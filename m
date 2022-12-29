Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70066589A6
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 07:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbiL2GQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 01:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232624AbiL2GPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 01:15:50 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7498865AB
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 22:15:48 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8AxxvCSMK1jNjMJAA--.19829S3;
        Thu, 29 Dec 2022 14:15:46 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dxrb6OMK1jIiYPAA--.24618S6;
        Thu, 29 Dec 2022 14:15:46 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 4/6] LoongArch: Strip guess_unwinder out from prologue_unwinder
Date:   Thu, 29 Dec 2022 14:15:15 +0800
Message-Id: <20221229061516.31671-5-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221229061516.31671-1-hejinyang@loongson.cn>
References: <20221229061516.31671-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dxrb6OMK1jIiYPAA--.24618S6
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3KrykCw4fZF45GF1xZrWUurg_yoW8Gry7Xo
        WSyF4agrW8X3y5t3yjyryUtFyYgr4jka1DA3y3trn8WF42y343urWjqasxJFyIqwn5KrWU
        Cr42gF4rXan7Arn3n29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
        8EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr1j6F4U
        JwAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4
        CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Wrv_ZF1lYx0E
        x4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x
        0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCF
        I7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
        106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
        xVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7
        xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_
        Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jqRRiUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The prolugue unwinder rely on symbol info. When PC is not in kernel
text address, it cannot find relative symbol info and it will be broken.
The guess unwinder will be used in this case. And the guess unwinder
codes in prolugue unwinder is redundant. Strip it out and set the
unwinder info in unwind_state.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/include/asm/unwind.h     |  26 ++++-
 arch/loongarch/kernel/Makefile          |   3 +-
 arch/loongarch/kernel/traps.c           |   3 -
 arch/loongarch/kernel/unwind.c          |  52 +++++++++
 arch/loongarch/kernel/unwind_guess.c    |  41 ++------
 arch/loongarch/kernel/unwind_prologue.c | 133 +++++++++---------------
 6 files changed, 132 insertions(+), 126 deletions(-)
 create mode 100644 arch/loongarch/kernel/unwind.c

diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index 6ece48f0ff77..4a55fd7b77ad 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -13,20 +13,30 @@
 #include <asm/ptrace.h>
 #include <asm/stacktrace.h>
 
-enum unwinder_type {
-	UNWINDER_GUESS,
-	UNWINDER_PROLOGUE,
-};
+struct unwinder_ops;
 
 struct unwind_state {
-	char type; /* UNWINDER_XXX */
 	struct stack_info stack_info;
 	struct task_struct *task;
 	bool first, error, is_ftrace;
 	int graph_idx;
 	unsigned long sp, pc, ra;
+	const struct unwinder_ops *ops;
+};
+
+struct unwinder_ops {
+	void (*unwind_start)(struct unwind_state *state,
+			     struct task_struct *task, struct pt_regs *regs);
+	bool (*unwind_next_frame)(struct unwind_state *state);
+	unsigned long (*unwind_get_return_address)(struct unwind_state *state);
 };
 
+extern const struct unwinder_ops *default_unwinder;
+extern const struct unwinder_ops unwinder_guess;
+#ifdef CONFIG_UNWINDER_PROLOGUE
+extern const struct unwinder_ops unwinder_prologue;
+#endif
+
 void unwind_start(struct unwind_state *state,
 		  struct task_struct *task, struct pt_regs *regs);
 bool unwind_next_frame(struct unwind_state *state);
@@ -49,4 +59,10 @@ static inline unsigned long unwind_graph_addr(struct unwind_state *state,
 	return ftrace_graph_ret_addr(state->task, &state->graph_idx,
 				     pc, (unsigned long *)(cfa - GRAPH_FAKE_OFFSET));
 }
+
+static inline void unwind_register_unwinder(struct unwind_state *state,
+					  const struct unwinder_ops *unwinder)
+{
+	state->ops = unwinder;
+}
 #endif /* _ASM_UNWIND_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index 7ca65195f7f8..cb6029ea3ea9 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -8,7 +8,7 @@ extra-y		:= vmlinux.lds
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
 		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
