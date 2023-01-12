Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14836667E2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:37:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236304AbjALAhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:37:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbjALAhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:37:09 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC24D3FA08
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:36:58 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8CxIfApVr9j7RIBAA--.3608S3;
        Thu, 12 Jan 2023 08:36:57 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbL4kVr9jLyEYAA--.43573S6;
        Thu, 12 Jan 2023 08:36:56 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 4/5] LoongArch: Strip guess_unwinder out from prologue_unwinder
Date:   Thu, 12 Jan 2023 08:36:26 +0800
Message-Id: <20230112003627.26111-5-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230112003627.26111-1-hejinyang@loongson.cn>
References: <20230112003627.26111-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxbL4kVr9jLyEYAA--.43573S6
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvAXoW3KryfuFy8Kry8ZFykGrWxWFg_yoW8JF4kAo
        WayF4agr48Aay5t3yjyryUJFyYgr4jka1DA3y3trn8WF47A345urW0qasxJFyIqwn5KrWU
        GrW2gF4rXws7Arn3n29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG6rWj6s
        0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
        ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWrXwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj
        6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==
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
unwinder type in unwind_state. Make guess_unwinder::unwind_next_frame()
as default way when other unwinders cannot unwind in some extreme case.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/include/asm/unwind.h     |  29 +++++
 arch/loongarch/kernel/Makefile          |   2 +-
 arch/loongarch/kernel/traps.c           |   3 -
 arch/loongarch/kernel/unwind.c          |  33 +++++
 arch/loongarch/kernel/unwind_guess.c    |  51 +-------
 arch/loongarch/kernel/unwind_prologue.c | 153 ++++++++++--------------
 6 files changed, 129 insertions(+), 142 deletions(-)
 create mode 100644 arch/loongarch/kernel/unwind.c

diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index 6ece48f0ff77..cb428e1b19af 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -27,6 +27,8 @@ struct unwind_state {
 	unsigned long sp, pc, ra;
 };
 
+extern bool default_next_frame(struct unwind_state *state);
+
 void unwind_start(struct unwind_state *state,
 		  struct task_struct *task, struct pt_regs *regs);
 bool unwind_next_frame(struct unwind_state *state);
@@ -49,4 +51,31 @@ static inline unsigned long unwind_graph_addr(struct unwind_state *state,
 	return ftrace_graph_ret_addr(state->task, &state->graph_idx,
 				     pc, (unsigned long *)(cfa - GRAPH_FAKE_OFFSET));
 }
+
+static __always_inline void __unwind_start(struct unwind_state *state,
+					struct task_struct *task, struct pt_regs *regs)
+{
+	memset(state, 0, sizeof(*state));
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
+}
+
+static inline unsigned long __unwind_get_return_address(struct unwind_state *state)
+{
+	return unwind_done(state) ? 0 : state->pc;
+}
 #endif /* _ASM_UNWIND_H */
diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makefile
index fcaa024a685e..c8cfbd562921 100644
--- a/arch/loongarch/kernel/Makefile
+++ b/arch/loongarch/kernel/Makefile
@@ -8,7 +8,7 @@ extra-y		:= vmlinux.lds
 obj-y		+= head.o cpu-probe.o cacheinfo.o env.o setup.o entry.o genex.o \
 		   traps.o irq.o idle.o process.o dma.o mem.o io.o reset.o switch.o \
 		   elf.o syscall.o signal.o time.o topology.o inst.o ptrace.o vdso.o \
-		   alternative.o unaligned.o
+		   alternative.o unaligned.o unwind.o
 
 obj-$(CONFIG_ACPI)		+= acpi.o
 obj-$(CONFIG_EFI) 		+= efi.o
