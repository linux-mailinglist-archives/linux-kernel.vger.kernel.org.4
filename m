Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72FEA6B6CFA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 02:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjCMBFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 21:05:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjCMBFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 21:05:21 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41F7A2E835;
        Sun, 12 Mar 2023 18:05:19 -0700 (PDT)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4PZdk14rhVz4BKKx;
        Mon, 13 Mar 2023 03:05:13 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678669513;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h/pvQVt+vuUPuQ9B01Nl6jLdNrR89A8Ov37l9z6w6mY=;
        b=dArefm5LviYM/l2FVbDihP/Hq1r79RvOGyuGY3ZtOTJme1+s1Q8/XVUVTlRylV5HEKMri0
        9t0wdZ/xwZAIlOx1anxGMKrIIivQHELIcWhVoIUI52o2KIYlw8YdSt9mXHP1jZOuKskfig
        0mGXc5A17+77jxkM85PRTTGX+1nl41en6+0JGXv3QOOaF4aCVH3+o28FhPb1ffe/EAOQhL
        DcqsVq40DFUwI0KTURiYwymYduJFdTnY2s+hTKpDVvJxL4/ITiHhCoKtaVC3aNA1s+9E65
        UIfsXjVpxULu2NE0qsBjClEIuYHltqqoEQjYP5GL6ci6nloUjpcp64z7cMfUog==
Received: from dungeon.fi (dungeon.fi [IPv6:2a00:d880:11::2cc])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: kasper)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PZdjt1qcJzyVM;
        Mon, 13 Mar 2023 03:05:06 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678669506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h/pvQVt+vuUPuQ9B01Nl6jLdNrR89A8Ov37l9z6w6mY=;
        b=myJuidsOBcoC+ZRZQjOCEPJ4ad+7dVMc34LiFCY24ItoDxdnEWGk0dRa2UI5dAYDrqSa8x
        Nw+HBQSmcM6dRQekFi4/oRhLXJTvEf8rA5pUzVepWzo5AFhNi+9AZPjAd8yz9sRuRA09UU
        DFfnvn2DWQrGusfbH490zN4elIw9HME=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678669506; a=rsa-sha256; cv=none;
        b=mhssVkgGbGX8tO79Dd/+8JcePfTxs+bt8b3oScajgxIUlxq7B1IqSLQG5tJMHwzUHN4nXz
        zssWosVStJ/FdrdN/FvwDbTHYcVOYFa3zAbNTPPT+1d8viiUlittSZZId++NLa4dqpqOhh
        oKFeRSoW1JCnEA+w581cuT7l25NqlHg=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678669506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=h/pvQVt+vuUPuQ9B01Nl6jLdNrR89A8Ov37l9z6w6mY=;
        b=uI5nI3h7hw7pkY+Db4aH6MzOMVPgqB7Qhzj1nCNbOjqTIEYdJ8MoBSWS7a9qfIuBLolL7K
        pzHzhZykku2wESWq7sMqrtBPzH4m+k4LuyIheREIspKL6c8FFlsf7FuiZshECCEQPtwBw1
        SSRrwgP0oelR17YKL9/3y5SDkfRsfqQ=
Received: from gridbug.. (dktgsyyyyyyyyyyyyyyct-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::5])
        by dungeon.fi (Postfix) with ESMTPSA id 44EC33F1EA;
        Mon, 13 Mar 2023 03:05:05 +0200 (EET)
