Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E65C6FD403
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 05:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235280AbjEJDIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 23:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbjEJDIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 23:08:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6701994
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 20:08:13 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1aaea43def7so46147755ad.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 20:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683688093; x=1686280093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mdyIuzCEQXkuMCMgyrDXSrNFYsBJ81LFvpXdEhZyndE=;
        b=KF+RqwztN2NZt9pfLjeNVxLHOActmRjgW2a2Bjvrz/FwXmPpKnJgIu798OC/MZV2p5
         VCQOpzjCJLlQAf1MuoBQumqDZNDagmRb2DdslUqIBSnOLvfNa5zEopoUGQ6MaelyFAfc
         tCcVk3FzDXRlxHWx3awgzaEKkJybGh4/3XHPPXCXB//npFd5GRGo3J4HfGZNZtziyv/n
         pdzBaQD/GEZ7wHfGVJ7rT1h9vT0iE0EoifWGcMSAH6RzT8kK+QfS7HjMU04AG+fIgvoP
         qObHY70UDTbs+4ofd7x8h7LxE5/uI/udjIJoTeScUrs7dN3B5D6yWme/xM6YNYroDlZt
         JByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683688093; x=1686280093;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mdyIuzCEQXkuMCMgyrDXSrNFYsBJ81LFvpXdEhZyndE=;
        b=bYfM2z+rYIw/b0/zSIt9x9cHzYZAVRlJQKWaeoi4+jhvwXoD2yuethHhs61bgM+MDj
         7bRwi+WyrnG2w4pYmBViLbipfTknGFasOhDy0RlUShaaSOlJRSyXlYY718k0YWkhcPMT
         feVE9sl+2wHrRfpeoFmEHnFj72y/7boYjdxJUDEsqCuPSiUMu+NK39SIjQcB5sWqhsao
         XvfWYT21k9Exwqlyygo4D3yOlz2GzsNA7VSwM+ei5BuT70plFVT+5Ldwy78vmpChhx8y
         mR4HUSeLmZeZQoZa3Us797NTO+0h6EXza2PAcGC5AFCmTMCoEeeJL3/l59BztfPPWstW
         G+uA==
X-Gm-Message-State: AC+VfDxjUW+WIWhkdZyik6C+0QsGZmDjncVRA3O8/2O/I4HEy7TsskA1
        aNm2CyXZzfQncz2UMbxR3+YRWL45mRs=
X-Google-Smtp-Source: ACHHUZ57hGVF/muezA/SAkuROfDs+4BN9tM4MRvLt47M9MpE2CUehPOuJhXoVo3bHV9Yqnxe/ICnJA==
X-Received: by 2002:a17:902:f690:b0:1ab:29bc:bd87 with SMTP id l16-20020a170902f69000b001ab29bcbd87mr18643199plg.35.1683688092869;
        Tue, 09 May 2023 20:08:12 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id h6-20020a170902b94600b001ac78ac2cafsm2419642pls.239.2023.05.09.20.08.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 20:08:12 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
From:   Tejun Heo <tj@kernel.org>
To:     jiangshanlai@gmail.com
Cc:     torvalds@linux-foundation.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/6] workqueue, sched: Notify workqueue of scheduling of RUNNING and preempted tasks
Date:   Tue,  9 May 2023 17:07:47 -1000
Message-Id: <20230510030752.542340-2-tj@kernel.org>
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

When a workqueue kworker goes to sleep, wq_worker_sleeping() is called so
that workqueue can manage concurrency. This patch renames
wq_worker_sleeping() to wq_worker_stopping() and calls it whenever a kworker
is scheduled out whether it's going to sleep or not.

Workqueue will use the schedule-out events of RUNNING tasks to automatically
detect CPU hogging work items and exclude them from concurrency management
so that they can't stall other work items.

sched_submit_work() and sched_update_work() were only called by schedule().
As workqueue would need to be notified of all scheduling events including
preemptions, make the two functions notrace, add @sched_mode and call them
from all schedule functions. As wq_worker_sleeping() is now called from
preemption path, it's also marked notrace.

As sched_update_work() is noop when called !SM_NONE, it's debatable whether
it needs to be called from !SM_NONE paths. However, it shouldn't add any
actual overhead and is possibly less confusing to keep the symmetry. This
can go either way.

The only functional change is that wq_worker_sleeping() is now called from
all scheduling paths. As this patch adds early exit conditions which make it
noop in all new invocations, there shouldn't be any behavior change. While
at it, remove the already outdated comment which doesn't cover the io_wq
case.

v2: Lai pointed out that !SM_NONE cases should also be notified. Updated
    accordingly.

Signed-off-by: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 kernel/sched/core.c         | 48 ++++++++++++++++++++++++-------------
 kernel/workqueue.c          | 23 +++++++++++++-----
 kernel/workqueue_internal.h |  2 +-
 3 files changed, 49 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 944c3ae39861..ab4317a8e11a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6692,24 +6692,20 @@ void __noreturn do_task_dead(void)
 		cpu_relax();
 }
 
-static inline void sched_submit_work(struct task_struct *tsk)
+static inline notrace void sched_submit_work(struct task_struct *tsk,
+					     unsigned int sched_mode)
 {
-	unsigned int task_flags;
+	unsigned int task_flags = tsk->flags;
+	bool voluntary = sched_mode == SM_NONE;
 
-	if (task_is_running(tsk))
+	if (task_flags & PF_WQ_WORKER)
+		wq_worker_stopping(tsk, voluntary);
+
+	if (!voluntary || task_is_running(tsk))
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
@@ -6725,8 +6721,12 @@ static inline void sched_submit_work(struct task_struct *tsk)
 	blk_flush_plug(tsk->plug, true);
 }
 
