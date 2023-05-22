Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C00070C3EC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233485AbjEVRD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjEVRDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:03:47 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF63CD;
        Mon, 22 May 2023 10:03:46 -0700 (PDT)
Received: from jupiter.universe (dyndsl-091-248-208-162.ewe-ip-backbone.de [91.248.208.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0D45E6606E6F;
        Mon, 22 May 2023 18:03:45 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684775025;
        bh=aOdRu9IgBBsXxS1i+3a2pCjzvGT6Hcmagn1UYmXetkE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iZPGWsHQ05ONMyoFxPyoBnZsYqF53ShQRH/KtCwJzPTjZvSDTHO2twimXkWH7jgbO
         bMB0hLsm98/il6bGvm53IjZcLQVy5z1YM3+W3bTNTGoD/sWBk/73FiVt2NJqyaXy4e
         ynlSPUUhC83263oLDQiB2r6lz54MIct2M42bMCxNIK5XZXX+DK4mbQ1g4D9xbCB/ja
         02sc8KG4+j+Ub3b/brmfS2+QV6xaqYOM99xIyHaigpiQJiRtlbvx3xh0ZGp7DOijFb
         mLeg4BsGLryCxkrv950UmBGx+dHkkKciNChr5bFIFuYbjcxzRJg+wOHQBnUpMs42JK
         gAV0IJkoGfgKQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 7FCAB4807EF; Mon, 22 May 2023 19:03:40 +0200 (CEST)
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
Subject: [PATCH v3 5/7] phy: phy-rockchip-inno-usb2: simplify phy clock handling
Date:   Mon, 22 May 2023 19:03:22 +0200
Message-Id: <20230522170324.61349-6-sebastian.reichel@collabora.com>
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

Simplify phyclk handling by using devm_clk_get_optional_enabled to
acquire and enable the optional clock. This also fixes a resource
leak in driver remove path and adds proper error handling.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
index aa8c55609c0d..1cf84869e78b 100644
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

