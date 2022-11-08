Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D074962072C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233298AbiKHDE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiKHDEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:04:10 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118672FFEC;
        Mon,  7 Nov 2022 19:04:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667876649; x=1699412649;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dxRO8ihGEN1iBkWIJJbqgCAhtl1mODxjE+WqrNOJ0rM=;
  b=SuifzG+f6KOEz5OvTPoh3jxasb+hYcEqz0CE424AZIJfjsZeDfe15rwO
   /Zj10vvdaOSfGExMmF4D3zVffpsNGfMfY0bRF/DcOxJJwMLBacN7HoOof
   nzOgUYBYtMSRYEAF5mquFtVNN6RhkJz7a8wYbPZMbMW6GaTyJGVIEBLA5
   Cxfc4R3dXMrQA5j9KJULqLdIszxz7QQmFLR/rAsVBieGXbOQP5URXYq9X
   p1wkrY/cNwCESTbvRtC/W1gXtfEET5hiSBrRku8kIb8xQsT9m1O65upSC
   0G1iPh/tkIkJjOO/jwd3VIgJskTN+2WL1xtO5Sf2AIsPtc0oaRH1JX+sc
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="337310750"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="337310750"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 19:04:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638612691"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638612691"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 07 Nov 2022 19:04:07 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rui.zhang@intel.com, rafael@kernel.org, daniel.lezcano@linaro.org
Cc:     amitk@kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] thermal/drivers/intel_cpu_idle_cooling: Introduce Intel cpu idle cooling driver
Date:   Mon,  7 Nov 2022 19:03:42 -0800
Message-Id: <20221108030342.1127216-5-srinivas.pandruvada@linux.intel.com>
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

The cpu idle cooling is used to cool down a CPU by injecting idle cycles
at runtime. The objective is similar to intel_powerclamp driver, which is
used for system wide cooling by injecting idle on each CPU.

This driver is modeled after drivers/thermal/cpuidle_cooling.c by reusing
powercap/idle_inject framework.

On each CPU online a thermal cooling device is registered. The minimum
state of the cooling device is 0 and maximum is 100. When user space
changes the current state to non zero, then register with idle inject
framework and start idle inject.

The default idle duration is 24 milli seconds, matching intel_powerclamp,
which doesn't change based on the current state of cooling device. The
runtime is changed based on the current state.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/intel/Kconfig                 |  10 +
 drivers/thermal/intel/Makefile                |   1 +
 .../thermal/intel/intel_cpu_idle_cooling.c    | 262 ++++++++++++++++++
 3 files changed, 273 insertions(+)
 create mode 100644 drivers/thermal/intel/intel_cpu_idle_cooling.c

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index 0883740bf70d..c93daa7c83eb 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -114,3 +114,13 @@ config INTEL_HFI_THERMAL
 	  These capabilities may change as a result of changes in the operating
 	  conditions of the system such power and thermal limits. If selected,
 	  the kernel relays updates in CPUs' capabilities to userspace.
+
+config INTEL_CPU_IDLE_COOLING
+	tristate "Intel CPU idle cooling device"
+	depends on IDLE_INJECT
+	help
+	  This implements the CPU cooling mechanism through
+	  idle injection. This will throttle the CPU by injecting
+	  idle cycle.
+	  Unlike Intel Power clamp driver, this driver provides
+	  idle injection for each CPU.
diff --git a/drivers/thermal/intel/Makefile b/drivers/thermal/intel/Makefile
index 9a8d8054f316..8d5f7b5cf9b7 100644
--- a/drivers/thermal/intel/Makefile
+++ b/drivers/thermal/intel/Makefile
@@ -14,3 +14,4 @@ obj-$(CONFIG_INTEL_TCC_COOLING)	+= intel_tcc_cooling.o
 obj-$(CONFIG_X86_THERMAL_VECTOR) += therm_throt.o
 obj-$(CONFIG_INTEL_MENLOW)	+= intel_menlow.o
 obj-$(CONFIG_INTEL_HFI_THERMAL) += intel_hfi.o
