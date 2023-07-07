Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53CC874AE9D
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 12:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbjGGKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232729AbjGGKOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 06:14:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208371FE7;
        Fri,  7 Jul 2023 03:14:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CCAB618EF;
        Fri,  7 Jul 2023 10:14:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D529DC433C8;
        Fri,  7 Jul 2023 10:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1688724868;
        bh=hzgm6iCuJXquD0czGylXjzuQplsX1jKdOFq14AOxEls=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AITopDNkXw+KpbAueDPJT9H8i0NNscSaV65CUxe+7QF4uUSDDWaFH/cd6Vr32/VY1
         K5Eghn+qpb+DGhiJuq03oK817Vl3vwAvcaZuPSV1IijYp2Dryn+e5VRpLqSn1ZctYa
         Enoo5DV+hLsKZB/N7s4jfIh/sykd8cqnW4YwQnRM=
Date:   Fri, 7 Jul 2023 11:11:34 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     richard.yu@hpe.com
Cc:     verdun@hpe.com, nick.hawkins@hpe.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/3] usb: gadget: udc: gxp-udc: add HPE GXP USB support
Message-ID: <2023070749-nutlike-reverse-5847@gregkh>
References: <20230706215910.78772-1-richard.yu@hpe.com>
 <20230706215910.78772-3-richard.yu@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230706215910.78772-3-richard.yu@hpe.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 06, 2023 at 04:59:09PM -0500, richard.yu@hpe.com wrote:
> From: Richard Yu <richard.yu@hpe.com>
> 
> The HPE GXP vEHCI controller presents a four port EHCI compatible PCI
> function to host software. Each vEHCI port is logically connected to a
> corresponding set of virtual device registers.
> 
> Signed-off-by: Richard Yu <richard.yu@hpe.com>
> ---
>  drivers/usb/gadget/udc/Kconfig   |    6 +
>  drivers/usb/gadget/udc/Makefile  |    1 +
>  drivers/usb/gadget/udc/gxp-udc.c | 1401 ++++++++++++++++++++++++++++++
>  3 files changed, 1408 insertions(+)
>  create mode 100644 drivers/usb/gadget/udc/gxp-udc.c
> 
> diff --git a/drivers/usb/gadget/udc/Kconfig b/drivers/usb/gadget/udc/Kconfig
> index 83cae6bb12eb..c01eb2a2c7db 100644
> --- a/drivers/usb/gadget/udc/Kconfig
> +++ b/drivers/usb/gadget/udc/Kconfig
> @@ -461,6 +461,12 @@ config USB_ASPEED_UDC
>  	  dynamically linked module called "aspeed_udc" and force all
>  	  gadget drivers to also be dynamically linked.
>  
> +config USB_GXP_UDC
> +        bool "GXP UDC Driver"
> +        depends on ARCH_HPE_GXP || COMPILE_TEST
> +        help
> +          Say "y" to add support for GXP UDC driver
> +
>  source "drivers/usb/gadget/udc/aspeed-vhub/Kconfig"
>  
>  #
> diff --git a/drivers/usb/gadget/udc/Makefile b/drivers/usb/gadget/udc/Makefile
> index ee569f63c74a..63fa262f31c5 100644
> --- a/drivers/usb/gadget/udc/Makefile
> +++ b/drivers/usb/gadget/udc/Makefile
> @@ -42,3 +42,4 @@ obj-$(CONFIG_USB_ASPEED_VHUB)	+= aspeed-vhub/
>  obj-$(CONFIG_USB_ASPEED_UDC)	+= aspeed_udc.o
>  obj-$(CONFIG_USB_BDC_UDC)	+= bdc/
>  obj-$(CONFIG_USB_MAX3420_UDC)	+= max3420_udc.o
> +obj-$(CONFIG_USB_GXP_UDC)	+= gxp-udc.o
> diff --git a/drivers/usb/gadget/udc/gxp-udc.c b/drivers/usb/gadget/udc/gxp-udc.c
> new file mode 100644
> index 000000000000..97d198128c06
> --- /dev/null
> +++ b/drivers/usb/gadget/udc/gxp-udc.c
> @@ -0,0 +1,1401 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright (C) 2023 Hewlett-Packard Enterprise Development Company, L.P. */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/spinlock.h>
> +#include <linux/interrupt.h>
> +#include <linux/platform_device.h>
> +#include <linux/of_platform.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/delay.h>
> +#include <linux/io.h>
> +#include <linux/slab.h>
> +#include <linux/clk.h>
> +#include <linux/err.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/gadget.h>
> +#include <linux/usb/otg.h>
> +#include <linux/prefetch.h>
> +#include <linux/regmap.h>
> +#include <linux/mfd/syscon.h>

Are you sure you need all of these?  I don't see any syscon_* calls in
this file.  Please audit the list of includes here and remove all
unneeded ones.

thanks,

greg k-h
