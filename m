Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5866E6DB4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 22:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbjDRUwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 16:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232740AbjDRUwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 16:52:11 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F98BA0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-247048f86c7so1350862a91.2
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 13:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681851129; x=1684443129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1wusuTviJzFnYrvF5N6mC+TqPux3bAWpP9Y7s3wD8Y=;
        b=DF/9vGOvXBl/6rB2kFsLQ7h9jjj/MWltLPFLWWY+rErkU4SiE9fLPZApTSDsUiK1TH
         ozLsH7V7NZp3BzIK9t83rVPiY54OLKc1TctLwCdU9WnLJDgfdEf3WPNH/78R6EYDVA1L
         OyY6yQipPxhH1UJM9IqP2etFI8FnTNp+YLWvU7KIBuKqvhtVmxD2gVGd6v0BmA3TH1lA
         IhKPVh6IP3BlkdR542LDSkG3H0Z3GJ62pnj7g038ou6VQCm4xwSBeIv6JqFQeMjaz2Y3
         hROyq6XZwvodyPd8XREhh59oL2Mds7p6Rw+p1RvzQ6eTriw0VT4ujS48CyvQKmmnN9FP
         uQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681851129; x=1684443129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1wusuTviJzFnYrvF5N6mC+TqPux3bAWpP9Y7s3wD8Y=;
        b=cLzvFK9fCkMfziP9yPkwR8Ho+UsrHxg9cZ+nSoy58pLF6yMjti4VYohw7Y0IPp0Hdq
         7vqWB1LpPYq8VF7VhuQUQhCErgZ/7YLWlnHL3cP+92iutj3YuOjN8vIqCEVK9DSp+P8n
         Y53Cgly8EvhurB/VKkw65gVPJgXSDqRfffcx/AHoobvnmIzWeIIbIZ3MHg1mneTu+KJU
         Ckcw3bryh0+FwEsmnNNiqwD3PN/3x8o8j0inXMdVuPNUl+L3NSEXzazebaebaFV4v2rp
         F/8UTKOus1jw2tjVjZcHRlVbs5b/h+NDcSYsVKGfLRZkiNkXw8ZxD0CWMQeiGsvC9gMp
         rmpg==
X-Gm-Message-State: AAQBX9cE9r1iciZ46ZB2azovNOTuAWklxFptw9XTfwDTxjHg8FVk5Hej
        NYfxLeETfXEdr0fzdGNVijc=
X-Google-Smtp-Source: AKy350bn5focHIEE6GhsW1PTJ9itHxP5G7oO2QwV6jl8MPNRAdpHufekQeBvBz0vDuFD7hgifFi2EA==
X-Received: by 2002:a17:90a:e7c5:b0:247:1c17:77eb with SMTP id kb5-20020a17090ae7c500b002471c1777ebmr815743pjb.27.1681851128519;
        Tue, 18 Apr 2023 13:52:08 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id l23-20020a17090aaa9700b00231227781d5sm26466pjq.2.2023.04.18.13.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:52:08 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/5] workqueue, sched: Notify workqueue of scheduling of RUNNING tasks
Date:   Tue, 18 Apr 2023 10:51:55 -1000
Message-Id: <20230418205159.724789-2-tj@kernel.org>
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

When a workqueue kworker goes to sleep, wq_worker_sleeping() is called so
that workqueue can manage concurrency. This patch renames
wq_worker_sleeping() to wq_worker_stopping() can calls it whenever a kworker
is scheduled out whether it's going to sleep or not.

Workqueue will use the schedule-out event of running tasks to automatically
detect CPU hogging work items and exclude them from concurrency management
so that they can't stall other work items.

This patch just moves the task_is_running() test from sched_submit_work() to
wq_worker_stopping(). No behavior change is intended. While at it, remove
the already outdated comment which doesn't cover the io_wq case.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c         | 18 ++++++------------
 kernel/workqueue.c          | 13 ++++++++-----
 kernel/workqueue_internal.h |  2 +-
 3 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0d18c3969f90..1d83ff00d587 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6650,22 +6650,16 @@ void __noreturn do_task_dead(void)
 
 static inline void sched_submit_work(struct task_struct *tsk)
 {
-	unsigned int task_flags;
+	unsigned int task_flags = tsk->flags;
+
+	if (task_flags & PF_WQ_WORKER)
+		wq_worker_stopping(tsk);
 
 	if (task_is_running(tsk))
 		return;
 
-	task_flags = tsk->flags;
-	/*
-	 * If a worker goes to sleep, notify and ask workqueue whether it
-	 * wants to wake up a task to maintain concurrency.
-	 */
-	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
-		if (task_flags & PF_WQ_WORKER)
-			wq_worker_sleeping(tsk);
-		else
-			io_wq_worker_sleeping(tsk);
-	}
+	if (task_flags & PF_IO_WORKER)
+		io_wq_worker_sleeping(tsk);
 
 	/*
 	 * spinlock and rwlock must not flush block requests.  This will
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index b8b541caed48..6199fbf10cec 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -886,17 +886,20 @@ void wq_worker_running(struct task_struct *task)
 }
 
 /**
- * wq_worker_sleeping - a worker is going to sleep
- * @task: task going to sleep
+ * wq_worker_stopping - a worker is stopping
+ * @task: task stopping
  *
- * This function is called from schedule() when a busy worker is
- * going to sleep.
+ * This function is called from schedule() when a busy worker is going off the
+ * CPU.
  */
-void wq_worker_sleeping(struct task_struct *task)
+void wq_worker_stopping(struct task_struct *task)
 {
 	struct worker *worker = kthread_data(task);
 	struct worker_pool *pool;
 
+	if (task_is_running(task))
+		return;
+
 	/*
 	 * Rescuers, which may not have all the fields set up like normal
 	 * workers, also reach here, let's not access anything before
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index e00b1204a8e9..b3b4b2b41d93 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -75,7 +75,7 @@ static inline struct worker *current_wq_worker(void)
  * sched/ and workqueue.c.
  */
 void wq_worker_running(struct task_struct *task);
-void wq_worker_sleeping(struct task_struct *task);
+void wq_worker_stopping(struct task_struct *task);
 work_func_t wq_worker_last_func(struct task_struct *task);
 
 #endif /* _KERNEL_WORKQUEUE_INTERNAL_H */
-- 
2.40.0

