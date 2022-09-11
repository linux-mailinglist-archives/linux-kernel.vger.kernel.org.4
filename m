Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24F7E5B4F4E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Sep 2022 16:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbiIKODX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 10:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiIKODL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 10:03:11 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005363340C;
        Sun, 11 Sep 2022 07:03:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91EC56102D;
        Sun, 11 Sep 2022 14:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE7CC43142;
        Sun, 11 Sep 2022 14:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662904989;
        bh=w/Ksdq4EdREphK9IhIE14j5zncHoLhHSvs29UcJrW5U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmoXeV2wK8f7EFdzxWlFv9h1l8cULEcRSt04zuf7O6OwjddT/gdBisRCzJqZsiomk
         wcKY40jsFt1mlJLbcUtYq42oLmd0mTjdvQ4EFBaujlQGessWcq2wKLarlvF36y41sc
         Fuf8drXYzvZ/K/CR5DO+mc5KtnV2K4oNxvcj92ZggodajWH0+mR/kwdq6bOyExn11E
         3nW4K/yHZeuIbLcubCfyB8DoYqqpkPTVOEpmvzJWvjbtvUxVzBEG8zZ2uFopy8ojvW
         v+wAHVK7cY9mLr/rwko6ltUDoONOj1b8H71c/KKwLeZhjyX02h49VPEfpf8bbVJamA
         nE5jNpTQ3YIYw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1oXNYL-0007wj-Sb; Sun, 11 Sep 2022 16:03:17 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Amireddy mallikarjuna reddy <mallikarjuna.reddy@ftdichip.com>,
        arun.pappan@ftdichip.com, sowjanya.reddy@ftdichip.com,
        malliamireddy009@gmail.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 05/12] USB: serial: ftdi_sio: rename channel index
Date:   Sun, 11 Sep 2022 16:02:09 +0200
Message-Id: <20220911140216.30481-6-johan@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220911140216.30481-1-johan@kernel.org>
References: <20220911140216.30481-1-johan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multi-channel devices require a channel selector to be included in
control requests.

