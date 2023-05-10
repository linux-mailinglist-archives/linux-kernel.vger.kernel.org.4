Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB046FE7D8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 01:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbjEJXBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 19:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236801AbjEJXBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 19:01:47 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81A1F49D9;
        Wed, 10 May 2023 16:01:42 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pwsoW-0004Vu-2l;
        Wed, 10 May 2023 23:01:41 +0000
Date:   Thu, 11 May 2023 00:59:46 +0200
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
Subject: [PATCH net-next 7/8] net: phy: realtek: check validity of 10GbE
 link-partner advertisement
Message-ID: <3722c3cf286bdaf89343c6d9e552d3eef79a2557.1683756691.git.daniel@makrotopia.org>
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

Only use link-partner advertisement bits for 10GbE modes if they are
actually valid. Check LOCALOK and REMOTEOK bits and clear 10GbE modes
unless both of them are set.

Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index cde61a30ac4c..29168f98f451 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -715,6 +715,10 @@ static int rtl822x_read_status(struct phy_device *phydev)
 		if (lpadv < 0)
 			return lpadv;
 
+		if (!(lpadv & MDIO_AN_10GBT_STAT_REMOK) ||
+		    !(lpadv & MDIO_AN_10GBT_STAT_LOCOK))
+			lpadv = 0;
+
 		mii_10gbt_stat_mod_linkmode_lpa_t(phydev->lp_advertising, lpadv);
 	}
 
-- 
2.40.0

