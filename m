Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEB600454
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbiJPXnA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiJPXms (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:48 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 407CB27926;
        Sun, 16 Oct 2022 16:42:29 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id r3-20020a05600c35c300b003b4b5f6c6bdso8796039wmq.2;
        Sun, 16 Oct 2022 16:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZVDsQVUoXvmNA77LPJOpJward80S9xfbJHcpTm+nB6k=;
        b=LdxhTUGv6G/jlHfDy9pL7GUcaGdHPUeipIafb3dmrWm7Y2wyMQRFqvBwtKK8Ji6cpY
         nl045tPCGMpLFcHbwnuokGlpuAejRaoqnZR2dGu9dIrS4t8jeNUygscvUE7DifymeyZe
         hMnqIT1rM60SORrNdgs/vu/XYFFQpGzrG+cHVviow0qbo/M2G3fEYMB+lSDZrhsMmz4H
         Uc6S3RFfqz1s0Gj/P4otHikC7+SCcqdESEq7Da+JprHXigiMLPwsCI8OxsoF1rcAswuY
         Tr78r4C5/wag+SZSy2MCcAZ0cqDKRSHx+YQbA0IQt1PTnIBb0Ee/csk0+dqAoIbGFqRi
         X6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZVDsQVUoXvmNA77LPJOpJward80S9xfbJHcpTm+nB6k=;
        b=FoEcxfzYIakofNr6lxferrHQ2eoMl6edYTaZVm0rDlS1heiOk0jpYWPQkrg6nhljlf
         efvg2lPh0QwTusTTC1Cfi2jHH8K/+/EeEGVM7GCT7RdImEgiNsgY6sEZ2Vut0wKSqOCS
         H6CW/ZEGtri/mABGBHkq+FfKY/SWvgsm0SCAHRTgZ03l55rF7UkFCdILmGxmobeATvwh
         vg76o05sOr1UnAUm4DZ5hlg/Rxh2rYPluCS/unihLF0W1SgLowFdEb+LbVavxumrem0a
         aZYhrQzHWY9syG/jUBrCQOIJhQAawz6fFI72T+OlK7HlCAIdk8QcDjJdc7vwSco3tf5J
         FpXg==
X-Gm-Message-State: ACrzQf0rHbUhLtMbTUi2S0AetKDFQYn8AU7nNs8qsdsrc4uJWG269L56
        1/BGSvgFVgU8Bp69HV1xpWY=
X-Google-Smtp-Source: AMsMyM5nWP/Bnp/5xlA33MAoj44akUajQaDLEcURpTH8g/8ghQI4o1ULBLs45uyXTcT9+jfuFyRQZg==
X-Received: by 2002:a1c:f60d:0:b0:3be:708b:c96c with SMTP id w13-20020a1cf60d000000b003be708bc96cmr17752477wmc.168.1665963747975;
        Sun, 16 Oct 2022 16:42:27 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id p14-20020a05600c468e00b003c6f3e5ba42sm3442346wmo.46.2022.10.16.16.42.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:27 -0700 (PDT)
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
Subject: [PATCH v6 09/13] iio: adc: axp20x_adc: Add support for AXP192
Date:   Mon, 17 Oct 2022 00:43:31 +0100
Message-Id: <20221016234335.904212-10-aidanmacdonald.0x0@gmail.com>
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

The AXP192 is identical to the AXP20x, except for the addition of
two more GPIO ADC channels.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 279 +++++++++++++++++++++++++++++++++++
 1 file changed, 279 insertions(+)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 75bda94dbce1..8d748b814f20 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -22,11 +22,19 @@
 #include <linux/iio/machine.h>
 #include <linux/mfd/axp20x.h>
 
+#define AXP192_ADC_EN1_MASK			GENMASK(7, 0)
+#define AXP192_ADC_EN2_MASK			(GENMASK(3, 0) | BIT(7))
+
 #define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
 #define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
 
 #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
 
+#define AXP192_GPIO30_IN_RANGE_GPIO0		BIT(0)
+#define AXP192_GPIO30_IN_RANGE_GPIO1		BIT(1)
+#define AXP192_GPIO30_IN_RANGE_GPIO2		BIT(2)
+#define AXP192_GPIO30_IN_RANGE_GPIO3		BIT(3)
+
 #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
 #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
 
@@ -71,6 +79,25 @@ struct axp20x_adc_iio {
 	const struct axp_data	*data;
 };
 
+enum axp192_adc_channel_v {
+	AXP192_ACIN_V = 0,
+	AXP192_VBUS_V,
+	AXP192_TS_IN,
+	AXP192_GPIO0_V,
+	AXP192_GPIO1_V,
+	AXP192_GPIO2_V,
+	AXP192_GPIO3_V,
+	AXP192_IPSOUT_V,
+	AXP192_BATT_V,
+};
+
+enum axp192_adc_channel_i {
+	AXP192_ACIN_I = 0,
+	AXP192_VBUS_I,
+	AXP192_BATT_CHRG_I,
+	AXP192_BATT_DISCHRG_I,
+};
+
 enum axp20x_adc_channel_v {
 	AXP20X_ACIN_V = 0,
 	AXP20X_VBUS_V,
@@ -158,6 +185,43 @@ static struct iio_map axp22x_maps[] = {
  * The only exception is for the battery. batt_v will be in_voltage6_raw and
  * charge current in_current6_raw and discharge current will be in_current7_raw.
  */
+static const struct iio_chan_spec axp192_adc_channels[] = {
+	AXP20X_ADC_CHANNEL(AXP192_ACIN_V, "acin_v", IIO_VOLTAGE,
+			   AXP20X_ACIN_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP192_ACIN_I, "acin_i", IIO_CURRENT,
+			   AXP20X_ACIN_I_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP192_VBUS_V, "vbus_v", IIO_VOLTAGE,
+			   AXP20X_VBUS_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP192_VBUS_I, "vbus_i", IIO_CURRENT,
+			   AXP20X_VBUS_I_ADC_H),
+	{
+		.type = IIO_TEMP,
+		.address = AXP20X_TEMP_ADC_H,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE) |
+				      BIT(IIO_CHAN_INFO_OFFSET),
+		.datasheet_name = "pmic_temp",
+	},
+	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO0_V, "gpio0_v", IIO_VOLTAGE,
+				  AXP20X_GPIO0_V_ADC_H),
+	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO1_V, "gpio1_v", IIO_VOLTAGE,
+				  AXP20X_GPIO1_V_ADC_H),
+	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO2_V, "gpio2_v", IIO_VOLTAGE,
+				  AXP192_GPIO2_V_ADC_H),
+	AXP20X_ADC_CHANNEL_OFFSET(AXP192_GPIO3_V, "gpio3_v", IIO_VOLTAGE,
+				  AXP192_GPIO3_V_ADC_H),
+	AXP20X_ADC_CHANNEL(AXP192_IPSOUT_V, "ipsout_v", IIO_VOLTAGE,
+			   AXP20X_IPSOUT_V_HIGH_H),
+	AXP20X_ADC_CHANNEL(AXP192_BATT_V, "batt_v", IIO_VOLTAGE,
+			   AXP20X_BATT_V_H),
+	AXP20X_ADC_CHANNEL(AXP192_BATT_CHRG_I, "batt_chrg_i", IIO_CURRENT,
+			   AXP20X_BATT_CHRG_I_H),
+	AXP20X_ADC_CHANNEL(AXP192_BATT_DISCHRG_I, "batt_dischrg_i", IIO_CURRENT,
+			   AXP20X_BATT_DISCHRG_I_H),
+	AXP20X_ADC_CHANNEL(AXP192_TS_IN, "ts_v", IIO_VOLTAGE,
+			   AXP20X_TS_IN_H),
+};
+
 static const struct iio_chan_spec axp20x_adc_channels[] = {
 	AXP20X_ADC_CHANNEL(AXP20X_ACIN_V, "acin_v", IIO_VOLTAGE,
 			   AXP20X_ACIN_V_ADC_H),
@@ -231,6 +295,27 @@ static const struct iio_chan_spec axp813_adc_channels[] = {
 			   AXP288_TS_ADC_H),
 };
 
