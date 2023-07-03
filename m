Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70EC6745FD7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbjGCP1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbjGCP1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:27:44 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 08:27:42 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B1BE66
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:27:42 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 20230703152638bd31abf74635af848a
        for <linux-kernel@vger.kernel.org>;
        Mon, 03 Jul 2023 17:26:38 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=a5E01gIUkA26aGt9X7j9VPDWiRV+QjB9oiTC8u4s6Ao=;
 b=oJ0migxhMbedawTB702z3Van3Bb03KWJujtAQQ3pSsUzZM0Pva42oLJCKExrPh5WCyT5nK
 C3y03eT3uLgadcXrbfAoJPJ9+5IZryo/1lWhzyFVFKRmD9IZfftJR6VTAiL1CDs77NQ+p+UH
 mK2iTQvfgf+2hjX3SxAlu7c7VTrpE=;
From:   "M. Haener" <michael.haener@siemens.com>
To:     netdev@vger.kernel.org
Cc:     Michael Haener <michael.haener@siemens.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 2/3] net: dsa: mv88e632x: Refactor serdes write
Date:   Mon,  3 Jul 2023 17:26:08 +0200
Message-ID: <20230703152611.420381-3-michael.haener@siemens.com>
In-Reply-To: <20230703152611.420381-1-michael.haener@siemens.com>
References: <20230703152611.420381-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Haener <michael.haener@siemens.com>

To avoid code duplication, the serdes write functions
have been combined.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   | 13 ++++++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  2 ++
 drivers/net/dsa/mv88e6xxx/serdes.c | 52 +++++++++++++++---------------
 drivers/net/dsa/mv88e6xxx/serdes.h | 13 ++++++++
 4 files changed, 54 insertions(+), 26 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ddbc2be746bb..54e99cfb17c1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4431,6 +4431,7 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	.phylink_get_caps = mv88e6341_phylink_get_caps,
 };
 
@@ -4619,6 +4620,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
 	.serdes_power = mv88e6352_serdes_power,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4725,6 +4727,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
 	.serdes_power = mv88e6352_serdes_power,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
 	.serdes_irq_status = mv88e6352_serdes_irq_status,
@@ -4837,6 +4840,7 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 };
@@ -4903,6 +4907,7 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6390x_phylink_get_caps,
 };
@@ -4967,6 +4972,7 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
@@ -5026,6 +5032,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
 	.serdes_power = mv88e6352_serdes_power,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
 	.serdes_irq_status = mv88e6352_serdes_irq_status,
@@ -5142,6 +5149,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6390_ptp_ops,
@@ -5309,6 +5317,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	.phylink_get_caps = mv88e6341_phylink_get_caps,
 };
 
@@ -5460,6 +5469,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
 	.serdes_power = mv88e6352_serdes_power,
 	.serdes_read = mv88e6352_serdes_read,
+	.serdes_write = mv88e6352_serdes_write,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
 	.serdes_irq_status = mv88e6352_serdes_irq_status,
@@ -5542,6 +5552,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 };
 
@@ -5608,6 +5619,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6390_ptp_ops,
@@ -5676,6 +5688,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.serdes_irq_enable = mv88e6393x_serdes_irq_enable,
 	.serdes_irq_status = mv88e6393x_serdes_irq_status,
 	.serdes_read = mv88e6390_serdes_read,
+	.serdes_write = mv88e6390_serdes_write,
 	/* TODO: serdes stats */
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 17f89951557d..d78daa2bfad4 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -609,6 +609,8 @@ struct mv88e6xxx_ops {
 				  int lane, int speed, int duplex);
 	int (*serdes_read)(struct mv88e6xxx_chip *chip, int lane, int device,
 			   int reg, u16 *val);
+	int (*serdes_write)(struct mv88e6xxx_chip *chip, int lane, int device,
+			    int reg, u16 val);
 
 	/* SERDES interrupt handling */
 	unsigned int (*serdes_irq_mapping)(struct mv88e6xxx_chip *chip,
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index ab3471887b41..7b64e30600b9 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -25,8 +25,8 @@ int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 				       reg, val);
 }
 
