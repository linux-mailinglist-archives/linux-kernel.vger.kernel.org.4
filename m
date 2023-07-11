Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D659D74E338
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 03:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbjGKBQe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 21:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbjGKBQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 21:16:10 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E6AE5E;
        Mon, 10 Jul 2023 18:15:31 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5577004e21bso1790015a12.2;
        Mon, 10 Jul 2023 18:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689038100; x=1691630100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkFSAYNODZN0di2/Ld2Uei2YtYdld5uhb+0NkutjUbI=;
        b=ktc9f1GEfH7tRxLJFK4ueODH1ffqst4Bb26NIyQmWW9R7WpgAMLLyelfa1UdxS54/l
         MuU6c83udEX3aZ4Gk9NqggnbQF7IHQJEQmdh4EIBBI3ezGtkvKnvKyS2FIEXBJ92+mSS
         Wc6/3fdf3rL2E7MBrwWAOufnMPHmxjCobkqZ/8knlPO8VhuRFM9dZhkCXNezvQyTNTF6
         azkOlSSGaCLZqwkTPKM5AsYibB4YNsKnZOZLvbcBU4koAtQInvG5SdcAHxCsULRJIpwg
         mjCJdx5/XK3Azgp9U/ka473TFu5qHSnMUzciTZ93ubBYPhh7ySTKTJLXjUNNTw03Z9ce
         hohA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689038100; x=1691630100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IkFSAYNODZN0di2/Ld2Uei2YtYdld5uhb+0NkutjUbI=;
        b=lCHJwvscxaSR/Nf9SxePxGiflVW/OVpaf4iV2sPXQOurtB4knW9biRPqEQM/lqXgEy
         hrTzIMWtDA7JnxMzupHvMakvhk/l5thWKlMF4pmpx+77OK7FGoC9oMWOo8ys/9FWhuuP
         kr+yO5x+A6fBp5IdMMNnXZ74wtxZBn/umUhvKDvlWnRYVsYiQWINJyVundQLE0hDrdi/
         vVr5AqSoF8/1auRbMn4Yrbwz38yi6y6CwQxrPvTP7pd6TE8YI6EcAfXK/jB7XktxU+q9
         Y3EWKgAyfUvm34k9Zaz7Ote7JjpGIErig10j6ocyXAFaCY05+EHqGaK38Tw22dk8t5Qn
         fv6g==
X-Gm-Message-State: ABy/qLa/tEDFNIledldaMoS8Ii77SZUnS1oMEd3v0Pmz+QJPPkkZi17/
        jj8uhRm3ceUlScRMjJClQ2s=
X-Google-Smtp-Source: APBJJlGqs5i0enFjdnsEWdKEjN4zwHOAzfEjbA2N7llcTSktUL+pIlGQ6fpOHnsTdwe8vs1JcFn7aQ==
X-Received: by 2002:a17:902:db06:b0:1b5:25bd:df2b with SMTP id m6-20020a170902db0600b001b525bddf2bmr14475132plx.14.1689038100223;
        Mon, 10 Jul 2023 18:15:00 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:e2fe])
        by smtp.gmail.com with ESMTPSA id h13-20020a170902680d00b001b9e86e05b7sm561254plk.0.2023.07.10.18.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 18:14:59 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     torvalds@linux-foundation.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org,
        joshdon@google.com, brho@google.com, pjt@google.com,
        derkling@google.com, haoluo@google.com, dvernet@meta.com,
        dschatzberg@meta.com, dskarlat@cs.cmu.edu, riel@surriel.com
Cc:     linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 22/34] sched_ext: Implement tickless support
Date:   Mon, 10 Jul 2023 15:13:40 -1000
Message-ID: <20230711011412.100319-23-tj@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230711011412.100319-1-tj@kernel.org>
References: <20230711011412.100319-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow BPF schedulers to indicate tickless operation by setting p->scx.slice
to SCX_SLICE_INF. A CPU whose current task has infinte slice goes into
tickless operation.

