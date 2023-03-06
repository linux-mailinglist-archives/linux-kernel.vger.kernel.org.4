Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B965E6AC29B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 15:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbjCFOLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 09:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231440AbjCFOKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 09:10:52 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0113018A;
        Mon,  6 Mar 2023 06:08:56 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 189646602FF3;
        Mon,  6 Mar 2023 14:06:42 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678111603;
        bh=+rJu1lq5BLirEKECDD7KKkaw15QAWsrzbIAaNVC4b1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P8eUs05KlkTWOvOZI6vKEjQhO8Sle3mnv0wO044GvPutVjl5fOqa6gjHovTHnc2Iz
         EUGrvgPwxBxBQ8sdAXjIGGaXsG35KHJDp+bPZ/n1Qops6H7FX28uHbTiIJjkENCqfE
         zD/NiPkDDLbhXT2Ouk168GYY+GzUM3IZVHIJB+xpEFO31mjH+E2V7ZpbIVNdAAdwiT
         HkfZoVd1TDz6FxadxDqaUiTlkPPJeSZ3yXf0MbV1mOVoPUCiwLvdJ3a2PukTsZ1i2U
         5Xe8d9Vy79C0aMA6NLFc/AYPTb+C8dtENBzigMkf58en2QpRtJ7lJzCbfSOHhUlKOK
         G25atp0TuUCMg==
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
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v6 35/54] clk: mediatek: mt8186-mcu: Migrate to common probe mechanism
Date:   Mon,  6 Mar 2023 15:05:24 +0100
Message-Id: <20230306140543.1813621-36-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
References: <20230306140543.1813621-1-angelogioacchino.delregno@collabora.com>
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

Convert MT8186 MCUSYS clocks to the common mtk_clk_simple_probe().

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
Tested-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8186-mcu.c | 68 +++++----------------------
 1 file changed, 13 insertions(+), 55 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8186-mcu.c b/drivers/clk/mediatek/clk-mt8186-mcu.c
index e52a2d986c99..895856df95df 100644
--- a/drivers/clk/mediatek/clk-mt8186-mcu.c
+++ b/drivers/clk/mediatek/clk-mt8186-mcu.c
@@ -43,67 +43,25 @@ static struct mtk_composite mcu_muxes[] = {
 	MUX(CLK_MCU_ARMPLL_BUS_SEL, "mcu_armpll_bus_sel", mcu_armpll_bus_parents, 0x2E0, 9, 2),
 };
 
-static const struct of_device_id of_match_clk_mt8186_mcu[] = {
-	{ .compatible = "mediatek,mt8186-mcusys", },
-	{}
+static const struct mtk_clk_desc mcu_desc = {
+	.composite_clks = mcu_muxes,
+	.num_composite_clks = ARRAY_SIZE(mcu_muxes),
 };
 
-static int clk_mt8186_mcu_probe(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data;
-	struct device_node *node = pdev->dev.of_node;
-	int r;
-	void __iomem *base;
-
-	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
-	if (!clk_data)
-		return -ENOMEM;
-
-	base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(base)) {
-		r = PTR_ERR(base);
-		goto free_mcu_data;
-	}
-
-	r = mtk_clk_register_composites(&pdev->dev, mcu_muxes,
-					ARRAY_SIZE(mcu_muxes), base,
-					NULL, clk_data);
-	if (r)
-		goto free_mcu_data;
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		goto unregister_composite_muxes;
-
-	platform_set_drvdata(pdev, clk_data);
-
-	return r;
-
-unregister_composite_muxes:
-	mtk_clk_unregister_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), clk_data);
-free_mcu_data:
-	mtk_free_clk_data(clk_data);
-	return r;
-}
-
-static int clk_mt8186_mcu_remove(struct platform_device *pdev)
-{
-	struct clk_hw_onecell_data *clk_data = platform_get_drvdata(pdev);
-	struct device_node *node = pdev->dev.of_node;
-
-	of_clk_del_provider(node);
-	mtk_clk_unregister_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes), clk_data);
-	mtk_free_clk_data(clk_data);
-
-	return 0;
-}
+static const struct of_device_id of_match_clk_mt8186_mcu[] = {
+	{ .compatible = "mediatek,mt8186-mcusys", .data = &mcu_desc },
+	{ /* sentinel */}
+};
 
 static struct platform_driver clk_mt8186_mcu_drv = {
-	.probe = clk_mt8186_mcu_probe,
-	.remove = clk_mt8186_mcu_remove,
 	.driver = {
 		.name = "clk-mt8186-mcu",
 		.of_match_table = of_match_clk_mt8186_mcu,
 	},
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
 };
-builtin_platform_driver(clk_mt8186_mcu_drv);
+module_platform_driver(clk_mt8186_mcu_drv);
+
+MODULE_DESCRIPTION("MediaTek MT8186 mcusys clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.2

