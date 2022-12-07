Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E19645A97
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 14:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiLGNRp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 7 Dec 2022 08:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiLGNRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 08:17:37 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F91163;
        Wed,  7 Dec 2022 05:17:35 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 4AA2D24E2B0;
        Wed,  7 Dec 2022 21:17:34 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 7 Dec
 2022 21:17:34 +0800
Received: from williamqiu-virtual-machine.starfivetech.com (171.223.208.138)
 by EXMBX068.cuchost.com (172.16.6.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Wed, 7 Dec 2022 21:17:33 +0800
From:   William Qiu <william.qiu@starfivetech.com>
To:     <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        William Qiu <william.qiu@starfivetech.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/3] mmc: starfive: Add sdio/emmc driver support
Date:   Wed, 7 Dec 2022 21:17:30 +0800
Message-ID: <20221207131731.1291517-3-william.qiu@starfivetech.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221207131731.1291517-1-william.qiu@starfivetech.com>
References: <20221207131731.1291517-1-william.qiu@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX068.cuchost.com
 (172.16.6.68)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add sdio/emmc driver support for StarFive JH7110 soc.

Signed-off-by: William Qiu <william.qiu@starfivetech.com>
---
 MAINTAINERS                        |   6 +
 drivers/mmc/host/Kconfig           |  10 ++
 drivers/mmc/host/Makefile          |   1 +
 drivers/mmc/host/dw_mmc-starfive.c | 197 +++++++++++++++++++++++++++++
 4 files changed, 214 insertions(+)
 create mode 100644 drivers/mmc/host/dw_mmc-starfive.c

diff --git a/MAINTAINERS b/MAINTAINERS
index a70c1d0f303e..2b46ef07f5dc 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19623,6 +19623,12 @@ F:	Documentation/devicetree/bindings/reset/starfive,jh7100-reset.yaml
 F:	drivers/reset/starfive/
 F:	include/dt-bindings/reset/starfive*
 
+STARFIVE JH7110 MMC/SD/SDIO DRIVER
+M:	William Qiu <william.qiu@starfivetech.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/starfive*
+F:	drivers/mmc/dw_mmc-starfive.c
+
 STATIC BRANCH/CALL
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Josh Poimboeuf <jpoimboe@kernel.org>
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index fb1062a6394c..b87262503403 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -871,6 +871,16 @@ config MMC_DW_ROCKCHIP
 	  Synopsys DesignWare Memory Card Interface driver. Select this option
 	  for platforms based on RK3066, RK3188 and RK3288 SoC's.
 
+config MMC_DW_STARFIVE
+	tristate "StarFive specific extensions for Synopsys DW Memory Card Interface"
+	depends on SOC_STARFIVE
+	depends on MMC_DW
+	select MMC_DW_PLTFM
+	help
+	  This selects support for StarFive JH7110 SoC specific extensions to the
+	  Synopsys DesignWare Memory Card Interface driver. Select this option
+	  for platforms based on StarFive JH7110 SoC.
+
 config MMC_SH_MMCIF
 	tristate "SuperH Internal MMCIF support"
 	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
index 4e4ceb32c4b4..32c0e5564b9a 100644
--- a/drivers/mmc/host/Makefile
+++ b/drivers/mmc/host/Makefile
@@ -56,6 +56,7 @@ obj-$(CONFIG_MMC_DW_HI3798CV200) += dw_mmc-hi3798cv200.o
 obj-$(CONFIG_MMC_DW_K3)		+= dw_mmc-k3.o
 obj-$(CONFIG_MMC_DW_PCI)	+= dw_mmc-pci.o
 obj-$(CONFIG_MMC_DW_ROCKCHIP)	+= dw_mmc-rockchip.o
+obj-$(CONFIG_MMC_DW_STARFIVE)	+= dw_mmc-starfive.o
 obj-$(CONFIG_MMC_SH_MMCIF)	+= sh_mmcif.o
 obj-$(CONFIG_MMC_JZ4740)	+= jz4740_mmc.o
 obj-$(CONFIG_MMC_VUB300)	+= vub300.o
