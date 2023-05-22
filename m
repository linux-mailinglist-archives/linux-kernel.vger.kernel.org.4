Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9598A70C3F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:04:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233397AbjEVREI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:04:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233409AbjEVRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:03:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6390DE9;
        Mon, 22 May 2023 10:03:46 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 12A966606E72;
        Mon, 22 May 2023 18:03:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684775025;
        bh=MWtwyGF7akcYO5s0qhuBRzsJ9ydw4HewyiQSd80e/Q8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaqvdF6ocAzkI463kXIOimiwSO1fUcnLllx8va5AKRDNr9vD6FVlUO2X8Mpbc1sZs
         ctecFb+keRzRcbLylk/SHTTO1Pejil6HHad66nLkksi2NgRp6Zji3frtgpziqLWFbE
         FWx0xJ4cJ0Yxhbj3xZtkE+/wFLUqGzgzW3vGf6q5SUNLY00sJDzZul8XmLi9GP9oG7
         u+bGhBc9X2ykxMjwGUgDkt2R2WY9gQKT9nJ9Eht1TAy9SIey3lv6ox7hJ6N+CgZWbZ
         E16rhGV/aO6mUiFy0qcecULKTRZ6UsNYmWg2tgtssWvh5rF+IYvg0mWeV3wFqcF+Sw
         z4eUy8i/NrJyw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 81CCD4807F0; Mon, 22 May 2023 19:03:40 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Heiko Stuebner <heiko@sntech.de>, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 6/7] phy: phy-rockchip-inno-usb2: simplify getting match data
Date:   Mon, 22 May 2023 19:03:23 +0200
Message-Id: <20230522170324.61349-7-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230522170324.61349-1-sebastian.reichel@collabora.com>
References: <20230522170324.61349-1-sebastian.reichel@collabora.com>
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

Simplify the code by directly getting the match data via
device_get_match_data() instead of open coding its functionality.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 1cf84869e78b..f5c30f117cba 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1305,7 +1305,6 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	struct phy_provider *provider;
 	struct rockchip_usb2phy *rphy;
 	const struct rockchip_usb2phy_cfg *phy_cfgs;
-	const struct of_device_id *match;
 	unsigned int reg;
 	int index, ret;
 
@@ -1313,12 +1312,6 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	if (!rphy)
 		return -ENOMEM;
 
-	match = of_match_device(dev->driver->of_match_table, dev);
-	if (!match || !match->data) {
-		dev_err(dev, "phy configs are not assigned!\n");
-		return -EINVAL;
-	}
-
 	if (!dev->parent || !dev->parent->of_node) {
 		rphy->grf = syscon_regmap_lookup_by_phandle(np, "rockchip,usbgrf");
 		if (IS_ERR(rphy->grf)) {
@@ -1359,12 +1352,15 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	}
 
 	rphy->dev = dev;
-	phy_cfgs = match->data;
+	phy_cfgs = device_get_match_data(dev);
 	rphy->chg_state = USB_CHG_STATE_UNDEFINED;
 	rphy->chg_type = POWER_SUPPLY_TYPE_UNKNOWN;
 	rphy->irq = platform_get_irq_optional(pdev, 0);
 	platform_set_drvdata(pdev, rphy);
 
+	if (!phy_cfgs)
+		return dev_err_probe(dev, -EINVAL, "phy configs are not assigned!\n");
+
 	ret = rockchip_usb2phy_extcon_register(rphy);
 	if (ret)
 		return ret;
-- 
2.39.2

