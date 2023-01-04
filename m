Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC1965D71B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbjADPRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:17:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239594AbjADPQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:16:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27667F0B;
        Wed,  4 Jan 2023 07:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672845409; x=1704381409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZPHVabX/cSkxQW1KrADJmTufBu4DKd9OGYScWAnxr2o=;
  b=AImzo9x5VtgeIeFHJgqsrR5X+yaxq+FwKAbfzlu9jkC184rbKzTPj+e1
   wvsvYvGUtv5aFsJoKwc8JBICq0WzR+NGInJhEIlA2ZiD1nx/KSo08gnOx
   ItCgm6y+w5afHDCIM56QlMYGvhov0Iprs37fRdshICS9iawSxeohwx7ID
   7OQ2WjicVpI2vfpcKqu5GvvcIAZHwbVj9ogWJ+NnNrdlOOtjtpAocGa4+
   9N3LhvacdD/BEaZwRkMYOucc5+lDS8AL3vu6Lr3GmX40Nehl0vjo3e0Mv
   oHAOkDpQXkL3hGVQWbp10l4JyfttaRSWsGmsx8Za04tMPiHnwv9w+RXSL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301644537"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301644537"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:16:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762700918"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762700918"
Received: from msvoboda-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:16:21 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hovold <johan@kernel.org>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 08/10] tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool
Date:   Wed,  4 Jan 2023 17:15:29 +0200
Message-Id: <20230104151531.73994-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
References: <20230104151531.73994-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert status parameter for ->dcd_change() and
uart_handle_dcd_change() to bool which matches to how the parameter is
used.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pps/clients/pps-ldisc.c  | 2 +-
 drivers/tty/serial/serial_core.c | 4 ++--
 drivers/tty/serial/sunhv.c       | 8 ++++----
 drivers/usb/serial/generic.c     | 2 +-
 include/linux/serial_core.h      | 3 +--
 include/linux/tty_ldisc.h        | 4 ++--
 include/linux/usb/serial.h       | 2 +-
 7 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index d73c4c2ed4e1..67aee758ac1d 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -13,7 +13,7 @@
 #include <linux/pps_kernel.h>
 #include <linux/bug.h>
 
-static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
+static void pps_tty_dcd_change(struct tty_struct *tty, bool status)
 {
 	struct pps_device *pps;
 	struct pps_event_time ts;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 07b4af10a7e9..76536c74e907 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3250,11 +3250,11 @@ EXPORT_SYMBOL(uart_match_port);
 /**
  * uart_handle_dcd_change - handle a change of carrier detect state
  * @uport: uart_port structure for the open port
- * @status: new carrier detect status, nonzero if active
+ * @status: new carrier detect status, true if active
  *
  * Caller must hold uport->lock.
  */
-void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
+void uart_handle_dcd_change(struct uart_port *uport, bool status)
 {
 	struct tty_port *port = &uport->state->port;
 	struct tty_struct *tty = port->tty;
diff --git a/drivers/tty/serial/sunhv.c b/drivers/tty/serial/sunhv.c
index 16c746a63258..7d38c33ef506 100644
--- a/drivers/tty/serial/sunhv.c
+++ b/drivers/tty/serial/sunhv.c
@@ -87,10 +87,10 @@ static int receive_chars_getchar(struct uart_port *port)
 
 		if (c == CON_HUP) {
 			hung_up = 1;
-			uart_handle_dcd_change(port, 0);
+			uart_handle_dcd_change(port, false);
 		} else if (hung_up) {
 			hung_up = 0;
-			uart_handle_dcd_change(port, 1);
+			uart_handle_dcd_change(port, true);
 		}
 
 		if (port->state == NULL) {
@@ -133,7 +133,7 @@ static int receive_chars_read(struct uart_port *port)
 				bytes_read = 1;
 			} else if (stat == CON_HUP) {
 				hung_up = 1;
-				uart_handle_dcd_change(port, 0);
+				uart_handle_dcd_change(port, false);
 				continue;
 			} else {
 				/* HV_EWOULDBLOCK, etc.  */
@@ -143,7 +143,7 @@ static int receive_chars_read(struct uart_port *port)
 
 		if (hung_up) {
 			hung_up = 0;
-			uart_handle_dcd_change(port, 1);
+			uart_handle_dcd_change(port, true);
 		}
 
 		if (port->sysrq != 0 &&  *con_read_page) {
diff --git a/drivers/usb/serial/generic.c b/drivers/usb/serial/generic.c
index 15b6dee3a8e5..50016ee1026a 100644
--- a/drivers/usb/serial/generic.c
+++ b/drivers/usb/serial/generic.c
@@ -608,7 +608,7 @@ EXPORT_SYMBOL_GPL(usb_serial_handle_break);
  * @status: new carrier detect status, nonzero if active
  */
 void usb_serial_handle_dcd_change(struct usb_serial_port *port,
-				struct tty_struct *tty, unsigned int status)
+				struct tty_struct *tty, bool status)
 {
 	dev_dbg(&port->dev, "%s - status %d\n", __func__, status);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index fd59f600094a..f1b69a36bb2b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -896,8 +896,7 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
  * The following are helper functions for the low level drivers.
  */
 
-extern void uart_handle_dcd_change(struct uart_port *uport,
-		unsigned int status);
+extern void uart_handle_dcd_change(struct uart_port *uport, bool status);
 extern void uart_handle_cts_change(struct uart_port *uport,
 		unsigned int status);
 
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index dcb61ec11424..8f4a684973c9 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -170,7 +170,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	send, please arise a tasklet or workqueue to do the real data transfer.
  *	Do not send data in this hook, it may lead to a deadlock.
  *
- * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, unsigned int status)``
+ * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, bool status)``
  *
  *	Tells the discipline that the DCD pin has changed its status. Used
  *	exclusively by the %N_PPS (Pulse-Per-Second) line discipline.
@@ -238,7 +238,7 @@ struct tty_ldisc_ops {
 	void	(*receive_buf)(struct tty_struct *tty, const unsigned char *cp,
 			       const char *fp, int count);
 	void	(*write_wakeup)(struct tty_struct *tty);
-	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
+	void	(*dcd_change)(struct tty_struct *tty, bool status);
 	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
 				const char *fp, int count);
 	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
diff --git a/include/linux/usb/serial.h b/include/linux/usb/serial.h
index c597357853d9..6fa608cb4d98 100644
--- a/include/linux/usb/serial.h
+++ b/include/linux/usb/serial.h
@@ -372,7 +372,7 @@ static inline int usb_serial_handle_break(struct usb_serial_port *port)
 #endif
 
 void usb_serial_handle_dcd_change(struct usb_serial_port *usb_port,
-		struct tty_struct *tty, unsigned int status);
+				  struct tty_struct *tty, bool status);
 
 
 int usb_serial_bus_register(struct usb_serial_driver *device);
-- 
2.30.2

