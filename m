Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6456CB3F0
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 04:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbjC1CVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 22:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjC1CUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 22:20:21 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E1F35A7;
        Mon, 27 Mar 2023 19:19:59 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id ix20so10292595plb.3;
        Mon, 27 Mar 2023 19:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679969991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lf02EoceYl+rP0fJ8Md+ICeACeHn4hqsSM9AVm7EPGI=;
        b=Z5HLKpZCS00ngHeuY2B74EmQ7E/AVB4eAywncRnXWWoshn2j3UULk0z2yJSIg25VyJ
         kQix+mdGqUb/953T1NsuTAWAA2307jdqRqz75+Nz7sqFqaX6J6ZFvY9HNO2Fn9R7rVYe
         +kpFVq3ONdqPcgoVr8KzNBdrVhz+maq9q7efjgWM2dPobXVnISq76thSZSFbaQMvPxHW
         Ypx/3+K258Zzi4/3cj5lek4YqRvarhPwK2OnXcFQzC9SWBW0fUentjrOTfZDSOt/Z4EX
         unBMl9TL9jB+iRajj3cQo9OdpmQTryQw2meER5mKW+gHqBEKFUI1Ywis1CwdF0/e6U/L
         YGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679969991;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lf02EoceYl+rP0fJ8Md+ICeACeHn4hqsSM9AVm7EPGI=;
        b=oKfGbRYN618tcdNJxQwYy+nGAOif6j27WHeU1x9sm08IqnMo5Z3+Byw1JhBRA4ckYH
         qfE6uV1/ZHhQxuWBuj8Bs2mJ/36Nm+DjmnSh86oFFqYe9uD3tYRgg/kY66uChf/BKVyl
         Az4ZiWXvhL6zzITVRWnUlW89s/SztTRoGSnySrR4SxOpwZGOkvF8LKw83a3oIQcrAXzW
         o8IS9Gmjg6cJ2YNY9rTu/K0vZBO9XqVWx+is7YnpSQ1INTjzznwjq7OPuqn0ZlhrU5it
         Vtw6oCHqQwBWqHrX+EscMubV1WZg7x6MY3K7LycA/YRWVAr8dac87AmPIsfVaBbxGS9c
         AZJg==
X-Gm-Message-State: AAQBX9chQkBuim52/F5oFJ/qM4OfPUEaXuw905YuuV11upeYQOc1N6bk
        y8te21IEGzhmYFxQ22FnN9Y=
X-Google-Smtp-Source: AKy350bjPszhUD48eY4INaM9fQQD7JAJi1sDgCJkQyf7rjAij4zxQ7ETq2sIk/uLMd/lEAHmcqaUrA==
X-Received: by 2002:a17:90b:3846:b0:237:24a8:c5e2 with SMTP id nl6-20020a17090b384600b0023724a8c5e2mr14963878pjb.40.1679969991360;
        Mon, 27 Mar 2023 19:19:51 -0700 (PDT)
