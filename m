Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4455744795
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Jul 2023 09:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGAHMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Jul 2023 03:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231523AbjGAHLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Jul 2023 03:11:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6CD46A8;
        Sat,  1 Jul 2023 00:08:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1688195305; x=1719731305;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=WKN4Gj8OhKpw4+Ln7vmsDjbu71/nm2LHklC27FW4W9w=;
  b=e2jfJqO541YHE12QwvnXBgZAx/LbyNFrZEi5ZW76wtR/rv9Ulsnz55eW
   IzaP5ZZWc9+On/WB8hKFvzUqL6bExd0ZnvIVmsvfTrWdvpFRDB4QpqKPE
   Ffm7jQZt00rkdYPSNV6RZkpduRdC+2C7FmlUuaGV5XNfk2VJeD3QUZ3A+
   UcebRleuTWmdMsL9+MuWwG/XC+9Ofqk22chuj95p5zFZBFbw8RtmpzlSf
   elJ8R+Wf16f69tcDGZeczvQW8gRBzTN1qDx1WkGhgSy/m33I2mM45Levl
   QYTvzWXj5axkt/QtB6OUgdLIFxfeN/57tPSkG3BUdlklrkgUxce0c5zge
   g==;
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="218459590"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Jul 2023 00:08:24 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Sat, 1 Jul 2023 00:08:08 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.21 via Frontend Transport; Sat, 1 Jul 2023 00:08:05 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>
CC:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <kumaravel.thiagarajan@microchip.com>,
        <tharunkumar.pasumarthi@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <michael@walle.cc>,
        "Vaibhaav Ram T . L" <vaibhaavram.tl@microchip.com>
Subject: [PATCH RESEND v13 char-misc-next 1/2] misc: microchip: pci1xxxx: Add support to read and write into PCI1XXXX OTP via NVMEM sysfs
Date:   Sat, 1 Jul 2023 12:38:18 +0530
Message-ID: <20230701070819.3992094-2-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230701070819.3992094-1-kumaravel.thiagarajan@microchip.com>
References: <20230701070819.3992094-1-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer,
industrial, and automotive applications. This switch integrates OTP
and EEPROM to enable customization of the part in the field. This
patch adds support to read and write into PCI1XXXX OTP via NVMEM sysfs.

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Co-developed-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
Signed-off-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 MAINTAINERS                                   |   2 +
 drivers/misc/mchp_pci1xxxx/Kconfig            |   1 +
 drivers/misc/mchp_pci1xxxx/Makefile           |   2 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c | 303 ++++++++++++++++++
 4 files changed, 307 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 250518fc70ff..fd15229569a7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13812,12 +13812,14 @@ F:	drivers/nvmem/microchip-otpc.c
 F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
 
 MICROCHIP PCI1XXXX GP DRIVER
+M:	Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
 M:	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
 L:	linux-gpio@vger.kernel.org
 S:	Supported
 F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
 F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
 F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
 
 MICROCHIP PCI1XXXX I2C DRIVER
 M:	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
diff --git a/drivers/misc/mchp_pci1xxxx/Kconfig b/drivers/misc/mchp_pci1xxxx/Kconfig
index 4abb47de7219..64e457581fb4 100644
--- a/drivers/misc/mchp_pci1xxxx/Kconfig
+++ b/drivers/misc/mchp_pci1xxxx/Kconfig
@@ -2,6 +2,7 @@ config GP_PCI1XXXX
        tristate "Microchip PCI1XXXX PCIe to GPIO Expander + OTP/EEPROM manager"
        depends on PCI
        depends on GPIOLIB
+       depends on NVMEM_SYSFS
        select GPIOLIB_IRQCHIP
        select AUXILIARY_BUS
        help
