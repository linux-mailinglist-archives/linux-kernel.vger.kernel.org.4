Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A26F708CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjESATe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231178AbjESAS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:56 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF21991
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:32 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1ae5dc9eac4so14717635ad.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455496; x=1687047496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zkZtLQuErefJawKFSbPbL/we8iYilRNyxhefO3dKqWY=;
        b=TOXj6Ie9mXX3Bd+HeUr0iSFla0b53tv55+ilgb1gAuphTcPacCvVcvL7hNJc9aC6ce
         g31DZiKEGPik+L72fI2PWdGP9X4sMWlxq6b1LVBq7F4qYAS10yXY0HPD/Whuu5ywtas6
         jvzEpYEFxFJdpUMo5BY69t0Rjl11ILbCFSA4a+O6i5GIRUJ1++YYYfqr2zdXdrAe4wJS
         WeG81LT2n42mfzqTCIQNM7mHcnnApElw6+jYOKKsKBnf1I8JzoiAOYgNqw2x3mkxw3uL
         3WUBV3VsFe/Kfjro90TLK3eW+O4llGuMdcaQhcEYe2r1UYGBgbIkWdXb+qEqJ0AAJ+RJ
         G1eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455496; x=1687047496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zkZtLQuErefJawKFSbPbL/we8iYilRNyxhefO3dKqWY=;
        b=J0xxCZujtektgLstTR6NrmTEn7R6iAstZkHGOyw9ytPbBjdEW/hVLQPbK0JQZpjd36
         6p/HGDdWUkaXS91SKsQ+G42Av3ZRufO0wPCirXRWhlpxqK7M+MlKjTfrOQMTNDdoPMxl
         +YDkmIsbTOu9anq1AgkVUFhbRh8CR9ooAlURNuadJyKCYlP1GgnaCq7QMMTZbDcyfMOS
         RS/tA1cdnH1pn8iQLnjsyjAwn6gq6FVlqC/ST9oRMqTfRoQCojFjpvQw5yysFNTh1QZo
         9L1gx51WARiRQkHY6UKu9AnOR4BOA3fMbUH9J9L2oOkF+9gLcp36ELU/XAPVcmS/htd6
         /mmw==
X-Gm-Message-State: AC+VfDx7WvkfsHNxqZ7pF5io1IBtIDldLe8r1YYFDC3Dh80KBEYl8JsZ
        abSPPhVx2KNmnzdPl3e/8eE=
X-Google-Smtp-Source: ACHHUZ4RbpUdVLopTtQPcxWVrNc7m02Lq3NjYpn/KZf0lzA9YSVdi/J+tQHyeRRvKk9XOfIRVXFrkA==
X-Received: by 2002:a17:902:ef94:b0:1ab:1241:f671 with SMTP id iz20-20020a170902ef9400b001ab1241f671mr792359plb.29.1684455495717;
        Thu, 18 May 2023 17:18:15 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id s19-20020a170902a51300b001ac381f1ce9sm2043835plq.185.2023.05.18.17.18.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:15 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 21/24] workqueue: Implement non-strict affinity scope for unbound workqueues
Date:   Thu, 18 May 2023 14:17:06 -1000
Message-Id: <20230519001709.2563-22-tj@kernel.org>
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

An unbound workqueue can be served by multiple worker_pools to improve
locality. The segmentation is achieved by grouping CPUs into pods. By
default, the cache boundaries according to cpus_share_cache() define the
CPUs are grouped. Let's a workqueue is allowed to run on all CPUs and the
system has two L3 caches. The workqueue would be mapped to two worker_pools
each serving one L3 cache domains.

While this improves locality, because the pod boundaries are strict, it
limits the total bandwidth a given issuer can consume. For example, let's
say there is a thread pinned to a CPU issuing enough work items to saturate
the whole machine. With the machine segmented into two pods, no matter how
many work items it issues, it can only use half of the CPUs on the system.

While this limitation has existed for a very long time, it wasn't very
pronounced because the affinity grouping used to be always by NUMA nodes.
With cache boundaries as the default and support for even finer grained
scopes (smt and cpu), it is now an a lot more pressing problem.

This patch implements non-strict affinity scope where the pod boundaries
aren't enforced strictly. Going back to the previous example, the workqueue
would still be mapped to two worker_pools; however, the affinity enforcement
would be soft. The workers in both pools would have their cpus_allowed set
to the whole machine thus allowing the scheduler to migrate them anywhere on
the machine. However, whenever an idle worker is woken up, the workqueue
code asks the scheduler to bring back the task within the pod if the worker
is outside. ie. work items start executing within its affinity scope but can
be migrated outside as the scheduler sees fit. This removes the hard cap on
utilization while maintaining the benefits of affinity scopes.

