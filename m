Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDFD6A1E59
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 16:18:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjBXPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 10:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbjBXPSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 10:18:17 -0500
Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49DB0DBE5;
        Fri, 24 Feb 2023 07:18:12 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: lina@asahilina.net)
        by mail.marcansoft.com (Postfix) with ESMTPSA id 7B8363FA55;
        Fri, 24 Feb 2023 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=asahilina.net;
        s=default; t=1677251455;
        bh=bwPvVyEUxtLRCYv2r9JtCrX7vjpiYD7tuhjqs1lxyKw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=eJe38OTmJZA4H5Yhrd/tMJS0IZdUQjMOTlXKh/JM4Qi2U8YL/NqmLC8WzbBuI84sU
         KF3gWsbTmB+GU2vN1OhomTAKvAg7y+9BdX0vszuzhkJGpQr3jIVwJ6XXh6UoVgLEL4
         89Medj+mjrUdLfTQR2TK7ilReiGdQ/5TfQee08lEPVbGXYSfjYdSCc4YJLKdGBGt6n
         f9VSi+YR5OQTaFvc2cCqcunEwIHzWlZZT5xtuUHobbcsKutejiFUY4herKRq+Jbq16
         CizC0rErHYj3xUUTO2gPEgNSlwMNoGAdg0Vw4nbnfQvrvl7sLXfEAyzMfL9iz90VTc
         TMNU36Iq6q1uA==
Message-ID: <26fc1456-0244-a379-0af4-e6adc819545c@asahilina.net>
Date:   Sat, 25 Feb 2023 00:10:47 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
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
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
 <Y/idMBIOfFZxXnVM@kroah.com>
From:   Asahi Lina <lina@asahilina.net>
In-Reply-To: <Y/idMBIOfFZxXnVM@kroah.com>
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

Hi!

First, I should say that some of this is really an example, and this
abstraction doesn't need to go in as part of this series. I just added
it at the end as an example of how RawDevice could/will be implemented,
but there is more discussion that needs to happen around Devices
(especially around how actual driver implementations and device data
stuff work) I think. The main goal of having the RawDevice trait now is
that we can start reviewing and upstreaming things that aren't part of
the device model but take device references. Otherwise we end up
serializing everything too much and it will be difficult to get
everything upstream in a reasonable timeframe...

Also note that I didn't write any of this code so if you have questions
about *why* it was all designed like this, I think Wedson will have to
answer that ^^

On 2023/02/24 20:19, Greg Kroah-Hartman wrote:
> On Fri, Feb 24, 2023 at 07:53:17PM +0900, Asahi Lina wrote:
>> From: Wedson Almeida Filho <wedsonaf@gmail.com>
>>
>> Add a Device type which represents an owned reference to a generic
>> struct device. This minimal implementation just handles reference
>> counting and allows the user to get the device name.
> 
> What good is just the device name?  I'm all for proper bindings to hook
> up properly to the driver core, but this feels like it's not really
> doing much of anything.

I think we can just drop this, I don't use it. It was just an example of
how a RawDevice method might work that is in the downstream tree, and I
kept it here.

A more practical example would be `of_node()`, which returns the OF node
associated with a device and is how the OF abstraction I wrote hooks
into the device model. I think I can submit that one pretty soon too, if
I'm not mistaken.

>> +void *rust_helper_dev_get_drvdata(struct device *dev)
>> +{
>> +	return dev_get_drvdata(dev);
>> +}
>> +EXPORT_SYMBOL_GPL(rust_helper_dev_get_drvdata);
> 
> No matching dev_set_drvdata()?  What good is getting a random void
> pointer if you couldn't set it in the first place?  :)

I thought something else used this, but looking again the bus drivers
just use stuff like platform_{set,get}_drvdata. I'll drop it, I'm not
sure why I thought I needed this later...

