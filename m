Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56C8E6DF3E7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:40:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDLLjm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:39:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbjDLLjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:39:13 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2616E8D;
        Wed, 12 Apr 2023 04:38:50 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id d204so2919398ybh.6;
        Wed, 12 Apr 2023 04:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681299529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=n3dVbDu7hAlbrDiv9/ZUJT5TunPW1jIu8qSPcKdVUhU=;
        b=E8YA+5NwAFyuyF5c9CAsk6B3qXsfn6KDFcmfhhsycsEhhLITBpjTy8RyTKB8oyWR8/
         z8WN9HxcDM4Zpyt9tSxUyb+SZAwuBr+jG8WPlXt+DrU3H74bqT7+46BYsddmRAd2dbBN
         PRVK9XdznWPklPcpGIrVIJaSBuZj3D7s0IQQm1a6zZFimcxTzy3K4c81Yf9vcXdX/Tak
         7OW8sl1zchJTB429wrO68zU27RYjFwWJKDB2UMBO3QHlUBaJX6YpwosWDg9E7AbHeRcU
         aM9j8E8xBYHBUgCx/LRkSYa/fzNqyMMqnc/7Kg/t6epWC+NPOt3zzfZcNx6hd3+qv626
         8tsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681299529;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=n3dVbDu7hAlbrDiv9/ZUJT5TunPW1jIu8qSPcKdVUhU=;
        b=xBzY5TswBY8bxeyy9m9sqSPCWXU6mhB4dOASenf4f4cGtktEJxC/Iy7SN9BVqi7cJ+
         YZ/55LG4R4jzTCgCmf2Tjg9sJeJFNMhq5pos7Jz1GgtQYY3Uuv35F26AiKMrmWw4Yf6g
         WrxQLGqOYuklFumEURfnjresTLP0mfisYpmUwlaYChMOWTzuIyzmDGr0S4WVDcvcW/lC
         /wOL+0VdYGYRr3uUqPL+X+E6icd1vy2wtjKGmAeaIU9Bbp07edkc16/+VylYeLrs56Fe
         KY+49Qa7N2aWQD85xDRTS0xd/4d7UYGfbMGpXJTuj/VYKUcMT/OODIVF1luYRPg3a7dw
         ViSA==
X-Gm-Message-State: AAQBX9f0Dq9OF4PApsi1eqruuCnSINpOxc9YYHDZ8KxAUf2cA3O2urU7
        HMUAfwc+0ncWYt4SjrpFMxXE5xCJaYX7OvABy/A=
X-Google-Smtp-Source: AKy350brNge+xFYJe3IaBRFamG5X/vSyGyNc5rgLbVaEWJaioYUVHjGnuijcFavHtqRc1Yin0k92d8Y8dJ0l3WWZ3lM=
X-Received: by 2002:a25:d705:0:b0:b6b:6a39:949c with SMTP id
 o5-20020a25d705000000b00b6b6a39949cmr6851264ybg.6.1681299528860; Wed, 12 Apr
 2023 04:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-2-wedsonaf@gmail.com>
 <20230411214205.5753343f.gary@garyguo.net>
