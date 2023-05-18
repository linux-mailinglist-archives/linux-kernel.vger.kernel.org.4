Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C84707849
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 05:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229835AbjERDB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 23:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjERDBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 23:01:02 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FC71982
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:58 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-51f6461af24so994412a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 20:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684378858; x=1686970858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6vWn9Lx96vURD4HIemcly9P0Sbhst5wEsNzzf7bjYr0=;
        b=YA3fI3O8j0K5zdYmSxdOmjg1qXeOv6UFvUj4juu7JNurTiD+wIcG4HINVDVx4DvDZ8
         mWPE9wWTlt7N61U5PtJIth5JMJ8kLkWPlWupgGmpqXusjH/WRKhL6PbjQBiJCbzLV9ZQ
         FelrIGroDz2zp7zBsw9SfK8hA+YHI3cWmqcx5NfFpv44d7q38TW6HJU+hYzDr18ubJSC
         d0HnGVg6uEBVwrImo1P+q3BZxAOama9f35xDgu1GAHNirLhlcxmom5UEckQZjjc1HMSl
         oW67/gjVC40NN4rZg2/Byv49FAStdm7B58CewGFLxlBlIWRGAnX25zRFm2uFlgwm2geX
         9dNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684378858; x=1686970858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6vWn9Lx96vURD4HIemcly9P0Sbhst5wEsNzzf7bjYr0=;
        b=jKC3JZpwgtK9b2oaxBaewhhuipsMXJd6AbIsfBnP7uBwpVPUKNS2EL19aTNbtSQqKf
         ukGLgx6Ohhw1vGxyjVaa9jX77p/GZS76FtAO57Jrgo6ob88qtwtExUMMTk32t3xj0HmU
         FDqOYVj262tm4ar4/+1LtCnB327Zg7kStCH2cF9wLcybUuyYVEkLtqkG6+SZOu1ChXBY
         mpNw/GqbiRf35zlwa4G2dpYiM3sP7vw50qWj7UUBjfouEEakc2sNh3DgFw1Sc4itivZz
         n2xjCVAKFEK1WQwkqBDNO9+E7lTHlHEnsXONTUgJhK9la7RMxHh0tw34Sc0gKgdzHhW9
         u94Q==
X-Gm-Message-State: AC+VfDxJLFreYolG15zuf+kLN40KsmSM5JT7aGb6/PmdarDTj+1EGKbE
        G4na/LFOSGmBxWTLejKj/uE=
X-Google-Smtp-Source: ACHHUZ4uO1eKLvxpo/cbzKBEQ6Qd0KJsHo+ADo8d2XHQbv9A+wOweC6AN/aPes/KeERr+CQetGTBdQ==
X-Received: by 2002:a17:902:e5c8:b0:1ac:4fb3:1693 with SMTP id u8-20020a170902e5c800b001ac4fb31693mr1005716plf.52.1684378858220;
        Wed, 17 May 2023 20:00:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:1c2f])
        by smtp.gmail.com with ESMTPSA id a10-20020a170902ee8a00b001ab1cdb41d6sm94963pld.235.2023.05.17.20.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 20:00:57 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 5/7] workqueue: Automatically mark CPU-hogging work items CPU_INTENSIVE
Date:   Wed, 17 May 2023 17:00:31 -1000
Message-Id: <20230518030033.4163274-6-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518030033.4163274-1-tj@kernel.org>
References: <20230518030033.4163274-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a per-cpu work item hogs the CPU, it can prevent other work items from
starting through concurrency management. A per-cpu workqueue which intends
to host such CPU-hogging work items can choose to not participate in
concurrency management by setting %WQ_CPU_INTENSIVE; however, this can be
error-prone and difficult to debug when missed.

This patch adds an automatic CPU usage based detection. If a
concurrency-managed work item consumes more CPU time than the threshold
(10ms by default) continuously without intervening sleeps, wq_worker_tick()
which is called from scheduler_tick() will detect the condition and
automatically mark it CPU_INTENSIVE.

The mechanism isn't foolproof:

* Detection depends on tick hitting the work item. Getting preempted at the
  right timings may allow a violating work item to evade detection at least
  temporarily.

* nohz_full CPUs may not be running ticks and thus can fail detection.

* Even when detection is working, the 10ms detection delays can add up if
  many CPU-hogging work items are queued at the same time.

However, in vast majority of cases, this should be able to detect violations
reliably and provide reasonable protection with a small increase in code
complexity.

