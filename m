Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2694E6107BB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 04:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235845AbiJ1COe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 22:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235747AbiJ1CO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 22:14:28 -0400
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A5713E2F;
        Thu, 27 Oct 2022 19:14:25 -0700 (PDT)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 025251A0AB4;
        Fri, 28 Oct 2022 04:14:24 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BAC4B1A0A58;
        Fri, 28 Oct 2022 04:14:23 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id E4FFA180222C;
        Fri, 28 Oct 2022 10:14:21 +0800 (+08)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     shengjiu.wang@gmail.com, abelvesa@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, marex@denx.de
Subject: [PATCH v3 2/3] clk: imx8mp: Add audio shared gate
Date:   Fri, 28 Oct 2022 09:53:44 +0800
Message-Id: <1666922026-6943-3-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1666922026-6943-1-git-send-email-shengjiu.wang@nxp.com>
References: <1666922026-6943-1-git-send-email-shengjiu.wang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

According to the RM, the CCGR101 is shared for the following root clocks:
- AUDIO_AHB_CLK_ROOT
- AUDIO_AXI_CLK_ROOT
- SAI1_CLK_ROOT
- SAI2_CLK_ROOT
- SAI3_CLK_ROOT
- SAI5_CLK_ROOT
- SAI6_CLK_ROOT
- SAI7_CLK_ROOT
- PDM_CLK_ROOT

And correct clock MX8MP_CLK_AUDIO_ROOT to be IMX8MP_CLK_AUDIO_AHB_ROOT.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
Reviewed-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index 652ae58c2735..0ae3bc7bf8a1 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -17,6 +17,7 @@
 
 static u32 share_count_nand;
 static u32 share_count_media;
+static u32 share_count_audio;
 
 static const char * const pll_ref_sels[] = { "osc_24m", "dummy", "dummy", "dummy", };
 static const char * const audio_pll1_bypass_sels[] = {"audio_pll1", "audio_pll1_ref_sel", };
@@ -699,7 +700,15 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_HDMI_ROOT] = imx_clk_hw_gate4("hdmi_root_clk", "hdmi_axi", ccm_base + 0x45f0, 0);
 	hws[IMX8MP_CLK_TSENSOR_ROOT] = imx_clk_hw_gate4("tsensor_root_clk", "ipg_root", ccm_base + 0x4620, 0);
 	hws[IMX8MP_CLK_VPU_ROOT] = imx_clk_hw_gate4("vpu_root_clk", "vpu_bus", ccm_base + 0x4630, 0);
-	hws[IMX8MP_CLK_AUDIO_ROOT] = imx_clk_hw_gate4("audio_root_clk", "audio_ahb", ccm_base + 0x4650, 0);
+	hws[IMX8MP_CLK_AUDIO_AHB_ROOT] = imx_clk_hw_gate2_shared2("audio_ahb_root", "audio_ahb", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_AUDIO_AXI_ROOT] = imx_clk_hw_gate2_shared2("audio_axi_root", "audio_axi", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI1_ROOT] = imx_clk_hw_gate2_shared2("sai1_root", "sai1", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI2_ROOT] = imx_clk_hw_gate2_shared2("sai2_root", "sai2", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI3_ROOT] = imx_clk_hw_gate2_shared2("sai3_root", "sai3", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI5_ROOT] = imx_clk_hw_gate2_shared2("sai5_root", "sai5", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI6_ROOT] = imx_clk_hw_gate2_shared2("sai6_root", "sai6", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_SAI7_ROOT] = imx_clk_hw_gate2_shared2("sai7_root", "sai7", ccm_base + 0x4650, 0, &share_count_audio);
+	hws[IMX8MP_CLK_PDM_ROOT] = imx_clk_hw_gate2_shared2("pdm_root", "pdm", ccm_base + 0x4650, 0, &share_count_audio);
 
 	hws[IMX8MP_CLK_ARM] = imx_clk_hw_cpu("arm", "arm_a53_core",
 					     hws[IMX8MP_CLK_A53_CORE]->clk,
-- 
2.34.1

