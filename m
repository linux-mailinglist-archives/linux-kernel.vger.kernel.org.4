Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A553D704FEA
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 15:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233803AbjEPNwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 09:52:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjEPNwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 09:52:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D38312C;
        Tue, 16 May 2023 06:52:19 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (unknown [IPv6:2001:b07:2ed:14ed:a962:cd4d:a84:1eab])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DAA7C66058EE;
        Tue, 16 May 2023 14:52:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684245138;
        bh=x2dy/8x6paWf4RnAJeXasl5ck2RGUFcu8+qpfg51DI8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eYCpCGwH8wAbP8Xr6X5pM3sNLlq8EmTXNk5H4xeBkesiLGAJ2ROvAZG6smACquijt
         UBy4+DPdcyEksZfLc703uPYbC6uLiTuSRtTAtOk7doems2nCMR7iI/GnRDzONy8Wm/
         uNBP3QB2yNCO+4nz9VSlRAarG37wLQYpVGlwmTgaJr/HUFsh+55mN+oUz1c3ppHgEE
         a8Jw8R87kxGS6TUGhUE+wbVC516xN6MF6dqdcG5I8a7JLEvkUqUua6YcRgkCjbb33+
         PRJXEhj9BBhW+1zlrph5g0xjzjquTE4V2R7isi34NKR+i9bVs8GPAO4rkSO6il1Eru
         U/mz//3cvEeBA==
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
Subject: [PATCH v2 1/2] clk: mediatek: mux: Stop forcing CLK_SET_RATE_PARENT flag
Date:   Tue, 16 May 2023 15:52:04 +0200
Message-Id: <20230516135205.372951-2-angelogioacchino.delregno@collabora.com>
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

The clk-mux driver was forcing the CLK_SET_RATE_PARENT flag even for
the GATE_CLK_SET_UPD_FLAGS() macro, as in mtk_clk_register_mux() the
flag was unconditionally added.

In preparation for a change on MSDC clock muxes, stop forcing this
flag and, where necessary, update clock drivers to add it so that
with this commit we introduce no functional changes for the currently
supported SoCs.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 drivers/clk/mediatek/clk-mt6765.c          |  8 +++---
 drivers/clk/mediatek/clk-mt6779.c          |  6 ++---
 drivers/clk/mediatek/clk-mt8183.c          |  6 +++--
 drivers/clk/mediatek/clk-mt8186-topckgen.c | 12 ++++-----
 drivers/clk/mediatek/clk-mt8188-topckgen.c | 24 +++++++++++------
 drivers/clk/mediatek/clk-mt8192.c          |  6 ++---
 drivers/clk/mediatek/clk-mt8195-topckgen.c | 30 ++++++++++++++--------
 drivers/clk/mediatek/clk-mt8365.c          |  8 +++---
 drivers/clk/mediatek/clk-mux.c             |  2 +-
 9 files changed, 62 insertions(+), 40 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index fa7948ef1e68..4f028df6c0a9 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -367,10 +367,12 @@ static const struct mtk_mux top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
 			      CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR,
-			      0, 2, 7, CLK_CFG_UPDATE, 0, CLK_IS_CRITICAL),
+			      0, 2, 7, CLK_CFG_UPDATE, 0,
+			      CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MEM_SEL, "mem_sel", mem_parents,
 			      CLK_CFG_0, CLK_CFG_0_SET, CLK_CFG_0_CLR,
-			      8, 2, 15, CLK_CFG_UPDATE, 1, CLK_IS_CRITICAL),
+			      8, 2, 15, CLK_CFG_UPDATE, 1,
+			      CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MM_SEL, "mm_sel", mm_parents, CLK_CFG_0,
 			CLK_CFG_0_SET, CLK_CFG_0_CLR, 16, 3, 23,
 			CLK_CFG_UPDATE, 2),
