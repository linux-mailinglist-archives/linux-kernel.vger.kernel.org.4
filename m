Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F305ED31F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 04:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiI1Cnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 22:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbiI1Cnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 22:43:37 -0400
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7711110D0D3;
        Tue, 27 Sep 2022 19:43:34 -0700 (PDT)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28RNcPWr015337;
        Wed, 28 Sep 2022 02:43:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=u1hZPdNWwkuzavTirvSzj+u04+i8bvlJMyqIrdrvUo8=;
 b=ShxyulI74GaXmUXJYt85mDts3GzymEVckF/wLqILBblmlHijCtVW60GR3k0AE0IZCIRd
 Mwkv/m3cXaqHw78g/DUdJRy9HD46rGTzEAr0OHIeyBWwbStSAg3Pxvs68qSQmJWJYbsV
 l3W0TUn7GfXaV/nwF3ofIZ4GeeKi2xPkJ1WfK4g1ieIKNYTSzmbKj/dlt2wzlyBDyqjo
 3ibsmPqfZoC7skFFqMYqm0kZ61T/nJ4w7ttT0AlOYktJLJzzvSrMV0T0fVw4oxREVDSG
 deUYYZ5WmzhU03FZ/2PtPnJgdlq0IC3oEDfPNQd/3WwmrY3LVUVi/AHCOtio2No16eK0 eQ== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3juqj0c70j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 02:43:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
        by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 28S2hPU4004592
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Sep 2022 02:43:25 GMT
Received: from fenglinw2-gv.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.29; Tue, 27 Sep 2022 19:43:22 -0700
From:   Fenglin Wu <quic_fenglinw@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Pavel Machek" <pavel@ucw.cz>, Gene Chen <gene_chen@richtek.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Fenglin Wu <quic_fenglinw@quicinc.com>,
        <linux-leds@vger.kernel.org>
CC:     <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>
Subject: [PATCH v1 1/2] leds: flash: add driver to support flash LED module in QCOM PMICs
Date:   Wed, 28 Sep 2022 10:42:38 +0800
Message-ID: <20220928024239.3843909-2-quic_fenglinw@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220928024239.3843909-1-quic_fenglinw@quicinc.com>
References: <20220928024239.3843909-1-quic_fenglinw@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6zu4Lc4HBwVdH3lEjruqd8uzB6c-anyr
X-Proofpoint-GUID: 6zu4Lc4HBwVdH3lEjruqd8uzB6c-anyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-27_12,2022-09-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 priorityscore=1501 adultscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999
 spamscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2209280015
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial driver to support flash LED module found in Qualcomm
Technologies, Inc. PMICs. The flash module can have 3 or 4 channels
and each channel can be controlled indepedently and support full scale
current up to 1.5 A. It also supports connecting two channels together
to supply one LED component with full scale current up to 2 A. In that
case, the current will be split on each channel symmetrically and the
channels will be enabled and disabled at the same time.

Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
---
 drivers/leds/flash/Kconfig           |  14 +
 drivers/leds/flash/Makefile          |   1 +
 drivers/leds/flash/leds-qcom-flash.c | 706 +++++++++++++++++++++++++++
 3 files changed, 721 insertions(+)
 create mode 100644 drivers/leds/flash/leds-qcom-flash.c

diff --git a/drivers/leds/flash/Kconfig b/drivers/leds/flash/Kconfig
index d3eb689b193c..92773fa872dc 100644
--- a/drivers/leds/flash/Kconfig
+++ b/drivers/leds/flash/Kconfig
@@ -61,6 +61,20 @@ config LEDS_MT6360
 	  Independent current sources supply for each flash LED support torch
 	  and strobe mode.
 
+config LEDS_QCOM_FLASH
+	tristate "LED support for flash module inside Qualcomm Technologies, Inc. PMIC"
+	depends on MFD_SPMI_PMIC
+	depends on LEDS_CLASS && OF
+	depends on V4L2_FLASH_LED_CLASS || !V4L2_FLASH_LED_CLASS
+	help
+	  This option enables support for the flash module found in Qualcomm
+	  Technologies, Inc. PMICs. The flash module can have 3 or 4 flash LED
+	  channels and each channel is programmable to support up to 1.5 A full
+	  scale current. It also supports connecting two channels' output together
+	  to supply one LED component to achieve current up to 2 A. In such case,
+	  the total LED current will be split symmetrically on each channel and
+	  they will be enabled/disabled at the same time.
+
 config LEDS_RT4505
 	tristate "LED support for RT4505 flashlight controller"
 	depends on I2C && OF
