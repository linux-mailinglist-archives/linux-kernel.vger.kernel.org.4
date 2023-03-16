Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A4306BDD2C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:49:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjCPXtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjCPXtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:49:05 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7863B3E0C;
        Thu, 16 Mar 2023 16:48:58 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z21so14149321edb.4;
        Thu, 16 Mar 2023 16:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679010537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HY6ak39HWm1vukAoAm5/mRKLP47+0DQKKodQ4ujm/lU=;
        b=n7aGSC429Aw7BKGC5eAgRlScDvAHO7P+NIJNNLoGdnrJDFTYUMs0a53DvYlnqDmKOl
         BHSqPyF5pQrXlONEpG8FhlsMKRRc3iOvCtjji/UxVjhp0HJfvRQZaiCa/UILVzjkC0t3
         3wDHSANMFzxT/5GjQ+wL26avyfTG8B/KIZBZueL+YA+J+lcxdJGEyIk6xqE7ZXeD3otc
         K6FdUFdYE7wv/vLfAbElO6WR+XUcRbGcGU+AbvfENxOqV1Cpetwk4RbY1ffHb/AaDi1w
         eRsiQ9tGXYJiLAX6UzR/khakIrZvFpZgB1IVAvDGFa58vjjqkyMGyrf25ssplxf+gz2C
         pW/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679010537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HY6ak39HWm1vukAoAm5/mRKLP47+0DQKKodQ4ujm/lU=;
        b=A5YAkIwNnbZwqpVpFILo/e6ursr4qgoROVOgJkMF1K01jL+wtmGcm+JEbsijYC3FDe
         Q1OHL1+yfQJte4St5Aype+uE6/iRQ3shsgD8DG8fQeXKWYjH8QCR66UBGd4VQWws3wtK
         4+mFjp5zZ1kAonaG4sVFJtCOd7FwUaXxul74TvJQPQkO6zj5REWb7BCZmrsaoe4QYM06
         176XeYjpeObnSHYIhXOLg4hHGnofqeL+R+zu6eVBV0uM2YlIB8dAb/tkYTU6bNfRUynp
         BF8bCtoVdptEB2gPKVSXFkrNGtBVkuF9dyRExxiW3REKumdm1K3089uYlG6wCHrvSlse
         5kzQ==
X-Gm-Message-State: AO0yUKV1VLhEs4cGARSeTlQewiGmZ7nASG4hVXpA6Sbh1OlNiR1x0X2F
        etZZdaL+7Q6bpaFOAEbK7d8=
X-Google-Smtp-Source: AK7set9u16NXczfXtttPXuz2RtvI8fpBA4fyuNSCarVJZMFASrHeA4QcJO2lm7H/09JRQGRkqT37nA==
X-Received: by 2002:a17:906:950b:b0:884:3174:119d with SMTP id u11-20020a170906950b00b008843174119dmr13213305ejx.14.1679010537036;
        Thu, 16 Mar 2023 16:48:57 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::a442])
        by smtp.gmail.com with ESMTPSA id h24-20020a1709062dd800b008db605598b9sm226896eji.67.2023.03.16.16.48.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 16:48:55 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Date:   Fri, 17 Mar 2023 00:48:36 +0100
Message-Id: <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1679009443.git.mehdi.djait.k@gmail.com>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the kx022a driver implementation to make it more
generic and extensible.
Add the chip_info structure will to the driver's private
data to hold all the device specific infos.
Move the enum, struct and constants definitions to the header
file.

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/kionix-kx022a-i2c.c |  19 +-
 drivers/iio/accel/kionix-kx022a-spi.c |  22 +-
 drivers/iio/accel/kionix-kx022a.c     | 289 ++++++++++++--------------
 drivers/iio/accel/kionix-kx022a.h     | 128 ++++++++++--
 4 files changed, 274 insertions(+), 184 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index e6fd02d931b6..21c4c0ae1a68 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -15,23 +15,35 @@
 static int kx022a_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
+	struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
+	const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
 
 	if (!i2c->irq) {
 		dev_err(dev, "No IRQ configured\n");
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
+	chip_info = device_get_match_data(&i2c->dev);
+	if (!chip_info)
+		chip_info = (const struct kx022a_chip_info *) id->driver_data;
+
+	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to initialize Regmap\n");
 
-	return kx022a_probe_internal(dev);
+	return kx022a_probe_internal(dev, chip_info);
 }
 
