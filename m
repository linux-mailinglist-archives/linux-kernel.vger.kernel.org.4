Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE53724662
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 16:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238061AbjFFOif (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 10:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238155AbjFFOiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 10:38:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC29E42
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 07:37:46 -0700 (PDT)
Message-ID: <20230606142031.928021762@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686062264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BVz57Fiq4y3HANqcZc1xKtZ2T7kpNoRDOZcZ2I4Dywg=;
        b=OXNv1AoeCwdVG8cgbF4uXunKSC+maSLNg/mynVZgvO9IFMNYyEspVWkSY9eokdBKGA2yGz
        5umVpPLu1o8Bq9v0QJkLGjLcjDDCKdvEmgZ/XMNLUzFrv8jzQIDpRaHwvDZMhqsBnmk2bZ
        zHTmOjzDpL0RvXHDykanfAW2dB2WxRuLnuwMDtItFPiSEjSA9AmrupfA5qHyeYnRo4BwjL
        hzDqIwZBcItlKFxAG4iTMSdyG4REMta+QimfGeEU44roRuzuZPotlRCGHwlOZnJ31m1VEP
        y1L+mopDD8Ye3mrWDMgrd0UyfYYipTqW73ZQVDRVQJQtZocHnSt4Qp0wdrghpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686062264;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BVz57Fiq4y3HANqcZc1xKtZ2T7kpNoRDOZcZ2I4Dywg=;
        b=0S4FTbLs/WLg9eK1op5nChLJ5PMVrhUanQz0OQODSwoxoI2fZjXNqo94T/KbL+0WAIn+TM
        N8pa5f1PXIjBtGDA==
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
Subject: [patch 16/45] posix-timers: Consolidate timer setup
References: <20230606132949.068951363@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Tue,  6 Jun 2023 16:37:44 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hrtimer based and CPU timers have their own way to install the new interval
and to reset overrun and signal handling related data.

Create a helper function and do the same operation for all variants.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/time/posix-cpu-timers.c |   15 +--------------
 kernel/time/posix-timers.c     |   23 +++++++++++++++++------
 kernel/time/posix-timers.h     |    1 +
 3 files changed, 19 insertions(+), 20 deletions(-)

--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -709,21 +709,8 @@ static int posix_cpu_timer_set(struct k_
 		trigger_base_recalc_expires(timer, p);
 
 	unlock_task_sighand(p, &flags);
-	/*
-	 * Install the new reload setting, and
-	 * set up the signal and overrun bookkeeping.
-	 */
-	timer->it_interval = timespec64_to_ktime(new->it_interval);
 
-	/*
-	 * This acts as a modification timestamp for the timer,
-	 * so any automatic reload attempt will punt on seeing
-	 * that we have reset the timer manually.
-	 */
-	timer->it_requeue_pending = (timer->it_requeue_pending + 2) &
-		~REQUEUE_PENDING;
-	timer->it_overrun_last = 0;
-	timer->it_overrun = -1;
+	posix_timer_set_common(timer, new);
 
 	/*
 	 * If the new expiry time was already in the past the timer was not
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -853,6 +853,21 @@ static struct k_itimer *timer_wait_runni
 	return lock_timer(timer_id, flags);
 }
 
+/*
+ * Set up the new interval and reset the signal delivery data
+ */
+void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_setting)
+{
+	if (new_setting->it_value.tv_sec || new_setting->it_value.tv_nsec)
+		timer->it_interval = timespec64_to_ktime(new_setting->it_interval);
+
+	/* Prevent reloading in case there is a signal pending */
+	timer->it_requeue_pending = (timer->it_requeue_pending + 2) & ~REQUEUE_PENDING;
+	/* Reset overrun accounting */
+	timer->it_overrun_last = 0;
+	timer->it_overrun = -1LL;
+}
+
 /* Set a POSIX.1b interval timer. */
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
@@ -875,16 +890,12 @@ int common_timer_set(struct k_itimer *ti
 		return TIMER_RETRY;
 
 	timr->it_active = 0;
-	timr->it_requeue_pending = (timr->it_requeue_pending + 2) &
-		~REQUEUE_PENDING;
-	timr->it_overrun_last = 0;
-	timr->it_overrun = -1LL;
+	posix_timer_set_common(timr, new_setting);
 
-	/* Switch off the timer when it_value is zero */
+	/* Keep timer disarmed when it_value is zero */
 	if (!new_setting->it_value.tv_sec && !new_setting->it_value.tv_nsec)
 		return 0;
 
-	timr->it_interval = timespec64_to_ktime(new_setting->it_interval);
 	expires = timespec64_to_ktime(new_setting->it_value);
 	if (flags & TIMER_ABSTIME)
 		expires = timens_ktime_to_host(timr->it_clock, expires);
--- a/kernel/time/posix-timers.h
+++ b/kernel/time/posix-timers.h
@@ -42,4 +42,5 @@ void common_timer_get(struct k_itimer *t
 int common_timer_set(struct k_itimer *timr, int flags,
 		     struct itimerspec64 *new_setting,
 		     struct itimerspec64 *old_setting);
+void posix_timer_set_common(struct k_itimer *timer, struct itimerspec64 *new_setting);
 int common_timer_del(struct k_itimer *timer);

