Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BB786C40F7
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 04:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjCVDYM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 23:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCVDX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 23:23:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F01564C6D0;
        Tue, 21 Mar 2023 20:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=+jxQm4a2lYSbF7DT6xlAo7j/87XE/W5CISYsvH1fPCI=; b=1R022ZrnkvcJODIEvqRyR1KU8t
        +HJLPnd9st8COEjmq+NyBViIjZ3U9HHkP4Kb4v4qD3HUAhX2lSdbuormoc25JBnEMxp1Z/CAC2Wrq
        AvyrnY0XXT8Htom28nQkUKz9lLYc9ZBXqYr0T+kJnXalhkKodZyDrdECUNO2zoFHk4r3j7juBJkFP
        t9Mi6WJkpzRaJijfV3VOsIH90C+kh7qEOBtd0QAb4x2NOJ2dWxHiV64ySnly9rG2UC2hi4XZ6FqZd
        c0WHexJ+JiXcKdnEIvqELiadGuc9wwsrdPQ7JGGRhHIxy4yIMOiu55Wvs/jowlP8BiwS1So5KC8dI
        jfBm277w==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pep4o-00EQez-36;
        Wed, 22 Mar 2023 03:23:50 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     colin.i.king@gmail.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, dave@stgolabs.net,
        a.manzanares@samsung.com, fan.ni@samsung.com,
        vincent.fu@samsung.com, mcgrof@kernel.org
Subject: [PATCH v3] stress-module: stress finit_module() and delete_module()
Date:   Tue, 21 Mar 2023 20:23:50 -0700
Message-Id: <20230322032350.3439056-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_FILL_THIS_FORM_SHORT,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are different ways to test loading modules:

  * modprobe calls
  * kernel module autoloader

To stress tests modprobe we can simply run modprobe in a loop. To stress
test the kernel module autoloader we can stress tests using the upstream
kernel tools/testing/selftests/kmod/kmod.sh. This ends up calling
modprobe in the end, and it has its own caps built-in to self protect
the kernel from too many requests at the same time. Today we cap that
at 50 max concurrent threads at a time.

The userspace modprobe call will also prevent calls if the same module
exists already.

You figured that might be enough to stop usersapce or even the kernel
from doing stupid things, but its not! See the issues reported by
David Hildenbrand on > 400 CPUs with KASAN enabled we get a shortage
of vmap space.

Although I have patches which are in the works which seem to fix this
issue it is pretty hard to reproduce an environment that has 400 CPUs
to stress test what that is like. And although current debugging seems
to indicate that the issue is actually the kernel ACPI driver uses
aliases and each CPU trying to load the same drivers; and although we
have patches in the pipeline to hopefully fix that too [2] -- we still
need a way to stress the hell out of finit_module() because clearly
evidence is showing we could blame either userspace *or* even kernel
for doing stupid things.

This stress-ng modules stressor is designed to help stress test the
finit_module() system call even if the module is already loaded, letting
us tests things which are hard to reproduce as well, things which
otherwise modprobe would pick up on small systems. We allow two methods
to stress test, one with a shared file descriptor, and another where we
call open prior to each finit_module().

Example uses:

sudo ./stress-ng --module 1 --module-name xfs
sudo ./stress-ng --module 1 --module-name xfs --module-sharedfd

The /lib/modules/$(uname -r)/modules.dep file is looked for and
once we find a module which matches your name we use that path.
Since we're not trying to replicate modprobe we don't load any
dependencies for you. Be sure to have them loaded before running
your stress tests.

We don't use libkmod as we don't want to bloat stress-ng, and because
we can provide a simpler parser to get our target module *once*.

