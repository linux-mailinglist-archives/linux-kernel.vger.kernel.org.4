Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E17E6CB073
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 23:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjC0VOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 17:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbjC0VOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 17:14:42 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D051707;
        Mon, 27 Mar 2023 14:14:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 54EE65FD0F;
        Tue, 28 Mar 2023 00:14:37 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1679951677;
        bh=h7KZsDqVPD+r3V88SPhZSFC8IrVx/na/cPa72ZDRYXc=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=XH/zQ8XiIYaxHRBw85FlcuAFzktlw8duPMtaAImoIiOpo8mL4kfB/jjo0kwO+dRpo
         cw/vkvdEqYs5820uVlHu1VR++K511C3okTA95POIzR26zwiTwF65nfWstuTH5v0hsV
         dZsJ+t9r39xggayv0rppK2YLRKlk5fmNWpINUTDQ0j+teTXu4j8MrfSAgUUViiQ1Jd
         mKAfoZo5YJgxq3jH9L1dJcGQve2PqCggXsQT8xEGEwRq0IjmeLGZa5VTZY2lyvWc8M
         QhZMQ0qeT/dxmXXcppEUPiq81F9w9/ciJQqTgnwmMgenznz642gaUGxGd/LOgJh8FE
         +6B8fJKvCHeWw==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Tue, 28 Mar 2023 00:14:37 +0300 (MSK)
From:   Martin Kurbanov <mmkurbanov@sberdevices.ru>
To:     Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@sberdevices.ru>,
        Martin Kurbanov <mmkurbanov@sberdevices.ru>
Subject: [PATCH v2 2/2] spi: add support for Meson A1 SPI Flash Controller
Date:   Tue, 28 Mar 2023 00:13:51 +0300
Message-ID: <20230327211351.686831-3-mmkurbanov@sberdevices.ru>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327211351.686831-1-mmkurbanov@sberdevices.ru>
References: <20230327211351.686831-1-mmkurbanov@sberdevices.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH02.sberdevices.ru (172.16.1.5) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/03/27 19:06:00 #21018749
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a driver for the Amlogic Meson SPI flash controller support
on A113L SoC.

Signed-off-by: Martin Kurbanov <mmkurbanov@sberdevices.ru>
---
 drivers/spi/Kconfig              |   7 +
 drivers/spi/Makefile             |   1 +
 drivers/spi/spi-meson-spifc-a1.c | 453 +++++++++++++++++++++++++++++++
 3 files changed, 461 insertions(+)
 create mode 100644 drivers/spi/spi-meson-spifc-a1.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 3b1c0878bb85..80ec01dbe7c1 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -582,6 +582,13 @@ config SPI_MESON_SPIFC
 	  This enables master mode support for the SPIFC (SPI flash
 	  controller) available in Amlogic Meson SoCs.
 
+config SPI_MESON_SPIFC_A1
+	tristate "Amlogic Meson A1 SPIFC controller"
+	depends on ARCH_MESON || COMPILE_TEST
+	help
+	  This enables master mode support for the SPIFC (SPI flash
+	  controller) available in Amlogic Meson A1 (A113L SoC).
+
 config SPI_MICROCHIP_CORE
 	tristate "Microchip FPGA SPI controllers"
 	depends on SPI_MASTER
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index be9ba40ef8d0..702053970967 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_SPI_LM70_LLP)		+= spi-lm70llp.o
 obj-$(CONFIG_SPI_LP8841_RTC)		+= spi-lp8841-rtc.o
 obj-$(CONFIG_SPI_MESON_SPICC)		+= spi-meson-spicc.o
 obj-$(CONFIG_SPI_MESON_SPIFC)		+= spi-meson-spifc.o
+obj-$(CONFIG_SPI_MESON_SPIFC_A1)	+= spi-meson-spifc-a1.o
 obj-$(CONFIG_SPI_MICROCHIP_CORE)	+= spi-microchip-core.o
 obj-$(CONFIG_SPI_MICROCHIP_CORE_QSPI)	+= spi-microchip-core-qspi.o
 obj-$(CONFIG_SPI_MPC512x_PSC)		+= spi-mpc512x-psc.o