diff --git a/drivers/misc/mchp_pci1xxxx/Makefile b/drivers/misc/mchp_pci1xxxx/Makefile
index fc4615cfe28b..ae31251dab37 100644
--- a/drivers/misc/mchp_pci1xxxx/Makefile
+++ b/drivers/misc/mchp_pci1xxxx/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_GP_PCI1XXXX) := mchp_pci1xxxx_gp.o mchp_pci1xxxx_gpio.o
+obj-$(CONFIG_GP_PCI1XXXX) := mchp_pci1xxxx_gp.o mchp_pci1xxxx_gpio.o mchp_pci1xxxx_otpe2p.o
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
new file mode 100644
index 000000000000..d3aa5664f0b0
--- /dev/null
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
@@ -0,0 +1,303 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022-2023 Microchip Technology Inc.
+// PCI1xxxx OTP/EEPROM driver
+
+#include <linux/auxiliary_bus.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/nvmem-provider.h>
+
+#include "mchp_pci1xxxx_gp.h"
+
+#define AUX_DRIVER_NAME			"PCI1xxxxOTPE2P"
+#define OTP_NAME			"pci1xxxx_otp"
+
+#define PERI_PF3_SYSTEM_REG_ADDR_BASE	0x2000
+#define PERI_PF3_SYSTEM_REG_LENGTH	0x4000
+
+#define OTP_SIZE_BYTES			8192
+
+#define CONFIG_REG_ADDR_BASE		0
+#define OTP_REG_ADDR_BASE		0x1000
+
+#define MMAP_OTP_OFFSET(x)		(OTP_REG_ADDR_BASE + (x))
+#define MMAP_CFG_OFFSET(x)		(CONFIG_REG_ADDR_BASE + (x))
+
+#define STATUS_READ_DELAY_US		1
+#define STATUS_READ_TIMEOUT_US		20000
+
+#define OTP_ADDR_HIGH_OFFSET		0x04
+#define OTP_ADDR_LOW_OFFSET		0x08
+#define OTP_PRGM_DATA_OFFSET		0x10
+#define OTP_PRGM_MODE_OFFSET		0x14
+#define OTP_RD_DATA_OFFSET		0x18
+#define OTP_FUNC_CMD_OFFSET		0x20
+#define OTP_CMD_GO_OFFSET		0x28
+#define OTP_PASS_FAIL_OFFSET		0x2C
+#define OTP_STATUS_OFFSET		0x30
+
+#define OTP_FUNC_RD_BIT			BIT(0)
+#define OTP_FUNC_PGM_BIT		BIT(1)
+#define OTP_CMD_GO_BIT			BIT(0)
+#define OTP_STATUS_BUSY_BIT		BIT(0)
+#define OTP_PGM_MODE_BYTE_BIT		BIT(0)
+#define OTP_FAIL_BIT			BIT(0)
+
+#define OTP_PWR_DN_BIT			BIT(0)
+#define OTP_PWR_DN_OFFSET		0x00
+
+#define CFG_SYS_LOCK_OFFSET		0xA0
+#define CFG_SYS_LOCK_PF3		BIT(5)
+
+#define BYTE_LOW			(GENMASK(7, 0))
+#define BYTE_HIGH			(GENMASK(12, 8))
+
+struct pci1xxxx_otp_eeprom_device {
+	struct auxiliary_device *pdev;
+	void __iomem *reg_base;
+	struct nvmem_config nvmem_config_otp;
+	struct nvmem_device *nvmem_otp;
+};
+
+static int set_sys_lock(struct pci1xxxx_otp_eeprom_device *priv)
+{
+	void __iomem *sys_lock = priv->reg_base +
+				 MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
+	u8 data;
+
+	writel(CFG_SYS_LOCK_PF3, sys_lock);
+	data = readl(sys_lock);
+	if (data != CFG_SYS_LOCK_PF3)
+		return -EPERM;
+
+	return 0;
+}
+
+static void release_sys_lock(struct pci1xxxx_otp_eeprom_device *priv)
+{
+	void __iomem *sys_lock = priv->reg_base +
+				 MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
+	writel(0, sys_lock);
+}
+
+static void otp_device_set_address(struct pci1xxxx_otp_eeprom_device *priv,
+				   u16 address)
+{
+	u16 lo, hi;
+
+	lo = address & BYTE_LOW;
+	hi = (address & BYTE_HIGH) >> 8;
+	writew(lo, priv->reg_base + MMAP_OTP_OFFSET(OTP_ADDR_LOW_OFFSET));
+	writew(hi, priv->reg_base + MMAP_OTP_OFFSET(OTP_ADDR_HIGH_OFFSET));
+}
+
+static int pci1xxxx_otp_read(void *priv_t, unsigned int off,
+			     void *buf_t, size_t count)
+{
+	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
+	void __iomem *rb = priv->reg_base;
+	char *buf = buf_t;
+	u32 regval;
+	u32 byte;
+	int ret;
+	u8 data;
+
+	if (off >= priv->nvmem_config_otp.size)
+		return -EFAULT;
+
+	if ((off + count) > priv->nvmem_config_otp.size)
+		count = priv->nvmem_config_otp.size - off;
+
+	ret = set_sys_lock(priv);
+	if (ret)
+		return ret;
+
+	for (byte = 0; byte < count; byte++) {
+		otp_device_set_address(priv, (u16)(off + byte));
+		data = readl(rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
+		writel(data | OTP_FUNC_RD_BIT,
+		       rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
+		data = readl(rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
+		writel(data | OTP_CMD_GO_BIT,
+		       rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
+
+		ret = read_poll_timeout(readl, regval,
+					!(regval & OTP_STATUS_BUSY_BIT),
+					STATUS_READ_DELAY_US,
+					STATUS_READ_TIMEOUT_US, true,
+					rb + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
+
+		data = readl(rb + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
+		if (ret < 0 || data & OTP_FAIL_BIT) {
+			ret = -EIO;
+			goto error;
+		}
+
+		buf[byte] = readl(rb + MMAP_OTP_OFFSET(OTP_RD_DATA_OFFSET));
+	}
+	ret = byte;
+error:
+	release_sys_lock(priv);
+	return ret;
+}
+
+static int pci1xxxx_otp_write(void *priv_t, unsigned int off,
+			      void *value_t, size_t count)
+{
+	struct pci1xxxx_otp_eeprom_device *priv = priv_t;
+	void __iomem *rb = priv->reg_base;
+	char *value = value_t;
+	u32 regval;
+	u32 byte;
+	int ret;
+	u8 data;
+
+	if (off >= priv->nvmem_config_otp.size)
+		return -EFAULT;
+
+	if ((off + count) > priv->nvmem_config_otp.size)
+		count = priv->nvmem_config_otp.size - off;
+
+	ret = set_sys_lock(priv);
+	if (ret)
+		return ret;
+
+	for (byte = 0; byte < count; byte++) {
+		otp_device_set_address(priv, (u16)(off + byte));
+
+		/*
+		 * Set OTP_PGM_MODE_BYTE command bit in OTP_PRGM_MODE register
+		 * to enable Byte programming
+		 */
+		data = readl(rb + MMAP_OTP_OFFSET(OTP_PRGM_MODE_OFFSET));
+		writel(data | OTP_PGM_MODE_BYTE_BIT,
+		       rb + MMAP_OTP_OFFSET(OTP_PRGM_MODE_OFFSET));
+		writel(*(value + byte), rb + MMAP_OTP_OFFSET(OTP_PRGM_DATA_OFFSET));
+		data = readl(rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
+		writel(data | OTP_FUNC_PGM_BIT,
+		       rb + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
+		data = readl(rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
+		writel(data | OTP_CMD_GO_BIT,
+		       rb + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
+
+		ret = read_poll_timeout(readl, regval,
+					!(regval & OTP_STATUS_BUSY_BIT),
+					STATUS_READ_DELAY_US,
+					STATUS_READ_TIMEOUT_US, true,
+					rb + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
+
+		data = readl(rb + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
+		if (ret < 0 || data & OTP_FAIL_BIT) {
+			ret = -EIO;
+			goto error;
+		}
+	}
+	ret = byte;
+error:
+	release_sys_lock(priv);
+	return ret;
+}
+
+static int pci1xxxx_otp_eeprom_probe(struct auxiliary_device *aux_dev,
+				     const struct auxiliary_device_id *id)
+{
+	struct auxiliary_device_wrapper *aux_dev_wrapper;
+	struct pci1xxxx_otp_eeprom_device *priv;
+	struct gp_aux_data_type *pdata;
+	int ret;
+	u8 data;
+
+	aux_dev_wrapper = container_of(aux_dev, struct auxiliary_device_wrapper,
+				       aux_dev);
+	pdata = &aux_dev_wrapper->gp_aux_data;
+	if (!pdata)
+		return -EINVAL;
+
+	priv = devm_kzalloc(&aux_dev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = aux_dev;
+
+	if (!devm_request_mem_region(&aux_dev->dev, pdata->region_start +
+				     PERI_PF3_SYSTEM_REG_ADDR_BASE,
+				     PERI_PF3_SYSTEM_REG_LENGTH,
+				     aux_dev->name))
+		return -ENOMEM;
+
+	priv->reg_base = devm_ioremap(&aux_dev->dev, pdata->region_start +
+				      PERI_PF3_SYSTEM_REG_ADDR_BASE,
+				      PERI_PF3_SYSTEM_REG_LENGTH);
+	if (!priv->reg_base)
+		return -ENOMEM;
+
+	ret = set_sys_lock(priv);
+	if (ret)
+		return ret;
+
+	/* Set OTP_PWR_DN to 0 to make OTP Operational */
+	data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
+	writel(data & ~OTP_PWR_DN_BIT,
+	       priv->reg_base + MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
+
+	dev_set_drvdata(&aux_dev->dev, priv);
+
+	release_sys_lock(priv);
+
+	priv->nvmem_config_otp.type = NVMEM_TYPE_OTP;
+	priv->nvmem_config_otp.name = OTP_NAME;
+	priv->nvmem_config_otp.dev = &aux_dev->dev;
+	priv->nvmem_config_otp.owner = THIS_MODULE;
+	priv->nvmem_config_otp.reg_read = pci1xxxx_otp_read;
+	priv->nvmem_config_otp.reg_write = pci1xxxx_otp_write;
+	priv->nvmem_config_otp.priv = priv;
+	priv->nvmem_config_otp.stride = 1;
+	priv->nvmem_config_otp.word_size = 1;
+	priv->nvmem_config_otp.size = OTP_SIZE_BYTES;
+
+	priv->nvmem_otp = devm_nvmem_register(&aux_dev->dev,
+					      &priv->nvmem_config_otp);
+	if (!priv->nvmem_otp)
+		return -ENOMEM;
+
+	return ret;
+}
+
+static void pci1xxxx_otp_eeprom_remove(struct auxiliary_device *aux_dev)
+{
+	struct pci1xxxx_otp_eeprom_device *priv;
+	void __iomem *sys_lock;
+
+	priv = dev_get_drvdata(&aux_dev->dev);
+	sys_lock = priv->reg_base + MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
+	writel(CFG_SYS_LOCK_PF3, sys_lock);
+
+	/* Shut down OTP */
+	writel(OTP_PWR_DN_BIT,
+	       priv->reg_base + MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
+
+	writel(0, sys_lock);
+}
+
+static const struct auxiliary_device_id pci1xxxx_otp_eeprom_auxiliary_id_table[] = {
+	{.name = "mchp_pci1xxxx_gp.gp_otp_e2p"},
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pci1xxxx_otp_eeprom_auxiliary_id_table);
+
+static struct auxiliary_driver pci1xxxx_otp_eeprom_driver = {
+	.driver = {
+		.name = AUX_DRIVER_NAME,
+	},
+	.probe = pci1xxxx_otp_eeprom_probe,
+	.remove = pci1xxxx_otp_eeprom_remove,
+	.id_table = pci1xxxx_otp_eeprom_auxiliary_id_table
+};
+module_auxiliary_driver(pci1xxxx_otp_eeprom_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>");
+MODULE_AUTHOR("Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>");
+MODULE_AUTHOR("Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>");
+MODULE_DESCRIPTION("Microchip Technology Inc. PCI1xxxx OTP EEPROM Programmer");
-- 
2.34.1

