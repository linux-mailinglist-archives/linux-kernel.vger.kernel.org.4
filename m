Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7912768C19A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 16:32:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjBFPcr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 10:32:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231273AbjBFPbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 10:31:50 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E3929E28;
        Mon,  6 Feb 2023 07:30:42 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54DF26602F9A;
        Mon,  6 Feb 2023 15:30:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1675697429;
        bh=AA/m7HsAfXtZJhylCrqFkUgDrrgGMEf91gpLkXpKHdU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZKSl8Sk6OhcXAbzbhpI7gzC4i4rIUh1r5BwWji1x1MRQMvUBGQdS1ABnSMLexIdag
         asgZTPsFhpJ//cpQeFVmsty7zPyhihfazFJ3J063BfWSXXHwkp2ombR1YixlIRRNHm
         k3oxABz7s8osPmNqbgL6qDGGI1IrdQprm867whgikif2hbes2fQ2I5KZG/L1k07urv
         RZlo8jl/CAqIWRxnt1vY5iOV3Xuhy4R2+7bICFN3fxQEwIKj/3wmsM7u+brlICgSVp
         TfypL8wBw4JIwNkro+QQ5Y1oTtQEPD99Whq6CnpyFdZAEZEFla9eynqYIp1FboMB9h
         pnd0shIXTwhYA==
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
Subject: [PATCH v1 31/45] clk: mediatek: mt7986-eth: Migrate to common probe mechanism
Date:   Mon,  6 Feb 2023 16:29:14 +0100
Message-Id: <20230206152928.918562-32-angelogioacchino.delregno@collabora.com>
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

Convert this driver to use the common mtk_clk_simple_probe() mechanism.
While at it, also remove __initconst annotations (as these structures
are used also at runtime).

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt7986-eth.c | 83 +++++++++++----------------
 1 file changed, 32 insertions(+), 51 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-eth.c b/drivers/clk/mediatek/clk-mt7986-eth.c
index 615b4b10d37c..3e0eaaf23cc5 100644
--- a/drivers/clk/mediatek/clk-mt7986-eth.c
+++ b/drivers/clk/mediatek/clk-mt7986-eth.c
@@ -26,7 +26,7 @@ static const struct mtk_gate_regs sgmii0_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &sgmii0_cg_regs, _shift,	\
 		 &mtk_clk_gate_ops_no_setclr_inv)
 
-static const struct mtk_gate sgmii0_clks[] __initconst = {
+static const struct mtk_gate sgmii0_clks[] = {
 	GATE_SGMII0(CLK_SGMII0_TX250M_EN, "sgmii0_tx250m_en", "top_xtal", 2),
 	GATE_SGMII0(CLK_SGMII0_RX250M_EN, "sgmii0_rx250m_en", "top_xtal", 3),
 	GATE_SGMII0(CLK_SGMII0_CDR_REF, "sgmii0_cdr_ref", "top_xtal", 4),
@@ -43,7 +43,7 @@ static const struct mtk_gate_regs sgmii1_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &sgmii1_cg_regs, _shift,	\
 		 &mtk_clk_gate_ops_no_setclr_inv)
 
-static const struct mtk_gate sgmii1_clks[] __initconst = {
+static const struct mtk_gate sgmii1_clks[] = {
 	GATE_SGMII1(CLK_SGMII1_TX250M_EN, "sgmii1_tx250m_en", "top_xtal", 2),
 	GATE_SGMII1(CLK_SGMII1_RX250M_EN, "sgmii1_rx250m_en", "top_xtal", 3),
 	GATE_SGMII1(CLK_SGMII1_CDR_REF, "sgmii1_cdr_ref", "top_xtal", 4),
@@ -60,7 +60,7 @@ static const struct mtk_gate_regs eth_cg_regs = {
 	GATE_MTK(_id, _name, _parent, &eth_cg_regs, _shift,	\
 		 &mtk_clk_gate_ops_no_setclr_inv)
 
-static const struct mtk_gate eth_clks[] __initconst = {
+static const struct mtk_gate eth_clks[] = {
 	GATE_ETH(CLK_ETH_FE_EN, "eth_fe_en", "netsys_2x_sel", 6),
 	GATE_ETH(CLK_ETH_GP2_EN, "eth_gp2_en", "sgm_325m_sel", 7),
 	GATE_ETH(CLK_ETH_GP1_EN, "eth_gp1_en", "sgm_325m_sel", 8),
@@ -68,56 +68,37 @@ static const struct mtk_gate eth_clks[] __initconst = {
 	GATE_ETH(CLK_ETH_WOCPU0_EN, "eth_wocpu0_en", "netsys_mcu_sel", 15),
 };
 
-static void __init mtk_sgmiisys_0_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii0_clks));
-
-	mtk_clk_register_gates(NULL, node, sgmii0_clks,
-			       ARRAY_SIZE(sgmii0_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-}
-CLK_OF_DECLARE(mtk_sgmiisys_0, "mediatek,mt7986-sgmiisys_0",
-	       mtk_sgmiisys_0_init);
-
-static void __init mtk_sgmiisys_1_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
-
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(sgmii1_clks));
-
-	mtk_clk_register_gates(NULL, node, sgmii1_clks,
-			       ARRAY_SIZE(sgmii1_clks), clk_data);
-
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
-
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-}
-CLK_OF_DECLARE(mtk_sgmiisys_1, "mediatek,mt7986-sgmiisys_1",
-	       mtk_sgmiisys_1_init);
+static const struct mtk_clk_desc eth_desc = {
+	.clks = eth_clks,
+	.num_clks = ARRAY_SIZE(eth_clks),
+};
 
-static void __init mtk_ethsys_init(struct device_node *node)
-{
-	struct clk_hw_onecell_data *clk_data;
-	int r;
+static const struct mtk_clk_desc sgmii0_desc = {
+	.clks = sgmii0_clks,
+	.num_clks = ARRAY_SIZE(sgmii0_clks),
+};
 
-	clk_data = mtk_alloc_clk_data(ARRAY_SIZE(eth_clks));
+static const struct mtk_clk_desc sgmii1_desc = {
+	.clks = sgmii1_clks,
+	.num_clks = ARRAY_SIZE(sgmii1_clks),
+};
 
-	mtk_clk_register_gates(NULL, node, eth_clks, ARRAY_SIZE(eth_clks), clk_data);
+static const struct of_device_id of_match_clk_mt7986_eth[] = {
+	{ .compatible = "mediatek,mt7986-ethsys", .data = &eth_desc },
+	{ .compatible = "mediatek,mt7986-sgmiisys_0", .data = &sgmii0_desc },
+	{ .compatible = "mediatek,mt7986-sgmiisys_1", .data = &sgmii1_desc },
+	{ /* sentinel */ }
+};
 
-	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+static struct platform_driver clk_mt7986_eth_drv = {
+	.driver = {
+		.name = "clk-mt7986-eth",
+		.of_match_table = of_match_clk_mt7986_eth,
+	},
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+};
+module_platform_driver(clk_mt7986_eth_drv);
 
-	if (r)
-		pr_err("%s(): could not register clock provider: %d\n",
-		       __func__, r);
-}
-CLK_OF_DECLARE(mtk_ethsys, "mediatek,mt7986-ethsys", mtk_ethsys_init);
+MODULE_DESCRIPTION("MediaTek MT7986 Ethernet clocks driver");
+MODULE_LICENSE("GPL");
-- 
2.39.1

