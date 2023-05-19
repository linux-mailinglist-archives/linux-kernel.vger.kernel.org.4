Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB78A708CC8
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231163AbjESATT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231150AbjESASq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:18:46 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C06C1736
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:27 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1ac4910e656so2124345ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 May 2023 17:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684455490; x=1687047490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3FMjv/w/Hp/nkhV0xFtUdgAGxV0/BekPEmbNAHbOcSE=;
        b=gqdPupC7vG9dxYRsXYbW/7FUu59mI8lZh+ewJbmTyUiXR7IeYYoNamJ3rNtuVFR+NG
         sD21MSBH4XRpLtELOuJ1T40jCbOf/Kjn1S8PE8FNsmSMPJK4r723baayCUYonk5lMCCo
         ozIk/oj/0fkj+6LcOr/6+uCIR9rVOr5l7P+qEemlZGvY7VXXWo7YBf6RZlD+x3IiK7ar
         QtditnhPhuT7jy5TrH1vEHqTQiZcn8MeVZQlECkckbu8YtvuOsLFgXAnaOn6JgdAIiVX
         cmVmurae7SDV8G5Q3GDsZhGdaKnmkJCHwb3sJCCpVKemqgFFfsisGd8bOiQcxhvO0gp+
         C3AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684455490; x=1687047490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3FMjv/w/Hp/nkhV0xFtUdgAGxV0/BekPEmbNAHbOcSE=;
        b=USGzaexB4iHs7cC5S/nhlIcBEFEsArA6kr0n48pdiLjohFl6VgUFNt8XKMx3xgfOMf
         ZO9Es1+wc9aHxvHc5nNRHaDuU3EVApZjO3YYAzUeBnVxaxSHglfvHxxwY4vH+0O1nU9q
         mhG0aCD5uRA/+PmS3b2V85/Q2kwsyv/BeHsxH3ruKXVK6jUw/NbRE1wAq8Jucp37h4jn
         us5m08QCg3WGs+G3yb/nDnlthi2JY0raxMAn1/GNcdSPDvjqfBXal7qV84kvToW/7HIQ
         glsYWR+m+sOvEbjS8sjtVjsnS4Edj5ALzkPigkM7ZAbF6DCU50DX30asDnaB9ig/GY0S
         jHiQ==
X-Gm-Message-State: AC+VfDx2bs7fHaNZtoZltvYqPjSSdK8f0+Qk8NGnohr2EIQz6gxpJmU8
        enoi5TBzVUr4/ZJlRufWNBk=
X-Google-Smtp-Source: ACHHUZ6mwZggezIpQGFRtf8SEM/jJlOH+SahR1pdQmpsyZrrjV2zhYMvaL6A0ZDzy1Xpu+o8+VIkvA==
X-Received: by 2002:a17:902:c410:b0:1aa:d4ba:de2 with SMTP id k16-20020a170902c41000b001aad4ba0de2mr1214743plk.18.1684455489854;
        Thu, 18 May 2023 17:18:09 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id d20-20020a170902c19400b001a1a07d04e6sm2061759pld.77.2023.05.18.17.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 17:18:09 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        joshdon@google.com, brho@google.com, briannorris@chromium.org,
        nhuck@google.com, agk@redhat.com, snitzer@kernel.org,
        void@manifault.com, Tejun Heo <tj@kernel.org>
Subject: [PATCH 18/24] workqueue: Factor out work to worker assignment and collision handling
Date:   Thu, 18 May 2023 14:17:03 -1000
Message-Id: <20230519001709.2563-19-tj@kernel.org>
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

The two work execution paths in worker_thread() and rescuer_thread() use
move_linked_works() to claim work items from @pool->worklist. Once claimed,
process_schedule_works() is called which invokes process_one_work() on each
work item. process_one_work() then uses find_worker_executing_work() to
detect and handle collisions - situations where the work item to be executed
is still running on another worker.

This works fine, but, to improve work execution locality, we want to
establish work to worker association earlier and know for sure that the
worker is going to excute the work once asssigned, which requires performing
collision handling earlier while trying to assign the work item to the
worker.

This patch introduces assign_work() which assigns a work item to a worker
using move_linked_works() and then performs collision handling. As collision
handling is handled earlier, process_one_work() no longer needs to worry
about them.

After the this patch, collision checks for linked work items are skipped,
which should be fine as they can't be queued multiple times concurrently.
For work items running from rescuers, the timing of collision handling may
change but the invariant that the work items go through collision handling
before starting execution does not.