-static int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int reg,
-				  u16 val)
+int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 val)
 {
 	return mv88e6xxx_phy_page_write(chip, MV88E6352_ADDR_SERDES,
 					MV88E6352_SERDES_PAGE_FIBER,
@@ -39,8 +39,8 @@ int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip,
 	return mv88e6xxx_phy_read_c45(chip, lane, device, reg, val);
 }
 
-static int mv88e6390_serdes_write(struct mv88e6xxx_chip *chip,
-				  int lane, int device, int reg, u16 val)
+int mv88e6390_serdes_write(struct mv88e6xxx_chip *chip,
+			   int lane, int device, int reg, u16 val)
 {
 	return mv88e6xxx_phy_write_c45(chip, lane, device, reg, val);
 }
@@ -133,7 +133,7 @@ int mv88e6352_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
 		new_val = val | BMCR_PDOWN;
 
 	if (val != new_val)
-		err = mv88e6352_serdes_write(chip, MII_BMCR, new_val);
+		err = mv88e6xxx_serdes_write(chip, lane, 0, MII_BMCR, new_val);
 
 	return err;
 }
@@ -167,7 +167,7 @@ int mv88e6352_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 
 	changed = val != adv;
 	if (changed) {
-		err = mv88e6352_serdes_write(chip, MII_ADVERTISE, adv);
+		err = mv88e6xxx_serdes_write(chip, lane, 0, MII_ADVERTISE, adv);
 		if (err)
 			return err;
 	}
@@ -184,7 +184,7 @@ int mv88e6352_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 	if (bmcr == val)
 		return changed;
 
-	return mv88e6352_serdes_write(chip, MII_BMCR, bmcr);
+	return mv88e6xxx_serdes_write(chip, lane, 0, MII_BMCR, bmcr);
 }
 
 int mv88e6352_serdes_pcs_get_state(struct mv88e6xxx_chip *chip, int port,
@@ -224,7 +224,7 @@ int mv88e6352_serdes_pcs_an_restart(struct mv88e6xxx_chip *chip, int port,
 	if (err)
 		return err;
 
-	return mv88e6352_serdes_write(chip, MII_BMCR, bmcr | BMCR_ANRESTART);
+	return mv88e6xxx_serdes_write(chip, lane, 0, MII_BMCR, bmcr | BMCR_ANRESTART);
 }
 
 int mv88e6352_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
@@ -255,7 +255,7 @@ int mv88e6352_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 	if (bmcr == val)
 		return 0;
 
-	return mv88e6352_serdes_write(chip, MII_BMCR, bmcr);
+	return mv88e6xxx_serdes_write(chip, lane, 0, MII_BMCR, bmcr);
 }
 
 int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
@@ -409,7 +409,7 @@ int mv88e6352_serdes_irq_enable(struct mv88e6xxx_chip *chip, int port, int lane,
 	if (enable)
 		val |= MV88E6352_SERDES_INT_LINK_CHANGE;
 
-	return mv88e6352_serdes_write(chip, MV88E6352_SERDES_INT_ENABLE, val);
+	return mv88e6xxx_serdes_write(chip, lane, 0, MV88E6352_SERDES_INT_ENABLE, val);
 }
 
 unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)
@@ -717,7 +717,7 @@ static int mv88e6390_serdes_power_10g(struct mv88e6xxx_chip *chip, int lane,
 		new_val = val | MDIO_CTRL1_LPOWER;
 
 	if (val != new_val)
-		err = mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+		err = mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 					     MV88E6390_10G_CTRL1, new_val);
 
 	return err;
@@ -741,7 +741,7 @@ static int mv88e6390_serdes_power_sgmii(struct mv88e6xxx_chip *chip, int lane,
 		new_val = val | BMCR_PDOWN;
 
 	if (val != new_val)
-		err = mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+		err = mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 					     MV88E6390_SGMII_BMCR, new_val);
 
 	return err;
@@ -831,7 +831,7 @@ static int mv88e6390_serdes_enable_checker(struct mv88e6xxx_chip *chip, int lane
 		return err;
 
 	reg |= MV88E6390_PG_CONTROL_ENABLE_PC;
-	return mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	return mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				      MV88E6390_PG_CONTROL, reg);
 }
 
@@ -897,7 +897,7 @@ int mv88e6390_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 
 	changed = val != adv;
 	if (changed) {
-		err = mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+		err = mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 					     MV88E6390_SGMII_ADVERTISE, adv);
 		if (err)
 			return err;
@@ -917,7 +917,7 @@ int mv88e6390_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 	if (bmcr == val)
 		return changed;
 
-	return mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	return mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				      MV88E6390_SGMII_BMCR, bmcr);
 }
 
@@ -1082,7 +1082,7 @@ int mv88e6390_serdes_pcs_an_restart(struct mv88e6xxx_chip *chip, int port,
 	if (err)
 		return err;
 
-	return mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	return mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				      MV88E6390_SGMII_BMCR,
 				      bmcr | BMCR_ANRESTART);
 }
