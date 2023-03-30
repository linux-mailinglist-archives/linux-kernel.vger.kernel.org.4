Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DCB6D1277
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 00:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbjC3WpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 18:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjC3Wok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 18:44:40 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD4D8DBF7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:44:34 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-545ef25cfb7so139404717b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 15:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680216274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PafzZUjsN+AldhPHNYx1ZKiIIku0MB5EoRgnFO5S24A=;
        b=IKo+uYXFFOMVUkZCYD9QMyvEzy1K5F2Pc9DdKpm5zjml0/VAGJUaLqqMWkx5eqevIY
         dFPCOU0wSNRnXquMJxQGOpdJihyAhn9Wqz/DZRA8h8eZZlflCfxVOo0BLAZxHkF6KQno
         ODtLcGtCtxingBlMnCwD+pBF0PySDATkGjxGl5tf6QtSVZDGX/yjLbR/rPR3GEgGA8L4
         ENcw1nZtvF2tW2qjsprDMsEIrbTGDXrU1qEcikQoszEXgxUXOxY8fqPN8rBKcF8L9Zld
         n4jp4Mx0M90/W/506LqL6MYLmvBH25YiUD8PRR8t0m/lQpg06cHUDmRR9aUCuuiQjCVV
         QVXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680216274;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PafzZUjsN+AldhPHNYx1ZKiIIku0MB5EoRgnFO5S24A=;
        b=wtMG/wjUBVqexMhzXcx7lQPieUtdZB4QkpSSzQU2Q9b5Zy8+yaRsaMrnPzig4r4p0b
         rK0RV4sWgGWRL89xWGujP/i9TW0pfp0SQhYWYBVmc2lhtc1C6uEX7+XKQuiiGVzI4Lo0
         MdvZe8EqhL+wcCdPaHdaTQE0BdZUmPMwthp7kYiGt4fOJdkGC0WiU5eB1mn7fV2fpyDH
         RnXkx3iHf0/C8nzbKsxsm/ecJ/nKi4CL+jLFJO0t3H2dScPxmSOGA44yVv/tXLTYVXax
         f3qmrA2oYqpTAl2um8hKDPhebXb2DTZl+LcwGJkgb6IQYKiU5Pjpqaita9Mxee5ceuLX
         GW4Q==
X-Gm-Message-State: AAQBX9eSExNspUHWHWpq9zlxObWLPdFD2G7lb9Y5IHB1xDNB1iZC5gIV
        t0f5RbJRGFRkxYkjmYhTm2qLKjj2/4MH
X-Google-Smtp-Source: AKy350YE+XR9BlmvWUfrlL4ZhH75skUxtvf6Y6Jcl33IrYOudgql0YBgTSgHkhTSUkWj1dRNbRJzCn45A6sz
X-Received: from davidai2.mtv.corp.google.com ([2620:15c:211:201:c162:24e8:ec5e:d520])
 (user=davidai job=sendgmr) by 2002:a81:ad05:0:b0:545:fff5:b639 with SMTP id
 l5-20020a81ad05000000b00545fff5b639mr7392338ywh.1.1680216273889; Thu, 30 Mar
 2023 15:44:33 -0700 (PDT)
Date:   Thu, 30 Mar 2023 15:43:41 -0700
In-Reply-To: <20230330224348.1006691-1-davidai@google.com>
Mime-Version: 1.0
References: <20230330224348.1006691-1-davidai@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230330224348.1006691-7-davidai@google.com>
Subject: [RFC PATCH 6/6] cpufreq: add kvm-cpufreq driver
From:   David Dai <davidai@google.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Cc:     David Dai <davidai@google.com>,
        Saravana Kannan <saravanak@google.com>,
        kernel-team@android.com, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a virtualized cpufreq driver for guest kernels to improve
performance and power of workloads within VMs.

This driver does two main things:

1. Sends utilization of vCPUs as a hint to the host. The host uses the
hint to schedule the vCPU threads and decide physical CPU frequency.

2. If a VM does not support a virtualized FIE(like AMUs), it uses
hypercalls to update the guest's frequency scaling factor periodically
by querying the host CPU frequency. This enables accurate
Per-Entity Load Tracking for tasks running in the guest.

Note that because the host already employs a rate_limit_us, we set the
transition_delay_us of the cpufreq policy to a miniscule value(1)
to avoid any additional delays between when the runqueue's util change
and a frequency response on the host.

Co-developed-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: Saravana Kannan <saravanak@google.com>
Signed-off-by: David Dai <davidai@google.com>
---
 drivers/cpufreq/Kconfig       |  13 ++
 drivers/cpufreq/Makefile      |   1 +
 drivers/cpufreq/kvm-cpufreq.c | 245 ++++++++++++++++++++++++++++++++++
 include/linux/sched.h         |   1 +
 kernel/sched/core.c           |   6 +
 5 files changed, 266 insertions(+)
 create mode 100644 drivers/cpufreq/kvm-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index 2c839bd2b051..0ef9d5be7c4d 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -217,6 +217,19 @@ config CPUFREQ_DT
 
 	  If in doubt, say N.
 
