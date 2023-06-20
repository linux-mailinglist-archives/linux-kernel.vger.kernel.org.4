Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29F3F736C68
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 14:55:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjFTMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 08:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbjFTMz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 08:55:27 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424C510F8
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 05:55:26 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qBat4-0005HR-Bi; Tue, 20 Jun 2023 14:55:10 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qBat2-008nEH-SB; Tue, 20 Jun 2023 14:55:08 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qBat2-00A50M-7A; Tue, 20 Jun 2023 14:55:08 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v1 1/1] net: phy: dp83td510: fix kernel stall during netboot in DP83TD510E PHY driver
Date:   Tue, 20 Jun 2023 14:55:05 +0200
Message-Id: <20230620125505.2402497-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an issue where the kernel would stall during netboot, showing the
"sched: RT throttling activated" message. This stall was triggered by
the behavior of the mii_interrupt bit (Bit 7 - DP83TD510E_STS_MII_INT)
in the DP83TD510E's PHY_STS Register (Address = 0x10). The DP83TD510E
datasheet (2020) states that the bit clears on write, however, in
practice, the bit clears on read.

This discrepancy had significant implications on the driver's interrupt
handling. The PHY_STS Register was used by handle_interrupt() to check
for pending interrupts and by read_status() to get the current link
status. The call to read_status() was unintentionally clearing the
mii_interrupt status bit without deasserting the IRQ pin, causing
handle_interrupt() to miss other pending interrupts. This issue was most
apparent during netboot.

The fix refrains from using the PHY_STS Register for interrupt handling.
Instead, we now solely rely on the INTERRUPT_REG_1 Register (Address =
0x12) and INTERRUPT_REG_2 Register (Address = 0x13) for this purpose.
These registers directly influence the IRQ pin state and are latched
high until read.

Note: The INTERRUPT_REG_2 Register (Address = 0x13) exists and can also
be used for interrupt handling, specifically for "Aneg page received
interrupt" and "Polarity change interrupt". However, these features are
currently not supported by this driver.

Fixes: 165cd04fe253 ("net: phy: dp83td510: Add support for the DP83TD510 Ethernet PHY")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/phy/dp83td510.c | 23 +++++------------------
 1 file changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/dp83td510.c b/drivers/net/phy/dp83td510.c
index 3cd9a77f9532..d7616b13c594 100644
--- a/drivers/net/phy/dp83td510.c
+++ b/drivers/net/phy/dp83td510.c
@@ -12,6 +12,11 @@
 
 /* MDIO_MMD_VEND2 registers */
 #define DP83TD510E_PHY_STS			0x10
+/* Bit 7 - mii_interrupt, active high. Clears on read.
+ * Note: Clearing does not necessarily deactivate IRQ pin if interrupts pending.
+ * This differs from the DP83TD510E datasheet (2020) which states this bit
+ * clears on write 0.
+ */
 #define DP83TD510E_STS_MII_INT			BIT(7)
 #define DP83TD510E_LINK_STATUS			BIT(0)
 
@@ -53,12 +58,6 @@ static int dp83td510_config_intr(struct phy_device *phydev)
 	int ret;
 
 	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
-		/* Clear any pending interrupts */
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS,
-				    0x0);
-		if (ret)
-			return ret;
-
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2,
 				    DP83TD510E_INTERRUPT_REG_1,
 				    DP83TD510E_INT1_LINK_EN);
@@ -81,10 +80,6 @@ static int dp83td510_config_intr(struct phy_device *phydev)
 					 DP83TD510E_GENCFG_INT_EN);
 		if (ret)
 			return ret;
-
-		/* Clear any pending interrupts */
-		ret = phy_write_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS,
-				    0x0);
 	}
 
 	return ret;
@@ -94,14 +89,6 @@ static irqreturn_t dp83td510_handle_interrupt(struct phy_device *phydev)
 {
 	int  ret;
 
-	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_PHY_STS);
-	if (ret < 0) {
-		phy_error(phydev);
-		return IRQ_NONE;
-	} else if (!(ret & DP83TD510E_STS_MII_INT)) {
-		return IRQ_NONE;
-	}
-
 	/* Read the current enabled interrupts */
 	ret = phy_read_mmd(phydev, MDIO_MMD_VEND2, DP83TD510E_INTERRUPT_REG_1);
 	if (ret < 0) {
-- 
2.39.2

