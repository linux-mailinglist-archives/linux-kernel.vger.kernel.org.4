Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7E668C15B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:30:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjBFPaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230464AbjBFP3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:29:54 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E455CEB58;
        Mon,  6 Feb 2023 07:29:51 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 837146602F93;
        Mon,  6 Feb 2023 15:29:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697390;
        bh=WKpw2fiw36IrxOH+V8tBFVPPWVlzsB3hq2yFDzvM3JI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C7O8rzaw/uMVpP5XG495qg6P+0QNlvncRbsSqHXmQGj8tM4EWApX6VQD5Wp/b47CH
         zyoO9qxWB/Moc1iq9UBwA2l6E0tTzx2r8leXRsr64NDJNQitiqYwJbMHdLPuy8t3O2
         bvUslVLxLUJ9RKsBeSk5ne3qOj/E1+bw+1NjsmJnglepAper4xPL9zo+cfEy32v7YC
         0SPJPnoiPkKwFuim/ZfLRp3CJNJVq74mK91nWvjKX7VeY5T9rVGl8lPttm+iY+5xQx
         CUccrgFiKIzpLhQMI7GCbGkbvGU444agBruWDDgt03V4OgJvAnFSfteiFBHqJ11XRV
         oA6ewqkMgcNkw==
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
Subject: [PATCH v1 03/45] clk: mediatek: Migrate to mtk_clk_pdev_probe() for multimedia clocks
Date:   Mon,  6 Feb 2023 16:28:46 +0100
Message-Id: <20230206152928.918562-4-angelogioacchino.delregno@collabora.com>
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

Reduce duplication and simplify all MediaTek multimedia clock drivers
by migrating away from defining custom probe functions for each driver
and instead use mtk_clk_pdev_probe().

While at it, also add a .remove() callback to all of the multimedia
clock drivers where missing.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt2701-mm.c   | 31 +++++---------
 drivers/clk/mediatek/clk-mt2712-mm.c   | 31 +++++---------
 drivers/clk/mediatek/clk-mt6779-mm.c   | 24 +++++------
 drivers/clk/mediatek/clk-mt6795-mm.c   | 55 +++++-------------------
 drivers/clk/mediatek/clk-mt6797-mm.c   | 31 +++++---------
 drivers/clk/mediatek/clk-mt8167-mm.c   | 47 +++++----------------
 drivers/clk/mediatek/clk-mt8173-mm.c   | 58 +++++---------------------
 drivers/clk/mediatek/clk-mt8183-mm.c   | 24 +++++------
 drivers/clk/mediatek/clk-mt8186-mm.c   | 56 +++++--------------------
 drivers/clk/mediatek/clk-mt8192-mm.c   | 29 +++++--------
 drivers/clk/mediatek/clk-mt8195-vdo0.c | 55 +++++-------------------
 drivers/clk/mediatek/clk-mt8195-vdo1.c | 57 ++++++-------------------
 drivers/clk/mediatek/clk-mt8365-mm.c   | 39 +++++------------
 13 files changed, 143 insertions(+), 394 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt2701-mm.c b/drivers/clk/mediatek/clk-mt2701-mm.c
index 23d5ddcc1d37..a8d94ca0eefd 100644
--- a/drivers/clk/mediatek/clk-mt2701-mm.c
+++ b/drivers/clk/mediatek/clk-mt2701-mm.c
@@ -79,32 +79,23 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_DISP1(CLK_MM_TVE_FMM, "mm_tve_fmm", "mm_sel", 14),
 };
 
-static int clk_mt2701_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
-
-	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
-			       ARRAY_SIZE(mm_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
-	return r;
-}
+static const struct platform_device_id clk_mt2701_mm_id_table[] = {
+	{ .name = "clk-mt2701-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt2701_mm_drv = {
-	.probe = clk_mt2701_mm_probe,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt2701-mm",
 	},
+	.id_table = clk_mt2701_mm_id_table,
 };
 
 builtin_platform_driver(clk_mt2701_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt2712-mm.c b/drivers/clk/mediatek/clk-mt2712-mm.c
index 25b8af640c12..615f6b0fe96e 100644
--- a/drivers/clk/mediatek/clk-mt2712-mm.c
+++ b/drivers/clk/mediatek/clk-mt2712-mm.c
@@ -126,32 +126,23 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM2(CLK_MM_DSI3_DIGITAL, "mm_dsi3_digital", "dsi1_lntc", 6),
 };
 