@@ -459,7 +461,7 @@ static const struct mtk_mux top_muxes[] = {
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_PWRAP_ULPOSC_SEL, "ulposc_sel",
 			      ulposc_parents, CLK_CFG_7, CLK_CFG_7_SET,
 			      CLK_CFG_7_CLR, 0, 3, 7, CLK_CFG_UPDATE, 28,
-			      CLK_IS_CRITICAL),
+			      CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTM_SEL, "camtm_sel", camtm_parents,
 			CLK_CFG_7, CLK_CFG_7_SET, CLK_CFG_7_CLR, 8, 2, 15,
 			CLK_CFG_UPDATE, 29),
diff --git a/drivers/clk/mediatek/clk-mt6779.c b/drivers/clk/mediatek/clk-mt6779.c
index 1f5ea1508f61..ada927a61309 100644
--- a/drivers/clk/mediatek/clk-mt6779.c
+++ b/drivers/clk/mediatek/clk-mt6779.c
@@ -640,7 +640,7 @@ static const struct mtk_mux top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "axi_sel", axi_parents,
 				   0x20, 0x24, 0x28, 0, 2, 7,
-				   0x004, 0, CLK_IS_CRITICAL),
+				   0x004, 0, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MM, "mm_sel", mm_parents,
 			     0x20, 0x24, 0x28, 8, 3, 15, 0x004, 1),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCP, "scp_sel", scp_parents,
@@ -710,7 +710,7 @@ static const struct mtk_mux top_muxes[] = {
 			     0x90, 0x94, 0x98, 0, 2, 7, 0x004, 28),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SSPM, "sspm_sel", sspm_parents,
 				   0x90, 0x94, 0x98, 8, 3, 15,
-				   0x004, 29, CLK_IS_CRITICAL),
+				   0x004, 29, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DPI0, "dpi0_sel", dpi0_parents,
 			     0x90, 0x94, 0x98, 16, 3, 23, 0x004, 30),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCAM, "scam_sel", scam_parents,
@@ -727,7 +727,7 @@ static const struct mtk_mux top_muxes[] = {
 			     16, 2, 23, 0x008, 3),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "spm_sel", spm_parents,
 				   0xa0, 0xa4, 0xa8, 24, 2, 31,
