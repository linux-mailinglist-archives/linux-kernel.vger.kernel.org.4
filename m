Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D34536CBD15
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 13:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjC1LHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 07:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232518AbjC1LHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 07:07:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3410B7AB4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 04:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/C/m782qsnmwI6cQ0Y2RQX/I95kOCPkI4DP+5cVPooA=; b=XEceOuziBevC8sFld6uhQbiVed
        FGk8byGMLqpfsRx8GVQT+wuCf2DB8xc6phdNavZaePUBaFnOQP8RCX9AF6w/emIAeJHW3KstdYyKS
        nc/wxgPvM6erZkGisI+/HssFRFW87Z5ZBQETU528BMIpoWgGBrHFcANZa/SPAHgn9J2XC4OgCkzLG
        jpphSR5fjOn9gch6p8l2ahp9eEMy/73SqFgQBE183H+hF27OyGBfI8xxx7qX/Z+eGwZq5KBzxxNBX
        Di6v4qFD6IUOkk7hGdOpbhbxPJTxsHVN88NY0h7AV2ejmc1xM0WN5cynvTcS/Tk/KIuaPmKTMfDee
        hkh4Ybdg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ph79m-008MDD-0U; Tue, 28 Mar 2023 11:06:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51364302E0F;
        Tue, 28 Mar 2023 13:06:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C767E2CB8CEC4; Tue, 28 Mar 2023 13:06:20 +0200 (CEST)
Message-ID: <20230328110354.141543852@infradead.org>
User-Agent: quilt/0.66
Date:   Tue, 28 Mar 2023 11:26:30 +0200
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
        joel@joelfernandes.org, efault@gmx.de
Subject: [PATCH 08/17] sched/fair: Implement an EEVDF like policy
References: <20230328092622.062917921@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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
 - relative deadline; which is related to slice length and mapped
   to the new latency nice.

Basically, by setting a smaller slice, the deadline will be earlier
and the task will be more eligible and ran earlier.

