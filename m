Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2061F2D6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 13:21:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiKGMVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 07:21:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKGMVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 07:21:22 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1459D633D;
        Mon,  7 Nov 2022 04:21:20 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2A79b1DP019772;
        Mon, 7 Nov 2022 07:21:10 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3kpmgu4d2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Nov 2022 07:21:10 -0500
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 2A7CL8Zi046761
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 7 Nov 2022 07:21:08 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 7 Nov 2022 07:21:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 7 Nov 2022 07:21:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 7 Nov 2022 07:21:07 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.106])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 2A7CKrRK022057;
        Mon, 7 Nov 2022 07:20:58 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v2 2/3] iio: frequency: adf4377: add support for ADF4377
Date:   Mon, 7 Nov 2022 14:02:42 +0200
Message-ID: <20221107120243.57344-2-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107120243.57344-1-antoniu.miclaus@analog.com>
References: <20221107120243.57344-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tSj-O4orBYUxPJrpnH_lY3k8G0o8Syui
X-Proofpoint-ORIG-GUID: tSj-O4orBYUxPJrpnH_lY3k8G0o8Syui
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_04,2022-11-07_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2210170000
 definitions=main-2211070100
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ADF4377 is a high performance, ultralow jitter, dual output integer-N
phased locked loop (PLL) with integrated voltage controlled oscillator
(VCO) ideally suited for data converter and mixed signal front end (MxFE)
clock applications.

Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/adf4377.pdf
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 - use `devm_clk_get_enabled()`
 - return in place for `adf4377_read` and `adf4377_write`
 - remove adf4378 support since datasheet is not public yet.
 - print errors inside `adf4377_init`
 - remove enable/disable related defines and use 0/1 inline with field_prep
 - remove powerdown bit defines
 - use `regmap_multi_reg_write` to set the default registers
 - remove `adf4377_set_default` function
 - drive gpios to low state by default
 - remove redundant comments
 - remove muxout from userspace, move it as devicetree property
 - remove custom set of the Charge Pump current
 - remove comma on NULL terminators
 drivers/iio/frequency/Kconfig   |  10 +
 drivers/iio/frequency/Makefile  |   1 +
 drivers/iio/frequency/adf4377.c | 971 ++++++++++++++++++++++++++++++++
 3 files changed, 982 insertions(+)
 create mode 100644 drivers/iio/frequency/adf4377.c

diff --git a/drivers/iio/frequency/Kconfig b/drivers/iio/frequency/Kconfig
index f3702f36436c..9e85dfa58508 100644
--- a/drivers/iio/frequency/Kconfig
+++ b/drivers/iio/frequency/Kconfig
@@ -50,6 +50,16 @@ config ADF4371
 	  To compile this driver as a module, choose M here: the
 	  module will be called adf4371.
 
+config ADF4377
+	tristate "Analog Devices ADF4377 Microwave Wideband Synthesizer"
+	depends on SPI && COMMON_CLK
+	help
+	  Say yes here to build support for Analog Devices ADF4377 Microwave
+	  Wideband Synthesizer.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called adf4377.
+
 config ADMV1013
 	tristate "Analog Devices ADMV1013 Microwave Upconverter"
 	depends on SPI && COMMON_CLK
diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makefile
index 48add732f1d3..b616c29b4a08 100644
--- a/drivers/iio/frequency/Makefile
+++ b/drivers/iio/frequency/Makefile
@@ -7,6 +7,7 @@
 obj-$(CONFIG_AD9523) += ad9523.o
 obj-$(CONFIG_ADF4350) += adf4350.o
 obj-$(CONFIG_ADF4371) += adf4371.o
+obj-$(CONFIG_ADF4377) += adf4377.o
 obj-$(CONFIG_ADMV1013) += admv1013.o
 obj-$(CONFIG_ADMV1014) += admv1014.o
 obj-$(CONFIG_ADMV4420) += admv4420.o
