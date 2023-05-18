Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D8D6708504
	for <lists+linux-kernel@lfdr.de>; Thu, 18 May 2023 17:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjERPed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 11:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbjERPeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 11:34:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459D8E49;
        Thu, 18 May 2023 08:34:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADFB36503D;
        Thu, 18 May 2023 15:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ACCC4339E;
        Thu, 18 May 2023 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684424052;
        bh=Ik9a/pOpVq3VRm0rIlpIiP6uAAc66FLi4+A5HDVjeRU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BUWFXZt89Kpp/QVGWQrXZ37jLI1umGW1FARv1t0IhyhEQdzoO2QRyi1oYu9Mu0EIG
         ETaEYdAu+jc107fyODdCHQ9KcF5JiVYZOFaWxZcpxNQxggwLuVODvutMCSRVqyB+eC
         QsBWoNEsGBaYOkRvPVbFvEgaPCl78dzfQ3Iby6/68BADQCXhw7KN+k2IWFwDkp4oLK
         JTcbsP7xvnUzrIEx5YSoiZuZtfC04rG3oKUtfuBRHTyy8h7TKbONB+r4n6QWCKO7Ne
         s/DZI377o4sJAVda7yV+PY/FPZjXFO8MXQxAyDzUgdkUTUr2uGxSgpg/aJxUPsXNeu
         LSxpyi+g/kwDg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: [PATCH v4 04/10] serial: bflb_uart: add Bouffalolab UART Driver
Date:   Thu, 18 May 2023 23:22:38 +0800
Message-Id: <20230518152244.2178-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230518152244.2178-1-jszhang@kernel.org>
References: <20230518152244.2178-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the driver for Bouffalolab UART IP which is found in Bouffalolab
SoCs such as bl808.

UART driver probe will create path named "/dev/ttySx".

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/tty/serial/Kconfig       |  18 +
 drivers/tty/serial/Makefile      |   1 +
 drivers/tty/serial/bflb_uart.c   | 586 +++++++++++++++++++++++++++++++
 include/uapi/linux/serial_core.h |   3 +
 4 files changed, 608 insertions(+)
 create mode 100644 drivers/tty/serial/bflb_uart.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 398e5aac2e77..abc30a0713f5 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -179,6 +179,24 @@ config SERIAL_ATMEL_TTYAT
 
 	  Say Y if you have an external 8250/16C550 UART.  If unsure, say N.
 
+config SERIAL_BFLB
+	tristate "Bouffalolab serial port support"
+	select SERIAL_CORE
+	depends on COMMON_CLK
+	help
+	  This enables the driver for the Bouffalolab's serial.
+
+config SERIAL_BFLB_CONSOLE
+	bool "Support for console on Bouffalolab serial port"
+	depends on SERIAL_BFLB=y
+	select SERIAL_CORE_CONSOLE
+	select SERIAL_EARLYCON
+	help
+	  Say Y here if you wish to use a Bouffalolab UART as the
+	  system console (the system console is the device which
+	  receives all kernel messages and warnings and which allows
+	  logins in single user mode) as /dev/ttySn.
+
 config SERIAL_KGDB_NMI
 	bool "Serial console over KGDB NMI debugger port"
 	depends on KGDB_SERIAL_CONSOLE
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index cd9afd9e3018..5788a708d327 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SERIAL_8250) += 8250/
 
 obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
 obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
+obj-$(CONFIG_SERIAL_BFLB) += bflb_uart.o
 obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
 obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
 obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
