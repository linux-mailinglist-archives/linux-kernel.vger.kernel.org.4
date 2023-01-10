Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24870663FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 13:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbjAJMFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 07:05:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbjAJMEs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 07:04:48 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA456133A;
        Tue, 10 Jan 2023 04:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673352232; x=1704888232;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t3AofURgQrlD1q/1wrXq4yH+zizSxR5Eo97yqMlfyZU=;
  b=TboAVqSJdARydXSk2NlxSO9JPoo6QlJVyMFdJJU4KzQb5/vLpeT2VgUR
   HMlK+t1SBWkr3ouoZtilyjidwQ6XEYaMhtzBouA2nEkwylj/LRan8b27b
   rABDL/j4dmMvYDl2fkoL07enLklaD4gvMRWTNkaQSmxVJxDMQZK3lMdtQ
   hOwUuIqayMmhkklnDOORNUOXnmgUAR1EO6K1bKQXc/SEVwxjkkYqWjqRL
   T+MMpYVw5yQfSfNEuTXureoYotjiRxI68uTDjWS/drlWsCv7T2p6xUt7Z
   qvkpr+7dPV7TL/G/D3dYQMwVocuGJZh/dO9maTgS7hqowFxKJzkO5Elx6
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="350350203"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="350350203"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10585"; a="799406994"
X-IronPort-AV: E=Sophos;i="5.96,315,1665471600"; 
   d="scan'208";a="799406994"
Received: from gbocanex-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.44.115])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2023 04:03:44 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Rodolfo Giometti <giometti@enneenne.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 09/13] serial: Make uart_handle_cts_change() status param bool active
Date:   Tue, 10 Jan 2023 14:02:22 +0200
Message-Id: <20230110120226.14972-10-ilpo.jarvinen@linux.intel.com>
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

Convert uart_handle_cts_change() to bool which is more appropriate
than unsigned int.

Rename status to active to better describe what the parameter means.
While at it, make the comment about the active parameter easier to
parse.

Cleanup callsites from operations that are not necessary with bool.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/imx.c         | 2 +-
 drivers/tty/serial/max3100.c     | 2 +-
 drivers/tty/serial/max310x.c     | 3 +--
 drivers/tty/serial/serial_core.c | 8 ++++----
 include/linux/serial_core.h      | 3 +--
 5 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 757825edb0cd..07850a9cde61 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -771,7 +771,7 @@ static irqreturn_t __imx_uart_rtsint(int irq, void *dev_id)
 
 	imx_uart_writel(sport, USR1_RTSD, USR1);
 	usr1 = imx_uart_readl(sport, USR1) & USR1_RTSS;
-	uart_handle_cts_change(&sport->port, !!usr1);
+	uart_handle_cts_change(&sport->port, usr1);
 	wake_up_interruptible(&sport->port.state->port.delta_msr_wait);
 
 	return IRQ_HANDLED;
diff --git a/drivers/tty/serial/max3100.c b/drivers/tty/serial/max3100.c
index bb74f23251fe..86dcbff8faa3 100644
--- a/drivers/tty/serial/max3100.c
+++ b/drivers/tty/serial/max3100.c
@@ -247,7 +247,7 @@ static int max3100_handlerx(struct max3100_port *s, u16 rx)
 	cts = (rx & MAX3100_CTS) > 0;
 	if (s->cts != cts) {
 		s->cts = cts;
-		uart_handle_cts_change(&s->port, cts ? TIOCM_CTS : 0);
+		uart_handle_cts_change(&s->port, cts);
 	}
 
 	return ret;
diff --git a/drivers/tty/serial/max310x.c b/drivers/tty/serial/max310x.c
index 4eb24e3407f8..e9cacfe7e032 100644
--- a/drivers/tty/serial/max310x.c
+++ b/drivers/tty/serial/max310x.c
@@ -819,8 +819,7 @@ static irqreturn_t max310x_port_irq(struct max310x_port *s, int portno)
 
 		if (ists & MAX310X_IRQ_CTS_BIT) {
 			lsr = max310x_port_read(port, MAX310X_LSR_IRQSTS_REG);
-			uart_handle_cts_change(port,
-					       !!(lsr & MAX310X_LSR_CTS_BIT));
+			uart_handle_cts_change(port, lsr & MAX310X_LSR_CTS_BIT);
 		}
 		if (rxlen)
 			max310x_handle_rx(port, rxlen);
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index f8a9386db482..b8fff667d4f0 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3287,11 +3287,11 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
 /**
  * uart_handle_cts_change - handle a change of clear-to-send state
  * @uport: uart_port structure for the open port
- * @status: new clear to send status, nonzero if active
+ * @active: new clear-to-send status
  *
  * Caller must hold uport->lock.
  */
-void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
+void uart_handle_cts_change(struct uart_port *uport, bool active)
 {
 	lockdep_assert_held_once(&uport->lock);
 
@@ -3299,13 +3299,13 @@ void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
 
 	if (uart_softcts_mode(uport)) {
 		if (uport->hw_stopped) {
-			if (status) {
+			if (active) {
 				uport->hw_stopped = 0;
 				uport->ops->start_tx(uport);
 				uart_write_wakeup(uport);
 			}
 		} else {
-			if (!status) {
+			if (!active) {
 				uport->hw_stopped = 1;
 				uport->ops->stop_tx(uport);
 			}
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 760c96ffb5bd..ddd7c9425938 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -897,8 +897,7 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
  */
 
 extern void uart_handle_dcd_change(struct uart_port *uport, bool active);
-extern void uart_handle_cts_change(struct uart_port *uport,
-		unsigned int status);
+extern void uart_handle_cts_change(struct uart_port *uport, bool active);
 
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
-- 
2.30.2

