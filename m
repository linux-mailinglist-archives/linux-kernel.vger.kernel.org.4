Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B20717D0F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235478AbjEaKSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235891AbjEaKSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:18:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4951B5;
        Wed, 31 May 2023 03:18:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A88F632A4;
        Wed, 31 May 2023 10:18:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73362C433D2;
        Wed, 31 May 2023 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528283;
        bh=Q+V6lDaB+nI7Zb8ZY0l0DT3+Ay/ikMB41CH+Vnegztk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iOURKizWFHjf9TqHBki8TDKWAOfA1cDXYYFNpLsdj95k/S5ge3ejck9fnzTm3zPG4
         82cRaBH93RDUvCYwmwZOGEiOXDfbxQQUiQYVqgY30gH5zrdT0kVy0TuWAT56jh5a7X
         YQgYrQ+gHo7pWIVCVujqT3rcp/fiYhh7hUL9UuHWDvY5YTXrUaVVXU9Q4Ib+TDQqix
         dqH0611o5ATRE2MVyK7LcgH0rWNT/Jj1a5xGvXKTLBnM1dN/mCnEunc3AxVXXteKrE
         4OiigEYTnMJoMzEMIduiLqgIjHXOW9COAd8Y7o1W1PTF5g4oZIRwf/expMWiSZkmfS
         /rh8hKBeOj1Lg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 6/9] rcu/nocb: Rename was_alldone to was_pending
Date:   Wed, 31 May 2023 12:17:33 +0200
Message-Id: <20230531101736.12981-7-frederic@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531101736.12981-1-frederic@kernel.org>
References: <20230531101736.12981-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon enqueuing on an offloaded rdp, RCU checks if the queue was
previsouly only made of done callbacks and relies on that information
in order to determine if the rcuog kthread needs to be woken up.

In order to prepare for moving the lazy callbacks from the bypass queue
to the main queue, track instead if there are pending callbacks. For
now the meaning of "having pending callbacks" is just the reverse of
"having only done callbacks". However lazy callbacks will be ignored
from the pending queue in a further patch.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/tree.c      | 14 +++++++-------
 kernel/rcu/tree.h      |  2 +-
 kernel/rcu/tree_nocb.h | 28 ++++++++++++++--------------
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e33c0d889216..d71b9915c91e 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2633,7 +2633,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	unsigned long flags;
 	bool lazy;
 	struct rcu_data *rdp;
-	bool was_alldone;
+	bool was_pending;
 
 	/* Misaligned rcu_head! */
 	WARN_ON_ONCE((unsigned long)head & (sizeof(void *) - 1));
@@ -2670,7 +2670,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 
 	check_cb_ovld(rdp);
