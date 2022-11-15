Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0F5629256
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232380AbiKOHRw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:17:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbiKOHRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:17:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C227D1DF05;
        Mon, 14 Nov 2022 23:17:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 77BEDB816E1;
        Tue, 15 Nov 2022 07:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19C2C433C1;
        Tue, 15 Nov 2022 07:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668496653;
        bh=H6ycuvdmMnn4fzX+ZhFbcKEoEHYAguQOKDxX4bdPxmU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K8Iu51xsk/uma9VXUC+KtCaKc2k728Hhu9iT9hakP+zjNbkf1Sm0z0curl0rL/35R
         PocaKKjpqrbp1nxraFy82R+x8FNWAmWrYRmzkDWtc1nijLQnzpjQnga5Er6HM1Zgqu
         UE0K+IhEiOpnSK2Ne/d9u/HKuE5mjx0j3/hW33KGErn967xK8DSF6p/WJHHierWd7k
         tQ0qy4XFdHSzoyYOiCAfd5j5sO7nu09fGYfA4X3yr7ZpLZvNOQ/Xg4aE1h53V1E+zU
         nWZUP4SxrvjrUrN11IqTyVScrhmx3braNGbRgsdCkbdpdK2Z6qxdNHizNUKJUVamPk
         2KW6vf9csSJyA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>
Subject: [PATCH 4/4] tty: serial: altera_jtaguart: remove struct altera_jtaguart
Date:   Tue, 15 Nov 2022 08:17:24 +0100
Message-Id: <20221115071724.5185-4-jirislaby@kernel.org>
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

It contains only struct uart_port, so no need for another structure.
Remove it and convert the rest to use struct uart_port directly.

Cc: Tobias Klauser <tklauser@distanz.ch>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/altera_jtaguart.c | 29 +++++++++-------------------
 1 file changed, 9 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index 6808abd27785..9f843d1cee40 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -50,13 +50,6 @@
 #define ALTERA_JTAGUART_CONTROL_AC_MSK		0x00000400
 #define ALTERA_JTAGUART_CONTROL_WSPACE_MSK	0xFFFF0000
 
-/*
- * Local per-uart structure.
- */
-struct altera_jtaguart {
-	struct uart_port port;
-};
-
 static unsigned int altera_jtaguart_tx_space(struct uart_port *port, u32 *ctlp)
 {
 	u32 ctl = readl(port->membase + ALTERA_JTAGUART_CONTROL_REG);
@@ -115,9 +108,8 @@ static void altera_jtaguart_set_termios(struct uart_port *port,
 		tty_termios_copy_hw(termios, old);
 }
 
-static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
+static void altera_jtaguart_rx_chars(struct uart_port *port)
 {
-	struct uart_port *port = &pp->port;
 	unsigned char ch;
 	unsigned long status;
 
@@ -134,9 +126,8 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
 	tty_flip_buffer_push(&port->state->port);
 }
 
-static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
+static void altera_jtaguart_tx_chars(struct uart_port *port)
 {
-	struct uart_port *port = &pp->port;
 	unsigned int count;
 	u8 ch;
 
@@ -151,8 +142,6 @@ static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
 static irqreturn_t altera_jtaguart_interrupt(int irq, void *data)
 {
 	struct uart_port *port = data;
-	struct altera_jtaguart *pp =
-	    container_of(port, struct altera_jtaguart, port);
 	unsigned int isr;
 
 	isr = (readl(port->membase + ALTERA_JTAGUART_CONTROL_REG) >>
@@ -161,9 +150,9 @@ static irqreturn_t altera_jtaguart_interrupt(int irq, void *data)
 	spin_lock(&port->lock);
 
 	if (isr & ALTERA_JTAGUART_CONTROL_RE_MSK)
-		altera_jtaguart_rx_chars(pp);
+		altera_jtaguart_rx_chars(port);
 	if (isr & ALTERA_JTAGUART_CONTROL_WE_MSK)
-		altera_jtaguart_tx_chars(pp);
+		altera_jtaguart_tx_chars(port);
 
 	spin_unlock(&port->lock);
 
@@ -265,7 +254,7 @@ static const struct uart_ops altera_jtaguart_ops = {
 };
 
 #define ALTERA_JTAGUART_MAXPORTS 1
-static struct altera_jtaguart altera_jtaguart_ports[ALTERA_JTAGUART_MAXPORTS];
+static struct uart_port altera_jtaguart_ports[ALTERA_JTAGUART_MAXPORTS];
 
 #if defined(CONFIG_SERIAL_ALTERA_JTAGUART_CONSOLE)
 
@@ -308,7 +297,7 @@ static void altera_jtaguart_console_putc(struct uart_port *port, unsigned char c
 static void altera_jtaguart_console_write(struct console *co, const char *s,
 					  unsigned int count)
 {
-	struct uart_port *port = &(altera_jtaguart_ports + co->index)->port;
+	struct uart_port *port = &altera_jtaguart_ports[co->index];
 
 	uart_console_write(port, s, count, altera_jtaguart_console_putc);
 }
@@ -320,7 +309,7 @@ static int __init altera_jtaguart_console_setup(struct console *co,
 
 	if (co->index < 0 || co->index >= ALTERA_JTAGUART_MAXPORTS)
 		return -EINVAL;
-	port = &altera_jtaguart_ports[co->index].port;
+	port = &altera_jtaguart_ports[co->index];
 	if (port->membase == NULL)
 		return -ENODEV;
 	return 0;
@@ -400,7 +389,7 @@ static int altera_jtaguart_probe(struct platform_device *pdev)
 	if (i >= ALTERA_JTAGUART_MAXPORTS)
 		return -EINVAL;
 
-	port = &altera_jtaguart_ports[i].port;
+	port = &altera_jtaguart_ports[i];
 
 	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	if (res_mem)
@@ -444,7 +433,7 @@ static int altera_jtaguart_remove(struct platform_device *pdev)
 	if (i == -1)
 		i = 0;
 
-	port = &altera_jtaguart_ports[i].port;
+	port = &altera_jtaguart_ports[i];
 	uart_remove_one_port(&altera_jtaguart_driver, port);
 	iounmap(port->membase);
 
-- 
2.38.1

