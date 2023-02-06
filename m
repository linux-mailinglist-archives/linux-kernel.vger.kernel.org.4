Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D454168C18B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbjBFPcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjBFPbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:31:06 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7155D2B091;
        Mon,  6 Feb 2023 07:30:22 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0AD336602F99;
        Mon,  6 Feb 2023 15:30:20 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697421;
        bh=z+n09aZEEp48TA41nIzqHi4DvVH0YFJg8AJCbKOMIlc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GLwUFvcQFK3feV0NNwhBh5v/lidMVyDYvXl4LiNTOnyMdOF6imLviqr8Nrqjoye7q
         Qh4KdR6pSSW/D0FWtIa6EIsb1c9ivJKvR1R73QV6qh/FwKNUM4tfnBhZBaJpFSCRaz
         qLR6DW5Jlqq9cxy79nXGc/7yRq7rf3uK8HjPnyD26yUikN/hh5JbAuuZfox7TXF58d
         DdKeE1t/Vwy4lM9uLFyFNAR5vb9T0P4BatzjjSVpsI2qokF7yjb0Pgn8yOpWNQobcb
         UVBmY0z68QzLDjfCudyly3oPZ7eLAH9CkHgg2Q6DSNMr+pylvFwd8ukIPQ45pWJTsS
         GYiBIkvbS7m1w==
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
Subject: [PATCH v1 25/45] clk: mediatek: mt8516: Move apmixedsys clock driver to its own file
Date:   Mon,  6 Feb 2023 16:29:08 +0100
Message-Id: <20230206152928.918562-26-angelogioacchino.delregno@collabora.com>
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

In preparation for migrating mt8516 clocks to the common simple
probe mechanism, convert the apmixedsys to be a separated
platform driver and move it to clk-mt8516-apmixedsys.c.
While at it, also fix some indentation issues.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Makefile                |   2 +-
 drivers/clk/mediatek/clk-mt8516-apmixedsys.c | 121 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8516.c            |  81 -------------
 3 files changed, 122 insertions(+), 82 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8516-apmixedsys.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 0f2cd735d9fd..3133ad8c2028 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -120,5 +120,5 @@ obj-$(CONFIG_COMMON_CLK_MT8365_MFG) += clk-mt8365-mfg.o
 obj-$(CONFIG_COMMON_CLK_MT8365_MMSYS) += clk-mt8365-mm.o
 obj-$(CONFIG_COMMON_CLK_MT8365_VDEC) += clk-mt8365-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8365_VENC) += clk-mt8365-venc.o
-obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
+obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o clk-mt8516-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8516-apmixedsys.c b/drivers/clk/mediatek/clk-mt8516-apmixedsys.c
new file mode 100644
index 000000000000..5b87c9fb81f5
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8516-apmixedsys.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2019 MediaTek Inc.
+ *               James Liao <jamesjj.liao@mediatek.com>
+ *               Fabien Parent <fparent@baylibre.com>
+ *
+ * Copyright (c) 2023 Collabora, Ltd.
+ *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#include <dt-bindings/clock/mt8516-clk.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-pll.h"
+
+#define MT8516_PLL_FMAX		(1502UL * MHZ)
+
+#define CON0_MT8516_RST_BAR	BIT(27)
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
+		.rst_bar_mask = CON0_MT8516_RST_BAR,			\
+		.fmax = MT8516_PLL_FMAX,				\
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
+	{ .div = 0, .freq = MT8516_PLL_FMAX },
+	{ .div = 1, .freq = 1000000000 },
+	{ .div = 2, .freq = 604500000 },
+	{ .div = 3, .freq = 253500000 },
+	{ .div = 4, .freq = 126750000 },
+	{ } /* sentinel */
+};
+
+static const struct mtk_pll_data plls[] = {
+	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0100, 0x0110, 0, 0,
+	    21, 0x0104, 24, 0, 0x0104, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0120, 0x0130, 0,
+	    HAVE_RST_BAR, 21, 0x0124, 24, 0, 0x0124, 0),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0140, 0x0150, 0x30000000,
+	    HAVE_RST_BAR, 7, 0x0144, 24, 0, 0x0144, 0),
+	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0160, 0x0170, 0, 0,
+	      21, 0x0164, 24, 0, 0x0164, 0, mmpll_div_table),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x0180, 0x0190, 0, 0,
+	    31, 0x0180, 1, 0x0194, 0x0184, 0),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x01A0, 0x01B0, 0, 0,
+	    31, 0x01A0, 1, 0x01B4, 0x01A4, 0),
+};
+
+static int clk_mt8516_apmixed_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_devm_alloc_clk_data(dev, CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (ret)
+		return ret;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_plls;
+
+	return 0;
+
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+
+	return ret;
+}
+
+static const struct of_device_id of_match_clk_mt8516_apmixed[] = {
+	{ .compatible = "mediatek,mt8516-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8516_apmixed_drv = {
+	.probe = clk_mt8516_apmixed_probe,
+	.driver = {
+		.name = "clk-mt8516-apmixed",
+		.of_match_table = of_match_clk_mt8516_apmixed,
+	},
+};
+builtin_platform_driver(clk_mt8516_apmixed_drv)
+
+MODULE_DESCRIPTION("MediaTek MT8516 apmixedsys clocks driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/clk/mediatek/clk-mt8516.c b/drivers/clk/mediatek/clk-mt8516.c
index bea2128b4446..202a9820008f 100644
--- a/drivers/clk/mediatek/clk-mt8516.c
+++ b/drivers/clk/mediatek/clk-mt8516.c
@@ -13,7 +13,6 @@
 
 #include "clk-gate.h"
 #include "clk-mtk.h"
-#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8516-clk.h>
 
@@ -701,83 +700,3 @@ static void __init mtk_infracfg_init(struct device_node *node)
 			__func__, r);
 }
 CLK_OF_DECLARE(mtk_infracfg, "mediatek,mt8516-infracfg", mtk_infracfg_init);
-
-#define MT8516_PLL_FMAX		(1502UL * MHZ)
-
-#define CON0_MT8516_RST_BAR	BIT(27)
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
-		.rst_bar_mask = CON0_MT8516_RST_BAR,			\
-		.fmax = MT8516_PLL_FMAX,				\
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
-	{ .div = 0, .freq = MT8516_PLL_FMAX },
-	{ .div = 1, .freq = 1000000000 },
-	{ .div = 2, .freq = 604500000 },
-	{ .div = 3, .freq = 253500000 },
-	{ .div = 4, .freq = 126750000 },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_data plls[] = {
-	PLL(CLK_APMIXED_ARMPLL, "armpll", 0x0100, 0x0110, 0, 0,
-		21, 0x0104, 24, 0, 0x0104, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0120, 0x0130, 0,
-		HAVE_RST_BAR, 21, 0x0124, 24, 0, 0x0124, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll", 0x0140, 0x0150, 0x30000000,
-		HAVE_RST_BAR, 7, 0x0144, 24, 0, 0x0144, 0),
-	PLL_B(CLK_APMIXED_MMPLL, "mmpll", 0x0160, 0x0170, 0, 0,
-		21, 0x0164, 24, 0, 0x0164, 0, mmpll_div_table),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x0180, 0x0190, 0, 0,
-		31, 0x0180, 1, 0x0194, 0x0184, 0),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x01A0, 0x01B0, 0, 0,
-		31, 0x01A0, 1, 0x01B4, 0x01A4, 0),
-};
-
-static void __init mtk_apmixedsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	void __iomem *base;
-	int r;
-
-	base = of_iomap(node, 0);
-	if (!base) {
-		pr_err("%s(): ioremap failed\n", __func__);
-		return;
-	}
-
-	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
-
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-}
-CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8516-apmixedsys",
-		mtk_apmixedsys_init);
-- 
2.39.1

