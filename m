Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21DAE63CBF3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 00:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbiK2Xey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 18:34:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiK2Xei (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 18:34:38 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D3D4F020;
        Tue, 29 Nov 2022 15:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669764877; x=1701300877;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UB+AsI11L5AiZWNtd3SOlQlASLZ7XjEIFfhbV5ckI+E=;
  b=HuYim+0Qa99/TKxsuDUMKGp6YI+43Yfi0/3UZ0N4okpSye7zuJrYfaDW
   7xyyGTZTQBoFcroF10lbPzMkIBOs2PyPiZIyJk/r7OkVrRgnawfh13NGj
   E1b3zQN7Pjcg14KER4kmMaRZqezAMxrcqxkMQeBPFS7r533VuD6hMaZT1
   kY7tW7r4QSsZ6vu/GH6l/3LrpAiw+LrG1TNQc0OvauTsF9ag+nIkmvfRb
   OntBwKkLMVHerBU8d/PQ5LXpOvN9AGiLRNfiGYd6ZeBY6nOwCaY8a8kPc
   ZsDEE2cJB2kmcjBe1rNogSWCeGwtVMUVvgpFm0OVLDB/y8CZjs6qR2Ig9
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="342178175"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="342178175"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 15:34:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="768617611"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="768617611"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga004.jf.intel.com with ESMTP; 29 Nov 2022 15:34:35 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, amitk@kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2 4/4] thermal/drivers/intel_cpu_idle_cooling: Introduce Intel cpu idle cooling driver
Date:   Tue, 29 Nov 2022 15:34:19 -0800
Message-Id: <20221129233419.4022830-5-srinivas.pandruvada@linux.intel.com>
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
v2:
- Removed callback arguments for idle_inject_register

 drivers/thermal/intel/Kconfig                 |  10 +
 drivers/thermal/intel/Makefile                |   1 +
 .../thermal/intel/intel_cpu_idle_cooling.c    | 261 ++++++++++++++++++
 3 files changed, 272 insertions(+)
 create mode 100644 drivers/thermal/intel/intel_cpu_idle_cooling.c

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index 6c2a95f41c81..8c88d6e18414 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -115,3 +115,13 @@ config INTEL_HFI_THERMAL
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
index 000000000000..cdd62756cc3d
--- /dev/null
+++ b/drivers/thermal/intel/intel_cpu_idle_cooling.c
@@ -0,0 +1,261 @@
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
+	ii_dev = idle_inject_register((struct cpumask *)cpumask_of(cooling_dev->cpu));
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
2.31.1

