Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334F25EA152
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 12:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbiIZKsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 06:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiIZKqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 06:46:34 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB2E57201
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:55 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso6251905pjm.5
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 03:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=dfrvFJv3fbVYtkzOesS2nCjv03jbPjSnpl4/pHrmOI0=;
        b=R3fvf+mIuTcwr8RUSPIbTjbb+QNP6w61DPA9Q0Zg51chRmtM9nCtrQzcBcCUoWuz0L
         1djaOg9i11ufJet1Xquh0IBifxnAmxKkYmJHAGTjLAxmnBj0lhKwCOXeHqE1pBsZFt8t
         dGijk7zDNaieq6F30gZrAAMqrkaYe2ci1E4yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=dfrvFJv3fbVYtkzOesS2nCjv03jbPjSnpl4/pHrmOI0=;
        b=YrGJJMq7xDThxyK5e72ewz+PJZMwymW26k1jKJ1kNuu1lzOwNKQyhT7RPo2RP8RlKB
         VGv5RBie7ANmitFaB83RIbZJOj9aX3dVfz5QcV2lgF5KVza9P/P3fKu4iCuum1Cp55FS
         AvPc9bQwgorn0xxWxvVzcZSJhuonM70pEzmo1KZkO0LDLdMbWPpitKMzuWwPDPLmr0sv
         Sv5451ewNO0kQclDVk+GPYcH2I7Y5KJ/N1Sunky19YDLR+t+NNiLOFlZC2L5YCvBByUi
         RmzRsvVPa+wAVHYRFQ/uZJsusCoxTZo4bkUEVZ2aqmd2i5MimOS98XLiN15VjmyDqQmv
         ObSQ==
X-Gm-Message-State: ACrzQf0T+sQS13HJnvO+rZSa9sAPFgwY3NOZr7dGkhBPiQamq5BCcGMa
        UUbzafyVwWZy+kVG58ZunNuc5A==
X-Google-Smtp-Source: AMsMyM4e37D4auwSkCzoht355wZttO7a0T0S5nuoiQPOkNpD3entmXxn4kS3po1nh0f2CqPH736YUA==
X-Received: by 2002:a17:902:f08a:b0:176:b477:8be0 with SMTP id p10-20020a170902f08a00b00176b4778be0mr21924036pla.66.1664187954811;
        Mon, 26 Sep 2022 03:25:54 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:1340:7319:2f7a:3be9])
        by smtp.gmail.com with ESMTPSA id y23-20020aa79af7000000b00536aa488062sm11750236pfp.163.2022.09.26.03.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 03:25:53 -0700 (PDT)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] clk: mediatek: mt8192: deduplicate parent clock lists
Date:   Mon, 26 Sep 2022 18:25:22 +0800
Message-Id: <20220926102523.2367530-6-wenst@chromium.org>
X-Mailer: git-send-email 2.37.3.998.g577e59143f-goog
In-Reply-To: <20220926102523.2367530-1-wenst@chromium.org>
References: <20220926102523.2367530-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some groups of clocks of the same type share the same list of parents.
These lists were declared separately for each clock in older drivers,
bloating the code.

Merge some obvious duplicate parent clock lists in the MT8192 clock
driver together to reduce the code size. These include:

- apll_i2s*_m_parents into one as apll_i2s_m_parents
- img1_parents & img2_parents into one as img_parents
- msdc30_*_parents into one as msdc30_parents
- camtg*_parents into cam_tg_parents
- seninf*_parents into seninf_parents

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/clk/mediatek/clk-mt8192.c | 206 ++++--------------------------
 1 file changed, 25 insertions(+), 181 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index c2ce72df6db0..d3f57fb73c49 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -167,22 +167,7 @@ static const char * const mdp_parents[] = {
 	"mmpll_d5_d2"
 };
 
