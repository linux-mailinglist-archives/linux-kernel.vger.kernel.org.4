Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4FF86B1DE2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjCIIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:24:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbjCIIWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:22:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FBFD3B65B;
        Thu,  9 Mar 2023 00:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678350118; x=1709886118;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CxxEqgd3/ySziCnHqMBtXGYZorO4KpYH46SmZHK5Ytg=;
  b=SR+neSPxmTmcldf2ThYLSPFPw30FJh/D5TQPNMb0PjGc5/SsTS8YkdyL
   oUqsxCEDaePUhwbaMlGHhDwlSE4MHQ++/P4Hb3ZxXRnbJqb2Va+HMEQk4
   baQ3XGupiuqDjtjftZtWmYxUAOAoaIh2JnGwK6LSE7tzaPY+lW6Oa5Dzs
   35eA7bm7AUyevc/ML5Qhf7D067RPqccvapY6HzFc2HXJF6iz6CV3V/DF1
   WMFolMbtC9FfkAz0V+lFDESP6wTxr/RxORS/ZYNHJxqCmyxi14X+qOYjB
   d467aAH1vVBu969umphcjacczj+pCIl1lpi9PbYQey4T1fblYk21/hYe7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="364025957"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="364025957"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="787473901"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="787473901"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:21:15 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 8/8] tty: Convert hw_stopped in tty_struct to bool
Date:   Thu,  9 Mar 2023 10:20:35 +0200
Message-Id: <20230309082035.14880-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
References: <20230309082035.14880-1-ilpo.jarvinen@linux.intel.com>
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

hw_stopped in tty_struct is used like bool, convert the variable type
to bool.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/char/pcmcia/synclink_cs.c |  6 +++---
 drivers/mmc/core/sdio_uart.c      | 10 +++++-----
 drivers/tty/amiserial.c           |  6 +++---
 drivers/tty/mxser.c               |  6 +++---
 drivers/tty/synclink_gt.c         |  6 +++---
 include/linux/tty.h               |  2 +-
 6 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
index 6ddfeb2fe98f..97c5bfb9d58a 100644
--- a/drivers/char/pcmcia/synclink_cs.c
+++ b/drivers/char/pcmcia/synclink_cs.c
@@ -1060,7 +1060,7 @@ static void cts_change(MGSLPC_INFO *info, struct tty_struct *tty)
 			if (info->serial_signals & SerialSignal_CTS) {
 				if (debug_level >= DEBUG_LEVEL_ISR)
 					printk("CTS tx start...");
-				tty->hw_stopped = 0;
+				tty->hw_stopped = false;
 				tx_start(info, tty);
 				info->pending_bh |= BH_TRANSMIT;
 				return;
@@ -1069,7 +1069,7 @@ static void cts_change(MGSLPC_INFO *info, struct tty_struct *tty)
 			if (!(info->serial_signals & SerialSignal_CTS)) {
 				if (debug_level >= DEBUG_LEVEL_ISR)
 					printk("CTS tx stop...");
-				tty->hw_stopped = 1;
+				tty->hw_stopped = true;
 				tx_stop(info);
 			}
 		}
@@ -2312,7 +2312,7 @@ static void mgslpc_set_termios(struct tty_struct *tty,
 
 	/* Handle turning off CRTSCTS */
 	if (old_termios->c_cflag & CRTSCTS && !C_CRTSCTS(tty)) {
-		tty->hw_stopped = 0;
+		tty->hw_stopped = false;
 		tx_release(tty);
 	}
 }
diff --git a/drivers/mmc/core/sdio_uart.c b/drivers/mmc/core/sdio_uart.c
index 50536fe59f1a..aa659758563f 100644
--- a/drivers/mmc/core/sdio_uart.c
+++ b/drivers/mmc/core/sdio_uart.c
@@ -478,13 +478,13 @@ static void sdio_uart_check_modem_status(struct sdio_uart_port *port)
 			int cts = (status & UART_MSR_CTS);
 			if (tty->hw_stopped) {
 				if (cts) {
-					tty->hw_stopped = 0;
+					tty->hw_stopped = false;
 					sdio_uart_start_tx(port);
 					tty_wakeup(tty);
 				}
 			} else {
 				if (!cts) {
-					tty->hw_stopped = 1;
+					tty->hw_stopped = true;
 					sdio_uart_stop_tx(port);
 				}
 			}
@@ -633,7 +633,7 @@ static int sdio_uart_activate(struct tty_port *tport, struct tty_struct *tty)
 
 	if (C_CRTSCTS(tty))
 		if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS))
