Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DEE8654051
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235762AbiLVL4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:56:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235507AbiLVLyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:54:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F145C2B615;
        Thu, 22 Dec 2022 03:49:34 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4BC796602CE0;
        Thu, 22 Dec 2022 11:49:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709773;
        bh=r5WwAdbnwDoB/0JmQN+IuJY8Pc/5wDk/FORuo0uPctY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TZ+SFgrqq53oM+vPv8o3DVSc85YZE6/y7SP5N+qPl1Swz7JRrk8eMG1pWZzTGpZr1
         eXXO1H9OxRvje5H/UxygLwNw57EIa84Dghgf4yUsKjanKvuX+UMFa4bVUGzrgINSHo
         d0R67AaVNoAVszDuqpqwmyHBpiX9dvVvo3wxBHss5cEJ79J2E8SY3deDp5EEPOBm1T
         6CFw/zqmVtyysQ+Tv8WIIpjXrm3lMzfU26tXMkHU70enwls+cwEO8rPSnnnGKoQKkK
         DsB4frfcSwyvuAa+uv0QWMyg0BGAFPc1e1GyY9EltCbQernouW/tOyAKnTBWn2pSXI
         hOrrcaNVoojEg==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        fparent@baylibre.com, chun-jie.chen@mediatek.com,
        sam.shih@mediatek.com, y.oudjana@protonmail.com,
        nfraprado@collabora.com, rex-bc.chen@mediatek.com,
        ryder.lee@kernel.org, daniel@makrotopia.org,
        jose.exposito89@gmail.com, yangyingliang@huawei.com,
        pablo.sun@mediatek.com, msp@baylibre.com, weiyi.lu@mediatek.com,
        ikjn@chromium.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        kernel@collabora.com
Subject: [PATCH v1 11/25] clk: mediatek: mt8173: Break down clock drivers and allow module build
Date:   Thu, 22 Dec 2022 12:48:43 +0100
Message-Id: <20221222114857.120060-12-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
References: <20221222114857.120060-1-angelogioacchino.delregno@collabora.com>
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

Split the giant clock driver for MT8173 into smaller drivers and
make it possible to build the non boot critical clock controller
drivers as modules by adding remove functions.

Some spare code style cleanups were also performed.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Kconfig                  |  30 +-
 drivers/clk/mediatek/Makefile                 |   6 +-
 drivers/clk/mediatek/clk-mt8173-apmixedsys.c  | 157 ++++
 drivers/clk/mediatek/clk-mt8173-img.c         |  55 ++
 drivers/clk/mediatek/clk-mt8173-infracfg.c    | 154 ++++
 drivers/clk/mediatek/clk-mt8173-pericfg.c     | 171 ++++
 .../{clk-mt8173.c => clk-mt8173-topckgen.c}   | 813 ++++--------------
 drivers/clk/mediatek/clk-mt8173-vdecsys.c     |  57 ++
 drivers/clk/mediatek/clk-mt8173-vencsys.c     |  64 ++
 9 files changed, 854 insertions(+), 653 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8173-apmixedsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-img.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-infracfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-pericfg.c
 rename drivers/clk/mediatek/{clk-mt8173.c => clk-mt8173-topckgen.c} (50%)
 create mode 100644 drivers/clk/mediatek/clk-mt8173-vdecsys.c
 create mode 100644 drivers/clk/mediatek/clk-mt8173-vencsys.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index c504ebca21ee..b11646a9bf6e 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -457,19 +457,41 @@ config COMMON_CLK_MT8167_VDECSYS
 	  This driver supports MediaTek MT8167 vdecsys clocks.
 
 config COMMON_CLK_MT8173
-	bool "Clock driver for MediaTek MT8173"
+	tristate "Clock driver for MediaTek MT8173"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 	select COMMON_CLK_MEDIATEK
 	default ARCH_MEDIATEK
 	help
-	  This driver supports MediaTek MT8173 clocks.
+	  This driver supports MediaTek MT8173 basic clocks and clocks
+	  required for various peripherals found on MediaTek.
+
+config COMMON_CLK_MT8173_IMGSYS
+	tristate "Clock driver for MediaTek MT8173 imgsys"
+	depends on COMMON_CLK_MT8173
+	default COMMON_CLK_MT8173
+	help
+	  This driver supports MediaTek MT8173 imgsys clocks.
 
 config COMMON_CLK_MT8173_MMSYS
-	bool "Clock driver for MediaTek MT8173 mmsys"
+       tristate "Clock driver for MediaTek MT8173 mmsys"
+       depends on COMMON_CLK_MT8173
+	default COMMON_CLK_MT8173
+       help
+         This driver supports MediaTek MT8173 mmsys clocks.
+
+config COMMON_CLK_MT8173_VDECSYS
+	tristate "Clock driver for MediaTek MT8173 VDECSYS"
+	depends on COMMON_CLK_MT8173
+	default COMMON_CLK_MT8173
+	help
+	  This driver supports MediaTek MT8173 vdecsys clocks.
+
+config COMMON_CLK_MT8173_VENCSYS
+	tristate "Clock driver for MediaTek MT8173 VENCSYS"
 	depends on COMMON_CLK_MT8173
 	default COMMON_CLK_MT8173
 	help
-	  This driver supports MediaTek MT8173 mmsys clocks.
+	  This driver supports MediaTek MT8173 vencsys clocks.
 
 config COMMON_CLK_MT8183
 	bool "Clock driver for MediaTek MT8183"
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e24080fd6e7f..a5c216c94831 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -64,8 +64,12 @@ obj-$(CONFIG_COMMON_CLK_MT8167_IMGSYS) += clk-mt8167-img.o
 obj-$(CONFIG_COMMON_CLK_MT8167_MFGCFG) += clk-mt8167-mfgcfg.o
 obj-$(CONFIG_COMMON_CLK_MT8167_MMSYS) += clk-mt8167-mm.o
 obj-$(CONFIG_COMMON_CLK_MT8167_VDECSYS) += clk-mt8167-vdec.o
-obj-$(CONFIG_COMMON_CLK_MT8173) += clk-mt8173.o
+obj-$(CONFIG_COMMON_CLK_MT8173) += clk-mt8173-apmixedsys.o clk-mt8173-infracfg.o \
+				   clk-mt8173-pericfg.o clk-mt8173-topckgen.o
+obj-$(CONFIG_COMMON_CLK_MT8173_IMGSYS) += clk-mt8173-img.o
 obj-$(CONFIG_COMMON_CLK_MT8173_MMSYS) += clk-mt8173-mm.o
+obj-$(CONFIG_COMMON_CLK_MT8173_VDECSYS) += clk-mt8173-vdecsys.o
+obj-$(CONFIG_COMMON_CLK_MT8173_VENCSYS) += clk-mt8173-vencsys.o
 obj-$(CONFIG_COMMON_CLK_MT8183) += clk-mt8183.o
 obj-$(CONFIG_COMMON_CLK_MT8183_AUDIOSYS) += clk-mt8183-audio.o
 obj-$(CONFIG_COMMON_CLK_MT8183_CAMSYS) += clk-mt8183-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8173-apmixedsys.c b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
