Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD58666803
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 01:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbjALAmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 19:42:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236619AbjALAlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 19:41:19 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 63A4BA1AC
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 16:41:14 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8Ax3eopV79jlRMBAA--.3377S3;
        Thu, 12 Jan 2023 08:41:13 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Axfb4oV79jNyIYAA--.47594S2;
        Thu, 12 Jan 2023 08:41:12 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Qing Zhang <zhangqing@loongson.cn>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v3 5/5] LoongArch: Add generic ex-handler unwind in prologue unwinder
Date:   Thu, 12 Jan 2023 08:40:48 +0800
Message-Id: <20230112004048.26191-1-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Axfb4oV79jNyIYAA--.47594S2
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3XF15XF48Wr4DXFWDXF1rtFb_yoWxWF4kpF
        9akrn5Gr4rKr9Fqry7Jryv9r98Aws7Cw12gasrKas5CF1Iqry3WrnYy34qvF1DJ3y8WFyI
        qFs3Xrya9a1UJa7anT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        bfAYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kK
        e7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
        0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2z280
        aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4
        kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI
        1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_Jr
        Wlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj
        6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr
        0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUv
        cSsGvfC2KfnxnUUI43ZEXa7IUneRRtUUUUU==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When exception is triggered, code flow go handle_\exception in some
cases. One of stackframe in this case as follows,

high -> +-------+
        | REGS  |  <- a pt_regs
        |       |
        |       |  <- ex trigger
        | REGS  |  <- ex pt_regs   <-+
        |       |                    |
        |       |                    |
low  -> +-------+           ->unwind-+

When unwinder unwind to handler_\exception it cannot go on prologue
analysis. It is asynchronous code flow, we should get the next frame
PC from regs->csr_era but not from regs->regs[1]. And we copy the
handler codes to eentry in the early time and copy the handler codes
to NUMA-relative memory named pcpu_handlers if NUMA is enabled. Thus,
unwinder cannot unwind normally. Therefore, try to give some hint in
handler_\exception and fixup it in unwind_next_frame.

Reported-by: Qing Zhang <zhangqing@loongson.cn>
Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/include/asm/unwind.h     |   2 +-
 arch/loongarch/kernel/genex.S           |   3 +
 arch/loongarch/kernel/unwind_prologue.c | 100 +++++++++++++++++++++---
 arch/loongarch/mm/tlb.c                 |   2 +-
 4 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index cb428e1b19af..a38eb152aefb 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -22,7 +22,7 @@ struct unwind_state {
 	char type; /* UNWINDER_XXX */
 	struct stack_info stack_info;
 	struct task_struct *task;
-	bool first, error, is_ftrace;
+	bool first, error, reset;
 	int graph_idx;
 	unsigned long sp, pc, ra;
 };
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 75e5be807a0d..7e5c293ed89f 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -67,14 +67,17 @@ SYM_FUNC_END(except_vec_cex)
 	.macro	BUILD_HANDLER exception handler prep
 	.align	5
 	SYM_FUNC_START(handle_\exception)
+	666:
 	BACKUP_T0T1
 	SAVE_ALL
 	build_prep_\prep
 	move	a0, sp
 	la.abs	t0, do_\handler
 	jirl	ra, t0, 0
+	668:
 	RESTORE_ALL_AND_RET
 	SYM_FUNC_END(handle_\exception)
