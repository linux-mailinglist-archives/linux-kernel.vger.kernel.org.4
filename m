Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A0B68C16D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:30:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbjBFPau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjBFPaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:30:18 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98C02A151;
        Mon,  6 Feb 2023 07:30:02 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8AD986602D99;
        Mon,  6 Feb 2023 15:30:00 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697401;
        bh=Tgy4IbGAfY6efE2gs67l9vy2ntRVs3xc9XOtrPK1ojY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b9N2szdiUgYP7MsseAjXAMzCXf3UsAUL02xausjmi+ZMh4BX5mFIG2nNwNGzbg8D9
         dYObtYyJp8/o6HVISq4G+G4yUOJuaCqmO+vGU2WpLy7BL7ibqQeNzX886Yvh6mpENw
         GiwKeEjDNmvIDR8FmTOhF63StV8FoTqsgrYY/FmPhYILgg6LbHo3leEjcj5bcAmANF
         KHHvb4EKugrq9wiW5nasBjLUUkJjqYx0fGm7kW7DWeQ4A2I++S9/Wj5zIu1Hn1sPv3
         srtU6onJv/lVSNBbiVN/DONmFAKYqPENoAt069U4EnJtXPGBZBDNEMQtD9DNmms9ON
         GSNDih9XWXtbg==
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
Subject: [PATCH v1 11/45] clk: mediatek: mt8365: Move apmixedsys clock driver to its own file
Date:   Mon,  6 Feb 2023 16:28:54 +0100
Message-Id: <20230206152928.918562-12-angelogioacchino.delregno@collabora.com>
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

In preparation for migrating all other mt8365 clocks to the common
mtk_clk_simple_probe(), move apmixedsys clocks to a different file.
While at it, use the builtin_platform_driver() macro for it.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Makefile                |   2 +-
 drivers/clk/mediatek/clk-mt8365-apmixedsys.c | 164 +++++++++++++++++++
 drivers/clk/mediatek/clk-mt8365.c            | 142 ----------------
 3 files changed, 165 insertions(+), 143 deletions(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8365-apmixedsys.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 3c7dd19cdddf..b004a47026d4 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -112,7 +112,7 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
 				   clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
 				   clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
 				   clk-mt8195-apusys_pll.o
-obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365.o
+obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365.o clk-mt8365-apmixedsys.o
 obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
 obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8365_MFG) += clk-mt8365-mfg.o
