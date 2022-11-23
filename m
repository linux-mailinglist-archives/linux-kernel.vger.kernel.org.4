Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA8B63528D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiKWI2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiKWI1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:27:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F494631A;
        Wed, 23 Nov 2022 00:27:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 19786B81EE4;
        Wed, 23 Nov 2022 08:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 962ACC433D7;
        Wed, 23 Nov 2022 08:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669192063;
        bh=+Gj9VY8s8NivuczNkGfzHn17+4LSQEt5i0IRoGeWmyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=leqf/6jLvGhj6Vo0mGKQlru4xbl5WhJElvBN0FT2SCaHSpIXBm1QJnND/RwqkHniX
         UN254aoLDitmLzn65QxcdHj5EBSIToN0XmuAPy72V3O6M8nXwOg45TEhQHsQma3LDd
         GTE2G4vT9X0qwAtea+cM0OiforWe7iGdwzNqS5xZXtJO/Dbx0HGDC57JT3GDMKt4HF
         8WgR4p2Gg2XFcX0idYJ13zhZSXSLALftFKnnxgIdKBOfHTHTTvpBEphEut479s0xbn
         Iq8ZGSNi+3TnA6vPAzeVDQ9cAI0QjRvcei38ZlEpOlB/o/JckE8hjRruwIUR/vGnNr
         7AnoR5oizfUmQ==
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
Subject: [PATCH 2/2] serial: atmel: don't stop the transmitter when doing PIO
Date:   Wed, 23 Nov 2022 09:27:36 +0100
Message-Id: <20221123082736.24566-2-jirislaby@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221123082736.24566-1-jirislaby@kernel.org>
References: <20221123082736.24566-1-jirislaby@kernel.org>
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

Writing ATMEL_US_TXDIS to ATMEL_US_CR makes the transmitter NOT to send
the just queued character. This means when the character is last and
uart calls ops->stop_tx(), the character is not sent at all.

The usart datasheet is not much specific on this, it just says the
transmitter is stopped. But apparently, the character is dropped. So
we should stop the transmitter only for DMA and PDC transfers to not
send any more characters. For PIO, this is unexpected and deviates from
other drivers. In particular, the below referenced commit broke TX as it
added a call to ->stop_tx() after the very last character written to the
transmitter.

So fix this by limiting the write of ATMEL_US_TXDIS to DMA transfers
only.

Even there, I don't know if it is correctly implemented. Are all the
queued characters sent once ->start_tx() is called? Anyone tested flow
control -- be it hard (RTSCTS) or the soft (XOFF/XON) one?

Fixes: 2d141e683e9a ("tty: serial: use uart_port_tx() helper")
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: linux-arm-kernel@lists.infradead.org
Reported-by: Michael Walle <michael@walle.cc>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/serial/atmel_serial.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 65f63dccfd72..f1c06e12efa0 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -553,19 +553,22 @@ static void atmel_stop_tx(struct uart_port *port)
 {
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
 	bool is_pdc = atmel_use_pdc_tx(port);
+	bool is_dma = is_pdc || atmel_use_dma_tx(port);
 
 	if (is_pdc) {
 		/* disable PDC transmit */
 		atmel_uart_writel(port, ATMEL_PDC_PTCR, ATMEL_PDC_TXTDIS);
 	}
 
-	/*
-	 * Disable the transmitter.
-	 * This is mandatory when DMA is used, otherwise the DMA buffer
-	 * is fully transmitted.
-	 */
-	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
-	atmel_port->tx_stopped = true;
+	if (is_dma) {
+		/*
+		 * Disable the transmitter.
+		 * This is mandatory when DMA is used, otherwise the DMA buffer
+		 * is fully transmitted.
+		 */
+		atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXDIS);
+		atmel_port->tx_stopped = true;
+	}
 
 	/* Disable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IDR, atmel_port->tx_done_mask);
@@ -601,9 +604,11 @@ static void atmel_start_tx(struct uart_port *port)
 	/* Enable interrupts */
 	atmel_uart_writel(port, ATMEL_US_IER, atmel_port->tx_done_mask);
 
-	/* re-enable the transmitter */
-	atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
-	atmel_port->tx_stopped = false;
+	if (is_dma) {
+		/* re-enable the transmitter */
+		atmel_uart_writel(port, ATMEL_US_CR, ATMEL_US_TXEN);
+		atmel_port->tx_stopped = false;
+	}
 }
 
 /*
-- 
2.38.1

