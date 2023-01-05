Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3233565E184
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 01:26:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbjAEAXb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 19:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235496AbjAEAXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 19:23:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA84744372;
        Wed,  4 Jan 2023 16:23:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1AE0EB8167B;
        Thu,  5 Jan 2023 00:23:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B908CC433D2;
        Thu,  5 Jan 2023 00:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672878187;
        bh=RVZbEyTmCniCww65JvMwyLYk21JOsmMrHWf5ALY+E3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SCUL6KbQmIBZ8VvBA/pmHR6NC0WroSi1i+aHvUdwxTjFNUMIXXOLYQwmoLGKPgo5D
         mTx7e4rPGU1tHdND6mQdsBo+goFLWeKcSsVJNtZaYdOEnSxq2KMUBy7pdtVjCEvym7
         jigU4sRoYWHPTQSjkBqIsP9U7a6vqYs5H2m9r9cToVoC6VlsxqzJwIlcxP0/Uk8H0y
         vza1fCeaOt+SjlAZCJ+o5Iv2LvGgW7ch7Yr3V/RgXyJIGlvjW/SVep92kDaapMO5M9
         weVYXl8YDQcsLa/DSLK+/Dm1NdGYtYUSK5TWK9Y/v+tyGw66wDufDy93M9E3MtoCcX
         sSt0uFgT5+gGQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 755145C086D; Wed,  4 Jan 2023 16:23:07 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 02/10] rcu: Consolidate initialization and CPU-hotplug code
Date:   Wed,  4 Jan 2023 16:22:57 -0800
Message-Id: <20230105002305.1768591-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
References: <20230105002257.GA1768487@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit consolidates the initialization and CPU-hotplug code at
the end of kernel/rcu/tree.c.  This is strictly a code-motion commit.
No functionality has changed.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 314 +++++++++++++++++++++++-----------------------
 1 file changed, 158 insertions(+), 156 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index cf34a961821ad..d3b082233b74b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -144,14 +144,16 @@ static int rcu_scheduler_fully_active __read_mostly;
 
 static void rcu_report_qs_rnp(unsigned long mask, struct rcu_node *rnp,
 			      unsigned long gps, unsigned long flags);
-static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
-static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
 static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu);
 static void invoke_rcu_core(void);
 static void rcu_report_exp_rdp(struct rcu_data *rdp);
 static void sync_sched_exp_online_cleanup(int cpu);
 static void check_cb_ovld_locked(struct rcu_data *rdp, struct rcu_node *rnp);
 static bool rcu_rdp_is_offloaded(struct rcu_data *rdp);
+static bool rcu_rdp_cpu_online(struct rcu_data *rdp);
+static bool rcu_init_invoked(void);
+static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf);
+static void rcu_init_new_rnp(struct rcu_node *rnp_leaf);
 
 /*
  * rcuc/rcub/rcuop kthread realtime priority. The "rcuop"
@@ -214,27 +216,6 @@ EXPORT_SYMBOL_GPL(rcu_get_gp_kthreads_prio);
  */
 #define PER_RCU_NODE_PERIOD 3	/* Number of grace periods between delays for debugging. */
 