+static int axp192_adc_raw(struct iio_dev *indio_dev,
+			  struct iio_chan_spec const *chan, int *val)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int ret, size;
+
+	if (chan->type == IIO_CURRENT &&
+	    (chan->channel == AXP192_BATT_CHRG_I ||
+	     chan->channel == AXP192_BATT_DISCHRG_I))
+		size = 13;
+	else
+		size = 12;
+
+	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
+	if (ret < 0)
+		return ret;
+
+	*val = ret;
+	return IIO_VAL_INT;
+}
+
 static int axp20x_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
@@ -283,6 +368,44 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
 	return IIO_VAL_INT;
 }
 
+static int axp192_adc_scale_voltage(int channel, int *val, int *val2)
+{
+	switch (channel) {
+	case AXP192_ACIN_V:
+	case AXP192_VBUS_V:
+		*val = 1;
+		*val2 = 700000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP192_GPIO0_V:
+	case AXP192_GPIO1_V:
+	case AXP192_GPIO2_V:
+	case AXP192_GPIO3_V:
+		*val = 0;
+		*val2 = 500000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP192_BATT_V:
+		*val = 1;
+		*val2 = 100000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP192_IPSOUT_V:
+		*val = 1;
+		*val2 = 400000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	case AXP192_TS_IN:
+		/* 0.8 mV per LSB */
+		*val = 0;
+		*val2 = 800000;
+		return IIO_VAL_INT_PLUS_MICRO;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_adc_scale_voltage(int channel, int *val, int *val2)
 {
 	switch (channel) {
@@ -386,6 +509,29 @@ static int axp20x_adc_scale_current(int channel, int *val, int *val2)
 	}
 }
 
+static int axp192_adc_scale(struct iio_chan_spec const *chan, int *val,
+			    int *val2)
+{
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		return axp192_adc_scale_voltage(chan->channel, val, val2);
+
+	case IIO_CURRENT:
+		/*
+		 * AXP192 current channels are identical to the AXP20x,
+		 * therefore we can re-use the scaling function.
+		 */
+		return axp20x_adc_scale_current(chan->channel, val, val2);
+
+	case IIO_TEMP:
+		*val = 100;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_adc_scale(struct iio_chan_spec const *chan, int *val,
 			    int *val2)
 {
@@ -445,6 +591,42 @@ static int axp813_adc_scale(struct iio_chan_spec const *chan, int *val,
 	}
 }
 
+static int axp192_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
+				     int *val)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	unsigned int regval;
+	int ret;
+
+	ret = regmap_read(info->regmap, AXP192_GPIO30_IN_RANGE, &regval);
+	if (ret < 0)
+		return ret;
+
+	switch (channel) {
+	case AXP192_GPIO0_V:
+		regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO0, regval);
+		break;
+
+	case AXP192_GPIO1_V:
+		regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO1, regval);
+		break;
+
+	case AXP192_GPIO2_V:
+		regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO2, regval);
+		break;
+
+	case AXP192_GPIO3_V:
+		regval = FIELD_GET(AXP192_GPIO30_IN_RANGE_GPIO3, regval);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	*val = regval ? 700000 : 0;
+	return IIO_VAL_INT;
+}
+
 static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
 				     int *val)
 {
@@ -473,6 +655,22 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
 	return IIO_VAL_INT;
 }
 
