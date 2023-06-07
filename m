Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9515372541E
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjFGG0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbjFGG0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:26:31 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428761726;
        Tue,  6 Jun 2023 23:26:25 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 3576P8KQ0024452, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 3576P8KQ0024452
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 7 Jun 2023 14:25:08 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 7 Jun 2023 14:25:23 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 7 Jun 2023 14:25:23 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 7 Jun 2023 14:25:23 +0800
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
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "Flavio Suligoi" <f.suligoi@asem.it>,
        Matthias Kaehlcke <mka@chromium.org>,
        "Mathias Nyman" <mathias.nyman@linux.intel.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: [PATCH v3 3/5] phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY
Date:   Wed, 7 Jun 2023 14:24:39 +0800
Message-ID: <20230607062500.24669-3-stanley_chang@realtek.com>
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
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek DHC (digital home center) RTD SoCs support DWC3 XHCI USB
controller. Added the driver to drive the USB 3.0 PHY transceivers.

Signed-off-by: Stanley Chang <stanley_chang@realtek.com>
---
v2 to v3 change:
    1. Broken down into two patches, one for each of USB 2 & 3 PHY.
    2. Removed parameter v1 support for simplification.
    3. Used remove_new for driver remove callback.
v1 to v2 change:
    1. Move the drivers to drivers/phy/ for generic phy driver
    2. Use the generic phy driver api to initialize phy
    3. Use readl/writel to instead phy_read/phy_write directly.
    4. Use read_poll_timeout() in function utmi_wait_register.
    5. Revised some coding styles.
    6. fix the compiler warning for kernel test robot.
---
 drivers/phy/realtek/Kconfig        |   10 +
 drivers/phy/realtek/Makefile       |    1 +
 drivers/phy/realtek/phy-rtk-usb3.c | 1070 ++++++++++++++++++++++++++++
 3 files changed, 1081 insertions(+)
 create mode 100644 drivers/phy/realtek/phy-rtk-usb3.c

diff --git a/drivers/phy/realtek/Kconfig b/drivers/phy/realtek/Kconfig
index 76e31f6abdee..28ee3d9be568 100644
--- a/drivers/phy/realtek/Kconfig
+++ b/drivers/phy/realtek/Kconfig
@@ -11,3 +11,13 @@ config PHY_RTK_RTD_USB2PHY
 	  The DHC (digital home center) RTD series SoCs used the Synopsys
 	  DWC3 USB IP. This driver will do the PHY initialization
 	  of the parameters.
