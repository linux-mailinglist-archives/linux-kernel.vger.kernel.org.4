Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F29386D103B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbjC3UpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC3Uo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:44:59 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5211C2137;
        Thu, 30 Mar 2023 13:44:47 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5416698e889so377941367b3.2;
        Thu, 30 Mar 2023 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680209086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=oWfRGrpV5MJhPuww+93USL8lTo4MhD+IDxAXmRenEE0=;
        b=RRrq66w5fA18DW2TXvpqltKDQPui3LnHtaBY3Y918G6PkSz4qvLMe1yDxJkW4yFmsn
         +liLaQbHb7qlSEm55ssE61imbeX+/ihhzRI97+jPbpi/yCIiJTgNLKYLBNjRrSCGphvK
         Rd9z0iQEPpZDjUwzz/iVYaTCFZTLMqNV58RmcILQe1HU0zM9r7RZa1mlyjqCMFXkx515
         /6j9OFb7QXBRLb+Orbqau2Sq8k2tPERQdVyElLuPiOWC6TBURASaxjE+cjByqT0xlwL5
         cvMszKVnJrj/jV9QxNW+FhwM0riUqFB7Ycff+14sBXpciHockzsn3NQgY8ivRwSu9qov
         GhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680209086;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oWfRGrpV5MJhPuww+93USL8lTo4MhD+IDxAXmRenEE0=;
        b=AzRqscyR36Jz9B684rY2qZWxb2WS8Bj2HHUilG16a0moslrV0TlSCeLGCNuJmtshOR
         SFBGEaQ1P6xkKxUg28imHakv2b2ZRjEAqnM7QxdWQj8qKZBWKvG4pVgsWExxWUVmqp5Y
         /tHhAsbYCPNiPgnev8i0eKk4VVRCHp8Gdy4THNDO/UfpJ46aqN8rQr5THKdZhiKWoxZs
         W3c2juxVIgkEAxaC1lr6KJ9UpxrV2/IfZJexuXSKGhwhLK0k+n55cNEbcerk7SU7PSE/
         0hP9Bqd8+T6PmLTivUOzxqPyFgl2LEkHrw6ta6GYJd/lzk9z3jfcte95wVPqEbJFUNqe
         ENLw==
X-Gm-Message-State: AAQBX9cWqnSpnO5iIduqAzIcYo0WYLZ5eJrJB0qgf7REBwvnZ3jl+7p1
        DM+23Jk0H0l899vKWghGAsEYApInHfILmLWVl8g=
X-Google-Smtp-Source: AKy350aDkocMGFpO7n1YFWL3FJ2z/mYK/32VzTb13F/atRRkMuOwT6fOLl+z3cPly5RP2vYK4QVu87g5/fMGZaEG20Y=
X-Received: by 2002:a81:c84a:0:b0:541:753d:32f9 with SMTP id
 k10-20020a81c84a000000b00541753d32f9mr12273495ywl.9.1680209086380; Thu, 30
 Mar 2023 13:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230330043954.562237-1-wedsonaf@gmail.com> <20230330043954.562237-13-wedsonaf@gmail.com>
 <04034640-2d89-dd63-07e5-29fa612aa458@protonmail.com>
In-Reply-To: <04034640-2d89-dd63-07e5-29fa612aa458@protonmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Thu, 30 Mar 2023 17:44:37 -0300
Message-ID: <CANeycqo=bbGHz_3OiDUDXwwesvO9t57twALcbgGdx=kCRb-SFg@mail.gmail.com>
Subject: Re: [PATCH 13/13] rust: sync: introduce `LockedBy`
To:     Benno Lossin <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Benno,

Thanks for reviewing!