new file mode 100644
index 000000000000..a56c5845d07a
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8173-apmixedsys.c
@@ -0,0 +1,157 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8173-clk.h>
+#include <linux/of_address.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#define REGOFF_REF2USB		0x8
+#define REGOFF_HDMI_REF		0x40
+
+#define MT8173_PLL_FMAX		(3000UL * MHZ)
+
+#define CON0_MT8173_RST_BAR	BIT(24)
+
+#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
+			_pcw_shift, _div_table) {			\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = CON0_MT8173_RST_BAR,			\
+		.fmax = MT8173_PLL_FMAX,				\
+		.pcwbits = _pcwbits,					\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.div_table = _div_table,				\
+	}
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
+			_pcw_shift)					\
+		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, \
+			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift, \
+			NULL)
+
+static const struct mtk_pll_div_table mmpll_div_table[] = {
+	{ .div = 0, .freq = MT8173_PLL_FMAX },
+	{ .div = 1, .freq = 1000000000 },
+	{ .div = 2, .freq = 702000000 },
+	{ .div = 3, .freq = 253500000 },
+	{ .div = 4, .freq = 126750000 },
+	{ } /* sentinel */
+};
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0, PLL_AO,
+	    21, 0x204, 24, 0x0, 0x204, 0),
+	PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0, PLL_AO,
+	    21, 0x214, 24, 0x0, 0x214, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000100, HAVE_RST_BAR, 21,
+	    0x220, 4, 0x0, 0x224, 0),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000000, HAVE_RST_BAR, 7,
+	    0x230, 4, 0x0, 0x234, 14),
+	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0, 0, 21, 0x244, 24, 0x0,
+	      0x244, 0, mmpll_div_table),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0, 0, 21, 0x250, 4, 0x0, 0x254, 0),
+	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0, 0, 21, 0x260, 4, 0x0, 0x264, 0),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0, 0, 21, 0x270, 4, 0x0, 0x274, 0),
+	PLL(CLK_APMIXED_MPLL, "mpll", 0x280, 0x28c, 0, 0, 21, 0x280, 4, 0x0, 0x284, 0),
+	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x290, 0x29c, 0, 0, 21, 0x290, 4, 0x0, 0x294, 0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x2a0, 0x2b0, 0, 0, 31, 0x2a0, 4, 0x2a4, 0x2a4, 0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0, 0, 31, 0x2b4, 4, 0x2b8, 0x2b8, 0),
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2d0, 0x2dc, 0, 0, 21, 0x2d0, 4, 0x0, 0x2d4, 0),
+	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0, 0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
+};
+
+static const struct of_device_id of_match_clk_mt8173_apmixed[] = {
+	{ .compatible = "mediatek,mt8173-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data;
+	void __iomem *base;
+	struct clk_hw *hw;
+	int r;
+
+	base = of_iomap(node, 0);
+	if (!base)
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (IS_ERR_OR_NULL(clk_data))
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (r)
+		goto free_clk_data;
+
+	hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REGOFF_REF2USB);
+	if (IS_ERR(hw)) {
+		r = PTR_ERR(hw);
+		dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\n", r);
+		goto unregister_plls;
+	}
+	clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
+
+	hw = devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tvdpll_594m", 0,
+					  base + REGOFF_HDMI_REF, 16, 3,
+					  CLK_DIVIDER_POWER_OF_TWO, NULL);
+	clk_data->hws[CLK_APMIXED_HDMI_REF] = hw;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_ref2usb;
+
+	return 0;
+
+unregister_ref2usb:
+	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static int clk_mt8173_apmixed_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
+static struct platform_driver clk_mt8173_apmixed_drv = {
+	.probe = clk_mt8173_apmixed_probe,
+	.remove = clk_mt8173_apmixed_remove,
+	.driver = {
+		.name = "clk-mt8173-apmixed",
+		.of_match_table = of_match_clk_mt8173_apmixed,
+	},
+};
+module_platform_driver(clk_mt8173_apmixed_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8173 apmixed clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8173-img.c b/drivers/clk/mediatek/clk-mt8173-img.c
new file mode 100644
index 000000000000..7b50ffb7a8a5
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8173-img.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8173-clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs img_cg_regs = {
+	.set_ofs = 0x0004,
+	.clr_ofs = 0x0008,
+	.sta_ofs = 0x0000,
+};
+
+#define GATE_IMG(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &img_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate img_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "img_dummy"),
+	GATE_IMG(CLK_IMG_LARB2_SMI, "img_larb2_smi", "mm_sel", 0),
+	GATE_IMG(CLK_IMG_CAM_SMI, "img_cam_smi", "mm_sel", 5),
+	GATE_IMG(CLK_IMG_CAM_CAM, "img_cam_cam", "mm_sel", 6),
+	GATE_IMG(CLK_IMG_SEN_TG, "img_sen_tg", "camtg_sel", 7),
+	GATE_IMG(CLK_IMG_SEN_CAM, "img_sen_cam", "mm_sel", 8),
+	GATE_IMG(CLK_IMG_CAM_SV, "img_cam_sv", "mm_sel", 9),
+	GATE_IMG(CLK_IMG_FD, "img_fd", "mm_sel", 11),
+};
+
+static const struct mtk_clk_desc img_desc = {
+	.clks = img_clks,
+	.num_clks = ARRAY_SIZE(img_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8173_imgsys[] = {
+	{ .compatible = "mediatek,mt8173-imgsys", .data = &img_desc },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8173_vdecsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8173-imgsys",
+		.of_match_table = of_match_clk_mt8173_imgsys,
+	},
+};
+module_platform_driver(clk_mt8173_vdecsys_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8173 vdecsys clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8173-infracfg.c b/drivers/clk/mediatek/clk-mt8173-infracfg.c
new file mode 100644
index 000000000000..ee4b992c89c6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8173-infracfg.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8173-clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "clk-cpumux.h"
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "reset.h"
+
+#define GATE_ICG(_id, _name, _parent, _shift)			\
+		GATE_MTK(_id, _name, _parent, &infra_cg_regs,	\
+			 _shift, &mtk_clk_gate_ops_setclr)
+
+static struct clk_hw_onecell_data *infra_clk_data;
+
+static const struct mtk_gate_regs infra_cg_regs = {
+	.set_ofs = 0x0040,
+	.clr_ofs = 0x0044,
+	.sta_ofs = 0x0048,
+};
+
+static const char * const ca53_parents[] __initconst = {
+	"clk26m",
+	"armca7pll",
+	"mainpll",
+	"univpll"
+};
+
+static const char * const ca72_parents[] __initconst = {
+	"clk26m",
+	"armca15pll",
+	"mainpll",
+	"univpll"
+};
+
+static const struct mtk_composite cpu_muxes[] = {
+	MUX(CLK_INFRA_CA53SEL, "infra_ca53_sel", ca53_parents, 0x0000, 0, 2),
+	MUX(CLK_INFRA_CA72SEL, "infra_ca72_sel", ca72_parents, 0x0000, 2, 2),
+};
+
+static const struct mtk_fixed_factor infra_early_divs[] = {
+	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
+};
+
+static const struct mtk_gate infra_gates[] = {
+	GATE_ICG(CLK_INFRA_DBGCLK, "infra_dbgclk", "axi_sel", 0),
+	GATE_ICG(CLK_INFRA_SMI, "infra_smi", "mm_sel", 1),
+	GATE_ICG(CLK_INFRA_AUDIO, "infra_audio", "aud_intbus_sel", 5),
+	GATE_ICG(CLK_INFRA_GCE, "infra_gce", "axi_sel", 6),
+	GATE_ICG(CLK_INFRA_L2C_SRAM, "infra_l2c_sram", "axi_sel", 7),
+	GATE_ICG(CLK_INFRA_M4U, "infra_m4u", "mem_sel", 8),
+	GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "cpum_ck", 15),
+	GATE_ICG(CLK_INFRA_KP, "infra_kp", "axi_sel", 16),
+	GATE_ICG(CLK_INFRA_CEC, "infra_cec", "clk26m", 18),
+	GATE_ICG(CLK_INFRA_PMICSPI, "infra_pmicspi", "pmicspi_sel", 22),
+	GATE_ICG(CLK_INFRA_PMICWRAP, "infra_pmicwrap", "axi_sel", 23),
+};
+
+static u16 infrasys_rst_ofs[] = { 0x30, 0x34 };
+
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = infrasys_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
+};
+
+static const struct of_device_id of_match_clk_mt8173_infracfg[] = {
+	{ .compatible = "mediatek,mt8173-infracfg" },
+	{ /* sentinel */ }
+};
+
+static void clk_mt8173_infra_init_early(struct device_node *node)
+{
+	int i;
+
+	infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
+	if (!infra_clk_data)
+		return;
+
+	for (i = 0; i < CLK_INFRA_NR_CLK; i++)
+		infra_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
+
+	mtk_clk_register_factors(infra_early_divs, ARRAY_SIZE(infra_early_divs), infra_clk_data);
+
+	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, infra_clk_data);
+}
+CLK_OF_DECLARE_DRIVER(mtk_infrasys, "mediatek,mt8173-infracfg",
+		      clk_mt8173_infra_init_early);
+
+static int clk_mt8173_infracfg_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	int r;
+
+	r = mtk_clk_register_gates(node, infra_gates, ARRAY_SIZE(infra_gates),
+				   infra_clk_data, &pdev->dev);
+	if (r)
+		return r;
+
+	r = mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
+				      infra_clk_data, &pdev->dev);
+	if (r)
+		goto unregister_gates;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, infra_clk_data);
+	if (r)
+		goto unregister_cpumuxes;
+
+	r = mtk_register_reset_controller(node, &clk_rst_desc);
+	if (r)
+		goto unregister_clk_hw;
+
+	return 0;
+
+unregister_clk_hw:
+	of_clk_del_provider(node);
+unregister_cpumuxes:
+	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), infra_clk_data);
+unregister_gates:
+	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), infra_clk_data);
+	return r;
+}
+
+static int clk_mt8173_infracfg_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), clk_data);
+	mtk_clk_unregister_gates(infra_gates, ARRAY_SIZE(infra_gates), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
+static struct platform_driver clk_mt8173_infracfg_drv = {
+	.driver = {
+		.name = "clk-mt8173-infracfg",
+		.of_match_table = of_match_clk_mt8173_infracfg,
+	},
+	.probe = clk_mt8173_infracfg_probe,
+	.remove = clk_mt8173_infracfg_remove,
+};
+module_platform_driver(clk_mt8173_infracfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8173 infracfg clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8173-pericfg.c b/drivers/clk/mediatek/clk-mt8173-pericfg.c
new file mode 100644
index 000000000000..30c0fa263cc0
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8173-pericfg.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8173-clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "reset.h"
+
+#define GATE_PERI0(_id, _name, _parent, _shift)			\
+		GATE_MTK(_id, _name, _parent, &peri0_cg_regs,	\
+			 _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_PERI1(_id, _name, _parent, _shift)			\
+		GATE_MTK(_id, _name, _parent, &peri1_cg_regs,	\
+			 _shift, &mtk_clk_gate_ops_setclr)
+
+static DEFINE_SPINLOCK(mt8173_clk_lock);
+
+static const struct mtk_gate_regs peri0_cg_regs = {
+	.set_ofs = 0x0008,
+	.clr_ofs = 0x0010,
+	.sta_ofs = 0x0018,
+};
+
+static const struct mtk_gate_regs peri1_cg_regs = {
+	.set_ofs = 0x000c,
+	.clr_ofs = 0x0014,
+	.sta_ofs = 0x001c,
+};
+
+static const char * const uart_ck_sel_parents[] = {
+	"clk26m",
+	"uart_sel",
+};
+
+static const struct mtk_composite peri_clks[] = {
+	MUX(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents, 0x40c, 0, 1),
+	MUX(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents, 0x40c, 1, 1),
+	MUX(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents, 0x40c, 2, 1),
+	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
+};
+
+static const struct mtk_gate peri_gates[] = {
+	/* PERI0 */
+	GATE_PERI0(CLK_PERI_NFI, "peri_nfi", "axi_sel", 0),
+	GATE_PERI0(CLK_PERI_THERM, "peri_therm", "axi_sel", 1),
+	GATE_PERI0(CLK_PERI_PWM1, "peri_pwm1", "axi_sel", 2),
+	GATE_PERI0(CLK_PERI_PWM2, "peri_pwm2", "axi_sel", 3),
+	GATE_PERI0(CLK_PERI_PWM3, "peri_pwm3", "axi_sel", 4),
+	GATE_PERI0(CLK_PERI_PWM4, "peri_pwm4", "axi_sel", 5),
+	GATE_PERI0(CLK_PERI_PWM5, "peri_pwm5", "axi_sel", 6),
+	GATE_PERI0(CLK_PERI_PWM6, "peri_pwm6", "axi_sel", 7),
+	GATE_PERI0(CLK_PERI_PWM7, "peri_pwm7", "axi_sel", 8),
+	GATE_PERI0(CLK_PERI_PWM, "peri_pwm", "axi_sel", 9),
+	GATE_PERI0(CLK_PERI_USB0, "peri_usb0", "usb20_sel", 10),
+	GATE_PERI0(CLK_PERI_USB1, "peri_usb1", "usb20_sel", 11),
+	GATE_PERI0(CLK_PERI_AP_DMA, "peri_ap_dma", "axi_sel", 12),
+	GATE_PERI0(CLK_PERI_MSDC30_0, "peri_msdc30_0", "msdc50_0_sel", 13),
+	GATE_PERI0(CLK_PERI_MSDC30_1, "peri_msdc30_1", "msdc30_1_sel", 14),
+	GATE_PERI0(CLK_PERI_MSDC30_2, "peri_msdc30_2", "msdc30_2_sel", 15),
+	GATE_PERI0(CLK_PERI_MSDC30_3, "peri_msdc30_3", "msdc30_3_sel", 16),
+	GATE_PERI0(CLK_PERI_NLI_ARB, "peri_nli_arb", "axi_sel", 17),
+	GATE_PERI0(CLK_PERI_IRDA, "peri_irda", "irda_sel", 18),
+	GATE_PERI0(CLK_PERI_UART0, "peri_uart0", "axi_sel", 19),
+	GATE_PERI0(CLK_PERI_UART1, "peri_uart1", "axi_sel", 20),
+	GATE_PERI0(CLK_PERI_UART2, "peri_uart2", "axi_sel", 21),
+	GATE_PERI0(CLK_PERI_UART3, "peri_uart3", "axi_sel", 22),
+	GATE_PERI0(CLK_PERI_I2C0, "peri_i2c0", "axi_sel", 23),
+	GATE_PERI0(CLK_PERI_I2C1, "peri_i2c1", "axi_sel", 24),
+	GATE_PERI0(CLK_PERI_I2C2, "peri_i2c2", "axi_sel", 25),
+	GATE_PERI0(CLK_PERI_I2C3, "peri_i2c3", "axi_sel", 26),
+	GATE_PERI0(CLK_PERI_I2C4, "peri_i2c4", "axi_sel", 27),
+	GATE_PERI0(CLK_PERI_AUXADC, "peri_auxadc", "clk26m", 28),
+	GATE_PERI0(CLK_PERI_SPI0, "peri_spi0", "spi_sel", 29),
+	GATE_PERI0(CLK_PERI_I2C5, "peri_i2c5", "axi_sel", 30),
+	GATE_PERI0(CLK_PERI_NFIECC, "peri_nfiecc", "axi_sel", 31),
+	/* PERI1 */
+	GATE_PERI1(CLK_PERI_SPI, "peri_spi", "spi_sel", 0),
+	GATE_PERI1(CLK_PERI_IRRX, "peri_irrx", "spi_sel", 1),
+	GATE_PERI1(CLK_PERI_I2C6, "peri_i2c6", "axi_sel", 2),
+};
+
+static u16 pericfg_rst_ofs[] = { 0x0, 0x4 };
+
+static const struct mtk_clk_rst_desc clk_rst_desc = {
+	.version = MTK_RST_SIMPLE,
+	.rst_bank_ofs = pericfg_rst_ofs,
+	.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
+};
+
+static const struct of_device_id of_match_clk_mt8173_pericfg[] = {
+	{ .compatible = "mediatek,mt8173-pericfg" },
+	{ /* sentinel */ }
+};
+
+static int clk_mt8173_pericfg_probe(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	if (IS_ERR_OR_NULL(clk_data))
+		return -ENOMEM;
+
+	r = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
+				   clk_data, &pdev->dev);
+	if (r)
+		goto free_clk_data;
+
+	r = mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
+					&mt8173_clk_lock, clk_data, &pdev->dev);
+	if (r)
+		goto unregister_gates;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r)
+		goto unregister_composites;
+
+	r = mtk_register_reset_controller(node, &clk_rst_desc);
+	if (r)
+		goto unregister_clk_hw;
+
+	return 0;
+
+unregister_clk_hw:
+	of_clk_del_provider(node);
+unregister_composites:
+	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
+unregister_gates:
+	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static int clk_mt8173_pericfg_remove(struct platform_device *pdev)
+{
+	struct device_node *node = pdev->dev.of_node;
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
+
+	of_clk_del_provider(node);
+	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
+	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
+	mtk_free_clk_data(clk_data);
+
+	return 0;
+}
+
+static struct platform_driver clk_mt8173_pericfg_drv = {
+	.driver = {
+		.name = "clk-mt8173-pericfg",
+		.of_match_table = of_match_clk_mt8173_pericfg,
+	},
+	.probe = clk_mt8173_pericfg_probe,
+	.remove = clk_mt8173_pericfg_remove,
+};
+module_platform_driver(clk_mt8173_pericfg_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8173 pericfg clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8173.c b/drivers/clk/mediatek/clk-mt8173-topckgen.c
similarity index 50%
rename from drivers/clk/mediatek/clk-mt8173.c
rename to drivers/clk/mediatek/clk-mt8173-topckgen.c
index 02231f8ba6d9..46144e429081 100644
--- a/drivers/clk/mediatek/clk-mt8173.c
+++ b/drivers/clk/mediatek/clk-mt8173-topckgen.c
@@ -1,138 +1,34 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2014 MediaTek Inc.
- * Author: James Liao <jamesjj.liao@mediatek.com>
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
-#include <linux/clk.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
-#include <linux/of_device.h>
+#include <dt-bindings/clock/mt8173-clk.h>
+#include <linux/module.h>
 #include <linux/platform_device.h>
-
-#include "clk-cpumux.h"
 #include "clk-gate.h"
 #include "clk-mtk.h"
-#include "clk-pll.h"
-
-#include <dt-bindings/clock/mt8173-clk.h>
-
-#define REGOFF_REF2USB	0x8
-#define REGOFF_HDMI_REF	0x40
+#include "clk-mux.h"
 
 /*
  * For some clocks, we don't care what their actual rates are. And these
  * clocks may change their rate on different products or different scenarios.
  * So we model these clocks' rate as 0, to denote it's not an actual rate.
  */
-#define DUMMY_RATE		0
-
-static DEFINE_SPINLOCK(mt8173_clk_lock);
-
-static const struct mtk_fixed_clk fixed_clks[] = {
-	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", DUMMY_RATE),
-	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
-	FIXED_CLK(CLK_TOP_DSI0_DIG, "dsi0_dig", "clk26m", DUMMY_RATE),
-	FIXED_CLK(CLK_TOP_DSI1_DIG, "dsi1_dig", "clk26m", DUMMY_RATE),
-	FIXED_CLK(CLK_TOP_LVDS_PXL, "lvds_pxl", "lvdspll", DUMMY_RATE),
-	FIXED_CLK(CLK_TOP_LVDS_CTS, "lvds_cts", "lvdspll", DUMMY_RATE),
-};
-
-static const struct mtk_fixed_factor top_divs[] = {
-	FACTOR(CLK_TOP_ARMCA7PLL_754M, "armca7pll_754m", "armca7pll", 1, 2),
-	FACTOR(CLK_TOP_ARMCA7PLL_502M, "armca7pll_502m", "armca7pll", 1, 3),
-
-	FACTOR_FLAGS(CLK_TOP_MAIN_H546M, "main_h546m", "mainpll", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_MAIN_H364M, "main_h364m", "mainpll", 1, 3, 0),
-	FACTOR_FLAGS(CLK_TOP_MAIN_H218P4M, "main_h218p4m", "mainpll", 1, 5, 0),
-	FACTOR_FLAGS(CLK_TOP_MAIN_H156M, "main_h156m", "mainpll", 1, 7, 0),
-
-	FACTOR(CLK_TOP_TVDPLL_445P5M, "tvdpll_445p5m", "tvdpll", 1, 4),
-	FACTOR(CLK_TOP_TVDPLL_594M, "tvdpll_594m", "tvdpll", 1, 3),
-
-	FACTOR_FLAGS(CLK_TOP_UNIV_624M, "univ_624m", "univpll", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIV_416M, "univ_416m", "univpll", 1, 3, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIV_249P6M, "univ_249p6m", "univpll", 1, 5, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIV_178P3M, "univ_178p3m", "univpll", 1, 7, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIV_48M, "univ_48m", "univpll", 1, 26, 0),
-
-	FACTOR(CLK_TOP_CLKRTC_EXT, "clkrtc_ext", "clk32k", 1, 1),
-	FACTOR(CLK_TOP_CLKRTC_INT, "clkrtc_int", "clk26m", 1, 793),
-	FACTOR(CLK_TOP_FPC, "fpc_ck", "clk26m", 1, 1),
-
-	FACTOR(CLK_TOP_HDMITXPLL_D2, "hdmitxpll_d2", "hdmitx_dig_cts", 1, 2),
-	FACTOR(CLK_TOP_HDMITXPLL_D3, "hdmitxpll_d3", "hdmitx_dig_cts", 1, 3),
-
-	FACTOR(CLK_TOP_ARMCA7PLL_D2, "armca7pll_d2", "armca7pll_754m", 1, 1),
-	FACTOR(CLK_TOP_ARMCA7PLL_D3, "armca7pll_d3", "armca7pll_502m", 1, 1),
-
-	FACTOR(CLK_TOP_APLL1, "apll1_ck", "apll1", 1, 1),
-	FACTOR(CLK_TOP_APLL2, "apll2_ck", "apll2", 1, 1),
-
-	FACTOR(CLK_TOP_DMPLL, "dmpll_ck", "clkph_mck_o", 1, 1),
-	FACTOR(CLK_TOP_DMPLL_D2, "dmpll_d2", "clkph_mck_o", 1, 2),
-	FACTOR(CLK_TOP_DMPLL_D4, "dmpll_d4", "clkph_mck_o", 1, 4),
-	FACTOR(CLK_TOP_DMPLL_D8, "dmpll_d8", "clkph_mck_o", 1, 8),
-	FACTOR(CLK_TOP_DMPLL_D16, "dmpll_d16", "clkph_mck_o", 1, 16),
-
-	FACTOR(CLK_TOP_LVDSPLL_D2, "lvdspll_d2", "lvdspll", 1, 2),
-	FACTOR(CLK_TOP_LVDSPLL_D4, "lvdspll_d4", "lvdspll", 1, 4),
-	FACTOR(CLK_TOP_LVDSPLL_D8, "lvdspll_d8", "lvdspll", 1, 8),
+#define DUMMY_RATE	0
 
-	FACTOR(CLK_TOP_MMPLL, "mmpll_ck", "mmpll", 1, 1),
-	FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", "mmpll", 1, 2),
-
-	FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", "msdcpll", 1, 1),
-	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
-	FACTOR(CLK_TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
-	FACTOR(CLK_TOP_MSDCPLL2, "msdcpll2_ck", "msdcpll2", 1, 1),
-	FACTOR(CLK_TOP_MSDCPLL2_D2, "msdcpll2_d2", "msdcpll2", 1, 2),
-	FACTOR(CLK_TOP_MSDCPLL2_D4, "msdcpll2_d4", "msdcpll2", 1, 4),
-
-	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "main_h546m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D2, "syspll1_d2", "main_h546m", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D4, "syspll1_d4", "main_h546m", 1, 4, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D8, "syspll1_d8", "main_h546m", 1, 8, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D16, "syspll1_d16", "main_h546m", 1, 16, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL_D3, "syspll_d3", "main_h364m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL2_D2, "syspll2_d2", "main_h364m", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL2_D4, "syspll2_d4", "main_h364m", 1, 4, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL_D5, "syspll_d5", "main_h218p4m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL3_D2, "syspll3_d2", "main_h218p4m", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL3_D4, "syspll3_d4", "main_h218p4m", 1, 4, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL_D7, "syspll_d7", "main_h156m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL4_D2, "syspll4_d2", "main_h156m", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_SYSPLL4_D4, "syspll4_d4", "main_h156m", 1, 4, 0),
-
-	FACTOR(CLK_TOP_TVDPLL, "tvdpll_ck", "tvdpll_594m", 1, 1),
-	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_594m", 1, 2),
-	FACTOR(CLK_TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll_594m", 1, 4),
-	FACTOR(CLK_TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll_594m", 1, 8),
-	FACTOR(CLK_TOP_TVDPLL_D16, "tvdpll_d16", "tvdpll_594m", 1, 16),
-
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univ_624m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", "univ_624m", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", "univ_624m", 1, 4, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D8, "univpll1_d8", "univ_624m", 1, 8, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univ_416m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D2, "univpll2_d2", "univ_416m", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D4, "univpll2_d4", "univ_416m", 1, 4, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D8, "univpll2_d8", "univ_416m", 1, 8, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univ_249p6m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D2, "univpll3_d2", "univ_249p6m", 1, 2, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", "univ_249p6m", 1, 4, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D8, "univpll3_d8", "univ_249p6m", 1, 8, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univ_178p3m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D26, "univpll_d26", "univ_48m", 1, 1, 0),
-	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D52, "univpll_d52", "univ_48m", 1, 2, 0),
+#define TOP_MUX_GATE_NOSR(_id, _name, _parents, _reg, _shift, _width, _gate, _flags) \
+		MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _reg,		\
+			(_reg + 0x4), (_reg + 0x8), _shift, _width,		\
+			_gate, 0, -1, _flags)
 
-	FACTOR(CLK_TOP_VCODECPLL, "vcodecpll_ck", "vcodecpll", 1, 3),
-	FACTOR(CLK_TOP_VCODECPLL_370P5, "vcodecpll_370p5", "vcodecpll", 1, 4),
+#define TOP_MUX_GATE(_id, _name, _parents, _reg, _shift, _width, _gate, _flags)	\
+		TOP_MUX_GATE_NOSR(_id, _name, _parents, _reg, _shift, _width,	\
+				  _gate, CLK_SET_RATE_PARENT | _flags)
 
-	FACTOR(CLK_TOP_VENCPLL, "vencpll_ck", "vencpll", 1, 1),
-	FACTOR(CLK_TOP_VENCPLL_D2, "vencpll_d2", "vencpll", 1, 2),
-	FACTOR(CLK_TOP_VENCPLL_D4, "vencpll_d4", "vencpll", 1, 4),
-};
+static DEFINE_SPINLOCK(mt8173_top_clk_lock);
 
 static const char * const axi_parents[] = {
 	"clk26m",
@@ -524,23 +420,109 @@ static const char * const i2s3_b_ck_parents[] = {
 	"apll2_div5"
 };
 
-static const char * const ca53_parents[] = {
-	"clk26m",
-	"armca7pll",
-	"mainpll",
-	"univpll"
+static const struct mtk_fixed_clk fixed_clks[] = {
+	FIXED_CLK(CLK_TOP_CLKPH_MCK_O, "clkph_mck_o", "clk26m", DUMMY_RATE),
+	FIXED_CLK(CLK_TOP_USB_SYSPLL_125M, "usb_syspll_125m", "clk26m", 125 * MHZ),
+	FIXED_CLK(CLK_TOP_DSI0_DIG, "dsi0_dig", "clk26m", DUMMY_RATE),
+	FIXED_CLK(CLK_TOP_DSI1_DIG, "dsi1_dig", "clk26m", DUMMY_RATE),
+	FIXED_CLK(CLK_TOP_LVDS_PXL, "lvds_pxl", "lvdspll", DUMMY_RATE),
+	FIXED_CLK(CLK_TOP_LVDS_CTS, "lvds_cts", "lvdspll", DUMMY_RATE),
 };
 
-static const char * const ca72_parents[] = {
-	"clk26m",
-	"armca15pll",
-	"mainpll",
-	"univpll"
-};
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_ARMCA7PLL_754M, "armca7pll_754m", "armca7pll", 1, 2),
+	FACTOR(CLK_TOP_ARMCA7PLL_502M, "armca7pll_502m", "armca7pll", 1, 3),
+
+	FACTOR_FLAGS(CLK_TOP_MAIN_H546M, "main_h546m", "mainpll", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_MAIN_H364M, "main_h364m", "mainpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_MAIN_H218P4M, "main_h218p4m", "mainpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_MAIN_H156M, "main_h156m", "mainpll", 1, 7, 0),
+
+	FACTOR(CLK_TOP_TVDPLL_445P5M, "tvdpll_445p5m", "tvdpll", 1, 4),
+	FACTOR(CLK_TOP_TVDPLL_594M, "tvdpll_594m", "tvdpll", 1, 3),
+
+	FACTOR_FLAGS(CLK_TOP_UNIV_624M, "univ_624m", "univpll", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIV_416M, "univ_416m", "univpll", 1, 3, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIV_249P6M, "univ_249p6m", "univpll", 1, 5, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIV_178P3M, "univ_178p3m", "univpll", 1, 7, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIV_48M, "univ_48m", "univpll", 1, 26, 0),
 
-static const struct mtk_composite cpu_muxes[] = {
-	MUX(CLK_INFRA_CA53SEL, "infra_ca53_sel", ca53_parents, 0x0000, 0, 2),
-	MUX(CLK_INFRA_CA72SEL, "infra_ca72_sel", ca72_parents, 0x0000, 2, 2),
+	FACTOR(CLK_TOP_CLKRTC_EXT, "clkrtc_ext", "clk32k", 1, 1),
+	FACTOR(CLK_TOP_CLKRTC_INT, "clkrtc_int", "clk26m", 1, 793),
+	FACTOR(CLK_TOP_FPC, "fpc_ck", "clk26m", 1, 1),
+
+	FACTOR(CLK_TOP_HDMITXPLL_D2, "hdmitxpll_d2", "hdmitx_dig_cts", 1, 2),
+	FACTOR(CLK_TOP_HDMITXPLL_D3, "hdmitxpll_d3", "hdmitx_dig_cts", 1, 3),
+
+	FACTOR(CLK_TOP_ARMCA7PLL_D2, "armca7pll_d2", "armca7pll_754m", 1, 1),
+	FACTOR(CLK_TOP_ARMCA7PLL_D3, "armca7pll_d3", "armca7pll_502m", 1, 1),
+
+	FACTOR(CLK_TOP_APLL1, "apll1_ck", "apll1", 1, 1),
+	FACTOR(CLK_TOP_APLL2, "apll2_ck", "apll2", 1, 1),
+
+	FACTOR(CLK_TOP_DMPLL, "dmpll_ck", "clkph_mck_o", 1, 1),
+	FACTOR(CLK_TOP_DMPLL_D2, "dmpll_d2", "clkph_mck_o", 1, 2),
+	FACTOR(CLK_TOP_DMPLL_D4, "dmpll_d4", "clkph_mck_o", 1, 4),
+	FACTOR(CLK_TOP_DMPLL_D8, "dmpll_d8", "clkph_mck_o", 1, 8),
+	FACTOR(CLK_TOP_DMPLL_D16, "dmpll_d16", "clkph_mck_o", 1, 16),
+
+	FACTOR(CLK_TOP_LVDSPLL_D2, "lvdspll_d2", "lvdspll", 1, 2),
+	FACTOR(CLK_TOP_LVDSPLL_D4, "lvdspll_d4", "lvdspll", 1, 4),
+	FACTOR(CLK_TOP_LVDSPLL_D8, "lvdspll_d8", "lvdspll", 1, 8),
+
+	FACTOR(CLK_TOP_MMPLL, "mmpll_ck", "mmpll", 1, 1),
+	FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", "mmpll", 1, 2),
+
+	FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", "msdcpll", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(CLK_TOP_MSDCPLL_D4, "msdcpll_d4", "msdcpll", 1, 4),
+	FACTOR(CLK_TOP_MSDCPLL2, "msdcpll2_ck", "msdcpll2", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL2_D2, "msdcpll2_d2", "msdcpll2", 1, 2),
+	FACTOR(CLK_TOP_MSDCPLL2_D4, "msdcpll2_d4", "msdcpll2", 1, 4),
+
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D2, "syspll_d2", "main_h546m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D2, "syspll1_d2", "main_h546m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D4, "syspll1_d4", "main_h546m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D8, "syspll1_d8", "main_h546m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL1_D16, "syspll1_d16", "main_h546m", 1, 16, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D3, "syspll_d3", "main_h364m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL2_D2, "syspll2_d2", "main_h364m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL2_D4, "syspll2_d4", "main_h364m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D5, "syspll_d5", "main_h218p4m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL3_D2, "syspll3_d2", "main_h218p4m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL3_D4, "syspll3_d4", "main_h218p4m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL_D7, "syspll_d7", "main_h156m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL4_D2, "syspll4_d2", "main_h156m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_SYSPLL4_D4, "syspll4_d4", "main_h156m", 1, 4, 0),
+
+	FACTOR(CLK_TOP_TVDPLL, "tvdpll_ck", "tvdpll_594m", 1, 1),
+	FACTOR(CLK_TOP_TVDPLL_D2, "tvdpll_d2", "tvdpll_594m", 1, 2),
+	FACTOR(CLK_TOP_TVDPLL_D4, "tvdpll_d4", "tvdpll_594m", 1, 4),
+	FACTOR(CLK_TOP_TVDPLL_D8, "tvdpll_d8", "tvdpll_594m", 1, 8),
+	FACTOR(CLK_TOP_TVDPLL_D16, "tvdpll_d16", "tvdpll_594m", 1, 16),
+
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univ_624m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", "univ_624m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", "univ_624m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL1_D8, "univpll1_d8", "univ_624m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univ_416m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D2, "univpll2_d2", "univ_416m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D4, "univpll2_d4", "univ_416m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL2_D8, "univpll2_d8", "univ_416m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univ_249p6m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D2, "univpll3_d2", "univ_249p6m", 1, 2, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", "univ_249p6m", 1, 4, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL3_D8, "univpll3_d8", "univ_249p6m", 1, 8, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D7, "univpll_d7", "univ_178p3m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D26, "univpll_d26", "univ_48m", 1, 1, 0),
+	FACTOR_FLAGS(CLK_TOP_UNIVPLL_D52, "univpll_d52", "univ_48m", 1, 2, 0),
+
+	FACTOR(CLK_TOP_VCODECPLL, "vcodecpll_ck", "vcodecpll", 1, 3),
+	FACTOR(CLK_TOP_VCODECPLL_370P5, "vcodecpll_370p5", "vcodecpll", 1, 4),
+
+	FACTOR(CLK_TOP_VENCPLL, "vencpll_ck", "vencpll", 1, 1),
+	FACTOR(CLK_TOP_VENCPLL_D2, "vencpll_d2", "vencpll", 1, 2),
+	FACTOR(CLK_TOP_VENCPLL_D4, "vencpll_d4", "vencpll", 1, 4),
 };
 
 static const struct mtk_composite top_muxes[] = {
@@ -564,25 +546,35 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_USB20_SEL, "usb20_sel", usb20_parents, 0x0060, 24, 2, 31),
 	/* CLK_CFG_3 */
 	MUX_GATE(CLK_TOP_USB30_SEL, "usb30_sel", usb30_parents, 0x0070, 0, 2, 7),
-	MUX_GATE(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel", msdc50_0_h_parents, 0x0070, 8, 3, 15),
-	MUX_GATE(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents, 0x0070, 16, 4, 23),
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents, 0x0070, 24, 3, 31),
+	MUX_GATE(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel", msdc50_0_h_parents,
+		 0x0070, 8, 3, 15),
+	MUX_GATE(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents,
+		 0x0070, 16, 4, 23),
+	MUX_GATE(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents,
+		 0x0070, 24, 3, 31),
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_2_parents, 0x0080, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_parents, 0x0080, 8, 4, 15),
-	MUX_GATE(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents, 0x0080, 16, 2, 23),
-	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, "aud_intbus_sel", aud_intbus_parents, 0x0080, 24, 3, 31),
+	MUX_GATE(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_2_parents,
+		 0x0080, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_parents,
+		 0x0080, 8, 4, 15),
+	MUX_GATE(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents,
+		 0x0080, 16, 2, 23),
+	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, "aud_intbus_sel", aud_intbus_parents,
+		 0x0080, 24, 3, 31),
 	/* CLK_CFG_5 */
