Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BB3661FB1
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 09:09:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjAIIJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 03:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAIIJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 03:09:42 -0500
Received: from 1wt.eu (wtarreau.pck.nerim.net [62.212.114.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B62A0BA6
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 00:09:40 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 30989Pl9026641;
        Mon, 9 Jan 2023 09:09:25 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>,
        Willy Tarreau <w@1wt.eu>
Subject: [PATCH 1/4] nolibc: add support for s390
Date:   Mon,  9 Jan 2023 09:09:07 +0100
Message-Id: <20230109080910.26594-2-w@1wt.eu>
X-Mailer: git-send-email 2.17.5
In-Reply-To: <20230109080910.26594-1-w@1wt.eu>
References: <20230109080910.26594-1-w@1wt.eu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Schnelle <svens@linux.ibm.com>

Use arch-x86_64 as a template. Not really different, but
we have our own mmap syscall which takes a structure instead
of discrete arguments.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 tools/include/nolibc/arch-s390.h | 222 +++++++++++++++++++++++++++++++
 tools/include/nolibc/arch.h      |   2 +
 tools/include/nolibc/sys.h       |   2 +
 3 files changed, 226 insertions(+)
 create mode 100644 tools/include/nolibc/arch-s390.h

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
new file mode 100644
index 000000000000..76bc8fdaf922
--- /dev/null
+++ b/tools/include/nolibc/arch-s390.h
@@ -0,0 +1,222 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * s390 specific definitions for NOLIBC
+ */
+
+#ifndef _NOLIBC_ARCH_S390_H
+#define _NOLIBC_ARCH_S390_H
+#include <asm/unistd.h>
+
+/* O_* macros for fcntl/open are architecture-specific */
+#define O_RDONLY            0
+#define O_WRONLY            1
+#define O_RDWR              2
+#define O_CREAT          0x40
+#define O_EXCL           0x80
+#define O_NOCTTY        0x100
+#define O_TRUNC         0x200
+#define O_APPEND        0x400
+#define O_NONBLOCK      0x800
+#define O_DIRECTORY   0x10000
+
+/* The struct returned by the stat() syscall, equivalent to stat64(). The
+ * syscall returns 116 bytes and stops in the middle of __unused.
+ */
+
+struct sys_stat_struct {
+	unsigned long	st_dev;
+	unsigned long	st_ino;
+	unsigned long	st_nlink;
+	unsigned int	st_mode;
+	unsigned int	st_uid;
+	unsigned int	st_gid;
+	unsigned int	__pad1;
+	unsigned long	st_rdev;
+	unsigned long	st_size;
+	unsigned long	st_atime;
+	unsigned long	st_atime_nsec;
+	unsigned long	st_mtime;
+	unsigned long	st_mtime_nsec;
+	unsigned long	st_ctime;
+	unsigned long	st_ctime_nsec;
+	unsigned long	st_blksize;
+	long		st_blocks;
+	unsigned long	__unused[3];
+};
+
+/* Syscalls for s390:
+ *   - registers are 64-bit
+ *   - syscall number is passed in r1
+ *   - arguments are in r2-r7
+ *   - the system call is performed by calling the svc instruction
+ *   - syscall return value is in r2
+ *   - r1 and r2 are clobbered, others are preserved.
+ *
+ * Link s390 ABI: https://github.com/IBM/s390x-abi
+ *
+ */
+
+#define my_syscall0(num)						\
+({									\
+	register long _num __asm__ ("1") = (num);			\
+	register long _rc __asm__ ("2");				\
+									\
+	__asm__  volatile (						\
+		"svc 0\n"						\
+		: "=d"(_rc)						\
+		: "d"(_num)						\
+		: "memory", "cc"					\
+		);							\
+	_rc;								\
+})
+
+#define my_syscall1(num, arg1)						\
+({									\
+	register long _num __asm__ ("1") = (num);			\
+	register long _arg1 __asm__ ("2") = (long)(arg1);		\
+									\
+	__asm__  volatile (						\
+		"svc 0\n"						\
+		: "+d"(_arg1)						\
+		: "d"(_num)						\
+		: "memory", "cc"					\
+		);							\
+	_arg1;								\
+})
+
+#define my_syscall2(num, arg1, arg2)					\
+({									\
+	register long _num __asm__ ("1") = (num);			\
+	register long _arg1 __asm__ ("2") = (long)(arg1);		\
+	register long _arg2 __asm__ ("3") = (long)(arg2);		\
+									\
+	__asm__  volatile (						\
+		"svc 0\n"						\
+		: "+d"(_arg1)						\
+		: "d"(_arg2), "d"(_num)					\
+		: "memory", "cc"					\
+		);							\
+	_arg1;								\
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)				\
+({									\
+	register long _num __asm__ ("1") = (num);			\
+	register long _arg1 __asm__ ("2") = (long)(arg1);		\
+	register long _arg2 __asm__ ("3") = (long)(arg2);		\
+	register long _arg3 __asm__ ("4") = (long)(arg3);		\
+									\
+	__asm__  volatile (						\
+		"svc 0\n"						\
+		: "+d"(_arg1)						\
+		: "d"(_arg2), "d"(_arg3), "d"(_num)			\
+		: "memory", "cc"					\
+		);							\
+	_arg1;								\
+})
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)			\
+({									\
+	register long _num __asm__ ("1") = (num);			\
+	register long _arg1 __asm__ ("2") = (long)(arg1);		\
+	register long _arg2 __asm__ ("3") = (long)(arg2);		\
+	register long _arg3 __asm__ ("4") = (long)(arg3);		\
+	register long _arg4 __asm__ ("5") = (long)(arg4);		\
+									\
+	__asm__  volatile (						\
+		"svc 0\n"						\
+		: "+d"(_arg1)						\
+		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_num)		\
+		: "memory", "cc"					\
+		);							\
+	_arg1;								\
+})
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)			\
+({									\
+	register long _num __asm__ ("1") = (num);			\
+	register long _arg1 __asm__ ("2") = (long)(arg1);		\
+	register long _arg2 __asm__ ("3") = (long)(arg2);		\
+	register long _arg3 __asm__ ("4") = (long)(arg3);		\
+	register long _arg4 __asm__ ("5") = (long)(arg4);		\
+	register long _arg5 __asm__ ("6") = (long)(arg5);		\
+									\
+	__asm__  volatile (						\
+		"svc 0\n"						\
+		: "+d"(_arg1)						\
+		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_arg5),	\
+		  "d"(_num)						\
+		: "memory", "cc"					\
+		);							\
+	_arg1;								\
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)		\
+({									\
+	register long _num __asm__ ("1") = (num);			\
+	register long _arg1 __asm__ ("2") = (long)(arg1);		\
+	register long _arg2 __asm__ ("3") = (long)(arg2);		\
+	register long _arg3 __asm__ ("4") = (long)(arg3);		\
+	register long _arg4 __asm__ ("5") = (long)(arg4);		\
+	register long _arg5 __asm__ ("6") = (long)(arg5);		\
+	register long _arg6 __asm__ ("7") = (long)(arg6);		\
+									\
+	__asm__  volatile (						\
+		"svc 0\n"						\
+		: "+d"(_arg1)						\
+		: "d"(_arg2), "d"(_arg3), "d"(_arg4), "d"(_arg5),	\
+		  "d"(_arg6), "d"(_num)					\
+		: "memory", "cc"					\
+		);							\
+	_arg1;								\
+})
+
+/* startup code */
+__asm__ (".section .text\n"
+	 ".weak _start\n"
+	 "_start:\n"
+	 "lg	%r2,0(%r15)\n"		/* argument count */
+	 "la	%r3,8(%r15)\n"		/* argument pointers */
+
+	 "xgr	%r0,%r0\n"		/* r0 will be our NULL value */
+	 /* search for envp */
+	 "lgr	%r4,%r3\n"		/* start at argv */
+	 "0:\n"
+	 "clg	%r0,0(%r4)\n"		/* entry zero? */
+	 "la	%r4,8(%r4)\n"		/* advance pointer */
+	 "jnz	0b\n"			/* no -> test next pointer */
+					/* yes -> r4 now contains start of envp */
+
+	 "aghi	%r15,-160\n"		/* allocate new stackframe */
+	 "xc	0(8,%r15),0(%r15)\n"	/* clear backchain */
+	 "brasl	%r14,main\n"		/* ret value of main is arg to exit */
+	 "lghi	%r1,1\n"		/* __NR_exit */
+	 "svc	0\n"
+	 "");
+
+struct s390_mmap_arg_struct {
+	unsigned long addr;
+	unsigned long len;
+	unsigned long prot;
+	unsigned long flags;
+	unsigned long fd;
+	unsigned long offset;
+};
+
+static __attribute__((unused))
+void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
+	       off_t offset)
+{
+	struct s390_mmap_arg_struct args = {
+		.addr = (unsigned long)addr,
+		.len = (unsigned long)length,
+		.prot = prot,
+		.flags = flags,
+		.fd = fd,
+		.offset = (unsigned long)offset
+	};
+
+	return (void *)my_syscall1(__NR_mmap, &args);
+}
+#define sys_mmap sys_mmap
+#endif // _NOLIBC_ARCH_S390_H
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 4c6992321b0d..78b067a4fa47 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -27,6 +27,8 @@
 #include "arch-mips.h"
 #elif defined(__riscv)
 #include "arch-riscv.h"
+#elif defined(__s390x__)
+#include "arch-s390.h"
 #endif
 
 #endif /* _NOLIBC_ARCH_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index 78473d34e27c..a42d7c405bdc 100644
--- a/tools/include/nolibc/sys.h
+++ b/tools/include/nolibc/sys.h
@@ -686,6 +686,7 @@ int mknod(const char *path, mode_t mode, dev_t dev)
 #define MAP_FAILED ((void *)-1)
 #endif
 
+#ifndef sys_mmap
 static __attribute__((unused))
 void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	       off_t offset)
@@ -707,6 +708,7 @@ void *sys_mmap(void *addr, size_t length, int prot, int flags, int fd,
 	return (void *)my_syscall6(n, addr, length, prot, flags, fd, offset);
 #endif
 }
+#endif
 
 static __attribute__((unused))
 void *mmap(void *addr, size_t length, int prot, int flags, int fd, off_t offset)
-- 
2.17.5

