Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711B05BE9E6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiITPQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231375AbiITPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:15:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4784E61D4D;
        Tue, 20 Sep 2022 08:15:49 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MX4mV1fgRzpTJ7;
        Tue, 20 Sep 2022 23:12:58 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:46 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:45 +0800
From:   Chen Zhongjin <chenzhongjin@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-perf-users@vger.kernel.org>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <peterz@infradead.org>,
        <mingo@redhat.com>, <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <namhyung@kernel.org>,
        <jolsa@kernel.org>, <guoren@kernel.org>, <nsaenzju@redhat.com>,
        <frederic@kernel.org>, <changbin.du@intel.com>,
        <vincent.chen@sifive.com>, <ardb@kernel.org>,
        <mhiramat@kernel.org>, <rostedt@goodmis.org>,
        <keescook@chromium.org>, <catalin.marinas@arm.com>,
        <chenzhongjin@huawei.com>
Subject: [PATCH -next 2/7] riscv: stacktrace: Introduce unwind functions
Date:   Tue, 20 Sep 2022 23:11:57 +0800
Message-ID: <20220920151202.180057-3-chenzhongjin@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220920151202.180057-1-chenzhongjin@huawei.com>
References: <20220920151202.180057-1-chenzhongjin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.175.36]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500013.china.huawei.com (7.185.36.172)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now all riscv unwinding code is inside arch_stack_walk. It's
not same as other architectures.

Make some refactoring, to move unwinding code into unwind() and
unwind_next() functions, which walks through all stack frames
or single frame.

This patch only moves code but doesn't make any logical change.

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/riscv/include/asm/stacktrace.h |   7 ++
 arch/riscv/kernel/stacktrace.c      | 104 ++++++++++++++++++----------
 2 files changed, 74 insertions(+), 37 deletions(-)

diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index b6cd3eddfd38..a39e4ef1dbd5 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -11,6 +11,13 @@ struct stackframe {
 	unsigned long ra;
 };
 
+struct unwind_state {
+	unsigned long fp;
+	unsigned long sp;
+	unsigned long pc;
+	struct pt_regs *regs;
+};
+
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
 			   const char *loglvl);
 
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index b51e32d50a0e..e84e21868a3e 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,54 +16,84 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
-noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
-		  void *cookie, struct task_struct *task,
-		  struct pt_regs *regs)
+static int notrace unwind_next(struct unwind_state *state)
 {
-	unsigned long fp, sp, pc;
-	int level = 0;
+	unsigned long low, high, fp;
+	struct stackframe *frame;
 
-	if (regs) {
-		fp = frame_pointer(regs);
-		sp = user_stack_pointer(regs);
-		pc = instruction_pointer(regs);
-	} else if (task == NULL || task == current) {
-		fp = (unsigned long)__builtin_frame_address(0);
-		sp = current_stack_pointer;
-		pc = (unsigned long)arch_stack_walk;
+	fp = state->fp;
+
+	/* Validate frame pointer */
+	low = state->sp + sizeof(struct stackframe);
+	high = ALIGN(low, THREAD_SIZE);
+
+	if (fp < low || fp > high || fp & 0x7)
+		return -EINVAL;
+
+	/* Unwind stack frame */
+	frame = (struct stackframe *)fp - 1;
+	state->sp = fp;
+
+	if (state->regs && state->regs->epc == state->pc &&
+		fp & 0x7) {
+		state->fp = frame->ra;
+		state->pc = state->regs->ra;
 	} else {
-		/* task blocked in __switch_to */
-		fp = task->thread.s[0];
-		sp = task->thread.sp;
-		pc = task->thread.ra;
+		state->fp = frame->fp;
+		state->pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
+							(unsigned long *)fp - 1);
 	}
 
-	for (;;) {
-		unsigned long low, high;
-		struct stackframe *frame;
+	return 0;
+}
 
-		if (unlikely(!__kernel_text_address(pc) ||
-		   (level++ >= 1 && !consume_entry(cookie, pc))))
+static void notrace unwind(struct unwind_state *state,
+				stack_trace_consume_fn consume_entry, void *cookie)
+{
+	while (1) {
+		int ret;
+
+		if (!__kernel_text_address(state->pc))
+			break;
+
+		if (!consume_entry(cookie, state->pc))
 			break;
 
-		/* Validate frame pointer */
-		low = sp + sizeof(struct stackframe);
-		high = ALIGN(sp, THREAD_SIZE);
-		if (unlikely(fp < low || fp > high || fp & 0x7))
+		ret = unwind_next(state);
+		if (ret < 0)
 			break;
-		/* Unwind stack frame */
-		frame = (struct stackframe *)fp - 1;
-		sp = fp;
-		if (regs && (regs->epc == pc) && (frame->fp & 0x7)) {
-			fp = frame->ra;
-			pc = regs->ra;
-		} else {
-			fp = frame->fp;
-			pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
-						   (unsigned long *)(fp - 8));
-		}
+	}
+}
+
+noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
+		  void *cookie, struct task_struct *task,
+		  struct pt_regs *regs)
+{
+	struct unwind_state state;
+
+	if (task == NULL)
+		task = current;
 
+	if (regs) {
+		state.fp = frame_pointer(regs);
+		state.sp = user_stack_pointer(regs);
+		state.pc = instruction_pointer(regs);
+		state.regs = regs;
+	} else if (task == current) {
+		state.fp = (unsigned long)__builtin_frame_address(0);
+		state.sp = current_stack_pointer;
+		state.pc = (unsigned long)arch_stack_walk;
+
+		/* skip frame of arch_stack_walk */
+		unwind_next(&state);
+	} else {
+		/* task blocked in __switch_to */
+		state.fp = task->thread.s[0];
+		state.sp = task->thread.sp;
+		state.pc = task->thread.ra;
 	}
+
+	unwind(&state, consume_entry, cookie);
 }
 
 #else /* !CONFIG_FRAME_POINTER */
-- 
2.17.1

