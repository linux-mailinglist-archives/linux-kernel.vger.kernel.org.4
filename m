Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA796A5418
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 09:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjB1IEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 03:04:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjB1IEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 03:04:11 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96053FF0D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 00:03:47 -0800 (PST)
Received: from loongson.cn (unknown [111.9.175.10])
        by gateway (Coremail) with SMTP id _____8CxQMxdtf1j_mUGAA--.6519S3;
        Tue, 28 Feb 2023 16:03:41 +0800 (CST)
Received: from localhost.localdomain (unknown [111.9.175.10])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxB707tf1jb3tAAA--.49681S7;
        Tue, 28 Feb 2023 16:03:38 +0800 (CST)
From:   Jinyang He <hejinyang@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>
Cc:     Xi Ruoyao <xry111@xry111.site>,
        Youling Tang <tangyouling@loongson.cn>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/6] LoongArch: Fix up the prologue unwinder unwind exception frame
Date:   Tue, 28 Feb 2023 16:02:56 +0800
Message-Id: <20230228080257.28807-6-hejinyang@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230228080257.28807-1-hejinyang@loongson.cn>
References: <20230228080257.28807-1-hejinyang@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxB707tf1jb3tAAA--.49681S7
X-CM-SenderInfo: pkhmx0p1dqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoW3GryDAr43AF48uFy5tw45trb_yoW7AF48pF
        nrAF1kGrWrWasaqryDtryDur98A3s3Gw1aga9rKa4rCF17XF15Wr1vvryDZFyjqaykXrW0
        qFyfGFyY9F4Uta7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b7kYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AI
        xVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64
        kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8JVWxJwAm
        72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I
        0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
        GVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
        0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
        rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
        4UJbIYCTnIWIevJa73UjIFyTuYvjxUcCD7UUUUU
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_SBL_CSS,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
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