diff --git a/drivers/leds/flash/Makefile b/drivers/leds/flash/Makefile
index 0acbddc0b91b..8a60993f1a25 100644
--- a/drivers/leds/flash/Makefile
+++ b/drivers/leds/flash/Makefile
@@ -6,6 +6,7 @@ obj-$(CONFIG_LEDS_AS3645A)	+= leds-as3645a.o
 obj-$(CONFIG_LEDS_KTD2692)	+= leds-ktd2692.o
 obj-$(CONFIG_LEDS_LM3601X)	+= leds-lm3601x.o
 obj-$(CONFIG_LEDS_MAX77693)	+= leds-max77693.o
+obj-$(CONFIG_LEDS_QCOM_FLASH)	+= leds-qcom-flash.o
 obj-$(CONFIG_LEDS_RT4505)	+= leds-rt4505.o
 obj-$(CONFIG_LEDS_RT8515)	+= leds-rt8515.o
 obj-$(CONFIG_LEDS_SGM3140)	+= leds-sgm3140.o
diff --git a/drivers/leds/flash/leds-qcom-flash.c b/drivers/leds/flash/leds-qcom-flash.c
new file mode 100644
index 000000000000..d974958843bf
--- /dev/null
+++ b/drivers/leds/flash/leds-qcom-flash.c
@@ -0,0 +1,706 @@
+//SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include <linux/bitops.h>
+#include <linux/leds.h>
+#include <linux/led-class-flash.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <media/v4l2-flash-led-class.h>
+
+/* registers definitions */
+#define FLASH_TYPE_REG			0x04
+#define FLASH_TYPE_VAL			0x18
+
+#define FLASH_SUBTYPE_REG		0x05
+#define FLASH_SUBTYPE_3CH_VAL		0x04
+#define FLASH_SUBTYPE_4CH_VAL		0x07
+
+#define FLASH_MODULE_EN_BIT		BIT(7)
+
+#define FLASH_TIMER_EN_BIT		BIT(7)
+#define FLASH_TIMER_VAL_MASK		GENMASK(6, 0)
+#define FLASH_TIMER_STEP_MS		10
+
+#define FLASH_ITARGET_CURRENT_MASK	GENMASK(6, 0)
+
+#define FLASH_STROBE_HW_SW_SEL_BIT	BIT(2)
+#define SW_STROBE_VAL			0
+#define HW_STROBE_VAL			1
+#define FLASH_HW_STROBE_TRIGGER_SEL_BIT	BIT(1)
+#define STROBE_LEVEL_TRIGGER_VAL	0
+#define STROBE_EDGE_TRIGGER_VAL		1
+#define FLASH_STROBE_POLARITY_BIT	BIT(0)
+#define STROBE_ACTIVE_HIGH_VAL		1
+
+#define FLASH_IRES_MASK_4CH		BIT(0)
+#define FLASH_IRES_MASK_3CH		GENMASK(1, 0)
+#define FLASH_IRES_12P5MA_VAL		0
+#define FLASH_IRES_5MA_VAL_4CH		1
+#define FLASH_IRES_5MA_VAL_3CH		3
+
+/* constants */
+#define FLASH_CURRENT_MAX_UA		1500000
+#define TORCH_CURRENT_MAX_UA		500000
+#define FLASH_TOTAL_CURRENT_MAX_UA	2000000
+#define FLASH_CURRENT_DEFAULT_UA	1000000
+#define TORCH_CURRENT_DEFAULT_UA	200000
+
+#define TORCH_IRES_UA			5000
+#define FLASH_IRES_UA			12500
+
+#define FLASH_TIMEOUT_MAX_US		1280000
+#define FLASH_TIMEOUT_STEP_US		10000
+
+enum hw_type {
+	QCOM_MVFLASH_3CH,
+	QCOM_MVFLASH_4CH,
+};
+
+enum led_mode {
+	FLASH_MODE,
+	TORCH_MODE,
+};
+
+enum led_strobe {
+	SW_STROBE,
+	HW_STROBE,
+};
+
+struct qcom_flash_reg {
+	u8 module_en;
+	u8 chan_timer;
+	u8 itarget;
+	u8 iresolution;
+	u8 chan_strobe;
+	u8 chan_en;
+	u8 status1;
+	u8 status2;
+	u8 status3;
+};
+
+struct qcom_flash_led {
+	struct qcom_flash_chip		*chip;
+	struct led_classdev_flash	flash;
+	struct v4l2_flash		*v4l2_flash;
+	u32				max_flash_current_ma;
+	u32				max_torch_current_ma;
+	u32				max_timeout_ms;
+	u32				flash_current_ma;
+	u32				flash_timeout_ms;
+	u8				*chan_id;
+	u8				chan_count;
+	bool				enabled;
+};
+
+struct qcom_flash_chip {
+	struct qcom_flash_led		*leds;
+	const struct qcom_flash_reg	*reg;
+	struct device			*dev;
+	struct regmap			*regmap;
+	struct mutex			lock;
+	enum hw_type			hw_type;
+	u32				reg_base;
+	u8				leds_count;
+	u8				max_channels;
+	u8				chan_en_bits;
+};
+
+static const struct qcom_flash_reg mvflash_3ch_reg = {
+	.chan_timer	= 0x40,
+	.itarget	= 0x43,
+	.module_en	= 0x46,
+	.iresolution	= 0x47,
+	.chan_strobe	= 0x49,
+	.chan_en	= 0x4c,
+	.status1	= 0x08,
+	.status2	= 0x09,
+	.status3	= 0x0a,
+};
+
+static const struct qcom_flash_reg mvflash_4ch_reg = {
+	.chan_timer	= 0x3e,
+	.itarget	= 0x42,
+	.module_en	= 0x46,
+	.iresolution	= 0x49,
+	.chan_strobe	= 0x4a,
+	.chan_en	= 0x4e,
+	.status1	= 0x06,
+	.status2	= 0x07,
+	.status3	= 0x09,
+};
+
+static int __set_flash_module_en(struct qcom_flash_led *led, bool en)
+{
+	struct qcom_flash_chip *chip = led->chip;
+	u8 led_mask = 0, val;
+	int i, rc;
+
+	for (i = 0; i < led->chan_count; i++)
+		led_mask |= BIT(led->chan_id[i] - 1);
+
+	mutex_lock(&chip->lock);
+	if (en)
+		chip->chan_en_bits |= led_mask;
+	else
+		chip->chan_en_bits &= ~led_mask;
+
+	val = (!!chip->chan_en_bits) ? FLASH_MODULE_EN_BIT : 0;
+	rc = regmap_update_bits(chip->regmap, chip->reg_base + chip->reg->module_en,
+				FLASH_MODULE_EN_BIT, val);
+	mutex_unlock(&chip->lock);
+
+	return rc;
+}
+
+static int __set_flash_current(struct qcom_flash_led *led, u32 current_ma, enum led_mode mode)
+{
+	struct qcom_flash_chip *chip = led->chip;
+	u32 itarg_ua = current_ma * 1000 / led->chan_count + 1;
+	u32 ires_ua = (mode == FLASH_MODE) ? FLASH_IRES_UA : TORCH_IRES_UA;
+	u8 reg, val, shift, ires_mask = 0, ires_val = 0, chan_id;
+	int i, rc;
+
+	/*
+	 * Split the current across the channels and set the
+	 * IRESOLUTION and ITARGET registers accordingly.
+	 */
+	for (i = 0; i < led->chan_count; i++) {
+		chan_id = led->chan_id[i];
+		if (itarg_ua < ires_ua)
+			val = 0;
+		else
+			val = itarg_ua / ires_ua - 1;
+
+		reg = chip->reg->itarget + chan_id - 1;
+		rc = regmap_update_bits(chip->regmap, chip->reg_base + reg,
+				FLASH_ITARGET_CURRENT_MASK, val);
+		if (rc < 0)
+			return rc;
+
+		if (chip->hw_type == QCOM_MVFLASH_3CH) {
+			shift = (chan_id - 1) * 2;
+			ires_mask |= FLASH_IRES_MASK_3CH << shift;
+			ires_val |= ((mode == FLASH_MODE) ?
+				(FLASH_IRES_12P5MA_VAL << shift) :
+				(FLASH_IRES_5MA_VAL_3CH << shift));
+		} else if (chip->hw_type == QCOM_MVFLASH_4CH) {
+			shift = chan_id - 1;
+			ires_mask |= FLASH_IRES_MASK_4CH << shift;
+			ires_val |= ((mode == FLASH_MODE) ?
+				(FLASH_IRES_12P5MA_VAL << shift) :
+				(FLASH_IRES_5MA_VAL_4CH << shift));
+		}
+	}
+
+	reg = chip->reg->iresolution;
+
+	return regmap_update_bits(chip->regmap, chip->reg_base + reg, ires_mask, ires_val);
+}
+
+static int __set_flash_timeout(struct qcom_flash_led *led, u32 timeout_ms)
+{
+	struct qcom_flash_chip *chip = led->chip;
+	u8 reg, mask, val, chan_id;
+	int rc, i;
+
+	/* set SAFETY_TIMER for all the channels connected to the same LED */
+	timeout_ms = min_t(u32, timeout_ms, led->max_timeout_ms);
+	for (i = 0; i < led->chan_count; i++) {
+		chan_id = led->chan_id[i];
+		mask = 0xff;
+		val = timeout_ms / FLASH_TIMER_STEP_MS;
+		val = clamp_t(u8, val, 0, FLASH_TIMER_VAL_MASK);
+		if (timeout_ms)
+			val |= FLASH_TIMER_EN_BIT;
+
+		reg = chip->reg->chan_timer + chan_id - 1;
+		rc = regmap_update_bits(chip->regmap, chip->reg_base + reg, mask, val);
+		if (rc < 0)
+			return rc;
+
+	}
+
+	return 0;
+}
+
+static int __set_flash_strobe(struct qcom_flash_led *led, enum led_strobe strobe, bool state)
+{
+	struct qcom_flash_chip *chip = led->chip;
+	u8 reg, mask, val, chan_id = 0, chan_mask = 0;
+	int rc, i;
+
+	/* Set SW strobe config for all channels connected to the LED */
+	for (i = 0; i < led->chan_count; i++) {
+		chan_id = led->chan_id[i];
+		mask = FLASH_STROBE_HW_SW_SEL_BIT | FLASH_HW_STROBE_TRIGGER_SEL_BIT
+			| FLASH_STROBE_POLARITY_BIT;
+		if (strobe == SW_STROBE)
+			val = FIELD_PREP(FLASH_STROBE_HW_SW_SEL_BIT, SW_STROBE_VAL);
+		else
+			val = FIELD_PREP(FLASH_STROBE_HW_SW_SEL_BIT, HW_STROBE_VAL);
+
+		val |= FIELD_PREP(FLASH_HW_STROBE_TRIGGER_SEL_BIT, STROBE_LEVEL_TRIGGER_VAL) |
+			FIELD_PREP(FLASH_STROBE_POLARITY_BIT, STROBE_ACTIVE_HIGH_VAL);
+		reg = chip->reg->chan_strobe + chan_id - 1;
+		rc = regmap_update_bits(chip->regmap, chip->reg_base + reg, mask, val);
+		if (rc < 0)
+			return rc;
+
+		chan_mask |= BIT(chan_id - 1);
+	}
+
+	/* enable/disable flash channels */
+	mask = chan_mask;
+	val = state ? mask : 0;
+	reg = chip->reg->chan_en;
+	rc = regmap_update_bits(chip->regmap, chip->reg_base + reg, mask, val);
+	if (rc < 0)
+		return rc;
+
+	led->enabled = state;
+	return 0;
+}
+
+static int qcom_flash_brightness_set(struct led_classdev_flash *fled_cdev, u32 brightness)
+{
+	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
+
+	led->flash_current_ma = min_t(u32, led->max_flash_current_ma, brightness / 1000);
+	return 0;
+}
+
+static int qcom_flash_timeout_set(struct led_classdev_flash *fled_cdev, u32 timeout)
+{
+	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
+
+	led->flash_timeout_ms = timeout / 1000;
+	return 0;
+}
+
+static int qcom_flash_strobe_set(struct led_classdev_flash *fled_cdev, bool state)
+{
+	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
+	int rc;
+
+	rc = __set_flash_current(led, led->flash_current_ma, FLASH_MODE);
+	if (rc < 0)
+		return rc;
+
+	rc = __set_flash_timeout(led, led->flash_timeout_ms);
+	if (rc < 0)
+		return rc;
+
+	rc = __set_flash_module_en(led, state);
+	if (rc < 0)
+		return rc;
+
+	return __set_flash_strobe(led, SW_STROBE, state);
+}
+
+static int qcom_flash_strobe_get(struct led_classdev_flash *fled_cdev, bool *state)
+{
+	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
+
+	*state = led->enabled;
+	return 0;
+}
+
+static int qcom_flash_fault_get(struct led_classdev_flash *fled_cdev, u32 *fault)
+{
+	struct qcom_flash_led *led = container_of(fled_cdev, struct qcom_flash_led, flash);
+	struct qcom_flash_chip *chip = led->chip;
+	u8 shift, chan_id = 0, chan_mask = 0;
+	u8 ot_mask = 0, oc_mask = 0, uv_mask = 0;
+	u32 val, fault_sts = 0;
+	int i, rc;
+
+	rc = regmap_read(chip->regmap, chip->reg_base + chip->reg->status1, &val);
+	if (rc < 0)
+		return rc;
+
+	for (i = 0; i < led->chan_count; i++) {
+		chan_id = led->chan_id[i];
+		shift = (chan_id - 1) * 2;
+		if (val & BIT(shift))
+			fault_sts |= LED_FAULT_SHORT_CIRCUIT;
+		chan_mask |= BIT(chan_id - 1);
+	}
+
+	rc = regmap_read(chip->regmap, chip->reg_base + chip->reg->status2, &val);
+	if (rc < 0)
+		return rc;
+
+	if (chip->hw_type == QCOM_MVFLASH_3CH) {
+		ot_mask = 0x0f;
+		oc_mask = 0xe0;
+		uv_mask = 0x10;
+	} else if (chip->hw_type == QCOM_MVFLASH_4CH) {
+		ot_mask = 0x70;
+		oc_mask = 0x0e;
+		uv_mask = 0x01;
+	}
+
+	if (val & ot_mask)
+		fault_sts |= LED_FAULT_OVER_TEMPERATURE;
+	if (val & oc_mask)
+		fault_sts |= LED_FAULT_OVER_CURRENT;
+	if (val & uv_mask)
+		fault_sts |= LED_FAULT_INPUT_VOLTAGE;
+
+	rc = regmap_read(chip->regmap, chip->reg_base + chip->reg->status3, &val);
+	if (rc < 0)
+		return rc;
+
+	if (chip->hw_type == QCOM_MVFLASH_3CH) {
+		if (val & chan_mask)
+			fault_sts |= LED_FAULT_TIMEOUT;
+	} else if (chip->hw_type == QCOM_MVFLASH_4CH) {
+		for (i = 0; i < led->chan_count; i++) {
+			chan_id = led->chan_id[i];
+			shift = (chan_id - 1) * 2;
+			if (val & BIT(shift))
+				fault_sts |= LED_FAULT_TIMEOUT;
+		}
+	}
+
+	*fault = fault_sts;
+	return 0;
+}
+
+static int qcom_flash_led_brightness_set(struct led_classdev *led_cdev,
+					enum led_brightness brightness)
+{
+	struct led_classdev_flash *fled_cdev =
+		container_of(led_cdev, struct led_classdev_flash, led_cdev);
+	struct qcom_flash_led *led =
+		container_of(fled_cdev, struct qcom_flash_led, flash);
+	u32 current_ma = brightness * led->max_torch_current_ma / LED_FULL;
+	bool enable = !!brightness;
+	int rc;
+
+	rc = __set_flash_current(led, current_ma, TORCH_MODE);
+	if (rc < 0)
+		return rc;
+
+	/* disable flash timeout for torch LED */
+	rc = __set_flash_timeout(led, 0);
+	if (rc < 0)
+		return rc;
+
+	rc = __set_flash_module_en(led, enable);
+	if (rc < 0)
+		return rc;
+
+	return __set_flash_strobe(led, SW_STROBE, enable);
+}
+
+static const struct led_flash_ops qcom_flash_ops = {
+	.flash_brightness_set = qcom_flash_brightness_set,
+	.strobe_set = qcom_flash_strobe_set,
+	.strobe_get = qcom_flash_strobe_get,
+	.timeout_set = qcom_flash_timeout_set,
+	.fault_get = qcom_flash_fault_get,
+};
+
+#if IS_ENABLED(CONFIG_V4L2_FLASH_LED_CLASS)
+static int qcom_flash_external_strobe_set(struct v4l2_flash *v4l2_flash, bool enable)
+{
+	struct led_classdev_flash *flash = v4l2_flash->fled_cdev;
+	struct qcom_flash_led *led = container_of(flash, struct qcom_flash_led, flash);
+	int rc;
+
+	rc = __set_flash_module_en(led, enable);
+	if (rc < 0)
+		return rc;
+
+	if (enable)
+		return __set_flash_strobe(led, HW_STROBE, true);
+	else
+		return __set_flash_strobe(led, SW_STROBE, false);
+}
+
+static enum led_brightness qcom_flash_intensity_to_led_brightness(
+		struct v4l2_flash *v4l2_flash, s32 intensity)
+{
+	struct led_classdev_flash *flash = v4l2_flash->fled_cdev;
+	struct qcom_flash_led *led = container_of(flash, struct qcom_flash_led, flash);
+	u32 current_ma = intensity / 1000;
+
+	current_ma = min_t(u32, current_ma, led->max_torch_current_ma);
+	if (!current_ma)
+		return LED_OFF;
+
+	return current_ma * LED_FULL / led->max_torch_current_ma;
+}
+
+static s32 qcom_flash_brightness_to_led_intensity(struct v4l2_flash *v4l2_flash,
+					enum led_brightness brightness)
+{
+	struct led_classdev_flash *flash = v4l2_flash->fled_cdev;
+	struct qcom_flash_led *led = container_of(flash, struct qcom_flash_led, flash);
+
+	return (brightness * led->max_torch_current_ma * 1000) / LED_FULL;
+}
+
+static const struct v4l2_flash_ops qcom_v4l2_flash_ops = {
+	.external_strobe_set = qcom_flash_external_strobe_set,
+	.intensity_to_led_brightness = qcom_flash_intensity_to_led_brightness,
+	.led_brightness_to_intensity = qcom_flash_brightness_to_led_intensity,
+};
+
+static int qcom_flash_v4l2_init(struct qcom_flash_led *led, struct fwnode_handle *fwnode)
+{
+	struct v4l2_flash_config v4l2_cfg = {0};
+	struct led_flash_setting *s = &v4l2_cfg.intensity;
+
+	if (!(led->flash.led_cdev.flags & LED_DEV_CAP_FLASH))
+		return 0;
+
+	s->min = s->step = TORCH_IRES_UA * led->chan_count;
+	s->max = led->max_torch_current_ma * 1000;
+	s->val = min_t(u32, s->max, TORCH_CURRENT_DEFAULT_UA);
+
+	strscpy(v4l2_cfg.dev_name, led->flash.led_cdev.dev->kobj.name,
+					sizeof(v4l2_cfg.dev_name));
+	v4l2_cfg.has_external_strobe = 1;
+	v4l2_cfg.flash_faults = LED_FAULT_INPUT_VOLTAGE | LED_FAULT_OVER_CURRENT |
+		LED_FAULT_SHORT_CIRCUIT | LED_FAULT_OVER_TEMPERATURE | LED_FAULT_TIMEOUT;
+
+	led->v4l2_flash = v4l2_flash_init(led->chip->dev, fwnode, &led->flash,
+					&qcom_v4l2_flash_ops, &v4l2_cfg);
+	return PTR_ERR_OR_ZERO(led->v4l2_flash);
+}
+# else
+static int qcom_flash_v4l2_init(struct qcom_flash_led *led, struct fwnode_handle *fwnode)
+{
+	return 0;
+}
+#endif
+
+static int qcom_flash_register_led_device(struct device *parent,
+		struct fwnode_handle *node, struct qcom_flash_led *led)
+{
+	struct qcom_flash_chip *chip = led->chip;
+	struct led_init_data init_data;
+	struct led_classdev_flash *flash;
+	struct led_flash_setting *s;
+	u32 count, val;
+	u32 channels[4];
+	int i, rc;
+
+	flash = &led->flash;
+	count = fwnode_property_count_u32(node, "led-sources");
+	if (count <= 0) {
+		dev_err(chip->dev, "No led-sources specified\n");
+		return -ENODEV;
+	}
+
+	if (count > chip->max_channels) {
+		dev_err(chip->dev, "led-sources count %u exceeds maximum channel count %u\n",
+				count, chip->max_channels);
+		return -EINVAL;
+	}
+
+	rc = fwnode_property_read_u32_array(node, "led-sources", channels, count);
+	if (rc < 0) {
+		dev_err(chip->dev, "get led-sources failed, rc=%d\n", rc);
+		return rc;
+	}
+
+	led->chan_count = count;
+	led->chan_id = devm_kcalloc(chip->dev, count, sizeof(u8), GFP_KERNEL);
+	if (!led->chan_id)
+		return -ENOMEM;
+
+	for (i = 0; i < count; i++) {
+		if (channels[i] > chip->max_channels) {
+			dev_err(chip->dev, "led-source out of HW support range [1-%u]\n",
+					chip->max_channels);
+			return -EINVAL;
+		}
+
+		led->chan_id[i] = channels[i];
+	}
+
+	rc = fwnode_property_read_u32(node, "led-max-microamp", &val);
+	if (rc < 0) {
+		dev_err(chip->dev, "Get led-max-microamp failed, rc=%d\n", rc);
+		return rc;
+	}
+
+	if (!val) {
+		dev_err(chip->dev, "led-max-microamp shouldn't be 0\n");
+		return -EINVAL;
+	}
+
+	val = min_t(u32, val, TORCH_CURRENT_MAX_UA * led->chan_count);
+	led->max_torch_current_ma = val / 1000;
+
+	if (fwnode_property_present(node, "flash-max-microamp")) {
+		flash->led_cdev.flags |= LED_DEV_CAP_FLASH;
+		rc = fwnode_property_read_u32(node, "flash-max-microamp", &val);
+		if (rc < 0) {
+			dev_err(chip->dev, "Get flash-max-microamp failed, rc=%d\n", rc);
+			return rc;
+		}
+
+		val = min_t(u32, val, FLASH_CURRENT_MAX_UA * led->chan_count);
+		val = min_t(u32, val, FLASH_TOTAL_CURRENT_MAX_UA);
+		s = &flash->brightness;
+		s->min = s->step = FLASH_IRES_UA * led->chan_count;
+		s->max = val;
+		s->val = min_t(u32, val, FLASH_CURRENT_DEFAULT_UA);
+		led->max_flash_current_ma = val / 1000;
+		led->flash_current_ma = s->val / 1000;
+
+		rc = fwnode_property_read_u32(node, "flash-max-timeout-us", &val);
+		if (rc < 0) {
+			dev_err(chip->dev, "Get flash-max-timeout-us failed, rc=%d\n", rc);
+			return rc;
+		}
+
+		val = min_t(u32, val, FLASH_TIMEOUT_MAX_US);
+		s = &flash->timeout;
+		s->min = s->step = FLASH_TIMEOUT_STEP_US;
+		s->val = s->max = val;
+		led->max_timeout_ms = led->flash_timeout_ms = val / 1000;
+
+		flash->ops = &qcom_flash_ops;
+	}
+
+	flash->led_cdev.brightness_set_blocking = qcom_flash_led_brightness_set;
+	init_data.fwnode = node;
+	init_data.devicename = NULL;
+	init_data.default_label = NULL;
+	init_data.devname_mandatory = false;
+	rc = devm_led_classdev_flash_register_ext(parent, flash, &init_data);
+	if (rc < 0) {
+		dev_err(chip->dev, "Register flash LED classdev failed, rc=%d\n", rc);
+		return rc;
+	}
+
+	return qcom_flash_v4l2_init(led, node);
+}
+
+static int qcom_flash_led_probe(struct platform_device *pdev)
+{
+	struct qcom_flash_chip *chip;
+	struct qcom_flash_led *led;
+	struct fwnode_handle *child;
+	struct device *dev = &pdev->dev;
+	int count, rc;
+	u32 val;
+
+	chip = devm_kzalloc(dev, sizeof(*chip), GFP_KERNEL);
+	if (!chip)
+		return -ENOMEM;
+
+	chip->regmap = dev_get_regmap(dev->parent, NULL);
+	if (!chip->regmap) {
+		dev_err(dev, "Failed to get parent regmap\n");
+		return -EINVAL;
+	}
+
+	rc = fwnode_property_read_u32(dev->fwnode, "reg", &chip->reg_base);
+	if (rc < 0) {
+		dev_err(dev, "Failed to get register base address, rc=%d\n", rc);
+		return rc;
+	}
+
+	rc = regmap_read(chip->regmap, chip->reg_base + FLASH_TYPE_REG, &val);
+	if (rc < 0) {
+		dev_err(dev, "Read flash module type failed, rc=%d\n", rc);
+		return rc;
+	}
+
+	if (val != FLASH_TYPE_VAL) {
+		dev_err(dev, "type %#x is not a flash module\n", val);
+		return -ENODEV;
+	}
+
+	rc = regmap_read(chip->regmap, chip->reg_base + FLASH_SUBTYPE_REG, &val);
+	if (rc < 0) {
+		dev_err(dev, "Read flash module subtype failed, rc=%d\n", rc);
+		return rc;
+	}
+
+	if (val == FLASH_SUBTYPE_3CH_VAL) {
+		chip->hw_type = QCOM_MVFLASH_3CH;
+		chip->max_channels = 3;
+		chip->reg = &mvflash_3ch_reg;
+	} else if (val == FLASH_SUBTYPE_4CH_VAL) {
+		chip->hw_type = QCOM_MVFLASH_4CH;
+		chip->max_channels = 4;
+		chip->reg = &mvflash_4ch_reg;
+	} else {
+		dev_err(dev, "flash subtype %#x is not yet supported\n", val);
+		return -ENODEV;
+	}
+
+	chip->dev = dev;
+	platform_set_drvdata(pdev, chip);
+	mutex_init(&chip->lock);
+	count = device_get_child_node_count(dev);
+	if (count == 0 || count > chip->max_channels) {
+		dev_err(dev, "No child or child count exceeds %d\n", chip->max_channels);
+		return -EINVAL;
+	}
+
+	chip->leds = devm_kcalloc(dev, count, sizeof(*chip->leds), GFP_KERNEL);
+	if (!chip->leds)
+		return -ENOMEM;
+
+	device_for_each_child_node(dev, child) {
+		led = &chip->leds[chip->leds_count];
+		led->chip = chip;
+		rc = qcom_flash_register_led_device(dev, child, led);
+		if (rc < 0)
+			goto release;
+
+		chip->leds_count++;
+	}
+
+	return 0;
+release:
+	while (chip->leds && chip->leds_count--)
+		v4l2_flash_release(chip->leds[chip->leds_count].v4l2_flash);
+	return rc;
+}
+
+static int qcom_flash_led_remove(struct platform_device *pdev)
+{
+	struct qcom_flash_chip *chip = platform_get_drvdata(pdev);
+
+	while (chip->leds_count--)
+		v4l2_flash_release(chip->leds[chip->leds_count].v4l2_flash);
+
+	mutex_destroy(&chip->lock);
+	return 0;
+}
+
+static const struct of_device_id qcom_flash_led_match_table[] = {
+	{ .compatible = "qcom,spmi-flash-led" },
+	{ .compatible = "qcom,pm8150c-flash-led" },
+	{ .compatible = "qcom,pm8150l-flash-led" },
+	{ .compatible = "qcom,pm8350c-flash-led" },
+	{ }
+};
+
+static struct platform_driver qcom_flash_led_driver = {
+	.driver = {
+		.name = "leds-qcom-flash",
+		.of_match_table = qcom_flash_led_match_table,
+	},
+	.probe = qcom_flash_led_probe,
+	.remove = qcom_flash_led_remove,
+};
+
+module_platform_driver(qcom_flash_led_driver);
+
+MODULE_DESCRIPTION("QCOM Flash LED driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

