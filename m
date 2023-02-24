Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 405F26A1E95
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjBXPcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBXPcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:32:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727E46A9CD;
        Fri, 24 Feb 2023 07:32:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08D77B81BFC;
        Fri, 24 Feb 2023 15:32:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1029BC433EF;
        Fri, 24 Feb 2023 15:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677252728;
        bh=VG3FvE06PIjxGs1vg0h1POSeWhUrBuh1/n18lMYwwHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HLnWmy5FQGU1wN2m4c581AYIF56xRzlRV/NV3wCA77AsxAUtmBcIcdar4ZZwAejGw
         uO8cWDLKEN2ioQ9wUq5hkeW/UXa8US3nvUr6coXLD7W2G2bLLwtS30It9XxBZCZx9L
         20bTtM+oSzGT7mMWMlKqzkM3+P/BQj4eZoZGw6iE=
Date:   Fri, 24 Feb 2023 16:32:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Message-ID: <Y/jYdTrsrCyCPXHT@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
 <Y/ieQ0UX/niAG1Hg@kroah.com>
 <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
 <Y/jFeZzZVCpBGvGv@kroah.com>
 <e6d6d928-4514-55b9-346d-2e5e82220729@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6d6d928-4514-55b9-346d-2e5e82220729@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 02:32:47PM +0000, Robin Murphy wrote:
> On 2023-02-24 14:11, Greg Kroah-Hartman wrote:
> > Thanks for the detailed rust explainations, I'd like to just highlight
> > one thing:
> > 
> > On Fri, Feb 24, 2023 at 10:15:12PM +0900, Asahi Lina wrote:
> > > On 24/02/2023 20.23, Greg Kroah-Hartman wrote:
> > > > And again, why are bindings needed for a "raw" struct device at all?
> > > > Shouldn't the bus-specific wrappings work better?
> > > 
> > > Because lots of kernel subsystems need to be able to accept "any" device
> > > and don't care about the bus! That's what this is for.
> > 
> > That's great, but:
> > 
> > > All the bus
> > > wrappers would implement this so they can be used as an argument for all
> > > those subsystems (plus a generic one when you just need to pass around
> > > an actual owned generic reference and no longer need bus-specific
> > > operations - you can materialize that out of a RawDevice impl, which is
> > > when get_device() would be called). That's why I'm introducing this now,
> > > because both io_pgtable and rtkit need to take `struct device` pointers
> > > on the C side so we need some "generic struct device" view on the Rust side.
> > 
> > In looking at both ftkit and io_pgtable, those seem to be good examples
> > of how "not to use a struct device", so trying to make safe bindings
> > from Rust to these frameworks is very ironic :)
> > 
> > rtkit takes a struct device pointer and then never increments it,
> > despite saving it off, which is unsafe.  It then only uses it to print
> > out messages if things go wrong (or right in some cases), which is odd.
> > So it can get away from using a device pointer entirely, except for the
> > devm_apple_rtkit_init() call, which I doubt you want to call from rust
> > code, right?
> > 
> > for io_pgtable, that's a bit messier, you want to pass in a device that
> > io_pgtable treats as a "device" but again, it is NEVER properly
> > reference counted, AND, it is only needed to try to figure out the bus
> > operations that dma memory should be allocated from for this device.  So
> > what would be better to save off there would be a pointer to the bus,
> > which is constant and soon will be read-only so there are no lifetime
> > rules needed at all (see the major struct bus_type changes going into
> > 6.3-rc1 that will enable that to happen).
> 
> FWIW the DMA API *has* to know which specific device it's operating with,
> since the relevant properties can and do vary even between different devices
> within a single bus_type (e.g. DMA masks).

What bus_type has different DMA masks depending on the device on that
bus today?

And the iommu ops are on the bus, not the device, but there is a
iommu_group on the device, is that what you are referring to?

Am I getting iommu and dma stuff confused here?  A bus also has dma
callbacks, but yet the device itself has dma_ops?

> In the case of io-pgtable at least, there's no explicit refcounting since
> the struct device must be the one representing the physical
> platform/PCI/etc. device consuming the pagetable, so if that were to
> disappear from underneath its driver while the pagetable is still in use,
> things would already have gone very very wrong indeed :)

But that could happen at any point in time, the device can be removed
from the system with no warning, how do you guarantee that io-pgtable is
being initialized with a device that can NOT be removed?

Think of drawers containing CPUs and PCI devices and memory, Linux
has supported hot-removal of those for decades.  (well, not for memory,
we could only hot-add that...)

Again, passing in a pointer to a struct device, and saving it off
WITHOUT incrementing the reference count is not ok, that's not how
reference counts work...

But again, let's see about disconnecting the iommu ops entirely from the
device and just relying on the bus, that should work better, rigth?

thanks,

greg k-h
