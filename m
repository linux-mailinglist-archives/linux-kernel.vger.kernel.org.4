Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CBC6DCFE7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 05:03:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjDKDC6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 23:02:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjDKDCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 23:02:18 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5412D4E;
        Mon, 10 Apr 2023 20:02:06 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-54c0c86a436so254335397b3.6;
        Mon, 10 Apr 2023 20:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681182126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iDrT2xWORuHMEvyUDrFYP/EZ+yVFK4BCHBMls8FGano=;
        b=EfM0lwjs/Sg5SfHWhtRaT5GMyVmWz9KBTYHchL3910wwu6QCp584ocaFA9Tcm3mckM
         JIu4kDqZ9vxEm61qPa8XxYxQ3Gkp7E669BwbWxdb2rQ2yuF4oqVxEbXtQSF5qw3WBbg+
         /zOwjv4ajseZtrEfPCGflbAds9gFmPvwXILfYSn42ln0+vR8t1pvcAIiaDw+S1ght6fw
         DuufxwiCsSuH0HaAvUJU+/5jrDjR/0pRkAoxMM6JRSRxFYKl8kTsnM7jd3kTrFod7fCb
         +Qv+DjUFNuMZ17f5RQaAOQNgUBZ2yUCQE2kOMvMIzQArGwq0LfGaHczNV97FATH+CMV6
         ++Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681182126;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iDrT2xWORuHMEvyUDrFYP/EZ+yVFK4BCHBMls8FGano=;
        b=rVl/dCf+m5lOmxOj3yYldtPw+YHo/9ENI+prPFj9wyGhvEqU11GYFvqYH2D57NM4Hh
         frQK8x2AS5IYBH18T8LD/MFtPwpvj3vrTQs55gsZom8foOI/d3ob/iZGGY3sPXr2Umjf
         q3wZ5oXqVeJAY0o3YYjB+SEzlkzr8p/GPBC7Rn0KMsv6byExz9JD+aFNU517ne+hNbQ8
         9ET9FPdVp0+PhwofV6wKSNerebvoznO+uqtHIqmEIzL9LPmcfEZz1/Z7zBi9inReb1a9
         O6zFPLTTeOympo++Jzu7nLyFbnzBvNgymP0Vr+5Niyifna7kb0pMFU5AsMDOOlNrDpq+
         xQHQ==
X-Gm-Message-State: AAQBX9ciyJXtBEV+/JdBL6rOEoWkEFT8F28R0BxYXjs1eZejPdGrEzSo
        ZdKYQg6XQ5bQB0X3qimFgsCEKRkuZWo9wrVuSxk=
X-Google-Smtp-Source: AKy350axJIP8B5/f+6AoBHa6kJj+V9jKKePuLbMKWQjZnv0F/bxTpaYJiAWDXsvkOI/dHcbOehmqbMwrB3WhaA10ouk=
X-Received: by 2002:a81:431e:0:b0:545:883a:544d with SMTP id
 q30-20020a81431e000000b00545883a544dmr7280139ywa.9.1681182125664; Mon, 10 Apr
 2023 20:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230408075340.25237-1-wedsonaf@gmail.com> <20230408075340.25237-2-wedsonaf@gmail.com>
 <50d1083b-10a4-941a-7e50-2aa0b6eb3867@gmail.com>
In-Reply-To: <50d1083b-10a4-941a-7e50-2aa0b6eb3867@gmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Tue, 11 Apr 2023 00:01:54 -0300
Message-ID: <CANeycqr+MUYVWzuaidejpGFhEEaPOmA0SGOTXOaCGTQY5FvqVQ@mail.gmail.com>
Subject: Re: [PATCH v3 02/13] rust: sync: introduce `Lock` and `Guard`
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
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

On Sun, 9 Apr 2023 at 13:47, Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 4/8/23 04:53, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > They are generic Rust implementations of a lock and a lock guard that
> > contain code that is common to all locks. Different backends will be
> > introduced in subsequent commits.
> >
> > Suggested-by: Gary Guo <gary@garyguo.net>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: No changes
> > v2 -> v3: Use new Opaque::ffi_init from Benno's series
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
> > index 000000000000..3fa4eefde740
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
> > +/// specified as the generic parameter `T`.
>
> I think this meant that it is specified by `B` and wraps `T`.

Yes, I meant `B` here. Will fix.

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
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
