Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588936D128C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbjC3Wsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231176AbjC3WsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:48:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A341114A;
        Thu, 30 Mar 2023 15:47:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 038C8621E1;
        Thu, 30 Mar 2023 22:47:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DFB2C43444;
        Thu, 30 Mar 2023 22:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680216449;
        bh=BFCXKUKL73Xf4o7sL1OPzuArpLQgxGcR88Y6JAad7z0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pgJkhYZqWCVl9xMU0FuMVBbQzujZKJ6vkuHwgdSPnoONXOiM/qS+4aipxMMZ58ECW
         dpWqM/3BmFJ+BDe7fE3YpAE3vdm+fkJHh/Axcrx1aSPG60kY3bzKqcOVUGY4hA6dMC
         nj6Gj0mzONzS8FSK23SXz59vnyhZWJ2GGrIxpU85k4y/YQhzUX1HsL9HY5nlyG3Aur
         +ZwJgbIoKAcIl1VDRwDqktmb77kSBmLyj3E07CqOTwE2PL6JWf9eSdJWAbOefIM2EV
         12Torc+JpN+rTxShArz3Pe8BH5CsZi6kHwKNpcc9KEluBLbQvU2Hha8yPWyV79AO57
         Gek9gSJBTEK+g==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 3E04C154048F; Thu, 30 Mar 2023 15:47:28 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, hch@lst.de,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Sachin Sant <sachinp@linux.ibm.com>,
        "Zhang, Qiang1" <qiang1.zhang@intel.com>
Subject: [PATCH rcu 19/20] srcu: Fix long lines in srcu_gp_end()
Date:   Thu, 30 Mar 2023 15:47:25 -0700
Message-Id: <20230330224726.662344-19-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.0.rc2
In-Reply-To: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
References: <f1b6cd5f-f0b7-4748-abd5-0dcfef0ce126@paulmck-laptop>
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

Cc: Christoph Hellwig <hch@lst.de>
Tested-by: Sachin Sant <sachinp@linux.ibm.com>
Tested-by: "Zhang, Qiang1" <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/srcutree.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 11a08201ca0a..f661a0f6bc0d 100644
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

