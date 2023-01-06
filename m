Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F90B6607A1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbjAFUKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbjAFUKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:10:14 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp11.broadcom.com [192.19.166.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731B38408B;
        Fri,  6 Jan 2023 12:10:13 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 2712CC0000F3;
        Fri,  6 Jan 2023 12:10:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 2712CC0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035813;
        bh=ozSkN0f8jvndbN+kSJY2e89x7m1Mt90y0tVuB9JkQIs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QGQP7XdyE4qHmMs9NebEfOoBP8nFhPVua9PyEK+QrScvoyG4mEy2xGmOJ/Qx/eEHX
         r/vEgEBeW4W25cAxOA2pyKhS4JESbf6OwusZHk2W3BqTqKdiuFlpGVp7qnzKgd9y8P
         muwAYLhJujEU3h4XlpUppIaVEorZByV5RDoztTJc=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 253A018041CAC6;
        Fri,  6 Jan 2023 12:10:13 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 663BB101B5D; Fri,  6 Jan 2023 12:10:06 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 10/16] spi: bcm63xx-hsspi: Make dummy cs workaround as an option
Date:   Fri,  6 Jan 2023 12:08:02 -0800
Message-Id: <20230106200809.330769-11-william.zhang@broadcom.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230106200809.330769-1-william.zhang@broadcom.com>
References: <20230106200809.330769-1-william.zhang@broadcom.com>
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

Due to the controller limitation to keep the chip select low during the
bus idle time between the transfer, a dummy cs workaround was used when
this driver was first upstreamed to the kernel.

The workaround picks dummy_cs as !actual_cs and usually cs is 0 and
dummy cs is 1. But this does not work out in all the situations as
customer reported issues for their board design. Due to SPI block design
constrain, the controller works in different mode internally depending
on the clock. When clock is 30MHz or above, controller works in faster
mode and cs 1 signal is used internally as feedback from the pad. So cs
1 pin must be brought out and configured as chip select function in
pinmux. When clock is below 30MHz, only cs 0 pin is used. In summary
when clock is below 30MHz, the workaround always works as only cs 0 is
involved. For clock faster than 30MHz, it require cs1 pin used in the
board design and configured as chip selection function.

In a typical usage of SPI flash on cs 0 that normally runs at 100MHz,
cs 1 pin must be used in the board design but this is not always the
case for many customer boards.

For voice daughtercard usage,  the SoC alway uses internal cs 7 for
voice card SPI control. Then it requires cs 0 pin as the dummy cs but
board with voice design may not use cs 0 pin at all.

The controller actually has a prepend feature that can combine multiple
SPI transfers in a SPI message into one single transfer when the
transfers meet certain requirements. So there is no need for keeping cs
low when the message only has one transfer. Most of the SPI devices
including SPI NOR, SPI NAND flash, Broadcom voice card and etc can use
this feature without the dummy cs workaround.

This patch makes the dummy cs workaround as an option based on the
dts flag brcm,use-cs-workaround. By default dummy cs workaround is
hard coded to enable. We will use the prepend feature and disable this
workaround as default in the next patch of this series unless this flag
is set in dts.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 drivers/spi/spi-bcm63xx-hsspi.c | 55 +++++++++++++++++++++------------
 1 file changed, 36 insertions(+), 19 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 398c412dcc3e..b5043251edec 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -111,6 +111,7 @@ struct bcm63xx_hsspi {
 
 	u32 speed_hz;
 	u8 cs_polarity;
+	bool use_cs_workaround;
 	int irq;
 };
 
