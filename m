Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22DA1635F79
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 14:26:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236751AbiKWN0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 08:26:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236848AbiKWNYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 08:24:54 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B5BA59B;
        Wed, 23 Nov 2022 05:05:23 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id a27so11109010qtw.10;
        Wed, 23 Nov 2022 05:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3vOBwE8D1dAFgjAlie4wwP6R5GhWvJqKGsjcfV0A8tA=;
        b=TD7WPG1byXGcxR56YaJkS7kt+jTZ+gi5rHxZD/VbYHR8k7nKOdCtOnVdBXHo2xG1k8
         FKKgwgtOZM3sWsX2B1MAd25g8QUyaSt40fgFfiNnpVglviWO9ZN+0cHerHmNnVsVT8uo
         oHvYDFEdvfJcu3vn6GJijSqhnCTJs5jpNPKJqIxH+wLZDe/K7/TwZ5HZ2ZPt4ORRqVuq
         C99Pl8usQlXGnBXKUz6XJBHJu8xnbskBoAzwr7GxADTJ/55t86yVo2iisIG3Qk/DgB6E
         0hbbJ+NUIqJvth+8l93V+24KVdxzjcWnRNlqdNcwf/FxrzhJfo/ppN4xwRl0NXMkfJK5
         n3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3vOBwE8D1dAFgjAlie4wwP6R5GhWvJqKGsjcfV0A8tA=;
        b=bHUQ2LO9B9pCmKkl28IsbJCKXMvsrgwaYbPFPk92gGNOvBWc7Qa6rpyqMGzEbk9R9K
         FE0uUDe7jSl0Fm7GRBc+1WCy36EuE0JjIh6XpOyNXwfFTXgpgQb3R9itgbCD0BXyaOGC
         tyEhYgrp82Xqa4LVMlI1agBjw4V0d3R6g25IypPI6O0LZpAYvaV9W8ckBfwbj+t/ULXt
         dZdjTS0keH9Dd7CET+gHAtSXWSYtSlWE/ZrZ2cG54JakEx2b+OEBNSypubDrAsYPl8bi
         uzysa2qKSbJOytP8VnjIWsiepqKuZBfny/bZToytfh9q8LDNC2PI22mdgzQjzFrTkU3G
         MkZw==
X-Gm-Message-State: ANoB5pmMF7X6kkoeZGyeiC7VONSZhtXhp54uJ//V6IIpRVYo/lbvQ5jx
        NnctYlBR5rqYKhDkoQrL//ErmNlvTNZKPQ==
X-Google-Smtp-Source: AA0mqf6GWr9xhUbyY1VpwVuIQ+uhEZI30MBz22sqHhZArmHnwTlXiPxXOCzM6/OZyduC1jkKBaqYag==
X-Received: by 2002:ac8:7415:0:b0:3a4:a229:b974 with SMTP id p21-20020ac87415000000b003a4a229b974mr8107388qtq.255.1669208721911;
        Wed, 23 Nov 2022 05:05:21 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id f13-20020a05620a408d00b006bb78d095c5sm12188520qko.79.2022.11.23.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Nov 2022 05:05:21 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v6 13/14] serial: liteuart: add IRQ support for the TX path
Date:   Wed, 23 Nov 2022 08:04:59 -0500
Message-Id: <20221123130500.1030189-14-gsomlo@gmail.com>
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

Switch the TX path to IRQ-driven operation, while maintaining support
for polling mode via the poll timer.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 8685c97d391e..6e9f58d3957c 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -93,27 +93,12 @@ static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
 
 static void liteuart_stop_tx(struct uart_port *port)
 {
+	liteuart_update_irq_reg(port, false, EV_TX);
 }
 
 static void liteuart_start_tx(struct uart_port *port)
 {
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
+	liteuart_update_irq_reg(port, true, EV_TX);
 }
 
 static void liteuart_stop_rx(struct uart_port *port)
@@ -144,6 +129,15 @@ static void liteuart_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static void liteuart_tx_chars(struct uart_port *port)
+{
+	u8 ch;
+
+	uart_port_tx(port, ch,
+		!litex_read8(port->membase + OFF_TXFULL),
+		litex_write8(port->membase + OFF_RXTX, ch));
+}
+
 static irqreturn_t liteuart_interrupt(int irq, void *data)
 {
 	struct liteuart_port *uart = data;
@@ -159,6 +153,8 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
 	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
 	if (isr & EV_RX)
 		liteuart_rx_chars(port);
+	if (isr & EV_TX)
+		liteuart_tx_chars(port);
 	spin_unlock_irqrestore(&port->lock, flags);
 
 	return IRQ_RETVAL(isr);
-- 
2.38.1

