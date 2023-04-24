Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540A56E6793
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232052AbjDROxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjDROxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91150AF22;
        Tue, 18 Apr 2023 07:53:34 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:53:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681829611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfTLvPvmkoUmxckHjErqBahcxhIhR7fQTO9hzWxAnZw=;
        b=xxqyjxqyvSHPdC1ZxRVViREChzGTWEkLxB5z7VVY5boT2aq5M4YJgTVHpFxZnEfi44eCx9
        mwbvCk+Rndb1l9Fjn/US6WDAHSsaWKiCf2BF8O8Kx5DMAKXhq8XeFoBvCM38r6kzAFWwSa
        UMcIorv8lSRhfG2KYxVQvZpPK7m06NFsKjlqJU/pOHHoHjpvyyMNExcWghg+cXBCx5+0Wx
        2Uk2/RfQZJ2VrrO1SPgXw0oW+9GvdxNgbzU9gMB1Otnw/jhXCpICA3L5mztEqw/Xn9cGns
        PPWhcar3m4lAPZvJV7P5j8k+Iht7qy7DIAN9avMCmt/79ToJUBD6KmsGKpFpYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681829611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wfTLvPvmkoUmxckHjErqBahcxhIhR7fQTO9hzWxAnZw=;
        b=cYkBd8388jmf1KZdUmKkCDReTvVjICTOcJb1i1x6ZLe7uWbMfVqpLpEG01qErAq0G38IXo
        DWZHNvZUcq8IVqCg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/nohz: Restructure and reshuffle struct tick_sched
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222144649.624380-2-frederic@kernel.org>
References: <20230222144649.624380-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <168182961061.404.1643520889505328562.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     605da849d5982dee0527edb2488b79795f31a150
Gitweb:        https://git.kernel.org/tip/605da849d5982dee0527edb2488b79795f31a150
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 22 Feb 2023 15:46:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 16:35:12 +02:00

timers/nohz: Restructure and reshuffle struct tick_sched

Restructure and group fields by access in order to optimize cache
layout. While at it, also add missing kernel doc for two fields:
@last_jiffies and @idle_expires.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230222144649.624380-2-frederic@kernel.org

---
 kernel/time/tick-sched.h | 66 ++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 5046495..c666325 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -22,65 +22,81 @@ enum tick_nohz_mode {
 
 /**
  * struct tick_sched - sched tick emulation and no idle tick control/stats
- * @sched_timer:	hrtimer to schedule the periodic tick in high
- *			resolution mode
- * @check_clocks:	Notification mechanism about clocksource changes
- * @nohz_mode:		Mode - one state of tick_nohz_mode
+ *
  * @inidle:		Indicator that the CPU is in the tick idle mode
  * @tick_stopped:	Indicator that the idle tick has been stopped
  * @idle_active:	Indicator that the CPU is actively in the tick idle mode;
  *			it is reset during irq handling phases.
- * @do_timer_lst:	CPU was the last one doing do_timer before going idle
+ * @do_timer_last:	CPU was the last one doing do_timer before going idle
  * @got_idle_tick:	Tick timer function has run with @inidle set
+ * @stalled_jiffies:	Number of stalled jiffies detected across ticks
+ * @last_tick_jiffies:	Value of jiffies seen on last tick
+ * @sched_timer:	hrtimer to schedule the periodic tick in high
+ *			resolution mode
  * @last_tick:		Store the last tick expiry time when the tick
  *			timer is modified for nohz sleeps. This is necessary
  *			to resume the tick timer operation in the timeline
  *			when the CPU returns from nohz sleep.
  * @next_tick:		Next tick to be fired when in dynticks mode.
  * @idle_jiffies:	jiffies at the entry to idle for idle time accounting
+ * @idle_waketime:	Time when the idle was interrupted
+ * @idle_entrytime:	Time when the idle call was entered
+ * @nohz_mode:		Mode - one state of tick_nohz_mode
+ * @last_jiffies:	Base jiffies snapshot when next event was last computed
+ * @timer_expires_base:	Base time clock monotonic for @timer_expires
+ * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
+ * @next_timer:		Expiry time of next expiring timer for debugging purpose only
+ * @idle_expires:	Next tick in idle, for debugging purpose only
  * @idle_calls:		Total number of idle calls
  * @idle_sleeps:	Number of idle calls, where the sched tick was stopped
- * @idle_entrytime:	Time when the idle call was entered
- * @idle_waketime:	Time when the idle was interrupted
  * @idle_exittime:	Time when the idle state was left
  * @idle_sleeptime:	Sum of the time slept in idle with sched tick stopped
  * @iowait_sleeptime:	Sum of the time slept in idle with sched tick stopped, with IO outstanding
- * @timer_expires:	Anticipated timer expiration time (in case sched tick is stopped)
- * @timer_expires_base:	Base time clock monotonic for @timer_expires
- * @next_timer:		Expiry time of next expiring timer for debugging purpose only
  * @tick_dep_mask:	Tick dependency mask - is set, if someone needs the tick
- * @last_tick_jiffies:	Value of jiffies seen on last tick
- * @stalled_jiffies:	Number of stalled jiffies detected across ticks
+ * @check_clocks:	Notification mechanism about clocksource changes
  */
 struct tick_sched {
-	struct hrtimer			sched_timer;
-	unsigned long			check_clocks;
-	enum tick_nohz_mode		nohz_mode;
-
+	/* Common flags */
 	unsigned int			inidle		: 1;
 	unsigned int			tick_stopped	: 1;
 	unsigned int			idle_active	: 1;
 	unsigned int			do_timer_last	: 1;
 	unsigned int			got_idle_tick	: 1;
 
+	/* Tick handling: jiffies stall check */
+	unsigned int			stalled_jiffies;
+	unsigned long			last_tick_jiffies;
+
+	/* Tick handling */
+	struct hrtimer			sched_timer;
 	ktime_t				last_tick;
 	ktime_t				next_tick;
 	unsigned long			idle_jiffies;
-	unsigned long			idle_calls;
-	unsigned long			idle_sleeps;
-	ktime_t				idle_entrytime;
 	ktime_t				idle_waketime;
-	ktime_t				idle_exittime;
-	ktime_t				idle_sleeptime;
-	ktime_t				iowait_sleeptime;
+
+	/* Idle entry */
+	ktime_t				idle_entrytime;
+
+	/* Tick stop */
+	enum tick_nohz_mode		nohz_mode;
 	unsigned long			last_jiffies;
-	u64				timer_expires;
 	u64				timer_expires_base;
+	u64				timer_expires;
 	u64				next_timer;
 	ktime_t				idle_expires;
+	unsigned long			idle_calls;
+	unsigned long			idle_sleeps;
+
+	/* Idle exit */
+	ktime_t				idle_exittime;
+	ktime_t				idle_sleeptime;
+	ktime_t				iowait_sleeptime;
+
+	/* Full dynticks handling */
 	atomic_t			tick_dep_mask;
-	unsigned long			last_tick_jiffies;
-	unsigned int			stalled_jiffies;
+
+	/* Clocksource changes */
+	unsigned long			check_clocks;
 };
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
