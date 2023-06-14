Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD0F71804F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjEaMtq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236001AbjEaMtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:49:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DA5E4E
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=i3Jc3X0qqsWXpDgBU31PMBGvMF6Gom6a3AhiCBIdnXs=; b=gTT0AISEooSh2zxjPsV3tvvguP
        CXuZwgwr4hBfHGdkcb/t246rV9FiTj7hKB5mWfEsota1pM6nfM3yy5tWrv9ywUTUL8lt6/lZa8DJn
        YF82mlxAyuq/eYkJd7Ztp5jMTDnycB7LFRaOH4lwkq0HQPVddP2+TW3WGxQWAAdBTGThNc3p09HqW
        jkuUnl7ZvTG6ZuPvygU47iBoZdMEB5+Ow/y7SpXXSpij9rVbSLA0buY3V+CkDs+DgnZskkqS8yxhk
        ycyLl01CENUacoYS4L039TK+bab2D4zkcNB8TQpnEZDWUViX3yjla7bxF/51FSP8gEbUDAJCjMapF
        6n8pKL7A==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LEp-007GRa-Go; Wed, 31 May 2023 12:47:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 83900300CB5;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 0707922BA645B; Wed, 31 May 2023 14:47:34 +0200 (CEST)
Message-ID: <20230531124604.137187212@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:47 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: [PATCH 08/15] sched: Commit to EEVDF
References: <20230531115839.089944915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EEVDF is a better defined scheduling policy, as a result it has less
heuristics/tunables. There is no compelling reason to keep CFS around.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/debug.c    |    6 
 kernel/sched/fair.c     |  465 +++---------------------------------------------
 kernel/sched/features.h |   12 -
 kernel/sched/sched.h    |    5 
 4 files changed, 38 insertions(+), 450 deletions(-)

--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -347,10 +347,7 @@ static __init int sched_init_debug(void)
 	debugfs_create_file("preempt", 0644, debugfs_sched, NULL, &sched_dynamic_fops);
 #endif
 
