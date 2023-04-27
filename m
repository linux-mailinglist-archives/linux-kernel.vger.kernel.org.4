Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CDFC6F04E0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 13:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243644AbjD0LUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 07:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243559AbjD0LTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 07:19:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81A85244
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 04:19:45 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682594384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORxxMGTCqHCTuORmt0+70Mqp063X5vrWfREdzEDLbVo=;
        b=Gck4aSMK7OncrecOxwvKthriuTS5Inm5bndSjBt2etXMraZlGX5LwTrbipYyQ6g+FnQu7h
        D6VO9eIYi36JjwEB3OCkJEUB+hzWOrMTB9oFx68JZ0joHQ/j1+OXUA23QKOJD/Irt90G4m
        AJ1/SGpsJ8EzpzsVkIInAWp1z1bKq3hyaegCCjfuUiaPcd7mKKHZACmSqT7tg26AeLB58k
        GIp+cL1HPMrZgUpwvV3i4rZhC1h1KNAqecJ+RWhFLIyfm+s2Eztv1AUGFfvWjdxVEFewXi
        f1H2Nnqw3ZVdehzB5XEfdU1SKHPeX65QMa4VXdOe+kbrNXEmJiIXPJt/dJXczw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682594384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ORxxMGTCqHCTuORmt0+70Mqp063X5vrWfREdzEDLbVo=;
        b=kTs6IfxYm3EWHR6adfgx1jpJcNw3wEw7YFL0cGjAZtgwI9WLXPj1tvs402v/43ghvrNppo
        dLNHVFDlqOO0g8BQ==
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
Subject: [PATCH v2 2/4] locking/rtmutex: Submit/resume work explicitly before/after blocking
Date:   Thu, 27 Apr 2023 13:19:35 +0200
Message-Id: <20230427111937.2745231-3-bigeasy@linutronix.de>
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

schedule() invokes sched_submit_work() before scheduling and
sched_resume_work() afterwards to ensure that queued block requests are
flushed and the (IO)worker machineries can instantiate new workers if
required. This avoids deadlocks and starvation.

With rt_mutexes this can lead to a subtle problem:

  When rtmutex blocks current::pi_blocked_on points to the rtmutex it
  blocks on. When one of the functions in sched_submit/resume_work() conten=
ds
  on a rtmutex based lock then that would corrupt current::pi_blocked_on.

Let rtmutex and the RT lock variants which are based on it invoke
sched_submit/resume_work() explicitly before and after the slowpath so
it's guaranteed that current::pi_blocked_on cannot be corrupted by blocking
on two locks.

This does not apply to the PREEMPT_RT variants of spinlock_t and rwlock_t
as their scheduling slowpath is separate and cannot invoke the work related
functions due to potential deadlocks anyway.

[ tglx: Make it explicit and symmetric. Massage changelog ]

