Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F221F62B18F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 03:54:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiKPCyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 21:54:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbiKPCxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 21:53:40 -0500
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF56C2189
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 18:53:35 -0800 (PST)
Received: from loongson.cn (unknown [113.200.148.30])
        by gateway (Coremail) with SMTP id _____8DxTtuuUHRjuJEHAA--.22333S3;
        Wed, 16 Nov 2022 10:53:34 +0800 (CST)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8Dx9VakUHRjO1MUAA--.35612S9;
        Wed, 16 Nov 2022 10:53:34 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v7 7/9] LoongArch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
Date:   Wed, 16 Nov 2022 10:53:22 +0800
Message-Id: <20221116025324.1624-8-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20221116025324.1624-1-zhangqing@loongson.cn>
References: <20221116025324.1624-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8Dx9VakUHRjO1MUAA--.35612S9
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBjvJXoWxAr43CF45Zr4xCr1fZr4ktFb_yoWrKFyUpF
        9xCas5GrWxGF9agrnFqr1j9r4kGrn7Cw1agasFy34FkFsFqFy7Wrn2vryqqF4kt3ykWrWI
        g3Z5G390ka1UX3JanT9S1TB71UUUUjUqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
        qI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUIcSsGvfJTRUUU
        baxYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s
        1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
        wVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84
        ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr0_Cr1U
        M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zV
        CFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWrXVW3AwAv7VC2
        z280aVAFwI0_Cr0_Gr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04
        k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC2
        0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
        0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW5JVW7JwCI42IY6xIIjxv2
        0xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2js
        IE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZF
        pf9x07jxSdgUUUUU=
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

