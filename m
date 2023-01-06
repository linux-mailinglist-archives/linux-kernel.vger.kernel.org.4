Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBDE0660199
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjAFNyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 08:54:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234484AbjAFNxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 08:53:51 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20349777F8
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 05:53:49 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r2so1323239wrv.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 05:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7KVItfpNtRK6pwANzgpudn1/hZ6MgJU0uBwIKFq2aQ=;
        b=JBDKQ7Hs/LOLgQC/kgQLW3jdvNRN7yR5uivFa9wPoBYzrtx1dGmmHR1X/nwL6pUFUG
         0KH1orI97wRcIsBYz8+E3pPoFK7+t97vFSglCVyQtuqJyNKKYmy8FEUrAOLorTi/FlF/
         ev+7W/UpDFj9BZiOyc5TV+T2MSfppbrk1hUllpRglpuRc8QWLVZzLLMxiD0tkZEsQ8UE
         HvFmWNZZN4geogik7Kb5dKK2xvk9+qG/8R5u0GPZEVXmiqJ058l7eIiCev1JsfRofzPT
         YGJvPRGiS2YjP5Vr29yaxYHWvDm/VxoprS2U2gd8jPviAc5AA/ojUHlj1jDU2vQIxe90
         Um0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K7KVItfpNtRK6pwANzgpudn1/hZ6MgJU0uBwIKFq2aQ=;
        b=02DWptX5phKwJp+tI96F3wTLxE7rakAheJniTUNCyGl2xUvywf1TdK+zM760kFP0ab
         BbiC+Y406ocNGYAqwoDPC1smELcr4f6UYac6dvqUFt0ATkrDOvO49/ixtECjdxkxe+Uq
         WzHcaUlblgF8gPuNYSYiqZ8OIKPir/XRQrJh6tcbFXTBKlPWONlO0dCRBYaJH16FrU7X
         OrkNcQ6YJcR+IjHFer38KHLxd1ahPD/QhC9ZSTwWQeIlb5G88wf2Ch5W4o10A7N47TUq
         6vVOr0bHMp+EkD7VZ2swVHW8dCMaEcJaWR+3qrIZHYBPBl7Vm1326VZlcgYxJwUME96V
         g5AQ==
X-Gm-Message-State: AFqh2kqXnX4eUKnxTRKPeKGPiQv+hfj0ftCHxKk8IrOHhPVrGr+d1VNx
        kUp8Cuf+E4PjhO5tiCjTq4DeNQ==
X-Google-Smtp-Source: AMrXdXvNaQv0pyDaykAfhmYnStNGB/KA4AXFy8TsuhrOa7s/YRSNmt40HK903Tt4o37QM7q5qR26oQ==
X-Received: by 2002:a5d:6591:0:b0:277:cd3d:be10 with SMTP id q17-20020a5d6591000000b00277cd3dbe10mr28006242wru.17.1673013227590;
        Fri, 06 Jan 2023 05:53:47 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id m7-20020adffe47000000b002b880b6ef19sm1191623wrs.66.2023.01.06.05.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jan 2023 05:53:47 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     gregkh@linuxfoundation.org, johan@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 1/2] usb: serial: add support for CH348
Date:   Fri,  6 Jan 2023 13:53:37 +0000
Message-Id: <20230106135338.643951-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230106135338.643951-1-clabbe@baylibre.com>
References: <20230106135338.643951-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CH348 is an USB octo port serial adapter.
The device multiplexes all 8 ports in the same pair of Bulk endpoints.
Since there is no public datasheet, unfortunately it remains some magic values

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/usb/serial/Kconfig  |   9 +
 drivers/usb/serial/Makefile |   1 +
 drivers/usb/serial/ch348.c  | 660 ++++++++++++++++++++++++++++++++++++
 3 files changed, 670 insertions(+)
 create mode 100644 drivers/usb/serial/ch348.c

diff --git a/drivers/usb/serial/Kconfig b/drivers/usb/serial/Kconfig
index ef8d1c73c754..1e1842656b54 100644
--- a/drivers/usb/serial/Kconfig
+++ b/drivers/usb/serial/Kconfig
@@ -112,6 +112,15 @@ config USB_SERIAL_CH341
 	  To compile this driver as a module, choose M here: the
 	  module will be called ch341.
 
