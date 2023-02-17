Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F10C69AF99
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjBQPe5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:34:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBQPez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:34:55 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8A76F3E9;
        Fri, 17 Feb 2023 07:34:52 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f19so1211460wml.3;
        Fri, 17 Feb 2023 07:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eoAGYS91FVNG59X2nIHtCAzt1nj2bSLTdLXaWRLOUNE=;
        b=OavKJms6ALhkrMR1m9fe7oCgVuAoPgsTkYT46lgNtZSUcZzl8bKdOd+ZQq5so5vG6Z
         nQKU27ewVU8pxf/cGXeoFafzkwbbIHi/S9Uzqv5qcGTst8RmHAiDJ6SWIX0NuDQO1iwG
         0LPMVNrW89XKFNa7dubcmjJnx/jsN0ZkJ/WmESBe+auYmqH+pApFUPbmkzf7OupRCBPe
         f3tTAT+jhgz57d2+BJpOfvHvR9+PI+wlHca8IjZulO/NnGb9MjGknxqWi8S5NwnYhpVS
         n/xXLSV9a/a8ocgINrB3+l/E1Yi7PHqt/RWaiPWvgzo/g18ESbPRGMgNSEKpTQX6B5e3
         BghA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eoAGYS91FVNG59X2nIHtCAzt1nj2bSLTdLXaWRLOUNE=;
        b=O6QyfXP663O/QUKyg4Em2y0srH2NO693ka7kzvwqET12MEE0IFfeVESIOnhFShpAa/
         T177UW6TiqX+wwtNbkqHWZ1K2vE0vylmLqaWfY/z8lbj0MIeSqnIoMYnIUEpwd2uA4sa
         NFKdjYk/oNEznl8leklUblgKR86/pGnsnI95XOIdPhUv+ofz85TlXfDT61FACqBdPwGB
         i/lCxyFmMEviKYMr8rDORCpinwGUkV59LXUFKXbhRCJehhHmJjBR2Fo0Wtxod68AGjY3
         Dsu7r1Bcu87iCwM2wyNvplDi3ln75/UmqDcgRvkR7bMRQHqQFLAAVpcujKgJnAujZ0OP
         6pjw==
X-Gm-Message-State: AO0yUKUjeDkvSWMBIv73KRI7klllCtlClQFJPsaTpubW2fe8+4q0iECX
        6y7dMM7SJv1HndwEPyM3aA8=
X-Google-Smtp-Source: AK7set+HevX6S73TaNLg8NdV4/e8W88YLSkEKn1cyGTHRiTb9UAnCwET3jslXQK+jt4Gc+7o6WW5dg==
X-Received: by 2002:a05:600c:502c:b0:3d1:caf1:3f56 with SMTP id n44-20020a05600c502c00b003d1caf13f56mr5302613wmr.9.1676648091421;
        Fri, 17 Feb 2023 07:34:51 -0800 (PST)
Received: from localhost (94.197.16.234.threembb.co.uk. [94.197.16.234])
        by smtp.gmail.com with ESMTPSA id f19-20020a1c6a13000000b003e0238d9101sm5031209wmc.31.2023.02.17.07.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:34:51 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org
Cc:     wens@csie.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH v6 2/2] iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
Date:   Fri, 17 Feb 2023 15:34:04 +0000
Message-Id: <20230217153404.32481-2-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20230217153404.32481-1-aidanmacdonald.0x0@gmail.com>
References: <20230217153404.32481-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The adc_en2 flag is essentially specific to axp20x-compatible devices
because it hardcodes register values. Replace it with a mask field
so the register value can be specified in device match data.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
This is a resend of a preparatory patch from a larger series adding support
for the AXP192 PMIC[1]. Since I don't think there's much hope of getting it
merged in one development cycle, there's no point letting these cleanups sit
around unapplied -- apply them whenever convienient!

[1] https://lore.kernel.org/all/20221016234335.904212-1-aidanmacdonald.0x0@gmail.com/

---
 drivers/iio/adc/axp20x_adc.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index ab25e6e1ff65..75bda94dbce1 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -623,9 +623,9 @@ struct axp_data {
 	int				num_channels;
 	struct iio_chan_spec const	*channels;
 	unsigned long			adc_en1_mask;
+	unsigned long			adc_en2_mask;
 	int				(*adc_rate)(struct axp20x_adc_iio *info,
 						    int rate);
-	bool				adc_en2;
 	struct iio_map			*maps;
 };
 
@@ -634,8 +634,8 @@ static const struct axp_data axp20x_data = {
 	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
 	.channels = axp20x_adc_channels,
 	.adc_en1_mask = AXP20X_ADC_EN1_MASK,
+	.adc_en2_mask = AXP20X_ADC_EN2_MASK,
 	.adc_rate = axp20x_adc_rate,
-	.adc_en2 = true,
 	.maps = axp20x_maps,
 };
 
@@ -645,7 +645,6 @@ static const struct axp_data axp22x_data = {
 	.channels = axp22x_adc_channels,
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp22x_adc_rate,
-	.adc_en2 = false,
 	.maps = axp22x_maps,
 };
 
@@ -655,7 +654,6 @@ static const struct axp_data axp813_data = {
 	.channels = axp813_adc_channels,
 	.adc_en1_mask = AXP22X_ADC_EN1_MASK,
 	.adc_rate = axp813_adc_rate,
-	.adc_en2 = false,
 	.maps = axp22x_maps,
 };
 
@@ -713,10 +711,10 @@ static int axp20x_probe(struct platform_device *pdev)
 	/* Enable the ADCs on IP */
 	regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
 
-	if (info->data->adc_en2)
-		/* Enable GPIO0/1 and internal temperature ADCs */
+	if (info->data->adc_en2_mask)
 		regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
-				   AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
+				   info->data->adc_en2_mask,
+				   info->data->adc_en2_mask);
 
 	/* Configure ADCs rate */
 	info->data->adc_rate(info, 100);
@@ -741,7 +739,7 @@ static int axp20x_probe(struct platform_device *pdev)
 fail_map:
 	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
 
-	if (info->data->adc_en2)
+	if (info->data->adc_en2_mask)
 		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
 
 	return ret;
@@ -757,7 +755,7 @@ static int axp20x_remove(struct platform_device *pdev)
 
 	regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
 
-	if (info->data->adc_en2)
+	if (info->data->adc_en2_mask)
 		regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
 
 	return 0;
-- 
2.39.2