[0] https://lore.kernel.org/all/20221013180518.217405-1-david@redhat.com/T/#u
[1] https://lkml.kernel.org/r/bb6e15e0-2831-6352-82c8-92648a29fb0b@redhat.com
[2] https://lkml.kernel.org/r/20230316151036.10181-1-petr.pavlu@suse.com

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 Makefile                  |   1 +
 Makefile.config           |  15 +-
 core-shim.c               |  34 +++
 core-stressors.h          |   1 +
 stress-module.c           | 444 ++++++++++++++++++++++++++++++++++++++
 stress-ng.1               |  37 ++++
 stress-ng.c               |   7 +
 stress-ng.h               |  10 +
 syscalls.txt              |   2 +-
 test/test-delete-module.c |  24 +++
 test/test-finit-module.c  |  31 +++
 11 files changed, 602 insertions(+), 4 deletions(-)
 create mode 100644 stress-module.c
 create mode 100644 test/test-delete-module.c
 create mode 100644 test/test-finit-module.c

diff --git a/Makefile b/Makefile
index be46f656..f4ac7b63 100644
--- a/Makefile
+++ b/Makefile
@@ -316,6 +316,7 @@ STRESS_SRC = \
 	stress-mmapfork.c \
 	stress-mmaphuge.c \
 	stress-mmapmany.c \
+	stress-module.c \
 	stress-mprotect.c \
 	stress-mq.c \
 	stress-mremap.c \
diff --git a/Makefile.config b/Makefile.config
index 40fbe0f6..023d93b0 100644
--- a/Makefile.config
+++ b/Makefile.config
@@ -339,7 +339,7 @@ headers: \
 	LINUX_GENETLINK_H LINUX_HDREG_H LINUX_HPET_H LINUX_IF_ALG_H \
 	LINUX_IF_PACKET_H LINUX_IF_TUN_H LINUX_IO_URING_H LINUX_KD_H \
 	LINUX_KVM_H LINUX_LANDLOCK_H LINUX_LOOP_H LINUX_MAGIC_H LINUX_MEDIA_H \
-	LINUX_MEMBARRIER_H LINUX_MEMPOLICY_H LINUX_NETLINK_H \
+	LINUX_MEMBARRIER_H LINUX_MEMPOLICY_H LINUX_MODULE_H LINUX_NETLINK_H \
 	LINUX_OPENAT2_H LINUX_PCI_H LINUX_PERF_EVENT_H LINUX_POSIX_TYPES_H \
 	LINUX_PPDEV_H LINUX_PTP_CLOCK_H LINUX_RANDOM_H LINUX_RSEQ_H \
 	LINUX_RTC_H LINUX_RTNETLINK_H LINUX_SECCOMP_H LINUX_SERIAL_H \
@@ -544,6 +544,9 @@ LINUX_MEMBARRIER_H:
 LINUX_MEMPOLICY_H:
 	$(call check_header,linux/mempolicy.h,HAVE_LINUX_MEMPOLICY_H)
 
+LINUX_MODULE_H:
+	$(call check_header,linux/module.h,HAVE_LINUX_MODULE_H)
+
 LINUX_NETLINK_H:
 	$(call check_header,linux/netlink.h,HAVE_LINUX_NETLINK_H)
 
@@ -1513,11 +1516,11 @@ functions: \
 	INTRINSIC_RORB INTRINSIC_RORD INTRINSIC_RORW INTRINSIC_RORQ \
 	CABSL CACHEFLUSH CCOS CCOSF CCOSL CHROOT CIMAG CIMAGF CIMAGL CLEARENV CLOCK_ADJTIME \
 	CLOCK_GETRES CLOCK_GETTIME CLOCK_NANOSLEEP CLOCK_SETTIME CLONE COPY_FILE_RANGE \
-	COSHL COSL CPOW CREAL CREALF CREALL CRYPT_R CSIN CSINF CSINL DUP3 DRAND48 \
+	COSHL COSL CPOW CREAL CREALF CREALL CRYPT_R CSIN CSINF CSINL DUP3 DRAND48 DELETE_MODULE \
 	ENDMNTENT ENDPWENT EPOLL_CREATE \
 	EPOLL_CREATE1 EVENTFD EXECUTABLE_START EXECVEAT EXPL FACCESSAT \
 	FACCESSAT2 FALLOCATE FANOTIFY FCHMODAT FCHOWNAT FDATASYNC \
