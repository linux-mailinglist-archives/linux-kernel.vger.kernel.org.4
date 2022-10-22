Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E80608CD8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 13:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiJVLkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 07:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiJVLkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 07:40:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54890422E3;
        Sat, 22 Oct 2022 04:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5627960CBB;
        Sat, 22 Oct 2022 11:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3059EC433D6;
        Sat, 22 Oct 2022 11:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666438378;
        bh=1sICJHC0lJ2TpJ7b/Au1nHb08DMV/sOXgrux/tW2J0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UAvLXSGicJuQmibs/esBBZm5JSMxS9M1pjrOYL2WVieIKFenPaDoS99V5TCODB3a4
         wOpe/eVdF5nkwYdJKt1Nm2ZUtVT4352h5ngBgTE6uw/YIVxJoJYcX/fvlrXctXpk6p
         0VV8P3RyOfGPO53IKIHb/A8yuverttAcKr8B+b50=
Date:   Sat, 22 Oct 2022 13:32:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Vacura <w36195@motorola.com>
Cc:     linux-usb@vger.kernel.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jeff Vanhoof <qjv001@motorola.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Felipe Balbi <balbi@kernel.org>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 5/6] usb: gadget: uvc: make interrupt skip logic
 configurable
Message-ID: <Y1PU6K4Izr9n5tcs@kroah.com>
References: <20221018215044.765044-1-w36195@motorola.com>
 <20221018215044.765044-6-w36195@motorola.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018215044.765044-6-w36195@motorola.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 04:50:41PM -0500, Dan Vacura wrote:
> Some UDC hw may not support skipping interrupts, but still support the
> request. Allow the interrupt frequency to be configurable to the user.
> 
> Signed-off-by: Dan Vacura <w36195@motorola.com>
> ---
> V1 -> V2:
> - no change, new patch in series
> V2 -> V3:
> - default to baseline value of 4, fix storing the initial value
> V3 -> V4:
> - no change
> 
>  Documentation/ABI/testing/configfs-usb-gadget-uvc | 1 +
>  Documentation/usb/gadget-testing.rst              | 2 ++

Adding more tunable knobs always just adds complexity and fragility as
things do not get tested.

Can't we just make this dynamic and work properly on all systems?  What
UDC hardware types do not allow skipping interrupts?  Why can't we just
detect that and only do that if this is the case or not?

>  drivers/usb/gadget/function/f_uvc.c               | 3 +++
>  drivers/usb/gadget/function/u_uvc.h               | 1 +
>  drivers/usb/gadget/function/uvc.h                 | 2 ++
>  drivers/usb/gadget/function/uvc_configfs.c        | 2 ++
>  drivers/usb/gadget/function/uvc_queue.c           | 6 ++++++
>  drivers/usb/gadget/function/uvc_video.c           | 3 ++-
>  8 files changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> index 611b23e6488d..5dfaa3f7f6a4 100644
> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
> @@ -8,6 +8,7 @@ Description:	UVC function directory
>  		streaming_maxpacket	1..1023 (fs), 1..3072 (hs/ss)
>  		streaming_interval	1..16
>  		function_name		string [32]
> +		req_int_skip_div	unsigned int
>  		===================	=============================
>  
>  What:		/config/usb-gadget/gadget/functions/uvc.name/control
> diff --git a/Documentation/usb/gadget-testing.rst b/Documentation/usb/gadget-testing.rst
> index 2278c9ffb74a..f9b5a09be1f4 100644
> --- a/Documentation/usb/gadget-testing.rst
> +++ b/Documentation/usb/gadget-testing.rst
> @@ -794,6 +794,8 @@ The uvc function provides these attributes in its function directory:
>  			    sending or receiving when this configuration is
>  			    selected
>  	function_name       name of the interface
> +	req_int_skip_div    divisor of total requests to aid in calculating
> +			    interrupt frequency, 0 indicates all interrupt

This provides no information that would help to determine how to
configure this at all.  I wouldn't know what to do with this, so that's
a huge sign that this is not a good interface :(

thanks,

greg k-h
