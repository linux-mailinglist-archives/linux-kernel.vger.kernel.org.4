Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BED22734854
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 22:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFRUuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 16:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjFRUuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 16:50:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D37D123;
        Sun, 18 Jun 2023 13:49:59 -0700 (PDT)
Date:   Sun, 18 Jun 2023 20:49:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1687121397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ulay+IJn+o8JcX+jgajJWMne8J/Z4XZyhw+hfQwiS6Q=;
        b=clg/w3v6DdGuGOuAqMd2SshrVg55b3AC3DU7vwRmL7p65CdFOAxwNZwxoIEP4ymV2JDJ3x
        WmYM77MPI4z8EDvILnoBG77wdh5CWhFF/ZWMs7f1/D9XZclgkisNH8j8DjRXWV9MF0C2Df
        SRpztuAI09gzBQh3CfbaNKTBW38okMaL9OrlGMsQeUokKQY1GFEpPHJMHTtbQ6KQxV3Bg8
        XGqjhgQldJqqE6kSdOnMkXjTsLwx0QZKTCAtVTmLJU4wQtyjOQpoWrKcawOxzO1JW8kaGy
        qDJUJ+gQ+C0CL4LAiKFFngoiz0Dk316PICSayggSYq0gJuSaxevtBG57Lb6jPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1687121397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ulay+IJn+o8JcX+jgajJWMne8J/Z4XZyhw+hfQwiS6Q=;
        b=wGX5UD2uWBGM4fIXBt7GURPnUl2Iu2Ek/QYEVuF3fF9vj+CbWGhjYMLSOAWB/C5oRYKLDO
        wKDFzEQqri8Y4wBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-timers: Clarify posix_timer_fn() comments
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <874jnrdmrq.ffs@tglx>
References: <874jnrdmrq.ffs@tglx>
MIME-Version: 1.0
Message-ID: <168712139719.404.2275002250356402873.tip-bot2@tip-bot2>
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

Commit-ID:     84999b8bdb4969816c7bb7c14c3a55ed42aa4b94
Gitweb:        https://git.kernel.org/tip/84999b8bdb4969816c7bb7c14c3a55ed42aa4b94
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 01 Jun 2023 21:07:37 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 18 Jun 2023 22:41:52 +02:00

posix-timers: Clarify posix_timer_fn() comments

Make the issues vs. SIG_IGN understandable and remove the 15 years old
promise that a proper solution is already on the horizon.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/874jnrdmrq.ffs@tglx

---
 kernel/time/posix-timers.c | 62 +++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 30 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index d8d2169..ae8799e 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -326,11 +326,11 @@ int posix_timer_event(struct k_itimer *timr, int si_private)
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
@@ -348,9 +348,10 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 
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
@@ -359,34 +360,35 @@ static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
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
+			 * than a timer storm.
+			 *
+			 * Only required when high resolution timers are
+			 * enabled as the periodic tick based timers are
+			 * automatically aligned to the next tick.
 			 */
-#ifdef CONFIG_HIGH_RES_TIMERS
-			{
-				ktime_t kj = NSEC_PER_SEC / HZ;
+			if (IS_ENABLED(CONFIG_HIGHRES_TIMERS)) {
+				ktime_t kj = TICK_NSEC;
 
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