-static int clk_mt2712_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-
-	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
-			       ARRAY_SIZE(mm_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r != 0)
-		pr_err("%s(): could not register clock provider: %d\n",
-			__func__, r);
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
-	return r;
-}
+static const struct platform_device_id clk_mt2712_mm_id_table[] = {
+	{ .name = "clk-mt2712-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt2712_mm_drv = {
-	.probe = clk_mt2712_mm_probe,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt2712-mm",
 	},
+	.id_table = clk_mt2712_mm_id_table,
 };
 
 builtin_platform_driver(clk_mt2712_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt6779-mm.c b/drivers/clk/mediatek/clk-mt6779-mm.c
index 2cccf62d3b36..219a3a7920cd 100644
--- a/drivers/clk/mediatek/clk-mt6779-mm.c
+++ b/drivers/clk/mediatek/clk-mt6779-mm.c
@@ -85,25 +85,23 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM1(CLK_MM_DISP_OVL_FBDC, "mm_disp_ovl_fbdc", "mm_sel", 16),
 };
 
-static int clk_mt6779_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-
-	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
-			       ARRAY_SIZE(mm_clks), clk_data);
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct platform_device_id clk_mt6779_mm_id_table[] = {
+	{ .name = "clk-mt6779-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt6779_mm_drv = {
-	.probe = clk_mt6779_mm_probe,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt6779-mm",
 	},
+	.id_table = clk_mt6779_mm_id_table,
 };
 
 module_platform_driver(clk_mt6779_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt6795-mm.c b/drivers/clk/mediatek/clk-mt6795-mm.c
index eebb6143ada2..c0c61a08cd72 100644
--- a/drivers/clk/mediatek/clk-mt6795-mm.c
+++ b/drivers/clk/mediatek/clk-mt6795-mm.c
@@ -76,56 +76,23 @@ static const struct mtk_gate mm_gates[] = {
 	GATE_MM1(CLK_MM_DPI_ENGINE, "mm_dpi_engine", "mm_sel", 9),
 };
 
-static int clk_mt6795_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int ret;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	ret = mtk_clk_register_gates(&pdev->dev, node, mm_gates,
-				     ARRAY_SIZE(mm_gates), clk_data);
-	if (ret)
-		goto free_clk_data;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto unregister_gates;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return 0;
-
-unregister_gates:
-	mtk_clk_unregister_gates(mm_gates, ARRAY_SIZE(mm_gates), clk_data);
-free_clk_data:
-	mtk_free_clk_data(clk_data);
-	return ret;
-}
-
-static int clk_mt6795_mm_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(mm_gates, ARRAY_SIZE(mm_gates), clk_data);
-	mtk_free_clk_data(clk_data);
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_gates,
+	.num_clks = ARRAY_SIZE(mm_gates),
+};
 
-	return 0;
-}
+static const struct platform_device_id clk_mt6795_mm_id_table[] = {
+	{ .name = "clk-mt6795-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt6795_mm_drv = {
 	.driver = {
 		.name = "clk-mt6795-mm",
 	},
-	.probe = clk_mt6795_mm_probe,
-	.remove = clk_mt6795_mm_remove,
+	.id_table = clk_mt6795_mm_id_table,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 };
 module_platform_driver(clk_mt6795_mm_drv);
 
diff --git a/drivers/clk/mediatek/clk-mt6797-mm.c b/drivers/clk/mediatek/clk-mt6797-mm.c
index deb16a6b16a5..706c9775646d 100644
--- a/drivers/clk/mediatek/clk-mt6797-mm.c
+++ b/drivers/clk/mediatek/clk-mt6797-mm.c
@@ -92,32 +92,23 @@ static const struct mtk_gate mm_clks[] = {
 		 "clk26m", 3),
 };
 
