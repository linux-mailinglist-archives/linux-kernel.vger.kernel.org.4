Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52C8E74BDED
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jul 2023 16:57:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjGHO51 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jul 2023 10:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbjGHO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jul 2023 10:57:26 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71867D9;
        Sat,  8 Jul 2023 07:57:24 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [IPv6:2a00:d880:11::2cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4Qytf74HF5z49Psw;
        Sat,  8 Jul 2023 17:57:19 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1688828240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dx+yZDyoZEMezjVYd3PTEK6iSdWrjTFGImAbJdiYRVE=;
        b=BdhpdtzEd3Cu0xkFxtfzOhvqFCLAgStCVT2E+Cl9CBWJA0TmnbtuWan/5GUJX2l1NDpF03
        h5DfCMBRDnnKTsqTEcXWS6LAj9mlQ/buizRRsfgV12QRJIqV1/GJpLdWoGpxRmFLIXmLE9
        yNrzH75UO8q9pVyfofRl0r5+jkZq1TuMqkrrzezLN0HT/FCINrCf/YvC1AEzCIjt8koaSo
        ef+JqCa48QNe9VORZsbKVKzHJcQxvmUWjn5xxAjLFUPj+ZwrHkdhJRUmUAn9BPQeL1BJ+V
        /A8MZBVALvOqhl1jr//kuYQ2rAZw2WLJ23YAWJtX/zXar0oJ4KehQtVWl8qmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1688828240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dx+yZDyoZEMezjVYd3PTEK6iSdWrjTFGImAbJdiYRVE=;
        b=Eus036bV69xgfrnpumuM12bQkuz/cA18+0MS2pLpvM7UKuWoHjwaWfJNGuoyPaSHJAuyZv
        6MRU2Q813JDwNha1rNDwCt6s77gtV7ZsKw6uiAYcogDwe5Iodk2QZV+zCj1Lmd6VyUuOCg
        74g8U4CoS4vNlhWUEO/tfp3baVzqgrViF2Ak3ml5ROngn0iPIauJ6e9BZvy+h9dfvhE8mj
        TBcDKUnZt0g2QL4M5btDLULz3osyHGU95wj7V0488GZqYMg7U93JqdjcHawGSrB8NTeGtA
        ngImx4FjntaiMpRSaZRgfse6XHxwFwvYaQqmXfiJzpHhq4pmepT8ARcOiuICAQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1688828240; a=rsa-sha256;
        cv=none;
        b=Bk2rD+wCoFfI1Wdne7kHdG5nJjwK0P4cDk8QkR+xs17okV3/3cGkAYlQ0XPkyewoSUISxr
        QbLIITQk48mIR6yGM9bmcLa5K2BEBL3ZsMTPcfUrjO0T9i4Si5V6Zm/nDdpWmpevPnq4tJ
        unUeRtAz5e9vFMgUSrI/S9Ew1JtdrhUL/nbyNPjSNIhMQB+6D3CdSGJBya3kL1mJHcohkW
        LB+OpWiTrTl6dVr+AcmlXYx+sJLhFXhL1pyuMmh0LROGUKfRkdOgK22yIn4jx9go+3684n
        Oag54yvOzJBJpjG4RHdxvK6L9EvFXDsENZVdNEbFQB9EZ2hMco4CzGKiVL23wA==
Received: from gridbug.. (dkxv4fyyyyyyyyyyyyyby-3.rev.dnainternet.fi [IPv6:2001:14ba:44e3:8200::2])
        by dungeon.fi (Postfix) with ESMTPSA id E7C113F57A;
        Sat,  8 Jul 2023 17:57:17 +0300 (EEST)
From:   Jarkko Sonninen <kasper@iki.fi>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Date:   Sat,  8 Jul 2023 17:56:50 +0300
Message-Id: <20230708145651.1860565-1-kasper@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZJGduS4z5U65T7IL@hovoldconsulting.com>
References: <ZJGduS4z5U65T7IL@hovoldconsulting.com>
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
behaviour of the RTS#/RS485 pin. Setting SER_RS485_RTS_AFTER_SEND
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
Change in v5:
 - Use tty->termios_rwsem semaphore instead of own mutex
 - Set SER_RS485_RTS_AFTER_SEND as the default
 - Fix XR_GPIO_MODE_RS485_TX_H setting with SER_RS485_RTS_ON_SEND
 - Add missing __user directives
 drivers/usb/serial/xr_serial.c | 90 +++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 4ec7c5892b84..6a5a70e77969 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -93,6 +93,7 @@ struct xr_txrx_clk_mask {
 #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
 #define XR_GPIO_MODE_SEL_RS485		0x3
 #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
+#define XR_GPIO_MODE_RS485_TX_H		0x8
 #define XR_GPIO_MODE_TX_TOGGLE		0x100
 #define XR_GPIO_MODE_RX_TOGGLE		0x200
 
@@ -237,6 +238,7 @@ static const struct xr_type xr_types[] = {
 struct xr_data {
 	const struct xr_type *type;
 	u8 channel;			/* zero-based index or interface number */
+	struct serial_rs485 rs485;
 };
 
 static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
@@ -629,6 +631,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	struct xr_data *data = usb_get_serial_port_data(port);
 	const struct xr_type *type = data->type;
 	u16 flow, gpio_mode;
+	bool rs485_enabled;
 	int ret;
 
 	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
@@ -645,7 +648,17 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	/* Set GPIO mode for controlling the pins manually by default. */
 	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
 
-	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
+	rs485_enabled = !!(data->rs485.flags & SER_RS485_ENABLED);
+	if (rs485_enabled) {
+		dev_dbg(&port->dev, "Enabling RS-485\n");
+		gpio_mode |= XR_GPIO_MODE_SEL_RS485;
+		if (data->rs485.flags & SER_RS485_RTS_ON_SEND)
+			gpio_mode &= ~XR_GPIO_MODE_RS485_TX_H;
+		else
+			gpio_mode |= XR_GPIO_MODE_RS485_TX_H;
+	}
+
+	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0 && !rs485_enabled) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
 		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
 		flow = XR_UART_FLOW_MODE_HW;
@@ -809,6 +822,80 @@ static void xr_cdc_set_line_coding(struct tty_struct *tty,
 	kfree(lc);
 }
 
+static void xr_sanitize_serial_rs485(struct serial_rs485 *rs485)
+{
+	if (!(rs485->flags & SER_RS485_ENABLED)) {
+		memset(rs485, 0, sizeof(*rs485));
+		return;
+	}
+
+	/* Select RTS after send if the user hasn't selected the mode properly */
+	if (!!(rs485->flags & SER_RS485_RTS_ON_SEND) ==
+	    !!(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
+		rs485->flags |= SER_RS485_RTS_AFTER_SEND;
+		rs485->flags &= ~SER_RS485_RTS_ON_SEND;
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
+			       struct serial_rs485 __user *argp)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+
+	down_read(&tty->termios_rwsem);
+	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485))) {
+		up_read(&tty->termios_rwsem);
+		return -EFAULT;
+	}
+	up_read(&tty->termios_rwsem);
+
+	return 0;
+}
+
+static int xr_set_rs485_config(struct tty_struct *tty,
+			       struct serial_rs485 __user *argp)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+	struct serial_rs485 rs485;
+
+	if (copy_from_user(&rs485, argp, sizeof(rs485)))
+		return -EFAULT;
+	xr_sanitize_serial_rs485(&rs485);
+
+	down_write(&tty->termios_rwsem);
+	data->rs485 = rs485;
+	xr_set_flow_mode(tty, port, NULL);
+	up_write(&tty->termios_rwsem);
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
@@ -1010,6 +1097,7 @@ static struct usb_serial_driver xr_device = {
 	.set_termios		= xr_set_termios,
 	.tiocmget		= xr_tiocmget,
 	.tiocmset		= xr_tiocmset,
+	.ioctl			= xr_ioctl,
 	.dtr_rts		= xr_dtr_rts
 };
 
-- 
2.34.1

