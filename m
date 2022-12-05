Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72BD9642870
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbiLEM2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:28:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLEM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:28:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7664FADE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 04:28:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7FCE6B8103C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 12:28:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EF5C433D6;
        Mon,  5 Dec 2022 12:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670243318;
        bh=p0jlDmkjydJVkRUVJOWk4Ud2ZF3Mx24s6SrrqIkjF1M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2ATTqSRKnAri5kaxJlDNouOj3spRG8yzINH9U6p4dO/NXr6j55mrnlhez19R7Viif
         5/k79X/uMir75agfCtlCQRKqOYmj85hnEf/IkNlXqb9VwVzanHrc6HbhG7Rhay3dww
         WDcZji/o/c9dfZcx3dMVPb2rop8hwPSXAio8W6eg=
Date:   Mon, 5 Dec 2022 13:28:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jack Schofield <schofija@oregonstate.edu>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: emxx_udc: Remove unneeded parentheses
Message-ID: <Y43j88qqo8K96TZL@kroah.com>
References: <20221128044012.GA2028@virt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128044012.GA2028@virt>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 27, 2022 at 08:40:12PM -0800, Jack Schofield wrote:
> Parentheses are not required around condition tests. Remove to follow
> Linux Kernel coding style. Issue reported by checkpatch.
> 
> Signed-off-by: Jack Schofield <schofija@oregonstate.edu>
> ---
> There are more instances of extra parens to cleanup. If this patch is
> welcome I can continue to cleanup this file.
> 
>  drivers/staging/emxx_udc/emxx_udc.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
> index b4e19174bef2..1d4ac8374fe2 100644
> --- a/drivers/staging/emxx_udc/emxx_udc.c
> +++ b/drivers/staging/emxx_udc/emxx_udc.c
> @@ -149,8 +149,8 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
>  			/* SET_FEATURE */
>  			recipient = (u8)(p_ctrl->bRequestType & USB_RECIP_MASK);
>  			selector  = le16_to_cpu(p_ctrl->wValue);
> -			if ((recipient == USB_RECIP_DEVICE) &&
> -			    (selector == USB_DEVICE_TEST_MODE)) {
> +			if (recipient == USB_RECIP_DEVICE &&
> +			    selector == USB_DEVICE_TEST_MODE) {
>  				wIndex = le16_to_cpu(p_ctrl->wIndex);
>  				test_mode = (u32)(wIndex >> 8);
>  				_nbu2ss_set_test_mode(udc, test_mode);
> @@ -287,7 +287,7 @@ static int _nbu2ss_epn_exit(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
>  	u32		num;
>  	u32		data;
>  
> -	if ((ep->epnum == 0) || (udc->vbus_active == 0))
> +	if (ep->epnum == 0 || udc->vbus_active == 0)

This type of change requires you to remember the == comes before || so
it's best to just leave the code as-is to make it much more obvious
what is happening.

sorry,

greg k-h
