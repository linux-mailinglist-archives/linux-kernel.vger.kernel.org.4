Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3D99686E12
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232020AbjBASgB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:36:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjBASf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:35:58 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9B27FA20;
        Wed,  1 Feb 2023 10:35:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276530; x=1706812530;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hzXaxXa/12m2UA384itaWVqGMRJpMjv07+6PASO6Ohg=;
  b=Ht6nJ6UeTQmc+P3rMiglUG3pOy+QOD5KHQq5J1jcKIfXe4HM8bHZ6Ofl
   INElsBwAOECzDffUyB9hrv9k/O78QV+xMQGtYaKPMIWMK6AFxBuyVyiFl
   f+cOf9VwXDwVks9N3kjjMPWY74vi8ui/l9hzzy5carxT0laDbBm6hvSMa
   +JFAwlU/6giWtfmsq8YzfuX7CyldrpREvSkgGwxnzgsiuA7BmSQa5JuIe
   sw8tMbZYRpQuAdbvK7CM7CsViELo0jyybNeqq5tWDhEJQgQcTWTx3gt8K
   eyGuBr/kxaMydlg2AUVUXq+rozOCCG7ZwEAXShJR5hVNcXpAg4A7rDtTY
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414440448"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="414440448"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667014267"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="667014267"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2023 10:28:57 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v5 4/4] thermal/drivers/intel_powerclamp: Add additional module params
Date:   Wed,  1 Feb 2023 10:28:54 -0800
Message-Id: <20230201182854.2158535-5-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
References: <20230201182854.2158535-1-srinivas.pandruvada@linux.intel.com>
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

In some use cases, it is desirable to only inject idle on certain set
of CPUs. For example on Alder Lake systems, it is possible that we force
idle only on P-Cores for thermal reasons. Also the idle percent can be
more than 50% if we only choose partial set of CPUs in the system.

Introduce module parameters for setting cpumask and max_idle. They
can be only changed when the cooling device is inactive. This module
already have other module parameters. There is no change done for
those parameters.

