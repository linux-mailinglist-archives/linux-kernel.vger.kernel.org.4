Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61DC86DB8C1
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 06:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjDHEME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 00:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjDHEMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 00:12:02 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66D8D332;
        Fri,  7 Apr 2023 21:12:00 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id y186so404371yby.13;
        Fri, 07 Apr 2023 21:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680927120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DrbRjSdQRr9IJPgCGlzD/ebgWSH8jxp+2pjblcvsCNU=;
        b=Wm681GmhC2j8X5uVZLZFoWl01x+QBpQvEhjdB7pN7lekASuFg5msnpJ71E3WKfWl7g
         3t9YJ1YJuot4IELcn8y0N3mmuxZoW4oq9RL6Xf1YLW6HIerTG6DSF867UVPKQokSRuWZ
         7HXIhHoR9pWJ8UpYGB5dCQ44ugfu8SgHhz9IXfnWabUXhFJDAhjO05RJiDwIc5dqc/Py
         +axxZ8NZkb5MwvV1WjUPxQwif+eNDPnKly9Atc5LO8ijOInlMqgCZCjNxR1tEFKNHgH5
         6a1B98yiE7lsVy1aJFPlAJ3ka/G8773p5mL+lA7U/cIKH6swEE3axzzx7bIUvVALJetC
         hm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680927120;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DrbRjSdQRr9IJPgCGlzD/ebgWSH8jxp+2pjblcvsCNU=;
        b=vGj8w8PWIkKbQ48VvACqtRJTnqYP1/z7JoqNKUfnGr3fuuDa/P9mCiUnC+eQViIe6x
         w5YyfqXr+TyQvXGOTPhiUizYKMrtX82ffXWOPluuqq9aEP/VCsD/S9hke6O4iHID3yi9
         FVRe+IFXwKY4ALtjn2J+iAiZI48rPJWPdlyJoNfgN2rfFHmbrK41icm1tKUx2+oTWS1M
         eggsu+mVR0r4H5s9rbjtPJKgWXLslQc69hp4wK0eM8sIHYCDTvirUOh8g7/DVcODNu8l
         oSUDGuBmxwzwzpDedmO1I/1dC5mX2+8frQeGnQk8rwhXJ53tBkdlQYzwmalLPmP1jUan
         Kjqg==
X-Gm-Message-State: AAQBX9f5+ke8ouW+fc29mzNYwfU40xXKs4Q35ohOVNpTF1ZEFvl2Uo2B
        Aj4cMk+7QiNNFIS3LBHSIHCc6P1Ls/Y5JLXPAZc=
X-Google-Smtp-Source: AKy350a2Dou1sBzW+L+pK+5sDjKIGKlGBWD/Evy+dvwH4vTfXQITiNtfy5ePav5W2XyexmKtr3SJDqt6P48ew/DYtqg=
X-Received: by 2002:a25:e0cf:0:b0:b7d:87f:ce3e with SMTP id
 x198-20020a25e0cf000000b00b7d087fce3emr3036525ybg.6.1680927119735; Fri, 07
 Apr 2023 21:11:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230405175111.5974-1-wedsonaf@gmail.com> <20230405175111.5974-13-wedsonaf@gmail.com>
 <68b859ca-f67b-07dd-c5c7-7f8884e5b9f1@protonmail.com>
In-Reply-To: <68b859ca-f67b-07dd-c5c7-7f8884e5b9f1@protonmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Sat, 8 Apr 2023 01:11:52 -0300
Message-ID: <CANeycqqbDU1a3wDmsdiXUSEb=jeDxLQrhXsbnwWsk0zmmUxBwA@mail.gmail.com>
Subject: Re: [PATCH v2 13/13] rust: sync: introduce `LockedBy`
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

On Fri, 7 Apr 2023 at 18:00, Benno Lossin <y86-dev@protonmail.com> wrote:
>
> On 05.04.23 19:51, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This allows us to have data protected by a lock despite not being
> > wrapped by it. Access is granted by providing evidence that the lock is
> > held by the caller.
> >
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: Added build_assert to rule out zero-sized types
> >
> >   rust/kernel/sync.rs           |   2 +
> >   rust/kernel/sync/lock.rs      |   2 +-
> >   rust/kernel/sync/locked_by.rs | 128 ++++++++++++++++++++++++++++++++++
> >   3 files changed, 131 insertions(+), 1 deletion(-)
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
> > index 000000000000..191e37d804e5
> > --- /dev/null
> > +++ b/rust/kernel/sync/locked_by.rs
> > @@ -0,0 +1,128 @@
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
>
> Maybe add that the `access`/`access_mut` functions panic when the supplied
> external value is not the correct one.

Will do for v3.

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
>
> I think it would be sensible to also do the ZST check here, then it will
> fail immediately on construction (but also keep the other location, as it
> does not add any runtime cost).

This ZST restriction on `U` applies to `access` and `access_mut`, but
doesn't apply to versions of these functions that work on `Guard`
instances, which we have in the `rust` branch but not here yet. (The
restrictions there are different.) So it doesn't make sense to block
the _creation_ of `LockedBy` instances if `access`/`access_mut` are
never used.

> Also, I think you should mention in the documentation that ZSTs are not
> supported. And it would be good to have an explaining comment on the
> `build_assert!` why we disallow ZSTs here.

I'll add comments in v3 to access/access_mut.

> > +        Self {
> > +            owner: owner.data.get(),
> > +            data: UnsafeCell::new(data),
> > +        }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized, U> LockedBy<T, U> {
> > +    /// Returns a reference to the protected data when the caller provides evidence (via a
> > +    /// reference) that the owner is locked.
>
> Maybe add a `# Panic` section, also for `access_mut`.
>
> --
> Cheers,
> Benno
>
> > +    pub fn access<'a>(&'a self, owner: &'a U) -> &'a T {
> > +        crate::build_assert!(core::mem::size_of::<U>() > 0);
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
> > +        crate::build_assert!(core::mem::size_of::<U>() > 0);
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
