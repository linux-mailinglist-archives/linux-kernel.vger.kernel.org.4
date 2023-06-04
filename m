Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A14E7216FD
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 14:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230500AbjFDMfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 08:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbjFDMfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 08:35:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C412ECF;
        Sun,  4 Jun 2023 05:34:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49A2361783;
        Sun,  4 Jun 2023 12:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E33C433EF;
        Sun,  4 Jun 2023 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685882095;
        bh=pCCxUQRcFTYZQCxsJVBlWtZ2T2n6nEdssGE1uVkjm+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BjCD8436PYrJIMu5kIyABVPWcfb+o9k9BCEIOSG1B0EDpo/HP5J0hHylMVNlDoWko
         qdGU0hkwjh7W72ii7GHYTDlL286yDqPHJM9DzOCLhzCUdvuHubHkJFhOp0t2g0bfWD
         TGSgI73Ws8DxF5A2ANlC7oGGfba1EjWiT3ev2e8rT32QYYndQS3SX510abs+rI2P1l
         MfR/a9cQdNubWubFUDeDzlhOjiIsATwN8ve3M2LkgOmqza7mvgHIWNPNVjF2HJq9y3
         SwWz0lGhy7B/njeyYjaafs5f99RsPf//FgQejlmPSj3aF2MQSYe2+3gFheUCOZRQow
         kXSr9BsDEPAxw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q5mww-0001DU-JG; Sun, 04 Jun 2023 14:35:10 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Corey Minyard <minyard@acm.org>
Subject: [PATCH v2 1/3] USB: serial: return errors from break handling
Date:   Sun,  4 Jun 2023 14:35:03 +0200
Message-Id: <20230604123505.4661-2-johan@kernel.org>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20230604123505.4661-1-johan@kernel.org>
References: <20230604123505.4661-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_FILL_THIS_FORM_SHORT,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start propagating errors to user space when setting the break state
fails.

This will be used by follow-on changes to also report when a driver or
device does not support break control.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ark3116.c          |  7 +++--
 drivers/usb/serial/belkin_sa.c        | 12 ++++++---
 drivers/usb/serial/ch341.c            | 37 +++++++++++++++++----------
 drivers/usb/serial/cp210x.c           |  8 +++---
 drivers/usb/serial/digi_acceleport.c  |  7 ++---
 drivers/usb/serial/f81232.c           |  4 ++-
 drivers/usb/serial/f81534.c           |  4 ++-
 drivers/usb/serial/ftdi_sio.c         | 10 +++++---
 drivers/usb/serial/io_edgeport.c      |  6 +++--
 drivers/usb/serial/io_ti.c            |  9 +++++--
 drivers/usb/serial/keyspan.c          |  5 +++-
 drivers/usb/serial/keyspan_pda.c      |  8 ++++--
 drivers/usb/serial/mct_u232.c         |  6 ++---
 drivers/usb/serial/mos7720.c          |  9 ++++---
 drivers/usb/serial/mos7840.c          |  7 ++---
 drivers/usb/serial/mxuport.c          |  6 ++---
 drivers/usb/serial/pl2303.c           | 14 ++++++----
 drivers/usb/serial/quatech2.c         |  8 ++++--
 drivers/usb/serial/ti_usb_3410_5052.c | 10 +++++---
 drivers/usb/serial/upd78f0730.c       |  7 +++--
 drivers/usb/serial/usb-serial.c       |  2 +-
 drivers/usb/serial/usb_debug.c        | 13 +++++++---
 drivers/usb/serial/whiteheat.c        |  7 ++---
 drivers/usb/serial/xr_serial.c        |  4 +--
 include/linux/usb/serial.h            |  2 +-
 25 files changed, 140 insertions(+), 72 deletions(-)

diff --git a/drivers/usb/serial/ark3116.c b/drivers/usb/serial/ark3116.c
index 9452291f1703..67a07cc007f0 100644
--- a/drivers/usb/serial/ark3116.c
+++ b/drivers/usb/serial/ark3116.c
@@ -433,10 +433,11 @@ static int ark3116_tiocmset(struct tty_struct *tty,
 	return 0;
 }
 
