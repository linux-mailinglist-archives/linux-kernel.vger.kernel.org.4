Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08ADD6A1E7C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjBXPYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:24:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjBXPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:24:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D39C1448A;
        Fri, 24 Feb 2023 07:24:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 10968B81BFC;
        Fri, 24 Feb 2023 15:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53684C4339B;
        Fri, 24 Feb 2023 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677252279;
        bh=PsQlJ5rODM7lTMLrcvBKIiq/aelF+HVpzHzjJleOBxc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RziRQza4CX6ahk6XD13yrybSVAGLgQkwOlVayytq+YzQkA1c8IZOM+WiHEmJyDzF+
         yRT+2tGyhDZvNsWSN6LDHpY8zbqTkCaO2/yebjCTTAFJj4czFLuoguLtGft7lhz6eb
         AVWjpQz4jth6VShjp86ja2lTYO9b7Z93RpwtOUhY=
Date:   Fri, 24 Feb 2023 16:24:37 +0100
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
Message-ID: <Y/jWtVr7JK/YKcsE@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
 <Y/ieQ0UX/niAG1Hg@kroah.com>
 <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
 <Y/jFeZzZVCpBGvGv@kroah.com>
 <0e3c15bd-a1d6-a363-d7b6-087b6e4cddac@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e3c15bd-a1d6-a363-d7b6-087b6e4cddac@asahilina.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 11:43:54PM +0900, Asahi Lina wrote:
> 
> 
> On 2023/02/24 23:11, Greg Kroah-Hartman wrote:
> > Thanks for the detailed rust explainations, I'd like to just highlight
> > one thing:
> > 
> > On Fri, Feb 24, 2023 at 10:15:12PM +0900, Asahi Lina wrote:
> >> On 24/02/2023 20.23, Greg Kroah-Hartman wrote:
> >>> And again, why are bindings needed for a "raw" struct device at all?
> >>> Shouldn't the bus-specific wrappings work better?
> >>
> >> Because lots of kernel subsystems need to be able to accept "any" device
> >> and don't care about the bus! That's what this is for.
> > 
> > That's great, but:
> > 
> >> All the bus
> >> wrappers would implement this so they can be used as an argument for all
> >> those subsystems (plus a generic one when you just need to pass around
> >> an actual owned generic reference and no longer need bus-specific
> >> operations - you can materialize that out of a RawDevice impl, which is
> >> when get_device() would be called). That's why I'm introducing this now,
> >> because both io_pgtable and rtkit need to take `struct device` pointers
> >> on the C side so we need some "generic struct device" view on the Rust side.
> > 
> > In looking at both ftkit and io_pgtable, those seem to be good examples
> > of how "not to use a struct device", so trying to make safe bindings
> > from Rust to these frameworks is very ironic :)
> 
> And this is why I want to use Rust, and why writing the abstractions for
> C code is so difficult... Rust encodes all these rules in the type
> system, but C doesn't, and so many kernel APIs don't document any of
> this or what the requirements are...

I totally agree, and is why I'm wanting to review this stuff.

> > rtkit takes a struct device pointer and then never increments it,
> > despite saving it off, which is unsafe.  It then only uses it to print
> > out messages if things go wrong (or right in some cases), which is odd.
> > So it can get away from using a device pointer entirely, except for the
> > devm_apple_rtkit_init() call, which I doubt you want to call from rust
> > code, right?
> 
> That sounds like we need to fix the C side to grab a reference ^^

I agree.  Or remove the reference entirely.

> We do need to pass the device to the init function though
> (apple_rtkit_init(), this is in the SoC tree which I mentioned as a
> prequisite and already on the way to 6.3-rc1), since at the very least
> it has to pick up the mailbox and all that to initialize.

As I said, the rtkit code does not actually use the device pointer at
all except for some (I would say pointless) log messages.  So we could
change the rtkit code either way, I would go for the removal.