After the earlier ->__pod_cpumask changes, the implementation is pretty
simple. When non-strict which is the new default:

* pool_allowed_cpus() returns @pool->attrs->cpumask instead of
  ->__pod_cpumask so that the workers are allowed to run on any CPU that
  the associated workqueues allow.

* If the idle worker task's ->wake_cpu is outside the pod, kick_pool() sets
  the field to a CPU within the pod.

This would be the first use of task_struct->wake_cpu outside scheduler
proper, so it isn't clear whether this would be acceptable. However, other
methods of migrating tasks are significantly more expensive and are likely
prohibitively so if we want to do this on every work item. This needs
discussion with scheduler folks.

There is also a race window where setting ->wake_cpu wouldn't be effective
as the target task is still on CPU. However, the window is pretty small and
this being a best-effort optimization, it doesn't seem to warrant more
complexity at the moment.

While the non-strict cache affinity scopes seem to be the best option, the
performance picture interacts with the affinity scope and is a bit
complicated to fully discuss in this patch, so the behavior is made easily
selectable through wqattrs and sysfs and the next patch will add
documentation to discuss performance implications.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 Documentation/core-api/workqueue.rst | 30 +++++++++---
 include/linux/workqueue.h            | 11 +++++
 kernel/workqueue.c                   | 73 +++++++++++++++++++++++++++-
 tools/workqueue/wq_dump.py           | 16 ++++--
 tools/workqueue/wq_monitor.py        | 21 +++++---
 5 files changed, 131 insertions(+), 20 deletions(-)

diff --git a/Documentation/core-api/workqueue.rst b/Documentation/core-api/workqueue.rst
index 56af317508c9..c73a6df6a118 100644
--- a/Documentation/core-api/workqueue.rst
+++ b/Documentation/core-api/workqueue.rst
@@ -353,9 +353,10 @@ Affinity Scopes
 An unbound workqueue groups CPUs according to its affinity scope to improve
 cache locality. For example, if a workqueue is using the default affinity
 scope of "cache", it will group CPUs according to last level cache
-boundaries. A work item queued on the workqueue will be processed by a
-worker running on one of the CPUs which share the last level cache with the
-issuing CPU.
+boundaries. A work item queued on the workqueue will be assigned to a worker
+on one of the CPUs which share the last level cache with the issuing CPU.
+Once started, the worker may or may not be allowed to move outside the scope
+depending on the ``affinity_strict`` setting of the scope.
 
 Workqueue currently supports the following five affinity scopes.
 
@@ -391,6 +392,21 @@ directory.
 ``affinity_scope``
   Read to see the current affinity scope. Write to change.
 
+``affinity_strict``
+  0 by default indicating that affinity scopes are not strict. When a work
+  item starts execution, workqueue makes a best-effort attempt to ensure
+  that the worker is inside its affinity scope, which is called
+  repatriation. Once started, the scheduler is free to move the worker
+  anywhere in the system as it sees fit. This enables benefiting from scope
+  locality while still being able to utilize other CPUs if necessary and
+  available.
+
+  If set to 1, all workers of the scope are guaranteed always to be in the
+  scope. This may be useful when crossing affinity scopes has other
+  implications, for example, in terms of power consumption or workload
+  isolation. Strict NUMA scope can also be used to match the workqueue
+  behavior of older kernels.
+
 
 Examining Configuration
 =======================
@@ -475,21 +491,21 @@ Monitoring
 Use tools/workqueue/wq_monitor.py to monitor workqueue operations: ::
 
   $ tools/workqueue/wq_monitor.py events
-                              total  infl  CPUtime  CPUhog  CMwake  mayday rescued
+                              total  infl  CPUtime  CPUhog CMW/RPR  mayday rescued
   events                      18545     0      6.1       0       5       -       -
   events_highpri                  8     0      0.0       0       0       -       -
   events_long                     3     0      0.0       0       0       -       -
-  events_unbound              38306     0      0.1       -       -       -       -
+  events_unbound              38306     0      0.1       -       7       -       -
   events_freezable                0     0      0.0       0       0       -       -
   events_power_efficient      29598     0      0.2       0       0       -       -
   events_freezable_power_        10     0      0.0       0       0       -       -
   sock_diag_events                0     0      0.0       0       0       -       -
 
