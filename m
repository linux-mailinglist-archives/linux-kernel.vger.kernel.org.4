Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB67724665
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238244AbjFFOij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237908AbjFFOiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160EA19A3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:50 -0700 (PDT)
Message-ID: <20230606142032.040938859@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=psF57WLKdFqu9d22GEwITnNmBUegjhn1nfEG4ZPBrXA=;
        b=mSPDSqrv1NDyZxfVdpBVPROOQPPJPJbiZLlJlHdy2N3yQzUi5VtXwvWZ0d2alC7elOSJ4Y
        fbMuF1NEfVrLI2MYC4WrsVzJNyBgERX+kUQItZu0/8d6GlKbYIde4rA7J60J+3PskfQUFI
        UxPW6Ba+qLTR3IzvxNe8tjVVE+AYd6fUTT5gGATzpVuB1BTCJVCXszMJWWsLfoK7b4dcMU
        H4tDOXT2dBL7K1Mn0IpeOGSCvmZpTQnhuB9EDdbNA04jbipBuRDAZZYg4otlrEwamP/GHX
        d2+7Fd3tr81dkp37P3b0pWv5y6cW3USN6pXGwQIoixH17ZtuV6DkURXv46IQWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062267;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=psF57WLKdFqu9d22GEwITnNmBUegjhn1nfEG4ZPBrXA=;
        b=yoLu84z6rrJTIWXMD3aLk4dbgwAS/EFLZIa05jJ8SYQPQhUanOTFGf6+DF2mdXsdkWozuA
        SEmVuUjkwhLu4bAA==
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
Subject: [patch 18/45] posix-timers: Consolidate signal queueing
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:47 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename posix_timer_event() to posix_timer_queue_signal() as this is what
the function is about.

Consolidate the requeue pending and deactivation updates into that function
as there is no point in doing this in all incarnations of posix timers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/alarmtimer.c       |    7 +------
 kernel/time/posix-cpu-timers.c |    4 ++--
 kernel/time/posix-timers.c     |   21 +++++++++++----------
 kernel/time/posix-timers.h     |    2 +-
 4 files changed, 15 insertions(+), 19 deletions(-)

--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -563,15 +563,10 @@ static enum alarmtimer_restart alarm_han
 					    it.alarm.alarmtimer);
 	enum alarmtimer_restart result = ALARMTIMER_NORESTART;
 	unsigned long flags;
-	int si_private = 0;
 
 	spin_lock_irqsave(&ptr->it_lock, flags);
 
-	ptr->it_active = 0;
-	if (ptr->it_interval)
-		si_private = ++ptr->it_requeue_pending;
-
-	if (posix_timer_event(ptr, si_private) && ptr->it_interval) {
+	if (posix_timer_queue_signal(ptr) && ptr->it_interval) {
 		/*
 		 * Handle ignored signals and rearm the timer. This will go
 		 * away once we handle ignored signals proper. Ensure that
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -597,9 +597,9 @@ static void cpu_timer_fire(struct k_itim
 		/*
 		 * One-shot timer.  Clear it as soon as it's fired.
 		 */
-		posix_timer_event(timer, 0);
+		posix_timer_queue_signal(timer);
 		cpu_timer_setexpires(ctmr, 0);
-	} else if (posix_timer_event(timer, ++timer->it_requeue_pending)) {
+	} else if (posix_timer_queue_signal(timer)) {
 		/*
 		 * The signal did not get queued because the signal
 		 * was ignored, so we won't get any callback to
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -277,10 +277,17 @@ void posixtimer_rearm(struct kernel_sigi
 	unlock_timer(timr, flags);
 }
 
-int posix_timer_event(struct k_itimer *timr, int si_private)
+int posix_timer_queue_signal(struct k_itimer *timr)
 {
+	int ret, si_private = 0;
 	enum pid_type type;
-	int ret;
+
+	lockdep_assert_held(&timr->it_lock);
+
+	timr->it_active = 0;
+	if (timr->it_interval)
+		si_private = ++timr->it_requeue_pending;
+
 	/*
 	 * FIXME: if ->sigq is queued we can race with
 	 * dequeue_signal()->posixtimer_rearm().
@@ -309,19 +316,13 @@ int posix_timer_event(struct k_itimer *t
  */
 static enum hrtimer_restart posix_timer_fn(struct hrtimer *timer)
 {
+	struct k_itimer *timr = container_of(timer, struct k_itimer, it.real.timer);
 	enum hrtimer_restart ret = HRTIMER_NORESTART;
-	struct k_itimer *timr;
 	unsigned long flags;
-	int si_private = 0;
 
-	timr = container_of(timer, struct k_itimer, it.real.timer);
 	spin_lock_irqsave(&timr->it_lock, flags);
 
-	timr->it_active = 0;
-	if (timr->it_interval != 0)
-		si_private = ++timr->it_requeue_pending;
-
-	if (posix_timer_event(timr, si_private)) {
+	if (posix_timer_queue_signal(timr)) {
 		/*
 		 * The signal was not queued due to SIG_IGN. As a
 		 * consequence the timer is not going to be rearmed from
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -36,7 +36,7 @@ extern const struct k_clock clock_proces
 extern const struct k_clock clock_thread;
 extern const struct k_clock alarm_clock;
 
-int posix_timer_event(struct k_itimer *timr, int si_private);
+int posix_timer_queue_signal(struct k_itimer *timr);
 
 void common_timer_get(struct k_itimer *timr, struct itimerspec64 *cur_setting);
 int common_timer_set(struct k_itimer *timr, int flags,