cpumask (Read/Write): A bit mask of CPUs to inject idle. The format of
this bitmask is same as used in other subsystems like in
/proc/irq/*/smp_affinity. The mask is comma separated 32 bit groups.
Each CPU is one bit. For example for 256 CPU system the full mask is:
ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
The leftmost mask is for CPU 0-32.

max_idle (Read/Write): Maximum injected idle time to the total CPU time
ratio in percent range from 1 to 100. Even if the cooling device max_state
is always 100 (100%), this parameter allows to add a max idle percent
limit. The default is 50, to match the current implementation of powerclamp
driver. Also doesn't allow value more than 75, if the cpumask includes
every CPU present in the system.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v5
New patch

 .../driver-api/thermal/intel_powerclamp.rst   |  22 +++
 drivers/thermal/intel/intel_powerclamp.c      | 169 ++++++++++++++++--
 2 files changed, 173 insertions(+), 18 deletions(-)

diff --git a/Documentation/driver-api/thermal/intel_powerclamp.rst b/Documentation/driver-api/thermal/intel_powerclamp.rst
index 3f6dfb0b3ea6..d805e28b7a45 100644
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
+``max_idle`` (RW)
+	Maximum injected idle time to the total CPU time ratio in percent range
+	from 1 to 100. Even if the cooling device max_state is always 100 (100%),
+	this parameter allows to add a max idle percent	limit. The default is 50,
+	to match the current implementation of powerclamp driver. Also doesn't
+	allow value more than 75, if the cpumask includes every CPU present in
+	the system.
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 850195ebe5e0..68830b726da2 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -37,7 +37,7 @@
 #include <asm/mwait.h>
 #include <asm/cpu_device_id.h>
 
-#define MAX_TARGET_RATIO (50U)
+#define MAX_TARGET_RATIO (100U)
 /* For each undisturbed clamping period (no extra wake ups during idle time),
  * we increment the confidence counter for the given target ratio.
  * CONFIDENCE_OK defines the level where runtime calibration results are
@@ -109,6 +109,135 @@ static const struct kernel_param_ops duration_ops = {
 module_param_cb(duration, &duration_ops, &duration, 0644);
 MODULE_PARM_DESC(duration, "forced idle time for each attempt in msec.");
 
+#define DEFAULT_MAX_IDLE	50
+#define MAX_ALL_CPU_IDLE	75
+
+static u8 max_idle = DEFAULT_MAX_IDLE;
+
+static cpumask_var_t idle_injection_cpu_mask;
+
+static int allocate_idle_injection_mask(void)
+{
+	/* This mask is allocated only one time and freed during module exit */
+	if (!idle_injection_cpu_mask) {
+		if (!zalloc_cpumask_var(&idle_injection_cpu_mask, GFP_KERNEL))
+			return -ENOMEM;
+
+		cpumask_copy(idle_injection_cpu_mask, cpu_present_mask);
+	}
+
+	return 0;
+}
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
+	/*
+	 * When module parameters are passed from kernel command line
+	 * during insmod, the module parameter callback is called
+	 * before powerclamp_init(), so we can't assume that some
+	 * cpumask can be allocated before here.
+	 */
+	ret = allocate_idle_injection_mask();
+	if (ret)
+		goto skip_cpumask_set;
+
+	ret = bitmap_parse(arg, strlen(arg), cpumask_bits(idle_injection_cpu_mask),
+			   nr_cpumask_bits);
+	if (ret)
+		goto skip_cpumask_set;
+
+	if (cpumask_empty(idle_injection_cpu_mask)) {
+		ret = -EINVAL;
+		goto skip_cpumask_set;
+	}
+
+	if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask) &&
+			  max_idle > MAX_ALL_CPU_IDLE) {
+		ret = -EINVAL;
+		goto skip_cpumask_set;
+	}
+
+	mutex_unlock(&powerclamp_lock);
+
+	return 0;
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
+static int max_idle_set(const char *arg, const struct kernel_param *kp)
+{
+	u8 _max_idle;
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
+	ret = kstrtou8(arg, 10, &_max_idle);
+	if (ret)
+		goto skip_limit_set;
+
+	if (_max_idle > MAX_TARGET_RATIO) {
+		ret = -EINVAL;
+		goto skip_limit_set;
+	}
+
+	if (idle_injection_cpu_mask && cpumask_equal(cpu_present_mask, idle_injection_cpu_mask) &&
+	    _max_idle > MAX_ALL_CPU_IDLE) {
+		ret = -EINVAL;
+		goto skip_limit_set;
+	}
+
+	max_idle = _max_idle;
+
+skip_limit_set:
+	mutex_unlock(&powerclamp_lock);
+
+	return ret;
+}
+
+static const struct kernel_param_ops max_idle_ops = {
+	.set = max_idle_set,
+	.get = param_get_int,
+};
+
+module_param_cb(max_idle, &max_idle_ops, &max_idle, 0644);
+MODULE_PARM_DESC(max_idle, "maximum injected idle time to the total CPU time ratio in percent range:1-100");
+
 struct powerclamp_calibration_data {
 	unsigned long confidence;  /* used for calibration, basically a counter
 				    * gets incremented each time a clamping
@@ -342,6 +471,10 @@ static unsigned int get_run_time(void)
 	unsigned int compensated_ratio;
 	unsigned int runtime;
 
+	/* No compensation for non systemwide idle injection */
+	if (max_idle > MAX_ALL_CPU_IDLE)
+		return (duration * 100 / powerclamp_data.target_ratio - duration);
+
 	/*
 	 * make sure user selected ratio does not take effect until
 	 * the next round. adjust target_ratio if user has changed
@@ -460,21 +593,11 @@ static void trigger_idle_injection(void)
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
+	if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask))
+		ii_dev = idle_inject_register_full(idle_injection_cpu_mask, idle_inject_update);
+	else
+		ii_dev = idle_inject_register(idle_injection_cpu_mask);
+
 	if (!ii_dev) {
 		pr_err("powerclamp: idle_inject_register failed\n");
 		return -EAGAIN;
@@ -510,7 +633,7 @@ static int start_power_clamp(void)
 	ret = powerclamp_idle_injection_register();
 	if (!ret) {
 		trigger_idle_injection();
-		if (poll_pkg_cstate_enable)
+		if (poll_pkg_cstate_enable && max_idle < MAX_ALL_CPU_IDLE)
 			schedule_delayed_work(&poll_pkg_cstate_work, 0);
 	}
 
@@ -565,7 +688,7 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 	mutex_lock(&powerclamp_lock);
 
 	new_target_ratio = clamp(new_target_ratio, 0UL,
-				(unsigned long) (MAX_TARGET_RATIO - 1));
+				(unsigned long) (max_idle - 1));
 	if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
 		pr_info("Start idle injection to reduce power\n");
 		powerclamp_data.target_ratio = new_target_ratio;
@@ -656,6 +779,13 @@ static int __init powerclamp_init(void)
 
 	/* probe cpu features and ids here */
 	retval = powerclamp_probe();
+	if (retval)
+		return retval;
+
+	mutex_lock(&powerclamp_lock);
+	retval = allocate_idle_injection_mask();
+	mutex_unlock(&powerclamp_lock);
+
 	if (retval)
 		return retval;
 
@@ -689,6 +819,9 @@ static void __exit powerclamp_exit(void)
 
 	cancel_delayed_work_sync(&poll_pkg_cstate_work);
 	debugfs_remove_recursive(debug_dir);
+
+	if (idle_injection_cpu_mask)
+		free_cpumask_var(idle_injection_cpu_mask);
 }
 module_exit(powerclamp_exit);
 
-- 
2.39.1

