Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F4C670E079
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 17:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236530AbjEWPbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 11:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237341AbjEWPbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 11:31:33 -0400
Received: from smtp.missinglinkelectronics.com (smtp.missinglinkelectronics.com [162.55.135.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689B111A;
        Tue, 23 May 2023 08:31:28 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by smtp.missinglinkelectronics.com (Postfix) with ESMTP id B97572070F;
        Tue, 23 May 2023 17:31:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at missinglinkelectronics.com
Received: from smtp.missinglinkelectronics.com ([127.0.0.1])
        by localhost (mail.missinglinkelectronics.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2G3HKuyBGfdm; Tue, 23 May 2023 17:31:26 +0200 (CEST)
Received: from humpen-bionic2.mle (p578c5bfe.dip0.t-ipconnect.de [87.140.91.254])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: david)
        by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 4010C2066D;
        Tue, 23 May 2023 17:31:26 +0200 (CEST)
From:   David Epping <david.epping@missinglinkelectronics.com>
To:     Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Russell King <linux@armlinux.org.uk>
Cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com,
        David Epping <david.epping@missinglinkelectronics.com>
Subject: [PATCH net v3 3/4] net: phy: mscc: remove unnecessary phydev locking
Date:   Tue, 23 May 2023 17:31:07 +0200
Message-Id: <20230523153108.18548-4-david.epping@missinglinkelectronics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230523153108.18548-1-david.epping@missinglinkelectronics.com>
References: <20230523153108.18548-1-david.epping@missinglinkelectronics.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holding the struct phy_device (phydev) lock is unnecessary when
accessing phydev->interface in the PHY driver .config_init method,
which is the only place that vsc85xx_rgmii_set_skews() is called from.

The phy_modify_paged() function implements required MDIO bus level
locking, which can not be achieved by a phydev lock.

Signed-off-by: David Epping <david.epping@missinglinkelectronics.com>
---
 drivers/net/phy/mscc/mscc_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/phy/mscc/mscc_main.c b/drivers/net/phy/mscc/mscc_main.c
index 29fc27a16805..0c39b3ecb1f2 100644
--- a/drivers/net/phy/mscc/mscc_main.c
+++ b/drivers/net/phy/mscc/mscc_main.c
@@ -528,8 +528,6 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 	u16 reg_val = 0;
 	int rc;
 
-	mutex_lock(&phydev->lock);
-
 	if (phydev->interface == PHY_INTERFACE_MODE_RGMII_RXID ||
 	    phydev->interface == PHY_INTERFACE_MODE_RGMII_ID)
 		reg_val |= RGMII_CLK_DELAY_2_0_NS << rgmii_rx_delay_pos;
@@ -542,8 +540,6 @@ static int vsc85xx_rgmii_set_skews(struct phy_device *phydev, u32 rgmii_cntl,
 			      rgmii_rx_delay_mask | rgmii_tx_delay_mask,
 			      reg_val);
 
-	mutex_unlock(&phydev->lock);
-
 	return rc;
 }
 
-- 
2.17.1

