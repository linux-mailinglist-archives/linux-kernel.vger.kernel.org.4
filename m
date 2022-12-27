Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFB8656E57
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 20:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiL0TdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 14:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbiL0TdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 14:33:00 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA05CCDD
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:32:58 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id p6so7314821iod.13
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 11:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lhVBRX6mEeqjrbQaNrnuTseHHWQmf0qBMhdf/prhA8Q=;
        b=d56W4tyOOlA8X+zf1fgOS7wpOaspo0rVMYZkqF8xdGOsUngNqTNxcwTDSMKVifsPtP
         Vb97x6KggpVAfXwEPBqEC/mW03XuTpW18a31JWXT8LlQGqm/QIPdU/9uhISrT4MWNUlA
         H0jhW/CEpJFhM5VSW7euJKCziqVI0EVsvhQMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lhVBRX6mEeqjrbQaNrnuTseHHWQmf0qBMhdf/prhA8Q=;
        b=JpyeXdj0Xj+TOZMifxR5h7TNPUV47Q8HJFmZ1hCxnhiU7L6CQPsixuBQItSzOB+982
         yB85DsjyQggsjKmAUd0a9EapFGkB8S6ga9tLZvl7sCB1AUYGWjs+hg5B4iA6U6aigW/g
         cHxZHsnJe82m7dJWIdtV9yf7hF5er8OHWylyfzYTRUUpwogXlqjfWwaANU28EoZ0vmRK
         eevsiSnqooHA2vqU5s8zM6UqUPxazrkoeUqxWxN7/jxlw09GohKkMi3Uot/oC/OAYZQx
         DfCs2oyVZ3V+nYwWBNO4DFYdCZ2m0h4EydVv3mJLMajvgZQtfzvLCZPBNhZJJkyUzXho
         hQow==
X-Gm-Message-State: AFqh2kpyfQ1iqS1fSIQxgPirQAuVlA5OdI0V5httTVXfok2Yft0qyAb8
        vfwDkqZbNkMHWvZSzUobMOqkLNMn5Ez098mM
X-Google-Smtp-Source: AMrXdXtWZ8O86whQ+2ZxcY4MD3uuJXeR4cQaMc7xlwZBOq1wjp/jLoagSGqQJyJdYPCEQD5tQe4H7Q==
X-Received: by 2002:a5d:860d:0:b0:6e1:a62e:f658 with SMTP id f13-20020a5d860d000000b006e1a62ef658mr15551113iol.18.1672169577976;
        Tue, 27 Dec 2022 11:32:57 -0800 (PST)
Received: from markhas1.corp.google.com ([100.107.108.223])
        by smtp.gmail.com with ESMTPSA id a10-20020a02ac0a000000b003755a721e98sm4504995jao.107.2022.12.27.11.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Dec 2022 11:32:57 -0800 (PST)
From:   Mark Hasemeyer <markhas@chromium.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Raul Rangel <rrangel@chromium.org>,
        Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        Mark Hasemeyer <markhas@chromium.org>,
        Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev
Subject: [PATCH v13 1/3] platform/chrome: cros_ec_uart: Add transport layer
Date:   Tue, 27 Dec 2022 12:32:22 -0700
Message-Id: <20221227123212.v13.1.If7926fcbad397bc6990dd725690229bed403948c@changeid>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhanu Prakash Maiya <bhanumaiya@chromium.org>

This patch does following:
1. Adds a new cros-ec-uart driver. This driver can send EC requests on
   UART and process response packets received on UART transport.
2. Once probed, this driver will initialize the serdev device based on
   the underlying information in the ACPI resource. After serdev device
   properties are set, this driver will register itself cros-ec.
3. High level driver can use this implementation to talk to ChromeOS
   Embedded Controller device in case it supports UART as transport.
4. When cros-ec driver initiates a request packet, outgoing message is
   processed in buffer and sent via serdev. Once bytes are sent, driver
   enables a wait_queue.
5. Since ChromeOS EC device sends response asynchronously, AP's TTY
   driver accumulates response bytes and calls the registered callback.
   TTY driver can send multiple callback for bytes ranging from 1 to MAX
   bytes supported by EC device.
6. Driver waits for EC_MSG_DEADLINE_MS to collect and process received
   bytes. It wakes wait_queue if expected bytes are received or else
   wait_queue timeout. Based on the error condition, driver returns
   data_len or error to cros_ec.

Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@chromium.org>
Co-developed-by: Mark Hasemeyer <markhas@chromium.org>
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
Reviewed-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v13:
- Introduce resp pointer to improve readability
- Remove whitespace
- Initialize sum variable just in time to improve readability
- Initialize ec_uart->serdev just in time to improve readability
- Update commit message to be more concise
- Remove tag: Reported-by: kernel test robot <lkp@intel.com>

