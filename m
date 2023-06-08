Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52190728468
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 17:59:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236835AbjFHP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 11:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbjFHP6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 11:58:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6AA1BD6
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 08:58:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 16A8063188
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 15:58:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A97C433EF;
        Thu,  8 Jun 2023 15:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686239927;
        bh=irhFt8hXdNrn8MEpsIEQtWZRpMbwo45bMx05+TZBRkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mW7iD2POyS7C4511DMT1Rrfvc0vlnmMQq1+A8XpM3tc1zXPnk39XOCk648/ka+bws
         F1W+m113EZqA52oGAJArpqnYPJoV4P7L4rO6U1Mtu8tXjkv+WL6OIhKJW8VgSLcbuM
         M0AYHHwNbsv+kYbThELeJRdnHXl9N1nr4NYRBvQP4bM5EQbo7i3wt4QimXNPE02mUT
         Nhsi9dcmi2l9sJEhQNX/eSBJtQwurc7JLGXGK9o3dQbALsH31raO4pxzOfpe1rLfgq
         R4vFURedUrcV9ebC0B5oeRmFuwcgO9t3vIBVsRO9DWC46wqLkOJeQ4tDMDOxGx+RMl
         7rxhINoBSJMEw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Luca Abeni <luca.abeni@santannapisa.it>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joel Fernandes <joel@joelfernandes.org>,
        Vineeth Pillai <vineeth@bitbyteword.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [RFC PATCH V3 4/6] sched/deadline: Introduce deadline servers
Date:   Thu,  8 Jun 2023 17:58:16 +0200
Message-Id: <e08a76013ff2b6a83028e8fdf3b8a6a0aa677d58.1686239016.git.bristot@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686239016.git.bristot@kernel.org>
References: <cover.1686239016.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Low priority tasks (e.g., SCHED_OTHER) can suffer starvation if tasks
with higher priority (e.g., SCHED_FIFO) monopolize CPU(s).

RT Throttling has been introduced a while ago as a (mostly debug)
countermeasure one can utilize to reserve some CPU time for low priority
tasks (usually background type of work, e.g. workqueues, timers, etc.).
It however has its own problems (see documentation) and the undesired
effect of unconditionally throttling FIFO tasks even when no lower
priority activity needs to run (there are mechanisms to fix this issue
as well, but, again, with their own problems).

Introduce deadline servers to service low priority tasks needs under
starvation conditions. Deadline servers are built extending SCHED_DEADLINE
implementation to allow 2-level scheduling (a sched_deadline entity
becomes a container for lower priority scheduling entities).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/sched.h   |  22 ++-
 kernel/sched/core.c     |  17 ++
 kernel/sched/deadline.c | 350 +++++++++++++++++++++++++++-------------
 kernel/sched/fair.c     |   4 +
 kernel/sched/sched.h    |  29 ++++
 5 files changed, 309 insertions(+), 113 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 26b1925a702a..4c90d7693a75 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -64,12 +64,14 @@ struct robust_list_head;
 struct root_domain;
 struct rq;
 struct sched_attr;
+struct sched_dl_entity;
 struct sched_param;
 struct seq_file;
 struct sighand_struct;
 struct signal_struct;
 struct task_delay_info;
 struct task_group;
+struct task_struct;
 struct user_event_mm;
 
 /*
@@ -600,6 +602,9 @@ struct sched_rt_entity {
 #endif
 } __randomize_layout;
 
+typedef bool (*dl_server_has_tasks_f)(struct sched_dl_entity *);
+typedef struct task_struct *(*dl_server_pick_f)(struct sched_dl_entity *);
+
 struct sched_dl_entity {
 	struct rb_node			rb_node;
 
@@ -647,6 +652,7 @@ struct sched_dl_entity {
 	unsigned int			dl_yielded        : 1;
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
+	unsigned int			dl_server         : 1;
 
 	/*
 	 * Bandwidth enforcement timer. Each -deadline task has its
@@ -661,7 +667,20 @@ struct sched_dl_entity {
 	 * timer is needed to decrease the active utilization at the correct
 	 * time.
 	 */
