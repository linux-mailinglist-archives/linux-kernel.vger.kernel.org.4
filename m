Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B6C663FDD
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbjAJMGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbjAJMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:05:34 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3B56D526;
        Tue, 10 Jan 2023 04:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673352243; x=1704888243;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mQMK7+4N/va/WUn7WFZNose1CWMA2tUcL+tOgTEHCok=;
  b=faZfVH22HGuWFccICA4I9Af+nYTlmB0OHETQjlNCshoSDOnzF2c/0CAg
   PTThnWw+7zoniTUV3GPXOBt4jGFAoumm6gEcqQDSgdfJN5eYazOrBfP/5
   FX9FeSMDHyGDzyzpcwK2N8XXCFdMb2zbnOwwGjrtOHgsh+qZjz9gTUDhE
   +8G6/K9VkZGtwlaQpqBJJ+qbpom/Y9IjPwYpHfzHNFgoJXKxHJer6rEg0
   DCKCTj8SxmxaQSUJo56ElVi4f7Es3QcNbX6Aiux1hNKXeXeJPMqExHGfn
   Mf39sLFzchLaBbc9EGEjg+KY+B+GcFHEVnCdOd3XBxar/IKn8K6bxOb/j
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350350276"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350350276"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:59 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="799407043"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799407043"
Received: from gbocanex-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.115])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:53 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        David Lin <dtwlin@gmail.com>, Alex Elder <elder@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 11/13] tty/serial: Call ->dtr_rts() parameter active consistently
Date:   Tue, 10 Jan 2023 14:02:24 +0200
Message-Id: <20230110120226.14972-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
References: <20230110120226.14972-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert various parameter names for ->dtr_rts() and related functions
from onoff, on, and raise to active.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/char/pcmcia/synclink_cs.c | 6 +++---
 drivers/mmc/core/sdio_uart.c      | 6 +++---
 drivers/staging/greybus/uart.c    | 4 ++--
 drivers/tty/amiserial.c           | 4 ++--
 drivers/tty/hvc/hvc_console.h     | 2 +-
 drivers/tty/hvc/hvc_iucv.c        | 6 +++---
 drivers/tty/mxser.c               | 4 ++--
 drivers/tty/n_gsm.c               | 4 ++--
 drivers/tty/serial/serial_core.c  | 8 ++++----
 drivers/tty/synclink_gt.c         | 4 ++--
 include/linux/tty_port.h          | 4 ++--
 include/linux/usb/serial.h        | 2 +-
 12 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 46a0b586d234..1577eba6fe0e 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -378,7 +378,7 @@ static void async_mode(MGSLPC_INFO *info);
 static void tx_timeout(struct timer_list *t);
 
 static bool carrier_raised(struct tty_port *port);
-static void dtr_rts(struct tty_port *port, bool onoff);
+static void dtr_rts(struct tty_port *port, bool active);
 
 #if SYNCLINK_GENERIC_HDLC
 #define dev_to_port(D) (dev_to_hdlc(D)->priv)
@@ -2442,13 +2442,13 @@ static bool carrier_raised(struct tty_port *port)
 	return info->serial_signals & SerialSignal_DCD;
 }
 
