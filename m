Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEAD738FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231861AbjFUTNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjFUTNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:13:22 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1FF1726;
        Wed, 21 Jun 2023 12:13:20 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-98802908fedso622081666b.1;
        Wed, 21 Jun 2023 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374798; x=1689966798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ly5NA5faFK7hsekbAil9PR1Mb1J+eZ8ww8EYkdUuAYk=;
        b=ohIV+xcvhtJ9V+bFsY1G8VvtTVHiVBSKjRnyfLLldHlU0RV8XAnNH6Vr5LikovoGjC
         GaIJYiV8k7xZT3PAk7Cl88wvmnu9xTqRLRTT1mAMdyAv2+4BxVvtI0/nuSsFqz2BTpPA
         5zGJDYl+ndXNkCdJVXp1dOMXjWYs49y8VdPZBeEAS0VKJf9TmO4X2+3pI/nzt1m7/zE9
         Xc84NnXkofMiT3mYXpgSG436JwIQOl9LdAVOf5ZG3Gk8U6FDquUVjS7oBDQUw6850z21
         HYO30dtb2hJ+lT3Jp/9/rO/betmmiF5534Wh9BDkc0buTo4ilACj+78RXL1bikS9mu96
         Nd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374798; x=1689966798;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ly5NA5faFK7hsekbAil9PR1Mb1J+eZ8ww8EYkdUuAYk=;
        b=H++saNbZ3hUziCMPtkdvfAqrxvXLe/VlwlzKYqHkEhlKF+610N4l6Rqn16Zn3It5ap
         ZHEIhyPZS/RQiPKqp29e7J4F3kO7Y2luDLTveiKbRFmpIgHBUX7MGHJuweB4kVjlKVtS
         I1Nnys9Ajvcn/Gwxy7cPz3UmFIBcVBf2Xl5+vOelnRzdBtB3UW6mwhX3fZfJdZY8PjEs
         pgh3nqql7EhBVyGAN2zXX+MxXQYD5S3FmfjuG1UBQ+LSLr36nRStLsapeeNUZuiSytzd
         e6O5chUC1v17tp4xR5BXE9HRSU0XlyXS48lwJEPRnoCa9CNAjlePKwVEbaEqNkVpeNnb
         LLvg==
X-Gm-Message-State: AC+VfDy9GQWgc8Qwxz6O7FKVA0BNh4NGkhaGTbYcXVl1LobCdEdo5zu/
        InkVtPoWg+94WOXO9WXGtBUQIPG2amQr2w==
X-Google-Smtp-Source: ACHHUZ691yKcyWe84w2PlnciF6EL1FZ6aFiD1OErHCXPDghGzybmoA8JdwIYQ+uYHnXHcIlOzYLjww==
X-Received: by 2002:a17:907:9283:b0:986:d833:3cf9 with SMTP id bw3-20020a170907928300b00986d8333cf9mr12146225ejc.39.1687374798208;
        Wed, 21 Jun 2023 12:13:18 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id gu1-20020a170906f28100b009829a5ae8b3sm3539562ejb.64.2023.06.21.12.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:13:17 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linus.walleij@linaro.org, Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/6] net: dsa: vsc73xx: convert to PHYLINK
Date:   Wed, 21 Jun 2023 21:12:56 +0200
Message-Id: <20230621191302.1405623-1-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces the adjust_link api with the phylink apis that provide
equivalent functionality.

The remaining functionality from the adjust_link is now covered in the
phylink_mac_link_* and phylink_mac_config.

Removes:
.adjust_link
Adds:
.phylink_get_caps
.phylink_mac_link_down
.phylink_mac_link_up
.phylink_mac_link_down

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 179 ++++++++++++++-----------
 1 file changed, 99 insertions(+), 80 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index ae55167ce0a6..e853b57b0bc8 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -39,6 +39,7 @@
 #define VSC73XX_BLOCK_SYSTEM	0x7 /* Only subblock 0 */
 
 #define CPU_PORT	6 /* CPU port */
+#define VSC73XX_TABLE_ATTEMPTS	10
 
 /* MAC Block registers */
 #define VSC73XX_MAC_CFG		0x00
