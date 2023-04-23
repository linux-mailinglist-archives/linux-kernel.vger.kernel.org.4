Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3556EC1AE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjDWTAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 15:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWTAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 15:00:06 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E635A10D4;
        Sun, 23 Apr 2023 12:00:04 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [IPv6:2a00:d880:11::2cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4Q4Hd831h3zySW;
        Sun, 23 Apr 2023 21:59:56 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1682276398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxfAWl1kWp9CpnyDQXswuqjCQB/+/RxHWBjkeo+0fS4=;
        b=HKcNpldoL+e2BKjtWHb0Lm84sG+CQH5RUp+FBeW2ZKT75mHu2K2IFJc51Z8attlZsfFk4R
        +lurW3vuz/rW3/zPzJRZ+tJsIxCAC0vNx2o7NWrIiLU/oa9dMs2aJ29hIylkk7X17688BD
        E+aZi/RdfOrIFKc9dkHdaFG/NlaXNeg=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1682276398; a=rsa-sha256; cv=none;
        b=CvV0oydI7Iemg+7pixuLzpfX9KbpzDFm9DeeNIeCV3NtaAhgV7zsEm1hECrfaA/kxIZaK3
        NPkEWyWGPEQhmyI77RyaYNLRLqdzH8THyaBAETh5DPOy+Za/Z9qGxGhZqc+aMXPxvfXKUl
        CNgCnFYYMhN1oLtLQ9eKtrKb9rPPl9w=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1682276398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MxfAWl1kWp9CpnyDQXswuqjCQB/+/RxHWBjkeo+0fS4=;
        b=XUYW4vzkxfQONcnets2MrDFBDj3/+zME4FKIyCDYrOMQtGHb/xpasVuAKG2DehXjNqYwKf
        1/Sizic1Tz6D3OBXwRmz5FZ8qd+JJcQX3I/K6wVDdwlQkxV2DFVrPG3gajlG3QNpIUsIyY
        xsaqDhrKjmfJQkNAm966bhIxlV60zys=
Received: from gridbug.. (dktgsyyyyyyyyyyyyyybt-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::3])
        by dungeon.fi (Postfix) with ESMTPSA id 1F6A93F244;
        Sun, 23 Apr 2023 21:59:55 +0300 (EEST)
From:   Jarkko Sonninen <kasper@iki.fi>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Date:   Sun, 23 Apr 2023 21:59:28 +0300
Message-Id: <20230423185929.1595056-1-kasper@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZD1cy6omacYMRCLs@hovoldconsulting.com>
References: <ZD1cy6omacYMRCLs@hovoldconsulting.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exar devices like XR21B1411 can control an RS485 transceiver by
automatically asserting the RTS#/RS485 pin before sending data
and deasserting it when the last stop bit has been transmitted.
The polarity of the RST#/RS485 signal is configurable and the
hardware also supports half-duplex turn-around delay and
address matching mode.

Add support for enabling and disabling RS-485 mode and
configuring the RST#/RS485 signal polarity using the TIOCGRS485
and TIOCSRS485 ioctls. Support for half-duplex turn-around delay
and address matching mode are left unimplemented for now.

User enables RS-485 mode by setting SER_RS485_ENABLED flag in
struct serial_rs485 flags. User should also set either
SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND to select the
behaviour of the RTS#/RS485 pin. Setting SER_RS485_RTS_ON_SEND
will drive RTS#/RS485 high during transmission. As this is the
typical application described by Exar, it is selected when
user sets neither or both flags.

Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
---
Changes in v3:
 - In this version only rs485.flags are stored to state.
 - There is no locking as only one bit of the flags is used.
 - ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.
Changes in v4:
 - Store struct rs485 to data
 - Add mutex to protect data->rs485.
 - Implement SER_RS485_RTS_ON_SEND or SER_RS485_RTS_AFTER_SEND flags
 - SER_RS485_RTS_ON_SEND is the default like in serial_core.c


 drivers/usb/serial/xr_serial.c | 93 +++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index fdb0aae546c3..a2157619b63c 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -19,6 +19,7 @@
 #include <linux/usb.h>
 #include <linux/usb/cdc.h>
 #include <linux/usb/serial.h>