+	SYM_DATA(unwind_hint_\exception, .word 668b - 666b)
 	.endm
 
 	BUILD_HANDLER ade ade badv
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index e6c3f2ee507c..e52c18c2b604 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -2,21 +2,100 @@
 /*
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/cpumask.h>
 #include <linux/ftrace.h>
 #include <linux/kallsyms.h>
 
 #include <asm/inst.h>
+#include <asm/loongson.h>
 #include <asm/ptrace.h>
+#include <asm/setup.h>
 #include <asm/unwind.h>
 
-static inline void unwind_state_fixup(struct unwind_state *state)
+extern const int unwind_hint_ade;
+extern const int unwind_hint_ale;
+extern const int unwind_hint_bp;
+extern const int unwind_hint_fpe;
+extern const int unwind_hint_fpu;
+extern const int unwind_hint_lsx;
+extern const int unwind_hint_lasx;
+extern const int unwind_hint_lbt;
+extern const int unwind_hint_ri;
+extern const int unwind_hint_watch;
+extern unsigned long eentry;
+#ifdef CONFIG_NUMA
+extern unsigned long pcpu_handlers[NR_CPUS];
+#endif
+
+static inline bool scan_handler(unsigned long entry_offset)
 {
-#ifdef CONFIG_DYNAMIC_FTRACE
-	static unsigned long ftrace = (unsigned long)ftrace_call + 4;
+	int idx, offset;
 
-	if (state->pc == ftrace)
-		state->is_ftrace = true;
+	if (entry_offset >= EXCCODE_INT_START * VECSIZE)
+		return false;
+
+	idx = entry_offset / VECSIZE;
+	offset = entry_offset % VECSIZE;
+	switch (idx) {
+	case EXCCODE_ADE:
+		return offset == unwind_hint_ade;
+	case EXCCODE_ALE:
+		return offset == unwind_hint_ale;
+	case EXCCODE_BP:
+		return offset == unwind_hint_bp;
+	case EXCCODE_FPE:
+		return offset == unwind_hint_fpe;
+	case EXCCODE_FPDIS:
+		return offset == unwind_hint_fpu;
+	case EXCCODE_LSXDIS:
+		return offset == unwind_hint_lsx;
+	case EXCCODE_LASXDIS:
+		return offset == unwind_hint_lasx;
+	case EXCCODE_BTDIS:
+		return offset == unwind_hint_lbt;
+	case EXCCODE_INE:
+		return offset == unwind_hint_ri;
+	case EXCCODE_WATCH:
+		return offset == unwind_hint_watch;
+	default:
+		return false;
+	}
+}
+
+static inline bool fix_exceptions(unsigned long pc)
+{
+#ifdef CONFIG_NUMA
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (!pcpu_handlers[cpu])
+			continue;
+		if (scan_handler(pc - pcpu_handlers[cpu]))
+			return true;
+	}
 #endif
+	return scan_handler(pc - eentry);
+}
+
+/*
+ * As we meet ftrace_regs_entry, reset first flag like first doing
+ * tracing. Prologue analysis will stop soon because PC is at entry.
+ */
+static inline bool fix_ftrace(unsigned long pc)
+{
+#ifdef CONFIG_DYNAMIC_FTRACE
+	return pc == (unsigned long)ftrace_call + LOONGARCH_INSN_SIZE;
+#else
+	return false;
+#endif
+}
+
+static inline bool unwind_state_fixup(struct unwind_state *state)
+{
+	if (!fix_exceptions(state->pc) && !fix_ftrace(state->pc))
+		return false;
+	state->reset = true;
+	return true;
 }
 
 /*
@@ -39,14 +118,10 @@ static bool unwind_by_prologue(struct unwind_state *state)
 	if (state->sp >= info->end || state->sp < info->begin)
 		return false;
 
-	if (state->is_ftrace) {
-		/*
-		 * As we meet ftrace_regs_entry, reset first flag like first doing
-		 * tracing. Prologue analysis will stop soon because PC is at entry.
-		 */
+	if (state->reset) {
 		regs = (struct pt_regs *)state->sp;
 		state->first = true;
-		state->is_ftrace = false;
+		state->reset = false;
 		state->pc = regs->csr_era;
 		state->ra = regs->regs[1];
 		state->sp = regs->regs[3];
@@ -111,8 +186,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
 
 out:
 	state->first = false;
-	unwind_state_fixup(state);
-	return !!__kernel_text_address(state->pc);
+	return unwind_state_fixup(state) || __kernel_text_address(state->pc);
 }
 
 static bool next_frame(struct unwind_state *state)
diff --git a/arch/loongarch/mm/tlb.c b/arch/loongarch/mm/tlb.c
index da3681f131c8..8bad6b0cff59 100644
--- a/arch/loongarch/mm/tlb.c
+++ b/arch/loongarch/mm/tlb.c
@@ -251,7 +251,7 @@ static void output_pgtable_bits_defines(void)
 }
 
 #ifdef CONFIG_NUMA
-static unsigned long pcpu_handlers[NR_CPUS];
+unsigned long pcpu_handlers[NR_CPUS];
 #endif
 extern long exception_handlers[VECSIZE * 128 / sizeof(long)];
 
-- 
2.34.3

