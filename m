Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1D76E6794
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 16:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjDROx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 10:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjDROxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 10:53:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B71AF27;
        Tue, 18 Apr 2023 07:53:34 -0700 (PDT)
Date:   Tue, 18 Apr 2023 14:53:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1681829610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VvcTTLm2KkrV85I8ZMFlEWkPNdZDWITWa52KXTO/eUM=;
        b=WEnNSJhpdFhnaxTwsROiR+mglYmzIHk/XzEr8pvwbDewDM8usdPP0RFXmKQfKOHapYFa4e
        Pgp8nm1kOU1dByJ1KC2aQlkf7aEnopJqgintoZJsl2lgsnWY66IIeSXrMLE1UzOSIMCGeP
        /x/HImn1OKC+KekMy6m4tYhdKu/mNdSVnUJZhB4tEQBXc+3RA6suZwa6MAWRj9ADcvlltN
        dvpnERr7uFHK5E2SBzF/0a9npFvbHZwW3QC7bjzAeLxzcpKyeoD8OiU0VP+tTdZUAijS7Y
        zAIwyTsm/YYLAB+c6xKn/zr2qI+/eUEUQfcwvoHeC2EVgafqN57lhz3eYXbX2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1681829610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VvcTTLm2KkrV85I8ZMFlEWkPNdZDWITWa52KXTO/eUM=;
        b=WXpqv9xUAW4KJ2Z2SEviulUzbisUzlfTRkiUm/NboJ21xqFBM0vsUSgLbzSb9yynx6hVGX
        Y30SgAxdVv4L0yDA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timers/nohz: Only ever update sleeptime from idle exit
Cc:     Yu Liao <liaoyu15@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230222144649.624380-3-frederic@kernel.org>
References: <20230222144649.624380-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <168182961013.404.1915224443684031152.tip-bot2@tip-bot2>
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

Commit-ID:     07b65a800b6d5b6afbd6a91487b47038eac97c21
Gitweb:        https://git.kernel.org/tip/07b65a800b6d5b6afbd6a91487b47038eac97c21
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Wed, 22 Feb 2023 15:46:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Apr 2023 16:35:12 +02:00

timers/nohz: Only ever update sleeptime from idle exit

The idle and IO sleeptime statistics appearing in /proc/stat can be
currently updated from two sites: locally on idle exit and remotely
by cpufreq. However there is no synchronization mechanism protecting
concurrent updates. It is therefore possible to account the sleeptime
twice, among all the other possible broken scenarios.

To prevent from breaking the sleeptime accounting source, restrict the
sleeptime updates to the local idle exit site. If there is a delta to
add since the last update, IO/Idle sleep time readers will now only
compute the delta without actually writing it back to the internal idle
statistic fields.

This fixes a writer VS writer race. Note there are still two known
reader VS writer races to handle. A subsequent patch will fix one.

Reported-by: Yu Liao <liaoyu15@huawei.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20230222144649.624380-3-frederic@kernel.org

---
 kernel/time/tick-sched.c | 95 +++++++++++++++------------------------
 1 file changed, 37 insertions(+), 58 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c92..9058b9e 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -637,31 +637,21 @@ static void tick_nohz_update_jiffies(ktime_t now)
 	touch_softlockup_watchdog_sched();
 }
 
-/*
- * Updates the per-CPU time idle statistics counters
- */
-static void
-update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_update_time)
+static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 {
 	ktime_t delta;
 
-	if (ts->idle_active) {
-		delta = ktime_sub(now, ts->idle_entrytime);
-		if (nr_iowait_cpu(cpu) > 0)
-			ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
-		else
-			ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
-		ts->idle_entrytime = now;
-	}
+	if (WARN_ON_ONCE(!ts->idle_active))
+		return;
 
-	if (last_update_time)
-		*last_update_time = ktime_to_us(now);
+	delta = ktime_sub(now, ts->idle_entrytime);
 
-}
+	if (nr_iowait_cpu(smp_processor_id()) > 0)
+		ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
+	else
+		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
 
-static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
-{
-	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
+	ts->idle_entrytime = now;
 	ts->idle_active = 0;
 
 	sched_clock_idle_wakeup_event();
@@ -674,6 +664,30 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
 	sched_clock_idle_sleep_event();
 }
 
+static u64 get_cpu_sleep_time_us(struct tick_sched *ts, ktime_t *sleeptime,
+				 bool compute_delta, u64 *last_update_time)
+{
+	ktime_t now, idle;
+
+	if (!tick_nohz_active)
+		return -1;
+
+	now = ktime_get();
+	if (last_update_time)
+		*last_update_time = ktime_to_us(now);
+
+	if (ts->idle_active && compute_delta) {
+		ktime_t delta = ktime_sub(now, ts->idle_entrytime);
+
+		idle = ktime_add(*sleeptime, delta);
+	} else {
+		idle = *sleeptime;
+	}
+
+	return ktime_to_us(idle);
+
+}
+
 /**
  * get_cpu_idle_time_us - get the total idle time of a CPU
  * @cpu: CPU number to query
@@ -691,27 +705,9 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
-	ktime_t now, idle;
-
-	if (!tick_nohz_active)
-		return -1;
-
-	now = ktime_get();
-	if (last_update_time) {
-		update_ts_time_stats(cpu, ts, now, last_update_time);
-		idle = ts->idle_sleeptime;
-	} else {
-		if (ts->idle_active && !nr_iowait_cpu(cpu)) {
-			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
-
-			idle = ktime_add(ts->idle_sleeptime, delta);
-		} else {
-			idle = ts->idle_sleeptime;
-		}
-	}
-
-	return ktime_to_us(idle);
 
+	return get_cpu_sleep_time_us(ts, &ts->idle_sleeptime,
+				     !nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 
@@ -732,26 +728,9 @@ EXPORT_SYMBOL_GPL(get_cpu_idle_time_us);
 u64 get_cpu_iowait_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
-	ktime_t now, iowait;
-
-	if (!tick_nohz_active)
-		return -1;
-
-	now = ktime_get();
-	if (last_update_time) {
-		update_ts_time_stats(cpu, ts, now, last_update_time);
-		iowait = ts->iowait_sleeptime;
-	} else {
-		if (ts->idle_active && nr_iowait_cpu(cpu) > 0) {
-			ktime_t delta = ktime_sub(now, ts->idle_entrytime);
-
-			iowait = ktime_add(ts->iowait_sleeptime, delta);
-		} else {
-			iowait = ts->iowait_sleeptime;
-		}
-	}
 
-	return ktime_to_us(iowait);
+	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
+				     nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