-	FGETXATTR FLISTXATTR FLOCK FREMOVEXATTR FSETXATTR FSTATAT FSYNC FUTIMENS \
+	FGETXATTR FINIT_MODULE FLISTXATTR FLOCK FREMOVEXATTR FSETXATTR FSTATAT FSYNC FUTIMENS \
 	FUTIMES FUTIMESAT GETAUXVAL GETCPU GETDOMAINNAME GETDTABLESIZE GETENTROPY \
 	GETEXECNAME GETHOSTID GETHOSTNAME GETITIMER GETLOADAVG GETMNTENT GETMNTINFO \
 	GETPAGESIZE GETPGID GETPGRP GETPRIORITY GETPWENT GETRANDOM GETRESGID \
@@ -1950,6 +1953,9 @@ CSINL:
 DRAND48:
 	$(call check,test-drand48,HAVE_DRAND48,drand48)
 
+DELETE_MODULE:
+	$(call check,test-delete-module,HAVE_DELETE_MODULE,delete_module)
+
 DUP3:
 	$(call check,test-dup3,HAVE_DUP3,dup3)
 
@@ -2001,6 +2007,9 @@ FDATASYNC:
 FGETXATTR:
 	$(call check,test-fgetxattr,HAVE_FGETXATTR,fgetxattr)
 
+FINIT_MODULE:
+	$(call check,test-finit-module,HAVE_FINIT_MODULE,finit_module)
+
 FLISTXATTR:
 	$(call check,test-flistxattr,HAVE_FLISTXATTR,flistxattr)
 
diff --git a/core-shim.c b/core-shim.c
index 4ef97a1e..6fb459a5 100644
--- a/core-shim.c
+++ b/core-shim.c
@@ -95,6 +95,40 @@ UNEXPECTED
 #define shim_rusage_who_t	int
 #endif
 
+#ifdef HAVE_LINUX_MODULE_H
+#include <linux/module.h>
+#endif
+
+#ifndef HAVE_FINIT_MODULE
+#include <errno.h>
+#endif
+
+#ifndef __NR_finit_module
+# define __NR_finit_module -1
+#endif
+
+int shim_finit_module(int fd, const char *uargs, int flags)
+{
+#ifdef HAVE_FINIT_MODULE
+	return finit_module(fd, uargs, flags);
+#elif defined(__NR_finit_module)
+	return syscall(__NR_finit_module, fd, uargs, flags);
+#else
+	return shim_enosys(0, fd, uargs, flags);
+#endif
+}
+
+int shim_delete_module(const char *name, unsigned int flags)
+{
+#ifdef HAVE_DELETE_MODULE
+	return delete_module(name, flags);
+#elif defined(__NR_delete_module)
+	return syscall(__NR_delete_module, name, flags);
+#else
+	return shim_enosys(0, name, flags);
+#endif
+}
+
 #if defined(__sun__)
 #if defined(HAVE_GETDOMAINNAME)
 extern int getdomainname(char *name, size_t len);
diff --git a/core-stressors.h b/core-stressors.h
index fe5ac70a..d22ef7f2 100644
--- a/core-stressors.h
+++ b/core-stressors.h
@@ -166,6 +166,7 @@
 	MACRO(mmapfork)		\
 	MACRO(mmaphuge)		\
 	MACRO(mmapmany)		\
+	MACRO(module)		\
 	MACRO(mprotect)		\
 	MACRO(mq)		\
 	MACRO(mremap)		\
