Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4821C62F88F
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 15:57:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242156AbiKRO5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 09:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242145AbiKRO4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 09:56:32 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBE3903BB;
        Fri, 18 Nov 2022 06:55:37 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id c8so3458991qvn.10;
        Fri, 18 Nov 2022 06:55:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrG3U4P8tnDM4SCWDYONLDPgsN83+RRu4eA0i7Q0lE8=;
        b=XPczYzmI7T958Ohirzr9OISoe0OA3mMrj3KmiR1oHYoNd+2Kx7FemEYeiBT5GjGSFp
         w2ttPETiLoFs3ysNof7dvniSnfaGve6wHDb87qUt19UcyJgyJAP0R000bep5SlygwqTh
         o4M4sSk/JDdbpMPOY03kyHZ4AvsvotliHbbMCFuV7jDOuawRVSXyjBkyvbijF8FNn/UE
         /DsoF+rxWWEbdl/mZNaeDFBS4BSQlzbEEbtXegJ1bg+iFIKDJ7jxrv6Qoy7vESwV/q8k
         HflrZotVOg/JP6poLgjAYmrchvJmq7FGm+66MQt6b20IBWcERZdwt50oTmbh/V8nJmdS
         V40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrG3U4P8tnDM4SCWDYONLDPgsN83+RRu4eA0i7Q0lE8=;
        b=DMhzGwzUwSa25OueuLgY0bsoE0g3KjmlvD3C/CFdanhHmQnJyxCup+8HWz+1eBPhod
         jL5Hsb3YKmjDeXslHgfDk+yp6iTG91l+Qy/Pi4Da4GMdhJ1hOCtvSfGmKFCJDc9J7Owr
         T2QJNSsHf/UQC4vBUG/6nANWb2pTuYBDWfI/j40dODhLTyyNYucYrFsSRR5mMDpDB23n
         uzF4n6CgUDOhUWGEUoUjqyBLrW6ip88P7gEAF+po6PifKvZqCdrcYRYEdS00ISBe+P7U
         ekGmale+LPyPXk71Q7ntHsAU2eZjWcCQs3Y9P8+LNq5AeAoRq3RUpVkICF/82kXk7Eaa
         lMug==
X-Gm-Message-State: ANoB5pk1kqkwSO6B6lBfrFPXbQrDl2zUnOgz7yNeF7dBvUaJDW3mos+k
        LTX0CaY9v6ULk+x8Jw6G94RhRA87OTpmKg==
X-Google-Smtp-Source: AA0mqf4W/w9J2gEsUjyjVl/z3e0KqmyVIn3MpWrVs55f3J9IAkd2xp3piMc0F6P8+gqa/J19g2lg6Q==
X-Received: by 2002:a05:6214:3984:b0:4bb:e31f:a56e with SMTP id ny4-20020a056214398400b004bbe31fa56emr6869841qvb.76.1668783335940;
        Fri, 18 Nov 2022 06:55:35 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id m125-20020a378a83000000b006cbc6e1478csm2397269qkd.57.2022.11.18.06.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Nov 2022 06:55:34 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@gmail.com,
        florent@enjoy-digital.fr, geert@linux-m68k.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v5 12/14] serial: liteuart: add IRQ support for the RX path
Date:   Fri, 18 Nov 2022 09:55:10 -0500
Message-Id: <20221118145512.509950-13-gsomlo@gmail.com>
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

Add support for IRQ-driven RX. Support for the TX path will be added
in a separate commit.

Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

Changes from v4:
  - using dev_err() instead of a combo of pr_err() and pr_fmt()
  - dropped "get irq" comment in probe()

> Changes from v3:
>   - add shadow irq register to support polling mode and avoid reading
>     hardware mmio irq register to learn which irq flags are enabled
>     - this also simplifies both liteuart_interrupt() and liteuart_startup()

 drivers/tty/serial/liteuart.c | 76 +++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 8a6e176be08e..678c37c952cf 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -7,6 +7,7 @@
 
 #include <linux/bits.h>
 #include <linux/console.h>
+#include <linux/interrupt.h>
 #include <linux/litex.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -46,6 +47,7 @@ struct liteuart_port {
 	struct uart_port port;
 	struct timer_list timer;
 	u32 id;
+	u8 irq_reg;
 };
 
 #define to_liteuart_port(port)	container_of(port, struct liteuart_port, port)
@@ -76,6 +78,19 @@ static void liteuart_putchar(struct uart_port *port, unsigned char ch)
 	litex_write8(port->membase + OFF_RXTX, ch);
 }
 
+static void liteuart_update_irq_reg(struct uart_port *port, bool set, u8 mask)
+{
+	struct liteuart_port *uart = to_liteuart_port(port);
+
+	if (set)
+		uart->irq_reg |= mask;
+	else
+		uart->irq_reg &= ~mask;
+
+	if (port->irq)
+		litex_write8(port->membase + OFF_EV_ENABLE, uart->irq_reg);
+}
+
 static void liteuart_stop_tx(struct uart_port *port)
 {
 }
@@ -129,13 +144,27 @@ static void liteuart_rx_chars(struct uart_port *port)
 	tty_flip_buffer_push(&port->state->port);
 }
 
+static irqreturn_t liteuart_interrupt(int irq, void *data)
+{
+	struct liteuart_port *uart = data;
+	struct uart_port *port = &uart->port;
+	u8 isr;
+
+	spin_lock(&port->lock);
+	isr = litex_read8(port->membase + OFF_EV_PENDING) & uart->irq_reg;
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
 
@@ -161,19 +190,46 @@ static unsigned int liteuart_get_mctrl(struct uart_port *port)
 static int liteuart_startup(struct uart_port *port)
 {
 	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned long flags;
+	int ret;
 
-	/* disable events */
-	litex_write8(port->membase + OFF_EV_ENABLE, 0);
+	if (port->irq) {
+		ret = request_irq(port->irq, liteuart_interrupt, 0,
+				  KBUILD_MODNAME, uart);
+		if (ret) {
+			dev_err(port->dev,
+				"line %d irq %d failed: switch to polling\n",
+				port->line, port->irq);
+			port->irq = 0;
+		}
+	}
 
-	/* prepare timer for polling */
-	timer_setup(&uart->timer, liteuart_timer, 0);
-	mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+	spin_lock_irqsave(&port->lock, flags);
+	/* only enabling rx irqs during startup */
+	liteuart_update_irq_reg(port, true, EV_RX);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (!port->irq) {
+		timer_setup(&uart->timer, liteuart_timer, 0);
+		mod_timer(&uart->timer, jiffies + uart_poll_timeout(port));
+	}
 
 	return 0;
 }
 
 static void liteuart_shutdown(struct uart_port *port)
 {
+	struct liteuart_port *uart = to_liteuart_port(port);
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	liteuart_update_irq_reg(port, false, EV_RX | EV_TX);
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	if (port->irq)
+		free_irq(port->irq, port);
+	else
+		del_timer_sync(&uart->timer);
 }
 
 static void liteuart_set_termios(struct uart_port *port, struct ktermios *new,
@@ -262,6 +318,12 @@ static int liteuart_probe(struct platform_device *pdev)
 		goto err_erase_id;
 	}
 
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
2.38.1

