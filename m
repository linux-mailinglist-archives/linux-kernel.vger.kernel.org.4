Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269D9738FC9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231922AbjFUTOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjFUTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:14:04 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B04A19A1;
        Wed, 21 Jun 2023 12:13:53 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-988a076a7d3so561433566b.3;
        Wed, 21 Jun 2023 12:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374832; x=1689966832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TLLtjHWzs7ZG8vPoT2X5Q4HoaZ6N+6iqDgnNi3PJXLw=;
        b=aJHQiINYiNkkDGqMQe18joU6lSfifejsOhQsS1qmfD+tKvk+HYzahqce/xUJ1yF8fM
         ahOPQGYYQMqrPwgCLfUZup6l9xoCGnh5XUNRHnu3LRmgrOLG8oVVMDR5iJHgSRXpIEKR
         lmLNaNy6B7nV18adJfqiy49dq5vIoEqimTJg80zJ8egHw0AkY5mookiAAQoBKguIVN+i
         /7u3iGnH29LF0EUsGfYUvLZPj6M6zy8XP8mojq373HAkXYNB23f3pBgKy2getpSBMyi1
         7/Krd1Ziq759mQ/NAD6BnnbemylWQSOOyYXc5jOTotDzPjb1OfwKgckbUVpg9v4ocv9j
         WD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374832; x=1689966832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TLLtjHWzs7ZG8vPoT2X5Q4HoaZ6N+6iqDgnNi3PJXLw=;
        b=fSc3dNUNAHegc9d2ULNAB9SIYPafwewA5rHLIBZLk4BMis5GNy10C3J1CNq8GwNz/s
         xyMJBrzZW6MZ4o9WRpqmRvLFQknhs/ClKgiY/+HE3+2vJkQTO1VRWDXVHOa2ASCJhG4K
         aCsF+qdX40EW8Yy4bUpv7MFgivXFyPF9/rh7IORL+utZp5Cz0OlSwzurn7O+l9A24bmI
         H/cT9ocFnvdMdm0j9lbkYoClxDaVOHpG39BPo+KE+qZsMjMxjjAVhelLfNRQVSsGhg4B
         jAGf7SFF/bJhAOHQA0+G4WVFVlB8FfolVabQuZ9CkT97sCNj/EABlvbP/wOqw+K44Vl9
         5RKg==
X-Gm-Message-State: AC+VfDxGV5tU4Ytvs6MSSivEJRsFRZ16RJ6F+cpb2JEivK7IsOJCIu4P
        jqG5QFzNTMjhar0zTmkxtIE7fimvsYWYoA==
X-Google-Smtp-Source: ACHHUZ4Jg/YSAuqDeej/flbZFnXw9si1E2/gmbeI71BDWf06TLesUifJeRzU7yPxYooa855A1GWWMg==
X-Received: by 2002:a17:907:1c8b:b0:988:a876:53ca with SMTP id nb11-20020a1709071c8b00b00988a87653camr10259839ejc.65.1687374831501;
        Wed, 21 Jun 2023 12:13:51 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id gu1-20020a170906f28100b009829a5ae8b3sm3539562ejb.64.2023.06.21.12.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:13:51 -0700 (PDT)
From:   Pawel Dembicki <paweldembicki@gmail.com>
To:     netdev@vger.kernel.org
Cc:     linus.walleij@linaro.org, Pawel Dembicki <paweldembicki@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set function
Date:   Wed, 21 Jun 2023 21:12:58 +0200
Message-Id: <20230621191302.1405623-2-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621191302.1405623-1-paweldembicki@gmail.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
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

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 51 +++++++++++++++++++++++---
 drivers/net/dsa/vitesse-vsc73xx.h      |  1 +
 2 files changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index e853b57b0bc8..ce22bd5fa8df 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -165,6 +165,10 @@
 #define VSC73XX_AGENCTRL	0xf0
 #define VSC73XX_CAPRST		0xff
 
+#define VSC73XX_SRCMASKS_CPU_COPY		BIT(27)
+#define VSC73XX_SRCMASKS_MIRROR			BIT(26)
+#define VSC73XX_SRCMASKS_PORTS_MASK		GENMASK(7, 0)
+
 #define VSC73XX_MACACCESS_CPU_COPY		BIT(14)
 #define VSC73XX_MACACCESS_FWD_KILL		BIT(13)
 #define VSC73XX_MACACCESS_IGNORE_VLAN		BIT(12)
@@ -621,15 +625,17 @@ static int vsc73xx_setup(struct dsa_switch *ds)
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
@@ -885,9 +891,6 @@ static void vsc73xx_phylink_mac_link_up(struct dsa_switch *ds, int port,
 		break;
 	}
 
-	/* Enable port (forwarding) in the receieve mask */
-	vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
-			    VSC73XX_RECVMASK, BIT(port), BIT(port));
 	vsc73xx_adjust_enable_port(vsc, port, val);
 }
 
@@ -1054,6 +1057,41 @@ static int vsc73xx_get_max_mtu(struct dsa_switch *ds, int port)
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
@@ -1070,6 +1108,7 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_disable = vsc73xx_port_disable,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
+	.port_stp_state_set = vsc73xx_port_stp_state_set,
 };
 
 static int vsc73xx_gpio_get(struct gpio_chip *chip, unsigned int offset)
diff --git a/drivers/net/dsa/vitesse-vsc73xx.h b/drivers/net/dsa/vitesse-vsc73xx.h
index 30b1f0a36566..1552a9ca06ff 100644
--- a/drivers/net/dsa/vitesse-vsc73xx.h
+++ b/drivers/net/dsa/vitesse-vsc73xx.h
@@ -15,6 +15,7 @@ struct vsc73xx {
 	u8				addr[ETH_ALEN];
 	const struct vsc73xx_ops	*ops;
 	void				*priv;
+	u8				forward_map[8];
 };
 
 struct vsc73xx_ops {
-- 
2.34.1

