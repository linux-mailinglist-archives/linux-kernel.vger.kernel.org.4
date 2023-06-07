Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDDD72541F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjFGG0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234924AbjFGG0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:26:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42908172B;
        Tue,  6 Jun 2023 23:26:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3576OwrW6024091, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3576OwrW6024091
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 7 Jun 2023 14:24:58 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 7 Jun 2023 14:25:14 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 7 Jun 2023 14:25:12 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 7 Jun 2023 14:25:12 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael Grzeschik" <m.grzeschik@pengutronix.de>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Ray Chi <raychi@google.com>,
        "Flavio Suligoi" <f.suligoi@asem.it>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v3 2/5] phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY
Date:   Wed, 7 Jun 2023 14:24:38 +0800
Message-ID: <20230607062500.24669-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230607062500.24669-1-stanley_chang@realtek.com>
References: <20230607062500.24669-1-stanley_chang@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXMBS01.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
controller. Added the driver to drive the USB 2.0 PHY transceivers.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v2 to v3 change:
    1. Broken down into two patches, one for each of USB 2 & 3 PHY.
    2. Removed parameter v1 support for simplification.
    3. Use remove_new for driver remove callback.
v1 to v2 change:
    1. Move the drivers to drivers/phy/ for generic phy driver
    2. Use the generic phy driver api to initialize phy
    3. Use readl/writel to instead phy_read/phy_write directly.
    4. Use read_poll_timeout() in function utmi_wait_register.
    5. Revised some coding styles.
    6. fix the compiler warning for kernel test robot.
---
 drivers/phy/Kconfig                |    1 +
 drivers/phy/Makefile               |    1 +
 drivers/phy/realtek/Kconfig        |   13 +
 drivers/phy/realtek/Makefile       |    2 +
 drivers/phy/realtek/phy-rtk-usb2.c | 1914 ++++++++++++++++++++++++++++
 5 files changed, 1931 insertions(+)
 create mode 100644 drivers/phy/realtek/Kconfig
 create mode 100644 drivers/phy/realtek/Makefile
 create mode 100644 drivers/phy/realtek/phy-rtk-usb2.c

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index f46e3148d286..6d04a0029c6c 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -86,6 +86,7 @@ source "drivers/phy/motorola/Kconfig"
 source "drivers/phy/mscc/Kconfig"
 source "drivers/phy/qualcomm/Kconfig"
 source "drivers/phy/ralink/Kconfig"
+source "drivers/phy/realtek/Kconfig"
 source "drivers/phy/renesas/Kconfig"
 source "drivers/phy/rockchip/Kconfig"
 source "drivers/phy/samsung/Kconfig"
diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
index 54f312c10a40..ba7c100b14fc 100644
--- a/drivers/phy/Makefile
+++ b/drivers/phy/Makefile
@@ -26,6 +26,7 @@ obj-y					+= allwinner/	\
 					   mscc/	\
 					   qualcomm/	\
 					   ralink/	\
+					   realtek/	\
 					   renesas/	\
 					   rockchip/	\
 					   samsung/	\