scx_central is updated to use tickless operations for all tasks and
instead use a BPF timer to expire slices. This also uses the SCX_ENQ_PREEMPT
and task state tracking added by the previous patches.

Currently, there is no way to pin the timer on the central CPU, so it may
end up on one of the worker CPUs; however, outside of that, the worker CPUs
can go tickless both while running sched_ext tasks and idling.

With schbench running, scx_central shows:

  root@test ~# grep ^LOC /proc/interrupts; sleep 10; grep ^LOC /proc/interrupts
  LOC:     142024        656        664        449   Local timer interrupts
  LOC:     161663        663        665        449   Local timer interrupts

Without it:

  root@test ~ [SIGINT]# grep ^LOC /proc/interrupts; sleep 10; grep ^LOC /proc/interrupts
  LOC:     188778       3142       3793       3993   Local timer interrupts
  LOC:     198993       5314       6323       6438   Local timer interrupts

While scx_central itself is too barebone to be useful as a
production scheduler, a more featureful central scheduler can be built using
the same approach. Google's experience shows that such an approach can have
significant benefits for certain applications such as VM hosting.

v2: * Convert to BPF inline iterators.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reviewed-by: David Vernet <dvernet@meta.com>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
---
 include/linux/sched/ext.h         |   1 +
 kernel/sched/core.c               |   9 ++-
 kernel/sched/ext.c                |  43 ++++++++++-
 kernel/sched/ext.h                |   2 +
 kernel/sched/sched.h              |   6 ++
 tools/sched_ext/scx_central.bpf.c | 121 ++++++++++++++++++++++++++++--
 tools/sched_ext/scx_central.c     |   3 +-
 7 files changed, 173 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 5cc37bc30352..676259b09ac4 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -19,6 +19,7 @@ enum scx_consts {
 	SCX_EXIT_MSG_LEN	= 1024,
 
 	SCX_SLICE_DFL		= 20 * NSEC_PER_MSEC,
+	SCX_SLICE_INF		= U64_MAX,	/* infinite, implies nohz */
 };
 
 /*
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c976a36dd642..30603331c2d7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1222,13 +1222,16 @@ bool sched_can_stop_tick(struct rq *rq)
 		return true;
 
 	/*
-	 * If there are no DL,RR/FIFO tasks, there must only be CFS tasks left;
-	 * if there's more than one we need the tick for involuntary
-	 * preemption.
+	 * If there are no DL,RR/FIFO tasks, there must only be CFS or SCX tasks
+	 * left. For CFS, if there's more than one we need the tick for
+	 * involuntary preemption. For SCX, ask.
 	 */
 	if (!scx_switched_all() && rq->nr_running > 1)
 		return false;
 
+	if (scx_enabled() && !scx_can_stop_tick(rq))
+		return false;
+
 	return true;
 }
 #endif /* CONFIG_NO_HZ_FULL */
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 2951200cd81a..7632bb7a016d 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -477,7 +477,8 @@ static void update_curr_scx(struct rq *rq)
 	account_group_exec_runtime(curr, delta_exec);
 	cgroup_account_cputime(curr, delta_exec);
 
-	curr->scx.slice -= min(curr->scx.slice, delta_exec);
+	if (curr->scx.slice != SCX_SLICE_INF)
+		curr->scx.slice -= min(curr->scx.slice, delta_exec);
 }
 
 static void dispatch_enqueue(struct scx_dispatch_q *dsq, struct task_struct *p,
@@ -1399,6 +1400,20 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 		SCX_CALL_OP(SCX_KF_REST, running, p);
 
 	watchdog_unwatch_task(p, true);
+
+	/*
+	 * @p is getting newly scheduled or got kicked after someone updated its
+	 * slice. Refresh whether tick can be stopped. See can_stop_tick_scx().
+	 */
+	if ((p->scx.slice == SCX_SLICE_INF) !=
+	    (bool)(rq->scx.flags & SCX_RQ_CAN_STOP_TICK)) {
+		if (p->scx.slice == SCX_SLICE_INF)
+			rq->scx.flags |= SCX_RQ_CAN_STOP_TICK;
+		else
+			rq->scx.flags &= ~SCX_RQ_CAN_STOP_TICK;
+
+		sched_update_tick_dependency(rq);
+	}
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
@@ -1981,6 +1996,26 @@ int scx_check_setscheduler(struct task_struct *p, int policy)
 	return 0;
 }
 
