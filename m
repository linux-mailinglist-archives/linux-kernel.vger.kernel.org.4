Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6D712955
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 17:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244143AbjEZPXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 11:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244066AbjEZPX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 11:23:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3584E4B;
        Fri, 26 May 2023 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=/epu39V2eVwn0eeUwS2oeiAC/1i5SyzpFwGW0qH4Svg=; b=RmdQ4FeqtdlBw44e5gA3veMxZM
        UCHAhpXHZTMiOonvHd/Nr6nDe0WLtfAe7v+YyREroiobLMMcrFso/W0MpmT6QixRrqwyIYwBpJqyp
        WVBXQglJ+M9ZqJ4RsHcDpVLjOtaofTUq1zE288oWkb6fBRFo+S/GbLSdbm50WPOrzhDfpRtplU5iH
        xg668aJzRpFLSC0Ap7suP5Y1MtBMaPJVHls6oYNfDPeoymVRQ9CuV29SXoafYQtr9PgAFMvf1/pI5
        EddGBcc3+oTxaJUZv6FQlU7ask+5T32uwEi31pdYNjswAJNO2ekSUJTxHf54xqWmi0oZzR05Ruxag
        tFEXlSYQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1q2ZHD-002uj9-KX; Fri, 26 May 2023 15:22:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8BD65300794;
        Fri, 26 May 2023 17:22:44 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 3E03622163BC1; Fri, 26 May 2023 17:22:44 +0200 (CEST)
Message-ID: <20230526151947.027972233@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 26 May 2023 17:05:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     torvalds@linux-foundation.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, pbonzini@redhat.com
Cc:     linux-kernel@vger.kernel.org, ojeda@kernel.org,
        ndesaulniers@google.com, peterz@infradead.org, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, josh@joshtriplett.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        qiang1.zhang@intel.com, rcu@vger.kernel.org, tj@kernel.org,
        tglx@linutronix.de
Subject: [RFC][PATCH 2/2] sched: Use fancy new guards
References: <20230526150549.250372621@infradead.org>
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

Convert kernel/sched/core.c to use the fancy new guards to simplify
the error paths.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c  | 1223 +++++++++++++++++++++++----------------------------
 kernel/sched/sched.h |   39 +
 2 files changed, 595 insertions(+), 667 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1097,24 +1097,21 @@ int get_nohz_timer_target(void)
 
 	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
 
-	rcu_read_lock();
-	for_each_domain(cpu, sd) {
-		for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
-			if (cpu == i)
-				continue;
+	void_scope(rcu) {
+		for_each_domain(cpu, sd) {
+			for_each_cpu_and(i, sched_domain_span(sd), hk_mask) {
+				if (cpu == i)
+					continue;
 
-			if (!idle_cpu(i)) {
-				cpu = i;
-				goto unlock;
+				if (!idle_cpu(i))
+					return i;
 			}
 		}
-	}
 
-	if (default_cpu == -1)
-		default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
-	cpu = default_cpu;
-unlock:
-	rcu_read_unlock();
+		if (default_cpu == -1)
+			default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
+		cpu = default_cpu;
+	}
 	return cpu;
 }
 
@@ -1457,16 +1454,12 @@ static void __uclamp_update_util_min_rt_
 
 static void uclamp_update_util_min_rt_default(struct task_struct *p)
 {
-	struct rq_flags rf;
-	struct rq *rq;
-
 	if (!rt_task(p))
 		return;
 
 	/* Protect updates to p->uclamp_* */
-	rq = task_rq_lock(p, &rf);
-	__uclamp_update_util_min_rt_default(p);
-	task_rq_unlock(rq, p, &rf);
+	lock_scope(task_rq, p)
+		__uclamp_update_util_min_rt_default(p);
 }
 
 static inline struct uclamp_se
@@ -1762,9 +1755,8 @@ static void uclamp_update_root_tg(void)
 	uclamp_se_set(&tg->uclamp_req[UCLAMP_MAX],
 		      sysctl_sched_uclamp_util_max, false);
 
-	rcu_read_lock();
-	cpu_util_update_eff(&root_task_group.css);
-	rcu_read_unlock();
+	void_scope(rcu)
+		cpu_util_update_eff(&root_task_group.css);
 }
 #else
 static void uclamp_update_root_tg(void) { }
@@ -1791,10 +1783,10 @@ static void uclamp_sync_util_min_rt_defa
 	smp_mb__after_spinlock();
 	read_unlock(&tasklist_lock);
 
-	rcu_read_lock();
-	for_each_process_thread(g, p)
-		uclamp_update_util_min_rt_default(p);
-	rcu_read_unlock();
+	void_scope(rcu) {
+		for_each_process_thread(g, p)
+			uclamp_update_util_min_rt_default(p);
+	}
 }
 
 static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
@@ -1804,7 +1796,8 @@ static int sysctl_sched_uclamp_handler(s
 	int old_min, old_max, old_min_rt;
 	int result;
 
-	mutex_lock(&uclamp_mutex);
+	lock_guard(mutex, guard, &uclamp_mutex);
+
 	old_min = sysctl_sched_uclamp_util_min;
 	old_max = sysctl_sched_uclamp_util_max;
 	old_min_rt = sysctl_sched_uclamp_util_min_rt_default;
@@ -1813,7 +1806,7 @@ static int sysctl_sched_uclamp_handler(s
 	if (result)
 		goto undo;
 	if (!write)
-		goto done;
+		return result;
 
 	if (sysctl_sched_uclamp_util_min > sysctl_sched_uclamp_util_max ||
 	    sysctl_sched_uclamp_util_max > SCHED_CAPACITY_SCALE	||
@@ -1849,16 +1842,12 @@ static int sysctl_sched_uclamp_handler(s
 	 * Otherwise, keep it simple and do just a lazy update at each next
 	 * task enqueue time.
 	 */
-
-	goto done;
+	return result;
 
 undo:
 	sysctl_sched_uclamp_util_min = old_min;
 	sysctl_sched_uclamp_util_max = old_max;
 	sysctl_sched_uclamp_util_min_rt_default = old_min_rt;
-done:
-	mutex_unlock(&uclamp_mutex);
-
 	return result;
 }
 #endif
@@ -2249,10 +2238,10 @@ void migrate_disable(void)
 		return;
 	}
 
-	preempt_disable();
-	this_rq()->nr_pinned++;
-	p->migration_disabled = 1;
-	preempt_enable();
+	void_scope(preempt) {
+		this_rq()->nr_pinned++;
+		p->migration_disabled = 1;
+	}
 }
 EXPORT_SYMBOL_GPL(migrate_disable);
 
@@ -2276,18 +2265,18 @@ void migrate_enable(void)
 	 * Ensure stop_task runs either before or after this, and that
 	 * __set_cpus_allowed_ptr(SCA_MIGRATE_ENABLE) doesn't schedule().
 	 */
-	preempt_disable();
-	if (p->cpus_ptr != &p->cpus_mask)
-		__set_cpus_allowed_ptr(p, &ac);
-	/*
-	 * Mustn't clear migration_disabled() until cpus_ptr points back at the
-	 * regular cpus_mask, otherwise things that race (eg.
-	 * select_fallback_rq) get confused.
-	 */
-	barrier();
-	p->migration_disabled = 0;
-	this_rq()->nr_pinned--;
-	preempt_enable();
+	void_scope(preempt) {
+		if (p->cpus_ptr != &p->cpus_mask)
+			__set_cpus_allowed_ptr(p, &ac);
+		/*
+		 * Mustn't clear migration_disabled() until cpus_ptr points back at the
+		 * regular cpus_mask, otherwise things that race (eg.
+		 * select_fallback_rq) get confused.
+		 */
+		barrier();
+		p->migration_disabled = 0;
+		this_rq()->nr_pinned--;
+	}
 }
 EXPORT_SYMBOL_GPL(migrate_enable);
 
@@ -3272,31 +3261,28 @@ static int migrate_swap_stop(void *data)
 	src_rq = cpu_rq(arg->src_cpu);
 	dst_rq = cpu_rq(arg->dst_cpu);
 
