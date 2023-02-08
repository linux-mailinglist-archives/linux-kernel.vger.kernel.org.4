Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF14C68F1D9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 16:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjBHPTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 10:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbjBHPTg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 10:19:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0A41E9D0
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 07:19:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BDC0616EE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 15:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380F7C433D2;
        Wed,  8 Feb 2023 15:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675869573;
        bh=MtJnJJ6b33n0/jOJNoXl97RZ3B1Mim0+uCOBp8fF7YU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PPe7WJJmiROwbI47CQqsSOtI8tfmPNTiV7XC5X2qqbWLXadO/GyUCOWmtJigQsqa0
         WF7BA+irZM8HLNSRqoO+buG5+biYdYZGBCFQVUAldgAoijPD61CZIrMPGOX11O/Umj
         n06T5Q/oKpefknR3LlCGjpqg/0VZ4EeSDQ8pR8x9s+flxnHHAICQvF0uvI/089mTes
         Nop81c15SjffXyQ8gvpcZGkPmv37QHU6yRdqrXiklNXjineRdHiEFm0Wye4lykOxun
         q+kgez/NNAjoHnuDsXA8Ul842LKqG/qqaN05G75SE/iAe9ucPpu7Veoboe1w1M3HEp
         MvxAtddYEhcmg==
Date:   Wed, 8 Feb 2023 16:19:30 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Yu Liao <liaoyu15@huawei.com>, fweisbec@gmail.com,
        mingo@kernel.org, liwei391@huawei.com, adobriyan@gmail.com,
        mirsad.todorovac@alu.unizg.hr, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] timers/nohz: Restructure and reshuffle struct tick_sched
Message-ID: <Y+O9gjj/ZJY/Qnoo@lothringen>
References: <20230128020051.2328465-1-liaoyu15@huawei.com>
 <87357q228f.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87357q228f.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 31, 2023 at 03:44:00PM +0100, Thomas Gleixner wrote:
> @Frederic: This structure is patently unstructured and if we fix this
> issue here then we really want to look at the cache line layout for
> real.

I'm not really good at that, but here is my try:

---
From: Frederic Weisbecker <frederic@kernel.org>
Date: Wed, 8 Feb 2023 16:08:11 +0100
Subject: [PATCH] timers/nohz: Restructure and reshuffle struct tick_sched

Restructure and group fields by access in order to optimize cache
layout. While at it, also add missing kernel doc for two fields:
@last_jiffies and @idle_expires.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.h | 66 +++++++++++++++++++++++++---------------
 1 file changed, 41 insertions(+), 25 deletions(-)

diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 504649513399..c6663254d17d 100644
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
-- 
2.34.1

