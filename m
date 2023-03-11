Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7976B5CA2
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 15:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCKOMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 09:12:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjCKOMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 09:12:18 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA1F12EACB
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:12:16 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id l13so8831889qtv.3
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 06:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678543936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xCOdnUIlYRCljoP0jvOuSQYBn7IV6NgBdnHZL4+pu3w=;
        b=LXMFDdhtuKA40vu2SEAhMVBhs8oZwu/drmX6hNyIt8+awHmKaZgNMzdNQXdMvp9FxT
         OU/4o6Rkh9Er1seWekbvMKWyHSfSq/NdKVoUvyF04ycTc+jooxe2jOXsifRswkv7x/Dt
         G3BgTHxoiSK9iBru9//uDq8MTXsTLD3UfekmH3lhzE9vvGqvDHKx8Z7P/Fh8sR+9zGFC
         FmFGDqEp80QQIrSAhOgeqRlRX4gFW13YB6JhPTZlGBLuK9PlEfYmMPvE+gGlcNDssPfc
         lVJeKWE9OEsk92oBnC+JVtUlDy0f4ArZafnvpY0fy5GV6+SBzXvwaH46u1VZ5fQowQL2
         RYDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678543936;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xCOdnUIlYRCljoP0jvOuSQYBn7IV6NgBdnHZL4+pu3w=;
        b=P/rZoXu8hrFTJqmKvgUdMxaEwstVygB9cvsabb4VeRfTMoh2jtzPVo93SB+KL8TRtx
         JSghv1x25HwQUxg9W3zbPs/1g4zjSteJP/NflR+5jxIOv1LijRdj1sAK+HZ+VvMmLy5F
         enOGfJXWrqNshaIXqTexL8ukV8rP4VSe/YhmfxOmg0l6M7FxmZFKul4ME/VI567JdgCq
         aJKIGwlkfXQ5euf2O0su3ozZ0lQSN2OxDhOB4TNGiUOgQBLVjifMpU/820AqIw9VaI1+
         bApbNf/tQrEPJUp25s721WxixkQTi3wC18JUxjip3qhy5m+M7Q+84oADsv8LSHjnN5ob
         j7fg==
X-Gm-Message-State: AO0yUKUtstHdPTzxZfrLqYPZNx81WOy2B2NrWDbpCQJcaFmXA7UJ5QJf
        YKtFieXcUWJ2MFeELjVOK5FL5w==
X-Google-Smtp-Source: AK7set//Oy9vO2UCidiKi98LPXBRGR+lR9kXA6z7ARs80qDWyasfS+VW4Fo6A/M7zVe7dcFVJlx8Ug==
X-Received: by 2002:ac8:7e83:0:b0:3b8:2e36:9d24 with SMTP id w3-20020ac87e83000000b003b82e369d24mr48358766qtj.50.1678543935958;
        Sat, 11 Mar 2023 06:12:15 -0800 (PST)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id q25-20020a37f719000000b0073ba92629e1sm1886615qkj.23.2023.03.11.06.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Mar 2023 06:12:15 -0800 (PST)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     jic23@kernel.org, lars@metafoo.de
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] iio: dac: cio-dac: Migrate to the regmap API
Date:   Sat, 11 Mar 2023 09:02:18 -0500
Message-Id: <20230311140218.74920-1-william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
Changes in v2:
 - Remove DAC initialization to 0V in cio_dio_probe() as superfluous now
   that the chan_out_states buffer is gone

 drivers/iio/dac/Kconfig   |  1 +
 drivers/iio/dac/cio-dac.c | 66 ++++++++++++++++++++++++++-------------
 2 files changed, 46 insertions(+), 21 deletions(-)

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
index 791dd999cf29..759833a6bd29 100644
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
@@ -92,7 +115,7 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
 {
 	struct iio_dev *indio_dev;
 	struct cio_dac_iio *priv;
-	unsigned int i;
+	void __iomem *regs;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
 	if (!indio_dev)
@@ -105,21 +128,22 @@ static int cio_dac_probe(struct device *dev, unsigned int id)
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
 	indio_dev->num_channels = CIO_DAC_NUM_CHAN;
 	indio_dev->name = dev_name(dev);
 
-	/* initialize DAC outputs to 0V */
-	for (i = 0; i < CIO_DAC_NUM_CHAN; i++)
-		iowrite16(0, priv->base + i);
-
 	return devm_iio_device_register(dev, indio_dev);
 }
 

base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
-- 
2.39.2

