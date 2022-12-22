Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2276653488
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 18:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiLURGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 12:06:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234636AbiLURF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 12:05:57 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6341CE6;
        Wed, 21 Dec 2022 09:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1671642355; x=1703178355;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DGYrM3N4wZb2eAZ7fb5UiyWAukbJreMHapEROGFMvu8=;
  b=Mvrs9Ji5mUipApD4HmkiM+IcyLxLdI/J2jrh8qSnvD87ExakgEKAScho
   Xm9t4gRsAqRHxr6EqpBhNVB1VL9Kto0E8NYg8bN22pj3GYMeaw8OdSxVN
   IoJJi55Hlvkc6zvDsgJShn681115U//ciqy3OjIeCTGTW4tUPx6KrzOId
   RZ76v1/4e27+MQxZRHjTjeynLS664FR0kqm8cZss+M0m19m2jMx4KvQCI
   KQWA02dpN88Jy/yiQIcOxOcspplhgn63TmvqryWf5rW5sA250SLjDKAB0
   abuOJjv0uHBGqec8LKUW7913isvYEunj/tj3Nt+0YCC927VElW+ySSFkd
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,263,1665471600"; 
   d="scan'208";a="129224605"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Dec 2022 10:05:54 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Wed, 21 Dec 2022 10:05:52 -0700
Received: from CHE-LT-UNGSOFTWARE.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Wed, 21 Dec 2022 10:05:50 -0700
From:   Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
To:     <arnd@arndb.de>
CC:     <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <unglinuxdriver@microchip.com>,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: [PATCH char-misc-next] misc: microchip: pci1xxxx: Add OTP/EEPROM driver for the pci1xxxx switch
Date:   Thu, 22 Dec 2022 11:10:48 +0530
Message-ID: <20221222054048.3080265-1-kumaravel.thiagarajan@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for consumer, industrial,
and automotive applications. This switch integrates OTP and EEPROM to enable
customization of the part in the field. This patch provides the OTP/EEPROM
driver to support the same.

Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
---
 MAINTAINERS                                   |   1 +
 drivers/misc/mchp_pci1xxxx/Makefile           |   2 +-
 .../misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c | 693 ++++++++++++++++++
 3 files changed, 695 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9886aa1a4403..195af3ac451d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13614,6 +13614,7 @@ S:	Supported
 F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
 F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.h
 F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gpio.c
+F:	drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
 
 MICROCHIP OTPC DRIVER
 M:	Claudiu Beznea <claudiu.beznea@microchip.com>
