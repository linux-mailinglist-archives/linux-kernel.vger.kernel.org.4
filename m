Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C636B2BC9
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjCIROV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:14:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjCIRNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:13:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D1562303;
        Thu,  9 Mar 2023 09:11:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6B541B8202D;
        Thu,  9 Mar 2023 17:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97AFAC433EF;
        Thu,  9 Mar 2023 17:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678381881;
        bh=+pVFmckyZKAy6V4CMmFE6drYZ5eXhJw5f2OiG2sh3uk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gtqK5mvOxzVD0VxS8duJTeyD9Bvr0/IU5nnINTT0lHuaFYag/S+Ms7RIvN+DDW4Vl
         d5Nd2wWfzLI/cE08PnmKjRlcdo8pV6HtH+6an7IlRPiOdxeKSMKYjMPkrQVQiQCJSp
         RtaDo2zEPv2pX82PKDNOi5QRvq5nyenxzW4b/Eis=
Date:   Thu, 9 Mar 2023 18:11:18 +0100
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
Message-ID: <ZAoTNlF+bHyyGs7x@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com>
 <CANeycqoHwp3URSPGvnNZx+9PdbC90UVFWLwg4w=JBHQnjnGUPA@mail.gmail.com>
 <ZAnB/DozWsir1cIE@kroah.com>
 <CANeycqrtjKMfpae_DUp-VrDZugJVO7mcbBvUBB+zAc=E6aU4tw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANeycqrtjKMfpae_DUp-VrDZugJVO7mcbBvUBB+zAc=E6aU4tw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:46:39PM -0300, Wedson Almeida Filho wrote:
> On Thu, 9 Mar 2023 at 08:24, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > > > > +        // owns a reference. This is satisfied by the call to `get_device` above.
> > > > > +        Self { ptr }
> > > > > +    }
> > > > > +
> > > > > +    /// Creates a new device instance from an existing [`RawDevice`] instance.
> > > > > +    pub fn from_dev(dev: &dyn RawDevice) -> Self {
> > > >
> > > > I am a rust newbie, but I don't understand this "RawDevice" here at all.
> > >
> > > Different buses will have their own Rust "Device" type, for example,
> > > pci::Device, amba::Device, platform::Device that wrap their C
> > > counterparts pci_dev, amba_device, platform_device.
> > >
> > > "RawDevice" is a trait for functionality that is common to all
> > > devices. It exposes the "struct device" of each bus/subsystem so that
> > > functions that work on any "struct device", for example, `clk_get`,
> > > `pr_info`. will automatically work on all subsystems.
> >
> > Why is this being called "Raw" then?  Why not just "Device" to follow
> > along with the naming scheme that the kernel already uses?
> 
> Because it gives us access to underlying raw `struct device` pointer,
> in Rust raw pointers are those unsafe `*mut T` or `*const T`. I'm not
> married to the name though, we should probably look for a better one
> if this one is confusing.
> 
> Just "Device" is already taken. It's a ref-counted `struct device` (it
> calls get_device/put_device in the right places automatically,
> guarantees no dandling pointers); it is meant to be used by code that
> needs to hold on to devices when they don't care about the bus. (It in
> fact implements `RawDevice`.)

I don't understand, why do you need both of these?  Why can't one just
do?  Why would you need one without the other?  I would think that
"Device" and "RawDevice" here would be the same thing, that is a way to
refer to a "larger" underlying struct device memory chunk in a way that
can be passed around without knowing, or caring, what the "real" device
type is.

>  How about `IsDevice`?

That sounds like a question, and would return a boolean, not a structure :)

> Then, for example, the platform bus would implement `IsDevice` for
> `plaform::Device`.

I don't really understand that, sorry.

thanks,

greg k-h
