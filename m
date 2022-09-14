Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 602675B7F37
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiINDOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiINDOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:14:30 -0400
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 842DF6CF5B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 20:14:25 -0700 (PDT)
Received: from cgk-Precision-3650-Tower.. (unknown [123.114.53.210])
        by APP-05 (Coremail) with SMTP id zQCowAD3_ZX5RiFjnMZ9Ag--.16550S4;
        Wed, 14 Sep 2022 11:14:01 +0800 (CST)
From:   Chen Guokai <chenguokai17@mails.ucas.ac.cn>
To:     paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, rostedt@goodmis.org, mingo@redhat.com,
        sfr@canb.auug.org.au
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        liaochang1@huawei.com, Chen Guokai <chenguokai17@mails.ucas.ac.cn>
Subject: [PATCH v2] riscv: kprobes: implement optprobes
Date:   Wed, 14 Sep 2022 11:13:59 +0800
Message-Id: <20220914031359.593629-1-chenguokai17@mails.ucas.ac.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowAD3_ZX5RiFjnMZ9Ag--.16550S4
X-Coremail-Antispam: 1UD129KBjvAXoWfCr4xJrW5Ary7Gr1fArWDJwb_yoW5Gw48Wo
        WIga1DX34rtF4I9ayFk3s7GrW8u34kKr95Ar45Kr4ruF18CrW5Xr90k3yrZa4Fqr40g3yr
        ZrW7WryrXFZ5ZF15n29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUUYq7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20EY4v20xva
        j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2
        x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8
        JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
        Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Gr0_Cr
        1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
        rcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
        kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
        67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCw
        CI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E
        3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
        nIWIevJa73UjIFyTuYvjfUOxhLUUUUU
X-Originating-IP: [123.114.53.210]
X-CM-SenderInfo: xfkh0w5xrntxyrx6ztxlovh3xfdvhtffof0/1tbiCgEJE2KY1r-HDAAAsJ
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add jump optimization support for RISC-V.

Replaces ebreak instructions used by normal kprobes with an
auipc+jalr instruction pair, at the aim of suppressing the probe-hit
overhead.

All known optprobe-capable RISC architectures have been using a single
jump or branch instructions while this patch chooses not. RISC-V has a
quite limited jump range (4KB or 2MB) for both its branch and jump
instructions, which prevent optimizations from supporting probes that
spread all over the kernel.

Auipc-jalr instruction pair is introduced with a much wider jump range
(4GB), where auipc loads the upper 12 bits to a free register and jalr
appends the lower 20 bits to form a 32 bit immediate. Note that returning
from probe handler requires another free register. As kprobes can appear
almost anywhere inside the kernel, the free register should be found in a
generic way, not depending on calling convention or any other regulations.

The algorithm for finding the free register is inspired by the register
renaming in modern processors. From the perspective of register renaming, a
register could be represented as two different registers if two neighbour
instructions both write to it but no one ever reads. Extending this fact,
a register is considered to be free if there is no read before its next
write in the execution flow. We are free to change its value without
interfering normal execution.

Static analysis shows that 51% instructions of the kernel (default config)
is capable of being replaced i.e. two free registers can be found at both
the start and end of replaced instruction pairs while the replaced
instructions can be directly executed.

Signed-off-by: Chen Guokai <chenguokai17@mails.ucas.ac.cn>
---
v2:
1. Adjusted comments
2. Removed improper copyright infos
3. Cleaned up format issues that is not common practice
4. Extracted common defines of instruction decoding
5. Fixed SMP race
---
 arch/riscv/Kconfig                        |   1 +
 arch/riscv/include/asm/ftrace.h           |   2 +-
 arch/riscv/include/asm/kprobes.h          |  31 ++
 arch/riscv/kernel/probes/Makefile         |   1 +
 arch/riscv/kernel/probes/opt.c            | 517 ++++++++++++++++++++++
 arch/riscv/kernel/probes/opt_trampoline.S | 132 ++++++
 arch/riscv/kernel/probes/simulate-insn.c  |   9 -
 arch/riscv/kernel/probes/simulate-insn.h  |  25 ++
 8 files changed, 708 insertions(+), 10 deletions(-)
 create mode 100644 arch/riscv/kernel/probes/opt.c
 create mode 100644 arch/riscv/kernel/probes/opt_trampoline.S

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index d557cc502..efaedf29b 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -97,6 +97,7 @@ config RISCV
 	select HAVE_KPROBES if !XIP_KERNEL
 	select HAVE_KPROBES_ON_FTRACE if !XIP_KERNEL
 	select HAVE_KRETPROBES if !XIP_KERNEL
