Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17A2E6E9D16
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 22:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjDTUXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 16:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjDTUXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 16:23:04 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4435B85;
        Thu, 20 Apr 2023 13:22:39 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-94a34a14a54so119076866b.1;
        Thu, 20 Apr 2023 13:22:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682022158; x=1684614158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J92/mGPOKwRe8b0k7TiWa8uXmFu4uTnMw0vXrJ4qGUQ=;
        b=LIMktiNKSVndcEGp8MLfbag3O0BzlBOypPpMKAANXldJMTnAIMhM/IdMuZ/KcjA1pB
         GMQ0kP5rYmfCzD9V9kRk7trGcJnzCITeigyG38CyjfHdQiXVfwNmbKXW0OfACll8R/jx
         /a78jfnbFMB64VCaHBkot2s0ZS9MaTRsmSv8vwkV69+9zY7isRnD3sAx5BAIinXX2UfV
         G5POoMb039QoW1sqF/n+qUo4HdLTn4jgzFvGskSsLXP7B3bgV561pQMqna68uYHo7Pq5
         8DH1j8G8eG32LYInUJno0nMhu2JunQ2Aj1Jw4/Xn+McNkptCwlDerfD0SE9YhEVSDEf2
         g3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682022158; x=1684614158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J92/mGPOKwRe8b0k7TiWa8uXmFu4uTnMw0vXrJ4qGUQ=;
        b=eZFd/9/C33Z39i9l+gFNMXPBpRm4MmQ4cWPjlBi0UYbEiRPpBpXbEceJjuOr6FI5aT
         kPBg5le/yqjwCd6uiCz2jltOydi11VB4r+6bLHKojkFIGrxpSQiLzjKmucBr6J9V/dWG
         Jp3sD/hXiDaWHlV+NTp2fpJ/CXT0e33YVCmB6eDLL0+yuHHxWK0UTrltxCbEqlkcO04D
         SUJTO55vTVllbu5Ptqotc/l6M2IAjH74r0HAP6vIDHXdbshnfoGcWTmFm7o3CTrJRb8Z
         3jsiNsyHfpGgylPDvoX9kyOJwhz3AbQZbvi/4vEOuiG3/gXm6uAvBdXyxOxqYjBgWjAw
         t3Rw==
X-Gm-Message-State: AAQBX9eEYW2giHXMydx8Orp8I9PJZIyvxRHjpawtrtBqQPxAhLp9Jtwt
        MTLAY7rsZT+ffT86AkIpZWg=
X-Google-Smtp-Source: AKy350Z0r5JBnJz0iibwEOWo2aGCjecyEOHvD8Jv6zBsAv6T7l9ShATzQ0n3uW9Vg75hpOdmiOY2qQ==
X-Received: by 2002:a17:907:9518:b0:94a:845c:3528 with SMTP id ew24-20020a170907951800b0094a845c3528mr155459ejc.45.1682022157974;
        Thu, 20 Apr 2023 13:22:37 -0700 (PDT)
Received: from carbian.fritz.box ([2a02:8109:aa3f:ead8::d7e8])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b00932ba722482sm1136881ejn.149.2023.04.20.13.22.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Apr 2023 13:22:37 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v2 3/5] iio: accel: kionix-kx022a: Refactor driver and add chip_info structure
Date:   Thu, 20 Apr 2023 22:22:03 +0200
Message-Id: <e0b599e3f1d1fe0c68e4e0083c8d51fbf0834059.1682019544.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682019544.git.mehdi.djait.k@gmail.com>
References: <cover.1682019544.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor the kx022a driver implementation to make it more generic and
extensible.
Introduce an i2c_device_id table.
Add the chip_info structure to the driver's private data to hold all
the device specific infos.

Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
v2:
- mentioned the introduction of the i2c_device_id table in the commit
- get i2c_/spi_get_device_id only with device get match fails
- removed the generic KX_define
- removed the kx022a_device_type enum
- added comments for the chip_info struct elements
- fixed errors pointed out by the kernel test robot

 drivers/iio/accel/kionix-kx022a-i2c.c |  20 ++++-
 drivers/iio/accel/kionix-kx022a-spi.c |  21 ++++--
 drivers/iio/accel/kionix-kx022a.c     | 102 ++++++++++++++++----------
 drivers/iio/accel/kionix-kx022a.h     |  54 +++++++++++++-
 4 files changed, 146 insertions(+), 51 deletions(-)

diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index e6fd02d931b6..ce299d0446f7 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -15,6 +15,7 @@
 static int kx022a_i2c_probe(struct i2c_client *i2c)
 {
 	struct device *dev = &i2c->dev;
+	const struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
 
 	if (!i2c->irq) {
@@ -22,16 +23,28 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_i2c(i2c, &kx022a_regmap);
+	chip_info = device_get_match_data(&i2c->dev);
+	if (!chip_info) {
+		const struct i2c_device_id *id = i2c_client_get_device_id(i2c);
+		chip_info = (const struct kx022a_chip_info *)id->driver_data;
+	}
+
+	regmap = devm_regmap_init_i2c(i2c, chip_info->regmap_config);
 	if (IS_ERR(regmap))
 		return dev_err_probe(dev, PTR_ERR(regmap),
 				     "Failed to initialize Regmap\n");
 
-	return kx022a_probe_internal(dev);
+	return kx022a_probe_internal(dev, chip_info);
 }
 
+static const struct i2c_device_id kx022a_i2c_id[] = {
+	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
+
 static const struct of_device_id kx022a_of_match[] = {
-	{ .compatible = "kionix,kx022a", },
+	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
@@ -42,6 +55,7 @@ static struct i2c_driver kx022a_i2c_driver = {
 		.of_match_table = kx022a_of_match,
 	  },
 	.probe_new    = kx022a_i2c_probe,
+	.id_table     = kx022a_i2c_id,
 };
 module_i2c_driver(kx022a_i2c_driver);
 
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
index 9cd047f7b346..7bc81588e40e 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -15,6 +15,7 @@
 static int kx022a_spi_probe(struct spi_device *spi)
 {
 	struct device *dev = &spi->dev;
+	const struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
 
 	if (!spi->irq) {
@@ -22,22 +23,28 @@ static int kx022a_spi_probe(struct spi_device *spi)
 		return -EINVAL;
 	}
 
-	regmap = devm_regmap_init_spi(spi, &kx022a_regmap);
+	chip_info = device_get_match_data(&spi->dev);
+	if (!chip_info) {
+		const struct spi_device_id *id = spi_get_device_id(spi);
+		chip_info = (const struct kx022a_chip_info *)id->driver_data;
+	}
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
+	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
 	{ }
 };
-MODULE_DEVICE_TABLE(spi, kx022a_id);
+MODULE_DEVICE_TABLE(spi, kx022a_spi_id);
 
 static const struct of_device_id kx022a_of_match[] = {
-	{ .compatible = "kionix,kx022a", },
+	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
@@ -48,7 +55,7 @@ static struct spi_driver kx022a_spi_driver = {
 		.of_match_table = kx022a_of_match,
 	},
 	.probe = kx022a_spi_probe,
-	.id_table = kx022a_id,
+	.id_table = kx022a_spi_id,
 };
 module_spi_driver(kx022a_spi_driver);
 
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 70530005cad3..7f9a2c29790b 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -48,7 +48,7 @@ enum {
 	KX022A_STATE_FIFO,
 };
 
-/* Regmap configs */
+/* kx022a Regmap configs */
 static const struct regmap_range kx022a_volatile_ranges[] = {
 	{
 		.range_min = KX022A_REG_XHP_L,
@@ -138,7 +138,7 @@ static const struct regmap_access_table kx022a_nir_regs = {
 	.n_yes_ranges = ARRAY_SIZE(kx022a_noinc_read_ranges),
 };
 
-const struct regmap_config kx022a_regmap = {
+static const struct regmap_config kx022a_regmap_config = {
 	.reg_bits = 8,
 	.val_bits = 8,
 	.volatile_table = &kx022a_volatile_regs,
@@ -149,7 +149,6 @@ const struct regmap_config kx022a_regmap = {
 	.max_register = KX022A_MAX_REGISTER,
 	.cache_type = REGCACHE_RBTREE,
 };
-EXPORT_SYMBOL_NS_GPL(kx022a_regmap, IIO_KX022A);
 
 struct kx022a_data {
 	struct regmap *regmap;
@@ -208,7 +207,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 	{ }
 };
 
-#define KX022A_ACCEL_CHAN(axis, index)				\
+#define KX022A_ACCEL_CHAN(axis, reg, index)			\
 {								\
 	.type = IIO_ACCEL,					\
 	.modified = 1,						\
@@ -220,7 +219,7 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 				BIT(IIO_CHAN_INFO_SCALE) |	\
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
 	.ext_info = kx022a_ext_info,				\
-	.address = KX022A_REG_##axis##OUT_L,			\
+	.address = reg,						\
 	.scan_index = index,					\
 	.scan_type = {                                          \
 		.sign = 's',					\
@@ -231,9 +230,9 @@ static const struct iio_chan_spec_ext_info kx022a_ext_info[] = {
 }
 
 static const struct iio_chan_spec kx022a_channels[] = {
-	KX022A_ACCEL_CHAN(X, 0),
-	KX022A_ACCEL_CHAN(Y, 1),
-	KX022A_ACCEL_CHAN(Z, 2),
+	KX022A_ACCEL_CHAN(X, KX022A_REG_XOUT_L, 0),
+	KX022A_ACCEL_CHAN(Y, KX022A_REG_YOUT_L, 1),
+	KX022A_ACCEL_CHAN(Z, KX022A_REG_ZOUT_L, 2),
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
@@ -332,10 +331,10 @@ static int kx022a_turn_on_off_unlocked(struct kx022a_data *data, bool on)
 	int ret;
 
 	if (on)
-		ret = regmap_set_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_set_bits(data->regmap, data->chip_info->cntl,
 				      KX022A_MASK_PC1);
 	else
-		ret = regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_clear_bits(data->regmap, data->chip_info->cntl,
 					KX022A_MASK_PC1);
 	if (ret)
 		dev_err(data->dev, "Turn %s fail %d\n", str_on_off(on), ret);
@@ -403,7 +402,7 @@ static int kx022a_write_raw(struct iio_dev *idev,
 			break;
 
 		ret = regmap_update_bits(data->regmap,
-					 KX022A_REG_ODCNTL,
+					 data->chip_info->odcntl,
 					 KX022A_MASK_ODR, n);
 		data->odr_ns = kx022a_odrs[n];
 		kx022a_turn_on_unlock(data);
@@ -424,7 +423,7 @@ static int kx022a_write_raw(struct iio_dev *idev,
 		if (ret)
 			break;
 
-		ret = regmap_update_bits(data->regmap, KX022A_REG_CNTL,
+		ret = regmap_update_bits(data->regmap, data->chip_info->cntl,
 					 KX022A_MASK_GSEL,
 					 n << KX022A_GSEL_SHIFT);
 		kx022a_turn_on_unlock(data);
@@ -446,7 +445,7 @@ static int kx022a_fifo_set_wmi(struct kx022a_data *data)
 
 	threshold = data->watermark;
 
-	return regmap_update_bits(data->regmap, KX022A_REG_BUF_CNTL1,
+	return regmap_update_bits(data->regmap, data->chip_info->buf_cntl1,
 				  KX022A_MASK_WM_TH, threshold);
 }
 
@@ -489,7 +488,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		return ret;
 
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		ret = regmap_read(data->regmap, KX022A_REG_ODCNTL, &regval);
+		ret = regmap_read(data->regmap, data->chip_info->odcntl, &regval);
 		if (ret)
 			return ret;
 
@@ -504,7 +503,7 @@ static int kx022a_read_raw(struct iio_dev *idev,
 		return IIO_VAL_INT_PLUS_MICRO;
 
 	case IIO_CHAN_INFO_SCALE:
-		ret = regmap_read(data->regmap, KX022A_REG_CNTL, &regval);
+		ret = regmap_read(data->regmap, data->chip_info->cntl, &regval);
 		if (ret < 0)
 			return ret;
 
@@ -531,8 +530,8 @@ static int kx022a_set_watermark(struct iio_dev *idev, unsigned int val)
 {
 	struct kx022a_data *data = iio_priv(idev);
 
-	if (val > KX022A_FIFO_LENGTH)
-		val = KX022A_FIFO_LENGTH;
+	if (val > data->chip_info->fifo_length)
+		val = data->chip_info->fifo_length;
 
 	mutex_lock(&data->mutex);
 	data->watermark = val;
@@ -593,7 +592,7 @@ static int kx022a_drop_fifo_contents(struct kx022a_data *data)
 	 */
 	data->timestamp = 0;
 
-	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0x0);
+	return regmap_write(data->regmap, data->chip_info->buf_clear, 0x0);
 }
 
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
@@ -680,7 +679,7 @@ static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 	}
 
 	fifo_bytes = count * KX022A_FIFO_SAMPLES_SIZE_BYTES;
-	ret = regmap_noinc_read(data->regmap, KX022A_REG_BUF_READ,
+	ret = regmap_noinc_read(data->regmap, data->chip_info->buf_read,
 				&buffer[0], fifo_bytes);
 	if (ret)
 		goto renable_out;
@@ -733,10 +732,10 @@ static const struct iio_info kx022a_info = {
 static int kx022a_set_drdy_irq(struct kx022a_data *data, bool en)
 {
 	if (en)
-		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
+		return regmap_set_bits(data->regmap, data->chip_info->cntl,
 				       KX022A_MASK_DRDY);
 
-	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
+	return regmap_clear_bits(data->regmap, data->chip_info->cntl,
 				 KX022A_MASK_DRDY);
 }
 
@@ -771,7 +770,7 @@ static int kx022a_fifo_disable(struct kx022a_data *data)
 	if (ret)
 		goto unlock_out;
 
-	ret = regmap_clear_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+	ret = regmap_clear_bits(data->regmap, data->chip_info->buf_cntl2,
 				KX022A_MASK_BUF_EN);
 	if (ret)
 		goto unlock_out;
@@ -812,7 +811,7 @@ static int kx022a_fifo_enable(struct kx022a_data *data)
 		goto unlock_out;
 
 	/* Enable buffer */
-	ret = regmap_set_bits(data->regmap, KX022A_REG_BUF_CNTL2,
+	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BUF_EN);
 	if (ret)
 		goto unlock_out;
@@ -858,7 +857,7 @@ static irqreturn_t kx022a_trigger_handler(int irq, void *p)
 	struct kx022a_data *data = iio_priv(idev);
 	int ret;
 
-	ret = regmap_bulk_read(data->regmap, KX022A_REG_XOUT_L, data->buffer,
+	ret = regmap_bulk_read(data->regmap, data->chip_info->xout_l, data->buffer,
 			       KX022A_FIFO_SAMPLES_SIZE_BYTES);
 	if (ret < 0)
 		goto err_read;
@@ -906,7 +905,7 @@ static irqreturn_t kx022a_irq_thread_handler(int irq, void *private)
 	if (data->state & KX022A_STATE_FIFO) {
 		int ok;
 
-		ok = __kx022a_fifo_flush(idev, KX022A_FIFO_LENGTH, true);
+		ok = __kx022a_fifo_flush(idev, data->chip_info->fifo_length, true);
 		if (ok > 0)
 			ret = IRQ_HANDLED;
 	}
@@ -959,7 +958,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	int ret, val;
 
 	/* Reset the senor */
-	ret = regmap_write(data->regmap, KX022A_REG_CNTL2, KX022A_MASK_SRST);
+	ret = regmap_write(data->regmap, data->chip_info->cntl2, KX022A_MASK_SRST);
 	if (ret)
 		return ret;
 
@@ -969,7 +968,7 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	 */
 	msleep(1);
 
-	ret = regmap_read_poll_timeout(data->regmap, KX022A_REG_CNTL2, val,
+	ret = regmap_read_poll_timeout(data->regmap, data->chip_info->cntl2, val,
 				       !(val & KX022A_MASK_SRST),
 				       KX022A_SOFT_RESET_WAIT_TIME_US,
 				       KX022A_SOFT_RESET_TOTAL_WAIT_TIME_US);
@@ -979,14 +978,14 @@ static int kx022a_chip_init(struct kx022a_data *data)
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
+	ret = regmap_set_bits(data->regmap, data->chip_info->buf_cntl2,
 			      KX022A_MASK_BRES16);
 	if (ret) {
 		dev_err(data->dev, "Failed to set data resolution\n");
@@ -996,7 +995,31 @@ static int kx022a_chip_init(struct kx022a_data *data)
 	return kx022a_prepare_irq_pin(data);
 }
 
-int kx022a_probe_internal(struct device *dev)
+const struct kx022a_chip_info kx022a_chip_info = {
+	.name		  = "kx022-accel",
+	.regmap_config	  = &kx022a_regmap_config,
+	.channels	  = kx022a_channels,
+	.num_channels	  = ARRAY_SIZE(kx022a_channels),
+	.fifo_length	  = KX022A_FIFO_LENGTH,
+	.who		  = KX022A_REG_WHO,
+	.id		  = KX022A_ID,
+	.cntl		  = KX022A_REG_CNTL,
+	.cntl2		  = KX022A_REG_CNTL2,
+	.odcntl		  = KX022A_REG_ODCNTL,
+	.buf_cntl1	  = KX022A_REG_BUF_CNTL1,
+	.buf_cntl2	  = KX022A_REG_BUF_CNTL2,
+	.buf_clear	  = KX022A_REG_BUF_CLEAR,
+	.buf_status1	  = KX022A_REG_BUF_STATUS_1,
+	.buf_read	  = KX022A_REG_BUF_READ,
+	.inc1		  = KX022A_REG_INC1,
+	.inc4		  = KX022A_REG_INC4,
+	.inc5		  = KX022A_REG_INC5,
+	.inc6		  = KX022A_REG_INC6,
+	.xout_l		  = KX022A_REG_XOUT_L,
+};
+EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
+
+int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
 {
 	static const char * const regulator_names[] = {"io-vdd", "vdd"};
 	struct iio_trigger *indio_trig;
@@ -1023,6 +1046,7 @@ int kx022a_probe_internal(struct device *dev)
 		return -ENOMEM;
 
 	data = iio_priv(idev);
+	data->chip_info = chip_info;
 
 	/*
 	 * VDD is the analog and digital domain voltage supply and
@@ -1033,24 +1057,24 @@ int kx022a_probe_internal(struct device *dev)
 	if (ret && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to enable regulator\n");
 
-	ret = regmap_read(regmap, KX022A_REG_WHO, &chip_id);
+	ret = regmap_read(regmap, chip_info->who, &chip_id);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to access sensor\n");
 
-	if (chip_id != KX022A_ID) {
+	if (chip_id != chip_info->id)
 		dev_warn(dev, "unsupported device 0x%x\n", chip_id);
 
 	irq = fwnode_irq_get_byname(fwnode, "INT1");
 	if (irq > 0) {
-		data->inc_reg = KX022A_REG_INC1;
-		data->ien_reg = KX022A_REG_INC4;
+		data->inc_reg = chip_info->inc1;
+		data->ien_reg = chip_info->inc4;
 	} else {
 		irq = fwnode_irq_get_byname(fwnode, "INT2");
 		if (irq <= 0)
 			return dev_err_probe(dev, irq, "No suitable IRQ\n");
 
-		data->inc_reg = KX022A_REG_INC5;
-		data->ien_reg = KX022A_REG_INC6;
+		data->inc_reg = chip_info->inc5;
+		data->ien_reg = chip_info->inc6;
 	}
 
 	data->regmap = regmap;
@@ -1059,9 +1083,9 @@ int kx022a_probe_internal(struct device *dev)
 	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
 	mutex_init(&data->mutex);
 
-	idev->channels = kx022a_channels;
-	idev->num_channels = ARRAY_SIZE(kx022a_channels);
-	idev->name = "kx022-accel";
+	idev->channels = chip_info->channels;
+	idev->num_channels = chip_info->num_channels;
+	idev->name = chip_info->name;
 	idev->info = &kx022a_info;
 	idev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
 	idev->available_scan_masks = kx022a_scan_masks;
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index 12424649d438..3c31e7d88f78 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -76,7 +76,57 @@
 
 struct device;
 
-int kx022a_probe_internal(struct device *dev);
-extern const struct regmap_config kx022a_regmap;
+/**
+ * struct kx022a_chip_info - Kionix accelerometer chip specific information
+ *
+ * @name:		name of the device
+ * @regmap_config:	pointer to register map configuration
+ * @channels:		pointer to iio_chan_spec array
+ * @num_channels:	number of iio_chan_spec channels
+ * @fifo_length:	number of 16-bit samples in a full buffer
+ * @who:		WHO_AM_I register
+ * @id:			WHO_AM_I register value
+ * @cntl:		control register 1
+ * @cntl2:		control register 2
+ * @odcntl:		output data control register
+ * @buf_cntl1:		buffer control register 1
+ * @buf_cntl2:		buffer control register 2
+ * @buf_clear:		buffer clear register
+ * @buf_status1:	buffer status register 1
+ * @buf_smp_lvl_mask:	buffer sample level mask
+ * @buf_read:		buffer read register
+ * @inc1:		interrupt control register 1
+ * @inc4:		interrupt control register 4
+ * @inc5:		interrupt control register 5
+ * @inc6:		interrupt control register 6
+ * @xout_l:		x-axis output least significant byte
+ */
+struct kx022a_chip_info {
+	const char *name;
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
+int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
+
+extern const struct kx022a_chip_info kx022a_chip_info;
 
 #endif
-- 
2.30.2

