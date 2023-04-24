Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F2D66E78D4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 13:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjDSLn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 07:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjDSLnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 07:43:55 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0605413FA1;
        Wed, 19 Apr 2023 04:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681904632; x=1713440632;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=InYCDECiPrr8G3JKUeCdYI/qPo5X0FpU9UuG9Pd8u/Y=;
  b=SUnEz3Tl2rY4iLXcvMp/Sa67u0jUprJfUrv0FiygHpbXT3CPh8MVj9D3
   y/RxQPxnna/0DeY8d1B6ZdD5D5rRyDLHEeTuHTEMxNTjSxBOqRD8es2Lt
   OKAIIwa3dwt+xijXp6x11ucY/AIE+eitVOwLuV5W2ZapKQhp3F3i/racN
   +Zvbng8o1RR3fR8d1cLLhD2OLAlYxRpidNhLQ9CbNnTd8M8lTuACwaJIk
   DqtZqjFOo3SPhhpLsTXgCjdqkbpnLWOszNpwSv+rkWVLEvxeGwh9fOPQ6
   8TSXb/3cSbmVoVhNkxBV2hbhY3sUFtp0RO0HXi10Mielninj+v3HSN8Ik
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="325038299"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="325038299"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 04:43:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10684"; a="835273558"
X-IronPort-AV: E=Sophos;i="5.99,208,1677571200"; 
   d="scan'208";a="835273558"
Received: from hbourgeo-mobl2.ger.corp.intel.com ([10.249.34.207])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2023 04:43:44 -0700
Date:   Wed, 19 Apr 2023 14:43:38 +0300 (EEST)
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
Subject: Re: [PATCH v3 tty-next 2/2] serial: 8250: add driver for NI UARTs
In-Reply-To: <20230418223800.284601-3-brenda.streiff@ni.com>
Message-ID: <9cd84bb0-864a-af70-986a-841ac1f522e@linux.intel.com>
References: <20230410211152.94332-1-brenda.streiff@ni.com> <20230418223800.284601-1-brenda.streiff@ni.com> <20230418223800.284601-3-brenda.streiff@ni.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Apr 2023, Brenda Streiff wrote:

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
>  drivers/tty/serial/8250/8250_ni.c | 468 ++++++++++++++++++++++++++++++
>  drivers/tty/serial/8250/Kconfig   |  13 +
>  drivers/tty/serial/8250/Makefile  |   1 +
>  4 files changed, 489 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_ni.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 90abe83c02f3..4d44622da6cb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14323,6 +14323,13 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
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
> index 000000000000..92e8912c4875
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_ni.c
> @@ -0,0 +1,468 @@
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
> +#include <linux/clk.h>
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

Ah, checking the comment, this is GENMASK(1, 0). Remember to add the 
include for it too.

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

GENMASK()

