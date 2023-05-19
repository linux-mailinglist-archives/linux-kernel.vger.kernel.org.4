Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646E8708CD0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjESAT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjESAS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:58 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2491BE1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:36 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-64384c6797eso2092951b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455501; x=1687047501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=joGAwVPVcQFy7FDlG7CBQ2u/DQ455OmkdcCWfnguelY=;
        b=CnIlNJ/Z8M4Rgn+Eb2vs/s+F0sOh9YhYCNuG7/VDRvbnTQ1yalu6MN8uhyHx7OYva5
         e6kvkCf38vwzhP7lrBI2tCqwbQB6+E0DNPfgotudG7jw3492uGnHNu6EfKUdrM0pxZks
         RJU7QxxMIxV4hy1wACxJtKQOxiP3ajNzX3XTF6HHJA1VnO17V+B5m3A9q2NB30nvkeTh
         0LpPYWN9OXou4cjay7SwU2hsMODsE6NgtzHWKOwRKhf/81dFiEr7Z0FHTclk3pwc23PU
         tBAexGCvZfk0DWDLWFdEDO/Nna9X3Vxz5utrCiNCZuJxoDDKwTjmARyX4qI7T3jVR1Su
         xyIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455502; x=1687047502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=joGAwVPVcQFy7FDlG7CBQ2u/DQ455OmkdcCWfnguelY=;
        b=O6BsuBPHk5twLfcvykxujC1jP3YcXFxH2CGQE+Mksg4fc1N8FXwQYpG2OWvwSCU6uu
         iIp4Yzv0/LGH5ry/9gEOMFnx4VXKTiCW9R6lY1lAYs1MFi9jAaA6HAwQu3opCfY+A3Or
         MGwIOMecm3GZzyxEr9ja+g+OMAtHvliTUUh5kbnZZxWOrUGiAbW2yo1TiLW+Fc9MSlWb
         /AL2JSqWEwX/xvdJdgivKZ7bXsOvuevNR54zcN2LYFavq1dWTPhQMLXtVTsl1ffn1hqa
         5pzfFHh+KJ8nSEs0eaNodwvA0xESk/jHbvchCs4QpForyNKF1IOH89yqiA7tqqo/9BXS
         4fLQ==
X-Gm-Message-State: AC+VfDyLDihKKHoI20WXHxE22dON5actJwZLNJ3FJChnDc64j+2OopI0
        r/hz7raKa6uNaD5usV453mA=
X-Google-Smtp-Source: ACHHUZ5hU+6n/qE35W/6wwZp8phX8yQCWoarKZZoriCks8vyxk1ih+yzbVpE8qIM94W390OLSFoujA==
X-Received: by 2002:a05:6a21:6d95:b0:ff:9f85:41e1 with SMTP id wl21-20020a056a216d9500b000ff9f8541e1mr213750pzb.40.1684455501262;
        Thu, 18 May 2023 17:18:21 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id ev23-20020a17090aead700b0023cfdbb6496sm269966pjb.1.2023.05.18.17.18.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:20 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 24/24] workqueue: Implement localize-to-issuing-CPU for unbound workqueues
Date:   Thu, 18 May 2023 14:17:09 -1000
Message-Id: <20230519001709.2563-25-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
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

The non-strict cache affinity scope provides a reasonable default behavior
for improving execution locality while avoiding strict utilization limits
and the overhead of too-fine-grained scopes. However, it ignores L1/2
locality which may benefit some workloads.

This patch implements workqueue_attrs->localize which, when turned on, tries
to put the worker on the work item's issuing CPU when starting execution in
the same way non-strict cache affinity is implemented. As it uses the same
task_struct->wake_cpu, the same caveats apply. It isn't clear whether this
is an acceptable use of the scheduler property and there is a small race
window where the setting from position_worker() may be ignored.

To locate a worker on the work item's issuing CPU, we need to pre-assign the
work item to the worker before waking it up; otherwise, we can't know which
exact worker the work item is going to be assigned to. For work items that
request localization, this patch updates kick_pool() to pre-assign each work
item to an idle worker, exit the worker from the idle state before waking it
up. In turn, worker_thread() directly proceeds to work item execution if
IDLE was already clear when it woke up.

Theoretically, localizing to the issuing CPU without any hard restrictions
should be the best option as it tells the scheduler the best CPU to use for
locality without any restrictions on future scheduler decisions. However, in
practice, this doesn't work out that way due to loss of work conservation.
As such, this patch isn't for upstream yet. See the cover letter for further
discussion.