diff --git a/drivers/tty/serial/bflb_uart.c b/drivers/tty/serial/bflb_uart.c
new file mode 100644
index 000000000000..3f80bba8599a
--- /dev/null
+++ b/drivers/tty/serial/bflb_uart.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Based on bflb_uart.c, by Bouffalolab team
+ *
+ * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/console.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/serial.h>
+#include <linux/serial_core.h>
+#include <linux/tty.h>
+#include <linux/tty_flip.h>
+
+#define UART_UTX_CONFIG			0x00
+#define  UART_CR_UTX_EN			BIT(0)
+#define  UART_CR_UTX_CTS_EN		BIT(1)
+#define  UART_CR_UTX_FRM_EN		BIT(2)
+#define  UART_CR_UTX_PRT_EN		BIT(4)
+#define  UART_CR_UTX_PRT_SEL		BIT(5)
+#define  UART_CR_UTX_BIT_CNT_D_MSK	GENMASK(10, 8)
+#define  UART_CR_UTX_BIT_CNT_P_MSK	GENMASK(12, 11)
+#define UART_URX_CONFIG			0x04
+#define  UART_CR_URX_EN			BIT(0)
+#define  UART_CR_URX_PRT_EN		BIT(4)
+#define  UART_CR_URX_PRT_SEL		BIT(5)
+#define  UART_CR_URX_BIT_CNT_D_MSK	GENMASK(10, 8)
+#define UART_BIT_PRD			0x08
+#define  UART_CR_UTX_BIT_PRD_MSK	GENMASK(15, 0)
+#define  UART_CR_URX_BIT_PRD_MSK	GENMASK(31, 16)
+#define UART_DATA_CONFIG		0x0c
+#define  UART_CR_UART_BIT_INV		BIT(0)
+#define UART_URX_RTO_TIMER		0x18
+#define  UART_CR_URX_RTO_VALUE_MSK	GENMASK(7, 0)
+#define UART_SW_MODE			0x1c
+#define UART_INT_STS			0x20
+#define  UART_UTX_END_INT		BIT(0)
+#define  UART_URX_END_INT		BIT(1)
+#define  UART_UTX_FIFO_INT		BIT(2)
+#define  UART_URX_FIFO_INT		BIT(3)
+#define  UART_URX_RTO_INT		BIT(4)
+#define  UART_URX_PCE_INT		BIT(5)
+#define  UART_UTX_FER_INT		BIT(6)
+#define  UART_URX_FER_INT		BIT(7)
+#define  UART_URX_LSE_INT		BIT(8)
+#define UART_INT_MASK			0x24
+#define UART_INT_CLEAR			0x28
+#define UART_INT_EN			0x2c
+#define UART_STATUS			0x30
+#define  UART_STS_UTX_BUS_BUSY		BIT(0)
+#define UART_FIFO_CONFIG_0		0x80
+#define  UART_DMA_TX_EN			BIT(0)
+#define  UART_DMA_RX_EN			BIT(1)
+#define  UART_TX_FIFO_CLR		BIT(2)
+#define  UART_RX_FIFO_CLR		BIT(3)
+#define  UART_TX_FIFO_OVERFLOW		BIT(4)
+#define  UART_TX_FIFO_UNDERFLOW		BIT(5)
+#define  UART_RX_FIFO_OVERFLOW		BIT(6)
+#define  UART_RX_FIFO_UNDERFLOW		BIT(7)
+#define UART_FIFO_CONFIG_1		0x84
+#define  UART_TX_FIFO_CNT_MSK		GENMASK(5, 0)
+#define  UART_RX_FIFO_CNT_MSK		GENMASK(13, 8)
+#define  UART_TX_FIFO_TH_MSK		GENMASK(20, 16)
+#define  UART_RX_FIFO_TH_MSK		GENMASK(28, 24)
+#define UART_FIFO_WDATA			0x88
+#define UART_FIFO_RDATA			0x8c
+#define  UART_FIFO_RDATA_MSK		GENMASK(7, 0)
+
+#define BFLB_UART_MAXPORTS		8
+#define BFLB_UART_BAUD			2000000
+#define BFLB_UART_RX_FIFO_TH		7
+#define BFLB_UART_TX_FIFO_TH		15
+#define BFLB_UART_URX_RTO_TIME		0x4f
+
+struct bflb_uart_port {
+	struct uart_port port;
+	struct clk *clk;
+};
+
+static struct bflb_uart_port *bflb_uart_ports[BFLB_UART_MAXPORTS];
+
+static inline u32 rdl(struct uart_port *port, u32 reg)
+{
+	return readl_relaxed(port->membase + reg);
+}
+
+static inline void wrl(struct uart_port *port, u32 reg, u32 value)
+{
+	writel_relaxed(value, port->membase + reg);
+}
+
+static inline void wrb(struct uart_port *port, u32 reg, u8 value)
+{
+	writeb_relaxed(value, port->membase + reg);
+}
+
+static unsigned int bflb_uart_tx_empty(struct uart_port *port)
+{
+	return (rdl(port, UART_FIFO_CONFIG_1) & UART_TX_FIFO_CNT_MSK) ? TIOCSER_TEMT : 0;
+}
+
+static unsigned int bflb_uart_get_mctrl(struct uart_port *port)
+{
+	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
+}
+
+static void bflb_uart_set_mctrl(struct uart_port *port, unsigned int sigs)
+{
+}
+
+static void bflb_uart_start_tx(struct uart_port *port)
+{
+	u32 val;
+
+	val = rdl(port, UART_UTX_CONFIG);
+	val |= UART_CR_UTX_EN;
+	wrl(port, UART_UTX_CONFIG, val);
+
+	val = rdl(port, UART_FIFO_CONFIG_1);
+	val &= ~UART_TX_FIFO_TH_MSK;
+	val |= FIELD_PREP(UART_TX_FIFO_TH_MSK, BFLB_UART_TX_FIFO_TH);
+	wrl(port, UART_FIFO_CONFIG_1, val);
+
+	val = rdl(port, UART_INT_MASK);
+	val &= ~UART_UTX_FIFO_INT;
+	wrl(port, UART_INT_MASK, val);
+}
+
+static void bflb_uart_stop_tx(struct uart_port *port)
+{
+	u32 val;
+
+	val = rdl(port, UART_INT_MASK);
+	val |= UART_UTX_FIFO_INT;
+	wrl(port, UART_INT_MASK, val);
+}
+
+static void bflb_uart_stop_rx(struct uart_port *port)
+{
+	u32 val;
+
+	val = rdl(port, UART_URX_CONFIG);
+	val &= ~UART_CR_URX_EN;
+	wrl(port, UART_URX_CONFIG, val);
+
+	val = rdl(port, UART_INT_MASK);
+	val |= UART_URX_FIFO_INT | UART_URX_RTO_INT | UART_URX_FER_INT;
+	wrl(port, UART_INT_MASK, val);
+}
+
+static void bflb_uart_set_termios(struct uart_port *port,
+				  struct ktermios *termios,
+				  const struct ktermios *old)
+{
+	unsigned long flags;
+	u32 valt, valr, val;
+	unsigned int baud, min;
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	/* set data length */
+	val = tty_get_char_size(termios->c_cflag) - 1;
+	valt = FIELD_PREP(UART_CR_UTX_BIT_CNT_D_MSK, val);
+
+	/* calculate parity */
+	termios->c_cflag &= ~CMSPAR;	/* no support mark/space */
+	if (termios->c_cflag & PARENB) {
+		valt |= UART_CR_UTX_PRT_EN;
+		if (termios->c_cflag & PARODD)
+			valt |= UART_CR_UTX_PRT_SEL;
+	}
+
+	valr = valt;
+
+	/* calculate stop bits */
+	if (termios->c_cflag & CSTOPB)
+		val = 2;
+	else
+		val = 1;
+	valt |= FIELD_PREP(UART_CR_UTX_BIT_CNT_P_MSK, val);
+
+	/* flow control */
+	if (termios->c_cflag & CRTSCTS)
+		valt |= UART_CR_UTX_CTS_EN;
+
+	/* enable TX freerunning mode */
+	valt |= UART_CR_UTX_FRM_EN;
+
+	valt |= UART_CR_UTX_EN;
+	valr |= UART_CR_URX_EN;
+
+	wrl(port, UART_UTX_CONFIG, valt);
+	wrl(port, UART_URX_CONFIG, valr);
+
+	min = port->uartclk / (UART_CR_UTX_BIT_PRD_MSK + 1);
+	baud = uart_get_baud_rate(port, termios, old, min, 4000000);
+
+	val = DIV_ROUND_CLOSEST(port->uartclk, baud) - 1;
+	val = FIELD_PREP(UART_CR_UTX_BIT_PRD_MSK, val);
+	val |= FIELD_PREP(UART_CR_URX_BIT_PRD_MSK, val);
+	wrl(port, UART_BIT_PRD, val);
+
+	uart_update_timeout(port, termios->c_cflag, baud);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void bflb_uart_rx_chars(struct uart_port *port)
+{
+	u8 ch;
+
+	while (rdl(port, UART_FIFO_CONFIG_1) & UART_RX_FIFO_CNT_MSK) {
+		ch = FIELD_GET(UART_FIFO_RDATA_MSK, rdl(port, UART_FIFO_RDATA));
+		port->icount.rx++;
+
+		if (uart_handle_sysrq_char(port, ch))
+			continue;
+		uart_insert_char(port, 0, 0, ch, TTY_NORMAL);
+	}
+
+	spin_unlock(&port->lock);
+	tty_flip_buffer_push(&port->state->port);
+	spin_lock(&port->lock);
+}
+
+static void bflb_uart_tx_chars(struct uart_port *port)
+{
+	u8 ch;
+
+	uart_port_tx_limited(port, ch, BFLB_UART_TX_FIFO_TH,
+			true,
+			wrl(port, UART_FIFO_WDATA, ch),
+			({}));
+}
+
+static irqreturn_t bflb_uart_interrupt(int irq, void *data)
+{
+	struct uart_port *port = data;
+	u32 isr, val;
+
+	isr = rdl(port, UART_INT_STS);
+	wrl(port, UART_INT_CLEAR, isr);
+
+	spin_lock(&port->lock);
+
+	if (isr & UART_URX_FER_INT) {
+		/* RX FIFO error interrupt */
+		val = rdl(port, UART_FIFO_CONFIG_0);
+		if (val & UART_RX_FIFO_OVERFLOW)
+			port->icount.overrun++;
+
+		val |= UART_RX_FIFO_CLR;
+		wrl(port, UART_FIFO_CONFIG_0, val);
+	}
+
+	if (isr & (UART_URX_FIFO_INT | UART_URX_RTO_INT))
+		bflb_uart_rx_chars(port);
+
+	if (isr & UART_UTX_FIFO_INT)
+		bflb_uart_tx_chars(port);
+
+	spin_unlock(&port->lock);
+
+	return IRQ_RETVAL(isr);
+}
+
+static void bflb_uart_config_port(struct uart_port *port, int flags)
+{
+	port->type = PORT_BFLB;
+}
+
+static int bflb_uart_startup(struct uart_port *port)
+{
+	unsigned long flags;
+	int ret;
+	u32 val;
+
+	ret = devm_request_irq(port->dev, port->irq, bflb_uart_interrupt,
+			       IRQF_SHARED, port->name, port);
+	if (ret) {
+		dev_err(port->dev, "fail to request serial irq %d, ret=%d\n",
+			port->irq, ret);
+		return ret;
+	}
+
+	spin_lock_irqsave(&port->lock, flags);
+
+	wrl(port, UART_INT_MASK, ~0);
+
+	wrl(port, UART_DATA_CONFIG, 0);
+	wrl(port, UART_SW_MODE, 0);
+	wrl(port, UART_URX_RTO_TIMER, FIELD_PREP(UART_CR_URX_RTO_VALUE_MSK, BFLB_UART_URX_RTO_TIME));
+
+	val = rdl(port, UART_FIFO_CONFIG_1);
+	val &= ~UART_RX_FIFO_TH_MSK;
+	val |= FIELD_PREP(UART_RX_FIFO_TH_MSK, BFLB_UART_RX_FIFO_TH);
+	wrl(port, UART_FIFO_CONFIG_1, val);
+
+	/* Unmask RX interrupts now */
+	val = rdl(port, UART_INT_MASK);
+	val &= ~(UART_URX_FIFO_INT | UART_URX_RTO_INT | UART_URX_FER_INT);
+	wrl(port, UART_INT_MASK, val);
+
+	val = rdl(port, UART_UTX_CONFIG);
+	val |= UART_CR_UTX_EN;
+	wrl(port, UART_UTX_CONFIG, val);
+	val = rdl(port, UART_URX_CONFIG);
+	val |= UART_CR_URX_EN;
+	wrl(port, UART_URX_CONFIG, val);
+
+	spin_unlock_irqrestore(&port->lock, flags);
+
+	return 0;
+}
+
+static void bflb_uart_shutdown(struct uart_port *port)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&port->lock, flags);
+	/* mask all interrupts now */
+	wrl(port, UART_INT_MASK, ~0);
+	spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static const char *bflb_uart_type(struct uart_port *port)
+{
+	return (port->type == PORT_BFLB) ? "BFLB UART" : NULL;
+}
+
+static int bflb_uart_verify_port(struct uart_port *port,
+				 struct serial_struct *ser)
+{
+	if (ser->type != PORT_UNKNOWN && ser->type != PORT_BFLB)
+		return -EINVAL;
+	return 0;
+}
+
+static const struct uart_ops bflb_uart_ops = {
+	.tx_empty = bflb_uart_tx_empty,
+	.get_mctrl = bflb_uart_get_mctrl,
+	.set_mctrl = bflb_uart_set_mctrl,
+	.start_tx = bflb_uart_start_tx,
+	.stop_tx = bflb_uart_stop_tx,
+	.stop_rx = bflb_uart_stop_rx,
+	.startup = bflb_uart_startup,
+	.shutdown = bflb_uart_shutdown,
+	.set_termios = bflb_uart_set_termios,
+	.type = bflb_uart_type,
+	.config_port = bflb_uart_config_port,
+	.verify_port = bflb_uart_verify_port,
+};
+
+#ifdef CONFIG_SERIAL_BFLB_CONSOLE
+static void bflb_console_putchar(struct uart_port *port, unsigned char ch)
+{
+	while (!(rdl(port, UART_FIFO_CONFIG_1) & UART_TX_FIFO_CNT_MSK))
+		cpu_relax();
+	wrb(port, UART_FIFO_WDATA, ch);
+}
+
+/*
+ * Interrupts are disabled on entering
+ */
+static void bflb_uart_console_write(struct console *co, const char *s,
+				    u_int count)
+{
+	struct uart_port *port = &bflb_uart_ports[co->index]->port;
+	u32 status, reg, mask;
+
+	/* save then disable interrupts */
+	mask = rdl(port, UART_INT_MASK);
+	reg = ~0;
+	wrl(port, UART_INT_MASK, reg);
+
+	/* Make sure that tx is enabled */
+	reg = rdl(port, UART_UTX_CONFIG);
+	reg |= UART_CR_UTX_EN;
+	wrl(port, UART_UTX_CONFIG, reg);
+
+	uart_console_write(port, s, count, bflb_console_putchar);
+
+	/* wait for TX done */
+	do {
+		status = rdl(port, UART_STATUS);
+	} while ((status & UART_STS_UTX_BUS_BUSY));
+
+	/* restore IRQ mask */
+	wrl(port, UART_INT_MASK, mask);
+}
+
+static int bflb_uart_console_setup(struct console *co, char *options)
+{
+	struct uart_port *port;
+	struct bflb_uart_port *bp;
+	int baud = BFLB_UART_BAUD;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+	u32 val;
+
+	if (co->index >= BFLB_UART_MAXPORTS || co->index < 0)
+		return -EINVAL;
+
+	bp = bflb_uart_ports[co->index];
+	if (!bp)
+		/* Port not initialized yet - delay setup */
+		return -ENODEV;
+
+	port = &bp->port;
+
+	val = rdl(port, UART_UTX_CONFIG);
+	val |= UART_CR_UTX_EN;
+	wrl(port, UART_UTX_CONFIG, val);
+
+	if (options)
+		uart_parse_options(options, &baud, &parity, &bits, &flow);
+
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct uart_driver bflb_uart_driver;
+static struct console bflb_uart_console = {
+	.name = "ttyS",
+	.write = bflb_uart_console_write,
+	.device = uart_console_device,
+	.setup = bflb_uart_console_setup,
+	.flags = CON_PRINTBUFFER,
+	.index = -1,
+	.data = &bflb_uart_driver,
+};
+
+static int __init bflb_uart_console_init(void)
+{
+	register_console(&bflb_uart_console);
+	return 0;
+}
+console_initcall(bflb_uart_console_init);
+
+#define BFLB_UART_CONSOLE (&bflb_uart_console)
+
+static void bflb_uart_earlycon_write(struct console *co, const char *s,
+				     unsigned int count)
+{
+	struct earlycon_device *dev = co->data;
+
+	uart_console_write(&dev->port, s, count, bflb_console_putchar);
+}
+
+static int __init bflb_uart_earlycon_setup(struct earlycon_device *dev,
+					   const char *options)
+{
+	if (!dev->port.membase)
+		return -ENODEV;
+
+	dev->con->write = bflb_uart_earlycon_write;
+
+	return 0;
+}
+OF_EARLYCON_DECLARE(bflb_uart, "bouffalolab,bl808-uart", bflb_uart_earlycon_setup);
+
+#else
+
+#define BFLB_UART_CONSOLE NULL
+
+#endif /* CONFIG_SERIAL_BFLB_CONSOLE */
+
+static struct uart_driver bflb_uart_driver = {
+	.owner = THIS_MODULE,
+	.driver_name = "bflb_uart",
+	.dev_name = "ttyS",
+	.nr = BFLB_UART_MAXPORTS,
+	.cons = BFLB_UART_CONSOLE,
+};
+
+static int bflb_uart_probe(struct platform_device *pdev)
+{
+	struct uart_port *port;
+	struct bflb_uart_port *bp;
+	struct resource *res;
+	int index, irq;
+
+	index = of_alias_get_id(pdev->dev.of_node, "serial");
+	if (unlikely(index < 0 || index >= BFLB_UART_MAXPORTS)) {
+		dev_err(&pdev->dev, "got a wrong serial alias id %d\n", index);
+		return -EINVAL;
+	}
+
+	bp = devm_kzalloc(&pdev->dev, sizeof(*bp), GFP_KERNEL);
+	if (!bp)
+		return -ENOMEM;
+
+	bflb_uart_ports[index] = bp;
+	platform_set_drvdata(pdev, bp);
+	port = &bp->port;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	port->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(port->membase))
+		return PTR_ERR(port->membase);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	port->mapbase = res->start;
+	port->irq = irq;
+	port->line = index;
+	port->type = PORT_BFLB;
+	port->iotype = UPIO_MEM;
+	port->fifosize = 32;
+	port->ops = &bflb_uart_ops;
+	port->flags = UPF_BOOT_AUTOCONF;
+	port->dev = &pdev->dev;
+	port->has_sysrq = IS_ENABLED(CONFIG_SERIAL_BFLB_CONSOLE);
+
+	bp->clk = devm_clk_get_enabled(&pdev->dev, NULL);
+	if (IS_ERR(bp->clk))
+		return PTR_ERR(bp->clk);
+	port->uartclk = clk_get_rate(bp->clk);
+
+	return uart_add_one_port(&bflb_uart_driver, port);
+}
+
+static int bflb_uart_remove(struct platform_device *pdev)
+{
+	struct bflb_uart_port *bp = platform_get_drvdata(pdev);
+
+	uart_remove_one_port(&bflb_uart_driver, &bp->port);
+	bflb_uart_ports[bp->port.line] = NULL;
+
+	return 0;
+}
+
+static const struct of_device_id bflb_uart_match[] = {
+	{
+		.compatible = "bouffalolab,bl808-uart",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, bflb_uart_match);
+
+static struct platform_driver bflb_uart_platform_driver = {
+	.probe	= bflb_uart_probe,
+	.remove	= bflb_uart_remove,
+	.driver	= {
+		.name		= "bflb_uart",
+		.of_match_table	= of_match_ptr(bflb_uart_match),
+	},
+};
+
+static int __init bflb_uart_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&bflb_uart_driver);
+	if (ret)
+		return ret;
+
+	ret = platform_driver_register(&bflb_uart_platform_driver);
+	if (ret)
+		uart_unregister_driver(&bflb_uart_driver);
+
+	return ret;
+}
+
+static void __exit bflb_uart_exit(void)
+{
+	platform_driver_unregister(&bflb_uart_platform_driver);
+	uart_unregister_driver(&bflb_uart_driver);
+}
+
+module_init(bflb_uart_init);
+module_exit(bflb_uart_exit);
+
+MODULE_DESCRIPTION("Bouffalolab UART driver");
+MODULE_AUTHOR("Jisheng Zhang <jszhang@kernel.org>");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
index 281fa286555c..0651fcc8734f 100644
--- a/include/uapi/linux/serial_core.h
+++ b/include/uapi/linux/serial_core.h
@@ -279,4 +279,7 @@
 /* Sunplus UART */
 #define PORT_SUNPLUS	123
 
+/* Bouffalolab UART */
+#define PORT_BFLB	124
+
 #endif /* _UAPILINUX_SERIAL_CORE_H */
-- 
2.40.0

