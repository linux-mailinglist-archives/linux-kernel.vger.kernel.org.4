Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31D676F97D7
	for <lists+linux-kernel@lfdr.de>; Sun,  7 May 2023 11:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjEGJHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 May 2023 05:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjEGJHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 May 2023 05:07:12 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0832137
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 02:07:10 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ABB463F22B
        for <linux-kernel@vger.kernel.org>; Sun,  7 May 2023 09:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1683450428;
        bh=5/2r8YQlDsy/JUAvnmk4D9UbIOl3EIi1J1nVeszSeDM=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=LgBLmT9Je4+1DrFVZpYvI4c5YnVTK5yJAba9Fewh7DPWdPycVPqvK946LIdwHELPb
         C7SY9Cbp3igx2krtcmOezWqKP8c7CBpISxgdSiXs4bQ8W2hurfLoC6o0OR0Zci05cN
         NKiLdpz2wTpXW6nQDRYLiU1QM2Wf+89Yjc6GgNgYi6UyoQ05ojtpEp9IZJQtC+ANcn
         1IterDxEnIRnzYSx3olFntl+jnGCrRUL+Z5aDOz1iPlfqXS2u3MT9CdZjs85dxubpX
         YAoq7SGiWDPbHNx9REbMpdnmhzDZT22V9alC3AfuDVQlhGx+MsEXb/aTZkaeJhjjAn
         4alDI+X9P5IfA==
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-50a0a814498so3061908a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 May 2023 02:07:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683450428; x=1686042428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5/2r8YQlDsy/JUAvnmk4D9UbIOl3EIi1J1nVeszSeDM=;
        b=l39eWVDU2jn1RiU1p8ULPcKQWpKh0qN6F4GwAYdVaL7Vxw2U/GgW1KcagAdbMesiny
         gbuMmg276jDbIoTxTFc6cu73zsFa2zlrErqYJjgp3XuKPFhENT/ydI/bQyp/WY9znecs
         Qn1xz3MfulxMH3N1RMfmHza71YvkN8PtN8LSPwC9UncdJ/3zz2Wy+jySupXY3FYFHGf7
         C9EDCz/Lp+WCvxOqFR4389+O2h1yaeoKeB60g+YCbFGd0fYTGV44kFitMtmBz++fiCb3
         W3GAKhJDUE5GoWdI0p5G1t5JYLImS/GXwID/ys+FeQvqIlosZMqp+BV6tMkIny0r5wEM
         DRuw==
X-Gm-Message-State: AC+VfDygs/plwRN/D9S53sdqyhH5fA82HkPlBq38b6LYl4p8rQd6VuZu
        h42UuAzuL51mfQlMSnsrsteyimziaXwFhCQtgqA429ZZRxjew71vgjva0pxRG4e4kQZDSfZvH16
        FprYx1rKsXndUVX3kk77bwvo7hlgVlp37x5JC7SvGRQ==
X-Received: by 2002:aa7:ca46:0:b0:50d:8991:d1b9 with SMTP id j6-20020aa7ca46000000b0050d8991d1b9mr3745979edt.8.1683450428196;
        Sun, 07 May 2023 02:07:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4BRutfYB8SEPwLh638B2h9sgrfx5/zpF4Ni/r3hjyYzV0WtG5lyqc69TSWG5nSOkmBf0xbyQ==
X-Received: by 2002:aa7:ca46:0:b0:50d:8991:d1b9 with SMTP id j6-20020aa7ca46000000b0050d8991d1b9mr3745963edt.8.1683450427847;
        Sun, 07 May 2023 02:07:07 -0700 (PDT)
Received: from localhost.localdomain (host-79-20-89-124.retail.telecomitalia.it. [79.20.89.124])
        by smtp.gmail.com with ESMTPSA id c26-20020a056402101a00b0050c524253dasm2784260edu.20.2023.05.07.02.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 May 2023 02:07:07 -0700 (PDT)
From:   Andrea Righi <andrea.righi@canonical.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Salvatore Bonaccorso <carnil@debian.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH] timers/nohz: introduce nohz_full_aggressive
Date:   Sun,  7 May 2023 11:07:00 +0200
Message-Id: <20230507090700.18470-1-andrea.righi@canonical.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overview:

nohz_full is a feature that allows to reduce the number of CPU tick
interrupts, thereby improving energy efficiency and reducing kernel
jitter.

This works by stopping the tick interrupts on the CPUs that are either
idle or that have only one runnable task on them (there is no reason to
periodically interrupt the execution of a single running task if none
else is waiting to acquire the same CPU).

It is not possible to configure all the available CPUs to work in the
nohz_full mode, at least one non-adaptive-tick CPU must be periodically
interrupted to properly handle timekeeping tasks in the system (such as
the gettimeofday() syscall returning accurate values).

However, under certain conditions, we may want to relax this constraint,
accepting potential time inaccuracies in the system, in order to provide
additional benefits in terms of power consumption, performance and/or
reduce kernel jitter even more.

For this reason introduce the new parameter nohz_full_aggressive.