-static void ark3116_break_ctl(struct tty_struct *tty, int break_state)
+static int ark3116_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ark3116_private *priv = usb_get_serial_port_data(port);
+	int ret;
 
 	/* LCR is also used for other things: protect access */
 	mutex_lock(&priv->hw_lock);
@@ -446,9 +447,11 @@ static void ark3116_break_ctl(struct tty_struct *tty, int break_state)
 	else
 		priv->lcr &= ~UART_LCR_SBC;
 
-	ark3116_write_reg(port->serial, UART_LCR, priv->lcr);
+	ret = ark3116_write_reg(port->serial, UART_LCR, priv->lcr);
 
 	mutex_unlock(&priv->hw_lock);
+
+	return ret;
 }
 
 static void ark3116_update_msr(struct usb_serial_port *port, __u8 msr)
diff --git a/drivers/usb/serial/belkin_sa.c b/drivers/usb/serial/belkin_sa.c
index 9331a562dac0..cf47ee4ae5d3 100644
--- a/drivers/usb/serial/belkin_sa.c
+++ b/drivers/usb/serial/belkin_sa.c
@@ -46,7 +46,7 @@ static void belkin_sa_process_read_urb(struct urb *urb);
 static void belkin_sa_set_termios(struct tty_struct *tty,
 				  struct usb_serial_port *port,
 				  const struct ktermios *old_termios);
-static void belkin_sa_break_ctl(struct tty_struct *tty, int break_state);
+static int belkin_sa_break_ctl(struct tty_struct *tty, int break_state);
 static int  belkin_sa_tiocmget(struct tty_struct *tty);
 static int  belkin_sa_tiocmset(struct tty_struct *tty,
 					unsigned int set, unsigned int clear);
@@ -399,13 +399,19 @@ static void belkin_sa_set_termios(struct tty_struct *tty,
 	spin_unlock_irqrestore(&priv->lock, flags);
 }
 
-static void belkin_sa_break_ctl(struct tty_struct *tty, int break_state)
+static int belkin_sa_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_serial *serial = port->serial;
+	int ret;
 
-	if (BSA_USB_CMD(BELKIN_SA_SET_BREAK_REQUEST, break_state ? 1 : 0) < 0)
+	ret = BSA_USB_CMD(BELKIN_SA_SET_BREAK_REQUEST, break_state ? 1 : 0);
+	if (ret < 0) {
 		dev_err(&port->dev, "Set break_ctl %d\n", break_state);
+		return ret;
+	}
+
+	return 0;
 }
 
 static int belkin_sa_tiocmget(struct tty_struct *tty)
diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 6e1b87e67304..612bea504d7a 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -562,12 +562,12 @@ static void ch341_set_termios(struct tty_struct *tty,
  * TCSBRKP. Due to how the simulation is implemented the duration can't be
  * controlled. The duration is always about (1s / 46bd * 9bit) = 196ms.
  */
-static void ch341_simulate_break(struct tty_struct *tty, int break_state)
+static int ch341_simulate_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ch341_private *priv = usb_get_serial_port_data(port);
 	unsigned long now, delay;
-	int r;
+	int r, r2;
 
 	if (break_state != 0) {
 		dev_dbg(&port->dev, "enter break state requested\n");
@@ -599,7 +599,7 @@ static void ch341_simulate_break(struct tty_struct *tty, int break_state)
 		 */
 		priv->break_end = jiffies + (11 * HZ / CH341_MIN_BPS);
 
-		return;
+		return 0;
 	}
 
 	dev_dbg(&port->dev, "leave break state requested\n");
@@ -615,17 +615,22 @@ static void ch341_simulate_break(struct tty_struct *tty, int break_state)
 		schedule_timeout_interruptible(delay);
 	}
 
+	r = 0;
 restore:
 	/* Restore original baud rate */
-	r = ch341_set_baudrate_lcr(port->serial->dev, priv, priv->baud_rate,
-				   priv->lcr);
-	if (r < 0)
+	r2 = ch341_set_baudrate_lcr(port->serial->dev, priv, priv->baud_rate,
+			priv->lcr);
+	if (r2 < 0) {
 		dev_err(&port->dev,
 			"restoring original baud rate of %u failed: %d\n",
-			priv->baud_rate, r);
+			priv->baud_rate, r2);
+		return r2;
+	}
+
+	return r;
 }
 