If some work items trigger this condition repeatedly, the bigger problem
likely is the CPU being saturated with such per-cpu work items and the
solution would be making them UNBOUND. The next patch will add a debug
mechanism to help spot such cases.

v4: Documentation for workqueue.cpu_intensive_thresh_us added to
    kernel-parameters.txt.

v3: Switch to use wq_worker_tick() instead of hooking into preemptions as
    suggested by Peter.

v2: Lai pointed out that wq_worker_stopping() also needs to be called from
    preemption and rtlock paths and an earlier patch was updated
    accordingly. This patch adds a comment describing the risk of infinte
    recursions and how they're avoided.

Signed-off-by: Tejun Heo <tj@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 .../admin-guide/kernel-parameters.txt         |  7 ++
 Documentation/core-api/workqueue.rst          | 38 +++++------
 kernel/sched/core.c                           |  3 +
 kernel/workqueue.c                            | 68 +++++++++++++++++--
 kernel/workqueue_internal.h                   |  2 +
 tools/workqueue/wq_monitor.py                 | 13 +++-
 6 files changed, 106 insertions(+), 25 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..1f2185cf2f0a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6931,6 +6931,13 @@
 			it can be updated at runtime by writing to the
 			corresponding sysfs file.
 
+	workqueue.cpu_intensive_thresh_us=
+			Per-cpu work items which run for longer than this
+			threshold are automatically considered CPU intensive
+			and excluded from concurrency management to prevent
+			them from noticeably delaying other per-cpu work
+			items. Default is 10000 (10ms).
+
 	workqueue.disable_numa
 			By default, all work items queued to unbound
 			workqueues are affine to the NUMA nodes they're
diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 7e5c39310bbf..a389f31b025c 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -354,25 +354,25 @@ Monitoring
 Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
 
   $ tools/workqueue/wq_monitor.py events
-                              total  infl  CMwake  mayday rescued
-  events                      18545     0       5       -       -
-  events_highpri                  8     0       0       -       -
-  events_long                     3     0       0       -       -
-  events_unbound              38306     0       -       -       -
-  events_freezable                0     0       0       -       -
-  events_power_efficient      29598     0       0       -       -
-  events_freezable_power_        10     0       0       -       -
-  sock_diag_events                0     0       0       -       -
-
-                              total  infl  CMwake  mayday rescued
-  events                      18548     0       5       -       -
-  events_highpri                  8     0       0       -       -
-  events_long                     3     0       0       -       -
-  events_unbound              38322     0       -       -       -
-  events_freezable                0     0       0       -       -
-  events_power_efficient      29603     0       0       -       -
-  events_freezable_power_        10     0       0       -       -
-  sock_diag_events                0     0       0       -       -
+                              total  infl CPUitsv  CMwake  mayday rescued
+  events                      18545     0       0       5       -       -
+  events_highpri                  8     0       0       0       -       -
+  events_long                     3     0       0       0       -       -
+  events_unbound              38306     0       -       -       -       -
+  events_freezable                0     0       0       0       -       -
+  events_power_efficient      29598     0       0       0       -       -
+  events_freezable_power_        10     0       0       0       -       -
+  sock_diag_events                0     0       0       0       -       -
+
+                              total  infl CPUitsv  CMwake  mayday rescued
+  events                      18548     0       0       5       -       -
+  events_highpri                  8     0       0       0       -       -
+  events_long                     3     0       0       0       -       -
+  events_unbound              38322     0       -       -       -       -
+  events_freezable                0     0       0       0       -       -
+  events_power_efficient      29603     0       0       0       -       -
+  events_freezable_power_        10     0       0       0       -       -
+  sock_diag_events                0     0       0       0       -       -
 
   ...
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae39861..3484cada9a4a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5632,6 +5632,9 @@ void scheduler_tick(void)
 
 	perf_event_task_tick();
 
