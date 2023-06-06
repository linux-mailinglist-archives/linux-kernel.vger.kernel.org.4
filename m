Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3232E724666
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238250AbjFFOim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbjFFOiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B284F19AD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:50 -0700 (PDT)
Message-ID: <20230606142032.095893220@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NkUrDTbG2kUXm4FwAX4frsR2bQohb+OmRpFyHE6t2mA=;
        b=3vJpsNCd5Cty9AxlHVIAAC4r6I8hNXiaYpKzMmQUemVg9DoLwOy5WiGazhw+1WqznMIonr
        cgmpaFC/pWVkbwMhxfiKohvbxtNUHKzO8h9Ykar5+D3cVgyPtCtkrq2xfVG5WrnGwVnrXg
        z4aULVl0zsL31Js+l0Rx+1lquD6nsZ7aSazjFG+8bHwI/WXTAs+6P89jKbOiNyvxhkGRYU
        2gE4nWX0rTtcvxsbJQryz6Tkmw2zobEwcocwp17CV8kVkhJjZ0HF2gj6FP1kVArZhWIilO
        N8HJjFNqli/nezp9omLTO59XWsqIRqeMfIIheNVfJFz846u2MYZZ4azVZ0FxEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=NkUrDTbG2kUXm4FwAX4frsR2bQohb+OmRpFyHE6t2mA=;
        b=FOhRJm+RNuhNW+Fzm6R39QCjgVamcm3e4KM3EJudB2HxdLzadgjA+Nkpt2PHOYjQ6frDo5
        U1fiiTT0AP6Pu+Cw==
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
Subject: [patch 19/45] signal: Remove task argument from dequeue_signal()
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:48 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The task pointer which is handed to dequeue_signal() is always current. The
argument along with the first comment about signalfd in that function is
confusing at best. Remove it and use current internally.

Update the stale comment for dequeue_signal() while at it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/signalfd.c                |    4 ++--
 include/linux/sched/signal.h |    5 ++---
 kernel/signal.c              |   23 ++++++++++-------------
 3 files changed, 14 insertions(+), 18 deletions(-)

--- a/fs/signalfd.c
+++ b/fs/signalfd.c
@@ -160,7 +160,7 @@ static ssize_t signalfd_dequeue(struct s
 	DECLARE_WAITQUEUE(wait, current);
 
 	spin_lock_irq(&current->sighand->siglock);
-	ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+	ret = dequeue_signal(&ctx->sigmask, info, &type);
 	switch (ret) {
 	case 0:
 		if (!nonblock)
@@ -175,7 +175,7 @@ static ssize_t signalfd_dequeue(struct s
 	add_wait_queue(&current->sighand->signalfd_wqh, &wait);
 	for (;;) {
 		set_current_state(TASK_INTERRUPTIBLE);
-		ret = dequeue_signal(current, &ctx->sigmask, info, &type);
+		ret = dequeue_signal(&ctx->sigmask, info, &type);
 		if (ret != 0)
 			break;
 		if (signal_pending(current)) {
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -275,8 +275,7 @@ static inline void signal_set_stop_flags
 extern void flush_signals(struct task_struct *);
 extern void ignore_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
-extern int dequeue_signal(struct task_struct *task, sigset_t *mask,
-			  kernel_siginfo_t *info, enum pid_type *type);
+extern int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type);
 
 static inline int kernel_dequeue_signal(void)
 {
@@ -286,7 +285,7 @@ static inline int kernel_dequeue_signal(
 	int ret;
 
 	spin_lock_irq(&task->sighand->siglock);
-	ret = dequeue_signal(task, &task->blocked, &__info, &__type);
+	ret = dequeue_signal(&task->blocked, &__info, &__type);
 	spin_unlock_irq(&task->sighand->siglock);
 
 	return ret;
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -621,20 +621,18 @@ static int __dequeue_signal(struct sigpe
 }
 
 /*
- * Dequeue a signal and return the element to the caller, which is
- * expected to free it.
- *
- * All callers have to hold the siglock.
+ * Try to dequeue a signal. If a deliverable signal is found fill in the
+ * caller provided siginfo and return the signal number. Otherwise return
+ * 0.
  */
-int dequeue_signal(struct task_struct *tsk, sigset_t *mask,
-		   kernel_siginfo_t *info, enum pid_type *type)
+int dequeue_signal(sigset_t *mask, kernel_siginfo_t *info, enum pid_type *type)
 {
+	struct task_struct *tsk = current;
 	bool resched_timer = false;
 	int signr;
 
-	/* We only dequeue private signals from ourselves, we don't let
-	 * signalfd steal them
-	 */
+	lockdep_assert_held(&tsk->sighand->siglock);
+
 	*type = PIDTYPE_PID;
 	signr = __dequeue_signal(&tsk->pending, mask, info, &resched_timer);
 	if (!signr) {
@@ -2751,8 +2749,7 @@ bool get_signal(struct ksignal *ksig)
 		type = PIDTYPE_PID;
 		signr = dequeue_synchronous_signal(&ksig->info);
 		if (!signr)
-			signr = dequeue_signal(current, &current->blocked,
-					       &ksig->info, &type);
+			signr = dequeue_signal(&current->blocked, &ksig->info, &type);
 
 		if (!signr)
 			break; /* will return 0 */
@@ -3606,7 +3603,7 @@ static int do_sigtimedwait(const sigset_
 	signotset(&mask);
 
 	spin_lock_irq(&tsk->sighand->siglock);
-	sig = dequeue_signal(tsk, &mask, info, &type);
+	sig = dequeue_signal(&mask, info, &type);
 	if (!sig && timeout) {
 		/*
 		 * None ready, temporarily unblock those we're interested
@@ -3625,7 +3622,7 @@ static int do_sigtimedwait(const sigset_
 		spin_lock_irq(&tsk->sighand->siglock);
 		__set_task_blocked(tsk, &tsk->real_blocked);
 		sigemptyset(&tsk->real_blocked);
-		sig = dequeue_signal(tsk, &mask, info, &type);
+		sig = dequeue_signal(&mask, info, &type);
 	}
 	spin_unlock_irq(&tsk->sighand->siglock);
 

