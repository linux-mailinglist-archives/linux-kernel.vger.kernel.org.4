Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8622462B496
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 09:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238483AbiKPIIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 03:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233140AbiKPIHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 03:07:41 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8ADBDBC97
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 00:07:32 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx67VDmnRjI7IHAA--.2962S3;
        Wed, 16 Nov 2022 16:07:31 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VY6mnRjQ54UAA--.36317S5;
        Wed, 16 Nov 2022 16:07:30 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH v8 3/9] LoongArch/ftrace: Add dynamic function tracer support
Date:   Wed, 16 Nov 2022 16:07:16 +0800
Message-Id: <20221116080722.4745-4-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116080722.4745-1-zhangqing@loongson.cn>
References: <20221116080722.4745-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VY6mnRjQ54UAA--.36317S5
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3CF1DCF18uF4DAFWfAw48Xrb_yoW8WF4kXo
        WY93Wj9r4rGrW29w4Yy3y5GFWjqr10krZ8Z34ayrn8WF40yry3XryUKa15Ka43Jr95Gr4r
        Cr97uF48ZFWxXr9rn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UU9Ib4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2
        z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIF
        yTuYvjxU2na9DUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The compiler has inserted 2 NOPs before the regular function prologue.
T series registers are available and safe because of LoongArch psABI.

At runtime, replace nop with bl to enable ftrace call and replace bl with
nop to disable ftrace call. The bl requires us to save the original RA
value, so here it saves RA at t0.
details are:

| Compiled   |       Disabled         |        Enabled         |
+------------+------------------------+------------------------+
| nop        | move     t0, ra        | move     t0, ra        |
| nop        | nop                    | bl      ftrace_caller  |
| func_body  | func_body              | func_body              |

The RA value will be recovered by ftrace_regs_entry, and restored into RA
before returning to the regular function prologue. When a function is not
being traced, the move t0, ra is not harmful.

1) ftrace_make_call, ftrace_make_nop (in kernel/ftrace.c)
   The two functions turn each recorded call site of filtered functions
   into a call to ftrace_caller or nops.

2) ftracce_update_ftrace_func (in kernel/ftrace.c)
   turns the nops at ftrace_call into a call to a generic entry for
   function tracers.

3) ftrace_caller (in kernel/mcount-dyn.S)
   The entry where each _mcount call sites calls to once they are
   filtered to be traced.

Co-developed-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/Kconfig                  |   1 +
 arch/loongarch/Makefile                 |   5 ++
 arch/loongarch/include/asm/ftrace.h     |  16 ++++
 arch/loongarch/include/asm/inst.h       |  12 +++
 arch/loongarch/include/asm/unwind.h     |   2 +-
 arch/loongarch/kernel/Makefile          |   5 ++
 arch/loongarch/kernel/ftrace_dyn.c      | 111 ++++++++++++++++++++++++
 arch/loongarch/kernel/inst.c            |  92 ++++++++++++++++++++
 arch/loongarch/kernel/mcount_dyn.S      |  89 +++++++++++++++++++
 arch/loongarch/kernel/unwind_prologue.c |  35 ++++++--
 10 files changed, 362 insertions(+), 6 deletions(-)
 create mode 100644 arch/loongarch/kernel/ftrace_dyn.c
 create mode 100644 arch/loongarch/kernel/mcount_dyn.S

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index e6b1defca1f1..615ce62422b8 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -89,6 +89,7 @@ config LOONGARCH
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_STACKOVERFLOW
 	select HAVE_DMA_CONTIGUOUS
+	select HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT
 	select HAVE_EXIT_THREAD
 	select HAVE_FAST_GUP
diff --git a/arch/loongarch/Makefile b/arch/loongarch/Makefile
index a0fc1f9980e3..33e1e4f3fff0 100644
--- a/arch/loongarch/Makefile
+++ b/arch/loongarch/Makefile
@@ -25,6 +25,11 @@ endif
 32bit-emul		= elf32loongarch
 64bit-emul		= elf64loongarch
 
