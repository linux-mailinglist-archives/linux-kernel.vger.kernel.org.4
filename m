Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD3A6CEF79
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 18:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjC2Qbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 12:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjC2Qbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 12:31:37 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38B06A7C;
        Wed, 29 Mar 2023 09:31:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E0704CE2471;
        Wed, 29 Mar 2023 16:31:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A577C433D2;
        Wed, 29 Mar 2023 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680107464;
        bh=s1Ut6jqWzvH4yOb8a6S2poi/OAOS+Fs1ddYYHAgF8Bw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X3KhZWSpKv92omHGrYZK8vPzSkNb3/O8PRH1Ef6Xu1FOuqwfm1wnF+mAY/davUj/6
         LCPNrKu2rZjoZsIwRdKVYGjubm4k0PxO0IY/D/nucmG3JeTVEYW6DW3hADEyQ15WwR
         j8/l1mPxsem6Zo7K4e2n0w6rsPBLl8zcsBjNiW4s=
Date:   Wed, 29 Mar 2023 18:30:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Brenda Streiff <brenda.streiff@ni.com>
Cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
Message-ID: <ZCRnwDa8kpuz7GwJ@kroah.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com>
 <20230329154235.615349-3-brenda.streiff@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329154235.615349-3-brenda.streiff@ni.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:42:35AM -0500, Brenda Streiff wrote:
> The National Instruments (NI) 16550 is a 16550-like UART with larger
> FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
> patch adds a driver that can operate this UART, which is used for
> onboard serial ports in several NI embedded controller designs.

