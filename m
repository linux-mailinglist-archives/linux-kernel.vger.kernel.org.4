Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D336FD405
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjEJDIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjEJDIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:08:21 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2359C49D0
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:08:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-64115eef620so47101650b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683688098; x=1686280098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wNQb+Y1ahRgJj+8rQGW7q8cobBpoM+WxdgK50ASUO8=;
        b=c7R8VMfWKMssG4of5LK4OUFqC/iqXHWACp48s2RRSiqiJ/arySCs+DmIdsqj8yyuLa
         Wq5mlmJnW4AGPdRo2j49ZLya/skgBi4UFy1Ro8M7xY/IYjjs3JDRrWYYT0X/t7TXS+ML
         WTA6Dx4/82wJNx+eHqT7NEWFobovriAoda6QP0Fjn1GeFIDuv+T38cXAFoI8VlRdPZYt
         eXpIIG1gGauGTn5xi9R+xSFUBV73jJQGM08hRZC97+b/3upHK/tVyOzrfghwoJ4vFXns
         sZaN49AgPIpAwwbmknpoON4PdfsSIs0ZbQTrs4skL9UX+BQYWw3FadjlYpEyZSSz+Nv9
         4t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688098; x=1686280098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1wNQb+Y1ahRgJj+8rQGW7q8cobBpoM+WxdgK50ASUO8=;
        b=hb46MaJdawbrJ9jxDIGZW2nrizhXzRKITyeDqOr/m7uXYXP2OMo3d6vl3mtiN+cYTI
         0wDkDU353poKET0X50QataXBywHbk+x5q2XHKKnUoIfy4JabmT3hQne7d3+uUZBJ6KSu
         0u232YadrhowiWY+vUhONTRZ5TUD/scRC3VKsoy7HlgjZn5N1tJ518N4M/rn6HazGaD8
         scUD4OjhIntvhMbjIaytrc7bDKHmnJuf3rgbF3kiDDEoI3voYsDk2LD9a1hVpiagT36t
         uFX/AF5j3mAMsp1Z6/0/OSwXdVEaXWrxXR58wvAmEuVNCoFpebE8GUqmB9AC6YyOGyoG
         rPmQ==
X-Gm-Message-State: AC+VfDwYLLHOKs98pr5DaqTfX6cUiLofoTAU77NS7evHSxG8GwboyBkP
        LyNKQCZBY1T+OveU+4lcSIQYmOBAYNA=
X-Google-Smtp-Source: ACHHUZ5NWo9YzkaC9cWimqez5Ng1tMoNeilseRCWsGWuemN1cidttbaUfZLR4WX2z00WWP+s7XzvLg==
X-Received: by 2002:a05:6a20:3d09:b0:f0:93d9:9c03 with SMTP id y9-20020a056a203d0900b000f093d99c03mr20037322pzi.15.1683688098283;
        Tue, 09 May 2023 20:08:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id 12-20020a63124c000000b00502ecb91940sm2089397pgs.55.2023.05.09.20.08.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:08:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>, Hillf Danton <hdanton@sina.com>
Subject: [PATCH 4/6] workqueue: Automatically mark CPU-hogging work items CPU_INTENSIVE
Date:   Tue,  9 May 2023 17:07:50 -1000
Message-Id: <20230510030752.542340-5-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230510030752.542340-1-tj@kernel.org>
References: <20230510030752.542340-1-tj@kernel.org>
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

v2: Lai pointed out that wq_worker_stopping() also needs to be called from
    preemption and rtlock paths and an earlier patch was updated
    accordingly. This patch adds a comment describing the risk of infinte
    recursions and how they're avoided.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Acked-by: Hillf Danton <hdanton@sina.com>
---
 kernel/workqueue.c          | 82 +++++++++++++++++++++++++++----------
 kernel/workqueue_internal.h |  1 +
 2 files changed, 61 insertions(+), 22 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 31f1618d98c2..b63bbd22f756 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -310,6 +310,14 @@ static struct kmem_cache *pwq_cache;
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
 
@@ -963,9 +971,6 @@ void notrace wq_worker_stopping(struct task_struct *task, bool voluntary)
 	struct worker *worker = kthread_data(task);
 	struct worker_pool *pool;
 
-	if (!voluntary || task_is_running(task))
-		return;
-
 	/*
 	 * Rescuers, which may not have all the fields set up like normal
 	 * workers, also reach here, let's not access anything before
@@ -976,24 +981,54 @@ void notrace wq_worker_stopping(struct task_struct *task, bool voluntary)
 
 	pool = worker->pool;
 
-	/* Return if preempted before wq_worker_running() was reached */
-	if (worker->sleeping)
-		return;
+	if (!voluntary || task_is_running(task)) {
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
+		/*
+		 * As this function may be called from preempt_enable_notrace(),
+		 * all operations upto this point must not be traceable to avoid
+		 * infinite recursions. We're safe once IRQ is disabled.
+		 */
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
@@ -2311,7 +2346,6 @@ __acquires(&pool->lock)
 {
 	struct pool_workqueue *pwq = get_work_pwq(work);
 	struct worker_pool *pool = worker->pool;
-	bool cpu_intensive = pwq->wq->flags & WQ_CPU_INTENSIVE;
 	unsigned long work_data;
 	struct worker *collision;
 #ifdef CONFIG_LOCKDEP
@@ -2348,6 +2382,7 @@ __acquires(&pool->lock)
 	worker->current_work = work;
 	worker->current_func = work->func;
 	worker->current_pwq = pwq;
+	worker->current_at = worker->task->se.sum_exec_runtime;
 	work_data = *work_data_bits(work);
 	worker->current_color = get_work_color(work_data);
 
@@ -2365,7 +2400,7 @@ __acquires(&pool->lock)
 	 * of concurrency management and the next code block will chain
 	 * execution of the pending work items.
 	 */
-	if (unlikely(cpu_intensive))
+	if (unlikely(pwq->wq->flags & WQ_CPU_INTENSIVE))
 		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
 
 	/*
@@ -2443,9 +2478,12 @@ __acquires(&pool->lock)
 
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
index a20b4d052a45..a1f012accce2 100644
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
2.40.1

