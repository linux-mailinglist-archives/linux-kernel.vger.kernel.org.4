Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12156EE7C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 20:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235013AbjDYSuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Apr 2023 14:50:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjDYSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Apr 2023 14:50:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8981A17A2D
        for <linux-kernel@vger.kernel.org>; Tue, 25 Apr 2023 11:49:36 -0700 (PDT)
Message-ID: <20230425183313.777610259@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1682448564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=m5Kqsh4JR/w9Cu3b9AUJc4exPQX4NUZsivF0HR7AMXM=;
        b=nAg/4Ne7AAYygDtnN76h5AZTiIrRn1KYQJcIFl60cNjp7Nn84QDIb1484q8RIgrPnVfXUg
        N6Ch8MHxSc7DfalJ6QxhZ5meKiAxJj+qaDk2h/4WaGRnMCHDcWFrmnbBqWntU7lEV9uxM4
        tP3/mtPlxFeNTeKJ1sd4iJ5QmTt8Dy9IXyx/1XNa3sldpmvKXvCzEAoEJFI/BQy7P/Ew5X
        Ta73GtL39nmAEp6KJMLYi9G39SUhPVGBN+748tjWi3sP0OK4pEVbJtldPtsZPAg2ttNg+e
        O2xxliMK+FMdZQhrEhqlnCPE4kLHFkFT5B3ZpgzEv3P78fULEjFMyxEXA7cfuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1682448564;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=m5Kqsh4JR/w9Cu3b9AUJc4exPQX4NUZsivF0HR7AMXM=;
        b=WANxwChzr3gqBMt08n80lCIQi1jCqz/dv9R0coX4NSzLNjRtVZEg2HjqnujVL/DvGGjv9O
        RgAUfC2+M6KH0WDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: [patch 18/20] posix-timers: Clarify posix_timer_fn() comments
References: <20230425181827.219128101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 25 Apr 2023 20:49:24 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the issues vs. SIG_IGN understandable and remove the 15 years old
promise that a proper solution is already on the horizon.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-timers.c |   56 +++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 29 deletions(-)

--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -325,11 +325,11 @@ int posix_timer_event(struct k_itimer *t
 }
 
 /*
- * This function gets called when a POSIX.1b interval timer expires.  It
- * is used as a callback from the kernel internal timer.  The
- * run_timer_list code ALWAYS calls with interrupts on.
-
- * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
+ * This function gets called when a POSIX.1b interval timer expires from
+ * the HRTIMER soft interrupt with interrupts enabled.
+ *
+ * Handles CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_BOOTTIME and CLOCK_TAI
+ * based timers.
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
@@ -347,9 +347,10 @@ static enum hrtimer_restart posix_timer_
 
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
@@ -358,34 +359,31 @@ static enum hrtimer_restart posix_timer_
 			 * FIXME: What we really want, is to stop this
 			 * timer completely and restart it in case the
 			 * SIG_IGN is removed. This is a non trivial
-			 * change which involves sighand locking
-			 * (sigh !), which we don't want to do late in
-			 * the release cycle.
+			 * change to the signal handling code.
+			 *
+			 * For now let timers with an interval less than a
+			 * jiffie expire every jiffie to avoid softirq
+			 * starvation in case of SIG_IGN and a very small
+			 * interval, which would put the timer right back
+			 * on the softirq pending list. Moving now ahead of
+			 * time tricks hrtimer_forward() to expire the
+			 * timer later, while it still maintains the
+			 * overrun accuracy for the price of a slightly
+			 * inconsistency in the timer_gettime() case. This
+			 * is at least better than a starved softirq.
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
+			 * Only required when high resolution timers are
+			 * enabled as the periodic tick based timers are
+			 * automatically aligned to the next tick.
 			 */
-#ifdef CONFIG_HIGH_RES_TIMERS
-			{
+			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
 				ktime_t kj = NSEC_PER_SEC / HZ;
 
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

