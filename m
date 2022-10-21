Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D28B3607D54
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 19:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiJURTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 13:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJURTE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 13:19:04 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B761AA25C;
        Fri, 21 Oct 2022 10:19:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 29LHIZW7068967;
        Fri, 21 Oct 2022 12:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1666372715;
        bh=3HkSD6gzkSr94PeFPVxDI7c4rRcKhoiN/vjBRFuON7c=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Wmt7oL4Kf6FD0MFZpS6/iNbJh/ugGJxZr3Zp6v7CmYTM3q6QC6vW202gWEAZTTU1e
         QbWJ2aEZ1Jy/RSsJnjETf33ViOIf5ljcZIAc7WEIME7mv9fkNPCX4PQQDzaz3+E6zr
         5hO/zS02oEN42GnzVV7yY4na391VshycN/lkX7qY=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 29LHIZra069351
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Oct 2022 12:18:35 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Fri, 21
 Oct 2022 12:18:35 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Fri, 21 Oct 2022 12:18:35 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 29LHIYWi037382;
        Fri, 21 Oct 2022 12:18:34 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <tomi.valkeinen@ideasonboard.com>
CC:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <p.zabel@pengutronix.de>, <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>, <a-bhatia1@ti.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v8 5/5] drm/bridge: cdns-dsi: Add support for J721E wrapper
Date:   Fri, 21 Oct 2022 22:48:20 +0530
Message-ID: <20221021171820.15984-6-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.38.0
In-Reply-To: <20221021171820.15984-1-r-ravikumar@ti.com>
References: <20221021171820.15984-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for wrapper settings for DSI bridge on
j721e. Also set the DPI input to DPI0

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 drivers/gpu/drm/bridge/cadence/Kconfig        | 10 ++++
 drivers/gpu/drm/bridge/cadence/Makefile       |  1 +
 .../gpu/drm/bridge/cadence/cdns-dsi-core.c    | 37 +++++++++++++-
 .../gpu/drm/bridge/cadence/cdns-dsi-core.h    | 13 +++++
 .../gpu/drm/bridge/cadence/cdns-dsi-j721e.c   | 51 +++++++++++++++++++
 .../gpu/drm/bridge/cadence/cdns-dsi-j721e.h   | 18 +++++++
 6 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.c
 create mode 100644 drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.h

diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
index 8fbb46c66094..663a02d96420 100644
--- a/drivers/gpu/drm/bridge/cadence/Kconfig
+++ b/drivers/gpu/drm/bridge/cadence/Kconfig
@@ -36,3 +36,13 @@ config DRM_CDNS_DSI
 	help
 	  Support Cadence DPI to DSI bridge. This is an internal
 	  bridge and is meant to be directly embedded in a SoC.
+
+if DRM_CDNS_DSI
+
+config DRM_CDNS_DSI_J721E
+	bool "J721E Cadence DPI/DSI wrapper support"
+	default y
+	help
+	  Support J721E Cadence DPI/DSI wrapper. This wrapper adds
+	  support to select which DPI input to use for the bridge.
+endif
diff --git a/drivers/gpu/drm/bridge/cadence/Makefile b/drivers/gpu/drm/bridge/cadence/Makefile
index e3d8e9a40784..4cffc8ff71c4 100644
--- a/drivers/gpu/drm/bridge/cadence/Makefile
+++ b/drivers/gpu/drm/bridge/cadence/Makefile
@@ -4,3 +4,4 @@ cdns-mhdp8546-y := cdns-mhdp8546-core.o cdns-mhdp8546-hdcp.o
 cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) += cdns-mhdp8546-j721e.o
 obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
 cdns-dsi-y := cdns-dsi-core.o
+cdns-dsi-$(CONFIG_DRM_CDNS_DSI_J721E) += cdns-dsi-j721e.o
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
index cba91247ab26..4b7de38ef1b0 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
@@ -15,12 +15,16 @@
 #include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
+#include <linux/of_device.h>
 #include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 
 #include "cdns-dsi-core.h"
+#ifdef CONFIG_DRM_CDNS_DSI_J721E
+#include "cdns-dsi-j721e.h"
+#endif
 
 static inline struct cdns_dsi *input_to_dsi(struct cdns_dsi_input *input)
 {
@@ -265,6 +269,10 @@ static void cdns_dsi_bridge_disable(struct drm_bridge *bridge)
 
 	val = readl(dsi->regs + MCTL_MAIN_EN) & ~IF_EN(input->id);
 	writel(val, dsi->regs + MCTL_MAIN_EN);
+
+	if (dsi->platform_ops && dsi->platform_ops->disable)
+		dsi->platform_ops->disable(dsi);
+
 	pm_runtime_put(dsi->base.dev);
 }
 
@@ -360,6 +368,9 @@ static void cdns_dsi_bridge_enable(struct drm_bridge *bridge)
 	if (WARN_ON(pm_runtime_get_sync(dsi->base.dev) < 0))
 		return;
 
+	if (dsi->platform_ops && dsi->platform_ops->enable)
+		dsi->platform_ops->enable(dsi);
+
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 	nlanes = output->dev->lanes;
 
@@ -800,6 +811,8 @@ static int cdns_dsi_drm_probe(struct platform_device *pdev)
 		goto err_disable_pclk;
 	}
 
+	dsi->platform_ops = of_device_get_match_data(&pdev->dev);
+
 	val = readl(dsi->regs + IP_CONF);
 	dsi->direct_cmd_fifo_depth = 1 << (DIRCMD_FIFO_DEPTH(val) + 2);
 	dsi->rx_fifo_depth = RX_FIFO_DEPTH(val);
