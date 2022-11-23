Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78181635F72
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238735AbiKWN0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238748AbiKWNYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:35 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76047B9610;
        Wed, 23 Nov 2022 05:05:21 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id z6so11127974qtv.5;
        Wed, 23 Nov 2022 05:05:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QeOhv8hm5IPcwehIrO8OEVXHvIMgFvCAfRcrJ3iovRc=;
        b=KyOlItduxSvhcwnnNngGtReEVVXLPcKBmPmYUIMUa0aiRKfBKzRomcjdgewp/bw3rC
         T7REI/3dMw7C+fT/rlScKCvN0PITQnlABE1lLCeDHaJuGc1AmNw/oOkfEKXLbR6lv/kj
         Z9VnAl3sU52mb7yBk9cq7qc2k4j4oCsyyQQsnaJsYfzJekLT9JvK0b36MoeuEqY8UVqg
         sVDZNUZH59Fmai3uEvOPxNaF1on764nE3Q4ZR2dc+2KxjULl44Sufl57w7FDgnb3O93c
         gbHT1OY683ghWDGk1rP0NDopT7HxR1jofAPBJ/859+OIpzfzI0ByVlpOUgJwm6C47d7Z
         riKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QeOhv8hm5IPcwehIrO8OEVXHvIMgFvCAfRcrJ3iovRc=;
        b=SjXn23ZmiTJjfDx+UYQnTrqXw454kIxiJRnWBjch+CPUIgvJkHSARqH5y+EugxLgj6
         FgFrrwxGHTZS7iOYG0KIqnBCl5BhzcyNtZSar308wgf5KKlGo+/l6lW/8V+uQr6f5YA2
         DuJ0g+AnoX82eS6JBn0N59SJL/5hmDXB/mma4zCa/TQipDk2s2OrnIaUc/tMV3elN0Yk
         PbMQEJ1t6G2ewC+MKxMCzugOYYdfOOwh7OupY3emffjFtMmGusGAeXAYPPUZhCyQfvOB
         huv2UI1bgOHXuSrfjfYRyNsukZVOcer4dd0vXrY3H9pNjdOSEWZd73FSt1z1eIeuUkrq
         XYkg==
X-Gm-Message-State: ANoB5pnxZ0SUQ6wv5t9DfdaCdM8wJadpCvgLi/ObQvBto3Jw5gmPfjff
        gl8G9aKaFQk8oGCUl9eWyha6HMPzxeYaXg==
X-Google-Smtp-Source: AA0mqf73BdO0+MBcMhLCYO6sdc1tEwtSlR3zi5fhWM9dgqh9ArfdbNFP1p9lN/Y9TCFFVth5RRPtkg==
X-Received: by 2002:a05:622a:2283:b0:3a5:943b:8441 with SMTP id ay3-20020a05622a228300b003a5943b8441mr26669333qtb.90.1669208719687;
        Wed, 23 Nov 2022 05:05:19 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:19 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 11/14] serial: liteuart: move function definitions
Date:   Wed, 23 Nov 2022 08:04:57 -0500
Message-Id: <20221123130500.1030189-12-gsomlo@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123130500.1030189-1-gsomlo@gmail.com>
References: <20221123130500.1030189-1-gsomlo@gmail.com>
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
Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/tty/serial/liteuart.c | 82 +++++++++++++++++------------------
 1 file changed, 41 insertions(+), 41 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index ab6837f3e40d..0b9d96e5efcf 100644
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

