Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B0566D9AC4
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 16:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239226AbjDFOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239180AbjDFOmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 10:42:19 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3178CBBA1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 07:40:39 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id y184so29201982oiy.8
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 07:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680792038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yd2yVxoqIsDwTMXS2T+HZEAI9D83RI3BoDA5xaKfBE=;
        b=jtclRHPP5+lJZo9EBwwK1pZZFGC6dToXe2TyW5nNy5HVecAtbIlh/Rfnqd77oMbOzz
         6cc345VEEpP3eeXWnTMebBVLNo84sY9QhB3s50HVOo2ZdYC5504EaKkl6JxOh5JJXaZ6
         6H73eFKohOwWu5uex72u2AmLhanIemGuU49cPfbzrSaLrb2InzKCmgJtEKBo2SpsBe+5
         UQ4TgI7Ze8QI16rYD86n7eLAFoQWb/O2hPbj/g3LDNdy/gQBi0GtDO5AnZuutm1NItBy
         d4bomTjT3OS5PfyuaW+RlfJinm0fGjhwTlx8Hq+VUAbIg4/ucVkcD6J7fEC7wiNvyH7i
         0hNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680792038;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yd2yVxoqIsDwTMXS2T+HZEAI9D83RI3BoDA5xaKfBE=;
        b=tuVBCpDhzlADT2go6VpxY0/yqRchKhwg6wNWBzjf+TENRrw0M8/4eKEX7/Tcabn3+C
         8rDLHVhr5BT+IkDNs4MJHbwVLg6J9E+fvNhF8NoFCEhNwC1q338hapetQzwzCEksPmxM
         pDGFdZp76hSiIm8leRi7QHSy/YSuO2U4J2HJs53c80jVYbljc14yIxdoOELECxuFK9bX
         QZijos7/8mVJMaTIxKjH2ui6oPkAaV3rU7QXbPYAyZ0qLcf84hsoPaW7xGZ3e9+iqqzg
         4/ejBOx2r99cxZBEuMM/nbLPZ0lAkPVfEtrj79E+FxdaEsGL9dDaJzoEkPMRz28BJyk9
         zuCQ==
X-Gm-Message-State: AAQBX9dc2koycg5IgKaIeqCA+1FQk5VJc4ZFYEcnx//io/4dPJ1wRCux
        c+Po0N5YKjDQIMFcL8/Iad7GCSRrbZ7W4Inef64fmg==
X-Google-Smtp-Source: AKy350boRhk831n7uM/oGwGMSDoOnGxltKCbM/S3odFkPmPDtOQI5khsKqh21rhHiUk4RR7Y85y6Rg==
X-Received: by 2002:a05:6808:20f:b0:389:5104:84db with SMTP id l15-20020a056808020f00b00389510484dbmr4351821oie.35.1680792037861;
        Thu, 06 Apr 2023 07:40:37 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q7-20020acaf207000000b0037d7f4eb7e8sm726209oih.31.2023.04.06.07.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 07:40:37 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH v5 5/6] iio: addac: stx104: Migrate to the regmap API
Date:   Thu,  6 Apr 2023 10:40:14 -0400
Message-Id: <0bcdfc4738cc019fb2ff83f61eb46a3488bc166d.1680790580.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1680790580.git.william.gray@linaro.org>
References: <cover.1680790580.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

In addition, to improve code organization in stx104_probe(), the
devm_iio_device_register() call is moved above GPIO configuration in
order to keep relevant code closer together.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
Changes in v5: none
Changes in v4:
 - Remove regmap_config max_register lines as superfluous
 - Utilize BIT() for gain calculation in stx104_read_raw()
Changes in v3:
 - Add STX104_ prefixes to defines to avoid potential name classes
 - Rename SAME_CHANNEL() to STX104_SINGLE_CHANNEL() to convey intention
   better
 - Utilize u8_encode_bits() to define STX104_SOFTWARE_TRIGGER
 - Adjust to utilize reg_base members in regmap_config structures
 - Fix off-by-one errors in aio_data_wr_ranges[], aio_data_rd_ranges[],
   and aio_data_regmap_config max_register
 - Inline gpio_config initialization to avoid zeroing it at declaration
 - Add blank lines between register map init blocks for clarity