-		   alternative.o unaligned.o
+		   alternative.o unaligned.o unwind.o unwind_guess.o
 
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_EFI) 		+= efi.o
@@ -42,7 +42,6 @@ obj-$(CONFIG_MAGIC_SYSRQ)	+= sysrq.o
 obj-$(CONFIG_KEXEC)		+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
 
-obj-$(CONFIG_UNWINDER_GUESS)	+= unwind_guess.o
 obj-$(CONFIG_UNWINDER_PROLOGUE) += unwind_prologue.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o perf_regs.o
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index 3adc44832205..1ea14f6c18d3 100644
--- a/arch/loongarch/kernel/traps.c
+++ b/arch/loongarch/kernel/traps.c
@@ -72,9 +72,6 @@ static void show_backtrace(struct task_struct *task, const struct pt_regs *regs,
 	if (!task)
 		task = current;
 
-	if (user_mode(regs))
-		state.type = UNWINDER_GUESS;
-
 	printk("%sCall Trace:", loglvl);
 	for (unwind_start(&state, task, pregs);
 	      !unwind_done(&state); unwind_next_frame(&state)) {
diff --git a/arch/loongarch/kernel/unwind.c b/arch/loongarch/kernel/unwind.c
new file mode 100644
index 000000000000..24d2cf99bfb6
--- /dev/null
+++ b/arch/loongarch/kernel/unwind.c
@@ -0,0 +1,52 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Loongson Technology Corporation Limited
+ */
+#include <asm/unwind.h>
+
+#if defined(CONFIG_UNWINDER_GUESS)
+const struct unwinder_ops *default_unwinder = &unwinder_guess;
+#elif defined(CONFIG_UNWINDER_PROLOGUE)
+const struct unwinder_ops *default_unwinder = &unwinder_prologue;
+#endif
+
+unsigned long unwind_get_return_address(struct unwind_state *state)
+{
+	if (!state->ops || unwind_done(state))
+		return 0;
+	return state->ops->unwind_get_return_address(state);
+}
+EXPORT_SYMBOL_GPL(unwind_get_return_address);
+
+void unwind_start(struct unwind_state *state, struct task_struct *task,
+		    struct pt_regs *regs)
+{
+	memset(state, 0, sizeof(*state));
+	unwind_register_unwinder(state, default_unwinder);
+	if (regs) {
+		state->sp = regs->regs[3];
+		state->pc = regs->csr_era;
+		state->ra = regs->regs[1];
+	} else if (task == current || task == NULL) {
+		state->sp = (unsigned long)__builtin_frame_address(0);
+		state->pc = (unsigned long)__builtin_return_address(0);
+		state->ra = 0;
+	} else {
+		state->sp = thread_saved_fp(task);
+		state->pc = thread_saved_ra(task);
+		state->ra = 0;
+	}
+	state->task = task;
+	get_stack_info(state->sp, state->task, &state->stack_info);
+	state->pc = unwind_graph_addr(state, state->pc, state->sp);
+	state->ops->unwind_start(state, task, regs);
+}
+EXPORT_SYMBOL_GPL(unwind_start);
+
+bool unwind_next_frame(struct unwind_state *state)
+{
+	if (!state->ops || unwind_done(state))
+		return false;
+	return state->ops->unwind_next_frame(state);
+}
+EXPORT_SYMBOL_GPL(unwind_next_frame);
diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
index 935d24f8c95c..b7ca2b88ac63 100644
--- a/arch/loongarch/kernel/unwind_guess.c
+++ b/arch/loongarch/kernel/unwind_guess.c
@@ -7,51 +7,23 @@
 
 #include <asm/unwind.h>
 
-unsigned long unwind_get_return_address(struct unwind_state *state)
+static unsigned long get_return_address(struct unwind_state *state)
 {
-	if (unwind_done(state))
-		return 0;
 	return state->pc;
 }
-EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
-void unwind_start(struct unwind_state *state, struct task_struct *task,
+static void start(struct unwind_state *state, struct task_struct *task,
 		    struct pt_regs *regs)
 {
-	memset(state, 0, sizeof(*state));
-
-	if (regs) {
-		state->sp = regs->regs[3];
-		state->pc = regs->csr_era;
-	} else if (task == current || task == NULL) {
-		state->sp = (unsigned long)__builtin_frame_address(0);
-		state->pc = (unsigned long)__builtin_return_address(0);
-	} else {
-		state->sp = thread_saved_fp(task);
-		state->pc = thread_saved_ra(task);
-	}
-
-	state->task = task;
-	state->first = true;
-	state->pc = unwind_graph_addr(state, state->pc, state->sp);
-	get_stack_info(state->sp, state->task, &state->stack_info);
-
 	if (!unwind_done(state) && !__kernel_text_address(state->pc))
 		unwind_next_frame(state);
 }
-EXPORT_SYMBOL_GPL(unwind_start);
 
-bool unwind_next_frame(struct unwind_state *state)
+static bool next_frame(struct unwind_state *state)
 {
 	struct stack_info *info = &state->stack_info;
 	unsigned long addr;
 
-	if (unwind_done(state))
-		return false;
-
-	if (state->first)
-		state->first = false;
-
 	do {
 		for (state->sp += sizeof(unsigned long);
 		     state->sp < info->end;
@@ -68,4 +40,9 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(unwind_next_frame);
+
+const struct unwinder_ops unwinder_guess = {
+	.unwind_start = start,
+	.unwind_next_frame = next_frame,
+	.unwind_get_return_address = get_return_address,
+};
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index f7994ed05f04..beb57ea24da2 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -19,31 +19,19 @@ static inline void unwind_state_fixup(struct unwind_state *state)
 #endif
 }
 
-unsigned long unwind_get_return_address(struct unwind_state *state)
+static unsigned long get_return_address(struct unwind_state *state)
 {
-	if (unwind_done(state))
-		return 0;
 	return state->pc;
 }
-EXPORT_SYMBOL_GPL(unwind_get_return_address);
-
-static bool unwind_by_guess(struct unwind_state *state)
-{
-	struct stack_info *info = &state->stack_info;
-	unsigned long addr;
-
-	for (state->sp += sizeof(unsigned long);
-	     state->sp < info->end;
-	     state->sp += sizeof(unsigned long)) {
-		addr = *(unsigned long *)(state->sp);
-		state->pc = unwind_graph_addr(state, addr, state->sp + 8);
-		if (__kernel_text_address(state->pc))
-			return true;
-	}
-
-	return false;
-}
 
+/*
+ * LoongArch function prologue like follows,
+ *     [others instructions not use stack var]
+ *     addi.d sp, sp, -imm
+ *     st.d   xx, sp, offset <- save callee saved regs and
+ *     st.d   yy, sp, offset    save ra if function is nest.
+ *     [others instructions]
+ */
 static bool unwind_by_prologue(struct unwind_state *state)
 {
 	long frame_ra = -1;
@@ -89,6 +77,10 @@ static bool unwind_by_prologue(struct unwind_state *state)
 		ip++;
 	}
 
+	/*
+	 * Not find stack alloc action, PC may be in a leaf function. Only the
+	 * first being true is reasonable, otherwise indicate analysis is broken.
+	 */
 	if (!frame_size) {
 		if (state->first)
 			goto first;
@@ -106,6 +98,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
 		ip++;
 	}
 
+	/* Not find save $ra action, PC may be in a leaf function, too. */
 	if (frame_ra < 0) {
 		if (state->first) {
 			state->sp = state->sp + frame_size;
@@ -114,96 +107,63 @@ static bool unwind_by_prologue(struct unwind_state *state)
 		return false;
 	}
 
-	if (state->first)
-		state->first = false;
-
 	state->pc = *(unsigned long *)(state->sp + frame_ra);
 	state->sp = state->sp + frame_size;
 	goto out;
 
 first:
-	state->first = false;
-	if (state->pc == state->ra)
-		return false;
-
 	state->pc = state->ra;
 
 out:
+	state->first = false;
 	unwind_state_fixup(state);
 	return !!__kernel_text_address(state->pc);
 }
 
-void unwind_start(struct unwind_state *state, struct task_struct *task,
+static void start(struct unwind_state *state, struct task_struct *task,
 		    struct pt_regs *regs)
 {
-	memset(state, 0, sizeof(*state));
-	state->type = UNWINDER_PROLOGUE;
-
-	if (regs) {
-		state->sp = regs->regs[3];
-		state->pc = regs->csr_era;
-		state->ra = regs->regs[1];
-		if (!__kernel_text_address(state->pc))
-			state->type = UNWINDER_GUESS;
-	} else if (task == current || task == NULL) {
-		state->sp = (unsigned long)__builtin_frame_address(0);
-		state->pc = (unsigned long)__builtin_return_address(0);
-		state->ra = 0;
-	} else {
-		state->sp = thread_saved_fp(task);
-		state->pc = thread_saved_ra(task);
-		state->ra = 0;
-	}
-
-	state->task = task;
 	state->first = true;
-	state->pc = unwind_graph_addr(state, state->pc, state->sp);
-	get_stack_info(state->sp, state->task, &state->stack_info);
 
-	if (!unwind_done(state) && !__kernel_text_address(state->pc))
-		unwind_next_frame(state);
+	/*
+	 * The current PC is not kernel text address, we cannot find its
+	 * relative symbol. Thus, prologue analysis will be broken. Luckly,
+	 * we can use the guess unwinder.
+	 */
+	if (!__kernel_text_address(state->pc)) {
+		unwind_register_unwinder(state, &unwinder_guess);
+		if (!unwind_done(state))
+			unwind_next_frame(state);
+	}
 }
-EXPORT_SYMBOL_GPL(unwind_start);
 
-bool unwind_next_frame(struct unwind_state *state)
+static bool next_frame(struct unwind_state *state)
 {
 	struct stack_info *info = &state->stack_info;
 	struct pt_regs *regs;
 	unsigned long pc;
 
-	if (unwind_done(state))
-		return false;
-
 	do {
-		switch (state->type) {
-		case UNWINDER_GUESS:
-			state->first = false;
-			if (unwind_by_guess(state))
-				return true;
-			break;
-
-		case UNWINDER_PROLOGUE:
-			if (unwind_by_prologue(state)) {
-				state->pc = unwind_graph_addr(state, state->pc, state->sp);
-				return true;
-			}
+		if (unwind_by_prologue(state)) {
+			state->pc = unwind_graph_addr(state, state->pc, state->sp);
+			return true;
+		}
 
-			if (info->type == STACK_TYPE_IRQ &&
-				info->end == state->sp) {
-				regs = (struct pt_regs *)info->next_sp;
-				pc = regs->csr_era;
+		if (info->type == STACK_TYPE_IRQ &&
+		    info->end == state->sp) {
+			regs = (struct pt_regs *)info->next_sp;
+			pc = regs->csr_era;
 
-				if (user_mode(regs) || !__kernel_text_address(pc))
-					return false;
+			if (user_mode(regs) || !__kernel_text_address(pc))
+				return false;
 
-				state->first = true;
-				state->ra = regs->regs[1];
-				state->sp = regs->regs[3];
-				state->pc = pc;
-				get_stack_info(state->sp, state->task, info);
+			state->first = true;
+			state->ra = regs->regs[1];
+			state->sp = regs->regs[3];
+			state->pc = pc;
+			get_stack_info(state->sp, state->task, info);
 
-				return true;
-			}
+			return true;
 		}
 
 		state->sp = info->next_sp;
@@ -212,4 +172,9 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	return false;
 }
-EXPORT_SYMBOL_GPL(unwind_next_frame);
+
+const struct unwinder_ops unwinder_prologue = {
+	.unwind_start = start,
+	.unwind_next_frame = next_frame,
+	.unwind_get_return_address = get_return_address,
+};
-- 
2.34.3

