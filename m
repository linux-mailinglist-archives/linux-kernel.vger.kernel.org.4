Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D415ED235
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 02:50:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbiI1AuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 20:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbiI1AuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 20:50:15 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4228411E0FB
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 17:50:13 -0700 (PDT)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmtBmjNjVwIjAA--.53900S4;
        Wed, 28 Sep 2022 08:50:11 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] LoongArch: Add kprobe support
Date:   Wed, 28 Sep 2022 08:50:06 +0800
Message-Id: <1664326209-13995-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
References: <1664326209-13995-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8DxvmtBmjNjVwIjAA--.53900S4
X-Coremail-Antispam: 1UD129KBjvAXoW3KryUJw45tw45uryfJFyDGFg_yoW8JF17Zo
        WSvF4DXw40gr47uF15Ar1DXayUW3W8KFZ5AryavrsxuF1UAr1UXr1UCr4rJ3W3Xr4Fg3yf
        u343ua4fJa13Crn3n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYW7k0a2IF6w4kM7kC6x804xWl14x267AKxVW8JVW5JwAFc2x0
        x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87
        I2jVAFwI0_Jryl82xGYIkIc2x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY
        1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20x
        vEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280
        aVCY1x0267AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6w1l42xK82IYc2
        Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
        6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
        vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE
        42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
        kF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUyA9NDUUUU
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobes allows you to trap at almost any kernel address and
execute a callback function, this commit adds kprobe support
for LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig               |   1 +
 arch/loongarch/include/asm/inst.h    |  12 ++
 arch/loongarch/include/asm/kprobes.h |  44 +++++
 arch/loongarch/kernel/Makefile       |   2 +
 arch/loongarch/kernel/kprobes.c      | 312 +++++++++++++++++++++++++++++++++++
 arch/loongarch/mm/fault.c            |   3 +
 6 files changed, 374 insertions(+)
 create mode 100644 arch/loongarch/include/asm/kprobes.h
 create mode 100644 arch/loongarch/kernel/kprobes.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index be8389f..8debd70 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -94,6 +94,7 @@ config LOONGARCH
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_KPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_PCI
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index 93d5cd4..fc8879b 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -21,6 +21,10 @@
 
 #define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
 
