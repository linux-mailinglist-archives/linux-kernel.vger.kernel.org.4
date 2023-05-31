Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C239717D12
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234571AbjEaKTF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231514AbjEaKST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:18:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431FBE45;
        Wed, 31 May 2023 03:18:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1E1FE632D2;
        Wed, 31 May 2023 10:18:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1058EC4339B;
        Wed, 31 May 2023 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528286;
        bh=JI+zCdQIPywTzYQ2XlPqVyYDc0CNvcXd6W1q9yu8sXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Os0hL/d0D1vHsP5DYmYRTnXAZGUc2+ziS3PNtLtBTMwCXolEiwr139pBMuwGBNc2/
         leTQoDEx6jiv8+TBy3r2W3WrViCL4ZKijCMvYkFKvFtmoBEBei6w/L88R+jWXYxrHz
         DRVEsmh8r6s6UWA1BcUORqIXb6x8Bq00KYGUVvC4XkQDfTLX9vqEcW13b0u8BULgSi
         EF7qbsUnbQ1nIHC9IeAoA9FQtTmzP45ZSWI/4oE0/A3M/pzBqLY2g9LaAj8SnE3oJe
         aJ2OXV21lMIQsYLH6FqaZn/PlFzzpcv7HlBlIJLzuufBqwcNm1FJrNf1jqIbgNe06a
         iq/G31Xt3a+hA==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 7/9] rcu: Implement lazyness on the main segcblist level
Date:   Wed, 31 May 2023 12:17:34 +0200
Message-Id: <20230531101736.12981-8-frederic@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230531101736.12981-1-frederic@kernel.org>
References: <20230531101736.12981-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The lazy queue is currently implemented by the bypass list which only
exists on CONFIG_RCU_NOCB=y with offloaded rdp.

Supporting the lazy queue on non offloaded rdp will require a different
approach based on the main per-cpu segmented callback list. And ideally
most of the lazy infrastructure behind offloaded and non-offloaded
should be made generic and consolidated.

Therefore in order to prepare for supporting lazy callbacks on
non-offloaded rdp, switch the lazy callbacks infrastructure from the
bypass list to the main segmented callback list.

Lazy callbacks are then enqueued like any other callbacks to the
RCU_NEXT_TAIL segment and a SEGCBLIST_NEXT_TAIL_LAZY flag tells if that
segment is completely lazy or not. A lazy queue gets ignored by
acceleration, unless it can piggyback with the acceleration of existing
callbacks in RCU_NEXT_READY_TAIL or RCU_WAIT_TAIL. If anything this
introduces a tiny optimization as compared to the bypass list.

As for the offloaded implementation specifics, the rcuog kthread is
only woken up if the RCU_NEXT_TAIL segment is not lazy.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 include/linux/rcu_segcblist.h |  13 +--
 kernel/rcu/rcu_segcblist.c    |  42 ++++++++--
 kernel/rcu/rcu_segcblist.h    |  21 ++++-
 kernel/rcu/tree.c             |  98 ++++++++++++++++++++--
 kernel/rcu/tree.h             |   8 +-
 kernel/rcu/tree_nocb.h        | 154 ++++++++++++++--------------------
 6 files changed, 221 insertions(+), 115 deletions(-)

diff --git a/include/linux/rcu_segcblist.h b/include/linux/rcu_segcblist.h
index 659d13a7ddaa..9bc2d556d4d4 100644
--- a/include/linux/rcu_segcblist.h
+++ b/include/linux/rcu_segcblist.h
@@ -196,12 +196,13 @@ struct rcu_cblist {
  *  |  rcuc kthread, without holding nocb_lock.                                |
  *  ----------------------------------------------------------------------------
  */
-#define SEGCBLIST_ENABLED	BIT(0)
-#define SEGCBLIST_RCU_CORE	BIT(1)
-#define SEGCBLIST_LOCKING	BIT(2)
-#define SEGCBLIST_KTHREAD_CB	BIT(3)
-#define SEGCBLIST_KTHREAD_GP	BIT(4)
-#define SEGCBLIST_OFFLOADED	BIT(5)
+#define SEGCBLIST_ENABLED		BIT(0)
+#define SEGCBLIST_RCU_CORE		BIT(1)
+#define SEGCBLIST_LOCKING		BIT(2)
+#define SEGCBLIST_KTHREAD_CB		BIT(3)
+#define SEGCBLIST_KTHREAD_GP		BIT(4)
+#define SEGCBLIST_OFFLOADED		BIT(5)
+#define SEGCBLIST_NEXT_TAIL_LAZY	BIT(6)
 
 struct rcu_segcblist {
 	struct rcu_head *head;
diff --git a/kernel/rcu/rcu_segcblist.c b/kernel/rcu/rcu_segcblist.c
index 1693ea22ef1b..9f604d721cb9 100644
--- a/kernel/rcu/rcu_segcblist.c
+++ b/kernel/rcu/rcu_segcblist.c
@@ -291,6 +291,27 @@ bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp)
 	       !rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL);
 }
 