diff --git a/stress-module.c b/stress-module.c
new file mode 100644
index 00000000..cee581bd
--- /dev/null
+++ b/stress-module.c
@@ -0,0 +1,444 @@
+/*
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ */
+#include "stress-ng.h"
+
+#if defined(HAVE_LINUX_MODULE_H)
+#include <linux/module.h>
+#else
+UNEXPECTED
+#endif
+
+#if defined(HAVE_LIBGEN_H)
+#include <libgen.h>
+#endif
+
+#if defined(HAVE_SYS_UTSNAME_H)
+#include <sys/utsname.h>
+#else
+UNEXPECTED
+#endif
+
+#ifndef MODULE_INIT_IGNORE_MODVERSIONS
+#define MODULE_INIT_IGNORE_MODVERSIONS 1
+#endif
+
+#ifndef MODULE_INIT_IGNORE_VERMAGIC
+#define MODULE_INIT_IGNORE_VERMAGIC 2
+#endif
+
+#ifndef PATH_MAX
+#define PATH_MAX 1024
+#endif
+
+static const stress_help_t help[] = {
+	{ NULL,	"module N",	    "start N workers performing module requests" },
+	{ NULL,	"module-name F",    "use the specified module name F to load." },
+	{ NULL,	"module-nounload",  "skip unload of the module after module load" },
+	{ NULL,	"module-sharedfd",  "use a shared file descriptor for all loads" },
+	{ NULL,	"module-nomodver",  "ignore symbol version hashes" },
+	{ NULL,	"module-novermag",  "ignore kernel version magic" },
+	{ NULL,	"module-ops N",     "stop after N module bogo operations" },
+	{ NULL,	NULL,		NULL }
+};
+
+enum parse_line_type {
+	PARSE_COMMENT = 0,
+	PARSE_EMPTY,
+	PARSE_DEPMOD_MODULE,
+	PARSE_INVALID,
+	PARSE_EOF,
+};
+
+/* Taken from kmod.git to keep bug compatible */
+static const char *dirname_default_prefix = "/lib/modules";
+static bool module_path_found = false;
+static char global_module_path[PATH_MAX];
+static int global_module_fd;
+
+static int stress_set_module_nounload(const char *opt)
+{
+	return stress_set_setting_true("module-nounload", opt);
+}
+
+static int stress_set_module_sharedfd(const char *opt)
+{
+	return stress_set_setting_true("module-sharedfd", opt);
+}
+
+static int stress_set_module_nomodver(const char *opt)
+{
+	return stress_set_setting_true("module-nomodver", opt);
+}
+
+static int stress_set_module_novermag(const char *opt)
+{
+	return stress_set_setting_true("module-novermag", opt);
+}
+
+static int stress_set_module_name(const char *name)
+{
+	return stress_set_setting("module-name", TYPE_ID_STR, name);
+}
+
+static bool isempty(const char *line, ssize_t linelen)
+{
+	ssize_t i = 0;
+	char p;
+
+	while (i < linelen) {
+		p = line[i++];
+
+		/* tab or space */
+		if (!isblank(p))
+			return false;
+	}
+
+	return true;
+}
+
+static bool iscomment(const char *line, ssize_t	linelen)
+{
+	ssize_t i = 0;
+	char p;
+
+	while (i != linelen) {
+		p = line[i];
+		i++;
+
+		/* tab or space */
+		if (isblank(p))
+			continue;
+
+		if (p == '#')
+			return true;
+
+		return false;
+	}
+
+	return false;
+}
+
+static enum parse_line_type parse_get_line_type(const char *line,
+						ssize_t linelen,
+						char *module)
+{
+	int ret;
+
+	if (isempty(line, linelen))
+		return PARSE_EMPTY;
+
+	if (iscomment(line, linelen))
+		return PARSE_COMMENT;
+
+	/* should be a "kernel/foo/path.ko: .* */
+	ret = sscanf(line, "%[^:]:", module);
+	if (ret == 1) {
+		return PARSE_DEPMOD_MODULE;
+	}
+
+	if (ret == EOF)
+		return PARSE_EOF;
+
+	errno = EINVAL;
+	return PARSE_INVALID;
+}
+
+/*
+ * We can surely port over some of the kmod index file stuff, but
+ * that's pretty complex. Instead we just write our own simple
+ * modules.dep parser.
+ *
+ * This reads /lib/modules/$(uname -r)/modules.dep for the module name
+ * to get the module path name.
+ *
+ * No dependencies are loaded, we're not stressing modprobe, we're
+ * stressing finit_module(). You must have your dependencies
+ * loaded.
+ *
+ * On success returns 0 and sets module_path to the path of the
+ * module you should load with finit_module.
+ */
+int get_modpath_name(const char *name, char *module_path)
+{
+#if defined(HAVE_UNAME) &&      \
+    defined(HAVE_SYS_UTSNAME_H)
+	struct utsname u;
+	char depmod[PATH_MAX];
+	FILE *fp;
+	char *line = NULL;
+	ssize_t linelen;
+	size_t len = 0, lineno = 0;
+	char module[PATH_MAX]; /* used by our parser */
+	char module_path_truncated[PATH_MAX]; /* truncated path */
+	char module_path_basename[PATH_MAX];
+	char module_short[PATH_MAX];
+	int ret = -1;
+	enum parse_line_type parse_type;
+
+        if (uname(&u) < 0)
+		return -1;
+	snprintf(depmod, sizeof(depmod), "%s/%s/modules.dep",
+		 dirname_default_prefix, u.release);
+
+	fp = fopen(depmod, "r");
+	if (!fp)
+		goto out_close;
+	while ((linelen = getline(&line, &len, fp)) != -1) {
+		lineno++;
+		parse_type = parse_get_line_type(line, linelen, module);
+		switch (parse_type) {
+		case PARSE_EMPTY:
+		case PARSE_COMMENT:
+			/* Nothing tag to free for these */
+			break;
+		case PARSE_EOF:
+			goto out_close;
+		case PARSE_DEPMOD_MODULE:
+			char *module_pathp;
+			char *start_postfix;
+			char *modulenamep;
+			/* truncates the "kernel/" part */
+			module_pathp = strchr(module, '/');
+			if (module_pathp == NULL) {
+				free(line);
+				line = NULL;
+				break;
+			}
+
+			memset(module_path_truncated, 0, PATH_MAX);
+			strncpy(module_path_truncated, module_pathp, PATH_MAX);
+
+			/* basename can modify the the original string */
+			modulenamep = basename(module_path_truncated);
+			memset(module_path_basename, 0, PATH_MAX);
+			strcpy(module_path_basename, modulenamep);
+
+			start_postfix = strchr(module_path_basename, '.');
+			if (start_postfix == NULL) {
+				free(line);
+				line = NULL;
+				break;
+			}
+			*start_postfix  = '\0';
+
+			memset(module_short, 0, PATH_MAX);
+			strncpy(module_short, module_path_basename, PATH_MAX);
+			if (strlen(name) != strlen (module_short)) {
+				free(line);
+				line = NULL;
+				break;
+			}
+			if (strncmp(name, module_short, strlen(name)) != 0) {
+				free(line);
+				line = NULL;
+				break;
+			}
+			//snprintf(module_path, strlen(module_path), "%s/%s/%s",
+			snprintf(module_path, PATH_MAX*2, "%s/%s/%s",
+				 dirname_default_prefix,
+				 u.release, module);
+			ret = 0;
+			goto out_close;
+		case PARSE_INVALID:
+			ret = -1;
+			fprintf(stderr, "Invalid line %s:%zu : %s\n", depmod, lineno, line);
+			goto out_close;
+		}
+
+		free(line);
+		line = NULL;
+	}
+
+out_close:
+	if (line)
+		free(line);
+	fclose(fp);
+	return ret;
+#else
+	return -1;
+#endif
+}
+
+
+/*
+ *  stress_module
+ *	stress by heavy module ops
+ */
+static int stress_module(const stress_args_t *args)
+{
+	bool module_nounload = false;
+	bool module_sharedfd = false;
+	bool ignore_vermagic = false;
+	bool ignore_modversions = false;
+	char *module_name_cli = NULL;
+	char module_path[PATH_MAX];
+	char *module_name;
+	char *default_module = "test_module";
+	const char *finit_args1 = "";
+	unsigned int kernel_flags = 0;
+	struct stat statbuf;
+	int ret = EXIT_SUCCESS;
+
+	(void)stress_get_setting("module-name", &module_name_cli);
+	(void)stress_get_setting("module-novermag", &ignore_vermagic);
+	(void)stress_get_setting("module-nomodver", &ignore_modversions);
+	(void)stress_get_setting("module-nounload", &module_nounload);
+	(void)stress_get_setting("module-sharedfd", &module_sharedfd);
+
+	if (geteuid() != 0) {
+		if (args->instance == 0)
+			pr_inf("%s: need root privilege to run "
+				"this stressor\n", args->name);
+		/* Not strictly a test failure */
+		return EXIT_SUCCESS;
+	}
+
+	if (ignore_vermagic)
+		kernel_flags |= MODULE_INIT_IGNORE_VERMAGIC;
+	if (ignore_modversions)
+		kernel_flags |= MODULE_INIT_IGNORE_MODVERSIONS;
+
+	if (module_name_cli)
+		module_name = module_name_cli;
+	else
+		module_name = default_module;
+
+	/*
+	 * We're not stressing the modules.dep --> module path lookup,
+	 * just the finit_module() calls and so only do the lookup once.
+	 */
+	if (args->instance != 0) {
+		if (!module_path_found)
+			return EXIT_SUCCESS;
+	} else {
+		ret = get_modpath_name(module_name, module_path);
+		if (ret != 0) {
+			if (module_name == default_module)
+				pr_inf_skip("%s: could not find a module path for the default test_module '%s', perhaps CONFIG_TEST_LKM is disabled in your kernel, skipping stressor\n",
+					    args->name, module_name);
+			else
+				pr_inf_skip("%s: could not find a module path for module you specified '%s', ensure it is enabld in your running kernel, skipping stressor\n",
+					    args->name, module_name);
+			return EXIT_NO_RESOURCE;
+		}
+		if (stat(module_path, &statbuf) < 0) {
+			if (args->instance == 0) {
+				if (module_path != default_module)
+					pr_inf_skip("%s: could not get stat() on the module you specified '%s', skipping stressor\n",
+						    args->name, module_path);
+				else
+					pr_inf_skip("%s: could not get stat() on the default module '%s', skipping stressor (XXX implement utsname path completion)\n",
+						    args->name, module_path);
+			}
+			return EXIT_NO_RESOURCE;
+		}
+		if (!S_ISREG(statbuf.st_mode)) {
+			pr_inf_skip("%s: module passed is not a regular file '%s', skipping stressor\n",
+				    args->name, module_path);
+			return EXIT_NO_RESOURCE;
+		}
+
+		memcpy(global_module_path, module_path, PATH_MAX);
+
+		if (module_sharedfd) {
+			global_module_fd = open(global_module_path, O_RDONLY | O_CLOEXEC);
+
+			if (global_module_fd < 0) {
+				/* Check if we hit the open file limit */
+				if ((errno == EMFILE) || (errno == ENFILE)) {
+					ret = EXIT_NO_RESOURCE;
+					goto out;
+				}
+				pr_inf_skip("%s: unexpected error while opening module file %s, skipping stressor\n",
+					    args->name, global_module_path);
+				ret = EXIT_NO_RESOURCE;
+				goto out;
+			}
+		}
+		module_path_found = true;
+	}
+
+	/*
+	 * Always unload the module unless the user asked to not do it.
+	 * As a sanity we try to unload it prior to loading it for
+	 * the first time.
+	 */
+	if (!module_nounload)
+		shim_delete_module(module_name, 0);
+
+	stress_set_proc_state(args->name, STRESS_STATE_RUN);
+
+	do {
+		int ret;
+		int fd;
+
+		if (!keep_stressing(args))
+			goto out;
+
+		if (module_sharedfd)
+			fd = global_module_fd;
+		else {
+			fd = open(global_module_path, O_RDONLY | O_CLOEXEC);
+
+			if (fd < 0) {
+				/* Check if we hit the open file limit */
+				if ((errno == EMFILE) || (errno == ENFILE)) {
+					ret = EXIT_NO_RESOURCE;
+					goto out;
+				}
+				/* Ignore other errors */
+				continue;
+			}
+		}
+
+		ret = shim_finit_module(fd, finit_args1, kernel_flags);
+		if (ret == 0) {
+			if (!module_nounload)
+				shim_delete_module(module_name, 0);
+		}
+
+		if (!module_sharedfd)
+			(void)close(fd);
+
+	} while (keep_stressing(args));
+
+out:
+	stress_set_proc_state(args->name, STRESS_STATE_DEINIT);
+
+	if (module_sharedfd && args->instance == 0)
+		close(global_module_fd);
+
+	return ret;
+}
+
+static const stress_opt_set_func_t opt_set_funcs[] = {
+	{ OPT_module_name,	stress_set_module_name},
+	{ OPT_module_nomodver,	stress_set_module_nomodver },
+	{ OPT_module_novermag,	stress_set_module_novermag },
+	{ OPT_module_nounload,	stress_set_module_nounload },
+	{ OPT_module_sharedfd,	stress_set_module_sharedfd},
+	{ 0,					NULL }
+};
+
+stressor_info_t stress_module_info = {
+	.stressor = stress_module,
+	.class = CLASS_OS | CLASS_FILESYSTEM | CLASS_MEMORY,
+	.opt_set_funcs = opt_set_funcs,
+	.help = help
+};
diff --git a/stress-ng.1 b/stress-ng.1
index 959649a8..3cbfe95f 100644
--- a/stress-ng.1
+++ b/stress-ng.1
@@ -3402,6 +3402,43 @@ the maximum allowed mappings or a maximum of 262144 mappings are made.
 .B \-\-mmapmany\-ops N
 stop after N mmapmany bogo operations
 .TP
