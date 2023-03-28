Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C3F6CBB6C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 11:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232851AbjC1Jol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 05:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjC1JoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 05:44:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 945E95FCB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:44:20 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id d11-20020a05600c3acb00b003ef6e6754c5so3530161wms.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 02:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google; t=1679996659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=os0uDoAihK463Kxke7kC6hpuq3Q8sz+Qzd9rJytLYis=;
        b=Un4Bg3/38pp5xM40D+62vjDtK/TNHfyDEdz7+gr+AJO7OYetwOGUmecbMfc+WGiWh1
         4qc7VQ3iekAUy6LNYunRqGnLSvG49PGnl3uUC1DnAgEvSNIm2vyrHAlSY+8n8IaFRVDY
         m5zL2Uo5ru7Jy6mdj41sKHPwWEFNYGiSoPAv3cr3nSrOTDreFHVVo7WwqeanrMPpiyst
         dOHeHsD6380TeD6XzRKEQ8vT57OBnzv6/cZkBW9sfjZKzIGjEazSb1xaRWbXRosrusvV
         BWDR0epDHX6IfiCDlhQThftpdXeYzqhZly4K04e6ykWu8ytdyUpqYoKDkJKUNye/j6qn
         fRnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679996659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=os0uDoAihK463Kxke7kC6hpuq3Q8sz+Qzd9rJytLYis=;
        b=LP2oImEqGncB/fCcjgws/Q1B6Qz0iPA23uLPPTJS8GCMyREa9EPMSyxFwhi66Wpvv+
         +rUooCqHhenU3lDTiRoIbUzMRBW2EUP9oBJdcfK0aAVFb9A2PHcwgiUz6xgaLzxkOz7+
         D2K+QR3Fl2UaYfepBF/hy7WEyaslCFddeRriosGQLgz5e2R1VSKKvQAAMUNftLyPf5AB
         HrApNy/cwsNG0ZbxMbQzBkt1uDSzXexWdA/Us2U98qPZ0GPXAwxRNBnyayTsWrHXkSSZ
         UaY+qMyGtSbOgoLFcI0cfI63wt5vCUbez1y3NkB9N3h0+hK3JwHgjSznW9WNvKwTiZKe
         FvFg==
X-Gm-Message-State: AO0yUKVcFUDNEh5hMUrs4qMo2Ot5A67hjsVXf7e8/wFMF15RwvjyafOb
        gIjHydXu22anf/eFMO/wbux9Hg==
X-Google-Smtp-Source: AK7set/QEicgtU2DVi3nFca023KDoBzlIwLp0zstcLrjL3bkmzKrgmRe679qUND/WGL9EN+wi7D5kQ==
X-Received: by 2002:a1c:cc19:0:b0:3ed:4b9b:f0a1 with SMTP id h25-20020a1ccc19000000b003ed4b9bf0a1mr11622223wmb.27.1679996659085;
        Tue, 28 Mar 2023 02:44:19 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f6-20020a05600c154600b003ef7058ea02sm5387953wmg.29.2023.03.28.02.44.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 02:44:18 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: [PATCH v3 1/2] iio: max597x: Add support for max597x
Date:   Tue, 28 Mar 2023 11:44:14 +0200
Message-Id: <20230328094416.3851801-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.39.1
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

From: Patrick Rudolph <patrick.rudolph@9elements.com>

max5970 & max5978 has 10bit ADC for voltage & current
monitoring.
Use iio framework to expose the same in sysfs.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
...
Changes in V3:
- Use bulk read
- Remove line split
Changes in V2:
- Remove fallthrough
- Use pdev->dev instead of i2c->dev
- Init indio_dev->name based on device type.
---
 drivers/iio/adc/Kconfig       |  15 ++++
 drivers/iio/adc/Makefile      |   1 +
 drivers/iio/adc/max597x-iio.c | 148 ++++++++++++++++++++++++++++++++++
 3 files changed, 164 insertions(+)
 create mode 100644 drivers/iio/adc/max597x-iio.c

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 45af2302be53..69310af5c665 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -735,6 +735,21 @@ config MAX1363
 	  To compile this driver as a module, choose M here: the module will be
 	  called max1363.
 
+config MAX597X_IIO
+	tristate "Maxim 597x power switch and monitor"
+	depends on I2C && OF
+	select MFD_MAX597X
+	help
+	  This driver enables support for the Maxim 5970 & 5978 smart switch
+	  and voltage/current monitoring interface using the Industrial I/O
+	  (IIO) framework. The Maxim 597x is a power switch and monitor that can
+	  provide voltage and current measurements via the I2C bus. Enabling
+	  this driver will allow user space applications to read the voltage
+	  and current measurements using IIO interfaces.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max597x-iio.
+
 config MAX9611
 	tristate "Maxim max9611/max9612 ADC driver"
 	depends on I2C
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 36c18177322a..7ec0c2cf7bbb 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
+obj-$(CONFIG_MAX597X_IIO) += max597x-iio.o
 obj-$(CONFIG_MAX9611) += max9611.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
