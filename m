Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4DE69D025
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 16:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjBTPFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 10:05:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232314AbjBTPEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 10:04:37 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6364492;
        Mon, 20 Feb 2023 07:02:49 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B25F966021CC;
        Mon, 20 Feb 2023 15:02:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676905347;
        bh=qI37eAVXpXgAjG1sJQwIW4vaDPf2H9q2nvTIZKlPjrA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feWv+GbdqoXRxlb40FKN7ey+pcKIxAunXKLRx9IOt3hGxo7wdTNXr0t5h/HkgDYQD
         eQReTEmpRpNPA1b3yYYkLa3B1nRVg16Xm+LHk2EgMXlPTc2xtaVA9F1ADA9N7Mpby2
         HggVB6+gM2D8GKtBqBUXORFxUCgkytaZsqf1O9BbXe8Ts6DKZgpQBuK8uRwsesvk6D
         HGCVThfIFx84aCOZqJ+0fDZIutyaBogpxVVX5GUxUKfLPncRM7ENOARytYc9ndT7Bg
         i8PbOcz7EJnTwGFqsWY3EaBF52LojzUNQMTjMAmTfupxkaRwU9ojYqQh1uPD0FR5Vz
         Ea8TXgXsrIUpQ==
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
Subject: [PATCH v3 51/55] clk: mediatek: mt8135: Properly use CLK_IS_CRITICAL flag
Date:   Mon, 20 Feb 2023 16:01:07 +0100
Message-Id: <20230220150111.77897-52-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
References: <20230220150111.77897-1-angelogioacchino.delregno@collabora.com>
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

Instead of calling clk_prepare_enable() for clocks that shall stay
enabled, use the CLK_IS_CRITICAL flag, which purpose is exactly that.

Fixes: a8aede794843 ("clk: mediatek: Add basic clocks for Mediatek MT8135.")
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt8135.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8135.c b/drivers/clk/mediatek/clk-mt8135.c
index 2a9405b552c6..1c76c0003f99 100644
--- a/drivers/clk/mediatek/clk-mt8135.c
+++ b/drivers/clk/mediatek/clk-mt8135.c
@@ -2,6 +2,8 @@
 /*
  * Copyright (c) 2014 MediaTek Inc.
  * Author: James Liao <jamesjj.liao@mediatek.com>
+ * Copyright (c) 2023 Collabora, Ltd.
+ *               AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
  */
 
 #include <linux/clk.h>
@@ -390,7 +392,7 @@ static const struct mtk_composite top_muxes[] __initconst = {
 	MUX_GATE(CLK_TOP_GCPU_SEL, "gcpu_sel", gcpu_parents, 0x0164, 24, 3, 31),
 	/* CLK_CFG_9 */
 	MUX_GATE(CLK_TOP_DPI1_SEL, "dpi1_sel", dpi1_parents, 0x0168, 0, 2, 7),
-	MUX_GATE(CLK_TOP_CCI_SEL, "cci_sel", cci_parents, 0x0168, 8, 3, 15),
+	MUX_GATE_FLAGS(CLK_TOP_CCI_SEL, "cci_sel", cci_parents, 0x0168, 8, 3, 15, CLK_IS_CRITICAL),
 	MUX_GATE(CLK_TOP_APLL_SEL, "apll_sel", apll_parents, 0x0168, 16, 3, 23),
 	MUX_GATE(CLK_TOP_HDMIPLL_SEL, "hdmipll_sel", hdmipll_parents, 0x0168, 24, 2, 31),
 };
@@ -404,6 +406,10 @@ static const struct mtk_gate_regs infra_cg_regs = {
 #define GATE_ICG(_id, _name, _parent, _shift)	\
 	GATE_MTK(_id, _name, _parent, &infra_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
 
+#define GATE_ICG_AO(_id, _name, _parent, _shift)	\
+	GATE_MTK_FLAGS(_id, _name, _parent, &infra_cg_regs, _shift,	\
+		       &mtk_clk_gate_ops_setclr, CLK_IS_CRITICAL)
+
 static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_PMIC_WRAP, "pmic_wrap_ck", "axi_sel", 23),
 	GATE_ICG(CLK_INFRA_PMICSPI, "pmicspi_ck", "pmicspi_sel", 22),
@@ -411,7 +417,7 @@ static const struct mtk_gate infra_clks[] __initconst = {
 	GATE_ICG(CLK_INFRA_CCIF0_AP_CTRL, "ccif0_ap_ctrl", "axi_sel", 20),
 	GATE_ICG(CLK_INFRA_KP, "kp_ck", "axi_sel", 16),
 	GATE_ICG(CLK_INFRA_CPUM, "cpum_ck", "cpum_tck_in", 15),
-	GATE_ICG(CLK_INFRA_M4U, "m4u_ck", "mem_sel", 8),
+	GATE_ICG_AO(CLK_INFRA_M4U, "m4u_ck", "mem_sel", 8),
 	GATE_ICG(CLK_INFRA_MFGAXI, "mfgaxi_ck", "axi_sel", 7),
 	GATE_ICG(CLK_INFRA_DEVAPC, "devapc_ck", "axi_sel", 6),
 	GATE_ICG(CLK_INFRA_AUDIO, "audio_ck", "aud_intbus_sel", 5),
@@ -534,8 +540,6 @@ static void __init mtk_topckgen_init(struct device_node *node)
 				    ARRAY_SIZE(top_muxes), base,
 				    &mt8135_clk_lock, clk_data);
 
-	clk_prepare_enable(clk_data->hws[CLK_TOP_CCI_SEL]->clk);
-
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
@@ -553,8 +557,6 @@ static void __init mtk_infrasys_init(struct device_node *node)
 	mtk_clk_register_gates(NULL, node, infra_clks,
 			       ARRAY_SIZE(infra_clks), clk_data);
 
-	clk_prepare_enable(clk_data->hws[CLK_INFRA_M4U]->clk);
-
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 	if (r)
 		pr_err("%s(): could not register clock provider: %d\n",
-- 
2.39.1

