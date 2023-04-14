Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CFF6E20D9
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 12:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjDNKdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 06:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbjDNKdS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 06:33:18 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2A1D9743;
        Fri, 14 Apr 2023 03:32:49 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33E75p3J029255;
        Fri, 14 Apr 2023 06:32:32 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3pxc350g2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Apr 2023 06:32:32 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 33EAWUDP043663
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 14 Apr 2023 06:32:30 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 14 Apr
 2023 06:32:29 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 14 Apr 2023 06:32:29 -0400
Received: from kimedia-VirtualBox.analog.com (KPALLER2-L02.ad.analog.com [10.116.185.143])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 33EAWFtv003845;
        Fri, 14 Apr 2023 06:32:17 -0400
From:   Kim Seer Paller <kimseer.paller@analog.com>
To:     <jic23@kernel.org>, <lars@metafoo.de>, <lgirdwood@gmail.com>,
        <broonie@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     <kimseer.paller@analog.com>
Subject: [PATCH 2/2] iio:adc: add max14001 support
Date:   Fri, 14 Apr 2023 18:32:02 +0800
Message-ID: <20230414103202.21603-1-kimseer.paller@analog.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: nGZ_qokq2qy8B6mSNVrylO2iSjNgPFVw
X-Proofpoint-GUID: nGZ_qokq2qy8B6mSNVrylO2iSjNgPFVw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-14_04,2023-04-14_01,2023-02-09_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 spamscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2303200000 definitions=main-2304140095
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver implementation for max14001.

The MAX14001 is configurable, isolated 10-bit ADCs for multi-range
binary inputs.

Signed-off-by: Kim Seer Paller <kimseer.paller@analog.com>
---
 MAINTAINERS                |   2 +
 drivers/iio/adc/Kconfig    |  10 +
 drivers/iio/adc/Makefile   |   1 +
 drivers/iio/adc/max14001.c | 369 +++++++++++++++++++++++++++++++++++++
 4 files changed, 382 insertions(+)
 create mode 100644 drivers/iio/adc/max14001.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 766847ad2..c0a133e5c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12579,6 +12579,8 @@ L:	linux-iio@vger.kernel.org
 S:	Supported
 W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/dac/adi,max14001.yaml
+F:	drivers/iio/adc/max14001.c
+
 
 MAXBOTIX ULTRASONIC RANGER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 45af2302b..af66d1fa8 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -745,6 +745,16 @@ config MAX9611
 	  To compile this driver as a module, choose M here: the module will be
 	  called max9611.
 
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
 config MCP320X
 	tristate "Microchip Technology MCP3x01/02/04/08 and MCP3550/1/3"
 	depends on SPI
diff --git a/drivers/iio/adc/Makefile b/drivers/iio/adc/Makefile
index 36c181773..2e3c6f1a7 100644
--- a/drivers/iio/adc/Makefile
+++ b/drivers/iio/adc/Makefile
@@ -68,6 +68,7 @@ obj-$(CONFIG_MAX11410) += max11410.o
 obj-$(CONFIG_MAX1241) += max1241.o
 obj-$(CONFIG_MAX1363) += max1363.o
 obj-$(CONFIG_MAX9611) += max9611.o
+obj-$(CONFIG_MAX14001) += max14001.o
 obj-$(CONFIG_MCP320X) += mcp320x.o
 obj-$(CONFIG_MCP3422) += mcp3422.o
 obj-$(CONFIG_MCP3911) += mcp3911.o
