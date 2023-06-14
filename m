Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A828172DDD2
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 11:35:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238951AbjFMJfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 05:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240985AbjFMJej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 05:34:39 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F231C10E4;
        Tue, 13 Jun 2023 02:34:36 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35D8IEWL031522;
        Tue, 13 Jun 2023 05:34:22 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3r4k168qwd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 05:34:22 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 35D9YLLl010518
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 13 Jun 2023 05:34:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 Jun 2023 05:34:20 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 13 Jun 2023 05:34:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 13 Jun 2023 05:34:19 -0400
Received: from kimedia-VirtualBox.ad.analog.com (KPALLER2-L02.ad.analog.com [10.116.242.24])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 35D9XuF7020837;
        Tue, 13 Jun 2023 05:34:07 -0400
From:   Kim Seer Paller <kimseer.paller@analog.com>
CC:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <Michael.Hennerich@analog.com>,
        <andy.shevchenko@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <robh@kernel.org>, <kimseer.paller@analog.com>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v5 2/2] iio: adc: max14001: New driver
Date:   Tue, 13 Jun 2023 17:33:46 +0800
Message-ID: <20230613093346.60781-2-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613093346.60781-1-kimseer.paller@analog.com>
References: <20230613093346.60781-1-kimseer.paller@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: DiiDgGr63HC290zE0ZQQi2cpvlux2Vhh
X-Proofpoint-ORIG-GUID: DiiDgGr63HC290zE0ZQQi2cpvlux2Vhh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_04,2023-06-12_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 phishscore=0 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2305260000 definitions=main-2306130084
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
binary inputs.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS                |   1 +
 drivers/iio/adc/Kconfig    |  10 ++
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max14001.c | 328 +++++++++++++++++++++++++++++++++++++
 4 files changed, 340 insertions(+)
 create mode 100644 drivers/iio/adc/max14001.c

diff --git a/MAINTAINERS b/MAINTAINERS
index dcea2c31f920..b527cf471d7a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12676,6 +12676,7 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/adc/adi,max14001.yaml
+F:	drivers/iio/adc/max14001.c
 
 MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index eb2b09ef5d5b..e599d166e98d 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -706,6 +706,16 @@ config MAX11410
 	  To compile this driver as a module, choose M here: the module will be
 	  called max11410.
 
+config MAX14001
+	tristate "Analog Devices MAX14001 ADC driver"
+	depends on SPI
+	help
+	  Say yes here to build support for Analog Devices MAX14001 Configurable,
+	  Isolated 10-bit ADCs for Multi-Range Binary Inputs.
+
+	  To compile this driver as a module, choose M here: the module will be
+	  called max14001.
+
 config MAX1241
 	tristate "Maxim max1241 ADC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index e07e4a3e6237..9f8964258f03 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -65,6 +65,7 @@ obj-$(CONFIG_MAX11100) += max11100.o
 obj-$(CONFIG_MAX1118) += max1118.o
 obj-$(CONFIG_MAX11205) += max11205.o
 obj-$(CONFIG_MAX11410) += max11410.o
+obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX9611) += max9611.o
diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
new file mode 100644
index 000000000000..bbee7454dbee
--- /dev/null
+++ b/drivers/iio/adc/max14001.c
@@ -0,0 +1,328 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Analog Devices MAX14001 ADC driver
+ *
+ * Copyright 2023 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitrev.h>
+#include <linux/device.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/slab.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
+
+/* MAX14001 Registers Address */
+#define MAX14001_ADC			0x00
+#define MAX14001_FADC			0x01
+#define MAX14001_FLAGS			0x02
+#define MAX14001_FLTEN			0x03
+#define MAX14001_THL			0x04
+#define MAX14001_THU			0x05
+#define MAX14001_INRR			0x06
+#define MAX14001_INRT			0x07
+#define MAX14001_INRP			0x08
+#define MAX14001_CFG			0x09
+#define MAX14001_ENBL			0x0A
+#define MAX14001_ACT			0x0B
+#define MAX14001_WEN			0x0C
+
+#define MAX14001_VERIFICATION_REG(x)	((x) + 0x10)
+
+#define MAX14001_CFG_EXRF		BIT(5)
+
+#define MAX14001_ADDR_MASK		GENMASK(15, 11)
+#define MAX14001_DATA_MASK		GENMASK(9, 0)
+#define MAX14001_FILTER_MASK		GENMASK(3, 2)
+
+#define MAX14001_SET_WRITE_BIT		BIT(10)
+#define MAX14001_WRITE_WEN		0x294
+
+struct max14001_state {
+	struct spi_device	*spi;
+	/*
+	 * lock protect agains multiple concurrent accesses, RMW sequence, and
+	 * SPI transfer
+	 */
+	struct mutex		lock;
+	int			vref_mv;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	__be16			spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
+	__be16			spi_rx_buffer;
+};
+
+static int max14001_read(void *context, unsigned int reg_addr, unsigned int *data)
+{
+	struct max14001_state *st = context;
+	int ret;
+
+	struct spi_transfer xfers[] = {
+		{
+			.tx_buf = &st->spi_tx_buffer,
+			.len = 2,
+			.cs_change = 1,
+		}, {
+			.rx_buf = &st->spi_rx_buffer,
+			.len = 2,
+		},
+	};
+
+	st->spi_tx_buffer = bitrev16(cpu_to_be16(FIELD_PREP(MAX14001_ADDR_MASK,
+								reg_addr)));
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	*data = bitrev16(be16_to_cpu(st->spi_rx_buffer)) & MAX14001_DATA_MASK;
+
+	return 0;
+}
+
+static int max14001_write(void *context, unsigned int reg_addr, unsigned int data)
+{
+	struct max14001_state *st = context;
+
+	st->spi_tx_buffer = bitrev16(cpu_to_be16(
+			FIELD_PREP(MAX14001_ADDR_MASK, reg_addr) |
+			FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
+			FIELD_PREP(MAX14001_DATA_MASK, data)));
+
+	return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_buffer));
+}
+
+static int max14001_write_verification_reg(struct max14001_state *st,
+						unsigned int reg_addr)
+{
+	unsigned int reg_data;
+	int ret;
+
+	ret = max14001_read(st, reg_addr, &reg_data);
+	if (ret)
+		return ret;
+
+	return max14001_write(st, MAX14001_VERIFICATION_REG(reg_addr), reg_data);
+}
+
+static int max14001_reg_update(struct max14001_state *st,
+				unsigned int reg_addr,
+				unsigned int mask,
+				unsigned int val)
+{
+	int ret;
+	unsigned int reg_data;
+
+	/* Enable SPI Registers Write */
+	ret = max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
+	if (ret)
+		return ret;
+
+	ret = max14001_read(st, reg_addr, &reg_data);
+	if (ret)
+		return ret;
+
+	reg_data = FIELD_PREP(mask, val);
+
+	ret = max14001_write(st, reg_addr, reg_data);
+	if (ret)
+		return ret;
+
+	/* Write Verification Register */
+	ret = max14001_write_verification_reg(st, reg_addr);
+	if (ret)
+		return ret;
+
+	/* Disable SPI Registers Write */
+	return max14001_write(st, MAX14001_WEN, 0);
+}
+
+static int max14001_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max14001_state *st = iio_priv(indio_dev);
+	unsigned int data;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = max14001_read(st, MAX14001_ADC, &data);
+		mutex_unlock(&st->lock);
+		if (ret < 0)
+			return ret;
+
+		*val = data;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv;
+		*val2 = 10;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct iio_info max14001_info = {
+	.read_raw = max14001_read_raw,
+};
+
+static const struct iio_chan_spec max14001_channels[] = {
+	{
+		.type = IIO_VOLTAGE,
+		.channel = 0,
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+				      BIT(IIO_CHAN_INFO_SCALE),
+	}
+};
+
+static void max14001_regulator_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
+static int max14001_init(struct max14001_state *st)
+{
+	int ret;
+
+	/* Enable SPI Registers Write */
+	ret = max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
+	if (ret)
+		return ret;
+
+	/*
+	 * Reads all registers and writes the values back to their appropriate
+	 * verification registers to clear the Memory Validation fault.
+	 */
+	ret = max14001_write_verification_reg(st, MAX14001_FLTEN);
+	if (ret)
+		return ret;
+
+	ret = max14001_write_verification_reg(st, MAX14001_THL);
+	if (ret)
+		return ret;
+
+	ret = max14001_write_verification_reg(st, MAX14001_THU);
+	if (ret)
+		return ret;
+
+	ret = max14001_write_verification_reg(st, MAX14001_INRR);
+	if (ret)
+		return ret;
+
+	ret = max14001_write_verification_reg(st, MAX14001_INRT);
+	if (ret)
+		return ret;
+
+	ret = max14001_write_verification_reg(st, MAX14001_INRP);
+	if (ret)
+		return ret;
+
+	ret = max14001_write_verification_reg(st, MAX14001_CFG);
+	if (ret)
+		return ret;
+
+	ret = max14001_write_verification_reg(st, MAX14001_ENBL);
+	if (ret)
+		return ret;
+
+	/* Disable SPI Registers Write */
+	return max14001_write(st, MAX14001_WEN, 0);
+}
+
+static int max14001_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct max14001_state *st;
+	struct regulator *vref;
+	struct device *dev = &spi->dev;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+	st->spi = spi;
+
+	indio_dev->name = "max14001";
+	indio_dev->info = &max14001_info;
+	indio_dev->channels = max14001_channels;
+	indio_dev->num_channels = ARRAY_SIZE(max14001_channels);
+	indio_dev->modes = INDIO_DIRECT_MODE;
+
+	ret = max14001_init(st);
+	if (ret)
+		return ret;
+
+	vref = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(vref)) {
+		if (PTR_ERR(vref) != -ENODEV)
+			return dev_err_probe(dev, PTR_ERR(vref),
+					     "Failed to get vref regulator");
+
+		/* internal reference */
+		st->vref_mv = 1250;
+	} else {
+		ret = regulator_enable(vref);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					"Failed to enable vref regulators\n");
+
+		ret = devm_add_action_or_reset(dev, max14001_regulator_disable,
+					       vref);
+		if (ret)
+			return ret;
+
+		/* select external voltage reference source for the ADC */
+		ret = max14001_reg_update(st, MAX14001_CFG,
+					  MAX14001_CFG_EXRF, 1);
+
+		ret = regulator_get_voltage(vref);
+		if (ret < 0)
+			return dev_err_probe(dev, ret,
+					     "Failed to get vref\n");
+
+		st->vref_mv = ret / 1000;
+	}
+
+	mutex_init(&st->lock);
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct of_device_id max14001_of_match[] = {
+	{ .compatible = "adi,max14001" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, max14001_of_match);
+
+static struct spi_driver max14001_driver = {
+	.driver = {
+		.name = "max14001",
+		.of_match_table = max14001_of_match,
+	},
+	.probe = max14001_probe,
+};
+module_spi_driver(max14001_driver);
+
+MODULE_AUTHOR("Kim Seer Paller");
+MODULE_DESCRIPTION("MAX14001 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

