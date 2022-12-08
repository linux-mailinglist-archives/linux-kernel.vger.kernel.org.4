Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4463A646A8C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 09:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiLHIac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 03:30:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiLHIaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 03:30:18 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997D660B4E;
        Thu,  8 Dec 2022 00:30:15 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0457224E289;
        Thu,  8 Dec 2022 16:30:09 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 16:30:08 +0800
Received: from localhost.localdomain (113.72.146.33) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 8 Dec
 2022 16:30:07 +0800
From:   Walker Chen <walker.chen@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Walker Chen <walker.chen@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] soc: starfive: Add StarFive JH71XX pmu driver
Date:   Thu, 8 Dec 2022 16:29:54 +0800
Message-ID: <20221208082955.10653-3-walker.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221208082955.10653-1-walker.chen@starfivetech.com>
References: <20221208082955.10653-1-walker.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.146.33]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pmu driver for the StarFive JH71XX SoC.

As the power domains provider, the Power Management Unit (PMU) is
designed for including multiple PM domains that can be used for power
gating of selected IP blocks for power saving by reduced leakage
current. It accepts software encourage command to switch the power mode
of SoC.

Signed-off-by: Walker Chen <walker.chen@starfivetech.com>
---
 MAINTAINERS                       |  14 ++
 drivers/soc/Kconfig               |   1 +
 drivers/soc/Makefile              |   1 +
 drivers/soc/starfive/Kconfig      |  11 +
 drivers/soc/starfive/Makefile     |   3 +
 drivers/soc/starfive/jh71xx_pmu.c | 396 ++++++++++++++++++++++++++++++
 6 files changed, 426 insertions(+)
 create mode 100644 drivers/soc/starfive/Kconfig
 create mode 100644 drivers/soc/starfive/Makefile
 create mode 100644 drivers/soc/starfive/jh71xx_pmu.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a70c1d0f303e..dbbc25a9f25b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19623,6 +19623,20 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
 F:	drivers/reset/starfive/
 F:	include/dt-bindings/reset/starfive*
 
+STARFIVE SOC DRIVER
+M:	Conor Dooley <conor@kernel.org>
+S:	Maintained
+T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
+F:	drivers/soc/starfive/
+F:	include/soc/starfive/
+
+STARFIVE JH71XX PMU CONTROLLER DRIVER
+M:	Walker Chen <walker.chen@starfivetech.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/power/starfive*
+F:	drivers/soc/starfive/jh71xx_pmu.c
+F:	include/dt-bindings/power/starfive,jh7110-pmu.h
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index e461c071189b..628fda4d5ed9 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -21,6 +21,7 @@ source "drivers/soc/renesas/Kconfig"
 source "drivers/soc/rockchip/Kconfig"
 source "drivers/soc/samsung/Kconfig"
 source "drivers/soc/sifive/Kconfig"
+source "drivers/soc/starfive/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
 source "drivers/soc/tegra/Kconfig"
 source "drivers/soc/ti/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 534669840858..cbe076f42068 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -27,6 +27,7 @@ obj-y				+= renesas/
 obj-y				+= rockchip/
 obj-$(CONFIG_SOC_SAMSUNG)	+= samsung/
 obj-y				+= sifive/
+obj-y				+= starfive/
 obj-y				+= sunxi/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
 obj-y				+= ti/