This option allows to enforce nozh_full across all the CPUs (even the
timekeeping CPU) at the cost of having potential timer inaccuracies in
the system.

Test:

 - Hardware: Dell XPS 13 7390 w/ 8 cores

 - Kernel is using CONFIG_HZ=1000 (worst case scenario in terms of
   power consumption and kernel jitter) and nohz_full=all

 - Measure interrupts and power consumption when the system is idle and
   with 2, 4 and 8 cpu hogs

Result:

The following numbers have been collected using turbostat and dstat
measuring the average over a 5min run for each test.

irqs/sec             idle     1 CPU hog  2 CPU hogs  4 CPU hogs  8 CPU hogs
                     ------------------------------------------------------
nohz_full            1036.679  1047.522    1046.203    1048.590    1074.867
nohz_full_aggressive   98.685   106.296     127.587     146.586    1062.277

Power (Watt)         idle     1 CPU hog  2 CPU hogs  4 CPU hogs  8 CPU hogs
                     ------------------------------------------------------
nohz_full            0.502 W    3.436 W    3.755 W    6.187 W    6.019 W
nohz_full_aggressive 0.301 W    2.372 W    2.372 W    6.005 W    6.016 W

% power reduction     40.04%     30.97%     36.83%      2.94%      0.05%

Conclusion:

nohz_full_aggressive used together with nohz_full=all allows to save
some energy when the system is idle or under low CPU usage (e.g., when
less than half of the CPUs are used).

Under high CPU load conditions power consumption is pretty much
identical to nohz_full=all because the impact of the saved power/irqs on
the timekeeping CPU doesn't contribute very much to the total energy
consumption.

However, enabling nohz_full_aggressive can lead to timing inaccuracies
in the system, because periodic ticks can be disabled also on the
timekeeping CPU.

Note:

I wrote this patch while I was stuck in the airport, because my flight
was delayed and I was trying to optimize the battery usage of my laptop
in more creative ways. Ultimately I ended up wasting a lot more energy
to test this patch, but at least the long wait wasn't too boring.

Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
---
 .../ABI/testing/sysfs-devices-system-cpu      | 12 ++++++++++++
 .../admin-guide/kernel-parameters.txt         |  7 +++++++
 Documentation/timers/no_hz.rst                |  5 +++++
 drivers/base/cpu.c                            | 19 +++++++++++++++++++
 include/linux/tick.h                          |  7 +++++++
 kernel/time/hrtimer.c                         |  7 ++++++-
 kernel/time/tick-sched.c                      | 16 +++++++++++++---
 7 files changed, 69 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index f54867cadb0f..aa620e154d54 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -679,6 +679,18 @@ Description:
 		(RO) the list of CPUs that are in nohz_full mode.
 		These CPUs are set by boot parameter "nohz_full=".
 
+What:		/sys/devices/system/cpu/nohz_full_aggressive
+Date:		Apr 2023
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RW) enable/disable nohz_full also for the timekeeping CPU.
+
+		WARNING: enabling this option can cause potential
+		high-resolution timer inaccuracies in the system.
+
+		This option can be set by boot parameter
+		"nohz_full_aggressive".
+
 What:		/sys/devices/system/cpu/isolated
 Date:		Apr 2015
 Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9e5bab29685f..23c6fe20e067 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3732,6 +3732,13 @@
 			Note that this argument takes precedence over
 			the CONFIG_RCU_NOCB_CPU_DEFAULT_ALL option.
 
+	nohz_full_aggressive
+			[KNL,BOOT,SMP,ISOL] allow to enable nohz_full also for
+			the timekeeping CPU.
+
+			WARNING: enabling this option can cause potential
+			high-resolution timer inaccuracies in the system.
+
 	noinitrd	[RAM] Tells the kernel not to load any configured
 			initial RAM disk.
 
diff --git a/Documentation/timers/no_hz.rst b/Documentation/timers/no_hz.rst
index f8786be15183..aa9f79297d77 100644
--- a/Documentation/timers/no_hz.rst
+++ b/Documentation/timers/no_hz.rst
@@ -136,6 +136,11 @@ error message, and the boot CPU will be removed from the mask.  Note that
 this means that your system must have at least two CPUs in order for
 CONFIG_NO_HZ_FULL=y to do anything for you.
 
+This constraint can be relaxed passing the parameter "nohz_full_aggressive".
+With this option enabled the timekeeping CPU can be also configured to use
+non-adaptive ticks, at the cost of having potential high-resolution timer
+inaccuracies and in the system.
+
 Finally, adaptive-ticks CPUs must have their RCU callbacks offloaded.
 This is covered in the "RCU IMPLICATIONS" section below.
 
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index c1815b9dae68..b55d6111a733 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -280,6 +280,24 @@ static ssize_t print_cpus_nohz_full(struct device *dev,
 	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(tick_nohz_full_mask));
 }
 static DEVICE_ATTR(nohz_full, 0444, print_cpus_nohz_full, NULL);
