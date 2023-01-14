Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E15066AA6E
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 10:28:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjANJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Jan 2023 04:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjANJ1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 04:27:38 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A5D86EBE
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 01:27:35 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Cx+emGdcJjaJ0BAA--.5066S3;
        Sat, 14 Jan 2023 17:27:34 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Bxb+SBdcJjcVYZAA--.11667S4;
        Sat, 14 Jan 2023 17:27:33 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/6] LoongArch: Add kprobe support
Date:   Sat, 14 Jan 2023 17:27:20 +0800
Message-Id: <1673688444-24251-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn>
References: <1673688444-24251-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8Bxb+SBdcJjcVYZAA--.11667S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3Kry8GF4kAr4kJr13Jr4Utwb_yoW8WFW5Jo
        WSvF4DWw40gr4IgFWFyF1kJF1Uu3W0gFZ5AryFyFsxuw1kAr1rXr17Cr4rJa42qr4Fgw4x
        u345Zw1fGrZ3CFnxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWx
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I
        8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
        xVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
        AFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kprobe allows you to trap at almost any kernel address and execute a
callback function, this commit adds kprobe support for LoongArch.

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 arch/loongarch/Kconfig               |   1 +
 arch/loongarch/include/asm/inst.h    |  15 ++
 arch/loongarch/include/asm/kprobes.h |  58 ++++++
 arch/loongarch/kernel/Makefile       |   2 +
 arch/loongarch/kernel/kprobes.c      | 378 +++++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/traps.c        |  11 +-
 arch/loongarch/mm/fault.c            |   3 +
 7 files changed, 463 insertions(+), 5 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kprobes.h
 create mode 100644 arch/loongarch/kernel/kprobes.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 9be74ec..ce930f2 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -103,6 +103,7 @@ config LOONGARCH
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_KPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_PCI
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index c83cfb7..e0771d2 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -24,6 +24,10 @@
 
 #define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >> ADDR_IMMSHIFT_##INSN)
 