-                              total  infl  CPUtime  CPUhog  CMwake  mayday rescued
+                              total  infl  CPUtime  CPUhog CMW/RPR  mayday rescued
   events                      18548     0      6.1       0       5       -       -
   events_highpri                  8     0      0.0       0       0       -       -
   events_long                     3     0      0.0       0       0       -       -
-  events_unbound              38322     0      0.1       -       -       -       -
+  events_unbound              38322     0      0.1       -       7       -       -
   events_freezable                0     0      0.0       0       0       -       -
   events_power_efficient      29603     0      0.2       0       0       -       -
   events_freezable_power_        10     0      0.0       0       0       -       -
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 7a0fc0919e0a..751eb915e3f0 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -168,6 +168,17 @@ struct workqueue_attrs {
 	 */
 	cpumask_var_t __pod_cpumask;
 
+	/**
+	 * @affn_strict: affinity scope is strict
+	 *
+	 * If clear, workqueue will make a best-effort attempt at starting the
+	 * worker inside @__pod_cpumask but the scheduler is free to migrate it
+	 * outside.
+	 *
+	 * If set, workers are only allowed to run inside @__pod_cpumask.
+	 */
+	bool affn_strict;
+
 	/*
 	 * Below fields aren't properties of a worker_pool. They only modify how
 	 * :c:func:`apply_workqueue_attrs` select pools and thus don't
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index daebc28d09ab..3ce4c18e139c 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -210,6 +210,7 @@ enum pool_workqueue_stats {
 	PWQ_STAT_CPU_TIME,	/* total CPU time consumed */
 	PWQ_STAT_CPU_INTENSIVE,	/* wq_cpu_intensive_thresh_us violations */
 	PWQ_STAT_CM_WAKEUP,	/* concurrency-management worker wakeups */
+	PWQ_STAT_REPATRIATED,	/* unbound workers brought back into scope */
 	PWQ_STAT_MAYDAY,	/* maydays to rescuer */
 	PWQ_STAT_RESCUED,	/* linked work items executed by rescuer */
 
@@ -1094,13 +1095,41 @@ static bool assign_work(struct work_struct *work, struct worker *worker,
 static bool kick_pool(struct worker_pool *pool)
 {
 	struct worker *worker = first_idle_worker(pool);
+	struct task_struct *p;
 
 	lockdep_assert_held(&pool->lock);
 
 	if (!need_more_worker(pool) || !worker)
 		return false;
 
-	wake_up_process(worker->task);
+	p = worker->task;
+
+#ifdef CONFIG_SMP
+	/*
+	 * Idle @worker is about to execute @work and waking up provides an
+	 * opportunity to migrate @worker at a lower cost by setting the task's
+	 * wake_cpu field. Let's see if we want to move @worker to improve
+	 * execution locality.
+	 *
+	 * We're waking the worker that went idle the latest and there's some
+	 * chance that @worker is marked idle but hasn't gone off CPU yet. If
+	 * so, setting the wake_cpu won't do anything. As this is a best-effort
+	 * optimization and the race window is narrow, let's leave as-is for
+	 * now. If this becomes pronounced, we can skip over workers which are
+	 * still on cpu when picking an idle worker.
+	 *
+	 * If @pool has non-strict affinity, @worker might have ended up outside
+	 * its affinity scope. Repatriate.
+	 */
+	if (!pool->attrs->affn_strict &&
+	    !cpumask_test_cpu(p->wake_cpu, pool->attrs->__pod_cpumask)) {
+		struct work_struct *work = list_first_entry(&pool->worklist,
+						struct work_struct, entry);
+		p->wake_cpu = cpumask_any_distribute(pool->attrs->__pod_cpumask);
+		get_work_pwq(work)->stats[PWQ_STAT_REPATRIATED]++;
+	}
+#endif
+	wake_up_process(p);
 	return true;
 }
 
@@ -2031,7 +2060,10 @@ static struct worker *alloc_worker(int node)
 
 static cpumask_t *pool_allowed_cpus(struct worker_pool *pool)
 {
-	return pool->attrs->__pod_cpumask;
+	if (pool->cpu < 0 && pool->attrs->affn_strict)
+		return pool->attrs->__pod_cpumask;
+	else
+		return pool->attrs->cpumask;
 }
 
 /**
@@ -3696,6 +3728,7 @@ static void copy_workqueue_attrs(struct workqueue_attrs *to,
 	to->nice = from->nice;
 	cpumask_copy(to->cpumask, from->cpumask);
 	cpumask_copy(to->__pod_cpumask, from->__pod_cpumask);
+	to->affn_strict = from->affn_strict;
 
 	/*
 	 * Unlike hash and equality test, copying shouldn't ignore wq-only
@@ -3716,6 +3749,7 @@ static u32 wqattrs_hash(const struct workqueue_attrs *attrs)
 		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
 	hash = jhash(cpumask_bits(attrs->__pod_cpumask),
 		     BITS_TO_LONGS(nr_cpumask_bits) * sizeof(long), hash);
+	hash = jhash_1word(attrs->affn_strict, hash);
 	return hash;
 }
 
@@ -3729,6 +3763,8 @@ static bool wqattrs_equal(const struct workqueue_attrs *a,
 		return false;
 	if (!cpumask_equal(a->__pod_cpumask, b->__pod_cpumask))
 		return false;
+	if (a->affn_strict != b->affn_strict)
+		return false;
 	return true;
 }
 
@@ -5792,6 +5828,7 @@ module_param_cb(default_affinity_scope, &wq_affn_dfl_ops, NULL, 0644);
  *  nice		RW int	: nice value of the workers
  *  cpumask		RW mask	: bitmask of allowed CPUs for the workers
  *  affinity_scope	RW str  : worker CPU affinity scope (cache, numa, none)
+ *  affinity_strict	RW bool : worker CPU affinity is strict
  */
 struct wq_device {
 	struct workqueue_struct		*wq;
@@ -5971,10 +6008,42 @@ static ssize_t wq_affn_scope_store(struct device *dev,
 	return ret ?: count;
 }
 
+static ssize_t wq_affinity_strict_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct workqueue_struct *wq = dev_to_wq(dev);
+
+	return scnprintf(buf, PAGE_SIZE, "%d\n",
+			 wq->unbound_attrs->affn_strict);
+}
+
+static ssize_t wq_affinity_strict_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct workqueue_struct *wq = dev_to_wq(dev);
+	struct workqueue_attrs *attrs;
+	int v, ret = -ENOMEM;
+
+	if (sscanf(buf, "%d", &v) != 1)
+		return -EINVAL;
+
+	apply_wqattrs_lock();
+	attrs = wq_sysfs_prep_attrs(wq);
+	if (attrs) {
+		attrs->affn_strict = (bool)v;
+		ret = apply_workqueue_attrs_locked(wq, attrs);
+	}
+	apply_wqattrs_unlock();
+	free_workqueue_attrs(attrs);
+	return ret ?: count;
+}
+
 static struct device_attribute wq_sysfs_unbound_attrs[] = {
 	__ATTR(nice, 0644, wq_nice_show, wq_nice_store),
 	__ATTR(cpumask, 0644, wq_cpumask_show, wq_cpumask_store),
 	__ATTR(affinity_scope, 0644, wq_affn_scope_show, wq_affn_scope_store),
+	__ATTR(affinity_strict, 0644, wq_affinity_strict_show, wq_affinity_strict_store),
 	__ATTR_NULL,
 };
 
diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index 43ab71a193b8..d0df5833f2c1 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -36,10 +36,11 @@ Workqueue CPU -> pool
 Lists all workqueues along with their type and worker pool association. For
 each workqueue:
 
-  NAME TYPE POOL_ID...
+  NAME TYPE[,FLAGS] POOL_ID...
 
   NAME      name of the workqueue
   TYPE      percpu, unbound or ordered
+  FLAGS     S: strict affinity scope
   POOL_ID   worker pool ID associated with each possible CPU
 """
 
@@ -138,13 +139,16 @@ max_ref_len = 0
         print(f'cpu={pool.cpu.value_():3}', end='')
     else:
         print(f'cpus={cpumask_str(pool.attrs.cpumask)}', end='')
+        print(f' pod_cpus={cpumask_str(pool.attrs.__pod_cpumask)}', end='')
+        if pool.attrs.affn_strict:
+            print(' strict', end='')
     print('')
 
 print('')
 print('Workqueue CPU -> pool')
 print('=====================')
 
-print('[    workqueue \ CPU            ', end='')
+print('[    workqueue     \     type   CPU', end='')
 for cpu in for_each_possible_cpu(prog):
     print(f' {cpu:{max_pool_id_len}}', end='')
 print(' dfl]')
@@ -153,11 +157,15 @@ print(' dfl]')
     print(f'{wq.name.string_().decode()[-24:]:24}', end='')
     if wq.flags & WQ_UNBOUND:
         if wq.flags & WQ_ORDERED:
-            print(' ordered', end='')
+            print(' ordered   ', end='')
         else:
             print(' unbound', end='')
+            if wq.unbound_attrs.affn_strict:
+                print(',S ', end='')
+            else:
+                print('   ', end='')
     else:
-        print(' percpu ', end='')
+        print(' percpu    ', end='')
 
     for cpu in for_each_possible_cpu(prog):
         pool_id = per_cpu_ptr(wq.cpu_pwq, cpu)[0].pool.id.value_()
diff --git a/tools/workqueue/wq_monitor.py b/tools/workqueue/wq_monitor.py
index 6e258d123e8c..a8856a9c45dc 100644
--- a/tools/workqueue/wq_monitor.py
+++ b/tools/workqueue/wq_monitor.py
@@ -20,8 +20,11 @@ https://github.com/osandov/drgn.
            and got excluded from concurrency management to avoid stalling
            other work items.
 
-  CMwake   The number of concurrency-management wake-ups while executing a
-           work item of the workqueue.
+  CMW/RPR  For per-cpu workqueues, the number of concurrency-management
+           wake-ups while executing a work item of the workqueue. For
+           unbound workqueues, the number of times a worker was repatriated
+           to its affinity scope after being migrated to an off-scope CPU by
+           the scheduler.
 
   mayday   The number of times the rescuer was requested while waiting for
            new worker creation.
@@ -65,6 +68,7 @@ PWQ_STAT_COMPLETED      = prog['PWQ_STAT_COMPLETED']	# work items completed exec
 PWQ_STAT_CPU_TIME       = prog['PWQ_STAT_CPU_TIME']     # total CPU time consumed
 PWQ_STAT_CPU_INTENSIVE  = prog['PWQ_STAT_CPU_INTENSIVE'] # wq_cpu_intensive_thresh_us violations
 PWQ_STAT_CM_WAKEUP      = prog['PWQ_STAT_CM_WAKEUP']    # concurrency-management worker wakeups
+PWQ_STAT_REPATRIATED    = prog['PWQ_STAT_REPATRIATED']  # unbound workers brought back into scope
 PWQ_STAT_MAYDAY         = prog['PWQ_STAT_MAYDAY']	# maydays to rescuer
 PWQ_STAT_RESCUED        = prog['PWQ_STAT_RESCUED']	# linked work items executed by rescuer
 PWQ_NR_STATS            = prog['PWQ_NR_STATS']
@@ -89,22 +93,25 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
                  'cpu_time'             : self.stats[PWQ_STAT_CPU_TIME],
                  'cpu_intensive'        : self.stats[PWQ_STAT_CPU_INTENSIVE],
                  'cm_wakeup'            : self.stats[PWQ_STAT_CM_WAKEUP],
+                 'repatriated'          : self.stats[PWQ_STAT_REPATRIATED],
                  'mayday'               : self.stats[PWQ_STAT_MAYDAY],
                  'rescued'              : self.stats[PWQ_STAT_RESCUED], }
 
     def table_header_str():
         return f'{"":>24} {"total":>8} {"infl":>5} {"CPUtime":>8} '\
-            f'{"CPUitsv":>7} {"CMwake":>7} {"mayday":>7} {"rescued":>7}'
+            f'{"CPUitsv":>7} {"CMW/RPR":>7} {"mayday":>7} {"rescued":>7}'
 
     def table_row_str(self):
         cpu_intensive = '-'
-        cm_wakeup = '-'
+        cmw_rpr = '-'
         mayday = '-'
         rescued = '-'
 
-        if not self.unbound:
+        if self.unbound:
+            cmw_rpr = str(self.stats[PWQ_STAT_REPATRIATED]);
+        else:
             cpu_intensive = str(self.stats[PWQ_STAT_CPU_INTENSIVE])
-            cm_wakeup = str(self.stats[PWQ_STAT_CM_WAKEUP])
+            cmw_rpr = str(self.stats[PWQ_STAT_CM_WAKEUP])
 
         if self.mem_reclaim:
             mayday = str(self.stats[PWQ_STAT_MAYDAY])
@@ -115,7 +122,7 @@ PWQ_NR_STATS            = prog['PWQ_NR_STATS']
               f'{max(self.stats[PWQ_STAT_STARTED] - self.stats[PWQ_STAT_COMPLETED], 0):5} ' \
               f'{self.stats[PWQ_STAT_CPU_TIME] / 1000000:8.1f} ' \
               f'{cpu_intensive:>7} ' \
-              f'{cm_wakeup:>7} ' \
+              f'{cmw_rpr:>7} ' \
               f'{mayday:>7} ' \
               f'{rescued:>7} '
         return out.rstrip(':')
-- 
2.40.1

