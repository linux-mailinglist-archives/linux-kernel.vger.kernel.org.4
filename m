Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB905E9554
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 20:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbiIYSJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 14:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiIYSJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 14:09:42 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25838E97
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 11:09:31 -0700 (PDT)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A9A5F60004;
        Sun, 25 Sep 2022 18:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1664129367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vQ6nSh7AknV2yq1xRZY2J4+Brn8vMV4byzunU3j5yy4=;
        b=ALsOcVFXlIZRlODNg8u1TIrMPtvkClsV3a1Bw6Mfc2iPdJS6HFpYRHHglvSjSvCb1eaAGF
        ePD5gSoj8gmjdn0FJbypizGZviwAoies5v7jcbEddHRg00MyzCbcEsZPgfJ3hTbzZEEdTv
        BOk2mcAbilSiog27CIlRF3bY4fvZv3YETHr1OQAyG3YnEMQRuUu8m26ySH2wzMxDHNn4xy
        +9MJQS4a9KH527cEBN+LZLfp+0CxZMfbM5X/jbJHn08YdlgrIcuUxC0t3Jqm+04+/4HdCN
        6zavYYL1XNxeNqmiqtDl5JBPWD20IS6Vybwd1bSAJ9wXyLuCvBj25EoPjea6+w==
Date:   Sun, 25 Sep 2022 20:09:26 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: Re: [PATCH] pcmcia: at91_cf: switch to using gpiod API
Message-ID: <YzCZVkT5PeNes7Wu@mail.local>
References: <Yy6d7TjqzUwGQnQa@penguin>
 <68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com>
 <Yy7tLRcMaKeet9An@mail.local>
 <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yy8RcC2QHdws26ha@owl.dominikbrodowski.net>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/09/2022 16:17:20+0200, Dominik Brodowski wrote:
