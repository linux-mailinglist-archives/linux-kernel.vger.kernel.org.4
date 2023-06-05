Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50386722A7C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbjFEPJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjFEPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:08:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C25F3;
        Mon,  5 Jun 2023 08:08:33 -0700 (PDT)
Date:   Mon, 05 Jun 2023 15:08:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685977712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRKARvUliXIIvLU+7X5+u+u6JXY8zYPAdY7I9M16Eqg=;
        b=GQH/ENpnqWkeAgZQIB2sv8Yciow3CdoT97JAgeh0L72URzCN2rSp+UFmzr73KjgQRwWpvY
        BR8f6WIsKPDa+5dNebgLqcmKi2hD//De7v8urwRErkMhHKT+KRNEc8jyrFdpMxI2YoinRK
        7EF6hsu6c/gJ7pRb9DUJd5gi4AM49LBpZ4I/oDqNZPXqJjPFF0vWJq7y454bAFTGdDHSIL
        L9SjznRNRyPfJEIK2/Tr9/Rgn6TCHX6u0aSqCe+8CyFE7HOuonR7hMgfNVXowSs50+zscH
        NgQJ9OZSYPQAOncubj89dLNFycwrAeMNstLd3gIqrgMTtHRJMeQWXVt1oMHtFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685977712;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WRKARvUliXIIvLU+7X5+u+u6JXY8zYPAdY7I9M16Eqg=;
        b=JpRstdjkoVoYlSMUbCvDg8gyZqa67YpM84p4+zyfLfGRwsqMot1rbSw5knEIIIrVKKaVCj
        bVZ84FmzA1Y2/iDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Prevent RT livelock in itimer_delete()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <87v8g7c50d.ffs@tglx>
References: <87v8g7c50d.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168597771212.404.434816099112734866.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1b59b2577582f9cf3d0f17245675a76859175cc1
Gitweb:        https://git.kernel.org/tip/1b59b2577582f9cf3d0f17245675a76859175cc1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 01 Jun 2023 22:16:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Jun 2023 17:03:36 +02:00

posix-timers: Prevent RT livelock in itimer_delete()

itimer_delete() has a retry loop when the timer is concurrently expired. On
non-RT kernels this just spin-waits until the timer callback has completed,
except for posix CPU timers which have HAVE_POSIX_CPU_TIMERS_TASK_WORK
enabled.

In that case and on RT kernels the existing task could live lock when
preempting the task which does the timer delivery.

Replace spin_unlock() with an invocation of timer_wait_running() to handle
it the same way as the other retry loops in the posix timer code.

Fixes: ec8f954a40da ("posix-timers: Use a callback for cancel synchronization on PREEMPT_RT")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/87v8g7c50d.ffs@tglx

---
 kernel/time/posix-timers.c | 41 ++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 808a247..2d835c2 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -1037,27 +1037,52 @@ retry_delete:
 }
 
 /*
- * return timer owned by the process, used by exit_itimers
+ * Delete a timer if it is armed, remove it from the hash and schedule it
+ * for RCU freeing.
  */
 static void itimer_delete(struct k_itimer *timer)
 {
+	unsigned long flags;
+
 retry_delete:
-	spin_lock_irq(&timer->it_lock);
+	/*
+	 * irqsave is required to make timer_wait_running() work.
+	 */
+	spin_lock_irqsave(&timer->it_lock, flags);
 
+	/*
+	 * Even if the timer is not longer accessible from other tasks
+	 * it still might be armed and queued in the underlying timer
+	 * mechanism. Worse, that timer mechanism might run the expiry
+	 * function concurrently.
+	 */
 	if (timer_delete_hook(timer) == TIMER_RETRY) {
-		spin_unlock_irq(&timer->it_lock);
+		/*
+		 * Timer is expired concurrently, prevent livelocks
+		 * and pointless spinning on RT.
+		 *
+		 * timer_wait_running() drops timer::it_lock, which opens
+		 * the possibility for another task to delete the timer.
+		 *
+		 * That's not possible here because this is invoked from
+		 * do_exit() only for the last thread of the thread group.
+		 * So no other task can access and delete that timer.
+		 */
+		if (WARN_ON_ONCE(timer_wait_running(timer, &flags) != timer))
+			return;
+
 		goto retry_delete;
 	}
 	list_del(&timer->list);
 
-	spin_unlock_irq(&timer->it_lock);
+	spin_unlock_irqrestore(&timer->it_lock, flags);
 	release_posix_timer(timer, IT_ID_SET);
 }
 
 /*
- * This is called by do_exit or de_thread, only when nobody else can
- * modify the signal->posix_timers list. Yet we need sighand->siglock
- * to prevent the race with /proc/pid/timers.
+ * Invoked from do_exit() when the last thread of a thread group exits.
+ * At that point no other task can access the timers of the dying
+ * task anymore.
  */
 void exit_itimers(struct task_struct *tsk)
 {
@@ -1067,10 +1092,12 @@ void exit_itimers(struct task_struct *tsk)
 	if (list_empty(&tsk->signal->posix_timers))
 		return;
 
+	/* Protect against concurrent read via /proc/$PID/timers */
 	spin_lock_irq(&tsk->sighand->siglock);
 	list_replace_init(&tsk->signal->posix_timers, &timers);
 	spin_unlock_irq(&tsk->sighand->siglock);
 
+	/* The timers are not longer accessible via tsk::signal */
 	while (!list_empty(&timers)) {
 		tmr = list_first_entry(&timers, struct k_itimer, list);
 		itimer_delete(tmr);
