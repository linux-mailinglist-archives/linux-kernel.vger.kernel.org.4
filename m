Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF91E62F88E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242166AbiKRO5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242160AbiKRO4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:56:34 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D209150E;
        Fri, 18 Nov 2022 06:55:38 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id x18so3543901qki.4;
        Fri, 18 Nov 2022 06:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H85ZBilTG0+9LONYH8WQbu/RytIoy2zs4o7WBsneFmU=;
        b=LhhyMUdVDLul1ydHHrS6RZygPfgsb9WLi8RzPvcrcuEFUHygkpO7cPiUTwe0kNowqO
         6nEygirPATdptLzsTN3KSUmnvFS8xfFcpbjN8tgit+65xbSMko3dgNEXHSLUsL896Fqr
         /IU0W9jv0vBQluLZYX36TRLdbsNRkcTf6pbGShO3TWOW1IFJqDXSFiQLv7xk9sSxVPDA
         FY0JDoTULWHJGzmtmoxoYL6HVkDgu4HFu2NyuMIsHm45LZLPEmhCxcCtLWLvorM5bMID
         lCm0eekLEWH0+moRRJaxSDLabpHiqNltQ5UGYnGHIjX0Fjk2qDaK2z0cGxvrcJ4PCxeP
         ZxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H85ZBilTG0+9LONYH8WQbu/RytIoy2zs4o7WBsneFmU=;
        b=6qwEa0cVFlTvNabvHXzA4HPXhzLiG2QCq9qDgTOHWnBth0bvCWWnNOZ8XNie0zkqJy
         CUQlLucDs/BYPDqb73gNGaVeyqDPgzyGm3T2lRF25M3Z5X2bdkDmz31JN10MMgd4gJuw
         fU4Z5Fdm/tUI4b1CyeVyRrq+cX//phVZtEcTDB57ua1DzXMdg+xHoT23xe3qomPGGm+c
         KW99QRYC2jy9rKXtVvpBHHEO1Yxo4k06iXrkqYEhc9boN1FMQya1qbwT+iVr3YJ1iFXQ
         3z72Mu+oSkJfLbgXxaztgKwUFSgulosLyYKfLu+OWhVcQ09gsg6K+gdJfEXtUpwDHFcM
         TJHA==
X-Gm-Message-State: ANoB5pngzgJamhnQAwuTYCOgPLx0k2c5s61LAT3xkg0/7uFbjJv5WCii
        +2p+TzUCfyuXt9fbbzJaCV/WFg5tm6VnVg==
X-Google-Smtp-Source: AA0mqf5Vy4Ub03FXWWAc6fYXJR6NsDw2lzDHauufkGa3awmps9hzkb8CsY0EiZnT8S/DnpxDrlrqRg==
X-Received: by 2002:ae9:ef92:0:b0:6fa:11fd:5861 with SMTP id d140-20020ae9ef92000000b006fa11fd5861mr6110181qkg.726.1668783337181;
        Fri, 18 Nov 2022 06:55:37 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:36 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 13/14] serial: liteuart: add IRQ support for the TX path
Date:   Fri, 18 Nov 2022 09:55:11 -0500
Message-Id: <20221118145512.509950-14-gsomlo@gmail.com>
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

Switch the TX path to IRQ-driven operation, while maintaining support
for polling mode via the poll timer.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/tty/serial/liteuart.c | 30 +++++++++++++-----------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 678c37c952cf..850125870efb 100644
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
@@ -154,6 +148,8 @@ static irqreturn_t liteuart_interrupt(int irq, void *data)
 	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
 	if (isr & EV_RX)
 		liteuart_rx_chars(port);
+	if (isr & EV_TX)
+		liteuart_tx_chars(port);
 	spin_unlock(&port->lock);
 
 	return IRQ_RETVAL(isr);
-- 
2.38.1