> Am Sat, Sep 24, 2022 at 01:42:37PM +0200 schrieb Alexandre Belloni:
> > On 24/09/2022 10:33:29+0200, Arnd Bergmann wrote:
> > > On Sat, Sep 24, 2022, at 8:04 AM, Dmitry Torokhov wrote:
> > > > This patch switches the driver to use newer gpiod API instead of legacy
> > > > gpio API. This moves us closer to the goal of stopping exporting
> > > > OF-specific APIs of gpiolib.
> > > >
> > > > While at it, stop using module-global for regmap.
> > > >
> > > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > > 
> > > This looks good to me overall. Three comments:
> > > 
> > > > @@ -63,7 +62,7 @@ struct at91_cf_socket {
> > > > 
> > > >  static inline int at91_cf_present(struct at91_cf_socket *cf)
> > > >  {
> > > > -	return !gpio_get_value(cf->board->det_pin);
> > > > +	return gpiod_get_value(cf->board->det_pin);
> > > >  }
> > > 
> > > a) The change in polarity looks wrong here, I can't really tell
> > > from the patch. If this is intentional, maybe explain it in
> > > the changelog. With that addressed (either way)
> > > 
> > > Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> > > 
> > > 
> > > b) In case you are doing more patches like this one at the moment,
> > > note that I'm in the process of removing all unused board files
> > > for arch/arm/, which will in turn make a lot of drivers unused.
> > > I should be able to provide a branch soon, which can be used to
> > > identify drivers that don't have DT support any more and don't
> > > have any board files. Rather than converting them to gpio
> > > descriptors, we can probably just remove those drivers.
> > > 
> > > c) I'm not sure about the state of the at91_cf driver. Apparently
> > > we used to have three drivers for the same hardware (pcmcia,
> > > pata and ide), and only the pcmcia driver remained in the tree
> > > after drivers/ide/ was removed and pata_at91 did not get converted
> > > to DT. I think in the long run we will remove the pcmcia layer,
> > > so if you are actually trying to use this hardware, we may want to
> > > revive the pata variant and drop this one instead.
> > > There is no dts file in tree that actually declares either of them,
> > > so chances are that nobody is actually using the CF slot on at91
> > > any more.
> > > 
> > 
> > I'm pretty sure it is broken since eaa9a21dd14b ("pcmcia: at91_cf: Use
> > syscon to configure the MC/smc") as this change has never been tested.
> 
> Well, that's a pretty strong reason to remove this driver. May I get ACKs on
> this patch, please?
> 
> Thanks,
> 	Dominik
> 
> 
> From: Dominik Brodowski <linux@dominikbrodowski.net>
> Subject: [PATCH] pcmcia: remove AT91RM9200 Compact Flash driver
> 
> As noted by Arnd Bergmann, "we used to have three drivers for the same
> hardware (pcmcia, pata and ide), and only the pcmcia driver remained
> in the tree after drivers/ide/ was removed and pata_at91 did not get
> converted to DT". "There is no dts file in tree that actually declares
> either of them, so chances are that nobody is actually using the CF
> slot on at91 any more."[1]
> 
> On this rationale, remove the AT91RM9200 Compact Flash driver, which
> also assists in reaching "the goal of stopping exporting OF-specific
> APIs of gpiolib".[2]
> 
> [1] https://lore.kernel.org/lkml/68c63077-848b-45f5-8aca-ed995391f2b6@www.fastmail.com/
> [2] https://lore.kernel.org/lkml/Yy6d7TjqzUwGQnQa@penguin/
> 
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> 
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
> index 90ebc688ec05..1525023e49b6 100644
> --- a/drivers/pcmcia/Kconfig
> +++ b/drivers/pcmcia/Kconfig
> @@ -248,15 +248,6 @@ config OMAP_CF
>  	  Say Y here to support the CompactFlash controller on OMAP.
>  	  Note that this doesn't support "True IDE" mode.
>  
> -config AT91_CF
> -	tristate "AT91 CompactFlash Controller"
> -	depends on PCI
> -	depends on OF
> -	depends on PCMCIA && ARCH_AT91
> -	help
> -	  Say Y here to support the CompactFlash controller on AT91 chips.
> -	  Or choose M to compile the driver as a module named "at91_cf".
> -
>  config ELECTRA_CF
>  	tristate "Electra CompactFlash Controller"
>  	depends on PCMCIA && PPC_PASEMI
> diff --git a/drivers/pcmcia/Makefile b/drivers/pcmcia/Makefile
> index 1c3ae8888e5f..b3a2accf47af 100644
> --- a/drivers/pcmcia/Makefile
> +++ b/drivers/pcmcia/Makefile
> @@ -30,7 +30,6 @@ obj-$(CONFIG_PCMCIA_SA1100)			+= sa1100_cs.o
>  obj-$(CONFIG_PCMCIA_SA1111)			+= sa1111_cs.o
>  obj-$(CONFIG_PCMCIA_BCM63XX)			+= bcm63xx_pcmcia.o
>  obj-$(CONFIG_OMAP_CF)				+= omap_cf.o
> -obj-$(CONFIG_AT91_CF)				+= at91_cf.o
>  obj-$(CONFIG_ELECTRA_CF)			+= electra_cf.o
>  obj-$(CONFIG_PCMCIA_ALCHEMY_DEVBOARD)		+= db1xxx_ss.o
>  obj-$(CONFIG_PCMCIA_MAX1600)			+= max1600.o
> diff --git a/drivers/pcmcia/at91_cf.c b/drivers/pcmcia/at91_cf.c
> deleted file mode 100644
> index c1297f0ebf03..000000000000
> --- a/drivers/pcmcia/at91_cf.c
> +++ /dev/null
> @@ -1,407 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-or-later
> -/*
> - * at91_cf.c -- AT91 CompactFlash controller driver
> - *
> - * Copyright (C) 2005 David Brownell
> - */
> -
> -#include <linux/module.h>
> -#include <linux/kernel.h>
> -#include <linux/platform_device.h>
> -#include <linux/errno.h>
> -#include <linux/init.h>
> -#include <linux/interrupt.h>
> -#include <linux/slab.h>
> -#include <linux/gpio.h>
> -#include <linux/io.h>
> -#include <linux/sizes.h>
> -#include <linux/mfd/syscon.h>
> -#include <linux/mfd/syscon/atmel-mc.h>
> -#include <linux/of.h>
> -#include <linux/of_device.h>
> -#include <linux/of_gpio.h>
> -#include <linux/pci.h>
> -#include <linux/regmap.h>
> -
> -#include <pcmcia/ss.h>
> -
> -/*
> - * A0..A10 work in each range; A23 indicates I/O space;  A25 is CFRNW;
> - * some other bit in {A24,A22..A11} is nREG to flag memory access
> - * (vs attributes).  So more than 2KB/region would just be waste.
> - * Note: These are offsets from the physical base address.
> - */
> -#define	CF_ATTR_PHYS	(0)
> -#define	CF_IO_PHYS	(1 << 23)
> -#define	CF_MEM_PHYS	(0x017ff800)
> -
> -struct at91_cf_data {
> -	int	irq_pin;		/* I/O IRQ */
> -	int	det_pin;		/* Card detect */
> -	int	vcc_pin;		/* power switching */
> -	int	rst_pin;		/* card reset */
> -	u8	chipselect;		/* EBI Chip Select number */
> -	u8	flags;
> -#define AT91_CF_TRUE_IDE	0x01
> -#define AT91_IDE_SWAP_A0_A2	0x02
> -};
> -
> -static struct regmap *mc;
> -
> -/*--------------------------------------------------------------------------*/
> -
> -struct at91_cf_socket {
> -	struct pcmcia_socket	socket;
> -
> -	unsigned		present:1;
> -
> -	struct platform_device	*pdev;
> -	struct at91_cf_data	*board;
> -
> -	unsigned long		phys_baseaddr;
> -};
> -
> -static inline int at91_cf_present(struct at91_cf_socket *cf)
> -{
> -	return !gpio_get_value(cf->board->det_pin);
> -}
> -
> -/*--------------------------------------------------------------------------*/
> -
> -static int at91_cf_ss_init(struct pcmcia_socket *s)
> -{
> -	return 0;
> -}
> -
> -static irqreturn_t at91_cf_irq(int irq, void *_cf)
> -{
> -	struct at91_cf_socket *cf = _cf;
> -
> -	if (irq == gpio_to_irq(cf->board->det_pin)) {
> -		unsigned present = at91_cf_present(cf);
> -
> -		/* kick pccard as needed */
> -		if (present != cf->present) {
> -			cf->present = present;
> -			dev_dbg(&cf->pdev->dev, "card %s\n",
> -					present ? "present" : "gone");
> -			pcmcia_parse_events(&cf->socket, SS_DETECT);
> -		}
> -	}
> -
> -	return IRQ_HANDLED;
> -}
> -
> -static int at91_cf_get_status(struct pcmcia_socket *s, u_int *sp)
> -{
> -	struct at91_cf_socket	*cf;
> -
> -	if (!sp)
> -		return -EINVAL;
> -
> -	cf = container_of(s, struct at91_cf_socket, socket);
> -
> -	/* NOTE: CF is always 3VCARD */
> -	if (at91_cf_present(cf)) {
> -		int rdy	= gpio_is_valid(cf->board->irq_pin);	/* RDY/nIRQ */
> -		int vcc	= gpio_is_valid(cf->board->vcc_pin);
> -
> -		*sp = SS_DETECT | SS_3VCARD;
> -		if (!rdy || gpio_get_value(cf->board->irq_pin))
> -			*sp |= SS_READY;
> -		if (!vcc || gpio_get_value(cf->board->vcc_pin))
> -			*sp |= SS_POWERON;
> -	} else
> -		*sp = 0;
> -
> -	return 0;
> -}
> -
> -static int
> -at91_cf_set_socket(struct pcmcia_socket *sock, struct socket_state_t *s)
> -{
> -	struct at91_cf_socket	*cf;
> -
> -	cf = container_of(sock, struct at91_cf_socket, socket);
> -
> -	/* switch Vcc if needed and possible */
> -	if (gpio_is_valid(cf->board->vcc_pin)) {
> -		switch (s->Vcc) {
> -		case 0:
> -			gpio_set_value(cf->board->vcc_pin, 0);
> -			break;
> -		case 33:
> -			gpio_set_value(cf->board->vcc_pin, 1);
> -			break;
> -		default:
> -			return -EINVAL;
> -		}
> -	}
> -
> -	/* toggle reset if needed */
> -	gpio_set_value(cf->board->rst_pin, s->flags & SS_RESET);
> -
> -	dev_dbg(&cf->pdev->dev, "Vcc %d, io_irq %d, flags %04x csc %04x\n",
> -				s->Vcc, s->io_irq, s->flags, s->csc_mask);
> -
> -	return 0;
> -}
> -
> -static int at91_cf_ss_suspend(struct pcmcia_socket *s)
> -{
> -	return at91_cf_set_socket(s, &dead_socket);
> -}
> -
> -/* we already mapped the I/O region */
> -static int at91_cf_set_io_map(struct pcmcia_socket *s, struct pccard_io_map *io)
> -{
> -	struct at91_cf_socket	*cf;
> -	u32			csr;
> -
> -	cf = container_of(s, struct at91_cf_socket, socket);
> -	io->flags &= (MAP_ACTIVE | MAP_16BIT | MAP_AUTOSZ);
> -
> -	/*
> -	 * Use 16 bit accesses unless/until we need 8-bit i/o space.
> -	 *
> -	 * NOTE: this CF controller ignores IOIS16, so we can't really do
> -	 * MAP_AUTOSZ.  The 16bit mode allows single byte access on either
> -	 * D0-D7 (even addr) or D8-D15 (odd), so it's close enough for many
> -	 * purposes (and handles ide-cs).
> -	 *
> -	 * The 8bit mode is needed for odd byte access on D0-D7.  It seems
> -	 * some cards only like that way to get at the odd byte, despite
> -	 * CF 3.0 spec table 35 also giving the D8-D15 option.
> -	 */
> -	if (!(io->flags & (MAP_16BIT | MAP_AUTOSZ))) {
> -		csr = AT91_MC_SMC_DBW_8;
> -		dev_dbg(&cf->pdev->dev, "8bit i/o bus\n");
> -	} else {
> -		csr = AT91_MC_SMC_DBW_16;
> -		dev_dbg(&cf->pdev->dev, "16bit i/o bus\n");
> -	}
> -	regmap_update_bits(mc, AT91_MC_SMC_CSR(cf->board->chipselect),
> -			   AT91_MC_SMC_DBW, csr);
> -
> -	io->start = cf->socket.io_offset;
> -	io->stop = io->start + SZ_2K - 1;
> -
> -	return 0;
> -}
> -
> -/* pcmcia layer maps/unmaps mem regions */
> -static int
> -at91_cf_set_mem_map(struct pcmcia_socket *s, struct pccard_mem_map *map)
> -{
> -	struct at91_cf_socket	*cf;
> -
> -	if (map->card_start)
> -		return -EINVAL;
> -
> -	cf = container_of(s, struct at91_cf_socket, socket);
> -
> -	map->flags &= (MAP_ACTIVE | MAP_ATTRIB | MAP_16BIT);
> -	if (map->flags & MAP_ATTRIB)
> -		map->static_start = cf->phys_baseaddr + CF_ATTR_PHYS;
> -	else
> -		map->static_start = cf->phys_baseaddr + CF_MEM_PHYS;
> -
> -	return 0;
> -}
> -
> -static struct pccard_operations at91_cf_ops = {
> -	.init			= at91_cf_ss_init,
> -	.suspend		= at91_cf_ss_suspend,
> -	.get_status		= at91_cf_get_status,
> -	.set_socket		= at91_cf_set_socket,
> -	.set_io_map		= at91_cf_set_io_map,
> -	.set_mem_map		= at91_cf_set_mem_map,
> -};
> -
> -/*--------------------------------------------------------------------------*/
> -
> -static const struct of_device_id at91_cf_dt_ids[] = {
> -	{ .compatible = "atmel,at91rm9200-cf" },
> -	{ /* sentinel */ }
> -};
> -MODULE_DEVICE_TABLE(of, at91_cf_dt_ids);
> -
> -static int at91_cf_probe(struct platform_device *pdev)
> -{
> -	struct at91_cf_socket	*cf;
> -	struct at91_cf_data	*board;
> -	struct resource		*io;
> -	struct resource		realio;
> -	int			status;
> -
> -	board = devm_kzalloc(&pdev->dev, sizeof(*board), GFP_KERNEL);
> -	if (!board)
> -		return -ENOMEM;
> -
> -	board->irq_pin = of_get_gpio(pdev->dev.of_node, 0);
> -	board->det_pin = of_get_gpio(pdev->dev.of_node, 1);
> -	board->vcc_pin = of_get_gpio(pdev->dev.of_node, 2);
> -	board->rst_pin = of_get_gpio(pdev->dev.of_node, 3);
> -
> -	mc = syscon_regmap_lookup_by_compatible("atmel,at91rm9200-sdramc");
> -	if (IS_ERR(mc))
> -		return PTR_ERR(mc);
> -
> -	if (!gpio_is_valid(board->det_pin) || !gpio_is_valid(board->rst_pin))
> -		return -ENODEV;
> -
> -	io = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> -	if (!io)
> -		return -ENODEV;
> -
> -	cf = devm_kzalloc(&pdev->dev, sizeof(*cf), GFP_KERNEL);
> -	if (!cf)
> -		return -ENOMEM;
> -
> -	cf->board = board;
> -	cf->pdev = pdev;
> -	cf->phys_baseaddr = io->start;
> -	platform_set_drvdata(pdev, cf);
> -
> -	/* must be a GPIO; ergo must trigger on both edges */
> -	status = devm_gpio_request(&pdev->dev, board->det_pin, "cf_det");
> -	if (status < 0)
> -		return status;
> -
> -	status = devm_request_irq(&pdev->dev, gpio_to_irq(board->det_pin),
> -					at91_cf_irq, 0, "at91_cf detect", cf);
> -	if (status < 0)
> -		return status;
> -
> -	device_init_wakeup(&pdev->dev, 1);
> -
> -	status = devm_gpio_request(&pdev->dev, board->rst_pin, "cf_rst");
> -	if (status < 0)
> -		goto fail0a;
> -
> -	if (gpio_is_valid(board->vcc_pin)) {
> -		status = devm_gpio_request(&pdev->dev, board->vcc_pin, "cf_vcc");
> -		if (status < 0)
> -			goto fail0a;
> -	}
> -
> -	/*
> -	 * The card driver will request this irq later as needed.
> -	 * but it causes lots of "irqNN: nobody cared" messages
> -	 * unless we report that we handle everything (sigh).
> -	 * (Note:  DK board doesn't wire the IRQ pin...)
> -	 */
> -	if (gpio_is_valid(board->irq_pin)) {
> -		status = devm_gpio_request(&pdev->dev, board->irq_pin, "cf_irq");
> -		if (status < 0)
> -			goto fail0a;
> -
> -		status = devm_request_irq(&pdev->dev, gpio_to_irq(board->irq_pin),
> -					at91_cf_irq, IRQF_SHARED, "at91_cf", cf);
> -		if (status < 0)
> -			goto fail0a;
> -		cf->socket.pci_irq = gpio_to_irq(board->irq_pin);
> -	} else
> -		cf->socket.pci_irq = nr_irqs + 1;
> -
> -	/*
> -	 * pcmcia layer only remaps "real" memory not iospace
> -	 * io_offset is set to 0x10000 to avoid the check in static_find_io().
> -	 * */
> -	cf->socket.io_offset = 0x10000;
> -	realio.start = cf->socket.io_offset;
> -	realio.end = realio.start + SZ_64K - 1;
> -	status = pci_remap_iospace(&realio, cf->phys_baseaddr + CF_IO_PHYS);
> -	if (status)
> -		goto fail0a;
> -
> -	/* reserve chip-select regions */
> -	if (!devm_request_mem_region(&pdev->dev, io->start, resource_size(io), "at91_cf")) {
> -		status = -ENXIO;
> -		goto fail0a;
> -	}
> -
> -	dev_info(&pdev->dev, "irqs det #%d, io #%d\n",
> -		gpio_to_irq(board->det_pin), gpio_to_irq(board->irq_pin));
> -
> -	cf->socket.owner = THIS_MODULE;
> -	cf->socket.dev.parent = &pdev->dev;
> -	cf->socket.ops = &at91_cf_ops;
> -	cf->socket.resource_ops = &pccard_static_ops;
> -	cf->socket.features = SS_CAP_PCCARD | SS_CAP_STATIC_MAP
> -				| SS_CAP_MEM_ALIGN;
> -	cf->socket.map_size = SZ_2K;
> -	cf->socket.io[0].res = io;
> -
> -	status = pcmcia_register_socket(&cf->socket);
> -	if (status < 0)
> -		goto fail0a;
> -
> -	return 0;
> -
> -fail0a:
> -	device_init_wakeup(&pdev->dev, 0);
> -	return status;
> -}
> -
> -static int at91_cf_remove(struct platform_device *pdev)
> -{
> -	struct at91_cf_socket	*cf = platform_get_drvdata(pdev);
> -
> -	pcmcia_unregister_socket(&cf->socket);
> -	device_init_wakeup(&pdev->dev, 0);
> -
> -	return 0;
> -}
> -
> -#ifdef	CONFIG_PM
> -
> -static int at91_cf_suspend(struct platform_device *pdev, pm_message_t mesg)
> -{
> -	struct at91_cf_socket	*cf = platform_get_drvdata(pdev);
> -	struct at91_cf_data	*board = cf->board;
> -
> -	if (device_may_wakeup(&pdev->dev)) {
> -		enable_irq_wake(gpio_to_irq(board->det_pin));
> -		if (gpio_is_valid(board->irq_pin))
> -			enable_irq_wake(gpio_to_irq(board->irq_pin));
> -	}
> -	return 0;
> -}
> -
> -static int at91_cf_resume(struct platform_device *pdev)
> -{
> -	struct at91_cf_socket	*cf = platform_get_drvdata(pdev);
> -	struct at91_cf_data	*board = cf->board;
> -
> -	if (device_may_wakeup(&pdev->dev)) {
> -		disable_irq_wake(gpio_to_irq(board->det_pin));
> -		if (gpio_is_valid(board->irq_pin))
> -			disable_irq_wake(gpio_to_irq(board->irq_pin));
> -	}
> -
> -	return 0;
> -}
> -
> -#else
> -#define	at91_cf_suspend		NULL
> -#define	at91_cf_resume		NULL
> -#endif
> -
> -static struct platform_driver at91_cf_driver = {
> -	.driver = {
> -		.name		= "at91_cf",
> -		.of_match_table = at91_cf_dt_ids,
> -	},
> -	.probe		= at91_cf_probe,
> -	.remove		= at91_cf_remove,
> -	.suspend	= at91_cf_suspend,
> -	.resume		= at91_cf_resume,
> -};
> -
> -module_platform_driver(at91_cf_driver);
> -
> -MODULE_DESCRIPTION("AT91 Compact Flash Driver");
> -MODULE_AUTHOR("David Brownell");
> -MODULE_LICENSE("GPL");
> -MODULE_ALIAS("platform:at91_cf");

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
