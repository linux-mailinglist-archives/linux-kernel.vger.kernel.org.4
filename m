Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5522865F34B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 19:03:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbjAESDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 13:03:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230015AbjAESDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 13:03:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43106564CB;
        Thu,  5 Jan 2023 10:03:47 -0800 (PST)
Received: from jupiter.universe (dyndsl-085-016-198-020.ewe-ip-backbone.de [85.16.198.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 49DD46602CCE;
        Thu,  5 Jan 2023 18:03:45 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1672941825;
        bh=xIMSW4AOlAHM6XznKwVJh8dNalSiPuEcNwEAA+jCX+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ARcEhpNhY8IjBHP1mZiLKhnqOgnoKS1kPMfjbrZixL0pJ13OycZhhxh8Ctc6eQAE5
         soGLACoxLgOJZ3n+9Pl//W7Rz46EPVWcFNrftD2asguPWfhBn9hcTiul8ZOClVJCux
         lzvxPvb81YcdDhg3r+fL65mP/xI7/KFnBKUL2TaORQ6ivQlyO/mnRFy9Ov+/Fh02LD
         rSktOEczDffayNaMzST6/Wxf9LPIngjXFEgsIlx9JRBYOzpEm49EzZMJy1uzlDLqy2
         XaZcyWpDt4VmpcJbN5AFHQBwr9Wjv9AEr93cR95bYFiVUNIlA41ZtfGCuXyv1RJEEm
         h0XTt4o9DLSrw==
Received: by jupiter.universe (Postfix, from userid 1000)
        id A6CFF480119; Thu,  5 Jan 2023 19:03:42 +0100 (CET)
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
Subject: [PATCHv3 2/7] thermal: rockchip: Simplify clock logic
Date:   Thu,  5 Jan 2023 19:03:35 +0100
Message-Id: <20230105180340.29140-3-sebastian.reichel@collabora.com>
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

By using devm_clk_get_enabled() the clock acquisition and
enabling can be done in one step with automatic error
handling.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 33 +++++-------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 8c52700d58e8..74e0ad001b33 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1385,14 +1385,14 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
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
@@ -1400,26 +1400,13 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
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
@@ -1433,7 +1420,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 			dev_err(&pdev->dev,
 				"failed to register sensor[%d] : error = %d\n",
 				i, error);
-			goto err_disable_pclk;
+			return error;
 		}
 	}
 
@@ -1444,7 +1431,7 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
 	if (error) {
 		dev_err(&pdev->dev,
 			"failed to request tsadc irq: %d\n", error);
-		goto err_disable_pclk;
+		return error;
 	}
 
 	thermal->chip->control(thermal->regs, true);
@@ -1462,13 +1449,6 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
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
@@ -1485,9 +1465,6 @@ static int rockchip_thermal_remove(struct platform_device *pdev)
 
 	thermal->chip->control(thermal->regs, false);
 
-	clk_disable_unprepare(thermal->pclk);
-	clk_disable_unprepare(thermal->clk);
-
 	return 0;
 }
 
-- 
2.39.0

