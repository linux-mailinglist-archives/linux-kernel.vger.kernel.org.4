Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE4564C93C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Dec 2022 13:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238212AbiLNMro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Dec 2022 07:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238172AbiLNMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Dec 2022 07:47:13 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AAB2EA;
        Wed, 14 Dec 2022 04:45:35 -0800 (PST)
Received: from pendragon.ideasonboard.com (213-243-189-158.bb.dnainternet.fi [213.243.189.158])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8315349C;
        Wed, 14 Dec 2022 13:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1671021933;
        bh=MT4oVhoeYKfi75Mw9bGeCsVC1/s8Z0XaW8o0uPZAxj0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J4VJTbrqMS15H56JNeOOwuqwDiVGZslc865bqqmAojXy05f8IKLLSSp3WfFBcZdCS
         KQu+TdLBhCeGXNPXHfdaV9WWGZyFjZp1Tx5f4+TNpQ+WKWfQSPxy9T0hUP2iNKVhAw
         WdA7/eWrCN0cKpv37UwlN6KhEGyu/9tVTCY9n4/g=
Date:   Wed, 14 Dec 2022 14:45:30 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Yunke Cao <yunkec@chromium.org>, Max Staudt <mstaudt@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: uvcvideo: Do not alloc dev->status
Message-ID: <Y5nFap/r4OgqgmeK@pendragon.ideasonboard.com>
References: <20221214-uvc-status-alloc-v1-0-a0098ddc7c93@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221214-uvc-status-alloc-v1-0-a0098ddc7c93@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ricardo,

Thank you for the patch.

On Wed, Dec 14, 2022 at 12:23:41PM +0100, Ricardo Ribalda wrote:
> UVC_MAX_STATUS_SIZE is 16, simplify the code by inlining dev->status.

The reason why uvc_status is allocated dynamically is to ensure cache
line alignment, as the USB host controller may DMA to the buffer.

