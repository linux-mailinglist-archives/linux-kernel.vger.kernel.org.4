Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A798742D23
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 21:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjF2TEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 15:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233348AbjF2TCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 15:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FEB130F6;
        Thu, 29 Jun 2023 12:01:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9ED361615;
        Thu, 29 Jun 2023 19:01:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B40D5C433CC;
        Thu, 29 Jun 2023 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688065308;
        bh=843jaKBD1k8owvqU/g+zjN+qonnvgOsHX7Jb+KRGfjs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LVN3C7rswFnWgrp09d/NjIpOqgveemOYplMzwN/BX6/kb387fmHhaHS7LVWOErtrg
         ErIfsgC9TFqWBNE8kmKfd1RQQsVAJfemvBfuPjtXmS0+zVQuIGrMmjG1u8DU1z//ZJ
         AM3pyaTgwGigrijo2hoVEKa1p8QGY8a2FCXzOCK0dxN1yzmR+8CfPZiWvQFGNE7aL7
         kT/3th2n/3849X/FZ/GGTkLztPMDr5mbCAsbxxE9t/Vc8KUK1gayGWW4g8WXrQiADI
         Y9FoRJCiZ/F3Hx0J64NpMdAF8U0m98K47cFTygURrZun9+cX58aa3eFih5yjQL4Y5T
         yRDsgonTxzcTA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Josua Mayer <josua@solid-run.com>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, ioana.ciornei@nxp.com,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 08/12] net: dpaa2-mac: add 25gbase-r support
Date:   Thu, 29 Jun 2023 15:01:28 -0400
Message-Id: <20230629190134.907949-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230629190134.907949-1-sashal@kernel.org>
References: <20230629190134.907949-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.35
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
index 49ff85633783a..c6d73c9a30396 100644
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
@@ -407,7 +412,7 @@ int dpaa2_mac_connect(struct dpaa2_mac *mac)
 
 	mac->phylink_config.mac_capabilities = MAC_SYM_PAUSE | MAC_ASYM_PAUSE |
 		MAC_10FD | MAC_100FD | MAC_1000FD | MAC_2500FD | MAC_5000FD |
-		MAC_10000FD;
+		MAC_10000FD | MAC_25000FD;
 
 	dpaa2_mac_set_supported_interfaces(mac);
 
-- 
2.39.2

