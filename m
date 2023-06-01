Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1399A71F29F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 21:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjFATHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 15:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjFATHk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 15:07:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CA8413E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 12:07:39 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1685646457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jk3OoUH/vZ/PG3PRxTx2YkNfM1UU6F5mJBsyBA6TRrs=;
        b=nIt1sJEqQB6By3BxH5cEPmu1YnS5qbn+FgaDghURYc8HcWrS9HvQ4QiMyL/ztPdXADCohE
        nZrhgbdMoArVnJLLHhmfsMwV/NihjleXWqcdSL8O6SqmQDPgiNlPTOhTop6LnUCsPl4yHF
        EJYLV8D4TPnFsefhvZMaYpC4Zx9WQbqqZwfl10rW1nYQ2e4uEoxugYnD/0D6gmLy2JCyLO
        H31I0+IPrHP3rH6IMulFZt63TTW6Ik5i3ZEfglRFVi6nmXDKwBPk8GVxKt6yIFXQHd3fXC
        BJSsqRg2pj1IKuPKyeUxH9g3NJrQfd0jvfdTx9cQRm50kKP9QR9Wtsvh3iCWzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1685646457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jk3OoUH/vZ/PG3PRxTx2YkNfM1UU6F5mJBsyBA6TRrs=;
        b=0XqM433XX03aY9XDC63CjR6M1lCyncWLejBoFggnpDCkbPIAUP5HJ9wFhLv3zIJgM/QY4T
        LpdBehvpCuBgUJCw==
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch 18/20] posix-timers: Clarify posix_timer_fn() comments
In-Reply-To: <ZHibcwrDgegKwQeQ@lothringen>
References: <20230425181827.219128101@linutronix.de>
 <20230425183313.777610259@linutronix.de> <ZHibcwrDgegKwQeQ@lothringen>
Date:   Thu, 01 Jun 2023 21:07:37 +0200
Message-ID: <874jnrdmrq.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the issues vs. SIG_IGN understandable and remove the 15 years old
promise that a proper solution is already on the horizon.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Clarify comments and use TICK_NSECS - Frederic
---
 kernel/time/posix-timers.c |   62 +++++++++++++++++++++++----------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -326,11 +326,11 @@ int posix_timer_event(struct k_itimer *t
 }
 
 /*
- * This function gets called when a POSIX.1b interval timer expires.  It
- * is used as a callback from the kernel internal timer.  The
- * run_timer_list code ALWAYS calls with interrupts on.
-
- * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
+ * This function gets called when a POSIX.1b interval timer expires from
+ * the HRTIMER interrupt (soft interrupt on RT kernels).
+ *
+ * Handles CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME and CLOCK_TAI
+ * based timers.
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
@@ -348,9 +348,10 @@ static enum hrtimer_restart posix_timer_
 
 	if (posix_timer_event(timr, si_private)) {
 		/*
-		 * signal was not sent because of sig_ignor
-		 * we will not get a call back to restart it AND
-		 * it should be restarted.
+		 * The signal was not queued due to SIG_IGN. As a
+		 * consequence the timer is not going to be rearmed from
+		 * the signal delivery path. But as a real signal handler
+		 * can be installed later the timer must be rearmed here.
 		 */
 		if (timr->it_interval != 0) {
 			ktime_t now = hrtimer_cb_get_time(timer);
@@ -359,34 +360,35 @@ static enum hrtimer_restart posix_timer_
 			 * FIXME: What we really want, is to stop this
 			 * timer completely and restart it in case the
 			 * SIG_IGN is removed. This is a non trivial
-			 * change which involves sighand locking
-			 * (sigh !), which we don't want to do late in
-			 * the release cycle.
+			 * change to the signal handling code.
+			 *
+			 * For now let timers with an interval less than a
+			 * jiffie expire every jiffie and recheck for a
+			 * valid signal handler.
+			 *
+			 * This avoids interrupt starvation in case of a
+			 * very small interval, which would expire the
+			 * timer immediately again.
 			 *
-			 * For now we just let timers with an interval
-			 * less than a jiffie expire every jiffie to
-			 * avoid softirq starvation in case of SIG_IGN
-			 * and a very small interval, which would put
-			 * the timer right back on the softirq pending
-			 * list. By moving now ahead of time we trick
-			 * hrtimer_forward() to expire the timer
-			 * later, while we still maintain the overrun
-			 * accuracy, but have some inconsistency in
-			 * the timer_gettime() case. This is at least
-			 * better than a starved softirq. A more
-			 * complex fix which solves also another related
-			 * inconsistency is already in the pipeline.
+			 * Moving now ahead of time by one jiffie tricks
+			 * hrtimer_forward() to expire the timer later,
+			 * while it still maintains the overrun accuracy
+			 * for the price of a slight inconsistency in the
+			 * timer_gettime() case. This is at least better
+			 * than a starved softirq.
+			 *
+			 * Only required when high resolution timers are
+			 * enabled as the periodic tick based timers are
+			 * automatically aligned to the next tick.
 			 */
-#ifdef CONFIG_HIGH_RES_TIMERS
-			{
-				ktime_t kj = NSEC_PER_SEC / HZ;
+			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
+				ktime_t kj = TICK_NSECS;
 
 				if (timr->it_interval < kj)
 					now = ktime_add(now, kj);
 			}
-#endif
-			timr->it_overrun += hrtimer_forward(timer, now,
-							    timr->it_interval);
+
+			timr->it_overrun += hrtimer_forward(timer, now, timr->it_interval);
 			ret = HRTIMER_RESTART;
 			++timr->it_requeue_pending;
 			timr->it_active = 1;
