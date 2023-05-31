Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B22717D13
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234371AbjEaKTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235892AbjEaKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:18:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FFEE60;
        Wed, 31 May 2023 03:18:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 77C8E62F14;
        Wed, 31 May 2023 10:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2B01C4339E;
        Wed, 31 May 2023 10:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685528291;
        bh=UJ984DEuGUy+c9Gxy5RefY2CK3sksB4978t6B/2fQmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuWIKGN/RGQe1Q6HP6LLDw1InPXrKGDuH1xs/Tc7ed4n8wUT8q36JHaCQbS7ktbXn
         es99kCwnSbmEia1ntLac22hUD2P4WG7dK1/PyQ6nbhxKggM7OWxkrjXmmjbf5Al/cj
         9hzIXMNMsxtYUgNLPMNEIGQompdm2Q/vbHBGS8B1BCevTtV+dYq/BU31YhsSL/FGXK
         6bWOvZorwzc8h6NRyvgUqXFkT9iuN3NVWWXr/wDGPjdHmXz6jC95ViGmxhUjejZvwV
         Oi840c8TYaAMmt7nh8rpDpuX85cYDUumQfqYEvDNe5Y8IBMigjEGM6JKhPhiYCrHiC
         TJPjs3K19Ee/Q==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        rcu <rcu@vger.kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Giovanni Gherdovich <ggherdovich@suse.cz>
Subject: [PATCH 9/9] rcu: Support lazy callbacks with CONFIG_RCU_NOCB_CPU=n
Date:   Wed, 31 May 2023 12:17:36 +0200
Message-Id: <20230531101736.12981-10-frederic@kernel.org>
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

Support the lazy queue with CONFIG_RCU_NOCB_CPU=n or CONFIG_RCU_NOCB=y
with non-offloaded rdp. This reuses most of the lazy infrastructure.

The major difference is the addition of a dedicated per-CPU timer which
runs as long as the queue is lazy to make sure that lazy callbacks
eventually expire. It's worth noting that the timer is not cancelled
when the lazy queue is accelerated (reset) for performance reasons. It
may therefore run spuriously though the delay is long enough (10 secs)
for it to go mostly unnoticed. Nohz_full CPUs shouldn't suffer from
that since they rely on the NOCB implementation.

Some interesting numbers have been observed on a mostly idle system.
The test runs 100 times "sleep 10" on an 8 CPU machine and computes an
average of the idle time spent on all CPUs per C-state before and after
this patch. The following displays the improvement:

Before the patch:

	POLL:	0.000006
	C1:	0.001064
	C1E:	0.000777
	C3:	0.000457
	C6:	2.711224
	C7s:	47.484802
	Total:	50.198330

After the patch:

	POLL:	0.000011
	C1:	0.001088
	C1E:	0.000874
	C3:	0.000545
	C6:	3.234707
	C7s:	53.101949
	Total:	56.339175

Diff:

	POLL:	+0.000005 (+43.73%)
	C1:	+0.000024 (+2.25%)
	C1E:	+0.000097 (+11.11%)
	C3:	+0.000088 (+16.16%)
	C6:	+0.523482 (+16.18%)
	C7s:	+5.617148 (+10.58%)
	Total	+6.140844 (+10.90%)

It's worth noting that the above may depend on the idle load (here an
idle ssh connection is probably the source of some periodic lazy
callbacks queued that get batched, hence the improvement). And more
important further testing is mandatory to ensure that this doesn't
introduce a performance regression on busy loads.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/rcu/Kconfig         |   2 +-
 kernel/rcu/rcu_segcblist.h |   9 +++
 kernel/rcu/tree.c          | 153 +++++++++++++++++++++++++++++++++++--
 kernel/rcu/tree.h          |   1 +
 kernel/rcu/tree_nocb.h     | 110 +++-----------------------
 5 files changed, 167 insertions(+), 108 deletions(-)

diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index bdd7eadb33d8..b5e45c3a77e5 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -308,7 +308,7 @@ config TASKS_TRACE_RCU_READ_MB
 
 config RCU_LAZY
 	bool "RCU callback lazy invocation functionality"
