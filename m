Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF74A644230
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:33:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbiLFLde (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiLFLdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:33:31 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD444262A;
        Tue,  6 Dec 2022 03:33:30 -0800 (PST)
Received: from [192.168.0.43] (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 52939480;
        Tue,  6 Dec 2022 12:33:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670326408;
        bh=OOw3jvyZAlreG+NVNZfb0NQYrAQH9l/8Rruf4vw/Kh8=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=sC35kEOwrDQPBQ9aTnDCBwFIS/7EinsgJ8CGQR9rwB0iTZerxMyf1R5YlXhYdeuHb
         e+WvNz7ROw5v/KzHcNrzDNSgJAVw4AosVPKmha44B1qOasG7teuIwLnJTFt73cDAtr
         0GZCzP12UEGuCptrZq62nZLCeq8PtZTG6XnOq/c0=
Message-ID: <9ffc4812-ab45-d7f9-7d93-fcacf629a754@ideasonboard.com>
Date:   Tue, 6 Dec 2022 11:33:25 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Content-Language: en-US
To:     Szymon Heidrich <szymon.heidrich@gmail.com>,
        laurent.pinchart@ideasonboard.com
Cc:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y4jqVZfEj+/VdfnH@kroah.com>
 <20221201191134.12404-1-szymon.heidrich@gmail.com>
From:   Dan Scally <dan.scally@ideasonboard.com>
Subject: Re: [PATCH v2] usb: gadget: uvc: Prevent buffer overflow in setup
 handler
In-Reply-To: <20221201191134.12404-1-szymon.heidrich@gmail.com>
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

Hi Szymon

On 01/12/2022 19:11, Szymon Heidrich wrote:
> Setup function uvc_function_setuppermits control transfer
> requests with up to 64 bytes of payload (UVC_MAX_REQUEST_SIZE),
> data stage handler for OUT transfer uses memcpy to copy req->actual
> bytes to uvc_event->data.data array of size 60. This may result
> in an overflow of 4 bytes.
>
> Signed-off-by: Szymon Heidrich <szymon.heidrich@gmail.com>


Reviewed-by: Daniel Scally <dan.scally@ideasonboard.com>


This probably needs to be tagged with:


Fixes: cdda479f15cd ("USB gadget: video class function driver")

> ---
> V1 -> V2: Corrected commit message and changed ?: in favor of min_t
>
>   drivers/usb/gadget/function/f_uvc.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/usb/gadget/function/f_uvc.c b/drivers/usb/gadget/function/f_uvc.c
> index 6e196e061..4419b7972 100644
> --- a/drivers/usb/gadget/function/f_uvc.c
> +++ b/drivers/usb/gadget/function/f_uvc.c
> @@ -216,8 +216,9 @@ uvc_function_ep0_complete(struct usb_ep *ep, struct usb_request *req)
>   
>   		memset(&v4l2_event, 0, sizeof(v4l2_event));
>   		v4l2_event.type = UVC_EVENT_DATA;
> -		uvc_event->data.length = req->actual;
> -		memcpy(&uvc_event->data.data, req->buf, req->actual);
> +		uvc_event->data.length = min_t(unsigned int, req->actual,
> +			sizeof(uvc_event->data.data));
> +		memcpy(&uvc_event->data.data, req->buf, uvc_event->data.length);
>   		v4l2_event_queue(&uvc->vdev, &v4l2_event);
>   	}
>   }
