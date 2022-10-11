Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C195FBAD4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 20:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJKS4w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 14:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229987AbiJKS4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 14:56:33 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 665C870E4F;
        Tue, 11 Oct 2022 11:56:29 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29BGsv63019536;
        Tue, 11 Oct 2022 18:56:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=pps0720;
 bh=HyBNCXn30otiPECmmjNb7EYhMkHvylQwZ3c9ijCnfCI=;
 b=fYA8Zp5cBnCX49HMEfKbhoP4EeUjseDT6h3D8uTctr3sMx0u+9OUY0tF9QvJ4J16FLci
 CEk2nPhFLZVDLBuqDUycORbz/TpuXp79mVjUVbjf8/pDrGsDilVflb2ddFDb6EOCZ1lD
 46Wkum8DtU1PAGX1HaCNtDoO2eZaKc9h8LVy5/FyoTnkLrCZ0+hpxhjr9mMxqs3Oiuw9
 M4hRGCejfIxk9hkzP1nEdK8aq9eWvbyPQw+xFCuBM2smkb8ZYwTbmmEV+TOBtt7NILS9
 OoUFWxQZAXL7F+I2dJGEoHQezh/l8zDmsh5ybaHq1rRsB6I+mL5nrisf6yziJ2XN3mIs ew== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3k5cdvgyu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Oct 2022 18:56:03 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 12E5C801AC8;
        Tue, 11 Oct 2022 18:56:01 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.36])
        by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9EE75809415;
        Tue, 11 Oct 2022 18:56:00 +0000 (UTC)
From:   nick.hawkins@hpe.com
To:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux@armlinux.org.uk,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 1/5] soc: hpe: add support for HPE GXP Programmable Register Driver
Date:   Tue, 11 Oct 2022 13:55:21 -0500
Message-Id: <20221011185525.94210-2-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221011185525.94210-1-nick.hawkins@hpe.com>
References: <20221011185525.94210-1-nick.hawkins@hpe.com>
X-Proofpoint-ORIG-GUID: CGNVswop1nDNH1TKHk_Pu8GXHUnxTQE0
X-Proofpoint-GUID: CGNVswop1nDNH1TKHk_Pu8GXHUnxTQE0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-11_08,2022-10-11_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 malwarescore=0 clxscore=1015 mlxlogscore=999 bulkscore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2209130000
 definitions=main-2210110110
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Hawkins <nick.hawkins@hpe.com>

The GXP SoC is interfaced with a programmable logic device that takes
inputs/outputs from the server board. All these inputs/outputs are
presented in register form to the SoC. The Programmable Register Driver
enables access to these registers and provides a standard way to
provide access across the HPE portfolio.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
---
 drivers/soc/Kconfig          |    1 +
 drivers/soc/Makefile         |    1 +
 drivers/soc/hpe/Kconfig      |   19 +
 drivers/soc/hpe/Makefile     |    7 +
 drivers/soc/hpe/gxp-plreg.c  | 1207 ++++++++++++++++++++++++++++++++++
 drivers/soc/hpe/gxp-soclib.c |   19 +
 drivers/soc/hpe/gxp-soclib.h |   15 +
 include/linux/soc/hpe/gxp.h  |   15 +
 8 files changed, 1284 insertions(+)
 create mode 100644 drivers/soc/hpe/Kconfig
 create mode 100644 drivers/soc/hpe/Makefile
 create mode 100644 drivers/soc/hpe/gxp-plreg.c
 create mode 100644 drivers/soc/hpe/gxp-soclib.c
 create mode 100644 drivers/soc/hpe/gxp-soclib.h
 create mode 100644 include/linux/soc/hpe/gxp.h

diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index e461c071189b..e4fed449d619 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -10,6 +10,7 @@ source "drivers/soc/bcm/Kconfig"
 source "drivers/soc/canaan/Kconfig"
 source "drivers/soc/fsl/Kconfig"
 source "drivers/soc/fujitsu/Kconfig"
+source "drivers/soc/hpe/Kconfig"
 source "drivers/soc/imx/Kconfig"
 source "drivers/soc/ixp4xx/Kconfig"
 source "drivers/soc/litex/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 69ba6508cf2c..ebdab9bcbe79 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_MACH_DOVE)		+= dove/
 obj-y				+= fsl/
 obj-y				+= fujitsu/
 obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
+obj-$(CONFIG_ARCH_HPE)		+= hpe/
 obj-y				+= imx/
 obj-y				+= ixp4xx/
 obj-$(CONFIG_SOC_XWAY)		+= lantiq/
