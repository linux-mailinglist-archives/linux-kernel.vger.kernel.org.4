Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF2316B1D85
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbjCIILX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjCIIKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:10:30 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9E1DBB51;
        Thu,  9 Mar 2023 00:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349398; x=1709885398;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rJCyEkJNEsA+/cTIkJbgh5VawdlmNIWJoyG5MajweuI=;
  b=jS2+KEVRPPNOvVH1UuZZYGJ8KgPRDfFou3pvph8XEdMXCVVrwjUXOfyR
   URhwMjLZWttcxuJdMH5/DrnfRvxXbKAXHwb4rdv1E4MWCxNW85WyHPJF1
   r6VHdQzyN9nerOtTlP+Y71Us8CeJLtHdl7hGZbK0gIXhY68nUoE0m253S
   Kz59a0u5uE34uHNhoC2q49Ie2p825WRCbyOjbXPlKS2f1OvuzHx6voJX3
   c9dcpsgPeE7bLq+/a0EkBVLpM3dO5d4JoTCc/ry3PZwAtyVd2l8td0W2o
   g3h0NcL2Y7ZfBgng/HNMenBmsq52H0r5BL2YSmduS8koNVwBJpoNApdkw
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333853588"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="333853588"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746227986"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746227986"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:42 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 4/8] serial: Move uart_change_speed() earlier
Date:   Thu,  9 Mar 2023 10:09:19 +0200
Message-Id: <20230309080923.11778-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
References: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
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

Move uart_change_speed() earlier to get rid of its forward declaration.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/serial_core.c | 94 ++++++++++++++++----------------
 1 file changed, 46 insertions(+), 48 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 296d2c33ea7a..7201bbc44fa7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -49,8 +49,6 @@ static struct lock_class_key port_lock_key;
  */
 #define RS485_MAX_RTS_DELAY	100 /* msecs */
 
-static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
-			      const struct ktermios *old_termios);
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout);
 static void uart_change_pm(struct uart_state *state,
 			   enum uart_pm_state pm_state);
@@ -178,6 +176,52 @@ static void uart_port_dtr_rts(struct uart_port *uport, bool active)
 		uart_clear_mctrl(uport, TIOCM_DTR | TIOCM_RTS);
 }
 
+/* Caller holds port mutex */
+static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
+			      const struct ktermios *old_termios)
+{
+	struct uart_port *uport = uart_port_check(state);
+	struct ktermios *termios;
+	int hw_stopped;
+
+	/*
+	 * If we have no tty, termios, or the port does not exist,
+	 * then we can't set the parameters for this port.
+	 */
+	if (!tty || uport->type == PORT_UNKNOWN)
+		return;
+
+	termios = &tty->termios;
+	uport->ops->set_termios(uport, termios, old_termios);
+
+	/*
+	 * Set modem status enables based on termios cflag
+	 */
+	spin_lock_irq(&uport->lock);
+	if (termios->c_cflag & CRTSCTS)
+		uport->status |= UPSTAT_CTS_ENABLE;
+	else
+		uport->status &= ~UPSTAT_CTS_ENABLE;
+
+	if (termios->c_cflag & CLOCAL)
+		uport->status &= ~UPSTAT_DCD_ENABLE;
+	else
+		uport->status |= UPSTAT_DCD_ENABLE;
+
+	/* reset sw-assisted CTS flow control based on (possibly) new mode */
+	hw_stopped = uport->hw_stopped;
+	uport->hw_stopped = uart_softcts_mode(uport) &&
+			    !(uport->ops->get_mctrl(uport) & TIOCM_CTS);
+	if (uport->hw_stopped) {
+		if (!hw_stopped)
+			uport->ops->stop_tx(uport);
+	} else {
+		if (hw_stopped)
+			__uart_start(tty);
+	}
+	spin_unlock_irq(&uport->lock);
+}
+
 /*
  * Startup the port.  This will be called once per open.  All calls
  * will be serialised by the per-port mutex.
@@ -486,52 +530,6 @@ uart_get_divisor(struct uart_port *port, unsigned int baud)
 }
 EXPORT_SYMBOL(uart_get_divisor);
 
-/* Caller holds port mutex */
-static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
-			      const struct ktermios *old_termios)
-{
-	struct uart_port *uport = uart_port_check(state);
-	struct ktermios *termios;
-	int hw_stopped;
-
-	/*
-	 * If we have no tty, termios, or the port does not exist,
-	 * then we can't set the parameters for this port.
-	 */
-	if (!tty || uport->type == PORT_UNKNOWN)
-		return;
-
-	termios = &tty->termios;
-	uport->ops->set_termios(uport, termios, old_termios);
-
-	/*
-	 * Set modem status enables based on termios cflag
-	 */
-	spin_lock_irq(&uport->lock);
-	if (termios->c_cflag & CRTSCTS)
-		uport->status |= UPSTAT_CTS_ENABLE;
-	else
-		uport->status &= ~UPSTAT_CTS_ENABLE;
-
-	if (termios->c_cflag & CLOCAL)
-		uport->status &= ~UPSTAT_DCD_ENABLE;
-	else
-		uport->status |= UPSTAT_DCD_ENABLE;
-
-	/* reset sw-assisted CTS flow control based on (possibly) new mode */
-	hw_stopped = uport->hw_stopped;
-	uport->hw_stopped = uart_softcts_mode(uport) &&
-				!(uport->ops->get_mctrl(uport) & TIOCM_CTS);
-	if (uport->hw_stopped) {
-		if (!hw_stopped)
-			uport->ops->stop_tx(uport);
-	} else {
-		if (hw_stopped)
-			__uart_start(tty);
-	}
-	spin_unlock_irq(&uport->lock);
-}
-
 static int uart_put_char(struct tty_struct *tty, unsigned char c)
 {
 	struct uart_state *state = tty->driver_data;
-- 
2.30.2

