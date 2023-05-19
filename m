Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E03CA708CB9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbjESARv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjESARn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:17:43 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3C0E0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:41 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-53469299319so1127328a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455461; x=1687047461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mQwCMgvu2VcS9enL8hvYeXtHxlRMITrajrDxqgjGaCA=;
        b=dINA6O1E+wWjh43Uq8aD2hjsTsjgcYQx5psqEDoYUb75QqvVB6EOkS7v43SrOXkvbx
         bX4YyK4mxUHpqlTIwyZMyAVnA/NEiQi4xQGC0IHbQvxSN/zID3rRlrI2cyvtARhLx4CD
         ZSm5VlhSOdx2Lh03NxR6pUXo72O7hdvNNzsoMlaw25+UO016RUFiiu+6T5WLgeT8+9Co
         wlrYYcxv9aDycB8lZIpZS2Rf/omOttafHbXdgdLDOh43GxxYVCoHe1mcPjmACVnRUK9E
         r9rE4XBvv6/hIy7C9cn+hYvq4ieJEWUihsSIpJMFYt+1ekYWrJvVQpOYWGh5iW9F91V3
         BdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455461; x=1687047461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mQwCMgvu2VcS9enL8hvYeXtHxlRMITrajrDxqgjGaCA=;
        b=OPa8ttIQmlfZHjC1kK9kr6G2giTVMFFaPde3o0OjmD3SW1IMtPXMzWv+kglTyeJKMF
         wSAiqcYczSbBCGVyzTEUZRh5QKZbJXT3Cn8UASB3R1oTrrnHhfalC55+4s0VwNxz/0KW
         7yjJ4kD7wvkXelxA5Tvl561wv/85jRMl2q5bnQbxgk/xE9H6ASseZBmrwOL88WjFM77Y
         Lzm5bHV+fFbR9zEDyWopV11LOQhS5/X3Wasz0mPnL+xEYH8oJ67J8cTn0afsD+dQZXLF
         6LJvMNSRMe48tIxHvHiMN1pH/taWMzq/myOR7CKrvrwRIiP9iGWqgHyQcdxJzRNvJAQW
         ISwA==
X-Gm-Message-State: AC+VfDyx43+Pk+ejOTxJ01UCs3PTrE9R6LCkeGEXnvOgbxjo2GxqRODD
        JSSHMCriSJr1DblcTrs4RVc=
X-Google-Smtp-Source: ACHHUZ5ZybYFC9rL+tZubyJSc/kRn1GfWdOwLDhVkj4WO7fOd2CveuUrcccs5+pNRWrWOkyU25NFbA==
X-Received: by 2002:a17:903:32cb:b0:1a6:4606:6e06 with SMTP id i11-20020a17090332cb00b001a646066e06mr1139601plr.17.1684455461381;
        Thu, 18 May 2023 17:17:41 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x8-20020a170902a38800b001aaf536b1e3sm2068143pla.123.2023.05.18.17.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:17:40 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 03/24] workqueue: Not all work insertion needs to wake up a worker
Date:   Thu, 18 May 2023 14:16:48 -1000
Message-Id: <20230519001709.2563-4-tj@kernel.org>
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

insert_work() always tried to wake up a worker; however, the only time it
needs to try to wake up a worker is when a new active work item is queued.
When a work item goes on the inactive list or queueing a flush work item,
there's no reason to try to wake up a worker.

This patch moves the worker wakeup logic out of insert_work() and places it
in the active new work item queueing path in __queue_work().

While at it:

* __queue_work() is dereferencing pwq->pool repeatedly. Add local variable
  pool.

* Every caller of insert_work() calls debug_work_activate(). Consolidate the
  invocations into insert_work().

* In __queue_work() pool->watchdog_ts update is relocated slightly. This is
  to better accommodate future changes.

