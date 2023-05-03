Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFFE6F580A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:38:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjECMim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjECMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:38:39 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437964224;
        Wed,  3 May 2023 05:38:34 -0700 (PDT)
Date:   Wed, 03 May 2023 12:38:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1683117511; x=1683376711;
        bh=y5GsLDkv+seeh4vnGPqOR3n2rVIFisoH/G0vmDt1tLQ=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=LdJES8UkVI1ckkqj+7B5LMGE7OfXXSVpy1P/xs/y0A1SM6x5+KTPi8EYveSWM6Ibu
         OD0G7zymU+zIZdP02AJ6jTK8LttVTWZdiVcwrpGSCZi19a+2KQTdQY9DNIXMLLqqTP
         5wzEk4BruW177CB45tf/eDZ93z+PddBoJm7GV5t+t5cjmVIkRo3N3MGq6BVeuMcW61
         ztZd0k0jRTRTVhxBaB5ydWEBPcOrlyw3znfsumcoKqkca+jaNG2+w/0fvNvscdaNVT
         lVJ8f6sCEN0hclggvaKoRPyQv7tTnZgrB4UB1BNb7XW+PF3c5Sv4oWhrpbO0LUGKa+
         mMtNmfi/5Pv6g==
To:     Benno Lossin <benno.lossin@proton.me>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Andreas Hindborg <nmi@metaspace.dk>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <kbusch@kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.de>,
        lsf-pc@lists.linux-foundation.org, rust-for-linux@vger.kernel.org,
        linux-block@vger.kernel.org,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, gost.dev@samsung.com
Subject: Re: [RFC PATCH 02/11] rust: add `pages` module for handling page allocation
Message-ID: <LDtgXi9Js_rS954DPc4jHhcMzBbAvl4GfdC8w3QE_OYv7KvdZ0Miyn4Qxj-tclIHwpS924DyXpSLEZUK9KAOulD-dzRIO0krtrttnky1orU=@proton.me>
In-Reply-To: <LENFIdWyfQLEP0OtqLWgW9LAr7dW5BruyHO-G8RurzAJCEDkVkQgds9_pzJ5I98qpnrunvFixdiHQtSwa04CgxEBFlISAHz8_q-C28j_f6o=@proton.me>
References: <20230503090708.2524310-1-nmi@metaspace.dk> <20230503090708.2524310-3-nmi@metaspace.dk> <LENFIdWyfQLEP0OtqLWgW9LAr7dW5BruyHO-G8RurzAJCEDkVkQgds9_pzJ5I98qpnrunvFixdiHQtSwa04CgxEBFlISAHz8_q-C28j_f6o=@proton.me>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS,TO_EQ_FM_DIRECT_MX,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry, forgot to replace `> #@` with nothing. Fixed here:

