Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DF7C6FB0B4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 14:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbjEHM7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 08:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjEHM7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 08:59:06 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9272535D8D
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 05:58:59 -0700 (PDT)
Date:   Mon, 08 May 2023 12:58:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1683550737; x=1683809937;
        bh=BluAfUkptjoDzZo7Eg121LZmkzey8cfOy9NzYMZPt0Y=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=AguKqKWk3fxm4RzGwpxqYJ+Elbe6zzaVADUvFphs4BnVGIEnorHv45D15DtU2wU7K
         ffRj0FWuoy30ty9KrVj/YD1FZwSIToCmgnNoaQOT1R47wAKrpyRL8cbOwzdVpDBbP5
         BoM6KRAcc1Mh/xR8yP+REaG96lfhIhv412sB8ULr1sMz/LTj9L4IM4fOyTpam81f/0
         MX8tsJaibZwgGocdooxfp1PGi5HU5/rw9Kxh1oSkzupSt2kKzgDtYo4+R9QzNeqCmM
         q8rQ2EvRtCAz7JvUDWWYFbBKgVy/tYeSVFVw5mqfOBxM+LOjYCXq8YrTjCC4ewb2H+
         fycvF92iaOzGw==
To:     Andreas Hindborg <nmi@metaspace.dk>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
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
Subject: Re: [RFC PATCH 04/11] rust: block: introduce `kernel::block::bio` module
Message-ID: <-SiJ5paRDIUkH1WEWhGhEjhIgFbSo5PJAvac53bTnBZ5o41DR-kNWZEQBsnKeW1FRJh35siVFRrx54L0M6ebSzl0rzecgcDjqZFGRa9uypE=@proton.me>
In-Reply-To: <20230503090708.2524310-5-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk> <20230503090708.2524310-5-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, May 3rd, 2023 at 11:07, Andreas Hindborg <nmi@metaspace.dk> w=
rote:
> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> Add abstractions for working with `struct bio`.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/kernel/block.rs            |   1 +
>  rust/kernel/block/bio.rs        |  93 ++++++++++++++++
>  rust/kernel/block/bio/vec.rs    | 181 ++++++++++++++++++++++++++++++++
>  rust/kernel/block/mq/request.rs |  16 +++
>  4 files changed, 291 insertions(+)
>  create mode 100644 rust/kernel/block/bio.rs
>  create mode 100644 rust/kernel/block/bio/vec.rs
>=20
> diff --git a/rust/kernel/block.rs b/rust/kernel/block.rs
> index 4c93317a568a..1797859551fd 100644
> --- a/rust/kernel/block.rs
> +++ b/rust/kernel/block.rs
> @@ -2,4 +2,5 @@
>=20
>  //! Types for working with the block layer
>=20
> +pub mod bio;
>  pub mod mq;
> diff --git a/rust/kernel/block/bio.rs b/rust/kernel/block/bio.rs
> new file mode 100644
> index 000000000000..6e93e4420105
> --- /dev/null
> +++ b/rust/kernel/block/bio.rs
> @@ -0,0 +1,93 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types for working with the bio layer.
> +//!
> +//! C header: [`include/linux/blk_types.h`](../../include/linux/blk_type=
s.h)
> +
> +use core::fmt;
> +use core::ptr::NonNull;
> +
> +mod vec;
> +
> +pub use vec::BioSegmentIterator;
> +pub use vec::Segment;
> +
> +/// A wrapper around a `struct bio` pointer
> +///
> +/// # Invariants
> +///
> +/// First field must alwyas be a valid pointer to a valid `struct bio`.
> +pub struct Bio<'a>(
> +    NonNull<crate::bindings::bio>,
> +    core::marker::PhantomData<&'a ()>,

Please make this a struct with named fields. Also this is rather a
`BioRef`, right? Why can't `&Bio` be used and `Bio` embeds
`bindings::bio`?

