Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4411162F889
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiKRO4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242103AbiKRO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:56:14 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3139F903B0;
        Fri, 18 Nov 2022 06:55:35 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id z17so3521418qki.11;
        Fri, 18 Nov 2022 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=21klUdbfGDRjcluKPkIVpLANgI2deNdmI4jgyQps/O0=;
        b=n8CjLEpyMMypMvrOR56LqMpSVaojyD46sOcMUYJx+0FWmmryO4Mhunao5oBcb2/ZF9
         0JFN60k3k+R5BOHSyYWLUTWf3jdMXgd5Jws3WEcYaXirV7y8R3xCDwKUhxGajyocQYTW
         UI3SCnvaSxUPHtmE373/M9iRNdmai2GH57+DECiBcvTlAMvheLRKCFZNqg0aNL+/pqUR
         TmZB9QosMtFYri3KGjQP6fvrBtBnOVnFyrqiHtZpEjNsEHnaL4vKLAflI29YhUfmxJdI
         d2zikxyEQFke2ySzzV6RPFiZ0cf0XyJ+dA6SnheBq/Xs1csz7NYJ1C72UsLDcFn+EtUQ
         rotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=21klUdbfGDRjcluKPkIVpLANgI2deNdmI4jgyQps/O0=;
        b=FlgeBoTxj/dPcB2+fn5JLtyg7pc2EWsmleujee2eDQjTys4dJfrdBdRrDKet2DpmT3
         RRoPZkXHEcGahTc5Oi4V3oKUEk5xtbqDSolwxWPFRKQcksXda/m8NWNWtktwXJSaqlVq
         nxBUE5fnkm7OC0VBfPMmjDKaLgPkm5Iwep+A5TWfQrDOoh5adDGVDeQeX5iZPp2p3RAe
         5AO8lDbtdPguIiOe9Z1M41WSw66D2aZzieODnw24Ra/1u1x5m3HshkbPihJnLnL5Vcpm
         0LOdgX9YrZK+V9bTJXkNvui1QzVJZztmDXg9+76Sq7+9IcL0fcnraR850EZoStWjRa4c
         ib9g==
X-Gm-Message-State: ANoB5pmoT4mZgnVztxKQypkVHhz/d9J2YTJE72mwf3/ACXeM58N/4GzR
        Iqyly8oTV86FmVEyzZAaEaPzN0v0AiBLKA==
X-Google-Smtp-Source: AA0mqf7akg3izJE5qTRoR+aLT1DtJXWHdFAu/tOyf7N/hRqjoRI6qRoCHjaHgvKRuiPNGZh4UWqX7w==
X-Received: by 2002:a37:a806:0:b0:6fa:88d:521d with SMTP id r6-20020a37a806000000b006fa088d521dmr5917911qke.317.1668783333970;
        Fri, 18 Nov 2022 06:55:33 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:33 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 11/14] serial: liteuart: move function definitions
Date:   Fri, 18 Nov 2022 09:55:09 -0500
Message-Id: <20221118145512.509950-12-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221118145512.509950-1-gsomlo@gmail.com>
References: <20221118145512.509950-1-gsomlo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 82 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 76f8a09b82cd..8a6e176be08e 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -68,6 +68,47 @@ static struct uart_driver liteuart_driver = {
 #endif
 };
 
+static void liteuart_putchar(struct uart_port *port, unsigned char ch)
+{
+	while (litex_read8(port->membase + OFF_TXFULL))
+		cpu_relax();
+
+	litex_write8(port->membase + OFF_RXTX, ch);
+}
+
+static void liteuart_stop_tx(struct uart_port *port)
+{
+}
+
+static void liteuart_start_tx(struct uart_port *port)
+{
+	struct circ_buf *xmit = &port->state->xmit;
+	unsigned char ch;
+
+	if (unlikely(port->x_char)) {
+		litex_write8(port->membase + OFF_RXTX, port->x_char);
+		port->icount.tx++;
+		port->x_char = 0;
+	} else if (!uart_circ_empty(xmit)) {
+		while (xmit->head != xmit->tail) {
+			ch = xmit->buf[xmit->tail];
+			uart_xmit_advance(port, 1);
+			liteuart_putchar(port, ch);
+		}
+	}
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(port);
+}
+
+static void liteuart_stop_rx(struct uart_port *port)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	/* just delete timer */
+	del_timer(&uart->timer);
+}
+
 static void liteuart_rx_chars(struct uart_port *port)
 {
 	unsigned char __iomem *membase = port->membase;
@@ -98,14 +139,6 @@ static void liteuart_timer(struct timer_list *t)
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
-static void liteuart_putchar(struct uart_port *port, unsigned char ch)
-{
-	while (litex_read8(port->membase + OFF_TXFULL))
-		cpu_relax();
-
-	litex_write8(port->membase + OFF_RXTX, ch);
-}
-
 static unsigned int liteuart_tx_empty(struct uart_port *port)
 {
 	/* not really tx empty, just checking if tx is not full */
@@ -125,39 +158,6 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
 	return TIOCM_CTS | TIOCM_DSR | TIOCM_CAR;
 }
 
-static void liteuart_stop_tx(struct uart_port *port)
-{
-}
-
-static void liteuart_start_tx(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned char ch;
-
-	if (unlikely(port->x_char)) {
-		litex_write8(port->membase + OFF_RXTX, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-	} else if (!uart_circ_empty(xmit)) {
-		while (xmit->head != xmit->tail) {
-			ch = xmit->buf[xmit->tail];
-			uart_xmit_advance(port, 1);
-			liteuart_putchar(port, ch);
-		}
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-}
-
-static void liteuart_stop_rx(struct uart_port *port)
-{
-	struct liteuart_port *uart = to_liteuart_port(port);
-
-	/* just delete timer */
-	del_timer(&uart->timer);
-}
-
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
-- 
2.38.1

