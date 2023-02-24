Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBBEA6A1DA0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 15:44:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjBXOoP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 09:44:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjBXOoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 09:44:06 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7151689D;
        Fri, 24 Feb 2023 06:44:03 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 2AB393FA55;
        Fri, 24 Feb 2023 14:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677249842;
        bh=D5wNXpCLthvKzU0v4nv/lr+ty+Pv+guL5ET4c/EH8nE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Irlcd4vdNdqExEiwyDlVv808VxXgX9m/G5YGPBtDAzaBbtvHVqk+M6pp6lLJRb/Vl
         6PrAkVvLBUdlAoLtVdfffN7wpTeIp9MFE/g0j0JNbXJ+l6auXoQVRW5MpDE1y2N5mh
         nPJqUnPdkN8C7BIV5xy8t8S2oK9uEfw0IEBybH4Nqp+XtB/abdrfPIS5jMAOH3drxP
         DcMRWEwlj3kRo+dDtOQ2XYy/fpEYNkcZcCGzvD3ZTYRlhGSqRoMtRKpCIVHDFV/3xJ
         3pdo74roDva34gPGO/b/MIfnHB1QxdQJKmEclCybOaUuS9owqxmRxG1HfeiMgx1XuK
         7jU8V9xYpKXIw==
Message-ID: <0e3c15bd-a1d6-a363-d7b6-087b6e4cddac@asahilina.net>
Date:   Fri, 24 Feb 2023 23:43:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 2/5] rust: device: Add a minimal RawDevice trait
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
 <Y/ieQ0UX/niAG1Hg@kroah.com>
 <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
 <Y/jFeZzZVCpBGvGv@kroah.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/jFeZzZVCpBGvGv@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/02/24 23:11, Greg Kroah-Hartman wrote:
> Thanks for the detailed rust explainations, I'd like to just highlight
> one thing:
> 
> On Fri, Feb 24, 2023 at 10:15:12PM +0900, Asahi Lina wrote:
>> On 24/02/2023 20.23, Greg Kroah-Hartman wrote:
>>> And again, why are bindings needed for a "raw" struct device at all?
>>> Shouldn't the bus-specific wrappings work better?
>>
>> Because lots of kernel subsystems need to be able to accept "any" device
>> and don't care about the bus! That's what this is for.
> 
> That's great, but:
> 
>> All the bus
>> wrappers would implement this so they can be used as an argument for all
>> those subsystems (plus a generic one when you just need to pass around
>> an actual owned generic reference and no longer need bus-specific
>> operations - you can materialize that out of a RawDevice impl, which is
>> when get_device() would be called). That's why I'm introducing this now,
>> because both io_pgtable and rtkit need to take `struct device` pointers
>> on the C side so we need some "generic struct device" view on the Rust side.
> 
> In looking at both ftkit and io_pgtable, those seem to be good examples
> of how "not to use a struct device", so trying to make safe bindings
> from Rust to these frameworks is very ironic :)

And this is why I want to use Rust, and why writing the abstractions for
C code is so difficult... Rust encodes all these rules in the type
system, but C doesn't, and so many kernel APIs don't document any of
this or what the requirements are...

> rtkit takes a struct device pointer and then never increments it,
> despite saving it off, which is unsafe.  It then only uses it to print
> out messages if things go wrong (or right in some cases), which is odd.
> So it can get away from using a device pointer entirely, except for the
> devm_apple_rtkit_init() call, which I doubt you want to call from rust
> code, right?

That sounds like we need to fix the C side to grab a reference ^^

We do need to pass the device to the init function though
(apple_rtkit_init(), this is in the SoC tree which I mentioned as a
prequisite and already on the way to 6.3-rc1), since at the very least
it has to pick up the mailbox and all that to initialize.

Alternatively we could say that the C API contract is that the user of
rtkit has to own a reference, and then the Rust abstraction would have
to take that reference to make a safe abstraction, but that doesn't
sound like the better option.

What do you recommend for things that want to print device-associated
messages, if not holding a reference to the device? Or did I
misunderstand what you meant? Just pr_foo() isn't great because we have
a lot of instances of rtkit and then you wouldn't know which device the
messages are about...

> for io_pgtable, that's a bit messier, you want to pass in a device that
> io_pgtable treats as a "device" but again, it is NEVER properly
> reference counted, AND, it is only needed to try to figure out the bus
> operations that dma memory should be allocated from for this device.  So
> what would be better to save off there would be a pointer to the bus,
> which is constant and soon will be read-only so there are no lifetime
> rules needed at all (see the major struct bus_type changes going into
> 6.3-rc1 that will enable that to happen).
> 
> So the two subsystems you want to call from rust code don't properly
> handle the reference count of the object you are going to pass into it,
> and only need it for debugging and iommu stuff, which is really only the
> bus that the device is on, not good examples to start out with :)

Well, they're two examples that are dependencies for the driver I wrote,
and I don't think you want me picking easy examples with zero known
upcoming users... ^^;;

> Yeah, this is yack-shaving, sorry, but it's how we clean up core
> subsystems for apis and implementations that are not really correct and
> were not noticed at the time.

I'm fine with helping fix all this, and I don't expect all the
underlying C code to be perfect already either! I already fixed one
locking bug in DRM and spent a lot of time trying to figure out lifetime
rules there, but I didn't dig into rtkit/io_pgtable and didn't realize
they don't take references properly...

> Can we see some users of this code posted so I can see how struct device
> is going to work in a rust driver?  That's the thing I worry most about
> the rust/C interaction here as we have two different ways of thinking
> about reference counts from the two worlds and putting them together is
> going to be "interesting", as can be seen here already.

I linked a tree with everything in the cover letter ([4]), look in
drivers/gpu/drm/asahi for the actual driver. But there are a lot of
other dependencies that have to go in before that will compile
(everything else in that branch...)

I know it's hard to review without examples, but I also can't just post
the driver and everything else as one series now, there's still a lot to
be improved and fixed and I'm working with the Rust folks on figuring
out a roadmap for that... and waiting until "everything" is ready and
perfect would mean we don't get anything done in the meantime and fall
into a pit of endless rebasing and coordinating downstream trees, which
also isn't good...

~~ Lina
