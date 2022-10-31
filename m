Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C26B8613C8E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiJaRvS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiJaRvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:51:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6663C63E0;
        Mon, 31 Oct 2022 10:51:03 -0700 (PDT)
Received: from jupiter.universe (dyndsl-095-033-157-181.ewe-ip-backbone.de [95.33.157.181])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7CADC660290F;
        Mon, 31 Oct 2022 17:51:01 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667238661;
        bh=7J3K+zPuxxNR3IXEOaesAW1rMsS9Y33MQd/6Z4GSCzo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k32Z1g7zMJRZklE7ffW5U9Hl9YVQI47r3g26AkTm+srupfEGO2BF3ldm/xx/T07fj
         BokmH1TUj2BDaZOdQ+LH602ToZ0N9p0dcHVvZJrC412w05F5Lfk2Cbr0w9iqCt7u/A
         PVNyTxwVkfLUBJvVQsE7UVUQfonxi0mYVQ4KmrTrzlpYjDLFXqPhTxgTjhC9gEJ1/1
         RhxKetx/PQNvIVEhyw0UgmYg6oNU1N9xNxGHS7qZDlVSoGzPK7FYnZBmQslXesUB8l
         XGJtxqtXI/TkBbv+LEruK8HiHH6htC+fAsYkn/vR8EHUrFzSptRPj5ObdHg2fTpQbE
         hB5a6dFz64yFQ==
Received: by jupiter.universe (Postfix, from userid 1000)
        id 4F0CE4801C4; Mon, 31 Oct 2022 18:50:59 +0100 (CET)
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
Subject: [PATCH 2/7] thermal: rockchip: Simplify clock logic
Date:   Mon, 31 Oct 2022 18:50:53 +0100
Message-Id: <20221031175058.175698-3-sebastian.reichel@collabora.com>
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

By using devm_clk_get_enabled() the clock acquisition and
enabling can be done in one step with automatic error
handling.

Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/thermal/rockchip_thermal.c | 33 +++++-------------------------
 1 file changed, 5 insertions(+), 28 deletions(-)

diff --git a/drivers/thermal/rockchip_thermal.c b/drivers/thermal/rockchip_thermal.c
index 0a0f38c29842..6d680bea0734 100644
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
2.35.1

