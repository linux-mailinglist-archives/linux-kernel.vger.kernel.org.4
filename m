Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2695F1AA1
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Oct 2022 09:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbiJAHdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Oct 2022 03:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229571AbiJAHdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Oct 2022 03:33:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EB825291
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 00:33:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CF2D60B07
        for <linux-kernel@vger.kernel.org>; Sat,  1 Oct 2022 07:33:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18F85C433D6;
        Sat,  1 Oct 2022 07:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664609584;
        bh=ZWSAXWIc+fo9iToKEaqGYonGMxMMKfGxQOOCqApi5y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1TOby2CTh+qHGkZvhlqDPVeRg644mWXwqCQrHY3y2Rvm2ZpUnhHus64j1q9su95s3
         AYxv/6FUuHD1DQeePzOg9iLmdjekPlwKnwSiiY9vsbBDItByomOrfQmp7Rb4fAVzzv
         T3BezeS/iAUnbSFRxnp+03N+hkubOXU1GmsYSX1U=
Date:   Sat, 1 Oct 2022 09:33:41 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v11] firmware: google: Implement cbmem in sysfs driver
Message-ID: <YzftVZj+2RCcIDN7@kroah.com>
References: <20220929234432.3711480-1-jrosenth@chromium.org>
 <YzaNjlqc0GqmJt68@kroah.com>
 <YzdqUX/zPvtyCmNm@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzdqUX/zPvtyCmNm@chromium.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 30, 2022 at 04:14:41PM -0600, Jack Rosenthal wrote:
> On 2022-09-30 at 08:32 +0200, Greg KH wrote:
> > symlink?  Ick, no, do not do that at all please.
> > 
> > As these are device attributes, just stick with them.  Don't do a crazy
> > symlink into a non-device-attribute portion of the sysfs tree, by doing
> > that you break all userspace tools and stuff like libudev will never
> > even see these attributes.
> 
> I guess I can fill in some info here about the use case needed:
> userspace tools (in this case, a tool called "crossystem") needs to look
> up a CBMEM entry by ID and read it.  So, being able to find a fixed path
> like /sys/firmware/cbmem/<id>/mem is significantly easier than scanning
> all /sys/bus/coreboot/devices/coreboot*/id to find the right device
> first.

No, this is a device, make these device attributes, don't polute sysfs
with random symlinks from a device into the firmware location, that's
not ok.

And again, your current code means that tools like udev and libraries
will not see these attributes at all.  Stick with what every other
device in the kernel does please, consistancy is good.

> What exactly do we break here by adding symlinks?  udev won't look into
> /sys/firmware, right?

Exactly.  You want that to work.

> Or, is there another good alternative that we could use to find a CBMEM
> entry by its id without needing to scan thru all coreboot bus type
> devices?  Setting the device name to something more predictable (e.g.,
> "cbmem-<id>") would require the coreboot bus type to "look ahead" and
> notice it's a CBMEM entry before registering the device, which wouldn't
> exactly be all that clean.

All devices on a bus can call themselves whatever they want, of course
they should be naming themselves based on their device type, why
wouldn't they?

Or put an attribute of the type in the directory of the coreboot device
and iterate on that.  It's a simple udev rule for matching on an
attribute value on a bus.

> > > +What:		/sys/firmware/cbmem/
> > > +Date:		August 2022
> > > +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> > > +Description:
> > > +		Coreboot provides a variety of data structures in CBMEM.  This
> > > +		directory contains each CBMEM entry, which can be found via
> > > +		Coreboot tables.
> > 
> > What happened to the coreboot name?
> 
> I removed it as it seemed like from your last message you didn't want
> it?

I do not recall saying that, I was just confused that it had not been
used before.

Please do not use cbmem.

thanks,

greg k-h
