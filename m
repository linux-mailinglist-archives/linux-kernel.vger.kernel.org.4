Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF636D0323
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbjC3L3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjC3L3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:29:06 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483F586AB
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:29:04 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:28:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680175742; x=1680434942;
        bh=XfCZyP1vsJsXaXjTfv1aS0dAtrtbQWCUhyE0nUwDrgE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=sGf5sEb1DbkT0HO0LPOU5LecCYKJsBm6TkNOEqvbq2NDFRPni8cSDhCyQAvcy8fM7
         QB9/SB+d7AuiBc1JMbHQBuPrAaNiR8j5860e/oOsFr0OGTwpkE5dhkBEjo5j0uLqfG
         0enrLqXlelh9+g76uazHDwb1JxV4bcUxW03U5kDem6FcPIhrfNIo9PjYeno0eZ50N6
         T7Lu1Cv4W77p3heuGpD7EIogLN+I1HEJX2LPbYMCg6IS9Dapo8rkc4J2Kc4lKaZwkh
         jsUdTdjEFkEGTnHOmGaN5xUMPE9cAwEDj/FrfGbqIKh6P9DfpRsKeQ/3SvAbnyMIqd
         1oj2CawBNCJnA==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [PATCH 13/13] rust: sync: introduce `LockedBy`
Message-ID: <04034640-2d89-dd63-07e5-29fa612aa458@protonmail.com>
In-Reply-To: <20230330043954.562237-13-wedsonaf@gmail.com>
References: <20230330043954.562237-1-wedsonaf@gmail.com> <20230330043954.562237-13-wedsonaf@gmail.com>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.03.23 06:39, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This allows us to have data protected by a lock despite not being
> wrapped by it. Access is granted by providing evidence that the lock is
> held by the caller.
>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
>   rust/kernel/sync.rs           |   2 +
>   rust/kernel/sync/lock.rs      |   2 +-
>   rust/kernel/sync/locked_by.rs | 126 ++++++++++++++++++++++++++++++++++
>   3 files changed, 129 insertions(+), 1 deletion(-)
>   create mode 100644 rust/kernel/sync/locked_by.rs
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index d6dd0e2c1678..f8edb6d0d794 100644
> --- a/rust/kernel/sync.rs
> +++ b/rust/kernel/sync.rs
> @@ -10,10 +10,12 @@ use crate::types::Opaque;
>   mod arc;
>   mod condvar;
>   pub mod lock;
> +mod locked_by;
>
>   pub use arc::{Arc, ArcBorrow, UniqueArc};
>   pub use condvar::CondVar;
>   pub use lock::{mutex::Mutex, spinlock::SpinLock};
> +pub use locked_by::LockedBy;
>
>   /// Represents a lockdep class. It's a wrapper around C's `lock_class_k=
ey`.
>   #[repr(transparent)]
> diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> index f52ba9ab1b70..51c996ca2109 100644
> --- a/rust/kernel/sync/lock.rs
> +++ b/rust/kernel/sync/lock.rs
> @@ -111,7 +111,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
>       _pin: PhantomPinned,
>
>       /// The data protected by the lock.
> -    data: UnsafeCell<T>,
> +    pub(crate) data: UnsafeCell<T>,
>   }
>
>   // SAFETY: `Lock` can be transferred across thread boundaries iff the d=
ata it protects can.
> diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.r=
s
> new file mode 100644
> index 000000000000..cbfd4e84b770
> --- /dev/null
> +++ b/rust/kernel/sync/locked_by.rs
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A wrapper for data protected by a lock that does not wrap it.
> +
> +use super::{lock::Backend, lock::Lock};
> +use core::{cell::UnsafeCell, ptr};
> +
> +/// Allows access to some data to be serialised by a lock that does not =
wrap it.
> +///
> +/// In most cases, data protected by a lock is wrapped by the appropriat=
e lock type, e.g.,
> +/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for c=
ases when this is not
> +/// possible. For example, if a container has a lock and some data in th=
e contained elements needs
> +/// to be protected by the same lock.
> +///
> +/// [`LockedBy`] wraps the data in lieu of another locking primitive, an=
d only allows access to it
> +/// when the caller shows evidence that the 'external' lock is locked.
> +///
> +/// # Examples
> +///
> +/// The following is an example for illustrative purposes: `InnerDirecto=
ry::bytes_used` is an
> +/// aggregate of all `InnerFile::bytes_used` and must be kept consistent=
; so we wrap `InnerFile` in
> +/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This al=
lows us to enforce at
> +/// compile-time that access to `InnerFile` is only granted when an `Inn=
erDirectory` is also
> +/// locked; we enforce at run time that the right `InnerDirectory` is lo=
cked.
> +///
> +/// ```
> +/// use kernel::sync::{LockedBy, Mutex};
> +///
> +/// struct InnerFile {
> +///     bytes_used: u64,
> +/// }
> +///
> +/// struct File {
> +///     _ino: u32,
> +///     inner: LockedBy<InnerFile, InnerDirectory>,
> +/// }
> +///
> +/// struct InnerDirectory {
> +///     /// The sum of the bytes used by all files.
> +///     bytes_used: u64,
> +///     _files: Vec<File>,
> +/// }
> +///
> +/// struct Directory {
> +///     _ino: u32,
> +///     inner: Mutex<InnerDirectory>,
> +/// }
> +///
> +/// /// Prints `bytes_used` from both the directory and file.
> +/// fn print_bytes_used(dir: &Directory, file: &File) {
> +///     let guard =3D dir.inner.lock();
> +///     let inner_file =3D file.inner.access(&guard);
> +///     pr_info!("{} {}", guard.bytes_used, inner_file.bytes_used);
> +/// }
> +///
> +/// /// Increments `bytes_used` for both the directory and file.
> +/// fn inc_bytes_used(dir: &Directory, file: &File) {
> +///     let mut guard =3D dir.inner.lock();
> +///     guard.bytes_used +=3D 10;
> +///
> +///     let file_inner =3D file.inner.access_mut(&mut guard);