+/*
+ * Does the specified segcblist have pending callbacks beyond the
+ * lazy ones?
+ */
+bool rcu_segcblist_pend_cbs_nolazy(struct rcu_segcblist *rsclp)
+{
+	int i;
+
+	if (!rcu_segcblist_pend_cbs(rsclp))
+		return false;
+
+	if (!rcu_segcblist_n_cbs_lazy(rsclp))
+		return true;
+
+	for (i = RCU_WAIT_TAIL; i < RCU_NEXT_TAIL; i++)
+		if (!rcu_segcblist_segempty(rsclp, i))
+			return true;
+
+	return false;
+}
+
 /*
  * Return a pointer to the first callback in the specified rcu_segcblist
  * structure.  This is useful for diagnostics.
@@ -320,9 +341,9 @@ struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp)
  * Return false if there are no CBs awaiting grace periods, otherwise,
  * return true and store the nearest waited-upon grace period into *lp.
  */
-bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp)
+bool rcu_segcblist_nextgp_nolazy(struct rcu_segcblist *rsclp, unsigned long *lp)
 {
-	if (!rcu_segcblist_pend_cbs(rsclp))
+	if (!rcu_segcblist_pend_cbs_nolazy(rsclp))
 		return false;
 	*lp = rsclp->gp_seq[RCU_WAIT_TAIL];
 	return true;
@@ -537,6 +558,7 @@ void rcu_segcblist_advance(struct rcu_segcblist *rsclp, unsigned long seq)
 bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 {
 	int i, j;
+	bool empty_dest = true;
 
 	WARN_ON_ONCE(!rcu_segcblist_is_enabled(rsclp));
 	if (rcu_segcblist_restempty(rsclp, RCU_DONE_TAIL))
@@ -550,10 +572,14 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	 * callbacks in the RCU_NEXT_TAIL segment, and assigned "seq"
 	 * as their ->gp_seq[] grace-period completion sequence number.
 	 */
-	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--)
-		if (!rcu_segcblist_segempty(rsclp, i) &&
-		    ULONG_CMP_LT(rsclp->gp_seq[i], seq))
-			break;
+	for (i = RCU_NEXT_READY_TAIL; i > RCU_DONE_TAIL; i--) {
+		if (!rcu_segcblist_segempty(rsclp, i)) {
+			if (ULONG_CMP_LT(rsclp->gp_seq[i], seq))
+				break;
+			else
+				empty_dest = false;
+		}
+	}
 
 	/*
 	 * If all the segments contain callbacks that correspond to
@@ -579,6 +605,10 @@ bool rcu_segcblist_accelerate(struct rcu_segcblist *rsclp, unsigned long seq)
 	if (rcu_segcblist_restempty(rsclp, i) || ++i >= RCU_NEXT_TAIL)
 		return false;
 
+	/* Ignore lazy callbacks, unless there is a queue they can piggyback in. */
+	if (rcu_segcblist_next_is_lazy(rsclp) && empty_dest)
+		return false;
+
 	/* Accounting: everything below i is about to get merged into i. */
 	for (j = i + 1; j <= RCU_NEXT_TAIL; j++)
 		rcu_segcblist_move_seglen(rsclp, j, i);
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 4fe877f5f654..620ca48e782b 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -104,6 +104,24 @@ static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rscl
 	return false;
 }
 
