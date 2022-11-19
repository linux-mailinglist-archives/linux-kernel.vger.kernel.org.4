Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAD0630BEC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 05:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbiKSEnE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 23:43:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiKSEm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 23:42:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AC7C97ED9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 20:42:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B853CB8252C
        for <linux-kernel@vger.kernel.org>; Sat, 19 Nov 2022 04:42:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E45CC433C1;
        Sat, 19 Nov 2022 04:42:51 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, Xuefeng Li <lixuefeng@loongson.cn>,
        Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        linux-kernel@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH] LoongArch: Add basic STACKPROTECTOR support
Date:   Sat, 19 Nov 2022 12:40:25 +0800
Message-Id: <20221119044025.1578509-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic stack protector support similar to other architectures. A
constant canary value is set at boot time, and with help of compiler's
-fstack-protector we can detect stack corruption.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                      |  1 +
 arch/loongarch/include/asm/stackprotector.h | 38 +++++++++++++++++++++
 arch/loongarch/kernel/asm-offsets.c         |  3 ++
 arch/loongarch/kernel/process.c             |  6 ++++
 arch/loongarch/kernel/switch.S              |  5 +++
 5 files changed, 53 insertions(+)
 create mode 100644 arch/loongarch/include/asm/stackprotector.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 6c40af615c20..0a43d104c3a0 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -104,6 +104,7 @@ config LOONGARCH
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RSEQ
 	select HAVE_SETUP_PER_CPU_AREA if NUMA
+	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_TIF_NOHZ
 	select HAVE_VIRT_CPU_ACCOUNTING_GEN if !SMP
diff --git a/arch/loongarch/include/asm/stackprotector.h b/arch/loongarch/include/asm/stackprotector.h
new file mode 100644
index 000000000000..a1a965751a7b
--- /dev/null
+++ b/arch/loongarch/include/asm/stackprotector.h
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * GCC stack protector support.
+ *
+ * Stack protector works by putting predefined pattern at the start of
+ * the stack frame and verifying that it hasn't been overwritten when
+ * returning from the function. The pattern is called stack canary and
+ * on LoongArch gcc expects it to be defined by a global variable called
+ * "__stack_chk_guard".
+ */
+
+#ifndef _ASM_STACKPROTECTOR_H
+#define _ASM_STACKPROTECTOR_H
+
+#include <linux/random.h>
+#include <linux/version.h>
+
+extern unsigned long __stack_chk_guard;
+
+/*
+ * Initialize the stackprotector canary value.
+ *
+ * NOTE: this must only be called from functions that never return,
+ * and it must always be inlined.
+ */
+static __always_inline void boot_init_stack_canary(void)
+{
+	unsigned long canary;
+
+	/* Try to get a semi random initial value. */
+	get_random_bytes(&canary, sizeof(canary));
+	canary ^= LINUX_VERSION_CODE;
+
+	current->stack_canary = canary;
+	__stack_chk_guard = current->stack_canary;
+}
+
+#endif	/* _ASM_STACKPROTECTOR_H */
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-offsets.c
index 4ef494577813..4bdb203fc66e 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -68,6 +68,9 @@ void output_task_defines(void)
 	OFFSET(TASK_FLAGS, task_struct, flags);
 	OFFSET(TASK_MM, task_struct, mm);
 	OFFSET(TASK_PID, task_struct, pid);
+#if defined(CONFIG_STACKPROTECTOR)
+	OFFSET(TASK_STACK_CANARY, task_struct, stack_canary);
+#endif
 	DEFINE(TASK_STRUCT_SIZE, sizeof(struct task_struct));
 	BLANK();
 }
diff --git a/arch/loongarch/kernel/process.c b/arch/loongarch/kernel/process.c
index d983dfce7371..27c8cacbce01 100644
--- a/arch/loongarch/kernel/process.c
+++ b/arch/loongarch/kernel/process.c
@@ -47,6 +47,12 @@
 #include <asm/unwind.h>
 #include <asm/vdso.h>
 
+#ifdef CONFIG_STACKPROTECTOR
+#include <linux/stackprotector.h>
+unsigned long __stack_chk_guard __read_mostly;
+EXPORT_SYMBOL(__stack_chk_guard);
+#endif
+
 /*
  * Idle related variables and functions
  */
diff --git a/arch/loongarch/kernel/switch.S b/arch/loongarch/kernel/switch.S
index 202a163cb32f..31dd8199b245 100644
--- a/arch/loongarch/kernel/switch.S
+++ b/arch/loongarch/kernel/switch.S
@@ -23,6 +23,11 @@ SYM_FUNC_START(__switch_to)
 	stptr.d	ra, a0, THREAD_REG01
 	stptr.d a3, a0, THREAD_SCHED_RA
 	stptr.d a4, a0, THREAD_SCHED_CFA
+#if defined(CONFIG_STACKPROTECTOR) && !defined(CONFIG_SMP)
+	la	t7, __stack_chk_guard
+	LONG_L	t8, a1, TASK_STACK_CANARY
+	LONG_S	t8, t7, 0
+#endif
 	move	tp, a2
 	cpu_restore_nonscratch a1
 
-- 
2.31.1

