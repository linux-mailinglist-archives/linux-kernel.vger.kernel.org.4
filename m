Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85DC6B744A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 11:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjCMKjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 06:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjCMKjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 06:39:05 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD94DBC9;
        Mon, 13 Mar 2023 03:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=ysjw2zASi2TN/sEh3AgZLlcqDNtBqR4JUmN2mmSl7tQ=; b=HAvudky9j4TSTsClvuImR7P2k7
        A/lZZbwJGo0VKLL3hAtlxVyb1Uc3SGhVWF6VwjlndJPbdYYBsYkx76x8ConLISCR3PRmGH1fdaDzN
        lM9Qa//ivj4ryY7R5zY4B68uiVEDSs4vGv051dlcBGhfm1/SiKWbZHmtJ2fIBGYWu/uFP89KU3307
        qhmhHuF+vkvy5oM+aM8X4JuNJ8UHTAxxc7H/lCxaR+GccVqlmDOjKerDa8oUHgTseMntK3x0xME/0
        cINmLJT+XASddwh6YFhdo+DP5NbvFjLi4ljzU/VfPDy1lRqOcdZI3vpQt9usDCbttu4OSmQ7sJt6K
        XCWS30/g==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbfVt-005BYJ-Tc; Mon, 13 Mar 2023 10:34:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     colin.i.king@gmail.com, patches@lists.linux.dev,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        pmladek@suse.com, david@redhat.com, petr.pavlu@suse.com,
        prarit@redhat.com
Cc:     christophe.leroy@csgroup.eu, song@kernel.org, mcgrof@kernel.org
Subject: [PATCH] stress-module: stress finit_module() and delete_module()
Date:   Mon, 13 Mar 2023 03:34:38 -0700
Message-Id: <20230313103439.1235909-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
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

This is a patch for stress-ng to help stress module races with
finit_module() and system memory pressure when userspace is being
raced to see if a module is present and it fails to see the module
already loaded, so stresses the system memory.

We can later add support to make the default module be saught after
using uname and the /lib/modules/$(uname -r)/kernel/lib/$hello.ko.