+static inline bool rcu_segcblist_next_is_lazy(struct rcu_segcblist *rsclp)
+{
+	if (IS_ENABLED(CONFIG_RCU_LAZY) &&
+	    rcu_segcblist_test_flags(rsclp, SEGCBLIST_NEXT_TAIL_LAZY))
+		return true;
+
+	return false;
+}
+
+/* Return number of callbacks in segmented callback list. */
+static inline long rcu_segcblist_n_cbs_lazy(struct rcu_segcblist *rsclp)
+{
+	if (rcu_segcblist_next_is_lazy(rsclp))
+		return rcu_segcblist_get_seglen(rsclp, RCU_NEXT_TAIL);
+	else
+		return 0;
+}
+
 /*
  * Are all segments following the specified segment of the specified
  * rcu_segcblist structure empty of callbacks?  (The specified
@@ -132,9 +150,10 @@ void rcu_segcblist_disable(struct rcu_segcblist *rsclp);
 void rcu_segcblist_offload(struct rcu_segcblist *rsclp, bool offload);
 bool rcu_segcblist_ready_cbs(struct rcu_segcblist *rsclp);
 bool rcu_segcblist_pend_cbs(struct rcu_segcblist *rsclp);
+bool rcu_segcblist_pend_cbs_nolazy(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_cb(struct rcu_segcblist *rsclp);
 struct rcu_head *rcu_segcblist_first_pend_cb(struct rcu_segcblist *rsclp);
-bool rcu_segcblist_nextgp(struct rcu_segcblist *rsclp, unsigned long *lp);
+bool rcu_segcblist_nextgp_nolazy(struct rcu_segcblist *rsclp, unsigned long *lp);
 void rcu_segcblist_enqueue(struct rcu_segcblist *rsclp,
 			   struct rcu_head *rhp);
 bool rcu_segcblist_entrain(struct rcu_segcblist *rsclp,
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d71b9915c91e..e48ccbe0f2f6 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -394,6 +394,16 @@ module_param(qhimark_lazy, long, 0444);
 module_param(qlowmark, long, 0444);
 module_param(qovld, long, 0444);
 
+/*
+ * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
+ * can elapse before lazy callbacks are flushed. Lazy callbacks
+ * could be flushed much earlier for a number of other reasons
+ * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
+ * left unsubmitted to RCU after those many jiffies.
+ */
+#define LAZY_FLUSH_JIFFIES (10 * HZ)
+static unsigned long jiffies_lazy_flush = LAZY_FLUSH_JIFFIES;
+
 static ulong jiffies_till_first_fqs = IS_ENABLED(CONFIG_RCU_STRICT_GRACE_PERIOD) ? 0 : ULONG_MAX;
 static ulong jiffies_till_next_fqs = ULONG_MAX;
 static bool rcu_kick_kthreads;
@@ -1074,8 +1084,12 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	 * number.
 	 */
 	gp_seq_req = rcu_seq_snap(&rcu_state.gp_seq);
-	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req))
+	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req)) {
+		/* The RCU_NEXT_TAIL has been flushed, reset the lazy bit accordingly */
+		if (IS_ENABLED(CONFIG_RCU_LAZY) && qhimark_lazy && rcu_segcblist_completely_offloaded(&rdp->cblist))
+			rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
 		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
+	}
 
 	/* Trace depending on how much we were able to accelerate. */
 	if (rcu_segcblist_restempty(&rdp->cblist, RCU_WAIT_TAIL))
@@ -1105,7 +1119,11 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 	c = rcu_seq_snap(&rcu_state.gp_seq);
 	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		/* Old request still live, so mark recent callbacks. */
-		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
+		if (rcu_segcblist_accelerate(&rdp->cblist, c)) {
+			/* The RCU_NEXT_TAIL has been flushed, reset the lazy bit accordingly */
+			if (IS_ENABLED(CONFIG_RCU_LAZY) && qhimark_lazy && rcu_segcblist_completely_offloaded(&rdp->cblist))
+				rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+		}
 		return;
 	}
 	raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