-static void ch341_break_ctl(struct tty_struct *tty, int break_state)
+static int ch341_break_ctl(struct tty_struct *tty, int break_state)
 {
 	const uint16_t ch341_break_reg =
 			((uint16_t) CH341_REG_LCR << 8) | CH341_REG_BREAK;
@@ -635,17 +640,17 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
 	uint16_t reg_contents;
 	uint8_t break_reg[2];
 
-	if (priv->quirks & CH341_QUIRK_SIMULATE_BREAK) {
-		ch341_simulate_break(tty, break_state);
-		return;
-	}
+	if (priv->quirks & CH341_QUIRK_SIMULATE_BREAK)
+		return ch341_simulate_break(tty, break_state);
 
 	r = ch341_control_in(port->serial->dev, CH341_REQ_READ_REG,
 			ch341_break_reg, 0, break_reg, 2);
 	if (r) {
 		dev_err(&port->dev, "%s - USB control read error (%d)\n",
 				__func__, r);
-		return;
+		if (r > 0)
+			r = -EIO;
+		return r;
 	}
 	dev_dbg(&port->dev, "%s - initial ch341 break register contents - reg1: %x, reg2: %x\n",
 		__func__, break_reg[0], break_reg[1]);
@@ -663,9 +668,13 @@ static void ch341_break_ctl(struct tty_struct *tty, int break_state)
 	reg_contents = get_unaligned_le16(break_reg);
 	r = ch341_control_out(port->serial->dev, CH341_REQ_WRITE_REG,
 			ch341_break_reg, reg_contents);
-	if (r < 0)
+	if (r < 0) {
 		dev_err(&port->dev, "%s - USB control write error (%d)\n",
 				__func__, r);
+		return r;
+	}
+
+	return 0;
 }
 
 static int ch341_tiocmset(struct tty_struct *tty,
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index cdea1bff3b70..81e49ed9d147 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -39,7 +39,7 @@ static int cp210x_tiocmget(struct tty_struct *);
 static int cp210x_tiocmset(struct tty_struct *, unsigned int, unsigned int);
 static int cp210x_tiocmset_port(struct usb_serial_port *port,
 		unsigned int, unsigned int);
-static void cp210x_break_ctl(struct tty_struct *, int);
+static int cp210x_break_ctl(struct tty_struct *, int);
 static int cp210x_attach(struct usb_serial *);
 static void cp210x_disconnect(struct usb_serial *);
 static void cp210x_release(struct usb_serial *);
@@ -1434,7 +1434,7 @@ static int cp210x_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-static void cp210x_break_ctl(struct tty_struct *tty, int break_state)
+static int cp210x_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	u16 state;
@@ -1443,9 +1443,11 @@ static void cp210x_break_ctl(struct tty_struct *tty, int break_state)
 		state = BREAK_OFF;
 	else
 		state = BREAK_ON;
+
 	dev_dbg(&port->dev, "%s - turning break %s\n", __func__,
 		state == BREAK_OFF ? "off" : "on");
-	cp210x_write_u16_reg(port, CP210X_SET_BREAK, state);
+
+	return cp210x_write_u16_reg(port, CP210X_SET_BREAK, state);
 }
 
 #ifdef CONFIG_GPIOLIB
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 45d688e9b93f..d1dea3850576 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -217,7 +217,7 @@ static void digi_rx_unthrottle(struct tty_struct *tty);
 static void digi_set_termios(struct tty_struct *tty,
 			     struct usb_serial_port *port,
 			     const struct ktermios *old_termios);
-static void digi_break_ctl(struct tty_struct *tty, int break_state);
+static int digi_break_ctl(struct tty_struct *tty, int break_state);
 static int digi_tiocmget(struct tty_struct *tty);
 static int digi_tiocmset(struct tty_struct *tty, unsigned int set,
 		unsigned int clear);
@@ -839,7 +839,7 @@ static void digi_set_termios(struct tty_struct *tty,
 }
 
 
-static void digi_break_ctl(struct tty_struct *tty, int break_state)
+static int digi_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	unsigned char buf[4];
@@ -848,7 +848,8 @@ static void digi_break_ctl(struct tty_struct *tty, int break_state)
 	buf[1] = 2;				/* length */
 	buf[2] = break_state ? 1 : 0;
 	buf[3] = 0;				/* pad */
