Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24C905BE9E5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiITPQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231379AbiITPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:15:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEA22B1A;
        Tue, 20 Sep 2022 08:15:49 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MX4nG3fd6zHpCw;
        Tue, 20 Sep 2022 23:13:38 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 20 Sep 2022 23:15:47 +0800
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
Subject: [PATCH -next 7/7] riscv: stacktrace: Fix unwinding on __kretporbe_trampoline
Date:   Tue, 20 Sep 2022 23:12:02 +0800
Message-ID: <20220920151202.180057-8-chenzhongjin@huawei.com>
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

When unwinding on __kretprobe_trampoline, the caller of traced function
will be skipped because unwinder doesn't read the saved pt_regs.

Things going like this:

caller's caller		|       ...                 |<---+
caller			+---------------------------+    |
			| ra caller's caller        |    |
			| s0 of caller's caller     |    |
			|       ...                 |    |
probed func returned	+---------------------------+    |
__kretprobe_trampoline	| pt_regs:                  |    |
			| epc caller                |    |
                        | ra  __kretprobe_trampoline|    |
			|       ...                 |    |
                        | s0 of caller              | {ra, fp}
			|       ...                 |

Since from caller to __kretprobe_trampoline, the {ra, fp} are not
changed, unwinder will go directly to caller's caller.

Now we can have an ENCODED_FRAME_POINTER on stack and read the pt_regs,
kretporbe will set the epc to correct_ret_addr so that we can unwind
to the correct caller.

Stacktrace before this patch:

 Call Trace:
  ...
  [<ffffffff800d5d48>] __kretprobe_trampoline_handler+0xc2/0x13e
  [<ffffffff808b766c>] trampoline_probe_handler+0x30/0x46
  [<ffffffff800070de>] __kretprobe_trampoline+0x52/0x92
  [<ffffffff0163809c>] kprobe_init+0x9c/0x1000 [kprobe_unwind]
  [<ffffffff800027c8>] do_one_initcall+0x4c/0x1f2
  ...

Stacktrace after this patch:

 Call Trace:
  ...
  [<ffffffff800d5d48>] __kretprobe_trampoline_handler+0xc2/0x13e
  [<ffffffff808b766c>] trampoline_probe_handler+0x30/0x46
  [<ffffffff800070de>] __kretprobe_trampoline+0x52/0x92
+ [<ffffffff01633076>] the_caller+0x2c/0x38 [kprobe_unwind]
  [<ffffffff0163809c>] kprobe_init+0x9c/0x1000 [kprobe_unwind]
  [<ffffffff800027c8>] do_one_initcall+0x4c/0x1f2
  ...

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/riscv/include/asm/stacktrace.h           | 4 ++++
 arch/riscv/kernel/probes/kprobes_trampoline.S | 8 ++++++++
 arch/riscv/kernel/stacktrace.c                | 5 +++++
 3 files changed, 17 insertions(+)

diff --git a/arch/riscv/include/asm/stacktrace.h b/arch/riscv/include/asm/stacktrace.h
index a39e4ef1dbd5..506c7c38b6cb 100644
--- a/arch/riscv/include/asm/stacktrace.h
+++ b/arch/riscv/include/asm/stacktrace.h
@@ -16,6 +16,10 @@ struct unwind_state {
 	unsigned long sp;
 	unsigned long pc;
 	struct pt_regs *regs;
+#ifdef CONFIG_KRETPROBES
+	struct llist_node *kr_cur;
+	struct task_struct *task;
+#endif
 };
 
 extern void dump_backtrace(struct pt_regs *regs, struct task_struct *task,
diff --git a/arch/riscv/kernel/probes/kprobes_trampoline.S b/arch/riscv/kernel/probes/kprobes_trampoline.S
index 7bdb09ded39b..3c0677a714a6 100644
--- a/arch/riscv/kernel/probes/kprobes_trampoline.S
+++ b/arch/riscv/kernel/probes/kprobes_trampoline.S
@@ -6,6 +6,8 @@
 
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
+#include <asm/frame.h>
+#include <asm/csr.h>
 
 	.text
 	.altmacro
@@ -79,6 +81,12 @@ ENTRY(__kretprobe_trampoline)
 	addi sp, sp, -(PT_SIZE_ON_STACK)
 	save_all_base_regs
 
+#ifdef CONFIG_FRAME_POINTER
+	li s0, SR_PP
+	REG_S s0, PT_STATUS(sp)
+	ENCODE_FRAME_POINTER
+#endif
+
 	move a0, sp /* pt_regs */
 
 	call trampoline_probe_handler
diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 976dc298ab3b..53edc685ca18 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -11,6 +11,7 @@
 #include <linux/sched/task_stack.h>
 #include <linux/stacktrace.h>
 #include <linux/ftrace.h>
+#include <linux/kprobes.h>
 
 #include <asm/stacktrace.h>
 
@@ -123,6 +124,10 @@ noinline notrace void arch_stack_walk(stack_trace_consume_fn consume_entry,
 		state.sp = task->thread.sp;
 		state.pc = task->thread.ra;
 	}
+#ifdef CONFIG_KRETPROBES
+	state.kr_cur = NULL;
+	state.task = task;
+#endif
 
 	unwind(&state, consume_entry, cookie);
 }
-- 
2.17.1

