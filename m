Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD06268C166
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjBFPa3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:30:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBFPaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:11 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C21E02A153;
        Mon,  6 Feb 2023 07:29:58 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 6983B6602F9B;
        Mon,  6 Feb 2023 15:29:56 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697397;
        bh=YsU0v43gD4jPbDwzfZ0jmUsfIGu82Z//UJP2EKTfI0A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LuUNRdtgUkGvZpNddMSq6N42v0vxZEgRQc759N/BYmHjwk9mfef62CPwxF6ZV4xFL
         8FyOmBgCL4ghd9iTI9B3L6h9UVHB54jL4aZ7rp/Q67fUXb6tsq2AW46LsuAZys5J0b
         5ZOTuWBUVpiUnRebmhW1TBRJ1NY36g+67Zs6LmbFj8yCrkXJq0xC7HM7Xo+KME/cWi
         ncRrCzbRYyjC+lxqC6x1srYdCOvnGKnFp1AUbsLER+6SmnAuizImsYwLDZrPHKdrHe
         0nE2AfcANBKi6cK0lXPtW5RtfdmJjaQh63seTnBQt3DJNNVZqPOcvsWUgo2cNGl+IB
         yLF643Sh02zSw==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v1 08/45] clk: mediatek: mt2712: Move apmixedsys clock driver to its own file
Date:   Mon,  6 Feb 2023 16:28:51 +0100
Message-Id: <20230206152928.918562-9-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com>
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

The only clock driver that does not support mtk_clk_simple_probe() is
apmixedsys: in preparation for enabling module build of non-critical
mt2712 clocks, move this to its own file.
While at it, also fix some indentation issues in the PLLs table.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Makefile                |   2 +-
 drivers/clk/mediatek/clk-mt2712-apmixedsys.c | 152 +++++++++++++++++
 drivers/clk/mediatek/clk-mt2712.c            | 164 -------------------
 3 files changed, 153 insertions(+), 165 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt2712-apmixedsys.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index e5d018270ed0..3c7dd19cdddf 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -38,7 +38,7 @@ obj-$(CONFIG_COMMON_CLK_MT2701_HIFSYS) += clk-mt2701-hif.o
 obj-$(CONFIG_COMMON_CLK_MT2701_IMGSYS) += clk-mt2701-img.o
 obj-$(CONFIG_COMMON_CLK_MT2701_MMSYS) += clk-mt2701-mm.o
 obj-$(CONFIG_COMMON_CLK_MT2701_VDECSYS) += clk-mt2701-vdec.o
-obj-$(CONFIG_COMMON_CLK_MT2712) += clk-mt2712.o
+obj-$(CONFIG_COMMON_CLK_MT2712) += clk-mt2712.o clk-mt2712-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT2712_BDPSYS) += clk-mt2712-bdp.o
 obj-$(CONFIG_COMMON_CLK_MT2712_IMGSYS) += clk-mt2712-img.o
 obj-$(CONFIG_COMMON_CLK_MT2712_JPGDECSYS) += clk-mt2712-jpgdec.o
