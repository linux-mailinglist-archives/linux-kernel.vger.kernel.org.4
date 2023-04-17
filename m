Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96546E4FCF
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbjDQSEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 14:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjDQSEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 14:04:06 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143065269
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 11:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1681754639; x=1713290639;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KoHza1vejrzAkyGsjA2yudMh/oMxUYOS4fEMrrvFgz8=;
  b=lWnfQRkjgkn/cxKHQStTXy5UiohWfe5I/gzcwWh9eWqiMdw3MsckHVV1
   sxXg84y29Ym4be4Zj5DF8neTpGsYsDuzxii6WTjaCN5S6fdvZQXZAV1+o
   OEju2eLJ7GJU0vrBiflMWfIKkd4OaOCDBee2GInnec4Oq5/cgWXdElZF8
   O9FGqiPGAGaS4JVljVwU/dXpm8sEeRR/uJlV1aHBJLJky8qChetJmAg15
   tGheW+1KfFuU5WI348wn2B4QOHHc74g69lXVUb9Qg6Su+VbE1Wvb5U6SP
   C8UVuj/VR0CLXiX78AbCtdReF/L97hIHpjRM6KIrRE0Jw/k/bAVxSKRph
   A==;
X-IronPort-AV: E=Sophos;i="5.99,204,1677567600"; 
   d="scan'208";a="147469774"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Apr 2023 11:03:57 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 17 Apr 2023 11:03:50 -0700
Received: from DEN-LT-70577.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Mon, 17 Apr 2023 11:03:48 -0700
From:   Daniel Machon <daniel.machon@microchip.com>
To:     <vkoul@kernel.org>
CC:     <kishon@kernel.org>, <Steen.Hegelund@microchip.com>,
        <daniel.machon@microchip.com>, <UNGLinuxDriver@microchip.com>,
        <joe@perches.com>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/7] phy: sparx5-serdes: power down all CMUs by default
Date:   Mon, 17 Apr 2023 20:03:32 +0200
Message-ID: <20230417180335.2787494-5-daniel.machon@microchip.com>
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

All CMUs are powered up initially. This uses needless power. This patch
makes sure all CMUs are powered down by default. This involves
configuring a number reference clock and power-down registers of the
CMU.

Individual CMUs are later powered up, when the serdes lanes are
configured.

Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
---
 drivers/phy/microchip/sparx5_serdes.c | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/phy/microchip/sparx5_serdes.c b/drivers/phy/microchip/sparx5_serdes.c
index d8620e0fae7b..0e9db7b36b60 100644
--- a/drivers/phy/microchip/sparx5_serdes.c
+++ b/drivers/phy/microchip/sparx5_serdes.c
@@ -1078,6 +1078,54 @@ static int sparx5_serdes_cmu_enable(struct sparx5_serdes_private *priv)
 	return err;
 }
 
+static void sparx5_serdes_cmu_power_off(struct sparx5_serdes_private *priv)
+{
+	void __iomem *cmu_inst, *cmu_cfg_inst;
+	int i;
+
+	/* Power down each CMU */
+	for (i = 0; i < SPX5_CMU_MAX; i++) {
+		cmu_inst = sdx5_inst_get(priv, TARGET_SD_CMU, i);
+		cmu_cfg_inst = sdx5_inst_get(priv, TARGET_SD_CMU_CFG, i);
+
+		sdx5_inst_rmw(SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST_SET(0),
+			      SD_CMU_CFG_SD_CMU_CFG_EXT_CFG_RST, cmu_cfg_inst,
+			      SD_CMU_CFG_SD_CMU_CFG(0));
+
+		sdx5_inst_rmw(SD_CMU_CMU_05_CFG_REFCK_TERM_EN_SET(0),
+			      SD_CMU_CMU_05_CFG_REFCK_TERM_EN, cmu_inst,
+			      SD_CMU_CMU_05(0));
+
+		sdx5_inst_rmw(SD_CMU_CMU_09_CFG_EN_TX_CK_DN_SET(0),
+			      SD_CMU_CMU_09_CFG_EN_TX_CK_DN, cmu_inst,
+			      SD_CMU_CMU_09(0));
+
+		sdx5_inst_rmw(SD_CMU_CMU_06_CFG_VCO_PD_SET(1),
+			      SD_CMU_CMU_06_CFG_VCO_PD, cmu_inst,
+			      SD_CMU_CMU_06(0));
+
+		sdx5_inst_rmw(SD_CMU_CMU_09_CFG_EN_TX_CK_UP_SET(0),
+			      SD_CMU_CMU_09_CFG_EN_TX_CK_UP, cmu_inst,
+			      SD_CMU_CMU_09(0));
+
+		sdx5_inst_rmw(SD_CMU_CMU_08_CFG_CK_TREE_PD_SET(1),
+			      SD_CMU_CMU_08_CFG_CK_TREE_PD, cmu_inst,
+			      SD_CMU_CMU_08(0));
+
+		sdx5_inst_rmw(SD_CMU_CMU_0D_CFG_REFCK_PD_SET(1) |
+			      SD_CMU_CMU_0D_CFG_PD_DIV64_SET(1) |
+			      SD_CMU_CMU_0D_CFG_PD_DIV66_SET(1),
+			      SD_CMU_CMU_0D_CFG_REFCK_PD |
+			      SD_CMU_CMU_0D_CFG_PD_DIV64 |
+			      SD_CMU_CMU_0D_CFG_PD_DIV66, cmu_inst,
+			      SD_CMU_CMU_0D(0));
+
+		sdx5_inst_rmw(SD_CMU_CMU_06_CFG_CTRL_LOGIC_PD_SET(1),
+			      SD_CMU_CMU_06_CFG_CTRL_LOGIC_PD, cmu_inst,
+			      SD_CMU_CMU_06(0));
+	}
+}
+
 static void sparx5_sd25g28_reset(void __iomem *regs[],
 				 struct sparx5_sd25g28_params *params,
 				 u32 sd_index)
@@ -2521,6 +2569,9 @@ static int sparx5_serdes_probe(struct platform_device *pdev)
 			return err;
 	}
 
+	/* Power down all CMUs by default */
+	sparx5_serdes_cmu_power_off(priv);
+
 	provider = devm_of_phy_provider_register(priv->dev, sparx5_serdes_xlate);
 
 	return PTR_ERR_OR_ZERO(provider);
-- 
2.34.1