+	select HAVE_OPTPROBES if !XIP_KERNEL && !RISCV_ISA_C
 	select HAVE_MOVE_PMD
 	select HAVE_MOVE_PUD
 	select HAVE_PCI
diff --git a/arch/riscv/include/asm/ftrace.h b/arch/riscv/include/asm/ftrace.h
index 04dad3380..8b17a4c66 100644
--- a/arch/riscv/include/asm/ftrace.h
+++ b/arch/riscv/include/asm/ftrace.h
@@ -35,7 +35,7 @@ struct dyn_arch_ftrace {
 };
 #endif
 
-#ifdef CONFIG_DYNAMIC_FTRACE
+#if defined(CONFIG_DYNAMIC_FTRACE) || defined(CONFIG_OPTPROBES)
 /*
  * A general call in RISC-V is a pair of insts:
  * 1) auipc: setting high-20 pc-related bits to ra register
diff --git a/arch/riscv/include/asm/kprobes.h b/arch/riscv/include/asm/kprobes.h
index 217ef89f2..fb9d93627 100644
--- a/arch/riscv/include/asm/kprobes.h
+++ b/arch/riscv/include/asm/kprobes.h
@@ -43,5 +43,36 @@ bool kprobe_single_step_handler(struct pt_regs *regs);
 void __kretprobe_trampoline(void);
 void __kprobes *trampoline_probe_handler(struct pt_regs *regs);
 
+#ifdef CONFIG_OPTPROBES
+
+/* optinsn template addresses */
+extern __visible kprobe_opcode_t optprobe_template_entry[];
+extern __visible kprobe_opcode_t optprobe_template_val[];
+extern __visible kprobe_opcode_t optprobe_template_call[];
+extern __visible kprobe_opcode_t optprobe_template_store_epc[];
+extern __visible kprobe_opcode_t optprobe_template_end[];
+extern __visible kprobe_opcode_t optprobe_template_sub_sp[];
+extern __visible kprobe_opcode_t optprobe_template_add_sp[];
+extern __visible kprobe_opcode_t optprobe_template_restore_begin[];
+extern __visible kprobe_opcode_t optprobe_template_restore_orig_insn[];
+extern __visible kprobe_opcode_t optprobe_template_restore_end[];
+
+#define MAX_OPTINSN_SIZE				\
+		((unsigned long)optprobe_template_end -	\
+		 (unsigned long)optprobe_template_entry)
+
+#define MAX_COPIED_INSN 2
+#define MAX_OPTIMIZED_LENGTH  (MAX_COPIED_INSN * 4)
+#define JUMP_SIZE             MAX_OPTIMIZED_LENGTH
+
+struct arch_optimized_insn {
+	kprobe_opcode_t copied_insn[MAX_COPIED_INSN];
+	/* detour code buffer */
+	kprobe_opcode_t *insn;
+};
+
+#define RVI_INST_SIZE 4
+
+#endif /* CONFIG_OPTPROBES */
 #endif /* CONFIG_KPROBES */
 #endif /* _ASM_RISCV_KPROBES_H */
diff --git a/arch/riscv/kernel/probes/Makefile b/arch/riscv/kernel/probes/Makefile
index 7f0840dcc..6255b4600 100644
--- a/arch/riscv/kernel/probes/Makefile
+++ b/arch/riscv/kernel/probes/Makefile
@@ -3,4 +3,5 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o simulate-insn.o
 obj-$(CONFIG_KPROBES)		+= kprobes_trampoline.o
 obj-$(CONFIG_KPROBES_ON_FTRACE)	+= ftrace.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o simulate-insn.o
+obj-$(CONFIG_OPTPROBES)		+= opt.o opt_trampoline.o
 CFLAGS_REMOVE_simulate-insn.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/riscv/kernel/probes/opt.c b/arch/riscv/kernel/probes/opt.c