+	if (curr->flags & PF_WQ_WORKER)
+		wq_worker_tick(curr);
+
 #ifdef CONFIG_SMP
 	rq->idle_balance = idle_cpu(cpu);
 	trigger_load_balance(rq);
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 942421443603..3dc83d5eba50 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -212,6 +212,7 @@ struct worker_pool {
 enum pool_workqueue_stats {
 	PWQ_STAT_STARTED,	/* work items started execution */
 	PWQ_STAT_COMPLETED,	/* work items completed execution */
+	PWQ_STAT_CPU_INTENSIVE,	/* wq_cpu_intensive_thresh_us violations */
 	PWQ_STAT_CM_WAKEUP,	/* concurrency-management worker wakeups */
 	PWQ_STAT_MAYDAY,	/* maydays to rescuer */
 	PWQ_STAT_RESCUED,	/* linked work items executed by rescuer */
@@ -332,6 +333,14 @@ static struct kmem_cache *pwq_cache;
 static cpumask_var_t *wq_numa_possible_cpumask;
 					/* possible CPUs of each node */
 
+/*
+ * Per-cpu work items which run for longer than the following threshold are
+ * automatically considered CPU intensive and excluded from concurrency
+ * management to prevent them from noticeably delaying other per-cpu work items.
+ */
+static unsigned long wq_cpu_intensive_thresh_us = 10000;
+module_param_named(cpu_intensive_thresh_us, wq_cpu_intensive_thresh_us, ulong, 0644);
+
 static bool wq_disable_numa;
 module_param_named(disable_numa, wq_disable_numa, bool, 0444);
 
@@ -962,6 +971,13 @@ void wq_worker_running(struct task_struct *task)
 	if (!(worker->flags & WORKER_NOT_RUNNING))
 		worker->pool->nr_running++;
 	preempt_enable();
+
+	/*
+	 * CPU intensive auto-detection cares about how long a work item hogged
+	 * CPU without sleeping. Reset the starting timestamp on wakeup.
+	 */
+	worker->current_at = worker->task->se.sum_exec_runtime;
+
 	worker->sleeping = 0;
 }
 
@@ -1012,6 +1028,45 @@ void wq_worker_sleeping(struct task_struct *task)
 	raw_spin_unlock_irq(&pool->lock);
 }
 