Missing deref (`*`) in front of `guard`.

> +///     file_inner.bytes_used +=3D 10;
> +/// }
> +///
> +/// /// Creates a new file.
> +/// fn new_file(ino: u32, dir: &Directory) -> File {
> +///     File {
> +///         _ino: ino,
> +///         inner: LockedBy::new(&dir.inner, InnerFile { bytes_used: 0 }=
),
> +///     }
> +/// }
> +/// ```
> +pub struct LockedBy<T: ?Sized, U: ?Sized> {
> +    owner: *const U,
> +    data: UnsafeCell<T>,
> +}
> +
> +// SAFETY: `LockedBy` can be transferred across thread boundaries iff th=
e data it protects can.
> +unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
> +
> +// SAFETY: `LockedBy` serialises the interior mutability it provides, so=
 it is `Sync` as long as the
> +// data it protects is `Send`.
> +unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
> +
> +impl<T, U: ?Sized> LockedBy<T, U> {
> +    /// Constructs a new instance of [`LockedBy`].
> +    ///
> +    /// It stores a raw pointer to the owner that is never dereferenced.=
 It is only used to ensure
> +    /// that the right owner is being used to access the protected data.=
 If the owner is freed, the
> +    /// data becomes inaccessible; if another instance of the owner is a=
llocated *on the same
> +    /// memory location*, the data becomes accessible again: none of thi=
s affects memory safety
> +    /// because in any case at most one thread (or CPU) can access the p=
rotected data at a time.
> +    pub fn new(owner: &Lock<U, impl Backend>, data: T) -> Self {
> +        Self {
> +            owner: owner.data.get(),
> +            data: UnsafeCell::new(data),
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized, U: ?Sized> LockedBy<T, U> {
> +    /// Returns a reference to the protected data when the caller provid=
es evidence (via a
> +    /// reference) that the owner is locked.
> +    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
> +        if !ptr::eq(owner, self.owner) {
> +            panic!("mismatched owners");
> +        }
> +
> +        // SAFETY: `owner` is evidence that the owner is locked.
> +        unsafe { &*self.data.get() }
> +    }
> +
> +    /// Returns a mutable reference to the protected data when the calle=
r provides evidence (via a
> +    /// mutable owner) that the owner is locked mutably.
> +    ///
> +    /// Showing a mutable reference to the owner is sufficient because w=
e know no other references
> +    /// can exist to it.
> +    pub fn access_mut<'a>(&'a self, owner: &'a mut U) -> &'a mut T {
> +        if !ptr::eq(owner, self.owner) {
> +            panic!("mismatched owners");
> +        }
> +
> +        // SAFETY: `owner` is evidence that there is only one reference =
to the owner.
> +        unsafe { &mut *self.data.get() }
> +    }
> +}
> --
> 2.34.1
>

What happens if the the protected data `U` is a ZST? Then the address
comparing will not work, since all ZST references have the same address.
For example:

     struct Outer {
         mtx: Mutex<()>,
         inners: Vec<Inner>,
     }

     struct Inner {
         count: LockedBy<usize, ()>,
     }

     fn evil(inner: &Inner) {
         // can create two mutable references at the same time:
         let a =3D inner.count.access_mut(&mut ());
         let b =3D inner.count.access_mut(&mut ());
         core::mem::swap(a, b);
     }

Maybe prevent this by checking for `assert!(mem::size_of::<U>() !=3D 0);`
in the `new` function? Though I am not sure if a ZST is the only way for
values to share addresses.

--
Cheers,
Benno