Changes in v2:
 - Relocate struct stx104_iio for the sake of a clearer patch diff
 - Replace FIELD_PREP() and FIELD_GET() with u8_encode_bits() and
   u8_get_bits()

 drivers/iio/addac/Kconfig  |   2 +
 drivers/iio/addac/stx104.c | 438 ++++++++++++++++++++-----------------
 2 files changed, 245 insertions(+), 195 deletions(-)

diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index 2843fcb70e24..877f9124803c 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -35,7 +35,9 @@ config STX104
 	tristate "Apex Embedded Systems STX104 driver"
 	depends on PC104 && X86
 	select ISA_BUS_API
+	select REGMAP_MMIO
 	select GPIOLIB
+	select GPIO_REGMAP
 	help
 	  Say yes here to build support for the Apex Embedded Systems STX104
 	  integrated analog PC/104 card.
diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 81020b710195..798f98a8872e 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -3,21 +3,20 @@
  * IIO driver for the Apex Embedded Systems STX104
  * Copyright (C) 2016 William Breathitt Gray
  */
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
-#include <linux/gpio/driver.h>
+#include <linux/err.h>
+#include <linux/gpio/regmap.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
 #include <linux/isa.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <linux/mutex.h>
-#include <linux/spinlock.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 #define STX104_OUT_CHAN(chan) {				\
@@ -47,107 +46,207 @@ static unsigned int num_stx104;
 module_param_hw_array(base, uint, ioport, &num_stx104, 0);
 MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 
-/**
- * struct stx104_reg - device register structure
- * @ssr_ad:	Software Strobe Register and ADC Data
- * @achan:	ADC Channel
- * @dio:	Digital I/O
- * @dac:	DAC Channels
- * @cir_asr:	Clear Interrupts and ADC Status
- * @acr:	ADC Control
- * @pccr_fsh:	Pacer Clock Control and FIFO Status MSB
- * @acfg:	ADC Configuration
- */
-struct stx104_reg {
-	u16 ssr_ad;
-	u8 achan;
-	u8 dio;
-	u16 dac[2];
-	u8 cir_asr;
-	u8 acr;
-	u8 pccr_fsh;
-	u8 acfg;
-};
+#define STX104_AIO_BASE 0x0
+#define STX104_SOFTWARE_STROBE STX104_AIO_BASE
+#define STX104_ADC_DATA STX104_AIO_BASE
+#define STX104_ADC_CHANNEL (STX104_AIO_BASE + 0x2)
+#define STX104_DIO_REG (STX104_AIO_BASE + 0x3)
+#define STX104_DAC_BASE (STX104_AIO_BASE + 0x4)
+#define STX104_ADC_STATUS (STX104_AIO_BASE + 0x8)
+#define STX104_ADC_CONTROL (STX104_AIO_BASE + 0x9)
+#define STX104_ADC_CONFIGURATION (STX104_AIO_BASE + 0x11)
+
+#define STX104_AIO_DATA_STRIDE 2
+#define STX104_DAC_OFFSET(_channel) (STX104_DAC_BASE + STX104_AIO_DATA_STRIDE * (_channel))
+
+/* ADC Channel */
+#define STX104_FC GENMASK(3, 0)
+#define STX104_LC GENMASK(7, 4)
+#define STX104_SINGLE_CHANNEL(_channel) \
+	(u8_encode_bits(_channel, STX104_FC) | u8_encode_bits(_channel, STX104_LC))
+
+/* ADC Status */
+#define STX104_SD BIT(5)
+#define STX104_CNV BIT(7)
+#define STX104_DIFFERENTIAL 1
+
+/* ADC Control */
+#define STX104_ALSS GENMASK(1, 0)
+#define STX104_SOFTWARE_TRIGGER u8_encode_bits(0x0, STX104_ALSS)
+
+/* ADC Configuration */
+#define STX104_GAIN GENMASK(1, 0)
+#define STX104_ADBU BIT(2)
+#define STX104_BIPOLAR 0
+#define STX104_GAIN_X1 0
+#define STX104_GAIN_X2 1
+#define STX104_GAIN_X4 2
+#define STX104_GAIN_X8 3
 
 /**
  * struct stx104_iio - IIO device private data structure
  * @lock: synchronization lock to prevent I/O race conditions
- * @chan_out_states:	channels' output states
- * @reg:		I/O address offset for the device registers
+ * @aio_data_map: Regmap for analog I/O data
+ * @aio_ctl_map: Regmap for analog I/O control
  */
 struct stx104_iio {
 	struct mutex lock;
-	unsigned int chan_out_states[STX104_NUM_OUT_CHAN];
-	struct stx104_reg __iomem *reg;
+	struct regmap *aio_data_map;
+	struct regmap *aio_ctl_map;
 };
 
