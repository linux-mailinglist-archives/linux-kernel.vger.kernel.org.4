Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E87768D00A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:02:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbjBGHCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjBGHCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:02:02 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE6E2A995;
        Mon,  6 Feb 2023 23:01:30 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 4218EC0000F0;
        Mon,  6 Feb 2023 23:01:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 4218EC0000F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753266;
        bh=mXv6v8JdfcjrO71Q3IkTodMsaTt+D2tJ9DMrz2G42c8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PhmYYXFfk0zPiU49H890kLjjvpPROwW+TLi9YaKbHIA+DdN700TKArYBjEmWGx2En
         uiNWTUr0VNFobyJ5AFTYO7j0xro5aaeLnEahiZtZw/mtD4DabyAkIgFNhRaar43cOK
         ++1BEqEzfFM5Hvz/igjzulCm2BQ5k2bH6XSbyl8A=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 4067C18041CAC6;
        Mon,  6 Feb 2023 23:01:06 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 93971101B35; Mon,  6 Feb 2023 23:00:56 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 14/15] spi: bcmbca-hsspi: Add driver for newer HSSPI controller
Date:   Mon,  6 Feb 2023 22:58:25 -0800
Message-Id: <20230207065826.285013-15-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230207065826.285013-1-william.zhang@broadcom.com>
References: <20230207065826.285013-1-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer BCMBCA SoCs such as BCM6756, BCM4912 and BCM6855 include an
updated SPI controller that add the capability to allow the driver to
control chip select explicitly. Driver can control and keep cs low
between the transfers natively. Hence the dummy cs workaround or prepend
mode found in the bcm63xx-hsspi driver are no longer needed and this new
driver is much cleaner.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v3:
- Port the cs_change and cs_off logic from SPI core
  spi_transfer_one_message function
- Minor coding style fix

Changes in v2:
- Fix build error for Alpha platform
Reported-by: kernel test robot <lkp@intel.com>
- Make interrupt as required node in the dts
- Use polling mode as default mode
- Add driver sysfs option wait_mode to allow mode change at run time
- Update the compatible string based on changes in dts document
- Remove clock gate disabling code for now
- Update commit message

 drivers/spi/Kconfig            |   9 +
 drivers/spi/Makefile           |   1 +
 drivers/spi/spi-bcmbca-hsspi.c | 651 +++++++++++++++++++++++++++++++++
 3 files changed, 661 insertions(+)
 create mode 100644 drivers/spi/spi-bcmbca-hsspi.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1c0878bb85..771244582d03 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -199,6 +199,15 @@ config SPI_BCM_QSPI
 	  based platforms. This driver works for both SPI master for SPI NOR
 	  flash device as well as MSPI device.
 
+config SPI_BCMBCA_HSSPI
+	tristate "Broadcom BCMBCA HS SPI controller driver"
+	depends on ARCH_BCMBCA || COMPILE_TEST
+	help
+	  This enables support for the High Speed SPI controller present on
+	  newer Broadcom BCMBCA SoCs. These SoCs include an updated SPI controller
+	  that adds the capability to allow the driver to control chip select
+	  explicitly.
+
 config SPI_BITBANG
 	tristate "Utilities for Bitbanging SPI masters"
 	help
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index be9ba40ef8d0..fe92106447c3 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -30,6 +30,7 @@ obj-$(CONFIG_SPI_BCM2835)		+= spi-bcm2835.o
 obj-$(CONFIG_SPI_BCM2835AUX)		+= spi-bcm2835aux.o
 obj-$(CONFIG_SPI_BCM63XX)		+= spi-bcm63xx.o
 obj-$(CONFIG_SPI_BCM63XX_HSSPI)		+= spi-bcm63xx-hsspi.o
+obj-$(CONFIG_SPI_BCMBCA_HSSPI)		+= spi-bcmbca-hsspi.o
 obj-$(CONFIG_SPI_BCM_QSPI)		+= spi-iproc-qspi.o spi-brcmstb-qspi.o spi-bcm-qspi.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi-bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi-butterfly.o
