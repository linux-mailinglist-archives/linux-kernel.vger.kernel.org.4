Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD545B8541
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiINJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 05:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbiINJj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 05:39:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001CED67;
        Wed, 14 Sep 2022 02:39:46 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dVAj113545;
        Wed, 14 Sep 2022 04:39:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1663148371;
        bh=Nu+6daNznh/b8uWXgMlJJ6knNdhWjxmmybMsKI7CSv8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=DjQ6EkTWoYyIvajgqjdhoBr1nROL/OcxubFb26EKXllLDHTAL0kLHZ/rRBcf2uD2T
         Y46WjULT8umjseZZfNruEW3ExnQ9oDtXM/6yV7Pb6Xt0FNlrthzMqqyglTk+PC2ell
         GteDT1uux/wOZsiAh7ZZGiUkFrs2zNHRVMmB/k64=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 28E9dVQT014825
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 14 Sep 2022 04:39:31 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Wed, 14
 Sep 2022 04:39:30 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Wed, 14 Sep 2022 04:39:30 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 28E9dBHG111966;
        Wed, 14 Sep 2022 04:39:26 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <sjakhade@cadence.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 3/6] phy: ti: gmii-sel: Add support for CPSW9G GMII SEL in J721e
Date:   Wed, 14 Sep 2022 15:09:08 +0530
Message-ID: <20220914093911.187764-4-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220914093911.187764-1-s-vadapalli@ti.com>
References: <20220914093911.187764-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each of the CPSW9G ports in J721e support additional modes like QSGMII.
Add a new compatible for J721e to support the additional modes.

In TI's J721e, each of the CPSW9G ethernet interfaces can act as a
QSGMII main or QSGMII-SUB port. The QSGMII main interface is responsible
for performing auto-negotiation between the MAC and the PHY while the rest
of the interfaces are designated as QSGMII-SUB interfaces, indicating that
they will not be taking part in the auto-negotiation process.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 47 +++++++++++++++++++++++++++--------
 1 file changed, 37 insertions(+), 10 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index f0b2ba7a9c96..fdb1a7db123d 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -223,6 +223,13 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
 	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII) | BIT(PHY_INTERFACE_MODE_SGMII),
 };
 
+static const
+struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw9g_soc_j721e = {
+	.use_of_data = true,
+	.regfields = phy_gmii_sel_fields_am654,
+	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
+};
+
 static const struct of_device_id phy_gmii_sel_id_table[] = {
 	{
 		.compatible	= "ti,am3352-phy-gmii-sel",
@@ -248,6 +255,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
 		.compatible	= "ti,j7200-cpsw5g-phy-gmii-sel",
 		.data		= &phy_gmii_sel_cpsw5g_soc_j7200,
 	},
+	{
+		.compatible	= "ti,j721e-cpsw9g-phy-gmii-sel",
+		.data		= &phy_gmii_sel_cpsw9g_soc_j721e,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, phy_gmii_sel_id_table);
@@ -389,7 +400,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	const struct of_device_id *of_id;
 	struct phy_gmii_sel_priv *priv;
-	u32 main_ports = 1;
+	u32 main_ports[2] = {1, 1};
 	int ret;
 
 	of_id = of_match_node(phy_gmii_sel_id_table, pdev->dev.of_node);
@@ -403,15 +414,31 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	priv->soc_data = of_id->data;
 	priv->num_ports = priv->soc_data->num_ports;
-	of_property_read_u32(node, "ti,qsgmii-main-ports", &main_ports);
-	/*
-	 * Ensure that main_ports is within bounds. If the property
-	 * ti,qsgmii-main-ports is not mentioned, or the value mentioned
-	 * is out of bounds, default to 1.
-	 */
-	if (main_ports < 1 || main_ports > 4)
-		main_ports = 1;
-	priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports);
+	/* Differentiate between J7200 CPSW5G and J721e CPSW9G */
+	if (of_device_is_compatible(node, "ti,j7200-cpsw5g-phy-gmii-sel") > 0) {
+		of_property_read_u32(node, "ti,qsgmii-main-ports", &main_ports[0]);
+		/*
+		 * Ensure that main_ports is within bounds. If the property
+		 * ti,qsgmii-main-ports is not mentioned, or the value mentioned
+		 * is out of bounds, default to 1.
+		 */
+		if (main_ports[0] < 1 || main_ports[0] > 4)
+			main_ports[0] = 1;
+		priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports[0]);
+	} else if (of_device_is_compatible(node, "ti,j721e-cpsw9g-phy-gmii-sel") > 0) {
+		of_property_read_u32_array(node, "ti,qsgmii-main-ports", &main_ports[0], 2);
+		/*
+		 * Ensure that main_ports is within bounds. If the property
+		 * ti,qsgmii-main-ports is not mentioned, or the value mentioned
+		 * is out of bounds, default to 1.
+		 */
+		if (main_ports[0] < 1 || main_ports[0] > 8)
+			main_ports[0] = 1;
+		if (main_ports[1] < 1 || main_ports[1] > 8)
+			main_ports[1] = 1;
+		priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports[0]);
+		priv->qsgmii_main_ports |= PHY_GMII_PORT(main_ports[1]);
+	}
 
 	priv->regmap = syscon_node_to_regmap(node->parent);
 	if (IS_ERR(priv->regmap)) {
-- 
2.25.1