+ifdef CONFIG_DYNAMIC_FTRACE
+KBUILD_CPPFLAGS += -DCC_USING_PATCHABLE_FUNCTION_ENTRY
+CC_FLAGS_FTRACE := -fpatchable-function-entry=2
+endif
+
 ifdef CONFIG_64BIT
 tool-archpref		= $(64bit-tool-archpref)
 UTS_MACHINE		:= loongarch64
diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 6a3e76234618..76ca58767f4d 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -10,9 +10,25 @@
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
 #ifndef __ASSEMBLY__
+#ifndef CONFIG_DYNAMIC_FTRACE
 extern void _mcount(void);
 #define mcount _mcount
+#endif
 
+#ifdef CONFIG_DYNAMIC_FTRACE
+static inline unsigned long ftrace_call_adjust(unsigned long addr)
+{
+	return addr;
+}
+
+struct dyn_arch_ftrace {
+};
+
+struct dyn_ftrace;
+int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec);
+#define ftrace_init_nop ftrace_init_nop
+
+#endif /* CONFIG_DYNAMIC_FTRACE */
 #endif /* __ASSEMBLY__ */
 #endif /* CONFIG_FUNCTION_TRACER */
 #endif /* _ASM_LOONGARCH_FTRACE_H */
diff --git a/arch/loongarch/include/asm/inst.h b/arch/loongarch/include/asm/inst.h
index a52913787183..59fee75590e9 100644
--- a/arch/loongarch/include/asm/inst.h
+++ b/arch/loongarch/include/asm/inst.h
@@ -349,6 +349,18 @@ static inline bool is_stack_alloc_ins(union loongarch_instruction *ip)
 		is_imm12_negative(ip->reg2i12_format.immediate);
 }
 
+int larch_insn_read(void *addr, u32 *insnp);
+int larch_insn_write(void *addr, u32 insn);
+int larch_insn_patch_text(void *addr, u32 insn);
+
+u32 larch_insn_gen_nop(void);
+u32 larch_insn_gen_b(unsigned long pc, unsigned long dest);
+u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest);
+
+u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj,
+			enum loongarch_gpr rk);
+u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj);
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
 u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr rj, int imm);
 u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned long pc, unsigned long dest);
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index 6af4718bdf01..a51eec00efb8 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -20,7 +20,7 @@ struct unwind_state {
 	char type; /* UNWINDER_XXX */
 	struct stack_info stack_info;
 	struct task_struct *task;
-	bool first, error;
+	bool first, error, is_ftrace;
 	unsigned long sp, pc, ra;
 };
 
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 3f71bce1c7ce..27a5b62efc92 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -16,8 +16,13 @@ obj-$(CONFIG_EFI) 		+= efi.o
 obj-$(CONFIG_CPU_HAS_FPU)	+= fpu.o
 
 ifdef CONFIG_FUNCTION_TRACER
+ifndef CONFIG_DYNAMIC_FTRACE
 obj-y += mcount.o ftrace.o
 CFLAGS_REMOVE_ftrace.o = $(CC_FLAGS_FTRACE)