-	MUX_GATE(CLK_TOP_PMICSPI_SEL, "pmicspi_sel", pmicspi_parents, 0x0090, 0, 3, 7 /* 7:5 */),
+	MUX_GATE(CLK_TOP_PMICSPI_SEL, "pmicspi_sel", pmicspi_parents,
+		 0x0090, 0, 3, 7 /* 7:5 */),
 	MUX_GATE(CLK_TOP_SCP_SEL, "scp_sel", scp_parents, 0x0090, 8, 3, 15),
 	MUX_GATE(CLK_TOP_ATB_SEL, "atb_sel", atb_parents, 0x0090, 16, 2, 23),
-	MUX_GATE(CLK_TOP_VENC_LT_SEL, "venclt_sel", venc_lt_parents, 0x0090, 24, 4, 31),
+	MUX_GATE(CLK_TOP_VENC_LT_SEL, "venclt_sel", venc_lt_parents,
+		 0x0090, 24, 4, 31),
 	/* CLK_CFG_6 */
 	/*
 	 * The dpi0_sel clock should not propagate rate changes to its parent
 	 * clock so the dpi driver can have full control over PLL and divider.
 	 */
-	MUX_GATE_FLAGS(CLK_TOP_DPI0_SEL, "dpi0_sel", dpi0_parents, 0x00a0, 0, 3, 7, 0),
+	MUX_GATE_FLAGS(CLK_TOP_DPI0_SEL, "dpi0_sel", dpi0_parents,
+		       0x00a0, 0, 3, 7, 0),
 	MUX_GATE(CLK_TOP_IRDA_SEL, "irda_sel", irda_parents, 0x00a0, 8, 2, 15),
 	MUX_GATE_FLAGS(CLK_TOP_CCI400_SEL, "cci400_sel",
 		       cci400_parents, 0x00a0, 16, 3, 23,
@@ -590,17 +582,23 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_AUD_1_SEL, "aud_1_sel", aud_1_parents, 0x00a0, 24, 2, 31),
 	/* CLK_CFG_7 */
 	MUX_GATE(CLK_TOP_AUD_2_SEL, "aud_2_sel", aud_2_parents, 0x00b0, 0, 2, 7),
