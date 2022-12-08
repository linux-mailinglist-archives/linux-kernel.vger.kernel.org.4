Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7DC6469D0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:41:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLHHlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:41:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbiLHHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:41:29 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63EDD47308
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 23:41:27 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8AxRPAmlZFjlg0EAA--.9495S3;
        Thu, 08 Dec 2022 15:41:26 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPuAjlZFjn8gnAA--.32821S4;
        Thu, 08 Dec 2022 15:41:26 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v8 2/4] LoongArch: Add kprobe support
Date:   Thu,  8 Dec 2022 15:41:11 +0800
Message-Id: <1670485273-15717-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1670485273-15717-1-git-send-email-yangtiezhu@loongson.cn>
References: <1670485273-15717-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxPuAjlZFjn8gnAA--.32821S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3KryUtF43CF1rZw1xJr1fWFg_yoW8Gw4UJo
        WSvF4DWw48Kr47uF45Ar1kXFWUu3W8KFZ5Aryaywsxur1DAr18Xr1UCrW8J3W2qrsYgw4f
        u34Y9a4fGFW3Crnxn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
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
        cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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
 arch/loongarch/include/asm/inst.h    |  15 ++
 arch/loongarch/include/asm/kprobes.h |  59 +++++++
 arch/loongarch/kernel/Makefile       |   2 +
 arch/loongarch/kernel/kprobes.c      | 309 +++++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/traps.c        |  13 +-
 arch/loongarch/mm/fault.c            |   3 +
 7 files changed, 398 insertions(+), 4 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kprobes.h
 create mode 100644 arch/loongarch/kernel/kprobes.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 16bf1b6..f6fc156 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -102,6 +102,7 @@ config LOONGARCH
 	select HAVE_IOREMAP_PROT
 	select HAVE_IRQ_EXIT_ON_IRQ_STACK
 	select HAVE_IRQ_TIME_ACCOUNTING
+	select HAVE_KPROBES
 	select HAVE_MOD_ARCH_SPECIFIC
 	select HAVE_NMI
 	select HAVE_PCI
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index a91798b..42984d5 100644
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
@@ -335,6 +345,11 @@ static inline bool is_branch_ins(union loongarch_instruction *ip)
 		ip->reg1i21_format.opcode <= bgeu_op;
 }
 
+static inline bool is_break_ins(union loongarch_instruction *ip)
+{
+	return ip->reg0i15_format.opcode == break_op;
+}
+
 static inline bool is_ra_save_ins(union loongarch_instruction *ip)
 {
 	/* st.d $ra, $sp, offset */
diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/include/asm/kprobes.h
new file mode 100644
index 0000000..d3903f3
--- /dev/null
+++ b/arch/loongarch/include/asm/kprobes.h
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef __ASM_LOONGARCH_KPROBES_H
+#define __ASM_LOONGARCH_KPROBES_H
+
+#include <asm-generic/kprobes.h>
+#include <asm/cacheflush.h>
+
+#ifdef CONFIG_KPROBES
+
+#include <asm/inst.h>
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
+bool kprobe_breakpoint_handler(struct pt_regs *regs);
+bool kprobe_singlestep_handler(struct pt_regs *regs);
+
+#else /* !CONFIG_KPROBES */
+
+static inline bool kprobe_breakpoint_handler(struct pt_regs *regs) { return 0; }
+static inline bool kprobe_singlestep_handler(struct pt_regs *regs) { return 0; }
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
index 0000000..a296f2d
--- /dev/null
+++ b/arch/loongarch/kernel/kprobes.c
@@ -0,0 +1,309 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kprobes.h>
+#include <linux/kdebug.h>
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
+static bool insns_are_not_supported(union loongarch_instruction insn)
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
+	regs->csr_prmd &= ~CSR_PRMD_PIE;
+
+	if (p->ainsn.insn->word == breakpoint_insn.word) {
+		regs->csr_prmd |= kcb->kprobe_saved_irq;
+		preempt_enable_no_resched();
+		return;
+	}
+
+	if (insns_are_not_simulated(p, regs)) {
+		kcb->kprobe_status = KPROBE_HIT_SS;
+		regs->csr_era = (unsigned long)&p->ainsn.insn[0];
+	} else {
+		kcb->kprobe_status = KPROBE_HIT_SSDONE;
+		if (p->post_handler)
+			p->post_handler(p, regs, 0);
+		reset_current_kprobe();
+		preempt_enable_no_resched();
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
+			if (!p->pre_handler || !p->pre_handler(p, regs)) {
+				setup_singlestep(p, regs, kcb, 0);
+				return true;
+			} else {
+				reset_current_kprobe();
+				preempt_enable_no_resched();
+				return true;
+			}
+		}
+	}
+
+	if (!is_break_ins(addr)) {
+		/*
+		 * The breakpoint instruction was removed right
+		 * after we hit it.  Another cpu has removed
+		 * either a probepoint or a debugger breakpoint
+		 * at this address.  In either case, no further
+		 * handling of this interrupt is appropriate.
+		 * Return back to original instruction, and continue.
+		 */
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
+
+	if (!cur)
+		return false;
+
+	/* Restore back the original saved kprobes variables and continue */
+	if (kcb->kprobe_status == KPROBE_REENTER) {
+		restore_previous_kprobe(kcb);
+		goto out;
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
+out:
+	preempt_enable_no_resched();
+	return true;
+}
+NOKPROBE_SYMBOL(kprobe_singlestep_handler);
+
+bool kprobe_fault_handler(struct pt_regs *regs, int trapnr)
+{
+	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
+
+	if (kcb->kprobe_status & KPROBE_HIT_SS) {
+		regs->csr_era = kcb->kprobe_saved_era + LOONGARCH_INSN_SIZE;
+		regs->csr_prmd |= kcb->kprobe_saved_irq;
+
+		reset_current_kprobe();
+		preempt_enable_no_resched();
+	}
+
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
index a19bb32..4d9f775 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -448,14 +448,12 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
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
@@ -479,6 +477,13 @@ asmlinkage void noinstr do_bp(struct pt_regs *regs)
 			break;
 	}
 
+	if (bcode == BRK_KPROBE_BP) {
+		if (__get_inst(&opcode, (u32 *)era, user))
+			goto out_sigsegv;
+
+		bcode = (opcode & 0x7fff);
+	}
+
 	switch (bcode) {
 	case BRK_BUG:
 		bug_handler(regs);
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

