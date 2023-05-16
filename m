Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2DD704FEB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:52:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbjEPNwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjEPNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:52:37 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAADCE67;
        Tue, 16 May 2023 06:52:20 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 73CFD66058F2;
        Tue, 16 May 2023 14:52:18 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684245139;
        bh=ufkfvUTq+iyLY2prEwuiBlm1RT4f7vEu8daWQ9QE+Ig=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jgFnd8T3EEAffspkydrYiFrUyNo02knyHMOVY3vpB7g4g1GkNxx47bj6OOfKuD4Xn
         gAxhtuhU6t1Y3Q+9v4SENHKeG/57bHcldhW3VQI7riV8WFbuHXifT/SaCCYMmfT1EV
         P9822P5/P2dGvNpVJ7OwDoOZ9GAFQF/4xpT3qbVQThJiEPWOlGlMmGxdkxBJCO0mYR
         OIAaDEEfVBkiAV9hIEDwbUCTtJ6mtFF1Sj3nCUqwHdh3xuBs7kwres7VO936Bq6ILk
         NOnV8esPXZQrTKZFLRGkzNEiXaUyy2h4nejnSgr78gUwn2LvKGrnam1JAAXVXw9BkZ
         2Gb8PE+kZjg4w==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     mturquette@baylibre.com
Cc:     sboyd@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com, wenst@chromium.org,
        chun-jie.chen@mediatek.com, mandyjh.liu@mediatek.com,
        miles.chen@mediatek.com, zhaojh329@gmail.com,
        daniel@makrotopia.org, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, Garmin.Chang@mediatek.com,
        msp@baylibre.com, yangyingliang@huawei.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: [PATCH v2 2/2] clk: mediatek: Remove CLK_SET_PARENT from all MSDC core clocks
