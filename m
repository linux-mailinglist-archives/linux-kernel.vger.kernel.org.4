Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A28D7145E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 10:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjE2IDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 04:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbjE2ICs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 04:02:48 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050BDB8;
        Mon, 29 May 2023 01:02:41 -0700 (PDT)
X-GND-Sasl: alexis.lothore@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1685347360;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wLlejYnnlPpBsffXf/fqkjKT1olZBXAXWvGAEO2awd4=;
        b=Te43Orz2z8IC9dhpM7xfaPHV15Y1nm2PZHzL43g5DOPUSRH6tzt1Xfl40UDY0Vpkx2/LQ3
        L4s1dAV92jbpaFH8GD1KhvQfDEt6zyy4ZQseWX+Js5z+K0LgsRdpZ/VUxOePFMRENvjsn/
        DUGNNzH+9wnMM2YFBLrh/sWoSs8VBnrDYNm/0kTCsgiqmVCPfOdzsxnOSGJh2yUYM7NzSz
        jhDX4fHW0cW5K94weeZvW1wP+CdDkbB2oPIw8Fb7sMtfeCZjk5dmLywIIZH2moh0p5leax
        r9MrXZ2Sih6NFv6VdgfLr3+W+xRyI3rX++7hZPuk3H9Q6ptvPRI+Ztoore0ejQ==
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
X-GND-Sasl: alexis.lothore@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4F4406000F;
        Mon, 29 May 2023 08:02:39 +0000 (UTC)
From:   =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
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
Cc:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        paul.arola@telus.com, scott.roberts@telus.com,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        =?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH net-next v4 4/7] net: dsa: mv88e6xxx: add field to specify internal phys layout
Date:   Mon, 29 May 2023 10:02:43 +0200
Message-Id: <20230529080246.82953-5-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230529080246.82953-1-alexis.lothore@bootlin.com>
References: <20230529080246.82953-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mv88e6xxx currently assumes that switch equipped with internal phys have
those phys mapped contiguously starting from port 0 (see
mv88e6xxx_phy_is_internal). However, some switches have internal PHYs but
NOT starting from port 0. For example 88e6393X, 88E6193X and 88E6191X have
integrated PHYs available on ports 1 to 8
To properly support this offset, add a new field to allow specifying an
internal PHYs layout. If field is not set, default layout is assumed (start
at port 0)

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes since v3:
- fix SoB
- add reviewed-by tag

Changes since v2:
- move start/end computation out of for-loop
- remove whitespace
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 4 +++-
 drivers/net/dsa/mv88e6xxx/chip.h    | 5 +++++
 drivers/net/dsa/mv88e6xxx/global2.c | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 1b5a05f118b4..c967259fcadd 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -465,7 +465,9 @@ static int mv88e6xxx_port_setup_mac(struct mv88e6xxx_chip *chip, int port,
 
 static int mv88e6xxx_phy_is_internal(struct mv88e6xxx_chip *chip, int port)
 {
-	return port < chip->info->num_internal_phys;
+	return port >= chip->info->internal_phys_offset &&
+		port < chip->info->num_internal_phys +
+			chip->info->internal_phys_offset;
 }
 
 static int mv88e6xxx_port_ppu_updates(struct mv88e6xxx_chip *chip, int port)
diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index da6e1339f809..eca51946c100 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -167,6 +167,11 @@ struct mv88e6xxx_info {
 
 	/* Supports PTP */
 	bool ptp_support;
+
+	/* Internal PHY start index. 0 means that internal PHYs range starts at
+	 * port 0, 1 means internal PHYs range starts at port 1, etc
+	 */
+	unsigned int internal_phys_offset;
 };
 
 struct mv88e6xxx_atu_entry {
diff --git a/drivers/net/dsa/mv88e6xxx/global2.c b/drivers/net/dsa/mv88e6xxx/global2.c
index 615896893076..937a01f2ba75 100644
--- a/drivers/net/dsa/mv88e6xxx/global2.c
+++ b/drivers/net/dsa/mv88e6xxx/global2.c
@@ -1196,9 +1196,12 @@ int mv88e6xxx_g2_irq_setup(struct mv88e6xxx_chip *chip)
 int mv88e6xxx_g2_irq_mdio_setup(struct mv88e6xxx_chip *chip,
 				struct mii_bus *bus)
 {
+	int phy_start = chip->info->internal_phys_offset;
+	int phy_end = chip->info->internal_phys_offset +
+		      chip->info->num_internal_phys;
 	int phy, irq;
 
-	for (phy = 0; phy < chip->info->num_internal_phys; phy++) {
+	for (phy = phy_start; phy < phy_end; phy++) {
 		irq = irq_find_mapping(chip->g2_irq.domain, phy);
 		if (irq < 0)
 			return irq;
-- 
2.40.1

