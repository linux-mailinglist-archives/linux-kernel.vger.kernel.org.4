Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ECFA66D416
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 03:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjAQCIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 21:08:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235150AbjAQCHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 21:07:46 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BFC1DBB6;
        Mon, 16 Jan 2023 18:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673921265; x=1705457265;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pf5odtJ7eC1FC8bG+y+UlkBGlbR6fMPmvDJxk/oztQc=;
  b=YO61pgNBmqTC5wrpngjDCOMsW5oUxF43Gom7AtIEsKYll/rBgFafWiBY
   Hg+q4gsJWJOXelgzxNO8Eezr/U+c3IohTqkfLOS6B7xdnRcy82bk/DLlq
   o7gww8wsB5jBnfmokuwoWf2zDpHB0IX1ZjAgc0U6/gzXeT/jJyqm/d+hy
   /ywh0HCaNCdej5ftu1/tOlUh8YrM2FAUXvzeEjobWbLpOh8rbremGrjPC
   NGkB67zCWU6sLznfr3pd0hpa+Q4RtnnyPusztht1G95SSdRQZA5PYKA1T
   MusQXykYdNvMnulxbbunjpgHkQbkQibPH7VxcXnf4NehrASsDlawqKM5v
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="323287633"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="323287633"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2023 18:07:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="636703089"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="636703089"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 16 Jan 2023 18:07:43 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v3 2/4] powercap: idle_inject: Add update callback
Date:   Mon, 16 Jan 2023 18:07:40 -0800
Message-Id: <20230117020742.2760307-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
References: <20230117020742.2760307-1-srinivas.pandruvada@linux.intel.com>
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

The powercap/idle_inject core uses play_idle_precise() to inject idle
time. But play_idle_precise() can't ensure that the CPU is fully idle
for the specified duration because of wakeups due to interrupts. To
compensate for the reduced idle time due to these wakes, the caller
can adjust requested idle time for the next cycle.

The goal of idle injection is to keep system at some idle percent on
average, so this is fine to overshoot or undershoot instantaneous idle
times.

The idle inject core provides an interface idle_inject_set_duration()
to set idle and runtime duration.

Some architectures provide interface to get actual idle time observed
by the hardware. So, the effective idle percent can be adjusted using
the hardware feedback. For example, Intel CPUs provides package idle
counters, which is currently used by Intel powerclamp driver to
readjust runtime duration.

When the caller's desired idle time over a period is less or greater
than the actual CPU idle time observed by the hardware, caller can
readjust idle and runtime duration for the next cycle.

The only way this can be done currently is by monitoring hardware idle
time from a different software thread and readjust idle and runtime
duration using idle_inject_set_duration().

This can be avoided by adding a callback which callers can register and
readjust from this callback function.

Add a capability to register an optional update() callback, which can be
called from the idle inject core before waking up CPUs for idle injection.
This callback can be registered via a new interface:
idle_inject_register_full().

During this process of constantly adjusting idle and runtime duration
there can be some cases where actual idle time is more than the desired.
In this case idle inject can be skipped for a cycle. If update() callback
returns false, then the idle inject core skips waking up CPUs for the
idle injection.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3:
- Replace prepare/complete callback with update callback

v2
- Replace begin/end with prepare/complete
- Add new interface idle_inject_register_full with callbacks
- Update kernel doc
- Update commit description

 drivers/powercap/idle_inject.c | 50 ++++++++++++++++++++++++++++++----
 include/linux/idle_inject.h    |  3 ++
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index dfa989182e71..c57b40477246 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -63,13 +63,27 @@ struct idle_inject_thread {
  * @idle_duration_us: duration of CPU idle time to inject
  * @run_duration_us: duration of CPU run time to allow
  * @latency_us: max allowed latency
+ * @update: Optional callback deciding whether or not to skip idle
+ *		injection in the given cycle.
  * @cpumask: mask of CPUs affected by idle injection
+ *
+ * This structure is used to define per instance idle inject device data. Each
+ * instance has an idle duration, a run duration and mask of CPUs to inject
+ * idle.
+ * Actual idle is injected by calling kernel scheduler interface
+ * play_idle_precise(). There is one optional callbacks which the caller can
+ * register by calling idle_inject_register_full():
+ * update() - This callback is called just before waking up CPUs to inject
+ * idle. If this callback returns false, CPUs are not woken up to inject idle
+ * for this cycle. Also gives opportunity to the caller to readjust idle
+ * and run duration by calling idle_inject_set_duration() for the next cycle.
  */
 struct idle_inject_device {
 	struct hrtimer timer;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned int latency_us;
+	bool (*update)(void);
 	unsigned long cpumask[];
 };
 
@@ -111,11 +125,12 @@ static enum hrtimer_restart idle_inject_timer_fn(struct hrtimer *timer)
 	struct idle_inject_device *ii_dev =
 		container_of(timer, struct idle_inject_device, timer);
 
+	if (!ii_dev->update || (ii_dev->update && ii_dev->update()))
+		idle_inject_wakeup(ii_dev);
+
 	duration_us = READ_ONCE(ii_dev->run_duration_us);
 	duration_us += READ_ONCE(ii_dev->idle_duration_us);
 
-	idle_inject_wakeup(ii_dev);
-
 	hrtimer_forward_now(timer, ns_to_ktime(duration_us * NSEC_PER_USEC));
 
 	return HRTIMER_RESTART;
@@ -295,17 +310,22 @@ static int idle_inject_should_run(unsigned int cpu)
 }
 
 /**
- * idle_inject_register - initialize idle injection on a set of CPUs
+ * idle_inject_register_full - initialize idle injection on a set of CPUs
  * @cpumask: CPUs to be affected by idle injection
+ * @update: This callback is called just before waking up CPUs to inject
+ * idle
  *
  * This function creates an idle injection control device structure for the
- * given set of CPUs and initializes the timer associated with it.  It does not
- * start any injection cycles.
+ * given set of CPUs and initializes the timer associated with it. This
+ * function also allows to register update()callback.
+ * It does not start any injection cycles.
  *
  * Return: NULL if memory allocation fails, idle injection control device
  * pointer on success.
  */
-struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
+
+struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
+						     bool (*update)(void))
 {
 	struct idle_inject_device *ii_dev;
 	int cpu, cpu_rb;
@@ -318,6 +338,7 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
 	ii_dev->latency_us = UINT_MAX;
+	ii_dev->update = update;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
@@ -342,6 +363,23 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 
 	return NULL;
 }
+EXPORT_SYMBOL_NS_GPL(idle_inject_register_full, IDLE_INJECT);
+
+/**
+ * idle_inject_register - initialize idle injection on a set of CPUs
+ * @cpumask: CPUs to be affected by idle injection
+ *
+ * This function creates an idle injection control device structure for the
+ * given set of CPUs and initializes the timer associated with it.  It does not
+ * start any injection cycles.
+ *
+ * Return: NULL if memory allocation fails, idle injection control device
+ * pointer on success.
+ */
+struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
+{
+	return idle_inject_register_full(cpumask, NULL);
+}
 EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
 
 /**
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index fb88e23a99d3..a85d5dd40f72 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -13,6 +13,9 @@ struct idle_inject_device;
 
 struct idle_inject_device *idle_inject_register(struct cpumask *cpumask);
 
+struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
+						     bool (*update)(void));
+
 void idle_inject_unregister(struct idle_inject_device *ii_dev);
 
 int idle_inject_start(struct idle_inject_device *ii_dev);
-- 
2.31.1

