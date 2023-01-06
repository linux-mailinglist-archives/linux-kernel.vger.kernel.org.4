Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A263660835
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 21:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236117AbjAFUVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 15:21:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235695AbjAFUUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 15:20:54 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A3FE84619;
        Fri,  6 Jan 2023 12:19:53 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 20386C0000E4;
        Fri,  6 Jan 2023 12:09:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 20386C0000E4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1673035798;
        bh=kULL+jS6s3TbEdnopz1j9+j+pURxcCnfZ3AKuAKy3OQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmHte0+eQgGwnKrnDzqyuIYcN4B6tEVTW0vuhnKH5r82KGvovBgImYq21oxPdHIi3
         /dsOwQ9S682iFagZ5NnxbMBTw3AoftDU4/NHucTjkr9VRxrxz5ZYd2RvNRTc6F1H55
         +VreAcBPuFYhH2BtcS0FdZExLnKTVne8769dWrVk=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 1E43918041CAC6;
        Fri,  6 Jan 2023 12:09:58 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 16805101B33; Fri,  6 Jan 2023 12:09:58 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     anand.gore@broadcom.com, tomer.yacoby@broadcom.com,
        dan.beygelman@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, jonas.gorski@gmail.com,
        kursad.oney@broadcom.com, dregan@mail.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 07/16] spi: bcm63xx-hsspi: Add polling mode support
Date:   Fri,  6 Jan 2023 12:07:59 -0800
Message-Id: <20230106200809.330769-8-william.zhang@broadcom.com>
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

Polling mode provides better throughput in general by avoiding the
interrupt overhead as the maximum data size one interrupt can handle is
only 512 bytes.

When interrupt is not defined in the HSSPI dts node, driver switches to
polling mode for controller SPI message processing.  Also add driver
banner message when the driver is loaded successfully.

When test on a Broadcom BCM47622(ARM A7 dual core) reference board with
WINBOND W25N01GV SPI NAND chip at 100MHz SPI clock using the MTD speed
test suite, it shows about 15% improvement on the write and 30% on
the read:
** Interrupt mode **
  mtd_speedtest: MTD device: 0    count: 16
  mtd_speedtest: MTD device size 134217728, eraseblock size 131072, page
size 2048, count of eraseblocks 1024, pages per eraseblock 64, OOB size
64
  mtd_test: scanning for bad eraseblocks
  mtd_test: scanned 16 eraseblocks, 0 are bad
  mtd_speedtest: testing eraseblock write speed
  mtd_speedtest: eraseblock write speed is 3072 KiB/s
  mtd_speedtest: testing eraseblock read speed
  mtd_speedtest: eraseblock read speed is 6690 KiB/s
  mtd_speedtest: testing page write speed
  mtd_speedtest: page write speed is 3066 KiB/s
  mtd_speedtest: testing page read speed
  mtd_speedtest: page read speed is 6762 KiB/s
  mtd_speedtest: testing 2 page write speed
  mtd_speedtest: 2 page write speed is 3071 KiB/s
  mtd_speedtest: testing 2 page read speed
  mtd_speedtest: 2 page read speed is 6772 KiB/s
** Polling mode **
  mtd_speedtest: MTD device: 0    count: 16
  mtd_speedtest: MTD device size 134217728, eraseblock size 131072, page
size 2048, count of eraseblocks 1024, pages per eraseblock 64, OOB size
64
  mtd_test: scanning for bad eraseblocks
  mtd_test: scanned 16 eraseblocks, 0 are bad
  mtd_speedtest: testing eraseblock write speed
  mtd_speedtest: eraseblock write speed is 3542 KiB/s
  mtd_speedtest: testing eraseblock read speed
  mtd_speedtest: eraseblock read speed is 8825 KiB/s
  mtd_speedtest: testing page write speed
  mtd_speedtest: page write speed is 3563 KiB/s
  mtd_speedtest: testing page read speed
  mtd_speedtest: page read speed is 8787 KiB/s
  mtd_speedtest: testing 2 page write speed
  mtd_speedtest: 2 page write speed is 3572 KiB/s
  mtd_speedtest: testing 2 page read speed
  mtd_speedtest: 2 page read speed is 8806 KiB/s

Signed-off-by: William Zhang <william.zhang@broadcom.com>
---

 drivers/spi/spi-bcm63xx-hsspi.c | 49 +++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index 63682c8ff955..2b4cdf7e7002 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -57,6 +57,7 @@
 #define PINGPONG_CMD_SS_SHIFT			12
 
 #define HSSPI_PINGPONG_STATUS_REG(x)		(0x84 + (x) * 0x40)
