Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AEED65D710
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 16:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239654AbjADPRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 10:17:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239606AbjADPQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 10:16:51 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88252AF4;
        Wed,  4 Jan 2023 07:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672845410; x=1704381410;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FoqobpN/XyZOt6RH0jMAVUy4b82570kSmzhqiLl+O90=;
  b=LdG3QslyK49dN4+AMcSrL1lMlTmtijWgK2QFnYx4gKQBVr4psy4Z0lAE
   c1Zt5Dde2AJlslNpOj1nHrDX1yUlXGrQ6yj1NoUdoxnyeMp5fFTbLJ8NS
   NwPQiVB+/A/7PLuVWsmx3jcluHsdii2qN18ND+pc9RZ9TN9VxGPagHZQR
   RVSMkmMwxRuuReNRaoS4w4KOF/5Gm1mzo6LmUGHHnhmqq+BNRMiBSWUPR
   GqH9mxEArzESz2YrP2AAY/aNt7fHdz3gWc+sr1txZlKH6HYnilcscLaVz
   xRBgmOPa5PE1FJE6eeGCGEX96C+u1as6S5dnZNWGU2AeY/H0gtB13F7zr
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="301644557"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="301644557"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:16:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10580"; a="762700930"
X-IronPort-AV: E=Sophos;i="5.96,300,1665471600"; 
   d="scan'208";a="762700930"
Received: from msvoboda-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.48.119])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2023 07:16:25 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 09/10] serial: Make uart_handle_cts_change() status param bool
Date:   Wed,  4 Jan 2023 17:15:30 +0200
Message-Id: <20230104151531.73994-10-ilpo.jarvinen@linux.intel.com>
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

Convert uart_handle_cts_change() to bool which is more appropriate
than unsigned int.

Cleanup callsites from operations that are not necessary with bool.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/imx.c         | 2 +-
 drivers/tty/serial/max3100.c     | 2 +-
 drivers/tty/serial/max310x.c     | 3 +--
 drivers/tty/serial/serial_core.c | 4 ++--
 include/linux/serial_core.h      | 3 +--
 5 files changed, 6 insertions(+), 8 deletions(-)

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
index 76536c74e907..35fff37e42bb 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3285,11 +3285,11 @@ EXPORT_SYMBOL_GPL(uart_handle_dcd_change);
 /**
  * uart_handle_cts_change - handle a change of clear-to-send state
  * @uport: uart_port structure for the open port
- * @status: new clear to send status, nonzero if active
+ * @status: new clear to send status, true if active
  *
  * Caller must hold uport->lock.
  */
-void uart_handle_cts_change(struct uart_port *uport, unsigned int status)
+void uart_handle_cts_change(struct uart_port *uport, bool status)
 {
 	lockdep_assert_held_once(&uport->lock);
 
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index f1b69a36bb2b..591224505cb4 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -897,8 +897,7 @@ static inline bool uart_softcts_mode(struct uart_port *uport)
  */
 
 extern void uart_handle_dcd_change(struct uart_port *uport, bool status);
-extern void uart_handle_cts_change(struct uart_port *uport,
-		unsigned int status);
+extern void uart_handle_cts_change(struct uart_port *uport, bool status);
 
 extern void uart_insert_char(struct uart_port *port, unsigned int status,
 		 unsigned int overrun, unsigned int ch, unsigned int flag);
-- 
2.30.2

