Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7855B718050
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 14:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236128AbjEaMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 08:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235980AbjEaMtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 08:49:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 179D918C
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 05:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=UUZu/hqcsQvYgFHsQR4VxKw3ZZWY0neTSKhwBSImriw=; b=cR1EDCMQlRUGh8tM5bzyOutoJU
        6grMs8MRXAVH9rq05QKQ+xC+qyWy1MciOZNYXf1uSGeNBfF+8RgzKmztKdm2YvVG1jZ12nKrO8Zi+
        AeWpTzT2emRZ5Z+/16c8Ym7l9Gqh2MlCfxi8YOx1b1JODVHldRrDg9SCLFMuEQFS8Z1mnd3Lg7yd2
        dVOw7/MCdMTIA7JRoAs3szTHUIsZm+lW8TBkcy4/zsdbbR5CQmDLJnvhqK3Eb5fJcNtYPzFaf31yG
        slJzrIWvJf2EKUGJNG5NI5Pfux0/cvDVov0h6Yl4iv3sBspmWxRxB4yvk8nmx+FNGkUHoGBx+4f60
        FuluVvUA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q4LEp-007GRZ-Gh; Wed, 31 May 2023 12:47:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8382A30084B;
        Wed, 31 May 2023 14:47:37 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id ED33222BA6458; Wed, 31 May 2023 14:47:33 +0200 (CEST)
Message-ID: <20230531124603.931005524@infradead.org>
User-Agent: quilt/0.66
Date:   Wed, 31 May 2023 13:58:44 +0200
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
Subject: [PATCH 05/15] sched/fair: Implement an EEVDF like policy
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

Where CFS is currently a WFQ based scheduler with only a single knob,
the weight. The addition of a second, latency oriented parameter,
makes something like WF2Q or EEVDF based a much better fit.

Specifically, EEVDF does EDF like scheduling in the left half of the
tree -- those entities that are owed service. Except because this is a
virtual time scheduler, the deadlines are in virtual time as well,
which is what allows over-subscription.

EEVDF has two parameters:

 - weight, or time-slope; which is mapped to nice just as before
 - request size, or slice length; which is used to compute
   the virtual deadline as: vd_i = ve_i + r_i/w_i

Basically, by setting a smaller slice, the deadline will be earlier
and the task will be more eligible and ran earlier.

Tick driven preemption is driven by request/slice completion; while
wakeup preemption is driven by the deadline.

Because the tree is now effectively an interval tree, and the
selection is no longer 'leftmost', over-scheduling is less of a
problem.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    4 
 kernel/sched/core.c     |    1 
 kernel/sched/debug.c    |    6 
 kernel/sched/fair.c     |  338 +++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/features.h |    3 
 kernel/sched/sched.h    |    4 
 6 files changed, 308 insertions(+), 48 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -550,6 +550,9 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	u64				deadline;
