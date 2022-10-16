Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE8600450
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 01:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbiJPXmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Oct 2022 19:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiJPXma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Oct 2022 19:42:30 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87F127150;
        Sun, 16 Oct 2022 16:42:26 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w18so15994112wro.7;
        Sun, 16 Oct 2022 16:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iLzGYWDmP7UYu1QNx5f+Qbth2SePhNiLrOaMsgn1dzA=;
        b=MZmeAAI6Ahc5u0nPigQy5ddDWdsm7rcBJ8PnwV2YGDnAkxU9KkxHnHWqD5166cOiVu
         4eWTXWqQ/bx4S332HPEpUC7Lk4klRm5C9C4vUw8pa+l0OMd/C61x08nAq0C18Ndpc7Cd
         pF/lqXTWnCJmAZWS/PqvTJ81jHqvv/Jm7PkFM04QPaonNfZtGopr+sJHZdqWg6j1hItt
         KDsOJBVkIPa7BgV+ao9eWp4XKa+IKWBj+Y8Iou+MVEcrisgf8aDOSnEpXNIU/bu4LB+l
         47D0OxMirl4uzr7iPDJQC3E6LIRyi2Bkq/b7Ky/tJasiR0z+zQgyH0KLbSs0MDedPbi9
         j0bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iLzGYWDmP7UYu1QNx5f+Qbth2SePhNiLrOaMsgn1dzA=;
        b=HVvuKuCQn9y/LkvV3LCjdFQJbcY1gJtzHq7fNKNAlni9ONwqwMwUltLnawtKZ0sekL
         AD36aoIXrW5vBvWlce23/JH6NTkn6G4OXPEBp8zZ+D3IO4+spQ1m8VqZpLUSJzkTtaev
         H+/KcR7PP3/cIawUnGJZunIt6izjKHlVNiZYHgzfR+skqvYx70sHvCDiL3yiDa38rnwO
         U7oKa1xVxft5GEAYQTSBJ5uybeMWQA4xlV5jF74L6nfu/EpRN8X97pNMUxX6iK2svQur
         y85Ef1MRHQ+a5Hh61WzLhPQBR+3AoTGV6RZsXUdJm32yGCbNSNzEa5dDDmpRzxvmfYn5
         2kuw==
X-Gm-Message-State: ACrzQf1GgcbZiIkiNw7WqLKURttPXFWAUxYORaD2lemqd+MHT21cFxWZ
        Q+4O0/9JAo3MbyFyGiw7Ego=
X-Google-Smtp-Source: AMsMyM7LeDLj/ALhsbjhvbO2NC2tmDEnb4Lln27sAAM8L3wQ4vzUSa03N/jgEKEke+FvA1TtE8wPig==
X-Received: by 2002:a5d:530b:0:b0:22e:3e8c:45aa with SMTP id e11-20020a5d530b000000b0022e3e8c45aamr4886492wrv.321.1665963745079;
        Sun, 16 Oct 2022 16:42:25 -0700 (PDT)
Received: from localhost (188.31.4.189.threembb.co.uk. [188.31.4.189])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b003c6cc57566fsm13008690wmq.14.2022.10.16.16.42.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Oct 2022 16:42:24 -0700 (PDT)
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
Subject: [PATCH v6 07/13] iio: adc: axp20x_adc: Minor code cleanups
Date:   Mon, 17 Oct 2022 00:43:29 +0100
Message-Id: <20221016234335.904212-8-aidanmacdonald.0x0@gmail.com>
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

The code may be clearer if parameters are not re-purposed to hold
temporary results like register values, so introduce local variables
as necessary to avoid that. Regroup macros based on chip type, and
use the FIELD_PREP() macro instead of a hand-rolled version.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 drivers/iio/adc/axp20x_adc.c | 61 +++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
index 53bf7d4899d2..ab25e6e1ff65 100644
--- a/drivers/iio/adc/axp20x_adc.c
+++ b/drivers/iio/adc/axp20x_adc.c
@@ -5,6 +5,7 @@
  *	Quentin Schulz <quentin.schulz@free-electrons.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
@@ -22,20 +23,20 @@
 #include <linux/mfd/axp20x.h>
 
 #define AXP20X_ADC_EN1_MASK			GENMASK(7, 0)
-
 #define AXP20X_ADC_EN2_MASK			(GENMASK(3, 2) | BIT(7))
+
 #define AXP22X_ADC_EN1_MASK			(GENMASK(7, 5) | BIT(0))
 
 #define AXP20X_GPIO10_IN_RANGE_GPIO0		BIT(0)
 #define AXP20X_GPIO10_IN_RANGE_GPIO1		BIT(1)
-#define AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(x)	((x) & BIT(0))
-#define AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(x)	(((x) & BIT(0)) << 1)
 
 #define AXP20X_ADC_RATE_MASK			GENMASK(7, 6)
-#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
-#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
 #define AXP20X_ADC_RATE_HZ(x)			((ilog2((x) / 25) << 6) & AXP20X_ADC_RATE_MASK)
