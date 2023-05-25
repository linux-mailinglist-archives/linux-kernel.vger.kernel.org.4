Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAD80711916
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 23:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjEYV2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 17:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241377AbjEYV2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 17:28:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17739E49;
        Thu, 25 May 2023 14:28:14 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 303346606E81;
        Thu, 25 May 2023 22:28:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685050092;
        bh=dLuu0SEFNcIqh//QlQCte4G4opm+zXpvYd73IcKTf1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LEKdNo3mLOU+adE2Y7F/aUFFUhZfZ4UXAGvUd2GlJT0kQHuvss+mbsX/O/73C6y6E
         JabCu7NLEA/RPKe+5vEv5Wvs71PpxdKY0nFiXIfQu6kah/uk8fTlJiFmB8bipNl/SB
         Xq7EkfAvk7sSkvTZplkeRD0B1yH/9Xt0nVRSG6wEgTkP6xjF35MzQX8NZvFcFMBrVg
         JPBaude2yN99FKCnjjYqDbOd75/dZofAW4wHFtdUDLuQ2Te6V7D05pWlt8w+N0uqDy
         /ZEnRHCyETPZlASaBNmn6KKvvGOhkNBMYNShvT0TJ3udbjltyeEZKiwlJfRqVtSfBC
         iZI6NjMpv2bXA==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, gustavo.padovan@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v2 3/8] iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled
Date:   Fri, 26 May 2023 02:57:07 +0530
Message-Id: <20230525212712.255406-4-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230525212712.255406-1-shreeya.patel@collabora.com>
References: <20230525212712.255406-1-shreeya.patel@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use devm_clk_get_enabled() to avoid manually disabling the
clock.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v2
  - No need to enable the clocks earlier than the original code.
    Move the enablement of clocks at it's original position.

 drivers/iio/adc/rockchip_saradc.c | 73 ++++---------------------------
 1 file changed, 9 insertions(+), 64 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 31637440be83..41226b76a995 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -345,20 +345,6 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
 	reset_control_deassert(reset);
 }
 
-static void rockchip_saradc_clk_disable(void *data)
-{
-	struct rockchip_saradc *info = data;
-
-	clk_disable_unprepare(info->clk);
-}
-
-static void rockchip_saradc_pclk_disable(void *data)
-{
-	struct rockchip_saradc *info = data;
-
-	clk_disable_unprepare(info->pclk);
-}
-
 static void rockchip_saradc_regulator_disable(void *data)
 {
 	struct rockchip_saradc *info = data;
@@ -492,16 +478,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	info->pclk = devm_clk_get(&pdev->dev, "apb_pclk");
-	if (IS_ERR(info->pclk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->pclk),
-				     "failed to get pclk\n");
-
-	info->clk = devm_clk_get(&pdev->dev, "saradc");
-	if (IS_ERR(info->clk))
-		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
-				     "failed to get adc clock\n");
-
 	info->vref = devm_regulator_get(&pdev->dev, "vref");
 	if (IS_ERR(info->vref))
 		return dev_err_probe(&pdev->dev, PTR_ERR(info->vref),
@@ -539,31 +515,15 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
 	info->uv_vref = ret;
 
-	ret = clk_prepare_enable(info->pclk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable pclk\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rockchip_saradc_pclk_disable, info);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register devm action, %d\n",
-			ret);
-		return ret;
-	}
+	info->pclk = devm_clk_get_enabled(&pdev->dev, "apb_pclk");
+	if (IS_ERR(info->pclk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->pclk),
+				     "failed to get pclk\n");
 
-	ret = clk_prepare_enable(info->clk);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable converter clock\n");
-		return ret;
-	}
-	ret = devm_add_action_or_reset(&pdev->dev,
-				       rockchip_saradc_clk_disable, info);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register devm action, %d\n",
-			ret);
-		return ret;
-	}
+	info->clk = devm_clk_get_enabled(&pdev->dev, "saradc");
+	if (IS_ERR(info->clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(info->clk),
+				     "failed to get adc clock\n");
 
 	platform_set_drvdata(pdev, indio_dev);
 
@@ -600,8 +560,6 @@ static int rockchip_saradc_suspend(struct device *dev)
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rockchip_saradc *info = iio_priv(indio_dev);
 
-	clk_disable_unprepare(info->clk);
-	clk_disable_unprepare(info->pclk);
 	regulator_disable(info->vref);
 
 	return 0;
@@ -611,21 +569,8 @@ static int rockchip_saradc_resume(struct device *dev)
 {
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct rockchip_saradc *info = iio_priv(indio_dev);
-	int ret;
-
-	ret = regulator_enable(info->vref);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(info->pclk);
-	if (ret)
-		return ret;
-
-	ret = clk_prepare_enable(info->clk);
-	if (ret)
-		clk_disable_unprepare(info->pclk);
 
-	return ret;
+	return regulator_enable(info->vref);
 }
 
 static DEFINE_SIMPLE_DEV_PM_OPS(rockchip_saradc_pm_ops,
-- 
2.30.2

