Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF9E68CFF9
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:00:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjBGHAP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:00:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbjBGHAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:00:10 -0500
Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E202A995;
        Mon,  6 Feb 2023 23:00:06 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 23F88C0000F0;
        Mon,  6 Feb 2023 23:00:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 23F88C0000F0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753206;
        bh=RJR42zafzuHzU9zXhln8Js/HzO3eQwmWzyRbDNyJX1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YC9uBlI8RB8CSpBlHPFXNIfvDlpXEyr/N4GdDVJnftfXjcpVCIKx6P9oDccDD8hlu
         AQdvud6/1WNzwJuzUHdZ0TPxXsqjpSFhojSUTHcRe+O5TvAeKuM1VV2bhs+znc45un
         2hygm/tMr5xUm0+SnBbwLUc2qte3uBSallVK00hM=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 2274718041CAC6;
        Mon,  6 Feb 2023 23:00:06 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 6F4B7101B35; Mon,  6 Feb 2023 22:59:59 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/15] spi: bcm63xx-hsspi: Add polling mode support
Date:   Mon,  6 Feb 2023 22:58:18 -0800
Message-Id: <20230207065826.285013-8-william.zhang@broadcom.com>
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

Polling mode provides better throughput in general by avoiding the
interrupt overhead as the maximum data size one interrupt can handle is
only 512 bytes. So switch to polling mode as the default mode but add
a driver sysfs option wait_mode to allow user manually changing the mode
at run time between interrupt and polling. Also add driver banner
message when the driver is loaded successfully.

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

(no changes since v2)

Changes in v2:
- Make interrupt as required node in the dts
- Use polling mode as default mode
- Add driver sysfs option wait_mode to allow mode change at run time
- Update commit message

 drivers/spi/spi-bcm63xx-hsspi.c | 109 ++++++++++++++++++++++++++++----
 1 file changed, 98 insertions(+), 11 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index a65a0ec67641..55cbe7deba08 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -57,6 +57,7 @@
 #define PINGPONG_CMD_SS_SHIFT			12
 
 #define HSSPI_PINGPONG_STATUS_REG(x)		(0x84 + (x) * 0x40)
+#define HSSPI_PINGPONG_STATUS_SRC_BUSY		BIT(1)
 
 #define HSSPI_PROFILE_CLK_CTRL_REG(x)		(0x100 + (x) * 0x20)
 #define CLK_CTRL_FREQ_CTRL_MASK			0x0000ffff
@@ -96,11 +97,16 @@
 
 #define HSSPI_SPI_MAX_CS			8
 #define HSSPI_BUS_NUM				1 /* 0 is legacy SPI */
