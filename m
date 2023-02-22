Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D499669F6FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 15:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjBVOrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 09:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbjBVOrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 09:47:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF94E3BDAF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 06:47:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3544661464
        for <linux-kernel@vger.kernel.org>; Wed, 22 Feb 2023 14:47:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819ADC4339B;
        Wed, 22 Feb 2023 14:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677077221;
        bh=Wy5hbT4ewIbxtuRGZo3BNmMi3nK/RbjQJn9sH1g4yFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FDmOTfUDDAvB318Tim6Svmwl4prd0CvCrO2yMhterj811AW25jGCizagfRmMU3PuO
         TtwrV6OOwv0mDAN5hY6twOv0xbamI50e31QG5hOBllfU0tfy1WiuNPI1PFNylJku9E
         QN4/p1q4Mkdo26fnClKlfGr9+zZk2dvpCo1jxbOYzQ+c677jHx0+V9SrSnUeintpfl
         JfyivG+S4iGlZNMP70TqKR+DSDUdc7Wbb+gTYayl3WGKBFkf2IXoLn4WuTbr4EivDM
         MdnybAwi2AGGOFmy382kl+pG1nF6aGuLLq2BGD/GXMWKOpgw5S3CvPPD7yfdLzqFb8
         UabOOMYAYTN6w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Wei Li <liwei391@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Yu Liao <liaoyu15@huawei.com>, Hillf Danton <hdanton@sina.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 2/8] timers/nohz: Only ever update sleeptime from idle exit
Date:   Wed, 22 Feb 2023 15:46:43 +0100
Message-Id: <20230222144649.624380-3-frederic@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230222144649.624380-1-frederic@kernel.org>
References: <20230222144649.624380-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The idle and io sleeptime statistics appearing in /proc/stat can be
currently updated from two sites: locally on idle exit and remotely
by cpufreq. However there is no synchronization mechanism protecting
concurrent updates. It is therefore possible to account the sleeptime
twice, among all the possible broken scenarios.

To prevent from breaking the sleeptime accounting source, restrict the
sleeptime updates to the local idle exit site. If there is a delta to
add since the last update, IO/Idle sleep time readers will now only
compute the delta without actually writing it back to the internal idle
statistic fields.

This fixes a writer VS writer race. Note there are still two known
reader VS writer races to handle. A subsequent patch will fix one.

Reported-by: Yu Liao <liaoyu15@huawei.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Wei Li <liwei391@huawei.com>
Cc: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/time/tick-sched.c | 103 ++++++++++++++++-----------------------
 1 file changed, 41 insertions(+), 62 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..9058b9eb8bc1 100644
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
-{
-	ktime_t delta;
-
-	if (ts->idle_active) {
-		delta = ktime_sub(now, ts->idle_entrytime);
-		if (nr_iowait_cpu(cpu) > 0)
-			ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
-		else
-			ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
-		ts->idle_entrytime = now;
-	}
-
-	if (last_update_time)
-		*last_update_time = ktime_to_us(now);
-
-}
-
 static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 {
-	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
+	ktime_t delta;
+
+	if (WARN_ON_ONCE(!ts->idle_active))
+		return;
+
+	delta = ktime_sub(now, ts->idle_entrytime);
+
+	if (nr_iowait_cpu(smp_processor_id()) > 0)
+		ts->iowait_sleeptime = ktime_add(ts->iowait_sleeptime, delta);
+	else
+		ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta);
+
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
-
-	return ktime_to_us(iowait);
+	return get_cpu_sleep_time_us(ts, &ts->iowait_sleeptime,
+				     nr_iowait_cpu(cpu), last_update_time);
 }
 EXPORT_SYMBOL_GPL(get_cpu_iowait_time_us);
 
-- 
2.34.1

