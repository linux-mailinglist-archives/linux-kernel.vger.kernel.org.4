Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2646D5245
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 22:23:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231513AbjDCUXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 16:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCUXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 16:23:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196EE1FEE;
        Mon,  3 Apr 2023 13:23:16 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-212-192.ewe-ip-backbone.de [91.248.212.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D3A316603162;
        Mon,  3 Apr 2023 21:23:14 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680553395;
        bh=0AvnUkLP+KMEub7LlbfJLBC/RaxG7cnldhb+34NFfeU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kqT8QSd5xC5Zn0kxCvSR4k+bV5Mwq/AX6a3Esoh79VDC6EvNEl7QC07blK6+R5/AI
         Pj5sj5tTks1PhbhhLT3NqBjB6oNf8B5BST4g5XZl+4zzGn8RE0xzn7+ya3OBH0E+QH
         0ovrdHQ6Ok1XLtALq3T7Fwn+QMgJP5U1gQ8ChzTbkqvYrN03mXtEFSOdK8dIuNL+Az
         QHh04QCYqdPLmVp5zxq3ZcCTr0CIMONCxUxSjoQunoW0ayIa+2beS0ebtOWflpnpWw
         8hIkgPL3iKYUrfU/h+oh4GxYvKFv7wqFTKrFd8E05cbWPKglpXXlFpFfVQcTd+1NOF
         iIBaCwSIY0YGA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 14F3F4807F2; Mon,  3 Apr 2023 22:23:09 +0200 (CEST)
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
Subject: [PATCHv2 6/7] phy: phy-rockchip-inno-usb2: simplify phy clock handling
Date:   Mon,  3 Apr 2023 22:23:06 +0200
Message-Id: <20230403202307.120562-7-sebastian.reichel@collabora.com>
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

Simplify phyclk handling by using devm_clk_get_optional_enabled to
acquire and enable the optional clock. This also fixes a resource
leak in driver remove path and adds proper error handling.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index 9f6d09da7fbd..2de1408eaa60 100644
--- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
+++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
@@ -1390,24 +1390,22 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 	if (IS_ERR(rphy->phy_reset))
 		return PTR_ERR(rphy->phy_reset);
 
-	rphy->clk = of_clk_get_by_name(np, "phyclk");
-	if (!IS_ERR(rphy->clk)) {
-		clk_prepare_enable(rphy->clk);
-	} else {
-		dev_info(&pdev->dev, "no phyclk specified\n");
-		rphy->clk = NULL;
+	rphy->clk = devm_clk_get_optional_enabled(dev, "phyclk");
+	if (IS_ERR(rphy->clk)) {
+		return dev_err_probe(&pdev->dev, PTR_ERR(rphy->clk),
+				     "failed to get phyclk\n");
 	}
 
 	ret = rockchip_usb2phy_clk480m_register(rphy);
 	if (ret) {
 		dev_err(dev, "failed to register 480m output clock\n");
-		goto disable_clks;
+		return ret;
 	}
 
 	if (rphy->phy_cfg->phy_tuning) {
 		ret = rphy->phy_cfg->phy_tuning(rphy);
 		if (ret)
-			goto disable_clks;
+			return ret;
 	}
 
 	index = 0;
@@ -1470,11 +1468,6 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
 
 put_child:
 	of_node_put(child_np);
-disable_clks:
-	if (rphy->clk) {
-		clk_disable_unprepare(rphy->clk);
-		clk_put(rphy->clk);
-	}
 	return ret;
 }
 
-- 
2.39.2

