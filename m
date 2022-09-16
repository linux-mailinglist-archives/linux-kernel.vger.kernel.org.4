Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3719D5BA4DC
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:58:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229888AbiIPC6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:58:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiIPC5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:57:32 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3C6939C1ED
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 19:57:31 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8BxXWsM5iNjV8kaAA--.41570S3;
        Fri, 16 Sep 2022 10:57:27 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH v4 10/10] LoongArch/ftrace: Fix unwind state when option func_stack_trace
Date:   Fri, 16 Sep 2022 10:57:16 +0800
Message-Id: <20220916025716.18864-2-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220916025716.18864-1-zhangqing@loongson.cn>
References: <20220916025716.18864-1-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8BxXWsM5iNjV8kaAA--.41570S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUtFWxKF4kGFWDXrW5Wrg_yoWrXrykpF
        95CF95Wr4Fgr97WrnrXr1j9rn5GrZayr17KF9rJw1rCFnFqryfXrnYya4DZFs8J3ykG3Wx
        XFsYkrya9w4UJaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUQC14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
        x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
        Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
        A2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
        M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
        xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCa
        FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x
        0262kKe7AKxVWUtVW8ZwCY02Avz4vE14v_Gr1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC
        6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s
        026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF
        0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42
        IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Cr0_Gr1UMIIF0xvEx4A2
        jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8xhpUUUUU
X-CM-SenderInfo: x2kd0wptlqwqxorr0wxvrqhubq/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ftrace plays like function head exception, prologue analysis will stop soon
because PC is at entry.

   90000000004c5a54 <callee>:
   90000000004c5a54:	03400000  andi   $zero, $zero, 0x0   ==>move  t0, ra
   90000000004c5a58:	03400000  andi   $zero, $zero, 0x0   ==>bl callsite
==>90000000004c5a5c:	02fcc063  addi.d $sp, $sp, -208(0xf30)
   ...

When encountering ftrace_call, save trace function ra at PT_ERA, save parent ra
at PT_R1, At this time, pc is the position after the two nops of callee. There is
no conventional prologue operation between this position and the function entry,
so we need to reset the first flag to make the caller continue to unwind.

testing method:
  echo path_openat > ./set_ftrace_filter
  echo 1 > ./options/func_stack_trace
  echo function > ./current_tracer

Reported-by: Jeff Xie <xiehuan09@gmail.com>
Tested-by: Jinyang He <hejinyang@loongson.cn>
Tested-by: Jeff Xie <xiehuan09@gmail.com>
Signed-off-by: Qing Zhang <zhangqing@loongson.cn>
---
 arch/loongarch/include/asm/unwind.h     |  2 +-
 arch/loongarch/kernel/unwind_prologue.c | 33 +++++++++++++++++++++----
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/arch/loongarch/include/asm/unwind.h b/arch/loongarch/include/asm/unwind.h
index f66b07c3e6a1..f2b52b9ea93d 100644
--- a/arch/loongarch/include/asm/unwind.h
+++ b/arch/loongarch/include/asm/unwind.h
@@ -20,7 +20,7 @@ struct unwind_state {
 	char type; /* UNWINDER_XXX */
 	struct stack_info stack_info;
 	struct task_struct *task;
-	bool first, error;
+	bool first, error, is_ftrace;
 	int graph_idx;
 	unsigned long sp, pc, ra;
 };
diff --git a/arch/loongarch/kernel/unwind_prologue.c b/arch/loongarch/kernel/unwind_prologue.c
index f77f3b6f3f06..996ac9239caf 100644
--- a/arch/loongarch/kernel/unwind_prologue.c
+++ b/arch/loongarch/kernel/unwind_prologue.c
@@ -14,9 +14,7 @@ unsigned long unwind_get_return_address(struct unwind_state *state)
 
 	if (unwind_done(state))
 		return 0;
-	else if (state->type)
-		return state->pc;
-	else if (state->first)
+	else if (state->type || state->first)
 		return state->pc;
 
 	return *(unsigned long *)(state->sp);
@@ -42,16 +40,39 @@ static bool unwind_by_guess(struct unwind_state *state)
 	return false;
 }
 
+static void unwind_state_fixup(struct unwind_state *state)
+{
+	static unsigned long ftrace_case = (unsigned long)ftrace_call + 4;
+
+	if (state->pc == ftrace_case)
+		state->is_ftrace = true;
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
 
@@ -97,7 +118,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
 
 	state->pc = *(unsigned long *)(state->sp + frame_ra);
 	state->sp = state->sp + frame_size;
-	return !!__kernel_text_address(state->pc);
+	goto out;
 
 first:
 	state->first = false;
@@ -106,7 +127,9 @@ static bool unwind_by_prologue(struct unwind_state *state)
 
 	state->pc = state->ra;
 
-	return !!__kernel_text_address(state->ra);
+out:
+	unwind_state_fixup(state);
+	return !!__kernel_text_address(state->pc);
 }
 
 void unwind_start(struct unwind_state *state, struct task_struct *task,
-- 
2.36.1

