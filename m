Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD66A0744
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 12:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233358AbjBWLXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 06:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233689AbjBWLX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 06:23:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588E0E055;
        Thu, 23 Feb 2023 03:23:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EB9B616BF;
        Thu, 23 Feb 2023 11:23:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1159CC433EF;
        Thu, 23 Feb 2023 11:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677151406;
        bh=fyjS7/d2Yt5dgqJ9gDBnQzQPvwzmiL6diyXW7SUnGf8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kO96RzC9xGtt+BXLdB3SAnI04FIWmSyVHFaPwtuQului0ygsbf2l4AbugT72g/x+k
         7UNW93wsUDVjPEm7PUFQqpxTvmLfZ1RT6k/Vn46N+MChp6n2xB5HSmw59W387n6RA1
         6PtjPODs//3hWzli70lCOoGgiNWiGYf2/qeFObbQ=
Date:   Thu, 23 Feb 2023 12:23:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Wu <michael@allwinnertech.com>
Cc:     jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-usb@vger.kernel.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, mario.limonciello@amd.com,
        richard.gong@amd.com
Subject: Re: [PATCH] HID: usbhid: enable remote wakeup for mice
Message-ID: <Y/dMq2KKYfdMdrjh@kroah.com>
References: <20230222013944.31095-1-michael@allwinnertech.com>
 <Y/WwXBF37hoZBbQa@kroah.com>
 <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bf4463c-6541-a6cb-9bbc-6d070118509a@allwinnertech.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 23, 2023 at 07:18:12PM +0800, Michael Wu wrote:
> Dear Greg,
> 
> On 2/22/2023 2:04 PM, Greg KH wrote:
> > On Wed, Feb 22, 2023 at 09:39:44AM +0800, Michael Wu wrote:
> > > This patch fixes a problem that USB mouse can't wake up the device that
> > > enters standby.
> > 
> > This not a problem, it is that way by design.
> 
> I got it, maybe it's a little problem to say that.

It is.

> > > At present, the kernel only checks whether certain USB manufacturers
> > > support wake-up, which will easily cause inconvenience to the
> > > development work of other manufacturers and add unnecessary work to the
> > > maintenance of kernel.
> > > 
> > > The USB protocol supports judging whether a usb supports the wake-up
> > > function, so it should be more reasonable to add a wake-up source by
> > > directly checking the settings from the USB protocol.
> > 
> > But you do not do that in this patch, why not?
> 
> I just want to explain the background of my patch, to prove we could use a
> similar way to avoid such a "disturbing" situation.
> To reduce the influence, my patch enables remote wakeup for USB mouse
> devices refer to what keyboard do.

Keyboards are not mice :)

> > > There was a similar issue on the keyboard before, which was fixed by
> > > this patch (3d61510f4eca), but now the problem happened on the mouse.
> > > This patch uses a similar idea to fix this problem.
> > > 
> > > Signed-off-by: Michael Wu <michael@allwinnertech.com>
> > > ---
> > >   drivers/hid/usbhid/hid-core.c | 8 ++++++++
> > >   drivers/hid/usbhid/usbmouse.c | 1 +
> > >   2 files changed, 9 insertions(+)
> > > 
> > > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> > > index be4c731aaa65..d3a6755cca09 100644
> > > --- a/drivers/hid/usbhid/hid-core.c
> > > +++ b/drivers/hid/usbhid/hid-core.c
> > > @@ -1189,6 +1189,14 @@ static int usbhid_start(struct hid_device *hid)
> > >   		device_set_wakeup_enable(&dev->dev, 1);
> > >   	}
> > > +	/**
> > > +	 * NOTE: enable remote wakeup by default for all mouse devices
> > > +	 * supporting the boot protocol.
> > > +	 */
> > > +	if (interface->desc.bInterfaceSubClass == USB_INTERFACE_SUBCLASS_BOOT &&
> > > +	    interface->desc.bInterfaceProtocol == USB_INTERFACE_PROTOCOL_MOUSE)
> > > +		device_set_wakeup_enable(&dev->dev, 1);
> > 
> > Sorry, but we can not take this unless it is proven that this will work
> > properly for all of these devices.  Other operating systems do not do
> > this last I checked, so there will be problems.
> 
> As Mario Limonciello says, they has confirmed that the Microsoft Windows
> does set a similar policy as well. Can we talk about more in this topic: why
> does Linux not support it?
> Of course, if you have other great idea, I will appreciate that if we can
> have some further discussion.

You need to provide some sort of "proof" that this has been heavily
tested on a huge range of devices before we can change this.

When this was first implemented, Windows did not work this way and many
devices on the market were broken if this were to be enabled.  I'm sure
the mailing list archives from 20+ years ago have many more details,
please dig around there for specifics.

If you feel strongly that this is the way forward, why not do it in
userspace today for your systems as part of testing this out?  It should
not require a kernel change, right?

thanks,

greg k-h
