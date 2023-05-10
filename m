Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853726FE7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236777AbjEJXCa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:02:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236497AbjEJXC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:02:28 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06305249;
        Wed, 10 May 2023 16:02:26 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pwspE-0004Wg-2T;
        Wed, 10 May 2023 23:02:25 +0000
Date:   Thu, 11 May 2023 01:00:21 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH net-next 8/8] net: phy: realtek: setup ALDPS on RTL8221B
Message-ID: <701034ea45c08db557af926a5a44113e4e45c634.1683756691.git.daniel@makrotopia.org>
References: <cover.1683756691.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683756691.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setup Link Down Power Saving Mode according the DTS property
just like for RTL821x 1GE PHYs.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 29168f98f451..b5d7208004d8 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -62,6 +62,10 @@
 #define RTL8221B_SERDES_OPTION_MODE_2500BASEX		2
 #define RTL8221B_SERDES_OPTION_MODE_HISGMII		3
 
+#define RTL8221B_PHYCR1				0xa430
+#define RTL8221B_PHYCR1_ALDPS_EN		BIT(2)
+#define RTL8221B_PHYCR1_ALDPS_XTAL_OFF_EN	BIT(12)
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -757,6 +761,25 @@ static int rtl8226_match_phy_device(struct phy_device *phydev)
 	       rtlgen_supports_2_5gbps(phydev);
 }
 
+static int rtl822x_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	int val;
+
+	val = phy_read_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, RTL8221B_PHYCR1);
+	if (val < 0)
+		return val;
+
+	if (of_property_read_bool(dev->of_node, "realtek,aldps-enable"))
+		val |= RTL8221B_PHYCR1_ALDPS_EN | RTL8221B_PHYCR1_ALDPS_XTAL_OFF_EN;
+	else
+		val &= ~(RTL8221B_PHYCR1_ALDPS_EN | RTL8221B_PHYCR1_ALDPS_XTAL_OFF_EN);
+
+	phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, RTL8221B_PHYCR1, val);
+
+	return 0;
+}
+
 static int rtlgen_resume(struct phy_device *phydev)
 {
 	int ret = genphy_resume(phydev);
@@ -1034,6 +1057,7 @@ static struct phy_driver realtek_drvs[] = {
 		.match_phy_device = rtl8226_match_phy_device,
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
+		.probe          = rtl822x_probe,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1048,6 +1072,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
 		.config_init	= rtl8221b_config_init,
+		.probe          = rtl822x_probe,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -1061,6 +1086,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8226-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.probe          = rtl822x_probe,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1073,6 +1099,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl8221b_config_init,
+		.probe          = rtl822x_probe,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1085,6 +1112,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl8221b_config_init,
+		.probe          = rtl822x_probe,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1097,6 +1125,7 @@ static struct phy_driver realtek_drvs[] = {
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
 		.config_init    = rtl8221b_config_init,
+		.probe          = rtl822x_probe,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
-- 
2.40.0