> Now that we are at it, remove all the castings.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
> To: Yunke Cao <yunkec@chromium.org>
> To: Sergey Senozhatsky <senozhatsky@chromium.org>
> To: Max Staudt <mstaudt@google.com>
> To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> To: Mauro Carvalho Chehab <mchehab@kernel.org>
> Cc: linux-media@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  drivers/media/usb/uvc/uvc_status.c | 69 ++++++++++++--------------------------
>  drivers/media/usb/uvc/uvcvideo.h   | 22 +++++++++++-
>  2 files changed, 42 insertions(+), 49 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_status.c b/drivers/media/usb/uvc/uvc_status.c
> index 7518ffce22ed..adf63e7616c9 100644
> --- a/drivers/media/usb/uvc/uvc_status.c
> +++ b/drivers/media/usb/uvc/uvc_status.c
> @@ -73,38 +73,24 @@ static void uvc_input_report_key(struct uvc_device *dev, unsigned int code,
>  /* --------------------------------------------------------------------------
>   * Status interrupt endpoint
>   */
> -struct uvc_streaming_status {
> -	u8	bStatusType;
> -	u8	bOriginator;
> -	u8	bEvent;
> -	u8	bValue[];
> -} __packed;
> -
> -struct uvc_control_status {
> -	u8	bStatusType;
> -	u8	bOriginator;
> -	u8	bEvent;
> -	u8	bSelector;
> -	u8	bAttribute;
> -	u8	bValue[];
> -} __packed;
> -
>  static void uvc_event_streaming(struct uvc_device *dev,
> -				struct uvc_streaming_status *status, int len)
> +				struct uvc_status *status, int len)
>  {
> -	if (len < 3) {
> +	if (len <= offsetof(struct uvc_status, bEvent)) {
>  		uvc_dbg(dev, STATUS,
>  			"Invalid streaming status event received\n");
>  		return;
>  	}
>  
>  	if (status->bEvent == 0) {
> -		if (len < 4)
> +		if (len <= offsetof(struct uvc_status, streaming))
>  			return;
> +
>  		uvc_dbg(dev, STATUS, "Button (intf %u) %s len %d\n",
>  			status->bOriginator,
> -			status->bValue[0] ? "pressed" : "released", len);
> -		uvc_input_report_key(dev, KEY_CAMERA, status->bValue[0]);
> +			status->streaming.button ? "pressed" : "released", len);
> +		uvc_input_report_key(dev, KEY_CAMERA,
> +				     status->streaming.button);
>  	} else {
>  		uvc_dbg(dev, STATUS, "Stream %u error event %02x len %d\n",
>  			status->bOriginator, status->bEvent, len);
> @@ -131,7 +117,7 @@ static struct uvc_control *uvc_event_entity_find_ctrl(struct uvc_entity *entity,
>  }
>  
>  static struct uvc_control *uvc_event_find_ctrl(struct uvc_device *dev,
> -					const struct uvc_control_status *status,
> +					const struct uvc_status *status,
>  					struct uvc_video_chain **chain)
>  {
>  	list_for_each_entry((*chain), &dev->chains, list) {
> @@ -143,7 +129,7 @@ static struct uvc_control *uvc_event_find_ctrl(struct uvc_device *dev,
>  				continue;
>  
>  			ctrl = uvc_event_entity_find_ctrl(entity,
> -							  status->bSelector);
> +						     status->control.bSelector);
>  			if (ctrl)
>  				return ctrl;
>  		}
> @@ -153,7 +139,7 @@ static struct uvc_control *uvc_event_find_ctrl(struct uvc_device *dev,
>  }
>  
>  static bool uvc_event_control(struct urb *urb,
> -			      const struct uvc_control_status *status, int len)
> +			      const struct uvc_status *status, int len)
>  {
>  	static const char *attrs[] = { "value", "info", "failure", "min", "max" };
>  	struct uvc_device *dev = urb->context;
> @@ -161,24 +147,24 @@ static bool uvc_event_control(struct urb *urb,
>  	struct uvc_control *ctrl;
>  
>  	if (len < 6 || status->bEvent != 0 ||
> -	    status->bAttribute >= ARRAY_SIZE(attrs)) {
> +	    status->control.bAttribute >= ARRAY_SIZE(attrs)) {
>  		uvc_dbg(dev, STATUS, "Invalid control status event received\n");
>  		return false;
>  	}
>  
>  	uvc_dbg(dev, STATUS, "Control %u/%u %s change len %d\n",
> -		status->bOriginator, status->bSelector,
> -		attrs[status->bAttribute], len);
> +		status->bOriginator, status->control.bSelector,
> +		attrs[status->control.bAttribute], len);
>  
>  	/* Find the control. */
>  	ctrl = uvc_event_find_ctrl(dev, status, &chain);
>  	if (!ctrl)
>  		return false;
>  
> -	switch (status->bAttribute) {
> +	switch (status->control.bAttribute) {
>  	case UVC_CTRL_VALUE_CHANGE:
>  		return uvc_ctrl_status_event_async(urb, chain, ctrl,
> -						   status->bValue);
> +						   status->control.bValue);
>  
>  	case UVC_CTRL_INFO_CHANGE:
>  	case UVC_CTRL_FAILURE_CHANGE:
> @@ -214,28 +200,22 @@ static void uvc_status_complete(struct urb *urb)
>  
>  	len = urb->actual_length;
>  	if (len > 0) {
> -		switch (dev->status[0] & 0x0f) {
> +		switch (dev->status.bStatusType & 0x0f) {
>  		case UVC_STATUS_TYPE_CONTROL: {
> -			struct uvc_control_status *status =
> -				(struct uvc_control_status *)dev->status;
> -
> -			if (uvc_event_control(urb, status, len))
> +			if (uvc_event_control(urb, &dev->status, len))
>  				/* The URB will be resubmitted in work context. */
>  				return;
>  			break;
>  		}
>  
>  		case UVC_STATUS_TYPE_STREAMING: {
> -			struct uvc_streaming_status *status =
> -				(struct uvc_streaming_status *)dev->status;
> -
> -			uvc_event_streaming(dev, status, len);
> +			uvc_event_streaming(dev, &dev->status, len);
>  			break;
>  		}
>  
>  		default:
>  			uvc_dbg(dev, STATUS, "Unknown status event type %u\n",
> -				dev->status[0]);
> +				dev->status.bStatusType);
>  			break;
>  		}
>  	}
> @@ -259,15 +239,9 @@ int uvc_status_init(struct uvc_device *dev)
>  
>  	uvc_input_init(dev);
>  
> -	dev->status = kzalloc(UVC_MAX_STATUS_SIZE, GFP_KERNEL);
> -	if (dev->status == NULL)
> -		return -ENOMEM;
> -
>  	dev->int_urb = usb_alloc_urb(0, GFP_KERNEL);
> -	if (dev->int_urb == NULL) {
> -		kfree(dev->status);
> +	if (!dev->int_urb)
>  		return -ENOMEM;
> -	}
>  
>  	pipe = usb_rcvintpipe(dev->udev, ep->desc.bEndpointAddress);
>  
> @@ -281,7 +255,7 @@ int uvc_status_init(struct uvc_device *dev)
>  		interval = fls(interval) - 1;
>  
>  	usb_fill_int_urb(dev->int_urb, dev->udev, pipe,
> -		dev->status, UVC_MAX_STATUS_SIZE, uvc_status_complete,
> +		&dev->status, sizeof(dev->status), uvc_status_complete,
>  		dev, interval);
>  
>  	return 0;
> @@ -296,7 +270,6 @@ void uvc_status_unregister(struct uvc_device *dev)
>  void uvc_status_cleanup(struct uvc_device *dev)
>  {
>  	usb_free_urb(dev->int_urb);
> -	kfree(dev->status);
>  }
>  
>  int uvc_status_start(struct uvc_device *dev, gfp_t flags)
> diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> index df93db259312..cdd2e328acc2 100644
> --- a/drivers/media/usb/uvc/uvcvideo.h
> +++ b/drivers/media/usb/uvc/uvcvideo.h
> @@ -527,6 +527,26 @@ struct uvc_device_info {
>  	const struct uvc_control_mapping **mappings;
>  };
>  
> +struct uvc_status_streaming {
> +	u8	button;
> +} __packed;
> +
> +struct uvc_status_control {
> +	u8	bSelector;
> +	u8	bAttribute;
> +	u8	bValue[11];
> +} __packed;
> +
> +struct uvc_status {
> +	u8	bStatusType;
> +	u8	bOriginator;
> +	u8	bEvent;
> +	union {
> +		struct uvc_status_control control;
> +		struct uvc_status_streaming streaming;
> +	};
> +} __packed;
> +
>  struct uvc_device {
>  	struct usb_device *udev;
>  	struct usb_interface *intf;
> @@ -559,7 +579,7 @@ struct uvc_device {
>  	/* Status Interrupt Endpoint */
>  	struct usb_host_endpoint *int_ep;
>  	struct urb *int_urb;
> -	u8 *status;
> +	struct uvc_status status;
>  	struct input_dev *input;
>  	char input_phys[64];
>  
> 
> ---
> base-commit: 0ec5a38bf8499f403f81cb81a0e3a60887d1993c
> change-id: 20221214-uvc-status-alloc-93becb783898

-- 
Regards,

Laurent Pinchart
