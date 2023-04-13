Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E42D66E0A6F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 11:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDMJpY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 05:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbjDMJpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:45:22 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EFA9031
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 02:45:16 -0700 (PDT)
Date:   Thu, 13 Apr 2023 09:45:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=qcpkh3tzojdgbkwz55ti355tey.protonmail; t=1681379114; x=1681638314;
        bh=VS/vvMrfuqP4jLEUV8GWITdtCW3cWpNVfUsPCecWtQM=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=HDI3X5ciFHdjLP88ayQxa/p617ulOwo7gR+4/S14ieWyH02w0oktDTG5NJ1bSzjUQ
         4SJBb0seANH3IXaiW3TB5WmcBX54UzVKRN1zv8PdIFhLNyLqWbvjNX9fwhJ6FGvYMw
         0gTaDy6oouKLPkCAsl3o8+j4U5wg9W9OflPvSubU76XzlqgLIikZ8epk9iUwIVFvHJ
         WMPSP59gkMi1aVaskKJ1SZ1lv0YLG1jPTK30ps0eaPOwTgOmHbNGWbIgQKVNLVEQYa
         XmJpjh+EDxWeq67KbfSsGB33sMNW6ofhB07N6cr7uCTtUPfD96Qp1JZc9Cf2F3xvU2
         BZN10IUOWj4EQ==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 13/13] rust: sync: introduce `LockedBy`
Message-ID: <4cbd25e7-0537-e1fd-6959-5802e2ce443e@proton.me>
In-Reply-To: <20230411054543.21278-13-wedsonaf@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-13-wedsonaf@gmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.04.23 07:45, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This allows us to have data protected by a lock despite not being
> wrapped by it. Access is granted by providing evidence that the lock is
> held by the caller.
>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
> v1 -> v2: Added build_assert to rule out zero-sized types
> v2 -> v3: Improve comments around panics and support for ZSTs
> v3 -> v4:
> - Added build_assert to LockBy::new
> - Updated build_assert calls with messages
> - Included crate::build_assert and mem::size_of since they're used
>    repeatedly.
>
>   rust/kernel/sync.rs           |   2 +
>   rust/kernel/sync/lock.rs      |   2 +-
>   rust/kernel/sync/locked_by.rs | 156 ++++++++++++++++++++++++++++++++++
>   3 files changed, 159 insertions(+), 1 deletion(-)
>   create mode 100644 rust/kernel/sync/locked_by.rs
>
> diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> index 431402180aa8..d219ee518eff 100644
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
> index 816c5d3bba12..14940312141d 100644
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
> index 000000000000..b17ee5cd98f3
> --- /dev/null
> +++ b/rust/kernel/sync/locked_by.rs
> @@ -0,0 +1,156 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! A wrapper for data protected by a lock that does not wrap it.
> +
> +use super::{lock::Backend, lock::Lock};
> +use crate::build_assert;
> +use core::{cell::UnsafeCell, mem::size_of, ptr};
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
> +/// when the caller shows evidence that the 'external' lock is locked. I=
t panics if the evidence
> +/// refers to the wrong instance of the lock.
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
> +impl<T, U> LockedBy<T, U> {
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
> +    pub fn new<B: Backend>(owner: &Lock<U, B>, data: T) -> Self {
> +        build_assert!(
> +            size_of::<Lock<U, B>>() > 0,
> +            "The lock type cannot be a ZST because it may be impossible =
to distinguish instances"
> +        );
> +        Self {
> +            owner: owner.data.get(),
> +            data: UnsafeCell::new(data),
> +        }
> +    }
> +}
> +
> +impl<T: ?Sized, U> LockedBy<T, U> {
> +    /// Returns a reference to the protected data when the caller provid=
es evidence (via a
> +    /// reference) that the owner is locked.
> +    ///
> +    /// `U` cannot be a zero-sized type (ZST) because there are ways to =
get an `&U` that matches
> +    /// the data protected by the lock without actually holding it.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `owner` is different from the data protected by the lo=
ck used in
> +    /// [`new`](LockedBy::new).
> +    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
> +        build_assert!(
> +            size_of::<U>() > 0,
> +            "`U` cannot be a ZST because `owner` wouldn't be unique"
> +        );
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
> +    /// `U` cannot be a zero-sized type (ZST) because there are ways to =
get an `&mut U` that
> +    /// matches the data protected by the lock without actually holding =
it.
> +    ///
> +    /// Showing a mutable reference to the owner is sufficient because w=
e know no other references
> +    /// can exist to it.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if `owner` is different from the data protected by the lo=
ck used in
> +    /// [`new`](LockedBy::new).
> +    pub fn access_mut<'a>(&'a self, owner: &'a mut U) -> &'a mut T {
> +        build_assert!(
> +            size_of::<U>() > 0,
> +            "`U` cannot be a ZST because `owner` wouldn't be unique"
> +        );
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


