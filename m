Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E363467EF7F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 21:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbjA0UYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 15:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbjA0UYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 15:24:01 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D1C6A67;
        Fri, 27 Jan 2023 12:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674851040; x=1706387040;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=UdsiALeU4rr0v+aNNFHWoK4uGHxdzHfOzR8c4y++rjk=;
  b=KV3ICMY7TJhyL0BAawcBTNf9FdgqyLdm0YcvQfFG9In8t8KvtCfura1t
   vN5+/X2LHdFnW6pPqsW6Nh0NwDnqFs7OLEZMlFftrlKiiMTbcswJdD/oz
   TxmJMj+FvZjy/zZL1wq8Vj3KIYwO/6Z4GSCQ2O5iMCB/bTxJKo3gkwApB
   m754GEPZjkunFUdydKyC7dHHqMLj+8xZFPCT1F8B1qmn67WJHsk9+Pw7k
   LLXS/292lCLO71DdNH+XLu9OJYF7o3wOV4BIBZKiVat9qvxNXG27+iCql
   cjh3L0Jp+dfh8eyts+eVRITSQFtPK+n+j0hUHLNTz/rHasGZ7Pmmn1D6T
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="354484490"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="354484490"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2023 12:24:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10603"; a="640816925"
X-IronPort-AV: E=Sophos;i="5.97,252,1669104000"; 
   d="scan'208";a="640816925"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by orsmga006.jf.intel.com with ESMTP; 27 Jan 2023 12:23:58 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [RFC PATCH] thermal/drivers/intel_powerclamp: Support cpumask and step_size
Date:   Fri, 27 Jan 2023 12:23:58 -0800
Message-Id: <20230127202358.992651-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some use cases, it is desirable to only inject idle on certain set
of CPUs. For example on Alder Lake systems, it is possible that we force
idle only on P-Cores for thermal reasons. Also the idle percent can be
more than 50% if we only choose partial set of CPUs in the system.

Introduce module parameters for setting cpumask and step_size. They
can be only changed when the cooling device is inactive. This module
already have other module parameters. There is no change done for
those parameters.

