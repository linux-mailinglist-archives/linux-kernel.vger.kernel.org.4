Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4ECA5BE9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 17:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiITPQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 11:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiITPPv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 11:15:51 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4768F61129;
        Tue, 20 Sep 2022 08:15:49 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MX4l06HjSzlW5D;
        Tue, 20 Sep 2022 23:11:40 +0800 (CST)
Received: from dggpemm500013.china.huawei.com (7.185.36.172) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
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
Subject: [PATCH -next 6/7] riscv: stacktrace: Fix unwinding on ftrace_regs_call
Date:   Tue, 20 Sep 2022 23:12:01 +0800
Message-ID: <20220920151202.180057-7-chenzhongjin@huawei.com>
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

When unwinding on ftrace_regs_call, the traced function will be skipped
because ftrace_regs_caller doesn't save the fp and ra.

Save the encoded fp so that we can get the pt_regs so that we can unwind
from ftrace_regs_call to the traced function.

Also the pt_regs->status should be set as kernel mode.

Stacktrace before this patch:

 Call Trace:
  ...
  [<ffffffff0161a0e0>] handler_pre+0x30/0x4a [kprobe_unwind]
  [<ffffffff800bce92>] aggr_pre_handler+0x60/0x94
  [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
  [<ffffffff80008e7e>] ftrace_regs_call+0x8/0x10
  [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
  [<ffffffff8008a4e6>] do_init_module+0x56/0x210
 ...

Stacktrace after this patch:

 Call Trace:
  ...
  [<ffffffff016150e0>] handler_pre+0x30/0x4a [kprobe_unwind]
  [<ffffffff800bce96>] aggr_pre_handler+0x60/0x94
  [<ffffffff80006df0>] kprobe_ftrace_handler+0x13e/0x188
  [<ffffffff80008e82>] ftrace_regs_call+0x8/0x10
+ [<ffffffff01615000>] empty_call+0x0/0x1e [kprobe_unwind]
  [<ffffffff80002540>] do_one_initcall+0x4c/0x1f2
  [<ffffffff8008a4ea>] do_init_module+0x56/0x210
  ...

Signed-off-by: Chen Zhongjin <chenzhongjin@huawei.com>
---
 arch/riscv/kernel/mcount-dyn.S | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
index d171eca623b6..56a4014c392f 100644
--- a/arch/riscv/kernel/mcount-dyn.S
+++ b/arch/riscv/kernel/mcount-dyn.S
@@ -10,6 +10,8 @@
 #include <asm/asm-offsets.h>
 #include <asm-generic/export.h>
 #include <asm/ftrace.h>
+#include <asm/frame.h>
+#include <asm/csr.h>
 
 	.text
 
@@ -97,6 +99,11 @@
 	REG_S x29, PT_T4(sp)
 	REG_S x30, PT_T5(sp)
 	REG_S x31, PT_T6(sp)
+
+#ifdef CONFIG_FRAME_POINTER
+	li s0, SR_PP
+	REG_S s0, PT_STATUS(sp)
+#endif
 	.endm
 
 	.macro RESTORE_ALL
@@ -172,6 +179,7 @@ ENDPROC(ftrace_caller)
 #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
 ENTRY(ftrace_regs_caller)
 	SAVE_ALL
+	ENCODE_FRAME_POINTER
 
 	addi	a0, ra, -FENTRY_RA_OFFSET
 	la	a1, function_trace_op
-- 
2.17.1

