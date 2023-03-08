Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 176E26B05DA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:23:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231437AbjCHLXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbjCHLXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:23:03 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D281F933;
        Wed,  8 Mar 2023 03:23:00 -0800 (PST)
Received: from jupiter.universe (dyndsl-091-248-211-125.ewe-ip-backbone.de [91.248.211.125])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 64C606602FF1;
        Wed,  8 Mar 2023 11:22:58 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678274578;
        bh=s2e12H1E4UhSPpqxDNG9lVL6rQq63K8jTcBFhbky8Dg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PWDBwQd7lPom216y2V5hxcOsCbaNr5I4ZREz/oIk/xw/3lmH6sd71T6839LvZ/87A
         7hObMp9lOWAX+VcSGikHY5tBBNSds6Q+zJYxuTckZVIt7PdpvX1k+bj3c5waE1NHV/
         3iA5ATYKnA3vzlTrnZ2eUecaf3IUEw0NZ//mkx5BJc7LJkGr9h8TU0xipwQwHka/L8
         +kisnpikbmL4h+Qnl0bvHn60rRW6wBYRNVX1NsC0Pv0YuOX8YS1qyxfabBT833mmbc
         vX29t8Tm3ja7lX5vJ/nW2GslMgM30fcjg3TbfPLGkUrmYc923TkJoWUfRnm8MyHaIZ
         wK18alJ9nTRfQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 712CD48011B; Wed,  8 Mar 2023 12:22:55 +0100 (CET)
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
Subject: [RESEND] [PATCHv3 3/7] thermal: rockchip: Use dev_err_probe
Date:   Wed,  8 Mar 2023 12:22:49 +0100
Message-Id: <20230308112253.15659-4-sebastian.reichel@collabora.com>
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

Use dev_err_probe to simplify error printing in the driver's probe
routine.

Reviewed-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 50 +++++++++++-------------------
 1 file changed, 18 insertions(+), 32 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 6235c033995b..9ed45b318344 100644
--- a/drivers/thermal/rockchip_thermal.c
+++ b/drivers/thermal/rockchip_thermal.c
@@ -1377,35 +1377,26 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
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
@@ -1414,23 +1405,18 @@ static int rockchip_thermal_probe(struct platform_device *pdev)
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
2.39.2