+config USB_SERIAL_CH348
+	tristate "USB Winchiphead CH348 Octo Port Serial Driver"
+	help
+	  Say Y here if you want to use a Winchiphead CH348 octo port
+	  USB to serial adapter.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called ch348.
+
 config USB_SERIAL_WHITEHEAT
 	tristate "USB ConnectTech WhiteHEAT Serial Driver"
 	select USB_EZUSB_FX2
diff --git a/drivers/usb/serial/Makefile b/drivers/usb/serial/Makefile
index c7bb1a88173e..d16ff59fde68 100644
--- a/drivers/usb/serial/Makefile
+++ b/drivers/usb/serial/Makefile
@@ -15,6 +15,7 @@ obj-$(CONFIG_USB_SERIAL_AIRCABLE)		+= aircable.o
 obj-$(CONFIG_USB_SERIAL_ARK3116)		+= ark3116.o
 obj-$(CONFIG_USB_SERIAL_BELKIN)			+= belkin_sa.o
 obj-$(CONFIG_USB_SERIAL_CH341)			+= ch341.o
+obj-$(CONFIG_USB_SERIAL_CH348)			+= ch348.o
 obj-$(CONFIG_USB_SERIAL_CP210X)			+= cp210x.o
 obj-$(CONFIG_USB_SERIAL_CYBERJACK)		+= cyberjack.o
 obj-$(CONFIG_USB_SERIAL_CYPRESS_M8)		+= cypress_m8.o
