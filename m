Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9408738FD8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231820AbjFUTO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbjFUTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:14:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15511FCB;
        Wed, 21 Jun 2023 12:14:17 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5147e40bbbbso6575641a12.3;
        Wed, 21 Jun 2023 12:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374856; x=1689966856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OFEEr8CRLhYmuTj5DihLU72iPAQ9ZiHHA571qCsogI=;
        b=doD9KOMJcKD8cOpR92sSS1frurq3fCa9rRRFRPWBioxhbTviRlaqFc+CuG0mpoaid3
         MJuzgvLdkctrtU5sY8cb6/HoGA3V0qVpf4npbEzOTYE6CE8E0pPUL8W6A6aIEP2c0g8s
         uk+5czKWFE3aizqiQMzPSt7HXb2jZYm3Z1SiSy8R+nGzQLqx870Uk5msdVZkedmlTL4K
         ZwSSx+Nt4+mqoJ/h5/leDsaAwc1uwzzpZHvaP9hNSBODir3gR1pH7wdBrZExxY455wbR
         c3krhEVwD9t56dEYoXkO/KDVuWEEgHGOkeq9U5icJ/yvMuC9JEaTxz6/yYN/HAPS20d4
         L5XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374856; x=1689966856;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0OFEEr8CRLhYmuTj5DihLU72iPAQ9ZiHHA571qCsogI=;
        b=V1FCzkKc3Du7XuDcV7nJMWevFPGkY2hOOvavWEMrCtOJVqli6TDKs1+kEe5H/0OLZ8
         klZOgW+VfMFXb/7ga6TWZ1YS75PohAWwkYldpXAFkru7lp2bFMgkUqFs3NgVNZ7TzzcY
         M+16uHtNssarWwtoHDPhOfvwyOxHX2z6Bex8Kha7bfAJqxoLFhz41+4wQalW8/OdQ1if
         a+ro63vHCqKWM7xdRV4D60+xEDal0iNDniP7/UI5JSIfdGoDkQT0dh08upVgfe1pJud/
         zqHQvRwleudv6MykTFaXo3CFt2f83Ct36+aPgTOJOHVEa+H//1JeHPMjaUTQhPS4MKdf
         alMw==
X-Gm-Message-State: AC+VfDyupB8VjkcD0TlzZiCaVnrAvDow/Z5ALoDfqzTI1xgBbVeKOp9K
        z98CH5UcetIzeY6vQJvw1dbaxDslxwVBmg==
X-Google-Smtp-Source: ACHHUZ4SclwO9nDqPe0vpCLLvv9iPwe3xITQAzVvoJBd7NWrcLWLajqw+ubOhiFoqREniPkzJA+GGA==
X-Received: by 2002:a17:906:974f:b0:989:21e4:6c6e with SMTP id o15-20020a170906974f00b0098921e46c6emr4815550ejy.53.1687374855819;
        Wed, 21 Jun 2023 12:14:15 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id gu1-20020a170906f28100b009829a5ae8b3sm3539562ejb.64.2023.06.21.12.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:14:15 -0700 (PDT)
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
Subject: [PATCH net-next 5/6] net: dsa: vsc73xx: Add vlan filtering
Date:   Wed, 21 Jun 2023 21:13:01 +0200
Message-Id: <20230621191302.1405623-5-paweldembicki@gmail.com>
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

This patch implement vlan filtering for vsc73xx driver.

After vlan filtering start, switch is reconfigured from QinQ to simple
vlan aware mode. It's required, because VSC73XX chips haven't support
for inner vlan tag filter.

Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
 drivers/net/dsa/vitesse-vsc73xx-core.c | 101 +++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 427b6f964811..fcce47cf6da4 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1239,6 +1239,30 @@ static int vsc73xx_port_set_double_vlan_aware(struct dsa_switch *ds, int port)
 	return ret;
 }
 
