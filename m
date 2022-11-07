Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EFA61FAF4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 18:15:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiKGRPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 12:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232075AbiKGRPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 12:15:14 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409BC220C9;
        Mon,  7 Nov 2022 09:15:13 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id 8so7570008qka.1;
        Mon, 07 Nov 2022 09:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U5p80570qCVpx8wyPaQFV3qqLd7So3Af8EEHHd8G+ec=;
        b=g1n5ouBUfdzPqmzTo1aF2iinTR+GfBeVFFEgQhMtLO5h8ruxXyy5U1crM3BFJxWWv1
         VOf3KKcBCvg4RmX/EpaHPD5V2OmYTroM7P1fRX68lKzwUiB61SdVc4e57PrhugminAHm
         Ogms5IDkF8M2raN0pblemV2DBoR9ZWOeBYKjziqFudJlBqkn/i/Q180IBEbpDrnpB/PF
         ILvzOPjLjl7xa3Em49vR3kF/RKevJl7DcQAxh4p6IVKmpCzqHQxFhlTezyDHBJHArpSQ
         z4biNg6nwayzIktBvMaFimFcEvrzn4N0X4mHTzjFAtB+uMCauuzY1ULy8a7uKPMqsTVi
         fWVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U5p80570qCVpx8wyPaQFV3qqLd7So3Af8EEHHd8G+ec=;
        b=pmrYQJanWODME+yindp2rNzZwmNN7h9eWBmFQY8fECYHyPhif26qdoxLKIeSbCy6A2
         9704+Zr2rIUewdrACYtjw0O3mNp1vjnRyxj5zsDuijzGBcThxmXImBSchAXHIW4MVVKR
         0JhfoH+pOfgvbiGH4gaOrg3DtmRQFZhnY5lMfbtmLcVKWynisx0/pLyq10dk2RDnos3T
         jYmct67zIK/CgboYSIpZKL1DVmo3EBHebbVg/y02Fl7Ylc+I3ESHOTG6aIKwzdLpkfTu
         6GWq2H9PqMUbQNwBjZgXOOggjuEz030gFD64QciFVhQ9EUcleU52tAQQLYbCPWNna83n
         BZtA==
X-Gm-Message-State: ACrzQf0Ko8FDMMnhrcTdeTM0vkqs7iAg2EcJC0/W+Wv+O8FWudWB1x94
        IPClGEapzxIV9xFIBAM2o1jYNVj5Od67Bw==
X-Google-Smtp-Source: AMsMyM4TiQKsKhWsVl5nt4uilXsU/bvWyhNkW/RbVLY2RYjvWXp6qLWdbZDiCvLvTGAubgAzIsz23w==
X-Received: by 2002:a05:620a:f15:b0:6cf:1efa:3705 with SMTP id v21-20020a05620a0f1500b006cf1efa3705mr36279978qkl.439.1667841311795;
        Mon, 07 Nov 2022 09:15:11 -0800 (PST)
Received: from glsvmlin.ini.cmu.edu (GLSVMLIN.INI.CMU.EDU. [128.2.16.9])
        by smtp.gmail.com with ESMTPSA id az36-20020a05620a172400b006ce9e880c6fsm7333611qkb.111.2022.11.07.09.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 09:15:11 -0800 (PST)
From:   Gabriel Somlo <gsomlo@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-serial@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, kgugala@antmicro.com, mholenko@antmicro.com,
        joel@jms.id.au, david.abdurachmanov@sifive.com,
        florent@enjoy-digital.fr
Subject: [PATCH v1 3/3] serial: liteuart: add IRQ support
Date:   Mon,  7 Nov 2022 12:15:00 -0500
Message-Id: <20221107171500.2537938-4-gsomlo@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221107171500.2537938-1-gsomlo@gmail.com>
References: <20221107171500.2537938-1-gsomlo@gmail.com>
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
 drivers/tty/serial/liteuart.c | 65 +++++++++++++++++++++++++++++++----
 1 file changed, 58 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/liteuart.c b/drivers/tty/serial/liteuart.c
index 90a29ed79bff..47ce3ecc50f2 100644
--- a/drivers/tty/serial/liteuart.c
+++ b/drivers/tty/serial/liteuart.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/console.h>
+#include <linux/interrupt.h>
 #include <linux/litex.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -90,13 +91,27 @@ static void liteuart_rx_chars(struct uart_port *port)
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
 
@@ -165,19 +180,48 @@ static void liteuart_stop_rx(struct uart_port *port)
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
+				  DRV_NAME, port);
+		if (ret == 0) {
+			/* we only need interrupts on the rx path! */
+			irq_mask = EV_RX;
+		} else {
+			pr_err(DRV_NAME ": can't attach LiteUART %d irq=%d; "
+			       "switching to polling\n", port->line, port->irq);
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
@@ -266,6 +310,13 @@ static int liteuart_probe(struct platform_device *pdev)
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

