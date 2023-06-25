Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE3C73D0B2
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbjFYLza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjFYLzB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:55:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A198E4E;
        Sun, 25 Jun 2023 04:54:56 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b69ff54321so1270811fa.2;
        Sun, 25 Jun 2023 04:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687694094; x=1690286094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60Zazpocf6dvO7NBzRzsiGBzkHiKo0Zq0HLMlrfAmUs=;
        b=T9RvxzdXg42/05gDV629CPCIeBkFUTVZE/ckXCF4kVClsItOTXYuj7qB5dw53vtK/+
         80Ul3yLadV+wNgPXxHucIs5zyBTyFMS4EHLS963dOF9NN+9Ni8YWN81jdkBjJmnEEo/H
         GlSP7obO1LG5IItwhGDpGqVxIyWFBdOw0HZNcGqzBQ88Rdw2VF75NTFJdlq68X4dCBg/
         bM1TODTxseOo4WgvuFmQXNF2sh/jEFPDLGQGXhZl5ysBf74ZPLQ+RsH0m0dbdMuQMKDO
         h2QsemTYGUbVUYA08Gd2bqNuk9GGWp/SOzdgPM0w6/lHbr28NdAYXDvupdqYino1Ua1A
         ufIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687694094; x=1690286094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60Zazpocf6dvO7NBzRzsiGBzkHiKo0Zq0HLMlrfAmUs=;
        b=f9ELhFpWLeuI7BnJvYtGMvfO4y1XnvD0hWAn6zHrhIVyRTRyfWuIEuBZevFb2JaY4Q
         l4mqmTcfd9l9c7RMLLMb61iZ7niP67pjwnOix8b25NkZjr+KkwIZnlpzGvwgRtT1ZIiV
         2QJpRqkUV+5LscpSO7CXp1bZl005ls2/FvhSYwO+LmHO38lOjSkDGx39Zyl7paY8iMCW
         mT6FP+mdk2MK/G9SKwB5FnSiqO5eVIb7Du4xhXtigwVz+t2LYZxGxUXMVKjh9qj3AmEW
         7TK/+CYAM56mxpABjLK2Tk37+AzzxTHSWSVcfUsP2pQxFCWxw+GmYO5xsb3tOecQzOfP
         Fu5g==
X-Gm-Message-State: AC+VfDxVXOUseLbFvrH3hSbwWG75noOZ1lE1DlAiClYWWqeuTfI6ULTk
        S98e2Kv3d2NKIcbQ8nJ/Zg/HunoduIHj+A==
X-Google-Smtp-Source: ACHHUZ7ueOqiC+Xuh9d0k0eXYn0vBQ9cNSl2fyWjxWlcUVyDkE4ZQwhgx3sF5qzoI1hXM9UAuO3qbg==
X-Received: by 2002:a2e:9f57:0:b0:2b6:99a3:c256 with SMTP id v23-20020a2e9f57000000b002b699a3c256mr848906ljk.38.1687694094148;
        Sun, 25 Jun 2023 04:54:54 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id w21-20020a2e9595000000b002b6993b9665sm416043ljh.65.2023.06.25.04.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Jun 2023 04:54:53 -0700 (PDT)
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
Subject: [PATCH net-next v2 6/7] net: dsa: vsc73xx: Add vlan filtering
Date:   Sun, 25 Jun 2023 13:53:41 +0200
Message-Id: <20230625115343.1603330-6-paweldembicki@gmail.com>
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

This patch implement vlan filtering for vsc73xx driver.

After vlan filtering start, switch is reconfigured from QinQ to simple
vlan aware mode. It's required, because VSC73XX chips haven't support
for inner vlan tag filter.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Pawel Dembicki <paweldembicki@gmail.com>
---
v2:
  - no changes done

 drivers/net/dsa/vitesse-vsc73xx-core.c | 101 +++++++++++++++++++++++++
 1 file changed, 101 insertions(+)

diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/vitesse-vsc73xx-core.c
index 457eb7fddf4c..c946464489ab 100644
--- a/drivers/net/dsa/vitesse-vsc73xx-core.c
+++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
@@ -1226,6 +1226,30 @@ static int vsc73xx_port_set_double_vlan_aware(struct dsa_switch *ds, int port)
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
@@ -1304,6 +1328,80 @@ static int vsc73xx_vlan_set_pvid(struct dsa_switch *ds, int port, u16 vid,
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
@@ -1524,6 +1622,9 @@ static const struct dsa_switch_ops vsc73xx_ds_ops = {
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

