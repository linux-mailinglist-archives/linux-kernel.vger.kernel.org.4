Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912A563ECA9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbiLAJkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:40:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiLAJkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:40:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349A570616;
        Thu,  1 Dec 2022 01:40:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669887607; x=1701423607;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=wniq+W13iJT6w9Nv+pN4AUqaMkrHbvudrm3nE4i/jqI=;
  b=UCYbWGLxiA0d85BJ143EIy3pk5XvoupB0eS8LYZ7yWFkFtaCoTNiHDgy
   +FGIdx3c1t0XRKLCDCqg0KvxW9KNSTIVeA8l5RegqfgfIRQss48x2Skse
   p1u5RYsq3WxQDJZmJfa/gR7qw6JV38ly5th8fDTx+OvKBEYrJQIw/RoGg
   7YXSi1Jjq+GJqUakFaNm+BRLMnV4wtaE8tW4gh68yAnr7rAcqjBa7zWDB
   4yGLV7kfwI0QkKCKxR3k55bTiRPiaWhfp4J7crNn5iLKYiQZIWvvMluQC
   E7Am+4P6OnK/ER73Qzu9THHCwLHbZdyP+F6A8kQqntDHjoiYtRZdDaHf4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="299007033"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="299007033"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:40:05 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="818980548"
X-IronPort-AV: E=Sophos;i="5.96,209,1665471600"; 
   d="scan'208";a="818980548"
Received: from akoroglu-mobl.ger.corp.intel.com ([10.251.212.165])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 01:40:00 -0800
Date:   Thu, 1 Dec 2022 11:39:57 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        macro@orcam.me.uk, jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, Lukas Wunner <lukas@wunner.de>,
        UNGLinuxDriver@microchip.com, colin.i.king@gmail.com,
        Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Subject: Re: [PATCH v6 tty-next 2/4] serial: 8250_pci1xxxx: Add driver for
 quad-uart support.
In-Reply-To: <20221201045146.1055913-3-kumaravel.thiagarajan@microchip.com>
Message-ID: <79c14380-2cf4-108c-544b-98a84e5e251e@linux.intel.com>
References: <20221201045146.1055913-1-kumaravel.thiagarajan@microchip.com> <20221201045146.1055913-3-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Dec 2022, Kumaravel Thiagarajan wrote:

