Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2A071858D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 17:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233941AbjEaPEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234028AbjEaPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 11:04:21 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14E5E43;
        Wed, 31 May 2023 08:04:12 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D5F846606EB2;
        Wed, 31 May 2023 16:04:09 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685545451;
        bh=ojpftkR4i1FZMG72jz+SAgiRAqMlLbUDSyJeAdTo4nY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7mMuiFuy/oZjT/E/zwMGXS97T7DIb4RyJ9VJp9TS9OvzuwpCTEXV5xrM8uS4ufMR
         MhCWdJhw/97WCAgQoMaMAshA2clPWxN+aEUuaXFCswmdlwGF7v60dei6rybplBpoAp
         CL82PTdQGLZhz4igNm94bDG0J28z772/+v2TWq+x0UhEVNgixsyUGZN8C7SMT9s8Iz
         xExkFD6cS8oXJ6zZnM538/tbRElTqVG5qbfsdvEpnUeESswWK6/BXNu7lS3UaT4YZT
         h0J8UO3PqOP0UmhikDx2wn+zy+nlwzyYKL567lhL8AS8L4LnaE+zCGtF0DryGOOHVE
         jLX6eljPHwUhg==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH 2/2] net: phy: realtek: Add optional external PHY clock
Date:   Wed, 31 May 2023 11:03:40 -0400
Message-Id: <20230531150340.522994-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230531150340.522994-1-detlev.casanova@collabora.com>
References: <20230531150340.522994-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, the PHY can use an external clock source instead of a
crystal.

Add an optional clock in the phy node to make sure that the clock source
is enabled, if specified, before probing.

Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/net/phy/realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 3d99fd6664d7..70c75dbbf799 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -12,6 +12,7 @@
 #include <linux/phy.h>
 #include <linux/module.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 
 #define RTL821x_PHYSR				0x11
 #define RTL821x_PHYSR_DUPLEX			BIT(13)
@@ -80,6 +81,7 @@ struct rtl821x_priv {
 	u16 phycr1;
 	u16 phycr2;
 	bool has_phycr2;
+	struct clk *clk;
 };
 
 static int rtl821x_read_page(struct phy_device *phydev)
@@ -103,6 +105,11 @@ static int rtl821x_probe(struct phy_device *phydev)
 	if (!priv)
 		return -ENOMEM;
 
+	priv->clk = devm_clk_get_optional_enabled(dev, "xtal");
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "failed to get phy xtal clock\n");
+
 	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
 	if (ret < 0)
 		return ret;
-- 
2.39.3