-				   0x008, 4, CLK_IS_CRITICAL),
+				   0x008, 4, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/* CLK_CFG_9 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C, "i2c_sel", i2c_parents,
 			     0xb0, 0xb4, 0xb8, 0, 2, 7, 0x008, 5),
diff --git a/drivers/clk/mediatek/clk-mt8183.c b/drivers/clk/mediatek/clk-mt8183.c
index 2336a1b69c09..95786b0c2d5f 100644
--- a/drivers/clk/mediatek/clk-mt8183.c
+++ b/drivers/clk/mediatek/clk-mt8183.c
@@ -451,7 +451,8 @@ static const char * const aud_2_parents[] = {
 static const struct mtk_mux top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_AXI, "axi_sel",
-		axi_parents, 0x40, 0x44, 0x48, 0, 2, 7, 0x004, 0, CLK_IS_CRITICAL),
+		axi_parents, 0x40, 0x44, 0x48, 0, 2, 7, 0x004, 0,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_MM, "mm_sel",
 		mm_parents, 0x40, 0x44, 0x48, 8, 3, 15, 0x004, 1),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_IMG, "img_sel",
@@ -518,7 +519,8 @@ static const struct mtk_mux top_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_SSUSB_TOP_XHCI, "ssusb_top_xhci_sel",
 		ssusb_top_xhci_parents, 0xb0, 0xb4, 0xb8, 16, 2, 23, 0x004, 30),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MUX_SPM, "spm_sel",
-		spm_parents, 0xb0, 0xb4, 0xb8, 24, 1, 31, 0x008, 0, CLK_IS_CRITICAL),
+		spm_parents, 0xb0, 0xb4, 0xb8, 24, 1, 31, 0x008, 0,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/* CLK_CFG_8 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MUX_I2C, "i2c_sel",
 		i2c_parents, 0xc0, 0xc4, 0xc8, 0, 2, 7, 0x008, 1),
diff --git a/drivers/clk/mediatek/clk-mt8186-topckgen.c b/drivers/clk/mediatek/clk-mt8186-topckgen.c
index 1a0340a20beb..669806212073 100644
--- a/drivers/clk/mediatek/clk-mt8186-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8186-topckgen.c
@@ -504,10 +504,10 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "top_axi", axi_parents,
 				   0x0040, 0x0044, 0x0048, 0, 2, 7, 0x0004, 0,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SCP, "top_scp", scp_parents,
 				   0x0040, 0x0044, 0x0048, 8, 3, 15, 0x0004, 1,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MFG, "top_mfg",
 		mfg_parents, 0x0040, 0x0044, 0x0048, 16, 2, 23, 0x0004, 2),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_CAMTG, "top_camtg",
@@ -559,7 +559,7 @@ static const struct mtk_mux top_mtk_muxes[] = {
 		disp_pwm_parents, 0x0090, 0x0094, 0x0098, 8, 3, 15, 0x0004, 21),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SSPM, "top_sspm", sspm_parents,
 				   0x0090, 0x0094, 0x0098, 16, 3, 23, 0x0004, 22,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DXCC, "top_dxcc",
 		dxcc_parents, 0x0090, 0x0094, 0x0098, 24, 2, 31, 0x0004, 23),
 	/*
@@ -570,10 +570,10 @@ static const struct mtk_mux top_mtk_muxes[] = {
 		usb_parents, 0x00a0, 0x00a4, 0x00a8, 0, 2, 7, 0x0004, 24),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SRCK, "top_srck", srck_parents,
 				   0x00a0, 0x00a4, 0x00a8, 8, 2, 15, 0x0004, 25,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "top_spm", spm_parents,
 				   0x00a0, 0x00a4, 0x00a8, 16, 2, 23, 0x0004, 26,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C, "top_i2c",
 		i2c_parents, 0x00a0, 0x00a4, 0x00a8, 24, 2, 31, 0x0004, 27),
 	/* CLK_CFG_7 */
@@ -627,7 +627,7 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DVFSRC, "top_dvfsrc", dvfsrc_parents,
 				   0x0100, 0x0104, 0x0108, 0, 1, 7, 0x0008, 17,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DSI_OCC, "top_dsi_occ",
 		dsi_occ_parents, 0x0100, 0x0104, 0x0108, 8, 2, 15, 0x0008, 18),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_MST, "top_spmi_mst",
diff --git a/drivers/clk/mediatek/clk-mt8188-topckgen.c b/drivers/clk/mediatek/clk-mt8188-topckgen.c
index c56ec42cb15f..7c99244d997e 100644
--- a/drivers/clk/mediatek/clk-mt8188-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8188-topckgen.c
@@ -954,13 +954,17 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	 * spm_sel and scp_sel are main clocks in always-on co-processor.
 	 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "top_axi", axi_parents,