Received: from a28aa0606c51.. (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id f17-20020a17090ac29100b00232cc61e16bsm5029301pjt.35.2023.03.27.19.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 19:19:51 -0700 (PDT)
From:   Jacky Huang <ychuang570808@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        lee@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        jirislaby@kernel.org
Cc:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        arnd@arndb.de, schung@nuvoton.com, mjchen@nuvoton.com,
        Jacky Huang <ychuang3@nuvoton.com>
Subject: [PATCH v6 11/12] tty: serial: Add Nuvoton ma35d1 serial driver support
Date:   Tue, 28 Mar 2023 02:19:11 +0000
Message-Id: <20230328021912.177301-12-ychuang570808@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230328021912.177301-1-ychuang570808@gmail.com>
References: <20230328021912.177301-1-ychuang570808@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Huang <ychuang3@nuvoton.com>

This adds UART and console driver for Nuvoton ma35d1 Soc.
It supports full-duplex communication, FIFO control, and
hardware flow control.

Signed-off-by: Jacky Huang <ychuang3@nuvoton.com>
---
 drivers/tty/serial/Kconfig         |  18 +
 drivers/tty/serial/Makefile        |   1 +
 drivers/tty/serial/ma35d1_serial.c | 802 +++++++++++++++++++++++++++++
 3 files changed, 821 insertions(+)
 create mode 100644 drivers/tty/serial/ma35d1_serial.c

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index 0072892ca7fc..daa4ae6bc08e 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1562,6 +1562,24 @@ config SERIAL_SUNPLUS_CONSOLE
 	  you can alter that using a kernel command line option such as
 	  "console=ttySUPx".
 
+config SERIAL_NUVOTON_MA35D1
+	tristate "Nuvoton MA35D1 family UART support"
+	depends on ARCH_NUVOTON || COMPILE_TEST
+	select SERIAL_CORE
+	help
+	  This driver supports Nuvoton MA35D1 family UART ports. If you would
+	  like to use them, you must answer Y or M to this option. Note that
+	  for use as console, it must be included in kernel and not as a
+	  module
+
+config SERIAL_NUVOTON_MA35D1_CONSOLE
+	bool "Console on a Nuvotn MA35D1 family UART port"
+	depends on SERIAL_NUVOTON_MA35D1=y
+	select SERIAL_CORE_CONSOLE
+	help
+	  Select this options if you'd like to use the UART port0 of the
+	  Nuvoton MA35D1 family as a console.
+
 endmenu
 
 config SERIAL_MCTRL_GPIO
diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
index cd9afd9e3018..71ebeba06ff2 100644
--- a/drivers/tty/serial/Makefile
+++ b/drivers/tty/serial/Makefile
@@ -93,3 +93,4 @@ obj-$(CONFIG_SERIAL_MCTRL_GPIO)	+= serial_mctrl_gpio.o
 
 obj-$(CONFIG_SERIAL_KGDB_NMI) += kgdb_nmi.o
 obj-$(CONFIG_KGDB_SERIAL_CONSOLE) += kgdboc.o
+obj-$(CONFIG_SERIAL_NUVOTON_MA35D1)	+= ma35d1_serial.o
diff --git a/drivers/tty/serial/ma35d1_serial.c b/drivers/tty/serial/ma35d1_serial.c
new file mode 100644
index 000000000000..75618ab0b2ca
--- /dev/null
+++ b/drivers/tty/serial/ma35d1_serial.c
@@ -0,0 +1,802 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ *  MA35D1 serial driver
+ *  Copyright (C) 2023 Nuvoton Technology Corp.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/serial_core.h>
+#include <linux/slab.h>
+#include <linux/tty_flip.h>
+
+#define UART_NR			17
+
+#define UART_REG_RBR		0x00
+#define UART_REG_THR		0x00
+#define UART_REG_IER		0x04
+#define UART_REG_FCR		0x08
+#define UART_REG_LCR		0x0C
+#define UART_REG_MCR		0x10
+#define UART_REG_MSR		0x14
+#define UART_REG_FSR		0x18
+#define UART_REG_ISR		0x1C
+#define UART_REG_TOR		0x20
+#define UART_REG_BAUD		0x24
+#define UART_REG_ALTCTL		0x2C
+#define UART_FUN_SEL		0x30
+#define UART_REG_WKCTL		0x40
+#define UART_REG_WKSTS		0x44
+
+/* UART_REG_IER - Interrupt Enable Register */
+#define IER_RDA_IEN		BIT(0)  /* RBR Available Interrupt Enable */
+#define IER_THRE_IEN		BIT(1)  /* THR Empty Interrupt Enable */
+#define IER_RLS_IEN		BIT(2)  /* RX Line Status Interrupt Enable */
+#define IER_RTO_IEN		BIT(4)  /* RX Time-out Interrupt Enable */
+#define IER_BUFERR_IEN		BIT(5)  /* Buffer Error Interrupt Enable */
+#define IER_TIME_OUT_EN		BIT(11) /* RX Buffer Time-out Counter Enable */
+#define IER_AUTO_RTS		BIT(12) /* nRTS Auto-flow Control Enable */
+#define IER_AUTO_CTS		BIT(13) /* nCTS Auto-flow Control Enable */
+
+/* UART_REG_FCR - FIFO Control Register */
+#define FCR_RFR			BIT(1)  /* RX Field Software Reset */
+#define FCR_TFR			BIT(2)  /* TX Field Software Reset */
+#define FCR_RFITL_MASK		GENMASK(7, 4) /* RX FIFO Interrupt Trigger Level */
+#define FCR_RFITL_1BYTE		FIELD_PREP(FCR_RFITL_MASK, 0)
+#define FCR_RFITL_4BYTES	FIELD_PREP(FCR_RFITL_MASK, 1)
+#define FCR_RFITL_8BYTES	FIELD_PREP(FCR_RFITL_MASK, 2)
+#define FCR_RFITL_14BYTES	FIELD_PREP(FCR_RFITL_MASK, 3)
+#define FCR_RFITL_30BYTES	FIELD_PREP(FCR_RFITL_MASK, 4)
+#define FCR_RTSTRGLV_MASK	GENMASK(19, 16) /* nRTS Trigger Level */
+#define FCR_RTSTRGLV_1BYTE	FIELD_PREP(FCR_RTSTRGLV_MASK, 0)
+#define FCR_RTSTRGLV_4BYTES	FIELD_PREP(FCR_RTSTRGLV_MASK, 1)
+#define FCR_RTSTRGLV_8BYTES	FIELD_PREP(FCR_RTSTRGLV_MASK, 2)
+#define FCR_RTSTRGLV_14BYTES	FIELD_PREP(FCR_RTSTRGLV_MASK, 3)
+#define FCR_RTSTRGLVL_30BYTES	FIELD_PREP(FCR_RTSTRGLV_MASK, 4)
+
+/* UART_REG_LCR - Line Control Register */
+#define	LCR_NSB			BIT(2) /* Number of “STOP Bit” */
+#define LCR_PBE			BIT(3) /* Parity Bit Enable */
+#define LCR_EPE			BIT(4) /* Even Parity Enable */
+#define LCR_SPE			BIT(5) /* Stick Parity Enable */
+#define LCR_BREAK		BIT(6) /* Break Control */
+#define LCR_WLS_MASK		GENMASK(1, 0) /* Word Length Selection */
+#define LCR_WLS_5BITS		FIELD_PREP(LCR_WLS_MASK, 0)
+#define LCR_WLS_6BITS		FIELD_PREP(LCR_WLS_MASK, 1)
+#define LCR_WLS_7BITS		FIELD_PREP(LCR_WLS_MASK, 2)
+#define LCR_WLS_8BITS		FIELD_PREP(LCR_WLS_MASK, 3)
+
+/* UART_REG_MCR - Modem Control Register */
+#define MCR_RTS_CTRL		BIT(1)  /* nRTS Signal Control */
+#define MCR_RTSACTLV		BIT(9)  /* nRTS Pin Active Level */
+#define MCR_RTSSTS		BIT(13) /* nRTS Pin Status (Read Only) */
+
+/* UART_REG_MSR - Modem Status Register */
+#define MSR_CTSDETF		BIT(0)  /* Detect nCTS State Change Flag */
+#define MSR_CTSSTS		BIT(4)  /* nCTS Pin Status (Read Only) */
+#define MSR_CTSACTLV		BIT(8)  /* nCTS Pin Active Level */
+
+/* UART_REG_FSR - FIFO Status Register */
+#define FSR_RX_OVER_IF		BIT(0)  /* RX Overflow Error Interrupt Flag */
+#define FSR_PEF			BIT(4)  /* Parity Error Flag*/
+#define FSR_FEF			BIT(5)  /* Framing Error Flag */
+#define FSR_BIF			BIT(6)  /* Break Interrupt Flag */
+#define FSR_RX_EMPTY		BIT(14) /* Receiver FIFO Empty (Read Only) */
+#define FSR_RX_FULL		BIT(15) /* Receiver FIFO Full (Read Only) */
+#define FSR_TX_EMPTY		BIT(22) /* Transmitter FIFO Empty (Read Only) */
+#define FSR_TX_FULL		BIT(23) /* Transmitter FIFO Full (Read Only) */
+#define FSR_TX_OVER_IF		BIT(24) /* TX Overflow Error Interrupt Flag */
+#define FSR_TE_FLAG		BIT(28) /* Transmitter Empty Flag (Read Only) */
+#define FSR_RXPTR_MSK		GENMASK(13, 8) /* TX FIFO Pointer mask */
+#define FSR_TXPTR_MSK		GENMASK(21, 16) /* RX FIFO Pointer mask */
+
+/* UART_REG_ISR - Interrupt Status Register */
+#define ISR_RDA_IF		BIT(0) /* RBR Available Interrupt Flag */
+#define ISR_THRE_IF		BIT(1) /* THR Empty Interrupt Flag */
+#define ISR_RLSIF		BIT(2) /* Receive Line Interrupt Flag */
+#define ISR_MODEMIF		BIT(3) /* MODEM Interrupt Flag */
+#define ISR_RXTO_IF		BIT(4) /* RX Time-out Interrupt Flag */
+#define ISR_BUFEIF		BIT(5) /* Buffer Error Interrupt Flag */
+#define UART_ISR_WK_IF		BIT(6) /* UART Wake-up Interrupt Flag */
+#define UART_ISR_RDAINT		BIT(8) /* RBR Available Interrupt Indicator */
+#define ISR_THRE_INT		BIT(9) /* THR Empty Interrupt Indicator */
+#define ISR_ALL			0xFFFFFFFF
+
+/* UART_REG_BAUD - Baud Rate Divider Register */
+#define	BAUD_MODE_MASK		GENMASK(29, 28)
+#define BAUD_MODE0		FIELD_PREP(BAUD_MODE_MASK, 0)
+#define BAUD_MODE1		FIELD_PREP(BAUD_MODE_MASK, 2)
+#define BAUD_MODE2		FIELD_PREP(BAUD_MODE_MASK, 3)
+
+/* UART_REG_ALTCTL - Alternate Control/Status Register */
+#define ALTCTL_RS485AUD		BIT(10) /* RS-485 Auto Direction Function */
+
+/* UART_FUN_SEL - Function Select Register */
+#define FUN_SEL_MASK		GENMASK(2, 0)
+#define FUN_SEL_UART		FIELD_PREP(FUN_SEL_MASK, 0)
+#define FUN_SEL_RS485		FIELD_PREP(FUN_SEL_MASK, 3)
+
+/* UART FIFO depth */
+#define UART_FIFO_DEPTH		32
+/* UART console clock */
+#define UART_CONSOLE_CLK	24000000
+/* UART register ioremap size */
+#define UART_REG_SIZE		0x100
+/* Rx Timeout */
+#define UART_RX_TOUT		0x40
+
+#define UART_ISR_IF_CHECK (ISR_RDA_IF | ISR_RXTO_IF | ISR_THRE_INT | ISR_BUFEIF)
+
+#define LOOP_TIMEOUT		1000
+
+static struct uart_driver ma35d1serial_reg;
+struct clk *clk;
+
+struct uart_ma35d1_port {
+	struct uart_port port;
+	u16 capabilities; /* port capabilities */
+	u8 ier;
+	u8 lcr;
+	u8 mcr;
+	u32 baud_rate;
+	u32 console_baud_rate;
+	u32 console_line;
+	u32 console_int;
+};
+
+static struct device_node *ma35d1serial_uart_nodes[UART_NR];
+static struct uart_ma35d1_port ma35d1serial_ports[UART_NR] = { 0 };
+
+static struct uart_ma35d1_port *to_ma35d1_uart_port(struct uart_port *uart)
+{
+	return container_of(uart, struct uart_ma35d1_port, port);
+}
+
+static u32 serial_in(struct uart_ma35d1_port *p, u32 offset)
+{
+	return readl_relaxed(p->port.membase + offset);
+}
+
+static void serial_out(struct uart_ma35d1_port *p, u32 offset, u32 value)
+{
+	writel_relaxed(value, p->port.membase + offset);
+}
+
+static void __stop_tx(struct uart_ma35d1_port *p)
+{
+	u32 ier;
+
+	ier = serial_in(p, UART_REG_IER);
+	if (ier & IER_THRE_IEN)
+		serial_out(p, UART_REG_IER, ier & ~IER_THRE_IEN);
+}
+
+static void ma35d1serial_stop_tx(struct uart_port *port)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+
+	__stop_tx(up);
+}
+
+static void transmit_chars(struct uart_ma35d1_port *up)
+{
+	struct circ_buf *xmit = &up->port.state->xmit;
+	int count;
+	u8 ch;
+
+	if (uart_tx_stopped(&up->port)) {
+		ma35d1serial_stop_tx(&up->port);
+		return;
+	}
+	if (uart_circ_empty(xmit)) {
+		__stop_tx(up);
+		return;
+	}
+
+	count = UART_FIFO_DEPTH - ((serial_in(up, UART_REG_FSR) & FSR_TXPTR_MSK) >> 16);
+
+	uart_port_tx_limited(&up->port, ch, count,
+			     !(serial_in(up, UART_REG_FSR) & FSR_TX_FULL),
+			     serial_out(up, UART_REG_THR, ch),
+			     ({}));
+
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+		uart_write_wakeup(&up->port);
+
+	if (uart_circ_empty(xmit))
+		__stop_tx(up);
+}
+
+static void ma35d1serial_start_tx(struct uart_port *port)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+	u32 ier;
+
+	ier = serial_in(up, UART_REG_IER);
+	serial_out(up, UART_REG_IER, ier & ~IER_THRE_IEN);
+	transmit_chars(up);
+	serial_out(up, UART_REG_IER, ier | IER_THRE_IEN);
+}
+
+static void ma35d1serial_stop_rx(struct uart_port *port)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+
+	serial_out(up, UART_REG_IER, serial_in(up, UART_REG_IER) & ~IER_RDA_IEN);
+}
+
+static void receive_chars(struct uart_ma35d1_port *up)
+{
+	u8 flag;
+	u32 fsr;
+	unsigned int ch;
+	int max_count = 256;
+
+	fsr = serial_in(up, UART_REG_FSR);
+	do {
+		flag = TTY_NORMAL;
+		up->port.icount.rx++;
+
+		if (unlikely(fsr & (FSR_BIF | FSR_FEF | FSR_PEF | FSR_RX_OVER_IF))) {
+			if (fsr & FSR_BIF) {
+				up->port.icount.brk++;
+				if (uart_handle_break(&up->port))
+					continue;
+			}
+			if (fsr & FSR_FEF)
+				up->port.icount.frame++;
+			if (fsr & FSR_PEF)
+				up->port.icount.parity++;
+			if (fsr & FSR_RX_OVER_IF)
+				up->port.icount.overrun++;
+
+			serial_out(up, UART_REG_FSR, fsr &
+				   (FSR_BIF | FSR_FEF | FSR_PEF | FSR_RX_OVER_IF));
+
+			if (fsr & FSR_BIF)
+				flag = TTY_BREAK;
+			else if (fsr & FSR_PEF)
+				flag = TTY_PARITY;
+			else if (fsr & FSR_FEF)
+				flag = TTY_FRAME;
+		}
+
+		ch = serial_in(up, UART_REG_RBR);
+		if (uart_handle_sysrq_char(&up->port, ch))
+			continue;
+
+		spin_lock(&up->port.lock);
+		uart_insert_char(&up->port, fsr, FSR_RX_OVER_IF, ch, flag);
+		spin_unlock(&up->port.lock);
+
+		fsr = serial_in(up, UART_REG_FSR);
+	} while (!(fsr & FSR_RX_EMPTY) && (max_count-- > 0));
+
+	spin_lock(&up->port.lock);
+	tty_flip_buffer_push(&up->port.state->port);
+	spin_unlock(&up->port.lock);
+}
+
+static irqreturn_t ma35d1serial_interrupt(int irq, void *dev_id)
+{
+	struct uart_port *port = dev_id;
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+	u32 isr, fsr;
+
+	isr = serial_in(up, UART_REG_ISR);
+	fsr = serial_in(up, UART_REG_FSR);
+
+	if (!(isr & UART_ISR_IF_CHECK))
+		return IRQ_NONE;
+
+	if (isr & (ISR_RDA_IF | ISR_RXTO_IF))
+		receive_chars(up);
+	if (isr & ISR_THRE_INT)
+		transmit_chars(up);
+	if (fsr & FSR_TX_OVER_IF)
+		serial_out(up, UART_REG_FSR, FSR_TX_OVER_IF);
+
+	return IRQ_HANDLED;
+}
+
+static u32 ma35d1serial_tx_empty(struct uart_port *port)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+	u32 fsr;
+
+	fsr = serial_in(up, UART_REG_FSR);
+	return (fsr & (FSR_TE_FLAG | FSR_TX_EMPTY)) ==
+		(FSR_TE_FLAG | FSR_TX_EMPTY) ? TIOCSER_TEMT : 0;
+}
+
+static u32 ma35d1serial_get_mctrl(struct uart_port *port)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+	u32 status;
+	u32 ret = 0;
+
+	status = serial_in(up, UART_REG_MSR);
+	if (!(status & MSR_CTSSTS))
+		ret |= TIOCM_CTS;
+	return ret;
+}
+
+static void ma35d1serial_set_mctrl(struct uart_port *port, u32 mctrl)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+	u32 mcr = 0;
+	u32 ier = 0;
+
+	if (mctrl & TIOCM_RTS) {
+		mcr = serial_in(up, UART_REG_MCR);
+		mcr |= MCR_RTSACTLV;
+		mcr &= ~MCR_RTS_CTRL;
+	}
+	if (up->mcr & UART_MCR_AFE) {
+		mcr = serial_in(up, UART_REG_MCR);
+		mcr |= MCR_RTSACTLV;
+		mcr &= ~MCR_RTS_CTRL;
+
+		serial_out(up, UART_REG_IER,
+			   (serial_in(up, UART_REG_IER) | IER_AUTO_RTS | IER_AUTO_CTS));
+
+		up->port.flags |= UPF_HARD_FLOW;
+	} else {
+		ier = serial_in(up, UART_REG_IER);
+		ier &= ~(IER_AUTO_RTS | IER_AUTO_CTS);
+		serial_out(up, UART_REG_IER, ier);
+
+		up->port.flags &= ~UPF_HARD_FLOW;
+	}
+	serial_out(up, UART_REG_MSR, (serial_in(up, UART_REG_MSR) | MSR_CTSACTLV));
+	serial_out(up, UART_REG_MCR, mcr);
+}
+
+static void ma35d1serial_break_ctl(struct uart_port *port, int break_state)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+	unsigned long flags;
+	u32 lcr;
+
+	spin_lock_irqsave(&up->port.lock, flags);
+	lcr = serial_in(up, UART_REG_LCR);
+	if (break_state != 0)
+		lcr |= LCR_BREAK;
+	else
+		lcr &= ~LCR_BREAK;
+	serial_out(up, UART_REG_LCR, lcr);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static int ma35d1serial_startup(struct uart_port *port)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+	int retval;
+
+	/* Reset FIFO */
+	serial_out(up, UART_REG_FCR, FCR_TFR | FCR_RFR);
+
+	/* Clear pending interrupts */
+	serial_out(up, UART_REG_ISR, ISR_ALL);
+
+	retval = request_irq(port->irq, ma35d1serial_interrupt, 0,
+			     dev_name(port->dev), port);
+	if (retval) {
+		dev_err(up->port.dev, "request irq failed.\n");
+		return retval;
+	}
+
+	serial_out(up, UART_REG_FCR, serial_in(up, UART_REG_FCR) |
+		   FCR_RFITL_4BYTES | FCR_RTSTRGLV_8BYTES);
+	serial_out(up, UART_REG_LCR, LCR_WLS_8BITS);
+	serial_out(up, UART_REG_TOR, UART_RX_TOUT);
+	serial_out(up, UART_REG_IER, IER_RTO_IEN | IER_RDA_IEN |
+		   IER_TIME_OUT_EN | IER_BUFERR_IEN);
+	return 0;
+}
+
+static void ma35d1serial_shutdown(struct uart_port *port)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+
+	serial_out(up, UART_REG_IER, 0);
+	free_irq(port->irq, port);
+}
+
+static u32 ma35d1serial_get_divisor(struct uart_port *port, u32 baud)
+{
+	return (port->uartclk / baud) - 2;
+}
+
+static void ma35d1serial_set_termios(struct uart_port *port,
+				     struct ktermios *termios,
+				     const struct ktermios *old)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+	u32 lcr = 0;
+	unsigned long flags;
+	u32 baud, quot;
+
+	lcr = UART_LCR_WLEN(tty_get_char_size(termios->c_cflag));
+
+	if (termios->c_cflag & CSTOPB)
+		lcr |= LCR_NSB;
+	if (termios->c_cflag & PARENB)
+		lcr |= LCR_PBE;
+	if (!(termios->c_cflag & PARODD))
+		lcr |= LCR_EPE;
+	if (termios->c_cflag & CMSPAR)
+		lcr |= LCR_SPE;
+
+	baud = uart_get_baud_rate(port, termios, old, port->uartclk / 0xffff,
+				  port->uartclk / 11);
+
+	quot = ma35d1serial_get_divisor(port, baud);
+
+	/*
+	 * Ok, we're now changing the port state.  Do it with
+	 * interrupts disabled.
+	 */
+	spin_lock_irqsave(&up->port.lock, flags);
+
+	up->port.read_status_mask = FSR_RX_OVER_IF;
+	if (termios->c_iflag & INPCK)
+		up->port.read_status_mask |= FSR_FEF | FSR_PEF;
+	if (termios->c_iflag & (BRKINT | PARMRK))
+		up->port.read_status_mask |= FSR_BIF;
+
+	/*
+	 * Characteres to ignore
+	 */
+	up->port.ignore_status_mask = 0;
+	if (termios->c_iflag & IGNPAR)
+		up->port.ignore_status_mask |= FSR_FEF | FSR_PEF;
+	if (termios->c_iflag & IGNBRK) {
+		up->port.ignore_status_mask |= FSR_BIF;
+		/*
+		 * If we're ignoring parity and break indicators,
+		 * ignore overruns too (for real raw support).
+		 */
+		if (termios->c_iflag & IGNPAR)
+			up->port.ignore_status_mask |= FSR_RX_OVER_IF;
+	}
+	if (termios->c_cflag & CRTSCTS)
+		up->mcr |= UART_MCR_AFE;
+	else
+		up->mcr &= ~UART_MCR_AFE;
+
+	uart_update_timeout(port, termios->c_cflag, baud);
+	ma35d1serial_set_mctrl(&up->port, up->port.mctrl);
+	serial_out(up, UART_REG_BAUD, quot | BAUD_MODE2);
+	serial_out(up, UART_REG_LCR, lcr);
+	spin_unlock_irqrestore(&up->port.lock, flags);
+}
+
+static const char *ma35d1serial_type(struct uart_port *port)
+{
+	return "ma35d1-uart";
+}
+
+static void ma35d1serial_config_port(struct uart_port *port, int flags)
+{
+	/*
+	 * Driver core for serial ports forces a non-zero value for port type.
+	 * Write an arbitrary value here to accommodate the serial core driver,
+	 * as ID part of UAPI is redundant.
+	 */
+	port->type = 1;
+}
+
+static int ma35d1serial_verify_port(struct uart_port *port,
+				struct serial_struct *ser)
+{
+	if (port->type != PORT_UNKNOWN && ser->type != 1)
+		return -EINVAL;
+
+	return 0;
+}
+
+static const struct uart_ops ma35d1serial_ops = {
+	.tx_empty     = ma35d1serial_tx_empty,
+	.set_mctrl    = ma35d1serial_set_mctrl,
+	.get_mctrl    = ma35d1serial_get_mctrl,
+	.stop_tx      = ma35d1serial_stop_tx,
+	.start_tx     = ma35d1serial_start_tx,
+	.stop_rx      = ma35d1serial_stop_rx,
+	.break_ctl    = ma35d1serial_break_ctl,
+	.startup      = ma35d1serial_startup,
+	.shutdown     = ma35d1serial_shutdown,
+	.set_termios  = ma35d1serial_set_termios,
+	.type         = ma35d1serial_type,
+	.config_port  = ma35d1serial_config_port,
+	.verify_port  = ma35d1serial_verify_port,
+};
+
+static const struct of_device_id ma35d1_serial_of_match[] = {
+	{ .compatible = "nuvoton,ma35d1-uart" },
+	{},
+};
+MODULE_DEVICE_TABLE(of, ma35d1_serial_of_match);
+
+#ifdef CONFIG_SERIAL_NUVOTON_MA35D1_CONSOLE
+
+static void wait_for_xmitr(struct uart_ma35d1_port *up)
+{
+	unsigned int tmout;
+
+	/* Wait up to 10ms for the character(s) to be sent. */
+	tmout = 10000;
+	while (--tmout) {
+		if (serial_in(up, UART_REG_FSR) & FSR_TX_EMPTY)
+			break;
+		udelay(1);
+	}
+}
+
+static void ma35d1serial_console_putchar(struct uart_port *port, unsigned char ch)
+{
+	struct uart_ma35d1_port *up = to_ma35d1_uart_port(port);
+
+	wait_for_xmitr(up);
+	serial_out(up, UART_REG_THR, ch);
+}
+
+/*
+ *  Print a string to the serial port trying not to disturb
+ *  any possible real use of the port...
+ *
+ *  The console_lock must be held when we get here.
+ */
+static void ma35d1serial_console_write(struct console *co,
+				       const char *s, u32 count)
+{
+	struct uart_ma35d1_port *up = &ma35d1serial_ports[co->index];
+	unsigned long flags;
+	u32 ier;
+
+	local_irq_save(flags);
+
+	/*
+	 *  First save the IER then disable the interrupts
+	 */
+	ier = serial_in(up, UART_REG_IER);
+	serial_out(up, UART_REG_IER, 0);
+
+	uart_console_write(&up->port, s, count, ma35d1serial_console_putchar);
+
+	wait_for_xmitr(up);
+
+	serial_out(up, UART_REG_IER, ier);
+	local_irq_restore(flags);
+}
+
+static int __init ma35d1serial_console_setup(struct console *co,
+					     char *options)
+{
+	struct device_node *np = ma35d1serial_uart_nodes[co->index];
+	struct uart_ma35d1_port *p = &ma35d1serial_ports[co->index];
+	u32 val32[4];
+	struct uart_port *port;
+	int baud = 115200;
+	int bits = 8;
+	int parity = 'n';
+	int flow = 'n';
+
+	/*
+	 * Check whether an invalid uart number has been specified, and
+	 * if so, search for the first available port that does have
+	 * console support.
+	 */
+	if ((co->index < 0) || (co->index >= UART_NR)) {
+		pr_debug("Console Port%x out of range\n", co->index);
+		return -EINVAL;
+	}
+
+	if (of_property_read_u32_array(np, "reg", val32, 4) != 0)
+		return -EINVAL;
+	p->port.iobase = val32[1];
+	p->port.membase = ioremap(p->port.iobase, UART_REG_SIZE);
+	p->port.ops = &ma35d1serial_ops;
+	p->port.line = 0;
+	p->port.uartclk = UART_CONSOLE_CLK;
+
+	port = &ma35d1serial_ports[co->index].port;
+	return uart_set_options(port, co, baud, parity, bits, flow);
+}
+
+static struct console ma35d1serial_console = {
+	.name    = "ttyS",
+	.write   = ma35d1serial_console_write,
+	.device  = uart_console_device,
+	.setup   = ma35d1serial_console_setup,
+	.flags   = CON_PRINTBUFFER | CON_ENABLED,
+	.index   = -1,
+	.data    = &ma35d1serial_reg,
+};
+
+static void ma35d1serial_console_init_port(void)
+{
+	int i = 0;
+	struct device_node *np;
+
+	for_each_matching_node(np, ma35d1_serial_of_match) {
+		if (ma35d1serial_uart_nodes[i] == NULL) {
+			of_node_get(np);
+			ma35d1serial_uart_nodes[i] = np;
+			i++;
+			if (i == UART_NR)
+				break;
+		}
+	}
+}
+
+static int __init ma35d1serial_console_init(void)
+{
+	ma35d1serial_console_init_port();
+	register_console(&ma35d1serial_console);
+	return 0;
+}
+console_initcall(ma35d1serial_console_init);
+
+#define MA35D1SERIAL_CONSOLE    (&ma35d1serial_console)
+#else
+#define MA35D1SERIAL_CONSOLE    NULL
+#endif
+
+static struct uart_driver ma35d1serial_reg = {
+	.owner        = THIS_MODULE,
+	.driver_name  = "serial",
+	.dev_name     = "ttyS",
+	.major        = TTY_MAJOR,
+	.minor        = 64,
+	.cons         = MA35D1SERIAL_CONSOLE,
+	.nr           = UART_NR,
+};
+
+/*
+ * Register a set of serial devices attached to a platform device.
+ * The list is terminated with a zero flags entry, which means we expect
+ * all entries to have at least UPF_BOOT_AUTOCONF set.
+ */
+static int ma35d1serial_probe(struct platform_device *pdev)
+{
+	struct resource *res_mem;
+	struct uart_ma35d1_port *up;
+	int ret;
+	struct clk *clk;
+	int err;
+
+	if (pdev->dev.of_node) {
+		ret = of_alias_get_id(pdev->dev.of_node, "serial");
+		if (ret < 0) {
+			dev_err(&pdev->dev, "failed to get alias/pdev id, errno %d\n", ret);
+			return ret;
+		}
+	}
+	up = &ma35d1serial_ports[ret];
+	up->port.line = ret;
+	res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res_mem)
+		return -ENODEV;
+
+	up->port.iobase = res_mem->start;
+	up->port.membase = ioremap(up->port.iobase, UART_REG_SIZE);
+	up->port.ops = &ma35d1serial_ops;
+
+	spin_lock_init(&up->port.lock);
+
+	clk = of_clk_get(pdev->dev.of_node, 0);
+	if (IS_ERR(clk)) {
+		err = PTR_ERR(clk);
+		dev_err(&pdev->dev, "failed to get core clk: %d\n", err);
+		return -ENOENT;
+	}
+	err = clk_prepare_enable(clk);
+	if (err)
+		return -ENOENT;
+
+	if (up->port.line != 0)
+		up->port.uartclk = clk_get_rate(clk);
+	up->port.irq = platform_get_irq(pdev, 0);
+	up->port.dev = &pdev->dev;
+	up->port.flags = UPF_BOOT_AUTOCONF;
+	ret = uart_add_one_port(&ma35d1serial_reg, &up->port);
+	platform_set_drvdata(pdev, up);
+	return 0;
+}
+
+/*
+ * Remove serial ports registered against a platform device.
+ */
+static int ma35d1serial_remove(struct platform_device *dev)
+{
+	struct uart_port *port = platform_get_drvdata(dev);
+
+	if (port) {
+		uart_remove_one_port(&ma35d1serial_reg, port);
+		free_irq(port->irq, port);
+	}
+	return 0;
+}
+
+static int ma35d1serial_suspend(struct platform_device *dev, pm_message_t state)
+{
+	int i;
+	struct uart_ma35d1_port *up;
+
+	if (dev->dev.of_node)
+		i = of_alias_get_id(dev->dev.of_node, "serial");
+	if (i < 0) {
+		dev_err(&dev->dev, "failed to get alias/pdev id, errno %d\n", i);
+		return i;
+	}
+	up = &ma35d1serial_ports[i];
+	if (i == 0) {
+		up->console_baud_rate = serial_in(up, UART_REG_BAUD);
+		up->console_line = serial_in(up, UART_REG_LCR);
+		up->console_int = serial_in(up, UART_REG_IER);
+	}
+	return 0;
+}
+
+static int ma35d1serial_resume(struct platform_device *dev)
+{
+	int i;
+	struct uart_ma35d1_port *up;
+
+	if (dev->dev.of_node)
+		i = of_alias_get_id(dev->dev.of_node, "serial");
+	if (i < 0) {
+		dev_err(&dev->dev, "failed to get alias/pdev id, errno %d\n", i);
+		return i;
+	}
+	up = &ma35d1serial_ports[i];
+	if (i == 0) {
+		serial_out(up, UART_REG_BAUD, up->console_baud_rate);
+		serial_out(up, UART_REG_LCR, up->console_line);
+		serial_out(up, UART_REG_IER, up->console_int);
+	}
+	return 0;
+}
+
+static struct platform_driver ma35d1serial_driver = {
+	.probe      = ma35d1serial_probe,
+	.remove     = ma35d1serial_remove,
+	.suspend    = ma35d1serial_suspend,
+	.resume     = ma35d1serial_resume,
+	.driver     = {
+		.name   = "ma35d1-uart",
+		.owner  = THIS_MODULE,
+		.of_match_table = of_match_ptr(ma35d1_serial_of_match),
+	},
+};
+
+static int __init ma35d1serial_init(void)
+{
+	int ret;
+
+	ret = uart_register_driver(&ma35d1serial_reg);
+	if (ret)
+		return ret;
+	ret = platform_driver_register(&ma35d1serial_driver);
+	if (ret)
+		uart_unregister_driver(&ma35d1serial_reg);
+	return ret;
+}
+
+static void __exit ma35d1serial_exit(void)
+{
+	platform_driver_unregister(&ma35d1serial_driver);
+	uart_unregister_driver(&ma35d1serial_reg);
+}
+
+module_init(ma35d1serial_init);
+module_exit(ma35d1serial_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MA35D1 serial driver");
+MODULE_ALIAS_CHARDEV_MAJOR(TTY_MAJOR);
+
-- 
2.34.1