On Thu, 30 Mar 2023 at 08:29, Benno Lossin <y86-dev@protonmail.com> wrote:
>
> On 30.03.23 06:39, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This allows us to have data protected by a lock despite not being
> > wrapped by it. Access is granted by providing evidence that the lock is
> > held by the caller.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> >   rust/kernel/sync.rs           |   2 +
> >   rust/kernel/sync/lock.rs      |   2 +-
> >   rust/kernel/sync/locked_by.rs | 126 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 129 insertions(+), 1 deletion(-)
> >   create mode 100644 rust/kernel/sync/locked_by.rs
> >
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index d6dd0e2c1678..f8edb6d0d794 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -10,10 +10,12 @@ use crate::types::Opaque;
> >   mod arc;
> >   mod condvar;
> >   pub mod lock;
> > +mod locked_by;
> >
> >   pub use arc::{Arc, ArcBorrow, UniqueArc};
> >   pub use condvar::CondVar;
> >   pub use lock::{mutex::Mutex, spinlock::SpinLock};
> > +pub use locked_by::LockedBy;
> >
> >   /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> >   #[repr(transparent)]
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index f52ba9ab1b70..51c996ca2109 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -111,7 +111,7 @@ pub struct Lock<T: ?Sized, B: Backend> {
> >       _pin: PhantomPinned,
> >
> >       /// The data protected by the lock.
> > -    data: UnsafeCell<T>,
> > +    pub(crate) data: UnsafeCell<T>,
> >   }
> >
> >   // SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
> > diff --git a/rust/kernel/sync/locked_by.rs b/rust/kernel/sync/locked_by.rs
> > new file mode 100644
> > index 000000000000..cbfd4e84b770
> > --- /dev/null
> > +++ b/rust/kernel/sync/locked_by.rs
> > @@ -0,0 +1,126 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! A wrapper for data protected by a lock that does not wrap it.
> > +
> > +use super::{lock::Backend, lock::Lock};
> > +use core::{cell::UnsafeCell, ptr};
> > +
> > +/// Allows access to some data to be serialised by a lock that does not wrap it.
> > +///
> > +/// In most cases, data protected by a lock is wrapped by the appropriate lock type, e.g.,
> > +/// [`super::Mutex`] or [`super::SpinLock`]. [`LockedBy`] is meant for cases when this is not
> > +/// possible. For example, if a container has a lock and some data in the contained elements needs
> > +/// to be protected by the same lock.
> > +///
> > +/// [`LockedBy`] wraps the data in lieu of another locking primitive, and only allows access to it
> > +/// when the caller shows evidence that the 'external' lock is locked.
> > +///
> > +/// # Examples
> > +///
> > +/// The following is an example for illustrative purposes: `InnerDirectory::bytes_used` is an
> > +/// aggregate of all `InnerFile::bytes_used` and must be kept consistent; so we wrap `InnerFile` in
> > +/// a `LockedBy` so that it shares a lock with `InnerDirectory`. This allows us to enforce at
> > +/// compile-time that access to `InnerFile` is only granted when an `InnerDirectory` is also
> > +/// locked; we enforce at run time that the right `InnerDirectory` is locked.
> > +///
> > +/// ```
> > +/// use kernel::sync::{LockedBy, Mutex};
> > +///
> > +/// struct InnerFile {
> > +///     bytes_used: u64,
> > +/// }
> > +///
> > +/// struct File {
> > +///     _ino: u32,
> > +///     inner: LockedBy<InnerFile, InnerDirectory>,
> > +/// }
> > +///
> > +/// struct InnerDirectory {
> > +///     /// The sum of the bytes used by all files.
> > +///     bytes_used: u64,
> > +///     _files: Vec<File>,
> > +/// }
> > +///
> > +/// struct Directory {
> > +///     _ino: u32,
> > +///     inner: Mutex<InnerDirectory>,
> > +/// }
> > +///
> > +/// /// Prints `bytes_used` from both the directory and file.
> > +/// fn print_bytes_used(dir: &Directory, file: &File) {
> > +///     let guard = dir.inner.lock();
> > +///     let inner_file = file.inner.access(&guard);
> > +///     pr_info!("{} {}", guard.bytes_used, inner_file.bytes_used);
> > +/// }
> > +///
> > +/// /// Increments `bytes_used` for both the directory and file.
> > +/// fn inc_bytes_used(dir: &Directory, file: &File) {
> > +///     let mut guard = dir.inner.lock();
> > +///     guard.bytes_used += 10;
> > +///
> > +///     let file_inner = file.inner.access_mut(&mut guard);
>
> Missing deref (`*`) in front of `guard`.

