Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59534644DE2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 22:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiLFVVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 16:21:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiLFVVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 16:21:53 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BAB47325;
        Tue,  6 Dec 2022 13:21:52 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3E1933D7;
        Tue,  6 Dec 2022 22:21:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670361711;
        bh=OrJsCJNo27Qlp3rbIbQPFuVvMQMYEBOzgkHtwGy1OdQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FwiImNRf7ALJLdu5YaC8qgkXWb8AnAiJDZIVuV9VEhI6Odi/lmjE10LQ8JHi3ru+V
         4M5VR3lKZO+3vXLGdDoP6c4Hbr/GiVqDzZvox4qcbnQld9WxuvZy85p2mS1s8LfhYR
         x2qMpgVuMRxMzjpCvdkCd8mwF4Y4Bqn4EW5LLHTA=
Date:   Tue, 6 Dec 2022 23:21:48 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Szymon Heidrich <szymon.heidrich@gmail.com>
Cc:     dan.scally@ideasonboard.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] usb: gadget: uvc: Prevent buffer overflow in setup
 handler
Message-ID: <Y4+ybPL2uUO4SCJJ@pendragon.ideasonboard.com>
References: <9ffc4812-ab45-d7f9-7d93-fcacf629a754@ideasonboard.com>
 <20221206141301.51305-1-szymon.heidrich@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221206141301.51305-1-szymon.heidrich@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Szymon,

Thank you for the patch.

On Tue, Dec 06, 2022 at 03:13:01PM +0100, Szymon Heidrich wrote:
> Setup function uvc_function_setup permits control transfer
> requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
> data stage handler for OUT transfer uses memcpy to copy req->actual
> bytes to uvc_event->data.data array of size 60. This may result
> in an overflow of 4 bytes.
> 
> Fixes: cdda479f15cd ("USB gadget: video class function driver")
> Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>

Good catch.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> V1 -> V2: Corrected commit message and changed ?: in favor of min_t
> V2 -> V3: Added fixes tag
> 
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

-- 
Regards,

Laurent Pinchart