diff --git a/drivers/iio/frequency/adf4377.c b/drivers/iio/frequency/adf4377.c
new file mode 100644
index 000000000000..542299f0d47d
--- /dev/null
+++ b/drivers/iio/frequency/adf4377.c
@@ -0,0 +1,971 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ADF4377 driver
+ *
+ * Copyright 2022 Analog Devices Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bits.h>
+#include <linux/clk.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/notifier.h>
+#include <linux/property.h>
+#include <linux/spi/spi.h>
+#include <linux/iio/iio.h>
+#include <linux/regmap.h>
+#include <linux/units.h>
+
+#include <asm/unaligned.h>
+
+/* ADF4377 REG0000 Map */
+#define ADF4377_SOFT_RESET_R_MSK	BIT(7)
+#define ADF4377_LSB_FIRST_R_MSK		BIT(6)
+#define ADF4377_ADDRESS_ASC_R_MSK	BIT(5)
+#define ADF4377_SDO_ACTIVE_R_MSK	BIT(4)
+#define ADF4377_SDO_ACTIVE_MSK		BIT(3)
+#define ADF4377_ADDRESS_ASC_MSK		BIT(2)
+#define ADF4377_LSB_FIRST_MSK		BIT(1)
+#define ADF4377_SOFT_RESET_MSK		BIT(0)
+
+/* ADF4377 REG0000 Bit Definition */
+#define ADF4377_SDO_ACTIVE_SPI_3W	0x0
+#define ADF4377_SDO_ACTIVE_SPI_4W	0x1
+
+#define ADF4377_ADDR_ASC_AUTO_DECR	0x0
+#define ADF4377_ADDR_ASC_AUTO_INCR	0x1
+
+#define ADF4377_LSB_FIRST_MSB		0x0
+#define ADF4377_LSB_FIRST_LSB		0x1
+
+#define ADF4377_SOFT_RESET_N_OP		0x0
+#define ADF4377_SOFT_RESET_EN		0x1
+
+/* ADF4377 REG0001 Map */
+#define ADF4377_SINGLE_INSTR_MSK	BIT(7)
+#define ADF4377_MASTER_RB_CTRL_MSK	BIT(5)
+
+/* ADF4377 REG0003 Bit Definition */
+#define ADF4377_CHIP_TYPE		0x06
+
+/* ADF4377 REG0004 Bit Definition */
+#define ADF4377_PRODUCT_ID_LSB		0x0005
+
+/* ADF4377 REG0005 Bit Definition */
+#define ADF4377_PRODUCT_ID_MSB		0x0005
+
+/* ADF4377 REG000A Map */
+#define ADF4377_SCRATCHPAD_MSK		GENMASK(7, 0)
+
+/* ADF4377 REG000C Bit Definition */
+#define ADF4377_VENDOR_ID_LSB		0x56
+
+/* ADF4377 REG000D Bit Definition */
+#define ADF4377_VENDOR_ID_MSB		0x04
+
+/* ADF4377 REG000F Bit Definition */
+#define ADF4377_R00F_RSV1_MSK		GENMASK(7, 0)
+
+/* ADF4377 REG0010 Map*/
+#define ADF4377_N_INT_LSB_MSK		GENMASK(7, 0)
+
+/* ADF4377 REG0011 Map*/
+#define ADF4377_EN_AUTOCAL_MSK		BIT(7)
+#define ADF4377_EN_RDBLR_MSK		BIT(6)
+#define ADF4377_DCLK_DIV2_MSK		GENMASK(5, 4)
+#define ADF4377_N_INT_MSB_MSK		GENMASK(3, 0)
+
+/* ADF4377 REG0011 Bit Definition */
+#define ADF4377_DCLK_DIV2_1		0x0
+#define ADF4377_DCLK_DIV2_2		0x1
+#define ADF4377_DCLK_DIV2_4		0x2
+#define ADF4377_DCLK_DIV2_8		0x3
+
+/* ADF4377 REG0012 Map*/
+#define ADF4377_CLKOUT_DIV_MSK		GENMASK(7, 6)
+#define ADF4377_R_DIV_MSK		GENMASK(5, 0)
+
+/* ADF4377 REG0012 Bit Definition */
+#define ADF4377_CLKOUT_DIV_1		0x0
+#define ADF4377_CLKOUT_DIV_2		0x1
+#define ADF4377_CLKOUT_DIV_4		0x2
+#define ADF4377_CLKOUT_DIV_8		0x3
+
+/* ADF4377 REG0013 Map */
+#define ADF4377_M_VCO_CORE_MSK		GENMASK(5, 4)
+#define ADF4377_M_VCO_BIAS_MSK		GENMASK(3, 0)
+
+/* ADF4377 REG0013 Bit Definition */
+#define ADF4377_M_VCO_0			0x0
+#define ADF4377_M_VCO_1			0x1
+#define ADF4377_M_VCO_2			0x2
+#define ADF4377_M_VCO_3			0x3
+
+/* ADF4377 REG0014 Map */
+#define ADF4377_M_VCO_BAND_MSK		GENMASK(7, 0)
+
+/* ADF4377 REG0015 Map */
+#define ADF4377_BLEED_I_LSB_MSK		GENMASK(7, 6)
+#define ADF4377_BLEED_POL_MSK		BIT(5)
+#define ADF4377_EN_BLEED_MSK		BIT(4)
+#define ADF4377_CP_I_MSK		GENMASK(3, 0)
+
+/* ADF4377 REG0015 Bit Definition */
+#define ADF4377_CURRENT_SINK		0x0
+#define ADF4377_CURRENT_SOURCE		0x1
+
+#define ADF4377_CP_0MA7			0x0
+#define ADF4377_CP_0MA9			0x1
+#define ADF4377_CP_1MA1			0x2
+#define ADF4377_CP_1MA3			0x3
+#define ADF4377_CP_1MA4			0x4
+#define ADF4377_CP_1MA8			0x5
+#define ADF4377_CP_2MA2			0x6
+#define ADF4377_CP_2MA5			0x7
+#define ADF4377_CP_2MA9			0x8
+#define ADF4377_CP_3MA6			0x9
+#define ADF4377_CP_4MA3			0xA
+#define ADF4377_CP_5MA0			0xB
+#define ADF4377_CP_5MA7			0xC
+#define ADF4377_CP_7MA2			0xD
+#define ADF4377_CP_8MA6			0xE
+#define ADF4377_CP_10MA1		0xF
+
+/* ADF4377 REG0016 Map */
+#define ADF4377_BLEED_I_MSB_MSK		GENMASK(7, 0)
+
+/* ADF4377 REG0017 Map */
+#define ADF4377_INV_CLKOUT_MSK		BIT(7)
+#define ADF4377_N_DEL_MSK		GENMASK(6, 0)
+
+/* ADF4377 REG0018 Map */
+#define ADF4377_CMOS_OV_MSK		BIT(7)
+#define ADF4377_R_DEL_MSK		GENMASK(6, 0)
+
+/* ADF4377 REG0018 Bit Definition */
+#define ADF4377_1V8_LOGIC		0x0
+#define ADF4377_3V3_LOGIC		0x1
+
+/* ADF4377 REG0019 Map */
+#define ADF4377_CLKOUT2_OP_MSK		GENMASK(7, 6)
+#define ADF4377_CLKOUT1_OP_MSK		GENMASK(5, 4)
+#define ADF4377_PD_CLK_MSK		BIT(3)
+#define ADF4377_PD_RDET_MSK		BIT(2)
+#define ADF4377_PD_ADC_MSK		BIT(1)
+#define ADF4377_PD_CALADC_MSK		BIT(0)
+
+/* ADF4377 REG0019 Bit Definition */
+#define ADF4377_CLKOUT_320MV		0x0
+#define ADF4377_CLKOUT_420MV		0x1
+#define ADF4377_CLKOUT_530MV		0x2
+#define ADF4377_CLKOUT_640MV		0x3
+
+/* ADF4377 REG001A Map */
+#define ADF4377_PD_ALL_MSK		BIT(7)
+#define ADF4377_PD_RDIV_MSK		BIT(6)
+#define ADF4377_PD_NDIV_MSK		BIT(5)
+#define ADF4377_PD_VCO_MSK		BIT(4)
+#define ADF4377_PD_LD_MSK		BIT(3)
+#define ADF4377_PD_PFDCP_MSK		BIT(2)
+#define ADF4377_PD_CLKOUT1_MSK		BIT(1)
+#define ADF4377_PD_CLKOUT2_MSK		BIT(0)
+
+/* ADF4377 REG001B Map */
+#define ADF4377_EN_LOL_MSK		BIT(7)
+#define ADF4377_LDWIN_PW_MSK		BIT(6)
+#define ADF4377_EN_LDWIN_MSK		BIT(5)
+#define ADF4377_LD_COUNT_MSK		GENMASK(4, 0)
+
+/* ADF4377 REG001B Bit Definition */
+#define ADF4377_LDWIN_PW_NARROW		0x0
+#define ADF4377_LDWIN_PW_WIDE		0x1
+
+/* ADF4377 REG001C Map */
+#define ADF4377_EN_DNCLK_MSK		BIT(7)
+#define ADF4377_EN_DRCLK_MSK		BIT(6)
+#define ADF4377_RST_LD_MSK		BIT(2)
+#define ADF4377_R01C_RSV1_MSK		BIT(0)
+
+/* ADF4377 REG001C Bit Definition */
+#define ADF4377_RST_LD_INACTIVE         0x0
+#define ADF4377_RST_LD_ACTIVE           0x1
+
+#define ADF4377_R01C_RSV1		0x1
+
+/* ADF4377 REG001D Map */
+#define ADF4377_MUXOUT_MSK		GENMASK(7, 4)
+#define ADF4377_EN_CPTEST_MSK		BIT(2)
+#define ADF4377_CP_DOWN_MSK		BIT(1)
+#define ADF4377_CP_UP_MSK		BIT(0)
+
+#define ADF4377_EN_CPTEST_OFF		0x0
+#define ADF4377_EN_CPTEST_ON		0x1
+
+#define ADF4377_CP_DOWN_OFF		0x0
+#define ADF4377_CP_DOWN_ON		0x1
+
+#define ADF4377_CP_UP_OFF		0x0
+#define ADF4377_CP_UP_ON		0x1
+
+/* ADF4377 REG001F Map */
+#define ADF4377_BST_REF_MSK		BIT(7)
+#define ADF4377_FILT_REF_MSK		BIT(6)
+#define ADF4377_REF_SEL_MSK		BIT(5)
+#define ADF4377_R01F_RSV1_MSK		GENMASK(4, 0)
+
+/* ADF4377 REG001F Bit Definition */
+#define ADF4377_BST_LARGE_REF_IN	0x0
+#define ADF4377_BST_SMALL_REF_IN	0x1
+
+#define ADF4377_FILT_REF_OFF		0x0
+#define ADF4377_FILT_REF_ON		0x1
+
+#define ADF4377_REF_SEL_DMA		0x0
+#define ADF4377_REF_SEL_LNA		0x1
+
+#define ADF4377_R01F_RSV1		0x7
+
+/* ADF4377 REG0020 Map */
+#define ADF4377_RST_SYS_MSK		BIT(4)
+#define ADF4377_EN_ADC_CLK_MSK		BIT(3)
+#define ADF4377_R020_RSV1_MSK		BIT(0)
+
+/* ADF4377 REG0021 Bit Definition */
+#define ADF4377_R021_RSV1		0xD3
+
+/* ADF4377 REG0022 Bit Definition */
+#define ADF4377_R022_RSV1		0x32
+
+/* ADF4377 REG0023 Map */
+#define ADF4377_CAT_CT_SEL		BIT(7)
+#define ADF4377_R023_RSV1_MSK		GENMASK(6, 0)
+
+/* ADF4377 REG0023 Bit Definition */
+#define ADF4377_R023_RSV1		0x18
+
+/* ADF4377 REG0024 Map */
+#define ADF4377_DCLK_MODE_MSK		BIT(2)
+
+/* ADF4377 REG0025 Map */
+#define ADF4377_CLKODIV_DB_MSK		BIT(7)
+#define ADF4377_DCLK_DB_MSK		BIT(6)
+#define ADF4377_R025_RSV1_MSK		GENMASK(5, 0)
+
+/* ADF4377 REG0025 Bit Definition */
+#define ADF4377_R025_RSV1		0x16
+
+/* ADF4377 REG0026 Map */
+#define ADF4377_VCO_BAND_DIV_MSK	GENMASK(7, 0)
+
+/* ADF4377 REG0027 Map */
+#define ADF4377_SYNTH_LOCK_TO_LSB_MSK	GENMASK(7, 0)
+
+/* ADF4377 REG0028 Map */
+#define ADF4377_O_VCO_DB_MSK		BIT(7)
+#define ADF4377_SYNTH_LOCK_TO_MSB_MSK	GENMASK(6, 0)
+
+/* ADF4377 REG0029 Map */
+#define ADF4377_VCO_ALC_TO_LSB_MSK	GENMASK(7, 0)
+
+/* ADF4377 REG002A Map */
+#define ADF4377_DEL_CTRL_DB_MSK		BIT(7)
+#define ADF4377_VCO_ALC_TO_MSB_MSK	GENMASK(6, 0)
+
+/* ADF4377 REG002C Map */
+#define ADF4377_R02C_RSV1		0xC0
+
+/* ADF4377 REG002D Map */
+#define ADF4377_ADC_CLK_DIV_MSK		GENMASK(7, 0)
+
+/* ADF4377 REG002E Map */
+#define ADF4377_EN_ADC_CNV_MSK		BIT(7)
+#define ADF4377_EN_ADC_MSK		BIT(1)
+#define ADF4377_ADC_A_CONV_MSK		BIT(0)
+
+/* ADF4377 REG002E Bit Definition */
+#define ADF4377_ADC_A_CONV_ADC_ST_CNV	0x0
+#define ADF4377_ADC_A_CONV_VCO_CALIB	0x1
+
+/* ADF4377 REG002F Map */
+#define ADF4377_DCLK_DIV1_MSK		GENMASK(1, 0)
+
+/* ADF4377 REG002F Bit Definition */
+#define ADF4377_DCLK_DIV1_1		0x0
+#define ADF4377_DCLK_DIV1_2		0x1
+#define ADF4377_DCLK_DIV1_8		0x2
+#define ADF4377_DCLK_DIV1_32		0x3
+
+/* ADF4377 REG0031 Bit Definition */
+#define ADF4377_R031_RSV1		0x09
+
+/* ADF4377 REG0032 Map */
+#define ADF4377_ADC_CLK_SEL_MSK		BIT(6)
+#define ADF4377_R032_RSV1_MSK		GENMASK(5, 0)
+
+/* ADF4377 REG0032 Bit Definition */
+#define ADF4377_ADC_CLK_SEL_N_OP	0x0
+#define ADF4377_ADC_CLK_SEL_SPI_CLK	0x1
+
+#define ADF4377_R032_RSV1		0x9
+
+/* ADF4377 REG0033 Bit Definition */
+#define ADF4377_R033_RSV1		0x18
+
+/* ADF4377 REG0034 Bit Definition */
+#define ADF4377_R034_RSV1		0x08
+
+/* ADF4377 REG003A Bit Definition */
+#define ADF4377_R03A_RSV1		0x5D
+
+/* ADF4377 REG003B Bit Definition */
+#define ADF4377_R03B_RSV1		0x2B
+
+/* ADF4377 REG003D Map */
+#define ADF4377_O_VCO_BAND_MSK		BIT(3)
+#define ADF4377_O_VCO_CORE_MSK		BIT(2)
+#define ADF4377_O_VCO_BIAS_MSK		BIT(1)
+
+/* ADF4377 REG003D Bit Definition */
+#define ADF4377_O_VCO_BAND_VCO_CALIB	0x0
+#define ADF4377_O_VCO_BAND_M_VCO	0x1
+
+#define ADF4377_O_VCO_CORE_VCO_CALIB	0x0
+#define ADF4377_O_VCO_CORE_M_VCO	0x1
+
+#define ADF4377_O_VCO_BIAS_VCO_CALIB	0x0
+#define ADF4377_O_VCO_BIAS_M_VCO	0x1
+
+/* ADF4377 REG0042 Map */
+#define ADF4377_R042_RSV1		0x05
+
+/* ADF4377 REG0045 Map */
+#define ADF4377_ADC_ST_CNV_MSK		BIT(0)
+
+/* ADF4377 REG0049 Map */
+#define ADF4377_EN_CLK2_MSK		BIT(7)
+#define ADF4377_EN_CLK1_MSK		BIT(6)
+#define ADF4377_REF_OK_MSK		BIT(3)
+#define ADF4377_ADC_BUSY_MSK		BIT(2)
+#define ADF4377_FSM_BUSY_MSK		BIT(1)
+#define ADF4377_LOCKED_MSK		BIT(0)
+
+/* ADF4377 REG004B Map */
+#define ADF4377_VCO_CORE_MSK		GENMASK(1, 0)
+
+/* ADF4377 REG004C Map */
+#define ADF4377_CHIP_TEMP_LSB_MSK	GENMASK(7, 0)
+
+/* ADF4377 REG004D Map */
+#define ADF4377_CHIP_TEMP_MSB_MSK	BIT(0)
+
+/* ADF4377 REG004F Map */
+#define ADF4377_VCO_BAND_MSK		GENMASK(7, 0)
+
+/* ADF4377 REG0051 Map */
+#define ADF4377_VCO_BIAS_MSK		GENMASK(3, 0)
+
+/* ADF4377 REG0054 Map */
+#define ADF4377_CHIP_VERSION_MSK	GENMASK(7, 0)
+
+/* Specifications */
+#define ADF4377_SPI_READ_CMD		BIT(7)
+#define ADF4377_MAX_VCO_FREQ		(12800ULL * HZ_PER_MHZ)
+#define ADF4377_MIN_VCO_FREQ		(6400ULL * HZ_PER_MHZ)
+#define ADF4377_MAX_REFIN_FREQ		(1000 * HZ_PER_MHZ)
+#define ADF4377_MIN_REFIN_FREQ		(10 * HZ_PER_MHZ)
+#define ADF4377_MAX_FREQ_PFD		(500 * HZ_PER_MHZ)
+#define ADF4377_MIN_FREQ_PFD		(3 * HZ_PER_MHZ)
+#define ADF4377_MAX_CLKPN_FREQ		ADF4377_MAX_VCO_FREQ
+#define ADF4377_MIN_CLKPN_FREQ		(ADF4377_MIN_VCO_FREQ / 8)
+#define ADF4377_FREQ_PFD_80MHZ		(80 * HZ_PER_MHZ)
+#define ADF4377_FREQ_PFD_125MHZ		(125 * HZ_PER_MHZ)
+#define ADF4377_FREQ_PFD_160MHZ		(160 * HZ_PER_MHZ)
+#define ADF4377_FREQ_PFD_250MHZ		(250 * HZ_PER_MHZ)
+#define ADF4377_FREQ_PFD_320MHZ		(320 * HZ_PER_MHZ)
+
+enum {
+	ADF4377_FREQ,
+};
+
+enum muxout_select_mode {
+	ADF4377_MUXOUT_HIGH_Z = 0x0,
+	ADF4377_MUXOUT_LKDET = 0x1,
+	ADF4377_MUXOUT_LOW = 0x2,
+	ADF4377_MUXOUT_DIV_RCLK_2 = 0x4,
+	ADF4377_MUXOUT_DIV_NCLK_2 = 0x5,
+	ADF4377_MUXOUT_HIGH = 0x8,
+};
+
+struct adf4377_state {
+	struct spi_device	*spi;
+	struct regmap		*regmap;
+	struct clk		*clkin;
+	/* Protect against concurrent accesses to the device and data content */
+	struct mutex		lock;
+	struct notifier_block	nb;
+	/* Reference Divider */
+	unsigned int		ref_div_factor;
+	/* PFD Frequency */
+	unsigned int		f_pfd;
+	/* Input Reference Clock */
+	unsigned int		clkin_freq;
+	/* CLKOUT Divider */
+	u8			clkout_div_sel;
+	/* Feedback Divider (N) */
+	u16			n_int;
+	u16			synth_lock_timeout;
+	u16			vco_alc_timeout;
+	u16			adc_clk_div;
+	u16			vco_band_div;
+	u8			dclk_div1;
+	u8			dclk_div2;
+	u8			dclk_mode;
+	unsigned int		f_div_rclk;
+	enum muxout_select_mode	muxout_select;
+	struct gpio_desc	*gpio_ce;
+	struct gpio_desc	*gpio_enclk1;
+	struct gpio_desc	*gpio_enclk2;
+	u8			buf[2] ____cacheline_aligned;
+};
+
+static const char * const adf4377_muxout_modes[] = {
+	[ADF4377_MUXOUT_HIGH_Z] = "high_z",
+	[ADF4377_MUXOUT_LKDET] = "lock_detect",
+	[ADF4377_MUXOUT_LOW] = "muxout_low",
+	[ADF4377_MUXOUT_DIV_RCLK_2] = "f_div_rclk_2",
+	[ADF4377_MUXOUT_DIV_NCLK_2] = "f_div_nclk_2",
+	[ADF4377_MUXOUT_HIGH] = "muxout_high",
+};
+
+static const struct reg_sequence adf4377_reg_defaults[] = {
+	{0x42,  ADF4377_R042_RSV1},
+	{0x3B,  ADF4377_R03B_RSV1},
+	{0x3A,  ADF4377_R03A_RSV1},
+	{0x34,  ADF4377_R034_RSV1},
+	{0x33,  ADF4377_R033_RSV1},
+	{0x32,  ADF4377_R032_RSV1},
+	{0x31,  ADF4377_R031_RSV1},
+	{0x2C,  ADF4377_R02C_RSV1},
+	{0x25,  ADF4377_R025_RSV1},
+	{0x23,  ADF4377_R023_RSV1},
+	{0x22,  ADF4377_R022_RSV1},
+	{0x21,  ADF4377_R021_RSV1},
+	{0x1f,  ADF4377_R01F_RSV1},
+	{0x1c,  ADF4377_R01C_RSV1},
+};
+
+static const struct regmap_config adf4377_regmap_config = {
+	.reg_bits = 16,
+	.val_bits = 8,
+	.read_flag_mask = BIT(7),
+	.max_register = 0x54,
+};
+
+static int adf4377_reg_access(struct iio_dev *indio_dev,
+			      unsigned int reg,
+			      unsigned int write_val,
+			      unsigned int *read_val)
+{
+	struct adf4377_state *st = iio_priv(indio_dev);
+
+	if (read_val)
+		return regmap_read(st->regmap, reg, read_val);
+
+	return regmap_write(st->regmap, reg, write_val);
+}
+
+static const struct iio_info adf4377_info = {
+	.debugfs_reg_access = &adf4377_reg_access,
+};
+
+static int adf4377_soft_reset(struct adf4377_state *st)
+{
+	unsigned int read_val;
+	int ret;
+
+	ret = regmap_update_bits(st->regmap, 0x0, ADF4377_SOFT_RESET_MSK |
+				 ADF4377_SOFT_RESET_R_MSK,
+				 FIELD_PREP(ADF4377_SOFT_RESET_MSK, 1) |
+				 FIELD_PREP(ADF4377_SOFT_RESET_R_MSK, 1));
+	if (ret)
+		return ret;
+
+	return regmap_read_poll_timeout(st->regmap, 0x0, read_val,
+					!(read_val & (ADF4377_SOFT_RESET_R_MSK |
+					ADF4377_SOFT_RESET_R_MSK)), 200, 200 * 100);
+}
+
+static int adf4377_get_freq(struct adf4377_state *st, u64 *freq)
+{
+	unsigned int ref_div_factor, n_int;
+	u64 clkin_freq;
+	int ret;
+
+	mutex_lock(&st->lock);
+	ret = regmap_read(st->regmap, 0x12, &ref_div_factor);
+	if (ret)
+		goto exit;
+
+	ret = regmap_bulk_read(st->regmap, 0x10, st->buf, sizeof(st->buf));
+	if (ret)
+		goto exit;
+
+	clkin_freq = clk_get_rate(st->clkin);
+	ref_div_factor = FIELD_GET(ADF4377_R_DIV_MSK, ref_div_factor);
+	n_int = FIELD_GET(ADF4377_N_INT_LSB_MSK | ADF4377_N_INT_MSB_MSK,
+			  get_unaligned_le16(&st->buf));
+
+	*freq = div_u64(clkin_freq, ref_div_factor) * n_int;
+exit:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static int adf4377_set_freq(struct adf4377_state *st, u64 freq)
+{
+	unsigned int read_val;
+	u64 f_vco;
+	int ret;
+
+	mutex_lock(&st->lock);
+
+	ret = regmap_update_bits(st->regmap, 0x1C, ADF4377_EN_DNCLK_MSK | ADF4377_EN_DRCLK_MSK,
+				 FIELD_PREP(ADF4377_EN_DNCLK_MSK, 1) |
+				 FIELD_PREP(ADF4377_EN_DRCLK_MSK, 1));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, 0x11, ADF4377_EN_AUTOCAL_MSK | ADF4377_DCLK_DIV2_MSK,
+				 FIELD_PREP(ADF4377_EN_AUTOCAL_MSK, 1) |
+				 FIELD_PREP(ADF4377_DCLK_DIV2_MSK, st->dclk_div2));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, 0x2E, ADF4377_EN_ADC_CNV_MSK | ADF4377_EN_ADC_MSK |
+				 ADF4377_ADC_A_CONV_MSK,
+				 FIELD_PREP(ADF4377_EN_ADC_CNV_MSK, 1) |
+				 FIELD_PREP(ADF4377_EN_ADC_MSK, 1) |
+				 FIELD_PREP(ADF4377_ADC_A_CONV_MSK, ADF4377_ADC_A_CONV_VCO_CALIB));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, 0x20, ADF4377_EN_ADC_CLK_MSK,
+				 FIELD_PREP(ADF4377_EN_ADC_CLK_MSK, 1));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, 0x2F, ADF4377_DCLK_DIV1_MSK,
+				 FIELD_PREP(ADF4377_DCLK_DIV1_MSK, st->dclk_div1));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, 0x24, ADF4377_DCLK_MODE_MSK,
+				 FIELD_PREP(ADF4377_DCLK_MODE_MSK, st->dclk_mode));
+	if (ret)
+		goto exit;
+
+	ret = regmap_write(st->regmap, 0x27,
+			   FIELD_PREP(ADF4377_SYNTH_LOCK_TO_LSB_MSK, st->synth_lock_timeout));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, 0x28, ADF4377_SYNTH_LOCK_TO_MSB_MSK,
+				 FIELD_PREP(ADF4377_SYNTH_LOCK_TO_MSB_MSK,
+					    st->synth_lock_timeout >> 8));
+	if (ret)
+		goto exit;
+
+	ret = regmap_write(st->regmap, 0x29,
+			   FIELD_PREP(ADF4377_VCO_ALC_TO_LSB_MSK, st->vco_alc_timeout));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, 0x2A, ADF4377_VCO_ALC_TO_MSB_MSK,
+				 FIELD_PREP(ADF4377_VCO_ALC_TO_MSB_MSK, st->vco_alc_timeout >> 8));
+	if (ret)
+		goto exit;
+
+	ret = regmap_write(st->regmap, 0x26,
+			   FIELD_PREP(ADF4377_VCO_BAND_DIV_MSK, st->vco_band_div));
+	if (ret)
+		goto exit;
+
+	ret = regmap_write(st->regmap, 0x2D,
+			   FIELD_PREP(ADF4377_ADC_CLK_DIV_MSK, st->adc_clk_div));
+	if (ret)
+		goto exit;
+
+	st->clkout_div_sel = 0;
+
+	if (freq > ADF4377_MAX_CLKPN_FREQ || freq < ADF4377_MIN_CLKPN_FREQ) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	f_vco = freq;
+
+	while (f_vco < ADF4377_MIN_VCO_FREQ) {
+		f_vco <<= 1;
+		st->clkout_div_sel++;
+	}
+
+	st->n_int = div_u64(freq, st->f_pfd);
+
+	ret = regmap_update_bits(st->regmap, 0x11, ADF4377_EN_RDBLR_MSK | ADF4377_N_INT_MSB_MSK,
+				 FIELD_PREP(ADF4377_EN_RDBLR_MSK, 0) |
+				 FIELD_PREP(ADF4377_N_INT_MSB_MSK, st->n_int >> 8));
+	if (ret)
+		goto exit;
+
+	ret = regmap_update_bits(st->regmap, 0x12, ADF4377_R_DIV_MSK | ADF4377_CLKOUT_DIV_MSK,
+				 FIELD_PREP(ADF4377_CLKOUT_DIV_MSK, st->clkout_div_sel) |
+				 FIELD_PREP(ADF4377_R_DIV_MSK, st->ref_div_factor));
+	if (ret)
+		goto exit;
+
+	ret = regmap_write(st->regmap, 0x10,
+			   FIELD_PREP(ADF4377_N_INT_LSB_MSK, st->n_int));
+	if (ret)
+		goto exit;
+
+	ret = regmap_read_poll_timeout(st->regmap, 0x49, read_val,
+				       !(read_val & (ADF4377_FSM_BUSY_MSK)), 200, 200 * 100);
+	if (ret)
+		goto exit;
+
+	/* Disable EN_DNCLK, EN_DRCLK */
+	ret = regmap_update_bits(st->regmap, 0x1C, ADF4377_EN_DNCLK_MSK | ADF4377_EN_DRCLK_MSK,
+				 FIELD_PREP(ADF4377_EN_DNCLK_MSK, 0) |
+				 FIELD_PREP(ADF4377_EN_DRCLK_MSK, 0));
+	if (ret)
+		goto exit;
+
+	/* Disable EN_ADC_CLK */
+	ret = regmap_update_bits(st->regmap, 0x20, ADF4377_EN_ADC_CLK_MSK,
+				 FIELD_PREP(ADF4377_EN_ADC_CLK_MSK, 0));
+	if (ret)
+		goto exit;
+
+	/* Set output Amplitude */
+	ret = regmap_update_bits(st->regmap, 0x19, ADF4377_CLKOUT2_OP_MSK | ADF4377_CLKOUT1_OP_MSK,
+				 FIELD_PREP(ADF4377_CLKOUT1_OP_MSK, ADF4377_CLKOUT_420MV) |
+				 FIELD_PREP(ADF4377_CLKOUT2_OP_MSK, ADF4377_CLKOUT_420MV));
+
+exit:
+	mutex_unlock(&st->lock);
+
+	return ret;
+}
+
+static void adf4377_gpio_init(struct adf4377_state *st)
+{
+	if (st->gpio_ce) {
+		gpiod_set_value(st->gpio_ce, 1);
+
+		/* Delay for SPI register bits to settle to their power-on reset state */
+		fsleep(200);
+	}
+
+	if (st->gpio_enclk1)
+		gpiod_set_value(st->gpio_enclk1, 1);
+
+	if (st->gpio_enclk2)
+		gpiod_set_value(st->gpio_enclk2, 1);
+}
+
+static int adf4377_init(struct adf4377_state *st)
+{
+	struct spi_device *spi = st->spi;
+	int ret;
+
+	adf4377_gpio_init(st);
+
+	ret = adf4377_soft_reset(st);
+	if (ret) {
+		dev_err(&spi->dev, "Failed to soft reset.\n");
+		return ret;
+	}
+
+	ret = regmap_multi_reg_write(st->regmap, adf4377_reg_defaults,
+				     ARRAY_SIZE(adf4377_reg_defaults));
+	if (ret) {
+		dev_err(&spi->dev, "Failed to set default registers.\n");
+		return ret;
+	}
+
+	ret = regmap_update_bits(st->regmap, 0x00,
+				 ADF4377_SDO_ACTIVE_MSK | ADF4377_SDO_ACTIVE_R_MSK,
+				 FIELD_PREP(ADF4377_SDO_ACTIVE_MSK, ADF4377_SDO_ACTIVE_SPI_4W) |
+				 FIELD_PREP(ADF4377_SDO_ACTIVE_R_MSK, ADF4377_SDO_ACTIVE_SPI_4W));
+	if (ret) {
+		dev_err(&spi->dev, "Failed to set 4-Wire Operation.\n");
+		return ret;
+	}
+
+	st->clkin_freq = clk_get_rate(st->clkin);
+
+	/* Power Up */
+	ret = regmap_write(st->regmap, 0x1a,
+			   FIELD_PREP(ADF4377_PD_ALL_MSK, 0) |
+			   FIELD_PREP(ADF4377_PD_RDIV_MSK, 0) |
+			   FIELD_PREP(ADF4377_PD_NDIV_MSK, 0) |
+			   FIELD_PREP(ADF4377_PD_VCO_MSK, 0) |
+			   FIELD_PREP(ADF4377_PD_LD_MSK, 0) |
+			   FIELD_PREP(ADF4377_PD_PFDCP_MSK, 0) |
+			   FIELD_PREP(ADF4377_PD_CLKOUT1_MSK, 0) |
+			   FIELD_PREP(ADF4377_PD_CLKOUT2_MSK, 0));
+	if (ret) {
+		dev_err(&spi->dev, "Failed to set power down registers.\n");
+		return ret;
+	}
+
+	/* Set Mux Output */
+	ret = regmap_update_bits(st->regmap, 0x1D,
+				 ADF4377_MUXOUT_MSK,
+				 FIELD_PREP(ADF4377_MUXOUT_MSK, st->muxout_select));
+	if (ret)
+		return ret;
+
+	/* Compute PFD */
+	st->ref_div_factor = 0;
+	do {
+		st->ref_div_factor++;
+		st->f_pfd = st->clkin_freq / st->ref_div_factor;
+	} while (st->f_pfd > ADF4377_MAX_FREQ_PFD);
+
+	if (st->f_pfd > ADF4377_MAX_FREQ_PFD || st->f_pfd < ADF4377_MIN_FREQ_PFD)
+		return -EINVAL;
+
+	st->f_div_rclk = st->f_pfd;
+
+	if (st->f_pfd <= ADF4377_FREQ_PFD_80MHZ) {
+		st->dclk_div1 = ADF4377_DCLK_DIV1_1;
+		st->dclk_div2 = ADF4377_DCLK_DIV2_1;
+		st->dclk_mode = 0;
+	} else if (st->f_pfd <= ADF4377_FREQ_PFD_125MHZ) {
+		st->dclk_div1 = ADF4377_DCLK_DIV1_1;
+		st->dclk_div2 = ADF4377_DCLK_DIV2_1;
+		st->dclk_mode = 1;
+	} else if (st->f_pfd <= ADF4377_FREQ_PFD_160MHZ) {
+		st->dclk_div1 = ADF4377_DCLK_DIV1_2;
+		st->dclk_div2 = ADF4377_DCLK_DIV2_1;
+		st->dclk_mode = 0;
+		st->f_div_rclk /= 2;
+	} else if (st->f_pfd <= ADF4377_FREQ_PFD_250MHZ) {
+		st->dclk_div1 = ADF4377_DCLK_DIV1_2;
+		st->dclk_div2 = ADF4377_DCLK_DIV2_1;
+		st->dclk_mode = 1;
+		st->f_div_rclk /= 2;
+	} else if (st->f_pfd <= ADF4377_FREQ_PFD_320MHZ) {
+		st->dclk_div1 = ADF4377_DCLK_DIV1_2;
+		st->dclk_div2 = ADF4377_DCLK_DIV2_2;
+		st->dclk_mode = 0;
+		st->f_div_rclk /= 4;
+	} else {
+		st->dclk_div1 = ADF4377_DCLK_DIV1_2;
+		st->dclk_div2 = ADF4377_DCLK_DIV2_2;
+		st->dclk_mode = 1;
+		st->f_div_rclk /= 4;
+	}
+
+	st->synth_lock_timeout = DIV_ROUND_UP(st->f_div_rclk, 50000);
+	st->vco_alc_timeout = DIV_ROUND_UP(st->f_div_rclk, 20000);
+	st->vco_band_div = DIV_ROUND_UP(st->f_div_rclk, 150000 * 16 * (1 << st->dclk_mode));
+	st->adc_clk_div = DIV_ROUND_UP((st->f_div_rclk / 400000 - 2), 4);
+
+	return 0;
+}
+
+static ssize_t adf4377_read(struct iio_dev *indio_dev, uintptr_t private,
+			    const struct iio_chan_spec *chan, char *buf)
+{
+	struct adf4377_state *st = iio_priv(indio_dev);
+	u64 val = 0;
+
+	switch ((u32)private) {
+	case ADF4377_FREQ:
+		return adf4377_get_freq(st, &val) ?: sysfs_emit(buf, "%llu\n", val);
+	default:
+		val = 0;
+		return -EINVAL;
+	}
+}
+
+static ssize_t adf4377_write(struct iio_dev *indio_dev, uintptr_t private,
+			     const struct iio_chan_spec *chan, const char *buf,
+			     size_t len)
+{
+	struct adf4377_state *st = iio_priv(indio_dev);
+	unsigned long long freq;
+	int ret;
+
+	switch ((u32)private) {
+	case ADF4377_FREQ:
+		ret = kstrtoull(buf, 10, &freq);
+		if (ret)
+			return ret;
+
+		return adf4377_set_freq(st, freq) ?: len;
+	default:
+		return -EINVAL;
+	}
+}
+
+#define _ADF4377_EXT_INFO(_name, _shared, _ident) { \
+		.name = _name, \
+		.read = adf4377_read, \
+		.write = adf4377_write, \
+		.private = _ident, \
+		.shared = _shared, \
+	}
+
+static const struct iio_chan_spec_ext_info adf4377_ext_info[] = {
+	/*
+	 * Usually we use IIO_CHAN_INFO_FREQUENCY, but there are
+	 * values > 2^32 in order to support the entire frequency range
+	 * in Hz.
+	 */
+	_ADF4377_EXT_INFO("frequency", IIO_SEPARATE, ADF4377_FREQ),
+	{ },
+};
+
+static const struct iio_chan_spec adf4377_channels[] = {
+	{
+		.type = IIO_ALTVOLTAGE,
+		.indexed = 1,
+		.output = 1,
+		.channel = 0,
+		.ext_info = adf4377_ext_info,
+	},
+};
+
+static int adf4377_properties_parse(struct adf4377_state *st)
+{
+	struct spi_device *spi = st->spi;
+	const char *str;
+	int ret;
+
+	st->clkin = devm_clk_get_enabled(&spi->dev, "ref_in");
+	if (IS_ERR(st->clkin))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->clkin),
+				     "failed to get the reference input clock\n");
+
+	st->gpio_ce = devm_gpiod_get_optional(&st->spi->dev, "chip-enable",
+					      GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_ce))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_ce),
+				     "failed to get the CE GPIO\n");
+
+	st->gpio_enclk1 = devm_gpiod_get_optional(&st->spi->dev, "clk1-enable",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_enclk1))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk1),
+				     "failed to get the CE GPIO\n");
+
+	st->gpio_enclk2 = devm_gpiod_get_optional(&st->spi->dev, "clk2-enable",
+						  GPIOD_OUT_LOW);
+	if (IS_ERR(st->gpio_enclk2))
+		return dev_err_probe(&spi->dev, PTR_ERR(st->gpio_enclk2),
+				     "failed to get the CE GPIO\n");
+
+	ret = device_property_read_string(&spi->dev, "adi,muxout-select", &str);
+	if (ret) {
+		st->muxout_select = ADF4377_MUXOUT_HIGH_Z;
+	} else {
+		ret = match_string(adf4377_muxout_modes, ARRAY_SIZE(adf4377_muxout_modes), str);
+		if (ret < 0)
+			return ret;
+
+		st->muxout_select = ret;
+	}
+
+	return 0;
+}
+
+static int adf4377_freq_change(struct notifier_block *nb, unsigned long action, void *data)
+{
+	struct adf4377_state *st = container_of(nb, struct adf4377_state, nb);
+	int ret;
+
+	if (action == POST_RATE_CHANGE) {
+		mutex_lock(&st->lock);
+		ret = notifier_from_errno(adf4377_init(st));
+		mutex_unlock(&st->lock);
+		return ret;
+	}
+
+	return NOTIFY_OK;
+}
+
+static int adf4377_probe(struct spi_device *spi)
+{
+	struct iio_dev *indio_dev;
+	struct regmap *regmap;
+	struct adf4377_state *st;
+	int ret;
+
+	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
+	if (!indio_dev)
+		return -ENOMEM;
+
+	regmap = devm_regmap_init_spi(spi, &adf4377_regmap_config);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	st = iio_priv(indio_dev);
+
+	indio_dev->info = &adf4377_info;
+	indio_dev->name = "adf4377";
+	indio_dev->channels = adf4377_channels;
+	indio_dev->num_channels = ARRAY_SIZE(adf4377_channels);
+
+	st->regmap = regmap;
+	st->spi = spi;
+	mutex_init(&st->lock);
+
+	ret = adf4377_properties_parse(st);
+	if (ret)
+		return ret;
+
+	st->nb.notifier_call = adf4377_freq_change;
+	ret = devm_clk_notifier_register(&spi->dev, st->clkin, &st->nb);
+	if (ret)
+		return ret;
+
+	ret = adf4377_init(st);
+	if (ret)
+		return ret;
+
+	return devm_iio_device_register(&spi->dev, indio_dev);
+}
+
+static const struct spi_device_id adf4377_id[] = {
+	{ "adf4377", 0 },
+	{}
+};
+MODULE_DEVICE_TABLE(spi, adf4377_id);
+
+static const struct of_device_id adf4377_of_match[] = {
+	{ .compatible = "adi,adf4377" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, adf4377_of_match);
+
+static struct spi_driver adf4377_driver = {
+	.driver = {
+		.name = "adf4377",
+		.of_match_table = adf4377_of_match,
+	},
+	.probe = adf4377_probe,
+	.id_table = adf4377_id,
+};
+module_spi_driver(adf4377_driver);
+
+MODULE_AUTHOR("Antoniu Miclaus <antoniu.miclaus@analog.com>");
+MODULE_DESCRIPTION("Analog Devices ADF4377");
+MODULE_LICENSE("GPL");
-- 
2.38.1

