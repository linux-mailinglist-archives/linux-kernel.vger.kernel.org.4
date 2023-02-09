Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA74168FDE7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 04:25:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjBIDZQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 22:25:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbjBIDYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 22:24:37 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67621126E5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 19:24:34 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id gj9-20020a17090b108900b0023114156d36so4357331pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 19:24:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xibiFF/V1JSfx4FVu1IvjMxukDbBPo1ygOI1aB6E6KY=;
        b=duqBh6zR1EPMOjfmGmy8rAUfEZToUfWPCX6ZWeu2VoqcXeTKHAsByuY3pYlJc1hCp4
         rJ2JgON3y02f50DMNoIcS06plkv8is6t9pxEAln2ElvfnJa5OHDvj5RUFreNpyKGo+W1
         /jtowuUynU+ELIA6pT9ijZcvMV7hFPXDAvBeVkn9erQbOtZ5DeWRSnx5e6AWkPCo+Y3x
         wTfsYHAldyxlexW4ipwTKYCC3mUymATHW9heZjjPcwR5ZSZioFQNY+7WFbncHC8WA7V/
         qtmNWKn13AqeNMws8P6c/X3ynWjxlPg/Yqs2Zl//w+ltuJmdMNf4/kZhvtZO20z7KQqK
         x+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xibiFF/V1JSfx4FVu1IvjMxukDbBPo1ygOI1aB6E6KY=;
        b=pl8mYBTNDaMGwGWFr7IYJaAfa3J8Fv1UX/j+GXx8BGu2q8rxbxJaOdkFvbXT/cQMAK
         01fF4WwpjBjQU5RKyiYa9l+DxYzjISD2HmbzzWZFMol2s4zUAx0SeVCr/DY09tP+3OCp
         Ki+nVskCwtGbA6LSCebWWh6a7gl5+PBOoQSRZ98ZEDmaG4W32UT91uriNmPpNA3MYgdo
         nsh2ZFN0rEgOlcfeEAbNhofKhBlGfSS9enMQBf+i1B3i2btwayEalVFMpzMKrpDMAeQu
         zZOg0NCuqasOpJtq+qKDccxRl+xJLIbOs6O0PAu5LK1IIRSU6FdRRCj+KPZfVbRotrDg
         qtkg==
X-Gm-Message-State: AO0yUKUJ0MiyERfvy74HRqESBoATp1Q5eWiJQtoRZdhoma11dXYBPFn8
        g3wo1fEf6VAszAllxD7DoUI=
X-Google-Smtp-Source: AK7set/DtLeVN8DjT4PYmdhl8G9Ard+TFk0dUH5bmnDlH3/mAf3zpmPwJSKsVFwDRIYxQuHNYzfAaw==
X-Received: by 2002:a17:902:f2cd:b0:19a:5999:7a35 with SMTP id h13-20020a170902f2cd00b0019a59997a35mr827082plc.36.1675913073804;
        Wed, 08 Feb 2023 19:24:33 -0800 (PST)
Received: from localhost.localdomain ([112.20.108.204])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b00192820d00d0sm216086pld.120.2023.02.08.19.24.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 08 Feb 2023 19:24:33 -0800 (PST)
From:   chris.chenfeiyang@gmail.com
X-Google-Original-From: chenfeiyang@loongson.cn
To:     w@1wt.eu, paulmck@kernel.org
Cc:     Feiyang Chen <chenfeiyang@loongson.cn>, arnd@arndb.de,
        chenhuacai@kernel.org, jiaxun.yang@flygoat.com,
        chris.chenfeiyang@gmail.com, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] tools/nolibc: Add support for LoongArch
Date:   Thu,  9 Feb 2023 11:24:14 +0800
Message-Id: <19f6fc2d1c15b9fb3b13ff78ce00298b74de2d72.1675907639.git.chenfeiyang@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1675907639.git.chenfeiyang@loongson.cn>
References: <cover.1675907639.git.chenfeiyang@loongson.cn>
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
2.39.0

