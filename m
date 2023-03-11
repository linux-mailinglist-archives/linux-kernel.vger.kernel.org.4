Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C77F36B5C52
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 14:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjCKNkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 08:40:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjCKNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 08:40:28 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06215120EBC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:40:27 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id s12so8717022qtq.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 05:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678542026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f3Xj1IbOZVq4+100AodKd8uUFRcQmpC1YabmNJYx1GY=;
        b=DwqjHMJqnvC3bo5YaJX+03dQiq/NDGU7RWFsMfAa5Ebd9NXfSXv5V5yhCm8N6IYVLY
         hcREekK4pddCGwEtVgS732qysuAagLIlvIQHdFniLJDcCMnn4C/Zu5JBxKYcvxftOBCp
         8QBP54dqbRQNLgvZYcNVwOEnF1dmpQjGtOmHaWEAI7sGHcY2att2D33GA2kiPVlxzTwR
         EmPSw7t2mC0ZiSIBGxw00HROzEoMnuHnOFOuqxYRi1gZg6Qt78J3s8Dy6dvNIjzYB1TK
         YZc0LUajOiVf/qJpBDz4eNNJsfk/yQSyDwzKc/UhwxHgpnHnsuu75QCtqvO65iznD2Wn
         YAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678542026;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=f3Xj1IbOZVq4+100AodKd8uUFRcQmpC1YabmNJYx1GY=;
        b=XpUhGXVgouCSzHJsoTEgZ7mS3vI0UwbqO5FBvETH0vctVIyOcGXgH5Pqbst710AwQ/
         KlK33tM95jUfJLaOylMXfH92SDjscunglSHotzKbkxPSqqwIxq8Dh45PQhg1Lc6ER098
         z508h0KCgExa/sdJBxt0Y3669vI5EotlaXH6pYVeiuSZCrmdCXFOPZJXJhoAk+VnPxf5
         /XSUMo7OUMvXNbDV8CaFma3Zd05/rsl2iFyqeu/B9MjWF6R+OoPzmnc9UXW9hvf6Jt9D
         oW2HBWcNMpX0yvkSOIFkNCF43Kh7cw0t2bdQqw68AZXYgcz1RqmbiYm9+rbZohzoF3Cd
         P9bw==
X-Gm-Message-State: AO0yUKVqQQ9wdAKZbEs3XG5gQ7irUpXxPredJpFWia014d9MTSfWadcZ
        Z6HakcPM7Dciif9aCg1SHWrOJA==
X-Google-Smtp-Source: AK7set+AhlAqXzQOT10DhjtxzJQjQDFaEX2GE4eUT/a+0T8Uh4R4xV6Q3i5JWgsfQZz1vtJkbuTi4w==
X-Received: by 2002:a05:622a:144c:b0:3bf:c458:3b0c with SMTP id v12-20020a05622a144c00b003bfc4583b0cmr47698460qtx.30.1678542026073;
        Sat, 11 Mar 2023 05:40:26 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id f10-20020ac8464a000000b003bd0e7ff466sm1900995qto.7.2023.03.11.05.40.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 05:40:25 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] iio: dac: cio-dac: Migrate to the regmap API
Date:   Sat, 11 Mar 2023 08:40:12 -0500
Message-Id: <20230311134012.70822-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regmap API supports IO port accessors so we can take advantage of
regmap abstractions rather than handling access to the device registers
directly in the driver.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/dac/Kconfig   |  1 +
 drivers/iio/dac/cio-dac.c | 71 +++++++++++++++++++++++++++++----------
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index d3f90cf86143..3acd9c3f388e 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -277,6 +277,7 @@ config CIO_DAC
 	tristate "Measurement Computing CIO-DAC IIO driver"
 	depends on X86 && (ISA_BUS || PC104)
 	select ISA_BUS_API
+	select REGMAP_MMIO
 	help
 	  Say yes here to build support for the Measurement Computing CIO-DAC
 	  analog output device family (CIO-DAC16, CIO-DAC08, PC104-DAC06). The
diff --git a/drivers/iio/dac/cio-dac.c b/drivers/iio/dac/cio-dac.c
index 791dd999cf29..13438f022f8e 100644
--- a/drivers/iio/dac/cio-dac.c
+++ b/drivers/iio/dac/cio-dac.c
@@ -6,16 +6,15 @@
  * This driver supports the following Measurement Computing devices: CIO-DAC16,
  * CIO-DAC06, and PC104-DAC06.
  */
