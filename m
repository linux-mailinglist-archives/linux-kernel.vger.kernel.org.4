Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08196722B6F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234912AbjFEPkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbjFEPkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:40:25 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC4341BB;
        Mon,  5 Jun 2023 08:40:15 -0700 (PDT)
Received: from arisu.mtl.collabora.ca (mtl.collabora.ca [66.171.169.34])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: detlev)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1CC536602242;
        Mon,  5 Jun 2023 16:40:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685979614;
        bh=vWggyIWMQJwPp+5rrAFGhNQx/8NDyETfk2n0HVwyCl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9a9zBIYcIdls2PzTWUkthOwuEK1v/PspIqd2Os67mqb5Z56YMIh483PHx6F/dRIv
         Hm0b0/VhgyWceKlaAKRGsfzLDZ6lxq7ZWVkC5/e8mlFJNcGgK8k2QliAVc10S0Cy1r
         k9f3/LnCgE/3gD2ZmN+BTUOzksLhBhV93p/IE2EOQZpULJ5rxPGquXCE3nXNH+aFWI
         gCU4lvxqcjnBmkJ/qpWX3PEeIj+Cl/QCnpwjhO51xvebwPX/EdooyDQKrjH7u6CgFf
         1FTR3+W3tl/PMXklFxWWVcum482W4S+vs+zayKUXaRUtXfctdtRXyLN1oO//qZrKxs
         Yc91Wz4LkumoA==
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
        Detlev Casanova <detlev.casanova@collabora.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH v4 1/3] net: phy: realtek: Add optional external PHY clock
Date:   Mon,  5 Jun 2023 11:40:08 -0400
Message-Id: <20230605154010.49611-2-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230605154010.49611-1-detlev.casanova@collabora.com>
References: <20230605154010.49611-1-detlev.casanova@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, the PHY can use an external clock source instead of a
crystal.

Add an optional clock in the phy node to make sure that the clock source
is enabled, if specified, before probing.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/net/phy/realtek.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 3d99fd6664d7..b13dd0b3c99e 100644
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
 
+	priv->clk = devm_clk_get_optional_enabled(dev, NULL);
+	if (IS_ERR(priv->clk))
+		return dev_err_probe(dev, PTR_ERR(priv->clk),
+				     "failed to get phy clock\n");
+
 	ret = phy_read_paged(phydev, 0xa43, RTL8211F_PHYCR1);
 	if (ret < 0)
 		return ret;
-- 
2.39.3

