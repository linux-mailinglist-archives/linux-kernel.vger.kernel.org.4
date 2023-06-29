Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD45742CBF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjF2TC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbjF2TBZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:01:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45C330C5;
        Thu, 29 Jun 2023 12:01:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 708E761610;
        Thu, 29 Jun 2023 19:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C30C43395;
        Thu, 29 Jun 2023 19:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065281;
        bh=mauEmIibkSzi6T2wNkYsvsVxn/WfSz8lZ3dKZtW4dAY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HdRRWuHqv/p9PA4gEoFaPrCXEeRjkmN/A7NfDn7QO3tMtcELm1yECOn7PebH55rny
         sGE+zrUUzdDrWwgcCpNouHvd1VvRiykreQ1RmH9TZKqmGwf2FkPXOtJf3Z8X3tHBJx
         EIz9h4vJqeLc0Qu80hSOMzNWv/R9jZlX/TwjmZUojXv5XEV3OaYZwVjdAGs8azBpGV
         lDOFvZKIupsUTTCU4y/uM3GjFT1pgZpyavrJ4M2cZ/8LB5DlxHOirnLv8yshZGXY6F
         hq7jbsanIJ4mQiTuqIoFHPoyNjVRWHMNHt4WoMcZjbWc97Nxc8QNXjWP+21VIGgDl/
         Fjep5PI1xGTsg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, ioana.ciornei@nxp.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 11/17] net: dpaa2-mac: add 25gbase-r support
Date:   Thu, 29 Jun 2023 15:00:40 -0400
Message-Id: <20230629190049.907558-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190049.907558-1-sashal@kernel.org>
References: <20230629190049.907558-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Josua Mayer <josua@solid-run.com>

[ Upstream commit 9a43827e876c9a071826cc81783aa2222b020f1d ]

Layerscape MACs support 25Gbps network speed with dpmac "CAUI" mode.
Add the mappings between DPMAC_ETH_IF_* and HY_INTERFACE_MODE_*, as well
as the 25000 mac capability.

Tested on SolidRun LX2162a Clearfog, serdes 1 protocol 18.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
index c886f33f8c6fe..5ab24f18026b0 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-mac.c
@@ -54,6 +54,9 @@ static int phy_mode(enum dpmac_eth_if eth_if, phy_interface_t *if_mode)
 	case DPMAC_ETH_IF_XFI:
 		*if_mode = PHY_INTERFACE_MODE_10GBASER;
 		break;
+	case DPMAC_ETH_IF_CAUI:
+		*if_mode = PHY_INTERFACE_MODE_25GBASER;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -79,6 +82,8 @@ static enum dpmac_eth_if dpmac_eth_if_mode(phy_interface_t if_mode)
 		return DPMAC_ETH_IF_XFI;
 	case PHY_INTERFACE_MODE_1000BASEX:
 		return DPMAC_ETH_IF_1000BASEX;
+	case PHY_INTERFACE_MODE_25GBASER:
+		return DPMAC_ETH_IF_CAUI;
 	default:
 		return DPMAC_ETH_IF_MII;
 	}
@@ -417,7 +422,7 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
 
 	mac->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 		MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD | MAC_5000FD |
-		MAC_10000FD;
+		MAC_10000FD | MAC_25000FD;
 
 	dpaa2_mac_set_supported_interfaces(mac);
 
-- 
2.39.2