+static int
+vsc73xx_port_vlan_filtering(struct dsa_switch *ds, int port,
+			    bool vlan_filtering, struct netlink_ext_ack *extack)
+{
+	int ret, i;
+
+	if (vlan_filtering) {
+		vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_VLAN_AWARE);
+	} else {
+		if (port == CPU_PORT)
+			vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_DOUBLE_VLAN_CPU_AWARE);
+		else
+			vsc73xx_port_set_vlan_conf(ds, port, VSC73XX_DOUBLE_VLAN_AWARE);
+	}
+
+	for (i = 0; i <= 3072; i++) {
+		ret = vsc73xx_port_update_vlan_table(ds, port, i, 0);
+		if (ret)
+			return ret;
+	}
+
+	return ret;
+}
+
 static int vsc73xx_vlan_set_untagged(struct dsa_switch *ds, int port, u16 vid,
 				     bool port_vlan)
 {
@@ -1317,6 +1341,80 @@ static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid,
 	return 0;
 }
 
+static int vsc73xx_port_vlan_add(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan,
+				 struct netlink_ext_ack *extack)
+{
+	bool untagged = vlan->flags & BRIDGE_VLAN_INFO_UNTAGGED;
+	bool pvid = vlan->flags & BRIDGE_VLAN_INFO_PVID;
+	int ret;
+
+	/* Be sure to deny alterations to the configuration done by tag_8021q.
+	 */
+	if (vid_is_dsa_8021q(vlan->vid)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Range 3072-4095 reserved for dsa_8021q operation");
+		return -EBUSY;
+	}
+
+	if (untagged && port != CPU_PORT) {
+		ret = vsc73xx_vlan_set_untagged(ds, port, vlan->vid, true);
+		if (ret)
+			return ret;
+	}
+	if (pvid && port != CPU_PORT) {
+		ret = vsc73xx_vlan_set_pvid(ds, port, vlan->vid, true);
+		if (ret)
+			return ret;
+	}
+
+	ret = vsc73xx_port_update_vlan_table(ds, port, vlan->vid, 1);
+
+	return ret;
+}
+
+static int vsc73xx_port_vlan_del(struct dsa_switch *ds, int port,
+				 const struct switchdev_obj_port_vlan *vlan)
+{
+	struct vsc73xx *vsc = ds->priv;
+	u16 vlan_no;
+	int ret;
+	u32 val;
+
+	ret =
+	    vsc73xx_port_update_vlan_table(ds, port, vlan->vid, 0);
+	if (ret)
+		return ret;
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_TXUPDCFG, &val);
+
+	if (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA) {
+		vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port,
+			     VSC73XX_TXUPDCFG, &val);
+		vlan_no = (val & VSC73XX_TXUPDCFG_TX_UNTAGGED_VID) >>
+			  VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_SHIFT;
+		if (vlan_no == vlan->vid) {
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_TXUPDCFG,
+					    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID_ENA,
+					    0);
+			vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+					    VSC73XX_TXUPDCFG,
+					    VSC73XX_TXUPDCFG_TX_UNTAGGED_VID, 0);
+		}
+	}
+
+	vsc73xx_read(vsc, VSC73XX_BLOCK_MAC, port, VSC73XX_CAT_PORT_VLAN, &val);
+	vlan_no = val & VSC73XX_CAT_PORT_VLAN_VLAN_VID;
+	if (vlan_no && vlan_no == vlan->vid) {
+		vsc73xx_update_bits(vsc, VSC73XX_BLOCK_MAC, port,
+				    VSC73XX_CAT_PORT_VLAN,
+				    VSC73XX_CAT_PORT_VLAN_VLAN_VID, 0);
+	}
+
+	return 0;
+}
+
 static void vsc73xx_update_forwarding_map(struct vsc73xx *vsc)
 {
 	int i;
@@ -1537,6 +1635,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
 	.port_change_mtu = vsc73xx_change_mtu,
 	.port_max_mtu = vsc73xx_get_max_mtu,
 	.port_stp_state_set = vsc73xx_port_stp_state_set,
+	.port_vlan_filtering = vsc73xx_port_vlan_filtering,
+	.port_vlan_add = vsc73xx_port_vlan_add,
+	.port_vlan_del = vsc73xx_port_vlan_del,
 	.tag_8021q_vlan_add = vsc73xx_tag_8021q_vlan_add,
 	.tag_8021q_vlan_del = vsc73xx_tag_8021q_vlan_del,
 };
-- 
2.34.1

