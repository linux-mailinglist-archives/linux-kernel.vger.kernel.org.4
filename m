Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E835C708CC9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjESATb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231164AbjESASz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D791981
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:29 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-51f1b6e8179so1827068a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455492; x=1687047492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YDmg69IzRJyOjIfphfIT4F9L0vpepBzuS21ti/0FCgQ=;
        b=otJs2qmS8dpN45tc70hwrQ9M3LO2eisKxyYiQVofbXdLcm623kBDFUGAQQIQX/Hv1/
         7cnptQE4bYKMZ7MPCk+m0P4VUVmc52yBcmS78kPfCzvLtEPTt+aUMLLVdX8x2kMdg9H+
         pBy2RLmIDHKF95jmwsXM+gU6tmknMgE3uavTiZ8OCvf46ddWqf89k/hqbYeRVw8aawmL
         MJ/A2531xVPGajmq+k9vfTXYy6MN/fRVO6jYDAPJLxcgz4E8M+QaQUdAow+4c/jwxYKJ
         IqOnHTK++VvmIt7A0Q9WxNSlvMGyWn28A8PiJVTPJ6MDy2hHGS5kiandPT0cQieM7DCJ
         yEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455492; x=1687047492;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YDmg69IzRJyOjIfphfIT4F9L0vpepBzuS21ti/0FCgQ=;
        b=F/m+UhsIfHayznqzVoDzS9JY2kU/jYRqei04mAsO6zW1lGZ/spvdWym34S2WPwo1xW
         oEEMdVzFbVxfQsIOUQCff0WujWVDMjf/6k0jUrxF/1zI6s7iDZ6/heL/14wt+E5n083b
         7kX1fbFNaWABcDcOKvRuLBwUOXHXUuEn5/Nr+ax/t98RPyKpIAJbbf4VkVtirFufnfkk
         yRaIn+RE2JQ84jJ3oAcsw5gBUaZtBQ5RaQYKK7mEyqt1R3oHfdI7t+J74qXrceR3Nx7N
         Dum/MdSJIfdUsm/b7YNkqs6K9pZp3bvQzDxjCOzgpz4hxcKpklpqwqGJflG92u8YAa/g
         Fpdw==
X-Gm-Message-State: AC+VfDyRBovGITOp1mB+eAT63HdI9229wbBrNzzaIEi2j3Ho6+Kq6F6C
        2juxJrXoVhHq7Km0dfLfdQo=
X-Google-Smtp-Source: ACHHUZ6ZoSjR4OdMZv0l+2zl7ovWcNubPcQquuKvovK2kecGup5Gk1AjFr6eObHIoCmnRg/xrWnZ8A==
X-Received: by 2002:a17:902:c40d:b0:1ac:66c4:6071 with SMTP id k13-20020a170902c40d00b001ac66c46071mr935163plk.57.1684455491881;
        Thu, 18 May 2023 17:18:11 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id g7-20020a1709029f8700b001ab18eaf90esm2041082plq.158.2023.05.18.17.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 19/24] workqueue: Factor out need_more_worker() check and worker wake-up
Date:   Thu, 18 May 2023 14:17:04 -1000
Message-Id: <20230519001709.2563-20-tj@kernel.org>
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

Checking need_more_worker() and calling wake_up_worker() is a repeated
pattern. Let's add kick_pool(), which checks need_more_worker() and
open-code wake_up_worker(), and replace wake_up_worker() uses. The following
conversions aren't one-to-one:

* __queue_work() was using __need_more_work() because it knows that
  pool->worklist isn't empty. Switching to kick_pool() adds an extra
  list_empty() test.

* create_worker() always needs to wake up the newly minted worker whether
  there's more work to do or not to avoid triggering hung task check on the
  new task. Keep the current wake_up_process() and still add kick_pool().
  This may lead to an extra wakeup which isn't harmful.

* pwq_adjust_max_active() was explicitly checking whether it needs to wake
  up a worker or not to avoid spurious wakeups. As kick_pool() only wakes up
  a worker when necessary, this explicit check is no longer necessary and
  dropped.

* unbind_workers() now calls kick_pool() instead of wake_up_worker() adding
  a need_more_worker() test. This avoids spurious wakeups and shouldn't
  break anything.

wake_up_worker() is dropped as kick_pool() replaces all its users. After
this patch, all paths that wakes up a non-rescuer worker to initiate work
item execution use kick_pool(). This will enable future changes to improve
locality.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 87 ++++++++++++++++++++--------------------------
 1 file changed, 37 insertions(+), 50 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a2e6c2be3a06..58aec5cc5722 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -805,11 +805,6 @@ static bool work_is_canceling(struct work_struct *work)
  * they're being called with pool->lock held.
  */
 
-static bool __need_more_worker(struct worker_pool *pool)
-{
-	return !pool->nr_running;
-}
-
 /*
  * Need to wake up a worker?  Called from anything but currently
  * running workers.
@@ -820,7 +815,7 @@ static bool __need_more_worker(struct worker_pool *pool)
  */
 static bool need_more_worker(struct worker_pool *pool)
 {
-	return !list_empty(&pool->worklist) && __need_more_worker(pool);
+	return !list_empty(&pool->worklist) && !pool->nr_running;
 }
 
 /* Can I start working?  Called from busy but !running workers. */
@@ -1090,20 +1085,23 @@ static bool assign_work(struct work_struct *work, struct worker *worker,
 }
 
 /**
- * wake_up_worker - wake up an idle worker
- * @pool: worker pool to wake worker from
- *
- * Wake up the first idle worker of @pool.
+ * kick_pool - wake up an idle worker if necessary
+ * @pool: pool to kick
  *
- * CONTEXT:
- * raw_spin_lock_irq(pool->lock).
+ * @pool may have pending work items. Wake up worker if necessary. Returns
+ * whether a worker was woken up.
  */
