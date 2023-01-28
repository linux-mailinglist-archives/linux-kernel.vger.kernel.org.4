Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C682C67F3CE
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Jan 2023 02:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjA1BnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 20:43:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjA1BnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 20:43:11 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A7D28D2B
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 17:43:10 -0800 (PST)
Received: from dggpeml100003.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P3cbp6zsTznVyj;
        Sat, 28 Jan 2023 09:41:10 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpeml100003.china.huawei.com
 (7.185.36.120) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sat, 28 Jan
 2023 09:43:07 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>
CC:     <liaoyu15@huawei.com>, <liwei391@huawei.com>,
        <adobriyan@gmail.com>, <mirsad.todorovac@alu.unizg.hr>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH RFC] tick/nohz: fix data races in get_cpu_idle_time_us()
Date:   Sat, 28 Jan 2023 10:00:51 +0800
Message-ID: <20230128020051.2328465-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml100003.china.huawei.com (7.185.36.120)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

selftest/proc/proc-uptime-001 complains:
  Euler:/mnt # while true; do ./proc-uptime-001; done
  proc-uptime-001: proc-uptime-001.c:41: main: Assertion `i1 >= i0' failed.
  proc-uptime-001: proc-uptime-001.c:41: main: Assertion `i1 >= i0' failed.

/proc/uptime should be monotonically increasing. This occurs because
the data races between get_cpu_idle_time_us and
tick_nohz_stop_idle/tick_nohz_start_idle, for example:

CPU0                        CPU1
get_cpu_idle_time_us

                            tick_nohz_idle_exit
                              now = ktime_get();
                              tick_nohz_stop_idle
                                update_ts_time_stats
                                  delta = ktime_sub(now, ts->idle_entrytime);
                                  ts->idle_sleeptime = ktime_add(ts->idle_sleeptime, delta)
                                  ts->idle_entrytime = now

now = ktime_get();
if (ts->idle_active && !nr_iowait_cpu(cpu)) {
    ktime_t delta = ktime_sub(now, ts->idle_entrytime);
    idle = ktime_add(ts->idle_sleeptime, delta);
    //idle is slightly greater than the actual value
} else {
    idle = ts->idle_sleeptime;
}
                            ts->idle_active = 0

After this, idle = idle_sleeptime(actual idle value) + now(CPU0) - now(CPU1).
If get_cpu_idle_time_us() is called immediately after ts->idle_active = 0,
only ts->idle_sleeptime is returned, which is smaller than the previously
read one, resulting in a non-monotonically increasing idle time. In
addition, there are other data race scenarios not listed here.

This patch introduce a lock to prevent data races.

Fixes: a130e8fbc7de ("fs/proc/uptime.c: Fix idle time reporting in /proc/uptime")
Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 kernel/time/tick-sched.c | 15 ++++++++++++++-
 kernel/time/tick-sched.h |  1 +
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b0e3c9205946..ad7d47098a58 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -36,7 +36,9 @@
 /*
  * Per-CPU nohz control structure
  */
-static DEFINE_PER_CPU(struct tick_sched, tick_cpu_sched);
+static DEFINE_PER_CPU(struct tick_sched, tick_cpu_sched) = {
+	.idle_time_lock = __SPIN_LOCK_UNLOCKED(tick_cpu_sched.idle_time_lock),
+};
 
 struct tick_sched *tick_get_tick_sched(int cpu)
 {
@@ -661,16 +663,24 @@ update_ts_time_stats(int cpu, struct tick_sched *ts, ktime_t now, u64 *last_upda
 
 static void tick_nohz_stop_idle(struct tick_sched *ts, ktime_t now)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->idle_time_lock, flags);
 	update_ts_time_stats(smp_processor_id(), ts, now, NULL);
 	ts->idle_active = 0;
+	spin_unlock_irqrestore(&ts->idle_time_lock, flags);
 
 	sched_clock_idle_wakeup_event();
 }
 
 static void tick_nohz_start_idle(struct tick_sched *ts)
 {
+	unsigned long flags;
+
+	spin_lock_irqsave(&ts->idle_time_lock, flags);
 	ts->idle_entrytime = ktime_get();
 	ts->idle_active = 1;
+	spin_unlock_irqrestore(&ts->idle_time_lock, flags);
 	sched_clock_idle_sleep_event();
 }
 
@@ -691,12 +701,14 @@ static void tick_nohz_start_idle(struct tick_sched *ts)
 u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 {
 	struct tick_sched *ts = &per_cpu(tick_cpu_sched, cpu);
+	unsigned long flags;
 	ktime_t now, idle;
 
 	if (!tick_nohz_active)
 		return -1;
 
 	now = ktime_get();
+	spin_lock_irqsave(&ts->idle_time_lock, flags);
 	if (last_update_time) {
 		update_ts_time_stats(cpu, ts, now, last_update_time);
 		idle = ts->idle_sleeptime;
@@ -709,6 +721,7 @@ u64 get_cpu_idle_time_us(int cpu, u64 *last_update_time)
 			idle = ts->idle_sleeptime;
 		}
 	}
+	spin_unlock_irqrestore(&ts->idle_time_lock, flags);
 
 	return ktime_to_us(idle);
 
diff --git a/kernel/time/tick-sched.h b/kernel/time/tick-sched.h
index 504649513399..a64d4781e7af 100644
--- a/kernel/time/tick-sched.h
+++ b/kernel/time/tick-sched.h
@@ -81,6 +81,7 @@ struct tick_sched {
 	atomic_t			tick_dep_mask;
 	unsigned long			last_tick_jiffies;
 	unsigned int			stalled_jiffies;
+	spinlock_t			idle_time_lock;
 };
 
 extern struct tick_sched *tick_get_tick_sched(int cpu);
-- 
2.25.1

