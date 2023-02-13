Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9184D69476D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbjBMNuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 08:50:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjBMNt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 08:49:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B221BADC;
        Mon, 13 Feb 2023 05:49:51 -0800 (PST)
Received: from [192.168.0.192] (unknown [194.146.248.75])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BC57266018CF;
        Mon, 13 Feb 2023 13:49:49 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676296190;
        bh=XiD9OByqHK9do+PqpCf1DqzfoDEHH76nlh+pxGnhaGg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WHhr2vwDOBN5R6Zl/353Iv5qjYlePv0Eh7dySXr4COAFX8kt1rPlZwOjzp4V58e3d
         bJ5zzppDsacdsEd6A5JWK6xj/wq+5R8Xs4h5FgrRBZFTunPxXyMSwjHblC+kUbJw3R
         2hMIvek3WlOKjRK8b2ZLr5ISAfr3sz9Fw7rOJHf7ko8662B/4p6tq5UWwgN3k5WOsD
         pUo1zQTEoAAahZ3xhIrkH9HssmjN7pVdNwZiHrSVdmKo2L+yX47wvQClyCETMa4bWl
         q0Sb+WI8+BR2fqaJytBfZRcbJ5vCsPMWSmTTpvlvMmTDSubqjvAEv/YoaDTdrL32nn
         U7NiNvkuoYCSg==
Message-ID: <bcbf9d22-c90a-a4d1-2931-0da43bc7371e@collabora.com>
Date:   Mon, 13 Feb 2023 14:49:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH V3 1/2] usb: gadget: u_ether: Convert prints to device
 prints
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20230209125319.18589-1-jonathanh@nvidia.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20230209125319.18589-1-jonathanh@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

W dniu 9.02.2023 o 13:53, Jon Hunter pisze:
> The USB ethernet gadget driver implements its own print macros which
> call printk. Device drivers should use the device prints that print the
> device name. Fortunately, the same macro names are defined in the header
> file 'linux/usb/composite.h' and these use the device prints. Therefore,
> remove the local definitions in the USB ethernet gadget driver and use
> those in 'linux/usb/composite.h'. The only difference is that now the
> device name is printed instead of the ethernet interface name.
> 
> Tested using ethernet gadget on Jetson AGX Orin.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> Tested-by: Jon Hunter <jonathanh@nvidia.com>
> ---
> V3: Added this patch and dropped the patch in V2 that improved some of
>      the prints.
> 
>   drivers/usb/gadget/function/u_ether.c | 36 +--------------------------
>   1 file changed, 1 insertion(+), 35 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/u_ether.c b/drivers/usb/gadget/function/u_ether.c
> index 8f12f3f8f6ee..740331882e8d 100644
> --- a/drivers/usb/gadget/function/u_ether.c
> +++ b/drivers/usb/gadget/function/u_ether.c
> @@ -17,6 +17,7 @@
>   #include <linux/etherdevice.h>
>   #include <linux/ethtool.h>
>   #include <linux/if_vlan.h>
> +#include <linux/usb/composite.h>
>   
>   #include "u_ether.h"
>   
> @@ -103,41 +104,6 @@ static inline int qlen(struct usb_gadget *gadget, unsigned qmult)
>   
>   /*-------------------------------------------------------------------------*/
>   
> -/* REVISIT there must be a better way than having two sets
> - * of debug calls ...
> - */
> -
> -#undef DBG
> -#undef VDBG
> -#undef ERROR
> -#undef INFO
> -
> -#define xprintk(d, level, fmt, args...) \
> -	printk(level "%s: " fmt , (d)->net->name , ## args)
> -
> -#ifdef DEBUG
> -#undef DEBUG
> -#define DBG(dev, fmt, args...) \
> -	xprintk(dev , KERN_DEBUG , fmt , ## args)
> -#else
> -#define DBG(dev, fmt, args...) \
> -	do { } while (0)
> -#endif /* DEBUG */

Actually there are more (at least hypothetical) changes than the declared
change of printed device name.

If DEBUG is not set there can be _more_ messages printed
when your patch is applied as-is (i.e. all DBG() invocations will
expand into some dev_dbg(), whereas before the patch is applied
they compile into nothing).

> -
> -#ifdef VERBOSE_DEBUG
> -#define VDBG	DBG
> -#else
> -#define VDBG(dev, fmt, args...) \
> -	do { } while (0)
> -#endif /* DEBUG */

In the same spirit, the above block could be considered valid.

Not sure, how much of an issue it is, though.

Regards,

Andrzej

> -
> -#define ERROR(dev, fmt, args...) \
> -	xprintk(dev , KERN_ERR , fmt , ## args)
> -#define INFO(dev, fmt, args...) \
> -	xprintk(dev , KERN_INFO , fmt , ## args)
> -
> -/*-------------------------------------------------------------------------*/
> -
>   /* NETWORK DRIVER HOOKUP (to the layer above this driver) */
>   
>   static void eth_get_drvinfo(struct net_device *net, struct ethtool_drvinfo *p)

