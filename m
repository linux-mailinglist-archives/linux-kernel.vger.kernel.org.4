Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60035705AEF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjEPXDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjEPXDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:03:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7102F76AF;
        Tue, 16 May 2023 16:03:20 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPv6:2405:201:0:21ea:73f6:2283:f432:3936])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: shreeya)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CAF2B6605905;
        Wed, 17 May 2023 00:03:07 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684278199;
        bh=RWQQOKamedoTAntnFqnzwlUZr9v/kXvlyH/KIUMibi8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hJ6hRVnWUNx/wTbz9VOZyhxzThiln65c/Xm2TrwTyUH2C0tP3Ylz44bLicMLiNUrT
         cTmDCsj8UKc/noPQT0XJZBVrFDIPj2Hpl2Op+CDwKoOlZyaNBjfmz2r7eQniJVLYDs
         ynNdCPaTmJYEJgpVviA0Q/JnDmfeteD1Q6R5A9r3S+2eug4UpdGXBk24tBIrJf225D
         dG6THNld5Qep0qTjIGjJ9inELncAWQymF8iYZIaVoxpam+E3SXs1HHe4uRYRZBvNqr
         dQlGt5KQcFIinGlkHBKeKicP8Qv9Bq8d1D6vgAFS0W0XrD6vNSfo9nDsCcyHpivJnr
         Rhko8y1Ef7UdA==
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
Subject: [PATCH 3/7] iio: adc: rockchip_saradc: Use of_device_get_match_data
Date:   Wed, 17 May 2023 04:30:47 +0530
Message-Id: <20230516230051.14846-4-shreeya.patel@collabora.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230516230051.14846-1-shreeya.patel@collabora.com>
References: <20230516230051.14846-1-shreeya.patel@collabora.com>
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

Use of_device_get_match_data() to simplify the code.

Signed-off-by: Shreeya Patel <shreeya.patel@collabora.com>
---
 drivers/iio/adc/rockchip_saradc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/rockchip_saradc.c b/drivers/iio/adc/rockchip_saradc.c
index 05b66eff9a44..05ea823a8f16 100644
--- a/drivers/iio/adc/rockchip_saradc.c
+++ b/drivers/iio/adc/rockchip_saradc.c
@@ -408,10 +408,10 @@ static void rockchip_saradc_regulator_unreg_notifier(void *data)
 
 static int rockchip_saradc_probe(struct platform_device *pdev)
 {
+	const struct rockchip_saradc_data *match_data;
 	struct rockchip_saradc *info = NULL;
 	struct device_node *np = pdev->dev.of_node;
 	struct iio_dev *indio_dev = NULL;
-	const struct of_device_id *match;
 	int ret;
 	int irq;
 
@@ -425,13 +425,13 @@ static int rockchip_saradc_probe(struct platform_device *pdev)
 	}
 	info = iio_priv(indio_dev);
 
-	match = of_match_device(rockchip_saradc_match, &pdev->dev);
-	if (!match) {
+	match_data = of_device_get_match_data(&pdev->dev);
+	if (!match_data) {
 		dev_err(&pdev->dev, "failed to match device\n");
 		return -ENODEV;
 	}
 
-	info->data = match->data;
+	info->data = match_data;
 
 	/* Sanity check for possible later IP variants with more channels */
 	if (info->data->num_channels > SARADC_MAX_CHANNELS) {
-- 
2.30.2

