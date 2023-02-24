Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF0A6A19B3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjBXKLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjBXKLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:11:30 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84C6439CED
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:10:56 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8Dxj80vjfhjsqQEAA--.3601S3;
        Fri, 24 Feb 2023 18:10:55 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxX+QjjfhjNH86AA--.6368S7;
        Fri, 24 Feb 2023 18:10:55 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] LoongArch: Fix up the prologue unwinder unwind exception frame
Date:   Fri, 24 Feb 2023 18:10:12 +0800
Message-Id: <20230224101013.26971-6-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230224101013.26971-1-hejinyang@loongson.cn>
References: <20230224101013.26971-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxX+QjjfhjNH86AA--.6368S7
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GryDAr43AF48uFy5tw45trb_yoW7AF48pF
        nrAF1kGrWrWasaqryDtryDur98A3s3Gw1aga9rKa4rCF17XF15Wr1vvryDZFyjqaykXrW0
        qFyfGFyY9F4Uta7anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b28YFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2
        IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4U
        McvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCFx2
        IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
        6r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
        AKxVW5JVW7JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
        s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
        0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is a simply way to correct the unwind info when the special functions
influence the normal prologue analysis. We find out the position where
should unwind by PT_REGS, and mark it UNW_NEED_RESET. Linkers will
collect them and the prologue unwinder will compare them to pc.

Signed-off-by: Jinyang He <hejinyang@loongson.cn>
---
 arch/loongarch/include/asm/traps.h      | 13 +++++++++
 arch/loongarch/include/asm/unwind.h     |  2 +-
 arch/loongarch/kernel/genex.S           |  1 +
 arch/loongarch/kernel/mcount_dyn.S      |  2 ++
 arch/loongarch/kernel/unwind_prologue.c | 37 +++++++++----------------
 arch/loongarch/kernel/vmlinux.lds.S     |  9 ++++++
 6 files changed, 39 insertions(+), 25 deletions(-)

diff --git a/arch/loongarch/include/asm/traps.h b/arch/loongarch/include/asm/traps.h
index 8f276253f145..0c30a024a9e5 100644
--- a/arch/loongarch/include/asm/traps.h
+++ b/arch/loongarch/include/asm/traps.h
@@ -5,6 +5,7 @@
 #ifndef _ASM_TRAPS_H
 #define _ASM_TRAPS_H
 
+#include <asm/asm.h>
 #include <asm/loongarch.h>		// For EXCCODES
 
 #ifdef __ASSEMBLY__
@@ -35,11 +36,23 @@
 	__VA_ARGS__;						\
 	.popsection;
 
+#ifdef CONFIG_UNWINDER_PROLOGUE
+#define UNW_NEED_RESET						\
+	668:							\
+	.pushsection .unw_need_reset, "a";			\
+	PTR 668b;						\
+	.popsection;
+#else /* CONFIG_UNWINDER_PROLOGUE */
+#define UNW_NEED_RESET
+#endif
+
 #else /* __ASSEMBLY__ */
 
 #define VECSIZE	0x200
 extern void *__ex_handlers;
 extern void *__tlbr_entry;
