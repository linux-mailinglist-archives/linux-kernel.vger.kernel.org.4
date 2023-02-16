Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4740869930E
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjBPLYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjBPLYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:24:19 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B04671554B;
        Thu, 16 Feb 2023 03:24:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 021A3CE2902;
        Thu, 16 Feb 2023 11:24:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992C0C433EF;
        Thu, 16 Feb 2023 11:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676546655;
        bh=BI+4VFV2LW0IJC5veXtpUv8Ydx7BNeOwxhkh7tEqj/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OWjjOiDLAgGl/nVwA5I5MHqTOLnLQdm2VIJvSFTjLPyL7HCDTX5Q9Zf+4N1q+QxZI
         96BIxgH2stGwrbaO2w/rmO8dabKoU6S96hDmoYW4qscyDWCfNt3F4+EePKlsP8uF64
         m2MaCCaEPSOrO6DsRUDmaFT5MCIfDa6sDf3tZS50=
Date:   Thu, 16 Feb 2023 12:24:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Daisy.Barrera@siriusxm.com, Cliff.Holden@siriusxm.com,
        arnd@arndb.de, tony@atomide.com, jdelvare@suse.de,
        neal_liu@aspeedtech.com, linus.walleij@linaro.org,
        egtvedt@samfundet.no, biju.das.jz@bp.renesas.com,
        herve.codina@bootlin.com
Subject: Re: [PATCH 1/4] usb: cdns2: Device side header file for CDNS2 driver
Message-ID: <Y+4SXE25Xl7Lv/K8@kroah.com>
References: <20230216105411.364157-1-pawell@cadence.com>
 <20230216105411.364157-2-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216105411.364157-2-pawell@cadence.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 05:54:08AM -0500, Pawel Laszczak wrote:
> Patch defines macros, registers and structures used by
> Device side driver.
> 
> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> ---
>  drivers/usb/gadget/udc/cdns2/cdns2-gadget.h | 670 ++++++++++++++++++++
>  1 file changed, 670 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
> 
> diff --git a/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
> new file mode 100644
> index 000000000000..66cdb902163c
> --- /dev/null
> +++ b/drivers/usb/gadget/udc/cdns2/cdns2-gadget.h
> @@ -0,0 +1,670 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * USBHS-DEV device controller driver header file
> + *
> + * Copyright (C) 2023 Cadence.
> + *
> + * Author: Pawel Laszczak <pawell@cadence.com>
> + */
> +
> +#ifndef __LINUX_CDNS2_GADGET
> +#define __LINUX_CDNS2_GADGET
> +
> +#include <linux/usb/gadget.h>
> +#include <linux/dma-direction.h>
> +
> +/*
> + * USBHS register interface.
> + * This corresponds to the USBHS Device Controller Interface.
> + */
> +
> +/**
> + * struct cdns2_ep0_regs - endpoint 0 related registers.
> + * @rxbc: receive (OUT) 0 endpoint byte count register.
> + * @txbc: transmit (IN) 0 endpoint byte count register.
> + * @cs: 0 endpoint control and status register.
> + * @fifo: 0 endpoint fifo register.
> + * @setupdat: SETUP data register.
> + * @maxpack: 0 endpoint max packet size.

You didn't describe the "reserved" fields in here, so you will get a
kerneldoc warning :(

> + */
> +struct cdns2_ep0_regs {
> +	__u8 rxbc;
> +	__u8 txbc;
> +	__u8 cs;
> +	__u8 reserved1[4];
> +	__u8 fifo;
> +	__le32 reserved2[94];
> +	__u8 setupdat[8];
> +	__u8 reserved4[88];

Why are these all reserved?  Should they be set to 0?  Something else?

Same with the other reserved fields in this file, you need to fix up the
kerneldoc for them too.

thanks,

greg k-h