People are still making new 8250-like variants with different ways of
controlling them these days?  That's the design pattern that will not
die, or at least, it keeps getting a "value-add" :(

> 
> Portions of this driver were originally written by Jaeden Amero and
> Karthik Manamcheri, with extensive cleanups and refactors since.
> 
> Signed-off-by: Brenda Streiff <brenda.streiff@ni.com>
> Cc: Gratian Crisan <gratian.crisan@ni.com>
> Cc: Jason Smith <jason.smith@ni.com>
> ---
>  MAINTAINERS                       |   7 +
>  drivers/tty/serial/8250/8250_ni.c | 447 ++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig   |   9 +
>  drivers/tty/serial/8250/Makefile  |   1 +
>  4 files changed, 464 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_ni.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d8ebab595b2a..c5283a7385fa 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14322,6 +14322,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
>  F:	drivers/mtd/nand/
>  F:	include/linux/mtd/*nand*.h
>  
> +NATIONAL INSTRUMENTS SERIAL DRIVER
> +M:	Brenda Streiff <brenda.streiff@ni.com>
> +L:	linux-serial@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/serial/ni,ni16550.yaml
> +F:	drivers/tty/serial/8250/8250_ni.c
> +
>  NATIVE INSTRUMENTS USB SOUND INTERFACE DRIVER
>  M:	Daniel Mack <zonque@gmail.com>
>  L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
> diff --git a/drivers/tty/serial/8250/8250_ni.c b/drivers/tty/serial/8250/8250_ni.c
> new file mode 100644
> index 000000000000..8bd9768576a7
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_ni.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0+

Do you really mean "+"?  Sorry, I have to ask.

> +/*
> + * NI 16550 UART Driver
> + *
> + * The National Instruments (NI) 16550 is a UART that is compatible with the
> + * TL16C550C and OX16C950B register interfaces, but has additional functions
> + * for RS-485 transceiver control. This driver implements support for the
> + * additional functionality on top of the standard serial8250 core.
> + *
> + * Copyright 2012-2023 National Instruments Corporation

Um, 2012 and every year since then?  You all have had an out-of-tree
driver for 11+ years that has been constantly updated every year?

> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/device.h>
> +#include <linux/io.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/property.h>
> +
> +#include "8250.h"
> +
> +/* Extra bits in UART_ACR */
> +#define NI16550_ACR_AUTO_DTR_EN			BIT(4)
> +
> +/* TFS - TX FIFO Size */
> +#define NI16550_TFS_OFFSET	0x0C
> +/* RFS - RX FIFO Size */
> +#define NI16550_RFS_OFFSET	0x0D
> +
> +/* PMR - Port Mode Register */
> +#define NI16550_PMR_OFFSET	0x0E
> +/* PMR[1:0] - Port Capabilities */
> +#define NI16550_PMR_CAP_MASK			0x03
> +#define NI16550_PMR_NOT_IMPL			0x00 /* not implemented */
> +#define NI16550_PMR_CAP_RS232			0x01 /* RS-232 capable */
> +#define NI16550_PMR_CAP_RS485			0x02 /* RS-485 capable */
> +#define NI16550_PMR_CAP_DUAL			0x03 /* dual-port */
> +/* PMR[4] - Interface Mode */
> +#define NI16550_PMR_MODE_MASK			0x10
> +#define NI16550_PMR_MODE_RS232			0x00 /* currently 232 */
> +#define NI16550_PMR_MODE_RS485			0x10 /* currently 485 */
> +
> +/* PCR - Port Control Register */
> +#define NI16550_PCR_OFFSET	0x0F
> +#define NI16550_PCR_RS422			0x00
> +#define NI16550_PCR_ECHO_RS485			0x01
> +#define NI16550_PCR_DTR_RS485			0x02
> +#define NI16550_PCR_AUTO_RS485			0x03
> +#define NI16550_PCR_WIRE_MODE_MASK		0x03
> +#define NI16550_PCR_TXVR_ENABLE_BIT		BIT(3)
> +#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
> +
> +/* flags for ni16550_device_info */
> +#define NI_HAS_PMR		BIT(0)
> +
> +struct ni16550_device_info {
> +	unsigned int uartclk;
> +	uint8_t prescaler;

Please use proper kernel types, u8.

> +	unsigned int flags;

And that's a horrible packing, do you mean to have those offsets?

And why "unsigned int", don't you mean "u64" or "u32"?

> +};
> +
> +struct ni16550_data {
> +	int line;
> +};
> +
> +static int ni16550_enable_transceivers(struct uart_port *port)
> +{
> +	uint8_t pcr;
> +
> +	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
> +	pcr |= NI16550_PCR_TXVR_ENABLE_BIT;
> +	dev_dbg(port->dev, "enable transceivers: write pcr: 0x%02x\n", pcr);
> +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
> +
> +	return 0;
> +}
> +
> +static int ni16550_disable_transceivers(struct uart_port *port)
> +{
> +	uint8_t pcr;
> +
> +	pcr = port->serial_in(port, NI16550_PCR_OFFSET);
> +	pcr &= ~NI16550_PCR_TXVR_ENABLE_BIT;
> +	dev_dbg(port->dev, "disable transceivers: write pcr: 0x%02x\n", pcr);
> +	port->serial_out(port, NI16550_PCR_OFFSET, pcr);
> +
> +	return 0;
> +}
> +
> +static int ni16550_rs485_config(struct uart_port *port,
> +				struct ktermios *termios,
> +				struct serial_rs485 *rs485)
> +{
> +	uint8_t pcr;
> +	struct uart_8250_port *up = container_of(port, struct uart_8250_port,
> +						 port);
> +
> +	/* "rs485" should be given to us non-NULL. */
> +	if (WARN_ON(rs485 == NULL))

Can this ever happen?  If not, don't check for it, otherwise you just
rebooted a machine that has panic-on-warn enabled :(

> +		return -EINVAL;

Or better yet, handle the case and return the error, why the WARN_ON()?

> +
> +	pcr = serial_in(up, NI16550_PCR_OFFSET);
> +	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* RS-485 */
> +		dev_vdbg(port->dev, "2-wire Auto\n");

Why "dev_vdbg()"?  Why not just "dev_dbg()"?  When are you going to
rebuild this code to enable the "dev_vdbg()" lines?

> +		pcr |= NI16550_PCR_AUTO_RS485;
> +		up->acr |= NI16550_ACR_AUTO_DTR_EN;
> +	} else {
> +		/* RS-422 */
> +		dev_vdbg(port->dev, "4-wire\n");
> +		pcr |= NI16550_PCR_RS422;
> +		up->acr &= ~NI16550_ACR_AUTO_DTR_EN;
> +	}
> +
> +	dev_dbg(port->dev, "config rs485: write pcr: 0x%02x, acr: %02x\n", pcr, up->acr);
> +	serial_out(up, NI16550_PCR_OFFSET, pcr);
> +	serial_icr_write(up, UART_ACR, up->acr);
> +
> +	return 0;
> +}
> +
> +static bool is_pmr_rs232_mode(struct uart_8250_port *up)
> +{
> +	uint8_t pmr = serial_in(up, NI16550_PMR_OFFSET);

Again, proper kernel types everywhere please "u8".

> +
> +	/*
> +	 * If the PMR is not implemented, then by default NI UARTs are
> +	 * connected to RS-485 transceivers
> +	 */
> +	if ((pmr & NI16550_PMR_CAP_MASK) == NI16550_PMR_NOT_IMPL)
> +		return false;
> +
> +	if ((pmr & NI16550_PMR_CAP_MASK) == NI16550_PMR_CAP_DUAL)
> +		/*
> +		 * If the port is dual-mode capable, then read the mode bit
> +		 * to know the current mode
> +		 */
> +		return ((pmr & NI16550_PMR_MODE_MASK)
> +					== NI16550_PMR_MODE_RS232);
> +	else
> +		/*
> +		 * If it is not dual-mode capable, then decide based on the
> +		 * capability
> +		 */
> +		return ((pmr & NI16550_PMR_CAP_MASK) == NI16550_PMR_CAP_RS232);
> +}
> +
> +static void ni16550_config_prescaler(struct uart_8250_port *up,
> +				     uint8_t prescaler)
> +{
> +	/*
> +	 * Page in the Enhanced Mode Registers
> +	 * Sets EFR[4] for Enhanced Mode.
> +	 */
> +	uint8_t lcr_value;
> +	uint8_t efr_value;
> +
> +	lcr_value = serial_in(up, UART_LCR);
> +	serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> +
> +	efr_value = serial_in(up, UART_EFR);
> +	efr_value |= UART_EFR_ECB;
> +
> +	serial_out(up, UART_EFR, efr_value);
> +
> +	/* Page out the Enhanced Mode Registers */
> +	serial_out(up, UART_LCR, lcr_value);
> +
> +	/* Set prescaler to CPR register. */
> +	serial_out(up, UART_SCR, UART_CPR);
> +	serial_out(up, UART_ICR, prescaler);
> +}
> +
> +static const struct serial_rs485 ni16550_rs485_supported = {
> +	.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND | SER_RS485_RTS_AFTER_SEND,
> +};
> +
> +static void ni16550_rs485_setup(struct uart_port *port)
> +{
> +	port->rs485_config = ni16550_rs485_config;
> +	port->rs485_supported = ni16550_rs485_supported;
> +	/*
> +	 * The hardware comes up by default in 2-wire auto mode and we
> +	 * set the flags to represent that
> +	 */
> +	port->rs485.flags = SER_RS485_ENABLED | SER_RS485_RTS_ON_SEND;
> +}
> +
> +static int ni16550_port_startup(struct uart_port *port)
> +{
> +	int ret;
> +
> +	ret = serial8250_do_startup(port);
> +	if (ret)
> +		return ret;
> +
> +	return ni16550_enable_transceivers(port);
> +}
> +
> +static void ni16550_port_shutdown(struct uart_port *port)
> +{
> +	ni16550_disable_transceivers(port);
> +
> +	serial8250_do_shutdown(port);
> +}
> +
> +static int ni16550_get_regs(struct platform_device *pdev,
> +			    struct uart_port *port)
> +{
> +	struct resource *regs;
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_IO, 0);
> +	if (regs) {
> +		port->iotype = UPIO_PORT;
> +		port->iobase = regs->start;
> +
> +		return 0;
> +	}
> +
> +	regs = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (regs) {
> +		port->iotype  = UPIO_MEM;
> +		port->mapbase = regs->start;
> +		port->mapsize = resource_size(regs);
> +		port->flags   |= UPF_IOREMAP;
> +
> +		port->membase = devm_ioremap(&pdev->dev, port->mapbase,
> +					     port->mapsize);
> +		if (!port->membase)
> +			return -ENOMEM;
> +
> +		return 0;
> +	}
> +
> +	dev_err(&pdev->dev, "no registers defined\n");
> +	return -EINVAL;
> +}
> +
> +static int ni16550_read_fifo_size(struct uart_8250_port *uart, int reg)

