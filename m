Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C0863B7A4
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 03:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiK2CDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 21:03:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbiK2CDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 21:03:10 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 02DEC95B8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 18:03:05 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Dx9vBYaIVjMeIBAA--.4472S3;
        Tue, 29 Nov 2022 10:03:04 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxPuBUaIVjPdsdAA--.10463S4;
        Tue, 29 Nov 2022 10:03:04 +0800 (CST)
From:   Tiezhu Yang <yangtiezhu@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/4] LoongArch: Add kprobe support
Date:   Tue, 29 Nov 2022 10:02:52 +0800
Message-Id: <1669687374-16432-3-git-send-email-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1669687374-16432-1-git-send-email-yangtiezhu@loongson.cn>
References: <1669687374-16432-1-git-send-email-yangtiezhu@loongson.cn>
X-CM-TRANSID: AQAAf8AxPuBUaIVjPdsdAA--.10463S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3KryUtF43CF1rZw1xJr1fWFg_yoW8Xr1rAo
        WSvF4DXw48Gr47uF45Ar1kXFWUu3W8KFZ5Aryayanxur1kAr1rXr1UC3y8J3W2qrsYgw4f
        u34Y9w1fGFW3Crnxn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUkIb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
        JwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFc
        xC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_
        Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMx
        C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
        wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
        vE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v2
        0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
        W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8l38UUUUUU==
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
 arch/loongarch/include/asm/inst.h    |  10 ++
 arch/loongarch/include/asm/kprobes.h |  65 +++++++
 arch/loongarch/kernel/Makefile       |   2 +
 arch/loongarch/kernel/kprobes.c      | 326 +++++++++++++++++++++++++++++++++++
 arch/loongarch/kernel/traps.c        |   6 +-
 arch/loongarch/mm/fault.c            |   4 +
 7 files changed, 410 insertions(+), 4 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kprobes.h
 create mode 100644 arch/loongarch/kernel/kprobes.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 5c4f1dc..925d46d 100644
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
index a91798b..f5fb2be 100644
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
diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/include/asm/kprobes.h
new file mode 100644
index 0000000..e2d0729
--- /dev/null
+++ b/arch/loongarch/include/asm/kprobes.h
@@ -0,0 +1,65 @@
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
+struct patch_insn {
+	void *addr;
+	union loongarch_instruction insn;
+	atomic_t cpu_count;
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
index 27a5b62..a87b7f5 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -47,4 +47,6 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
 
+obj-$(CONFIG_KPROBES)		+= kprobes.o
+
 CPPFLAGS_vmlinux.lds		:= $(KBUILD_CFLAGS)
diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kprobes.c
new file mode 100644
index 0000000..d01ecb2
--- /dev/null
+++ b/arch/loongarch/kernel/kprobes.c
@@ -0,0 +1,326 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/kprobes.h>
+#include <linux/kdebug.h>
+#include <linux/preempt.h>
+#include <linux/stop_machine.h>
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
+static int patch_text_cb(void *data)
+{
+	struct patch_insn *param = data;
+	int ret = 0;
+
+	if (atomic_inc_return(&param->cpu_count) == num_online_cpus()) {
+		ret = larch_insn_patch_text(param->addr, param->insn.word);
+		atomic_inc(&param->cpu_count);
+	} else {
+		while (atomic_read(&param->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		smp_mb();
+	}
+
+	return ret;
+}
+NOKPROBE_SYMBOL(patch_text_cb);
+
+static int patch_text(void *addr, union loongarch_instruction insn)
+{
+	struct patch_insn param = { addr, insn, ATOMIC_INIT(0) };
+
+	return stop_machine_cpuslocked(patch_text_cb, &param, cpu_online_mask);
+}
+NOKPROBE_SYMBOL(patch_text);
+
+/* Install breakpoint in text */
+void arch_arm_kprobe(struct kprobe *p)
+{
+	patch_text(p->addr, breakpoint_insn);
+}
+NOKPROBE_SYMBOL(arch_arm_kprobe);
+
+/* Remove breakpoint from text */
+void arch_disarm_kprobe(struct kprobe *p)
+{
+	patch_text(p->addr, p->opcode);
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
+		preempt_enable_no_resched();
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
+	struct kprobe *p, *cur_kprobe;
+	struct kprobe_ctlblk *kcb;
+	unsigned long addr = instruction_pointer(regs);
+
+	preempt_disable();
+	kcb = get_kprobe_ctlblk();
+	cur_kprobe = kprobe_running();
+
+	p = get_kprobe((kprobe_opcode_t *)addr);
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
+			} else {
+				reset_current_kprobe();
+				preempt_enable_no_resched();
+			}
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
+
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
index 7ea62fa..8525446 100644
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
diff --git a/arch/loongarch/mm/fault.c b/arch/loongarch/mm/fault.c
index 1ccd536..fc9225a 100644
--- a/arch/loongarch/mm/fault.c
+++ b/arch/loongarch/mm/fault.c
@@ -253,12 +253,16 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs,
 {
 	irqentry_state_t state = irqentry_enter(regs);
 
+	if (kprobe_page_fault(regs, current->thread.trap_nr))
+		goto out;
+
 	/* Enable interrupt if enabled in parent context */
 	if (likely(regs->csr_prmd & CSR_PRMD_PIE))
 		local_irq_enable();
 
 	__do_page_fault(regs, write, address);
 
+out:
 	local_irq_disable();
 
 	irqentry_exit(regs, state);
-- 
2.1.0