+	u64				min_deadline;
+
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
@@ -558,6 +561,7 @@ struct sched_entity {
 	u64				prev_sum_exec_runtime;
 	u64				vruntime;
 	s64				vlag;
+	u64				slice;
 
 	u64				nr_migrations;
 
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4464,6 +4464,7 @@ static void __sched_fork(unsigned long c
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
+	p->se.slice			= sysctl_sched_min_granularity;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -581,9 +581,13 @@ print_task(struct seq_file *m, struct rq
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, " %15s %5d %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
+		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
+		SPLIT_NS(p->se.deadline),
+		SPLIT_NS(p->se.slice),
+		SPLIT_NS(p->se.sum_exec_runtime),
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -47,6 +47,7 @@
 #include <linux/psi.h>
 #include <linux/ratelimit.h>
 #include <linux/task_work.h>
+#include <linux/rbtree_augmented.h>
 
 #include <asm/switch_to.h>
 
@@ -347,6 +348,16 @@ static u64 __calc_delta(u64 delta_exec,
 	return mul_u64_u32_shr(delta_exec, fact, shift);
 }
 
+/*
+ * delta /= w
+ */
+static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
+{
+	if (unlikely(se->load.weight != NICE_0_LOAD))
+		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
+
+	return delta;
+}
 
 const struct sched_class fair_sched_class;
 
@@ -717,11 +728,62 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 
 /*
  * lag_i = S - s_i = w_i * (V - v_i)
+ *
+ * However, since V is approximated by the weighted average of all entities it
+ * is possible -- by addition/removal/reweight to the tree -- to move V around
+ * and end up with a larger lag than we started with.
+ *
+ * Limit this to either double the slice length with a minimum of TICK_NSEC
+ * since that is the timing granularity.
+ *
+ * EEVDF gives the following limit for a steady state system:
+ *
+ *   -r_max < lag < max(r_max, q)
+ *
+ * XXX could add max_slice to the augmented data to track this.
  */
 void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	s64 lag, limit;
+
 	SCHED_WARN_ON(!se->on_rq);
-	se->vlag = avg_vruntime(cfs_rq) - se->vruntime;
+	lag = avg_vruntime(cfs_rq) - se->vruntime;
+
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+	se->vlag = clamp(lag, -limit, limit);
+}
+
+/*
+ * Entity is eligible once it received less service than it ought to have,
+ * eg. lag >= 0.
+ *
+ * lag_i = S - s_i = w_i*(V - v_i)
+ *
+ * lag_i >= 0 -> V >= v_i
+ *
+ *     \Sum (v_i - v)*w_i
+ * V = ------------------ + v
+ *          \Sum w_i
+ *
+ * lag_i >= 0 -> \Sum (v_i - v)*w_i >= (v_i - v)*(\Sum w_i)
+ *
+ * Note: using 'avg_vruntime() > se->vruntime' is inacurate due
+ *       to the loss in precision caused by the division.
+ */
+int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	struct sched_entity *curr = cfs_rq->curr;
+	s64 avg = cfs_rq->avg_vruntime;
+	long load = cfs_rq->avg_load;
+
+	if (curr && curr->on_rq) {
+		unsigned long weight = scale_load_down(curr->load.weight);
+
+		avg += entity_key(cfs_rq, curr) * weight;
+		load += weight;
+	}
+
+	return avg >= entity_key(cfs_rq, se) * load;
 }
 
 static u64 __update_min_vruntime(struct cfs_rq *cfs_rq, u64 vruntime)
@@ -740,8 +802,8 @@ static u64 __update_min_vruntime(struct
 
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
+	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
-	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
 	u64 vruntime = cfs_rq->min_vruntime;
 
@@ -752,9 +814,7 @@ static void update_min_vruntime(struct c
 			curr = NULL;
 	}
 
-	if (leftmost) { /* non-empty tree */
-		struct sched_entity *se = __node_2_se(leftmost);
-
+	if (se) {
 		if (!curr)
 			vruntime = se->vruntime;
 		else
@@ -771,18 +831,50 @@ static inline bool __entity_less(struct
 	return entity_before(__node_2_se(a), __node_2_se(b));
 }
 
+#define deadline_gt(field, lse, rse) ({ (s64)((lse)->field - (rse)->field) > 0; })
+
+static inline void __update_min_deadline(struct sched_entity *se, struct rb_node *node)
+{
+	if (node) {
+		struct sched_entity *rse = __node_2_se(node);
+		if (deadline_gt(min_deadline, se, rse))
+			se->min_deadline = rse->min_deadline;
+	}
+}
+
+/*
+ * se->min_deadline = min(se->deadline, left->min_deadline, right->min_deadline)
+ */
+static inline bool min_deadline_update(struct sched_entity *se, bool exit)
+{
+	u64 old_min_deadline = se->min_deadline;
+	struct rb_node *node = &se->run_node;
+
+	se->min_deadline = se->deadline;
+	__update_min_deadline(se, node->rb_right);
+	__update_min_deadline(se, node->rb_left);
+
+	return se->min_deadline == old_min_deadline;
+}
+
+RB_DECLARE_CALLBACKS(static, min_deadline_cb, struct sched_entity,
+		     run_node, min_deadline, min_deadline_update);
+
 /*
  * Enqueue an entity into the rb-tree:
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	avg_vruntime_add(cfs_rq, se);
-	rb_add_cached(&se->run_node, &cfs_rq->tasks_timeline, __entity_less);
+	se->min_deadline = se->deadline;
+	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
+				__entity_less, &min_deadline_cb);
 }
 
 static void __dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	rb_erase_cached(&se->run_node, &cfs_rq->tasks_timeline);
+	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
+				  &min_deadline_cb);
 	avg_vruntime_sub(cfs_rq, se);
 }
 
@@ -806,6 +898,97 @@ static struct sched_entity *__pick_next_
 	return __node_2_se(next);
 }
 
+static struct sched_entity *pick_cfs(struct cfs_rq *cfs_rq, struct sched_entity *curr)
+{
+	struct sched_entity *left = __pick_first_entity(cfs_rq);
+
+	/*
+	 * If curr is set we have to see if its left of the leftmost entity
+	 * still in the tree, provided there was anything in the tree at all.
+	 */
+	if (!left || (curr && entity_before(curr, left)))
+		left = curr;
+
+	return left;
+}
+
+/*
+ * Earliest Eligible Virtual Deadline First
+ *
+ * In order to provide latency guarantees for different request sizes
+ * EEVDF selects the best runnable task from two criteria:
+ *
+ *  1) the task must be eligible (must be owed service)
+ *
+ *  2) from those tasks that meet 1), we select the one
+ *     with the earliest virtual deadline.
+ *
+ * We can do this in O(log n) time due to an augmented RB-tree. The
+ * tree keeps the entries sorted on service, but also functions as a
+ * heap based on the deadline by keeping:
+ *
+ *  se->min_deadline = min(se->deadline, se->{left,right}->min_deadline)
+ *
+ * Which allows an EDF like search on (sub)trees.
+ */
+static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
+{
+	struct rb_node *node = cfs_rq->tasks_timeline.rb_root.rb_node;
+	struct sched_entity *curr = cfs_rq->curr;
+	struct sched_entity *best = NULL;
+
+	if (curr && (!curr->on_rq || !entity_eligible(cfs_rq, curr)))
+		curr = NULL;
+
+	while (node) {
+		struct sched_entity *se = __node_2_se(node);
+
+		/*
+		 * If this entity is not eligible, try the left subtree.
+		 */
+		if (!entity_eligible(cfs_rq, se)) {
+			node = node->rb_left;
+			continue;
+		}
+
+		/*
+		 * If this entity has an earlier deadline than the previous
+		 * best, take this one. If it also has the earliest deadline
+		 * of its subtree, we're done.
+		 */
+		if (!best || deadline_gt(deadline, best, se)) {
+			best = se;
+			if (best->deadline == best->min_deadline)
+				break;
+		}
+
+		/*
+		 * If the earlest deadline in this subtree is in the fully
+		 * eligible left half of our space, go there.
+		 */
+		if (node->rb_left &&
+		    __node_2_se(node->rb_left)->min_deadline == se->min_deadline) {
+			node = node->rb_left;
+			continue;
+		}
+
+		node = node->rb_right;
+	}
+
+	if (!best || (curr && deadline_gt(deadline, best, curr)))
+		best = curr;
+
+	if (unlikely(!best)) {
+		struct sched_entity *left = __pick_first_entity(cfs_rq);
+		if (left) {
+			pr_err("EEVDF scheduling fail, picking leftmost\n");
+			return left;
+		}
+	}
+
+	return best;
+}
+
 #ifdef CONFIG_SCHED_DEBUG
 struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq)
 {
@@ -840,17 +1023,6 @@ int sched_update_scaling(void)
 #endif
 
 /*
- * delta /= w
- */
-static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
-{
-	if (unlikely(se->load.weight != NICE_0_LOAD))
-		delta = __calc_delta(delta, NICE_0_LOAD, &se->load);
-
-	return delta;
-}
-
-/*
  * The idea is to set a period in which each task runs once.
  *
  * When there are too many tasks (sched_nr_latency) we have to stretch
@@ -915,6 +1087,48 @@ static u64 sched_slice(struct cfs_rq *cf
 	return slice;
 }
 
+static void clear_buddies(struct cfs_rq *cfs_rq, struct sched_entity *se);
+
+/*
+ * XXX: strictly: vd_i += N*r_i/w_i such that: vd_i > ve_i
+ * this is probably good enough.
+ */
+static void update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if ((s64)(se->vruntime - se->deadline) < 0)
+		return;
+
+	if (sched_feat(EEVDF)) {
+		/*
+		 * For EEVDF the virtual time slope is determined by w_i (iow.
+		 * nice) while the request time r_i is determined by
+		 * sysctl_sched_min_granularity.
+		 */
+		se->slice = sysctl_sched_min_granularity;
+
+		/*
+		 * The task has consumed its request, reschedule.
+		 */
+		if (cfs_rq->nr_running > 1) {
+			resched_curr(rq_of(cfs_rq));
+			clear_buddies(cfs_rq, se);
+		}
+	} else {
+		/*
+		 * When many tasks blow up the sched_period; it is possible
+		 * that sched_slice() reports unusually large results (when
+		 * many tasks are very light for example). Therefore impose a
+		 * maximum.
+		 */
+		se->slice = min_t(u64, sched_slice(cfs_rq, se), sysctl_sched_latency);
+	}
+
+	/*
+	 * EEVDF: vd_i = ve_i + r_i / w_i
+	 */
+	se->deadline = se->vruntime + calc_delta_fair(se->slice, se);
+}
+
 #include "pelt.h"
 #ifdef CONFIG_SMP
 
@@ -1047,6 +1261,7 @@ static void update_curr(struct cfs_rq *c
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -3521,6 +3736,14 @@ static void reweight_entity(struct cfs_r
 		 * we need to scale se->vlag when w_i changes.
 		 */
 		se->vlag = div_s64(se->vlag * old_weight, weight);
+	} else {
+		s64 deadline = se->deadline - se->vruntime;
+		/*
+		 * When the weight changes, the virtual time slope changes and
+		 * we should adjust the relative virtual deadline accordingly.
+		 */
+		deadline = div_s64(deadline * old_weight, weight);
+		se->deadline = se->vruntime + deadline;
 	}
 
 #ifdef CONFIG_SMP
@@ -4871,6 +5094,7 @@ static inline bool entity_is_long_sleepe
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
+	u64 vslice = calc_delta_fair(se->slice, se);
 	u64 vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
@@ -4942,9 +5166,9 @@ place_entity(struct cfs_rq *cfs_rq, stru
 		 */
 		load = cfs_rq->avg_load;
 		if (curr && curr->on_rq)
-			load += curr->load.weight;
+			load += scale_load_down(curr->load.weight);
 
-		lag *= load + se->load.weight;
+		lag *= load + scale_load_down(se->load.weight);
 		if (WARN_ON_ONCE(!load))
 			load = 1;
 		lag = div_s64(lag, load);
@@ -4985,6 +5209,19 @@ place_entity(struct cfs_rq *cfs_rq, stru
 	}
 
 	se->vruntime = vruntime;
+
+	/*
+	 * When joining the competition; the exisiting tasks will be,
+	 * on average, halfway through their slice, as such start tasks
+	 * off with half a slice to ease into the competition.
+	 */
+	if (sched_feat(PLACE_DEADLINE_INITIAL) && initial)
+		vslice /= 2;
+
+	/*
+	 * EEVDF: vd_i = ve_i + r_i/w_i
+	 */
+	se->deadline = se->vruntime + vslice;
 }
 
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq);
@@ -5196,19 +5433,12 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
 static void
 check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	unsigned long ideal_runtime, delta_exec;
+	unsigned long delta_exec;
 	struct sched_entity *se;
 	s64 delta;
 
-	/*
-	 * When many tasks blow up the sched_period; it is possible that
-	 * sched_slice() reports unusually large results (when many tasks are
-	 * very light for example). Therefore impose a maximum.
-	 */
-	ideal_runtime = min_t(u64, sched_slice(cfs_rq, curr), sysctl_sched_latency);
-
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
-	if (delta_exec > ideal_runtime) {
+	if (delta_exec > curr->slice) {
 		resched_curr(rq_of(cfs_rq));
 		/*
 		 * The current task ran long enough, ensure it doesn't get
@@ -5232,7 +5462,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq
 	if (delta < 0)
 		return;
 
-	if (delta > ideal_runtime)
+	if (delta > curr->slice)
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -5287,17 +5517,20 @@ wakeup_preempt_entity(struct sched_entit
 static struct sched_entity *
 pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 {
-	struct sched_entity *left = __pick_first_entity(cfs_rq);
-	struct sched_entity *se;
+	struct sched_entity *left, *se;
 
-	/*
-	 * If curr is set we have to see if its left of the leftmost entity
-	 * still in the tree, provided there was anything in the tree at all.
-	 */
-	if (!left || (curr && entity_before(curr, left)))
-		left = curr;
+	if (sched_feat(EEVDF)) {
+		/*
+		 * Enabling NEXT_BUDDY will affect latency but not fairness.
+		 */
+		if (sched_feat(NEXT_BUDDY) &&
+		    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
+			return cfs_rq->next;
+
+		return pick_eevdf(cfs_rq);
+	}
 
-	se = left; /* ideally we run the leftmost entity */
+	se = left = pick_cfs(cfs_rq, curr);
 
 	/*
 	 * Avoid running the skip buddy, if running something else can
@@ -5390,7 +5623,7 @@ entity_tick(struct cfs_rq *cfs_rq, struc
 		return;
 #endif
 
-	if (cfs_rq->nr_running > 1)
+	if (!sched_feat(EEVDF) && cfs_rq->nr_running > 1)
 		check_preempt_tick(cfs_rq, curr);
 }
 
@@ -6396,13 +6629,12 @@ static inline void unthrottle_offline_cf
 static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 {
 	struct sched_entity *se = &p->se;
-	struct cfs_rq *cfs_rq = cfs_rq_of(se);
 
 	SCHED_WARN_ON(task_rq(p) != rq);
 
 	if (rq->cfs.h_nr_running > 1) {
-		u64 slice = sched_slice(cfs_rq, se);
 		u64 ran = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+		u64 slice = se->slice;
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
@@ -8122,7 +8354,19 @@ static void check_preempt_wakeup(struct
 	if (cse_is_idle != pse_is_idle)
 		return;
 
-	update_curr(cfs_rq_of(se));
+	cfs_rq = cfs_rq_of(se);
+	update_curr(cfs_rq);
+
+	if (sched_feat(EEVDF)) {
+		/*
+		 * XXX pick_eevdf(cfs_rq) != se ?
+		 */
+		if (pick_eevdf(cfs_rq) == pse)
+			goto preempt;
+
+		return;
+	}
+
 	if (wakeup_preempt_entity(se, pse) == 1) {
 		/*
 		 * Bias pick_next to pick the sched entity that is
@@ -8368,7 +8612,7 @@ static void yield_task_fair(struct rq *r
 
 	clear_buddies(cfs_rq, se);
 
-	if (curr->policy != SCHED_BATCH) {
+	if (sched_feat(EEVDF) || curr->policy != SCHED_BATCH) {
 		update_rq_clock(rq);
 		/*
 		 * Update run-time statistics of the 'current'.
@@ -8381,6 +8625,8 @@ static void yield_task_fair(struct rq *r
 		 */
 		rq_clock_skip_update(rq);
 	}
+	if (sched_feat(EEVDF))
+		se->deadline += calc_delta_fair(se->slice, se);
 
 	set_skip_buddy(se);
 }
@@ -12136,8 +12382,8 @@ static void rq_offline_fair(struct rq *r
 static inline bool
 __entity_slice_used(struct sched_entity *se, int min_nr_tasks)
 {
-	u64 slice = sched_slice(cfs_rq_of(se), se);
 	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+	u64 slice = se->slice;
 
 	return (rtime * min_nr_tasks > slice);
 }
@@ -12832,7 +13078,7 @@ static unsigned int get_rr_interval_fair
 	 * idle runqueue:
 	 */
 	if (rq->cfs.load.weight)
-		rr_interval = NS_TO_JIFFIES(sched_slice(cfs_rq_of(se), se));
+		rr_interval = NS_TO_JIFFIES(se->slice);
 
 	return rr_interval;
 }
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -13,6 +13,7 @@ SCHED_FEAT(GENTLE_FAIR_SLEEPERS, true)
  * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
  */
 SCHED_FEAT(PLACE_LAG, true)
+SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 
 /*
  * Prefer to schedule the task we woke last (assuming it failed
@@ -103,3 +104,5 @@ SCHED_FEAT(LATENCY_WARN, false)
 
 SCHED_FEAT(ALT_PERIOD, true)
 SCHED_FEAT(BASE_SLICE, true)
+
+SCHED_FEAT(EEVDF, true)
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2481,9 +2481,10 @@ extern void check_preempt_curr(struct rq
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
+extern unsigned int sysctl_sched_min_granularity;
+
 #ifdef CONFIG_SCHED_DEBUG
 extern unsigned int sysctl_sched_latency;
-extern unsigned int sysctl_sched_min_granularity;
 extern unsigned int sysctl_sched_idle_min_granularity;
 extern unsigned int sysctl_sched_wakeup_granularity;
 extern int sysctl_resched_latency_warn_ms;
@@ -3507,5 +3508,6 @@ static inline void init_sched_mm_cid(str
 #endif
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
+extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 #endif /* _KERNEL_SCHED_SCHED_H */