Fixes: e17ba59b7e8e1 ("locking/rtmutex: Guard regular sleeping locks specif=
ic functions")
Reported-by: Crystal Wood <swood@redhat.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/4b4ab374d3e24e6ea8df5cadc4297619a6d945af.came=
l@redhat.com
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/locking/rtmutex.c     | 11 +++++++++--
 kernel/locking/rwbase_rt.c   | 18 ++++++++++++++++--
 kernel/locking/rwsem.c       |  6 ++++++
 kernel/locking/spinlock_rt.c |  3 +++
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 728f434de2bbf..aa66a3c5950a7 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1555,7 +1555,7 @@ static int __sched rt_mutex_slowlock_block(struct rt_=
mutex_base *lock,
 		raw_spin_unlock_irq(&lock->wait_lock);
=20
 		if (!owner || !rtmutex_spin_on_owner(lock, waiter, owner))
-			schedule();
+			schedule_rtmutex();
=20
 		raw_spin_lock_irq(&lock->wait_lock);
 		set_current_state(state);
@@ -1584,7 +1584,7 @@ static void __sched rt_mutex_handle_deadlock(int res,=
 int detect_deadlock,
 	WARN(1, "rtmutex deadlock detected\n");
 	while (1) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		schedule();
+		schedule_rtmutex();
 	}
 }
=20
@@ -1679,6 +1679,12 @@ static int __sched rt_mutex_slowlock(struct rt_mutex=
_base *lock,
 	unsigned long flags;
 	int ret;
=20
+	/*
+	 * The task is about to sleep. Invoke sched_submit_work() before
+	 * blocking as that might take locks and corrupt tsk::pi_blocked_on.
+	 */
+	sched_submit_work();
+
 	/*
 	 * Technically we could use raw_spin_[un]lock_irq() here, but this can
 	 * be called in early boot if the cmpxchg() fast path is disabled
@@ -1691,6 +1697,7 @@ static int __sched rt_mutex_slowlock(struct rt_mutex_=
base *lock,
 	ret =3D __rt_mutex_slowlock_locked(lock, ww_ctx, state);
 	raw_spin_unlock_irqrestore(&lock->wait_lock, flags);
=20
+	sched_resume_work();
 	return ret;
 }
=20
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 25ec0239477c2..945d474f5d27f 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -131,10 +131,21 @@ static int __sched __rwbase_read_lock(struct rwbase_r=
t *rwb,
 static __always_inline int rwbase_read_lock(struct rwbase_rt *rwb,
 					    unsigned int state)
 {
+	int ret;
+
 	if (rwbase_read_trylock(rwb))
 		return 0;
=20
-	return __rwbase_read_lock(rwb, state);
+	/*
+	 * The task is about to sleep. For rwsems this submits work as that
+	 * might take locks and corrupt tsk::pi_blocked_on. Must be
+	 * explicit here because __rwbase_read_lock() cannot invoke
+	 * rt_mutex_slowlock(). NOP for rwlocks.
+	 */
+	rwbase_sched_submit_work();
+	ret =3D __rwbase_read_lock(rwb, state);
+	rwbase_sched_resume_work();
+	return ret;
 }
=20
 static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
@@ -230,7 +241,10 @@ static int __sched rwbase_write_lock(struct rwbase_rt =
*rwb,
 	struct rt_mutex_base *rtm =3D &rwb->rtmutex;
 	unsigned long flags;
=20
-	/* Take the rtmutex as a first step */
+	/*
+	 * Take the rtmutex as a first step. For rwsem this will also
+	 * invoke sched_submit_work() to flush IO and workers.
+	 */
 	if (rwbase_rtmutex_lock_state(rtm, state))
 		return -EINTR;
=20
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index acb5a50309a18..aca266006ad47 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1415,6 +1415,12 @@ static inline void __downgrade_write(struct rw_semap=
hore *sem)
 #define rwbase_rtmutex_lock_state(rtm, state)		\
 	__rt_mutex_lock(rtm, state)
=20
+#define rwbase_sched_submit_work()			\
+	sched_submit_work()
+
+#define rwbase_sched_resume_work()			\
+	sched_resume_work()
+
 #define rwbase_rtmutex_slowlock_locked(rtm, state)	\
 	__rt_mutex_slowlock_locked(rtm, NULL, state)
=20
diff --git a/kernel/locking/spinlock_rt.c b/kernel/locking/spinlock_rt.c
index 48a19ed8486d8..62c4a6866087a 100644
--- a/kernel/locking/spinlock_rt.c
+++ b/kernel/locking/spinlock_rt.c
@@ -159,6 +159,9 @@ rwbase_rtmutex_lock_state(struct rt_mutex_base *rtm, un=
signed int state)
 	return 0;
 }
=20
+static __always_inline void rwbase_sched_submit_work(void) { }
+static __always_inline void rwbase_sched_resume_work(void) { }
+
 static __always_inline int
 rwbase_rtmutex_slowlock_locked(struct rt_mutex_base *rtm, unsigned int sta=
te)
 {
--=20
2.40.1

