Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 125576B712A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 09:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjCMI3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 04:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbjCMI24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 04:28:56 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A6C922CB4;
        Mon, 13 Mar 2023 01:28:53 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [81.4.110.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PZqYv31RJz4BKKQ;
        Mon, 13 Mar 2023 10:28:50 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678696131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8Q/yjIi83AYb30LAP0er5gMTTPbreeu07x7cWZNn2Q=;
        b=IPhBC7+rRL4aWrV6z9PyhTg4f7L2es7C9gbOREme0aITn1cbIuI+l+bc7h2UMHTh7Pfk8e
        uqnFOQIxdpg8aQHywNb+DzVwviqiPk0lleyaIA8xMvbIbrIPkVJutagCWN20xnL2x13zgM
        ipwKVEODmh+sReHmrCb9ue1JkDVKRN8wRmHL7kNlq0Jl17S2wikM7Idww7s2A2fCnliOA6
        Cr7WnKAZjF6NJ+5e3UA/9h5z5grTEUjz52BV4VoLYYdjUKcD4TD7ULdWS+GWWBCvi6+Fac
        r8r1rm0U/kLAasuhcLppl10stfCtvDerttlHVrh59CqxWj9zY9KcWQxz4pNrBg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678696131; a=rsa-sha256;
        cv=none;
        b=I5BFBSB7cPGxbtn3TK3snZEySdyJ7W4oiqgXPCbhuiVZDQIFj8rwKVsLfw5Vw+ViLTK3Q+
        DNY/r+m1/JCiuy068PIc6GdhuqNZkUrMuz1tOqUjuAEtMV+OlaT/ix4I3+ZI17WECdKs9o
        qb88hnjyua6CHFCLJaW+y5LHNgzzf5QB8W3enMb99oYz/63yFRRFMtfn6ecisGST+VWOw4
        vp6MJKgBVPHfzLtegdJs4iytkMkgxaoZiWYPH68+m/n6kDDTnRy3VxxYcwnSFSViuWIJDY
        mq2oHXBjn3Xg+2A7Efjpj1C2dmtkdLmEQa1inBBACzxZhNMiqBj9C7ThuWkiUw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678696131;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X8Q/yjIi83AYb30LAP0er5gMTTPbreeu07x7cWZNn2Q=;
        b=L7s7r1V1AsHdHmvSWOPPhPxy0qr1g3jUzqKgH/vMLa98eNlle0PVSFy/MLfq7r8XIRxq0q
        +x781uGb93TF7hHNkOjSWiZy8REd6P8j+hFwo+ASh/g0oOjgDD8RdhRWQ2BxocGqguw4VV
        qT9TagPERYVPFz16Mmn/iD+/50Y/v7cOf4WL7AilBBCCvKhaizjOAaZ0dDCPJaewhG4aSg
        p/3hZSfeQMseJLC42bG4GUefsSjjghhWNxbLsCoAaMUZ35btEL5ysZk1Ob3y4KrQUnG6ye
        af8izy5GQDU1NUt/Yh29ZghTr2YD9Wykg6l4deSZE2fFeDeIqfPOyVfmhHxqYw==
Received: from gridbug.. (dktgsyyyyyyyyyyyyyybt-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::3])
        by dungeon.fi (Postfix) with ESMTPSA id 82F1C3F270;
        Mon, 13 Mar 2023 10:28:49 +0200 (EET)
From:   Jarkko Sonninen <kasper@iki.fi>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Date:   Mon, 13 Mar 2023 10:27:34 +0200
Message-Id: <20230313082734.886890-1-kasper@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ZA7Wh2Z/DdKOsOYr@kroah.com>
References: <ZA7Wh2Z/DdKOsOYr@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for RS-485 in Exar USB adapters.
RS-485 mode is controlled by TIOCGRS485 and TIOCSRS485 ioctls.
Gpio mode register is set to enable RS-485.

Signed-off-by: Jarkko Sonninen <kasper@iki.fi>
---
 drivers/usb/serial/xr_serial.c | 65 +++++++++++++++++++++++++++++++++-
 1 file changed, 64 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index fdb0aae546c3..480cda0daafc 100644
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
@@ -827,6 +838,57 @@ static void xr_set_termios(struct tty_struct *tty,
 	xr_set_flow_mode(tty, port, old_termios);
 }
 
+static int xr_get_rs485_config(struct tty_struct *tty,
+			 unsigned int __user *argp)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+
+	dev_dbg(tty->dev, "Flags %02x\n", data->rs485.flags);
+	if (copy_to_user(argp, &data->rs485, sizeof(data->rs485)))
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
+	dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);
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
+	return -ENOTTY;
+}
+
 static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	int ret;
@@ -1010,6 +1072,7 @@ static struct usb_serial_driver xr_device = {
 	.set_termios		= xr_set_termios,
 	.tiocmget		= xr_tiocmget,
 	.tiocmset		= xr_tiocmset,
+	.ioctl			= xr_ioctl,
 	.dtr_rts		= xr_dtr_rts
 };
 
-- 
2.34.1

