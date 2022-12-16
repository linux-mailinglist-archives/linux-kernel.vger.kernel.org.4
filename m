Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664E64ED0B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 15:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbiLPOil (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 09:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiLPOiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 09:38:01 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8516E5EDF6;
        Fri, 16 Dec 2022 06:37:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671201455; x=1702737455;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=J0mdrmfLxlHEcCr5e4Fi4cUVYAJmnyZqi9HwlYY6NOw=;
  b=MZFcg2NuTtzlJ7wgkNDlY5EcyC+YxmS5/JjF6jqIW/MSXUIbUfnFR/aP
   tHN7XdjPc1zmaNyeRZ1G/tqn7HIZgU5coG+KEsTr74jiNqtAkRqvePktK
   xDOz/K6K1xpVAECBxjxsjML9I5hur7m8CE8H3rVcrKnIFAeLQQ25UM/xI
   fhlC2iqhksHq9L2CDBVQ1MUSOSjhnPSql5A1yViJToV372zM2uZE4eVmm
   egX70rVC534xpvQfrJRPbTAV45Bqc11gl1139GGJhDuSPA1wu6nYTSxKT
   TvTGa3HQtNowOyUBPJce9v0qQI817JFHsw/1vUxKkWn3RJ9e+a3i2yELc
   w==;
X-IronPort-AV: E=Sophos;i="5.96,249,1665471600"; 
   d="scan'208";a="193386527"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Dec 2022 07:37:34 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Fri, 16 Dec 2022 07:37:33 -0700
Received: from ROB-ULT-M18282.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Fri, 16 Dec 2022 07:37:31 -0700
From:   Eugen Hristev <eugen.hristev@microchip.com>
To:     <linux-media@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <luis.oliveira@synopsys.com>,
        Luis Oliveira <Luis.Oliveira@synopsys.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [PATCH v5 4/4] media: platform: dwc: Add DW MIPI DPHY Rx driver
Date:   Fri, 16 Dec 2022 16:37:17 +0200
Message-ID: <20221216143717.1002015-5-eugen.hristev@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221216143717.1002015-1-eugen.hristev@microchip.com>
References: <20221216143717.1002015-1-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Luis Oliveira <Luis.Oliveira@synopsys.com>

Add of Synopsys MIPI D-PHY in RX mode support.
Separated in the implementation are platform dependent probing functions.

Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
[eugen.hristev@microchip.com: add stop state check :
After coming out of reset, the PHY must have the lanes in stop state.
Wait for stop state to be active, and if it's not, print out a message.]
Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
[luis.oliveira@synopsys.com: Add platform data support to D-Phy]
Signed-off-by: Luis Oliveira <luis.oliveira@synopsys.com>
---
 MAINTAINERS                                |   2 +
 drivers/media/platform/dwc/Kconfig         |  24 +-
 drivers/media/platform/dwc/Makefile        |   6 +
 drivers/media/platform/dwc/dw-dphy-plat.c  | 224 ++++++++
 drivers/media/platform/dwc/dw-dphy-rx.c    | 625 +++++++++++++++++++++
 drivers/media/platform/dwc/dw-dphy-rx.h    | 212 +++++++
 drivers/media/platform/dwc/dw-dphy-sysfs.c | 232 ++++++++
 include/media/dwc/dw-dphy-data.h           |  32 ++
 8 files changed, 1356 insertions(+), 1 deletion(-)
 create mode 100644 drivers/media/platform/dwc/dw-dphy-plat.c
 create mode 100644 drivers/media/platform/dwc/dw-dphy-rx.c
 create mode 100644 drivers/media/platform/dwc/dw-dphy-rx.h
 create mode 100644 drivers/media/platform/dwc/dw-dphy-sysfs.c
 create mode 100644 include/media/dwc/dw-dphy-data.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a425dcb734db..2fc3c4d39c8d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20133,7 +20133,9 @@ S:	Maintained
 T:	git git://linuxtv.org/media_tree.git
 F:	drivers/media/platform/dwc
 F:	Documentation/devicetree/bindings/media/snps,dw-csi.yaml
+F:	Documentation/devicetree/bindings/phy/snps,dw-dphy-rx.txt
 F:	include/media/dwc/dw-csi-data.h
+F:	include/media/dwc/dw-dphy-data.h
 
 SYNOPSYS DESIGNWARE DMAC DRIVER
 M:	Viresh Kumar <vireshk@kernel.org>
diff --git a/drivers/media/platform/dwc/Kconfig b/drivers/media/platform/dwc/Kconfig
index 508ac216e29d..b42219df2418 100644
--- a/drivers/media/platform/dwc/Kconfig
+++ b/drivers/media/platform/dwc/Kconfig
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 #
 #  Synopsys DWC Platform drivers
-#	Drivers here are currently for MIPI CSI-2 support
+#	Drivers here are currently for MIPI CSI-2 and MIPI DPHY support
 
 config DWC_MIPI_CSI2_HOST
 	tristate "Synopsys DesignWare CSI-2 Host Controller support"
@@ -17,3 +17,25 @@ config DWC_MIPI_CSI2_HOST
 	  If you have a controller with this interface, say Y.
 
 	   If unsure, say N.
+
+config DWC_MIPI_DPHY_GEN3
+	tristate "DesignWare platform support using a Gen3 D-PHY"
+	select GENERIC_PHY
+	help
+	 Synopsys MIPI D-PHY Generation 3 reference driver. This driver supports
+	 all Generation 3 D-PHYs. Choose Y or M if you have a platform with this
+	 block.
+
+	  If unsure, say N.
+
+if DWC_MIPI_DPHY_GEN3
+
+config DWC_MIPI_TC_DPHY_GEN3
+	bool "Platform support using a Synopsys Test Chip"
+	help
+	 Synopsys Test Chip is for prototyping purposes. This enables extra
+	 features that exist only in prototyping and/or for debug purposes.
+
+	  If unsure, say N.
+
+endif # DWC_MIPI_DPHY_GEN3
diff --git a/drivers/media/platform/dwc/Makefile b/drivers/media/platform/dwc/Makefile
index 057f137b733c..9af4dfb92e12 100644
--- a/drivers/media/platform/dwc/Makefile
+++ b/drivers/media/platform/dwc/Makefile
@@ -7,3 +7,9 @@ ifeq ($(CONFIG_DWC_MIPI_TC_DPHY_GEN3),y)
 	dw-csi-objs += dw-csi-sysfs.o
 endif
 obj-$(CONFIG_DWC_MIPI_CSI2_HOST) += dw-csi.o
+
+dw-dphy-objs := dw-dphy-plat.o dw-dphy-rx.o
+ifeq ($(CONFIG_DWC_MIPI_TC_DPHY_GEN3),y)
+	dw-dphy-objs += dw-dphy-sysfs.o
+endif
+obj-$(CONFIG_DWC_MIPI_DPHY_GEN3) += dw-dphy.o
diff --git a/drivers/media/platform/dwc/dw-dphy-plat.c b/drivers/media/platform/dwc/dw-dphy-plat.c
new file mode 100644
index 000000000000..34d9caf957d0
--- /dev/null
+++ b/drivers/media/platform/dwc/dw-dphy-plat.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Synopsys DesignWare MIPI D-PHY controller driver.
+ * Platform driver
+ *
+ * Author: Luis Oliveira <luis.oliveira@synopsys.com>
+ */
+
+#include <media/dwc/dw-dphy-data.h>
+#include <media/dwc/dw-csi-data.h>
+
+#include "dw-dphy-rx.h"
+
+static struct phy_ops dw_dphy_ops = {
+	.init = dw_dphy_init,
+	.reset = dw_dphy_reset,
+	.power_on = dw_dphy_power_on,
+	.power_off = dw_dphy_power_off,
+	.owner = THIS_MODULE,
+};
+
+static struct phy_provider *phy_provider;
+
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+static u8 get_config_8l(struct device *dev, struct dw_dphy_rx *dphy)
+{
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		dphy->config_8l = of_get_gpio(dev->of_node, 0);
+		if (!gpio_is_valid(dphy->config_8l)) {
+			dev_warn(dev,
+				 "failed to parse 8l config, default is 0\n");
+			dphy->config_8l = 0;
+		}
+	} else {
+		struct dw_phy_pdata *pdata = dev->platform_data;
+
+		dphy->config_8l = pdata->config_8l;
+	}
+	return dphy->config_8l;
+}
+#endif
+static int get_resources(struct device *dev, struct dw_dphy_rx *dphy)
+{
+	int ret = 0;
+
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		if (of_property_read_u32(dev->of_node, "snps,dphy-frequency",
+					 &dphy->dphy_freq)) {
+			dev_err(dev, "failed to find dphy frequency\n");
+			ret = -EINVAL;
+		}
+		if (of_property_read_u32(dev->of_node, "bus-width",
+					 &dphy->dphy_te_len)) {
+			dev_err(dev, "failed to find dphy te length\n");
+			ret = -EINVAL;
+		}
+		if (of_property_read_u32(dev->of_node, "snps,phy_type",
+					 &dphy->phy_type)) {
+			dev_err(dev, "failed to find dphy type\n");
+			ret = -EINVAL;
+		}
+	} else {
+		struct dw_phy_pdata *pdata = dev->platform_data;
+
+		dphy->dphy_freq = pdata->dphy_frequency;
+		dphy->dphy_te_len = pdata->dphy_te_len;
+		dphy->dphy_gen = pdata->dphy_gen;
+	}
+	dev_set_drvdata(dev, dphy);
+
+	return ret;
+}
+
+static int phy_register(struct device *dev)
+{
+	int ret = 0;
+
+	if (IS_ENABLED(CONFIG_OF) && dev->of_node) {
+		phy_provider = devm_of_phy_provider_register(dev,
+							     dw_dphy_xlate);
+		if (IS_ERR(phy_provider)) {
+			dev_err(dev, "error getting phy provider\n");
+			ret = PTR_ERR(phy_provider);
+		}
+	} else {
+		struct dw_phy_pdata *pdata = dev->platform_data;
+		struct dw_dphy_rx *dphy = dev_get_drvdata(dev);
+
+		ret = phy_create_lookup(dphy->phy,
+					phys[pdata->id].name,
+					csis[pdata->id].name);
+		if (ret)
+			dev_err(dev, "Failed to create dphy lookup\n");
+		else
+			dev_warn(dev,
+				 "Created dphy lookup [%s] --> [%s]\n",
+				 phys[pdata->id].name, csis[pdata->id].name);
+	}
+	return ret;
+}
+
+static void phy_unregister(struct device *dev)
+{
+	if (!dev->of_node) {
+		struct dw_dphy_rx *dphy = dev_get_drvdata(dev);
+
+		phy_remove_lookup(dphy->phy, "dw-dphy", "dw-csi");
+	}
+}
+
+static int dw_dphy_rx_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_dphy_rx *dphy;
+	struct resource *res;
+
+	dphy = devm_kzalloc(&pdev->dev, sizeof(*dphy), GFP_KERNEL);
+	if (!dphy)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dphy->base_address = devm_ioremap(&pdev->dev,
+					  res->start, resource_size(res));
+	if (IS_ERR(dphy->base_address)) {
+		dev_err(&pdev->dev, "error requesting base address\n");
+		return PTR_ERR(dphy->base_address);
+	}
+
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+
+	dphy->dphy1_if_addr = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dphy->dphy1_if_addr)) {
+		dev_err(&pdev->dev, "error requesting dphy 1 if regbank\n");
+		return PTR_ERR(dphy->dphy1_if_addr);
+	}
+
+	dphy->max_lanes =
+		dw_dphy_if_read_msk(dphy, DPHYID, DPHY_ID_LANE_SUPPORT, 4);
+
+	dphy->dphy_gen = dw_dphy_if_read_msk(dphy, DPHYID, DPHY_ID_GEN, 4);
+
+	dev_info(&pdev->dev, "DPHY GEN %s with maximum %s lanes\n",
+		 dphy->dphy_gen == GEN3 ? "3" : "2",
+		 dphy->max_lanes == CTRL_8_LANES ? "8" : "4");
+
+	if (dphy->max_lanes == CTRL_8_LANES) {
+		res = platform_get_resource(pdev, IORESOURCE_MEM, 2);
+		dphy->dphy2_if_addr =
+			devm_ioremap(&pdev->dev,
+				     res->start, resource_size(res));
+
+		if (IS_ERR(dphy->dphy2_if_addr)) {
+			dev_err(&pdev->dev,
+				"error requesting dphy 2 if regbank\n");
+			return PTR_ERR(dphy->dphy2_if_addr);
+		}
+		dphy->config_8l = get_config_8l(&pdev->dev, dphy);
+	}
+#endif
+	if (get_resources(dev, dphy)) {
+		dev_err(dev, "failed to parse PHY resources\n");
+		return -EINVAL;
+	}
+
+	dphy->phy = devm_phy_create(dev, NULL, &dw_dphy_ops);
+	if (IS_ERR(dphy->phy)) {
+		dev_err(dev, "failed to create PHY\n");
+		return PTR_ERR(dphy->phy);
+	}
+
+	platform_set_drvdata(pdev, dphy);
+	phy_set_drvdata(dphy->phy, dphy);
+
+	if (phy_register(dev)) {
+		dev_err(dev, "failed to register PHY\n");
+		return -EINVAL;
+	}
+
+	dphy->lp_time = 1000; /* 1000 ns */
+	dphy->lanes_config = dw_dphy_setup_config(dphy);
+
+	dev_info(dev, "Probing dphy finished\n");
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+	dw_dphy_create_capabilities_sysfs(pdev);
+#endif
+
+	return 0;
+}
+
+static int dw_dphy_rx_remove(struct platform_device *pdev)
+{
+	phy_unregister(&pdev->dev);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_OF)
+static const struct of_device_id dw_dphy_rx_of_match[] = {
+	{ .compatible = "snps,dw-dphy-rx" },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, dw_dphy_rx_of_match);
+#endif
+
+static struct platform_driver dw_dphy_rx_driver = {
+	.probe = dw_dphy_rx_probe,
+	.remove = dw_dphy_rx_remove,
+	.driver = {
+#if IS_ENABLED(CONFIG_OF)
+		.of_match_table = of_match_ptr(dw_dphy_rx_of_match),
+#endif
+		.name = "dw-dphy",
+		.owner = THIS_MODULE,
+	}
+};
+module_platform_driver(dw_dphy_rx_driver);
+
+MODULE_DESCRIPTION("Synopsys DesignWare MIPI DPHY Rx driver");
+MODULE_AUTHOR("Luis Oliveira <lolivei@synopsys.com>");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/media/platform/dwc/dw-dphy-rx.c b/drivers/media/platform/dwc/dw-dphy-rx.c
new file mode 100644
index 000000000000..1dd0d81feb61
--- /dev/null
+++ b/drivers/media/platform/dwc/dw-dphy-rx.c
@@ -0,0 +1,625 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Synopsys DesignWare MIPI D-PHY controller driver
+ * Core functions
+ *
+ * Author: Luis Oliveira <luis.oliveira@synopsys.com>
+ */
+
+#include "dw-dphy-rx.h"
+
+struct range_dphy_gen2 {
+	u32 freq;
+	u8 hsfregrange;
+};
+
+struct range_dphy_gen2 range_gen2[] = {
+	{ 80, 0x00 }, { 90, 0x10 }, { 100, 0x20 }, { 110, 0x30 },
+	{ 120, 0x01 }, { 130, 0x11 }, { 140, 0x21 }, { 150, 0x31 },
+	{ 160, 0x02 }, { 170, 0x12 }, { 180, 0x22 }, { 190, 0x32 },
+	{ 205, 0x03 }, { 220, 0x13 }, { 235, 0x23 }, { 250, 0x33 },
+	{ 275, 0x04 }, { 300, 0x14 }, { 325, 0x05 }, { 350, 0x15 },
+	{ 400, 0x25 }, { 450, 0x06 }, { 500, 0x16 }, { 550, 0x07 },
+	{ 600, 0x17 }, { 650, 0x08 }, { 700, 0x18 }, { 750, 0x09 },
+	{ 800, 0x19 }, { 850, 0x29 }, { 900, 0x39 }, { 950, 0x0A },
+	{ 1000, 0x1A }, { 1050, 0x2A }, { 1100, 0x3A }, { 1150, 0x0B },
+	{ 1200, 0x1B }, { 1250, 0x2B }, { 1300, 0x3B }, { 1350, 0x0C },
+	{ 1400, 0x1C }, { 1450, 0x2C }, { 1500, 0x3C }, { 1550, 0x0D },
+	{ 1600, 0x1D }, { 1650, 0x2D }, { 1700, 0x0E }, { 1750, 0x1E },
+	{ 1800, 0x2E }, { 1850, 0x3E }, { 1900, 0x0F }, { 1950, 0x1F },
+	{ 2000, 0x2F },
+};
+
+struct range_dphy_gen3 {
+	u32 freq;
+	u8 hsfregrange;
+	u32 osc_freq_target;
+};
+
+struct range_dphy_gen3 range_gen3[] = {
+	{ 80, 0x00, 0x1B6 }, { 90, 0x10, 0x1B6 }, { 100, 0x20, 0x1B6 },
+	{ 110, 0x30, 0x1B6 }, { 120, 0x01, 0x1B6 }, { 130, 0x11, 0x1B6 },
+	{ 140, 0x21, 0x1B6 }, { 150, 0x31, 0x1B6 }, { 160, 0x02, 0x1B6 },
+	{ 170, 0x12, 0x1B6 }, { 180, 0x22, 0x1B6 }, { 190, 0x32, 0x1B6 },
+	{ 205, 0x03, 0x1B6 }, { 220, 0x13, 0x1B6 }, { 235, 0x23, 0x1B6 },
+	{ 250, 0x33, 0x1B6 }, { 275, 0x04, 0x1B6 }, { 300, 0x14, 0x1B6 },
+	{ 325, 0x25, 0x1B6 }, { 350, 0x35, 0x1B6 }, { 400, 0x05, 0x1B6 },
+	{ 450, 0x16, 0x1B6 }, { 500, 0x26, 0x1B6 }, { 550, 0x37, 0x1B6 },
+	{ 600, 0x07, 0x1B6 }, { 650, 0x18, 0x1B6 }, { 700, 0x28, 0x1B6 },
+	{ 750, 0x39, 0x1B6 }, { 800, 0x09, 0x1B6 }, { 850, 0x19, 0x1B6 },
+	{ 900, 0x29, 0x1B6 }, { 950, 0x3A, 0x1B6 }, { 1000, 0x0A, 0x1B6 },
+	{ 1050, 0x1A, 0x1B6 }, { 1100, 0x2A, 0x1B6 }, { 1150, 0x3B, 0x1B6 },
+	{ 1200, 0x0B, 0x1B6 }, { 1250, 0x1B, 0x1B6 }, { 1300, 0x2B, 0x1B6 },
+	{ 1350, 0x3C, 0x1B6 }, { 1400, 0x0C, 0x1B6 }, { 1450, 0x1C, 0x1B6 },
+	{ 1500, 0x2C, 0x1B6 }, { 1550, 0x3D, 0x10F }, { 1600, 0x0D, 0x118 },
+	{ 1650, 0x1D, 0x121 }, { 1700, 0x2E, 0x12A }, { 1750, 0x3E, 0x132 },
+	{ 1800, 0x0E, 0x13B }, { 1850, 0x1E, 0x144 }, { 1900, 0x2F, 0x14D },
+	{ 1950, 0x3F, 0x155 }, { 2000, 0x0F, 0x15E }, { 2050, 0x40, 0x167 },
+	{ 2100, 0x41, 0x170 }, { 2150, 0x42, 0x178 }, { 2200, 0x43, 0x181 },
+	{ 2250, 0x44, 0x18A }, { 2300, 0x45, 0x193 }, { 2350, 0x46, 0x19B },
+	{ 2400, 0x47, 0x1A4 }, { 2450, 0x48, 0x1AD }, { 2500, 0x49, 0x1B6 }
+};
+
+u8 dw_dphy_setup_config(struct dw_dphy_rx *dphy)
+{
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+	int ret;
+
+	if (dphy->max_lanes == CTRL_4_LANES) {
+		dev_vdbg(&dphy->phy->dev, "CONFIG 4L\n");
+		return CTRL_4_LANES;
+	}
+	if (IS_ENABLED(CONFIG_OF)) {
+		ret = gpio_request(dphy->config_8l, "config");
+		if (ret < 0) {
+			dev_vdbg(&dphy->phy->dev,
+				 "could not acquire config (err=%d)\n", ret);
+			return ret;
+		}
+		ret = gpio_get_value(dphy->config_8l);
+		gpio_free(dphy->config_8l);
+	} else {
+		ret = dphy->config_8l;
+	}
+
+	dev_vdbg(&dphy->phy->dev,
+		 "Booting in [%s] mode\n",
+		 ret == CTRL_8_LANES ? "8L" : "4+4L");
+	return ret;
+
+#endif /* CONFIG_DWC_MIPI_TC_DPHY_GEN3 */
+	return CTRL_4_LANES;
+}
+
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+void dw_dphy_if_write(struct dw_dphy_rx *dphy, u32 address, u32 data)
+{
+	writel(data, dphy->dphy1_if_addr + address);
+
+	if (dphy->lanes_config == CTRL_4_LANES)
+		return;
+
+	iowrite32(data, dphy->dphy2_if_addr + address);
+}
+
+u32 dw_dphy_if_read(struct dw_dphy_rx *dphy, u32 address)
+{
+	u32 if1 = 0, if2 = 0;
+
+	if1 = readl(dphy->dphy1_if_addr + address);
+
+	if (dphy->lanes_config == CTRL_4_LANES)
+		goto end;
+
+	if (dphy->lanes_config == DPHYID)
+		goto end;
+
+	if2 = readl(dphy->dphy2_if_addr + address);
+
+	if (if1 != if2)
+		dev_vdbg(&dphy->phy->dev,
+			 "Values read different for each interface\n");
+end:
+	return if1;
+}
+#endif
+
+void dw_dphy_write(struct dw_dphy_rx *dphy, u32 address, u32 data)
+{
+	iowrite32(data, dphy->base_address + address);
+
+	if (dphy->lanes_config == CTRL_4_LANES)
+		return;
+
+	if (address == R_CSI2_DPHY_TST_CTRL0)
+		iowrite32(data, dphy->base_address + R_CSI2_DPHY2_TST_CTRL0);
+	else if (address == R_CSI2_DPHY_TST_CTRL1)
+		iowrite32(data, dphy->base_address + R_CSI2_DPHY2_TST_CTRL1);
+}
+
+u32 dw_dphy_read(struct dw_dphy_rx *dphy, u32 address)
+{
+	int dphy1 = 0, dphy2 = 0;
+
+	dphy1 = ioread32(dphy->base_address + address);
+
+	if (dphy->lanes_config == CTRL_4_LANES)
+		goto end;
+
+	if (address == R_CSI2_DPHY_TST_CTRL0)
+		dphy2 = ioread32(dphy->base_address + R_CSI2_DPHY2_TST_CTRL0);
+	else if (address == R_CSI2_DPHY_TST_CTRL1)
+		dphy2 = ioread32(dphy->base_address + R_CSI2_DPHY2_TST_CTRL1);
+	else
+		return -ENODEV;
+end:
+	return dphy1;
+}
+
+void dw_dphy_write_msk(struct dw_dphy_rx *dev, u32 address, u32 data, u8 shift,
+		       u8 width)
+{
+	u32 temp = dw_dphy_read(dev, address);
+	u32 mask = (1 << width) - 1;
+
+	temp &= ~(mask << shift);
+	temp |= (data & mask) << shift;
+	dw_dphy_write(dev, address, temp);
+}
+
+static void dw_dphy_te_12b_write(struct dw_dphy_rx *dphy, u16 addr, u8 data)
+{
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 1, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0x00, PHY_TESTDIN, 8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, (u8)(addr >> 8),
+			  PHY_TESTDIN, 8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 1, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, (u8)addr, PHY_TESTDIN,
+			  8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, (u8)data, PHY_TESTDIN,
+			  8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+}
+
+static void dw_dphy_te_8b_write(struct dw_dphy_rx *dphy, u8 addr, u8 data)
+{
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write(dphy, R_CSI2_DPHY_TST_CTRL1, addr);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 1, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTEN, 1);
+	dw_dphy_write(dphy, R_CSI2_DPHY_TST_CTRL1, data);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+}
+
+static void dw_dphy_te_write(struct dw_dphy_rx *dphy, u16 addr, u8 data)
+{
+	if (dphy->dphy_te_len == BIT12)
+		dw_dphy_te_12b_write(dphy, addr, data);
+	else
+		dw_dphy_te_8b_write(dphy, addr, data);
+}
+
+static int dw_dphy_te_12b_read(struct dw_dphy_rx *dphy, u32 addr)
+{
+	u8 ret;
+
+	dw_dphy_write(dphy, R_CSI2_DPHY_SHUTDOWNZ, 0);
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 0);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 1, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0x00, PHY_TESTDIN, 8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, (u8)(addr >> 8),
+			  PHY_TESTDIN, 8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 1, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, (u8)addr, PHY_TESTDIN,
+			  8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0x00, 0, PHY_TESTDIN);
+	ret = dw_dphy_read_msk(dphy, R_CSI2_DPHY_TST_CTRL1, PHY_TESTDOUT, 8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTEN, 1);
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 1);
+	dw_dphy_write(dphy, R_CSI2_DPHY_SHUTDOWNZ, 1);
+
+	return ret;
+}
+
+static int dw_dphy_te_8b_read(struct dw_dphy_rx *dphy, u32 addr)
+{
+	u8 ret;
+
+	dw_dphy_write(dphy, R_CSI2_DPHY_SHUTDOWNZ, 0);
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 0);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 1, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, addr, PHY_TESTDIN, 8);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTEN, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL1, 0, PHY_TESTDIN, 8);
+	ret = dw_dphy_read_msk(dphy, R_CSI2_DPHY_TST_CTRL1, PHY_TESTDOUT, 8);
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 1);
+	dw_dphy_write(dphy, R_CSI2_DPHY_SHUTDOWNZ, 1);
+
+	return ret;
+}
+
+int dw_dphy_te_read(struct dw_dphy_rx *dphy, u32 addr)
+{
+	int ret;
+
+	if (dphy->dphy_te_len == BIT12)
+		ret = dw_dphy_te_12b_read(dphy, addr);
+	else
+		ret = dw_dphy_te_8b_read(dphy, addr);
+
+	return ret;
+}
+
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+static void dw_dphy_if_init(struct dw_dphy_rx *dphy)
+{
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RESET);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, TX_PHY);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLR, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLR, 1);
+	dw_dphy_if_write(dphy, DPHYZCALCTRL, 0);
+	dw_dphy_if_write(dphy, DPHYZCALCTRL, 1);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RESET);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, GLUELOGIC);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLR, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLR, 1);
+	dw_dphy_if_write(dphy, DPHYZCALCTRL, 0);
+	dw_dphy_if_write(dphy, DPHYZCALCTRL, 1);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RESET);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RX_PHY);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLR, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLR, 1);
+	dw_dphy_if_write(dphy, DPHYZCALCTRL, 0);
+	dw_dphy_if_write(dphy, DPHYZCALCTRL, 1);
+}
+#endif
+
+static void dw_dphy_gen3_12bit_tc_power_up(struct dw_dphy_rx *dphy)
+{
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RESET);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, GLUELOGIC);
+#endif
+	dw_dphy_te_write(dphy, CFGCLKFREQRANGE_TX, 0x1C);
+
+	/* CLKSEL | UPDATEPLL | SHADOW_CLEAR | SHADOW_CTRL | FORCEPLL */
+	dw_dphy_te_write(dphy, BYPASS, 0x3F);
+
+	/* IO_DS3 | IO_DS2 | IO_DS1 | IO_DS0 */
+	if (dphy->dphy_freq > 1500)
+		dw_dphy_te_write(dphy, IO_DS, 0x0F);
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RESET);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RX_PHY);
+#endif
+}
+
+static void dw_dphy_gen3_8bit_tc_power_up(struct dw_dphy_rx *dphy)
+{
+	u32 input_freq = dphy->dphy_freq / 1000;
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RESET);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, GLUELOGIC);
+	dw_dphy_te_write(dphy, CFGCLKFREQRANGE_RX, 0x1C);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RESET);
+	dw_dphy_if_write(dphy, DPHYGLUEIFTESTER, RX_PHY);
+#endif
+	dw_dphy_te_write(dphy, OSC_FREQ_TARGET_RX0_MSB, 0x03);
+	dw_dphy_te_write(dphy, OSC_FREQ_TARGET_RX0_LSB, 0x02);
+	dw_dphy_te_write(dphy, OSC_FREQ_TARGET_RX1_MSB, 0x03);
+	dw_dphy_te_write(dphy, OSC_FREQ_TARGET_RX1_LSB, 0x02);
+	dw_dphy_te_write(dphy, OSC_FREQ_TARGET_RX2_MSB, 0x03);
+	dw_dphy_te_write(dphy, OSC_FREQ_TARGET_RX2_LSB, 0x02);
+	dw_dphy_te_write(dphy, OSC_FREQ_TARGET_RX3_MSB, 0x03);
+	dw_dphy_te_write(dphy, OSC_FREQ_TARGET_RX3_LSB, 0x02);
+	dw_dphy_te_write(dphy, BANDGAP_CTRL, 0x80);
+
+	if (input_freq < 2000)
+		dw_dphy_te_write(dphy, HS_RX_CTRL_LANE0, 0xC0);
+
+	if (input_freq < 1000) {
+		dw_dphy_te_write(dphy, HS_RX_CTRL_LANE1, 0xC0);
+		dw_dphy_te_write(dphy, HS_RX_CTRL_LANE2, 0xC0);
+		dw_dphy_te_write(dphy, HS_RX_CTRL_LANE3, 0xC0);
+	}
+}
+
+int dw_dphy_g118_settle(struct dw_dphy_rx *dphy)
+{
+	u32 input_freq, total_settle, settle_time, byte_clk, lp_time;
+
+	lp_time = dphy->lp_time;
+	input_freq = dphy->dphy_freq / 1000;
+
+	settle_time = (8 * (1000000 / (input_freq))) + 115000;
+	byte_clk = (8000000 / (input_freq));
+	total_settle = (settle_time + lp_time * 1000) / byte_clk;
+
+	if (total_settle > 0xFF)
+		total_settle = 0xFF;
+
+	return total_settle;
+}
+
+static void dw_dphy_pwr_down(struct dw_dphy_rx *dphy)
+{
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 0);
+
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLK, 1);
+	if (dphy->lanes_config == CTRL_8_LANES)
+		dw_dphy_write_msk(dphy, R_CSI2_DPHY2_TST_CTRL0, 0, PHY_TESTCLK,
+				  1);
+
+	dw_dphy_write(dphy, R_CSI2_DPHY_SHUTDOWNZ, 0);
+}
+
+static void dw_dphy_pwr_up(struct dw_dphy_rx *dphy)
+{
+	u32 state = 0, wait = 0;
+
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLK, 1);
+	if (dphy->lanes_config == CTRL_8_LANES)
+		dw_dphy_write_msk(dphy, R_CSI2_DPHY2_TST_CTRL0, 1, PHY_TESTCLK,
+				  1);
+	dev_vdbg(&dphy->phy->dev, "DPHY power up.\n");
+	dw_dphy_write(dphy, R_CSI2_DPHY_SHUTDOWNZ, 1);
+	usleep_range(100, 500);
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 1);
+
+	while (state != 0x10003) {
+		state = dw_dphy_read(dphy, R_CSI2_DPHY_STOPSTATE);
+		usleep_range(100, 500);
+		wait++;
+		if (wait > 10)
+			break;
+	}
+	if (state != 0x10003)
+		dev_warn(&dphy->phy->dev, "PHY Stop state not reached %x\n",
+			 state);
+}
+
+static int dw_dphy_gen3_12bit_configure(struct dw_dphy_rx *dphy)
+{
+	u32 input_freq = dphy->dphy_freq;
+	u8 range = 0;
+
+	dev_vdbg(&dphy->phy->dev, "12bit: PHY GEN 3: Freq: %u\n", input_freq);
+	for (range = 0; (range < ARRAY_SIZE(range_gen3) - 1) &&
+	     ((input_freq / 1000) > range_gen3[range].freq);
+	     range++)
+		;
+
+	dw_dphy_gen3_12bit_tc_power_up(dphy);
+	dw_dphy_te_write(dphy, RX_SYS_1, range_gen3[range].hsfregrange);
+	dw_dphy_te_write(dphy, RX_SYS_0, 0x20);
+	dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_2,
+			 (u8)range_gen3[range].osc_freq_target);
+	dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_3,
+			 (u8)(range_gen3[range].osc_freq_target >> 8));
+	dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_4, 0x01);
+
+	if (dphy->phy_type) {
+		dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_1, 0x01);
+		dw_dphy_te_write(dphy, RX_RX_STARTUP_OVR_0, 0x80);
+	}
+
+	if (dphy->phy_type || input_freq <= 1500)
+		dw_dphy_te_write(dphy, RX_SYS_7, 0x38);
+
+	return 0;
+}
+
+static int dw_dphy_gen3_8bit_configure(struct dw_dphy_rx *dphy)
+{
+	u32 input_freq = dphy->dphy_freq;
+	u8 data;
+	u8 range = 0;
+
+	dev_vdbg(&dphy->phy->dev, "8bit: PHY GEN 3: Freq: %u\n", input_freq);
+	for (range = 0; (range < ARRAY_SIZE(range_gen3) - 1) &&
+	     ((input_freq / 1000) > range_gen3[range].freq);
+	     range++)
+		;
+
+	dw_dphy_te_write(dphy, RX_SKEW_CAL, dw_dphy_g118_settle(dphy));
+	data = 1 << 7 | range_gen3[range].hsfregrange;
+	dw_dphy_te_write(dphy, HSFREQRANGE_8BIT, data);
+	dw_dphy_gen3_8bit_tc_power_up(dphy);
+
+	return 0;
+}
+
+static int dw_dphy_gen2_configure(struct dw_dphy_rx *dphy)
+{
+	u32 input_freq = dphy->dphy_freq;
+	u8 data;
+	u8 range = 0;
+
+	/* provide an initial active-high test clear pulse in TESTCLR  */
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 1, PHY_TESTCLR, 1);
+	dw_dphy_write_msk(dphy, R_CSI2_DPHY_TST_CTRL0, 0, PHY_TESTCLR, 1);
+
+	dev_vdbg(&dphy->phy->dev, "PHY GEN 2: Freq: %u\n", input_freq);
+	for (range = 0; (range < ARRAY_SIZE(range_gen2) - 1) &&
+	     ((input_freq / 1000) > range_gen2[range].freq); range++)
+		;
+
+	data = range_gen2[range].hsfregrange << 1;
+	dw_dphy_te_write(dphy, HSFREQRANGE_8BIT, data);
+
+	return 0;
+}
+
+static int dw_dphy_configure(struct dw_dphy_rx *dphy)
+{
+	dw_dphy_pwr_down(dphy);
+
+	if (dphy->dphy_gen == GEN3) {
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+		dw_dphy_if_init(dphy);
+#endif
+		if (dphy->dphy_te_len == BIT12)
+			dw_dphy_gen3_12bit_configure(dphy);
+		else
+			dw_dphy_gen3_8bit_configure(dphy);
+	} else {
+		dw_dphy_gen2_configure(dphy);
+	}
+	dw_dphy_pwr_up(dphy);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+int dw_dphy_if_set_idelay(struct dw_dphy_rx *dphy, u8 dly, u8 cells)
+{
+	u32 val = 0;
+
+	dw_dphy_if_write(dphy, IDLYCFG, 0);
+	dw_dphy_if_write(dphy, IDLYSEL, cells);
+	dw_dphy_if_write(dphy, IDLYCNTINVAL, dly);
+
+	/* Pulse Value Set */
+	dw_dphy_if_write(dphy, IDLYCFG, 1);
+	usleep_range(10, 20);
+	dw_dphy_if_write(dphy, IDLYCFG, 0);
+
+	/* Pulse IDELAY CTRL Reset */
+	dw_dphy_if_write(dphy, DPHY1REGRSTN, 0);
+	usleep_range(10, 20);
+	dw_dphy_if_write(dphy, DPHY1REGRSTN, 1);
+
+	/* Get Value*/
+	val = dw_dphy_if_read(dphy, IDLYCNTOUTVAL);
+
+	if (val != dly) {
+		dev_vdbg(&dphy->phy->dev,
+			 "odelay config failed, set %d get %d", dly, val);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int dw_dphy_if_get_idelay(struct dw_dphy_rx *dphy)
+{
+	return dw_dphy_if_read(dphy, IDLYCNTOUTVAL);
+}
+
+int dw_dphy_if_set_idelay_lane(struct dw_dphy_rx *dphy, u8 dly, u8 lane)
+{
+	int cell;
+
+	switch (lane) {
+	case 0:
+		for (cell = 3; cell <= 10; cell++)
+			dw_dphy_if_set_idelay(dphy, dly, cell);
+		break;
+	case 1:
+		for (cell = 14; cell <= 21; cell++)
+			dw_dphy_if_set_idelay(dphy, dly, cell);
+		break;
+	case 2:
+		for (cell = 24; cell <= 31; cell++)
+			dw_dphy_if_set_idelay(dphy, dly, cell);
+		break;
+	case 3:
+		for (cell = 34; cell <= 41; cell++)
+			dw_dphy_if_set_idelay(dphy, dly, cell);
+		break;
+	case 4: /* ALL */
+		dw_dphy_if_set_idelay(dphy, dly, 0x7F);
+		break;
+	default:
+		dev_err(&dphy->phy->dev, "Lane Value not recognized\n");
+		return -1;
+	}
+	return 0;
+}
+#endif
+
+int dw_dphy_init(struct phy *phy)
+{
+	struct dw_dphy_rx *dphy = phy_get_drvdata(phy);
+
+	dev_vdbg(&dphy->phy->dev, "Init DPHY.\n");
+
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 0);
+	dw_dphy_write(dphy, R_CSI2_DPHY_SHUTDOWNZ, 0);
+
+	return 0;
+}
+
+static int dw_dphy_set_phy_state(struct dw_dphy_rx *dphy, u32 on)
+{
+	u8 hs_freq;
+
+	dphy->lanes_config = dw_dphy_setup_config(dphy);
+
+	if (dphy->dphy_te_len == BIT12)
+		hs_freq = RX_SYS_1;
+	else
+		hs_freq = HSFREQRANGE_8BIT;
+
+	if (on) {
+		dw_dphy_configure(dphy);
+		dev_vdbg(&dphy->phy->dev,
+			 "HS Code: 0X%x\n", dw_dphy_te_read(dphy, hs_freq));
+	} else {
+		dw_dphy_write(dphy, R_CSI2_DPHY_SHUTDOWNZ, 0);
+		dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 0);
+	}
+
+	return 0;
+}
+
+int dw_dphy_power_on(struct phy *phy)
+{
+	struct dw_dphy_rx *dphy = phy_get_drvdata(phy);
+
+	return dw_dphy_set_phy_state(dphy, 1);
+}
+
+int dw_dphy_power_off(struct phy *phy)
+{
+	struct dw_dphy_rx *dphy = phy_get_drvdata(phy);
+
+	return dw_dphy_set_phy_state(dphy, 0);
+}
+
+int dw_dphy_reset(struct phy *phy)
+{
+	struct dw_dphy_rx *dphy = phy_get_drvdata(phy);
+
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 0);
+	usleep_range(100, 200);
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 1);
+
+	return 0;
+}
diff --git a/drivers/media/platform/dwc/dw-dphy-rx.h b/drivers/media/platform/dwc/dw-dphy-rx.h
new file mode 100644
index 000000000000..2e8d68c914c1
--- /dev/null
+++ b/drivers/media/platform/dwc/dw-dphy-rx.h
@@ -0,0 +1,212 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Synopsys DesignWare MIPI D-PHY controller driver
+ *
+ * Author: Luis Oliveira <luis.oliveira@synopsys.com>
+ */
+
+#ifndef __PHY_SNPS_DPHY_RX_H__
+#define __PHY_SNPS_DPHY_RX_H__
+
+#include <linux/debugfs.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_gpio.h>
+#include <linux/phy/phy.h>
+#include <linux/phy/phy-mipi-dphy.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+
+/* DPHY interface register bank*/
+
+#define R_CSI2_DPHY_SHUTDOWNZ 0x0
+#define R_CSI2_DPHY_RSTZ 0x4
+#define R_CSI2_DPHY_RX 0x8
+#define	R_CSI2_DPHY_STOPSTATE 0xC
+#define R_CSI2_DPHY_TST_CTRL0 0x10
+#define R_CSI2_DPHY_TST_CTRL1 0x14
+#define R_CSI2_DPHY2_TST_CTRL0 0x18
+#define R_CSI2_DPHY2_TST_CTRL1 0x1C
+
+enum dphy_id_mask {
+	DPHY_ID_LANE_SUPPORT = 0,
+	DPHY_ID_IF = 4,
+	DPHY_ID_GEN = 8,
+};
+
+enum dphy_gen_values {
+	GEN1,
+	GEN2,
+	GEN3,
+};
+
+enum dphy_interface_length {
+	BIT8 = 8,
+	BIT12 = 12,
+};
+
+enum tst_ctrl0 {
+	PHY_TESTCLR,
+	PHY_TESTCLK,
+};
+
+enum tst_ctrl1 {
+	PHY_TESTDIN = 0,
+	PHY_TESTDOUT = 8,
+	PHY_TESTEN = 16,
+};
+
+enum lanes_config_values {
+	CTRL_4_LANES,
+	CTRL_8_LANES,
+};
+
+enum dphy_tc {
+	CFGCLKFREQRANGE_TX = 0x02,
+	CFGCLKFREQRANGE_RX = 0x05,
+	BYPASS = 0x20,
+	IO_DS = 0x30,
+};
+
+enum dphy_8bit_interface_addr {
+	BANDGAP_CTRL = 0x24,
+	HS_RX_CTRL_LANE0 = 0x42,
+	HSFREQRANGE_8BIT = 0x44,
+	OSC_FREQ_TARGET_RX0_LSB	= 0x4e,
+	OSC_FREQ_TARGET_RX0_MSB	= 0x4f,
+	HS_RX_CTRL_LANE1 = 0x52,
+	OSC_FREQ_TARGET_RX1_LSB	= 0x5e,
+	OSC_FREQ_TARGET_RX1_MSB	= 0x5f,
+	RX_SKEW_CAL = 0x7e,
+	HS_RX_CTRL_LANE2 = 0x82,
+	OSC_FREQ_TARGET_RX2_LSB	= 0x8e,
+	OSC_FREQ_TARGET_RX2_MSB	= 0x8f,
+	HS_RX_CTRL_LANE3 = 0x92,
+	OSC_FREQ_TARGET_RX3_LSB	= 0x9e,
+	OSC_FREQ_TARGET_RX3_MSB	= 0x9f,
+};
+
+enum dphy_12bit_interface_addr {
+	RX_SYS_0 = 0x01,
+	RX_SYS_1 = 0x02,
+	RX_SYS_7 = 0x08,
+	RX_RX_STARTUP_OVR_0 = 0xe0,
+	RX_RX_STARTUP_OVR_1 = 0xe1,
+	RX_RX_STARTUP_OVR_2 = 0xe2,
+	RX_RX_STARTUP_OVR_3 = 0xe3,
+	RX_RX_STARTUP_OVR_4 = 0xe4,
+};
+
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+/* Testchip interface register bank */
+#define IDLYCFG	0x00
+#define IDLYSEL	0x04
+#define IDLYCNTINVAL 0x08
+#define IDLYCNTOUTVAL 0x0c
+#define DPHY1REGRSTN 0x10
+#define DPHYZCALSTAT 0x14
+#define DPHYZCALCTRL 0x18
+#define DPHYLANE0STAT 0x1c
+#define DPHYLANE1STAT 0x20
+#define DPHYLANE2STAT 0x24
+#define DPHYLANE3STAT 0x28
+#define DPHYCLKSTAT 0x2c
+#define DPHYZCLKCTRL 0x30
+#define TCGENPURPOSOUT 0x34
+#define TCGENPURPOSIN 0x38
+#define DPHYGENERICOUT 0x3c
+#define DPHYGENERICIN 0x40
+#define DPHYGLUEIFTESTER 0x44
+#define DPHYID 0x100
+
+#define DPHY_DEFAULT_FREQ 300000
+
+enum glueiftester {
+	RESET = 0x0,
+	TX_PHY = 0x1,
+	RX_PHY = 0x2,
+	GLUELOGIC = 0x4,
+};
+#endif
+
+/**
+ * struct phy		specifies associated phy component
+ * struct cfg		to pass mipi dphy specific configurations
+ * @lanes_config	lanes configuration
+ * @dphy_freq		operating frequency of the d-phy (mbps)
+ * @phy_type		dphy can be of two types, passed here
+ * @dphy_gen		dphy can be of three generations, passed here
+ * @dphy_te_len		bus width
+ * @max_lanes		maximum number of lanes
+ * @lp_time		time in low-power
+ * @base_address	memmory address of dphy test interface
+ * @dphy1_if_addr	gluelogic dphy 1 memmory address of interface
+ * @dphy2_if_addr	gluelogic dphy 2 memmory address of interface
+ * @config_8l		eight lanes configuration
+ */
+
+struct dw_dphy_rx {
+	struct phy *phy;
+	struct phy_configure_opts_mipi_dphy *cfg;
+	u32 lanes_config;
+	u32 dphy_freq;
+	u32 phy_type;
+	u32 dphy_gen;
+	u32 dphy_te_len;
+	u32 max_lanes;
+	u32 lp_time;
+	void __iomem *base_address;
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+	void __iomem *dphy1_if_addr;
+	void __iomem *dphy2_if_addr;
+	u8 config_8l;
+	u8 (*get_config_8l)(struct device *dev, struct dw_dphy_rx *dphy);
+#endif
+	u8 (*phy_register)(struct device *dev);
+	void (*phy_unregister)(struct device *dev);
+};
+
+int dw_dphy_init(struct phy *phy);
+int dw_dphy_reset(struct phy *phy);
+int dw_dphy_power_off(struct phy *phy);
+int dw_dphy_power_on(struct phy *phy);
+u8 dw_dphy_setup_config(struct dw_dphy_rx *dphy);
+void dw_dphy_write(struct dw_dphy_rx *dphy, u32 address, u32 data);
+u32 dw_dphy_read(struct dw_dphy_rx *dphy, u32 address);
+int dw_dphy_te_read(struct dw_dphy_rx *dphy, u32 addr);
+
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+u32 dw_dphy_if_read(struct dw_dphy_rx *dphy, u32 address);
+int dw_dphy_if_get_idelay(struct dw_dphy_rx *dphy);
+int dw_dphy_if_set_idelay_lane(struct dw_dphy_rx *dphy, u8 dly, u8 lane);
+int dw_dphy_create_capabilities_sysfs(struct platform_device *pdev);
+
+static inline
+u32 dw_dphy_if_read_msk(struct dw_dphy_rx *dphy,
+			u32 address, u8 shift, u8 width)
+{
+	return (dw_dphy_if_read(dphy, address) >> shift) & ((1 << width) - 1);
+}
+#endif /*IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)*/
+
+static inline struct phy *dw_dphy_xlate(struct device *dev,
+					struct of_phandle_args *args)
+{
+	struct dw_dphy_rx *dphy = dev_get_drvdata(dev);
+
+	return dphy->phy;
+}
+
+static inline
+u32 dw_dphy_read_msk(struct dw_dphy_rx *dev, u32 address, u8 shift,  u8 width)
+{
+	return (dw_dphy_read(dev, address) >> shift) & ((1 << width) - 1);
+}
+#endif /*__PHY_SNPS_DPHY_RX_H__*/
diff --git a/drivers/media/platform/dwc/dw-dphy-sysfs.c b/drivers/media/platform/dwc/dw-dphy-sysfs.c
new file mode 100644
index 000000000000..416dec85cc49
--- /dev/null
+++ b/drivers/media/platform/dwc/dw-dphy-sysfs.c
@@ -0,0 +1,232 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Synopsys DesignWare MIPI D-PHY controller driver.
+ * SysFS components for the platform driver
+ *
+ * Author: Luis Oliveira <luis.oliveira@synopsys.com>
+ */
+
+#include "dw-dphy-rx.h"
+
+static ssize_t dphy_reset_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	char buffer[15];
+
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 0);
+	usleep_range(100, 200);
+	dw_dphy_write(dphy, R_CSI2_DPHY_RSTZ, 1);
+
+	return strlcpy(buf, buffer, PAGE_SIZE);
+}
+
+static ssize_t dphy_freq_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t count)
+{
+	int ret;
+	unsigned long freq;
+
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+
+	ret = kstrtoul(buf, 10, &freq);
+	if (ret < 0)
+		return ret;
+
+	if (freq > 2500) {
+		dev_info(dev, "Freq must be under 2500 Mhz\n");
+		return count;
+	}
+	if (freq < 80) {
+		dev_info(dev, "Freq must be over 80 Mhz\n");
+		return count;
+	}
+
+	dev_vdbg(dev, "Data Rate %lu Mbps\n", freq);
+	dphy->dphy_freq = freq;
+
+	return count;
+}
+
+static ssize_t dphy_freq_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	char buffer[15];
+
+	snprintf(buffer,
+		 sizeof(buffer),
+		 "Freq %d\n", dphy->dphy_freq);
+
+	return strlcpy(buf, buffer, PAGE_SIZE);
+}
+
+static ssize_t dphy_addr_store(struct device *dev,
+			       struct device_attribute *attr,
+			       const char *buf,
+			       size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	unsigned long val;
+	u8 addr, payload;
+	int ret;
+
+	ret = kstrtoul(buf, 32, &val);
+	if (ret < 0)
+		return ret;
+
+	payload = (u16)val;
+	addr = (u16)(val >> 16);
+
+	dev_vdbg(dev, "addr 0x%lX\n", val);
+	dev_vdbg(dev, "payload: 0x%X\n", addr);
+	dev_vdbg(dev, "Addr [0x%x] -> 0x%x\n", (unsigned int)addr,
+		 dw_dphy_te_read(dphy, addr));
+
+	return count;
+}
+
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+static ssize_t idelay_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	char buffer[15];
+
+	snprintf(buffer,
+		 sizeof(buffer), "idelay %d\n", dw_dphy_if_get_idelay(dphy));
+
+	return strlcpy(buf, buffer, PAGE_SIZE);
+}
+
+static ssize_t idelay_store(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	unsigned long val;
+	u8 lane, delay;
+	int ret;
+
+	ret = kstrtoul(buf, 16, &val);
+	if (ret < 0)
+		return ret;
+
+	lane = (u8)val;
+	delay = (u8)(val >> 8);
+
+	dev_vdbg(dev, "Lanes %u\n", lane);
+	dev_vdbg(dev, "Delay %u\n", delay);
+
+	dw_dphy_if_set_idelay_lane(dphy, delay, lane);
+
+	return count;
+}
+#endif
+
+static ssize_t len_config_store(struct device *dev,
+				struct device_attribute *attr,
+				const char *buf,
+				size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	unsigned long length;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &length);
+	if (ret < 0)
+		return ret;
+
+	if (length == BIT8)
+		dev_vdbg(dev, "Configured for 8-bit interface\n");
+	else if (length == BIT12)
+		dev_vdbg(dev, "Configured for 12-bit interface\n");
+	else
+		return count;
+
+	dphy->dphy_te_len = length;
+
+	return count;
+}
+
+static ssize_t len_config_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	char buffer[20];
+
+	snprintf(buffer, sizeof(buffer), "Length %d\n", dphy->dphy_te_len);
+
+	return strlcpy(buf, buffer, PAGE_SIZE);
+}
+
+static ssize_t dw_dphy_g118_settle_store(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	unsigned long lp_time;
+	int ret;
+
+	ret = kstrtoul(buf, 10, &lp_time);
+	if (ret < 0)
+		return ret;
+
+	if (lp_time > 1 && lp_time < 10000) {
+		dphy->lp_time = lp_time;
+	} else {
+		dev_vdbg(dev, "Invalid Value configuring for 1000 ns\n");
+		dphy->lp_time = 1000;
+	}
+
+	dphy->lp_time = lp_time;
+
+	return count;
+}
+
+static ssize_t dw_dphy_g118_settle_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct platform_device *pdev = to_platform_device(dev);
+	struct dw_dphy_rx *dphy = platform_get_drvdata(pdev);
+	char buffer[10];
+
+	snprintf(buffer, sizeof(buffer), "Settle %d ns\n", dphy->lp_time);
+
+	return strlcpy(buf, buffer, PAGE_SIZE);
+}
+
+static DEVICE_ATTR_RO(dphy_reset);
+static DEVICE_ATTR_RW(dphy_freq);
+static DEVICE_ATTR_WO(dphy_addr);
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+static DEVICE_ATTR_RW(idelay);
+#endif
+static DEVICE_ATTR_RW(len_config);
+static DEVICE_ATTR_RW(dw_dphy_g118_settle);
+
+int dw_dphy_create_capabilities_sysfs(struct platform_device *pdev)
+{
+	device_create_file(&pdev->dev, &dev_attr_dphy_reset);
+	device_create_file(&pdev->dev, &dev_attr_dphy_freq);
+	device_create_file(&pdev->dev, &dev_attr_dphy_addr);
+#if IS_ENABLED(CONFIG_DWC_MIPI_TC_DPHY_GEN3)
+	device_create_file(&pdev->dev, &dev_attr_idelay);
+#endif
+	device_create_file(&pdev->dev, &dev_attr_len_config);
+	device_create_file(&pdev->dev, &dev_attr_dw_dphy_g118_settle);
+	return 0;
+}
diff --git a/include/media/dwc/dw-dphy-data.h b/include/media/dwc/dw-dphy-data.h
new file mode 100644
index 000000000000..c8d6c0f90935
--- /dev/null
+++ b/include/media/dwc/dw-dphy-data.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2018-2019 Synopsys, Inc. and/or its affiliates.
+ *
+ * Synopsys DesignWare MIPI D-PHY platform data
+ *
+ * Author: Luis Oliveira <Luis.Oliveira@synopsys.com>
+ */
+
+#include <linux/phy/phy.h>
+#include <linux/kernel.h>
+#include <media/dwc/dw-mipi-csi-pltfrm.h>
+
+struct dw_phy_pdata {
+	u32 dphy_frequency;
+	u8 dphy_te_len;
+	u32 config_8l;
+	u8 dphy_gen;
+	u8 phy_type;
+	u8 id;
+};
+
+static const struct pdata_names phys[] = {
+	{ .name = "phy-dw-dphy.0.0", },
+	{ .name = "phy-dw-dphy.1.1", },
+};
+
+struct dw_dphy_rx;
+
+struct plat_dw_dphy {
+	int (*get_resources)(struct device *dev, struct dw_dphy_rx *dphy);
+};
-- 
2.25.1