-	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags, lazy))
+	if (rcu_nocb_try_bypass(rdp, head, &was_pending, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
@@ -2686,7 +2686,7 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 
 	/* Go handle any RCU core processing required. */
 	if (unlikely(rcu_rdp_is_offloaded(rdp))) {
-		__call_rcu_nocb_wake(rdp, was_alldone, flags); /* unlocks */
+		__call_rcu_nocb_wake(rdp, was_pending, flags); /* unlocks */
 	} else {
 		__call_rcu_core(rdp, head, flags);
 		local_irq_restore(flags);
@@ -3936,8 +3936,8 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 {
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
+	bool nocb_no_pending = false;
 	bool wake_nocb = false;
-	bool was_alldone = false;
 
 	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
@@ -3951,9 +3951,9 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	 * queue. This way we don't wait for bypass timer that can reach seconds
 	 * if it's fully lazy.
 	 */
-	was_alldone = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
+	nocb_no_pending = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
 	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
-	wake_nocb = was_alldone && rcu_segcblist_pend_cbs(&rdp->cblist);
+	wake_nocb = nocb_no_pending && rcu_segcblist_pend_cbs(&rdp->cblist);
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -4549,7 +4549,7 @@ void rcutree_migrate_callbacks(int cpu)
 	check_cb_ovld_locked(my_rdp, my_rnp);
 	if (rcu_rdp_is_offloaded(my_rdp)) {
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
-		__call_rcu_nocb_wake(my_rdp, true, flags);
+		__call_rcu_nocb_wake(my_rdp, false, flags);
 	} else {
 		rcu_nocb_unlock(my_rdp); /* irqs remain disabled. */
 		raw_spin_unlock_irqrestore_rcu_node(my_rnp, flags);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 192536916f9a..966abe037f57 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -464,7 +464,7 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 				  unsigned long j, bool lazy);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags,
+				bool *was_pending, unsigned long flags,
 				bool lazy);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index c08447db5a2e..d8b17c69110a 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -413,7 +413,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
  * there is only one CPU in operation.
  */
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags,
+				bool *was_pending, unsigned long flags,
 				bool lazy)
 {
 	unsigned long c;
@@ -427,7 +427,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// Pure softirq/rcuc based processing: no bypassing, no
 	// locking.
 	if (!rcu_rdp_is_offloaded(rdp)) {
-		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false;
 	}
 
@@ -435,7 +435,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// locking.
 	if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
 		rcu_nocb_lock(rdp);
-		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false; /* Not offloaded, no bypassing. */
 	}
 
@@ -443,7 +443,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
 		rcu_nocb_lock(rdp);
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
-		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
 		return false;
 	}
 
@@ -468,8 +468,8 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// Lazy CBs throttle this back and do immediate bypass queuing.
 	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) {
 		rcu_nocb_lock(rdp);
-		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
-		if (*was_alldone)
+		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
+		if (!*was_pending)
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstQ"));
 
@@ -484,10 +484,10 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	    ((!bypass_is_lazy && ((j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark)) ||
 	     (bypass_is_lazy && (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush) || ncbs >= qhimark_lazy)))) {
 		rcu_nocb_lock(rdp);
-		*was_alldone = !rcu_segcblist_pend_cbs(&rdp->cblist);
+		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
 
 		if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy)) {
-			if (*was_alldone)
+			if (!*was_pending)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
 			WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
@@ -503,7 +503,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		// The flush succeeded and we moved CBs into the regular list.
 		// Don't wait for the wake up timer as it may be too far ahead.
 		// Wake up the GP thread now instead, if the cblist was empty.
-		__call_rcu_nocb_wake(rdp, *was_alldone, flags);
+		__call_rcu_nocb_wake(rdp, *was_pending, flags);
 
 		return true; // Callback already enqueued.
 	}
@@ -539,7 +539,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		if (!rcu_segcblist_pend_cbs(&rdp->cblist)) {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQwake"));
-			__call_rcu_nocb_wake(rdp, true, flags);
+			__call_rcu_nocb_wake(rdp, false, flags);
 		} else {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQnoWake"));
@@ -555,7 +555,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
  *
  * If warranted, also wake up the kthread servicing this CPUs queues.
  */
-static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
+static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_pending,
 				 unsigned long flags)
 				 __releases(rdp->nocb_lock)
 {
@@ -578,7 +578,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	len = rcu_segcblist_n_cbs(&rdp->cblist);
 	bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 	lazy_len = READ_ONCE(rdp->lazy_len);
-	if (was_alldone) {
+	if (!was_pending) {
 		rdp->qlen_last_fqs_check = len;
 		// Only lazy CBs in bypass list
 		if (lazy_len && bypass_len == lazy_len) {
@@ -1767,12 +1767,12 @@ static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 }
 
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_alldone, unsigned long flags, bool lazy)
+				bool *was_pending, unsigned long flags, bool lazy)
 {
 	return false;
 }
 
-static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
+static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_pending,
 				 unsigned long flags)
 {
 	WARN_ON_ONCE(1);  /* Should be dead code! */
-- 
2.40.1