Date:   Tue, 16 May 2023 15:52:05 +0200
Message-Id: <20230516135205.372951-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516135205.372951-1-angelogioacchino.delregno@collabora.com>
References: <20230516135205.372951-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Various MSDC core clocks, used for multiple MSDC controller instances,
share the same parent(s): in order to add parents selection in the
mtk-sd driver to achieve an accurate clock rate for all modes, remove
the CLK_SET_RATE_PARENT flag from all MSDC clocks for all SoCs: this
will make sure that a clk_set_rate() call performed for a clock on
a secondary controller will not change the rate of a common parent,
which would result in an overclock or underclock of one of the
controllers.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/clk/mediatek/clk-mt6765.c          | 12 ++++-----
 drivers/clk/mediatek/clk-mt6779.c          | 18 ++++++-------
 drivers/clk/mediatek/clk-mt7981-topckgen.c | 12 ++++-----
 drivers/clk/mediatek/clk-mt7986-topckgen.c | 12 ++++-----
 drivers/clk/mediatek/clk-mt8173-topckgen.c | 24 ++++++++---------
 drivers/clk/mediatek/clk-mt8183.c          | 16 ++++++------
 drivers/clk/mediatek/clk-mt8186-topckgen.c | 12 ++++-----
 drivers/clk/mediatek/clk-mt8188-topckgen.c | 16 ++++++------
 drivers/clk/mediatek/clk-mt8192.c          | 17 ++++++------
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 16 ++++++------
 drivers/clk/mediatek/clk-mt8365.c          | 30 +++++++++++-----------
 11 files changed, 93 insertions(+), 92 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 4f028df6c0a9..0377e6dd3206 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -406,15 +406,15 @@ static const struct mtk_mux top_muxes[] = {
 			CLK_CFG_2_SET, CLK_CFG_2_CLR, 24, 2, 31,
 			CLK_CFG_UPDATE, 11),
 	/* CLK_CFG_3 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK_SEL, "msdc5hclk",
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK_SEL, "msdc5hclk",
 			msdc5hclk_parents, CLK_CFG_3, CLK_CFG_3_SET,
-			CLK_CFG_3_CLR, 0, 2, 7, CLK_CFG_UPDATE, 12),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
+			CLK_CFG_3_CLR, 0, 2, 7, CLK_CFG_UPDATE, 12, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
 			msdc50_0_parents, CLK_CFG_3, CLK_CFG_3_SET,
-			CLK_CFG_3_CLR, 8, 3, 15, CLK_CFG_UPDATE, 13),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
+			CLK_CFG_3_CLR, 8, 3, 15, CLK_CFG_UPDATE, 13, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
 			msdc30_1_parents, CLK_CFG_3, CLK_CFG_3_SET,
-			CLK_CFG_3_CLR, 16, 3, 23, CLK_CFG_UPDATE, 14),
+			CLK_CFG_3_CLR, 16, 3, 23, CLK_CFG_UPDATE, 14, 0),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents,
 			CLK_CFG_3, CLK_CFG_3_SET, CLK_CFG_3_CLR,
 			24, 2, 31, CLK_CFG_UPDATE, 15),
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index ada927a61309..555e937e9430 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -687,16 +687,16 @@ static const struct mtk_mux top_muxes[] = {
 			     0x70, 0x74, 0x78, 0, 1, 7, 0x004, 20),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI, "spi_sel", spi_parents,
 			     0x70, 0x74, 0x78, 8, 2, 15, 0x004, 21),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "msdc50_hclk_sel",
-			     msdc50_hclk_parents, 0x70, 0x74, 0x78,
-			     16, 2, 23, 0x004, 22),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "msdc50_0_sel",
-			     msdc50_0_parents, 0x70, 0x74, 0x78,
-			     24, 3, 31, 0x004, 23),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK, "msdc50_hclk_sel",
+				   msdc50_hclk_parents, 0x70, 0x74, 0x78,
+				   16, 2, 23, 0x004, 22, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0, "msdc50_0_sel",
+				   msdc50_0_parents, 0x70, 0x74, 0x78,
+				   24, 3, 31, 0x004, 23, 0),
 	/* CLK_CFG_6 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "msdc30_1_sel",
-			     msdc30_1_parents, 0x80, 0x84, 0x88,
-			     0, 3, 7, 0x004, 24),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1, "msdc30_1_sel",
+				   msdc30_1_parents, 0x80, 0x84, 0x88,
+				   0, 3, 7, 0x004, 24, 0),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD, "audio_sel", audio_parents,
 			     0x80, 0x84, 0x88, 8, 2, 15, 0x004, 25),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS, "aud_intbus_sel",
diff --git a/drivers/clk/mediatek/clk-mt7981-topckgen.c b/drivers/clk/mediatek/clk-mt7981-topckgen.c
index 3aba1a9b9a36..ac015a68674c 100644
--- a/drivers/clk/mediatek/clk-mt7981-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7981-topckgen.c
@@ -310,12 +310,12 @@ static const struct mtk_mux top_muxes[] = {
 			     pextp_tl_ck_parents, 0x010, 0x014, 0x018, 24, 2, 31,
 			     0x1C0, 7),
 	/* CLK_CFG_2 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_208M_SEL, "emmc_208m_sel",
-			     emmc_208m_parents, 0x020, 0x024, 0x028, 0, 3, 7,
-			     0x1C0, 8),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_400M_SEL, "emmc_400m_sel",
-			     emmc_400m_parents, 0x020, 0x024, 0x028, 8, 2, 15,
-			     0x1C0, 9),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_EMMC_208M_SEL, "emmc_208m_sel",
+				   emmc_208m_parents, 0x020, 0x024, 0x028, 0, 3, 7,
+				   0x1C0, 8, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_EMMC_400M_SEL, "emmc_400m_sel",
+				   emmc_400m_parents, 0x020, 0x024, 0x028, 8, 2, 15,
+				   0x1C0, 9, 0),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_F26M_SEL, "csw_f26m_sel",
 				   csw_f26m_parents, 0x020, 0x024, 0x028, 16, 1, 23,
 				   0x1C0, 10,
diff --git a/drivers/clk/mediatek/clk-mt7986-topckgen.c b/drivers/clk/mediatek/clk-mt7986-topckgen.c
index fbca3feded8f..536655bede26 100644
--- a/drivers/clk/mediatek/clk-mt7986-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt7986-topckgen.c
@@ -193,12 +193,12 @@ static const struct mtk_mux top_muxes[] = {
 			     pextp_tl_ck_parents, 0x010, 0x014, 0x018, 24, 2,
 			     31, 0x1C0, 7),
 	/* CLK_CFG_2 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_250M_SEL, "emmc_250m_sel",
-			     emmc_250m_parents, 0x020, 0x024, 0x028, 0, 1, 7,
-			     0x1C0, 8),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_EMMC_416M_SEL, "emmc_416m_sel",
-			     emmc_416m_parents, 0x020, 0x024, 0x028, 8, 1, 15,
-			     0x1C0, 9),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_EMMC_250M_SEL, "emmc_250m_sel",
+				   emmc_250m_parents, 0x020, 0x024, 0x028, 0, 1, 7,
+				   0x1C0, 8, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_EMMC_416M_SEL, "emmc_416m_sel",
+				   emmc_416m_parents, 0x020, 0x024, 0x028, 8, 1, 15,
+				   0x1C0, 9, 0),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_F_26M_ADC_SEL, "f_26m_adc_sel",
 			     f_26m_adc_parents, 0x020, 0x024, 0x028, 16, 1, 23,
 			     0x1C0, 10),
diff --git a/drivers/clk/mediatek/clk-mt8173-topckgen.c b/drivers/clk/mediatek/clk-mt8173-topckgen.c
index baa8fd6cb312..42c37541cebb 100644
--- a/drivers/clk/mediatek/clk-mt8173-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8173-topckgen.c
@@ -547,17 +547,17 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_USB20_SEL, "usb20_sel", usb20_parents, 0x0060, 24, 2, 31),
 	/* CLK_CFG_3 */
 	MUX_GATE(CLK_TOP_USB30_SEL, "usb30_sel", usb30_parents, 0x0070, 0, 2, 7),