-	double_raw_lock(&arg->src_task->pi_lock,
-			&arg->dst_task->pi_lock);
-	double_rq_lock(src_rq, dst_rq);
-
-	if (task_cpu(arg->dst_task) != arg->dst_cpu)
-		goto unlock;
+	double_lock_scope(raw,
+			  &arg->src_task->pi_lock,
+			  &arg->dst_task->pi_lock) {
+		double_lock_guard(rq, guard, src_rq, dst_rq);
 
-	if (task_cpu(arg->src_task) != arg->src_cpu)
-		goto unlock;
+		if (task_cpu(arg->dst_task) != arg->dst_cpu)
+			break;
 
-	if (!cpumask_test_cpu(arg->dst_cpu, arg->src_task->cpus_ptr))
-		goto unlock;
+		if (task_cpu(arg->src_task) != arg->src_cpu)
+			break;
 
-	if (!cpumask_test_cpu(arg->src_cpu, arg->dst_task->cpus_ptr))
-		goto unlock;
+		if (!cpumask_test_cpu(arg->dst_cpu, arg->src_task->cpus_ptr))
+			break;
 
-	__migrate_swap_task(arg->src_task, arg->dst_cpu);
-	__migrate_swap_task(arg->dst_task, arg->src_cpu);
+		if (!cpumask_test_cpu(arg->src_cpu, arg->dst_task->cpus_ptr))
+			break;
 
-	ret = 0;
+		__migrate_swap_task(arg->src_task, arg->dst_cpu);
+		__migrate_swap_task(arg->dst_task, arg->src_cpu);
 
-unlock:
-	double_rq_unlock(src_rq, dst_rq);
-	raw_spin_unlock(&arg->dst_task->pi_lock);
-	raw_spin_unlock(&arg->src_task->pi_lock);
+		ret = 0;
+	}
 
 	return ret;
 }