+#ifdef CONFIG_NO_HZ_FULL
+bool scx_can_stop_tick(struct rq *rq)
+{
+	struct task_struct *p = rq->curr;
+
+	if (scx_ops_disabling())
+		return false;
+
+	if (p->sched_class != &ext_sched_class)
+		return true;
+
+	/*
+	 * @rq can dispatch from different DSQs, so we can't tell whether it
+	 * needs the tick or not by looking at nr_running. Allow stopping ticks
+	 * iff the BPF scheduler indicated so. See set_next_task_scx().
+	 */
+	return rq->scx.flags & SCX_RQ_CAN_STOP_TICK;
+}
+#endif
+
 /*
  * Omitted operations:
  *
@@ -2141,7 +2176,7 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	struct rhashtable_iter rht_iter;
 	struct scx_dispatch_q *dsq;
 	const char *reason;
-	int i, type;
+	int i, cpu, type;
 
 	type = atomic_read(&scx_exit_type);
 	while (true) {
@@ -2239,6 +2274,10 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	scx_task_iter_exit(&sti);
 	spin_unlock_irq(&scx_tasks_lock);
 
+	/* kick all CPUs to restore ticks */
+	for_each_possible_cpu(cpu)
+		resched_cpu(cpu);
+
 forward_progress_guaranteed:
 	/*
 	 * Here, every runnable task is guaranteed to make forward progress and
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index f535ec39e660..0953091750a6 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -102,6 +102,7 @@ int scx_fork(struct task_struct *p);
 void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 int scx_check_setscheduler(struct task_struct *p, int policy);
+bool scx_can_stop_tick(struct rq *rq);
 void init_sched_ext_class(void);
 
 __printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
@@ -162,6 +163,7 @@ static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline int scx_check_setscheduler(struct task_struct *p,
 					 int policy) { return 0; }
+static inline bool scx_can_stop_tick(struct rq *rq) { return true; }
 static inline void init_sched_ext_class(void) {}
 static inline void scx_notify_sched_tick(void) {}
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index ed544ed5ecd6..f79fa633e343 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -686,12 +686,18 @@ struct cfs_rq {
 };
 
 #ifdef CONFIG_SCHED_CLASS_EXT
+/* scx_rq->flags, protected by the rq lock */
+enum scx_rq_flags {
+	SCX_RQ_CAN_STOP_TICK	= 1 << 0,
+};
+
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
 	struct list_head	watchdog_list;
 	u64			ops_qseq;
 	u64			extra_enq_flags;	/* see move_task_to_local_dsq() */
 	u32			nr_running;
+	u32			flags;
 	cpumask_var_t		cpus_to_kick;
 	cpumask_var_t		cpus_to_preempt;
 	struct irq_work		kick_cpus_irq_work;
diff --git a/tools/sched_ext/scx_central.bpf.c b/tools/sched_ext/scx_central.bpf.c
index 094e089300a2..f44b9365a177 100644
--- a/tools/sched_ext/scx_central.bpf.c
+++ b/tools/sched_ext/scx_central.bpf.c
@@ -13,7 +13,26 @@
  *    through per-CPU BPF queues. The current design is chosen to maximally
  *    utilize and verify various SCX mechanisms such as LOCAL_ON dispatching.
  *
