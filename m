Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C43673029
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjASE1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:27:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjASD4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:56:40 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on20628.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::628])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03DF367E1;
        Wed, 18 Jan 2023 19:53:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gRHeoGWkRuoeJVuKt+cOCF8LBXvVcGvSkVCMquqRU51w3KOzHDuke0SOaGcRFDvTYiydIcwAzE+zmsNxR3IzqOil5ptb7lzk7NTPQqgYevk23h+mYlUSpopbayj0vQU7uFJOWNGKLd5rJCH3CqiDWN8ZzywVQ+9oYQ7NqZpXjwWbUgSTp0I6s8aPs37Zg+VrM3eRvaX4+M+yQdzXiDmoOIXVzB5Ao0Fr2fgzmONUIuFAV2+6uOiNEXQcHHxI5wO/hW01zVfs56zSLipr+tLQjYLECNAk8SNv0Wn10PX+sDiKExPJrTtKFvK+1I8bLPD71b+rY3UZdf/rYG+TWhS/QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uVSyIxd0zyi5DPAP831D9ZtXzLP6ZjtYK7g/s1ptTOw=;
 b=BavH2f7ZPS289YSJZ4vWb9kAtK8VqTY8A7uYaeNR0wA1NjQevvx/MC2kmuAu/A/z9GzADgIS9e3hU7mmNj5Gc7mwxsa4Stg4HLbxeZTDhpCJ4NhEjpcZtU8H3rHyUDDYYGdUNtO6sPLjZHdACAgRA5gQHexRCy373OnEJkmOMznDhxcqjjxMWiZ2/sHD4ki5fCIeBe+VpdSeVcnErDDC7UOGCKMKNoV/AIev9QJWt+eb0saKF9driCoa1PYqi1hNwKqQzMho5chu9A2ld6KVe4ifKxG0jQsjh7/Bpn/8HzgMSN5jQ6fYA1cEBsjG+q38Fn/uzFSu81WqanApPsxS3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uVSyIxd0zyi5DPAP831D9ZtXzLP6ZjtYK7g/s1ptTOw=;
 b=lc7PIabXDIsjAcoPzxVEQceZx7KHaBl9b8g49Qb5XHu4n7PaFUQcf/ZVzeUrDDCZ9T2ROeZWV4B/zYQW5eP5hVG0O9y9CqlSxB4TYoo3jMegY0PzBn1KOq9LjUIq2bidExpRctVm2zeKSbznAzjOPNRKxhE1gKPONCrsdpvqnd4=