-	digi_write_inb_command(port, buf, 4, 0);
+
+	return digi_write_inb_command(port, buf, 4, 0);
 }
 
 
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 891fb1fe69df..5f7a46bcace6 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -448,7 +448,7 @@ static void f81534a_process_read_urb(struct urb *urb)
 	tty_flip_buffer_push(&port->port);
 }
 
-static void f81232_break_ctl(struct tty_struct *tty, int break_state)
+static int f81232_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct f81232_private *priv = usb_get_serial_port_data(port);
@@ -467,6 +467,8 @@ static void f81232_break_ctl(struct tty_struct *tty, int break_state)
 		dev_err(&port->dev, "set break failed: %d\n", status);
 
 	mutex_unlock(&priv->lock);
+
+	return status;
 }
 
 static int f81232_find_clk(speed_t baudrate)
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index 4083ae961be4..ef126cd3d94f 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -656,7 +656,7 @@ static int f81534_set_port_config(struct usb_serial_port *port,
 	return status;
 }
 
-static void f81534_break_ctl(struct tty_struct *tty, int break_state)
+static int f81534_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct f81534_port_private *port_priv = usb_get_serial_port_data(port);
@@ -675,6 +675,8 @@ static void f81534_break_ctl(struct tty_struct *tty, int break_state)
 		dev_err(&port->dev, "set break failed: %d\n", status);
 
 	mutex_unlock(&port_priv->lcr_mutex);
+
+	return status;
 }
 
 static int f81534_update_mctrl(struct usb_serial_port *port, unsigned int set,
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 05e28a5ce42b..1bf23611be12 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2550,11 +2550,12 @@ static void ftdi_process_read_urb(struct urb *urb)
 		tty_flip_buffer_push(&port->port);
 }
 
-static void ftdi_break_ctl(struct tty_struct *tty, int break_state)
+static int ftdi_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 	u16 value;
+	int ret;
 
 	/* break_state = -1 to turn on break, and 0 to turn off break */
 	/* see drivers/char/tty_io.c to see it used */
@@ -2565,19 +2566,22 @@ static void ftdi_break_ctl(struct tty_struct *tty, int break_state)
 	else
 		value = priv->last_set_data_value;
 
-	if (usb_control_msg(port->serial->dev,
+	ret = usb_control_msg(port->serial->dev,
 			usb_sndctrlpipe(port->serial->dev, 0),
 			FTDI_SIO_SET_DATA_REQUEST,
 			FTDI_SIO_SET_DATA_REQUEST_TYPE,
 			value, priv->channel,
-			NULL, 0, WDR_TIMEOUT) < 0) {
+			NULL, 0, WDR_TIMEOUT);
+	if (ret < 0) {
 		dev_err(&port->dev, "%s FAILED to enable/disable break state (state was %d)\n",
 			__func__, break_state);
+		return ret;
 	}
 
 	dev_dbg(&port->dev, "%s break state is %d - urb is %d\n", __func__,
 		break_state, value);
 
+	return 0;
 }
 
 static bool ftdi_tx_empty(struct usb_serial_port *port)
diff --git a/drivers/usb/serial/io_edgeport.c b/drivers/usb/serial/io_edgeport.c
index 3a4c0febf335..abe4bbb0ac65 100644
--- a/drivers/usb/serial/io_edgeport.c
+++ b/drivers/usb/serial/io_edgeport.c
@@ -1560,12 +1560,12 @@ static int edge_ioctl(struct tty_struct *tty,
  * SerialBreak
  *	this function sends a break to the port
  *****************************************************************************/
-static void edge_break(struct tty_struct *tty, int break_state)
+static int edge_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
 	struct edgeport_serial *edge_serial = usb_get_serial_data(port->serial);
-	int status;
+	int status = 0;
 
 	if (!edge_serial->is_epic ||
 	    edge_serial->epic_descriptor.Supports.IOSPChase) {
@@ -1597,6 +1597,8 @@ static void edge_break(struct tty_struct *tty, int break_state)
 			dev_dbg(&port->dev, "%s - error sending break set/clear command.\n",
 				__func__);
 	}
+
+	return status;
 }
 
 
