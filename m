Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0FBD745FD5
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbjGCP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGCP1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:27:43 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jul 2023 08:27:39 PDT
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B056EE5D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:27:39 -0700 (PDT)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 2023070315263519655ba5ba6f625af5
        for <linux-kernel@vger.kernel.org>;
        Mon, 03 Jul 2023 17:26:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=ZdPJck4ohxSu61f3MR2THgU+BhIdxesm3nlOUSlZhCI=;
 b=ZYEZDeyw1rr06Em6uD24W12wiJnO9XELv/UyU9YDbNaonGsG/z6qK6Y0STC44yKuRr7Ele
 1EZ+TCAjIp2ORUeWA804loratsH5LAv1G3MFHeYGDuKXfzNBrovCZL9iHH6ZBZNyMd5VrY3u
 Gv5LYKp1hWDWpKvI5Wwi9p7uMjgIw=;
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
Subject: [PATCH 1/3] net: dsa: mv88e632x: Refactor serdes read
Date:   Mon,  3 Jul 2023 17:26:07 +0200
Message-ID: <20230703152611.420381-2-michael.haener@siemens.com>
In-Reply-To: <20230703152611.420381-1-michael.haener@siemens.com>
References: <20230703152611.420381-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Haener <michael.haener@siemens.com>

To avoid code duplication, the serdes read functions
have been combined.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   | 13 ++++
 drivers/net/dsa/mv88e6xxx/chip.h   |  2 +
 drivers/net/dsa/mv88e6xxx/serdes.c | 96 ++++++++++++++++--------------
 drivers/net/dsa/mv88e6xxx/serdes.h | 13 ++++
 4 files changed, 80 insertions(+), 44 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 8b51756bd805..ddbc2be746bb 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4430,6 +4430,7 @@ static const struct mv88e6xxx_ops mv88e6141_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.phylink_get_caps = mv88e6341_phylink_get_caps,
 };
 
@@ -4617,6 +4618,7 @@ static const struct mv88e6xxx_ops mv88e6172_ops = {
 	.serdes_pcs_an_restart = mv88e6352_serdes_pcs_an_restart,
 	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
 	.serdes_power = mv88e6352_serdes_power,
+	.serdes_read = mv88e6352_serdes_read,
 	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6352_serdes_get_regs,
 	.gpio_ops = &mv88e6352_gpio_ops,
@@ -4722,6 +4724,7 @@ static const struct mv88e6xxx_ops mv88e6176_ops = {
 	.serdes_pcs_an_restart = mv88e6352_serdes_pcs_an_restart,
 	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
 	.serdes_power = mv88e6352_serdes_power,
+	.serdes_read = mv88e6352_serdes_read,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
 	.serdes_irq_status = mv88e6352_serdes_irq_status,
@@ -4833,6 +4836,7 @@ static const struct mv88e6xxx_ops mv88e6190_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 };
@@ -4898,6 +4902,7 @@ static const struct mv88e6xxx_ops mv88e6190x_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.phylink_get_caps = mv88e6390x_phylink_get_caps,
 };
@@ -4961,6 +4966,7 @@ static const struct mv88e6xxx_ops mv88e6191_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
@@ -5019,6 +5025,7 @@ static const struct mv88e6xxx_ops mv88e6240_ops = {
 	.serdes_pcs_an_restart = mv88e6352_serdes_pcs_an_restart,
 	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
 	.serdes_power = mv88e6352_serdes_power,
+	.serdes_read = mv88e6352_serdes_read,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
 	.serdes_irq_status = mv88e6352_serdes_irq_status,
@@ -5134,6 +5141,7 @@ static const struct mv88e6xxx_ops mv88e6290_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6390_ptp_ops,
@@ -5300,6 +5308,7 @@ static const struct mv88e6xxx_ops mv88e6341_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.phylink_get_caps = mv88e6341_phylink_get_caps,
 };
 
