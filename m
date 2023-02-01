Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1852E67F2F9
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 01:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjA1ATM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 19:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbjA1ASF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 19:18:05 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74BD87CCB2;
        Fri, 27 Jan 2023 16:17:29 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id v23so6592297plo.1;
        Fri, 27 Jan 2023 16:17:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ShvHxKSvwBj/EM2eUFVCPEUd79aoyWNar7Xjs0gX+VI=;
        b=MuYrxfRzqS0pNVRRpV6OUWON+D10yphHLf19wJqYr5KSpGjYaD7O5cprW7ajyjeVFN
         tQMacVNywpwmpbKLCji1IQCJRex1Uiw+naRWsuC5f0y9L+/XmCI6c0nqWWZ/hCNeAWgM
         zUuWxB89+17IGS7ZIdAc0f/+xO7uJywuvecWmIxBEbAmMUZyzTwLZTYjP1RFVj0gOJRW
         kb/XnhGlEo40cwnk3CTmGIsFswRlXuUX4Ud9hdFYXSANljlEDEDbpKSq2GcA0V2EZoth
         d9/GQ4TCQJtTSSmDMwWO/jJ/YGZTS34995+yMepDcjFiCdv8IYfmvJp+AI1smh9FdJTI
         snug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ShvHxKSvwBj/EM2eUFVCPEUd79aoyWNar7Xjs0gX+VI=;
        b=279AxleBl9TwTPs64vh2ql5Y8Rm8ZxRs5tHihwBAkKtkEpydMjEWslAkIfbbKxqQBI
         RW0MKVWWez6QdjvAVVq9uryEe8hnttSX4mU7viQ9p0jVriDJDSVot0JyDwjGwx+EyIzO
         tkgYD1EUayBvXzGeSt4Se9dl7vJu+M9etbYdDtKMTmdUw33V2qwbytE4QgZ0egNrUn51
         GqsnO0w2cti8hC6DHOd5fG4rTonvKVmZD1XAi1C+aodC1bfRbIQKHbHU9ls9g8oU0SF0
         qnBaYzh+kgVo1XnT/A+G59Il80czHnAEZKYnh9J6uqgNf/TGojUfaqXgcMTc4H4uSxVI
         ZL+Q==
X-Gm-Message-State: AFqh2krSChEI+f3lHijewj6xxLVxOUwHr8ZcXsA0REvYZublukMW5wg8
        zNEfzYOsyRk+F3QJZM8nQy+3aOk/GBw=
X-Google-Smtp-Source: AMrXdXuNjRdTROrVaUoV6b/cdf05Ut3DAhXyG5LeIlrQ1jLVvddFEMs+Jyyr4yO4XJrE0DYohpIpzg==
X-Received: by 2002:a17:902:b213:b0:189:e3d0:daf8 with SMTP id t19-20020a170902b21300b00189e3d0daf8mr39278315plr.55.1674865041676;
        Fri, 27 Jan 2023 16:17:21 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id k14-20020a170902ce0e00b0018c990ce7fesm3378804plg.239.2023.01.27.16.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 16:17:21 -0800 (PST)
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
        kernel-team@meta.com, Tejun Heo <tj@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH 16/30] sched_ext: Implement runnable task stall watchdog
Date:   Fri, 27 Jan 2023 14:16:25 -1000
Message-Id: <20230128001639.3510083-17-tj@kernel.org>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230128001639.3510083-1-tj@kernel.org>
References: <20230128001639.3510083-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Vernet <dvernet@meta.com>

The most common and critical way that a BPF scheduler can misbehave is by
failing to run runnable tasks for too long. This patch implements a
watchdog.

* All tasks record when they become runnable.

* A watchdog work periodically scans all runnable tasks. If any task has
  stayed runnable for too long, the BPF scheduler is aborted.

* scheduler_tick() monitors whether the watchdog itself is stuck. If so, the
  BPF scheduler is aborted.