NOT_FOR_UPSTREAM
---
 Documentation/core-api/workqueue.rst |  38 +++---
 include/linux/workqueue.h            |  10 ++
 kernel/workqueue.c                   | 183 +++++++++++++++++++--------
 tools/workqueue/wq_dump.py           |   7 +-
 tools/workqueue/wq_monitor.py        |   8 +-
 5 files changed, 170 insertions(+), 76 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 4a8e764f41ae..3a7b3b0e7196 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -665,25 +665,25 @@ Monitoring
 Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
 
   $ tools/workqueue/wq_monitor.py events
-                              total  infl  CPUtime  CPUhog CMW/RPR  mayday rescued
-  events                      18545     0      6.1       0       5       -       -
-  events_highpri                  8     0      0.0       0       0       -       -
-  events_long                     3     0      0.0       0       0       -       -
-  events_unbound              38306     0      0.1       -       7       -       -
-  events_freezable                0     0      0.0       0       0       -       -
-  events_power_efficient      29598     0      0.2       0       0       -       -
-  events_freezable_power_        10     0      0.0       0       0       -       -
-  sock_diag_events                0     0      0.0       0       0       -       -
-
-                              total  infl  CPUtime  CPUhog CMW/RPR  mayday rescued
-  events                      18548     0      6.1       0       5       -       -
-  events_highpri                  8     0      0.0       0       0       -       -
-  events_long                     3     0      0.0       0       0       -       -
-  events_unbound              38322     0      0.1       -       7       -       -
-  events_freezable                0     0      0.0       0       0       -       -
-  events_power_efficient      29603     0      0.2       0       0       -       -
-  events_freezable_power_        10     0      0.0       0       0       -       -
-  sock_diag_events                0     0      0.0       0       0       -       -
+                              total  infl  CPUtime  CPUlocal CPUhog CMW/RPR  mayday rescued
+  events                      18545     0      6.1     18545      0       5       -       -
+  events_highpri                  8     0      0.0         8      0       0       -       -
+  events_long                     3     0      0.0         3      0       0       -       -
+  events_unbound              38306     0      0.1      9432      -       7       -       -
+  events_freezable                0     0      0.0         0      0       0       -       -
+  events_power_efficient      29598     0      0.2     29598      0       0       -       -
+  events_freezable_power_        10     0      0.0        10      0       0       -       -
+  sock_diag_events                0     0      0.0         0      0       0       -       -
+
+                              total  infl  CPUtime  CPUlocal CPUhog CMW/RPR  mayday rescued
+  events                      18548     0      6.1     18548      0       5       -       -
+  events_highpri                  8     0      0.0         8      0       0       -       -
+  events_long                     3     0      0.0         3      0       0       -       -
+  events_unbound              38322     0      0.1      9440      -       7       -       -
+  events_freezable                0     0      0.0         0      0       0       -       -
+  events_power_efficient      29603     0      0.2     29063      0       0       -       -
+  events_freezable_power_        10     0      0.0        10      0       0       -       -
+  sock_diag_events                0     0      0.0         0      0       0       -       -
 
   ...
 
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 751eb915e3f0..d989f95f6646 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -197,6 +197,16 @@ struct workqueue_attrs {
 	 */
 	enum wq_affn_scope affn_scope;
 
+	/**
+	 * @localize: always put worker on work item's issuing CPU
+	 *
+	 * When starting execution of a work item, always move the assigned
+	 * worker to the CPU the work item was issued on. The scheduler is free
+	 * to move the worker around afterwards as allowed by the affinity
+	 * scope.
+	 */
+	bool localize;
+
 	/**
 	 * @ordered: work items must be executed one by one in queueing order
 	 */
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4efb0bd6f2e0..b2e914655f05 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -208,6 +208,7 @@ enum pool_workqueue_stats {
 	PWQ_STAT_STARTED,	/* work items started execution */
 	PWQ_STAT_COMPLETED,	/* work items completed execution */
 	PWQ_STAT_CPU_TIME,	/* total CPU time consumed */
+	PWQ_STAT_CPU_LOCAL,	/* work items started on the issuing CPU */
 	PWQ_STAT_CPU_INTENSIVE,	/* wq_cpu_intensive_thresh_us violations */
 	PWQ_STAT_CM_WAKEUP,	/* concurrency-management worker wakeups */
 	PWQ_STAT_REPATRIATED,	/* unbound workers brought back into scope */
@@ -1087,51 +1088,76 @@ static bool assign_work(struct work_struct *work, struct worker *worker,
 }
 
 /**
- * kick_pool - wake up an idle worker if necessary
+ * kick_pool - wake up workers and optionally assign work items to them
  * @pool: pool to kick
  *
- * @pool may have pending work items. Wake up worker if necessary. Returns
- * whether a worker was woken up.
+ * @pool may have pending work items. Either wake up one idle worker or multiple
+ * with work items pre-assigned. See the in-line comments.
  */
 static bool kick_pool(struct worker_pool *pool)
 {
-	struct worker *worker = first_idle_worker(pool);
-	struct task_struct *p;
+	bool woken_up = false;
+	struct worker *worker;
 
 	lockdep_assert_held(&pool->lock);
 
-	if (!need_more_worker(pool) || !worker)
-		return false;
-
-	p = worker->task;
-
+	while (need_more_worker(pool) && (worker = first_idle_worker(pool))) {
+		struct task_struct *p = worker->task;
 #ifdef CONFIG_SMP
-	/*
-	 * Idle @worker is about to execute @work and waking up provides an
-	 * opportunity to migrate @worker at a lower cost by setting the task's
-	 * wake_cpu field. Let's see if we want to move @worker to improve
-	 * execution locality.
-	 *
-	 * We're waking the worker that went idle the latest and there's some
-	 * chance that @worker is marked idle but hasn't gone off CPU yet. If
-	 * so, setting the wake_cpu won't do anything. As this is a best-effort
-	 * optimization and the race window is narrow, let's leave as-is for
-	 * now. If this becomes pronounced, we can skip over workers which are
-	 * still on cpu when picking an idle worker.
-	 *
-	 * If @pool has non-strict affinity, @worker might have ended up outside
-	 * its affinity scope. Repatriate.
-	 */
-	if (!pool->attrs->affn_strict &&
-	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
 		struct work_struct *work = list_first_entry(&pool->worklist,
 						struct work_struct, entry);
-		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
-		get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
-	}
+		struct pool_workqueue *pwq = get_work_pwq(work);
+		struct workqueue_struct *wq = pwq->wq;
+
+		/*
+		 * Idle @worker is about to execute @work and waking up provides
+		 * an opportunity to migrate @worker at a lower cost by setting
+		 * the task's wake_cpu field. Let's see if we want to move
+		 * @worker to improve execution locality.
+		 *
+		 * We're waking the worker that went idle the latest and there's
+		 * some chance that @worker is marked idle but hasn't gone off
+		 * CPU yet. If so, setting the wake_cpu won't do anything. As
+		 * this is a best-effort optimization and the race window is
+		 * narrow, let's leave as-is for now. If this becomes
+		 * pronounced, we can skip over workers which are still on cpu
+		 * when picking an idle worker.
+		 */
+
+		/*
+		 * If @work's workqueue requests localization, @work has CPU
+		 * assigned and there are enough idle workers, pre-assign @work
+		 * to @worker and tell the scheduler to try to wake up @worker
+		 * on @work's issuing CPU. Be careful that ->localize is a
+		 * workqueue attribute, not a pool one.
+		 */
+		if (wq->unbound_attrs && wq->unbound_attrs->localize &&
+		    pwq->cpu >= 0 && pool->nr_idle > 1) {
+			if (assign_work(work, worker, NULL)) {
+				worker_leave_idle(worker);
+				p->wake_cpu = pwq->cpu;
+				wake_up_process(worker->task);
+				woken_up = true;
+				continue;
+			}
+		}
+
+		/*
+		 * If @pool has non-strict affinity, @worker might have ended up
+		 * outside its affinity scope. Repatriate.
+		 */
+		if (!pool->attrs->affn_strict &&
+		    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
+			p->wake_cpu = cpumask_any_distribute(
+						pool->attrs->__pod_cpumask);
+			pwq->stats[PWQ_STAT_REPATRIATED]++;
+		}
 #endif
-	wake_up_process(p);
-	return true;
+		wake_up_process(p);
+		return true;
+	}
+
+	return woken_up;
 }
 
 #ifdef CONFIG_WQ_CPU_INTENSIVE_REPORT
@@ -2607,6 +2633,8 @@ __acquires(&pool->lock)
 	 */
 	lockdep_invariant_state(true);
 	pwq->stats[PWQ_STAT_STARTED]++;
+	if (pwq->cpu == smp_processor_id())
+		pwq->stats[PWQ_STAT_CPU_LOCAL]++;
 	trace_workqueue_execute_start(work);
 	worker->current_func(work);
 	/*
@@ -2730,22 +2758,26 @@ static int worker_thread(void *__worker)
 		return 0;
 	}
 
-	worker_leave_idle(worker);
-recheck:
-	/* no more worker necessary? */
-	if (!need_more_worker(pool))
-		goto sleep;
-
-	/* do we need to manage? */
-	if (unlikely(!may_start_working(pool)) && manage_workers(worker))
-		goto recheck;
-
 	/*
-	 * ->scheduled list can only be filled while a worker is
-	 * preparing to process a work or actually processing it.
-	 * Make sure nobody diddled with it while I was sleeping.
+	 * If kick_pool() assigned a work item to us, it made sure that there
+	 * are other idle workers to serve the manager role and moved us out of
+	 * the idle state already. If IDLE is clear, skip manager check and
+	 * start executing the work items on @worker->scheduled right away.
 	 */
-	WARN_ON_ONCE(!list_empty(&worker->scheduled));
+	if (worker->flags & WORKER_IDLE) {
+		WARN_ON_ONCE(!list_empty(&worker->scheduled));
+		worker_leave_idle(worker);
+
+		while (true) {
+			/* no more worker necessary? */
+			if (!need_more_worker(pool))
+				goto sleep;
+			/* do we need to manage? */
+			if (likely(may_start_working(pool)) ||
+			    !manage_workers(worker))
+				break;
+		}
+	}
 
 	/*
 	 * Finish PREP stage.  We're guaranteed to have at least one idle
@@ -2756,14 +2788,31 @@ static int worker_thread(void *__worker)
 	 */
 	worker_clr_flags(worker, WORKER_PREP | WORKER_REBOUND);
 
-	do {
-		struct work_struct *work =
-			list_first_entry(&pool->worklist,
-					 struct work_struct, entry);
+	/*
+	 * If we woke up with IDLE cleared, there may already be work items on
+	 * ->scheduled. Always run process_scheduled_works() at least once. Note
+	 * that ->scheduled can be empty even after !IDLE wake-up as the
+	 * scheduled work item could have been canceled in-between.
+	 */
+	process_scheduled_works(worker);
 
-		if (assign_work(work, worker, NULL))
-			process_scheduled_works(worker);
-	} while (keep_working(pool));
+	/*
+	 * For unbound workqueues, the following keep_working() would be true
+	 * only when there are worker shortages. Otherwise, work items would
+	 * have been assigned to workers on queueing.
+	 */
+	while (keep_working(pool)) {
+		struct work_struct *work = list_first_entry(&pool->worklist,
+						struct work_struct, entry);
+		/*
+		 * An unbound @worker here might not be on the same CPU as @work
+		 * which is unfortunate if the workqueue has localization turned
+		 * on. However, it shouldn't be a problem in practice as this
+		 * path isn't taken often for unbound workqueues.
+		 */
+		assign_work(work, worker, NULL);
+		process_scheduled_works(worker);
+	}
 
 	worker_set_flags(worker, WORKER_PREP);
 sleep:
@@ -3737,6 +3786,7 @@ static void copy_workqueue_attrs(struct workqueue_attrs *to,
 	 * get_unbound_pool() explicitly clears the fields.
 	 */
 	to->affn_scope = from->affn_scope;
+	to->localize = from->localize;
 	to->ordered = from->ordered;
 }
 
@@ -4020,6 +4070,7 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
 
 	/* clear wq-only attr fields. See 'struct workqueue_attrs' comments */
 	pool->attrs->affn_scope = WQ_AFFN_NR_TYPES;
+	pool->attrs->localize = false;
 	pool->attrs->ordered = false;
 
 	if (worker_pool_assign_id(pool) < 0)
@@ -5832,6 +5883,7 @@ module_param_cb(default_affinity_scope, &wq_affn_dfl_ops, NULL, 0644);
  *  cpumask		RW mask	: bitmask of allowed CPUs for the workers
  *  affinity_scope	RW str  : worker CPU affinity scope (cache, numa, none)
  *  affinity_strict	RW bool : worker CPU affinity is strict
+ *  localize		RW bool : localize worker to work's origin CPU
  */
 struct wq_device {
 	struct workqueue_struct		*wq;
@@ -6042,11 +6094,34 @@ static ssize_t wq_affinity_strict_store(struct device *dev,
 	return ret ?: count;
 }
 
+static ssize_t wq_localize_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct workqueue_struct *wq = dev_to_wq(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n", wq->unbound_attrs->localize);
+}
+
+static ssize_t wq_localize_store(struct device *dev,
+				 struct device_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct workqueue_struct *wq = dev_to_wq(dev);
+	int v;
+
+	if (sscanf(buf, "%d", &v) != 1)
+		return -EINVAL;
+
+	wq->unbound_attrs->localize = v;
+	return count;
+}
+
 static struct device_attribute wq_sysfs_unbound_attrs[] = {
 	__ATTR(nice, 0644, wq_nice_show, wq_nice_store),
 	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store),
 	__ATTR(affinity_scope, 0644, wq_affn_scope_show, wq_affn_scope_store),
 	__ATTR(affinity_strict, 0644, wq_affinity_strict_show, wq_affinity_strict_store),
+	__ATTR(localize, 0644, wq_localize_show, wq_localize_store),
 	__ATTR_NULL,
 };
 
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index d0df5833f2c1..036fb89260a3 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -41,6 +41,7 @@ Lists all workqueues along with their type and worker pool association. For
   NAME      name of the workqueue
   TYPE      percpu, unbound or ordered
   FLAGS     S: strict affinity scope
+            L: localize worker to work item's issuing CPU
   POOL_ID   worker pool ID associated with each possible CPU
 """
 
@@ -160,8 +161,10 @@ print(' dfl]')
             print(' ordered   ', end='')
         else:
             print(' unbound', end='')
-            if wq.unbound_attrs.affn_strict:
-                print(',S ', end='')
+            strict = wq.unbound_attrs.affn_strict
+            local = wq.unbound_attrs.localize
+            if strict or local:
+                print(f',{"S" if strict else "_"}{"L" if local else "_"}', end='')
             else:
                 print('   ', end='')
     else:
diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
index a8856a9c45dc..a0b0cd50b629 100644
--- a/tools/workqueue/wq_monitor.py
+++ b/tools/workqueue/wq_monitor.py
@@ -15,6 +15,9 @@ https://github.com/osandov/drgn.
            sampled from scheduler ticks and only provides ballpark
            measurement. "nohz_full=" CPUs are excluded from measurement.
 
+  CPUlocl  The number of times a work item starts executing on the same CPU
+           that the work item was issued on.
+
   CPUitsv  The number of times a concurrency-managed work item hogged CPU
            longer than the threshold (workqueue.cpu_intensive_thresh_us)
            and got excluded from concurrency management to avoid stalling
@@ -66,6 +69,7 @@ WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
 PWQ_STAT_STARTED        = prog['PWQ_STAT_STARTED']      # work items started execution
 PWQ_STAT_COMPLETED      = prog['PWQ_STAT_COMPLETED']	# work items completed execution
 PWQ_STAT_CPU_TIME       = prog['PWQ_STAT_CPU_TIME']     # total CPU time consumed
+PWQ_STAT_CPU_LOCAL      = prog['PWQ_STAT_CPU_LOCAL']    # work items started on the issuing CPU
 PWQ_STAT_CPU_INTENSIVE  = prog['PWQ_STAT_CPU_INTENSIVE'] # wq_cpu_intensive_thresh_us violations
 PWQ_STAT_CM_WAKEUP      = prog['PWQ_STAT_CM_WAKEUP']    # concurrency-management worker wakeups
 PWQ_STAT_REPATRIATED    = prog['PWQ_STAT_REPATRIATED']  # unbound workers brought back into scope
@@ -91,6 +95,7 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
                  'started'              : self.stats[PWQ_STAT_STARTED],
                  'completed'            : self.stats[PWQ_STAT_COMPLETED],
                  'cpu_time'             : self.stats[PWQ_STAT_CPU_TIME],
+                 'cpu_local'            : self.stats[PWQ_STAT_CPU_LOCAL],
                  'cpu_intensive'        : self.stats[PWQ_STAT_CPU_INTENSIVE],
                  'cm_wakeup'            : self.stats[PWQ_STAT_CM_WAKEUP],
                  'repatriated'          : self.stats[PWQ_STAT_REPATRIATED],
@@ -98,7 +103,7 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
                  'rescued'              : self.stats[PWQ_STAT_RESCUED], }
 
     def table_header_str():
-        return f'{"":>24} {"total":>8} {"infl":>5} {"CPUtime":>8} '\
+        return f'{"":>24} {"total":>8} {"infl":>5} {"CPUtime":>8} {"CPUlocal":>8} '\
             f'{"CPUitsv":>7} {"CMW/RPR":>7} {"mayday":>7} {"rescued":>7}'
 
     def table_row_str(self):
@@ -121,6 +126,7 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
               f'{self.stats[PWQ_STAT_STARTED]:8} ' \
               f'{max(self.stats[PWQ_STAT_STARTED] - self.stats[PWQ_STAT_COMPLETED], 0):5} ' \
               f'{self.stats[PWQ_STAT_CPU_TIME] / 1000000:8.1f} ' \
+              f'{self.stats[PWQ_STAT_CPU_LOCAL]:8} ' \
               f'{cpu_intensive:>7} ' \
               f'{cmw_rpr:>7} ' \
               f'{mayday:>7} ' \
-- 
2.40.1