`Deref` coercion obviates the need for an explicit dereference. This
works as is.

> > +///     file_inner.bytes_used += 10;
> > +/// }
> > +///
> > +/// /// Creates a new file.
> > +/// fn new_file(ino: u32, dir: &Directory) -> File {
> > +///     File {
> > +///         _ino: ino,
> > +///         inner: LockedBy::new(&dir.inner, InnerFile { bytes_used: 0 }),
> > +///     }
> > +/// }
> > +/// ```
> > +pub struct LockedBy<T: ?Sized, U: ?Sized> {
> > +    owner: *const U,
> > +    data: UnsafeCell<T>,
> > +}
> > +
> > +// SAFETY: `LockedBy` can be transferred across thread boundaries iff the data it protects can.
> > +unsafe impl<T: ?Sized + Send, U: ?Sized> Send for LockedBy<T, U> {}
> > +
> > +// SAFETY: `LockedBy` serialises the interior mutability it provides, so it is `Sync` as long as the
> > +// data it protects is `Send`.
> > +unsafe impl<T: ?Sized + Send, U: ?Sized> Sync for LockedBy<T, U> {}
> > +
> > +impl<T, U: ?Sized> LockedBy<T, U> {
> > +    /// Constructs a new instance of [`LockedBy`].
> > +    ///
> > +    /// It stores a raw pointer to the owner that is never dereferenced. It is only used to ensure
> > +    /// that the right owner is being used to access the protected data. If the owner is freed, the
> > +    /// data becomes inaccessible; if another instance of the owner is allocated *on the same
> > +    /// memory location*, the data becomes accessible again: none of this affects memory safety
> > +    /// because in any case at most one thread (or CPU) can access the protected data at a time.
> > +    pub fn new(owner: &Lock<U, impl Backend>, data: T) -> Self {
> > +        Self {
> > +            owner: owner.data.get(),
> > +            data: UnsafeCell::new(data),
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized, U: ?Sized> LockedBy<T, U> {
> > +    /// Returns a reference to the protected data when the caller provides evidence (via a
> > +    /// reference) that the owner is locked.
> > +    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
> > +        if !ptr::eq(owner, self.owner) {
> > +            panic!("mismatched owners");
> > +        }
> > +
> > +        // SAFETY: `owner` is evidence that the owner is locked.
> > +        unsafe { &*self.data.get() }
> > +    }
> > +
> > +    /// Returns a mutable reference to the protected data when the caller provides evidence (via a
> > +    /// mutable owner) that the owner is locked mutably.
> > +    ///
> > +    /// Showing a mutable reference to the owner is sufficient because we know no other references
> > +    /// can exist to it.
> > +    pub fn access_mut<'a>(&'a self, owner: &'a mut U) -> &'a mut T {
> > +        if !ptr::eq(owner, self.owner) {
> > +            panic!("mismatched owners");
> > +        }
> > +
> > +        // SAFETY: `owner` is evidence that there is only one reference to the owner.
> > +        unsafe { &mut *self.data.get() }
> > +    }
> > +}
> > --
> > 2.34.1
> >
>
> What happens if the the protected data `U` is a ZST? Then the address
> comparing will not work, since all ZST references have the same address.

Indeed SZTs are problematic. I'll add a restriction to rule them out.

> For example:
>
>      struct Outer {
>          mtx: Mutex<()>,
>          inners: Vec<Inner>,
>      }
>
>      struct Inner {
>          count: LockedBy<usize, ()>,
>      }
>
>      fn evil(inner: &Inner) {
>          // can create two mutable references at the same time:
>          let a = inner.count.access_mut(&mut ());
>          let b = inner.count.access_mut(&mut ());
>          core::mem::swap(a, b);
>      }
>
> Maybe prevent this by checking for `assert!(mem::size_of::<U>() != 0);`
> in the `new` function? Though I am not sure if a ZST is the only way for
> values to share addresses.

I'll add such an assert a part of a `const` inside an impl block so
that we get it to fail at compile time if misused.

>
> --
> Cheers,
> Benno
>
>
