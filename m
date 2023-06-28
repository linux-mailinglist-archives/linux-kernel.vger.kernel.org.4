Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1068740E56
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbjF1KL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:11:26 -0400
Received: from mail-40133.protonmail.ch ([185.70.40.133]:32535 "EHLO
        mail-40133.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbjF1KH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 06:07:29 -0400
Date:   Wed, 28 Jun 2023 10:07:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687946847; x=1688206047;
        bh=UpZHWzsrfNOLqeOc1z4tKkV+9JnbzntAZiSfSVgKJds=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=WWBEUpjfy75Uxk8GAx5C0EFChHGNBbGq3pllIPKpzGJdokO/LzfL5O7OOH1/zSz+4
         NkX7fIpdIOwIRZWA2KwUN1r1KUviDJ+IcMwb89iqoctXo26uySsaa+0gL4+2/DCFH4
         jAfOy6Sw5q4tQmExR8yTqTkXIoQUy8tbrvIhSLWlMsOvUnAxRSNxRHWpfthSPzqkJE
         zEhQJFRXodhR8gMxBx5jKIvpjcsK37gxpBpTgDe/6KteNAFCwKYw7EoCBfT2mcOshW
         mvYXEY964fWrzTRL11XPRtE09O8iX6AePBlnEBj6EXjAtsgMyTvKKzFJDnYCD0UDzP
         YJ/SD6KgnZ9aA==
To:     Boqun Feng <boqun.feng@gmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2] rust: alloc: Add realloc and alloc_zeroed to the GlobalAlloc impl
Message-ID: <ffYDfWJfSkQZnT-rW-AJ2S8KyMvWqSzuqHVEFiMEJAz0EzRbuwllUKKOV-evQpo6XA8aoeCpuF6Wjh5cLRJQyz1CyO9LeT0olkZhcH5y5P4=@proton.me>
In-Reply-To: <20230625232528.89306-1-boqun.feng@gmail.com>
References: <20230625232528.89306-1-boqun.feng@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.23 01:25, Boqun Feng wrote:
> While there are default impls for these methods, using the respective C
> api's is faster. Currently neither the existing nor these new
> GlobalAlloc method implementations are actually called. Instead the
> __rust_* function defined below the GlobalAlloc impl are used. With
> rustc 1.71 these functions will be gone and all allocation calls will go
> through the GlobalAlloc implementation.
>=20
> Link: https://github.com/Rust-for-Linux/linux/issues/68
> Signed-off-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>
> [boqun: add size adjustment for alignment requirement]
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> Miguel, I fold my diff into Bj=C3=B6rn's original patch and make a v2, it
> relies on the other patch:
>=20
> =09https://lore.kernel.org/rust-for-linux/6e61f06f-2411-0bcb-926b-0a69270=
96f20@gmail.com/
>=20
> So this v2 (if all goes well) is targeted for v6.6, JFYI.
>=20
> v1 -> v2:
>=20
> *=09Add size adjustment for align requirement.
>=20
>   rust/kernel/allocator.rs | 59 ++++++++++++++++++++++++++++++++++++----
>   1 file changed, 54 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/allocator.rs b/rust/kernel/allocator.rs
> index 66575cf87ce2..af723c2924dc 100644
> --- a/rust/kernel/allocator.rs
> +++ b/rust/kernel/allocator.rs
> @@ -9,8 +9,17 @@
>=20
>   struct KernelAllocator;
>=20
> -unsafe impl GlobalAlloc for KernelAllocator {
> -    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +impl KernelAllocator {
> +    /// # Safety
> +    ///
> +    /// * `ptr` can be either null or a pointer which has been allocated=
 by this allocator.
> +    /// * `layout` must have a non-zero size.
> +    unsafe fn krealloc_with_flags(
> +        &self,
> +        ptr: *mut u8,
> +        layout: Layout,
> +        flags: bindings::gfp_t,
> +    ) -> *mut u8 {
>           // Customized layouts from `Layout::from_size_align()` can have=
 size < align, so pads first.
>           let layout =3D layout.pad_to_align();
>=20
> @@ -26,9 +35,22 @@ unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
>               size =3D size.next_power_of_two();
>           }
>=20
> -        // `krealloc()` is used instead of `kmalloc()` because the latte=
r is
> -        // an inline function and cannot be bound to as a result.
> -        unsafe { bindings::krealloc(ptr::null(), size, bindings::GFP_KER=
NEL) as *mut u8 }
> +        // SAFETY:
> +        //
> +        // * `ptr` is either null or a pointer returned from a previous =
k{re}alloc() by the function
> +        //   safety requirement.
> +        //
> +        // * `size` is greater than 0 since it's either a `layout.size()=
` (which cannot be zero
> +        //    according to the function safety requirement) or a result =
from `next_power_of_two()`.
> +        unsafe { bindings::krealloc(ptr as *const core::ffi::c_void, siz=
e, flags) as *mut u8 }
> +    }
> +}
> +
> +unsafe impl GlobalAlloc for KernelAllocator {
> +    unsafe fn alloc(&self, layout: Layout) -> *mut u8 {
> +        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> +        // requirement.
> +        unsafe { self.krealloc_with_flags(ptr::null_mut(), layout, bindi=
ngs::GFP_KERNEL) }
>       }
>=20
>       unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout) {
> @@ -36,6 +58,33 @@ unsafe fn dealloc(&self, ptr: *mut u8, _layout: Layout=
) {
>               bindings::kfree(ptr as *const core::ffi::c_void);
>           }
>       }
> +
> +    unsafe fn realloc(&self, ptr: *mut u8, layout: Layout, new_size: usi=
ze) -> *mut u8 {
> +        // SAFETY:
> +        // * `new_size` when rounded up to the nearest multiple of `layo=
ut.align()`, will not
> +        //   overflow `isize` by the function safety requirement.
> +        // * `layout.align()` is a proper alignment (i.e. not zero and m=
ust be a power of two).
> +        let layout =3D unsafe { Layout::from_size_align_unchecked(new_si=
ze, layout.align()) };
> +
> +        // SAFETY:
> +        // * `ptr` is either null or a pointer allocated by this allocat=
or by function safety
> +        //   requirement.
> +        // * the size of `layout` is not zero because `new_size` is not =
zero by function safety
> +        //   requirement.
> +        unsafe { self.krealloc_with_flags(ptr, layout, bindings::GFP_KER=
NEL) }
> +    }
> +
> +    unsafe fn alloc_zeroed(&self, layout: Layout) -> *mut u8 {
> +        // SAFETY: `ptr::null_mut()` is null and `layout` has a non-zero=
 size by the function safety
> +        // requirement.
> +        unsafe {
> +            self.krealloc_with_flags(
> +                ptr::null_mut(),
> +                layout,
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO,
> +            )
> +        }
> +    }
>   }
>=20
>   #[global_allocator]
> --
> 2.39.2
> 
