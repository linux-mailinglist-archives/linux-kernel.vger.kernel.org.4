Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EAE654ECA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 10:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236192AbiLWJqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 04:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236094AbiLWJpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 04:45:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF003B422;
        Fri, 23 Dec 2022 01:43:40 -0800 (PST)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BAC966602D03;
        Fri, 23 Dec 2022 09:43:37 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1671788619;
        bh=hfLSNFYO1N3oGbd/PPfAVz7ORJ/6t7ABxEYaZXHA2pw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AzWc8aLUPhPJcSTa9F0o0yw5RCfx2BJtjMg55XZ5roP5O8N6CVWjkXOG9YSmDY3A8
         26psj8q1xw6CiI3UCN9N0HhxoWc8fpwSst5ZsjiURSwnYgIa0FS1ZY/GU2eMUfGWiq
         DLw7twAIOSPwAtaMjMju+gV0aZl5Uf3Q+r3lFC92wNsCPqdZXCJx9kj6oIJ2x6nk14
         LS1Gk+nZO+ENZD1FhSvFVwgmgr9o1I8Oyj6Bb91WhCv6UuLY4zkPMbj2WdkUv8TUCb
         sVxpqks6ahdoqCHBhRNrfodg6WBefBMMIS/iR5CbRtrrkbpSqUdMdO5o4HcY8iSf/N
         tVp9JfoLTX6xQ==
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
Subject: [PATCH v2 22/23] clk: mediatek: clk-mt7986-topckgen: Properly keep some clocks enabled
Date:   Fri, 23 Dec 2022 10:42:58 +0100
Message-Id: <20221223094259.87373-23-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
References: <20221223094259.87373-1-angelogioacchino.delregno@collabora.com>
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

Instead of calling clk_prepare_enable() on a bunch of clocks at probe
time, set the CLK_IS_CRITICAL flag to the same as these are required
to be always on, and this is the right way of achieving that.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 46 +++++++++++-----------
 1 file changed, 24 insertions(+), 22 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index d7df9585787f..bf3088e6d9e3 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -202,16 +202,23 @@ static const struct mtk_mux top_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_F_26M_ADC_SEL, "f_26m_adc_sel",
 			     f_26m_adc_parents, 0x020, 0x024, 0x028, 16, 1, 23,
 			     0x1C0, 10),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_DRAMC_SEL, "dramc_sel", f_26m_adc_parents,
-			     0x020, 0x024, 0x028, 24, 1, 31, 0x1C0, 11),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DRAMC_SEL, "dramc_sel",
+				   f_26m_adc_parents, 0x020, 0x024, 0x028,
+				   24, 1, 31, 0x1C0, 11,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/* CLK_CFG_3 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_DRAMC_MD32_SEL, "dramc_md32_sel",
-			     dramc_md32_parents, 0x030, 0x034, 0x038, 0, 1, 7,
-			     0x1C0, 12),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_SYSAXI_SEL, "sysaxi_sel", sysaxi_parents,
-			     0x030, 0x034, 0x038, 8, 2, 15, 0x1C0, 13),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_SYSAPB_SEL, "sysapb_sel", sysapb_parents,
-			     0x030, 0x034, 0x038, 16, 2, 23, 0x1C0, 14),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DRAMC_MD32_SEL, "dramc_md32_sel",
+				   dramc_md32_parents, 0x030, 0x034, 0x038,
+				   0, 1, 7, 0x1C0, 12,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SYSAXI_SEL, "sysaxi_sel",
+				   sysaxi_parents, 0x030, 0x034, 0x038,
+				   8, 2, 15, 0x1C0, 13,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SYSAPB_SEL, "sysapb_sel",
+				   sysapb_parents, 0x030, 0x034, 0x038,
+				   16, 2, 23, 0x1C0, 14,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_ARM_DB_MAIN_SEL, "arm_db_main_sel",
 			     arm_db_main_parents, 0x030, 0x034, 0x038, 24, 1,
 			     31, 0x1C0, 15),
@@ -234,9 +241,10 @@ static const struct mtk_mux top_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_325M_SEL, "sgm_325m_sel",
 			     sgm_325m_parents, 0x050, 0x054, 0x058, 8, 1, 15,
 			     0x1C0, 21),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel",
-			     sgm_reg_parents, 0x050, 0x054, 0x058, 16, 1, 23,
-			     0x1C0, 22),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SGM_REG_SEL, "sgm_reg_sel",
+				   sgm_reg_parents, 0x050, 0x054, 0x058,
+				   16, 1, 23, 0x1C0, 22,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_A1SYS_SEL, "a1sys_sel", a1sys_parents,
 			     0x050, 0x054, 0x058, 24, 1, 31, 0x1C0, 23),
 	/* CLK_CFG_6 */
@@ -252,9 +260,10 @@ static const struct mtk_mux top_muxes[] = {
 			     f_26m_adc_parents, 0x060, 0x064, 0x068, 24, 1, 31,
 			     0x1C0, 27),
 	/* CLK_CFG_7 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_F26M_SEL, "csw_f26m_sel",
-			     f_26m_adc_parents, 0x070, 0x074, 0x078, 0, 1, 7,
-			     0x1C0, 28),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_F26M_SEL, "csw_f26m_sel",
+				   f_26m_adc_parents, 0x070, 0x074, 0x078,
+				   0, 1, 7, 0x1C0, 28,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_L_SEL, "aud_l_sel", aud_l_parents,
 			     0x070, 0x074, 0x078, 8, 2, 15, 0x1C0, 29),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_A_TUNER_SEL, "a_tuner_sel",
@@ -306,13 +315,6 @@ static int clk_mt7986_topckgen_probe(struct platform_device *pdev)
 	mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
 			       &mt7986_clk_lock, clk_data, &pdev->dev);
 
-	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAXI_SEL]->clk);
-	clk_prepare_enable(clk_data->hws[CLK_TOP_SYSAPB_SEL]->clk);
-	clk_prepare_enable(clk_data->hws[CLK_TOP_DRAMC_SEL]->clk);
-	clk_prepare_enable(clk_data->hws[CLK_TOP_DRAMC_MD32_SEL]->clk);
-	clk_prepare_enable(clk_data->hws[CLK_TOP_F26M_SEL]->clk);
-	clk_prepare_enable(clk_data->hws[CLK_TOP_SGM_REG_SEL]->clk);
-
 	r = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
 
 	if (r) {
-- 
2.39.0

