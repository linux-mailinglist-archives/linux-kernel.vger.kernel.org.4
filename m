Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C66F5F4109
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJDKtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJDKtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:49:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129902ADD;
        Tue,  4 Oct 2022 03:49:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44FDCB819C1;
        Tue,  4 Oct 2022 10:49:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C87FFC433D6;
        Tue,  4 Oct 2022 10:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664880577;
        bh=m8tfkarc/U/e4Iyh3eMuKRiHdieKiSSYFFKUNs0aLlI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LZsS1DYQEOogdUehVO/d65sA//M8BaO5ZBzs+CNzw5ypWSKFsCIeNza+u5VTkqVjl
         YZvaOaEKRaEut9+oDIMn0KVWowG3prdR6X6TDq4ozS/miGodofiRP+Rta0cd82NVmk
         AIQM6ZKxMiw63KokdClk5F7mHeSjlCyFMnVv1uMdaWPmKnTrpLXx0FJItF8WqBF4XX
         WfoFiEmGV1B0LmIt1FNlg6HZC+GFgxlxQdUK6X1QP1UOws+5MkeQN+B4akLpoYtMFb
         i3CWmhUCapJ8BCY2Xdz/g0awtvgm4KLVcC/2bMX8Ojq2alipQK3A87Zp2DaOAhDzC9
         WRYzw04F95k+g==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Tobias Klauser <tklauser@distanz.ch>,
        Richard Genoud <richard.genoud@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 2/3] tty: serial: use uart_port_tx() helper
Date:   Tue,  4 Oct 2022 12:49:26 +0200
Message-Id: <20221004104927.14361-3-jirislaby@kernel.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20221004104927.14361-1-jirislaby@kernel.org>
References: <20221004104927.14361-1-jirislaby@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

uart_port_tx() is a new helper to send characters to the device. Use it
in these drivers.

Cc: Tobias Klauser <tklauser@distanz.ch>
Cc: Richard Genoud <richard.genoud@gmail.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: Vladimir Zapolskiy <vz@mleia.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: "Andreas Färber" <afaerber@suse.de>
Cc: Manivannan Sadhasivam <mani@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v5] use bool pending in mcf_tx_chars() too [Ilpo]
    
    [v4] switch from DEFINE_UART_PORT_TX_HELPER() (helper generator) to
         uart_port_tx() (akin to wait_event())
    
    [v3] remove stray \n removal (Ilpo)

 drivers/tty/serial/altera_uart.c   | 29 ++++------------------
 drivers/tty/serial/atmel_serial.c  | 28 +++++----------------
 drivers/tty/serial/fsl_lpuart.c    | 30 ++++-------------------
 drivers/tty/serial/lantiq.c        | 36 +++------------------------
 drivers/tty/serial/lpc32xx_hs.c    | 33 +++----------------------
 drivers/tty/serial/mcf.c           | 34 ++++++--------------------
 drivers/tty/serial/mpc52xx_uart.c  | 39 +++---------------------------
 drivers/tty/serial/mps2-uart.c     | 26 +++-----------------
 drivers/tty/serial/mxs-auart.c     | 32 ++++++------------------
 drivers/tty/serial/owl-uart.c      | 32 +++---------------------
 drivers/tty/serial/sa1100.c        | 34 +++-----------------------
 drivers/tty/serial/vt8500_serial.c | 30 +++--------------------
 12 files changed, 60 insertions(+), 323 deletions(-)