+enum reg0i15_op {
+	break_op	= 0x54,
+};
+
 enum reg0i26_op {
 	b_op		= 0x14,
 	bl_op		= 0x15,
@@ -180,6 +184,11 @@ enum reg3sa2_op {
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
@@ -265,6 +274,7 @@ struct reg3sa2_format {
 
 union loongarch_instruction {
 	unsigned int word;
+	struct reg0i15_format	reg0i15_format;
 	struct reg0i26_format	reg0i26_format;
 	struct reg1i20_format	reg1i20_format;
 	struct reg1i21_format	reg1i21_format;
@@ -323,6 +333,11 @@ static inline bool is_imm_negative(unsigned long val, unsigned int bit)
 	return val & (1UL << (bit - 1));
 }
 
+static inline bool is_break_ins(union loongarch_instruction *ip)
+{
+	return ip->reg0i15_format.opcode == break_op;
+}
+
 static inline bool is_pc_ins(union loongarch_instruction *ip)
 {
 	return ip->reg1i20_format.opcode >= pcaddi_op &&
diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/include/asm/kprobes.h
new file mode 100644
index 0000000..7b9fc3e
--- /dev/null
+++ b/arch/loongarch/include/asm/kprobes.h
@@ -0,0 +1,58 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_LOONGARCH_KPROBES_H
+#define __ASM_LOONGARCH_KPROBES_H
+
+#include <asm-generic/kprobes.h>
+
+#ifdef CONFIG_KPROBES
+
+#include <asm/inst.h>
+#include <asm/cacheflush.h>
+
+#define __ARCH_WANT_KPROBES_INSN_SLOT
+#define MAX_INSN_SIZE			2
+
+#define flush_insn_slot(p)						\
+do {									\
+	if (p->addr)							\
+		flush_icache_range((unsigned long)p->addr,		\
+			   (unsigned long)p->addr +			\
+			   (MAX_INSN_SIZE * sizeof(kprobe_opcode_t)));	\
+} while (0)
+
+#define kretprobe_blacklist_size	0
+
+typedef union loongarch_instruction kprobe_opcode_t;
+
+/* Architecture specific copy of original instruction */
+struct arch_specific_insn {
+	/* copy of the original instruction */
+	kprobe_opcode_t *insn;
+	/* restore address after simulation */
+	unsigned long restore;
+};
+
+struct prev_kprobe {
+	struct kprobe *kp;
+	unsigned int status;
+};
+
+/* per-cpu kprobe control block */
+struct kprobe_ctlblk {
+	unsigned int kprobe_status;
+	unsigned long saved_status;
+	struct prev_kprobe prev_kprobe;
+};
+
+void arch_remove_kprobe(struct kprobe *p);
+bool kprobe_fault_handler(struct pt_regs *regs, int trapnr);
+bool kprobe_breakpoint_handler(struct pt_regs *regs);
+bool kprobe_singlestep_handler(struct pt_regs *regs);
+
+#else /* !CONFIG_KPROBES */
+
+static inline bool kprobe_breakpoint_handler(struct pt_regs *regs) { return false; }
+static inline bool kprobe_singlestep_handler(struct pt_regs *regs) { return false; }
+
+#endif /* CONFIG_KPROBES */
+#endif /* __ASM_LOONGARCH_KPROBES_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index fcaa024..6fe4a4e 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -47,4 +47,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
 
+obj-$(CONFIG_KPROBES)		+= kprobes.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
new file mode 100644
index 0000000..a0c2f9d
--- /dev/null
+++ b/arch/loongarch/kernel/kprobes.c
@@ -0,0 +1,378 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kdebug.h>
+#include <linux/kprobes.h>
+#include <linux/preempt.h>
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
+static void post_kprobe_handler(struct kprobe *, struct kprobe_ctlblk *, struct pt_regs *);
+
+static bool insns_not_supported(union loongarch_instruction insn)
+{
+	switch (insn.reg2i14_format.opcode) {
+	case llw_op:
+	case lld_op:
+	case scw_op:
+	case scd_op:
+		pr_notice("kprobe: ll and sc instructions are not supported\n");
+		return true;
+	}
+
+	switch (insn.reg1i21_format.opcode) {
+	case bceqz_op:
+		pr_notice("kprobe: bceqz and bcnez instructions are not supported\n");
+		return true;
+	}
+
+	return false;
+}
+NOKPROBE_SYMBOL(insns_not_supported);
+
+static bool insn_need_simulation(struct kprobe *p)
+{
+	if (is_pc_ins(&p->opcode))
+		return true;
+
+	if (is_branch_ins(&p->opcode))
+		return true;
+
+	return false;
+}
+NOKPROBE_SYMBOL(insn_need_simulation);
+
+static void arch_simulate_insn(struct kprobe *p, struct pt_regs *regs)
+{
+	if (is_pc_ins(&p->opcode))
+		simu_pc(regs, p->opcode);
+	else if (is_branch_ins(&p->opcode))
+		simu_branch(regs, p->opcode);
+}
+NOKPROBE_SYMBOL(arch_simulate_insn);
+
+static void arch_prepare_ss_slot(struct kprobe *p)
+{
+	p->ainsn.insn[0] = *p->addr;
+	p->ainsn.insn[1] = singlestep_insn;
+	p->ainsn.restore = (unsigned long)p->addr + LOONGARCH_INSN_SIZE;
+}
+NOKPROBE_SYMBOL(arch_prepare_ss_slot);
+
+static void arch_prepare_simulate(struct kprobe *p)
+{
+	p->ainsn.restore = 0;
+}
+NOKPROBE_SYMBOL(arch_prepare_simulate);
+
+int arch_prepare_kprobe(struct kprobe *p)
+{
+	/* copy instruction */
+	p->opcode = *p->addr;
+
+	/* decode instruction */
+	if (insns_not_supported(p->opcode))
+		return -EINVAL;
+
+	if (insn_need_simulation(p)) {
+		p->ainsn.insn = NULL;
+	} else {
+		p->ainsn.insn = get_insn_slot();
+		if (!p->ainsn.insn)
+			return -ENOMEM;
+	}
+
+	/* prepare the instruction */
+	if (p->ainsn.insn)
+		arch_prepare_ss_slot(p);
+	else
+		arch_prepare_simulate(p);
+
+	return 0;
+}
+NOKPROBE_SYMBOL(arch_prepare_kprobe);
+
+/* Install breakpoint in text */
+void arch_arm_kprobe(struct kprobe *p)
+{
+	*p->addr = breakpoint_insn;
+	flush_insn_slot(p);
+}
+NOKPROBE_SYMBOL(arch_arm_kprobe);
+
+/* Remove breakpoint from text */
+void arch_disarm_kprobe(struct kprobe *p)
+{
+	*p->addr = p->opcode;
+	flush_insn_slot(p);
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
+}
+NOKPROBE_SYMBOL(save_previous_kprobe);
+
+static void restore_previous_kprobe(struct kprobe_ctlblk *kcb)
+{
+	__this_cpu_write(current_kprobe, kcb->prev_kprobe.kp);
+	kcb->kprobe_status = kcb->prev_kprobe.status;
+}
+NOKPROBE_SYMBOL(restore_previous_kprobe);
+
+static void set_current_kprobe(struct kprobe *p)
+{
+	__this_cpu_write(current_kprobe, p);
+}
+NOKPROBE_SYMBOL(set_current_kprobe);
+
+/*
+ * Interrupts need to be disabled before single-step mode is set,
+ * and not reenabled until after single-step mode ends.
+ * Without disabling interrupt on local CPU, there is a chance of
+ * interrupt occurrence in the period of exception return and start
+ * of out-of-line single-step, that result in wrongly single stepping
+ * into the interrupt handler.
+ */
+static void save_local_irqflag(struct kprobe_ctlblk *kcb,
+			       struct pt_regs *regs)
+{
+	kcb->saved_status = regs->csr_prmd;
+	regs->csr_prmd &= ~CSR_PRMD_PIE;
+}
+NOKPROBE_SYMBOL(save_local_irqflag);
+
+static void restore_local_irqflag(struct kprobe_ctlblk *kcb,
+				  struct pt_regs *regs)
+{
+	regs->csr_prmd = kcb->saved_status;
+}
+NOKPROBE_SYMBOL(restore_local_irqflag);
+
+static void setup_singlestep(struct kprobe *p, struct pt_regs *regs,
+			     struct kprobe_ctlblk *kcb, int reenter)
+{
+	if (reenter) {
+		save_previous_kprobe(kcb);
+		set_current_kprobe(p);
+		kcb->kprobe_status = KPROBE_REENTER;
+	} else {
+		kcb->kprobe_status = KPROBE_HIT_SS;
+	}
+
+	if (p->ainsn.insn) {
+		/* IRQs and single stepping do not mix well */
+		save_local_irqflag(kcb, regs);
+		/* set ip register to prepare for single stepping */
+		regs->csr_era = (unsigned long)p->ainsn.insn;
+	} else {
+		/* simulate single steping */
+		arch_simulate_insn(p, regs);
+		/* now go for post processing */
+		post_kprobe_handler(p, kcb, regs);
+	}
+}
+NOKPROBE_SYMBOL(setup_singlestep);
+
+static bool reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
+			   struct kprobe_ctlblk *kcb)
+{
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SSDONE:
+	case KPROBE_HIT_ACTIVE:
+	case KPROBE_HIT_SS:
+		kprobes_inc_nmissed_count(p);
+		setup_singlestep(p, regs, kcb, 1);
+		break;
+	case KPROBE_REENTER:
+		pr_warn("Failed to recover from reentered kprobes.\n");
+		dump_kprobe(p);
+		WARN_ON_ONCE(1);
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
+static void post_kprobe_handler(struct kprobe *cur, struct kprobe_ctlblk *kcb,
+				struct pt_regs *regs)
+{
+	/* return addr restore if non-branching insn */
+	if (cur->ainsn.restore != 0)
+		instruction_pointer_set(regs, cur->ainsn.restore);
+
+	/* restore back original saved kprobe variables and continue */
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		preempt_enable_no_resched();
+		return;
+	}
+
+	/*
+	 * update the kcb status even if the cur->post_handler is
+	 * not set because reset_curent_kprobe() doesn't update kcb.
+	 */
+	kcb->kprobe_status = KPROBE_HIT_SSDONE;
+	if (cur->post_handler)
+		cur->post_handler(cur, regs, 0);
+
+	reset_current_kprobe();
+	preempt_enable_no_resched();
+}
+NOKPROBE_SYMBOL(post_kprobe_handler);
+
+bool kprobe_breakpoint_handler(struct pt_regs *regs)
+{
+	struct kprobe_ctlblk *kcb;
+	struct kprobe *p, *cur_kprobe;
+	kprobe_opcode_t *addr = (kprobe_opcode_t *)regs->csr_era;
+
+	/*
+	 * We don't want to be preempted for the entire
+	 * duration of kprobe processing.
+	 */
+	preempt_disable();
+	kcb = get_kprobe_ctlblk();
+	cur_kprobe = kprobe_running();
+
+	p = get_kprobe(addr);
+	if (p) {
+		if (cur_kprobe) {
+			if (reenter_kprobe(p, regs, kcb))
+				return true;
+		} else {
+			/* Probe hit */
+			set_current_kprobe(p);
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
+			if (!p->pre_handler || !p->pre_handler(p, regs)) {
+				setup_singlestep(p, regs, kcb, 0);
+			} else {
+				reset_current_kprobe();
+				preempt_enable_no_resched();
+			}
+			return true;
+		}
+	}
+
+	if (addr->word != breakpoint_insn.word) {
+		/*
+		 * The breakpoint instruction was removed right
+		 * after we hit it.  Another cpu has removed
+		 * either a probepoint or a debugger breakpoint
+		 * at this address.  In either case, no further
+		 * handling of this interrupt is appropriate.
+		 * Return back to original instruction, and continue.
+		 */
+		regs->csr_era = (unsigned long)addr;
+		preempt_enable_no_resched();
+		return true;
+	}
+
+	preempt_enable_no_resched();
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_breakpoint_handler);
+
+bool kprobe_singlestep_handler(struct pt_regs *regs)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+	unsigned long addr = instruction_pointer(regs);
+
+	if (cur && (kcb->kprobe_status & (KPROBE_HIT_SS | KPROBE_REENTER)) &&
+	    ((unsigned long)&cur->ainsn.insn[1] == addr)) {
+		restore_local_irqflag(kcb, regs);
+		post_kprobe_handler(cur, kcb, regs);
+		return true;
+	}
+
+	preempt_enable_no_resched();
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_singlestep_handler);
+
+bool kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	struct kprobe *cur = kprobe_running();
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	switch (kcb->kprobe_status) {
+	case KPROBE_HIT_SS:
+	case KPROBE_REENTER:
+		/*
+		 * We are here because the instruction being single
+		 * stepped caused a page fault. We reset the current
+		 * kprobe and the ip points back to the probe address
+		 * and allow the page fault handler to continue as a
+		 * normal page fault.
+		 */
+		regs->csr_era = (unsigned long)cur->addr;
+		WARN_ON_ONCE(!instruction_pointer(regs));
+
+		if (kcb->kprobe_status == KPROBE_REENTER) {
+			restore_previous_kprobe(kcb);
+		} else {
+			restore_local_irqflag(kcb, regs);
+			reset_current_kprobe();
+		}
+		preempt_enable_no_resched();
+		break;
+	}
+	return false;
+}
+NOKPROBE_SYMBOL(kprobe_fault_handler);
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
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index a19bb32..5af6475 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -435,7 +435,10 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
 	unsigned long era = exception_era(regs);
 	irqentry_state_t state = irqentry_enter(regs);
 
-	local_irq_enable();
+	/* Enable interrupt if enabled in parent context */
+	if (likely(regs->csr_prmd & CSR_PRMD_PIE))
+		local_irq_enable();
+
 	current->thread.trap_nr = read_csr_excode();
 	if (__get_inst(&opcode, (u32 *)era, user))
 		goto out_sigsegv;
@@ -448,14 +451,12 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
 	 */
 	switch (bcode) {
 	case BRK_KPROBE_BP:
-		if (notify_die(DIE_BREAK, "Kprobe", regs, bcode,
-			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
+		if (kprobe_breakpoint_handler(regs))
 			goto out;
 		else
 			break;
 	case BRK_KPROBE_SSTEPBP:
-		if (notify_die(DIE_SSTEPBP, "Kprobe_SingleStep", regs, bcode,
-			       current->thread.trap_nr, SIGTRAP) == NOTIFY_STOP)
+		if (kprobe_singlestep_handler(regs))
 			goto out;
 		else
 			break;
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 1ccd536..449087b 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -135,6 +135,9 @@ static void __kprobes __do_page_fault(struct pt_regs *regs,
 	struct vm_area_struct *vma = NULL;
 	vm_fault_t fault;
 
+	if (kprobe_page_fault(regs, current->thread.trap_nr))
+		return;
+
 	/*
 	 * We fault-in kernel-space virtual memory on-demand. The
 	 * 'reference' page table is init_mm.pgd.
-- 
2.1.0