-static int clk_mt6797_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR);
-
-	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
-			       ARRAY_SIZE(mm_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		dev_err(&pdev->dev,
-			"could not register clock provider: %s: %d\n",
-			pdev->name, r);
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
-	return r;
-}
+static const struct platform_device_id clk_mt6797_mm_id_table[] = {
+	{ .name = "clk-mt6797-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt6797_mm_drv = {
-	.probe = clk_mt6797_mm_probe,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt6797-mm",
 	},
+	.id_table = clk_mt6797_mm_id_table,
 };
 
 builtin_platform_driver(clk_mt6797_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8167-mm.c b/drivers/clk/mediatek/clk-mt8167-mm.c
index c0b44104c765..78c023b0565a 100644
--- a/drivers/clk/mediatek/clk-mt8167-mm.c
+++ b/drivers/clk/mediatek/clk-mt8167-mm.c
@@ -86,47 +86,22 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM1(CLK_MM_HDMI_PLL, "mm_hdmi_pll", "hdmtx_dig_cts", 21),
 };
 
-struct clk_mt8167_mm_driver_data {
-	const struct mtk_gate *gates_clk;
-	int gates_num;
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
 };
 
-static const struct clk_mt8167_mm_driver_data mt8167_mmsys_driver_data = {
-	.gates_clk = mm_clks,
-	.gates_num = ARRAY_SIZE(mm_clks),
+static const struct platform_device_id clk_mt8167_mm_id_table[] = {
+	{ .name = "clk-mt8167-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
 };
 
-static int clk_mt8167_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	const struct clk_mt8167_mm_driver_data *data;
-	struct clk_hw_onecell_data *clk_data;
-	int ret;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	data = &mt8167_mmsys_driver_data;
-
-	ret = mtk_clk_register_gates(&pdev->dev, node, data->gates_clk,
-				     data->gates_num, clk_data);
-	if (ret)
-		return ret;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static struct platform_driver clk_mt8173_mm_drv = {
+static struct platform_driver clk_mt8167_mm_drv = {
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8167-mm",
 	},
-	.probe = clk_mt8167_mm_probe,
+	.id_table = clk_mt8167_mm_id_table,
 };
-
-builtin_platform_driver(clk_mt8173_mm_drv);
+builtin_platform_driver(clk_mt8167_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8173-mm.c b/drivers/clk/mediatek/clk-mt8173-mm.c
index 315430ad1581..ffec2d917661 100644
--- a/drivers/clk/mediatek/clk-mt8173-mm.c
+++ b/drivers/clk/mediatek/clk-mt8173-mm.c
@@ -44,6 +44,7 @@ static const struct mtk_gate_regs mm1_cg_regs = {
 	}
 
 static const struct mtk_gate mt8173_mm_clks[] = {
+	GATE_DUMMY(CLK_DUMMY, "mm_dummy"),
 	/* MM0 */
 	GATE_MM0(CLK_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 0),
 	GATE_MM0(CLK_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 1),
@@ -100,62 +101,23 @@ static const struct mtk_gate mt8173_mm_clks[] = {
 	GATE_MM1(CLK_MM_HDMI_HDCP24M, "mm_hdmi_hdcp24m", "hdcp_24m_sel", 20),
 };
 
-struct clk_mt8173_mm_driver_data {
-	const struct mtk_gate *gates_clk;
-	int gates_num;
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mt8173_mm_clks,
+	.num_clks = ARRAY_SIZE(mt8173_mm_clks),
 };
 
-static const struct clk_mt8173_mm_driver_data mt8173_mmsys_driver_data = {
-	.gates_clk = mt8173_mm_clks,
-	.gates_num = ARRAY_SIZE(mt8173_mm_clks),
+static const struct platform_device_id clk_mt8173_mm_id_table[] = {
+	{ .name = "clk-mt8173-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
 };
 
-static int clk_mt8173_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	const struct clk_mt8173_mm_driver_data *data;
-	struct clk_hw_onecell_data *clk_data;
-	int ret;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	data = &mt8173_mmsys_driver_data;
-
-	ret = mtk_clk_register_gates(&pdev->dev, node, data->gates_clk,
-				     data->gates_num, clk_data);
-	if (ret)
-		return ret;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		return ret;
-
-	return 0;
-}
-
-static int clk_mt8173_mm_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	const struct clk_mt8173_mm_driver_data *data = &mt8173_mmsys_driver_data;
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(data->gates_clk, data->gates_num, clk_data);
-	mtk_free_clk_data(clk_data);
-
-	return 0;
-}
-
 static struct platform_driver clk_mt8173_mm_drv = {
 	.driver = {
 		.name = "clk-mt8173-mm",
 	},
-	.probe = clk_mt8173_mm_probe,
-	.remove = clk_mt8173_mm_remove,
+	.id_table = clk_mt8173_mm_id_table,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 };
 
 builtin_platform_driver(clk_mt8173_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8183-mm.c b/drivers/clk/mediatek/clk-mt8183-mm.c
index 358031530913..669dcdd66efb 100644
--- a/drivers/clk/mediatek/clk-mt8183-mm.c
+++ b/drivers/clk/mediatek/clk-mt8183-mm.c
@@ -82,25 +82,23 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM1(CLK_MM_DBI_IF, "mm_dbi_if", "dpi0_sel", 13),
 };
 
-static int clk_mt8183_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-
-	mtk_clk_register_gates(&pdev->dev, node, mm_clks,
-			       ARRAY_SIZE(mm_clks), clk_data);
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct platform_device_id clk_mt8183_mm_id_table[] = {
+	{ .name = "clk-mt8183-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt8183_mm_drv = {
-	.probe = clk_mt8183_mm_probe,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8183-mm",
 	},
+	.id_table = clk_mt8183_mm_id_table,
 };
 
 builtin_platform_driver(clk_mt8183_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8186-mm.c b/drivers/clk/mediatek/clk-mt8186-mm.c
index 0b72607777fa..6506a8b848a9 100644
--- a/drivers/clk/mediatek/clk-mt8186-mm.c
+++ b/drivers/clk/mediatek/clk-mt8186-mm.c
@@ -58,55 +58,21 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM1(CLK_MM_DISP_26M, "mm_disp_26m_ck", "top_disp", 10),
 };
 
-static int clk_mt8186_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, mm_clks,
-				   ARRAY_SIZE(mm_clks), clk_data);
-	if (r)
-		goto free_mm_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_gates:
-	mtk_clk_unregister_gates(mm_clks, ARRAY_SIZE(mm_clks), clk_data);
-free_mm_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static int clk_mt8186_mm_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(mm_clks, ARRAY_SIZE(mm_clks), clk_data);
-	mtk_free_clk_data(clk_data);
-
-	return 0;
-}
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
+static const struct platform_device_id clk_mt8186_mm_id_table[] = {
+	{ .name = "clk-mt8186-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 static struct platform_driver clk_mt8186_mm_drv = {
-	.probe = clk_mt8186_mm_probe,
-	.remove = clk_mt8186_mm_remove,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8186-mm",
 	},
+	.id_table = clk_mt8186_mm_id_table,
 };
 builtin_platform_driver(clk_mt8186_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8192-mm.c b/drivers/clk/mediatek/clk-mt8192-mm.c
index e9eb4cf8349a..638e6faae84c 100644
--- a/drivers/clk/mediatek/clk-mt8192-mm.c
+++ b/drivers/clk/mediatek/clk-mt8192-mm.c
@@ -80,30 +80,23 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM2(CLK_MM_32KHZ, "mm_32khz", "clk32k", 25),
 };
 
-static int clk_mt8192_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, mm_clks,
-			       ARRAY_SIZE(mm_clks), clk_data);
-	if (r)
-		return r;
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
-	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-}
+static const struct platform_device_id clk_mt8192_mm_id_table[] = {
+	{ .name = "clk-mt8192-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt8192_mm_drv = {
-	.probe = clk_mt8192_mm_probe,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8192-mm",
 	},
+	.id_table = clk_mt8192_mm_id_table,
 };
 
 builtin_platform_driver(clk_mt8192_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo0.c b/drivers/clk/mediatek/clk-mt8195-vdo0.c
index 839b730688ac..492c1e133d0d 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo0.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo0.c
@@ -93,55 +93,22 @@ static const struct mtk_gate vdo0_clks[] = {
 			  "top_edp", 16, CLK_SET_RATE_PARENT),
 };
 