diff --git a/drivers/soc/hpe/Kconfig b/drivers/soc/hpe/Kconfig
new file mode 100644
index 000000000000..2bdc9785fe83
--- /dev/null
+++ b/drivers/soc/hpe/Kconfig
@@ -0,0 +1,19 @@
+config SOC_VENDOR_HPE
+	bool "HPE SoC drivers"
+	default y
+	depends on ARCH_HPE
+
+if SOC_VENDOR_HPE
+
+config HPE_GXP_SOCLIB
+	bool
+	default n
+
+config HPE_GXP_PLREG
+	bool "GXP Programmable logic register support"
+	depends on ARCH_HPE_GXP
+	select HPE_GXP_SOCLIB
+	select GPIOLIB_IRQCHIP
+	help
+	  Say yes here to add support for the PLREG.
+endif
diff --git a/drivers/soc/hpe/Makefile b/drivers/soc/hpe/Makefile
new file mode 100644
index 000000000000..f304fe0192c9
--- /dev/null
+++ b/drivers/soc/hpe/Makefile
@@ -0,0 +1,7 @@
+obj-$(CONFIG_HPE_GXP_SOCLIB) += gxp-soclib.o
+obj-$(CONFIG_HPE_GXP_PLREG) += gxp-plreg.o
+obj-$(CONFIG_HPE_GXP_FN2) += gxp-fn2.o
+obj-$(CONFIG_HPE_GXP_CSM) += gxp-csm.o
+obj-$(CONFIG_HPE_GXP_SROM) += gxp-srom.o
+obj-$(CONFIG_HPE_GXP_CHIF) += gxp-chif.o
+obj-$(CONFIG_HPE_GXP_DBG) += gxp-dbg.o
diff --git a/drivers/soc/hpe/gxp-plreg.c b/drivers/soc/hpe/gxp-plreg.c
new file mode 100644
index 000000000000..c2b038a3f4ba
--- /dev/null
+++ b/drivers/soc/hpe/gxp-plreg.c
@@ -0,0 +1,1207 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/device.h>
+#include <linux/gpio.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/interrupt.h>
+#include <linux/mfd/core.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/sysfs.h>
+
+#include <linux/soc/hpe/gxp.h>
+#include "gxp-soclib.h"
+
+#define IOP_LED1 0
+#define IOP_LED2 1
+#define IOP_LED3 2
+#define IOP_LED4 3
+#define IOP_LED5 4
+#define IOP_LED6 5
+#define IOP_LED7 6
+#define IOP_LED8 7
+#define FAN1_INST 8
+#define FAN2_INST 9
+#define FAN3_INST 10
+#define FAN4_INST 11
+#define FAN5_INST 12
+#define FAN6_INST 13
+#define FAN7_INST 14
+#define FAN8_INST 15
+#define FAN9_INST 16
+#define FAN10_INST 17
+#define FAN11_INST 18
+#define FAN12_INST 19
+#define FAN13_INST 20
+#define FAN14_INST 21
+#define FAN15_INST 22
+#define FAN16_INST 23
+#define FAN1_FAIL 24
+#define FAN2_FAIL 25
+#define FAN3_FAIL 26
+#define FAN4_FAIL 27
+#define FAN5_FAIL 28
+#define FAN6_FAIL 29
+#define FAN7_FAIL 30
+#define FAN8_FAIL 31
+#define FAN9_FAIL 32
+#define FAN10_FAIL 33
+#define FAN11_FAIL 34
+#define FAN12_FAIL 35
+#define FAN13_FAIL 36
+#define FAN14_FAIL 37
+#define FAN15_FAIL 38
+#define FAN16_FAIL 39
+#define FAN1_ID 40
+#define FAN2_ID 41
+#define FAN3_ID 42
+#define FAN4_ID 43
+#define FAN5_ID 44
+#define FAN6_ID 45
+#define FAN7_ID 46
+#define FAN8_ID 47
+#define FAN9_ID 48
+#define FAN10_ID 49
+#define FAN11_ID 50
+#define FAN12_ID 51
+#define FAN13_ID 52
+#define FAN14_ID 53
+#define FAN15_ID 54
+#define FAN16_ID 55
+#define LED_IDENTIFY 56
+#define LED_HEALTH_RED 57
+#define LED_HEALTH_AMBER 58
+#define PWR_BTN_INT 59
+#define UID_PRESS_INT 60
+#define SLP_INT 61
+#define PME_INT 62
+#define RESV0 63
+#define RESV1 64
+#define RESV2 65
+#define ACM_FORCE_OFF 70
+#define ACM_REMOVED 71
+#define ACM_REQ_N 72
+
+#define PLREG_INT_GRP5_PIN_BASE	59
+
+#define MAX_FAN 16
+#define IOP_LED_QUANTITY 8
+#define BYTE 0
+#define MASK 1
+#define VALUE 2
+
+struct fan_access {
+	u32 inst;
+	u32 fail;
+	u32 id;
+	u32 bit;
+};
+
+struct iop_led_access {
+	u32 iop_led[2];
+};
+
+struct health_led_access {
+	u32 red[2];
+	u32 amber[2];
+	u32 green[2];
+};
+
+struct identify_led_access {
+	u32 off[2];
+	u32 on[2];
+};
+
+struct acm_access {
+	int exists;
+	u32 force_off[2];
+	u32 removed[2];
+	u32 unlatch_req[2];
+};
+
+struct server_id_access {
+	u32 upper[2];
+	u32 lower[2];
+};
+
+struct sideband_access {
+	u32 disabled[2];
+	u32 embedded[2];
+	u32 adaptive[2];
+};
+
+struct grp5_intr_flag_access {
+	u32 ack[2];
+	u32 pwrbtn[2];
+	u32 uidpress[2];
+	u32 slpintr[2];
+};
+
+struct grp5_intr_mask_access {
+	u32 pwrbtn[2];
+	u32 slpintr[2];
+};
+
+struct grp_intr_masks_access {
+	u32 grp5[2];
+};
+
+struct grp_intr_flags_access {
+	u32 grp5[2];
+};
+
+struct pwrbtn_access {
+	u32 latch[3];
+};
+
+struct gxp_plreg_drvdata {
+	void __iomem *base;
+	struct regmap *plreg_map;
+	struct gpio_chip gpio_chip;
+	int irq;
+	struct fan_access fan[16];
+	struct health_led_access health_led;
+	struct iop_led_access iop_led[8];
+	struct identify_led_access identify_led;
+	struct acm_access acm;
+	struct server_id_access server_id;
+	struct sideband_access sideband;
+	struct grp5_intr_flag_access grp5_intr_flag;
+	struct grp5_intr_mask_access grp5_intr_mask;
+	struct grp_intr_masks_access grp_intr_masks;
+	struct grp_intr_flags_access grp_intr_flags;
+	struct pwrbtn_access pwrbtn;
+};
+
+struct gxp_plreg_drvdata client_data;
+
+static void address_translation(u32 desired_offset, u32 *offset, u32 *bit_shift)
+{
+	*offset = (desired_offset & 0xffc);
+	*bit_shift = (desired_offset - *offset) * 8;
+}
+
+int gxp_plreg_get_fan_inst(int fan)
+{
+	struct gxp_plreg_drvdata *drvdata = &client_data;
+	u32 trans_offset;
+	u32 trans_shift;
+	u32 val;
+
+	address_translation(drvdata->fan[fan].inst,
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_read(drvdata->plreg_map, trans_offset, &val);
+	val = (val >> trans_shift) & drvdata->fan[fan].bit;
+	if (val == drvdata->fan[fan].bit)
+		return 1;
+	else
+		return 0;
+}
+EXPORT_SYMBOL(gxp_plreg_get_fan_inst);
+
+int gxp_plreg_get_fan_fail(int fan)
+{
+	struct gxp_plreg_drvdata *drvdata = &client_data;
+	u32 trans_offset;
+	u32 trans_shift;
+	u32 val;
+
+	address_translation(drvdata->fan[fan].fail,
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_read(drvdata->plreg_map, trans_offset, &val);
+	val = (val >> trans_shift) & drvdata->fan[fan].bit;
+	if (val == drvdata->fan[fan].bit)
+		return 1;
+	else
+		return 0;
+}
+EXPORT_SYMBOL(gxp_plreg_get_fan_fail);
+
+int gxp_plreg_get_fan_id(int fan)
+{
+	struct gxp_plreg_drvdata *drvdata = &client_data;
+	u32 trans_offset;
+	u32 trans_shift;
+	u32 val;
+
+	address_translation(drvdata->fan[fan].id,
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_read(drvdata->plreg_map, trans_offset, &val);
+	val = (val >> trans_shift) & drvdata->fan[fan].bit;
+	if (val == drvdata->fan[fan].bit)
+		return 1;
+	else
+		return 0;
+}
+EXPORT_SYMBOL(gxp_plreg_get_fan_id);
+
+void gxp_plreg_do_virt_pwr_btn_latch(void)
+{
+	struct gxp_plreg_drvdata *drvdata = &client_data;
+	u32 trans_offset;
+	u32 trans_shift;
+
+	address_translation(drvdata->pwrbtn.latch[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_update_bits(drvdata->plreg_map, trans_offset,
+			   drvdata->pwrbtn.latch[MASK] << trans_shift,
+			   drvdata->pwrbtn.latch[VALUE] << trans_shift);
+}
+EXPORT_SYMBOL(gxp_plreg_do_virt_pwr_btn_latch);
+
+static ssize_t server_id_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(dev);
+	int value_upper;
+	int value_lower;
+	ssize_t ret;
+	u32 trans_offset;
+	u32 trans_shift;
+
+	/* read upper first */
+	address_translation(drvdata->server_id.upper[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+	regmap_read(drvdata->plreg_map, trans_offset, &value_upper);
+	value_upper = value_upper >> trans_shift;
+	value_upper = value_upper & drvdata->server_id.upper[MASK];
+
+	/* read lower last */
+	address_translation(drvdata->server_id.lower[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+	regmap_read(drvdata->plreg_map, trans_offset, &value_lower);
+	value_lower = value_lower >> trans_shift;
+	value_lower = value_lower & drvdata->server_id.lower[MASK];
+
+	ret = sprintf(buf, "0x%04x", value_upper | value_lower);
+
+	return ret;
+}
+
+static DEVICE_ATTR_RO(server_id);
+
+static ssize_t sideband_sel_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(dev);
+	int value;
+	ssize_t ret;
+	u32 trans_offset;
+	u32 trans_shift;
+	u32 status = PLREG_SIDEBAND_UNKNOWN;
+
+	/* check first to see if its disabled */
+	address_translation(drvdata->sideband.disabled[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_read(drvdata->plreg_map, trans_offset, &value);
+	value = value >> trans_shift;
+
+	if ((value & drvdata->sideband.disabled[MASK]) ==
+	    drvdata->sideband.disabled[MASK]) {
+		status = PLREG_SIDEBAND_DISABLED;
+		goto EXIT;
+	}
+
+	/* check next to see if its embedded */
+	address_translation(drvdata->sideband.embedded[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_read(drvdata->plreg_map, trans_offset, &value);
+	value = value >> trans_shift;
+
+	if ((value & drvdata->sideband.embedded[MASK]) ==
+	    drvdata->sideband.embedded[MASK]) {
+		status = PLREG_SIDEBAND_EMBEDDED;
+		goto EXIT;
+	}
+
+	/* check finally to see if its adaptive */
+	address_translation(drvdata->sideband.adaptive[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_read(drvdata->plreg_map, trans_offset, &value);
+	value = value >> trans_shift;
+
+	if ((value & drvdata->sideband.adaptive[MASK]) ==
+	    drvdata->sideband.adaptive[MASK])
+		status = PLREG_SIDEBAND_ADAPTIVE;
+EXIT:
+
+	ret = sprintf(buf, "0x%02x", status);
+
+	return ret;
+}
+
+static ssize_t sideband_sel_store(struct device *dev, struct device_attribute *attr,
+				  const char *buf, size_t count)
+{
+	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(dev);
+	int input;
+	int rc;
+	u32 trans_offset;
+	u32 trans_shift;
+
+	rc = kstrtoint(buf, 0, &input);
+	if (rc < 0)
+		return -EINVAL;
+
+	if (input > PLREG_SIDEBAND_ADAPTIVE ||  input <  PLREG_SIDEBAND_DISABLED)
+		return -EINVAL;
+
+	if (input == PLREG_SIDEBAND_DISABLED) {
+		address_translation(drvdata->sideband.disabled[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+
+		regmap_update_bits(drvdata->plreg_map, trans_offset,
+				   drvdata->sideband.disabled[MASK] << trans_shift,
+				   drvdata->sideband.disabled[MASK] << trans_shift);
+	} else if (input == PLREG_SIDEBAND_EMBEDDED) {
+		address_translation(drvdata->sideband.embedded[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+
+		regmap_update_bits(drvdata->plreg_map, trans_offset,
+				   drvdata->sideband.embedded[MASK] << trans_shift,
+				   drvdata->sideband.embedded[MASK] << trans_shift);
+	} else {
+		address_translation(drvdata->sideband.adaptive[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+
+		regmap_update_bits(drvdata->plreg_map, trans_offset,
+				   drvdata->sideband.adaptive[MASK] << trans_shift,
+				   drvdata->sideband.adaptive[MASK] << trans_shift);
+	}
+
+	return count;
+}
+static DEVICE_ATTR_RW(sideband_sel);
+
+static struct attribute *plreg_attrs[] = {
+	&dev_attr_server_id.attr,
+	&dev_attr_sideband_sel.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(plreg);
+
+static int sysfs_register(struct device *parent, struct gxp_plreg_drvdata *plreg)
+{
+	struct device *dev;
+
+	dev = device_create_with_groups(soc_class, parent, 0,
+					plreg, plreg_groups, "plreg");
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+
+	return 0;
+}
+
+static int gxp_gpio_plreg_get(struct gpio_chip *chip, unsigned int offset)
+{
+	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	int ret = 0;
+	u32 trans_offset;
+	u32 trans_shift;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+		address_translation(drvdata->iop_led[offset].iop_led[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->iop_led[offset].iop_led[MASK];
+		if (val == drvdata->iop_led[offset].iop_led[MASK])
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case FAN1_INST ...FAN16_INST:
+		address_translation(drvdata->fan[offset - FAN1_INST].inst,
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->fan[offset - FAN1_INST].bit;
+		if (val == drvdata->fan[offset - FAN1_INST].bit)
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case FAN1_FAIL ... FAN16_FAIL:
+		address_translation(drvdata->fan[offset - FAN1_FAIL].fail,
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->fan[offset - FAN1_FAIL].bit;
+		if (val == drvdata->fan[offset - FAN1_FAIL].bit)
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case FAN1_ID ... FAN16_ID:
+		address_translation(drvdata->fan[offset - FAN1_ID].id,
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->fan[offset - FAN1_ID].bit;
+		if (val == drvdata->fan[offset - FAN1_ID].bit)
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case PWR_BTN_INT:
+		address_translation(drvdata->grp5_intr_flag.pwrbtn[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->grp5_intr_flag.pwrbtn[MASK];
+		if (val == drvdata->grp5_intr_flag.pwrbtn[MASK])
+			ret = 0;
+		else
+			ret = 1;
+		break;
+	case UID_PRESS_INT:
+		address_translation(drvdata->grp5_intr_flag.uidpress[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->grp5_intr_flag.uidpress[MASK];
+		if (val == drvdata->grp5_intr_flag.uidpress[MASK])
+			ret = 0;
+		else
+			ret = 1;
+		break;
+	case SLP_INT:
+		address_translation(drvdata->grp5_intr_flag.slpintr[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->grp5_intr_flag.slpintr[MASK];
+		if (val == drvdata->grp5_intr_flag.slpintr[MASK])
+			ret = 0;
+		else
+			ret = 1;
+		break;
+	case ACM_FORCE_OFF:
+		if (!drvdata->acm.exists)
+			return -1;
+
+		address_translation(drvdata->acm.force_off[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->acm.force_off[MASK];
+		if (val == drvdata->acm.force_off[MASK])
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case ACM_REMOVED:
+		if (!drvdata->acm.exists)
+			return -1;
+		address_translation(drvdata->acm.removed[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->acm.removed[MASK];
+		if (val == drvdata->acm.removed[MASK])
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	case ACM_REQ_N:
+		if (!drvdata->acm.exists)
+			return -1;
+		address_translation(drvdata->acm.unlatch_req[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_read(drvdata->plreg_map, trans_offset, &val);
+		val = (val >> trans_shift) & drvdata->acm.unlatch_req[MASK];
+		if (val == drvdata->acm.unlatch_req[MASK])
+			ret = 1;
+		else
+			ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void gxp_gpio_plreg_set(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	u32 trans_offset;
+	u32 trans_shift;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+		if (value > 1 || 0 < value)
+			return;
+
+		address_translation(drvdata->iop_led[offset].iop_led[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_update_bits(drvdata->plreg_map, trans_offset,
+				   drvdata->iop_led[offset].iop_led[MASK] << trans_shift,
+				   value << trans_shift);
+		break;
+	case LED_IDENTIFY:
+		//offset 0x05 bit 7:6
+		if (value == 1) {
+			address_translation(drvdata->identify_led.on[BYTE],
+					    &trans_offset,
+					    &trans_shift);
+			regmap_update_bits(drvdata->plreg_map, trans_offset,
+					   drvdata->identify_led.on[MASK] << trans_shift,
+					   drvdata->identify_led.on[MASK] << trans_shift);
+		} else if (value == 0) {
+			address_translation(drvdata->identify_led.off[BYTE],
+					    &trans_offset,
+					    &trans_shift);
+			regmap_update_bits(drvdata->plreg_map, trans_offset,
+					   drvdata->identify_led.off[MASK] << trans_shift,
+					   drvdata->identify_led.off[MASK] << trans_shift);
+		}
+		break;
+	case LED_HEALTH_RED:
+		if (value > 1 || 0 < value)
+			return;
+
+		address_translation(drvdata->health_led.red[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_update_bits(drvdata->plreg_map, trans_offset,
+				   drvdata->health_led.red[MASK] << trans_shift,
+				   value << trans_shift);
+		break;
+	case LED_HEALTH_AMBER:
+		if (value > 1 || 0 < value)
+			return;
+
+		address_translation(drvdata->health_led.amber[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+		regmap_update_bits(drvdata->plreg_map, trans_offset,
+				   drvdata->health_led.amber[MASK] << trans_shift,
+				   value << trans_shift);
+		break;
+	case ACM_FORCE_OFF:
+		if (value > 1 || 0 < value || !drvdata->acm.exists)
+			return;
+
+		address_translation(drvdata->acm.force_off[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+
+		regmap_update_bits(drvdata->plreg_map, trans_offset,
+				   drvdata->acm.force_off[MASK] << trans_shift,
+				   value << trans_shift);
+		break;
+	case ACM_REQ_N:
+		if (value > 1 || 0 < value || !drvdata->acm.exists)
+			return;
+
+		address_translation(drvdata->acm.force_off[BYTE],
+				    &trans_offset,
+				    &trans_shift);
+
+		regmap_update_bits(drvdata->plreg_map, trans_offset,
+				   drvdata->acm.force_off[MASK] << trans_shift,
+				   value << trans_shift);
+		break;
+	default:
+		break;
+	}
+}
+
+static int gxp_gpio_plreg_get_direction(struct gpio_chip *chip, unsigned int offset)
+{
+	int ret = GPIO_DIR_IN;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+	case LED_IDENTIFY ... LED_HEALTH_AMBER:
+	case ACM_FORCE_OFF:
+	case ACM_REQ_N:
+		ret = GPIO_DIR_OUT;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_plreg_direction_input(struct gpio_chip *chip, unsigned int offset)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	case FAN1_INST ... FAN16_ID:
+		ret = 0;
+		break;
+	case PWR_BTN_INT ... RESV2:
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static int gxp_gpio_plreg_direction_output(struct gpio_chip *chip, unsigned int offset, int value)
+{
+	int ret = -EOPNOTSUPP;
+
+	switch (offset) {
+	case IOP_LED1 ... IOP_LED8:
+	case LED_IDENTIFY ... LED_HEALTH_AMBER:
+	case ACM_FORCE_OFF:
+	case ACM_REQ_N:
+		gxp_gpio_plreg_set(chip, offset, value);
+		ret = 0;
+		break;
+	default:
+		break;
+	}
+
+	return ret;
+}
+
+static void gxp_gpio_irq_ack(struct irq_data *d)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	unsigned int val;
+	u32 trans_offset;
+	u32 trans_shift;
+
+	// Read latched interrupt
+	address_translation(drvdata->grp5_intr_flag.ack[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+	regmap_read(drvdata->plreg_map, trans_offset, &val);
+
+	//Clear latched interrupt
+	regmap_update_bits(drvdata->plreg_map, trans_offset,
+			   drvdata->grp5_intr_flag.ack[MASK] << trans_shift,
+			   drvdata->grp5_intr_flag.ack[MASK] << trans_shift);
+}
+
+static void gxp_gpio_irq_set_mask(struct irq_data *d, bool set)
+{
+	struct gpio_chip *chip = irq_data_get_irq_chip_data(d);
+	struct gxp_plreg_drvdata *drvdata = dev_get_drvdata(chip->parent);
+	u32 trans_offset;
+	u32 trans_shift;
+
+	address_translation(drvdata->grp5_intr_flag.ack[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+
+	regmap_update_bits(drvdata->plreg_map, trans_offset,
+			   (drvdata->grp5_intr_flag.pwrbtn[MASK] |
+			   drvdata->grp5_intr_flag.slpintr[MASK]) << trans_shift,
+			   set == 1 ? 0 : (drvdata->grp5_intr_flag.pwrbtn[MASK] |
+			   drvdata->grp5_intr_flag.slpintr[MASK]) << trans_shift);
+
+	regmap_update_bits(drvdata->plreg_map, trans_offset,
+			   drvdata->grp5_intr_flag.ack[MASK] << trans_shift,
+			   drvdata->grp5_intr_flag.ack[MASK] << trans_shift);
+}
+
+static void gxp_gpio_irq_mask(struct irq_data *d)
+{
+	gxp_gpio_irq_set_mask(d, false);
+}
+
+static void gxp_gpio_irq_unmask(struct irq_data *d)
+{
+	gxp_gpio_irq_set_mask(d, true);
+}
+
+static int gxp_gpio_set_type(struct irq_data *d, unsigned int type)
+{
+	if (type & IRQ_TYPE_LEVEL_MASK)
+		irq_set_handler_locked(d, handle_level_irq);
+	else
+		irq_set_handler_locked(d, handle_edge_irq);
+
+	return 0;
+}
+
+static irqreturn_t gxp_plreg_irq_handle(int irq, void *_drvdata)
+{
+	struct gxp_plreg_drvdata *drvdata = (struct gxp_plreg_drvdata *)_drvdata;
+	unsigned int val, girq, i;
+
+	/* handle plreg interrupt group5 */
+	val = readb(drvdata->base + drvdata->grp5_intr_flag.ack[BYTE]);
+
+	for_each_set_bit(i, (unsigned long *)&val, 3) {
+		girq = irq_find_mapping(drvdata->gpio_chip.irq.domain,
+					i + PLREG_INT_GRP5_PIN_BASE);
+		generic_handle_irq(girq);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static const struct gpio_chip plreg_chip = {
+	.label			= "gxp-plreg",
+	.owner			= THIS_MODULE,
+	.get			= gxp_gpio_plreg_get,
+	.set			= gxp_gpio_plreg_set,
+	.get_direction = gxp_gpio_plreg_get_direction,
+	.direction_input = gxp_gpio_plreg_direction_input,
+	.direction_output = gxp_gpio_plreg_direction_output,
+	.base = -1,
+	//.can_sleep		= true,
+};
+
+static struct irq_chip gxp_gpio_irqchip = {
+	.name		= "gxp-plreg",
+	.irq_ack	= gxp_gpio_irq_ack,
+	.irq_mask	= gxp_gpio_irq_mask,
+	.irq_unmask	= gxp_gpio_irq_unmask,
+	.irq_set_type	= gxp_gpio_set_type,
+};
+
+static const struct of_device_id gxp_plreg_of_match[] = {
+	{ .compatible = "hpe,gxp-plreg" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, gxp_plreg_of_match);
+
+static int gxp_plreg_probe(struct platform_device *pdev)
+{
+	int i;
+	int j;
+	int ret;
+	struct gxp_plreg_drvdata *drvdata;
+	struct resource *res;
+	struct gpio_irq_chip *girq;
+	struct device_node *np;
+	char name_buf[10];
+	u32 trans_offset;
+	u32 trans_shift;
+
+	drvdata = devm_kzalloc(&pdev->dev,
+			       sizeof(struct gxp_plreg_drvdata), GFP_KERNEL);
+	if (!drvdata)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, drvdata);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	drvdata->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(drvdata->base))
+		return PTR_ERR(drvdata->base);
+
+	drvdata->plreg_map = syscon_regmap_lookup_by_compatible("hpe,gxp-plreg");
+	if (IS_ERR(drvdata->plreg_map)) {
+		dev_err(&pdev->dev, "Unable to find plreg regmap\n");
+		return PTR_ERR(drvdata->plreg_map);
+	}
+
+	/* Supply driver with information to access specific offsets in plreg */
+	for (i = 0; i < MAX_FAN; i++) {
+		/* Find Fan Children */
+		snprintf(name_buf, sizeof(name_buf), "fan%d", i + 1);
+		np = of_get_child_by_name(pdev->dev.of_node, name_buf);
+
+		if (np) {
+		/* For each child there should be 3 fan properties */
+			if (of_property_read_u32(np, "inst",
+						 &drvdata->fan[i].inst)) {
+				dev_err(&pdev->dev, "%s is missing its 'inst' property\n",
+					name_buf);
+				return -ENODEV;
+			}
+
+			if (of_property_read_u32(np, "fail",
+						 &drvdata->fan[i].fail)) {
+				dev_err(&pdev->dev, "%s is missing its 'fail' property\n",
+					name_buf);
+				return -ENODEV;
+			}
+			if (of_property_read_u32(np, "id",
+						 &drvdata->fan[i].id)) {
+				dev_err(&pdev->dev, "%s is missing its 'id' property\n",
+					name_buf);
+				return -ENODEV;
+			}
+			if (of_property_read_u32(np, "bit",
+						 &drvdata->fan[i].bit)) {
+				dev_err(&pdev->dev, "%s is missing its 'bit' property\n",
+					name_buf);
+				return -ENODEV;
+			}
+		} else {
+			dev_warn(&pdev->dev, "%pOF is missing its '%s' node\n", np, name_buf);
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "healthled");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'healthled' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "red", i,
+					       &drvdata->health_led.red[i])) {
+			dev_err(&pdev->dev, "healthled is missing its 'red' property index %d\n",
+				i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "amber", i,
+					       &drvdata->health_led.amber[i])) {
+			dev_err(&pdev->dev, "healthled is missing its 'amber' property index %d\n",
+				i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "green", i,
+					       &drvdata->health_led.green[i])) {
+			dev_err(&pdev->dev, "healthled is missing its 'green' property index %d\n",
+				i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i < IOP_LED_QUANTITY; i++) {
+		/* Find iopLed Children */
+		snprintf(name_buf, sizeof(name_buf), "iopled%d", i + 1);
+		np = of_get_child_by_name(pdev->dev.of_node, name_buf);
+
+		if (np) {
+		/* For each child there should be 1 property */
+			for (j = 0; j <= MASK; j++) {
+				if (of_property_read_u32_index(np, "on", j,
+							       &drvdata->iop_led[i].iop_led[j]
+							       )) {
+					dev_err(&pdev->dev, "%s is missing its 'on' property index %d\n",
+						name_buf, j);
+					return -ENODEV;
+				}
+			}
+		} else {
+			dev_err(&pdev->dev, "%pOF is missing its '%s' node\n", np, name_buf);
+			return -ENODEV;
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "identifyled");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'identifyled' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "on", i, &drvdata->identify_led.on[i])) {
+			dev_err(&pdev->dev, "identifyled is missing its 'on' property index %d\n",
+				i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "off", i, &drvdata->identify_led.off[i])) {
+			dev_err(&pdev->dev, "identifyled is missing its 'off' property index %d\n",
+				i);
+			return -ENODEV;
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "acm");
+	if (!np) {
+		dev_warn(&pdev->dev, "%pOF is missing its 'acm' node\n", np);
+	} else {
+		for (i = 0; i <= MASK; i++) {
+			if (of_property_read_u32_index(np, "forceoff", i,
+						       &drvdata->acm.force_off[i])) {
+				dev_err(&pdev->dev,
+					"acm is missing its 'forceoff' property index %d\n", i);
+				return -ENODEV;
+			}
+		}
+
+		for (i = 0; i <= MASK; i++) {
+			if (of_property_read_u32_index(np, "removed", i,
+						       &drvdata->acm.removed[i])) {
+				dev_err(&pdev->dev,
+					"acm is missing its 'removed' property index %d\n", i);
+				return -ENODEV;
+			}
+		}
+
+		for (i = 0; i <= MASK; i++) {
+			if (of_property_read_u32_index(np, "unlatchreq", i,
+						       &drvdata->acm.unlatch_req[i])) {
+				dev_err(&pdev->dev,
+					"acm is missing its 'unlatchreq' property index %d\n", i);
+				return -ENODEV;
+			}
+		}
+		drvdata->acm.exists = 1;
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "serverid");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'serverid' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "upper", i,
+					       &drvdata->server_id.upper[i])) {
+			dev_err(&pdev->dev,
+				"serverid is missing its 'upper' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "lower", i, &drvdata->server_id.lower[i])) {
+			dev_err(&pdev->dev,
+				"serverid is missing its 'lower' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "sideband");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'sideband' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "disabled", i,
+					       &drvdata->sideband.disabled[i])) {
+			dev_err(&pdev->dev,
+				"sideband is missing its 'disabled' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "embedded", i,
+					       &drvdata->sideband.embedded[i])) {
+			dev_err(&pdev->dev,
+				"sideband is missing its 'embedded' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "adaptive", i,
+					       &drvdata->sideband.adaptive[i])) {
+			dev_err(&pdev->dev,
+				"sideband is missing its 'adaptive' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "grp5intflag");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'grp5intflag' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "ack", i, &drvdata->grp5_intr_flag.ack[i])) {
+			dev_err(&pdev->dev,
+				"grp5intflag is missing its 'ack' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "pwrbtn", i,
+					       &drvdata->grp5_intr_flag.pwrbtn[i])) {
+			dev_err(&pdev->dev,
+				"grp5intflag is missing its 'pwrbtn' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "uidpress", i,
+					       &drvdata->grp5_intr_flag.uidpress[i])) {
+			dev_err(&pdev->dev,
+				"grp5intflag is missing its 'uid' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "slpint", i,
+					       &drvdata->grp5_intr_flag.slpintr[i])) {
+			dev_err(&pdev->dev,
+				"grp5intflag is missing its 'slpint' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "grp5intmask");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'grp5intmask' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "pwrbtn", i,
+					       &drvdata->grp5_intr_mask.pwrbtn[i])) {
+			dev_err(&pdev->dev,
+				"grp5intmask is missing its 'pwrbtn' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "slpint", i,
+					       &drvdata->grp5_intr_mask.slpintr[i])) {
+			dev_err(&pdev->dev,
+				"grp5intmask is missing its 'slpint' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "grpintsmasks");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'grpintsmasks' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "grp5", i,
+					       &drvdata->grp_intr_masks.grp5[i])) {
+			dev_err(&pdev->dev,
+				"grpintsmasks is missing its 'grp5' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "grpintsflags");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'grpintsflags' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= MASK; i++) {
+		if (of_property_read_u32_index(np, "grp5", i,
+					       &drvdata->grp_intr_flags.grp5[i])) {
+			dev_err(&pdev->dev,
+				"grp5intsflags is missing its 'grp5' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	np = of_get_child_by_name(pdev->dev.of_node, "pwrbtn");
+	if (!np) {
+		dev_err(&pdev->dev, "%pOF is missing its 'pwrbtn' node\n", np);
+		return -ENODEV;
+	}
+
+	for (i = 0; i <= VALUE; i++) {
+		if (of_property_read_u32_index(np, "latch", i, &drvdata->pwrbtn.latch[i])) {
+			dev_err(&pdev->dev, "pwrbtn is missing its 'latch' property index %d\n", i);
+			return -ENODEV;
+		}
+	}
+
+	drvdata->gpio_chip = plreg_chip;
+	drvdata->gpio_chip.ngpio = 100;
+	drvdata->gpio_chip.parent = &pdev->dev;
+
+	girq = &drvdata->gpio_chip.irq;
+	girq->chip = &gxp_gpio_irqchip;
+	/* This will let us handle the parent IRQ in the driver */
+	girq->parent_handler = NULL;
+	girq->num_parents = 0;
+	girq->parents = NULL;
+	girq->default_type = IRQ_TYPE_NONE;
+	girq->handler = handle_edge_irq;
+	/* Set up interrupt from PLREG Group 5 Mask */
+	address_translation(drvdata->grp_intr_flags.grp5[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+	regmap_update_bits(drvdata->plreg_map, trans_offset,
+			   drvdata->grp_intr_flags.grp5[MASK] << trans_shift,
+			   drvdata->grp_intr_flags.grp5[MASK] << trans_shift);
+	address_translation(drvdata->grp_intr_masks.grp5[BYTE],
+			    &trans_offset,
+			    &trans_shift);
+	regmap_update_bits(drvdata->plreg_map, trans_offset,
+			   drvdata->grp_intr_masks.grp5[MASK] << trans_shift,
+			   0x00);
+
+	ret = platform_get_irq(pdev, 0);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Get irq from platform fail - %d\n", ret);
+		return ret;
+	}
+	drvdata->irq = ret;
+
+	ret = devm_request_irq(&pdev->dev, drvdata->irq, gxp_plreg_irq_handle, IRQF_SHARED,
+			       "gxp-plreg", drvdata);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "IRQ handler failed - %d\n", ret);
+		return ret;
+	}
+
+	ret = sysfs_register(&pdev->dev, drvdata);
+	if (ret < 0) {
+		dev_warn(&pdev->dev, "Unable to register sysfs\n");
+		return ret;
+	}
+
+	ret = devm_gpiochip_add_data(&pdev->dev, &drvdata->gpio_chip, NULL);
+	if (ret < 0)
+		dev_err(&pdev->dev, "Could not register gpiochip for plreg, %d\n", ret);
+
+	client_data = *drvdata;
+
+	dev_info(&pdev->dev, "HPE GXP PLREG driver loaded.\n");
+
+	return 0;
+}
+
+static struct platform_driver gxp_plreg_driver = {
+	.probe = gxp_plreg_probe,
+	.driver = {
+		.name = "gxp-plreg",
+		.of_match_table = of_match_ptr(gxp_plreg_of_match),
+	},
+};
+module_platform_driver(gxp_plreg_driver);
+
+MODULE_AUTHOR("Nick Hawkins <nick.hawkins@hpe.com>");
+MODULE_DESCRIPTION("HPE GXP Programmable Logic Registers Driver");
diff --git a/drivers/soc/hpe/gxp-soclib.c b/drivers/soc/hpe/gxp-soclib.c
new file mode 100644
index 000000000000..e32aa346e770
--- /dev/null
+++ b/drivers/soc/hpe/gxp-soclib.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (C) 2022 Hewlett-Packard Enterprise Development Company, L.P. */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/io.h>
+
+struct class *soc_class;
+
+static int __init gxp_soclib_init(void)
+{
+	soc_class = class_create(THIS_MODULE, "soc");
+	if (IS_ERR(soc_class))
+		return PTR_ERR(soc_class);
+	return 0;
+}
+
+module_init(gxp_soclib_init);
+
diff --git a/drivers/soc/hpe/gxp-soclib.h b/drivers/soc/hpe/gxp-soclib.h
new file mode 100644
index 000000000000..583902969ad5
--- /dev/null
+++ b/drivers/soc/hpe/gxp-soclib.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2019 Hewlett-Packard Development Company, L.P.
+ *
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef __GXP_SOCLIB_H__
+#define __GXP_SOCLIB_H__
+
+extern struct class *soc_class;
+
+#endif
diff --git a/include/linux/soc/hpe/gxp.h b/include/linux/soc/hpe/gxp.h
new file mode 100644
index 000000000000..3573c391ec5a
--- /dev/null
+++ b/include/linux/soc/hpe/gxp.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0=or-later */
+/* Copyright (C) 2022 Hewlett-Packard Development Company, L.P. */
+
+#ifndef _LINUX_SOC_HPE_GXP_
+#define _LINUX_SOC_HPE_GXP_H_
+
+#define PLREG_SIDEBAND_UNKNOWN 0x00
+#define PLREG_SIDEBAND_DISABLED 0x01
+#define PLREG_SIDEBAND_EMBEDDED 0x02
+#define PLREG_SIDEBAND_ADAPTIVE 0x03
+
+#define GPIO_DIR_OUT 0
+#define GPIO_DIR_IN  1
+
+#endif /* _LINUX_SOC_HPE_GXP_H_ */
-- 
2.17.1

