Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02C17211A4
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbjFCSyt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjFCSyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:54:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A8F197;
        Sat,  3 Jun 2023 11:54:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 8C15766031BB;
        Sat,  3 Jun 2023 19:54:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685818479;
        bh=3LQsZ14e2cVfHZN107KymnzFhYRU0E11A9f45uJB4io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JNQThkngO8TEScja0x+PQ1s5ANOp1fLarmN/MuzK+NSb75MwFkKNmnGuvlHSnXeLh
         q2eC2f/EwWMhxNlxkFxmHAiKvm5E0xC34bSQ6tbqWo7ua0FHHbbK+NKwuakSATjY5B
         kHnSZO3DSF1TQ7ZxbNOhCWRU2bAtvXwZT63AThAK/XtV1KkxnvbyY39aQi0sP4wE/Z
         S+078He6GqEcg+isBGtt5Mj/+4Tjdm1nVSo+dwDmBkNkr61ogWA9HHBzgBlCaubtG1
         8UHKzF/6a3tSetMJc4acVKEyVs6XLdWj+imYjSK4mAX+aaLY8mFTHnQmAzAvWrvqBM
         OLVPtmQP9G5yw==
From:   Shreeya Patel <shreeya.patel@collabora.com>
To:     jic23@kernel.org, lars@metafoo.de, heiko@sntech.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sebastian.reichel@collabora.com
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        gustavo.padovan@collabora.com, kernel@collabora.com,
        serge.broslavsky@collabora.com,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: [PATCH v3 3/8] iio: adc: rockchip_saradc: Make use of devm_clk_get_enabled
Date:   Sun,  4 Jun 2023 00:23:35 +0530
Message-Id: <20230603185340.13838-4-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230603185340.13838-1-shreeya.patel@collabora.com>
References: <20230603185340.13838-1-shreeya.patel@collabora.com>
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

Changes in v3
  - Do not remove clock enabling and disabling from the suspend and
    resume functions respectively.

Changes in v2
  - No need to enable the clocks earlier than the original code.
    Move the enablement of clocks at it's original position.

 drivers/iio/adc/rockchip_saradc.c | 56 +++++--------------------------
 1 file changed, 8 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 312286ec91dc..ac424ea50787 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -346,20 +346,6 @@ static void rockchip_saradc_reset_controller(struct reset_control *reset)
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
@@ -493,16 +479,6 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
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
@@ -540,31 +516,15 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 
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
 
-- 
2.30.2

