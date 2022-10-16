Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1996A60044E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiJPXmt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:42:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiJPXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BBE27CFD;
        Sun, 16 Oct 2022 16:42:26 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id j16so16017098wrh.5;
        Sun, 16 Oct 2022 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iQ42DvT7kTgetW5TS8dmSiYkpUS6xNSvrMGj0peFw8=;
        b=o2Qhxs69zm3BrTRBcSq0mgrrFPeS3SQwliVPzpHd97HNYWLvDMxJpdDSpOvb1Fy4ye
         nA/qOVrkWItaVL3PUdKgaRv9Ag3hQnZuusaA/+tO22hW2AlctKoZhJTi7XPkx0qbuW8T
         AGj640QhXYm0ZkV+17VFia8V6rHjM33bpOjGq0z/wRdf05n4ziC6SbX8EgeZkaBUNRXW
         vP5BVPrqGF407P5Fgochq0+HyIp/nZ9QqeNbCapziCpXJC551p+BP8D7tjg8X1xzTlhn
         hvKL6hqTyb4p/X73JclOclG/WhPthJcvnb5viPAniFUuaVnyzVyHF87zC3GYdOjKpnUg
         CoLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9iQ42DvT7kTgetW5TS8dmSiYkpUS6xNSvrMGj0peFw8=;
        b=iIeWHo++uYtWytgvRPVFv4oNW1Q5T9+jzp3ErSwYtHxR48AWsVqPCt7l7064VrfEY6
         ey+lgzO6NrXZ+buWMf2LLi4iCgWfE/C7l70MF51shbeImOXhcgMy35Y0uZNztnlD2jBD
         EKor56wgXbJrxqgTBwqG7tESCl/XCtJjTHJPhyBiNv0bp7rEoYWuALjzcq1jCs/BBWBF
         I4u1nhsaqvjuMLnix+UTHqT/JYEKXG9VhoZgVw1ZhmC+eBTFIYYPztc3MJJdoPmewEj2
         9e6W8aU6mKZzQH+SwUiGW6bZ0xkxaf/spL+WkrXq2CzFEMGkp7JBd0nBSdhMy+PZAZiH
         iUtg==
X-Gm-Message-State: ACrzQf2GRTlX7446y9vDfFhpmOlp2jLM6aSaP0d+ZY4JUonZkTOd4Rby
        ujhG4o3V0YkJHes14MtIeLI=
X-Google-Smtp-Source: AMsMyM61lMMzVHbrWF/FTBy/pbOCUMsGU2H4CyKaCzslxskg3aLjsjEZPWk4Q8+fxjdVwygtNOxeqA==
X-Received: by 2002:a5d:4d07:0:b0:22e:3c45:9f00 with SMTP id z7-20020a5d4d07000000b0022e3c459f00mr4573014wrt.646.1665963746468;
        Sun, 16 Oct 2022 16:42:26 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id f7-20020a1cc907000000b003b31c560a0csm8397203wmb.12.2022.10.16.16.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:26 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, wens@csie.org,
        lee.jones@linaro.org, sre@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com,
        linus.walleij@linaro.org, brgl@bgdev.pl, michael@walle.cc,
        samuel@sholland.org, linux-iio@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v6 08/13] iio: adc: axp20x_adc: Replace adc_en2 flag with adc_en2_mask field
Date:   Mon, 17 Oct 2022 00:43:30 +0100
Message-Id: <20221016234335.904212-9-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
References: <20221016234335.904212-1-aidanmacdonald.0x0@gmail.com>
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
2.38.0