-	depends on RCU_NOCB_CPU
+	depends on TREE_RCU
 	default n
 	help
 	  To save power, batch RCU callbacks and flush after delay, memory
diff --git a/kernel/rcu/rcu_segcblist.h b/kernel/rcu/rcu_segcblist.h
index 36245efdf800..0033da9a42fa 100644
--- a/kernel/rcu/rcu_segcblist.h
+++ b/kernel/rcu/rcu_segcblist.h
@@ -104,6 +104,15 @@ static inline bool rcu_segcblist_completely_offloaded(struct rcu_segcblist *rscl
 	return false;
 }
 
+static inline bool rcu_segcblist_nocb_transitioning(struct rcu_segcblist *rsclp)
+{
+	if (IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
+	    rcu_segcblist_test_flags(rsclp, SEGCBLIST_LOCKING | SEGCBLIST_RCU_CORE))
+		return true;
+
+	return false;
+}
+
 static inline bool rcu_segcblist_next_is_lazy(struct rcu_segcblist *rsclp)
 {
 	if (IS_ENABLED(CONFIG_RCU_LAZY) &&
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e48ccbe0f2f6..467a9cda7e71 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -669,8 +669,19 @@ NOKPROBE_SYMBOL(__rcu_irq_enter_check_tick);
  */
 int rcu_needs_cpu(void)
 {
-	return !rcu_segcblist_empty(&this_cpu_ptr(&rcu_data)->cblist) &&
-		!rcu_rdp_is_offloaded(this_cpu_ptr(&rcu_data));
+	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
+
+	if (rcu_segcblist_empty(&rdp->cblist))
+		return false;
+
+	if (rcu_rdp_is_offloaded(rdp))
+		return false;
+
+	if (IS_ENABLED(CONFIG_RCU_LAZY) &&
+	    rcu_segcblist_n_cbs_lazy(&rdp->cblist) == rcu_segcblist_n_cbs(&rdp->cblist))
+		return false;
+
+	return true;
 }
 
 /*
@@ -1086,7 +1097,7 @@ static bool rcu_accelerate_cbs(struct rcu_node *rnp, struct rcu_data *rdp)
 	gp_seq_req = rcu_seq_snap(&rcu_state.gp_seq);
 	if (rcu_segcblist_accelerate(&rdp->cblist, gp_seq_req)) {
 		/* The RCU_NEXT_TAIL has been flushed, reset the lazy bit accordingly */
-		if (IS_ENABLED(CONFIG_RCU_LAZY) && qhimark_lazy && rcu_segcblist_completely_offloaded(&rdp->cblist))
+		if (IS_ENABLED(CONFIG_RCU_LAZY) && qhimark_lazy && !rcu_segcblist_nocb_transitioning(&rdp->cblist))
 			rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
 		ret = rcu_start_this_gp(rnp, rdp, gp_seq_req);
 	}
@@ -1121,7 +1132,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 		/* Old request still live, so mark recent callbacks. */
 		if (rcu_segcblist_accelerate(&rdp->cblist, c)) {
 			/* The RCU_NEXT_TAIL has been flushed, reset the lazy bit accordingly */
-			if (IS_ENABLED(CONFIG_RCU_LAZY) && qhimark_lazy && rcu_segcblist_completely_offloaded(&rdp->cblist))
+			if (IS_ENABLED(CONFIG_RCU_LAZY) && qhimark_lazy && !rcu_segcblist_nocb_transitioning(&rdp->cblist))
 				rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
 		}
 		return;
@@ -2556,6 +2567,14 @@ static int __init rcu_spawn_core_kthreads(void)
 static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 			    unsigned long flags)
 {
+#ifdef CONFIG_RCU_LAZY
+	if (rcu_segcblist_n_cbs_lazy(&rdp->cblist) == 1) {
+		if (!timer_pending(&rdp->lazy_timer)) {
+			rdp->lazy_timer.expires = jiffies + jiffies_lazy_flush;
+			add_timer_on(&rdp->lazy_timer, smp_processor_id());
+		}
+	}
+#endif
 	/*
 	 * If called from an extended quiescent state, invoke the RCU
 	 * core in order to force a re-evaluation of RCU's idleness.
@@ -2577,6 +2596,7 @@ static void __call_rcu_core(struct rcu_data *rdp, struct rcu_head *head,
 	if (unlikely(rcu_segcblist_n_cbs(&rdp->cblist) >
 		     rdp->qlen_last_fqs_check + qhimark)) {
 
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
 		/* Are we ignoring a completed grace period? */
 		note_gp_changes(rdp);
 
@@ -2644,6 +2664,110 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
+#ifdef CONFIG_RCU_LAZY
+static unsigned long
+lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long count = 0;
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+		count += rcu_segcblist_n_cbs_lazy(&rdp->cblist);
+	}
+
+	return count ? count : SHRINK_EMPTY;
+}
+
+static unsigned long
+lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
+{
+	int cpu;
+	unsigned long flags;
+	unsigned long count = 0;
+
+	/*  Protect against concurrent (de-)offloading. */
+	if (!mutex_trylock(&rcu_state.barrier_mutex)) {
+		/*
+		 * But really don't insist if barrier_mutex is contended since we
+		 * can't guarantee that it will never engage in a dependency
+		 * chain involving memory allocation. The lock is seldom contended
+		 * anyway.
+		 */
+		return 0;
+	}
+
+	/* Snapshot count of all CPUs */
+	for_each_possible_cpu(cpu) {
+		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+		int _count;
+
+		if (!rcu_segcblist_n_cbs_lazy(&rdp->cblist))
+			continue;
+
+		rcu_nocb_lock_irqsave(rdp, flags);
+		_count = rcu_segcblist_n_cbs_lazy(&rdp->cblist);
+		if (!_count) {
+			rcu_nocb_unlock_irqrestore(rdp, flags);
+			continue;
+		}
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+		rcu_nocb_unlock_irqrestore(rdp, flags);
+
+		if (rcu_rdp_is_offloaded(rdp))
+			wake_nocb_gp(rdp, false);
+		sc->nr_to_scan -= _count;
+		count += _count;
+		if (sc->nr_to_scan <= 0)
+			break;
+	}
+
+	mutex_unlock(&rcu_state.barrier_mutex);
+
+	return count ? count : SHRINK_STOP;
+}
+
+static struct shrinker lazy_rcu_shrinker = {
+	.count_objects = lazy_rcu_shrink_count,
+	.scan_objects = lazy_rcu_shrink_scan,
+	.batch = 0,
+	.seeks = DEFAULT_SEEKS,
+};
+
+/* Lazy timer expiration callback for non-offloaded rdp */
+static void rcu_lazy_timer(struct timer_list *timer)
+{
+	unsigned long flags;
+	struct rcu_data *rdp = container_of(timer, struct rcu_data, lazy_timer);
+	unsigned long delta;
+	unsigned long jiff;
+
+	WARN_ON_ONCE(rdp->cpu != smp_processor_id());
+	/*
+	 * Protect against concurrent (de-)offloading on -RT where softirqs
+	 * are preemptible.
+	 */
+	local_irq_save(flags);
+	if (rcu_rdp_is_offloaded(rdp))
+		goto out;
+
+	if (!rcu_segcblist_n_cbs_lazy(&rdp->cblist))
+		goto out;
+
+	jiff = READ_ONCE(jiffies);
+	delta = jiff - rdp->lazy_firstq;
+
+	if (delta >= LAZY_FLUSH_JIFFIES)
+		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+	else
+		mod_timer(timer, jiff + (LAZY_FLUSH_JIFFIES - delta));
+out:
+	local_irq_restore(flags);
+}
+#endif
+
 /*
  * Handle lazy callbacks. Return true if no further handling is needed (unlocks nocb then).
  * Return false if further treatment is needed (wake rcuog kthread, set the nocb timer, etc...).
@@ -2667,7 +2791,11 @@ static bool __call_rcu_lazy(struct rcu_data *rdp, bool was_pending, bool lazy, u
 	/* First lazy callback on an empty queue, set the timer if necessary */
 	if (lazy_len == 1) {
 		WRITE_ONCE(rdp->lazy_firstq, jiffies);
-		if (!was_pending)
+		/*
+		 * nocb_gp_wait() will set the timer for us if it is already tracking
+		 * pending callbacks.
+		 */
+		if (!rcu_rdp_is_offloaded(rdp) || !was_pending)
 			return false;
 		else
 			goto out;
@@ -3958,7 +4086,8 @@ static int rcu_pending(int user)
 	/* Has RCU gone idle with this CPU needing another grace period? */
 	if (!gp_in_progress && rcu_segcblist_is_enabled(&rdp->cblist) &&
 	    !rcu_rdp_is_offloaded(rdp) &&
-	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
+	    !rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL) &&
+	    !rcu_segcblist_next_is_lazy(&rdp->cblist))
 		return 1;
 
 	/* Have RCU grace period completed or started?  */