In-Reply-To: <20230411214205.5753343f.gary@garyguo.net>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 12 Apr 2023 08:38:37 -0300
Message-ID: <CANeycqqM-k2odQzNffaYQ6Nrxii=XUp3VsQ8mQ3vw=WA5mykJw@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] rust: sync: introduce `Lock` and `Guard`
To:     Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Apr 2023 at 17:42, Gary Guo <gary@garyguo.net> wrote:
>
> On Tue, 11 Apr 2023 02:45:32 -0300
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > They are generic Rust implementations of a lock and a lock guard that
> > contain code that is common to all locks. Different backends will be
> > introduced in subsequent commits.
> >
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Suggested-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: No changes
> > v2 -> v3: Use new Opaque::ffi_init from Benno's series
> > v3 -> v4: Fixed name of parameter in Lock comment
> >
> >  rust/kernel/sync.rs      |   2 +-
> >  rust/kernel/sync/lock.rs | 162 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 163 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/kernel/sync/lock.rs
> >
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index 541d235ffbeb..81b0998eaa18 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -8,6 +8,7 @@
> >  use crate::types::Opaque;
> >
> >  mod arc;
> > +pub mod lock;
> >
> >  pub use arc::{Arc, ArcBorrow, UniqueArc};
> >
> > @@ -25,7 +26,6 @@ impl LockClassKey {
> >          Self(Opaque::uninit())
> >      }
> >
> > -    #[allow(dead_code)]
> >      pub(crate) fn as_ptr(&self) -> *mut bindings::lock_class_key {
> >          self.0.get()
> >      }
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > new file mode 100644
> > index 000000000000..1a8ecccf4f24
> > --- /dev/null
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -0,0 +1,162 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Generic kernel lock and guard.
> > +//!
> > +//! It contains a generic Rust lock and guard that allow for different backends (e.g., mutexes,
> > +//! spinlocks, raw spinlocks) to be provided with minimal effort.
> > +
> > +use super::LockClassKey;
> > +use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
> > +use core::{cell::UnsafeCell, marker::PhantomData, marker::PhantomPinned};
> > +use macros::pin_data;
> > +
> > +/// The "backend" of a lock.
> > +///
> > +/// It is the actual implementation of the lock, without the need to repeat patterns used in all
> > +/// locks.
> > +///
> > +/// # Safety
> > +///
> > +/// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
> > +/// is owned, that is, between calls to `lock` and `unlock`.
> > +pub unsafe trait Backend {
> > +    /// The state required by the lock.
> > +    type State;
> > +
> > +    /// The state required to be kept between lock and unlock.
> > +    type GuardState;
> > +
> > +    /// Initialises the lock.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// `ptr` must be valid for write for the duration of the call, while `name` and `key` must
> > +    /// remain valid for read indefinitely.
> > +    unsafe fn init(
> > +        ptr: *mut Self::State,
> > +        name: *const core::ffi::c_char,
> > +        key: *mut bindings::lock_class_key,
> > +    );
>
> Any reason that this takes FFI types rather than just `&'static CStr` and `&'static LockClassKey`?

Yes, because we want to move work that is done by all backend
implementations into `Lock`. This includes calls to convert these to
ffi types.

> > +
> > +    /// Acquires the lock, making the caller its owner.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that [`Backend::init`] has been previously called.
> > +    #[must_use]
> > +    unsafe fn lock(ptr: *mut Self::State) -> Self::GuardState;
> > +
> > +    /// Releases the lock, giving up its ownership.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// It must only be called by the current owner of the lock.
> > +    unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
> > +}
> > +
> > +/// A mutual exclusion primitive.
> > +///
> > +/// Exposes one of the kernel locking primitives. Which one is exposed depends on the lock banckend
> > +/// specified as the generic parameter `B`.
> > +#[pin_data]
> > +pub struct Lock<T: ?Sized, B: Backend> {
> > +    /// The kernel lock object.
> > +    #[pin]
> > +    state: Opaque<B::State>,
> > +
> > +    /// Some locks are known to be self-referential (e.g., mutexes), while others are architecture
> > +    /// or config defined (e.g., spinlocks). So we conservatively require them to be pinned in case
> > +    /// some architecture uses self-references now or in the future.
> > +    #[pin]
> > +    _pin: PhantomPinned,
> > +
> > +    /// The data protected by the lock.
> > +    data: UnsafeCell<T>,
> > +}
> > +
> > +// SAFETY: `Lock` can be transferred across thread boundaries iff the data it protects can.
> > +unsafe impl<T: ?Sized + Send, B: Backend> Send for Lock<T, B> {}
> > +
> > +// SAFETY: `Lock` serialises the interior mutability it provides, so it is `Sync` as long as the
> > +// data it protects is `Send`.
> > +unsafe impl<T: ?Sized + Send, B: Backend> Sync for Lock<T, B> {}
> > +
> > +impl<T, B: Backend> Lock<T, B> {
> > +    /// Constructs a new lock initialiser.
> > +    #[allow(clippy::new_ret_no_self)]
> > +    pub fn new(t: T, name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> > +        pin_init!(Self {
> > +            data: UnsafeCell::new(t),
> > +            _pin: PhantomPinned,
> > +            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
> > +            // static lifetimes so they live indefinitely.
> > +            state <- Opaque::ffi_init(|slot| unsafe {
> > +                B::init(slot, name.as_char_ptr(), key.as_ptr())
> > +            }),
> > +        })
> > +    }
> > +}
>
> There is not drop implementation on `Lock`, which implies all locks can
> be just forgotten?