-/**
- * struct stx104_gpio - GPIO device private data structure
- * @chip:	instance of the gpio_chip
- * @lock:	synchronization lock to prevent I/O race conditions
- * @base:	base port address of the GPIO device
- * @out_state:	output bits state
- */
-struct stx104_gpio {
-	struct gpio_chip chip;
-	spinlock_t lock;
-	u8 __iomem *base;
-	unsigned int out_state;
+static const struct regmap_range aio_ctl_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x0), regmap_reg_range(0x2, 0x2), regmap_reg_range(0x9, 0x9),
+	regmap_reg_range(0x11, 0x11),
+};
+static const struct regmap_range aio_ctl_rd_ranges[] = {
+	regmap_reg_range(0x2, 0x2), regmap_reg_range(0x8, 0x9), regmap_reg_range(0x11, 0x11),
+};
+static const struct regmap_range aio_ctl_volatile_ranges[] = {
+	regmap_reg_range(0x8, 0x8),
+};
+static const struct regmap_access_table aio_ctl_wr_table = {
+	.yes_ranges = aio_ctl_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_ctl_wr_ranges),
+};
+static const struct regmap_access_table aio_ctl_rd_table = {
+	.yes_ranges = aio_ctl_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_ctl_rd_ranges),
+};
+static const struct regmap_access_table aio_ctl_volatile_table = {
+	.yes_ranges = aio_ctl_volatile_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_ctl_volatile_ranges),
+};
+
+static const struct regmap_config aio_ctl_regmap_config = {
+	.name = "aio_ctl",
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.reg_base = STX104_AIO_BASE,
+	.val_bits = 8,
+	.io_port = true,
+	.wr_table = &aio_ctl_wr_table,
+	.rd_table = &aio_ctl_rd_table,
+	.volatile_table = &aio_ctl_volatile_table,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static const struct regmap_range aio_data_wr_ranges[] = {
+	regmap_reg_range(0x4, 0x6),
+};
+static const struct regmap_range aio_data_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x0),
+};
+static const struct regmap_access_table aio_data_wr_table = {
+	.yes_ranges = aio_data_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_data_wr_ranges),
+};
+static const struct regmap_access_table aio_data_rd_table = {
+	.yes_ranges = aio_data_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(aio_data_rd_ranges),
+};
+
+static const struct regmap_config aio_data_regmap_config = {
+	.name = "aio_data",
+	.reg_bits = 16,
+	.reg_stride = STX104_AIO_DATA_STRIDE,
+	.reg_base = STX104_AIO_BASE,
+	.val_bits = 16,
+	.io_port = true,
+	.wr_table = &aio_data_wr_table,
+	.rd_table = &aio_data_rd_table,
+	.volatile_table = &aio_data_rd_table,
+	.cache_type = REGCACHE_FLAT,
+};
+
+static const struct regmap_config dio_regmap_config = {
+	.name = "dio",
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.reg_base = STX104_DIO_REG,
+	.val_bits = 8,
+	.io_port = true,
 };
 
 static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
-	struct stx104_reg __iomem *const reg = priv->reg;
+	int err;
 	unsigned int adc_config;
-	int adbu;
-	int gain;
+	unsigned int value;
+	unsigned int adc_status;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
-		/* get gain configuration */
-		adc_config = ioread8(&reg->acfg);
-		gain = adc_config & 0x3;
+		err = regmap_read(priv->aio_ctl_map, STX104_ADC_CONFIGURATION, &adc_config);
+		if (err)
+			return err;
 
-		*val = 1 << gain;
+		*val = BIT(u8_get_bits(adc_config, STX104_GAIN));
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_RAW:
 		if (chan->output) {
-			*val = priv->chan_out_states[chan->channel];
+			err = regmap_read(priv->aio_data_map, STX104_DAC_OFFSET(chan->channel),
+					  &value);
+			if (err)
+				return err;
+			*val = value;
 			return IIO_VAL_INT;
 		}
 
 		mutex_lock(&priv->lock);
 
 		/* select ADC channel */
-		iowrite8(chan->channel | (chan->channel << 4), &reg->achan);
+		err = regmap_write(priv->aio_ctl_map, STX104_ADC_CHANNEL,
+				   STX104_SINGLE_CHANNEL(chan->channel));
+		if (err) {
+			mutex_unlock(&priv->lock);
+			return err;
+		}
 
 		/* trigger ADC sample capture by writing to the 8-bit
 		 * Software Strobe Register and wait for completion
 		 */
