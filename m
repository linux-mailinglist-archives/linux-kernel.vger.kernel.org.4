Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3452866081F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236245AbjAFUT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbjAFUS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:18:59 -0500
X-Greylist: delayed 547 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 06 Jan 2023 12:18:26 PST
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB5933C703;
        Fri,  6 Jan 2023 12:18:26 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 01CD8C0000F3;
        Fri,  6 Jan 2023 12:10:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 01CD8C0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035808;
        bh=4+QaWMX/RdX5N5eXa+dYncIa2WJfkQ1n8sBRvbRvhKo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oop0CaGfTnDH6irNfURuZIwOxH34Z2FSP7W8zZlDLCQ+oKrknMUkavcarcLIkvhT/
         PNyfzqr13eiQFb+zEj3vugv2hsrMs8ApOYE14ZX9hCZ5u2ED3AE+mR+fTHBC/ca4Lg
         UaaB8sZ7F4b0l5a8D7rLgZ+Vvu8N4MmoPuJiRQzw=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id BDCA318041CAC6;
        Fri,  6 Jan 2023 12:10:07 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id B2D48101B5E; Fri,  6 Jan 2023 12:10:07 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 11/16] spi: bcm63xx-hsspi: Add prepend feature support
Date:   Fri,  6 Jan 2023 12:08:03 -0800
Message-Id: <20230106200809.330769-12-william.zhang@broadcom.com>
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

Multiple transfers within a SPI message may be combined into one
transfer to the controller using its prepend feature. A SPI message is
prependable only if the following are all true:
  * One or more half duplex write transfer
  * Optional full duplex read/write at the end
  * No delay and cs_change between transfers

Most of the SPI device meets this requirements such as SPI NOR,
SPI NAND flash, Broadcom SPI voice card and etc. So this patch
makes use of the prepend feature as the default mode as it has no board
design requirement as the dummy cs workaround needs.

For any SPI device that does not meet the above requirement, dummy cs
mode can be used as long as the board design meets its cs pin usage
requirement or runs below 30MHz clock speed.

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 drivers/spi/spi-bcm63xx-hsspi.c | 246 ++++++++++++++++++++++++++++----
 1 file changed, 221 insertions(+), 25 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index b5043251edec..58f2b495c13c 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -113,8 +113,208 @@ struct bcm63xx_hsspi {
 	u8 cs_polarity;
 	bool use_cs_workaround;
 	int irq;
+	u32 prepend_cnt;
+	u8 *prepend_buf;
 };
 
