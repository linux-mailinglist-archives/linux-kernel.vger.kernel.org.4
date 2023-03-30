Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D306D1291
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjC3WtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbjC3WsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E81CC9;
        Thu, 30 Mar 2023 15:47:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2367FB82A6B;
        Thu, 30 Mar 2023 22:47:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAA3C43443;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=BGO1b8NtiaH39dX3EQtGPIpQm+szueNs/o3Qv7qj9XA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EP5v8NQwsl9ACrUnDx4NiTZkfRkpW82qKELLxm3Pdd7z0UWzwHj4lH6tR42X+x9LG
         o0E/uBm2C7vdQb8qqr783QZzmNpYbXE03RR3y/9OIS8xfFymHzTILRHzhd/MwPLdiU
         pD/OFqORgvpskQJSpzUEBL3c/6pPrC7w764TYJCmv1DtJVaW2yW2hmGnvMZfY4L3Uc
         P/nW4FeKWnewhFXrM2spAP2n01pBbjDC0nnWu6wvv2t5TqYtRqBQTUHOYwcZ72rDqp
         20RThlRYEBWEZfqo2d8bdWqhAPPKTUNrSYqFCtfdZrqT0XEV5RYy97RklVV3QSNKwL
         Xvt8i18ezgpDg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 418C41540490; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 20/20] srcu: Fix long lines in srcu_funnel_gp_start()
Date:   Thu, 30 Mar 2023 15:47:26 -0700
Message-Id: <20230330224726.662344-20-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit creates an srcu_usage pointer named "sup" as a shorter
synonym for the "ssp->srcu_sup" that was bloating several lines of code.

Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index f661a0f6bc0d..a887cfc89894 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -1004,9 +1004,10 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	struct srcu_node *snp;
 	struct srcu_node *snp_leaf;
 	unsigned long snp_seq;
+	struct srcu_usage *sup = ssp->srcu_sup;
 
 	/* Ensure that snp node tree is fully initialized before traversing it */
-	if (smp_load_acquire(&ssp->srcu_sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
+	if (smp_load_acquire(&sup->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
 		snp_leaf = NULL;
 	else
 		snp_leaf = sdp->mynode;
@@ -1014,7 +1015,7 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	if (snp_leaf)
 		/* Each pass through the loop does one level of the srcu_node tree. */
 		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
-			if (WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, s)) && snp != snp_leaf)
+			if (WARN_ON_ONCE(rcu_seq_done(&sup->srcu_gp_seq, s)) && snp != snp_leaf)
 				return; /* GP already done and CBs recorded. */
 			spin_lock_irqsave_rcu_node(snp, flags);
 			snp_seq = snp->srcu_have_cbs[idx];
@@ -1041,20 +1042,20 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 
 	/* Top of tree, must ensure the grace period will be started. */
 	spin_lock_irqsave_ssp_contention(ssp, &flags);
-	if (ULONG_CMP_LT(ssp->srcu_sup->srcu_gp_seq_needed, s)) {
+	if (ULONG_CMP_LT(sup->srcu_gp_seq_needed, s)) {
 		/*
 		 * Record need for grace period s.  Pair with load
 		 * acquire setting up for initialization.
 		 */
-		smp_store_release(&ssp->srcu_sup->srcu_gp_seq_needed, s); /*^^^*/
+		smp_store_release(&sup->srcu_gp_seq_needed, s); /*^^^*/
 	}
-	if (!do_norm && ULONG_CMP_LT(ssp->srcu_sup->srcu_gp_seq_needed_exp, s))
-		WRITE_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp, s);
+	if (!do_norm && ULONG_CMP_LT(sup->srcu_gp_seq_needed_exp, s))
+		WRITE_ONCE(sup->srcu_gp_seq_needed_exp, s);
 
 	/* If grace period not already in progress, start it. */
-	if (!WARN_ON_ONCE(rcu_seq_done(&ssp->srcu_sup->srcu_gp_seq, s)) &&
-	    rcu_seq_state(ssp->srcu_sup->srcu_gp_seq) == SRCU_STATE_IDLE) {
-		WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_sup->srcu_gp_seq, ssp->srcu_sup->srcu_gp_seq_needed));
+	if (!WARN_ON_ONCE(rcu_seq_done(&sup->srcu_gp_seq, s)) &&
+	    rcu_seq_state(sup->srcu_gp_seq) == SRCU_STATE_IDLE) {
+		WARN_ON_ONCE(ULONG_CMP_GE(sup->srcu_gp_seq, sup->srcu_gp_seq_needed));
 		srcu_gp_start(ssp);
 
 		// And how can that list_add() in the "else" clause
@@ -1063,12 +1064,12 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 		// can only be executed during early boot when there is only
 		// the one boot CPU running with interrupts still disabled.
 		if (likely(srcu_init_done))
-			queue_delayed_work(rcu_gp_wq, &ssp->srcu_sup->work,
+			queue_delayed_work(rcu_gp_wq, &sup->work,
 					   !!srcu_get_delay(ssp));
-		else if (list_empty(&ssp->srcu_sup->work.work.entry))
-			list_add(&ssp->srcu_sup->work.work.entry, &srcu_boot_list);
+		else if (list_empty(&sup->work.work.entry))
+			list_add(&sup->work.work.entry, &srcu_boot_list);
 	}
-	spin_unlock_irqrestore_rcu_node(ssp->srcu_sup, flags);
+	spin_unlock_irqrestore_rcu_node(sup, flags);
 }
 
 /*
-- 
2.40.0.rc2

