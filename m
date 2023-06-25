Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4FEA73D0AB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjFYLzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231688AbjFYLy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:54:56 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDAAE6B;
        Sun, 25 Jun 2023 04:54:51 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id 38308e7fff4ca-2b47a15ca10so33629171fa.1;
        Sun, 25 Jun 2023 04:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694090; x=1690286090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OALd4eb7UL8T5fpkRECjHOOzQFxYtFTTgkr+9lZkN8Q=;
        b=F4O5IztO6leg3x7gXZ7Z5Q/JgW/cuSVKlN5Qy+Ze7z0rjNahI83B6mnsstCoacvaIR
         Z+9y26PZRxoJrhybWPzU+WhEC6XTBvpwWHX9O7qaKUXn2dRAXtr2Epjp2RcYp2nbWshZ
         d3kz178Etkbnhplpuq1x9wmQX2geTpI1+eWGYV4LbIN88Oja10GWGv/tgg1iYMkd8xWM
         +i69h0Hk9gwcaykId70yYOJF4Ybgk5VXQ6mskihWFc+YgxhSStfoSNwtTT7Dvwd+tjUY
         ny+ebjOh7BNy6Y+OcT4wsyZQ+tYYLP0Qu5lJV4UlBurUm5ui6DDg+2etP9knquFpczEx
         ncYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694090; x=1690286090;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OALd4eb7UL8T5fpkRECjHOOzQFxYtFTTgkr+9lZkN8Q=;
        b=VrLr/KXL23JTqW2SP3ekUPobkRMEKLWjTWJBqgWe0diNFJigajFMWML8HlbR5UHxXT
         yQR2PNhpMfgCY6XIcsfBDP2nQWDQI3L9v1gVFx49EPprLt58ZVht4ukT/emk1UaQDauz
         fPfOnBbKYnjTCjsNJeVLBMk4de2zBzNpF34wGlXXukIKv6VlrBI1FjqgAhutq8KQ6ooG
         CCWbtlZ/LTdvOiZ/EbeQ9Tz3VGpHgTcEIRUT1Wnzy1lb4Pv3FlNRYEqzAJvuqMw/0NP3
         /Tzu8Y4rcOdAU5EMzhjcMlPK8ZxqVPpFLC/o7MEIJxH02Gk8E9ndRg8mShxiLptu8qIB
         BJmg==
X-Gm-Message-State: AC+VfDxVC1nvjkSj8/xMtqmt+d4ZAkNJMbKqwmV9dUIfGzltUGA5jss7
        4KObiIJx6s9YNWwrfbIRql5SCKaQRB/6Mg==
X-Google-Smtp-Source: ACHHUZ5I4noyBNS26MkTgQPpxBmaHYHG6mr+XqPurb/R43wD1yMa3SpcjKZpogO3NsoCa51CHn4y/w==
X-Received: by 2002:a2e:9dc4:0:b0:2b6:9ed2:f61c with SMTP id x4-20020a2e9dc4000000b002b69ed2f61cmr384700ljj.7.1687694089668;
        Sun, 25 Jun 2023 04:54:49 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9595000000b002b6993b9665sm416043ljh.65.2023.06.25.04.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 04:54:49 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     Pawel Dembicki <paweldembicki@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 3/7] net: dsa: vsc73xx: add port_stp_state_set function
Date:   Sun, 25 Jun 2023 13:53:38 +0200
Message-Id: <20230625115343.1603330-3-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230625115343.1603330-1-paweldembicki@gmail.com>
References: <20230625115343.1603330-1-paweldembicki@gmail.com>
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

This isn't fully functional implementation of 802.1D, but
port_stp_state_set is required for future tag8021q operations.

This implementation handle properly all states, but vsc 73xx don't
forward STP packets.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - fix kdoc

 drivers/net/dsa/vitesse-vsc73xx-core.c | 51 +++++++++++++++++++++++---
 drivers/net/dsa/vitesse-vsc73xx.h      |  2 +
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 221672b9e17f..f123ce2ed244 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -164,6 +164,10 @@
 #define VSC73XX_AGENCTRL	0xf0
 #define VSC73XX_CAPRST		0xff
 
+#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
+#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
+#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -620,15 +624,17 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GMIIDELAY,
 		      VSC73XX_GMIIDELAY_GMII0_GTXDELAY_2_0_NS |
 		      VSC73XX_GMIIDELAY_GMII0_RXDELAY_2_0_NS);
-	/* Enable reception of frames on all ports */
-	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_RECVMASK,
-		      0x5f);
 	/* IP multicast flood mask (table 144) */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_ANALYZER, 0, VSC73XX_IFLODMSK,
 		      0xff);
 
 	mdelay(50);
 
+	/*configure forward map to CPU <-> port only*/
+	for (i = 0; i < vsc->ds->num_ports; i++)
+		vsc->forward_map[i] = VSC73XX_SRCMASKS_PORTS_MASK & BIT(CPU_PORT);
+	vsc->forward_map[CPU_PORT] = VSC73XX_SRCMASKS_PORTS_MASK & ~BIT(CPU_PORT);
+
 	/* Release reset from the internal PHYs */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
 		      VSC73XX_GLORESET_PHY_RESET);
@@ -871,9 +877,6 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 	if (duplex == DUPLEX_FULL)
 		val |= VSC73XX_MAC_CFG_FDX;
 
-	/* Enable port (forwarding) in the receieve mask */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), BIT(port));
 	vsc73xx_adjust_enable_port(vsc, port, val);
 }
 
@@ -1040,6 +1043,41 @@ static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
 	return 9600;
 }
 
+static void vsc73xx_port_stp_state_set(struct dsa_switch *ds, int port,
+				       u8 state)
+{
+	struct vsc73xx *vsc = ds->priv;
+	/* FIXME: STP frames isn't forwarded at this moment. BPDU frames are
+	 * forwarded only from to PI/SI interface. For more info see chapter
+	 * 2.7.1 (CPU Forwarding) in datasheet.
+	 * This function is required for tag8021q operations.
+	 */
+
+	if (state == BR_STATE_BLOCKING)
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_RECVMASK, BIT(port), 0);
+	else
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_RECVMASK, BIT(port), BIT(port));
+
+	if (state == BR_STATE_LEARNING || state == BR_STATE_FORWARDING)
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_LEARNMASK, BIT(port), BIT(port));
+	else
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_LEARNMASK, BIT(port), 0);
+
+	if (state == BR_STATE_FORWARDING)
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK,
+				    vsc->forward_map[port]);
+	else
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+				    VSC73XX_SRCMASKS + port,
+				    VSC73XX_SRCMASKS_PORTS_MASK, 0);
+}
+
 static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_tag_protocol = vsc73xx_get_tag_protocol,
 	.setup = vsc73xx_setup,
@@ -1056,6 +1094,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.port_stp_state_set = vsc73xx_port_stp_state_set,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 30b1f0a36566..c4d5398edeeb 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -5,6 +5,7 @@
 
 /**
  * struct vsc73xx - VSC73xx state container
+ * @forward_map: Forward table cache
  */
 struct vsc73xx {
 	struct device			*dev;
@@ -15,6 +16,7 @@ struct vsc73xx {
 	u8				addr[ETH_ALEN];
 	const struct vsc73xx_ops	*ops;
 	void				*priv;
+	u8				forward_map[8];
 };
 
 struct vsc73xx_ops {
-- 
2.34.1