diff --git a/drivers/spi/spi-bcmbca-hsspi.c b/drivers/spi/spi-bcmbca-hsspi.c
new file mode 100644
index 000000000000..d58033251c02
--- /dev/null
+++ b/drivers/spi/spi-bcmbca-hsspi.c
@@ -0,0 +1,651 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Broadcom BCMBCA High Speed SPI Controller driver
+ *
+ * Copyright 2000-2010 Broadcom Corporation
+ * Copyright 2012-2013 Jonas Gorski <jogo@openwrt.org>
+ * Copyright 2019-2022 Broadcom Ltd
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/clk.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/spi/spi.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/pm_runtime.h>
+
+#define HSSPI_GLOBAL_CTRL_REG			0x0
+#define GLOBAL_CTRL_CS_POLARITY_SHIFT		0
+#define GLOBAL_CTRL_CS_POLARITY_MASK		0x000000ff
+#define GLOBAL_CTRL_PLL_CLK_CTRL_SHIFT		8
+#define GLOBAL_CTRL_PLL_CLK_CTRL_MASK		0x0000ff00
+#define GLOBAL_CTRL_CLK_GATE_SSOFF		BIT(16)
+#define GLOBAL_CTRL_CLK_POLARITY		BIT(17)
+#define GLOBAL_CTRL_MOSI_IDLE			BIT(18)
+
+#define HSSPI_GLOBAL_EXT_TRIGGER_REG		0x4
+
+#define HSSPI_INT_STATUS_REG			0x8
+#define HSSPI_INT_STATUS_MASKED_REG		0xc
+#define HSSPI_INT_MASK_REG			0x10
+
+#define HSSPI_PINGx_CMD_DONE(i)			BIT((i * 8) + 0)
+#define HSSPI_PINGx_RX_OVER(i)			BIT((i * 8) + 1)
+#define HSSPI_PINGx_TX_UNDER(i)			BIT((i * 8) + 2)
+#define HSSPI_PINGx_POLL_TIMEOUT(i)		BIT((i * 8) + 3)
+#define HSSPI_PINGx_CTRL_INVAL(i)		BIT((i * 8) + 4)
+
+#define HSSPI_INT_CLEAR_ALL			0xff001f1f
+
+#define HSSPI_PINGPONG_COMMAND_REG(x)		(0x80 + (x) * 0x40)
+#define PINGPONG_CMD_COMMAND_MASK		0xf
+#define PINGPONG_COMMAND_NOOP			0
+#define PINGPONG_COMMAND_START_NOW		1
+#define PINGPONG_COMMAND_START_TRIGGER		2
+#define PINGPONG_COMMAND_HALT			3
+#define PINGPONG_COMMAND_FLUSH			4
+#define PINGPONG_CMD_PROFILE_SHIFT		8
+#define PINGPONG_CMD_SS_SHIFT			12
+
+#define HSSPI_PINGPONG_STATUS_REG(x)		(0x84 + (x) * 0x40)
+#define HSSPI_PINGPONG_STATUS_SRC_BUSY          BIT(1)
+
+#define HSSPI_PROFILE_CLK_CTRL_REG(x)		(0x100 + (x) * 0x20)
+#define CLK_CTRL_FREQ_CTRL_MASK			0x0000ffff
+#define CLK_CTRL_SPI_CLK_2X_SEL			BIT(14)
+#define CLK_CTRL_ACCUM_RST_ON_LOOP		BIT(15)
+#define CLK_CTRL_CLK_POLARITY			BIT(16)
+
+#define HSSPI_PROFILE_SIGNAL_CTRL_REG(x)	(0x104 + (x) * 0x20)
+#define SIGNAL_CTRL_LATCH_RISING		BIT(12)
+#define SIGNAL_CTRL_LAUNCH_RISING		BIT(13)
+#define SIGNAL_CTRL_ASYNC_INPUT_PATH		BIT(16)
+
+#define HSSPI_PROFILE_MODE_CTRL_REG(x)		(0x108 + (x) * 0x20)
+#define MODE_CTRL_MULTIDATA_RD_STRT_SHIFT	8
+#define MODE_CTRL_MULTIDATA_WR_STRT_SHIFT	12
+#define MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT	16
+#define MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT	18
+#define MODE_CTRL_MODE_3WIRE			BIT(20)
+#define MODE_CTRL_PREPENDBYTE_CNT_SHIFT		24
+
+#define HSSPI_FIFO_REG(x)			(0x200 + (x) * 0x200)
+
+#define HSSPI_OP_MULTIBIT			BIT(11)
+#define HSSPI_OP_CODE_SHIFT			13
+#define HSSPI_OP_SLEEP				(0 << HSSPI_OP_CODE_SHIFT)
+#define HSSPI_OP_READ_WRITE			(1 << HSSPI_OP_CODE_SHIFT)
+#define HSSPI_OP_WRITE				(2 << HSSPI_OP_CODE_SHIFT)
+#define HSSPI_OP_READ				(3 << HSSPI_OP_CODE_SHIFT)
+#define HSSPI_OP_SETIRQ				(4 << HSSPI_OP_CODE_SHIFT)
+
+#define HSSPI_BUFFER_LEN			512
+#define HSSPI_OPCODE_LEN			2
+
+#define HSSPI_MAX_PREPEND_LEN			15
+
+#define HSSPI_MAX_SYNC_CLOCK			30000000
+
+#define HSSPI_SPI_MAX_CS			8
+#define HSSPI_BUS_NUM				1	/* 0 is legacy SPI */
+#define HSSPI_POLL_STATUS_TIMEOUT_MS	100
+
+#define HSSPI_WAIT_MODE_POLLING		0
+#define HSSPI_WAIT_MODE_INTR		1
+#define HSSPI_WAIT_MODE_MAX			HSSPI_WAIT_MODE_INTR
+
+#define SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT		0
+#define SPIM_CTRL_CS_OVERRIDE_SEL_MASK		0xff
+#define SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT		8
+#define SPIM_CTRL_CS_OVERRIDE_VAL_MASK		0xff
+
+struct bcmbca_hsspi {
+	struct completion done;
+	struct mutex bus_mutex;
+	struct mutex msg_mutex;
+	struct platform_device *pdev;
+	struct clk *clk;
+	struct clk *pll_clk;
+	void __iomem *regs;
+	void __iomem *spim_ctrl;
+	u8 __iomem *fifo;
+	u32 speed_hz;
+	u8 cs_polarity;
+	u32 wait_mode;
+};
+
+static ssize_t wait_mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct bcmbca_hsspi *bs = spi_master_get_devdata(ctrl);
+
+	return sprintf(buf, "%d\n", bs->wait_mode);
+}
+
+static ssize_t wait_mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct bcmbca_hsspi *bs = spi_master_get_devdata(ctrl);
+	u32 val;
+
+	if (kstrtou32(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > HSSPI_WAIT_MODE_MAX) {
+		dev_warn(dev, "invalid wait mode %u\n", val);
+		return -EINVAL;
+	}
+
+	mutex_lock(&bs->msg_mutex);
+	bs->wait_mode = val;
+	/* clear interrupt status to avoid spurious int on next transfer */
+	if (val == HSSPI_WAIT_MODE_INTR)
+		__raw_writel(HSSPI_INT_CLEAR_ALL, bs->regs + HSSPI_INT_STATUS_REG);
+	mutex_unlock(&bs->msg_mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(wait_mode);
+
+static struct attribute *bcmbca_hsspi_attrs[] = {
+	&dev_attr_wait_mode.attr,
+	NULL,
+};
+
+static const struct attribute_group bcmbca_hsspi_group = {
+	.attrs = bcmbca_hsspi_attrs,
+};
+
+static void bcmbca_hsspi_set_cs(struct bcmbca_hsspi *bs, unsigned int cs,
+				 bool active)
+{
+	u32 reg;
+
+	/* No cs orerriden needed for SS7 internal cs on pcm based voice dev */
+	if (cs == 7)
+		return;
+
+	mutex_lock(&bs->bus_mutex);
+
+	reg = __raw_readl(bs->spim_ctrl);
+	if (active)
+		reg |= BIT(cs + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
+	else
+		reg &= ~BIT(cs + SPIM_CTRL_CS_OVERRIDE_SEL_SHIFT);
+
+	__raw_writel(reg, bs->spim_ctrl);
+
+	mutex_unlock(&bs->bus_mutex);
+}
+
+static void bcmbca_hsspi_set_clk(struct bcmbca_hsspi *bs,
+				  struct spi_device *spi, int hz)
+{
+	unsigned int profile = spi->chip_select;
+	u32 reg;
+
+	reg = DIV_ROUND_UP(2048, DIV_ROUND_UP(bs->speed_hz, hz));
+	__raw_writel(CLK_CTRL_ACCUM_RST_ON_LOOP | reg,
+		     bs->regs + HSSPI_PROFILE_CLK_CTRL_REG(profile));
+
+	reg = __raw_readl(bs->regs + HSSPI_PROFILE_SIGNAL_CTRL_REG(profile));
+	if (hz > HSSPI_MAX_SYNC_CLOCK)
+		reg |= SIGNAL_CTRL_ASYNC_INPUT_PATH;
+	else
+		reg &= ~SIGNAL_CTRL_ASYNC_INPUT_PATH;
+	__raw_writel(reg, bs->regs + HSSPI_PROFILE_SIGNAL_CTRL_REG(profile));
+
+	mutex_lock(&bs->bus_mutex);
+	/* setup clock polarity */
+	reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
+	reg &= ~GLOBAL_CTRL_CLK_POLARITY;
+	if (spi->mode & SPI_CPOL)
+		reg |= GLOBAL_CTRL_CLK_POLARITY;
+	__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
+
+	mutex_unlock(&bs->bus_mutex);
+}
+
+static int bcmbca_hsspi_wait_cmd(struct bcmbca_hsspi *bs, unsigned int cs)
+{
+	unsigned long limit;
+	u32 reg = 0;
+	int rc = 0;
+
+	if (bs->wait_mode == HSSPI_WAIT_MODE_INTR) {
+		if (wait_for_completion_timeout(&bs->done, HZ) == 0)
+			rc = 1;
+	} else {
+		limit = jiffies + msecs_to_jiffies(HSSPI_POLL_STATUS_TIMEOUT_MS);
+
+		while (!time_after(jiffies, limit)) {
+			reg = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
+			if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
+				cpu_relax();
+			else
+				break;
+		}
+		if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
+			rc = 1;
+	}
+
+	if (rc)
+		dev_err(&bs->pdev->dev, "transfer timed out!\n");
+
+	return rc;
+}
+
+static int bcmbca_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t,
+								struct spi_message *msg)
+{
+	struct bcmbca_hsspi *bs = spi_master_get_devdata(spi->master);
+	unsigned int chip_select = spi->chip_select;
+	u16 opcode = 0;
+	int pending = t->len;
+	int step_size = HSSPI_BUFFER_LEN;
+	const u8 *tx = t->tx_buf;
+	u8 *rx = t->rx_buf;
+	u32 reg = 0, cs_act = 0;
+
+	bcmbca_hsspi_set_clk(bs, spi, t->speed_hz);
+
+	if (tx && rx)
+		opcode = HSSPI_OP_READ_WRITE;
+	else if (tx)
+		opcode = HSSPI_OP_WRITE;
+	else if (rx)
+		opcode = HSSPI_OP_READ;
+
+	if (opcode != HSSPI_OP_READ)
+		step_size -= HSSPI_OPCODE_LEN;
+
+	if ((opcode == HSSPI_OP_READ && t->rx_nbits == SPI_NBITS_DUAL) ||
+	    (opcode == HSSPI_OP_WRITE && t->tx_nbits == SPI_NBITS_DUAL)) {
+		opcode |= HSSPI_OP_MULTIBIT;
+
+		if (t->rx_nbits == SPI_NBITS_DUAL)
+			reg |= 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
+		if (t->tx_nbits == SPI_NBITS_DUAL)
+			reg |= 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
+	}
+
+	__raw_writel(reg | 0xff,
+		     bs->regs + HSSPI_PROFILE_MODE_CTRL_REG(chip_select));
+
+	while (pending > 0) {
+		int curr_step = min_t(int, step_size, pending);
+
+		reinit_completion(&bs->done);
+		if (tx) {
+			memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN, tx, curr_step);
+			tx += curr_step;
+		}
+		__raw_writew((u16)cpu_to_be16(opcode | curr_step), bs->fifo);
+
+		/* enable interrupt */
+		if (bs->wait_mode == HSSPI_WAIT_MODE_INTR)
+			__raw_writel(HSSPI_PINGx_CMD_DONE(0),
+			    bs->regs + HSSPI_INT_MASK_REG);
+
+		if (!cs_act) {
+			/* must apply cs signal as close as the cmd starts */
+			bcmbca_hsspi_set_cs(bs, chip_select, true);
+			cs_act = 1;
+		}
+
+		reg = chip_select << PINGPONG_CMD_SS_SHIFT |
+			    chip_select << PINGPONG_CMD_PROFILE_SHIFT |
+			    PINGPONG_COMMAND_START_NOW;
+		__raw_writel(reg, bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
+
+		if (bcmbca_hsspi_wait_cmd(bs, spi->chip_select))
+			return -ETIMEDOUT;
+
+		pending -= curr_step;
+
+		if (rx) {
+			memcpy_fromio(rx, bs->fifo, curr_step);
+			rx += curr_step;
+		}
+	}
+
+	return 0;
+}
+
+static int bcmbca_hsspi_setup(struct spi_device *spi)
+{
+	struct bcmbca_hsspi *bs = spi_master_get_devdata(spi->master);
+	u32 reg;
+
+	reg = __raw_readl(bs->regs +
+			  HSSPI_PROFILE_SIGNAL_CTRL_REG(spi->chip_select));
+	reg &= ~(SIGNAL_CTRL_LAUNCH_RISING | SIGNAL_CTRL_LATCH_RISING);
+	if (spi->mode & SPI_CPHA)
+		reg |= SIGNAL_CTRL_LAUNCH_RISING;
+	else
+		reg |= SIGNAL_CTRL_LATCH_RISING;
+	__raw_writel(reg, bs->regs +
+		     HSSPI_PROFILE_SIGNAL_CTRL_REG(spi->chip_select));
+
+	mutex_lock(&bs->bus_mutex);
+	reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
+
+	if (spi->mode & SPI_CS_HIGH)
+		reg |= BIT(spi->chip_select);
+	else
+		reg &= ~BIT(spi->chip_select);
+	__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
+
+	if (spi->mode & SPI_CS_HIGH)
+		bs->cs_polarity |= BIT(spi->chip_select);
+	else
+		bs->cs_polarity &= ~BIT(spi->chip_select);
+
+	reg = __raw_readl(bs->spim_ctrl);
+	reg &= ~BIT(spi->chip_select + SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT);
+	if (spi->mode & SPI_CS_HIGH)
+		reg |= BIT(spi->chip_select + SPIM_CTRL_CS_OVERRIDE_VAL_SHIFT);
+	__raw_writel(reg, bs->spim_ctrl);
+
+	mutex_unlock(&bs->bus_mutex);
+
+	return 0;
+}
+
+static int bcmbca_hsspi_transfer_one(struct spi_master *master,
+				      struct spi_message *msg)
+{
+	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_transfer *t;
+	struct spi_device *spi = msg->spi;
+	int status = -EINVAL;
+	bool keep_cs = false;
+
+	mutex_lock(&bs->msg_mutex);
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		status = bcmbca_hsspi_do_txrx(spi, t, msg);
+		if (status)
+			break;
+
+		spi_transfer_delay_exec(t);
+
+		if (t->cs_change) {
+			if (list_is_last(&t->transfer_list,	&msg->transfers)) {
+				keep_cs = true;
+			} else {
+				if (!t->cs_off)
+					bcmbca_hsspi_set_cs(bs, spi->chip_select, false);
+
+				spi_transfer_cs_change_delay_exec(msg, t);
+
+				if (!list_next_entry(t, transfer_list)->cs_off)
+					bcmbca_hsspi_set_cs(bs, spi->chip_select, true);
+			}
+		} else if (!list_is_last(&t->transfer_list, &msg->transfers) &&
+			   t->cs_off != list_next_entry(t, transfer_list)->cs_off) {
+			bcmbca_hsspi_set_cs(bs, spi->chip_select, t->cs_off);
+		}
+
+		msg->actual_length += t->len;
+	}
+
+	mutex_unlock(&bs->msg_mutex);
+
+	if (status || !keep_cs)
+		bcmbca_hsspi_set_cs(bs, spi->chip_select, false);
+
+	msg->status = status;
+	spi_finalize_current_message(master);
+
+	return 0;
+}
+
+static irqreturn_t bcmbca_hsspi_interrupt(int irq, void *dev_id)
+{
+	struct bcmbca_hsspi *bs = (struct bcmbca_hsspi *)dev_id;
+
+	if (__raw_readl(bs->regs + HSSPI_INT_STATUS_MASKED_REG) == 0)
+		return IRQ_NONE;
+
+	__raw_writel(HSSPI_INT_CLEAR_ALL, bs->regs + HSSPI_INT_STATUS_REG);
+	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
+
+	complete(&bs->done);
+
+	return IRQ_HANDLED;
+}
+
+static int bcmbca_hsspi_probe(struct platform_device *pdev)
+{
+	struct spi_master *master;
+	struct bcmbca_hsspi *bs;
+	struct resource *res_mem;
+	void __iomem *spim_ctrl;
+	void __iomem *regs;
+	struct device *dev = &pdev->dev;
+	struct clk *clk, *pll_clk = NULL;
+	int irq, ret;
+	u32 reg, rate, num_cs = HSSPI_SPI_MAX_CS;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "hsspi");
+	if (!res_mem)
+		return -EINVAL;
+	regs = devm_ioremap_resource(dev, res_mem);
+	if (IS_ERR(regs))
+		return PTR_ERR(regs);
+
+	res_mem = platform_get_resource_byname(pdev, IORESOURCE_MEM, "spim-ctrl");
+	if (!res_mem)
+		return -EINVAL;
+	spim_ctrl = devm_ioremap_resource(dev, res_mem);
+	if (IS_ERR(spim_ctrl))
+		return PTR_ERR(spim_ctrl);
+
+	clk = devm_clk_get(dev, "hsspi");
+	if (IS_ERR(clk))
+		return PTR_ERR(clk);
+
+	ret = clk_prepare_enable(clk);
+	if (ret)
+		return ret;
+
+	rate = clk_get_rate(clk);
+	if (!rate) {
+		pll_clk = devm_clk_get(dev, "pll");
+
+		if (IS_ERR(pll_clk)) {
+			ret = PTR_ERR(pll_clk);
+			goto out_disable_clk;
+		}
+
+		ret = clk_prepare_enable(pll_clk);
+		if (ret)
+			goto out_disable_clk;
+
+		rate = clk_get_rate(pll_clk);
+		if (!rate) {
+			ret = -EINVAL;
+			goto out_disable_pll_clk;
+		}
+	}
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*bs));
+	if (!master) {
+		ret = -ENOMEM;
+		goto out_disable_pll_clk;
+	}
+
+	bs = spi_master_get_devdata(master);
+	bs->pdev = pdev;
+	bs->clk = clk;
+	bs->pll_clk = pll_clk;
+	bs->regs = regs;
+	bs->spim_ctrl = spim_ctrl;
+	bs->speed_hz = rate;
+	bs->fifo = (u8 __iomem *) (bs->regs + HSSPI_FIFO_REG(0));
+	bs->wait_mode = HSSPI_WAIT_MODE_POLLING;
+
+	mutex_init(&bs->bus_mutex);
+	mutex_init(&bs->msg_mutex);
+	init_completion(&bs->done);
+
+	master->dev.of_node = dev->of_node;
+	if (!dev->of_node)
+		master->bus_num = HSSPI_BUS_NUM;
+
+	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
+	if (num_cs > 8) {
+		dev_warn(dev, "unsupported number of cs (%i), reducing to 8\n",
+			 num_cs);
+		num_cs = HSSPI_SPI_MAX_CS;
+	}
+	master->num_chipselect = num_cs;
+	master->setup = bcmbca_hsspi_setup;
+	master->transfer_one_message = bcmbca_hsspi_transfer_one;
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
+	    SPI_RX_DUAL | SPI_TX_DUAL;
+	master->bits_per_word_mask = SPI_BPW_MASK(8);
+	master->auto_runtime_pm = true;
+
+	platform_set_drvdata(pdev, master);
+
+	/* Initialize the hardware */
+	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
+
+	/* clean up any pending interrupts */
+	__raw_writel(HSSPI_INT_CLEAR_ALL, bs->regs + HSSPI_INT_STATUS_REG);
+
+	/* read out default CS polarities */
+	reg = __raw_readl(bs->regs + HSSPI_GLOBAL_CTRL_REG);
+	bs->cs_polarity = reg & GLOBAL_CTRL_CS_POLARITY_MASK;
+	__raw_writel(reg | GLOBAL_CTRL_CLK_GATE_SSOFF,
+		     bs->regs + HSSPI_GLOBAL_CTRL_REG);
+
+	if (irq > 0) {
+		ret = devm_request_irq(dev, irq, bcmbca_hsspi_interrupt, IRQF_SHARED,
+			       pdev->name, bs);
+		if (ret)
+			goto out_put_master;
+	}
+
+	pm_runtime_enable(&pdev->dev);
+
+	if (sysfs_create_group(&pdev->dev.kobj, &bcmbca_hsspi_group)) {
+		dev_err(&pdev->dev, "couldn't register sysfs group\n");
+		goto out_pm_disable;
+	}
+
+	/* register and we are done */
+	ret = devm_spi_register_master(dev, master);
+	if (ret)
+		goto out_sysgroup_disable;
+
+	dev_info(dev, "Broadcom BCMBCA High Speed SPI Controller driver");
+
+	return 0;
+
+out_sysgroup_disable:
+	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
+out_pm_disable:
+	pm_runtime_disable(&pdev->dev);
+out_put_master:
+	spi_master_put(master);
+out_disable_pll_clk:
+	clk_disable_unprepare(pll_clk);
+out_disable_clk:
+	clk_disable_unprepare(clk);
+	return ret;
+}
+
+static int bcmbca_hsspi_remove(struct platform_device *pdev)
+{
+	struct spi_master *master = platform_get_drvdata(pdev);
+	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
+
+	/* reset the hardware and block queue progress */
+	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
+	clk_disable_unprepare(bs->pll_clk);
+	clk_disable_unprepare(bs->clk);
+	sysfs_remove_group(&pdev->dev.kobj, &bcmbca_hsspi_group);
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int bcmbca_hsspi_suspend(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
+
+	spi_master_suspend(master);
+	clk_disable_unprepare(bs->pll_clk);
+	clk_disable_unprepare(bs->clk);
+
+	return 0;
+}
+
+static int bcmbca_hsspi_resume(struct device *dev)
+{
+	struct spi_master *master = dev_get_drvdata(dev);
+	struct bcmbca_hsspi *bs = spi_master_get_devdata(master);
+	int ret;
+
+	ret = clk_prepare_enable(bs->clk);
+	if (ret)
+		return ret;
+
+	if (bs->pll_clk) {
+		ret = clk_prepare_enable(bs->pll_clk);
+		if (ret) {
+			clk_disable_unprepare(bs->clk);
+			return ret;
+		}
+	}
+
+	spi_master_resume(master);
+
+	return 0;
+}
+#endif
+
+static SIMPLE_DEV_PM_OPS(bcmbca_hsspi_pm_ops, bcmbca_hsspi_suspend,
+			 bcmbca_hsspi_resume);
+
+static const struct of_device_id bcmbca_hsspi_of_match[] = {
+	{ .compatible = "brcm,bcmbca-hsspi-v1.1", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, bcmbca_hsspi_of_match);
+
+static struct platform_driver bcmbca_hsspi_driver = {
+	.driver = {
+		   .name = "bcmbca-hsspi",
+		   .pm = &bcmbca_hsspi_pm_ops,
+		   .of_match_table = bcmbca_hsspi_of_match,
+		   },
+	.probe = bcmbca_hsspi_probe,
+	.remove = bcmbca_hsspi_remove,
+};
+
+module_platform_driver(bcmbca_hsspi_driver);
+
+MODULE_ALIAS("platform:bcmbca_hsspi");
+MODULE_DESCRIPTION("Broadcom BCMBCA High Speed SPI Controller driver");
+MODULE_LICENSE("GPL");
-- 
2.37.3

