Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C7C6B22E2
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 12:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbjCIL06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 06:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjCIL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 06:26:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5454E41D5;
        Thu,  9 Mar 2023 03:24:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A3CE61A11;
        Thu,  9 Mar 2023 11:24:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5187CC433EF;
        Thu,  9 Mar 2023 11:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678361086;
        bh=UUP2mfok1s5L/13n4NmG5S7yZyWo6emhjFUNY3+1RNw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qEV5r5g53oJxkHo+D/YrprI6PNCb7ooqU6DQEaDcORDfd1dBfdYuiLU0tG9B8jxIs
         2FhjPpkqoZvaScRI8vn7Oh1PoS3oa+h9pYGjI7yhvp0YR3nqRbSgghgn666z4V76EK
         HdyeXcealG3qRVHDAG5vyOV+rz3ZYccVXGymiTA8=
Date:   Thu, 9 Mar 2023 12:24:44 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
Message-ID: <ZAnB/DozWsir1cIE@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com>
 <CANeycqoHwp3URSPGvnNZx+9PdbC90UVFWLwg4w=JBHQnjnGUPA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqoHwp3URSPGvnNZx+9PdbC90UVFWLwg4w=JBHQnjnGUPA@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 05, 2023 at 03:39:25AM -0300, Wedson Almeida Filho wrote:
> > > +    /// Returns the name of the device.
> > > +    fn name(&self) -> &CStr {
> > > +        let ptr = self.raw_device();
> > > +
> > > +        // SAFETY: `ptr` is valid because `self` keeps it alive.
> > > +        let name = unsafe { bindings::dev_name(ptr) };
> > > +
> > > +        // SAFETY: The name of the device remains valid while it is alive (because the device is
> > > +        // never renamed, per the safety requirement of this trait). This is guaranteed to be the
> > > +        // case because the reference to `self` outlives the one of the returned `CStr` (enforced
> > > +        // by the compiler because of their lifetimes).
> > > +        unsafe { CStr::from_char_ptr(name) }
> >
> > Why can the device never be renamed?  Devices are renamed all the time,
> > sometimes when you least expect it (i.e. by userspace).  So how is this
> > considered "safe"? and actually correct?
> >
> > Again, maybe seeing a real user of this might make more sense, but
> > as-is, this feels wrong and not needed at all.
> 
> This requirement is to allow callers to use the string without having
> to make a copy of it.
> 
> If subsystems/buses are not following what the C documentation says,
> as you point out in another thread, we have a several options: (a)
> remove access to names altogether, (b) leave things as they are, then
> those subsystems wouldn't be able to honour the safety requirements of
> this trait therefore they wouldn't implement it, (c) make a copy of
> the string, etc.

How about we fix the documentation in the .c code and also drop this as
you really don't need it now.

Want to send a patch for the driver core code fix?

> > > +        // owns a reference. This is satisfied by the call to `get_device` above.
> > > +        Self { ptr }
> > > +    }
> > > +
> > > +    /// Creates a new device instance from an existing [`RawDevice`] instance.
> > > +    pub fn from_dev(dev: &dyn RawDevice) -> Self {
> >
> > I am a rust newbie, but I don't understand this "RawDevice" here at all.
> 
> Different buses will have their own Rust "Device" type, for example,
> pci::Device, amba::Device, platform::Device that wrap their C
> counterparts pci_dev, amba_device, platform_device.
> 
> "RawDevice" is a trait for functionality that is common to all
> devices. It exposes the "struct device" of each bus/subsystem so that
> functions that work on any "struct device", for example, `clk_get`,
> `pr_info`. will automatically work on all subsystems.

Why is this being called "Raw" then?  Why not just "Device" to follow
along with the naming scheme that the kernel already uses?

> For example, as part writing Rust abstractions for a platform devices,
> we have a platform::Device type, which is wrapper around `struct
> platform_device`. It has a bunch of associated functions that do
> things that are specific to the platform bus. But then they also
> implement the `RawDevice` trait (by implementing `raw_device` that
> returns &pdev->dev), which allows drivers to call `clk_get` and the
> printing functions directly.
> 
> Let's say `pdev` is a platform device; if we wanted to call `clk_get`
> in C, we'd do something like:
> 
> clk = clk_get(&pdev->dev, NULL);
> 
> In Rust, we'd do:
> 
> clk = pdev.clk_get(None);
> 
> (Note that we didn't have to know that pdev had a field whose type is
> a `struct device` that we could use to call clk_get on; `RawDevice`
> encoded this information.)
> 
> Does the intent of the abstraction make sense to you now?

A bit more, yes.  But I want to see some real users before agreeing that
it is sane :)

thanks,

greg k-h