> pci1xxxx is a PCIe switch with a multi-function endpoint on one of
> its downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---
> Changes in v6:
> - Removed un-necessary paranthesis
> - Used array and removed switch cases to reduce complexity
> - Handled failure case of pcim_iomap
> 
> Changes in v5:
> - Used tabs instead of spaces in MACRO definitions for readability
> - Removed assignments that are not required
> - Removed redundant blank lines
> 
> Changes in v4:
> - Renamed pci_setup_port to serial8250_pci_setup_port
> - Added Copyright information to 8250_pcilib.c
> 
> Changes in v3:
> - Used NSEC_PER_SEC, HZ_PER_MHZ, FIELD_PREP, FIELD_GET MACROs wherever
>   necessary
> - Handled failure case of serial8250_register_8250_port properly
> - Moved pci_setup_port to 8250_pcilib.c
> 
> Changes in v2:
> - Use only the 62.5 MHz for baud clock.
> - Define custom implementation for get_divisor and set_divisor.
> - Use BOTHER instead of UPF_SPD_CUST for non standard baud rates
>   (untested).
> - Correct indentation in clock divisor computation.
> - Remove unnecessary call to pci_save_state in probe function.
> - Fix null pointer dereference in probe function.
> - Move pci1xxxx_rs485_config to a separate patch.
> - Depends on SERIAL_8250_PCI & default to SERIAL_8250.
> - Change PORT_MCHP16550A to 100 from 124.
> 
> ---
>  MAINTAINERS                             |   7 +
>  drivers/tty/serial/8250/8250_pci1xxxx.c | 298 ++++++++++++++++++++++++
>  drivers/tty/serial/8250/8250_port.c     |   8 +
>  drivers/tty/serial/8250/Kconfig         |  11 +
>  drivers/tty/serial/8250/Makefile        |   1 +
>  include/uapi/linux/serial_core.h        |   3 +
>  6 files changed, 328 insertions(+)
>  create mode 100644 drivers/tty/serial/8250/8250_pci1xxxx.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d30f26e07cd3..20c868776a5e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13434,6 +13434,13 @@ F:	Documentation/devicetree/bindings/nvmem/microchip,sama7g5-otpc.yaml
>  F:	drivers/nvmem/microchip-otpc.c
>  F:	include/dt-bindings/nvmem/microchip,sama7g5-otpc.h
>  
> +MICROCHIP PCIe UART DRIVER
> +M:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> +M:     Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> +L:     linux-serial@vger.kernel.org
> +S:     Maintained
> +F:     drivers/tty/serial/8250/8250_pci1xxxx.c
> +
>  MICROCHIP PWM DRIVER
>  M:	Claudiu Beznea <claudiu.beznea@microchip.com>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
> new file mode 100644
> index 000000000000..d5037e76b636
> --- /dev/null
> +++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
> @@ -0,0 +1,298 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  Probe module for 8250/16550-type MCHP PCI serial ports.
> + *
> + *  Based on drivers/tty/serial/8250/8250_pci.c,
> + *
> + *  Copyright (C) 2022 Microchip Technology Inc., All Rights Reserved.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/serial_core.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/units.h>
> +#include <linux/tty.h>
> +
> +#include <asm/byteorder.h>
> +
> +#include "8250.h"
> +#include "8250_pcilib.h"
> +
> +#define PCI_DEVICE_ID_EFAR_PCI12000		0xa002
> +#define PCI_DEVICE_ID_EFAR_PCI11010		0xa012
> +#define PCI_DEVICE_ID_EFAR_PCI11101		0xa022
> +#define PCI_DEVICE_ID_EFAR_PCI11400		0xa032
> +#define PCI_DEVICE_ID_EFAR_PCI11414		0xa042
> +
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p	0x0001
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012	0x0002
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013	0x0003
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023	0x0004
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123	0x0005
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01	0x0006
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02	0x0007
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03	0x0008
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12	0x0009
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13	0x000a
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23	0x000b
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0	0x000c
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1	0x000d
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2	0x000e
> +#define PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3	0x000f
> +
> +#define PCI_SUBDEVICE_ID_EFAR_PCI12000		0xa002
> +#define PCI_SUBDEVICE_ID_EFAR_PCI11010		0xa012
> +#define PCI_SUBDEVICE_ID_EFAR_PCI11101		0xa022
> +#define PCI_SUBDEVICE_ID_EFAR_PCI11400		0xa032
> +#define PCI_SUBDEVICE_ID_EFAR_PCI11414		0xa042

Since those numbers seems to match the others, could you just do:

#define PCI_SUBDEVICE_ID_EFAR_PCI11414 PCI_DEVICE_ID_EFAR_PCI11414

> +
> +#define UART_ACTV_REG				0x11
> +#define UART_BLOCK_SET_ACTIVE			BIT(0)
> +
> +#define UART_PCI_CTRL_REG			0x80
> +#define UART_PCI_CTRL_SET_MULTIPLE_MSI		BIT(4)
> +#define UART_PCI_CTRL_D3_CLK_ENABLE		BIT(0)
> +
> +#define ADCL_CFG_REG				0x40
> +#define ADCL_CFG_POL_SEL			BIT(2)
> +#define ADCL_CFG_PIN_SEL			BIT(1)
> +#define ADCL_CFG_EN				BIT(0)
> +
> +#define UART_BIT_SAMPLE_CNT			16
> +#define BAUD_CLOCK_DIV_INT_MSK			GENMASK(31, 8)
> +#define ADCL_CFG_RTS_DELAY_MASK			GENMASK(11, 8)
> +#define UART_CLOCK_DEFAULT			(62.5 * HZ_PER_MHZ)

I don't think you want to go into float realm. Just do 62500 * HZ_PER_KHZ

