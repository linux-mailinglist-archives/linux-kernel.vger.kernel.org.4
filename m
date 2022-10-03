Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1B995F3668
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 21:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJCThE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 15:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiJCThC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 15:37:02 -0400
Received: from smtp.smtpout.orange.fr (smtp-25.smtpout.orange.fr [80.12.242.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0F6E1A80F
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 12:36:58 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.100.34])
        by smtp.orange.fr with ESMTPA
        id fRFEoZmqSkifIfRFFokRMU; Mon, 03 Oct 2022 21:36:57 +0200
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 03 Oct 2022 21:36:57 +0200
X-ME-IP: 86.243.100.34
Message-ID: <676c5723-a9b7-9f28-fbb4-27a5c6f6145b@wanadoo.fr>
Date:   Mon, 3 Oct 2022 21:36:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
Content-Language: fr
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, andy.shevchenko@gmail.com,
        u.kleine-koenig@pengutronix.de, johan@kernel.org,
        wander@redhat.com, etremblay@distech-controls.com,
        macro@orcam.me.uk, geert+renesas@glider.be, jk@ozlabs.org,
        phil.edworthy@renesas.com, lukas@wunner.de
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        UNGLinuxDriver@microchip.com
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com>
 <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 01/10/2022 à 08:15, Kumaravel Thiagarajan a écrit :
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.
> 
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> ---

[...]

> +static int pci1xxxx_setup_port(struct pci1xxxx_8250 *priv, struct uart_8250_port *port,
> +			       int offset)
> +{
> +	struct pci_dev *dev = priv->dev;
> +
> +	if (pci_resource_flags(dev, 0) & IORESOURCE_MEM) {
> +		if (!pcim_iomap(dev, 0, 0) && !pcim_iomap_table(dev))
> +			return -ENOMEM;
> +
> +		port->port.iotype = UPIO_MEM;
> +		port->port.iobase = 0;
> +		port->port.mapbase = pci_resource_start(dev, 0) + offset;
> +		port->port.membase = pcim_iomap_table(dev)[0] + offset;

Hi,

Is it needed to call pcim_iomap_table(dev) twice? (here and a few lines 
above in the 'if')

> +		port->port.regshift = 0;
> +	} else {
> +		port->port.iotype = UPIO_PORT;
> +		port->port.iobase = pci_resource_start(dev, 0) + offset;
> +		port->port.mapbase = 0;
> +		port->port.membase = NULL;
> +		port->port.regshift = 0;
> +	}
> +
> +	return 0;
> +}

[...]

> +static int pci1xxxx_serial_probe(struct pci_dev *dev,
> +				 const struct pci_device_id *ent)
> +{
> +	struct pci1xxxx_8250 *priv;
> +	struct uart_8250_port uart;
> +	unsigned int nr_ports, i;
> +	int num_vectors = 0;
> +	int rc;
> +
> +	rc = pcim_enable_device(dev);
> +	if (rc)
> +		return rc;
> +
> +	nr_ports = pci1xxxx_get_num_ports(dev);
> +
> +	priv = devm_kzalloc(&dev->dev, struct_size(priv, line, nr_ports), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	priv->membase = pcim_iomap(dev, 0, 0);
> +	priv->dev = dev;
> +	priv->nr =  nr_ports;
> +
> +	pci_set_master(dev);
> +
> +	num_vectors  = pci_alloc_irq_vectors(dev, 1, 4, PCI_IRQ_ALL_TYPES);
> +	if (num_vectors < 0)
> +		return num_vectors;
> +
> +	memset(&uart, 0, sizeof(uart));
> +	uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_TYPE | UPF_FIXED_PORT;
> +	uart.port.uartclk = 62500000;
> +	uart.port.dev = &dev->dev;
> +
> +	if (num_vectors == 4)
> +		writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, (priv->membase + UART_PCI_CTRL_REG));
> +	else
> +		uart.port.irq = pci_irq_vector(dev, 0);
> +
> +	for (i = 0; i < nr_ports; i++) {
> +		if (num_vectors == 4)
> +			pci1xxxx_irq_assign(priv, &uart, i);
> +		priv->line[i] = -ENOSPC;
> +		rc = pci1xxxx_setup(priv, &uart, i);
> +		if (rc) {
> +			dev_err(&dev->dev, "Failed to setup port %u\n", i);
> +			break;
> +		}
> +		priv->line[i] = serial8250_register_8250_port(&uart);

In case of error, this should be undone in an error handling path in the 
probe, as done in the remove() function below.

If we break, we still continue and return success. But the last 
priv->line[i] are still 0. Is it an issue when pci1xxxx_serial_remove() 
is called?

> +
> +		if (priv->line[i] < 0) {
> +			dev_err(&dev->dev,
> +				"Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +				uart.port.iobase, uart.port.irq,
> +				uart.port.iotype, priv->line[i]);
> +			break;
> +		}
> +	}
> +
> +	pci_set_drvdata(dev, priv);
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

[...]