+.B \-\-module N
+start N workers that will use finit_module() to load the module specified
+or the hello test module, if you've compiled that. There are different ways
+to test loading modules. Using modprobe calls in a loop, using the kernel
+kernel module autoloader, and this stress-ng module stressor. To stress tests
+modprobe we can simply run the userspace modprobe program in a loop. To stress
+test the kernel module autoloader we can stress tests using the upstream
+kernel tools/testing/selftests/kmod/kmod.sh. This ends up calling modprobe
+in the end, and it has its own caps built-in to self protect the kernel from
+too many requests at the same time. The userspace modprobe call will also
+prevent calls if the same module exists already. The stress-ng modules
+stressor is designed to help stress test the finit_module() system call
+even if the module is already loaded, letting us tests races which are
+otherwise hard to reproduce.
+.TP
+.B \-\-module\-name NAME
+NAME of the module to use. Examples: test_module, xfs, ext4. By default
+test_module is used so you must have CONFIG_TEST_LKM enabled on your kernel.
+Your module dependencies must be loaded prior to running these stressor
+tests, as this stresses running finit_module() not using modprobe.
+.TP
+.B \-\-module\-ignore\-modversions
+Ignore module modversions when using finit_module().
+.TP
+.B \-\-module\-ignore\-vermagic
+Ignore module versions when using finit_module().
+.TP
+.B \-\-module\-unload
+Unload the module right after loading it with finit_module().
+.TP
+.B \-\-module\-sharedfd
+Share the same file descriptor for for all jobs. If you don't want to
+stress test opening a new file descriptor per each finit_module() you want
+to test then enable this. This won't replicate most finit_module() uses
+as typically a shared file descriptor is not a goal by most system bringup
+software, although perhaps that should be an end goal.
+.TP
 .B \-\-mprotect N
 start N workers that exercise changing page protection settings and access
 memory after each change. 8 processes per worker contend with each other
