Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ECF65405E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Dec 2022 12:56:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235788AbiLVL4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Dec 2022 06:56:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235522AbiLVLzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Dec 2022 06:55:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC102CC9C;
        Thu, 22 Dec 2022 03:49:38 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9E8D46602CDF;
        Thu, 22 Dec 2022 11:49:35 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671709777;
        bh=9AMGeEobxZAlGGSxOjtTru9sFdkLsAzlzcePTMEUc+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nduLXxZxZaVgkBjNh4b3WeQbTbVnXkrZlUE8lYvsovTcpxvXJsXHkNeIXkSBeIk44
         2Rty2NW3+eYLWKPCzq3K7jsqH/hjiPsVnYoD7H6UOcCBHzteG9qzXAiwspuB1rBIYC
         y2livRTy82nG5HFWvVct/wkSdbJGJfLXOkaH4N6qFRP6xOZbrFLzeQHyyJDAcHGwTw
         l2MC2X3gjTTnkGsaaBjD3EnivZLXye0X2yJ38PjD7hx52g8bHKJZoih8QmB6ffXEUV
         mUN63BkZctQi+0VEhK/Qn/bAVjVCXjqgCwrtwVAMOccZiHg18bx2A3F6DauoJvYrm5
         +OBXnR1VFkipQ==
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
Subject: [PATCH v1 13/25] clk: mediatek: Switch to mtk_clk_simple_probe() where possible
Date:   Thu, 22 Dec 2022 12:48:45 +0100
Message-Id: <20221222114857.120060-14-angelogioacchino.delregno@collabora.com>
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

mtk_clk_simple_probe() is a function that registers mtk gate clocks
and, if reset data is present, a reset controller and across all of
the MTK clock drivers, such a function is duplicated many times:
switch to the common mtk_clk_simple_probe() function for all of the
clock drivers that are registering as platform drivers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701-aud.c   | 26 +++----
 drivers/clk/mediatek/clk-mt2701-eth.c   | 34 +++------
 drivers/clk/mediatek/clk-mt2701-g3d.c   | 56 +++-----------
 drivers/clk/mediatek/clk-mt2701-hif.c   | 36 +++------
 drivers/clk/mediatek/clk-mt2712.c       | 83 ++++++++-------------
 drivers/clk/mediatek/clk-mt6779.c       | 42 ++++++-----
 drivers/clk/mediatek/clk-mt7622-aud.c   | 49 +++----------
 drivers/clk/mediatek/clk-mt7622-eth.c   | 82 ++++-----------------
 drivers/clk/mediatek/clk-mt7622-hif.c   | 85 ++++-----------------
 drivers/clk/mediatek/clk-mt7629-hif.c   | 85 ++++-----------------
 drivers/clk/mediatek/clk-mt8183-audio.c | 19 +++--
 drivers/clk/mediatek/clk-mt8183.c       | 75 ++++++++-----------
 drivers/clk/mediatek/clk-mt8192-aud.c   | 25 +++----
 drivers/clk/mediatek/clk-mt8192.c       | 98 ++++++++-----------------
 14 files changed, 236 insertions(+), 559 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-aud.c b/drivers/clk/mediatek/clk-mt2701-aud.c
index ab13ab618fb5..1fd6d96b34dc 100644
--- a/drivers/clk/mediatek/clk-mt2701-aud.c
+++ b/drivers/clk/mediatek/clk-mt2701-aud.c
@@ -76,6 +76,7 @@ static const struct mtk_gate_regs audio3_cg_regs = {
 };
 
 static const struct mtk_gate audio_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "aud_dummy"),
 	/* AUDIO0 */
 	GATE_AUDIO0(CLK_AUD_AFE, "audio_afe", "aud_intbus_sel", 2),
 	GATE_AUDIO0(CLK_AUD_HDMI, "audio_hdmi", "audpll_sel", 20),
@@ -138,29 +139,26 @@ static const struct mtk_gate audio_clks[] = {
 	GATE_AUDIO3(CLK_AUD_MEM_ASRC5, "audio_mem_asrc5", "asm_h_sel", 14),
 };
 
