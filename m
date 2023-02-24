Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2522D6A1B4C
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjBXLTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBXLTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:19:21 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A83158B9;
        Fri, 24 Feb 2023 03:19:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 428BECE22A9;
        Fri, 24 Feb 2023 11:19:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D57C433D2;
        Fri, 24 Feb 2023 11:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677237555;
        bh=+iZyNXPSCvcy7/yyvuzg8vpZUHIVsr9o2KUzCN78T5E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkEpopIeJNkKcN2GNXg17J3faj5nzjIaHoMT1x1cCaPYUf6qrP0YinojGYLCAFjJ8
         2uo+idKfu5VeLk9a843ZNZBazaq+XLVDcbPpo8O5GnIPe8iBycTfv3rfn1HjWb0Fuz
         hKp/eGtwdF3N1LnjxuLbLz2i1823tCrIlGrVGSZ4=
Date:   Fri, 24 Feb 2023 12:19:12 +0100
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
Subject: Re: [PATCH 5/5] rust: device: Add a stub abstraction for devices
Message-ID: <Y/idMBIOfFZxXnVM@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224-rust-iopt-rtkit-v1-5-49ced3391295@asahilina.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 07:53:17PM +0900, Asahi Lina wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a Device type which represents an owned reference to a generic
> struct device. This minimal implementation just handles reference
> counting and allows the user to get the device name.

What good is just the device name?  I'm all for proper bindings to hook
up properly to the driver core, but this feels like it's not really
doing much of anything.

Do you have a real user that we can see how this is interacting?

And what does a driver care about the device name anyway?  It should
only be using the dev_*() calls to print that info out to the log, and
never messing around with it in any other format as that's what
userspace expects.

> Lina: Rewrote commit message, dropped the Amba bits, and squashed in
> simple changes to the core Device code from latter commits in
> rust-for-linux/rust. Also include the rust_helper_dev_get_drvdata
> helper which will be needed by consumers later on anyway.
> 
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/helpers.c        | 13 +++++++++
>  rust/kernel/device.rs | 76 ++++++++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 04b9be46e887..54954fd80c77 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -20,6 +20,7 @@
>  
>  #include <linux/bug.h>
>  #include <linux/build_bug.h>
> +#include <linux/device.h>
>  #include <linux/err.h>
>  #include <linux/refcount.h>
>  
> @@ -65,6 +66,18 @@ long rust_helper_PTR_ERR(__force const void *ptr)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
>  
> +void *rust_helper_dev_get_drvdata(struct device *dev)
> +{
> +	return dev_get_drvdata(dev);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_dev_get_drvdata);

No matching dev_set_drvdata()?  What good is getting a random void
pointer if you couldn't set it in the first place?  :)

> +const char *rust_helper_dev_name(const struct device *dev)
> +{
> +	return dev_name(dev);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_dev_name);

Again, why?  What is going to use this?

And I don't really understand the rules you are putting on the name
string after calling this, more below:

> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 9be021e393ca..e57da622d817 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -4,7 +4,7 @@
>  //!
>  //! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
>  
> -use crate::bindings;
> +use crate::{bindings, str::CStr};
>  
>  /// A raw device.
>  ///
> @@ -20,4 +20,78 @@ use crate::bindings;
>  pub unsafe trait RawDevice {
>      /// Returns the raw `struct device` related to `self`.
>      fn raw_device(&self) -> *mut bindings::device;
> +
> +    /// Returns the name of the device.
> +    fn name(&self) -> &CStr {
> +        let ptr = self.raw_device();
> +
> +        // SAFETY: `ptr` is valid because `self` keeps it alive.
> +        let name = unsafe { bindings::dev_name(ptr) };
> +
> +        // SAFETY: The name of the device remains valid while it is alive (because the device is
> +        // never renamed, per the safety requirement of this trait). This is guaranteed to be the
> +        // case because the reference to `self` outlives the one of the returned `CStr` (enforced
> +        // by the compiler because of their lifetimes).
> +        unsafe { CStr::from_char_ptr(name) }

Why can the device never be renamed?  Devices are renamed all the time,
sometimes when you least expect it (i.e. by userspace).  So how is this
considered "safe"? and actually correct?

Again, maybe seeing a real user of this might make more sense, but
as-is, this feels wrong and not needed at all.


> +    }
> +}
> +
> +/// A ref-counted device.
> +///
> +/// # Invariants
> +///
> +/// `ptr` is valid, non-null, and has a non-zero reference count. One of the references is owned by
> +/// `self`, and will be decremented when `self` is dropped.
> +pub struct Device {
> +    pub(crate) ptr: *mut bindings::device,
> +}
> +
> +// SAFETY: `Device` only holds a pointer to a C device, which is safe to be used from any thread.
> +unsafe impl Send for Device {}
> +
> +// SAFETY: `Device` only holds a pointer to a C device, references to which are safe to be used
> +// from any thread.
> +unsafe impl Sync for Device {}
> +
> +impl Device {
> +    /// Creates a new device instance.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that `ptr` is valid, non-null, and has a non-zero reference count.
> +    pub unsafe fn new(ptr: *mut bindings::device) -> Self {
> +        // SAFETY: By the safety requirements, ptr is valid and its refcounted will be incremented.
> +        unsafe { bindings::get_device(ptr) };

You don't check the return value of get_device()?  What if it failed
(hint, it can)?


> +        // INVARIANT: The safety requirements satisfy all but one invariant, which is that `self`
> +        // owns a reference. This is satisfied by the call to `get_device` above.
> +        Self { ptr }
> +    }
> +
> +    /// Creates a new device instance from an existing [`RawDevice`] instance.
> +    pub fn from_dev(dev: &dyn RawDevice) -> Self {

I am a rust newbie, but I don't understand this "RawDevice" here at all.


> +        // SAFETY: The requirements are satisfied by the existence of `RawDevice` and its safety
> +        // requirements.
> +        unsafe { Self::new(dev.raw_device()) }
> +    }
> +}
> +
> +// SAFETY: The device returned by `raw_device` is the one for which we hold a reference.
> +unsafe impl RawDevice for Device {
> +    fn raw_device(&self) -> *mut bindings::device {
> +        self.ptr
> +    }

What does this raw device do?  What is the relationship to a "real"
device?  Maybe it's just my lack of rust knowledge here showing, so any
hints would be appreciated.

> +}
> +
> +impl Drop for Device {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we know that `self` owns a reference, so it is safe to
> +        // relinquish it now.
> +        unsafe { bindings::put_device(self.ptr) };

So it is now ok for this to be freed?

One meta-comment, why is any of this needed at all?  No driver should
ever be dealing with a "raw" struct device pointer at all, right?  They
should be calling into subsystems that give it a pointer to a
bus-specific pointer type (gpio, usb, pci, etc.)

So I'm thinking that adding support for "raw" struct device pointers
feels ripe for abuse in a "the code should not be doing that" type of
thing.

Unless you are writing a new bus/class in rust?

thanks,

greg k-h