Preemption (both tick and wakeup) is driven by testing against a fresh
pick. Because the tree is now effectively an interval tree, and the
selection is no longer 'leftmost', over-scheduling is less of a
problem.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched.h   |    4 
 kernel/sched/debug.c    |    6 
 kernel/sched/fair.c     |  324 +++++++++++++++++++++++++++++++++++++++++-------
 kernel/sched/features.h |    3 
 kernel/sched/sched.h    |    1 
 5 files changed, 293 insertions(+), 45 deletions(-)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -548,6 +548,9 @@ struct sched_entity {
 	/* For load-balancing: */
 	struct load_weight		load;
 	struct rb_node			run_node;
+	u64				deadline;
+	u64				min_deadline;
+
 	struct list_head		group_node;
 	unsigned int			on_rq;
 
@@ -556,6 +559,7 @@ struct sched_entity {
 	u64				vruntime;
 	u64				prev_sum_exec_runtime;
 	s64				vlag;
+	u64				slice;
 
 	u64				nr_migrations;
 
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -535,9 +535,13 @@ print_task(struct seq_file *m, struct rq
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
 
@@ -691,11 +702,62 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 
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
@@ -714,8 +776,8 @@ static u64 __update_min_vruntime(struct
 
 static void update_min_vruntime(struct cfs_rq *cfs_rq)
 {
+	struct sched_entity *se = __pick_first_entity(cfs_rq);
 	struct sched_entity *curr = cfs_rq->curr;
-	struct rb_node *leftmost = rb_first_cached(&cfs_rq->tasks_timeline);
 
 	u64 vruntime = cfs_rq->min_vruntime;
 
@@ -726,9 +788,7 @@ static void update_min_vruntime(struct c
 			curr = NULL;
 	}
 
-	if (leftmost) { /* non-empty tree */
-		struct sched_entity *se = __node_2_se(leftmost);
-
+	if (se) {
 		if (!curr)
 			vruntime = se->vruntime;
 		else
@@ -745,18 +805,50 @@ static inline bool __entity_less(struct
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
 
@@ -780,6 +872,97 @@ static struct sched_entity *__pick_next_
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
@@ -822,17 +1005,6 @@ long calc_latency_offset(int prio)
 }
 
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
@@ -897,6 +1069,38 @@ static u64 sched_slice(struct cfs_rq *cf
 	return slice;
 }
 
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
+		 * latency-nice.
+		 */
+		se->slice = se->latency_offset;
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
 
@@ -1029,6 +1233,7 @@ static void update_curr(struct cfs_rq *c
 	schedstat_add(cfs_rq->exec_clock, delta_exec);
 
 	curr->vruntime += calc_delta_fair(delta_exec, curr);
+	update_deadline(cfs_rq, curr);
 	update_min_vruntime(cfs_rq);
 
 	if (entity_is_task(curr)) {
@@ -4796,6 +5001,7 @@ static inline bool entity_is_long_sleepe
 static void
 place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int initial)
 {
+	u64 vslice = calc_delta_fair(se->slice, se);
 	u64 vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
@@ -4834,9 +5040,9 @@ place_entity(struct cfs_rq *cfs_rq, stru
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
@@ -4877,6 +5083,19 @@ place_entity(struct cfs_rq *cfs_rq, stru
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
@@ -5088,19 +5307,20 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
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
+	if (sched_feat(EEVDF)) {
+		if (pick_eevdf(cfs_rq) != curr)
+			goto preempt;
+
+		return;
+	}
 
 	delta_exec = curr->sum_exec_runtime - curr->prev_sum_exec_runtime;
-	if (delta_exec > ideal_runtime) {
+	if (delta_exec > curr->slice) {
+preempt:
 		resched_curr(rq_of(cfs_rq));
 		/*
 		 * The current task ran long enough, ensure it doesn't get
@@ -5124,7 +5344,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq
 	if (delta < 0)
 		return;
 
-	if (delta > ideal_runtime)
+	if (delta > curr->slice)
 		resched_curr(rq_of(cfs_rq));
 }
 
@@ -5179,17 +5399,20 @@ wakeup_preempt_entity(struct sched_entit
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
@@ -6284,13 +6507,12 @@ static inline void unthrottle_offline_cf
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
@@ -8010,7 +8232,19 @@ static void check_preempt_wakeup(struct
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
@@ -8256,7 +8490,7 @@ static void yield_task_fair(struct rq *r
 
 	clear_buddies(cfs_rq, se);
 
-	if (curr->policy != SCHED_BATCH) {
+	if (sched_feat(EEVDF) || curr->policy != SCHED_BATCH) {
 		update_rq_clock(rq);
 		/*
 		 * Update run-time statistics of the 'current'.
@@ -8269,6 +8503,8 @@ static void yield_task_fair(struct rq *r
 		 */
 		rq_clock_skip_update(rq);
 	}
+	if (sched_feat(EEVDF))
+		se->deadline += calc_delta_fair(se->slice, se);
 
 	set_skip_buddy(se);
 }
@@ -12012,8 +12248,8 @@ static void rq_offline_fair(struct rq *r
 static inline bool
 __entity_slice_used(struct sched_entity *se, int min_nr_tasks)
 {
-	u64 slice = sched_slice(cfs_rq_of(se), se);
 	u64 rtime = se->sum_exec_runtime - se->prev_sum_exec_runtime;
+	u64 slice = se->slice;
 
 	return (rtime * min_nr_tasks > slice);
 }
@@ -12728,7 +12964,7 @@ static unsigned int get_rr_interval_fair
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
@@ -3316,5 +3316,6 @@ static inline void switch_mm_cid(struct
 #endif
 
 extern u64 avg_vruntime(struct cfs_rq *cfs_rq);
+extern int entity_eligible(struct cfs_rq *cfs_rq, struct sched_entity *se);
 
 #endif /* _KERNEL_SCHED_SCHED_H */