-	struct hrtimer inactive_timer;
+	struct hrtimer			inactive_timer;
+
+	/*
+	 * Bits for DL-server functionality. Also see the comment near
+	 * dl_server_update().
+	 *
+	 * @rq the runqueue this server is for
+	 *
+	 * @server_has_tasks() returns true if @server_pick return a
+	 * runnable task.
+	 */
+	struct rq			*rq;
+	dl_server_has_tasks_f		server_has_tasks;
+	dl_server_pick_f		server_pick;
 
 #ifdef CONFIG_RT_MUTEXES
 	/*
@@ -790,6 +809,7 @@ struct task_struct {
 	struct sched_entity		se;
 	struct sched_rt_entity		rt;
 	struct sched_dl_entity		dl;
+	struct sched_dl_entity		*server;
 	const struct sched_class	*sched_class;
 
 #ifdef CONFIG_SCHED_CORE
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e34b02cbe41f..5b88b822ec89 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3803,6 +3803,8 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
 		rq->idle_stamp = 0;
 	}
 #endif
+
+	p->server = NULL;
 }
 
 /*
@@ -6013,12 +6015,27 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			p = pick_next_task_idle(rq);
 		}
 
+		/*
+		 * This is the fast path; it cannot be a DL server pick;
+		 * therefore even if @p == @prev, ->server must be NULL.
+		 */
+		if (p->server)
+			p->server = NULL;
+
 		return p;
 	}
 
 restart:
 	put_prev_task_balance(rq, prev, rf);
 
+	/*
+	 * We've updated @prev and no longer need the server link, clear it.
+	 * Must be done before ->pick_next_task() because that can (re)set
+	 * ->server.
+	 */
+	if (prev->server)
+		prev->server = NULL;
+
 	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 869734eecb2c..c67056ff5749 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -52,8 +52,14 @@ static int __init sched_dl_sysctl_init(void)
 late_initcall(sched_dl_sysctl_init);
 #endif
 
+static bool dl_server(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_server;
+}
+
 static inline struct task_struct *dl_task_of(struct sched_dl_entity *dl_se)
 {
+	BUG_ON(dl_server(dl_se));
 	return container_of(dl_se, struct task_struct, dl);
 }
 
@@ -62,14 +68,22 @@ static inline struct rq *rq_of_dl_rq(struct dl_rq *dl_rq)
 	return container_of(dl_rq, struct rq, dl);
 }
 
-static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+static inline struct rq *rq_of_dl_se(struct sched_dl_entity *dl_se)
 {
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = task_rq(p);
+	struct rq *rq = dl_se->rq;
+
+	if (!dl_server(dl_se))
+		rq = task_rq(dl_task_of(dl_se));
 
-	return &rq->dl;
+	return rq;
 }
 