- * b. Preemption
+ * b. Tickless operation
+ *
+ *    All tasks are dispatched with the infinite slice which allows stopping the
+ *    ticks on CONFIG_NO_HZ_FULL kernels running with the proper nohz_full
+ *    parameter. The tickless operation can be observed through
+ *    /proc/interrupts.
+ *
+ *    Periodic switching is enforced by a periodic timer checking all CPUs and
+ *    preempting them as necessary. Unfortunately, BPF timer currently doesn't
+ *    have a way to pin to a specific CPU, so the periodic timer isn't pinned to
+ *    the central CPU.
+ *
+ * c. Preemption
+ *
+ *    Kthreads are unconditionally queued to the head of a matching local dsq
+ *    and dispatched with SCX_DSQ_PREEMPT. This ensures that a kthread is always
+ *    prioritized over user threads, which is required for ensuring forward
+ *    progress as e.g. the periodic timer may run on a ksoftirqd and if the
+ *    ksoftirqd gets starved by a user thread, there may not be anything else to
+ *    vacate that user thread.
  *
  *    SCX_KICK_PREEMPT is used to trigger scheduling and CPUs to move to the
  *    next tasks.
@@ -42,7 +61,7 @@ const volatile s32 central_cpu;
 const volatile u32 nr_cpu_ids = 64;	/* !0 for veristat, set during init */
 
 u64 nr_total, nr_locals, nr_queued, nr_lost_pids;
-u64 nr_dispatches, nr_mismatches, nr_retries;
+u64 nr_timers, nr_dispatches, nr_mismatches, nr_retries;
 u64 nr_overflows;
 
 struct user_exit_info uei;
@@ -55,6 +74,7 @@ struct {
 
 /* can't use percpu map due to bad lookups */
 static bool cpu_gimme_task[MAX_CPUS];
+static u64 cpu_started_at[MAX_CPUS];
 
 struct central_timer {
 	struct bpf_timer timer;
@@ -67,6 +87,11 @@ struct {
 	__type(value, struct central_timer);
 } central_timer SEC(".maps");
 
+static bool vtime_before(u64 a, u64 b)
+{
+	return (s64)(a - b) < 0;
+}
+
 s32 BPF_STRUCT_OPS(central_select_cpu, struct task_struct *p,
 		   s32 prev_cpu, u64 wake_flags)
 {
@@ -85,9 +110,22 @@ void BPF_STRUCT_OPS(central_enqueue, struct task_struct *p, u64 enq_flags)
 
 	__sync_fetch_and_add(&nr_total, 1);
 
+	/*
+	 * Push per-cpu kthreads at the head of local dsq's and preempt the
+	 * corresponding CPU. This ensures that e.g. ksoftirqd isn't blocked
+	 * behind other threads which is necessary for forward progress
+	 * guarantee as we depend on the BPF timer which may run from ksoftirqd.
+	 */
+	if ((p->flags & PF_KTHREAD) && p->nr_cpus_allowed == 1) {
+		__sync_fetch_and_add(&nr_locals, 1);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL, SCX_SLICE_INF,
+				 enq_flags | SCX_ENQ_PREEMPT);
+		return;
+	}
+
 	if (bpf_map_push_elem(&central_q, &pid, 0)) {
 		__sync_fetch_and_add(&nr_overflows, 1);
-		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, enq_flags);
+		scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, enq_flags);
 		return;
 	}
 
@@ -120,13 +158,13 @@ static bool dispatch_to_cpu(s32 cpu)
 		 */
 		if (!bpf_cpumask_test_cpu(cpu, p->cpus_ptr)) {
 			__sync_fetch_and_add(&nr_mismatches, 1);
-			scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_DFL, 0);
+			scx_bpf_dispatch(p, FALLBACK_DSQ_ID, SCX_SLICE_INF, 0);
 			bpf_task_release(p);
 			continue;
 		}
 
 		/* dispatch to local and mark that @cpu doesn't need more */
-		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_DFL, 0);
+		scx_bpf_dispatch(p, SCX_DSQ_LOCAL_ON | cpu, SCX_SLICE_INF, 0);
 
 		if (cpu != central_cpu)
 			scx_bpf_kick_cpu(cpu, 0);
@@ -194,12 +232,81 @@ void BPF_STRUCT_OPS(central_dispatch, s32 cpu, struct task_struct *prev)
 	}
 }
 
