Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8AA35F2D0E
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbiJCJXh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiJCJXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:23:34 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9AE1D64D;
        Mon,  3 Oct 2022 02:23:32 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id d17so6185310qko.13;
        Mon, 03 Oct 2022 02:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=SQHaq94VGQuh3SBDwvSsOgRGHHClVd1zxaSFa7JsqpY=;
        b=BTvbST36ESOK2zGdv+KQ8CjGbxEahU5OZ4j8qjvD0/+uO8X6EDwi0mjDWlyB5no3Nz
         HggVAbaIaaLikvLKC4Acs2lW4ewsul3MDcDkH26bb0+CpPDi/3eooOeiq09WEbej5MhG
         DM8bjwhgFLk76Aptis8/w6vgZUzDqZUtWhYWau2mX2hNBDLe6DTBroFlF1dIm/X0qTOW
         42uLQWMqGMsLBcnOjgevNgVnzg2bOrJXV7ernC+L6uyu1F28XycNR2UuTLWgmIAkzy7W
         N1F+cInUcsBkxPa3+Aj9Ej8DvjGg/fqFaM7kJwFleV/DSCjHUj7ojaCsLlJ9/9SGYF+o
         uIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=SQHaq94VGQuh3SBDwvSsOgRGHHClVd1zxaSFa7JsqpY=;
        b=cVP1gdjBg7siHId+vIYYrsBINujuda9blcDvp1n2czrLZMzOm4zbE6sGk60EyGC/4o
         YP+TTjqHo0s+4H9qSIDExlpMHm4SImwXjTRiir1fX3O7vzHXxoIp0V36PBp5/r7t9Fer
         jnFReYKfYTPG4LbGh5IenzHqdtO97d0FEMaANKtaLl0u2l172BCtpDTlH68lXPR0odHv
         Vbv+2VDoAt3WMWlT4tRM/TeKdoi4TcsvGMzimvlAIpopajIGmfmcbjj0b6Gkfx5F9r8H
         oC9m36YHhCnquy+E/V+EQWkdShFbzp/L8CHRlIZj1JKFgko9W8weSqevG/kXulsZaW0u
         exJA==
X-Gm-Message-State: ACrzQf0EJlgEcItbg+o6bPk3KkIRxM+fF6TTf0z/RDyvAB9lqExSpu1s
        joZqHYMAKJpE/sRpWSRMu1LE7ayHNmjGc7c+4O3MvIgY0VoXOw==
X-Google-Smtp-Source: AMsMyM6uqRrBVIdW8Q9/c9ikc/SBH+6CGQdwuth5Iy/2p1fOPhMLdcK6055VIEenulcxi386hzpqirpG28Z5r3s3P00=
X-Received: by 2002:a05:620a:288a:b0:6b8:fcfe:db02 with SMTP id
 j10-20020a05620a288a00b006b8fcfedb02mr13468642qkp.504.1664789011676; Mon, 03
 Oct 2022 02:23:31 -0700 (PDT)