Received: from MW4PR04CA0264.namprd04.prod.outlook.com (2603:10b6:303:88::29)
 by DS7PR12MB8082.namprd12.prod.outlook.com (2603:10b6:8:e6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.24; Thu, 19 Jan
 2023 03:53:06 +0000
Received: from CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::63) by MW4PR04CA0264.outlook.office365.com
 (2603:10b6:303:88::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.19 via Frontend
 Transport; Thu, 19 Jan 2023 03:53:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT034.mail.protection.outlook.com (10.13.174.248) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.24 via Frontend Transport; Thu, 19 Jan 2023 03:53:06 +0000
Received: from platform-dev1.pensando.io (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 18 Jan 2023 21:53:02 -0600
From:   Brad Larson <blarson@amd.com>
To:     <linux-arm-kernel@lists.infradead.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <adrian.hunter@intel.com>,
        <alcooperx@gmail.com>, <andy.shevchenko@gmail.com>,
        <arnd@arndb.de>, <brad@pensando.io>, <blarson@amd.com>,
        <brendan.higgins@linux.dev>, <briannorris@chromium.org>,
        <brijeshkumar.singh@amd.com>, <catalin.marinas@arm.com>,
        <davidgow@google.com>, <gsomlo@gmail.com>, <gerg@linux-m68k.org>,
        <krzk@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <lee@kernel.org>, <lee.jones@linaro.org>, <broonie@kernel.org>,
        <yamada.masahiro@socionext.com>, <p.zabel@pengutronix.de>,
        <piotrs@cadence.com>, <p.yadav@ti.com>, <rdunlap@infradead.org>,
        <robh+dt@kernel.org>, <samuel@sholland.org>,
        <fancer.lancer@gmail.com>, <skhan@linuxfoundation.org>,
        <suravee.suthikulpanit@amd.com>, <thomas.lendacky@amd.com>,
        <tonyhuang.sunplus@gmail.com>, <ulf.hansson@linaro.org>,
        <vaishnav.a@ti.com>, <will@kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH v9 15/15] spi: pensando-sr: Add AMD Pensando SoC System Resource
Date:   Wed, 18 Jan 2023 19:51:36 -0800
Message-ID: <20230119035136.21603-16-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119035136.21603-1-blarson@amd.com>
References: <20230119035136.21603-1-blarson@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT034:EE_|DS7PR12MB8082:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d6c73c3-faea-4ef6-a6e6-08daf9d0ac19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r13aYIPKJF5YHCvi16uyqhEPVgtV/cMHccQ3rJo9Boe+6M5eBHQwJ7uTrpGXb4Pq0Af8/KEf5G4ZtRPoMXVnek+WL7fpSLgrmQKidcc7Ec4HyLOhaIYPutH28hrf12ej8ZRmgr1KkRIVdYYiPEB5c04VyLo+x6JvQaiPwUclm/mEl5JmvN8Igonq9iyhwyQftVRTCNwlx3xveHu/3gNTBYd9eO0+OU+Dirz6EG3PPxeIDGJWwgWpaP+NxRty3oYrwOpBZmTVrMsWSevVA2nwrMGqQgSxzAaIwJRJveYodYVeBKoNHjg6Dk8Zvk/YksR35JCTCxuN92rDZ6v6d6XlZM4lNpqOEWlsMqjhF1w/Eq2NakgH+6nEO0V2sIaF1//704NtFeb3q01ONuiyd748aWsN/qGsw6CMT4t6HEqUIdNuPMvgksJjzNmGAKD2sTKc3glsdfSAhqNG5aoVGMvRMkjvNY2Z6yfGGVJV1Sa/oi6Fk1x6zzR0pvIuDnc7EZVsrwcYjlKPPT7PdfzKr++6GUT319Ml1Tnd4cznOLa4gixkgvQ4P/rCFrFGgD610bWH+xvJWfPsi1YbruTb9TYLb89yYl5ziKst1C0wPyXHBQmxMqzf9qyLit9KzqUHkaW4R6C0Blq3yrn4WdkGoacQctPmIutXopwanC4RR/lR9E9AH4q/XTkQ4W/9QSdwn9ruCd+kgyTa9LXRARcIjWjdgSRZe6y4Q5RR1ExLsLxqtCASJ1mcp74LKwQk8OnKxEZ63jWx91nNSHk6kUh2dQ1SMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(39860400002)(136003)(451199015)(46966006)(36840700001)(40470700004)(36860700001)(426003)(82310400005)(47076005)(356005)(83380400001)(81166007)(82740400003)(2906002)(8936002)(5660300002)(30864003)(41300700001)(7416002)(7406005)(40460700003)(40480700001)(4326008)(6666004)(1076003)(186003)(2616005)(16526019)(478600001)(26005)(336012)(316002)(8676002)(70586007)(70206006)(54906003)(6916009)(36756003)(36900700001)(473944003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2023 03:53:06.0816
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d6c73c3-faea-4ef6-a6e6-08daf9d0ac19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the AMD Pensando SoC System Resource chip using
the SPI interface.  The device functions are accessed using
four chip-selects and the device can be a CPLD or FPGA depending
on functionality.

Signed-off-by: Brad Larson <blarson@amd.com>
---

Changes since v6:
- Previously patch 14/17
- After the change to the device tree node and squashing
  reset-cells into the parent simplified this to not use
  any MFD API and move it to drivers/spi/pensando-sr.c.
- Change the naming to remove elba since this driver is common
  for all Pensando SoC designs .
- Default yes SPI_PENSANDO_SR for ARCH_PENSANDO

---
 drivers/spi/Kconfig           |  14 ++
 drivers/spi/Makefile          |   1 +
 drivers/spi/spi-pensando-sr.c | 454 ++++++++++++++++++++++++++++++++++
 3 files changed, 469 insertions(+)
 create mode 100644 drivers/spi/spi-pensando-sr.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1c0878bb85..1e8605c59a0e 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -730,6 +730,20 @@ config SPI_PCI1XXXX
 	  This driver can be built as module. If so, the module will be
 	  called as spi-pci1xxxx.
 
+config SPI_PENSANDO_SR
+	bool "AMD Pensando SoC System Resource chip"
+	depends on SPI_MASTER=y
+	depends on (ARCH_PENSANDO && OF) || COMPILE_TEST
+	default y if ARCH_PENSANDO
+	select REGMAP_SPI
+	select MFD_SYSCON
+	help
+	  Support for the AMD Pensando SoC System Resource chip using the
+	  SPI interface.  This driver provides userspace access to the SPI
+	  device functions via multiple chip selects.  The device can be
+	  a CPLD or FPGA depending on the functionality required and is
+	  present in all Pensando SoC based designs.
+
 config SPI_PIC32
 	tristate "Microchip PIC32 series SPI"
 	depends on MACH_PIC32 || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index be9ba40ef8d0..71e0a95c6d88 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -95,6 +95,7 @@ obj-$(CONFIG_SPI_OMAP_100K)		+= spi-omap-100k.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= spi-omap2-mcspi.o
 obj-$(CONFIG_SPI_TI_QSPI)		+= spi-ti-qspi.o
 obj-$(CONFIG_SPI_ORION)			+= spi-orion.o
+obj-$(CONFIG_SPI_PENSANDO_SR)		+= spi-pensando-sr.o
 obj-$(CONFIG_SPI_PCI1XXXX)		+= spi-pci1xxxx.o
 obj-$(CONFIG_SPI_PIC32)			+= spi-pic32.o
 obj-$(CONFIG_SPI_PIC32_SQI)		+= spi-pic32-sqi.o
diff --git a/drivers/spi/spi-pensando-sr.c b/drivers/spi/spi-pensando-sr.c
new file mode 100644
index 000000000000..91c64bcfba04
--- /dev/null
+++ b/drivers/spi/spi-pensando-sr.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AMD Pensando SoC System Resource Driver
+ *
+ * Userspace interface and reset driver support for SPI
+ * connected Pensando SoC System Resource Chip.  This
+ * device is present in all Pensando SoC based designs.
+ * This file is derived in part from spi/spidev.c.
+ *
+ * Copyright (C) 2006 SWAPP
+ *      Andrea Paterniani <a.paterniani@swapp-eng.it>
+ * Copyright (C) 2007 David Brownell (simplification, cleanup)
+ * Copyright 2023 Advanced Micro Devices, Inc.
+ */
+
+#include <linux/cdev.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/fs.h>
+#include <linux/init.h>
+#include <linux/ioctl.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/reset-controller.h>
+#include <linux/spi/spi.h>
+#include <linux/types.h>
+
+#define PENSR_MAX_REG		0xff
+#define PENSR_CTRL0_REG		0x10
+#define PENSR_SPI_CMD_REGRD	0x0b
+#define PENSR_SPI_CMD_REGWR	0x02
+#define SPI_IOC_MAGIC		'k'
+
+#define SPI_MSGSIZE(N) \
+	((((N)*(sizeof(struct spi_ioc_transfer))) < (1 << _IOC_SIZEBITS)) \
+		? ((N)*(sizeof(struct spi_ioc_transfer))) : 0)
+#define SPI_IOC_MESSAGE(N)	_IOW(SPI_IOC_MAGIC, 0, char[SPI_MSGSIZE(N)])
+
+struct spi_ioc_transfer {
+	__u64 tx_buf;
+	__u64 rx_buf;
+	__u32 len;
+	__u32 speed_hz;
+	__u16 delay_usecs;
+	__u8 bits_per_word;
+	__u8 cs_change;
+	__u8 tx_nbits;
+	__u8 rx_nbits;
+	__u8 word_delay_usecs;
+	__u8 pad;
+};
+
+struct pensr_device {
+	struct spi_device *spi_dev;
+	struct reset_controller_dev rcdev;
+	struct mutex buf_lock;
+	spinlock_t spi_lock;
+	u8 *tx_buffer;
+	u8 *rx_buffer;
+};
+
+static dev_t pensr_devt;
+static struct pensr_device *pensr;
+static struct class *pensr_class;
+static unsigned int bufsiz = 4096;
+
+static struct spi_ioc_transfer *
+pensr_spi_get_ioc_message(unsigned int cmd,
+			  struct spi_ioc_transfer __user *u_ioc,
+			  unsigned int *n_ioc)
+{
+	u32 tmp;
+
+	/* Check type, command number and direction */
+	if (_IOC_TYPE(cmd) != SPI_IOC_MAGIC
+			|| _IOC_NR(cmd) != _IOC_NR(SPI_IOC_MESSAGE(0))
+			|| _IOC_DIR(cmd) != _IOC_WRITE)
+		return ERR_PTR(-ENOTTY);
+
+	tmp = _IOC_SIZE(cmd);
+	if ((tmp % sizeof(struct spi_ioc_transfer)) != 0)
+		return ERR_PTR(-EINVAL);
+	*n_ioc = tmp / sizeof(struct spi_ioc_transfer);
+	if (*n_ioc == 0)
+		return NULL;
+
+	/* copy into scratch area */
+	return memdup_user(u_ioc, tmp);
+}
+
+static long
+pensr_spi_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct spi_transfer t[2] = { 0 };
+	struct spi_ioc_transfer	*u_xfers;
+	struct spi_ioc_transfer *u_xfer;
+	struct pensr_device *pensr;
+	struct spi_device *spi_dev;
+	unsigned int n_xfers;
+	struct spi_message m;
+	u8 *tx_buf;
+	u8 *rx_buf;
+	int ret;
+
+	/* Check type and command number */
+	if (_IOC_TYPE(cmd) != SPI_IOC_MAGIC)
+		return -ENOTTY;
+
+	pensr = filp->private_data;
+	if (!pensr)
+		return -ESHUTDOWN;
+
+	tx_buf = pensr->tx_buffer;
+	rx_buf = pensr->rx_buffer;
+
+	spin_lock_irq(&pensr->spi_lock);
+	spi_dev = spi_dev_get(pensr->spi_dev);
+	spin_unlock_irq(&pensr->spi_lock);
+	if (spi_dev == NULL)
+		return -ESHUTDOWN;
+
+	/* Use the buffer lock here for triple duty:
+	 *  - prevent I/O (from us) so calling spi_setup() is safe;
+	 *  - prevent concurrent SPI_IOC_WR_* from morphing
+	 *    data fields while SPI_IOC_RD_* reads them;
+	 *  - SPI_IOC_MESSAGE needs the buffer locked "normally".
+	 */
+	mutex_lock(&pensr->buf_lock);
+
+	u_xfers = pensr_spi_get_ioc_message(cmd,
+			(struct spi_ioc_transfer __user *)arg, &n_xfers);
+	if (IS_ERR(u_xfers)) {
+		ret = PTR_ERR(u_xfers);
+		goto done;
+	}
+	if (!u_xfers)
+		goto done;
+	u_xfer = u_xfers;
+
+	t[0].tx_buf = tx_buf;
+	t[0].len = u_xfer->len;
+	if (copy_from_user(tx_buf, (const u8 __user *) (uintptr_t) u_xfer->tx_buf, u_xfer->len)) {
+		ret = -EFAULT;
+		goto done;
+	}
+
+	if (n_xfers > 1) {
+		u_xfer++;
+		t[1].rx_buf = rx_buf;
+		t[1].len = u_xfer->len;
+	}
+
+	spi_message_init_with_transfers(&m, t, n_xfers);
+	ret = spi_sync(spi_dev, &m);
+	if (ret < 0)
+		goto done;
+
+	if (n_xfers > 1) {
+		if (copy_to_user((u8 __user *)(uintptr_t)u_xfer->rx_buf, rx_buf, u_xfer->len)) {
+			ret = -EFAULT;
+			goto done;
+		}
+	}
+
+done:
+	mutex_unlock(&pensr->buf_lock);
+	spi_dev_put(spi_dev);
+	return ret;
+}
+
+static int pensr_spi_open(struct inode *inode, struct file *filp)
+{
+	struct spi_device *spi_dev;
+	int status = -ENXIO;
+	u8 current_cs;
+
+	if (!pensr)
+		return -ENODEV;
+
+	filp->private_data = pensr;
+	current_cs = iminor(inode);
+	spi_dev = pensr->spi_dev;
+	spi_dev->chip_select = current_cs;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[current_cs];
+	spi_setup(spi_dev);
+
+	if (!pensr->tx_buffer) {
+		pensr->tx_buffer = kmalloc(bufsiz, GFP_KERNEL);
+		memset(pensr->tx_buffer, 0, bufsiz);
+		if (!pensr->tx_buffer) {
+			status = -ENOMEM;
+			goto err_alloc_tx_buf;
+		}
+	}
+	if (!pensr->rx_buffer) {
+		pensr->rx_buffer = kmalloc(bufsiz, GFP_KERNEL);
+		memset(pensr->rx_buffer, 0, bufsiz);
+		if (!pensr->rx_buffer) {
+			status = -ENOMEM;
+			goto err_alloc_rx_buf;
+		}
+	}
+	stream_open(inode, filp);
+	return 0;
+
+err_alloc_rx_buf:
+	kfree(pensr->tx_buffer);
+	pensr->tx_buffer = NULL;
+err_alloc_tx_buf:
+	return status;
+}
+
+static int pensr_spi_release(struct inode *inode, struct file *filp)
+{
+	filp->private_data = NULL;
+	return 0;
+}
+
+static const struct file_operations pensr_spi_fops = {
+	.owner =	THIS_MODULE,
+	.unlocked_ioctl = pensr_spi_ioctl,
+	.open =		pensr_spi_open,
+	.release =	pensr_spi_release,
+	.llseek =	no_llseek,
+};
+
+static int pensr_regs_read(struct pensr_device *pensr, u32 reg, u32 *val)
+{
+	struct spi_device *spi_dev = pensr->spi_dev;
+	struct spi_transfer t[2] = { 0 };
+	struct spi_message m;
+	u8 txbuf[3];
+	u8 rxbuf[1];
+	int ret;
+
+	txbuf[0] = PENSR_SPI_CMD_REGRD;
+	txbuf[1] = reg;
+	txbuf[2] = 0x0;
+	t[0].tx_buf = (u8 *)txbuf;
+	t[0].len = 3;
+
+	rxbuf[0] = 0x0;
+	t[1].rx_buf = rxbuf;
+	t[1].len = 1;
+
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+	ret = spi_sync(spi_dev, &m);
+	if (ret == 0) {
+		/* 3 Tx + 1 Rx = 4 */
+		*val = rxbuf[0];
+	}
+	return ret;
+}
+
+static int pensr_regs_write(struct pensr_device *pensr, u32 reg, u32 val)
+{
+	struct spi_device *spi_dev = pensr->spi_dev;
+	struct spi_transfer t[1] = { 0 };
+	struct spi_message m;
+	u8 txbuf[4];
+	int ret;
+
+	spi_dev->chip_select = 0;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[0];
+	spi_setup(spi_dev);
+
+	txbuf[0] = PENSR_SPI_CMD_REGWR;
+	txbuf[1] = reg;
+	txbuf[2] = val;
+	txbuf[3] = 0;
+
+	t[0].tx_buf = txbuf;
+	t[0].len = 4;
+	spi_message_init_with_transfers(&m, t, ARRAY_SIZE(t));
+	ret = spi_sync(spi_dev, &m);
+	return ret;
+}
+
+static int pensr_reset_assert(struct reset_controller_dev *rcdev,
+			      unsigned long id)
+{
+	struct pensr_device *pensr =
+		container_of(rcdev, struct pensr_device, rcdev);
+	struct spi_device *spi_dev = pensr->spi_dev;
+	unsigned int val;
+	int ret;
+
+	spin_lock_irq(&pensr->spi_lock);
+	spi_dev->chip_select = 0;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[spi_dev->chip_select];
+	spi_setup(spi_dev);
+
+	ret = pensr_regs_read(pensr, PENSR_CTRL0_REG, &val);
+	if (ret) {
+		dev_err(&spi_dev->dev, "error reading ctrl0 reg\n");
+		goto done;
+	}
+
+	val |= BIT(6);
+	ret = pensr_regs_write(pensr, PENSR_CTRL0_REG, val);
+	if (ret)
+		dev_err(&spi_dev->dev, "error writing ctrl0 reg\n");
+
+done:
+	spin_unlock_irq(&pensr->spi_lock);
+	return ret;
+}
+
+static int pensr_reset_deassert(struct reset_controller_dev *rcdev,
+				unsigned long id)
+{
+	struct pensr_device *pensr =
+		container_of(rcdev, struct pensr_device, rcdev);
+	struct spi_device *spi_dev = pensr->spi_dev;
+	unsigned int val;
+	int ret;
+
+	spin_lock_irq(&pensr->spi_lock);
+	spi_dev->chip_select = 0;
+	spi_dev->cs_gpiod = spi_dev->controller->cs_gpiods[spi_dev->chip_select];
+	spi_setup(spi_dev);
+
+	ret = pensr_regs_read(pensr, PENSR_CTRL0_REG, &val);
+	if (ret) {
+		dev_err(&spi_dev->dev, "error reading ctrl0 reg\n");
+		goto done;
+	}
+
+	val &= ~BIT(6);
+	ret = pensr_regs_write(pensr, PENSR_CTRL0_REG, val);
+	if (ret)
+		dev_err(&spi_dev->dev, "error writing ctrl0 reg\n");
+
+done:
+	spin_unlock_irq(&pensr->spi_lock);
+	return ret;
+}
+
+static const struct reset_control_ops pensr_reset_ops = {
+	.assert = pensr_reset_assert,
+	.deassert = pensr_reset_deassert,
+};
+
+static int pensr_spi_probe(struct spi_device *spi_dev)
+{
+	struct device_node *np;
+	struct property *prop;
+	struct device *dev;
+	struct cdev *cdev;
+	const __be32 *p;
+	int status;
+	u32 num_cs;
+	u32 cs;
+
+	np = spi_dev->dev.parent->of_node;
+	status = of_property_read_u32(np, "num-cs", &num_cs);
+	if (status)
+		return dev_err_probe(&spi_dev->dev, status,
+				     "number of chip-selects not defined");
+
+	status = alloc_chrdev_region(&pensr_devt, 0, num_cs, "pensr");
+	if (status)
+		return dev_err_probe(&spi_dev->dev, status,
+				     "failed to alloc chrdev region\n");
+
+	pensr_class = class_create(THIS_MODULE, "pensr");
+	if (IS_ERR(pensr_class)) {
+		unregister_chrdev(MAJOR(pensr_devt), "pensr");
+		return dev_err_probe(&spi_dev->dev, PTR_ERR(pensr_class),
+				     "failed to create class\n");
+	}
+
+	cdev = cdev_alloc();
+	if (!cdev) {
+		dev_err(&spi_dev->dev, "allocation of cdev failed");
+		status = -ENOMEM;
+		goto cdev_failed;
+	}
+	cdev->owner = THIS_MODULE;
+	cdev_init(cdev, &pensr_spi_fops);
+
+	status = cdev_add(cdev, pensr_devt, num_cs);
+	if (status) {
+		dev_err(&spi_dev->dev, "register of cdev failed");
+		goto cdev_delete;
+	}
+
+	/* Allocate driver data */
+	pensr = kzalloc(sizeof(*pensr), GFP_KERNEL);
+	if (!pensr) {
+		status = -ENOMEM;
+		dev_err(&spi_dev->dev, "allocate driver data failed");
+		goto cdev_delete;
+	}
+
+	pensr->spi_dev = spi_dev;
+	spin_lock_init(&pensr->spi_lock);
+	mutex_init(&pensr->buf_lock);
+
+	/* Create a device for each chip select */
+	np = spi_dev->dev.of_node;
+	of_property_for_each_u32(np, "cs", prop, p, cs) {
+		dev = device_create(pensr_class,
+				    &spi_dev->dev,
+				    MKDEV(MAJOR(pensr_devt), cs),
+				    pensr,
+				    "pensr0.%d",
+				    cs);
+		if (IS_ERR(dev)) {
+			status = IS_ERR(dev);
+			dev_err(&spi_dev->dev, "error creating device\n");
+			goto cdev_delete;
+		}
+		dev_dbg(&spi_dev->dev, "created device major %u, minor %d\n",
+			MAJOR(pensr_devt), cs);
+	}
+
+	spi_set_drvdata(spi_dev, pensr);
+
+	/* Register emmc hardware reset */
+	pensr->rcdev.nr_resets = 1;
+	pensr->rcdev.owner = THIS_MODULE;
+	pensr->rcdev.dev = &spi_dev->dev;
+	pensr->rcdev.ops = &pensr_reset_ops;
+	pensr->rcdev.of_node = spi_dev->dev.of_node;
+	status = reset_controller_register(&pensr->rcdev);
+	if (status)
+		return dev_err_probe(&spi_dev->dev, status,
+				     "failed to register reset controller\n");
+	return status;
+
+cdev_delete:
+	cdev_del(cdev);
+cdev_failed:
+	device_destroy(pensr_class, pensr_devt);
+	return status;
+}
+
+static const struct of_device_id pensr_dt_match[] = {
+	{ .compatible = "amd,pensando-sr" },
+	{ /* sentinel */ }
+};
+
+static struct spi_driver pensr_spi_driver = {
+	.probe = pensr_spi_probe,
+	.driver = {
+		.name = "pensando-sr",
+		.of_match_table = pensr_dt_match,
+	},
+};
+builtin_driver(pensr_spi_driver, spi_register_driver)
-- 
2.17.1