From:   Jarkko Sonninen <kasper@iki.fi>
Cc:     kasper@iki.fi, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Date:   Mon, 13 Mar 2023 03:04:16 +0200
Message-Id: <20230313010416.845252-1-kasper@iki.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for RS-485 in Exar USB adapters.
RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
Gpio mode register is set to enable RS-485.

Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
---
 drivers/usb/serial/xr_serial.c | 72 +++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index fdb0aae546c3..edbb6add087c 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -93,6 +93,7 @@ struct xr_txrx_clk_mask {
 #define XR_GPIO_MODE_SEL_DTR_DSR	0x2
 #define XR_GPIO_MODE_SEL_RS485		0x3
 #define XR_GPIO_MODE_SEL_RS485_ADDR	0x4
+#define XR_GPIO_MODE_RS485_TX_H		0x8
 #define XR_GPIO_MODE_TX_TOGGLE		0x100
 #define XR_GPIO_MODE_RX_TOGGLE		0x200
 
@@ -237,6 +238,8 @@ static const struct xr_type xr_types[] = {
 struct xr_data {
 	const struct xr_type *type;
 	u8 channel;			/* zero-based index or interface number */
+	struct serial_rs485 rs485;
+	spinlock_t lock;
 };
 
 static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
@@ -629,6 +632,7 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	struct xr_data *data = usb_get_serial_port_data(port);
 	const struct xr_type *type = data->type;
 	u16 flow, gpio_mode;
+	unsigned long flags, rs485_flags;
 	int ret;
 
 	ret = xr_get_reg_uart(port, type->gpio_mode, &gpio_mode);
@@ -645,9 +649,16 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	/* Set GPIO mode for controlling the pins manually by default. */
 	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
 
+	spin_lock_irqsave(&data->lock, flags);
+	rs485_flags = data->rs485.flags;
+	spin_unlock_irqrestore(&data->lock, flags);
+	if (rs485_flags & SER_RS485_ENABLED)
+		gpio_mode |= XR_GPIO_MODE_SEL_RS485 | XR_GPIO_MODE_RS485_TX_H;
+	else if (C_CRTSCTS(tty) && C_BAUD(tty) != B0)
+		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
+
 	if (C_CRTSCTS(tty) && C_BAUD(tty) != B0) {
 		dev_dbg(&port->dev, "Enabling hardware flow ctrl\n");
-		gpio_mode |= XR_GPIO_MODE_SEL_RTS_CTS;
 		flow = XR_UART_FLOW_MODE_HW;
 	} else if (I_IXON(tty)) {
 		u8 start_char = START_CHAR(tty);
@@ -827,6 +838,64 @@ static void xr_set_termios(struct tty_struct *tty,
 	xr_set_flow_mode(tty, port, old_termios);
 }
 
+static int xr_get_rs485_config(struct tty_struct *tty,
+			 unsigned int __user *argp)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+	unsigned long flags;
+	struct serial_rs485 rs485;
+
+	spin_lock_irqsave(&data->lock, flags);
+	memcpy(&rs485, &data->rs485, sizeof(rs485));
+	spin_unlock_irqrestore(&data->lock, flags);
+	dev_dbg(tty->dev, "%s flags %02x\n", __func__, rs485.flags);
+
+	if (copy_to_user(argp, &rs485, sizeof(rs485)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int xr_set_rs485_config(struct tty_struct *tty,
+			 unsigned long __user *argp)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+	struct serial_rs485 rs485;
+	unsigned long flags;
+
+	if (copy_from_user(&rs485, argp, sizeof(rs485)))
+		return -EFAULT;
+
+	dev_dbg(tty->dev, "%s flags %02x\n", __func__, rs485.flags);
+	rs485.flags &= SER_RS485_ENABLED;
+	spin_lock_irqsave(&data->lock, flags);
+	memcpy(&data->rs485, &rs485, sizeof(rs485));
+	spin_unlock_irqrestore(&data->lock, flags);
+	xr_set_flow_mode(tty, port, 0);
+
+	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485)))
+		return -EFAULT;
+
+	return 0;
+}
+
+
+static int xr_ioctl(struct tty_struct *tty,
+					unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+
+	switch (cmd) {
+	case TIOCGRS485:
+		return xr_get_rs485_config(tty, argp);
+	case TIOCSRS485:
+		return xr_set_rs485_config(tty, argp);
+	}
+	return -ENOIOCTLCMD;
+}
+
 static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	int ret;
@@ -1010,6 +1079,7 @@ static struct usb_serial_driver xr_device = {
 	.set_termios		= xr_set_termios,
 	.tiocmget		= xr_tiocmget,
 	.tiocmset		= xr_tiocmset,
+	.ioctl			= xr_ioctl,
 	.dtr_rts		= xr_dtr_rts
 };
 
-- 
2.34.1

