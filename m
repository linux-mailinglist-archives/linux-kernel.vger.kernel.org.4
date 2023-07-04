Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D641746A3D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbjGDHAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 03:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbjGDHAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:00:51 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 00:00:45 PDT
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82D5E47
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jul 2023 00:00:45 -0700 (PDT)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 202307040659418aaa3a3a2f487e16f4
        for <linux-kernel@vger.kernel.org>;
        Tue, 04 Jul 2023 08:59:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=michael.haener@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tFUdaM7fpMZCMiSMA7Y3KWuA2AF40gFd8plul349lJQ=;
 b=ldbvFvOMewpoK47CJdIVC3LDItmhxEq16kzFM9K32tR+k4yNi73CpyPiTwXt3gRHVgvhxY
 ME384voVrIel2nPeS+jVk+NpjyqwBkYMw7SLinqodssS8Mzx8bI0xFjgkq//paFUo0lQRDQk
 cHFFatIK/JdwDOGp9OuvNggIdnZb0=;
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
Subject: [PATCH v2 3/3] net: dsa: mv88e632x: Add SERDES ops
Date:   Tue,  4 Jul 2023 08:59:06 +0200
Message-ID: <20230704065916.132486-4-michael.haener@siemens.com>
In-Reply-To: <20230704065916.132486-1-michael.haener@siemens.com>
References: <20230704065916.132486-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-664519:519-21489:flowmailer
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
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
 drivers/net/dsa/mv88e6xxx/chip.c   | 18 ++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.c | 39 ++++++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/serdes.h |  9 +++++++
 3 files changed, 66 insertions(+)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 11b98546b938..9802a3608dc6 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4905,10 +4905,19 @@ static const struct mv88e6xxx_ops mv88e6320_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.serdes_get_lane = mv88e6320_serdes_get_lane,
+	.serdes_read = mv88e6320_serdes_read,
+	.serdes_write = mv88e6320_serdes_write,
+	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
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
@@ -4951,10 +4960,19 @@ static const struct mv88e6xxx_ops mv88e6321_ops = {
 	.reset = mv88e6352_g1_reset,
 	.vtu_getnext = mv88e6185_g1_vtu_getnext,
 	.vtu_loadpurge = mv88e6185_g1_vtu_loadpurge,
+	.serdes_get_lane = mv88e6320_serdes_get_lane,
+	.serdes_read = mv88e6320_serdes_read,
+	.serdes_write = mv88e6320_serdes_write,
+	.serdes_irq_mapping = mv88e6352_serdes_irq_mapping,
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
index b988d47ecbdd..411fe9ac421a 100644
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
+int mv88e6320_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
+			   u16 val)
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
index d3e83c674ef7..9dcc9e581c05 100644
--- a/drivers/net/dsa/mv88e6xxx/serdes.h
+++ b/drivers/net/dsa/mv88e6xxx/serdes.h
@@ -14,6 +14,10 @@
 
 struct phylink_link_state;
 
+#define MV88E6320_PORT0_LANE		0x0c
+#define MV88E6320_PORT1_LANE		0x0d
+#define MV88E6320_SERDES_PAGE_FIBER	0x01
+
 #define MV88E6352_ADDR_SERDES		0x0f
 #define MV88E6352_SERDES_PAGE_FIBER	0x01
 #define MV88E6352_SERDES_IRQ		0x0b
@@ -116,14 +120,19 @@ struct phylink_link_state;
 int mv88e6xxx_pcs_decode_state(struct device *dev, u16 bmsr, u16 lpa,
 			       u16 status, struct phylink_link_state *state);
 
+int mv88e6320_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6341_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6390x_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
 int mv88e6393x_serdes_get_lane(struct mv88e6xxx_chip *chip, int port);
+int mv88e6320_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
+			  int reg, u16 *val);
 int mv88e6352_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
 int mv88e6390_serdes_read(struct mv88e6xxx_chip *chip, int lane, int device,
 			  int reg, u16 *val);
+int mv88e6320_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
+			   u16 val);
 int mv88e6352_serdes_write(struct mv88e6xxx_chip *chip, int lane, int reg,
 			   u16 val);
 unsigned int mv88e6352_serdes_irq_mapping(struct mv88e6xxx_chip *chip,
-- 
2.41.0