@@ -715,8 +716,7 @@ static void vsc73xx_init_port(struct vsc73xx *vsc, int port)
 }
 
 static void vsc73xx_adjust_enable_port(struct vsc73xx *vsc,
-				       int port, struct phy_device *phydev,
-				       u32 initval)
+				       int port, u32 initval)
 {
 	u32 val = initval;
 	u8 seed;
@@ -754,12 +754,40 @@ static void vsc73xx_adjust_enable_port(struct vsc73xx *vsc,
 			    VSC73XX_MAC_CFG_TX_EN | VSC73XX_MAC_CFG_RX_EN);
 }
 
-static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
-				struct phy_device *phydev)
+static void vsc73xx_phylink_get_caps(struct dsa_switch *ds, int port,
+				     struct phylink_config *config)
 {
-	struct vsc73xx *vsc = ds->priv;
-	u32 val;
+	/* This switch only supports full-duplex at 1Gbps */
+	config->mac_capabilities = MAC_10 | MAC_100 | MAC_1000FD |
+				   MAC_ASYM_PAUSE | MAC_SYM_PAUSE;
 
+	if (port == CPU_PORT) {
+		__set_bit(PHY_INTERFACE_MODE_RGMII,
+			  config->supported_interfaces);
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+	} else {
+		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+			  config->supported_interfaces);
+		/* Compatibility for phylib's default interface type when the
+		 * phy-mode property is absent
+		 */
+		__set_bit(PHY_INTERFACE_MODE_GMII,
+			  config->supported_interfaces);
+	}
+
+	/* This driver does not make use of the speed, duplex, pause or the
+	 * advertisement in its mac_config, so it is safe to mark this driver
+	 * as non-legacy.
+	 */
+	config->legacy_pre_march2020 = false;
+}
+
+static void vsc73xx_phylink_mac_config(struct dsa_switch *ds, int port,
+				       unsigned int mode,
+				       const struct phylink_link_state *state)
+{
+	struct vsc73xx *vsc = ds->priv;
 	/* Special handling of the CPU-facing port */
 	if (port == CPU_PORT) {
 		/* Other ports are already initialized but not this one */
@@ -775,104 +803,92 @@ static void vsc73xx_adjust_link(struct dsa_switch *ds, int port,
 			      VSC73XX_ADVPORTM_ENA_GTX |
 			      VSC73XX_ADVPORTM_DDR_MODE);
 	}
+}
 
-	/* This is the MAC confiuration that always need to happen
-	 * after a PHY or the CPU port comes up or down.
-	 */
-	if (!phydev->link) {
-		int maxloop = 10;
+static void vsc73xx_phylink_mac_link_down(struct dsa_switch *ds, int port,
+					  unsigned int mode,
+					  phy_interface_t interface)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
 
-		dev_dbg(vsc->dev, "port %d: went down\n",
-			port);
+	int maxloop = VSC73XX_TABLE_ATTEMPTS;
 
-		/* Disable RX on this port */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
-				    VSC73XX_MAC_CFG,
-				    VSC73XX_MAC_CFG_RX_EN, 0);
+	dev_dbg(vsc->dev, "port %d: went down\n",
+		port);
 
-		/* Discard packets */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_ARBDISC, BIT(port), BIT(port));
+	/* Disable RX on this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+			    VSC73XX_MAC_CFG,
+			    VSC73XX_MAC_CFG_RX_EN, 0);
+
+	/* Discard packets */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_ARBDISC, BIT(port), BIT(port));
 
-		/* Wait until queue is empty */
+	/* Wait until queue is empty */
+	vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
+		     VSC73XX_ARBEMPTY, &val);
+	while (!(val & BIT(port))) {
+		msleep(1);
 		vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
 			     VSC73XX_ARBEMPTY, &val);
-		while (!(val & BIT(port))) {
-			msleep(1);
-			vsc73xx_read(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				     VSC73XX_ARBEMPTY, &val);
-			if (--maxloop == 0) {
-				dev_err(vsc->dev,
-					"timeout waiting for block arbiter\n");
-				/* Continue anyway */
-				break;
-			}
+		if (--maxloop == 0) {
+			dev_err(vsc->dev,
+				"timeout waiting for block arbiter\n");
+			/* Continue anyway */
+			break;
 		}
+	}
 