+static inline struct dl_rq *dl_rq_of_se(struct sched_dl_entity *dl_se)
+{
+	return &rq_of_dl_se(dl_se)->dl;
+}
+
+
 static inline int on_dl_rq(struct sched_dl_entity *dl_se)
 {
 	return !RB_EMPTY_NODE(&dl_se->rb_node);
@@ -392,9 +406,8 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se);
 static void task_non_contending(struct sched_dl_entity *dl_se)
 {
 	struct hrtimer *timer = &dl_se->inactive_timer;
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct rq *rq = rq_of_dl_se(dl_se);
+	struct dl_rq *dl_rq = &rq->dl;
 	s64 zerolag_time;
 
 	/*
@@ -424,25 +437,33 @@ static void task_non_contending(struct sched_dl_entity *dl_se)
 	 * utilization now, instead of starting a timer
 	 */
 	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
-		if (dl_task(p))
+		if (dl_server(dl_se)) {
 			sub_running_bw(dl_se, dl_rq);
+		} else {
+			struct task_struct *p = dl_task_of(dl_se);
+
+			if (dl_task(p))
+				sub_running_bw(dl_se, dl_rq);
 
-		if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
-			struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
+			if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
+				struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
-			if (READ_ONCE(p->__state) == TASK_DEAD)
-				sub_rq_bw(dl_se, &rq->dl);
-			raw_spin_lock(&dl_b->lock);
-			__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
-			raw_spin_unlock(&dl_b->lock);
-			__dl_clear_params(dl_se);
+				if (READ_ONCE(p->__state) == TASK_DEAD)
+					sub_rq_bw(dl_se, &rq->dl);
+				raw_spin_lock(&dl_b->lock);
+				__dl_sub(dl_b, dl_se->dl_bw, dl_bw_cpus(task_cpu(p)));
+				raw_spin_unlock(&dl_b->lock);
+				__dl_clear_params(dl_se);
+			}
 		}
 
 		return;
 	}
 
 	dl_se->dl_non_contending = 1;
-	get_task_struct(p);
+	if (!dl_server(dl_se))
+		get_task_struct(dl_task_of(dl_se));
+
 	hrtimer_start(timer, ns_to_ktime(zerolag_time), HRTIMER_MODE_REL_HARD);
 }
 
@@ -469,8 +490,10 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 		 * will not touch the rq's active utilization,
 		 * so we are still safe.
 		 */
-		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1)
-			put_task_struct(dl_task_of(dl_se));
+		if (hrtimer_try_to_cancel(&dl_se->inactive_timer) == 1) {
+			if (!dl_server(dl_se))
+				put_task_struct(dl_task_of(dl_se));
+		}
 	} else {
 		/*
 		 * Since "dl_non_contending" is not set, the
@@ -483,10 +506,8 @@ static void task_contending(struct sched_dl_entity *dl_se, int flags)
 	}
 }
 
-static inline int is_leftmost(struct task_struct *p, struct dl_rq *dl_rq)
+static inline int is_leftmost(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
-
 	return rb_first_cached(&dl_rq->root) == &dl_se->rb_node;
 }
 
@@ -573,8 +594,6 @@ static void inc_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 
 	if (p->nr_cpus_allowed > 1)
 		dl_rq->dl_nr_migratory++;
-
-	update_dl_migration(dl_rq);
 }
 
 static void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
@@ -583,8 +602,6 @@ static void dec_dl_migration(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 
 	if (p->nr_cpus_allowed > 1)
 		dl_rq->dl_nr_migratory--;
-
-	update_dl_migration(dl_rq);
 }
 
 #define __node_2_pdl(node) \
@@ -762,8 +779,10 @@ static inline void deadline_queue_pull_task(struct rq *rq)
 }
 #endif /* CONFIG_SMP */
 
+static void
+enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags);
 static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags);
