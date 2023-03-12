Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE36B68C3
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 18:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbjCLRWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjCLRV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 13:21:59 -0400
X-Greylist: delayed 412 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 12 Mar 2023 10:21:54 PDT
Received: from out-43.mta0.migadu.com (out-43.mta0.migadu.com [IPv6:2001:41d0:1004:224b::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36F96367E6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 10:21:54 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678641298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mb4vcnMoEk2i3pcE+eV8FNHRJlRbgjIuCc3blHn1k6Q=;
        b=mJ63MwxTFKfT8brCcSjLj5ewAY8K9xVdzZkbDkRXQwGCrtrx+EOcfYwG7odI0EhZcOWaqt
        RlcvTKGjGmpVt6/5UNO+K94sAUj6krmhSae26TD5R2bNUG66LsFRdMpHSbU91hGmb8HHTs
        D4/wavrjpH0PMOwCqs1AA5DrMpcIaUQ=
From:   Cixi Geng <cixi.geng@linux.dev>
To:     gregkh@linuxfoundation.org, orsonzhai@gmail.com,
        baolin.wang@linux.alibaba.com, zhang.lyra@gmail.com, arnd@arndb.de,
        tony@atomide.com, felipe.balbi@linux.intel.com,
        paul@crapouillou.net, linus.walleij@linaro.org,
        cixi.geng1@unisoc.com, gengcixi@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [RFC PATCH v1] usb/phy add sprd ums512 usbphy
Date:   Mon, 13 Mar 2023 01:14:38 +0800
Message-Id: <20230312171438.177952-1-cixi.geng@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cixi Geng <cixi.geng1@unisoc.com>

This driver is support USB2 phy for Spreadtrum UMS512 SOC's,

Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
---
 drivers/usb/phy/Kconfig           |  10 +
 drivers/usb/phy/Makefile          |   1 +
 drivers/usb/phy/phy-sprd-ums512.c | 511 ++++++++++++++++++++++++++++++
 drivers/usb/phy/phy-sprd-ums512.h |  39 +++
 4 files changed, 561 insertions(+)
 create mode 100644 drivers/usb/phy/phy-sprd-ums512.c
 create mode 100644 drivers/usb/phy/phy-sprd-ums512.h

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 5f629d7cad64..fa5564e6f3a3 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -158,6 +158,16 @@ config USB_TEGRA_PHY
 	  This driver provides PHY support for the USB controllers found
 	  on NVIDIA Tegra SoC's.
 
+config USB_SPRD_UMS512_PHY
+	tristate "Spreadtrum ums512 USB2 PHY Driver"
+	depends on ARCH_SPRD || COMPILE_TEST
+	select USB_PHY
+	select EXTCON_USB_GPIO
+	help
+	  Enable this to support the SPRD ums512 USB2 PHY that is part of SOC.
+	  This driver takes care of all the PHY functionality, normally paired with
+	  DesignWare USB20 (DRD) Controller.
+
 config USB_ULPI
 	bool "Generic ULPI Transceiver Driver"
 	depends on ARM || ARM64 || COMPILE_TEST
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index e5d619b4d8f6..ce45ee0f12a8 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -22,4 +22,5 @@ obj-$(CONFIG_USB_MV_OTG)		+= phy-mv-usb.o
 obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
 obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
+obj-$(CONFIG_USB_SPRD_UMS512_PHY)	+= phy-sprd-ums512.o
 obj-$(CONFIG_KEYSTONE_USB_PHY)		+= phy-keystone.o
diff --git a/drivers/usb/phy/phy-sprd-ums512.c b/drivers/usb/phy/phy-sprd-ums512.c
new file mode 100644
index 000000000000..025f45e8d509
--- /dev/null
+++ b/drivers/usb/phy/phy-sprd-ums512.c
@@ -0,0 +1,511 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Unisoc USB PHY driver
+ *
+ * Copyright (C) 2023 Unisoc Inc.
+ */
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/usb/otg.h>
+#include <linux/usb/phy.h>
+#include <uapi/linux/usb/charger.h>
+
+#include "phy-sprd-ums512.h"
+
+struct sprd_hsphy {
+	struct device		*dev;
+	struct usb_phy		phy;
+	struct regulator	*vdd;
+	struct regmap		*hsphy_glb;
+	struct regmap		*ana_g2;
+	struct regmap		*pmic;
+	u32			vdd_vol;
+	atomic_t		reset;
+	atomic_t		inited;
+	bool			is_host;
+};
+
+#define TUNEHSAMP_2_6MA		(3 << 25)
+#define TFREGRES_TUNE_VALUE	(0x14 << 19)
+#define SC2730_CHARGE_STATUS	0x1b9c
+#define BIT_CHG_DET_DONE	BIT(11)
+#define BIT_SDP_INT		BIT(7)
+#define BIT_DCP_INT		BIT(6)
+#define BIT_CDP_INT		BIT(5)
+
+static enum usb_charger_type sc27xx_charger_detect(struct regmap *regmap)
+{
+	enum usb_charger_type type;
+	u32 status = 0, val;
+	int ret, cnt = 10;
+
+	do {
+		ret = regmap_read(regmap, SC2730_CHARGE_STATUS, &val);
+		if (ret)
+			return UNKNOWN_TYPE;
+
+		if (val & BIT_CHG_DET_DONE) {
+			status = val & (BIT_CDP_INT | BIT_DCP_INT | BIT_SDP_INT);
+			break;
+		}
+
+		msleep(200);
+	} while (--cnt > 0);
+
+	switch (status) {
+	case BIT_CDP_INT:
+		type = CDP_TYPE;
+		break;
+	case BIT_DCP_INT:
+		type = DCP_TYPE;
+		break;
+	case BIT_SDP_INT:
+		type = SDP_TYPE;
+		break;
+	default:
+		type = UNKNOWN_TYPE;
+	}
+
+	return type;
+}
+
+static inline void sprd_hsphy_enable(struct sprd_hsphy *sprd_phy)
+{
+	u32 reg, msk;
+
+	/* enable usb module */
+	reg = msk = (MASK_AON_APB_OTG_UTMI_EB | MASK_AON_APB_ANA_EB);
+	regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_APB_EB1, msk, reg);
+	reg = msk = MASK_AON_APB_CGM_OTG_REF_EN |
+		MASK_AON_APB_CGM_DPHY_REF_EN;
+	regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_CGM_REG1, msk, reg);
+}
+
+static inline void sprd_hsphy_power_down(struct sprd_hsphy *sprd_phy)
+{
+	u32 reg, msk;
+
+	/* usb power down */
+	reg = msk = (MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_PS_PD_L |
+		MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_PS_PD_S);
+	regmap_update_bits(sprd_phy->ana_g2,
+		REG_ANLG_PHY_G2_ANALOG_USB20_USB20_BATTER_PLL, msk, reg);
+}
+
+static inline void sprd_hsphy_reset_core(struct sprd_hsphy *sprd_phy)
+{
+	u32 reg, msk;
+
+	/* Reset PHY */
+	reg = msk = MASK_AON_APB_OTG_PHY_SOFT_RST | MASK_AON_APB_OTG_UTMI_SOFT_RST;
+
+	regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_APB_RST1, msk, reg);
+	/* USB PHY reset need to delay 20ms~30ms */
+	usleep_range(20000, 30000);
+	regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_APB_RST1, msk, 0);
+}
+
+static int sprd_hostphy_set(struct usb_phy *u_phy, int on)
+{
+	struct sprd_hsphy *sprd_phy = container_of(u_phy, struct sprd_hsphy, phy);
+	u32 reg, msk;
+	int ret = 0;
+
+	if (on) {
+		msk = MASK_AON_APB_USB2_PHY_IDDIG;
+		ret |= regmap_update_bits(sprd_phy->hsphy_glb,
+			REG_AON_APB_OTG_PHY_CTRL, msk, 0);
+
+		msk = MASK_ANLG_PHY_G2_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN |
+			MASK_ANLG_PHY_G2_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN;
+		ret |= regmap_update_bits(sprd_phy->ana_g2,
+			REG_ANLG_PHY_G2_ANALOG_USB20_REG_SEL_CFG_0,
+			msk, msk);
+
+		msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DMPULLDOWN |
+			MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DPPULLDOWN;
+		ret |= regmap_update_bits(sprd_phy->ana_g2,
+			REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL2,
+			msk, msk);
+
+		reg = 0x200;
+		msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_RESERVED;
+		ret |= regmap_update_bits(sprd_phy->ana_g2,
+			REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1,
+			msk, reg);
+		sprd_phy->is_host = true;
+	} else {
+		reg = msk = MASK_AON_APB_USB2_PHY_IDDIG;
+		ret |= regmap_update_bits(sprd_phy->hsphy_glb,
+			REG_AON_APB_OTG_PHY_CTRL, msk, reg);
+
+		msk = MASK_ANLG_PHY_G2_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN |
+			MASK_ANLG_PHY_G2_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN;
+		ret |= regmap_update_bits(sprd_phy->ana_g2,
+			REG_ANLG_PHY_G2_ANALOG_USB20_REG_SEL_CFG_0,
+			msk, msk);
+
+		msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DMPULLDOWN |
+			MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DPPULLDOWN;
+		ret |= regmap_update_bits(sprd_phy->ana_g2,
+			REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL2,
+			msk, 0);
+
+		msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_RESERVED;
+		ret |= regmap_update_bits(sprd_phy->ana_g2,
+			REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1,
+			msk, 0);
+		sprd_phy->is_host = false;
+	}
+	return ret;
+}
+
+static int sprd_hsphy_init(struct usb_phy *u_phy)
+{
+	struct sprd_hsphy *sprd_phy = container_of(u_phy, struct sprd_hsphy, phy);
+	u32 reg, msk;
+	int ret;
+
+	if (atomic_read(&sprd_phy->inited)) {
+		dev_dbg(u_phy->dev, "%s is already inited!\n", __func__);
+		return 0;
+	}
+
+	/* Turn On VDD */
+	regulator_set_voltage(sprd_phy->vdd, sprd_phy->vdd_vol, sprd_phy->vdd_vol);
+	if (!regulator_is_enabled(sprd_phy->vdd)) {
+		ret = regulator_enable(sprd_phy->vdd);
+		if (ret)
+			return ret;
+	}
+
+	sprd_hsphy_enable(sprd_phy);
+	regmap_update_bits(sprd_phy->ana_g2, REG_ANLG_PHY_G2_ANALOG_USB20_USB20_ISO_SW,
+				MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_ISO_SW_EN, 0);
+
+	/* usb phy power */
+	msk = (MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_PS_PD_L |
+		MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_PS_PD_S);
+	regmap_update_bits(sprd_phy->ana_g2, REG_ANLG_PHY_G2_ANALOG_USB20_USB20_BATTER_PLL,
+			msk, 0);
+
+	/* usb vbus valid */
+	reg = msk = MASK_AON_APB_OTG_VBUS_VALID_PHYREG;
+	regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_OTG_PHY_TEST, msk, reg);
+
+	reg = msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_VBUSVLDEXT;
+	regmap_update_bits(sprd_phy->ana_g2, REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1,
+			msk, reg);
+
+	/* for SPRD phy utmi_width sel */
+	reg = msk = MASK_AON_APB_UTMI_WIDTH_SEL;
+	regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_OTG_PHY_CTRL, msk, reg);
+
+	reg = msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DATABUS16_8;
+	regmap_update_bits(sprd_phy->ana_g2, REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1,
+			msk, reg);
+
+	reg = TUNEHSAMP_2_6MA;
+	msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_TUNEHSAMP;
+	regmap_update_bits(sprd_phy->ana_g2, REG_ANLG_PHY_G2_ANALOG_USB20_USB20_TRIMMING,
+			msk, reg);
+
+	reg = TFREGRES_TUNE_VALUE;
+	msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_TFREGRES;
+	regmap_update_bits(sprd_phy->ana_g2, REG_ANLG_PHY_G2_ANALOG_USB20_USB20_TRIMMING,
+			msk, reg);
+
+	if (!atomic_read(&sprd_phy->reset)) {
+		sprd_hsphy_reset_core(sprd_phy);
+		atomic_set(&sprd_phy->reset, 1);
+	}
+
+	atomic_set(&sprd_phy->inited, 1);
+
+	return 0;
+}
+
+static void sprd_hsphy_shutdown(struct usb_phy *u_phy)
+{
+	struct sprd_hsphy *sprd_phy = container_of(u_phy, struct sprd_hsphy, phy);
+	u32 reg, msk;
+
+	if (!atomic_read(&sprd_phy->inited)) {
+		dev_dbg(sprd_phy->dev, "%s is already shut down\n", __func__);
+		return;
+	}
+
+	/* usb vbus */
+	msk = MASK_AON_APB_OTG_VBUS_VALID_PHYREG;
+	regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_OTG_PHY_TEST, msk, 0);
+	msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_VBUSVLDEXT;
+	regmap_update_bits(sprd_phy->ana_g2,
+		REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1, msk, 0);
+
+	sprd_hsphy_power_down(sprd_phy);
+	regmap_update_bits(sprd_phy->ana_g2,
+		REG_ANLG_PHY_G2_ANALOG_USB20_USB20_ISO_SW,
+		msk, reg);
+
+	/* usb cgm ref */
+	msk = MASK_AON_APB_CGM_OTG_REF_EN |
+		MASK_AON_APB_CGM_DPHY_REF_EN;
+	regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_CGM_REG1, msk, 0);
+
+	if (regulator_is_enabled(sprd_phy->vdd))
+		regulator_disable(sprd_phy->vdd);
+
+	atomic_set(&sprd_phy->inited, 0);
+	atomic_set(&sprd_phy->reset, 0);
+}
+
+static ssize_t vdd_voltage_show(struct device *dev,
+				struct device_attribute *attr,
+				char *buf)
+{
+	struct sprd_hsphy *sprd_phy = dev_get_drvdata(dev);
+
+	if (!sprd_phy)
+		return -EINVAL;
+
+	return sprintf(buf, "%d\n", sprd_phy->vdd_vol);
+}
+
+static ssize_t vdd_voltage_store(struct device *dev,
+				 struct device_attribute *attr,
+				 const char *buf, size_t size)
+{
+	struct sprd_hsphy *sprd_phy = dev_get_drvdata(dev);
+	u32 vol;
+
+	if (!sprd_phy)
+		return -EINVAL;
+
+	if (kstrtouint(buf, 16, &vol) < 0)
+		return -EINVAL;
+
+	if (vol < 1200000 || vol > 3750000) {
+		dev_err(dev, "Invalid voltage value %d\n", vol);
+		return -EINVAL;
+	}
+	sprd_phy->vdd_vol = vol;
+
+	return size;
+}
+static DEVICE_ATTR_RW(vdd_voltage);
+
+static struct attribute *usb_hsphy_attrs[] = {
+	&dev_attr_vdd_voltage.attr,
+	NULL
+};
+ATTRIBUTE_GROUPS(usb_hsphy);
+
+static int sprd_hsphy_vbus_notify(struct notifier_block *nb,
+				  unsigned long event, void *data)
+{
+	struct usb_phy *u_phy = container_of(nb, struct usb_phy, vbus_nb);
+	struct sprd_hsphy *sprd_phy = container_of(u_phy, struct sprd_hsphy, phy);
+	u32 reg, msk;
+
+	if (sprd_phy->is_host || u_phy->last_event == USB_EVENT_ID) {
+		dev_info(sprd_phy->dev, "USB PHY is host mode\n");
+		return 0;
+	}
+
+	if (event) {
+		/* usb vbus valid */
+		reg = msk = MASK_AON_APB_OTG_VBUS_VALID_PHYREG;
+		regmap_update_bits(sprd_phy->hsphy_glb,
+			REG_AON_APB_OTG_PHY_TEST, msk, reg);
+
+		reg = msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_VBUSVLDEXT;
+		regmap_update_bits(sprd_phy->ana_g2,
+			REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1, msk, reg);
+		usb_phy_set_charger_state(u_phy, USB_CHARGER_PRESENT);
+	} else {
+		/* usb vbus invalid */
+		msk = MASK_AON_APB_OTG_VBUS_VALID_PHYREG;
+		regmap_update_bits(sprd_phy->hsphy_glb, REG_AON_APB_OTG_PHY_TEST,
+			msk, 0);
+		msk = MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_VBUSVLDEXT;
+		regmap_update_bits(sprd_phy->ana_g2,
+			REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1, msk, 0);
+		usb_phy_set_charger_state(u_phy, USB_CHARGER_ABSENT);
+	}
+
+	return 0;
+}
+
+static enum usb_charger_type sprd_hsphy_charger_detect(struct usb_phy *u_phy)
+{
+	struct sprd_hsphy *sprd_phy = container_of(u_phy, struct sprd_hsphy, phy);
+
+	return sc27xx_charger_detect(sprd_phy->pmic);
+}
+
+static int sprd_hsphy_probe(struct platform_device *pdev)
+{
+	struct device_node *regmap_np;
+	struct platform_device *regmap_pdev;
+	struct sprd_hsphy *sprd_phy;
+	struct device *dev = &pdev->dev;
+	int ret;
+	struct usb_otg *otg;
+
+	sprd_phy = devm_kzalloc(dev, sizeof(*sprd_phy), GFP_KERNEL);
+	if (!sprd_phy)
+		return -ENOMEM;
+
+	regmap_np = of_find_compatible_node(NULL, NULL, "sprd,sc27xx-syscon");
+	if (!regmap_np) {
+		dev_err(dev, "unable to get syscon node\n");
+		return -ENODEV;
+	}
+
+	regmap_pdev = of_find_device_by_node(regmap_np);
+	if (!regmap_pdev) {
+		dev_err(dev, "unable to get syscon platform device\n");
+		ret = -ENODEV;
+		goto device_node_err;
+	}
+
+	sprd_phy->pmic = dev_get_regmap(regmap_pdev->dev.parent, NULL);
+	if (!sprd_phy->pmic) {
+		dev_err(dev, "unable to get pmic regmap device\n");
+		ret = -ENODEV;
+		goto platform_device_err;
+	}
+
+	ret = of_property_read_u32(dev->of_node, "sprd,vdd-voltage",
+				   &sprd_phy->vdd_vol);
+	if (ret < 0) {
+		dev_err(dev, "unable to read ssphy vdd voltage\n");
+		goto platform_device_err;
+	}
+
+	sprd_phy->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(sprd_phy->vdd)) {
+		dev_err(dev, "unable to get ssphy vdd supply\n");
+		ret = PTR_ERR(sprd_phy->vdd);
+		goto platform_device_err;
+	}
+
+	ret = regulator_set_voltage(sprd_phy->vdd, sprd_phy->vdd_vol, sprd_phy->vdd_vol);
+	if (ret < 0) {
+		dev_err(dev, "fail to set ssphy vdd voltage at %dmV\n", sprd_phy->vdd_vol);
+		goto platform_device_err;
+	}
+
+	otg = devm_kzalloc(&pdev->dev, sizeof(*otg), GFP_KERNEL);
+	if (!otg) {
+		ret = -ENOMEM;
+		goto platform_device_err;
+	}
+
+	sprd_phy->ana_g2 = syscon_regmap_lookup_by_phandle(dev->of_node,
+				 "sprd,syscon-anag2");
+	if (IS_ERR(sprd_phy->ana_g2)) {
+		dev_err(&pdev->dev, "ap USB anag2 syscon failed!\n");
+		ret = PTR_ERR(sprd_phy->ana_g2);
+		goto platform_device_err;
+	}
+
+	sprd_phy->hsphy_glb = syscon_regmap_lookup_by_phandle(dev->of_node,
+				 "sprd,syscon-enable");
+	if (IS_ERR(sprd_phy->hsphy_glb)) {
+		dev_err(&pdev->dev, "ap USB aon apb syscon failed!\n");
+		ret = PTR_ERR(sprd_phy->hsphy_glb);
+		goto platform_device_err;
+	}
+
+	sprd_hsphy_enable(sprd_phy);
+
+	sprd_hsphy_power_down(sprd_phy);
+
+	sprd_phy->phy.dev = dev;
+	sprd_phy->phy.label = "sprd-hsphy";
+	sprd_phy->phy.otg = otg;
+	sprd_phy->phy.init = sprd_hsphy_init;
+	sprd_phy->phy.shutdown = sprd_hsphy_shutdown;
+	sprd_phy->phy.set_vbus = sprd_hostphy_set;
+	sprd_phy->phy.type = USB_PHY_TYPE_USB2;
+	sprd_phy->phy.vbus_nb.notifier_call = sprd_hsphy_vbus_notify;
+	sprd_phy->phy.charger_detect = sprd_hsphy_charger_detect;
+	otg->usb_phy = &sprd_phy->phy;
+
+	platform_set_drvdata(pdev, sprd_phy);
+
+	ret = usb_add_phy_dev(&sprd_phy->phy);
+	if (ret) {
+		dev_err(dev, "fail to add phy\n");
+		goto platform_device_err;
+	}
+
+	ret = sysfs_create_groups(&dev->kobj, usb_hsphy_groups);
+	if (ret)
+		dev_warn(dev, "failed to create usb hsphy attributes\n");
+
+	if (extcon_get_state(sprd_phy->phy.edev, EXTCON_USB) > 0)
+		usb_phy_set_charger_state(&sprd_phy->phy, USB_CHARGER_PRESENT);
+
+	dev_info(dev, "sprd usb phy probe ok !\n");
+
+platform_device_err:
+device_node_err:
+	of_node_put(regmap_np);
+
+	return ret;
+}
+
+static int sprd_hsphy_remove(struct platform_device *pdev)
+{
+	struct sprd_hsphy *sprd_phy = platform_get_drvdata(pdev);
+
+	sysfs_remove_groups(&pdev->dev.kobj, usb_hsphy_groups);
+	usb_remove_phy(&sprd_phy->phy);
+	if (regulator_is_enabled(sprd_phy->vdd))
+		regulator_disable(sprd_phy->vdd);
+
+	return 0;
+}
+
+static const struct of_device_id sprd_hsphy_match[] = {
+	{ .compatible = "sprd,ums512-phy"},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, sprd_hsphy_match);
+
+static struct platform_driver sprd_hsphy_driver = {
+	.probe = sprd_hsphy_probe,
+	.remove = sprd_hsphy_remove,
+	.driver = {
+		.name = "sprd-hsphy",
+		.of_match_table = sprd_hsphy_match,
+	},
+};
+
+static int __init sprd_hsphy_driver_init(void)
+{
+	return platform_driver_register(&sprd_hsphy_driver);
+}
+
+static void __exit sprd_hsphy_driver_exit(void)
+{
+	platform_driver_unregister(&sprd_hsphy_driver);
+}
+
+late_initcall(sprd_hsphy_driver_init);
+module_exit(sprd_hsphy_driver_exit);
+
+MODULE_DESCRIPTION("UNISOC USB PHY driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/phy/phy-sprd-ums512.h b/drivers/usb/phy/phy-sprd-ums512.h
new file mode 100644
index 000000000000..903da0573eae
--- /dev/null
+++ b/drivers/usb/phy/phy-sprd-ums512.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0+ OR MIT */
+/*
+ * Spreadtrum UMS512 SOC USB registers file
+ *
+ * Copyright C 2022, Spreadtrum Communications Inc.
+ */
+
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DATABUS16_8			0x10000000
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DMPULLDOWN			0x8
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_DPPULLDOWN			0x10
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_ISO_SW_EN			0x1
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_PS_PD_L			0x8
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_PS_PD_S			0x10
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_RESERVED			0xffff
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_TFREGRES			0x1f80000
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_TUNEHSAMP			0x6000000
+#define MASK_ANLG_PHY_G2_ANALOG_USB20_USB20_VBUSVLDEXT			0x10000
+#define MASK_ANLG_PHY_G2_DBG_SEL_ANALOG_USB20_USB20_DMPULLDOWN		0x2
+#define MASK_ANLG_PHY_G2_DBG_SEL_ANALOG_USB20_USB20_DPPULLDOWN		0x4
+#define MASK_AON_APB_ANA_EB						0x1000
+#define MASK_AON_APB_CGM_DPHY_REF_EN					0x400
+#define MASK_AON_APB_CGM_OTG_REF_EN					0x1000
+#define MASK_AON_APB_OTG_PHY_SOFT_RST					0x200
+#define MASK_AON_APB_OTG_UTMI_EB					0x100
+#define MASK_AON_APB_OTG_UTMI_SOFT_RST					0x100
+#define MASK_AON_APB_OTG_VBUS_VALID_PHYREG				0x1000000
+#define MASK_AON_APB_USB2_PHY_IDDIG					0x8
+#define MASK_AON_APB_UTMI_WIDTH_SEL					0x40000000
+#define REG_ANLG_PHY_G2_ANALOG_USB20_USB20_BATTER_PLL			0x005c
+#define REG_ANLG_PHY_G2_ANALOG_USB20_USB20_ISO_SW			0x0070
+#define REG_ANLG_PHY_G2_ANALOG_USB20_USB20_TRIMMING			0x0064
+#define REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL1			0x0058
+#define REG_ANLG_PHY_G2_ANALOG_USB20_USB20_UTMI_CTL2			0x0060
+#define REG_ANLG_PHY_G2_ANALOG_USB20_REG_SEL_CFG_0			0x0074
+#define REG_AON_APB_APB_EB1						0x0004
+#define REG_AON_APB_APB_RST1						0x0010
+#define REG_AON_APB_CGM_REG1						0x0138
+#define REG_AON_APB_OTG_PHY_CTRL					0x0208
+#define REG_AON_APB_OTG_PHY_TEST					0x0204
-- 
2.34.1

