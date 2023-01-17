Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58DAE66D992
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236487AbjAQJOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236623AbjAQJOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:14:00 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C612E30EA3;
        Tue, 17 Jan 2023 01:06:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673946407; x=1705482407;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=DqGwj4mZtH/ajwoE/03bzZWvrwSPcsHx4SSVX7QXSb8=;
  b=eoCqVJ5JabHUXiDSkx7cKmtygja/Xb+O9YUt//b6fdTHJRTZbMwMkiBH
   J6TfvAKDHuVPKt/m3/kJuVbdYtBf4tI+qekH+wSoZzLTHZe4lqfF/A59I
   VAYI7G78wT4v8MPxUooVJw+m9rzPV29mYjp/G6UGc91ZWczvhqj1dR9KM
   H9PCY9krfRElhY0Jl/P45MKVnaDEELT/C0dxu5zPCGE4rTEpvPaFglfAQ
   F36f9X0BEUgp9ulH+H9AT+QPK8aVzK6hzqkkJFQQVqm97MA0vjT6m6n9q
   LFR19w4iTGexUsWAhlNfJM+yZGv1CypADulfTNd0UAKWZzMgrMk3vxcpq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324701185"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324701185"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:05:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783174335"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783174335"
Received: from tronach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.40.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:05:30 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Arnd Bergmann <arnd@arndb.de>, David Lin <dtwlin@gmail.com>,
        Alex Elder <elder@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, greybus-dev@lists.linaro.org,
        linux-staging@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 11/12] tty: Call ->dtr_rts() parameter active consistently
Date:   Tue, 17 Jan 2023 11:03:57 +0200
Message-Id: <20230117090358.4796-12-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
References: <20230117090358.4796-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert various parameter names for ->dtr_rts() and related functions
from onoff, on, and raise to active.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For MMC
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
 drivers/usb/class/cdc-acm.c       | 4 ++--
 include/linux/tty_port.h          | 4 ++--
 12 files changed, 28 insertions(+), 28 deletions(-)

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
-- 
2.30.2