> Alternatively we could say that the C API contract is that the user of
> rtkit has to own a reference, and then the Rust abstraction would have
> to take that reference to make a safe abstraction, but that doesn't
> sound like the better option.

Yeah, that feels odd.

> What do you recommend for things that want to print device-associated
> messages, if not holding a reference to the device?

If you aren't holding a reference to the device, that means you aren't
associated to it at all, so you better not be printing out anything
related to any device as that pointer could be invalid at any point in
time.

> Or did I
> misunderstand what you meant? Just pr_foo() isn't great because we have
> a lot of instances of rtkit and then you wouldn't know which device the
> messages are about...

Then the rtkit code needs to be changed to properly grab the reference
and actually use it for something other than just a log message.  If it
only wants it for a log message, then let's just drop it and have the
rtkit code go quiet, as when kernel code is working properly, it should
be quiet.  If something goes wrong, the code that called into rtkit can
print out a message based on the error return values.

I have no idea what "rtkit" is, if it's an interface to hardware, why
doesn't it have its own struct device that it creates and manages and
uses instead?  In my quick glance, that feels like the real solution
here instead of just "I hope this pointer is going to be valid" like it
lives with today.  Odds are you can't remove a rtkit device at runtime,
so no one has noticed this yet...

> > for io_pgtable, that's a bit messier, you want to pass in a device that
> > io_pgtable treats as a "device" but again, it is NEVER properly
> > reference counted, AND, it is only needed to try to figure out the bus
> > operations that dma memory should be allocated from for this device.  So
> > what would be better to save off there would be a pointer to the bus,
> > which is constant and soon will be read-only so there are no lifetime
> > rules needed at all (see the major struct bus_type changes going into
> > 6.3-rc1 that will enable that to happen).
> > 
> > So the two subsystems you want to call from rust code don't properly
> > handle the reference count of the object you are going to pass into it,
> > and only need it for debugging and iommu stuff, which is really only the
> > bus that the device is on, not good examples to start out with :)
> 
> Well, they're two examples that are dependencies for the driver I wrote,
> and I don't think you want me picking easy examples with zero known
> upcoming users... ^^;;

Hey, this is good, I like it, no complaints!

> > Yeah, this is yack-shaving, sorry, but it's how we clean up core
> > subsystems for apis and implementations that are not really correct and
> > were not noticed at the time.
> 
> I'm fine with helping fix all this, and I don't expect all the
> underlying C code to be perfect already either! I already fixed one
> locking bug in DRM and spent a lot of time trying to figure out lifetime
> rules there, but I didn't dig into rtkit/io_pgtable and didn't realize
> they don't take references properly...

The iomem code is under heavy-flux right now so let's see what 6.3-rc1
looks like to determine if this still needs to be resolved or not.  I
hope the latest set of fixes/reworks for that subsystem land.  Either
way, I'll look into what needs to be done there as obviously, the
current code is not correct.

> > Can we see some users of this code posted so I can see how struct device
> > is going to work in a rust driver?  That's the thing I worry most about
> > the rust/C interaction here as we have two different ways of thinking
> > about reference counts from the two worlds and putting them together is
> > going to be "interesting", as can be seen here already.
> 
> I linked a tree with everything in the cover letter ([4]), look in
> drivers/gpu/drm/asahi for the actual driver. But there are a lot of
> other dependencies that have to go in before that will compile
> (everything else in that branch...)

Sorry, it's hard to notice random github repos and branches, especially
when traveling, that's why we use email for review.

> I know it's hard to review without examples, but I also can't just post
> the driver and everything else as one series now, there's still a lot to
> be improved and fixed and I'm working with the Rust folks on figuring
> out a roadmap for that... and waiting until "everything" is ready and
> perfect would mean we don't get anything done in the meantime and fall
> into a pit of endless rebasing and coordinating downstream trees, which
> also isn't good...

Yeah, it's a chicken and egg issue right now, no worries, I understand.
This is going to take some cycles to get right.

thanks,

greg k-h