cpumask (Read/Write): A bit mask of CPUs to inject idle. The format of
this bitmask is same as used in other subsystems like in
/proc/irq/*/smp_affinity. The mask is comma separated 32 bit groups.
Each CPU is one bit. For example for 256 CPU system the full mask is:
ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
The leftmost mask is for CPU 0-32.

step_size (Read/Write): Step size specifies a multiplication factor to
the cooling device state. The step size can be either 1 or 2. By default,
step_size = 1. When the step size = 1, the max idle percent is 50%.
When step size = 2, the max idle percent is 100%. For the step size of 2,
the cpumask should be smaller than the full system cpumask. In this way
the system wide idle injection is restricted to 50%.

Since the max state for thermal cooling can't be changed with some
thermal core changes, step_size is a way to allow more than 50% idle
percent.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 .../driver-api/thermal/intel_powerclamp.rst   |  22 +++
 drivers/thermal/intel/intel_powerclamp.c      | 166 ++++++++++++++++--
 2 files changed, 170 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/thermal/intel_powerclamp.rst b/Documentation/driver-api/thermal/intel_powerclamp.rst
index 3f6dfb0b3ea6..582e3e42750b 100644
--- a/Documentation/driver-api/thermal/intel_powerclamp.rst
+++ b/Documentation/driver-api/thermal/intel_powerclamp.rst
@@ -26,6 +26,8 @@ By:
 	    - Generic Thermal Layer (sysfs)
 	    - Kernel APIs (TBD)
 
+	(*) Module Parameters
+
 INTRODUCTION
 ============
 
@@ -318,3 +320,23 @@ device, a PID based userspace thermal controller can manage to
 control CPU temperature effectively, when no other thermal influence
 is added. For example, a UltraBook user can compile the kernel under
 certain temperature (below most active trip points).
+
+Module Parameters
+=================
+
+``cpumask`` (RW)
+	A bit mask of CPUs to inject idle. The format of the bitmask is same as
+	used in other subsystems like in /proc/irq/*/smp_affinity. The mask is
+	comma separated 32 bit groups. Each CPU is one bit. For example for a 256
+	CPU system the full mask is:
+	ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
+
+	The leftmost mask is for CPU 0-32.
+
+``step_size`` (RW)
+	Step size specifies a multiplication factor to the cooling device state.
+	The step size can be either 1 or 2. By default,
+	step_size = 1. When the step size = 1, the max idle percent is 50%.
+	When step size = 2, the max idle percent is 100%. For the step size of 2,
+	the cpumask should be smaller than the full system cpumask. In this way
+	the system wide idle injection is restricted to 50%.
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 320525c3c530..221c6de3e06f 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -108,6 +108,119 @@ static const struct kernel_param_ops duration_ops = {
 module_param_cb(duration, &duration_ops, &duration, 0644);
 MODULE_PARM_DESC(duration, "forced idle time for each attempt in msec.");
 
+static u8 step_size = 1;
+static cpumask_var_t idle_injection_cpu_mask;
+
+static int cpumask_set(const char *arg, const struct kernel_param *kp)
+{
+	int ret;
+
+	mutex_lock(&powerclamp_lock);
+
+	/* Can't set mask when cooling device is in use */
+	if (powerclamp_data.clamping) {
+		ret = -EAGAIN;
+		goto skip_cpumask_set;
+	}
+
+	if (!idle_injection_cpu_mask) {
+		if (!zalloc_cpumask_var(&idle_injection_cpu_mask, GFP_KERNEL)) {
+			ret = -ENOMEM;
+			goto skip_cpumask_set;
+		}
+	}
+
+	ret = bitmap_parse(arg, strlen(arg), cpumask_bits(idle_injection_cpu_mask),
+			   nr_cpumask_bits);
+	if (ret)
+		goto free_cpu_mask;
+
+	if (cpumask_empty(idle_injection_cpu_mask)) {
+		ret = -EINVAL;
+		goto free_cpu_mask;
+	}
+
+	if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask) &&
+			  step_size > 1) {
+		ret = -EINVAL;
+		goto free_cpu_mask;
+	}
+
+	mutex_unlock(&powerclamp_lock);
+
+	return 0;
+
+free_cpu_mask:
+	free_cpumask_var(idle_injection_cpu_mask);
+	idle_injection_cpu_mask = NULL;
+
+skip_cpumask_set:
+	mutex_unlock(&powerclamp_lock);
+
+	return ret;
+}
+
+static int cpumask_get(char *buf, const struct kernel_param *kp)
+{
+	if (!idle_injection_cpu_mask)
+		return -EINVAL;
+
+	return bitmap_print_to_pagebuf(false, buf, cpumask_bits(idle_injection_cpu_mask),
+				       nr_cpumask_bits);
+}
+
+static const struct kernel_param_ops cpumask_ops = {
+	.set = cpumask_set,
+	.get = cpumask_get,
+};
+
+module_param_cb(cpumask, &cpumask_ops, NULL, 0644);
+MODULE_PARM_DESC(cpumask, "Mask of CPUs to use for idle injection.");
+
+static int step_size_set(const char *arg, const struct kernel_param *kp)
+{
+	u8 _step_size;
+	int ret = 0;
+
+	mutex_lock(&powerclamp_lock);
+
+	/* Can't set mask when cooling device is in use */
+	if (powerclamp_data.clamping) {
+		ret = -EAGAIN;
+		goto skip_limit_set;
+	}
+
+	ret = kstrtou8(arg, 10, &_step_size);
+	if (ret)
+		goto skip_limit_set;
+
+	if (_step_size > 2) {
+		ret = -EINVAL;
+		goto skip_limit_set;
+	}
+
+	if (idle_injection_cpu_mask && cpumask_equal(cpu_present_mask, idle_injection_cpu_mask) &&
+	    _step_size > 1) {
+		ret = -EINVAL;
+		goto skip_limit_set;
+	}
+
+	step_size = _step_size;
+
+skip_limit_set:
+	mutex_unlock(&powerclamp_lock);
+
+	return ret;
+}
+
+static const struct kernel_param_ops step_size_ops = {
+	.set = step_size_set,
+	.get = param_get_int,
+};
+
+module_param_cb(step_size, &step_size_ops, &step_size, 0644);
+MODULE_PARM_DESC(step_size, "Step size to increment for each cooling state. range 1-2");
+
 struct powerclamp_calibration_data {
 	unsigned long confidence;  /* used for calibration, basically a counter
 				    * gets incremented each time a clamping
@@ -246,6 +359,9 @@ static unsigned int get_compensation(int ratio)
 {
 	unsigned int comp = 0;
 
+	if (step_size > 1)
+		return 0;
+
 	/* we only use compensation if all adjacent ones are good */
 	if (ratio == 1 &&
 		cal_data[ratio].confidence >= CONFIDENCE_OK &&
@@ -338,6 +454,10 @@ static unsigned int get_run_time(void)
 	unsigned int compensated_ratio;
 	unsigned int runtime;
 
+	/* No compensation for non systemwide idle injection */
+	if (step_size > 1)
+		return (duration * 100 / powerclamp_data.target_ratio - duration);
+
 	/*
 	 * make sure user selected ratio does not take effect until
 	 * the next round. adjust target_ratio if user has changed
@@ -454,21 +574,26 @@ static void trigger_idle_injection(void)
  */
 static int powerclamp_idle_injection_register(void)
 {
-	/*
-	 * The idle inject core will only inject for online CPUs,
-	 * So we can register for all present CPUs. In this way
-	 * if some CPU goes online/offline while idle inject
-	 * is registered, nothing additional calls are required.
-	 * The same runtime and idle time is applicable for
-	 * newly onlined CPUs if any.
-	 *
-	 * Here cpu_present_mask can be used as is.
-	 * cast to (struct cpumask *) is required as the
-	 * cpu_present_mask is const struct cpumask *, otherwise
-	 * there will be compiler warnings.
-	 */
-	ii_dev = idle_inject_register_full((struct cpumask *)cpu_present_mask,
-					   idle_inject_update);
+	if (!idle_injection_cpu_mask) {
+		if (!zalloc_cpumask_var(&idle_injection_cpu_mask, GFP_KERNEL))
+			return -ENOMEM;
+
+		/*
+		 * The idle inject core will only inject for online CPUs,
+		 * So we can register for all present CPUs. In this way
+		 * if some CPU goes online/offline while idle inject
+		 * is registered, nothing additional calls are required.
+		 * The same runtime and idle time is applicable for
+		 * newly onlined CPUs if any.
+		 */
+		cpumask_copy(idle_injection_cpu_mask, cpu_present_mask);
+	}
+
+	if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask))
+		ii_dev = idle_inject_register_full(idle_injection_cpu_mask, idle_inject_update);
+	else
+		ii_dev = idle_inject_register(idle_injection_cpu_mask);
+
 	if (!ii_dev) {
 		pr_err("powerclamp: idle_inject_register failed\n");
 		return -EAGAIN;
@@ -504,7 +629,9 @@ static int start_power_clamp(void)
 	ret = powerclamp_idle_injection_register();
 	if (!ret) {
 		trigger_idle_injection();
-		schedule_delayed_work(&poll_pkg_cstate_work, 0);
+		/* No use of package residency counters when partial set is used */
+		if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask))
+			schedule_delayed_work(&poll_pkg_cstate_work, 0);
 	}
 
 	return ret;
@@ -558,7 +685,7 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 				(unsigned long) (MAX_TARGET_RATIO - 1));
 	if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
 		pr_info("Start idle injection to reduce power\n");
-		powerclamp_data.target_ratio = new_target_ratio;
+		powerclamp_data.target_ratio = new_target_ratio * step_size;
 		ret = start_power_clamp();
 		if (ret)
 			powerclamp_data.target_ratio = 0;
@@ -570,7 +697,7 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 	} else	/* adjust currently running */ {
 		unsigned int runtime;
 
-		powerclamp_data.target_ratio = new_target_ratio;
+		powerclamp_data.target_ratio = new_target_ratio * step_size;
 		runtime = get_run_time();
 		idle_inject_set_duration(ii_dev, runtime, duration);
 	}
@@ -676,6 +803,9 @@ static void __exit powerclamp_exit(void)
 
 	cancel_delayed_work_sync(&poll_pkg_cstate_work);
 	debugfs_remove_recursive(debug_dir);
+
+	if (idle_injection_cpu_mask)
+		free_cpumask_var(idle_injection_cpu_mask);
 }
 module_exit(powerclamp_exit);
 
-- 
2.37.2

