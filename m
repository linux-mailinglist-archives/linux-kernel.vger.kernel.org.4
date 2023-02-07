Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05AE268D001
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 08:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjBGHBb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 02:01:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbjBGHB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 02:01:26 -0500
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.166.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5E137578;
        Mon,  6 Feb 2023 23:00:48 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.75.146.107])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 10AE1C0000F3;
        Mon,  6 Feb 2023 23:00:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 10AE1C0000F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1675753236;
        bh=fWyNs2bkXFHqj678zYRyTH37mXgp7vEB3WpvXdWqxLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ky8+H9gqpkjZIMM0vOFcx1Z4lOMKoQ53iRGInZJOXK7wjI5WysT6Tmn5szt55tKvJ
         SSD13fBxoR8gdxe3qNVK2sxiwZxjSzfuxQTCnbIG+LQol8SZub4e8xqo8LAxKhH4CJ
         VMYeYmKaYp7F2IEjXsr+qz+AC7uNVeX1tM5OWMAQ=
Received: from bcacpedev-irv-3.lvn.broadcom.net (bcacpedev-irv-3.lvn.broadcom.net [10.75.138.105])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPS id 0F0AE18041CAC6;
        Mon,  6 Feb 2023 23:00:36 -0800 (PST)
Received: by bcacpedev-irv-3.lvn.broadcom.net (Postfix, from userid 28376)
        id 0D044101B35; Mon,  6 Feb 2023 23:00:36 -0800 (PST)
From:   William Zhang <william.zhang@broadcom.com>
To:     Linux SPI List <linux-spi@vger.kernel.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, dregan@mail.com, f.fainelli@gmail.com,
        joel.peshkin@broadcom.com, jonas.gorski@gmail.com,
        tomer.yacoby@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 11/15] spi: bcm63xx-hsspi: Add prepend mode support
Date:   Mon,  6 Feb 2023 22:58:22 -0800
Message-Id: <20230207065826.285013-12-william.zhang@broadcom.com>
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

Due to the controller limitation to keep the chip select low during the
bus idle time between the transfer, a dummy cs workaround was used when
this driver was first upstreamed to the kernel.  It basically picks the
dummy cs as !actual_cs so typically dummy cs is 1 when most of the case
only cs 0 is used in the board design. Then invert the polarity of both
cs and tell the controller to start the transfers using dummy cs.
Assuming both cs are active low before the inversion, effectively this
keeps dummy cs high and actual cs low during the transfer and workaround
the issue.

This workaround implies that dummy cs 1 pin has to be set to chip
selection function in the pinmux when the transfer clock is above
25MHz. The old chips likely have default pinmux set to chip select on
the dummy cs pin so it works but this is not case for the new Broadband
BCA chips and this workaround stop working. This is specifically an
issue to support SPI NAND and SPI NOR flash because these flash devices
can typically run at or above 100MHz.

This patch utilizes the prepend feature of the controller to combine the
multiple transfers in the same message to a single transfer when
possible. This way there is no need to keep clock low between transfers
and solve the issue without any hardware requirement.

Multiple transfers within a SPI message may be combined into one
transfer if the following are all true:
  * One or more half duplex write transfer in single bit mode
  * Optional full duplex read/write at the end
  * No delay and cs_change between transfers

Most of the SPI device meets this requirements such as SPI NOR,
SPI NAND flash, Broadcom SPI voice card and etc. For any SPI message
that does not meet the above requirement to combine the transfers, we
switch to original dummy cs mode but limit the clock rate to the safe
25MHz. This is the default auto transfer mode and it makes sure all the
SPI message can be supported automatically under the hood.

This patch also adds the driver sysfs node xfer_mode to provide
the option for overriding the default auto mode and force it to dummy cs
or prepend mode.

Signed-off-by: William Zhang <william.zhang@broadcom.com>

---

Changes in v3:
- Factor dummy cs workaround into a funtion and adjust logic for
differnt xfer modes to make code more readable
- Adjust message level based on xfer mode and fallback situation

Changes in v2:
- Fix build error for Alpha platform
Reported-by: kernel test robot <lkp@intel.com>
- Remove use_cs_workaround option from device tree
- Change the transfer logic to use try prepend first and if not
prependable, switch to dummy cs mode with clock limit at the 25MHz
- Add driver sysfs node xfer_mode for the option to override the
transfer mode to dummy cs or prepend mode.
- Add number of bits check in the tranfer for prepend mode eligibility
check
- Update commit message

 drivers/spi/spi-bcm63xx-hsspi.c | 361 ++++++++++++++++++++++++++++----
 1 file changed, 324 insertions(+), 37 deletions(-)

