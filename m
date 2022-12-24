Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7A6655872
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Dec 2022 06:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbiLXFU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Dec 2022 00:20:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLXFUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Dec 2022 00:20:25 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9C018687;
        Fri, 23 Dec 2022 21:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671859223; x=1703395223;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S40gLU/6WKa7SgaWDOJhy4OtsZ/xWarbNmOK4WXAaGM=;
  b=CYj+eaxdpW+hPgKNz9iOZbpXVS/xoukVd/yNt4TECJFh21hTKCgFZoir
   U/qX+vRD/kLSp1wPmaNMowPpaQjUk63D9q86PcnofOfe8EHReGOwZYmOp
   UxbSKS1ptxBqxI+tCzvxW93ms5skSDrYR4uyKBlaVEwFtAsmCq87WgV33
   9iN4zW0/ppJraKZ/i62mDgQLbCfRGqxcaK7llKRkmstaggwcdZPJVbY6t
   31F1XfvVraqmYZXdJU47fgvg8FUntiOcLeY5oAQO+G5NxgzIsXR7HU8yx
   6fK1OUKahWTHYTS7NRLO6qn232e0yYs5jj42x8FdpttznrKRx2pSrCY08
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="320466535"
X-IronPort-AV: E=Sophos;i="5.96,270,1665471600"; 
   d="scan'208";a="320466535"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 21:20:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10570"; a="826428622"
X-IronPort-AV: E=Sophos;i="5.96,270,1665471600"; 
   d="scan'208";a="826428622"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Dec 2022 21:20:21 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Safe access to rcu_node structure's->exp_tasks
Date:   Sat, 24 Dec 2022 13:25:53 +0800
Message-Id: <20221224052553.263199-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For kernels built with CONFIG_PREEMPT_RCU=y, the following scenario
can result system oops.

           CPU1                                           CPU2
rcu_preempt_deferred_qs_irqrestore                rcu_print_task_exp_stall
  if (special.b.blocked)                            READ_ONCE(rnp->exp_tasks) != NULL
    raw_spin_lock_rcu_node
    np = rcu_next_node_entry(t, rnp)
    if (&t->rcu_node_entry == rnp->exp_tasks)
      WRITE_ONCE(rnp->exp_tasks, np)
      ....
      raw_spin_unlock_irqrestore_rcu_node
                                                    raw_spin_lock_irqsave_rcu_node
                                                    t = list_entry(rnp->exp_tasks->prev,
                                                        struct task_struct, rcu_node_entry)
                                                    (if rnp->exp_tasks is NULL
                                                       will trigger oops)

This problem is that CPU2 accesses rcu_node structure's->exp_tasks
without holding the rcu_node structure's ->lock and CPU2 did not
observe CPU1's change to rcu_node structure's->exp_tasks in time,
if rcu_node structure's->exp_tasks is set null pointer by CPU1, after
that CPU2 accesses members of rcu_node structure's->exp_tasks will
trigger oops.

This commit therefore allows rcu_node structure's->exp_tasks to be
accessed while holding rcu_node structure's ->lock.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree_exp.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 7cc4856da081..902e7c8709c7 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -803,9 +803,11 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 	int ndetected = 0;
 	struct task_struct *t;
 
-	if (!READ_ONCE(rnp->exp_tasks))
-		return 0;
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
+	if (!READ_ONCE(rnp->exp_tasks)) {
+		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+		return 0;
+	}
 	t = list_entry(rnp->exp_tasks->prev,
 		       struct task_struct, rcu_node_entry);
 	list_for_each_entry_continue(t, &rnp->blkd_tasks, rcu_node_entry) {
-- 
2.25.1