+static const struct mtk_clk_desc audio_desc = {
+	.clks = audio_clks,
+	.num_clks = ARRAY_SIZE(audio_clks),
+};
+
 static const struct of_device_id of_match_clk_mt2701_aud[] = {
-	{ .compatible = "mediatek,mt2701-audsys", },
-	{}
+	{ .compatible = "mediatek,mt2701-audsys", .data = &audio_desc },
+	{ /* sentinel */ }
 };
 
 static int clk_mt2701_aud_probe(struct platform_device *pdev)
 {
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_AUD_NR);
-
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = mtk_clk_simple_probe(pdev);
 	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
-
-		goto err_clk_provider;
+		return r;
 	}
 
 	r = devm_of_platform_populate(&pdev->dev);
@@ -170,13 +168,13 @@ static int clk_mt2701_aud_probe(struct platform_device *pdev)
 	return 0;
 
 err_plat_populate:
-	of_clk_del_provider(node);
-err_clk_provider:
+	mtk_clk_simple_remove(pdev);
 	return r;
 }
 
 static struct platform_driver clk_mt2701_aud_drv = {
 	.probe = clk_mt2701_aud_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-aud",
 		.of_match_table = of_match_clk_mt2701_aud,
diff --git a/drivers/clk/mediatek/clk-mt2701-eth.c b/drivers/clk/mediatek/clk-mt2701-eth.c
index 9670e1e170f2..bd3fddf53ce1 100644
--- a/drivers/clk/mediatek/clk-mt2701-eth.c
+++ b/drivers/clk/mediatek/clk-mt2701-eth.c
@@ -26,6 +26,7 @@ static const struct mtk_gate_regs eth_cg_regs = {
 	}
 
 static const struct mtk_gate eth_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "eth_dummy"),
 	GATE_ETH(CLK_ETHSYS_HSDMA, "hsdma_clk", "ethif_sel", 5),
 	GATE_ETH(CLK_ETHSYS_ESW, "esw_clk", "ethpll_500m_ck", 6),
 	GATE_ETH(CLK_ETHSYS_GP2, "gp2_clk", "trgpll", 7),
@@ -44,35 +45,20 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
+static const struct mtk_clk_desc eth_desc = {
+	.clks = eth_clks,
+	.num_clks = ARRAY_SIZE(eth_clks),
+	.rst_desc = &clk_rst_desc,
+};
+
 static const struct of_device_id of_match_clk_mt2701_eth[] = {
-	{ .compatible = "mediatek,mt2701-ethsys", },
+	{ .compatible = "mediatek,mt2701-ethsys", .data = &eth_desc },
 	{}
 };
 
-static int clk_mt2701_eth_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_ETHSYS_NR);
-
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-						clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-
-	return r;
-}
-
 static struct platform_driver clk_mt2701_eth_drv = {
-	.probe = clk_mt2701_eth_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-eth",
 		.of_match_table = of_match_clk_mt2701_eth,
diff --git a/drivers/clk/mediatek/clk-mt2701-g3d.c b/drivers/clk/mediatek/clk-mt2701-g3d.c
index 11391b144267..499a170ba5f9 100644
--- a/drivers/clk/mediatek/clk-mt2701-g3d.c
+++ b/drivers/clk/mediatek/clk-mt2701-g3d.c
@@ -32,6 +32,7 @@ static const struct mtk_gate_regs g3d_cg_regs = {
 };
 
 static const struct mtk_gate g3d_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "g3d_dummy"),
 	GATE_G3D(CLK_G3DSYS_CORE, "g3d_core", "mfg_sel", 0),
 };
 
