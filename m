Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5E76C7475
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjCXAUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbjCXATu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDECA2C66C;
        Thu, 23 Mar 2023 17:19:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 66EAAB82245;
        Fri, 24 Mar 2023 00:19:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBF4C4339C;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=l31ZVxzvsf5Mo/krVC1TzBNoZigl26axBa/w/xOsuuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0K3ytQWk89vnjC3zZ2d7/NNM+0eQFQpeAuvXn1ohJlVwm75gD9staupAQosnD0cD
         BtCRxT1fsTXKJYttuZUS9by6VyUSXd2lDUDZkiG8eeXgCPDftTzjxPDNMtt/+O2bVr
         14iki5/0ubn/M67CJIFC8VMafg5XIqX6MRBJcSMRYE6Epjlg25w0ZHhPljSVpNA+te
         bL2coV5i0P2WO3jJcb9/3lJyO5EIJXT74zeXKOBbB8VtlwT/BOZo4x9bGN/RnoQyub
         KtwyxYywUx7LRaRCebxaGP1iGYW+52qmpN9QrSgBB4txO+UfAGVZ5Ojet139G+fUqJ
         9QFHLrS1ET53g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 95153154039D; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 04/19] srcu: Move ->level from srcu_struct to srcu_usage
Date:   Thu, 23 Mar 2023 17:19:23 -0700
Message-Id: <20230324001938.3443499-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
References: <3db82572-f156-4a5d-b711-841aa28bd996@paulmck-laptop>
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

This commit moves the ->level[] array from the srcu_struct structure to
the srcu_usage structure to reduce the size of the former in order to
improve cache locality.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  4 ++--
 kernel/rcu/srcutree.c    | 14 +++++++-------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 2689e64024bb..362c8f39c53d 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -62,14 +62,14 @@ struct srcu_node {
  */
 struct srcu_usage {
 	struct srcu_node *node;			/* Combining tree. */
+	struct srcu_node *level[RCU_NUM_LVLS + 1];
+						/* First node at each level. */
 };
 
 /*
  * Per-SRCU-domain structure, similar in function to rcu_state.
  */
 struct srcu_struct {
-	struct srcu_node *level[RCU_NUM_LVLS + 1];
-						/* First node at each level. */
 	int srcu_size_state;			/* Small-to-big transition state. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
 	spinlock_t __private lock;		/* Protect counters and size state. */
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index ad1d5ca42a99..90d753e10e33 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -178,9 +178,9 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 		return false;
 
 	/* Work out the overall tree geometry. */
-	ssp->level[0] = &ssp->srcu_sup->node[0];
+	ssp->srcu_sup->level[0] = &ssp->srcu_sup->node[0];
 	for (i = 1; i < rcu_num_lvls; i++)
-		ssp->level[i] = ssp->level[i - 1] + num_rcu_lvl[i - 1];
+		ssp->srcu_sup->level[i] = ssp->srcu_sup->level[i - 1] + num_rcu_lvl[i - 1];
 	rcu_init_levelspread(levelspread, num_rcu_lvl);
 
 	/* Each pass through this loop initializes one srcu_node structure. */
@@ -202,10 +202,10 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 		}
 
 		/* Non-root node. */
-		if (snp == ssp->level[level + 1])
+		if (snp == ssp->srcu_sup->level[level + 1])
 			level++;
-		snp->srcu_parent = ssp->level[level - 1] +
-				   (snp - ssp->level[level]) /
+		snp->srcu_parent = ssp->srcu_sup->level[level - 1] +
+				   (snp - ssp->srcu_sup->level[level]) /
 				   levelspread[level - 1];
 	}
 
@@ -214,7 +214,7 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp, gfp_t gfp_flags)
 	 * leaves of the srcu_node tree.
 	 */
 	level = rcu_num_lvls - 1;
-	snp_first = ssp->level[level];
+	snp_first = ssp->srcu_sup->level[level];
 	for_each_possible_cpu(cpu) {
 		sdp = per_cpu_ptr(ssp->sda, cpu);
 		sdp->mynode = &snp_first[cpu / levelspread[level]];
@@ -889,7 +889,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		srcu_for_each_node_breadth_first(ssp, snp) {
 			spin_lock_irq_rcu_node(snp);
 			cbs = false;
-			last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
+			last_lvl = snp >= ssp->srcu_sup->level[rcu_num_lvls - 1];
 			if (last_lvl)
 				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
 			snp->srcu_have_cbs[idx] = gpseq;
-- 
2.40.0.rc2