+static int axp192_adc_offset(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan, int *val)
+{
+	switch (chan->type) {
+	case IIO_VOLTAGE:
+		return axp192_adc_offset_voltage(indio_dev, chan->channel, val);
+
+	case IIO_TEMP:
+		*val = -1447;
+		return IIO_VAL_INT;
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_adc_offset(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan, int *val)
 {
@@ -489,6 +687,25 @@ static int axp20x_adc_offset(struct iio_dev *indio_dev,
 	}
 }
 
+static int axp192_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan, int *val,
+			   int *val2, long mask)
+{
+	switch (mask) {
+	case IIO_CHAN_INFO_OFFSET:
+		return axp192_adc_offset(indio_dev, chan, val);
+
+	case IIO_CHAN_INFO_SCALE:
+		return axp192_adc_scale(chan, val, val2);
+
+	case IIO_CHAN_INFO_RAW:
+		return axp192_adc_raw(indio_dev, chan, val);
+
+	default:
+		return -EINVAL;
+	}
+}
+
 static int axp20x_read_raw(struct iio_dev *indio_dev,
 			   struct iio_chan_spec const *chan, int *val,
 			   int *val2, long mask)
@@ -549,6 +766,51 @@ static int axp813_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static int axp192_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan, int val, int val2,
+			    long mask)
+{
+	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	unsigned int regmask, regval;
+
+	/*
+	 * The AXP192 PMIC allows the user to choose between 0V and 0.7V offsets
+	 * for (independently) GPIO0-3 when in ADC mode.
+	 */
+	if (mask != IIO_CHAN_INFO_OFFSET)
+		return -EINVAL;
+
+	if (val != 0 && val != 700000)
+		return -EINVAL;
+
+	switch (chan->channel) {
+	case AXP192_GPIO0_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO0;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO0, !!val);
+		break;
+
+	case AXP192_GPIO1_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO1;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO1, !!val);
+		break;
+
+	case AXP192_GPIO2_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO2;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO2, !!val);
+		break;
+
+	case AXP192_GPIO3_V:
+		regmask = AXP192_GPIO30_IN_RANGE_GPIO3;
+		regval = FIELD_PREP(AXP192_GPIO30_IN_RANGE_GPIO3, !!val);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return regmap_update_bits(info->regmap, AXP192_GPIO30_IN_RANGE, regmask, regval);
+}
+
 static int axp20x_write_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int val, int val2,
 			    long mask)