@@ -5450,6 +5459,7 @@ static const struct mv88e6xxx_ops mv88e6352_ops = {
 	.serdes_pcs_an_restart = mv88e6352_serdes_pcs_an_restart,
 	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
 	.serdes_power = mv88e6352_serdes_power,
+	.serdes_read = mv88e6352_serdes_read,
 	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
 	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
 	.serdes_irq_status = mv88e6352_serdes_irq_status,
@@ -5531,6 +5541,7 @@ static const struct mv88e6xxx_ops mv88e6390_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.phylink_get_caps = mv88e6390_phylink_get_caps,
 };
 
@@ -5596,6 +5607,7 @@ static const struct mv88e6xxx_ops mv88e6390x_ops = {
 	.serdes_get_stats = mv88e6390_serdes_get_stats,
 	.serdes_get_regs_len = mv88e6390_serdes_get_regs_len,
 	.serdes_get_regs = mv88e6390_serdes_get_regs,
+	.serdes_read = mv88e6390_serdes_read,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
 	.ptp_ops = &mv88e6390_ptp_ops,
@@ -5663,6 +5675,7 @@ static const struct mv88e6xxx_ops mv88e6393x_ops = {
 	.serdes_irq_mapping = mv88e6390_serdes_irq_mapping,
 	.serdes_irq_enable = mv88e6393x_serdes_irq_enable,
 	.serdes_irq_status = mv88e6393x_serdes_irq_status,
+	.serdes_read = mv88e6390_serdes_read,
 	/* TODO: serdes stats */
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6390_avb_ops,
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 0ad34b2d8913..17f89951557d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -607,6 +607,8 @@ struct mv88e6xxx_ops {
 				     int lane);
 	int (*serdes_pcs_link_up)(struct mv88e6xxx_chip *chip, int port,
 				  int lane, int speed, int duplex);
+	int (*serdes_read)(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 *val);
 
 	/* SERDES interrupt handling */
 	unsigned int (*serdes_irq_mapping)(struct mv88e6xxx_chip *chip,
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 80167d53212f..ab3471887b41 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -17,8 +17,8 @@
 #include "port.h"
 #include "serdes.h"
 
-static int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int reg,
-				 u16 *val)
+int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
+			  int device, int reg, u16 *val)
 {
 	return mv88e6xxx_phy_page_read(chip, MV88E6352_ADDR_SERDES,
 				       MV88E6352_SERDES_PAGE_FIBER,
@@ -33,8 +33,8 @@ static int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int reg,
 					reg, val);
 }
 
-static int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip,
-				 int lane, int device, int reg, u16 *val)
+int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip,
+			  int lane, int device, int reg, u16 *val)
 {
 	return mv88e6xxx_phy_read_c45(chip, lane, device, reg, val);
 }
@@ -123,7 +123,7 @@ int mv88e6352_serdes_power(struct mv88e6xxx_chip *chip, int port, int lane,
 	u16 val, new_val;
 	int err;
 
-	err = mv88e6352_serdes_read(chip, MII_BMCR, &val);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MII_BMCR, &val);
 	if (err)
 		return err;
 
@@ -161,7 +161,7 @@ int mv88e6352_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 		return 0;
 	}
 
-	err = mv88e6352_serdes_read(chip, MII_ADVERTISE, &val);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MII_ADVERTISE, &val);
 	if (err)
 		return err;
 
@@ -172,7 +172,7 @@ int mv88e6352_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 			return err;
 	}
 
-	err = mv88e6352_serdes_read(chip, MII_BMCR, &val);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MII_BMCR, &val);
 	if (err)
 		return err;
 
@@ -193,19 +193,19 @@ int mv88e6352_serdes_pcs_get_state(struct mv88e6xxx_chip *chip, int port,
 	u16 bmsr, lpa, status;
 	int err;
 
-	err = mv88e6352_serdes_read(chip, MII_BMSR, &bmsr);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MII_BMSR, &bmsr);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes PHY BMSR: %d\n", err);
 		return err;
 	}
 
-	err = mv88e6352_serdes_read(chip, 0x11, &status);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, 0x11, &status);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes PHY status: %d\n", err);
 		return err;
 	}
 
