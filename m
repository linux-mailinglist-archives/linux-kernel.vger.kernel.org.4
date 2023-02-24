Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDEC56A1D59
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjBXOTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:19:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjBXOTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:19:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBD114E94;
        Fri, 24 Feb 2023 06:19:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F3C78B81C98;
        Fri, 24 Feb 2023 14:19:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45376C433D2;
        Fri, 24 Feb 2023 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677248345;
        bh=VVr5qMwDHp3Mv4YJ3jqKYQJJBfkXts5SVmeq0n91+kw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eeg79hTvVO6pCiDYNzipa7NxI8tjGdJRcj0YNU9STBcDbRSr1QxWQBoffHrSXaCdf
         hTXYCZmvoClZQnyMqZuyEU6cRQFO0d+u1ewGTS55V/W6pkvrj5PmFbfsDjOSpYXz4d
         PBzGtVgvq+pGbvDQmYZy1RC5ZHx8j7B8RznD3UuY=
Date:   Fri, 24 Feb 2023 15:19:03 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     void0red <void0red@gmail.com>
Cc:     mudongliangabcd@gmail.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: udc: replace kzalloc with devm_kzalloc
 in mv_udc_probe and add a check for this allocation.
Message-ID: <Y/jHVzugTF4JDvqO@kroah.com>
References: <CAD-N9QVTxUSiCnprnXw=i4NVWbKFg2dZrkB0rqV2E4jzPeXAeA@mail.gmail.com>
 <20230224141101.73-1-void0red@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224141101.73-1-void0red@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 10:11:01PM +0800, void0red wrote:
> From: Kang Chen <void0red@gmail.com>
> 
> This driver uses the unified memory management api, so replace
> kzalloc with devm_kzalloc to avoid a memory leak and add a check
> for this allocation.
> 
> Reported-by: eriri <1527030098@qq.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217081
> 
> Signed-off-by: Kang Chen <void0red@gmail.com>
> ---
>  drivers/usb/gadget/udc/mv_udc_core.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/gadget/udc/mv_udc_core.c b/drivers/usb/gadget/udc/mv_udc_core.c
> index b397f3a84..08474c08d 100644
> --- a/drivers/usb/gadget/udc/mv_udc_core.c
> +++ b/drivers/usb/gadget/udc/mv_udc_core.c
> @@ -2229,7 +2229,11 @@ static int mv_udc_probe(struct platform_device *pdev)
>  	INIT_LIST_HEAD(&udc->status_req->queue);
>  
>  	/* allocate a small amount of memory to get valid address */
> -	udc->status_req->req.buf = kzalloc(8, GFP_KERNEL);
> +	udc->status_req->req.buf = devm_kzalloc(&pdev->dev, 8, GFP_KERNEL);
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

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/process/submitting-patches.rst for what
  needs to be done here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