@@ -43,57 +44,20 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
-static int clk_mt2701_g3dsys_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_G3DSYS_NR);
-
-	mtk_clk_register_gates(node, g3d_clks, ARRAY_SIZE(g3d_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-
-	return r;
-}
+static const struct mtk_clk_desc g3d_desc = {
+	.clks = g3d_clks,
+	.num_clks = ARRAY_SIZE(g3d_clks),
+	.rst_desc = &clk_rst_desc,
+};
 
 static const struct of_device_id of_match_clk_mt2701_g3d[] = {
-	{
-		.compatible = "mediatek,mt2701-g3dsys",
-		.data = clk_mt2701_g3dsys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt2701-g3dsys", .data = &g3d_desc },
+	{ /* sentinel */ }
 };
 
-static int clk_mt2701_g3d_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt2701_g3d_drv = {
-	.probe = clk_mt2701_g3d_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-g3d",
 		.of_match_table = of_match_clk_mt2701_g3d,
diff --git a/drivers/clk/mediatek/clk-mt2701-hif.c b/drivers/clk/mediatek/clk-mt2701-hif.c
index c14c0bb10f88..5d113838b3e4 100644
--- a/drivers/clk/mediatek/clk-mt2701-hif.c
+++ b/drivers/clk/mediatek/clk-mt2701-hif.c
@@ -26,6 +26,7 @@ static const struct mtk_gate_regs hif_cg_regs = {
 	}
 
 static const struct mtk_gate hif_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "hif_dummy"),
 	GATE_HIF(CLK_HIFSYS_USB0PHY, "usb0_phy_clk", "ethpll_500m_ck", 21),
 	GATE_HIF(CLK_HIFSYS_USB1PHY, "usb1_phy_clk", "ethpll_500m_ck", 22),
 	GATE_HIF(CLK_HIFSYS_PCIE0, "pcie0_clk", "ethpll_500m_ck", 24),
@@ -41,37 +42,20 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
+static const struct mtk_clk_desc hif_desc = {
+	.clks = hif_clks,
+	.num_clks = ARRAY_SIZE(hif_clks),
+	.rst_desc = &clk_rst_desc,
+};
+
 static const struct of_device_id of_match_clk_mt2701_hif[] = {
-	{ .compatible = "mediatek,mt2701-hifsys", },
+	{ .compatible = "mediatek,mt2701-hifsys", .data = &hif_desc },
 	{}
 };
 
-static int clk_mt2701_hif_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_HIFSYS_NR);
-
-	mtk_clk_register_gates(node, hif_clks, ARRAY_SIZE(hif_clks),
-						clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r) {
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-		return r;
-	}
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-
-	return 0;
-}
-
 static struct platform_driver clk_mt2701_hif_drv = {
-	.probe = clk_mt2701_hif_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt2701-hif",
 		.of_match_table = of_match_clk_mt2701_hif,
diff --git a/drivers/clk/mediatek/clk-mt2712.c b/drivers/clk/mediatek/clk-mt2712.c
index 5cadcf6ca9b7..c4bee791f570 100644
--- a/drivers/clk/mediatek/clk-mt2712.c
+++ b/drivers/clk/mediatek/clk-mt2712.c
@@ -1362,50 +1362,6 @@ static int clk_mt2712_top_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt2712_infra_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[0]);
-
-	return r;
-}
-
-static int clk_mt2712_peri_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
-
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc[1]);
-
-	return r;
-}
-
 static int clk_mt2712_mcu_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -1440,12 +1396,6 @@ static const struct of_device_id of_match_clk_mt2712[] = {
 	}, {
 		.compatible = "mediatek,mt2712-topckgen",
 		.data = clk_mt2712_top_probe,
-	}, {
-		.compatible = "mediatek,mt2712-infracfg",
-		.data = clk_mt2712_infra_probe,
-	}, {
-		.compatible = "mediatek,mt2712-pericfg",
-		.data = clk_mt2712_peri_probe,
 	}, {
 		.compatible = "mediatek,mt2712-mcucfg",
 		.data = clk_mt2712_mcu_probe,
@@ -1472,6 +1422,33 @@ static int clk_mt2712_probe(struct platform_device *pdev)
 	return r;
 }
 
