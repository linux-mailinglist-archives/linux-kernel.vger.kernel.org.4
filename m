Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39930708CBB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjESASB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjESARx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:17:53 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5FD10E7
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:46 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-253520adb30so1435231a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455466; x=1687047466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l59TW3SO2E8+id/N9ePHaPeVBwKCkcAQduO8MlWs1rY=;
        b=eHpFQrwTVtLflC1aHXznxuuUxG3nA5fVcmju/wZu0cYSWfk8fb3EhLSTQze08lXH0m
         reLbpXiizQSIU7kZWAsJ1Ej5YKMHgqfaZzAOIgWoPtxyDQobACXXbOyOozEJSdkNq00/
         I/jbOcqEKC2WgcQ7H9r6pSUnzmNHhfMU7ie6yHkB2A/k3qiqxaAZPfWiXqr+89d9LNZh
         BNOCGP3FWBExyaKvozRnslka91kv9W2fCAw4C3WRncnhvctA7XZSFxS3HpzDXiwSj0P0
         Pi0vJSUJgw3phpgaytIzVD37gtvQn0MuDveglwAnjC3OSUIRloL2Dw+DVfUxss87FY2J
         9aOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455466; x=1687047466;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l59TW3SO2E8+id/N9ePHaPeVBwKCkcAQduO8MlWs1rY=;
        b=iN6C61Wjec6+6vitTnUbUDCl0yf6gxhNquoA3SCKUT5bfi42gdlo+/newTnqB2n0fr
         wstuqY7i98SLC17GYZniEVntEByZGkXlufA8NI7oK6vdA2dDwABVyjqAZeJ8gKufZWnp
         W1y8vkSLegSzrjLBEw8JFqYTQC/BsqykXOFgLsBL8Bw5QXgMdw82Wb2hMVtYqMBa/0Pz
         S4VaN4IiFaIxWJIxQDiSbWClnE8R6UIW5TR44lMNg46t6MexuJLnM6sgsN9uIAlh/8AS
         rBcBWP3gSJUasJuREfkbJuStHwLW8N8D2LSte9scUwGG1uudJ3DAIxf8xm1HhLDxowPv
         VFAg==
X-Gm-Message-State: AC+VfDysLURFfPYVhaDo4RVWJ4ZgjuWyM1u05jnNdHe4FWQ2qXSAzNR5
        1L0IcCNcSIdNwjfGRKLW/10=
X-Google-Smtp-Source: ACHHUZ4VycXuiRE0qzTNUjPa8ghU9EeygRG1QCLHolu4yJmdqpCkWiTy0DYGzR2RG/l08PmokK6xMw==
X-Received: by 2002:a17:90a:9cf:b0:250:bb6:47ed with SMTP id 73-20020a17090a09cf00b002500bb647edmr257522pjo.33.1684455465410;
        Thu, 18 May 2023 17:17:45 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id co2-20020a17090afe8200b0024de3dff70esm216219pjb.56.2023.05.18.17.17.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:44 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/24] workqueue: Relocate worker and work management functions
Date:   Thu, 18 May 2023 14:16:50 -1000
Message-Id: <20230519001709.2563-6-tj@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519001709.2563-1-tj@kernel.org>
References: <20230519001709.2563-1-tj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Collect first_idle_worker(), worker_enter/leave_idle(),
find_worker_executing_work(), move_linked_works() and wake_up_worker() into
one place. These functions will later be used to implement higher level
worker management logic.

No functional changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 340 ++++++++++++++++++++++-----------------------
 1 file changed, 168 insertions(+), 172 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 80b2bd01c718..6ec22eb87283 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -860,36 +860,6 @@ static bool too_many_workers(struct worker_pool *pool)
 	return nr_idle > 2 && (nr_idle - 2) * MAX_IDLE_WORKERS_RATIO >= nr_busy;
 }
 
