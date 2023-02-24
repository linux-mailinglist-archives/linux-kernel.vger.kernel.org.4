Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 604996A1CD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 14:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbjBXNP0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 08:15:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjBXNPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 08:15:22 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9750156533;
        Fri, 24 Feb 2023 05:15:20 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id ECC973FA55;
        Fri, 24 Feb 2023 13:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677244519;
        bh=JO7LZ+UZTbX7aFX3msEPPny1eqLFld3+UeOQ0vjC2Vs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=BtDVDBuvwtoz5SQkWrfz9yQbpj9enVmh2+4C/WkmnHhBHWIq8N/3nHVCYBWLWCSPD
         K5kQucd+G5/rGqWQNOQSWWxyQ+S3EYSrp0hiOrsCH8pRLHOn5tVDbr+NtPaqQY0kMz
         oj9qAEnw1WOd9sbQbFqe8WIctPAcY1/eMab/vhGIVz8JS99KVXuNbj1X2FR6y0ghx/
         PUB5m1bYjjZxGNz6qc2dM4vO7kjahci9PmQ4t3W3gBIoRqQiCcRX9YGt10cTiHVONS
         AhMJMTEoMJXnYWRBYBz0hgtKZu/tyYSF+j0crSxBs3m0AmieVSbytfvXVFUW9rIDj7
         6VcsRGaLxC3fA==
Message-ID: <ef3a3638-6381-87ab-d674-644306b6b6ce@asahilina.net>
Date:   Fri, 24 Feb 2023 22:15:12 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
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
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/ieQ0UX/niAG1Hg@kroah.com>
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

On 24/02/2023 20.23, Greg Kroah-Hartman wrote:
> On Fri, Feb 24, 2023 at 07:53:14PM +0900, Asahi Lina wrote:
>> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>>
>> Add a RawDevice trait which can be implemented by any type representing
>> a device class (such as a PlatformDevice). This is the minimum amount of
>> Device support code required to unblock abstractions that need to take
>> device pointers.
>>
>> Lina: Rewrote commit message, and dropped everything except RawDevice.
>>
>> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
>> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
>> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
>> Signed-off-by: Asahi Lina <lina@asahilina.net>
>> ---
>>  rust/bindings/bindings_helper.h |  1 +
>>  rust/kernel/device.rs           | 23 +++++++++++++++++++++++
>>  rust/kernel/lib.rs              |  1 +
>>  3 files changed, 25 insertions(+)
>>
>> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> new file mode 100644
>> index 000000000000..9be021e393ca
>> --- /dev/null
>> +++ b/rust/kernel/device.rs
>> @@ -0,0 +1,23 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +
>> +//! Generic devices that are part of the kernel's driver model.
>> +//!
>> +//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
>> +
>> +use crate::bindings;
>> +
>> +/// A raw device.
>> +///
>> +/// # Safety
>> +///
>> +/// Implementers must ensure that the `*mut device` returned by [`RawDevice::raw_device`] is
>> +/// related to `self`, that is, actions on it will affect `self`. For example, if one calls
>> +/// `get_device`, then the refcount on the device represented by `self` will be incremented.
> 
> What is a "implementer" here?  Rust code?  C code?  Who is calling
> get_device() here, rust code or the driver code or something else?  How
> are you matching up the reference logic of this structure with the fact
> that the driver core actually owns the reference, not any rust code?

This is a Rust trait, so that would be Rust code. In practice that means
other abstractions for different device buses, and the generic one which
I sent as patch 5. It's not a structure, so it doesn't have any
reference logic itself. That would go into the implementing struct (like
`Device`). What the comment is saying is that other parts of the Rust
kernel crate may make assumptions about the relationship between the
lifetime of the struct implementing RawDevice and the lifetime of the
underlying `struct device`. So for example, it's not legal to return a
borrowed reference to a `struct device` that might go away before `self`
does.