diff --git a/drivers/tty/serial/altera_uart.c b/drivers/tty/serial/altera_uart.c
index 82f2790de28d..316074bb23e9 100644
--- a/drivers/tty/serial/altera_uart.c
+++ b/drivers/tty/serial/altera_uart.c
@@ -247,31 +247,12 @@ static void altera_uart_rx_chars(struct uart_port *port)
 
 static void altera_uart_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if (port->x_char) {
-		/* Send special char - probably flow control */
-		altera_uart_writel(port, port->x_char, ALTERA_UART_TXDATA_REG);
-		port->x_char = 0;
-		port->icount.tx++;
-		return;
-	}
-
-	while (altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
-	       ALTERA_UART_STATUS_TRDY_MSK) {
-		if (xmit->head == xmit->tail)
-			break;
-		altera_uart_writel(port, xmit->buf[xmit->tail],
-		       ALTERA_UART_TXDATA_REG);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		altera_uart_stop_tx(port);
+	uart_port_tx(port, ch,
+		altera_uart_readl(port, ALTERA_UART_STATUS_REG) &
+		                ALTERA_UART_STATUS_TRDY_MSK,
+		altera_uart_writel(port, ch, ALTERA_UART_TXDATA_REG));
 }
 
 static irqreturn_t altera_uart_interrupt(int irq, void *data)
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index bd07f79a2df9..a6b4d30c5888 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -824,30 +824,14 @@ static void atmel_rx_chars(struct uart_port *port)
  */
 static void atmel_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
 	struct atmel_uart_port *atmel_port = to_atmel_uart_port(port);
+	bool pending;
+	u8 ch;
 
