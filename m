Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41C3604B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 17:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbiJSP3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 11:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232596AbiJSP3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 11:29:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 197722EF0E;
        Wed, 19 Oct 2022 08:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0112C6183B;
        Wed, 19 Oct 2022 15:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14141C433D6;
        Wed, 19 Oct 2022 15:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666192864;
        bh=yWpP5rcBA/V4zM+3Kf0SHoYs8NLhaoSKrOLcnNumx0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T0ACXHiaI0xSYoHeg+S7sBaOQxPRtEET+I/nq8S1ezrUd673bqnwW1by0S6xIrMIV
         H9gDsPGfuGmTFQxDoISfFprnOo3nNljHFz7Cdzr9kZcQEFUEwQ+0SqfFk6cggqxq0b
         Y/Iz8gioR1ELb4f1YbT+QaZ5gpNRdhGy8aPd+O3PALJSiD8GEZUe21LvPIGNBjdqpB
         R7Mct+diTuhDEVdZYsZI659jTIq+S6Nq81p5xCxicY89GqNXhM7B8jz0XG4pbf1+2U
         JIFYnTPgFXnmJCSU6xIsEOHCeBZIgy3LJt8IyL6xbKN6qGoVbumE1DIvPRvXVtiD56
         uhr00kvUiZc3Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Cory Maccarrone <darkstar6262@gmail.com>,
        Fabrice Crohas <fcrohas@gmail.com>, linux-spi@vger.kernel.org
Subject: [PATCH 16/17] spi: remove omap 100K driver
Date:   Wed, 19 Oct 2022 17:03:38 +0200
Message-Id: <20221019150410.3851944-16-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20221019150410.3851944-1-arnd@kernel.org>
References: <20221019144119.3848027-1-arnd@kernel.org>
 <20221019150410.3851944-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The OMAP7xx/OMAP8xx support was removed since all of its boards
have no remaining users. Remove its spi driver as well.

Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: linux-omap@vger.kernel.org
Cc: Cory Maccarrone <darkstar6262@gmail.com>
Cc: Fabrice Crohas <fcrohas@gmail.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/spi/Kconfig         |   6 -
 drivers/spi/Makefile        |   1 -
 drivers/spi/spi-omap-100k.c | 490 ------------------------------------
 3 files changed, 497 deletions(-)
 delete mode 100644 drivers/spi/spi-omap-100k.c

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index d1bb62f7368b..bf0dc704abbe 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -697,12 +697,6 @@ config SPI_TI_QSPI
 	  This device supports single, dual and quad read support, while
 	  it only supports single write mode.
 
-config SPI_OMAP_100K
-	tristate "OMAP SPI 100K"
-	depends on ARCH_OMAP850 || ARCH_OMAP730 || COMPILE_TEST
-	help
-	  OMAP SPI 100K master controller for omap7xx boards.
-
 config SPI_ORION
 	tristate "Orion SPI master"
 	depends on PLAT_ORION || ARCH_MVEBU || COMPILE_TEST
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 4b34e855c841..ae5ba0109d4b 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -90,7 +90,6 @@ obj-$(CONFIG_SPI_OC_TINY)		+= spi-oc-tiny.o
 spi-octeon-objs				:= spi-cavium.o spi-cavium-octeon.o
 obj-$(CONFIG_SPI_OCTEON)		+= spi-octeon.o
 obj-$(CONFIG_SPI_OMAP_UWIRE)		+= spi-omap-uwire.o
-obj-$(CONFIG_SPI_OMAP_100K)		+= spi-omap-100k.o
 obj-$(CONFIG_SPI_OMAP24XX)		+= spi-omap2-mcspi.o
 obj-$(CONFIG_SPI_TI_QSPI)		+= spi-ti-qspi.o
 obj-$(CONFIG_SPI_ORION)			+= spi-orion.o