@@ -161,16 +162,18 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 {
 	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
 	unsigned int chip_select = spi->chip_select;
+	unsigned int hw_cs;
 	u16 opcode = 0;
 	int pending = t->len;
 	int step_size = HSSPI_BUFFER_LEN;
 	const u8 *tx = t->tx_buf;
 	u8 *rx = t->rx_buf;
-	u32 val = 0;
 	unsigned long limit;
+	u32 reg = 0;
 
 	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
-	bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
+	if (bs->use_cs_workaround)
+		bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
 
 	if (tx && rx)
 		opcode = HSSPI_OP_READ_WRITE;
@@ -187,14 +190,15 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 		opcode |= HSSPI_OP_MULTIBIT;
 
 		if (t->rx_nbits == SPI_NBITS_DUAL)
-			val |= 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
+			reg |= 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
 		if (t->tx_nbits == SPI_NBITS_DUAL)
-			val |= 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
+			reg |= 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
 	}
 
-	__raw_writel(val | 0xff,
+	__raw_writel(reg | 0xff,
 		     bs->regs + HSSPI_PROFILE_MODE_CTRL_REG(chip_select));
 
+	hw_cs = bs->use_cs_workaround ? !chip_select : chip_select;
 	while (pending > 0) {
 		int curr_step = min_t(int, step_size, pending);
 
@@ -211,11 +215,10 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 			__raw_writel(HSSPI_PINGx_CMD_DONE(0),
 				     bs->regs + HSSPI_INT_MASK_REG);
 
-		/* start the transfer */
-		__raw_writel(!chip_select << PINGPONG_CMD_SS_SHIFT |
-			     chip_select << PINGPONG_CMD_PROFILE_SHIFT |
-			     PINGPONG_COMMAND_START_NOW,
-			     bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
+		reg =  hw_cs << PINGPONG_CMD_SS_SHIFT |
+			    chip_select << PINGPONG_CMD_PROFILE_SHIFT |
+			    PINGPONG_COMMAND_START_NOW;
+		__raw_writel(reg, bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
 
 		if (bs->irq > 0) {
 			if (wait_for_completion_timeout(&bs->done, HZ) == 0)
@@ -223,14 +226,15 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 		} else {
 			/* polling mode checks for status busy bit */
 			limit = jiffies + msecs_to_jiffies(HSSPI_POLL_STATUS_TIMEOUT_MS);
+
 			while (!time_after(jiffies, limit)) {
-				val = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
-				if (val & HSSPI_PINGPONG_STATUS_SRC_BUSY)
+				reg = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
+				if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
 					cpu_relax();
 				else
 					break;
 			}
-			if (val & HSSPI_PINGPONG_STATUS_SRC_BUSY)
+			if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
 				goto err_timeout;
 		}
 
@@ -311,8 +315,10 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	 * e. At the end restore the polarities again to their default values.
 	 */
 
-	dummy_cs = !spi->chip_select;
-	bcm63xx_hsspi_set_cs(bs, dummy_cs, true);
+	if (bs->use_cs_workaround) {
+		dummy_cs = !spi->chip_select;
+		bcm63xx_hsspi_set_cs(bs, dummy_cs, true);
+	}
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
 		status = bcm63xx_hsspi_do_txrx(spi, t);
@@ -343,9 +349,11 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 		restore_polarity = !t->cs_change;
 	}
 
-	bcm63xx_hsspi_set_cs(bs, dummy_cs, false);
-	if (restore_polarity)
-		bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
+	if (bs->use_cs_workaround) {
+		bcm63xx_hsspi_set_cs(bs, dummy_cs, false);
+		if (restore_polarity)
+			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
+	}
 
 	msg->status = status;
 	spi_finalize_current_message(master);
@@ -445,8 +453,17 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	init_completion(&bs->done);
 
 	master->dev.of_node = dev->of_node;
-	if (!dev->of_node)
+	if (!dev->of_node) {
 		master->bus_num = HSSPI_BUS_NUM;
+		/* use dummy cs workaround on old mips dev with no dts support */
+		bs->use_cs_workaround = true;
+	} else {
+		/* check if dummy cs workaround is needed from device tree */
+		bs->use_cs_workaround = of_property_read_bool(
+				    dev->of_node, "brcm,use-cs-workaround");
+	}
+	/* tmp hack. hard code to use cs workaround before prepend mode is added */
+	bs->use_cs_workaround = true;
 
 	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
 	if (num_cs > 8) {
-- 
2.37.3

