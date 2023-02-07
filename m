Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721DE68DF0B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:35:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbjBGRfk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:35:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjBGRfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:35:39 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39931EBFC;
        Tue,  7 Feb 2023 09:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675791338; x=1707327338;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CBDnXYMpefoM/KDHRnX5+6Pu5oD1c6FLkpV+Imh/0ZI=;
  b=ePA3eSDEpmB5VWKpA5eNV99qG0vSgdX9JzwGu+zoaw7hUXaUmpA1d7pR
   YyIzHAnQI9FXbuS+BCDD9wiOTcRP8daGSjBf5Z39giFeofAC8VubZuBGW
   gv/9kgNp3T596VdzO3G/0/F2sh7ZMnWJZ4a+QrutVABBcS/ilw809ZKPC
   XVszfWet6HbUKvy5T2CBpE3XfVy271UJ4syxi2IWAvf0GGbnBTtZi/VDr
   KESyFL0MlW+hQRlO0mpXO2JT5EhH0fan9W7jD9BQg+FjhOeajgkTQIqWp
   hih63AOfaSQGNBK1NuBs9gN+YkGZe4VeO4q4Hz82rc5dOXRskIuPDUVRH
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="328220331"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="328220331"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2023 09:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10614"; a="809606228"
X-IronPort-AV: E=Sophos;i="5.97,278,1669104000"; 
   d="scan'208";a="809606228"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga001.fm.intel.com with ESMTP; 07 Feb 2023 09:35:35 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org, rui.zhang@intel.com, daniel.lezcano@linaro.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [UPDATE][PATCH v3 2/2] thermal/drivers/intel_powerclamp: Add two module parameters
Date:   Tue,  7 Feb 2023 09:35:34 -0800
Message-Id: <20230207173534.4190275-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.39.1
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

Introduce 2 new module parameters for this purpose. They can be only
changed when the cooling device is inactive.