+
+config PHY_RTK_RTD_USB3PHY
+	tristate "Realtek RTD USB3 PHY Transceiver Driver"
+	select GENERIC_PHY
+	select USB_PHY
+	help
+	  Enable this to support Realtek SoC USB3 phy transceiver.
+	  The DHC (digital home center) RTD series SoCs used the Synopsys
+	  DWC3 USB IP. This driver will do the PHY initialization
+	  of the parameters.
diff --git a/drivers/phy/realtek/Makefile b/drivers/phy/realtek/Makefile
index cf5d440841a2..ed7b47ff8a26 100644
--- a/drivers/phy/realtek/Makefile
+++ b/drivers/phy/realtek/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PHY_RTK_RTD_USB2PHY)	+= phy-rtk-usb2.o
+obj-$(CONFIG_PHY_RTK_RTD_USB3PHY)	+= phy-rtk-usb3.o
diff --git a/drivers/phy/realtek/phy-rtk-usb3.c b/drivers/phy/realtek/phy-rtk-usb3.c
new file mode 100644
index 000000000000..aae0525ce78d
--- /dev/null
+++ b/drivers/phy/realtek/phy-rtk-usb3.c
@@ -0,0 +1,1070 @@
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
+#include <linux/phy/phy.h>
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+#include <linux/usb/phy.h>
+
+#define USB_MDIO_CTRL_PHY_BUSY BIT(7)
+#define USB_MDIO_CTRL_PHY_WRITE BIT(0)
+#define USB_MDIO_CTRL_PHY_ADDR_SHIFT 8
+#define USB_MDIO_CTRL_PHY_DATA_SHIFT 16
+
+#define MAX_USB_PHY_DATA_SIZE 0x30
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
+struct rtk_usb_phy {
+	struct usb_phy phy;
+	struct device *dev;
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
+static void do_rtk_usb3_phy_toggle(struct rtk_usb_phy *rtk_phy, int i,
+	    bool isConnect)
+{
+	struct reg_addr *regAddr;
+	struct phy_data *phy_data;
+	struct phy_parameter *phy_parameter;
+	size_t index;
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
+}
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
+static int rtk_usb_phy_init(struct phy *phy)
+{
+	struct rtk_usb_phy *rtk_phy = phy_get_drvdata(phy);
+	int ret = 0;
+	int i;
+	unsigned long phy_init_time = jiffies;
+
+	if (!rtk_phy) {
+		pr_err("%s rtk_phy is NULL!\n", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(rtk_phy->dev, "Init RTK USB 3.0 PHY\n");
+	for (i = 0; i < rtk_phy->phyN; i++)
+		ret = do_rtk_usb_phy_init(rtk_phy, i);
+
+	dev_info(rtk_phy->dev, "Initialized RTK USB 3.0 PHY (take %dms)\n",
+		    jiffies_to_msecs(jiffies - phy_init_time));
+	return ret;
+}
+
+static int rtk_usb_phy_exit(struct phy *phy)
+{
+	struct rtk_usb_phy *rtk_phy = phy_get_drvdata(phy);
+
+	if (!rtk_phy) {
+		pr_err("%s rtk_phy is NULL!\n", __func__);
+		return -ENODEV;
+	}
+
+	dev_dbg(rtk_phy->dev, "Exit RTK USB 3.0 PHY\n");
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
+static void rtk_usb_phy_toggle(struct usb_phy *usb3_phy, bool isConnect, int port)
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
+static int __get_phy_parameter(struct device *dev, struct phy_data *phy_data,
+	    struct device_node *sub_node)
+{
+	struct phy_parameter *phy_parameter;
+	int i, ret = 0;
+	int data_size, num_cells = 2;
+
+	phy_data->size = MAX_USB_PHY_DATA_SIZE;
+	phy_data->parameter = devm_kzalloc(dev,
+		    sizeof(struct phy_parameter) * phy_data->size, GFP_KERNEL);
+	if (!phy_data->parameter)
+		return -ENOMEM;
+
+	if (!of_get_property(sub_node, "realtek,param", &data_size)) {
+		dev_dbg(dev, "%s No parameter (data_size=%d)\n",
+			    __func__, data_size);
+		data_size = 0;
+	}
+
+	if (!data_size)
+		goto out;
+
+	phy_parameter = phy_data->parameter;
+	/* Set default addr to 0xff for no data case */
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
+		ret = of_property_read_u32_index(sub_node, "realtek,param",
+			    offset, &addr);
+		if (ret) {
+			dev_err(dev, "ERROR: To get param i=%d addr=0x%x\n",
+				    i, addr);
+			break;
+		}
+
+		ret = of_property_read_u32_index(sub_node, "realtek,param",
+			    offset + 1, &data);
+		if (ret) {
+			dev_err(dev, "ERROR: To get param i=%d addr=0x%x\n",
+				    i, data);
+			break;
+		}
+
+		index = PHY_ADDR_MAP_ARRAY_INDEX(addr);
+		parameter = (phy_parameter + index);
+		parameter->addr = (u8)addr;
+		parameter->data = (u16)data;
+
+		dev_dbg(dev, "param index=%d addr=0x%x data=0x%x\n", index,
+			    parameter->addr, parameter->data);
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
+	addr =  &((struct reg_addr *)rtk_phy->reg_addr)[index];
+	phy_data = &((struct phy_data *)rtk_phy->phy_data)[index];
+
+	addr->reg_mdio_ctl = of_iomap(dev->of_node, 0) + index;
+	dev_dbg(dev, "%s %d #%d reg_mdio_ctl=%p\n",
+		    __func__, __LINE__, index, addr->reg_mdio_ctl);
+
+	if (!sub_node) {
+		dev_err(dev, "%s %d No device sub node\n", __func__, __LINE__);
+		goto err;
+	}
+
+	ret = __get_phy_parameter(dev, phy_data, sub_node);
+	if (ret)
+		goto err;
+
+	if (of_property_read_bool(sub_node, "realtek,do-toggle-once"))
+		phy_data->do_toggle_once = true;
+	else
+		phy_data->do_toggle_once = false;
+
+	if (of_property_read_bool(sub_node, "realtek,do-toggle"))
+		phy_data->do_toggle = true;
+	else
+		phy_data->do_toggle = false;
+
+	if (of_property_read_bool(sub_node, "realtek,use-default-parameter"))
+		phy_data->use_default_parameter = true;
+	else
+		phy_data->use_default_parameter = false;
+
+	if (of_property_read_bool(sub_node, "realtek,check-rx-front-end-offset"))
+		phy_data->check_rx_front_end_offset = true;
+	else
+		phy_data->check_rx_front_end_offset = false;
+
+	if (of_property_read_bool(sub_node, "realtek,check-efuse"))
+		phy_data->check_efuse = true;
+	else
+		phy_data->check_efuse = false;
+
+	__get_phy_parameter_by_efuse(rtk_phy, phy_data, index);
+
+err:
+	return ret;
+}
+
+static int rtk_usb3phy_probe(struct platform_device *pdev)
+{
+	struct rtk_usb_phy *rtk_phy;
+	struct device *dev = &pdev->dev;
+	struct device_node *node;
+	struct device_node *sub_node;
+	struct phy *generic_phy;
+	struct phy_provider *phy_provider;
+	int ret, phyN;
+
+	rtk_phy = devm_kzalloc(dev, sizeof(*rtk_phy), GFP_KERNEL);
+	if (!rtk_phy)
+		return -ENOMEM;
+
+	rtk_phy->dev			= &pdev->dev;
+	rtk_phy->phy.dev		= rtk_phy->dev;
+	rtk_phy->phy.label		= "rtk-usb3phy";
+	rtk_phy->phy.notify_port_status = rtk_usb_phy_notify_port_status;
+
+	if (!dev->of_node) {
+		dev_err(dev, "%s %d No device node\n", __func__, __LINE__);
+		ret = -ENODEV;
+		goto err;
+	}
+
+	node = dev->of_node;
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
+	dev_dbg(&pdev->dev, "Probe RTK USB 3.0 PHY (ret=%d)\n", ret);
+
+	return ret;
+}
+
+static void rtk_usb3phy_remove(struct platform_device *pdev)
+{
+	struct rtk_usb_phy *rtk_phy = platform_get_drvdata(pdev);
+
+	remove_debug_files(rtk_phy);
+
+	usb_remove_phy(&rtk_phy->phy);
+}
+
+static const struct of_device_id usbphy_rtk_dt_match[] = {
+	{ .compatible = "realtek,usb3phy", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, usbphy_rtk_dt_match);
+
+static struct platform_driver rtk_usb3phy_driver = {
+	.probe		= rtk_usb3phy_probe,
+	.remove_new	= rtk_usb3phy_remove,
+	.driver		= {
+		.name	= "rtk-usb3phy",
+		.owner	= THIS_MODULE,
+		.of_match_table = usbphy_rtk_dt_match,
+	},
+};
+
+module_platform_driver(rtk_usb3phy_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform: rtk-usb3phy");
+MODULE_AUTHOR("Stanley Chang <stanley_chang@realtek.com>");
+MODULE_DESCRIPTION("Realtek usb 3.0 phy driver");
-- 
2.34.1

