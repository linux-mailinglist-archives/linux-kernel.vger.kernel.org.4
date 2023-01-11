Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C270665DD2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:26:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbjAKOZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:25:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239455AbjAKOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:25:06 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462EC13F03;
        Wed, 11 Jan 2023 06:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447105; x=1704983105;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tjo30vecdnfzzkp73XHKlN6YohIR8095ki6mZ5URrJY=;
  b=jiPcjGW7rimBOzrpC6OLvtNpJDjcQtMSjqOG8WVnp4OIgZ/LP7Cd7oVt
   dxlte4CqsMzTXrlwKKExsO/KnFyG4Gzko/QrAgEc28H5CI+OLsmTpAI6V
   lZWMhvjAuKVUVdKqIcAmYz6NNBw2SHg3sivi4WlHt1PBQH0zu+Ehxuxlk
   8Wv2WmTOa2puX4L+78lUBQLrThnqi43kywyx3kVzFgQiGEDiMM3U62E+9
   t7odK5qGthKH6tjsCzAGN6U3vUslfWWTzHMpbjMpz4orV2y7pz6d7rHNA
   oNTQao8OcMJXYcMJSUJ9Jji0P2NynE67xgjIvJdYznUIpLhUMZbkHyZ2U
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303793840"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303793840"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:25:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607382161"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607382161"
Received: from mihaiana-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.222.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:25:00 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        Oliver Neukum <oneukum@suse.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 13/13] usb/serial: Rename dtr/rts parameters/variables to active
Date:   Wed, 11 Jan 2023 16:23:31 +0200
Message-Id: <20230111142331.34518-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
References: <20230111142331.34518-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use active consistently for naming parameters and variables.
This converts all USB serial drivers + CDC-ACM.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/usb/class/cdc-acm.c          | 4 ++--
 drivers/usb/serial/ch341.c           | 4 ++--
 drivers/usb/serial/cp210x.c          | 6 +++---
 drivers/usb/serial/cypress_m8.c      | 6 +++---
 drivers/usb/serial/digi_acceleport.c | 6 +++---
 drivers/usb/serial/f81232.c          | 4 ++--
 drivers/usb/serial/f81534.c          | 4 ++--
 drivers/usb/serial/ftdi_sio.c        | 6 +++---
 drivers/usb/serial/ipw.c             | 8 ++++----
 drivers/usb/serial/keyspan.c         | 6 +++---
 drivers/usb/serial/keyspan_pda.c     | 4 ++--
 drivers/usb/serial/mct_u232.c        | 6 +++---
 drivers/usb/serial/mxuport.c         | 4 ++--
 drivers/usb/serial/pl2303.c          | 4 ++--
 drivers/usb/serial/quatech2.c        | 6 +++---
 drivers/usb/serial/sierra.c          | 6 +++---
 drivers/usb/serial/spcp8x5.c         | 4 ++--
 drivers/usb/serial/ssu100.c          | 6 +++---
 drivers/usb/serial/upd78f0730.c      | 4 ++--
 drivers/usb/serial/usb-serial.c      | 4 ++--
 drivers/usb/serial/usb-wwan.h        | 2 +-
 drivers/usb/serial/usb_wwan.c        | 6 +++---
 drivers/usb/serial/xr_serial.c       | 4 ++--
 23 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
index d4f9220b8162..11da5fb284d0 100644
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -651,13 +651,13 @@ static int acm_tty_open(struct tty_struct *tty, struct file *filp)
 	return tty_port_open(&acm->port, tty, filp);
 }
 
-static void acm_port_dtr_rts(struct tty_port *port, bool raise)
+static void acm_port_dtr_rts(struct tty_port *port, bool active)
 {
 	struct acm *acm = container_of(port, struct acm, port);
 	int val;
 	int res;
 
-	if (raise)
+	if (active)
 		val = USB_CDC_CTRL_DTR | USB_CDC_CTRL_RTS;
 	else
 		val = 0;
diff --git a/drivers/usb/serial/ch341.c b/drivers/usb/serial/ch341.c
index 98ec4fe46914..68e2eddde911 100644
--- a/drivers/usb/serial/ch341.c
+++ b/drivers/usb/serial/ch341.c
@@ -420,14 +420,14 @@ static bool ch341_carrier_raised(struct usb_serial_port *port)
 	return priv->msr & CH341_BIT_DCD;
 }
 