@@ -4363,6 +4492,9 @@ rcu_boot_init_percpu_data(int cpu)
 	rdp->rcu_onl_gp_flags = RCU_GP_CLEANED;
 	rdp->last_sched_clock = jiffies;
 	rdp->cpu = cpu;
+#ifdef CONFIG_RCU_LAZY
+	timer_setup(&rdp->lazy_timer, rcu_lazy_timer, TIMER_PINNED);
+#endif
 	rcu_boot_init_nocb_percpu_data(rdp);
 }
 
@@ -4588,6 +4720,9 @@ void rcu_report_dead(unsigned int cpu)
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	arch_spin_unlock(&rcu_state.ofl_lock);
+#ifdef CONFIG_RCU_LAZY
+	del_timer(&rdp->lazy_timer);
+#endif
 	rdp->cpu_started = false;
 }
 
@@ -5098,6 +5233,12 @@ void __init rcu_init(void)
 	(void)start_poll_synchronize_rcu_expedited();
 
 	rcu_test_sync_prims();
+
+#ifdef CONFIG_RCU_LAZY
+	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
+		pr_err("Failed to register lazy_rcu shrinker!\n");
+#endif // #ifdef CONFIG_RCU_LAZY
+
 }
 
 #include "tree_stall.h"
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 90b39ff8ad70..e21698260fac 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -282,6 +282,7 @@ struct rcu_data {
 	struct rcu_snap_record snap_record; /* Snapshot of core stats at half of */
 					    /* the first RCU stall timeout */
 	unsigned long lazy_firstq;
+	struct timer_list lazy_timer;
 	int cpu;
 };
 
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index fbd54a2e1f17..327a480d606c 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -1055,6 +1055,9 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	struct rcu_data *rdp_gp = rdp->nocb_gp_rdp;
 	bool wake_gp = false;
 
