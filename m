Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 712736ED7CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Apr 2023 00:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbjDXWXi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 18:23:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbjDXWX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 18:23:28 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8804E93E8;
        Mon, 24 Apr 2023 15:22:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-959a3e2dd27so309427866b.3;
        Mon, 24 Apr 2023 15:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682374975; x=1684966975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k8x37hSZAA/UyYHJr6MBXyC+9iGDHF5LYlDzRBMVftQ=;
        b=PjkysorumdCiXiUuH0mkobFqohkxt3GyKWsPcMwqVh0kv64MkfcT6Vs4sLk0LbHbNu
         FX1f979oJguiKSk1HWZrrHADerZim0qicZ/mjXFf4DmlBX+BrEfAQQ7Js7uNWVwlFH4g
         nREHqT6dpYshp02CNZjUHM83qosrIrrBEy3g/VDhtVn6lvJdVR+Id/JMttqswKvjJgc+
         MNHR4aVc5WritVDtswK1M1pr9gdbsd1uAqqeIPqPIjgJNTRj26Nh2N4ipVx9VriXk6z8
         GPqQUdHPf4BQcQ50wOh0cmhCAXcOMNS9zS33YFyRBTk41f2Haff+MHoO9BfwM++4chQ8
         64RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682374975; x=1684966975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k8x37hSZAA/UyYHJr6MBXyC+9iGDHF5LYlDzRBMVftQ=;
        b=iaXcjrEOBi3YBimeLrXKBw71mR12nhT++j+H39+j7gB+vEQ7/x4egi5yDyUpoWo1PM
         IVwiBuWbg8taF3mxs9uyiwCB6nqmZQ9RXiR4uYli1YUzfK5rZvxhHPwRVU7wfjD/OWHL
         waRUnVaVZL6rTQyz4oniuBWziX6b/BnS8F3QAeGy0juFflQdu2VIDZNcIWVOK0ts8Lor
         jvThLksE1LKdHEXCJDMstlXq5jQsmBtw4obxq6X3hhMnGubL0ItzGL7I9fLundVd9+AX
         cPr9iGPSTnhWfR242+VE66R8uRMIOjw7Zwwc887BaQiuT0BcKuRsgKYT6by7uW8Yl1ac
         jNrQ==
X-Gm-Message-State: AAQBX9c4yjKB55ZqCGxOjQKzlUR1L0gRyrfTLwNOmRM2hdlYeTP+lv78
        k5C8H00bvAFbg6r612C9f94=
X-Google-Smtp-Source: AKy350ZDcvdn46uywgAgMo+fr3R9HkcdCtaXDXFD0SA1r83KhBqEDR+sae5d+HhoLhIWNVXBGWPrmQ==
X-Received: by 2002:a17:907:c30b:b0:93d:ae74:fa9e with SMTP id tl11-20020a170907c30b00b0093dae74fa9emr10796054ejc.7.1682374975420;
        Mon, 24 Apr 2023 15:22:55 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8109:aa3f:ead8::2fd0])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906539500b0094efdfe60dcsm5870886ejo.206.2023.04.24.15.22.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 15:22:55 -0700 (PDT)
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     jic23@kernel.org, mazziesaccount@gmail.com
Cc:     krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, robh+dt@kernel.org,
        lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Mehdi Djait <mehdi.djait.k@gmail.com>
Subject: [PATCH v3 7/7] iio: accel: Add support for Kionix/ROHM KX132-1211 accelerometer
Date:   Tue, 25 Apr 2023 00:22:27 +0200
Message-Id: <593798a44c8ba45f969b86aa29e172d59065958c.1682373451.git.mehdi.djait.k@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1682373451.git.mehdi.djait.k@gmail.com>
References: <cover.1682373451.git.mehdi.djait.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Kionix KX132-1211 is a tri-axis 16-bit accelerometer that can support
ranges from ±2G to ±16G, digital output through I²C/SPI.
Add support for basic accelerometer features such as reading acceleration
via IIO using raw reads, triggered buffer (data-ready), or the WMI IRQ.

Datasheet: https://kionixfs.azureedge.net/en/document/KX132-1211-Technical-Reference-Manual-Rev-5.0.pdf
Signed-off-by: Mehdi Djait <mehdi.djait.k@gmail.com>
---
 drivers/iio/accel/Kconfig             |   8 +-
 drivers/iio/accel/kionix-kx022a-i2c.c |   2 +
 drivers/iio/accel/kionix-kx022a-spi.c |   2 +
 drivers/iio/accel/kionix-kx022a.c     | 147 ++++++++++++++++++++++++++
 drivers/iio/accel/kionix-kx022a.h     |  52 +++++++++
 5 files changed, 207 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/accel/Kconfig b/drivers/iio/accel/Kconfig
