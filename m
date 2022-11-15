Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22126629255
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:17:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbiKOHRs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:17:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiKOHRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:17:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D36F1DF07;
        Mon, 14 Nov 2022 23:17:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2ADAB816E3;
        Tue, 15 Nov 2022 07:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3516CC433D7;
        Tue, 15 Nov 2022 07:17:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668496651;
        bh=ySbf5OGqnLlT6+c5XgtGYdkxj8KjA4c0fKuJpbK+Xa8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wo3YGIGoImxD2R2QnuP0u57S+zV8/mH+JYkL1bRXG8eVtmO1Azn4BwldRFM43gzoI
         u7ooUUY0c+seV9RinkoH0WjKV+FNzA9r9kQomNUPhQpsb5svlkARiZA/Yox3XHgqgh
         y7U+LDT5npwH9jVY1taWmP7hf9sv1EFh/Zy9waYuemMDwLjlTrFPXsrZ9BkfQgvSWA
         FXdvbkyJdIKk37BKZBAkkb8agytP3uU8XUOY2YkTr9PsVeHyMrmT2Ufx9eC/Om8Dqf
         PjR56200TJ/9m5csISkbaxXg81klMus4xZywT6V+svYAd88ochkr1csH+cBXCP5mv4
         REAMkaKw7chzQ==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 3/4] tty: serial: altera_jtaguart: use uart_port::read_status_mask
Date:   Tue, 15 Nov 2022 08:17:23 +0100
Message-Id: <20221115071724.5185-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115071724.5185-1-jirislaby@kernel.org>
References: <20221115071724.5185-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of self-defined struct altera_jtaguart::imr, use preexisting
uart_port::read_status_mask.

Note that imr was ulong. But there is no reason for that, its values are
uints. And readl/writel's are used to read it/write to it.

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/altera_jtaguart.c | 41 +++++++++++-----------------
 1 file changed, 16 insertions(+), 25 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index b83eade64b22..6808abd27785 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -55,7 +55,6 @@
  */
 struct altera_jtaguart {
 	struct uart_port port;
-	unsigned long imr;	/* Local IMR mirror */
 };
 
 static unsigned int altera_jtaguart_tx_space(struct uart_port *port, u32 *ctlp)
@@ -84,29 +83,23 @@ static void altera_jtaguart_set_mctrl(struct uart_port *port, unsigned int sigs)
 
 static void altera_jtaguart_start_tx(struct uart_port *port)
 {
-	struct altera_jtaguart *pp =
-	    container_of(port, struct altera_jtaguart, port);
-
-	pp->imr |= ALTERA_JTAGUART_CONTROL_WE_MSK;
-	writel(pp->imr, port->membase + ALTERA_JTAGUART_CONTROL_REG);
+	port->read_status_mask |= ALTERA_JTAGUART_CONTROL_WE_MSK;
+	writel(port->read_status_mask,
+			port->membase + ALTERA_JTAGUART_CONTROL_REG);
 }
 
 static void altera_jtaguart_stop_tx(struct uart_port *port)
 {
-	struct altera_jtaguart *pp =
-	    container_of(port, struct altera_jtaguart, port);
-
-	pp->imr &= ~ALTERA_JTAGUART_CONTROL_WE_MSK;
-	writel(pp->imr, port->membase + ALTERA_JTAGUART_CONTROL_REG);
+	port->read_status_mask &= ~ALTERA_JTAGUART_CONTROL_WE_MSK;
+	writel(port->read_status_mask,
+			port->membase + ALTERA_JTAGUART_CONTROL_REG);
 }
 
 static void altera_jtaguart_stop_rx(struct uart_port *port)
 {
-	struct altera_jtaguart *pp =
-	    container_of(port, struct altera_jtaguart, port);
-
-	pp->imr &= ~ALTERA_JTAGUART_CONTROL_RE_MSK;
-	writel(pp->imr, port->membase + ALTERA_JTAGUART_CONTROL_REG);
+	port->read_status_mask &= ~ALTERA_JTAGUART_CONTROL_RE_MSK;
+	writel(port->read_status_mask,
+			port->membase + ALTERA_JTAGUART_CONTROL_REG);
 }
 
 static void altera_jtaguart_break_ctl(struct uart_port *port, int break_state)
@@ -163,7 +156,7 @@ static irqreturn_t altera_jtaguart_interrupt(int irq, void *data)
 	unsigned int isr;
 
 	isr = (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) >>
-	       ALTERA_JTAGUART_CONTROL_RI_OFF) & pp->imr;
+	       ALTERA_JTAGUART_CONTROL_RI_OFF) & port->read_status_mask;
 
 	spin_lock(&port->lock);
 
@@ -187,8 +180,6 @@ static void altera_jtaguart_config_port(struct uart_port *port, int flags)
 
 static int altera_jtaguart_startup(struct uart_port *port)
 {
-	struct altera_jtaguart *pp =
-	    container_of(port, struct altera_jtaguart, port);
 	unsigned long flags;
 	int ret;
 
@@ -203,8 +194,9 @@ static int altera_jtaguart_startup(struct uart_port *port)
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Enable RX interrupts now */
-	pp->imr = ALTERA_JTAGUART_CONTROL_RE_MSK;
-	writel(pp->imr, port->membase + ALTERA_JTAGUART_CONTROL_REG);
+	port->read_status_mask = ALTERA_JTAGUART_CONTROL_RE_MSK;
+	writel(port->read_status_mask,
+			port->membase + ALTERA_JTAGUART_CONTROL_REG);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
@@ -213,15 +205,14 @@ static int altera_jtaguart_startup(struct uart_port *port)
 
 static void altera_jtaguart_shutdown(struct uart_port *port)
 {
-	struct altera_jtaguart *pp =
-	    container_of(port, struct altera_jtaguart, port);
 	unsigned long flags;
 
 	spin_lock_irqsave(&port->lock, flags);
 
 	/* Disable all interrupts now */
-	pp->imr = 0;
-	writel(pp->imr, port->membase + ALTERA_JTAGUART_CONTROL_REG);
+	port->read_status_mask = 0;
+	writel(port->read_status_mask,
+			port->membase + ALTERA_JTAGUART_CONTROL_REG);
 
 	spin_unlock_irqrestore(&port->lock, flags);
 
-- 
2.38.1

