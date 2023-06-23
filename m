Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697F673B54B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 12:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbjFWKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbjFWK34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 06:29:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E7BF1BCA
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 03:29:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1351F61A18
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 10:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46DF5C433CC;
        Fri, 23 Jun 2023 10:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687516182;
        bh=1muRLOb59+kQ7ZeXLBMZWXmkOisk9F6Bf+D/rqGDwuY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=Fg6wduN550kCKQZAgcUK+qaSxIyBJvy3NpfG7LFBjHOeAxveVY2qfyTrz2SYTMYok
         V9yn8w0v64hHHiyJx+/fThXbsPsHutp/n8hsSi5SMYEIjOGK7w/qZFfzbMtzBX1iTE
         29nL8rlcN2obNqdLHbi5OzZRLRIie1wjFJqC7qN6U6kVIaOy/hCRiEk6wu2b0fePP7
         D/kwRdTlPoDZ+t4LzMymI/5K5LWgCcR0jpt/8U5pI7RJI2Y89s57LurgxGWmq0bYYx
         G/weE/QDJSfjzcCEDCxb815JI2ABvpdqcRO+qIXgrxyLIBUbxw8rXN2aqyO4nBjcnF
         WHOJX1er4qZUg==
From:   Michael Walle <mwalle@kernel.org>
Date:   Fri, 23 Jun 2023 12:29:15 +0200
Subject: [PATCH net-next v2 06/10] net: phy: print an info if a broken C45
 bus is found
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230620-feature-c45-over-c22-v2-6-def0ab9ccee2@kernel.org>
References: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
In-Reply-To: <20230620-feature-c45-over-c22-v2-0-def0ab9ccee2@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Xu Liang <lxu@maxlinear.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Walle <mwalle@kernel.org>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is an PHY which gets confused by C45 transactions on the MDIO
bus, print an info together with the PHY identifier of the offending
one.

Signed-off-by: Michael Walle <mwalle@kernel.org>

---
I wasn't sure if this should be phydev_dbg() or phydev_info(). I mainly
see this as an info to a user why some PHYs might not be probed (or
c45-over-c22 is used later).
---
 drivers/net/phy/mdio_bus.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 00b25f6803bc..38529add6420 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -617,10 +617,10 @@ static int mdiobus_scan_bus_c45(struct mii_bus *bus)
  */
 void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
 {
+	struct phy_device *phydev;
 	int i;
 
 	for (i = 0; i < PHY_MAX_ADDR; i++) {
-		struct phy_device *phydev;
 		u32 oui;
 
 		phydev = mdiobus_get_phy(bus, i);
@@ -633,6 +633,11 @@ void mdiobus_scan_for_broken_c45_access(struct mii_bus *bus)
 			break;
 		}
 	}
+
+	if (bus->prevent_c45_access)
+		dev_info(&bus->dev,
+			 "Detected broken PHY (ID %08lx). Disabling C45 bus transactions.\n",
+			 (unsigned long)phydev->phy_id);
 }
 
 /**

-- 
2.39.2

