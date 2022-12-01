Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63063F201
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbiLANtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:49:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiLANtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:49:45 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3812FC32;
        Thu,  1 Dec 2022 05:49:43 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 203842D9;
        Thu,  1 Dec 2022 14:49:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1669902581;
        bh=3sSiumN32WfXS7NyHhwNkd03q4CT2IYhavfVxB+W+Aw=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=UuYL6Df+a1aTs6G/6I6g4k4VUjHpGkc5HiwpLqflFRPA9Ot//hnN8AUAGABxTa4yh
         ymILLQZFvLEgxbauR6NwJ3m27zhdf8oVoqNstRgUh4kDtjo3ReGBszkfWGYJyDqO8D
         CIEiyJMNdgEsRk9d8++NEYjjhXVHNOrpmSxqkV/s=
Message-ID: <780379d9-2331-cd7a-126d-cdaa8aec023d@ideasonboard.com>
Date:   Thu, 1 Dec 2022 13:49:38 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Szymon Heidrich <szymon.heidrich@gmail.com>,
        laurent.pinchart@ideasonboard.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221201122141.8739-1-szymon.heidrich@gmail.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Subject: Re: [PATCH] Prevent buffer overflow in UVC Gadget setup handler
In-Reply-To: <20221201122141.8739-1-szymon.heidrich@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello - thanks for the patch

On 01/12/2022 12:21, Szymon Heidrich wrote:
> Setup function uvc_function_setup


You've written uvc_function_setup here, but the code changes 
uvc_function_ep0_complete.

>   permits control transfer
> requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
> data stage handler for OUT transfer uses memcpy to copy req->actual
> bytes to uvc_event->data.data array of size 60. This may result
> in an overflow of 4 bytes.
>
> Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>


Good catch

> ---
>   drivers/usb/gadget/function/f_uvc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 6e196e061..69c5eb3a3 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -216,8 +216,9 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
>   
>   		memset(&v4l2_event, 0, sizeof(v4l2_event));
>   		v4l2_event.type = UVC_EVENT_DATA;
> -		uvc_event->data.length = req->actual;
> -		memcpy(&uvc_event->data.data, req->buf, req->actual);
> +		uvc_event->data.length = (req->actual > sizeof(uvc_event->data.data) ?
> +			sizeof(uvc_event->data.data) : req->actual);


There's a clamp() macro in f_uvc.c, can we use that?

> +		memcpy(&uvc_event->data.data, req->buf, uvc_event->data.length);
>   		v4l2_event_queue(&uvc->vdev, &v4l2_event);
>   	}
>   }