diff --git a/drivers/spi/spi-omap-100k.c b/drivers/spi/spi-omap-100k.c
deleted file mode 100644
index 061f7394e5b9..000000000000
--- a/drivers/spi/spi-omap-100k.c
+++ /dev/null
@@ -1,490 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * OMAP7xx SPI 100k controller driver
- * Author: Fabrice Crohas <fcrohas@gmail.com>
- * from original omap1_mcspi driver
- *
- * Copyright (C) 2005, 2006 Nokia Corporation
- * Author:      Samuel Ortiz <samuel.ortiz@nokia.com> and
- *              Juha Yrjola <juha.yrjola@nokia.com>
- */
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/module.h>
-#include <linux/device.h>
-#include <linux/delay.h>
-#include <linux/platform_device.h>
-#include <linux/pm_runtime.h>
-#include <linux/err.h>
-#include <linux/clk.h>
-#include <linux/io.h>
-#include <linux/slab.h>
-
-#include <linux/spi/spi.h>
-
-#define OMAP1_SPI100K_MAX_FREQ          48000000
-
-#define ICR_SPITAS      (OMAP7XX_ICR_BASE + 0x12)
-
-#define SPI_SETUP1      0x00
-#define SPI_SETUP2      0x02
-#define SPI_CTRL        0x04
-#define SPI_STATUS      0x06
-#define SPI_TX_LSB      0x08
-#define SPI_TX_MSB      0x0a
-#define SPI_RX_LSB      0x0c
-#define SPI_RX_MSB      0x0e
-
-#define SPI_SETUP1_INT_READ_ENABLE      (1UL << 5)
-#define SPI_SETUP1_INT_WRITE_ENABLE     (1UL << 4)
-#define SPI_SETUP1_CLOCK_DIVISOR(x)     ((x) << 1)
-#define SPI_SETUP1_CLOCK_ENABLE         (1UL << 0)
-
-#define SPI_SETUP2_ACTIVE_EDGE_FALLING  (0UL << 0)
-#define SPI_SETUP2_ACTIVE_EDGE_RISING   (1UL << 0)
-#define SPI_SETUP2_NEGATIVE_LEVEL       (0UL << 5)
-#define SPI_SETUP2_POSITIVE_LEVEL       (1UL << 5)
-#define SPI_SETUP2_LEVEL_TRIGGER        (0UL << 10)
-#define SPI_SETUP2_EDGE_TRIGGER         (1UL << 10)
-
-#define SPI_CTRL_SEN(x)                 ((x) << 7)
-#define SPI_CTRL_WORD_SIZE(x)           (((x) - 1) << 2)
-#define SPI_CTRL_WR                     (1UL << 1)
-#define SPI_CTRL_RD                     (1UL << 0)
-
-#define SPI_STATUS_WE                   (1UL << 1)
-#define SPI_STATUS_RD                   (1UL << 0)
-
-/* use PIO for small transfers, avoiding DMA setup/teardown overhead and
- * cache operations; better heuristics consider wordsize and bitrate.
- */
-#define DMA_MIN_BYTES                   8
-
-#define SPI_RUNNING	0
-#define SPI_SHUTDOWN	1
-
-struct omap1_spi100k {
-	struct clk              *ick;
-	struct clk              *fck;
-
-	/* Virtual base address of the controller */
-	void __iomem            *base;
-};
-
-struct omap1_spi100k_cs {
-	void __iomem            *base;
-	int                     word_len;
-};
-
-static void spi100k_enable_clock(struct spi_master *master)
-{
-	unsigned int val;
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	/* enable SPI */
-	val = readw(spi100k->base + SPI_SETUP1);
-	val |= SPI_SETUP1_CLOCK_ENABLE;
-	writew(val, spi100k->base + SPI_SETUP1);
-}
-
-static void spi100k_disable_clock(struct spi_master *master)
-{
-	unsigned int val;
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	/* disable SPI */
-	val = readw(spi100k->base + SPI_SETUP1);
-	val &= ~SPI_SETUP1_CLOCK_ENABLE;
-	writew(val, spi100k->base + SPI_SETUP1);
-}
-
-static void spi100k_write_data(struct spi_master *master, int len, int data)
-{
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	/* write 16-bit word, shifting 8-bit data if necessary */
-	if (len <= 8) {
-		data <<= 8;
-		len = 16;
-	}
-
-	spi100k_enable_clock(master);
-	writew(data, spi100k->base + SPI_TX_MSB);
-
-	writew(SPI_CTRL_SEN(0) |
-	       SPI_CTRL_WORD_SIZE(len) |
-	       SPI_CTRL_WR,
-	       spi100k->base + SPI_CTRL);
-
-	/* Wait for bit ack send change */
-	while ((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_WE) != SPI_STATUS_WE)
-		;
-	udelay(1000);
-
-	spi100k_disable_clock(master);
-}
-
-static int spi100k_read_data(struct spi_master *master, int len)
-{
-	int dataL;
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	/* Always do at least 16 bits */
-	if (len <= 8)
-		len = 16;
-
-	spi100k_enable_clock(master);
-	writew(SPI_CTRL_SEN(0) |
-	       SPI_CTRL_WORD_SIZE(len) |
-	       SPI_CTRL_RD,
-	       spi100k->base + SPI_CTRL);
-
-	while ((readw(spi100k->base + SPI_STATUS) & SPI_STATUS_RD) != SPI_STATUS_RD)
-		;
-	udelay(1000);
-
-	dataL = readw(spi100k->base + SPI_RX_LSB);
-	readw(spi100k->base + SPI_RX_MSB);
-	spi100k_disable_clock(master);
-
-	return dataL;
-}
-
-static void spi100k_open(struct spi_master *master)
-{
-	/* get control of SPI */
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	writew(SPI_SETUP1_INT_READ_ENABLE |
-	       SPI_SETUP1_INT_WRITE_ENABLE |
-	       SPI_SETUP1_CLOCK_DIVISOR(0), spi100k->base + SPI_SETUP1);
-
-	/* configure clock and interrupts */
-	writew(SPI_SETUP2_ACTIVE_EDGE_FALLING |
-	       SPI_SETUP2_NEGATIVE_LEVEL |
-	       SPI_SETUP2_LEVEL_TRIGGER, spi100k->base + SPI_SETUP2);
-}
-
-static void omap1_spi100k_force_cs(struct omap1_spi100k *spi100k, int enable)
-{
-	if (enable)
-		writew(0x05fc, spi100k->base + SPI_CTRL);
-	else
-		writew(0x05fd, spi100k->base + SPI_CTRL);
-}
-
-static unsigned
-omap1_spi100k_txrx_pio(struct spi_device *spi, struct spi_transfer *xfer)
-{
-	struct omap1_spi100k_cs *cs = spi->controller_state;
-	unsigned int            count, c;
-	int                     word_len;
-
-	count = xfer->len;
-	c = count;
-	word_len = cs->word_len;
-
-	if (word_len <= 8) {
-		u8              *rx;
-		const u8        *tx;
-
-		rx = xfer->rx_buf;
-		tx = xfer->tx_buf;
-		do {
-			c -= 1;
-			if (xfer->tx_buf != NULL)
-				spi100k_write_data(spi->master, word_len, *tx++);
-			if (xfer->rx_buf != NULL)
-				*rx++ = spi100k_read_data(spi->master, word_len);
-		} while (c);
-	} else if (word_len <= 16) {
-		u16             *rx;
-		const u16       *tx;
-
-		rx = xfer->rx_buf;
-		tx = xfer->tx_buf;
-		do {
-			c -= 2;
-			if (xfer->tx_buf != NULL)
-				spi100k_write_data(spi->master, word_len, *tx++);
-			if (xfer->rx_buf != NULL)
-				*rx++ = spi100k_read_data(spi->master, word_len);
-		} while (c);
-	} else if (word_len <= 32) {
-		u32             *rx;
-		const u32       *tx;
-
-		rx = xfer->rx_buf;
-		tx = xfer->tx_buf;
-		do {
-			c -= 4;
-			if (xfer->tx_buf != NULL)
-				spi100k_write_data(spi->master, word_len, *tx);
-			if (xfer->rx_buf != NULL)
-				*rx = spi100k_read_data(spi->master, word_len);
-		} while (c);
-	}
-	return count - c;
-}
-
-/* called only when no transfer is active to this device */
-static int omap1_spi100k_setup_transfer(struct spi_device *spi,
-		struct spi_transfer *t)
-{
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(spi->master);
-	struct omap1_spi100k_cs *cs = spi->controller_state;
-	u8 word_len;
-
-	if (t != NULL)
-		word_len = t->bits_per_word;
-	else
-		word_len = spi->bits_per_word;
-
-	if (word_len > 32)
-		return -EINVAL;
-	cs->word_len = word_len;
-
-	/* SPI init before transfer */
-	writew(0x3e, spi100k->base + SPI_SETUP1);
-	writew(0x00, spi100k->base + SPI_STATUS);
-	writew(0x3e, spi100k->base + SPI_CTRL);
-
-	return 0;
-}
-
-/* the spi->mode bits understood by this driver: */
-#define MODEBITS (SPI_CPOL | SPI_CPHA | SPI_CS_HIGH)
-
-static int omap1_spi100k_setup(struct spi_device *spi)
-{
-	int                     ret;
-	struct omap1_spi100k    *spi100k;
-	struct omap1_spi100k_cs *cs = spi->controller_state;
-
-	spi100k = spi_master_get_devdata(spi->master);
-
-	if (!cs) {
-		cs = devm_kzalloc(&spi->dev, sizeof(*cs), GFP_KERNEL);
-		if (!cs)
-			return -ENOMEM;
-		cs->base = spi100k->base + spi->chip_select * 0x14;
-		spi->controller_state = cs;
-	}
-
-	spi100k_open(spi->master);
-
-	clk_prepare_enable(spi100k->ick);
-	clk_prepare_enable(spi100k->fck);
-
-	ret = omap1_spi100k_setup_transfer(spi, NULL);
-
-	clk_disable_unprepare(spi100k->ick);
-	clk_disable_unprepare(spi100k->fck);
-
-	return ret;
-}
-
-static int omap1_spi100k_transfer_one_message(struct spi_master *master,
-					      struct spi_message *m)
-{
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-	struct spi_device *spi = m->spi;
-	struct spi_transfer *t = NULL;
-	int cs_active = 0;
-	int status = 0;
-
-	list_for_each_entry(t, &m->transfers, transfer_list) {
-		if (t->tx_buf == NULL && t->rx_buf == NULL && t->len) {
-			break;
-		}
-		status = omap1_spi100k_setup_transfer(spi, t);
-		if (status < 0)
-			break;
-
-		if (!cs_active) {
-			omap1_spi100k_force_cs(spi100k, 1);
-			cs_active = 1;
-		}
-
-		if (t->len) {
-			unsigned count;
-
-			count = omap1_spi100k_txrx_pio(spi, t);
-			m->actual_length += count;
-
-			if (count != t->len) {
-				break;
-			}
-		}
-
-		spi_transfer_delay_exec(t);
-
-		/* ignore the "leave it on after last xfer" hint */
-
-		if (t->cs_change) {
-			omap1_spi100k_force_cs(spi100k, 0);
-			cs_active = 0;
-		}
-	}
-
-	status = omap1_spi100k_setup_transfer(spi, NULL);
-
-	if (cs_active)
-		omap1_spi100k_force_cs(spi100k, 0);
-
-	m->status = status;
-
-	spi_finalize_current_message(master);
-
-	return status;
-}
-
-static int omap1_spi100k_probe(struct platform_device *pdev)
-{
-	struct spi_master       *master;
-	struct omap1_spi100k    *spi100k;
-	int                     status = 0;
-
-	if (!pdev->id)
-		return -EINVAL;
-
-	master = spi_alloc_master(&pdev->dev, sizeof(*spi100k));
-	if (master == NULL) {
-		dev_dbg(&pdev->dev, "master allocation failed\n");
-		return -ENOMEM;
-	}
-
-	if (pdev->id != -1)
-		master->bus_num = pdev->id;
-
-	master->setup = omap1_spi100k_setup;
-	master->transfer_one_message = omap1_spi100k_transfer_one_message;
-	master->num_chipselect = 2;
-	master->mode_bits = MODEBITS;
-	master->bits_per_word_mask = SPI_BPW_RANGE_MASK(4, 32);
-	master->min_speed_hz = OMAP1_SPI100K_MAX_FREQ/(1<<16);
-	master->max_speed_hz = OMAP1_SPI100K_MAX_FREQ;
-	master->auto_runtime_pm = true;
-
-	spi100k = spi_master_get_devdata(master);
-
-	/*
-	 * The memory region base address is taken as the platform_data.
-	 * You should allocate this with ioremap() before initializing
-	 * the SPI.
-	 */
-	spi100k->base = (void __iomem *)dev_get_platdata(&pdev->dev);
-
-	spi100k->ick = devm_clk_get(&pdev->dev, "ick");
-	if (IS_ERR(spi100k->ick)) {
-		dev_dbg(&pdev->dev, "can't get spi100k_ick\n");
-		status = PTR_ERR(spi100k->ick);
-		goto err;
-	}
-
-	spi100k->fck = devm_clk_get(&pdev->dev, "fck");
-	if (IS_ERR(spi100k->fck)) {
-		dev_dbg(&pdev->dev, "can't get spi100k_fck\n");
-		status = PTR_ERR(spi100k->fck);
-		goto err;
-	}
-
-	status = clk_prepare_enable(spi100k->ick);
-	if (status != 0) {
-		dev_err(&pdev->dev, "failed to enable ick: %d\n", status);
-		goto err;
-	}
-
-	status = clk_prepare_enable(spi100k->fck);
-	if (status != 0) {
-		dev_err(&pdev->dev, "failed to enable fck: %d\n", status);
-		goto err_ick;
-	}
-
-	pm_runtime_enable(&pdev->dev);
-	pm_runtime_set_active(&pdev->dev);
-
-	status = devm_spi_register_master(&pdev->dev, master);
-	if (status < 0)
-		goto err_fck;
-
-	return status;
-
-err_fck:
-	pm_runtime_disable(&pdev->dev);
-	clk_disable_unprepare(spi100k->fck);
-err_ick:
-	clk_disable_unprepare(spi100k->ick);
-err:
-	spi_master_put(master);
-	return status;
-}
-
-static int omap1_spi100k_remove(struct platform_device *pdev)
-{
-	struct spi_master *master = platform_get_drvdata(pdev);
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	pm_runtime_disable(&pdev->dev);
-
-	clk_disable_unprepare(spi100k->fck);
-	clk_disable_unprepare(spi100k->ick);
-
-	return 0;
-}
-
-#ifdef CONFIG_PM
-static int omap1_spi100k_runtime_suspend(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-
-	clk_disable_unprepare(spi100k->ick);
-	clk_disable_unprepare(spi100k->fck);
-
-	return 0;
-}
-
-static int omap1_spi100k_runtime_resume(struct device *dev)
-{
-	struct spi_master *master = dev_get_drvdata(dev);
-	struct omap1_spi100k *spi100k = spi_master_get_devdata(master);
-	int ret;
-
-	ret = clk_prepare_enable(spi100k->ick);
-	if (ret != 0) {
-		dev_err(dev, "Failed to enable ick: %d\n", ret);
-		return ret;
-	}
-
-	ret = clk_prepare_enable(spi100k->fck);
-	if (ret != 0) {
-		dev_err(dev, "Failed to enable fck: %d\n", ret);
-		clk_disable_unprepare(spi100k->ick);
-		return ret;
-	}
-
-	return 0;
-}
-#endif
-
-static const struct dev_pm_ops omap1_spi100k_pm = {
-	SET_RUNTIME_PM_OPS(omap1_spi100k_runtime_suspend,
-			   omap1_spi100k_runtime_resume, NULL)
-};
-
-static struct platform_driver omap1_spi100k_driver = {
-	.driver = {
-		.name		= "omap1_spi100k",
-		.pm		= &omap1_spi100k_pm,
-	},
-	.probe		= omap1_spi100k_probe,
-	.remove		= omap1_spi100k_remove,
-};
-
-module_platform_driver(omap1_spi100k_driver);
-
-MODULE_DESCRIPTION("OMAP7xx SPI 100k controller driver");
-MODULE_AUTHOR("Fabrice Crohas <fcrohas@gmail.com>");
-MODULE_LICENSE("GPL");
-- 
2.29.2

