Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284A965F359
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbjAESEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:04:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234788AbjAESDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:03:49 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43045564CA;
        Thu,  5 Jan 2023 10:03:46 -0800 (PST)
Received: from jupiter.universe (dyndsl-085-016-198-020.ewe-ip-backbone.de [85.16.198.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5D3706602CD7;
        Thu,  5 Jan 2023 18:03:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672941825;
        bh=sbwbPC8CQ9pDo6+I6EbaGiqJManEPRlNV8KKXl/kDSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gls4Mzv+c+/KPrDmXnys6tTry4Su9e0SSucEF8h5b0l+nTCgBykn2cy3CgnB8Rt3k
         Z5MUAGSHGjuIdLQQVRCCYMz6xMaKkKnIe6r59dm9pw+0a+gkXniPNJxeJ2YCiMLnq+
         NUqrKIsBmPtcc3LNfryQsEpghqRSCzHAF5lo3OtjSsun3VOQ85XTJs2LVYLgrnxlW4
         fIRIVi4MRORbXxW/UWVQ1apH1nqRBsTeu26Xn+NWAzaJahOd0Z42Q1E/qu5EjZaxlP
         QrNIFCgEPh6YpP7UDOD2ognfztesuKzM+OmD7DIoX0QVml7sv6Z+4NjuM27kXsF5ZC
         v1UzEf3wL9/wA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A800848011A; Thu,  5 Jan 2023 19:03:42 +0100 (CET)
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
Subject: [PATCHv3 3/7] thermal: rockchip: Use dev_err_probe
Date:   Thu,  5 Jan 2023 19:03:36 +0100
Message-Id: <20230105180340.29140-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230105180340.29140-1-sebastian.reichel@collabora.com>
References: <20230105180340.29140-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dev_err_probe to simplify error printing in the driver's probe
routine.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 50 +++++++++++-------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 74e0ad001b33..0670584533a5 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1379,35 +1379,26 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		return PTR_ERR(thermal->regs);
 
 	thermal->reset = devm_reset_control_array_get(&pdev->dev, false, false);
-	if (IS_ERR(thermal->reset)) {
-		error = PTR_ERR(thermal->reset);
-		dev_err(&pdev->dev, "failed to get tsadc reset: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(thermal->reset))
+		return dev_err_probe(&pdev->dev, PTR_ERR(thermal->reset),
+				     "failed to get tsadc reset.\n");
 
 	thermal->clk = devm_clk_get_enabled(&pdev->dev, "tsadc");
-	if (IS_ERR(thermal->clk)) {
-		error = PTR_ERR(thermal->clk);
-		dev_err(&pdev->dev, "failed to get tsadc clock: %d\n", error);
-		return error;
-	}
+	if (IS_ERR(thermal->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(thermal->clk),
+				     "failed to get tsadc clock.\n");
 
 	thermal->pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
-	if (IS_ERR(thermal->pclk)) {
-		error = PTR_ERR(thermal->pclk);
-		dev_err(&pdev->dev, "failed to get apb_pclk clock: %d\n",
-			error);
-		return error;
-	}
+	if (IS_ERR(thermal->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(thermal->pclk),
+				     "failed to get apb_pclk clock.\n");
 
 	rockchip_thermal_reset_controller(thermal->reset);
 
 	error = rockchip_configure_from_dt(&pdev->dev, np, thermal);
-	if (error) {
-		dev_err(&pdev->dev, "failed to parse device tree data: %d\n",
-			error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				"failed to parse device tree data\n");
 
 	thermal->chip->initialize(thermal->grf, thermal->regs,
 				  thermal->tshut_polarity);
@@ -1416,23 +1407,18 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 		error = rockchip_thermal_register_sensor(pdev, thermal,
 						&thermal->sensors[i],
 						thermal->chip->chn_id[i]);
-		if (error) {
-			dev_err(&pdev->dev,
-				"failed to register sensor[%d] : error = %d\n",
-				i, error);
-			return error;
-		}
+		if (error)
+			return dev_err_probe(&pdev->dev, error,
+				"failed to register sensor[%d].\n", i);
 	}
 
 	error = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 					  &rockchip_thermal_alarm_irq_thread,
 					  IRQF_ONESHOT,
 					  "rockchip_thermal", thermal);
-	if (error) {
-		dev_err(&pdev->dev,
-			"failed to request tsadc irq: %d\n", error);
-		return error;
-	}
+	if (error)
+		return dev_err_probe(&pdev->dev, error,
+				     "failed to request tsadc irq.\n");
 
 	thermal->chip->control(thermal->regs, true);
 
-- 
2.39.0