new file mode 100644
index 000000000..ba4e8d0bf
--- /dev/null
+++ b/arch/riscv/kernel/probes/opt.c
@@ -0,0 +1,517 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ *  Kernel Probes Jump Optimization (Optprobes)
+ *
+ * Copyright (C) IBM Corporation, 2002, 2004
+ * Copyright (C) Hitachi Ltd., 2012
+ * Copyright (C) Huawei Inc., 2014
+ * Copyright (C) Guokai Chen, 2022
+ * Author: Guokai Chen chenguokai17@mails.ucas.ac.cn
+ */
+
+#include <linux/kprobes.h>
+#include <linux/jump_label.h>
+#include <linux/extable.h>
+#include <linux/stop_machine.h>
+#include <linux/moduleloader.h>
+#include <linux/kprobes.h>
+#include <linux/cacheflush.h>
+/* for patch_text */
+#include <linux/ftrace.h>
+#include <asm/patch.h>
+#include "simulate-insn.h"
+#include "decode-insn.h"
+
+/*
+ * If the probed instruction doesn't use PC and is not system or fence
+ * we can copy it into template and have it executed directly without
+ * simulation or emulation.
+ */
+static enum probe_insn __kprobes can_kprobe_direct_exec(kprobe_opcode_t *addr)
+{
+	/*
+	 * instructions that use PC like: branch jump auipc
+	 * instructions that belongs to system or fence like ebreak ecall fence.i
+	 */
+	kprobe_opcode_t inst = *addr;
+
+	RISCV_INSN_REJECTED(system, inst);
+	RISCV_INSN_REJECTED(fence, inst);
+	RISCV_INSN_REJECTED(branch, inst);
+	RISCV_INSN_REJECTED(jal, inst);
+	RISCV_INSN_REJECTED(jalr, inst);
+	RISCV_INSN_REJECTED(auipc, inst);
+	return INSN_GOOD;
+}
+
+#define TMPL_VAL_IDX \
+	((kprobe_opcode_t *)optprobe_template_val - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_CALL_IDX \
+	((kprobe_opcode_t *)optprobe_template_call - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_STORE_EPC_IDX \
+	((kprobe_opcode_t *)optprobe_template_store_epc - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_END_IDX \
+	((kprobe_opcode_t *)optprobe_template_end - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_ADD_SP \
+	((kprobe_opcode_t *)optprobe_template_add_sp - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_SUB_SP \
+	((kprobe_opcode_t *)optprobe_template_sub_sp - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_RESTORE_BEGIN \
+	((kprobe_opcode_t *)optprobe_template_restore_begin - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_RESTORE_ORIGN_INSN \
+	((kprobe_opcode_t *)optprobe_template_restore_orig_insn - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_RESTORE_RET \
+	((kprobe_opcode_t *)optprobe_template_ret - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+#define TMPL_RESTORE_END \
+	((kprobe_opcode_t *)optprobe_template_restore_end - \
+	 (kprobe_opcode_t *)optprobe_template_entry)
+
+#define FREE_SEARCH_DEPTH 32
+
+/*
+ * RISC-V can always optimize an instruction if not null
+ */
+int arch_prepared_optinsn(struct arch_optimized_insn *optinsn)
+{
+	return optinsn->insn != NULL;
+}
+
+/*
+ * In RISC-V ISA, jal has a quite limited jump range, To achive adequate
+ * range, auipc+jalr pair is utilized. It requires a replacement of two
+ * instructions, thus next instruction should be examined.
+ */
+int arch_check_optimized_kprobe(struct optimized_kprobe *op)
+{
+	struct kprobe *p;
+
+	/* check if the next instruction has a kprobe */
+	p = get_kprobe(op->kp.addr + 1);
+	if (p && !kprobe_disabled(p))
+		return -EEXIST;
+
+	return 0;
+}
+
+/*
+ * In RISC-V ISA, auipc+jalr requires a free register
+ * Inspired by register renaming in OoO processor, we search backwards
+ * to find such a register that is not previously used as a source
+ * register and is used as a destination register before any branch or
+ * jump instruction.
+ */
+static int
+__arch_find_free_register(kprobe_opcode_t *addr, int use_orig,
+			  kprobe_opcode_t orig)
+{
+	int i, rs1, rs2, rd;
+	kprobe_opcode_t inst;
+	int rs_mask = 0;
+
+	for (i = 0; i < FREE_SEARCH_DEPTH; i++) {
+		if (i == 0 && use_orig)
+			inst = orig;
+		else
+			inst = *(kprobe_opcode_t *)(addr + i);
+		/*
+		 * Detailed handling:
+		 * jalr/branch/system: must have reached the end, no result
+		 * jal: if not chosen as result, must have reached the end
+		 * arithmetic/load/store: record their rs
+		 * jal/arithmetic/load: if proper rd found, return result
+		 * others (float point/vector): ignore
+		 */
+		if (riscv_insn_is_branch(inst) || riscv_insn_is_jalr(inst) ||
+		    riscv_insn_is_system(inst)) {
+			return 0;
+		}
+		/* instructions that has rs1 */
+		if (riscv_insn_is_arith_ri(inst) || riscv_insn_is_arith_rr(inst) ||
+		    riscv_insn_is_load(inst) || riscv_insn_is_store(inst) ||
+		    riscv_insn_is_amo(inst)) {
+			rs1 = (inst & 0xF8000) >> 15;
+			rs_mask |= 1 << rs1;
+		}
+		/* instructions that has rs2 */
+		if (riscv_insn_is_arith_rr(inst) || riscv_insn_is_store(inst) ||
+		    riscv_insn_is_amo(inst)) {
+			rs2 = (inst & 0x1F00000) >> 20;
+			rs_mask |= 1 << rs2;
+		}
+		/* instructions that has rd */
+		if (riscv_insn_is_lui(inst) || riscv_insn_is_jal(inst) ||
+		    riscv_insn_is_load(inst) || riscv_insn_is_arith_ri(inst) ||
+		    riscv_insn_is_arith_rr(inst) || riscv_insn_is_amo(inst)) {
+			rd = (inst & 0xF80) >> 7;
+			if (rd != 0 && (rs_mask & (1 << rd)) == 0)
+				return rd;
+			if (riscv_insn_is_jal(inst))
+				return 0;
+		}
+	}
+	return 0;
+}
+
+/*
+ * If two free registers can be found at the beginning of both
+ * the start and the end of replaced code, it can be optimized
+ * Also, in-function jumps need to be checked to make sure that
+ * there is no jump to the second instruction to be replaced
+ */
+
+static int can_optimize(unsigned long paddr, kprobe_opcode_t orig)
+{
+	unsigned long addr, size = 0, offset = 0, target;
+	s32 imm;
+	kprobe_opcode_t inst;
+
+	if (!kallsyms_lookup_size_offset(paddr, &size, &offset))
+		return 0;
+
+	addr = paddr - offset;
+
+	/* if there are not enough space for our kprobe, skip */
+	if (addr + size <= paddr + MAX_OPTIMIZED_LENGTH)
+		return 0;
+
+	while (addr < paddr - offset + size) {
+		/* Check from the start until the end */
+		inst = *(kprobe_opcode_t *)addr;
+		/* branch and jal is capable of determing target before execution */
+		if (riscv_insn_is_branch(inst)) {
+			imm = branch_offset(inst);
+			target = addr + imm;
+			if (target == paddr + RVI_INST_SIZE)
+				return 0;
+		} else if (riscv_insn_is_jal(inst)) {
+			imm = jal_offset(inst);
+			target = addr + imm;
+			if (target == paddr + RVI_INST_SIZE)
+				return 0;
+		}
+		/* RVI is always 4 byte long */
+		addr += RVI_INST_SIZE;
+	}
+
+	if (can_kprobe_direct_exec((kprobe_opcode_t *)(paddr + 4)) != INSN_GOOD ||
+	    can_kprobe_direct_exec(&orig) != INSN_GOOD)
+		return 0;
+
+	/* only valid when we find two free registers, the first of which stores
+	 * detour buffer entry address and the second one stores the return address
+	 * that is two instructions after the probe point
+	 */
+	return __arch_find_free_register((kprobe_opcode_t *)paddr, 1, orig) &&
+			__arch_find_free_register((kprobe_opcode_t *)paddr + MAX_COPIED_INSN, 0, 0);
+}
+
+/* Free optimized instruction slot */
+static void
+__arch_remove_optimized_kprobe(struct optimized_kprobe *op, int dirty)
+{
+	if (op->optinsn.insn) {
+		free_optinsn_slot(op->optinsn.insn, dirty);
+		op->optinsn.insn = NULL;
+	}
+}
+
+static void
+optimized_callback(struct optimized_kprobe *op, struct pt_regs *regs)
+{
+	unsigned long flags;
+	struct kprobe_ctlblk *kcb;
+
+	/* Save skipped registers */
+	regs->epc = (unsigned long)op->kp.addr;
+	regs->orig_a0 = ~0UL;
+
+	local_irq_save(flags);
+	kcb = get_kprobe_ctlblk();
+
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(&op->kp);
+	} else {
+		__this_cpu_write(current_kprobe, &op->kp);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		opt_pre_handler(&op->kp, regs);
+		__this_cpu_write(current_kprobe, NULL);
+	}
+	local_irq_restore(flags);
+}
+
+NOKPROBE_SYMBOL(optimized_callback)
+
+/*
+ * R-type instruction as an example for the following patch functions
+ * 31   24 25 20 19 15 14    12 11 7 6     0
+ * funct7 | rs2 | rs1 | funct3 | rd | opcode
+ *    7      5     5       3      5     7
+ */
+
+#define RISCV_RD_CLEAR 0xfffff07fUL
+#define RISCV_RS1_CLEAR 0xfff07fffUL
+#define RISCV_RS2_CLEAR 0xfe0fffffUL
+#define RISCV_RD_SHIFT 7
+#define RISCV_RS1_SHIFT 15
+#define RISCV_RS2_SHIFT 20
+
+static inline kprobe_opcode_t
+__arch_patch_rd(kprobe_opcode_t inst, unsigned long val)
+{
+	inst &= RISCV_RD_CLEAR;
+	inst |= val << RISCV_RD_SHIFT;
+	return inst;
+}
+
+static inline kprobe_opcode_t
+__arch_patch_rs1(kprobe_opcode_t inst, unsigned long val)
+{
+	inst &= RISCV_RS1_CLEAR;
+	inst |= val << RISCV_RS1_SHIFT;
+	return inst;
+}
+
+static inline kprobe_opcode_t __arch_patch_rs2(kprobe_opcode_t inst,
+					       unsigned long val)
+{
+	inst &= RISCV_RS2_CLEAR;
+	inst |= val << RISCV_RS2_SHIFT;
+	return inst;
+}
+
+int arch_prepare_optimized_kprobe(struct optimized_kprobe *op, struct kprobe *orig)
+{
+	kprobe_opcode_t *code, *detour_slot, *detour_ret_addr;
+	long rel_chk;
+	unsigned long val;
+	int ret = 0;
+
+	if (!can_optimize((unsigned long)orig->addr, orig->opcode))
+		return -EILSEQ;
+
+	code = kzalloc(MAX_OPTINSN_SIZE, GFP_KERNEL);
+	detour_slot = get_optinsn_slot();
+
+	if (!code || !detour_slot) {
+		ret = -ENOMEM;
+		goto on_err;
+	}
+
+	/*
+	 * Verify if the address gap is within 4GB range, because this uses
+	 * a auipc+jalr pair.
+	 */
+	rel_chk = (long)detour_slot - (long)orig->addr + 8;
+	if (abs(rel_chk) > U32_MAX) {
+		/*
+		 * Different from x86, we free code buf directly instead of
+		 * calling __arch_remove_optimized_kprobe() because
+		 * we have not fill any field in op.
+		 */
+		ret = -ERANGE;
+		goto on_err;
+	}
+
+	/* Copy arch-dep-instance from template. */
+	memcpy(code, (unsigned long *)optprobe_template_entry,
+	       TMPL_END_IDX * sizeof(kprobe_opcode_t));
+
+	/* Set probe information */
+	*(unsigned long *)(&code[TMPL_VAL_IDX]) = (unsigned long)op;
+
+	/* Set probe function call */
+	*(unsigned long *)(&code[TMPL_CALL_IDX]) = (unsigned long)optimized_callback;
+
+	/* The free register to which the EPC (return address) is stored,
+	 * is dynamically allocated during opt probe setup. For every different
+	 * probe address, epc is stored in a possibly different register,
+	 * which need to be patched to reflect the real source.
+	 * rs2 of optprobe_template_store_epc is the source register.
+	 * After patch, optprobe_template_store_epc will be
+	 * REG_S free_register, PT_EPC(sp)
+	 */
+	code[TMPL_STORE_EPC_IDX] =
+		__arch_patch_rs2(code[TMPL_STORE_EPC_IDX],
+				 __arch_find_free_register(orig->addr, 1, orig->opcode));
+
+	/* Adjust return temp register */
+	val =
+		__arch_find_free_register(orig->addr +
+					  MAX_COPIED_INSN, 0,
+					  0);
+	/*
+	 * Patch of optprobe_template_restore_end
+	 * patch:
+	 *   rd and imm of auipc
+	 *   rs1 and imm of jalr
+	 * after patch:
+	 *   auipc free_register, %hi(return_address)
+	 *   jalr x0, %lo(return_address)(free_register)
+	 *
+	 */
+
+	detour_ret_addr = &detour_slot[optprobe_template_restore_end - optprobe_template_entry];
+
+	make_call(detour_ret_addr, (orig->addr + MAX_COPIED_INSN),
+		  (code + TMPL_RESTORE_END));
+	code[TMPL_RESTORE_END] = __arch_patch_rd(code[TMPL_RESTORE_END], val);
+	code[TMPL_RESTORE_END + 1] =
+		__arch_patch_rs1(code[TMPL_RESTORE_END + 1], val);
+	code[TMPL_RESTORE_END + 1] = __arch_patch_rd(code[TMPL_RESTORE_END + 1], 0);
+
+	/* Copy insn and have it executed during restore */
+
+	code[TMPL_RESTORE_ORIGN_INSN] = orig->opcode;
+	code[TMPL_RESTORE_ORIGN_INSN + 1] =
+		*(kprobe_opcode_t *)(orig->addr + 1);
+
+	if (patch_text_nosync(detour_slot, code, MAX_OPTINSN_SIZE)) {
+		ret = -EPERM;
+		goto on_err;
+	}
+
+	kfree(code);
+	/* Set op->optinsn.insn means prepared. */
+	op->optinsn.insn = detour_slot;
+	return ret;
+
+on_err:
+	kfree(code);
+	if (detour_slot)
+		free_optinsn_slot(detour_slot, 0);
+	return ret;
+}
+
+struct patch_probe {
+	void *addr;
+	void *insns;
+	size_t len;
+	atomic_t cpu_count;
+};
+
+static int patch_text_stop_machine(void *data)
+{
+	struct patch_probe *arg = data;
+	int ret = 0;
+
+	if (atomic_inc_return(&arg->cpu_count) == num_online_cpus()) {
+		ret = patch_text_nosync(arg->addr, arg->insns, arg->len);
+		atomic_inc(&arg->cpu_count);
+	} else {
+		while (atomic_read(&arg->cpu_count) <= num_online_cpus())
+			cpu_relax();
+		/* ensure patch visibility */
+		smp_mb();
+	}
+
+	return ret;
+}
+
+void __kprobes arch_optimize_kprobes(struct list_head *oplist)
+{
+	struct optimized_kprobe *op, *tmp;
+	kprobe_opcode_t val;
+	struct patch_probe pp;
+
+	list_for_each_entry_safe(op, tmp, oplist, list) {
+		kprobe_opcode_t insn[MAX_COPIED_INSN];
+
+		WARN_ON(kprobe_disabled(&op->kp));
+
+		/*
+		 * Backup instructions which will be replaced
+		 * by jump address
+		 */
+		memcpy(op->optinsn.copied_insn, op->kp.addr, JUMP_SIZE);
+		op->optinsn.copied_insn[0] = op->kp.opcode;
+
+		make_call(op->kp.addr, op->optinsn.insn, insn);
+
+		/*
+		 * Extract free register from the third instruction of
+		 * detour buffer (rs2 of REG_S free_register, PT_EPC(sp))
+		 * to save another call of __arch_find_free_register
+		 */
+		val = (op->optinsn.insn[2] & 0x1F00000) >> 20;
+
+		/*
+		 * After patch, it should be:
+		 * auipc free_register, %hi(detour_buffer)
+		 * jalr free_register, free_register, %lo(detour_buffer)
+		 * where free_register will eventually save the return address
+		 */
+		insn[0] = __arch_patch_rd(insn[0], val);
+		insn[1] = __arch_patch_rd(insn[1], val);
+		insn[1] = __arch_patch_rs1(insn[1], val);
+
+		/*
+		 * Similar to __arch_disarm_kprobe, operations which
+		 * removing breakpoints must be wrapped by stop_machine
+		 * to avoid racing.
+		 */
+		pp = (struct patch_probe){
+			.addr = op->kp.addr,
+			.insns = insn,
+			.len = JUMP_SIZE,
+			.cpu_count = ATOMIC_INIT(0),
+		};
+		WARN_ON(stop_machine_cpuslocked(patch_text_stop_machine, &pp, cpu_online_mask));
+
+		list_del_init(&op->list);
+	}
+}
+
+static int arch_disarm_kprobe_opt(void *vop)
+{
+	struct optimized_kprobe *op = (struct optimized_kprobe *)vop;
+	struct patch_probe pp = {
+		.addr = op->kp.addr,
+		.insns = op->optinsn.copied_insn,
+		.len = JUMP_SIZE,
+		.cpu_count = ATOMIC_INIT(0),
+	};
+	WARN_ON(stop_machine_cpuslocked(patch_text_stop_machine, &pp, cpu_online_mask));
+	arch_arm_kprobe(&op->kp);
+	return 0;
+}
+
+void arch_unoptimize_kprobe(struct optimized_kprobe *op)
+{
+	arch_disarm_kprobe_opt((void *)op);
+}
+
+/*
+ * Recover original instructions and breakpoints from relative jumps.
+ * Caller must call with locking kprobe_mutex.
+ */
+void arch_unoptimize_kprobes(struct list_head *oplist,
+			     struct list_head *done_list)
+{
+	struct optimized_kprobe *op, *tmp;
+
+	list_for_each_entry_safe(op, tmp, oplist, list) {
+		arch_unoptimize_kprobe(op);
+		list_move(&op->list, done_list);
+	}
+}
+
+int arch_within_optimized_kprobe(struct optimized_kprobe *op,
+				 kprobe_opcode_t *addr)
+{
+	return (op->kp.addr <= addr &&
+		op->kp.addr + (JUMP_SIZE / sizeof(kprobe_opcode_t)) > addr);
+}
+
+void arch_remove_optimized_kprobe(struct optimized_kprobe *op)
+{
+	__arch_remove_optimized_kprobe(op, 1);
+}
diff --git a/arch/riscv/kernel/probes/opt_trampoline.S b/arch/riscv/kernel/probes/opt_trampoline.S
new file mode 100644
index 000000000..974597ed5
--- /dev/null
+++ b/arch/riscv/kernel/probes/opt_trampoline.S
@@ -0,0 +1,132 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 Regents of the University of California
+ * Copyright (C) 2017 SiFive
+ * Copyright (C) 2022 Guokai Chen
+ */
+
+#include <linux/init.h>
+#include <linux/linkage.h>
+
+#include <asm/asm.h>
+#include <asm/csr.h>
+#include <asm/unistd.h>
+#include <asm/thread_info.h>
+#include <asm/asm-offsets.h>
+
+#ifdef CONFIG_OPTPROBES
+
+ENTRY(optprobe_template_entry)
+ENTRY(optprobe_template_sub_sp)
+
+	REG_S sp, (-(PT_SIZE_ON_STACK) + PT_SP)(sp)
+	addi sp, sp, -(PT_SIZE_ON_STACK)
+ENTRY(optprobe_template_store_epc)
+	REG_S ra, PT_EPC(sp)
+	REG_S ra, PT_RA(sp)
+	REG_S gp, PT_GP(sp)
+	REG_S tp, PT_TP(sp)
+	REG_S t0, PT_T0(sp)
+	REG_S t1, PT_T1(sp)
+	REG_S t2, PT_T2(sp)
+	REG_S s0, PT_S0(sp)
+	REG_S s1, PT_S1(sp)
+	REG_S a0, PT_A0(sp)
+	REG_S a1, PT_A1(sp)
+	REG_S a2, PT_A2(sp)
+	REG_S a3, PT_A3(sp)
+	REG_S a4, PT_A4(sp)
+	REG_S a5, PT_A5(sp)
+	REG_S a6, PT_A6(sp)
+	REG_S a7, PT_A7(sp)
+	REG_S s2, PT_S2(sp)
+	REG_S s3, PT_S3(sp)
+	REG_S s4, PT_S4(sp)
+	REG_S s5, PT_S5(sp)
+	REG_S s6, PT_S6(sp)
+	REG_S s7, PT_S7(sp)
+	REG_S s8, PT_S8(sp)
+	REG_S s9, PT_S9(sp)
+	REG_S s10, PT_S10(sp)
+	REG_S s11, PT_S11(sp)
+	REG_S t3, PT_T3(sp)
+	REG_S t4, PT_T4(sp)
+	REG_S t5, PT_T5(sp)
+	REG_S t6, PT_T6(sp)
+	csrr t0, sstatus
+	csrr t1, stval
+	csrr t2, scause
+	REG_S t0, PT_STATUS(sp)
+	REG_S t1, PT_BADADDR(sp)
+	REG_S t2, PT_CAUSE(sp)
+ENTRY(optprobe_template_add_sp)
+	move a1, sp
+	lla a0, 1f
+	REG_L a0, 0(a0)
+	REG_L a2, 2f
+	jalr 0(a2)
+ENTRY(optprobe_template_restore_begin)
+	REG_L t0, PT_STATUS(sp)
+	REG_L t1, PT_BADADDR(sp)
+	REG_L t2, PT_CAUSE(sp)
+	csrw sstatus, t0
+	csrw stval, t1
+	csrw scause, t2
+	REG_L ra, PT_RA(sp)
+	REG_L gp, PT_GP(sp)
+	REG_L tp, PT_TP(sp)
+	REG_L t0, PT_T0(sp)
+	REG_L t1, PT_T1(sp)
+	REG_L t2, PT_T2(sp)
+	REG_L s0, PT_S0(sp)
+	REG_L s1, PT_S1(sp)
+	REG_L a0, PT_A0(sp)
+	REG_L a1, PT_A1(sp)
+	REG_L a2, PT_A2(sp)
+	REG_L a3, PT_A3(sp)
+	REG_L a4, PT_A4(sp)
+	REG_L a5, PT_A5(sp)
+	REG_L a6, PT_A6(sp)
+	REG_L a7, PT_A7(sp)
+	REG_L s2, PT_S2(sp)
+	REG_L s3, PT_S3(sp)
+	REG_L s4, PT_S4(sp)
+	REG_L s5, PT_S5(sp)
+	REG_L s6, PT_S6(sp)
+	REG_L s7, PT_S7(sp)
+	REG_L s8, PT_S8(sp)
+	REG_L s9, PT_S9(sp)
+	REG_L s10, PT_S10(sp)
+	REG_L s11, PT_S11(sp)
+	REG_L t3, PT_T3(sp)
+	REG_L t4, PT_T4(sp)
+	REG_L t5, PT_T5(sp)
+	REG_L t6, PT_T6(sp)
+	addi sp, sp, PT_SIZE_ON_STACK
+ENTRY(optprobe_template_restore_orig_insn)
+	nop
+	nop
+ENTRY(optprobe_template_restore_end)
+ret_to_normal:
+	auipc ra, 0
+	jalr x0, 0(ra)
+ENTRY(optprobe_template_val)
+1:
+	.dword 0
+ENTRY(optprobe_template_call)
+2:
+	.dword 0
+	.dword 0
+ENTRY(optprobe_template_end)
+END(optprobe_template_end)
+END(optprobe_template_call)
+END(optprobe_template_val)
+END(optprobe_template_restore_end)
+END(optprobe_template_restore_orig_insn)
+END(optprobe_template_restore_begin)
+END(optprobe_template_add_sp)
+END(optprobe_template_store_epc)
+END(optprobe_template_sub_sp)
+END(optprobe_template_entry)
+
+#endif /* CONFIG_OPTPROBES */
diff --git a/arch/riscv/kernel/probes/simulate-insn.c b/arch/riscv/kernel/probes/simulate-insn.c
index d73e96f6e..5b9a6cc06 100644
--- a/arch/riscv/kernel/probes/simulate-insn.c
+++ b/arch/riscv/kernel/probes/simulate-insn.c
@@ -127,15 +127,6 @@ bool __kprobes simulate_auipc(u32 opcode, unsigned long addr, struct pt_regs *re
 #define branch_funct3(opcode) \
 	(((opcode) >> 12) & 0x7)
 
-#define branch_imm(opcode) \
-	(((((opcode) >>  8) & 0xf ) <<  1) | \
-	 ((((opcode) >> 25) & 0x3f) <<  5) | \
-	 ((((opcode) >>  7) & 0x1 ) << 11) | \
-	 ((((opcode) >> 31) & 0x1 ) << 12))
-
-#define branch_offset(opcode) \
-	sign_extend32((branch_imm(opcode)), 12)
-
 #define BRANCH_BEQ	0x0
 #define BRANCH_BNE	0x1
 #define BRANCH_BLT	0x4
diff --git a/arch/riscv/kernel/probes/simulate-insn.h b/arch/riscv/kernel/probes/simulate-insn.h
index cb6ff7dcc..74aca44ff 100644
--- a/arch/riscv/kernel/probes/simulate-insn.h
+++ b/arch/riscv/kernel/probes/simulate-insn.h
@@ -44,4 +44,29 @@ __RISCV_INSN_FUNCS(branch,	0x7f, 0x63);
 __RISCV_INSN_FUNCS(jal,		0x7f, 0x6f);
 __RISCV_INSN_FUNCS(jalr,	0x707f, 0x67);
 
+/* 0111011 && 0110011 */
+__RISCV_INSN_FUNCS(arith_rr, 0x77, 0x33);
+/* 0011011 && 0010011 */
+__RISCV_INSN_FUNCS(arith_ri, 0x77, 0x13);
+__RISCV_INSN_FUNCS(lui, 0x7f, 0x37);
+__RISCV_INSN_FUNCS(load, 0x7f, 0x03);
+__RISCV_INSN_FUNCS(store, 0x7f, 0x23);
+__RISCV_INSN_FUNCS(amo, 0x7f, 0x2f);
+
+#define branch_imm(opcode) \
+	(((((opcode) >>  8) & 0xf) <<  1) | \
+	 ((((opcode) >> 25) & 0x3f) << 5) | \
+	 ((((opcode) >>  7) & 0x1) << 11) | \
+	 ((((opcode) >> 31) & 0x1) << 12))
+
+#define branch_offset(opcode) \
+	sign_extend32((branch_imm(opcode)), 12)
+
+#define jal_imm(opcode) \
+	(((((opcode) >> 21) & 0x3ff) << 1) | \
+	 ((((opcode) >> 20) &  0x1) << 11) | \
+	 ((((opcode) >> 31) &  0x1) << 20))
+#define jal_offset(opcode) \
+	sign_extend32(jal_imm(opcode), 20)
+
 #endif /* _RISCV_KERNEL_PROBES_SIMULATE_INSN_H */
-- 
2.34.1

