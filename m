Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A47F96E3AB2
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 19:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjDPRhc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 13:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjDPRhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 13:37:21 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B4F30C7
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:37:16 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 22-20020a9d0116000000b006a5dcfee7d7so1000296otu.2
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 10:37:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681666635; x=1684258635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FYx0k5ihhJlPtRpOo4XGHOU5FikMHitAj1rgNIt8olI=;
        b=iJhar42nZCrIRo6hBBOzAXGE/XF9O0Jp6LT+eXOaVDiIO5i/yATOcjPIAHJtvdJ2Rc
         0flialZCD7rELafUN208dVRAsB48TeALBtAcqVlpfZD0mcM7AUWtzDqm5vchixm355ry
         SZN7c0zOA9AqLgOk+Ag6hoQXvv9UhJgnl5MAhUgaezn3tNDTOK+KBRrTdYb+Riu5c4uF
         09T3u/xfKj1C4WfTmIrkICPhIKXRHe+UQHz58sVBsX1Oo9kySjWkZ/32KewjyROxZT1I
         oEvtgOlBtdCoKQrJt8ruiAPAKg1agDb8JXaTiTLZ4/rpdGZtYBeaeqkD8G5QSlpxdPG9
         4MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681666635; x=1684258635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FYx0k5ihhJlPtRpOo4XGHOU5FikMHitAj1rgNIt8olI=;
        b=TAiQ+P7Mufi0zu3snd8h/5waZXuEpqafuBczAO91oI/UuPnOTp6MlLShb7W0G3j9i/
         8vt15pMJn8uXSlYnXFawejvN+iOsuTbqSbpKSAPj1bzDrUiYbUkiRPBs3Dh9YChAKGyC
         bMLhYE3QSpPf49pRlc35Tpwfc7JjBy6Fdw9xYdEEGC1zSONPwIbVt/yOLXRl12KzRX77
         otntRFh/FJSeQi5xCoPmqqXEG70SpWP/AqNQz2rprtdmE94MQFc3aBzLo/wD/Kv9q2GF
         Wk6fnDRRs2Gm17zoYoSND9O6fXWyCGK/8xq+SvO+sFpHUJ4WQndfE+HVz1AfTbSj24VS
         xgag==
X-Gm-Message-State: AAQBX9enn1lRBSReUD/UAoDPpR0DPIYFhr5OHKb4SDaepVMNAcozxbp/
        OqKTkw76JqBqc2yw3/s2EXw5JBbUrDzlxZSE5/1CIA==
X-Google-Smtp-Source: AKy350a7UU1lbYnc9sEjdYX046H6Scr3HtpydUxLMudV1BMQbviJTEylyNcUf9a9pGCGVi4RdY1beQ==
X-Received: by 2002:a05:6830:1614:b0:6a4:25d5:83f8 with SMTP id g20-20020a056830161400b006a425d583f8mr5467237otr.20.1681666635775;
        Sun, 16 Apr 2023 10:37:15 -0700 (PDT)
Received: from fedora.attlocal.net (69-109-179-158.lightspeed.dybhfl.sbcglobal.net. [69.109.179.158])
        by smtp.gmail.com with ESMTPSA id v16-20020a05683011d000b0069457b86060sm3771038otq.47.2023.04.16.10.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Apr 2023 10:37:15 -0700 (PDT)
From:   William Breathitt Gray <william.gray@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        William Breathitt Gray <william.gray@linaro.org>
Subject: [PATCH 3/3] iio: addac: stx104: Add 8254 Counter/Timer support
Date:   Sun, 16 Apr 2023 13:36:55 -0400
Message-Id: <45d35b6f6e8d51df788b2bc85c456bfd45476b1a.1681665189.git.william.gray@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1681665189.git.william.gray@linaro.org>
References: <cover.1681665189.git.william.gray@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The STX104 features an 8254 Counter/Timer chip providing three
counter/timers which can be used for frequency measurement, frequency
output, pulse width modulation, pulse width measurement, event count,
etc. The STX104 provides a register bank selection to bank select
between the 8254 Bank and the Indexed Register Array Bank; the Indexed
Register Array is not utilized by this driver, so the 8254 Bank is
selected unconditionally.

Signed-off-by: William Breathitt Gray <william.gray@linaro.org>
---
 drivers/iio/addac/Kconfig  |  1 +
 drivers/iio/addac/stx104.c | 61 ++++++++++++++++++++++++++++++++++++--
 2 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/addac/Kconfig b/drivers/iio/addac/Kconfig
index 877f9124803c..b2623881f0ec 100644
--- a/drivers/iio/addac/Kconfig
+++ b/drivers/iio/addac/Kconfig
@@ -38,6 +38,7 @@ config STX104
 	select REGMAP_MMIO
 	select GPIOLIB
 	select GPIO_REGMAP
+	select I8254
 	help
 	  Say yes here to build support for the Apex Embedded Systems STX104
 	  integrated analog PC/104 card.
diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index d1f7ce033b46..6946a65512ca 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -8,6 +8,7 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/regmap.h>
+#include <linux/i8254.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/types.h>
 #include <linux/isa.h>