diff --git a/drivers/usb/serial/io_ti.c b/drivers/usb/serial/io_ti.c
index bc3c24ea42c1..7a3a6e539456 100644
--- a/drivers/usb/serial/io_ti.c
+++ b/drivers/usb/serial/io_ti.c
@@ -2421,7 +2421,7 @@ static int edge_tiocmget(struct tty_struct *tty)
 	return result;
 }
 
-static void edge_break(struct tty_struct *tty, int break_state)
+static int edge_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct edgeport_port *edge_port = usb_get_serial_port_data(port);
@@ -2430,10 +2430,15 @@ static void edge_break(struct tty_struct *tty, int break_state)
 
 	if (break_state == -1)
 		bv = 1;	/* On */
+
 	status = ti_do_config(edge_port, UMPC_SET_CLR_BREAK, bv);
-	if (status)
+	if (status) {
 		dev_dbg(&port->dev, "%s - error %d sending break set/clear command.\n",
 			__func__, status);
+		return status;
+	}
+
+	return 0;
 }
 
 static void edge_heartbeat_schedule(struct edgeport_serial *edge_serial)
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 2966e0c4941e..93b17e0e05a3 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -599,7 +599,7 @@ struct keyspan_port_private {
 #include "keyspan_usa67msg.h"
 
 
-static void keyspan_break_ctl(struct tty_struct *tty, int break_state)
+static int keyspan_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct keyspan_port_private 	*p_priv;
@@ -611,7 +611,10 @@ static void keyspan_break_ctl(struct tty_struct *tty, int break_state)
 	else
 		p_priv->break_on = 0;
 
+	/* FIXME: return errors */
 	keyspan_send_setup(port, 0);
+
+	return 0;
 }
 
 
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index 6fd15cd9e1eb..0eef358b314a 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -299,7 +299,7 @@ static speed_t keyspan_pda_setbaud(struct usb_serial *serial, speed_t baud)
 	return baud;
 }
 
-static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
+static int keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_serial *serial = port->serial;
@@ -315,9 +315,13 @@ static void keyspan_pda_break_ctl(struct tty_struct *tty, int break_state)
 			4, /* set break */
 			USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
 			value, 0, NULL, 0, 2000);
-	if (result < 0)
+	if (result < 0) {
 		dev_dbg(&port->dev, "%s - error %d from usb_control_msg\n",
 			__func__, result);
+		return result;
+	}
+
+	return 0;
 }
 
 static void keyspan_pda_set_termios(struct tty_struct *tty,
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index d3852feb81a4..6570c8817a80 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -47,7 +47,7 @@ static void mct_u232_read_int_callback(struct urb *urb);
 static void mct_u232_set_termios(struct tty_struct *tty,
 				 struct usb_serial_port *port,
 				 const struct ktermios *old_termios);
-static void mct_u232_break_ctl(struct tty_struct *tty, int break_state);
+static int  mct_u232_break_ctl(struct tty_struct *tty, int break_state);
 static int  mct_u232_tiocmget(struct tty_struct *tty);
 static int  mct_u232_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
@@ -677,7 +677,7 @@ static void mct_u232_set_termios(struct tty_struct *tty,
 	spin_unlock_irqrestore(&priv->lock, flags);
 } /* mct_u232_set_termios */
 
-static void mct_u232_break_ctl(struct tty_struct *tty, int break_state)
+static int mct_u232_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
@@ -691,7 +691,7 @@ static void mct_u232_break_ctl(struct tty_struct *tty, int break_state)
 		lcr |= MCT_U232_SET_BREAK;
 	spin_unlock_irqrestore(&priv->lock, flags);
 
-	mct_u232_set_line_ctrl(port, lcr);
+	return mct_u232_set_line_ctrl(port, lcr);
 } /* mct_u232_break_ctl */
 
 
diff --git a/drivers/usb/serial/mos7720.c b/drivers/usb/serial/mos7720.c
index 1d1f85fabc28..23544074eb1c 100644
--- a/drivers/usb/serial/mos7720.c
+++ b/drivers/usb/serial/mos7720.c
@@ -996,7 +996,7 @@ static void mos7720_close(struct usb_serial_port *port)
 	mos7720_port->open = 0;
 }
 
