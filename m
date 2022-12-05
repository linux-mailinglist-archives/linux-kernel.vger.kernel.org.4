Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40BE6428AF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbiLEMmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231443AbiLEMms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:42:48 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17C8631B
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:42:46 -0800 (PST)
Received: from dggpemm100009.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NQjm432rqzkXrn;
        Mon,  5 Dec 2022 20:39:16 +0800 (CST)
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 5 Dec
 2022 20:42:44 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Changbin Du <changbin.du@intel.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>
Subject: [PATCH] riscv: stacktrace: Fix missing the first frame
Date:   Mon, 5 Dec 2022 21:29:36 +0800
Message-ID: <20221205132936.493245-1-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running kfence_test, I found some testcases failed like this:

 # test_out_of_bounds_read: EXPECTATION FAILED at mm/kfence/kfence_test.c:346
 Expected report_matches(&expect) to be true, but is false
 not ok 1 - test_out_of_bounds_read

The corresponding call-trace is:

 BUG: KFENCE: out-of-bounds read in kunit_try_run_case+0x38/0x84

 Out-of-bounds read at 0x(____ptrval____) (32B right of kfence-#10):
  kunit_try_run_case+0x38/0x84
  kunit_generic_run_threadfn_adapter+0x12/0x1e
  kthread+0xc8/0xde
  ret_from_exception+0x0/0xc

The kfence_test using the first frame of call trace to check whether the
testcase is succeed or not. Patch a7c5c7e8ff78 skip first frame for all
case, which results the kfence_test failed. Indeed, we only need to skip
the first frame for case (task==NULL || task==current).

With this patch, the call-trace will be:

 BUG: KFENCE: out-of-bounds read in test_out_of_bounds_read+0x88/0x19e

 Out-of-bounds read at 0x(____ptrval____) (1B left of kfence-#7):
  test_out_of_bounds_read+0x88/0x19e
  kunit_try_run_case+0x38/0x84
  kunit_generic_run_threadfn_adapter+0x12/0x1e
  kthread+0xc8/0xde
  ret_from_exception+0x0/0xc

Fixes: a7c5c7e8ff78 ("riscv: eliminate unreliable __builtin_frame_address(1)")
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 arch/riscv/kernel/stacktrace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/stacktrace.c b/arch/riscv/kernel/stacktrace.c
index 08d11a53f39e..5fe2ae4cf135 100644
--- a/arch/riscv/kernel/stacktrace.c
+++ b/arch/riscv/kernel/stacktrace.c
@@ -30,6 +30,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		fp = (unsigned long)__builtin_frame_address(0);
 		sp = current_stack_pointer;
 		pc = (unsigned long)walk_stackframe;
+		level = -1;
 	} else {
 		/* task blocked in __switch_to */
 		fp = task->thread.s[0];
@@ -41,7 +42,7 @@ void notrace walk_stackframe(struct task_struct *task, struct pt_regs *regs,
 		unsigned long low, high;
 		struct stackframe *frame;
 
-		if (unlikely(!__kernel_text_address(pc) || (level++ >= 1 && !fn(arg, pc))))
+		if (unlikely(!__kernel_text_address(pc) || (level++ >= 0 && !fn(arg, pc))))
 			break;
 
 		/* Validate frame pointer */
-- 
2.25.1

