Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0377A7184C0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjEaOWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 10:22:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237549AbjEaOWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 10:22:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12E51A7;
        Wed, 31 May 2023 07:21:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 04FC063CBC;
        Wed, 31 May 2023 14:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F042C433EF;
        Wed, 31 May 2023 14:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685542873;
        bh=GR201WusWaVuJRFRW4qMwM55zgR7q/8W7rYwmVCAMtY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UBFg9A8m3t6uFsCSmRXbWreOaSgtjWsXepKzuTAhVAT+aHKVotkzoNIQfAaGNxlmy
         6E8PWCkW4dBEmlfU4bT/7ZoZOAxYLKx9puphCKefWMvrmqSwNQ9lnjY7FlGozeiik2
         qzJKOmsQuUxIrimjGhbjqbNzszXvjTLEKIM54axc6cH125hLktin8SKEKJsbovWk5j
         GzKboFmOmX6D4Ugufhz3kNWWLiMxW23UWsjyWTe1kfvwU5nzW/+WWz9ocxdjRU7ZCp
         BQrXA+kPFi6Gu0ziXHxAzoZsiXkIzCWEGwG3K1FyBvxWuL5fL7mpLq8S88KmahwtOg
         TfiSc8c8lmfIw==
Date:   Wed, 31 May 2023 22:09:56 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-serial@vger.kernel.org
Subject: Re: [PATCH v4 04/10] serial: bflb_uart: add Bouffalolab UART Driver
Message-ID: <ZHdVNIQpgfCzimRg@xhacker>
References: <20230518152244.2178-1-jszhang@kernel.org>
 <20230518152244.2178-5-jszhang@kernel.org>
 <2023053010-gondola-luminous-f5e7@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023053010-gondola-luminous-f5e7@gregkh>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:36:00AM +0100, Greg Kroah-Hartman wrote:
> On Thu, May 18, 2023 at 11:22:38PM +0800, Jisheng Zhang wrote:
> > Add the driver for Bouffalolab UART IP which is found in Bouffalolab
> > SoCs such as bl808.
> 
> New uarts are being created that are NOT 8250-like?  Why????

Hi,

I'm not sure I understand your meaning. I guess you mean writing the new
uart driver following 8250 style. And the latest example is
sunplus-uart.c, it can be used as an example how to write a 8250 style
driver for new non-8250 uart IP. 

If the above guesses are wrong, could you please provide more details?

Thanks

