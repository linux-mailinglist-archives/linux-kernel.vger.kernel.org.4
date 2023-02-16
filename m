Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E366699309
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbjBPLW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:22:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjBPLW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:22:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2DDCC03;
        Thu, 16 Feb 2023 03:22:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6CA2A61F8B;
        Thu, 16 Feb 2023 11:22:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52A45C433EF;
        Thu, 16 Feb 2023 11:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676546574;
        bh=0qqP8YfdPuUO0Dc99+8WCSqLXB5eDVzze4LLyYnqAnc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WxDdc3HbDfcBYDyK5L0kpRknYDGo0/fnM3NOc1toFI9gKT8YPXPddarGA8iFcTVBe
         Y/ibSW3vaenzYauaBbnCiwC62RksV7aSGxeTWHyjMUjKbhZgH1Gp8Hnlpv1aLtVVFl
         AEVGO18oEIKCebnEaSatcxjHUT9W9rMhsziF1/5Q=
Date:   Thu, 16 Feb 2023 12:22:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Daisy.Barrera@siriusxm.com, Cliff.Holden@siriusxm.com,
        arnd@arndb.de, tony@atomide.com, jdelvare@suse.de,
        neal_liu@aspeedtech.com, linus.walleij@linaro.org,
        egtvedt@samfundet.no, biju.das.jz@bp.renesas.com,
        herve.codina@bootlin.com
Subject: Re: [PATCH 3/4] usb: cdns2: Add tracepoints for CDNS2 driver
Message-ID: <Y+4SCXeMUgQhpADE@kroah.com>
References: <20230216105411.364157-1-pawell@cadence.com>
 <20230216105411.364157-4-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216105411.364157-4-pawell@cadence.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 05:54:10AM -0500, Pawel Laszczak wrote:
> Patch adds the series of tracepoints that can be used for
> debugging issues detected in driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/gadget/udc/cdns2/Makefile       |   2 +
>  drivers/usb/gadget/udc/cdns2/cdns2-debug.h  | 200 +++++++
>  drivers/usb/gadget/udc/cdns2/cdns2-ep0.c    |  26 +-
>  drivers/usb/gadget/udc/cdns2/cdns2-gadget.c |  52 +-
>  drivers/usb/gadget/udc/cdns2/cdns2-trace.c  |  11 +
>  drivers/usb/gadget/udc/cdns2/cdns2-trace.h  | 609 ++++++++++++++++++++
>  6 files changed, 897 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-debug.h
>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.c
>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-trace.h
> 
> diff --git a/drivers/usb/gadget/udc/cdns2/Makefile b/drivers/usb/gadget/udc/cdns2/Makefile
> index 7c746e6d53c2..a1ffbbe2e768 100644
> --- a/drivers/usb/gadget/udc/cdns2/Makefile
> +++ b/drivers/usb/gadget/udc/cdns2/Makefile
> @@ -1,5 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  # define_trace.h needs to know how to find our header
> +CFLAGS_cdns2-trace.o		:= -I$(src)
>  
>  obj-$(CONFIG_USB_CDNS2_UDC)		+= cdns2-udc-pci.o
>  cdns2-udc-pci-$(CONFIG_USB_CDNS2_UDC)	+= cdns2-pci.o cdns2-gadget.o cdns2-ep0.o
> +cdns2-udc-pci-$(CONFIG_TRACING)	+= cdns2-trace.o
> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-debug.h b/drivers/usb/gadget/udc/cdns2/cdns2-debug.h
> new file mode 100644
> index 000000000000..3a80f3fbdcd3
> --- /dev/null
> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-debug.h
> @@ -0,0 +1,200 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Cadence USBHS-DEV Driver.
> + * Debug header file.
> + *
> + * Copyright (C) 2023 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#ifndef __LINUX_CDNS2_DEBUG
> +#define __LINUX_CDNS2_DEBUG
> +
> +static inline const char *cdns2_decode_usb_irq(char *str, size_t size,
> +					       u8 usb_irq, u8 ext_irq)

<snip>

Why are all of these big functions declared as inline?  Do they really
work as inline functions if you only reference them in a trace callback?

thanks,

greg k-h