diff --git a/arch/loongarch/kernel/traps.c b/arch/loongarch/kernel/traps.c
index a19bb329123b..8029757c50bd 100644
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
index 000000000000..58a5051f1797
--- /dev/null
+++ b/arch/loongarch/kernel/unwind.c
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2023 Loongson Technology Corporation Limited
+ */
+#include <linux/kernel.h>
+#include <linux/ftrace.h>
+
+#include <asm/unwind.h>
+
+bool default_next_frame(struct unwind_state *state)
+{
+	struct stack_info *info = &state->stack_info;
+	unsigned long addr;
+
+	if (unwind_done(state))
+		return false;
+
+	do {
+		for (state->sp += sizeof(unsigned long);
+		     state->sp < info->end;
+		     state->sp += sizeof(unsigned long)) {
+			addr = *(unsigned long *)(state->sp);
+			state->pc = unwind_graph_addr(state, addr, state->sp + 8);
+			if (__kernel_text_address(state->pc))
+				return true;
+		}
+
+		state->sp = info->next_sp;
+
+	} while (!get_stack_info(state->sp, state->task, info));
+
+	return false;
+}
diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
index 935d24f8c95c..98379b7d4147 100644
--- a/arch/loongarch/kernel/unwind_guess.c
+++ b/arch/loongarch/kernel/unwind_guess.c
@@ -2,40 +2,18 @@
 /*
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
-#include <linux/kernel.h>
-#include <linux/ftrace.h>
-
 #include <asm/unwind.h>
 
 unsigned long unwind_get_return_address(struct unwind_state *state)
 {
-	if (unwind_done(state))
-		return 0;
-	return state->pc;
+	return __unwind_get_return_address(state);
 }
 EXPORT_SYMBOL_GPL(unwind_get_return_address);
 
 void unwind_start(struct unwind_state *state, struct task_struct *task,
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
+	__unwind_start(state, task, regs);
 	if (!unwind_done(state) && !__kernel_text_address(state->pc))
 		unwind_next_frame(state);
 }
@@ -43,29 +21,6 @@ EXPORT_SYMBOL_GPL(unwind_start);
 
 bool unwind_next_frame(struct unwind_state *state)
 {
-	struct stack_info *info = &state->stack_info;
-	unsigned long addr;
-
-	if (unwind_done(state))
-		return false;
-
-	if (state->first)
-		state->first = false;
-
-	do {
-		for (state->sp += sizeof(unsigned long);
-		     state->sp < info->end;
-		     state->sp += sizeof(unsigned long)) {
-			addr = *(unsigned long *)(state->sp);
-			state->pc = unwind_graph_addr(state, addr, state->sp + 8);
-			if (__kernel_text_address(state->pc))
-				return true;
-		}
-
-		state->sp = info->next_sp;
-
-	} while (!get_stack_info(state->sp, state->task, info));
-
-	return false;
+	return default_next_frame(state);
 }
 EXPORT_SYMBOL_GPL(unwind_next_frame);
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index f7994ed05f04..e6c3f2ee507c 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -19,31 +19,14 @@ static inline void unwind_state_fixup(struct unwind_state *state)
 #endif
 }
 
-unsigned long unwind_get_return_address(struct unwind_state *state)
-{
-	if (unwind_done(state))
-		return 0;
-	return state->pc;
-}
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
-
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
@@ -89,6 +72,10 @@ static bool unwind_by_prologue(struct unwind_state *state)
 		ip++;
 	}
 
+	/*
+	 * Not find stack alloc action, PC may be in a leaf function. Only the
+	 * first being true is reasonable, otherwise indicate analysis is broken.
+	 */
 	if (!frame_size) {
 		if (state->first)
 			goto first;
@@ -106,6 +93,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
 		ip++;
 	}
 
+	/* Not find save $ra action, PC may be in a leaf function, too. */
 	if (frame_ra < 0) {
 		if (state->first) {
 			state->sp = state->sp + frame_size;
@@ -114,58 +102,20 @@ static bool unwind_by_prologue(struct unwind_state *state)
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
-		    struct pt_regs *regs)
-{
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
-	state->first = true;
-	state->pc = unwind_graph_addr(state, state->pc, state->sp);
-	get_stack_info(state->sp, state->task, &state->stack_info);
-
-	if (!unwind_done(state) && !__kernel_text_address(state->pc))
-		unwind_next_frame(state);
-}
-EXPORT_SYMBOL_GPL(unwind_start);
-
-bool unwind_next_frame(struct unwind_state *state)
+static bool next_frame(struct unwind_state *state)
 {
 	struct stack_info *info = &state->stack_info;
 	struct pt_regs *regs;
@@ -175,35 +125,26 @@ bool unwind_next_frame(struct unwind_state *state)
 		return false;
 
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
@@ -212,4 +153,36 @@ bool unwind_next_frame(struct unwind_state *state)
 
 	return false;
 }
+
+unsigned long unwind_get_return_address(struct unwind_state *state)
+{
+	return __unwind_get_return_address(state);
+}
+EXPORT_SYMBOL_GPL(unwind_get_return_address);
+
+void unwind_start(struct unwind_state *state, struct task_struct *task,
+		    struct pt_regs *regs)
+{
+	__unwind_start(state, task, regs);
+	state->type = UNWINDER_PROLOGUE;
+	state->first = true;
+
+	/*
+	 * The current PC is not kernel text address, we cannot find its
+	 * relative symbol. Thus, prologue analysis will be broken. Luckly,
+	 * we can use the default next_frame.
+	 */
+	if (!__kernel_text_address(state->pc)) {
+		state->type = UNWINDER_GUESS;
+		if (!unwind_done(state))
+			unwind_next_frame(state);
+	}
+}
+EXPORT_SYMBOL_GPL(unwind_start);
+
+bool unwind_next_frame(struct unwind_state *state)
+{
+	return state->type == UNWINDER_PROLOGUE ?
+				next_frame(state) : default_next_frame(state);
+}
 EXPORT_SYMBOL_GPL(unwind_next_frame);
-- 
2.34.3