@@ -2626,6 +2644,56 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
+/*
+ * Handle lazy callbacks. Return true if no further handling is needed (unlocks nocb then).
+ * Return false if further treatment is needed (wake rcuog kthread, set the nocb timer, etc...).
+ */
+static bool __call_rcu_lazy(struct rcu_data *rdp, bool was_pending, bool lazy, unsigned long flags)
+	__releases(rdp->nocb_lock)
+{
+	long lazy_len;
+	unsigned long timeout;
+
+	if (!rcu_segcblist_next_is_lazy(&rdp->cblist))
+		return false;
+
+	/* New callback is not lazy, unlazy the queue */
+	if (!lazy) {
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+		return false;
+	}
+
+	lazy_len = rcu_segcblist_get_seglen(&rdp->cblist, RCU_NEXT_TAIL);
+	/* First lazy callback on an empty queue, set the timer if necessary */
+	if (lazy_len == 1) {
+		WRITE_ONCE(rdp->lazy_firstq, jiffies);
+		if (!was_pending)
+			return false;
+		else
+			goto out;
+	}
+
+	/* Too many lazy callbacks, unlazy them */
+	if (lazy_len >= qhimark_lazy) {
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+		return false;
+	}
+
+	timeout = rdp->lazy_firstq + jiffies_lazy_flush;
+
+	/* Lazy callbacks are too old, unlazy them */
+	if (time_after(READ_ONCE(jiffies), timeout)) {
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+		return false;
+	}
+
+out:
+	/* No further treatment is needed */
+	rcu_nocb_unlock_irqrestore(rdp, flags);
+
+	return true;
+}
+
 static void
 __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 {
@@ -2670,8 +2738,10 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 	}
 
 	check_cb_ovld(rdp);
+
 	if (rcu_nocb_try_bypass(rdp, head, &was_pending, flags, lazy))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
+
 	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kvfree_rcu_offset((unsigned long)func))
@@ -2684,6 +2754,9 @@ __call_rcu_common(struct rcu_head *head, rcu_callback_t func, bool lazy_in)
 
 	trace_rcu_segcb_stats(&rdp->cblist, TPS("SegCBQueued"));
 
+	if (__call_rcu_lazy(rdp, was_pending, lazy, flags))
+		return;
+
 	/* Go handle any RCU core processing required. */
 	if (unlikely(rcu_rdp_is_offloaded(rdp))) {
 		__call_rcu_nocb_wake(rdp, was_pending, flags); /* unlocks */
@@ -3948,12 +4021,18 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	rcu_nocb_lock(rdp);
 	/*
 	 * Flush bypass and wakeup rcuog if we add callbacks to an empty regular
-	 * queue. This way we don't wait for bypass timer that can reach seconds
-	 * if it's fully lazy.
+	 * queue. This way we don't wait for bypass timer.
 	 */
-	nocb_no_pending = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs(&rdp->cblist);
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
+	nocb_no_pending = rcu_rdp_is_offloaded(rdp) && !rcu_segcblist_pend_cbs_nolazy(&rdp->cblist);
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
+	/*
+	 * Make sure the entrained callback isn't treated as lazy. This brainlessly
+	 * flush the queue and might even prevent the next lazy callback from being
+	 * treated as lazy if RCU_NEXT_TAIL is empty. But no big deal.
+	 */
+	rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
 	wake_nocb = nocb_no_pending && rcu_segcblist_pend_cbs(&rdp->cblist);
+
 	if (rcu_segcblist_entrain(&rdp->cblist, &rdp->barrier_head)) {
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
@@ -4536,7 +4615,12 @@ void rcutree_migrate_callbacks(int cpu)
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
 	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies, false));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(my_rdp, NULL, jiffies));
+	/*
+	 * We are going to merge external callbacks, make sure they won't
+	 * be accidentally tagged as lazy.
+	 */
+	rcu_segcblist_clear_flags(&my_rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
 	raw_spin_lock_rcu_node(my_rnp); /* irqs already disabled. */
 	/* Leverage recent GPs and set GP for new callbacks. */
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 966abe037f57..90b39ff8ad70 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -281,8 +281,7 @@ struct rcu_data {
 	unsigned long last_sched_clock;	/* Jiffies of last rcu_sched_clock_irq(). */
 	struct rcu_snap_record snap_record; /* Snapshot of core stats at half of */
 					    /* the first RCU stall timeout */
-
-	long lazy_len;			/* Length of buffered lazy callbacks. */
+	unsigned long lazy_firstq;
 	int cpu;
 };
 
@@ -462,10 +461,9 @@ static void rcu_nocb_gp_cleanup(struct swait_queue_head *sq);
 static void rcu_init_one_nocb(struct rcu_node *rnp);
 static bool wake_nocb_gp(struct rcu_data *rdp, bool force);
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j, bool lazy);
+				  unsigned long j);
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_pending, unsigned long flags,
-				bool lazy);
+				bool *was_pending, unsigned long flags, bool lazy);
 static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_empty,
 				 unsigned long flags);
 static int rcu_nocb_need_deferred_wakeup(struct rcu_data *rdp, int level);
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index d8b17c69110a..fbd54a2e1f17 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -256,16 +256,6 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 	return __wake_nocb_gp(rdp_gp, rdp, force, flags);
 }
 
