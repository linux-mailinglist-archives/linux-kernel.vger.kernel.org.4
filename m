Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB95E63528E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbiKWI2C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236569AbiKWI1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:27:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DCAB8C;
        Wed, 23 Nov 2022 00:27:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB15561B13;
        Wed, 23 Nov 2022 08:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAABDC433C1;
        Wed, 23 Nov 2022 08:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669192061;
        bh=2ofp/BMPjwg+BMvx/7faulMyTjPJEKpup6ALMxyJL58=;
        h=From:To:Cc:Subject:Date:From;
        b=WJjXJ2whn+6+lj2hNLVPETN8pcvKGKN/7RZr09IksU6GqhO4uboDzNGmG07PzA6Xn
         3TZFVMavwDUNBC/lZQm8Mq87b3kDb2M22FtR0JIuGTubD9vS6FiW2ZtNEf3eb2LDrj
         q+LN3LFj5KNruZDDkaebHcbVofdqt6OcPUCsmqnh8r114pwzYSbV9q0WE2tRMwSt88
         VF9QY6iUH6D0XLJt4NqY9zVonmVsWAWShywx9FXniazaV7GL2yTbfINhBZ1LoLe8wJ
         r9wSoo1YNN3IOOGCQLBqCAKbPS3fbre9YW4s3Box8UYDU5qG9XwVlw3l6O5QS0+3NT
         4PGcFZAly+Xaw==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org,
        Michael Walle <michael@walle.cc>
Subject: [PATCH 1/2] serial: atmel: cleanup atmel_start+stop_tx()
Date:   Wed, 23 Nov 2022 09:27:35 +0100
Message-Id: <20221123082736.24566-1-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
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

Define local variables holding information about whether pdc or dma is
used in the HW. These are retested several times by calls to
atmel_use_pdc_tx() and atmel_use_dma_tx(). So to make the code more
readable, simply cache the values.

This is also a preparatory patch for the next one (where is_pdc is used
once more in atmel_stop_tx()).

Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/atmel_serial.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 4ca04676c406..65f63dccfd72 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -552,8 +552,9 @@ static u_int atmel_get_mctrl(struct uart_port *port)
 static void atmel_stop_tx(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	bool is_pdc = atmel_use_pdc_tx(port);
 
-	if (atmel_use_pdc_tx(port)) {
+	if (is_pdc) {
 		/* disable PDC transmit */
 		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
 	}
@@ -572,7 +573,6 @@ static void atmel_stop_tx(struct uart_port *port)
 	if (atmel_uart_is_half_duplex(port))
 		if (!atomic_read(&atmel_port->tasklet_shutdown))
 			atmel_start_rx(port);
-
 }
 
 /*
@@ -581,20 +581,22 @@ static void atmel_stop_tx(struct uart_port *port)
 static void atmel_start_tx(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	bool is_pdc = atmel_use_pdc_tx(port);
+	bool is_dma = is_pdc || atmel_use_dma_tx(port);
 
-	if (atmel_use_pdc_tx(port) && (atmel_uart_readl(port, ATMEL_PDC_PTSR)
+	if (is_pdc && (atmel_uart_readl(port, ATMEL_PDC_PTSR)
 				       & ATMEL_PDC_TXTEN))
 		/* The transmitter is already running.  Yes, we
 		   really need this.*/
 		return;
 
-	if (atmel_use_pdc_tx(port) || atmel_use_dma_tx(port))
-		if (atmel_uart_is_half_duplex(port))
-			atmel_stop_rx(port);
+	if (is_dma && atmel_uart_is_half_duplex(port))
+		atmel_stop_rx(port);
 
-	if (atmel_use_pdc_tx(port))
+	if (is_pdc) {
 		/* re-enable PDC transmit */
 		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTEN);
+	}
 
 	/* Enable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
-- 
2.38.1