diff --git a/drivers/soc/starfive/Kconfig b/drivers/soc/starfive/Kconfig
new file mode 100644
index 000000000000..29d92df97421
--- /dev/null
+++ b/drivers/soc/starfive/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+config JH71XX_PMU
+	bool "Support PMU for StarFive JH71XX Soc"
+	depends on PM && (SOC_STARFIVE || COMPILE_TEST)
+	default SOC_STARFIVE
+	select PM_GENERIC_DOMAINS
+	help
+	  Say 'y' here to enable support power domain support.
+	  In order to meet low power requirements, a Power Management Unit (PMU)
+	  is designed for controlling power resources in StarFive JH71XX SoCs.
diff --git a/drivers/soc/starfive/Makefile b/drivers/soc/starfive/Makefile
new file mode 100644
index 000000000000..13b589d6b5f3
--- /dev/null
+++ b/drivers/soc/starfive/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_JH71XX_PMU)	+= jh71xx_pmu.o
diff --git a/drivers/soc/starfive/jh71xx_pmu.c b/drivers/soc/starfive/jh71xx_pmu.c
new file mode 100644
index 000000000000..7a0145779e07
--- /dev/null
+++ b/drivers/soc/starfive/jh71xx_pmu.c
@@ -0,0 +1,396 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * StarFive JH71XX PMU (Power Management Unit) Controller Driver
+ *
+ * Copyright (C) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <dt-bindings/power/starfive,jh7110-pmu.h>
+
+/* register offset */
+#define JH71XX_PMU_HW_EVENT_ON		0x04
+#define JH71XX_PMU_HW_EVENT_OFF		0x08
+#define JH71XX_PMU_SW_TURN_ON_POWER	0x0C
+#define JH71XX_PMU_SW_TURN_OFF_POWER	0x10
+#define JH71XX_PMU_SW_ENCOURAGE		0x44
+#define JH71XX_PMU_INT_MASK		0x48
+#define JH71XX_PMU_PCH_BYPASS		0x4C
+#define JH71XX_PMU_PCH_PSTATE		0x50
+#define JH71XX_PMU_PCH_TIMEOUT		0x54
+#define JH71XX_PMU_LP_TIMEOUT		0x58
+#define JH71XX_PMU_HW_TURN_ON		0x5C
+#define JH71XX_PMU_CURR_POWER_MODE	0x80
+#define JH71XX_PMU_EVENT_STATUS		0x88
+#define JH71XX_PMU_INT_STATUS		0x8C
+
+/* sw encourage cfg */
+#define JH71XX_PMU_SW_ENCOURAGE_EN_LO	0x05
+#define JH71XX_PMU_SW_ENCOURAGE_EN_HI	0x50
+#define JH71XX_PMU_SW_ENCOURAGE_DIS_LO	0x0A
+#define JH71XX_PMU_SW_ENCOURAGE_DIS_HI	0xA0
+#define JH71XX_PMU_SW_ENCOURAGE_ON	0xFF
+
+/* pmu int status */
+#define JH71XX_PMU_INT_SEQ_DONE		BIT(0)
+#define JH71XX_PMU_INT_HW_REQ		BIT(1)
+#define JH71XX_PMU_INT_SW_FAIL		GENMASK(3, 2)
+#define JH71XX_PMU_INT_HW_FAIL		GENMASK(5, 4)
+#define JH71XX_PMU_INT_PCH_FAIL		GENMASK(8, 6)
+#define JH71XX_PMU_INT_FAIL_MASK	(JH71XX_PMU_INT_SW_FAIL | \
+					JH71XX_PMU_INT_HW_FAIL | \
+					JH71XX_PMU_INT_PCH_FAIL)
+#define JH71XX_PMU_INT_ALL_MASK		(JH71XX_PMU_INT_SEQ_DONE | \
+					JH71XX_PMU_INT_HW_REQ | \
+					JH71XX_PMU_INT_FAIL_MASK)
+
+/*
+ * The time required for switching power status is based on the time
+ * to turn on the largest domain's power, which is at microsecond level
+ */
+#define JH71XX_PMU_TIMEOUT_US		100
+
+struct jh71xx_domain_info {
+	const char * const name;
+	u8 bit;
+	unsigned int flags;
+};
+
+struct jh71xx_pmu_match_data {
+	int num_domains;
+	const struct jh71xx_domain_info *domain_info;
+};
+
+struct jh71xx_pmu {
+	struct device *dev;
+	const struct jh71xx_pmu_match_data *match_data;
+	void __iomem *base;
+	spinlock_t lock;	/* protects pmu reg */
+	int irq;
+	struct genpd_onecell_data genpd_data;
+	struct generic_pm_domain **genpd;
+};
+
+struct jh71xx_pmu_dev {
+	struct generic_pm_domain genpd;
+	const struct jh71xx_domain_info *domain_info;
+	struct jh71xx_pmu *pmu;
+};
+
+static int jh71xx_pmu_get_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool *is_on)
+{
+	struct jh71xx_pmu *pmu = pmd->pmu;
+
+	if (!mask) {
+		*is_on = false;
+		return -EINVAL;
+	}
+
+	*is_on = readl(pmu->base + JH71XX_PMU_CURR_POWER_MODE) & mask;
+
+	return 0;
+}
+
+static int jh71xx_pmu_set_state(struct jh71xx_pmu_dev *pmd, u32 mask, bool on)
+{
+	struct jh71xx_pmu *pmu = pmd->pmu;
+	unsigned long flags;
+	u32 val;
+	u32 mode;
+	u32 encourage_lo;
+	u32 encourage_hi;
+	bool is_on;
+	int ret;
+
+	ret = jh71xx_pmu_get_state(pmd, mask, &is_on);
+	if (ret) {
+		dev_dbg(pmu->dev, "unable to get current state for %s\n",
+			pmd->genpd.name);
+		return ret;
+	}
+
+	if (is_on == on) {
+		dev_dbg(pmu->dev, "pm domain [%s] is already %sable status.\n",
+			pmd->genpd.name, on ? "en" : "dis");
+		return 0;
+	}
+
+	spin_lock_irqsave(&pmu->lock, flags);
+
+	/*
+	 * The PMU accepts software encourage to switch power mode in the following 2 steps:
+	 *
+	 * 1. Configure the register SW_TURN_ON_POWER (offset 0x0c), write 1 to
+	 *    the bit which power domain will be turn-on, write 0 to the others.
+	 *    Likewise, configure the register SW_TURN_OFF_POWER (offset 0x10),
+	 *    write 1 to the bit which power domain will be turn-off, write 0 to the others.
+	 */
+	if (on) {
+		mode = JH71XX_PMU_SW_TURN_ON_POWER;
+		encourage_lo = JH71XX_PMU_SW_ENCOURAGE_EN_LO;
+		encourage_hi = JH71XX_PMU_SW_ENCOURAGE_EN_HI;
+	} else {
+		mode = JH71XX_PMU_SW_TURN_OFF_POWER;
+		encourage_lo = JH71XX_PMU_SW_ENCOURAGE_DIS_LO;
+		encourage_hi = JH71XX_PMU_SW_ENCOURAGE_DIS_HI;
+	}
+
+	writel(mask, pmu->base + mode);
+
+	/*
+	 * 2. Write SW encourage command sequence to the Software Encourage Reg (offset 0x44)
+	 * SW turn-on command sequence: 0xff -> 0x05 -> 0x50
+	 * SW turn-off command sequence: 0xff -> 0x0a -> 0xa0
+	 *
+	 * Note: writing SW_MODE_ENCOURAGE_ON (0xFF) to the SW_ENCOURAGE register,
+	 * the purpose is to reset the state machine which is going to parse instruction
+	 *  sequence. It has to be written every time.
+	 */
+	writel(JH71XX_PMU_SW_ENCOURAGE_ON, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
+	writel(encourage_lo, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
+	writel(encourage_hi, pmu->base + JH71XX_PMU_SW_ENCOURAGE);
+
+	spin_unlock_irqrestore(&pmu->lock, flags);
+
+	/* Wait for the power domain bit to be enabled / disabled */
+	if (on) {
+		ret = readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MODE,
+						val, val & mask,
+						1, JH71XX_PMU_TIMEOUT_US);
+	} else {
+		ret = readl_poll_timeout_atomic(pmu->base + JH71XX_PMU_CURR_POWER_MODE,
+						val, !(val & mask),
+						1, JH71XX_PMU_TIMEOUT_US);
+	}
+
+	if (ret) {
+		dev_err(pmu->dev, "%s: failed to power %s\n",
+			pmd->genpd.name, on ? "on" : "off");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int jh71xx_pmu_on(struct generic_pm_domain *genpd)
+{
+	struct jh71xx_pmu_dev *pmd = container_of(genpd,
+						  struct jh71xx_pmu_dev, genpd);
+	u32 pwr_mask = BIT(pmd->domain_info->bit);
+
+	return jh71xx_pmu_set_state(pmd, pwr_mask, true);
+}
+
+static int jh71xx_pmu_off(struct generic_pm_domain *genpd)
+{
+	struct jh71xx_pmu_dev *pmd = container_of(genpd,
+						  struct jh71xx_pmu_dev, genpd);
+	u32 pwr_mask = BIT(pmd->domain_info->bit);
+
+	return jh71xx_pmu_set_state(pmd, pwr_mask, false);
+}
+
+static void jh71xx_pmu_int_enable(struct jh71xx_pmu *pmu, u32 mask, bool enable)
+{
+	u32 val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&pmu->lock, flags);
+	val = readl(pmu->base + JH71XX_PMU_INT_MASK);
+
+	if (enable)
+		val &= ~mask;
+	else
+		val |= mask;
+
+	writel(val, pmu->base + JH71XX_PMU_INT_MASK);
+	spin_unlock_irqrestore(&pmu->lock, flags);
+}
+
+static irqreturn_t jh71xx_pmu_interrupt(int irq, void *data)
+{
+	struct jh71xx_pmu *pmu = data;
+	u32 val;
+
+	val = readl(pmu->base + JH71XX_PMU_INT_STATUS);
+
+	if (val & JH71XX_PMU_INT_SEQ_DONE)
+		dev_dbg(pmu->dev, "sequence done.\n");
+	if (val & JH71XX_PMU_INT_HW_REQ)
+		dev_dbg(pmu->dev, "hardware encourage requestion.\n");
+	if (val & JH71XX_PMU_INT_SW_FAIL)
+		dev_err(pmu->dev, "software encourage fail.\n");
+	if (val & JH71XX_PMU_INT_HW_FAIL)
+		dev_err(pmu->dev, "hardware encourage fail.\n");
+	if (val & JH71XX_PMU_INT_PCH_FAIL)
+		dev_err(pmu->dev, "p-channel fail event.\n");
+
+	/* clear interrupts */
+	writel(val, pmu->base + JH71XX_PMU_INT_STATUS);
+	writel(val, pmu->base + JH71XX_PMU_EVENT_STATUS);
+
+	return IRQ_HANDLED;
+}
+
+static int jh71xx_pmu_init_domain(struct jh71xx_pmu *pmu, int index)
+{
+	struct jh71xx_pmu_dev *pmd;
+	bool is_on;
+	u32 pwr_mask;
+	int ret;
+
+	pmd = devm_kzalloc(pmu->dev, sizeof(*pmd), GFP_KERNEL);
+	if (!pmd)
+		return -ENOMEM;
+
+	pmd->domain_info = &pmu->match_data->domain_info[index];
+	pmd->pmu = pmu;
+	pwr_mask = BIT(pmd->domain_info->bit);
+
+	pmd->genpd.name = pmd->domain_info->name;
+	pmd->genpd.flags = pmd->domain_info->flags;
+
+	ret = jh71xx_pmu_get_state(pmd, pwr_mask, &is_on);
+	if (ret)
+		dev_warn(pmu->dev, "unable to get current state for %s\n",
+			 pmd->genpd.name);
+
+	pmd->genpd.power_on = jh71xx_pmu_on;
+	pmd->genpd.power_off = jh71xx_pmu_off;
+	pm_genpd_init(&pmd->genpd, NULL, !is_on);
+
+	pmu->genpd_data.domains[index] = &pmd->genpd;
+
+	return 0;
+}
+
+static int jh71xx_pmu_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct jh71xx_pmu_match_data *match_data;
+	struct jh71xx_pmu *pmu;
+	unsigned int i;
+	int ret;
+
+	pmu = devm_kzalloc(dev, sizeof(*pmu), GFP_KERNEL);
+	if (!pmu)
+		return -ENOMEM;
+
+	pmu->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(pmu->base))
+		return PTR_ERR(pmu->base);
+
+	/* initialize pmu interrupt  */
+	pmu->irq = platform_get_irq(pdev, 0);
+	if (pmu->irq < 0)
+		return pmu->irq;
+
+	ret = devm_request_irq(dev, pmu->irq, jh71xx_pmu_interrupt,
+			       0, pdev->name, pmu);
+	if (ret)
+		dev_err(dev, "request irq failed.\n");
+
+	match_data = of_device_get_match_data(dev);
+	if (!match_data)
+		return -EINVAL;
+
+	pmu->genpd = devm_kcalloc(dev, match_data->num_domains,
+				  sizeof(struct generic_pm_domain *),
+				  GFP_KERNEL);
+	if (!pmu->genpd)
+		return -ENOMEM;
+
+	pmu->dev = dev;
+	pmu->match_data = match_data;
+	pmu->genpd_data.domains = pmu->genpd;
+	pmu->genpd_data.num_domains = match_data->num_domains;
+
+	for (i = 0; i < match_data->num_domains; i++) {
+		ret = jh71xx_pmu_init_domain(pmu, i);
+		if (ret) {
+			dev_err(dev, "failed to initialize power domain\n");
+			return ret;
+		}
+	}
+
+	spin_lock_init(&pmu->lock);
+	jh71xx_pmu_int_enable(pmu, JH71XX_PMU_INT_ALL_MASK & ~JH71XX_PMU_INT_PCH_FAIL, true);
+
+	ret = of_genpd_add_provider_onecell(np, &pmu->genpd_data);
+	if (ret) {
+		dev_err(dev, "failed to register genpd driver: %d\n", ret);
+		return ret;
+	}
+
+	dev_info(dev, "registered %u power domains\n", i);
+
+	return 0;
+}
+
+static const struct jh71xx_domain_info jh7110_power_domains[] = {
+	[JH7110_PD_SYSTOP] = {
+		.name = "SYSTOP",
+		.bit = 0,
+		.flags = GENPD_FLAG_ALWAYS_ON,
+	},
+	[JH7110_PD_CPU] = {
+		.name = "CPU",
+		.bit = 1,
+		.flags = GENPD_FLAG_ALWAYS_ON,
+	},
+	[JH7110_PD_GPUA] = {
+		.name = "GPUA",
+		.bit = 2,
+	},
+	[JH7110_PD_VDEC] = {
+		.name = "VDEC",
+		.bit = 3,
+	},
+	[JH7110_PD_VOUT] = {
+		.name = "VOUT",
+		.bit = 4,
+	},
+	[JH7110_PD_ISP] = {
+		.name = "ISP",
+		.bit = 5,
+	},
+	[JH7110_PD_VENC] = {
+		.name = "VENC",
+		.bit = 6,
+	},
+};
+
+static const struct jh71xx_pmu_match_data jh7110_pmu = {
+	.num_domains = ARRAY_SIZE(jh7110_power_domains),
+	.domain_info = jh7110_power_domains,
+};
+
+static const struct of_device_id jh71xx_pmu_of_match[] = {
+	{
+		.compatible = "starfive,jh7110-pmu",
+		.data = (void *)&jh7110_pmu,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver jh71xx_pmu_driver = {
+	.driver = {
+		.name = "jh71xx-pmu",
+		.of_match_table = jh71xx_pmu_of_match,
+	},
+	.probe  = jh71xx_pmu_probe,
+};
+builtin_platform_driver(jh71xx_pmu_driver);
+
+MODULE_AUTHOR("Walker Chen <walker.chen@starfivetech.com>");
+MODULE_DESCRIPTION("StarFive JH71XX PMU Driver");
+MODULE_LICENSE("GPL");
-- 
2.17.1