-static void ch341_dtr_rts(struct usb_serial_port *port, bool on)
+static void ch341_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct ch341_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
 
 	/* drop DTR and RTS */
 	spin_lock_irqsave(&priv->lock, flags);
-	if (on)
+	if (active)
 		priv->mcr |= CH341_BIT_RTS | CH341_BIT_DTR;
 	else
 		priv->mcr &= ~(CH341_BIT_RTS | CH341_BIT_DTR);
diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
index fe2cdc477fb9..c5c80492ad98 100644
--- a/drivers/usb/serial/cp210x.c
+++ b/drivers/usb/serial/cp210x.c
@@ -45,7 +45,7 @@ static void cp210x_disconnect(struct usb_serial *);
 static void cp210x_release(struct usb_serial *);
 static int cp210x_port_probe(struct usb_serial_port *);
 static void cp210x_port_remove(struct usb_serial_port *);
-static void cp210x_dtr_rts(struct usb_serial_port *port, bool on);
+static void cp210x_dtr_rts(struct usb_serial_port *port, bool active);
 static void cp210x_process_read_urb(struct urb *urb);
 static void cp210x_enable_event_mode(struct usb_serial_port *port);
 static void cp210x_disable_event_mode(struct usb_serial_port *port);
@@ -1402,9 +1402,9 @@ static int cp210x_tiocmset_port(struct usb_serial_port *port,
 	return ret;
 }
 
-static void cp210x_dtr_rts(struct usb_serial_port *port, bool on)
+static void cp210x_dtr_rts(struct usb_serial_port *port, bool active)
 {
-	if (on)
+	if (active)
 		cp210x_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
 	else
 		cp210x_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/usb/serial/cypress_m8.c b/drivers/usb/serial/cypress_m8.c
index 7c6060c17ee0..5167cf6dd99c 100644
--- a/drivers/usb/serial/cypress_m8.c
+++ b/drivers/usb/serial/cypress_m8.c
@@ -118,7 +118,7 @@ static int  cypress_ca42v2_port_probe(struct usb_serial_port *port);
 static void cypress_port_remove(struct usb_serial_port *port);
 static int  cypress_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void cypress_close(struct usb_serial_port *port);
-static void cypress_dtr_rts(struct usb_serial_port *port, bool on);
+static void cypress_dtr_rts(struct usb_serial_port *port, bool active);
 static int  cypress_write(struct tty_struct *tty, struct usb_serial_port *port,
 			const unsigned char *buf, int count);
 static void cypress_send(struct usb_serial_port *port);
@@ -621,12 +621,12 @@ static int cypress_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return result;
 } /* cypress_open */
 
-static void cypress_dtr_rts(struct usb_serial_port *port, bool on)
+static void cypress_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct cypress_private *priv = usb_get_serial_port_data(port);
 	/* drop dtr and rts */
 	spin_lock_irq(&priv->lock);
-	if (!on)
+	if (!active)
 		priv->line_control = 0;
 	else 
 		priv->line_control = CONTROL_DTR | CONTROL_RTS;
diff --git a/drivers/usb/serial/digi_acceleport.c b/drivers/usb/serial/digi_acceleport.c
index 890e446273d7..82529c1939ca 100644
--- a/drivers/usb/serial/digi_acceleport.c
+++ b/drivers/usb/serial/digi_acceleport.c
@@ -228,7 +228,7 @@ static unsigned int digi_write_room(struct tty_struct *tty);
 static unsigned int digi_chars_in_buffer(struct tty_struct *tty);
 static int digi_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void digi_close(struct usb_serial_port *port);
-static void digi_dtr_rts(struct usb_serial_port *port, bool on);
+static void digi_dtr_rts(struct usb_serial_port *port, bool active);
 static int digi_startup_device(struct usb_serial *serial);
 static int digi_startup(struct usb_serial *serial);
 static void digi_disconnect(struct usb_serial *serial);
@@ -1060,10 +1060,10 @@ static unsigned int digi_chars_in_buffer(struct tty_struct *tty)
 	return chars;
 }
 