+else
+obj-y += mcount_dyn.o ftrace_dyn.o
+CFLAGS_REMOVE_ftrace_dyn.o = $(CC_FLAGS_FTRACE)
+endif
 CFLAGS_REMOVE_inst.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_time.o = $(CC_FLAGS_FTRACE)
 CFLAGS_REMOVE_perf_event.o = $(CC_FLAGS_FTRACE)
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
new file mode 100644
index 000000000000..1f8955be8b64
--- /dev/null
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Based on arch/arm64/kernel/ftrace.c
+ *
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <linux/ftrace.h>
+#include <linux/uaccess.h>
+
+#include <asm/inst.h>
+
+static int ftrace_modify_code(unsigned long pc, u32 old, u32 new,
+			      bool validate)
+{
+	u32 replaced;
+
+	if (validate) {
+		if (larch_insn_read((void *)pc, &replaced))
+			return -EFAULT;
+
+		if (replaced != old)
+			return -EINVAL;
+	}
+
+	if (larch_insn_patch_text((void *)pc, new))
+		return -EPERM;
+
+	return 0;
+}
+
+int ftrace_update_ftrace_func(ftrace_func_t func)
+{
+	unsigned long pc;
+	u32 new;
+
+	pc = (unsigned long)&ftrace_call;
+	new = larch_insn_gen_bl(pc, (unsigned long)func);
+
+	return ftrace_modify_code(pc, 0, new, false);
+}
+
+/*
+ * The compiler has inserted 2 NOPs before the regular function prologue.
+ * T series registers are available and safe because of LoongArch psABI.
+ *
+ * At runtime, replace nop with bl to enable ftrace call and replace bl with
+ * nop to disable ftrace call. The bl requires us to save the original RA value,
+ * so here it saves RA at t0.
+ * details are:
+ *
+ * | Compiled   |       Disabled         |        Enabled         |
+ * +------------+------------------------+------------------------+
+ * | nop        | move     t0, ra        | move     t0, ra        |
+ * | nop        | nop                    | bl      ftrace_caller  |
+ * | func_body  | func_body              | func_body              |
+ *
+ * The RA value will be recovered by ftrace_regs_entry, and restored into RA
+ * before returning to the regular function prologue. When a function is not
+ * being traced, the move t0, ra is not harmful.
+ */
+
+int ftrace_init_nop(struct module *mod, struct dyn_ftrace *rec)
+{
+	unsigned long pc;
+	u32 old, new;
+
+	pc = rec->ip;
+	old = larch_insn_gen_nop();
+	new = larch_insn_gen_move(LOONGARCH_GPR_T0, LOONGARCH_GPR_RA);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
+{
+	unsigned long pc;
+	u32 old, new;
+
+	pc = rec->ip + LOONGARCH_INSN_SIZE;
+
+	old = larch_insn_gen_nop();
+	new = larch_insn_gen_bl(pc, addr);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+int ftrace_make_nop(struct module *mod, struct dyn_ftrace *rec,
+		    unsigned long addr)
+{
+	unsigned long pc;
+	u32 old, new;
+
+	pc = rec->ip + LOONGARCH_INSN_SIZE;
+
+	new = larch_insn_gen_nop();
+	old = larch_insn_gen_bl(pc, addr);
+
+	return ftrace_modify_code(pc, old, new, true);
+}
+
+void arch_ftrace_update_code(int command)
+{
+	command |= FTRACE_MAY_SLEEP;
+	ftrace_modify_all_code(command);
+}
+
+int __init ftrace_dyn_arch_init(void)
+{
+	return 0;
+}
diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.c
index b1df0ec34bd1..d62cdf4a9ffb 100644
--- a/arch/loongarch/kernel/inst.c
+++ b/arch/loongarch/kernel/inst.c
@@ -2,8 +2,83 @@
 /*
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <linux/sizes.h>
+#include <linux/uaccess.h>
+
+#include <asm/cacheflush.h>
 #include <asm/inst.h>
 
+static DEFINE_RAW_SPINLOCK(patch_lock);
+
+int larch_insn_read(void *addr, u32 *insnp)
+{
+	int ret;
+	u32 val;
+
+	ret = copy_from_kernel_nofault(&val, addr, LOONGARCH_INSN_SIZE);
+	if (!ret)
+		*insnp = val;
+
+	return ret;
+}
+
+int larch_insn_write(void *addr, u32 insn)
+{
+	int ret;
+	unsigned long flags = 0;
+
+	raw_spin_lock_irqsave(&patch_lock, flags);
+	ret = copy_to_kernel_nofault(addr, &insn, LOONGARCH_INSN_SIZE);
+	raw_spin_unlock_irqrestore(&patch_lock, flags);
+
+	return ret;
+}
+
+int larch_insn_patch_text(void *addr, u32 insn)
+{
+	int ret;
+	u32 *tp = addr;
+
+	if ((unsigned long)tp & 3)
+		return -EINVAL;
+
+	ret = larch_insn_write(tp, insn);
+	if (!ret)
+		flush_icache_range((unsigned long)tp,
+				   (unsigned long)tp + LOONGARCH_INSN_SIZE);
+
+	return ret;
+}
+
+u32 larch_insn_gen_nop(void)
+{
+	return INSN_NOP;
+}
+
+u32 larch_insn_gen_bl(unsigned long pc, unsigned long dest)
+{
+	unsigned int immediate_l, immediate_h;
+	union loongarch_instruction insn;
+	long offset = dest - pc;
+
+	if ((offset & 3) || offset < -SZ_128M || offset >= SZ_128M) {
+		pr_warn("The generated bl instruction is out of range.\n");
+		return INSN_BREAK;
+	}
+
+	offset >>= 2;
+
+	immediate_l = offset & 0xffff;
+	offset >>= 16;
+	immediate_h = offset & 0x3ff;
+
+	insn.reg0i26_format.opcode = bl_op;
+	insn.reg0i26_format.immediate_l = immediate_l;
+	insn.reg0i26_format.immediate_h = immediate_h;
+
+	return insn.word;
+}
+
 u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
 {
 	union loongarch_instruction insn;
@@ -38,3 +113,20 @@ u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj, unsigned l
 
 	return insn.word;
 }
+
+u32 larch_insn_gen_or(enum loongarch_gpr rd, enum loongarch_gpr rj, enum loongarch_gpr rk)
+{
+	union loongarch_instruction insn;
+
+	insn.reg3_format.opcode = or_op;
+	insn.reg3_format.rd = rd;
+	insn.reg3_format.rj = rj;
+	insn.reg3_format.rk = rk;
+
+	return insn.word;
+}
+
+u32 larch_insn_gen_move(enum loongarch_gpr rd, enum loongarch_gpr rj)
+{
+	return larch_insn_gen_or(rd, rj, 0);
+}
diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
new file mode 100644
index 000000000000..205925bc3822
--- /dev/null
+++ b/arch/loongarch/kernel/mcount_dyn.S
@@ -0,0 +1,89 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+
+#include <asm/export.h>
+#include <asm/regdef.h>
+#include <asm/stackframe.h>
+#include <asm/ftrace.h>
+
+	.text
+/*
+ * Due to -fpatchable-function-entry=2: the compiler inserted 2 NOPs before the
+ * regular C function prologue. When PC arrived here, the last 2 instructions
+ * as follows,
+ * 	move		t0, ra
+ * 	bl		callsite (for modules, callsite is a tramplione)
+ *
+ * modules tramplione as follows,
+ * 	lu12i.w		t1, callsite[31:12]
+ * 	lu32i.d		t1, callsite[51:32]
+ * 	lu52i.d		t1, t1, callsite[63:52]
+ * 	jirl		zero, t1, callsite[11:0] >> 2
+ *
+ * See arch/loongarch/kernel/ftrace_dyn.c for details. Here, pay attention to
+ * that the T series regs are available and safe because each C functions
+ * follows the LoongArch psABI well.
+ */
+
+	.macro  ftrace_regs_entry
+	PTR_ADDI sp, sp, -PT_SIZE
+	/* Save trace function ra at PT_ERA */
+	PTR_S	ra, sp, PT_ERA
+	/* Save parent ra at PT_R1(RA) */
+	PTR_S	t0, sp, PT_R1
+	PTR_S	a0, sp, PT_R4
+	PTR_S	a1, sp, PT_R5
+	PTR_S	a2, sp, PT_R6
+	PTR_S	a3, sp, PT_R7
+	PTR_S	a4, sp, PT_R8
+	PTR_S	a5, sp, PT_R9
+	PTR_S	a6, sp, PT_R10
+	PTR_S	a7, sp, PT_R11
+	PTR_S	fp, sp, PT_R22
+
+	PTR_ADDI t8, sp, PT_SIZE
+	PTR_S   t8, sp, PT_R3
+
+	.endm
+
+SYM_CODE_START(ftrace_caller)
+	ftrace_regs_entry
+	b	ftrace_common
+SYM_CODE_END(ftrace_caller)
+
+SYM_CODE_START(ftrace_common)
+	PTR_ADDI	a0, ra, -8	/* arg0: ip */
+	move		a1, t0		/* arg1: parent_ip */
+	la.pcrel	t1, function_trace_op
+	PTR_L		a2, t1, 0	/* arg2: op */
+	move		a3, sp		/* arg3: regs */
+	.globl ftrace_call
+ftrace_call:
+	bl		ftrace_stub
+/*
+ * As we didn't use S series regs in this assmembly code and all calls
+ * are C function which will save S series regs by themselves, there is
+ * no need to restore S series regs. The T series is available and safe
+ * at the callsite, so there is no need to restore the T series regs.
+ */
+ftrace_common_return:
+	PTR_L	a0, sp, PT_R4
+	PTR_L	a1, sp, PT_R5
+	PTR_L	a2, sp, PT_R6
+	PTR_L	a3, sp, PT_R7
+	PTR_L	a4, sp, PT_R8
+	PTR_L	a5, sp, PT_R9
+	PTR_L	a6, sp, PT_R10
+	PTR_L	a7, sp, PT_R11
+	PTR_L	fp, sp, PT_R22
+	PTR_L	ra, sp, PT_R1
+	PTR_L	t0, sp, PT_ERA
+	PTR_ADDI sp, sp, PT_SIZE
+	jr	t0
+SYM_CODE_END(ftrace_common)
+
+SYM_FUNC_START(ftrace_stub)
+	jr	ra
+SYM_FUNC_END(ftrace_stub)
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index b206d9159205..c5df4ae73e0d 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -13,9 +13,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
 
 	if (unwind_done(state))
 		return 0;
-	else if (state->type)
-		return state->pc;
-	else if (state->first)
+	else if (state->type || state->first)
 		return state->pc;
 
 	return *(unsigned long *)(state->sp);
@@ -39,16 +37,41 @@ static bool unwind_by_guess(struct unwind_state *state)
 	return false;
 }
 
+static inline void unwind_state_fixup(struct unwind_state *state)
+{
+#ifdef CONFIG_DYNAMIC_FTRACE
+	static unsigned long ftrace_case = (unsigned long)ftrace_call + 4;
+
+	if (state->pc == ftrace_case)
+		state->is_ftrace = true;
+#endif
+}
+
 static bool unwind_by_prologue(struct unwind_state *state)
 {
 	struct stack_info *info = &state->stack_info;
 	union loongarch_instruction *ip, *ip_end;
 	unsigned long frame_size = 0, frame_ra = -1;
 	unsigned long size, offset, pc = state->pc;
+	struct pt_regs *regs;
 
 	if (state->sp >= info->end || state->sp < info->begin)
 		return false;
 
+	if (state->is_ftrace) {
+		/*
+		 * As we meet ftrace_regs_entry, reset first flag like first doing
+		 * tracing, Prologue analysis will stop soon because PC is at entry.
+		 */
+		regs = (struct pt_regs *)state->sp;
+		state->pc = regs->csr_era;
+		state->ra = regs->regs[1];
+		state->sp = regs->regs[3];
+		state->first = true;
+		state->is_ftrace = false;
+		return true;
+	}
+
 	if (!kallsyms_lookup_size_offset(pc, &size, &offset))
 		return false;
 
@@ -94,7 +117,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
 
 	state->pc = *(unsigned long *)(state->sp + frame_ra);
 	state->sp = state->sp + frame_size;
-	return !!__kernel_text_address(state->pc);
+	goto out;
 
 first:
 	state->first = false;
@@ -103,7 +126,9 @@ static bool unwind_by_prologue(struct unwind_state *state)
 
 	state->pc = state->ra;
 
-	return !!__kernel_text_address(state->ra);
+out:
+	unwind_state_fixup(state);
+	return !!__kernel_text_address(state->pc);
 }
 
 void unwind_start(struct unwind_state *state, struct task_struct *task,
-- 
2.36.0

