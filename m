Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A54262072B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiKHDEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:04:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233168AbiKHDEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:04:09 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202CB2FFDF;
        Mon,  7 Nov 2022 19:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667876648; x=1699412648;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bZKUfgswrQzZt1xpgqXVm99HvJ16L7TugknFYChFNOY=;
  b=kod4ktCazBOaxYEIesnWtCk1WqxovrgDvX+SCBoDw9WjjcnGyNbp213t
   sP4r1U0p3hlQbcBK8CzKxrVfvVPHMg+oTEWCmCm6kP1zKYj+V7WR/a9XU
   j3SI5U+GopD2Tlf1hiXfmiSy+db9qmLpWDqd4RJrTlexMFpH3qXBVTYTG
   5sZY5Qu30l+W7r0fFJq6ARpR15aAQtbaqfguZDSfPP5j591Z1klyb0jks
   i2KoGrGmuZQznixNpQxN5PAlqiexX+wXbiNYdxsl+OJDyu2mBvj1OM4aD
   Pzg2D5wNqXgdAauuwnc/5ApXTnpd42P1uHmLAm5Eb4hMMofLoN0KwBpi6
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337310748"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337310748"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:04:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638612678"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638612678"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 19:04:07 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] powercap: idle_inject: Add begin/end callbacks
Date:   Mon,  7 Nov 2022 19:03:40 -0800
Message-Id: <20221108030342.1127216-3-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221108030342.1127216-1-srinivas.pandruvada@linux.intel.com>
References: <20221108030342.1127216-1-srinivas.pandruvada@linux.intel.com>
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

The actual CPU Idle percent can be different than what can be observed
from the hardware. Since the objective for CPU Idle injection is for
thermal control, the idle percent observed by the hardware is more
relevant.

To account for hardware feedback the actual runtime/idle time should be
adjusted.

Add a capability to register a begin and end callback during call to
idle_inject_register(). If they are not NULL, then begin callback is
called before calling play_idle_precise() and end callback is called
after play_idle_precise().

If begin callback is present and returns non 0 value then
play_idle_precise() is not called as it means there is some over
compensation.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/powercap/idle_inject.c    | 19 ++++++++++++++++++-
 drivers/thermal/cpuidle_cooling.c |  2 +-
 include/linux/idle_inject.h       |  4 +++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index e73885bd9065..14968b0ff133 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -70,6 +70,8 @@ struct idle_inject_device {
 	unsigned int idle_duration_us;
 	unsigned int run_duration_us;
 	unsigned int latency_us;
+	int (*idle_inject_begin)(unsigned int cpu);
+	void (*idle_inject_end)(unsigned int cpu);
 	unsigned long cpumask[];
 };
 
@@ -132,6 +134,7 @@ static void idle_inject_fn(unsigned int cpu)
 {
 	struct idle_inject_device *ii_dev;
 	struct idle_inject_thread *iit;
+	int ret;
 
 	ii_dev = per_cpu(idle_inject_device, cpu);
 	iit = per_cpu_ptr(&idle_inject_thread, cpu);
@@ -141,8 +144,18 @@ static void idle_inject_fn(unsigned int cpu)
 	 */
 	iit->should_run = 0;
 
+	if (ii_dev->idle_inject_begin) {
+		ret = ii_dev->idle_inject_begin(cpu);
+		if (ret)
+			goto skip;
+	}
+
 	play_idle_precise(READ_ONCE(ii_dev->idle_duration_us) * NSEC_PER_USEC,
 			  READ_ONCE(ii_dev->latency_us) * NSEC_PER_USEC);
+
+skip:
+	if (ii_dev->idle_inject_end)
+		ii_dev->idle_inject_end(cpu);
 }
 
 /**
@@ -302,7 +315,9 @@ static int idle_inject_should_run(unsigned int cpu)
  * Return: NULL if memory allocation fails, idle injection control device
  * pointer on success.
  */
-struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
+struct idle_inject_device *idle_inject_register(struct cpumask *cpumask,
+						int (*idle_inject_begin)(unsigned int cpu),
+						void (*idle_inject_end)(unsigned int cpu))
 {
 	struct idle_inject_device *ii_dev;
 	int cpu, cpu_rb;
@@ -315,6 +330,8 @@ struct idle_inject_device *idle_inject_register(struct cpumask *cpumask)
 	hrtimer_init(&ii_dev->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	ii_dev->timer.function = idle_inject_timer_fn;
 	ii_dev->latency_us = UINT_MAX;
+	ii_dev->idle_inject_begin = idle_inject_begin;
+	ii_dev->idle_inject_end = idle_inject_end;
 
 	for_each_cpu(cpu, to_cpumask(ii_dev->cpumask)) {
 
diff --git a/drivers/thermal/cpuidle_cooling.c b/drivers/thermal/cpuidle_cooling.c
index 4f41102e8b16..e8b35b3b5767 100644
--- a/drivers/thermal/cpuidle_cooling.c
+++ b/drivers/thermal/cpuidle_cooling.c
@@ -184,7 +184,7 @@ static int __cpuidle_cooling_register(struct device_node *np,
 		goto out;
 	}
 
-	ii_dev = idle_inject_register(drv->cpumask);
+	ii_dev = idle_inject_register(drv->cpumask, NULL, NULL);
 	if (!ii_dev) {
 		ret = -EINVAL;
 		goto out_kfree;
diff --git a/include/linux/idle_inject.h b/include/linux/idle_inject.h
index fb88e23a99d3..73f3414fafe2 100644
--- a/include/linux/idle_inject.h
+++ b/include/linux/idle_inject.h
@@ -11,7 +11,9 @@
 /* private idle injection device structure */
 struct idle_inject_device;
 
-struct idle_inject_device *idle_inject_register(struct cpumask *cpumask);
+struct idle_inject_device *idle_inject_register(struct cpumask *cpumask,
+						int (*idle_inject_begin)(unsigned int cpu),
+						void (*idle_inject_end)(unsigned int cpu));
 
 void idle_inject_unregister(struct idle_inject_device *ii_dev);
 
-- 
2.37.3