-				   0x020, 0x024, 0x028, 0, 4, 7, 0x04, 0, CLK_IS_CRITICAL),
+				   0x020, 0x024, 0x028, 0, 4, 7, 0x04, 0,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "top_spm", spm_parents,
-				   0x020, 0x024, 0x028, 8, 4, 15, 0x04, 1, CLK_IS_CRITICAL),
+				   0x020, 0x024, 0x028, 8, 4, 15, 0x04, 1,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SCP, "top_scp", scp_parents,
-				   0x020, 0x024, 0x028, 16, 4, 23, 0x04, 2, CLK_IS_CRITICAL),
+				   0x020, 0x024, 0x028, 16, 4, 23, 0x04, 2,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_BUS_AXIMEM, "top_bus_aximem", bus_aximem_parents,
-				   0x020, 0x024, 0x028, 24, 4, 31, 0x04, 3, CLK_IS_CRITICAL),
+				   0x020, 0x024, 0x028, 24, 4, 31, 0x04, 3,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/* CLK_CFG_1 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_VPP, "top_vpp",
 			     vpp_parents, 0x02C, 0x030, 0x034, 0, 4, 7, 0x04, 4),
@@ -1078,7 +1082,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM, "top_pwm",
 			     pwm_parents, 0x0BC, 0x0C0, 0x0C4, 8, 4, 15, 0x08, 21),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MCUPM, "top_mcupm", mcupm_parents,
-				   0x0BC, 0x0C0, 0x0C4, 16, 4, 23, 0x08, 22, CLK_IS_CRITICAL),
+				   0x0BC, 0x0C0, 0x0C4, 16, 4, 23, 0x08, 22,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_P_MST, "top_spmi_p_mst",
 			     spmi_p_mst_parents, 0x0BC, 0x0C0, 0x0C4, 24, 4, 31, 0x08, 23),
 	/*
@@ -1088,7 +1093,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_M_MST, "top_spmi_m_mst",
 			     spmi_m_mst_parents, 0x0C8, 0x0CC, 0x0D0, 0, 4, 7, 0x08, 24),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DVFSRC, "top_dvfsrc", dvfsrc_parents,
-				   0x0C8, 0x0CC, 0x0D0, 8, 4, 15, 0x08, 25, CLK_IS_CRITICAL),
+				   0x0C8, 0x0CC, 0x0D0, 8, 4, 15, 0x08, 25,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_TL, "top_tl",
 			     tl_parents, 0x0C8, 0x0CC, 0x0D0, 16, 4, 23, 0x08, 26),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_AES_MSDCFDE, "top_aes_msdcfde",
@@ -1164,9 +1170,11 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPINOR, "top_spinor",
 			     spinor_parents, 0x0128, 0x012C, 0x0130, 0, 4, 7, 0x0C, 24),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_ULPOSC, "top_ulposc", ulposc_parents,
-				   0x0128, 0x012C, 0x0130, 8, 4, 15, 0x0C, 25, CLK_IS_CRITICAL),
+				   0x0128, 0x012C, 0x0130, 8, 4, 15, 0x0C, 25,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SRCK, "top_srck", srck_parents,
-				   0x0128, 0x012C, 0x0130, 16, 4, 23, 0x0C, 26, CLK_IS_CRITICAL),
+				   0x0128, 0x012C, 0x0130, 16, 4, 23, 0x0C, 26,
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 };
 
 static const struct mtk_composite top_adj_divs[] = {
diff --git a/drivers/clk/mediatek/clk-mt8192.c b/drivers/clk/mediatek/clk-mt8192.c
index aa11291463f7..8a9e6d5f85b4 100644
--- a/drivers/clk/mediatek/clk-mt8192.c
+++ b/drivers/clk/mediatek/clk-mt8192.c
@@ -549,15 +549,15 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, "axi_sel",
 				   axi_parents, 0x010, 0x014, 0x018, 0, 3, 7, 0x004, 0,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, "spm_sel",
 				   spm_parents, 0x010, 0x014, 0x018, 8, 2, 15, 0x004, 1,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SCP_SEL, "scp_sel",
 			     scp_parents, 0x010, 0x014, 0x018, 16, 3, 23, 0x004, 2),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_BUS_AXIMEM_SEL, "bus_aximem_sel",
 				   bus_aximem_parents, 0x010, 0x014, 0x018, 24, 3, 31, 0x004, 3,
-				   CLK_IS_CRITICAL),
+				   CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/* CLK_CFG_1 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DISP_SEL, "disp_sel",
 			     disp_parents, 0x020, 0x024, 0x028, 0, 4, 7, 0x004, 4),
diff --git a/drivers/clk/mediatek/clk-mt8195-topckgen.c b/drivers/clk/mediatek/clk-mt8195-topckgen.c
index 3c2174c3e742..3acbd1c907ab 100644
--- a/drivers/clk/mediatek/clk-mt8195-topckgen.c
+++ b/drivers/clk/mediatek/clk-mt8195-topckgen.c
@@ -862,13 +862,17 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	 * top_spm and top_scp are main clocks in always-on co-processor.
 	 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI, "top_axi",
-		axi_parents, 0x020, 0x024, 0x028, 0, 3, 7, 0x04, 0, CLK_IS_CRITICAL),
+		axi_parents, 0x020, 0x024, 0x028, 0, 3, 7, 0x04, 0,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM, "top_spm",
-		spm_parents, 0x020, 0x024, 0x028, 8, 2, 15, 0x04, 1, CLK_IS_CRITICAL),
+		spm_parents, 0x020, 0x024, 0x028, 8, 2, 15, 0x04, 1,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SCP, "top_scp",
-		scp_parents, 0x020, 0x024, 0x028, 16, 3, 23, 0x04, 2, CLK_IS_CRITICAL),
+		scp_parents, 0x020, 0x024, 0x028, 16, 3, 23, 0x04, 2,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_BUS_AXIMEM, "top_bus_aximem",
-		bus_aximem_parents, 0x020, 0x024, 0x028, 24, 3, 31, 0x04, 3, CLK_IS_CRITICAL),
+		bus_aximem_parents, 0x020, 0x024, 0x028, 24, 3, 31, 0x04, 3,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/* CLK_CFG_1 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_VPP, "top_vpp",
 		vpp_parents, 0x02C, 0x030, 0x034, 0, 4, 7, 0x04, 4),
@@ -951,7 +955,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_ATB, "top_atb",
 		atb_parents, 0x08C, 0x090, 0x094, 8, 2, 15, 0x08, 5),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_PWRMCU, "top_pwrmcu",
-		pwrmcu_parents, 0x08C, 0x090, 0x094, 16, 3, 23, 0x08, 6, CLK_IS_CRITICAL),
+		pwrmcu_parents, 0x08C, 0x090, 0x094, 16, 3, 23, 0x08, 6,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DP, "top_dp",
 		dp_parents, 0x08C, 0x090, 0x094, 24, 4, 31, 0x08, 7),
 	/* CLK_CFG_10 */