+
 #define AXP22X_ADC_RATE_HZ(x)			((ilog2((x) / 100) << 6) & AXP20X_ADC_RATE_MASK)
+
+#define AXP813_V_I_ADC_RATE_MASK		GENMASK(5, 4)
+#define AXP813_ADC_RATE_MASK			(AXP20X_ADC_RATE_MASK | AXP813_V_I_ADC_RATE_MASK)
 #define AXP813_TS_GPIO0_ADC_RATE_HZ(x)		AXP20X_ADC_RATE_HZ(x)
 #define AXP813_V_I_ADC_RATE_HZ(x)		((ilog2((x) / 100) << 4) & AXP813_V_I_ADC_RATE_MASK)
 #define AXP813_ADC_RATE_HZ(x)			(AXP20X_ADC_RATE_HZ(x) | AXP813_V_I_ADC_RATE_HZ(x))
@@ -234,7 +235,7 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
-	int size = 12;
+	int ret, size;
 
 	/*
 	 * N.B.:  Unlike the Chinese datasheets tell, the charging current is
@@ -246,10 +247,11 @@ static int axp20x_adc_raw(struct iio_dev *indio_dev,
 	else
 		size = 12;
 
-	*val = axp20x_read_variable_width(info->regmap, chan->address, size);
-	if (*val < 0)
-		return *val;
+	ret = axp20x_read_variable_width(info->regmap, chan->address, size);
+	if (ret < 0)
+		return ret;
 
+	*val = ret;
 	return IIO_VAL_INT;
 }
 
@@ -257,11 +259,13 @@ static int axp22x_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int ret;
 
-	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
-	if (*val < 0)
-		return *val;
+	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
+	if (ret < 0)
+		return ret;
 
+	*val = ret;
 	return IIO_VAL_INT;
 }
 
@@ -269,11 +273,13 @@ static int axp813_adc_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan, int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	int ret;
 
-	*val = axp20x_read_variable_width(info->regmap, chan->address, 12);
-	if (*val < 0)
-		return *val;
+	ret = axp20x_read_variable_width(info->regmap, chan->address, 12);
+	if (ret < 0)
+		return ret;
 
+	*val = ret;
 	return IIO_VAL_INT;
 }
 
@@ -443,27 +449,27 @@ static int axp20x_adc_offset_voltage(struct iio_dev *indio_dev, int channel,
 				     int *val)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
+	unsigned int regval;
 	int ret;
 
-	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, val);
+	ret = regmap_read(info->regmap, AXP20X_GPIO10_IN_RANGE, &regval);
 	if (ret < 0)
 		return ret;
 
 	switch (channel) {
 	case AXP20X_GPIO0_V:
-		*val &= AXP20X_GPIO10_IN_RANGE_GPIO0;
+		regval = FIELD_GET(AXP20X_GPIO10_IN_RANGE_GPIO0, regval);
 		break;
 
 	case AXP20X_GPIO1_V:
-		*val &= AXP20X_GPIO10_IN_RANGE_GPIO1;
+		regval = FIELD_GET(AXP20X_GPIO10_IN_RANGE_GPIO1, regval);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	*val = *val ? 700000 : 0;
-
+	*val = regval ? 700000 : 0;
 	return IIO_VAL_INT;
 }
 
@@ -548,7 +554,7 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 			    long mask)
 {
 	struct axp20x_adc_iio *info = iio_priv(indio_dev);
-	unsigned int reg, regval;
+	unsigned int regmask, regval;
 
 	/*
 	 * The AXP20X PMIC allows the user to choose between 0V and 0.7V offsets
@@ -560,25 +566,22 @@ static int axp20x_write_raw(struct iio_dev *indio_dev,
 	if (val != 0 && val != 700000)
 		return -EINVAL;
 
-	val = val ? 1 : 0;
-
 	switch (chan->channel) {
 	case AXP20X_GPIO0_V:
-		reg = AXP20X_GPIO10_IN_RANGE_GPIO0;
-		regval = AXP20X_GPIO10_IN_RANGE_GPIO0_VAL(val);
+		regmask = AXP20X_GPIO10_IN_RANGE_GPIO0;
+		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO0, !!val);
 		break;
 
 	case AXP20X_GPIO1_V:
-		reg = AXP20X_GPIO10_IN_RANGE_GPIO1;
-		regval = AXP20X_GPIO10_IN_RANGE_GPIO1_VAL(val);
+		regmask = AXP20X_GPIO10_IN_RANGE_GPIO1;
+		regval = FIELD_PREP(AXP20X_GPIO10_IN_RANGE_GPIO1, !!val);
 		break;
 
 	default:
 		return -EINVAL;
 	}
 
-	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, reg,
-				  regval);
+	return regmap_update_bits(info->regmap, AXP20X_GPIO10_IN_RANGE, regmask, regval);
 }
 
 static const struct iio_info axp20x_adc_iio_info = {
-- 
2.38.0