-static void mos7720_break(struct tty_struct *tty, int break_state)
+static int mos7720_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	unsigned char data;
@@ -1007,7 +1007,7 @@ static void mos7720_break(struct tty_struct *tty, int break_state)
 
 	mos7720_port = usb_get_serial_port_data(port);
 	if (mos7720_port == NULL)
-		return;
+		return -ENODEV;
 
 	if (break_state == -1)
 		data = mos7720_port->shadowLCR | UART_LCR_SBC;
@@ -1015,8 +1015,9 @@ static void mos7720_break(struct tty_struct *tty, int break_state)
 		data = mos7720_port->shadowLCR & ~UART_LCR_SBC;
 
 	mos7720_port->shadowLCR  = data;
-	write_mos_reg(serial, port->port_number, MOS7720_LCR,
-		      mos7720_port->shadowLCR);
+
+	return write_mos_reg(serial, port->port_number, MOS7720_LCR,
+			     mos7720_port->shadowLCR);
 }
 
 /*
diff --git a/drivers/usb/serial/mos7840.c b/drivers/usb/serial/mos7840.c
index 73370eaae0ab..8b0308d84270 100644
--- a/drivers/usb/serial/mos7840.c
+++ b/drivers/usb/serial/mos7840.c
@@ -787,7 +787,7 @@ static void mos7840_close(struct usb_serial_port *port)
  * mos7840_break
  *	this function sends a break to the port
  *****************************************************************************/
-static void mos7840_break(struct tty_struct *tty, int break_state)
+static int mos7840_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct moschip_port *mos7840_port = usb_get_serial_port_data(port);
@@ -801,8 +801,9 @@ static void mos7840_break(struct tty_struct *tty, int break_state)
 	/* FIXME: no locking on shadowLCR anywhere in driver */
 	mos7840_port->shadowLCR = data;
 	dev_dbg(&port->dev, "%s mos7840_port->shadowLCR is %x\n", __func__, mos7840_port->shadowLCR);
-	mos7840_set_uart_reg(port, LINE_CONTROL_REGISTER,
-			     mos7840_port->shadowLCR);
+
+	return mos7840_set_uart_reg(port, LINE_CONTROL_REGISTER,
+				    mos7840_port->shadowLCR);
 }
 
 /*****************************************************************************
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index faa0eedfe245..1f7bb3e4fcf2 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -1230,7 +1230,7 @@ static void mxuport_close(struct usb_serial_port *port)
 }
 
 /* Send a break to the port. */
-static void mxuport_break_ctl(struct tty_struct *tty, int break_state)
+static int mxuport_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct usb_serial *serial = port->serial;
@@ -1244,8 +1244,8 @@ static void mxuport_break_ctl(struct tty_struct *tty, int break_state)
 		dev_dbg(&port->dev, "%s - clearing break\n", __func__);
 	}
 
-	mxuport_send_ctrl_urb(serial, RQ_VENDOR_SET_BREAK,
-			      enable, port->port_number);
+	return mxuport_send_ctrl_urb(serial, RQ_VENDOR_SET_BREAK,
+				     enable, port->port_number);
 }
 
 static int mxuport_resume(struct usb_serial *serial)
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index 8949c1891164..d93f5d584557 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -173,7 +173,7 @@ MODULE_DEVICE_TABLE(usb, id_table);
 #define PL2303_HXN_FLOWCTRL_RTS_CTS	0x18
 #define PL2303_HXN_FLOWCTRL_XON_XOFF	0x0c
 
-static void pl2303_set_break(struct usb_serial_port *port, bool enable);
+static int pl2303_set_break(struct usb_serial_port *port, bool enable);
 
 enum pl2303_type {
 	TYPE_H,
@@ -1060,7 +1060,7 @@ static int pl2303_carrier_raised(struct usb_serial_port *port)
 	return 0;
 }
 