diff --git a/stress-ng.c b/stress-ng.c
index 034d7440..9076149f 100644
--- a/stress-ng.c
+++ b/stress-ng.c
@@ -686,6 +686,13 @@ static const struct option long_options[] = {
 	{ "mmaphuge-ops",	1,	0,	OPT_mmaphuge_ops },
 	{ "mmapmany",		1,	0,	OPT_mmapmany },
 	{ "mmapmany-ops",	1,	0,	OPT_mmapmany_ops },
+	{ "module",		1,	0,	OPT_module},
+	{ "module-ops",		1,	0,	OPT_module_ops },
+	{ "module-name",	1,	0,	OPT_module_name},
+	{ "module-nomodver",	1,	0,	OPT_module_nomodver},
+	{ "module-novermag",	1,	0,	OPT_module_novermag,},
+	{ "module-nounload",	0,	0,	OPT_module_nounload},
+	{ "module-sharedfd",	0,	0,	OPT_module_sharedfd},
 	{ "mprotect",		1,	0,	OPT_mprotect },
 	{ "mprotect-ops",	1,	0,	OPT_mprotect_ops },
 	{ "mq",			1,	0,	OPT_mq },
diff --git a/stress-ng.h b/stress-ng.h
index c93654ac..93125ac7 100644
--- a/stress-ng.h
+++ b/stress-ng.h
@@ -1614,6 +1614,14 @@ typedef enum {
 	OPT_mmapmany,
 	OPT_mmapmany_ops,
 
+	OPT_module,
+	OPT_module_name,
+	OPT_module_nomodver,
+	OPT_module_novermag,
+	OPT_module_nounload,
+	OPT_module_ops,
+	OPT_module_sharedfd,
+
 	OPT_mprotect,
 	OPT_mprotect_ops,
 
@@ -2914,6 +2922,7 @@ extern int shim_clone3(struct shim_clone_args *cl_args, size_t size);
 extern int shim_close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern ssize_t shim_copy_file_range(int fd_in, shim_loff_t *off_in,
 	int fd_out, shim_loff_t *off_out, size_t len, unsigned int flags);
+extern int shim_delete_module(const char *name, unsigned int flags);
 extern int shim_dup3(int oldfd, int newfd, int flags);
 extern int shim_execveat(int dir_fd, const char *pathname, char *const argv[],
 	char *const envp[], int flags);
@@ -2921,6 +2930,7 @@ extern void shim_exit_group(int status);
 extern int shim_fallocate(int fd, int mode, off_t offset, off_t len);
 extern int shim_fdatasync(int fd);
 extern ssize_t shim_fgetxattr(int fd, const char *name, void *value, size_t size);
+extern int shim_finit_module(int fd, const char *uargs, int flags);
 extern ssize_t shim_flistxattr(int fd, char *list, size_t size);
 extern int shim_fsconfig(int fd, unsigned int cmd, const char *key,
 	const void *value, int aux);
diff --git a/syscalls.txt b/syscalls.txt
index 2952a46c..69471a9f 100644
--- a/syscalls.txt
+++ b/syscalls.txt
@@ -82,7 +82,7 @@ fchownat			close
 fcntl				open, lockf, fcntl
 fdatasync			hdd
 fgetxattr			xattr
-finit_module
+finit_module			module
 flistxattr			xattr
 flock				flock
 fork				fork
diff --git a/test/test-delete-module.c b/test/test-delete-module.c
new file mode 100644
index 00000000..37c383a8
--- /dev/null
+++ b/test/test-delete-module.c
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ */
+#include <linux/module.h>
+
+int main(void)
+{
+	return delete_module("hello", 0);
+}
diff --git a/test/test-finit-module.c b/test/test-finit-module.c
new file mode 100644
index 00000000..4da4267e
--- /dev/null
+++ b/test/test-finit-module.c
@@ -0,0 +1,31 @@
+/*
+ * Copyright (C) 2023 Luis Chamberlain <mcgrof@kernel.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version 2
+ * of the License, or (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
+ *
+ */
+#include <linux/module.h>
+
+int main(void)
+{
+	char *module = "hello";
+	int fd, ret;
+
+	fd = open(module, O_RDONLY | O_CLOEXEC);
+	if (fd > 0)
+		ret = finit_module(fd, finit_args1, kernel_flags);
+
+	return 0;
+}
-- 
2.39.2