On 03.05.23 11:06, Andreas Hindborg wrote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>
> This patch adds support for working with pages of order 0. Support for pa=
ges
> with higher order is deferred. Page allocation flags are fixed in this pa=
tch.
> Future work might allow the user to specify allocation flags.
>
> This patch is a heavily modified version of code available in the rust tr=
ee [1],
> primarily adding support for multiple page mapping strategies.
>
> [1] https://github.com/rust-for-Linux/linux/tree/bc22545f38d74473cfef3e9f=
d65432733435b79f/rust/kernel/pages.rs
>
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/helpers.c       |  31 +++++
>  rust/kernel/lib.rs   |   6 +
>  rust/kernel/pages.rs | 284 +++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 321 insertions(+)
>  create mode 100644 rust/kernel/pages.rs
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 5dd5e325b7cc..9bd9d95da951 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -27,6 +27,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/wait.h>
>  #include <linux/radix-tree.h>
> +#include <linux/highmem.h>
>
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -150,6 +151,36 @@ void **rust_helper_radix_tree_next_slot(void **slot,
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_radix_tree_next_slot);
>
> +void *rust_helper_kmap(struct page *page)
> +{
> +=09return kmap(page);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kmap);
> +
> +void rust_helper_kunmap(struct page *page)
> +{
> +=09return kunmap(page);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunmap);
> +
> +void *rust_helper_kmap_atomic(struct page *page)
> +{
> +=09return kmap_atomic(page);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kmap_atomic);
> +
> +void rust_helper_kunmap_atomic(void *address)
> +{
> +=09kunmap_atomic(address);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_kunmap_atomic);
> +
> +struct page *rust_helper_alloc_pages(gfp_t gfp_mask, unsigned int order)
> +{
> +=09return alloc_pages(gfp_mask, order);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_alloc_pages);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` =
type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index a85cb6aae8d6..8bef6686504b 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -38,6 +38,7 @@ mod build_assert;
>  pub mod error;
>  pub mod init;
>  pub mod ioctl;
> +pub mod pages;
>  pub mod prelude;
>  pub mod print;
>  pub mod radix_tree;
> @@ -57,6 +58,11 @@ pub use uapi;
>  #[doc(hidden)]
>  pub use build_error::build_error;
>
> +/// Page size defined in terms of the `PAGE_SHIFT` macro from C.

`PAGE_SHIFT` is not using a doc-link.

> +///
> +/// [`PAGE_SHIFT`]: ../../../include/asm-generic/page.h
> +pub const PAGE_SIZE: u32 =3D 1 << bindings::PAGE_SHIFT;

This should be of type `usize`.

> +
>  /// Prefix to appear before log messages printed from within the `kernel=
` crate.
>  const __LOG_PREFIX: &[u8] =3D b"rust_kernel\0";
>
> diff --git a/rust/kernel/pages.rs b/rust/kernel/pages.rs
> new file mode 100644
> index 000000000000..ed51b053dd5d
> --- /dev/null
> +++ b/rust/kernel/pages.rs
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Kernel page allocation and management.
> +//!
> +//! This module currently provides limited support. It supports pages of=
 order 0
> +//! for most operations. Page allocation flags are fixed.
> +
> +use crate::{bindings, error::code::*, error::Result, PAGE_SIZE};
> +use core::{marker::PhantomData, ptr};
> +
> +/// A set of physical pages.
> +///
> +/// `Pages` holds a reference to a set of pages of order `ORDER`. Having=
 the order as a generic
> +/// const allows the struct to have the same size as a pointer.

I would remove the 'Having the order as a...' sentence. Since that is
just implementation detail.

> +///
> +/// # Invariants
> +///
> +/// The pointer `Pages::pages` is valid and points to 2^ORDER pages.

`Pages::pages` -> `pages`.

> +pub struct Pages<const ORDER: u32> {
> +    pub(crate) pages: *mut bindings::page,
> +}
> +
> +impl<const ORDER: u32> Pages<ORDER> {
> +    /// Allocates a new set of contiguous pages.
> +    pub fn new() -> Result<Self> {
> +        let pages =3D unsafe {
> +            bindings::alloc_pages(
> +                bindings::GFP_KERNEL | bindings::__GFP_ZERO | bindings::=
___GFP_HIGHMEM,
> +                ORDER,
> +            )
> +        };

Missing `SAFETY` comment.

> +        if pages.is_null() {
> +            return Err(ENOMEM);
> +        }
> +        // INVARIANTS: We checked that the allocation above succeeded.
> +        // SAFETY: We allocated pages above
> +        Ok(unsafe { Self::from_raw(pages) })
> +    }
> +
> +    /// Create a `Pages` from a raw `struct page` pointer
> +    ///
> +    /// # Safety
> +    ///
> +    /// Caller must own the pages pointed to by `ptr` as these will be f=
reed
> +    /// when the returned `Pages` is dropped.
> +    pub unsafe fn from_raw(ptr: *mut bindings::page) -> Self {
> +        Self { pages: ptr }
> +    }
> +}
> +
> +impl Pages<0> {
> +    #[inline(always)]

Is this really needed? I think this function should be inlined
automatically.

> +    fn check_offset_and_map<I: MappingInfo>(
> +        &self,
> +        offset: usize,
> +        len: usize,
> +    ) -> Result<PageMapping<'_, I>>
> +    where
> +        Pages<0>: MappingActions<I>,

Why not use `Self: MappingActions<I>`?

> +    {
> +        let end =3D offset.checked_add(len).ok_or(EINVAL)?;
> +        if end as u32 > PAGE_SIZE {

Remove the `as u32`, since `PAGE_SIZE` should be of type `usize`.

> +            return Err(EINVAL);

I think it would make sense to create a more descriptive Rust error with
a `From` impl to turn it into an `Error`. It always is better to know from
the signature what exactly can go wrong when calling a function.

> +        }
> +
> +        let mapping =3D <Self as MappingActions<I>>::map(self);
> +
> +        Ok(mapping)

I would merge these lines.

> +    }
> +
> +    #[inline(always)]
> +    unsafe fn read_internal<I: MappingInfo>(

Missing `# Safety` section.

> +        &self,
> +        dest: *mut u8,
> +        offset: usize,
> +        len: usize,
> +    ) -> Result
> +    where
> +        Pages<0>: MappingActions<I>,
> +    {
> +        let mapping =3D self.check_offset_and_map::<I>(offset, len)?;
> +
> +        unsafe { ptr::copy_nonoverlapping((mapping.ptr as *mut u8).add(o=
ffset), dest, len) };

Missing `SAFETY` comment. Replace `as *mut u8` with `.cast::<u8>()`.

> +        Ok(())
> +    }
> +
> +    /// Maps the pages and reads from them into the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the destination buffer is valid for the=
 given
