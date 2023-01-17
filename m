Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC0F66D97F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 10:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbjAQJO1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 04:14:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbjAQJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 04:13:13 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7295305CB;
        Tue, 17 Jan 2023 01:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673946383; x=1705482383;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c7jjkXg2zevtUfDVCklxzCATy4MDGgUxteLanbQzGXo=;
  b=HTwBSnj4sN8XgZ2kN8kcPJ8PNuJi4DAkgmXdntZqWwf10Pj8CzGX1xrB
   zla7MQZCZh+WqFyxTC0URDp0+dEQaF5SHMwCOWDwDabv+MJIfEouKZzeo
   7lXWDE0BsNTtS6BqPJ8Dssyv00DsqxX7EKPvT+RhwNGnXsxoLaEB3EHsi
   Dapl6lZ/Nf6TTcKGbR9COmqcsrxPajG8qsp2A9RhnE0k7FpVQ9r4YYMpK
   ALi2/7zePAuKZAbc3cGWvMAUUEmbXIdamG0cV4YN61fGTiFCTg1s6XAJ+
   +T9+c2FSjAhtsHZDytydJ7MFATp6iakvnEFDes+MN/5/ZInE9VPM3wX7b
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="324701099"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="324701099"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:05:18 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10592"; a="783174235"
X-IronPort-AV: E=Sophos;i="5.97,222,1669104000"; 
   d="scan'208";a="783174235"
Received: from tronach-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.40.3])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2023 01:05:14 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Rodolfo Giometti <giometti@enneenne.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Johan Hovold <johan@kernel.org>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 08/12] tty/serial: Make ->dcd_change()+uart_handle_dcd_change() status bool active
Date:   Tue, 17 Jan 2023 11:03:54 +0200
Message-Id: <20230117090358.4796-9-ilpo.jarvinen@linux.intel.com>
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

Convert status parameter for ->dcd_change() and
uart_handle_dcd_change() to bool which matches to how the parameter is
used.

Rename status to active to better describe what the parameter means.

Acked-by: Rodolfo Giometti <giometti@enneenne.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pps/clients/pps-ldisc.c  | 6 +++---
 drivers/tty/serial/serial_core.c | 8 ++++----
 drivers/tty/serial/sunhv.c       | 8 ++++----
 include/linux/serial_core.h      | 3 +--
 include/linux/tty_ldisc.h        | 4 ++--
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index d73c4c2ed4e1..443d6bae19d1 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -13,7 +13,7 @@
 #include <linux/pps_kernel.h>
 #include <linux/bug.h>
 
-static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
+static void pps_tty_dcd_change(struct tty_struct *tty, bool active)
 {
 	struct pps_device *pps;
 	struct pps_event_time ts;
@@ -29,11 +29,11 @@ static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 		return;
 
 	/* Now do the PPS event report */
-	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
+	pps_event(pps, &ts, active ? PPS_CAPTUREASSERT :
 			PPS_CAPTURECLEAR, NULL);
 
 	dev_dbg(pps->dev, "PPS %s at %lu\n",
-			status ? "assert" : "clear", jiffies);
+			active ? "assert" : "clear", jiffies);
 }
 
 static int (*alias_n_tty_open)(struct tty_struct *tty);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 053535846ba2..f8a9386db482 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3252,11 +3252,11 @@ EXPORT_SYMBOL(uart_match_port);
 /**
  * uart_handle_dcd_change - handle a change of carrier detect state
  * @uport: uart_port structure for the open port
- * @status: new carrier detect status, nonzero if active
+ * @active: new carrier detect status
  *
  * Caller must hold uport->lock.
  */
-void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
+void uart_handle_dcd_change(struct uart_port *uport, bool active)
 {
 	struct tty_port *port = &uport->state->port;
 	struct tty_struct *tty = port->tty;
@@ -3268,7 +3268,7 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 		ld = tty_ldisc_ref(tty);
 		if (ld) {
 			if (ld->ops->dcd_change)
-				ld->ops->dcd_change(tty, status);
+				ld->ops->dcd_change(tty, active);
 			tty_ldisc_deref(ld);
 		}
 	}
@@ -3276,7 +3276,7 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 	uport->icount.dcd++;
 
 	if (uart_dcd_enabled(uport)) {
-		if (status)
+		if (active)
 			wake_up_interruptible(&port->open_wait);
 		else if (tty)
 			tty_hangup(tty);
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
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index fd59f600094a..760c96ffb5bd 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -896,8 +896,7 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
  * The following are helper functions for the low level drivers.
  */
 
-extern void uart_handle_dcd_change(struct uart_port *uport,
-		unsigned int status);
+extern void uart_handle_dcd_change(struct uart_port *uport, bool active);
 extern void uart_handle_cts_change(struct uart_port *uport,
 		unsigned int status);
 
diff --git a/include/linux/tty_ldisc.h b/include/linux/tty_ldisc.h
index dcb61ec11424..49dc172dedc7 100644
--- a/include/linux/tty_ldisc.h
+++ b/include/linux/tty_ldisc.h
@@ -170,7 +170,7 @@ int ldsem_down_write_nested(struct ld_semaphore *sem, int subclass,
  *	send, please arise a tasklet or workqueue to do the real data transfer.
  *	Do not send data in this hook, it may lead to a deadlock.
  *
- * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, unsigned int status)``
+ * @dcd_change: [DRV] ``void ()(struct tty_struct *tty, bool active)``
  *
  *	Tells the discipline that the DCD pin has changed its status. Used
  *	exclusively by the %N_PPS (Pulse-Per-Second) line discipline.
@@ -238,7 +238,7 @@ struct tty_ldisc_ops {
 	void	(*receive_buf)(struct tty_struct *tty, const unsigned char *cp,
 			       const char *fp, int count);
 	void	(*write_wakeup)(struct tty_struct *tty);
-	void	(*dcd_change)(struct tty_struct *tty, unsigned int status);
+	void	(*dcd_change)(struct tty_struct *tty, bool active);
 	int	(*receive_buf2)(struct tty_struct *tty, const unsigned char *cp,
 				const char *fp, int count);
 	void	(*lookahead_buf)(struct tty_struct *tty, const unsigned char *cp,
-- 
2.30.2