diff --git a/drivers/usb/serial/ch348.c b/drivers/usb/serial/ch348.c
new file mode 100644
index 000000000000..c02f403cf439
--- /dev/null
+++ b/drivers/usb/serial/ch348.c
@@ -0,0 +1,660 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USB serial driver for USB to Octal UARTs chip ch348.
+ *
+ * Copyright (C) 2022 Corentin Labbe <clabbe@baylibre.com>
+ * With the help of Neil Armstrong <neil.armstrong@linaro.org>
+ */
+
+#include <linux/errno.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/serial.h>
+#include <linux/slab.h>
+#include <linux/tty.h>
+#include <linux/tty_driver.h>
+#include <linux/tty_flip.h>
+#include <linux/usb.h>
+#include <linux/usb/serial.h>
+
+#define DEFAULT_BAUD_RATE 9600
+#define DEFAULT_TIMEOUT   2000
+
+#define CH348_CTO_D	0x01
+#define CH348_CTO_R	0x02
+
+#define CH348_CTI_C	0x10
+#define CH348_CTI_DSR	0x20
+#define CH348_CTI_R	0x40
+#define CH348_CTI_DCD	0x80
+
+#define CH348_LO	0x02
+#define CH348_LP	0x04
+#define CH348_LF	0x08
+#define CH348_LB	0x10
+
+#define CMD_W_R		0xC0
+#define CMD_W_BR	0x80
+
+#define CMD_WB_E	0x90
+#define CMD_RB_E	0xC0
+
+#define M_NOR		0x00
+#define M_HF		0x03
+
+#define R_MOD		0x97
+#define R_IO_D		0x98
+#define R_IO_O		0x99
+#define R_IO_I		0x9b
+#define R_TM_O		0x9c
+#define R_INIT		0xa1
+
+#define R_C1		0x01
+#define R_C2		0x02
+#define R_C4		0x04
+#define R_C5		0x06
+
+#define R_II_B1		0x06
+#define R_II_B2		0x02
+#define R_II_B3		0x00
+
+#define CH348_RX_PORT_CHUNK_LENGTH	32
+#define CH348_RX_PORT_MAX_LENGTH	30
+
+struct ch348_rxbuf {
+	u8 port;
+	u8 length;
+	u8 data[CH348_RX_PORT_MAX_LENGTH];
+} __packed;
+
+struct ch348_txbuf {
+	u8 port;
+	__le16 length;
+	u8 data[];
+} __packed;
+
+#define CH348_TX_HDRSIZE offsetof(struct ch348_txbuf, data)
+
+struct ch348_initbuf {
+	u8 cmd;
+	u8 reg;
+	u8 port;
+	__be32 baudrate;
+	u8 format;
+	u8 paritytype;
+	u8 databits;
+	u8 rate;
+	u8 unk;
+} __packed;
+
+#define CH348_MAXPORT 8
+
+/*
+ * The CH348 multiplexes rx & tx into a pair of Bulk USB endpoints for
+ * the 8 serial ports, and another pair of Bulk USB endpoints to
+ * set port settings and receive port status events.
+ *
+ * The USB serial cores ties every Bulk endpoints pairs to each ports,
+ * but in our case it will set port 0 with the rx/tx endpoints
+ * and port 1 with the setup/status endpoints.
+ *
+ * To still take advantage of the generic code, we (re-)initialize
+ * the USB serial port structure with the correct USB endpoint
+ * for read and write, and write proper process_read_urb()
+ * and prepare_write_buffer() to correctly (de-)multiplex data.
+ */
+
+/**
+ * struct ch348_ttyport - per-port information
+ * @uartmode:		UART port current mode
+ * @io_status:		last reported I/O state
+ * @modem_status:	last reported modem signals state
+ */
+struct ch348_ttyport {
+	u8 uartmode;
+	unsigned int io_status;
+	unsigned int modem_status;
+};
+
+/**
+ * struct ch348 - main container for all this driver information
+ * @udev:		pointer to the CH348 USB device
+ * @ttyport:		List of per-port information
+ * @serial:		pointer to the serial structure
+ * @rx_endpoint:	endpoint number for read operations
+ * @tx_endpoint:	endpoint number for write operations
+ * @statusrx_endpoint:	endpoint number for status operations
+ * @cmdtx_endpoint:	endpoint number for configure operations
+ * @status_read_urb:	URB for status
+ * @status_read_buffer:	buffer used by status_read_urb
+ * @status_lock:	control access of io_status/modem_status
+ * @readsize:		packet size for bulk_in
+ * @writesize:		packet size for bulk_out
+ */
+struct ch348 {
+	struct usb_device *udev;
+	struct ch348_ttyport ttyport[CH348_MAXPORT];
+	struct usb_serial *serial;
+
+	int rx_endpoint;
+	int tx_endpoint;
+	int statusrx_endpoint;
+	int cmdtx_endpoint;
+
+	struct urb *status_read_urb;
+	u8 *status_read_buffer;
+
+	spinlock_t status_lock;
+	int readsize;
+	int writesize;
+};
+
+struct ch348_magic {
+	u8 action;
+	u8 reg;
+	u8 control;
+} __packed;
+
+/* Some values came from vendor tree, and we have no meaning for them, this
+ * function simply use them.
+ */
+static int ch348_do_magic(struct ch348 *ch348, int portnum, u8 action, u8 reg, u8 control)
+{
+	int ret = 0, len;
+	struct ch348_magic *buffer;
+
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer)
+		return -ENOMEM;
+
+	if (portnum < 4)
+		reg += 0x10 * portnum;
+	else
+		reg += 0x10 * (portnum - 4) + 0x08;
+
+	buffer->action = action;
+	buffer->reg = reg;
+	buffer->control = control;
+
+	ret = usb_bulk_msg(ch348->udev, ch348->cmdtx_endpoint, buffer, 3, &len,
+			   DEFAULT_TIMEOUT);
+	if (ret)
+		dev_err(&ch348->udev->dev, "%s usb_bulk_msg err=%d\n", __func__, ret);
+
+	kfree(buffer);
+	return ret;
+}
+
+static int ch348_configure(struct ch348 *ch348, int portnum)
+{
+	int ret;
+
+	ret = ch348_do_magic(ch348, portnum, CMD_W_R, R_C2, 0x87);
+	if (ret)
+		return ret;
+	return ch348_do_magic(ch348, portnum, CMD_W_R, R_C4, 0x08);
+}
+
+static void ch348_process_read_urb(struct urb *urb)
+{
+	struct usb_serial_port *port = urb->context;
+	struct ch348 *ch348 = usb_get_serial_data(port->serial);
+	u8 *buffer = urb->transfer_buffer, *end;
+	unsigned int portnum, usblen;
+	struct ch348_rxbuf *rxb;
+
+	if (urb->actual_length < 2) {
+		dev_dbg(&port->dev, "%s:%d empty rx buffer\n", __func__, __LINE__);
+		return;
+	}
+
+	end = buffer + urb->actual_length;
+
+	for (; buffer < end; buffer += CH348_RX_PORT_CHUNK_LENGTH) {
+		rxb = (struct ch348_rxbuf *)buffer;
+		portnum = rxb->port;
+		if (portnum >= CH348_MAXPORT) {
+			dev_dbg(&port->dev, "%s:%d invalid port %d\n",
+				 __func__, __LINE__, portnum);
+			break;
+		}
+
+		port = ch348->serial->port[portnum];
+
+		usblen = rxb->length;
+		if (usblen > CH348_RX_PORT_MAX_LENGTH) {
+			dev_dbg(&port->dev, "%s:%d invalid length %d for port %d\n",
+				 __func__, __LINE__, usblen, portnum);
+			break;
+		}
+
+		tty_insert_flip_string(&port->port, rxb->data, usblen);
+		tty_flip_buffer_push(&port->port);
+		port->icount.rx += usblen;
+		usb_serial_debug_data(&port->dev, __func__, usblen, rxb->data);
+	}
+}
+
+static int ch348_prepare_write_buffer(struct usb_serial_port *port, void *dest, size_t size)
+{
+	struct ch348_txbuf *rxt = dest;
+	int count;
+
+	count = kfifo_out_locked(&port->write_fifo, rxt->data,
+				 size - CH348_TX_HDRSIZE, &port->lock);
+
+	rxt->port = port->port_number;
+	rxt->length = cpu_to_le16(count);
+
+	return count + CH348_TX_HDRSIZE;
+}
+
+static int ch348_set_uartmode(struct ch348 *ch348, int portnum, u8 index, u8 mode)
+{
+	int ret;
+
+	if (ch348->ttyport[portnum].uartmode == M_NOR && mode == M_HF) {
+		ret = ch348_do_magic(ch348, portnum, CMD_W_BR, R_C4, 0x51);
+		if (ret)
+			return ret;
+		ch348->ttyport[portnum].uartmode = M_HF;
+	}
+
+	if (ch348->ttyport[portnum].uartmode == M_HF && mode == M_NOR) {
+		ret = ch348_do_magic(ch348, portnum, CMD_W_BR, R_C4, 0x50);
+		if (ret)
+			return ret;
+		ch348->ttyport[portnum].uartmode = M_NOR;
+	}
+	return 0;
+}
+
+static void ch348_set_termios(struct tty_struct *tty, struct usb_serial_port *port,
+			      const struct ktermios *termios_old)
+{
+	struct ch348 *ch348 = usb_get_serial_data(port->serial);
+	int portnum = port->port_number;
+	struct ktermios *termios = &tty->termios;
+	int ret, sent;
+	speed_t	baudrate;
+	u8 format;
+	struct ch348_initbuf *buffer;
+
+	if (termios_old && !tty_termios_hw_change(&tty->termios, termios_old))
+		return;
+
+	buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
+	if (!buffer) {
+		if (termios_old)
+			tty->termios = *termios_old;
+		return;
+	}
+
+	baudrate = tty_get_baud_rate(tty);
+	/* test show no success on low baud and datasheet said it is not supported */
+	if (baudrate < 1200)
+		baudrate = DEFAULT_BAUD_RATE;
+	/* datasheet said it is not supported */
+	if (baudrate > 6000000)
+		baudrate = 6000000;
+
+	format = termios->c_cflag & CSTOPB ? 2 : 1;
+
+	buffer->paritytype = 0;
+	if (termios->c_cflag & PARENB) {
+		if (termios->c_cflag & PARODD)
+			buffer->paritytype += 1;
+		else
+			buffer->paritytype += 2;
+		if  (termios->c_cflag & CMSPAR)
+			buffer->paritytype += 2;
+	}
+
+	switch (C_CSIZE(tty)) {
+	case CS5:
+		buffer->databits = 5;
+		break;
+	case CS6:
+		buffer->databits = 6;
+		break;
+	case CS7:
+		buffer->databits = 7;
+		break;
+	case CS8:
+	default:
+		buffer->databits = 8;
+		break;
+	}
+	buffer->cmd = CMD_WB_E | (portnum & 0x0F);
+	buffer->reg = R_INIT;
+	buffer->port = portnum;
+	buffer->baudrate = cpu_to_be32(baudrate);
+
+	if (format == 2)
+		buffer->format = 0x02;
+	else if (format == 1)
+		buffer->format = 0x00;
+
+	buffer->rate = max_t(speed_t, 5, DIV_ROUND_CLOSEST(10000 * 15, baudrate));
+
+	ret = usb_bulk_msg(ch348->udev, ch348->cmdtx_endpoint, buffer,
+			   sizeof(*buffer), &sent, DEFAULT_TIMEOUT);
+	if (ret < 0) {
+		dev_err(&ch348->udev->dev, "failed to change line settings: %d\n",
+			ret);
+		goto out;
+	}
+
+	ret = ch348_do_magic(ch348, portnum, CMD_W_R, R_C1, 0x0F);
+	if (ret < 0)
+		goto out;
+
+	if (C_CRTSCTS(tty))
+		ret = ch348_set_uartmode(ch348, portnum, portnum, M_HF);
+	else
+		ret = ch348_set_uartmode(ch348, portnum, portnum, M_NOR);
+
+out:
+	kfree(buffer);
+}
+
+static int ch348_open(struct tty_struct *tty, struct usb_serial_port *port)
+{
+	struct ch348 *ch348 = usb_get_serial_data(port->serial);
+	int ret;
+
+	if (tty)
+		ch348_set_termios(tty, port, NULL);
+
+	ret = ch348_configure(ch348, port->port_number);
+	if (ret) {
+		dev_err(&ch348->udev->dev, "%s configure err\n", __func__);
+		return ret;
+	}
+
+	return usb_serial_generic_open(tty, port);
+}
+
+static void ch348_update_io_status(struct ch348 *ch348, unsigned int portnum, u8 data)
+{
+	u8 diff;
+
+	if (portnum >= CH348_MAXPORT)
+		return;
+
+	data &= (CH348_LO | CH348_LP | CH348_LF | CH348_LB);
+
+	spin_lock(&ch348->status_lock);
+	diff = data ^ ch348->ttyport[portnum].io_status;
+	ch348->ttyport[portnum].io_status = data;
+	spin_unlock(&ch348->status_lock);
+
+	if (!diff)
+		return;
+
+	if (diff & CH348_LO)
+		ch348->serial->port[portnum]->icount.overrun++;
+	if (diff & CH348_LP)
+		ch348->serial->port[portnum]->icount.parity++;
+	if (diff & CH348_LF)
+		ch348->serial->port[portnum]->icount.frame++;
+	if (diff & CH348_LB)
+		ch348->serial->port[portnum]->icount.brk++;
+
+	wake_up_interruptible(&ch348->serial->port[portnum]->port.delta_msr_wait);
+}
+
+static void ch348_update_modem_status(struct ch348 *ch348, unsigned int portnum, u8 data)
+{
+	struct tty_struct *tty;
+	u8 diff;
+
+	if (portnum >= CH348_MAXPORT)
+		return;
+
+	data &= (CH348_CTI_C | CH348_CTI_DSR | CH348_CTI_R | CH348_CTI_DCD);
+
+	spin_lock(&ch348->status_lock);
+	diff = data ^ ch348->ttyport[portnum].modem_status;
+	ch348->ttyport[portnum].modem_status = data;
+	spin_unlock(&ch348->status_lock);
+
+	if (!diff)
+		return;
+
+	if (diff & CH348_CTI_C)
+		ch348->serial->port[portnum]->icount.cts++;
+	if (diff & CH348_CTI_DSR)
+		ch348->serial->port[portnum]->icount.dsr++;
+	if (diff & CH348_CTI_R)
+		ch348->serial->port[portnum]->icount.rng++;
+	if (diff & CH348_CTI_DCD) {
+		ch348->serial->port[portnum]->icount.dcd++;
+
+		tty = tty_port_tty_get(&ch348->serial->port[portnum]->port);
+		if (tty) {
+			usb_serial_handle_dcd_change(ch348->serial->port[portnum], tty,
+						     data & CH348_CTI_DCD);
+			tty_kref_put(tty);
+		}
+	}
+
+	wake_up_interruptible(&ch348->serial->port[portnum]->port.delta_msr_wait);
+}
+
+static void ch348_update_status(struct ch348 *ch348, u8 *data, unsigned int len)
+{
+	u8 *end = data + len;
+	unsigned int portnum, reg;
+
+	for (; data + 1 < end; ) {
+		portnum = data[0] & 0xf;
+		reg = data[1];
+
+		if (reg == R_INIT) {
+			data += sizeof(struct ch348_initbuf);
+			continue;
+		}
+
+		if (reg >= R_MOD && reg <= R_IO_I) {
+			/* This signal is used by vendor driver to handle GPIO Interrupts */
+			dev_dbg(&ch348->udev->dev, "port%d: unhandled status %02x%02x\n",
+				portnum, data[2], data[3]);
+			data += 4;
+			continue;
+		}
+
+		if ((reg & 0xf) == R_II_B1) {
+			dev_dbg(&ch348->udev->dev, "port%d: uart io state %02x\n",
+				portnum, data[2]);
+			ch348_update_io_status(ch348, portnum, data[2]);
+			data += 3;
+			continue;
+		}
+
+		if ((reg & 0xf) == R_II_B2) {
+			/* This signal is used by vendor driver to aggregate multiple port TX */
+			dev_dbg(&ch348->udev->dev,
+				"port%d: unhandled Write Empty status\n", portnum);
+			data += 3;
+			continue;
+		}
+
+		if ((reg & 0xf) == R_II_B3) {
+			dev_dbg(&ch348->udev->dev, "port%d: modem status %02x\n", portnum, data[2]);
+			ch348_update_modem_status(ch348, portnum, data[2]);
+			data += 3;
+			continue;
+		}
+
+		dev_dbg(&ch348->udev->dev, "port%d: unknown status %02x\n", portnum, reg);
+		data += 3;
+	}
+}
+
+static void ch348_status_read_bulk_callback(struct urb *urb)
+{
+	struct ch348 *ch348 = urb->context;
+	u8 *data = urb->transfer_buffer;
+	unsigned int len = urb->actual_length;
+	int ret;
+
+	switch (urb->status) {
+	case 0:
+		/* success */
+		break;
+	case -ECONNRESET:
+	case -ENOENT:
+	case -ESHUTDOWN:
+		/* this urb is terminated, clean up */
+		dev_dbg(&ch348->udev->dev, "%s - urb shutting down: %d\n",
+			__func__, urb->status);
+		return;
+	default:
+		dev_dbg(&ch348->udev->dev, "%s - nonzero urb status: %d\n",
+			__func__, urb->status);
+		goto exit;
+	}
+
+	usb_serial_debug_data(&ch348->udev->dev, __func__, len, data);
+	ch348_update_status(ch348, data, len);
+
+exit:
+	ret = usb_submit_urb(urb, GFP_ATOMIC);
+	if (ret) {
+		dev_err(&ch348->udev->dev, "%s - failed to submit status urb: %d\n",
+			__func__, ret);
+	}
+}
+
+static int ch348_allocate_status_read(struct ch348 *ch348, struct usb_endpoint_descriptor *epd)
+{
+	int buffer_size = usb_endpoint_maxp(epd);
+
+	ch348->status_read_urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!ch348->status_read_urb)
+		return -ENOMEM;
+	ch348->status_read_buffer = kmalloc(buffer_size, GFP_KERNEL);
+	if (!ch348->status_read_buffer) {
+		usb_free_urb(ch348->status_read_urb);
+		return -ENOMEM;
+	}
+
+	usb_fill_bulk_urb(ch348->status_read_urb, ch348->udev,
+			  ch348->statusrx_endpoint, ch348->status_read_buffer,
+			  buffer_size, ch348_status_read_bulk_callback, ch348);
+
+	return 0;
+}
+
+static void ch348_release(struct usb_serial *serial)
+{
+	struct ch348 *ch348 = usb_get_serial_data(serial);
+
+	usb_kill_urb(ch348->status_read_urb);
+	usb_free_urb(ch348->status_read_urb);
+	kfree(ch348->status_read_buffer);
+}
+
+static int ch348_probe(struct usb_serial *serial, const struct usb_device_id *id)
+{
+	struct usb_interface *intf;
+	struct usb_endpoint_descriptor *epcmdwrite = NULL;
+	struct usb_endpoint_descriptor *epstatusread = NULL;
+	struct usb_endpoint_descriptor *epread = NULL;
+	struct usb_endpoint_descriptor *epwrite = NULL;
+	struct usb_device *usb_dev = serial->dev;
+	struct ch348 *ch348;
+	int ret;
+
+	intf = usb_ifnum_to_if(usb_dev, 0);
+
+	ret = usb_find_common_endpoints(intf->cur_altsetting, &epread, &epwrite,
+					NULL, NULL);
+	if (ret) {
+		dev_err(&serial->dev->dev, "ERROR: failed to find basic endpoints ret=%d\n", ret);
+		return ret;
+	}
+	epstatusread = &intf->cur_altsetting->endpoint[2].desc;
+	epcmdwrite = &intf->cur_altsetting->endpoint[3].desc;
+
+	if (!usb_endpoint_is_bulk_in(epstatusread)) {
+		dev_err(&serial->dev->dev, "ERROR: missing second bulk in\n");
+		return -EINVAL;
+	}
+	if (!usb_endpoint_is_bulk_out(epcmdwrite)) {
+		dev_err(&serial->dev->dev, "ERROR: missing second bulk out\n");
+		return -EINVAL;
+	}
+
+	ch348 = devm_kzalloc(&serial->dev->dev, sizeof(*ch348), GFP_KERNEL);
+	if (!ch348)
+		return -ENOMEM;
+
+	usb_set_serial_data(serial, ch348);
+
+	ch348->readsize = usb_endpoint_maxp(epread);
+	ch348->writesize = usb_endpoint_maxp(epwrite);
+	ch348->udev = serial->dev;
+	ch348->serial = serial;
+
+	spin_lock_init(&ch348->status_lock);
+
+	ch348->rx_endpoint = usb_rcvbulkpipe(usb_dev, epread->bEndpointAddress);
+	ch348->tx_endpoint = usb_sndbulkpipe(usb_dev, epwrite->bEndpointAddress);
+	ch348->cmdtx_endpoint = usb_sndbulkpipe(usb_dev, epcmdwrite->bEndpointAddress);
+	ch348->statusrx_endpoint = usb_rcvbulkpipe(usb_dev, epstatusread->bEndpointAddress);
+
+	ret = ch348_allocate_status_read(ch348, epstatusread);
+	if (ret)
+		return ret;
+	return 0;
+}
+
+static int ch348_calc_num_ports(struct usb_serial *serial,
+				struct usb_serial_endpoints *epds)
+{
+	int i;
+
+	for (i = 1; i < CH348_MAXPORT; ++i) {
+		epds->bulk_out[i] = epds->bulk_out[0];
+		epds->bulk_in[i] = epds->bulk_in[0];
+	}
+	epds->num_bulk_out = CH348_MAXPORT;
+	epds->num_bulk_in = CH348_MAXPORT;
+	return CH348_MAXPORT;
+}
+
+static const struct usb_device_id ch348_ids[] = {
+	{ USB_DEVICE(0x1a86, 0x55d9), },
+	{ }
+};
+
+MODULE_DEVICE_TABLE(usb, ch348_ids);
+
+static struct usb_serial_driver ch348_device = {
+	.driver = {
+		.owner = THIS_MODULE,
+		.name = "ch348",
+	},
+	.id_table =		ch348_ids,
+	.num_ports =		CH348_MAXPORT,
+	.open =			ch348_open,
+	.set_termios =		ch348_set_termios,
+	.process_read_urb =	ch348_process_read_urb,
+	.prepare_write_buffer =	ch348_prepare_write_buffer,
+	.probe =		ch348_probe,
+	.calc_num_ports =	ch348_calc_num_ports,
+	.release =		ch348_release,
+};
+
+static struct usb_serial_driver * const serial_drivers[] = {
+	&ch348_device, NULL
+};
+
+module_usb_serial_driver(serial_drivers, ch348_ids);
+
+MODULE_AUTHOR("Corentin Labbe <clabbe@baylibre.com>");
+MODULE_DESCRIPTION("USB CH348 Octo port serial converter driver");
+MODULE_LICENSE("GPL");
-- 
2.38.2

