Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0717B6E4FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjDQSEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjDQSEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:04:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DDD28692
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681754638; x=1713290638;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3uLKkGcs/8EltrBSlra1gjG4qIRlejr3L2TWbWqYgXw=;
  b=yAXVk3YW0lXImILOqG3yT8JxwQ/0VrHSP2nC63cIYkOMHRTcHdYWQ/U1
   5TlNkAlq2yv30Yuqz+xTKnPwC4BDxyu2E3nA2hIL6xWvYA6XCZyA/y9lu
   0+S1Z0kl7dFBr8WJ3zb3QAn1fZxX6J5zDmQFglarW0xetfYUeHB41UpqQ
   Hcog6/adrpJ5Xg32MNQcKmNgjLkh1GOFyV5XEb6mVofo1GHl6xXkx2Iaf
   f8JBRQmXBIO3EIQM5wne8ynsHtr3F+bn3NlCjF3wRiLIvu1LKQZziFFDn
   dg0xo9jZZAOGC0PAuR+X/b9XQtcrF45dudmI1ouvQMcnUnE0vWCJJvw59
   Q==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="147469770"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:03:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:03:48 -0700
Received: from DEN-LT-70577.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Apr 2023 11:03:46 -0700
From:   Daniel Machon <daniel.machon@microchip.com>
To:     <vkoul@kernel.org>
CC:     <kishon@kernel.org>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <joe@perches.com>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/7] phy: sparx5-serdes: reorder CMU functions
Date:   Mon, 17 Apr 2023 20:03:31 +0200
Message-ID: <20230417180335.2787494-4-daniel.machon@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230417180335.2787494-1-daniel.machon@microchip.com>
References: <20230417180335.2787494-1-daniel.machon@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder CMU functions, as some of them are now required by the serdes
functions. No functional changes.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 306 +++++++++++++-------------
 1 file changed, 153 insertions(+), 153 deletions(-)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index 6ba058b2482f..d8620e0fae7b 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -925,6 +925,159 @@ static void sparx5_sd10g28_get_params(struct sparx5_serdes_macro *macro,
 	*params = init;
 }
 