diff --git a/drivers/spi/spi-bcm63xx-hsspi.c b/drivers/spi/spi-bcm63xx-hsspi.c
index bc700649d270..6a289deb5848 100644
--- a/drivers/spi/spi-bcm63xx-hsspi.c
+++ b/drivers/spi/spi-bcm63xx-hsspi.c
@@ -93,7 +93,11 @@
 
 #define HSSPI_MAX_PREPEND_LEN			15
 
-#define HSSPI_MAX_SYNC_CLOCK			30000000
+/*
+ * Some chip require 30MHz but other require 25MHz. Use smaller value to cover
+ * both cases.
+ */
+#define HSSPI_MAX_SYNC_CLOCK			25000000
 
 #define HSSPI_SPI_MAX_CS			8
 #define HSSPI_BUS_NUM				1 /* 0 is legacy SPI */
@@ -103,6 +107,24 @@
 #define HSSPI_WAIT_MODE_INTR		1
 #define HSSPI_WAIT_MODE_MAX			HSSPI_WAIT_MODE_INTR
 
+/*
+ * Default transfer mode is auto. If the msg is prependable, use the prepend
+ * mode.  If not, falls back to use the dummy cs workaround mode but limit the
+ * clock to 25MHz to make sure it works in all board design.
+ */
+#define HSSPI_XFER_MODE_AUTO		0
+#define HSSPI_XFER_MODE_PREPEND		1
+#define HSSPI_XFER_MODE_DUMMYCS		2
+#define HSSPI_XFER_MODE_MAX			HSSPI_XFER_MODE_DUMMYCS
+
+#define bcm63xx_prepend_printk_on_checkfail(bs, fmt, ...)	\
+do {										\
+	if (bs->xfer_mode == HSSPI_XFER_MODE_AUTO)				\
+		dev_dbg(&bs->pdev->dev, fmt, ##__VA_ARGS__);		\
+	else if (bs->xfer_mode == HSSPI_XFER_MODE_PREPEND)		\
+		dev_err(&bs->pdev->dev, fmt, ##__VA_ARGS__);		\
+} while (0)
+
 struct bcm63xx_hsspi {
 	struct completion done;
 	struct mutex bus_mutex;
@@ -116,6 +138,9 @@ struct bcm63xx_hsspi {
 	u32 speed_hz;
 	u8 cs_polarity;
 	u32 wait_mode;
+	u32 xfer_mode;
+	u32 prepend_cnt;
+	u8 *prepend_buf;
 };
 
 static ssize_t wait_mode_show(struct device *dev, struct device_attribute *attr,
@@ -154,8 +179,42 @@ static ssize_t wait_mode_store(struct device *dev, struct device_attribute *attr
 
 static DEVICE_ATTR_RW(wait_mode);
 
+static ssize_t xfer_mode_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
+
+	return sprintf(buf, "%d\n", bs->xfer_mode);
+}
+
+static ssize_t xfer_mode_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t count)
+{
+	struct spi_controller *ctrl = dev_get_drvdata(dev);
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(ctrl);
+	u32 val;
+
+	if (kstrtou32(buf, 10, &val))
+		return -EINVAL;
+
+	if (val > HSSPI_XFER_MODE_MAX) {
+		dev_warn(dev, "invalid xfer mode %u\n", val);
+		return -EINVAL;
+	}
+
+	mutex_lock(&bs->msg_mutex);
+	bs->xfer_mode = val;
+	mutex_unlock(&bs->msg_mutex);
+
+	return count;
+}
+
+static DEVICE_ATTR_RW(xfer_mode);
+
 static struct attribute *bcm63xx_hsspi_attrs[] = {
 	&dev_attr_wait_mode.attr,
+	&dev_attr_xfer_mode.attr,
 	NULL,
 };
 
@@ -163,6 +222,203 @@ static const struct attribute_group bcm63xx_hsspi_group = {
 	.attrs = bcm63xx_hsspi_attrs,
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
+	if (bs->wait_mode == HSSPI_WAIT_MODE_INTR) {
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
+static bool bcm63xx_prepare_prepend_transfer(struct spi_master *master,
+					  struct spi_message *msg,
+					  struct spi_transfer *t_prepend)
+{
+
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	bool tx_only = false;
+	struct spi_transfer *t;
+
+	/*
+	 * Multiple transfers within a message may be combined into one transfer
+	 * to the controller using its prepend feature. A SPI message is prependable
+	 * only if the following are all true:
+	 *   1. One or more half duplex write transfer in single bit mode
+	 *   2. Optional full duplex read/write at the end
+	 *   3. No delay and cs_change between transfers
+	 */
+	bs->prepend_cnt = 0;
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if ((spi_delay_to_ns(&t->delay, t) > 0) || t->cs_change) {
+			bcm63xx_prepend_printk_on_checkfail(bs,
+				 "Delay or cs change not supported in prepend mode!\n");
+			return false;
+		}
+
+		tx_only = false;
+		if (t->tx_buf && !t->rx_buf) {
+			tx_only = true;
+			if (bs->prepend_cnt + t->len >
+				(HSSPI_BUFFER_LEN - HSSPI_OPCODE_LEN)) {
+				bcm63xx_prepend_printk_on_checkfail(bs,
+					 "exceed max buf len, abort prepending transfers!\n");
+				return false;
+			}
+
+			if (t->tx_nbits > SPI_NBITS_SINGLE &&
+				!list_is_last(&t->transfer_list, &msg->transfers)) {
+				bcm63xx_prepend_printk_on_checkfail(bs,
+					 "multi-bit prepend buf not supported!\n");
+				return false;
+			}
+
+			if (t->tx_nbits == SPI_NBITS_SINGLE) {
+				memcpy(bs->prepend_buf + bs->prepend_cnt, t->tx_buf, t->len);
+				bs->prepend_cnt += t->len;
+			}
+		} else {
+			if (!list_is_last(&t->transfer_list, &msg->transfers)) {
+				bcm63xx_prepend_printk_on_checkfail(bs,
+					 "rx/tx_rx transfer not supported when it is not last one!\n");
+				return false;
+			}
+		}
+
+		if (list_is_last(&t->transfer_list, &msg->transfers)) {
+			memcpy(t_prepend, t, sizeof(struct spi_transfer));
+
+			if (tx_only && t->tx_nbits == SPI_NBITS_SINGLE) {
+				/*
+				 * if the last one is also a single bit tx only transfer, merge
+				 * all of them into one single tx transfer
+				 */
+				t_prepend->len = bs->prepend_cnt;
+				t_prepend->tx_buf = bs->prepend_buf;
+				bs->prepend_cnt = 0;
+			} else {
+				/*
+				 * if the last one is not a tx only transfer or dual tx xfer, all
+				 * the previous transfers are sent through prepend bytes and
+				 * make sure it does not exceed the max prepend len
+				 */
+				if (bs->prepend_cnt > HSSPI_MAX_PREPEND_LEN) {
+					bcm63xx_prepend_printk_on_checkfail(bs,
+						"exceed max prepend len, abort prepending transfers!\n");
+					return false;
+				}
+			}
+		}
+	}
+
+	return true;
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
+	__raw_writew((u16)cpu_to_be16(opcode | t->len), bs->fifo);
+	/* enable interrupt */
+	if (bs->wait_mode == HSSPI_WAIT_MODE_INTR)
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
@@ -215,8 +471,7 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	int step_size = HSSPI_BUFFER_LEN;
 	const u8 *tx = t->tx_buf;
 	u8 *rx = t->rx_buf;
-	u32 val = 0;
-	unsigned long limit;
+	u32 reg = 0;
 
 	bcm63xx_hsspi_set_clk(bs, spi, t->speed_hz);
 	if (!t->cs_off)
@@ -237,12 +492,12 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
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
 
 	while (pending > 0) {
@@ -261,28 +516,13 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 			__raw_writel(HSSPI_PINGx_CMD_DONE(0),
 				     bs->regs + HSSPI_INT_MASK_REG);
 
-		/* start the transfer */
-		__raw_writel(!chip_select << PINGPONG_CMD_SS_SHIFT |
-			     chip_select << PINGPONG_CMD_PROFILE_SHIFT |
-			     PINGPONG_COMMAND_START_NOW,
-			     bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
+		reg =  !chip_select << PINGPONG_CMD_SS_SHIFT |
+			    chip_select << PINGPONG_CMD_PROFILE_SHIFT |
+			    PINGPONG_COMMAND_START_NOW;
+		__raw_writel(reg, bs->regs + HSSPI_PINGPONG_COMMAND_REG(0));
 
-		if (bs->wait_mode == HSSPI_WAIT_MODE_INTR) {
-			if (wait_for_completion_timeout(&bs->done, HZ) == 0)
-				goto err_timeout;
-		} else {
-			/* polling mode checks for status busy bit */
-			limit = jiffies + msecs_to_jiffies(HSSPI_POLL_STATUS_TIMEOUT_MS);
-			while (!time_after(jiffies, limit)) {
-				val = __raw_readl(bs->regs + HSSPI_PINGPONG_STATUS_REG(0));
-				if (val & HSSPI_PINGPONG_STATUS_SRC_BUSY)
-					cpu_relax();
-				else
-					break;
-			}
-			if (val & HSSPI_PINGPONG_STATUS_SRC_BUSY)
-				goto err_timeout;
-		}
+		if (bcm63xx_hsspi_wait_cmd(bs))
+			return -ETIMEDOUT;
 
 		if (rx) {
 			memcpy_fromio(rx, bs->fifo, curr_step);
@@ -293,10 +533,6 @@ static int bcm63xx_hsspi_do_txrx(struct spi_device *spi, struct spi_transfer *t)
 	}
 
 	return 0;
-
-err_timeout:
-	dev_err(&bs->pdev->dev, "transfer timed out!\n");
-	return -ETIMEDOUT;
 }
 
 static int bcm63xx_hsspi_setup(struct spi_device *spi)
@@ -336,18 +572,17 @@ static int bcm63xx_hsspi_setup(struct spi_device *spi)
 	return 0;
 }
 
-static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
+static int bcm63xx_hsspi_do_dummy_cs_txrx(struct spi_device *spi,
 				      struct spi_message *msg)
 {
-	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
-	struct spi_transfer *t;
-	struct spi_device *spi = msg->spi;
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(spi->master);
 	int status = -EINVAL;
 	int dummy_cs;
 	bool keep_cs = false;
+	struct spi_transfer *t;
 
-	mutex_lock(&bs->msg_mutex);
-	/* This controller does not support keeping CS active during idle.
+	/*
+	 * This controller does not support keeping CS active during idle.
 	 * To work around this, we use the following ugly hack:
 	 *
 	 * a. Invert the target chip select's polarity so it will be active.
@@ -365,6 +600,21 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	bcm63xx_hsspi_set_cs(bs, dummy_cs, true);
 
 	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		/*
+		 * We are here because one of reasons below:
+		 * a. Message is not prependable and in default auto xfer mode. This mean
+		 *    we fallback to dummy cs mode at maximum 25MHz safe clock rate.
+		 * b. User set to use the dummy cs mode.
+		 */
+		if (bs->xfer_mode == HSSPI_XFER_MODE_AUTO) {
+			if (t->speed_hz > HSSPI_MAX_SYNC_CLOCK) {
+				t->speed_hz = HSSPI_MAX_SYNC_CLOCK;
+				dev_warn_once(&bs->pdev->dev,
+					"Force to dummy cs mode. Reduce the speed to %dHz",
+					t->speed_hz);
+			}
+		}
+
 		status = bcm63xx_hsspi_do_txrx(spi, t);
 		if (status)
 			break;
@@ -396,6 +646,35 @@ static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
 	if (status || !keep_cs)
 		bcm63xx_hsspi_set_cs(bs, spi->chip_select, false);
 
+	return status;
+}
+
+static int bcm63xx_hsspi_transfer_one(struct spi_master *master,
+				      struct spi_message *msg)
+{
+	struct bcm63xx_hsspi *bs = spi_master_get_devdata(master);
+	struct spi_device *spi = msg->spi;
+	int status = -EINVAL;
+	bool prependable = false;
+	struct spi_transfer t_prepend;
+
+	mutex_lock(&bs->msg_mutex);
+
+	if (bs->xfer_mode != HSSPI_XFER_MODE_DUMMYCS)
+		prependable = bcm63xx_prepare_prepend_transfer(master, msg, &t_prepend);
+
+	if (prependable) {
+		status = bcm63xx_hsspi_do_prepend_txrx(spi, &t_prepend);
+		msg->actual_length = (t_prepend.len + bs->prepend_cnt);
+	} else {
+		if (bs->xfer_mode == HSSPI_XFER_MODE_PREPEND) {
+			dev_err(&bs->pdev->dev,
+				"User sets prepend mode but msg not prependable! Abort transfer\n");
+			status = -EINVAL;
+		} else
+			status = bcm63xx_hsspi_do_dummy_cs_txrx(spi, msg);
+	}
+
 	mutex_unlock(&bs->msg_mutex);
 	msg->status = status;
 	spi_finalize_current_message(master);
@@ -490,6 +769,11 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	bs->speed_hz = rate;
 	bs->fifo = (u8 __iomem *)(bs->regs + HSSPI_FIFO_REG(0));
 	bs->wait_mode = HSSPI_WAIT_MODE_POLLING;
+	bs->prepend_buf = devm_kzalloc(dev, HSSPI_BUFFER_LEN, GFP_KERNEL);
+	if (!bs->prepend_buf) {
+		ret = -ENOMEM;
+		goto out_put_master;
+	}
 
 	mutex_init(&bs->bus_mutex);
 	mutex_init(&bs->msg_mutex);
@@ -508,6 +792,9 @@ static int bcm63xx_hsspi_probe(struct platform_device *pdev)
 	master->num_chipselect = num_cs;
 	master->setup = bcm63xx_hsspi_setup;
 	master->transfer_one_message = bcm63xx_hsspi_transfer_one;
+	master->max_transfer_size = bcm63xx_hsspi_max_message_size;
+	master->max_message_size = bcm63xx_hsspi_max_message_size;
+
 	master->mode_bits = SPI_CPOL | SPI_CPHA | SPI_CS_HIGH |
 			    SPI_RX_DUAL | SPI_TX_DUAL;
 	master->bits_per_word_mask = SPI_BPW_MASK(8);
-- 
2.37.3