-			tty->hw_stopped = 1;
+			tty->hw_stopped = true;
 
 	clear_bit(TTY_IO_ERROR, &tty->flags);
 
@@ -882,14 +882,14 @@ static void sdio_uart_set_termios(struct tty_struct *tty,
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
-		tty->hw_stopped = 0;
+		tty->hw_stopped = false;
 		sdio_uart_start_tx(port);
 	}
 
 	/* Handle turning on CRTSCTS */
 	if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
 		if (!(sdio_uart_get_mctrl(port) & TIOCM_CTS)) {
-			tty->hw_stopped = 1;
+			tty->hw_stopped = true;
 			sdio_uart_stop_tx(port);
 		}
 	}
diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index d7515d61659e..c06ad0a0744b 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -347,7 +347,7 @@ static void check_modem_status(struct serial_state *info)
 #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
 				printk("CTS tx start...");
 #endif
-				port->tty->hw_stopped = 0;
+				port->tty->hw_stopped = false;
 				info->IER |= UART_IER_THRI;
 				amiga_custom.intena = IF_SETCLR | IF_TBE;
 				mb();
@@ -362,7 +362,7 @@ static void check_modem_status(struct serial_state *info)
 #if (defined(SERIAL_DEBUG_INTR) || defined(SERIAL_DEBUG_FLOW))
 				printk("CTS tx stop...");
 #endif
-				port->tty->hw_stopped = 1;
+				port->tty->hw_stopped = true;
 				info->IER &= ~UART_IER_THRI;
 				/* disable Tx interrupt and remove any pending interrupts */
 				amiga_custom.intena = IF_TBE;
@@ -1197,7 +1197,7 @@ static void rs_set_termios(struct tty_struct *tty, const struct ktermios *old_te
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
-		tty->hw_stopped = 0;
+		tty->hw_stopped = false;
 		rs_start(tty);
 	}
 
diff --git a/drivers/tty/mxser.c b/drivers/tty/mxser.c
index ef3116e87975..10855e66fda1 100644
--- a/drivers/tty/mxser.c
+++ b/drivers/tty/mxser.c
@@ -553,7 +553,7 @@ static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
 
 	if (tty->hw_stopped) {
 		if (cts) {
-			tty->hw_stopped = 0;
+			tty->hw_stopped = false;
 
 			if (!mxser_16550A_or_MUST(info))
 				__mxser_start_tx(info);
@@ -563,7 +563,7 @@ static void mxser_handle_cts(struct tty_struct *tty, struct mxser_port *info,
 	} else if (cts)
 		return;
 
-	tty->hw_stopped = 1;
+	tty->hw_stopped = true;
 	if (!mxser_16550A_or_MUST(info))
 		__mxser_stop_tx(info);
 }
@@ -1361,7 +1361,7 @@ static void mxser_set_termios(struct tty_struct *tty,
 	spin_unlock_irqrestore(&info->slock, flags);
 
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
-		tty->hw_stopped = 0;
+		tty->hw_stopped = false;
 		mxser_start(tty);
 	}
 
diff --git a/drivers/tty/synclink_gt.c b/drivers/tty/synclink_gt.c
index 33f258d6fef9..543b3224dce9 100644
--- a/drivers/tty/synclink_gt.c
+++ b/drivers/tty/synclink_gt.c
@@ -730,7 +730,7 @@ static void set_termios(struct tty_struct *tty,
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !C_CRTSCTS(tty)) {
-		tty->hw_stopped = 0;
+		tty->hw_stopped = false;
 		tx_release(tty);
 	}
 }
@@ -1953,13 +1953,13 @@ static void cts_change(struct slgt_info *info, unsigned short status)
 		if (info->port.tty) {
 			if (info->port.tty->hw_stopped) {
 				if (info->signals & SerialSignal_CTS) {
-		 			info->port.tty->hw_stopped = 0;
+					info->port.tty->hw_stopped = false;
 					info->pending_bh |= BH_TRANSMIT;
 					return;
 				}
 			} else {
 				if (!(info->signals & SerialSignal_CTS))
-		 			info->port.tty->hw_stopped = 1;
+					info->port.tty->hw_stopped = true;
 			}
 		}
 	}
diff --git a/include/linux/tty.h b/include/linux/tty.h
index 093935e97f42..60871a9d3212 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -227,7 +227,7 @@ struct tty_struct {
 		unsigned long unused[0];
 	} __aligned(sizeof(unsigned long)) ctrl;
 
-	int hw_stopped;
+	bool hw_stopped;
 	unsigned int receive_room;
 	int flow_change;
 
-- 
2.30.2

