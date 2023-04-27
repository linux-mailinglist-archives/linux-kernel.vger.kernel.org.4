Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0886D6F04DB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:20:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243703AbjD0LUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243620AbjD0LTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:19:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7B4C2B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:19:45 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682594383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAuLWDQMB55lcnDvQBz27uhWcaqTSuhCvrx4iirveNU=;
        b=BmkA1tCRKTr0kyPsvHU5Dx2g8M0ALymErOFL9wJnFzO+sFQX9zAW50FDQ6L+v5BlNr180F
        h/yyXzQs3uUjMuEpDYrNzEJMXW9k33YY3s6f/HN+9dj+yfr+6CZicnl82w8xi1IINnwqZo
        KynDhU/i5Sl6SrfL8yh7366jKIoQ6zeAnzqB4MzH2i6fhBH/w/Alk/0IZA/gLB1seLiuHS
        M7eRYEVwI7wieHXdEH6c7CyySRdzp70Jm4oTJvb2i7wpW1p07San6NlgxBhYUqBIHSMBgA
        sYSI9VDdjVS3rG4v1zEPM9dWBRhBh/U/i8slHSCDU/Ce+3prrQ5YKELIKVjfng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682594383;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nAuLWDQMB55lcnDvQBz27uhWcaqTSuhCvrx4iirveNU=;
        b=bs2EIpLBPRPQy4OQl6bI+zwRt6XERNPrd+Q1YXGQ6JTJocNYKkDZVwlZMK047VgIn5/kja
        YCoZjm/To83YB5BQ==
To:     linux-kernel@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>, Boqun Feng <boqun.feng@gmail.com>,
        Crystal Wood <swood@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        John Stultz <jstultz@google.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 1/4] sched/core: Provide sched_rtmutex() and expose sched work helpers
Date:   Thu, 27 Apr 2023 13:19:34 +0200
Message-Id: <20230427111937.2745231-2-bigeasy@linutronix.de>
In-Reply-To: <20230427111937.2745231-1-bigeasy@linutronix.de>
References: <20230427111937.2745231-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

schedule() invokes sched_submit_work() before scheduling and
sched_update_worker() afterwards to ensure that queued block requests are
flushed and the (IO)worker machineries can instantiate new workers if
required. This avoids deadlocks and starvation.

With rt_mutexes this can lead to subtle problem:

  When rtmutex blocks current::pi_blocked_on points to the rtmutex it
  blocks on. When one of the functions in sched_submit/resume_work()
  contends on a rtmutex based lock then that would corrupt
  current::pi_blocked_on.

Make it possible to let rtmutex issue the calls outside of the slowpath,
i.e. when it is guaranteed that current::pi_blocked_on is NULL, by:

  - Exposing sched_submit_work() and moving the task_running() condition
    into schedule()

  - Renamimg sched_update_worker() to sched_resume_work() and exposing it
    too.

  - Providing sched_rtmutex() which just does the inner loop of scheduling
    until need_resched() is not longer set. Split out the loop so this does
    not create yet another copy.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 include/linux/sched.h |  5 +++++
 kernel/sched/core.c   | 40 ++++++++++++++++++++++------------------
 2 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 675298d6eb362..ff1ce66d8b6e3 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -304,6 +304,11 @@ extern long schedule_timeout_idle(long timeout);
 asmlinkage void schedule(void);
 extern void schedule_preempt_disabled(void);
 asmlinkage void preempt_schedule_irq(void);
+
+extern void sched_submit_work(void);
+extern void sched_resume_work(void);
+extern void schedule_rtmutex(void);
+
 #ifdef CONFIG_PREEMPT_RT
  extern void schedule_rtlock(void);
 #endif
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c415418b0b847..7c5cfae086c78 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6690,14 +6690,11 @@ void __noreturn do_task_dead(void)
 		cpu_relax();
 }
=20
-static inline void sched_submit_work(struct task_struct *tsk)
+void sched_submit_work(void)
 {
-	unsigned int task_flags;
+	struct task_struct *tsk =3D current;
+	unsigned int task_flags =3D tsk->flags;
=20
-	if (task_is_running(tsk))
-		return;
-
-	task_flags =3D tsk->flags;
 	/*
 	 * If a worker goes to sleep, notify and ask workqueue whether it
 	 * wants to wake up a task to maintain concurrency.
@@ -6723,8 +6720,10 @@ static inline void sched_submit_work(struct task_str=
uct *tsk)
 	blk_flush_plug(tsk->plug, true);
 }
=20
-static void sched_update_worker(struct task_struct *tsk)
+void sched_resume_work(void)
 {
+	struct task_struct *tsk =3D current;
+
 	if (tsk->flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
 		if (tsk->flags & PF_WQ_WORKER)
 			wq_worker_running(tsk);
@@ -6733,20 +6732,29 @@ static void sched_update_worker(struct task_struct =
*tsk)
 	}
 }
=20
-asmlinkage __visible void __sched schedule(void)
+static void schedule_loop(unsigned int sched_mode)
 {
-	struct task_struct *tsk =3D current;
-
-	sched_submit_work(tsk);
 	do {
 		preempt_disable();
-		__schedule(SM_NONE);
+		__schedule(sched_mode);
 		sched_preempt_enable_no_resched();
 	} while (need_resched());
-	sched_update_worker(tsk);
+}
+
+asmlinkage __visible void __sched schedule(void)
+{
+	if (!task_is_running(current))
+		sched_submit_work();
+	schedule_loop(SM_NONE);
+	sched_resume_work();
 }
 EXPORT_SYMBOL(schedule);
=20
+void schedule_rtmutex(void)
+{
+	schedule_loop(SM_NONE);
+}
+
 /*
  * synchronize_rcu_tasks() makes sure that no task is stuck in preempted
  * state (have scheduled out non-voluntarily) by making sure that all
@@ -6806,11 +6814,7 @@ void __sched schedule_preempt_disabled(void)
 #ifdef CONFIG_PREEMPT_RT
 void __sched notrace schedule_rtlock(void)
 {
-	do {
-		preempt_disable();
-		__schedule(SM_RTLOCK_WAIT);
-		sched_preempt_enable_no_resched();
-	} while (need_resched());
+	schedule_loop(SM_RTLOCK_WAIT);
 }
 NOKPROBE_SYMBOL(schedule_rtlock);
 #endif
--=20
2.40.1