-/*
- * LAZY_FLUSH_JIFFIES decides the maximum amount of time that
- * can elapse before lazy callbacks are flushed. Lazy callbacks
- * could be flushed much earlier for a number of other reasons
- * however, LAZY_FLUSH_JIFFIES will ensure no lazy callbacks are
- * left unsubmitted to RCU after those many jiffies.
- */
-#define LAZY_FLUSH_JIFFIES (10 * HZ)
-static unsigned long jiffies_lazy_flush = LAZY_FLUSH_JIFFIES;
-
 #ifdef CONFIG_RCU_LAZY
 // To be called only from test code.
 void rcu_lazy_set_jiffies_lazy_flush(unsigned long jif)
@@ -327,16 +317,16 @@ static void wake_nocb_gp_defer(struct rcu_data *rdp, int waketype,
  *
  * Note that this function always returns true if rhp is NULL.
  */
-static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_in,
-				     unsigned long j, bool lazy)
+static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
+				     unsigned long j)
 {
 	struct rcu_cblist rcl;
-	struct rcu_head *rhp = rhp_in;
+	long len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 
 	WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp));
 	rcu_lockdep_assert_cblist_protected(rdp);
 	lockdep_assert_held(&rdp->nocb_bypass_lock);
-	if (rhp && !rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
+	if (rhp && !len) {
 		raw_spin_unlock(&rdp->nocb_bypass_lock);
 		return false;
 	}
@@ -344,22 +334,15 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_
 	if (rhp)
 		rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
 
-	/*
-	 * If the new CB requested was a lazy one, queue it onto the main
-	 * ->cblist so that we can take advantage of the grace-period that will
-	 * happen regardless. But queue it onto the bypass list first so that
-	 * the lazy CB is ordered with the existing CBs in the bypass list.
-	 */
-	if (lazy && rhp) {
-		rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
-		rhp = NULL;
-	}
 	rcu_cblist_flush_enqueue(&rcl, &rdp->nocb_bypass, rhp);
-	WRITE_ONCE(rdp->lazy_len, 0);
 
 	rcu_segcblist_insert_pend_cbs(&rdp->cblist, &rcl);
 	WRITE_ONCE(rdp->nocb_bypass_first, j);
 	rcu_nocb_bypass_unlock(rdp);
+
+	if (len)
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+
 	return true;
 }
 
@@ -372,13 +355,13 @@ static bool rcu_nocb_do_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp_
  * Note that this function always returns true if rhp is NULL.
  */
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j, bool lazy)
+				  unsigned long j)
 {
 	if (!rcu_rdp_is_offloaded(rdp))
 		return true;
 	rcu_lockdep_assert_cblist_protected(rdp);
 	rcu_nocb_bypass_lock(rdp);
-	return rcu_nocb_do_flush_bypass(rdp, rhp, j, lazy);
+	return rcu_nocb_do_flush_bypass(rdp, rhp, j);
 }
 
 /*
@@ -391,7 +374,7 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
 	if (!rcu_rdp_is_offloaded(rdp) ||
 	    !rcu_nocb_bypass_trylock(rdp))
 		return;
-	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j, false));
+	WARN_ON_ONCE(!rcu_nocb_do_flush_bypass(rdp, NULL, j));
 }
 
 /*
@@ -413,14 +396,12 @@ static void rcu_nocb_try_flush_bypass(struct rcu_data *rdp, unsigned long j)
  * there is only one CPU in operation.
  */
 static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				bool *was_pending, unsigned long flags,
