Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA7D6D5247
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbjDCUXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbjDCUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:23:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AC001FD2;
        Mon,  3 Apr 2023 13:23:16 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-192.ewe-ip-backbone.de [91.248.212.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DDF04660316C;
        Mon,  3 Apr 2023 21:23:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680553395;
        bh=IaXnd/TmDz+Pb/Lo3qVMIEFOaBSU3EHyiLnXscaJdlo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S3FDcWaNuohQVCrTCsFItK51ce4vVpzyorjjVHaXNJ3P/3sMyu85H+8zVM0NyntzK
         Qsd1xW2QcRLax4LNEUDacbACP8nX93jDHkxbswcoqpPR9lk9LR03LoxGZuriTm1i6Y
         q+5tEnFHDT0lFGRaS7wfMdQkDVeWeNa+cKDkivijl1IJW7GQHz3+d/HAxLiIWqzVQK
         gIQWRQRVUEKaxMMb076UtM09YCv8dPG0cKeXfVPzcGboPrwxrS3YbotxBTKjd47rFu
         grmtOJCYgByHQOu6udWI7RIsO9/tr/QiaqLqw+LbYXeisOtFGvlQegFwtGyQ3KYcZy
         etPpQUaor+uNw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 16D574807F3; Mon,  3 Apr 2023 22:23:09 +0200 (CEST)
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
Subject: [PATCHv2 7/7] phy: phy-rockchip-inno-usb2: simplify getting match data
Date:   Mon,  3 Apr 2023 22:23:07 +0200
Message-Id: <20230403202307.120562-8-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230403202307.120562-1-sebastian.reichel@collabora.com>
References: <20230403202307.120562-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
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
index 2de1408eaa60..e978c73ba1e5 100644
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