-#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/errno.h>
+#include <linux/err.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
-#include <linux/io.h>
-#include <linux/ioport.h>
 #include <linux/isa.h>
 #include <linux/module.h>
 #include <linux/moduleparam.h>
+#include <linux/regmap.h>
 #include <linux/types.h>
 
 #define CIO_DAC_NUM_CHAN 16
@@ -35,25 +34,51 @@ static unsigned int num_cio_dac;
 module_param_hw_array(base, uint, ioport, &num_cio_dac, 0);
 MODULE_PARM_DESC(base, "Measurement Computing CIO-DAC base addresses");
 
+#define CIO_DAC_BASE 0x00
+#define CIO_DAC_CHANNEL_STRIDE 2
+
+static bool cio_dac_precious_reg(struct device *dev, unsigned int reg)
+{
+	/*
+	 * All registers are considered precious; if the XFER jumper is set on
+	 * the device, then no update occurs until a DAC register is read.
+	 */
+	return true;
+}
+
+static const struct regmap_config cio_dac_regmap_config = {
+	.reg_bits = 16,
+	.reg_stride = 2,
+	.val_bits = 16,
+	.io_port = true,
+	.max_register = 0x1F,
+	.precious_reg = cio_dac_precious_reg,
+};
+
 /**
  * struct cio_dac_iio - IIO device private data structure
- * @chan_out_states:	channels' output states
- * @base:		base memory address of the DAC device
+ * @map: Regmap for the device
  */
 struct cio_dac_iio {
-	int chan_out_states[CIO_DAC_NUM_CHAN];
-	u16 __iomem *base;
+	struct regmap *map;
 };
 
 static int cio_dac_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
 	struct cio_dac_iio *const priv = iio_priv(indio_dev);
+	const unsigned int offset = chan->channel * CIO_DAC_CHANNEL_STRIDE;
+	int err;
+	unsigned int dac_val;
 
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
 
-	*val = priv->chan_out_states[chan->channel];
+	err = regmap_read(priv->map, CIO_DAC_BASE + offset, &dac_val);
+	if (err)
+		return err;
+
+	*val = dac_val;
 
 	return IIO_VAL_INT;
 }
@@ -62,6 +87,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int val, int val2, long mask)
 {
 	struct cio_dac_iio *const priv = iio_priv(indio_dev);
+	const unsigned int offset = chan->channel * CIO_DAC_CHANNEL_STRIDE;
 
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
@@ -70,10 +96,7 @@ static int cio_dac_write_raw(struct iio_dev *indio_dev,
 	if ((unsigned int)val > 65535)
 		return -EINVAL;
 
-	priv->chan_out_states[chan->channel] = val;
-	iowrite16(val, priv->base + chan->channel);
-
-	return 0;
+	return regmap_write(priv->map, CIO_DAC_BASE + offset, val);
 }
 
 static const struct iio_info cio_dac_info = {
@@ -92,7 +115,10 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
 	struct cio_dac_iio *priv;
+	void __iomem *regs;
 	unsigned int i;
+	unsigned int offset;
+	int err;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
@@ -105,11 +131,16 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 		return -EBUSY;
 	}
 
-	priv = iio_priv(indio_dev);
-	priv->base = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
-	if (!priv->base)
+	regs = devm_ioport_map(dev, base[id], CIO_DAC_EXTENT);
+	if (!regs)
 		return -ENOMEM;
 
+	priv = iio_priv(indio_dev);
+	priv->map = devm_regmap_init_mmio(dev, regs, &cio_dac_regmap_config);
+	if (IS_ERR(priv->map))
+		return dev_err_probe(dev, PTR_ERR(priv->map),
+				     "Unable to initialize register map\n");
+
 	indio_dev->info = &cio_dac_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = cio_dac_channels;
@@ -117,8 +148,12 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 	indio_dev->name = dev_name(dev);
 
 	/* initialize DAC outputs to 0V */
-	for (i = 0; i < CIO_DAC_NUM_CHAN; i++)
-		iowrite16(0, priv->base + i);
+	for (i = 0; i < CIO_DAC_NUM_CHAN; i++) {
+		offset = i * CIO_DAC_CHANNEL_STRIDE;
+		err = regmap_write(priv->map, CIO_DAC_BASE + offset, 0);
+		if (err)
+			return err;
+	}
 
 	return devm_iio_device_register(dev, indio_dev);
 }

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