+void BPF_STRUCT_OPS(central_running, struct task_struct *p)
+{
+	s32 cpu = scx_bpf_task_cpu(p);
+	u64 *started_at = MEMBER_VPTR(cpu_started_at, [cpu]);
+	if (started_at)
+		*started_at = bpf_ktime_get_ns() ?: 1;	/* 0 indicates idle */
+}
+
+void BPF_STRUCT_OPS(central_stopping, struct task_struct *p, bool runnable)
+{
+	s32 cpu = scx_bpf_task_cpu(p);
+	u64 *started_at = MEMBER_VPTR(cpu_started_at, [cpu]);
+	if (started_at)
+		*started_at = 0;
+}
+
+static int central_timerfn(void *map, int *key, struct bpf_timer *timer)
+{
+	u64 now = bpf_ktime_get_ns();
+	u64 nr_to_kick = nr_queued;
+	s32 i;
+
+	bpf_for(i, 0, nr_cpu_ids) {
+		s32 cpu = (nr_timers + i) % nr_cpu_ids;
+		u64 *started_at;
+
+		if (cpu == central_cpu)
+			continue;
+
+		/* kick iff the current one exhausted its slice */
+		started_at = MEMBER_VPTR(cpu_started_at, [cpu]);
+		if (started_at && *started_at &&
+		    vtime_before(now, *started_at + SCX_SLICE_DFL))
+			continue;
+
+		/* and there's something pending */
+		if (scx_bpf_dsq_nr_queued(FALLBACK_DSQ_ID) ||
+		    scx_bpf_dsq_nr_queued(SCX_DSQ_LOCAL_ON | cpu))
+			;
+		else if (nr_to_kick)
+			nr_to_kick--;
+		else
+			continue;
+
+		scx_bpf_kick_cpu(cpu, SCX_KICK_PREEMPT);
+	}
+
+	scx_bpf_kick_cpu(central_cpu, SCX_KICK_PREEMPT);
+
+	bpf_timer_start(timer, TIMER_INTERVAL_NS, 0);
+	__sync_fetch_and_add(&nr_timers, 1);
+	return 0;
+}
+
 int BPF_STRUCT_OPS_SLEEPABLE(central_init)
 {
+	u32 key = 0;
+	struct bpf_timer *timer;
+	int ret;
+
 	if (!switch_partial)
 		scx_bpf_switch_all();
 
-	return scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+	ret = scx_bpf_create_dsq(FALLBACK_DSQ_ID, -1);
+	if (ret)
+		return ret;
+
+	timer = bpf_map_lookup_elem(&central_timer, &key);
+	if (!timer)
+		return -ESRCH;
+
+	bpf_timer_init(timer, &central_timer, CLOCK_MONOTONIC);
+	bpf_timer_set_callback(timer, central_timerfn);
+	ret = bpf_timer_start(timer, TIMER_INTERVAL_NS, 0);
+	return ret;
 }
 
 void BPF_STRUCT_OPS(central_exit, struct scx_exit_info *ei)
@@ -219,6 +326,8 @@ struct sched_ext_ops central_ops = {
 	.select_cpu		= (void *)central_select_cpu,
 	.enqueue		= (void *)central_enqueue,
 	.dispatch		= (void *)central_dispatch,
+	.running		= (void *)central_running,
+	.stopping		= (void *)central_stopping,
 	.init			= (void *)central_init,
 	.exit			= (void *)central_exit,
 	.name			= "central",
diff --git a/tools/sched_ext/scx_central.c b/tools/sched_ext/scx_central.c
index 09cb759984a6..7481d3c9123a 100644
--- a/tools/sched_ext/scx_central.c
+++ b/tools/sched_ext/scx_central.c
@@ -76,7 +76,8 @@ int main(int argc, char **argv)
 		       skel->bss->nr_locals,
 		       skel->bss->nr_queued,
 		       skel->bss->nr_lost_pids);
-		printf("                    dispatch:%10lu mismatch:%10lu retry:%10lu\n",
+		printf("timer   :%10lu dispatch:%10lu mismatch:%10lu retry:%10lu\n",
+		       skel->bss->nr_timers,
 		       skel->bss->nr_dispatches,
 		       skel->bss->nr_mismatches,
 		       skel->bss->nr_retries);
-- 
2.41.0

