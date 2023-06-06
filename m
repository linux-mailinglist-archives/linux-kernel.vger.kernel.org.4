Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9351E72485F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238311AbjFFP6J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:58:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237689AbjFFP6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:58:07 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F21C611D;
        Tue,  6 Jun 2023 08:58:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E3642F4;
        Tue,  6 Jun 2023 08:58:50 -0700 (PDT)
Received: from e125905.cambridge.arm.com (e125905.cambridge.arm.com [10.1.198.22])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 026C73F6C4;
        Tue,  6 Jun 2023 08:58:02 -0700 (PDT)
From:   Beata Michalska <beata.michalska@arm.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, will@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org, sudeep.holla@arm.com,
        ionela.voinescu@arm.com, sumitg@nvidia.com,
        yang@os.amperecomputing.com
Subject: [PATCH] arm64: Provide an AMU-based version of arch_freq_get_on_cpu
Date:   Tue,  6 Jun 2023 16:57:54 +0100
Message-Id: <20230606155754.245998-1-beata.michalska@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the Frequency Invariance Engine (FIE) being already wired up with
sched tick and making use of relevant (core counter and constant
counter) AMU counters, getting the current frequency for a given CPU
on supported platforms, can be achieved by utilizing the frequency scale
factor which reflects an average CPU frequency for the last tick period
length.

With that at hand, arch_freq_get_on_cpu dedicated implementation
gets enrolled into cpuinfo_cur_freq policy sysfs attribute handler,
which is expected to represent the current frequency of a given CPU,
as obtained by the hardware. This is exactly the type of feedback that
cycle counters provide.

In order to avoid calling arch_freq_get_on_cpu from the scaling_cur_freq
attribute handler for platforms that do provide cpuinfo_cur_freq, and
yet keeping things intact for those platform that do not, its use gets
conditioned on the presence of cpufreq_driver (*get) callback (which also
seems to be the case for creating cpuinfo_cur_freq attribute).

Suggested-by: Ionela Voinescu <ionela.voinescu@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
---
 arch/arm64/kernel/topology.c | 34 ++++++++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq.c    |  9 +++++++--
 2 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 817d788cd866..00a1aa421ec2 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -17,6 +17,7 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/percpu.h>
+#include <linux/sched/isolation.h>
 
 #include <asm/cpu.h>
 #include <asm/cputype.h>
@@ -251,6 +252,39 @@ static int __init init_amu_fie(void)
 }
 core_initcall(init_amu_fie);
 
+unsigned int arch_freq_get_on_cpu(int cpu)
+{
+	unsigned int freq;
+	u64 scale;
+
+	if (!cpumask_test_cpu(cpu, amu_fie_cpus))
+		return 0;
+
+	if (!housekeeping_cpu(cpu, HK_TYPE_TICK)) {
+		struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
+		int ref_cpu = nr_cpu_ids;
+
+		if (cpumask_intersects(housekeeping_cpumask(HK_TYPE_TICK),
+				       policy->cpus))
+			ref_cpu = cpumask_nth_and(cpu, policy->cpus,
+						  housekeeping_cpumask(HK_TYPE_TICK));
+		cpufreq_cpu_put(policy);
+		if (ref_cpu >= nr_cpu_ids)
+			return 0;
+		cpu = ref_cpu;
+	}
+	/*
+	 * Reversed computation to the one used to determine
+	 * the arch_freq_scale value
+	 * (see amu_scale_freq_tick for details)
+	 */
+	scale = per_cpu(arch_freq_scale, cpu);
+	scale *= cpufreq_get_hw_max_freq(cpu);
+	freq = scale >> SCHED_CAPACITY_SHIFT;
+
+	return freq;
+}
+
 #ifdef CONFIG_ACPI_CPPC_LIB
 #include <acpi/cppc_acpi.h>
 
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 6b52ebe5a890..9f2cf45bf190 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -710,7 +710,8 @@ static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 	ssize_t ret;
 	unsigned int freq;
 
-	freq = arch_freq_get_on_cpu(policy->cpu);
+	freq = !cpufreq_driver->get ? arch_freq_get_on_cpu(policy->cpu)
+				    : 0;
 	if (freq)
 		ret = sprintf(buf, "%u\n", freq);
 	else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
@@ -747,7 +748,11 @@ store_one(scaling_max_freq, max);
 static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
 					char *buf)
 {
-	unsigned int cur_freq = __cpufreq_get(policy);
+	unsigned int cur_freq;
+
+	cur_freq = arch_freq_get_on_cpu(policy->cpu);
+	if (!cur_freq)
+		cur_freq = __cpufreq_get(policy);
 
 	if (cur_freq)
 		return sprintf(buf, "%u\n", cur_freq);
-- 
2.25.1