diff --git a/drivers/spi/spi-meson-spifc-a1.c b/drivers/spi/spi-meson-spifc-a1.c
new file mode 100644
index 000000000000..9fecf0a71bef
--- /dev/null
+++ b/drivers/spi/spi-meson-spifc-a1.c
@@ -0,0 +1,453 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for Amlogic Meson A1 SPI flash controller (SPIFC)
+ *
+ * Copyright (c) 2023, SberDevices. All Rights Reserved.
+ *
+ * Author: Martin Kurbanov <mmkurbanov@sberdevices.ru>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi-mem.h>
+#include <linux/types.h>
+
+#define SPIFC_A1_AHB_CTRL_REG		0x0
+#define SPIFC_A1_AHB_BUS_EN		BIT(31)
+
+#define SPIFC_A1_USER_CTRL0_REG		0x200
+#define SPIFC_A1_USER_REQUEST_ENABLE	BIT(31)
+#define SPIFC_A1_USER_REQUEST_FINISH	BIT(30)
+#define SPIFC_A1_USER_DATA_UPDATED	BIT(0)
+
+#define SPIFC_A1_USER_CTRL1_REG		0x204
+#define SPIFC_A1_USER_CMD_ENABLE	BIT(30)
+#define SPIFC_A1_USER_CMD_MODE		GENMASK(29, 28)
+#define SPIFC_A1_USER_CMD_CODE		GENMASK(27, 20)
+#define SPIFC_A1_USER_ADDR_ENABLE	BIT(19)
+#define SPIFC_A1_USER_ADDR_MODE		GENMASK(18, 17)
+#define SPIFC_A1_USER_ADDR_BYTES	GENMASK(16, 15)
+#define SPIFC_A1_USER_DOUT_ENABLE	BIT(14)
+#define SPIFC_A1_USER_DOUT_MODE		GENMASK(11, 10)
+#define SPIFC_A1_USER_DOUT_BYTES	GENMASK(9, 0)
+
+#define SPIFC_A1_USER_CTRL2_REG		0x208
+#define SPIFC_A1_USER_DUMMY_ENABLE	BIT(31)
+#define SPIFC_A1_USER_DUMMY_MODE	GENMASK(30, 29)
+#define SPIFC_A1_USER_DUMMY_CLK_SYCLES	GENMASK(28, 23)
+
+#define SPIFC_A1_USER_CTRL3_REG		0x20c
+#define SPIFC_A1_USER_DIN_ENABLE	BIT(31)
+#define SPIFC_A1_USER_DIN_MODE		GENMASK(28, 27)
+#define SPIFC_A1_USER_DIN_BYTES		GENMASK(25, 16)
+
+#define SPIFC_A1_USER_ADDR_REG		0x210
+
+#define SPIFC_A1_AHB_REQ_CTRL_REG	0x214
+#define SPIFC_A1_AHB_REQ_ENABLE		BIT(31)
+
+#define SPIFC_A1_ACTIMING0_REG		(0x0088 << 2)
+#define SPIFC_A1_TSLCH			GENMASK(31, 30)
+#define SPIFC_A1_TCLSH			GENMASK(29, 28)
+#define SPIFC_A1_TSHWL			GENMASK(20, 16)
+#define SPIFC_A1_TSHSL2			GENMASK(15, 12)
+#define SPIFC_A1_TSHSL1			GENMASK(11, 8)
+#define SPIFC_A1_TWHSL			GENMASK(7, 0)
+
+#define SPIFC_A1_DBUF_CTRL_REG		0x240
+#define SPIFC_A1_DBUF_DIR		BIT(31)
+#define SPIFC_A1_DBUF_AUTO_UPDATE_ADDR	BIT(30)
+#define SPIFC_A1_DBUF_ADDR		GENMASK(7, 0)
+
+#define SPIFC_A1_DBUF_DATA_REG		0x244
+
+#define SPIFC_A1_USER_DBUF_ADDR_REG	0x248
+
+#define SPIFC_A1_BUFFER_SIZE		512
+
+#define SPIFC_A1_MAX_HZ			200000000
+#define SPIFC_A1_MIN_HZ			1000000
+
+#define SPIFC_A1_USER_CMD(op) ( \
+	SPIFC_A1_USER_CMD_ENABLE | \
+	FIELD_PREP(SPIFC_A1_USER_CMD_CODE, (op)->cmd.opcode) | \
+	FIELD_PREP(SPIFC_A1_USER_CMD_MODE, ilog2((op)->cmd.buswidth)))
+
+#define SPIFC_A1_USER_ADDR(op) ( \
+	SPIFC_A1_USER_ADDR_ENABLE | \
+	FIELD_PREP(SPIFC_A1_USER_ADDR_MODE, ilog2((op)->addr.buswidth)) | \
+	FIELD_PREP(SPIFC_A1_USER_ADDR_BYTES, (op)->addr.nbytes - 1))
+
+#define SPIFC_A1_USER_DUMMY(op) ( \
+	SPIFC_A1_USER_DUMMY_ENABLE | \
+	FIELD_PREP(SPIFC_A1_USER_DUMMY_MODE, ilog2((op)->dummy.buswidth)) | \
+	FIELD_PREP(SPIFC_A1_USER_DUMMY_CLK_SYCLES, (op)->dummy.nbytes << 3))
+
+#define SPIFC_A1_TSLCH_VAL	FIELD_PREP(SPIFC_A1_TSLCH, 1)
+#define SPIFC_A1_TCLSH_VAL	FIELD_PREP(SPIFC_A1_TCLSH, 1)
+#define SPIFC_A1_TSHWL_VAL	FIELD_PREP(SPIFC_A1_TSHWL, 7)
+#define SPIFC_A1_TSHSL2_VAL	FIELD_PREP(SPIFC_A1_TSHSL2, 7)
+#define SPIFC_A1_TSHSL1_VAL	FIELD_PREP(SPIFC_A1_TSHSL1, 7)
+#define SPIFC_A1_TWHSL_VAL	FIELD_PREP(SPIFC_A1_TWHSL, 2)
+#define SPIFC_A1_ACTIMING0_VAL	(SPIFC_A1_TSLCH_VAL | SPIFC_A1_TCLSH_VAL | \
+				 SPIFC_A1_TSHWL_VAL | SPIFC_A1_TSHSL2_VAL | \
+				 SPIFC_A1_TSHSL1_VAL | SPIFC_A1_TWHSL_VAL)
+
+struct meson_spifc_a1 {
+	struct spi_controller *ctrl;
+	struct clk *clk;
+	struct device *dev;
+	void __iomem *base;
+};
+
+static int meson_spifc_a1_request(struct meson_spifc_a1 *spifc, bool read)
+{
+	u32 mask = SPIFC_A1_USER_REQUEST_FINISH |
+		   (read ? SPIFC_A1_USER_DATA_UPDATED : 0);
+	u32 val;
+
+	writel(SPIFC_A1_USER_REQUEST_ENABLE,
+	       spifc->base + SPIFC_A1_USER_CTRL0_REG);
+
+	return readl_poll_timeout(spifc->base + SPIFC_A1_USER_CTRL0_REG,
+				  val, (val & mask) == mask, 0,
+				  200 * USEC_PER_MSEC);
+}
+
+static void meson_spifc_a1_drain_buffer(struct meson_spifc_a1 *spifc,
+					char *buf, u32 len)
+{
+	u32 data;
+	const u32 count = len / sizeof(data);
+	const u32 pad = len % sizeof(data);
+
+	writel(SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
+	       spifc->base + SPIFC_A1_DBUF_CTRL_REG);
+	ioread32_rep(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
+
+	if (pad) {
+		data = readl(spifc->base + SPIFC_A1_DBUF_DATA_REG);
+		memcpy(buf + len - pad, &data, pad);
+	}
+}
+
+static void meson_spifc_a1_fill_buffer(struct meson_spifc_a1 *spifc,
+				       const char *buf, u32 len)
+{
+	u32 data;
+	const u32 count = len / sizeof(data);
+	const u32 pad = len % sizeof(data);
+
+	writel(SPIFC_A1_DBUF_DIR | SPIFC_A1_DBUF_AUTO_UPDATE_ADDR,
+	       spifc->base + SPIFC_A1_DBUF_CTRL_REG);
+	iowrite32_rep(spifc->base + SPIFC_A1_DBUF_DATA_REG, buf, count);
+
+	if (pad) {
+		memcpy(&data, buf + len - pad, pad);
+		writel(data, spifc->base + SPIFC_A1_DBUF_DATA_REG);
+	}
+}
+
+static void meson_spifc_a1_user_init(struct meson_spifc_a1 *spifc)
+{
+	writel(0, spifc->base + SPIFC_A1_USER_CTRL0_REG);
+	writel(0, spifc->base + SPIFC_A1_USER_CTRL1_REG);
+	writel(0, spifc->base + SPIFC_A1_USER_CTRL2_REG);
+	writel(0, spifc->base + SPIFC_A1_USER_CTRL3_REG);
+}
+
+static void meson_spifc_a1_set_cmd(struct meson_spifc_a1 *spifc, u32 cmd_cfg)
+{
+	u32 val;
+
+	val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
+	val &= ~(SPIFC_A1_USER_CMD_MODE | SPIFC_A1_USER_CMD_CODE);
+	val |= cmd_cfg;
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
+}
+
+static void meson_spifc_a1_set_addr(struct meson_spifc_a1 *spifc, u32 addr,
+				    u32 addr_cfg)
+{
+	u32 val;
+
+	writel(addr, spifc->base + SPIFC_A1_USER_ADDR_REG);
+
+	val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
+	val &= ~(SPIFC_A1_USER_ADDR_MODE | SPIFC_A1_USER_ADDR_BYTES);
+	val |= addr_cfg;
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
+}
+
+static void meson_spifc_a1_set_dummy(struct meson_spifc_a1 *spifc,
+				     u32 dummy_cfg)
+{
+	u32 val = readl(spifc->base + SPIFC_A1_USER_CTRL2_REG);
+
+	val &= ~(SPIFC_A1_USER_DUMMY_MODE | SPIFC_A1_USER_DUMMY_CLK_SYCLES);
+	val |= dummy_cfg;
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL2_REG);
+}
+
+static int meson_spifc_a1_read(struct meson_spifc_a1 *spifc, void *buf,
+			       u32 size, u32 mode)
+{
+	u32 val = readl(spifc->base + SPIFC_A1_USER_CTRL3_REG);
+	int ret;
+
+	val &= ~(SPIFC_A1_USER_DIN_MODE | SPIFC_A1_USER_DIN_BYTES);
+	val |= SPIFC_A1_USER_DIN_ENABLE;
+	val |= FIELD_PREP(SPIFC_A1_USER_DIN_MODE, mode);
+	val |= FIELD_PREP(SPIFC_A1_USER_DIN_BYTES, size);
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL3_REG);
+
+	ret = meson_spifc_a1_request(spifc, true);
+	if (!ret)
+		meson_spifc_a1_drain_buffer(spifc, buf, size);
+
+	return ret;
+}
+
+static int meson_spifc_a1_write(struct meson_spifc_a1 *spifc, const void *buf,
+				u32 size, u32 mode)
+{
+	u32 val;
+
+	meson_spifc_a1_fill_buffer(spifc, buf, size);
+
+	val = readl(spifc->base + SPIFC_A1_USER_CTRL1_REG);
+	val &= ~(SPIFC_A1_USER_DOUT_MODE | SPIFC_A1_USER_DOUT_BYTES);
+	val |= FIELD_PREP(SPIFC_A1_USER_DOUT_MODE, mode);
+	val |= FIELD_PREP(SPIFC_A1_USER_DOUT_BYTES, size);
+	val |= SPIFC_A1_USER_DOUT_ENABLE;
+	writel(val, spifc->base + SPIFC_A1_USER_CTRL1_REG);
+
+	return meson_spifc_a1_request(spifc, false);
+}
+
+static int meson_spifc_a1_exec_op(struct spi_mem *mem,
+				  const struct spi_mem_op *op)
+{
+	struct meson_spifc_a1 *spifc =
+		spi_controller_get_devdata(mem->spi->controller);
+	size_t off, nbytes = op->data.nbytes;
+	u32 cmd_cfg, addr_cfg, dummy_cfg, dmode;
+	int ret;
+
+	meson_spifc_a1_user_init(spifc);
+
+	cmd_cfg = SPIFC_A1_USER_CMD(op);
+	meson_spifc_a1_set_cmd(spifc, cmd_cfg);
+
+	if (op->addr.nbytes) {
+		addr_cfg = SPIFC_A1_USER_ADDR(op);
+		meson_spifc_a1_set_addr(spifc, op->addr.val, addr_cfg);
+	}
+
+	if (op->dummy.nbytes) {
+		dummy_cfg = SPIFC_A1_USER_DUMMY(op);
+		meson_spifc_a1_set_dummy(spifc, dummy_cfg);
+	}
+
+	if (!op->data.nbytes)
+		return meson_spifc_a1_request(spifc, false);
+
+	dmode = ilog2(op->data.buswidth);
+	off = 0;
+
+	do {
+		size_t block_size = min_t(size_t, nbytes, SPIFC_A1_BUFFER_SIZE);
+
+		meson_spifc_a1_set_cmd(spifc, cmd_cfg);
+
+		if (op->addr.nbytes)
+			meson_spifc_a1_set_addr(spifc, op->addr.val + off,
+						addr_cfg);
+
+		if (op->dummy.nbytes)
+			meson_spifc_a1_set_dummy(spifc, dummy_cfg);
+
+		writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
+
+		if (op->data.dir == SPI_MEM_DATA_IN)
+			ret = meson_spifc_a1_read(spifc, op->data.buf.in + off,
+						  block_size, dmode);
+		else
+			ret = meson_spifc_a1_write(spifc,
+						   op->data.buf.out + off,
+						   block_size, dmode);
+
+		nbytes -= block_size;
+		off += block_size;
+	} while (nbytes != 0 && !ret);
+
+	return ret;
+}
+
+static void meson_spifc_a1_hw_init(struct meson_spifc_a1 *spifc)
+{
+	u32 regv;
+
+	regv = readl(spifc->base + SPIFC_A1_AHB_REQ_CTRL_REG);
+	regv &= ~(SPIFC_A1_AHB_REQ_ENABLE);
+	writel(regv, spifc->base + SPIFC_A1_AHB_REQ_CTRL_REG);
+
+	regv = readl(spifc->base + SPIFC_A1_AHB_CTRL_REG);
+	regv &= ~(SPIFC_A1_AHB_BUS_EN);
+	writel(regv, spifc->base + SPIFC_A1_AHB_CTRL_REG);
+
+	writel(SPIFC_A1_ACTIMING0_VAL, spifc->base + SPIFC_A1_ACTIMING0_REG);
+
+	writel(0, spifc->base + SPIFC_A1_USER_DBUF_ADDR_REG);
+}
+
+static const struct spi_controller_mem_ops meson_spifc_a1_mem_ops = {
+	.exec_op = meson_spifc_a1_exec_op,
+};
+
+static int meson_spifc_a1_probe(struct platform_device *pdev)
+{
+	struct spi_controller *ctrl;
+	struct meson_spifc_a1 *spifc;
+	int ret;
+
+	ctrl = devm_spi_alloc_master(&pdev->dev, sizeof(*spifc));
+	if (!ctrl)
+		return -ENOMEM;
+
+	spifc = spi_controller_get_devdata(ctrl);
+	platform_set_drvdata(pdev, spifc);
+
+	spifc->dev = &pdev->dev;
+	spifc->ctrl = ctrl;
+
+	spifc->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(spifc->base))
+		return PTR_ERR(spifc->base);
+
+	spifc->clk = devm_clk_get_enabled(spifc->dev, NULL);
+	if (IS_ERR(spifc->clk))
+		return dev_err_probe(spifc->dev, PTR_ERR(spifc->clk),
+				     "unable to get clock\n");
+
+	meson_spifc_a1_hw_init(spifc);
+
+	pm_runtime_set_autosuspend_delay(spifc->dev, 500);
+	pm_runtime_use_autosuspend(spifc->dev);
+	devm_pm_runtime_enable(spifc->dev);
+
+	ctrl->num_chipselect = 1;
+	ctrl->dev.of_node = pdev->dev.of_node;
+	ctrl->bits_per_word_mask = SPI_BPW_MASK(8);
+	ctrl->auto_runtime_pm = true;
+	ctrl->mem_ops = &meson_spifc_a1_mem_ops;
+	ctrl->min_speed_hz = SPIFC_A1_MIN_HZ;
+	ctrl->max_speed_hz = SPIFC_A1_MAX_HZ;
+	ctrl->mode_bits = (SPI_RX_DUAL | SPI_TX_DUAL |
+			   SPI_RX_QUAD | SPI_TX_QUAD);
+
+	ret = devm_spi_register_controller(spifc->dev, ctrl);
+	if (ret)
+		return dev_err_probe(spifc->dev, ret,
+				     "failed to register spi controller\n");
+
+	return 0;
+}
+
+#ifdef CONFIG_PM_SLEEP
+static int meson_spifc_a1_suspend(struct device *dev)
+{
+	struct meson_spifc_a1 *spifc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = spi_controller_suspend(spifc->ctrl);
+	if (ret)
+		return ret;
+
+	if (!pm_runtime_suspended(dev))
+		clk_disable_unprepare(spifc->clk);
+
+	return 0;
+}
+
+static int meson_spifc_a1_resume(struct device *dev)
+{
+	struct meson_spifc_a1 *spifc = dev_get_drvdata(dev);
+	int ret = 0;
+
+	if (!pm_runtime_suspended(dev)) {
+		ret = clk_prepare_enable(spifc->clk);
+		if (ret)
+			return ret;
+	}
+
+	meson_spifc_a1_hw_init(spifc);
+
+	ret = spi_controller_resume(spifc->ctrl);
+	if (ret)
+		clk_disable_unprepare(spifc->clk);
+
+	return ret;
+}
+#endif /* CONFIG_PM_SLEEP */
+
+#ifdef CONFIG_PM
+static int meson_spifc_a1_runtime_suspend(struct device *dev)
+{
+	struct meson_spifc_a1 *spifc = dev_get_drvdata(dev);
+
+	clk_disable_unprepare(spifc->clk);
+
+	return 0;
+}
+
+static int meson_spifc_a1_runtime_resume(struct device *dev)
+{
+	struct meson_spifc_a1 *spifc = dev_get_drvdata(dev);
+	int ret;
+
+	ret = clk_prepare_enable(spifc->clk);
+	if (!ret)
+		meson_spifc_a1_hw_init(spifc);
+
+	return ret;
+}
+#endif /* CONFIG_PM */
+
+static const struct dev_pm_ops meson_spifc_a1_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(meson_spifc_a1_suspend, meson_spifc_a1_resume)
+	SET_RUNTIME_PM_OPS(meson_spifc_a1_runtime_suspend,
+			   meson_spifc_a1_runtime_resume,
+			   NULL)
+};
+
+#ifdef CONFIG_OF
+static const struct of_device_id meson_spifc_a1_dt_match[] = {
+	{ .compatible = "amlogic,meson-a1-spifc", },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, meson_spifc_a1_dt_match);
+#endif /* CONFIG_OF */
+
+static struct platform_driver meson_spifc_a1_driver = {
+	.probe	= meson_spifc_a1_probe,
+	.driver	= {
+		.name		= "meson-spifc-a1",
+		.of_match_table	= of_match_ptr(meson_spifc_a1_dt_match),
+		.pm		= &meson_spifc_a1_pm_ops,
+	},
+};
+module_platform_driver(meson_spifc_a1_driver);
+
+MODULE_AUTHOR("Martin Kurbanov <mmkurbanov@sberdevices.ru>");
+MODULE_DESCRIPTION("Amlogic Meson A1 SPIFC driver");
+MODULE_LICENSE("GPL");
-- 
2.40.0

