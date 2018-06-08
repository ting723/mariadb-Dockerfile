# 底层为centos
FROM centos
MAINTAINER zly 
# 更新yum源及安装mariadb
RUN mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup \
&& curl -o /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo \
&& yum clean all && yum makecache && yum update -y \
&& yum install mariadb-server mariadb-client -y
# 设置相关环境变量
ENV MARIADB_USER root
ENV MARIADB_PASS yourpwd
ENV LC_ALL en_US.UTF-8
# 暴露端口
EXPOSE 3306
# 设置挂载点
# 增加mysql启动
ADD db_init.sh /root/db_init.sh
RUN chmod 775 /root/db_init.sh && /root/db_init.sh
#VOLUME /var/lib/mysql
# 设置容器启动时，需执行的脚本
CMD ["mysqld_safe"]
