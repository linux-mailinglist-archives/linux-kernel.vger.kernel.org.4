Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DCB673036
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 05:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjASE23 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 23:28:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjASDqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 22:46:32 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 761636D680
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:42:18 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id 200so517095pfx.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 19:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pensando.io; s=google;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uVSyIxd0zyi5DPAP831D9ZtXzLP6ZjtYK7g/s1ptTOw=;
        b=CYcNjBOA4iXUjDqf0A2U3wySawGseGrC8O+CwtrYZlNnZmtVga6ezSlVGObFe68bfe
         PDqckIQs4DeawALv2+6Mvdom3AeZu98c1Cwvx+B9ev7yP35lUOpVhoVfaXrCtk6zri4d
         Sz1pU6ug/Pna7Aiuw4AKnZFJ9edOeTnVxi07NBxq417KftkTxIiIkD6/juWB4O1QPX+O
         j+pDBrml8t0bpXQtWNDRztzI/W4HKiU6aJTqgQbaBVF6xfRs7UWapRtgav2sB+6flTPi
         Fhx+k1R6eQPiY3bb5xzIziuvDXt7QpAVtrMpNB4u+aT6ln4Rc0GGqBBHSsXwS13cYabF
         qelA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uVSyIxd0zyi5DPAP831D9ZtXzLP6ZjtYK7g/s1ptTOw=;
        b=6/lvWgJA2hsZWYU07hB/umqJVGZjpcoLThx+bJYPrwx8ZN6Th8wPt9+eeNAl20lUQi
         LdKGZWFMEwfqyYAh8lW76QnW7kH7P87BBU9N7NSbKZFIGNKrh0nKD5xqVH2nU813fK7g
         tLifUfQjkIFQtIYcM87/DI5xgTrH9ZXH4S85WuvM/jWI5b6JgFxFTeAiTZvP9N2zhNJ1
         5Sn7LtIKSu/S8BjUz2Sbk+5KFDbYvNH0nUsvfWNZM0wTEg3Oq0x9dhFaEacdfbiFbvO0
         xEUMFSa7PR9fpPD2acyC1jAXAVUaKFdGtlFKq1sj2mUFYp7aUFaOF8I9msg4ubo9Lojz
         4KBg==
X-Gm-Message-State: AFqh2koS7ENfyx945x5+1ouWN5BpJ/FjJzyGOb2k1nIvpJwJ0sxSZXx7
        KiF/OJRYlQb3Oyzvt+Ga/8u6fw==
X-Google-Smtp-Source: AMrXdXu31sYvhMTGNmKeNMGDtn67A+7vFxdchzZgm01ST9jP/KJYHS7MLvPV/vuDH+ZYP8aICPTGsg==
X-Received: by 2002:a62:6410:0:b0:58b:c873:54e9 with SMTP id y16-20020a626410000000b0058bc87354e9mr9103160pfb.4.1674099688066;
        Wed, 18 Jan 2023 19:41:28 -0800 (PST)
Received: from platform-dev1.pensando.io ([12.226.153.42])
        by smtp.gmail.com with ESMTPSA id f13-20020aa7968d000000b0056b4c5dde61sm11097879pfk.98.2023.01.18.19.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 19:41:27 -0800 (PST)
From:   Brad Larson <brad@pensando.io>
X-Google-Original-From: Brad Larson <blarson@amd.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-spi@vger.kernel.org, adrian.hunter@intel.com,
        alcooperx@gmail.com, andy.shevchenko@gmail.com, arnd@arndb.de,
        brad@pensando.io, blarson@amd.com, brendan.higgins@linux.dev,
        briannorris@chromium.org, brijeshkumar.singh@amd.com,
        catalin.marinas@arm.com, davidgow@google.com, gsomlo@gmail.com,
        gerg@linux-m68k.org, krzk@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        lee.jones@linaro.org, broonie@kernel.org,
        yamada.masahiro@socionext.com, p.zabel@pengutronix.de,
        piotrs@cadence.com, p.yadav@ti.com, rdunlap@infradead.org,
        robh+dt@kernel.org, samuel@sholland.org, fancer.lancer@gmail.com,
        skhan@linuxfoundation.org, suravee.suthikulpanit@amd.com,
        thomas.lendacky@amd.com, tonyhuang.sunplus@gmail.com,
        ulf.hansson@linaro.org, vaishnav.a@ti.com, will@kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH v9 15/15] spi: pensando-sr: Add AMD Pensando SoC System Resource
Date:   Wed, 18 Jan 2023 19:39:18 -0800
Message-Id: <20230119033918.44117-16-blarson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119033918.44117-1-blarson@amd.com>
References: <20230119033918.44117-1-blarson@amd.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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

