Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E23626C747F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCXAUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjCXAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994A2E0E3;
        Thu, 23 Mar 2023 17:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E0F84B822B8;
        Fri, 24 Mar 2023 00:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC604C433B3;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=n01ySLfbpYhus3Mob79To2m1LPQToRsdp4kgb/5Hf30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VLuPzNlCYuKg3TaBy/0difG1UhzPlTqt2rEuEtkPtyAaxZU3H0ZuprO6BsoMhLNyO
         JgmqxDdZPk1h4spbzVRTjjafiVD1bpQgETQMit9Yq/zxc38SrF0/L00TowiAQynwZG
         pZBIR5nIrrraXyhU6ix/xtC7+oNqcPvAOzaIr93nZoPw8xy7d3BpvRcqo7oZtUkU8k
         fG14zhuZxOjNsVd+iJ79V6TqA9+K2z4M+pAEjR777LowwZfgJs66XvQGKX0po4GDmz
         vvGqZfamClj6Hm6Yndi+TOlCftlntgYK8FFRMYfOppX2GpaDvFmjRchmttFNv30oU4
         KSVTmaCeasItA==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C78F315403AB; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 18/19] srcu: Fix long lines in srcu_funnel_gp_start()
Date:   Thu, 23 Mar 2023 17:19:37 -0700
Message-Id: <20230324001938.3443499-18-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit creates an srcu_usage pointer named "sup" as a shorter
synonym for the "ssp->srcu_sup" that was bloating several lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/rcu/srcutree.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index fcb2bac7bb4b..61dd47981b40 100644
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

