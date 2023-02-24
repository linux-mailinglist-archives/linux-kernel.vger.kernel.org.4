Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FE6C6A1D47
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:11:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjBXOLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBXOLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:11:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA0412B;
        Fri, 24 Feb 2023 06:11:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C836B61839;
        Fri, 24 Feb 2023 14:11:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A512EC433EF;
        Fri, 24 Feb 2023 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677247868;
        bh=ILec1+10culSs+4LFcu4lSKq2NAnqzI8CinlFn1UHX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=X5RRtLW6bsr/7UHfOmsN3l4DkaUpOu9tISvL05vIbTpOsR9fYGuvcHyaMvmyqaBMJ
         ZLsK7n4KM2xdKyXZoDZC2QjQcyQtNKZnLtxaG+bu3PkCd9Pj8Bx2Qm6NjymWSWuxJx
         3kZpU2ead9fExo/nCjFMJLS+SK4UgO8ZYbOH/gv8=
Date:   Fri, 24 Feb 2023 15:11:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
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
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Message-ID: <Y/jFeZzZVCpBGvGv@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
 <Y/ieQ0UX/niAG1Hg@kroah.com>
 <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the detailed rust explainations, I'd like to just highlight
one thing:

On Fri, Feb 24, 2023 at 10:15:12PM +0900, Asahi Lina wrote:
> On 24/02/2023 20.23, Greg Kroah-Hartman wrote:
> > And again, why are bindings needed for a "raw" struct device at all?
> > Shouldn't the bus-specific wrappings work better?
> 
> Because lots of kernel subsystems need to be able to accept "any" device
> and don't care about the bus! That's what this is for.

That's great, but:

> All the bus
> wrappers would implement this so they can be used as an argument for all
> those subsystems (plus a generic one when you just need to pass around
> an actual owned generic reference and no longer need bus-specific
> operations - you can materialize that out of a RawDevice impl, which is
> when get_device() would be called). That's why I'm introducing this now,
> because both io_pgtable and rtkit need to take `struct device` pointers
> on the C side so we need some "generic struct device" view on the Rust side.

In looking at both ftkit and io_pgtable, those seem to be good examples
of how "not to use a struct device", so trying to make safe bindings
from Rust to these frameworks is very ironic :)

rtkit takes a struct device pointer and then never increments it,
despite saving it off, which is unsafe.  It then only uses it to print
out messages if things go wrong (or right in some cases), which is odd.
So it can get away from using a device pointer entirely, except for the
devm_apple_rtkit_init() call, which I doubt you want to call from rust
code, right?

for io_pgtable, that's a bit messier, you want to pass in a device that
io_pgtable treats as a "device" but again, it is NEVER properly
reference counted, AND, it is only needed to try to figure out the bus
operations that dma memory should be allocated from for this device.  So
what would be better to save off there would be a pointer to the bus,
which is constant and soon will be read-only so there are no lifetime
rules needed at all (see the major struct bus_type changes going into
6.3-rc1 that will enable that to happen).

So the two subsystems you want to call from rust code don't properly
handle the reference count of the object you are going to pass into it,
and only need it for debugging and iommu stuff, which is really only the
bus that the device is on, not good examples to start out with :)

Yeah, this is yack-shaving, sorry, but it's how we clean up core
subsystems for apis and implementations that are not really correct and
were not noticed at the time.

Can we see some users of this code posted so I can see how struct device
is going to work in a rust driver?  That's the thing I worry most about
the rust/C interaction here as we have two different ways of thinking
about reference counts from the two worlds and putting them together is
going to be "interesting", as can be seen here already.

thanks,

greg k-h