-static void wake_up_worker(struct worker_pool *pool)
+static bool kick_pool(struct worker_pool *pool)
 {
 	struct worker *worker = first_idle_worker(pool);
 
-	if (likely(worker))
-		wake_up_process(worker->task);
+	lockdep_assert_held(&pool->lock);
+
+	if (!need_more_worker(pool) || !worker)
+		return false;
+
+	wake_up_process(worker->task);
+	return true;
 }
 
 #ifdef CONFIG_WQ_CPU_INTENSIVE_REPORT
@@ -1271,10 +1269,9 @@ void wq_worker_sleeping(struct task_struct *task)
 	}
 
 	pool->nr_running--;
-	if (need_more_worker(pool)) {
+	if (kick_pool(pool))
 		worker->current_pwq->stats[PWQ_STAT_CM_WAKEUP]++;
-		wake_up_worker(pool);
-	}
+
 	raw_spin_unlock_irq(&pool->lock);
 }
 
@@ -1312,10 +1309,8 @@ void wq_worker_tick(struct task_struct *task)
 	wq_cpu_intensive_report(worker->current_func);
 	pwq->stats[PWQ_STAT_CPU_INTENSIVE]++;
 
-	if (need_more_worker(pool)) {
+	if (kick_pool(pool))
 		pwq->stats[PWQ_STAT_CM_WAKEUP]++;
-		wake_up_worker(pool);
-	}
 
 	raw_spin_unlock(&pool->lock);
 }
@@ -1752,9 +1747,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		trace_workqueue_activate_work(work);
 		pwq->nr_active++;
 		insert_work(pwq, work, &pool->worklist, work_flags);
-
-		if (__need_more_worker(pool))
-			wake_up_worker(pool);
+		kick_pool(pool);
 	} else {
 		work_flags |= WORK_STRUCT_INACTIVE;
 		insert_work(pwq, work, &pwq->inactive_works, work_flags);
@@ -2160,9 +2153,18 @@ static struct worker *create_worker(struct worker_pool *pool)
 
 	/* start the newly created worker */
 	raw_spin_lock_irq(&pool->lock);
+
 	worker->pool->nr_workers++;
 	worker_enter_idle(worker);
+	kick_pool(pool);
+
+	/*
+	 * @worker is waiting on a completion in kthread() and will trigger hung
+	 * check if not woken up soon. As kick_pool() might not have waken it
+	 * up, wake it up explicitly once more.
+	 */
 	wake_up_process(worker->task);
+
 	raw_spin_unlock_irq(&pool->lock);
 
 	return worker;
@@ -2525,14 +2527,12 @@ __acquires(&pool->lock)
 		worker_set_flags(worker, WORKER_CPU_INTENSIVE);
 
 	/*
-	 * Wake up another worker if necessary.  The condition is always
-	 * false for normal per-cpu workers since nr_running would always
-	 * be >= 1 at this point.  This is used to chain execution of the
-	 * pending work items for WORKER_NOT_RUNNING workers such as the
-	 * UNBOUND and CPU_INTENSIVE ones.
+	 * Kick @pool if necessary. It's always noop for per-cpu worker pools
+	 * since nr_running would always be >= 1 at this point. This is used to
+	 * chain execution of the pending work items for WORKER_NOT_RUNNING
+	 * workers such as the UNBOUND and CPU_INTENSIVE ones.
 	 */
-	if (need_more_worker(pool))
-		wake_up_worker(pool);
+	kick_pool(pool);
 
 	/*
 	 * Record the last pool and clear PENDING which should be the last
@@ -2852,12 +2852,10 @@ static int rescuer_thread(void *__rescuer)
 		put_pwq(pwq);
 
 		/*
-		 * Leave this pool.  If need_more_worker() is %true, notify a
-		 * regular worker; otherwise, we end up with 0 concurrency
-		 * and stalling the execution.
+		 * Leave this pool. Notify regular workers; otherwise, we end up
+		 * with 0 concurrency and stalling the execution.
 		 */
-		if (need_more_worker(pool))
-			wake_up_worker(pool);
+		kick_pool(pool);
 
 		raw_spin_unlock_irq(&pool->lock);
 
@@ -4068,24 +4066,13 @@ static void pwq_adjust_max_active(struct pool_workqueue *pwq)
 	 * is updated and visible.
 	 */
 	if (!freezable || !workqueue_freezing) {
-		bool kick = false;
-
 		pwq->max_active = wq->saved_max_active;
 
 		while (!list_empty(&pwq->inactive_works) &&
-		       pwq->nr_active < pwq->max_active) {
+		       pwq->nr_active < pwq->max_active)
 			pwq_activate_first_inactive(pwq);
-			kick = true;
-		}
 
-		/*
-		 * Need to kick a worker after thawed or an unbound wq's
-		 * max_active is bumped. In realtime scenarios, always kicking a
-		 * worker will cause interference on the isolated cpu cores, so
-		 * let's kick iff work items were activated.
-		 */
-		if (kick)
-			wake_up_worker(pwq->pool);
+		kick_pool(pwq->pool);
 	} else {
 		pwq->max_active = 0;
 	}
@@ -5351,7 +5338,7 @@ static void unbind_workers(int cpu)
 		 * worker blocking could lead to lengthy stalls.  Kick off
 		 * unbound chain execution of currently pending work items.
 		 */
-		wake_up_worker(pool);
+		kick_pool(pool);
 
 		raw_spin_unlock_irq(&pool->lock);
 
-- 
2.40.1

