Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC7D86F5644
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbjECKfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjECKfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:35:01 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E5334EFD
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 03:34:56 -0700 (PDT)
Date:   Wed, 03 May 2023 10:34:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=c45gzkyicfbjnkpxq5pov66h5q.protonmail; t=1683110091; x=1683369291;
        bh=yTuWhDy/Ex1N0qe/tRLjDHy7FCNkp6ne4TYP1/rZsdg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ZLnppUjDO5/ZP57uoTL/7IP8spu2w07LX2fj6ethh59+P6lMTzQq0TPuM8kqNUmhj
         c8C7CcZBD3GECplmgo+yxWh2PVeEm6Q400eG6I0Q8tKJFNuFuMhUNR7V8boXTPgx+g
         MN6HnTvP1x9CZ6dpZgdJotX7ouUTEicG/rm5vEwfMGZP7fqwel38thFomM7IUb6/tX
         sM3qNyOBHwPScEy3WYnEnS65D8KtNweMAHAtqxzEs8JxYTHEd6g5sEeI3MSLUwRv2m
         4cS4I++rrJieiEg8ssNt34rvZAh2ZtrZtInpwSh3M87bd+R1SJiV94KQ5DJmS7Jpkv
         jFi9KJsjQ1m2A==
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
Subject: Re: [RFC PATCH 01/11] rust: add radix tree abstraction
Message-ID: <615XOkalORUFcLI8ZOdiEloHy_FyOO8k4hFe8uQ-Cd1wcrAvIYvbzkMeIs2ofJ5L37owbU2vB3Gg6Ya5NroUeggwAMssPRfdBfBZ4vvMr_w=@proton.me>
In-Reply-To: <20230503090708.2524310-2-nmi@metaspace.dk>
References: <20230503090708.2524310-1-nmi@metaspace.dk> <20230503090708.2524310-2-nmi@metaspace.dk>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Andreas Hindborg <a.hindborg@samsung.com>
>=20
> Add abstractions for the C radix_tree. This abstraction allows Rust code =
to use
> the radix_tree as a map from `u64` keys to `ForeignOwnable` values.
>=20
> Signed-off-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
>  rust/bindings/bindings_helper.h |   2 +
>  rust/bindings/lib.rs            |   1 +
>  rust/helpers.c                  |  22 +++++
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/radix_tree.rs       | 156 ++++++++++++++++++++++++++++++++
>  5 files changed, 182 insertions(+)
>  create mode 100644 rust/kernel/radix_tree.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 50e7a76d5455..52834962b94d 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,7 +10,9 @@
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/radix-tree.h>

Can you sort these alphabetically? Also the constants down below.

