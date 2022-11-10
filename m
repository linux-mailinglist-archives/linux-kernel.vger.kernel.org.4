Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1581F623859
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 01:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbiKJApe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 19:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbiKJApI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 19:45:08 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5D411C1F;
        Wed,  9 Nov 2022 16:45:07 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id s20so299148qkg.5;
        Wed, 09 Nov 2022 16:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+gDpqiQ2v07jcXDv+V+5mliWVvvI7QzpDNtOf1ZH6V8=;
        b=UKJoFM9Gfo4iktkKb4AhB4lJnkAdV940srYt0j+gLCpBXNv0FaYU6SpVIh6JdC1fDR
         iHXJjhNo5C9pFNNm0IiGbEuqUcb8MneWBurYovZKXBQM8pqJvZ2agsAACBaKOXqg/+Bw
         FPYJ+GCUIIajWyAnJcHaZI+QWZubGkUq5cYZTza5PzYbyDlVeDtXboHKO/kuVlKBqKsm
         oBlITBLnxIMXFbdAP4In+DKLcC8x+/WSHZE8VMfYpZNYYKYpcCJ16Zc+YmX+UVjlrPUX
         eziVvkE2aZjGRkzsFoL0H49py5ZKg0uqDBTbpE6CY5v6exd1AfcZ0eYkpTCNoS+W34Mw
         pnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+gDpqiQ2v07jcXDv+V+5mliWVvvI7QzpDNtOf1ZH6V8=;
        b=TKq7Ilmp46KbC75OvC0Ol3otxxpK+7umaU6Ko+TOH9p+vatKgqAkNq5j2rwX+QJmFV
         Vg/g+IO7FH4d09iPuIoJlduBvvZUF0tAjr78rTlejLp5llpXfrak0KqL0lEx3pf5bJnN
         pd3+fCy1bE25grEFAn7Qp67jrmIAaMhgsh8ijkIO3Paft7SHEfuh5A9F6XXaun7dUCSs
         /TjxSoIPZFUytvirVoNli+uLJYuM1l1E30k0rSOE9mGjxM8720aRXOkSI4xTIxsyc7AG
         znsEwr9XwqjEG5hIBOrxrfr+cmWcng73i1q20Khje22Noa70D2z8uR/+mlZf5aJURq0j
         HqcA==
X-Gm-Message-State: ACrzQf02fQ6ei2c/D2mxnn+XjvRw2IVeENlm0xsQsl3JRQ9ePzWFpH/V
        K3axYQRfPyuhGLLlL7c3riXhCQ84xtbFXg==
X-Google-Smtp-Source: AMsMyM4DTmriaNEFE6SIFXZh5UExPzopMuzvhqIlUs+cSfvIU9CoTmnahpzYAXeY3v/hmp6QAMidew==
X-Received: by 2002:a37:ac0f:0:b0:6fa:1185:4e7e with SMTP id e15-20020a37ac0f000000b006fa11854e7emr46101376qkm.334.1668041106140;
        Wed, 09 Nov 2022 16:45:06 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id x1-20020a05620a12a100b006eeb3165565sm11678506qki.80.2022.11.09.16.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 16:45:05 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org
Subject: [PATCH v2 7/7] serial: liteuart: add IRQ support
Date:   Wed,  9 Nov 2022 19:44:50 -0500
Message-Id: <20221110004450.772768-8-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221110004450.772768-1-gsomlo@gmail.com>
References: <20221110004450.772768-1-gsomlo@gmail.com>
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

Add support for IRQ-driven RX. The TX path remains "polling" based,
which is fine since TX is synchronous.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
---
 drivers/tty/serial/liteuart.c | 66 +++++++++++++++++++++++++++++++----
 1 file changed, 59 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index aa7052280197..45da944d1fea 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/console.h>
+#include <linux/interrupt.h>
 #include <linux/litex.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -88,13 +89,27 @@ static void liteuart_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static irqreturn_t liteuart_interrupt(int irq, void *data)
+{
+	struct uart_port *port = data;
+	unsigned int isr;
+
+	isr = litex_read32(port->membase + OFF_EV_PENDING);
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
 
@@ -163,19 +178,49 @@ static void liteuart_stop_rx(struct uart_port *port)
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned long flags;
+	int ret;
+	u8 irq_mask = 0;
 
-	/* disable events */
-	litex_write8(port->membase + OFF_EV_ENABLE, 0);
+	if (port->irq) {
+		ret = request_irq(port->irq, liteuart_interrupt, 0,
+				  KBUILD_MODNAME, port);
+		if (ret == 0) {
+			/* we only need interrupts on the rx path! */
+			irq_mask = EV_RX;
+		} else {
+			pr_err(KBUILD_MODNAME ": can't attach LiteUART %d "
+				"irq %d; switching to polling\n",
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
+	spin_lock_irqsave(&port->lock, flags);
+	litex_write8(port->membase + OFF_EV_ENABLE, irq_mask);
+	spin_unlock_irqrestore(&port->lock, flags);
 
 	return 0;
 }
 
 static void liteuart_shutdown(struct uart_port *port)
 {
+	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	litex_write8(port->membase + OFF_EV_ENABLE, 0);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (port->irq)
+		free_irq(port->irq, port);
+	else
+		del_timer_sync(&uart->timer);
 }
 
 static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
@@ -264,6 +309,13 @@ static int liteuart_probe(struct platform_device *pdev)
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

