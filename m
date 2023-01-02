Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B0965B00B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 11:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229470AbjABKwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 05:52:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231730AbjABKwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 05:52:07 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3DD625F4;
        Mon,  2 Jan 2023 02:52:05 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3028CtLP011323;
        Mon, 2 Jan 2023 10:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=nAKMIu0WKzF2mKkWHHuX95QPtvqwcG7iKmnBAv6vac4=;
 b=F93nyTyvP53JYy3jXVj+1iwpzBCQP692uPcmKm8uv8E8GDmITo/UyBnz+UNr9wDTLa9B
 xYJaZTmeias3bM810ypMe664AgGYThkqsgT4TCNFwL+aLwfeSX+R0cA5ENzD5hQwDc4M
 uAXO5Oucrr9Qyvpjq/ubH4AErn4J8AKX7rhE0Kb46V5R6BGuEuoiiqeyuAYOI54HiIGR
 mj9/C/B8pBO+7b90k/dxjGyv0kTycwy00QoG1QbuPhQEVeb6ISgMsQg0RPmZCQHqaqJa
 Eqh9XlOXaaF5ltKVMGWOTp1uoRdy9j7Vfq5TiNVBOWQ1kfqmv5rOdmIxI3woOCdEnJ1l Cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mty836cb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:36 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 302AkGFS017701;
        Mon, 2 Jan 2023 10:51:35 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3mty836cas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:35 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3017rFwg008371;
        Mon, 2 Jan 2023 10:51:33 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3mtcbfhpu3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Jan 2023 10:51:33 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 302ApUnB24248798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 2 Jan 2023 10:51:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D019B20040;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B497B20043;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  2 Jan 2023 10:51:30 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
        id 88D4BE0914; Mon,  2 Jan 2023 11:51:30 +0100 (CET)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Willy Tarreau <w@1wt.eu>, "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 2/5] nolibc: add support for s390
Date:   Mon,  2 Jan 2023 11:51:09 +0100
Message-Id: <20230102105112.1661651-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230102105112.1661651-1-svens@linux.ibm.com>
References: <20230102105112.1661651-1-svens@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KbhZ5tljGJ1BLWA30PQFGa7SzYpYME9h
X-Proofpoint-ORIG-GUID: ISzJ9NWfRaGnCLHiLwfQabSSFar6Q0JN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-02_06,2022-12-30_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 clxscore=1015 mlxscore=0 bulkscore=0
 adultscore=0 spamscore=0 mlxlogscore=416 phishscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301020096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use arch-x86_64 as a template. Not really different, but
we have our own mmap syscall which takes a structure instead
of discrete arguments.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 tools/include/nolibc/arch-s390.h | 213 +++++++++++++++++++++++++++++++
 tools/include/nolibc/arch.h      |   2 +
 tools/include/nolibc/sys.h       |   2 +
 3 files changed, 217 insertions(+)
 create mode 100644 tools/include/nolibc/arch-s390.h

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
new file mode 100644
index 000000000000..df96d8f830a7
--- /dev/null
+++ b/tools/include/nolibc/arch-s390.h
@@ -0,0 +1,213 @@
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
+	 "la	%r4,24(%r15)\n"		/* environment pointers */
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
index 4c6992321b0d..fcded65b98d7 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -27,6 +27,8 @@
 #include "arch-mips.h"
 #elif defined(__riscv)
 #include "arch-riscv.h"
+#elif defined(__s390x__)
+#include "arch-s390x.h"
 #endif
 
 #endif /* _NOLIBC_ARCH_H */
diff --git a/tools/include/nolibc/sys.h b/tools/include/nolibc/sys.h
index ce3ee03aa679..3db1dd8c74ee 100644
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
2.34.1

