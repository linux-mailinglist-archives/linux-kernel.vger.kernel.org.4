Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBA46E6DB6
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:52:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjDRUwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232800AbjDRUwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:52:16 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B29212B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:14 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-63b7588005fso1941616b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681851134; x=1684443134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BiyKnV+GvV02qxUA2NL2SgXCN13SONya0esr6HuFPq8=;
        b=lLn8NTdpeFlg72X5fgMh6+fYVpcJAKPpbKQUKCAyaT5TUtFs4dqSS1yi59TWUzTjFI
         M+aF0IiFQin50s7Fwt3tC2e/hmhipUxPHGe7idC5D2Oas4BknVHQr/gogEBuuYhhLMMn
         9tDcH4hAnpN8TnD8BbQF8Y8rXq3hW2rn21WpOgwS805WDL2xroouzea0RWAd7lUJ5oC4
         QhrnHSVlF+INDYBnWZoiB5iwvpq01vWUpq0NcfymvzavRzIVdG1P1MuSnUHLDDbMDc2b
         lx3ctvtfioxUQPO11n2vXqCsmG8PyTqUuUPqXRIQjPY7CTRtKl8m/C4NUCAaU8fZC8tW
         V53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851134; x=1684443134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BiyKnV+GvV02qxUA2NL2SgXCN13SONya0esr6HuFPq8=;
        b=DztkRB8IkveYIorbaW7iGmm3iDoSYz1gghgFW36xbVDadXU0kUGPSDneriD1JfrqvV
         YurXMFvahDYOyeR/kvbuzR7oKKzZM/7MOc/tgOKmycYmEQGYDMOzVvE0fnwDWAuT0ZvH
         IXc6Rj665gzbQnCwR2M4/bznJ7KUSGTjMmJIRaAmRFXsvpfSRi4wN/IO7Dy6xChrh3bp
         CejyciXdQAneoZRe364lFx5wzWGYEMO+jDicHVKG6k3yv14Vtru7OWnwzcNyayMgEsFu
         WAE6BNWRS2j41nDWJA28WkuVyqlrPQTVv0YAxXVlk6xwdDRSF6YTsBFzcu/GfoxzpUnQ
         kd5A==
X-Gm-Message-State: AAQBX9fT+Eq5SU0uR0CPE9rVd9qGC9GL1XFqj9BYKvGfDggWcUhHVBG2
        BxA5eBIgmWxsnDAv74A/H58=
X-Google-Smtp-Source: AKy350aLAERsGZSf33kGFV2X2SCghuu3lluzV6y8CkzdD5YQ5DIkNKMZSaga8JkFh2pRvZc5VGYUxA==
X-Received: by 2002:a05:6a00:24ca:b0:63b:8b47:453c with SMTP id d10-20020a056a0024ca00b0063b8b47453cmr1255962pfv.1.1681851134046;
        Tue, 18 Apr 2023 13:52:14 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id p22-20020aa78616000000b0063b675f01a2sm7895121pfn.26.2023.04.18.13.52.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:52:13 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 4/5] workqueue: Automatically mark CPU-hogging work items CPU_INTENSIVE
Date:   Tue, 18 Apr 2023 10:51:58 -1000
Message-Id: <20230418205159.724789-5-tj@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418205159.724789-1-tj@kernel.org>
References: <20230418205159.724789-1-tj@kernel.org>
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
concurrency-managed work item consumes more CPU time than the threshold (5ms
by default), it's marked CPU_INTENSIVE automatically on schedule-out.

The mechanism isn't foolproof in that the 5ms detection delays can add up if
many CPU-hogging work items are queued at the same time. However, in such
situations, the bigger problem likely is the CPU being saturated with
per-cpu work items and the solution would be making them UNBOUND.

For occasional CPU hogging, the new automatic mechanism should provide
reasonable protection with minimal increase in code complexity.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
---
 kernel/workqueue.c          | 77 ++++++++++++++++++++++++++-----------
 kernel/workqueue_internal.h |  1 +
 2 files changed, 56 insertions(+), 22 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b9e8dc54272d..d24b887ddd86 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -306,6 +306,14 @@ static struct kmem_cache *pwq_cache;
 static cpumask_var_t *wq_numa_possible_cpumask;
 					/* possible CPUs of each node */
 
+/*
+ * Per-cpu work items which run for longer than the following threshold are
+ * automatically considered CPU intensive and excluded from concurrency
+ * management to prevent them from noticeably delaying other per-cpu work items.
+ */
+static unsigned long wq_cpu_intensive_thresh_us = 5000;
+module_param_named(cpu_intensive_thresh_us, wq_cpu_intensive_thresh_us, ulong, 0644);
+
 static bool wq_disable_numa;
 module_param_named(disable_numa, wq_disable_numa, bool, 0444);
 
