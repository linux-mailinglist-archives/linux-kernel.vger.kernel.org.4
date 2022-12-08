Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4A26470F0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:41:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbiLHNlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:41:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiLHNlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:41:14 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8B7D58BD10
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:41:13 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx2+p46ZFjIR8EAA--.9620S3;
        Thu, 08 Dec 2022 21:41:12 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxTuB06ZFj8BwoAA--.33104S5;
        Thu, 08 Dec 2022 21:41:12 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v9 3/4] LoongArch: Add kretprobe support
Date:   Thu,  8 Dec 2022 21:41:07 +0800
Message-Id: <1670506868-15771-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1670506868-15771-1-git-send-email-yangtiezhu@loongson.cn>
References: <1670506868-15771-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8BxTuB06ZFj8BwoAA--.33104S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFWrZw45JFW3tFyUWw1UGFg_yoWrtr45pF
        9rArn8Zr4I9rnYvr93trWF9Fyjqr1kua12gFy7JrWrGF4UWr1UXr1xGr9rZF43Kws8Jr1S
        qr1rGrWYqFW3J37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic kretprobe trampoline handler to add kretprobe
support for LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig                     |  1 +
 arch/loongarch/kernel/Makefile             |  2 +-
 arch/loongarch/kernel/kprobes.c            | 24 ++++++++
 arch/loongarch/kernel/kprobes_trampoline.S | 96 ++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f6fc156..12571ee 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -103,6 +103,7 @@ config LOONGARCH
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES
+	select HAVE_KRETPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_PCI
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 6fe4a4e..7ca6519 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -47,6 +47,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
 
-obj-$(CONFIG_KPROBES)		+= kprobes.o
+obj-$(CONFIG_KPROBES)		+= kprobes.o kprobes_trampoline.o
 
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
index aadfc9ae..31dd75c 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -326,6 +326,30 @@ int __init arch_populate_kprobe_blacklist(void)
 					 (unsigned long)__irqentry_text_end);
 }
 
+/* Called from __kretprobe_trampoline */
+void __used *trampoline_probe_handler(struct pt_regs *regs)
+{
+	return (void *)kretprobe_trampoline_handler(regs, NULL);
+}
+NOKPROBE_SYMBOL(trampoline_probe_handler);
+
+void arch_prepare_kretprobe(struct kretprobe_instance *ri,
+			    struct pt_regs *regs)
+{
+	ri->ret_addr = (kprobe_opcode_t *)regs->regs[1];
+	ri->fp = NULL;
+
+	/* Replace the return addr with trampoline addr */
+	regs->regs[1] = (unsigned long)&__kretprobe_trampoline;
+}
+NOKPROBE_SYMBOL(arch_prepare_kretprobe);
+
+int arch_trampoline_kprobe(struct kprobe *p)
+{
+	return 0;
+}
+NOKPROBE_SYMBOL(arch_trampoline_kprobe);
+
 int __init arch_init_kprobes(void)
 {
 	return 0;
diff --git a/arch/loongarch/kernel/kprobes_trampoline.S b/arch/loongarch/kernel/kprobes_trampoline.S
new file mode 100644
index 0000000..af94b0d
--- /dev/null
+++ b/arch/loongarch/kernel/kprobes_trampoline.S
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#include <linux/linkage.h>
+#include <asm/stackframe.h>
+
+	.text
+
+	.macro save_all_base_regs
+	cfi_st  ra, PT_R1
+	cfi_st	tp, PT_R2
+	cfi_st	a0, PT_R4
+	cfi_st	a1, PT_R5
+	cfi_st	a2, PT_R6
+	cfi_st	a3, PT_R7
+	cfi_st	a4, PT_R8
+	cfi_st	a5, PT_R9
+	cfi_st	a6, PT_R10
+	cfi_st	a7, PT_R11
+	cfi_st	t0, PT_R12
+	cfi_st	t1, PT_R13
+	cfi_st	t2, PT_R14
+	cfi_st	t3, PT_R15
+	cfi_st	t4, PT_R16
+	cfi_st	t5, PT_R17
+	cfi_st	t6, PT_R18
+	cfi_st	t7, PT_R19
+	cfi_st	t8, PT_R20
+	cfi_st	u0, PT_R21
+	cfi_st	fp, PT_R22
+	cfi_st	s0, PT_R23
+	cfi_st	s1, PT_R24
+	cfi_st	s2, PT_R25
+	cfi_st	s3, PT_R26
+	cfi_st	s4, PT_R27
+	cfi_st	s5, PT_R28
+	cfi_st	s6, PT_R29
+	cfi_st	s7, PT_R30
+	cfi_st	s8, PT_R31
+	csrrd	t0, LOONGARCH_CSR_CRMD
+	andi	t0, t0, 0x7 /* extract bit[1:0] PLV, bit[2] IE */
+	LONG_S	t0, sp, PT_CRMD
+	.endm
+
+	.macro restore_all_base_regs
+	cfi_ld	tp, PT_R2
+	cfi_ld	a0, PT_R4
+	cfi_ld	a1, PT_R5
+	cfi_ld	a2, PT_R6
+	cfi_ld	a3, PT_R7
+	cfi_ld	a4, PT_R8
+	cfi_ld	a5, PT_R9
+	cfi_ld	a6, PT_R10
+	cfi_ld	a7, PT_R11
+	cfi_ld	t0, PT_R12
+	cfi_ld	t1, PT_R13
+	cfi_ld	t2, PT_R14
+	cfi_ld	t3, PT_R15
+	cfi_ld	t4, PT_R16
+	cfi_ld	t5, PT_R17
+	cfi_ld	t6, PT_R18
+	cfi_ld	t7, PT_R19
+	cfi_ld	t8, PT_R20
+	cfi_ld	u0, PT_R21
+	cfi_ld	fp, PT_R22
+	cfi_ld	s0, PT_R23
+	cfi_ld	s1, PT_R24
+	cfi_ld	s2, PT_R25
+	cfi_ld	s3, PT_R26
+	cfi_ld	s4, PT_R27
+	cfi_ld	s5, PT_R28
+	cfi_ld	s6, PT_R29
+	cfi_ld	s7, PT_R30
+	cfi_ld	s8, PT_R31
+	LONG_L  t0, sp, PT_CRMD
+	li.d	t1, 0x7 /* mask bit[1:0] PLV, bit[2] IE */
+	csrxchg t0, t1, LOONGARCH_CSR_CRMD
+	.endm
+
+SYM_CODE_START(__kretprobe_trampoline)
+	addi.d	sp, sp, -PT_SIZE
+	save_all_base_regs
+
+	addi.d	t0, sp, PT_SIZE
+	LONG_S	t0, sp, PT_R3
+
+	move a0, sp /* pt_regs */
+
+	bl trampoline_probe_handler
+
+	/* use the result as the return-address */
+	move ra, a0
+
+	restore_all_base_regs
+	addi.d	sp, sp, PT_SIZE
+
+	jr ra
+SYM_CODE_END(__kretprobe_trampoline)
-- 
2.1.0

