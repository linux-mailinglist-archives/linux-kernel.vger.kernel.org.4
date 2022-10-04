Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F376D5F410B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 12:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbiJDKuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 06:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiJDKto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 06:49:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA13C6420;
        Tue,  4 Oct 2022 03:49:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3DAC66134B;
        Tue,  4 Oct 2022 10:49:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BAE2C4347C;
        Tue,  4 Oct 2022 10:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664880581;
        bh=EiG7MLXpt/ieQf/scjf2AjsAsALEw0iDo5jOA5XLK1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PuVLtqtDLOT35uK/LKnFhKdO0kypUV5cjbuQpI1HoAo/jyjXpt0+wXMugbV9m+DH1
         rtjsLiAd/QPE3wrlBKsAgA8c8fLOQpgmoth5DWgiQddc779ITsKE5MbOjL9jis3Gus
         e+zgNVycSJbIax0Fzpu4RqkALLumzUjWKLO+R421G5GgutWK7Ut7RKt5NKPKhZu/S2
         BhXtJdVBlmMNHO5szSGb0i8jYIJaMtJvXSgif7/EcdNG2iKkegj7VbXe2SgmVKkcY5
         Lk6y5yk4YHUikyo2kUJ77MEAzmivbFTC3NEHc5Swhicqze11ubW4qA/2Qh1Tb1NPA8
         YhVI37WXg8xTA==
From:   "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-riscv@lists.infradead.org
Subject: [PATCH v5 3/3] tty: serial: use uart_port_tx_limited()
Date:   Tue,  4 Oct 2022 12:49:27 +0200
Message-Id: <20221004104927.14361-4-jirislaby@kernel.org>
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

uart_port_tx_limited() is a new helper to send characters to the device.
Use it in these drivers.

mux.c also needs to define tx_done(). But I'm not sure if the driver
really wants to wait for all the characters to dismiss from the HW fifo
at this code point. Hence I marked this as FIXME.

Cc: Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: bcm-kernel-feedback-list@broadcom.com
Cc: "Pali Rohár" <pali@kernel.org>
Cc: Kevin Cernekee <cernekee@gmail.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Orson Zhai <orsonzhai@gmail.com>
Cc: Baolin Wang <baolin.wang7@gmail.com>
Cc: Chunyan Zhang <zhang.lyra@gmail.com>
Cc: Patrice Chotard <patrice.chotard@foss.st.com>
Cc: linux-riscv@lists.infradead.org
Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---

Notes:
    [v4] switch from DEFINE_UART_PORT_TX_HELPER_LIMITED() (helper generator)
         to uart_port_tx_limited() (akin to wait_event())

 drivers/tty/serial/21285.c           | 32 +++----------------
 drivers/tty/serial/altera_jtaguart.c | 36 ++++-----------------
 drivers/tty/serial/amba-pl010.c      | 32 +++----------------
 drivers/tty/serial/apbuart.c         | 34 +++-----------------
 drivers/tty/serial/bcm63xx_uart.c    | 47 ++++++---------------------
 drivers/tty/serial/mux.c             | 45 ++++++++------------------
 drivers/tty/serial/mvebu-uart.c      | 38 +++-------------------
 drivers/tty/serial/omap-serial.c     | 32 +++----------------
 drivers/tty/serial/pxa.c             | 33 +++----------------
 drivers/tty/serial/rp2.c             | 31 ++++--------------
 drivers/tty/serial/serial_txx9.c     | 32 +++----------------
 drivers/tty/serial/sifive.c          | 31 +++---------------
 drivers/tty/serial/sprd_serial.c     | 33 +++----------------
 drivers/tty/serial/st-asc.c          | 48 +++-------------------------
 14 files changed, 85 insertions(+), 419 deletions(-)

