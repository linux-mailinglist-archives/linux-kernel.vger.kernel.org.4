Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A4B729231
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 10:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239916AbjFIIFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 04:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240002AbjFIIEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 04:04:37 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541973AB4;
        Fri,  9 Jun 2023 01:03:20 -0700 (PDT)
X-GND-Sasl: maxime.chevallier@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686297790;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iM8ydqGhr2n/tsxrZM65WHkskm2cjecADl+Ygc3iZ0A=;
        b=fe/zlv2hrnEWfJez2MvwUhGPcNucsfrbwVy999jQgZDLfPjTUfni45DIkKcos1BllLkKmw
        H/IyWzpXD3BfL5FPiDdm6xcGRv92nEvOoLM/2/By4FZkV2zafLJQIUMxCdbDg/O//7fTaz
        Rqf/a+kMRkbVe1kD0c8s4LTvdEbsvziG5edrsgS57VqJfAi7b79V+IDl5WdHy00iMdqQsW
        dMk8eGplGfi8FqE1rbewap2wsmoWYOMnFh9zufFvDhlq4miZYF/DK+arbyj8nb158TiJt2
        di5uqVe+gWtZOk3/og1ocJqowZMmcgrYoktOD7NKa/SJcnRQXzMuiWonTY77CA==
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
X-GND-Sasl: maxime.chevallier@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60AEBC000D;
        Fri,  9 Jun 2023 08:03:09 +0000 (UTC)
From:   Maxime Chevallier <maxime.chevallier@bootlin.com>
To:     davem@davemloft.net
Cc:     Maxime Chevallier <maxime.chevallier@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, Horatiu.Vultur@microchip.com,
        Allan.Nielsen@microchip.com, UNGLinuxDriver@microchip.com,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net v2 1/2] net: phylink: report correct max speed for QUSGMII
Date:   Fri,  9 Jun 2023 10:03:04 +0200
Message-Id: <20230609080305.546028-2-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230609080305.546028-1-maxime.chevallier@bootlin.com>
References: <20230609080305.546028-1-maxime.chevallier@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q-USGMII is the quad port version of USGMII, and supports a max speed of
1Gbps on each line. Make so that phylink_interface_max_speed() reports
this information correctly.

Fixes: ae0e4bb2a0e0 ("net: phylink: Adjust link settings based on rate matching")
Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V1->V2: No changes

 drivers/net/phy/phylink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 508434fd4da8..590469261b98 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -205,6 +205,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_RGMII_ID:
 	case PHY_INTERFACE_MODE_RGMII:
 	case PHY_INTERFACE_MODE_QSGMII:
+	case PHY_INTERFACE_MODE_QUSGMII:
 	case PHY_INTERFACE_MODE_SGMII:
 	case PHY_INTERFACE_MODE_GMII:
 		return SPEED_1000;
@@ -221,7 +222,6 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_10GBASER:
 	case PHY_INTERFACE_MODE_10GKR:
 	case PHY_INTERFACE_MODE_USXGMII:
-	case PHY_INTERFACE_MODE_QUSGMII:
 		return SPEED_10000;
 
 	case PHY_INTERFACE_MODE_25GBASER:
-- 
2.40.1

