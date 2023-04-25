Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071576EE7C0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbjDYStv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234766AbjDYStY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:49:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F91317A04
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:15 -0700 (PDT)
Message-ID: <20230425183313.409169321@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OftMSE12zQRmdkVUGBv+nkpk/BkQQU4Y9Jo02sefzOk=;
        b=nDl5yt7+JD2vDRRpCR3LBaiAJA9pKy8yQqRR2YI/lZZ6K0rueJ6loAqn/WROjzT7j5nDMF
        sX3YPDurf6WxIBaOlBDAkbTfy604auteDuwbXS/UOeKcJ8e8bPu8JtRItUcc+MWn5vZ04N
        sW5COWqb1WeHb4jEtT19Yj/2iKufme552mRcsmEAO0YHcnMZnU2aDPTxCytjr+QkrwW1hc
        0RwvGqxOiCpN9wGKaygT2bvcipZaoI1wzLJVLztqdNJiUdkGHnZRPCKDiLdDC7x7vDtwRH
        cySevYKWAWFOnB1p5oGmqSHWyh2pqlbnfxR8ncU4ol1VhYP3eIIyIa5TxNtW7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=OftMSE12zQRmdkVUGBv+nkpk/BkQQU4Y9Jo02sefzOk=;
        b=Z6Xi5jHpo1B87jSElU/Frrjl9kLNd40sgenJCjf6iEiulTEpFi0fMije2/f5AZLdz3ZOcV
        a7M1frfjzZ3rEsBw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 11/20] posix-timers: Document common_clock_get() correctly
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:12 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace another confusing and inaccurate set of comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   50 +++++++++++++++++++++++++++------------------
 1 file changed, 30 insertions(+), 20 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -659,20 +659,16 @@ static s64 common_hrtimer_forward(struct
 }
 
 /*
- * Get the time remaining on a POSIX.1b interval timer.  This function
- * is ALWAYS called with spin_lock_irq on the timer, thus it must not
- * mess with irq.
+ * Get the time remaining on a POSIX.1b interval timer.
  *
- * We have a couple of messes to clean up here.  First there is the case
- * of a timer that has a requeue pending.  These timers should appear to
- * be in the timer list with an expiry as if we were to requeue them
- * now.
+ * Two issues to handle here:
  *
- * The second issue is the SIGEV_NONE timer which may be active but is
- * not really ever put in the timer list (to save system resources).
- * This timer may be expired, and if so, we will do it here.  Otherwise
- * it is the same as a requeue pending timer WRT to what we should
- * report.
+ *  1) The timer has a requeue pending. The return value must appear as
+ *     if the timer has been requeued right now.
+ *
+ *  2) The timer is a SIGEV_NONE timer. These timers are never enqueued
+ *     into the hrtimer queue and therefore never expired. Emulate expiry
+ *     here taking #1 into account.
  */
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting)
 {
@@ -688,8 +684,12 @@ void common_timer_get(struct k_itimer *t
 		cur_setting->it_interval = ktime_to_timespec64(iv);
 	} else if (!timr->it_active) {
 		/*
-		 * SIGEV_NONE oneshot timers are never queued. Check them
-		 * below.
+		 * SIGEV_NONE oneshot timers are never queued and therefore
+		 * timr->it_active is always false. The check below
+		 * vs. remaining time will handle this case.
+		 *
+		 * For all other timers there is nothing to update here, so
+		 * return.
 		 */
 		if (!sig_none)
 			return;
@@ -698,18 +698,29 @@ void common_timer_get(struct k_itimer *t
 	now = kc->clock_get_ktime(timr->it_clock);
 
 	/*
-	 * When a requeue is pending or this is a SIGEV_NONE timer move the
-	 * expiry time forward by intervals, so expiry is > now.
+	 * If this is an interval timer and either has requeue pending or
+	 * is a SIGEV_NONE timer move the expiry time forward by intervals,
+	 * so expiry is > now.
 	 */
 	if (iv && (timr->it_requeue_pending & REQUEUE_PENDING || sig_none))
 		timr->it_overrun += kc->timer_forward(timr, now);
 
 	remaining = kc->timer_remaining(timr, now);
-	/* Return 0 only, when the timer is expired and not pending */
+	/*
+	 * As @now is retrieved before a possible timer_forward() and
+	 * cannot be reevaluated by the compiler @remaining is based on the
+	 * same @now value. Therefore @remaining is consistent vs. @now.
+	 *
+	 * Consequently all interval timers, i.e. @iv > 0, cannot have a
+	 * remaining time <= 0 because timer_forward() guarantees to move
+	 * them forward so that the next timer expiry is > @now.
+	 */
 	if (remaining <= 0) {
 		/*
-		 * A single shot SIGEV_NONE timer must return 0, when
-		 * it is expired !
+		 * A single shot SIGEV_NONE timer must return 0, when it is
+		 * expired! Timers which have a real signal delivery mode
+		 * must return a remaining time greater than 0 because the
+		 * signal has not yet been delivered.
 		 */
 		if (!sig_none)
 			cur_setting->it_value.tv_nsec = 1;
@@ -718,7 +729,6 @@ void common_timer_get(struct k_itimer *t
 	}
 }
 
-/* Get the time remaining on a POSIX.1b interval timer. */
 static int do_timer_gettime(timer_t timer_id,  struct itimerspec64 *setting)
 {
 	struct k_itimer *timr;