-				bool lazy)
+				bool *was_pending, unsigned long flags, bool lazy)
 {
 	unsigned long c;
 	unsigned long cur_gp_seq;
 	unsigned long j = jiffies;
 	long ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-	bool bypass_is_lazy = (ncbs == READ_ONCE(rdp->lazy_len));
 
 	lockdep_assert_irqs_disabled();
 
@@ -435,7 +416,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	// locking.
 	if (!rcu_segcblist_completely_offloaded(&rdp->cblist)) {
 		rcu_nocb_lock(rdp);
-		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
+		*was_pending = rcu_segcblist_pend_cbs_nolazy(&rdp->cblist);
 		return false; /* Not offloaded, no bypassing. */
 	}
 
@@ -443,7 +424,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	if (rcu_scheduler_active != RCU_SCHEDULER_RUNNING) {
 		rcu_nocb_lock(rdp);
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
-		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
+		*was_pending = rcu_segcblist_pend_cbs_nolazy(&rdp->cblist);
 		return false;
 	}
 
@@ -460,33 +441,34 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 		else if (c > nocb_nobypass_lim_per_jiffy)
 			c = nocb_nobypass_lim_per_jiffy;
 	}
-	WRITE_ONCE(rdp->nocb_nobypass_count, c);
 
 	// If there hasn't yet been all that many ->cblist enqueues
 	// this jiffy, tell the caller to enqueue onto ->cblist.  But flush
 	// ->nocb_bypass first.
-	// Lazy CBs throttle this back and do immediate bypass queuing.
-	if (rdp->nocb_nobypass_count < nocb_nobypass_lim_per_jiffy && !lazy) {
+	if (c < nocb_nobypass_lim_per_jiffy) {
 		rcu_nocb_lock(rdp);
-		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
+		if (!rcu_segcblist_next_is_lazy(&rdp->cblist) || !lazy)
+			WRITE_ONCE(rdp->nocb_nobypass_count, c);
+		*was_pending = rcu_segcblist_pend_cbs_nolazy(&rdp->cblist);
 		if (!*was_pending)
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstQ"));
 
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j, false));
+		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, j));
 		WARN_ON_ONCE(rcu_cblist_n_cbs(&rdp->nocb_bypass));
 		return false; // Caller must enqueue the callback.
 	}
 