-static void pl2303_set_break(struct usb_serial_port *port, bool enable)
+static int pl2303_set_break(struct usb_serial_port *port, bool enable)
 {
 	struct usb_serial *serial = port->serial;
 	u16 state;
@@ -1077,15 +1077,19 @@ static void pl2303_set_break(struct usb_serial_port *port, bool enable)
 	result = usb_control_msg(serial->dev, usb_sndctrlpipe(serial->dev, 0),
 				 BREAK_REQUEST, BREAK_REQUEST_TYPE, state,
 				 0, NULL, 0, 100);
-	if (result)
+	if (result) {
 		dev_err(&port->dev, "error sending break = %d\n", result);
+		return result;
+	}
+
+	return 0;
 }
 
-static void pl2303_break_ctl(struct tty_struct *tty, int state)
+static int pl2303_break_ctl(struct tty_struct *tty, int state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 
-	pl2303_set_break(port, state);
+	return pl2303_set_break(port, state);
 }
 
 static void pl2303_update_line_status(struct usb_serial_port *port,
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index fee581409bf6..821f25e52ec2 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -741,7 +741,7 @@ static int qt2_tiocmset(struct tty_struct *tty,
 	return update_mctrl(port_priv, set, clear);
 }
 
-static void qt2_break_ctl(struct tty_struct *tty, int break_state)
+static int qt2_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct qt2_port_private *port_priv;
@@ -754,10 +754,14 @@ static void qt2_break_ctl(struct tty_struct *tty, int break_state)
 
 	status = qt2_control_msg(port->serial->dev, QT2_BREAK_CONTROL,
 				 val, port_priv->device_port);
-	if (status < 0)
+	if (status < 0) {
 		dev_warn(&port->dev,
 			 "%s - failed to send control message: %i\n", __func__,
 			 status);
+		return status;
+	}
+
+	return 0;
 }
 
 
diff --git a/drivers/usb/serial/ti_usb_3410_5052.c b/drivers/usb/serial/ti_usb_3410_5052.c
index b99f78224846..0fba25abf671 100644
--- a/drivers/usb/serial/ti_usb_3410_5052.c
+++ b/drivers/usb/serial/ti_usb_3410_5052.c
@@ -319,7 +319,7 @@ static void ti_set_termios(struct tty_struct *tty,
 static int ti_tiocmget(struct tty_struct *tty);
 static int ti_tiocmset(struct tty_struct *tty,
 		unsigned int set, unsigned int clear);
-static void ti_break(struct tty_struct *tty, int break_state);
+static int ti_break(struct tty_struct *tty, int break_state);
 static void ti_interrupt_callback(struct urb *urb);
 static void ti_bulk_in_callback(struct urb *urb);
 static void ti_bulk_out_callback(struct urb *urb);
@@ -1071,7 +1071,7 @@ static int ti_tiocmset(struct tty_struct *tty,
 }
 
 
-static void ti_break(struct tty_struct *tty, int break_state)
+static int ti_break(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct ti_port *tport = usb_get_serial_port_data(port);
@@ -1083,8 +1083,12 @@ static void ti_break(struct tty_struct *tty, int break_state)
 		tport->tp_uart_base_addr + TI_UART_OFFSET_LCR,
 		TI_LCR_BREAK, break_state == -1 ? TI_LCR_BREAK : 0);
 
-	if (status)
+	if (status) {
 		dev_dbg(&port->dev, "%s - error setting break, %d\n", __func__, status);
+		return status;
+	}
+
+	return 0;
 }
 
 static int ti_get_port_from_code(unsigned char code)
diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index c47439bd90fa..46952182e04f 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -238,12 +238,13 @@ static int upd78f0730_tiocmset(struct tty_struct *tty,
 	return res;
 }
 
-static void upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
+static int upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct upd78f0730_port_private *private;
 	struct usb_serial_port *port = tty->driver_data;
 	struct upd78f0730_set_dtr_rts request;
 	struct device *dev = &port->dev;
+	int res;
 
 	private = usb_get_serial_port_data(port);
 
@@ -258,8 +259,10 @@ static void upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 	request.opcode = UPD78F0730_CMD_SET_DTR_RTS;
 	request.params = private->line_signals;
 
-	upd78f0730_send_ctl(port, &request, sizeof(request));
+	res = upd78f0730_send_ctl(port, &request, sizeof(request));
 	mutex_unlock(&private->lock);
