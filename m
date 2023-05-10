Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7095A6FE7CE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:00:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbjEJXAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236614AbjEJXAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:00:07 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E64F9E64;
        Wed, 10 May 2023 16:00:05 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pwsmy-0004U1-1A;
        Wed, 10 May 2023 23:00:04 +0000
Date:   Thu, 11 May 2023 00:58:10 +0200
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
Subject: [PATCH net-next 4/8] net: phy: realtek: disable SGMII in-band AN for
 2.5G PHYs
Message-ID: <574c9703523af5643af0623144db3aa385635e84.1683756691.git.daniel@makrotopia.org>
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

MAC drivers don't use SGMII in-band autonegotiation unless told to do so
in device tree using 'managed = "in-band-status"'. When using MDIO to
access a PHY, in-band-status is unneeded as we have link-status via
MDIO. Switch off SGMII in-band autonegotiation using magic values.

Reported-by: Chen Minqiang <ptpt52@gmail.com>
Reported-by: Chukun Pan <amadeus@jmu.edu.cn>
Reported-by: Yevhen Kolomeiko <jarvis2709@gmail.com>
Tested-by: Yevhen Kolomeiko <jarvis2709@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 0cf7846c9812..acadb6f0057b 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -666,7 +666,7 @@ static int rtl822x_get_features(struct phy_device *phydev)
 
 static int rtl822x_config_aneg(struct phy_device *phydev)
 {
-	int ret = 0;
+	int val, ret = 0;
 
 	if (phydev->autoneg == AUTONEG_ENABLE) {
 		u16 adv2500 = 0;
@@ -681,6 +681,19 @@ static int rtl822x_config_aneg(struct phy_device *phydev)
 			return ret;
 	}
 
+	/* MACs using phylink assume SGMII in-band status is not used.
+	 * Keep things as they are for MACs not using phylink such as
+	 * RealTek PCIe chips which come with built-in PHYs
+	 */
+	if (phydev->phylink) {
+		/* Disable SGMII AN */
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x7588, 0x2);
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x7589, 0x71d0);
+		phy_write_mmd(phydev, RTL8221B_MMD_SERDES_CTRL, 0x7587, 0x3);
+		phy_read_mmd_poll_timeout(phydev, RTL8221B_MMD_SERDES_CTRL, 0x7587,
+					  val, !(val & BIT(0)), 500, 100000, false);
+	}
+
 	return __genphy_config_aneg(phydev, ret);
 }
 
-- 
2.40.0

