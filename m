Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2455B666BD4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 08:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbjALHvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 02:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239589AbjALHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 02:51:26 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDF13726A;
        Wed, 11 Jan 2023 23:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673509874; x=1705045874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Yn345f6A8xT4Ihg6H07aIdh08XFZ516Tsct5gO5ktsE=;
  b=HCgUh5dH+Dp0z3DRdc5hX427gz3+eG7bc4ljFNPcj9SIH81AVgz8NsB+
   r9IQfB+bu2MONbuRjB849djVSfMHfYBkgZFD2DSQ1z9YZeDUlFIH+pTQx
   zFkPvEyVK3qn91gWvuE8AkbUEIp1nKpMy+EVRkc5gQuQjcZIVSUr4s5nF
   GAPcDnBaXJwFYWAZaUSVjV6E3bSil8TaFTDIyfygyNVuFPVXdTVLo57m8
   VVZgWg0qa53xmWQJO83QpIg+4O/rhY29FM7WfTdCaqm9hevmnlpWaW1aj
   bgfEdMY+9SEKGV8CFhLPAPNhiwcmdXg1+7D2c9xYG9SqkK467JV07vxv5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307159888"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="307159888"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:51:12 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="726213355"
X-IronPort-AV: E=Sophos;i="5.96,319,1665471600"; 
   d="scan'208";a="726213355"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 23:51:09 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Fix the start_poll_synchronize_rcu_expedited() be invoked very early
Date:   Thu, 12 Jan 2023 15:56:29 +0800
Message-Id: <20230112075629.1661429-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the start_poll_synchronize_rcu_expedited() can be invoked
very early. before rcu_init(), the rcu_data structure's->mynode is not
initialized, if invoke start_poll_synchronize_rcu_expedited() before
rcu_init(), will trigger a null rcu_node structure's->exp_seq_poll access.

This commit add boot_exp_seq_poll_rq member to rcu_state structure to
store seq number return by invoke start_poll_synchronize_rcu_expedited()
very early.

Fixes: d96c52fe4907 ("rcu: Add polled expedited grace-period primitives")
Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c     | 3 ++-
 kernel/rcu/tree.h     | 1 +
 kernel/rcu/tree_exp.h | 6 ++++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 63545d79da51..12f0891ce7f4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -92,6 +92,7 @@ static struct rcu_state rcu_state = {
 	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
 	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
 	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
+	.boot_exp_seq_poll_rq = RCU_GET_STATE_COMPLETED,
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -4938,7 +4939,7 @@ void __init rcu_init(void)
 		qovld_calc = qovld;
 
 	// Kick-start any polled grace periods that started early.
-	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
+	if (!(rcu_state.boot_exp_seq_poll_rq & 0x1))
 		(void)start_poll_synchronize_rcu_expedited();
 
 	rcu_test_sync_prims();
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..ae50ca6853ad 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -397,6 +397,7 @@ struct rcu_state {
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 	int nocb_is_setup;			/* nocb is setup from boot */
+	unsigned long boot_exp_seq_poll_rq;
 };
 
 /* Values for rcu_state structure's gp_flags field. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 956cd459ba7f..1b35a1e233d9 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -1068,9 +1068,11 @@ unsigned long start_poll_synchronize_rcu_expedited(void)
 	if (rcu_init_invoked())
 		raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	if (!poll_state_synchronize_rcu(s)) {
-		rnp->exp_seq_poll_rq = s;
-		if (rcu_init_invoked())
+		if (rcu_init_invoked()) {
+			rnp->exp_seq_poll_rq = s;
 			queue_work(rcu_gp_wq, &rnp->exp_poll_wq);
+		} else
+			rcu_state.boot_exp_seq_poll_rq = s;
 	}
 	if (rcu_init_invoked())
 		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
-- 
2.25.1

