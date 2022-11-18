Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6562FB95
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:26:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242324AbiKRR00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235347AbiKRR0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:26:24 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B05591515;
        Fri, 18 Nov 2022 09:26:22 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AIFfs7v003138;
        Fri, 18 Nov 2022 12:26:18 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kx0n9vgue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 18 Nov 2022 12:26:17 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2AIHQG9d018594
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Nov 2022 12:26:16 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Fri, 18 Nov
 2022 12:26:15 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 18 Nov 2022 12:26:15 -0500
Received: from debian.ad.analog.com ([10.48.65.130])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2AIHPsw4021732;
        Fri, 18 Nov 2022 12:26:09 -0500
From:   Ciprian Regus <ciprian.regus@analog.com>
To:     <jic23@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Ciprian Regus <ciprian.regus@analog.com>
Subject: [PATCH v3 2/2] drivers: iio: dac: Add AD5754 DAC driver
Date:   Fri, 18 Nov 2022 19:24:07 +0200
Message-ID: <20221118172407.765423-3-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221118172407.765423-1-ciprian.regus@analog.com>
References: <20221118172407.765423-1-ciprian.regus@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: ZaVG2S4Z203rQue9OEkcuKs8hzDNTbMy
X-Proofpoint-GUID: ZaVG2S4Z203rQue9OEkcuKs8hzDNTbMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-18_05,2022-11-18_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 bulkscore=0
 phishscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211180102
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The AD5724/AD5734/AD5754 are quad, 12-/14-/16-bit, serial input, voltage
output DACs. The devices operate from single-supply voltages from +4.5 V
up to +16.5 V or dual-supply voltages from ±4.5 V up to ±16.5 V. The
input coding is user-selectable twos complement or offset binary for a
bipolar output (depending on the state of Pin BIN/2sComp), and straight
binary for a unipolar output.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5724_5734_5754.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5722_5732_5752.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ad5724r_5734r_5754r.pdf
Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/AD5722R_5732R_5752R.pdf
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 changes in v3:
  - wrapped the commit message to 70-75 characters.
  - added a lock for the reg_read function in order to synchronize sequential transfers.
  - replaced explicit size setting with ARRAY_SIZE() in ad5754_set_dac_code().
  - enabled all channels at once, thus also removing the side effects of the
    ad5754_enable_channels().
  - removed the vref field from the ad5754_state struct, since it's not necessary to cache
    the vref value.
  - fixed the scale formula, since the one used in v2 would only work for a 2.5V reference.
  - split the devm_ unwind path into 3 functions (instead of a single one).
 MAINTAINERS              |   8 +
 drivers/iio/dac/Kconfig  |  12 +
 drivers/iio/dac/Makefile |   1 +
 drivers/iio/dac/ad5754.c | 672 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 693 insertions(+)
 create mode 100644 drivers/iio/dac/ad5754.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e5d1d737cfb..6fa48820c969 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1091,6 +1091,14 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git
 F:	drivers/net/amt.c
 
+ANALOG DEVICES INC AD5754 DRIVER
+M:	Ciprian Regus <ciprian.regus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5754.yaml
+F:	drivers/iio/dac/ad5754.c
+
 ANALOG DEVICES INC AD7192 DRIVER
 M:	Alexandru Tachici <alexandru.tachici@analog.com>
 L:	linux-iio@vger.kernel.org
diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
index 80521bd28d0f..561bfbedeecb 100644
--- a/drivers/iio/dac/Kconfig
+++ b/drivers/iio/dac/Kconfig
@@ -170,6 +170,18 @@ config AD5696_I2C
 	  To compile this driver as a module, choose M here: the module will be
 	  called ad5696.
 
+config AD5754
+	tristate "Analog Devices AD5754 and similar DACs"
+	depends on SPI
+	select REGMAP_SPI
+	help
+	  Say yes here to build support for Analog Devices AD5752, AD5732,
+	  AD5722, AD5754, AD5734, AD5724, AD5752R, AD5732R, AD5722R, AD5754R,
+	  AD5734R, AD5724R dual/quad channel Digital to Analog Converters.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ad5754.
+
 config AD5755
 	tristate "Analog Devices AD5755/AD5755-1/AD5757/AD5735/AD5737 DAC driver"
 	depends on SPI_MASTER
diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
index ec3e42713f00..d6c18deed1f7 100644
--- a/drivers/iio/dac/Makefile
+++ b/drivers/iio/dac/Makefile
@@ -16,6 +16,7 @@ obj-$(CONFIG_AD5449) += ad5449.o
 obj-$(CONFIG_AD5592R_BASE) += ad5592r-base.o
 obj-$(CONFIG_AD5592R) += ad5592r.o
 obj-$(CONFIG_AD5593R) += ad5593r.o
+obj-$(CONFIG_AD5754) += ad5754.o
 obj-$(CONFIG_AD5755) += ad5755.o
 obj-$(CONFIG_AD5755) += ad5758.o
 obj-$(CONFIG_AD5761) += ad5761.o
diff --git a/drivers/iio/dac/ad5754.c b/drivers/iio/dac/ad5754.c
new file mode 100644
index 000000000000..81cfda2efa0f
--- /dev/null
+++ b/drivers/iio/dac/ad5754.c
@@ -0,0 +1,672 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Analog Devices, Inc.
+ * Author: Ciprian Regus <ciprian.regus@analog.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/driver.h>
+#include <linux/iio/iio.h>
+#include <linux/kernel.h>
+#include <linux/linear_range.h>
+#include <linux/mod_devicetable.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <asm/unaligned.h>
+
+#define AD5754_INT_VREF_mV			2500
+#define AD5754_FRAME_SIZE			3
+#define AD5754_MAX_CHANNELS			4
+#define AD5754_MAX_RESOLUTION			16
+#define uV_PER_mV				1000
+
+#define AD5754_DATA_MASK(_lsb)		GENMASK(15, _lsb)
+#define AD5754_RANGE_MASK		GENMASK(2, 0)
+
+#define AD5754_REG_RD			BIT(7)
+
+#define AD5754_CLEAR_FUNC		0x4
+#define AD5754_LOAD_FUNC		0x5
+#define AD5754_NOOP_FUNC		0x0
+
+#define AD5754_PU_ADDR			0x0
+#define AD5754_PU_MASK			GENMASK(3, 0)
+#define AD5754_PU_CH(x)			BIT(x)
+#define AD5754_INT_REF_MASK		BIT(4)
+
+#define AD5754_DAC_REG			0x0
+#define AD5754_RANGE_REG		0x1
+#define AD5754_PWR_REG			0x2
+#define AD5754_CTRL_REG			0x3
+
+#define AD5754_REG_ADDR(reg, addr)	(((reg) << 3) | (addr))
+
+#define AD5754_CHANNEL(_channel)					\
+	{								\
+		.type = IIO_VOLTAGE,					\
+		.indexed = 1,						\
+		.channel = _channel,					\
+		.output = 1,						\
+		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW)    |	\
+				      BIT(IIO_CHAN_INFO_SCALE)  |	\
+				      BIT(IIO_CHAN_INFO_OFFSET)		\
+	}
+
+struct ad5754_span_tbl {
+	int min;
+	int max;
+};
+
+static const struct ad5754_span_tbl ad5754_range[] = {
+	{0, 5000000},
+	{0, 10000000},
+	{0, 10800000},
+	{-5000000, 5000000},
+	{-10000000, 10000000},
+	{-10800000, 10800000},
+};
+
+enum AD5754_TYPE {
+	AD5722,
+	AD5732,
+	AD5752,
+	AD5724,
+	AD5734,
+	AD5754,
+	AD5722R,
+	AD5732R,
+	AD5752R,
+	AD5724R,
+	AD5734R,
+	AD5754R,
+};
+
+struct ad5754_chip_info {
+	const char *name;
+	u32 resolution;
+	bool internal_vref;
+	const u32 data_mask;
+	const struct iio_chan_spec *channels;
+	u32 num_channels;
+};
+
+static const struct iio_chan_spec ad5754_2_channels[2] = {
+		AD5754_CHANNEL(0),
+		AD5754_CHANNEL(1),
+};
+
+static const struct iio_chan_spec ad5754_4_channels[4] = {
+		AD5754_CHANNEL(0),
+		AD5754_CHANNEL(1),
+		AD5754_CHANNEL(2),
+		AD5754_CHANNEL(3),
+};
+
+static const struct ad5754_chip_info ad5754_chip_info_data[] = {
+	[AD5722] = {
+		.name = "ad5722",
+		.resolution = 12,
+		.data_mask = AD5754_DATA_MASK(4),
+		.internal_vref = false,
+		.num_channels = 2,
+		.channels = ad5754_2_channels,
+	},
+	[AD5732] = {
+		.name = "ad5732",
+		.resolution = 14,
+		.data_mask = AD5754_DATA_MASK(2),
+		.internal_vref = false,
+		.num_channels = 2,
+		.channels = ad5754_2_channels,
+	},
+	[AD5752] = {
+		.name = "ad5752",
+		.resolution = 16,
+		.data_mask = AD5754_DATA_MASK(0),
+		.internal_vref = false,
+		.num_channels = 2,
+		.channels = ad5754_2_channels,
+	},
+	[AD5724] = {
+		.name = "ad5724",
+		.resolution = 12,
+		.data_mask = AD5754_DATA_MASK(4),
+		.internal_vref = false,
+		.num_channels = 4,
+		.channels = ad5754_4_channels,
+	},
+	[AD5734] = {
+		.name = "ad5734",
+		.resolution = 14,
+		.data_mask = AD5754_DATA_MASK(2),
+		.internal_vref = false,
+		.num_channels = 4,
+		.channels = ad5754_4_channels,
+	},
+	[AD5754] = {
+		.name = "ad5754",
+		.resolution = 16,
+		.data_mask = AD5754_DATA_MASK(0),
+		.internal_vref = false,
+		.num_channels = 4,
+		.channels = ad5754_4_channels,
+	},
+	[AD5722R] = {
+		.name = "ad5722r",
+		.resolution = 12,
+		.data_mask = AD5754_DATA_MASK(4),
+		.internal_vref = true,
+		.num_channels = 2,
+		.channels = ad5754_2_channels,
+	},
+	[AD5732R] = {
+		.name = "ad5732r",
+		.resolution = 14,
+		.data_mask = AD5754_DATA_MASK(2),
+		.internal_vref = true,
+		.num_channels = 2,
+		.channels = ad5754_2_channels,
+	},
+	[AD5752R] = {
+		.name = "ad5752r",
+		.resolution = 16,
+		.data_mask = AD5754_DATA_MASK(0),
+		.internal_vref = true,
+		.num_channels = 2,
+		.channels = ad5754_2_channels,
+	},
+	[AD5724R] = {
+		.name = "ad5724r",
+		.resolution = 12,
+		.data_mask = AD5754_DATA_MASK(4),
+		.internal_vref = true,
+		.num_channels = 4,
+		.channels = ad5754_4_channels,
+	},
+	[AD5734R] = {
+		.name = "ad5734r",
+		.resolution = 14,
+		.data_mask = AD5754_DATA_MASK(2),
+		.internal_vref = true,
+		.num_channels = 4,
+		.channels = ad5754_4_channels,
+	},
+	[AD5754R] = {
+		.name = "ad5754r",
+		.resolution = 16,
+		.data_mask = AD5754_DATA_MASK(0),
+		.internal_vref = true,
+		.num_channels = 4,
+		.channels = ad5754_4_channels,
+	},
+};
+
+struct ad5754_state {
+	struct regmap *regmap;
+	struct spi_device *spi;
+
+	const struct ad5754_chip_info *chip_info;
+
+	/* Used for sequential SPI transfers synchronization */
+	struct mutex lock;
+
+	struct gpio_desc *clr_gpio;
+	struct regulator *vref_reg;
+	u32 range_idx[AD5754_MAX_CHANNELS];
+	int offset[AD5754_MAX_CHANNELS];
+	u32 data_mask;
+
+	/*
+	 * DMA (thus cache coherency maintenance) may require the
+	 * transfer buffers to live in their own cache lines.
+	 */
+	u8 buff[AD5754_FRAME_SIZE] __aligned(IIO_DMA_MINALIGN);
+};
+
+/*
+ * The channel addresses for 2 channel chip variants are not sequential:
+ *      A2 A1 A0 Channel
+ *	0  0  0   DAC A
+ *	0  1  0   DAC B
+ *
+ * This is not the case for 4 channel chips:
+ *	A2 A1 A0 Channel
+ *	0  0  0   DAC A
+ *	0  0  1   DAC B
+ *	0  1  0   DAC C
+ *	0  1  1   DAC D
+ */
+static unsigned int ad5754_real_ch(struct ad5754_state *st,
+				   u32 channel,
+				   u32 *real_channel)
+{
+	switch (st->chip_info->num_channels) {
+	case 2:
+		if (channel == 0)
+			*real_channel = 0;
+		else
+			*real_channel = 2;
+		break;
+	case 4:
+		*real_channel = channel;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ad5754_get_output_range(struct ad5754_state *st,
+				   struct fwnode_handle *channel_node,
+				   u32 ch_idx)
+{
+	u32 range[2];
+	int min, max;
+	int ret;
+	u32 i;
+
+	ret = fwnode_property_read_u32_array(channel_node,
+					     "adi,output-range-microvolt",
+					     range, 2);
+	if (ret)
+		return ret;
+
+	min = range[0];
+	max = range[1];
+
+	for (i = 0; i < ARRAY_SIZE(ad5754_range); i++) {
+		if (ad5754_range[i].min != min || ad5754_range[i].max != max)
+			continue;
+
+		st->range_idx[ch_idx] = i;
+		if (min < 0)
+			st->offset[ch_idx] = -BIT(st->chip_info->resolution - 1);
+
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int ad5754_reg_write(void *context, unsigned int reg, unsigned int val)
+{
+	struct ad5754_state *st = context;
+	struct spi_transfer xfer = {
+		.tx_buf = st->buff,
+		.len = 3,
+	};
+
+	st->buff[0] = reg;
+	put_unaligned_be16(val, &st->buff[1]);
+
+	return spi_sync_transfer(st->spi, &xfer, 1);
+};
+
+static int ad5754_reg_read(void *context, unsigned int reg, unsigned int *val)
+{
+	struct ad5754_state *st = context;
+	struct spi_transfer xfer[] = {
+		{
+			.tx_buf = st->buff,
+			.len = AD5754_FRAME_SIZE,
+		},
+	};
+	int ret;
+
+	st->buff[0] = AD5754_REG_RD | reg;
+
+	mutex_lock(&st->lock);
+	ret = spi_sync_transfer(st->spi, xfer, 1);
+	if (ret)
+		goto unlock;
+
+	xfer->rx_buf = st->buff;
+	st->buff[0] = AD5754_REG_ADDR(AD5754_CTRL_REG, AD5754_NOOP_FUNC);
+	st->buff[1] = 0;
+	st->buff[2] = 0;
+	ret = spi_sync_transfer(st->spi, xfer, 1);
+	if (ret)
+		goto unlock;
+
+	*val = get_unaligned_be16(&st->buff[1]);
+
+unlock:
+	mutex_unlock(&st->lock);
+
+	return ret;
+};
+
+static const struct regmap_config ad5754_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 16,
+	.reg_write = ad5754_reg_write,
+	.reg_read = ad5754_reg_read,
+	.max_register = 0x23,
+};
+
+static int ad5754_set_dac_code(struct ad5754_state *st, u32 channel, u32 code)
+{
+	u32 sub_lsb = AD5754_MAX_RESOLUTION - st->chip_info->resolution;
+	struct reg_sequence xfer_seq[2] = {
+		{ AD5754_REG_ADDR(AD5754_DAC_REG, channel), code << sub_lsb },
+		{ AD5754_REG_ADDR(AD5754_CTRL_REG, AD5754_LOAD_FUNC), 0 },
+	};
+
+	return regmap_multi_reg_write(st->regmap, xfer_seq, ARRAY_SIZE(xfer_seq));
+}
+
+static int ad5754_enable_channels(struct ad5754_state *st)
+{
+	struct fwnode_handle *channel_node;
+	u32 en_channels = 0;
+	u32 real_channel;
+	u32 index;
+	int ret;
+
+	device_for_each_child_node(&st->spi->dev, channel_node) {
+		ret = fwnode_property_read_u32(channel_node, "reg", &index);
+		if (ret) {
+			dev_err(&st->spi->dev, "Failed to read channel reg: %d\n", ret);
+			goto free_node;
+		}
+		if (index >= st->chip_info->num_channels) {
+			dev_err(&st->spi->dev, "Channel index %u is too large\n", index);
+			goto free_node;
+		}
+
+		ret = ad5754_real_ch(st, index, &real_channel);
+		if (ret)
+			goto free_node;
+
+		ret = ad5754_get_output_range(st, channel_node, index);
+		if (ret)
+			goto free_node;
+
+		ret = regmap_write_bits(st->regmap,
+					AD5754_REG_ADDR(AD5754_RANGE_REG, real_channel),
+					AD5754_RANGE_MASK, st->range_idx[index]);
+		if (ret)
+			goto free_node;
+
+		en_channels |= AD5754_PU_CH(real_channel);
+	}
+
+	ret = regmap_update_bits(st->regmap,
+				 AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
+				 AD5754_PU_MASK,
+				 FIELD_PREP(AD5754_PU_MASK, en_channels));
+	if (ret)
+		return ret;
+
+	/* Channel power up delay */
+	fsleep(10);
+
+	return 0;
+
+free_node:
+	fwnode_handle_put(channel_node);
+
+	return ret;
+}
+
+static int ad5754_write_raw(struct iio_dev *indio_dev,
+			    struct iio_chan_spec const *chan,
+			    int val, int val2, long info)
+{
+	struct ad5754_state *st = iio_priv(indio_dev);
+	u32 real_channel;
+	int ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val >= BIT(st->chip_info->resolution)) {
+			dev_err(&st->spi->dev, "Invalid DAC code %d\n", val);
+			return -EINVAL;
+		}
+		ret = ad5754_real_ch(st, chan->channel, &real_channel);
+		if (ret)
+			return ret;
+
+		return ad5754_set_dac_code(st, real_channel, val);
+	default:
+		return -EINVAL;
+	}
+}
+
+static int ad5754_read_raw(struct iio_dev *indio_dev,
+			   struct iio_chan_spec const *chan,
+			   int *val, int *val2, long info)
+{
+	struct ad5754_state *st = iio_priv(indio_dev);
+	const struct ad5754_span_tbl *range;
+	u32 real_channel;
+	u32 gain;
+	int vref;
+	int ret;
+
+	ret = ad5754_real_ch(st, chan->channel, &real_channel);
+	if (ret)
+		return ret;
+
+	switch (info) {
+	case IIO_CHAN_INFO_RAW:
+		ret = regmap_read(st->regmap, real_channel, val);
+		if (ret)
+			return ret;
+
+		*val >>= AD5754_MAX_RESOLUTION - st->chip_info->resolution;
+
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_SCALE:
+		if (st->chip_info->internal_vref) {
+			vref = AD5754_INT_VREF_mV;
+		} else {
+			vref = regulator_get_voltage(st->vref_reg);
+			if (vref < 0)
+				return vref;
+
+			vref /= uV_PER_mV;
+		}
+
+		range = &ad5754_range[st->range_idx[chan->channel]];
+		gain = (range->max - range->min) / AD5754_INT_VREF_mV;
+		*val = vref * gain / uV_PER_mV;
+		*val2 = st->chip_info->resolution;
+
+		return IIO_VAL_FRACTIONAL_LOG2;
+	case IIO_CHAN_INFO_OFFSET:
+		*val = st->offset[chan->channel];
+
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
+}
+
+static void ad5754_channels_disable(void *state)
+{
+	struct ad5754_state *st = state;
+
+	regmap_update_bits(st->regmap,
+			   AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
+			   AD5754_PU_MASK, FIELD_PREP(AD5754_PU_MASK, 0));
+}
+
+static void ad5754_disable_int_ref(void *state)
+{
+	struct ad5754_state *st = state;
+
+	regmap_update_bits(st->regmap,
+			   AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
+			   AD5754_INT_REF_MASK,
+			   FIELD_PREP(AD5754_INT_REF_MASK, 0));
+}
+
+static void ad5754_regulator_disable(void *regulator)
+{
+	regulator_disable(regulator);
+}
+
+static const struct iio_info ad5754_info = {
+	.read_raw = &ad5754_read_raw,
+	.write_raw = &ad5754_write_raw,
+};
+
+static int ad5754_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct iio_dev *indio_dev;
+	struct ad5754_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	st = iio_priv(indio_dev);
+
+	st->spi = spi;
+	st->chip_info = device_get_match_data(dev);
+	if (!st->chip_info)
+		st->chip_info = (void *)spi_get_device_id(spi)->driver_data;
+
+	mutex_init(&st->lock);
+
+	st->regmap = devm_regmap_init(dev, NULL, st, &ad5754_regmap_config);
+	if (IS_ERR(st->regmap))
+		return dev_err_probe(dev, PTR_ERR(st->regmap),
+				     "Regmap init error\n");
+
+	st->clr_gpio = devm_gpiod_get_optional(dev, "clr", GPIOD_OUT_LOW);
+	if (IS_ERR(st->clr_gpio))
+		return PTR_ERR(st->clr_gpio);
+
+	/* Clear DAC outputs */
+	ret = regmap_write(st->regmap,
+			   AD5754_REG_ADDR(AD5754_CTRL_REG, AD5754_CLEAR_FUNC),
+			   0);
+	if (ret)
+		return ret;
+
+	st->vref_reg = devm_regulator_get_optional(dev, "vref");
+	if (IS_ERR(st->vref_reg)) {
+		if (!st->chip_info->internal_vref)
+			return dev_err_probe(dev, PTR_ERR(st->vref_reg),
+					     "Failed to get the vref regulator\n");
+
+		ret = regmap_update_bits(st->regmap,
+					 AD5754_REG_ADDR(AD5754_PWR_REG, AD5754_PU_ADDR),
+					 AD5754_INT_REF_MASK,
+					 FIELD_PREP(AD5754_INT_REF_MASK, 1));
+		if (ret)
+			return ret;
+
+		ret = devm_add_action_or_reset(dev, ad5754_disable_int_ref, st);
+		if (ret)
+			return ret;
+	} else {
+		ret = regulator_enable(st->vref_reg);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "Failed to enable the vref regulator\n");
+
+		ret = devm_add_action_or_reset(dev, ad5754_regulator_disable, st->vref_reg);
+		if (ret)
+			return ret;
+	}
+
+	indio_dev->name = st->chip_info->name;
+	indio_dev->modes = INDIO_DIRECT_MODE;
+	indio_dev->info = &ad5754_info;
+	indio_dev->channels = st->chip_info->channels;
+	indio_dev->num_channels = st->chip_info->num_channels;
+
+	ret = ad5754_enable_channels(st);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, ad5754_channels_disable, st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(dev, indio_dev);
+}
+
+static const struct spi_device_id ad5754_id[] = {
+	{ "ad5722", (kernel_ulong_t)&ad5754_chip_info_data[AD5722], },
+	{ "ad5732", (kernel_ulong_t)&ad5754_chip_info_data[AD5732], },
+	{ "ad5752", (kernel_ulong_t)&ad5754_chip_info_data[AD5752], },
+	{ "ad5724", (kernel_ulong_t)&ad5754_chip_info_data[AD5724], },
+	{ "ad5734", (kernel_ulong_t)&ad5754_chip_info_data[AD5734], },
+	{ "ad5754", (kernel_ulong_t)&ad5754_chip_info_data[AD5754], },
+	{ "ad5722r", (kernel_ulong_t)&ad5754_chip_info_data[AD5722R], },
+	{ "ad5732r", (kernel_ulong_t)&ad5754_chip_info_data[AD5732R], },
+	{ "ad5752r", (kernel_ulong_t)&ad5754_chip_info_data[AD5752R], },
+	{ "ad5724r", (kernel_ulong_t)&ad5754_chip_info_data[AD5724R], },
+	{ "ad5734r", (kernel_ulong_t)&ad5754_chip_info_data[AD5734R], },
+	{ "ad5754r", (kernel_ulong_t)&ad5754_chip_info_data[AD5754R], },
+	{}
+};
+
+static const struct of_device_id ad5754_dt_id[] = {
+	{
+		.compatible = "adi,ad5722",
+		.data = &ad5754_chip_info_data[AD5722],
+	}, {
+		.compatible = "adi,ad5732",
+		.data = &ad5754_chip_info_data[AD5732],
+	}, {
+		.compatible = "adi,ad5752",
+		.data = &ad5754_chip_info_data[AD5752],
+	}, {
+		.compatible = "adi,ad5724",
+		.data = &ad5754_chip_info_data[AD5724],
+	}, {
+		.compatible = "adi,ad5734",
+		.data = &ad5754_chip_info_data[AD5734],
+	}, {
+		.compatible = "adi,ad5754",
+		.data = &ad5754_chip_info_data[AD5754],
+	}, {
+		.compatible = "adi,ad5722r",
+		.data = &ad5754_chip_info_data[AD5722R],
+	}, {
+		.compatible = "adi,ad5732r",
+		.data = &ad5754_chip_info_data[AD5732R],
+	}, {
+		.compatible = "adi,ad5752r",
+		.data = &ad5754_chip_info_data[AD5752R],
+	}, {
+		.compatible = "adi,ad5724r",
+		.data = &ad5754_chip_info_data[AD5724R],
+	}, {
+		.compatible = "adi,ad5734r",
+		.data = &ad5754_chip_info_data[AD5734R],
+	}, {
+		.compatible = "adi,ad5754r",
+		.data = &ad5754_chip_info_data[AD5754R],
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, ad5754_dt_id);
+
+static struct spi_driver ad5754_driver = {
+	.driver = {
+		.name = "ad5754",
+		.of_match_table = ad5754_dt_id,
+	},
+	.probe = ad5754_probe,
+	.id_table = ad5754_id,
+};
+
+module_spi_driver(ad5754_driver);
+
+MODULE_AUTHOR("Ciprian Regus <ciprian.regus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices AD5754 DAC");
+MODULE_LICENSE("GPL");
-- 
2.30.2