Because the watchdog only scans the tasks which are currently runnable and
usually very infrequently, the overhead should be negligible.
scx_example_qmap is updated so that it can be told to stall user and/or
kernel tasks.

A detected task stall looks like the following:

 sched_ext: BPF scheduler "qmap" errored, disabling
 sched_ext: runnable task stall (dbus-daemon[953] failed to run for 6.478s)
    scx_check_timeout_workfn+0x10e/0x1b0
    process_one_work+0x287/0x560
    worker_thread+0x234/0x420
    kthread+0xe9/0x100
    ret_from_fork+0x1f/0x30

A detected watchdog stall:

 sched_ext: BPF scheduler "qmap" errored, disabling
 sched_ext: runnable task stall (watchdog failed to check in for 5.001s)
    scheduler_tick+0x2eb/0x340
    update_process_times+0x7a/0x90
    tick_sched_timer+0xd8/0x130
    __hrtimer_run_queues+0x178/0x3b0
    hrtimer_interrupt+0xfc/0x390
    __sysvec_apic_timer_interrupt+0xb7/0x2b0
    sysvec_apic_timer_interrupt+0x90/0xb0
    asm_sysvec_apic_timer_interrupt+0x1b/0x20
    default_idle+0x14/0x20
    arch_cpu_idle+0xf/0x20
    default_idle_call+0x50/0x90
    do_idle+0xe8/0x240
    cpu_startup_entry+0x1d/0x20
    kernel_init+0x0/0x190
    start_kernel+0x0/0x392
    start_kernel+0x324/0x392
    x86_64_start_reservations+0x2a/0x2c
    x86_64_start_kernel+0x104/0x109
    secondary_startup_64_no_verify+0xce/0xdb

Note that this patch exposes scx_ops_error[_type]() in kernel/sched/ext.h to
inline scx_notify_sched_tick().

v2: Julia Lawall noticed that the watchdog code was mixing msecs and
    jiffies. Fix by using jiffies for everything.

Signed-off-by: David Vernet <dvernet@meta.com>
Reviewed-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Josh Don <joshdon@google.com>
Acked-by: Hao Luo <haoluo@google.com>
Acked-by: Barret Rhoden <brho@google.com>
Cc: Julia Lawall <julia.lawall@inria.fr>
---
 include/linux/sched/ext.h              |  13 +++
 init/init_task.c                       |   2 +
 kernel/sched/core.c                    |   3 +
 kernel/sched/ext.c                     | 128 +++++++++++++++++++++++--
 kernel/sched/ext.h                     |  25 +++++
 kernel/sched/sched.h                   |   1 +
 tools/sched_ext/scx_example_qmap.bpf.c |  12 +++
 tools/sched_ext/scx_example_qmap.c     |  14 ++-
 8 files changed, 186 insertions(+), 12 deletions(-)

diff --git a/include/linux/sched/ext.h b/include/linux/sched/ext.h
index 988d1e30e26c..474a8c0a0b12 100644
--- a/include/linux/sched/ext.h
+++ b/include/linux/sched/ext.h
@@ -59,6 +59,7 @@ enum scx_exit_type {
 
 	SCX_EXIT_ERROR = 1024,	/* runtime error, error msg contains details */
 	SCX_EXIT_ERROR_BPF,	/* ERROR but triggered through scx_bpf_error() */
+	SCX_EXIT_ERROR_STALL,	/* watchdog detected stalled runnable tasks */
 };
 
 /*
@@ -307,6 +308,15 @@ struct sched_ext_ops {
 	 */
 	u64 flags;
 
+	/**
+	 * timeout_ms - The maximum amount of time, in milliseconds, that a
+	 * runnable task should be able to wait before being scheduled. The
+	 * maximum timeout may not exceed the default timeout of 30 seconds.
+	 *
+	 * Defaults to the maximum allowed timeout value of 30 seconds.
+	 */
+	u32 timeout_ms;
+
 	/**
 	 * name - BPF scheduler's name
 	 *
@@ -340,6 +350,7 @@ enum scx_ent_flags {
 	SCX_TASK_OPS_PREPPED	= 1 << 3, /* prepared for BPF scheduler enable */
 	SCX_TASK_OPS_ENABLED	= 1 << 4, /* task has BPF scheduler enabled */
 