+enum reg0i15_op {
+	break_op	= 0x54,
+};
+
 enum reg0i26_op {
 	b_op		= 0x14,
 	bl_op		= 0x15,
@@ -38,6 +42,8 @@ enum reg1i20_op {
 enum reg1i21_op {
 	beqz_op		= 0x10,
 	bnez_op		= 0x11,
+	bceqz_op	= 0x48000000,
+	bcnez_op	= 0x48000100,
 };
 
 enum reg2_op {
@@ -167,6 +173,11 @@ enum reg3sa2_op {
 	alsld_op	= 0x16,
 };
 
+struct reg0i15_format {
+	unsigned int immediate : 15;
+	unsigned int opcode : 17;
+};
+
 struct reg0i26_format {
 	unsigned int immediate_h : 10;
 	unsigned int immediate_l : 16;
@@ -252,6 +263,7 @@ struct reg3sa2_format {
 
 union loongarch_instruction {
 	unsigned int word;
+	struct reg0i15_format	reg0i15_format;
 	struct reg0i26_format	reg0i26_format;
 	struct reg1i20_format	reg1i20_format;
 	struct reg1i21_format	reg1i21_format;
diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/include/asm/kprobes.h
new file mode 100644
index 0000000..afcf254
--- /dev/null
+++ b/arch/loongarch/include/asm/kprobes.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_LOONGARCH_KPROBES_H
+#define __ASM_LOONGARCH_KPROBES_H
+
+#include <asm-generic/kprobes.h>
+
+#ifdef CONFIG_KPROBES
+
+#include <asm/inst.h>
+
+#define __ARCH_WANT_KPROBES_INSN_SLOT
+#define MAX_INSN_SIZE			2
+
+#define flush_insn_slot(p)		do { } while (0)
+#define kretprobe_blacklist_size	0
+
+typedef union loongarch_instruction kprobe_opcode_t;
+
+/* Architecture specific copy of original instruction */
+struct arch_specific_insn {
+	/* copy of the original instruction */
+	kprobe_opcode_t *insn;
+};
+
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned long status;
+	unsigned long saved_irq;
+	unsigned long saved_era;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned long kprobe_status;
+	unsigned long kprobe_saved_irq;
+	unsigned long kprobe_saved_era;
+	struct prev_kprobe prev_kprobe;
+};
+
+void arch_remove_kprobe(struct kprobe *p);
+bool kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+
+#endif /* CONFIG_KPROBES */
+#endif /* __ASM_LOONGARCH_KPROBES_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 5358144..ff98d8a 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -33,4 +33,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
 
+obj-$(CONFIG_KPROBES)		+= kprobes.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
new file mode 100644
index 0000000..c11f6e0
--- /dev/null
+++ b/arch/loongarch/kernel/kprobes.c
@@ -0,0 +1,312 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kprobes.h>
+#include <linux/kdebug.h>
+#include <asm/break.h>
+
+static const union loongarch_instruction breakpoint_insn = {
+	.reg0i15_format = {
+		.opcode = break_op,
+		.immediate = BRK_KPROBE_BP,
+	}
+};
+
+static const union loongarch_instruction singlestep_insn = {
+	.reg0i15_format = {
+		.opcode = break_op,
+		.immediate = BRK_KPROBE_SSTEPBP,
+	}
+};
+
+DEFINE_PER_CPU(struct kprobe *, current_kprobe);
+DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
+
+static bool insns_are_not_supported(union loongarch_instruction insn)
+{
+	switch (insn.reg2i14_format.opcode) {
+	case llw_op:
+	case lld_op:
+	case scw_op:
+	case scd_op:
+		pr_notice("kprobe: ll or sc instructions are not supported\n");
+		return true;
+	}
+
+	switch (insn.reg1i21_format.opcode) {
+	case bceqz_op:
+	case bcnez_op:
+		pr_notice("kprobe: bceqz or bcnez instructions are not supported\n");
+		return true;
+	}
+
+	return false;
+}
+NOKPROBE_SYMBOL(insns_are_not_supported);
+
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	union loongarch_instruction insn;
+
+	insn = p->addr[0];
+	if (insns_are_not_supported(insn))
+		return -EINVAL;
+
+	p->ainsn.insn = get_insn_slot();
+	if (!p->ainsn.insn)
+		return -ENOMEM;
+
+	p->ainsn.insn[0] = *p->addr;
+	p->ainsn.insn[1] = singlestep_insn;
+
+	p->opcode = *p->addr;
+
+	return 0;
+}
+NOKPROBE_SYMBOL(arch_prepare_kprobe);
+
+/* Install breakpoint in text */
+void arch_arm_kprobe(struct kprobe *p)
+{
+	*p->addr = breakpoint_insn;
+}
+NOKPROBE_SYMBOL(arch_arm_kprobe);
+
+/* Remove breakpoint from text */
+void arch_disarm_kprobe(struct kprobe *p)
+{
+	*p->addr = p->opcode;
+}
+NOKPROBE_SYMBOL(arch_disarm_kprobe);
+
+void arch_remove_kprobe(struct kprobe *p)
+{
+	if (p->ainsn.insn) {
+		free_insn_slot(p->ainsn.insn, 0);
+		p->ainsn.insn = NULL;
+	}
+}
+NOKPROBE_SYMBOL(arch_remove_kprobe);
+
+static void save_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	kcb->prev_kprobe.kp = kprobe_running();
+	kcb->prev_kprobe.status = kcb->kprobe_status;
+	kcb->prev_kprobe.saved_irq = kcb->kprobe_saved_irq;
+	kcb->prev_kprobe.saved_era = kcb->kprobe_saved_era;
+}
+NOKPROBE_SYMBOL(save_previous_kprobe);
+
+static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+	kcb->kprobe_saved_irq = kcb->prev_kprobe.saved_irq;
+	kcb->kprobe_saved_era = kcb->prev_kprobe.saved_era;
+}
+NOKPROBE_SYMBOL(restore_previous_kprobe);
+
+static void set_current_kprobe(struct kprobe *p, struct pt_regs *regs,
+			       struct kprobe_ctlblk *kcb)
+{
+	__this_cpu_write(current_kprobe, p);
+	kcb->kprobe_saved_irq = regs->csr_prmd & CSR_PRMD_PIE;
+	kcb->kprobe_saved_era = regs->csr_era;
+}
+NOKPROBE_SYMBOL(set_current_kprobe);
+
+static bool insns_are_not_simulated(struct kprobe *p, struct pt_regs *regs)
+{
+	if (is_branch_ins(&p->opcode)) {
+		simu_branch(regs, p->opcode);
+		return false;
+	} else if (is_pc_ins(&p->opcode)) {
+		simu_pc(regs, p->opcode);
+		return false;
+	} else {
+		return true;
+	}
+}
+NOKPROBE_SYMBOL(insns_are_not_simulated);
+
+static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
+			     struct kprobe_ctlblk *kcb, int reenter)
+{
+	if (reenter) {
+		save_previous_kprobe(kcb);
+		set_current_kprobe(p, regs, kcb);
+		kcb->kprobe_status = KPROBE_REENTER;
+	} else {
+		kcb->kprobe_status = KPROBE_HIT_SS;
+	}
+
+	if (p->ainsn.insn->word == breakpoint_insn.word) {
+		regs->csr_prmd &= ~CSR_PRMD_PIE;
+		regs->csr_prmd |= kcb->kprobe_saved_irq;
+		return;
+	}
+
+	regs->csr_prmd &= ~CSR_PRMD_PIE;
+
+	if (insns_are_not_simulated(p, regs)) {
+		kcb->kprobe_status = KPROBE_HIT_SS;
+		regs->csr_era = (unsigned long)&p->ainsn.insn[0];
+	} else {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		if (p->post_handler)
+			p->post_handler(p, regs, 0);
+		reset_current_kprobe();
+	}
+}
+NOKPROBE_SYMBOL(setup_singlestep);
+
+static bool reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
+			  struct kprobe_ctlblk *kcb)
+{
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SSDONE:
+	case KPROBE_HIT_ACTIVE:
+		kprobes_inc_nmissed_count(p);
+		setup_singlestep(p, regs, kcb, 1);
+		break;
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		pr_warn("Failed to recover from reentered kprobes.\n");
+		dump_kprobe(p);
+		BUG();
+		break;
+	default:
+		WARN_ON(1);
+		return false;
+	}
+
+	return true;
+}
+NOKPROBE_SYMBOL(reenter_kprobe);
+
+static bool kprobe_pre_handler(struct pt_regs *regs)
+{
+	struct kprobe *p, *cur_kprobe;
+	struct kprobe_ctlblk *kcb;
+	unsigned long addr = instruction_pointer(regs);
+
+	kcb = get_kprobe_ctlblk();
+	cur_kprobe = kprobe_running();
+
+	p = get_kprobe((kprobe_opcode_t *) addr);
+	if (p) {
+		if (cur_kprobe) {
+			if (reenter_kprobe(p, regs, kcb))
+				return true;
+		} else {
+			/* Probe hit */
+			set_current_kprobe(p, regs, kcb);
+			kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+
+			/*
+			 * If we have no pre-handler or it returned 0, we
+			 * continue with normal processing.  If we have a
+			 * pre-handler and it returned non-zero, it will
+			 * modify the execution path and no need to single
+			 * stepping. Let's just reset current kprobe and exit.
+			 *
+			 * pre_handler can hit a breakpoint and can step thru
+			 * before return.
+			 */
+			if (!p->pre_handler || !p->pre_handler(p, regs))
+				setup_singlestep(p, regs, kcb, 0);
+			else
+				reset_current_kprobe();
+		}
+		return true;
+	}
+
+	/*
+	 * The breakpoint instruction was removed right
+	 * after we hit it.  Another cpu has removed
+	 * either a probepoint or a debugger breakpoint
+	 * at this address.  In either case, no further
+	 * handling of this interrupt is appropriate.
+	 * Return back to original instruction, and continue.
+	 */
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_pre_handler);
+
+static bool kprobe_post_handler(struct pt_regs *regs)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (!cur)
+		return false;
+
+	/* Restore back the original saved kprobes variables and continue */
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		return true;
+	}
+
+	/* Call post handler */
+	kcb->kprobe_status = KPROBE_HIT_SSDONE;
+	if (cur->post_handler)
+		cur->post_handler(cur, regs, 0);
+
+	regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
+	regs->csr_prmd |= kcb->kprobe_saved_irq;
+
+	reset_current_kprobe();
+
+	return true;
+}
+NOKPROBE_SYMBOL(kprobe_post_handler);
+
+bool kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (kcb->kprobe_status & KPROBE_HIT_SS) {
+		regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
+		regs->csr_prmd |= kcb->kprobe_saved_irq;
+		reset_current_kprobe();
+	}
+
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_fault_handler);
+
+int kprobe_exceptions_notify(struct notifier_block *self,
+			     unsigned long val, void *data)
+{
+	struct die_args *args = (struct die_args *)data;
+	int ret = NOTIFY_DONE;
+
+	switch (val) {
+	case DIE_BREAK:
+		if (kprobe_pre_handler(args->regs))
+			ret = NOTIFY_STOP;
+		break;
+	case DIE_SSTEPBP:
+		if (kprobe_post_handler(args->regs))
+			ret = NOTIFY_STOP;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+NOKPROBE_SYMBOL(kprobe_exceptions_notify);
+
+/*
+ * Provide a blacklist of symbols identifying ranges which cannot be kprobed.
+ * This blacklist is exposed to userspace via debugfs (kprobes/blacklist).
+ */
+int __init arch_populate_kprobe_blacklist(void)
+{
+	return kprobe_add_area_blacklist((unsigned long)__irqentry_text_start,
+					 (unsigned long)__irqentry_text_end);
+}
+
+int __init arch_init_kprobes(void)
+{
+	return 0;
+}
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 1ccd536..5882f17 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -253,6 +253,9 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
+	if (kprobe_page_fault(regs, current->thread.trap_nr))
+		return;
+
 	/* Enable interrupt if enabled in parent context */
 	if (likely(regs->csr_prmd & CSR_PRMD_PIE))
 		local_irq_enable();
-- 
2.1.0