-static const char * const img1_parents[] = {
-	"clk26m",
-	"univpll_d4",
-	"tvdpll_ck",
-	"mainpll_d4",
-	"univpll_d5",
-	"mmpll_d6",
-	"univpll_d6",
-	"mainpll_d6",
-	"mmpll_d4_d2",
-	"mainpll_d4_d2",
-	"mmpll_d6_d2",
-	"mmpll_d5_d2"
-};
-
-static const char * const img2_parents[] = {
+static const char * const img_parents[] = {
 	"clk26m",
 	"univpll_d4",
 	"tvdpll_ck",
@@ -280,61 +265,6 @@ static const char * const camtg_parents[] = {
 	"univpll_192m_d32"
 };
 
-static const char * const camtg2_parents[] = {
-	"clk26m",
-	"univpll_192m_d8",
-	"univpll_d6_d8",
-	"univpll_192m_d4",
-	"univpll_d6_d16",
-	"csw_f26m_d2",
-	"univpll_192m_d16",
-	"univpll_192m_d32"
-};
-
-static const char * const camtg3_parents[] = {
-	"clk26m",
-	"univpll_192m_d8",
-	"univpll_d6_d8",
-	"univpll_192m_d4",
-	"univpll_d6_d16",
-	"csw_f26m_d2",
-	"univpll_192m_d16",
-	"univpll_192m_d32"
-};
-
-static const char * const camtg4_parents[] = {
-	"clk26m",
-	"univpll_192m_d8",
-	"univpll_d6_d8",
-	"univpll_192m_d4",
-	"univpll_d6_d16",
-	"csw_f26m_d2",
-	"univpll_192m_d16",
-	"univpll_192m_d32"
-};
-
-static const char * const camtg5_parents[] = {
-	"clk26m",
-	"univpll_192m_d8",
-	"univpll_d6_d8",
-	"univpll_192m_d4",
-	"univpll_d6_d16",
-	"csw_f26m_d2",
-	"univpll_192m_d16",
-	"univpll_192m_d32"
-};
-
-static const char * const camtg6_parents[] = {
-	"clk26m",
-	"univpll_192m_d8",
-	"univpll_d6_d8",
-	"univpll_192m_d4",
-	"univpll_d6_d16",
-	"csw_f26m_d2",
-	"univpll_192m_d16",
-	"univpll_192m_d32"
-};
-
 static const char * const uart_parents[] = {
 	"clk26m",
 	"univpll_d6_d8"
@@ -362,15 +292,7 @@ static const char * const msdc50_0_parents[] = {
 	"univpll_d4_d2"
 };
 
-static const char * const msdc30_1_parents[] = {
-	"clk26m",
-	"univpll_d6_d2",
-	"mainpll_d6_d2",
-	"mainpll_d7_d2",
-	"msdcpll_d2"
-};
-
-static const char * const msdc30_2_parents[] = {
+static const char * const msdc30_parents[] = {
 	"clk26m",
 	"univpll_d6_d2",
 	"mainpll_d6_d2",
@@ -457,39 +379,6 @@ static const char * const seninf_parents[] = {
 	"univpll_d5"
 };
 
-static const char * const seninf1_parents[] = {
-	"clk26m",
-	"univpll_d4_d4",
-	"univpll_d6_d2",
-	"univpll_d4_d2",
-	"univpll_d7",
-	"univpll_d6",
-	"mmpll_d6",
-	"univpll_d5"
-};
-
-static const char * const seninf2_parents[] = {
-	"clk26m",
-	"univpll_d4_d4",
-	"univpll_d6_d2",
-	"univpll_d4_d2",
-	"univpll_d7",
-	"univpll_d6",
-	"mmpll_d6",
-	"univpll_d5"
-};
-
-static const char * const seninf3_parents[] = {
-	"clk26m",
-	"univpll_d4_d4",
-	"univpll_d6_d2",
-	"univpll_d4_d2",
-	"univpll_d7",
-	"univpll_d6",
-	"mmpll_d6",
-	"univpll_d5"
-};
-
 static const char * const tl_parents[] = {
 	"clk26m",
 	"univpll_192m_d2",
@@ -649,52 +538,7 @@ static const char * const sflash_parents[] = {
 	"univpll_d5_d8"
 };
 
-static const char * const apll_i2s0_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s1_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s2_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s3_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s4_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s5_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s6_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s7_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s8_m_parents[] = {
-	"aud_1_sel",
-	"aud_2_sel"
-};
-
-static const char * const apll_i2s9_m_parents[] = {
+static const char * const apll_i2s_m_parents[] = {
 	"aud_1_sel",
 	"aud_2_sel"
 };
@@ -724,9 +568,9 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MDP_SEL, "mdp_sel",
 			     mdp_parents, 0x020, 0x024, 0x028, 8, 4, 15, 0x004, 5),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_IMG1_SEL, "img1_sel",
-			     img1_parents, 0x020, 0x024, 0x028, 16, 4, 23, 0x004, 6),
+			     img_parents, 0x020, 0x024, 0x028, 16, 4, 23, 0x004, 6),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_IMG2_SEL, "img2_sel",
-			     img2_parents, 0x020, 0x024, 0x028, 24, 4, 31, 0x004, 7),
+			     img_parents, 0x020, 0x024, 0x028, 24, 4, 31, 0x004, 7),
 	/* CLK_CFG_2 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_IPE_SEL, "ipe_sel",
 			     ipe_parents, 0x030, 0x034, 0x038, 0, 4, 7, 0x004, 8),
@@ -747,16 +591,16 @@ static const struct mtk_mux top_mtk_muxes[] = {
 			     camtg_parents, 0x050, 0x054, 0x058, 24, 3, 31, 0x004, 19),
 	/* CLK_CFG_5 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG2_SEL, "camtg2_sel",
-			     camtg2_parents, 0x060, 0x064, 0x068, 0, 3, 7, 0x004, 20),
+			     camtg_parents, 0x060, 0x064, 0x068, 0, 3, 7, 0x004, 20),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG3_SEL, "camtg3_sel",
-			     camtg3_parents, 0x060, 0x064, 0x068, 8, 3, 15, 0x004, 21),
+			     camtg_parents, 0x060, 0x064, 0x068, 8, 3, 15, 0x004, 21),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG4_SEL, "camtg4_sel",
-			     camtg4_parents, 0x060, 0x064, 0x068, 16, 3, 23, 0x004, 22),
+			     camtg_parents, 0x060, 0x064, 0x068, 16, 3, 23, 0x004, 22),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG5_SEL, "camtg5_sel",
-			     camtg5_parents, 0x060, 0x064, 0x068, 24, 3, 31, 0x004, 23),
+			     camtg_parents, 0x060, 0x064, 0x068, 24, 3, 31, 0x004, 23),
 	/* CLK_CFG_6 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG6_SEL, "camtg6_sel",
-			     camtg6_parents, 0x070, 0x074, 0x078, 0, 3, 7, 0x004, 24),
+			     camtg_parents, 0x070, 0x074, 0x078, 0, 3, 7, 0x004, 24),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_UART_SEL, "uart_sel",
 			     uart_parents, 0x070, 0x074, 0x078, 8, 1, 15, 0x004, 25),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel",
@@ -767,9 +611,9 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
 			     msdc50_0_parents, 0x080, 0x084, 0x088, 0, 3, 7, 0x004, 28),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
-			     msdc30_1_parents, 0x080, 0x084, 0x088, 8, 3, 15, 0x004, 29),
+			     msdc30_parents, 0x080, 0x084, 0x088, 8, 3, 15, 0x004, 29),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MSDC30_2_SEL, "msdc30_2_sel",
-			     msdc30_2_parents, 0x080, 0x084, 0x088, 16, 3, 23, 0x004, 30),
+			     msdc30_parents, 0x080, 0x084, 0x088, 16, 3, 23, 0x004, 30),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel",
 			     audio_parents, 0x080, 0x084, 0x088, 24, 2, 31, 0x008, 0),
 	/* CLK_CFG_8 */
@@ -796,12 +640,12 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF_SEL, "seninf_sel",
 			     seninf_parents, 0x0b0, 0x0b4, 0x0b8, 16, 3, 23, 0x008, 11),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF1_SEL, "seninf1_sel",
-			     seninf1_parents, 0x0b0, 0x0b4, 0x0b8, 24, 3, 31, 0x008, 12),
+			     seninf_parents, 0x0b0, 0x0b4, 0x0b8, 24, 3, 31, 0x008, 12),
 	/* CLK_CFG_11 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF2_SEL, "seninf2_sel",
-			     seninf2_parents, 0x0c0, 0x0c4, 0x0c8, 0, 3, 7, 0x008, 13),
+			     seninf_parents, 0x0c0, 0x0c4, 0x0c8, 0, 3, 7, 0x008, 13),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SENINF3_SEL, "seninf3_sel",
-			     seninf3_parents, 0x0c0, 0x0c4, 0x0c8, 8, 3, 15, 0x008, 14),
+			     seninf_parents, 0x0c0, 0x0c4, 0x0c8, 8, 3, 15, 0x008, 14),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_TL_SEL, "tl_sel",
 			     tl_parents, 0x0c0, 0x0c4, 0x0c8, 16, 2, 23, 0x008, 15),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DXCC_SEL, "dxcc_sel",
@@ -847,16 +691,16 @@ static const struct mtk_mux top_mtk_muxes[] = {
 
 static struct mtk_composite top_muxes[] = {
 	/* CLK_AUDDIV_0 */