@@ -584,6 +846,11 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
 }
 
+static const struct iio_info axp192_adc_iio_info = {
+	.read_raw = axp192_read_raw,
+	.write_raw = axp192_write_raw,
+};
+
 static const struct iio_info axp20x_adc_iio_info = {
 	.read_raw = axp20x_read_raw,
 	.write_raw = axp20x_write_raw,
@@ -629,6 +896,16 @@ struct axp_data {
 	struct iio_map			*maps;
 };
 
+static const struct axp_data axp192_data = {
+	.iio_info = &axp192_adc_iio_info,
+	.num_channels = ARRAY_SIZE(axp192_adc_channels),
+	.channels = axp192_adc_channels,
+	.adc_en1_mask = AXP192_ADC_EN1_MASK,
+	.adc_en2_mask = AXP192_ADC_EN2_MASK,
+	.adc_rate = axp20x_adc_rate,
+	.maps = axp20x_maps,
+};
+
 static const struct axp_data axp20x_data = {
 	.iio_info = &axp20x_adc_iio_info,
 	.num_channels = ARRAY_SIZE(axp20x_adc_channels),
@@ -658,6 +935,7 @@ static const struct axp_data axp813_data = {
 };
 
 static const struct of_device_id axp20x_adc_of_match[] = {
+	{ .compatible = "x-powers,axp192-adc", .data = (void *)&axp192_data, },
 	{ .compatible = "x-powers,axp209-adc", .data = (void *)&axp20x_data, },
 	{ .compatible = "x-powers,axp221-adc", .data = (void *)&axp22x_data, },
 	{ .compatible = "x-powers,axp813-adc", .data = (void *)&axp813_data, },
@@ -666,6 +944,7 @@ static const struct of_device_id axp20x_adc_of_match[] = {
 MODULE_DEVICE_TABLE(of, axp20x_adc_of_match);
 
 static const struct platform_device_id axp20x_adc_id_match[] = {
+	{ .name = "axp192-adc", .driver_data = (kernel_ulong_t)&axp192_data, },
 	{ .name = "axp20x-adc", .driver_data = (kernel_ulong_t)&axp20x_data, },
 	{ .name = "axp22x-adc", .driver_data = (kernel_ulong_t)&axp22x_data, },
 	{ .name = "axp813-adc", .driver_data = (kernel_ulong_t)&axp813_data, },
-- 
2.38.0

