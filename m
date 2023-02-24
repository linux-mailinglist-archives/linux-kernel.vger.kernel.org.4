Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9750E6A1B5B
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBXLXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjBXLXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 06:23:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A147013517;
        Fri, 24 Feb 2023 03:23:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A1366173C;
        Fri, 24 Feb 2023 11:23:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245A5C433EF;
        Fri, 24 Feb 2023 11:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1677237829;
        bh=YWMHxEgZ8at03Pj0xQ2ZWGalNQEx8KUOPYy67J9pBPI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ox8QGMv0NVgAoeYGSa3oQgURAah4bZhQ4qINGDI1RheK2DEwgvgS3fNlwf6B1lc8J
         pfMb+Gj3ivdnBwGYYV7lNSyVnkzbecN7p5auB+UYkSjQbs+fPZV4Dz0xyfEJsOCJi5
         /l3BtIDSC+4OnGzwRPZyACE33rMWrork8bMnLV+M=
Date:   Fri, 24 Feb 2023 12:23:47 +0100
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
Message-ID: <Y/ieQ0UX/niAG1Hg@kroah.com>
References: <20230224-rust-iopt-rtkit-v1-0-49ced3391295@asahilina.net>
 <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230224-rust-iopt-rtkit-v1-2-49ced3391295@asahilina.net>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 07:53:14PM +0900, Asahi Lina wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Add a RawDevice trait which can be implemented by any type representing
> a device class (such as a PlatformDevice). This is the minimum amount of
> Device support code required to unblock abstractions that need to take
> device pointers.
> 
> Lina: Rewrote commit message, and dropped everything except RawDevice.
> 
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> ---
>  rust/bindings/bindings_helper.h |  1 +
>  rust/kernel/device.rs           | 23 +++++++++++++++++++++++
>  rust/kernel/lib.rs              |  1 +
>  3 files changed, 25 insertions(+)
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 75d85bd6c592..3632a39a28a6 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -6,6 +6,7 @@
>   * Sorted alphabetically.
>   */
>  
> +#include <linux/device.h>
>  #include <linux/slab.h>
>  #include <linux/refcount.h>
>  
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> new file mode 100644
> index 000000000000..9be021e393ca
> --- /dev/null
> +++ b/rust/kernel/device.rs
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic devices that are part of the kernel's driver model.
> +//!
> +//! C header: [`include/linux/device.h`](../../../../include/linux/device.h)
> +
> +use crate::bindings;
> +
> +/// A raw device.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that the `*mut device` returned by [`RawDevice::raw_device`] is
> +/// related to `self`, that is, actions on it will affect `self`. For example, if one calls
> +/// `get_device`, then the refcount on the device represented by `self` will be incremented.

What is a "implementer" here?  Rust code?  C code?  Who is calling
get_device() here, rust code or the driver code or something else?  How
are you matching up the reference logic of this structure with the fact
that the driver core actually owns the reference, not any rust code?


> +///
> +/// Additionally, implementers must ensure that the device is never renamed. Commit a5462516aa99
> +/// ("driver-core: document restrictions on device_rename()") has details on why `device_rename`
> +/// should not be used.

As much as I would have liked that, that commit was from 2010 and
device_rename() is still being used by some pretty large subsystems
(networking and IB) and I don't see that going away any year soon.

So yes, your device will be renamed, so don't mess with the device name
like I mentioned in review of path 5/5 in this series.

> +pub unsafe trait RawDevice {
> +    /// Returns the raw `struct device` related to `self`.
> +    fn raw_device(&self) -> *mut bindings::device;

Again, what prevents this device from going away?  I don't see a call to
get_device() here :(

And again, why are bindings needed for a "raw" struct device at all?
Shouldn't the bus-specific wrappings work better?

thanks,

greg k-h