+static const struct i2c_device_id kx022a_i2c_id[] = {
+	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
+
 static const struct of_device_id kx022a_of_match[] = {
-	{ .compatible = "kionix,kx022a", },
+	{ .compatible = "kionix,kx022a", .data = &kx_chip_info[KX022A] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
@@ -42,6 +54,7 @@ static struct i2c_driver kx022a_i2c_driver = {
 		.of_match_table = kx022a_of_match,
 	  },
 	.probe_new    = kx022a_i2c_probe,
+	.id_table     = kx022a_i2c_id,
 };
 module_i2c_driver(kx022a_i2c_driver);
 
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
index 9cd047f7b346..ec076af0f261 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -15,40 +15,46 @@
 static int kx022a_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
+	const struct spi_device_id *id = spi_get_device_id(spi);
 
 	if (!spi->irq) {
 		dev_err(dev, "No IRQ configured\n");
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
+	chip_info = device_get_match_data(&spi->dev);
+	if (!chip_info)
+		chip_info = (const struct kx022a_chip_info *) id->driver_data;
+
+	regmap = devm_regmap_init_spi(spi, chip_info->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to initialize Regmap\n");
 
-	return kx022a_probe_internal(dev);
+	return kx022a_probe_internal(dev, chip_info);
 }
 
-static const struct spi_device_id kx022a_id[] = {
-	{ "kx022a" },
+static const struct spi_device_id kx022a_spi_id[] = {
+	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, kx022a_id);
+MODULE_DEVICE_TABLE(spi, kx022a_spi_id);
 
 static const struct of_device_id kx022a_of_match[] = {
-	{ .compatible = "kionix,kx022a", },
+	{ .compatible = "kionix,kx022a", .data = &kx_chip_info[KX022A] },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
 
 static struct spi_driver kx022a_spi_driver = {
 	.driver = {
-		.name   = "kx022a-spi",
+		.name	= "kx022a-spi",
 		.of_match_table = kx022a_of_match,
 	},
 	.probe = kx022a_spi_probe,
-	.id_table = kx022a_id,
+	.id_table = kx022a_spi_id,
 };
 module_spi_driver(kx022a_spi_driver);
 
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 8dac0337c249..27e8642aa8f5 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -26,29 +26,7 @@
 
 #include "kionix-kx022a.h"
 
-/*
- * The KX022A has FIFO which can store 43 samples of HiRes data from 2
- * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
- * 258 bytes of sample data. The quirk to know is that the amount of bytes in
- * the FIFO is advertised via 8 bit register (max value 255). The thing to note
- * is that full 258 bytes of data is indicated using the max value 255.
- */
-#define KX022A_FIFO_LENGTH			43
-#define KX022A_FIFO_FULL_VALUE			255
-#define KX022A_SOFT_RESET_WAIT_TIME_US		(5 * USEC_PER_MSEC)
-#define KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US	(500 * USEC_PER_MSEC)
-
-/* 3 axis, 2 bytes of data for each of the axis */
-#define KX022A_FIFO_SAMPLES_SIZE_BYTES		6
-#define KX022A_FIFO_MAX_BYTES					\
-	(KX022A_FIFO_LENGTH * KX022A_FIFO_SAMPLES_SIZE_BYTES)
-
-enum {
-	KX022A_STATE_SAMPLE,
-	KX022A_STATE_FIFO,
-};
-
-/* Regmap configs */
+/* kx022a Regmap configs */
 static const struct regmap_range kx022a_volatile_ranges[] = {
 	{
 		.range_min = KX022A_REG_XHP_L,
@@ -138,7 +116,7 @@ static const struct regmap_access_table kx022a_nir_regs = {
 	.n_yes_ranges = ARRAY_SIZE(kx022a_noinc_read_ranges),
 };
 
-const struct regmap_config kx022a_regmap = {
+static const struct regmap_config kx022a_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &kx022a_volatile_regs,
@@ -149,39 +127,6 @@ const struct regmap_config kx022a_regmap = {
 	.max_register = KX022A_MAX_REGISTER,
 	.cache_type = REGCACHE_RBTREE,
 };
-EXPORT_SYMBOL_NS_GPL(kx022a_regmap, IIO_KX022A);
-
-struct kx022a_data {
-	struct regmap *regmap;
-	struct iio_trigger *trig;
-	struct device *dev;
-	struct iio_mount_matrix orientation;
-	int64_t timestamp, old_timestamp;
-
-	int irq;
-	int inc_reg;
-	int ien_reg;
-
-	unsigned int state;
-	unsigned int odr_ns;
-
-	bool trigger_enabled;
-	/*
-	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
-	 * middle of a configuration, or when the fifo is enabled. Also,
-	 * protect the data stored/retrieved from this structure from
-	 * concurrent accesses.
-	 */
-	struct mutex mutex;
-	u8 watermark;
-
-	/* 3 x 16bit accel data + timestamp */
-	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
-	struct {
-		__le16 channels[3];
-		s64 ts __aligned(8);
-	} scan;
-};
 
 static const struct iio_mount_matrix *
 kx022a_get_mount_matrix(const struct iio_dev *idev,
@@ -192,13 +137,6 @@ kx022a_get_mount_matrix(const struct iio_dev *idev,
 	return &data->orientation;
 }
 
-enum {
-	AXIS_X,
-	AXIS_Y,
-	AXIS_Z,
-	AXIS_MAX
-};
-
 static const unsigned long kx022a_scan_masks[] = {
 	BIT(AXIS_X) | BIT(AXIS_Y) | BIT(AXIS_Z), 0
 };
@@ -208,7 +146,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 	{ }
 };
 
-#define KX022A_ACCEL_CHAN(axis, index)				\
+#define KX022A_ACCEL_CHAN(axis, index, device)			\
 {								\
 	.type = IIO_ACCEL,					\
 	.modified = 1,						\
@@ -220,7 +158,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 				BIT(IIO_CHAN_INFO_SCALE) |	\
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.ext_info = kx022a_ext_info,				\
-	.address = KX022A_REG_##axis##OUT_L,			\
+	.address = device##_REG_##axis##OUT_L,			\
 	.scan_index = index,					\
 	.scan_type = {                                          \
 		.sign = 's',					\
@@ -231,9 +169,9 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 }
 
 static const struct iio_chan_spec kx022a_channels[] = {
-	KX022A_ACCEL_CHAN(X, 0),
-	KX022A_ACCEL_CHAN(Y, 1),
-	KX022A_ACCEL_CHAN(Z, 2),
+	KX022A_ACCEL_CHAN(X, 0, KX022A),
+	KX022A_ACCEL_CHAN(Y, 1, KX022A),
+	KX022A_ACCEL_CHAN(Z, 2, KX022A),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
@@ -286,6 +224,34 @@ static const int kx022a_scale_table[][2] = {
 	{ 4788, 403320 },
 };
 
+const struct kx022a_chip_info kx_chip_info[] = {
+	[KX022A] = {
+		.name		  = "kx022a",
+		.type		  = KX022A,
+		.regmap_config	  = &kx022a_regmap_config,
+		.channels	  = kx022a_channels,
+		.num_channels	  = ARRAY_SIZE(kx022a_channels),
+		.fifo_length	  = KX022A_FIFO_LENGTH,
+		.who		  = KX022A_REG_WHO,
+		.id		  = KX022A_ID,
+		.cntl		  = KX022A_REG_CNTL,
+		.cntl2		  = KX022A_REG_CNTL2,
+		.odcntl		  = KX022A_REG_ODCNTL,
+		.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
+		.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
+		.buf_clear	  = KX022A_REG_BUF_CLEAR,
+		.buf_status1	  = KX022A_REG_BUF_STATUS_1,
+		.buf_smp_lvl_mask = KX022A_MASK_BUF_SMP_LVL,
+		.buf_read	  = KX022A_REG_BUF_READ,
+		.inc1		  = KX022A_REG_INC1,
+		.inc4		  = KX022A_REG_INC4,
+		.inc5		  = KX022A_REG_INC5,
+		.inc6		  = KX022A_REG_INC6,
+		.xout_l		  = KX022A_REG_XOUT_L,
+	},
+};
+EXPORT_SYMBOL_NS_GPL(kx_chip_info, IIO_KX022A);
+
 static int kx022a_read_avail(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     const int **vals, int *type, int *length,
@@ -309,19 +275,17 @@ static int kx022a_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
-#define KX022A_DEFAULT_PERIOD_NS (20 * NSEC_PER_MSEC)
-
 static void kx022a_reg2freq(unsigned int val,  int *val1, int *val2)
 {
-	*val1 = kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][0];
-	*val2 = kx022a_accel_samp_freq_table[val & KX022A_MASK_ODR][1];
+	*val1 = kx022a_accel_samp_freq_table[val & KX_MASK_ODR][0];
+	*val2 = kx022a_accel_samp_freq_table[val & KX_MASK_ODR][1];
 }
 
 static void kx022a_reg2scale(unsigned int val, unsigned int *val1,
 			     unsigned int *val2)
 {
-	val &= KX022A_MASK_GSEL;
-	val >>= KX022A_GSEL_SHIFT;
+	val &= KX_MASK_GSEL;
+	val >>= KX_GSEL_SHIFT;
 
 	*val1 = kx022a_scale_table[val][0];
 	*val2 = kx022a_scale_table[val][1];
@@ -332,11 +296,11 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 	int ret;
 
 	if (on)
-		ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL,
-				      KX022A_MASK_PC1);
+		ret = regmap_set_bits(data->regmap, data->chip_info->cntl,
+				      KX_MASK_PC1);
 	else
-		ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
-					KX022A_MASK_PC1);
+		ret = regmap_clear_bits(data->regmap, data->chip_info->cntl,
+					KX_MASK_PC1);
 	if (ret)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
 
@@ -403,8 +367,8 @@ static int kx022a_write_raw(struct iio_dev *idev,
 			break;
 
 		ret = regmap_update_bits(data->regmap,
-					 KX022A_REG_ODCNTL,
-					 KX022A_MASK_ODR, n);
+					 data->chip_info->odcntl,
+					 KX_MASK_ODR, n);
 		data->odr_ns = kx022a_odrs[n];
 		kx022a_turn_on_unlock(data);
 		break;
@@ -424,9 +388,9 @@ static int kx022a_write_raw(struct iio_dev *idev,
 		if (ret)
 			break;
 
-		ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
-					 KX022A_MASK_GSEL,
-					 n << KX022A_GSEL_SHIFT);
+		ret = regmap_update_bits(data->regmap, data->chip_info->cntl,
+					 KX_MASK_GSEL,
+					 n << KX_GSEL_SHIFT);
 		kx022a_turn_on_unlock(data);
 		break;
 	default:
@@ -446,8 +410,8 @@ static int kx022a_fifo_set_wmi(struct kx022a_data *data)
 
 	threshold = data->watermark;
 
-	return regmap_update_bits(data->regmap, KX022A_REG_BUF_CNTL1,
-				  KX022A_MASK_WM_TH, threshold);
+	return regmap_update_bits(data->regmap, data->chip_info->buf_cntl1,
+				  KX_MASK_WM_TH, threshold);
 }
 
 static int kx022a_get_axis(struct kx022a_data *data,
@@ -489,11 +453,11 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		return ret;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
+		ret = regmap_read(data->regmap, data->chip_info->odcntl, &regval);
 		if (ret)
 			return ret;
 
-		if ((regval & KX022A_MASK_ODR) >
+		if ((regval & KX_MASK_ODR) >
 		    ARRAY_SIZE(kx022a_accel_samp_freq_table)) {
 			dev_err(data->dev, "Invalid ODR\n");
 			return -EINVAL;
@@ -504,7 +468,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
+		ret = regmap_read(data->regmap, data->chip_info->cntl, &regval);
 		if (ret < 0)
 			return ret;
 
@@ -531,8 +495,8 @@ static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
 {
 	struct kx022a_data *data = iio_priv(idev);
 
-	if (val > KX022A_FIFO_LENGTH)
-		val = KX022A_FIFO_LENGTH;
+	if (val > data->chip_info->fifo_length)
+		val = data->chip_info->fifo_length;
 
 	mutex_lock(&data->mutex);
 	data->watermark = val;
@@ -580,6 +544,37 @@ static const struct iio_dev_attr *kx022a_fifo_attributes[] = {
 	NULL
 };
 
+static int kx022a_get_fifo_bytes(struct kx022a_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	__le16 buf_status;
+	int ret, fifo_bytes;
+
+	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1, &buf_status, sizeof(buf_status));
+	if (ret) {
+		dev_err(dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	buf_status &= data->chip_info->buf_smp_lvl_mask;
+	fifo_bytes = le16_to_cpu(buf_status);
+
+	/*
+	 * The KX022A has FIFO which can store 43 samples of HiRes data from 2
+	 * channels. This equals to 43 (samples) * 3 (channels) * 2 (bytes/sample) to
+	 * 258 bytes of sample data. The quirk to know is that the amount of bytes in
+	 * the FIFO is advertised via 8 bit register (max value 255). The thing to note
+	 * is that full 258 bytes of data is indicated using the max value 255.
+	 */
+	if (data->chip_info->type == KX022A && fifo_bytes == KX022A_FIFO_FULL_VALUE)
+		fifo_bytes = KX022A_FIFO_MAX_BYTES;
+
+	if (fifo_bytes % KX_FIFO_SAMPLES_SIZE_BYTES)
+		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
+
+	return fifo_bytes;
+}
+
 static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 {
 	/*
@@ -593,35 +588,22 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	 */
 	data->timestamp = 0;
 
-	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
+	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 			       bool irq)
 {
 	struct kx022a_data *data = iio_priv(idev);
-	struct device *dev = regmap_get_device(data->regmap);
-	__le16 buffer[KX022A_FIFO_LENGTH * 3];
+	__le16 buffer[data->chip_info->fifo_length * 3];
 	uint64_t sample_period;
 	int count, fifo_bytes;
 	bool renable = false;
 	int64_t tstamp;
 	int ret, i;
 
-	ret = regmap_read(data->regmap, KX022A_REG_BUF_STATUS_1, &fifo_bytes);
-	if (ret) {
-		dev_err(dev, "Error reading buffer status\n");
-		return ret;
-	}
-
-	/* Let's not overflow if we for some reason get bogus value from i2c */
-	if (fifo_bytes == KX022A_FIFO_FULL_VALUE)
-		fifo_bytes = KX022A_FIFO_MAX_BYTES;
-
-	if (fifo_bytes % KX022A_FIFO_SAMPLES_SIZE_BYTES)
-		dev_warn(data->dev, "Bad FIFO alignment. Data may be corrupt\n");
-
-	count = fifo_bytes / KX022A_FIFO_SAMPLES_SIZE_BYTES;
+	fifo_bytes = kx022a_get_fifo_bytes(data);
+	count = fifo_bytes / KX_FIFO_SAMPLES_SIZE_BYTES;
 	if (!count)
 		return 0;
 
@@ -679,8 +661,8 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 		count = samples;
 	}
 
-	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
-	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
+	fifo_bytes = count * KX_FIFO_SAMPLES_SIZE_BYTES;
+	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
 				&buffer[0], fifo_bytes);
 	if (ret)
 		goto renable_out;
@@ -733,20 +715,18 @@ static const struct iio_info kx022a_info = {
 static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
 {
 	if (en)
-		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
-				       KX022A_MASK_DRDY);
+		return regmap_set_bits(data->regmap, data->chip_info->cntl,
+				       KX_MASK_DRDY);
 
-	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
-				 KX022A_MASK_DRDY);
+	return regmap_clear_bits(data->regmap, data->chip_info->cntl,
+				 KX_MASK_DRDY);
 }
 
 static int kx022a_prepare_irq_pin(struct kx022a_data *data)
 {
 	/* Enable IRQ1 pin. Set polarity to active low */
-	int mask = KX022A_MASK_IEN | KX022A_MASK_IPOL |
-		   KX022A_MASK_ITYP;
-	int val = KX022A_MASK_IEN | KX022A_IPOL_LOW |
-		  KX022A_ITYP_LEVEL;
+	int mask = KX_MASK_IEN | KX_MASK_IPOL | KX_MASK_ITYP;
+	int val = KX_MASK_IEN | KX_IPOL_LOW | KX_ITYP_LEVEL;
 	int ret;
 
 	ret = regmap_update_bits(data->regmap, data->inc_reg, mask, val);
@@ -754,7 +734,7 @@ static int kx022a_prepare_irq_pin(struct kx022a_data *data)
 		return ret;
 
 	/* We enable WMI to IRQ pin only at buffer_enable */
-	mask = KX022A_MASK_INS2_DRDY;
+	mask = KX_MASK_INS2_DRDY;
 
 	return regmap_set_bits(data->regmap, data->ien_reg, mask);
 }
@@ -767,16 +747,16 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
 	if (ret)
 		return ret;
 
-	ret = regmap_clear_bits(data->regmap, data->ien_reg, KX022A_MASK_WMI);
+	ret = regmap_clear_bits(data->regmap, data->ien_reg, KX_MASK_WMI);
 	if (ret)
 		goto unlock_out;
 
-	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
-				KX022A_MASK_BUF_EN);
+	ret = regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
+				KX_MASK_BUF_EN);
 	if (ret)
 		goto unlock_out;
 
-	data->state &= ~KX022A_STATE_FIFO;
+	data->state &= ~KX_STATE_FIFO;
 
 	kx022a_drop_fifo_contents(data);
 
@@ -812,14 +792,14 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 		goto unlock_out;
 
 	/* Enable buffer */
-	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
-			      KX022A_MASK_BUF_EN);
+	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
+			      KX_MASK_BUF_EN);
 	if (ret)
 		goto unlock_out;
 
-	data->state |= KX022A_STATE_FIFO;
+	data->state |= KX_STATE_FIFO;
 	ret = regmap_set_bits(data->regmap, data->ien_reg,
-			      KX022A_MASK_WMI);
+			      KX_MASK_WMI);
 	if (ret)
 		goto unlock_out;
 
@@ -858,8 +838,8 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	struct kx022a_data *data = iio_priv(idev);
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
-			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
+	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l, data->buffer,
+			       KX_FIFO_SAMPLES_SIZE_BYTES);
 	if (ret < 0)
 		goto err_read;
 
@@ -879,7 +859,7 @@ static irqreturn_t kx022a_irq_handler(int irq, void *private)
 	data->old_timestamp = data->timestamp;
 	data->timestamp = iio_get_time_ns(idev);
 
-	if (data->state & KX022A_STATE_FIFO || data->trigger_enabled)
+	if (data->state & KX_STATE_FIFO || data->trigger_enabled)
 		return IRQ_WAKE_THREAD;
 
 	return IRQ_NONE;
@@ -903,10 +883,10 @@ static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
 		ret = IRQ_HANDLED;
 	}
 
-	if (data->state & KX022A_STATE_FIFO) {
+	if (data->state & KX_STATE_FIFO) {
 		int ok;
 
-		ok = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
+		ok = __kx022a_fifo_flush(idev, data->chip_info->fifo_length, true);
 		if (ok > 0)
 			ret = IRQ_HANDLED;
 	}
@@ -927,7 +907,7 @@ static int kx022a_trigger_set_state(struct iio_trigger *trig,
 	if (data->trigger_enabled == state)
 		goto unlock_out;
 
-	if (data->state & KX022A_STATE_FIFO) {
+	if (data->state & KX_STATE_FIFO) {
 		dev_warn(data->dev, "Can't set trigger when FIFO enabled\n");
 		ret = -EBUSY;
 		goto unlock_out;
@@ -959,7 +939,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	int ret, val;
 
 	/* Reset the senor */
-	ret = regmap_write(data->regmap, KX022A_REG_CNTL2, KX022A_MASK_SRST);
+	ret = regmap_write(data->regmap, data->chip_info->cntl2, KX_MASK_SRST);
 	if (ret)
 		return ret;
 
@@ -969,25 +949,25 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	 */
 	msleep(1);
 
-	ret = regmap_read_poll_timeout(data->regmap, KX022A_REG_CNTL2, val,
-				       !(val & KX022A_MASK_SRST),
-				       KX022A_SOFT_RESET_WAIT_TIME_US,
-				       KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US);
+	ret = regmap_read_poll_timeout(data->regmap, data->chip_info->cntl2, val,
+				       !(val & KX_MASK_SRST),
+				       KX_SOFT_RESET_WAIT_TIME_US,
+				       KX_SOFT_RESET_TOTAL_WAIT_TIME_US);
 	if (ret) {
 		dev_err(data->dev, "Sensor reset %s\n",
-			val & KX022A_MASK_SRST ? "timeout" : "fail#");
+			val & KX_MASK_SRST ? "timeout" : "fail#");
 		return ret;
 	}
 
-	ret = regmap_reinit_cache(data->regmap, &kx022a_regmap);
+	ret = regmap_reinit_cache(data->regmap, data->chip_info->regmap_config);
 	if (ret) {
 		dev_err(data->dev, "Failed to reinit reg cache\n");
 		return ret;
 	}
 
 	/* set data res 16bit */
-	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
-			      KX022A_MASK_BRES16);
+	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
+			      KX_MASK_BRES16);
 	if (ret) {
 		dev_err(data->dev, "Failed to set data resolution\n");
 		return ret;
@@ -996,7 +976,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	return kx022a_prepare_irq_pin(data);
 }
 
-int kx022a_probe_internal(struct device *dev)
+int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
 {
 	static const char * const regulator_names[] = {"io-vdd", "vdd"};
 	struct iio_trigger *indio_trig;
@@ -1023,6 +1003,7 @@ int kx022a_probe_internal(struct device *dev)
 		return -ENOMEM;
 
 	data = iio_priv(idev);
+	data->chip_info = chip_info;
 
 	/*
 	 * VDD is the analog and digital domain voltage supply and
@@ -1033,37 +1014,37 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to enable regulator\n");
 
-	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
+	ret = regmap_read(regmap, data->chip_info->who, &chip_id);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID) {
+	if (chip_id != data->chip_info->id) {
 		dev_err(dev, "unsupported device 0x%x\n", chip_id);
 		return -EINVAL;
 	}
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-		data->inc_reg = KX022A_REG_INC1;
-		data->ien_reg = KX022A_REG_INC4;
+		data->inc_reg = data->chip_info->inc1;
+		data->ien_reg = data->chip_info->inc4;
 	} else {
 		irq = fwnode_irq_get_byname(fwnode, "INT2");
 		if (irq <= 0)
 			return dev_err_probe(dev, irq, "No suitable IRQ\n");
 
-		data->inc_reg = KX022A_REG_INC5;
-		data->ien_reg = KX022A_REG_INC6;
+		data->inc_reg = data->chip_info->inc5;
+		data->ien_reg = data->chip_info->inc6;
 	}
 
 	data->regmap = regmap;
 	data->dev = dev;
 	data->irq = irq;
-	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
+	data->odr_ns = KX_DEFAULT_PERIOD_NS;
 	mutex_init(&data->mutex);
 
-	idev->channels = kx022a_channels;
-	idev->num_channels = ARRAY_SIZE(kx022a_channels);
-	idev->name = "kx022-accel";
+	idev->channels = data->chip_info->channels;
+	idev->num_channels = data->chip_info->num_channels;
+	idev->name = data->chip_info->name;
 	idev->info = &kx022a_info;
 	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	idev->available_scan_masks = kx022a_scan_masks;
@@ -1112,7 +1093,7 @@ int kx022a_probe_internal(struct device *dev)
 	 * No need to check for NULL. request_threaded_irq() defaults to
 	 * dev_name() should the alloc fail.
 	 */
-	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-kx022a",
+	name = devm_kasprintf(data->dev, GFP_KERNEL, "%s-accel",
 			      dev_name(data->dev));
 
 	ret = devm_request_threaded_irq(data->dev, irq, kx022a_irq_handler,
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 12424649d438..3bb40e9f5613 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -11,24 +11,48 @@
 #include <linux/bits.h>
 #include <linux/regmap.h>
 
+#include <linux/iio/iio.h>
+
+/* Common for all supported devices */
+#define KX_FIFO_SAMPLES_SIZE_BYTES	    6
+#define KX_SOFT_RESET_WAIT_TIME_US	    (5 * USEC_PER_MSEC)
+#define KX_SOFT_RESET_TOTAL_WAIT_TIME_US    (500 * USEC_PER_MSEC)
+#define KX_DEFAULT_PERIOD_NS		    (20 * NSEC_PER_MSEC)
+#define KX_MASK_GSEL			    GENMASK(4, 3)
+#define KX_MASK_ODR			    GENMASK(3, 0)
+#define KX_MASK_WM_TH			    GENMASK(6, 0)
+#define KX_GSEL_SHIFT			    3
+#define KX_MASK_IEN			    BIT(5)
+#define KX_MASK_DRDY			    BIT(5)
+#define KX_MASK_PC1			    BIT(7)
+#define KX_MASK_IPOL			    BIT(4)
+#define KX_IPOL_LOW			    0
+#define KX_MASK_ITYP			    BIT(3)
+#define KX_ITYP_LEVEL			    0
+#define KX_MASK_INS2_DRDY		    BIT(4)
+#define KX_MASK_WMI			    BIT(5)
+#define KX_MASK_BUF_EN			    BIT(7)
+#define KX_MASK_SRST			    BIT(7)
+#define KX_MASK_BRES16			    BIT(6)
+
+
 #define KX022A_REG_WHO		0x0f
 #define KX022A_ID		0xc8
 
+#define KX022A_FIFO_LENGTH	43
+#define KX022A_FIFO_FULL_VALUE	255
+#define KX022A_FIFO_MAX_BYTES					\
+	 (KX022A_FIFO_LENGTH * KX_FIFO_SAMPLES_SIZE_BYTES)
+
 #define KX022A_REG_CNTL2	0x19
-#define KX022A_MASK_SRST	BIT(7)
 #define KX022A_REG_CNTL		0x18
-#define KX022A_MASK_PC1		BIT(7)
 #define KX022A_MASK_RES		BIT(6)
-#define KX022A_MASK_DRDY	BIT(5)
-#define KX022A_MASK_GSEL	GENMASK(4, 3)
-#define KX022A_GSEL_SHIFT	3
 #define KX022A_GSEL_2		0x0
 #define KX022A_GSEL_4		BIT(3)
 #define KX022A_GSEL_8		BIT(4)
 #define KX022A_GSEL_16		GENMASK(4, 3)
 
 #define KX022A_REG_INS2		0x13
-#define KX022A_MASK_INS2_DRDY	BIT(4)
 #define KX122_MASK_INS2_WMI	BIT(5)
 
 #define KX022A_REG_XHP_L	0x0
@@ -45,38 +69,104 @@
 #define KX022A_REG_MAN_WAKE	0x2c
 
 #define KX022A_REG_BUF_CNTL1	0x3a
-#define KX022A_MASK_WM_TH	GENMASK(6, 0)
 #define KX022A_REG_BUF_CNTL2	0x3b
-#define KX022A_MASK_BUF_EN	BIT(7)
-#define KX022A_MASK_BRES16	BIT(6)
 #define KX022A_REG_BUF_STATUS_1	0x3c
 #define KX022A_REG_BUF_STATUS_2	0x3d
+#define KX022A_MASK_BUF_SMP_LVL GENMASK(6, 0)
 #define KX022A_REG_BUF_CLEAR	0x3e
 #define KX022A_REG_BUF_READ	0x3f
-#define KX022A_MASK_ODR		GENMASK(3, 0)
 #define KX022A_ODR_SHIFT	3
 #define KX022A_FIFO_MAX_WMI_TH	41
 
 #define KX022A_REG_INC1		0x1c
 #define KX022A_REG_INC5		0x20
 #define KX022A_REG_INC6		0x21
-#define KX022A_MASK_IEN		BIT(5)
-#define KX022A_MASK_IPOL	BIT(4)
 #define KX022A_IPOL_LOW		0
-#define KX022A_IPOL_HIGH	KX022A_MASK_IPOL1
-#define KX022A_MASK_ITYP	BIT(3)
-#define KX022A_ITYP_PULSE	KX022A_MASK_ITYP
-#define KX022A_ITYP_LEVEL	0
+#define KX022A_IPOL_HIGH	KX_MASK_IPOL
+#define KX022A_ITYP_PULSE	KX_MASK_ITYP
 
 #define KX022A_REG_INC4		0x1f
-#define KX022A_MASK_WMI		BIT(5)
 
 #define KX022A_REG_SELF_TEST	0x60
 #define KX022A_MAX_REGISTER	0x60
 
+enum kx022a_device_type {
+	KX022A,
+};
+
+enum {
+	KX_STATE_SAMPLE,
+	KX_STATE_FIFO,
+};
+
+enum {
+	AXIS_X,
+	AXIS_Y,
+	AXIS_Z,
+	AXIS_MAX
+};
+
 struct device;
 
-int kx022a_probe_internal(struct device *dev);
-extern const struct regmap_config kx022a_regmap;
+struct kx022a_chip_info {
+	const char *name;
+	enum kx022a_device_type type;
+	const struct regmap_config *regmap_config;
+	const struct iio_chan_spec *channels;
+	unsigned int num_channels;
+	unsigned int fifo_length;
+	u8 who;
+	u8 id;
+	u8 cntl;
+	u8 cntl2;
+	u8 odcntl;
+	u8 buf_cntl1;
+	u8 buf_cntl2;
+	u8 buf_clear;
+	u8 buf_status1;
+	u16 buf_smp_lvl_mask;
+	u8 buf_read;
+	u8 inc1;
+	u8 inc4;
+	u8 inc5;
+	u8 inc6;
+	u8 xout_l;
+};
+
+struct kx022a_data {
+	const struct kx022a_chip_info *chip_info;
+	struct regmap *regmap;
+	struct iio_trigger *trig;
+	struct device *dev;
+	struct iio_mount_matrix orientation;
+	int64_t timestamp, old_timestamp;
+
+	int irq;
+	int inc_reg;
+	int ien_reg;
+
+	unsigned int state;
+	unsigned int odr_ns;
+
+	bool trigger_enabled;
+	/*
+	 * Prevent toggling the sensor stby/active state (PC1 bit) in the
+	 * middle of a configuration, or when the fifo is enabled. Also,
+	 * protect the data stored/retrieved from this structure from
+	 * concurrent accesses.
+	 */
+	struct mutex mutex;
+	u8 watermark;
+
+	/* 3 x 16bit accel data + timestamp */
+	__le16 buffer[8] __aligned(IIO_DMA_MINALIGN);
+	struct {
+		__le16 channels[3];
+		s64 ts __aligned(8);
+	} scan;
+};
+
+int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
+extern const struct kx022a_chip_info kx_chip_info[];
 
 #endif
-- 
2.30.2