> +#define NI16550_PCR_TXVR_ENABLE_BIT		BIT(3)
> +#define NI16550_PCR_RS485_TERMINATION_BIT	BIT(6)
> +
> +/* flags for ni16550_device_info */
> +#define NI_HAS_PMR		BIT(0)
> +
> +struct ni16550_device_info {
> +	u32 uartclk;
> +	u8 prescaler;
> +	u8 flags;
> +};
> +
> +struct ni16550_data {
> +	int line;
> +	struct clk *clk;
> +};
> +
> +static int ni16550_enable_transceivers(struct uart_port *port)
> +{
> +	u8 pcr;
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
> +	u8 pcr;
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
> +	struct uart_8250_port *up = container_of(port, struct uart_8250_port,
> +						 port);

Just put these on the same line.

> +	u8 pcr;
> +
> +	/* "rs485" should be given to us non-NULL. */
> +	if (WARN_ON(rs485 == NULL))
> +		return -EINVAL;

Remove this sanity check.

> +	pcr = serial_in(up, NI16550_PCR_OFFSET);
> +	pcr &= ~NI16550_PCR_WIRE_MODE_MASK;
> +
> +	if (rs485->flags & SER_RS485_ENABLED) {
> +		/* RS-485 */
> +		dev_dbg(port->dev, "2-wire Auto\n");
> +		pcr |= NI16550_PCR_AUTO_RS485;
> +		up->acr |= NI16550_ACR_AUTO_DTR_EN;
> +	} else {
> +		/* RS-422 */
> +		dev_dbg(port->dev, "4-wire\n");
> +		pcr |= NI16550_PCR_RS422;
> +		up->acr &= ~NI16550_ACR_AUTO_DTR_EN;
> +	}

Does this difference also mean the UART's RS485 could support 
SER_RS485_RX_DURING_TX? (half-duplex vs full-duplex RS-485)

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
> +	u8 pmr = serial_in(up, NI16550_PMR_OFFSET);
> +	u8 pmr_mode = pmr & NI16550_PMR_MODE_MASK;
> +	u8 pmr_cap = pmr & NI16550_PMR_CAP_MASK;
> +
> +	/*
> +	 * If the PMR is not implemented, then by default NI UARTs are
> +	 * connected to RS-485 transceivers
> +	 */
> +	if (pmr_cap == NI16550_PMR_NOT_IMPL)
> +		return false;
> +
> +	if (pmr_cap == NI16550_PMR_CAP_DUAL)
> +		/*
> +		 * If the port is dual-mode capable, then read the mode bit
> +		 * to know the current mode
> +		 */
> +		return pmr_mode == NI16550_PMR_MODE_RS232;
> +	/*
> +	 * If it is not dual-mode capable, then decide based on the
> +	 * capability
> +	 */
> +	return pmr_cap == NI16550_PMR_CAP_RS232;
> +}
> +
> +static void ni16550_config_prescaler(struct uart_8250_port *up,
> +				     u8 prescaler)
> +{
> +	/*
> +	 * Page in the Enhanced Mode Registers
> +	 * Sets EFR[4] for Enhanced Mode.
> +	 */
> +	u8 lcr_value;
> +	u8 efr_value;
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

The driver does not seem to change anything based on the value of
SER_RS485_RTS_ON_SEND, was this an oversight or is RTS on/off on/after 
send not supported?

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

Remove the extra alignment, it didn't help much anyway as 1 out of 4 had 
that |.

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
> +static u8 ni16550_read_fifo_size(struct uart_8250_port *uart, int reg)
> +{
> +	/*
> +	 * Very old implementations don't have the TFS or RFS registers
> +	 * defined, so we may read all-0s or all-1s. For such devices,
> +	 * assume a FIFO size of 128.
> +	 */
> +	u8 value = serial_in(uart, reg);
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
> +	const struct ni16550_device_info *info;
> +	struct device *dev = &pdev->dev;
> +	struct uart_8250_port uart = {};
> +	struct ni16550_data *data;
> +	const char *portmode;
> +	unsigned int prescaler;
> +	int txfifosz, rxfifosz;
> +	int rs232_property;
> +	int ret;
> +	int irq;
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
> +	uart.port.flags		= UPF_SHARE_IRQ | UPF_BOOT_AUTOCONF
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
> +	 * Declaration of the base clock frequency can come from one of:
> +	 * - static declaration in this driver (for older ACPI IDs)
> +	 * - a "clock-frquency" ACPI or OF device property
> +	 * - an associated OF clock definition
> +	 */
> +	if (info->uartclk)
> +		uart.port.uartclk = info->uartclk;
> +	if (device_property_read_u32(dev, "clock-frequency",
> +				     &uart.port.uartclk)) {
> +		data->clk = devm_clk_get_optional_enabled(dev, "baudclk");
> +		if (data->clk)
> +			uart.port.uartclk = clk_get_rate(data->clk);
> +	}
> +
> +	if (!uart.port.uartclk) {
> +		dev_err(dev, "unable to determine clock frequency!\n");
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	if (info->prescaler)
> +		prescaler = info->prescaler;
> +	device_property_read_u32(dev, "clock-prescaler", &prescaler);
> +
> +	if (prescaler != 0) {
> +		uart.port.set_mctrl = ni16550_set_mctrl;
> +		ni16550_config_prescaler(&uart, (u8)prescaler);
> +	}
> +
> +	/*
> +	 * The determination of whether or not this is an RS-485 or RS-232 port
> +	 * can come from a device property (if present), or it can come from
> +	 * the PMR (if present), and otherwise we're solely an RS-485 port.
> +	 *
> +	 * This is a device-specific property, and thus has a vendor-prefixed
> +	 * "ni,serial-port-mode" form as a devicetree binding. However, there
> +	 * are old devices in the field using "transceiver" as an ACPI device
> +	 * property, so we have to check for that as well.
> +	 */
> +	if (!device_property_read_string(dev, "ni,serial-port-mode",
> +					 &portmode) ||
> +	    !device_property_read_string(dev, "transceiver", &portmode)) {
> +		rs232_property = strncmp(portmode, "RS-232", 6) == 0;
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
> +		goto err;
> +	data->line = ret;
> +
> +	platform_set_drvdata(pdev, data);
> +	return 0;
> +
> +err:
> +	clk_disable_unprepare(data->clk);
> +	return ret;
> +}
> +
> +static int ni16550_remove(struct platform_device *pdev)
> +{
> +	struct ni16550_data *data = platform_get_drvdata(pdev);
> +
> +	clk_disable_unprepare(data->clk);
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

To me these two comments don't seemingly agree, one states 22.222MHz and 
defines 25M clk, whereas the other states 29.629MHz and defines 29.629M 
clk. I guess one of them comes from prescaled and the other from 
postscaled frequency?

> +};
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id ni16550_acpi_match[] = {
> +	{ "NIC7750",	(kernel_ulong_t)&nic7750 },
> +	{ "NIC7772",	(kernel_ulong_t)&nic7772 },
> +	{ "NIC792B",	(kernel_ulong_t)&nic792b },
> +	{ "NIC7A69",	(kernel_ulong_t)&nic7a69 },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(acpi, ni16550_acpi_match);
> +#endif
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
> index 5313aa31930f..c650566fc71d 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -565,6 +565,19 @@ config SERIAL_8250_BCM7271
>  	  including DMA support and high accuracy BAUD rates, say
>  	  Y to this option. If unsure, say N.
>  
> +config SERIAL_8250_NI
> +	tristate "NI 16550 based serial port"
> +	depends on SERIAL_8250
> +	depends on (X86 && ACPI) || (ARCH_ZYNQ && OF) || COMPILE_TEST
> +	help
> +	  This driver supports the integrated serial ports on National
> +          Instruments (NI) controller hardware. This is required for all NI
> +          controller models with onboard RS-485 or dual-mode RS-485/RS-232
> +          ports.

Check that the indent is same for all these lines (tab + 2 spaces).

> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called 8250_ni.
> +
>  config SERIAL_OF_PLATFORM
>  	tristate "Devicetree based probing for 8250 ports"
>  	depends on SERIAL_8250 && OF
> diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
> index 4fc2fc1f41b6..58dc1b5ff054 100644
> --- a/drivers/tty/serial/8250/Makefile
> +++ b/drivers/tty/serial/8250/Makefile
> @@ -45,6 +45,7 @@ obj-$(CONFIG_SERIAL_8250_PERICOM)	+= 8250_pericom.o
>  obj-$(CONFIG_SERIAL_8250_PXA)		+= 8250_pxa.o
>  obj-$(CONFIG_SERIAL_8250_TEGRA)		+= 8250_tegra.o
>  obj-$(CONFIG_SERIAL_8250_BCM7271)	+= 8250_bcm7271.o
> +obj-$(CONFIG_SERIAL_8250_NI)		+= 8250_ni.o
>  obj-$(CONFIG_SERIAL_OF_PLATFORM)	+= 8250_of.o
>  
>  CFLAGS_8250_ingenic.o += -I$(srctree)/scripts/dtc/libfdt
> 

-- 
 i.