-static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags);
+static void dequeue_dl_entity(struct sched_dl_entity *dl_se, int flags);
 static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p, int flags);
 
 static inline void replenish_dl_new_period(struct sched_dl_entity *dl_se,
@@ -1011,8 +1030,7 @@ static inline bool dl_is_implicit(struct sched_dl_entity *dl_se)
  */
 static void update_dl_entity(struct sched_dl_entity *dl_se)
 {
-	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq);
+	struct rq *rq = rq_of_dl_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) ||
 	    dl_entity_overflow(dl_se, rq_clock(rq))) {
@@ -1043,11 +1061,11 @@ static inline u64 dl_next_period(struct sched_dl_entity *dl_se)
  * actually started or not (i.e., the replenishment instant is in
  * the future or in the past).
  */
-static int start_dl_timer(struct task_struct *p)
+static int start_dl_timer(struct sched_dl_entity *dl_se)
 {
-	struct sched_dl_entity *dl_se = &p->dl;
 	struct hrtimer *timer = &dl_se->dl_timer;
-	struct rq *rq = task_rq(p);
+	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
+	struct rq *rq = rq_of_dl_rq(dl_rq);
 	ktime_t now, act;
 	s64 delta;
 
@@ -1081,13 +1099,33 @@ static int start_dl_timer(struct task_struct *p)
 	 * and observe our state.
 	 */
 	if (!hrtimer_is_queued(timer)) {
-		get_task_struct(p);
+		if (!dl_server(dl_se))
+			get_task_struct(dl_task_of(dl_se));
 		hrtimer_start(timer, act, HRTIMER_MODE_ABS_HARD);
 	}
 
 	return 1;
 }
 
+static void __push_dl_task(struct rq *rq, struct rq_flags *rf)
+{
+#ifdef CONFIG_SMP
+	/*
+	 * Queueing this task back might have overloaded rq, check if we need
+	 * to kick someone away.
+	 */
+	if (has_pushable_dl_tasks(rq)) {
+		/*
+		 * Nothing relies on rq->lock after this, so its safe to drop
+		 * rq->lock.
+		 */
+		rq_unpin_lock(rq, rf);
+		push_dl_task(rq);
+		rq_repin_lock(rq, rf);
+	}
+#endif
+}
+
 /*
  * This is the bandwidth enforcement timer callback. If here, we know
  * a task is not on its dl_rq, since the fact that the timer was running
@@ -1106,10 +1144,34 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	struct sched_dl_entity *dl_se = container_of(timer,
 						     struct sched_dl_entity,
 						     dl_timer);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct task_struct *p;
 	struct rq_flags rf;
 	struct rq *rq;
 
+	if (dl_server(dl_se)) {
+		struct rq *rq = rq_of_dl_se(dl_se);
+		struct rq_flags rf;
+
+		rq_lock(rq, &rf);
+		if (dl_se->dl_throttled) {
+			sched_clock_tick();
+			update_rq_clock(rq);
+
+			if (dl_se->server_has_tasks(dl_se)) {
+				enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
+				resched_curr(rq);
+				__push_dl_task(rq, &rf);
+			} else {
+				replenish_dl_entity(dl_se);
+			}
+
+		}
+		rq_unlock(rq, &rf);
+
+		return HRTIMER_NORESTART;
+	}
+
+	p = dl_task_of(dl_se);
 	rq = task_rq_lock(p, &rf);
 
 	/*
@@ -1180,21 +1242,7 @@ static enum hrtimer_restart dl_task_timer(struct hrtimer *timer)
 	else
 		resched_curr(rq);
 
-#ifdef CONFIG_SMP
-	/*
-	 * Queueing this task back might have overloaded rq, check if we need
-	 * to kick someone away.
-	 */
-	if (has_pushable_dl_tasks(rq)) {
-		/*
-		 * Nothing relies on rq->lock after this, so its safe to drop
-		 * rq->lock.
-		 */
-		rq_unpin_lock(rq, &rf);
-		push_dl_task(rq);
-		rq_repin_lock(rq, &rf);
-	}
-#endif
+	__push_dl_task(rq, &rf);
 
 unlock:
 	task_rq_unlock(rq, p, &rf);
@@ -1236,12 +1284,11 @@ static void init_dl_task_timer(struct sched_dl_entity *dl_se)
  */
 static inline void dl_check_constrained_dl(struct sched_dl_entity *dl_se)
 {
-	struct task_struct *p = dl_task_of(dl_se);
-	struct rq *rq = rq_of_dl_rq(dl_rq_of_se(dl_se));
+	struct rq *rq = rq_of_dl_se(dl_se);
 
 	if (dl_time_before(dl_se->deadline, rq_clock(rq)) &&
 	    dl_time_before(rq_clock(rq), dl_next_period(dl_se))) {
-		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(p)))
+		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se)))
 			return;
 		dl_se->dl_throttled = 1;
 		if (dl_se->runtime > 0)