But this should be enough to get us playing ball.

 Makefile         |   1 +
 core-shim.c      |  35 ++++++++++
 core-stressors.h |   1 +
 stress-module.c  | 168 +++++++++++++++++++++++++++++++++++++++++++++++
 stress-ng.1      |  27 ++++++++
 stress-ng.c      |   6 ++
 stress-ng.h      |   9 +++
 syscalls.txt     |   2 +-
 8 files changed, 248 insertions(+), 1 deletion(-)
 create mode 100644 stress-module.c

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
diff --git a/core-shim.c b/core-shim.c
index 4ef97a1e..262883e8 100644
--- a/core-shim.c
+++ b/core-shim.c
@@ -95,6 +95,41 @@ UNEXPECTED
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
+#else
+	if (__NR_finit_module == -1) {
+		errno = ENOSYS;
+		return -1;
+	}
+
+	return syscall(__NR_finit_module, fd, uargs, flags);
+#endif
+}
+
+int shim_delete_module(const char *name, unsigned int flags)
+{
+#ifdef HAVE_DELETE_MODULE
+	return delete_module(name, flags);
+#else
+	return syscall(__NR_delete_module, name, flags);
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
index 00000000..f9cab300
--- /dev/null
+++ b/stress-module.c
@@ -0,0 +1,168 @@
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
+# define MODULE_INIT_IGNORE_MODVERSIONS 1
+#endif
+
+#ifndef MODULE_INIT_IGNORE_VERMAGIC
+# define MODULE_INIT_IGNORE_VERMAGIC 2
+#endif
+
+static const stress_help_t help[] = {
+	{ NULL,	"module N",	    "start N workers performing module requests" },
+	{ NULL,	"module-path F",    "use the specified module name F to load." },
+	{ NULL,	"module-unload",    "unload the module after module load" },
+	{ NULL,	"module-nomodver",  "ignore symbol version hashes" },
+	{ NULL,	"module-novermag",  "ignore kernel version magic" },
+	{ NULL,	"module-ops N",     "stop after N module bogo operations" },
+	{ NULL,	NULL,		NULL }
+};
+
+static int stress_set_module_unload(const char *opt)
+{
+	return stress_set_setting_true("module-unload", opt);
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
+	int fd;
+	bool module_unload = false;
+	bool ignore_vermagic = false;
+	bool ignore_modversions = false;
+	char *module_path = NULL;
+	char *module_name;
+	char *default_module = "hello";
+	const char *finit_args1 = "";
+	unsigned int kernel_flags = 0;
+	const pid_t mypid = getpid();
+	struct stat statbuf;
+
+	(void)stress_get_setting("module-path", &module_path);
+	(void)stress_get_setting("module-novermag", &ignore_vermagic);
+	(void)stress_get_setting("module-nomodver", &ignore_modversions);
+	(void)stress_get_setting("module-unload", &module_unload);
+
+	if (ignore_vermagic)
+		kernel_flags |= MODULE_INIT_IGNORE_VERMAGIC;
+	if (ignore_modversions)
+		kernel_flags |= MODULE_INIT_IGNORE_MODVERSIONS;
+
+	if (!module_path)
+		module_path = default_module;
+
+	if (stat(module_path, &statbuf) < 0)
+		return EXIT_FAILURE;
+	if (!S_ISREG(statbuf.st_mode))
+		return EXIT_FAILURE;
+
+	module_name = basename(module_path);
+
+	stress_set_proc_state(args->name, STRESS_STATE_RUN);
+
+	do {
+		int ret;
+
+		if (!keep_stressing(args)) {
+			if (mypid > 1)
+				(void)kill(mypid, SIGKILL);
+			goto out;
+		}
+
+		fd = open(module_path, O_RDONLY|O_CLOEXEC);
+
+		if (fd < 0) {
+			/* Check if we hit the open file limit */
+			if ((errno == EMFILE) || (errno == ENFILE)) {
+				if (mypid > 1)
+					(void)kill(mypid, SIGKILL);
+				goto out;
+			}
+			/* Ignore other errors */
+			continue;
+		}
+
+		if (module_unload)
+			shim_delete_module(module_name, 0);
+		ret = shim_finit_module(fd, finit_args1, kernel_flags);
+		if (ret == 0) {
+			if (module_unload)
+				shim_delete_module(module_name, 0);
+		}
+		(void)close(fd);
+
+out:
+	} while (keep_stressing(args));
+
+	stress_set_proc_state(args->name, STRESS_STATE_DEINIT);
+
+	if (mypid > 1) {
+		int status;
+
+		(void)kill(mypid, SIGKILL);
+		(void)waitpid(mypid, &status, 0);
+	}
+
+	return EXIT_SUCCESS;
+}
+
+static const stress_opt_set_func_t opt_set_funcs[] = {
+	{ OPT_module_path,	stress_set_module_path },
+	{ OPT_module_nomodver,	stress_set_module_nomodver },
+	{ OPT_module_novermag,	stress_set_module_novermag },
+	{ OPT_module_unload,	stress_set_module_unload },
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
index 034d7440..1fe65011 100644
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
+	{ "module-unload",	0,	0,	OPT_module_unload},
 	{ "mprotect",		1,	0,	OPT_mprotect },
 	{ "mprotect-ops",	1,	0,	OPT_mprotect_ops },
 	{ "mq",			1,	0,	OPT_mq },
diff --git a/stress-ng.h b/stress-ng.h
index c93654ac..be89cdba 100644
--- a/stress-ng.h
+++ b/stress-ng.h
@@ -1614,6 +1614,13 @@ typedef enum {
 	OPT_mmapmany,
 	OPT_mmapmany_ops,
 
+	OPT_module,
+	OPT_module_path,
+	OPT_module_nomodver,
+	OPT_module_novermag,
+	OPT_module_unload,
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
-- 
2.39.2