-	debugfs_create_u32("latency_ns", 0644, debugfs_sched, &sysctl_sched_latency);
 	debugfs_create_u32("min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_min_granularity);
-	debugfs_create_u32("idle_min_granularity_ns", 0644, debugfs_sched, &sysctl_sched_idle_min_granularity);
-	debugfs_create_u32("wakeup_granularity_ns", 0644, debugfs_sched, &sysctl_sched_wakeup_granularity);
 
 	debugfs_create_u32("latency_warn_ms", 0644, debugfs_sched, &sysctl_resched_latency_warn_ms);
 	debugfs_create_u32("latency_warn_once", 0644, debugfs_sched, &sysctl_resched_latency_warn_once);
@@ -865,10 +862,7 @@ static void sched_debug_header(struct se
 	SEQ_printf(m, "  .%-40s: %Ld\n", #x, (long long)(x))
 #define PN(x) \
 	SEQ_printf(m, "  .%-40s: %Ld.%06ld\n", #x, SPLIT_NS(x))
-	PN(sysctl_sched_latency);
 	PN(sysctl_sched_min_granularity);
-	PN(sysctl_sched_idle_min_granularity);
-	PN(sysctl_sched_wakeup_granularity);
 	P(sysctl_sched_child_runs_first);
 	P(sysctl_sched_features);
 #undef PN
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -58,22 +58,6 @@
 #include "autogroup.h"
 
 /*
- * Targeted preemption latency for CPU-bound tasks:
- *
- * NOTE: this latency value is not the same as the concept of
- * 'timeslice length' - timeslices in CFS are of variable length
- * and have no persistent notion like in traditional, time-slice
- * based scheduling concepts.
- *
- * (to see the precise effective timeslice length of your workload,
- *  run vmstat and monitor the context-switches (cs) field)
- *
- * (default: 6ms * (1 + ilog(ncpus)), units: nanoseconds)
- */
-unsigned int sysctl_sched_latency			= 6000000ULL;
-static unsigned int normalized_sysctl_sched_latency	= 6000000ULL;
-
-/*
  * The initial- and re-scaling of tunables is configurable
  *
  * Options are:
@@ -95,36 +79,11 @@ unsigned int sysctl_sched_min_granularit
 static unsigned int normalized_sysctl_sched_min_granularity	= 750000ULL;
 
 /*
- * Minimal preemption granularity for CPU-bound SCHED_IDLE tasks.
- * Applies only when SCHED_IDLE tasks compete with normal tasks.
- *
- * (default: 0.75 msec)
- */
-unsigned int sysctl_sched_idle_min_granularity			= 750000ULL;
-
-/*
- * This value is kept at sysctl_sched_latency/sysctl_sched_min_granularity
- */
-static unsigned int sched_nr_latency = 8;
-
-/*
  * After fork, child runs first. If set to 0 (default) then
  * parent will (try to) run first.
  */
 unsigned int sysctl_sched_child_runs_first __read_mostly;
 
-/*
- * SCHED_OTHER wake-up granularity.
- *
- * This option delays the preemption effects of decoupled workloads
- * and reduces their over-scheduling. Synchronous workloads will still
- * have immediate wakeup/sleep latencies.
- *
- * (default: 1 msec * (1 + ilog(ncpus)), units: nanoseconds)
- */
-unsigned int sysctl_sched_wakeup_granularity			= 1000000UL;
-static unsigned int normalized_sysctl_sched_wakeup_granularity	= 1000000UL;
-
 const_debug unsigned int sysctl_sched_migration_cost	= 500000UL;
 
 int sched_thermal_decay_shift;
@@ -279,8 +238,6 @@ static void update_sysctl(void)
 #define SET_SYSCTL(name) \
 	(sysctl_##name = (factor) * normalized_sysctl_##name)
 	SET_SYSCTL(sched_min_granularity);
-	SET_SYSCTL(sched_latency);
-	SET_SYSCTL(sched_wakeup_granularity);
 #undef SET_SYSCTL
 }
 
@@ -888,30 +845,6 @@ struct sched_entity *__pick_first_entity
 	return __node_2_se(left);
 }
 
-static struct sched_entity *__pick_next_entity(struct sched_entity *se)
-{
-	struct rb_node *next = rb_next(&se->run_node);
-
-	if (!next)
-		return NULL;
-
-	return __node_2_se(next);
-}
-
-static struct sched_entity *pick_cfs(struct cfs_rq *cfs_rq, struct sched_entity *curr)
-{
-	struct sched_entity *left = __pick_first_entity(cfs_rq);
-
-	/*
-	 * If curr is set we have to see if its left of the leftmost entity
-	 * still in the tree, provided there was anything in the tree at all.
-	 */
-	if (!left || (curr && entity_before(curr, left)))
-		left = curr;
-
-	return left;
-}
-
 /*
  * Earliest Eligible Virtual Deadline First
  *
@@ -1008,85 +941,15 @@ int sched_update_scaling(void)
 {
 	unsigned int factor = get_update_sysctl_factor();
 
-	sched_nr_latency = DIV_ROUND_UP(sysctl_sched_latency,
-					sysctl_sched_min_granularity);
-
 #define WRT_SYSCTL(name) \
 	(normalized_sysctl_##name = sysctl_##name / (factor))
 	WRT_SYSCTL(sched_min_granularity);
-	WRT_SYSCTL(sched_latency);
-	WRT_SYSCTL(sched_wakeup_granularity);
 #undef WRT_SYSCTL
 
 	return 0;
 }
 #endif
 
-/*
- * The idea is to set a period in which each task runs once.
- *
- * When there are too many tasks (sched_nr_latency) we have to stretch
- * this period because otherwise the slices get too small.
- *
- * p = (nr <= nl) ? l : l*nr/nl
- */
-static u64 __sched_period(unsigned long nr_running)
-{
-	if (unlikely(nr_running > sched_nr_latency))
-		return nr_running * sysctl_sched_min_granularity;
-	else
-		return sysctl_sched_latency;
-}
-
-static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
-
-/*
- * We calculate the wall-time slice from the period by taking a part
- * proportional to the weight.
- *
- * s = p*P[w/rw]
- */
-static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-	unsigned int nr_running = cfs_rq->nr_running;
-	struct sched_entity *init_se = se;
-	unsigned int min_gran;
-	u64 slice;
-
-	if (sched_feat(ALT_PERIOD))
-		nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
-
-	slice = __sched_period(nr_running + !se->on_rq);
-
-	for_each_sched_entity(se) {
-		struct load_weight *load;
-		struct load_weight lw;
-		struct cfs_rq *qcfs_rq;
-
-		qcfs_rq = cfs_rq_of(se);
-		load = &qcfs_rq->load;
-
-		if (unlikely(!se->on_rq)) {
-			lw = qcfs_rq->load;
-
-			update_load_add(&lw, se->load.weight);
-			load = &lw;
-		}
-		slice = __calc_delta(slice, se->load.weight, load);
-	}
-
-	if (sched_feat(BASE_SLICE)) {
-		if (se_is_idle(init_se) && !sched_idle_cfs_rq(cfs_rq))
-			min_gran = sysctl_sched_idle_min_granularity;
-		else
-			min_gran = sysctl_sched_min_granularity;
-
-		slice = max_t(u64, slice, min_gran);
-	}
-
-	return slice;
-}
-
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 /*
@@ -1098,35 +961,25 @@ static void update_deadline(struct cfs_r
 	if ((s64)(se->vruntime - se->deadline) < 0)
 		return;
 
-	if (sched_feat(EEVDF)) {
-		/*
-		 * For EEVDF the virtual time slope is determined by w_i (iow.
-		 * nice) while the request time r_i is determined by
-		 * sysctl_sched_min_granularity.
-		 */
-		se->slice = sysctl_sched_min_granularity;
-
-		/*
-		 * The task has consumed its request, reschedule.
-		 */
-		if (cfs_rq->nr_running > 1) {
-			resched_curr(rq_of(cfs_rq));
-			clear_buddies(cfs_rq, se);
-		}
-	} else {
-		/*
-		 * When many tasks blow up the sched_period; it is possible
-		 * that sched_slice() reports unusually large results (when
-		 * many tasks are very light for example). Therefore impose a
-		 * maximum.
-		 */
-		se->slice = min_t(u64, sched_slice(cfs_rq, se), sysctl_sched_latency);
-	}
+	/*
+	 * For EEVDF the virtual time slope is determined by w_i (iow.
+	 * nice) while the request time r_i is determined by
+	 * sysctl_sched_min_granularity.
+	 */
+	se->slice = sysctl_sched_min_granularity;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
 	 */
 	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+
+	/*
+	 * The task has consumed its request, reschedule.
+	 */
+	if (cfs_rq->nr_running > 1) {
+		resched_curr(rq_of(cfs_rq));
+		clear_buddies(cfs_rq, se);
+	}
 }
 
 #include "pelt.h"
