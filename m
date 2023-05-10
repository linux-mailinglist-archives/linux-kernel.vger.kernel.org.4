Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA536FE7BD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjEJW4D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:56:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236629AbjEJWz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:55:56 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7216EA2;
        Wed, 10 May 2023 15:55:50 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pwsir-0004Pe-1B;
        Wed, 10 May 2023 22:55:49 +0000
Date:   Thu, 11 May 2023 00:53:55 +0200
From:   Alexander Couzens <lynxis@fe80.eu>
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
Subject: [PATCH net-next 1/8] net: phy: realtek: rtl8221: allow to configure
 SERDES mode
Message-ID: <302d982c5550f10d589735fc2e46cf27386c39f4.1683756691.git.daniel@makrotopia.org>
References: <cover.1683756691.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683756691.git.daniel@makrotopia.org>
Sender: daniel@makrotopia.org
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rtl8221 supports multiple SERDES modes:
- SGMII
- 2500base-x
- HiSGMII

Further it supports rate adaption on SERDES links to allow
slow ethernet speeds (10/100/1000mbit) to work on 2500base-x/HiSGMII
links without reducing the SERDES speed.

When operating without rate adapters the SERDES link will follow the
ethernet speed.

Signed-off-by: Alexander Couzens <lynxis@fe80.eu>
---
 drivers/net/phy/realtek.c | 55 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 3d99fd6664d7..a7dd5a075135 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -53,6 +53,15 @@
 						 RTL8201F_ISR_LINK)
 #define RTL8201F_IER				0x13
 
+#define RTL8221B_MMD_SERDES_CTRL		MDIO_MMD_VEND1
+#define RTL8221B_MMD_PHY_CTRL			MDIO_MMD_VEND2
+#define RTL8221B_SERDES_OPTION			0x697a
+#define RTL8221B_SERDES_OPTION_MODE_MASK	GENMASK(5, 0)
+#define RTL8221B_SERDES_OPTION_MODE_2500BASEX_SGMII	0
+#define RTL8221B_SERDES_OPTION_MODE_HISGMII_SGMII	1
+#define RTL8221B_SERDES_OPTION_MODE_2500BASEX		2
+#define RTL8221B_SERDES_OPTION_MODE_HISGMII		3
+
 #define RTL8366RB_POWER_SAVE			0x15
 #define RTL8366RB_POWER_SAVE_ON			BIT(12)
 
@@ -849,6 +858,48 @@ static irqreturn_t rtl9000a_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+static int rtl8221b_config_init(struct phy_device *phydev)
+{
+	u16 option_mode;
+
+	switch (phydev->interface) {
+	case PHY_INTERFACE_MODE_2500BASEX:
+		if (!phydev->is_c45) {
+			option_mode = RTL8221B_SERDES_OPTION_MODE_2500BASEX;
+			break;
+		}
+		fallthrough;
+	case PHY_INTERFACE_MODE_SGMII:
+		option_mode = RTL8221B_SERDES_OPTION_MODE_2500BASEX_SGMII;
+		break;
+	default:
+		return 0;
+	}
+
+	phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL,
+		      0x75f3, 0);
+
+	phy_modify_mmd_changed(phydev, RTL8221B_MMD_SERDES_CTRL,
+			       RTL8221B_SERDES_OPTION,
+			       RTL8221B_SERDES_OPTION_MODE_MASK, option_mode);
+	switch (option_mode) {
+	case RTL8221B_SERDES_OPTION_MODE_2500BASEX_SGMII:
+	case RTL8221B_SERDES_OPTION_MODE_2500BASEX:
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6a04, 0x0503);
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6f10, 0xd455);
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6f11, 0x8020);
+		break;
+	case RTL8221B_SERDES_OPTION_MODE_HISGMII_SGMII:
+	case RTL8221B_SERDES_OPTION_MODE_HISGMII:
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6a04, 0x0503);
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6f10, 0xd433);
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x6f11, 0x8020);
+		break;
+	}
+
+	return 0;
+}
+
 static struct phy_driver realtek_drvs[] = {
 	{
 		PHY_ID_MATCH_EXACT(0x00008201),
@@ -970,6 +1021,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name		= "RTL8226B_RTL8221B 2.5Gbps PHY",
 		.get_features	= rtl822x_get_features,
 		.config_aneg	= rtl822x_config_aneg,
+		.config_init	= rtl8221b_config_init,
 		.read_status	= rtl822x_read_status,
 		.suspend	= genphy_suspend,
 		.resume		= rtlgen_resume,
@@ -992,6 +1044,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8226B-CG_RTL8221B-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl8221b_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1002,6 +1055,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl8221b_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
@@ -1012,6 +1066,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VM-CG 2.5Gbps PHY",
 		.get_features   = rtl822x_get_features,
 		.config_aneg    = rtl822x_config_aneg,
+		.config_init    = rtl8221b_config_init,
 		.read_status    = rtl822x_read_status,
 		.suspend        = genphy_suspend,
 		.resume         = rtlgen_resume,
-- 
2.40.0