diff --git a/drivers/clk/mediatek/clk-mt2712-apmixedsys.c b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
new file mode 100644
index 000000000000..e841be3a02c9
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt2712-apmixedsys.c
@@ -0,0 +1,152 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2017 MediaTek Inc.
+ * Copyright (c) 2023 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-pll.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt2712-clk.h>
+
+#define MT2712_PLL_FMAX		(3000UL * MHZ)
+
+#define CON0_MT2712_RST_BAR	BIT(24)
+
+#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+			_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,	\
+			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
+			_div_table) {					\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = CON0_MT2712_RST_BAR,			\
+		.fmax = MT2712_PLL_FMAX,				\
+		.pcwbits = _pcwbits,					\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.div_table = _div_table,				\
+	}
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+			_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,	\
+			_tuner_en_bit, _pcw_reg, _pcw_shift)		\
+		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
+			_pcwbits, _pd_reg, _pd_shift, _tuner_reg,	\
+			_tuner_en_reg, _tuner_en_bit, _pcw_reg,		\
+			_pcw_shift, NULL)
+
+static const struct mtk_pll_div_table armca35pll_div_table[] = {
+	{ .div = 0, .freq = MT2712_PLL_FMAX },
+	{ .div = 1, .freq = 1202500000 },
+	{ .div = 2, .freq = 500500000 },
+	{ .div = 3, .freq = 315250000 },
+	{ .div = 4, .freq = 157625000 },
+	{ /* sentinel */ }
+};
+
+static const struct mtk_pll_div_table armca72pll_div_table[] = {
+	{ .div = 0, .freq = MT2712_PLL_FMAX },
+	{ .div = 1, .freq = 994500000 },
+	{ .div = 2, .freq = 520000000 },
+	{ .div = 3, .freq = 315250000 },
+	{ .div = 4, .freq = 157625000 },
+	{ /* sentinel */ }
+};
+
+static const struct mtk_pll_div_table mmpll_div_table[] = {
+	{ .div = 0, .freq = MT2712_PLL_FMAX },
+	{ .div = 1, .freq = 1001000000 },
+	{ .div = 2, .freq = 601250000 },
+	{ .div = 3, .freq = 250250000 },
+	{ .div = 4, .freq = 125125000 },
+	{ /* sentinel */ }
+};
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0xf0000100,
+	    HAVE_RST_BAR, 31, 0x0230, 4, 0, 0, 0, 0x0234, 0),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0240, 0x024C, 0xfe000100,
+	    HAVE_RST_BAR, 31, 0x0240, 4, 0, 0, 0, 0x0244, 0),
+	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x0320, 0x032C, 0xc0000100,
+	    0, 31, 0x0320, 4, 0, 0, 0, 0x0324, 0),
+	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x0280, 0x028C, 0x00000100,
+	    0, 31, 0x0280, 4, 0, 0, 0, 0x0284, 0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x0330, 0x0340, 0x00000100,
+	    0, 31, 0x0330, 4, 0x0338, 0x0014, 0, 0x0334, 0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x0350, 0x0360, 0x00000100,
+	    0, 31, 0x0350, 4, 0x0358, 0x0014, 1, 0x0354, 0),
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0370, 0x037c, 0x00000100,
+	    0, 31, 0x0370, 4, 0, 0, 0, 0x0374, 0),
+	PLL(CLK_APMIXED_LVDSPLL2, "lvdspll2", 0x0390, 0x039C, 0x00000100,
+	    0, 31, 0x0390, 4, 0, 0, 0, 0x0394, 0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0270, 0x027C, 0x00000100,
+	    0, 31, 0x0270, 4, 0, 0, 0, 0x0274, 0),
+	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x0410, 0x041C, 0x00000100,
+	    0, 31, 0x0410, 4, 0, 0, 0, 0x0414, 0),
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0290, 0x029C, 0xc0000100,
+	    0, 31, 0x0290, 4, 0, 0, 0, 0x0294, 0),
+	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0250, 0x0260, 0x00000100,
+	      0, 31, 0x0250, 4, 0, 0, 0, 0x0254, 0, mmpll_div_table),
+	PLL_B(CLK_APMIXED_ARMCA35PLL, "armca35pll", 0x0100, 0x0110, 0xf0000100,
+	      HAVE_RST_BAR, 31, 0x0100, 4, 0, 0, 0, 0x0104, 0, armca35pll_div_table),
+	PLL_B(CLK_APMIXED_ARMCA72PLL, "armca72pll", 0x0210, 0x0220, 0x00000100,
+	      0, 31, 0x0210, 4, 0, 0, 0, 0x0214, 0, armca72pll_div_table),
+	PLL(CLK_APMIXED_ETHERPLL, "etherpll", 0x0300, 0x030C, 0xc0000100,
+	    0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
+};
+
+static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	int r;
+	struct device_node *node = pdev->dev.of_node;
+
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (r)
+		goto free_clk_data;
+
+	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (r) {
+		dev_err(&pdev->dev, "Cannot register clock provider: %d\n", r);
+		goto unregister_plls;
+	}
+
+	return 0;
+
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+	return r;
+}
+
+static const struct of_device_id of_match_clk_mt2712_apmixed[] = {
+	{ .compatible = "mediatek,mt2712-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt2712_apmixed_drv = {
+	.probe = clk_mt2712_apmixed_probe,
+	.driver = {
+		.name = "clk-mt2712",
+		.of_match_table = of_match_clk_mt2712_apmixed,
+	},
+};
+builtin_platform_driver(clk_mt2712_apmixed_drv)
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 8aa361f0fa13..c5fd76d1b9df 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -14,7 +14,6 @@
 #include <linux/slab.h>
 
 #include "clk-gate.h"
-#include "clk-pll.h"
 #include "clk-mtk.h"
 
 #include <dt-bindings/clock/mt2712-clk.h>
@@ -971,101 +970,6 @@ static const struct mtk_gate peri_clks[] = {
 	GATE_PERI2(CLK_PERI_MSDC30_3_QTR_EN, "per_msdc30_3_q", "mem_sel", 7),
 };
 
-#define MT2712_PLL_FMAX		(3000UL * MHZ)
-
-#define CON0_MT2712_RST_BAR	BIT(24)
-
-#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
-			_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,	\
-			_tuner_en_bit, _pcw_reg, _pcw_shift,		\
-			_div_table) {					\
-		.id = _id,						\
-		.name = _name,						\
-		.reg = _reg,						\
-		.pwr_reg = _pwr_reg,					\
-		.en_mask = _en_mask,					\
-		.flags = _flags,					\
-		.rst_bar_mask = CON0_MT2712_RST_BAR,			\
-		.fmax = MT2712_PLL_FMAX,				\
-		.pcwbits = _pcwbits,					\
-		.pd_reg = _pd_reg,					\
-		.pd_shift = _pd_shift,					\
-		.tuner_reg = _tuner_reg,				\
-		.tuner_en_reg = _tuner_en_reg,				\
-		.tuner_en_bit = _tuner_en_bit,				\
-		.pcw_reg = _pcw_reg,					\
-		.pcw_shift = _pcw_shift,				\
-		.div_table = _div_table,				\
-	}
-
-#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
-			_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,	\
-			_tuner_en_bit, _pcw_reg, _pcw_shift)		\
-		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
-			_pcwbits, _pd_reg, _pd_shift, _tuner_reg,	\
-			_tuner_en_reg, _tuner_en_bit, _pcw_reg,		\
-			_pcw_shift, NULL)
-
-static const struct mtk_pll_div_table armca35pll_div_table[] = {
-	{ .div = 0, .freq = MT2712_PLL_FMAX },
-	{ .div = 1, .freq = 1202500000 },
-	{ .div = 2, .freq = 500500000 },
-	{ .div = 3, .freq = 315250000 },
-	{ .div = 4, .freq = 157625000 },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_div_table armca72pll_div_table[] = {
-	{ .div = 0, .freq = MT2712_PLL_FMAX },
-	{ .div = 1, .freq = 994500000 },
-	{ .div = 2, .freq = 520000000 },
-	{ .div = 3, .freq = 315250000 },
-	{ .div = 4, .freq = 157625000 },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_div_table mmpll_div_table[] = {
-	{ .div = 0, .freq = MT2712_PLL_FMAX },
-	{ .div = 1, .freq = 1001000000 },
-	{ .div = 2, .freq = 601250000 },
-	{ .div = 3, .freq = 250250000 },
-	{ .div = 4, .freq = 125125000 },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0230, 0x023C, 0xf0000100,
-	    HAVE_RST_BAR, 31, 0x0230, 4, 0, 0, 0, 0x0234, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0240, 0x024C, 0xfe000100,
-	    HAVE_RST_BAR, 31, 0x0240, 4, 0, 0, 0, 0x0244, 0),
-	PLL(CLK_APMIXED_VCODECPLL, "vcodecpll", 0x0320, 0x032C, 0xc0000100,
-	    0, 31, 0x0320, 4, 0, 0, 0, 0x0324, 0),
-	PLL(CLK_APMIXED_VENCPLL, "vencpll", 0x0280, 0x028C, 0x00000100,
-	    0, 31, 0x0280, 4, 0, 0, 0, 0x0284, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x0330, 0x0340, 0x00000100,
-	    0, 31, 0x0330, 4, 0x0338, 0x0014, 0, 0x0334, 0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x0350, 0x0360, 0x00000100,
-	    0, 31, 0x0350, 4, 0x0358, 0x0014, 1, 0x0354, 0),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0370, 0x037c, 0x00000100,
-	    0, 31, 0x0370, 4, 0, 0, 0, 0x0374, 0),
-	PLL(CLK_APMIXED_LVDSPLL2, "lvdspll2", 0x0390, 0x039C, 0x00000100,
-	    0, 31, 0x0390, 4, 0, 0, 0, 0x0394, 0),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0270, 0x027C, 0x00000100,
-	    0, 31, 0x0270, 4, 0, 0, 0, 0x0274, 0),
-	PLL(CLK_APMIXED_MSDCPLL2, "msdcpll2", 0x0410, 0x041C, 0x00000100,
-	    0, 31, 0x0410, 4, 0, 0, 0, 0x0414, 0),
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x0290, 0x029C, 0xc0000100,
-	    0, 31, 0x0290, 4, 0, 0, 0, 0x0294, 0),
-	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0250, 0x0260, 0x00000100,
-	    0, 31, 0x0250, 4, 0, 0, 0, 0x0254, 0, mmpll_div_table),
-	PLL_B(CLK_APMIXED_ARMCA35PLL, "armca35pll", 0x0100, 0x0110, 0xf0000100,
-	      HAVE_RST_BAR, 31, 0x0100, 4, 0, 0, 0, 0x0104, 0, armca35pll_div_table),
-	PLL_B(CLK_APMIXED_ARMCA72PLL, "armca72pll", 0x0210, 0x0220, 0x00000100,
-	      0, 31, 0x0210, 4, 0, 0, 0, 0x0214, 0, armca72pll_div_table),
-	PLL(CLK_APMIXED_ETHERPLL, "etherpll", 0x0300, 0x030C, 0xc0000100,
-	    0, 31, 0x0300, 4, 0, 0, 0, 0x0304, 0),
-};
-
 static u16 infrasys_rst_ofs[] = { 0x30, 0x34, };
 static u16 pericfg_rst_ofs[] = { 0x0, 0x4, };
 
