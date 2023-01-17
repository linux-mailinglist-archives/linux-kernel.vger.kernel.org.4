Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2397F66D70C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 08:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235903AbjAQHjw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 02:39:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbjAQHjq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 02:39:46 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98862241F5;
        Mon, 16 Jan 2023 23:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673941181; x=1705477181;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OymUx5WFjRv4twSVzDF5ORdlt+mfD9H/c4rO83TER9k=;
  b=gZarcBaTIflOUJCxCiHigjdGKzytGOadQXQW6hZQ92AGG0267HfkR+ga
   PYIH+MN33lmfEpDjZzTtd0EqINW+bqSlOglsN9f9z+qHKryAO/2eCyGhX
   ML+AInPYTBB1MJ0re2jUD1sCzqTS8MdNYzes8uGur+SLPE8MTgavZlnqc
   pSkHgwVLLoS/wu5FT3zLGY4Glt6/jpjbpzH3H7oTsBMkUP8PZjh7GpnOl
   eY19xCXeepHC7N1vxbPH5woKZwUwVl/XyyyeSv9Ks27W0KogterPKuxVG
   BQtZCI9yVbRDz3Hwe4tvfQU23mW4zW/VcJLl3Tc7++NuWYv6udoxK5bfO
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="410871143"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="410871143"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 23:39:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="833067078"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="833067078"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 23:39:27 -0800
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] rcu: Remove impossible wakeup rcu GP kthread action from rcu_report_qs_rdp()
Date:   Tue, 17 Jan 2023 15:44:43 +0800
Message-Id: <20230117074443.1982347-1-qiang1.zhang@intel.com>
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

When inovke rcu_report_qs_rdp(), if current CPU's rcu_data structure's ->
grpmask has not been cleared from the corresponding rcu_node structure's
->qsmask, after that will clear and report quiescent state, but in this
time, this also means that current grace period is not end, the current
grace period is ongoing, because the rcu_gp_in_progress() currently return
true, so for non-offloaded rdp, invoke rcu_accelerate_cbs() is impossible
to return true.

This commit therefore remove impossible rcu_gp_kthread_wake() calling.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 kernel/rcu/tree.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index b2c204529478..c78d48482583 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1956,7 +1956,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 {
 	unsigned long flags;
 	unsigned long mask;
-	bool needwake = false;
 	bool needacc = false;
 	struct rcu_node *rnp;
 
@@ -1988,7 +1987,7 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		 * NOCB kthreads have their own way to deal with that...
 		 */
 		if (!rcu_rdp_is_offloaded(rdp)) {
-			needwake = rcu_accelerate_cbs(rnp, rdp);
+			WARN_ON_ONCE(rcu_accelerate_cbs(rnp, rdp));
 		} else if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
 			/*
 			 * ...but NOCB kthreads may miss or delay callbacks acceleration
@@ -2000,8 +1999,6 @@ rcu_report_qs_rdp(struct rcu_data *rdp)
 		rcu_disable_urgency_upon_qs(rdp);
 		rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
 		/* ^^^ Released rnp->lock */
-		if (needwake)
-			rcu_gp_kthread_wake();
 
 		if (needacc) {
 			rcu_nocb_lock_irqsave(rdp, flags);
-- 
2.25.1