Yes, all locks can be forgotten.

> I believe we discussed a case where this is can lead to UAF when a lock
> is dropped while it is locked (e.g. because the guard is forgotten).

Yes, this is the issue brought up by Boqun:
https://github.com/Rust-for-Linux/linux/issues/862

The issue arises when a mutex guard is forgotten and the task that
owns it exits. Then another task trying to acquire the mutex will lead
to a UAF. A drop implementation on the lock doesn't solve this.

One solution is to increment the refcount on the current task when we
acquire the mutex and decrement it when we release, but if we do that,
the cost of acquiring/releasing a mutex gets much worse in Rust than
it is in C.

Another solution might be to force disable CONFIG_MUTEX_SPIN_ON_OWNER
when Rust is enabled, which is undesirable because it affects the
performance of C code as well.

Even a closure-based lock (which I believe you suggested at the time)
doesn't solve this completely because the thread may exit during the
closure execution and leave a dangling pointer in the mutex.

So we don't have a good solution for this yet.

> > +
> > +impl<T: ?Sized, B: Backend> Lock<T, B> {
> > +    /// Acquires the lock and gives the caller access to the data protected by it.
> > +    pub fn lock(&self) -> Guard<'_, T, B> {
> > +        // SAFETY: The constructor of the type calls `init`, so the existence of the object proves
> > +        // that `init` was called.
> > +        let state = unsafe { B::lock(self.state.get()) };
> > +        // SAFETY: The lock was just acquired.
> > +        unsafe { Guard::new(self, state) }
> > +    }
> > +}
> > +
> > +/// A lock guard.
> > +///
> > +/// Allows mutual exclusion primitives that implement the `Backend` trait to automatically unlock
> > +/// when a guard goes out of scope. It also provides a safe and convenient way to access the data
> > +/// protected by the lock.
> > +#[must_use = "the lock unlocks immediately when the guard is unused"]
> > +pub struct Guard<'a, T: ?Sized, B: Backend> {
> > +    pub(crate) lock: &'a Lock<T, B>,
> > +    pub(crate) state: B::GuardState,
> > +    _not_send: PhantomData<*mut ()>,
> > +}
> > +
> > +// SAFETY: `Guard` is sync when the data protected by the lock is also sync.
> > +unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
> > +
> > +impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
> > +    type Target = T;
> > +
> > +    fn deref(&self) -> &Self::Target {
> > +        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
> > +        unsafe { &*self.lock.data.get() }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized, B: Backend> core::ops::DerefMut for Guard<'_, T, B> {
> > +    fn deref_mut(&mut self) -> &mut Self::Target {
> > +        // SAFETY: The caller owns the lock, so it is safe to deref the protected data.
> > +        unsafe { &mut *self.lock.data.get() }
> > +    }
> > +}
> > +
> > +impl<T: ?Sized, B: Backend> Drop for Guard<'_, T, B> {
> > +    fn drop(&mut self) {
> > +        // SAFETY: The caller owns the lock, so it is safe to unlock it.
> > +        unsafe { B::unlock(self.lock.state.get(), &self.state) };
> > +    }
> > +}
> > +
> > +impl<'a, T: ?Sized, B: Backend> Guard<'a, T, B> {
> > +    /// Constructs a new immutable lock guard.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// The caller must ensure that it owns the lock.
> > +    pub(crate) unsafe fn new(lock: &'a Lock<T, B>, state: B::GuardState) -> Self {
> > +        Self {
> > +            lock,
> > +            state,
> > +            _not_send: PhantomData,
> > +        }
> > +    }
> > +}
>