-static void dtr_rts(struct tty_port *port, bool onoff)
+static void dtr_rts(struct tty_port *port, bool active)
 {
 	MGSLPC_INFO *info = container_of(port, MGSLPC_INFO, port);
 	unsigned long flags;
 
 	spin_lock_irqsave(&info->lock, flags);
-	if (onoff)
+	if (active)
 		info->serial_signals |= SerialSignal_RTS | SerialSignal_DTR;
 	else
 		info->serial_signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index c6b4b2b2a4b2..50536fe59f1a 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -542,20 +542,20 @@ static bool uart_carrier_raised(struct tty_port *tport)
 /**
  *	uart_dtr_rts		-	 port helper to set uart signals
  *	@tport: tty port to be updated
- *	@onoff: set to turn on DTR/RTS
+ *	@active: set to turn on DTR/RTS
  *
  *	Called by the tty port helpers when the modem signals need to be
  *	adjusted during an open, close and hangup.
  */
 
-static void uart_dtr_rts(struct tty_port *tport, bool onoff)
+static void uart_dtr_rts(struct tty_port *tport, bool active)
 {
 	struct sdio_uart_port *port =
 			container_of(tport, struct sdio_uart_port, port);
 	int ret = sdio_uart_claim_func(port);
 	if (ret)
 		return;
-	if (!onoff)
+	if (!active)
 		sdio_uart_clear_mctrl(port, TIOCM_DTR | TIOCM_RTS);
 	else
 		sdio_uart_set_mctrl(port, TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/staging/greybus/uart.c b/drivers/staging/greybus/uart.c
index 92d49740d5a4..20a34599859f 100644
--- a/drivers/staging/greybus/uart.c
+++ b/drivers/staging/greybus/uart.c
@@ -701,7 +701,7 @@ static int gb_tty_ioctl(struct tty_struct *tty, unsigned int cmd,
 	return -ENOIOCTLCMD;
 }
 
-static void gb_tty_dtr_rts(struct tty_port *port, bool on)
+static void gb_tty_dtr_rts(struct tty_port *port, bool active)
 {
 	struct gb_tty *gb_tty;
 	u8 newctrl;
@@ -709,7 +709,7 @@ static void gb_tty_dtr_rts(struct tty_port *port, bool on)
 	gb_tty = container_of(port, struct gb_tty, port);
 	newctrl = gb_tty->ctrlout;
 
-	if (on)
+	if (active)
 		newctrl |= (GB_UART_CTRL_DTR | GB_UART_CTRL_RTS);
 	else
 		newctrl &= ~(GB_UART_CTRL_DTR | GB_UART_CTRL_RTS);
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 29d4c554f6b8..d7515d61659e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -1459,13 +1459,13 @@ static bool amiga_carrier_raised(struct tty_port *port)
 	return !(ciab.pra & SER_DCD);
 }
 
-static void amiga_dtr_rts(struct tty_port *port, bool raise)
+static void amiga_dtr_rts(struct tty_port *port, bool active)
 {
 	struct serial_state *info = container_of(port, struct serial_state,
 			tport);
 	unsigned long flags;
 
-	if (raise)
+	if (active)
 		info->MCR |= SER_DTR|SER_RTS;
 	else
 		info->MCR &= ~(SER_DTR|SER_RTS);
diff --git a/drivers/tty/hvc/hvc_console.h b/drivers/tty/hvc/hvc_console.h
index 6d3428bf868f..9668f821db01 100644
--- a/drivers/tty/hvc/hvc_console.h
+++ b/drivers/tty/hvc/hvc_console.h
@@ -66,7 +66,7 @@ struct hv_ops {
 	int (*tiocmset)(struct hvc_struct *hp, unsigned int set, unsigned int clear);
 
 	/* Callbacks to handle tty ports */
-	void (*dtr_rts)(struct hvc_struct *hp, bool raise);
+	void (*dtr_rts)(struct hvc_struct *hp, bool active);
 };
 
 /* Register a vterm and a slot index for use as a console (console_init) */
diff --git a/drivers/tty/hvc/hvc_iucv.c b/drivers/tty/hvc/hvc_iucv.c
index fe862a6882d6..543f35ddf523 100644
--- a/drivers/tty/hvc/hvc_iucv.c
+++ b/drivers/tty/hvc/hvc_iucv.c
@@ -658,13 +658,13 @@ static void hvc_iucv_notifier_hangup(struct hvc_struct *hp, int id)
 /**
  * hvc_iucv_dtr_rts() - HVC notifier for handling DTR/RTS
  * @hp:		Pointer the HVC device (struct hvc_struct)
- * @raise:	True to raise or false to lower DTR/RTS lines
+ * @active:	True to raise or false to lower DTR/RTS lines
  *
  * This routine notifies the HVC back-end to raise or lower DTR/RTS
  * lines.  Raising DTR/RTS is ignored.  Lowering DTR/RTS indicates to
  * drop the IUCV connection (similar to hang up the modem).
  */
-static void hvc_iucv_dtr_rts(struct hvc_struct *hp, bool raise)
+static void hvc_iucv_dtr_rts(struct hvc_struct *hp, bool active)
 {
 	struct hvc_iucv_private *priv;
 	struct iucv_path        *path;
@@ -672,7 +672,7 @@ static void hvc_iucv_dtr_rts(struct hvc_struct *hp, bool raise)
 	/* Raising the DTR/RTS is ignored as IUCV connections can be
 	 * established at any times.
 	 */
-	if (raise)
+	if (active)
 		return;
 
 	priv = hvc_iucv_get_private(hp->vtermno);
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index d4fb11e39bb1..ef3116e87975 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -465,7 +465,7 @@ static bool mxser_carrier_raised(struct tty_port *port)
 	return inb(mp->ioaddr + UART_MSR) & UART_MSR_DCD;
 }
 
-static void mxser_dtr_rts(struct tty_port *port, bool on)
+static void mxser_dtr_rts(struct tty_port *port, bool active)
 {
 	struct mxser_port *mp = container_of(port, struct mxser_port, port);
 	unsigned long flags;
@@ -473,7 +473,7 @@ static void mxser_dtr_rts(struct tty_port *port, bool on)
 
 	spin_lock_irqsave(&mp->slock, flags);
 	mcr = inb(mp->ioaddr + UART_MCR);
-	if (on)
+	if (active)
 		mcr |= UART_MCR_DTR | UART_MCR_RTS;
 	else
 		mcr &= ~(UART_MCR_DTR | UART_MCR_RTS);
diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 8dd0d6441c42..4f29b00f2645 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -3792,11 +3792,11 @@ static bool gsm_carrier_raised(struct tty_port *port)
 	return dlci->modem_rx & TIOCM_CD;
 }
 
-static void gsm_dtr_rts(struct tty_port *port, bool onoff)
+static void gsm_dtr_rts(struct tty_port *port, bool active)
 {
 	struct gsm_dlci *dlci = container_of(port, struct gsm_dlci, port);
 	unsigned int modem_tx = dlci->modem_tx;
-	if (onoff)
+	if (active)
 		modem_tx |= TIOCM_DTR | TIOCM_RTS;
 	else
 		modem_tx &= ~(TIOCM_DTR | TIOCM_RTS);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index b8fff667d4f0..da4e4e8a2b50 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -169,9 +169,9 @@ uart_update_mctrl(struct uart_port *port, unsigned int set, unsigned int clear)
 #define uart_set_mctrl(port, set)	uart_update_mctrl(port, set, 0)
 #define uart_clear_mctrl(port, clear)	uart_update_mctrl(port, 0, clear)
 
-static void uart_port_dtr_rts(struct uart_port *uport, bool raise)
+static void uart_port_dtr_rts(struct uart_port *uport, bool active)
 {
-	if (raise)
+	if (active)
 		uart_set_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 	else
 		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
@@ -1885,7 +1885,7 @@ static bool uart_carrier_raised(struct tty_port *port)
 	return mctrl & TIOCM_CAR;
 }
 
-static void uart_dtr_rts(struct tty_port *port, bool raise)
+static void uart_dtr_rts(struct tty_port *port, bool active)
 {
 	struct uart_state *state = container_of(port, struct uart_state, port);
 	struct uart_port *uport;
@@ -1893,7 +1893,7 @@ static void uart_dtr_rts(struct tty_port *port, bool raise)
 	uport = uart_port_ref(state);
 	if (!uport)
 		return;
-	uart_port_dtr_rts(uport, raise);
+	uart_port_dtr_rts(uport, active);
 	uart_port_deref(uport);
 }
 
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 2b786265ce7b..33f258d6fef9 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -3138,13 +3138,13 @@ static bool carrier_raised(struct tty_port *port)
 	return info->signals & SerialSignal_DCD;
 }
 
-static void dtr_rts(struct tty_port *port, bool on)
+static void dtr_rts(struct tty_port *port, bool active)
 {
 	unsigned long flags;
 	struct slgt_info *info = container_of(port, struct slgt_info, port);
 
 	spin_lock_irqsave(&info->lock,flags);
-	if (on)
+	if (active)
 		info->signals |= SerialSignal_RTS | SerialSignal_DTR;
 	else
 		info->signals &= ~(SerialSignal_RTS | SerialSignal_DTR);
diff --git a/include/linux/tty_port.h b/include/linux/tty_port.h
index c44e489de0ff..edf685a24f7c 100644
--- a/include/linux/tty_port.h
+++ b/include/linux/tty_port.h
@@ -16,7 +16,7 @@ struct tty_struct;
 /**
  * struct tty_port_operations -- operations on tty_port
  * @carrier_raised: return true if the carrier is raised on @port
- * @dtr_rts: raise the DTR line if @raise is true, otherwise lower DTR
+ * @dtr_rts: raise the DTR line if @active is true, otherwise lower DTR
  * @shutdown: called when the last close completes or a hangup finishes IFF the
  *	port was initialized. Do not use to free resources. Turn off the device
  *	only. Called under the port mutex to serialize against @activate and
@@ -32,7 +32,7 @@ struct tty_struct;
  */
 struct tty_port_operations {
 	bool (*carrier_raised)(struct tty_port *port);
-	void (*dtr_rts)(struct tty_port *port, bool raise);
+	void (*dtr_rts)(struct tty_port *port, bool active);
 	void (*shutdown)(struct tty_port *port);
 	int (*activate)(struct tty_port *port, struct tty_struct *tty);
 	void (*destruct)(struct tty_port *port);
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index bad343c5e8a7..33afd9f3ebbe 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -292,7 +292,7 @@ struct usb_serial_driver {
 			struct serial_icounter_struct *icount);
 	/* Called by the tty layer for port level work. There may or may not
 	   be an attached tty at this point */
-	void (*dtr_rts)(struct usb_serial_port *port, bool on);
+	void (*dtr_rts)(struct usb_serial_port *port, bool active);
 	bool (*carrier_raised)(struct usb_serial_port *port);
 	/* Called by the usb serial hooks to allow the user to rework the
 	   termios state */
-- 
2.30.2

