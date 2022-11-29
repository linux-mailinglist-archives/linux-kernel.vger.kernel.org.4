Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9963CBF1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiK2Xep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbiK2Xeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:34:37 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C351A13D46;
        Tue, 29 Nov 2022 15:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669764876; x=1701300876;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hvisxqquf2yYaCVhVJZxHzOaZVsvlPXCmm2MsGkCZx8=;
  b=YOK9OlxLztQdsHakZ2JkVlgV+INQoIbtgZLvJ9CgrCmIxOh/YYCOh0Yl
   0R6JxO9IQUSrO4x+Uz5fmlU7PceH2/LfU6/n9uBwXCxfxf5A69RMZu2dW
   UD2Y9fqxiMAKvT1BaY3m1oLFzUyrjR/Xpkw8zqpxGc1IaxVYOKsQgCm92
   DxBSO278mnVDaNwpzRXZy7JXox7NTHwG6GNOOPL3hVJL7n+3fHwrOTka5
   dh+HjaaQte3hyo6UYXo1aq6e0cKOKr7mpSAJo0KIG/KWx31kLKBnzzHMm
   nEreD7NdDlp3imd1l42pYm/nxJVjyl4X2+pb12Tbvy7SUGChnU1Qpbm8m
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342178170"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="342178170"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 15:34:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768617604"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="768617604"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2022 15:34:35 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 2/4] powercap: idle_inject: Add prepare/complete callbacks
Date:   Tue, 29 Nov 2022 15:34:17 -0800
Message-Id: <20221129233419.4022830-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
References: <20221129233419.4022830-1-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The actual idle percentage can be less than the desired because of
interrupts. Since the objective for CPU Idle injection is for thermal
control, there should be some way to compensate for lost idle percentage.
Some architectures provide interface to get actual idle percent observed
by the hardware. So, the idle percent can be adjusted using the hardware
feedback. For example, Intel CPUs provides package idle counters, which
is currently used by intel powerclamp driver to adjust idle time.

The only way this can be done currently is by monitoring hardware idle
percent from a different software thread. This can be avoided by adding
callbacks.

Add a capability to register a prepare and complete callback during idle
inject registry. Add a new register function idle_inject_register_full()
which also allows to register callbacks.

If they are not NULL, then prepare callback is called before calling
play_idle_precise() and complete callback is called after calling
play_idle_precise().

If prepare callback is present and returns non 0 value then
play_idle_precise() is not called to avoid over compensation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
- Replace begin/end with prepare/complete
- Add new interface idle_inject_register_full with callbacks
- Update kernel doc
- Update commit description

 drivers/powercap/idle_inject.c | 62 +++++++++++++++++++++++++++++++---
 include/linux/idle_inject.h    |  4 +++
 2 files changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index dfa989182e71..f48e71501429 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -63,13 +63,31 @@ struct idle_inject_thread {
  * @idle_duration_us: duration of CPU idle time to inject
  * @run_duration_us: duration of CPU run time to allow
  * @latency_us: max allowed latency
+ * @prepare: Callback function which is called before calling
+ *		play_idle_precise()
+ * @complete: Callback function which is called after calling
+ *		play_idle_precise()
  * @cpumask: mask of CPUs affected by idle injection
+ *
+ * This structure is used to define per instance idle inject device data. Each
+ * instance has an idle duration, a run duration and mask of CPUs to inject
+ * idle.
+ * Actual idle is injected by calling kernel scheduler interface
+ * play_idle_precise(). There are two optional callbacks which the caller can
+ * register by calling idle_inject_register_full():
+ * prepare() - This callback is called just before calling play_idle_precise()
+ *		If this callback returns non zero value then
+ *		play_idle_precise() is not called. This means skip injecting
+ *		idle during this period.
+ * complete() - This callback is called after calling play_idle_precise().
  */
 struct idle_inject_device {
 	struct hrtimer timer;
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned int latency_us;
+	int (*prepare)(unsigned int cpu);
+	void (*complete)(unsigned int cpu);
 	unsigned long cpumask[];
 };
 
@@ -132,6 +150,7 @@ static void idle_inject_fn(unsigned int cpu)
 {
 	struct idle_inject_device *ii_dev;
 	struct idle_inject_thread *iit;
+	int ret;
 
 	ii_dev = per_cpu(idle_inject_device, cpu);
 	iit = per_cpu_ptr(&idle_inject_thread, cpu);
@@ -141,8 +160,18 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
+	if (ii_dev->prepare) {
+		ret = ii_dev->prepare(cpu);
+		if (ret)
+			goto skip;
+	}
+
 	play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
 			  READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
+
+skip:
+	if (ii_dev->complete)
+		ii_dev->complete(cpu);
 }
 
 /**
@@ -295,17 +324,23 @@ static int idle_inject_should_run(unsigned int cpu)
 }
 
 /**
- * idle_inject_register - initialize idle injection on a set of CPUs
+ * idle_inject_register_full - initialize idle injection on a set of CPUs
  * @cpumask: CPUs to be affected by idle injection
+ * @prepare: callback called before calling play_idle_precise()
+ * @complete: callback called after calling play_idle_precise()
  *
  * This function creates an idle injection control device structure for the
- * given set of CPUs and initializes the timer associated with it.  It does not
- * start any injection cycles.
+ * given set of CPUs and initializes the timer associated with it. This
+ * function also allows to register prepare() and complete() callbacks.
+ * It does not start any injection cycles.
  *
  * Return: NULL if memory allocation fails, idle injection control device
  * pointer on success.
  */
-struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
+
+struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
+						     int (*prepare)(unsigned int cpu),
+						     void (*complete)(unsigned int cpu))
 {
 	struct idle_inject_device *ii_dev;
 	int cpu, cpu_rb;
@@ -318,6 +353,8 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
 	ii_dev->latency_us = UINT_MAX;
+	ii_dev->prepare = prepare;
+	ii_dev->complete = complete;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
@@ -342,6 +379,23 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 
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
+	return idle_inject_register_full(cpumask, NULL, NULL);
+}
 EXPORT_SYMBOL_NS_GPL(idle_inject_register, IDLE_INJECT);
 
 /**
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index fb88e23a99d3..e18d89793490 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -13,6 +13,10 @@ struct idle_inject_device;
 
 struct idle_inject_device *idle_inject_register(struct cpumask *cpumask);
 
+struct idle_inject_device *idle_inject_register_full(struct cpumask *cpumask,
+						     int (*prepare)(unsigned int cpu),
+						     void (*complete)(unsigned int cpu));
+
 void idle_inject_unregister(struct idle_inject_device *ii_dev);
 
 int idle_inject_start(struct idle_inject_device *ii_dev);
-- 
2.31.1

