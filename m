Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF0C63A8A1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 13:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiK1MnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 07:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbiK1MnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 07:43:09 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718CCA187;
        Mon, 28 Nov 2022 04:43:05 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sendonly@marcansoft.com)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 694B641F5F;
        Mon, 28 Nov 2022 12:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
        t=1669639384; bh=xu+M6kzAgmGaqxFmqGvu6onPy0TJsA1BV56P0fanJXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eTM3zq8DbsjBS009RhuxOa4tjYtommczCPGSpaDiNK0SuqmfhZk2TgCasMeO6DMDF
         ndUkQHX2yBuirYTZrWCv5JHijmvimwcqYHOl2Kb9BwKlDSON3KdAtrBp1ppO8ZCOu9
         63RrZulwwtHJXKG61oruGMgTNjzBOKJKwdh5Gay+KUqURlz3gwqv0wk8UvSdzUVV7V
         Obn6nFVrR9C36KfFrVJAoa8RPa7KZRBGco4/kGXgcFVzlcTtvzwQYWu0JOeiXirDyz
         Xq6I0urOGdJ0Th9Oh71ZgNzIssZvd4WpZNqI+CwV2EGcXqmhb73FhNW+HntIiAQPJ7
         swW3RClEIjgCA==
From:   Hector Martin <marcan@marcan.st>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <mark.kettenis@xs4all.nl>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] cpufreq: apple-soc: Add new driver to control Apple SoC CPU P-states
Date:   Mon, 28 Nov 2022 21:42:15 +0900
Message-Id: <20221128124216.13477-4-marcan@marcan.st>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221128124216.13477-1-marcan@marcan.st>
References: <20221128124216.13477-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver implements CPU frequency scaling for Apple Silicon SoCs,
including M1 (t8103), M1 Max/Pro/Ultra (t600x), and M2 (t8112).

Each CPU cluster has its own register set, and frequency management is
fully automated by the hardware; the driver only has to write one
register. There is boost frequency support, but the hardware will only
allow their use if only a subset of cores in a cluster are in
non-deep-idle. Since we don't support deep idle yet, these frequencies
are not achievable, but the driver supports them. They will remain
disabled in the device tree until deep idle is implemented, to avoid
confusing users.

This driver does not yet implement the memory controller performance
state tuning that usually accompanies higher CPU p-states. This will be
done in a future patch.

Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Hector Martin <marcan@marcan.st>
---
 drivers/cpufreq/Kconfig.arm          |   9 +
 drivers/cpufreq/Makefile             |   1 +
 drivers/cpufreq/apple-soc-cpufreq.c  | 352 +++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |   2 +
 4 files changed, 364 insertions(+)
 create mode 100644 drivers/cpufreq/apple-soc-cpufreq.c

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index be590f498e6a..0a0352d8fa45 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -41,6 +41,15 @@ config ARM_ALLWINNER_SUN50I_CPUFREQ_NVMEM
 	  To compile this driver as a module, choose M here: the
 	  module will be called sun50i-cpufreq-nvmem.
 
+config ARM_APPLE_SOC_CPUFREQ
+	tristate "Apple Silicon SoC CPUFreq support"
+	depends on ARCH_APPLE || (COMPILE_TEST && 64BIT)
+	select PM_OPP
+	default ARCH_APPLE
+	help
+	  This adds the CPUFreq driver for Apple Silicon machines
+	  (e.g. Apple M1).
+
 config ARM_ARMADA_37XX_CPUFREQ
 	tristate "Armada 37xx CPUFreq support"
 	depends on ARCH_MVEBU && CPUFREQ_DT
diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 49b98c62c5af..32a7029e25ed 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -52,6 +52,7 @@ obj-$(CONFIG_X86_AMD_FREQ_SENSITIVITY)	+= amd_freq_sensitivity.o
 
 ##################################################################################
 # ARM SoC drivers
+obj-$(CONFIG_ARM_APPLE_SOC_CPUFREQ)	+= apple-soc-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_37XX_CPUFREQ)	+= armada-37xx-cpufreq.o
 obj-$(CONFIG_ARM_ARMADA_8K_CPUFREQ)	+= armada-8k-cpufreq.o
 obj-$(CONFIG_ARM_BRCMSTB_AVS_CPUFREQ)	+= brcmstb-avs-cpufreq.o