@@ -5055,19 +4908,6 @@ static inline void update_misfit_status(
 
 #endif /* CONFIG_SMP */
 
-static void check_spread(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
-#ifdef CONFIG_SCHED_DEBUG
-	s64 d = se->vruntime - cfs_rq->min_vruntime;
-
-	if (d < 0)
-		d = -d;
-
-	if (d > 3*sysctl_sched_latency)
-		schedstat_inc(cfs_rq->nr_spread_over);
-#endif
-}
-
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
@@ -5218,7 +5058,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 
 	check_schedstat_required();
 	update_stats_enqueue_fair(cfs_rq, se, flags);
-	check_spread(cfs_rq, se);
 	if (!curr)
 		__enqueue_entity(cfs_rq, se);
 	se->on_rq = 1;
@@ -5230,17 +5069,6 @@ enqueue_entity(struct cfs_rq *cfs_rq, st
 	}
 }
 
-static void __clear_buddies_last(struct sched_entity *se)
-{
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		if (cfs_rq->last != se)
-			break;
-
-		cfs_rq->last = NULL;
-	}
-}
-
 static void __clear_buddies_next(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
@@ -5252,27 +5080,10 @@ static void __clear_buddies_next(struct
 	}
 }
 
-static void __clear_buddies_skip(struct sched_entity *se)
-{
-	for_each_sched_entity(se) {
-		struct cfs_rq *cfs_rq = cfs_rq_of(se);
-		if (cfs_rq->skip != se)
-			break;
-
-		cfs_rq->skip = NULL;
-	}
-}
-
 static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	if (cfs_rq->last == se)
-		__clear_buddies_last(se);
-
 	if (cfs_rq->next == se)
 		__clear_buddies_next(se);
-
-	if (cfs_rq->skip == se)
-		__clear_buddies_skip(se);
 }
 
 static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -5330,45 +5141,6 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 		update_idle_cfs_rq_clock_pelt(cfs_rq);
 }
 