diff --git a/drivers/iio/adc/max597x-iio.c b/drivers/iio/adc/max597x-iio.c
new file mode 100644
index 000000000000..f158e49b5a56
--- /dev/null
+++ b/drivers/iio/adc/max597x-iio.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for IIO in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/iio/iio.h>
+#include <linux/mfd/max597x.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+struct max597x_iio {
+	struct regmap *regmap;
+	int shunt_micro_ohms[MAX5970_NUM_SWITCHES];
+	unsigned int irng[MAX5970_NUM_SWITCHES];
+	unsigned int mon_rng[MAX5970_NUM_SWITCHES];
+};
+
+#define MAX597X_ADC_CHANNEL(_idx, _type) {			\
+	.type = IIO_ ## _type,					\
+	.indexed = 1,						\
+	.channel = (_idx),					\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
+			      BIT(IIO_CHAN_INFO_SCALE),		\
+	.address = MAX5970_REG_ ## _type ## _L(_idx),		\
+}
+
+static const struct iio_chan_spec max5978_adc_iio_channels[] = {
+	MAX597X_ADC_CHANNEL(0, VOLTAGE),
+	MAX597X_ADC_CHANNEL(0, CURRENT),
+};
+
+static const struct iio_chan_spec max5970_adc_iio_channels[] = {
+	MAX597X_ADC_CHANNEL(0, VOLTAGE),
+	MAX597X_ADC_CHANNEL(0, CURRENT),
+	MAX597X_ADC_CHANNEL(1, VOLTAGE),
+	MAX597X_ADC_CHANNEL(1, CURRENT),
+};
+
+static int max597x_iio_read_raw(struct iio_dev *iio_dev,
+				struct iio_chan_spec const *chan,
+				int *val, int *val2, long info)
+{
+	int ret;
+	struct max597x_iio *data = iio_priv(iio_dev);
+	u16 reg_l, reg_h;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_bulk_read(data->regmap, chan->address - 1, &reg_l, 2);
+		if (ret < 0)
+			return ret;
+		reg_h = reg_l & 0xff;
+		reg_l = (reg_l >> 8) & 0xff;
+		*val = (reg_h << 2) | (reg_l & 3);
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		switch (chan->address) {
+		case MAX5970_REG_CURRENT_L(0):
+		case MAX5970_REG_CURRENT_L(1):
+			/* in A, convert to mA */
+			*val = data->irng[chan->channel] * 1000;
+			*val2 = data->shunt_micro_ohms[chan->channel] * ADC_MASK;
+			return IIO_VAL_FRACTIONAL;
+
+		case MAX5970_REG_VOLTAGE_L(0):
+		case MAX5970_REG_VOLTAGE_L(1):
+			/* in uV, convert to mV */
+			*val = data->mon_rng[chan->channel];
+			*val2 = ADC_MASK * 1000;
+			return IIO_VAL_FRACTIONAL;
+		}
+
+		break;
+	}
+	return -EINVAL;
+}
+
+static const struct iio_info max597x_adc_iio_info = {
+	.read_raw = &max597x_iio_read_raw,
+};
+
+static int max597x_iio_probe(struct platform_device *pdev)
+{
+	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
+	struct regmap *regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	struct iio_dev *indio_dev;
+	struct max597x_iio *priv;
+	int ret, i;
+
+	if (!regmap)
+		return -EPROBE_DEFER;
+
+	if (!max597x || !max597x->num_switches)
+		return -EPROBE_DEFER;
+
+	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*priv));
+	if (!indio_dev)
+		return dev_err_probe(&pdev->dev, -ENOMEM,
+				     "failed to allocate iio device\n");
+
+	indio_dev->info = &max597x_adc_iio_info;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	switch (max597x->num_switches) {
+	case MAX597x_TYPE_MAX5970:
+		indio_dev->channels = max5970_adc_iio_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max5970_adc_iio_channels);
+		indio_dev->name = "max5970";
+		break;
+	case MAX597x_TYPE_MAX5978:
+		indio_dev->channels = max5978_adc_iio_channels;
+		indio_dev->num_channels = ARRAY_SIZE(max5978_adc_iio_channels);
+		indio_dev->name = "max5978";
+		break;
+	}
+
+	priv = iio_priv(indio_dev);
+	priv->regmap = regmap;
+	for (i = 0; i < indio_dev->num_channels; i++) {
+		priv->irng[i] = max597x->irng[i];
+		priv->mon_rng[i] = max597x->mon_rng[i];
+		priv->shunt_micro_ohms[i] = max597x->shunt_micro_ohms[i];
+	}
+
+	ret = devm_iio_device_register(&pdev->dev, indio_dev);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "could not register iio device\n");
+
+	return 0;
+}
+
+static struct platform_driver max597x_iio_driver = {
+	.driver = {
+		.name = "max597x-iio",
+	},
+	.probe = max597x_iio_probe,
+};
+
+module_platform_driver(max597x_iio_driver);
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
+MODULE_LICENSE("GPL");

base-commit: 368eb79f738a21e16c2bdbcac2444dfa96b01aaa
-- 
2.39.1

