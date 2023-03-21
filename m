Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6C66C2760
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 02:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjCUBV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 21:21:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjCUBVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 21:21:25 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C872125A4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 18:20:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BEC8BCE172D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 01:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFABAC433B0;
        Tue, 21 Mar 2023 01:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679361099;
        bh=0tnH+PV473Tm6iVXAJx7Tp9q1rEWeuiB5k/lIQjGGho=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n9A5bQTnBwsvTjjQvz11pI1Y5IyAm9UQpZsrVFzL2KMxFnsS/j+JT2qJZSbJeRp6H
         8nCHGRcT+kUPqC/hk453RD8PpFmHeSg1TEivThL1jZDdn8DegoqMOdr1DWqnefC2nr
         Dv0vsqd1GSg39YcZxx4WfyX8Y//eonScyBjB/ioCZgSxzQXtDjfLz+/c4TsRqPNa13
         VFsGvpuOfMf8BpCY4q2SROamqnavnh1zKe4UQAX1aKvvp2ZcCy6mYlqPYYhVJ4Qt9p
         Y7tXpiJ1J1+EoYu4EoH3S6aX8AAM79zUVTapV9w8X2EVUkFVbLLTEPM41CcjBpM4ZP
         S0f7a/Dwv8bBw==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 0642415403A4; Mon, 20 Mar 2023 18:11:39 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     gwml@vger.gnuweeb.org, kernel-team@meta.com, w@lwt.eu,
        Feiyang Chen <chenfeiyang@loongson.cn>,
        Huacai Chen <chenhuacai@loongson.cn>, Willy Tarreau <w@1wt.eu>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH nolibc 12/14] tools/nolibc: Add support for LoongArch
Date:   Mon, 20 Mar 2023 18:11:35 -0700
Message-Id: <20230321011137.51837-12-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
References: <6a3206d0-e5cd-4990-9604-444a24a8207c@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Feiyang Chen <chenfeiyang@loongson.cn>

Add support for LoongArch (32 and 64 bit) to nolibc.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/arch-loongarch.h | 200 ++++++++++++++++++++++++++
 tools/include/nolibc/arch.h           |   2 +
 2 files changed, 202 insertions(+)
 create mode 100644 tools/include/nolibc/arch-loongarch.h

diff --git a/tools/include/nolibc/arch-loongarch.h b/tools/include/nolibc/arch-loongarch.h
new file mode 100644
index 000000000000..029ee3cd6baf
--- /dev/null
+++ b/tools/include/nolibc/arch-loongarch.h
@@ -0,0 +1,200 @@
+/* SPDX-License-Identifier: LGPL-2.1 OR MIT */
+/*
+ * LoongArch specific definitions for NOLIBC
+ * Copyright (C) 2023 Loongson Technology Corporation Limited
+ */
+
+#ifndef _NOLIBC_ARCH_LOONGARCH_H
+#define _NOLIBC_ARCH_LOONGARCH_H
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
+		"la.pcrel      $a4, _auxv\n"          // a4 = &_auxv
+		LONG_S       " $a3, $a4, 0\n"         // store a3 into _auxv
+
+		"la.pcrel      $a3, environ\n"        // a3 = &environ
+		LONG_S       " $a2, $a3, 0\n"         // store envp(a2) into environ
+		LONG_BSTRINS " $sp, $zero, 3, 0\n"    // sp must be 16-byte aligned
+		"bl            main\n"                // main() returns the status code, we'll exit with it.
+		"li.w          $a7, 93\n"             // NR_exit == 93
+		"syscall       0\n"
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
2.40.0.rc2