+obj-$(CONFIG_INTEL_CPU_IDLE_COOLING) += intel_cpu_idle_cooling.o
diff --git a/drivers/thermal/intel/intel_cpu_idle_cooling.c b/drivers/thermal/intel/intel_cpu_idle_cooling.c
new file mode 100644
index 000000000000..5df79f38d9fb
--- /dev/null
+++ b/drivers/thermal/intel/intel_cpu_idle_cooling.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Per CPU Idle injection cooling device implementation
+ *
+ * Copyright (c) 2022, Intel Corporation.
+ * All rights reserved.
+ *
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/cpufeature.h>
+#include <linux/cpuhotplug.h>
+#include <linux/idle_inject.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/thermal.h>
+#include <linux/topology.h>
+
+#include <asm/cpu_device_id.h>
+
+/* Duration match with intel_powerclamp driver */
+#define IDLE_DURATION		24000
+#define IDLE_LATENCY		UINT_MAX
+
+static int idle_duration_us = IDLE_DURATION;
+static int idle_latency_us = IDLE_LATENCY;
+
+module_param(idle_duration_us, int, 0644);
+MODULE_PARM_DESC(idle_duration_us,
+		 "Idle duration in us.");
+
+module_param(idle_latency_us, int, 0644);
+MODULE_PARM_DESC(idle_latency_us,
+		 "Idle latency in us.");
+
+/**
+ * struct cpuidle_cooling - Per instance data for cooling device
+ * @cpu: CPU number for this cooling device
+ * @ii_dev: Idle inject core instance pointer
+ * @cdev: Thermal core cooling device instance
+ * @state:  Current cooling device state
+ *
+ * Stores per instance cooling device state.
+ */
+struct cpuidle_cooling {
+	int cpu;
+	struct idle_inject_device *ii_dev;
+	struct thermal_cooling_device *cdev;
+	unsigned long state;
+};
+
+static DEFINE_PER_CPU(struct cpuidle_cooling, cooling_devs);
+static cpumask_t cpuidle_cpu_mask;
+
+/* Used for module unload protection with idle injection operations */
+static DEFINE_MUTEX(idle_cooling_lock);
+
+static unsigned int cpuidle_cooling_runtime(unsigned int idle_duration_us,
+					    unsigned long state)
+{
+	if (!state)
+		return 0;
+
+	return ((idle_duration_us * 100) / state) - idle_duration_us;
+}
+
+static int cpuidle_idle_injection_register(struct cpuidle_cooling *cooling_dev)
+{
+	struct idle_inject_device *ii_dev;
+
+	ii_dev = idle_inject_register((struct cpumask *)cpumask_of(cooling_dev->cpu),
+				      NULL, NULL);
+	if (!ii_dev) {
+		/*
+		 * It is busy as some other device claimed idle injection for this CPU
+		 * Also it is possible that memory allocation failure.
+		 */
+		pr_err("idle_inject_register failed for cpu:%d\n", cooling_dev->cpu);
+		return -EAGAIN;
+	}
+
+	idle_inject_set_duration(ii_dev, TICK_USEC, idle_duration_us);
+	idle_inject_set_latency(ii_dev, idle_latency_us);
+
+	cooling_dev->ii_dev = ii_dev;
+
+	return 0;
+}
+
+static void cpuidle_idle_injection_unregister(struct cpuidle_cooling *cooling_dev)
+{
+	idle_inject_unregister(cooling_dev->ii_dev);
+}
+
+static int cpuidle_cooling_get_max_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+	*state = 100;
+
+	return 0;
+}
+
+static int cpuidle_cooling_get_cur_state(struct thermal_cooling_device *cdev,
+					 unsigned long *state)
+{
+	struct cpuidle_cooling *cooling_dev = cdev->devdata;
+
+	*state = READ_ONCE(cooling_dev->state);
+
+	return 0;
+}
+
+static int cpuidle_cooling_set_cur_state(struct thermal_cooling_device *cdev,
+					 unsigned long state)
+{
+	struct cpuidle_cooling *cooling_dev = cdev->devdata;
+	unsigned int runtime_us;
+	unsigned long curr_state;
+	int ret = 0;
+
+	mutex_lock(&idle_cooling_lock);
+
+	curr_state = READ_ONCE(cooling_dev->state);
+
+	if (!curr_state && state > 0) {
+		/*
+		 * This is the first time to start cooling, so register with
+		 * idle injection framework.
+		 */
+		if (!cooling_dev->ii_dev) {
+			ret = cpuidle_idle_injection_register(cooling_dev);
+			if (ret)
+				goto unlock_set_state;
+		}
+
+		runtime_us = cpuidle_cooling_runtime(idle_duration_us, state);
+
+		idle_inject_set_duration(cooling_dev->ii_dev, runtime_us, idle_duration_us);
+		idle_inject_start(cooling_dev->ii_dev);
+	} else if (curr_state > 0 && state) {
+		/* Simply update runtime */
+		runtime_us = cpuidle_cooling_runtime(idle_duration_us, state);
+		idle_inject_set_duration(cooling_dev->ii_dev, runtime_us, idle_duration_us);
+	} else if (curr_state > 0 && !state) {
+		idle_inject_stop(cooling_dev->ii_dev);
+		cpuidle_idle_injection_unregister(cooling_dev);
+		cooling_dev->ii_dev = NULL;
+	}
+
+	WRITE_ONCE(cooling_dev->state, state);
+
+unlock_set_state:
+	mutex_unlock(&idle_cooling_lock);
+
+	return ret;
+}
+
+/**
+ * cpuidle_cooling_ops - thermal cooling device ops
+ */
+static struct thermal_cooling_device_ops cpuidle_cooling_ops = {
+	.get_max_state = cpuidle_cooling_get_max_state,
+	.get_cur_state = cpuidle_cooling_get_cur_state,
+	.set_cur_state = cpuidle_cooling_set_cur_state,
+};
+
+static int cpuidle_cooling_register(int cpu)
+{
+	struct cpuidle_cooling *cooling_dev = &per_cpu(cooling_devs, cpu);
+	struct thermal_cooling_device *cdev;
+	char name[14]; /* storage for cpuidle-XXXX */
+	int ret = 0;
+
+	mutex_lock(&idle_cooling_lock);
+
+	snprintf(name, sizeof(name), "cpuidle-%d", cpu);
+	cdev = thermal_cooling_device_register(name, cooling_dev, &cpuidle_cooling_ops);
+	if (IS_ERR(cdev)) {
+		ret = PTR_ERR(cdev);
+		goto unlock_register;
+	}
+
+	cooling_dev->cdev = cdev;
+	cpumask_set_cpu(cpu, &cpuidle_cpu_mask);
+	cooling_dev->cpu = cpu;
+
+unlock_register:
+	mutex_unlock(&idle_cooling_lock);
+
+	return ret;
+}
+
+static void cpuidle_cooling_unregister(int cpu)
+{
+	struct cpuidle_cooling *cooling_dev = &per_cpu(cooling_devs, cpu);
+
+	mutex_lock(&idle_cooling_lock);
+
+	if (cooling_dev->state) {
+		idle_inject_stop(cooling_dev->ii_dev);
+		cpuidle_idle_injection_unregister(cooling_dev);
+	}
+
+	thermal_cooling_device_unregister(cooling_dev->cdev);
+	cooling_dev->state = 0;
+
+	mutex_unlock(&idle_cooling_lock);
+}
+
+static int cpuidle_cooling_cpu_online(unsigned int cpu)
+{
+	cpuidle_cooling_register(cpu);
+
+	return 0;
+}
+
+static int cpuidle_cooling_cpu_offline(unsigned int cpu)
+{
+	cpuidle_cooling_unregister(cpu);
+
+	return 0;
+}
+
+static enum cpuhp_state cpuidle_cooling_hp_state __read_mostly;
+
+static const struct x86_cpu_id intel_cpuidle_cooling_ids[] __initconst = {
+	X86_MATCH_VENDOR_FEATURE(INTEL, X86_FEATURE_MWAIT, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, intel_cpuidle_cooling_ids);
+
+static int __init cpuidle_cooling_init(void)
+{
+	int ret;
+
+	if (!x86_match_cpu(intel_cpuidle_cooling_ids))
+		return -ENODEV;
+
+	ret = cpuhp_setup_state(CPUHP_AP_ONLINE_DYN,
+				"thermal/cpuidle_cooling:online",
+				cpuidle_cooling_cpu_online,
+				cpuidle_cooling_cpu_offline);
+	if (ret < 0)
+		return ret;
+
+	cpuidle_cooling_hp_state = ret;
+
+	return 0;
+}
+module_init(cpuidle_cooling_init)
+
+static void __exit cpuidle_cooling_exit(void)
+{
+	cpuhp_remove_state(cpuidle_cooling_hp_state);
+}
+module_exit(cpuidle_cooling_exit)
+
+MODULE_IMPORT_NS(IDLE_INJECT);
+
+MODULE_LICENSE("GPL");
-- 
2.37.3