@@ -1020,7 +1025,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_PWM, "top_pwm",
 		pwm_parents, 0x0E0, 0x0E4, 0x0E8, 16, 1, 23, 0x0C, 2),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_MCUPM, "top_mcupm",
-		mcupm_parents, 0x0E0, 0x0E4, 0x0E8, 24, 2, 31, 0x0C, 3, CLK_IS_CRITICAL),
+		mcupm_parents, 0x0E0, 0x0E4, 0x0E8, 24, 2, 31, 0x0C, 3,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/*
 	 * CLK_CFG_17
 	 * top_dvfsrc is for internal DVFS usage, should not be handled by Linux.
@@ -1030,7 +1036,8 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SPMI_M_MST, "top_spmi_m_mst",
 		spmi_parents, 0x0EC, 0x0F0, 0x0F4, 8, 4, 15, 0x0C, 5),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DVFSRC, "top_dvfsrc",
-		dvfsrc_parents, 0x0EC, 0x0F0, 0x0F4, 16, 2, 23, 0x0C, 6, CLK_IS_CRITICAL),
+		dvfsrc_parents, 0x0EC, 0x0F0, 0x0F4, 16, 2, 23, 0x0C, 6,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_TL, "top_tl",
 		tl_parents, 0x0EC, 0x0F0, 0x0F4, 24, 2, 31, 0x0C, 7),
 	/* CLK_CFG_18 */
@@ -1141,11 +1148,14 @@ static const struct mtk_mux top_mtk_muxes[] = {
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_DVIO_DGI_REF, "top_dvio_dgi_ref",
 		dvio_dgi_ref_parents, 0x017C, 0x0180, 0x0184, 0, 3, 7, 0x010, 20),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_ULPOSC, "top_ulposc",
