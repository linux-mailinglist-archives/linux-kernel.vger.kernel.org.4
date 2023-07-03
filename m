Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27DA1745FCF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbjGCP0s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjGCP0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:26:46 -0400
Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCBFE58
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 08:26:44 -0700 (PDT)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2023070315264213e82ac5c40c75b1c8
        for <linux-kernel@vger.kernel.org>;
        Mon, 03 Jul 2023 17:26:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=2C7Jb3Bpb/V3uMa0SnRT1zOU30LU1+kgf+2BdMTB4Bs=;
 b=VYSdB0sKL1CzSzgny3f6oQ5l1zmCH+5Ft+xdAJM48epFlTcrtIovvx5CH44BokaDgGbVb/
 Qparvi12ltQMSAOXklARVSYS6s+dYq3tZ72jGWXOTfmIvRdW4XMqxUE4F4MqwL0yOOLm4t72
 H+1YntpC2MQ0S3k3pBrjsjz+32jdk=;
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
Subject: [PATCH 3/3] net: dsa: mv88e632x: Add SERDES ops
Date:   Mon,  3 Jul 2023 17:26:09 +0200
Message-ID: <20230703152611.420381-4-michael.haener@siemens.com>
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

The 88e632x family has several SERDES 100/1000 blocks. By adding these
operations, these functionalities can be used.

Signed-off-by: Michael Haener <michael.haener@siemens.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c   | 32 ++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.c | 39 ++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.h |  9 +++++++
 3 files changed, 80 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 54e99cfb17c1..b889f08b9c3f 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -5197,10 +5197,26 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.serdes_get_lane = mv88e6320_serdes_get_lane,
+	.serdes_pcs_get_state = mv88e6352_serdes_pcs_get_state,
+	.serdes_pcs_config = mv88e6352_serdes_pcs_config,
+	.serdes_pcs_an_restart = mv88e6352_serdes_pcs_an_restart,
+	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
+	.serdes_read = mv88e6320_serdes_read,
+	.serdes_write = mv88e6320_serdes_write,
+	.serdes_power = mv88e6352_serdes_power,
+	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
+	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
+	.serdes_irq_status = mv88e6352_serdes_irq_status,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.serdes_get_sset_count = mv88e6352_serdes_get_sset_count,
+	.serdes_get_strings = mv88e6352_serdes_get_strings,
+	.serdes_get_stats = mv88e6352_serdes_get_stats,
+	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
+	.serdes_get_regs = mv88e6352_serdes_get_regs,
 };
 
 static const struct mv88e6xxx_ops mv88e6321_ops = {
@@ -5243,10 +5259,26 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.serdes_get_lane = mv88e6320_serdes_get_lane,
+	.serdes_pcs_get_state = mv88e6352_serdes_pcs_get_state,
+	.serdes_pcs_config = mv88e6352_serdes_pcs_config,
+	.serdes_pcs_an_restart = mv88e6352_serdes_pcs_an_restart,
+	.serdes_pcs_link_up = mv88e6352_serdes_pcs_link_up,
+	.serdes_read = mv88e6320_serdes_read,
+	.serdes_write = mv88e6320_serdes_write,
+	.serdes_power = mv88e6352_serdes_power,
+	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
+	.serdes_irq_enable = mv88e6352_serdes_irq_enable,
+	.serdes_irq_status = mv88e6352_serdes_irq_status,
 	.gpio_ops = &mv88e6352_gpio_ops,
 	.avb_ops = &mv88e6352_avb_ops,
 	.ptp_ops = &mv88e6352_ptp_ops,
 	.phylink_get_caps = mv88e6185_phylink_get_caps,
+	.serdes_get_sset_count = mv88e6352_serdes_get_sset_count,
+	.serdes_get_strings = mv88e6352_serdes_get_strings,
+	.serdes_get_stats = mv88e6352_serdes_get_stats,
+	.serdes_get_regs_len = mv88e6352_serdes_get_regs_len,
+	.serdes_get_regs = mv88e6352_serdes_get_regs,
 };
 
 static const struct mv88e6xxx_ops mv88e6341_ops = {
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.c b/drivers/net/dsa/mv88e6xxx/serdes.c
index 7b64e30600b9..8e8f264429de 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.c
+++ b/drivers/net/dsa/mv88e6xxx/serdes.c
@@ -17,6 +17,45 @@
 #include "port.h"
 #include "serdes.h"
 
+int mv88e6320_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val)
+{
+	return mv88e6xxx_phy_page_read(chip, lane,
+				       MV88E6320_SERDES_PAGE_FIBER,
+				       reg, val);
+}
+
+int mv88e6320_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 val)
+{
+	return mv88e6xxx_phy_page_write(chip, lane,
+					MV88E6320_SERDES_PAGE_FIBER,
+					reg, val);
+}
+
+int mv88e6320_serdes_get_lane(struct mv88e6xxx_chip *chip, int port)
+{
+	u8 cmode = chip->ports[port].cmode;
+	int lane = -ENODEV;
+
+	switch (port) {
+	case 0:
+		if (cmode == MV88E6XXX_PORT_STS_CMODE_100BASEX ||
+		    cmode == MV88E6XXX_PORT_STS_CMODE_1000BASEX ||
+		    cmode == MV88E6XXX_PORT_STS_CMODE_SGMII)
+			lane = MV88E6320_PORT0_LANE;
+		break;
+	case 1:
+		if (cmode == MV88E6XXX_PORT_STS_CMODE_100BASEX ||
+		    cmode == MV88E6XXX_PORT_STS_CMODE_1000BASEX ||
+		    cmode == MV88E6XXX_PORT_STS_CMODE_SGMII)
+			lane = MV88E6320_PORT1_LANE;
+		break;
+	}
+
+	return lane;
+}
+
 int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane,
 			  int device, int reg, u16 *val)
 {
diff --git a/drivers/net/dsa/mv88e6xxx/serdes.h b/drivers/net/dsa/mv88e6xxx/serdes.h
index e71cddf63eba..5af8a1046b69 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -12,6 +12,10 @@
 
 #include "chip.h"
 
+#define MV88E6320_PORT0_LANE		0x0c
+#define MV88E6320_PORT1_LANE		0x0d
+#define MV88E6320_SERDES_PAGE_FIBER	0x01
+
 #define MV88E6352_ADDR_SERDES		0x0f
 #define MV88E6352_SERDES_PAGE_FIBER	0x01
 #define MV88E6352_SERDES_IRQ		0x0b
@@ -108,6 +112,7 @@
 #define MV88E6393X_ERRATA_4_8_BIT		BIT(14)
 
 int mv88e6185_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
+int mv88e6320_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6352_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
@@ -137,10 +142,14 @@ int mv88e6352_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 				 int lane, int speed, int duplex);
 int mv88e6390_serdes_pcs_link_up(struct mv88e6xxx_chip *chip, int port,
 				 int lane, int speed, int duplex);
+int mv88e6320_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val);
 int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
 int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
+int mv88e6320_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
+			   int reg, u16 val);
 int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
 			   int reg, u16 val);
 int mv88e6390_serdes_write(struct mv88e6xxx_chip *chip, int lane, int device,
-- 
2.41.0