Why not return "u8"?

> +{
> +	/*
> +	 * Very old implementations don't have the TFS or RFS registers
> +	 * defined, so we may read all-0s or all-1s. For such devices,
> +	 * assume a FIFO size of 128.
> +	 */
> +	int value = serial_in(uart, reg);

Again, u8?


> +
> +	if (value == 0x00 || value == 0xFF)
> +		return 128;
> +
> +	return value;
> +}
> +
> +static void ni16550_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +	mctrl |= UART_MCR_CLKSEL;
> +
> +	serial8250_do_set_mctrl(port, mctrl);
> +}
> +
> +static int ni16550_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uart_8250_port uart = {};
> +	struct ni16550_data *data;
> +	const struct ni16550_device_info *info;
> +	int ret = 0;
> +	int irq;
> +	int rs232_property = 0;
> +	unsigned int prescaler;
> +	const char *transceiver;
> +	int txfifosz, rxfifosz;
> +
> +	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
> +	if (!data)
> +		return -ENOMEM;
> +
> +	spin_lock_init(&uart.port.lock);
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = ni16550_get_regs(pdev, &uart.port);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* early setup so that serial_in()/serial_out() work */
> +	serial8250_set_defaults(&uart);
> +
> +	info = device_get_match_data(dev);
> +
> +	uart.port.dev		= dev;
> +	uart.port.irq		= irq;
> +	uart.port.irqflags	= IRQF_SHARED;
> +	uart.port.flags		|= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
> +					| UPF_FIXED_PORT | UPF_FIXED_TYPE;
> +	uart.port.startup	= ni16550_port_startup;
> +	uart.port.shutdown	= ni16550_port_shutdown;
> +
> +	/*
> +	 * Hardware instantiation of FIFO sizes are held in registers.
> +	 */
> +	txfifosz = ni16550_read_fifo_size(&uart, NI16550_TFS_OFFSET);
> +	rxfifosz = ni16550_read_fifo_size(&uart, NI16550_RFS_OFFSET);
> +
> +	dev_dbg(dev, "NI 16550 has TX FIFO size %d, RX FIFO size %d\n",
> +		txfifosz, rxfifosz);
> +
> +	uart.port.type		= PORT_16550A;
> +	uart.port.fifosize	= txfifosz;
> +	uart.tx_loadsz		= txfifosz;
> +	uart.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10;
> +	uart.capabilities	= UART_CAP_FIFO | UART_CAP_AFE | UART_CAP_EFR;
> +
> +	/*
> +	 * OF device-tree and NIC7A69 ACPI can declare clock-frequency,
> +	 * but may be missing for other instantiations, so this is optional.
> +	 * If present, override what we've defined in this driver.
> +	 */
> +	if (info->uartclk)
> +		uart.port.uartclk = info->uartclk;
> +	device_property_read_u32(dev, "clock-frequency", &uart.port.uartclk);
> +	if (!uart.port.uartclk) {
> +		dev_err(dev, "unable to determine clock frequency!\n");
> +		return -ENODEV;
> +	}
> +
> +	if (info->prescaler)
> +		prescaler = info->prescaler;
> +	device_property_read_u32(dev, "clock-prescaler", &prescaler);
> +
> +	if (prescaler != 0) {
> +		uart.port.set_mctrl = ni16550_set_mctrl;
> +		ni16550_config_prescaler(&uart, (uint8_t)prescaler);
> +	}
> +
> +	/*
> +	 * The determination of whether or not this is an RS-485 or RS-232 port
> +	 * can come from the "transceiver" device property (if present), or it
> +	 * can come from the PMR (if it is present), and otherwise we're solely
> +	 * an RS-485 port.
> +	 */
> +	if (!device_property_read_string(dev, "transceiver", &transceiver)) {
> +		rs232_property = strncmp(transceiver, "RS-232", 6) == 0;
> +
> +		dev_dbg(dev, "port is in %s mode (via device property)",
> +			(rs232_property ? "RS-232" : "RS-485"));
> +	} else if (info->flags & NI_HAS_PMR) {
> +		rs232_property = is_pmr_rs232_mode(&uart);
> +
> +		dev_dbg(dev, "port is in %s mode (via PMR)",
> +			(rs232_property ? "RS-232" : "RS-485"));
> +	} else {
> +		rs232_property = 0;
> +
> +		dev_dbg(dev, "port is fixed as RS-485");
> +	}
> +
> +	if (!rs232_property) {
> +		/*
> +		 * Neither the 'transceiver' property nor the PMR indicate
> +		 * that this is an RS-232 port, so it must be an RS-485 one.
> +		 */
> +		ni16550_rs485_setup(&uart.port);
> +	}
> +
> +	ret = serial8250_register_8250_port(&uart);
> +	if (ret < 0)
> +		return ret;
> +
> +	data->line = ret;
> +
> +	platform_set_drvdata(pdev, data);
> +
> +	return 0;
> +}
> +
> +static int ni16550_remove(struct platform_device *pdev)
> +{
> +	struct ni16550_data *data = platform_get_drvdata(pdev);
> +
> +	serial8250_unregister_port(data->line);
> +	return 0;
> +}
> +
> +static const struct ni16550_device_info ni16550_default = { };
> +
> +static const struct of_device_id ni16550_of_match[] = {
> +	{ .compatible = "ni,ni16550", .data = &ni16550_default },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, ni16550_of_match);
> +
> +/* NI 16550 RS-485 Interface */
> +static const struct ni16550_device_info nic7750 = {
> +	.uartclk = 33333333,
> +};
> +
> +/* NI CVS-145x RS-485 Interface */
> +static const struct ni16550_device_info nic7772 = {
> +	.uartclk = 1843200,
> +	.flags = NI_HAS_PMR,
> +};
> +
> +/* NI cRIO-904x RS-485 Interface */
> +static const struct ni16550_device_info nic792b = {
> +	/* Sets UART clock rate to 22.222 MHz with 1.125 prescale */
> +	.uartclk = 25000000,
> +	.prescaler = 0x09,
> +};
> +
> +/* NI sbRIO 96x8 RS-232/485 Interfaces */
> +static const struct ni16550_device_info nic7a69 = {
> +	/* Set UART clock rate to 29.629 MHz with 1.125 prescale */
> +	.uartclk = 29629629,
> +	.prescaler = 0x09,
> +};
> +
> +static const struct acpi_device_id ni16550_acpi_match[] = {
> +	{ "NIC7750",	(kernel_ulong_t)&nic7750 },
> +	{ "NIC7772",	(kernel_ulong_t)&nic7772 },
> +	{ "NIC792B",	(kernel_ulong_t)&nic792b },
> +	{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);
> +
> +static struct platform_driver ni16550_driver = {
> +	.driver = {
> +		.name = "ni16550",
> +		.of_match_table = ni16550_of_match,
> +		.acpi_match_table = ACPI_PTR(ni16550_acpi_match),
> +	},
> +	.probe = ni16550_probe,
> +	.remove = ni16550_remove,
> +};
> +
> +module_platform_driver(ni16550_driver);
> +
> +MODULE_AUTHOR("Jaeden Amero <jaeden.amero@ni.com>");
> +MODULE_AUTHOR("Karthik Manamcheri <karthik.manamcheri@ni.com>");
> +MODULE_DESCRIPTION("NI 16550 Driver");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 5313aa31930f..c0f3aec51d13 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -565,6 +565,15 @@ config SERIAL_8250_BCM7271
>  	  including DMA support and high accuracy BAUD rates, say
>  	  Y to this option. If unsure, say N.
>  
> +config SERIAL_8250_NI
> +	tristate "NI 16550 based serial port"
> +	depends on SERIAL_8250
> +	help
> +	  This driver supports the integrated serial ports on National
> +          Instruments (NI) controller hardware. This is required for all NI
> +          controller models with onboard RS-485 or dual-mode RS-485/RS-232
> +          ports.

Module name if built as a module?

thanks,

greg k-h
