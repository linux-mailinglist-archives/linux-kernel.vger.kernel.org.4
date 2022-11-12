Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1904C626BF1
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiKLVWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235133AbiKLVVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:53 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D4717E27;
        Sat, 12 Nov 2022 13:21:43 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id z6so4875247qtv.5;
        Sat, 12 Nov 2022 13:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fmWYDGpb8IgSQuNUIhuOc4E9EPEFJS+O6JKsCfcl04A=;
        b=cvlZfzUOE4fIt0ylPCWhzQf5qAHZnEqXbhj8O+qwvQOTp4EJud9fQeAEZPphl3kdWC
         KXVmf1d4Cp4xQGd6zioJfGaWmsThJ/ry6Hh0tsg7FkQJVMzAD5cB7nFDi9Lu97XAQWSt
         rIIQ8v33Hyrywe9aN32h69DZD/61u/oKTT/tApu1+E9njOKD9CxGhTgw1MpPh7iCk1Zw
         1RoHqqLgjnCdanRFmdemtNvyuJYkW/LiE3pH3+FxKFSRyKJ7TZVoVfPLrI0gMltOZeSS
         9hyggEiXSseJvROugFk6g/hbl6lZGA4RikQYGrmcZBSi7expFOcDLtWwH+84m3tsheyo
         6g1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fmWYDGpb8IgSQuNUIhuOc4E9EPEFJS+O6JKsCfcl04A=;
        b=z2C/v2+ZUjC+vHj2Z6tgorPZqRTisFhfzZv2WVEyK6cY6N61p3JTM1StTmKI2orHO5
         1Y0AHRQnld30vddi1u8Sc4R5ysVlTxi0kiy/za3PVUmiOmW8zY2652cq/9qvMq4jI0J3
         ivAn6cYMcI9K212hFQ2CctKQQNeKsWVBTedkHRhulfOqcrFsTznI5l4vVEEfX/+krBCa
         Nj7lGMtO+xD2wuNV6TOlADEr54nBcxp7yhR8Tyvb9EwMxib9A4UvoI5GOGmcsFEWsulz
         aJ0tlAgepWIRdvXkXmT4kRsBfBFPQesWu66nHbUewcwgFb9NMpWPm0AWIfIDdkPE7ExM
         X7hg==
X-Gm-Message-State: ANoB5pmZKipNdMltnZ9gyBsCRedk+hdgOmMpOgYuX6fgB36zoB4MtWkd
        S84Mm5kDB7Ri4ACD/YyN7y1AWbvKFNAzyw==
X-Google-Smtp-Source: AA0mqf4mbOHSoDknDH/1f83OctrJlSQPBqDcY3z5fUZm5qe2VaS7RWdHVzq69d8Dxr95QyPJj1VKUQ==
X-Received: by 2002:ac8:118f:0:b0:3a5:9191:da4c with SMTP id d15-20020ac8118f000000b003a59191da4cmr6741736qtj.540.1668288102087;
        Sat, 12 Nov 2022 13:21:42 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:41 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 11/14] serial: liteuart: move function definitions
Date:   Sat, 12 Nov 2022 16:21:22 -0500
Message-Id: <20221112212125.448824-12-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221112212125.448824-1-gsomlo@gmail.com>
References: <20221112212125.448824-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move definitions for liteuart_[stop|start]_tx(), liteuart_stop_rx(),
and liteuart_putchar() to a more convenient location in preparation
for adding IRQ support. This patch contains no functional changes.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 98 +++++++++++++++++------------------
 1 file changed, 49 insertions(+), 49 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 172ac190ba2f..cf1ce597b45e 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -67,36 +67,6 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
-static void liteuart_rx_chars(struct uart_port *port)
-{
-	unsigned char __iomem *membase = port->membase;
-	unsigned int status, ch;
-
-	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
-		ch = litex_read8(membase + OFF_RXTX);
-		port->icount.rx++;
-
-		/* necessary for RXEMPTY to refresh its value */
-		litex_write8(membase + OFF_EV_PENDING, EV_RX);
-
-		/* no overflow bits in status */
-		if (!(uart_handle_sysrq_char(port, ch)))
-			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
-	}
-
-	tty_flip_buffer_push(&port->state->port);
-}
-
-static void liteuart_timer(struct timer_list *t)
-{
-	struct liteuart_port *uart = from_timer(uart, t, timer);
-	struct uart_port *port = &uart->port;
-
-	liteuart_rx_chars(port);
-
-	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
-}
-
 static void liteuart_putchar(struct uart_port *port, unsigned char ch)
 {
 	while (litex_read8(port->membase + OFF_TXFULL))
@@ -105,25 +75,6 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
 	litex_write8(port->membase + OFF_RXTX, ch);
 }
 
-static unsigned int liteuart_tx_empty(struct uart_port *port)
-{
-	/* not really tx empty, just checking if tx is not full */
-	if (!litex_read8(port->membase + OFF_TXFULL))
-		return TIOCSER_TEMT;
-
-	return 0;
-}
-
-static void liteuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
-{
-	/* modem control register is not present in LiteUART */
-}
-
-static unsigned int liteuart_get_mctrl(struct uart_port *port)
-{
-	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
-}
-
 static void liteuart_stop_tx(struct uart_port *port)
 {
 	/* not used in LiteUART, but called unconditionally from serial_core */
@@ -159,6 +110,55 @@ static void liteuart_stop_rx(struct uart_port *port)
 	del_timer(&uart->timer);
 }
 
+static void liteuart_rx_chars(struct uart_port *port)
+{
+	unsigned char __iomem *membase = port->membase;
+	unsigned int status, ch;
+
+	while ((status = !litex_read8(membase + OFF_RXEMPTY)) == 1) {
+		ch = litex_read8(membase + OFF_RXTX);
+		port->icount.rx++;
+
+		/* necessary for RXEMPTY to refresh its value */
+		litex_write8(membase + OFF_EV_PENDING, EV_RX);
+
+		/* no overflow bits in status */
+		if (!(uart_handle_sysrq_char(port, ch)))
+			uart_insert_char(port, status, 0, ch, TTY_NORMAL);
+	}
+
+	tty_flip_buffer_push(&port->state->port);
+}
+
+static void liteuart_timer(struct timer_list *t)
+{
+	struct liteuart_port *uart = from_timer(uart, t, timer);
+	struct uart_port *port = &uart->port;
+
+	liteuart_rx_chars(port);
+
+	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+}
+
+static unsigned int liteuart_tx_empty(struct uart_port *port)
+{
+	/* not really tx empty, just checking if tx is not full */
+	if (!litex_read8(port->membase + OFF_TXFULL))
+		return TIOCSER_TEMT;
+
+	return 0;
+}
+
+static void liteuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
+{
+	/* modem control register is not present in LiteUART */
+}
+
+static unsigned int liteuart_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
+}
+
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
-- 
2.37.3