index b6b45d359f28..d8cc6e6f2bb9 100644
--- a/drivers/iio/accel/Kconfig
+++ b/drivers/iio/accel/Kconfig
@@ -418,8 +418,8 @@ config IIO_KX022A_SPI
 	select IIO_KX022A
 	select REGMAP_SPI
 	help
-	  Enable support for the Kionix KX022A digital tri-axis
-	  accelerometer connected to I2C interface.
+	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
+	  accelerometers connected to SPI interface.
 
 config IIO_KX022A_I2C
 	tristate "Kionix KX022A tri-axis digital accelerometer I2C interface"
@@ -427,8 +427,8 @@ config IIO_KX022A_I2C
 	select IIO_KX022A
 	select REGMAP_I2C
 	help
-	  Enable support for the Kionix KX022A digital tri-axis
-	  accelerometer connected to I2C interface.
+	  Enable support for the Kionix KX022A, KX132-1211 digital tri-axis
+	  accelerometers connected to I2C interface.
 
 config KXSD9
 	tristate "Kionix KXSD9 Accelerometer Driver"
diff --git a/drivers/iio/accel/kionix-kx022a-i2c.c b/drivers/iio/accel/kionix-kx022a-i2c.c
index ce299d0446f7..4ea28d2482ec 100644
--- a/drivers/iio/accel/kionix-kx022a-i2c.c
+++ b/drivers/iio/accel/kionix-kx022a-i2c.c
@@ -39,12 +39,14 @@ static int kx022a_i2c_probe(struct i2c_client *i2c)
 
 static const struct i2c_device_id kx022a_i2c_id[] = {
 	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
+	{ .name = "kx132-1211", .driver_data = (kernel_ulong_t)&kx132_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, kx022a_i2c_id);
 
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
+	{ .compatible = "kionix,kx132-1211", .data = &kx132_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a-spi.c b/drivers/iio/accel/kionix-kx022a-spi.c
index b84503e24510..b755b2b395ed 100644
--- a/drivers/iio/accel/kionix-kx022a-spi.c
+++ b/drivers/iio/accel/kionix-kx022a-spi.c
@@ -39,12 +39,14 @@ static int kx022a_spi_probe(struct spi_device *spi)
 
 static const struct spi_device_id kx022a_id[] = {
 	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx022a_chip_info },
+	{ .name = "kx132-1211", .driver_data = (kernel_ulong_t)&kx132_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, kx022a_id);
 
 static const struct of_device_id kx022a_of_match[] = {
 	{ .compatible = "kionix,kx022a", .data = &kx022a_chip_info },
+	{ .compatible = "kionix,kx132-1211", .data = &kx132_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, kx022a_of_match);
diff --git a/drivers/iio/accel/kionix-kx022a.c b/drivers/iio/accel/kionix-kx022a.c
index 4a31d17c1f22..a6808ab12162 100644
--- a/drivers/iio/accel/kionix-kx022a.c
+++ b/drivers/iio/accel/kionix-kx022a.c
@@ -150,6 +150,101 @@ static const struct regmap_config kx022a_regmap_config = {
 	.cache_type = REGCACHE_RBTREE,
 };
 
+/* Regmap configs kx132 */
+static const struct regmap_range kx132_volatile_ranges[] = {
+	{
+		.range_min = KX132_REG_XADP_L,
+		.range_max = KX132_REG_COTR,
+	}, {
+		.range_min = KX132_REG_TSCP,
+		.range_max = KX132_REG_INT_REL,
+	}, {
+		/* The reset bit will be cleared by sensor */
+		.range_min = KX132_REG_CNTL2,
+		.range_max = KX132_REG_CNTL2,
+	}, {
+		.range_min = KX132_REG_BUF_STATUS_1,
+		.range_max = KX132_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx132_volatile_regs = {
+	.yes_ranges = &kx132_volatile_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_volatile_ranges),
+};
+
+static const struct regmap_range kx132_precious_ranges[] = {
+	{
+		.range_min = KX132_REG_INT_REL,
+		.range_max = KX132_REG_INT_REL,
+	},
+};
+
+static const struct regmap_access_table kx132_precious_regs = {
+	.yes_ranges = &kx132_precious_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_precious_ranges),
+};
+
+static const struct regmap_range kx132_read_only_ranges[] = {
+	{
+		.range_min = KX132_REG_XADP_L,
+		.range_max = KX132_REG_INT_REL,
+	}, {
+		.range_min = KX132_REG_BUF_STATUS_1,
+		.range_max = KX132_REG_BUF_STATUS_2,
+	}, {
+		.range_min = KX132_REG_BUF_READ,
+		.range_max = KX132_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx132_ro_regs = {
+	.no_ranges = &kx132_read_only_ranges[0],
+	.n_no_ranges = ARRAY_SIZE(kx132_read_only_ranges),
+};
+
+static const struct regmap_range kx132_write_only_ranges[] = {
+	{
+		.range_min = KX132_REG_MAN_WAKE,
+		.range_max = KX132_REG_MAN_WAKE,
+	}, {
+		.range_min = KX132_REG_SELF_TEST,
+		.range_max = KX132_REG_SELF_TEST,
+	}, {
+		.range_min = KX132_REG_BUF_CLEAR,
+		.range_max = KX132_REG_BUF_CLEAR,
+	},
+};
+
+static const struct regmap_access_table kx132_wo_regs = {
+	.no_ranges = &kx132_write_only_ranges[0],
+	.n_no_ranges = ARRAY_SIZE(kx132_write_only_ranges),
+};
+
+static const struct regmap_range kx132_noinc_read_ranges[] = {
+	{
+		.range_min = KX132_REG_BUF_READ,
+		.range_max = KX132_REG_BUF_READ,
+	},
+};
+
+static const struct regmap_access_table kx132_nir_regs = {
+	.yes_ranges = &kx132_noinc_read_ranges[0],
+	.n_yes_ranges = ARRAY_SIZE(kx132_noinc_read_ranges),
+};
+
+static const struct regmap_config kx132_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_table = &kx132_volatile_regs,
+	.rd_table = &kx132_wo_regs,
+	.wr_table = &kx132_ro_regs,
+	.rd_noinc_table = &kx132_nir_regs,
+	.precious_table = &kx132_precious_regs,
+	.max_register = KX132_MAX_REGISTER,
+	.cache_type = REGCACHE_RBTREE,
+};
+
 struct kx022a_data {
 	const struct kx022a_chip_info *chip_info;
 	struct regmap *regmap;
@@ -237,6 +332,13 @@ static const struct iio_chan_spec kx022a_channels[] = {
 	IIO_CHAN_SOFT_TIMESTAMP(3),
 };
 
+static const struct iio_chan_spec kx132_channels[] = {
+	KX022A_ACCEL_CHAN(X, KX132_REG_XOUT_L, 0),
+	KX022A_ACCEL_CHAN(Y, KX132_REG_YOUT_L, 1),
+	KX022A_ACCEL_CHAN(Z, KX132_REG_ZOUT_L, 2),
+	IIO_CHAN_SOFT_TIMESTAMP(3),
+};
+
 /*
  * The sensor HW can support ODR up to 1600 Hz, which is beyond what most of the
  * Linux CPUs can handle without dropping samples. Also, the low power mode is
@@ -613,6 +715,25 @@ static int kx022a_get_fifo_bytes(struct kx022a_data *data)
 	return fifo_bytes;
 }
 
+static int kx132_get_fifo_bytes(struct kx022a_data *data)
+{
+	struct device *dev = regmap_get_device(data->regmap);
+	__le16 buf_status;
+	int ret, fifo_bytes;
+
+	ret = regmap_bulk_read(data->regmap, data->chip_info->buf_status1,
+			       &buf_status, sizeof(buf_status));
+	if (ret) {
+		dev_err(dev, "Error reading buffer status\n");
+		return ret;
+	}
+
+	fifo_bytes = le16_to_cpu(buf_status);
+	fifo_bytes &= data->chip_info->buf_smp_lvl_mask;
+
+	return fifo_bytes;
+}
+
 static int __kx022a_fifo_flush(struct iio_dev *idev, unsigned int samples,
 			       bool irq)
 {
@@ -1036,6 +1157,32 @@ const struct kx022a_chip_info kx022a_chip_info = {
 };
 EXPORT_SYMBOL_NS_GPL(kx022a_chip_info, IIO_KX022A);
 
+const struct kx022a_chip_info kx132_chip_info = {
+	.name		  = "kx132-1211",
+	.regmap_config	  = &kx132_regmap_config,
+	.channels	  = kx132_channels,
+	.num_channels	  = ARRAY_SIZE(kx132_channels),
+	.fifo_length	  = KX132_FIFO_LENGTH,
+	.who		  = KX132_REG_WHO,
+	.id		  = KX132_ID,
+	.cntl		  = KX132_REG_CNTL,
+	.cntl2		  = KX132_REG_CNTL2,
+	.odcntl		  = KX132_REG_ODCNTL,
+	.buf_cntl1	  = KX132_REG_BUF_CNTL1,
+	.buf_cntl2	  = KX132_REG_BUF_CNTL2,
+	.buf_clear	  = KX132_REG_BUF_CLEAR,
+	.buf_status1	  = KX132_REG_BUF_STATUS_1,
+	.buf_smp_lvl_mask = KX132_MASK_BUF_SMP_LVL,
+	.buf_read	  = KX132_REG_BUF_READ,
+	.inc1		  = KX132_REG_INC1,
+	.inc4		  = KX132_REG_INC4,
+	.inc5		  = KX132_REG_INC5,
+	.inc6		  = KX132_REG_INC6,
+	.xout_l		  = KX132_REG_XOUT_L,
+	.get_fifo_bytes	  = kx132_get_fifo_bytes,
+};
+EXPORT_SYMBOL_NS_GPL(kx132_chip_info, IIO_KX022A);
+
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info)
 {
 	static const char * const regulator_names[] = {"io-vdd", "vdd"};
diff --git a/drivers/iio/accel/kionix-kx022a.h b/drivers/iio/accel/kionix-kx022a.h
index f043767067b7..1f4135cf20eb 100644
--- a/drivers/iio/accel/kionix-kx022a.h
+++ b/drivers/iio/accel/kionix-kx022a.h
@@ -74,6 +74,57 @@
 #define KX022A_REG_SELF_TEST	0x60
 #define KX022A_MAX_REGISTER	0x60
 
+#define KX132_REG_WHO		0x13
+#define KX132_ID		0x3d
+
+#define KX132_FIFO_LENGTH	86
+
+#define KX132_REG_CNTL		0x1b
+#define KX132_REG_CNTL2		0x1c
+#define KX132_MASK_RES		BIT(6)
+#define KX132_GSEL_2		0x0
+#define KX132_GSEL_4		BIT(3)
+#define KX132_GSEL_8		BIT(4)
+#define KX132_GSEL_16		GENMASK(4, 3)
+
+#define KX132_REG_INS2		0x17
+#define KX132_MASK_INS2_WMI	BIT(5)
+
+#define KX132_REG_XADP_L	0x02
+#define KX132_REG_XOUT_L	0x08
+#define KX132_REG_YOUT_L	0x0a
+#define KX132_REG_ZOUT_L	0x0c
+#define KX132_REG_COTR		0x12
+#define KX132_REG_TSCP		0x14
+#define KX132_REG_INT_REL	0x1a
+
+#define KX132_REG_ODCNTL	0x21
+
+#define KX132_REG_BTS_WUF_TH	0x4a
+#define KX132_REG_MAN_WAKE	0x4d
+
+#define KX132_REG_BUF_CNTL1	0x5e
+#define KX132_REG_BUF_CNTL2	0x5f
+#define KX132_REG_BUF_STATUS_1	0x60
+#define KX132_REG_BUF_STATUS_2	0x61
+#define KX132_MASK_BUF_SMP_LVL	GENMASK(9, 0)
+#define KX132_REG_BUF_CLEAR	0x62
+#define KX132_REG_BUF_READ	0x63
+#define KX132_ODR_SHIFT		3
+#define KX132_FIFO_MAX_WMI_TH	86
+
+#define KX132_REG_INC1		0x22
+#define KX132_REG_INC5		0x26
+#define KX132_REG_INC6		0x27
+#define KX132_IPOL_LOW		0
+#define KX132_IPOL_HIGH		KX022A_MASK_IPOL
+#define KX132_ITYP_PULSE	KX022A_MASK_ITYP
+
+#define KX132_REG_INC4		0x25
+
+#define KX132_REG_SELF_TEST	0x5d
+#define KX132_MAX_REGISTER	0x76
+
 struct device;
 
 struct kx022a_data;
@@ -132,5 +183,6 @@ struct kx022a_chip_info {
 int kx022a_probe_internal(struct device *dev, const struct kx022a_chip_info *chip_info);
 
 extern const struct kx022a_chip_info kx022a_chip_info;
+extern const struct kx022a_chip_info kx132_chip_info;
 
 #endif
-- 
2.30.2

