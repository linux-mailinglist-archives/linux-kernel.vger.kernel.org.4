Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13294665C2E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:11:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbjAKNLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232027AbjAKNLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:11:19 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5008E39;
        Wed, 11 Jan 2023 05:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673442674; x=1704978674;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tPgiAxXLY4gShdjl9d7GsMDyiml/2QFNArrDwpdyHfc=;
  b=msv4S96QkMlQX3+6eDtKfocmPauL1J9o4wfTiDOzv3cr4G7lI3JD7Pdf
   f4zXFJwFJIPbS064SfD6R8LcTd9uM6Dedwdz5TP8GX4a9yFjXObXjlMdX
   O2o7svmvrs4FPMFwJr4b168BpAajE4GJJud+Wu/mWQwRoajgwd6j5DIQP
   0jRNAFV8HwIOaG5zrasTDoweWrVV9fi2FPQnJt9MMR7lBNgX+ikHQMlHx
   7qryoZwsZszYRJmYsTHCOPKCu0bOtiAThZt8B55KmbLjy34DD7xV3FNdt
   BdJQZbVTchfYPV9QQbiTHQSH64M9m8r1QBlRLmjTo13FBeETXusbs3iJu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="409651827"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="409651827"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:09:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="650746989"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="650746989"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 05:09:33 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rcu: Fix the start_poll_synchronize_rcu_expedited() be invoked very early
Date:   Wed, 11 Jan 2023 21:14:53 +0800
Message-Id: <20230111131453.1626214-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the start_poll_synchronize_rcu_expedited() can be invoked
very early. before rcu_init(), the rcu_data structure's->mynode is not
initialized, if invoke start_poll_synchronize_rcu_expedited() before
rcu_init(), will access to NULL mynode pointer.

This commit therefore add exp_seq_poll_rq member to rcu_state structure
to store snap seq number

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c     | 3 ++-
 kernel/rcu/tree.h     | 1 +
 kernel/rcu/tree_exp.h | 6 ++++--
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 63545d79da51..34b13d6bd8c4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -92,6 +92,7 @@ static struct rcu_state rcu_state = {
 	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
 	.exp_wake_mutex = __MUTEX_INITIALIZER(rcu_state.exp_wake_mutex),
 	.ofl_lock = __ARCH_SPIN_LOCK_UNLOCKED,
+	.exp_seq_poll_rq = RCU_GET_STATE_COMPLETED,
 };
 
 /* Dump rcu_node combining tree at boot to verify correct setup. */
@@ -4938,7 +4939,7 @@ void __init rcu_init(void)
 		qovld_calc = qovld;
 
 	// Kick-start any polled grace periods that started early.
-	if (!(per_cpu_ptr(&rcu_data, cpu)->mynode->exp_seq_poll_rq & 0x1))
+	if (!(rcu_state.exp_seq_poll_rq & 0x1))
 		(void)start_poll_synchronize_rcu_expedited();
 
 	rcu_test_sync_prims();
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..dbc7c7484a7e 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -397,6 +397,7 @@ struct rcu_state {
 						/* Synchronize offline with */
 						/*  GP pre-initialization. */
 	int nocb_is_setup;			/* nocb is setup from boot */
+	unsigned long exp_seq_poll_rq;
 };
 
 /* Values for rcu_state structure's gp_flags field. */
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 956cd459ba7f..5964d1cccab1 100644
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
+			rcu_state.exp_seq_poll_rq = s;
 	}
 	if (rcu_init_invoked())
 		raw_spin_unlock_irqrestore(&rnp->exp_poll_lock, flags);
-- 
2.25.1

