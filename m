Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEC8665DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:25:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239246AbjAKOZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:25:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjAKOYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:24:45 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D519C1F;
        Wed, 11 Jan 2023 06:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673447084; x=1704983084;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=H7gcjHlQ0XUrWXxfntmwgVaPZ/M9meupAYikxPatJgg=;
  b=US+MOOycEPws8+Woif3vG8VFlaRMpaxplxLrxhlf6UPbdxzFUlIODHu1
   Q+UNbzOKJ37KBtH/WgZygFbh2LSJJXfxdjDELECc/J5OsgPNrJZTfXigs
   CE2IlNXi4Y1uMohL60SuaaU4G7GPnNTzLTLOEdt5Lvt9+6tpQTwNd5qT3
   lrkt3S04SbPAhJsF1hvmkJSITTgCiNuJvZ3a8LFE71+pGHMHA5ysbocyO
   XfsrWpZZ6gMjwt8YTP4+0gVLogQuk+Zs5ZQMnkq/xc3Igv8X5PjhWAhCE
   Y9ULihyC1dGi4wU+GKVEWGieAFSeRp2Zosi7HkHTJwCS2SfQadpOEUQ+i
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303793706"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="303793706"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:43 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="607381997"
X-IronPort-AV: E=Sophos;i="5.96,317,1665471600"; 
   d="scan'208";a="607381997"
Received: from mihaiana-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.222.62])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 06:24:38 -0800
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
Subject: [PATCH v3 09/13] serial: Make uart_handle_cts_change() status param bool active
Date:   Wed, 11 Jan 2023 16:23:27 +0200
Message-Id: <20230111142331.34518-10-ilpo.jarvinen@linux.intel.com>
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

Convert uart_handle_cts_change() to bool which is more appropriate
than unsigned int.

Rename status to active to better describe what the parameter means.
While at it, make the comment about the active parameter easier to
parse.

Cleanup callsites from operations that are not necessary with bool.

Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
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