@@ -951,9 +959,6 @@ void wq_worker_stopping(struct task_struct *task)
 	struct worker *worker = kthread_data(task);
 	struct worker_pool *pool;
 
-	if (task_is_running(task))
-		return;
-
 	/*
 	 * Rescuers, which may not have all the fields set up like normal
 	 * workers, also reach here, let's not access anything before
@@ -964,24 +969,49 @@ void wq_worker_stopping(struct task_struct *task)
 
 	pool = worker->pool;
 
-	/* Return if preempted before wq_worker_running() was reached */
-	if (worker->sleeping)
-		return;
+	if (task_is_running(task)) {
+		/*
+		 * Concurrency-managed @worker is still RUNNING. See if the
+		 * current work is hogging CPU stalling other per-cpu work
+		 * items. If so, mark @worker CPU_INTENSIVE to exclude it from
+		 * concurrency management. @worker->current_* are stable as they
+		 * can only be modified by @task which is %current.
+		 */
+		if (!worker->current_work ||
+		    task->se.sum_exec_runtime - worker->current_at <
+		    wq_cpu_intensive_thresh_us * NSEC_PER_USEC)
+			return;
 
-	worker->sleeping = 1;
-	raw_spin_lock_irq(&pool->lock);
+		raw_spin_lock_irq(&pool->lock);
+		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
+	} else {
+		/*
+		 * Concurrency-managed @worker is sleeping. Decrement the
+		 * associated pool's nr_running accordingly.
+		 */
 
-	/*
-	 * Recheck in case unbind_workers() preempted us. We don't
-	 * want to decrement nr_running after the worker is unbound
-	 * and nr_running has been reset.
-	 */
-	if (worker->flags & WORKER_NOT_RUNNING) {
-		raw_spin_unlock_irq(&pool->lock);
-		return;
+		/* Return if preempted before wq_worker_running() was reached */
+		if (worker->sleeping)
+			return;
+
+		worker->sleeping = 1;
+		raw_spin_lock_irq(&pool->lock);
+
+		/*
+		 * Recheck in case unbind_workers() preempted us. We don't want
+		 * to decrement nr_running after the worker is unbound and
+		 * nr_running has been reset. As a running worker never sleeps
+		 * inbetween work items, we know that @worker->current_* are
+		 * valid after the following check.
+		 */
+		if (worker->flags & WORKER_NOT_RUNNING) {
+			raw_spin_unlock_irq(&pool->lock);
+			return;
+		}
+
+		pool->nr_running--;
 	}
 
-	pool->nr_running--;
 	if (need_more_worker(pool))
 		wake_up_worker(pool);
 	raw_spin_unlock_irq(&pool->lock);
@@ -2288,7 +2318,6 @@ __acquires(&pool->lock)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
 	struct worker_pool *pool = worker->pool;
-	bool cpu_intensive = pwq->wq->flags & WQ_CPU_INTENSIVE;
 	unsigned long work_data;
 	struct worker *collision;
 #ifdef CONFIG_LOCKDEP
@@ -2325,6 +2354,7 @@ __acquires(&pool->lock)
 	worker->current_work = work;
 	worker->current_func = work->func;
 	worker->current_pwq = pwq;
+	worker->current_at = worker->task->se.sum_exec_runtime;
 	work_data = *work_data_bits(work);
 	worker->current_color = get_work_color(work_data);
 
@@ -2342,7 +2372,7 @@ __acquires(&pool->lock)
 	 * of concurrency management and the next code block will chain
 	 * execution of the pending work items.
 	 */
-	if (unlikely(cpu_intensive))
+	if (unlikely(pwq->wq->flags & WQ_CPU_INTENSIVE))
 		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
 
 	/*
@@ -2420,9 +2450,12 @@ __acquires(&pool->lock)
 
 	raw_spin_lock_irq(&pool->lock);
 
-	/* clear cpu intensive status */
-	if (unlikely(cpu_intensive))
-		worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
+	/*
+	 * In addition to %WQ_CPU_INTENSIVE, @worker may also have been marked
+	 * CPU intensive by wq_worker_stopping() if @work consumed more than
+	 * wq_cpu_intensive_thresh_us. Clear it.
+	 */
+	worker_clr_flags(worker, WORKER_CPU_INTENSIVE);
 
 	/* tag the worker for identification in schedule() */
 	worker->last_func = worker->current_func;
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index 902459b328de..08ffed41f104 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -31,6 +31,7 @@ struct worker {
 	struct work_struct	*current_work;	/* L: work being processed */
 	work_func_t		current_func;	/* L: current_work's fn */
 	struct pool_workqueue	*current_pwq;	/* L: current_work's pwq */
+	u64			current_at;	/* L: runtime when current_work started */
 	unsigned int		current_color;	/* L: current_work's color */
 	int			sleeping;	/* None */
 
-- 
2.40.0

