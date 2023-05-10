Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D846FE7D2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236717AbjEJXAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236637AbjEJXAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:00:47 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A6610F5;
        Wed, 10 May 2023 16:00:39 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pwsnU-0004Uo-0h;
        Wed, 10 May 2023 23:00:36 +0000
Date:   Thu, 11 May 2023 00:58:42 +0200
From:   Daniel Golle <daniel@makrotopia.org>
To:     netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH net-next 5/8] net: phy: realtek: make sure paged read is
 protected by mutex
Message-ID: <d56ee0a8fce63beb3916caff3ebc38f8fc562c52.1683756691.git.daniel@makrotopia.org>
References: <cover.1683756691.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1683756691.git.daniel@makrotopia.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As we cannot rely on phy_read_paged function before the PHY is
identified, the paged read in rtlgen_supports_2_5gbps needs to be open
coded as it is being called by the match_phy_device function, ie. before
.read_page and .write_page have been populated.

Make sure it is also protected by the MDIO bus mutex and use
rtl821x_write_page instead of 3 individually locked MDIO bus operations.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index acadb6f0057b..e6a46c4d97b1 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -744,9 +744,11 @@ static bool rtlgen_supports_2_5gbps(struct phy_device *phydev)
 {
 	int val;
 
-	phy_write(phydev, RTL821x_PAGE_SELECT, 0xa61);
-	val = phy_read(phydev, 0x13);
-	phy_write(phydev, RTL821x_PAGE_SELECT, 0);
+	phy_lock_mdio_bus(phydev);
+	rtl821x_write_page(phydev, 0xa61);
+	val = __phy_read(phydev, 0x13);
+	rtl821x_write_page(phydev, 0);
+	phy_unlock_mdio_bus(phydev);
 
 	return val >= 0 && val & RTL_SUPPORTS_2500FULL;
 }
-- 
2.40.0