@@ -55,6 +56,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 #define STX104_ADC_STATUS (STX104_AIO_BASE + 0x8)
 #define STX104_ADC_CONTROL (STX104_AIO_BASE + 0x9)
 #define STX104_ADC_CONFIGURATION (STX104_AIO_BASE + 0x11)
+#define STX104_I8254_BASE (STX104_AIO_BASE + 0x12)
 
 #define STX104_AIO_DATA_STRIDE 2
 #define STX104_DAC_OFFSET(_channel) (STX104_DAC_BASE + STX104_AIO_DATA_STRIDE * (_channel))
@@ -77,6 +79,7 @@ MODULE_PARM_DESC(base, "Apex Embedded Systems STX104 base addresses");
 /* ADC Configuration */
 #define STX104_GAIN GENMASK(1, 0)
 #define STX104_ADBU BIT(2)
+#define STX104_RBK GENMASK(7, 4)
 #define STX104_BIPOLAR 0
 #define STX104_GAIN_X1 0
 #define STX104_GAIN_X2 1
@@ -168,6 +171,32 @@ static const struct regmap_config dio_regmap_config = {
 	.io_port = true,
 };
 
+static const struct regmap_range pit_wr_ranges[] = {
+	regmap_reg_range(0x0, 0x3),
+};
+static const struct regmap_range pit_rd_ranges[] = {
+	regmap_reg_range(0x0, 0x2),
+};
+static const struct regmap_access_table pit_wr_table = {
+	.yes_ranges = pit_wr_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pit_wr_ranges),
+};
+static const struct regmap_access_table pit_rd_table = {
+	.yes_ranges = pit_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(pit_rd_ranges),
+};
+
+static const struct regmap_config pit_regmap_config = {
+	.name = "i8254",
+	.reg_bits = 8,
+	.reg_stride = 1,
+	.reg_base = STX104_I8254_BASE,
+	.val_bits = 8,
+	.io_port = true,
+	.wr_table = &pit_wr_table,
+	.rd_table = &pit_rd_table,
+};
+
 static int stx104_read_raw(struct iio_dev *indio_dev,
 	struct iio_chan_spec const *chan, int *val, int *val2, long mask)
 {
@@ -339,6 +368,21 @@ static const char *stx104_names[STX104_NGPIO] = {
 	"DIN0", "DIN1", "DIN2", "DIN3", "DOUT0", "DOUT1", "DOUT2", "DOUT3"
 };
 
+static int bank_select_i8254(struct regmap *map)
+{
+	const u8 select_i8254[] = { 0x3, 0xB, 0xA };
+	size_t i;
+	int err;
+
+	for (i = 0; i < ARRAY_SIZE(select_i8254); i++) {
+		err = regmap_write_bits(map, STX104_ADC_CONFIGURATION, STX104_RBK, select_i8254[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int stx104_init_hw(struct stx104_iio *const priv)
 {
 	int err;
@@ -361,7 +405,7 @@ static int stx104_init_hw(struct stx104_iio *const priv)
 	if (err)
 		return err;
 
-	return 0;
+	return bank_select_i8254(priv->aio_ctl_map);
 }
 
 static int stx104_probe(struct device *dev, unsigned int id)
@@ -369,6 +413,7 @@ static int stx104_probe(struct device *dev, unsigned int id)
 	struct iio_dev *indio_dev;
 	struct stx104_iio *priv;
 	struct gpio_regmap_config gpio_config;
+	struct i8254_regmap_config pit_config;
 	void __iomem *stx104_base;
 	struct regmap *aio_ctl_map;
 	struct regmap *aio_data_map;
@@ -406,6 +451,11 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		return dev_err_probe(dev, PTR_ERR(dio_map),
 				     "Unable to initialize dio register map\n");
 
+	pit_config.map = devm_regmap_init_mmio(dev, stx104_base, &pit_regmap_config);
+	if (IS_ERR(pit_config.map))
+		return dev_err_probe(dev, PTR_ERR(pit_config.map),
+				     "Unable to initialize i8254 register map\n");
+
 	priv = iio_priv(indio_dev);
 	priv->aio_ctl_map = aio_ctl_map;
 	priv->aio_data_map = aio_data_map;
@@ -449,7 +499,13 @@ static int stx104_probe(struct device *dev, unsigned int id)
 		.drvdata = dio_map,
 	};
 
-	return PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+	err = PTR_ERR_OR_ZERO(devm_gpio_regmap_register(dev, &gpio_config));
+	if (err)
+		return err;
+
+	pit_config.parent = dev;
+
+	return devm_i8254_regmap_register(dev, &pit_config);
 }
 
 static struct isa_driver stx104_driver = {
@@ -464,3 +520,4 @@ module_isa_driver(stx104_driver, num_stx104);
 MODULE_AUTHOR("William Breathitt Gray <vilhelm.gray@gmail.com>");
 MODULE_DESCRIPTION("Apex Embedded Systems STX104 IIO driver");
 MODULE_LICENSE("GPL v2");
+MODULE_IMPORT_NS(I8254);
-- 
2.39.2

