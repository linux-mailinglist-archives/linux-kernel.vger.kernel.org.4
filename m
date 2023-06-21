Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9867C738FD0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjFUTOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbjFUTOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:14:24 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801651BF7;
        Wed, 21 Jun 2023 12:14:13 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-988b204ce5fso477512466b.3;
        Wed, 21 Jun 2023 12:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374852; x=1689966852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sPvwDLAkPm+J5yy/CrqAAOmNvfy8yFX7NYpiCf7rGFY=;
        b=CqrDU8Tf/bjAF7VdkLJwDhrUE1jCNiXlhoc/pd7gGkepULcmd+0AXAeee9IahSUfjP
         Y6LglgErqcWCa3Kqa7pJdsiRCPlutHhV3sqVFfwjOrvFuXl51/SJLAX69NWvkuGHJxAI
         p448+QKYC6Nl9cwifFr2jAt3pIQT9FHP8rWvax0qA/bQjR02mtjNohEf+vORxMup56J0
         nzm/ldTm390H5eYn9TsG5HILhQGm6UpwkamKP5Plqt0QpmH1suYoBUtO5pEKMR03n48+
         Cw6nythrcgTO2nO1qXQuPNnBU8WxWpDWkC0C7w+Eq6/H0FuSvoHhIwGj23BWu3gvYUgA
         LdTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374852; x=1689966852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sPvwDLAkPm+J5yy/CrqAAOmNvfy8yFX7NYpiCf7rGFY=;
        b=RMJOcNHPmXMO4NoNohSvLu7d/QDusGw0BzXG0LBYLSwGc0mpBLUDvt8QXECdp40hFp
         y7JNNrhQxFDx9otjYWPHI+rSuw8K9tSeNt4p/XZ3DzNLB9kw2CtDq7Y/nM6mYBhcIGT8
         z+NY7Fz+9QKWEZ1ALj5pn8huXTVNHrQv0gJEybsxAIe0tYAvFSt5p0opXKX+QOMtTwrM
         LdIrsxC6Gdq8wwjVopMs4PYvC7s3vjUXNRDBAi4QdvJ07Pq0UcTmShmo32n/aWuUcKsi
         MU27NdjoRFOKsjLcK4Ek6gMwlEzw6dVWRcMuf+W2lg6WmuNPid/jh4lEZj6l0jxhs7EL
         PLTA==
X-Gm-Message-State: AC+VfDzFI+TolSntO4sueY1UvLcwef3XCNLMD317mJrDhiRvcNH75WvS
        ZXqcuyGshdh9xbnJtEaSdkhXy598E3hfeA==
X-Google-Smtp-Source: ACHHUZ4fDOq3zc5oeihem59ydVCdtumef/VHkXEaPyVyWTt1gXMHyKrm+Y3sskhuXcXikbTVlqMFpg==
X-Received: by 2002:a17:907:802:b0:982:a454:6d20 with SMTP id wv2-20020a170907080200b00982a4546d20mr13099911ejb.54.1687374851681;
        Wed, 21 Jun 2023 12:14:11 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id gu1-20020a170906f28100b009829a5ae8b3sm3539562ejb.64.2023.06.21.12.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:14:11 -0700 (PDT)
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
Subject: [PATCH net-next 4/6] net: dsa: vsc73xx: Add bridge support
Date:   Wed, 21 Jun 2023 21:13:00 +0200
Message-Id: <20230621191302.1405623-4-paweldembicki@gmail.com>
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

This patch adds bridge support for vsc73xx driver.
It introduce two functions for port_bridge_join and
vsc73xx_port_bridge_leave handling.

Those functions implement forwarding adjust and use
dsa_tag_8021q_bridge_* api for adjust VLAN configuration.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 69 ++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 653914fb5796..427b6f964811 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1317,6 +1317,72 @@ static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid,
 	return 0;
 }
 
+static void vsc73xx_update_forwarding_map(struct vsc73xx *vsc)
+{
+	int i;
+
+	for (i = 0; i < vsc->ds->num_ports; i++) {
+		u32 val;
+
+		vsc73xx_read(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+			     VSC73XX_SRCMASKS + i, &val);
+		/* update only if port is in forwarding state*/
+		if (val & VSC73XX_SRCMASKS_PORTS_MASK)
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_ANALYZER, 0,
+					    VSC73XX_SRCMASKS + i,
+					    VSC73XX_SRCMASKS_PORTS_MASK,
+					    vsc->forward_map[i]);
+	}
+}
+
+static int vsc73xx_port_bridge_join(struct dsa_switch *ds, int port,
+				    struct dsa_bridge bridge,
+				    bool *tx_fwd_offload,
+				    struct netlink_ext_ack *extack)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int i;
+
+	*tx_fwd_offload = true;
+
+	for (i = 0; i < ds->num_ports; i++) {
+		/* Add this port to the forwarding matrix of the
+		 * other ports in the same bridge, and viceversa.
+		 */
+		if (!dsa_is_user_port(ds, i))
+			continue;
+
+		if (i == port)
+			continue;
+
+		if (!dsa_port_offloads_bridge(dsa_to_port(ds, i), &bridge))
+			continue;
+
+		vsc->forward_map[port] |= VSC73XX_SRCMASKS_PORTS_MASK & BIT(i);
+		vsc->forward_map[i] |= VSC73XX_SRCMASKS_PORTS_MASK & BIT(port);
+	}
+	vsc73xx_update_forwarding_map(vsc);
+
+	return dsa_tag_8021q_bridge_join(ds, port, bridge);
+}
+
+static void vsc73xx_port_bridge_leave(struct dsa_switch *ds, int port,
+				      struct dsa_bridge bridge)
+{
+	struct vsc73xx *vsc = ds->priv;
+	int i;
+	/*configure forward map to CPU <-> port only*/
+	for (i = 0; i < vsc->ds->num_ports; i++) {
+		if (i == CPU_PORT)
+			continue;
+		vsc->forward_map[i] &= VSC73XX_SRCMASKS_PORTS_MASK & ~BIT(port);
+	}
+	vsc->forward_map[port] = VSC73XX_SRCMASKS_PORTS_MASK & BIT(CPU_PORT);
+
+	vsc73xx_update_forwarding_map(vsc);
+	dsa_tag_8021q_bridge_leave(ds, port, bridge);
+}
+
 static int vsc73xx_tag_8021q_vlan_add(struct dsa_switch *ds, int port, u16 vid,
 				      u16 flags)
 {
@@ -1355,6 +1421,7 @@ static int vsc73xx_setup(struct dsa_switch *ds)
 
 	ds->vlan_filtering_is_global = false;
 	ds->configure_vlan_while_not_filtering = false;
+	ds->max_num_bridges = 7;
 
 	/* Issue RESET */
 	vsc73xx_write(vsc, VSC73XX_BLOCK_SYSTEM, 0, VSC73XX_GLORESET,
@@ -1465,6 +1532,8 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.get_sset_count = vsc73xx_get_sset_count,
 	.port_enable = vsc73xx_port_enable,
 	.port_disable = vsc73xx_port_disable,
+	.port_bridge_join = vsc73xx_port_bridge_join,
+	.port_bridge_leave = vsc73xx_port_bridge_leave,
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
-- 
2.34.1