This makes wakeups more precise and will help the planned change to assign
work items to workers before waking them up. No behavior changes intended.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 37 ++++++++++++++++++-------------------
 1 file changed, 18 insertions(+), 19 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c1e56ba4a038..0d5eb436d31a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1523,7 +1523,7 @@ static int try_to_grab_pending(struct work_struct *work, bool is_dwork,
 static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 			struct list_head *head, unsigned int extra_flags)
 {
-	struct worker_pool *pool = pwq->pool;
+	debug_work_activate(work);
 
 	/* record the work call stack in order to print it in KASAN reports */
 	kasan_record_aux_stack_noalloc(work);
@@ -1532,9 +1532,6 @@ static void insert_work(struct pool_workqueue *pwq, struct work_struct *work,
 	set_work_pwq(work, pwq, extra_flags);
 	list_add_tail(&work->entry, head);
 	get_pwq(pwq);
-
-	if (__need_more_worker(pool))
-		wake_up_worker(pool);
 }
 
 /*
@@ -1588,8 +1585,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 			 struct work_struct *work)
 {
 	struct pool_workqueue *pwq;
-	struct worker_pool *last_pool;
-	struct list_head *worklist;
+	struct worker_pool *last_pool, *pool;
 	unsigned int work_flags;
 	unsigned int req_cpu = cpu;
 
@@ -1623,13 +1619,15 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 		pwq = per_cpu_ptr(wq->cpu_pwqs, cpu);
 	}
 
+	pool = pwq->pool;
+
 	/*
 	 * If @work was previously on a different pool, it might still be
 	 * running there, in which case the work needs to be queued on that
 	 * pool to guarantee non-reentrancy.
 	 */
 	last_pool = get_work_pool(work);
-	if (last_pool && last_pool != pwq->pool) {
+	if (last_pool && last_pool != pool) {
 		struct worker *worker;
 
 		raw_spin_lock(&last_pool->lock);
@@ -1638,13 +1636,14 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 
 		if (worker && worker->current_pwq->wq == wq) {
 			pwq = worker->current_pwq;
+			pool = pwq->pool;
 		} else {
 			/* meh... not running there, queue here */
 			raw_spin_unlock(&last_pool->lock);
-			raw_spin_lock(&pwq->pool->lock);
+			raw_spin_lock(&pool->lock);
 		}
 	} else {
-		raw_spin_lock(&pwq->pool->lock);
+		raw_spin_lock(&pool->lock);
 	}
 
 	/*
@@ -1657,7 +1656,7 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	 */
 	if (unlikely(!pwq->refcnt)) {
 		if (wq->flags & WQ_UNBOUND) {
-			raw_spin_unlock(&pwq->pool->lock);
+			raw_spin_unlock(&pool->lock);
 			cpu_relax();
 			goto retry;
 		}
@@ -1676,21 +1675,22 @@ static void __queue_work(int cpu, struct workqueue_struct *wq,
 	work_flags = work_color_to_flags(pwq->work_color);
 
 	if (likely(pwq->nr_active < pwq->max_active)) {
+		if (list_empty(&pool->worklist))
+			pool->watchdog_ts = jiffies;
+
 		trace_workqueue_activate_work(work);
 		pwq->nr_active++;
-		worklist = &pwq->pool->worklist;
-		if (list_empty(worklist))
-			pwq->pool->watchdog_ts = jiffies;
+		insert_work(pwq, work, &pool->worklist, work_flags);
+
+		if (__need_more_worker(pool))
+			wake_up_worker(pool);
 	} else {
 		work_flags |= WORK_STRUCT_INACTIVE;
-		worklist = &pwq->inactive_works;
+		insert_work(pwq, work, &pwq->inactive_works, work_flags);
 	}
 
-	debug_work_activate(work);
-	insert_work(pwq, work, worklist, work_flags);
-
 out:
-	raw_spin_unlock(&pwq->pool->lock);
+	raw_spin_unlock(&pool->lock);
 	rcu_read_unlock();
 }
 
@@ -2994,7 +2994,6 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 	pwq->nr_in_flight[work_color]++;
 	work_flags |= work_color_to_flags(work_color);
 
-	debug_work_activate(&barr->work);
 	insert_work(pwq, &barr->work, head, work_flags);
 }
 
-- 
2.40.1