> +    /// length. Additionally, if the raw buffer is intended to be recast=
, they
> +    /// must ensure that the data can be safely cast;
> +    /// [`crate::io_buffer::ReadableFromBytes`] has more details about i=
t.
> +    /// `dest` may not point to the source page.

- `dest` is valid for writes for `len`.
- What is meant by 'the raw buffer is intended to be recast'?
- `io_buffer` does not yet exist in `rust-next`.

> +    #[inline(always)]
> +    pub unsafe fn read(&self, dest: *mut u8, offset: usize, len: usize) =
-> Result {
> +        unsafe { self.read_internal::<NormalMappingInfo>(dest, offset, l=
en) }

Missing `SAFETY` comment.

> +    }
> +
> +    /// Maps the pages and reads from them into the given buffer. The pa=
ge is
> +    /// mapped atomically.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the destination buffer is valid for the=
 given
> +    /// length. Additionally, if the raw buffer is intended to be recast=
, they
> +    /// must ensure that the data can be safely cast;
> +    /// [`crate::io_buffer::ReadableFromBytes`] has more details about i=
t.
> +    /// `dest` may not point to the source page.
> +    #[inline(always)]
> +    pub unsafe fn read_atomic(&self, dest: *mut u8, offset: usize, len: =
usize) -> Result {
> +        unsafe { self.read_internal::<AtomicMappingInfo>(dest, offset, l=
en) }

Missing `SAFETY` comment.

> +    }
> +
> +    #[inline(always)]
> +    unsafe fn write_internal<I: MappingInfo>(

Missing `# Safety` section.

> +        &self,
> +        src: *const u8,
> +        offset: usize,
> +        len: usize,
> +    ) -> Result
> +    where
> +        Pages<0>: MappingActions<I>,
> +    {
> +        let mapping =3D self.check_offset_and_map::<I>(offset, len)?;
> +
> +        unsafe { ptr::copy_nonoverlapping(src, (mapping.ptr as *mut u8).=
add(offset), len) };

Missing `SAFETY` comment.

> +        Ok(())
> +    }
> +
> +    /// Maps the pages and writes into them from the given buffer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the buffer is valid for the given lengt=
h.
> +    /// Additionally, if the page is (or will be) mapped by userspace, t=
hey must
> +    /// ensure that no kernel data is leaked through padding if it was c=
ast from
> +    /// another type; [`crate::io_buffer::WritableToBytes`] has more det=
ails
> +    /// about it. `src` must not point to the destination page.

`src` is valid for reads for `len`.

> +    #[inline(always)]
> +    pub unsafe fn write(&self, src: *const u8, offset: usize, len: usize=
) -> Result {
> +        unsafe { self.write_internal::<NormalMappingInfo>(src, offset, l=
en) }
> +    }
> +
> +    /// Maps the pages and writes into them from the given buffer. The p=
age is
> +    /// mapped atomically.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the buffer is valid for the given lengt=
h.
> +    /// Additionally, if the page is (or will be) mapped by userspace, t=
hey must
> +    /// ensure that no kernel data is leaked through padding if it was c=
ast from
> +    /// another type; [`crate::io_buffer::WritableToBytes`] has more det=
ails
> +    /// about it. `src` must not point to the destination page.
> +    #[inline(always)]
> +    pub unsafe fn write_atomic(&self, src: *const u8, offset: usize, len=
: usize) -> Result {
> +        unsafe { self.write_internal::<AtomicMappingInfo>(src, offset, l=
en) }
> +    }
> +
> +    /// Maps the page at index 0.
> +    #[inline(always)]
> +    pub fn kmap(&self) -> PageMapping<'_, NormalMappingInfo> {
> +        let ptr =3D unsafe { bindings::kmap(self.pages) };

Missing `SAFETY` comment.

> +
> +        PageMapping {
> +            page: self.pages,
> +            ptr,
> +            _phantom: PhantomData,
> +            _phantom2: PhantomData,
> +        }
> +    }
> +
> +    /// Atomically Maps the page at index 0.
> +    #[inline(always)]
> +    pub fn kmap_atomic(&self) -> PageMapping<'_, AtomicMappingInfo> {
> +        let ptr =3D unsafe { bindings::kmap_atomic(self.pages) };

Missing `SAFETY` comment.