This patch shouldn't cause noticeable behavior changes, especially given
that worker_thread() behavior remains the same.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 80 ++++++++++++++++++++++++++++++----------------
 1 file changed, 52 insertions(+), 28 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index bb0900602408..a2e6c2be3a06 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1015,13 +1015,10 @@ static struct worker *find_worker_executing_work(struct worker_pool *pool,
  * @head: target list to append @work to
  * @nextp: out parameter for nested worklist walking
  *
- * Schedule linked works starting from @work to @head.  Work series to
- * be scheduled starts at @work and includes any consecutive work with
- * WORK_STRUCT_LINKED set in its predecessor.
- *
- * If @nextp is not NULL, it's updated to point to the next work of
- * the last scheduled work.  This allows move_linked_works() to be
- * nested inside outer list_for_each_entry_safe().
+ * Schedule linked works starting from @work to @head. Work series to be
+ * scheduled starts at @work and includes any consecutive work with
+ * WORK_STRUCT_LINKED set in its predecessor. See assign_work() for details on
+ * @nextp.
  *
  * CONTEXT:
  * raw_spin_lock_irq(pool->lock).
@@ -1050,6 +1047,48 @@ static void move_linked_works(struct work_struct *work, struct list_head *head,
 		*nextp = n;
 }
 
+/**
+ * assign_work - assign a work item and its linked work items to a worker
+ * @work: work to assign
+ * @worker: worker to assign to
+ * @nextp: out parameter for nested worklist walking
+ *
+ * Assign @work and its linked work items to @worker. If @work is already being
+ * executed by another worker in the same pool, it'll be punted there.
+ *
+ * If @nextp is not NULL, it's updated to point to the next work of the last
+ * scheduled work. This allows assign_work() to be nested inside
+ * list_for_each_entry_safe().
+ *
+ * Returns %true if @work was successfully assigned to @worker. %false if @work
+ * was punted to another worker already executing it.
+ */
+static bool assign_work(struct work_struct *work, struct worker *worker,
+			struct work_struct **nextp)
+{
+	struct worker_pool *pool = worker->pool;
+	struct worker *collision;
+
+	lockdep_assert_held(&pool->lock);
+
+	/*
+	 * A single work shouldn't be executed concurrently by multiple workers.
+	 * __queue_work() ensures that @work doesn't jump to a different pool
+	 * while still running in the previous pool. Here, we should ensure that
+	 * @work is not executed concurrently by multiple workers from the same
+	 * pool. Check whether anyone is already processing the work. If so,
+	 * defer the work to the currently executing one.
+	 */
+	collision = find_worker_executing_work(pool, work);
+	if (unlikely(collision)) {
+		move_linked_works(work, &collision->scheduled, nextp);
+		return false;
+	}
+
+	move_linked_works(work, &worker->scheduled, nextp);
+	return true;
+}
+
 /**
  * wake_up_worker - wake up an idle worker
  * @pool: worker pool to wake worker from
@@ -2442,7 +2481,6 @@ __acquires(&pool->lock)
 	struct pool_workqueue *pwq = get_work_pwq(work);
 	struct worker_pool *pool = worker->pool;
 	unsigned long work_data;
-	struct worker *collision;
 #ifdef CONFIG_LOCKDEP
 	/*
 	 * It is permissible to free the struct work_struct from
@@ -2459,18 +2497,6 @@ __acquires(&pool->lock)
 	WARN_ON_ONCE(!(pool->flags & POOL_DISASSOCIATED) &&
 		     raw_smp_processor_id() != pool->cpu);
 
-	/*
-	 * A single work shouldn't be executed concurrently by
-	 * multiple workers on a single cpu.  Check whether anyone is
-	 * already processing the work.  If so, defer the work to the
-	 * currently executing one.
-	 */
-	collision = find_worker_executing_work(pool, work);
-	if (unlikely(collision)) {
-		move_linked_works(work, &collision->scheduled, NULL);
-		return;
-	}
-
 	/* claim and dequeue */
 	debug_work_deactivate(work);
 	hash_add(pool->busy_hash, &worker->hentry, (unsigned long)work);
@@ -2697,8 +2723,8 @@ static int worker_thread(void *__worker)
 			list_first_entry(&pool->worklist,
 					 struct work_struct, entry);
 
-		move_linked_works(work, &worker->scheduled, NULL);
-		process_scheduled_works(worker);
+		if (assign_work(work, worker, NULL))
+			process_scheduled_works(worker);
 	} while (keep_working(pool));
 
 	worker_set_flags(worker, WORKER_PREP);
@@ -2742,7 +2768,6 @@ static int rescuer_thread(void *__rescuer)
 {
 	struct worker *rescuer = __rescuer;
 	struct workqueue_struct *wq = rescuer->rescue_wq;
-	struct list_head *scheduled = &rescuer->scheduled;
 	bool should_stop;
 
 	set_user_nice(current, RESCUER_NICE_LEVEL);
@@ -2787,15 +2812,14 @@ static int rescuer_thread(void *__rescuer)
 		 * Slurp in all works issued via this workqueue and
 		 * process'em.
 		 */
-		WARN_ON_ONCE(!list_empty(scheduled));
+		WARN_ON_ONCE(!list_empty(&rescuer->scheduled));
 		list_for_each_entry_safe(work, n, &pool->worklist, entry) {
-			if (get_work_pwq(work) == pwq) {
-				move_linked_works(work, scheduled, &n);
+			if (get_work_pwq(work) == pwq &&
+			    assign_work(work, rescuer, &n))
 				pwq->stats[PWQ_STAT_RESCUED]++;
-			}
 		}
 
-		if (!list_empty(scheduled)) {
+		if (!list_empty(&rescuer->scheduled)) {
 			process_scheduled_works(rescuer);
 
 			/*
-- 
2.40.1

