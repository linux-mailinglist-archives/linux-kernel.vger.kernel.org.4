Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754146218A8
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 16:43:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233920AbiKHPnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 10:43:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233472AbiKHPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 10:43:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A76F0A;
        Tue,  8 Nov 2022 07:43:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F32A4CE1B78;
        Tue,  8 Nov 2022 15:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B606EC433C1;
        Tue,  8 Nov 2022 15:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667922226;
        bh=Nw+U58XmhceIB7jzCZHqVjztahNIyAoUjYrmbLVFswk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjTjmRE2cag7LiHDhndJ/UtlEdZTY9jzj9/E2C8GlIu8QNpluwTafpDb05ZrRNMt5
         4UP/zDYDQu8u+3nrKtj3I2IKBpALhoXqIBBvf6REivwBA0R1E2TxNGENqDyeym5AHx
         lkS6Ea6/xK5OyJub6NwqVgXVrtn7iznIEhO3Nhm8=
Date:   Tue, 8 Nov 2022 16:43:42 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc:     Janne Grunau <j@jannau.net>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Sven Peter <sven@svenpeter.de>,
        "stable@kernel.org" <stable@kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] usb: dwc3: Do not get extcon device when
 usb-role-switch is used
Message-ID: <Y2p5LqRrSfwtLRif@kroah.com>
References: <20221106214804.2814-1-j@jannau.net>
 <20221108020208.y3hrbpaxmzke2lms@synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108020208.y3hrbpaxmzke2lms@synopsys.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 08, 2022 at 02:02:19AM +0000, Thinh Nguyen wrote:
> Hi,
> 
> On Sun, Nov 06, 2022, Janne Grunau wrote:
> > The change breaks device tree based platforms with PHY device and use
> > usb-role-switch instead of an extcon switch. extcon_find_edev_by_node()
> > will return EPROBE_DEFER if it can not find a device so probing without
> > an extcon device will be deferred indefinitely. Fix this by
> > explicitly checking for usb-role-switch.
> > At least the out-of-tree USB3 support on Apple silicon based platforms
> > using dwc3 with tipd USB Type-C and PD controller is affected by this
> > issue.
> > 
> > Fixes: d182c2e1bc92 ("usb: dwc3: Don't switch OTG -> peripheral if extcon is present")
> > Cc: stable@kernel.org
> > Signed-off-by: Janne Grunau <j@jannau.net>
> > ---
> >  drivers/usb/dwc3/core.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
> > index c0e7c76dc5c8..1f348bc867c2 100644
> > --- a/drivers/usb/dwc3/core.c
> > +++ b/drivers/usb/dwc3/core.c
> > @@ -1710,6 +1710,16 @@ static struct extcon_dev *dwc3_get_extcon(struct dwc3 *dwc)
> >  	if (device_property_read_string(dev, "linux,extcon-name", &name) == 0)
> >  		return extcon_get_extcon_dev(name);
> >  
> > +	/*
> > +	 * Check explicitly if "usb-role-switch" is used since
> > +	 * extcon_find_edev_by_node() can not be used to check the absence of
> 
> can not -> can't or cannot

"can not" is fine.

> 
> > +	 * an extcon device. In the absence of an device it will always return
> 
> "a" device,

Not an issue.

> > +	 * EPROBE_DEFER.
> > +	 */
> > +	if (IS_ENABLED(CONFIG_USB_ROLE_SWITCH) &&
> > +	    device_property_read_bool(dev, "usb-role-switch"))
> > +		return NULL;
> > +
> >  	/*
> >  	 * Try to get an extcon device from the USB PHY controller's "port"
> >  	 * node. Check if it has the "port" node first, to avoid printing the
> > -- 
> > 2.37.3
> > 
> 
> Looks like the "port" node check from c824c73a5e08 ("usb: dwc3: drd:
> Avoid error when extcon is missing") did not account for this platform
> setup.
> 
> This looks fine to me. Should we cleanup the incomplete check and stale
> comment right after this too (as a separate patch)?

Is this a Reviewed-by: ?

thanks,

greg k-h