@@ -1296,29 +1343,13 @@ static u64 grub_reclaim(u64 delta, struct rq *rq, struct sched_dl_entity *dl_se)
 	return (delta * u_act) >> BW_SHIFT;
 }
 
-/*
- * Update the current task's runtime statistics (provided it is still
- * a -deadline task and has not been removed from the dl_rq).
- */
-static void update_curr_dl(struct rq *rq)
+static inline void
+update_stats_dequeue_dl(struct dl_rq *dl_rq, struct sched_dl_entity *dl_se,
+                        int flags);
+static void update_curr_dl_se(struct rq *rq, struct sched_dl_entity *dl_se, s64 delta_exec)
 {
-	struct task_struct *curr = rq->curr;
-	struct sched_dl_entity *dl_se = &curr->dl;
-	s64 delta_exec, scaled_delta_exec;
-	int cpu = cpu_of(rq);
-
-	if (!dl_task(curr) || !on_dl_rq(dl_se))
-		return;
+	s64 scaled_delta_exec;
 
-	/*
-	 * Consumed budget is computed considering the time as
-	 * observed by schedulable tasks (excluding time spent
-	 * in hardirq context, etc.). Deadlines are instead
-	 * computed using hard walltime. This seems to be the more
-	 * natural solution, but the full ramifications of this
-	 * approach need further study.
-	 */
-	delta_exec = update_curr_common(rq);
 	if (unlikely(delta_exec <= 0)) {
 		if (unlikely(dl_se->dl_yielded))
 			goto throttle;
@@ -1336,10 +1367,9 @@ static void update_curr_dl(struct rq *rq)
 	 * according to current frequency and CPU maximum capacity.
 	 */
 	if (unlikely(dl_se->flags & SCHED_FLAG_RECLAIM)) {
-		scaled_delta_exec = grub_reclaim(delta_exec,
-						 rq,
-						 &curr->dl);
+		scaled_delta_exec = grub_reclaim(delta_exec, rq, dl_se);
 	} else {
+		int cpu = cpu_of(rq);
 		unsigned long scale_freq = arch_scale_freq_capacity(cpu);
 		unsigned long scale_cpu = arch_scale_cpu_capacity(cpu);
 
@@ -1358,11 +1388,21 @@ static void update_curr_dl(struct rq *rq)
 		    (dl_se->flags & SCHED_FLAG_DL_OVERRUN))
 			dl_se->dl_overrun = 1;
 
-		__dequeue_task_dl(rq, curr, 0);
-		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(curr)))
-			enqueue_task_dl(rq, curr, ENQUEUE_REPLENISH);
+		dequeue_dl_entity(dl_se, 0);
+		if (!dl_server(dl_se)) {
+			/* XXX: After v2, from __dequeue_task_dl() */
+			update_stats_dequeue_dl(&rq->dl, dl_se, 0);
+			dequeue_pushable_dl_task(rq, dl_task_of(dl_se));
+		}
+
+		if (unlikely(is_dl_boosted(dl_se) || !start_dl_timer(dl_se))) {
+			if (dl_server(dl_se))
+				enqueue_dl_entity(dl_se, ENQUEUE_REPLENISH);
+			else
+				enqueue_task_dl(rq, dl_task_of(dl_se), ENQUEUE_REPLENISH);
+		}
 
-		if (!is_leftmost(curr, &rq->dl))
+		if (!is_leftmost(dl_se, &rq->dl))
 			resched_curr(rq);
 	}
 
@@ -1392,20 +1432,82 @@ static void update_curr_dl(struct rq *rq)
 	}
 }
 