+static const struct mtk_clk_desc infra_desc = {
+	.clks = infra_clks,
+	.num_clks = ARRAY_SIZE(infra_clks),
+	.rst_desc = &clk_rst_desc[0],
+};
+
+static const struct mtk_clk_desc peri_desc = {
+	.clks = peri_clks,
+	.num_clks = ARRAY_SIZE(peri_clks),
+	.rst_desc = &clk_rst_desc[1],
+};
+
+static const struct of_device_id of_match_clk_mt2712_simple[] = {
+	{ .compatible = "mediatek,mt2712-infracfg", .data = &infra_desc },
+	{ .compatible = "mediatek,mt2712-pericfg", .data = &peri_desc, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt2712_simple_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt2712-simple",
+		.of_match_table = of_match_clk_mt2712_simple,
+	},
+};
+
 static struct platform_driver clk_mt2712_drv = {
 	.probe = clk_mt2712_probe,
 	.driver = {
@@ -1482,7 +1459,11 @@ static struct platform_driver clk_mt2712_drv = {
 
 static int __init clk_mt2712_init(void)
 {
-	return platform_driver_register(&clk_mt2712_drv);
+	int ret = platform_driver_register(&clk_mt2712_drv);
+
+	if (ret)
+		return ret;
+	return platform_driver_register(&clk_mt2712_simple_drv);
 }
 
 arch_initcall(clk_mt2712_init);
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 6d1fb19be77b..479fb38766ea 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -880,6 +880,7 @@ static const struct mtk_gate_regs infra3_cg_regs = {
 		&mtk_clk_gate_ops_setclr)
 
 static const struct mtk_gate infra_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "ifa_dummy"),
 	/* INFRA0 */
 	GATE_INFRA0(CLK_INFRA_PMIC_TMR, "infra_pmic_tmr",
 		    "axi_sel", 0),
@@ -1256,19 +1257,6 @@ static int clk_mt6779_top_probe(struct platform_device *pdev)
 	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 }
 
-static int clk_mt6779_infra_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-			       clk_data, &pdev->dev);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
-
 static const struct of_device_id of_match_clk_mt6779[] = {
 	{
 		.compatible = "mediatek,mt6779-apmixed",
@@ -1276,9 +1264,6 @@ static const struct of_device_id of_match_clk_mt6779[] = {
 	}, {
 		.compatible = "mediatek,mt6779-topckgen",
 		.data = clk_mt6779_top_probe,
-	}, {
-		.compatible = "mediatek,mt6779-infracfg_ao",
-		.data = clk_mt6779_infra_probe,
 	}, {
 		/* sentinel */
 	}
@@ -1302,6 +1287,25 @@ static int clk_mt6779_probe(struct platform_device *pdev)
 	return r;
 }
 
+static const struct mtk_clk_desc infra_desc = {
+	.clks = infra_clks,
+	.num_clks = ARRAY_SIZE(infra_clks),
+};
+
+static const struct of_device_id of_match_clk_mt6779_infra[] = {
+	{ .compatible = "mediatek,mt6779-infracfg_ao", .data = &infra_desc },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt6779_infra_drv  = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt6779-infra",
+		.of_match_table = of_match_clk_mt6779_infra,
+	},
+};
+
 static struct platform_driver clk_mt6779_drv = {
 	.probe = clk_mt6779_probe,
 	.driver = {
@@ -1312,7 +1316,11 @@ static struct platform_driver clk_mt6779_drv = {
 
 static int __init clk_mt6779_init(void)
 {
-	return platform_driver_register(&clk_mt6779_drv);
+	int ret = platform_driver_register(&clk_mt6779_drv);
+
+	if (ret)
+		return ret;
+	return platform_driver_register(&clk_mt6779_infra_drv);
 }
 
 arch_initcall(clk_mt6779_init);
diff --git a/drivers/clk/mediatek/clk-mt7622-aud.c b/drivers/clk/mediatek/clk-mt7622-aud.c
index d0379d8704af..86464cc750e2 100644
--- a/drivers/clk/mediatek/clk-mt7622-aud.c
+++ b/drivers/clk/mediatek/clk-mt7622-aud.c
@@ -130,24 +130,21 @@ static const struct mtk_gate audio_clks[] = {
 	GATE_AUDIO3(CLK_AUDIO_MEM_ASRC5, "audio_mem_asrc5", "asm_h_sel", 14),
 };
 
-static int clk_mt7622_audiosys_init(struct platform_device *pdev)
+static const struct mtk_clk_desc audio_desc = {
+	.clks = audio_clks,
+	.num_clks = ARRAY_SIZE(audio_clks),
+};
+
+static int clk_mt7622_aud_probe(struct platform_device *pdev)
 {
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
-
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = mtk_clk_simple_probe(pdev);
 	if (r) {
 		dev_err(&pdev->dev,
 			"could not register clock provider: %s: %d\n",
 			pdev->name, r);
-
-		goto err_clk_provider;
+		return r;
 	}
 
 	r = devm_of_platform_populate(&pdev->dev);
@@ -157,40 +154,18 @@ static int clk_mt7622_audiosys_init(struct platform_device *pdev)
 	return 0;
 
 err_plat_populate:
-	of_clk_del_provider(node);
-err_clk_provider:
+	mtk_clk_simple_remove(pdev);
 	return r;
 }
 
 static const struct of_device_id of_match_clk_mt7622_aud[] = {
-	{
-		.compatible = "mediatek,mt7622-audsys",
-		.data = clk_mt7622_audiosys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt7622-audsys", .data = &audio_desc },
+	{ /* sentinel */ }
 };
 
-static int clk_mt7622_aud_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_aud_drv = {
 	.probe = clk_mt7622_aud_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-aud",
 		.of_match_table = of_match_clk_mt7622_aud,
diff --git a/drivers/clk/mediatek/clk-mt7622-eth.c b/drivers/clk/mediatek/clk-mt7622-eth.c
index 9b4a26ca0f44..7dd0cec802f7 100644
--- a/drivers/clk/mediatek/clk-mt7622-eth.c
+++ b/drivers/clk/mediatek/clk-mt7622-eth.c
@@ -73,80 +73,26 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
-static int clk_mt7622_ethsys_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_ETH_NR_CLK);
-
-	mtk_clk_register_gates(node, eth_clks, ARRAY_SIZE(eth_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-
-	return r;
-}
-
-static int clk_mt7622_sgmiisys_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_SGMII_NR_CLK);
-
-	mtk_clk_register_gates(node, sgmii_clks, ARRAY_SIZE(sgmii_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
+static const struct mtk_clk_desc eth_desc = {
+	.clks = eth_clks,
+	.num_clks = ARRAY_SIZE(eth_clks),
+	.rst_desc = &clk_rst_desc,
+};
 
-	return r;
-}
+static const struct mtk_clk_desc sgmii_desc = {
+	.clks = eth_clks,
+	.num_clks = ARRAY_SIZE(sgmii_clks),
+};
 
 static const struct of_device_id of_match_clk_mt7622_eth[] = {
-	{
-		.compatible = "mediatek,mt7622-ethsys",
-		.data = clk_mt7622_ethsys_init,
-	}, {
-		.compatible = "mediatek,mt7622-sgmiisys",
-		.data = clk_mt7622_sgmiisys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt7622-ethsys", .data = &eth_desc },
+	{ .compatible = "mediatek,mt7622-sgmiisys", .data = &sgmii_desc },
+	{ /* sentinel */ }
 };
 
-static int clk_mt7622_eth_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_eth_drv = {
-	.probe = clk_mt7622_eth_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-eth",
 		.of_match_table = of_match_clk_mt7622_eth,
diff --git a/drivers/clk/mediatek/clk-mt7622-hif.c b/drivers/clk/mediatek/clk-mt7622-hif.c
index 8cf37f75ca77..ab5cad0c2b1c 100644
--- a/drivers/clk/mediatek/clk-mt7622-hif.c
+++ b/drivers/clk/mediatek/clk-mt7622-hif.c
@@ -84,82 +84,27 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
-static int clk_mt7622_ssusbsys_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
-
-	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-
-	return r;
-}
-
-static int clk_mt7622_pciesys_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
-
-	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+static const struct mtk_clk_desc ssusb_desc = {
+	.clks = ssusb_clks,
+	.num_clks = ARRAY_SIZE(ssusb_clks),
+	.rst_desc = &clk_rst_desc,
+};
 
-	return r;
-}
+static const struct mtk_clk_desc pcie_desc = {
+	.clks = pcie_clks,
+	.num_clks = ARRAY_SIZE(pcie_clks),
+	.rst_desc = &clk_rst_desc,
+};
 
 static const struct of_device_id of_match_clk_mt7622_hif[] = {
-	{
-		.compatible = "mediatek,mt7622-pciesys",
-		.data = clk_mt7622_pciesys_init,
-	}, {
-		.compatible = "mediatek,mt7622-ssusbsys",
-		.data = clk_mt7622_ssusbsys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt7622-pciesys", .data = &pcie_desc },
+	{ .compatible = "mediatek,mt7622-ssusbsys", .data = &ssusb_desc },
+	{ /* sentinel */ }
 };
 
-static int clk_mt7622_hif_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7622_hif_drv = {
-	.probe = clk_mt7622_hif_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7622-hif",
 		.of_match_table = of_match_clk_mt7622_hif,
diff --git a/drivers/clk/mediatek/clk-mt7629-hif.c b/drivers/clk/mediatek/clk-mt7629-hif.c
index 44fbd88b4647..c3eb09ea6036 100644
--- a/drivers/clk/mediatek/clk-mt7629-hif.c
+++ b/drivers/clk/mediatek/clk-mt7629-hif.c
@@ -79,82 +79,27 @@ static const struct mtk_clk_rst_desc clk_rst_desc = {
 	.rst_bank_nr = ARRAY_SIZE(rst_ofs),
 };
 
-static int clk_mt7629_ssusbsys_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_SSUSB_NR_CLK);
-
-	mtk_clk_register_gates(node, ssusb_clks, ARRAY_SIZE(ssusb_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-
-	return r;
-}
-
-static int clk_mt7629_pciesys_init(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_PCIE_NR_CLK);
-
-	mtk_clk_register_gates(node, pcie_clks, ARRAY_SIZE(pcie_clks),
-			       clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
+static const struct mtk_clk_desc ssusb_desc = {
+	.clks = ssusb_clks,
+	.num_clks = ARRAY_SIZE(ssusb_clks),
+	.rst_desc = &clk_rst_desc,
+};
 
-	return r;
-}
+static const struct mtk_clk_desc pcie_desc = {
+	.clks = pcie_clks,
+	.num_clks = ARRAY_SIZE(pcie_clks),
+	.rst_desc = &clk_rst_desc,
+};
 
 static const struct of_device_id of_match_clk_mt7629_hif[] = {
-	{
-		.compatible = "mediatek,mt7629-pciesys",
-		.data = clk_mt7629_pciesys_init,
-	}, {
-		.compatible = "mediatek,mt7629-ssusbsys",
-		.data = clk_mt7629_ssusbsys_init,
-	}, {
-		/* sentinel */
-	}
+	{ .compatible = "mediatek,mt7629-pciesys", .data = &pcie_desc },
+	{ .compatible = "mediatek,mt7629-ssusbsys", .data = &ssusb_desc },
+	{ /* sentinel */ }
 };
 
-static int clk_mt7629_hif_probe(struct platform_device *pdev)
-{
-	int (*clk_init)(struct platform_device *);
-	int r;
-
-	clk_init = of_device_get_match_data(&pdev->dev);
-	if (!clk_init)
-		return -EINVAL;
-
-	r = clk_init(pdev);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
-
-	return r;
-}
-
 static struct platform_driver clk_mt7629_hif_drv = {
-	.probe = clk_mt7629_hif_probe,
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt7629-hif",
 		.of_match_table = of_match_clk_mt7629_hif,
diff --git a/drivers/clk/mediatek/clk-mt8183-audio.c b/drivers/clk/mediatek/clk-mt8183-audio.c
index f4c6448b6f74..f5600450b4d1 100644
--- a/drivers/clk/mediatek/clk-mt8183-audio.c
+++ b/drivers/clk/mediatek/clk-mt8183-audio.c
@@ -67,35 +67,34 @@ static const struct mtk_gate audio_clks[] = {
 		20),
 };
 
+static const struct mtk_clk_desc audio_desc = {
+	.clks = audio_clks,
+	.num_clks = ARRAY_SIZE(audio_clks),
+};
+
 static int clk_mt8183_audio_probe(struct platform_device *pdev)
 {
-	struct clk_hw_onecell_data *clk_data;
 	int r;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_AUDIO_NR_CLK);
-
-	mtk_clk_register_gates(node, audio_clks, ARRAY_SIZE(audio_clks),
-			       clk_data, &pdev->dev);
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = mtk_clk_simple_probe(pdev);
 	if (r)
 		return r;
 
 	r = devm_of_platform_populate(&pdev->dev);
 	if (r)
-		of_clk_del_provider(node);
+		mtk_clk_simple_remove(pdev);
 
 	return r;
 }
 
 static const struct of_device_id of_match_clk_mt8183_audio[] = {
-	{ .compatible = "mediatek,mt8183-audiosys", },
+	{ .compatible = "mediatek,mt8183-audiosys", .data = &audio_desc },
 	{}
 };
 
 static struct platform_driver clk_mt8183_audio_drv = {
 	.probe = clk_mt8183_audio_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8183-audio",
 		.of_match_table = of_match_clk_mt8183_audio,
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 10a82b542376..f1d84c0730d5 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -1187,43 +1187,6 @@ static int clk_mt8183_top_probe(struct platform_device *pdev)
 				      top_clk_data);
 }
 
-static int clk_mt8183_infra_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-
-	mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-		clk_data, &pdev->dev);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r) {
-		dev_err(&pdev->dev,
-			"%s(): could not register clock provider: %d\n",
-			__func__, r);
-		return r;
-	}
-
-	mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-
-	return r;
-}
-
-static int clk_mt8183_peri_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
-
-	mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-			       clk_data, &pdev->dev);
-
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
-
 static int clk_mt8183_mcu_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -1249,12 +1212,6 @@ static const struct of_device_id of_match_clk_mt8183[] = {
 	}, {
 		.compatible = "mediatek,mt8183-topckgen",
 		.data = clk_mt8183_top_probe,
-	}, {
-		.compatible = "mediatek,mt8183-infracfg",
-		.data = clk_mt8183_infra_probe,
-	}, {
-		.compatible = "mediatek,mt8183-pericfg",
-		.data = clk_mt8183_peri_probe,
 	}, {
 		.compatible = "mediatek,mt8183-mcucfg",
 		.data = clk_mt8183_mcu_probe,
@@ -1281,6 +1238,32 @@ static int clk_mt8183_probe(struct platform_device *pdev)
 	return r;
 }
 
+static const struct mtk_clk_desc infra_desc = {
+	.clks = infra_clks,
+	.num_clks = ARRAY_SIZE(infra_clks),
+	.rst_desc = &clk_rst_desc,
+};
+
+static const struct mtk_clk_desc peri_desc = {
+	.clks = peri_clks,
+	.num_clks = ARRAY_SIZE(peri_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8183_simple[] = {
+	{ .compatible = "mediatek,mt8183-infracfg", .data = &infra_desc },
+	{ .compatible = "mediatek,mt8183-pericfg", .data = &peri_desc, },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8183_simple_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8183-simple",
+		.of_match_table = of_match_clk_mt8183_simple,
+	},
+};
+
 static struct platform_driver clk_mt8183_drv = {
 	.probe = clk_mt8183_probe,
 	.driver = {
@@ -1291,7 +1274,11 @@ static struct platform_driver clk_mt8183_drv = {
 
 static int __init clk_mt8183_init(void)
 {
-	return platform_driver_register(&clk_mt8183_drv);
+	int ret = platform_driver_register(&clk_mt8183_drv);
+
+	if (ret)
+		return ret;
+	return platform_driver_register(&clk_mt8183_simple_drv);
 }
 
 arch_initcall(clk_mt8183_init);
diff --git a/drivers/clk/mediatek/clk-mt8192-aud.c b/drivers/clk/mediatek/clk-mt8192-aud.c
index 3acadca2452a..d52f671e20ce 100644
--- a/drivers/clk/mediatek/clk-mt8192-aud.c
+++ b/drivers/clk/mediatek/clk-mt8192-aud.c
@@ -77,39 +77,34 @@ static const struct mtk_gate aud_clks[] = {
 	GATE_AUD2(CLK_AUD_I2S9_B, "aud_i2s9_b", "audio_sel", 4),
 };
 
+static const struct mtk_clk_desc aud_desc = {
+	.clks = aud_clks,
+	.num_clks = ARRAY_SIZE(aud_clks),
+};
+
 static int clk_mt8192_aud_probe(struct platform_device *pdev)
 {
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
 	int r;
 
-	clk_data = mtk_alloc_clk_data(CLK_AUD_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(node, aud_clks, ARRAY_SIZE(aud_clks),
-				   clk_data, &pdev->dev);
-	if (r)
-		return r;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	r = mtk_clk_simple_probe(pdev);
 	if (r)
 		return r;
 
 	r = devm_of_platform_populate(&pdev->dev);
 	if (r)
-		of_clk_del_provider(node);
+		mtk_clk_simple_remove(pdev);
 
 	return r;
 }
 
 static const struct of_device_id of_match_clk_mt8192_aud[] = {
-	{ .compatible = "mediatek,mt8192-audsys", },
-	{}
+	{ .compatible = "mediatek,mt8192-audsys", .data = &aud_desc },
+	{ /* sentinel */ }
 };
 
 static struct platform_driver clk_mt8192_aud_drv = {
 	.probe = clk_mt8192_aud_probe,
+	.remove = mtk_clk_simple_remove,
 	.driver = {
 		.name = "clk-mt8192-aud",
 		.of_match_table = of_match_clk_mt8192_aud,
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 3ca068a4c552..9a9d51bfb84d 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -1158,66 +1158,6 @@ static int clk_mt8192_top_probe(struct platform_device *pdev)
 	return r;
 }
 
-static int clk_mt8192_infra_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_INFRA_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(node, infra_clks, ARRAY_SIZE(infra_clks),
-					    clk_data, &pdev->dev);
-	if (r)
-		goto free_clk_data;
-
-	r = mtk_register_reset_controller_with_dev(&pdev->dev, &clk_rst_desc);
-	if (r)
-		goto unregister_gates;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	return r;
-
-unregister_gates:
-	mtk_clk_unregister_gates(infra_clks, ARRAY_SIZE(infra_clks), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static int clk_mt8192_peri_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
-					    clk_data, &pdev->dev);
-	if (r)
-		goto free_clk_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	return r;
-
-unregister_gates:
-	mtk_clk_unregister_gates(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
 static int clk_mt8192_apmixed_probe(struct platform_device *pdev)
 {
 	struct clk_hw_onecell_data *clk_data;
@@ -1255,12 +1195,6 @@ static const struct of_device_id of_match_clk_mt8192[] = {
 	}, {
 		.compatible = "mediatek,mt8192-topckgen",
 		.data = clk_mt8192_top_probe,
-	}, {
-		.compatible = "mediatek,mt8192-infracfg",
-		.data = clk_mt8192_infra_probe,
-	}, {
-		.compatible = "mediatek,mt8192-pericfg",
-		.data = clk_mt8192_peri_probe,
 	}, {
 		/* sentinel */
 	}
@@ -1282,6 +1216,32 @@ static int clk_mt8192_probe(struct platform_device *pdev)
 	return r;
 }
 
+static const struct mtk_clk_desc infra_desc = {
+	.clks = infra_clks,
+	.num_clks = ARRAY_SIZE(infra_clks),
+	.rst_desc = &clk_rst_desc,
+};
+
+static const struct mtk_clk_desc peri_desc = {
+	.clks = peri_clks,
+	.num_clks = ARRAY_SIZE(peri_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8192_simple[] = {
+	{ .compatible = "mediatek,mt8192-infracfg", .data = &infra_desc },
+	{ .compatible = "mediatek,mt8192-pericfg", .data = &peri_desc },
+	{ /* sentinel */ }
+};
+
+static struct platform_driver clk_mt8192_simple_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8192-simple",
+		.of_match_table = of_match_clk_mt8192_simple,
+	},
+};
+
 static struct platform_driver clk_mt8192_drv = {
 	.probe = clk_mt8192_probe,
 	.driver = {
@@ -1292,7 +1252,11 @@ static struct platform_driver clk_mt8192_drv = {
 
 static int __init clk_mt8192_init(void)
 {
-	return platform_driver_register(&clk_mt8192_drv);
+	int ret = platform_driver_register(&clk_mt8192_drv);
+
+	if (ret)
+		return ret;
+	return platform_driver_register(&clk_mt8192_simple_drv);
 }
 
 arch_initcall(clk_mt8192_init);
-- 
2.39.0

