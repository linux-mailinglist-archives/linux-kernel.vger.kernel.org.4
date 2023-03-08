Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393756B05CE
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231389AbjCHLXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbjCHLXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:23:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A33E0168B8;
        Wed,  8 Mar 2023 03:23:00 -0800 (PST)
Received: from jupiter.universe (dyndsl-091-248-211-125.ewe-ip-backbone.de [91.248.211.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 54A666602FEF;
        Wed,  8 Mar 2023 11:22:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678274578;
        bh=zBbVvDeuWMNfmUh52W1XZgduf0xZ4UgsGRTcx/DthA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZWQXMK4fD5rz7S1SLeS7mPWnuKPUIf/m/+XtfPvn7/5lU4QKPnAdv3sRHnlwUhlio
         aqUjUQzxat5OU5Bua/a46TEzV8fF0vx1kOaDcHJf+zhl7sNOJUNa1AT9aEPUsUVJJH
         5ttKoLPbJGI/hLKLqejgGI8zClNmQFV1enXpXEjtmJSyQ6UoCiU1tE1JH/SW31/wqr
         smvZ8y50RaQAjCq4TcepCETVTS7ky2hbMGel2X3N7LlDxY7Bt49q1/sLpGAmcUQFG5
         XamejIer7gNy/Xa9qmpJKzABJ1KT6OQ9155GbbTFoSbwGJ/VZO5x3M0WOj61NbPU8N
         lxxFR4plqhBWg==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 6F161480117; Wed,  8 Mar 2023 12:22:55 +0100 (CET)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
Subject: [RESEND] [PATCHv3 2/7] thermal: rockchip: Simplify clock logic
Date:   Wed,  8 Mar 2023 12:22:48 +0100
Message-Id: <20230308112253.15659-3-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230308112253.15659-1-sebastian.reichel@collabora.com>
References: <20230308112253.15659-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By using devm_clk_get_enabled() the clock acquisition and
enabling can be done in one step with automatic error
handling.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 33 +++++-------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 7e88525fe8d0..6235c033995b 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1383,14 +1383,14 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	thermal->clk = devm_clk_get(&pdev->dev, "tsadc");
+	thermal->clk = devm_clk_get_enabled(&pdev->dev, "tsadc");
 	if (IS_ERR(thermal->clk)) {
 		error = PTR_ERR(thermal->clk);
 		dev_err(&pdev->dev, "failed to get tsadc clock: %d\n", error);
 		return error;
 	}
 
-	thermal->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
+	thermal->pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
 	if (IS_ERR(thermal->pclk)) {
 		error = PTR_ERR(thermal->pclk);
 		dev_err(&pdev->dev, "failed to get apb_pclk clock: %d\n",
@@ -1398,26 +1398,13 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return error;
 	}
 
-	error = clk_prepare_enable(thermal->clk);
-	if (error) {
-		dev_err(&pdev->dev, "failed to enable converter clock: %d\n",
-			error);
-		return error;
-	}
-
-	error = clk_prepare_enable(thermal->pclk);
-	if (error) {
-		dev_err(&pdev->dev, "failed to enable pclk: %d\n", error);
-		goto err_disable_clk;
-	}
-
 	rockchip_thermal_reset_controller(thermal->reset);
 
 	error = rockchip_configure_from_dt(&pdev->dev, np, thermal);
 	if (error) {
 		dev_err(&pdev->dev, "failed to parse device tree data: %d\n",
 			error);
-		goto err_disable_pclk;
+		return error;
 	}
 
 	thermal->chip->initialize(thermal->grf, thermal->regs,
@@ -1431,7 +1418,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to register sensor[%d] : error = %d\n",
 				i, error);
-			goto err_disable_pclk;
+			return error;
 		}
 	}
 
@@ -1442,7 +1429,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed to request tsadc irq: %d\n", error);
-		goto err_disable_pclk;
+		return error;
 	}
 
 	thermal->chip->control(thermal->regs, true);
@@ -1460,13 +1447,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, thermal);
 
 	return 0;
-
-err_disable_pclk:
-	clk_disable_unprepare(thermal->pclk);
-err_disable_clk:
-	clk_disable_unprepare(thermal->clk);
-
-	return error;
 }
 
 static int rockchip_thermal_remove(struct platform_device *pdev)
@@ -1483,9 +1463,6 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 
 	thermal->chip->control(thermal->regs, false);
 
-	clk_disable_unprepare(thermal->pclk);
-	clk_disable_unprepare(thermal->clk);
-
 	return 0;
 }
 
-- 
2.39.2