>=20
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
> +const gfp_t BINDINGS_GFP_ATOMIC =3D GFP_ATOMIC;
>  const gfp_t BINDINGS___GFP_ZERO =3D __GFP_ZERO;
> diff --git a/rust/bindings/lib.rs b/rust/bindings/lib.rs
> index 7b246454e009..62f36a9eb1f4 100644
> --- a/rust/bindings/lib.rs
> +++ b/rust/bindings/lib.rs
> @@ -51,4 +51,5 @@ mod bindings_helper {
>  pub use bindings_raw::*;
>=20
>  pub const GFP_KERNEL: gfp_t =3D BINDINGS_GFP_KERNEL;
> +pub const GFP_ATOMIC: gfp_t =3D BINDINGS_GFP_ATOMIC;
>  pub const __GFP_ZERO: gfp_t =3D BINDINGS___GFP_ZERO;
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 81e80261d597..5dd5e325b7cc 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -26,6 +26,7 @@
>  #include <linux/spinlock.h>
>  #include <linux/sched/signal.h>
>  #include <linux/wait.h>
> +#include <linux/radix-tree.h>
>=20
>  __noreturn void rust_helper_BUG(void)
>  {
> @@ -128,6 +129,27 @@ void rust_helper_put_task_struct(struct task_struct =
*t)
>  }
>  EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
>=20
> +void rust_helper_init_radix_tree(struct xarray *tree, gfp_t gfp_mask)
> +{
> +=09INIT_RADIX_TREE(tree, gfp_mask);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_init_radix_tree);
> +
> +void **rust_helper_radix_tree_iter_init(struct radix_tree_iter *iter,
> +=09=09=09=09=09unsigned long start)
> +{
> +=09return radix_tree_iter_init(iter, start);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_radix_tree_iter_init);
> +
> +void **rust_helper_radix_tree_next_slot(void **slot,
> +=09=09=09=09=09struct radix_tree_iter *iter,
> +=09=09=09=09=09unsigned flags)
> +{
> +=09return radix_tree_next_slot(slot, iter, flags);
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_radix_tree_next_slot);
> +
>  /*
>   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` =
type
>   * as the Rust `usize` type, so we can use it in contexts where Rust
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 676995d4e460..a85cb6aae8d6 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -40,6 +40,7 @@ pub mod init;
>  pub mod ioctl;
>  pub mod prelude;
>  pub mod print;
> +pub mod radix_tree;
>  mod static_assert;
>  #[doc(hidden)]
>  pub mod std_vendor;
> diff --git a/rust/kernel/radix_tree.rs b/rust/kernel/radix_tree.rs
> new file mode 100644
> index 000000000000..f659ab8b017c
> --- /dev/null
> +++ b/rust/kernel/radix_tree.rs
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! RadixTree abstraction.
> +//!
> +//! C header: [`include/linux/radix_tree.h`](../../include/linux/radix_t=
ree.h)
> +
> +use crate::error::to_result;
> +use crate::error::Result;
> +use crate::types::ForeignOwnable;
> +use crate::types::Opaque;
> +use crate::types::ScopeGuard;
> +use alloc::boxed::Box;
> +use core::marker::PhantomData;
> +use core::pin::Pin;

I would prefer `use crate::{error::{...}, types::{...}};`.

> +
> +type Key =3D u64;

Is there a reason to not make this `pub`?

> +
> +/// A map of `u64` to `ForeignOwnable`
> +///
> +/// # Invariants
> +///
> +/// - `tree` always points to a valid and initialized `struct radix_tree=
`.
> +/// - Pointers stored in the tree are created by a call to `ForignOwnabl=
e::into_foreign()`
> +pub struct RadixTree<V: ForeignOwnable> {
> +    tree: Pin<Box<Opaque<bindings::xarray>>>,
> +    _marker: PhantomData<V>,
> +}

Design question: why is the tree boxed? Shouldn't the user decide how
they want to manage the memory of the tree? In other words, should
`tree` just be `Opaque<bindings::xarray>` and this type initialized via
`pin-init`?

> +
> +impl<V: ForeignOwnable> RadixTree<V> {
> +    /// Create a new radix tree
> +    ///
> +    /// Note: This function allocates memory with `GFP_ATOMIC`.

There probably is a reason why this uses `GFP_ATOMIC`, but I think if we
decide that the tree allocates memory there should be also a function
with `GFP_KERNEL`. That function should be called `new()` and this one
`new_atomic()` or `new_gfp(gfp: gfp_t)`. Also note that I think the
return type should be `Result<Self, AllocError>`, we should be explicit
where we can be.

> +    pub fn new() -> Result<Self> {
> +        let tree =3D Pin::from(Box::try_new(Opaque::uninit())?);
> +
> +        // SAFETY: `tree` points to allocated but not initialized memory=
. This
> +        // call will initialize the memory.
> +        unsafe { bindings::init_radix_tree(tree.get(), bindings::GFP_ATO=
MIC) };
> +
> +        Ok(Self {
> +            tree,
> +            _marker: PhantomData,
> +        })
> +    }
> +
> +    /// Try to insert a value into the tree
> +    pub fn try_insert(&mut self, key: Key, value: V) -> Result<()> {
> +        // SAFETY: `self.tree` points to a valid and initialized `struct=
 radix_tree`

Also add that the invariant of only inserting `ForignOwnable` pointers
is upheld.

> +        let ret =3D
> +            unsafe { bindings::radix_tree_insert(self.tree.get(), key, v=
alue.into_foreign() as _) };

Instead of `as _` prefer to use `.cast::<$type>()` or in this case probably=
 `.cast_mut()`.

> +        to_result(ret)
> +    }
> +
> +    /// Search for `key` in the map. Returns a reference to the associat=
ed
> +    /// value if found.
> +    pub fn get(&self, key: Key) -> Option<V::Borrowed<'_>> {
> +        // SAFETY: `self.tree` points to a valid and initialized `struct=
 radix_tree`
> +        let item =3D
> +            core::ptr::NonNull::new(unsafe { bindings::radix_tree_lookup=
(self.tree.get(), key) })?;

You use `NonNull` quiet a bit, consider importing it.

> +
> +        // SAFETY: `item` was created by a call to
> +        // `ForeignOwnable::into_foreign()`. As `get_mut()` and `remove(=
)` takes
> +        // a `&mut self`, no mutable borrows for `item` can exist and
> +        // `ForeignOwnable::from_foreign()` cannot be called until this =
borrow
> +        // is dropped.
> +        Some(unsafe { V::borrow(item.as_ptr()) })
> +    }
> +
> +    /// Search for `key` in the map. Return a mutable reference to the
> +    /// associated value if found.
> +    pub fn get_mut(&mut self, key: Key) -> Option<MutBorrow<'_, V>> {
> +        let item =3D
> +            core::ptr::NonNull::new(unsafe { bindings::radix_tree_lookup=
(self.tree.get(), key) })?;
> +
> +        // SAFETY: `item` was created by a call to
> +        // `ForeignOwnable::into_foreign()`. As `get()` takes a `&self` =
and
> +        // `remove()` takes a `&mut self`, no borrows for `item` can exi=
st and
> +        // `ForeignOwnable::from_foreign()` cannot be called until this =
borrow
> +        // is dropped.
> +        Some(MutBorrow {
> +            guard: unsafe { V::borrow_mut(item.as_ptr()) },
> +            _marker: core::marker::PhantomData,
> +        })
> +    }
> +
> +    /// Search for `key` in the map. If `key` is found, the key and valu=
e is
> +    /// removed from the map and the value is returned.
> +    pub fn remove(&mut self, key: Key) -> Option<V> {
> +        // SAFETY: `self.tree` points to a valid and initialized `struct=
 radix_tree`
> +        let item =3D
> +            core::ptr::NonNull::new(unsafe { bindings::radix_tree_delete=
(self.tree.get(), key) })?;
> +
> +        // SAFETY: `item` was created by a call to
> +        // `ForeignOwnable::into_foreign()` and no borrows to `item` can=
 exist
> +        // because this function takes a `&mut self`.
> +        Some(unsafe { ForeignOwnable::from_foreign(item.as_ptr()) })
> +    }
> +}
> +
> +impl<V: ForeignOwnable> Drop for RadixTree<V> {
> +    fn drop(&mut self) {
> +        let mut iter =3D bindings::radix_tree_iter {
> +            index: 0,
> +            next_index: 0,
> +            tags: 0,
> +            node: core::ptr::null_mut(),
> +        };
> +
> +        // SAFETY: Iter is valid as we allocated it on the stack above
> +        let mut slot =3D unsafe { bindings::radix_tree_iter_init(&mut it=
er, 0) };
> +        loop {
> +            if slot.is_null() {
> +                // SAFETY: Both `self.tree` and `iter` are valid
> +                slot =3D unsafe { bindings::radix_tree_next_chunk(self.t=
ree.get(), &mut iter, 0) };
> +            }
> +
> +            if slot.is_null() {
> +                break;
> +            }
> +
> +            // SAFETY: `self.tree` is valid and iter is managed by
> +            // `radix_tree_next_chunk()` and `radix_tree_next_slot()`
> +            let item =3D unsafe { bindings::radix_tree_delete(self.tree.=
get(), iter.index) };
> +            assert!(!item.is_null());
> +
> +            // SAFETY: All items in the tree are created by a call to
> +            // `ForeignOwnable::into_foreign()`.
> +            let _ =3D unsafe { V::from_foreign(item) };
> +
> +            // SAFETY: `self.tree` is valid and iter is managed by
> +            // `radix_tree_next_chunk()` and `radix_tree_next_slot()`. S=
lot is
> +            // not null.
> +            slot =3D unsafe { bindings::radix_tree_next_slot(slot, &mut =
iter, 0) };
> +        }
> +    }
> +}
> +
> +/// A mutable borrow of an object owned by a `RadixTree`
> +pub struct MutBorrow<'a, V: ForeignOwnable> {
> +    guard: ScopeGuard<V, fn(V)>,
> +    _marker: core::marker::PhantomData<&'a mut V>,
> +}
> +
> +impl<'a, V: ForeignOwnable> core::ops::Deref for MutBorrow<'a, V> {
> +    type Target =3D ScopeGuard<V, fn(V)>;

Why is `Target =3D ScopeGuard`? I think it makes more sense to use
`Target =3D V`.

> +
> +    fn deref(&self) -> &Self::Target {
> +        &self.guard
> +    }
> +}
> +
> +impl<'a, V: ForeignOwnable> core::ops::DerefMut for MutBorrow<'a, V> {
> +    fn deref_mut(&mut self) -> &mut Self::Target {
> +        &mut self.guard
> +    }
> +}
> --
> 2.40.0
>=20

--
Cheers,
Benno
