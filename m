Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699356B8B99
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbjCNHBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjCNHBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:01:47 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A5096F0B;
        Tue, 14 Mar 2023 00:01:44 -0700 (PDT)
Received: from dungeon.fi (dungeon.fi [81.4.110.129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kasper)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PbPZp6tBZzyQw;
        Tue, 14 Mar 2023 09:01:38 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678777300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBFiZRAVeT2FIrImO6sdWcu2f9xNpfHrJqo4KPXnuUU=;
        b=k8/NpawJ2Nc+UiODD/ZMIyENAzGF7FpxEsFQPAu8Efu4ANOI57RD77oELQhhIYhZRzuqy5
        FkGAksrRlw+nZPMv4VUqcNOrT3wBkgkfoa/vOkh/Lj0gZ20+uo3J+C+fZAWHAGk2A2glNO
        PYAhyd1MuuFQDsK1G87p5p8UKfFuoy4=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678777300; a=rsa-sha256; cv=none;
        b=iOPlerZPy2WQ/KBj0HVFDAu9odixkiR+Ox9hPgO7FPxSXa/8DmSQhPCEa8IG5gITo2vfbD
        8N2vk2MTO+z/V/Sa1Rrs8pqD+0e23GyIPXOOqPqWX+7sdcI65Ac7WZHUTvbfmFc0b31RLJ
        DGsGcpJY7ZBzay9F+dNpBcfOy1dPiXU=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=kasper smtp.mailfrom=kasper@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678777300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mBFiZRAVeT2FIrImO6sdWcu2f9xNpfHrJqo4KPXnuUU=;
        b=T6NNDtQZU//nN+NSIZ5wDI7e+8nmjZoVc/F9LzYmuA0OtVB07CBgN+ghFZarCeFlHcgXSI
        LEtcsYnkPEwHzeK3VZlu5dU8eNb2kSwBwGzraPSKFvfuBjk/sQGwVx3p2C0HFLOtpF1U0B
        bvCE8NjMx+2mPC6rqeRPLT456XeAEV8=
Received: from gridbug.. (dktgsyyyyyyyyyyyyyyct-3.rev.dnainternet.fi [IPv6:2001:14ba:440a:f000::5])
        by dungeon.fi (Postfix) with ESMTPSA id 0CF663F371;
        Tue, 14 Mar 2023 09:01:36 +0200 (EET)
From:   Jarkko Sonninen <kasper@iki.fi>
To:     Jarkko Sonninen <kasper@iki.fi>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] USB: serial: xr: Add TIOCGRS485 and TIOCSRS485 ioctls
Date:   Tue, 14 Mar 2023 09:00:01 +0200
Message-Id: <20230314070002.1008959-1-kasper@iki.fi>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230313010416.845252-1-kasper@iki.fi>
References: <20230313010416.845252-1-kasper@iki.fi>
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

In this version only rs485.flags are stored to state.
There is no locking as only one bit of the flags is used.
ioctl returns -ENOIOCTLCMD as the actual error handling is in tty code.

 drivers/usb/serial/xr_serial.c | 62 +++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index fdb0aae546c3..7b542ccb6596 100644
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
+	u32 rs485_flags;
 };
 
 static int xr_set_reg(struct usb_serial_port *port, u8 channel, u16 reg, u16 val)
@@ -645,9 +647,13 @@ static void xr_set_flow_mode(struct tty_struct *tty,
 	/* Set GPIO mode for controlling the pins manually by default. */
 	gpio_mode &= ~XR_GPIO_MODE_SEL_MASK;
 
+	if (data->rs485_flags & SER_RS485_ENABLED)
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
@@ -827,6 +833,59 @@ static void xr_set_termios(struct tty_struct *tty,
 	xr_set_flow_mode(tty, port, old_termios);
 }
 
+static int xr_get_rs485_config(struct tty_struct *tty,
+			 unsigned int __user *argp)
+{
+	struct usb_serial_port *port = tty->driver_data;
+	struct xr_data *data = usb_get_serial_port_data(port);
+	struct serial_rs485 rs485;
+
+	dev_dbg(tty->dev, "Flags %02x\n", data->rs485_flags);
+	memset(&rs485, 0, sizeof(rs485));
+	rs485.flags = data->rs485_flags;
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
+
+	if (copy_from_user(&rs485, argp, sizeof(rs485)))
+		return -EFAULT;
+
+	dev_dbg(tty->dev, "Flags %02x\n", rs485.flags);
+	data->rs485_flags = rs485.flags & SER_RS485_ENABLED;
+	xr_set_flow_mode(tty, port, (const struct ktermios *)0);
+
+	// Only the enable flag is implemented
+	memset(&rs485, 0, sizeof(rs485));
+	rs485.flags = data->rs485_flags;
+	if (copy_to_user(argp, &rs485, sizeof(rs485)))
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
+	return -ENOIOCTLCMD;
+}
+
 static int xr_open(struct tty_struct *tty, struct usb_serial_port *port)
 {
 	int ret;
@@ -1010,6 +1069,7 @@ static struct usb_serial_driver xr_device = {
 	.set_termios		= xr_set_termios,
 	.tiocmget		= xr_tiocmget,
 	.tiocmset		= xr_tiocmset,
+	.ioctl			= xr_ioctl,
 	.dtr_rts		= xr_dtr_rts
 };
 
-- 
2.34.1

