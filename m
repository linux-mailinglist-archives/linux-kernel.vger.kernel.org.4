Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DC56D7B1D
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237894AbjDELVq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237871AbjDELVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:21:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C876C2D4B
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 04:21:40 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Ce-0004S2-00; Wed, 05 Apr 2023 13:21:24 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Cc-0098SJ-2v; Wed, 05 Apr 2023 13:21:22 +0200
Received: from jzi by dude03.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <jzi@pengutronix.de>)
        id 1pk1Cb-005Gtt-BZ; Wed, 05 Apr 2023 13:21:21 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
To:     vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jun.li@nxp.com,
        haibo.chen@nxp.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     j.zink@pengutronix.de
Subject: [PATCH 2/2] phy: fsl-imx8mp-usb: add support for phy tuning
Date:   Wed,  5 Apr 2023 13:21:18 +0200
Message-Id: <20230405112118.1256151-3-j.zink@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405112118.1256151-1-j.zink@pengutronix.de>
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: jzi@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Jun <jun.li@nxp.com>

Add USB PHY parameter tuning for USB certifications.

Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Li Jun <jun.li@nxp.com>
[j.zink: ported to v6.3-rc1 from NXP downstream repo + cleanups]
Signed-off-by: Johannes Zink <j.zink@pengutronix.de>
---
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c | 124 +++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
index a29b4a6f7c24..ee1975aaab7e 100644
--- a/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
+++ b/drivers/phy/freescale/phy-fsl-imx8mq-usb.c
@@ -27,17 +27,137 @@
 #define PHY_CTRL2_TXENABLEN0		BIT(8)
 #define PHY_CTRL2_OTG_DISABLE		BIT(9)
 
+#define PHY_CTRL3			0xc
+#define PHY_CTRL3_COMPDISTUNE_MASK	GENMASK(2, 0)
+#define PHY_CTRL3_TXPREEMP_TUNE_MASK	GENMASK(16, 15)
+#define PHY_CTRL3_TXRISE_TUNE_MASK	GENMASK(21, 20)
+#define PHY_CTRL3_TXVREF_TUNE_MASK	GENMASK(25, 22)
+#define PHY_CTRL3_TX_VBOOST_LEVEL_MASK	GENMASK(31, 29)
+
+#define PHY_CTRL4			0x10
+#define PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK	GENMASK(20, 15)
+
+#define PHY_CTRL5			0x14
+#define PHY_CTRL5_DMPWD_OVERRIDE_SEL	BIT(23)
+#define PHY_CTRL5_DMPWD_OVERRIDE	BIT(22)
+#define PHY_CTRL5_DPPWD_OVERRIDE_SEL	BIT(21)
+#define PHY_CTRL5_DPPWD_OVERRIDE	BIT(20)
+#define PHY_CTRL5_PCS_TX_SWING_FULL_MASK	GENMASK(6, 0)
+
 #define PHY_CTRL6			0x18
 #define PHY_CTRL6_ALT_CLK_EN		BIT(1)
 #define PHY_CTRL6_ALT_CLK_SEL		BIT(0)
 
+#define PHY_TUNE_DEFAULT		0xffffffff
+
 struct imx8mq_usb_phy {
 	struct phy *phy;
 	struct clk *clk;
 	void __iomem *base;
 	struct regulator *vbus;
+	u32 pcs_tx_swing_full;
+	u32 pcs_tx_deemph_3p5db;
+	u32 tx_vref_tune;
+	u32 tx_rise_tune;
+	u32 tx_preemp_amp_tune;
+	u32 tx_vboost_level;
+	u32 comp_dis_tune;
 };
 