Changes in v12:
- No change

Changes in v11:
- Clarify error status in documentation
- Join more multi-line statments onto a single line if < 100 chars
- Add newline to the end of some printks
- Terminate acpi_device_id with a NULL entry
- Fix serdev doc warning for cros_ec_uart struct

Changes in v10:
- Remove superfluous comments
- Remove unneeded #include
- Use uninterruptible variant of wait_event
- Merge error and received variables into a single status var
- White space alignment
- Add warning message when byes are received out of band
- Join some multi-line statments onto a single line if < 100 chars

Changes in v9:
- Rebase onto for-next
- Update contact information in MAINTAINERS
- Remove superfluous comments
- Invert conditional logic checking response size
- Update authorship
- Convert single case switch statement to if conditional
- Reorder initializer list in increasing order of line length
- Use wait_event_timeout return value to detect timeout
- Remove unnecessary zeroizing of ec_uart struct
- Set received conditional on -EMSGSIZE error case
- Join dev_err msg onto single line where possible

Changes in v8:
- Combine for loops used for xsum calculation
- Use ec_dev->dev instead of serdev->dev
- Sort includes
- Swap struct var order to match doc order
- fix whitespace
- Update contact information in MAINTAINERS
- Update copyright date

Changes in v7:
- Use ACPI ID matching
- Change MODULE_LICENSE from GPL v2 to GPL

Changes in v6:
- Tuning EC_MSG_DEADLINE_MS from 1 sec to 500 msec. Since the EC's UART
  response buffer was tuned and redeuced to 256 byte, 500 msec timeout
  should give enough time for 256 bytes to be recieved from SoC  UART
  buffer.

Changes in v5:
- Fixed checkpatch.pl warnings.

Changes in v4:
- Change EC_MSG_DEADLINE_MS from 3 secs to 1 sec. 3 secs timeout prevents
  driver from intercepting EC in RO stage. In case of request failure, 1
  sec allows driver to retry and send HC when EC is in RO.
- Add more information in commit message.

Changes in v3:
- checkpatch.pl script warns about char len 80 even though we have
  relaxed view guideline for line below 100 chars. Currently sticking
  with 80 chars in v3.
- Fixed style issues

Changes in v2:
- Fixed build error on v1.
- Changed EC timeout for response packet to 3 Sec and added comments.
- Fixed cros_ec_uart_rx_bytes function to handle rx buffer < size of response header.

---
 MAINTAINERS                            |   7 +
 drivers/platform/chrome/Kconfig        |  10 +
 drivers/platform/chrome/Makefile       |   1 +
 drivers/platform/chrome/cros_ec_uart.c | 352 +++++++++++++++++++++++++
 4 files changed, 370 insertions(+)
 create mode 100644 drivers/platform/chrome/cros_ec_uart.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f61eb221415bd..49b0f0525502f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4985,6 +4985,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/google,cros-ec-codec.yaml
 F:	sound/soc/codecs/cros_ec_codec.*
 
+CHROMEOS EC UART DRIVER
+M:	Bhanu Prakash Maiya <bhanumaiya@chromium.org>
+R:	Benson Leung <bleung@chromium.org>
+R:	Tzung-Bi Shih <tzungbi@kernel.org>
+S:	Maintained
+F:	drivers/platform/chrome/cros_ec_uart.c
+
 CHROMEOS EC SUBDRIVERS
 M:	Benson Leung <bleung@chromium.org>
 R:	Guenter Roeck <groeck@chromium.org>
diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
index c1ca247987d2d..0d272c87f32b2 100644
--- a/drivers/platform/chrome/Kconfig
+++ b/drivers/platform/chrome/Kconfig
@@ -119,6 +119,16 @@ config CROS_EC_SPI
 	  response time cannot be guaranteed, we support ignoring
 	  'pre-amble' bytes before the response actually starts.
 
+config CROS_EC_UART
+	tristate "ChromeOS Embedded Controller (UART)"
+	depends on CROS_EC && ACPI && SERIAL_DEV_BUS
+	help
+	  If you say Y here, you get support for talking to the ChromeOS EC
+	  through a UART, using a byte-level protocol.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called cros_ec_uart.
+
 config CROS_EC_LPC
 	tristate "ChromeOS Embedded Controller (LPC)"
 	depends on CROS_EC && ACPI && (X86 || COMPILE_TEST)
diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
index f6068d077a40a..0f39edef660dd 100644
--- a/drivers/platform/chrome/Makefile
+++ b/drivers/platform/chrome/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
 obj-$(CONFIG_CROS_TYPEC_SWITCH)		+= cros_typec_switch.o
 obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
 obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
+obj-$(CONFIG_CROS_EC_UART)		+= cros_ec_uart.o
 cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
 obj-$(CONFIG_CROS_EC_TYPEC)		+= cros_ec_typec.o
 obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
diff --git a/drivers/platform/chrome/cros_ec_uart.c b/drivers/platform/chrome/cros_ec_uart.c
new file mode 100644
index 0000000000000..971ea4bc2df80
--- /dev/null
+++ b/drivers/platform/chrome/cros_ec_uart.c
@@ -0,0 +1,352 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * UART interface for ChromeOS Embedded Controller
+ *
+ * Copyright 2020-2022 Google LLC.
+ */
+
+#include <linux/acpi.h>
+#include <linux/delay.h>
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_data/cros_ec_proto.h>
+#include <linux/serdev.h>
+#include <linux/slab.h>
+#include <uapi/linux/sched/types.h>
+
+#include "cros_ec.h"
+
+/*
+ * EC sends contiguous bytes of response packet on UART AP RX.
+ * TTY driver in AP accumulates incoming bytes and calls the registered callback
+ * function. Byte count can range from 1 to MAX bytes supported by EC.
+ * This driver should wait for long time for all callbacks to be processed.
+ * Considering the worst case scenario, wait for 500 msec. This timeout should
+ * account for max latency and some additional guard time.
+ * Best case: Entire packet is received in ~200 ms, wait queue will be released
+ * and packet will be processed.
+ * Worst case: TTY driver sends bytes in multiple callbacks. In this case this
+ * driver will wait for ~1 sec beyond which it will timeout.
+ * This timeout value should not exceed ~500 msec because in case if
+ * EC_CMD_REBOOT_EC sent, high level driver should be able to intercept EC
+ * in RO.
+ */
+#define EC_MSG_DEADLINE_MS		500
+
+/**
+ * struct response_info - Encapsulate EC response related
+ *			information for passing between function
+ *			cros_ec_uart_pkt_xfer() and cros_ec_uart_rx_bytes()
+ *			callback.
+ * @data:		Copy the data received from EC here.
+ * @max_size:		Max size allocated for the @data buffer. If the
+ *			received data exceeds this value, we log an error.
+ * @size:		Actual size of data received from EC. This is also
+ *			used to accumulate byte count with response is received
+ *			in dma chunks.
+ * @exp_len:		Expected bytes of response from EC including header.
+ * @status:		Re-init to 0 before sending a cmd. Updated to 1 when
+ *			a response is successfully received, or an error number
+ *			on failure.
+ * @wait_queue:	Wait queue EC response where the cros_ec sends request
+ *			to EC and waits
+ */
+struct response_info {
+	void *data;
+	size_t max_size;
+	size_t size;
+	size_t exp_len;
+	int status;
+	wait_queue_head_t wait_queue;
+};
+
+/**
+ * struct cros_ec_uart - information about a uart-connected EC
+ *
+ * @serdev:		serdev uart device we are connected to.
+ * @baudrate:		UART baudrate of attached EC device.
+ * @flowcontrol:	UART flowcontrol of attached device.
+ * @irq:		Linux IRQ number of associated serial device.
+ * @response:		Response info passing between cros_ec_uart_pkt_xfer()
+ *			and cros_ec_uart_rx_bytes()
+ */
+struct cros_ec_uart {
+	struct serdev_device *serdev;
+	u32 baudrate;
+	u8 flowcontrol;
+	u32 irq;
+	struct response_info response;
+};
+
+static int cros_ec_uart_rx_bytes(struct serdev_device *serdev,
+				 const u8 *data,
+				 size_t count)
+{
+	struct ec_host_response *host_response;
+	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
+	struct cros_ec_uart *ec_uart = ec_dev->priv;
+	struct response_info *resp = &ec_uart->response;
+
+	/* Check if bytes were sent out of band */
+	if (!resp->data) {
+		/* Discard all bytes */
+		dev_warn(ec_dev->dev, "Bytes received out of band, dropping them.\n");
+		return count;
+	}
+
+	/*
+	 * Check if incoming bytes + resp->size is greater than allocated
+	 * buffer in din by cros_ec. This will ensure that if EC sends more
+	 * bytes than max_size, waiting process will be notified with an error.
+	 */
+	if (resp->size + count > resp->max_size) {
+		resp->status = -EMSGSIZE;
+		wake_up(&resp->wait_queue);
+		return count;
+	}
+
+	memcpy(resp->data + resp->size, data, count);
+
+	resp->size += count;
+
+	/* Read data_len if we received response header and if exp_len was not read before. */
+	if (resp->size >= sizeof(*host_response) && resp->exp_len == 0) {
+		host_response = (struct ec_host_response *)resp->data;
+		resp->exp_len = host_response->data_len + sizeof(*host_response);
+	}
+
+	/* If driver received response header and payload from EC, wake up the wait queue. */
+	if (resp->size >= sizeof(*host_response) && resp->size == resp->exp_len) {
+		resp->status = 1;
+		wake_up(&resp->wait_queue);
+	}
+
+	return count;
+}
+
+static int cros_ec_uart_pkt_xfer(struct cros_ec_device *ec_dev,
+				 struct cros_ec_command *ec_msg)
+{
+	struct cros_ec_uart *ec_uart = ec_dev->priv;
+	struct serdev_device *serdev = ec_uart->serdev;
+	struct response_info *resp = &ec_uart->response;
+	struct ec_host_response *host_response;
+	unsigned int len;
+	int ret, i;
+	u8 sum;
+
+	len = cros_ec_prepare_tx(ec_dev, ec_msg);
+	dev_dbg(ec_dev->dev, "Prepared len=%d\n", len);
+
+	/* Setup for incoming response */
+	resp->data = ec_dev->din;
+	resp->max_size = ec_dev->din_size;
+	resp->size = 0;
+	resp->exp_len = 0;
+	resp->status = 0;
+
+	ret = serdev_device_write_buf(serdev, ec_dev->dout, len);
+	if (ret < len) {
+		dev_err(ec_dev->dev, "Unable to write data\n");
+		ret = -EIO;
+		goto exit;
+	}
+
+	ret = wait_event_timeout(resp->wait_queue, resp->status,
+				 msecs_to_jiffies(EC_MSG_DEADLINE_MS));
+	if (ret == 0) {
+		dev_warn(ec_dev->dev, "Timed out waiting for response.\n");
+		ret = -ETIMEDOUT;
+		goto exit;
+	}
+
+	if (resp->status < 0) {
+		ret = resp->status;
+		dev_warn(ec_dev->dev, "Error response received: %d\n", ret);
+		goto exit;
+	}
+
+	host_response = (struct ec_host_response *)ec_dev->din;
+	ec_msg->result = host_response->result;
+
+	if (host_response->data_len > ec_msg->insize) {
+		dev_err(ec_dev->dev, "Resp too long (%d bytes, expected %d)\n",
+			host_response->data_len, ec_msg->insize);
+		ret = -ENOSPC;
+		goto exit;
+	}
+
+	/* Validate checksum */
+	sum = 0;
+	for (i = 0; i < sizeof(*host_response) + host_response->data_len; i++)
+		sum += ec_dev->din[i];
+
+	if (sum) {
+		dev_err(ec_dev->dev, "Bad packet checksum calculated %x\n", sum);
+		ret = -EBADMSG;
+		goto exit;
+	}
+
+	memcpy(ec_msg->data, ec_dev->din + sizeof(*host_response), host_response->data_len);
+
+	ret = host_response->data_len;
+
+exit:
+	/* Invalidate response buffer to guard against out of band rx data */
+	resp->data = NULL;
+
+	if (ec_msg->command == EC_CMD_REBOOT_EC)
+		msleep(EC_REBOOT_DELAY_MS);
+
+	return ret;
+}
+
+static int cros_ec_uart_resource(struct acpi_resource *ares, void *data)
+{
+	struct cros_ec_uart *ec_uart = data;
+	struct acpi_resource_uart_serialbus *sb = &ares->data.uart_serial_bus;
+
+	if (ares->type == ACPI_RESOURCE_TYPE_SERIAL_BUS &&
+	    sb->type == ACPI_RESOURCE_SERIAL_TYPE_UART) {
+		ec_uart->baudrate = sb->default_baud_rate;
+		dev_dbg(&ec_uart->serdev->dev, "Baudrate %d\n", ec_uart->baudrate);
+
+		ec_uart->flowcontrol = sb->flow_control;
+		dev_dbg(&ec_uart->serdev->dev, "Flow control %d\n", ec_uart->flowcontrol);
+	}
+
+	return 0;
+}
+
+static int cros_ec_uart_acpi_probe(struct cros_ec_uart *ec_uart)
+{
+	int ret;
+	LIST_HEAD(resources);
+	struct acpi_device *adev = ACPI_COMPANION(&ec_uart->serdev->dev);
+
+	ret = acpi_dev_get_resources(adev, &resources, cros_ec_uart_resource, ec_uart);
+	if (ret < 0)
+		return ret;
+
+	acpi_dev_free_resource_list(&resources);
+
+	/* Retrieve GpioInt and translate it to Linux IRQ number */
+	ret = acpi_dev_gpio_irq_get(adev, 0);
+	if (ret < 0)
+		return ret;
+
+	ec_uart->irq = ret;
+	dev_dbg(&ec_uart->serdev->dev, "IRQ number %d\n", ec_uart->irq);
+
+	return 0;
+}
+
+static const struct serdev_device_ops cros_ec_uart_client_ops = {
+	.receive_buf = cros_ec_uart_rx_bytes,
+};
+
+static int cros_ec_uart_probe(struct serdev_device *serdev)
+{
+	struct device *dev = &serdev->dev;
+	struct cros_ec_device *ec_dev;
+	struct cros_ec_uart *ec_uart;
+	int ret;
+
+	ec_uart = devm_kzalloc(dev, sizeof(*ec_uart), GFP_KERNEL);
+	if (!ec_uart)
+		return -ENOMEM;
+
+	ec_dev = devm_kzalloc(dev, sizeof(*ec_dev), GFP_KERNEL);
+	if (!ec_dev)
+		return -ENOMEM;
+
+	ret = devm_serdev_device_open(dev, serdev);
+	if (ret) {
+		dev_err(dev, "Unable to open UART device");
+		return ret;
+	}
+
+	serdev_device_set_drvdata(serdev, ec_dev);
+	serdev_device_set_client_ops(serdev, &cros_ec_uart_client_ops);
+	init_waitqueue_head(&ec_uart->response.wait_queue);
+
+	ec_uart->serdev = serdev;
+
+	ret = cros_ec_uart_acpi_probe(ec_uart);
+	if (ret < 0) {
+		dev_err(dev, "Failed to get ACPI info (%d)", ret);
+		return ret;
+	}
+
+	ret = serdev_device_set_baudrate(serdev, ec_uart->baudrate);
+	if (ret < 0) {
+		dev_err(dev, "Failed to set up host baud rate (%d)", ret);
+		return ret;
+	}
+
+	serdev_device_set_flow_control(serdev, ec_uart->flowcontrol);
+
+	/* Initialize ec_dev for cros_ec  */
+	ec_dev->phys_name = dev_name(dev);
+	ec_dev->dev = dev;
+	ec_dev->priv = ec_uart;
+	ec_dev->irq = ec_uart->irq;
+	ec_dev->cmd_xfer = NULL;
+	ec_dev->pkt_xfer = cros_ec_uart_pkt_xfer;
+	ec_dev->din_size = sizeof(struct ec_host_response) +
+			   sizeof(struct ec_response_get_protocol_info);
+	ec_dev->dout_size = sizeof(struct ec_host_request);
+
+	return cros_ec_register(ec_dev);
+}
+
+static void cros_ec_uart_remove(struct serdev_device *serdev)
+{
+	struct cros_ec_device *ec_dev = serdev_device_get_drvdata(serdev);
+
+	cros_ec_unregister(ec_dev);
+};
+
+static int __maybe_unused cros_ec_uart_suspend(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_suspend(ec_dev);
+}
+
+static int __maybe_unused cros_ec_uart_resume(struct device *dev)
+{
+	struct cros_ec_device *ec_dev = dev_get_drvdata(dev);
+
+	return cros_ec_resume(ec_dev);
+}
+
+static SIMPLE_DEV_PM_OPS(cros_ec_uart_pm_ops, cros_ec_uart_suspend,
+			 cros_ec_uart_resume);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cros_ec_uart_acpi_id[] = {
+	{ "GOOG0019", 0 },
+	{}
+};
+
+MODULE_DEVICE_TABLE(acpi, cros_ec_uart_acpi_id);
+#endif
+
+static struct serdev_device_driver cros_ec_uart_driver = {
+	.driver	= {
+		.name	= "cros-ec-uart",
+		.acpi_match_table = ACPI_PTR(cros_ec_uart_acpi_id),
+		.pm	= &cros_ec_uart_pm_ops,
+	},
+	.probe		= cros_ec_uart_probe,
+	.remove		= cros_ec_uart_remove,
+};
+
+module_serdev_device_driver(cros_ec_uart_driver);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("UART interface for ChromeOS Embedded Controller");
+MODULE_AUTHOR("Bhanu Prakash Maiya <bhanumaiya@chromium.org>");
-- 
2.39.0.314.g84b9a713c41-goog