+static int sparx5_cmu_apply_cfg(struct sparx5_serdes_private *priv,
+				u32 cmu_idx,
+				void __iomem *cmu_tgt,
+				void __iomem *cmu_cfg_tgt,
+				u32 spd10g)
+{
+	void __iomem **regs = priv->regs;
+	struct device *dev = priv->dev;
+	int value;
+
+	cmu_tgt = sdx5_inst_get(priv, TARGET_SD_CMU, cmu_idx);
+	cmu_cfg_tgt = sdx5_inst_get(priv, TARGET_SD_CMU_CFG, cmu_idx);
+
+	if (cmu_idx == 1 || cmu_idx == 4 || cmu_idx == 7 ||
+	    cmu_idx == 10 || cmu_idx == 13) {
+		spd10g = 0;
+	}
+
+	sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST_SET(1),
+		      SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST,
+		      cmu_cfg_tgt,
+		      SD_CMU_CFG_SD_CMU_CFG(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST_SET(0),
+		      SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST,
+		      cmu_cfg_tgt,
+		      SD_CMU_CFG_SD_CMU_CFG(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_CMU_RST_SET(1),
+		      SD_CMU_CFG_SD_CMU_CFG_CMU_RST,
+		      cmu_cfg_tgt,
+		      SD_CMU_CFG_SD_CMU_CFG(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_45_R_DWIDTHCTRL_FROM_HWT_SET(0x1) |
+		      SD_CMU_CMU_45_R_REFCK_SSC_EN_FROM_HWT_SET(0x1) |
+		      SD_CMU_CMU_45_R_LINK_BUF_EN_FROM_HWT_SET(0x1) |
+		      SD_CMU_CMU_45_R_BIAS_EN_FROM_HWT_SET(0x1) |
+		      SD_CMU_CMU_45_R_EN_RATECHG_CTRL_SET(0x0),
+		      SD_CMU_CMU_45_R_DWIDTHCTRL_FROM_HWT |
+		      SD_CMU_CMU_45_R_REFCK_SSC_EN_FROM_HWT |
+		      SD_CMU_CMU_45_R_LINK_BUF_EN_FROM_HWT |
+		      SD_CMU_CMU_45_R_BIAS_EN_FROM_HWT |
+		      SD_CMU_CMU_45_R_EN_RATECHG_CTRL,
+		      cmu_tgt,
+		      SD_CMU_CMU_45(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_47_R_PCS2PMA_PHYMODE_4_0_SET(0),
+		      SD_CMU_CMU_47_R_PCS2PMA_PHYMODE_4_0,
+		      cmu_tgt,
+		      SD_CMU_CMU_47(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_1B_CFG_RESERVE_7_0_SET(0),
+		      SD_CMU_CMU_1B_CFG_RESERVE_7_0,
+		      cmu_tgt,
+		      SD_CMU_CMU_1B(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_0D_CFG_JC_BYP_SET(0x1),
+		      SD_CMU_CMU_0D_CFG_JC_BYP,
+		      cmu_tgt,
+		      SD_CMU_CMU_0D(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_1F_CFG_VTUNE_SEL_SET(1),
+		      SD_CMU_CMU_1F_CFG_VTUNE_SEL,
+		      cmu_tgt,
+		      SD_CMU_CMU_1F(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_00_CFG_PLL_TP_SEL_1_0_SET(3),
+		      SD_CMU_CMU_00_CFG_PLL_TP_SEL_1_0,
+		      cmu_tgt,
+		      SD_CMU_CMU_00(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_05_CFG_BIAS_TP_SEL_1_0_SET(3),
+		      SD_CMU_CMU_05_CFG_BIAS_TP_SEL_1_0,
+		      cmu_tgt,
+		      SD_CMU_CMU_05(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_30_R_PLL_DLOL_EN_SET(1),
+		      SD_CMU_CMU_30_R_PLL_DLOL_EN,
+		      cmu_tgt,
+		      SD_CMU_CMU_30(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_09_CFG_SW_10G_SET(spd10g),
+		      SD_CMU_CMU_09_CFG_SW_10G,
+		      cmu_tgt,
+		      SD_CMU_CMU_09(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_CMU_RST_SET(0),
+		      SD_CMU_CFG_SD_CMU_CFG_CMU_RST,
+		      cmu_cfg_tgt,
+		      SD_CMU_CFG_SD_CMU_CFG(cmu_idx));
+
+	msleep(20);
+
+	sdx5_inst_rmw(SD_CMU_CMU_44_R_PLL_RSTN_SET(0),
+		      SD_CMU_CMU_44_R_PLL_RSTN,
+		      cmu_tgt,
+		      SD_CMU_CMU_44(cmu_idx));
+
+	sdx5_inst_rmw(SD_CMU_CMU_44_R_PLL_RSTN_SET(1),
+		      SD_CMU_CMU_44_R_PLL_RSTN,
+		      cmu_tgt,
+		      SD_CMU_CMU_44(cmu_idx));
+
+	msleep(20);
+
+	value = readl(sdx5_addr(regs, SD_CMU_CMU_E0(cmu_idx)));
+	value = SD_CMU_CMU_E0_PLL_LOL_UDL_GET(value);
+
+	if (value) {
+		dev_err(dev, "CMU PLL Loss of Lock: 0x%x\n", value);
+		return -EINVAL;
+	}
+	sdx5_inst_rmw(SD_CMU_CMU_0D_CFG_PMA_TX_CK_PD_SET(0),
+		      SD_CMU_CMU_0D_CFG_PMA_TX_CK_PD,
+		      cmu_tgt,
+		      SD_CMU_CMU_0D(cmu_idx));
+	return 0;
+}
+
+static int sparx5_cmu_cfg(struct sparx5_serdes_private *priv, u32 cmu_idx)
+{
+	void __iomem *cmu_tgt, *cmu_cfg_tgt;
+	u32 spd10g = 1;
+
+	if (cmu_idx == 1 || cmu_idx == 4 || cmu_idx == 7 ||
+	    cmu_idx == 10 || cmu_idx == 13) {
+		spd10g = 0;
+	}
+
+	cmu_tgt = sdx5_inst_get(priv, TARGET_SD_CMU, cmu_idx);
+	cmu_cfg_tgt = sdx5_inst_get(priv, TARGET_SD_CMU_CFG, cmu_idx);
+
+	return sparx5_cmu_apply_cfg(priv, cmu_idx, cmu_tgt, cmu_cfg_tgt, spd10g);
+}
+
+static int sparx5_serdes_cmu_enable(struct sparx5_serdes_private *priv)
+{
+	int idx, err = 0;
+
+	if (!priv->cmu_enabled) {
+		for (idx = 0; idx < SPX5_CMU_MAX; idx++) {
+			err  = sparx5_cmu_cfg(priv, idx);
+			if (err) {
+				dev_err(priv->dev, "CMU %u, error: %d\n", idx, err);
+				goto leave;
+			}
+		}
+		priv->cmu_enabled = true;
+	}
+leave:
+	return err;
+}
+
 static void sparx5_sd25g28_reset(void __iomem *regs[],
 				 struct sparx5_sd25g28_params *params,
 				 u32 sd_index)
@@ -1966,159 +2119,6 @@ static int sparx5_serdes_clock_config(struct sparx5_serdes_macro *macro)
 	return 0;
 }
 
-static int sparx5_cmu_apply_cfg(struct sparx5_serdes_private *priv,
-				u32 cmu_idx,
-				void __iomem *cmu_tgt,
-				void __iomem *cmu_cfg_tgt,
-				u32 spd10g)
-{
-	void __iomem **regs = priv->regs;
-	struct device *dev = priv->dev;
-	int value;
-
-	cmu_tgt = sdx5_inst_get(priv, TARGET_SD_CMU, cmu_idx);
-	cmu_cfg_tgt = sdx5_inst_get(priv, TARGET_SD_CMU_CFG, cmu_idx);
-
-	if (cmu_idx == 1 || cmu_idx == 4 || cmu_idx == 7 ||
-	    cmu_idx == 10 || cmu_idx == 13) {
-		spd10g = 0;
-	}
-
-	sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST_SET(1),
-		      SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST,
-		      cmu_cfg_tgt,
-		      SD_CMU_CFG_SD_CMU_CFG(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST_SET(0),
-		      SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST,
-		      cmu_cfg_tgt,
-		      SD_CMU_CFG_SD_CMU_CFG(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_CMU_RST_SET(1),
-		      SD_CMU_CFG_SD_CMU_CFG_CMU_RST,
-		      cmu_cfg_tgt,
-		      SD_CMU_CFG_SD_CMU_CFG(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_45_R_DWIDTHCTRL_FROM_HWT_SET(0x1) |
-		      SD_CMU_CMU_45_R_REFCK_SSC_EN_FROM_HWT_SET(0x1) |
-		      SD_CMU_CMU_45_R_LINK_BUF_EN_FROM_HWT_SET(0x1) |
-		      SD_CMU_CMU_45_R_BIAS_EN_FROM_HWT_SET(0x1) |
-		      SD_CMU_CMU_45_R_EN_RATECHG_CTRL_SET(0x0),
-		      SD_CMU_CMU_45_R_DWIDTHCTRL_FROM_HWT |
-		      SD_CMU_CMU_45_R_REFCK_SSC_EN_FROM_HWT |
-		      SD_CMU_CMU_45_R_LINK_BUF_EN_FROM_HWT |
-		      SD_CMU_CMU_45_R_BIAS_EN_FROM_HWT |
-		      SD_CMU_CMU_45_R_EN_RATECHG_CTRL,
-		      cmu_tgt,
-		      SD_CMU_CMU_45(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_47_R_PCS2PMA_PHYMODE_4_0_SET(0),
-		      SD_CMU_CMU_47_R_PCS2PMA_PHYMODE_4_0,
-		      cmu_tgt,
-		      SD_CMU_CMU_47(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_1B_CFG_RESERVE_7_0_SET(0),
-		      SD_CMU_CMU_1B_CFG_RESERVE_7_0,
-		      cmu_tgt,
-		      SD_CMU_CMU_1B(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_0D_CFG_JC_BYP_SET(0x1),
-		      SD_CMU_CMU_0D_CFG_JC_BYP,
-		      cmu_tgt,
-		      SD_CMU_CMU_0D(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_1F_CFG_VTUNE_SEL_SET(1),
-		      SD_CMU_CMU_1F_CFG_VTUNE_SEL,
-		      cmu_tgt,
-		      SD_CMU_CMU_1F(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_00_CFG_PLL_TP_SEL_1_0_SET(3),
-		      SD_CMU_CMU_00_CFG_PLL_TP_SEL_1_0,
-		      cmu_tgt,
-		      SD_CMU_CMU_00(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_05_CFG_BIAS_TP_SEL_1_0_SET(3),
-		      SD_CMU_CMU_05_CFG_BIAS_TP_SEL_1_0,
-		      cmu_tgt,
-		      SD_CMU_CMU_05(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_30_R_PLL_DLOL_EN_SET(1),
-		      SD_CMU_CMU_30_R_PLL_DLOL_EN,
-		      cmu_tgt,
-		      SD_CMU_CMU_30(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_09_CFG_SW_10G_SET(spd10g),
-		      SD_CMU_CMU_09_CFG_SW_10G,
-		      cmu_tgt,
-		      SD_CMU_CMU_09(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_CMU_RST_SET(0),
-		      SD_CMU_CFG_SD_CMU_CFG_CMU_RST,
-		      cmu_cfg_tgt,
-		      SD_CMU_CFG_SD_CMU_CFG(cmu_idx));
-
-	msleep(20);
-
-	sdx5_inst_rmw(SD_CMU_CMU_44_R_PLL_RSTN_SET(0),
-		      SD_CMU_CMU_44_R_PLL_RSTN,
-		      cmu_tgt,
-		      SD_CMU_CMU_44(cmu_idx));
-
-	sdx5_inst_rmw(SD_CMU_CMU_44_R_PLL_RSTN_SET(1),
-		      SD_CMU_CMU_44_R_PLL_RSTN,
-		      cmu_tgt,
-		      SD_CMU_CMU_44(cmu_idx));
-
-	msleep(20);
-
-	value = readl(sdx5_addr(regs, SD_CMU_CMU_E0(cmu_idx)));
-	value = SD_CMU_CMU_E0_PLL_LOL_UDL_GET(value);
-
-	if (value) {
-		dev_err(dev, "CMU PLL Loss of Lock: 0x%x\n", value);
-		return -EINVAL;
-	}
-	sdx5_inst_rmw(SD_CMU_CMU_0D_CFG_PMA_TX_CK_PD_SET(0),
-		      SD_CMU_CMU_0D_CFG_PMA_TX_CK_PD,
-		      cmu_tgt,
-		      SD_CMU_CMU_0D(cmu_idx));
-	return 0;
-}
-
-static int sparx5_cmu_cfg(struct sparx5_serdes_private *priv, u32 cmu_idx)
-{
-	void __iomem *cmu_tgt, *cmu_cfg_tgt;
-	u32 spd10g = 1;
-
-	if (cmu_idx == 1 || cmu_idx == 4 || cmu_idx == 7 ||
-	    cmu_idx == 10 || cmu_idx == 13) {
-		spd10g = 0;
-	}
-
-	cmu_tgt = sdx5_inst_get(priv, TARGET_SD_CMU, cmu_idx);
-	cmu_cfg_tgt = sdx5_inst_get(priv, TARGET_SD_CMU_CFG, cmu_idx);
-
-	return sparx5_cmu_apply_cfg(priv, cmu_idx, cmu_tgt, cmu_cfg_tgt, spd10g);
-}
-
-static int sparx5_serdes_cmu_enable(struct sparx5_serdes_private *priv)
-{
-	int idx, err = 0;
-
-	if (!priv->cmu_enabled) {
-		for (idx = 0; idx < SPX5_CMU_MAX; idx++) {
-			err  = sparx5_cmu_cfg(priv, idx);
-			if (err) {
-				dev_err(priv->dev, "CMU %u, error: %d\n", idx, err);
-				goto leave;
-			}
-		}
-		priv->cmu_enabled = true;
-	}
-leave:
-	return err;
-}
-
 static int sparx5_serdes_get_serdesmode(phy_interface_t portmode, int speed)
 {
 	switch (portmode) {
-- 
2.34.1