+	/* Unlazy pending callbacks (don't bother arming the right lazy timer) */
+	rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
+
 	rcu_segcblist_offload(cblist, offload);
 
 	if (rdp->nocb_cb_sleep)
@@ -1116,9 +1119,6 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	 */
 	rcu_segcblist_set_flags(cblist, SEGCBLIST_RCU_CORE);
 	invoke_rcu_core();
-	/* Deoffloaded doesn't support lazyness yet */
-	rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
-
 	wake_gp = rdp_offload_toggle(rdp, false, flags);
 
 	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
@@ -1259,6 +1259,12 @@ static long rcu_nocb_rdp_offload(void *arg)
 	rcu_segcblist_clear_flags(cblist, SEGCBLIST_RCU_CORE);
 	rcu_nocb_unlock_irqrestore(rdp, flags);
 
+	/*
+	 * The lazy timer is protected against concurrent (de-)offloading.
+	 * Still, no need to keep it around.
+	 */
+	del_timer(&rdp->lazy_timer);
+
 	return 0;
 }
 
@@ -1286,99 +1292,6 @@ int rcu_nocb_cpu_offload(int cpu)
 }
 EXPORT_SYMBOL_GPL(rcu_nocb_cpu_offload);
 
-#ifdef CONFIG_RCU_LAZY
-static unsigned long
-lazy_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
-{
-	int cpu;
-	unsigned long count = 0;
-
-	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
-		return 0;
-
-	/*  Protect rcu_nocb_mask against concurrent (de-)offloading. */
-	if (!mutex_trylock(&rcu_state.barrier_mutex))
-		return 0;
-
-	/* Snapshot count of all CPUs */
-	for_each_cpu(cpu, rcu_nocb_mask) {
-		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-
-		count += rcu_segcblist_n_cbs_lazy(&rdp->cblist);
-	}
-
-	mutex_unlock(&rcu_state.barrier_mutex);
-
-	return count ? count : SHRINK_EMPTY;
-}
-
-static unsigned long
-lazy_rcu_shrink_scan(struct shrinker *shrink, struct shrink_control *sc)
-{
-	int cpu;
-	unsigned long flags;
-	unsigned long count = 0;
-
-	if (WARN_ON_ONCE(!cpumask_available(rcu_nocb_mask)))
-		return 0;
-	/*
-	 * Protect against concurrent (de-)offloading. Otherwise nocb locking
-	 * may be ignored or imbalanced.
-	 */
-	if (!mutex_trylock(&rcu_state.barrier_mutex)) {
-		/*
-		 * But really don't insist if barrier_mutex is contended since we
-		 * can't guarantee that it will never engage in a dependency
-		 * chain involving memory allocation. The lock is seldom contended
-		 * anyway.
-		 */
-		return 0;
-	}
-
-	/* Snapshot count of all CPUs */
-	for_each_cpu(cpu, rcu_nocb_mask) {
-		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-		int _count;
-
-		if (WARN_ON_ONCE(!rcu_rdp_is_offloaded(rdp)))
-			continue;
-
-		if (!rcu_segcblist_n_cbs_lazy(&rdp->cblist))
-			continue;
-
-		rcu_nocb_lock_irqsave(rdp, flags);
-		/*
-		 * Recheck under the nocb lock. Since we are not holding the bypass
-		 * lock we may still race with increments from the enqueuer but still
-		 * we know for sure if there is at least one lazy callback.
-		 */
-		_count = rcu_segcblist_n_cbs_lazy(&rdp->cblist);
-		if (!_count) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
-			continue;
-		}
-		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_NEXT_TAIL_LAZY);
-		rcu_nocb_unlock_irqrestore(rdp, flags);
-		wake_nocb_gp(rdp, false);
-		sc->nr_to_scan -= _count;
-		count += _count;
-		if (sc->nr_to_scan <= 0)
-			break;
-	}
-
-	mutex_unlock(&rcu_state.barrier_mutex);
-
-	return count ? count : SHRINK_STOP;
-}
-
-static struct shrinker lazy_rcu_shrinker = {
-	.count_objects = lazy_rcu_shrink_count,
-	.scan_objects = lazy_rcu_shrink_scan,
-	.batch = 0,
-	.seeks = DEFAULT_SEEKS,
-};
-#endif // #ifdef CONFIG_RCU_LAZY
-
 void __init rcu_init_nohz(void)
 {
 	int cpu;
@@ -1409,11 +1322,6 @@ void __init rcu_init_nohz(void)
 	if (!rcu_state.nocb_is_setup)
 		return;
 
-#ifdef CONFIG_RCU_LAZY
-	if (register_shrinker(&lazy_rcu_shrinker, "rcu-lazy"))
-		pr_err("Failed to register lazy_rcu shrinker!\n");
-#endif // #ifdef CONFIG_RCU_LAZY
-
 	if (!cpumask_subset(rcu_nocb_mask, cpu_possible_mask)) {
 		pr_info("\tNote: kernel parameter 'rcu_nocbs=', 'nohz_full', or 'isolcpus=' contains nonexistent CPUs.\n");
 		cpumask_and(rcu_nocb_mask, cpu_possible_mask,
-- 
2.40.1

