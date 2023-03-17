Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C2F6BE3CD
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbjCQIhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjCQIgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:36:48 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA47AFF31;
        Fri, 17 Mar 2023 01:36:18 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.35])
        by gateway (Coremail) with SMTP id _____8AxJNgGJRRkz0sNAA--.7639S3;
        Fri, 17 Mar 2023 16:29:58 +0800 (CST)
Received: from user-pc.202.106.0.20 (unknown [10.20.42.35])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxT+T_JBRkaXIDAA--.15924S4;
        Fri, 17 Mar 2023 16:29:58 +0800 (CST)
From:   Yinbo Zhu <zhuyinbo@loongson.cn>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn, Yinbo Zhu <zhuyinbo@loongson.cn>
Subject: [PATCH v2 2/2] spi: loongson: add bus driver for the loongson spi controller
Date:   Fri, 17 Mar 2023 16:29:50 +0800
Message-Id: <20230317082950.12738-3-zhuyinbo@loongson.cn>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230317082950.12738-1-zhuyinbo@loongson.cn>
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxT+T_JBRkaXIDAA--.15924S4
X-CM-SenderInfo: 52kx5xhqerqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjvAXoW3KFWrJFW5XFW7Wry5XF4UXFb_yoW8Wr1DZo
        WxZas8Xr4rur18GFyjqr1Fqry7Xa45WrZ0yrn3A3WkJws8tFyDJr9xJrW7CF48Z3W3JFy3
        AFySgFWrKF4IgFWkn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXasCq-sGcSsGvf
        J3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnRJU
        UUvE1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFV
        AK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2
        z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr
        1l84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAaw2AFwI0_Jrv_JF1le2I262IYc4CY
        6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrV
        C2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE
        7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7
        Cv6cx26rWl4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAq
        x4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r
        43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF
        7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
        W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU
        cPEfUUUUU
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bus driver supports the Loongson spi hardware controller in the
Loongson platforms and supports to use DTS and PCI framework to
register spi device resources.

Signed-off-by: Yinbo Zhu <zhuyinbo@loongson.cn>
---
 MAINTAINERS                |   1 +
 drivers/spi/Kconfig        |  10 +
 drivers/spi/Makefile       |   1 +
 drivers/spi/spi-loongson.c | 459 +++++++++++++++++++++++++++++++++++++
 4 files changed, 471 insertions(+)
 create mode 100644 drivers/spi/spi-loongson.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 9bc2158c735d..22ed8f96d859 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12162,6 +12162,7 @@ M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-spi@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/spi/loongson,ls-spi.yaml
+F:	drivers/spi/spi-loongson.c
 
 LSILOGIC MPT FUSION DRIVERS (FC/SAS/SPI)
 M:	Sathya Prakash <sathya.prakash@broadcom.com>
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index cbf60b6a931c..fce551d2ad10 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -509,6 +509,16 @@ config SPI_LM70_LLP
 	  which interfaces to an LM70 temperature sensor using
 	  a parallel port.
 
+config SPI_LOONGSON
+	tristate "Loongson SPI Controller Support"
+	depends on OF && (LOONGARCH || COMPILE_TEST)
+	help
+	  This bus driver supports the Loongson spi hardware controller in
+	  the Loongson platforms and supports to use DTS and PCI framework
+	  to register spi device resources.
+	  Say Y or M here if you want to use the SPI controller on
+	  Loongson platform.
+
 config SPI_LP8841_RTC
 	tristate "ICP DAS LP-8841 SPI Controller for RTC"
 	depends on MACH_PXA27X_DT || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index d87cf75bee6a..cab3ff6d1814 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_SPI_INTEL_PLATFORM)	+= spi-intel-platform.o
 obj-$(CONFIG_SPI_LANTIQ_SSC)		+= spi-lantiq-ssc.o
 obj-$(CONFIG_SPI_JCORE)			+= spi-jcore.o
 obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
