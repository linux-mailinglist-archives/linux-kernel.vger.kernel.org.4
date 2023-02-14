Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2432A69647E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 14:20:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232402AbjBNNUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 08:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231834AbjBNNUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 08:20:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F30274A0;
        Tue, 14 Feb 2023 05:20:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B30161637;
        Tue, 14 Feb 2023 13:20:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68356C4339C;
        Tue, 14 Feb 2023 13:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676380829;
        bh=KdANFRR4PRJ9kp/ABO4FSUJAPI+iM5+P01yw4+tRecg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n64qKUh3kEFPlUcR6itG132XR7uCD164NatKPKbJDotAvNNKJEU5TWRBollm43lEm
         psw9zw3RqbkLzEsjoFvYTfmPXbSAQ47KutKvbz+UDmXT9ChDMuGCiR+iJ2wUYmkORv
         +uLIW7eiAWsRPLOigveURHt33QWGBQbURgiuLAvw=
Date:   Tue, 14 Feb 2023 14:20:27 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: Re: [PATCH V3 1/2] usb: gadget: u_ether: Convert prints to device
 prints
Message-ID: <Y+uKmxD+QLNSMx8e@kroah.com>
References: <20230209125319.18589-1-jonathanh@nvidia.com>
 <bcbf9d22-c90a-a4d1-2931-0da43bc7371e@collabora.com>
 <3dc8575e-050c-5e04-ae7c-af380801a227@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dc8575e-050c-5e04-ae7c-af380801a227@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 11:55:56AM +0000, Jon Hunter wrote:
> 
> On 13/02/2023 13:49, Andrzej Pietrasiewicz wrote:
> > Hi Jon,
> > 
> > W dniu 9.02.2023 o 13:53, Jon Hunter pisze:
> > > The USB ethernet gadget driver implements its own print macros which
> > > call printk. Device drivers should use the device prints that print the
> > > device name. Fortunately, the same macro names are defined in the header
> > > file 'linux/usb/composite.h' and these use the device prints. Therefore,
> > > remove the local definitions in the USB ethernet gadget driver and use
> > > those in 'linux/usb/composite.h'. The only difference is that now the
> > > device name is printed instead of the ethernet interface name.
> > > 
> > > Tested using ethernet gadget on Jetson AGX Orin.
> > > 
> > > Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
> > > Tested-by: Jon Hunter <jonathanh@nvidia.com>
> > > ---
> > > V3: Added this patch and dropped the patch in V2 that improved some of
> > >      the prints.
> > > 
> > >   drivers/usb/gadget/function/u_ether.c | 36 +--------------------------
> > >   1 file changed, 1 insertion(+), 35 deletions(-)
> > > 
> > > diff --git a/drivers/usb/gadget/function/u_ether.c
> > > b/drivers/usb/gadget/function/u_ether.c
> > > index 8f12f3f8f6ee..740331882e8d 100644
> > > --- a/drivers/usb/gadget/function/u_ether.c
> > > +++ b/drivers/usb/gadget/function/u_ether.c
> > > @@ -17,6 +17,7 @@
> > >   #include <linux/etherdevice.h>
> > >   #include <linux/ethtool.h>
> > >   #include <linux/if_vlan.h>
> > > +#include <linux/usb/composite.h>
> > >   #include "u_ether.h"
> > > @@ -103,41 +104,6 @@ static inline int qlen(struct usb_gadget
> > > *gadget, unsigned qmult)
> > > /*-------------------------------------------------------------------------*/
> > > -/* REVISIT there must be a better way than having two sets
> > > - * of debug calls ...
> > > - */
> > > -
> > > -#undef DBG
> > > -#undef VDBG
> > > -#undef ERROR
> > > -#undef INFO
> > > -
> > > -#define xprintk(d, level, fmt, args...) \
> > > -    printk(level "%s: " fmt , (d)->net->name , ## args)
> > > -
> > > -#ifdef DEBUG
> > > -#undef DEBUG
> > > -#define DBG(dev, fmt, args...) \
> > > -    xprintk(dev , KERN_DEBUG , fmt , ## args)
> > > -#else
> > > -#define DBG(dev, fmt, args...) \
> > > -    do { } while (0)
> > > -#endif /* DEBUG */
> > 
> > Actually there are more (at least hypothetical) changes than the declared
> > change of printed device name.
> > 
> > If DEBUG is not set there can be _more_ messages printed
> > when your patch is applied as-is (i.e. all DBG() invocations will
> > expand into some dev_dbg(), whereas before the patch is applied
> > they compile into nothing).
> 
> So dev_dbg() messages will only be printed if DEBUG is defined or if dynamic
> debug is enabled and the prints are enabled.
> 
> Greg, let me know what your thoughts on this version are?

Looks good to me, let me queue it up now.

thanks,

greg k-h