+void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec)
+{
+	update_curr_dl_se(dl_se->rq, dl_se, delta_exec);
+}
+
+void dl_server_start(struct sched_dl_entity *dl_se)
+{
+	if (!dl_server(dl_se)) {
+		dl_se->dl_server = 1;
+		setup_new_dl_entity(dl_se);
+	}
+	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
+}
+
+void dl_server_stop(struct sched_dl_entity *dl_se)
+{
+	dequeue_dl_entity(dl_se, DEQUEUE_SLEEP);
+}
+
+void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+		    dl_server_has_tasks_f has_tasks,
+		    dl_server_pick_f pick)
+{
+	dl_se->rq = rq;
+	dl_se->server_has_tasks = has_tasks;
+	dl_se->server_pick = pick;
+}
+
+/*
+ * Update the current task's runtime statistics (provided it is still
+ * a -deadline task and has not been removed from the dl_rq).
+ */
+static void update_curr_dl(struct rq *rq)
+{
+	struct task_struct *curr = rq->curr;
+	struct sched_dl_entity *dl_se = &curr->dl;
+	s64 delta_exec;
+
+	if (!dl_task(curr) || !on_dl_rq(dl_se))
+		return;
+
+	/*
+	 * Consumed budget is computed considering the time as
+	 * observed by schedulable tasks (excluding time spent
+	 * in hardirq context, etc.). Deadlines are instead
+	 * computed using hard walltime. This seems to be the more
+	 * natural solution, but the full ramifications of this
+	 * approach need further study.
+	 */
+	delta_exec = update_curr_common(rq);
+	update_curr_dl_se(rq, dl_se, delta_exec);
+}
+
 static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 {
 	struct sched_dl_entity *dl_se = container_of(timer,
 						     struct sched_dl_entity,
 						     inactive_timer);
-	struct task_struct *p = dl_task_of(dl_se);
+	struct task_struct *p = NULL;
 	struct rq_flags rf;
 	struct rq *rq;
 
-	rq = task_rq_lock(p, &rf);
+	if (!dl_server(dl_se)) {
+		p = dl_task_of(dl_se);
+		rq = task_rq_lock(p, &rf);
+	} else {
+		rq = dl_se->rq;
+		rq_lock(rq, &rf);
+	}
 
 	sched_clock_tick();
 	update_rq_clock(rq);
 
+	if (dl_server(dl_se))
+		goto no_task;
+
 	if (!dl_task(p) || READ_ONCE(p->__state) == TASK_DEAD) {
 		struct dl_bw *dl_b = dl_bw_of(task_cpu(p));
 
@@ -1422,14 +1524,21 @@ static enum hrtimer_restart inactive_task_timer(struct hrtimer *timer)
 
 		goto unlock;
 	}
+
+no_task:
 	if (dl_se->dl_non_contending == 0)
 		goto unlock;
 
 	sub_running_bw(dl_se, &rq->dl);
 	dl_se->dl_non_contending = 0;
 unlock:
-	task_rq_unlock(rq, p, &rf);
-	put_task_struct(p);
+
+	if (!dl_server(dl_se)) {
+		task_rq_unlock(rq, p, &rf);
+		put_task_struct(p);
+	} else {
+		rq_unlock(rq, &rf);
+	}
 
 	return HRTIMER_NORESTART;
 }
@@ -1487,34 +1596,35 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline)
 static inline void inc_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
 static inline void dec_dl_deadline(struct dl_rq *dl_rq, u64 deadline) {}
 
+static inline void update_dl_migration(struct dl_rq *dl_rq) {}
+
 #endif /* CONFIG_SMP */
 
 static inline
 void inc_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	int prio = dl_task_of(dl_se)->prio;
 	u64 deadline = dl_se->deadline;
 
-	WARN_ON(!dl_prio(prio));
 	dl_rq->dl_nr_running++;
 	add_nr_running(rq_of_dl_rq(dl_rq), 1);
 
 	inc_dl_deadline(dl_rq, deadline);