+extern void *__unw_need_reset;
+extern void *__unw_need_reset_end;
 
 static inline void set_eentry(void *entry)
 {
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index b9dce87afd2e..d9a10e264bdd 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -22,7 +22,7 @@ struct unwind_state {
 	char type; /* UNWINDER_XXX */
 	struct stack_info stack_info;
 	struct task_struct *task;
-	bool first, error, reset;
+	bool first, error, need_reset;
 	int graph_idx;
 	unsigned long sp, pc, ra;
 };
diff --git a/arch/loongarch/kernel/genex.S b/arch/loongarch/kernel/genex.S
index 256e2e5b83d4..8705a7661ce9 100644
--- a/arch/loongarch/kernel/genex.S
+++ b/arch/loongarch/kernel/genex.S
@@ -78,6 +78,7 @@ SYM_FUNC_START(handle_\exception)
 	move	a0, sp
 	la_abs	t0, do_\handler
 	jirl	ra, t0, 0
+	UNW_NEED_RESET
 	RESTORE_ALL_AND_RET
 SYM_FUNC_END(handle_\exception)
 	.endm
diff --git a/arch/loongarch/kernel/mcount_dyn.S b/arch/loongarch/kernel/mcount_dyn.S
index bbabf06244c2..3550bab52ff0 100644
--- a/arch/loongarch/kernel/mcount_dyn.S
+++ b/arch/loongarch/kernel/mcount_dyn.S
@@ -7,6 +7,7 @@
 #include <asm/ftrace.h>
 #include <asm/regdef.h>
 #include <asm/stackframe.h>
+#include <asm/traps.h>
 
 	.text
 /*
@@ -81,6 +82,7 @@ SYM_CODE_START(ftrace_common)
 
 SYM_INNER_LABEL(ftrace_call, SYM_L_GLOBAL)
 	bl		ftrace_stub
+	UNW_NEED_RESET
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 SYM_INNER_LABEL(ftrace_graph_call, SYM_L_GLOBAL)
 	nop				/* b ftrace_graph_caller */
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index de18335c6ba6..aa01c881481c 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -10,33 +10,22 @@
 #include <asm/loongson.h>
 #include <asm/ptrace.h>
 #include <asm/setup.h>
+#include <asm/traps.h>
 #include <asm/unwind.h>
 
-static inline bool fix_exception(unsigned long pc)
-{
-	return false;
-}
-
-/*
- * As we meet ftrace_regs_entry, reset first flag like first doing
- * tracing. Prologue analysis will stop soon because PC is at entry.
- */
-static inline bool fix_ftrace(unsigned long pc)
-{
-#ifdef CONFIG_DYNAMIC_FTRACE
-	return pc == (unsigned long)ftrace_call + LOONGARCH_INSN_SIZE;
-#else
-	return false;
-#endif
-}
-
 static inline bool unwind_state_fixup(struct unwind_state *state)
 {
-	if (!fix_exception(state->pc) && !fix_ftrace(state->pc))
-		return false;
+	unsigned long *p = (unsigned long *)&__unw_need_reset;
+	unsigned long *q = (unsigned long *)&__unw_need_reset_end;
 
-	state->reset = true;
-	return true;
+	for (; p < q; p++) {
+		if (*p != state->pc)
+			continue;
+		state->need_reset = true;
+		return true;
+	}
+
+	return false;
 }
 
 /*
@@ -59,10 +48,10 @@ static bool unwind_by_prologue(struct unwind_state *state)
 	if (state->sp >= info->end || state->sp < info->begin)
 		return false;
 
-	if (state->reset) {
+	if (state->need_reset) {
 		regs = (struct pt_regs *)state->sp;
 		state->first = true;
-		state->reset = false;
+		state->need_reset = false;
 		state->pc = regs->csr_era;
 		state->ra = regs->regs[1];
 		state->sp = regs->regs[3];
diff --git a/arch/loongarch/kernel/vmlinux.lds.S b/arch/loongarch/kernel/vmlinux.lds.S
index e99b50359900..00f1f9061961 100644
--- a/arch/loongarch/kernel/vmlinux.lds.S
+++ b/arch/loongarch/kernel/vmlinux.lds.S
@@ -70,6 +70,15 @@ SECTIONS
 		*(.tlbrhandler)
 	}
 
+#ifdef CONFIG_UNWINDER_PROLOGUE
+	. = ALIGN(8);
+	.unw_need_reset : {
+		__unw_need_reset = .;
+		*(.unw_need_reset)
+		__unw_need_reset_end = .;
+	}
+#endif
+
 	/*
 	 * struct alt_inst entries. From the header (alternative.h):
 	 * "Alternative instructions for different CPU types or capabilities"
-- 
2.34.3