-static void sched_update_worker(struct task_struct *tsk)
+static notrace void sched_update_worker(struct task_struct *tsk,
+					unsigned int sched_mode)
 {
+	if (sched_mode != SM_NONE)
+		return;
+
 	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
@@ -6739,13 +6739,13 @@ asmlinkage __visible void __sched schedule(void)
 {
 	struct task_struct *tsk = current;
 
-	sched_submit_work(tsk);
+	sched_submit_work(tsk, SM_NONE);
 	do {
 		preempt_disable();
 		__schedule(SM_NONE);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
-	sched_update_worker(tsk);
+	sched_update_worker(tsk, SM_NONE);
 }
 EXPORT_SYMBOL(schedule);
 
@@ -6808,17 +6808,24 @@ void __sched schedule_preempt_disabled(void)
 #ifdef CONFIG_PREEMPT_RT
 void __sched notrace schedule_rtlock(void)
 {
+	struct task_struct *tsk = current;
+
+	sched_submit_work(tsk, SM_RTLOCK_WAIT);
 	do {
 		preempt_disable();
 		__schedule(SM_RTLOCK_WAIT);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
+	sched_update_worker(tsk, SM_RTLOCK_WAIT);
 }
 NOKPROBE_SYMBOL(schedule_rtlock);
 #endif
 
 static void __sched notrace preempt_schedule_common(void)
 {
+	struct task_struct *tsk = current;
+
+	sched_submit_work(tsk, SM_PREEMPT);
 	do {
 		/*
 		 * Because the function tracer can trace preempt_count_sub()
@@ -6844,6 +6851,7 @@ static void __sched notrace preempt_schedule_common(void)
 		 * between schedule and now.
 		 */
 	} while (need_resched());
+	sched_update_worker(tsk, SM_PREEMPT);
 }
 
 #ifdef CONFIG_PREEMPTION
@@ -6901,11 +6909,13 @@ EXPORT_SYMBOL(dynamic_preempt_schedule);
  */
 asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 {
+	struct task_struct *tsk = current;
 	enum ctx_state prev_ctx;
 
 	if (likely(!preemptible()))
 		return;
 
+	sched_submit_work(tsk, SM_PREEMPT);
 	do {
 		/*
 		 * Because the function tracer can trace preempt_count_sub()
@@ -6934,6 +6944,7 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 		preempt_latency_stop(1);
 		preempt_enable_no_resched_notrace();
 	} while (need_resched());
+	sched_update_worker(tsk, SM_PREEMPT);
 }
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
@@ -6968,11 +6979,13 @@ EXPORT_SYMBOL(dynamic_preempt_schedule_notrace);
  */
 asmlinkage __visible void __sched preempt_schedule_irq(void)
 {
+	struct task_struct *tsk = current;
 	enum ctx_state prev_state;
 
 	/* Catch callers which need to be fixed */
 	BUG_ON(preempt_count() || !irqs_disabled());
 
+	sched_submit_work(tsk, SM_PREEMPT);
 	prev_state = exception_enter();
 
 	do {
@@ -6984,6 +6997,7 @@ asmlinkage __visible void __sched preempt_schedule_irq(void)
 	} while (need_resched());
 
 	exception_exit(prev_state);
+	sched_update_worker(tsk, SM_PREEMPT);
 }
 
 int default_wake_function(wait_queue_entry_t *curr, unsigned mode, int wake_flags,
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 4666a1a92a31..cbcdc11adabd 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -867,7 +867,10 @@ static void wake_up_worker(struct worker_pool *pool)
  * wq_worker_running - a worker is running again
  * @task: task waking up
  *
- * This function is called when a worker returns from schedule()
+ * This function is called when a worker returns from schedule().
+ *
+ * Unlike wq_worker_stopping(), this function is only called from schedule() but
+ * not other scheduling paths including preemption and can be traced safely.
  */
 void wq_worker_running(struct task_struct *task)
 {
@@ -890,17 +893,25 @@ void wq_worker_running(struct task_struct *task)
 }
 
 /**
- * wq_worker_sleeping - a worker is going to sleep
- * @task: task going to sleep
+ * wq_worker_stopping - a worker is stopping
+ * @task: task stopping
+ * @voluntary: being called from schedule()
+ *
+ * This function is called from scheduling paths including schedule() and
+ * preemption when a busy worker is going off the CPU.
  *
- * This function is called from schedule() when a busy worker is
- * going to sleep.
+ * As this function may be called from preempt_enable_notrace() and friends when
+ * !@voluntary, it must be notrace and limit reentrancy when @voluntary to avoid
+ * infinite recursions.
  */
-void wq_worker_sleeping(struct task_struct *task)
+void notrace wq_worker_stopping(struct task_struct *task, bool voluntary)
 {
 	struct worker *worker = kthread_data(task);
 	struct worker_pool *pool;
 
+	if (!voluntary || task_is_running(task))
+		return;
+
 	/*
 	 * Rescuers, which may not have all the fields set up like normal
 	 * workers, also reach here, let's not access anything before
diff --git a/kernel/workqueue_internal.h b/kernel/workqueue_internal.h
index e00b1204a8e9..c34b876af16d 100644
--- a/kernel/workqueue_internal.h
+++ b/kernel/workqueue_internal.h
@@ -75,7 +75,7 @@ static inline struct worker *current_wq_worker(void)
  * sched/ and workqueue.c.
  */
 void wq_worker_running(struct task_struct *task);
-void wq_worker_sleeping(struct task_struct *task);
+void wq_worker_stopping(struct task_struct *task, bool voluntary);
 work_func_t wq_worker_last_func(struct task_struct *task);
 
 #endif /* _KERNEL_WORKQUEUE_INTERNAL_H */
-- 
2.40.1