+
+static ssize_t
+nohz_full_aggressive_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	return sysfs_emit(buf, "%d\n", tick_nohz_full_aggressive);
+}
+
+static ssize_t nohz_full_aggressive_store(struct device *dev,
+					  struct device_attribute *attr,
+					  const char *buf, size_t count)
+{
+	if (kstrtobool(buf, &tick_nohz_full_aggressive))
+		return -EINVAL;
+	return count;
+}
+
+static DEVICE_ATTR_RW(nohz_full_aggressive);
 #endif
 
 static void cpu_device_release(struct device *dev)
@@ -468,6 +486,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&dev_attr_isolated.attr,
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
+	&dev_attr_nohz_full_aggressive.attr,
 #endif
 #ifdef CONFIG_GENERIC_CPU_AUTOPROBE
 	&dev_attr_modalias.attr,
diff --git a/include/linux/tick.h b/include/linux/tick.h
index 9459fef5b857..8d557838b3f6 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -176,6 +176,7 @@ static inline void tick_nohz_idle_stop_tick_protected(void) { }
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool tick_nohz_full_running;
+extern bool tick_nohz_full_aggressive;
 extern cpumask_var_t tick_nohz_full_mask;
 
 static inline bool tick_nohz_full_enabled(void)
@@ -186,6 +187,11 @@ static inline bool tick_nohz_full_enabled(void)
 	return tick_nohz_full_running;
 }
 
+static inline bool tick_nohz_full_aggressive_enabled(void)
+{
+	return !!tick_nohz_full_aggressive;
+}
+
 /*
  * Check if a CPU is part of the nohz_full subset. Arrange for evaluating
  * the cpu expression (typically smp_processor_id()) _after_ the static
@@ -276,6 +282,7 @@ extern void __tick_nohz_task_switch(void);
 extern void __init tick_nohz_full_setup(cpumask_var_t cpumask);
 #else
 static inline bool tick_nohz_full_enabled(void) { return false; }
+static inline bool tick_nohz_full_aggressive_enabled(void) { return false; }
 static inline bool tick_nohz_full_cpu(int cpu) { return false; }
 static inline void tick_nohz_full_add_cpus_to(struct cpumask *mask) { }
 
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index e8c08292defc..b3f27c6c8475 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1866,7 +1866,12 @@ void hrtimer_interrupt(struct clock_event_device *dev)
 	else
 		expires_next = ktime_add(now, delta);
 	tick_program_event(expires_next, 1);
-	pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
+	/*
+	 * This is a "normal" condition when nohz_full_aggressive mode is
+	 * enabled, so avoid printing this warning in this case.
+	 */
+	if (!tick_nohz_full_aggressive_enabled())
+		pr_warn_once("hrtimer: interrupt took %llu ns\n", ktime_to_ns(delta));
 }
 
 /* called with interrupts disabled */
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 52254679ec48..8864066e4746 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -188,7 +188,8 @@ static void tick_sched_do_timer(struct tick_sched *ts, ktime_t now)
 	 */
 	if (unlikely(tick_do_timer_cpu == TICK_DO_TIMER_NONE)) {
 #ifdef CONFIG_NO_HZ_FULL
-		WARN_ON_ONCE(tick_nohz_full_running);
+		if (!tick_nohz_full_aggressive_enabled())
+			WARN_ON_ONCE(tick_nohz_full_running);
 #endif
 		tick_do_timer_cpu = cpu;
 	}
@@ -250,6 +251,8 @@ cpumask_var_t tick_nohz_full_mask;
 EXPORT_SYMBOL_GPL(tick_nohz_full_mask);
 bool tick_nohz_full_running;
 EXPORT_SYMBOL_GPL(tick_nohz_full_running);
+bool tick_nohz_full_aggressive;
+EXPORT_SYMBOL_GPL(tick_nohz_full_aggressive);
 static atomic_t tick_dep_mask;
 
 static bool check_tick_dependency(atomic_t *dep)
@@ -524,6 +527,13 @@ void __tick_nohz_task_switch(void)
 	}
 }
 
+static int __init tick_nohz_full_aggressive_setup(char *str)
+{
+	tick_nohz_full_aggressive = true;
+	return 1;
+}
+__setup("nohz_full_aggressive", tick_nohz_full_aggressive_setup);
+
 /* Get the boot-time nohz CPU list from the kernel parameters. */
 void __init tick_nohz_full_setup(cpumask_var_t cpumask)
 {
@@ -854,7 +864,7 @@ static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
 	 * Otherwise we can sleep as long as we want.
 	 */
 	delta = timekeeping_max_deferment();
-	if (cpu != tick_do_timer_cpu &&
+	if ((tick_nohz_full_aggressive_enabled() || cpu != tick_do_timer_cpu) &&
 	    (tick_do_timer_cpu != TICK_DO_TIMER_NONE || !ts->do_timer_last))
 		delta = KTIME_MAX;
 
@@ -1073,7 +1083,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (unlikely(report_idle_softirq()))
 		return false;
 
-	if (tick_nohz_full_enabled()) {
+	if (tick_nohz_full_enabled() && !tick_nohz_full_aggressive_enabled()) {
 		/*
 		 * Keep the tick alive to guarantee timekeeping progression
 		 * if there are full dynticks CPUs around
-- 
2.39.2

