Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE04A5BC1B4
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiISDRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:17:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiISDQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:16:49 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 89A7213CCA
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:16:47 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvmsQ3ydjUW4dAA--.34031S10;
        Mon, 19 Sep 2022 11:16:43 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v5 08/10] LoongArch/ftrace: Add HAVE_FUNCTION_GRAPH_RET_ADDR_PTR support
Date:   Mon, 19 Sep 2022 11:16:30 +0800
Message-Id: <20220919031632.15374-9-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220919031632.15374-1-zhangqing@loongson.cn>
References: <20220919031632.15374-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxvmsQ3ydjUW4dAA--.34031S10
X-Coremail-Antispam: 1UD129KBjvJXoWxAr43CF45Zr4xCr1fZr4ktFb_yoWrKF18pF
        9rCas5GrWxWF9agrnFqr1Uur4kGr9rCw12ga9Fy34FkFsFqF13WrnFvryDXFWkt3ykW3yI
        q3Z5GrZ0ka1UX3JanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUBqb7Iv0xC_KF4lb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI
        8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28C
        jxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI
        8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
        x4A2jsIEc7CjxVAFwI0_Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
        xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8
        JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc2xSY4AK67AK6r48MxAIw2
        8IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4l
        x2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrw
        CI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI
        42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z2
        80aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EdgtUUUUU==
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
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
index 807226aad1c0..2a676ece4857 100644
--- a/arch/loongarch/include/asm/ftrace.h
+++ b/arch/loongarch/include/asm/ftrace.h
@@ -10,6 +10,8 @@
 #define FTRACE_REGS_PLT_IDX	1
 #define NR_FTRACE_PLTS		2
 
+#define GRAPH_FAKE_OFFSET (sizeof(struct pt_regs) - offsetof(struct pt_regs, regs[1]))
+
 #ifdef CONFIG_FUNCTION_TRACER
 #define MCOUNT_INSN_SIZE 4		/* sizeof mcount call */
 
@@ -37,6 +39,7 @@ void ftrace_graph_func(unsigned long ip, unsigned long parent_ip,
 #endif
 
 #ifdef CONFIG_DYNAMIC_FTRACE
+#define HAVE_FUNCTION_GRAPH_RET_ADDR_PTR
 static inline unsigned long ftrace_call_adjust(unsigned long addr)
 {
 	return addr;
diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index 6af4718bdf01..f66b07c3e6a1 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -21,6 +21,7 @@ struct unwind_state {
 	struct stack_info stack_info;
 	struct task_struct *task;
 	bool first, error;
+	int graph_idx;
 	unsigned long sp, pc, ra;
 };
 
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index dd37185d446e..b070ce225989 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -219,7 +219,7 @@ void prepare_ftrace_return(unsigned long self_addr, unsigned long *parent)
 
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
index b206d9159205..f77f3b6f3f06 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -2,6 +2,7 @@
 /*
  * Copyright (C) 2022 Loongson Technology Corporation Limited
  */
+#include <linux/ftrace.h>
 #include <linux/kallsyms.h>
 
 #include <asm/inst.h>
@@ -32,6 +33,8 @@ static bool unwind_by_guess(struct unwind_state *state)
 	     state->sp < info->end;
 	     state->sp += sizeof(unsigned long)) {
 		addr = *(unsigned long *)(state->sp);
+		state->pc = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+			addr, (unsigned long *)(state->sp - GRAPH_FAKE_OFFSET));
 		if (__kernel_text_address(addr))
 			return true;
 	}
@@ -146,8 +149,11 @@ bool unwind_next_frame(struct unwind_state *state)
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
@@ -157,8 +163,9 @@ bool unwind_next_frame(struct unwind_state *state)
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
2.36.1

