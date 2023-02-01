Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA702686E10
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBASft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:35:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjBASfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:35:43 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AAA8000E;
        Wed,  1 Feb 2023 10:35:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675276528; x=1706812528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=302NRxZAOpbn/8HYfc4howSfrEAdiHoj5bbgEuEBL7s=;
  b=OeKlFQqJe51c2tvf0+7N/u9ri9THEB1JNim0a4mywpIppXwCc0t+xr0G
   K99nQGwHfsoU7mnbZmctvdDmelOZ3vm3l5ifEtYU6aJY0xiyy/aS13z4W
   4E73q5wCepfaOVQzC6H59xJO5Rwm9FjQrI3Jw3MkRAW9h2bQ4EacsPvD5
   jS++6zP4mKbkBguX9zck0JeTFZJYVPaNwguE/xCXDvl4P+AV1i5IuHEcw
   lIzZpS4LQOQbuMpgC9I9EGjDBivoB8Qa1yXNcdLzhg5WIW2KjllH0dZ1Q
   Ym+DKEG1xSyU/eXmjzPSi8Qr5+YCWkIAkrbg2B202u/vpk12KZ8vdQJyo
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="414440444"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="414440444"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2023 10:28:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10608"; a="667014263"
X-IronPort-AV: E=Sophos;i="5.97,265,1669104000"; 
   d="scan'208";a="667014263"
Received: from spandruv-desk.jf.intel.com ([10.54.75.8])
  by fmsmga007.fm.intel.com with ESMTP; 01 Feb 2023 10:28:56 -0800
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v5 3/4] thermal/drivers/intel_powerclamp: Use powercap idle-inject framework
Date:   Wed,  1 Feb 2023 10:28:53 -0800
Message-Id: <20230201182854.2158535-4-srinivas.pandruvada@linux.intel.com>
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

There are two idle injection implementation in the Linux kernel. One
via intel_powerclamp and the other using powercap/idle_inject. Both
implementation end up in calling play_idle* function from a FIFO
priority thread. Both can't be used at the same time.

It is better to use one idle injection framework for better
maintainability. In this way, there is only one caller for play_idle.

Here powercap/idle_inject can be used for both per-core and for system
wide idle injection. This framework has a well defined interface which
allow registry for per-core or for all CPUs (system wide).

This reduces code complexity in the intel powerclamp driver as all the
per CPU kthreads, delayed work and calls to play_idle can be removed.

The changes include:
- Remove unneeded include files
- Remove per CPU kthread workers: balancing_work and idle_injection_work.
- Reuse the compensation related code by moving from previous worker
thread to idle_injection callback.
- Adjust the idle_duration and runtime by using powercap/idle_inject
interface.
- Remove all variables, which are not required once powercap/idle_inject
is used.
- Add mutex to avoid race during removal of idle injection during module
unload and user action to change idle inject percent. Also for
protection during dynamic adjustment of run and idle time from
update() callback.
- Remove online/offline callbacks to designate control CPU
- Use cpu_present_mask global variable for CPU mask
- Remove hot plug locks

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v5:
- Can no longer sleep in update() callbak which is a hr timer callback
So skip if mutex will result in sleep.

v4:
- Remove local cpumask for present CPUs as there is one global one
also no need for hot plug locks as it can't change
- Add some comments on functions

v3:
- Use Update callback which is per device
- Remove use of control_cpu and online/offline callback to set this

v2:
- Use idle_inject_register_full instead of idle_inject_register
- Also fix dependency issue with POWERCAP config
Reported-by: kernel test robot <lkp@intel.com>

 drivers/thermal/intel/Kconfig            |   2 +
 drivers/thermal/intel/intel_powerclamp.c | 379 ++++++++++-------------
 2 files changed, 158 insertions(+), 223 deletions(-)

diff --git a/drivers/thermal/intel/Kconfig b/drivers/thermal/intel/Kconfig
index e50fd260484a..b346a646fffb 100644
--- a/drivers/thermal/intel/Kconfig
+++ b/drivers/thermal/intel/Kconfig
@@ -3,6 +3,8 @@ config INTEL_POWERCLAMP
 	tristate "Intel PowerClamp idle injection driver"
 	depends on X86
 	depends on CPU_SUP_INTEL
