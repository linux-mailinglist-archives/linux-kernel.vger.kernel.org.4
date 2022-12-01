Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098C163F6EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 18:55:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiLARzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 12:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiLARy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 12:54:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 568AE64FD;
        Thu,  1 Dec 2022 09:54:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0945FB81FC8;
        Thu,  1 Dec 2022 17:54:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A0C3C433D6;
        Thu,  1 Dec 2022 17:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1669917272;
        bh=L1DFaGM8nHNn32XMTy2D7ZGvSFULQgjVc7BXefwrn8I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pFDgp3Qf/zlVOy9RGKihyVzStGB3ha5hXSRK7HSGbxigIVWaLLsxqwVd3CJTwtpjh
         JOJ1u1p5hSNYgV9YrAbMCLweOPftlHe34FVQYq2ttORZj3mLElhRzJTs+xrKqUz9tZ
         Ngb5GtHhGIGvh8aDy4TMaxFSHwXEKL2J4iBlgRPQ=
Date:   Thu, 1 Dec 2022 18:54:29 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Szymon Heidrich <szymon.heidrich@gmail.com>
Cc:     dan.scally@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: gadget: uvc: Prevent buffer overflow in setup
 handler
Message-ID: <Y4jqVZfEj+/VdfnH@kroah.com>
References: <abe0cc82-2fb8-2e29-e7b9-90fe6ae4d203@gmail.com>
 <20221201154546.11226-1-szymon.heidrich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221201154546.11226-1-szymon.heidrich@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 04:45:46PM +0100, Szymon Heidrich wrote:
> Setup function uvc_function_setup permits control transfer
> requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
> data stage handler for OUT transfer uses memcpy to copy req->actual
> bytes to uvc_event->data.data array of size 60. This may result
> in an overflow of 4 bytes.
> 
> Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>
> ---
>  drivers/usb/gadget/function/f_uvc.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 6e196e061..4419b7972 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -216,8 +216,9 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
>  
>  		memset(&v4l2_event, 0, sizeof(v4l2_event));
>  		v4l2_event.type = UVC_EVENT_DATA;
> -		uvc_event->data.length = req->actual;
> -		memcpy(&uvc_event->data.data, req->buf, req->actual);
> +		uvc_event->data.length = min_t(unsigned int, req->actual,
> +			sizeof(uvc_event->data.data));
> +		memcpy(&uvc_event->data.data, req->buf, uvc_event->data.length);
>  		v4l2_event_queue(&uvc->vdev, &v4l2_event);
>  	}
>  }
> -- 
> 2.38.1
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
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