+config CPUFREQ_KVM
+        tristate "KVM cpufreq driver"
+        help
+          This adds a virtualized KVM cpufreq driver for guest kernels that
+	  uses hypercalls to communicate with the host. It sends utilization
+	  updates to the host and gets used to schedule vCPU threads and
+	  select CPU frequency. If a VM does not support a virtualized FIE
+	  such as AMUs, it updates the frequency scaling factor by polling
+	  host CPU frequency to enable accurate Per-Entity Load Tracking
+	  for tasks running in the guest.
+
+	  If in doubt, say N.
+
 config CPUFREQ_DT_PLATDEV
 	bool
 	help
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index ef8510774913..179ea8d45135 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_CPU_FREQ_GOV_ATTR_SET)	+= cpufreq_governor_attr_set.o
 
 obj-$(CONFIG_CPUFREQ_DT)		+= cpufreq-dt.o
 obj-$(CONFIG_CPUFREQ_DT_PLATDEV)	+= cpufreq-dt-platdev.o
+obj-$(CONFIG_CPUFREQ_KVM)              += kvm-cpufreq.o
 
 # Traces
 CFLAGS_amd-pstate-trace.o               := -I$(src)
diff --git a/drivers/cpufreq/kvm-cpufreq.c b/drivers/cpufreq/kvm-cpufreq.c
new file mode 100644
index 000000000000..1542c9ac4119
--- /dev/null
+++ b/drivers/cpufreq/kvm-cpufreq.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Google LLC
+ */
+
+#include <linux/arch_topology.h>
+#include <linux/arm-smccc.h>
+#include <linux/cpufreq.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_platform.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+static void kvm_scale_freq_tick(void)
+{
+	unsigned long scale, cur_freq, max_freq;
+	struct arm_smccc_res hvc_res;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_GET_CUR_CPUFREQ_FUNC_ID,
+			0, &hvc_res);
+
+	cur_freq = hvc_res.a0;
+	max_freq = cpufreq_get_hw_max_freq(task_cpu(current));
+	scale = (cur_freq << SCHED_CAPACITY_SHIFT) / max_freq;
+
+	this_cpu_write(arch_freq_scale, (unsigned long)scale);
+}
+
+static struct scale_freq_data kvm_sfd = {
+	.source = SCALE_FREQ_SOURCE_ARCH,
+	.set_freq_scale = kvm_scale_freq_tick,
+};
+
+struct remote_data {
+	int ret;
+	struct cpufreq_frequency_table *table;
+};
+
+static void remote_get_freqtbl_num_entries(void *data)
+{
+	struct arm_smccc_res hvc_res;
+	u32 freq = 1UL;
+	int *idx = data;
+
+	while (freq != CPUFREQ_TABLE_END) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_GET_CPUFREQ_TBL_FUNC_ID,
+				*idx, &hvc_res);
+		if (hvc_res.a0) {
+			*idx = -ENODEV;
+			return;
+		}
+		freq = hvc_res.a1;
+		(*idx)++;
+	}
+}
+
+static int kvm_cpufreq_get_freqtbl_num_entries(int cpu)
+{
+	int num_entries = 0;
+
+	smp_call_function_single(cpu, remote_get_freqtbl_num_entries, &num_entries, true);
+	return num_entries;
+}
+
+static void remote_populate_freqtbl(void *data)
+{
+	struct arm_smccc_res hvc_res;
+	struct remote_data *freq_data = data;
+	struct cpufreq_frequency_table *pos;
+	struct cpufreq_frequency_table *table = freq_data->table;
+	int idx;
+
+	cpufreq_for_each_entry_idx(pos, table, idx) {
+		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_GET_CPUFREQ_TBL_FUNC_ID,
+				idx, &hvc_res);
+		if (hvc_res.a0) {
+			freq_data->ret = -ENODEV;
+			return;
+		}
+		pos->frequency = hvc_res.a1;
+	}
+	freq_data->ret = 0;
+}
+
+static int kvm_cpufreq_populate_freqtbl(struct cpufreq_frequency_table	*table, int cpu)
+{
+	struct remote_data freq_data;
+
+	freq_data.table = table;
+	smp_call_function_single(cpu, remote_populate_freqtbl, &freq_data, true);
+	return freq_data.ret;
+}
+
+static unsigned int kvm_cpufreq_setutil_hyp(struct cpufreq_policy *policy)
+{
+	struct arm_smccc_res hvc_res;
+	u32 util = sched_cpu_util_freq(policy->cpu);
+	u32 cap = arch_scale_cpu_capacity(policy->cpu);
+	u32 threshold = cap - (cap >> 2);
+
+	if (util > threshold)
+		util = (cap + threshold) >> 1;
+
+	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_KVM_UTIL_HINT_FUNC_ID,
+			     util, &hvc_res);
+
+	return hvc_res.a0;
+}
+
+static unsigned int kvm_cpufreq_fast_switch(struct cpufreq_policy *policy,
+		unsigned int target_freq)
+{
+	kvm_cpufreq_setutil_hyp(policy);
+	return target_freq;
+}
+
+static int kvm_cpufreq_target_index(struct cpufreq_policy *policy,
+		unsigned int index)
+{
+	return kvm_cpufreq_setutil_hyp(policy);
+}
+
+static const struct of_device_id kvm_cpufreq_match[] = {
+	{ .compatible = "virtual,kvm-cpufreq"},
+	{}
+};
+MODULE_DEVICE_TABLE(of, kvm_cpufreq_match);
+
+static int kvm_cpufreq_cpu_init(struct cpufreq_policy *policy)
+{
+	struct device *cpu_dev;
+	struct cpufreq_frequency_table	*table;
+	int num_entries;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("%s: failed to get cpu%d device\n", __func__,
+		       policy->cpu);
+		return -ENODEV;
+	}
+
+	num_entries = kvm_cpufreq_get_freqtbl_num_entries(policy->cpu);
+	if (num_entries == -ENODEV)
+		return -ENODEV;
+
+	table = kcalloc(num_entries, sizeof(*table), GFP_KERNEL);
+	if (!table)
+		return -ENOMEM;
+
+	table[num_entries-1].frequency = CPUFREQ_TABLE_END;
+
+	if (kvm_cpufreq_populate_freqtbl(table, policy->cpu))
+		return -ENODEV;
+
+	policy->freq_table = table;
+	policy->dvfs_possible_from_any_cpu = false;
+	policy->fast_switch_possible = true;
+	policy->transition_delay_us = 1;
+
+	/*
+	 * Only takes effect if another FIE source such as AMUs
+	 * have not been registered.
+	 */
+	topology_set_scale_freq_source(&kvm_sfd, policy->cpus);
+
+	return 0;
+}
+
+static int kvm_cpufreq_cpu_exit(struct cpufreq_policy *policy)
+{
+	kfree(policy->freq_table);
+	return 0;
+}
+
+static int kvm_cpufreq_online(struct cpufreq_policy *policy)
+{
+	/* Nothing to restore. */
+	return 0;
+}
+
+static int kvm_cpufreq_offline(struct cpufreq_policy *policy)
+{
+	/* Dummy offline() to avoid exit() being called and freeing resources. */
+	return 0;
+}
+
+static struct cpufreq_driver cpufreq_kvm_driver = {
+	.name		= "kvm-cpufreq",
+	.init		= kvm_cpufreq_cpu_init,
+	.exit		= kvm_cpufreq_cpu_exit,
+	.online         = kvm_cpufreq_online,
+	.offline        = kvm_cpufreq_offline,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.target_index	= kvm_cpufreq_target_index,
+	.fast_switch	= kvm_cpufreq_fast_switch,
+	.attr		= cpufreq_generic_attr,
+};
+
+static int kvm_cpufreq_driver_probe(struct platform_device *pdev)
+{
+	int ret;
+
+	ret = cpufreq_register_driver(&cpufreq_kvm_driver);
+	if (ret) {
+		dev_err(&pdev->dev, "KVM CPUFreq driver failed to register: %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(&pdev->dev, "KVM CPUFreq driver initialized\n");
+	return 0;
+}
+
+static int kvm_cpufreq_driver_remove(struct platform_device *pdev)
+{
+	cpufreq_unregister_driver(&cpufreq_kvm_driver);
+	return 0;
+}
+
+static struct platform_driver kvm_cpufreq_driver = {
+	.probe = kvm_cpufreq_driver_probe,
+	.remove = kvm_cpufreq_driver_remove,
+	.driver = {
+		.name = "kvm-cpufreq",
+		.of_match_table = kvm_cpufreq_match,
+	},
+};
+
+static int __init kvm_cpufreq_init(void)
+{
+	return platform_driver_register(&kvm_cpufreq_driver);
+}
+postcore_initcall(kvm_cpufreq_init);
+
+static void __exit kvm_cpufreq_exit(void)
+{
+	platform_driver_unregister(&kvm_cpufreq_driver);
+}
+module_exit(kvm_cpufreq_exit);
+
+MODULE_DESCRIPTION("KVM cpufreq driver");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/sched.h b/include/linux/sched.h
index d8c346fcdf52..bd38aa32a57c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2303,6 +2303,7 @@ static inline bool owner_on_cpu(struct task_struct *owner)
 
 /* Returns effective CPU energy utilization, as seen by the scheduler */
 unsigned long sched_cpu_util(int cpu);
+unsigned long sched_cpu_util_freq(int cpu);
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_RSEQ
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7700ef5610c1..dd46f4cc629b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7421,6 +7421,12 @@ unsigned long sched_cpu_util(int cpu)
 {
 	return effective_cpu_util(cpu, cpu_util_cfs(cpu), ENERGY_UTIL, NULL);
 }
+
+unsigned long sched_cpu_util_freq(int cpu)
+{
+	return effective_cpu_util(cpu, cpu_util_cfs(cpu), FREQUENCY_UTIL, NULL);
+}
+
 #endif /* CONFIG_SMP */
 
 /**
-- 
2.40.0.348.gf938b09366-goog

