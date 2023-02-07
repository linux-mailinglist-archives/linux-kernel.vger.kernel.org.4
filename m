Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D359968CC71
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 03:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjBGCKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 21:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjBGCJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 21:09:58 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07ACD35262
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 18:09:56 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 7so9507337pgh.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 18:09:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oTBK5yT9c802oLLl858LgMyvhpHlKJkR6QtDD5uV4zA=;
        b=JtBTNnjF/F7gHmCLNhLBlLqaPX/xqp/dhcLyHGdnQMtVbneOUEf1Go5f54oJE6dr35
         8qlX88TwVze81uei0FN7Yh1RIkBVX2H0n2+/2RByzoU/Y7tUQhsTzIpnAMalk2AxGGfn
         MFhXyQ2wmm+B2zGReSUF5U0ntvcMz7S8j/s0biizt5ckcvBfKSHqbNXX7oEHHF/sd89o
         KvtkDuRvBHn/0TsZ9r0tX1Op/CRlP2UlfFgsak8ZBH3F4imjJrczf9vPFoLAG+rmhcQ3
         S0FL+YJH138edZ5NkaQl2z8lviCYaJn8n9TwHwMMcU96wN5vs2Md28Fx1uga3deQakJU
         xHdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oTBK5yT9c802oLLl858LgMyvhpHlKJkR6QtDD5uV4zA=;
        b=pFOjZeMnZZ0DrhjEQQwETfAHPLT8T4FgaDxXCNwUEudJ7n84M+MSO66Vge6hRHNuLZ
         V7bMAE0ajwCxLx+7X2m8iiuph28T0sMLIuJxbGmnPRYNIUU56EwPJvZRup4xRz31ksHf
         tfhv8zptbO8RyWNIb+Sy85Kdiz935sv3S3ZoGHqlrxxmahsUP1xe88+WlLn5ZInn3F8Z
         SLPThH8BOhhLKBaLAdXyydq2hFc9kOA5/C0TeHmwsP0mqKSQP8pg3SHnm7oJ10jnDJfZ
         2nUfXxXEwVn/yiv7QKPqu96nR5WpYajVAphPy/T+sUnZV4QFw5KcOeN8KQlIlqsSJzf3
         C91A==
X-Gm-Message-State: AO0yUKWXLli1JKDvPTfdLGoq9XDxkFdRY3VSWB+0+BSDhXAC27ybyonT
        vL51Jed9veIQMTvWsmKfSHk=
X-Google-Smtp-Source: AK7set9UwYa6ds5veEYmDj2qiRdIwSIscqAqeKSQavPi4wx6+lAF4sEelHMquZN0WWa7QbIDjDbLWA==
X-Received: by 2002:aa7:94b3:0:b0:594:311:4509 with SMTP id a19-20020aa794b3000000b0059403114509mr1811910pfl.19.1675735796406;
        Mon, 06 Feb 2023 18:09:56 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id d198-20020a621dcf000000b00593225b379dsm7843765pfd.106.2023.02.06.18.09.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Feb 2023 18:09:55 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, chenhuacai@kernel.org,
        jiaxun.yang@flygoat.com, arnd@arndb.de,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] nolibc: Add support for LoongArch
Date:   Tue,  7 Feb 2023 10:09:41 +0800
Message-Id: <612947724da74327edb5e774de73d6d2a96d1648.1675734681.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675734681.git.chenfeiyang@loongson.cn>
References: <cover.1675734681.git.chenfeiyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Add support for LoongArch (32 and 64 bit) to nolibc.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
---
 tools/include/nolibc/arch-loongarch.h | 223 ++++++++++++++++++++++++++
 tools/include/nolibc/arch.h           |   2 +
 2 files changed, 225 insertions(+)
 create mode 100644 tools/include/nolibc/arch-loongarch.h

diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
new file mode 100644
index 000000000000..610efe00915c
--- /dev/null
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -0,0 +1,223 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * LoongArch specific definitions for NOLIBC
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef _NOLIBC_ARCH_LOONGARCH_H
+#define _NOLIBC_ARCH_LOONGARCH_H
+
+struct sys_stat_struct {
+	unsigned long	st_dev;		/* Device.  */
+	unsigned long	st_ino;		/* File serial number.  */
+	unsigned int	st_mode;	/* File mode.  */
+	unsigned int	st_nlink;	/* Link count.  */
+	unsigned int	st_uid;		/* User ID of the file's owner.  */
+	unsigned int	st_gid;		/* Group ID of the file's group. */
+	unsigned long	st_rdev;	/* Device number, if device.  */
+	unsigned long	__pad1;
+	long		st_size;	/* Size of file, in bytes.  */
+	int		st_blksize;	/* Optimal block size for I/O.  */
+	int		__pad2;
+	long		st_blocks;	/* Number 512-byte blocks allocated. */
+	long		st_atime;	/* Time of last access.  */
+	unsigned long	st_atime_nsec;
+	long		st_mtime;	/* Time of last modification.  */
+	unsigned long	st_mtime_nsec;
+	long		st_ctime;	/* Time of last status change.  */
+	unsigned long	st_ctime_nsec;
+	unsigned int	__unused4;
+	unsigned int	__unused5;
+};
+
+/* Syscalls for LoongArch :
+ *   - stack is 16-byte aligned
+ *   - syscall number is passed in a7
+ *   - arguments are in a0, a1, a2, a3, a4, a5
+ *   - the system call is performed by calling "syscall 0"
+ *   - syscall return comes in a0
+ *   - the arguments are cast to long and assigned into the target
+ *     registers which are then simply passed as registers to the asm code,
+ *     so that we don't have to experience issues with register constraints.
+ *
+ * On LoongArch, select() is not implemented so we have to use pselect6().
+ */
+#define __ARCH_WANT_SYS_PSELECT6
+
+#define my_syscall0(num)                                                      \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0");                                   \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "=r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall1(num, arg1)                                                \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);		      \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2),                                                 \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall3(num, arg1, arg2, arg3)                                    \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3),                                     \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall4(num, arg1, arg2, arg3, arg4)                              \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4),                         \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall5(num, arg1, arg2, arg3, arg4, arg5)                        \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5),             \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+#define my_syscall6(num, arg1, arg2, arg3, arg4, arg5, arg6)                  \
+({                                                                            \
+	register long _num  __asm__ ("a7") = (num);                           \
+	register long _arg1 __asm__ ("a0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("a1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("a2") = (long)(arg3);                    \
+	register long _arg4 __asm__ ("a3") = (long)(arg4);                    \
+	register long _arg5 __asm__ ("a4") = (long)(arg5);                    \
+	register long _arg6 __asm__ ("a5") = (long)(arg6);                    \
+									      \
+	__asm__  volatile (                                                   \
+		"syscall 0\n"                                                 \
+		: "+r"(_arg1)                                                 \
+		: "r"(_arg2), "r"(_arg3), "r"(_arg4), "r"(_arg5), "r"(_arg6), \
+		  "r"(_num)                                                   \
+		: "memory", "$t0", "$t1", "$t2", "$t3",                       \
+		  "$t4", "$t5", "$t6", "$t7", "$t8"                           \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+char **environ __attribute__((weak));
+const unsigned long *_auxv __attribute__((weak));
+
+#if __loongarch_grlen == 32
+#define LONGLOG      "2"
+#define SZREG        "4"
+#define REG_L        "ld.w"
+#define LONG_S       "st.w"
+#define LONG_ADD     "add.w"
+#define LONG_ADDI    "addi.w"
+#define LONG_SLL     "slli.w"
+#define LONG_BSTRINS "bstrins.w"
+#else // __loongarch_grlen == 64
+#define LONGLOG      "3"
+#define SZREG        "8"
+#define REG_L        "ld.d"
+#define LONG_S       "st.d"
+#define LONG_ADD     "add.d"
+#define LONG_ADDI    "addi.d"
+#define LONG_SLL     "slli.d"
+#define LONG_BSTRINS "bstrins.d"
+#endif
+
+/* startup code */
+void __attribute__((weak,noreturn,optimize("omit-frame-pointer"))) _start(void)
+{
+	__asm__ volatile (
+		REG_L        " $a0, $sp, 0\n"         // argc (a0) was in the stack
+		LONG_ADDI    " $a1, $sp, "SZREG"\n"   // argv (a1) = sp + SZREG
+		LONG_SLL     " $a2, $a0, "LONGLOG"\n" // envp (a2) = SZREG*argc ...
+		LONG_ADDI    " $a2, $a2, "SZREG"\n"   //             + SZREG (skip null)
+		LONG_ADD     " $a2, $a2, $a1\n"       //             + argv
+
+		"move          $a3, $a2\n"            // iterate a3 over envp to find auxv (after NULL)
+		"0:\n"                                // do {
+		REG_L        " $a4, $a3, 0\n"         //   a4 = *a3;
+		LONG_ADDI    " $a3, $a3, "SZREG"\n"   //   a3 += sizeof(void*);
+		"bne           $a4, $zero, 0b\n"      // } while (a4);
+		LONG_S       " $a3, %[_auxv]\n"       // store a3 into _auxv
+
+		LONG_S       " $a2, %[environ]\n"     // store envp(a2) into environ
+		LONG_BSTRINS " $sp, $zero, 3, 0\n"    // sp must be 16-byte aligned
+		"bl            main\n"                // main() returns the status code, we'll exit with it.
+		"li.w          $a7, 93\n"             // NR_exit == 93
+		"syscall       0\n"
+		:
+		: [_auxv]"m"(_auxv), [environ]"m"(environ)
+	);
+	__builtin_unreachable();
+}
+
+#endif // _NOLIBC_ARCH_LOONGARCH_H
diff --git a/tools/include/nolibc/arch.h b/tools/include/nolibc/arch.h
index 78b067a4fa47..2d5386a8d6aa 100644
--- a/tools/include/nolibc/arch.h
+++ b/tools/include/nolibc/arch.h
@@ -29,6 +29,8 @@
 #include "arch-riscv.h"
 #elif defined(__s390x__)
 #include "arch-s390.h"
+#elif defined(__loongarch__)
+#include "arch-loongarch.h"
 #endif
 
 #endif /* _NOLIBC_ARCH_H */
-- 
2.39.0

