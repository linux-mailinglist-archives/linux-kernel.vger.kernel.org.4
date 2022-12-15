Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 794DB64E126
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 19:43:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiLOSni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 13:43:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229975AbiLOSna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 13:43:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C55C20BEC;
        Thu, 15 Dec 2022 10:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671129809; x=1702665809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=alyrCRpg7VFefOZMHRABhidPtpezk2Hp/kqcUajm0NM=;
  b=AONdNd28/CS/Exz0LcHeyhZMxNxS1k6F018I0F7wdvj9cAUECAi73cwg
   WK1nuN+306ej0rzqhjrfZ6WnnTfRQfTFW5tkTyNfGZoyjEUKeSgsFg+1N
   b1A8mvDgrD938q6gUfTGnhAZHnZ3vzlLqeoSm6DqbASEcgClP8ucL81Qa
   q/XdWDqqeKYtySe7IH5jaQ0dlNqZZuVo6EqidV6W6DoEHPgJK5m4B2vYm
   stDxiNR4zGUSp52LwyEr+CW9Wb7fuMCTbQer2roa19yrxhlMUZbwVWSbf
   Xz6NyjanVaLDC+4wq76Xn2e/cKk+TQufMbXvFE7+c/MFfFkHMmstewKLF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="299112646"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="299112646"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 10:43:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="756442196"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="756442196"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga002.fm.intel.com with ESMTP; 15 Dec 2022 10:43:28 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, peterz@infradead.org, frederic@kernel.org,
        daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        len.brown@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC/RFT PATCH 2/2] sched/core: Add max duration to play_precise_idle()
Date:   Thu, 15 Dec 2022 10:43:00 -0800
Message-Id: <20221215184300.1592872-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
References: <20221215184300.1592872-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When there is a storm of soft irqs, it is possible that caller
spends lot more time in play_idle_precise() than the actual
idle time requested.

Add a pramater to play_precise_idle() to specify a maximum time to
exit the loop in play_precise_idle(), even if the the total forced idle
time is less than the desired. If exit before the required forced idle
duration return error to the caller, otherwise return 0.

For powercap/idle_inject, the maximum wait will be capped to two times
of idle duration.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/idle_inject.c |  4 +++-
 include/linux/cpu.h            |  4 ++--
 kernel/sched/idle.c            | 13 +++++++++++--
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index fe86a09e3b67..2764155d184e 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -132,6 +132,7 @@ static void idle_inject_fn(unsigned int cpu)
 {
 	struct idle_inject_device *ii_dev;
 	struct idle_inject_thread *iit;
+	u64 idle_duration_ns;
 
 	ii_dev = per_cpu(idle_inject_device, cpu);
 	iit = per_cpu_ptr(&idle_inject_thread, cpu);
@@ -140,8 +141,9 @@ static void idle_inject_fn(unsigned int cpu)
 	 * Let the smpboot main loop know that the task should not run again.
 	 */
 	iit->should_run = 0;
+	idle_duration_ns = READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC;
 
-	play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
+	play_idle_precise(idle_duration_ns, idle_duration_ns << 1,
 			  READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
 }
 
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 314802f98b9d..9969940553e5 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -190,11 +190,11 @@ void arch_cpu_idle_dead(void);
 int cpu_report_state(int cpu);
 int cpu_check_up_prepare(int cpu);
 void cpu_set_state_online(int cpu);
-void play_idle_precise(u64 duration_ns, u64 latency_ns);
+int play_idle_precise(u64 duration_ns, u64 max_duration_ns, u64 latency_ns);
 
 static inline void play_idle(unsigned long duration_us)
 {
-	play_idle_precise(duration_us * NSEC_PER_USEC, U64_MAX);
+	play_idle_precise(duration_us * NSEC_PER_USEC, 0, U64_MAX);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 77d6168288cf..c98b77ff84f5 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -360,10 +360,10 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	return HRTIMER_NORESTART;
 }
 
-void play_idle_precise(u64 duration_ns, u64 latency_ns)
+int play_idle_precise(u64 duration_ns, u64 duration_ns_max, u64 latency_ns)
 {
 	struct idle_timer it;
-	ktime_t remaining;
+	ktime_t remaining, end_time;
 
 	/*
 	 * Only FIFO tasks can disable the tick since they don't need the forced
@@ -378,6 +378,8 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 
 	remaining = ns_to_ktime(duration_ns);
 
+	end_time = ktime_add_ns(ktime_get(), duration_ns_max);
+
 	do {
 		rcu_sleep_check();
 		preempt_disable();
@@ -402,12 +404,19 @@ void play_idle_precise(u64 duration_ns, u64 latency_ns)
 		preempt_fold_need_resched();
 		preempt_enable();
 
+		if (!READ_ONCE(it.done) && duration_ns_max) {
+			if (ktime_after(ktime_get(), end_time))
+				return -EAGAIN;
+		}
+
 		/* Give ksoftirqd 1 jiffy to get a chance to start its job */
 		if (!READ_ONCE(it.done) && task_is_running(__this_cpu_read(ksoftirqd))) {
 			__set_current_state(TASK_UNINTERRUPTIBLE);
 			schedule_timeout(1);
 		}
 	} while (!READ_ONCE(it.done));
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(play_idle_precise);
 
-- 
2.38.1

