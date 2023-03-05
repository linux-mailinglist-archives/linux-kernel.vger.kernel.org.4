Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B44816AAE6C
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 07:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCEGjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 01:39:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjCEGjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 01:39:39 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817EDD321;
        Sat,  4 Mar 2023 22:39:36 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id q15so4808751oiw.11;
        Sat, 04 Mar 2023 22:39:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677998376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tIYEOzJQxqF3hQccTPsHlionVPSIsIxk4F/x9htVnz0=;
        b=F21QkwNVnf+ZV2encjLTEh1pdJRYNvyYVMsKv5Oi3WTri0bN+KkpvYcSzK250kzOiO
         xXXaxv2R4U7WeC0cqQLNKYx10Et+pJcdnsXoRqlK/fc7/qNJGi6S2+Uy9F05HVQCPuz8
         9X4Uhyvs23/508J2wvWtINMZ4hDIc3AIsuzrL8vvyyIWLtqhINPFU+24R0Lf5JC4eEOi
         /hqUGyCXJduBaTvRl6SudBeJk6ZtA4YScSA5WnmoxCNPR6TV6AufNtI8Jbg+HAyhoB0r
         7ranxmgBplr4F7yjbvwCPssKVTWUiOWWnBzgmDxOtjWIY2fTj5obaE7ahqgyQruiCg/G
         /sFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677998376;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tIYEOzJQxqF3hQccTPsHlionVPSIsIxk4F/x9htVnz0=;
        b=Ua4ioaewEJATKXTkhL72TIlfaGLH3Lj3+uIUHF5q5YBTi0O54/3/aSMgogC8QHq3n+
         I6GEt54Y1O2JpSgV0oRoDSJ0MbH6ADBTs85sWXJDgNg4qsvPMIds3FYGjYjFQl6zgsrO
         0UmeKEEtYzpVNsAzvDnRV0lDSjRD+NjkrZ28ozT3NdRMzMydKbvwVyKFg5e9gm+8nV0S
         oPa78tVCxynHfJYl65TzhTN+DLOCpxTfH5AiaE7CuCz0ij1cFK0YcYUUc2vRF0KdS270
         BD3ACe8ezLL+b1cE2E495P2p7GhJD4Yc4V0NWtsfY8R+hfEEd7Of0roGvTAas/gFYOwA
         qSjQ==
X-Gm-Message-State: AO0yUKUC1iav0cZjAGlSM0ijCT18XySWvY87pT35QMBGRmUNktE40kUl
        Jh//KHE7djqLsO1vqub464OlM2hQhIVuYF1fJr8=
X-Google-Smtp-Source: AK7set9KF9cTRphDeTJuBQET2rsv5nqcE7o6gCs2N9Mg9S1QPQx03F3OP551y9M8uHF+WoQ00oNFw5XfuxnR4cRbJgM=
X-Received: by 2002:aca:1c09:0:b0:384:2019:c201 with SMTP id
 c9-20020aca1c09000000b003842019c201mr2163514oic.8.1677998375603; Sat, 04 Mar
 2023 22:39:35 -0800 (PST)
MIME-Version: 1.0
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net> <Y/idMBIOfFZxXnVM@kroah.com>
In-Reply-To: <Y/idMBIOfFZxXnVM@kroah.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sun, 5 Mar 2023 03:39:25 -0300
Message-ID: <CANeycqoHwp3URSPGvnNZx+9PdbC90UVFWLwg4w=JBHQnjnGUPA@mail.gmail.com>
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>, Arnd Bergmann <arnd@arndb.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Neal Gompa <neal@gompa.dev>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

As Lina points out, I wrote this code, so I'll try to answer your questions.

Lina, apologies for the delay in participating, I've been distracted
with other stuff.

On Fri, 24 Feb 2023 at 08:19, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 24, 2023 at 07:53:17PM +0900, Asahi Lina wrote:
> > From: Wedson Almeida Filho <wedsonaf@gmail.com>
> >
> > Add a Device type which represents an owned reference to a generic
> > struct device. This minimal implementation just handles reference
> > counting and allows the user to get the device name.
>
> What good is just the device name?  I'm all for proper bindings to hook
> up properly to the driver core, but this feels like it's not really
> doing much of anything.
>
> Do you have a real user that we can see how this is interacting?
>
> And what does a driver care about the device name anyway?  It should
> only be using the dev_*() calls to print that info out to the log, and
> never messing around with it in any other format as that's what
> userspace expects.