> +);
> +
> +impl<'a> Bio<'a> {
> +    /// Returns an iterator over segments in this `Bio`. Does not consid=
er
> +    /// segments of other bios in this bio chain.
> +    #[inline(always)]

Why are these `inline(always)`? The compiler should inline them
automatically?

> +    pub fn segment_iter(&'a self) -> BioSegmentIterator<'a> {
> +        BioSegmentIterator::new(self)
> +    }
> +
> +    /// Get a pointer to the `bio_vec` off this bio
> +    #[inline(always)]
> +    fn io_vec(&self) -> *const bindings::bio_vec {
> +        // SAFETY: By type invariant, get_raw() returns a valid pointer =
to a
> +        // valid `struct bio`
> +        unsafe { (*self.get_raw()).bi_io_vec }
> +    }
> +
> +    /// Return a copy of the `bvec_iter` for this `Bio`
> +    #[inline(always)]
> +    fn iter(&self) -> bindings::bvec_iter {

Why does this return the bindings iter? Maybe rename to `raw_iter`?

> +        // SAFETY: self.0 is always a valid pointer
> +        unsafe { (*self.get_raw()).bi_iter }
> +    }
> +
> +    /// Get the next `Bio` in the chain
> +    #[inline(always)]
> +    fn next(&self) -> Option<Bio<'a>> {
> +        // SAFETY: self.0 is always a valid pointer
> +        let next =3D unsafe { (*self.get_raw()).bi_next };
> +        Some(Self(NonNull::new(next)?, core::marker::PhantomData))

Missing `INVARIANT` explaining why `next` is valid or null. Also why not
use `Self::from_raw` here?

> +    }
> +
> +    /// Return the raw pointer of the wrapped `struct bio`
> +    #[inline(always)]
> +    fn get_raw(&self) -> *const bindings::bio {
> +        self.0.as_ptr()
> +    }
> +
> +    /// Create an instance of `Bio` from a raw pointer. Does check that =
the
> +    /// pointer is not null.
> +    #[inline(always)]
> +    pub(crate) unsafe fn from_raw(ptr: *mut bindings::bio) -> Option<Bio=
<'a>> {
> +        Some(Self(NonNull::new(ptr)?, core::marker::PhantomData))
> +    }
> +}
> +
> +impl core::fmt::Display for Bio<'_> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        write!(f, "Bio {:?}", self.0.as_ptr())

this will display as `Bio 0x7ff0654..` I think there should be some
symbol wrapping the pointer like `Bio(0x7ff0654)` or `Bio { ptr: 0x7ff0654 =
}`.

> +    }
> +}
> +
> +/// An iterator over `Bio`
> +pub struct BioIterator<'a> {
> +    pub(crate) bio: Option<Bio<'a>>,
> +}
> +
> +impl<'a> core::iter::Iterator for BioIterator<'a> {
> +    type Item =3D Bio<'a>;
> +
> +    #[inline(always)]
> +    fn next(&mut self) -> Option<Bio<'a>> {
> +        if let Some(current) =3D self.bio.take() {
> +            self.bio =3D current.next();
> +            Some(current)
> +        } else {
> +            None
> +        }

Can be rewritten as:
    let current =3D self.bio.take()?;
    self.bio =3D current.next();
    Some(cur)

> +    }
> +}
> diff --git a/rust/kernel/block/bio/vec.rs b/rust/kernel/block/bio/vec.rs
> new file mode 100644
> index 000000000000..acd328a6fe54
> --- /dev/null
> +++ b/rust/kernel/block/bio/vec.rs
> @@ -0,0 +1,181 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Types for working with `struct bio_vec` IO vectors
> +//!
> +//! C header: [`include/linux/bvec.h`](../../include/linux/bvec.h)
> +
> +use super::Bio;
> +use crate::error::Result;
> +use crate::pages::Pages;
> +use core::fmt;
> +use core::mem::ManuallyDrop;
> +
> +#[inline(always)]
> +fn mp_bvec_iter_offset(bvec: *const bindings::bio_vec, iter: &bindings::=
bvec_iter) -> u32 {
> +    (unsafe { (*bvec_iter_bvec(bvec, iter)).bv_offset }) + iter.bi_bvec_=
done
> +}
> +
> +#[inline(always)]
> +fn mp_bvec_iter_page(
> +    bvec: *const bindings::bio_vec,
> +    iter: &bindings::bvec_iter,
> +) -> *mut bindings::page {
> +    unsafe { (*bvec_iter_bvec(bvec, iter)).bv_page }
> +}
> +
> +#[inline(always)]
> +fn mp_bvec_iter_page_idx(bvec: *const bindings::bio_vec, iter: &bindings=
::bvec_iter) -> usize {
> +    (mp_bvec_iter_offset(bvec, iter) / crate::PAGE_SIZE) as usize
> +}
> +
> +#[inline(always)]
> +fn mp_bvec_iter_len(bvec: *const bindings::bio_vec, iter: &bindings::bve=
c_iter) -> u32 {
> +    iter.bi_size
> +        .min(unsafe { (*bvec_iter_bvec(bvec, iter)).bv_len } - iter.bi_b=
vec_done)
> +}
> +
> +#[inline(always)]
> +fn bvec_iter_bvec(
> +    bvec: *const bindings::bio_vec,
> +    iter: &bindings::bvec_iter,
> +) -> *const bindings::bio_vec {
> +    unsafe { bvec.add(iter.bi_idx as usize) }
> +}
> +
> +#[inline(always)]
> +fn bvec_iter_page(
> +    bvec: *const bindings::bio_vec,
> +    iter: &bindings::bvec_iter,
> +) -> *mut bindings::page {
> +    unsafe { mp_bvec_iter_page(bvec, iter).add(mp_bvec_iter_page_idx(bve=
c, iter)) }
> +}
> +
> +#[inline(always)]
> +fn bvec_iter_len(bvec: *const bindings::bio_vec, iter: &bindings::bvec_i=
ter) -> u32 {
> +    mp_bvec_iter_len(bvec, iter).min(crate::PAGE_SIZE - bvec_iter_offset=
(bvec, iter))
> +}
> +
> +#[inline(always)]
> +fn bvec_iter_offset(bvec: *const bindings::bio_vec, iter: &bindings::bve=
c_iter) -> u32 {
> +    mp_bvec_iter_offset(bvec, iter) % crate::PAGE_SIZE
> +}