+
+	return res;
 }
 
 static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f8404073558b..470634444af7 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -539,7 +539,7 @@ static int serial_break(struct tty_struct *tty, int break_state)
 	dev_dbg(&port->dev, "%s\n", __func__);
 
 	if (port->serial->type->break_ctl)
-		port->serial->type->break_ctl(tty, break_state);
+		return port->serial->type->break_ctl(tty, break_state);
 
 	return 0;
 }
diff --git a/drivers/usb/serial/usb_debug.c b/drivers/usb/serial/usb_debug.c
index aaf4813e4971..6934970f180d 100644
--- a/drivers/usb/serial/usb_debug.c
+++ b/drivers/usb/serial/usb_debug.c
@@ -47,12 +47,19 @@ MODULE_DEVICE_TABLE(usb, id_table_combined);
 /* This HW really does not support a serial break, so one will be
  * emulated when ever the break state is set to true.
  */
-static void usb_debug_break_ctl(struct tty_struct *tty, int break_state)
+static int usb_debug_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
+	int ret;
+
 	if (!break_state)
-		return;
-	usb_serial_generic_write(tty, port, USB_DEBUG_BRK, USB_DEBUG_BRK_SIZE);
+		return 0;
+
+	ret = usb_serial_generic_write(tty, port, USB_DEBUG_BRK, USB_DEBUG_BRK_SIZE);
+	if (ret < 0)
+		return ret;
+
+	return 0;
 }
 
 static void usb_debug_process_read_urb(struct urb *urb)
diff --git a/drivers/usb/serial/whiteheat.c b/drivers/usb/serial/whiteheat.c
index 7f82d40753ee..ca48e90a8e81 100644
--- a/drivers/usb/serial/whiteheat.c
+++ b/drivers/usb/serial/whiteheat.c
@@ -87,7 +87,7 @@ static void whiteheat_set_termios(struct tty_struct *tty,
 static int  whiteheat_tiocmget(struct tty_struct *tty);
 static int  whiteheat_tiocmset(struct tty_struct *tty,
 			unsigned int set, unsigned int clear);
-static void whiteheat_break_ctl(struct tty_struct *tty, int break_state);
+static int whiteheat_break_ctl(struct tty_struct *tty, int break_state);
 
 static struct usb_serial_driver whiteheat_fake_device = {
 	.driver = {
@@ -449,10 +449,11 @@ static void whiteheat_set_termios(struct tty_struct *tty,
 	firm_setup_port(tty);
 }
 
-static void whiteheat_break_ctl(struct tty_struct *tty, int break_state)
+static int whiteheat_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
-	firm_set_break(port, break_state);
+
+	return firm_set_break(port, break_state);
 }
 
 
diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index fdb0aae546c3..4ec7c5892b84 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -503,7 +503,7 @@ static void xr_dtr_rts(struct usb_serial_port *port, int on)
 		xr_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
 }
 
-static void xr_break_ctl(struct tty_struct *tty, int break_state)
+static int xr_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct usb_serial_port *port = tty->driver_data;
 	struct xr_data *data = usb_get_serial_port_data(port);
@@ -517,7 +517,7 @@ static void xr_break_ctl(struct tty_struct *tty, int break_state)
 
 	dev_dbg(&port->dev, "Turning break %s\n", state == 0 ? "off" : "on");
 
-	xr_set_reg_uart(port, type->tx_break, state);
+	return xr_set_reg_uart(port, type->tx_break, state);
 }
 
 /* Tx and Rx clock mask values obtained from section 3.3.4 of datasheet */
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index 7eeb5f9c4f0d..1a0a4dc87980 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -278,7 +278,7 @@ struct usb_serial_driver {
 	int  (*set_serial)(struct tty_struct *tty, struct serial_struct *ss);
 	void (*set_termios)(struct tty_struct *tty, struct usb_serial_port *port,
 			    const struct ktermios *old);
-	void (*break_ctl)(struct tty_struct *tty, int break_state);
+	int (*break_ctl)(struct tty_struct *tty, int break_state);
 	unsigned int (*chars_in_buffer)(struct tty_struct *tty);
 	void (*wait_until_sent)(struct tty_struct *tty, long timeout);
 	bool (*tx_empty)(struct usb_serial_port *port);
-- 
2.39.3