+	select POWERCAP
+	select IDLE_INJECT
 	help
 	  Enable this to enable Intel PowerClamp idle injection driver. This
 	  enforce idle time which results in more package C-state residency. The
diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index 64f082c584b2..850195ebe5e0 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -2,7 +2,7 @@
 /*
  * intel_powerclamp.c - package c-state idle injection
  *
- * Copyright (c) 2012, Intel Corporation.
+ * Copyright (c) 2012-2023, Intel Corporation.
  *
  * Authors:
  *     Arjan van de Ven <arjan@linux.intel.com>
@@ -27,21 +27,15 @@
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/delay.h>
-#include <linux/kthread.h>
 #include <linux/cpu.h>
 #include <linux/thermal.h>
-#include <linux/slab.h>
-#include <linux/tick.h>
 #include <linux/debugfs.h>
 #include <linux/seq_file.h>
-#include <linux/sched/rt.h>
-#include <uapi/linux/sched/types.h>
+#include <linux/idle_inject.h>
 
-#include <asm/nmi.h>
 #include <asm/msr.h>
 #include <asm/mwait.h>
 #include <asm/cpu_device_id.h>
-#include <asm/hardirq.h>
 
 #define MAX_TARGET_RATIO (50U)
 /* For each undisturbed clamping period (no extra wake ups during idle time),
@@ -59,35 +53,26 @@ static unsigned int target_mwait;
 static struct dentry *debug_dir;
 static bool poll_pkg_cstate_enable;
 
-/* user selected target */
-static unsigned int set_target_ratio;
+/* Idle ratio observed using package C-state counters */
 static unsigned int current_ratio;
-static bool should_skip;
 
-static unsigned int control_cpu; /* The cpu assigned to collect stat and update
-				  * control parameters. default to BSP but BSP
-				  * can be offlined.
-				  */
-static bool clamping;
+/* Skip the idle injection till set to true */
+static bool should_skip;
 