+	WRITE_ONCE(rdp->nocb_nobypass_count, c);
+
 	// If ->nocb_bypass has been used too long or is too full,
 	// flush ->nocb_bypass to ->cblist.
 	if (ncbs &&
-	    ((!bypass_is_lazy && ((j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark)) ||
-	     (bypass_is_lazy && (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush) || ncbs >= qhimark_lazy)))) {
+	    ((j != READ_ONCE(rdp->nocb_bypass_first)) || ncbs >= qhimark)) {
 		rcu_nocb_lock(rdp);
-		*was_pending = rcu_segcblist_pend_cbs(&rdp->cblist);
+		*was_pending = rcu_segcblist_pend_cbs_nolazy(&rdp->cblist);;
 
-		if (!rcu_nocb_flush_bypass(rdp, rhp, j, lazy)) {
+		if (!rcu_nocb_flush_bypass(rdp, rhp, j)) {
 			if (!*was_pending)
 				trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 						    TPS("FirstQ"));
@@ -494,7 +476,7 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 			return false; // Caller must enqueue the callback.
 		}
 		if (j != rdp->nocb_gp_adv_time &&
-		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		    rcu_segcblist_nextgp_nolazy(&rdp->cblist, &cur_gp_seq) &&
 		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
@@ -515,9 +497,6 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	rcu_segcblist_inc_len(&rdp->cblist); /* Must precede enqueue. */
 	rcu_cblist_enqueue(&rdp->nocb_bypass, rhp);
 
-	if (lazy)
-		WRITE_ONCE(rdp->lazy_len, rdp->lazy_len + 1);
-
 	if (!ncbs) {
 		WRITE_ONCE(rdp->nocb_bypass_first, j);
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("FirstBQ"));
@@ -525,18 +504,14 @@ static bool rcu_nocb_try_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
 	rcu_nocb_bypass_unlock(rdp);
 	smp_mb(); /* Order enqueue before wake. */
 	// A wake up of the grace period kthread or timer adjustment
-	// needs to be done only if:
-	// 1. Bypass list was fully empty before (this is the first
-	//    bypass list entry), or:
-	// 2. Both of these conditions are met:
-	//    a. The bypass list previously had only lazy CBs, and:
-	//    b. The new CB is non-lazy.
-	if (ncbs && (!bypass_is_lazy || lazy)) {
+	// needs to be done only if bypass list was fully empty before
+	// (this is the first bypass list entry).
+	if (ncbs) {
 		local_irq_restore(flags);
 	} else {
 		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
 		rcu_nocb_lock(rdp); // Rare during call_rcu() flood.
-		if (!rcu_segcblist_pend_cbs(&rdp->cblist)) {
+		if (!rcu_segcblist_pend_cbs_nolazy(&rdp->cblist)) {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    TPS("FirstBQwake"));
 			__call_rcu_nocb_wake(rdp, false, flags);
@@ -559,10 +534,8 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_pending,
 				 unsigned long flags)
 				 __releases(rdp->nocb_lock)
 {
-	long bypass_len;
 	unsigned long cur_gp_seq;
 	unsigned long j;
-	long lazy_len;
 	long len;
 	struct task_struct *t;
 
@@ -576,12 +549,11 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_pending,
 	}
 	// Need to actually to a wakeup.
 	len = rcu_segcblist_n_cbs(&rdp->cblist);
-	bypass_len = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-	lazy_len = READ_ONCE(rdp->lazy_len);
 	if (!was_pending) {
 		rdp->qlen_last_fqs_check = len;
-		// Only lazy CBs in bypass list
-		if (lazy_len && bypass_len == lazy_len) {
+		// Only lazy CBs in queue
+		if (rcu_segcblist_n_cbs_lazy(&rdp->cblist) &&
+		    !rcu_cblist_n_cbs(&rdp->nocb_bypass)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			wake_nocb_gp_defer(rdp, RCU_NOCB_WAKE_LAZY,
 					   TPS("WakeLazy"));
@@ -601,7 +573,7 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_pending,
 		rdp->qlen_last_fqs_check = len;
 		j = jiffies;
 		if (j != rdp->nocb_gp_adv_time &&
-		    rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		    rcu_segcblist_nextgp_nolazy(&rdp->cblist, &cur_gp_seq) &&
 		    rcu_seq_done(&rdp->mynode->gp_seq, cur_gp_seq)) {
 			rcu_advance_cbs_nowake(rdp->mynode, rdp);
 			rdp->nocb_gp_adv_time = j;
@@ -712,42 +684,35 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 */
 	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
 		long bypass_ncbs;
-		bool flush_bypass = false;
 		long lazy_ncbs;
 
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
 		lockdep_assert_held(&rdp->nocb_lock);
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-		lazy_ncbs = READ_ONCE(rdp->lazy_len);
+		lazy_ncbs = rcu_segcblist_n_cbs_lazy(&rdp->cblist);
 
-		if (bypass_ncbs && (lazy_ncbs == bypass_ncbs) &&
-		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + jiffies_lazy_flush) ||
-		     bypass_ncbs > 2 * qhimark_lazy)) {
-			flush_bypass = true;
-		} else if (bypass_ncbs && (lazy_ncbs != bypass_ncbs) &&
+		if (lazy_ncbs &&
+		    (time_after(j, READ_ONCE(rdp->lazy_firstq) + jiffies_lazy_flush) ||
+		     lazy_ncbs > 2 * qhimark_lazy)) {
+			rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+		}
+
+		if (bypass_ncbs &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
 		     bypass_ncbs > 2 * qhimark)) {
-			flush_bypass = true;
-		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
-			continue; /* No callbacks here, try next. */
-		}
-
-		if (flush_bypass) {
 			// Bypass full or old, so flush it.
 			(void)rcu_nocb_try_flush_bypass(rdp, j);
 			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
-			lazy_ncbs = READ_ONCE(rdp->lazy_len);
+		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			continue; /* No callbacks here, try next. */
 		}
 
 		if (bypass_ncbs) {
 			trace_rcu_nocb_wake(rcu_state.name, rdp->cpu,
 					    bypass_ncbs == lazy_ncbs ? TPS("Lazy") : TPS("Bypass"));
-			if (bypass_ncbs == lazy_ncbs)
-				lazy = true;
-			else
-				bypass = true;
+			bypass = true;
 		}
 		rnp = rdp->mynode;
 
@@ -755,7 +720,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		needwake_gp = false;
 		if (!rcu_segcblist_restempty(&rdp->cblist,
 					     RCU_NEXT_READY_TAIL) ||
-		    (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq) &&
+		    (rcu_segcblist_nextgp_nolazy(&rdp->cblist, &cur_gp_seq) &&
 		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
@@ -767,7 +732,14 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		WARN_ON_ONCE(wasempty &&
 			     !rcu_segcblist_restempty(&rdp->cblist,
 						      RCU_NEXT_READY_TAIL));
-		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
+		/*
+		 * Lazy callbacks haven't expired and haven't been piggybacked within
+		 * the last acceleration.
+		 */
+		if (rcu_segcblist_n_cbs_lazy(&rdp->cblist))
+			lazy = true;
+
+		if (rcu_segcblist_nextgp_nolazy(&rdp->cblist, &cur_gp_seq)) {
 			if (!needwait_gp ||
 			    ULONG_CMP_LT(cur_gp_seq, wait_gp_seq))
 				wait_gp_seq = cur_gp_seq;
@@ -954,7 +926,7 @@ static void nocb_cb_wait(struct rcu_data *rdp)
 	local_bh_enable();
 	lockdep_assert_irqs_enabled();
 	rcu_nocb_lock_irqsave(rdp, flags);
-	if (rcu_segcblist_nextgp(cblist, &cur_gp_seq) &&
+	if (rcu_segcblist_nextgp_nolazy(cblist, &cur_gp_seq) &&
 	    rcu_seq_done(&rnp->gp_seq, cur_gp_seq) &&
 	    raw_spin_trylock_rcu_node(rnp)) { /* irqs already disabled. */
 		needwake_gp = rcu_advance_cbs(rdp->mynode, rdp);
@@ -1134,7 +1106,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 * return false, which means that future calls to rcu_nocb_try_bypass()
 	 * will refuse to put anything into the bypass.
 	 */
-	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
+	WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies));
 	/*
 	 * Start with invoking rcu_core() early. This way if the current thread
 	 * happens to preempt an ongoing call to rcu_core() in the middle,
@@ -1144,6 +1116,9 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 */
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
 	invoke_rcu_core();
+	/* Deoffloaded doesn't support lazyness yet */
+	rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+
 	wake_gp = rdp_offload_toggle(rdp, false, flags);
 
 	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
@@ -1329,7 +1304,7 @@ lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 	for_each_cpu(cpu, rcu_nocb_mask) {
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
-		count +=  READ_ONCE(rdp->lazy_len);
+		count += rcu_segcblist_n_cbs_lazy(&rdp->cblist);
 	}
 
 	mutex_unlock(&rcu_state.barrier_mutex);
@@ -1368,7 +1343,7 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		if (WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp)))
 			continue;
 
-		if (!READ_ONCE(rdp->lazy_len))
+		if (!rcu_segcblist_n_cbs_lazy(&rdp->cblist))
 			continue;
 
 		rcu_nocb_lock_irqsave(rdp, flags);
@@ -1377,12 +1352,12 @@ lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
 		 * lock we may still race with increments from the enqueuer but still
 		 * we know for sure if there is at least one lazy callback.
 		 */
-		_count = READ_ONCE(rdp->lazy_len);
+		_count = rcu_segcblist_n_cbs_lazy(&rdp->cblist);
 		if (!_count) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
 			continue;
 		}
-		WARN_ON_ONCE(!rcu_nocb_flush_bypass(rdp, NULL, jiffies, false));
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
 		rcu_nocb_unlock_irqrestore(rdp, flags);
 		wake_nocb_gp(rdp, false);
 		sc->nr_to_scan -= _count;
@@ -1474,7 +1449,6 @@ static void __init rcu_boot_init_nocb_percpu_data(struct rcu_data *rdp)
 	raw_spin_lock_init(&rdp->nocb_gp_lock);
 	timer_setup(&rdp->nocb_timer, do_nocb_deferred_wakeup_timer, 0);
 	rcu_cblist_init(&rdp->nocb_bypass);
-	WRITE_ONCE(rdp->lazy_len, 0);
 	mutex_init(&rdp->nocb_gp_kthread_mutex);
 }
 
@@ -1761,7 +1735,7 @@ static bool wake_nocb_gp(struct rcu_data *rdp, bool force)
 }
 
 static bool rcu_nocb_flush_bypass(struct rcu_data *rdp, struct rcu_head *rhp,
-				  unsigned long j, bool lazy)
+				  unsigned long j)
 {
 	return true;
 }
-- 
2.40.1

