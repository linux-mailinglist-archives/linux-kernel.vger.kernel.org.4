Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0806A180D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 09:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBXIga (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 03:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjBXIgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 03:36:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E363A3E;
        Fri, 24 Feb 2023 00:36:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47C1C60F10;
        Fri, 24 Feb 2023 08:36:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D33AC433EF;
        Fri, 24 Feb 2023 08:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677227773;
        bh=cNtvCBv9e5EOzBPQ4hr6vb//BkwJ1Beq5UG98RTPz+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Z6+5sX/j+mSxur6GjQu5Jl5C2KUPZCQkVHFt3iPMZ8fpN3uPM2ZMFPnJT0SkusOM
         c6SpCDnp2Ru6Iqu04qyY9aAOLY4sZt92qSBlZb8xDKn8lh9f3II5kAUwgSPU2Ibthf
         UnecJmK6GOnTka33nuKPLT5JeZ4RqB2diPi2IW5I=
Date:   Fri, 24 Feb 2023 09:36:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     void0red <void0red@gmail.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: udc: add return value check of kzalloc in
 mv_udc_probe
Message-ID: <Y/h28duM12cEbaqR@kroah.com>
References: <20230224080842.3104911-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224080842.3104911-1-void0red@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 04:08:42PM +0800, void0red wrote:
> Even an 8-byte kzalloc will fail when we don't have enough memory,
> so we need a nullptr check and do the cleanup when it fails.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081
> 
> Signed-off-by: void0red <void0red@gmail.com>
> ---
>  drivers/usb/gadget/udc/mv_udc_core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
> index b397f3a84..6dd6d52de 100644
> --- a/drivers/usb/gadget/udc/mv_udc_core.c
> +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> @@ -2230,6 +2230,10 @@ static int mv_udc_probe(struct platform_device *pdev)
>  
>  	/* allocate a small amount of memory to get valid address */
>  	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
> +	if (!udc->status_req->req.buf) {
> +		retval = -ENOMEM;
> +		goto err_destroy_dma;
> +	}
>  	udc->status_req->req.dma = DMA_ADDR_INVALID;
>  
>  	udc->resume_state = USB_STATE_NOTATTACHED;
> -- 
> 2.34.1
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- It looks like you did not use your "real" name for the patch on either
  the Signed-off-by: line, or the From: line (both of which have to
  match).  Please read the kernel file,
  Documentation/process/submitting-patches.rst for how to do this
  correctly.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