diff --git a/drivers/clk/mediatek/clk-mt8365-apmixedsys.c b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
new file mode 100644
index 000000000000..6f0fdf92bbd2
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8365-apmixedsys.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Copyright (c) 2023 Collabora Ltd.
+ */
+
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+#include "clk-pll.h"
+#include "clk-mtk.h"
+
+#define MT8365_PLL_FMAX		(3800UL * MHZ)
+#define MT8365_PLL_FMIN		(1500UL * MHZ)
+#define CON0_MT8365_RST_BAR	BIT(23)
+
+#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+		_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,		\
+		_tuner_en_bit,	_pcw_reg, _pcw_shift, _div_table,	\
+		_rst_bar_mask, _pcw_chg_reg) {				\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = _rst_bar_mask,				\
+		.fmax = MT8365_PLL_FMAX,				\
+		.fmin = MT8365_PLL_FMIN,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = 8,						\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcw_chg_reg = _pcw_chg_reg,				\
+		.div_table = _div_table,				\
+	}
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+			_pd_reg, _pd_shift, _tuner_reg,			\
+			_tuner_en_reg, _tuner_en_bit, _pcw_reg,		\
+			_pcw_shift, _rst_bar_mask, _pcw_chg_reg)	\
+		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
+			_pcwbits, _pd_reg, _pd_shift,			\
+			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
+			_pcw_reg, _pcw_shift, NULL, _rst_bar_mask,	\
+			_pcw_chg_reg)					\
+
+static const struct mtk_pll_div_table armpll_div_table[] = {
+	{ .div = 0, .freq = MT8365_PLL_FMAX },
+	{ .div = 1, .freq = 1500 * MHZ },
+	{ .div = 2, .freq = 750 * MHZ },
+	{ .div = 3, .freq = 375 * MHZ },
+	{ .div = 4, .freq = 182500000 },
+	{ } /* sentinel */
+};
+
+static const struct mtk_pll_div_table mfgpll_div_table[] = {
+	{ .div = 0, .freq = MT8365_PLL_FMAX },
+	{ .div = 1, .freq = 1600 * MHZ },
+	{ .div = 2, .freq = 800 * MHZ },
+	{ .div = 3, .freq = 400 * MHZ },
+	{ .div = 4, .freq = 200 * MHZ },
+	{ } /* sentinel */
+};
+
+static const struct mtk_pll_div_table dsppll_div_table[] = {
+	{ .div = 0, .freq = MT8365_PLL_FMAX },
+	{ .div = 1, .freq = 1600 * MHZ },
+	{ .div = 2, .freq = 600 * MHZ },
+	{ .div = 3, .freq = 400 * MHZ },
+	{ .div = 4, .freq = 200 * MHZ },
+	{ } /* sentinel */
+};
+
+static const struct mtk_pll_data plls[] = {
+	PLL_B(CLK_APMIXED_ARMPLL, "armpll", 0x030C, 0x0318, 0x00000001, PLL_AO,
+	      22, 0x0310, 24, 0, 0, 0, 0x0310, 0, armpll_div_table, 0, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0228, 0x0234, 0xFF000001,
+	    HAVE_RST_BAR, 22, 0x022C, 24, 0, 0, 0, 0x022C, 0, CON0_MT8365_RST_BAR, 0),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll2", 0x0208, 0x0214, 0xFF000001,
+	    HAVE_RST_BAR, 22, 0x020C, 24, 0, 0, 0, 0x020C, 0, CON0_MT8365_RST_BAR, 0),
+	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0218, 0x0224, 0x00000001, 0, 22,
+	      0x021C, 24, 0, 0, 0, 0x021C, 0, mfgpll_div_table, 0, 0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0350, 0x035C, 0x00000001, 0, 22,
+	    0x0354, 24, 0, 0, 0, 0x0354, 0, 0, 0),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0330, 0x033C, 0x00000001, 0, 22,
+	    0x0334, 24, 0, 0, 0, 0x0334, 0, 0, 0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x031C, 0x032C, 0x00000001, 0, 32,
+	    0x0320, 24, 0x0040, 0x000C, 0, 0x0324, 0, 0, 0x0320),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x0360, 0x0370, 0x00000001, 0, 32,
+	    0x0364, 24, 0x004C, 0x000C, 5, 0x0368, 0, 0, 0x0364),
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0374, 0x0380, 0x00000001, 0, 22,
+	    0x0378, 24, 0, 0, 0, 0x0378, 0, 0, 0),
+	PLL_B(CLK_APMIXED_DSPPLL, "dsppll", 0x0390, 0x039C, 0x00000001, 0, 22,
+	      0x0394, 24, 0, 0, 0, 0x0394, 0, dsppll_div_table, 0, 0),
+	PLL(CLK_APMIXED_APUPLL, "apupll", 0x03A0, 0x03AC, 0x00000001, 0, 22,
+	    0x03A4, 24, 0, 0, 0, 0x03A4, 0, 0, 0),
+};
+
+static int clk_mt8365_apmixed_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	struct device *dev = &pdev->dev;
+	struct clk_hw *hw;
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
+	hw = devm_clk_hw_register_gate(dev, "univ_en", "univpll2", 0,
+				       base + 0x204, 0, 0, NULL);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	clk_data->hws[CLK_APMIXED_UNIV_EN] = hw;
+
+	hw = devm_clk_hw_register_gate(dev, "usb20_en", "univ_en", 0,
+				       base + 0x204, 1, 0, NULL);
+	if (IS_ERR(hw))
+		return PTR_ERR(hw);
+	clk_data->hws[CLK_APMIXED_USB20_EN] = hw;
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
+static const struct of_device_id of_match_clk_mt8365_apmixed[] = {
+	{ .compatible = "mediatek,mt8365-apmixedsys" },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8365_apmixed_drv = {
+	.probe = clk_mt8365_apmixed_probe,
+	.driver = {
+		.name = "clk-mt8365-apmixed",
+		.of_match_table = of_match_clk_mt8365_apmixed,
+	},
+};
+builtin_platform_driver(clk_mt8365_apmixed_drv)
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index c9faa07ec0a6..69f293497778 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -757,145 +757,6 @@ static const struct mtk_simple_gate peri_clks[] = {
 	{ CLK_PERIAXI, "periaxi", "axi_sel", 0x20c, 31, 0 },
 };
 
-#define MT8365_PLL_FMAX		(3800UL * MHZ)
-#define MT8365_PLL_FMIN		(1500UL * MHZ)
-#define CON0_MT8365_RST_BAR	BIT(23)
-
-#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
-		_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,		\
-		_tuner_en_bit,	_pcw_reg, _pcw_shift, _div_table,	\
-		_rst_bar_mask, _pcw_chg_reg) {				\
-		.id = _id,						\
-		.name = _name,						\
-		.reg = _reg,						\
-		.pwr_reg = _pwr_reg,					\
-		.en_mask = _en_mask,					\
-		.flags = _flags,					\
-		.rst_bar_mask = _rst_bar_mask,				\
-		.fmax = MT8365_PLL_FMAX,				\
-		.fmin = MT8365_PLL_FMIN,				\
-		.pcwbits = _pcwbits,					\
-		.pcwibits = 8,						\
-		.pd_reg = _pd_reg,					\
-		.pd_shift = _pd_shift,					\
-		.tuner_reg = _tuner_reg,				\
-		.tuner_en_reg = _tuner_en_reg,				\
-		.tuner_en_bit = _tuner_en_bit,				\
-		.pcw_reg = _pcw_reg,					\
-		.pcw_shift = _pcw_shift,				\
-		.pcw_chg_reg = _pcw_chg_reg,				\
-		.div_table = _div_table,				\
-	}
-
-#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
-			_pd_reg, _pd_shift, _tuner_reg,			\
-			_tuner_en_reg, _tuner_en_bit, _pcw_reg,		\
-			_pcw_shift, _rst_bar_mask, _pcw_chg_reg)	\
-		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
-			_pcwbits, _pd_reg, _pd_shift,			\
-			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
-			_pcw_reg, _pcw_shift, NULL, _rst_bar_mask,	\
-			_pcw_chg_reg)					\
-
-static const struct mtk_pll_div_table armpll_div_table[] = {
-	{ .div = 0, .freq = MT8365_PLL_FMAX },
-	{ .div = 1, .freq = 1500 * MHZ },
-	{ .div = 2, .freq = 750 * MHZ },
-	{ .div = 3, .freq = 375 * MHZ },
-	{ .div = 4, .freq = 182500000 },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_div_table mfgpll_div_table[] = {
-	{ .div = 0, .freq = MT8365_PLL_FMAX },
-	{ .div = 1, .freq = 1600 * MHZ },
-	{ .div = 2, .freq = 800 * MHZ },
-	{ .div = 3, .freq = 400 * MHZ },
-	{ .div = 4, .freq = 200 * MHZ },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_div_table dsppll_div_table[] = {
-	{ .div = 0, .freq = MT8365_PLL_FMAX },
-	{ .div = 1, .freq = 1600 * MHZ },
-	{ .div = 2, .freq = 600 * MHZ },
-	{ .div = 3, .freq = 400 * MHZ },
-	{ .div = 4, .freq = 200 * MHZ },
-	{ } /* sentinel */
-};
-
-static const struct mtk_pll_data plls[] = {
-	PLL_B(CLK_APMIXED_ARMPLL, "armpll", 0x030C, 0x0318, 0x00000001, PLL_AO,
-	      22, 0x0310, 24, 0, 0, 0, 0x0310, 0, armpll_div_table, 0, 0),
-	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0228, 0x0234, 0xFF000001,
-	    HAVE_RST_BAR, 22, 0x022C, 24, 0, 0, 0, 0x022C, 0,
-	    CON0_MT8365_RST_BAR, 0),
-	PLL(CLK_APMIXED_UNIVPLL, "univpll2", 0x0208, 0x0214, 0xFF000001,
-	    HAVE_RST_BAR, 22, 0x020C, 24, 0, 0, 0, 0x020C, 0,
-	    CON0_MT8365_RST_BAR, 0),
-	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0218, 0x0224, 0x00000001, 0, 22,
-	      0x021C, 24, 0, 0, 0, 0x021C, 0, mfgpll_div_table, 0, 0),
-	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0350, 0x035C, 0x00000001, 0, 22,
-	    0x0354, 24, 0, 0, 0, 0x0354, 0, 0, 0),
-	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0330, 0x033C, 0x00000001, 0, 22,
-	    0x0334, 24, 0, 0, 0, 0x0334, 0, 0, 0),
-	PLL(CLK_APMIXED_APLL1, "apll1", 0x031C, 0x032C, 0x00000001, 0, 32,
-	    0x0320, 24, 0x0040, 0x000C, 0, 0x0324, 0, 0, 0x0320),
-	PLL(CLK_APMIXED_APLL2, "apll2", 0x0360, 0x0370, 0x00000001, 0, 32,
-	    0x0364, 24, 0x004C, 0x000C, 5, 0x0368, 0, 0, 0x0364),
-	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0374, 0x0380, 0x00000001, 0, 22,
-	    0x0378, 24, 0, 0, 0, 0x0378, 0, 0, 0),
-	PLL_B(CLK_APMIXED_DSPPLL, "dsppll", 0x0390, 0x039C, 0x00000001, 0, 22,
-	      0x0394, 24, 0, 0, 0, 0x0394, 0, dsppll_div_table, 0, 0),
-	PLL(CLK_APMIXED_APUPLL, "apupll", 0x03A0, 0x03AC, 0x00000001, 0, 22,
-	    0x03A4, 24, 0, 0, 0, 0x03A4, 0, 0, 0),
-};
-
-static int clk_mt8365_apmixed_probe(struct platform_device *pdev)
-{
-	void __iomem *base;
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	struct device *dev = &pdev->dev;
-	struct clk_hw *hw;
-	int ret;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	clk_data = mtk_devm_alloc_clk_data(dev, CLK_APMIXED_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	hw = devm_clk_hw_register_gate(dev, "univ_en", "univpll2", 0,
-				       base + 0x204, 0, 0, NULL);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-	clk_data->hws[CLK_APMIXED_UNIV_EN] = hw;
-
-	hw = devm_clk_hw_register_gate(dev, "usb20_en", "univ_en", 0,
-				       base + 0x204, 1, 0, NULL);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
-	clk_data->hws[CLK_APMIXED_USB20_EN] = hw;
-
-	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
-	if (ret)
-		return ret;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_plls;
-
-	return 0;
-
-unregister_plls:
-	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
-
-	return ret;
-}
-
 static int
 clk_mt8365_register_mtk_simple_gates(struct device *dev, void __iomem *base,
 				     struct clk_hw_onecell_data *clk_data,
@@ -1104,9 +965,6 @@ static int clk_mt8365_mcu_probe(struct platform_device *pdev)
 
 static const struct of_device_id of_match_clk_mt8365[] = {
 	{
-		.compatible = "mediatek,mt8365-apmixedsys",
-		.data = clk_mt8365_apmixed_probe,
-	}, {
 		.compatible = "mediatek,mt8365-topckgen",
 		.data = clk_mt8365_top_probe,
 	}, {
-- 
2.39.1

