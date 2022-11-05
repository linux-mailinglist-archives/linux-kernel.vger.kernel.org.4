Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A716661DC91
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 18:38:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiKERim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiKERil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 13:38:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81701C914;
        Sat,  5 Nov 2022 10:38:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 50A4360B31;
        Sat,  5 Nov 2022 17:38:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D554C433C1;
        Sat,  5 Nov 2022 17:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667669918;
        bh=Z7I+GuKl3dh2ub+VRNcy2mNWPcynPt2H6oRWtPE+IOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N5mAQpIQ6X7AELP/gFmcbw3avM3HrDF+DQilqmf4/x3YR6Fhact3vuUo04NPzDtv8
         NMJX89R6MyAbq4k4fTjXWCH2nFrsWyPiaTniMb0FO/J8C4xk4jMb4rihvbA5RQW5wv
         52ePz6Pl1zNc0BjRomdtFhIpXdu97VfwaYqnaQ80=
Date:   Sat, 5 Nov 2022 18:38:35 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, Marc Kleine-Budde <mkl@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH v2 3/3] can: etas_es58x: report the firmware version
 through ethtool
Message-ID: <Y2afm9xFIvJnwXh/@kroah.com>
References: <20221104073659.414147-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-1-mailhol.vincent@wanadoo.fr>
 <20221104171604.24052-4-mailhol.vincent@wanadoo.fr>
 <Y2Ydf6UxVvTe8Zmz@kroah.com>
 <CAMZ6RqJkzag-PGuzHcDQkSXjqH6d8=uAe-UN8VXUoNWX2x+qbw@mail.gmail.com>
 <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZ6RqLMGfW0QcNdBKhfwayV=+FNHhvM_-ob0UvL=o6=zN0J7A@mail.gmail.com>
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 06, 2022 at 02:21:11AM +0900, Vincent MAILHOL wrote:
> On Sat. 5 Nov. 2022 at 18:27, Vincent MAILHOL
> <mailhol.vincent@wanadoo.fr> wrote:
> > On Sat. 5 Nov. 2022 at 17:36, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > On Sat, Nov 05, 2022 at 02:16:04AM +0900, Vincent Mailhol wrote:
> > > > ES58x devices report below information in their usb product info
> > > > string:
> > > >
> > > >   * the firmware version
> > > >   * the bootloader version
> > > >   * the hardware revision
> > > >
> > > > Report the firmware version through ethtool_drvinfo::fw_version.
> > > > Because struct ethtool_drvinfo has no fields to report the boatloader
> > > > version nor the hardware revision, continue to print these in the
> > > > kernel log (c.f. es58x_get_product_info()).
> > > >
> > > > While doing so, bump up copyright year of each modified files.
> > >
> > > Why not just stick to the normal USB interface here and not try to tie
> > > it into ethtool?  These values are all availble today in sysfs or in
> > > libusb, right?
> >
> > The simple answer is ignorance. I am more familiar with ethtool than
> > libusb and I just did not think to explore that second option.
> > Thanks for the review, comments taken. I will study sysfs and libusb
> > and will rework that.
> 
> I double checked following options:
>   * CONFIG_USB_ANNOUNCE_NEW_DEVICES
>   * lsusb -v from usbutils
>   * sysfs
> 
> None of those will return the firmware version. The only strings I am
> getting are: the Product name, the Manufacturer and the SerialNumber.

Those are the default strings that a device can have, so it's good that
the core tries to get them.

Anything other than those are "custom" strings and you can use libusb
for that.  For some reason I thought sysfs also had custom strings, but
as they are so rare I don't know if anyone has tried that.

> I guess you were expecting some default behavior from the device, but
> unfortunately, this is not the case.
> On this device, the firmware version is stored at some arbitrary
> descriptor index (if you ask me: 6). Unless you query that magic
> number, the information will not pot up.
> 
> So as far as I can see, this does not duplicate existing mechanisms.
> With this patch, the firmware version becomes available using:
>   $ ethtool -i canX

It's late right now, and I can't remember the whole USB spec, but I
think the device provides a list of the string ids that are valid for
it.  If so, we can add that to sysfs for any USB device out there, no
matter the string descriptor number.

If not, maybe we can just iterate the 255 values and populate sysfs
files if they are present?  I'll dig up the USB spec tomorrow...

I say do this at the USB core level, that way it works for any USB
device, and you don't have a device-specific sysfs file and custom
userspace code just for this.

Sound reasonable?

greg k-h