-		iowrite8(0, &reg->ssr_ad);
-		while (ioread8(&reg->cir_asr) & BIT(7));
-
-		*val = ioread16(&reg->ssr_ad);
+		err = regmap_write(priv->aio_ctl_map, STX104_SOFTWARE_STROBE, 0);
+		if (err) {
+			mutex_unlock(&priv->lock);
+			return err;
+		}
+		do {
+			err = regmap_read(priv->aio_ctl_map, STX104_ADC_STATUS, &adc_status);
+			if (err) {
+				mutex_unlock(&priv->lock);
+				return err;
+			}
+		} while (u8_get_bits(adc_status, STX104_CNV));
+
+		err = regmap_read(priv->aio_data_map, STX104_ADC_DATA, &value);
+		if (err) {
+			mutex_unlock(&priv->lock);
+			return err;
+		}
+		*val = value;
 
 		mutex_unlock(&priv->lock);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OFFSET:
 		/* get ADC bipolar/unipolar configuration */
-		adc_config = ioread8(&reg->acfg);
-		adbu = !(adc_config & BIT(2));
+		err = regmap_read(priv->aio_ctl_map, STX104_ADC_CONFIGURATION, &adc_config);
+		if (err)
+			return err;
 
-		*val = -32768 * adbu;
+		*val = (u8_get_bits(adc_config, STX104_ADBU) == STX104_BIPOLAR) ? -32768 : 0;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		/* get ADC bipolar/unipolar and gain configuration */
-		adc_config = ioread8(&reg->acfg);
-		adbu = !(adc_config & BIT(2));
-		gain = adc_config & 0x3;
+		err = regmap_read(priv->aio_ctl_map, STX104_ADC_CONFIGURATION, &adc_config);
+		if (err)
+			return err;
 
 		*val = 5;
-		*val2 = 15 - adbu + gain;
+		*val2 = (u8_get_bits(adc_config, STX104_ADBU) == STX104_BIPOLAR) ? 14 : 15;
+		*val2 += u8_get_bits(adc_config, STX104_GAIN);
 		return IIO_VAL_FRACTIONAL_LOG2;
 	}
 
@@ -158,28 +257,29 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
 	struct stx104_iio *const priv = iio_priv(indio_dev);
+	u8 gain;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_HARDWAREGAIN:
 		/* Only four gain states (x1, x2, x4, x8) */
 		switch (val) {
 		case 1:
-			iowrite8(0, &priv->reg->acfg);
+			gain = STX104_GAIN_X1;
 			break;
 		case 2:
-			iowrite8(1, &priv->reg->acfg);
+			gain = STX104_GAIN_X2;
 			break;
 		case 4:
-			iowrite8(2, &priv->reg->acfg);
+			gain = STX104_GAIN_X4;
 			break;
 		case 8:
-			iowrite8(3, &priv->reg->acfg);
+			gain = STX104_GAIN_X8;
 			break;
 		default:
 			return -EINVAL;
 		}
 
-		return 0;
+		return regmap_write(priv->aio_ctl_map, STX104_ADC_CONFIGURATION, gain);
 	case IIO_CHAN_INFO_RAW:
 		if (!chan->output)
 			return -EINVAL;
@@ -187,13 +287,7 @@ static int stx104_write_raw(struct iio_dev *indio_dev,
 		if (val < 0 || val > U16_MAX)
 			return -EINVAL;
 
-		mutex_lock(&priv->lock);
-
-		priv->chan_out_states[chan->channel] = val;
-		iowrite16(val, &priv->reg->dac[chan->channel]);
-
-		mutex_unlock(&priv->lock);
-		return 0;
+		return regmap_write(priv->aio_data_map, STX104_DAC_OFFSET(chan->channel), val);
 	}
 
 	return -EINVAL;
@@ -222,119 +316,66 @@ static const struct iio_chan_spec stx104_channels_diff[] = {
 	STX104_IN_CHAN(6, 1), STX104_IN_CHAN(7, 1)
 };
 
