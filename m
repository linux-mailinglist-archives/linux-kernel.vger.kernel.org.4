Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13CB85B9911
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 12:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230030AbiIOKrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 06:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbiIOKrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 06:47:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44ED46BD68
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 03:47:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D4F61B81F9A
        for <linux-kernel@vger.kernel.org>; Thu, 15 Sep 2022 10:47:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21E8AC433D6;
        Thu, 15 Sep 2022 10:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663238858;
        bh=yItK4LRfpsWyejA+YwYzurqI06YhwZBLtq9+clMCb4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MBjp442pIA8cgzYsOp9i3Vhq1mcK52PpFzOyG6L8hbRnwZWJPbteZknwvHk/j95dQ
         1gSuz1Dj8HQ+ov3LaUhfwIeI2ZCzL4Yt7Ya/VwtdPUKpAq6vaLBREc45trpe35I4No
         5IkV6SmvKKyX885hwqnk7UnORGK/eODQ+QOhfux4=
Date:   Thu, 15 Sep 2022 12:48:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Olof Johansson <olof@lixom.net>
Cc:     Saravana Kannan <saravanak@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [GIT PULL] Driver core changes for 6.0-rc1
Message-ID: <YyMC5Fip2qCtil6D@kroah.com>
References: <YuqDMLF2AQyj4+N1@kroah.com>
 <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
 <CAOesGMgKM9gU9qNEiLb==pE_u-W7HTGd0s75CL38u6Eve2Uchg@mail.gmail.com>
 <YyCequVJnV3p0Cpw@kroah.com>
 <CAOesGMjQHhTUMBGHQcME4JBkZCof2NEQ4gaM1GWFgH40+LN9AQ@mail.gmail.com>
 <YyHehZ5hT8mXKoTX@kroah.com>
 <CAOesGMid4_pDeUQFwhfSwrBRGhGocA-73V83h5qOsmYg7gAWTA@mail.gmail.com>
 <CAGETcx9Ha+akkuqzanGH9vrCnFQT_zTmezAHwtMhpxsQa=mwjg@mail.gmail.com>
 <CAOesGMgpJQjMvo6m7on+27F8REiHaVSRL6HBjiRPVDM9Jscnrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMgpJQjMvo6m7on+27F8REiHaVSRL6HBjiRPVDM9Jscnrg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 08:56:04PM -0700, Olof Johansson wrote:
> On Wed, Sep 14, 2022 at 10:36 AM Saravana Kannan <saravanak@google.com> wrote:
> >
> > On Wed, Sep 14, 2022 at 9:24 AM Olof Johansson <olof@lixom.net> wrote:
> > >
> > > Hi,
> > >
> > > On Wed, Sep 14, 2022 at 7:00 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Sep 13, 2022 at 09:28:27AM -0700, Olof Johansson wrote:
> > > > > On Tue, Sep 13, 2022 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Mon, Sep 12, 2022 at 10:24:43AM -0700, Olof Johansson wrote:
> > > > > > > On Mon, Sep 12, 2022 at 10:23 AM Olof Johansson <olof@lixom.net> wrote:
> > > > > > > >
> > > > > > > > Hi,
> > > > > > > >
> > > > > > > > On Wed, Aug 3, 2022 at 7:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > > > > >
> > > > > > > > > Saravana Kannan (11):
> > > > > > > > >       PM: domains: Delete usage of driver_deferred_probe_check_state()
> > > > > > > > >       pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> > > > > > > > >       net: mdio: Delete usage of driver_deferred_probe_check_state()
> > > > > > > > >       driver core: Add wait_for_init_devices_probe helper function
> > > > > > > > >       net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
> > > > > > > > >       Revert "driver core: Set default deferred_probe_timeout back to 0."
> > > > > > > > >       driver core: Set fw_devlink.strict=1 by default
> > > > > > > > >       iommu/of: Delete usage of driver_deferred_probe_check_state()
> > > > > > > > >       driver core: Delete driver_deferred_probe_check_state()
> > > > > > > > >       driver core: fw_devlink: Allow firmware to mark devices as best effort
> > > > > > > > >       of: base: Avoid console probe delay when fw_devlink.strict=1
> > > > > > > >
> > > > > > > > The last patch in this list regresses my HoneyComb LX2K (ironically
> > > > > > > > the machine I do maintainer work on). It stops PCIe from probing, but
> > > > > > > > without a single message indicating why.
> > > > > > > >
> > > > > > > > The reason seems to be that the iommu-maps property doesn't get
> > > > > > > > patched up by my (older) u-boot, and thus isn't a valid reference.
> > > > > > > > System works fine without IOMMU, which is how I've ran it for a couple
> > > > > > > > of years.
> > > > > > > >
> > > > > > > > It's also extremely hard to diagnose out of the box because there are
> > > > > > > > *no error messages*. And there were no warnings leading up to this
> > > > > > > > strict enforcement.
> > > > > > > >
> > > > > > > > This "feature" seems to have been done backwards. The checks should
> > > > > > > > have been running (and not skipped due to the "optional" flag), but
> > > > > > > > also not causing errors, just warnings. That would have given users a
> > > > > > > > chance to know that this is something that needs to be fixed.
> > > > > > > >
> > > > > > > > And when you flip the switch, at least report what failed so that
> > > > > > > > people don't need to spend a whole night bisecting kernels, please.
> > > > > > > >
> > > > > > > > Greg, mind reverting just the last one? If I hit this, I presume
> > > > > > > > others would too.
> > > > > > >
> > > > > > > Apologies, wrong patch pointed out. The culprit is "driver core: Set
> > > > > > > fw_devlink.strict=1 by default", 71066545b48e42.
> > > > > >
> > > > > > Is this still an issue in -rc5?  A number of patches in the above series
> > > > > > was just reverted and hopefully should have resolved the issue you are
> > > > > > seeing.
> > > > >
> > > > > Unfortunately, I discovered this regression with -rc5 in the first
> > > > > place, so it's still there.
> > > >
> > > > Ick, ok, Saravana, any thoughts?  I know you're at the conference this
> > > > week with me, maybe you can give Olof a hint as to what to look for
> > > > here?
> > >
> > > I'm not sure what you want me to look for. The patch turns on
> > > enforcement of DT contents that never used to be enforced, so now my
> > > computer no longer boots. And it does it in a way that makes it
> > > impossible for someone not rebuilding kernels to debug to figure out
> > > what happened.
> >
> > Hi Olof,
> >
> > Sorry for the trouble. It doesn't print any error messages because
> > there are cases where it's block the probe where it wouldn't be an
> > error. If I printed it every time fw_devlink blocked a probe, it'd be
> > a ton of messages.
> >
> > Btw, when I enabled fw_devlink.strict=1, it was AFTER making changes
> > that'll stop indefinitely blocking probes. So what you are seeing
> > shouldn't be happening. After about 10 seconds (configurable), it
> > should stop blocking the probes.
> 
> "Shouldn't be happening" is a pretty bold statement. It's not actually
> stuck on timeout in my case, and doesn't recover.
> 
> Instead, what seems to be happening is that the PCIe driver, which
> registers as a platform_driver here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c#n255
> 
> ends up registering, and the driver core now refuses to try to probe
> the device matches, since they no longer have their suppliers
> fulfilled (the smmu suppliers would not be tracked since they are
> optional here:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/of/property.c#n1449
> 
> So what happens is that the driver registration succeeds, but there
> have been no devices matched to it. So when it returns to the platform
> core, it thinks there are no devices bound to this driver, so it
> should be unregistered:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/platform.c#n951
> 
> That explains why the pcie core doesn't retry and just disappears, and
> stops retrying.
> 
> This is what it looks like with CONFIG_DEBUG_DRIVER and CONFIG_DEBUG_DEVRES:
> [    5.178538] bus: 'platform': add driver layerscape-pcie-gen4
> [    5.184301] bus: 'platform': __driver_probe_device: matched device
> 3600000.pcie with driver layerscape-pcie-gen4
> [    5.194498] platform 3600000.pcie: error -EPROBE_DEFER: supplier
> 5000000.iommu not ready
> [    5.202607] platform 3600000.pcie: Added to deferred list
> [    5.208024] bus: 'platform': __driver_probe_device: matched device
> 3800000.pcie with driver layerscape-pcie-gen4
> [    5.218227] platform 3800000.pcie: error -EPROBE_DEFER: supplier
> 5000000.iommu not ready
> [    5.226333] platform 3800000.pcie: Added to deferred list
> [    5.231814] bus: 'platform': remove driver layerscape-pcie-gen4
> [    5.237761] driver: 'layerscape-pcie-gen4': driver_release
> 
> Note that the platform driver registration sets flags to disable async
> probing, supposedly so it can assume that any matching devices would
> be found by the time registration returns:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/platform.c#n917
> :
> 
> /*
> * We have to run our probes synchronously because we check if
> * we find any devices to bind to and exit with error if there
> * are any.
> */
> drv->driver.probe_type = PROBE_FORCE_SYNCHRONOUS;
> 
> /*
> * Prevent driver from requesting probe deferral to avoid further
> * futile probe attempts.
> */
> drv->prevent_deferred_probe = true;
> 
> 
> 
> 
> Bottom line: How was this code tested? This seems far from mature,
> this doesn't seem like that of an obscure condition to occur and it
> could create minefields for others down the road if it's fragile.

I've reverted it for now, let's get this worked out for later releases.

thanks,

greg k-h