@@ -3464,13 +3450,12 @@ unsigned long wait_task_inactive(struct
  */
 void kick_process(struct task_struct *p)
 {
+	void_guard(preempt, guard);
 	int cpu;
 
-	preempt_disable();
 	cpu = task_cpu(p);
 	if ((cpu != smp_processor_id()) && task_curr(p))
 		smp_send_reschedule(cpu);
-	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kick_process);
 
@@ -3678,17 +3663,16 @@ ttwu_stat(struct task_struct *p, int cpu
 		__schedstat_inc(rq->ttwu_local);
 		__schedstat_inc(p->stats.nr_wakeups_local);
 	} else {
+		void_guard(rcu, guard);
 		struct sched_domain *sd;
 
 		__schedstat_inc(p->stats.nr_wakeups_remote);
-		rcu_read_lock();
 		for_each_domain(rq->cpu, sd) {
 			if (cpumask_test_cpu(cpu, sched_domain_span(sd))) {
 				__schedstat_inc(sd->ttwu_wake_remote);
 				break;
 			}
 		}
-		rcu_read_unlock();
 	}
 
 	if (wake_flags & WF_MIGRATED)
@@ -3887,21 +3871,13 @@ static void __ttwu_queue_wakelist(struct
 void wake_up_if_idle(int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
-	struct rq_flags rf;
-
-	rcu_read_lock();
 
-	if (!is_idle_task(rcu_dereference(rq->curr)))
-		goto out;
-
-	rq_lock_irqsave(rq, &rf);
-	if (is_idle_task(rq->curr))
-		resched_curr(rq);
-	/* Else CPU is not idle, do nothing here: */
-	rq_unlock_irqrestore(rq, &rf);
-
-out:
-	rcu_read_unlock();
+	void_guard(rcu, rg);
+	if (is_idle_task(rcu_dereference(rq->curr))) {
+		lock_guard(rq, rq_guard, rq);
+		if (is_idle_task(rq->curr))
+			resched_curr(rq);
+	}
 }
 
 bool cpus_share_cache(int this_cpu, int that_cpu)
@@ -4158,10 +4134,9 @@ bool ttwu_state_match(struct task_struct
 static int
 try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 {
-	unsigned long flags;
+	void_guard(preempt, guard);
 	int cpu, success = 0;
 
-	preempt_disable();
 	if (p == current) {
 		/*
 		 * We're waking current, this means 'p->on_rq' and 'task_cpu(p)
@@ -4188,129 +4163,127 @@ try_to_wake_up(struct task_struct *p, un
 	 * reordered with p->state check below. This pairs with smp_store_mb()
 	 * in set_current_state() that the waiting thread does.
 	 */
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	smp_mb__after_spinlock();
-	if (!ttwu_state_match(p, state, &success))
-		goto unlock;
+	lock_scope(raw_irqsave, &p->pi_lock) {
+		smp_mb__after_spinlock();
+		if (!ttwu_state_match(p, state, &success))
+			break;
 
-	trace_sched_waking(p);
+		trace_sched_waking(p);
 
-	/*
-	 * Ensure we load p->on_rq _after_ p->state, otherwise it would
-	 * be possible to, falsely, observe p->on_rq == 0 and get stuck
-	 * in smp_cond_load_acquire() below.
-	 *
-	 * sched_ttwu_pending()			try_to_wake_up()
-	 *   STORE p->on_rq = 1			  LOAD p->state
-	 *   UNLOCK rq->lock
-	 *
-	 * __schedule() (switch to task 'p')
-	 *   LOCK rq->lock			  smp_rmb();
-	 *   smp_mb__after_spinlock();
-	 *   UNLOCK rq->lock
-	 *
-	 * [task p]
-	 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
-	 *
-	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
-	 * __schedule().  See the comment for smp_mb__after_spinlock().
-	 *
-	 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
-	 */
-	smp_rmb();
-	if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
-		goto unlock;
+		/*
+		 * Ensure we load p->on_rq _after_ p->state, otherwise it would
+		 * be possible to, falsely, observe p->on_rq == 0 and get stuck
+		 * in smp_cond_load_acquire() below.
+		 *
+		 * sched_ttwu_pending()			try_to_wake_up()
+		 *   STORE p->on_rq = 1			  LOAD p->state
+		 *   UNLOCK rq->lock
+		 *
+		 * __schedule() (switch to task 'p')
+		 *   LOCK rq->lock			  smp_rmb();
+		 *   smp_mb__after_spinlock();
+		 *   UNLOCK rq->lock
+		 *
+		 * [task p]
+		 *   STORE p->state = UNINTERRUPTIBLE	  LOAD p->on_rq
+		 *
+		 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+		 * __schedule().  See the comment for smp_mb__after_spinlock().
+		 *
+		 * A similar smb_rmb() lives in try_invoke_on_locked_down_task().
+		 */
+		smp_rmb();
+		if (READ_ONCE(p->on_rq) && ttwu_runnable(p, wake_flags))
+			break;
 
 #ifdef CONFIG_SMP
-	/*
-	 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
-	 * possible to, falsely, observe p->on_cpu == 0.
-	 *
-	 * One must be running (->on_cpu == 1) in order to remove oneself
-	 * from the runqueue.
-	 *
-	 * __schedule() (switch to task 'p')	try_to_wake_up()
-	 *   STORE p->on_cpu = 1		  LOAD p->on_rq
-	 *   UNLOCK rq->lock
-	 *
-	 * __schedule() (put 'p' to sleep)
-	 *   LOCK rq->lock			  smp_rmb();
-	 *   smp_mb__after_spinlock();
-	 *   STORE p->on_rq = 0			  LOAD p->on_cpu
-	 *
-	 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
-	 * __schedule().  See the comment for smp_mb__after_spinlock().
-	 *
-	 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
-	 * schedule()'s deactivate_task() has 'happened' and p will no longer
-	 * care about it's own p->state. See the comment in __schedule().
-	 */
-	smp_acquire__after_ctrl_dep();
+		/*
+		 * Ensure we load p->on_cpu _after_ p->on_rq, otherwise it would be
+		 * possible to, falsely, observe p->on_cpu == 0.
+		 *
+		 * One must be running (->on_cpu == 1) in order to remove oneself
+		 * from the runqueue.
+		 *
+		 * __schedule() (switch to task 'p')	try_to_wake_up()
+		 *   STORE p->on_cpu = 1		  LOAD p->on_rq
+		 *   UNLOCK rq->lock
+		 *
+		 * __schedule() (put 'p' to sleep)
+		 *   LOCK rq->lock			  smp_rmb();
+		 *   smp_mb__after_spinlock();
+		 *   STORE p->on_rq = 0			  LOAD p->on_cpu
+		 *
+		 * Pairs with the LOCK+smp_mb__after_spinlock() on rq->lock in
+		 * __schedule().  See the comment for smp_mb__after_spinlock().
+		 *
+		 * Form a control-dep-acquire with p->on_rq == 0 above, to ensure
+		 * schedule()'s deactivate_task() has 'happened' and p will no longer
+		 * care about it's own p->state. See the comment in __schedule().
+		 */
+		smp_acquire__after_ctrl_dep();
 
-	/*
-	 * We're doing the wakeup (@success == 1), they did a dequeue (p->on_rq
-	 * == 0), which means we need to do an enqueue, change p->state to
-	 * TASK_WAKING such that we can unlock p->pi_lock before doing the
-	 * enqueue, such as ttwu_queue_wakelist().
-	 */
-	WRITE_ONCE(p->__state, TASK_WAKING);
+		/*
+		 * We're doing the wakeup (@success == 1), they did a dequeue (p->on_rq
+		 * == 0), which means we need to do an enqueue, change p->state to
+		 * TASK_WAKING such that we can unlock p->pi_lock before doing the
+		 * enqueue, such as ttwu_queue_wakelist().
+		 */
+		WRITE_ONCE(p->__state, TASK_WAKING);
 
-	/*
-	 * If the owning (remote) CPU is still in the middle of schedule() with
-	 * this task as prev, considering queueing p on the remote CPUs wake_list
-	 * which potentially sends an IPI instead of spinning on p->on_cpu to
-	 * let the waker make forward progress. This is safe because IRQs are
-	 * disabled and the IPI will deliver after on_cpu is cleared.
-	 *
-	 * Ensure we load task_cpu(p) after p->on_cpu:
-	 *
-	 * set_task_cpu(p, cpu);
-	 *   STORE p->cpu = @cpu
-	 * __schedule() (switch to task 'p')
-	 *   LOCK rq->lock
-	 *   smp_mb__after_spin_lock()		smp_cond_load_acquire(&p->on_cpu)
-	 *   STORE p->on_cpu = 1		LOAD p->cpu
-	 *
-	 * to ensure we observe the correct CPU on which the task is currently
-	 * scheduling.
-	 */
-	if (smp_load_acquire(&p->on_cpu) &&
-	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
-		goto unlock;
+		/*
+		 * If the owning (remote) CPU is still in the middle of schedule() with
+		 * this task as prev, considering queueing p on the remote CPUs wake_list
+		 * which potentially sends an IPI instead of spinning on p->on_cpu to
+		 * let the waker make forward progress. This is safe because IRQs are
+		 * disabled and the IPI will deliver after on_cpu is cleared.
+		 *
+		 * Ensure we load task_cpu(p) after p->on_cpu:
+		 *
+		 * set_task_cpu(p, cpu);
+		 *   STORE p->cpu = @cpu
+		 * __schedule() (switch to task 'p')
+		 *   LOCK rq->lock
+		 *   smp_mb__after_spin_lock()		smp_cond_load_acquire(&p->on_cpu)
+		 *   STORE p->on_cpu = 1		LOAD p->cpu
+		 *
+		 * to ensure we observe the correct CPU on which the task is currently
+		 * scheduling.
+		 */
+		if (smp_load_acquire(&p->on_cpu) &&
+		    ttwu_queue_wakelist(p, task_cpu(p), wake_flags))
+			break;
 
-	/*
-	 * If the owning (remote) CPU is still in the middle of schedule() with
-	 * this task as prev, wait until it's done referencing the task.
-	 *
-	 * Pairs with the smp_store_release() in finish_task().
-	 *
-	 * This ensures that tasks getting woken will be fully ordered against
-	 * their previous state and preserve Program Order.
-	 */
-	smp_cond_load_acquire(&p->on_cpu, !VAL);
+		/*
+		 * If the owning (remote) CPU is still in the middle of schedule() with
+		 * this task as prev, wait until it's done referencing the task.
+		 *
+		 * Pairs with the smp_store_release() in finish_task().
+		 *
+		 * This ensures that tasks getting woken will be fully ordered against
+		 * their previous state and preserve Program Order.
+		 */
+		smp_cond_load_acquire(&p->on_cpu, !VAL);
 
-	cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
-	if (task_cpu(p) != cpu) {
-		if (p->in_iowait) {
-			delayacct_blkio_end(p);
-			atomic_dec(&task_rq(p)->nr_iowait);
-		}
+		cpu = select_task_rq(p, p->wake_cpu, wake_flags | WF_TTWU);
+		if (task_cpu(p) != cpu) {
+			if (p->in_iowait) {
+				delayacct_blkio_end(p);
+				atomic_dec(&task_rq(p)->nr_iowait);
+			}
 
-		wake_flags |= WF_MIGRATED;
-		psi_ttwu_dequeue(p);
-		set_task_cpu(p, cpu);
-	}
+			wake_flags |= WF_MIGRATED;
+			psi_ttwu_dequeue(p);
+			set_task_cpu(p, cpu);
+		}
 #else
-	cpu = task_cpu(p);
+		cpu = task_cpu(p);
 #endif /* CONFIG_SMP */
 
-	ttwu_queue(p, cpu, wake_flags);
-unlock:
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+		ttwu_queue(p, cpu, wake_flags);
+	}
 out:
 	if (success)
 		ttwu_stat(p, task_cpu(p), wake_flags);
-	preempt_enable();
 
 	return success;
 }
@@ -5458,23 +5431,20 @@ unsigned int nr_iowait(void)
 void sched_exec(void)
 {
 	struct task_struct *p = current;
-	unsigned long flags;
+	struct migration_arg arg;
 	int dest_cpu;
 
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
-	if (dest_cpu == smp_processor_id())
-		goto unlock;
+	lock_scope(raw_irqsave, &p->pi_lock) {
+		dest_cpu = p->sched_class->select_task_rq(p, task_cpu(p), WF_EXEC);
+		if (dest_cpu == smp_processor_id())
+			return;
 
-	if (likely(cpu_active(dest_cpu))) {
-		struct migration_arg arg = { p, dest_cpu };
+		if (unlikely(!cpu_active(dest_cpu)))
+			return;
 
-		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
-		stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
-		return;
+		arg = (struct migration_arg){ p, dest_cpu };
 	}
-unlock:
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+	stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
 }
 
 #endif
@@ -5682,7 +5652,6 @@ static void sched_tick_remote(struct wor
 	int cpu = twork->cpu;
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *curr;
-	struct rq_flags rf;
 	u64 delta;
 	int os;
 
@@ -5693,30 +5662,27 @@ static void sched_tick_remote(struct wor
 	 * statistics and checks timeslices in a time-independent way, regardless
 	 * of when exactly it is running.
 	 */
-	if (!tick_nohz_tick_stopped_cpu(cpu))
-		goto out_requeue;
+	if (tick_nohz_tick_stopped_cpu(cpu)) {
+		lock_guard(rq_irq, rq_guard, rq);
 
-	rq_lock_irq(rq, &rf);
-	curr = rq->curr;
-	if (cpu_is_offline(cpu))
-		goto out_unlock;
+		curr = rq->curr;
+		if (cpu_is_offline(cpu))
+			break;
 
-	update_rq_clock(rq);
+		update_rq_clock(rq);
 
-	if (!is_idle_task(curr)) {
-		/*
-		 * Make sure the next tick runs within a reasonable
-		 * amount of time.
-		 */
-		delta = rq_clock_task(rq) - curr->se.exec_start;
-		WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
-	}
-	curr->sched_class->task_tick(rq, curr, 0);
+		if (!is_idle_task(curr)) {
+			/*
+			 * Make sure the next tick runs within a reasonable
+			 * amount of time.
+			 */
+			delta = rq_clock_task(rq) - curr->se.exec_start;
+			WARN_ON_ONCE(delta > (u64)NSEC_PER_SEC * 3);
+		}
+		curr->sched_class->task_tick(rq, curr, 0);
 
-	calc_load_nohz_remote(rq);
-out_unlock:
-	rq_unlock_irq(rq, &rf);
-out_requeue:
+		calc_load_nohz_remote(rq);
+	}
 
 	/*
 	 * Run the remote tick once per second (1Hz). This arbitrary
@@ -6265,53 +6231,51 @@ static bool try_steal_cookie(int this, i
 	unsigned long cookie;
 	bool success = false;
 
-	local_irq_disable();
-	double_rq_lock(dst, src);
+	void_scope(irq) {
+		double_lock_guard(rq, guard, dst, src);
 
-	cookie = dst->core->core_cookie;
-	if (!cookie)
-		goto unlock;
+		cookie = dst->core->core_cookie;
+		if (!cookie)
+			break;
 
-	if (dst->curr != dst->idle)
-		goto unlock;
+		if (dst->curr != dst->idle)
+			break;
 
-	p = sched_core_find(src, cookie);
-	if (!p)
-		goto unlock;
+		p = sched_core_find(src, cookie);
+		if (!p)
+			break;
 
-	do {
-		if (p == src->core_pick || p == src->curr)
-			goto next;
+		do {
+			if (p == src->core_pick || p == src->curr)
+				goto next;
 
-		if (!is_cpu_allowed(p, this))
-			goto next;
+			if (!is_cpu_allowed(p, this))
+				goto next;
 
-		if (p->core_occupation > dst->idle->core_occupation)
-			goto next;
-		/*
-		 * sched_core_find() and sched_core_next() will ensure that task @p
-		 * is not throttled now, we also need to check whether the runqueue
-		 * of the destination CPU is being throttled.
-		 */
-		if (sched_task_is_throttled(p, this))
-			goto next;
+			if (p->core_occupation > dst->idle->core_occupation)
+				goto next;
+			/*
+			 * sched_core_find() and sched_core_next() will ensure
+			 * that task @p is not throttled now, we also need to
+			 * check whether the runqueue of the destination CPU is
+			 * being throttled.
+			 */
+			if (sched_task_is_throttled(p, this))
+				goto next;
 
-		deactivate_task(src, p, 0);
-		set_task_cpu(p, this);
-		activate_task(dst, p, 0);
+			deactivate_task(src, p, 0);
+			set_task_cpu(p, this);
+			activate_task(dst, p, 0);
 
-		resched_curr(dst);
+			resched_curr(dst);
 
-		success = true;
-		break;
+			success = true;
+			break;
 
 next:
-		p = sched_core_next(p, cookie);
-	} while (p);
-
-unlock:
-	double_rq_unlock(dst, src);
-	local_irq_enable();
+			p = sched_core_next(p, cookie);
+		} while (p);
+	}
 
 	return success;
 }
@@ -6339,8 +6303,9 @@ static void sched_core_balance(struct rq
 	struct sched_domain *sd;
 	int cpu = cpu_of(rq);
 
-	preempt_disable();
-	rcu_read_lock();
+	void_guard(preempt, pg);
+	void_guard(rcu, rg);
+
 	raw_spin_rq_unlock_irq(rq);
 	for_each_domain(cpu, sd) {
 		if (need_resched())
@@ -6350,8 +6315,6 @@ static void sched_core_balance(struct rq
 			break;
 	}
 	raw_spin_rq_lock_irq(rq);
-	rcu_read_unlock();
-	preempt_enable();
 }
 
 static DEFINE_PER_CPU(struct balance_callback, core_balance_head);
@@ -6370,20 +6333,24 @@ static void queue_core_balance(struct rq
 	queue_balance_callback(rq, &per_cpu(core_balance_head, rq->cpu), sched_core_balance);
 }
 
+DEFINE_LOCK_GUARD(core, int,
+		  sched_core_lock(*_G->lock, &_G->flags),
+		  sched_core_unlock(*_G->lock, &_G->flags),
+		  unsigned long flags;)
+
 static void sched_core_cpu_starting(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
-	unsigned long flags;
 	int t;
 
-	sched_core_lock(cpu, &flags);
+	lock_guard(core, guard, &cpu);
 
 	WARN_ON_ONCE(rq->core != rq);
 
 	/* if we're the first, we'll be our own leader */
 	if (cpumask_weight(smt_mask) == 1)
-		goto unlock;
+		return;
 
 	/* find the leader */
 	for_each_cpu(t, smt_mask) {
@@ -6397,7 +6364,7 @@ static void sched_core_cpu_starting(unsi
 	}
 
 	if (WARN_ON_ONCE(!core_rq)) /* whoopsie */
-		goto unlock;
+		return;
 
 	/* install and validate core_rq */
 	for_each_cpu(t, smt_mask) {
@@ -6408,29 +6375,25 @@ static void sched_core_cpu_starting(unsi
 
 		WARN_ON_ONCE(rq->core != core_rq);
 	}
-
-unlock:
-	sched_core_unlock(cpu, &flags);
 }
 
 static void sched_core_cpu_deactivate(unsigned int cpu)
 {
 	const struct cpumask *smt_mask = cpu_smt_mask(cpu);
 	struct rq *rq = cpu_rq(cpu), *core_rq = NULL;
-	unsigned long flags;
 	int t;
 
-	sched_core_lock(cpu, &flags);
+	lock_guard(core, guard, &cpu);
 
 	/* if we're the last man standing, nothing to do */
 	if (cpumask_weight(smt_mask) == 1) {
 		WARN_ON_ONCE(rq->core != rq);
-		goto unlock;
+		return;
 	}
 
 	/* if we're not the leader, nothing to do */
 	if (rq->core != rq)
-		goto unlock;
+		return;
 
 	/* find a new leader */
 	for_each_cpu(t, smt_mask) {
@@ -6441,7 +6404,7 @@ static void sched_core_cpu_deactivate(un
 	}
 
 	if (WARN_ON_ONCE(!core_rq)) /* impossible */
-		goto unlock;
+		return;
 
 	/* copy the shared state to the new leader */
 	core_rq->core_task_seq             = rq->core_task_seq;
@@ -6463,9 +6426,6 @@ static void sched_core_cpu_deactivate(un
 		rq = cpu_rq(t);
 		rq->core = core_rq;
 	}
-
-unlock:
-	sched_core_unlock(cpu, &flags);
 }
 
 static inline void sched_core_cpu_dying(unsigned int cpu)
@@ -7162,8 +7122,6 @@ void set_user_nice(struct task_struct *p
 {
 	bool queued, running;
 	int old_prio;
-	struct rq_flags rf;
-	struct rq *rq;
 
 	if (task_nice(p) == nice || nice < MIN_NICE || nice > MAX_NICE)
 		return;
@@ -7171,44 +7129,45 @@ void set_user_nice(struct task_struct *p
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	rq = task_rq_lock(p, &rf);
-	update_rq_clock(rq);
+	lock_scope(task_rq, p) {
+		struct rq *rq = _scope.guard.rq;
 
-	/*
-	 * The RT priorities are set via sched_setscheduler(), but we still
-	 * allow the 'normal' nice value to be set - but as expected
-	 * it won't have any effect on scheduling until the task is
-	 * SCHED_DEADLINE, SCHED_FIFO or SCHED_RR:
-	 */
-	if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
-		p->static_prio = NICE_TO_PRIO(nice);
-		goto out_unlock;
-	}
-	queued = task_on_rq_queued(p);
-	running = task_current(rq, p);
-	if (queued)
-		dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
-	if (running)
-		put_prev_task(rq, p);
+		update_rq_clock(rq);
 
-	p->static_prio = NICE_TO_PRIO(nice);
-	set_load_weight(p, true);
-	old_prio = p->prio;
-	p->prio = effective_prio(p);
+		/*
+		 * The RT priorities are set via sched_setscheduler(), but we still
+		 * allow the 'normal' nice value to be set - but as expected
+		 * it won't have any effect on scheduling until the task is
+		 * SCHED_DEADLINE, SCHED_FIFO or SCHED_RR:
+		 */
+		if (task_has_dl_policy(p) || task_has_rt_policy(p)) {
+			p->static_prio = NICE_TO_PRIO(nice);
+			return;
+		}
 
-	if (queued)
-		enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
-	if (running)
-		set_next_task(rq, p);
+		queued = task_on_rq_queued(p);
+		running = task_current(rq, p);
+		if (queued)
+			dequeue_task(rq, p, DEQUEUE_SAVE | DEQUEUE_NOCLOCK);
+		if (running)
+			put_prev_task(rq, p);
 
-	/*
-	 * If the task increased its priority or is running and
-	 * lowered its priority, then reschedule its CPU:
-	 */
-	p->sched_class->prio_changed(rq, p, old_prio);
+		p->static_prio = NICE_TO_PRIO(nice);
+		set_load_weight(p, true);
+		old_prio = p->prio;
+		p->prio = effective_prio(p);
 
-out_unlock:
-	task_rq_unlock(rq, p, &rf);
+		if (queued)
+			enqueue_task(rq, p, ENQUEUE_RESTORE | ENQUEUE_NOCLOCK);
+		if (running)
+			set_next_task(rq, p);
+
+		/*
+		 * If the task increased its priority or is running and
+		 * lowered its priority, then reschedule its CPU:
+		 */
+		p->sched_class->prio_changed(rq, p, old_prio);
+	}
 }
 EXPORT_SYMBOL(set_user_nice);
 
@@ -7468,6 +7427,19 @@ static struct task_struct *find_process_
 	return pid ? find_task_by_vpid(pid) : current;
 }
 
+static struct task_struct *find_get_task(pid_t pid)
+{
+	struct task_struct *p;
+
+	void_scope(rcu) {
+		p = find_process_by_pid(pid);
+		if (likely(p))
+			get_task_struct(p);
+	}
+
+	return p;
+}
+
 /*
  * sched_setparam() passes in -1 for its policy, to let the functions
  * it calls know not to change it.
@@ -7505,14 +7477,11 @@ static void __setscheduler_params(struct
 static bool check_same_owner(struct task_struct *p)
 {
 	const struct cred *cred = current_cred(), *pcred;
-	bool match;
+	void_guard(rcu, guard);
 
-	rcu_read_lock();
 	pcred = __task_cred(p);
-	match = (uid_eq(cred->euid, pcred->euid) ||
-		 uid_eq(cred->euid, pcred->uid));
-	rcu_read_unlock();
-	return match;
+	return (uid_eq(cred->euid, pcred->euid) ||
+		uid_eq(cred->euid, pcred->uid));
 }
 
 /*
@@ -7915,28 +7884,19 @@ EXPORT_SYMBOL_GPL(sched_set_normal);
 static int
 do_sched_setscheduler(pid_t pid, int policy, struct sched_param __user *param)
 {
+	ptr_guard(put_task, p) = NULL;
 	struct sched_param lparam;
-	struct task_struct *p;
-	int retval;
 
 	if (!param || pid < 0)
 		return -EINVAL;
 	if (copy_from_user(&lparam, param, sizeof(struct sched_param)))
 		return -EFAULT;
 
-	rcu_read_lock();
-	retval = -ESRCH;
-	p = find_process_by_pid(pid);
-	if (likely(p))
-		get_task_struct(p);
-	rcu_read_unlock();
-
-	if (likely(p)) {
-		retval = sched_setscheduler(p, policy, &lparam);
-		put_task_struct(p);
-	}
+	p = find_get_task(pid);
+	if (!p)
+		return -ESRCH;
 
-	return retval;
+	return sched_setscheduler(p, policy, &lparam);
 }
 
 /*
@@ -8031,8 +7991,8 @@ SYSCALL_DEFINE2(sched_setparam, pid_t, p
 SYSCALL_DEFINE3(sched_setattr, pid_t, pid, struct sched_attr __user *, uattr,
 			       unsigned int, flags)
 {
+	ptr_guard(put_task, p) = NULL;
 	struct sched_attr attr;
-	struct task_struct *p;
 	int retval;
 
 	if (!uattr || pid < 0 || flags)
@@ -8047,21 +8007,14 @@ SYSCALL_DEFINE3(sched_setattr, pid_t, pi
 	if (attr.sched_flags & SCHED_FLAG_KEEP_POLICY)
 		attr.sched_policy = SETPARAM_POLICY;
 
-	rcu_read_lock();
-	retval = -ESRCH;
-	p = find_process_by_pid(pid);
-	if (likely(p))
-		get_task_struct(p);
-	rcu_read_unlock();
+	p = find_get_task(pid);
+	if (!p)
+		return -ESRCH;
 
-	if (likely(p)) {
-		if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
-			get_params(p, &attr);
-		retval = sched_setattr(p, &attr);
-		put_task_struct(p);
-	}
+	if (attr.sched_flags & SCHED_FLAG_KEEP_PARAMS)
+		get_params(p, &attr);
 
-	return retval;
+	return sched_setattr(p, &attr);
 }
 
 /**
@@ -8079,16 +8032,19 @@ SYSCALL_DEFINE1(sched_getscheduler, pid_
 	if (pid < 0)
 		return -EINVAL;
 
-	retval = -ESRCH;
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	if (p) {
+	void_scope(rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
+
 		retval = security_task_getscheduler(p);
-		if (!retval)
-			retval = p->policy
-				| (p->sched_reset_on_fork ? SCHED_RESET_ON_FORK : 0);
+		if (!retval) {
+			retval = p->policy;
+			if (p->sched_reset_on_fork)
+				retval |= SCHED_RESET_ON_FORK;
+		}
 	}
-	rcu_read_unlock();
+
 	return retval;
 }
 
@@ -8109,30 +8065,23 @@ SYSCALL_DEFINE2(sched_getparam, pid_t, p
 	if (!param || pid < 0)
 		return -EINVAL;
 
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
+	void_scope(rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-	if (task_has_rt_policy(p))
-		lp.sched_priority = p->rt_priority;
-	rcu_read_unlock();
+		if (task_has_rt_policy(p))
+			lp.sched_priority = p->rt_priority;
+	}
 
 	/*
 	 * This one might sleep, we cannot do it with a spinlock held ...
 	 */
-	retval = copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
-
-	return retval;
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
+	return copy_to_user(param, &lp, sizeof(*param)) ? -EFAULT : 0;
 }
 
 /*
@@ -8192,39 +8141,33 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pi
 	    usize < SCHED_ATTR_SIZE_VER0 || flags)
 		return -EINVAL;
 
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
+	void_scope(rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-	kattr.sched_policy = p->policy;
-	if (p->sched_reset_on_fork)
-		kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
-	get_params(p, &kattr);
-	kattr.sched_flags &= SCHED_FLAG_ALL;
+		kattr.sched_policy = p->policy;
+		if (p->sched_reset_on_fork)
+			kattr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
+		get_params(p, &kattr);
+		kattr.sched_flags &= SCHED_FLAG_ALL;
 
 #ifdef CONFIG_UCLAMP_TASK
-	/*
-	 * This could race with another potential updater, but this is fine
-	 * because it'll correctly read the old or the new value. We don't need
-	 * to guarantee who wins the race as long as it doesn't return garbage.
-	 */
-	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
-	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
+		/*
+		 * This could race with another potential updater, but this is fine
+		 * because it'll correctly read the old or the new value. We don't need
+		 * to guarantee who wins the race as long as it doesn't return garbage.
+		 */
+		kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
+		kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
 #endif
-
-	rcu_read_unlock();
+	}
 
 	return sched_attr_copy_to_user(uattr, &kattr, usize);
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
 }
 
 #ifdef CONFIG_SMP
@@ -8245,10 +8188,10 @@ int dl_task_check_affinity(struct task_s
 	 * tasks allowed to run on all the CPUs in the task's
 	 * root_domain.
 	 */
-	rcu_read_lock();
-	if (!cpumask_subset(task_rq(p)->rd->span, mask))
-		ret = -EBUSY;
-	rcu_read_unlock();
+	void_scope(rcu) {
+		if (!cpumask_subset(task_rq(p)->rd->span, mask))
+			ret = -EBUSY;
+	}
 	return ret;
 }
 #endif
@@ -8317,41 +8260,27 @@ __sched_setaffinity(struct task_struct *
 
 long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 {
+	ptr_guard(put_task, p) = NULL;
 	struct affinity_context ac;
 	struct cpumask *user_mask;
-	struct task_struct *p;
 	int retval;
 
-	rcu_read_lock();
-
-	p = find_process_by_pid(pid);
-	if (!p) {
-		rcu_read_unlock();
+	p = find_get_task(pid);
+	if (!p)
 		return -ESRCH;
-	}
-
-	/* Prevent p going away */
-	get_task_struct(p);
-	rcu_read_unlock();
 
-	if (p->flags & PF_NO_SETAFFINITY) {
-		retval = -EINVAL;
-		goto out_put_task;
-	}
+	if (p->flags & PF_NO_SETAFFINITY)
+		return -EINVAL;
 
 	if (!check_same_owner(p)) {
-		rcu_read_lock();
-		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE)) {
-			rcu_read_unlock();
-			retval = -EPERM;
-			goto out_put_task;
-		}
-		rcu_read_unlock();
+		void_guard(rcu, rg);
+		if (!ns_capable(__task_cred(p)->user_ns, CAP_SYS_NICE))
+			return -EPERM;
 	}
 
 	retval = security_task_setscheduler(p);
 	if (retval)
-		goto out_put_task;
+		return retval;
 
 	/*
 	 * With non-SMP configs, user_cpus_ptr/user_mask isn't used and
@@ -8361,8 +8290,7 @@ long sched_setaffinity(pid_t pid, const
 	if (user_mask) {
 		cpumask_copy(user_mask, in_mask);
 	} else if (IS_ENABLED(CONFIG_SMP)) {
-		retval = -ENOMEM;
-		goto out_put_task;
+		return -ENOMEM;
 	}
 
 	ac = (struct affinity_context){
@@ -8374,8 +8302,6 @@ long sched_setaffinity(pid_t pid, const
 	retval = __sched_setaffinity(p, &ac);
 	kfree(ac.user_mask);
 
-out_put_task:
-	put_task_struct(p);
 	return retval;
 }
 
@@ -8417,28 +8343,22 @@ SYSCALL_DEFINE3(sched_setaffinity, pid_t
 long sched_getaffinity(pid_t pid, struct cpumask *mask)
 {
 	struct task_struct *p;
-	unsigned long flags;
 	int retval;
 
-	rcu_read_lock();
+	void_scope(rcu) {
+		p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = -ESRCH;
-	p = find_process_by_pid(pid);
-	if (!p)
-		goto out_unlock;
-
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
-
-	raw_spin_lock_irqsave(&p->pi_lock, flags);
-	cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
-	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-out_unlock:
-	rcu_read_unlock();
+		lock_scope(raw_irqsave, &p->pi_lock)
+			cpumask_and(mask, &p->cpus_mask, cpu_active_mask);
+	}
 
-	return retval;
+	return 0;
 }
 
 /**
@@ -8885,55 +8805,47 @@ int __sched yield_to(struct task_struct
 {
 	struct task_struct *curr = current;
 	struct rq *rq, *p_rq;
-	unsigned long flags;
 	int yielded = 0;
 
-	local_irq_save(flags);
-	rq = this_rq();
+	void_scope(irqsave) {
+		rq = this_rq();
 
 again:
-	p_rq = task_rq(p);
-	/*
-	 * If we're the only runnable task on the rq and target rq also
-	 * has only one task, there's absolutely no point in yielding.
-	 */
-	if (rq->nr_running == 1 && p_rq->nr_running == 1) {
-		yielded = -ESRCH;
-		goto out_irq;
-	}
+		p_rq = task_rq(p);
+		/*
+		 * If we're the only runnable task on the rq and target rq also
+		 * has only one task, there's absolutely no point in yielding.
+		 */
+		if (rq->nr_running == 1 && p_rq->nr_running == 1)
+			return -ESRCH;
 
-	double_rq_lock(rq, p_rq);
-	if (task_rq(p) != p_rq) {
-		double_rq_unlock(rq, p_rq);
-		goto again;
-	}
+		double_lock_scope(rq, rq, p_rq) {
+			if (task_rq(p) != p_rq)
+				goto again;
 
-	if (!curr->sched_class->yield_to_task)
-		goto out_unlock;
+			if (!curr->sched_class->yield_to_task)
+				return 0;
 
-	if (curr->sched_class != p->sched_class)
-		goto out_unlock;
+			if (curr->sched_class != p->sched_class)
+				return 0;
 
-	if (task_on_cpu(p_rq, p) || !task_is_running(p))
-		goto out_unlock;
+			if (task_on_cpu(p_rq, p) || !task_is_running(p))
+				return 0;
 
-	yielded = curr->sched_class->yield_to_task(rq, p);
-	if (yielded) {
-		schedstat_inc(rq->yld_count);
-		/*
-		 * Make p's CPU reschedule; pick_next_entity takes care of
-		 * fairness.
-		 */
-		if (preempt && rq != p_rq)
-			resched_curr(p_rq);
+			yielded = curr->sched_class->yield_to_task(rq, p);
+			if (yielded) {
+				schedstat_inc(rq->yld_count);
+				/*
+				 * Make p's CPU reschedule; pick_next_entity
+				 * takes care of fairness.
+				 */
+				if (preempt && rq != p_rq)
+					resched_curr(p_rq);
+			}
+		}
 	}
 
-out_unlock:
-	double_rq_unlock(rq, p_rq);
-out_irq:
-	local_irq_restore(flags);
-
-	if (yielded > 0)
+	if (yielded)
 		schedule();
 
 	return yielded;
@@ -9036,38 +8948,30 @@ SYSCALL_DEFINE1(sched_get_priority_min,
 
 static int sched_rr_get_interval(pid_t pid, struct timespec64 *t)
 {
-	struct task_struct *p;
-	unsigned int time_slice;
-	struct rq_flags rf;
-	struct rq *rq;
+	unsigned int time_slice = 0;
 	int retval;
 
 	if (pid < 0)
 		return -EINVAL;
 
-	retval = -ESRCH;
-	rcu_read_lock();
-	p = find_process_by_pid(pid);
-	if (!p)
-		goto out_unlock;
+	void_scope(rcu) {
+		struct task_struct *p = find_process_by_pid(pid);
+		if (!p)
+			return -ESRCH;
 
-	retval = security_task_getscheduler(p);
-	if (retval)
-		goto out_unlock;
+		retval = security_task_getscheduler(p);
+		if (retval)
+			return retval;
 
-	rq = task_rq_lock(p, &rf);
-	time_slice = 0;
-	if (p->sched_class->get_rr_interval)
-		time_slice = p->sched_class->get_rr_interval(rq, p);
-	task_rq_unlock(rq, p, &rf);
+		lock_scope(task_rq, p) {
+			struct rq *rq = _scope.guard.rq;
+			if (p->sched_class->get_rr_interval)
+				time_slice = p->sched_class->get_rr_interval(rq, p);
+		}
+	}
 
-	rcu_read_unlock();
 	jiffies_to_timespec64(time_slice, t);
 	return 0;
-
-out_unlock:
-	rcu_read_unlock();
-	return retval;
 }
 
 /**
@@ -9300,10 +9204,8 @@ int task_can_attach(struct task_struct *
 	 * success of set_cpus_allowed_ptr() on all attached tasks
 	 * before cpus_mask may be changed.
 	 */
-	if (p->flags & PF_NO_SETAFFINITY) {
-		ret = -EINVAL;
-		goto out;
-	}
+	if (p->flags & PF_NO_SETAFFINITY)
+		return -EINVAL;
 
 	if (dl_task(p) && !cpumask_intersects(task_rq(p)->rd->span,
 					      cs_effective_cpus)) {
@@ -9314,7 +9216,6 @@ int task_can_attach(struct task_struct *
 		ret = dl_cpu_busy(cpu, p);
 	}
 
-out:
 	return ret;
 }
 
@@ -10464,17 +10365,18 @@ void sched_move_task(struct task_struct
 	int queued, running, queue_flags =
 		DEQUEUE_SAVE | DEQUEUE_MOVE | DEQUEUE_NOCLOCK;
 	struct task_group *group;
-	struct rq_flags rf;
 	struct rq *rq;
 
-	rq = task_rq_lock(tsk, &rf);
+	lock_guard(task_rq, guard, tsk);
+	rq = guard.rq;
+
 	/*
 	 * Esp. with SCHED_AUTOGROUP enabled it is possible to get superfluous
 	 * group changes.
 	 */
 	group = sched_get_task_group(tsk);
 	if (group == tsk->sched_task_group)
-		goto unlock;
+		return;
 
 	update_rq_clock(rq);
 
@@ -10499,9 +10401,6 @@ void sched_move_task(struct task_struct
 		 */
 		resched_curr(rq);
 	}
-
-unlock:
-	task_rq_unlock(rq, tsk, &rf);
 }
 
 static inline struct task_group *css_tg(struct cgroup_subsys_state *css)
@@ -10538,11 +10437,10 @@ static int cpu_cgroup_css_online(struct
 
 #ifdef CONFIG_UCLAMP_TASK_GROUP
 	/* Propagate the effective uclamp value for the new group */
-	mutex_lock(&uclamp_mutex);
-	rcu_read_lock();
-	cpu_util_update_eff(css);
-	rcu_read_unlock();
-	mutex_unlock(&uclamp_mutex);
+	lock_scope(mutex, &uclamp_mutex) {
+		void_guard(rcu, guard);
+		cpu_util_update_eff(css);
+	}
 #endif
 
 	return 0;
@@ -10693,24 +10591,22 @@ static ssize_t cpu_uclamp_write(struct k
 
 	static_branch_enable(&sched_uclamp_used);
 
-	mutex_lock(&uclamp_mutex);
-	rcu_read_lock();
-
-	tg = css_tg(of_css(of));
-	if (tg->uclamp_req[clamp_id].value != req.util)
-		uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false);
+	lock_scope(mutex, &uclamp_mutex) {
+		void_guard(rcu, guard);
 
-	/*
-	 * Because of not recoverable conversion rounding we keep track of the
-	 * exact requested value
-	 */
-	tg->uclamp_pct[clamp_id] = req.percent;
+		tg = css_tg(of_css(of));
+		if (tg->uclamp_req[clamp_id].value != req.util)
+			uclamp_se_set(&tg->uclamp_req[clamp_id], req.util, false);
 
-	/* Update effective clamps to track the most restrictive value */
-	cpu_util_update_eff(of_css(of));
+		/*
+		 * Because of not recoverable conversion rounding we keep track of the
+		 * exact requested value
+		 */
+		tg->uclamp_pct[clamp_id] = req.percent;
 
-	rcu_read_unlock();
-	mutex_unlock(&uclamp_mutex);
+		/* Update effective clamps to track the most restrictive value */
+		cpu_util_update_eff(of_css(of));
+	}
 
 	return nbytes;
 }
@@ -10737,10 +10633,10 @@ static inline void cpu_uclamp_print(stru
 	u64 percent;
 	u32 rem;
 
-	rcu_read_lock();
-	tg = css_tg(seq_css(sf));
-	util_clamp = tg->uclamp_req[clamp_id].value;
-	rcu_read_unlock();
+	void_scope(rcu) {
+		tg = css_tg(seq_css(sf));
+		util_clamp = tg->uclamp_req[clamp_id].value;
+	}
 
 	if (util_clamp == SCHED_CAPACITY_SCALE) {
 		seq_puts(sf, "max\n");
@@ -10792,6 +10688,8 @@ static const u64 max_cfs_runtime = MAX_B
 
 static int __cfs_schedulable(struct task_group *tg, u64 period, u64 runtime);
 
+DEFINE_VOID_GUARD(cpus_read, cpus_read_lock(), cpus_read_unlock())
+
 static int tg_set_cfs_bandwidth(struct task_group *tg, u64 period, u64 quota,
 				u64 burst)
 {
@@ -10831,53 +10729,54 @@ static int tg_set_cfs_bandwidth(struct t
 	 * Prevent race between setting of cfs_rq->runtime_enabled and
 	 * unthrottle_offline_cfs_rqs().
 	 */
-	cpus_read_lock();
-	mutex_lock(&cfs_constraints_mutex);
-	ret = __cfs_schedulable(tg, period, quota);
-	if (ret)
-		goto out_unlock;
+	void_scope(cpus_read) {
+		lock_guard(mutex, guard, &cfs_constraints_mutex);
 
-	runtime_enabled = quota != RUNTIME_INF;
-	runtime_was_enabled = cfs_b->quota != RUNTIME_INF;
-	/*
-	 * If we need to toggle cfs_bandwidth_used, off->on must occur
-	 * before making related changes, and on->off must occur afterwards
-	 */
-	if (runtime_enabled && !runtime_was_enabled)
-		cfs_bandwidth_usage_inc();
-	raw_spin_lock_irq(&cfs_b->lock);
-	cfs_b->period = ns_to_ktime(period);
-	cfs_b->quota = quota;
-	cfs_b->burst = burst;
-
-	__refill_cfs_bandwidth_runtime(cfs_b);
-
-	/* Restart the period timer (if active) to handle new period expiry: */
-	if (runtime_enabled)
-		start_cfs_bandwidth(cfs_b);
-
-	raw_spin_unlock_irq(&cfs_b->lock);
-
-	for_each_online_cpu(i) {
-		struct cfs_rq *cfs_rq = tg->cfs_rq[i];
-		struct rq *rq = cfs_rq->rq;
-		struct rq_flags rf;
-
-		rq_lock_irq(rq, &rf);
-		cfs_rq->runtime_enabled = runtime_enabled;
-		cfs_rq->runtime_remaining = 0;
-
-		if (cfs_rq->throttled)
-			unthrottle_cfs_rq(cfs_rq);
-		rq_unlock_irq(rq, &rf);
+		ret = __cfs_schedulable(tg, period, quota);
+		if (ret)
+			return ret;
+
+		runtime_enabled = quota != RUNTIME_INF;
+		runtime_was_enabled = cfs_b->quota != RUNTIME_INF;
+		/*
+		 * If we need to toggle cfs_bandwidth_used, off->on must occur
+		 * before making related changes, and on->off must occur afterwards
+		 */
+		if (runtime_enabled && !runtime_was_enabled)
+			cfs_bandwidth_usage_inc();
+
+		lock_scope(raw_irq, &cfs_b->lock) {
+			cfs_b->period = ns_to_ktime(period);
+			cfs_b->quota = quota;
+			cfs_b->burst = burst;
+
+			__refill_cfs_bandwidth_runtime(cfs_b);
+
+			/*
+			 * Restart the period timer (if active) to handle new
+			 * period expiry:
+			 */
+			if (runtime_enabled)
+				start_cfs_bandwidth(cfs_b);
+		}
+
+		for_each_online_cpu(i) {
+			struct cfs_rq *cfs_rq = tg->cfs_rq[i];
+			struct rq *rq = cfs_rq->rq;
+
+			lock_scope(rq_irq, rq) {
+				cfs_rq->runtime_enabled = runtime_enabled;
+				cfs_rq->runtime_remaining = 0;
+
+				if (cfs_rq->throttled)
+					unthrottle_cfs_rq(cfs_rq);
+			}
+		}
+		if (runtime_was_enabled && !runtime_enabled)
+			cfs_bandwidth_usage_dec();
 	}
-	if (runtime_was_enabled && !runtime_enabled)
-		cfs_bandwidth_usage_dec();
-out_unlock:
-	mutex_unlock(&cfs_constraints_mutex);
-	cpus_read_unlock();
 
-	return ret;
+	return 0;
 }
 
 static int tg_set_cfs_quota(struct task_group *tg, long cfs_quota_us)
@@ -11069,9 +10968,8 @@ static int __cfs_schedulable(struct task
 		do_div(data.quota, NSEC_PER_USEC);
 	}
 
-	rcu_read_lock();
-	ret = walk_tg_tree(tg_cfs_schedulable_down, tg_nop, &data);
-	rcu_read_unlock();
+	void_scope(rcu)
+		ret = walk_tg_tree(tg_cfs_schedulable_down, tg_nop, &data);
 
 	return ret;
 }
@@ -11634,14 +11532,13 @@ int __sched_mm_cid_migrate_from_fetch_ci
 	 * are not the last task to be migrated from this cpu for this mm, so
 	 * there is no need to move src_cid to the destination cpu.
 	 */
-	rcu_read_lock();
-	src_task = rcu_dereference(src_rq->curr);
-	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		rcu_read_unlock();
-		t->last_mm_cid = -1;
-		return -1;
+	void_scope(rcu) {
+		src_task = rcu_dereference(src_rq->curr);
+		if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+			t->last_mm_cid = -1;
+			return -1;
+		}
 	}
-	rcu_read_unlock();
 
 	return src_cid;
 }
@@ -11685,18 +11582,17 @@ int __sched_mm_cid_migrate_from_try_stea
 	 * the lazy-put flag, this task will be responsible for transitioning
 	 * from lazy-put flag set to MM_CID_UNSET.
 	 */
-	rcu_read_lock();
-	src_task = rcu_dereference(src_rq->curr);
-	if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
-		rcu_read_unlock();
-		/*
-		 * We observed an active task for this mm, there is therefore
-		 * no point in moving this cid to the destination cpu.
-		 */
-		t->last_mm_cid = -1;
-		return -1;
+	void_scope(rcu) {
+		src_task = rcu_dereference(src_rq->curr);
+		if (READ_ONCE(src_task->mm_cid_active) && src_task->mm == mm) {
+			/*
+			 * We observed an active task for this mm, there is therefore
+			 * no point in moving this cid to the destination cpu.
+			 */
+			t->last_mm_cid = -1;
+			return -1;
+		}
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The src_cid is unused, so it can be unset.
@@ -11769,7 +11665,6 @@ static void sched_mm_cid_remote_clear(st
 {
 	struct rq *rq = cpu_rq(cpu);
 	struct task_struct *t;
-	unsigned long flags;
 	int cid, lazy_cid;
 
 	cid = READ_ONCE(pcpu_cid->cid);
@@ -11804,23 +11699,21 @@ static void sched_mm_cid_remote_clear(st
 	 * the lazy-put flag, that task will be responsible for transitioning
 	 * from lazy-put flag set to MM_CID_UNSET.
 	 */
-	rcu_read_lock();
-	t = rcu_dereference(rq->curr);
-	if (READ_ONCE(t->mm_cid_active) && t->mm == mm) {
-		rcu_read_unlock();
-		return;
+	void_scope(rcu) {
+		t = rcu_dereference(rq->curr);
+		if (READ_ONCE(t->mm_cid_active) && t->mm == mm)
+			return;
 	}
-	rcu_read_unlock();
 
 	/*
 	 * The cid is unused, so it can be unset.
 	 * Disable interrupts to keep the window of cid ownership without rq
 	 * lock small.
 	 */
-	local_irq_save(flags);
-	if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
-		__mm_cid_put(mm, cid);
-	local_irq_restore(flags);
+	void_scope(irqsave) {
+		if (try_cmpxchg(&pcpu_cid->cid, &lazy_cid, MM_CID_UNSET))
+			__mm_cid_put(mm, cid);
+	}
 }
 
 static void sched_mm_cid_remote_clear_old(struct mm_struct *mm, int cpu)
@@ -11842,14 +11735,13 @@ static void sched_mm_cid_remote_clear_ol
 	 * snapshot associated with this cid if an active task using the mm is
 	 * observed on this rq.
 	 */
-	rcu_read_lock();
-	curr = rcu_dereference(rq->curr);
-	if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
-		WRITE_ONCE(pcpu_cid->time, rq_clock);
-		rcu_read_unlock();
-		return;
+	void_scope(rcu) {
+		curr = rcu_dereference(rq->curr);
+		if (READ_ONCE(curr->mm_cid_active) && curr->mm == mm) {
+			WRITE_ONCE(pcpu_cid->time, rq_clock);
+			return;
+		}
 	}
-	rcu_read_unlock();
 
 	if (rq_clock < pcpu_cid->time + SCHED_MM_CID_PERIOD_NS)
 		return;
@@ -11943,7 +11835,6 @@ void task_tick_mm_cid(struct rq *rq, str
 void sched_mm_cid_exit_signals(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11951,23 +11842,22 @@ void sched_mm_cid_exit_signals(struct ta
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 0);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	mm_cid_put(mm);
-	t->last_mm_cid = t->mm_cid = -1;
-	rq_unlock_irqrestore(rq, &rf);
+	lock_scope(rq_irqsave, rq) {
+		preempt_enable_no_resched();	/* holding spinlock */
+		WRITE_ONCE(t->mm_cid_active, 0);
+		/*
+		 * Store t->mm_cid_active before loading per-mm/cpu cid.
+		 * Matches barrier in sched_mm_cid_remote_clear_old().
+		 */
+		smp_mb();
+		mm_cid_put(mm);
+		t->last_mm_cid = t->mm_cid = -1;
+	}
 }
 
 void sched_mm_cid_before_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11975,23 +11865,22 @@ void sched_mm_cid_before_execve(struct t
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 0);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	mm_cid_put(mm);
-	t->last_mm_cid = t->mm_cid = -1;
-	rq_unlock_irqrestore(rq, &rf);
+	lock_scope(rq_irqsave, rq) {
+		preempt_enable_no_resched();	/* holding spinlock */
+		WRITE_ONCE(t->mm_cid_active, 0);
+		/*
+		 * Store t->mm_cid_active before loading per-mm/cpu cid.
+		 * Matches barrier in sched_mm_cid_remote_clear_old().
+		 */
+		smp_mb();
+		mm_cid_put(mm);
+		t->last_mm_cid = t->mm_cid = -1;
+	}
 }
 
 void sched_mm_cid_after_execve(struct task_struct *t)
 {
 	struct mm_struct *mm = t->mm;
-	struct rq_flags rf;
 	struct rq *rq;
 
 	if (!mm)
@@ -11999,16 +11888,16 @@ void sched_mm_cid_after_execve(struct ta
 
 	preempt_disable();
 	rq = this_rq();
-	rq_lock_irqsave(rq, &rf);
-	preempt_enable_no_resched();	/* holding spinlock */
-	WRITE_ONCE(t->mm_cid_active, 1);
-	/*
-	 * Store t->mm_cid_active before loading per-mm/cpu cid.
-	 * Matches barrier in sched_mm_cid_remote_clear_old().
-	 */
-	smp_mb();
-	t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
-	rq_unlock_irqrestore(rq, &rf);
+	lock_scope(rq_irqsave, rq) {
+		preempt_enable_no_resched();	/* holding spinlock */
+		WRITE_ONCE(t->mm_cid_active, 1);
+		/*
+		 * Store t->mm_cid_active before loading per-mm/cpu cid.
+		 * Matches barrier in sched_mm_cid_remote_clear_old().
+		 */
+		smp_mb();
+		t->last_mm_cid = t->mm_cid = mm_cid_get(rq, mm);
+	}
 	rseq_set_notify_resume(t);
 }
 
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1397,6 +1397,10 @@ do {						\
 	flags = _raw_spin_rq_lock_irqsave(rq);	\
 } while (0)
 
+DEFINE_LOCK_GUARD(raw_rq, struct rq,
+		  raw_spin_rq_lock(_G->lock),
+		  raw_spin_rq_unlock(_G->lock))
+
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 
@@ -1630,6 +1634,12 @@ task_rq_unlock(struct rq *rq, struct tas
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
+DEFINE_LOCK_GUARD(task_rq, struct task_struct,
+		  _G->rq = task_rq_lock(_G->lock, &_G->rf),
+		  task_rq_unlock(_G->rq, _G->lock, &_G->rf),
+		  struct rq *rq;
+		  struct rq_flags rf;)
+
 static inline void
 rq_lock_irqsave(struct rq *rq, struct rq_flags *rf)
 	__acquires(rq->lock)
@@ -1678,6 +1688,21 @@ rq_unlock(struct rq *rq, struct rq_flags
 	raw_spin_rq_unlock(rq);
 }
 
+DEFINE_LOCK_GUARD(rq, struct rq,
+		  rq_lock(_G->lock, &_G->rf),
+		  rq_unlock(_G->lock, &_G->rf),
+		  struct rq_flags rf;)
+
+DEFINE_LOCK_GUARD(rq_irq, struct rq,
+		  rq_lock_irq(_G->lock, &_G->rf),
+		  rq_unlock_irq(_G->lock, &_G->rf),
+		  struct rq_flags rf;)
+
+DEFINE_LOCK_GUARD(rq_irqsave, struct rq,
+		  rq_lock_irqsave(_G->lock, &_G->rf),
+		  rq_unlock_irqrestore(_G->lock, &_G->rf),
+		  struct rq_flags rf;)
+
 static inline struct rq *
 this_rq_lock_irq(struct rq_flags *rf)
 	__acquires(rq->lock)
@@ -2701,6 +2726,16 @@ static inline void double_raw_lock(raw_s
 	raw_spin_lock_nested(l2, SINGLE_DEPTH_NESTING);
 }
 
+static inline void double_raw_unlock(raw_spinlock_t *l1, raw_spinlock_t *l2)
+{
+	raw_spin_unlock(l1);
+	raw_spin_unlock(l2);
+}
+
+DEFINE_DOUBLE_LOCK_GUARD(raw, raw_spinlock_t,
+			 double_raw_lock(_G->lock, _G->lock2),
+			 double_raw_unlock(_G->lock, _G->lock2))
+
 /*
  * double_rq_unlock - safely unlock two runqueues
  *
@@ -2758,6 +2793,10 @@ static inline void double_rq_unlock(stru
 
 #endif
 
+DEFINE_DOUBLE_LOCK_GUARD(rq, struct rq,
+			 double_rq_lock(_G->lock, _G->lock2),
+			 double_rq_unlock(_G->lock, _G->lock2))
+
 extern struct sched_entity *__pick_first_entity(struct cfs_rq *cfs_rq);
 extern struct sched_entity *__pick_last_entity(struct cfs_rq *cfs_rq);
 


