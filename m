Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85556BF6C8
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Mar 2023 01:08:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbjCRAIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 20:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCRAIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 20:08:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DDED34F66;
        Fri, 17 Mar 2023 17:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=m46Z26rJ5uG91cgPcLNJsI0C4/7Ou8RukPnekgpY+mg=; b=IUCG75sDpxRMDNIP3aQmloHG5f
        QJYhnZFZvDc5OCws95zTwQdhXzyynmb9H+9kjswL8SKYw5dSxUe3lcezTS8ql6zxlutU9dLn/VcJb
        TaBB2DdyKRWsTrIiPmR32iPBSBaQnYdku9elDc+nW8ILxatGBOyBx19HMLvMDXYnQgfK4Fs/A+xW5
        QZuOADYqav77jHPEN8lfPo+LCZWNPa8toQ8T3BP56zAJ4yZJ2I4Ac5AqI6ANQdLodq7g+K1WQAhuU
        NaDtnPFfjyAvQVZmXXrwIAOVcXTqqRRH2r2AKn11zJyfENITBn3sqbh3fW0txiWdL3FDe0Ymqs4zE
        3oKG5SIg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pdK7E-003kgg-1X;
        Sat, 18 Mar 2023 00:08:08 +0000
Date:   Fri, 17 Mar 2023 17:08:08 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Cc:     patches@lists.linux.dev, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, pmladek@suse.com, david@redhat.com,
        petr.pavlu@suse.com, prarit@redhat.com,
        christophe.leroy@csgroup.eu, song@kernel.org
Subject: [PATCH v2] stress-module: stress finit_module() and delete_module()
Message-ID: <ZBUA6E3kYh0Xuu/c@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
the kernel from too many requests at the same time.

The userspace modprobe call will also prevent calls if the same module
exists already.

This stress-ng modules stressor is designed to help stress test the
finit_module() system call even if the module is already loaded, letting
us tests things which are hard to reproduce.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

On this v2:

  o fixed most of the things pointed out
  o missing: the default module path, we shoudl build it for you, and
    we should allow uesrse to be lazy and not specify the full path too