MIME-Version: 1.0
References: <20221001061507.3508603-1-kumaravel.thiagarajan@microchip.com> <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
In-Reply-To: <20221001061507.3508603-2-kumaravel.thiagarajan@microchip.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 3 Oct 2022 12:22:55 +0300
Message-ID: <CAHp75VfoWii5Eo4n=-JcqE4VZMRoq77jjdTMGfwBF+vzKBXPog@mail.gmail.com>
Subject: Re: [PATCH v2 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver for
 quad-uart support.
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com, u.kleine-koenig@pengutronix.de,
        johan@kernel.org, wander@redhat.com,
        etremblay@distech-controls.com, macro@orcam.me.uk,
        geert+renesas@glider.be, jk@ozlabs.org, phil.edworthy@renesas.com,
        lukas@wunner.de, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, UNGLinuxDriver@microchip.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 1, 2022 at 9:15 AM Kumaravel Thiagarajan
<kumaravel.thiagarajan@microchip.com> wrote:
>
> pci1xxxx is a PCIe switch with a multi-function endpoint on one of its
> downstream ports. Quad-uart is one of the functions in the
> multi-function endpoint. This driver loads for the quad-uart and
> enumerates single or multiple instances of uart based on the PCIe
> subsystem device ID.

Thanks for an update, my comments below.

...

> +MICROCHIP PCIe UART DRIVER
> +M:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> +L:     linux-serial@vger.kernel.org
> +S:     Maintained
> +F:     drivers/tty/serial/8250/8250_pci1xxxx.c

>  8390 NETWORK DRIVERS [WD80x3/SMC-ELITE, SMC-ULTRA, NE2000, 3C503, etc.]

This doesn't look ordered at all. Please, locate your section in the
appropriate place.

...

> +#include <linux/serial_core.h>
> +#include <linux/8250_pci.h>
> +#include <asm/byteorder.h>
> +#include <linux/bitops.h>
> +#include <linux/module.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/pci.h>
> +#include <linux/tty.h>
> +#include <linux/io.h>

Please, keep this ordered and put a blank line between linux/* and
asm/* and "(local)" inclusions.

> +#include "8250.h"

...

> +#define PCI_VENDOR_ID_MCHP_PCI1XXXX    0x1055

Vendor should be vendor, this macro doesn't look right. See pci_ids.h
on how to properly define it.
Btw, PCI_VENDOR_ID_EFAR 0x1055 is there. Use it. (I believe microchip
bought that company in the past?)

...

> +#define PCI_DEVICE_ID_MCHP_PCI12000    0xA002
> +#define PCI_DEVICE_ID_MCHP_PCI11010    0xA012
> +#define PCI_DEVICE_ID_MCHP_PCI11101    0xA022
> +#define PCI_DEVICE_ID_MCHP_PCI11400    0xA032
> +#define PCI_DEVICE_ID_MCHP_PCI11414    0xA042

Use PCI_DEVICE_ID_#vendor_#device format. In a similar way for subdevice IDs.

...

> +#define UART_ACTV_REG                  0x11
> +#define UART_ACTV_SET_ACTIVE           BIT(0)

This namespace...

> +#define CLK_SEL_REG                    0x50
> +#define CLK_SEL_MASK                   GENMASK(1, 0)
> +#define CLK_SEL_166MHZ                 0x01
> +#define CLK_SEL_500MHZ                 0x02

> +#define CLK_DIVISOR_REG                        0x54

...and this one are potentially conflicting with more generic ones.

Ditto for the rest of the similar definitions.

...

> +static int pci1xxxx_setup_port(struct pci1xxxx_8250 *priv, struct uart_8250_port *port,
> +                              int offset)
> +{
> +       struct pci_dev *dev = priv->dev;
> +
> +       if (pci_resource_flags(dev, 0) & IORESOURCE_MEM) {
> +               if (!pcim_iomap(dev, 0, 0) && !pcim_iomap_table(dev))
> +                       return -ENOMEM;
> +
> +               port->port.iotype = UPIO_MEM;
> +               port->port.iobase = 0;
> +               port->port.mapbase = pci_resource_start(dev, 0) + offset;
> +               port->port.membase = pcim_iomap_table(dev)[0] + offset;
> +               port->port.regshift = 0;
> +       } else {
> +               port->port.iotype = UPIO_PORT;
> +               port->port.iobase = pci_resource_start(dev, 0) + offset;
> +               port->port.mapbase = 0;
> +               port->port.membase = NULL;
> +               port->port.regshift = 0;
> +       }
> +
> +       return 0;
> +}

Do you really have cards that are providing IO ports? If not, simplify
this accordingly.

...

> +       /*
> +        * Calculate baud rate sampling period in nano seconds.

nanoseconds

> +        * Fractional part x denotes x/255 parts of a nano second.
> +        */

...

> +       quot = ((1000000000) / (baud * UART_BIT_SAMPLE_CNT));
> +       *frac = (((1000000000 - (quot * baud * UART_BIT_SAMPLE_CNT)) /
> +                 UART_BIT_SAMPLE_CNT) * 255) / baud;

NSEC_PER_SEC ?

...

> +       writel((quot << 8) | frac, (port->membase + CLK_DIVISOR_REG));

Too many parentheses.

...

> +static int pci1xxxx_get_num_ports(struct pci_dev *dev)
> +{

> +       int nr_ports = 1;

Make this default case.

> +
> +       switch (dev->subsystem_device) {
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p0:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p1:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p2:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_1p3:
> +               nr_ports = 1;
> +               break;
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p01:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p02:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p03:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p12:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p13:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_2p23:
> +               nr_ports = 2;
> +               break;
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p012:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p123:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p013:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_3p023:
> +               nr_ports = 3;
> +               break;
> +       case PCI_SUBDEVICE_ID_MCHP_PCI1XXXX_4p:
> +       case PCI_SUBDEVICE_ID_MCHP_PCI11414:
> +               nr_ports = 4;
> +               break;
> +       }

> +       return nr_ports;

Drop the unnecessary local variable and use return directly from the
switch-cases.

> +}

...

> +       int first_offset = 0;

Use default switch-case.

...

> +       offset = first_offset + (idx * 256);

Too many parentheses. Check all your code for this kind of unnecessary.

...

> +       switch (priv->dev->subsystem_device) {

> +       case PCI_SUBDEVICE_ID_MCHP_PCI11414:
> +               uart->port.irq = pci_irq_vector(priv->dev, idx);
> +               break;

default?

> +       }

...

> +       uart.port.flags = UPF_SHARE_IRQ | UPF_FIXED_TYPE | UPF_FIXED_PORT;

Isn't there something duplicating here what's done in ->setup()?

...

> +       uart.port.uartclk = 62500000;

HZ_PER_MHZ ?

...

> +       if (num_vectors == 4)

This check should take care of all possible MSI >= 2, correct?

> +               writeb(UART_PCI_CTRL_SET_MULTIPLE_MSI, (priv->membase + UART_PCI_CTRL_REG));
> +       else
> +               uart.port.irq = pci_irq_vector(dev, 0);

...

> +       for (i = 0; i < nr_ports; i++) {
> +               if (num_vectors == 4)

Ditto.

> +                       pci1xxxx_irq_assign(priv, &uart, i);
> +               priv->line[i] = -ENOSPC;
> +               rc = pci1xxxx_setup(priv, &uart, i);
> +               if (rc) {
> +                       dev_err(&dev->dev, "Failed to setup port %u\n", i);
> +                       break;
> +               }
> +               priv->line[i] = serial8250_register_8250_port(&uart);
> +
> +               if (priv->line[i] < 0) {
> +                       dev_err(&dev->dev,
> +                               "Couldn't register serial port %lx, irq %d, type %d, error %d\n",
> +                               uart.port.iobase, uart.port.irq,
> +                               uart.port.iotype, priv->line[i]);
> +                       break;
> +               }
> +       }

...

> +       [PORT_MCHP16550A] = {
> +               .name           = "MCHP16550A",
> +               .fifo_size      = 256,
> +               .tx_loadsz      = 256,
> +               .fcr            = UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_01,
> +               .rxtrig_bytes   = {2, 66, 130, 194},
> +               .flags          = UART_CAP_FIFO,
> +       },

Can you assign this in ->setup() or so instead of adding a new port type?

>  };