-	MUX_GATE(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel", msdc50_0_h_parents,
-		 0x0070, 8, 3, 15),
-	MUX_GATE(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents,
-		 0x0070, 16, 4, 23),
-	MUX_GATE(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents,
-		 0x0070, 24, 3, 31),
+	MUX_GATE_FLAGS(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel", msdc50_0_h_parents,
+		 0x0070, 8, 3, 15, 0),
+	MUX_GATE_FLAGS(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel", msdc50_0_parents,
+		 0x0070, 16, 4, 23, 0),
+	MUX_GATE_FLAGS(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel", msdc30_1_parents,
+		 0x0070, 24, 3, 31, 0),
 	/* CLK_CFG_4 */
-	MUX_GATE(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_2_parents,
-		 0x0080, 0, 3, 7),
-	MUX_GATE(CLK_TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_parents,
-		 0x0080, 8, 4, 15),
+	MUX_GATE_FLAGS(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel", msdc30_2_parents,
+		 0x0080, 0, 3, 7, 0),
+	MUX_GATE_FLAGS(CLK_TOP_MSDC30_3_SEL, "msdc30_3_sel", msdc30_3_parents,
+		 0x0080, 8, 4, 15, 0),
 	MUX_GATE(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents,
 		 0x0080, 16, 2, 23),
 	MUX_GATE(CLK_TOP_AUD_INTBUS_SEL, "aud_intbus_sel", aud_intbus_parents,
@@ -595,8 +595,8 @@ static const struct mtk_composite top_muxes[] = {
 	MUX_GATE(CLK_TOP_DPILVDS_SEL, "dpilvds_sel", dpilvds_parents,
 		 0x00c0, 24, 3, 31),
 	/* CLK_CFG_13 */
-	MUX_GATE(CLK_TOP_MSDC50_2_H_SEL, "msdc50_2_h_sel", msdc50_2_h_parents,
-		 0x00d0, 0, 3, 7),
+	MUX_GATE_FLAGS(CLK_TOP_MSDC50_2_H_SEL, "msdc50_2_h_sel", msdc50_2_h_parents,
+		 0x00d0, 0, 3, 7, 0),
 	MUX_GATE(CLK_TOP_HDCP_SEL, "hdcp_sel", hdcp_parents, 0x00d0, 8, 2, 15),
 	MUX_GATE(CLK_TOP_HDCP_24M_SEL, "hdcp_24m_sel", hdcp_24m_parents,
 		 0x00d0, 16, 2, 23),
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 95786b0c2d5f..dc1a24f0046f 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -487,14 +487,14 @@ static const struct mtk_mux top_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_SPI, "spi_sel",
 		spi_parents, 0x70, 0x74, 0x78, 24, 2, 31, 0x004, 15),
 	/* CLK_CFG_4 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MSDC50_0_HCLK, "msdc50_hclk_sel",
-		msdc50_hclk_parents, 0x80, 0x84, 0x88, 0, 2, 7, 0x004, 16),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MSDC50_0, "msdc50_0_sel",
-		msdc50_0_parents, 0x80, 0x84, 0x88, 8, 3, 15, 0x004, 17),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MSDC30_1, "msdc30_1_sel",
-		msdc30_1_parents, 0x80, 0x84, 0x88, 16, 3, 23, 0x004, 18),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MSDC30_2, "msdc30_2_sel",
-		msdc30_2_parents, 0x80, 0x84, 0x88, 24, 3, 31, 0x004, 19),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_MSDC50_0_HCLK, "msdc50_hclk_sel",
+		msdc50_hclk_parents, 0x80, 0x84, 0x88, 0, 2, 7, 0x004, 16, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_MSDC50_0, "msdc50_0_sel",
+		msdc50_0_parents, 0x80, 0x84, 0x88, 8, 3, 15, 0x004, 17, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_MSDC30_1, "msdc30_1_sel",
+		msdc30_1_parents, 0x80, 0x84, 0x88, 16, 3, 23, 0x004, 18, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_MSDC30_2, "msdc30_2_sel",
+		msdc30_2_parents, 0x80, 0x84, 0x88, 24, 3, 31, 0x004, 19, 0),
 	/* CLK_CFG_5 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_AUDIO, "audio_sel",
 		audio_parents, 0x90, 0x94, 0x98, 0, 2, 7, 0x004, 20),
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 669806212073..b8a619e98da0 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -531,12 +531,12 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI, "top_spi",
 		spi_parents, 0x0060, 0x0064, 0x0068, 24, 3, 31, 0x0004, 11),
 	/* CLK_CFG_3 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "top_msdc5hclk",
-		msdc5hclk_parents, 0x0070, 0x0074, 0x0078, 0, 2, 7, 0x0004, 12),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "top_msdc50_0",
-		msdc50_0_parents, 0x0070, 0x0074, 0x0078, 8, 3, 15, 0x0004, 13),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "top_msdc30_1",
-		msdc30_1_parents, 0x0070, 0x0074, 0x0078, 16, 3, 23, 0x0004, 14),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK, "top_msdc5hclk",
+		msdc5hclk_parents, 0x0070, 0x0074, 0x0078, 0, 2, 7, 0x0004, 12, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0, "top_msdc50_0",
+		msdc50_0_parents, 0x0070, 0x0074, 0x0078, 8, 3, 15, 0x0004, 13, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1, "top_msdc30_1",
+		msdc30_1_parents, 0x0070, 0x0074, 0x0078, 16, 3, 23, 0x0004, 14, 0),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO, "top_audio",
 		audio_parents, 0x0070, 0x0074, 0x0078, 24, 2, 31, 0x0004, 15),
 	/* CLK_CFG_4 */
diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
index 7c99244d997e..8699b87b130d 100644
--- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
@@ -1015,15 +1015,15 @@ static const struct mtk_mux top_mtk_muxes[] = {
 			     uart_parents, 0x068, 0x06C, 0x070, 0, 4, 7, 0x04, 24),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI, "top_spi",
 			     spi_parents, 0x068, 0x06C, 0x070, 8, 4, 15, 0x04, 25),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "top_msdc5hclk",