Replace "interface" with the less ambiguous "channel", which is the
terminology used for newer devices, in the corresponding defines and
variables.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/ftdi_sio.c | 40 +++++++++++++++++------------------
 drivers/usb/serial/ftdi_sio.h | 10 ++++-----
 2 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index cd3cdecc5f90..707dc3d67a19 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -72,8 +72,7 @@ struct ftdi_private {
 	unsigned long last_dtr_rts;	/* saved modem control outputs */
 	char prev_status;        /* Used for TIOCMIWAIT */
 	char transmit_empty;	/* If transmitter is empty or not */
-	u16 interface;		/* FT2232C, FT2232H or FT4232H port interface
-				   (0 for FT232/245) */
+	u16 channel;		/* channel index, or 0 for legacy types */
 
 	speed_t force_baud;	/* if non-zero, force the baud rate to
 				   this value */
@@ -1271,7 +1270,7 @@ static int update_mctrl(struct usb_serial_port *port, unsigned int set,
 			       usb_sndctrlpipe(port->serial->dev, 0),
 			       FTDI_SIO_SET_MODEM_CTRL_REQUEST,
 			       FTDI_SIO_SET_MODEM_CTRL_REQUEST_TYPE,
-			       value, priv->interface,
+			       value, priv->channel,
 			       NULL, 0, WDR_TIMEOUT);
 	if (rv < 0) {
 		dev_dbg(dev, "%s Error from MODEM_CTRL urb: DTR %s, RTS %s\n",
@@ -1413,7 +1412,7 @@ static int change_speed(struct tty_struct *tty, struct usb_serial_port *port)
 			priv->chip_type == FTX) {
 		/* Probably the BM type needs the MSB of the encoded fractional
 		 * divider also moved like for the chips above. Any infos? */
-		index = (u16)((index << 8) | priv->interface);
+		index = (u16)((index << 8) | priv->channel);
 	}
 
 	rv = usb_control_msg(port->serial->dev,
@@ -1444,7 +1443,7 @@ static int write_latency_timer(struct usb_serial_port *port)
 			     usb_sndctrlpipe(udev, 0),
 			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST,
 			     FTDI_SIO_SET_LATENCY_TIMER_REQUEST_TYPE,
-			     l, priv->interface,
+			     l, priv->channel,
 			     NULL, 0, WDR_TIMEOUT);
 	if (rv < 0)
 		dev_err(&port->dev, "Unable to write latency timer: %i\n", rv);
@@ -1460,7 +1459,7 @@ static int _read_latency_timer(struct usb_serial_port *port)
 
 	rv = usb_control_msg_recv(udev, 0, FTDI_SIO_GET_LATENCY_TIMER_REQUEST,
 				  FTDI_SIO_GET_LATENCY_TIMER_REQUEST_TYPE, 0,
-				  priv->interface, &buf, 1, WDR_TIMEOUT,
+				  priv->channel, &buf, 1, WDR_TIMEOUT,
 				  GFP_KERNEL);
 	if (rv == 0)
 		rv = buf;
@@ -1581,15 +1580,14 @@ static void ftdi_determine_type(struct usb_serial_port *port)
 		} else
 			priv->chip_type = FT2232C;
 
-		/* Determine interface code. */
 		if (ifnum == 0)
-			priv->interface = INTERFACE_A;
+			priv->channel = CHANNEL_A;
 		else if (ifnum == 1)
-			priv->interface = INTERFACE_B;
+			priv->channel = CHANNEL_B;
 		else if (ifnum == 2)
-			priv->interface = INTERFACE_C;
+			priv->channel = CHANNEL_C;
 		else if (ifnum == 3)
-			priv->interface = INTERFACE_D;
+			priv->channel = CHANNEL_D;
 
 		/* BM-type devices have a bug where bcdDevice gets set
 		 * to 0x200 when iSerialNumber is 0.  */
@@ -1730,7 +1728,7 @@ static ssize_t event_char_store(struct device *dev,
 			     usb_sndctrlpipe(udev, 0),
 			     FTDI_SIO_SET_EVENT_CHAR_REQUEST,
 			     FTDI_SIO_SET_EVENT_CHAR_REQUEST_TYPE,
-			     v, priv->interface,
+			     v, priv->channel,
 			     NULL, 0, WDR_TIMEOUT);
 	if (rv < 0) {
 		dev_dbg(&port->dev, "Unable to write event character: %i\n", rv);
@@ -1804,7 +1802,7 @@ static int ftdi_set_bitmode(struct usb_serial_port *port, u8 mode)
 				 usb_sndctrlpipe(serial->dev, 0),
 				 FTDI_SIO_SET_BITMODE_REQUEST,
 				 FTDI_SIO_SET_BITMODE_REQUEST_TYPE, val,
-				 priv->interface, NULL, 0, WDR_TIMEOUT);
+				 priv->channel, NULL, 0, WDR_TIMEOUT);
 	if (result < 0) {
 		dev_err(&serial->interface->dev,
 			"bitmode request failed for value 0x%04x: %d\n",
@@ -1868,7 +1866,7 @@ static int ftdi_read_cbus_pins(struct usb_serial_port *port)
 	result = usb_control_msg_recv(serial->dev, 0,
 				      FTDI_SIO_READ_PINS_REQUEST,
 				      FTDI_SIO_READ_PINS_REQUEST_TYPE, 0,
-				      priv->interface, &buf, 1, WDR_TIMEOUT,
+				      priv->channel, &buf, 1, WDR_TIMEOUT,
 				      GFP_KERNEL);
 	if (result == 0)
 		result = buf;
@@ -2404,7 +2402,7 @@ static int ftdi_open(struct tty_struct *tty, struct usb_serial_port *port)
 	usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			FTDI_SIO_RESET_REQUEST, FTDI_SIO_RESET_REQUEST_TYPE,
 			FTDI_SIO_RESET_SIO,
-			priv->interface, NULL, 0, WDR_TIMEOUT);
+			priv->channel, NULL, 0, WDR_TIMEOUT);
 
 	/* Termios defaults are set by usb_serial_init. We don't change
 	   port->tty->termios - this would lose speed settings, etc.
@@ -2427,7 +2425,7 @@ static void ftdi_dtr_rts(struct usb_serial_port *port, int on)
 			    usb_sndctrlpipe(port->serial->dev, 0),
 			    FTDI_SIO_SET_FLOW_CTRL_REQUEST,
 			    FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
-			    0, priv->interface, NULL, 0,
+			    0, priv->channel, NULL, 0,
 			    WDR_TIMEOUT) < 0) {
 			dev_err(&port->dev, "error from flowcontrol urb\n");
 		}
@@ -2620,7 +2618,7 @@ static void ftdi_break_ctl(struct tty_struct *tty, int break_state)
 			usb_sndctrlpipe(port->serial->dev, 0),
 			FTDI_SIO_SET_DATA_REQUEST,
 			FTDI_SIO_SET_DATA_REQUEST_TYPE,
-			value , priv->interface,
+			value, priv->channel,
 			NULL, 0, WDR_TIMEOUT) < 0) {
 		dev_err(&port->dev, "%s FAILED to enable/disable break state (state was %d)\n",
 			__func__, break_state);
@@ -2756,7 +2754,7 @@ static void ftdi_set_termios(struct tty_struct *tty,
 	if (usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			    FTDI_SIO_SET_DATA_REQUEST,
 			    FTDI_SIO_SET_DATA_REQUEST_TYPE,
-			    value , priv->interface,
+			    value, priv->channel,
 			    NULL, 0, WDR_SHORT_TIMEOUT) < 0) {
 		dev_err(ddev, "%s FAILED to set databits/stopbits/parity\n",
 			__func__);
@@ -2769,7 +2767,7 @@ static void ftdi_set_termios(struct tty_struct *tty,
 		if (usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 				    FTDI_SIO_SET_FLOW_CTRL_REQUEST,
 				    FTDI_SIO_SET_FLOW_CTRL_REQUEST_TYPE,
-				    0, priv->interface,
+				    0, priv->channel,
 				    NULL, 0, WDR_TIMEOUT) < 0) {
 			dev_err(ddev, "%s error from disable flowcontrol urb\n",
 				__func__);
@@ -2803,7 +2801,7 @@ static void ftdi_set_termios(struct tty_struct *tty,
 		index = FTDI_SIO_DISABLE_FLOW_CTRL;
 	}
 
-	index |= priv->interface;
+	index |= priv->channel;
 
 	ret = usb_control_msg(dev, usb_sndctrlpipe(dev, 0),
 			FTDI_SIO_SET_FLOW_CTRL_REQUEST,
@@ -2857,7 +2855,7 @@ static int ftdi_get_modem_status(struct usb_serial_port *port,
 			usb_rcvctrlpipe(port->serial->dev, 0),
 			FTDI_SIO_GET_MODEM_STATUS_REQUEST,
 			FTDI_SIO_GET_MODEM_STATUS_REQUEST_TYPE,
-			0, priv->interface,
+			0, priv->channel,
 			buf, len, WDR_TIMEOUT);
 
 	/* NOTE: We allow short responses and handle that below. */
diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
index 12bc3a82ac2c..55ea61264f91 100644
--- a/drivers/usb/serial/ftdi_sio.h
+++ b/drivers/usb/serial/ftdi_sio.h
@@ -40,11 +40,11 @@
 #define FTDI_SIO_READ_PINS		0x0c /* Read immediate value of pins */
 #define FTDI_SIO_READ_EEPROM		0x90 /* Read EEPROM */
 
-/* Interface indices for FT2232, FT2232H and FT4232H devices */
-#define INTERFACE_A		1
-#define INTERFACE_B		2
-#define INTERFACE_C		3
-#define INTERFACE_D		4
+/* Channel indices for FT2232, FT2232H and FT4232H devices */
+#define CHANNEL_A		1
+#define CHANNEL_B		2
+#define CHANNEL_C		3
+#define CHANNEL_D		4
 
 
 /*
-- 
2.35.1