-	inc_dl_migration(dl_se, dl_rq);
+	if (!dl_server(dl_se))
+		inc_dl_migration(dl_se, dl_rq);
+	update_dl_migration(dl_rq);
 }
 
 static inline
 void dec_dl_tasks(struct sched_dl_entity *dl_se, struct dl_rq *dl_rq)
 {
-	int prio = dl_task_of(dl_se)->prio;
-
-	WARN_ON(!dl_prio(prio));
 	WARN_ON(!dl_rq->dl_nr_running);
 	dl_rq->dl_nr_running--;
 	sub_nr_running(rq_of_dl_rq(dl_rq), 1);
 
 	dec_dl_deadline(dl_rq, dl_se->deadline);
-	dec_dl_migration(dl_se, dl_rq);
+	if (!dl_server(dl_se))
+		dec_dl_migration(dl_se, dl_rq);
+	update_dl_migration(dl_rq);
 }
 
 static inline bool __dl_less(struct rb_node *a, const struct rb_node *b)
@@ -1676,8 +1786,7 @@ enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 	} else if (flags & ENQUEUE_REPLENISH) {
 		replenish_dl_entity(dl_se);
 	} else if ((flags & ENQUEUE_RESTORE) &&
-		  dl_time_before(dl_se->deadline,
-				 rq_clock(rq_of_dl_rq(dl_rq_of_se(dl_se))))) {
+		   dl_time_before(dl_se->deadline, rq_clock(rq_of_dl_se(dl_se)))) {
 		setup_new_dl_entity(dl_se);
 	}
 
@@ -1762,14 +1871,6 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 		enqueue_pushable_dl_task(rq, p);
 }
 
-static void __dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
-{
-	update_stats_dequeue_dl(&rq->dl, &p->dl, flags);
-	dequeue_dl_entity(&p->dl, flags);
-
-	if (!p->dl.dl_throttled)
-		dequeue_pushable_dl_task(rq, p);
-}
 
 static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 {
@@ -1778,7 +1879,9 @@ static void dequeue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	if (p->on_rq == TASK_ON_RQ_MIGRATING)
 		flags |= DEQUEUE_MIGRATING;
 
-	__dequeue_task_dl(rq, p, flags);
+	dequeue_dl_entity(&p->dl, flags);
+	if (!p->dl.dl_throttled)
+		dequeue_pushable_dl_task(rq, p);
 }
 
 /*
@@ -1968,12 +2071,12 @@ static void check_preempt_curr_dl(struct rq *rq, struct task_struct *p,
 }
 
 #ifdef CONFIG_SCHED_HRTICK
-static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
+static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
-	hrtick_start(rq, p->dl.runtime);
+	hrtick_start(rq, dl_se->runtime);
 }
 #else /* !CONFIG_SCHED_HRTICK */
-static void start_hrtick_dl(struct rq *rq, struct task_struct *p)
+static void start_hrtick_dl(struct rq *rq, struct sched_dl_entity *dl_se)
 {
 }
 #endif
@@ -1993,9 +2096,6 @@ static void set_next_task_dl(struct rq *rq, struct task_struct *p, bool first)
 	if (!first)
 		return;
 
-	if (hrtick_enabled_dl(rq))
-		start_hrtick_dl(rq, p);
-
 	if (rq->curr->sched_class != &dl_sched_class)
 		update_dl_rq_load_avg(rq_clock_pelt(rq), rq, 0);
 
@@ -2018,12 +2118,26 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 	struct dl_rq *dl_rq = &rq->dl;
 	struct task_struct *p;
 
+again:
 	if (!sched_dl_runnable(rq))
 		return NULL;
 
 	dl_se = pick_next_dl_entity(dl_rq);
 	WARN_ON_ONCE(!dl_se);
-	p = dl_task_of(dl_se);
+
+
+	if (dl_server(dl_se)) {
+		p = dl_se->server_pick(dl_se);
+		if (!p) {
+			// XXX should not happen, warn?!
+			dl_se->dl_yielded = 1;
+			update_curr_dl_se(rq, dl_se, 0);
+			goto again;
+		}
+		p->server = dl_se;
+	} else {
+		p = dl_task_of(dl_se);
+	}
 
 	return p;
 }