> +
> +#define UART_WAKE_REG				0x8C
> +#define UART_WAKE_MASK_REG			0x90
> +#define UART_WAKE_N_PIN				BIT(2)
> +#define UART_WAKE_NCTS				BIT(1)
> +#define UART_WAKE_INT				BIT(0)
> +#define UART_WAKE_SRCS	\
> +	(UART_WAKE_N_PIN | UART_WAKE_NCTS | UART_WAKE_INT)
> +
> +#define UART_BAUD_CLK_DIVISOR_REG		0x54
> +
> +#define UART_RESET_REG				0x94
> +#define UART_RESET_D3_RESET_DISABLE		BIT(16)
> +
> +#define MAX_PORTS				4
> +
> +struct pci1xxxx_8250 {
> +	struct pci_dev *pdev;
> +	unsigned int nr;
> +	void __iomem *membase;
> +	int line[];
> +};
> +
> +static int pci1xxxx_get_num_ports(struct pci_dev *dev)
> +{
> +	switch (dev->subsystem_device) {
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p0:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p1:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p2:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI12000:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11010:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11101:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11400:
> +	default:
> +		return 1;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p01:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p02:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p03:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p12:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p13:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_2p23:
> +		return 2;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p012:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p123:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p013:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_3p023:
> +		return 3;
> +	case PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_4p:
> +	case PCI_SUBDEVICE_ID_EFAR_PCI11414:
> +		return 4;
> +	}
> +}
> +
> +static unsigned int pci1xxxx_get_divisor(struct uart_port *port,
> +					 unsigned int baud, unsigned int *frac)
> +{
> +	unsigned int quot;
> +
> +	/*
> +	 * Calculate baud rate sampling period in nanoseconds.
> +	 * Fractional part x denotes x/255 parts of a nanosecond.
> +	 */
> +	quot = NSEC_PER_SEC / (baud * UART_BIT_SAMPLE_CNT);
> +	*frac = (NSEC_PER_SEC - quot * baud * UART_BIT_SAMPLE_CNT) /
> +		  UART_BIT_SAMPLE_CNT * 255 / baud;

Is it fine to div first before * 255 from precision point of view?

> +
> +	return quot;
> +}
> +
> +static void pci1xxxx_set_divisor(struct uart_port *port, unsigned int baud,
> +				 unsigned int quot, unsigned int frac)
> +{
> +	writel(FIELD_PREP(BAUD_CLOCK_DIV_INT_MSK, quot) | frac,
> +	       port->membase + UART_BAUD_CLK_DIVISOR_REG);
> +}
> +
> +static int pci1xxxx_setup(struct pci1xxxx_8250 *priv,
> +			  struct uart_8250_port *port, int port_idx)
> +{
> +	int ret;
> +
> +	port->port.flags |= UPF_FIXED_TYPE | UPF_SKIP_TEST;
> +	port->port.type = PORT_MCHP16550A;
> +	port->port.set_termios = serial8250_do_set_termios;
> +	port->port.get_divisor = pci1xxxx_get_divisor;
> +	port->port.set_divisor = pci1xxxx_set_divisor;
> +
> +	ret = serial8250_pci_setup_port(priv->pdev, port, 0, port_idx * 256, 0);
> +	if (ret < 0)
> +		return ret;
> +
> +	writeb(UART_BLOCK_SET_ACTIVE, port->port.membase + UART_ACTV_REG);
> +	writeb(UART_WAKE_SRCS, port->port.membase + UART_WAKE_REG);
> +	writeb(UART_WAKE_N_PIN, port->port.membase + UART_WAKE_MASK_REG);
> +
> +	return 0;
> +}
> +
> +static int pci1xxxx_serial_probe(struct pci_dev *pdev,
> +				 const struct pci_device_id *id)
> +{
> +	static int logical_to_physical_port_idx[][MAX_PORTS] = {
> +		{0, 1, 2, 3},	/* PCI12000 PCI11010 PCI11101 PCI11400 PCI11414 */
> +		{0, 1, 2, 3},	/* PCI4p */
> +		{0, 1, 2, -1},	/* PCI3p012 */
> +		{0, 1, 3, -1},	/* PCI3p013 */
> +		{0, 2, 3, -1},	/* PCI3p023 */
> +		{1, 2, 3, -1},	/* PCI3p123 */
> +		{0, 1, -1, -1},	/* PCI2p01 */
> +		{0, 2, -1, -1},	/* PCI2p02 */
> +		{0, 3, -1, -1},	/* PCI2p03 */
> +		{1, 2, -1, -1},	/* PCI2p12 */
> +		{1, 3, -1, -1},	/* PCI2p13 */
> +		{2, 3, -1, -1},	/* PCI2p23 */
> +		{0, -1, -1, -1},/* PCI1p0 */
> +		{1, -1, -1, -1},/* PCI1p1 */
> +		{2, -1, -1, -1},/* PCI1p2 */
> +		{3, -1, -1, -1}	/* PCI1p3 */

Add comma also to the last item.

This array can go outside of function's scope.

> +	};
> +	struct device *dev = &pdev->dev;
> +	struct pci1xxxx_8250 *priv;
> +	struct uart_8250_port uart;
> +	unsigned int nr_ports, i;
> +	int num_vectors;
> +	int subsys_dev;
> +	int port_idx;
> +	int rc;
> +
> +	rc = pcim_enable_device(pdev);
> +	if (rc)
> +		return rc;
> +
> +	nr_ports = pci1xxxx_get_num_ports(pdev);
> +
> +	priv = devm_kzalloc(dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->membase = pcim_iomap(pdev, 0, 0);
> +	if (!priv->membase)
> +		return -ENOMEM;
> +
> +	priv->pdev = pdev;
> +	subsys_dev = priv->pdev->subsystem_device;
> +	priv->nr = nr_ports;
> +	pci_set_master(pdev);
> +
> +	num_vectors = pci_alloc_irq_vectors(pdev, 1, 4, PCI_IRQ_ALL_TYPES);
> +	if (num_vectors < 0)
> +		return num_vectors;
> +
> +	memset(&uart, 0, sizeof(uart));
> +	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_PORT;
> +	uart.port.uartclk = UART_CLOCK_DEFAULT;
> +	uart.port.dev = dev;
> +
> +	if (num_vectors == 4)
> +		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI,
> +		       priv->membase + UART_PCI_CTRL_REG);
> +	else
> +		uart.port.irq = pci_irq_vector(pdev, 0);
> +
> +	for (i = 0; i < nr_ports; i++)
> +		priv->line[i] = -ENOSPC;

-ENODEV might be more appropriate.

> +
> +	for (i = 0; i < nr_ports; i++) {
> +		if (subsys_dev > 0x0f)

> PCI_SUBDEVICE_ID_EFAR_PCI1XXXX_1p3

> +			port_idx = logical_to_physical_port_idx[0][i];
> +		else
> +			port_idx = logical_to_physical_port_idx[subsys_dev][i];
> +
> +		if (num_vectors == 4)
> +			uart.port.irq = pci_irq_vector(priv->pdev, port_idx);
> +
> +		rc = pci1xxxx_setup(priv, &uart, port_idx);
> +		if (rc) {
> +			dev_warn(dev, "Failed to setup port %u\n", i);
> +			continue;
> +		}
> +
> +		priv->line[i] = serial8250_register_8250_port(&uart);
> +		if (priv->line[i] < 0) {
> +			dev_warn(dev,
> +				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +				uart.port.iobase, uart.port.irq,
> +				uart.port.iotype, priv->line[i]);
> +		}
> +	}
> +
> +	pci_set_drvdata(pdev, priv);
> +
> +	return 0;
> +}
> +
> +static void pci1xxxx_serial_remove(struct pci_dev *dev)
> +{
> +	struct pci1xxxx_8250 *priv = pci_get_drvdata(dev);
> +	int i;
> +
> +	for (i = 0; i < priv->nr; i++) {
> +		if (priv->line[i] >= 0)
> +			serial8250_unregister_port(priv->line[i]);
> +	}
> +}
> +
> +static const struct pci_device_id pci1xxxx_pci_tbl[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11010) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11101) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11400) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI11414) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_PCI12000) },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(pci, pci1xxxx_pci_tbl);
> +
> +static struct pci_driver pci1xxxx_pci_driver = {
> +	.name = "pci1xxxx serial",
> +	.probe = pci1xxxx_serial_probe,
> +	.remove = pci1xxxx_serial_remove,
> +	.id_table = pci1xxxx_pci_tbl,
> +};
> +module_pci_driver(pci1xxxx_pci_driver);
> +
> +MODULE_DESCRIPTION("Microchip Technology Inc. PCIe to UART module");
> +MODULE_AUTHOR("Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>");
> +MODULE_AUTHOR("Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 1d2a43214b48..ec2fe5fd7b02 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -313,6 +313,14 @@ static const struct serial8250_config uart_config[] = {
>  		.rxtrig_bytes	= {1, 4, 8, 14},
>  		.flags		= UART_CAP_FIFO,
>  	},
> +	[PORT_MCHP16550A] = {
> +		.name           = "MCHP16550A",
> +		.fifo_size      = 256,
> +		.tx_loadsz      = 256,
> +		.fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
> +		.rxtrig_bytes   = {2, 66, 130, 194},
> +		.flags          = UART_CAP_FIFO,
> +	},
>  };
>  
>  /* Uart divisor latch read */
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 3088eaff3ad0..f67542470eae 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -292,6 +292,17 @@ config SERIAL_8250_HUB6
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called 8250_hub6.
>  
> +config SERIAL_8250_PCI1XXXX
> +	tristate "Microchip 8250 based serial port"
> +	depends on SERIAL_8250_PCI

Do you actually need this any more after pcilib? It's not like all PCI 
UARTs depends on SERIAL_8250_PCI. An alternative might be this:

depends on SERIAL_8250 && PCI


-- 
 i.