diff --git a/drivers/misc/mchp_pci1xxxx/Makefile b/drivers/misc/mchp_pci1xxxx/Makefile
index fc4615cfe28b..ae31251dab37 100644
--- a/drivers/misc/mchp_pci1xxxx/Makefile
+++ b/drivers/misc/mchp_pci1xxxx/Makefile
@@ -1 +1 @@
-obj-$(CONFIG_GP_PCI1XXXX) := mchp_pci1xxxx_gp.o mchp_pci1xxxx_gpio.o
+obj-$(CONFIG_GP_PCI1XXXX) := mchp_pci1xxxx_gp.o mchp_pci1xxxx_gpio.o mchp_pci1xxxx_otpe2p.o
diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
new file mode 100644
index 000000000000..03a537d45873
--- /dev/null
+++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_otpe2p.c
@@ -0,0 +1,693 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2022 Microchip Technology Inc.
+// PCI1xxxx OTP/EEPROM driver
+
+#include <linux/auxiliary_bus.h>
+#include <linux/bio.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/delay.h>
+#include <linux/gpio/driver.h>
+#include <linux/kthread.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
+
+#include "mchp_pci1xxxx_gp.h"
+
+#define PERI_PF3_SYSTEM_REG_ADDR_BASE	(0x2000)
+#define PERI_PF3_SYSTEM_REG_LENGTH	(0x4000)
+
+#define CONFIG_REG_ADDR_BASE		(0)
+#define EEPROM_REG_ADDR_BASE		(0x0E00)
+#define OTP_REG_ADDR_BASE		(0x1000)
+
+#define MMAP_CFG_OFFSET(x)		(CONFIG_REG_ADDR_BASE + (x))
+
+#define CFG_SYS_LOCK_OFFSET		(0xA0)
+#define CFG_SYS_LOCK_PF3		BIT(5)
+
+#define MMAP_OTP_OFFSET(x)		(OTP_REG_ADDR_BASE + (x))
+
+#define OTP_PWR_DN_OFFSET		(0x00)
+#define OTP_ADDR_HIGH_OFFSET		(0x04)
+#define OTP_ADDR_LOW_OFFSET		(0x08)
+#define	OTP_ADDR_BITS_OFFSET		(0x0C)
+#define OTP_PRGM_DATA_OFFSET		(0x10)
+#define OTP_PRGM_MODE_OFFSET		(0x14)
+#define OTP_RD_DATA_OFFSET		(0x18)
+#define OTP_FUNC_CMD_OFFSET		(0x20)
+#define OTP_TEST_CMD_OFFSET		(0x24)
+#define OTP_CMD_GO_OFFSET		(0x28)
+#define OTP_PASS_FAIL_OFFSET		(0x2C)
+#define OTP_STATUS_OFFSET		(0x30)
+#define OTP_MAX_PRG_OFFSET		(0x34)
+#define OTP_RSTB_PW_OFFSET		(0x50)
+#define OTP_PGM_PW_OFFSET		(0x60)
+#define OTP_READ_PW_OFFSET		(0x70)
+
+#define OTP_PWR_DN_BIT			BIT(0)
+#define OTP_CMD_GO_BIT			BIT(0)
+#define OTP_PGM_MODE_BYTE_BIT		BIT(0)
+#define OTP_STATUS_BUSY_BIT		BIT(0)
+#define OTP_FUNC_PGM_BIT		BIT(1)
+#define OTP_FUNC_RD_BIT			BIT(0)
+
+#define OTP_RW_TIMEOUT_MILLISECONDS	(5)
+
+#define MMAP_EEPROM_OFFSET(x)		(EEPROM_REG_ADDR_BASE + (x))
+
+#define E2P_CMD_REG			(0x00)
+#define E2P_DATA_REG			(0x04)
+#define E2P_CFG_REG			(0x08)
+#define E2P_PAD_CTL_REG			(0x0C)
+
+#define E2P_CMD_EPC_BUSY_BIT		BIT(31)
+#define E2P_CMD_EPC_TIMEOUT_BIT		BIT(17)
+#define E2P_CMD_EPC_WRITE		(BIT(29) | BIT(28))
+
+#define E2P_CFG_BAUD_RATE_100KHZ	BIT(9)
+#define E2P_CFG_SIZE_SEL		BIT(12)
+#define E2P_CFG_PULSE_WIDTH_100KHZ	(BIT(17) | BIT(16))
+#define OTP_E2P_SECTOR_SIZE		(512)
+#define OTP_SIZE_IN_BYTES		(8 * 1024)
+#define E2P_SIZE_IN_BYTES		(8 * 1024)
+
+struct pci1xxxx_otp_e2p_device {
+	struct pci1xxxx_otp_e2p_disk *otp_e2p_device;
+	struct auxiliary_device *pdev;
+	void __iomem *reg_base;
+	int block_device_count;
+};
+
+struct pci1xxxx_otp_e2p_disk {
+	struct blk_mq_tag_set tag_set;
+	struct auxiliary_device *pdev;
+	struct request_queue *queue;
+	struct mutex  lock;
+	struct gendisk *gd;
+	bool E2P;
+	int (*disk_write_byte)(struct pci1xxxx_otp_e2p_device *priv,
+		unsigned long byte_offset, u8 value);
+	int (*disk_read_byte)(struct pci1xxxx_otp_e2p_device *priv,
+		unsigned long byte_offset, u8 *data);
+};
+
+static int OTP_sector_count = OTP_SIZE_IN_BYTES / OTP_E2P_SECTOR_SIZE;
+static int E2P_sector_count = E2P_SIZE_IN_BYTES / OTP_E2P_SECTOR_SIZE;
+static int otp_device_count, e2p_device_count;
+static int block_driver_registered;
+static int OTP_block_driver_major;
+
+static void otp_device_set_address(struct pci1xxxx_otp_e2p_device *priv, u16 address)
+{
+	u32 lo, hi;
+
+	lo = address & 0xFF;
+	hi = (address & 0x1f00) >> 8;
+	writel(lo, priv->reg_base + MMAP_OTP_OFFSET(OTP_ADDR_LOW_OFFSET));
+	writel(hi, priv->reg_base + MMAP_OTP_OFFSET(OTP_ADDR_HIGH_OFFSET));
+}
+
+static int set_sys_lock(struct pci1xxxx_otp_e2p_device *priv)
+{
+	void __iomem *p = priv->reg_base + MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
+	u8 data;
+
+	writel(CFG_SYS_LOCK_PF3, p);
+	data = readl(p);
+	if (data != CFG_SYS_LOCK_PF3)
+		return -EPERM;
+
+	return 0;
+}
+
+static int release_sys_lock(struct pci1xxxx_otp_e2p_device *priv)
+{
+	void __iomem *p = priv->reg_base + MMAP_CFG_OFFSET(CFG_SYS_LOCK_OFFSET);
+	u8 data;
+
+	data = readl(p);
+	if (data != CFG_SYS_LOCK_PF3)
+		return 0;
+
+	writel(0, p);
+
+	data = readl(p);
+	if (data & CFG_SYS_LOCK_PF3)
+		return -EPERM;
+
+	return 0;
+}
+
+static int otp_e2p_device_open(struct block_device *bdev, fmode_t mode)
+{
+	struct pci1xxxx_otp_e2p_disk *disk_priv;
+	struct pci1xxxx_otp_e2p_device *priv;
+	struct auxiliary_device *pdev;
+	int retval = 0;
+	u8 data;
+
+	disk_priv = (struct pci1xxxx_otp_e2p_disk *)bdev->bd_disk->private_data;
+	pdev = (struct auxiliary_device *)disk_priv->pdev;
+	priv = dev_get_drvdata(&pdev->dev);
+
+	mutex_lock(&disk_priv->lock);
+
+	do {
+		retval = set_sys_lock(priv);
+		if (retval)
+			break;
+
+		if (!disk_priv->E2P) {
+			data = readl(priv->reg_base +
+				     MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
+			writel((data & ~OTP_PWR_DN_BIT), priv->reg_base +
+				MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
+		}
+	} while (false);
+
+	mutex_unlock(&disk_priv->lock);
+
+	return retval;
+}
+
+static void otp_e2p_device_release(struct gendisk *disk, fmode_t mode)
+{
+	struct pci1xxxx_otp_e2p_disk *disk_priv;
+	struct pci1xxxx_otp_e2p_device *priv;
+	u8 data;
+
+	disk_priv = (struct pci1xxxx_otp_e2p_disk *)disk->private_data;
+	priv = dev_get_drvdata(&disk_priv->pdev->dev);
+
+	mutex_lock(&disk_priv->lock);
+
+	if (!disk_priv->E2P) {
+		data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
+		writel((data | OTP_PWR_DN_BIT), priv->reg_base +
+			MMAP_OTP_OFFSET(OTP_PWR_DN_OFFSET));
+	}
+	release_sys_lock(priv);
+
+	mutex_unlock(&disk_priv->lock);
+}
+
+static int e2p_device_write_byte(struct pci1xxxx_otp_e2p_device *priv,
+				 unsigned long byte_offset, u8 value)
+{
+	u32 data;
+
+	/* Write the value into E2P_DATA_REG register */
+	writel(value, priv->reg_base + MMAP_EEPROM_OFFSET(E2P_DATA_REG));
+	data = E2P_CMD_EPC_TIMEOUT_BIT | E2P_CMD_EPC_WRITE | byte_offset;
+
+	/* Write the data into E2P_CMD_REG register */
+	writel(data, priv->reg_base + MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+
+	/* Set the EPC_BUSY bit of E2P_CMD_REG register */
+	writel(E2P_CMD_EPC_BUSY_BIT | data, priv->reg_base +
+	       MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+
+	/* Wait for the EPC_BUSY bit to get cleared */
+	do {
+		data = readl(priv->reg_base + MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+	} while (data & E2P_CMD_EPC_BUSY_BIT);
+
+	if (data & E2P_CMD_EPC_TIMEOUT_BIT) {
+		dev_err(&priv->pdev->dev, "%s timed out\n", __func__);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+static int e2p_device_read_byte(struct pci1xxxx_otp_e2p_device *priv,
+				unsigned long byte_offset, u8 *data)
+{
+	u32 regval;
+
+	/*
+	 * Write the byte offset into the EPC_ADDRESS field of E2P_CMD_REG
+	 * register
+	 */
+	writel(byte_offset, priv->reg_base + MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+
+	/* Set the EPC_BUSY bit of E2P_CMD_REG register */
+	writel(E2P_CMD_EPC_BUSY_BIT | byte_offset, priv->reg_base +
+	       MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+
+	/* Wait for the EPC_BUSY bit to get cleared */
+	do {
+		regval = readl(priv->reg_base + MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+	} while (regval & E2P_CMD_EPC_BUSY_BIT);
+
+	if (regval & E2P_CMD_EPC_TIMEOUT_BIT) {
+		dev_err(&priv->pdev->dev, "%s timed out\n", __func__);
+		return -EFAULT;
+	}
+
+	/* Read the contents from the E2P_DATA_REG */
+	*data = readl(priv->reg_base + MMAP_EEPROM_OFFSET(E2P_DATA_REG));
+	return 0;
+}
+
+static bool check_e2p_response(struct pci1xxxx_otp_e2p_device *priv)
+{
+	u32 data;
+
+	if (set_sys_lock(priv))
+		return false;
+
+	writel((E2P_CFG_PULSE_WIDTH_100KHZ | E2P_CFG_SIZE_SEL |
+		E2P_CFG_BAUD_RATE_100KHZ), priv->reg_base +
+		MMAP_EEPROM_OFFSET(E2P_CFG_REG));
+
+	/*
+	 * Write the byte offset into the EPC_ADDRESS field of E2P_CMD_REG
+	 * register
+	 */
+	writel(E2P_CMD_EPC_TIMEOUT_BIT, priv->reg_base +
+	       MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+
+	/* Set the EPC_BUSY bit of E2P_CMD_REG register */
+	writel(E2P_CMD_EPC_BUSY_BIT, priv->reg_base +
+	       MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+
+	/* Wait for the EPC_BUSY bit to get cleared or timeout bit to get set*/
+	do {
+		data = readl(priv->reg_base + MMAP_EEPROM_OFFSET(E2P_CMD_REG));
+	} while (data & E2P_CMD_EPC_BUSY_BIT);
+
+	/* If EPC_TIMEOUT is set, then the EEPROM is not responsive */
+	release_sys_lock(priv);
+
+	if (data & E2P_CMD_EPC_TIMEOUT_BIT) {
+		dev_err(&priv->pdev->dev,
+			"EPC_Timeout, EEPROM is unresponsive: %x\n", data);
+		return false;
+	}
+
+	return true;
+}
+
+static int otp_device_write_byte(struct pci1xxxx_otp_e2p_device *priv,
+				 unsigned long byte_offset, u8 value)
+{
+	unsigned long j0, j1, delay;
+	u8 data;
+
+	if (!value)
+		return 0;
+
+	otp_device_set_address(priv, (u16)byte_offset);
+
+	/* Set OTP_PGM_MODE_BYTE command bit in OTP_PRGM_MODE register */
+	data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_PRGM_MODE_OFFSET));
+	writel((data | OTP_PGM_MODE_BYTE_BIT), priv->reg_base +
+		MMAP_OTP_OFFSET(OTP_PRGM_MODE_OFFSET));
+
+	/* Write the value to program into OTP_PRGM_DATA register */
+	writel(value, priv->reg_base + MMAP_OTP_OFFSET(OTP_PRGM_DATA_OFFSET));
+
+	/* Set OTP_PROGRAM command bit in OTP_FUNC_CMD register */
+	data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
+	writel((data | OTP_FUNC_PGM_BIT), priv->reg_base +
+		MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
+
+	/* Set OTP_GO command bit in OTP_CMD_GO register */
+	data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
+	writel((data | OTP_CMD_GO_BIT), priv->reg_base +
+		MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
+	delay = msecs_to_jiffies(OTP_RW_TIMEOUT_MILLISECONDS);
+	j0 = jiffies;
+	j1 = j0 + delay;
+
+	/* Wait for the OTP_BUSY bit to get cleared in OTP_STATUS register */
+	do {
+		data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
+	} while ((data & OTP_STATUS_BUSY_BIT) && (time_before(jiffies, j1)));
+
+	if (data & OTP_STATUS_BUSY_BIT) {
+		dev_err(&priv->pdev->dev, "%s timed out\n", __func__);
+		return -EFAULT;
+	}
+
+	/* Read the result from OTP_RD_DATA register */
+	data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_PASS_FAIL_OFFSET));
+	if (data & 0x02)
+		return 0;
+
+	dev_err(&priv->pdev->dev, "%s write read mismatch 0x%x\n", __func__, data);
+	return -EFAULT;
+}
+
+static int otp_device_read_byte(struct pci1xxxx_otp_e2p_device *priv,
+				unsigned long byte_offset, u8 *data)
+{
+	unsigned long j0, j1, delay;
+
+	otp_device_set_address(priv, (u16)byte_offset);
+
+	/* Set OTP_READ command bit in OTP_FUNC_CMD register */
+	*data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
+	writel((*data | OTP_FUNC_RD_BIT), priv->reg_base +
+		MMAP_OTP_OFFSET(OTP_FUNC_CMD_OFFSET));
+
+	/* Set OTP_GO command bit in OTP_CMD_GO register */
+	*data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
+	writel((*data | OTP_CMD_GO_BIT), priv->reg_base +
+		MMAP_OTP_OFFSET(OTP_CMD_GO_OFFSET));
+	delay = msecs_to_jiffies(OTP_RW_TIMEOUT_MILLISECONDS);
+	j0 = jiffies;
+	j1 = j0 + delay;
+
+	/* Wait for OTP_BUSY bit to get cleared in OTP_STATUS */
+	do {
+		*data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_STATUS_OFFSET));
+	} while ((*data & OTP_STATUS_BUSY_BIT) && (time_before(jiffies, j1)));
+
+	if (*data & OTP_STATUS_BUSY_BIT) {
+		dev_err(&priv->pdev->dev, "%s timed out\n", __func__);
+		return -EFAULT;
+	}
+
+	/* Read the result from OTP_RD_DATA register */
+	*data = readl(priv->reg_base + MMAP_OTP_OFFSET(OTP_RD_DATA_OFFSET));
+	return 0;
+}
+
+static int otp_e2P_device_transfer(struct request *req)
+{
+	struct pci1xxxx_otp_e2p_disk *disk_priv;
+	struct pci1xxxx_otp_e2p_device *priv;
+	unsigned long sector;
+	unsigned long nsect;
+	long byte_offset;
+	int retval;
+	u8 *buffer;
+	int write;
+	int i, j;
+
+	sector = blk_rq_pos(req);
+	nsect = blk_rq_cur_sectors(req);
+	buffer = bio_data(req->bio);
+	write = rq_data_dir(req);
+	disk_priv = (struct pci1xxxx_otp_e2p_disk *)req->q->disk->private_data;
+	priv = dev_get_drvdata(&disk_priv->pdev->dev);
+
+	if (write) {
+		for (i = 0; i < nsect; i++) {
+			byte_offset = (sector + i) * OTP_E2P_SECTOR_SIZE;
+			for (j = 0; j < OTP_E2P_SECTOR_SIZE; j++) {
+				retval = disk_priv->disk_write_byte(priv,
+								    byte_offset + j,
+								    *buffer);
+				if (retval)
+					return retval;
+
+				buffer++;
+			}
+		}
+	} else {
+		for (i = 0; i < nsect; i++) {
+			byte_offset = (sector + i) * OTP_E2P_SECTOR_SIZE;
+			for (j = 0; j < OTP_E2P_SECTOR_SIZE; j++) {
+				retval = disk_priv->disk_read_byte(priv,
+								   byte_offset + j,
+								   buffer);
+				if (retval)
+					return retval;
+
+				buffer++;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static blk_status_t OTPE2P_queue_rq(struct blk_mq_hw_ctx *hctx,
+				    const struct blk_mq_queue_data *bd)
+{
+	struct request *req = bd->rq;
+
+	blk_mq_start_request(req);
+	if (!otp_e2P_device_transfer(req)) {
+		blk_mq_end_request(req, BLK_STS_OK);
+		return BLK_STS_OK;
+	}
+
+	return BLK_STS_IOERR;
+}
+
+static const struct blk_mq_ops OTPE2P_mq_ops = {
+	.queue_rq	= OTPE2P_queue_rq,
+};
+
+static const struct block_device_operations otp_e2p_device_ops = {
+	.owner = THIS_MODULE,
+	.open = otp_e2p_device_open,
+	.release = otp_e2p_device_release,
+};
+
+static int otp_e2p_device_create_block_device(struct auxiliary_device *aux_dev)
+{
+	struct auxiliary_device_wrapper *aux_dev_wrapper;
+	struct pci1xxxx_otp_e2p_device *priv;
+	struct gp_aux_data_type *pdata;
+	int retval = 0, i;
+
+	aux_dev_wrapper = (struct auxiliary_device_wrapper *) container_of(aux_dev,
+			  struct auxiliary_device_wrapper, aux_dev);
+	pdata = &(aux_dev_wrapper->gp_aux_data);
+	if (!pdata) {
+		dev_err(&aux_dev->dev, "Invalid data in aux_dev_wrapper->gp_aux_data\n");
+		return -EINVAL;
+	}
+
+	priv = devm_kzalloc(&aux_dev->dev, sizeof(struct pci1xxxx_otp_e2p_device),
+			    GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->pdev = aux_dev;
+
+	dev_set_drvdata(&aux_dev->dev, priv);
+
+	if (!devm_request_mem_region(&aux_dev->dev, pdata->region_start +
+				     PERI_PF3_SYSTEM_REG_ADDR_BASE,
+		PERI_PF3_SYSTEM_REG_LENGTH, aux_dev->name)) {
+		dev_err(&aux_dev->dev, "can't request otpe2p region\n");
+		return -ENOMEM;
+	}
+
+	priv->reg_base = devm_ioremap(&aux_dev->dev, pdata->region_start +
+				      PERI_PF3_SYSTEM_REG_ADDR_BASE,
+				      PERI_PF3_SYSTEM_REG_LENGTH);
+	if (!priv->reg_base) {
+		dev_err(&aux_dev->dev, "ioremap failed\n");
+		return -ENOMEM;
+	}
+
+	priv->block_device_count = 0;
+	do {
+		if (check_e2p_response(priv))
+			priv->block_device_count = 2;
+		else
+			priv->block_device_count = 1;
+
+		priv->otp_e2p_device = devm_kzalloc(&priv->pdev->dev,
+						    priv->block_device_count *
+						    sizeof(struct pci1xxxx_otp_e2p_disk),
+						    GFP_KERNEL);
+		if (!priv->otp_e2p_device) {
+			retval = -ENOMEM;
+			break;
+		}
+
+		for (i = 0; i < priv->block_device_count; i++) {
+			mutex_init(&priv->otp_e2p_device[i].lock);
+			priv->otp_e2p_device[i].tag_set.ops = &OTPE2P_mq_ops;
+			priv->otp_e2p_device[i].tag_set.nr_hw_queues = 1;
+			priv->otp_e2p_device[i].tag_set.queue_depth = 16;
+			priv->otp_e2p_device[i].tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+
+			retval = blk_mq_alloc_tag_set(&priv->otp_e2p_device[i].tag_set);
+			if (retval) {
+				dev_err(&aux_dev->dev, "blk_mq_alloc_tag_set failed\n");
+				break;
+			}
+
+			priv->otp_e2p_device[i].queue =
+				blk_mq_init_queue(&priv->otp_e2p_device[i].tag_set);
+			if (IS_ERR(priv->otp_e2p_device[i].queue)) {
+				retval = PTR_ERR(priv->otp_e2p_device[i].queue);
+				priv->otp_e2p_device[i].queue = NULL;
+				if (i)
+					goto e2p_free_tag_set;
+				else
+					goto otp_free_tag_set;
+			}
+
+			blk_queue_logical_block_size(priv->otp_e2p_device[i].queue,
+						     OTP_E2P_SECTOR_SIZE);
+			blk_queue_physical_block_size(priv->otp_e2p_device[i].queue,
+						      OTP_E2P_SECTOR_SIZE);
+			priv->otp_e2p_device[i].queue->queuedata = priv;
+			priv->otp_e2p_device[i].gd =
+				blk_mq_alloc_disk(&priv->otp_e2p_device[i].tag_set,
+				NULL);
+			if (IS_ERR(priv->otp_e2p_device[i].gd)) {
+				retval = PTR_ERR(priv->otp_e2p_device[i].gd);
+				if (i)
+					goto e2p_destroy_queue;
+				else
+					goto otp_destroy_queue;
+			}
+
+			priv->otp_e2p_device[i].pdev = aux_dev;
+			priv->otp_e2p_device[i].gd->major = OTP_block_driver_major;
+			priv->otp_e2p_device[i].gd->minors = 1;
+			priv->otp_e2p_device[i].gd->first_minor =
+				otp_device_count + e2p_device_count;
+			priv->otp_e2p_device[i].gd->fops = &otp_e2p_device_ops;
+			priv->otp_e2p_device[i].gd->private_data =
+				&priv->otp_e2p_device[i];
+
+			if (i == 0) {
+				snprintf(priv->otp_e2p_device[i].gd->disk_name,
+					 32, "PCI1xxxxOTP%x", otp_device_count);
+				set_capacity(priv->otp_e2p_device[i].gd,
+					     OTP_sector_count);
+				priv->otp_e2p_device[i].disk_read_byte = otp_device_read_byte;
+				priv->otp_e2p_device[i].disk_write_byte = otp_device_write_byte;
+				otp_device_count++;
+			} else {
+				snprintf(priv->otp_e2p_device[i].gd->disk_name,
+					 32, "PCI1xxxxE2P%x", otp_device_count - 1);
+				set_capacity(priv->otp_e2p_device[i].gd,
+					     E2P_sector_count);
+				priv->otp_e2p_device[i].E2P = true;
+				priv->otp_e2p_device[i].disk_read_byte = e2p_device_read_byte;
+				priv->otp_e2p_device[i].disk_write_byte = e2p_device_write_byte;
+				e2p_device_count++;
+			}
+
+			retval = add_disk(priv->otp_e2p_device[i].gd);
+			if (retval) {
+				if (i)
+					goto e2p_free_disk;
+				else
+					goto otp_free_disk;
+			}
+		}
+
+	} while (false);
+
+	return retval;
+
+e2p_free_disk:
+	del_gendisk(priv->otp_e2p_device[1].gd);
+	put_disk(priv->otp_e2p_device[1].gd);
+e2p_destroy_queue:
+	blk_mq_destroy_queue(priv->otp_e2p_device[1].queue);
+e2p_free_tag_set:
+	blk_mq_free_tag_set(&priv->otp_e2p_device[1].tag_set);
+otp_free_disk:
+	del_gendisk(priv->otp_e2p_device[0].gd);
+	put_disk(priv->otp_e2p_device[0].gd);
+otp_destroy_queue:
+	blk_mq_destroy_queue(priv->otp_e2p_device[0].queue);
+otp_free_tag_set:
+	blk_mq_free_tag_set(&priv->otp_e2p_device[0].tag_set);
+
+	return retval;
+}
+
+static void pci1xxxx_otp_e2p_remove(struct auxiliary_device *aux_dev)
+{
+	struct pci1xxxx_otp_e2p_device *priv = dev_get_drvdata(&aux_dev->dev);
+	int i;
+
+	for (i = 0; i < priv->block_device_count; i++) {
+
+		if (priv->otp_e2p_device[i].queue)
+			blk_mq_destroy_queue(priv->otp_e2p_device[i].queue);
+
+		if (priv->otp_e2p_device[i].gd) {
+			del_gendisk(priv->otp_e2p_device[i].gd);
+			put_disk(priv->otp_e2p_device[i].gd);
+			blk_mq_free_tag_set(&priv->otp_e2p_device[i].tag_set);
+		}
+	}
+}
+
+static int pci1xxxx_otp_e2p_probe(struct auxiliary_device *aux_dev,
+				  const struct auxiliary_device_id *id)
+{
+	int retval;
+
+	retval = otp_e2p_device_create_block_device(aux_dev);
+	if (retval) {
+		dev_err(&aux_dev->dev,
+			"otp/eeprom device enumeration failed with errno = %d\n",
+			retval);
+		return retval;
+	}
+
+	return 0;
+}
+
+static const struct auxiliary_device_id pci1xxxx_otp_e2p_auxiliary_id_table[] = {
+	{.name = "mchp_pci1xxxx_gp.gp_otp_e2p"},
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, pci1xxxx_otp_e2p_auxiliary_id_table);
+
+static struct auxiliary_driver pci1xxxx_otp_e2p_driver = {
+	.driver = {
+		.name = "PCI1xxxxOTPE2P",
+	},
+	.probe = pci1xxxx_otp_e2p_probe,
+	.remove = pci1xxxx_otp_e2p_remove,
+	.id_table = pci1xxxx_otp_e2p_auxiliary_id_table
+};
+
+static int __init pci1xxxx_otp_e2p_driver_init(void)
+{
+	int retval;
+
+	do {
+		OTP_block_driver_major = register_blkdev(OTP_block_driver_major,
+			"OTPBlockDevice");
+		if (OTP_block_driver_major < 0) {
+			retval = OTP_block_driver_major;
+			break;
+		}
+
+		block_driver_registered = 1;
+
+		retval = auxiliary_driver_register(&pci1xxxx_otp_e2p_driver);
+		if (retval)
+			break;
+
+	} while (false);
+
+	return retval;
+}
+
+static void __exit pci1xxxx_otp_e2p_driver_exit(void)
+{
+	auxiliary_driver_unregister(&pci1xxxx_otp_e2p_driver);
+	if (block_driver_registered)
+		unregister_blkdev(OTP_block_driver_major, "OTPBlockDevice");
+}
+
+module_init(pci1xxxx_otp_e2p_driver_init);
+module_exit(pci1xxxx_otp_e2p_driver_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>");
+MODULE_AUTHOR("Tharun Kumar P<tharunkumar.pasumarthi@microchip.com>");
+MODULE_DESCRIPTION("Microchip Technology Inc. PCI1xxxx OTP EEPROM programmer");
-- 
2.25.1