+#define HSSPI_PINGPONG_STATUS_SRC_BUSY		BIT(1)
 
 #define HSSPI_PROFILE_CLK_CTRL_REG(x)		(0x100 + (x) * 0x20)
 #define CLK_CTRL_FREQ_CTRL_MASK			0x0000ffff
@@ -96,6 +97,7 @@
 
 #define HSSPI_SPI_MAX_CS			8
 #define HSSPI_BUS_NUM				1 /* 0 is legacy SPI */
+#define HSSPI_POLL_STATUS_TIMEOUT_MS	100
 
 struct bcm63xx_hsspi {
 	struct completion done;
@@ -109,6 +111,7 @@ struct bcm63xx_hsspi {
 
 	u32 speed_hz;
 	u8 cs_polarity;
+	int irq;
 };
 
 static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned int cs,
@@ -163,6 +166,8 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	int step_size = HSSPI_BUFFER_LEN;
 	const u8 *tx = t->tx_buf;
 	u8 *rx = t->rx_buf;
+	u32 val;
+	unsigned long limit;
 
 	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
 	bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
@@ -197,8 +202,9 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 		__raw_writew(cpu_to_be16(opcode | curr_step), bs->fifo);
 
 		/* enable interrupt */
-		__raw_writel(HSSPI_PINGx_CMD_DONE(0),
-			     bs->regs + HSSPI_INT_MASK_REG);
+		if (bs->irq > 0)
+			__raw_writel(HSSPI_PINGx_CMD_DONE(0),
+				     bs->regs + HSSPI_INT_MASK_REG);
 
 		/* start the transfer */
 		__raw_writel(!chip_select << PINGPONG_CMD_SS_SHIFT |
@@ -206,9 +212,21 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 			     PINGPONG_COMMAND_START_NOW,
 			     bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
 
-		if (wait_for_completion_timeout(&bs->done, HZ) == 0) {
-			dev_err(&bs->pdev->dev, "transfer timed out!\n");
-			return -ETIMEDOUT;
+		if (bs->irq > 0) {
+			if (wait_for_completion_timeout(&bs->done, HZ) == 0)
+				goto err_timeout;
+		} else {
+			/* polling mode checks for status busy bit */
+			limit = jiffies + msecs_to_jiffies(HSSPI_POLL_STATUS_TIMEOUT_MS);
+			while (!time_after(jiffies, limit)) {
+				val = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
+				if (val & HSSPI_PINGPONG_STATUS_SRC_BUSY)
+					cpu_relax();
+				else
+					break;
+			}
+			if (val & HSSPI_PINGPONG_STATUS_SRC_BUSY)
+				goto err_timeout;
 		}
 
 		if (rx) {
@@ -220,6 +238,10 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	return 0;
+
+err_timeout:
+	dev_err(&bs->pdev->dev, "transfer timed out!\n");
+	return -ETIMEDOUT;
 }
 
 static int bcm63xx_hsspi_setup(struct spi_device *spi)
@@ -338,8 +360,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	u32 reg, rate, num_cs = HSSPI_SPI_MAX_CS;
 	struct reset_control *reset;
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	irq = platform_get_irq_optional(pdev, 0);
+	if (irq < 0 && irq != -ENXIO)
 		return irq;
 
 	regs = devm_platform_ioremap_resource(pdev, 0);
@@ -398,6 +420,7 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	bs->regs = regs;
 	bs->speed_hz = rate;
 	bs->fifo = (u8 __iomem *)(bs->regs + HSSPI_FIFO_REG(0));
+	bs->irq = irq;
 
 	mutex_init(&bs->bus_mutex);
 	init_completion(&bs->done);
@@ -434,11 +457,13 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	__raw_writel(reg | GLOBAL_CTRL_CLK_GATE_SSOFF,
 		     bs->regs + HSSPI_GLOBAL_CTRL_REG);
 
-	ret = devm_request_irq(dev, irq, bcm63xx_hsspi_interrupt, IRQF_SHARED,
-			       pdev->name, bs);
+	if (bs->irq > 0) {
+		ret = devm_request_irq(dev, irq, bcm63xx_hsspi_interrupt, IRQF_SHARED,
+				       pdev->name, bs);
 
-	if (ret)
-		goto out_put_master;
+		if (ret)
+			goto out_put_master;
+	}
 
 	pm_runtime_enable(&pdev->dev);
 
@@ -447,6 +472,8 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_pm_disable;
 
+	dev_info(dev, "Broadcom 63XX High Speed SPI Controller driver");
+
 	return 0;
 
 out_pm_disable:
-- 
2.37.3