-		ulposc_parents, 0x017C, 0x0180, 0x0184, 8, 2, 15, 0x010, 21, CLK_IS_CRITICAL),
+		ulposc_parents, 0x017C, 0x0180, 0x0184, 8, 2, 15, 0x010, 21,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_ULPOSC_CORE, "top_ulposc_core",
-		ulposc_core_parents, 0x017C, 0x0180, 0x0184, 16, 2, 23, 0x010, 22, CLK_IS_CRITICAL),
+		ulposc_core_parents, 0x017C, 0x0180, 0x0184, 16, 2, 23, 0x010, 22,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SRCK, "top_srck",
-		srck_parents, 0x017C, 0x0180, 0x0184, 24, 1, 31, 0x010, 23, CLK_IS_CRITICAL),
+		srck_parents, 0x017C, 0x0180, 0x0184, 24, 1, 31, 0x010, 23,
+		CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/*
 	 * the clocks in CLK_CFG_30 ~ 37 are backup clock source, no need to handled
 	 * by Linux.
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
index 6b4e193f648d..28f94e015252 100644
--- a/drivers/clk/mediatek/clk-mt8365.c
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -410,7 +410,7 @@ static const struct mtk_mux top_muxes[] = {
 	/* CLK_CFG_0 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
 				   0x040, 0x044, 0x048, 0, 2, 7, CLK_CFG_UPDATE,
-				   0, CLK_IS_CRITICAL),
+				   0, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MEM_SEL, "mem_sel", mem_parents, 0x040,
 			     0x044, 0x048, 8, 2, 15, CLK_CFG_UPDATE, 1),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_MM_SEL, "mm_sel", mm_parents, 0x040, 0x044,
@@ -475,7 +475,7 @@ static const struct mtk_mux top_muxes[] = {
 	/* CLK_CFG_6 */
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DXCC_SEL, "dxcc_sel", dxcc_parents,
 				   0x0a0, 0x0a4, 0x0a8, 0, 2, 7, CLK_CFG_UPDATE,
-				   24, CLK_IS_CRITICAL),
+				   24, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_SSUSB_SYS_SEL, "ssusb_sys_sel",
 			     ssusb_sys_parents, 0x0a0, 0x0a4, 0x0a8, 8, 2, 15,
 			     CLK_CFG_UPDATE, 25),
@@ -483,8 +483,8 @@ static const struct mtk_mux top_muxes[] = {
 			     ssusb_sys_parents, 0x0a0, 0x0a4, 0x0a8, 16, 2, 23,
 			     CLK_CFG_UPDATE, 26),
 	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, "spm_sel", spm_parents,
-				   0x0a0, 0x0a4, 0x0a8, 24, 1, 31,
-				   CLK_CFG_UPDATE, 27, CLK_IS_CRITICAL),
+				   0x0a0, 0x0a4, 0x0a8, 24, 1, 31, CLK_CFG_UPDATE,
+				   27, CLK_IS_CRITICAL | CLK_SET_RATE_PARENT),
 	/* CLK_CFG_7 */
 	MUX_GATE_CLR_SET_UPD(CLK_TOP_I2C_SEL, "i2c_sel", i2c_parents, 0x0b0,
 			     0x0b4, 0x0b8, 0, 3, 7, CLK_CFG_UPDATE, 28),
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index c8593554239d..c93bc7f926e5 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -168,7 +168,7 @@ static struct clk_hw *mtk_clk_register_mux(struct device *dev,
 		return ERR_PTR(-ENOMEM);
 
 	init.name = mux->name;
-	init.flags = mux->flags | CLK_SET_RATE_PARENT;
+	init.flags = mux->flags;
 	init.parent_names = mux->parent_names;
 	init.num_parents = mux->num_parents;
 	init.ops = mux->ops;
-- 
2.40.1

