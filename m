Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4786168C173
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231418AbjBFPa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjBFPaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:30 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDC82A9A7;
        Mon,  6 Feb 2023 07:30:07 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC4D06602F9C;
        Mon,  6 Feb 2023 15:30:04 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697405;
        bh=8kQyDdnC0/43MPsGIOYi17QeWkO96To6LjFOlxi/Lyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HjlPD10FR/kMD9YXLMJ7/4XgOHfBinCwON7hZzjhgEe2hgCQfcZRs5Msr3hgQAft8
         x/b2B/J3rDy67BeAAAE8yR+36j0l2Z/7STWA4tT+IyGrZPyAVNS9Jgky8YtJBaQEHJ
         wXjIJ9lc8ljwxFp8LVIfM4CqTtrj0oiiwcUUAQ1z+a5MEMgWsHBHuuf4diZzVZQGUA
         nhNLGzKEJVhlRHqSYahlQAC+ey6cjFUQ77cWr1KGKRyrC3fndPke+o/Rz6USENAdB0
         g46WNW1+t9Fyla3B55TqjxCCA4KzBjYqef3XJgSYxS6lnOW2h76uliyb0glJccZ8iS
         eCGE82RA7hEjA==
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
Subject: [PATCH v1 14/45] clk: mediatek: mt8167: Move apmixedsys as platform_driver in new file
Date:   Mon,  6 Feb 2023 16:28:57 +0100
Message-Id: <20230206152928.918562-15-angelogioacchino.delregno@collabora.com>
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

In preparation for migrating all other MT8167 clocks to the common
mtk_clk_simple_probe(), move apmixedsys clocks to a different file.
While at it, also migrate away from the legacy CLK_OF_DECLARE and
convert this clock driver to be a platform_driver instead.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Makefile                |   2 +-
 drivers/clk/mediatek/clk-mt8167-apmixedsys.c | 143 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8167.c            | 102 -------------
 3 files changed, 144 insertions(+), 103 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8167-apmixedsys.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index b004a47026d4..7fda42b76533 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -62,7 +62,7 @@ obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-topckgen.o
 obj-$(CONFIG_COMMON_CLK_MT7986) += clk-mt7986-infracfg.o
 obj-$(CONFIG_COMMON_CLK_MT7986_ETHSYS) += clk-mt7986-eth.o
 obj-$(CONFIG_COMMON_CLK_MT8135) += clk-mt8135.o
-obj-$(CONFIG_COMMON_CLK_MT8167) += clk-mt8167.o
+obj-$(CONFIG_COMMON_CLK_MT8167) += clk-mt8167.o clk-mt8167-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8167_AUDSYS) += clk-mt8167-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8167_IMGSYS) += clk-mt8167-img.o
 obj-$(CONFIG_COMMON_CLK_MT8167_MFGCFG) += clk-mt8167-mfgcfg.o