diff --git a/drivers/cpufreq/apple-soc-cpufreq.c b/drivers/cpufreq/apple-soc-cpufreq.c
new file mode 100644
index 000000000000..d1801281cdd9
--- /dev/null
+++ b/drivers/cpufreq/apple-soc-cpufreq.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Apple SoC CPU cluster performance state driver
+ *
+ * Copyright The Asahi Linux Contributors
+ *
+ * Based on scpi-cpufreq.c
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cpu.h>
+#include <linux/cpufreq.h>
+#include <linux/cpumask.h>
+#include <linux/delay.h>
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/pm_opp.h>
+#include <linux/slab.h>
+
+#define APPLE_DVFS_CMD			0x20
+#define APPLE_DVFS_CMD_BUSY		BIT(31)
+#define APPLE_DVFS_CMD_SET		BIT(25)
+#define APPLE_DVFS_CMD_PS2		GENMASK(16, 12)
+#define APPLE_DVFS_CMD_PS1		GENMASK(4, 0)
+
+/* Same timebase as CPU counter (24MHz) */
+#define APPLE_DVFS_LAST_CHG_TIME	0x38
+
+/*
+ * Apple ran out of bits and had to shift this in T8112...
+ */
+#define APPLE_DVFS_STATUS			0x50
+#define APPLE_DVFS_STATUS_CUR_PS_T8103		GENMASK(7, 4)
+#define APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8103	4
+#define APPLE_DVFS_STATUS_TGT_PS_T8103		GENMASK(3, 0)
+#define APPLE_DVFS_STATUS_CUR_PS_T8112		GENMASK(9, 5)
+#define APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8112	5
+#define APPLE_DVFS_STATUS_TGT_PS_T8112		GENMASK(4, 0)
+
+/*
+ * Div is +1, base clock is 12MHz on existing SoCs.
+ * For documentation purposes. We use the OPP table to
+ * get the frequency.
+ */
+#define APPLE_DVFS_PLL_STATUS		0xc0
+#define APPLE_DVFS_PLL_FACTOR		0xc8
+#define APPLE_DVFS_PLL_FACTOR_MULT	GENMASK(31, 16)
+#define APPLE_DVFS_PLL_FACTOR_DIV	GENMASK(15, 0)
+
+#define APPLE_DVFS_TRANSITION_TIMEOUT 100
+
+struct apple_soc_cpufreq_info {
+	u64 max_pstate;
+	u64 cur_pstate_mask;
+	u64 cur_pstate_shift;
+};
+
+struct apple_cpu_priv {
+	struct device *cpu_dev;
+	void __iomem *reg_base;
+	const struct apple_soc_cpufreq_info *info;
+};
+
+static struct cpufreq_driver apple_soc_cpufreq_driver;
+
+static const struct apple_soc_cpufreq_info soc_t8103_info = {
+	.max_pstate = 15,
+	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8103,
+	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8103,
+};
+
+static const struct apple_soc_cpufreq_info soc_t8112_info = {
+	.max_pstate = 31,
+	.cur_pstate_mask = APPLE_DVFS_STATUS_CUR_PS_T8112,
+	.cur_pstate_shift = APPLE_DVFS_STATUS_CUR_PS_SHIFT_T8112,
+};
+
+static const struct apple_soc_cpufreq_info soc_default_info = {
+	.max_pstate = 15,
+	.cur_pstate_mask = 0, /* fallback */
+};
+
+static const struct of_device_id apple_soc_cpufreq_of_match[] = {
+	{
+		.compatible = "apple,t8103-cluster-cpufreq",
+		.data = &soc_t8103_info,
+	},
+	{
+		.compatible = "apple,t8112-cluster-cpufreq",
+		.data = &soc_t8112_info,
+	},
+	{
+		.compatible = "apple,cluster-cpufreq",
+		.data = &soc_default_info,
+	},
+	{}
+};
+
+static unsigned int apple_soc_cpufreq_get_rate(unsigned int cpu)
+{
+	struct cpufreq_policy *policy = cpufreq_cpu_get_raw(cpu);
+	struct apple_cpu_priv *priv = policy->driver_data;
+	struct cpufreq_frequency_table *p;
+	unsigned int pstate;
+
+	if (priv->info->cur_pstate_mask) {
+		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_STATUS);
+
+		pstate = (reg & priv->info->cur_pstate_mask) >>  priv->info->cur_pstate_shift;
+	} else {
+		/*
+		 * For the fallback case we might not know the layout of DVFS_STATUS,
+		 * so just use the command register value (which ignores boost limitations).
+		 */
+		u64 reg = readq_relaxed(priv->reg_base + APPLE_DVFS_CMD);
+
+		pstate = FIELD_GET(APPLE_DVFS_CMD_PS1, reg);
+	}
+
+	cpufreq_for_each_valid_entry(p, policy->freq_table)
+		if (p->driver_data == pstate)
+			return p->frequency;
+
+	dev_err(priv->cpu_dev, "could not find frequency for pstate %d\n",
+		pstate);
+	return 0;
+}
+
+static int apple_soc_cpufreq_set_target(struct cpufreq_policy *policy,
+					unsigned int index)
+{
+	struct apple_cpu_priv *priv = policy->driver_data;
+	unsigned int pstate = policy->freq_table[index].driver_data;
+	u64 reg;
+
+	/* Fallback for newer SoCs */
+	if (index > priv->info->max_pstate)
+		index = priv->info->max_pstate;
+
+	if (readq_poll_timeout_atomic(priv->reg_base + APPLE_DVFS_CMD, reg,
+				      !(reg & APPLE_DVFS_CMD_BUSY), 2,
+				      APPLE_DVFS_TRANSITION_TIMEOUT)) {
+		return -EIO;
+	}
+
+	reg &= ~(APPLE_DVFS_CMD_PS1 | APPLE_DVFS_CMD_PS2);
+	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS1, pstate);
+	reg |= FIELD_PREP(APPLE_DVFS_CMD_PS2, pstate);
+	reg |= APPLE_DVFS_CMD_SET;
+
+	writeq_relaxed(reg, priv->reg_base + APPLE_DVFS_CMD);
+
+	return 0;
+}
+
+static unsigned int apple_soc_cpufreq_fast_switch(struct cpufreq_policy *policy,
+						  unsigned int target_freq)
+{
+	if (apple_soc_cpufreq_set_target(policy, policy->cached_resolved_idx) < 0)
+		return 0;
+
+	return policy->freq_table[policy->cached_resolved_idx].frequency;
+}
+
+static int apple_soc_cpufreq_find_cluster(struct cpufreq_policy *policy,
+					  void __iomem **reg_base,
+					  const struct apple_soc_cpufreq_info **info)
+{
+	struct of_phandle_args args;
+	const struct of_device_id *match;
+	int ret = 0;
+
+	ret = of_perf_domain_get_sharing_cpumask(policy->cpu, "performance-domains",
+						 "#performance-domain-cells",
+						 policy->cpus, &args);
+	if (ret < 0)
+		return ret;
+
+	match = of_match_node(apple_soc_cpufreq_of_match, args.np);
+	of_node_put(args.np);
+	if (!match)
+		return -ENODEV;
+
+	*info = match->data;
+
+	*reg_base = of_iomap(args.np, 0);
+	if (IS_ERR(*reg_base))
+		return PTR_ERR(*reg_base);
+
+	return 0;
+}
+
+static struct freq_attr *apple_soc_cpufreq_hw_attr[] = {
+	&cpufreq_freq_attr_scaling_available_freqs,
+	NULL, /* Filled in below if boost is enabled */
+	NULL,
+};
+
+static int apple_soc_cpufreq_init(struct cpufreq_policy *policy)
+{
+	int ret, i;
+	unsigned int transition_latency;
+	void __iomem *reg_base;
+	struct device *cpu_dev;
+	struct apple_cpu_priv *priv;
+	const struct apple_soc_cpufreq_info *info;
+	struct cpufreq_frequency_table *freq_table;
+
+	cpu_dev = get_cpu_device(policy->cpu);
+	if (!cpu_dev) {
+		pr_err("failed to get cpu%d device\n", policy->cpu);
+		return -ENODEV;
+	}
+
+	ret = dev_pm_opp_of_add_table(cpu_dev);
+	if (ret < 0) {
+		dev_err(cpu_dev, "%s: failed to add OPP table: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = apple_soc_cpufreq_find_cluster(policy, &reg_base, &info);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to get cluster info: %d\n", __func__, ret);
+		return ret;
+	}
+
+	ret = dev_pm_opp_set_sharing_cpus(cpu_dev, policy->cpus);
+	if (ret) {
+		dev_err(cpu_dev, "%s: failed to mark OPPs as shared: %d\n", __func__, ret);
+		goto out_iounmap;
+	}
+
+	ret = dev_pm_opp_get_opp_count(cpu_dev);
+	if (ret <= 0) {
+		dev_dbg(cpu_dev, "OPP table is not ready, deferring probe\n");
+		ret = -EPROBE_DEFER;
+		goto out_free_opp;
+	}
+
+	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
+	if (!priv) {
+		ret = -ENOMEM;
+		goto out_free_opp;
+	}
+
+	ret = dev_pm_opp_init_cpufreq_table(cpu_dev, &freq_table);
+	if (ret) {
+		dev_err(cpu_dev, "failed to init cpufreq table: %d\n", ret);
+		goto out_free_priv;
+	}
+
+	/* Get OPP levels (p-state indexes) and stash them in driver_data */
+	for (i = 0; freq_table[i].frequency != CPUFREQ_TABLE_END; i++) {
+		unsigned long rate = freq_table[i].frequency * 1000 + 999;
+		struct dev_pm_opp *opp = dev_pm_opp_find_freq_floor(cpu_dev, &rate);
+
+		if (IS_ERR(opp)) {
+			ret = PTR_ERR(opp);
+			goto out_free_cpufreq_table;
+		}
+		freq_table[i].driver_data = dev_pm_opp_get_level(opp);
+		dev_pm_opp_put(opp);
+	}
+
+	priv->cpu_dev = cpu_dev;
+	priv->reg_base = reg_base;
+	priv->info = info;
+	policy->driver_data = priv;
+	policy->freq_table = freq_table;
+
+	transition_latency = dev_pm_opp_get_max_transition_latency(cpu_dev);
+	if (!transition_latency)
+		transition_latency = CPUFREQ_ETERNAL;
+
+	policy->cpuinfo.transition_latency = transition_latency;
+	policy->dvfs_possible_from_any_cpu = true;
+	policy->fast_switch_possible = true;
+
+	if (policy_has_boost_freq(policy)) {
+		ret = cpufreq_enable_boost_support();
+		if (ret) {
+			dev_warn(cpu_dev, "failed to enable boost: %d\n", ret);
+		} else {
+			apple_soc_cpufreq_hw_attr[1] = &cpufreq_freq_attr_scaling_boost_freqs;
+			apple_soc_cpufreq_driver.boost_enabled = true;
+		}
+	}
+
+	return 0;
+
+out_free_cpufreq_table:
+	dev_pm_opp_free_cpufreq_table(cpu_dev, &freq_table);
+out_free_priv:
+	kfree(priv);
+out_free_opp:
+	dev_pm_opp_remove_all_dynamic(cpu_dev);
+out_iounmap:
+	iounmap(reg_base);
+	return ret;
+}
+
+static int apple_soc_cpufreq_exit(struct cpufreq_policy *policy)
+{
+	struct apple_cpu_priv *priv = policy->driver_data;
+
+	dev_pm_opp_free_cpufreq_table(priv->cpu_dev, &policy->freq_table);
+	dev_pm_opp_remove_all_dynamic(priv->cpu_dev);
+	iounmap(priv->reg_base);
+	kfree(priv);
+
+	return 0;
+}
+
+static struct cpufreq_driver apple_soc_cpufreq_driver = {
+	.name		= "apple-cpufreq",
+	.flags		= CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			  CPUFREQ_NEED_INITIAL_FREQ_CHECK | CPUFREQ_IS_COOLING_DEV,
+	.verify		= cpufreq_generic_frequency_table_verify,
+	.attr		= cpufreq_generic_attr,
+	.get		= apple_soc_cpufreq_get_rate,
+	.init		= apple_soc_cpufreq_init,
+	.exit		= apple_soc_cpufreq_exit,
+	.target_index	= apple_soc_cpufreq_set_target,
+	.fast_switch	= apple_soc_cpufreq_fast_switch,
+	.register_em	= cpufreq_register_em_with_opp,
+	.attr		= apple_soc_cpufreq_hw_attr,
+};
+
+static int __init apple_soc_cpufreq_module_init(void)
+{
+	if (!of_machine_is_compatible("apple,arm-platform"))
+		return -ENODEV;
+
+	return cpufreq_register_driver(&apple_soc_cpufreq_driver);
+}
+module_init(apple_soc_cpufreq_module_init);
+
+static void __exit apple_soc_cpufreq_module_exit(void)
+{
+	cpufreq_unregister_driver(&apple_soc_cpufreq_driver);
+}
+module_exit(apple_soc_cpufreq_module_exit);
+
+MODULE_DEVICE_TABLE(of, apple_soc_cpufreq_of_match);
+MODULE_AUTHOR("Hector Martin <marcan@marcan.st>");
+MODULE_DESCRIPTION("Apple SoC CPU cluster DVFS driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 85ee11f79840..8ab672883043 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,8 @@ static const struct of_device_id allowlist[] __initconst = {
 static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },
 
+	{ .compatible = "apple,arm-platform", },
+
 	{ .compatible = "arm,vexpress", },
 
 	{ .compatible = "calxeda,highbank", },
-- 
2.35.1