diff --git a/drivers/iio/adc/max14001.c b/drivers/iio/adc/max14001.c
new file mode 100644
index 000000000..76ba6f2da
--- /dev/null
+++ b/drivers/iio/adc/max14001.c
@@ -0,0 +1,369 @@
+// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
+/*
+ * Analog Devices MAX14001 ADC driver
+ *
+ * Copyright 2023 Analog Devices Inc.
+ */
+#include <asm/unaligned.h>
+#include <linux/bitfield.h>
+#include <linux/delay.h>
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
+/* MAX14001 Registers Address */
+#define MAX14001_ADC		0x00
+#define MAX14001_FADC		0x01
+#define MAX14001_FLAGS		0x02
+#define MAX14001_FLTEN		0x03
+#define MAX14001_THL		0x04
+#define MAX14001_THU		0x05
+#define MAX14001_INRR		0x06
+#define MAX14001_INRT		0x07
+#define MAX14001_INRP		0x08
+#define MAX14001_CFG		0x09
+#define MAX14001_ENBL		0x0A
+#define MAX14001_ACT		0x0B
+#define MAX14001_WEN		0x0C
+#define MAX14001_FLTV		0x13
+#define MAX14001_THLV		0x14
+#define MAX14001_THUV		0x15
+#define MAX14001_INRRV		0x16
+#define MAX14001_INRTV		0x17
+#define MAX14001_INRPV		0x18
+#define MAX14001_CFGV		0x19
+#define MAX14001_ENBLV		0x1A
+
+#define MAX14001_ADDR_MASK	GENMASK(15, 11)
+#define MAX14001_DATA_MASK	GENMASK(9, 0)
+#define MAX14001_FILTER_MASK	GENMASK(3, 2)
+#define MAX14001_CFG_MASK	GENMASK(5, 1)
+
+#define MAX14001_LSB_DIV	BIT(10)
+#define MAX14001_SET_WRITE_BIT	BIT(10)
+#define MAX14001_WRITE_WEN	0x294
+
+/*
+ * Definition used because the latter is not available
+ * in project's source tree.
+ */
+#define IIO_DMA_MINALIGN	ARCH_KMALLOC_MINALIGN
+
+struct max14001_state {
+	struct spi_device	*spi;
+	/* lock protect agains multiple concurrent accesses */
+	struct mutex		lock;
+	int			cfg_value;
+	int			vref_mv;
+	bool			use_fadc;
+	/*
+	 * DMA (thus cache coherency maintenance) requires the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	__le16			spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
+	__le16			spi_rx_buffer;
+};
+
+static int max14001_read(struct max14001_state *st,
+			 unsigned int reg_addr, u16 *data)
+{
+	u16 tx = 0;
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
+	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
+	st->spi_tx_buffer = cpu_to_le16(tx);
+
+	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
+	if (ret)
+		return ret;
+
+	*data = le16_to_cpu(st->spi_rx_buffer) & MAX14001_DATA_MASK;
+
+	return 0;
+}
+
+static int max14001_write(struct max14001_state *st,
+			  unsigned int reg_addr, u16 data)
+{
+	u16 tx;
+
+	tx = FIELD_PREP(MAX14001_ADDR_MASK, reg_addr);
+	tx |= FIELD_PREP(MAX14001_SET_WRITE_BIT, 1);
+	tx |= FIELD_PREP(MAX14001_DATA_MASK, data);
+
+	st->spi_tx_buffer = cpu_to_le16(tx);
+
+	return spi_write(st->spi, &st->spi_tx_buffer, 2);
+}
+
+static void max14001_regulator_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
+static int max14001_read_raw(struct iio_dev *indio_dev,
+			     struct iio_chan_spec const *chan,
+			     int *val, int *val2, long mask)
+{
+	struct max14001_state *st = iio_priv(indio_dev);
+	u16 data;
+	int ret;
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		mutex_lock(&st->lock);
+		ret = max14001_read(st, st->use_fadc ?
+				    MAX14001_FADC : MAX14001_ADC, &data);
+		mutex_unlock(&st->lock);
+		if (ret < 0)
+			return ret;
+
+		*val = data;
+
+		return IIO_VAL_INT;
+
+	case IIO_CHAN_INFO_SCALE:
+		*val = st->vref_mv / 1000;
+		*val2 = MAX14001_LSB_DIV;
+
+		return IIO_VAL_FRACTIONAL;
+
+	case IIO_CHAN_INFO_OFFSET:
+		*val = (st->vref_mv / 1000) / 2;
+
+		return IIO_VAL_INT;
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
+		BIT(IIO_CHAN_INFO_SCALE) |
+		BIT(IIO_CHAN_INFO_OFFSET),
+	}
+};
+
+static void max14001_fw_parse(struct max14001_state *st)
+{
+	struct device *dev = &st->spi->dev;
+	int filter;
+
+	st->use_fadc = device_property_read_bool(dev, "adi,use-fadc");
+
+	if (device_property_read_bool(dev, "adi,inrush-mode"))
+		st->cfg_value |= BIT(1);
+
+	if (device_property_read_bool(dev, "adi,current-source"))
+		st->cfg_value |= BIT(4);
+
+	if (!device_property_read_u32(dev, "adi,filter", &filter)) {
+		if (filter > 3)
+			dev_err_probe(dev, -EINVAL, "Invalid filter value\n");
+
+		st->cfg_value |= FIELD_PREP(MAX14001_FILTER_MASK, filter);
+	}
+}
+
+static int max14001_config_init(struct max14001_state *st)
+{
+	u16 data, reg_flten, reg_cfg;
+	int ret, i;
+
+	/* Enable SPI Registers Write */
+	ret = max14001_write(st, MAX14001_WEN, MAX14001_WRITE_WEN);
+	if (ret)
+		return ret;
+
+	/* Software Reset */
+	ret = max14001_write(st, MAX14001_ACT, BIT(7));
+	if (ret)
+		return ret;
+
+	msleep(100);
+
+	/* Read to clear FLAGS */
+	ret = max14001_read(st, MAX14001_FLAGS, &data);
+	if (ret)
+		return ret;
+
+	/* Clear Faults */
+	for (i = MAX14001_FLTEN; i <= MAX14001_ACT; i++) {
+		ret = max14001_write(st, i, 0);
+		if (ret)
+			return ret;
+	}
+
+	for (i = MAX14001_FLTV; i <= MAX14001_ENBLV; i++) {
+		ret = max14001_write(st, i, 0);
+		if (ret)
+			return ret;
+	}
+
+	ret = max14001_read(st, MAX14001_FLTEN, &reg_flten);
+	if (ret)
+		return ret;
+
+	/* Enable Memory Validation Flag */
+	ret = max14001_write(st, MAX14001_FLTEN, reg_flten | BIT(7));
+	if (ret)
+		return ret;
+
+	ret = max14001_write(st, MAX14001_FLTV, reg_flten | BIT(7));
+	if (ret)
+		return ret;
+
+	/* Read to clear FLAGS */
+	ret = max14001_read(st, MAX14001_FLAGS, &data);
+	if (ret)
+		return ret;
+
+	ret = max14001_read(st, MAX14001_CFG, &reg_cfg);
+	if (ret)
+		return ret;
+
+	/* Set configuration register controls */
+	ret = max14001_write(st, MAX14001_CFG, st->cfg_value |
+				FIELD_PREP(MAX14001_CFG_MASK, reg_cfg));
+	if (ret)
+		return ret;
+
+	ret = max14001_write(st, MAX14001_CFGV, st->cfg_value |
+				FIELD_PREP(MAX14001_CFG_MASK, reg_cfg));
+	if (ret)
+		return ret;
+
+	/* Enable field side current sink */
+	ret = max14001_write(st, MAX14001_ENBL, 0x010);
+	if (ret)
+		return ret;
+
+	ret = max14001_write(st, MAX14001_ENBLV, 0x010);
+	if (ret)
+		return ret;
+
+	/* Read to clear FLAGS */
+	ret = max14001_read(st, MAX14001_FLAGS, &data);
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
+
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
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
+	vref = devm_regulator_get_optional(&spi->dev, "vref");
+	if (IS_ERR(vref)) {
+		if (PTR_ERR(vref) != -ENODEV)
+			return dev_err_probe(&spi->dev, PTR_ERR(vref),
+					     "Failed to get vref regulator");
+
+		/* internal reference */
+		st->vref_mv = 1250;
+	} else {
+		ret = regulator_enable(vref);
+		if (ret)
+			return dev_err_probe(&spi->dev, ret,
+					"Failed to enable vref regulators\n");
+
+		ret = devm_add_action_or_reset(&spi->dev,
+					       max14001_regulator_disable,
+					       vref);
+		if (ret)
+			return ret;
+
+		/* external voltage reference enabled */
+		st->cfg_value |= BIT(5);
+
+		ret = regulator_get_voltage(vref);
+		if (ret < 0)
+			return dev_err_probe(&spi->dev, ret,
+					     "Failed to get vref\n");
+
+		st->vref_mv = ret / 1000;
+	}
+
+	max14001_fw_parse(st);
+
+	ret = max14001_config_init(st);
+	if (ret)
+		return ret;
+
+	mutex_init(&st->lock);
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id max14001_id[] = {
+	{ "max14001", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, max14001_id);
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
+	.id_table = max14001_id,
+};
+module_spi_driver(max14001_driver);
+
+MODULE_AUTHOR("Kim Seer Paller");
+MODULE_DESCRIPTION("MAX14001 ADC driver");
+MODULE_LICENSE("GPL");
-- 
2.34.1

