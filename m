Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C3EC69AF97
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 16:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjBQPez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 10:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjBQPex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 10:34:53 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085FC6F3CE;
        Fri, 17 Feb 2023 07:34:52 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a12so1488554wro.7;
        Fri, 17 Feb 2023 07:34:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TPq7dANvniDbcU1+TXN1D5BHsJyiJgPU7gcflNsJ4wI=;
        b=PlBMRRMPbTWSBPRIsBNsWlVarHpYWk6k0xpN4O3s2nD1tssvsA/oSWtHK+IwPq+JMY
         NZlLKryenwYyIV06+ROuY35hvLmFrXYwmkKSu4XntZfSTQpwyHxB98zmfJ1UfmFs5ga1
         iWBsS30/OP7dKhFdATbKXPDPL1uj+MDsSl91CWmNS4ti5kYyp6CsimI5+O9rt3FS6BU6
         ri7O1BQMbcoGk5yjbPRrH59wVyagfg723OUgw3fPWpl3VlY4udfvb8oVsJ6hzYmSEREx
         lDXMEmuqzNCCNW0nx1yDdOUH/lZQQcvU3Mli+JzUJPo0sBmTq7Rym457B+mHb2ssryd4
         Egyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TPq7dANvniDbcU1+TXN1D5BHsJyiJgPU7gcflNsJ4wI=;
        b=GVvcE0bYYufqTYMIvwTk+JtkfpWrTuyvQZfMzdqWlUTnX6FFRd/mLeGUE3mmHSKT5d
         zBiHxaGErtu7AZbB6he7vhAJipTiaYPt7Vr3hxEnkZH5UX7i0k60Tn7bzTPBO0x2a1k3
         cEvKhyIQ30Yt3dFREKrP7f4A6OfNwkzzys3kkneoMryhIStv+1SGXDETdfDXrKwJIRXf
         5vdWRqDDuUw/Edjiam6nNvE5rOfQL+aLaF/MPEJktzwbC+eMd+kYAGIxMsU7U8hxqCFu
         Se3ctdenl6KRsXs6/lNegF5neIFOY0aiHxo2Ch/Ic5rkpsoaGgIzCXiRX4NuWTvXqZR4
         M3GQ==
X-Gm-Message-State: AO0yUKU4UkQYbOOObt2CzmerraYjrn+4G9kE4OcCC14SzAd7yeKk15Fr
        f3oijkCHmAVQnp4hjHpytZpJpxqwBxU=
X-Google-Smtp-Source: AK7set/OEoZIyS+jiV70fMLyMiCwxJBeCL2DFL0dFbCsYup+TpbM4hmln42MG+0MtYcJQeiVoI2Zkg==
X-Received: by 2002:adf:f804:0:b0:2c5:5aef:2759 with SMTP id s4-20020adff804000000b002c55aef2759mr6939823wrp.53.1676648090421;
        Fri, 17 Feb 2023 07:34:50 -0800 (PST)
Received: from localhost (94.197.16.234.threembb.co.uk. [94.197.16.234])
        by smtp.gmail.com with ESMTPSA id j13-20020a056000124d00b002c54e26bca5sm4648633wrx.49.2023.02.17.07.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Feb 2023 07:34:50 -0800 (PST)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     jic23@kernel.org
Cc:     wens@csie.org, lars@metafoo.de, andy.shevchenko@gmail.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [RESEND PATCH v6 1/2] iio: adc: axp20x_adc: Minor code cleanups
Date:   Fri, 17 Feb 2023 15:34:03 +0000
Message-Id: <20230217153404.32481-1-aidanmacdonald.0x0@gmail.com>
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
This is a resend of a preparatory patch from a larger series adding support
for the AXP192 PMIC[1]. Since I don't think there's much hope of getting it
merged in one development cycle, there's no point letting these cleanups sit
around unapplied -- apply them whenever convienient!

[1] https://lore.kernel.org/all/20221016234335.904212-1-aidanmacdonald.0x0@gmail.com/

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
2.39.2

