Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B02B708F16
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 07:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbjESFAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 01:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbjESFAS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 01:00:18 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B7410E0;
        Thu, 18 May 2023 22:00:13 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34J4wV6J1010004, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34J4wV6J1010004
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 12:58:31 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 19 May 2023 12:58:40 +0800
Received: from RTEXH36506.realtek.com.tw (172.21.6.27) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 19 May 2023 12:58:39 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server id
 15.1.2507.17 via Frontend Transport; Fri, 19 May 2023 12:58:39 +0800
From:   Stanley Chang <stanley_chang@realtek.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Stanley Chang <stanley_chang@realtek.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Ray Chi <raychi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Flavio Suligoi <f.suligoi@asem.it>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Bhuvanesh Surachari <Bhuvanesh_Surachari@mentor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Paul Cercueil" <paul@crapouillou.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v1 2/3] usb: phy: Add driver for the Realtek SoC USB 2.0/3.0 PHY
Date:   Fri, 19 May 2023 12:58:02 +0800
Message-ID: <20230519045825.28369-2-stanley_chang@realtek.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230519045825.28369-1-stanley_chang@realtek.com>
References: <20230519045825.28369-1-stanley_chang@realtek.com>
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

Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB 2.0/3.0
controller. Added two drivers to drive the  USB 2.0/3.0 PHY transceivers.
For USB 3.0 transceivers, a driver phy-rtk-usb3 is provided.
The driver phy-rtk-usb2 is used to support USB 2.0 transceivers.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
 drivers/usb/phy/Kconfig        |   14 +
 drivers/usb/phy/Makefile       |    2 +
 drivers/usb/phy/phy-rtk-usb.h  |   88 ++
 drivers/usb/phy/phy-rtk-usb2.c | 2196 ++++++++++++++++++++++++++++++++
 drivers/usb/phy/phy-rtk-usb3.c | 1165 +++++++++++++++++
 5 files changed, 3465 insertions(+)
 create mode 100644 drivers/usb/phy/phy-rtk-usb.h
 create mode 100644 drivers/usb/phy/phy-rtk-usb2.c
 create mode 100644 drivers/usb/phy/phy-rtk-usb3.c

diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
index 5f629d7cad64..b2e5feb9f37a 100644
--- a/drivers/usb/phy/Kconfig
+++ b/drivers/usb/phy/Kconfig
@@ -172,4 +172,18 @@ config USB_ULPI_VIEWPORT
 	  Provides read/write operations to the ULPI phy register set for
 	  controllers with a viewport register (e.g. Chipidea/ARC controllers).
 
+config RTK_USB2PHY
+	tristate "Realtek RTD USB2 PHY Transceiver Driver"
+	select USB_PHY
+	help
+	  Enable this to support Realtek SoC USB2 phy transceiver.
+	  Support the DHC (digital home center) RTD series SoCs.
+
+config RTK_USB3PHY
+	tristate "Realtek RTD USB3 PHY Transceiver Driver"
+	select USB_PHY
+	help
+	  Enable this to support Realtek SoC USB3 phy transceiver.
+	  Support the DHC (digital home center) RTD series SoCs.
+
 endmenu
diff --git a/drivers/usb/phy/Makefile b/drivers/usb/phy/Makefile
index e5d619b4d8f6..1e64255fcd1f 100644
--- a/drivers/usb/phy/Makefile
+++ b/drivers/usb/phy/Makefile
@@ -23,3 +23,5 @@ obj-$(CONFIG_USB_MXS_PHY)		+= phy-mxs-usb.o
 obj-$(CONFIG_USB_ULPI)			+= phy-ulpi.o
 obj-$(CONFIG_USB_ULPI_VIEWPORT)		+= phy-ulpi-viewport.o
 obj-$(CONFIG_KEYSTONE_USB_PHY)		+= phy-keystone.o