+/**
+ * wq_worker_tick - a scheduler tick occurred while a kworker is running
+ * @task: task currently running
+ *
+ * Called from scheduler_tick(). We're in the IRQ context and the current
+ * worker's fields which follow the 'K' locking rule can be accessed safely.
+ */
+void wq_worker_tick(struct task_struct *task)
+{
+	struct worker *worker = kthread_data(task);
+	struct pool_workqueue *pwq = worker->current_pwq;
+	struct worker_pool *pool = worker->pool;
+
+	if (!pwq)
+		return;
+
+	/*
+	 * If the current worker is concurrency managed and hogged the CPU for
+	 * longer than wq_cpu_intensive_thresh_us, it's automatically marked
+	 * CPU_INTENSIVE to avoid stalling other concurrency-managed work items.
+	 */
+	if ((worker->flags & WORKER_NOT_RUNNING) ||
+	    worker->task->se.sum_exec_runtime - worker->current_at <
+	    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
+		return;
+
+	raw_spin_lock(&pool->lock);
+
+	worker_set_flags(worker, WORKER_CPU_INTENSIVE);
+	pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;
+
+	if (need_more_worker(pool)) {
+		pwq->stats[PWQ_STAT_CM_WAKEUP]++;
+		wake_up_worker(pool);
+	}
+
+	raw_spin_unlock(&pool->lock);
+}
+
 /**
  * wq_worker_last_func - retrieve worker's last work function
  * @task: Task to retrieve last work function of.
@@ -2327,7 +2382,6 @@ __acquires(&pool->lock)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
 	struct worker_pool *pool = worker->pool;
-	bool cpu_intensive = pwq->wq->flags & WQ_CPU_INTENSIVE;
 	unsigned long work_data;
 	struct worker *collision;
 #ifdef CONFIG_LOCKDEP
@@ -2364,6 +2418,7 @@ __acquires(&pool->lock)
 	worker->current_work = work;
 	worker->current_func = work->func;
 	worker->current_pwq = pwq;
+	worker->current_at = worker->task->se.sum_exec_runtime;
 	work_data = *work_data_bits(work);
 	worker->current_color = get_work_color(work_data);
 
@@ -2381,7 +2436,7 @@ __acquires(&pool->lock)
 	 * of concurrency management and the next code block will chain
 	 * execution of the pending work items.
 	 */
-	if (unlikely(cpu_intensive))
+	if (unlikely(pwq->wq->flags & WQ_CPU_INTENSIVE))
 		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
 
 	/*
@@ -2461,9 +2516,12 @@ __acquires(&pool->lock)
 
 	raw_spin_lock_irq(&pool->lock);
 
-	/* clear cpu intensive status */
-	if (unlikely(cpu_intensive))
-		worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
+	/*
+	 * In addition to %WQ_CPU_INTENSIVE, @worker may also have been marked
+	 * CPU intensive by wq_worker_tick() if @work hogged CPU longer than
+	 * wq_cpu_intensive_thresh_us. Clear it.
+	 */
+	worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
 
 	/* tag the worker for identification in schedule() */
 	worker->last_func = worker->current_func;
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index c2455be7b4c2..6b1d66e28269 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -31,6 +31,7 @@ struct worker {
 	struct work_struct	*current_work;	/* K: work being processed and its */
 	work_func_t		current_func;	/* K: function */
 	struct pool_workqueue	*current_pwq;	/* K: pwq */
+	u64			current_at;	/* K: runtime at start or last wakeup */
 	unsigned int		current_color;	/* K: color */
 
 	int			sleeping;	/* S: is worker sleeping? */
@@ -76,6 +77,7 @@ static inline struct worker *current_wq_worker(void)
  */
 void wq_worker_running(struct task_struct *task);
 void wq_worker_sleeping(struct task_struct *task);
+void wq_worker_tick(struct task_struct *task);
 work_func_t wq_worker_last_func(struct task_struct *task);
 
 #endif /* _KERNEL_WORKQUEUE_INTERNAL_H */
diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
index fc1643ba06b3..7c6f523b9164 100644
--- a/tools/workqueue/wq_monitor.py
+++ b/tools/workqueue/wq_monitor.py
@@ -11,6 +11,11 @@ https://github.com/osandov/drgn.
 
   infl     The number of currently in-flight work items.
 
+  CPUitsv  The number of times a concurrency-managed work item hogged CPU
+           longer than the threshold (workqueue.cpu_intensive_thresh_us)
+           and got excluded from concurrency management to avoid stalling
+           other work items.
+
   CMwake   The number of concurrency-management wake-ups while executing a
            work item of the workqueue.
 
@@ -53,6 +58,7 @@ WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
 
 PWQ_STAT_STARTED        = prog['PWQ_STAT_STARTED']      # work items started execution
 PWQ_STAT_COMPLETED      = prog['PWQ_STAT_COMPLETED']	# work items completed execution
+PWQ_STAT_CPU_INTENSIVE  = prog['PWQ_STAT_CPU_INTENSIVE'] # wq_cpu_intensive_thresh_us violations
 PWQ_STAT_CM_WAKEUP      = prog['PWQ_STAT_CM_WAKEUP']    # concurrency-management worker wakeups
 PWQ_STAT_MAYDAY         = prog['PWQ_STAT_MAYDAY']	# maydays to rescuer
 PWQ_STAT_RESCUED        = prog['PWQ_STAT_RESCUED']	# linked work items executed by rescuer
@@ -75,19 +81,23 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
                  'mem_reclaim'          : self.mem_reclaim,
                  'started'              : self.stats[PWQ_STAT_STARTED],
                  'completed'            : self.stats[PWQ_STAT_COMPLETED],
+                 'cpu_intensive'        : self.stats[PWQ_STAT_CPU_INTENSIVE],
                  'cm_wakeup'            : self.stats[PWQ_STAT_CM_WAKEUP],
                  'mayday'               : self.stats[PWQ_STAT_MAYDAY],
                  'rescued'              : self.stats[PWQ_STAT_RESCUED], }
 
     def table_header_str():
-        return f'{"":>24} {"total":>8} {"infl":>5} {"CMwake":>7} {"mayday":>7} {"rescued":>7}'
+        return f'{"":>24} {"total":>8} {"infl":>5} '\
+            f'{"CPUitsv":>7} {"CMwake":>7} {"mayday":>7} {"rescued":>7}'
 
     def table_row_str(self):
+        cpu_intensive = '-'
         cm_wakeup = '-'
         mayday = '-'
         rescued = '-'
 
         if not self.unbound:
+            cpu_intensive = str(self.stats[PWQ_STAT_CPU_INTENSIVE])
             cm_wakeup = str(self.stats[PWQ_STAT_CM_WAKEUP])
 
         if self.mem_reclaim:
@@ -97,6 +107,7 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
         out = f'{self.name[-24:]:24} ' \
               f'{self.stats[PWQ_STAT_STARTED]:8} ' \
               f'{max(self.stats[PWQ_STAT_STARTED] - self.stats[PWQ_STAT_COMPLETED], 0):5} ' \
+              f'{cpu_intensive:>7} ' \
               f'{cm_wakeup:>7} ' \
               f'{mayday:>7} ' \
               f'{rescued:>7} '
-- 
2.40.1

