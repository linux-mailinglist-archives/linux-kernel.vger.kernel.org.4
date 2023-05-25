Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B480710AC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240878AbjEYLVS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjEYLVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:21:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E001B4;
        Thu, 25 May 2023 04:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685013667; x=1716549667;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=Vaf8hbEzW0GiP9VSR1Vgme7i6rbC6bI7GrB1LsNCkw8=;
  b=hJ5CC3sYRS+kYaMST9e2Q64sL4Jygrlrq1dTlYoLy3scNNvTR9VTLufI
   bobd5kceytGSPOr0Z7NadE8QNIMtosJl8ZJhKzmyfwbxTMWSyTS8NN/x2
   tMP60BMcvp2Y2ME+nutFCdoAtzX1fQ+LFN9I5LvldK9hGGVjxDdnUrjLa
   vSCzPHZwrEI3RkCWhpPiZCeWKVSrbQVX396J+zKg9jZPAgEJKxJPHUOpQ
   pxHuehLCkd0bx/qujAeQD1FU3FYrd8KVSxE8OAVfVhYvnmFHOwMwF54IM
   KP2TP3z6N/4CROA/VzLQhVYusSFHCFOthQ4s3T4efH/JlyhwKL+B+4n9A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="338434389"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="338434389"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 04:21:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10720"; a="849164264"
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="849164264"
Received: from aghiriba-mobl.ger.corp.intel.com ([10.249.40.17])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2023 04:21:02 -0700
Date:   Thu, 25 May 2023 14:20:59 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Hugo Villeneuve <hugo@hugovil.com>
cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        jringle@gridpoint.com, tomasz.mon@camlingroup.com,
        l.perczak@camlintechnologies.com,
        linux-serial <linux-serial@vger.kernel.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>
Subject: Re: [PATCH v3 05/11] serial: sc16is7xx: fix broken port 0 uart
 init
In-Reply-To: <20230525040324.3773741-6-hugo@hugovil.com>
Message-ID: <2936e18f-44ea-faed-9fa0-2ddefe7c3194@linux.intel.com>
References: <20230525040324.3773741-1-hugo@hugovil.com> <20230525040324.3773741-6-hugo@hugovil.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-497861732-1685013436=:1738"
Content-ID: <7ba46da5-da4e-341e-382e-cd7cf39b5cd@linux.intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-497861732-1685013436=:1738
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <b5e661ae-85b6-6dfc-28d2-ef1d35c850b0@linux.intel.com>

On Thu, 25 May 2023, Hugo Villeneuve wrote:

> From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> 
> While experimenting with rs485 configuration on a SC16IS752 dual UART,

You can remove this intro, it's not necessary.

> I found that the sc16is7xx_config_rs485() function was called only for
> the second port (index 1, channel B), causing initialization problems
> for the first port.

Just start with:

sc16is7xx_config_rs485() function is called only for ...

> For the sc16is7xx driver, port->membase and port->mapbase are not set,
> and their default values are 0. And we set port->iobase to the device
> index. This means that when the first device is registered using the
> uart_add_one_port() function, the following values will be in the port
> structure:
>     port->membase = 0
>     port->mapbase = 0
>     port->iobase  = 0
> 
> Therefore, the function uart_configure_port() in serial_core.c will
> exit early because of the following check:
> 	/*
> 	 * If there isn't a port here, don't do anything further.
> 	 */
> 	if (!port->iobase && !port->mapbase && !port->membase)
> 		return;
> 
> Typically, I2C and SPI drivers do not set port->membase and
> port->mapbase. But I found that the max310x driver sets
> port->membase to ~0 (all ones).

The max310x driver sets port->membase to ~0 (all ones) to solve the same 
problem.

> By implementing the same change in our
> driver, uart_configure_port() is now correctly executed.

our driver -> this driver

This changelog was really well describing the problem! :-)

> Fixes: dfeae619d781 ("serial: sc16is7xx")
> Signed-off-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> ---
> I am not sure if this change is the best long-term solution to this
> problem, and maybe uart_configure_port() itself could be modified to
> take into account the fact that some devices have all three *base
> values set to zero?

Yeah, some other solution should be devised. Maybe we should add another 
.iotype for thse kind of devices. But I'm fine with this for this fix.
After editing the changelog, feel free to add:

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> Also, many drivers use port->iobase as an index, is it the correct way
> to use it?

"Many" for this and max310x? Besides that, uartlite.c has a comment which 
says "mark port in use".

-- 
 i.


> For example, for our driver, there was
> commit 5da6b1c079e6 ("sc16is7xx: Set iobase to device index") with the
> following explanation:
>     "Set the .iobase value to the relative index within the device to allow
>     infering the order through sysfs."
> 
>  drivers/tty/serial/sc16is7xx.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
> index af7e66db54b4..8a2fc6f89d36 100644
> --- a/drivers/tty/serial/sc16is7xx.c
> +++ b/drivers/tty/serial/sc16is7xx.c
> @@ -1443,6 +1443,7 @@ static int sc16is7xx_probe(struct device *dev,
>  		s->p[i].port.fifosize	= SC16IS7XX_FIFO_SIZE;
>  		s->p[i].port.flags	= UPF_FIXED_TYPE | UPF_LOW_LATENCY;
>  		s->p[i].port.iobase	= i;
> +		s->p[i].port.membase	= (void __iomem *)~0;
>  		s->p[i].port.iotype	= UPIO_PORT;
>  		s->p[i].port.uartclk	= freq;
>  		s->p[i].port.rs485_config = sc16is7xx_config_rs485;
> 
--8323329-497861732-1685013436=:1738--