+#define HSSPI_POLL_STATUS_TIMEOUT_MS	100
+
+#define HSSPI_WAIT_MODE_POLLING		0
+#define HSSPI_WAIT_MODE_INTR		1
+#define HSSPI_WAIT_MODE_MAX			HSSPI_WAIT_MODE_INTR
 
 struct bcm63xx_hsspi {
 	struct completion done;
 	struct mutex bus_mutex;
-
+	struct mutex msg_mutex;
 	struct platform_device *pdev;
 	struct clk *clk;
 	struct clk *pll_clk;
@@ -109,6 +115,52 @@ struct bcm63xx_hsspi {
 
 	u32 speed_hz;
 	u8 cs_polarity;
+	u32 wait_mode;
+};
+
+static ssize_t wait_mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
+
+	return sprintf(buf, "%d\n", bs->wait_mode);
+}
+
+static ssize_t wait_mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
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
+static struct attribute *bcm63xx_hsspi_attrs[] = {
+	&dev_attr_wait_mode.attr,
+	NULL,
+};
+
+static const struct attribute_group bcm63xx_hsspi_group = {
+	.attrs = bcm63xx_hsspi_attrs,
 };
 
 static void bcm63xx_hsspi_set_cs(struct bcm63xx_hsspi *bs, unsigned int cs,
@@ -163,6 +215,8 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	int step_size = HSSPI_BUFFER_LEN;
 	const u8 *tx = t->tx_buf;
 	u8 *rx = t->rx_buf;
+	u32 val;
+	unsigned long limit;
 
 	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
 	bcm63xx_hsspi_set_cs(bs, spi->chip_select, true);
@@ -197,8 +251,9 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 		__raw_writew((u16)cpu_to_be16(opcode | curr_step), bs->fifo);
 
 		/* enable interrupt */
-		__raw_writel(HSSPI_PINGx_CMD_DONE(0),
-			     bs->regs + HSSPI_INT_MASK_REG);
+		if (bs->wait_mode == HSSPI_WAIT_MODE_INTR)
+			__raw_writel(HSSPI_PINGx_CMD_DONE(0),
+				     bs->regs + HSSPI_INT_MASK_REG);
 
 		/* start the transfer */
 		__raw_writel(!chip_select << PINGPONG_CMD_SS_SHIFT |
@@ -206,9 +261,21 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 			     PINGPONG_COMMAND_START_NOW,
 			     bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
 
-		if (wait_for_completion_timeout(&bs->done, HZ) == 0) {
-			dev_err(&bs->pdev->dev, "transfer timed out!\n");
-			return -ETIMEDOUT;
+		if (bs->wait_mode == HSSPI_WAIT_MODE_INTR) {
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
@@ -220,6 +287,10 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	return 0;
+
+err_timeout:
+	dev_err(&bs->pdev->dev, "transfer timed out!\n");
+	return -ETIMEDOUT;
 }
 
 static int bcm63xx_hsspi_setup(struct spi_device *spi)
@@ -269,6 +340,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	int dummy_cs;
 	u32 reg;
 
+	mutex_lock(&bs->msg_mutex);
 	/* This controller does not support keeping CS active during idle.
 	 * To work around this, we use the following ugly hack:
 	 *
@@ -306,6 +378,7 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	__raw_writel(reg, bs->regs + HSSPI_GLOBAL_CTRL_REG);
 	mutex_unlock(&bs->bus_mutex);
 
+	mutex_unlock(&bs->msg_mutex);
 	msg->status = status;
 	spi_finalize_current_message(master);
 
@@ -398,8 +471,10 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	bs->regs = regs;
 	bs->speed_hz = rate;
 	bs->fifo = (u8 __iomem *)(bs->regs + HSSPI_FIFO_REG(0));
+	bs->wait_mode = HSSPI_WAIT_MODE_POLLING;
 
 	mutex_init(&bs->bus_mutex);
+	mutex_init(&bs->msg_mutex);
 	init_completion(&bs->done);
 
 	master->dev.of_node = dev->of_node;
@@ -434,21 +509,32 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	__raw_writel(reg | GLOBAL_CTRL_CLK_GATE_SSOFF,
 		     bs->regs + HSSPI_GLOBAL_CTRL_REG);
 
-	ret = devm_request_irq(dev, irq, bcm63xx_hsspi_interrupt, IRQF_SHARED,
-			       pdev->name, bs);
+	if (irq > 0) {
+		ret = devm_request_irq(dev, irq, bcm63xx_hsspi_interrupt, IRQF_SHARED,
+				       pdev->name, bs);
 
-	if (ret)
-		goto out_put_master;
+		if (ret)
+			goto out_put_master;
+	}
 
 	pm_runtime_enable(&pdev->dev);
 
+	if (sysfs_create_group(&pdev->dev.kobj, &bcm63xx_hsspi_group)) {
+		dev_err(&pdev->dev, "couldn't register sysfs group\n");
+		goto out_pm_disable;
+	}
+
 	/* register and we are done */
 	ret = devm_spi_register_master(dev, master);
 	if (ret)
-		goto out_pm_disable;
+		goto out_sysgroup_disable;
+
+	dev_info(dev, "Broadcom 63XX High Speed SPI Controller driver");
 
 	return 0;
 
+out_sysgroup_disable:
+	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
 out_pm_disable:
 	pm_runtime_disable(&pdev->dev);
 out_put_master:
@@ -470,6 +556,7 @@ static int bcm63xx_hsspi_remove(struct platform_device *pdev)
 	__raw_writel(0, bs->regs + HSSPI_INT_MASK_REG);
 	clk_disable_unprepare(bs->pll_clk);
 	clk_disable_unprepare(bs->clk);
+	sysfs_remove_group(&pdev->dev.kobj, &bcm63xx_hsspi_group);
 
 	return 0;
 }
-- 
2.37.3

