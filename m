Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95E70613C90
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbiJaRvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231761AbiJaRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:51:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A1F640D;
        Mon, 31 Oct 2022 10:51:03 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-157-181.ewe-ip-backbone.de [95.33.157.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8D0756602923;
        Mon, 31 Oct 2022 17:51:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667238661;
        bh=+qY+C6EGTnTjDDxzojbaxh4GdVbARIg1OLM2mDdh7mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=in67QW6MMSO6F3j1G1W8w/CEg6nQR/gYVukjyvYf2zn903cibBfOtCcWlTSsXQeiN
         kUmbpOEZBPh1rTw4l2u1v3sgA7EtdyY25fiBRoanWazUPH9vEnqpkQGvg2+dvditAU
         F7HepoFHdE0JXHHxnEBMDm2SAbB1Co13HRsD72SFQvzJBLj+qOJ7Ifb1Lvr3C496BT
         +YM+cj/xxqXjjfQqnanThkm/DKmonkAkh1ceG7ddCs5qmuUPtLRA6aH96Sd5Bsrdx7
         JZKKPwty1+0qDIp5FzgK7pUEC0GvUj3/68mD3WY2VqYutOPbt8hNc3nMVX6tFYwbqA
         eVXRU09kFN3jw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 511BE4801C7; Mon, 31 Oct 2022 18:50:59 +0100 (CET)
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
Subject: [PATCH 3/7] thermal: rockchip: Use dev_err_probe
Date:   Mon, 31 Oct 2022 18:50:54 +0100
Message-Id: <20221031175058.175698-4-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221031175058.175698-1-sebastian.reichel@collabora.com>
References: <20221031175058.175698-1-sebastian.reichel@collabora.com>
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

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 50 +++++++++++-------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 6d680bea0734..3dab31f163b3 100644
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
2.35.1