diff --git a/drivers/mmc/host/dw_mmc-starfive.c b/drivers/mmc/host/dw_mmc-starfive.c
new file mode 100644
index 000000000000..b2e6a0b6abf9
--- /dev/null
+++ b/drivers/mmc/host/dw_mmc-starfive.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * StarFive Designware Mobile Storage Host Controller Driver
+ *
+ * Copyright (c) 2022 StarFive Technology Co., Ltd.
+ */
+
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/mfd/syscon.h>
+#include <linux/mmc/host.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+
+#include "dw_mmc.h"
+#include "dw_mmc-pltfm.h"
+
+#define ALL_INT_CLR		0x1ffff
+#define MAX_DELAY_CHAIN		32
+
+struct starfive_priv {
+	struct device *dev;
+	struct regmap *reg_syscon;
+	u32 syscon_offset;
+	u32 syscon_shift;
+	u32 syscon_mask;
+};
+
+static unsigned long dw_mci_starfive_caps[] = {
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23,
+	MMC_CAP_CMD23
+};
+
+static void dw_mci_starfive_set_ios(struct dw_mci *host, struct mmc_ios *ios)
+{
+	int ret;
+	unsigned int clock;
+
+	if (ios->timing == MMC_TIMING_MMC_DDR52 || ios->timing == MMC_TIMING_UHS_DDR50) {
+		clock = (ios->clock > 50000000 && ios->clock <= 52000000) ? 100000000 : ios->clock;
+		ret = clk_set_rate(host->ciu_clk, clock);
+		if (ret)
+			dev_dbg(host->dev, "Use an external frequency divider %uHz\n", ios->clock);
+		host->bus_hz = clk_get_rate(host->ciu_clk);
+	} else {
+		dev_dbg(host->dev, "Using the internal divider\n");
+	}
+}
+
+static int dw_mci_starfive_execute_tuning(struct dw_mci_slot *slot,
+					     u32 opcode)
+{
+	static const int grade  = MAX_DELAY_CHAIN;
+	struct dw_mci *host = slot->host;
+	struct starfive_priv *priv = host->priv;
+	int raise_point = -1, fall_point = -1;
+	int err, prev_err = -1;
+	int found = 0;
+	int i;
+	u32 regval;
+
+	for (i = 0; i < grade; i++) {
+		regval = i << priv->syscon_shift;
+		err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
+						priv->syscon_mask, regval);
+		if (err)
+			return err;
+		mci_writel(host, RINTSTS, ALL_INT_CLR);
+
+		err = mmc_send_tuning(slot->mmc, opcode, NULL);
+		if (!err)
+			found = 1;
+
+		if (i > 0) {
+			if (err && !prev_err)
+				fall_point = i - 1;
+			if (!err && prev_err)
+				raise_point = i;
+		}
+
+		if (raise_point != -1 && fall_point != -1)
+			goto tuning_out;
+
+		prev_err = err;
+		err = 0;
+	}
+
+tuning_out:
+	if (found) {
+		if (raise_point == -1)
+			raise_point = 0;
+		if (fall_point == -1)
+			fall_point = grade - 1;
+		if (fall_point < raise_point) {
+			if ((raise_point + fall_point) >
+			    (grade - 1))
+				i = fall_point / 2;
+			else
+				i = (raise_point + grade - 1) / 2;
+		} else {
+			i = (raise_point + fall_point) / 2;
+		}
+
+		regval = i << priv->syscon_shift;
+		err = regmap_update_bits(priv->reg_syscon, priv->syscon_offset,
+						priv->syscon_mask, regval);
+		if (err)
+			return err;
+		mci_writel(host, RINTSTS, ALL_INT_CLR);
+
+		dev_dbg(host->dev, "Found valid delay chain! use it [delay=%d]\n", i);
+	} else {
+		dev_err(host->dev, "No valid delay chain! use default\n");
+		err = -EINVAL;
+	}
+
+	mci_writel(host, RINTSTS, ALL_INT_CLR);
+	return err;
+}
+
+static int dw_mci_starfive_parse_dt(struct dw_mci *host)
+{
+	struct of_phandle_args args;
+	struct starfive_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(host->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	ret = of_parse_phandle_with_fixed_args(host->dev->of_node,
+						"starfive,sys-syscon", 3, 0, &args);
+	if (ret) {
+		dev_err(host->dev, "Failed to parse starfive,sys-syscon\n");
+		return -EINVAL;
+	}
+
+	priv->reg_syscon = syscon_node_to_regmap(args.np);
+	of_node_put(args.np);
+	if (IS_ERR(priv->reg_syscon))
+		return PTR_ERR(priv->reg_syscon);
+
+	priv->syscon_offset = args.args[0];
+	priv->syscon_shift  = args.args[1];
+	priv->syscon_mask   = args.args[2];
+
+	host->priv = priv;
+
+	return 0;
+}
+
+static const struct dw_mci_drv_data starfive_data = {
+	.caps = dw_mci_starfive_caps,
+	.num_caps = ARRAY_SIZE(dw_mci_starfive_caps),
+	.set_ios = dw_mci_starfive_set_ios,
+	.parse_dt = dw_mci_starfive_parse_dt,
+	.execute_tuning = dw_mci_starfive_execute_tuning,
+};
+
+static const struct of_device_id dw_mci_starfive_match[] = {
+	{ .compatible = "starfive,jh7110-sdio",
+		.data = &starfive_data },
+	{},
+};
+MODULE_DEVICE_TABLE(of, dw_mci_starfive_match);
+
+static int dw_mci_starfive_probe(struct platform_device *pdev)
+{
+	return dw_mci_pltfm_register(pdev, &starfive_data);
+}
+
+static int dw_mci_starfive_remove(struct platform_device *pdev)
+{
+	return dw_mci_pltfm_remove(pdev);
+}
+
+static struct platform_driver dw_mci_starfive_driver = {
+	.probe = dw_mci_starfive_probe,
+	.remove = dw_mci_starfive_remove,
+	.driver = {
+		.name = "dwmmc_starfive",
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.of_match_table = dw_mci_starfive_match,
+	},
+};
+module_platform_driver(dw_mci_starfive_driver);
+
+MODULE_DESCRIPTION("StarFive JH7110 Specific DW-MSHC Driver Extension");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:dwmmc_starfive");
-- 
2.34.1