+obj-$(CONFIG_SPI_LOONGSON)		+= spi-loongson.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
 obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
diff --git a/drivers/spi/spi-loongson.c b/drivers/spi/spi-loongson.c
new file mode 100644
index 000000000000..2f4d0ca22a63
--- /dev/null
+++ b/drivers/spi/spi-loongson.c
@@ -0,0 +1,459 @@
+// SPDX-License-Identifier: GPL-2.0+
+// Loongson SPI Support
+// Copyright (C) 2023 Loongson Technology Corporation Limited
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/err.h>
+#include <linux/spi/spi.h>
+#include <linux/pci.h>
+#include <linux/clk.h>
+#include <linux/of.h>
+
+#define	LOONGSON_SPI_SPCR_REG	0x00
+#define	LOONGSON_SPI_SPSR_REG	0x01
+#define	LOONGSON_SPI_FIFO_REG	0x02
+#define	LOONGSON_SPI_SPER_REG	0x03
+#define	LOONGSON_SPI_PARA_REG	0x04
+#define	LOONGSON_SPI_SFCS_REG	0x05
+#define	LOONGSON_SPI_TIMI_REG	0x06
+
+/* Bits definition for Loongson SPI register */
+#define	LOONGSON_SPI_PARA_MEM_EN	BIT(0)
+#define	LOONGSON_SPI_SPSR_SPIF	BIT(7)
+#define	LOONGSON_SPI_SPSR_WCOL	BIT(6)
+#define	LOONGSON_SPI_SPCR_SPE	BIT(6)
+
+#define SPI_COMPLETION_TIMEOUT	msecs_to_jiffies(2000)
+
+struct loongson_spi {
+	spinlock_t              lock;
+	struct	spi_master	*master;
+	void __iomem		*base;
+	int			cs_active;
+	unsigned int		hz;
+	unsigned char		spcr;
+	unsigned char		sper;
+	unsigned char		spsr;
+	unsigned char		para;
+	unsigned char		sfcs;
+	unsigned char		timi;
+	unsigned int		mode;
+	u64			clk_rate;
+};
+
+static inline void loongson_spi_write_reg(struct loongson_spi *spi, unsigned char reg,
+					  unsigned char data)
+{
+	writeb(data, spi->base + reg);
+}
+
+static inline char loongson_spi_read_reg(struct loongson_spi *spi, unsigned char reg)
+{
+	return readb(spi->base + reg);
+}
+
+static void loongson_spi_set_cs(struct spi_device *spi, bool val)
+{
+	int cs;
+	struct loongson_spi *loongson_spi = spi_master_get_devdata(spi->master);
+
+	if (loongson_spi->mode & SPI_NO_CS)
+		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, 0);
+	else {
+		cs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG)
+					   & ~(0x11 << spi->chip_select);
+		loongson_spi_write_reg(loongson_spi,
+				       LOONGSON_SPI_SFCS_REG,
+				       (val ? (0x11 << spi->chip_select) :
+				       (0x1 << spi->chip_select)) | cs);
+	}
+}
+
+static int loongson_spi_update_state(struct loongson_spi *loongson_spi,
+				     struct spi_device *spi, struct spi_transfer *t)
+{
+	unsigned int hz;
+	unsigned int div, div_tmp;
+	unsigned int bit;
+	unsigned char val;
+	const char rdiv[12] = {0, 1, 4, 2, 3, 5, 6, 7, 8, 9, 10, 11};
+
+	if (t)
+		hz = t->speed_hz;
+
+	if ((hz && loongson_spi->hz != hz) ||
+	    ((spi->mode ^ loongson_spi->mode) & (SPI_CPOL | SPI_CPHA))) {
+		div = DIV_ROUND_UP(loongson_spi->clk_rate, hz);
+		if (div < 2)
+			div = 2;
+		if (div > 4096)
+			div = 4096;
+
+		bit = fls(div) - 1;
+		if ((1<<bit) == div)
+			bit--;
+		div_tmp = rdiv[bit];
+		dev_dbg(&spi->dev, "clk_rate = %llu hz = %d div_tmp = %d bit = %d\n",
+			loongson_spi->clk_rate, hz, div_tmp, bit);
+
+		loongson_spi->hz = hz;
+		loongson_spi->spcr = div_tmp & 3;
+		loongson_spi->sper = (div_tmp >> 2) & 3;
+		val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
+		val &= ~0xc;
+		if (spi->mode & SPI_CPOL)
+			val |= 8;
+		if (spi->mode & SPI_CPHA)
+			val |= 4;
+
+		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, (val & ~3) |
+				       loongson_spi->spcr);
+		val = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
+		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, (val & ~3) |
+				       loongson_spi->sper);
+		loongson_spi->mode &= SPI_NO_CS;
+		loongson_spi->mode |= spi->mode;
+	}
+
+	return 0;
+}
+
+static int loongson_spi_setup(struct spi_device *spi)
+{
+	struct loongson_spi *loongson_spi;
+
+	loongson_spi = spi_master_get_devdata(spi->master);
+	if (spi->bits_per_word % 8)
+		return -EINVAL;
+
+	if (spi->chip_select >= spi->master->num_chipselect)
+		return -EINVAL;
+
+	spin_lock(&loongson_spi->lock);
+	loongson_spi_update_state(loongson_spi, spi, NULL);
+	loongson_spi_set_cs(spi, 1);
+	spin_unlock(&loongson_spi->lock);
+
+	return 0;
+}
+
+static int loongson_spi_write_read_8bit(struct spi_device *spi, const u8 **tx_buf,
+					u8 **rx_buf, unsigned int num)
+{
+	struct loongson_spi *loongson_spi = spi_master_get_devdata(spi->master);
+	unsigned long timeout = jiffies + SPI_COMPLETION_TIMEOUT;
+
+	if (tx_buf && *tx_buf) {
+		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, *((*tx_buf)++));
+		while ((loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG) & 0x1) == 1 &&
+			time_after(timeout, jiffies))
+			cpu_relax();
+	} else {
+		loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_FIFO_REG, 0);
+		while ((loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG) & 0x1) == 1 &&
+			time_after(timeout, jiffies))
+			cpu_relax();
+	}
+
+	if (rx_buf && *rx_buf)
+		*(*rx_buf)++ = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
+	else
+		loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_FIFO_REG);
+
+	return 0;
+}
+
+static unsigned int loongson_spi_write_read(struct spi_device *spi, struct spi_transfer *xfer)
+{
+	unsigned int count;
+	const u8 *tx = xfer->tx_buf;
+	u8 *rx = xfer->rx_buf;
+
+	count = xfer->len;
+
+	do {
+		if (loongson_spi_write_read_8bit(spi, &tx, &rx, count) < 0)
+			goto out;
+		count--;
+	} while (count);
+
+out:
+	return xfer->len - count;
+}
+
+static int loongson_spi_prepare_message(struct spi_controller *ctlr, struct spi_message *m)
+{
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctlr);
+
+	loongson_spi->para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para & ~1);
+
+	return 0;
+}
+
+static int loongson_spi_transfer_one(struct spi_controller *ctrl, struct spi_device *spi,
+				     struct spi_transfer *xfer)
+{
+	struct loongson_spi *loongson_spi = spi_master_get_devdata(spi->master);
+
+	loongson_spi_update_state(loongson_spi, spi, xfer);
+	if (xfer->len)
+		xfer->len = loongson_spi_write_read(spi, xfer);
+
+	return 0;
+}
+
+static int loongson_spi_unprepare_message(struct spi_controller *ctrl, struct spi_message *m)
+{
+	struct loongson_spi *loongson_spi = spi_controller_get_devdata(ctrl);
+
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para);
+
+	return 0;
+}
+
+static void loongson_spi_reginit(struct loongson_spi *loongson_spi_dev)
+{
+	unsigned char val;
+
+	val = loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG);
+	val &= ~LOONGSON_SPI_SPCR_SPE;
+	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
+
+	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPSR_REG,
+			       (LOONGSON_SPI_SPSR_SPIF | LOONGSON_SPI_SPSR_WCOL));
+
+	val = loongson_spi_read_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG);
+	val |= LOONGSON_SPI_SPCR_SPE;
+	loongson_spi_write_reg(loongson_spi_dev, LOONGSON_SPI_SPCR_REG, val);
+}
+
+static int loongson_spi_init_master(struct device *dev, struct resource *res)
+{
+	struct spi_master *master;
+	struct loongson_spi *spi;
+	struct clk *clk;
+	int ret;
+
+	master = spi_alloc_master(dev, sizeof(struct loongson_spi));
+	if (master == NULL) {
+		dev_dbg(dev, "master allocation failed\n");
+		return -ENOMEM;
+	}
+
+	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH;
+	master->setup = loongson_spi_setup;
+	master->prepare_message = loongson_spi_prepare_message;
+	master->transfer_one = loongson_spi_transfer_one;
+	master->unprepare_message = loongson_spi_unprepare_message;
+	master->set_cs = loongson_spi_set_cs;
+	master->num_chipselect = 4;
+	master->dev.of_node = of_node_get(dev->of_node);
+	dev_set_drvdata(dev, master);
+
+	spi = spi_master_get_devdata(master);
+
+	spi->master = master;
+
+	spi->base = devm_ioremap(dev, res->start, resource_size(res));
+	if (spi->base == NULL) {
+		dev_err(dev, "cannot map io\n");
+		ret = -ENXIO;
+		goto free_master;
+	}
+
+	clk = devm_clk_get(dev, NULL);
+	if (!IS_ERR(clk))
+		spi->clk_rate = clk_get_rate(clk);
+
+	loongson_spi_reginit(spi);
+
+	spi->mode = 0;
+	if (of_get_property(dev->of_node, "spi-nocs", NULL))
+		spi->mode |= SPI_NO_CS;
+
+	spin_lock_init(&spi->lock);
+
+	ret = spi_register_master(master);
+	if (ret < 0)
+		goto free_master;
+
+	return ret;
+
+free_master:
+	kfree(master);
+	spi_master_put(master);
+
+	return ret;
+}
+
+static int loongson_spi_platform_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct resource *res;
+	int ret;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (res == NULL) {
+		dev_err(dev, "cannot get io resource memory\n");
+		return -ENOENT;
+	}
+
+	ret = loongson_spi_init_master(dev, res);
+	if (ret)
+		dev_err(dev, "failed to initialize master\n");
+
+	return ret;
+}
+
+static int __maybe_unused loongson_spi_suspend(struct device *dev)
+{
+	struct loongson_spi *loongson_spi;
+	struct spi_master *master;
+
+	master = dev_get_drvdata(dev);
+	loongson_spi = spi_master_get_devdata(master);
+
+	loongson_spi->spcr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPCR_REG);
+	loongson_spi->sper = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPER_REG);
+	loongson_spi->spsr = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SPSR_REG);
+	loongson_spi->para = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_PARA_REG);
+	loongson_spi->sfcs = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_SFCS_REG);
+	loongson_spi->timi = loongson_spi_read_reg(loongson_spi, LOONGSON_SPI_TIMI_REG);
+
+	return 0;
+}
+
+static int __maybe_unused loongson_spi_resume(struct device *dev)
+{
+	struct loongson_spi *loongson_spi;
+	struct spi_master *master;
+
+	master = dev_get_drvdata(dev);
+	loongson_spi = spi_master_get_devdata(master);
+
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPCR_REG, loongson_spi->spcr);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPER_REG, loongson_spi->sper);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SPSR_REG, loongson_spi->spsr);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_PARA_REG, loongson_spi->para);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_SFCS_REG, loongson_spi->sfcs);
+	loongson_spi_write_reg(loongson_spi, LOONGSON_SPI_TIMI_REG, loongson_spi->timi);
+
+	return 0;
+}
+
+static const struct dev_pm_ops loongson_spi_dev_pm_ops = {
+	.suspend = loongson_spi_suspend,
+	.resume = loongson_spi_resume,
+};
+
+static const struct of_device_id loongson_spi_id_table[] = {
+	{ .compatible = "loongson,ls2k-spi", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, loongson_spi_id_table);
+
+static struct platform_driver loongson_spi_driver = {
+	.probe = loongson_spi_platform_probe,
+	.driver	= {
+		.name	= "loongson-spi",
+		.owner	= THIS_MODULE,
+		.bus = &platform_bus_type,
+		.pm = &loongson_spi_dev_pm_ops,
+		.of_match_table = loongson_spi_id_table,
+	},
+};
+
+#ifdef CONFIG_PCI
+static int loongson_spi_pci_register(struct pci_dev *pdev,
+			const struct pci_device_id *ent)
+{
+	int ret;
+	unsigned char v8;
+	struct resource res[2];
+	struct device *dev = &pdev->dev;
+
+	ret = pci_enable_device(pdev);
+	if (ret < 0) {
+		dev_err(dev, "cannot enable pci device\n");
+		goto err_out;
+	}
+
+	ret = pci_request_region(pdev, 0, "loongson-spi io");
+	if (ret < 0) {
+		dev_err(dev, "cannot request region 0.\n");
+		goto err_out;
+	}
+
+	res[0].start = pci_resource_start(pdev, 0);
+	res[0].end = pci_resource_end(pdev, 0);
+	ret = pci_read_config_byte(pdev, PCI_INTERRUPT_LINE, &v8);
+
+	if (ret == PCIBIOS_SUCCESSFUL) {
+		res[1].start = v8;
+		res[1].end = v8;
+	}
+
+	ret = loongson_spi_init_master(dev, res);
+	if (ret)
+		dev_err(dev, "failed to initialize master\n");
+
+err_out:
+	return ret;
+}
+
+static void loongson_spi_pci_unregister(struct pci_dev *pdev)
+{
+	pci_release_region(pdev, 0);
+}
+
+static struct pci_device_id loongson_spi_devices[] = {
+	{PCI_DEVICE(0x14, 0x7a0b)},
+	{PCI_DEVICE(0x14, 0x7a1b)},
+	{0, 0, 0, 0, 0, 0, 0}
+};
+MODULE_DEVICE_TABLE(pci, loongson_spi_devices);
+
+static struct pci_driver loongson_spi_pci_driver = {
+	.name       = "loongson-spi-pci",
+	.id_table   = loongson_spi_devices,
+	.probe      = loongson_spi_pci_register,
+	.remove     = loongson_spi_pci_unregister,
+};
+#endif
+
+static int __init loongson_spi_init(void)
+{
+	int ret;
+
+	ret = platform_driver_register(&loongson_spi_driver);
+	if (ret)
+		return ret;
+#ifdef CONFIG_PCI
+	ret = pci_register_driver(&loongson_spi_pci_driver);
+	if (ret) {
+		platform_driver_unregister(&loongson_spi_driver);
+		return ret;
+	}
+#endif
+	return 0;
+}
+
+static void __exit loongson_spi_exit(void)
+{
+	platform_driver_unregister(&loongson_spi_driver);
+#ifdef CONFIG_PCI
+	pci_unregister_driver(&loongson_spi_pci_driver);
+#endif
+}
+
+module_init(loongson_spi_init);
+module_exit(loongson_spi_exit);
+
+MODULE_DESCRIPTION("Loongson spi driver");
+MODULE_LICENSE("GPL");
-- 
2.20.1

