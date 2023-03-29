Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C706CD4B2
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbjC2IeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjC2IeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:34:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCAA10DB;
        Wed, 29 Mar 2023 01:33:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1C6E8B82103;
        Wed, 29 Mar 2023 08:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F53C433D2;
        Wed, 29 Mar 2023 08:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680078819;
        bh=WU/YsdWjPFjsmJIbPqeleTMIoAD615nCS44eUp0zb5U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlruXR3ymsvN9KoqiMA9tR9Lwbb9b83TEZh1tCGum0ywwzVjR6Qlhtq7c69yxy/mk
         qdJBnQfBEFNCGMhoo6FcSbCM5ywaNQfqRtMK0V0XuwtqZvFK/sAIV44znEqqgo3607
         gAkzqeFBRcBBHuNTJaV9iFvoWqMiBZRZj5CVlo6o=
Date:   Wed, 29 Mar 2023 10:33:36 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ruslan Bilovol <ruslan.bilovol@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        peter.chen@kernel.org
Subject: Re: [PATCH v3] usb: gadget: epautoconf: claim smallest endpoints
 first
Message-ID: <ZCP34MKN3PyOQB6v@kroah.com>
References: <20230312224836.297793-1-ruslan.bilovol@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312224836.297793-1-ruslan.bilovol@gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 06:48:36PM -0400, Ruslan Bilovol wrote:
> UDC hardware may have endpoints with different maxpacket
> size. Current endpoint matching code takes first matching
> endpoint from the list.
> 
> It's always possible that gadget allocates endpoints for
> small transfers (maxpacket size) first, then larger ones.
> That works fine if all matching UDC endpoints have same
> maxpacket size or are big enough to serve that allocation.
> 
> However, some UDCs have first endpoints in the list with
> bigger maxpacket size, whereas last endpoints are much
> smaller. In this case endpoint allocation will fail for
> the gadget (which allocates smaller endpoints first) on
> final endpoint allocations.

Note, please use all 72 columns in your changelog text if possible.

> 
> To make endpoint allocation fair, pick up smallest
> matching endpoints first, leaving bigger ones for
> heavier applications.
> 
> Keel old behavior when "wMaxPacketSize == 0" because

"Keel"?

> it's a special case. In this case a gadget driver wants
> to use a whole available MaxPacketSize of claimed
> endpoint. Since it doesn't know what MaxPacketSize
> may be in a particular UDC endpoint, it just
> relies on epautoconf core and gets what's available

I don't see the wMaxPacketSize == 0 case in the code today, so why are
you adding that?

And this really isn't "smallest endpoints", it is "find the best fit"

> 
> Signed-off-by: Ruslan Bilovol <ruslan.bilovol@gmail.com>
> ---
> 
> v3: updated commit msg, rebased onto latest gregkh/usb-next
> v2: rebased onto latest balbi/next branch
> v1: https://lore.kernel.org/lkml/20200629200551.27040-1-ruslan.bilovol@gmail.com/
> 
>  drivers/usb/gadget/epautoconf.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/gadget/epautoconf.c b/drivers/usb/gadget/epautoconf.c
> index ed5a92c474e5..086bb46e3f5a 100644
> --- a/drivers/usb/gadget/epautoconf.c
> +++ b/drivers/usb/gadget/epautoconf.c
> @@ -66,7 +66,7 @@ struct usb_ep *usb_ep_autoconfig_ss(
>  	struct usb_ss_ep_comp_descriptor *ep_comp
>  )
>  {
> -	struct usb_ep	*ep;
> +	struct usb_ep	*ep, *ep_min = NULL;
>  
>  	if (gadget->ops->match_ep) {
>  		ep = gadget->ops->match_ep(gadget, desc, ep_comp);
> @@ -74,14 +74,27 @@ struct usb_ep *usb_ep_autoconfig_ss(
>  			goto found_ep;
>  	}
>  
> -	/* Second, look at endpoints until an unclaimed one looks usable */
> +	/*
> +	 * Second, look at endpoints until an unclaimed one looks usable.
> +	 * Try to find one with smallest maxpacket limit, leaving larger
> +	 * endpoints for heavier applications

What do you mean by "heavier"?

This is a "find the smallest endpoint to fit the request" type of logic,
right?  If so, please say just that.


> +	 */
>  	list_for_each_entry (ep, &gadget->ep_list, ep_list) {
> -		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp))
> -			goto found_ep;
> +		if (usb_gadget_ep_match_desc(gadget, ep, desc, ep_comp)) {
> +			if (desc->wMaxPacketSize == 0)
> +				goto found_ep;
> +			else if (!ep_min)
> +				ep_min = ep;
> +			else if (ep->maxpacket_limit < ep_min->maxpacket_limit)
> +				ep_min = ep;
> +		}
>  	}
>  
>  	/* Fail */
> -	return NULL;
> +	if (!ep_min)
> +		return NULL;

The fail comment should be on the return NULL line, or better yet,
rewritten to say:
	/* If we found no endpoint that fits, then fail the request */


thanks,

greg k-h