...

> +config SERIAL_8250_PCI1XXXX
> +       tristate "Microchip 8250 based serial port"
> +       depends on SERIAL_8250_PCI
> +       default SERIAL_8250
> +       help
> +        Select this option if you have a setup with Microchip PCIe
> +        Switch with serial port enabled and wish to enable 8250
> +        serial driver for the serial interface. This driver support
> +        will ensure to support baud rates upto 1.5Mpbs.

Keep it in the Quad UART group of config sections (Yes, I know that
not all of them are sorted there, but try your best).

...

> @@ -40,6 +40,7 @@ obj-$(CONFIG_SERIAL_8250_LPSS)                += 8250_lpss.o
>  obj-$(CONFIG_SERIAL_8250_MID)          += 8250_mid.o
>  obj-$(CONFIG_SERIAL_8250_PERICOM)      += 8250_pericom.o
>  obj-$(CONFIG_SERIAL_8250_PXA)          += 8250_pxa.o
> +obj-$(CONFIG_SERIAL_8250_PCI1XXXX)     += 8250_pci1xxxx.o
>  obj-$(CONFIG_SERIAL_8250_TEGRA)                += 8250_tegra.o
>  obj-$(CONFIG_SERIAL_8250_BCM7271)      += 8250_bcm7271.o
>  obj-$(CONFIG_SERIAL_OF_PLATFORM)       += 8250_of.o

Ditto.

-- 
With Best Regards,
Andy Shevchenko