-	MUX(CLK_TOP_APLL_I2S0_M_SEL, "apll_i2s0_m_sel", apll_i2s0_m_parents, 0x320, 16, 1),
-	MUX(CLK_TOP_APLL_I2S1_M_SEL, "apll_i2s1_m_sel", apll_i2s1_m_parents, 0x320, 17, 1),
-	MUX(CLK_TOP_APLL_I2S2_M_SEL, "apll_i2s2_m_sel", apll_i2s2_m_parents, 0x320, 18, 1),
-	MUX(CLK_TOP_APLL_I2S3_M_SEL, "apll_i2s3_m_sel", apll_i2s3_m_parents, 0x320, 19, 1),
-	MUX(CLK_TOP_APLL_I2S4_M_SEL, "apll_i2s4_m_sel", apll_i2s4_m_parents, 0x320, 20, 1),
-	MUX(CLK_TOP_APLL_I2S5_M_SEL, "apll_i2s5_m_sel", apll_i2s5_m_parents, 0x320, 21, 1),
-	MUX(CLK_TOP_APLL_I2S6_M_SEL, "apll_i2s6_m_sel", apll_i2s6_m_parents, 0x320, 22, 1),
-	MUX(CLK_TOP_APLL_I2S7_M_SEL, "apll_i2s7_m_sel", apll_i2s7_m_parents, 0x320, 23, 1),
-	MUX(CLK_TOP_APLL_I2S8_M_SEL, "apll_i2s8_m_sel", apll_i2s8_m_parents, 0x320, 24, 1),
-	MUX(CLK_TOP_APLL_I2S9_M_SEL, "apll_i2s9_m_sel", apll_i2s9_m_parents, 0x320, 25, 1),
+	MUX(CLK_TOP_APLL_I2S0_M_SEL, "apll_i2s0_m_sel", apll_i2s_m_parents, 0x320, 16, 1),
+	MUX(CLK_TOP_APLL_I2S1_M_SEL, "apll_i2s1_m_sel", apll_i2s_m_parents, 0x320, 17, 1),
+	MUX(CLK_TOP_APLL_I2S2_M_SEL, "apll_i2s2_m_sel", apll_i2s_m_parents, 0x320, 18, 1),
+	MUX(CLK_TOP_APLL_I2S3_M_SEL, "apll_i2s3_m_sel", apll_i2s_m_parents, 0x320, 19, 1),
+	MUX(CLK_TOP_APLL_I2S4_M_SEL, "apll_i2s4_m_sel", apll_i2s_m_parents, 0x320, 20, 1),
+	MUX(CLK_TOP_APLL_I2S5_M_SEL, "apll_i2s5_m_sel", apll_i2s_m_parents, 0x320, 21, 1),
+	MUX(CLK_TOP_APLL_I2S6_M_SEL, "apll_i2s6_m_sel", apll_i2s_m_parents, 0x320, 22, 1),
+	MUX(CLK_TOP_APLL_I2S7_M_SEL, "apll_i2s7_m_sel", apll_i2s_m_parents, 0x320, 23, 1),
+	MUX(CLK_TOP_APLL_I2S8_M_SEL, "apll_i2s8_m_sel", apll_i2s_m_parents, 0x320, 24, 1),
+	MUX(CLK_TOP_APLL_I2S9_M_SEL, "apll_i2s9_m_sel", apll_i2s_m_parents, 0x320, 25, 1),
 };
 
 static const struct mtk_composite top_adj_divs[] = {
-- 
2.37.3.998.g577e59143f-goog

