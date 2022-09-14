Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C17E5B8A86
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiINOal (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiINOae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:30:34 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A88A12B1AC;
        Wed, 14 Sep 2022 07:30:30 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 28DBC20187C;
        Wed, 14 Sep 2022 16:30:29 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B81992018B0;
        Wed, 14 Sep 2022 16:30:28 +0200 (CEST)
Received: from lsv03121.swis.in-blr01.nxp.com (lsv03121.swis.in-blr01.nxp.com [92.120.146.118])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3A0911820F59;
        Wed, 14 Sep 2022 22:30:27 +0800 (+08)
From:   Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
To:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        will@kernel.org, axboe@kernel.dk, robh+dt@kernel.org
Cc:     mb@lightnvm.io, ckeepax@opensource.cirrus.com, arnd@arndb.d,
        manjunatha.venkatesh@nxp.com, mst@redhat.com, javier@javigon.com,
        mikelley@microsoft.com, jasowang@redhat.com,
        sunilmut@microsoft.com, bjorn.andersson@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        ashish.deshpande@nxp.com, rvmanjumce@gmail.com
Subject: [PATCH v5 2/2] misc: nxp-sr1xx: UWB driver support for sr1xx series chip
Date:   Wed, 14 Sep 2022 19:59:44 +0530
Message-Id: <20220914142944.576482-3-manjunatha.venkatesh@nxp.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
References: <20220914142944.576482-1-manjunatha.venkatesh@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ultra-wideband (UWB) is a short-range wireless communication protocol.

NXP has SR1XX family of UWB Subsystems (UWBS) devices. SR1XX SOCs
are FiRa Compliant. SR1XX SOCs are flash less devices and they need
Firmware Download on every device boot. More details on the SR1XX Family
can be found at https://www.nxp.com/products/:UWB-TRIMENSION

The sr1xx driver work the SR1XX Family of UWBS, and uses UWB Controller
Interface (UCI).  The corresponding details are available in the FiRa
Consortium Website (https://www.firaconsortium.org/).

Internally driver will handle two modes of operation.
1.HBCI mode (sr1xx BootROM Code Interface)
  Firmware download uses HBCI ptotocol packet structure which is
  Nxp proprietary,Firmware File(.bin) stored in user space context
  and during device init sequence pick the firmware packet in chunk
  and send it to the driver with write() api call.

  After the firmware download sequence at the end UWBS will
  send device status notification and its indication of device entered
  UCI mode.
  Here after any command/response/notification will follow
  UCI packet structure.

2.UCI mode (UWB Command interface)
  Once Firmware download finishes sr1xx will switch to UCI mode.
  Then driver exchange command/response/notification as per the FIRA UCI
  standard format between user space and sr1xx device.
  Any response or notification received from sr1xx through SPI line
  will convey to user space.

  Its Interrupt based driver and IO Handshake needed with SR1XX Family of
  SOCs.
  This driver needs dts config update as per the sr1xx data sheet.
  Corresponding document available in Documentation/devicetree/bindings/uwb

Link: https://lore.kernel.org/r/20220527184351.3829543-4-manjunatha.venkatesh@nxp.com
Signed-off-by: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
---
Changes since v4:
  - Commit Message Description updated
  - Funtion prototype related warnings fixed
  - Devicetree documentation updated as per the review comments
  - ACPI platform support added
  - Text Aligment related issues are addressed
  - Some Corner case scenarios error handling fixed as per review comments
  - Debug Logging improvement done as per review comments
  - Licensing part updated to GPL-2.0 OR BSD-3-Clause

 MAINTAINERS              |   6 +
 drivers/misc/Kconfig     |  11 +
 drivers/misc/Makefile    |   3 +-
 drivers/misc/nxp-sr1xx.c | 794 +++++++++++++++++++++++++++++++++++++++
 4 files changed, 813 insertions(+), 1 deletion(-)
 create mode 100644 drivers/misc/nxp-sr1xx.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 936490dcc97b..17413d93f5e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14695,6 +14695,12 @@ S:	Orphan
 F:	Documentation/devicetree/bindings/net/nfc/nxp,nci.yaml
 F:	drivers/nfc/nxp-nci

+NXP-SR1XX UWB DRIVER
+M:	Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/uwb/nxp,uwb-sr1xx.yaml
+F:	drivers/misc/nxp-sr1xx.c
+
 NXP i.MX 8QXP/8QM JPEG V4L2 DRIVER
 M:	Mirela Rabulea <mirela.rabulea@nxp.com>
 R:	NXP Linux Team <linux-imx@nxp.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 94e9fb4cdd76..31921850c71b 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -471,6 +471,17 @@ config HISI_HIKEY_USB
 	  switching between the dual-role USB-C port and the USB-A host ports
 	  using only one USB controller.

+config NXP_UWB
+    tristate "NXP UCI(Uwb Command Interface) protocol driver support"
+    depends on SPI
+    help
+      This option enables the UWB driver for NXP sr1xx device.
+      Such device supports UCI packet structure, FiRa compliant.
+
+      Say Y here to compile support for nxp-sr1xx into the kernel or
+      say M to compile it as a module. The module will be called
+      nxp-sr1xx.ko
+
 config OPEN_DICE
 	tristate "Open Profile for DICE driver"
 	depends on OF_RESERVED_MEM
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 2be8542616dd..ee8ca32c66f6 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -60,4 +60,5 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
 obj-$(CONFIG_VCPU_STALL_DETECTOR)	+= vcpu_stall_detector.o
+obj-$(CONFIG_NXP_UWB) 		+= nxp-sr1xx.o
diff --git a/drivers/misc/nxp-sr1xx.c b/drivers/misc/nxp-sr1xx.c
new file mode 100644
index 000000000000..6ca9a2b54b86
--- /dev/null
+++ b/drivers/misc/nxp-sr1xx.c
@@ -0,0 +1,794 @@
+// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+/*
+ * Copyright 2018-2022 NXP.
+ *
+ * SPI driver for UWB SR1xx
+ * Author: Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>
+ */
+
+#include <linux/miscdevice.h>
+#include <linux/module.h>
+#include <linux/delay.h>
+#include <linux/interrupt.h>
+#include <linux/of_gpio.h>
+#include <linux/spi/spi.h>
+#include <linux/uaccess.h>
+
+#define SR1XX_MAGIC 0xEA
+#define SR1XX_SET_PWR _IOW(SR1XX_MAGIC, 0x01, long)
+#define SR1XX_SET_FWD _IOW(SR1XX_MAGIC, 0x02, long)
+
+#define UCI_HEADER_LEN 4
+#define HBCI_HEADER_LEN 4
+#define UCI_PAYLOAD_LEN_OFFSET 3
+
+#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET 1
+#define UCI_EXT_PAYLOAD_LEN_IND_OFFSET_MASK 0x80
+#define UCI_EXT_PAYLOAD_LEN_OFFSET 2
+
+#define SR1XX_TXBUF_SIZE 4200
+#define SR1XX_RXBUF_SIZE 4200
+#define SR1XX_MAX_TX_BUF_SIZE 4200
+
+#define MAX_RETRY_COUNT_FOR_IRQ_CHECK 100
+#define MAX_RETRY_COUNT_FOR_HANDSHAKE 1000
+
+/* Macro to define SPI clock frequency */
+#define SR1XX_SPI_CLOCK 16000000L
+#define WAKEUP_SRC_TIMEOUT (2000)
+
+/* Maximum UCI packet size supported from the driver */
+#define MAX_UCI_PKT_SIZE 4200
+
+struct sr1xx_spi_platform_data {
+	struct gpio_desc *gpiod_irq;	/* SR1XX will interrupt host for any ntf */
+	struct gpio_desc *gpiod_ce;	/* SW reset gpio */
+	struct gpio_desc *gpiod_spi_handshake;	/* Host ready to read data */
+};
+
+/* Device specific macro and structure */
+struct sr1xx_dev {
+	wait_queue_head_t read_wq;	/* Wait queue for read interrupt */
+	struct spi_device *spi;	/* Spi device structure */
+	struct miscdevice sr1xx_device;	/* Char device as misc driver */
+	unsigned int ce_gpio;	/* SW reset gpio */
+	unsigned int irq_gpio;	/* SR1XX will interrupt host for any ntf */
+	unsigned int spi_handshake_gpio;	/* Host ready to read data */
+	bool irq_enabled;	/* Flag to indicate disable/enable irq sequence */
+	bool irq_received;	/* Flag to indicate that irq is received */
+	spinlock_t irq_enabled_lock;	/* Spin lock for read irq */
+	unsigned char *tx_buffer;	/* Transmit buffer */
+	unsigned char *rx_buffer;	/* Receive buffer */
+	unsigned int write_count;	/* Holds nubers of byte written */
+	unsigned int read_count;	/* Hold nubers of byte read */
+	struct mutex
+	 sr1xx_access_lock;	/* Lock used to synchronize read and write */
+	size_t total_bytes_to_read;	/* Total bytes read from the device */
+	bool is_extended_len_bit_set;	/* Variable to check ext payload Len */
+	bool read_abort_requested;	/* Used to indicate read abort request */
+	bool is_fw_dwnld_enabled;	/* Used to indicate fw download mode */
+	int mode;		/* Indicate write or read mode */
+	long timeout_in_ms;	/* Wait event interrupt timeout in ms */
+};
+
+/* Power enable/disable and read abort ioctl arguments */
+enum { PWR_DISABLE = 0, PWR_ENABLE, ABORT_READ_PENDING };
+
+enum spi_status_codes {
+	TRANSCEIVE_SUCCESS,
+	TRANSCEIVE_FAIL,
+	IRQ_WAIT_REQUEST,
+	IRQ_WAIT_TIMEOUT
+};
+
+/* Spi write/read operation mode */
+enum spi_operation_modes { SR1XX_WRITE_MODE, SR1XX_READ_MODE };
+static int sr1xx_dev_open(struct inode *inode, struct file *filp)
+{
+	struct sr1xx_dev *sr1xx_dev =
+	    container_of(filp->private_data, struct sr1xx_dev, sr1xx_device);
+
+	filp->private_data = sr1xx_dev;
+	return 0;
+}
+
+static void sr1xx_disable_irq(struct sr1xx_dev *sr1xx_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sr1xx_dev->irq_enabled_lock, flags);
+	if ((sr1xx_dev->irq_enabled)) {
+		disable_irq_nosync(sr1xx_dev->spi->irq);
+		sr1xx_dev->irq_received = true;
+		sr1xx_dev->irq_enabled = false;
+	}
+	spin_unlock_irqrestore(&sr1xx_dev->irq_enabled_lock, flags);
+}
+
+static void sr1xx_enable_irq(struct sr1xx_dev *sr1xx_dev)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&sr1xx_dev->irq_enabled_lock, flags);
+	if (!sr1xx_dev->irq_enabled) {
+		enable_irq(sr1xx_dev->spi->irq);
+		sr1xx_dev->irq_enabled = true;
+		sr1xx_dev->irq_received = false;
+	}
+	spin_unlock_irqrestore(&sr1xx_dev->irq_enabled_lock, flags);
+}
+
+static irqreturn_t sr1xx_dev_irq_handler(int irq, void *dev_id)
+{
+	struct sr1xx_dev *sr1xx_dev = dev_id;
+
+	sr1xx_disable_irq(sr1xx_dev);
+	/* Wake up waiting readers */
+	wake_up(&sr1xx_dev->read_wq);
+	if (device_may_wakeup(&sr1xx_dev->spi->dev))
+		pm_wakeup_event(&sr1xx_dev->spi->dev, WAKEUP_SRC_TIMEOUT);
+	return IRQ_HANDLED;
+}
+
+static long sr1xx_dev_ioctl(struct file *filp, unsigned int cmd,
+			    unsigned long arg)
+{
+	int ret = 0;
+	struct sr1xx_dev *sr1xx_dev = NULL;
+
+	sr1xx_dev = filp->private_data;
+
+	switch (cmd) {
+	case SR1XX_SET_PWR:
+		if (arg == PWR_ENABLE) {
+			gpio_set_value(sr1xx_dev->ce_gpio, 1);
+			usleep_range(10000, 12000);
+		} else if (arg == PWR_DISABLE) {
+			gpio_set_value(sr1xx_dev->ce_gpio, 0);
+			sr1xx_disable_irq(sr1xx_dev);
+			usleep_range(10000, 12000);
+		} else if (arg == ABORT_READ_PENDING) {
+			sr1xx_dev->read_abort_requested = true;
+			sr1xx_disable_irq(sr1xx_dev);
+			/* Wake up waiting readers */
+			wake_up(&sr1xx_dev->read_wq);
+		}
+		break;
+	case SR1XX_SET_FWD:
+		if (arg == 1) {
+			sr1xx_dev->is_fw_dwnld_enabled = true;
+			sr1xx_dev->read_abort_requested = false;
+		} else if (arg == 0) {
+			sr1xx_dev->is_fw_dwnld_enabled = false;
+		}
+		break;
+	default:
+		dev_err(&sr1xx_dev->spi->dev, " Error case");
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+/**
+ * sr1xx_wait_for_irq_gpio_low
+ *
+ * Function to wait till irq gpio goes low state
+ *
+ */
+static void sr1xx_wait_for_irq_gpio_low(struct sr1xx_dev *sr1xx_dev)
+{
+	int retry_count = 0;
+
+	do {
+		udelay(10);
+		retry_count++;
+		if (retry_count == MAX_RETRY_COUNT_FOR_HANDSHAKE) {
+			dev_info(&sr1xx_dev->spi->dev,
+				 "Slave not released the IRQ even after 10ms");
+			break;
+		}
+	} while (gpio_get_value(sr1xx_dev->irq_gpio));
+}
+
+/**
+ * sr1xx_dev_transceive
+ * @op_mode indicates write/read operation
+ *
+ * Write and Read logic implemented under same api with
+ * mutex lock protection so write and read synchronized
+ *
+ * During Uwb ranging sequence(read) need to block write sequence
+ * in order to avoid some race condition scenarios.
+ *
+ * Returns     : Number of bytes write/read if read is success else (-1)
+ *               otherwise indicate each error code
+ */
+static int sr1xx_dev_transceive(struct sr1xx_dev *sr1xx_dev, int op_mode,
+				int count)
+{
+	int ret, retry_count;
+
+	mutex_lock(&sr1xx_dev->sr1xx_access_lock);
+	sr1xx_dev->mode = op_mode;
+	sr1xx_dev->total_bytes_to_read = 0;
+	sr1xx_dev->is_extended_len_bit_set = 0;
+	ret = -1;
+	retry_count = 0;
+
+	switch (sr1xx_dev->mode) {
+	case SR1XX_WRITE_MODE:{
+			sr1xx_dev->write_count = 0;
+			/* UCI Header write */
+			ret = spi_write(sr1xx_dev->spi, sr1xx_dev->tx_buffer,
+					UCI_HEADER_LEN);
+			if (ret < 0) {
+				ret = -EIO;
+				dev_err(&sr1xx_dev->spi->dev,
+					"spi_write header : Failed.\n");
+				goto transceive_end;
+			} else {
+				count -= UCI_HEADER_LEN;
+			}
+			if (count > 0) {
+				/* In between header write and payload write slave need some time */
+				usleep_range(30, 50);
+				/* UCI Payload write */
+				ret = spi_write(sr1xx_dev->spi,
+						sr1xx_dev->tx_buffer +
+						UCI_HEADER_LEN, count);
+				if (ret < 0) {
+					ret = -EIO;
+					dev_err(&sr1xx_dev->spi->dev,
+						"spi_write payload : Failed.\n");
+					goto transceive_end;
+				}
+			}
+			sr1xx_dev->write_count = count + UCI_HEADER_LEN;
+			ret = TRANSCEIVE_SUCCESS;
+		}
+		break;
+	case SR1XX_READ_MODE:{
+			if (!gpio_get_value(sr1xx_dev->irq_gpio)) {
+				dev_err(&sr1xx_dev->spi->dev,
+					"IRQ might have gone low due to write ");
+				ret = IRQ_WAIT_REQUEST;
+				goto transceive_end;
+			}
+			retry_count = 0;
+			gpio_set_value(sr1xx_dev->spi_handshake_gpio, 1);
+			while (gpio_get_value(sr1xx_dev->irq_gpio)) {
+				if (retry_count ==
+				    MAX_RETRY_COUNT_FOR_IRQ_CHECK)
+					break;
+				udelay(10);
+				retry_count++;
+			}
+			sr1xx_enable_irq(sr1xx_dev);
+			sr1xx_dev->read_count = 0;
+			retry_count = 0;
+			/* Wait for inetrrupt upto 500ms */
+			ret =
+			    wait_event_interruptible_timeout(sr1xx_dev->read_wq,
+							     sr1xx_dev->irq_received,
+							     sr1xx_dev->timeout_in_ms);
+			if (ret == 0) {
+				dev_err(&sr1xx_dev->spi->dev,
+					"wait_event_interruptible timeout() : Failed.\n");
+				ret = IRQ_WAIT_TIMEOUT;
+				goto transceive_end;
+			}
+			if (!gpio_get_value(sr1xx_dev->irq_gpio)) {
+				dev_err(&sr1xx_dev->spi->dev,
+					"Second IRQ is Low");
+				ret = -1;
+				goto transceive_end;
+			}
+			ret =
+			    spi_read(sr1xx_dev->spi,
+				     (void *)sr1xx_dev->rx_buffer,
+				     UCI_HEADER_LEN);
+			if (ret < 0) {
+				dev_err(&sr1xx_dev->spi->dev,
+					"sr1xx_dev_read: spi read error %d\n ",
+					ret);
+				goto transceive_end;
+			}
+			sr1xx_dev->is_extended_len_bit_set =
+			    (sr1xx_dev->rx_buffer[UCI_EXT_PAYLOAD_LEN_IND_OFFSET] &
+			     UCI_EXT_PAYLOAD_LEN_IND_OFFSET_MASK);
+			sr1xx_dev->total_bytes_to_read =
+			    sr1xx_dev->rx_buffer[UCI_PAYLOAD_LEN_OFFSET];
+			if (sr1xx_dev->is_extended_len_bit_set) {
+				sr1xx_dev->total_bytes_to_read =
+				    ((sr1xx_dev->total_bytes_to_read << 8) |
+				     sr1xx_dev->rx_buffer[UCI_EXT_PAYLOAD_LEN_OFFSET]);
+			}
+			if (sr1xx_dev->total_bytes_to_read >
+			    (MAX_UCI_PKT_SIZE - UCI_HEADER_LEN)) {
+				dev_err(&sr1xx_dev->spi->dev,
+					"Length %d  exceeds the max limit %d....",
+					(int)sr1xx_dev->total_bytes_to_read,
+					(int)MAX_UCI_PKT_SIZE);
+				ret = -1;
+				goto transceive_end;
+			}
+			if (sr1xx_dev->total_bytes_to_read > 0) {
+				ret = spi_read(sr1xx_dev->spi,
+					       (void *)(sr1xx_dev->rx_buffer +
+							UCI_HEADER_LEN),
+					       sr1xx_dev->total_bytes_to_read);
+				if (ret < 0) {
+					dev_err(&sr1xx_dev->spi->dev,
+						"sr1xx_dev_read: spi read error.. %d\n ",
+						ret);
+					goto transceive_end;
+				}
+			}
+			sr1xx_dev->read_count =
+			    (unsigned int)(sr1xx_dev->total_bytes_to_read +
+					   UCI_HEADER_LEN);
+			sr1xx_wait_for_irq_gpio_low(sr1xx_dev);
+			ret = TRANSCEIVE_SUCCESS;
+			gpio_set_value(sr1xx_dev->spi_handshake_gpio, 0);
+		} break;
+	default:
+		dev_err(&sr1xx_dev->spi->dev, "invalid operation .....");
+		break;
+	}
+transceive_end:
+	if (sr1xx_dev->mode == SR1XX_READ_MODE)
+		gpio_set_value(sr1xx_dev->spi_handshake_gpio, 0);
+
+	mutex_unlock(&sr1xx_dev->sr1xx_access_lock);
+	return ret;
+}
+
+/**
+ * sr1xx_hbci_write
+ *
+ * Used to write hbci(SR1xx BootROM Command Interface) packets
+ * during firmware download sequence.
+ *
+ * Returns: TRANSCEIVE_SUCCESS on success or -1 on fail
+ */
+static int sr1xx_hbci_write(struct sr1xx_dev *sr1xx_dev, int count)
+{
+	int ret;
+
+	sr1xx_dev->write_count = 0;
+	/* HBCI write */
+	ret = spi_write(sr1xx_dev->spi, sr1xx_dev->tx_buffer, count);
+	if (ret < 0) {
+		ret = -EIO;
+		dev_err(&sr1xx_dev->spi->dev,
+			"spi_write fw download : Failed.\n");
+		goto hbci_write_fail;
+	}
+	sr1xx_dev->write_count = count;
+	sr1xx_enable_irq(sr1xx_dev);
+	ret = TRANSCEIVE_SUCCESS;
+	return ret;
+hbci_write_fail:
+	dev_err(&sr1xx_dev->spi->dev, "%s failed...%d", __func__, ret);
+	return ret;
+}
+
+static ssize_t sr1xx_dev_write(struct file *filp, const char *buf, size_t count,
+			       loff_t *offset)
+{
+	int ret;
+	struct sr1xx_dev *sr1xx_dev;
+
+	sr1xx_dev = filp->private_data;
+	if (count > SR1XX_MAX_TX_BUF_SIZE || count > SR1XX_TXBUF_SIZE) {
+		dev_err(&sr1xx_dev->spi->dev, "%s : Write Size Exceeds\n",
+			__func__);
+		ret = -ENOBUFS;
+		goto write_end;
+	}
+	if (copy_from_user(sr1xx_dev->tx_buffer, buf, count)) {
+		dev_err(&sr1xx_dev->spi->dev,
+			"%s : failed to copy from user space\n", __func__);
+		return -EFAULT;
+	}
+	if (sr1xx_dev->is_fw_dwnld_enabled)
+		ret = sr1xx_hbci_write(sr1xx_dev, count);
+	else
+		ret = sr1xx_dev_transceive(sr1xx_dev, SR1XX_WRITE_MODE, count);
+	if (ret == TRANSCEIVE_SUCCESS)
+		ret = sr1xx_dev->write_count;
+	else
+		dev_err(&sr1xx_dev->spi->dev, "write failed......");
+write_end:
+	return ret;
+}
+
+/**
+ * sr1xx_hbci_read
+ *
+ * Function used to read data from sr1xx on SPI line
+ * as part of firmware download sequence.
+ *
+ * Returns: Number of bytes read if read is success else (-1)
+ *               otherwise indicate each error code
+ */
+static ssize_t sr1xx_hbci_read(struct sr1xx_dev *sr1xx_dev, char *buf,
+			       size_t count)
+{
+	int ret = -EIO;
+
+	if (count > SR1XX_RXBUF_SIZE) {
+		dev_err(&sr1xx_dev->spi->dev, "count(%zu) out of range(0-%d)\n",
+			count, SR1XX_RXBUF_SIZE);
+		ret = -EINVAL;
+		goto hbci_fail;
+	}
+	/* Wait for inetrrupt upto 500ms */
+	ret = wait_event_interruptible_timeout(sr1xx_dev->read_wq,
+					       sr1xx_dev->irq_received,
+					       sr1xx_dev->timeout_in_ms);
+	if (ret == 0) {
+		dev_err(&sr1xx_dev->spi->dev,
+			"hbci wait_event_interruptible timeout() : Failed.\n");
+		ret = -1;
+		goto hbci_fail;
+	}
+	if (sr1xx_dev->read_abort_requested) {
+		sr1xx_dev->read_abort_requested = false;
+		dev_err(&sr1xx_dev->spi->dev, "HBCI Abort Read pending......");
+		return ret;
+	}
+	if (!gpio_get_value(sr1xx_dev->irq_gpio)) {
+		dev_err(&sr1xx_dev->spi->dev,
+			"IRQ is low during firmware download");
+		goto hbci_fail;
+	}
+	ret = spi_read(sr1xx_dev->spi, (void *)sr1xx_dev->rx_buffer, count);
+	if (ret < 0) {
+		dev_err(&sr1xx_dev->spi->dev,
+			"sr1xx_dev_read: spi read error %d\n ", ret);
+		goto hbci_fail;
+	}
+	ret = count;
+	if (copy_to_user(buf, sr1xx_dev->rx_buffer, count)) {
+		dev_err(&sr1xx_dev->spi->dev,
+			"sr1xx_dev_read: copy to user failed\n");
+		ret = -EFAULT;
+	}
+	return ret;
+hbci_fail:
+	dev_err(&sr1xx_dev->spi->dev, "Error sr1xx_fw_download ret %d Exit\n",
+		ret);
+	return ret;
+}
+
+static ssize_t sr1xx_dev_read(struct file *filp, char *buf, size_t count,
+			      loff_t *offset)
+{
+	struct sr1xx_dev *sr1xx_dev = filp->private_data;
+	int ret = -EIO;
+
+	/* 500ms timeout in jiffies */
+	sr1xx_dev->timeout_in_ms = ((500 * HZ) / 1000);
+	memset(sr1xx_dev->rx_buffer, 0x00, SR1XX_RXBUF_SIZE);
+	if (!gpio_get_value(sr1xx_dev->irq_gpio)) {
+		if (filp->f_flags & O_NONBLOCK) {
+			ret = -EAGAIN;
+			goto read_end;
+		}
+	}
+	/* HBCI packet read */
+	if (sr1xx_dev->is_fw_dwnld_enabled) {
+		ret = sr1xx_hbci_read(sr1xx_dev, buf, count);
+		goto read_end;
+	}
+	/* UCI packet read */
+	do {
+		sr1xx_enable_irq(sr1xx_dev);
+		if (!sr1xx_dev->read_abort_requested) {
+			ret = wait_event_interruptible(sr1xx_dev->read_wq,
+						       sr1xx_dev->irq_received);
+			if (ret) {
+				dev_err(&sr1xx_dev->spi->dev,
+					"wait_event_interruptible() : Failed.\n");
+				goto read_end;
+			}
+		}
+		if (sr1xx_dev->read_abort_requested) {
+			sr1xx_dev->read_abort_requested = false;
+			dev_err(&sr1xx_dev->spi->dev,
+				"Abort Read pending......");
+			goto read_end;
+		}
+		ret = sr1xx_dev_transceive(sr1xx_dev, SR1XX_READ_MODE, count);
+		if (ret == IRQ_WAIT_REQUEST) {
+			dev_err(&sr1xx_dev->spi->dev,
+				"Irg is low due to write hence irq is requested again...");
+		}
+	} while (ret == IRQ_WAIT_REQUEST);
+	if (ret == TRANSCEIVE_SUCCESS) {
+		if (copy_to_user(buf, sr1xx_dev->rx_buffer,
+				 sr1xx_dev->read_count)) {
+			dev_err(&sr1xx_dev->spi->dev,
+				"%s: copy to user failed\n", __func__);
+			ret = -EFAULT;
+			goto read_end;
+		}
+		ret = sr1xx_dev->read_count;
+	} else if (ret == IRQ_WAIT_TIMEOUT) {
+		dev_err(&sr1xx_dev->spi->dev,
+			"Second irq is not received..Time out...");
+		ret = -ETIME;
+	} else {
+		dev_err(&sr1xx_dev->spi->dev, "spi read failed...%d", ret);
+		ret = -EIO;
+	}
+read_end:
+	return ret;
+}
+
+static int sr1xx_hw_setup(struct device *dev,
+			  struct sr1xx_spi_platform_data *platform_data)
+{
+	int result = 0;
+
+	platform_data->gpiod_irq =
+	    devm_gpiod_get(dev, "nxp,sr1xx-irq", GPIOD_IN);
+	platform_data->gpiod_ce =
+	    devm_gpiod_get(dev, "nxp,sr1xx-ce", GPIOD_OUT_LOW);
+	platform_data->gpiod_spi_handshake =
+	    devm_gpiod_get(dev, "nxp,sr1xx-ri", GPIOD_OUT_LOW);
+	if (IS_ERR(platform_data->gpiod_irq)) {
+		dev_err(dev, "Failed fetching gpiod for irq\n");
+		return -EINVAL;
+	}
+	if (IS_ERR(platform_data->gpiod_ce)) {
+		dev_err(dev, "Failed fetching gpiod for ce\n");
+		return -EINVAL;
+	}
+	if (IS_ERR(platform_data->gpiod_spi_handshake)) {
+		dev_err(dev, "Failed fetching gpiod for spi handshake\n");
+		return -EINVAL;
+	}
+	dev_info(dev, "irq_gpio = %d, ce_gpio = %d, spi_handshake_gpio = %d\n",
+		 desc_to_gpio(platform_data->gpiod_irq),
+		 desc_to_gpio(platform_data->gpiod_ce),
+		 desc_to_gpio(platform_data->gpiod_spi_handshake));
+	return result;
+}
+
+static inline void sr1xx_set_data(struct spi_device *spi, void *data)
+{
+	dev_set_drvdata(&spi->dev, data);
+}
+
+static inline void *sr1xx_get_data(const struct spi_device *spi)
+{
+	return dev_get_drvdata(&spi->dev);
+}
+
+/* Possible fops on the sr1xx device */
+static const struct file_operations sr1xx_dev_fops = {
+	.owner = THIS_MODULE,
+	.read = sr1xx_dev_read,
+	.write = sr1xx_dev_write,
+	.open = sr1xx_dev_open,
+	.unlocked_ioctl = sr1xx_dev_ioctl,
+};
+
+/**
+ * sr1xx_gpio_cleanup
+ *
+ * Release requested gpios
+ *
+ */
+static void sr1xx_gpio_cleanup(struct device *dev,
+			       struct sr1xx_spi_platform_data *pdata)
+{
+	if (!IS_ERR(pdata->gpiod_ce))
+		devm_gpiod_put(dev, pdata->gpiod_ce);
+	if (!IS_ERR(pdata->gpiod_irq))
+		devm_gpiod_put(dev, pdata->gpiod_irq);
+	if (!IS_ERR(pdata->gpiod_spi_handshake))
+		devm_gpiod_put(dev, pdata->gpiod_spi_handshake);
+}
+
+static int sr1xx_probe(struct spi_device *spi)
+{
+	int ret;
+	struct sr1xx_spi_platform_data platform_data;
+	struct sr1xx_dev *sr1xx_dev = NULL;
+	unsigned int irq_flags;
+
+	dev_info(&spi->dev, "%s chip select : %d , bus number = %d\n", __func__,
+		 spi->chip_select, spi->master->bus_num);
+
+	sr1xx_dev = kzalloc(sizeof(*sr1xx_dev), GFP_KERNEL);
+	if (!sr1xx_dev) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+	ret = sr1xx_hw_setup(&spi->dev, &platform_data);
+	if (ret < 0) {
+		dev_err(&spi->dev, "Failed hw_setup\n");
+		goto err_setup;
+	}
+
+	spi->bits_per_word = 8;
+	spi->mode = SPI_MODE_0;
+	spi->max_speed_hz = SR1XX_SPI_CLOCK;
+	ret = spi_setup(spi);
+	if (ret < 0) {
+		dev_err(&spi->dev, "failed to do spi_setup()\n");
+		goto err_setup;
+	}
+
+	sr1xx_dev->spi = spi;
+	sr1xx_dev->sr1xx_device.minor = MISC_DYNAMIC_MINOR;
+	sr1xx_dev->sr1xx_device.name = "sr1xx";
+	sr1xx_dev->sr1xx_device.fops = &sr1xx_dev_fops;
+	sr1xx_dev->sr1xx_device.parent = &spi->dev;
+	sr1xx_dev->irq_gpio = desc_to_gpio(platform_data.gpiod_irq);
+	sr1xx_dev->ce_gpio = desc_to_gpio(platform_data.gpiod_ce);
+	sr1xx_dev->spi_handshake_gpio =
+	    desc_to_gpio(platform_data.gpiod_spi_handshake);
+
+	dev_set_drvdata(&spi->dev, sr1xx_dev);
+
+	/* init mutex and queues */
+	init_waitqueue_head(&sr1xx_dev->read_wq);
+	mutex_init(&sr1xx_dev->sr1xx_access_lock);
+
+	spin_lock_init(&sr1xx_dev->irq_enabled_lock);
+
+	ret = misc_register(&sr1xx_dev->sr1xx_device);
+	if (ret < 0) {
+		dev_err(&spi->dev, "misc_register failed! %d\n", ret);
+		goto err_setup;
+	}
+
+	sr1xx_dev->tx_buffer = kzalloc(SR1XX_TXBUF_SIZE, GFP_KERNEL);
+	sr1xx_dev->rx_buffer = kzalloc(SR1XX_RXBUF_SIZE, GFP_KERNEL);
+	if (!sr1xx_dev->tx_buffer) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+	if (!sr1xx_dev->rx_buffer) {
+		ret = -ENOMEM;
+		goto err_exit;
+	}
+
+	sr1xx_dev->spi->irq = gpio_to_irq(sr1xx_dev->irq_gpio);
+	if (sr1xx_dev->spi->irq < 0) {
+		dev_err(&spi->dev, "gpio_to_irq request failed gpio = 0x%x\n",
+			sr1xx_dev->irq_gpio);
+		goto err_exit;
+	}
+	/* request irq. The irq is set whenever the chip has data available
+	 * for reading. It is cleared when all data has been read.
+	 */
+	irq_flags = IRQ_TYPE_LEVEL_HIGH;
+	sr1xx_dev->irq_enabled = true;
+	sr1xx_dev->irq_received = false;
+
+	ret = request_irq(sr1xx_dev->spi->irq, sr1xx_dev_irq_handler, irq_flags,
+			  sr1xx_dev->sr1xx_device.name, sr1xx_dev);
+	if (ret) {
+		dev_err(&spi->dev, "request_irq failed\n");
+		goto err_exit;
+	}
+	sr1xx_disable_irq(sr1xx_dev);
+	return 0;
+err_exit:
+	if (sr1xx_dev) {
+		kfree(sr1xx_dev->tx_buffer);
+		kfree(sr1xx_dev->rx_buffer);
+		misc_deregister(&sr1xx_dev->sr1xx_device);
+	}
+err_setup:
+	if (sr1xx_dev)
+		mutex_destroy(&sr1xx_dev->sr1xx_access_lock);
+	sr1xx_gpio_cleanup(&spi->dev, &platform_data);
+	kfree(sr1xx_dev);
+	dev_err(&spi->dev, "ERROR: Exit : %s ret %d\n", __func__, ret);
+	return ret;
+}
+
+static void sr1xx_remove(struct spi_device *spi)
+{
+	struct sr1xx_dev *sr1xx_dev = sr1xx_get_data(spi);
+
+	if (!sr1xx_dev) {
+		dev_err(&spi->dev, "sr1xx_dev is NULL\n");
+		return;
+	}
+	gpio_free(sr1xx_dev->ce_gpio);
+	mutex_destroy(&sr1xx_dev->sr1xx_access_lock);
+	free_irq(sr1xx_dev->spi->irq, sr1xx_dev);
+	gpio_free(sr1xx_dev->irq_gpio);
+	gpio_free(sr1xx_dev->spi_handshake_gpio);
+	misc_deregister(&sr1xx_dev->sr1xx_device);
+	if (sr1xx_dev) {
+		kfree(sr1xx_dev->tx_buffer);
+		kfree(sr1xx_dev->rx_buffer);
+		kfree(sr1xx_dev);
+	}
+}
+
+/**
+ * sr1xx_dev_suspend
+ *
+ * Executed before putting the system into a sleep state
+ *
+ */
+int sr1xx_dev_suspend(struct device *dev)
+{
+	struct sr1xx_dev *sr1xx_dev = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		disable_irq_wake(sr1xx_dev->spi->irq);
+	return 0;
+}
+
+/**
+ * sr1xx_dev_resume
+ *
+ * Executed after waking the system up from a sleep state
+ *
+ */
+int sr1xx_dev_resume(struct device *dev)
+{
+	struct sr1xx_dev *sr1xx_dev = dev_get_drvdata(dev);
+
+	if (device_may_wakeup(dev))
+		enable_irq_wake(sr1xx_dev->spi->irq);
+
+	return 0;
+}
+
+static const struct of_device_id sr1xx_dt_match[] = {
+	{
+	 .compatible = "nxp,sr1xx",
+	 },
+	{}
+};
+
+static const struct acpi_device_id sr1xx_acpi_match[] = {
+	{"PRP0001", 0},
+	{"", 0},
+};
+
+MODULE_DEVICE_TABLE(acpi, sr1xx_acpi_match);
+
+static const struct dev_pm_ops sr1xx_dev_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(sr1xx_dev_suspend, sr1xx_dev_resume)
+};
+
+static struct spi_driver sr1xx_driver = {
+	.driver = {
+		   .name = "sr1xx",
+		   .pm = &sr1xx_dev_pm_ops,
+		   .of_match_table = sr1xx_dt_match,
+		   .acpi_match_table = sr1xx_acpi_match,
+		   },
+	.probe = sr1xx_probe,
+	.remove = sr1xx_remove,
+};
+
+static int __init sr1xx_dev_init(void)
+{
+	return spi_register_driver(&sr1xx_driver);
+}
+
+module_init(sr1xx_dev_init);
+
+static void __exit sr1xx_dev_exit(void)
+{
+	spi_unregister_driver(&sr1xx_driver);
+}
+
+module_exit(sr1xx_dev_exit);
+
+MODULE_AUTHOR("Manjunatha Venkatesh <manjunatha.venkatesh@nxp.com>");
+MODULE_DESCRIPTION("NXP SR1XX SPI driver");
+MODULE_LICENSE("GPL");
--
2.37.2