-	err = mv88e6352_serdes_read(chip, MII_LPA, &lpa);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MII_LPA, &lpa);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes PHY LPA: %d\n", err);
 		return err;
@@ -220,7 +220,7 @@ int mv88e6352_serdes_pcs_an_restart(struct mv88e6xxx_chip *chip, int port,
 	u16 bmcr;
 	int err;
 
-	err = mv88e6352_serdes_read(chip, MII_BMCR, &bmcr);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MII_BMCR, &bmcr);
 	if (err)
 		return err;
 
@@ -233,7 +233,7 @@ int mv88e6352_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 	u16 val, bmcr;
 	int err;
 
-	err = mv88e6352_serdes_read(chip, MII_BMCR, &val);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MII_BMCR, &val);
 	if (err)
 		return err;
 
@@ -311,14 +311,16 @@ int mv88e6352_serdes_get_strings(struct mv88e6xxx_chip *chip,
 	return ARRAY_SIZE(mv88e6352_serdes_hw_stats);
 }
 
-static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
+static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip, int port,
 					  struct mv88e6352_serdes_hw_stat *stat)
 {
 	u64 val = 0;
 	u16 reg;
 	int err;
+	int lane;
 
-	err = mv88e6352_serdes_read(chip, stat->reg, &reg);
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, stat->reg, &reg);
 	if (err) {
 		dev_err(chip->dev, "failed to read statistic\n");
 		return 0;
@@ -327,7 +329,7 @@ static uint64_t mv88e6352_serdes_get_stat(struct mv88e6xxx_chip *chip,
 	val = reg;
 
 	if (stat->sizeof_stat == 32) {
-		err = mv88e6352_serdes_read(chip, stat->reg + 1, &reg);
+		err = mv88e6xxx_serdes_read(chip, lane, 0, stat->reg + 1, &reg);
 		if (err) {
 			dev_err(chip->dev, "failed to read statistic\n");
 			return 0;
@@ -355,7 +357,7 @@ int mv88e6352_serdes_get_stats(struct mv88e6xxx_chip *chip, int port,
 
 	for (i = 0; i < ARRAY_SIZE(mv88e6352_serdes_hw_stats); i++) {
 		stat = &mv88e6352_serdes_hw_stats[i];
-		value = mv88e6352_serdes_get_stat(chip, stat);
+		value = mv88e6352_serdes_get_stat(chip, port, stat);
 		mv88e6xxx_port->serdes_stats[i] += value;
 		data[i] = mv88e6xxx_port->serdes_stats[i];
 	}
@@ -367,9 +369,11 @@ static void mv88e6352_serdes_irq_link(struct mv88e6xxx_chip *chip, int port)
 {
 	u16 bmsr;
 	int err;
+	int lane;
 
 	/* If the link has dropped, we want to know about it. */
-	err = mv88e6352_serdes_read(chip, MII_BMSR, &bmsr);
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MII_BMSR, &bmsr);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes BMSR: %d\n", err);
 		return;
@@ -385,7 +389,7 @@ irqreturn_t mv88e6352_serdes_irq_status(struct mv88e6xxx_chip *chip, int port,
 	u16 status;
 	int err;
 
-	err = mv88e6352_serdes_read(chip, MV88E6352_SERDES_INT_STATUS, &status);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MV88E6352_SERDES_INT_STATUS, &status);
 	if (err)
 		return ret;
 
@@ -432,13 +436,15 @@ void mv88e6352_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
 	u16 reg;
 	int err;
 	int i;
+	int lane;
 
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
 	if (err <= 0)
 		return;
 
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
 	for (i = 0 ; i < 32; i++) {
-		err = mv88e6352_serdes_read(chip, i, &reg);
+		err = mv88e6xxx_serdes_read(chip, lane, 0, i, &reg);
 		if (!err)
 			p[i] = reg;
 	}
@@ -697,7 +703,7 @@ static int mv88e6390_serdes_power_10g(struct mv88e6xxx_chip *chip, int lane,
 	u16 val, new_val;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_10G_CTRL1, &val);
 
 	if (err)
@@ -724,7 +730,7 @@ static int mv88e6390_serdes_power_sgmii(struct mv88e6xxx_chip *chip, int lane,
 	u16 val, new_val;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_BMCR, &val);
 	if (err)
 		return err;
@@ -784,7 +790,7 @@ static uint64_t mv88e6390_serdes_get_stat(struct mv88e6xxx_chip *chip, int lane,
 	int err, i;
 
 	for (i = 0; i < 3; i++) {
-		err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+		err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 					    stat->reg + i, &reg[i]);
 		if (err) {
 			dev_err(chip->dev, "failed to read statistic\n");
@@ -819,7 +825,7 @@ static int mv88e6390_serdes_enable_checker(struct mv88e6xxx_chip *chip, int lane
 	u16 reg;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_PG_CONTROL, &reg);
 	if (err)
 		return err;
@@ -884,7 +890,7 @@ int mv88e6390_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 		return 0;
 	}
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_ADVERTISE, &val);
 	if (err)
 		return err;
@@ -897,7 +903,7 @@ int mv88e6390_serdes_pcs_config(struct mv88e6xxx_chip *chip, int port,
 			return err;
 	}
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_BMCR, &val);
 	if (err)
 		return err;
@@ -921,21 +927,21 @@ static int mv88e6390_serdes_pcs_get_state_sgmii(struct mv88e6xxx_chip *chip,
 	u16 bmsr, lpa, status;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_BMSR, &bmsr);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes PHY BMSR: %d\n", err);
 		return err;
 	}
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_PHY_STATUS, &status);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes PHY status: %d\n", err);
 		return err;
 	}
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_LPA, &lpa);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes PHY LPA: %d\n", err);
@@ -951,7 +957,7 @@ static int mv88e6390_serdes_pcs_get_state_10g(struct mv88e6xxx_chip *chip,
 	u16 status;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_10G_STAT1, &status);
 	if (err)
 		return err;