+static void bcm63xx_hsspi_set_clk(struct bcm63xx_hsspi *bs,
+				  struct spi_device *spi, int hz);
+
+static size_t bcm63xx_hsspi_max_message_size(struct spi_device *spi)
+{
+	return HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN;
+}
+
+static int bcm63xx_hsspi_wait_cmd(struct bcm63xx_hsspi *bs)
+{
+	unsigned long limit;
+	u32 reg = 0;
+	int rc = 0;
+
+	if (bs->irq > 0) {
+		if (wait_for_completion_timeout(&bs->done, HZ) == 0)
+			rc = 1;
+	} else {
+		/* polling mode checks for status busy bit */
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
+static bool bcm63xx_check_msg_prependable(struct spi_master *master,
+					  struct spi_message *msg,
+					  struct spi_transfer *t_prepend)
+{
+
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	bool prepend = false, tx_only = false;
+	struct spi_transfer *t;
+
+	/* If cs dummy workaround used, no need to prepend message */
+	if (bs->use_cs_workaround)
+		goto check_done;
+
+	/*
+	 * Multiple transfers within a message may be combined into one transfer
+	 * to the controller using its prepend feature. A SPI message is prependable
+	 * only if the following are all true:
+	 *   1. One or more half duplex write transfer
+	 *   2. Optional full duplex read/write at the end
+	 *   3. No delay and cs_change between transfers
+	 */
+	bs->prepend_cnt = 0;
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if ((spi_delay_to_ns(&t->delay, t) > 0) || t->cs_change) {
+			dev_warn(&bs->pdev->dev,
+				 "Delay or cs change not supported in prepend mode!\n");
+			break;
+		}
+
+		tx_only = false;
+		if (t->tx_buf && !t->rx_buf) {
+			tx_only = true;
+			if (bs->prepend_cnt + t->len >
+			    (HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN)) {
+				dev_warn(&bs->pdev->dev,
+					 "exceed max buf len, abort prepending transfers!\n");
+				break;
+			}
+			memcpy(bs->prepend_buf + bs->prepend_cnt, t->tx_buf,
+			       t->len);
+			bs->prepend_cnt += t->len;
+		} else {
+			if (!list_is_last(&t->transfer_list, &msg->transfers)) {
+				dev_warn(&bs->pdev->dev,
+					 "rx/tx_rx transfer not supported when it is not last one!\n");
+				break;
+			}
+		}
+
+		if (list_is_last(&t->transfer_list, &msg->transfers)) {
+			memcpy(t_prepend, t, sizeof(struct spi_transfer));
+
+			if (tx_only) {
+				/*
+				 * if the last one is also a tx only transfer, merge all
+				 * them into one single tx transfer
+				 */
+				t_prepend->len = bs->prepend_cnt;
+				t_prepend->tx_buf = bs->prepend_buf;
+				bs->prepend_cnt = 0;
+			} else {
+				/*
+				 * if the last one is not a tx only transfer, all the previous
+				 * transfers are sent through prepend bytes and make sure it does
+				 * not exceed the max prepend len
+				 */
+				if (bs->prepend_cnt > HSSPI_MAX_PREPEND_LEN) {
+					dev_warn(&bs->pdev->dev,
+						"exceed max prepend len, abort prepending transfers!\n");
+					break;
+				}
+			}
+			prepend = true;
+		}
+	}
+
+check_done:
+	if (!bs->use_cs_workaround && !prepend)
+		dev_warn(&bs->pdev->dev,
+		    "Msg not prependable and cs war not used. Transfer may fail!\n");
+
+	return prepend;
+}
+
+static int bcm63xx_hsspi_do_prepend_txrx(struct spi_device *spi,
+					 struct spi_transfer *t)
+{
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
+	unsigned int chip_select = spi->chip_select;
+	u16 opcode = 0;
+	const u8 *tx = t->tx_buf;
+	u8 *rx = t->rx_buf;
+	u32 reg = 0;
+
+	/*
+	 * shouldn't happen as we set the max_message_size in the probe.
+	 * but check it again in case some driver does not honor the max size
+	 */
+	if (t->len + bs->prepend_cnt > (HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN)) {
+		dev_warn(&bs->pdev->dev,
+			 "Prepend message large than fifo size len %d prepend %d\n",
+			 t->len, bs->prepend_cnt);
+		return -EINVAL;
+	}
+
+	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
+
+	if (tx && rx)
+		opcode = HSSPI_OP_READ_WRITE;
+	else if (tx)
+		opcode = HSSPI_OP_WRITE;
+	else if (rx)
+		opcode = HSSPI_OP_READ;
+
+	if ((opcode == HSSPI_OP_READ && t->rx_nbits == SPI_NBITS_DUAL) ||
+	    (opcode == HSSPI_OP_WRITE && t->tx_nbits == SPI_NBITS_DUAL)) {
+		opcode |= HSSPI_OP_MULTIBIT;
+
+		if (t->rx_nbits == SPI_NBITS_DUAL) {
+			reg |= 1 << MODE_CTRL_MULTIDATA_RD_SIZE_SHIFT;
+			reg |= bs->prepend_cnt << MODE_CTRL_MULTIDATA_RD_STRT_SHIFT;
+		}
+		if (t->tx_nbits == SPI_NBITS_DUAL) {
+			reg |= 1 << MODE_CTRL_MULTIDATA_WR_SIZE_SHIFT;
+			reg |= bs->prepend_cnt << MODE_CTRL_MULTIDATA_WR_STRT_SHIFT;
+		}
+	}
+
+	reg |= bs->prepend_cnt << MODE_CTRL_PREPENDBYTE_CNT_SHIFT;
+	__raw_writel(reg | 0xff,
+		     bs->regs + HSSPI_PROFILE_MODE_CTRL_REG(chip_select));
+
+	reinit_completion(&bs->done);
+	if (bs->prepend_cnt)
+		memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN, bs->prepend_buf,
+			    bs->prepend_cnt);
+	if (tx)
+		memcpy_toio(bs->fifo + HSSPI_OPCODE_LEN + bs->prepend_cnt, tx,
+			    t->len);
+
+	__raw_writew(cpu_to_be16(opcode | t->len), bs->fifo);
+	/* enable interrupt */
+	if (bs->irq > 0)
+		__raw_writel(HSSPI_PINGx_CMD_DONE(0), bs->regs + HSSPI_INT_MASK_REG);
+
+	/* start the transfer */
+	reg = chip_select << PINGPONG_CMD_SS_SHIFT |
+	    chip_select << PINGPONG_CMD_PROFILE_SHIFT |
+	    PINGPONG_COMMAND_START_NOW;
+	__raw_writel(reg, bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
+
+	if (bcm63xx_hsspi_wait_cmd(bs))
+		return -ETIMEDOUT;
+
+	if (rx)
+		memcpy_fromio(rx, bs->fifo, t->len);
+
+	return 0;
+}
+
 static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned int cs,
 				 bool active)
 {
@@ -168,7 +368,6 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	int step_size = HSSPI_BUFFER_LEN;
 	const u8 *tx = t->tx_buf;
 	u8 *rx = t->rx_buf;
-	unsigned long limit;
 	u32 reg = 0;
 
 	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
@@ -220,23 +419,8 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 			    PINGPONG_COMMAND_START_NOW;
 		__raw_writel(reg, bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
 
-		if (bs->irq > 0) {
-			if (wait_for_completion_timeout(&bs->done, HZ) == 0)
-				goto err_timeout;
-		} else {
-			/* polling mode checks for status busy bit */
-			limit = jiffies + msecs_to_jiffies(HSSPI_POLL_STATUS_TIMEOUT_MS);
-
-			while (!time_after(jiffies, limit)) {
-				reg = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
-				if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
-					cpu_relax();
-				else
-					break;
-			}
-			if (reg & HSSPI_PINGPONG_STATUS_SRC_BUSY)
-				goto err_timeout;
-		}
+		if (bcm63xx_hsspi_wait_cmd(bs))
+			return -ETIMEDOUT;
 
 		if (rx) {
 			memcpy_fromio(rx, bs->fifo, curr_step);
@@ -247,10 +431,6 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	return 0;
-
-err_timeout:
-	dev_err(&bs->pdev->dev, "transfer timed out!\n");
-	return -ETIMEDOUT;
 }
 
 static int bcm63xx_hsspi_setup(struct spi_device *spi)
@@ -300,8 +480,16 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	int dummy_cs;
 	u32 reg;
 	bool restore_polarity = true;
+	struct spi_transfer t_prepend;
+
+	if (bcm63xx_check_msg_prependable(master, msg, &t_prepend)) {
+		status = bcm63xx_hsspi_do_prepend_txrx(spi, &t_prepend);
+		msg->actual_length += (t_prepend.len + bs->prepend_cnt);
+		goto msg_done;
+	}
 
-	/* This controller does not support keeping CS active during idle.
+	/*
+	 * This controller does not support keeping CS active during idle.
 	 * To work around this, we use the following ugly hack:
 	 *
 	 * a. Invert the target chip select's polarity so it will be active.
@@ -355,6 +543,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 			bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
 	}
 
+msg_done:
 	msg->status = status;
 	spi_finalize_current_message(master);
 
@@ -448,6 +637,11 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	bs->speed_hz = rate;
 	bs->fifo = (u8 __iomem *)(bs->regs + HSSPI_FIFO_REG(0));
 	bs->irq = irq;
+	bs->prepend_buf = devm_kzalloc(dev, HSSPI_BUFFER_LEN, GFP_KERNEL);
+	if (!bs->prepend_buf) {
+		ret = -ENOMEM;
+		goto out_put_master;
+	}
 
 	mutex_init(&bs->bus_mutex);
 	init_completion(&bs->done);
@@ -462,8 +656,6 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 		bs->use_cs_workaround = of_property_read_bool(
 				    dev->of_node, "brcm,use-cs-workaround");
 	}
-	/* tmp hack. hard code to use cs workaround before prepend mode is added */
-	bs->use_cs_workaround = true;
 
 	of_property_read_u32(dev->of_node, "num-cs", &num_cs);
 	if (num_cs > 8) {
@@ -474,6 +666,10 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	master->num_chipselect = num_cs;
 	master->setup = bcm63xx_hsspi_setup;
 	master->transfer_one_message = bcm63xx_hsspi_transfer_one;
+	if (!bs->use_cs_workaround) {
+		master->max_transfer_size = bcm63xx_hsspi_max_message_size;
+		master->max_message_size = bcm63xx_hsspi_max_message_size;
+	}
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
 			    SPI_RX_DUAL | SPI_TX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-- 
2.37.3

