Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F4D5BE9E4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:16:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiITPQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbiITPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:15:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 474E161116;
        Tue, 20 Sep 2022 08:15:49 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MX4mV62YhzpTJj;
        Tue, 20 Sep 2022 23:12:58 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:46 +0800
Received: from ubuntu1804.huawei.com (10.67.175.36) by
 dggpemm500013.china.huawei.com (7.185.36.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:46 +0800
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
Subject: [PATCH -next 5/7] riscv: stacktrace: Implement stacktrace for irq
Date:   Tue, 20 Sep 2022 23:12:00 +0800
Message-ID: <20220920151202.180057-6-chenzhongjin@huawei.com>
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

After adding encoded fp onto stack to record pt_regs, now the
unwinder have ability to unwind frame through irq.

There is two steps to unwind irq frame and the interrupted frame:

1. When there is an encoded fp on stack, we can get the pt_regs
and unwind frame by (regs->epc) and (regs->s0).

2. To unwind the interrupted frame, there is two possibilities,
we can determine the situation by checking whether the value in
frame->ra position is a fp value.

If there is a fp in ra position:
We are inside a leaf frame and there is only fp on ra position.
Get fp from ra position and get next pc from pt_regs.
Else:
Just get fp and next pc from stack frame.

Stacktrace before this patch:

 Call Trace:
  ...
  [<ffffffff800aa692>] __flush_smp_call_function_queue+0xde/0x1fa
  [<ffffffff800ab404>] generic_smp_call_function_single_interrupt+0x22/0x2a
  [<ffffffff800077b2>] handle_IPI+0xaa/0x108
  [<ffffffff803f827e>] riscv_intc_irq+0x56/0x6e
  [<ffffffff808d94b6>] generic_handle_arch_irq+0x4c/0x76
  [<ffffffff80003ad0>] ret_from_exception+0x0/0xc

Stacktrace after this patch:

 Call Trace:
  ...
  [<ffffffff800aa6da>] __flush_smp_call_function_queue+0xde/0x1fa
  [<ffffffff800ab44c>] generic_smp_call_function_single_interrupt+0x22/0x2a
  [<ffffffff800077fa>] handle_IPI+0xaa/0x108
  [<ffffffff803f82c6>] riscv_intc_irq+0x56/0x6e
  [<ffffffff808d94fe>] generic_handle_arch_irq+0x4c/0x76
  [<ffffffff80003ad0>] ret_from_exception+0x0/0xc
+ [<ffffffff80003d52>] arch_cpu_idle+0x22/0x28
+ [<ffffffff808e23a8>] default_idle_call+0x44/0xee
+ [<ffffffff80056ece>] do_idle+0x116/0x126
+ [<ffffffff8005706e>] cpu_startup_entry+0x36/0x38
+ [<ffffffff808d99ae>] kernel_init+0x0/0x15a
+ [<ffffffff80a007a0>] arch_post_acpi_subsys_init+0x0/0x38
+ [<ffffffff80a0100c>] start_kernel+0x7c4/0x7f2

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/riscv/kernel/stacktrace.c | 45 ++++++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index e84e21868a3e..976dc298ab3b 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -16,29 +16,60 @@
 
 #ifdef CONFIG_FRAME_POINTER
 
+static struct pt_regs *decode_frame_pointer(unsigned long fp)
+{
+	if (!(fp & 0x1))
+		return NULL;
+
+	return (struct pt_regs *)(fp & ~0x1);
+}
+
 static int notrace unwind_next(struct unwind_state *state)
 {
 	unsigned long low, high, fp;
 	struct stackframe *frame;
+	struct pt_regs *regs;
 
-	fp = state->fp;
+	regs = decode_frame_pointer(state->fp);
 
 	/* Validate frame pointer */
-	low = state->sp + sizeof(struct stackframe);
+	if (regs) {
+		if user_mode(regs)
+			return -1;
+
+		fp = (unsigned long)regs;
+		low = state->sp;
+	} else {
+		fp = state->fp;
+		low = state->sp + sizeof(struct stackframe);
+	}
 	high = ALIGN(low, THREAD_SIZE);
 
 	if (fp < low || fp > high || fp & 0x7)
 		return -EINVAL;
 
-	/* Unwind stack frame */
 	frame = (struct stackframe *)fp - 1;
 	state->sp = fp;
 
-	if (state->regs && state->regs->epc == state->pc &&
-		fp & 0x7) {
-		state->fp = frame->ra;
-		state->pc = state->regs->ra;
+	if (regs) {
+	/* Unwind from irq to interrupted function */
+		state->fp = regs->s0;
+		state->pc = regs->epc;
+		state->regs = regs;
+	} else if (state->regs && state->regs->epc == state->pc) {
+	/* Unwind from interrupted function to caller*/
+		if (frame->ra < low || frame->ra > high) {
+		/* normal function */
+			state->fp = frame->fp;
+			state->pc = frame->ra;
+		} else {
+		/* leaf function */
+			state->fp = frame->ra;
+			state->pc = state->regs->ra;
+		}
+		state->regs = NULL;
 	} else {
+	/* Unwind from normal stack frame */
 		state->fp = frame->fp;
 		state->pc = ftrace_graph_ret_addr(current, NULL, frame->ra,
 							(unsigned long *)fp - 1);
-- 
2.17.1