> +
> +        PageMapping {
> +            page: self.pages,
> +            ptr,
> +            _phantom: PhantomData,
> +            _phantom2: PhantomData,
> +        }
> +    }
> +}
> +
> +impl<const ORDER: u32> Drop for Pages<ORDER> {
> +    fn drop(&mut self) {
> +        // SAFETY: By the type invariants, we know the pages are allocat=
ed with the given order.
> +        unsafe { bindings::__free_pages(self.pages, ORDER) };
> +    }
> +}
> +
> +/// Specifies the type of page mapping
> +pub trait MappingInfo {}
> +
> +/// Encapsulates methods to map and unmap pages
> +pub trait MappingActions<I: MappingInfo>
> +where
> +    Pages<0>: MappingActions<I>,
> +{
> +    /// Map a page into the kernel address scpace

Typo.

> +    fn map(pages: &Pages<0>) -> PageMapping<'_, I>;
> +
> +    /// Unmap a page specified by `mapping`
> +    ///
> +    /// # Safety
> +    ///
> +    /// Must only be called by `PageMapping::drop()`.
> +    unsafe fn unmap(mapping: &PageMapping<'_, I>);
> +}
> +
> +/// A type state indicating that pages were mapped atomically
> +pub struct AtomicMappingInfo;
> +impl MappingInfo for AtomicMappingInfo {}
> +
> +/// A type state indicating that pages were not mapped atomically
> +pub struct NormalMappingInfo;
> +impl MappingInfo for NormalMappingInfo {}
> +
> +impl MappingActions<AtomicMappingInfo> for Pages<0> {
> +    #[inline(always)]
> +    fn map(pages: &Pages<0>) -> PageMapping<'_, AtomicMappingInfo> {
> +        pages.kmap_atomic()
> +    }
> +
> +    #[inline(always)]
> +    unsafe fn unmap(mapping: &PageMapping<'_, AtomicMappingInfo>) {
> +        // SAFETY: An instance of `PageMapping` is created only when `km=
ap` succeeded for the given
> +        // page, so it is safe to unmap it here.
> +        unsafe { bindings::kunmap_atomic(mapping.ptr) };
> +    }
> +}
> +
> +impl MappingActions<NormalMappingInfo> for Pages<0> {
> +    #[inline(always)]
> +    fn map(pages: &Pages<0>) -> PageMapping<'_, NormalMappingInfo> {
> +        pages.kmap()
> +    }
> +
> +    #[inline(always)]
> +    unsafe fn unmap(mapping: &PageMapping<'_, NormalMappingInfo>) {
> +        // SAFETY: An instance of `PageMapping` is created only when `km=
ap` succeeded for the given
> +        // page, so it is safe to unmap it here.
> +        unsafe { bindings::kunmap(mapping.page) };
> +    }
> +}

I am not sure if this is the best implementation, why do the `kmap` and
`kmap_atomic` functions exist? Would it not make sense to implement
them entirely in `MappingActions::map`?

> +
> +/// An owned page mapping. When this struct is dropped, the page is unma=
pped.
> +pub struct PageMapping<'a, I: MappingInfo>
> +where
> +    Pages<0>: MappingActions<I>,
> +{
> +    page: *mut bindings::page,
> +    ptr: *mut core::ffi::c_void,
> +    _phantom: PhantomData<&'a i32>,
> +    _phantom2: PhantomData<I>,
> +}
> +
> +impl<'a, I: MappingInfo> PageMapping<'a, I>
> +where
> +    Pages<0>: MappingActions<I>,
> +{
> +    /// Return a pointer to the wrapped `struct page`
> +    #[inline(always)]
> +    pub fn get_ptr(&self) -> *mut core::ffi::c_void {
> +        self.ptr
> +    }
> +}
> +
> +// Because we do not have Drop specialization, we have to do this dance.=
 Life
> +// would be much more simple if we could have `impl Drop for PageMapping=
<'_,
> +// Atomic>` and `impl Drop for PageMapping<'_, NotAtomic>`
> +impl<I: MappingInfo> Drop for PageMapping<'_, I>
> +where
> +    Pages<0>: MappingActions<I>,
> +{
> +    #[inline(always)]
> +    fn drop(&mut self) {
> +        // SAFETY: We are OK to call this because we are `PageMapping::d=
rop()`
> +        unsafe { <Pages<0> as MappingActions<I>>::unmap(self) }
> +    }
> +}
> --
> 2.40.0

Here are some more general things:
- I think we could use this as an opportunity to add more docs about how
  paging works, or at least add some links to the C documentation.
- Can we improve the paging API? I have not given it any thought yet, but
  the current API looks very primitive.
- Documentation comments should form complete sentences (so end with `.`).

--
Cheers,
Benno

