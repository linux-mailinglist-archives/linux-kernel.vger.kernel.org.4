Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8468666AA70
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjANJ2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjANJ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:27:39 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D6237A8A
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:27:36 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8BxKuqGdcJjbZ0BAA--.4995S3;
        Sat, 14 Jan 2023 17:27:34 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+SBdcJjcVYZAA--.11667S5;
        Sat, 14 Jan 2023 17:27:34 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v11 3/6] LoongArch: Add kretprobe support
Date:   Sat, 14 Jan 2023 17:27:21 +0800
Message-Id: <1673688444-24251-4-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn>
References: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Bxb+SBdcJjcVYZAA--.11667S5
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvJXoWxGFWrZw45JFW3Kw48WF1kuFg_yoWrKry8pF
        9rArn8Zr4I9rnavr93trWF9Fyjqr1kua12gFy7JrWrWF48WryUXr1xGr9rZF43Kws8Jr1S
        qr1rGrW5tFW3J37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the generic kretprobe trampoline handler to add kretprobe support
for LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig                     |  1 +
 arch/loongarch/kernel/Makefile             |  2 +-
 arch/loongarch/kernel/kprobes.c            | 27 +++++++++
 arch/loongarch/kernel/kprobes_trampoline.S | 96 ++++++++++++++++++++++++++++++
 4 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index ce930f2..134a2f8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -104,6 +104,7 @@ config LOONGARCH
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
index a0c2f9d..ced9c4c 100644
--- a/arch/loongarch/kernel/kprobes.c
+++ b/arch/loongarch/kernel/kprobes.c
@@ -372,6 +372,33 @@ int __init arch_populate_kprobe_blacklist(void)
 					 (unsigned long)__irqentry_text_end);
 }
 
+/* Called from __kretprobe_trampoline */
+void __used *trampoline_probe_handler(struct pt_regs *regs)
+{
+	return (void *)kretprobe_trampoline_handler(regs, NULL);
+}
+NOKPROBE_SYMBOL(trampoline_probe_handler);
+
+/* assembler function that handles the kretprobes must not be probed itself */
+NOKPROBE_SYMBOL(__kretprobe_trampoline);
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