-/*
- * Wake up functions.
- */
-
-/* Return the first idle worker.  Called with pool->lock held. */
-static struct worker *first_idle_worker(struct worker_pool *pool)
-{
-	if (unlikely(list_empty(&pool->idle_list)))
-		return NULL;
-
-	return list_first_entry(&pool->idle_list, struct worker, entry);
-}
-
-/**
- * wake_up_worker - wake up an idle worker
- * @pool: worker pool to wake worker from
- *
- * Wake up the first idle worker of @pool.
- *
- * CONTEXT:
- * raw_spin_lock_irq(pool->lock).
- */
-static void wake_up_worker(struct worker_pool *pool)
-{
-	struct worker *worker = first_idle_worker(pool);
-
-	if (likely(worker))
-		wake_up_process(worker->task);
-}
-
 /**
  * worker_set_flags - set worker flags and adjust nr_running accordingly
  * @worker: self
@@ -938,6 +908,174 @@ static inline void worker_clr_flags(struct worker *worker, unsigned int flags)
 			pool->nr_running++;
 }
 
+/* Return the first idle worker.  Called with pool->lock held. */
+static struct worker *first_idle_worker(struct worker_pool *pool)
+{
+	if (unlikely(list_empty(&pool->idle_list)))
+		return NULL;
+
+	return list_first_entry(&pool->idle_list, struct worker, entry);
+}
+
+/**
+ * worker_enter_idle - enter idle state
+ * @worker: worker which is entering idle state
+ *
+ * @worker is entering idle state.  Update stats and idle timer if
+ * necessary.
+ *
+ * LOCKING:
+ * raw_spin_lock_irq(pool->lock).
+ */
+static void worker_enter_idle(struct worker *worker)
+{
+	struct worker_pool *pool = worker->pool;
+
+	if (WARN_ON_ONCE(worker->flags & WORKER_IDLE) ||
+	    WARN_ON_ONCE(!list_empty(&worker->entry) &&
+			 (worker->hentry.next || worker->hentry.pprev)))
+		return;
+
+	/* can't use worker_set_flags(), also called from create_worker() */
+	worker->flags |= WORKER_IDLE;
+	pool->nr_idle++;
+	worker->last_active = jiffies;
+
+	/* idle_list is LIFO */
+	list_add(&worker->entry, &pool->idle_list);
+
+	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
+		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
+
+	/* Sanity check nr_running. */
+	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
+}
+
+/**
+ * worker_leave_idle - leave idle state
+ * @worker: worker which is leaving idle state
+ *
+ * @worker is leaving idle state.  Update stats.
+ *
+ * LOCKING:
+ * raw_spin_lock_irq(pool->lock).
+ */
+static void worker_leave_idle(struct worker *worker)
+{
+	struct worker_pool *pool = worker->pool;
+
+	if (WARN_ON_ONCE(!(worker->flags & WORKER_IDLE)))
+		return;
+	worker_clr_flags(worker, WORKER_IDLE);
+	pool->nr_idle--;
+	list_del_init(&worker->entry);
+}
+
+/**
+ * find_worker_executing_work - find worker which is executing a work
+ * @pool: pool of interest
+ * @work: work to find worker for
+ *
+ * Find a worker which is executing @work on @pool by searching
+ * @pool->busy_hash which is keyed by the address of @work.  For a worker
+ * to match, its current execution should match the address of @work and
+ * its work function.  This is to avoid unwanted dependency between
+ * unrelated work executions through a work item being recycled while still
+ * being executed.
+ *
+ * This is a bit tricky.  A work item may be freed once its execution
+ * starts and nothing prevents the freed area from being recycled for
+ * another work item.  If the same work item address ends up being reused
+ * before the original execution finishes, workqueue will identify the
+ * recycled work item as currently executing and make it wait until the
+ * current execution finishes, introducing an unwanted dependency.
+ *
+ * This function checks the work item address and work function to avoid
+ * false positives.  Note that this isn't complete as one may construct a
+ * work function which can introduce dependency onto itself through a
+ * recycled work item.  Well, if somebody wants to shoot oneself in the
+ * foot that badly, there's only so much we can do, and if such deadlock
+ * actually occurs, it should be easy to locate the culprit work function.
+ *
+ * CONTEXT:
+ * raw_spin_lock_irq(pool->lock).
+ *
+ * Return:
+ * Pointer to worker which is executing @work if found, %NULL
+ * otherwise.
+ */
+static struct worker *find_worker_executing_work(struct worker_pool *pool,
+						 struct work_struct *work)
+{
+	struct worker *worker;
+
+	hash_for_each_possible(pool->busy_hash, worker, hentry,
+			       (unsigned long)work)
+		if (worker->current_work == work &&
+		    worker->current_func == work->func)
+			return worker;
+
+	return NULL;
+}
+
+/**
+ * move_linked_works - move linked works to a list
+ * @work: start of series of works to be scheduled
+ * @head: target list to append @work to
+ * @nextp: out parameter for nested worklist walking
+ *
+ * Schedule linked works starting from @work to @head.  Work series to
+ * be scheduled starts at @work and includes any consecutive work with
+ * WORK_STRUCT_LINKED set in its predecessor.
+ *
+ * If @nextp is not NULL, it's updated to point to the next work of
+ * the last scheduled work.  This allows move_linked_works() to be
+ * nested inside outer list_for_each_entry_safe().
+ *
+ * CONTEXT:
+ * raw_spin_lock_irq(pool->lock).
+ */
+static void move_linked_works(struct work_struct *work, struct list_head *head,
+			      struct work_struct **nextp)
+{
+	struct work_struct *n;
+
+	/*
+	 * Linked worklist will always end before the end of the list,
+	 * use NULL for list head.
+	 */
+	list_for_each_entry_safe_from(work, n, NULL, entry) {
+		list_move_tail(&work->entry, head);
+		if (!(*work_data_bits(work) & WORK_STRUCT_LINKED))
+			break;
+	}
+
+	/*
+	 * If we're already inside safe list traversal and have moved
+	 * multiple works to the scheduled queue, the next position
+	 * needs to be updated.
+	 */
+	if (nextp)
+		*nextp = n;
+}
+
+/**
+ * wake_up_worker - wake up an idle worker
+ * @pool: worker pool to wake worker from
+ *
+ * Wake up the first idle worker of @pool.
+ *
+ * CONTEXT:
+ * raw_spin_lock_irq(pool->lock).
+ */
+static void wake_up_worker(struct worker_pool *pool)
+{
+	struct worker *worker = first_idle_worker(pool);
+
+	if (likely(worker))
+		wake_up_process(worker->task);
+}
+
 #ifdef CONFIG_WQ_CPU_INTENSIVE_REPORT
 
 /*
@@ -1183,94 +1321,6 @@ work_func_t wq_worker_last_func(struct task_struct *task)
 	return worker->last_func;
 }
 
-/**
- * find_worker_executing_work - find worker which is executing a work
- * @pool: pool of interest
- * @work: work to find worker for
- *
- * Find a worker which is executing @work on @pool by searching
- * @pool->busy_hash which is keyed by the address of @work.  For a worker
- * to match, its current execution should match the address of @work and
- * its work function.  This is to avoid unwanted dependency between
- * unrelated work executions through a work item being recycled while still
- * being executed.
- *
- * This is a bit tricky.  A work item may be freed once its execution
- * starts and nothing prevents the freed area from being recycled for
- * another work item.  If the same work item address ends up being reused
- * before the original execution finishes, workqueue will identify the
- * recycled work item as currently executing and make it wait until the
- * current execution finishes, introducing an unwanted dependency.
- *
- * This function checks the work item address and work function to avoid
- * false positives.  Note that this isn't complete as one may construct a
- * work function which can introduce dependency onto itself through a
- * recycled work item.  Well, if somebody wants to shoot oneself in the
- * foot that badly, there's only so much we can do, and if such deadlock
- * actually occurs, it should be easy to locate the culprit work function.
- *
- * CONTEXT:
- * raw_spin_lock_irq(pool->lock).
- *
- * Return:
- * Pointer to worker which is executing @work if found, %NULL
- * otherwise.
- */
-static struct worker *find_worker_executing_work(struct worker_pool *pool,
-						 struct work_struct *work)
-{
-	struct worker *worker;
-
-	hash_for_each_possible(pool->busy_hash, worker, hentry,
-			       (unsigned long)work)
-		if (worker->current_work == work &&
-		    worker->current_func == work->func)
-			return worker;
-
-	return NULL;
-}
-
-/**
- * move_linked_works - move linked works to a list
- * @work: start of series of works to be scheduled
- * @head: target list to append @work to
- * @nextp: out parameter for nested worklist walking
- *
- * Schedule linked works starting from @work to @head.  Work series to
- * be scheduled starts at @work and includes any consecutive work with
- * WORK_STRUCT_LINKED set in its predecessor.
- *
- * If @nextp is not NULL, it's updated to point to the next work of
- * the last scheduled work.  This allows move_linked_works() to be
- * nested inside outer list_for_each_entry_safe().
- *
- * CONTEXT:
- * raw_spin_lock_irq(pool->lock).
- */
-static void move_linked_works(struct work_struct *work, struct list_head *head,
-			      struct work_struct **nextp)
-{
-	struct work_struct *n;
-
-	/*
-	 * Linked worklist will always end before the end of the list,
-	 * use NULL for list head.
-	 */
-	list_for_each_entry_safe_from(work, n, NULL, entry) {
-		list_move_tail(&work->entry, head);
-		if (!(*work_data_bits(work) & WORK_STRUCT_LINKED))
-			break;
-	}
-
-	/*
-	 * If we're already inside safe list traversal and have moved
-	 * multiple works to the scheduled queue, the next position
-	 * needs to be updated.
-	 */
-	if (nextp)
-		*nextp = n;
-}
-
 /**
  * get_pwq - get an extra reference on the specified pool_workqueue
  * @pwq: pool_workqueue to get
@@ -1954,60 +2004,6 @@ bool queue_rcu_work(struct workqueue_struct *wq, struct rcu_work *rwork)
 }
 EXPORT_SYMBOL(queue_rcu_work);
 
-/**
- * worker_enter_idle - enter idle state
- * @worker: worker which is entering idle state
- *
- * @worker is entering idle state.  Update stats and idle timer if
- * necessary.
- *
- * LOCKING:
- * raw_spin_lock_irq(pool->lock).
- */
-static void worker_enter_idle(struct worker *worker)
-{
-	struct worker_pool *pool = worker->pool;
-
-	if (WARN_ON_ONCE(worker->flags & WORKER_IDLE) ||
-	    WARN_ON_ONCE(!list_empty(&worker->entry) &&
-			 (worker->hentry.next || worker->hentry.pprev)))
-		return;
-
-	/* can't use worker_set_flags(), also called from create_worker() */
-	worker->flags |= WORKER_IDLE;
-	pool->nr_idle++;
-	worker->last_active = jiffies;
-
-	/* idle_list is LIFO */
-	list_add(&worker->entry, &pool->idle_list);
-
-	if (too_many_workers(pool) && !timer_pending(&pool->idle_timer))
-		mod_timer(&pool->idle_timer, jiffies + IDLE_WORKER_TIMEOUT);
-
-	/* Sanity check nr_running. */
-	WARN_ON_ONCE(pool->nr_workers == pool->nr_idle && pool->nr_running);
-}
-
-/**
- * worker_leave_idle - leave idle state
- * @worker: worker which is leaving idle state
- *
- * @worker is leaving idle state.  Update stats.
- *
- * LOCKING:
- * raw_spin_lock_irq(pool->lock).
- */
-static void worker_leave_idle(struct worker *worker)
-{
-	struct worker_pool *pool = worker->pool;
-
-	if (WARN_ON_ONCE(!(worker->flags & WORKER_IDLE)))
-		return;
-	worker_clr_flags(worker, WORKER_IDLE);
-	pool->nr_idle--;
-	list_del_init(&worker->entry);
-}
-
 static struct worker *alloc_worker(int node)
 {
 	struct worker *worker;
-- 
2.40.1

