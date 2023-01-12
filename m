Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B9A5667AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 17:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238056AbjALQ1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 11:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238076AbjALQ1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 11:27:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE7E1C10C
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 08:24:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99FD96208F
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 16:24:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92642C433EF;
        Thu, 12 Jan 2023 16:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673540677;
        bh=63+5Xx8u7+1H2T+lBnQxdLkryhorI+y70lXtivZ2alk=;
        h=From:To:Cc:Subject:Date:From;
        b=BSlgKwj7Yc/kGMm+EXmtq1wG1gBZCE7Lk0aZFZ0HMlmTFhAtM21eTekAATIk00Hg6
         Uup6nZsgBwwcEusdgdDaiKJKSEo6XQYJj/rEaYxUFs/oNJ8R/4N5tWsRAYtWf2mym4
         oV2m+iU1WHcqYz1BfSIpsOF3p9/90cxxP0qYtVkLxAi5altbJnhzi9fRVzqE0G9jJv
         oIRVgmI6PiufDey2uHFj5KiJWNfG9udOXZoDH5LWRxcwE7gPrlXu6RwWORU80KdmfO
         v4TQhmIVtYZXV4w8BkN/bnvUsGpiuqvRDeqVg8k3b9NpcCmdm8ykCepThyED5H70GA
         zn7f2Qg3yzHuA==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Joe Mario <jmario@redhat.com>
Subject: [PATCH] sched/idle: Make idle poll dynamic per-cpu
Date:   Thu, 12 Jan 2023 17:24:26 +0100
Message-Id: <20230112162426.217522-1-bristot@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

idle=poll is frequently used on ultra-low-latency systems. Examples of
such systems are high-performance trading and 5G NVRAM. The performance
gain is given by avoiding the idle driver machinery and by keeping the
CPU is always in an active state - avoiding (odd) hardware heuristics that
are out of the control of the OS.

Currently, idle=poll is an all-or-nothing static option defined at
boot time. The motivation for creating this option dynamic and per-cpu
are two:

  1) Reduce the power usage/heat by allowing only selected CPUs to
     do idle polling;
  2) Allow multi-tenant systems (e.g., Kubernetes) to enable idle
     polling only when ultra-low-latency applications are present
     on specific CPUs.

Joe Mario did some experiments with this option enabled, and the results
were significant. For example, by using dynamic idle polling on
selected CPUs, cyclictest performance is optimal (like when using
idle=poll), but cpu power consumption drops from 381 to 233 watts.

Also, limiting idle=poll to the set of CPUs that benefits from
it allows other CPUs to benefit from frequency boosts. Joe also
shows that the results can be in the order of 80nsec round trip
improvement when system-wide idle=poll was not used.

The user can enable idle polling with this command:
  # echo 1 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll

And disable it via:
  # echo 0 > /sys/devices/system/cpu/cpu{CPU_ID}/idle_poll

By default, all CPUs have idle polling disabled (the current behavior).
A static key avoids the CPU mask check overhead when no idle polling
is enabled.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Joe Mario <jmario@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/sched/idle.c | 97 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f26ab2675f7d..c6ef1322d549 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -10,6 +10,91 @@
 /* Linker adds these: start and end of __cpuidle functions */
 extern char __cpuidle_text_start[], __cpuidle_text_end[];
 
+/*
+ * per-cpu idle polling selector.
+ */
+static struct cpumask cpu_poll_mask;
+DEFINE_STATIC_KEY_FALSE(cpu_poll_enabled);
+
+/*
+ * Protects the mask/static key relation.
+ */
+DEFINE_MUTEX(cpu_poll_mutex);
+
+static ssize_t idle_poll_store(struct device *dev, struct device_attribute *attr,
+			       const char *buf, size_t count)
+{
+	int cpu = dev->id;
+	int retval, set;
+	bool val;
+
+	retval = kstrtobool(buf, &val);
+	if (retval)
+		return retval;
+
+	mutex_lock(&cpu_poll_mutex);
+
+	if (val) {
+		set = cpumask_test_and_set_cpu(cpu, &cpu_poll_mask);
+
+		/*
+		 * If the CPU was already on, do not increase the static key usage.
+		 */
+		if (!set)
+			static_branch_inc(&cpu_poll_enabled);
+	} else {
+		set = cpumask_test_and_clear_cpu(cpu, &cpu_poll_mask);
+
+		/*
+		 * If the CPU was already off, do not decrease the static key usage.
+		 */
+		if (set)
+			static_branch_dec(&cpu_poll_enabled);
+	}
+
+	mutex_unlock(&cpu_poll_mutex);
+
+	return count;
+}
+
+static ssize_t idle_poll_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%d\n", cpumask_test_cpu(dev->id, &cpu_poll_mask));
+}
+
+static DEVICE_ATTR_RW(idle_poll);
+
+static const struct attribute *idle_poll_attrs[] = {
+	&dev_attr_idle_poll.attr,
+	NULL
+};
+
+static int __init idle_poll_sysfs_init(void)
+{
+	int cpu, retval;
+
+	for_each_possible_cpu(cpu) {
+		struct device *dev = get_cpu_device(cpu);
+
+		if (!dev)
+			continue;
+		retval = sysfs_create_files(&dev->kobj, idle_poll_attrs);
+		if (retval)
+			return retval;
+	}
+
+	return 0;
+}
+device_initcall(idle_poll_sysfs_init);
+
+static int is_cpu_idle_poll(int cpu)
+{
+	if (static_branch_unlikely(&cpu_poll_enabled))
+		return cpumask_test_cpu(cpu, &cpu_poll_mask);
+
+	return 0;
+}
+
 /**
  * sched_idle_set_state - Record idle state for the current CPU.
  * @idle_state: State to record.
@@ -51,18 +136,21 @@ __setup("hlt", cpu_idle_nopoll_setup);
 
 static noinline int __cpuidle cpu_idle_poll(void)
 {
-	trace_cpu_idle(0, smp_processor_id());
+	int cpu = smp_processor_id();
+
+	trace_cpu_idle(0, cpu);
 	stop_critical_timings();
 	ct_idle_enter();
 	local_irq_enable();
 
 	while (!tif_need_resched() &&
-	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
+	       (cpu_idle_force_poll || tick_check_broadcast_expired()
+		|| is_cpu_idle_poll(cpu)))
 		cpu_relax();
 
 	ct_idle_exit();
 	start_critical_timings();
-	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
+	trace_cpu_idle(PWR_EVENT_EXIT, cpu);
 
 	return 1;
 }
@@ -296,7 +384,8 @@ static void do_idle(void)
 		 * broadcast device expired for us, we don't want to go deep
 		 * idle as we know that the IPI is going to arrive right away.
 		 */
-		if (cpu_idle_force_poll || tick_check_broadcast_expired()) {
+		if (cpu_idle_force_poll || tick_check_broadcast_expired()
+		    || is_cpu_idle_poll(cpu)) {
 			tick_nohz_idle_restart_tick();
 			cpu_idle_poll();
 		} else {
-- 
2.38.1