Why are these functions:
- not marked as `unsafe`?
- undocumented,
- free functions.

Can't these be directly implemented on `Segment<'_>`? If not,
I think we should find some better way or make them `unsafe`.

> +
> +/// A wrapper around a `strutct bio_vec` - a contiguous range of physica=
l memory addresses
> +///
> +/// # Invariants
> +///
> +/// `bio_vec` must always be initialized and valid
> +pub struct Segment<'a> {
> +    bio_vec: bindings::bio_vec,
> +    _marker: core::marker::PhantomData<&'a ()>,
> +}
> +
> +impl Segment<'_> {
> +    /// Get he lenght of the segment in bytes
> +    #[inline(always)]
> +    pub fn len(&self) -> usize {
> +        self.bio_vec.bv_len as usize
> +    }
> +
> +    /// Returns true if the length of the segment is 0
> +    #[inline(always)]
> +    pub fn is_empty(&self) -> bool {
> +        self.len() =3D=3D 0
> +    }
> +
> +    /// Get the offset field of the `bio_vec`
> +    #[inline(always)]
> +    pub fn offset(&self) -> usize {
> +        self.bio_vec.bv_offset as usize
> +    }
> +
> +    /// Copy data of this segment into `page`.
> +    #[inline(always)]
> +    pub fn copy_to_page_atomic(&self, page: &mut Pages<0>) -> Result {
> +        // SAFETY: self.bio_vec is valid and thus bv_page must be a vali=
d
> +        // pointer to a `struct page`. We do not own the page, but we pr=
event
> +        // drop by wrapping the `Pages` in `ManuallyDrop`.
> +        let our_page =3D ManuallyDrop::new(unsafe { Pages::<0>::from_raw=
(self.bio_vec.bv_page) });
> +        let our_map =3D our_page.kmap_atomic();
> +
> +        // TODO: Checck offset is within page - what guarantees does `bi=
o_vec` provide?
> +        let ptr =3D unsafe { (our_map.get_ptr() as *const u8).add(self.o=
ffset()) };
> +
> +        unsafe { page.write_atomic(ptr, self.offset(), self.len()) }
> +    }
> +
> +    /// Copy data from `page` into this segment
> +    #[inline(always)]
> +    pub fn copy_from_page_atomic(&mut self, page: &Pages<0>) -> Result {
> +        // SAFETY: self.bio_vec is valid and thus bv_page must be a vali=
d
> +        // pointer to a `struct page`. We do not own the page, but we pr=
event
> +        // drop by wrapping the `Pages` in `ManuallyDrop`.
> +        let our_page =3D ManuallyDrop::new(unsafe { Pages::<0>::from_raw=
(self.bio_vec.bv_page) });
> +        let our_map =3D our_page.kmap_atomic();
> +
> +        // TODO: Checck offset is within page
> +        let ptr =3D unsafe { (our_map.get_ptr() as *mut u8).add(self.off=
set()) };
> +
> +        unsafe { page.read_atomic(ptr, self.offset(), self.len()) }
> +    }
> +}
> +
> +impl core::fmt::Display for Segment<'_> {
> +    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
> +        write!(
> +            f,
> +            "Segment {:?} len: {}",
> +            self.bio_vec.bv_page, self.bio_vec.bv_len
> +        )
> +    }
> +}
> +
> +/// An iterator over `Segment`
> +pub struct BioSegmentIterator<'a> {
> +    bio: &'a Bio<'a>,
> +    iter: bindings::bvec_iter,
> +}
> +
> +impl<'a> BioSegmentIterator<'a> {
> +    #[inline(always)]
> +    pub(crate) fn new(bio: &'a Bio<'a>) -> BioSegmentIterator<'_> {
> +        Self {
> +            bio,
> +            iter: bio.iter(),
> +        }
> +    }
> +}
> +
> +impl<'a> core::iter::Iterator for BioSegmentIterator<'a> {
> +    type Item =3D Segment<'a>;
> +
> +    #[inline(always)]
> +    fn next(&mut self) -> Option<Self::Item> {
> +        if self.iter.bi_size =3D=3D 0 {
> +            return None;
> +        }
> +
> +        // Macro
> +        // bio_vec =3D bio_iter_iovec(bio, self.iter)
> +        // bio_vec =3D bvec_iter_bvec(bio.bi_io_vec, self.iter);

Weird comment?

> +        let bio_vec_ret =3D bindings::bio_vec {
> +            bv_page: bvec_iter_page(self.bio.io_vec(), &self.iter),
> +            bv_len: bvec_iter_len(self.bio.io_vec(), &self.iter),
> +            bv_offset: bvec_iter_offset(self.bio.io_vec(), &self.iter),
> +        };
> +
> +        // Static C function
> +        unsafe {
> +            bindings::bio_advance_iter_single(
> +                self.bio.get_raw(),
> +                &mut self.iter as *mut bindings::bvec_iter,
> +                bio_vec_ret.bv_len,
> +            )
> +        };
> +
> +        Some(Segment {
> +            bio_vec: bio_vec_ret,
> +            _marker: core::marker::PhantomData,
> +        })
> +    }
> +}
> diff --git a/rust/kernel/block/mq/request.rs b/rust/kernel/block/mq/reque=
st.rs
> index e95ae3fd71ad..ccb1033b64b6 100644
> --- a/rust/kernel/block/mq/request.rs
> +++ b/rust/kernel/block/mq/request.rs
> @@ -11,6 +11,9 @@ use crate::{
>  };
>  use core::marker::PhantomData;
>=20
> +use crate::block::bio::Bio;
> +use crate::block::bio::BioIterator;
> +
>  /// A wrapper around a blk-mq `struct request`. This represents an IO re=
quest.
>  pub struct Request<T: Operations> {
>      ptr: *mut bindings::request,
> @@ -63,6 +66,19 @@ impl<T: Operations> Request<T> {
>          }
>      }
>=20
> +    /// Get a wrapper for the first Bio in this request
> +    #[inline(always)]
> +    pub fn bio(&self) -> Option<Bio<'_>> {
> +        let ptr =3D unsafe { (*self.ptr).bio };
> +        unsafe { Bio::from_raw(ptr) }
> +    }
> +
> +    /// Get an iterator over all bio structurs in this request
> +    #[inline(always)]
> +    pub fn bio_iter(&self) -> BioIterator<'_> {
> +        BioIterator { bio: self.bio() }
> +    }
> +
>      /// Get the target sector for the request
>      #[inline(always)]
>      pub fn sector(&self) -> usize {
> --
> 2.40.0
>=20

--
Cheers,
Benno