+static void imx8m_get_phy_tuning_data(struct imx8mq_usb_phy *imx_phy)
+{
+	struct device *dev = imx_phy->phy->dev.parent;
+
+	if (device_property_read_u32(dev, "fsl,phy-tx-vref-tune",
+				     &imx_phy->tx_vref_tune))
+		imx_phy->tx_vref_tune = PHY_TUNE_DEFAULT;
+
+	if (device_property_read_u32(dev, "fsl,phy-tx-rise-tune",
+				     &imx_phy->tx_rise_tune))
+		imx_phy->tx_rise_tune = PHY_TUNE_DEFAULT;
+
+	if (device_property_read_u32(dev, "fsl,phy-tx-preemp-amp-tune",
+				     &imx_phy->tx_preemp_amp_tune))
+		imx_phy->tx_preemp_amp_tune = PHY_TUNE_DEFAULT;
+
+	if (device_property_read_u32(dev, "fsl,phy-tx-vboost-level",
+				     &imx_phy->tx_vboost_level))
+		imx_phy->tx_vboost_level = PHY_TUNE_DEFAULT;
+
+	if (device_property_read_u32(dev, "fsl,phy-comp-dis-tune",
+				     &imx_phy->comp_dis_tune))
+		imx_phy->comp_dis_tune = PHY_TUNE_DEFAULT;
+
+	if (device_property_read_u32(dev, "fsl,pcs-tx-deemph-3p5db",
+				     &imx_phy->pcs_tx_deemph_3p5db))
+		imx_phy->pcs_tx_deemph_3p5db = PHY_TUNE_DEFAULT;
+
+	if (device_property_read_u32(dev, "fsl,phy-pcs-tx-swing-full",
+				     &imx_phy->pcs_tx_swing_full))
+		imx_phy->pcs_tx_swing_full = PHY_TUNE_DEFAULT;
+}
+
+static void imx8m_phy_tune(struct imx8mq_usb_phy *imx_phy)
+{
+	u32 value;
+
+	/* PHY tuning */
+	if (imx_phy->pcs_tx_deemph_3p5db != PHY_TUNE_DEFAULT) {
+		value = readl(imx_phy->base + PHY_CTRL4);
+		value &= ~PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK;
+		value |= FIELD_PREP(PHY_CTRL4_PCS_TX_DEEMPH_3P5DB_MASK,
+				   imx_phy->pcs_tx_deemph_3p5db);
+		writel(value, imx_phy->base + PHY_CTRL4);
+	}
+
+	if (imx_phy->pcs_tx_swing_full != PHY_TUNE_DEFAULT) {
+		value = readl(imx_phy->base + PHY_CTRL5);
+		value |= FIELD_PREP(PHY_CTRL5_PCS_TX_SWING_FULL_MASK,
+				   imx_phy->pcs_tx_swing_full);
+		writel(value, imx_phy->base + PHY_CTRL5);
+	}
+
+	if ((imx_phy->tx_vref_tune & imx_phy->tx_rise_tune &
+	     imx_phy->tx_preemp_amp_tune & imx_phy->comp_dis_tune &
+	     imx_phy->tx_vboost_level) == PHY_TUNE_DEFAULT)
+		/* If all are the default values, no need update. */
+		return;
+
+	value = readl(imx_phy->base + PHY_CTRL3);
+
+	if (imx_phy->tx_vref_tune != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_TXVREF_TUNE_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_TXVREF_TUNE_MASK,
+				   imx_phy->tx_vref_tune);
+	}
+
+	if (imx_phy->tx_rise_tune != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_TXRISE_TUNE_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_TXRISE_TUNE_MASK,
+				    imx_phy->tx_rise_tune);
+	}
+
+	if (imx_phy->tx_preemp_amp_tune != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_TXPREEMP_TUNE_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_TXPREEMP_TUNE_MASK,
+				imx_phy->tx_preemp_amp_tune);
+	}
+
+	if (imx_phy->comp_dis_tune != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_COMPDISTUNE_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_COMPDISTUNE_MASK,
+				    imx_phy->comp_dis_tune);
+	}
+
+	if (imx_phy->tx_vboost_level != PHY_TUNE_DEFAULT) {
+		value &= ~PHY_CTRL3_TX_VBOOST_LEVEL_MASK;
+		value |= FIELD_PREP(PHY_CTRL3_TX_VBOOST_LEVEL_MASK,
+				    imx_phy->tx_vboost_level);
+	}
+
+	writel(value, imx_phy->base + PHY_CTRL3);
+}
+
 static int imx8mq_usb_phy_init(struct phy *phy)
 {
 	struct imx8mq_usb_phy *imx_phy = phy_get_drvdata(phy);
@@ -99,6 +219,8 @@ static int imx8mp_usb_phy_init(struct phy *phy)
 	value &= ~(PHY_CTRL1_RESET | PHY_CTRL1_ATERESET);
 	writel(value, imx_phy->base + PHY_CTRL1);
 
+	imx8m_phy_tune(imx_phy);
+
 	return 0;
 }
 
@@ -182,6 +304,8 @@ static int imx8mq_usb_phy_probe(struct platform_device *pdev)
 
 	phy_set_drvdata(imx_phy->phy, imx_phy);
 
+	imx8m_get_phy_tuning_data(imx_phy);
+
 	phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
 
 	return PTR_ERR_OR_ZERO(phy_provider);
-- 
2.39.2

