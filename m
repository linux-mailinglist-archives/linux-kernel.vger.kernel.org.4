Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D88F470992B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 16:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjESONY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 10:13:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbjESONN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 10:13:13 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A7A1B5;
        Fri, 19 May 2023 07:13:11 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id B54E3E0009;
        Fri, 19 May 2023 14:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684505590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GD3HpwdAPAJ9CBxKjHowieAW3F05Ue1lxFDSEk1GFi4=;
        b=BiJmN6iK7DXgwcIX3bFx5T/ySFmsH7KClO1G2ukKGPIfP391jZOPBqwPPGtGNQ00WgjveB
        Btv82zQff5ZZxtYR+XV+iU3dqozpREEXcP9V4c96LoPMzSTPUp+sSqF2oPj1PZpg4qv5wu
        xLov/P/qAIudxny+4gpYmwEGqqKL2/Bs/j+z7u2jHAmIeL26EKdIy0jHlEFILIIKJsS0gR
        Jfb9+GLRoeNMdE79utfpbGLOsd0HJnqZhsqK5NeSLs7dTengGDJ8IYQ/KiiCP+qsApCbHO
        dM08w6NeSpdsx9souR5MzaO9su8BBo4+1jxNKnP5QjafEWr6bezWbvC6w56dPw==
From:   alexis.lothore@bootlin.com
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        paul.arola@telus.com, scott.roberts@telus.com,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH net-next v2 6/7] net: dsa: mv88e6xxx: pass mv88e6xxx_chip structure to port_max_speed_mode
Date:   Fri, 19 May 2023 16:13:02 +0200
Message-Id: <20230519141303.245235-7-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519141303.245235-1-alexis.lothore@bootlin.com>
References: <20230519141303.245235-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Some switches families have minor differences on supported link speed for
ports. Instead of redefining a new port_max_speed_mode for each different
configuration, allow to pass mv88e6xxx_chip structure to allow
differentiating those chips by known chip id

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c |  2 +-
 drivers/net/dsa/mv88e6xxx/chip.h |  3 ++-
 drivers/net/dsa/mv88e6xxx/port.c | 12 ++++++++----
 drivers/net/dsa/mv88e6xxx/port.h | 12 ++++++++----
 4 files changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f15ca17bf9e2..0e6267193ac1 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3311,7 +3311,7 @@ static int mv88e6xxx_setup_port(struct mv88e6xxx_chip *chip, int port)
 		caps = pl_config.mac_capabilities;
 
 		if (chip->info->ops->port_max_speed_mode)
-			mode = chip->info->ops->port_max_speed_mode(port);
+			mode = chip->info->ops->port_max_speed_mode(chip, port);
 		else
 			mode = PHY_INTERFACE_MODE_NA;
 
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index eca51946c100..dd7c8880e987 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -518,7 +518,8 @@ struct mv88e6xxx_ops {
 				     int speed, int duplex);
 
 	/* What interface mode should be used for maximum speed? */
-	phy_interface_t (*port_max_speed_mode)(int port);
+	phy_interface_t (*port_max_speed_mode)(struct mv88e6xxx_chip *chip,
+					       int port);
 
 	int (*port_tag_remap)(struct mv88e6xxx_chip *chip, int port);
 
diff --git a/drivers/net/dsa/mv88e6xxx/port.c b/drivers/net/dsa/mv88e6xxx/port.c
index f79cf716c541..66f1b40b4e96 100644
--- a/drivers/net/dsa/mv88e6xxx/port.c
+++ b/drivers/net/dsa/mv88e6xxx/port.c
@@ -342,7 +342,8 @@ int mv88e6341_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 					       duplex);
 }
 
-phy_interface_t mv88e6341_port_max_speed_mode(int port)
+phy_interface_t mv88e6341_port_max_speed_mode(struct mv88e6xxx_chip *chip,
+					      int port)
 {
 	if (port == 5)
 		return PHY_INTERFACE_MODE_2500BASEX;
@@ -381,7 +382,8 @@ int mv88e6390_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 					       duplex);
 }
 
-phy_interface_t mv88e6390_port_max_speed_mode(int port)
+phy_interface_t mv88e6390_port_max_speed_mode(struct mv88e6xxx_chip *chip,
+					      int port)
 {
 	if (port == 9 || port == 10)
 		return PHY_INTERFACE_MODE_2500BASEX;
@@ -403,7 +405,8 @@ int mv88e6390x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 					       duplex);
 }
 
-phy_interface_t mv88e6390x_port_max_speed_mode(int port)
+phy_interface_t mv88e6390x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
+					       int port)
 {
 	if (port == 9 || port == 10)
 		return PHY_INTERFACE_MODE_XAUI;
@@ -500,7 +503,8 @@ int mv88e6393x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 	return 0;
 }
 
-phy_interface_t mv88e6393x_port_max_speed_mode(int port)
+phy_interface_t mv88e6393x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
+					       int port)
 {
 	if (port == 0 || port == 9 || port == 10)
 		return PHY_INTERFACE_MODE_10GBASER;
diff --git a/drivers/net/dsa/mv88e6xxx/port.h b/drivers/net/dsa/mv88e6xxx/port.h
index aec9d4fd20e3..3c9fc17abdd2 100644
--- a/drivers/net/dsa/mv88e6xxx/port.h
+++ b/drivers/net/dsa/mv88e6xxx/port.h
@@ -359,10 +359,14 @@ int mv88e6390x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 int mv88e6393x_port_set_speed_duplex(struct mv88e6xxx_chip *chip, int port,
 				     int speed, int duplex);
 
-phy_interface_t mv88e6341_port_max_speed_mode(int port);
-phy_interface_t mv88e6390_port_max_speed_mode(int port);
-phy_interface_t mv88e6390x_port_max_speed_mode(int port);
-phy_interface_t mv88e6393x_port_max_speed_mode(int port);
+phy_interface_t mv88e6341_port_max_speed_mode(struct mv88e6xxx_chip *chip,
+					      int port);
+phy_interface_t mv88e6390_port_max_speed_mode(struct mv88e6xxx_chip *chip,
+					      int port);
+phy_interface_t mv88e6390x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
+					       int port);
+phy_interface_t mv88e6393x_port_max_speed_mode(struct mv88e6xxx_chip *chip,
+					       int port);
 
 int mv88e6xxx_port_set_state(struct mv88e6xxx_chip *chip, int port, u8 state);
 
-- 
2.40.1