-		/* Put this port into reset */
-		vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
-			      VSC73XX_MAC_CFG_RESET);
-
-		/* Accept packets again */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_ARBDISC, BIT(port), 0);
+	/* Put this port into reset */
+	vsc73xx_write(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_MAC_CFG,
+		      VSC73XX_MAC_CFG_RESET);
 
-		/* Allow backward dropping of frames from this port */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
-				    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
+	/* Accept packets again */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_ARBDISC, BIT(port), 0);
 
-		/* Receive mask (disable forwarding) */
-		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-				    VSC73XX_RECVMASK, BIT(port), 0);
+	/* Allow backward dropping of frames from this port */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ARBITER, 0,
+			    VSC73XX_SBACKWDROP, BIT(port), BIT(port));
 
-		return;
-	}
+	/* Receive mask (disable forwarding) */
+	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			    VSC73XX_RECVMASK, BIT(port), 0);
+}
 
-	/* Figure out what speed was negotiated */
-	if (phydev->speed == SPEED_1000) {
-		dev_dbg(vsc->dev, "port %d: 1000 Mbit mode full duplex\n",
-			port);
+static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
+					unsigned int mode,
+					phy_interface_t interface,
+					struct phy_device *phydev,
+					int speed, int duplex,
+					bool tx_pause, bool rx_pause)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u32 val;
 
+	switch (speed) {
+	case SPEED_1000:
 		/* Set up default for internal port or external RGMII */
-		if (phydev->interface == PHY_INTERFACE_MODE_RGMII)
+		if (interface == PHY_INTERFACE_MODE_RGMII)
 			val = VSC73XX_MAC_CFG_1000M_F_RGMII;
 		else
 			val = VSC73XX_MAC_CFG_1000M_F_PHY;
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else if (phydev->speed == SPEED_100) {
-		if (phydev->duplex == DUPLEX_FULL) {
-			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 100 Mbit full duplex mode\n",
-				port);
-		} else {
-			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 100 Mbit half duplex mode\n",
-				port);
-		}
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else if (phydev->speed == SPEED_10) {
-		if (phydev->duplex == DUPLEX_FULL) {
+		break;
+	case SPEED_100:
+	case SPEED_10:
+		if (duplex == DUPLEX_FULL)
 			val = VSC73XX_MAC_CFG_100_10M_F_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 10 Mbit full duplex mode\n",
-				port);
-		} else {
+		else
 			val = VSC73XX_MAC_CFG_100_10M_H_PHY;
-			dev_dbg(vsc->dev,
-				"port %d: 10 Mbit half duplex mode\n",
-				port);
-		}
-		vsc73xx_adjust_enable_port(vsc, port, phydev, val);
-	} else {
-		dev_err(vsc->dev,
-			"could not adjust link: unknown speed\n");
+		break;
 	}
 
 	/* Enable port (forwarding) in the receieve mask */
 	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
 			    VSC73XX_RECVMASK, BIT(port), BIT(port));
+	vsc73xx_adjust_enable_port(vsc, port, val);
 }
 
 static int vsc73xx_port_enable(struct dsa_switch *ds, int port,
@@ -1043,7 +1059,10 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.setup = vsc73xx_setup,
 	.phy_read = vsc73xx_phy_read,
 	.phy_write = vsc73xx_phy_write,
-	.adjust_link = vsc73xx_adjust_link,
+	.phylink_get_caps = vsc73xx_phylink_get_caps,
+	.phylink_mac_config = vsc73xx_phylink_mac_config,
+	.phylink_mac_link_down = vsc73xx_phylink_mac_link_down,
+	.phylink_mac_link_up = vsc73xx_phylink_mac_link_up,
 	.get_strings = vsc73xx_get_strings,
 	.get_ethtool_stats = vsc73xx_get_ethtool_stats,
 	.get_sset_count = vsc73xx_get_sset_count,
-- 
2.34.1