I'm not sure yet why we don't see the module delete work, I guess
because it's refcnt is still not 0 and so the unload probably won't
help at all unless we have a loop just dedicated to that. But its
odd as we just load and unlaod, hrm. Not sure, Lucas?

 Makefile                  |   1 +
 Makefile.config           |  15 +++-
 core-shim.c               |  34 +++++++
 core-stressors.h          |   1 +
 stress-module.c           | 183 ++++++++++++++++++++++++++++++++++++++
 stress-ng.1               |  27 ++++++
 stress-ng.c               |   6 ++
 stress-ng.h               |   9 ++
 syscalls.txt              |   2 +-
 test/test-delete-module.c |  24 +++++
 test/test-finit-module.c  |  31 +++++++
 11 files changed, 329 insertions(+), 4 deletions(-)
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
index 00000000..5e7a9a78
--- /dev/null
+++ b/stress-module.c
@@ -0,0 +1,183 @@
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
+#ifndef MODULE_INIT_IGNORE_MODVERSIONS
+#define MODULE_INIT_IGNORE_MODVERSIONS 1
+#endif
+
+#ifndef MODULE_INIT_IGNORE_VERMAGIC
+#define MODULE_INIT_IGNORE_VERMAGIC 2
+#endif
+
+static const stress_help_t help[] = {
+	{ NULL,	"module N",	    "start N workers performing module requests" },
+	{ NULL,	"module-path F",    "use the specified module name F to load." },
+	{ NULL,	"module-nounload",  "skip unload of the module after module load" },
+	{ NULL,	"module-nomodver",  "ignore symbol version hashes" },
+	{ NULL,	"module-novermag",  "ignore kernel version magic" },
+	{ NULL,	"module-ops N",     "stop after N module bogo operations" },
+	{ NULL,	NULL,		NULL }
+};
+
+static int stress_set_module_nounload(const char *opt)
+{
+	return stress_set_setting_true("module-nounload", opt);
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
+static int stress_set_module_path(const char *name)
+{
+	return stress_set_setting("module-path", TYPE_ID_STR, name);
+}
+
+/*
+ *  stress_module
+ *	stress by heavy module ops
+ */
+static int stress_module(const stress_args_t *args)
+{
+	bool module_nounload = false;
+	bool ignore_vermagic = false;
+	bool ignore_modversions = false;
+	char *module_path = NULL;
+	char *module_name;
+	char *default_module = "hello";
+	const char *finit_args1 = "";
+	unsigned int kernel_flags = 0;
+	struct stat statbuf;
+	int ret = EXIT_SUCCESS;
+
+	(void)stress_get_setting("module-path", &module_path);
+	(void)stress_get_setting("module-novermag", &ignore_vermagic);
+	(void)stress_get_setting("module-nomodver", &ignore_modversions);
+	(void)stress_get_setting("module-nounload", &module_nounload);
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
+	if (!module_path)
+		module_path = default_module;
+
+	if (stat(module_path, &statbuf) < 0) {
+		if (args->instance == 0) {
+			if (module_path != default_module)
+				pr_inf_skip("%s: could not get stat() on the module you specified '%s', skipping stressor\n",
+					    args->name, module_path);
+			else
+				pr_inf_skip("%s: could not get stat() on the default module '%s', skipping stressor (XXX implement utsname path completion)\n",
+					    args->name, module_path);
+		}
+		return EXIT_NO_RESOURCE;
+	}
+	if (!S_ISREG(statbuf.st_mode)) {
+		pr_inf_skip("%s: module passed is not a regular file '%s', skipping stressor\n",
+			    args->name, module_path);
+		return EXIT_NO_RESOURCE;
+	}
+
+	module_name = basename(module_path);
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
+		fd = open(module_path, O_RDONLY | O_CLOEXEC);
+
+		if (fd < 0) {
+			/* Check if we hit the open file limit */
+			if ((errno == EMFILE) || (errno == ENFILE)) {
+				ret = EXIT_NO_RESOURCE;
+				goto out;
+			}
+			/* Ignore other errors */
+			continue;
+		}
+
+		ret = shim_finit_module(fd, finit_args1, kernel_flags);
+		if (ret == 0) {
+			if (!module_nounload)
+				shim_delete_module(module_name, 0);
+		}
+		(void)close(fd);
+
+	} while (keep_stressing(args));
+
+out:
+	stress_set_proc_state(args->name, STRESS_STATE_DEINIT);
+
+	return ret;
+}
+
+static const stress_opt_set_func_t opt_set_funcs[] = {
+	{ OPT_module_path,	stress_set_module_path },
+	{ OPT_module_nomodver,	stress_set_module_nomodver },
+	{ OPT_module_novermag,	stress_set_module_novermag },
+	{ OPT_module_nounload,	stress_set_module_nounload },
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
index 959649a8..24dc5783 100644
--- a/stress-ng.1
+++ b/stress-ng.1
@@ -3402,6 +3402,33 @@ the maximum allowed mappings or a maximum of 262144 mappings are made.
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
+.B \-\-module\-path PATH
+PATH of the module to use. You must use a full path.
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
 .B \-\-mprotect N
 start N workers that exercise changing page protection settings and access
 memory after each change. 8 processes per worker contend with each other
diff --git a/stress-ng.c b/stress-ng.c
index 034d7440..ae23ab04 100644
--- a/stress-ng.c
+++ b/stress-ng.c
@@ -686,6 +686,12 @@ static const struct option long_options[] = {
 	{ "mmaphuge-ops",	1,	0,	OPT_mmaphuge_ops },
 	{ "mmapmany",		1,	0,	OPT_mmapmany },
 	{ "mmapmany-ops",	1,	0,	OPT_mmapmany_ops },
+	{ "module",		1,	0,	OPT_module},
+	{ "module-ops",		1,	0,	OPT_module_ops },
+	{ "module-path",	1,	0,	OPT_module_path},
+	{ "module-nomodver",	1,	0,	OPT_module_nomodver},
+	{ "module-novermag",	1,	0,	OPT_module_novermag,},
+	{ "module-nounload",	0,	0,	OPT_module_nounload},
 	{ "mprotect",		1,	0,	OPT_mprotect },
 	{ "mprotect-ops",	1,	0,	OPT_mprotect_ops },
 	{ "mq",			1,	0,	OPT_mq },
diff --git a/stress-ng.h b/stress-ng.h
index c93654ac..83756d62 100644
--- a/stress-ng.h
+++ b/stress-ng.h
@@ -1614,6 +1614,13 @@ typedef enum {
 	OPT_mmapmany,
 	OPT_mmapmany_ops,
 
+	OPT_module,
+	OPT_module_path,
+	OPT_module_nomodver,
+	OPT_module_novermag,
+	OPT_module_nounload,
+	OPT_module_ops,
+
 	OPT_mprotect,
 	OPT_mprotect_ops,
 
@@ -2914,6 +2921,7 @@ extern int shim_clone3(struct shim_clone_args *cl_args, size_t size);
 extern int shim_close_range(unsigned int fd, unsigned int max_fd, unsigned int flags);
 extern ssize_t shim_copy_file_range(int fd_in, shim_loff_t *off_in,
 	int fd_out, shim_loff_t *off_out, size_t len, unsigned int flags);
+extern int shim_delete_module(const char *name, unsigned int flags);
 extern int shim_dup3(int oldfd, int newfd, int flags);
 extern int shim_execveat(int dir_fd, const char *pathname, char *const argv[],
 	char *const envp[], int flags);
@@ -2921,6 +2929,7 @@ extern void shim_exit_group(int status);
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