-static int stx104_gpio_get_direction(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	/* GPIO 0-3 are input only, while the rest are output only */
-	if (offset < 4)
-		return 1;
-
-	return 0;
-}
-
-static int stx104_gpio_direction_input(struct gpio_chip *chip,
-	unsigned int offset)
-{
-	if (offset >= 4)
-		return -EINVAL;
-
-	return 0;
-}
-
-static int stx104_gpio_direction_output(struct gpio_chip *chip,
-	unsigned int offset, int value)
+static int stx104_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned int base,
+				 unsigned int offset, unsigned int *const reg,
+				 unsigned int *const mask)
 {
-	if (offset < 4)
-		return -EINVAL;
-
-	chip->set(chip, offset, value);
-	return 0;
-}
-
-static int stx104_gpio_get(struct gpio_chip *chip, unsigned int offset)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-
+	/* Output lines are located at same register bit offsets as input lines */
 	if (offset >= 4)
-		return -EINVAL;
+		offset -= 4;
 
-	return !!(ioread8(stx104gpio->base) & BIT(offset));
-}
-
-static int stx104_gpio_get_multiple(struct gpio_chip *chip, unsigned long *mask,
-	unsigned long *bits)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-
-	*bits = ioread8(stx104gpio->base);
+	*reg = base;
+	*mask = BIT(offset);
 
 	return 0;
 }
 
-static void stx104_gpio_set(struct gpio_chip *chip, unsigned int offset,
-	int value)
-{
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-	const unsigned int mask = BIT(offset) >> 4;
-	unsigned long flags;
-
-	if (offset < 4)
-		return;
-
-	spin_lock_irqsave(&stx104gpio->lock, flags);
-
-	if (value)
-		stx104gpio->out_state |= mask;
-	else
-		stx104gpio->out_state &= ~mask;
-
-	iowrite8(stx104gpio->out_state, stx104gpio->base);
-
-	spin_unlock_irqrestore(&stx104gpio->lock, flags);
-}
-
 #define STX104_NGPIO 8
 static const char *stx104_names[STX104_NGPIO] = {
 	"DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
 };
 
-static void stx104_gpio_set_multiple(struct gpio_chip *chip,
-	unsigned long *mask, unsigned long *bits)
+static int stx104_init_hw(struct stx104_iio *const priv)
 {
-	struct stx104_gpio *const stx104gpio = gpiochip_get_data(chip);
-	unsigned long flags;
-
-	/* verify masked GPIO are output */
-	if (!(*mask & 0xF0))
-		return;
+	int err;
 
-	*mask >>= 4;
-	*bits >>= 4;
+	/* configure device for software trigger operation */
+	err = regmap_write(priv->aio_ctl_map, STX104_ADC_CONTROL, STX104_SOFTWARE_TRIGGER);
+	if (err)
+		return err;
 
-	spin_lock_irqsave(&stx104gpio->lock, flags);
+	/* initialize gain setting to x1 */
+	err = regmap_write(priv->aio_ctl_map, STX104_ADC_CONFIGURATION, STX104_GAIN_X1);
+	if (err)
+		return err;
 
-	stx104gpio->out_state &= ~*mask;
-	stx104gpio->out_state |= *mask & *bits;
-	iowrite8(stx104gpio->out_state, stx104gpio->base);
+	/* initialize DAC outputs to 0V */
+	err = regmap_write(priv->aio_data_map, STX104_DAC_BASE, 0);
+	if (err)
+		return err;
+	err = regmap_write(priv->aio_data_map, STX104_DAC_BASE + STX104_AIO_DATA_STRIDE, 0);
+	if (err)
+		return err;
 
-	spin_unlock_irqrestore(&stx104gpio->lock, flags);
+	return 0;
 }
 
 static int stx104_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
 	struct stx104_iio *priv;
-	struct stx104_gpio *stx104gpio;
+	struct gpio_regmap_config gpio_config;
+	void __iomem *stx104_base;
+	struct regmap *aio_ctl_map;
+	struct regmap *aio_data_map;
+	struct regmap *dio_map;
 	int err;
+	unsigned int adc_status;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
 		return -ENOMEM;
 