@@ -2033,9 +2147,20 @@ static struct task_struct *pick_next_task_dl(struct rq *rq)
 	struct task_struct *p;
 
 	p = pick_task_dl(rq);
-	if (p)
+	if (!p)
+		return p;
+
+	/*
+	 * XXX: re-check !dl_server, changed from v2 because of
+	 * pick_next_task_dl change
+	 */
+	if (!dl_server(&p->dl))
 		set_next_task_dl(rq, p, true);
 
+	/* XXX not quite right */
+	if (hrtick_enabled(rq))
+		start_hrtick_dl(rq, &p->dl);
+
 	return p;
 }
 
@@ -2073,8 +2198,8 @@ static void task_tick_dl(struct rq *rq, struct task_struct *p, int queued)
 	 * be set and schedule() will start a new hrtick for the next task.
 	 */
 	if (hrtick_enabled_dl(rq) && queued && p->dl.runtime > 0 &&
-	    is_leftmost(p, &rq->dl))
-		start_hrtick_dl(rq, p);
+	    is_leftmost(&p->dl, &rq->dl))
+		start_hrtick_dl(rq, &p->dl);
 }
 
 static void task_fork_dl(struct task_struct *p)
@@ -3003,6 +3128,7 @@ static void __dl_clear_params(struct sched_dl_entity *dl_se)
 	dl_se->dl_yielded		= 0;
 	dl_se->dl_non_contending	= 0;
 	dl_se->dl_overrun		= 0;
+	dl_se->dl_server		= 0;
 
 #ifdef CONFIG_RT_MUTEXES
 	dl_se->pi_se			= dl_se;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fda67f05190d..0c58d8e55b69 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -930,6 +930,8 @@ s64 update_curr_common(struct rq *rq)
 
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
+	if (curr->server)
+		dl_server_update(curr->server, delta_exec);
 
 	return delta_exec;
 }
@@ -958,6 +960,8 @@ static void update_curr(struct cfs_rq *cfs_rq)
 		trace_sched_stat_runtime(curtask, delta_exec, curr->vruntime);
 		cgroup_account_cputime(curtask, delta_exec);
 		account_group_exec_runtime(curtask, delta_exec);
+		if (curtask->server)
+			dl_server_update(curtask->server, delta_exec);
 	}
 
 	account_cfs_rq_runtime(cfs_rq, delta_exec);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index aaf163695c2e..390c99e2f8a8 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -324,6 +324,35 @@ extern bool dl_param_changed(struct task_struct *p, const struct sched_attr *att
 extern int  dl_cpuset_cpumask_can_shrink(const struct cpumask *cur, const struct cpumask *trial);
 extern int  dl_cpu_busy(int cpu, struct task_struct *p);
 
+/*
+ * SCHED_DEADLINE supports servers (nested scheduling) with the following
+ * interface:
+ *
+ *   dl_se::rq -- runqueue we belong to.
+ *
+ *   dl_se::server_has_tasks() -- used on bandwidth enforcement; we 'stop' the
+ *                                server when it runs out of tasks to run.
+ *
+ *   dl_se::server_pick() -- nested pick_next_task(); we yield the period if this
+ *                           returns NULL.
+ *
+ *   dl_server_update() -- called from update_curr_common(), propagates runtime
+ *                         to the server.
+ *
+ *   dl_server_start()
+ *   dl_server_stop()  -- start/stop the server when it has (no) tasks
+ *
+ *   dl_server_init()
+ *
+ * XXX
+ */
+extern void dl_server_update(struct sched_dl_entity *dl_se, s64 delta_exec);
+extern void dl_server_start(struct sched_dl_entity *dl_se);
+extern void dl_server_stop(struct sched_dl_entity *dl_se);
+extern void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
+		    dl_server_has_tasks_f has_tasks,
+		    dl_server_pick_f pick);
+
 #ifdef CONFIG_CGROUP_SCHED
 
 struct cfs_rq;
-- 
2.40.1