@@ -1117,7 +1117,7 @@ int mv88e6390_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 	if (bmcr == val)
 		return 0;
 
-	return mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	return mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				      MV88E6390_SGMII_BMCR, bmcr);
 }
 
@@ -1164,7 +1164,7 @@ static int mv88e6390_serdes_irq_enable_sgmii(struct mv88e6xxx_chip *chip,
 		val |= MV88E6390_SGMII_INT_LINK_DOWN |
 			MV88E6390_SGMII_INT_LINK_UP;
 
-	return mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	return mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				      MV88E6390_SGMII_INT_ENABLE, val);
 }
 
@@ -1202,7 +1202,7 @@ static int mv88e6393x_serdes_irq_enable_10g(struct mv88e6xxx_chip *chip,
 	if (enable)
 		val |= MV88E6393X_10G_INT_LINK_CHANGE;
 
-	return mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	return mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				      MV88E6393X_10G_INT_ENABLE, val);
 }
 
@@ -1396,7 +1396,7 @@ int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
 	ctrl &= ~MV88E6352_SERDES_OUT_AMP_MASK;
 	ctrl |= reg;
 
-	return mv88e6352_serdes_write(chip, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
+	return mv88e6xxx_serdes_write(chip, lane, 0, MV88E6352_SERDES_SPEC_CTRL2, ctrl);
 }
 
 static int mv88e6393x_serdes_power_lane(struct mv88e6xxx_chip *chip, int lane,
@@ -1417,7 +1417,7 @@ static int mv88e6393x_serdes_power_lane(struct mv88e6xxx_chip *chip, int lane,
 		reg |= MV88E6393X_SERDES_CTRL1_TX_PDOWN |
 		       MV88E6393X_SERDES_CTRL1_RX_PDOWN;
 
-	return mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	return mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				      MV88E6393X_SERDES_CTRL1, reg);
 }
 
@@ -1442,7 +1442,7 @@ static int mv88e6393x_serdes_erratum_4_6(struct mv88e6xxx_chip *chip, int lane)
 	reg &= ~MV88E6393X_SERDES_POC_PDOWN;
 	reg |= MV88E6393X_SERDES_POC_RESET;
 
-	err = mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				     MV88E6393X_SERDES_POC, reg);
 	if (err)
 		return err;
@@ -1499,7 +1499,7 @@ static int mv88e6393x_serdes_erratum_4_8(struct mv88e6xxx_chip *chip, int lane)
 	else
 		reg &= ~MV88E6393X_ERRATA_4_8_BIT;
 
-	return mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	return mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				      MV88E6393X_ERRATA_4_8_REG, reg);
 }
 
@@ -1539,7 +1539,7 @@ static int mv88e6393x_serdes_erratum_5_2(struct mv88e6xxx_chip *chip, int lane,
 		reg &= ~fixes[i].mask;
 		reg |= fixes[i].val;
 
-		err = mv88e6390_serdes_write(chip, lane, fixes[i].dev,
+		err = mv88e6xxx_serdes_write(chip, lane, fixes[i].dev,
 					     fixes[i].reg, reg);
 		if (err)
 			return err;
@@ -1584,12 +1584,12 @@ static int mv88e6393x_serdes_fix_2500basex_an(struct mv88e6xxx_chip *chip,
 		reg |= MV88E6393X_SERDES_POC_PCS_2500BASEX;
 	reg |= MV88E6393X_SERDES_POC_RESET;
 
-	err = mv88e6390_serdes_write(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_PHYXS,
 				     MV88E6393X_SERDES_POC, reg);
 	if (err)
 		return err;
 
-	err = mv88e6390_serdes_write(chip, lane, MDIO_MMD_VEND1, 0x8000, 0x58);
+	err = mv88e6xxx_serdes_write(chip, lane, MDIO_MMD_VEND1, 0x8000, 0x58);
 	if (err)
 		return err;
 
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index 47ddd9d26c92..e71cddf63eba 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -141,6 +141,10 @@ int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
 int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
+int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 val);
+int mv88e6390_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 val);
 unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 					  int port);
 unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
@@ -226,6 +230,15 @@ static inline int mv88e6xxx_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 	return chip->info->ops->serdes_read(chip, lane, device, reg, val);
 }
 
+static inline int mv88e6xxx_serdes_write(struct mv88e6xxx_chip *chip, int lane,
+					 int device, int reg, u16 val)
+{
+	if (!chip->info->ops->serdes_write)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->serdes_write(chip, lane, device, reg, val);
+}
+
 static inline unsigned int
 mv88e6xxx_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)
 {
-- 
2.41.0

