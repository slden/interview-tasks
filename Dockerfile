FROM ubuntu:24.04


RUN apt-get update && apt-get install -y openssh-server sudo

# Для подключения по SSH и для деплоя плейбуков Ansible будем использовать юзера ubuntu
RUN echo 'ubuntu:ubuntu' | chpasswd
# Добавляем пользователя ubuntu в группу sudo
RUN usermod -aG sudo ubuntu
# Создаем директорию для корректной работы sshd в контейнере
RUN mkdir -p /run/sshd
# Правим shhd.conf для возможности подключения по паролю
#RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config


EXPOSE 80 22

# Запустить SSH-сервер в фоновом режиме
CMD ["/usr/sbin/sshd", "-D"]