-struct powerclamp_worker_data {
-	struct kthread_worker *worker;
-	struct kthread_work balancing_work;
-	struct kthread_delayed_work idle_injection_work;
+struct powerclamp_data {
 	unsigned int cpu;
 	unsigned int count;
 	unsigned int guard;
 	unsigned int window_size_now;
 	unsigned int target_ratio;
-	unsigned int duration_jiffies;
 	bool clamping;
 };
 
-static struct powerclamp_worker_data __percpu *worker_data;
+static struct powerclamp_data powerclamp_data;
+
 static struct thermal_cooling_device *cooling_dev;
-static unsigned long *cpu_clamping_mask;  /* bit map for tracking per cpu
-					   * clamping kthread worker
-					   */
+
+static DEFINE_MUTEX(powerclamp_lock);
 
 static unsigned int duration;
 static unsigned int pkg_cstate_ratio_cur;
@@ -306,7 +291,7 @@ static void adjust_compensation(int target_ratio, unsigned int win)
 	if (d->confidence >= CONFIDENCE_OK)
 		return;
 
-	delta = set_target_ratio - current_ratio;
+	delta = powerclamp_data.target_ratio - current_ratio;
 	/* filter out bad data */
 	if (delta >= 0 && delta <= (1+target_ratio/10)) {
 		if (d->steady_comp)
@@ -345,82 +330,39 @@ static bool powerclamp_adjust_controls(unsigned int target_ratio,
 	adjust_compensation(target_ratio, win);
 
 	/* if we are above target+guard, skip */
-	return set_target_ratio + guard <= current_ratio;
+	return powerclamp_data.target_ratio + guard <= current_ratio;
 }
 
-static void clamp_balancing_func(struct kthread_work *work)
+/*
+ * This function calculates runtime from the current target ratio.
+ * This function gets called under powerclamp_lock.
+ */
+static unsigned int get_run_time(void)
 {
-	struct powerclamp_worker_data *w_data;
-	int sleeptime;
-	unsigned long target_jiffies;
 	unsigned int compensated_ratio;
-	int interval; /* jiffies to sleep for each attempt */
-
-	w_data = container_of(work, struct powerclamp_worker_data,
-			      balancing_work);
+	unsigned int runtime;
 
 	/*
 	 * make sure user selected ratio does not take effect until
 	 * the next round. adjust target_ratio if user has changed
 	 * target such that we can converge quickly.
 	 */
-	w_data->target_ratio = READ_ONCE(set_target_ratio);
-	w_data->guard = 1 + w_data->target_ratio / 20;
-	w_data->window_size_now = window_size;
-	w_data->duration_jiffies = msecs_to_jiffies(duration);
-	w_data->count++;
+	powerclamp_data.guard = 1 + powerclamp_data.target_ratio / 20;
+	powerclamp_data.window_size_now = window_size;
 
 	/*
 	 * systems may have different ability to enter package level
 	 * c-states, thus we need to compensate the injected idle ratio
 	 * to achieve the actual target reported by the HW.
 	 */
-	compensated_ratio = w_data->target_ratio +
-		get_compensation(w_data->target_ratio);
+	compensated_ratio = powerclamp_data.target_ratio +
+		get_compensation(powerclamp_data.target_ratio);
 	if (compensated_ratio <= 0)
 		compensated_ratio = 1;
-	interval = w_data->duration_jiffies * 100 / compensated_ratio;
-
-	/* align idle time */
-	target_jiffies = roundup(jiffies, interval);
-	sleeptime = target_jiffies - jiffies;
-	if (sleeptime <= 0)
-		sleeptime = 1;
-
-	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
-		kthread_queue_delayed_work(w_data->worker,
-					   &w_data->idle_injection_work,
-					   sleeptime);
-}
 
-static void clamp_idle_injection_func(struct kthread_work *work)
-{
-	struct powerclamp_worker_data *w_data;
+	runtime = duration * 100 / compensated_ratio - duration;
 
-	w_data = container_of(work, struct powerclamp_worker_data,
-			      idle_injection_work.work);
-
-	/*
-	 * only elected controlling cpu can collect stats and update
-	 * control parameters.
-	 */
-	if (w_data->cpu == control_cpu &&
-	    !(w_data->count % w_data->window_size_now)) {
-		should_skip =
-			powerclamp_adjust_controls(w_data->target_ratio,
-						   w_data->guard,
-						   w_data->window_size_now);
-		smp_mb();
-	}
-
-	if (should_skip)
-		goto balance;
-
-	play_idle(jiffies_to_usecs(w_data->duration_jiffies));
-
-balance:
-	if (clamping && w_data->clamping && cpu_online(w_data->cpu))
-		kthread_queue_work(w_data->worker, &w_data->balancing_work);
+	return runtime;
 }
 
 /*
@@ -456,127 +398,135 @@ static void poll_pkg_cstate(struct work_struct *dummy)
 	msr_last = msr_now;
 	tsc_last = tsc_now;
 
-	if (true == clamping)
+	mutex_lock(&powerclamp_lock);
+	if (powerclamp_data.clamping)
 		schedule_delayed_work(&poll_pkg_cstate_work, HZ);
+	mutex_unlock(&powerclamp_lock);
 }
 
-static void start_power_clamp_worker(unsigned long cpu)
-{
-	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
-	struct kthread_worker *worker;
-
-	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inj/%ld", cpu);
-	if (IS_ERR(worker))
-		return;
-
-	w_data->worker = worker;
-	w_data->count = 0;
-	w_data->cpu = cpu;
-	w_data->clamping = true;
-	set_bit(cpu, cpu_clamping_mask);
-	sched_set_fifo(worker->task);
-	kthread_init_work(&w_data->balancing_work, clamp_balancing_func);
-	kthread_init_delayed_work(&w_data->idle_injection_work,
-				  clamp_idle_injection_func);
-	kthread_queue_work(w_data->worker, &w_data->balancing_work);
-}
+static struct idle_inject_device *ii_dev;
 
-static void stop_power_clamp_worker(unsigned long cpu)
+/*
+ * This function is called from idle injection core on timer expiry
+ * for the run duration. This allows powerclamp to readjust or skip
+ * injecting idle for this cycle.
+ */
+static bool idle_inject_update(void)
 {
-	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
+	bool update;
 
-	if (!w_data->worker)
-		return;
+	/* We can't sleep in this callback */
+	if (!mutex_trylock(&powerclamp_lock))
+		return true;
 
-	w_data->clamping = false;
-	/*
-	 * Make sure that all works that get queued after this point see
-	 * the clamping disabled. The counter part is not needed because
-	 * there is an implicit memory barrier when the queued work
-	 * is proceed.
-	 */
-	smp_wmb();
-	kthread_cancel_work_sync(&w_data->balancing_work);
-	kthread_cancel_delayed_work_sync(&w_data->idle_injection_work);
-	/*
-	 * The balancing work still might be queued here because
-	 * the handling of the "clapming" variable, cancel, and queue
-	 * operations are not synchronized via a lock. But it is not
-	 * a big deal. The balancing work is fast and destroy kthread
-	 * will wait for it.
-	 */
-	clear_bit(w_data->cpu, cpu_clamping_mask);
-	kthread_destroy_worker(w_data->worker);
+	if (!(powerclamp_data.count % powerclamp_data.window_size_now)) {
 
-	w_data->worker = NULL;
-}
+		should_skip = powerclamp_adjust_controls(powerclamp_data.target_ratio,
+							 powerclamp_data.guard,
+							 powerclamp_data.window_size_now);
+		update = true;
+	}
 
-static int start_power_clamp(void)
-{
-	unsigned long cpu;
+	if (update) {
+		unsigned int runtime = get_run_time();
 
-	set_target_ratio = clamp(set_target_ratio, 0U, MAX_TARGET_RATIO - 1);
-	/* prevent cpu hotplug */
-	cpus_read_lock();
+		idle_inject_set_duration(ii_dev, runtime, duration);
+	}
 
-	/* prefer BSP */
-	control_cpu = cpumask_first(cpu_online_mask);
+	powerclamp_data.count++;
 
-	clamping = true;
-	if (poll_pkg_cstate_enable)
-		schedule_delayed_work(&poll_pkg_cstate_work, 0);
+	mutex_unlock(&powerclamp_lock);
 
-	/* start one kthread worker per online cpu */
-	for_each_online_cpu(cpu) {
-		start_power_clamp_worker(cpu);
-	}
-	cpus_read_unlock();
+	if (should_skip)
+		return false;
 
-	return 0;
+	return true;
 }
 
-static void end_power_clamp(void)
+/* This function starts idle injection by calling idle_inject_start() */
+static void trigger_idle_injection(void)
 {
-	int i;
+	unsigned int runtime = get_run_time();
 
+	idle_inject_set_duration(ii_dev, runtime, duration);
+	idle_inject_start(ii_dev);
+	powerclamp_data.clamping = true;
+}
+
+/*
+ * This function is called from start_power_clamp() to register
+ * CPUS with powercap idle injection register and set default
+ * idle duration and latency.
+ */
+static int powerclamp_idle_injection_register(void)
+{
 	/*
-	 * Block requeuing in all the kthread workers. They will flush and
-	 * stop faster.
+	 * The idle inject core will only inject for online CPUs,
+	 * So we can register for all present CPUs. In this way
+	 * if some CPU goes online/offline while idle inject
+	 * is registered, nothing additional calls are required.
+	 * The same runtime and idle time is applicable for
+	 * newly onlined CPUs if any.
+	 *
+	 * Here cpu_present_mask can be used as is.
+	 * cast to (struct cpumask *) is required as the
+	 * cpu_present_mask is const struct cpumask *, otherwise
+	 * there will be compiler warnings.
 	 */
-	clamping = false;
-	for_each_set_bit(i, cpu_clamping_mask, num_possible_cpus()) {
-		pr_debug("clamping worker for cpu %d alive, destroy\n", i);
-		stop_power_clamp_worker(i);
+	ii_dev = idle_inject_register_full((struct cpumask *)cpu_present_mask,
+					   idle_inject_update);
+	if (!ii_dev) {
+		pr_err("powerclamp: idle_inject_register failed\n");
+		return -EAGAIN;
 	}
+
+	idle_inject_set_duration(ii_dev, TICK_USEC, duration);
+	idle_inject_set_latency(ii_dev, UINT_MAX);
+
+	return 0;
 }
 
-static int powerclamp_cpu_online(unsigned int cpu)
+/*
+ * This function is called from end_power_clamp() to stop idle injection
+ * and unregister CPUS from powercap idle injection core.
+ */
+static void remove_idle_injection(void)
 {
-	if (clamping == false)
-		return 0;
-	start_power_clamp_worker(cpu);
-	/* prefer BSP as controlling CPU */
-	if (cpu == 0) {
-		control_cpu = 0;
-		smp_mb();
-	}
-	return 0;
+	if (!powerclamp_data.clamping)
+		return;
+
+	powerclamp_data.clamping = false;
+	idle_inject_stop(ii_dev);
 }
 
-static int powerclamp_cpu_predown(unsigned int cpu)
+/*
+ * This function is called when user change the cooling device
+ * state from zero to some other value.
+ */
+static int start_power_clamp(void)
 {
-	if (clamping == false)
-		return 0;
+	int ret;
 
-	stop_power_clamp_worker(cpu);
-	if (cpu != control_cpu)
-		return 0;
+	ret = powerclamp_idle_injection_register();
+	if (!ret) {
+		trigger_idle_injection();
+		if (poll_pkg_cstate_enable)
+			schedule_delayed_work(&poll_pkg_cstate_work, 0);
+	}
 
-	control_cpu = cpumask_first(cpu_online_mask);
-	if (control_cpu == cpu)
-		control_cpu = cpumask_next(cpu, cpu_online_mask);
-	smp_mb();
-	return 0;
+	return ret;
+}
+
+/*
+ * This function is called when user change the cooling device
+ * state from non zero value zero.
+ */
+static void end_power_clamp(void)
+{
+	if (powerclamp_data.clamping) {
+		remove_idle_injection();
+		idle_inject_unregister(ii_dev);
+	}
 }
 
 static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
@@ -590,16 +540,20 @@ static int powerclamp_get_max_state(struct thermal_cooling_device *cdev,
 static int powerclamp_get_cur_state(struct thermal_cooling_device *cdev,
 				 unsigned long *state)
 {
-	if (true == clamping) {
+	mutex_lock(&powerclamp_lock);
+
+	if (powerclamp_data.clamping) {
 		if (poll_pkg_cstate_enable)
 			*state = pkg_cstate_ratio_cur;
 		else
-			*state = set_target_ratio;
+			*state = powerclamp_data.target_ratio;
 	} else {
 		/* to save power, do not poll idle ratio while not clamping */
 		*state = -1; /* indicates invalid state */
 	}
 
+	mutex_unlock(&powerclamp_lock);
+
 	return 0;
 }
 
@@ -608,24 +562,32 @@ static int powerclamp_set_cur_state(struct thermal_cooling_device *cdev,
 {
 	int ret = 0;
 
+	mutex_lock(&powerclamp_lock);
+
 	new_target_ratio = clamp(new_target_ratio, 0UL,
-				(unsigned long) (MAX_TARGET_RATIO-1));
-	if (set_target_ratio == 0 && new_target_ratio > 0) {
+				(unsigned long) (MAX_TARGET_RATIO - 1));
+	if (!powerclamp_data.target_ratio && new_target_ratio > 0) {
 		pr_info("Start idle injection to reduce power\n");
-		set_target_ratio = new_target_ratio;
+		powerclamp_data.target_ratio = new_target_ratio;
 		ret = start_power_clamp();
+		if (ret)
+			powerclamp_data.target_ratio = 0;
 		goto exit_set;
-	} else	if (set_target_ratio > 0 && new_target_ratio == 0) {
+	} else	if (powerclamp_data.target_ratio > 0 && new_target_ratio == 0) {
 		pr_info("Stop forced idle injection\n");
 		end_power_clamp();
-		set_target_ratio = 0;
+		powerclamp_data.target_ratio = 0;
 	} else	/* adjust currently running */ {
-		set_target_ratio = new_target_ratio;
-		/* make new set_target_ratio visible to other cpus */
-		smp_mb();
+		unsigned int runtime;
+
+		powerclamp_data.target_ratio = new_target_ratio;
+		runtime = get_run_time();
+		idle_inject_set_duration(ii_dev, runtime, duration);
 	}
 
 exit_set:
+	mutex_unlock(&powerclamp_lock);
+
 	return ret;
 }
 
@@ -666,7 +628,6 @@ static int powerclamp_debug_show(struct seq_file *m, void *unused)
 {
 	int i = 0;
 
-	seq_printf(m, "controlling cpu: %d\n", control_cpu);
 	seq_printf(m, "pct confidence steady dynamic (compensation)\n");
 	for (i = 0; i < MAX_TARGET_RATIO; i++) {
 		seq_printf(m, "%d\t%lu\t%lu\t%lu\n",
@@ -689,78 +650,50 @@ static inline void powerclamp_create_debug_files(void)
 			    &powerclamp_debug_fops);
 }
 
-static enum cpuhp_state hp_state;
-
 static int __init powerclamp_init(void)
 {
 	int retval;
 
-	cpu_clamping_mask = bitmap_zalloc(num_possible_cpus(), GFP_KERNEL);
-	if (!cpu_clamping_mask)
-		return -ENOMEM;
-
 	/* probe cpu features and ids here */
 	retval = powerclamp_probe();
 	if (retval)
-		goto exit_free;
+		return retval;
 
 	/* set default limit, maybe adjusted during runtime based on feedback */
 	window_size = 2;
-	retval = cpuhp_setup_state_nocalls(CPUHP_AP_ONLINE_DYN,
-					   "thermal/intel_powerclamp:online",
-					   powerclamp_cpu_online,
-					   powerclamp_cpu_predown);
-	if (retval < 0)
-		goto exit_free;
-
-	hp_state = retval;
-
-	worker_data = alloc_percpu(struct powerclamp_worker_data);
-	if (!worker_data) {
-		retval = -ENOMEM;
-		goto exit_unregister;
-	}
 
 	if (topology_max_packages() == 1 && topology_max_die_per_package() == 1)
 		poll_pkg_cstate_enable = true;
 
 	cooling_dev = thermal_cooling_device_register("intel_powerclamp", NULL,
-						&powerclamp_cooling_ops);
-	if (IS_ERR(cooling_dev)) {
-		retval = -ENODEV;
-		goto exit_free_thread;
-	}
+						      &powerclamp_cooling_ops);
+	if (IS_ERR(cooling_dev))
+		return -ENODEV;
 
 	if (!duration)
-		duration = jiffies_to_msecs(DEFAULT_DURATION_JIFFIES);
+		duration = jiffies_to_usecs(DEFAULT_DURATION_JIFFIES);
 
 	powerclamp_create_debug_files();
 
 	return 0;
-
-exit_free_thread:
-	free_percpu(worker_data);
-exit_unregister:
-	cpuhp_remove_state_nocalls(hp_state);
-exit_free:
-	bitmap_free(cpu_clamping_mask);
-	return retval;
 }
 module_init(powerclamp_init);
 
 static void __exit powerclamp_exit(void)
 {
+	mutex_lock(&powerclamp_lock);
 	end_power_clamp();
-	cpuhp_remove_state_nocalls(hp_state);
-	free_percpu(worker_data);
+	mutex_unlock(&powerclamp_lock);
+
 	thermal_cooling_device_unregister(cooling_dev);
-	bitmap_free(cpu_clamping_mask);
 
 	cancel_delayed_work_sync(&poll_pkg_cstate_work);
 	debugfs_remove_recursive(debug_dir);
 }
 module_exit(powerclamp_exit);
 
+MODULE_IMPORT_NS(IDLE_INJECT);
+
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Arjan van de Ven <arjan@linux.intel.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
-- 
2.39.1