> 
> 
> > 
> > UART driver probe will create path named "/dev/ttySx".
> > 
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  drivers/tty/serial/Kconfig       |  18 +
> >  drivers/tty/serial/Makefile      |   1 +
> >  drivers/tty/serial/bflb_uart.c   | 586 +++++++++++++++++++++++++++++++
> >  include/uapi/linux/serial_core.h |   3 +
> >  4 files changed, 608 insertions(+)
> >  create mode 100644 drivers/tty/serial/bflb_uart.c
> > 
> > diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> > index 398e5aac2e77..abc30a0713f5 100644
> > --- a/drivers/tty/serial/Kconfig
> > +++ b/drivers/tty/serial/Kconfig
> > @@ -179,6 +179,24 @@ config SERIAL_ATMEL_TTYAT
> >  
> >  	  Say Y if you have an external 8250/16C550 UART.  If unsure, say N.
> >  
> > +config SERIAL_BFLB
> > +	tristate "Bouffalolab serial port support"
> > +	select SERIAL_CORE
> > +	depends on COMMON_CLK
> > +	help
> > +	  This enables the driver for the Bouffalolab's serial.
> > +
> > +config SERIAL_BFLB_CONSOLE
> > +	bool "Support for console on Bouffalolab serial port"
> > +	depends on SERIAL_BFLB=y
> > +	select SERIAL_CORE_CONSOLE
> > +	select SERIAL_EARLYCON
> > +	help
> > +	  Say Y here if you wish to use a Bouffalolab UART as the
> > +	  system console (the system console is the device which
> > +	  receives all kernel messages and warnings and which allows
> > +	  logins in single user mode) as /dev/ttySn.
> > +
> >  config SERIAL_KGDB_NMI
> >  	bool "Serial console over KGDB NMI debugger port"
> >  	depends on KGDB_SERIAL_CONSOLE
> > diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
> > index cd9afd9e3018..5788a708d327 100644
> > --- a/drivers/tty/serial/Makefile
> > +++ b/drivers/tty/serial/Makefile
> > @@ -25,6 +25,7 @@ obj-$(CONFIG_SERIAL_8250) += 8250/
> >  
> >  obj-$(CONFIG_SERIAL_AMBA_PL010) += amba-pl010.o
> >  obj-$(CONFIG_SERIAL_AMBA_PL011) += amba-pl011.o
> > +obj-$(CONFIG_SERIAL_BFLB) += bflb_uart.o
> >  obj-$(CONFIG_SERIAL_CLPS711X) += clps711x.o
> >  obj-$(CONFIG_SERIAL_PXA_NON8250) += pxa.o
> >  obj-$(CONFIG_SERIAL_SA1100) += sa1100.o
> > diff --git a/drivers/tty/serial/bflb_uart.c b/drivers/tty/serial/bflb_uart.c
> > new file mode 100644
> > index 000000000000..3f80bba8599a
> > --- /dev/null
> > +++ b/drivers/tty/serial/bflb_uart.c
> > @@ -0,0 +1,586 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * Based on bflb_uart.c, by Bouffalolab team
> > + *
> > + * Copyright (C) 2022 Jisheng Zhang <jszhang@kernel.org>
> 
> It is 2023 :)
> 
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/console.h>
> > +#include <linux/kernel.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/serial.h>
> > +#include <linux/serial_core.h>
> > +#include <linux/tty.h>
> > +#include <linux/tty_flip.h>
> > +
> > +#define UART_UTX_CONFIG			0x00
> > +#define  UART_CR_UTX_EN			BIT(0)
> > +#define  UART_CR_UTX_CTS_EN		BIT(1)
> > +#define  UART_CR_UTX_FRM_EN		BIT(2)
> > +#define  UART_CR_UTX_PRT_EN		BIT(4)
> > +#define  UART_CR_UTX_PRT_SEL		BIT(5)
> > +#define  UART_CR_UTX_BIT_CNT_D_MSK	GENMASK(10, 8)
> > +#define  UART_CR_UTX_BIT_CNT_P_MSK	GENMASK(12, 11)
> > +#define UART_URX_CONFIG			0x04
> > +#define  UART_CR_URX_EN			BIT(0)
> > +#define  UART_CR_URX_PRT_EN		BIT(4)
> > +#define  UART_CR_URX_PRT_SEL		BIT(5)
> > +#define  UART_CR_URX_BIT_CNT_D_MSK	GENMASK(10, 8)
> > +#define UART_BIT_PRD			0x08
> > +#define  UART_CR_UTX_BIT_PRD_MSK	GENMASK(15, 0)
> > +#define  UART_CR_URX_BIT_PRD_MSK	GENMASK(31, 16)
> > +#define UART_DATA_CONFIG		0x0c
> > +#define  UART_CR_UART_BIT_INV		BIT(0)
> > +#define UART_URX_RTO_TIMER		0x18
> > +#define  UART_CR_URX_RTO_VALUE_MSK	GENMASK(7, 0)
> > +#define UART_SW_MODE			0x1c
> > +#define UART_INT_STS			0x20
> > +#define  UART_UTX_END_INT		BIT(0)
> > +#define  UART_URX_END_INT		BIT(1)
> > +#define  UART_UTX_FIFO_INT		BIT(2)
> > +#define  UART_URX_FIFO_INT		BIT(3)
> > +#define  UART_URX_RTO_INT		BIT(4)
> > +#define  UART_URX_PCE_INT		BIT(5)
> > +#define  UART_UTX_FER_INT		BIT(6)
> > +#define  UART_URX_FER_INT		BIT(7)
> > +#define  UART_URX_LSE_INT		BIT(8)
> > +#define UART_INT_MASK			0x24
> > +#define UART_INT_CLEAR			0x28
> > +#define UART_INT_EN			0x2c
> > +#define UART_STATUS			0x30
> > +#define  UART_STS_UTX_BUS_BUSY		BIT(0)
> > +#define UART_FIFO_CONFIG_0		0x80
> > +#define  UART_DMA_TX_EN			BIT(0)
> > +#define  UART_DMA_RX_EN			BIT(1)
> > +#define  UART_TX_FIFO_CLR		BIT(2)
> > +#define  UART_RX_FIFO_CLR		BIT(3)
> > +#define  UART_TX_FIFO_OVERFLOW		BIT(4)
> > +#define  UART_TX_FIFO_UNDERFLOW		BIT(5)
> > +#define  UART_RX_FIFO_OVERFLOW		BIT(6)
> > +#define  UART_RX_FIFO_UNDERFLOW		BIT(7)
> > +#define UART_FIFO_CONFIG_1		0x84
> > +#define  UART_TX_FIFO_CNT_MSK		GENMASK(5, 0)
> > +#define  UART_RX_FIFO_CNT_MSK		GENMASK(13, 8)
> > +#define  UART_TX_FIFO_TH_MSK		GENMASK(20, 16)
> > +#define  UART_RX_FIFO_TH_MSK		GENMASK(28, 24)
> > +#define UART_FIFO_WDATA			0x88
> > +#define UART_FIFO_RDATA			0x8c
> > +#define  UART_FIFO_RDATA_MSK		GENMASK(7, 0)
> > +
> > +#define BFLB_UART_MAXPORTS		8
> > +#define BFLB_UART_BAUD			2000000
> > +#define BFLB_UART_RX_FIFO_TH		7
> > +#define BFLB_UART_TX_FIFO_TH		15
> > +#define BFLB_UART_URX_RTO_TIME		0x4f
> > +
> > +struct bflb_uart_port {
> > +	struct uart_port port;
> > +	struct clk *clk;
> > +};
> > +
> > +static struct bflb_uart_port *bflb_uart_ports[BFLB_UART_MAXPORTS];
> > +
> > +static inline u32 rdl(struct uart_port *port, u32 reg)
> > +{
> > +	return readl_relaxed(port->membase + reg);
> > +}
> > +
> > +static inline void wrl(struct uart_port *port, u32 reg, u32 value)
> > +{
> > +	writel_relaxed(value, port->membase + reg);
> > +}
> > +
> > +static inline void wrb(struct uart_port *port, u32 reg, u8 value)
> > +{
> > +	writeb_relaxed(value, port->membase + reg);
> > +}
> > +
> > +static unsigned int bflb_uart_tx_empty(struct uart_port *port)
> > +{
> > +	return (rdl(port, UART_FIFO_CONFIG_1) & UART_TX_FIFO_CNT_MSK) ? TIOCSER_TEMT : 0;
> > +}
> > +
> > +static unsigned int bflb_uart_get_mctrl(struct uart_port *port)
> > +{
> > +	return TIOCM_CAR | TIOCM_DSR | TIOCM_CTS;
> > +}
> > +
> > +static void bflb_uart_set_mctrl(struct uart_port *port, unsigned int sigs)
> > +{
> > +}
> 
> Why is a blank function required here?
> 
> 
> > --- a/include/uapi/linux/serial_core.h
> > +++ b/include/uapi/linux/serial_core.h
> > @@ -279,4 +279,7 @@
> >  /* Sunplus UART */
> >  #define PORT_SUNPLUS	123
> >  
> > +/* Bouffalolab UART */
> > +#define PORT_BFLB	124
> 
> Why is this required?  What userspace code is going to need this?
> 
> thanks,
> 
> greg k-h
