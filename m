Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1F52626BF5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 22:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiKLVWZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 16:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiKLVVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 16:21:54 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D7D18E32;
        Sat, 12 Nov 2022 13:21:44 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id d8so2115611qki.13;
        Sat, 12 Nov 2022 13:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K4iHEj9GzsVhhsWXwgpXJUYpNlSEHLmzm/JsgBx/hzw=;
        b=EZSQB4szI1sqawbShitBG+hzdiK94qL8rotIka8T4R2AOXMEXnwnsPqjgi0OFSykcR
         Wj4xQgi5MSxXfhOOaNDiM2udoMgu+tPEn+eygOQeSbf2fE+0isZpODtq5sInTDiNFfye
         yJ4PG6QLktQy4Tz4QvFL+F2xMu6f05Xzl+PJcOX0PKSwhSE+QuTgeVO4oO1VeG4v/Vio
         E4KRfk9aL48mSGN+rA0AD4VYJLfISEQP4jrCdHnN/Q3v+QpJum/aX6sb8O3Dgy/210Ld
         mudcSj1Ci/sDA6Lnp91oChlRxHP9T+ZOtGiDz6lJjqo3Oj0kXH/cEvso/8OtCmyWtNk1
         YLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K4iHEj9GzsVhhsWXwgpXJUYpNlSEHLmzm/JsgBx/hzw=;
        b=42djFdXAMGNw/iua9V+o9Qcz/Tj24F63EFa1kSg/nh3nlaKNaDXANUQI2weQUahW+j
         HjxPPpzi5Phg35X/ZJW7TYfx6YI6YhqZOaUekeoCjcgGAP9AKjkHyEYFS1ff3dmuGPZs
         X4gv5Ga9m14rrAOoVROqgxm66ath6f0joAxCJrzjpdE6rhSZ/ttnDAQJpCSiJ3/B3MTp
         fgbkW1MHGzKI3aw7zyIpc5MeaiFFa+oCF+pxFas//bg/2/vBD8U62/++EwOmF7TUzjog
         gdomPSytF/UuS4stg9coAkjfIzT0Z5l9ZcLXLOoLWu2HR2WKJ7I/VzqEhkmeaiVxIQsH
         4+UA==
X-Gm-Message-State: ANoB5pkNPsmea2QhfUoyNXbCOg4GTBkjzFsacdPMDhlEPH54sChTOMVi
        GlhvL9hD7zKelVe2RUqiiFzAK1YSXYkFDA==
X-Google-Smtp-Source: AA0mqf7kqd9AcWKjMOWpFgbx6/iBsL2fXv3FyvWzV6AzGX32D/t7+8FzKy/VHkdItv3i7ioTfW2/Eg==
X-Received: by 2002:a37:86c3:0:b0:6fa:d7e:7b4 with SMTP id i186-20020a3786c3000000b006fa0d7e07b4mr6006823qkd.373.1668288103069;
        Sat, 12 Nov 2022 13:21:43 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id t8-20020a37ea08000000b006fa313bf185sm3811839qkj.8.2022.11.12.13.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Nov 2022 13:21:42 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v3 12/14] serial: liteuart: add IRQ support for the RX path
Date:   Sat, 12 Nov 2022 16:21:23 -0500
Message-Id: <20221112212125.448824-13-gsomlo@gmail.com>
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

Add support for IRQ-driven RX. Support for the TX path will be added
in a separate commit.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 61 +++++++++++++++++++++++++++++++----
 1 file changed, 54 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index cf1ce597b45e..e30adb30277f 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/console.h>
+#include <linux/interrupt.h>
 #include <linux/litex.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -130,13 +131,29 @@ static void liteuart_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static irqreturn_t liteuart_interrupt(int irq, void *data)
+{
+	struct liteuart_port *uart = data;
+	struct uart_port *port = &uart->port;
+	u8 isr = litex_read8(port->membase + OFF_EV_PENDING);
+
+	/* for now, only rx path triggers interrupts */
+	isr &= EV_RX;
+
+	spin_lock(&port->lock);
+	if (isr & EV_RX)
+		liteuart_rx_chars(port);
+	spin_unlock(&port->lock);
+
+	return IRQ_RETVAL(isr);
+}
+
 static void liteuart_timer(struct timer_list *t)
 {
 	struct liteuart_port *uart = from_timer(uart, t, timer);
 	struct uart_port *port = &uart->port;
 
-	liteuart_rx_chars(port);
-
+	liteuart_interrupt(0, port);
 	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
 }
 
@@ -162,19 +179,42 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
+	int ret;
+	u8 irq_mask = 0;
 
-	/* disable events */
-	litex_write8(port->membase + OFF_EV_ENABLE, 0);
+	if (port->irq) {
+		ret = request_irq(port->irq, liteuart_interrupt, 0,
+				  KBUILD_MODNAME, uart);
+		if (ret == 0) {
+			/* only enable rx interrupts at this time */
+			irq_mask = EV_RX;
+		} else {
+			pr_err(pr_fmt("line %d irq %d failed: using polling\n"),
+				port->line, port->irq);
+			port->irq = 0;
+		}
+	}
 
-	/* prepare timer for polling */
-	timer_setup(&uart->timer, liteuart_timer, 0);
-	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+	if (!port->irq) {
+		timer_setup(&uart->timer, liteuart_timer, 0);
+		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+	}
+
+	litex_write8(port->membase + OFF_EV_ENABLE, irq_mask);
 
 	return 0;
 }
 
 static void liteuart_shutdown(struct uart_port *port)
 {
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	litex_write8(port->membase + OFF_EV_ENABLE, 0);
+
+	if (port->irq)
+		free_irq(port->irq, port);
+	else
+		del_timer_sync(&uart->timer);
 }
 
 static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
@@ -263,6 +303,13 @@ static int liteuart_probe(struct platform_device *pdev)
 		goto err_erase_id;
 	}
 
+	/* get irq */
+	ret = platform_get_irq_optional(pdev, 0);
+	if (ret < 0 && ret != -ENXIO)
+		return ret;
+	if (ret > 0)
+		port->irq = ret;
+
 	/* values not from device tree */
 	port->dev = &pdev->dev;
 	port->iotype = UPIO_MEM;
-- 
2.37.3