+obj-$(CONFIG_RTK_USB2PHY)		+= phy-rtk-usb2.o
+obj-$(CONFIG_RTK_USB3PHY)		+= phy-rtk-usb3.o
diff --git a/drivers/usb/phy/phy-rtk-usb.h b/drivers/usb/phy/phy-rtk-usb.h
new file mode 100644
index 000000000000..5652866d0b02
--- /dev/null
+++ b/drivers/usb/phy/phy-rtk-usb.h
@@ -0,0 +1,88 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ *  phy-rtk-usb.h Realtek usb phy header file
+ *
+ * copyright (c) 2023 realtek semiconductor corporation
+ *
+ */
+
+#ifndef __PHY_RTK_USB_H__
+#define __PHY_RTK_USB_H__
+
+struct rtk_usb_phy {
+	struct usb_phy phy;
+	struct device *dev;
+	struct regmap *usb_regs;
+	struct regmap *mac_regs;
+	struct regmap *usb_ctrl_regs;
+
+	int port_index;
+	int phyN;
+	void *reg_addr;
+	void *phy_data;
+
+#ifdef CONFIG_DEBUG_FS
+	struct dentry *debug_dir;
+#endif
+};
+
+#define phy_read(addr) __raw_readl(addr)
+#define phy_write(addr, val) do { \
+	/* Do smp_wmb */ \
+	smp_wmb(); __raw_writel(val, addr); \
+} while (0)
+#define PHY_IO_TIMEOUT_MSEC		(50)
+
+static inline int utmi_wait_register(void __iomem *reg, u32 mask, u32 result)
+{
+	unsigned long timeout = jiffies + msecs_to_jiffies(PHY_IO_TIMEOUT_MSEC);
+
+	while (time_before(jiffies, timeout)) {
+		/* Do smp_rmb */
+		smp_rmb();
+		if ((phy_read(reg) & mask) == result)
+			return 0;
+		udelay(100);
+	}
+	pr_err("\033[0;32;31m can't program USB phy \033[m\n");
+
+	return -ETIMEDOUT;
+}
+
+#define DEFAULT_CHIP_REVISION 0xA00
+#define MAX_CHIP_REVISION 0xC00
+
+static inline int __get_chip_revision(void)
+{
+	int chip_revision = 0xFFF;
+	char revision[] = "FFF";
+	struct soc_device_attribute soc_att[] = {{.revision = revision}, {}};
+	struct soc_device_attribute *soc_att_match = NULL;
+
+	while (soc_att_match == NULL) {
+		chip_revision--;
+
+		if (chip_revision <= DEFAULT_CHIP_REVISION)
+			break;
+		if (chip_revision > MAX_CHIP_REVISION)
+			chip_revision = MAX_CHIP_REVISION;
+		else if ((chip_revision & 0xFF) > 0xF)
+			chip_revision = (chip_revision & 0xF00) + 0xF;
+
+		snprintf(revision, 4, "%X", chip_revision);
+
+		soc_att_match = (struct soc_device_attribute *)
+			    soc_device_match(soc_att);
+	}
+
+	if (soc_att_match) {
+		pr_debug("%s get chip_revision %x\n", __func__, chip_revision);
+		return chip_revision;
+	}
+
+	pr_debug("%s: Use default chip_revision %x\n", __func__,
+		    DEFAULT_CHIP_REVISION);
+	return DEFAULT_CHIP_REVISION;
+}
+
+#endif /* __PHY_RTK_USB_H__ */
diff --git a/drivers/usb/phy/phy-rtk-usb2.c b/drivers/usb/phy/phy-rtk-usb2.c
new file mode 100644
index 000000000000..ce9305ccb6fb
--- /dev/null
+++ b/drivers/usb/phy/phy-rtk-usb2.c
@@ -0,0 +1,2196 @@
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
+#include <linux/usb.h>
+#include <linux/usb/phy.h>
+#include <linux/usb/hcd.h>
+
+#include "phy-rtk-usb.h"
+
+#define RTK_USB2PHY_NAME "rtk-usb2phy"
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
+	s32 ldo_page0_e4_compensate;
+	s32 page0_e4_compensate;
+};
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
+	phy_write(reg_gusb2phyacc0, regVal);
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return (char)ret;
+
+	/* VCtrl = high nibble of addr, and set PHY_NEW_REG_REQ */
+	regVal = PHY_NEW_REG_REQ | (GET_HIGH_NIBBLE(addr) << PHY_VCTRL_SHIFT);
+	phy_write(reg_gusb2phyacc0, regVal);
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return (char)ret;
+
+	/* rmb for reg read */
+	smp_rmb();
+	regVal = phy_read(reg_gusb2phyacc0);
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
+	phy_write(reg_wrap_vstatus, (u32)data<<shift_bits);
+
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return ret;
+
+	/* VCtrl = low nibble of addr, set PHY_NEW_REG_REQ */
+	regVal = PHY_NEW_REG_REQ | (GET_LOW_NIBBLE(addr) << PHY_VCTRL_SHIFT);
+
+	phy_write(reg_gusb2phyacc0, regVal);
+	ret = utmi_wait_register(reg_gusb2phyacc0, PHY_VSTS_BUSY, 0);
+	if (ret)
+		return ret;
+
+	/* VCtrl = high nibble of addr, set PHY_NEW_REG_REQ */
+	regVal = PHY_NEW_REG_REQ | (GET_HIGH_NIBBLE(addr) << PHY_VCTRL_SHIFT);
+
+	phy_write(reg_gusb2phyacc0, regVal);
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
+	s32 page0_e4_compensate = 0;
+	s32 usb_dc_cal_mask = phy_data->usb_dc_cal_mask;
+
+	if (phy_data->check_efuse_version == CHECK_EFUSE_V1) {
+		if (phy_data->ldo_enable)
+			page0_e4_compensate = phy_data->ldo_page0_e4_compensate;
+
+		__val = (s32)(data & usb_dc_cal_mask) + page0_e4_compensate
+			    + phy_data->efuse_usb_dc_cal;
+	} else { /* for CHECK_EFUSE_V2 or no efuse */
+		page0_e4_compensate = phy_data->page0_e4_compensate;
+
+		if (phy_data->efuse_usb_dc_cal)
+			__val = (s32)((phy_data->efuse_usb_dc_cal & usb_dc_cal_mask)
+				    + page0_e4_compensate);
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
+	struct phy_parameter *phy_page_setting;
+	int i;
+
+	/* Set page 0 */
+	phy_page_setting = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE4);
+
+	if (i < phy_data->page0_size) {
+		u8 addr = (phy_page_setting + i)->addr;
+		u8 data = (phy_page_setting + i)->data;
+		u8 __data;
+		int offset = 4;
+		s32 usb_dc_dis_mask = phy_data->usb_dc_dis_mask;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			(phy_page_setting + i)->addr = addr;
+			(phy_page_setting + i)->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default addr %x value %x\n",
+				    (phy_page_setting + i)->addr,
+				    (phy_page_setting + i)->data);
+		}
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
+	struct phy_parameter *phy_page_setting;
+	int i;
+
+	/* Set page 1 */
+	phy_page_setting = phy_data->page1;
+	rtk_usb_phy_set_page(regAddr, 1);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE1_0xE2);
+
+	if (i < phy_data->page1_size) {
+		u8 addr = (phy_page_setting + i)->addr;
+		u8 data = (phy_page_setting + i)->data;
+		u8 __data;
+		s32 usb_dc_dis_mask = phy_data->usb_dc_dis_mask;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			(phy_page_setting + i)->addr = addr;
+			(phy_page_setting + i)->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default addr %x value %x\n",
+				    (phy_page_setting + i)->addr,
+				    (phy_page_setting + i)->data);
+		}
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
+static void do_rtk_usb2_phy_toggle(struct rtk_usb_phy *rtk_phy,
+	    int index, bool isConnect);
+
+static int do_rtk_usb_phy_init(struct rtk_usb_phy *rtk_phy, int index)
+{
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
+	struct phy_parameter *phy_page_setting;
+	int i;
+
+	if (!rtk_phy) {
+		pr_err("%s, rtk_phy is NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	dev_dbg(rtk_phy->dev, "%s: init phy#%d\n", __func__, index);
+
+	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+	if (!phy_data) {
+		pr_err("%s, phy_data is NULL\n", __func__);
+		return -EINVAL;
+	}
+
+	if (control_phy_power(rtk_phy, phy_data, regAddr)) {
+		phy_data->ldo_enable = true;
+		dev_info(rtk_phy->dev, "%s USB phy use ldo power compensate phy parameter (%d)\n",
+		    __func__, phy_data->ldo_page0_e4_compensate);
+	}
+
+	if (phy_data->use_default_parameter) {
+		dev_info(rtk_phy->dev, "%s phy#%d use default parameter\n",
+			    __func__, index);
+		goto do_toggle;
+	}
+
+	/* Set page 0 */
+	phy_page_setting = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	for (i = 0; i < phy_data->page0_size; i++) {
+		u8 addr = (phy_page_setting + i)->addr;
+		u8 data = (phy_page_setting + i)->data;
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
+			return -1;
+		}
+		dev_dbg(rtk_phy->dev, "[%s:%d] Good page0 addr=0x%x value=0x%x\n",
+			    __func__, __LINE__, addr,
+			    rtk_usb_phy_read(regAddr, addr));
+	}
+
+	/* Set page 1 */
+	phy_page_setting = phy_data->page1;
+	rtk_usb_phy_set_page(regAddr, 1);
+
+	for (i = 0; i < phy_data->page1_size; i++) {
+		u8 addr = (phy_page_setting + i)->addr;
+		u8 data = (phy_page_setting + i)->data;
+
+		if (!addr)
+			continue;
+
+		if (rtk_usb_phy_write(regAddr, addr, data)) {
+			dev_err(rtk_phy->dev,
+				    "[%s:%d] Error page1 addr=0x%x value=0x%x\n",
+				    __func__, __LINE__,
+				    addr, data);
+			return -1;
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
+	phy_page_setting = phy_data->page2;
+	rtk_usb_phy_set_page(regAddr, 2);
+
+	for (i = 0; i < phy_data->page2_size; i++) {
+		u8 addr = (phy_page_setting + i)->addr;
+		u8 data = (phy_page_setting + i)->data;
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
+			    __func__, __LINE__,
+			    (phy_page_setting + i)->addr,
+			    rtk_usb_phy_read(regAddr,
+			      (phy_page_setting + i)->addr));
+	}
+
+do_toggle:
+	do_rtk_usb2_phy_toggle(rtk_phy, index, false);
+
+	return 0;
+}
+
+static int rtk_usb_phy_init(struct usb_phy *phy)
+{
+	struct rtk_usb_phy *rtk_phy = container_of(phy, struct rtk_usb_phy, phy);
+	unsigned long phy_init_time = jiffies;
+	int i, ret = 0;
+
+	dev_dbg(phy->dev, "Init RTK USB 2.0 PHY\n");
+	for (i = 0; i < rtk_phy->phyN; i++)
+		ret = do_rtk_usb_phy_init(rtk_phy, i);
+
+	dev_info(phy->dev, "Initialized RTK USB 2.0 PHY (take %dms)\n",
+		    jiffies_to_msecs(jiffies - phy_init_time));
+	return ret;
+}
+
+static void rtk_usb_phy_shutdown(struct usb_phy *phy)
+{
+	dev_info(phy->dev, "Shutdown RTK USB 2.0 PHY\n");
+}
+
+static void do_rtk_usb2_phy_toggle(struct rtk_usb_phy *rtk_phy,
+	    int index, bool isConnect)
+{
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
+	struct phy_parameter *phy_page_setting;
+	int i;
+
+	if (!rtk_phy) {
+		pr_err("%s phy_data is NULL\n", __func__);
+		return;
+	}
+
+	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+	if (!phy_data) {
+		dev_err(rtk_phy->dev, "%s phy_data is NULL\n", __func__);
+		return;
+	}
+
+	if (!phy_data->do_toggle)
+		goto out;
+
+	if (phy_data->is_double_sensitivity_mode)
+		goto do_toggle_driving;
+
+	/* Set page 0 */
+	phy_page_setting = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE7);
+
+	if (i < phy_data->page0_size) {
+		u8 addr = (phy_page_setting + i)->addr;
+		u8 data = (phy_page_setting + i)->data;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			(phy_page_setting + i)->addr = addr;
+			(phy_page_setting + i)->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default addr %x value %x\n",
+				    (phy_page_setting + i)->addr,
+				    (phy_page_setting + i)->data);
+		}
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
+	phy_page_setting = phy_data->page0;
+	rtk_usb_phy_set_page(regAddr, 0);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE4);
+
+	if (i < phy_data->page0_size) {
+		u8 addr = (phy_page_setting + i)->addr;
+		u8 data = (phy_page_setting + i)->data;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			(phy_page_setting + i)->addr = addr;
+			(phy_page_setting + i)->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default addr %x value %x\n",
+				    (phy_page_setting + i)->addr,
+				    (phy_page_setting + i)->data);
+		}
+
+		if (addr == PAGE0_0xE4)
+			data = __updated_page0_0xe4_parameter(phy_data, data);
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
+	phy_page_setting = phy_data->page1;
+	rtk_usb_phy_set_page(regAddr, 1);
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE1_0xE0);
+
+	if (i < phy_data->page1_size) {
+		u8 addr = (phy_page_setting + i)->addr;
+		u8 data = (phy_page_setting + i)->data;
+
+		if (!addr) {
+			addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			data = rtk_usb_phy_read(regAddr, addr);
+
+			(phy_page_setting + i)->addr = addr;
+			(phy_page_setting + i)->data = data;
+			dev_dbg(rtk_phy->dev,
+				    "Get default addr %x value %x\n",
+				    (phy_page_setting + i)->addr,
+				    (phy_page_setting + i)->data);
+		}
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
+static void rtk_usb2_phy_toggle(struct usb_phy *usb2_phy, bool isConnect, int port)
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
+	do_rtk_usb2_phy_toggle(rtk_phy, index, isConnect);
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
+		rtk_usb2_phy_toggle(x, isConnect, port);
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
+		struct phy_parameter *phy_page_setting;
+
+		seq_printf(s, "PHY %d:\n", index);
+
+		seq_puts(s, "Page 0:\n");
+		/* Set page 0 */
+		phy_page_setting = phy_data->page0;
+		rtk_usb_phy_set_page(regAddr, 0);
+
+		for (i = 0; i < phy_data->page0_size; i++) {
+			u8 addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			u8 data = (phy_page_setting + i)->data;
+			u8 value = rtk_usb_phy_read(regAddr, addr);
+
+			if ((phy_page_setting + i)->addr)
+				seq_printf(s, "Page 0: addr=0x%x data=0x%02x ==> read value=0x%02x\n",
+					    addr, data, value);
+			else
+				seq_printf(s, "Page 0: addr=0x%x data=none ==> read value=0x%02x\n",
+					    addr, value);
+		}
+
+		seq_puts(s, "Page 1:\n");
+		/* Set page 1 */
+		phy_page_setting = phy_data->page1;
+		rtk_usb_phy_set_page(regAddr, 1);
+
+		for (i = 0; i < phy_data->page1_size; i++) {
+			u8 addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			u8 data = (phy_page_setting + i)->data;
+			u8 value = rtk_usb_phy_read(regAddr, addr);
+
+			if ((phy_page_setting + i)->addr)
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
+		phy_page_setting = phy_data->page2;
+		rtk_usb_phy_set_page(regAddr, 2);
+
+		for (i = 0; i < phy_data->page2_size; i++) {
+			u8 addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+			u8 data = (phy_page_setting + i)->data;
+			u8 value = rtk_usb_phy_read(regAddr, addr);
+
+			if ((phy_page_setting + i)->addr)
+				seq_printf(s, "Page 2: addr=0x%x data=0x%02x ==> read value=0x%02x\n",
+					    addr, data, value);
+			else
+				seq_printf(s, "Page 2: addr=0x%x data=none ==> read value=0x%02x\n",
+					    addr, value);
+		}
+
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
+		seq_printf(s, "ldo_page0_e4_compensate: %d\n",
+			    phy_data->ldo_page0_e4_compensate);
+		seq_printf(s, "page0_e4_compensate: %d\n",
+			    phy_data->page0_e4_compensate);
+	}
+
+out:
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
+	    struct phy_parameter *phy_parameter_array,
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
+	phy_parameter = (phy_parameter_array + i);
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
+	    struct phy_parameter *phy_parameter_array,
+	    const char *phy_page, const char *phy_addr, const char *phy_value)
+{
+	struct phy_parameter *phy_parameter;
+	uint32_t addr, value;
+	int i, ret;
+
+	ret = kstrtouint(phy_addr, 16, &addr);
+	if (ret < 0) {
+		pr_err("%s::kstrtouint() failed\n", __func__);
+		return -EINVAL;
+	}
+	ret = kstrtouint(phy_value, 16, &value);
+	if (ret < 0) {
+		pr_err("%s::kstrtouint() failed\n", __func__);
+		return -EINVAL;
+	}
+
+	i = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+	phy_parameter = (phy_parameter_array + i);
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
+	int ret, index;
+	struct phy_data *phy_data;
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
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
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
+/* Get default phy parameter for update by efuse or ldo_page0_e4_compensate */
+static int __get_default_phy_parameter_for_updated(
+	    struct rtk_usb_phy *rtk_phy, int index)
+{
+	int i;
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
+	struct phy_parameter *phy_page_setting;
+
+	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+	/* Get PAGE0_0xE4 default value */
+	if (phy_data->efuse_usb_dc_cal || phy_data->ldo_page0_e4_compensate ||
+		    (phy_data->efuse_usb_dc_dis && phy_data->usb_dc_dis_at_page0)) {
+		phy_page_setting = phy_data->page0;
+		rtk_usb_phy_set_page(regAddr, 0);
+
+		i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE0_0xE4);
+		if (i < phy_data->page0_size) {
+			u8 addr = (phy_page_setting + i)->addr;
+			u8 data = (phy_page_setting + i)->data;
+
+			if (!addr) {
+				addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+				data = rtk_usb_phy_read(regAddr, addr);
+
+				(phy_page_setting + i)->addr = addr;
+				(phy_page_setting + i)->data = data;
+				dev_dbg(rtk_phy->dev,
+					    "Get default addr %x value %x\n",
+					    (phy_page_setting + i)->addr,
+					    (phy_page_setting + i)->data);
+			}
+		}
+	}
+
+	/* Get PAGE1_0xE2 default value */
+	if (phy_data->efuse_usb_dc_dis && !phy_data->usb_dc_dis_at_page0) {
+		phy_page_setting = phy_data->page1;
+		rtk_usb_phy_set_page(regAddr, 1);
+
+		i = PAGE_ADDR_MAP_ARRAY_INDEX(PAGE1_0xE2);
+		if (i < phy_data->page1_size) {
+			u8 addr = (phy_page_setting + i)->addr;
+			u8 data = (phy_page_setting + i)->data;
+
+			if (!addr) {
+				addr = ARRAY_INDEX_MAP_PAGE_ADDR(i);
+				data = rtk_usb_phy_read(regAddr, addr);
+
+				(phy_page_setting + i)->addr = addr;
+				(phy_page_setting + i)->data = data;
+				dev_dbg(rtk_phy->dev,
+					    "Get default page1 addr %x value %x\n",
+					    (phy_page_setting + i)->addr,
+					    (phy_page_setting + i)->data);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int __get_phy_parameter_v1(struct device *dev, struct phy_data *phy_data,
+	    struct device_node *sub_node)
+{
+	int phy_data_page0_size, phy_data_page1_size;
+	int phy_data_page2_size;
+	char tmp_addr[MAX_PHY_DATA_SIZE];
+	char tmp_data[MAX_PHY_DATA_SIZE];
+	int i, chip_revision, revision, ret = 0;
+
+	chip_revision = __get_chip_revision();
+
+	dev_dbg(dev, "%s: Chip revision is %x\n", __func__, chip_revision);
+
+	ret = of_property_read_u32_index(sub_node,
+		    "realtek,phy-data-page0-size", 0, &phy_data_page0_size);
+	if (ret)
+		goto err;
+
+	ret = of_property_read_u32_index(sub_node,
+		    "realtek,phy-data-page1-size", 0, &phy_data_page1_size);
+	if (ret)
+		goto err;
+
+	dev_dbg(dev, "%s %d phy_data_page0_size=%d, phy_data_page1_size=%d\n",
+		    __func__, __LINE__,
+		    phy_data_page0_size, phy_data_page1_size);
+
+	if (phy_data_page0_size > MAX_PHY_DATA_SIZE ||
+		    phy_data_page1_size > MAX_PHY_DATA_SIZE) {
+		dev_err(dev, "%s phy_data size > MAX_PHY_DATA_SIZE\n",
+			    __func__);
+		goto err;
+	}
+
+	ret = of_property_read_u32_index(sub_node,
+		    "realtek,phy-data-page2-size", 0, &phy_data_page2_size);
+	if (ret)
+		phy_data_page2_size = 0;
+	dev_dbg(dev, "%s %d phy_data_page2_size=%d\n",
+		    __func__, __LINE__,
+		    phy_data_page2_size);
+
+	if (phy_data_page2_size > MAX_PHY_DATA_SIZE) {
+		dev_err(dev, "%s page2 phy_data size=%d > MAX_PHY_DATA_SIZE\n",
+			    __func__, phy_data_page2_size);
+		goto err;
+	}
+
+	phy_data->page0_size = phy_data_page0_size;
+	phy_data->page0 = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) *
+			phy_data_page0_size,
+		    GFP_KERNEL);
+	if (!phy_data->page0) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	phy_data->page1_size = phy_data_page1_size;
+	phy_data->page1 = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) *
+			phy_data_page1_size,
+		    GFP_KERNEL);
+	if (!phy_data->page1) {
+		ret = -ENOMEM;
+		goto err;
+	}
+
+	phy_data->page2_size = phy_data_page2_size;
+	if (phy_data->page2_size > 0) {
+		phy_data->page2 = devm_kzalloc(dev,
+			    sizeof(struct phy_parameter) *
+				phy_data->page2_size,
+			    GFP_KERNEL);
+		if (!phy_data->page2) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
+
+	ret = of_property_read_u8_array(sub_node, "realtek,phy-data-page0-addr",
+		    tmp_addr, phy_data_page0_size);
+	if (ret)
+		goto err;
+
+	revision = chip_revision;
+	while (revision >= DEFAULT_CHIP_REVISION) {
+		char phy_data_revision[32] = {0};
+
+		snprintf(phy_data_revision, 27, "realtek,phy-data-page0-%X", revision);
+
+		ret = of_property_read_u8_array(sub_node, phy_data_revision,
+			    tmp_data, phy_data_page0_size);
+		if (!ret) {
+			dev_dbg(dev, "%s load %s parameter\n",
+				    __func__, phy_data_revision);
+			break;
+		}
+		revision--;
+		if ((revision & 0xFF) > 0xF)
+			revision = (revision & 0xF00) + 0xF;
+	}
+
+	/* For old device tree */
+	if (ret) {
+		ret = of_property_read_u8_array(sub_node, "realtek,phy-data-page0-data",
+			    tmp_data, phy_data_page0_size);
+		if (ret)
+			goto err;
+		else
+			dev_info(dev, "%s load page0 parameter\n",
+				    __func__);
+	}
+
+	for (i = 0; i < phy_data_page0_size; i++) {
+		struct phy_parameter *phy_data_page0 =
+			    (phy_data->page0 + i);
+
+		phy_data_page0->addr = tmp_addr[i];
+		phy_data_page0->data = tmp_data[i];
+	}
+
+	ret = of_property_read_u8_array(sub_node, "realtek,phy-data-page1-addr",
+		    tmp_addr, phy_data_page1_size);
+	if (ret)
+		goto err;
+
+	revision = chip_revision;
+	while (revision >= DEFAULT_CHIP_REVISION) {
+		char phy_data_revision[32] = {0};
+
+		snprintf(phy_data_revision, 27, "realtek,phy-data-page1-%X", revision);
+
+		ret = of_property_read_u8_array(sub_node, phy_data_revision,
+			    tmp_data, phy_data_page1_size);
+		if (!ret) {
+			dev_dbg(dev, "%s load %s parameter\n",
+				    __func__, phy_data_revision);
+			break;
+		}
+		revision--;
+		if ((revision & 0xFF) > 0xF)
+			revision = (revision & 0xF00) + 0xF;
+	}
+
+	/* For old device tree */
+	if (ret) {
+		ret = of_property_read_u8_array(sub_node, "realtek,phy-data-page1-data",
+			    tmp_data, phy_data_page1_size);
+		if (ret)
+			goto err;
+		else
+			dev_info(dev, "%s load page1 parameter\n",
+				    __func__);
+	}
+
+	for (i = 0; i < phy_data_page1_size; i++) {
+		struct phy_parameter *phy_data_page1 =
+			    (phy_data->page1 + i);
+
+		phy_data_page1->addr = tmp_addr[i];
+		phy_data_page1->data = tmp_data[i];
+	}
+
+	if (phy_data->page2_size > 0) {
+		ret = of_property_read_u8_array(sub_node,
+			    "realtek,phy-data-page2-addr",
+			    tmp_addr, phy_data->page2_size);
+		if (ret)
+			goto err;
+
+		revision = chip_revision;
+		while (revision >= DEFAULT_CHIP_REVISION) {
+			char phy_data_revision[32] = {0};
+
+			snprintf(phy_data_revision, 27, "realtek,phy-data-page2-%X",
+				    revision);
+
+			ret = of_property_read_u8_array(sub_node,
+				    phy_data_revision,
+				    tmp_data, phy_data_page2_size);
+			if (!ret) {
+				dev_dbg(dev, "%s load %s parameter\n",
+					    __func__, phy_data_revision);
+				break;
+			}
+			revision--;
+			if ((revision & 0xFF) > 0xF)
+				revision = (revision & 0xF00) + 0xF;
+		}
+
+		/* For old device tree */
+		if (ret) {
+			ret = of_property_read_u8_array(sub_node,
+				    "realtek,phy-data-page2-data",
+				    tmp_data, phy_data->page2_size);
+			if (ret)
+				goto err;
+			else
+				dev_info(dev, "%s load page2 parameter\n",
+					    __func__);
+		}
+		for (i = 0; i < phy_data->page2_size; i++) {
+			struct phy_parameter *phy_data_page2 =
+				    (phy_data->page2 + i);
+			phy_data_page2->addr = tmp_addr[i];
+			phy_data_page2->data = tmp_data[i];
+		}
+	}
+
+err:
+	return ret;
+}
+
+static int __get_phy_parameter_v2(struct device *dev, struct phy_data *phy_data,
+	    struct device_node *sub_node)
+{
+	u32 page_size = 0;
+	u32 num_cells = 2; /*< addr value > */
+	u32 data_size;
+	int i, offset, chip_revision, revision, ret = 0;
+	char phy_data_revision[32] = {0};
+
+	chip_revision = __get_chip_revision();
+
+	/* Page 0 */
+	ret = of_property_read_u32_index(sub_node, "realtek,page0-size", 0, &page_size);
+	if (ret) {
+		dev_err(dev, "%s No page0_size\n", __func__);
+		goto parse_page1;
+	}
+
+	phy_data->page0_size = page_size;
+	phy_data->page0 = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * page_size, GFP_KERNEL);
+	if (!phy_data->page0) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	revision = chip_revision;
+	while (revision >= DEFAULT_CHIP_REVISION) {
+		snprintf(phy_data_revision, 23, "realtek,page0-data-%X", revision);
+
+		if (of_get_property(sub_node, phy_data_revision, &data_size)) {
+			dev_dbg(dev, "%s load %s parameter (data_size=%d)\n",
+				    __func__, phy_data_revision, data_size);
+			break;
+		}
+		revision--;
+		if ((revision & 0xFF) > 0xF)
+			revision = (revision & 0xF00) + 0xF;
+
+		data_size = 0;
+		ret = 0;
+	}
+	data_size = data_size / (sizeof(u32) * num_cells);
+
+	for (i = 0; i < data_size; i++) {
+		struct phy_parameter *phy_data_page;
+		u32 addr, data;
+		int index;
+
+		offset = i * num_cells;
+
+		ret = of_property_read_u32_index(sub_node, phy_data_revision,
+			    offset, &addr);
+		if (ret) {
+			dev_err(dev, "ERROR: To get %s i=%d addr=0x%x\n",
+				    phy_data_revision, i, addr);
+			break;
+		}
+
+		ret = of_property_read_u32_index(sub_node, phy_data_revision,
+			    offset + 1, &data);
+		if (ret) {
+			dev_err(dev, "ERROR: To get %s i=%d addr=0x%x\n",
+				    phy_data_revision, i, data);
+			break;
+		}
+
+		index = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+		phy_data_page = (phy_data->page0 + index);
+		phy_data_page->addr = (char)addr;
+		phy_data_page->data = (char)data;
+
+		dev_dbg(dev, "%s index=%d addr=0x%x data=0x%x\n",
+			    phy_data_revision, index,
+			    phy_data_page->addr, phy_data_page->data);
+	}
+
+parse_page1:
+	/* Page 1 */
+	ret = of_property_read_u32_index(sub_node, "realtek,page1-size", 0, &page_size);
+	if (ret) {
+		dev_err(dev, "%s No page0_size\n", __func__);
+		goto parse_page2;
+	}
+
+	phy_data->page1_size = page_size;
+	phy_data->page1 = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * page_size, GFP_KERNEL);
+	if (!phy_data->page1) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	revision = chip_revision;
+	while (revision >= DEFAULT_CHIP_REVISION) {
+		snprintf(phy_data_revision, 23, "realtek,page1-data_%X", revision);
+
+		if (of_get_property(sub_node, phy_data_revision, &data_size)) {
+			dev_dbg(dev, "%s load %s parameter (data_size=%d)\n",
+				    __func__, phy_data_revision, data_size);
+			break;
+		}
+		revision--;
+		if ((revision & 0xFF) > 0xF)
+			revision = (revision & 0xF00) + 0xF;
+
+		data_size = 0;
+		ret = 0;
+	}
+	data_size = data_size / (sizeof(u32) * num_cells);
+
+	for (i = 0; i < data_size; i++) {
+		struct phy_parameter *phy_data_page;
+		u32 addr, data;
+		int index;
+
+		offset = i * num_cells;
+
+		ret = of_property_read_u32_index(sub_node, phy_data_revision,
+			    offset, &addr);
+		if (ret) {
+			dev_err(dev, "ERROR: To get %s i=%d addr=0x%x\n",
+				    phy_data_revision, i, addr);
+			break;
+		}
+
+		ret = of_property_read_u32_index(sub_node, phy_data_revision,
+			    offset + 1, &data);
+		if (ret) {
+			dev_err(dev, "ERROR: To get %s i=%d addr=0x%x\n",
+				    phy_data_revision, i, data);
+			break;
+		}
+
+		index = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+		phy_data_page = phy_data->page1 + index;
+		phy_data_page->addr = (char)addr;
+		phy_data_page->data = (char)data;
+
+		dev_dbg(dev, "%s index=%d addr=0x%x data=0x%x\n",
+			    phy_data_revision, index,
+			    phy_data_page->addr, phy_data_page->data);
+	}
+
+parse_page2:
+	/* Page 2 */
+	ret = of_property_read_u32_index(sub_node, "realtek,page2-size", 0, &page_size);
+	if (ret) {
+		dev_dbg(dev, "%s No page2_size\n", __func__);
+		goto out;
+	}
+
+	phy_data->page2_size = page_size;
+	phy_data->page2 = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * page_size, GFP_KERNEL);
+	if (!phy_data->page2) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	revision = chip_revision;
+	while (revision >= DEFAULT_CHIP_REVISION) {
+		snprintf(phy_data_revision, 23, "realtek,page2-data-%X", revision);
+
+		if (of_get_property(sub_node, phy_data_revision, &data_size)) {
+			dev_dbg(dev, "%s load %s parameter (data_size=%d)\n",
+				    __func__, phy_data_revision, data_size);
+			break;
+		}
+		revision--;
+		if ((revision & 0xFF) > 0xF)
+			revision = (revision & 0xF00) + 0xF;
+
+		data_size = 0;
+		ret = 0;
+	}
+	data_size = data_size / (sizeof(u32) * num_cells);
+
+	for (i = 0; i < data_size; i++) {
+		struct phy_parameter *phy_data_page;
+		u32 addr, data;
+		int index;
+
+		offset = i * num_cells;
+
+		ret = of_property_read_u32_index(sub_node, phy_data_revision,
+			    offset, &addr);
+		if (ret) {
+			dev_err(dev, "ERROR: To get %s i=%d addr=0x%x\n",
+				    phy_data_revision, i, addr);
+			break;
+		}
+
+		ret = of_property_read_u32_index(sub_node, phy_data_revision,
+			    offset + 1, &data);
+		if (ret) {
+			dev_err(dev, "ERROR: To get %s i=%d addr=0x%x\n",
+				    phy_data_revision, i, data);
+			break;
+		}
+
+		index = PAGE_ADDR_MAP_ARRAY_INDEX(addr);
+		phy_data_page = phy_data->page2 + index;
+		phy_data_page->addr = (char)addr;
+		phy_data_page->data = (char)data;
+
+		dev_dbg(dev, "%s index=%d addr=0x%x data=0x%x\n",
+			    phy_data_revision, index,
+			    phy_data_page->addr, phy_data_page->data);
+	}
+
+out:
+	return ret;
+}
+
+static int __get_phy_parameter(struct rtk_usb_phy *rtk_phy, int index)
+{
+	struct device *dev = rtk_phy->dev;
+	struct reg_addr *addr =
+		    &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	struct phy_data *phy_data =
+		    &((struct phy_data *)rtk_phy->phy_data)[index];
+	char phy_name[5], phy_name_v2[10];
+	struct device_node *sub_node;
+	int ret = 0;
+
+	addr->reg_wrap_vstatus = of_iomap(dev->of_node, 0);
+	addr->reg_gusb2phyacc0 = of_iomap(dev->of_node, index + 1);
+	addr->vstatus_index = index;
+	dev_dbg(dev, "%s %d #%d reg_wrap_vstatus=%p\n",
+		    __func__, __LINE__,
+		    index, addr->reg_wrap_vstatus);
+	dev_dbg(dev, "%s %d #%d reg_gusb2phyacc0=%p\n",
+		    __func__, __LINE__,
+		    index, addr->reg_gusb2phyacc0);
+
+	snprintf(phy_name, 5, "phy%d", index);
+
+	sub_node = of_get_child_by_name(dev->of_node, phy_name);
+	if (sub_node) {
+		dev_dbg(dev, "%s %d: #%d Get phy data v1 sub_node for %s\n",
+			    __func__, __LINE__, index, phy_name);
+		ret = __get_phy_parameter_v1(dev, phy_data, sub_node);
+		if (ret)
+			goto err;
+	} else {
+		snprintf(phy_name_v2, 10, "phy%d_data", index);
+		sub_node = of_get_child_by_name(dev->of_node, phy_name_v2);
+		if (sub_node) {
+			dev_dbg(dev, "%s %d: #%d Get phy data v2 sub_node for %s\n",
+			    __func__, __LINE__, index, phy_name_v2);
+			ret = __get_phy_parameter_v2(dev, phy_data, sub_node);
+			if (ret)
+				goto err;
+		}
+	}
+
+	if (!sub_node)
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
+		 "realtek,ldo-page0-e4-compensate", &phy_data->ldo_page0_e4_compensate))
+		phy_data->ldo_page0_e4_compensate = 0;
+
+	if (of_property_read_s32(sub_node,
+		 "realtek,page0-e4-compensate", &phy_data->page0_e4_compensate))
+		phy_data->page0_e4_compensate = 0;
+
+	__get_phy_parameter_by_efuse(rtk_phy, phy_data, index);
+
+	__get_default_phy_parameter_for_updated(rtk_phy, index);
+err:
+	return ret;
+}
+
+static int rtk_usb2phy_probe(struct platform_device *pdev)
+{
+	struct rtk_usb_phy *rtk_phy;
+	struct device *dev = &pdev->dev;
+	int index, ret = 0;
+	int port_index, phyN;
+
+	rtk_phy = devm_kzalloc(dev, sizeof(*rtk_phy), GFP_KERNEL);
+	if (!rtk_phy)
+		return -ENOMEM;
+
+	rtk_phy->dev			= &pdev->dev;
+	rtk_phy->phy.dev		= rtk_phy->dev;
+	rtk_phy->phy.label		= RTK_USB2PHY_NAME;
+	rtk_phy->phy.init		= rtk_usb_phy_init;
+	rtk_phy->phy.shutdown		= rtk_usb_phy_shutdown;
+	rtk_phy->phy.notify_port_status = rtk_usb_phy_notify_port_status;
+
+	if (!dev->of_node) {
+		dev_err(dev, "%s %d No device node\n", __func__, __LINE__);
+		goto err;
+	}
+
+	rtk_phy->usb_regs = syscon_regmap_lookup_by_phandle(dev->of_node, "realtek,usb");
+	if (IS_ERR(rtk_phy->usb_regs)) {
+		dev_info(dev, "%s: DTS no support usb regs syscon\n", __func__);
+		rtk_phy->usb_regs = NULL;
+	}
+
+	rtk_phy->mac_regs = syscon_regmap_lookup_by_phandle(dev->of_node, "realtek,mac");
+	if (IS_ERR(rtk_phy->mac_regs)) {
+		dev_info(dev, "%s: DTS no support mac regs syscon\n", __func__);
+		rtk_phy->mac_regs = NULL;
+	}
+
+	rtk_phy->usb_ctrl_regs = syscon_regmap_lookup_by_phandle(dev->of_node, "realtek,usb_ctrl");
+	if (IS_ERR(rtk_phy->usb_ctrl_regs)) {
+		dev_info(dev, "%s: DTS no support usb_ctrl regs syscon\n", __func__);
+		rtk_phy->usb_ctrl_regs = NULL;
+	}
+
+	ret = of_property_read_u32_index(dev->of_node, "realtek,port-index", 0,
+		    &port_index);
+	if (ret)
+		port_index = -1;
+
+	ret = of_property_read_u32_index(dev->of_node, "realtek,phyN", 0,
+		    &phyN);
+	if (ret) {
+		dev_err(dev, "%s get phyN fail (ret=%d)\n", __func__, ret);
+		goto err;
+	}
+
+	dev_dbg(dev, "%s port_index=%d phyN=%d\n", __func__, port_index, phyN);
+
+	rtk_phy->port_index = port_index;
+	rtk_phy->phyN = phyN;
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
+	for (index = 0; index < phyN; index++) {
+		ret = __get_phy_parameter(rtk_phy, index);
+		if (ret) {
+			dev_err(dev, "%s: __get_phy_parameter fail ret=%d\n",
+				    __func__, ret);
+			goto err;
+		}
+	}
+
+	platform_set_drvdata(pdev, rtk_phy);
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
+static int rtk_usb2phy_remove(struct platform_device *pdev)
+{
+	struct rtk_usb_phy *rtk_phy = platform_get_drvdata(pdev);
+
+	remove_debug_files(rtk_phy);
+
+	usb_remove_phy(&rtk_phy->phy);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id usbphy_rtk_dt_match[] = {
+	{ .compatible = "realtek,usb2phy", },
+	{ .compatible = "realtek,rtd-usb2phy", },
+	{ .compatible = "realtek,rtd1295-usb2phy", },
+	{ .compatible = "realtek,rtd1395-usb2phy", },
+	{ .compatible = "realtek,rtd1619-usb2phy", },
+	{ .compatible = "realtek,rtd1319-usb2phy", },
+	{ .compatible = "realtek,rtd1619b-usb2phy", },
+	{ .compatible = "realtek,rtd1312c-usb2phy", },
+	{ .compatible = "realtek,rtd1319d-usb2phy", },
+	{ .compatible = "realtek,rtd1315e-usb2phy", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, usbphy_rtk_dt_match);
+#endif
+
+static struct platform_driver rtk_usb2phy_driver = {
+	.probe		= rtk_usb2phy_probe,
+	.remove		= rtk_usb2phy_remove,
+	.driver		= {
+		.name	= RTK_USB2PHY_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(usbphy_rtk_dt_match),
+	},
+};
+
+module_platform_driver(rtk_usb2phy_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" RTK_USB2PHY_NAME);
+MODULE_AUTHOR("Realtek Semiconductor Corporation");
+MODULE_DESCRIPTION("RTK usb 2.0 phy driver");
diff --git a/drivers/usb/phy/phy-rtk-usb3.c b/drivers/usb/phy/phy-rtk-usb3.c
new file mode 100644
index 000000000000..dd669fd75ee6
--- /dev/null
+++ b/drivers/usb/phy/phy-rtk-usb3.c
@@ -0,0 +1,1165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  phy-rtk-usb3.c RTK usb3.0 phy driver
+ *
+ * copyright (c) 2023 realtek semiconductor corporation
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
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/phy.h>
+
+#include "phy-rtk-usb.h"
+
+#define RTK_USB3PHY_NAME "rtk-usb3phy"
+
+#define USB_MDIO_CTRL_PHY_BUSY BIT(7)
+#define USB_MDIO_CTRL_PHY_WRITE BIT(0)
+#define USB_MDIO_CTRL_PHY_ADDR_SHIFT 8
+#define USB_MDIO_CTRL_PHY_DATA_SHIFT 16
+
+#define PHY_ADDR_0x09 0x09
+#define PHY_ADDR_0x0B 0x0B
+#define PHY_ADDR_0x0D 0x0D
+#define PHY_ADDR_0x10 0x10
+#define PHY_ADDR_0x1F 0x1F
+#define PHY_ADDR_0x20 0x20
+#define PHY_ADDR_0x30 0x30
+
+#define REG_0x0B_RX_OFFSET_RANGE_MASK 0xC
+#define REG_0x0D_RX_DEBUG_TEST_EN BIT(6)
+#define REG_0x10_DEBUG_MODE_SETTING 0x3C0
+#define REG_0x10_DEBUG_MODE_SETTING_MASK 0x3F8
+#define REG_0x1F_RX_OFFSET_CODE_MASK 0x1E
+
+#define USB_U3_TX_LFPS_SWING_TRIM_SHIFT 4
+#define USB_U3_TX_LFPS_SWING_TRIM_MASK 0xF
+
+#define PHY_ADDR_MAP_ARRAY_INDEX(addr) (addr)
+#define ARRAY_INDEX_MAP_PHY_ADDR(index) (index)
+
+#define WRAP_CTR_reg  0x0
+#define PIPE3_POWER_DOWN_SEL BIT(10)
+
+struct reg_addr {
+	void __iomem *reg_mdio_ctl;
+};
+
+struct phy_parameter {
+	u8 addr;
+	u16 data;
+};
+
+struct phy_data {
+	int size;
+	struct phy_parameter *parameter;
+
+	bool check_efuse;
+	u8 efuse_usb_u3_tx_lfps_swing_trim;
+	bool do_toggle;
+	bool do_toggle_once;
+	bool use_default_parameter;
+	bool check_rx_front_end_offset;
+};
+
+static int rtk_usb_phy3_wait_vbusy(struct reg_addr *regAddr)
+{
+	return utmi_wait_register(regAddr->reg_mdio_ctl, USB_MDIO_CTRL_PHY_BUSY, 0);
+}
+
+static u16 rtk_usb_phy_read(struct reg_addr *regAddr, char addr)
+{
+	unsigned int regVal;
+	u32 value;
+
+	regVal = (addr << USB_MDIO_CTRL_PHY_ADDR_SHIFT);
+
+	writel(regVal, regAddr->reg_mdio_ctl);
+
+	rtk_usb_phy3_wait_vbusy(regAddr);
+
+	value = readl(regAddr->reg_mdio_ctl);
+	value = value >> USB_MDIO_CTRL_PHY_DATA_SHIFT;
+
+	return (u16)value;
+}
+
+static int rtk_usb_phy_write(struct reg_addr *regAddr, char addr, u16 data)
+{
+	unsigned int regVal;
+
+	regVal = USB_MDIO_CTRL_PHY_WRITE |
+		    (addr << USB_MDIO_CTRL_PHY_ADDR_SHIFT) |
+		    (data << USB_MDIO_CTRL_PHY_DATA_SHIFT);
+
+	writel(regVal, regAddr->reg_mdio_ctl);
+
+	rtk_usb_phy3_wait_vbusy(regAddr);
+
+	return 0;
+}
+
+static void do_rtk_usb3_phy_toggle(struct rtk_usb_phy *rtk_phy,
+	    int index, bool isConnect);
+
+static int do_rtk_usb_phy_init(struct rtk_usb_phy *rtk_phy, int phy_index)
+{
+	struct reg_addr *regAddr =
+		    &((struct reg_addr *)rtk_phy->reg_addr)[phy_index];
+	struct phy_data *phy_data =
+		    &((struct phy_data *)rtk_phy->phy_data)[phy_index];
+	int index = 0;
+	struct phy_parameter *phy_parameter = phy_data->parameter;
+
+	dev_dbg(rtk_phy->dev, "%s: init phy#%d\n", __func__, phy_index);
+
+	if (phy_data->use_default_parameter) {
+		dev_info(rtk_phy->dev, "%s phy#%d use default parameter\n",
+			    __func__, phy_index);
+		goto do_toggle;
+	}
+
+	for (index = 0; index < phy_data->size; index++) {
+		u8 addr = (phy_parameter + index)->addr;
+		u16 data = (phy_parameter + index)->data;
+
+		if (addr == 0xFF)
+			continue;
+
+		if (addr == PHY_ADDR_0x20) {
+			u8 efuse_val = phy_data->efuse_usb_u3_tx_lfps_swing_trim;
+			u16 val_mask = USB_U3_TX_LFPS_SWING_TRIM_MASK;
+			int val_shift = USB_U3_TX_LFPS_SWING_TRIM_SHIFT;
+
+			if (efuse_val) {
+				data &= ~(val_mask << val_shift);
+				data |= ((efuse_val & val_mask) << val_shift);
+			}
+		}
+
+		rtk_usb_phy_write(regAddr, addr, data);
+	}
+
+	for (index = 0; index < phy_data->size; index++) {
+		u8 addr = (phy_parameter + index)->addr;
+		u16 data = (phy_parameter + index)->data;
+
+		if (addr == 0xFF)
+			continue;
+
+		dev_dbg(rtk_phy->dev, "[USB3_PHY], addr = 0x%02x, data = 0x%04x ==> read value = 0x%04x\n",
+			    addr, data,
+			    rtk_usb_phy_read(regAddr, addr));
+	}
+
+do_toggle:
+	if (phy_data->do_toggle_once)
+		phy_data->do_toggle = true;
+
+	do_rtk_usb3_phy_toggle(rtk_phy, phy_index, false);
+
+	if (phy_data->do_toggle_once) {
+		u16 check_value = 0;
+		int count = 10;
+		u16 value_0x0D, value_0x10;
+
+		/* Enable Debug mode by set 0x0D and 0x10 */
+		value_0x0D = rtk_usb_phy_read(regAddr, PHY_ADDR_0x0D);
+		value_0x10 = rtk_usb_phy_read(regAddr, PHY_ADDR_0x10);
+
+		rtk_usb_phy_write(regAddr, PHY_ADDR_0x0D,
+			    value_0x0D | REG_0x0D_RX_DEBUG_TEST_EN);
+		rtk_usb_phy_write(regAddr, PHY_ADDR_0x10,
+			    (value_0x10 & ~REG_0x10_DEBUG_MODE_SETTING_MASK) |
+			    REG_0x10_DEBUG_MODE_SETTING);
+
+		check_value = rtk_usb_phy_read(regAddr, PHY_ADDR_0x30);
+
+		while (!(check_value & BIT(15))) {
+			check_value = rtk_usb_phy_read(regAddr, PHY_ADDR_0x30);
+			mdelay(1);
+			if (count-- < 0)
+				break;
+		}
+
+		if (!(check_value & BIT(15)))
+			dev_info(rtk_phy->dev, "toggle fail addr=0x%02x, data=0x%04x\n",
+				    PHY_ADDR_0x30, check_value);
+		else
+			dev_info(rtk_phy->dev, "toggle okay addr=0x%02x, data=0x%04x\n",
+				    PHY_ADDR_0x30, check_value);
+
+		/* Disable Debug mode by set 0x0D and 0x10 to default*/
+		rtk_usb_phy_write(regAddr, PHY_ADDR_0x0D, value_0x0D);
+		rtk_usb_phy_write(regAddr, PHY_ADDR_0x10, value_0x10);
+
+		phy_data->do_toggle = false;
+	}
+
+
+	if (phy_data->check_rx_front_end_offset) {
+		u16 rx_offset_code, rx_offset_range;
+		bool do_update = false;
+
+		rx_offset_code = rtk_usb_phy_read(regAddr, PHY_ADDR_0x1F);
+		if (((rx_offset_code & REG_0x1F_RX_OFFSET_CODE_MASK) == 0x0) ||
+			    ((rx_offset_code & REG_0x1F_RX_OFFSET_CODE_MASK) ==
+			      REG_0x1F_RX_OFFSET_CODE_MASK))
+			do_update = true;
+
+		rx_offset_range = rtk_usb_phy_read(regAddr, PHY_ADDR_0x0B);
+		if (((rx_offset_range & REG_0x0B_RX_OFFSET_RANGE_MASK) ==
+				    REG_0x0B_RX_OFFSET_RANGE_MASK) && do_update) {
+			dev_warn(rtk_phy->dev, "Don't update rx_offset_range (rx_offset_code=0x%x, rx_offset_range=0x%x)\n",
+				    rx_offset_code, rx_offset_range);
+			do_update = false;
+		}
+
+		if (do_update) {
+			u16 tmp1, tmp2;
+
+			tmp1 = rx_offset_range & (~REG_0x0B_RX_OFFSET_RANGE_MASK);
+			tmp2 = rx_offset_range & REG_0x0B_RX_OFFSET_RANGE_MASK;
+			tmp2 += (1 << 2);
+			rx_offset_range = tmp1 | (tmp2 & REG_0x0B_RX_OFFSET_RANGE_MASK);
+			rtk_usb_phy_write(regAddr, PHY_ADDR_0x0B, rx_offset_range);
+			goto do_toggle;
+		}
+	}
+
+	return 0;
+}
+
+static int rtk_usb_phy_init(struct usb_phy *phy)
+{
+	struct rtk_usb_phy *rtk_phy = container_of(phy, struct rtk_usb_phy, phy);
+	int ret = 0;
+	int i;
+	unsigned long phy_init_time = jiffies;
+
+	if (!rtk_phy) {
+		pr_err("%s rtk_phy is NULL!\n", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(phy->dev, "Init RTK USB 3.0 PHY\n");
+	for (i = 0; i < rtk_phy->phyN; i++)
+		ret = do_rtk_usb_phy_init(rtk_phy, i);
+
+	dev_info(phy->dev, "Initialized RTK USB 3.0 PHY (take %dms)\n",
+		    jiffies_to_msecs(jiffies - phy_init_time));
+	return ret;
+}
+
+static void rtk_usb_phyhutdown(struct usb_phy *phy)
+{
+	dev_dbg(phy->dev, "Shutdown RTK USB 3.0 PHY\n");
+}
+
+static void do_rtk_usb3_phy_toggle(struct rtk_usb_phy *rtk_phy, int i,
+	    bool isConnect)
+{
+	struct reg_addr *regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[i];
+	struct phy_data *phy_data = &((struct phy_data *)rtk_phy->phy_data)[i];
+	struct phy_parameter *phy_parameter;
+	size_t index;
+
+	if (!rtk_phy) {
+		pr_err("%s rtk_phy is NULL!\n", __func__);
+		return;
+	}
+
+	regAddr = &((struct reg_addr *)rtk_phy->reg_addr)[i];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[i];
+
+	if (!phy_data) {
+		dev_err(rtk_phy->dev, "%s phy_data is NULL!\n", __func__);
+		return;
+	}
+
+	if (!phy_data->do_toggle)
+		return;
+
+	/* Disable usb3 phy suspend form usb wrapper */
+	if (rtk_phy->usb_regs)
+		regmap_update_bits(rtk_phy->usb_regs, WRAP_CTR_reg,
+			    (unsigned int)PIPE3_POWER_DOWN_SEL,
+			    (unsigned int)PIPE3_POWER_DOWN_SEL);
+
+	phy_parameter = phy_data->parameter;
+
+	index = PHY_ADDR_MAP_ARRAY_INDEX(PHY_ADDR_0x09);
+
+	if (index < phy_data->size) {
+		u8 addr = (phy_parameter + index)->addr;
+		u16 data = (phy_parameter + index)->data;
+
+		if (addr == 0xFF) {
+			addr = ARRAY_INDEX_MAP_PHY_ADDR(index);
+			data = rtk_usb_phy_read(regAddr, addr);
+			(phy_parameter + index)->addr = addr;
+			(phy_parameter + index)->data = data;
+		}
+		mdelay(1);
+		dev_info(rtk_phy->dev,
+			    "%s ########## to toggle PHY addr 0x09 BIT(9)\n",
+			    __func__);
+		rtk_usb_phy_write(regAddr, addr, data&(~BIT(9)));
+		mdelay(1);
+		rtk_usb_phy_write(regAddr, addr, data);
+	}
+	dev_info(rtk_phy->dev, "%s ########## PHY addr 0x1f = 0x%04x\n",
+		    __func__, rtk_usb_phy_read(regAddr, PHY_ADDR_0x1F));
+
+	/* Enable usb3 phy suspend form usb wrapper, power control by mac */
+	if (rtk_phy->usb_regs)
+		regmap_update_bits(rtk_phy->usb_regs, WRAP_CTR_reg,
+			    (unsigned int)PIPE3_POWER_DOWN_SEL,
+			    (unsigned int)(~PIPE3_POWER_DOWN_SEL));
+}
+
+static void rtk_usb3_phy_toggle(struct usb_phy *usb3_phy, bool isConnect, int port)
+{
+	int index = port;
+	struct rtk_usb_phy *rtk_phy = NULL;
+
+	if (usb3_phy != NULL && usb3_phy->dev != NULL)
+		rtk_phy = dev_get_drvdata(usb3_phy->dev);
+
+	if (rtk_phy == NULL) {
+		pr_err("%s ERROR! NO this device\n", __func__);
+		return;
+	}
+
+	if (index > rtk_phy->phyN) {
+		pr_err("%s %d ERROR! port=%d > phyN=%d\n",
+			    __func__, __LINE__, index, rtk_phy->phyN);
+		return;
+	}
+
+	do_rtk_usb3_phy_toggle(rtk_phy, index, isConnect);
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
+		rtk_usb3_phy_toggle(x, isConnect, port);
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
+static int rtk_usb3_parameter_show(struct seq_file *s, void *unused)
+{
+	struct rtk_usb_phy		*rtk_phy = s->private;
+	int i, index;
+
+	for (i = 0; i < rtk_phy->phyN; i++) {
+		struct reg_addr *regAddr =
+			    &((struct reg_addr *)rtk_phy->reg_addr)[i];
+		struct phy_data *phy_data =
+			    &((struct phy_data *)rtk_phy->phy_data)[i];
+		struct phy_parameter *phy_parameter;
+
+		phy_parameter = phy_data->parameter;
+
+		seq_printf(s, "[USB3_PHY] PHY %d\n", i);
+
+		for (index = 0; index < phy_data->size; index++) {
+			u8 addr = ARRAY_INDEX_MAP_PHY_ADDR(index);
+			u16 data = (phy_parameter + index)->data;
+
+			if ((phy_parameter + index)->addr == 0xFF)
+				seq_printf(s, "[USB3_PHY], addr = 0x%02x, data = none   ==> read value = 0x%04x\n",
+					    addr,
+					    rtk_usb_phy_read(regAddr, addr));
+			else
+				seq_printf(s, "[USB3_PHY], addr = 0x%02x, data = 0x%04x ==> read value = 0x%04x\n",
+					    addr, data,
+					    rtk_usb_phy_read(regAddr, addr));
+		}
+
+		seq_puts(s, "Property:\n");
+		seq_printf(s, "check_efuse: %s\n",
+			    phy_data->check_efuse?"Enable":"Disable");
+		seq_printf(s, "efuse_usb_u3_tx_lfps_swing_trim: 0x%x\n",
+			    (int)phy_data->efuse_usb_u3_tx_lfps_swing_trim);
+		seq_printf(s, "do_toggle: %s\n",
+			    phy_data->do_toggle?"Enable":"Disable");
+		seq_printf(s, "do_toggle_once: %s\n",
+			    phy_data->do_toggle_once?"Enable":"Disable");
+		seq_printf(s, "use_default_parameter: %s\n",
+			    phy_data->use_default_parameter?"Enable":"Disable");
+	}
+	return 0;
+}
+
+static int rtk_usb3_parameter_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtk_usb3_parameter_show, inode->i_private);
+}
+
+static const struct file_operations rtk_usb3_parameter_fops = {
+	.open			= rtk_usb3_parameter_open,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+static int __get_parameter_at_page(struct seq_file *s,
+	    struct rtk_usb_phy *rtk_phy,
+	    struct phy_parameter *phy_parameter_array,
+	    const char *phy_addr)
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
+
+	i = PHY_ADDR_MAP_ARRAY_INDEX(addr);
+	phy_parameter = (phy_parameter_array + i);
+
+	if (phy_parameter->addr != 0xFF)
+		seq_printf(s, "Now Parameter addr 0x%02x = 0x%04x\n",
+			    phy_parameter->addr, phy_parameter->data);
+	else
+		seq_printf(s, "Now Parameter addr 0x%02x is default\n",
+			    addr);
+
+	dev_dbg(rtk_phy->dev, "%s addr=0x%02x data=0x%04x\n",
+		    __func__, phy_parameter->addr, phy_parameter->data);
+
+	return 0;
+}
+
+static int __set_parameter_at_page(
+	    struct rtk_usb_phy *rtk_phy,
+	    struct reg_addr *regAddr, struct phy_data *phy_data,
+	    struct phy_parameter *phy_parameter_array,
+	    const char *phy_addr, const char *phy_value)
+{
+	struct phy_parameter *phy_parameter;
+	uint32_t addr, value;
+	int i, ret;
+
+	ret = kstrtouint(phy_addr, 16, &addr);
+	if (ret < 0) {
+		pr_err("%s::kstrtouint() failed\n", __func__);
+		return -EINVAL;
+	}
+	ret = kstrtouint(phy_value, 16, &value);
+	if (ret < 0) {
+		pr_err("%s::kstrtouint() failed\n", __func__);
+		return -EINVAL;
+	}
+
+	i = PHY_ADDR_MAP_ARRAY_INDEX(addr);
+	phy_parameter = (phy_parameter_array + i);
+
+	if (phy_parameter->addr != 0xFF) {
+		phy_parameter->data = value;
+	} else {
+		phy_parameter->addr = addr;
+		phy_parameter->data = value;
+	}
+
+	dev_info(rtk_phy->dev, "%s addr=0x%02x data=0x%04x\n",
+		    __func__, phy_parameter->addr, phy_parameter->data);
+
+	if (addr == PHY_ADDR_0x20)
+		dev_info(rtk_phy->dev,
+			    "%s PHY_ADDR_0x20 NOT use efuse u3_tx_lfps_swing_trim value\n",
+			    __func__);
+
+	if (rtk_usb_phy_write(regAddr, addr, value))
+		dev_err(rtk_phy->dev,
+				    "[%s:%d] Error: addr=0x%02x value=0x%04x\n",
+				    __func__, __LINE__, addr, value);
+
+	return 0;
+}
+
+static int rtk_usb3_set_parameter_show(struct seq_file *s, void *unused)
+{
+	struct rtk_usb_phy *rtk_phy = s->private;
+	const struct file *file = s->file;
+	const char *file_name = file_dentry(file)->d_iname;
+	struct dentry *p_dentry = file_dentry(file)->d_parent;
+	const char *phy_dir_name = p_dentry->d_iname;
+	int ret, index;
+	struct phy_data *phy_data;
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
+				    "%s: No phy_data for %s/%s\n",
+				    __func__, phy_dir_name, file_name);
+		return -EINVAL;
+	}
+
+	ret = __get_parameter_at_page(s, rtk_phy, phy_data->parameter, file_name);
+	if (ret < 0)
+		return ret;
+
+	seq_puts(s, "Set phy parameter by following command\n");
+	seq_printf(s, "echo \"value\" > %s/%s\n",
+		    phy_dir_name, file_name);
+
+	return 0;
+}
+
+static int rtk_usb3_set_parameter_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtk_usb3_set_parameter_show, inode->i_private);
+}
+
+static ssize_t rtk_usb3_set_parameter_write(struct file *file,
+		const char __user *ubuf, size_t count, loff_t *ppos)
+{
+	const char *file_name = file_dentry(file)->d_iname;
+	struct dentry *p_dentry = file_dentry(file)->d_parent;
+	const char *phy_dir_name = p_dentry->d_iname;
+	struct seq_file		*s = file->private_data;
+	struct rtk_usb_phy		*rtk_phy = s->private;
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
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
+				    "%s: No regAddr for %s/%s\n",
+				    __func__, phy_dir_name, file_name);
+		return -EINVAL;
+	}
+	if (!phy_data) {
+		dev_err(rtk_phy->dev,
+				    "%s: No phy_data for %s/%s\n",
+				    __func__, phy_dir_name, file_name);
+		return -EINVAL;
+	}
+
+	ret = __set_parameter_at_page(rtk_phy, regAddr, phy_data,
+		    phy_data->parameter, file_name, buffer);
+	if (ret < 0)
+		return ret;
+
+	return count;
+}
+
+static const struct file_operations rtk_usb3_set_parameter_fops = {
+	.open			= rtk_usb3_set_parameter_open,
+	.write			= rtk_usb3_set_parameter_write,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+static int rtk_usb3_toggle_show(struct seq_file *s, void *unused)
+{
+	struct rtk_usb_phy		*rtk_phy = s->private;
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
+static int rtk_usb3_toggle_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, rtk_usb3_toggle_show, inode->i_private);
+}
+
+static ssize_t rtk_usb3_toggle_write(struct file *file,
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
+static const struct file_operations rtk_usb3_toggle_fops = {
+	.open			= rtk_usb3_toggle_open,
+	.write			= rtk_usb3_toggle_write,
+	.read			= seq_read,
+	.llseek			= seq_lseek,
+	.release		= single_release,
+};
+
+static int create_debug_set_parameter_files(struct rtk_usb_phy *rtk_phy,
+	    struct dentry *phy_dir, size_t addr_size)
+{
+	int i;
+
+	for (i = 0; i < addr_size; i++) {
+		size_t sz = 30;
+		char name[30] = {0};
+
+		snprintf(name, sz, "%02x", ARRAY_INDEX_MAP_PHY_ADDR(i));
+
+		if (!debugfs_create_file(name, 0644,
+			    phy_dir, rtk_phy,
+			    &rtk_usb3_set_parameter_fops))
+			dev_err(rtk_phy->dev,
+				    "%s Error create file %s fail",
+				    name, __func__);
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
+	rtk_phy->debug_dir = debugfs_create_dir(dev_name(rtk_phy->dev),
+		    phy_debug_root);
+	if (!rtk_phy->debug_dir) {
+		dev_err(rtk_phy->dev, "%s Error debug_dir is NULL", __func__);
+		return;
+	}
+
+	if (!debugfs_create_file("parameter", 0444,
+		    rtk_phy->debug_dir, rtk_phy,
+		    &rtk_usb3_parameter_fops))
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
+				    phy_data->size);
+			if (ret < 0) {
+				dev_err(rtk_phy->dev,
+					    "%s Error create files fail\n",
+					    __func__);
+				goto file_error;
+			}
+		}
+	}
+
+	if (!debugfs_create_file("toggle", 0644, rtk_phy->debug_dir, rtk_phy,
+		    &rtk_usb3_toggle_fops))
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
+
+	if (!phy_data->check_efuse)
+		goto out;
+
+	cell = nvmem_cell_get(rtk_phy->dev, "usb_u3_tx_lfps_swing_trim");
+	if (IS_ERR(cell)) {
+		dev_warn(rtk_phy->dev,
+			    "%s failed to get usb_u3_tx_lfps_swing_trim: %ld\n",
+			    __func__, PTR_ERR(cell));
+	} else {
+		unsigned char *buf;
+		size_t buf_size;
+
+		buf = nvmem_cell_read(cell, &buf_size);
+
+		value = buf[0] & USB_U3_TX_LFPS_SWING_TRIM_MASK;
+
+		dev_dbg(rtk_phy->dev,
+			    "phy index=%d buf=0x%x buf_size=%d value=0x%x\n",
+			    index, buf[0], (int)buf_size, value);
+		kfree(buf);
+		nvmem_cell_put(cell);
+	}
+
+	if ((value > 0) && (value < 0x8))
+		phy_data->efuse_usb_u3_tx_lfps_swing_trim = 0x8;
+	else
+		phy_data->efuse_usb_u3_tx_lfps_swing_trim = (u8)value;
+
+	dev_dbg(rtk_phy->dev, "Get Efuse usb_u3_tx_lfps_swing_trim=0x%x (value=0x%x)\n",
+		    phy_data->efuse_usb_u3_tx_lfps_swing_trim, value);
+
+out:
+	return 0;
+}
+
+static int __get_phy_parameter_v1(struct device *dev, struct phy_data *phy_data,
+	    struct device_node *sub_node)
+{
+	struct phy_parameter *phy_parameter;
+	int revision, i, ret = 0;
+	u8 *addr;
+	u16 *data;
+
+	ret = of_property_read_u32_index(sub_node, "realtek,phy-data-size", 0,
+		    &phy_data->size);
+	if (ret)
+		goto out;
+
+	phy_data->parameter = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * phy_data->size,
+		    GFP_KERNEL);
+	if (!phy_data->parameter)
+		return -ENOMEM;
+
+	addr = kcalloc(phy_data->size, sizeof(u8), GFP_KERNEL);
+	if (!addr) {
+		kfree(phy_data->parameter);
+		phy_data->parameter = NULL;
+		return -ENOMEM;
+	}
+
+	data = kcalloc(phy_data->size, sizeof(u16), GFP_KERNEL);
+	if (!data) {
+		kfree(phy_data->parameter);
+		kfree(addr);
+		phy_data->parameter = NULL;
+		return -ENOMEM;
+	}
+	ret = of_property_read_u8_array(sub_node, "realtek,phy-data-addr",
+		    addr, phy_data->size);
+	if (ret)
+		goto out;
+
+	revision = __get_chip_revision();
+	dev_dbg(dev, "%s: Chip revision is %x\n", __func__, revision);
+
+	while (revision >= DEFAULT_CHIP_REVISION) {
+		char phy_data_revision[32] = {0};
+
+		snprintf(phy_data_revision, 21, "realtek,phy-data-%X",
+			    revision);
+		ret = of_property_read_u16_array(sub_node,
+			    phy_data_revision,
+			    data, phy_data->size);
+		if (!ret) {
+			dev_dbg(dev, "%s load %s parameter\n",
+				    __func__, phy_data_revision);
+			break;
+		}
+		revision--;
+		if ((revision & 0xFF) > 0xF)
+			revision = (revision & 0xF00) + 0xF;
+	}
+
+	/* For old device tree */
+	if (ret) {
+		ret = of_property_read_u16_array(sub_node,
+			    "realtek,phy-data-revA",
+			    data, phy_data->size);
+		if (ret)
+			goto out;
+		else
+			dev_info(dev, "%s load parameter\n", __func__);
+	}
+
+	phy_parameter = phy_data->parameter;
+
+	for (i = 0; i < phy_data->size; i++) {
+		(phy_parameter + i)->addr = *(addr + i);
+		(phy_parameter + i)->data = *(data + i);
+		dev_dbg(dev, "%s i=%d addr=0x%x data=0x%x\n",
+			    __func__, i, (phy_parameter + i)->addr,
+			    (phy_parameter + i)->data);
+	}
+
+out:
+	kfree(addr);
+	kfree(data);
+
+	return ret;
+}
+
+static int __get_phy_parameter_v2(struct device *dev, struct phy_data *phy_data,
+	    struct device_node *sub_node)
+{
+	struct phy_parameter *phy_parameter;
+	int revision, i, ret = 0;
+	int data_size, num_cells = 2;
+	char phy_data_revision[32] = {0};
+
+	ret = of_property_read_u32_index(sub_node, "realtek,phy-data-size", 0,
+		    &phy_data->size);
+	if (ret)
+		goto out;
+
+	phy_data->parameter = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * phy_data->size,
+		    GFP_KERNEL);
+	if (!phy_data->parameter)
+		return -ENOMEM;
+
+	revision = __get_chip_revision();
+	dev_dbg(dev, "%s: Chip revision is %x\n", __func__, revision);
+
+	while (revision >= DEFAULT_CHIP_REVISION) {
+		snprintf(phy_data_revision, 21, "realtek,phy-data-%X",
+			    revision);
+		if (of_get_property(sub_node, phy_data_revision, &data_size)) {
+			dev_dbg(dev, "%s load %s parameter (data_size=%d)\n",
+				    __func__, phy_data_revision, data_size);
+			break;
+		}
+		revision--;
+		if ((revision & 0xFF) > 0xF)
+			revision = (revision & 0xF00) + 0xF;
+
+		data_size = 0;
+		ret = 0;
+	}
+
+	phy_parameter = phy_data->parameter;
+	for (i = 0; i < phy_data->size; i++)
+		(phy_parameter + i)->addr = 0xFF;
+
+	data_size = data_size / (sizeof(u32) * num_cells);
+	for (i = 0; i < data_size; i++) {
+		struct phy_parameter *parameter;
+		u32 addr, data;
+		int offset, index;
+
+		offset = i * num_cells;
+
+		ret = of_property_read_u32_index(sub_node, phy_data_revision,
+			    offset, &addr);
+		if (ret) {
+			dev_err(dev, "ERROR: To get %s i=%d addr=0x%x\n",
+				    phy_data_revision, i, addr);
+			break;
+		}
+
+		ret = of_property_read_u32_index(sub_node, phy_data_revision,
+			    offset + 1, &data);
+		if (ret) {
+			dev_err(dev, "ERROR: To get %s i=%d addr=0x%x\n",
+				    phy_data_revision, i, data);
+			break;
+		}
+
+		index = PHY_ADDR_MAP_ARRAY_INDEX(addr);
+		parameter = (phy_parameter + index);
+		parameter->addr = (u8)addr;
+		parameter->data = (u16)data;
+
+		dev_dbg(dev, "%s index=%d addr=0x%x data=0x%x\n",
+			    phy_data_revision, index,
+			    parameter->addr, parameter->data);
+	}
+
+out:
+	return ret;
+}
+
+static int rtk_usb3phy_probe(struct platform_device *pdev)
+{
+	struct rtk_usb_phy *rtk_phy;
+	struct device *dev = &pdev->dev;
+	int i, ret, phyN;
+
+	rtk_phy = devm_kzalloc(dev, sizeof(*rtk_phy), GFP_KERNEL);
+	if (!rtk_phy)
+		return -ENOMEM;
+
+	rtk_phy->dev			= &pdev->dev;
+	rtk_phy->phy.dev		= rtk_phy->dev;
+	rtk_phy->phy.label		= RTK_USB3PHY_NAME;
+	rtk_phy->phy.init		= rtk_usb_phy_init;
+	rtk_phy->phy.shutdown		= rtk_usb_phyhutdown;
+	rtk_phy->phy.notify_port_status = rtk_usb_phy_notify_port_status;
+
+	if (!dev->of_node) {
+		dev_err(dev, "%s %d No device node\n", __func__, __LINE__);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	rtk_phy->usb_regs = syscon_regmap_lookup_by_phandle(dev->of_node, "realtek,usb");
+	if (IS_ERR(rtk_phy->usb_regs)) {
+		dev_info(dev, "%s: DTS no support usb regs syscon\n", __func__);
+		rtk_phy->usb_regs = NULL;
+	}
+
+	rtk_phy->mac_regs = syscon_regmap_lookup_by_phandle(dev->of_node, "realtek,mac");
+	if (IS_ERR(rtk_phy->mac_regs)) {
+		dev_info(dev, "%s: DTS no support mac regs syscon\n", __func__);
+		rtk_phy->mac_regs = NULL;
+	}
+
+	rtk_phy->usb_ctrl_regs = syscon_regmap_lookup_by_phandle(dev->of_node, "realtek,usb_ctrl");
+	if (IS_ERR(rtk_phy->usb_ctrl_regs)) {
+		dev_info(dev, "%s: DTS no support usb_ctrl regs syscon\n", __func__);
+		rtk_phy->usb_ctrl_regs = NULL;
+	}
+
+	ret = of_property_read_u32_index(dev->of_node, "realtek,phyN", 0,
+		    &phyN);
+	if (ret)
+		goto err;
+
+	rtk_phy->phyN = phyN;
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
+	for (i = 0; i < phyN; i++) {
+		struct reg_addr *addr =
+			    &((struct reg_addr *)rtk_phy->reg_addr)[i];
+		struct phy_data *phy_data =
+			    &((struct phy_data *)rtk_phy->phy_data)[i];
+
+		char phy_name[5], phy_name_v2[10];
+		struct device_node *sub_node;
+
+		addr->reg_mdio_ctl = of_iomap(dev->of_node, i);
+		dev_dbg(dev, "%s %d #%d reg_mdio_ctl=%p\n",
+			    __func__, __LINE__, i, addr->reg_mdio_ctl);
+
+		snprintf(phy_name, 5, "phy%d", i);
+
+		sub_node = of_get_child_by_name(dev->of_node, phy_name);
+		if (sub_node) {
+			dev_dbg(dev, "%s %d: #%d Get phy data v1 sub_node for %s\n",
+				    __func__, __LINE__, i, phy_name);
+			ret = __get_phy_parameter_v1(dev, phy_data, sub_node);
+			if (ret)
+				goto err;
+		} else {
+			snprintf(phy_name_v2, 10, "phy%d_data", i);
+			sub_node = of_get_child_by_name(dev->of_node, phy_name_v2);
+			if (sub_node) {
+				dev_dbg(dev, "%s %d: #%d Get phy data v2 sub_node for %s\n",
+					    __func__, __LINE__, i, phy_name_v2);
+				ret = __get_phy_parameter_v2(dev, phy_data, sub_node);
+				if (ret)
+					goto err;
+			}
+		}
+
+		if (!sub_node) {
+			dev_err(dev, "%s %d No device sub node for %s\n",
+				    __func__, __LINE__, phy_name);
+			goto err;
+		}
+
+		if (of_property_read_bool(sub_node, "realtek,do-toggle-once"))
+			phy_data->do_toggle_once = true;
+		else
+			phy_data->do_toggle_once = false;
+
+		if (of_property_read_bool(sub_node, "realtek,do-toggle"))
+			phy_data->do_toggle = true;
+		else
+			phy_data->do_toggle = false;
+
+		if (of_property_read_bool(sub_node, "realtek,use-default-parameter"))
+			phy_data->use_default_parameter = true;
+		else
+			phy_data->use_default_parameter = false;
+
+		if (of_property_read_bool(sub_node, "realtek,check-rx-front-end-offset"))
+			phy_data->check_rx_front_end_offset = true;
+		else
+			phy_data->check_rx_front_end_offset = false;
+
+		if (of_property_read_bool(sub_node, "realtek,check-efuse"))
+			phy_data->check_efuse = true;
+		else
+			phy_data->check_efuse = false;
+
+		__get_phy_parameter_by_efuse(rtk_phy, phy_data, i);
+	}
+
+	platform_set_drvdata(pdev, rtk_phy);
+
+	ret = usb_add_phy_dev(&rtk_phy->phy);
+	if (ret)
+		goto err;
+
+	create_debug_files(rtk_phy);
+
+err:
+	dev_dbg(&pdev->dev, "Probe RTK USB 3.0 PHY (ret=%d)\n", ret);
+
+	return ret;
+}
+
+static int rtk_usb3phy_remove(struct platform_device *pdev)
+{
+	struct rtk_usb_phy *rtk_phy = platform_get_drvdata(pdev);
+
+	remove_debug_files(rtk_phy);
+
+	usb_remove_phy(&rtk_phy->phy);
+
+	return 0;
+}
+
+#ifdef CONFIG_OF
+static const struct of_device_id usbphy_rtk_dt_match[] = {
+	{ .compatible = "realtek,usb3phy", },
+	{ .compatible = "realtek,rtd-usb3phy", },
+	{ .compatible = "realtek,rtd1295-usb3phy", },
+	{ .compatible = "realtek,rtd1619-usb3phy", },
+	{ .compatible = "realtek,rtd1319-usb3phy", },
+	{ .compatible = "realtek,rtd1619b-usb3phy", },
+	{ .compatible = "realtek,rtd1319d-usb3phy", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, usbphy_rtk_dt_match);
+#endif
+
+static struct platform_driver rtk_usb3phy_driver = {
+	.probe		= rtk_usb3phy_probe,
+	.remove		= rtk_usb3phy_remove,
+	.driver		= {
+		.name	= RTK_USB3PHY_NAME,
+		.owner	= THIS_MODULE,
+		.of_match_table = of_match_ptr(usbphy_rtk_dt_match),
+	},
+};
+
+module_platform_driver(rtk_usb3phy_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:" RTK_USB3PHY_NAME);
+MODULE_AUTHOR("Realtek Semiconductor Corporation");
+MODULE_DESCRIPTION("RTK usb 3.0 phy driver");
-- 
2.34.1