-	stx104gpio = devm_kzalloc(dev, sizeof(*stx104gpio), GFP_KERNEL);
-	if (!stx104gpio)
-		return -ENOMEM;
-
 	if (!devm_request_region(dev, base[id], STX104_EXTENT,
 		dev_name(dev))) {
 		dev_err(dev, "Unable to lock port addresses (0x%X-0x%X)\n",
@@ -342,16 +383,37 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	priv = iio_priv(indio_dev);
-	priv->reg = devm_ioport_map(dev, base[id], STX104_EXTENT);
-	if (!priv->reg)
+	stx104_base = devm_ioport_map(dev, base[id], STX104_EXTENT);
+	if (!stx104_base)
 		return -ENOMEM;
 
+	aio_ctl_map = devm_regmap_init_mmio(dev, stx104_base, &aio_ctl_regmap_config);
+	if (IS_ERR(aio_ctl_map))
+		return dev_err_probe(dev, PTR_ERR(aio_ctl_map),
+				     "Unable to initialize aio_ctl register map\n");
+
+	aio_data_map = devm_regmap_init_mmio(dev, stx104_base, &aio_data_regmap_config);
+	if (IS_ERR(aio_data_map))
+		return dev_err_probe(dev, PTR_ERR(aio_data_map),
+				     "Unable to initialize aio_data register map\n");
+
+	dio_map = devm_regmap_init_mmio(dev, stx104_base, &dio_regmap_config);
+	if (IS_ERR(dio_map))
+		return dev_err_probe(dev, PTR_ERR(dio_map),
+				     "Unable to initialize dio register map\n");
+
+	priv = iio_priv(indio_dev);
+	priv->aio_ctl_map = aio_ctl_map;
+	priv->aio_data_map = aio_data_map;
+
 	indio_dev->info = &stx104_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
-	/* determine if differential inputs */
-	if (ioread8(&priv->reg->cir_asr) & BIT(5)) {
+	err = regmap_read(aio_ctl_map, STX104_ADC_STATUS, &adc_status);
+	if (err)
+		return err;
+
+	if (u8_get_bits(adc_status, STX104_SD) == STX104_DIFFERENTIAL) {
 		indio_dev->num_channels = ARRAY_SIZE(stx104_channels_diff);
 		indio_dev->channels = stx104_channels_diff;
 	} else {
@@ -363,41 +425,27 @@ static int stx104_probe(struct device *dev, unsigned int id)
 
 	mutex_init(&priv->lock);
 
-	/* configure device for software trigger operation */
-	iowrite8(0, &priv->reg->acr);
+	err = stx104_init_hw(priv);
+	if (err)
+		return err;
 
-	/* initialize gain setting to x1 */
-	iowrite8(0, &priv->reg->acfg);
-
-	/* initialize DAC output to 0V */
-	iowrite16(0, &priv->reg->dac[0]);
-	iowrite16(0, &priv->reg->dac[1]);
-
-	stx104gpio->chip.label = dev_name(dev);
-	stx104gpio->chip.parent = dev;
-	stx104gpio->chip.owner = THIS_MODULE;
-	stx104gpio->chip.base = -1;
-	stx104gpio->chip.ngpio = STX104_NGPIO;
-	stx104gpio->chip.names = stx104_names;
-	stx104gpio->chip.get_direction = stx104_gpio_get_direction;
-	stx104gpio->chip.direction_input = stx104_gpio_direction_input;
-	stx104gpio->chip.direction_output = stx104_gpio_direction_output;
-	stx104gpio->chip.get = stx104_gpio_get;
-	stx104gpio->chip.get_multiple = stx104_gpio_get_multiple;
-	stx104gpio->chip.set = stx104_gpio_set;
-	stx104gpio->chip.set_multiple = stx104_gpio_set_multiple;
-	stx104gpio->base = &priv->reg->dio;
-	stx104gpio->out_state = 0x0;
-
-	spin_lock_init(&stx104gpio->lock);
-
-	err = devm_gpiochip_add_data(dev, &stx104gpio->chip, stx104gpio);
-	if (err) {
-		dev_err(dev, "GPIO registering failed (%d)\n", err);
+	err = devm_iio_device_register(dev, indio_dev);
+	if (err)
 		return err;
-	}
 
-	return devm_iio_device_register(dev, indio_dev);
+	gpio_config = (struct gpio_regmap_config) {
+		.parent = dev,
+		.regmap = dio_map,
+		.ngpio = STX104_NGPIO,
+		.names = stx104_names,
+		.reg_dat_base = GPIO_REGMAP_ADDR(STX104_DIO_REG),
+		.reg_set_base = GPIO_REGMAP_ADDR(STX104_DIO_REG),
+		.ngpio_per_reg = STX104_NGPIO,
+		.reg_mask_xlate = stx104_reg_mask_xlate,
+		.drvdata = dio_map,
+	};
+
+	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
 }
 
 static struct isa_driver stx104_driver = {
-- 
2.39.2