diff --git a/drivers/tty/serial/21285.c b/drivers/tty/serial/21285.c
index c7d34823f715..185462fd959c 100644
--- a/drivers/tty/serial/21285.c
+++ b/drivers/tty/serial/21285.c
@@ -154,35 +154,13 @@ static irqreturn_t serial21285_rx_chars(int irq, void *dev_id)
 static irqreturn_t serial21285_tx_chars(int irq, void *dev_id)
 {
 	struct uart_port *port = dev_id;
-	struct circ_buf *xmit = &port->state->xmit;
-	int count = 256;
-
-	if (port->x_char) {
-		*CSR_UARTDR = port->x_char;
-		port->icount.tx++;
-		port->x_char = 0;
-		goto out;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		serial21285_stop_tx(port);
-		goto out;
-	}
-
-	do {
-		*CSR_UARTDR = xmit->buf[xmit->tail];
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0 && !(*CSR_UARTFLG & 0x20));
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		serial21285_stop_tx(port);
+	uart_port_tx_limited(port, ch, 256,
+		!(*CSR_UARTFLG & 0x20),
+		*CSR_UARTDR = ch,
+		({}));
 
- out:
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/tty/serial/altera_jtaguart.c b/drivers/tty/serial/altera_jtaguart.c
index c2d154d78e54..aa49553fac58 100644
--- a/drivers/tty/serial/altera_jtaguart.c
+++ b/drivers/tty/serial/altera_jtaguart.c
@@ -146,37 +146,15 @@ static void altera_jtaguart_rx_chars(struct altera_jtaguart *pp)
 static void altera_jtaguart_tx_chars(struct altera_jtaguart *pp)
 {
 	struct uart_port *port = &pp->port;
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int pending, count;
-
-	if (port->x_char) {
-		/* Send special char - probably flow control */
-		writel(port->x_char, port->membase + ALTERA_JTAGUART_DATA_REG);
-		port->x_char = 0;
-		port->icount.tx++;
-		return;
-	}
+	unsigned int count;
+	u8 ch;
 
-	pending = uart_circ_chars_pending(xmit);
-	if (pending > 0) {
-		count = altera_jtaguart_tx_space(port, NULL);
-		if (count > pending)
-			count = pending;
-		if (count > 0) {
-			pending -= count;
-			while (count--) {
-				writel(xmit->buf[xmit->tail],
-				       port->membase + ALTERA_JTAGUART_DATA_REG);
-				xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-				port->icount.tx++;
-			}
-			if (pending < WAKEUP_CHARS)
-				uart_write_wakeup(port);
-		}
-	}
+	count = altera_jtaguart_tx_space(port, NULL);
 
-	if (pending == 0)
-		altera_jtaguart_stop_tx(port);
+	uart_port_tx_limited(port, ch, count,
+		true,
+		writel(ch, port->membase + ALTERA_JTAGUART_DATA_REG),
+		({}));
 }
 
 static irqreturn_t altera_jtaguart_interrupt(int irq, void *data)
diff --git a/drivers/tty/serial/amba-pl010.c b/drivers/tty/serial/amba-pl010.c
index af27fb8ec145..a98fae2ca422 100644
--- a/drivers/tty/serial/amba-pl010.c
+++ b/drivers/tty/serial/amba-pl010.c
@@ -164,34 +164,12 @@ static void pl010_rx_chars(struct uart_port *port)
 
 static void pl010_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	int count;
+	u8 ch;
 
-	if (port->x_char) {
-		writel(port->x_char, port->membase + UART01x_DR);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		pl010_stop_tx(port);
-		return;
-	}
-
-	count = port->fifosize >> 1;
-	do {
-		writel(xmit->buf[xmit->tail], port->membase + UART01x_DR);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		pl010_stop_tx(port);
+	uart_port_tx_limited(port, ch, port->fifosize >> 1,
+		true,
+		writel(ch, port->membase + UART01x_DR),
+		({}));
 }
 
 static void pl010_modem_status(struct uart_amba_port *uap)
diff --git a/drivers/tty/serial/apbuart.c b/drivers/tty/serial/apbuart.c
index 450f4edfda0f..915ee4b0d594 100644
--- a/drivers/tty/serial/apbuart.c
+++ b/drivers/tty/serial/apbuart.c
@@ -122,36 +122,12 @@ static void apbuart_rx_chars(struct uart_port *port)
 
 static void apbuart_tx_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	int count;
-
-	if (port->x_char) {
-		UART_PUT_CHAR(port, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		apbuart_stop_tx(port);
-		return;
-	}
-
-	/* amba: fill FIFO */
-	count = port->fifosize >> 1;
-	do {
-		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		apbuart_stop_tx(port);
+	uart_port_tx_limited(port, ch, port->fifosize >> 1,
+		true,
+		UART_PUT_CHAR(port, ch),
+		({}));
 }
 
 static irqreturn_t apbuart_int(int irq, void *dev_id)
diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index 5d9737c2d1f2..62bc7244dc67 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -303,53 +303,24 @@ static void bcm_uart_do_rx(struct uart_port *port)
  */
 static void bcm_uart_do_tx(struct uart_port *port)
 {
-	struct circ_buf *xmit;
-	unsigned int val, max_count;
-
-	if (port->x_char) {
-		bcm_uart_writel(port, port->x_char, UART_FIFO_REG);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_tx_stopped(port)) {
-		bcm_uart_stop_tx(port);
-		return;
-	}
-
-	xmit = &port->state->xmit;
-	if (uart_circ_empty(xmit))
-		goto txq_empty;
+	unsigned int val;
+	bool pending;
+	u8 ch;
 
 	val = bcm_uart_readl(port, UART_MCTL_REG);
 	val = (val & UART_MCTL_TXFIFOFILL_MASK) >> UART_MCTL_TXFIFOFILL_SHIFT;
-	max_count = port->fifosize - val;
-
-	while (max_count--) {
-		unsigned int c;
 
-		c = xmit->buf[xmit->tail];
-		bcm_uart_writel(port, c, UART_FIFO_REG);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
-
-	if (uart_circ_empty(xmit))
-		goto txq_empty;
-	return;
+	pending = uart_port_tx_limited(port, ch, port->fifosize - val,
+		true,
+		bcm_uart_writel(port, ch, UART_FIFO_REG),
+		({}));
+	if (pending)
+		return;
 
-txq_empty:
 	/* nothing to send, disable transmit interrupt */
 	val = bcm_uart_readl(port, UART_IR_REG);
 	val &= ~UART_TX_INT_MASK;
 	bcm_uart_writel(port, val, UART_IR_REG);
-	return;
 }
 
 /*
diff --git a/drivers/tty/serial/mux.c b/drivers/tty/serial/mux.c
index ed0e763f622a..85ce1e9af44a 100644
--- a/drivers/tty/serial/mux.c
+++ b/drivers/tty/serial/mux.c
@@ -171,6 +171,13 @@ static void mux_break_ctl(struct uart_port *port, int break_state)
 {
 }
 
+static void mux_tx_done(struct uart_port *port)
+{
+	/* FIXME js: really needs to wait? */
+	while (UART_GET_FIFO_CNT(port))
+		udelay(1);
+}
+
 /**
  * mux_write - Write chars to the mux fifo.
  * @port: Ptr to the uart_port.
@@ -180,39 +187,13 @@ static void mux_break_ctl(struct uart_port *port, int break_state)
  */
 static void mux_write(struct uart_port *port)
 {
-	int count;
-	struct circ_buf *xmit = &port->state->xmit;
-
-	if(port->x_char) {
-		UART_PUT_CHAR(port, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if(uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		mux_stop_tx(port);
-		return;
-	}
-
-	count = (port->fifosize) - UART_GET_FIFO_CNT(port);
-	do {
-		UART_PUT_CHAR(port, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if(uart_circ_empty(xmit))
-			break;
-
-	} while(--count > 0);
-
-	while(UART_GET_FIFO_CNT(port)) 
-		udelay(1);
-
-	if(uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		mux_stop_tx(port);
+	uart_port_tx_limited(port, ch,
+		port->fifosize - UART_GET_FIFO_CNT(port),
+		true,
+		UART_PUT_CHAR(port, ch),
+		mux_tx_done(port));
 }
 
 /**
diff --git a/drivers/tty/serial/mvebu-uart.c b/drivers/tty/serial/mvebu-uart.c
index ba16e1da6bd3..7b566404cb33 100644
--- a/drivers/tty/serial/mvebu-uart.c
+++ b/drivers/tty/serial/mvebu-uart.c
@@ -335,40 +335,12 @@ static void mvebu_uart_rx_chars(struct uart_port *port, unsigned int status)
 
 static void mvebu_uart_tx_chars(struct uart_port *port, unsigned int status)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	unsigned int count;
-	unsigned int st;
-
-	if (port->x_char) {
-		writel(port->x_char, port->membase + UART_TSH(port));
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		mvebu_uart_stop_tx(port);
-		return;
-	}
-
-	for (count = 0; count < port->fifosize; count++) {
-		writel(xmit->buf[xmit->tail], port->membase + UART_TSH(port));
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-
-		if (uart_circ_empty(xmit))
-			break;
-
-		st = readl(port->membase + UART_STAT);
-		if (st & STAT_TX_FIFO_FUL)
-			break;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		mvebu_uart_stop_tx(port);
+	uart_port_tx_limited(port, ch, port->fifosize,
+		!(readl(port->membase + UART_STAT) & STAT_TX_FIFO_FUL),
+		writel(ch, port->membase + UART_TSH(port)),
+		({}));
 }
 
 static irqreturn_t mvebu_uart_isr(int irq, void *dev_id)
diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 7d0d2718ef59..82d35dbbfa6c 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -347,34 +347,12 @@ static void serial_omap_put_char(struct uart_omap_port *up, unsigned char ch)
 
 static void transmit_chars(struct uart_omap_port *up, unsigned int lsr)
 {
-	struct circ_buf *xmit = &up->port.state->xmit;
-	int count;
+	u8 ch;
 
-	if (up->port.x_char) {
-		serial_omap_put_char(up, up->port.x_char);
-		up->port.icount.tx++;
-		up->port.x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
-		serial_omap_stop_tx(&up->port);
-		return;
-	}
-	count = up->port.fifosize / 4;
-	do {
-		serial_omap_put_char(up, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
-
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
-
-	if (uart_circ_empty(xmit))
-		serial_omap_stop_tx(&up->port);
+	uart_port_tx_limited(&up->port, ch, up->port.fifosize / 4,
+		true,
+		serial_omap_put_char(up, ch),
+		({}));
 }
 
 static inline void serial_omap_enable_ier_thri(struct uart_omap_port *up)
diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 2d25231fad84..444fa4b654ac 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -174,35 +174,12 @@ static inline void receive_chars(struct uart_pxa_port *up, int *status)
 
 static void transmit_chars(struct uart_pxa_port *up)
 {
-	struct circ_buf *xmit = &up->port.state->xmit;
-	int count;
+	u8 ch;
 
-	if (up->port.x_char) {
-		serial_out(up, UART_TX, up->port.x_char);
-		up->port.icount.tx++;
-		up->port.x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&up->port)) {
-		serial_pxa_stop_tx(&up->port);
-		return;
-	}
-
-	count = up->port.fifosize / 2;
-	do {
-		serial_out(up, UART_TX, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
-
-
-	if (uart_circ_empty(xmit))
-		serial_pxa_stop_tx(&up->port);
+	uart_port_tx_limited(&up->port, ch, up->port.fifosize / 2,
+		true,
+		serial_out(up, UART_TX, ch),
+		({}));
 }
 
 static void serial_pxa_start_tx(struct uart_port *port)
diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index b81afb06f1f4..749b873a5d99 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -427,32 +427,13 @@ static void rp2_rx_chars(struct rp2_uart_port *up)
 
 static void rp2_tx_chars(struct rp2_uart_port *up)
 {
-	u16 max_tx = FIFO_SIZE - readw(up->base + RP2_TX_FIFO_COUNT);
-	struct circ_buf *xmit = &up->port.state->xmit;
+	u8 ch;
 
-	if (uart_tx_stopped(&up->port)) {
-		rp2_uart_stop_tx(&up->port);
-		return;
-	}
-
-	for (; max_tx != 0; max_tx--) {
-		if (up->port.x_char) {
-			writeb(up->port.x_char, up->base + RP2_DATA_BYTE);
-			up->port.x_char = 0;
-			up->port.icount.tx++;
-			continue;
-		}
-		if (uart_circ_empty(xmit)) {
-			rp2_uart_stop_tx(&up->port);
-			break;
-		}
-		writeb(xmit->buf[xmit->tail], up->base + RP2_DATA_BYTE);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->port.icount.tx++;
-	}
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&up->port);
+	uart_port_tx_limited(&up->port, ch,
+		FIFO_SIZE - readw(up->base + RP2_TX_FIFO_COUNT),
+		true,
+		writeb(ch, up->base + RP2_DATA_BYTE),
+		({}));
 }
 
 static void rp2_ch_interrupt(struct rp2_uart_port *up)
diff --git a/drivers/tty/serial/serial_txx9.c b/drivers/tty/serial/serial_txx9.c
index e12f1dc18c38..eab387b01e36 100644
--- a/drivers/tty/serial/serial_txx9.c
+++ b/drivers/tty/serial/serial_txx9.c
@@ -321,34 +321,12 @@ receive_chars(struct uart_port *up, unsigned int *status)
 
 static inline void transmit_chars(struct uart_port *up)
 {
-	struct circ_buf *xmit = &up->state->xmit;
-	int count;
+	u8 ch;
 
-	if (up->x_char) {
-		sio_out(up, TXX9_SITFIFO, up->x_char);
-		up->icount.tx++;
-		up->x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(up)) {
-		serial_txx9_stop_tx(up);
-		return;
-	}
-
-	count = TXX9_SIO_TX_FIFO;
-	do {
-		sio_out(up, TXX9_SITFIFO, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		up->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(up);
-
-	if (uart_circ_empty(xmit))
-		serial_txx9_stop_tx(up);
+	uart_port_tx_limited(up, ch, TXX9_SIO_TX_FIFO,
+		true,
+		sio_out(up, TXX9_SITFIFO, ch),
+		({}));
 }
 
 static irqreturn_t serial_txx9_interrupt(int irq, void *dev_id)
diff --git a/drivers/tty/serial/sifive.c b/drivers/tty/serial/sifive.c
index 7fb6760b5c37..1f565a216e74 100644
--- a/drivers/tty/serial/sifive.c
+++ b/drivers/tty/serial/sifive.c
@@ -288,33 +288,12 @@ static void __ssp_transmit_char(struct sifive_serial_port *ssp, int ch)
  */
 static void __ssp_transmit_chars(struct sifive_serial_port *ssp)
 {
-	struct circ_buf *xmit = &ssp->port.state->xmit;
-	int count;
-
-	if (ssp->port.x_char) {
-		__ssp_transmit_char(ssp, ssp->port.x_char);
-		ssp->port.icount.tx++;
-		ssp->port.x_char = 0;
-		return;
-	}
-	if (uart_circ_empty(xmit) || uart_tx_stopped(&ssp->port)) {
-		sifive_serial_stop_tx(&ssp->port);
-		return;
-	}
-	count = SIFIVE_TX_FIFO_DEPTH;
-	do {
-		__ssp_transmit_char(ssp, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		ssp->port.icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(&ssp->port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		sifive_serial_stop_tx(&ssp->port);
+	uart_port_tx_limited(&ssp->port, ch, SIFIVE_TX_FIFO_DEPTH,
+		true,
+		__ssp_transmit_char(ssp, ch),
+		({}));
 }
 
 /**
diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 342a87967631..3f34f7bb7700 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -626,35 +626,12 @@ static inline void sprd_rx(struct uart_port *port)
 
 static inline void sprd_tx(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	int count;
-
-	if (port->x_char) {
-		serial_out(port, SPRD_TXD, port->x_char);
-		port->icount.tx++;
-		port->x_char = 0;
-		return;
-	}
-
-	if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
-		sprd_stop_tx(port);
-		return;
-	}
-
-	count = THLD_TX_EMPTY;
-	do {
-		serial_out(port, SPRD_TXD, xmit->buf[xmit->tail]);
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		port->icount.tx++;
-		if (uart_circ_empty(xmit))
-			break;
-	} while (--count > 0);
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		sprd_stop_tx(port);
+	uart_port_tx_limited(port, ch, THLD_TX_EMPTY,
+		true,
+		serial_out(port, SPRD_TXD, ch),
+		({}));
 }
 
 /* this handles the interrupt from one port */
diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
index fcecea689a0d..5215e6910f68 100644
--- a/drivers/tty/serial/st-asc.c
+++ b/drivers/tty/serial/st-asc.c
@@ -237,50 +237,12 @@ static inline unsigned asc_hw_txroom(struct uart_port *port)
  */
 static void asc_transmit_chars(struct uart_port *port)
 {
-	struct circ_buf *xmit = &port->state->xmit;
-	int txroom;
-	unsigned char c;
-
-	txroom = asc_hw_txroom(port);
-
-	if ((txroom != 0) && port->x_char) {
-		c = port->x_char;
-		port->x_char = 0;
-		asc_out(port, ASC_TXBUF, c);
-		port->icount.tx++;
-		txroom = asc_hw_txroom(port);
-	}
-
-	if (uart_tx_stopped(port)) {
-		/*
-		 * We should try and stop the hardware here, but I
-		 * don't think the ASC has any way to do that.
-		 */
-		asc_disable_tx_interrupts(port);
-		return;
-	}
-
-	if (uart_circ_empty(xmit)) {
-		asc_disable_tx_interrupts(port);
-		return;
-	}
-
-	if (txroom == 0)
-		return;
-
-	do {
-		c = xmit->buf[xmit->tail];
-		xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
-		asc_out(port, ASC_TXBUF, c);
-		port->icount.tx++;
-		txroom--;
-	} while ((txroom > 0) && (!uart_circ_empty(xmit)));
-
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
-		uart_write_wakeup(port);
+	u8 ch;
 
-	if (uart_circ_empty(xmit))
-		asc_disable_tx_interrupts(port);
+	uart_port_tx_limited(port, ch, asc_hw_txroom(port),
+		true,
+		asc_out(port, ASC_TXBUF, ch),
+		({}));
 }
 
 static void asc_receive_chars(struct uart_port *port)
-- 
2.37.3

