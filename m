Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 453CC69EE92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 07:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjBVGEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 01:04:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjBVGES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 01:04:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F332D14C;
        Tue, 21 Feb 2023 22:04:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 71133611EB;
        Wed, 22 Feb 2023 06:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F3E2C433EF;
        Wed, 22 Feb 2023 06:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677045856;
        bh=jYhyaaC4lTSy2X//RhSknOEokjEjxJIx+yfRYAlcw2o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wgE8pfG52DggsN8wnMb1VPzY/jDscIPTmIDXGT2x93ygd5c5yXqUXj580yiysbius
         tQ97lpBpQdJWdKpl9VS/gGReRW8d99X/gkXs639U9nDLlNmw3l6c6XrKejkWqQsofZ
         jO17PV+m5U9ghRRG3Gqcj3+Rf0KJ3UMf/gJHRlgk=
Date:   Wed, 22 Feb 2023 07:04:12 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Message-ID: <Y/WwXBF37hoZBbQa@kroah.com>
References: <20230222013944.31095-1-michael@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230222013944.31095-1-michael@allwinnertech.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 22, 2023 at 09:39:44AM +0800, Michael Wu wrote:
> This patch fixes a problem that USB mouse can't wake up the device that
> enters standby.

This not a problem, it is that way by design.

> At present, the kernel only checks whether certain USB manufacturers
> support wake-up, which will easily cause inconvenience to the
> development work of other manufacturers and add unnecessary work to the
> maintenance of kernel.
> 
> The USB protocol supports judging whether a usb supports the wake-up
> function, so it should be more reasonable to add a wake-up source by
> directly checking the settings from the USB protocol.

But you do not do that in this patch, why not?

> There was a similar issue on the keyboard before, which was fixed by
> this patch (3d61510f4eca), but now the problem happened on the mouse.
> This patch uses a similar idea to fix this problem.
> 
> Signed-off-by: Michael Wu <michael@allwinnertech.com>
> ---
>  drivers/hid/usbhid/hid-core.c | 8 ++++++++
>  drivers/hid/usbhid/usbmouse.c | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index be4c731aaa65..d3a6755cca09 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -1189,6 +1189,14 @@ static int usbhid_start(struct hid_device *hid)
>  		device_set_wakeup_enable(&dev->dev, 1);
>  	}
>  
> +	/**
> +	 * NOTE: enable remote wakeup by default for all mouse devices
> +	 * supporting the boot protocol.
> +	 */
> +	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
> +	    interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
> +		device_set_wakeup_enable(&dev->dev, 1);

Sorry, but we can not take this unless it is proven that this will work
properly for all of these devices.  Other operating systems do not do
this last I checked, so there will be problems.

thanks,

greg k-h