-	MUX_GATE(CLK_TOP_MEM_MFG_IN_SEL, "mem_mfg_in_sel", mem_mfg_in_parents, 0x00b0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_AXI_MFG_IN_SEL, "axi_mfg_in_sel", axi_mfg_in_parents, 0x00b0, 16, 2, 23),
+	MUX_GATE(CLK_TOP_MEM_MFG_IN_SEL, "mem_mfg_in_sel", mem_mfg_in_parents,
+		 0x00b0, 8, 2, 15),
+	MUX_GATE(CLK_TOP_AXI_MFG_IN_SEL, "axi_mfg_in_sel", axi_mfg_in_parents,
+		 0x00b0, 16, 2, 23),
 	MUX_GATE(CLK_TOP_SCAM_SEL, "scam_sel", scam_parents, 0x00b0, 24, 2, 31),
 	/* CLK_CFG_12 */
-	MUX_GATE(CLK_TOP_SPINFI_IFR_SEL, "spinfi_ifr_sel", spinfi_ifr_parents, 0x00c0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_SPINFI_IFR_SEL, "spinfi_ifr_sel", spinfi_ifr_parents,
+		 0x00c0, 0, 3, 7),
 	MUX_GATE(CLK_TOP_HDMI_SEL, "hdmi_sel", hdmi_parents, 0x00c0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_DPILVDS_SEL, "dpilvds_sel", dpilvds_parents, 0x00c0, 24, 3, 31),