-	if (port->x_char &&
-	    (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY)) {
-		atmel_uart_write_char(port, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
-		return;
-
-	while (atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY) {
-		atmel_uart_write_char(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (!uart_circ_empty(xmit)) {
+	pending = uart_port_tx(port, ch,
+		atmel_uart_readl(port, ATMEL_US_CSR) & ATMEL_US_TXRDY,
+		atmel_uart_write_char(port, ch));
+	if (pending) {
 		/* we still have characters to transmit, so we should continue
 		 * transmitting them when TX is ready, regardless of
 		 * mode or duplexity
diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 67fa113f77d4..d811eda1844e 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -742,32 +742,12 @@ static int lpuart32_poll_get_char(struct uart_port *port)
 
 static inline void lpuart_transmit_buffer(struct lpuart_port *sport)
 {
-	struct circ_buf *xmit = &sport->port.state->xmit;
-
-	if (sport->port.x_char) {
-		writeb(sport->port.x_char, sport->port.membase + UARTDR);
-		sport->port.icount.tx++;
-		sport->port.x_char = 0;
-		return;
-	}
-
-	if (lpuart_stopped_or_empty(&sport->port)) {
-		lpuart_stop_tx(&sport->port);
-		return;
-	}
-
-	while (!uart_circ_empty(xmit) &&
-		(readb(sport->port.membase + UARTTCFIFO) < sport->txfifo_size)) {
-		writeb(xmit->buf[xmit->tail], sport->port.membase + UARTDR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
+	struct uart_port *port = &sport->port;
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		lpuart_stop_tx(&sport->port);
+	uart_port_tx(port, ch,
+		readb(port->membase + UARTTCFIFO) < sport->txfifo_size,
+		writeb(ch, port->membase + UARTDR));
 }
 
 static inline void lpuart32_transmit_buffer(struct lpuart_port *sport)
diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index c892f3c7d1ab..a58e9277dfad 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -95,7 +95,6 @@
 #define ASCFSTAT_TXFFLMASK	0x3F00
 #define ASCFSTAT_TXFREEMASK	0x3F000000
 
-static void lqasc_tx_chars(struct uart_port *port);
 static struct ltq_uart_port *lqasc_port[MAXPORTS];
 static struct uart_driver lqasc_reg;
 
@@ -151,9 +150,12 @@ lqasc_start_tx(struct uart_port *port)
 {
 	unsigned long flags;
 	struct ltq_uart_port *ltq_port = to_ltq_uart_port(port);
+	u8 ch;
 
 	spin_lock_irqsave(&ltq_port->lock, flags);
-	lqasc_tx_chars(port);
+	uart_port_tx(port, ch,
+		lqasc_tx_ready(port),
+		writeb(ch, port->membase + LTQ_ASC_TBUF));
 	spin_unlock_irqrestore(&ltq_port->lock, flags);
 	return;
 }
@@ -226,36 +228,6 @@ lqasc_rx_chars(struct uart_port *port)
 	return 0;
 }
 
-static void
-lqasc_tx_chars(struct uart_port *port)
-{
-	struct circ_buf *xmit = &port->state->xmit;
-	if (uart_tx_stopped(port)) {
-		lqasc_stop_tx(port);
-		return;
-	}
-
-	while (lqasc_tx_ready(port)) {
-		if (port->x_char) {
-			writeb(port->x_char, port->membase + LTQ_ASC_TBUF);
-			port->icount.tx++;
-			port->x_char = 0;
-			continue;
-		}
-
-		if (uart_circ_empty(xmit))
-			break;
-
-		writeb(port->state->xmit.buf[port->state->xmit.tail],
-			port->membase + LTQ_ASC_TBUF);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-}
-
 static irqreturn_t
 lqasc_tx_int(int irq, void *_port)
 {
diff --git a/drivers/tty/serial/lpc32xx_hs.c b/drivers/tty/serial/lpc32xx_hs.c
index ed47f4768338..b38fe4728c26 100644
--- a/drivers/tty/serial/lpc32xx_hs.c
+++ b/drivers/tty/serial/lpc32xx_hs.c
@@ -276,8 +276,6 @@ static void __serial_lpc32xx_rx(struct uart_port *port)
 	tty_flip_buffer_push(tport);
 }
 
-static void serial_lpc32xx_stop_tx(struct uart_port *port);
-
 static bool serial_lpc32xx_tx_ready(struct uart_port *port)
 {
 	u32 level = readl(LPC32XX_HSUART_LEVEL(port->membase));
@@ -287,34 +285,11 @@ static bool serial_lpc32xx_tx_ready(struct uart_port *port)
 
 static void __serial_lpc32xx_tx(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if (port->x_char) {
-		writel((u32)port->x_char, LPC32XX_HSUART_FIFO(port->membase));
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port))
-		goto exit_tx;
-
-	/* Transfer data */
-	while (serial_lpc32xx_tx_ready(port)) {
-		writel((u32) xmit->buf[xmit->tail],
-		       LPC32XX_HSUART_FIFO(port->membase));
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-exit_tx:
-	if (uart_circ_empty(xmit))
-		serial_lpc32xx_stop_tx(port);
+	uart_port_tx(port, ch,
+		serial_lpc32xx_tx_ready(port),
+		writel(ch, LPC32XX_HSUART_FIFO(port->membase)));
 }
 
 static irqreturn_t serial_lpc32xx_interrupt(int irq, void *dev_id)
diff --git a/drivers/tty/serial/mcf.c b/drivers/tty/serial/mcf.c
index b1cd9a76dd93..3239babe12a4 100644
--- a/drivers/tty/serial/mcf.c
+++ b/drivers/tty/serial/mcf.c
@@ -327,34 +327,16 @@ static void mcf_rx_chars(struct mcf_uart *pp)
 static void mcf_tx_chars(struct mcf_uart *pp)
 {
 	struct uart_port *port = &pp->port;
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if (port->x_char) {
-		/* Send special char - probably flow control */
-		writeb(port->x_char, port->membase + MCFUART_UTB);
-		port->x_char = 0;
-		port->icount.tx++;
-		return;
-	}
-
-	while (readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY) {
-		if (uart_circ_empty(xmit))
-			break;
-		writeb(xmit->buf[xmit->tail], port->membase + MCFUART_UTB);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE -1);
-		port->icount.tx++;
-	}
+	bool pending;
+	u8 ch;
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	pending = uart_port_tx(port, ch,
+		readb(port->membase + MCFUART_USR) & MCFUART_USR_TXREADY,
+		writeb(ch, port->membase + MCFUART_UTB));
 
-	if (uart_circ_empty(xmit)) {
-		mcf_stop_tx(port);
-		/* Disable TX to negate RTS automatically */
-		if (port->rs485.flags & SER_RS485_ENABLED)
-			writeb(MCFUART_UCR_TXDISABLE,
-				port->membase + MCFUART_UCR);
-	}
+	/* Disable TX to negate RTS automatically */
+	if (!pending && (port->rs485.flags & SER_RS485_ENABLED))
+		writeb(MCFUART_UCR_TXDISABLE, port->membase + MCFUART_UCR);
 }
 
 /****************************************************************************/
diff --git a/drivers/tty/serial/mpc52xx_uart.c b/drivers/tty/serial/mpc52xx_uart.c
index 73362d4bc45d..384ca195e3d5 100644
--- a/drivers/tty/serial/mpc52xx_uart.c
+++ b/drivers/tty/serial/mpc52xx_uart.c
@@ -1428,42 +1428,11 @@ mpc52xx_uart_int_rx_chars(struct uart_port *port)
 static inline bool
 mpc52xx_uart_int_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-
-	/* Process out of band chars */
-	if (port->x_char) {
-		psc_ops->write_char(port, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return true;
-	}
-
-	/* Nothing to do ? */
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		mpc52xx_uart_stop_tx(port);
-		return false;
-	}
-
-	/* Send chars */
-	while (psc_ops->raw_tx_rdy(port)) {
-		psc_ops->write_char(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	/* Wake up */
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	/* Maybe we're done after all */
-	if (uart_circ_empty(xmit)) {
-		mpc52xx_uart_stop_tx(port);
-		return false;
-	}
+	u8 ch;
 
-	return true;
+	return uart_port_tx(port, ch,
+		psc_ops->raw_tx_rdy(port),
+		psc_ops->write_char(port, ch));
 }
 
 static irqreturn_t
diff --git a/drivers/tty/serial/mps2-uart.c b/drivers/tty/serial/mps2-uart.c
index 2e3e6cf16817..860d161fa594 100644
--- a/drivers/tty/serial/mps2-uart.c
+++ b/drivers/tty/serial/mps2-uart.c
@@ -129,29 +129,11 @@ static void mps2_uart_stop_tx(struct uart_port *port)
 
 static void mps2_uart_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-
-	while (!(mps2_uart_read8(port, UARTn_STATE) & UARTn_STATE_TX_FULL)) {
-		if (port->x_char) {
-			mps2_uart_write8(port, port->x_char, UARTn_DATA);
-			port->x_char = 0;
-			port->icount.tx++;
-			continue;
-		}
-
-		if (uart_circ_empty(xmit) || uart_tx_stopped(port))
-			break;
-
-		mps2_uart_write8(port, xmit->buf[xmit->tail], UARTn_DATA);
-		xmit->tail = (xmit->tail + 1) % UART_XMIT_SIZE;
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		mps2_uart_stop_tx(port);
+	uart_port_tx(port, ch,
+		mps2_uart_tx_empty(port),
+		mps2_uart_write8(port, ch, UARTn_DATA));
 }
 
 static void mps2_uart_start_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d21a4f3ef2fe..ef6e7bb6105c 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -569,6 +569,8 @@ static int mxs_auart_dma_tx(struct mxs_auart_port *s, int size)
 static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 {
 	struct circ_buf *xmit = &s->port.state->xmit;
+	bool pending;
+	u8 ch;
 
 	if (auart_dma_enabled(s)) {
 		u32 i = 0;
@@ -603,31 +605,13 @@ static void mxs_auart_tx_chars(struct mxs_auart_port *s)
 		return;
 	}
 
-
-	while (!(mxs_read(s, REG_STAT) & AUART_STAT_TXFF)) {
-		if (s->port.x_char) {
-			s->port.icount.tx++;
-			mxs_write(s->port.x_char, s, REG_DATA);
-			s->port.x_char = 0;
-			continue;
-		}
-		if (!uart_circ_empty(xmit) && !uart_tx_stopped(&s->port)) {
-			s->port.icount.tx++;
-			mxs_write(xmit->buf[xmit->tail], s, REG_DATA);
-			xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		} else
-			break;
-	}
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&s->port);
-
-	if (uart_circ_empty(&(s->port.state->xmit)))
-		mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
-	else
+	pending = uart_port_tx(&s->port, ch,
+		!(mxs_read(s, REG_STAT) & AUART_STAT_TXFF),
+		mxs_write(ch, s, REG_DATA));
+	if (pending)
 		mxs_set(AUART_INTR_TXIEN, s, REG_INTR);
-
-	if (uart_tx_stopped(&s->port))
-		mxs_auart_stop_tx(&s->port);
+	else
+		mxs_clr(AUART_INTR_TXIEN, s, REG_INTR);
 }
 
 static void mxs_auart_rx_char(struct mxs_auart_port *s)
diff --git a/drivers/tty/serial/owl-uart.c b/drivers/tty/serial/owl-uart.c
index fde39cc1145d..e99970a9437f 100644
--- a/drivers/tty/serial/owl-uart.c
+++ b/drivers/tty/serial/owl-uart.c
@@ -181,35 +181,11 @@ static void owl_uart_start_tx(struct uart_port *port)
 
 static void owl_uart_send_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int ch;
-
-	if (port->x_char) {
-		while (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU))
-			cpu_relax();
-		owl_uart_write(port, port->x_char, OWL_UART_TXDAT);
-		port->icount.tx++;
-		port->x_char = 0;
-	}
-
-	if (uart_tx_stopped(port))
-		return;
-
-	while (!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU)) {
-		if (uart_circ_empty(xmit))
-			break;
+	u8 ch;
 
-		ch = xmit->buf[xmit->tail];
-		owl_uart_write(port, ch, OWL_UART_TXDAT);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		owl_uart_stop_tx(port);
+	uart_port_tx(port, ch,
+		!(owl_uart_read(port, OWL_UART_STAT) & OWL_UART_STAT_TFFU),
+		owl_uart_write(port, ch, OWL_UART_TXDAT));
 }
 
 static void owl_uart_receive_chars(struct uart_port *port)
diff --git a/drivers/tty/serial/sa1100.c b/drivers/tty/serial/sa1100.c
index dd9e3253cab4..55107bbc00ce 100644
--- a/drivers/tty/serial/sa1100.c
+++ b/drivers/tty/serial/sa1100.c
@@ -228,14 +228,7 @@ sa1100_rx_chars(struct sa1100_port *sport)
 
 static void sa1100_tx_chars(struct sa1100_port *sport)
 {
-	struct circ_buf *xmit = &sport->port.state->xmit;
-
-	if (sport->port.x_char) {
-		UART_PUT_CHAR(sport, sport->port.x_char);
-		sport->port.icount.tx++;
-		sport->port.x_char = 0;
-		return;
-	}
+	u8 ch;
 
 	/*
 	 * Check the modem control lines before
@@ -243,28 +236,9 @@ static void sa1100_tx_chars(struct sa1100_port *sport)
 	 */
 	sa1100_mctrl_check(sport);
 
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&sport->port)) {
-		sa1100_stop_tx(&sport->port);
-		return;
-	}
-
-	/*
-	 * Tried using FIFO (not checking TNF) for fifo fill:
-	 * still had the '4 bytes repeated' problem.
-	 */
-	while (UART_GET_UTSR1(sport) & UTSR1_TNF) {
-		UART_PUT_CHAR(sport, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		sport->port.icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&sport->port);
-
-	if (uart_circ_empty(xmit))
-		sa1100_stop_tx(&sport->port);
+	uart_port_tx(&sport->port, ch,
+			UART_GET_UTSR1(sport) & UTSR1_TNF,
+			UART_PUT_CHAR(sport, ch));
 }
 
 static irqreturn_t sa1100_int(int irq, void *dev_id)
diff --git a/drivers/tty/serial/vt8500_serial.c b/drivers/tty/serial/vt8500_serial.c
index 10fbdb09965f..deedb6513160 100644
--- a/drivers/tty/serial/vt8500_serial.c
+++ b/drivers/tty/serial/vt8500_serial.c
@@ -196,33 +196,11 @@ static unsigned int vt8500_tx_empty(struct uart_port *port)
 
 static void handle_tx(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
+	u8 ch;
 
-	if (port->x_char) {
-		writeb(port->x_char, port->membase + VT8500_TXFIFO);
-		port->icount.tx++;
-		port->x_char = 0;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		vt8500_stop_tx(port);
-		return;
-	}
-
-	while (vt8500_tx_empty(port)) {
-		if (uart_circ_empty(xmit))
-			break;
-
-		writeb(xmit->buf[xmit->tail], port->membase + VT8500_TXFIFO);
-
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		vt8500_stop_tx(port);
+	uart_port_tx(port, ch,
+		vt8500_tx_empty(port),
+		writeb(ch, port->membase + VT8500_TXFIFO));
 }
 
 static void vt8500_start_tx(struct uart_port *port)
-- 
2.37.3