cpumask (Read/Write): A bit mask of CPUs to inject idle. The format of
this bitmask is same as used in other subsystems like in
/proc/irq/*/smp_affinity. The mask is comma separated 32 bit groups.
Each CPU is one bit. For example for 256 CPU system the full mask is:
ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff,ffffffff
The rightmost mask is for CPU 0-32.

max_idle (Read/Write): Maximum injected idle time to the total CPU time
ratio in percent range from 1 to 100. Even if the cooling device max_state
is always 100 (100%), this parameter allows to add a max idle percent
limit. The default is 50, to match the current implementation of powerclamp
driver. Also doesn't allow value more than 75, if the cpumask includes
every CPU present in the system.

Also when the cpumask doesn't include every CPU, there is no use of
compensation using package C-state idle counters. Hence don't start
package C-state polling thread even for a single package or a single die
system in this case.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v3 update:
change leftmost to rightmost in commit description

v3:
One word document change from leftmost to rightmost

v2:
Addressed comments from v5 series from Rafael
Build issue reported by Rui

 .../admin-guide/thermal/intel_powerclamp.rst  |  22 +++
 drivers/thermal/intel/intel_powerclamp.c      | 177 +++++++++++++++---
 2 files changed, 178 insertions(+), 21 deletions(-)

diff --git a/Documentation/admin-guide/thermal/intel_powerclamp.rst b/Documentation/admin-guide/thermal/intel_powerclamp.rst
index 3f6dfb0b3ea6..2d9d2d739f02 100644
--- a/Documentation/admin-guide/thermal/intel_powerclamp.rst
+++ b/Documentation/admin-guide/thermal/intel_powerclamp.rst
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
+	The rightmost mask is for CPU 0-32.
+
+``max_idle`` (RW)
+	Maximum injected idle time to the total CPU time ratio in percent range
+	from 1 to 100. Even if the cooling device max_state is always 100 (100%),
+	this parameter allows to add a max idle percent limit. The default is 50,
+	to match the current implementation of powerclamp driver. Also doesn't
+	allow value more than 75, if the cpumask includes every CPU present in
+	the system.
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 1390748706a6..6d00ac597b8a 100644
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
@@ -105,10 +105,144 @@ static const struct kernel_param_ops duration_ops = {
 	.get = param_get_int,
 };
 
-
 module_param_cb(duration, &duration_ops, &duration, 0644);
 MODULE_PARM_DESC(duration, "forced idle time for each attempt in msec.");
 
+#define DEFAULT_MAX_IDLE	50
+#define MAX_ALL_CPU_IDLE	75
+
+static u8 max_idle = DEFAULT_MAX_IDLE;
+
+static cpumask_var_t idle_injection_cpu_mask;
+
+static int allocate_copy_idle_injection_mask(const struct cpumask *copy_mask)
+{
+	if (cpumask_available(idle_injection_cpu_mask))
+		goto copy_mask;
+
+	/* This mask is allocated only one time and freed during module exit */
+	if (!alloc_cpumask_var(&idle_injection_cpu_mask, GFP_KERNEL))
+		return -ENOMEM;
+
+copy_mask:
+	cpumask_copy(idle_injection_cpu_mask, copy_mask);
+
+	return 0;
+}
+
+/* Return true if the cpumask and idle percent combination is invalid */
+static bool check_invalid(cpumask_var_t mask, u8 idle)
+{
+	if (cpumask_equal(cpu_present_mask, mask) && idle > MAX_ALL_CPU_IDLE)
+		return true;
+
+	return false;
+}
+
+static int cpumask_set(const char *arg, const struct kernel_param *kp)
+{
+	cpumask_var_t new_mask;
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
+	ret = alloc_cpumask_var(&new_mask, GFP_KERNEL);
+	if (!ret)
+		goto skip_cpumask_set;
+
+	ret = bitmap_parse(arg, strlen(arg), cpumask_bits(new_mask),
+			   nr_cpumask_bits);
+	if (ret)
+		goto free_cpumask_set;
+
+	if (cpumask_empty(new_mask) || check_invalid(new_mask, max_idle)) {
+		ret = -EINVAL;
+		goto free_cpumask_set;
+	}
+
+	/*
+	 * When module parameters are passed from kernel command line
+	 * during insmod, the module parameter callback is called
+	 * before powerclamp_init(), so we can't assume that some
+	 * cpumask can be allocated and copied before here. Also
+	 * in this case this cpumask is used as the default mask.
+	 */
+	ret = allocate_copy_idle_injection_mask(new_mask);
+
+free_cpumask_set:
+	free_cpumask_var(new_mask);
+skip_cpumask_set:
+	mutex_unlock(&powerclamp_lock);
+
+	return ret;
+}
+
+static int cpumask_get(char *buf, const struct kernel_param *kp)
+{
+	if (!cpumask_available(idle_injection_cpu_mask))
+		return -ENODEV;
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
+	u8 new_max_idle;
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
+	ret = kstrtou8(arg, 10, &new_max_idle);
+	if (ret)
+		goto skip_limit_set;
+
+	if (new_max_idle > MAX_TARGET_RATIO) {
+		ret = -EINVAL;
+		goto skip_limit_set;
+	}
+
+	if (check_invalid(idle_injection_cpu_mask, new_max_idle)) {
+		ret = -EINVAL;
+		goto skip_limit_set;
+	}
+
+	max_idle = new_max_idle;
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
@@ -460,21 +594,15 @@ static void trigger_idle_injection(void)
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
+	poll_pkg_cstate_enable = false;
+	if (cpumask_equal(cpu_present_mask, idle_injection_cpu_mask)) {
+		ii_dev = idle_inject_register_full(idle_injection_cpu_mask, idle_inject_update);
+		if (topology_max_packages() == 1 && topology_max_die_per_package() == 1)
+			poll_pkg_cstate_enable = true;
+	} else {
+		ii_dev = idle_inject_register(idle_injection_cpu_mask);
+	}
+
 	if (!ii_dev) {
 		pr_err("powerclamp: idle_inject_register failed\n");
 		return -EAGAIN;
@@ -555,7 +683,7 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 	mutex_lock(&powerclamp_lock);
 
 	new_target_ratio = clamp(new_target_ratio, 0UL,
-				(unsigned long) (MAX_TARGET_RATIO - 1));
+				(unsigned long) (max_idle - 1));
 	if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
 		pr_info("Start idle injection to reduce power\n");
 		powerclamp_data.target_ratio = new_target_ratio;
@@ -646,15 +774,19 @@ static int __init powerclamp_init(void)
 
 	/* probe cpu features and ids here */
 	retval = powerclamp_probe();
+	if (retval)
+		return retval;
+
+	mutex_lock(&powerclamp_lock);
+	retval = allocate_copy_idle_injection_mask(cpu_present_mask);
+	mutex_unlock(&powerclamp_lock);
+
 	if (retval)
 		return retval;
 
 	/* set default limit, maybe adjusted during runtime based on feedback */
 	window_size = 2;
 
-	if (topology_max_packages() == 1 && topology_max_die_per_package() == 1)
-		poll_pkg_cstate_enable = true;
-
 	cooling_dev = thermal_cooling_device_register("intel_powerclamp", NULL,
 						      &powerclamp_cooling_ops);
 	if (IS_ERR(cooling_dev))
@@ -679,6 +811,9 @@ static void __exit powerclamp_exit(void)
 
 	cancel_delayed_work_sync(&poll_pkg_cstate_work);
 	debugfs_remove_recursive(debug_dir);
+
+	if (cpumask_available(idle_injection_cpu_mask))
+		free_cpumask_var(idle_injection_cpu_mask);
 }
 module_exit(powerclamp_exit);
 
-- 
2.39.1