+	MUX_GATE(CLK_TOP_DPILVDS_SEL, "dpilvds_sel", dpilvds_parents,
+		 0x00c0, 24, 3, 31),
 	/* CLK_CFG_13 */
-	MUX_GATE(CLK_TOP_MSDC50_2_H_SEL, "msdc50_2_h_sel", msdc50_2_h_parents, 0x00d0, 0, 3, 7),
+	MUX_GATE(CLK_TOP_MSDC50_2_H_SEL, "msdc50_2_h_sel", msdc50_2_h_parents,
+		 0x00d0, 0, 3, 7),
 	MUX_GATE(CLK_TOP_HDCP_SEL, "hdcp_sel", hdcp_parents, 0x00d0, 8, 2, 15),
-	MUX_GATE(CLK_TOP_HDCP_24M_SEL, "hdcp_24m_sel", hdcp_24m_parents, 0x00d0, 16, 2, 23),
+	MUX_GATE(CLK_TOP_HDCP_24M_SEL, "hdcp_24m_sel", hdcp_24m_parents,
+		 0x00d0, 16, 2, 23),
 	MUX_FLAGS(CLK_TOP_RTC_SEL, "rtc_sel", rtc_parents, 0x00d0, 24, 2,
 		  CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 
@@ -625,236 +623,12 @@ static const struct mtk_composite top_muxes[] = {
 	MUX(CLK_TOP_I2S3_B_SEL, "i2s3_b_ck_sel", i2s3_b_ck_parents, 0x120, 8, 1),
 };
 
-static const struct mtk_gate_regs infra_cg_regs = {
-	.set_ofs = 0x0040,
-	.clr_ofs = 0x0044,
-	.sta_ofs = 0x0048,
-};
-
-#define GATE_ICG(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &infra_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
-
-static const struct mtk_gate infra_clks[] = {
-	GATE_ICG(CLK_INFRA_DBGCLK, "infra_dbgclk", "axi_sel", 0),
-	GATE_ICG(CLK_INFRA_SMI, "infra_smi", "mm_sel", 1),
-	GATE_ICG(CLK_INFRA_AUDIO, "infra_audio", "aud_intbus_sel", 5),
-	GATE_ICG(CLK_INFRA_GCE, "infra_gce", "axi_sel", 6),
-	GATE_ICG(CLK_INFRA_L2C_SRAM, "infra_l2c_sram", "axi_sel", 7),
-	GATE_ICG(CLK_INFRA_M4U, "infra_m4u", "mem_sel", 8),
-	GATE_ICG(CLK_INFRA_CPUM, "infra_cpum", "cpum_ck", 15),
-	GATE_ICG(CLK_INFRA_KP, "infra_kp", "axi_sel", 16),
-	GATE_ICG(CLK_INFRA_CEC, "infra_cec", "clk26m", 18),
-	GATE_ICG(CLK_INFRA_PMICSPI, "infra_pmicspi", "pmicspi_sel", 22),
-	GATE_ICG(CLK_INFRA_PMICWRAP, "infra_pmicwrap", "axi_sel", 23),
-};
-
-static const struct mtk_fixed_factor infra_early_divs[] = {
-	FACTOR(CLK_INFRA_CLK_13M, "clk13m", "clk26m", 1, 2),
-};
-
-static const struct mtk_gate_regs peri0_cg_regs = {
-	.set_ofs = 0x0008,
-	.clr_ofs = 0x0010,
-	.sta_ofs = 0x0018,
-};
-
-static const struct mtk_gate_regs peri1_cg_regs = {
-	.set_ofs = 0x000c,
-	.clr_ofs = 0x0014,
-	.sta_ofs = 0x001c,
-};
-
-#define GATE_PERI0(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &peri0_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
-
-#define GATE_PERI1(_id, _name, _parent, _shift) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &peri1_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
-
-static const struct mtk_gate peri_gates[] = {
-	/* PERI0 */
-	GATE_PERI0(CLK_PERI_NFI, "peri_nfi", "axi_sel", 0),
-	GATE_PERI0(CLK_PERI_THERM, "peri_therm", "axi_sel", 1),
-	GATE_PERI0(CLK_PERI_PWM1, "peri_pwm1", "axi_sel", 2),
-	GATE_PERI0(CLK_PERI_PWM2, "peri_pwm2", "axi_sel", 3),
-	GATE_PERI0(CLK_PERI_PWM3, "peri_pwm3", "axi_sel", 4),
-	GATE_PERI0(CLK_PERI_PWM4, "peri_pwm4", "axi_sel", 5),
-	GATE_PERI0(CLK_PERI_PWM5, "peri_pwm5", "axi_sel", 6),
-	GATE_PERI0(CLK_PERI_PWM6, "peri_pwm6", "axi_sel", 7),
-	GATE_PERI0(CLK_PERI_PWM7, "peri_pwm7", "axi_sel", 8),
-	GATE_PERI0(CLK_PERI_PWM, "peri_pwm", "axi_sel", 9),
-	GATE_PERI0(CLK_PERI_USB0, "peri_usb0", "usb20_sel", 10),
-	GATE_PERI0(CLK_PERI_USB1, "peri_usb1", "usb20_sel", 11),
-	GATE_PERI0(CLK_PERI_AP_DMA, "peri_ap_dma", "axi_sel", 12),
-	GATE_PERI0(CLK_PERI_MSDC30_0, "peri_msdc30_0", "msdc50_0_sel", 13),
-	GATE_PERI0(CLK_PERI_MSDC30_1, "peri_msdc30_1", "msdc30_1_sel", 14),
-	GATE_PERI0(CLK_PERI_MSDC30_2, "peri_msdc30_2", "msdc30_2_sel", 15),
-	GATE_PERI0(CLK_PERI_MSDC30_3, "peri_msdc30_3", "msdc30_3_sel", 16),
-	GATE_PERI0(CLK_PERI_NLI_ARB, "peri_nli_arb", "axi_sel", 17),
-	GATE_PERI0(CLK_PERI_IRDA, "peri_irda", "irda_sel", 18),
-	GATE_PERI0(CLK_PERI_UART0, "peri_uart0", "axi_sel", 19),
-	GATE_PERI0(CLK_PERI_UART1, "peri_uart1", "axi_sel", 20),
-	GATE_PERI0(CLK_PERI_UART2, "peri_uart2", "axi_sel", 21),
-	GATE_PERI0(CLK_PERI_UART3, "peri_uart3", "axi_sel", 22),
-	GATE_PERI0(CLK_PERI_I2C0, "peri_i2c0", "axi_sel", 23),
-	GATE_PERI0(CLK_PERI_I2C1, "peri_i2c1", "axi_sel", 24),
-	GATE_PERI0(CLK_PERI_I2C2, "peri_i2c2", "axi_sel", 25),
-	GATE_PERI0(CLK_PERI_I2C3, "peri_i2c3", "axi_sel", 26),
-	GATE_PERI0(CLK_PERI_I2C4, "peri_i2c4", "axi_sel", 27),
-	GATE_PERI0(CLK_PERI_AUXADC, "peri_auxadc", "clk26m", 28),
-	GATE_PERI0(CLK_PERI_SPI0, "peri_spi0", "spi_sel", 29),
-	GATE_PERI0(CLK_PERI_I2C5, "peri_i2c5", "axi_sel", 30),
-	GATE_PERI0(CLK_PERI_NFIECC, "peri_nfiecc", "axi_sel", 31),
-	/* PERI1 */
-	GATE_PERI1(CLK_PERI_SPI, "peri_spi", "spi_sel", 0),
-	GATE_PERI1(CLK_PERI_IRRX, "peri_irrx", "spi_sel", 1),
-	GATE_PERI1(CLK_PERI_I2C6, "peri_i2c6", "axi_sel", 2),
-};
-
-static const char * const uart_ck_sel_parents[] = {
-	"clk26m",
-	"uart_sel",
-};
-
-static const struct mtk_composite peri_clks[] = {
-	MUX(CLK_PERI_UART0_SEL, "uart0_ck_sel", uart_ck_sel_parents, 0x40c, 0, 1),
-	MUX(CLK_PERI_UART1_SEL, "uart1_ck_sel", uart_ck_sel_parents, 0x40c, 1, 1),
-	MUX(CLK_PERI_UART2_SEL, "uart2_ck_sel", uart_ck_sel_parents, 0x40c, 2, 1),
-	MUX(CLK_PERI_UART3_SEL, "uart3_ck_sel", uart_ck_sel_parents, 0x40c, 3, 1),
-};
-
-static const struct mtk_gate_regs cg_regs_4_8_0 = {
-	.set_ofs = 0x0004,
-	.clr_ofs = 0x0008,
-	.sta_ofs = 0x0000,
-};
-
-#define GATE_IMG(_id, _name, _parent, _shift) {			\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &cg_regs_4_8_0,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr,		\
-	}
-
-static const struct mtk_gate img_clks[] = {
-	GATE_DUMMY(CLK_DUMMY, "img_dummy"),
-	GATE_IMG(CLK_IMG_LARB2_SMI, "img_larb2_smi", "mm_sel", 0),
-	GATE_IMG(CLK_IMG_CAM_SMI, "img_cam_smi", "mm_sel", 5),
-	GATE_IMG(CLK_IMG_CAM_CAM, "img_cam_cam", "mm_sel", 6),
-	GATE_IMG(CLK_IMG_SEN_TG, "img_sen_tg", "camtg_sel", 7),
-	GATE_IMG(CLK_IMG_SEN_CAM, "img_sen_cam", "mm_sel", 8),
-	GATE_IMG(CLK_IMG_CAM_SV, "img_cam_sv", "mm_sel", 9),
-	GATE_IMG(CLK_IMG_FD, "img_fd", "mm_sel", 11),
-};
-
-static const struct mtk_gate_regs vdec0_cg_regs = {
-	.set_ofs = 0x0000,
-	.clr_ofs = 0x0004,
-	.sta_ofs = 0x0000,
-};
-
-static const struct mtk_gate_regs vdec1_cg_regs = {
-	.set_ofs = 0x0008,
-	.clr_ofs = 0x000c,
-	.sta_ofs = 0x0008,
-};
-
-#define GATE_VDEC0(_id, _name, _parent, _shift) {		\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &vdec0_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr_inv,		\
-	}
-
-#define GATE_VDEC1(_id, _name, _parent, _shift) {		\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &vdec1_cg_regs,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr_inv,		\
-	}
-
-static const struct mtk_gate vdec_clks[] = {
-	GATE_DUMMY(CLK_DUMMY, "vdec_dummy"),
-	GATE_VDEC0(CLK_VDEC_CKEN, "vdec_cken", "vdec_sel", 0),
-	GATE_VDEC1(CLK_VDEC_LARB_CKEN, "vdec_larb_cken", "mm_sel", 0),
-};
-
-#define GATE_VENC(_id, _name, _parent, _shift) {		\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &cg_regs_4_8_0,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr_inv,		\
-	}
-
-static const struct mtk_gate venc_clks[] = {
-	GATE_DUMMY(CLK_DUMMY, "venc_dummy"),
-	GATE_VENC(CLK_VENC_CKE0, "venc_cke0", "mm_sel", 0),
-	GATE_VENC(CLK_VENC_CKE1, "venc_cke1", "venc_sel", 4),
-	GATE_VENC(CLK_VENC_CKE2, "venc_cke2", "venc_sel", 8),
-	GATE_VENC(CLK_VENC_CKE3, "venc_cke3", "venc_sel", 12),
-};
-
-#define GATE_VENCLT(_id, _name, _parent, _shift) {		\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.regs = &cg_regs_4_8_0,				\
-		.shift = _shift,				\
-		.ops = &mtk_clk_gate_ops_setclr_inv,		\
-	}
-
-static const struct mtk_gate venclt_clks[] = {
-	GATE_DUMMY(CLK_DUMMY, "venclt_dummy"),
-	GATE_VENCLT(CLK_VENCLT_CKE0, "venclt_cke0", "mm_sel", 0),
-	GATE_VENCLT(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
-};
-
-static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
-static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
-
-static const struct mtk_clk_rst_desc clk_rst_desc[] = {
-	/* infrasys */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = infrasys_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(infrasys_rst_ofs),
-	},
-	/* pericfg */
-	{
-		.version = MTK_RST_SIMPLE,
-		.rst_bank_ofs = pericfg_rst_ofs,
-		.rst_bank_nr = ARRAY_SIZE(pericfg_rst_ofs),
-	}
+static const struct of_device_id of_match_clk_mt8173_topckgen[] = {
+	{ .compatible = "mediatek,mt8173-topckgen" },
+	{ /* sentinel */ }
 };
 
-static struct clk_hw_onecell_data *infra_clk_data;
-
-static int clk_mt8173_topck_probe(struct platform_device *pdev)
+static int clk_mt8173_topckgen_probe(struct platform_device *pdev)
 {
 	struct device_node *node = pdev->dev.of_node;
 	struct clk_hw_onecell_data *clk_data;
@@ -878,7 +652,7 @@ static int clk_mt8173_topck_probe(struct platform_device *pdev)
 		goto unregister_fixed_clks;
 
 	r = mtk_clk_register_composites(top_muxes, ARRAY_SIZE(top_muxes), base,
-					&mt8173_clk_lock, clk_data, &pdev->dev);
+					&mt8173_top_clk_lock, clk_data, &pdev->dev);
 	if (r)
 		goto unregister_factors;
 
@@ -899,286 +673,29 @@ static int clk_mt8173_topck_probe(struct platform_device *pdev)
 	return r;
 }
 