>> +impl Device {
>> +    /// Creates a new device instance.
>> +    ///
>> +    /// # Safety
>> +    ///
>> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
>> +    pub unsafe fn new(ptr: *mut bindings::device) -> Self {
>> +        // SAFETY: By the safety requirements, ptr is valid and its refcounted will be incremented.
>> +        unsafe { bindings::get_device(ptr) };
> 
> You don't check the return value of get_device()?  What if it failed
> (hint, it can)?

Really? I looked at the implementation and I don't see how it can fail,
as long as the argument is non-NULL and valid... (which is a
precondition of this unsafe function). Did I miss something?

>> +        // INVARIANT: The safety requirements satisfy all but one invariant, which is that `self`
>> +        // owns a reference. This is satisfied by the call to `get_device` above.
>> +        Self { ptr }
>> +    }
>> +
>> +    /// Creates a new device instance from an existing [`RawDevice`] instance.
>> +    pub fn from_dev(dev: &dyn RawDevice) -> Self {
> 
> I am a rust newbie, but I don't understand this "RawDevice" here at all.

RawDevice is a trait, so this means "a dynamic reference to any type
that implements RawDevice". That could be a reference to a bus device
outright (like a PlatformDevice), or another Device, or a type-erased
dynamic object that is "some device type" but you don't know which (like
a reference taken from a Box<dyn RawDevice>).

What this means is that you can always create a Device from a reference
to anything that is a device (a RawDevice impl). This code path does a
get_device(), so it creates a new reference that becomes logically owned
by the Device object.

Think of it like "clone, and erase the specific device type to a generic
device". This is the operation you would use in a kernel abstraction
that needs to take "some device", and then grab its own reference and
keep it for later, but which does not care about the specific bus type.

In particular, the way the bus abstractions work right now downstream,
the specific bus device types are not cloneable and only represent
borrowed device references that exist for the lifetime of the driver
probe callback. The idea is that you grab references to all the
bus-specific resources you need within (there is revocability logic to
make sure resources can disappear without breaking pointers, failing
gracefully if accessed) and do any bus-specific init you need, and then
you no longer need to directly touch the bus device after that. This is
definitely not going to cover some corner cases, but I haven't had any
need to use platform device ops in my GPU driver after probe, so it
works for me. But the driver does need to pass around device references
and keep them in some inner structures to make things like `dev_warn!()`
macros work, and that is what `Device` and `RawDevice` are for: `Device`
is an owning reference that can be cloned and constructed out of the
original `PlatformDevice` and can outlive it.
>> +        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
>> +        // requirements.
>> +        unsafe { Self::new(dev.raw_device()) }
>> +    }
>> +}
>> +
>> +// SAFETY: The device returned by `raw_device` is the one for which we hold a reference.
>> +unsafe impl RawDevice for Device {
>> +    fn raw_device(&self) -> *mut bindings::device {
>> +        self.ptr
>> +    }
> 
> What does this raw device do?  What is the relationship to a "real"
> device?  Maybe it's just my lack of rust knowledge here showing, so any
> hints would be appreciated.

This means that a Device (an owned reference to a generic struct device)
can be used anywhere you need a generic device reference (this sounds
tautological but the idea is that specific bus device types can also be
used, which is why this layer of indirection exists).

In this case it's just an accessor for self.ptr since a Device is just a
wrapper around the pointer.

> 
>> +}
>> +
>> +impl Drop for Device {
>> +    fn drop(&mut self) {
>> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
>> +        // relinquish it now.
>> +        unsafe { bindings::put_device(self.ptr) };
> 
> So it is now ok for this to be freed?

Yes, because the Rust type system guarantees that Drop only gets called
when the Device no longer has an owner. That means there are no
references of any kind left and the object is ceasing to exist. Rust
also blocks you from manually calling drop() (this is a special case,
without it you could drop something more than once).

In other words, a Device represents a reference to a struct device. Once
the Device gets dropped, there is nobody left to potentially use that
reference through the Device by definition. (Of course you can invalidly
stash away the raw pointer like those C API issues you found... but
that's a different problem).

One way to solve the C abstraction issue would be to embed a Device in
the RtKit/IoPageTableInner structs (the respective Rust abstraction
types), creating it out of the passed RawDevice reference with
Device::from_raw() in the constructor for those. That means you'd
automatically `get_device()` on construction and `put_device()` when the
abstraction objects get dropped, and that would solve all the problems
without any extra cleanup or management code.

> One meta-comment, why is any of this needed at all?  No driver should
> ever be dealing with a "raw" struct device pointer at all, right?  They
> should be calling into subsystems that give it a pointer to a
> bus-specific pointer type (gpio, usb, pci, etc.)

I'm getting the feeling maybe the name is just bad. Maybe it should be
called AbstractDevice or IntoDevice or something like that. It's just
"some device".

Drivers indeed should never be dealing with actual device pointers, the
pointers are for consumption by the kernel crate only. That this is done
using trait functions that can technically be called by the driver code
is just the way Rust models this: you need *some* trait function to get
at the raw pointer (because the kernel crate needs it) and the trait
needs to be public (because it's part of the public interface as the
abstract device type) and there is no such thing as private trait
functions in a public trait in Rust. But the idea is that this doesn't
matter: sure, drivers can *get* a raw device pointer but they can't *do*
anything with it without unsafe.

Technically though, if we wanted to hide this further, we could make it
return a newtype wrapper around the raw pointer. Then as long as the
inner field is not public, drivers wouldn't even be able to get at the
raw pointer but the kernel crate would. I'm not sure if this is worth
it, though. It's not like drivers can't work around that with unsafe
anyway, once you use unsafe you can do all kinds of crazy stuff like raw
memory reinterpretations, copies, and transmutations, which will allow
you to cheat the entire type system if you want... but of course the
whole idea here is that we make things impossible in safe code and then
we look at the unsafe blocks with a magnifying glass during review to
make sure they aren't doing anything actually unsafe or crazy.

~~ Lina