@@ -972,7 +978,7 @@ static int mv88e6393x_serdes_pcs_get_state_10g(struct mv88e6xxx_chip *chip,
 	u16 status;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_10G_STAT1, &status);
 	if (err)
 		return err;
@@ -1071,7 +1077,7 @@ int mv88e6390_serdes_pcs_an_restart(struct mv88e6xxx_chip *chip, int port,
 	u16 bmcr;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_BMCR, &bmcr);
 	if (err)
 		return err;
@@ -1087,7 +1093,7 @@ int mv88e6390_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 	u16 val, bmcr;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_BMCR, &val);
 	if (err)
 		return err;
@@ -1122,7 +1128,7 @@ static void mv88e6390_serdes_irq_link_sgmii(struct mv88e6xxx_chip *chip,
 	int err;
 
 	/* If the link has dropped, we want to know about it. */
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_BMSR, &bmsr);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes BMSR: %d\n", err);
@@ -1139,7 +1145,7 @@ static void mv88e6393x_serdes_irq_link_10g(struct mv88e6xxx_chip *chip,
 	int err;
 
 	/* If the link has dropped, we want to know about it. */
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_10G_STAT1, &status);
 	if (err) {
 		dev_err(chip->dev, "can't read Serdes STAT1: %d\n", err);
@@ -1182,7 +1188,7 @@ static int mv88e6390_serdes_irq_status_sgmii(struct mv88e6xxx_chip *chip,
 {
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6390_SGMII_INT_STATUS, status);
 
 	return err;
@@ -1224,7 +1230,7 @@ static int mv88e6393x_serdes_irq_status_10g(struct mv88e6xxx_chip *chip,
 {
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6393X_10G_INT_STATUS, status);
 
 	return err;
@@ -1346,7 +1352,7 @@ void mv88e6390_serdes_get_regs(struct mv88e6xxx_chip *chip, int port, void *_p)
 		return;
 
 	for (i = 0 ; i < ARRAY_SIZE(mv88e6390_serdes_regs); i++) {
-		err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+		err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 					    mv88e6390_serdes_regs[i], &reg);
 		if (!err)
 			p[i] = reg;
@@ -1365,6 +1371,7 @@ int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
 	u16 ctrl, reg;
 	int err;
 	int i;
+	int lane;
 
 	err = mv88e6352_g2_scratch_port_has_serdes(chip, port);
 	if (err <= 0)
@@ -1381,7 +1388,8 @@ int mv88e6352_serdes_set_tx_amplitude(struct mv88e6xxx_chip *chip, int port,
 	if (!found)
 		return -EINVAL;
 
-	err = mv88e6352_serdes_read(chip, MV88E6352_SERDES_SPEC_CTRL2, &ctrl);
+	lane = mv88e6xxx_serdes_get_lane(chip, port);
+	err = mv88e6xxx_serdes_read(chip, lane, 0, MV88E6352_SERDES_SPEC_CTRL2, &ctrl);
 	if (err)
 		return err;
 
@@ -1397,7 +1405,7 @@ static int mv88e6393x_serdes_power_lane(struct mv88e6xxx_chip *chip, int lane,
 	u16 reg;
 	int err;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6393X_SERDES_CTRL1, &reg);
 	if (err)
 		return err;
@@ -1426,7 +1434,7 @@ static int mv88e6393x_serdes_erratum_4_6(struct mv88e6xxx_chip *chip, int lane)
 	 * It seems that after this workaround the SERDES is automatically
 	 * powered up (the bit is cleared), so power it down.
 	 */
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6393X_SERDES_POC, &reg);
 	if (err)
 		return err;
@@ -1472,14 +1480,14 @@ static int mv88e6393x_serdes_erratum_4_8(struct mv88e6xxx_chip *chip, int lane)
 	 * Workaround is to write SERDES register 4.F074.14=1 for only those
 	 * modes and 0 in all other modes.
 	 */
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6393X_SERDES_POC, &pcs);
 	if (err)
 		return err;
 
 	pcs &= MV88E6393X_SERDES_POC_PCS_MASK;
 
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6393X_ERRATA_4_8_REG, &reg);
 	if (err)
 		return err;
@@ -1523,7 +1531,7 @@ static int mv88e6393x_serdes_erratum_5_2(struct mv88e6xxx_chip *chip, int lane,
 		return 0;
 
 	for (i = 0; i < ARRAY_SIZE(fixes); ++i) {
-		err = mv88e6390_serdes_read(chip, lane, fixes[i].dev,
+		err = mv88e6xxx_serdes_read(chip, lane, fixes[i].dev,
 					    fixes[i].reg, &reg);
 		if (err)
 			return err;
@@ -1563,7 +1571,7 @@ static int mv88e6393x_serdes_fix_2500basex_an(struct mv88e6xxx_chip *chip,
 	 * To avoid this, change PCS mode back to 2500base-x when disabling
 	 * SerDes from 2500base-x mode.
 	 */
-	err = mv88e6390_serdes_read(chip, lane, MDIO_MMD_PHYXS,
+	err = mv88e6xxx_serdes_read(chip, lane, MDIO_MMD_PHYXS,
 				    MV88E6393X_SERDES_POC, &reg);
 	if (err)
 		return err;
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index e245687ddb1d..47ddd9d26c92 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -137,6 +137,10 @@ int mv88e6352_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 				 int lane, int speed, int duplex);
 int mv88e6390_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 				 int lane, int speed, int duplex);
+int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val);
+int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val);
 unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
 					  int port);
 unsigned int mv88e6390_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
@@ -213,6 +217,15 @@ static inline int mv88e6xxx_serdes_power_down(struct mv88e6xxx_chip *chip,
 	return chip->info->ops->serdes_power(chip, port, lane, false);
 }
 
+static inline int mv88e6xxx_serdes_read(struct mv88e6xxx_chip *chip, int lane,
+					int device, int reg, u16 *val)
+{
+	if (!chip->info->ops->serdes_read)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->serdes_read(chip, lane, device, reg, val);
+}
+
 static inline unsigned int
 mv88e6xxx_serdes_irq_mapping(struct mv88e6xxx_chip *chip, int port)
 {
-- 
2.41.0