@@ -1084,35 +988,6 @@ static const struct mtk_clk_rst_desc clk_rst_desc[] = {
 	},
 };
 
-static int clk_mt2712_apmixed_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	if (r)
-		goto free_clk_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r) {
-		dev_err(&pdev->dev, "Cannot register clock provider: %d\n", r);
-		goto unregister_plls;
-	}
-
-	return 0;
-
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
 static const struct mtk_clk_desc topck_desc = {
 	.clks = top_clks,
 	.num_clks = ARRAY_SIZE(top_clks),
@@ -1133,33 +1008,6 @@ static const struct mtk_clk_desc mcu_desc = {
 	.clk_lock = &mt2712_clk_lock,
 };
 
-static const struct of_device_id of_match_clk_mt2712[] = {
-	{
-		.compatible = "mediatek,mt2712-apmixedsys",
-		.data = clk_mt2712_apmixed_probe,
-	}, {
-		/* sentinel */
-	}
-};
-
-static int clk_mt2712_probe(struct platform_device *pdev)
-{
-	int (*clk_probe)(struct platform_device *);
-	int r;
-
-	clk_probe = of_device_get_match_data(&pdev->dev);
-	if (!clk_probe)
-		return -EINVAL;
-
-	r = clk_probe(pdev);
-	if (r != 0)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static const struct mtk_clk_desc infra_desc = {
 	.clks = infra_clks,
 	.num_clks = ARRAY_SIZE(infra_clks),
@@ -1189,20 +1037,8 @@ static struct platform_driver clk_mt2712_simple_drv = {
 	},
 };
 
-static struct platform_driver clk_mt2712_drv = {
-	.probe = clk_mt2712_probe,
-	.driver = {
-		.name = "clk-mt2712",
-		.of_match_table = of_match_clk_mt2712,
-	},
-};
-
 static int __init clk_mt2712_init(void)
 {
-	int ret = platform_driver_register(&clk_mt2712_drv);
-
-	if (ret)
-		return ret;
 	return platform_driver_register(&clk_mt2712_simple_drv);
 }
 
-- 
2.39.1