We should probably make this `Sealed` too, to make sure no driver can
even try to implement it (which probably wouldn't make sense)... this
should only ever be implemented by stuff in the kernel crate.

The reference is owned by whoever owns the reference, no? If you call
get_device(), you own a new reference to the device (which means you can
keep the pointer around until you call put_device()). Normally in Rust
you would have logic where whatever Rust structure that owns a reference
(which in practice is most things that implement RawDevice) would also
have a `Clone` trait impl that calls `get_device()` and duplicates
itself, and a `Drop` trait impl that calls `put_device()`. In Rust
terms, the Rust structure "owns" the device reference, and whatever code
creates that structure needs to either be allowed to steal the reference
from its caller or explicitly call `get_device()`.

You can also elide that in some cases though, like when you're just
passing a device reference down from a callback into Rust code. Then the
caller guarantees it has a device reference, which will outlive the
execution of the callback. So the wrapper that calls user Rust code can
materialize a RawDevice implementation without calling `get_device()`,
and then pass a Rust reference to it (which means the downstream code
can't steal it), and then make sure it gets destroyed without a
`put_device()` before the callback returns. In Rust terms, that's a code
path that passes a borrowed reference to the device down into user code.

This kind of ties back to why Rust rather than C... C does not encode
concepts like "borrowing a reference" or "taking over a reference" in
the type system, so it's really easy to mess up the refcounting and end
up with dangling references or leaks. Rust does, so once you wrap a C
API with the matching Rust semantics, there's no way to mess up and have
those issues any more.

> 
>> +///
>> +/// Additionally, implementers must ensure that the device is never renamed. Commit a5462516aa99
>> +/// ("driver-core: document restrictions on device_rename()") has details on why `device_rename`
>> +/// should not be used.
> 
> As much as I would have liked that, that commit was from 2010 and
> device_rename() is still being used by some pretty large subsystems
> (networking and IB) and I don't see that going away any year soon.
> 
> So yes, your device will be renamed, so don't mess with the device name
> like I mentioned in review of path 5/5 in this series.

I think we can just drop that part (and the name stuff) then. Wedson, is
that okay?

> 
>> +pub unsafe trait RawDevice {
>> +    /// Returns the raw `struct device` related to `self`.
>> +    fn raw_device(&self) -> *mut bindings::device;
> 
> Again, what prevents this device from going away?  I don't see a call to
> get_device() here :(

That would be up to the caller, if it needs to keep the pointer around.
Think of `raw_device()` as just "please return the `struct device *`
pointer for yourself, thanks". If you need to store that pointer for
later, you need to call `get_device()`. But most of the time it will be
used transiently, and then you don't need to take any references since
the safety requirement above guarantees that `self` owns a reference.
The caller then just needs to make sure not to throw away `self` before
it finishes using the returned pointer.

Keep in mind that this is an internal abstraction, it's there to be
implemented and used by the kernel crate itself. User code can't
actually do anything with the returned pointer without using `unsafe`
(so it's safe to expose this) and can't implement the trait without
`unsafe` either. But it can take dynamic trait arguments of type
RawDevice and pass them along, which is perfectly fine. Rust guarantees
that the right `get_device()` and `put_device()` are called when
references get cloned or dropped, for owned objects, and for borrowed
references there is no need to touch the refcount.

> And again, why are bindings needed for a "raw" struct device at all?
> Shouldn't the bus-specific wrappings work better?

Because lots of kernel subsystems need to be able to accept "any" device
and don't care about the bus! That's what this is for. All the bus
wrappers would implement this so they can be used as an argument for all
those subsystems (plus a generic one when you just need to pass around
an actual owned generic reference and no longer need bus-specific
operations - you can materialize that out of a RawDevice impl, which is
when get_device() would be called). That's why I'm introducing this now,
because both io_pgtable and rtkit need to take `struct device` pointers
on the C side so we need some "generic struct device" view on the Rust side.

~~ Lina