I added this for the pl061 gpio driver, which initialises the gpio
chip label with the device name:
https://elixir.bootlin.com/linux/v6.2.2/source/drivers/gpio/gpio-pl061.c#L333

Someone suggested this driver as good example in some of these earlier
interminable threads. The source code for it is in our Rust-for-Linux
rust branch.

> > Lina: Rewrote commit message, dropped the Amba bits, and squashed in
> > simple changes to the core Device code from latter commits in
> > rust-for-linux/rust. Also include the rust_helper_dev_get_drvdata
> > helper which will be needed by consumers later on anyway.
> >
> > Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> > Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> > Signed-off-by: Asahi Lina <lina@asahilina.net>
> > ---
> >  rust/helpers.c        | 13 +++++++++
> >  rust/kernel/device.rs | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 88 insertions(+), 1 deletion(-)
> >
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 04b9be46e887..54954fd80c77 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -20,6 +20,7 @@
> >
> >  #include <linux/bug.h>
> >  #include <linux/build_bug.h>
> > +#include <linux/device.h>
> >  #include <linux/err.h>
> >  #include <linux/refcount.h>
> >
> > @@ -65,6 +66,18 @@ long rust_helper_PTR_ERR(__force const void *ptr)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
> >
> > +void *rust_helper_dev_get_drvdata(struct device *dev)
> > +{
> > +     return dev_get_drvdata(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_dev_get_drvdata);
>
> No matching dev_set_drvdata()?  What good is getting a random void
> pointer if you couldn't set it in the first place?  :)
>
> > +const char *rust_helper_dev_name(const struct device *dev)
> > +{
> > +     return dev_name(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_dev_name);
>
> Again, why?  What is going to use this?
>
> And I don't really understand the rules you are putting on the name
> string after calling this, more below:
>
> > +
> >  /*
> >   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> >   * as the Rust `usize` type, so we can use it in contexts where Rust
> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> > index 9be021e393ca..e57da622d817 100644
> > --- a/rust/kernel/device.rs
> > +++ b/rust/kernel/device.rs
> > @@ -4,7 +4,7 @@
> >  //!
> >  //! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
> >
> > -use crate::bindings;
> > +use crate::{bindings, str::CStr};
> >
> >  /// A raw device.
> >  ///
> > @@ -20,4 +20,78 @@ use crate::bindings;
> >  pub unsafe trait RawDevice {
> >      /// Returns the raw `struct device` related to `self`.
> >      fn raw_device(&self) -> *mut bindings::device;
> > +
> > +    /// Returns the name of the device.
> > +    fn name(&self) -> &CStr {
> > +        let ptr = self.raw_device();
> > +
> > +        // SAFETY: `ptr` is valid because `self` keeps it alive.
> > +        let name = unsafe { bindings::dev_name(ptr) };
> > +
> > +        // SAFETY: The name of the device remains valid while it is alive (because the device is
> > +        // never renamed, per the safety requirement of this trait). This is guaranteed to be the
> > +        // case because the reference to `self` outlives the one of the returned `CStr` (enforced
> > +        // by the compiler because of their lifetimes).
> > +        unsafe { CStr::from_char_ptr(name) }
>
> Why can the device never be renamed?  Devices are renamed all the time,
> sometimes when you least expect it (i.e. by userspace).  So how is this
> considered "safe"? and actually correct?
>
> Again, maybe seeing a real user of this might make more sense, but
> as-is, this feels wrong and not needed at all.

This requirement is to allow callers to use the string without having
to make a copy of it.

If subsystems/buses are not following what the C documentation says,
as you point out in another thread, we have a several options: (a)
remove access to names altogether, (b) leave things as they are, then
those subsystems wouldn't be able to honour the safety requirements of
this trait therefore they wouldn't implement it, (c) make a copy of
the string, etc.

Since we don't have immediate plans to upstream the pl061 driver, I
think we should just remove the name functionality for now and revisit
it later if the need arises.

>
> > +    }
> > +}
> > +
> > +/// A ref-counted device.
> > +///
> > +/// # Invariants
> > +///
> > +/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
> > +/// `self`, and will be decremented when `self` is dropped.
> > +pub struct Device {
> > +    pub(crate) ptr: *mut bindings::device,
> > +}
> > +
> > +// SAFETY: `Device` only holds a pointer to a C device, which is safe to be used from any thread.
> > +unsafe impl Send for Device {}
> > +
> > +// SAFETY: `Device` only holds a pointer to a C device, references to which are safe to be used
> > +// from any thread.
> > +unsafe impl Sync for Device {}
> > +
> > +impl Device {
> > +    /// Creates a new device instance.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
> > +    pub unsafe fn new(ptr: *mut bindings::device) -> Self {
> > +        // SAFETY: By the safety requirements, ptr is valid and its refcounted will be incremented.
> > +        unsafe { bindings::get_device(ptr) };
>
> You don't check the return value of get_device()?  What if it failed
> (hint, it can)?

I think this was already discussed, but anyway: the caller owns a
reference to this device, so `get_device`  is safe to call and cannot
fail.

Note that `get_device` calls `kobject_get`, which doesn't fail. I
suppose you're hinting at `kobject_get_unless_zero`, which of course
can fail but isn't in use here.

>
> > +        // INVARIANT: The safety requirements satisfy all but one invariant, which is that `self`
> > +        // owns a reference. This is satisfied by the call to `get_device` above.
> > +        Self { ptr }
> > +    }
> > +
> > +    /// Creates a new device instance from an existing [`RawDevice`] instance.
> > +    pub fn from_dev(dev: &dyn RawDevice) -> Self {
>
> I am a rust newbie, but I don't understand this "RawDevice" here at all.

Different buses will have their own Rust "Device" type, for example,
pci::Device, amba::Device, platform::Device that wrap their C
counterparts pci_dev, amba_device, platform_device.

"RawDevice" is a trait for functionality that is common to all
devices. It exposes the "struct device" of each bus/subsystem so that
functions that work on any "struct device", for example, `clk_get`,
`pr_info`. will automatically work on all subsystems.

For example, as part writing Rust abstractions for a platform devices,
we have a platform::Device type, which is wrapper around `struct
platform_device`. It has a bunch of associated functions that do
things that are specific to the platform bus. But then they also
implement the `RawDevice` trait (by implementing `raw_device` that
returns &pdev->dev), which allows drivers to call `clk_get` and the
printing functions directly.

Let's say `pdev` is a platform device; if we wanted to call `clk_get`
in C, we'd do something like:

clk = clk_get(&pdev->dev, NULL);

In Rust, we'd do:

clk = pdev.clk_get(None);

(Note that we didn't have to know that pdev had a field whose type is
a `struct device` that we could use to call clk_get on; `RawDevice`
encoded this information.)

Does the intent of the abstraction make sense to you now?

> > +        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
> > +        // requirements.
> > +        unsafe { Self::new(dev.raw_device()) }
> > +    }
> > +}
> > +
> > +// SAFETY: The device returned by `raw_device` is the one for which we hold a reference.
> > +unsafe impl RawDevice for Device {
> > +    fn raw_device(&self) -> *mut bindings::device {
> > +        self.ptr
> > +    }
>
> What does this raw device do?  What is the relationship to a "real"
> device?  Maybe it's just my lack of rust knowledge here showing, so any
> hints would be appreciated.
>

This is the function that returns the `struct device` field embedded
in the different devices for each bus.

> > +}
> > +
> > +impl Drop for Device {
> > +    fn drop(&mut self) {
> > +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> > +        // relinquish it now.
> > +        unsafe { bindings::put_device(self.ptr) };
>
> So it is now ok for this to be freed?
>
> One meta-comment, why is any of this needed at all?  No driver should
> ever be dealing with a "raw" struct device pointer at all, right?  They
> should be calling into subsystems that give it a pointer to a
> bus-specific pointer type (gpio, usb, pci, etc.)
>
> So I'm thinking that adding support for "raw" struct device pointers
> feels ripe for abuse in a "the code should not be doing that" type of
> thing.
>
> Unless you are writing a new bus/class in rust?

Drivers will not use this directly. They'll benefit from it as I
described above to be able to call bus-agnostic functions.

Implementers of bus abstractions will use this to say "my device also
has a `struct device` in it, and I want it to benefit from all
bus-agnostic device manipulation functions".

Implementers of abstractions of bus-agnostic device functions will add
their abstractions to `RawDevice` instead of bus-specific types so
that they work with all devices.

Cheers,
-Wedson
