Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 546FC622B09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 13:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229603AbiKIMBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 07:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiKIMBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 07:01:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BE22CDE2;
        Wed,  9 Nov 2022 04:01:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3ECDEB81E00;
        Wed,  9 Nov 2022 12:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED837C433D6;
        Wed,  9 Nov 2022 12:01:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667995265;
        bh=MMR9BuGh9Gom2AgUFKnJO3eflwuddmurD1iEbH/TJwg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=j2Dr4QQnwLnfWBdZY6eQWbcY/jjiye/O3ZEZ9aZw3WO85oPq7faKuIogs5ghZgoAN
         plR3L6MRr+KiAlRESq0GvHIIoMpGwZALMBfZxZviMYm4xsFBY4P0dZblNW84XWOYTR
         eIWJUlTMmuXy/l/ThaLUY27vW0LvFdziNTwtBYA8=
Date:   Wed, 9 Nov 2022 13:01:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        ilpo.jarvinen@linux.intel.com, macro@orcam.me.uk,
        jay.dolan@accesio.com, cang1@live.co.uk,
        u.kleine-koenig@pengutronix.de, wander@redhat.com,
        etremblay@distech-controls.com, jk@ozlabs.org,
        biju.das.jz@bp.renesas.com, geert+renesas@glider.be,
        phil.edworthy@renesas.com, lukas@wunner.de,
        UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v3 tty-next 1/3] 8250: microchip: pci1xxxx: Add driver
 for quad-uart support.
Message-ID: <Y2uWftt5b2AWyTtX@kroah.com>
References: <20221107124517.1364484-1-kumaravel.thiagarajan@microchip.com>
 <20221107124517.1364484-2-kumaravel.thiagarajan@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107124517.1364484-2-kumaravel.thiagarajan@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 06:15:15PM +0530, Kumaravel Thiagarajan wrote:
> +++ b/drivers/tty/serial/8250/8250_pcilib.c
> @@ -0,0 +1,31 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Microchip pci1xxxx 8250 library. */

Better name and a copyright line?

> +
> +#include <linux/pci.h>
> +#include "8250.h"
> +
> +int pci_setup_port(struct pci_dev *dev, struct uart_8250_port *port,
> +		   u8 bar, unsigned int offset, int regshift)
> +{
> +	if (bar >= PCI_STD_NUM_BARS)
> +		return -EINVAL;
> +
> +	if (pci_resource_flags(dev, bar) & IORESOURCE_MEM) {
> +		if (!pcim_iomap(dev, bar, 0) && !pcim_iomap_table(dev))
> +			return -ENOMEM;
> +
> +		port->port.iotype = UPIO_MEM;
> +		port->port.iobase = 0;
> +		port->port.mapbase = pci_resource_start(dev, bar) + offset;
> +		port->port.membase = pcim_iomap_table(dev)[bar] + offset;
> +		port->port.regshift = regshift;
> +	} else {
> +		port->port.iotype = UPIO_PORT;
> +		port->port.iobase = pci_resource_start(dev, bar) + offset;
> +		port->port.mapbase = 0;
> +		port->port.membase = NULL;
> +		port->port.regshift = 0;
> +	}
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_setup_port);

This needs a better name, 8250_pci_setup_port()?  This is not a pci core
function.

thanks,

greg k-h