-static void digi_dtr_rts(struct usb_serial_port *port, bool on)
+static void digi_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	/* Adjust DTR and RTS */
-	digi_set_modem_signals(port, on ? (TIOCM_DTR | TIOCM_RTS) : 0, 1);
+	digi_set_modem_signals(port, active ? (TIOCM_DTR | TIOCM_RTS) : 0, 1);
 }
 
 static int digi_open(struct tty_struct *tty, struct usb_serial_port *port)
diff --git a/drivers/usb/serial/f81232.c b/drivers/usb/serial/f81232.c
index 1656be847460..ca5ff47417a9 100644
--- a/drivers/usb/serial/f81232.c
+++ b/drivers/usb/serial/f81232.c
@@ -752,9 +752,9 @@ static void f81232_close(struct usb_serial_port *port)
 	flush_work(&port_priv->lsr_work);
 }
 
-static void f81232_dtr_rts(struct usb_serial_port *port, bool on)
+static void f81232_dtr_rts(struct usb_serial_port *port, bool active)
 {
-	if (on)
+	if (active)
 		f81232_set_mctrl(port, TIOCM_DTR | TIOCM_RTS, 0);
 	else
 		f81232_set_mctrl(port, 0, TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/usb/serial/f81534.c b/drivers/usb/serial/f81534.c
index 8b44b08752d6..1c3de4c752d6 100644
--- a/drivers/usb/serial/f81534.c
+++ b/drivers/usb/serial/f81534.c
@@ -1456,9 +1456,9 @@ static int f81534_tiocmset(struct tty_struct *tty, unsigned int set,
 	return f81534_update_mctrl(port, set, clear);
 }
 
-static void f81534_dtr_rts(struct usb_serial_port *port, bool on)
+static void f81534_dtr_rts(struct usb_serial_port *port, bool active)
 {
-	if (on)
+	if (active)
 		f81534_update_mctrl(port, TIOCM_DTR | TIOCM_RTS, 0);
 	else
 		f81534_update_mctrl(port, 0, TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/usb/serial/ftdi_sio.c b/drivers/usb/serial/ftdi_sio.c
index 09bdf623e94e..002db8bc6a16 100644
--- a/drivers/usb/serial/ftdi_sio.c
+++ b/drivers/usb/serial/ftdi_sio.c
@@ -2366,12 +2366,12 @@ static int ftdi_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return usb_serial_generic_open(tty, port);
 }
 
-static void ftdi_dtr_rts(struct usb_serial_port *port, bool on)
+static void ftdi_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
 
 	/* Disable flow control */
-	if (!on) {
+	if (!active) {
 		if (usb_control_msg(port->serial->dev,
 			    usb_sndctrlpipe(port->serial->dev, 0),
 			    FTDI_SIO_SET_FLOW_CTRL_REQUEST,
@@ -2382,7 +2382,7 @@ static void ftdi_dtr_rts(struct usb_serial_port *port, bool on)
 		}
 	}
 	/* drop RTS and DTR */
-	if (on)
+	if (active)
 		set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	else
 		clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/usb/serial/ipw.c b/drivers/usb/serial/ipw.c
index b1b7a033cc75..1937e4dfe2d9 100644
--- a/drivers/usb/serial/ipw.c
+++ b/drivers/usb/serial/ipw.c
@@ -215,18 +215,18 @@ static void ipw_release(struct usb_serial *serial)
 	kfree(data);
 }
 
-static void ipw_dtr_rts(struct usb_serial_port *port, bool on)
+static void ipw_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct usb_device *udev = port->serial->dev;
 	struct device *dev = &port->dev;
 	int result;
 
-	dev_dbg(dev, "%s: on = %d\n", __func__, on);
+	dev_dbg(dev, "%s: active = %d\n", __func__, active);
 
 	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 			 IPW_SIO_SET_PIN,
 			 USB_TYPE_VENDOR | USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 on ? IPW_PIN_SETDTR : IPW_PIN_CLRDTR,
+			 active ? IPW_PIN_SETDTR : IPW_PIN_CLRDTR,
 			 0,
 			 NULL,
 			 0,
@@ -237,7 +237,7 @@ static void ipw_dtr_rts(struct usb_serial_port *port, bool on)
 	result = usb_control_msg(udev, usb_sndctrlpipe(udev, 0),
 			 IPW_SIO_SET_PIN, USB_TYPE_VENDOR |
 					USB_RECIP_INTERFACE | USB_DIR_OUT,
-			 on ? IPW_PIN_SETRTS : IPW_PIN_CLRRTS,
+			 active ? IPW_PIN_SETRTS : IPW_PIN_CLRRTS,
 			 0,
 			 NULL,
 			 0,
diff --git a/drivers/usb/serial/keyspan.c b/drivers/usb/serial/keyspan.c
index 7e375367354b..241d7179d421 100644
--- a/drivers/usb/serial/keyspan.c
+++ b/drivers/usb/serial/keyspan.c
@@ -1564,12 +1564,12 @@ static int keyspan_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return 0;
 }
 
-static void keyspan_dtr_rts(struct usb_serial_port *port, bool on)
+static void keyspan_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct keyspan_port_private *p_priv = usb_get_serial_port_data(port);
 
-	p_priv->rts_state = on;
-	p_priv->dtr_state = on;
+	p_priv->rts_state = active;
+	p_priv->dtr_state = active;
 	keyspan_send_setup(port, 0);
 }
 
diff --git a/drivers/usb/serial/keyspan_pda.c b/drivers/usb/serial/keyspan_pda.c
index cb16c4bc8555..4a2e66c771fb 100644
--- a/drivers/usb/serial/keyspan_pda.c
+++ b/drivers/usb/serial/keyspan_pda.c
@@ -551,11 +551,11 @@ static int keyspan_pda_write(struct tty_struct *tty, struct usb_serial_port *por
 	return count;
 }
 
-static void keyspan_pda_dtr_rts(struct usb_serial_port *port, bool on)
+static void keyspan_pda_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct usb_serial *serial = port->serial;
 
-	if (on)
+	if (active)
 		keyspan_pda_set_modem_info(serial, BIT(7) | BIT(2));
 	else
 		keyspan_pda_set_modem_info(serial, 0);
diff --git a/drivers/usb/serial/mct_u232.c b/drivers/usb/serial/mct_u232.c
index eb3520490dd2..d871b7cbc550 100644
--- a/drivers/usb/serial/mct_u232.c
+++ b/drivers/usb/serial/mct_u232.c
@@ -42,7 +42,7 @@ static int  mct_u232_port_probe(struct usb_serial_port *port);
 static void mct_u232_port_remove(struct usb_serial_port *remove);
 static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port);
 static void mct_u232_close(struct usb_serial_port *port);
-static void mct_u232_dtr_rts(struct usb_serial_port *port, bool on);
+static void mct_u232_dtr_rts(struct usb_serial_port *port, bool active);
 static void mct_u232_read_int_callback(struct urb *urb);
 static void mct_u232_set_termios(struct tty_struct *tty,
 				 struct usb_serial_port *port,
@@ -477,13 +477,13 @@ static int  mct_u232_open(struct tty_struct *tty, struct usb_serial_port *port)
 	return retval;
 } /* mct_u232_open */
 
-static void mct_u232_dtr_rts(struct usb_serial_port *port, bool on)
+static void mct_u232_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	unsigned int control_state;
 	struct mct_u232_private *priv = usb_get_serial_port_data(port);
 
 	spin_lock_irq(&priv->lock);
-	if (on)
+	if (active)
 		priv->control_state |= TIOCM_DTR | TIOCM_RTS;
 	else
 		priv->control_state &= ~(TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/usb/serial/mxuport.c b/drivers/usb/serial/mxuport.c
index ac7594635719..da7c40db64c8 100644
--- a/drivers/usb/serial/mxuport.c
+++ b/drivers/usb/serial/mxuport.c
@@ -674,7 +674,7 @@ static int mxuport_set_rts(struct usb_serial_port *port, u8 state)
 	return err;
 }
 
-static void mxuport_dtr_rts(struct usb_serial_port *port, bool on)
+static void mxuport_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct mxuport_port *mxport = usb_get_serial_port_data(port);
 	u8 mcr_state;
@@ -683,7 +683,7 @@ static void mxuport_dtr_rts(struct usb_serial_port *port, bool on)
 	mutex_lock(&mxport->mutex);
 	mcr_state = mxport->mcr_state;
 
-	if (on)
+	if (active)
 		mcr_state |= (UART_MCR_RTS | UART_MCR_DTR);
 	else
 		mcr_state &= ~(UART_MCR_RTS | UART_MCR_DTR);
diff --git a/drivers/usb/serial/pl2303.c b/drivers/usb/serial/pl2303.c
index cb20911f35bb..da23412e6a54 100644
--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -931,14 +931,14 @@ static void pl2303_set_termios(struct tty_struct *tty,
 	kfree(buf);
 }
 
-static void pl2303_dtr_rts(struct usb_serial_port *port, bool on)
+static void pl2303_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct pl2303_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
 	u8 control;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	if (on)
+	if (active)
 		priv->line_control |= (CONTROL_DTR | CONTROL_RTS);
 	else
 		priv->line_control &= ~(CONTROL_DTR | CONTROL_RTS);
diff --git a/drivers/usb/serial/quatech2.c b/drivers/usb/serial/quatech2.c
index 6fd329ffec7e..7e513c6106b5 100644
--- a/drivers/usb/serial/quatech2.c
+++ b/drivers/usb/serial/quatech2.c
@@ -770,19 +770,19 @@ static void qt2_break_ctl(struct tty_struct *tty, int break_state)
 
 
 
-static void qt2_dtr_rts(struct usb_serial_port *port, bool on)
+static void qt2_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct usb_device *dev = port->serial->dev;
 	struct qt2_port_private *port_priv = usb_get_serial_port_data(port);
 
 	/* Disable flow control */
-	if (!on) {
+	if (!active) {
 		if (qt2_setregister(dev, port_priv->device_port,
 					   UART_MCR, 0) < 0)
 			dev_warn(&port->dev, "error from flowcontrol urb\n");
 	}
 	/* drop RTS and DTR */
-	if (on)
+	if (active)
 		update_mctrl(port_priv, TIOCM_DTR | TIOCM_RTS, 0);
 	else
 		update_mctrl(port_priv, 0, TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/usb/serial/sierra.c b/drivers/usb/serial/sierra.c
index f2c3a7af1a4a..ed941acc49be 100644
--- a/drivers/usb/serial/sierra.c
+++ b/drivers/usb/serial/sierra.c
@@ -813,13 +813,13 @@ static int sierra_open(struct tty_struct *tty, struct usb_serial_port *port)
 }
 
 
-static void sierra_dtr_rts(struct usb_serial_port *port, bool on)
+static void sierra_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct sierra_port_private *portdata;
 
 	portdata = usb_get_serial_port_data(port);
-	portdata->rts_state = on;
-	portdata->dtr_state = on;
+	portdata->rts_state = active;
+	portdata->dtr_state = active;
 
 	sierra_send_setup(port);
 }
diff --git a/drivers/usb/serial/spcp8x5.c b/drivers/usb/serial/spcp8x5.c
index 02402ea3bd1b..52b4194bd31d 100644
--- a/drivers/usb/serial/spcp8x5.c
+++ b/drivers/usb/serial/spcp8x5.c
@@ -256,14 +256,14 @@ static bool spcp8x5_carrier_raised(struct usb_serial_port *port)
 	return ret || msr & MSR_STATUS_LINE_DCD;
 }
 
-static void spcp8x5_dtr_rts(struct usb_serial_port *port, bool on)
+static void spcp8x5_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct spcp8x5_private *priv = usb_get_serial_port_data(port);
 	unsigned long flags;
 	u8 control;
 
 	spin_lock_irqsave(&priv->lock, flags);
-	if (on)
+	if (active)
 		priv->line_control = MCR_CONTROL_LINE_DTR
 						| MCR_CONTROL_LINE_RTS;
 	else
diff --git a/drivers/usb/serial/ssu100.c b/drivers/usb/serial/ssu100.c
index 4cff39895804..dc85938c368b 100644
--- a/drivers/usb/serial/ssu100.c
+++ b/drivers/usb/serial/ssu100.c
@@ -385,17 +385,17 @@ static int ssu100_tiocmset(struct tty_struct *tty,
 	return update_mctrl(dev, set, clear);
 }
 
-static void ssu100_dtr_rts(struct usb_serial_port *port, bool on)
+static void ssu100_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct usb_device *dev = port->serial->dev;
 
 	/* Disable flow control */
-	if (!on) {
+	if (!active) {
 		if (ssu100_setregister(dev, 0, UART_MCR, 0) < 0)
 			dev_err(&port->dev, "error from flowcontrol urb\n");
 	}
 	/* drop RTS and DTR */
-	if (on)
+	if (active)
 		set_mctrl(dev, TIOCM_DTR | TIOCM_RTS);
 	else
 		clear_mctrl(dev, TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 206749fe3263..076667620a3f 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -262,13 +262,13 @@ static void upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 	mutex_unlock(&private->lock);
 }
 
-static void upd78f0730_dtr_rts(struct usb_serial_port *port, bool on)
+static void upd78f0730_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct tty_struct *tty = port->port.tty;
 	unsigned int set = 0;
 	unsigned int clear = 0;
 
-	if (on)
+	if (active)
 		set = TIOCM_DTR | TIOCM_RTS;
 	else
 		clear = TIOCM_DTR | TIOCM_RTS;
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f8404073558b..1ff9d6893026 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -765,13 +765,13 @@ static bool serial_port_carrier_raised(struct tty_port *port)
 	return true;
 }
 
-static void serial_port_dtr_rts(struct tty_port *port, bool on)
+static void serial_port_dtr_rts(struct tty_port *port, bool active)
 {
 	struct usb_serial_port *p = container_of(port, struct usb_serial_port, port);
 	struct usb_serial_driver *drv = p->serial->type;
 
 	if (drv->dtr_rts)
-		drv->dtr_rts(p, on);
+		drv->dtr_rts(p, active);
 }
 
 static ssize_t port_number_show(struct device *dev,
diff --git a/drivers/usb/serial/usb-wwan.h b/drivers/usb/serial/usb-wwan.h
index b2a07dd44225..3f558af789de 100644
--- a/drivers/usb/serial/usb-wwan.h
+++ b/drivers/usb/serial/usb-wwan.h
@@ -6,7 +6,7 @@
 #ifndef __LINUX_USB_USB_WWAN
 #define __LINUX_USB_USB_WWAN
 
-extern void usb_wwan_dtr_rts(struct usb_serial_port *port, bool on);
+extern void usb_wwan_dtr_rts(struct usb_serial_port *port, bool active);
 extern int usb_wwan_open(struct tty_struct *tty, struct usb_serial_port *port);
 extern void usb_wwan_close(struct usb_serial_port *port);
 extern int usb_wwan_port_probe(struct usb_serial_port *port);
diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwan.c
index 168b11cc02b6..78e7d597e2e3 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -69,7 +69,7 @@ static int usb_wwan_send_setup(struct usb_serial_port *port)
 	return res;
 }
 
-void usb_wwan_dtr_rts(struct usb_serial_port *port, bool on)
+void usb_wwan_dtr_rts(struct usb_serial_port *port, bool active)
 {
 	struct usb_wwan_port_private *portdata;
 	struct usb_wwan_intf_private *intfdata;
@@ -81,8 +81,8 @@ void usb_wwan_dtr_rts(struct usb_serial_port *port, bool on)
 
 	portdata = usb_get_serial_port_data(port);
 	/* FIXME: locking */
-	portdata->rts_state = on;
-	portdata->dtr_state = on;
+	portdata->rts_state = active;
+	portdata->dtr_state = active;
 
 	usb_wwan_send_setup(port);
 }
diff --git a/drivers/usb/serial/xr_serial.c b/drivers/usb/serial/xr_serial.c
index 9aaed09d45e4..b02e3eeec32f 100644
--- a/drivers/usb/serial/xr_serial.c
+++ b/drivers/usb/serial/xr_serial.c
@@ -495,9 +495,9 @@ static int xr_tiocmset(struct tty_struct *tty,
 	return xr_tiocmset_port(port, set, clear);
 }
 
-static void xr_dtr_rts(struct usb_serial_port *port, bool on)
+static void xr_dtr_rts(struct usb_serial_port *port, bool active)
 {
-	if (on)
+	if (active)
 		xr_tiocmset_port(port, TIOCM_DTR | TIOCM_RTS, 0);
 	else
 		xr_tiocmset_port(port, 0, TIOCM_DTR | TIOCM_RTS);
-- 
2.30.2