-/*
- * Preempt the current task with a newly woken task if needed:
- */
-static void
-check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
-{
-	unsigned long delta_exec;
-	struct sched_entity *se;
-	s64 delta;
-
-	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
-	if (delta_exec > curr->slice) {
-		resched_curr(rq_of(cfs_rq));
-		/*
-		 * The current task ran long enough, ensure it doesn't get
-		 * re-elected due to buddy favours.
-		 */
-		clear_buddies(cfs_rq, curr);
-		return;
-	}
-
-	/*
-	 * Ensure that a task that missed wakeup preemption by a
-	 * narrow margin doesn't have to wait for a full slice.
-	 * This also mitigates buddy induced latencies under load.
-	 */
-	if (delta_exec < sysctl_sched_min_granularity)
-		return;
-
-	se = __pick_first_entity(cfs_rq);
-	delta = curr->vruntime - se->vruntime;
-
-	if (delta < 0)
-		return;
-
-	if (delta > curr->slice)
-		resched_curr(rq_of(cfs_rq));
-}
-
 static void
 set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
@@ -5407,9 +5179,6 @@ set_next_entity(struct cfs_rq *cfs_rq, s
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
 
-static int
-wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se);
-
 /*
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
@@ -5420,53 +5189,14 @@ wakeup_preempt_entity(struct sched_entit
 static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	struct sched_entity *left, *se;
-
-	if (sched_feat(EEVDF)) {
-		/*
-		 * Enabling NEXT_BUDDY will affect latency but not fairness.
-		 */
-		if (sched_feat(NEXT_BUDDY) &&
-		    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
-			return cfs_rq->next;
-
-		return pick_eevdf(cfs_rq);
-	}
-
-	se = left = pick_cfs(cfs_rq, curr);
-
 	/*
-	 * Avoid running the skip buddy, if running something else can
-	 * be done without getting too unfair.
+	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
-	if (cfs_rq->skip && cfs_rq->skip == se) {
-		struct sched_entity *second;
+	if (sched_feat(NEXT_BUDDY) &&
+	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
+		return cfs_rq->next;
 
-		if (se == curr) {
-			second = __pick_first_entity(cfs_rq);
-		} else {
-			second = __pick_next_entity(se);
-			if (!second || (curr && entity_before(curr, second)))
-				second = curr;
-		}
-
-		if (second && wakeup_preempt_entity(second, left) < 1)
-			se = second;
-	}
-
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
-		/*
-		 * Someone really wants this to run. If it's not unfair, run it.
-		 */
-		se = cfs_rq->next;
-	} else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
-		/*
-		 * Prefer last buddy, try to return the CPU to a preempted task.
-		 */
-		se = cfs_rq->last;
-	}
-
-	return se;
+	return pick_eevdf(cfs_rq);
 }
 
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -5483,8 +5213,6 @@ static void put_prev_entity(struct cfs_r
 	/* throttle cfs_rqs exceeding runtime */
 	check_cfs_rq_runtime(cfs_rq);
 
-	check_spread(cfs_rq, prev);
-
 	if (prev->on_rq) {
 		update_stats_wait_start_fair(cfs_rq, prev);
 		/* Put 'current' back into the tree. */
@@ -5525,9 +5253,6 @@ entity_tick(struct cfs_rq *cfs_rq, struc
 			hrtimer_active(&rq_of(cfs_rq)->hrtick_timer))
 		return;
 #endif
-
-	if (!sched_feat(EEVDF) && cfs_rq->nr_running > 1)
-		check_preempt_tick(cfs_rq, curr);
 }
 
 
@@ -6561,8 +6286,7 @@ static void hrtick_update(struct rq *rq)
 	if (!hrtick_enabled_fair(rq) || curr->sched_class != &fair_sched_class)
 		return;
 
-	if (cfs_rq_of(&curr->se)->nr_running < sched_nr_latency)
-		hrtick_start_fair(rq, curr);
+	hrtick_start_fair(rq, curr);
 }
 #else /* !CONFIG_SCHED_HRTICK */
 static inline void
@@ -6603,17 +6327,6 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
 