+#include <linux/mutex.h>
 
 struct xr_txrx_clk_mask {
 	u16 tx;
@@ -93,6 +94,7 @@ struct xr_txrx_clk_mask {
 #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
 #define XR_GPIO_MODE_SEL_RS485		0x3
 #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
+#define XR_GPIO_MODE_RS485_TX_H		0x8
 #define XR_GPIO_MODE_TX_TOGGLE		0x100
 #define XR_GPIO_MODE_RX_TOGGLE		0x200
 
@@ -237,6 +239,8 @@ static const struct xr_type xr_types[] = {
 struct xr_data {
 	const struct xr_type *type;
 	u8 channel;			/* zero-based index or interface number */
+	struct serial_rs485 rs485;
+	struct mutex lock;
 };
 
 static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
@@ -630,6 +634,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	const struct xr_type *type = data->type;
 	u16 flow, gpio_mode;
 	int ret;
+	bool rs485_enabled;
 
 	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
 	if (ret)
@@ -645,7 +650,17 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	/* Set GPIO mode for controlling the pins manually by default. */
 	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
 
-	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
+	rs485_enabled = !!(data->rs485.flags & SER_RS485_ENABLED);
+	if (rs485_enabled) {
+		dev_dbg(&port->dev, "Enabling RS-485\n");
+		gpio_mode |= XR_GPIO_MODE_SEL_RS485;
+		if (data->rs485.flags & SER_RS485_RTS_ON_SEND)
+			gpio_mode |= XR_GPIO_MODE_RS485_TX_H;
+		else
+			gpio_mode &= ~XR_GPIO_MODE_RS485_TX_H;
+	}
+
+	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0 && !rs485_enabled) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
 		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
 		flow = XR_UART_FLOW_MODE_HW;
@@ -809,6 +824,80 @@ static void xr_cdc_set_line_coding(struct tty_struct *tty,
 	kfree(lc);
 }
 
+static void xr_sanitize_serial_rs485(struct serial_rs485 *rs485)
+{
+	if (!(rs485->flags & SER_RS485_ENABLED)) {
+		memset(rs485, 0, sizeof(*rs485));
+		return;
+	}
+
+	/* Select RTS on send if the user hasn't selected the mode properly */
+	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
+		rs485->flags |= SER_RS485_RTS_ON_SEND;
+		rs485->flags &= ~SER_RS485_RTS_AFTER_SEND;
+	}
+
+	/* Only the flags are implemented at the moment */
+	rs485->flags &= SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND |
+			SER_RS485_RTS_AFTER_SEND;
+	rs485->delay_rts_before_send = 0;
+	rs485->delay_rts_after_send = 0;
+	memset(rs485->padding, 0, sizeof(rs485->padding));
+}
+
+static int xr_get_rs485_config(struct tty_struct *tty,
+			       struct serial_rs485 *argp)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+
+	mutex_lock(&data->lock);
+	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485))) {
+		mutex_unlock(&data->lock);
+		return -EFAULT;
+	}
+	mutex_unlock(&data->lock);
+
+	return 0;
+}
+
+static int xr_set_rs485_config(struct tty_struct *tty,
+			       struct serial_rs485 *argp)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+	struct serial_rs485 rs485;
+
+	if (copy_from_user(&rs485, argp, sizeof(rs485)))
+		return -EFAULT;
+	xr_sanitize_serial_rs485(&rs485);
+
+	mutex_lock(&data->lock);
+	data->rs485 = rs485;
+	xr_set_flow_mode(tty, port, NULL);
+	mutex_unlock(&data->lock);
+
+	if (copy_to_user(argp, &rs485, sizeof(rs485)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int xr_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case TIOCGRS485:
+		return xr_get_rs485_config(tty, argp);
+	case TIOCSRS485:
+		return xr_set_rs485_config(tty, argp);
+	}
+
+	return -ENOIOCTLCMD;
+}
+
 static void xr_set_termios(struct tty_struct *tty,
 			   struct usb_serial_port *port,
 			   const struct ktermios *old_termios)
@@ -939,6 +1028,7 @@ static int xr_port_probe(struct usb_serial_port *port)
 		return -ENOMEM;
 
 	data->type = type;
+	mutex_init(&data->lock);
 
 	desc = &port->serial->interface->cur_altsetting->desc;
 	if (type_id == XR21V141X)
@@ -1010,6 +1100,7 @@ static struct usb_serial_driver xr_device = {
 	.set_termios		= xr_set_termios,
 	.tiocmget		= xr_tiocmget,
 	.tiocmset		= xr_tiocmset,
+	.ioctl			= xr_ioctl,
 	.dtr_rts		= xr_dtr_rts
 };
 
-- 
2.34.1