-/*
- * Compute the mask of online CPUs for the specified rcu_node structure.
- * This will not be stable unless the rcu_node structure's ->lock is
- * held, but the bit corresponding to the current CPU will be stable
- * in most contexts.
- */
-static unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
-{
-	return READ_ONCE(rnp->qsmaskinitnext);
-}
-
-/*
- * Is the CPU corresponding to the specified rcu_data structure online
- * from RCU's perspective?  This perspective is given by that structure's
- * ->qsmaskinitnext field rather than by the global cpu_online_mask.
- */
-static bool rcu_rdp_cpu_online(struct rcu_data *rdp)
-{
-	return !!(rdp->grpmask & rcu_rnp_online_cpus(rdp->mynode));
-}
-
 /*
  * Return true if an RCU grace period is in progress.  The READ_ONCE()s
  * permit this function to be invoked without holding the root rcu_node
@@ -734,46 +715,6 @@ void rcu_request_urgent_qs_task(struct task_struct *t)
 	smp_store_release(per_cpu_ptr(&rcu_data.rcu_urgent_qs, cpu), true);
 }
 
-#if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU)
-
-/*
- * Is the current CPU online as far as RCU is concerned?
- *
- * Disable preemption to avoid false positives that could otherwise
- * happen due to the current CPU number being sampled, this task being
- * preempted, its old CPU being taken offline, resuming on some other CPU,
- * then determining that its old CPU is now offline.
- *
- * Disable checking if in an NMI handler because we cannot safely
- * report errors from NMI handlers anyway.  In addition, it is OK to use
- * RCU on an offline processor during initial boot, hence the check for
- * rcu_scheduler_fully_active.
- */
-bool rcu_lockdep_current_cpu_online(void)
-{
-	struct rcu_data *rdp;
-	bool ret = false;
-
-	if (in_nmi() || !rcu_scheduler_fully_active)
-		return true;
-	preempt_disable_notrace();
-	rdp = this_cpu_ptr(&rcu_data);
-	/*
-	 * Strictly, we care here about the case where the current CPU is
-	 * in rcu_cpu_starting() and thus has an excuse for rdp->grpmask
-	 * not being up to date. So arch_spin_is_locked() might have a
-	 * false positive if it's held by some *other* CPU, but that's
-	 * OK because that just means a false *negative* on the warning.
-	 */
-	if (rcu_rdp_cpu_online(rdp) || arch_spin_is_locked(&rcu_state.ofl_lock))
-		ret = true;
-	preempt_enable_notrace();
-	return ret;
-}
-EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
-
-#endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
-
 /*
  * When trying to report a quiescent state on behalf of some other CPU,
  * it is our responsibility to check for and handle potential overflow
@@ -1350,13 +1291,6 @@ static void rcu_strict_gp_boundary(void *unused)
 	invoke_rcu_core();
 }
 
-// Has rcu_init() been invoked?  This is used (for example) to determine
-// whether spinlocks may be acquired safely.
-static bool rcu_init_invoked(void)
-{
-	return !!rcu_state.n_online_cpus;
-}
-
 // Make the polled API aware of the beginning of a grace period.
 static void rcu_poll_gp_seq_start(unsigned long *snap)
 {
@@ -2091,92 +2025,6 @@ rcu_check_quiescent_state(struct rcu_data *rdp)
 	rcu_report_qs_rdp(rdp);
 }
 
-/*
- * Near the end of the offline process.  Trace the fact that this CPU
- * is going offline.
- */
-int rcutree_dying_cpu(unsigned int cpu)
-{
-	bool blkd;
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;
-
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		return 0;
-
-	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
-	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
-			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
-	return 0;
-}
-
-/*
- * All CPUs for the specified rcu_node structure have gone offline,
- * and all tasks that were preempted within an RCU read-side critical
- * section while running on one of those CPUs have since exited their RCU
- * read-side critical section.  Some other CPU is reporting this fact with
- * the specified rcu_node structure's ->lock held and interrupts disabled.
- * This function therefore goes up the tree of rcu_node structures,
- * clearing the corresponding bits in the ->qsmaskinit fields.  Note that
- * the leaf rcu_node structure's ->qsmaskinit field has already been
- * updated.
- *
- * This function does check that the specified rcu_node structure has
- * all CPUs offline and no blocked tasks, so it is OK to invoke it
- * prematurely.  That said, invoking it after the fact will cost you
- * a needless lock acquisition.  So once it has done its work, don't
- * invoke it again.
- */
-static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
-{
-	long mask;
-	struct rcu_node *rnp = rnp_leaf;
-
-	raw_lockdep_assert_held_rcu_node(rnp_leaf);
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
-	    WARN_ON_ONCE(rnp_leaf->qsmaskinit) ||
-	    WARN_ON_ONCE(rcu_preempt_has_tasks(rnp_leaf)))
-		return;
-	for (;;) {
-		mask = rnp->grpmask;
-		rnp = rnp->parent;
-		if (!rnp)
-			break;
-		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
-		rnp->qsmaskinit &= ~mask;
-		/* Between grace periods, so better already be zero! */
-		WARN_ON_ONCE(rnp->qsmask);
-		if (rnp->qsmaskinit) {
-			raw_spin_unlock_rcu_node(rnp);
-			/* irqs remain disabled. */
-			return;
-		}
-		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
-	}
-}
-
-/*
- * The CPU has been completely removed, and some other CPU is reporting
- * this fact from process context.  Do the remainder of the cleanup.
- * There can only be one CPU hotplug operation at a time, so no need for
- * explicit locking.
- */
-int rcutree_dead_cpu(unsigned int cpu)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
-
-	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
-		return 0;
-
-	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
-	/* Adjust any no-longer-needed kthreads. */
-	rcu_boost_kthread_setaffinity(rnp, -1);
-	// Stop-machine done, so allow nohz_full to disable tick.
-	tick_dep_clear(TICK_DEP_BIT_RCU);
-	return 0;
-}
-
 /*
  * Invoke any RCU callbacks that have made it to the end of their grace
  * period.  Throttle as specified by rdp->blimit.
@@ -4079,6 +3927,160 @@ void rcu_barrier(void)
 }
 EXPORT_SYMBOL_GPL(rcu_barrier);
 
+/*
+ * Compute the mask of online CPUs for the specified rcu_node structure.
+ * This will not be stable unless the rcu_node structure's ->lock is
+ * held, but the bit corresponding to the current CPU will be stable
+ * in most contexts.
+ */
+static unsigned long rcu_rnp_online_cpus(struct rcu_node *rnp)
+{
+	return READ_ONCE(rnp->qsmaskinitnext);
+}
+
+/*
+ * Is the CPU corresponding to the specified rcu_data structure online
+ * from RCU's perspective?  This perspective is given by that structure's
+ * ->qsmaskinitnext field rather than by the global cpu_online_mask.
+ */
+static bool rcu_rdp_cpu_online(struct rcu_data *rdp)
+{
+	return !!(rdp->grpmask & rcu_rnp_online_cpus(rdp->mynode));
+}
+
+#if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU)
+
+/*
+ * Is the current CPU online as far as RCU is concerned?
+ *
+ * Disable preemption to avoid false positives that could otherwise
+ * happen due to the current CPU number being sampled, this task being
+ * preempted, its old CPU being taken offline, resuming on some other CPU,
+ * then determining that its old CPU is now offline.
+ *
+ * Disable checking if in an NMI handler because we cannot safely
+ * report errors from NMI handlers anyway.  In addition, it is OK to use
+ * RCU on an offline processor during initial boot, hence the check for
+ * rcu_scheduler_fully_active.
+ */
+bool rcu_lockdep_current_cpu_online(void)
+{
+	struct rcu_data *rdp;
+	bool ret = false;
+
+	if (in_nmi() || !rcu_scheduler_fully_active)
+		return true;
+	preempt_disable_notrace();
+	rdp = this_cpu_ptr(&rcu_data);
+	/*
+	 * Strictly, we care here about the case where the current CPU is
+	 * in rcu_cpu_starting() and thus has an excuse for rdp->grpmask
+	 * not being up to date. So arch_spin_is_locked() might have a
+	 * false positive if it's held by some *other* CPU, but that's
+	 * OK because that just means a false *negative* on the warning.
+	 */
+	if (rcu_rdp_cpu_online(rdp) || arch_spin_is_locked(&rcu_state.ofl_lock))
+		ret = true;
+	preempt_enable_notrace();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(rcu_lockdep_current_cpu_online);
+
+#endif /* #if defined(CONFIG_PROVE_RCU) && defined(CONFIG_HOTPLUG_CPU) */
+
+// Has rcu_init() been invoked?  This is used (for example) to determine
+// whether spinlocks may be acquired safely.
+static bool rcu_init_invoked(void)
+{
+	return !!rcu_state.n_online_cpus;
+}
+
+/*
+ * Near the end of the offline process.  Trace the fact that this CPU
+ * is going offline.
+ */
+int rcutree_dying_cpu(unsigned int cpu)
+{
+	bool blkd;
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_node *rnp = rdp->mynode;
+
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		return 0;
+
+	blkd = !!(READ_ONCE(rnp->qsmask) & rdp->grpmask);
+	trace_rcu_grace_period(rcu_state.name, READ_ONCE(rnp->gp_seq),
+			       blkd ? TPS("cpuofl-bgp") : TPS("cpuofl"));
+	return 0;
+}
+
+/*
+ * All CPUs for the specified rcu_node structure have gone offline,
+ * and all tasks that were preempted within an RCU read-side critical
+ * section while running on one of those CPUs have since exited their RCU
+ * read-side critical section.  Some other CPU is reporting this fact with
+ * the specified rcu_node structure's ->lock held and interrupts disabled.
+ * This function therefore goes up the tree of rcu_node structures,
+ * clearing the corresponding bits in the ->qsmaskinit fields.  Note that
+ * the leaf rcu_node structure's ->qsmaskinit field has already been
+ * updated.
+ *
+ * This function does check that the specified rcu_node structure has
+ * all CPUs offline and no blocked tasks, so it is OK to invoke it
+ * prematurely.  That said, invoking it after the fact will cost you
+ * a needless lock acquisition.  So once it has done its work, don't
+ * invoke it again.
+ */
+static void rcu_cleanup_dead_rnp(struct rcu_node *rnp_leaf)
+{
+	long mask;
+	struct rcu_node *rnp = rnp_leaf;
+
+	raw_lockdep_assert_held_rcu_node(rnp_leaf);
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU) ||
+	    WARN_ON_ONCE(rnp_leaf->qsmaskinit) ||
+	    WARN_ON_ONCE(rcu_preempt_has_tasks(rnp_leaf)))
+		return;
+	for (;;) {
+		mask = rnp->grpmask;
+		rnp = rnp->parent;
+		if (!rnp)
+			break;
+		raw_spin_lock_rcu_node(rnp); /* irqs already disabled. */
+		rnp->qsmaskinit &= ~mask;
+		/* Between grace periods, so better already be zero! */
+		WARN_ON_ONCE(rnp->qsmask);
+		if (rnp->qsmaskinit) {
+			raw_spin_unlock_rcu_node(rnp);
+			/* irqs remain disabled. */
+			return;
+		}
+		raw_spin_unlock_rcu_node(rnp); /* irqs remain disabled. */
+	}
+}
+
+/*
+ * The CPU has been completely removed, and some other CPU is reporting
+ * this fact from process context.  Do the remainder of the cleanup.
+ * There can only be one CPU hotplug operation at a time, so no need for
+ * explicit locking.
+ */
+int rcutree_dead_cpu(unsigned int cpu)
+{
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */
+
+	if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
+		return 0;
+
+	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
+	/* Adjust any no-longer-needed kthreads. */
+	rcu_boost_kthread_setaffinity(rnp, -1);
+	// Stop-machine done, so allow nohz_full to disable tick.
+	tick_dep_clear(TICK_DEP_BIT_RCU);
+	return 0;
+}
+
 /*
  * Propagate ->qsinitmask bits up the rcu_node tree to account for the
  * first CPU in a given leaf rcu_node structure coming online.  The caller
-- 
2.31.1.189.g2e36527f23