-/*
- * Returns true if cfs_rq only has SCHED_IDLE entities enqueued. Note the use
- * of idle_nr_running, which does not consider idle descendants of normal
- * entities.
- */
-static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq)
-{
-	return cfs_rq->nr_running &&
-		cfs_rq->nr_running == cfs_rq->idle_nr_running;
-}
-
 #ifdef CONFIG_SMP
 static int sched_idle_cpu(int cpu)
 {
@@ -8099,66 +7812,6 @@ balance_fair(struct rq *rq, struct task_
 }
 #endif /* CONFIG_SMP */
 
-static unsigned long wakeup_gran(struct sched_entity *se)
-{
-	unsigned long gran = sysctl_sched_wakeup_granularity;
-
-	/*
-	 * Since its curr running now, convert the gran from real-time
-	 * to virtual-time in his units.
-	 *
-	 * By using 'se' instead of 'curr' we penalize light tasks, so
-	 * they get preempted easier. That is, if 'se' < 'curr' then
-	 * the resulting gran will be larger, therefore penalizing the
-	 * lighter, if otoh 'se' > 'curr' then the resulting gran will
-	 * be smaller, again penalizing the lighter task.
-	 *
-	 * This is especially important for buddies when the leftmost
-	 * task is higher priority than the buddy.
-	 */
-	return calc_delta_fair(gran, se);
-}
-
-/*
- * Should 'se' preempt 'curr'.
- *
- *             |s1
- *        |s2
- *   |s3
- *         g
- *      |<--->|c
- *
- *  w(c, s1) = -1
- *  w(c, s2) =  0
- *  w(c, s3) =  1
- *
- */
-static int
-wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
-{
-	s64 gran, vdiff = curr->vruntime - se->vruntime;
-
-	if (vdiff <= 0)
-		return -1;
-
-	gran = wakeup_gran(se);
-	if (vdiff > gran)
-		return 1;
-
-	return 0;
-}
-
-static void set_last_buddy(struct sched_entity *se)
-{
-	for_each_sched_entity(se) {
-		if (SCHED_WARN_ON(!se->on_rq))
-			return;
-		if (se_is_idle(se))
-			return;
-		cfs_rq_of(se)->last = se;
-	}
-}
-
 static void set_next_buddy(struct sched_entity *se)
 {
 	for_each_sched_entity(se) {
@@ -8170,12 +7823,6 @@ static void set_next_buddy(struct sched_
 	}
 }
 
-static void set_skip_buddy(struct sched_entity *se)
-{
-	for_each_sched_entity(se)
-		cfs_rq_of(se)->skip = se;
-}
-
 /*
  * Preempt the current task with a newly woken task if needed:
  */
@@ -8184,7 +7831,6 @@ static void check_preempt_wakeup(struct
 	struct task_struct *curr = rq->curr;
 	struct sched_entity *se = &curr->se, *pse = &p->se;
 	struct cfs_rq *cfs_rq = task_cfs_rq(curr);
-	int scale = cfs_rq->nr_running >= sched_nr_latency;
 	int next_buddy_marked = 0;
 	int cse_is_idle, pse_is_idle;
 
@@ -8200,7 +7846,7 @@ static void check_preempt_wakeup(struct
 	if (unlikely(throttled_hierarchy(cfs_rq_of(pse))))
 		return;
 
-	if (sched_feat(NEXT_BUDDY) && scale && !(wake_flags & WF_FORK)) {
+	if (sched_feat(NEXT_BUDDY) && !(wake_flags & WF_FORK)) {
 		set_next_buddy(pse);
 		next_buddy_marked = 1;
 	}
@@ -8248,44 +7894,16 @@ static void check_preempt_wakeup(struct
 	cfs_rq = cfs_rq_of(se);
 	update_curr(cfs_rq);
 
-	if (sched_feat(EEVDF)) {
-		/*
-		 * XXX pick_eevdf(cfs_rq) != se ?
-		 */
-		if (pick_eevdf(cfs_rq) == pse)
-			goto preempt;
-
-		return;
-	}
-
-	if (wakeup_preempt_entity(se, pse) == 1) {
-		/*
-		 * Bias pick_next to pick the sched entity that is
-		 * triggering this preemption.
-		 */
-		if (!next_buddy_marked)
-			set_next_buddy(pse);
+	/*
+	 * XXX pick_eevdf(cfs_rq) != se ?
+	 */
+	if (pick_eevdf(cfs_rq) == pse)
 		goto preempt;
-	}
 
 	return;
 
 preempt:
 	resched_curr(rq);
-	/*
-	 * Only set the backward buddy when the current task is still
-	 * on the rq. This can happen when a wakeup gets interleaved
-	 * with schedule on the ->pre_schedule() or idle_balance()
-	 * point, either of which can * drop the rq lock.
-	 *
-	 * Also, during early boot the idle thread is in the fair class,
-	 * for obvious reasons its a bad idea to schedule back to it.
-	 */
-	if (unlikely(!se->on_rq || curr == rq->idle))
-		return;
-
-	if (sched_feat(LAST_BUDDY) && scale && entity_is_task(se))
-		set_last_buddy(se);
 }
 
 #ifdef CONFIG_SMP
@@ -8486,8 +8104,6 @@ static void put_prev_task_fair(struct rq
 
 /*
  * sched_yield() is very simple
- *
- * The magic of dealing with the ->skip buddy is in pick_next_entity.
  */
 static void yield_task_fair(struct rq *rq)
 {
@@ -8503,23 +8119,19 @@ static void yield_task_fair(struct rq *r
 
 	clear_buddies(cfs_rq, se);
 
-	if (sched_feat(EEVDF) || curr->policy != SCHED_BATCH) {
-		update_rq_clock(rq);
-		/*
-		 * Update run-time statistics of the 'current'.
-		 */
-		update_curr(cfs_rq);
-		/*
-		 * Tell update_rq_clock() that we've just updated,
-		 * so we don't do microscopic update in schedule()
-		 * and double the fastpath cost.
-		 */
-		rq_clock_skip_update(rq);
-	}
-	if (sched_feat(EEVDF))
-		se->deadline += calc_delta_fair(se->slice, se);
+	update_rq_clock(rq);
+	/*
+	 * Update run-time statistics of the 'current'.
+	 */
+	update_curr(cfs_rq);
+	/*
+	 * Tell update_rq_clock() that we've just updated,
+	 * so we don't do microscopic update in schedule()
+	 * and double the fastpath cost.
+	 */
+	rq_clock_skip_update(rq);
 
-	set_skip_buddy(se);
+	se->deadline += calc_delta_fair(se->slice, se);
 }
 
 static bool yield_to_task_fair(struct rq *rq, struct task_struct *p)
@@ -8762,8 +8374,7 @@ static int task_hot(struct task_struct *
 	 * Buddy candidates are cache hot:
 	 */
 	if (sched_feat(CACHE_HOT_BUDDY) && env->dst_rq->nr_running &&
-			(&p->se == cfs_rq_of(&p->se)->next ||
-			 &p->se == cfs_rq_of(&p->se)->last))
+	    (&p->se == cfs_rq_of(&p->se)->next))
 		return 1;
 
 	if (sysctl_sched_migration_cost == -1)
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -15,13 +15,6 @@ SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 SCHED_FEAT(NEXT_BUDDY, false)
 
 /*
- * Prefer to schedule the task that ran last (when we did
- * wake-preempt) as that likely will touch the same data, increases
- * cache locality.
- */
-SCHED_FEAT(LAST_BUDDY, true)
-
-/*
  * Consider buddies to be cache hot, decreases the likeliness of a
  * cache buddy being migrated away, increases cache locality.
  */
@@ -93,8 +86,3 @@ SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
 
 SCHED_FEAT(LATENCY_WARN, false)
-
-SCHED_FEAT(ALT_PERIOD, true)
-SCHED_FEAT(BASE_SLICE, true)
-
-SCHED_FEAT(EEVDF, true)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -576,8 +576,6 @@ struct cfs_rq {
 	 */
 	struct sched_entity	*curr;
 	struct sched_entity	*next;
-	struct sched_entity	*last;
-	struct sched_entity	*skip;
 
 #ifdef	CONFIG_SCHED_DEBUG
 	unsigned int		nr_spread_over;
@@ -2484,9 +2482,6 @@ extern const_debug unsigned int sysctl_s
 extern unsigned int sysctl_sched_min_granularity;
 
 #ifdef CONFIG_SCHED_DEBUG
-extern unsigned int sysctl_sched_latency;
-extern unsigned int sysctl_sched_idle_min_granularity;
-extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
 extern int sysctl_resched_latency_warn_once;
 


