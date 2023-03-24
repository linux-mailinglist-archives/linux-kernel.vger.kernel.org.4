Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D786C7482
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 01:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCXAUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 20:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCXAT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 20:19:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179812E81D;
        Thu, 23 Mar 2023 17:19:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D5554B822B5;
        Fri, 24 Mar 2023 00:19:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD355C433B4;
        Fri, 24 Mar 2023 00:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679617181;
        bh=BGUB2fistUJ4gqE7rwALc7ULAezsO9b+PlI8e9ct9as=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JOWtHCxnhgFIhmU3FDT2IfbmcHRtpzmIK7aszFfqC+k5EDcplZ5lMpbmLjERbZ83W
         dRWcyYeUuTXQVF7j7eEaO4BGkjiVvlvVkEiWEkZXGVUOYeUSgW1Yc2SWPOUrcbThMF
         /0cLNxoB3dcJ0y8PXNKzMsLNi5fikH3H6tf7L1cR4tW0lsVU6BOmQZE65dbKjrYQCw
         pX/fpUr9jb9MD9p/qwwZmYet/3D6TfCjzMU3p13XsMLfqq0ei+kYCiaTDkCaz51a0o
         vUHNqLMlIbsbyHpcUyqxcaU+ooVWJo67ISAdaOqLK2ahtmCX/7DvIE0PStmXcrwgaX
         OIdZGCRF0oiuQ==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id C44BC15403AA; Thu, 23 Mar 2023 17:19:40 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH RFC rcu 17/19] srcu: Fix long lines in srcu_gp_end()
Date:   Thu, 23 Mar 2023 17:19:36 -0700
Message-Id: <20230324001938.3443499-17-paulmck@kernel.org>
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

This commit creates an srcu_usage pointer named "sup" as a shorter
synonym for the "ssp->srcu_sup" that was bloating several lines of code.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
---
 kernel/rcu/srcutree.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index fd88a98b7254..fcb2bac7bb4b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -862,28 +862,29 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	unsigned long sgsne;
 	struct srcu_node *snp;
 	int ss_state;
+	struct srcu_usage *sup = ssp->srcu_sup;
 
 	/* Prevent more than one additional grace period. */
-	mutex_lock(&ssp->srcu_sup->srcu_cb_mutex);
+	mutex_lock(&sup->srcu_cb_mutex);
 
 	/* End the current grace period. */
-	spin_lock_irq_rcu_node(ssp->srcu_sup);
-	idx = rcu_seq_state(ssp->srcu_sup->srcu_gp_seq);
+	spin_lock_irq_rcu_node(sup);
+	idx = rcu_seq_state(sup->srcu_gp_seq);
 	WARN_ON_ONCE(idx != SRCU_STATE_SCAN2);
-	if (ULONG_CMP_LT(READ_ONCE(ssp->srcu_sup->srcu_gp_seq), READ_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp)))
+	if (ULONG_CMP_LT(READ_ONCE(sup->srcu_gp_seq), READ_ONCE(sup->srcu_gp_seq_needed_exp)))
 		cbdelay = 0;
 
-	WRITE_ONCE(ssp->srcu_sup->srcu_last_gp_end, ktime_get_mono_fast_ns());
-	rcu_seq_end(&ssp->srcu_sup->srcu_gp_seq);
-	gpseq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
-	if (ULONG_CMP_LT(ssp->srcu_sup->srcu_gp_seq_needed_exp, gpseq))
-		WRITE_ONCE(ssp->srcu_sup->srcu_gp_seq_needed_exp, gpseq);
-	spin_unlock_irq_rcu_node(ssp->srcu_sup);
-	mutex_unlock(&ssp->srcu_sup->srcu_gp_mutex);
+	WRITE_ONCE(sup->srcu_last_gp_end, ktime_get_mono_fast_ns());
+	rcu_seq_end(&sup->srcu_gp_seq);
+	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
+	if (ULONG_CMP_LT(sup->srcu_gp_seq_needed_exp, gpseq))
+		WRITE_ONCE(sup->srcu_gp_seq_needed_exp, gpseq);
+	spin_unlock_irq_rcu_node(sup);
+	mutex_unlock(&sup->srcu_gp_mutex);
 	/* A new grace period can start at this point.  But only one. */
 
 	/* Initiate callback invocation as needed. */
-	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
+	ss_state = smp_load_acquire(&sup->srcu_size_state);
 	if (ss_state < SRCU_SIZE_WAIT_BARRIER) {
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, get_boot_cpu_id()),
 					cbdelay);
@@ -892,7 +893,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		srcu_for_each_node_breadth_first(ssp, snp) {
 			spin_lock_irq_rcu_node(snp);
 			cbs = false;
-			last_lvl = snp >= ssp->srcu_sup->level[rcu_num_lvls - 1];
+			last_lvl = snp >= sup->level[rcu_num_lvls - 1];
 			if (last_lvl)
 				cbs = ss_state < SRCU_SIZE_BIG || snp->srcu_have_cbs[idx] == gpseq;
 			snp->srcu_have_cbs[idx] = gpseq;
@@ -924,18 +925,18 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		}
 
 	/* Callback initiation done, allow grace periods after next. */
-	mutex_unlock(&ssp->srcu_sup->srcu_cb_mutex);
+	mutex_unlock(&sup->srcu_cb_mutex);
 
 	/* Start a new grace period if needed. */
-	spin_lock_irq_rcu_node(ssp->srcu_sup);
-	gpseq = rcu_seq_current(&ssp->srcu_sup->srcu_gp_seq);
+	spin_lock_irq_rcu_node(sup);
+	gpseq = rcu_seq_current(&sup->srcu_gp_seq);
 	if (!rcu_seq_state(gpseq) &&
-	    ULONG_CMP_LT(gpseq, ssp->srcu_sup->srcu_gp_seq_needed)) {
+	    ULONG_CMP_LT(gpseq, sup->srcu_gp_seq_needed)) {
 		srcu_gp_start(ssp);
-		spin_unlock_irq_rcu_node(ssp->srcu_sup);
+		spin_unlock_irq_rcu_node(sup);
 		srcu_reschedule(ssp, 0);
 	} else {
-		spin_unlock_irq_rcu_node(ssp->srcu_sup);
+		spin_unlock_irq_rcu_node(sup);
 	}
 
 	/* Transition to big if needed. */
@@ -943,7 +944,7 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 		if (ss_state == SRCU_SIZE_ALLOC)
 			init_srcu_struct_nodes(ssp, GFP_KERNEL);
 		else
-			smp_store_release(&ssp->srcu_sup->srcu_size_state, ss_state + 1);
+			smp_store_release(&sup->srcu_size_state, ss_state + 1);
 	}
 }
 
-- 
2.40.0.rc2