-			     msdc5hclk_parents, 0x068, 0x06C, 0x070, 16, 4, 23, 0x04, 26),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "top_msdc50_0",
-			     msdc50_0_parents, 0x068, 0x06C, 0x070, 24, 4, 31, 0x04, 27),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK, "top_msdc5hclk",
+				   msdc5hclk_parents, 0x068, 0x06C, 0x070, 16, 4, 23, 0x04, 26, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0, "top_msdc50_0",
+				   msdc50_0_parents, 0x068, 0x06C, 0x070, 24, 4, 31, 0x04, 27, 0),
 	/* CLK_CFG_7 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "top_msdc30_1",
-			     msdc30_1_parents, 0x074, 0x078, 0x07C, 0, 4, 7, 0x04, 28),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2, "top_msdc30_2",
-			     msdc30_2_parents, 0x074, 0x078, 0x07C, 8, 4, 15, 0x04, 29),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1, "top_msdc30_1",
+				   msdc30_1_parents, 0x074, 0x078, 0x07C, 0, 4, 7, 0x04, 28, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_2, "top_msdc30_2",
+				   msdc30_2_parents, 0x074, 0x078, 0x07C, 8, 4, 15, 0x04, 29, 0),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_INTDIR, "top_intdir",
 			     intdir_parents, 0x074, 0x078, 0x07C, 16, 4, 23, 0x04, 30),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS, "top_aud_intbus",
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index 8a9e6d5f85b4..55fc6fc3c467 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -601,15 +601,16 @@ static const struct mtk_mux top_mtk_muxes[] = {
 			     uart_parents, 0x070, 0x074, 0x078, 8, 1, 15, 0x004, 25),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel",
 			     spi_parents, 0x070, 0x074, 0x078, 16, 2, 23, 0x004, 26),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel",
-			     msdc50_0_h_parents, 0x070, 0x074, 0x078, 24, 2, 31, 0x004, 27),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_H_SEL, "msdc50_0_h_sel",
+				   msdc50_0_h_parents, 0x070, 0x074, 0x078, 24, 2,
+				   31, 0x004, 27, 0),
 	/* CLK_CFG_7 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
-			     msdc50_0_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x004, 28),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
-			     msdc30_parents, 0x080, 0x084, 0x088, 8, 3, 15, 0x004, 29),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel",
-			     msdc30_parents, 0x080, 0x084, 0x088, 16, 3, 23, 0x004, 30),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
+				   msdc50_0_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x004, 28, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
+				   msdc30_parents, 0x080, 0x084, 0x088, 8, 3, 15, 0x004, 29, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel",
+				   msdc30_parents, 0x080, 0x084, 0x088, 16, 3, 23, 0x004, 30, 0),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel",
 			     audio_parents, 0x080, 0x084, 0x088, 24, 2, 31, 0x008, 0),
 	/* CLK_CFG_8 */
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 3acbd1c907ab..f4b3d8ba9ff4 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -930,15 +930,15 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	/* CLK_CFG_7 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPIS, "top_spis",
 		spis_parents, 0x074, 0x078, 0x07C, 0, 3, 7, 0x04, 28),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HCLK, "top_msdc50_0_hclk",
-		msdc50_0_h_parents, 0x074, 0x078, 0x07C, 8, 2, 15, 0x04, 29),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0, "top_msdc50_0",
-		msdc50_0_parents, 0x074, 0x078, 0x07C, 16, 3, 23, 0x04, 30),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1, "top_msdc30_1",
-		msdc30_parents, 0x074, 0x078, 0x07C, 24, 3, 31, 0x04, 31),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HCLK, "top_msdc50_0_hclk",
+		msdc50_0_h_parents, 0x074, 0x078, 0x07C, 8, 2, 15, 0x04, 29, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0, "top_msdc50_0",
+		msdc50_0_parents, 0x074, 0x078, 0x07C, 16, 3, 23, 0x04, 30, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1, "top_msdc30_1",
+		msdc30_parents, 0x074, 0x078, 0x07C, 24, 3, 31, 0x04, 31, 0),
 	/* CLK_CFG_8 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2, "top_msdc30_2",
-		msdc30_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x08, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_2, "top_msdc30_2",
+		msdc30_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x08, 0, 0),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_INTDIR, "top_intdir",
 		intdir_parents, 0x080, 0x084, 0x088, 8, 2, 15, 0x08, 1),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUD_INTBUS, "top_aud_intbus",
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 28f94e015252..e45381e5d8e2 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -431,22 +431,22 @@ static const struct mtk_mux top_muxes[] = {
 			     0x064, 0x068, 0, 1, 7, CLK_CFG_UPDATE, 8),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel", spi_parents, 0x060,
 			     0x064, 0x068, 8, 2, 15, CLK_CFG_UPDATE, 9),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_HC_SEL, "msdc50_0_hc_sel",
-			     msdc50_0_hc_parents, 0x060, 0x064, 0x068, 16, 2,
-			     23, CLK_CFG_UPDATE, 10),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC2_2_HC_SEL, "msdc2_2_hc_sel",
-			     msdc50_0_hc_parents, 0x060, 0x064, 0x068, 24, 2,
-			     31, CLK_CFG_UPDATE, 11),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_HC_SEL, "msdc50_0_hc_sel",
+				   msdc50_0_hc_parents, 0x060, 0x064, 0x068, 16, 2,
+				   23, CLK_CFG_UPDATE, 10, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC2_2_HC_SEL, "msdc2_2_hc_sel",
+				   msdc50_0_hc_parents, 0x060, 0x064, 0x068, 24, 2,
+				   31, CLK_CFG_UPDATE, 11, 0),
 	/* CLK_CFG_3 */
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
-			     msdc50_0_parents, 0x070, 0x074, 0x078, 0, 3, 7,
-			     CLK_CFG_UPDATE, 12),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_2_SEL, "msdc50_2_sel",
-			     msdc50_2_parents, 0x070, 0x074, 0x078, 8, 3, 15,
-			     CLK_CFG_UPDATE, 13),
-	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
-			     msdc30_1_parents, 0x070, 0x074, 0x078, 16, 3, 23,
-			     CLK_CFG_UPDATE, 14),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
+				   msdc50_0_parents, 0x070, 0x074, 0x078, 0, 3, 7,
+				   CLK_CFG_UPDATE, 12, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC50_2_SEL, "msdc50_2_sel",
+				   msdc50_2_parents, 0x070, 0x074, 0x078, 8, 3, 15,
+				   CLK_CFG_UPDATE, 13, 0),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
+				   msdc30_1_parents, 0x070, 0x074, 0x078, 16, 3, 23,
+				   CLK_CFG_UPDATE, 14, 0),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents,
 			     0x070, 0x074, 0x078, 24, 2, 31, CLK_CFG_UPDATE,
 			     15),
-- 
2.40.1