+	SCX_TASK_WATCHDOG_RESET = 1 << 5, /* task watchdog counter should be reset */
 	SCX_TASK_DEQD_FOR_SLEEP	= 1 << 6, /* last dequeue was for SLEEP */
 
 	SCX_TASK_CURSOR		= 1 << 7, /* iteration cursor, not a task */
@@ -369,12 +380,14 @@ enum scx_kf_mask {
 struct sched_ext_entity {
 	struct scx_dispatch_q	*dsq;
 	struct list_head	dsq_node;
+	struct list_head	watchdog_node;
 	u32			flags;		/* protected by rq lock */
 	u32			weight;
 	s32			sticky_cpu;
 	s32			holding_cpu;
 	u32			kf_mask;	/* see scx_kf_mask above */
 	atomic64_t		ops_state;
+	unsigned long		runnable_at;
 
 	/* BPF scheduler modifiable fields */
 
diff --git a/init/init_task.c b/init/init_task.c
index bdbc663107bf..913194aab623 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -106,9 +106,11 @@ struct task_struct init_task
 #ifdef CONFIG_SCHED_CLASS_EXT
 	.scx		= {
 		.dsq_node	= LIST_HEAD_INIT(init_task.scx.dsq_node),
+		.watchdog_node	= LIST_HEAD_INIT(init_task.scx.watchdog_node),
 		.sticky_cpu	= -1,
 		.holding_cpu	= -1,
 		.ops_state	= ATOMIC_INIT(0),
+		.runnable_at	= INITIAL_JIFFIES,
 		.slice		= SCX_SLICE_DFL,
 	},
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 804aa291b837..3f177c161c1e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4424,12 +4424,14 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 #ifdef CONFIG_SCHED_CLASS_EXT
 	p->scx.dsq		= NULL;
 	INIT_LIST_HEAD(&p->scx.dsq_node);
+	INIT_LIST_HEAD(&p->scx.watchdog_node);
 	p->scx.flags		= 0;
 	p->scx.weight		= 0;
 	p->scx.sticky_cpu	= -1;
 	p->scx.holding_cpu	= -1;
 	p->scx.kf_mask		= 0;
 	atomic64_set(&p->scx.ops_state, 0);
+	p->scx.runnable_at	= INITIAL_JIFFIES;
 	p->scx.slice		= SCX_SLICE_DFL;
 #endif
 
@@ -5584,6 +5586,7 @@ void scheduler_tick(void)
 	if (sched_feat(LATENCY_WARN) && resched_latency)
 		resched_latency_warn(cpu, resched_latency);
 
+	scx_notify_sched_tick();
 	perf_event_task_tick();
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ebbf3f3c1cf7..1af74ea8ed42 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -9,6 +9,7 @@
 enum scx_internal_consts {
 	SCX_NR_ONLINE_OPS	= SCX_OP_IDX(init),
 	SCX_DSP_DFL_MAX_BATCH	= 32,
+	SCX_WATCHDOG_MAX_TIMEOUT = 30 * HZ,
 };
 
 enum scx_ops_enable_state {
@@ -87,6 +88,23 @@ static struct scx_exit_info scx_exit_info;
 
 static atomic64_t scx_nr_rejected = ATOMIC64_INIT(0);
 
+/*
+ * The maximum amount of time in jiffies that a task may be runnable without
+ * being scheduled on a CPU. If this timeout is exceeded, it will trigger
+ * scx_ops_error().
+ */
+unsigned long scx_watchdog_timeout;
+
+/*
+ * The last time the delayed work was run. This delayed work relies on
+ * ksoftirqd being able to run to service timer interrupts, so it's possible
+ * that this work itself could get wedged. To account for this, we check that
+ * it's not stalled in the timer tick, and trigger an error if it is.
+ */
+unsigned long scx_watchdog_timestamp = INITIAL_JIFFIES;
+
+static struct delayed_work scx_watchdog_work;
+
 /* idle tracking */
 #ifdef CONFIG_SMP
 #ifdef CONFIG_CPUMASK_OFFSTACK
@@ -146,10 +164,6 @@ static DEFINE_PER_CPU(struct scx_dsp_ctx, scx_dsp_ctx);
 
 void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64 slice,
 		      u64 enq_flags);
-__printf(2, 3) static void scx_ops_error_type(enum scx_exit_type type,
-					      const char *fmt, ...);
-#define scx_ops_error(fmt, args...)						\
-	scx_ops_error_type(SCX_EXIT_ERROR, fmt, ##args)
 
 struct scx_task_iter {
 	struct sched_ext_entity		cursor;
@@ -668,6 +682,27 @@ static void do_enqueue_task(struct rq *rq, struct task_struct *p, u64 enq_flags,
 	dispatch_enqueue(&scx_dsq_global, p, enq_flags);
 }
 
+static bool watchdog_task_watched(const struct task_struct *p)
+{
+	return !list_empty(&p->scx.watchdog_node);
+}
+
+static void watchdog_watch_task(struct rq *rq, struct task_struct *p)
+{
+	lockdep_assert_rq_held(rq);
+	if (p->scx.flags & SCX_TASK_WATCHDOG_RESET)
+		p->scx.runnable_at = jiffies;
+	p->scx.flags &= ~SCX_TASK_WATCHDOG_RESET;
+	list_add_tail(&p->scx.watchdog_node, &rq->scx.watchdog_list);
+}
+
+static void watchdog_unwatch_task(struct task_struct *p, bool reset_timeout)
+{
+	list_del_init(&p->scx.watchdog_node);
+	if (reset_timeout)
+		p->scx.flags |= SCX_TASK_WATCHDOG_RESET;
+}
+
 static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags)
 {
 	int sticky_cpu = p->scx.sticky_cpu;
@@ -684,9 +719,12 @@ static void enqueue_task_scx(struct rq *rq, struct task_struct *p, int enq_flags
 	if (unlikely(enq_flags & ENQUEUE_RESTORE) && task_current(rq, p))
 		sticky_cpu = cpu_of(rq);
 
-	if (p->scx.flags & SCX_TASK_QUEUED)
+	if (p->scx.flags & SCX_TASK_QUEUED) {
+		WARN_ON_ONCE(!watchdog_task_watched(p));
 		return;
+	}
 
+	watchdog_watch_task(rq, p);
 	p->scx.flags |= SCX_TASK_QUEUED;
 	rq->scx.nr_running++;
 	add_nr_running(rq, 1);
@@ -698,6 +736,8 @@ static void ops_dequeue(struct task_struct *p, u64 deq_flags)
 {
 	u64 opss;
 
+	watchdog_unwatch_task(p, false);
+
 	/* acquire ensures that we see the preceding updates on QUEUED */
 	opss = atomic64_read_acquire(&p->scx.ops_state);
 
@@ -742,8 +782,10 @@ static void dequeue_task_scx(struct rq *rq, struct task_struct *p, int deq_flags
 {
 	struct scx_rq *scx_rq = &rq->scx;
 
-	if (!(p->scx.flags & SCX_TASK_QUEUED))
+	if (!(p->scx.flags & SCX_TASK_QUEUED)) {
+		WARN_ON_ONCE(watchdog_task_watched(p));
 		return;
+	}
 
 	ops_dequeue(p, deq_flags);
 
@@ -1256,6 +1298,8 @@ static void set_next_task_scx(struct rq *rq, struct task_struct *p, bool first)
 	}
 
 	p->se.exec_start = rq_clock_task(rq);
+
+	watchdog_unwatch_task(p, true);
 }
 
 static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
@@ -1299,11 +1343,14 @@ static void put_prev_task_scx(struct rq *rq, struct task_struct *p)
 	 */
 	if (p->scx.flags & SCX_TASK_BAL_KEEP) {
 		p->scx.flags &= ~SCX_TASK_BAL_KEEP;
+		watchdog_watch_task(rq, p);
 		dispatch_enqueue(&rq->scx.local_dsq, p, SCX_ENQ_HEAD);
 		return;
 	}
 
 	if (p->scx.flags & SCX_TASK_QUEUED) {
+		watchdog_watch_task(rq, p);
+
 		/*
 		 * If @p has slice left and balance_scx() didn't tag it for
 		 * keeping, @p is getting preempted by a higher priority
@@ -1530,6 +1577,49 @@ static void reset_idle_masks(void) {}
 
 #endif /* CONFIG_SMP */
 
+static bool check_rq_for_timeouts(struct rq *rq)
+{
+	struct task_struct *p;
+	struct rq_flags rf;
+	bool timed_out = false;
+
+	rq_lock_irqsave(rq, &rf);
+	list_for_each_entry(p, &rq->scx.watchdog_list, scx.watchdog_node) {
+		unsigned long last_runnable = p->scx.runnable_at;
+
+		if (unlikely(time_after(jiffies,
+					last_runnable + scx_watchdog_timeout))) {
+			u32 dur_ms = jiffies_to_msecs(jiffies - last_runnable);
+
+			scx_ops_error_type(SCX_EXIT_ERROR_STALL,
+					   "%s[%d] failed to run for %u.%03us",
+					   p->comm, p->pid,
+					   dur_ms / 1000, dur_ms % 1000);
+			timed_out = true;
+			break;
+		}
+	}
+	rq_unlock_irqrestore(rq, &rf);
+
+	return timed_out;
+}
+
+static void scx_watchdog_workfn(struct work_struct *work)
+{
+	int cpu;
+
+	scx_watchdog_timestamp = jiffies;
+
+	for_each_online_cpu(cpu) {
+		if (unlikely(check_rq_for_timeouts(cpu_rq(cpu))))
+			break;
+
+		cond_resched();
+	}
+	queue_delayed_work(system_unbound_wq, to_delayed_work(work),
+			   scx_watchdog_timeout / 2);
+}
+
 static void task_tick_scx(struct rq *rq, struct task_struct *curr, int queued)
 {
 	update_curr_scx(rq);
@@ -1561,7 +1651,7 @@ static int scx_ops_prepare_task(struct task_struct *p, struct task_group *tg)
 		}
 	}
 
-	p->scx.flags |= SCX_TASK_OPS_PREPPED;
+	p->scx.flags |= (SCX_TASK_OPS_PREPPED | SCX_TASK_WATCHDOG_RESET);
 	return 0;
 }
 
@@ -1877,6 +1967,8 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 			break;
 	}
 
+	cancel_delayed_work_sync(&scx_watchdog_work);
+
 	switch (type) {
 	case SCX_EXIT_UNREG:
 		reason = "BPF scheduler unregistered";
@@ -1890,6 +1982,9 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	case SCX_EXIT_ERROR_BPF:
 		reason = "scx_bpf_error";
 		break;
+	case SCX_EXIT_ERROR_STALL:
+		reason = "runnable task stall";
+		break;
 	default:
 		reason = "<UNKNOWN>";
 	}
@@ -2074,8 +2169,8 @@ static void scx_ops_error_irq_workfn(struct irq_work *irq_work)
 
 static DEFINE_IRQ_WORK(scx_ops_error_irq_work, scx_ops_error_irq_workfn);
 
-__printf(2, 3) static void scx_ops_error_type(enum scx_exit_type type,
-					      const char *fmt, ...)
+__printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
+				       const char *fmt, ...)
 {
 	struct scx_exit_info *ei = &scx_exit_info;
 	int none = SCX_EXIT_NONE;
@@ -2174,6 +2269,14 @@ static int scx_ops_enable(struct sched_ext_ops *ops)
 		goto err_disable;
 	}
 
+	scx_watchdog_timeout = SCX_WATCHDOG_MAX_TIMEOUT;
+	if (ops->timeout_ms)
+		scx_watchdog_timeout = msecs_to_jiffies(ops->timeout_ms);
+
+	scx_watchdog_timestamp = jiffies;
+	queue_delayed_work(system_unbound_wq, &scx_watchdog_work,
+			   scx_watchdog_timeout / 2);
+
 	/*
 	 * Lock out forks before opening the floodgate so that they don't wander
 	 * into the operations prematurely.
@@ -2433,6 +2536,11 @@ static int bpf_scx_init_member(const struct btf_type *t,
 		if (ret == 0)
 			return -EINVAL;
 		return 1;
+	case offsetof(struct sched_ext_ops, timeout_ms):
+		if (*(u32 *)(udata + moff) > SCX_WATCHDOG_MAX_TIMEOUT)
+			return -E2BIG;
+		ops->timeout_ms = *(u32 *)(udata + moff);
+		return 1;
 	}
 
 	return 0;
@@ -2530,9 +2638,11 @@ void __init init_sched_ext_class(void)
 		struct rq *rq = cpu_rq(cpu);
 
 		init_dsq(&rq->scx.local_dsq, SCX_DSQ_LOCAL);
+		INIT_LIST_HEAD(&rq->scx.watchdog_list);
 	}
 
 	register_sysrq_key('S', &sysrq_sched_ext_reset_op);
+	INIT_DELAYED_WORK(&scx_watchdog_work, scx_watchdog_workfn);
 }
 
 
diff --git a/kernel/sched/ext.h b/kernel/sched/ext.h
index f8d5682deacf..7dfa7b888487 100644
--- a/kernel/sched/ext.h
+++ b/kernel/sched/ext.h
@@ -56,6 +56,8 @@ enum scx_deq_flags {
 extern const struct sched_class ext_sched_class;
 extern const struct bpf_verifier_ops bpf_sched_ext_verifier_ops;
 extern const struct file_operations sched_ext_fops;
+extern unsigned long scx_watchdog_timeout;
+extern unsigned long scx_watchdog_timestamp;
 
 DECLARE_STATIC_KEY_FALSE(__scx_ops_enabled);
 #define scx_enabled()		static_branch_unlikely(&__scx_ops_enabled)
@@ -67,6 +69,28 @@ void scx_post_fork(struct task_struct *p);
 void scx_cancel_fork(struct task_struct *p);
 void init_sched_ext_class(void);
 
+__printf(2, 3) void scx_ops_error_type(enum scx_exit_type type,
+				       const char *fmt, ...);
+#define scx_ops_error(fmt, args...)						\
+	scx_ops_error_type(SCX_EXIT_ERROR, fmt, ##args)
+
+static inline void scx_notify_sched_tick(void)
+{
+	unsigned long last_check;
+
+	if (!scx_enabled())
+		return;
+
+	last_check = scx_watchdog_timestamp;
+	if (unlikely(time_after(jiffies, last_check + scx_watchdog_timeout))) {
+		u32 dur_ms = jiffies_to_msecs(jiffies - last_check);
+
+		scx_ops_error_type(SCX_EXIT_ERROR_STALL,
+				   "watchdog failed to check in for %u.%03us",
+				   dur_ms / 1000, dur_ms % 1000);
+	}
+}
+
 static inline const struct sched_class *next_active_class(const struct sched_class *class)
 {
 	class++;
@@ -98,6 +122,7 @@ static inline int scx_fork(struct task_struct *p) { return 0; }
 static inline void scx_post_fork(struct task_struct *p) {}
 static inline void scx_cancel_fork(struct task_struct *p) {}
 static inline void init_sched_ext_class(void) {}
+static inline void scx_notify_sched_tick(void) {}
 
 #define for_each_active_class		for_each_class
 #define for_balance_class_range		for_class_range
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7778f4ce6b5b..112c2f127c95 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -687,6 +687,7 @@ struct cfs_rq {
 #ifdef CONFIG_SCHED_CLASS_EXT
 struct scx_rq {
 	struct scx_dispatch_q	local_dsq;
+	struct list_head	watchdog_list;
 	u64			ops_qseq;
 	u32			nr_running;
 };
diff --git a/tools/sched_ext/scx_example_qmap.bpf.c b/tools/sched_ext/scx_example_qmap.bpf.c
index 06a07c834b42..b22b8d82846e 100644
--- a/tools/sched_ext/scx_example_qmap.bpf.c
+++ b/tools/sched_ext/scx_example_qmap.bpf.c
@@ -22,6 +22,8 @@
 char _license[] SEC("license") = "GPL";
 
 const volatile u64 slice_ns = SCX_SLICE_DFL;
+const volatile u32 stall_user_nth;
+const volatile u32 stall_kernel_nth;
 
 u32 test_error_cnt;
 
@@ -117,11 +119,20 @@ static int weight_to_idx(u32 weight)
 
 void BPF_STRUCT_OPS(qmap_enqueue, struct task_struct *p, u64 enq_flags)
 {
+	static u32 user_cnt, kernel_cnt;
 	struct task_ctx *tctx;
 	u32 pid = p->pid;
 	int idx = weight_to_idx(p->scx.weight);
 	void *ring;
 
+	if (p->flags & PF_KTHREAD) {
+		if (stall_kernel_nth && !(++kernel_cnt % stall_kernel_nth))
+			return;
+	} else {
+		if (stall_user_nth && !(++user_cnt % stall_user_nth))
+			return;
+	}
+
 	if (test_error_cnt && !--test_error_cnt)
 		scx_bpf_error("test triggering error");
 
@@ -234,5 +245,6 @@ struct sched_ext_ops qmap_ops = {
 	.dispatch		= (void *)qmap_dispatch,
 	.prep_enable		= (void *)qmap_prep_enable,
 	.exit			= (void *)qmap_exit,
+	.timeout_ms		= 5000U,
 	.name			= "qmap",
 };
diff --git a/tools/sched_ext/scx_example_qmap.c b/tools/sched_ext/scx_example_qmap.c
index c6c74641a182..dd490a146b1a 100644
--- a/tools/sched_ext/scx_example_qmap.c
+++ b/tools/sched_ext/scx_example_qmap.c
@@ -20,10 +20,12 @@ const char help_fmt[] =
 "\n"
 "See the top-level comment in .bpf.c for more details.\n"
 "\n"
-"Usage: %s [-s SLICE_US] [-e COUNT]\n"
+"Usage: %s [-s SLICE_US] [-e COUNT] [-t COUNT] [-T COUNT]\n"
 "\n"
 "  -s SLICE_US   Override slice duration\n"
 "  -e COUNT      Trigger scx_bpf_error() after COUNT enqueues\n"
+"  -t COUNT      Stall every COUNT'th user thread\n"
+"  -T COUNT      Stall every COUNT'th kernel thread\n"
 "  -h            Display this help and exit\n";
 
 static volatile int exit_req;
@@ -47,13 +49,19 @@ int main(int argc, char **argv)
 	skel = scx_example_qmap__open();
 	assert(skel);
 
-	while ((opt = getopt(argc, argv, "hs:e:tTd:")) != -1) {
+	while ((opt = getopt(argc, argv, "hs:e:t:T:d:")) != -1) {
 		switch (opt) {
 		case 's':
 			skel->rodata->slice_ns = strtoull(optarg, NULL, 0) * 1000;
 			break;
 		case 'e':
-			skel->bss->test_error_cnt = strtoull(optarg, NULL, 0);
+			skel->bss->test_error_cnt = strtoul(optarg, NULL, 0);
+			break;
+		case 't':
+			skel->rodata->stall_user_nth = strtoul(optarg, NULL, 0);
+			break;
+		case 'T':
+			skel->rodata->stall_kernel_nth = strtoul(optarg, NULL, 0);
 			break;
 		default:
 			fprintf(stderr, help_fmt, basename(argv[0]));
-- 
2.39.1