diff --git a/drivers/clk/mediatek/clk-mt8167-apmixedsys.c b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
new file mode 100644
index 000000000000..ebd90365be5f
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8167-apmixedsys.c
@@ -0,0 +1,143 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Copyright (c) 2020 BayLibre, SAS
+ * Copyright (c) 2023 Collabora, Ltd.
+ */
+
+#include <dt-bindings/clock/mt8167-clk.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-pll.h"
+#include "clk-mtk.h"
+
+static DEFINE_SPINLOCK(mt8167_apmixed_clk_lock);
+
+#define MT8167_PLL_FMAX		(2500UL * MHZ)
+
+#define CON0_MT8167_RST_BAR	BIT(27)
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
+		.rst_bar_mask = CON0_MT8167_RST_BAR,			\
+		.fmax = MT8167_PLL_FMAX,				\
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
+	{ .div = 0, .freq = MT8167_PLL_FMAX },
+	{ .div = 1, .freq = 1000000000 },
+	{ .div = 2, .freq = 604500000 },
+	{ .div = 3, .freq = 253500000 },
+	{ .div = 4, .freq = 126750000 },
+	{ /* sentinel */ }
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
+	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x01C0, 0x01D0, 0, 0,
+	    21, 0x01C4, 24, 0, 0x01C4, 0),
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x01E0, 0x01F0, 0, 0,
+	    21, 0x01E4, 24, 0, 0x01E4, 0),
+};
+
+#define DIV_ADJ_FLAG(_id, _name, _parent, _reg, _shift, _width, _flag) { \
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.div_reg = _reg,				\
+		.div_shift = _shift,				\
+		.div_width = _width,				\
+		.clk_divider_flags = _flag,			\
+}
+
+static const struct mtk_clk_divider adj_divs[] = {
+	DIV_ADJ_FLAG(CLK_APMIXED_HDMI_REF, "hdmi_ref", "tvdpll",
+		     0x1c4, 24, 3, CLK_DIVIDER_POWER_OF_TWO),
+};
+
+static int clk_mt8167_apmixed_probe(struct platform_device *pdev)
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
+	clk_data = mtk_devm_alloc_clk_data(dev, MT8167_CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (ret)
+		return ret;
+
+	ret = mtk_clk_register_dividers(adj_divs, ARRAY_SIZE(adj_divs), base,
+					&mt8167_apmixed_clk_lock, clk_data);
+	if (ret)
+		goto unregister_plls;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_dividers;
+
+	return 0;
+
+unregister_dividers:
+	mtk_clk_unregister_dividers(adj_divs, ARRAY_SIZE(adj_divs), clk_data);
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+
+	return ret;
+}
+
+static const struct of_device_id of_match_clk_mt8167_apmixed[] = {
+	{ .compatible = "mediatek,mt8167-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8167_apmixed_drv = {
+	.probe = clk_mt8167_apmixed_probe,
+	.driver = {
+		.name = "clk-mt8167-apmixed",
+		.of_match_table = of_match_clk_mt8167_apmixed,
+	},
+};
+builtin_platform_driver(clk_mt8167_apmixed_drv)
diff --git a/drivers/clk/mediatek/clk-mt8167.c b/drivers/clk/mediatek/clk-mt8167.c
index 97a443fdfc77..f49456a88c4a 100644
--- a/drivers/clk/mediatek/clk-mt8167.c
+++ b/drivers/clk/mediatek/clk-mt8167.c
@@ -14,7 +14,6 @@
 
 #include "clk-gate.h"
 #include "clk-mtk.h"
-#include "clk-pll.h"
 
 #include <dt-bindings/clock/mt8167-clk.h>
 
@@ -685,21 +684,6 @@ static const struct mtk_clk_divider top_adj_divs[] = {
 		0x0078, 0, 8),
 };
 
-#define DIV_ADJ_FLAG(_id, _name, _parent, _reg, _shift, _width, _flag) {	\
-		.id = _id,					\
-		.name = _name,					\
-		.parent_name = _parent,				\
-		.div_reg = _reg,				\
-		.div_shift = _shift,				\
-		.div_width = _width,				\
-		.clk_divider_flags = _flag,				\
-}
-
-static const struct mtk_clk_divider apmixed_adj_divs[] = {
-	DIV_ADJ_FLAG(CLK_APMIXED_HDMI_REF, "hdmi_ref", "tvdpll",
-		0x1c4, 24, 3, CLK_DIVIDER_POWER_OF_TWO),
-};
-
 static const struct mtk_gate_regs top0_cg_regs = {
 	.set_ofs = 0x50,
 	.clr_ofs = 0x80,
@@ -937,89 +921,3 @@ static void __init mtk_infracfg_init(struct device_node *node)
 			__func__, r);
 }
 CLK_OF_DECLARE(mtk_infracfg, "mediatek,mt8167-infracfg", mtk_infracfg_init);
-
-#define MT8167_PLL_FMAX		(2500UL * MHZ)
-
-#define CON0_MT8167_RST_BAR	BIT(27)
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
-		.rst_bar_mask = CON0_MT8167_RST_BAR,			\
-		.fmax = MT8167_PLL_FMAX,				\
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
-	{ .div = 0, .freq = MT8167_PLL_FMAX },
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
-	PLL(CLK_APMIXED_TVDPLL, "tvdpll", 0x01C0, 0x01D0, 0, 0,
-		21, 0x01C4, 24, 0, 0x01C4, 0),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x01E0, 0x01F0, 0, 0,
-		21, 0x01E4, 24, 0, 0x01E4, 0),
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
-	clk_data = mtk_alloc_clk_data(MT8167_CLK_APMIXED_NR_CLK);
-
-	mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	mtk_clk_register_dividers(apmixed_adj_divs, ARRAY_SIZE(apmixed_adj_divs),
-		base, &mt8167_clk_lock, clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-}
-CLK_OF_DECLARE(mtk_apmixedsys, "mediatek,mt8167-apmixedsys",
-		mtk_apmixedsys_init);
-- 
2.39.1

