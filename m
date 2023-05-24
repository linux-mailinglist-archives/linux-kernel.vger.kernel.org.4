Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9345470F71C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 15:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbjEXNBd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 09:01:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234865AbjEXNBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 09:01:22 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FEA99;
        Wed, 24 May 2023 06:01:20 -0700 (PDT)
Received: (Authenticated sender: alexis.lothore@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id D45D760010;
        Wed, 24 May 2023 13:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1684933279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fENFV6k0hW/KI0XKc6WbSD1SpjYijhd5O6JA6P01zNU=;
        b=TW6l16kpLoESOHBtWLwy/VwDog9MtFmtcc+Q8vYNsIzatWoKgrDLlkcFuSZ/EwtctEoDiW
        6cvli5orWg3tbqhflgbcyHzXra+Qcr02z/MlbMP7+Mghv02zaIROJiEtEdSzsWTW9UYJfq
        81vkxWcTe8NdPsySbN6CdQofUfOdvnGsI9dwx8pPmbYPVgKr0+9iHqctuDiojIMgc1ZXWq
        zNZofO3HlckoYHi1s5RsL0hgbgXFerwNGbdu02NWZ9k3K4BAJEY3fMsE8VWD6yqnudSycW
        P2G28Rxou9qx0IYjhH9NF9qP4xOMV3F0gvva9gLZ4oyIgKygd+UMo5haduRS1A==
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
Subject: [PATCH net-next v3 4/7] net: dsa: mv88e6xxx: add field to specify internal phys layout
Date:   Wed, 24 May 2023 15:01:24 +0200
Message-Id: <20230524130127.268201-5-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230524130127.268201-1-alexis.lothore@bootlin.com>
References: <20230524130127.268201-1-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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

---
Changes since v2:
- move start/end computation out of for loop
- remove whitespace

Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
---
 drivers/net/dsa/mv88e6xxx/chip.c    | 4 +++-
 drivers/net/dsa/mv88e6xxx/chip.h    | 5 +++++
 drivers/net/dsa/mv88e6xxx/global2.c | 5 ++++-
 3 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index c812e52bb5b7..2716d17c5c49 100644
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

