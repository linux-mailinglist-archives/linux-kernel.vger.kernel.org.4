Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E69806D1F68
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 13:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjCaLqx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 07:46:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbjCaLqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 07:46:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6900C1FD07;
        Fri, 31 Mar 2023 04:46:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680263200; x=1711799200;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=y1HXRSf+IsUE2j8uvYPIPXiYxPkb16cBFiUzeE5ZtkU=;
  b=eVp0ECgCqIaMeHhZIvGvzPOnP3+c3j6zIPHnHXaBtf02sJoMgj0yiusm
   HgqQnoYsAtdCFhsVHx9/0D4J3JSa6o2hgroepHaNF/BgMfm2KZhKUDhHo
   Z4cpJxJGbE9QVhO+SiyMhbbveBuGvj9e6wX8/+m54MSEUBZqZacWNtFrp
   tjelMNjCwJ/cpPrkPLwPRS0c6fc0yhBIGI3JNA9Vq+m84xWLIJQCkYE8H
   IpRJZWriQ4ZDpJGBC62vrV03GruwwlLYeGMi/m9fn8iMKxIx1gApAlzgZ
   gzieQPeC80Vo8lMeT4jQHLmI1GLJ3ynv54MrppFG5rukJCg0xKpWQBp+4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="343091532"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="343091532"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 04:46:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="635269017"
X-IronPort-AV: E=Sophos;i="5.98,307,1673942400"; 
   d="scan'208";a="635269017"
Received: from rkiyama-mobl1.amr.corp.intel.com ([10.252.40.126])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 04:46:36 -0700
Date:   Fri, 31 Mar 2023 14:46:31 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Brenda Streiff <brenda.streiff@ni.com>
cc:     Gratian Crisan <gratian.crisan@ni.com>,
        Jason Smith <jason.smith@ni.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH tty-next 2/2] serial: 8250: add driver for NI UARTs
In-Reply-To: <20230329154235.615349-3-brenda.streiff@ni.com>
Message-ID: <4687fc63-65ad-c717-70b4-731079be38f7@linux.intel.com>
References: <20230329154235.615349-1-brenda.streiff@ni.com> <20230329154235.615349-3-brenda.streiff@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Mar 2023, Brenda Streiff wrote:

> The National Instruments (NI) 16550 is a 16550-like UART with larger
> FIFOs and embedded RS-232/RS-485 transceiver control circuitry. This
> patch adds a driver that can operate this UART, which is used for
> onboard serial ports in several NI embedded controller designs.
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
> +/*
> + * NI 16550 UART Driver
> + *
> + * The National Instruments (NI) 16550 is a UART that is compatible with the
> + * TL16C550C and OX16C950B register interfaces, but has additional functions
> + * for RS-485 transceiver control. This driver implements support for the
> + * additional functionality on top of the standard serial8250 core.
> + *
> + * Copyright 2012-2023 National Instruments Corporation
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
> +	unsigned int flags;
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

Reverse declaration order.

> +
> +	/* "rs485" should be given to us non-NULL. */
> +	if (WARN_ON(rs485 == NULL))
> +		return -EINVAL;
> +
> +	pcr = serial_in(up, NI16550_PCR_OFFSET);
> +	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* RS-485 */
> +		dev_vdbg(port->dev, "2-wire Auto\n");
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

Extra parenthesis.

> +	else
> +		/*
> +		 * If it is not dual-mode capable, then decide based on the
> +		 * capability
> +		 */
> +		return ((pmr & NI16550_PMR_CAP_MASK) == NI16550_PMR_CAP_RS232);

Extra parenthesis.

Wouldn't it be easier to add do the anding only once into the local 
variable rather than 4 times?


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

Do you need the port io?

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
> +{
> +	/*
> +	 * Very old implementations don't have the TFS or RFS registers
> +	 * defined, so we may read all-0s or all-1s. For such devices,
> +	 * assume a FIFO size of 128.
> +	 */
> +	int value = serial_in(uart, reg);
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

Unecessary = 0.

> +	int irq;
> +	int rs232_property = 0;
> +	unsigned int prescaler;
> +	const char *transceiver;
> +	int txfifosz, rxfifosz;

Try to follow reverse xmas-tree order.

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

Why |= ?


-- 
 i.