-static void clk_mt8173_infra_init_early(struct device_node *node)
-{
-	int i;
-
-	infra_clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-	if (!infra_clk_data)
-		return;
-
-	for (i = 0; i < CLK_INFRA_NR_CLK; i++)
-		infra_clk_data->hws[i] = ERR_PTR(-EPROBE_DEFER);
-
-	mtk_clk_register_factors(infra_early_divs, ARRAY_SIZE(infra_early_divs), infra_clk_data);
-
-	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, infra_clk_data);
-}
-CLK_OF_DECLARE_DRIVER(mtk_infrasys, "mediatek,mt8173-infracfg",
-		      clk_mt8173_infra_init_early);
-
-static int clk_mt8173_infra_probe(struct platform_device *pdev)
+static int clk_mt8173_topckgen_remove(struct platform_device *pdev)
 {
+	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
 	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	r = mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-				   infra_clk_data, &pdev->dev);
-	if (r)
-		return r;
-
-	r = mtk_clk_register_cpumuxes(node, cpu_muxes, ARRAY_SIZE(cpu_muxes),
-				      infra_clk_data, &pdev->dev);
-	if (r)
-		goto unregister_gates;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, infra_clk_data);
-	if (r)
-		goto unregister_cpumuxes;
-
-	r = mtk_register_reset_controller(node, &clk_rst_desc[0]);
-	if (r)
-		goto unregister_clk_hw;
 
