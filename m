Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65DC06FE7AE
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 00:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236549AbjEJWzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 18:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbjEJWzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 18:55:19 -0400
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E4C140DC;
        Wed, 10 May 2023 15:55:18 -0700 (PDT)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96)
        (envelope-from <daniel@makrotopia.org>)
        id 1pwsiJ-0004P1-27;
        Wed, 10 May 2023 22:55:15 +0000
Date:   Thu, 11 May 2023 00:53:22 +0200
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
Subject: [PATCH net-next 0/8] Improvements for RealTek 2.5G Ethernet PHYs
Message-ID: <cover.1683756691.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Improve support for RealTek 2.5G Ethernet PHYs (RTL822x series).
The PHYs can operate with Clause-22 and Clause-45 MDIO.

When using Clause-45 it is desireable to avoid rate-adapter mode and
rather have the MAC interface mode follow the PHY speed. The PHYs
support 2500Base-X for 2500M, and Cisco SGMII for 1000M/100M/10M.

Also prepare support for proprietary RealTek HiSGMII mode which will
be needed for situations when used with RealTek switch or router SoCs
such as RTL839x or RTL93xx.

Add support for Link Down Power Saving Mode (ALDPS) which is already
supported for older RTL821x series 1GbE PHYs.

Make sure that link-partner advertised modes are only used if the
advertisement can be considered valid. Otherwise we are seeing
false-positives warning about downscaling eventhough higher speeds
are not actually advertised by the link partner.

While at it, use helper function for paged operation and make sure
to use use locking for that as well.

Changes since RFC:
 * Turns out paged read used to identify the PHY needs to be hardcoded
   for the simple reason that the function pointers for paged operations
   have not yet been populated at this point. Hence keep open-coding it,
   but use helper function and make sure it happening while the MDIO bus
   mutex is locked.

Alexander Couzens (1):
  net: phy: realtek: rtl8221: allow to configure SERDES mode

Chukun Pan (1):
  net: phy: realtek: switch interface mode for RTL822x series

Daniel Golle (6):
  net: phy: realtek: use genphy_soft_reset for 2.5G PHYs
  net: phy: realtek: disable SGMII in-band AN for 2.5G PHYs
  net: phy: realtek: make sure paged read is protected by mutex
  net: phy: realtek: use inline functions for 10GbE advertisement
  net: phy: realtek: check validity of 10GbE link-partner advertisement
  net: phy: realtek: setup ALDPS on RTL8221B

 drivers/net/phy/realtek.c | 161 ++++++++++++++++++++++++++++++++------
 1 file changed, 138 insertions(+), 23 deletions(-)

-- 
2.40.0