-static int clk_mt8195_vdo0_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_VDO0_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, vdo0_clks,
-				   ARRAY_SIZE(vdo0_clks), clk_data);
-	if (r)
-		goto free_vdo0_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_gates:
-	mtk_clk_unregister_gates(vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
-free_vdo0_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static int clk_mt8195_vdo0_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(vdo0_clks, ARRAY_SIZE(vdo0_clks), clk_data);
-	mtk_free_clk_data(clk_data);
+static const struct mtk_clk_desc vdo0_desc = {
+	.clks = vdo0_clks,
+	.num_clks = ARRAY_SIZE(vdo0_clks),
+};
 
-	return 0;
-}
+static const struct platform_device_id clk_mt8195_vdo0_id_table[] = {
+	{ .name = "clk-mt8195-vdo0", .driver_data = (kernel_ulong_t)&vdo0_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt8195_vdo0_drv = {
-	.probe = clk_mt8195_vdo0_probe,
-	.remove = clk_mt8195_vdo0_remove,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8195-vdo0",
 	},
+	.id_table = clk_mt8195_vdo0_id_table,
 };
 builtin_platform_driver(clk_mt8195_vdo0_drv);
diff --git a/drivers/clk/mediatek/clk-mt8195-vdo1.c b/drivers/clk/mediatek/clk-mt8195-vdo1.c
index 7df695b28925..76e9f4496e43 100644
--- a/drivers/clk/mediatek/clk-mt8195-vdo1.c
+++ b/drivers/clk/mediatek/clk-mt8195-vdo1.c
@@ -120,55 +120,22 @@ static const struct mtk_gate vdo1_clks[] = {
 	GATE_VDO1_4(CLK_VDO1_DPI1_HDMI, "vdo1_dpi1_hdmi", "hdmi_txpll", 0),
 };
 
-static int clk_mt8195_vdo1_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(CLK_VDO1_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	r = mtk_clk_register_gates(&pdev->dev, node, vdo1_clks,
-				   ARRAY_SIZE(vdo1_clks), clk_data);
-	if (r)
-		goto free_vdo1_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_gates;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_gates:
-	mtk_clk_unregister_gates(vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
-free_vdo1_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static int clk_mt8195_vdo1_remove(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_gates(vdo1_clks, ARRAY_SIZE(vdo1_clks), clk_data);
-	mtk_free_clk_data(clk_data);
-
-	return 0;
-}
+static const struct mtk_clk_desc vdo1_desc = {
+	.clks = vdo1_clks,
+	.num_clks = ARRAY_SIZE(vdo1_clks),
+};
+
+static const struct platform_device_id clk_mt8195_vdo1_id_table[] = {
+	{ .name = "clk-mt8195-vdo1", .driver_data = (kernel_ulong_t)&vdo1_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt8195_vdo1_drv = {
-	.probe = clk_mt8195_vdo1_probe,
-	.remove = clk_mt8195_vdo1_remove,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8195-vdo1",
 	},
+	.id_table = clk_mt8195_vdo1_id_table,
 };
 builtin_platform_driver(clk_mt8195_vdo1_drv);
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
index 22c75a03a645..9569be54127c 100644
--- a/drivers/clk/mediatek/clk-mt8365-mm.c
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -72,40 +72,23 @@ static const struct mtk_gate mm_clks[] = {
 	GATE_MM1(CLK_MM_LVDSTX_CTS, "mm_flvdstx_cts", "lvdstx_dig_cts", 3),
 };
 
-static int clk_mt8365_mm_probe(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct device_node *node = dev->parent->of_node;
-	struct clk_hw_onecell_data *clk_data;
-	int ret;
-
-	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
-
-	ret = mtk_clk_register_gates(dev, node, mm_clks,
-				     ARRAY_SIZE(mm_clks), clk_data);
-	if (ret)
-		goto err_free_clk_data;
-
-	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (ret)
-		goto err_unregister_gates;
-
-	return 0;
-
-err_unregister_gates:
-	mtk_clk_unregister_gates(mm_clks, ARRAY_SIZE(mm_clks), clk_data);
-
-err_free_clk_data:
-	mtk_free_clk_data(clk_data);
+static const struct mtk_clk_desc mm_desc = {
+	.clks = mm_clks,
+	.num_clks = ARRAY_SIZE(mm_clks),
+};
 
-	return ret;
-}
+static const struct platform_device_id clk_mt8365_mm_id_table[] = {
+	{ .name = "clk-mt8365-mm", .driver_data = (kernel_ulong_t)&mm_desc },
+	{ /* sentinel */ }
+};
 
 static struct platform_driver clk_mt8365_mm_drv = {
-	.probe = clk_mt8365_mm_probe,
+	.probe = mtk_clk_pdev_probe,
+	.remove = mtk_clk_pdev_remove,
 	.driver = {
 		.name = "clk-mt8365-mm",
 	},
+	.id_table = clk_mt8365_mm_id_table,
 };
 builtin_platform_driver(clk_mt8365_mm_drv);
 MODULE_LICENSE("GPL");
-- 
2.39.1

