Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA6D7211AD
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 20:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbjFCSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjFCSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 14:55:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C6ACA;
        Sat,  3 Jun 2023 11:54:58 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:e49:10dd:40c0:e842])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DBE516603147;
        Sat,  3 Jun 2023 19:54:52 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1685818496;
        bh=8dxa3AxEBlpgUQ0ClMFRIptu4pfjEzefRs26x8e/iQo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cOTtYJhlLAEFYNPHn0rH56xZmVBUVaHNl5WbXHeLOijuS7R3nL6QgaYz4qV2gtQAG
         N6CY3vizDt0XoPpM6VJty3McTXSngliMiLlr9gsaXRCZY/7ZT8IZTAnaSTpdcY/xhJ
         yGbssgM4o6mU60feoq+ietYuogC3bZpJs818rrCmplbVyAs4fpWw0BlKRic4yQQVuO
         j/ou0vQDxEP3dUeeVITiSyEmAUheHwJpqZOmugBcoAmmg7Z/JAXvxbNEKxblSE0ovG
         +sT3GCZwWOfAzbqo08d6e0srfq4csdn9XMwlUpvmIYMffck3fuF67iXNY5JhCQ4glt
         6Iu63USJi+2NA==
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
Subject: [PATCH v3 6/8] iio: adc: rockchip_saradc: Use dev_err_probe
Date:   Sun,  4 Jun 2023 00:23:38 +0530
Message-Id: <20230603185340.13838-7-shreeya.patel@collabora.com>
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

Use dev_err_probe instead of dev_err in probe function,
which simplifies code a little bit and prints the error
code.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---

Changes in v3
  - No change

Changes in v2
  - No change

 drivers/iio/adc/rockchip_saradc.c | 45 ++++++++++++++-----------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 436e219984fd..921844d9232d 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -425,25 +425,23 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 		return -ENODEV;
 
 	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*info));
-	if (!indio_dev) {
-		dev_err(&pdev->dev, "failed allocating iio device\n");
-		return -ENOMEM;
-	}
+	if (!indio_dev)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed allocating iio device\n");
+
 	info = iio_priv(indio_dev);
 
 	match_data = of_device_get_match_data(&pdev->dev);
-	if (!match_data) {
-		dev_err(&pdev->dev, "failed to match device\n");
-		return -ENODEV;
-	}
+	if (!match_data)
+		return dev_err_probe(&pdev->dev, -ENODEV,
+				     "failed to match device\n");
 
 	info->data = match_data;
 
 	/* Sanity check for possible later IP variants with more channels */
-	if (info->data->num_channels > SARADC_MAX_CHANNELS) {
-		dev_err(&pdev->dev, "max channels exceeded");
-		return -EINVAL;
-	}
+	if (info->data->num_channels > SARADC_MAX_CHANNELS)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "max channels exceeded");
 
 	info->regs = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(info->regs))
@@ -491,23 +489,20 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	 * This may become user-configurable in the future.
 	 */
 	ret = clk_set_rate(info->clk, info->data->clk_rate);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to set adc clk rate, %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to set adc clk rate\n");
 
 	ret = regulator_enable(info->vref);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to enable vref regulator\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to enable vref regulator\n");
+
 	ret = devm_add_action_or_reset(&pdev->dev,
 				       rockchip_saradc_regulator_disable, info);
-	if (ret) {
-		dev_err(&pdev->dev, "failed to register devm action, %d\n",
-			ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to register devm action\n");
 
 	ret = regulator_get_voltage(info->vref);
 	if (ret < 0)
-- 
2.30.2