@@ -835,14 +848,27 @@ static int cdns_dsi_drm_probe(struct platform_device *pdev)
 	dsi->base.dev = &pdev->dev;
 	dsi->base.ops = &cdns_dsi_ops;
 
+	if (dsi->platform_ops && dsi->platform_ops->init) {
+		ret = dsi->platform_ops->init(dsi);
+		if (ret != 0) {
+			dev_err(&pdev->dev, "platform initialization failed: %d\n",
+				ret);
+			goto err_disable_runtime_pm;
+		}
+	}
+
 	ret = mipi_dsi_host_register(&dsi->base);
 	if (ret)
-		goto err_disable_runtime_pm;
+		goto err_deinit_platform;
 
 	clk_disable_unprepare(dsi->dsi_p_clk);
 
 	return 0;
 
+err_deinit_platform:
+	if (dsi->platform_ops && dsi->platform_ops->exit)
+		dsi->platform_ops->exit(dsi);
+
 err_disable_runtime_pm:
 	pm_runtime_disable(&pdev->dev);
 
@@ -857,6 +883,10 @@ static int cdns_dsi_drm_remove(struct platform_device *pdev)
 	struct cdns_dsi *dsi = platform_get_drvdata(pdev);
 
 	mipi_dsi_host_unregister(&dsi->base);
+
+	if (dsi->platform_ops && dsi->platform_ops->exit)
+		dsi->platform_ops->exit(dsi);
+
 	pm_runtime_disable(&pdev->dev);
 
 	return 0;
@@ -864,6 +894,11 @@ static int cdns_dsi_drm_remove(struct platform_device *pdev)
 
 static const struct of_device_id cdns_dsi_of_match[] = {
 	{ .compatible = "cdns,dsi" },
+#ifdef CONFIG_DRM_CDNS_DSI_J721E
+	{ .compatible = "ti,j721e-dsi",
+	  .data = &dsi_ti_j721e_ops,
+	},
+#endif
 	{ },
 };
 MODULE_DEVICE_TABLE(of, cdns_dsi_of_match);
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
index 65cc77f19b39..37568b547fbe 100644
--- a/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.h
@@ -439,9 +439,22 @@ struct cdns_dsi_input {
 	struct drm_bridge bridge;
 };
 
+struct cdns_dsi;
+
+struct dsi_platform_ops {
+	int (*init)(struct cdns_dsi *dsi);
+	void (*exit)(struct cdns_dsi *dsi);
+	void (*enable)(struct cdns_dsi *dsi);
+	void (*disable)(struct cdns_dsi *dsi);
+};
+
 struct cdns_dsi {
 	struct mipi_dsi_host base;
 	void __iomem *regs;
+#ifdef CONFIG_DRM_CDNS_DSI_J721E
+	void __iomem *j721e_regs;
+#endif
+	const struct dsi_platform_ops *platform_ops;
 	struct cdns_dsi_input input;
 	struct cdns_dsi_output output;
 	unsigned int direct_cmd_fifo_depth;
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.c
new file mode 100644
index 000000000000..b5216acb333e
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TI j721e Cadence DSI wrapper
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: Rahul T R <r-ravikumar@ti.com>
+ */
+
+#include <linux/io.h>
+#include <linux/platform_device.h>
+
+#include "cdns-dsi-j721e.h"
+
+#define DSI_WRAP_REVISION		0x0
+#define DSI_WRAP_DPI_CONTROL		0x4
+#define DSI_WRAP_DSC_CONTROL		0x8
+#define DSI_WRAP_DPI_SECURE		0xc
+#define DSI_WRAP_DSI_0_ASF_STATUS	0x10
+
+#define DSI_WRAP_DPI_0_EN		BIT(0)
+#define DSI_WRAP_DSI2_MUX_SEL		BIT(4)
+
+static int cdns_dsi_j721e_init(struct cdns_dsi *dsi)
+{
+	struct platform_device *pdev = to_platform_device(dsi->base.dev);
+
+	dsi->j721e_regs = devm_platform_ioremap_resource(pdev, 1);
+	return PTR_ERR_OR_ZERO(dsi->j721e_regs);
+}
+
+static void cdns_dsi_j721e_enable(struct cdns_dsi *dsi)
+{
+	/*
+	 * Enable DPI0 as its input. DSS0 DPI2 is connected
+	 * to DSI DPI0. This is the only supported configuration on
+	 * J721E.
+	 */
+	writel(DSI_WRAP_DPI_0_EN, dsi->j721e_regs + DSI_WRAP_DPI_CONTROL);
+}
+
+static void cdns_dsi_j721e_disable(struct cdns_dsi *dsi)
+{
+	/* Put everything to defaults  */
+	writel(0, dsi->j721e_regs + DSI_WRAP_DPI_CONTROL);
+}
+
+const struct dsi_platform_ops dsi_ti_j721e_ops = {
+	.init = cdns_dsi_j721e_init,
+	.enable = cdns_dsi_j721e_enable,
+	.disable = cdns_dsi_j721e_disable,
+};
diff --git a/drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.h b/drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.h
new file mode 100644
index 000000000000..01f3dbd92db2
--- /dev/null
+++ b/drivers/gpu/drm/bridge/cadence/cdns-dsi-j721e.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * TI j721e Cadence DSI wrapper
+ *
+ * Copyright (C) 2022 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: Rahul T R <r-ravikumar@ti.com>
+ */
+
+#ifndef CDNS_DSI_J721E_H
+#define CDNS_DSI_J721E_H
+
+#include "cdns-dsi-core.h"
+
+struct dsi_platform_ops;
+
+extern const struct dsi_platform_ops dsi_ti_j721e_ops;
+
+#endif /* !CDNS_DSI_J721E_H */
-- 
2.38.0

