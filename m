Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EDCE62903E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 03:57:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbiKOC5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 21:57:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiKOC5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 21:57:01 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 929CD1EC64
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 18:55:37 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8Bx37el_3JjhR8HAA--.16416S3;
        Tue, 15 Nov 2022 10:55:33 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxLuKf_3JjmywTAA--.51398S9;
        Tue, 15 Nov 2022 10:55:32 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/9] LoongArch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
Date:   Tue, 15 Nov 2022 10:55:25 +0800
Message-Id: <20221115025527.13382-8-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221115025527.13382-1-zhangqing@loongson.cn>
References: <20221115025527.13382-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxLuKf_3JjmywTAA--.51398S9
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr43CF45Zr4xCr1fZr4ktFb_yoWrKFyUpF
        9xCas5GrWxGF9agrnFqr1j9r4kGrn7Cw1agasFy34FkFsFqFy7Wrn2vryqqF4kt3ykWrWI
        g3Z5G390ka1UX3JanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        b3AYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4
        x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1l
        n4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
        ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26rWY6Fy7McIj6I8E
        87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
        IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
        xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
        126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY
        6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
        AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
        vjxUVCD7UUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_FILL_THIS_FORM_SHORT autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace_graph_ret_addr can be called by stack unwinding code to convert
a found stack return address ('ret') to its original value, in case the
function graph tracer has modified it to be 'return_to_handler',If the
hasn't been modified, the unchanged value of 'ret' is returned.

Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/ftrace.h     |  3 +++
 arch/loongarch/include/asm/unwind.h     |  1 +
 arch/loongarch/kernel/ftrace_dyn.c      |  2 +-
 arch/loongarch/kernel/unwind_guess.c    |  4 +++-
 arch/loongarch/kernel/unwind_prologue.c | 11 +++++++++--
 5 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/arch/loongarch/include/asm/ftrace.h b/arch/loongarch/include/asm/ftrace.h
index 5cc13ae48164..1583ec2171fc 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -6,6 +6,8 @@
 #ifndef _ASM_LOONGARCH_FTRACE_H
 #define _ASM_LOONGARCH_FTRACE_H
 
+#define GRAPH_FAKE_OFFSET (sizeof(struct pt_regs) - offsetof(struct pt_regs, regs[1]))
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
@@ -33,6 +35,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	return addr;
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index a51eec00efb8..f2b52b9ea93d 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -21,6 +21,7 @@ struct unwind_state {
 	struct stack_info stack_info;
 	struct task_struct *task;
 	bool first, error, is_ftrace;
+	int graph_idx;
 	unsigned long sp, pc, ra;
 };
 
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index f538829312d7..cd64887e26b5 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -140,7 +140,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
 
 	old = *parent;
 
-	if (!function_graph_enter(old, self_addr, 0, NULL))
+	if (!function_graph_enter(old, self_addr, 0, parent))
 		*parent = return_hooker;
 }
 
diff --git a/arch/loongarch/kernel/unwind_guess.c b/arch/loongarch/kernel/unwind_guess.c
index 5afa6064d73e..229ba014cea0 100644
--- a/arch/loongarch/kernel/unwind_guess.c
+++ b/arch/loongarch/kernel/unwind_guess.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/ftrace.h>
 #include <linux/kernel.h>
 
 #include <asm/unwind.h>
@@ -53,7 +54,8 @@ bool unwind_next_frame(struct unwind_state *state)
 		     state->sp < info->end;
 		     state->sp += sizeof(unsigned long)) {
 			addr = *(unsigned long *)(state->sp);
-
+			state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+				addr, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 			if (__kernel_text_address(addr))
 				return true;
 		}
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index c5df4ae73e0d..48f7a120ec27 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/ftrace.h>
 #include <linux/kallsyms.h>
 
 #include <asm/inst.h>
@@ -30,6 +31,8 @@ static bool unwind_by_guess(struct unwind_state *state)
 	     state->sp < info->end;
 	     state->sp += sizeof(unsigned long)) {
 		addr = *(unsigned long *)(state->sp);
+		state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+			addr, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 		if (__kernel_text_address(addr))
 			return true;
 	}
@@ -171,8 +174,11 @@ bool unwind_next_frame(struct unwind_state *state)
 			break;
 
 		case UNWINDER_PROLOGUE:
-			if (unwind_by_prologue(state))
+			if (unwind_by_prologue(state)) {
+				state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+					state->pc, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 				return true;
+			}
 
 			if (info->type == STACK_TYPE_IRQ &&
 				info->end == state->sp) {
@@ -182,8 +188,9 @@ bool unwind_next_frame(struct unwind_state *state)
 				if (user_mode(regs) || !__kernel_text_address(pc))
 					return false;
 
-				state->pc = pc;
 				state->sp = regs->regs[3];
+				state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+					pc, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 				state->ra = regs->regs[1];
 				state->first = true;
 				get_stack_info(state->sp, state->task, info);
-- 
2.36.0