-	return 0;
-
-unregister_clk_hw:
 	of_clk_del_provider(node);
-unregister_cpumuxes:
-	mtk_clk_unregister_cpumuxes(cpu_muxes, ARRAY_SIZE(cpu_muxes), infra_clk_data);
-unregister_gates:
-	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), infra_clk_data);
-	return r;
-}
-
-static int clk_mt8173_peri_probe(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	void __iomem *base;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
-	if (IS_ERR_OR_NULL(clk_data))
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(node, peri_gates, ARRAY_SIZE(peri_gates),
-				   clk_data, &pdev->dev);
-	if (r)
-		goto free_clk_data;
-
-	r = mtk_clk_register_composites(peri_clks, ARRAY_SIZE(peri_clks), base,
-					&mt8173_clk_lock, clk_data, &pdev->dev);
-	if (r)
-		goto unregister_gates;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_composites;
-
-	r = mtk_register_reset_controller(node, &clk_rst_desc[1]);
-	if (r)
-		goto unregister_clk_hw;
-
-	return 0;
-
-unregister_clk_hw:
-	of_clk_del_provider(node);
-unregister_composites:
-	mtk_clk_unregister_composites(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
-unregister_gates:
-	mtk_clk_unregister_gates(peri_gates, ARRAY_SIZE(peri_gates), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-#define MT8173_PLL_FMAX		(3000UL * MHZ)
-
-#define CON0_MT8173_RST_BAR	BIT(24)
-
-#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
-			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
-			_pcw_shift, _div_table) {			\
-		.id = _id,						\
-		.name = _name,						\
-		.reg = _reg,						\
-		.pwr_reg = _pwr_reg,					\
-		.en_mask = _en_mask,					\
-		.flags = _flags,					\
-		.rst_bar_mask = CON0_MT8173_RST_BAR,			\
-		.fmax = MT8173_PLL_FMAX,				\
-		.pcwbits = _pcwbits,					\
-		.pd_reg = _pd_reg,					\
-		.pd_shift = _pd_shift,					\
-		.tuner_reg = _tuner_reg,				\
-		.pcw_reg = _pcw_reg,					\
-		.pcw_shift = _pcw_shift,				\
-		.div_table = _div_table,				\
-	}
-
-#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
-			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg,	\
-			_pcw_shift)					\
-		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits, \
-			_pd_reg, _pd_shift, _tuner_reg, _pcw_reg, _pcw_shift, \
-			NULL)
-
-static const struct mtk_pll_div_table mmpll_div_table[] = {
-	{ .div = 0, .freq = MT8173_PLL_FMAX },
-	{ .div = 1, .freq = 1000000000 },
-	{ .div = 2, .freq = 702000000 },
-	{ .div = 3, .freq = 253500000 },
-	{ .div = 4, .freq = 126750000 },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMCA15PLL, "armca15pll", 0x200, 0x20c, 0, PLL_AO,
-	    21, 0x204, 24, 0x0, 0x204, 0),
-	PLL(CLK_APMIXED_ARMCA7PLL, "armca7pll", 0x210, 0x21c, 0, PLL_AO,
-	    21, 0x214, 24, 0x0, 0x214, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x220, 0x22c, 0xf0000100, HAVE_RST_BAR, 21, 0x220, 4, 0x0, 0x224, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x230, 0x23c, 0xfe000000, HAVE_RST_BAR, 7, 0x230, 4, 0x0, 0x234, 14),
-	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x240, 0x24c, 0, 0, 21, 0x244, 24, 0x0, 0x244, 0, mmpll_div_table),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x250, 0x25c, 0, 0, 21, 0x250, 4, 0x0, 0x254, 0),
-	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x260, 0x26c, 0, 0, 21, 0x260, 4, 0x0, 0x264, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x270, 0x27c, 0, 0, 21, 0x270, 4, 0x0, 0x274, 0),
-	PLL(CLK_APMIXED_MPLL, "mpll", 0x280, 0x28c, 0, 0, 21, 0x280, 4, 0x0, 0x284, 0),
-	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x290, 0x29c, 0, 0, 21, 0x290, 4, 0x0, 0x294, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x2a0, 0x2b0, 0, 0, 31, 0x2a0, 4, 0x2a4, 0x2a4, 0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x2b4, 0x2c4, 0, 0, 31, 0x2b4, 4, 0x2b8, 0x2b8, 0),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x2d0, 0x2dc, 0, 0, 21, 0x2d0, 4, 0x0, 0x2d4, 0),
-	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x2f0, 0x2fc, 0, 0, 21, 0x2f0, 4, 0x0, 0x2f4, 0),
-};
-
-static int clk_mt8173_apmixed_probe(struct platform_device *pdev)
-{
-	struct device_node *node = pdev->dev.of_node;
-	struct clk_hw_onecell_data *clk_data;
-	void __iomem *base;
-	struct clk_hw *hw;
-	int r;
-
-	base = of_iomap(node, 0);
-	if (!base)
-		return PTR_ERR(base);
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (IS_ERR_OR_NULL(clk_data))
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	if (r)
-		goto free_clk_data;
-
-	hw = mtk_clk_register_ref2usb_tx("ref2usb_tx", "clk26m", base + REGOFF_REF2USB);
-	if (IS_ERR(hw)) {
-		r = PTR_ERR(hw);
-		dev_err(&pdev->dev, "Failed to register ref2usb_tx: %d\n", r);
-		goto unregister_plls;
-	}
-	clk_data->hws[CLK_APMIXED_REF2USB_TX] = hw;
-
-	hw = devm_clk_hw_register_divider(&pdev->dev, "hdmi_ref", "tvdpll_594m", 0,
-					  base + REGOFF_HDMI_REF, 16, 3,
-					  CLK_DIVIDER_POWER_OF_TWO, NULL);
-	clk_data->hws[CLK_APMIXED_HDMI_REF] = hw;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_ref2usb;
+	mtk_clk_unregister_composites(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+	mtk_clk_unregister_fixed_clks(fixed_clks, ARRAY_SIZE(fixed_clks), clk_data);
+	mtk_free_clk_data(clk_data);
 
 	return 0;
-
-unregister_ref2usb:
-	mtk_clk_unregister_ref2usb_tx(clk_data->hws[CLK_APMIXED_REF2USB_TX]);
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static const struct mtk_clk_desc img_desc = {
-	.clks = img_clks,
-	.num_clks = ARRAY_SIZE(img_clks),
-};
-
-static const struct mtk_clk_desc vdec_desc = {
-	.clks = vdec_clks,
-	.num_clks = ARRAY_SIZE(vdec_clks),
-};
-
-static const struct mtk_clk_desc venc_desc = {
-	.clks = venc_clks,
-	.num_clks = ARRAY_SIZE(venc_clks),
-};
-
-static const struct mtk_clk_desc venc_lt_desc = {
-	.clks = venclt_clks,
-	.num_clks = ARRAY_SIZE(venclt_clks),
-};
-
-static const struct of_device_id of_match_clk_mt8173_simple[] = {
-	{ .compatible = "mediatek,mt8173-imgsys", .data = &img_desc },
-	{ .compatible = "mediatek,mt8173-vdecsys", .data = &vdec_desc },
-	{ .compatible = "mediatek,mt8173-vencsys", .data = &venc_desc },
-	{ .compatible = "mediatek,mt8173-vencltsys", .data = &venc_lt_desc },
-	{ /* sentinel */ }
-};
-
-static struct platform_driver clk_mt8173_simple_drv = {
-	.driver = {
-		.name = "clk-mt8173-simple",
-		.of_match_table = of_match_clk_mt8173_simple,
-	},
-	.probe = mtk_clk_simple_probe,
-	.remove = mtk_clk_simple_remove,
-};
-
-static int clk_mt8173_probe(struct platform_device *pdev)
-{
-	int (*clk_probe)(struct platform_device *pdev);
-	int r;
-
-	clk_probe = of_device_get_match_data(&pdev->dev);
-	if (!clk_probe)
-		return -EINVAL;
-
-	r = clk_probe(pdev);
-	if (r)
-		dev_err(&pdev->dev, "could not register clock provider: %s: %d\n", pdev->name, r);
-
-	return r;
 }
 
-static const struct of_device_id of_match_clk_mt8173[] = {
-	{ .compatible = "mediatek,mt8173-apmixedsys", .data = clk_mt8173_apmixed_probe },
-	{ .compatible = "mediatek,mt8173-infracfg", .data = clk_mt8173_infra_probe },
-	{ .compatible = "mediatek,mt8173-topckgen", .data = clk_mt8173_topck_probe },
-	{ .compatible = "mediatek,mt8173-pericfg", .data = clk_mt8173_peri_probe },
-	{ /* sentinel */ }
-};
-
-static struct platform_driver clk_mt8173_drv = {
-	.probe = clk_mt8173_probe,
+static struct platform_driver clk_mt8173_topckgen_drv = {
 	.driver = {
-		.name = "clk-mt8173",
-		.of_match_table = of_match_clk_mt8173,
+		.name = "clk-mt8173-topckgen",
+		.of_match_table = of_match_clk_mt8173_topckgen,
 	},
+	.probe = clk_mt8173_topckgen_probe,
+	.remove = clk_mt8173_topckgen_remove,
 };
+module_platform_driver(clk_mt8173_topckgen_drv);
 
-static int __init clk_mt8173_init(void)
-{
-	int ret = platform_driver_register(&clk_mt8173_drv);
-
-	if (ret)
-		return ret;
-	return platform_driver_register(&clk_mt8173_simple_drv);
-}
-arch_initcall(clk_mt8173_init);
+MODULE_DESCRIPTION("MediaTek MT8173 topckgen clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8173-vdecsys.c b/drivers/clk/mediatek/clk-mt8173-vdecsys.c
new file mode 100644
index 000000000000..5105b8e0969d
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8173-vdecsys.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8173-clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#define GATE_VDEC(_id, _name, _parent, _regs)			\
+		GATE_MTK(_id, _name, _parent, _regs, 0,		\
+			 &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate_regs vdec0_cg_regs = {
+	.set_ofs = 0x0000,
+	.clr_ofs = 0x0004,
+	.sta_ofs = 0x0000,
+};
+
+static const struct mtk_gate_regs vdec1_cg_regs = {
+	.set_ofs = 0x0008,
+	.clr_ofs = 0x000c,
+	.sta_ofs = 0x0008,
+};
+
+static const struct mtk_gate vdec_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "vdec_dummy"),
+	GATE_VDEC(CLK_VDEC_CKEN, "vdec_cken", "vdec_sel", &vdec0_cg_regs),
+	GATE_VDEC(CLK_VDEC_LARB_CKEN, "vdec_larb_cken", "mm_sel", &vdec1_cg_regs),
+};
+
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8173_vdecsys[] = {
+	{ .compatible = "mediatek,mt8173-vdecsys", .data = &vdec_desc },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8173_vdecsys_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8173-vdecsys",
+		.of_match_table = of_match_clk_mt8173_vdecsys,
+	},
+};
+module_platform_driver(clk_mt8173_vdecsys_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8173 vdecsys clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8173-vencsys.c b/drivers/clk/mediatek/clk-mt8173-vencsys.c
new file mode 100644
index 000000000000..ff4f1cb735de
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8173-vencsys.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2014 MediaTek Inc.
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8173-clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs venc_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_VENC(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate venc_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "venc_dummy"),
+	GATE_VENC(CLK_VENC_CKE0, "venc_cke0", "mm_sel", 0),
+	GATE_VENC(CLK_VENC_CKE1, "venc_cke1", "venc_sel", 4),
+	GATE_VENC(CLK_VENC_CKE2, "venc_cke2", "venc_sel", 8),
+	GATE_VENC(CLK_VENC_CKE3, "venc_cke3", "venc_sel", 12),
+};
+
+static const struct mtk_gate venclt_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "venclt_dummy"),
+	GATE_VENC(CLK_VENCLT_CKE0, "venclt_cke0", "mm_sel", 0),
+	GATE_VENC(CLK_VENCLT_CKE1, "venclt_cke1", "venclt_sel", 4),
+};
+
+static const struct mtk_clk_desc venc_desc = {
+	.clks = venc_clks,
+	.num_clks = ARRAY_SIZE(venc_clks),
+};
+
+static const struct mtk_clk_desc venc_lt_desc = {
+	.clks = venclt_clks,
+	.num_clks = ARRAY_SIZE(venclt_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8173_vencsys[] = {
+	{ .compatible = "mediatek,mt8173-vencsys", .data = &venc_desc },
+	{ .compatible = "mediatek,mt8173-vencltsys", .data = &venc_lt_desc },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8173_vencsys_drv = {
+	.driver = {
+		.name = "clk-mt8173-vencsys",
+		.of_match_table = of_match_clk_mt8173_vencsys,
+	},
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+};
+module_platform_driver(clk_mt8173_vencsys_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8173 vencsys clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.0