diff --git a/drivers/phy/realtek/Kconfig b/drivers/phy/realtek/Kconfig
new file mode 100644
index 000000000000..76e31f6abdee
--- /dev/null
+++ b/drivers/phy/realtek/Kconfig
@@ -0,0 +1,13 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Phy drivers for Realtek platforms
+#
+config PHY_RTK_RTD_USB2PHY
+	tristate "Realtek RTD USB2 PHY Transceiver Driver"
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this to support Realtek SoC USB2 phy transceiver.
+	  The DHC (digital home center) RTD series SoCs used the Synopsys
+	  DWC3 USB IP. This driver will do the PHY initialization
+	  of the parameters.
diff --git a/drivers/phy/realtek/Makefile b/drivers/phy/realtek/Makefile
new file mode 100644
index 000000000000..cf5d440841a2
--- /dev/null
+++ b/drivers/phy/realtek/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PHY_RTK_RTD_USB2PHY)	+= phy-rtk-usb2.o
diff --git a/drivers/phy/realtek/phy-rtk-usb2.c b/drivers/phy/realtek/phy-rtk-usb2.c
new file mode 100644
index 000000000000..0538424b9cab
--- /dev/null
+++ b/drivers/phy/realtek/phy-rtk-usb2.c
@@ -0,0 +1,1914 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  phy-rtk-usb2.c RTK usb2.0 PHY driver
+ *
+ * Copyright (C) 2023 Realtek Semiconductor Corporation
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_address.h>
+#include <linux/uaccess.h>
+#include <linux/debugfs.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/regmap.h>
+#include <linux/sys_soc.h>
+#include <linux/mfd/syscon.h>
+#include <linux/phy/phy.h>
+#include <linux/usb.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/hcd.h>
+
+/* GUSB2PHYACCn register */
+#define PHY_NEW_REG_REQ BIT(25)
+#define PHY_VSTS_BUSY   BIT(23)
+#define PHY_VCTRL_SHIFT 8
+#define PHY_REG_DATA_MASK 0xff
+
+#define GET_LOW_NIBBLE(addr) (addr & 0x0f)
+#define GET_HIGH_NIBBLE(addr) ((addr & 0xf0)>>4)
+
+#define EFUS_USB_DC_CAL_RATE 2
+#define EFUS_USB_DC_CAL_MAX 7
+
+#define EFUS_USB_DC_DIS_RATE 1
+#define EFUS_USB_DC_DIS_MAX 7
+
+#define MAX_PHY_DATA_SIZE 20
+#define OFFEST_PHY_READ 0x20
+
+#define MAX_USB_PHY_NUM_PORTS 4
+#define MAX_USB_PHY_PAGE0_DATA_SIZE 16
+#define MAX_USB_PHY_PAGE1_DATA_SIZE 8
+#define MAX_USB_PHY_PAGE2_DATA_SIZE 8
+
+#define SET_PAGE_OFFSET 0xf4
+#define SET_PAGE_0 0x9b
+#define SET_PAGE_1 0xbb
+#define SET_PAGE_2 0xdb
+
+#define PAGE_START 0xe0
+#define PAGE0_0xE4 0xe4
+#define PAGE0_0xE7 0xe7
+#define PAGE1_0xE0 0xe0
+#define PAGE1_0xE2 0xe2
+
+/* mapping 0xE0 to 0 ... 0xE7 to 7, 0xF0 to 8 ,,, 0xF7 to 15 */
+#define PAGE_ADDR_MAP_ARRAY_INDEX(addr) \
+	(((addr - PAGE_START)&0x7) + \
+	(((addr - PAGE_START)&0x10)>>1))
+#define ARRAY_INDEX_MAP_PAGE_ADDR(index) \
+	(((index + PAGE_START)&0x7) + \
+	(((index&0x8)<<1) + PAGE_START))
+
+struct reg_addr {
+	void __iomem *reg_wrap_vstatus;
+	void __iomem *reg_gusb2phyacc0;
+	int vstatus_index;
+};
+
+struct phy_parameter {
+	u8 addr;
+	u8 data;
+};
+
+struct phy_data {
+	int page0_size;
+	struct phy_parameter *page0;
+	int page1_size;
+	struct phy_parameter *page1;
+	int page2_size;
+	struct phy_parameter *page2;
+
+	bool check_efuse;
+	int check_efuse_version;
+#define CHECK_EFUSE_V1 1
+#define CHECK_EFUSE_V2 2
+	int8_t efuse_usb_dc_cal;
+	int efuse_usb_dc_cal_rate;
+	int usb_dc_cal_mask;
+	int8_t efuse_usb_dc_dis;
+	int efuse_usb_dc_dis_rate;
+	int usb_dc_dis_mask;
+	bool usb_dc_dis_at_page0;
+	bool do_toggle;
+	bool do_toggle_driving;
+	int disconnect_driving_updated;
+	bool use_default_parameter;
+	bool is_double_sensitivity_mode;
+	bool ldo_force_enable;
+	bool ldo_enable;
+	s32 ldo_driving_compensate;
+	s32 driving_compensate;
+};
+
+struct rtk_usb_phy {
+	struct usb_phy phy;
+	struct device *dev;
+	struct regmap *usb_ctrl_regs;
+
+	int phyN;
+	void *reg_addr;
+	void *phy_data;
+
+	struct dentry *debug_dir;
+};
+
+#define PHY_IO_TIMEOUT_USEC		(50000)
+#define PHY_IO_DELAY_US			(100)
+
+static inline int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
+{
+	int ret;
+	unsigned int val;
+
+	ret = read_poll_timeout(readl, val, ((val & mask) == result),
+		    PHY_IO_DELAY_US, PHY_IO_TIMEOUT_USEC, false, reg);
+	if (ret) {
+		pr_err("%s can't program USB phy\n", __func__);
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static char rtk_usb_phy_read(struct reg_addr *regAddr, char addr)
+{
+	void __iomem *reg_gusb2phyacc0 = regAddr->reg_gusb2phyacc0;
+	unsigned int regVal;
+	int ret = 0;
+
+	addr -= OFFEST_PHY_READ;
+
+	/* polling until VBusy == 0 */
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return (char)ret;
+
+	/* VCtrl = low nibble of addr, and set PHY_NEW_REG_REQ */
+	regVal = PHY_NEW_REG_REQ | (GET_LOW_NIBBLE(addr) << PHY_VCTRL_SHIFT);
+	writel(regVal, reg_gusb2phyacc0);
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return (char)ret;
+
+	/* VCtrl = high nibble of addr, and set PHY_NEW_REG_REQ */
+	regVal = PHY_NEW_REG_REQ | (GET_HIGH_NIBBLE(addr) << PHY_VCTRL_SHIFT);
+	writel(regVal, reg_gusb2phyacc0);
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return (char)ret;
+
+	regVal = readl(reg_gusb2phyacc0);
+
+	return (char) (regVal & PHY_REG_DATA_MASK);
+}
+
+static int rtk_usb_phy_write(struct reg_addr *regAddr, char addr, char data)
+{
+	unsigned int regVal;
+	void __iomem *reg_wrap_vstatus = regAddr->reg_wrap_vstatus;
+	void __iomem *reg_gusb2phyacc0 = regAddr->reg_gusb2phyacc0;
+	int shift_bits = regAddr->vstatus_index * 8;
+	int ret = 0;
+
+	/* write data to VStatusOut2 (data output to phy) */
+	writel((u32)data<<shift_bits, reg_wrap_vstatus);
+
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return ret;
+
+	/* VCtrl = low nibble of addr, set PHY_NEW_REG_REQ */
+	regVal = PHY_NEW_REG_REQ | (GET_LOW_NIBBLE(addr) << PHY_VCTRL_SHIFT);
+
+	writel(regVal, reg_gusb2phyacc0);
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return ret;
+
+	/* VCtrl = high nibble of addr, set PHY_NEW_REG_REQ */
+	regVal = PHY_NEW_REG_REQ | (GET_HIGH_NIBBLE(addr) << PHY_VCTRL_SHIFT);
+
+	writel(regVal, reg_gusb2phyacc0);
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int rtk_usb_phy_set_page(struct reg_addr *regAddr, int page)
+{
+	switch (page) {
+	case 0:
+		return rtk_usb_phy_write(regAddr, SET_PAGE_OFFSET, SET_PAGE_0);
+	case 1:
+		return rtk_usb_phy_write(regAddr, SET_PAGE_OFFSET, SET_PAGE_1);
+	case 2:
+		return rtk_usb_phy_write(regAddr, SET_PAGE_OFFSET, SET_PAGE_2);
+	default:
+		pr_err("%s error page=%d\n", __func__, page);
+	}
+
+	return -1;
+}
+
+#define USB_CTRL 0x0 /* usb ctrl at 0x98007FB0 */
+#define ISO_USB_U2PHY_REG_LDO_PW (BIT(20) | BIT(21) | BIT(22) | BIT(23))
+
+static int control_phy_power(struct rtk_usb_phy *rtk_phy,
+	    struct phy_data *phy_data, struct reg_addr *regAddr)
+{
+	int use_ldo = 0;
+	unsigned int val;
+
+	if (!rtk_phy->usb_ctrl_regs) {
+		dev_info(rtk_phy->dev, "%s No usb_ctrl_regs can't set USB_CTRL\n",
+			    __func__);
+		return use_ldo;
+	}
+
+	if (regmap_read(rtk_phy->usb_ctrl_regs, USB_CTRL, &val)) {
+		dev_err(rtk_phy->dev, "%s Get USB_CTRL fail\n", __func__);
+		return use_ldo;
+	}
+
+	if ((val & ISO_USB_U2PHY_REG_LDO_PW) == ISO_USB_U2PHY_REG_LDO_PW) {
+		dev_info(rtk_phy->dev, "%s phy use ldo power! (USB_CTRL val=0x%x)\n",
+			    __func__, val);
+		use_ldo = 1;
+		goto out;
+	}
+
+	if (phy_data->ldo_force_enable) {
+		regmap_update_bits(rtk_phy->usb_ctrl_regs, USB_CTRL,
+			    (unsigned int)ISO_USB_U2PHY_REG_LDO_PW,
+			    (unsigned int)ISO_USB_U2PHY_REG_LDO_PW);
+		use_ldo = 1;
+
+		dev_info(rtk_phy->dev, "%s phy %s then turn on ldo! USB_CTRL val=0x%x\n",
+			    __func__,
+			    phy_data->ldo_force_enable ?
+			      "ldo_force_enable":"no power",
+			    val);
+	}
+
+out:
+	return use_ldo;
+}
+
+static u8 __updated_page0_0xe4_parameter(struct phy_data *phy_data, u8 data)
+{
+	u8 val;
+	s32 __val;
+	s32 driving_compensate = 0;
+	s32 usb_dc_cal_mask = phy_data->usb_dc_cal_mask;
+
+	if (phy_data->check_efuse_version == CHECK_EFUSE_V1) {
+		if (phy_data->ldo_enable)
+			driving_compensate = phy_data->ldo_driving_compensate;
+
+		__val = (s32)(data & usb_dc_cal_mask) + driving_compensate
+			    + phy_data->efuse_usb_dc_cal;
+	} else { /* for CHECK_EFUSE_V2 or no efuse */
+		driving_compensate = phy_data->driving_compensate;
+
+		if (phy_data->efuse_usb_dc_cal)
+			__val = (s32)((phy_data->efuse_usb_dc_cal & usb_dc_cal_mask)
+				    + driving_compensate);
+		else
+			__val = (s32)(data & usb_dc_cal_mask);
+	}
+
+	if (__val > usb_dc_cal_mask)
+		__val = usb_dc_cal_mask;
+	else if (__val < 0)
+		__val = 0;
+
+	val = (data & (~usb_dc_cal_mask)) | (__val & usb_dc_cal_mask);
+
+	return val;
+}
+
+static u8 __updated_dc_disconnect_level_page0_0xe4(struct phy_data *phy_data,
+	    u8 data)
+{
+	u8 val;
+	s32 __val;
+	s32 usb_dc_dis_mask = phy_data->usb_dc_dis_mask;
+	int offset = 4;
+
+	__val = (s32)((data >> offset) & usb_dc_dis_mask)
+		     + phy_data->efuse_usb_dc_dis;
+
+	if (__val > usb_dc_dis_mask)
+		__val = usb_dc_dis_mask;
+	else if (__val < 0)
+		__val = 0;
+
+	val = (data & (~(usb_dc_dis_mask << offset))) |
+		    (__val & usb_dc_dis_mask) << offset;
+
+	return val;
+}
+
+/* updated disconnect level at page0 0xe4 */
+static void update_dc_disconnect_level_at_page0(struct rtk_usb_phy *rtk_phy,
+	    struct reg_addr *regAddr,
+	    struct phy_data *phy_data, bool isUpdate)
+{
+	struct phy_parameter *phy_parameter_page;
+	int i;
+
+	/* Set page 0 */
+	phy_parameter_page = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE4);
+	if (i < phy_data->page0_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+		u8 __data;
+		int offset = 4;
+		s32 usb_dc_dis_mask = phy_data->usb_dc_dis_mask;
+
+		__data = rtk_usb_phy_read(regAddr, addr);
+
+		/* keep default dc dis and real dc cal */
+		data = (data & ((usb_dc_dis_mask << offset))) |
+			    (__data & (~(usb_dc_dis_mask << offset)));
+
+		if (isUpdate)
+			data = __updated_dc_disconnect_level_page0_0xe4(phy_data, data);
+
+		if (rtk_usb_phy_write(regAddr, addr, data)) {
+			dev_err(rtk_phy->dev,
+				    "[%s:%d] Error page1 addr=0x%x value=0x%x\n",
+				    __func__, __LINE__,
+				    addr, data);
+			return;
+		}
+
+		dev_info(rtk_phy->dev,
+			    "%s to set Page0 0xE4=%x for dc disconnect level (%s)\n",
+			    __func__,
+			    rtk_usb_phy_read(regAddr, addr),
+			    isUpdate?"Update":"restore");
+	} else {
+		dev_err(rtk_phy->dev,
+			    "ERROR: %s %d index=%d addr Not PAGE0_0xE4\n",
+			    __func__, __LINE__, i);
+	}
+}
+
+static u8 __updated_dc_disconnect_level_page1_0xe2(struct phy_data *phy_data,
+	    u8 data)
+{
+	u8 val;
+	s32 __val;
+	s32 usb_dc_dis_mask = phy_data->usb_dc_dis_mask;
+
+	if (phy_data->check_efuse_version == CHECK_EFUSE_V1) {
+		__val = (s32)(data & usb_dc_dis_mask)
+			    + phy_data->efuse_usb_dc_dis;
+	} else { /* for CHECK_EFUSE_V2 or no efuse */
+		if (phy_data->efuse_usb_dc_dis)
+			__val = (s32)(phy_data->efuse_usb_dc_dis & usb_dc_dis_mask);
+		else
+			__val = (s32)(data & usb_dc_dis_mask);
+	}
+
+	if (__val > usb_dc_dis_mask)
+		__val = usb_dc_dis_mask;
+	else if (__val < 0)
+		__val = 0;
+
+	val = (data & (~usb_dc_dis_mask)) | (__val & usb_dc_dis_mask);
+
+	return val;
+}
+
+/* updated disconnect level at page1 0xe2 */
+static void update_dc_disconnect_level_at_page1(struct rtk_usb_phy *rtk_phy,
+	    struct reg_addr *regAddr,
+	    struct phy_data *phy_data, bool isUpdate)
+{
+	struct phy_parameter *phy_parameter_page;
+	int i;
+
+	/* Set page 1 */
+	phy_parameter_page = phy_data->page1;
+	rtk_usb_phy_set_page(regAddr, 1);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE1_0xE2);
+	if (i < phy_data->page1_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+		u8 __data;
+		s32 usb_dc_dis_mask = phy_data->usb_dc_dis_mask;
+
+		__data = rtk_usb_phy_read(regAddr, addr);
+
+		data = (data & usb_dc_dis_mask) | (__data & ~(usb_dc_dis_mask));
+
+		if (isUpdate)
+			data = __updated_dc_disconnect_level_page1_0xe2(phy_data, data);
+
+		if (rtk_usb_phy_write(regAddr, addr, data)) {
+			dev_err(rtk_phy->dev,
+				    "[%s:%d] Error page1 addr=0x%x value=0x%x\n",
+				    __func__, __LINE__,
+				    addr, data);
+			return;
+		}
+
+		dev_info(rtk_phy->dev,
+			    "%s to set Page1 0xE2=%x for dc disconnect level (%s)\n",
+			    __func__,
+			    rtk_usb_phy_read(regAddr, addr),
+			    isUpdate?"Update":"restore");
+	} else {
+		dev_err(rtk_phy->dev,
+			    "ERROR: %s %d index=%d addr Not PAGE1_0xE2\n",
+			    __func__, __LINE__, i);
+	}
+}
+
+static void update_dc_disconnect_level(struct rtk_usb_phy *rtk_phy,
+	    struct reg_addr *regAddr,
+	    struct phy_data *phy_data, bool isUpdate)
+{
+	if (phy_data->usb_dc_dis_at_page0)
+		update_dc_disconnect_level_at_page0(
+			    rtk_phy, regAddr, phy_data, isUpdate);
+	else
+		update_dc_disconnect_level_at_page1(
+			    rtk_phy, regAddr, phy_data, isUpdate);
+}
+
+static void do_rtk_usb_phy_toggle(struct rtk_usb_phy *rtk_phy,
+	    int index, bool isConnect)
+{
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
+	struct phy_parameter *phy_parameter_page;
+	int i;
+
+	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+	if (!phy_data->do_toggle)
+		goto out;
+
+	if (phy_data->is_double_sensitivity_mode)
+		goto do_toggle_driving;
+
+	/* Set page 0 */
+	phy_parameter_page = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE7);
+	if (i < phy_data->page0_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		if (isConnect) {
+			rtk_usb_phy_write(regAddr, addr, data &
+				    (~(BIT(4) | BIT(5) | BIT(6))));
+		} else {
+			rtk_usb_phy_write(regAddr, addr, data |
+				    (BIT(4) | BIT(5) | BIT(6)));
+		}
+		dev_info(rtk_phy->dev,
+			    "%s %sconnect to set Page0 0xE7=%x\n",
+			    __func__,
+			    isConnect?"":"dis",
+			    rtk_usb_phy_read(regAddr, addr));
+	} else {
+		dev_err(rtk_phy->dev,
+			    "ERROR: %s %d index=%d addr Not PAGE0_0xE7\n",
+			    __func__, __LINE__, i);
+	}
+
+do_toggle_driving:
+
+	if (!phy_data->do_toggle_driving)
+		goto do_toggle;
+
+	/* Page 0 addr 0xE4 driving capability */
+
+	/* Set page 0 */
+	phy_parameter_page = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE4);
+	if (i < phy_data->page0_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		data = __updated_page0_0xe4_parameter(phy_data, data);
+
+		if (isConnect) {
+			rtk_usb_phy_write(regAddr, addr, data);
+		} else {
+			u8 val;
+			s32 __val;
+			s32 driving_updated =
+				    phy_data->disconnect_driving_updated;
+			s32 usb_dc_cal_mask = phy_data->usb_dc_cal_mask;
+
+			__val = (s32)(data & usb_dc_cal_mask) + driving_updated;
+
+			if (__val > usb_dc_cal_mask)
+				__val = usb_dc_cal_mask;
+			else if (__val < 0)
+				__val = 0;
+
+			val = (data & (~usb_dc_cal_mask)) | (__val & usb_dc_cal_mask);
+
+			rtk_usb_phy_write(regAddr, addr, val);
+		}
+		dev_info(rtk_phy->dev,
+			    "%s %sconnect to set Page0 0xE4=%x for driving\n",
+			    __func__,
+			    isConnect?"":"dis",
+			    rtk_usb_phy_read(regAddr, addr));
+	} else {
+		dev_err(rtk_phy->dev,
+			    "ERROR: %s %d index=%d addr Not PAGE0_0xE4\n",
+			    __func__, __LINE__, i);
+	}
+
+do_toggle:
+	/* restore dc disconnect level before toggle */
+	update_dc_disconnect_level(rtk_phy, regAddr, phy_data, false);
+
+	/* Set page 1 */
+	phy_parameter_page = phy_data->page1;
+	rtk_usb_phy_set_page(regAddr, 1);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE1_0xE0);
+	if (i < phy_data->page1_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		dev_info(rtk_phy->dev,
+			    "%s ########## to toggle PAGE1_0xE0 BIT(2)\n",
+			    __func__);
+		rtk_usb_phy_write(regAddr, addr, data & (~BIT(2)));
+		mdelay(1);
+		rtk_usb_phy_write(regAddr, addr, data | (BIT(2)));
+	} else {
+		dev_err(rtk_phy->dev,
+			    "ERROR: %s %d index=%d addr Not PAGE1_0xE0\n",
+			    __func__, __LINE__, i);
+	}
+
+	/* update dc disconnect level after toggle */
+	update_dc_disconnect_level(rtk_phy, regAddr, phy_data, true);
+
+out:
+	return;
+}
+
+/* Get default phy parameter for update */
+static int __get_default_phy_parameter_for_updated(
+	    struct rtk_usb_phy *rtk_phy, int index)
+{
+	int i;
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
+	struct phy_parameter *phy_parameter_page;
+
+	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+	phy_parameter_page = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	/* Get PAGE0_0xE4 default value */
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE4);
+	if (i < phy_data->page0_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			phy_parameter->addr = addr;
+			phy_parameter->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default addr %x value %x\n",
+				    phy_parameter->addr,
+				    phy_parameter->data);
+		}
+	}
+
+	/* Get PAGE0_0xE7 default value */
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE7);
+	if (i < phy_data->page0_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			phy_parameter->addr = addr;
+			phy_parameter->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default addr %x value %x\n",
+				    phy_parameter->addr,
+				    phy_parameter->data);
+		}
+	}
+
+	phy_parameter_page = phy_data->page1;
+	rtk_usb_phy_set_page(regAddr, 1);
+
+	/* Get PAGE1_0xE0 default value */
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE1_0xE0);
+	if (i < phy_data->page1_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			phy_parameter->addr = addr;
+			phy_parameter->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default page1 addr %x value %x\n",
+				    phy_parameter->addr,
+				    phy_parameter->data);
+		}
+	}
+
+	/* Get PAGE1_0xE2 default value */
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE1_0xE2);
+	if (i < phy_data->page1_size) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			phy_parameter->addr = addr;
+			phy_parameter->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default page1 addr %x value %x\n",
+				    phy_parameter->addr,
+				    phy_parameter->data);
+		}
+	}
+
+	return 0;
+}
+
+static int do_rtk_usb_phy_init(struct rtk_usb_phy *rtk_phy, int index)
+{
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
+	struct phy_parameter *phy_parameter_page;
+	int i;
+
+	dev_dbg(rtk_phy->dev, "%s: init phy#%d\n", __func__, index);
+
+	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+	if (control_phy_power(rtk_phy, phy_data, regAddr)) {
+		phy_data->ldo_enable = true;
+		dev_info(rtk_phy->dev, "%s USB phy use ldo power compensate phy parameter (%d)\n",
+		    __func__, phy_data->ldo_driving_compensate);
+	}
+
+	__get_default_phy_parameter_for_updated(rtk_phy, index);
+
+	if (phy_data->use_default_parameter) {
+		dev_info(rtk_phy->dev, "%s phy#%d use default parameter\n",
+			    __func__, index);
+		goto do_toggle;
+	}
+
+	/* Set page 0 */
+	phy_parameter_page = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	for (i = 0; i < phy_data->page0_size; i++) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		if (!addr)
+			continue;
+
+		if (addr == PAGE0_0xE4)
+			data = __updated_page0_0xe4_parameter(phy_data, data);
+
+		if (rtk_usb_phy_write(regAddr, addr, data)) {
+			dev_err(rtk_phy->dev,
+				    "[%s:%d] Error page0 addr=0x%x value=0x%x\n",
+				    __func__, __LINE__, addr, data);
+			return -EINVAL;
+		}
+		dev_dbg(rtk_phy->dev, "[%s:%d] Good page0 addr=0x%x value=0x%x\n",
+			    __func__, __LINE__, addr,
+			    rtk_usb_phy_read(regAddr, addr));
+	}
+
+	/* Set page 1 */
+	phy_parameter_page = phy_data->page1;
+	rtk_usb_phy_set_page(regAddr, 1);
+
+	for (i = 0; i < phy_data->page1_size; i++) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		if (!addr)
+			continue;
+
+		if (rtk_usb_phy_write(regAddr, addr, data)) {
+			dev_err(rtk_phy->dev,
+				    "[%s:%d] Error page1 addr=0x%x value=0x%x\n",
+				    __func__, __LINE__,
+				    addr, data);
+			return -EINVAL;
+		}
+		dev_dbg(rtk_phy->dev, "[%s:%d] Good page1 addr=0x%x value=0x%x\n",
+			    __func__, __LINE__, addr,
+			    rtk_usb_phy_read(regAddr, addr));
+	}
+
+	if (phy_data->page2_size == 0)
+		goto do_toggle;
+
+	/* Set page 2 */
+	phy_parameter_page = phy_data->page2;
+	rtk_usb_phy_set_page(regAddr, 2);
+
+	for (i = 0; i < phy_data->page2_size; i++) {
+		struct phy_parameter *phy_parameter = phy_parameter_page + i;
+		u8 addr = phy_parameter->addr;
+		u8 data = phy_parameter->data;
+
+		if (!addr)
+			continue;
+
+		if (rtk_usb_phy_write(regAddr, addr, data)) {
+			dev_err(rtk_phy->dev,
+				    "[%s:%d] Error page2 addr=0x%x value=0x%x\n",
+				    __func__, __LINE__, addr, data);
+			return -1;
+		}
+		dev_dbg(rtk_phy->dev, "[%s:%d] Good page2 addr=0x%x value=0x%x\n",
+			    __func__, __LINE__, addr,
+			    rtk_usb_phy_read(regAddr, addr));
+	}
+
+do_toggle:
+	do_rtk_usb_phy_toggle(rtk_phy, index, false);
+
+	return 0;
+}
+
+static int rtk_usb_phy_init(struct phy *phy)
+{
+	struct rtk_usb_phy *rtk_phy = phy_get_drvdata(phy);
+	unsigned long phy_init_time = jiffies;
+	int i, ret = 0;
+
+	if (!rtk_phy)
+		return -EINVAL;
+
+	dev_dbg(rtk_phy->dev, "Init RTK USB 2.0 PHY\n");
+	for (i = 0; i < rtk_phy->phyN; i++)
+		ret = do_rtk_usb_phy_init(rtk_phy, i);
+
+	dev_info(rtk_phy->dev, "Initialized RTK USB 2.0 PHY (take %dms)\n",
+		    jiffies_to_msecs(jiffies - phy_init_time));
+	return ret;
+}
+
+static int rtk_usb_phy_exit(struct phy *phy)
+{
+	struct rtk_usb_phy *rtk_phy = phy_get_drvdata(phy);
+
+	if (!rtk_phy)
+		return -EINVAL;
+
+	dev_info(rtk_phy->dev, "Exit RTK USB 2.0 PHY\n");
+
+	return 0;
+}
+
+static const struct phy_ops ops = {
+	.init		= rtk_usb_phy_init,
+	.exit		= rtk_usb_phy_exit,
+	.owner		= THIS_MODULE,
+};
+
+static void rtk_usb_phy_toggle(struct usb_phy *usb2_phy, bool isConnect, int port)
+{
+	int index = port;
+	struct rtk_usb_phy *rtk_phy = NULL;
+
+	if (usb2_phy != NULL && usb2_phy->dev != NULL)
+		rtk_phy = dev_get_drvdata(usb2_phy->dev);
+
+	if (rtk_phy == NULL) {
+		pr_err("%s %d ERROR! NO this device\n", __func__, __LINE__);
+		return;
+	}
+	if (index > rtk_phy->phyN) {
+		pr_err("%s %d ERROR! port=%d > phyN=%d\n",
+			    __func__, __LINE__, index, rtk_phy->phyN);
+		return;
+	}
+
+	do_rtk_usb_phy_toggle(rtk_phy, index, isConnect);
+}
+
+static int rtk_usb_phy_notify_port_status(struct usb_phy *x, int port,
+	    u16 portstatus, u16 portchange)
+{
+	bool isConnect = false;
+
+	pr_debug("%s port=%d portstatus=0x%x portchange=0x%x\n",
+		    __func__, port, (int)portstatus, (int)portchange);
+	if (portstatus & USB_PORT_STAT_CONNECTION)
+		isConnect = true;
+
+	if (portchange & USB_PORT_STAT_C_CONNECTION)
+		rtk_usb_phy_toggle(x, isConnect, port);
+
+	return 0;
+}
+
+#ifdef CONFIG_DEBUG_FS
+static struct dentry *create_phy_debug_root(void)
+{
+	struct dentry *phy_debug_root;
+
+	phy_debug_root = debugfs_lookup("phy", usb_debug_root);
+	if (!phy_debug_root) {
+		phy_debug_root = debugfs_create_dir("phy", usb_debug_root);
+		if (!phy_debug_root)
+			pr_err("%s Error phy_debug_root is NULL\n", __func__);
+		else
+			pr_debug("%s Create phy_debug_root folder\n", __func__);
+	}
+
+	return phy_debug_root;
+}
+
+static int rtk_usb2_parameter_show(struct seq_file *s, void *unused)
+{
+	struct rtk_usb_phy		*rtk_phy = s->private;
+	int i, index;
+
+	for (index = 0; index < rtk_phy->phyN; index++) {
+		struct reg_addr *regAddr =
+			    &((struct reg_addr *)rtk_phy->reg_addr)[index];
+		struct phy_data *phy_data =
+			    &((struct phy_data *)rtk_phy->phy_data)[index];
+		struct phy_parameter *phy_parameter_page;
+
+		seq_printf(s, "PHY %d:\n", index);
+
+		seq_puts(s, "Page 0:\n");
+		/* Set page 0 */
+		phy_parameter_page = phy_data->page0;
+		rtk_usb_phy_set_page(regAddr, 0);
+
+		for (i = 0; i < phy_data->page0_size; i++) {
+			struct phy_parameter *phy_parameter = phy_parameter_page + i;
+			u8 addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			u8 data = phy_parameter->data;
+			u8 value = rtk_usb_phy_read(regAddr, addr);
+
+			if (phy_parameter->addr)
+				seq_printf(s, "Page 0: addr=0x%x data=0x%02x ==> read value=0x%02x\n",
+					    addr, data, value);
+			else
+				seq_printf(s, "Page 0: addr=0x%x data=none ==> read value=0x%02x\n",
+					    addr, value);
+		}
+
+		seq_puts(s, "Page 1:\n");
+		/* Set page 1 */
+		phy_parameter_page = phy_data->page1;
+		rtk_usb_phy_set_page(regAddr, 1);
+
+		for (i = 0; i < phy_data->page1_size; i++) {
+			struct phy_parameter *phy_parameter = phy_parameter_page + i;
+			u8 addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			u8 data = phy_parameter->data;
+			u8 value = rtk_usb_phy_read(regAddr, addr);
+
+			if (phy_parameter->addr)
+				seq_printf(s, "Page 1: addr=0x%x data=0x%02x ==> read value=0x%02x\n",
+					    addr, data, value);
+			else
+				seq_printf(s, "Page 1: addr=0x%x data=none ==> read value=0x%02x\n",
+					    addr, value);
+		}
+
+		if (phy_data->page2_size == 0)
+			goto out;
+
+		seq_puts(s, "Page 2:\n");
+		/* Set page 2 */
+		phy_parameter_page = phy_data->page2;
+		rtk_usb_phy_set_page(regAddr, 2);
+
+		for (i = 0; i < phy_data->page2_size; i++) {
+			struct phy_parameter *phy_parameter = phy_parameter_page + i;
+			u8 addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			u8 data = phy_parameter->data;
+			u8 value = rtk_usb_phy_read(regAddr, addr);
+
+			if (phy_parameter->addr)
+				seq_printf(s, "Page 2: addr=0x%x data=0x%02x ==> read value=0x%02x\n",
+					    addr, data, value);
+			else
+				seq_printf(s, "Page 2: addr=0x%x data=none ==> read value=0x%02x\n",
+					    addr, value);
+		}
+
+out:
+		seq_puts(s, "Property:\n");
+		seq_printf(s, "check_efuse: %s\n",
+			    phy_data->check_efuse?"Enable":"Disable");
+		seq_printf(s, "check_efuse_version: %d\n",
+			    phy_data->check_efuse_version);
+		seq_printf(s, "efuse_usb_dc_cal: %d\n",
+			    (int)phy_data->efuse_usb_dc_cal);
+		seq_printf(s, "efuse_usb_dc_cal_rate: %d\n",
+			    phy_data->efuse_usb_dc_cal_rate);
+		seq_printf(s, "usb_dc_cal_mask: 0x%x\n",
+			    phy_data->usb_dc_cal_mask);
+		seq_printf(s, "efuse_usb_dc_dis: %d\n",
+			    (int)phy_data->efuse_usb_dc_dis);
+		seq_printf(s, "efuse_usb_dc_dis_rate: %d\n",
+			    phy_data->efuse_usb_dc_dis_rate);
+		seq_printf(s, "usb_dc_dis_mask: 0x%x\n",
+			    phy_data->usb_dc_dis_mask);
+		seq_printf(s, "usb_dc_dis_at_page0: %s\n",
+			    phy_data->usb_dc_dis_at_page0?"true":"false");
+		seq_printf(s, "do_toggle: %s\n",
+			    phy_data->do_toggle?"Enable":"Disable");
+		seq_printf(s, "do_toggle_driving: %s\n",
+			    phy_data->do_toggle_driving?"Enable":"Disable");
+		seq_printf(s, "disconnect_driving_updated: 0x%x\n",
+			    phy_data->disconnect_driving_updated);
+		seq_printf(s, "use_default_parameter: %s\n",
+			    phy_data->use_default_parameter?"Enable":"Disable");
+		seq_printf(s, "is_double_sensitivity_mode: %s\n",
+			    phy_data->is_double_sensitivity_mode?"Enable":"Disable");
+		seq_printf(s, "ldo_force_enable: %s\n",
+			    phy_data->ldo_force_enable?"Enable":"Disable");
+		seq_printf(s, "ldo_enable: %s\n",
+			    phy_data->ldo_enable?"Enable":"Disable");
+		seq_printf(s, "ldo_driving_compensate: %d\n",
+			    phy_data->ldo_driving_compensate);
+		seq_printf(s, "driving_compensate: %d\n",
+			    phy_data->driving_compensate);
+	}
+
+	return 0;
+}
+
+static int rtk_usb2_parameter_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtk_usb2_parameter_show, inode->i_private);
+}
+
+static const struct file_operations rtk_usb2_parameter_fops = {
+	.open			= rtk_usb2_parameter_open,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+static int __get_parameter_at_page(struct seq_file *s,
+	    struct rtk_usb_phy *rtk_phy,
+	    struct phy_parameter *phy_parameter_page,
+	    const char *phy_page, const char *phy_addr)
+{
+	struct phy_parameter *phy_parameter;
+	uint32_t addr;
+	int i, ret;
+
+	ret = kstrtouint(phy_addr, 16, &addr);
+	if (ret < 0) {
+		pr_err("%s::kstrtouint() failed\n", __func__);
+		return -EINVAL;
+	}
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+	phy_parameter = (phy_parameter_page + i);
+
+	if (phy_parameter->addr)
+		seq_printf(s, "Now Parameter %s addr 0x%02x = 0x%02x\n",
+			    phy_page, phy_parameter->addr, phy_parameter->data);
+	else
+		seq_printf(s, "Now Parameter %s addr 0x%02x is default\n",
+			    phy_page, addr);
+
+	dev_dbg(rtk_phy->dev, "%s addr=0x%02x data=0x%02x\n",
+		    __func__, phy_parameter->addr, phy_parameter->data);
+
+	return 0;
+}
+
+static int __set_parameter_at_page(
+	    struct rtk_usb_phy *rtk_phy,
+	    struct reg_addr *regAddr, struct phy_data *phy_data,
+	    struct phy_parameter *phy_parameter_page,
+	    const char *phy_page, const char *phy_addr, const char *phy_value)
+{
+	struct phy_parameter *phy_parameter;
+	uint32_t addr, value;
+	int i, ret;
+
+	ret = kstrtouint(phy_addr, 16, &addr);
+	if (ret < 0)
+		return -EINVAL;
+
+	ret = kstrtouint(phy_value, 16, &value);
+	if (ret < 0)
+		return -EINVAL;
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+	phy_parameter = (phy_parameter_page + i);
+
+	if (phy_parameter->addr) {
+		phy_parameter->data = value;
+	} else {
+		phy_parameter->addr = addr;
+		phy_parameter->data = value;
+	}
+
+	dev_dbg(rtk_phy->dev, "%s addr=0x%02x data=0x%02x\n",
+		    __func__, phy_parameter->addr, phy_parameter->data);
+
+	if (strcmp("page0", phy_page) == 0 && (addr == PAGE0_0xE4))
+		value = __updated_page0_0xe4_parameter(phy_data, value);
+
+	if (rtk_usb_phy_write(regAddr, addr, value))
+		dev_err(rtk_phy->dev,
+				    "[%s:%d] Error: addr=0x%02x value=0x%02x\n",
+				    __func__, __LINE__, addr, value);
+
+	return 0;
+}
+
+static int rtk_usb2_set_parameter_show(struct seq_file *s, void *unused)
+{
+	struct rtk_usb_phy *rtk_phy = s->private;
+	const struct file *file = s->file;
+	const char *file_name = file_dentry(file)->d_iname;
+	struct dentry *p_dentry = file_dentry(file)->d_parent;
+	const char *dir_name = p_dentry->d_iname;
+	struct dentry *pp_dentry = p_dentry->d_parent;
+	const char *phy_dir_name = pp_dentry->d_iname;
+	int ret = 0;
+	int index;
+	struct phy_data *phy_data = NULL;
+
+	for (index = 0; index < rtk_phy->phyN; index++) {
+		size_t sz = 30;
+		char name[30] = {0};
+
+		snprintf(name, sz, "phy%d", index);
+		if (strncmp(name, phy_dir_name, strlen(name)) == 0) {
+			phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+			break;
+		}
+	}
+	if (!phy_data) {
+		dev_err(rtk_phy->dev,
+				    "%s: No phy_data for %s/%s/%s\n",
+				    __func__, phy_dir_name, dir_name, file_name);
+		return -EINVAL;
+	}
+
+	if (strcmp("page0", dir_name) == 0)
+		ret = __get_parameter_at_page(s, rtk_phy, phy_data->page0,
+			    dir_name, file_name);
+	else if (strcmp("page1", dir_name) == 0)
+		ret = __get_parameter_at_page(s, rtk_phy, phy_data->page1,
+			    dir_name, file_name);
+	else if (strcmp("page2", dir_name) == 0)
+		ret = __get_parameter_at_page(s, rtk_phy, phy_data->page2,
+			    dir_name, file_name);
+
+	if (ret < 0)
+		return ret;
+
+	seq_puts(s, "Set phy parameter by following command\n");
+	seq_printf(s, "echo \"value\" > %s/%s/%s\n",
+		    phy_dir_name, dir_name, file_name);
+
+	return 0;
+}
+
+static int rtk_usb2_set_parameter_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtk_usb2_set_parameter_show, inode->i_private);
+}
+
+static ssize_t rtk_usb2_set_parameter_write(struct file *file,
+		const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	const char *file_name = file_dentry(file)->d_iname;
+	struct dentry *p_dentry = file_dentry(file)->d_parent;
+	const char *dir_name = p_dentry->d_iname;
+	struct dentry *pp_dentry = p_dentry->d_parent;
+	const char *phy_dir_name = pp_dentry->d_iname;
+	struct seq_file		*s = file->private_data;
+	struct rtk_usb_phy		*rtk_phy = s->private;
+	struct reg_addr *regAddr = NULL;
+	struct phy_data *phy_data = NULL;
+	int ret = 0;
+	char buffer[40] = {0};
+	int index;
+
+	if (copy_from_user(&buffer, ubuf,
+		    min_t(size_t, sizeof(buffer) - 1, count)))
+		return -EFAULT;
+
+	for (index = 0; index < rtk_phy->phyN; index++) {
+		size_t sz = 30;
+		char name[30] = {0};
+
+		snprintf(name, sz, "phy%d", index);
+		if (strncmp(name, phy_dir_name, strlen(name)) == 0) {
+			regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
+			phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+			break;
+		}
+	}
+	if (!regAddr) {
+		dev_err(rtk_phy->dev,
+				    "%s: No regAddr for %s/%s/%s\n",
+				    __func__, phy_dir_name, dir_name, file_name);
+		return -EINVAL;
+	}
+	if (!phy_data) {
+		dev_err(rtk_phy->dev,
+				    "%s: No phy_data for %s/%s/%s\n",
+				    __func__, phy_dir_name, dir_name, file_name);
+		return -EINVAL;
+	}
+
+	if (strcmp("page0", dir_name) == 0) {
+		rtk_usb_phy_set_page(regAddr, 0);
+		ret = __set_parameter_at_page(rtk_phy, regAddr, phy_data,
+			    phy_data->page0, dir_name, file_name, buffer);
+	} else if (strcmp("page1", dir_name) == 0) {
+		rtk_usb_phy_set_page(regAddr, 1);
+		ret = __set_parameter_at_page(rtk_phy, regAddr, phy_data,
+			    phy_data->page1, dir_name, file_name, buffer);
+	} else if (strcmp("page2", dir_name) == 0) {
+		rtk_usb_phy_set_page(regAddr, 2);
+		ret = __set_parameter_at_page(rtk_phy, regAddr, phy_data,
+			    phy_data->page2, dir_name, file_name, buffer);
+	}
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations rtk_usb2_set_parameter_fops = {
+	.open			= rtk_usb2_set_parameter_open,
+	.write			= rtk_usb2_set_parameter_write,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+static int rtk_usb2_toggle_show(struct seq_file *s, void *unused)
+{
+	struct rtk_usb_phy *rtk_phy = s->private;
+	struct phy_data *phy_data;
+	int i;
+
+	for (i = 0; i < rtk_phy->phyN; i++) {
+		phy_data = &((struct phy_data *)rtk_phy->phy_data)[i];
+		seq_printf(s, "Now phy#%d do_toggle is %s.\n",
+			    i, phy_data->do_toggle?"Enable":"Disable");
+	}
+	seq_puts(s, "ehco 1 to enable toggle phy parameter.\n");
+
+	return 0;
+}
+
+static int rtk_usb2_toggle_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtk_usb2_toggle_show, inode->i_private);
+}
+
+static ssize_t rtk_usb2_toggle_write(struct file *file,
+		const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	struct seq_file		*s = file->private_data;
+	struct rtk_usb_phy		*rtk_phy = s->private;
+	char			buf[32];
+	struct phy_data *phy_data;
+	bool enable = false;
+	int i;
+
+	if (copy_from_user(&buf, ubuf, min_t(size_t, sizeof(buf) - 1, count)))
+		return -EFAULT;
+
+	if (!strncmp(buf, "1", 1))
+		enable = true;
+
+	for (i = 0; i < rtk_phy->phyN; i++) {
+		phy_data = &((struct phy_data *)rtk_phy->phy_data)[i];
+		phy_data->do_toggle = enable;
+		dev_info(rtk_phy->dev, "Set phy#%d do_toggle is %s.\n",
+			    i, phy_data->do_toggle?"Enable":"Disable");
+	}
+
+	return count;
+}
+
+static const struct file_operations rtk_usb2_toggle_fops = {
+	.open			= rtk_usb2_toggle_open,
+	.write			= rtk_usb2_toggle_write,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+static int create_debug_set_parameter_files(struct rtk_usb_phy *rtk_phy,
+	    struct dentry *phy_dir, const char *page, size_t addr_size)
+{
+	struct dentry *page_dir;
+	int i;
+
+	page_dir = debugfs_create_dir(page, phy_dir);
+	if (!page_dir) {
+		dev_err(rtk_phy->dev,
+			    "%s Error create folder %s fail\n",
+			    __func__, page);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < addr_size; i++) {
+		size_t sz = 30;
+		char name[30] = {0};
+
+		snprintf(name, sz, "%x", ARRAY_INDEX_MAP_PAGE_ADDR(i));
+
+		if (!debugfs_create_file(name, 0644,
+			    page_dir, rtk_phy,
+			    &rtk_usb2_set_parameter_fops))
+			dev_err(rtk_phy->dev,
+				    "%s Error create file %s/%s fail",
+				    page, name, __func__);
+	}
+
+	return 0;
+}
+
+static inline void create_debug_files(struct rtk_usb_phy *rtk_phy)
+{
+	struct dentry *phy_debug_root = NULL;
+	struct dentry *set_parameter_dir = NULL;
+
+	phy_debug_root = create_phy_debug_root();
+
+	if (!phy_debug_root) {
+		dev_err(rtk_phy->dev, "%s Error phy_debug_root is NULL",
+			    __func__);
+		return;
+	}
+
+	rtk_phy->debug_dir = debugfs_create_dir(dev_name(rtk_phy->dev),
+		    phy_debug_root);
+	if (!rtk_phy->debug_dir) {
+		dev_err(rtk_phy->dev, "%s Error debug_dir is NULL", __func__);
+		return;
+	}
+
+	if (!debugfs_create_file("parameter", 0444, rtk_phy->debug_dir, rtk_phy,
+		    &rtk_usb2_parameter_fops))
+		goto file_error;
+
+	set_parameter_dir = debugfs_create_dir("set_parameter",
+		    rtk_phy->debug_dir);
+	if (set_parameter_dir) {
+		int index, ret;
+
+		for (index = 0; index < rtk_phy->phyN; index++) {
+			struct dentry *phy_dir;
+			struct phy_data *phy_data;
+			size_t sz = 30;
+			char name[30] = {0};
+
+			snprintf(name, sz, "phy%d", index);
+
+			phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+			phy_dir = debugfs_create_dir(name, set_parameter_dir);
+			if (!phy_dir) {
+				dev_err(rtk_phy->dev,
+					    "%s Error create folder %s fail\n",
+					    name, __func__);
+				goto file_error;
+			}
+
+			ret = create_debug_set_parameter_files(rtk_phy, phy_dir,
+				    "page0", phy_data->page0_size);
+			if (ret < 0) {
+				dev_err(rtk_phy->dev,
+					    "%s Error create files for page0 fail\n",
+					    __func__);
+				goto file_error;
+			}
+
+			ret = create_debug_set_parameter_files(rtk_phy, phy_dir,
+				    "page1", phy_data->page1_size);
+			if (ret < 0) {
+				dev_err(rtk_phy->dev,
+					    "%s Error create files for page1 fail\n",
+					    __func__);
+				goto file_error;
+			}
+
+			ret = create_debug_set_parameter_files(rtk_phy, phy_dir,
+				    "page2", phy_data->page2_size);
+			if (ret < 0) {
+				dev_err(rtk_phy->dev,
+					    "%s Error create files for page2 fail\n",
+					    __func__);
+				goto file_error;
+			}
+		}
+	}
+
+	if (!debugfs_create_file("toggle", 0644,
+		    rtk_phy->debug_dir, rtk_phy, &rtk_usb2_toggle_fops))
+		goto file_error;
+
+	return;
+
+file_error:
+	debugfs_remove_recursive(rtk_phy->debug_dir);
+}
+
+static inline void remove_debug_files(struct rtk_usb_phy *rtk_phy)
+{
+	debugfs_remove_recursive(rtk_phy->debug_dir);
+}
+#else
+static inline void create_debug_files(struct rtk_usb_phy *rtk_phy) { }
+static inline void remove_debug_files(struct rtk_usb_phy *rtk_phy) { }
+#endif /* CONFIG_DEBUG_FS */
+
+static int __get_phy_parameter_by_efuse(struct rtk_usb_phy *rtk_phy,
+	    struct phy_data *phy_data, int index)
+{
+	u8 value = 0;
+	struct nvmem_cell *cell;
+	struct soc_device_attribute rtk_soc_groot[] = {
+			{ .family = "Realtek Groot",},
+			{ /* empty */ }
+		};
+	struct soc_device_attribute rtk_soc_hank[] = {
+			{ .family = "Realtek Hank",},
+			{ /* empty */ }
+		};
+	struct soc_device_attribute rtk_soc_efuse_v1[] = {
+			{ .family = "Realtek Phoenix",},
+			{ .family = "Realtek Kylin",},
+			{ .family = "Realtek Hercules",},
+			{ .family = "Realtek Thor",},
+			{ .family = "Realtek Hank",},
+			{ .family = "Realtek Groot",},
+			{ .family = "Realtek Stark",},
+			{ .family = "Realtek Parker",},
+			{ /* empty */ }
+		};
+	struct soc_device_attribute rtk_soc_dis_level_at_page0[] = {
+			{ .family = "Realtek Phoenix",},
+			{ .family = "Realtek Kylin",},
+			{ .family = "Realtek Hercules",},
+			{ .family = "Realtek Thor",},
+			{ .family = "Realtek Hank",},
+			{ .family = "Realtek Groot",},
+			{ /* empty */ }
+		};
+
+	if (soc_device_match(rtk_soc_efuse_v1)) {
+		dev_dbg(rtk_phy->dev, "Use efuse v1 to updated phy parameter\n");
+		phy_data->check_efuse_version = CHECK_EFUSE_V1;
+	} else {
+		dev_dbg(rtk_phy->dev, "Use efuse v2 to updated phy parameter\n");
+		phy_data->check_efuse_version = CHECK_EFUSE_V2;
+	}
+
+	if (soc_device_match(rtk_soc_dis_level_at_page0)) {
+		dev_dbg(rtk_phy->dev, "Use usb_dc_dis_at_page0\\n");
+		phy_data->usb_dc_dis_at_page0 = true;
+
+		phy_data->usb_dc_cal_mask = 0xf;
+		phy_data->usb_dc_dis_mask = 0xf;
+
+		phy_data->disconnect_driving_updated = 0xf;
+	} else {
+		dev_dbg(rtk_phy->dev, "No use usb_dc_dis_at_page0\n");
+		phy_data->usb_dc_dis_at_page0 = false;
+
+		phy_data->usb_dc_cal_mask = 0x1f;
+		phy_data->usb_dc_dis_mask = 0xf;
+
+		phy_data->disconnect_driving_updated = 0x8;
+	}
+
+	phy_data->efuse_usb_dc_cal_rate = EFUS_USB_DC_CAL_RATE;
+	phy_data->efuse_usb_dc_dis_rate = EFUS_USB_DC_DIS_RATE;
+
+	if (soc_device_match(rtk_soc_hank))
+		phy_data->efuse_usb_dc_cal_rate = 1;
+
+	if (!phy_data->check_efuse)
+		goto out;
+
+	/* Read efuse for usb dc cal */
+	cell = nvmem_cell_get(rtk_phy->dev, "usb-dc-cal");
+	if (IS_ERR(cell)) {
+		dev_warn(rtk_phy->dev, "%s failed to get usb-dc-cal: %ld\n",
+			    __func__, PTR_ERR(cell));
+	} else {
+		unsigned char *buf;
+		size_t buf_size;
+
+		buf = nvmem_cell_read(cell, &buf_size);
+
+		value = buf[0] & phy_data->usb_dc_cal_mask;
+
+		dev_dbg(rtk_phy->dev,
+			    "buf=0x%x buf_size=%d value=0x%x\n",
+			    buf[0], (int)buf_size, value);
+
+		kfree(buf);
+		nvmem_cell_put(cell);
+	}
+
+	if (phy_data->check_efuse_version == CHECK_EFUSE_V1) {
+		int rate = phy_data->efuse_usb_dc_cal_rate;
+
+		if (value <= EFUS_USB_DC_CAL_MAX)
+			phy_data->efuse_usb_dc_cal = (int8_t)(value * rate);
+		else
+			phy_data->efuse_usb_dc_cal = -(int8_t)(
+				    (EFUS_USB_DC_CAL_MAX & value) * rate);
+
+		if (soc_device_match(rtk_soc_groot)) {
+			dev_info(rtk_phy->dev, "For groot IC we need a workaround to adjust efuse_usb_dc_cal\n");
+
+			/* We don't multiple dc_cal_rate=2 for positive dc cal compensate */
+			if (value <= EFUS_USB_DC_CAL_MAX)
+				phy_data->efuse_usb_dc_cal = (int8_t)(value);
+
+			/* We set max dc cal compensate is 0x8 if otp is 0x7 */
+			if (value == 0x7)
+				phy_data->efuse_usb_dc_cal = (int8_t)(value + 1);
+		}
+	} else { /* for CHECK_EFUSE_V2 */
+		phy_data->efuse_usb_dc_cal = value & phy_data->usb_dc_cal_mask;
+	}
+
+	dev_dbg(rtk_phy->dev, "Get Efuse usb_dc_cal=%d for index=%d value=%x\n",
+		    phy_data->efuse_usb_dc_cal, index, value);
+
+	/* Read efuse for usb dc disconnect level */
+	value = 0;
+	cell = nvmem_cell_get(rtk_phy->dev, "usb-dc-dis");
+	if (IS_ERR(cell)) {
+		dev_warn(rtk_phy->dev, "%s failed to get usb-dc-dis: %ld\n",
+			    __func__, PTR_ERR(cell));
+	} else {
+		unsigned char *buf;
+		size_t buf_size;
+
+		buf = nvmem_cell_read(cell, &buf_size);
+
+		value = buf[0] & phy_data->usb_dc_dis_mask;
+
+		dev_dbg(rtk_phy->dev,
+			    "buf=0x%x buf_size=%d value=0x%x\n",
+			    buf[0], (int)buf_size, value);
+
+		kfree(buf);
+		nvmem_cell_put(cell);
+	}
+
+	if (phy_data->check_efuse_version == CHECK_EFUSE_V1) {
+		int rate = phy_data->efuse_usb_dc_dis_rate;
+
+		if (value <= EFUS_USB_DC_DIS_MAX)
+			phy_data->efuse_usb_dc_dis = (int8_t)(value * rate);
+		else
+			phy_data->efuse_usb_dc_dis = -(int8_t)(
+				    (EFUS_USB_DC_DIS_MAX & value) * rate);
+	} else { /* for CHECK_EFUSE_V2 */
+		phy_data->efuse_usb_dc_dis = value & phy_data->usb_dc_dis_mask;
+	}
+
+	dev_dbg(rtk_phy->dev, "Get Efuse usb_dc_dis=%d for index=%d value=%x\n",
+		    phy_data->efuse_usb_dc_dis, index, value);
+
+out:
+	return 0;
+}
+
+static int __get_phy_parameter(struct device *dev, struct phy_data *phy_data,
+	    struct device_node *sub_node)
+{
+	u32 page_size = 0;
+	u32 num_cells = 2; /*< addr value > */
+	u32 data_size;
+	int i, ret = 0;
+
+	/* Page 0 */
+	page_size = MAX_USB_PHY_PAGE0_DATA_SIZE;
+	phy_data->page0_size = page_size;
+	phy_data->page0 = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * page_size, GFP_KERNEL);
+	if (!phy_data->page0) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (!of_get_property(sub_node, "realtek,page0-param", &data_size)) {
+		dev_dbg(dev, "%s No page0 parameter (data_size=%d)\n",
+			    __func__, data_size);
+		data_size = 0;
+	}
+
+	if (!data_size)
+		goto parse_page1;
+
+	data_size = data_size / (sizeof(u32) * num_cells);
+
+	for (i = 0; i < data_size; i++) {
+		struct phy_parameter *phy_parameter;
+		u32 addr, data;
+		int index, offset;
+
+		offset = i * num_cells;
+
+		ret = of_property_read_u32_index(sub_node, "realtek,page0-param",
+			    offset, &addr);
+		if (ret) {
+			dev_err(dev, "ERROR: To get page0 i=%d addr=0x%x\n",
+				    i, addr);
+			break;
+		}
+
+		ret = of_property_read_u32_index(sub_node, "realtek,page0-param",
+			    offset + 1, &data);
+		if (ret) {
+			dev_err(dev, "ERROR: To get page0 i=%d addr=0x%x\n",
+				    i, data);
+			break;
+		}
+
+		index = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+		phy_parameter = (phy_data->page0 + index);
+		phy_parameter->addr = (char)addr;
+		phy_parameter->data = (char)data;
+
+		dev_dbg(dev, "page0 index=%d addr=0x%x data=0x%x\n",
+			    index, phy_parameter->addr, phy_parameter->data);
+	}
+
+parse_page1:
+	/* Page 1 */
+	page_size = MAX_USB_PHY_PAGE1_DATA_SIZE;
+	phy_data->page1_size = page_size;
+	phy_data->page1 = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * page_size, GFP_KERNEL);
+	if (!phy_data->page1) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (!of_get_property(sub_node, "realtek,page1-param", &data_size)) {
+		dev_dbg(dev, "%s No page1 parameter (data_size=%d)\n",
+			    __func__,  data_size);
+		data_size = 0;
+	}
+
+	if (!data_size)
+		goto parse_page2;
+
+	data_size = data_size / (sizeof(u32) * num_cells);
+
+	for (i = 0; i < data_size; i++) {
+		struct phy_parameter *phy_parameter;
+		u32 addr, data;
+		int index, offset;
+
+		offset = i * num_cells;
+
+		ret = of_property_read_u32_index(sub_node, "realtek,page1-param",
+			    offset, &addr);
+		if (ret) {
+			dev_err(dev, "ERROR: To get page1 i=%d addr=0x%x\n",
+				    i, addr);
+			break;
+		}
+
+		ret = of_property_read_u32_index(sub_node, "realtek,page1-param",
+			    offset + 1, &data);
+		if (ret) {
+			dev_err(dev, "ERROR: To get page1 i=%d addr=0x%x\n",
+				    i, data);
+			break;
+		}
+
+		index = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+		phy_parameter = phy_data->page1 + index;
+		phy_parameter->addr = (char)addr;
+		phy_parameter->data = (char)data;
+
+		dev_dbg(dev, "page1 index=%d addr=0x%x data=0x%x\n",
+			    index, phy_parameter->addr, phy_parameter->data);
+	}
+
+parse_page2:
+	/* Page 2 */
+	if (of_property_read_bool(sub_node, "realtek,support-page2-param"))
+		page_size = MAX_USB_PHY_PAGE2_DATA_SIZE;
+	else
+		page_size = 0;
+
+	if (!page_size)
+		goto out;
+
+	phy_data->page2_size = page_size;
+	phy_data->page2 = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * page_size, GFP_KERNEL);
+	if (!phy_data->page2) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (!of_get_property(sub_node, "realtek,page2-param", &data_size)) {
+		dev_dbg(dev, "%s No page2 parameter (data_size=%d)\n",
+			    __func__, data_size);
+		data_size = 0;
+	}
+	data_size = data_size / (sizeof(u32) * num_cells);
+
+	for (i = 0; i < data_size; i++) {
+		struct phy_parameter *phy_parameter;
+		u32 addr, data;
+		int index, offset;
+
+		offset = i * num_cells;
+
+		ret = of_property_read_u32_index(sub_node, "realtek,page2-param",
+			    offset, &addr);
+		if (ret) {
+			dev_err(dev, "ERROR: To get page2 i=%d addr=0x%x\n",
+				    i, addr);
+			break;
+		}
+
+		ret = of_property_read_u32_index(sub_node, "realtek,page2-param",
+			    offset + 1, &data);
+		if (ret) {
+			dev_err(dev, "ERROR: To get page2 i=%d addr=0x%x\n",
+				    i, data);
+			break;
+		}
+
+		index = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+		phy_parameter = phy_data->page2 + index;
+		phy_parameter->addr = (char)addr;
+		phy_parameter->data = (char)data;
+
+		dev_dbg(dev, "page2 index=%d addr=0x%x data=0x%x\n",
+			    index, phy_parameter->addr, phy_parameter->data);
+	}
+
+out:
+	return ret;
+}
+
+static int get_phy_parameter(struct rtk_usb_phy *rtk_phy,
+	    struct device_node *sub_node)
+{
+	struct device *dev = rtk_phy->dev;
+	struct reg_addr *addr;
+	struct phy_data *phy_data;
+	int ret = 0;
+	int index;
+
+	if (of_property_read_u32(sub_node, "reg", &index)) {
+		dev_err(dev, "sub_node without reg\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "sub_node index=%d\n", index);
+
+	addr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+	addr->reg_wrap_vstatus = of_iomap(dev->of_node, 0);
+	addr->reg_gusb2phyacc0 = of_iomap(dev->of_node, 1) + index;
+	addr->vstatus_index = index;
+	dev_dbg(dev, "%s %d #%d reg_wrap_vstatus=%p\n", __func__, __LINE__,
+		    index, addr->reg_wrap_vstatus);
+	dev_dbg(dev, "%s %d #%d reg_gusb2phyacc0=%p\n", __func__, __LINE__,
+		    index, addr->reg_gusb2phyacc0);
+
+	if (!sub_node)
+		goto err;
+
+	ret = __get_phy_parameter(dev, phy_data, sub_node);
+	if (ret)
+		goto err;
+
+	if (of_property_read_bool(sub_node, "realtek,do-toggle"))
+		phy_data->do_toggle = true;
+	else
+		phy_data->do_toggle = false;
+
+	if (of_property_read_bool(sub_node, "realtek,do-toggle-driving"))
+		phy_data->do_toggle_driving = true;
+	else
+		phy_data->do_toggle_driving = false;
+
+	if (of_property_read_bool(sub_node, "realtek,check-efuse"))
+		phy_data->check_efuse = true;
+	else
+		phy_data->check_efuse = false;
+
+	if (of_property_read_bool(sub_node, "realtek,use-default-parameter"))
+		phy_data->use_default_parameter = true;
+	else
+		phy_data->use_default_parameter = false;
+
+	if (of_property_read_bool(sub_node,
+		    "realtek,is-double-sensitivity-mode"))
+		phy_data->is_double_sensitivity_mode = true;
+	else
+		phy_data->is_double_sensitivity_mode = false;
+
+	if (of_property_read_bool(sub_node,
+		    "realtek,ldo-force-enable"))
+		phy_data->ldo_force_enable = true;
+	else
+		phy_data->ldo_force_enable = false;
+
+	if (of_property_read_s32(sub_node,
+		 "realtek,ldo-driving-compensate", &phy_data->ldo_driving_compensate))
+		phy_data->ldo_driving_compensate = 0;
+
+	if (of_property_read_s32(sub_node,
+		 "realtek,driving-compensate", &phy_data->driving_compensate))
+		phy_data->driving_compensate = 0;
+
+	__get_phy_parameter_by_efuse(rtk_phy, phy_data, index);
+
+err:
+	return ret;
+}
+
+static int rtk_usb2phy_probe(struct platform_device *pdev)
+{
+	struct rtk_usb_phy *rtk_phy;
+	struct device *dev = &pdev->dev;
+	struct device_node *node;
+	struct device_node *sub_node;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	int phyN, ret = 0;
+
+	rtk_phy = devm_kzalloc(dev, sizeof(*rtk_phy), GFP_KERNEL);
+	if (!rtk_phy)
+		return -ENOMEM;
+
+	rtk_phy->dev			= &pdev->dev;
+	rtk_phy->phy.dev		= rtk_phy->dev;
+	rtk_phy->phy.label		= "rtk-usb2phy";
+	rtk_phy->phy.notify_port_status = rtk_usb_phy_notify_port_status;
+
+	if (!dev->of_node) {
+		dev_err(dev, "%s %d No device node\n", __func__, __LINE__);
+		goto err;
+	}
+
+	node = dev->of_node;
+
+	rtk_phy->usb_ctrl_regs = syscon_regmap_lookup_by_phandle(node, "realtek,usb-ctrl");
+	if (IS_ERR(rtk_phy->usb_ctrl_regs)) {
+		dev_info(dev, "%s: DTS no support usb_ctrl regs syscon\n", __func__);
+		rtk_phy->usb_ctrl_regs = NULL;
+	}
+
+	phyN = of_get_child_count(node);
+	rtk_phy->phyN = phyN;
+	dev_dbg(dev, "%s phyN=%d\n", __func__, rtk_phy->phyN);
+
+	rtk_phy->reg_addr = devm_kzalloc(dev,
+		    sizeof(struct reg_addr) * phyN, GFP_KERNEL);
+	if (!rtk_phy->reg_addr)
+		return -ENOMEM;
+
+	rtk_phy->phy_data = devm_kzalloc(dev,
+		    sizeof(struct phy_data) * phyN, GFP_KERNEL);
+	if (!rtk_phy->phy_data)
+		return -ENOMEM;
+
+	for (sub_node = of_get_next_child(node, NULL); sub_node != NULL;
+		    sub_node = of_get_next_child(node, sub_node)) {
+		ret = get_phy_parameter(rtk_phy, sub_node);
+		if (ret) {
+			dev_err(dev, "%s: get_phy_parameter fail ret=%d\n",
+				    __func__, ret);
+			goto err;
+		}
+	}
+
+	platform_set_drvdata(pdev, rtk_phy);
+
+	generic_phy = devm_phy_create(rtk_phy->dev, NULL, &ops);
+	if (IS_ERR(generic_phy))
+		return PTR_ERR(generic_phy);
+
+	phy_set_drvdata(generic_phy, rtk_phy);
+
+	phy_provider = devm_of_phy_provider_register(rtk_phy->dev,
+				    of_phy_simple_xlate);
+	if (IS_ERR(phy_provider))
+		return PTR_ERR(phy_provider);
+
+	ret = usb_add_phy_dev(&rtk_phy->phy);
+	if (ret)
+		goto err;
+
+	create_debug_files(rtk_phy);
+
+err:
+	dev_dbg(dev, "Probe RTK USB 2.0 PHY (ret=%d)\n", ret);
+
+	return ret;
+}
+
+static void rtk_usb2phy_remove(struct platform_device *pdev)
+{
+	struct rtk_usb_phy *rtk_phy = platform_get_drvdata(pdev);
+
+	remove_debug_files(rtk_phy);
+
+	usb_remove_phy(&rtk_phy->phy);
+}
+
+static const struct of_device_id usbphy_rtk_dt_match[] = {
+	{ .compatible = "realtek,usb2phy", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, usbphy_rtk_dt_match);
+
+static struct platform_driver rtk_usb2phy_driver = {
+	.probe		= rtk_usb2phy_probe,
+	.remove_new	= rtk_usb2phy_remove,
+	.driver		= {
+		.name	= "rtk-usb2phy",
+		.owner	= THIS_MODULE,
+		.of_match_table = usbphy_rtk_dt_match,
+	},
+};
+
+module_platform_driver(rtk_usb2phy_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform: rtk-usb2phy");
+MODULE_AUTHOR("Stanley Chang <stanley_chang@realtek.com>");
+MODULE_DESCRIPTION("Realtek usb 2.0 phy driver");
-- 
2.34.1

