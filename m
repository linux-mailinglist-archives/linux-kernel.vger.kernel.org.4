Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247B472466B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238235AbjFFOjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238167AbjFFOic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691C61BDC
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:57 -0700 (PDT)
Message-ID: <20230606142032.320851262@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H0SHtIHKvGNjccihe5bl5KJFGvU0rvv1sAUDjIUVmZA=;
        b=xu+LjC6FcJ1D7kEM2up0mLuCoSwJNM/DGQub2BCOd4pms81P6znJhC3mipA9MCHfWSSfQ6
        nLLV7s3Qnj6R4CZ3oicRu3KRRzvgAD6Qek4KAp/h9o7GT29H4vlAsUN30CDYNKJjazs146
        PSOpfDH9bxwGV/aA+3z8XnuWk9jjeV7bUCvEbjhOvQ3wv/0PCPub4A94lNdvXYMJoD3jD2
        qg1OGNKqWrNbCjdZLii6CwZAy0bsShKFN1GAqqZqxhMFZokduyrpGnWFOsHD/voFJ45rxI
        OL2NZ9Afkyn+6Wpaotd6bYKIUfmrEQoiG0Npd5J0uutFjBvWEUNuXLUyKia6uQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=H0SHtIHKvGNjccihe5bl5KJFGvU0rvv1sAUDjIUVmZA=;
        b=29FxhteEWsRBzyVrLTeHNbrXTrB5L2OGD6EO2aYPwHO8ZDj9MiYQjhFnv9Nf9lkU5MCT3A
        emcm6vEe2z8gzICg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [patch 23/45] posix-timers: Cure si_sys_private race
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:55 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The si_sys_private member of the siginfo which is embedded in the
preallocated sigqueue is used by the posix timer code to decide whether a
timer must be reprogrammed on signal delivery.

The handling of this is racy as a long standing comment in that code
documents. It is modified with the timer lock held, but without sighand
lock being held. The actual signal delivery code checks for it under
sighand lock without holding the timer lock.

Hand the new value to send_sigqueue() as argument and store it with sighand
lock held.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/sched/signal.h |    2 +-
 kernel/signal.c              |   10 +++++++++-
 kernel/time/posix-timers.c   |   15 +--------------
 3 files changed, 11 insertions(+), 16 deletions(-)

--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -348,7 +348,7 @@ extern int send_sig(int, struct task_str
 extern int zap_other_threads(struct task_struct *p);
 extern struct sigqueue *sigqueue_alloc(void);
 extern void sigqueue_free(struct sigqueue *);
-extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type);
+extern int send_sigqueue(struct sigqueue *, struct pid *, enum pid_type, int si_private);
 extern int do_sigaction(int, struct k_sigaction *, struct k_sigaction *);
 
 static inline void clear_notify_signal(void)
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1911,7 +1911,7 @@ void sigqueue_free(struct sigqueue *q)
 		__sigqueue_free(q);
 }
 
-int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type)
+int send_sigqueue(struct sigqueue *q, struct pid *pid, enum pid_type type, int si_private)
 {
 	int sig = q->info.si_signo;
 	struct sigpending *pending;
@@ -1946,6 +1946,14 @@ int send_sigqueue(struct sigqueue *q, st
 	if (!likely(lock_task_sighand(t, &flags)))
 		goto ret;
 
+	/*
+	 * Update @q::info::si_sys_private for posix timer signals with
+	 * sighand locked to prevent a race against dequeue_signal() which
+	 * decides based on si_sys_private whether to invoke
+	 * posixtimer_rearm() or not.
+	 */
+	q->info.si_sys_private = si_private;
+
 	ret = 1; /* the signal is ignored */
 	result = TRACE_SIGNAL_IGNORED;
 	if (!prepare_signal(sig, t, false))
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -299,21 +299,8 @@ int posix_timer_queue_signal(struct k_it
 	if (timr->it_interval)
 		si_private = ++timr->it_requeue_pending;
 
-	/*
-	 * FIXME: if ->sigq is queued we can race with
-	 * dequeue_signal()->posixtimer_rearm().
-	 *
-	 * If dequeue_signal() sees the "right" value of
-	 * si_sys_private it calls posixtimer_rearm().
-	 * We re-queue ->sigq and drop ->it_lock().
-	 * posixtimer_rearm() locks the timer
-	 * and re-schedules it while ->sigq is pending.
-	 * Not really bad, but not that we want.
-	 */
-	timr->sigq->info.si_sys_private = si_private;
-
 	type = !(timr->it_sigev_notify & SIGEV_THREAD_ID) ? PIDTYPE_TGID : PIDTYPE_PID;
-	ret = send_sigqueue(timr->sigq, timr->it_pid, type);
+	ret = send_sigqueue(timr->sigq, timr->it_pid, type, si_private);
 	/* If we failed to send the signal the timer stops. */
 	return ret > 0;
 }

