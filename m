Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59C955B89AD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 16:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiINOBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 10:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbiINOAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 10:00:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1E21792FD
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 07:00:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F13A961DB3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 14:00:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEAF0C433C1;
        Wed, 14 Sep 2022 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663164013;
        bh=qYbGgDOkCLxv6FtLLV2PwvqOXvHPgUhdwYIvPpAFNMw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eHlc/jP12AJdEOQz42vbJrc6gfIouH/FFi+vXxtPuQuJC1Rqz7IDq3hu0YzuX5Giz
         xuEeNpobKeQh+44ssH+QRGGi8ffWXrsVxMc7g0OV1aNzzOloNzFb9c/ZjJBgnDESpv
         rpJz6Tm4XG0MpA0XIwUlzfBYumBVYNOnAeoUmgbk=
Date:   Wed, 14 Sep 2022 16:00:37 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Saravana Kannan <saravanak@google.com>,
        Olof Johansson <olof@lixom.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Subject: Re: [GIT PULL] Driver core changes for 6.0-rc1
Message-ID: <YyHehZ5hT8mXKoTX@kroah.com>
References: <YuqDMLF2AQyj4+N1@kroah.com>
 <CAOesGMivEZmYb7Z8C1ic=r0oeNeXBh61LYu28B1g9d_qZVOjyA@mail.gmail.com>
 <CAOesGMgKM9gU9qNEiLb==pE_u-W7HTGd0s75CL38u6Eve2Uchg@mail.gmail.com>
 <YyCequVJnV3p0Cpw@kroah.com>
 <CAOesGMjQHhTUMBGHQcME4JBkZCof2NEQ4gaM1GWFgH40+LN9AQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOesGMjQHhTUMBGHQcME4JBkZCof2NEQ4gaM1GWFgH40+LN9AQ@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 09:28:27AM -0700, Olof Johansson wrote:
> On Tue, Sep 13, 2022 at 8:15 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> >
> > On Mon, Sep 12, 2022 at 10:24:43AM -0700, Olof Johansson wrote:
> > > On Mon, Sep 12, 2022 at 10:23 AM Olof Johansson <olof@lixom.net> wrote:
> > > >
> > > > Hi,
> > > >
> > > > On Wed, Aug 3, 2022 at 7:16 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > > Saravana Kannan (11):
> > > > >       PM: domains: Delete usage of driver_deferred_probe_check_state()
> > > > >       pinctrl: devicetree: Delete usage of driver_deferred_probe_check_state()
> > > > >       net: mdio: Delete usage of driver_deferred_probe_check_state()
> > > > >       driver core: Add wait_for_init_devices_probe helper function
> > > > >       net: ipconfig: Relax fw_devlink if we need to mount a network rootfs
> > > > >       Revert "driver core: Set default deferred_probe_timeout back to 0."
> > > > >       driver core: Set fw_devlink.strict=1 by default
> > > > >       iommu/of: Delete usage of driver_deferred_probe_check_state()
> > > > >       driver core: Delete driver_deferred_probe_check_state()
> > > > >       driver core: fw_devlink: Allow firmware to mark devices as best effort
> > > > >       of: base: Avoid console probe delay when fw_devlink.strict=1
> > > >
> > > > The last patch in this list regresses my HoneyComb LX2K (ironically
> > > > the machine I do maintainer work on). It stops PCIe from probing, but
> > > > without a single message indicating why.
> > > >
> > > > The reason seems to be that the iommu-maps property doesn't get
> > > > patched up by my (older) u-boot, and thus isn't a valid reference.
> > > > System works fine without IOMMU, which is how I've ran it for a couple
> > > > of years.
> > > >
> > > > It's also extremely hard to diagnose out of the box because there are
> > > > *no error messages*. And there were no warnings leading up to this
> > > > strict enforcement.
> > > >
> > > > This "feature" seems to have been done backwards. The checks should
> > > > have been running (and not skipped due to the "optional" flag), but
> > > > also not causing errors, just warnings. That would have given users a
> > > > chance to know that this is something that needs to be fixed.
> > > >
> > > > And when you flip the switch, at least report what failed so that
> > > > people don't need to spend a whole night bisecting kernels, please.
> > > >
> > > > Greg, mind reverting just the last one? If I hit this, I presume
> > > > others would too.
> > >
> > > Apologies, wrong patch pointed out. The culprit is "driver core: Set
> > > fw_devlink.strict=1 by default", 71066545b48e42.
> >
> > Is this still an issue in -rc5?  A number of patches in the above series
> > was just reverted and hopefully should have resolved the issue you are
> > seeing.
> 
> Unfortunately, I discovered this regression with -rc5 in the first
> place, so it's still there.

Ick, ok, Saravana, any thoughts?  I know you're at the conference this
week with me, maybe you can give Olof a hint as to what to look for
here?

thanks,

greg k-h
