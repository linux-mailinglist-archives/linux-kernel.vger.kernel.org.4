Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF2B5BC1B9
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 05:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbiISDUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 23:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiISDTm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 23:19:42 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DEB513D04
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 20:19:16 -0700 (PDT)
Received: from localhost.localdomain (unknown [113.200.148.30])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8CxYOKv3ydj8W4dAA--.46332S2;
        Mon, 19 Sep 2022 11:19:12 +0800 (CST)
From:   Qing Zhang <zhangqing@loongson.cn>
To:     Huacai Chen <chenhuacai@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jeff Xie <xiehuan09@gmail.com>,
        Jinyang He <hejinyang@loongson.cn>
Subject: [PATCH v5 10/10] LoongArch/ftrace: Fix unwind state when option func_stack_trace
Date:   Mon, 19 Sep 2022 11:19:10 +0800
Message-Id: <20220919031910.15512-1-zhangqing@loongson.cn>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8CxYOKv3ydj8W4dAA--.46332S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWFyUtFWxKF4kGFWDXrW5Wrg_yoWrXFW8pF
        95CF95Wr4Fgr92grnrXr1j9rn5Grnayr17KF9rJw1rCFnFqryfJrnYya4DZFs8J3ykGF1x
        X3ZYkrya9w4UJaUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
        rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
        1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
        JVWxJr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxV
        WxJr0_GcWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
        Yx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbV
        WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AF
        wI0_JF0_Jw1lc2xSY4AK67AK6r48MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
        1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
        b7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0x
        vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
        0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
        VjvjDU0xZFpf9x0JU689_UUUUU=
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

When encountering ftrace_call, save trace function ra at PT_ERA, save
parent ra at PT_R1, At this time, pc is the position after the two nops
of callee. There is no conventional prologue operation between this
position and the function entry, so we need to reset the first flag to
make the caller continue to unwind.

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
 arch/loongarch/kernel/unwind_prologue.c | 35 +++++++++++++++++++++----
 2 files changed, 31 insertions(+), 6 deletions(-)

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
index f77f3b6f3f06..4fb4923b68cc 100644
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
@@ -42,16 +40,41 @@ static bool unwind_by_guess(struct unwind_state *state)
 	return false;
 }
 
+static inline void unwind_state_fixup(struct unwind_state *state)
+{
+#ifdef CONFIG_FUNCTION_TRACER
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
 
@@ -97,7 +120,7 @@ static bool unwind_by_prologue(struct unwind_state *state)
 
 	state->pc = *(unsigned long *)(state->sp + frame_ra);
 	state->sp = state->sp + frame_size;
-	return !!__kernel_text_address(state->pc);
+	goto out;
 
 first:
 	state->first = false;
@@ -106,7 +129,9 @@ static bool unwind_by_prologue(struct unwind_state *state)
 
 	state->pc = state->ra;
 
-	return !!__kernel_text_address(state->ra);
+out:
+	unwind_state_fixup(state);
+	return !!__kernel_text_address(state->pc);
 }
 
 void unwind_start(struct unwind_state *state, struct task_struct *task,
-- 
2.36.1

