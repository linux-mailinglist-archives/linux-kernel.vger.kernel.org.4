Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0D356DF302
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbjDLLSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbjDLLR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:17:56 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 877066EA5;
        Wed, 12 Apr 2023 04:17:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id e127so11251716ybf.8;
        Wed, 12 Apr 2023 04:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681298205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9vgeMqqjwy92KIDibUs2lkkbVvQINAuG9wgc3eeu+E=;
        b=YugBswhPW+UhUWOJGhp/3WcZfP2rk1uY6rRxt7D9a45ZGQi7bmJwVshblR38ZWSTDH
         23IewvaIooujWdTVmhuNFhegCozkDECYBPgvRVChB8msUVI2SNVgrjIH7lYnlOZYMohJ
         Pgv9jvUJ5kmmdfZf6nXgVV3aLtUk+TfVIDQtgThI6UyIuFbbtKleLyRh7+Nsf78yem0J
         pkUqD8mx7kBIRxzJHncZ1nqcswhDiiCjKqqOykPVV0PacTIAh7A2XPyC4YfLVvVbKaDS
         KsYEWmD7m0tclgJ8bDmrrrnm/ukRg7yjFngUYgI8HK5JBmsz1XWk1UBlY9imNPMgsaVG
         FLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681298205;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9vgeMqqjwy92KIDibUs2lkkbVvQINAuG9wgc3eeu+E=;
        b=2X6RFWcfyPIu1yI7MFoPxifrEiJe+GXNs3E4kqs4TkW/k/zBMedCzzoW5w9/3X+08i
         BTHXyKwa+2f0CxIvZabwAZBlnBpkGvdQCkJHk8y8rSzF0aLbOMLFnWi3HDpX1HFr2bsJ
         UNdZkDxLU3gCdDD2BGQpgZVVuPZJDEn81roLljtB+te6BKz1o7wYLdHJ/o1CA8bElEmY
         OrFmi9mLt9+JKBjYowPjLKd7iNDck1cQc+sD15sCIb4510CI26cHiTi6uTt/7eR7qoYO
         6ThXCxF1xPAzEaF3Urgn8xeQET5z0HYF8BHJtWQz2nBagyta+nV2GSRoVy3w13d878Le
         CYMg==
X-Gm-Message-State: AAQBX9fmBDq1LbncWk46wn7p69pbdppwYi/FFBCu0e+nydt0TYqdR30J
        t8o0DvuXalN4lYy6VNkA+GFpspaVk1/me3duEnA=
X-Google-Smtp-Source: AKy350ZogyWOgeIKf0FJs7/NpXzfm0pEigEA01THt0IprIJDLF6hOjHgmhMxlHgIUinKnvrvqgCTGZU0vUFdGSTaYo0=
X-Received: by 2002:a25:7390:0:b0:b6e:d788:eba4 with SMTP id
 o138-20020a257390000000b00b6ed788eba4mr8849797ybc.6.1681298204957; Wed, 12
 Apr 2023 04:16:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-11-wedsonaf@gmail.com>
 <20230411215413.7720246f.gary@garyguo.net>
In-Reply-To: <20230411215413.7720246f.gary@garyguo.net>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 12 Apr 2023 08:16:34 -0300
Message-ID: <CANeycqon3yUn_666ozTiU_G=16JcnRS54cdu28Yxd0=Pm_jpzA@mail.gmail.com>
Subject: Re: [PATCH v4 11/13] rust: lock: add `Guard::do_unlocked`
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

On Tue, 11 Apr 2023 at 17:54, Gary Guo <gary@garyguo.net> wrote:
>
> On Tue, 11 Apr 2023 02:45:41 -0300
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > It releases the lock, executes some function provided by the caller,
> > then reacquires the lock. This is preparation for the implementation of
> > condvars, which will sleep after between unlocking and relocking.
> >
> > We need an explicit `relock` method for primitives like `SpinLock` that
> > have an irqsave variant: we use the guard state to determine if the lock
> > was originally acquired with the regular `lock` function or
> > `lock_irqsave`.
> >
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: No changes
> > v2 -> v3: No changes
> > v3 -> v4: No changes
> >
> >  rust/kernel/sync/lock.rs          | 25 +++++++++++++++++++++++++
> >  rust/kernel/sync/lock/spinlock.rs | 17 +++++++++++++++--
> >  2 files changed, 40 insertions(+), 2 deletions(-)
> >
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index 819b8ea5ba2b..cde57756795f 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -22,6 +22,9 @@ pub mod spinlock;
> >  ///
> >  /// - Implementers must ensure that only one thread/CPU may access the protected data once the lock
> >  /// is owned, that is, between calls to `lock` and `unlock`.
> > +/// - Implementers must also ensure that `relock` uses the same locking method as the original
> > +/// lock operation. For example, it should disable interrupts if [`IrqSaveBackend::lock_irqsave`]
> > +/// is used.
> >  pub unsafe trait Backend {
> >      /// The state required by the lock.
> >      type State;
> > @@ -55,6 +58,17 @@ pub unsafe trait Backend {
> >      ///
> >      /// It must only be called by the current owner of the lock.
> >      unsafe fn unlock(ptr: *mut Self::State, guard_state: &Self::GuardState);
> > +
> > +    /// Reacquires the lock, making the caller its owner.
> > +    ///
> > +    /// # Safety
> > +    ///
> > +    /// Callers must ensure that `state` comes from a previous call to [`Backend::lock`] (or
> > +    /// variant) that has been unlocked with [`Backend::unlock`] and will be relocked now.
> > +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> > +        // SAFETY: The safety requirements ensure that the lock is initialised.
> > +        *guard_state = unsafe { Self::lock(ptr) };
> > +    }
> >  }
> >
> >  /// The "backend" of a lock that supports the irq-save variant.
> > @@ -164,6 +178,17 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
> >  // SAFETY: `Guard` is sync when the data protected by the lock is also sync.
> >  unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
> >
> > +impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
> > +    #[allow(dead_code)]
> > +    pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
> > +        // SAFETY: The caller owns the lock, so it is safe to unlock it.
> > +        unsafe { B::unlock(self.lock.state.get(), &self.state) };
> > +        cb();
> > +        // SAFETY: The lock was just unlocked above and is being relocked now.
> > +        unsafe { B::relock(self.lock.state.get(), &mut self.state) };
>
> This should be
>
>         let _guard = ScopeGuard::new(|| unsafe {
>             B::relock(self.lock.state.get(), &mut self.state) }
>         });
>         cb();
>
> Although we currently use `-Cpanic=abort`, I think as a general rule we
> should still try to make code unwind-safe, so it can remain sound if
> someone takes the code and use it for userspace (e.g. for testing
> purpose, or maybe sharing codebase with tools).

Good point. Although this has not been something we cared about in the
last couple of years because we abort, I think we should carefully
review code for this as we upstream.

It is also important for async scenarios: we need to go back to a
consistent state when we tear down `Future` instances.

> > +    }
> > +}
> > +
> >  impl<T: ?Sized, B: Backend> core::ops::Deref for Guard<'_, T, B> {
> >      type Target = T;
> >
> > diff --git a/rust/kernel/sync/lock/spinlock.rs b/rust/kernel/sync/lock/spinlock.rs
> > index 34dec09a97c0..e2a2f68e6d93 100644
> > --- a/rust/kernel/sync/lock/spinlock.rs
> > +++ b/rust/kernel/sync/lock/spinlock.rs
> > @@ -4,6 +4,7 @@
> >  //!
> >  //! This module allows Rust code to use the kernel's `spinlock_t`.
> >
> > +use super::IrqSaveBackend;
> >  use crate::bindings;
> >
> >  /// Creates a [`SpinLock`] initialiser with the given name and a newly-created lock class.
> > @@ -95,7 +96,8 @@ pub type SpinLock<T> = super::Lock<T, SpinLockBackend>;
> >  /// A kernel `spinlock_t` lock backend.
> >  pub struct SpinLockBackend;
> >
> > -// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion.
> > +// SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. `relock` uses the
> > +// same scheme as `unlock` to figure out which locking method was used originally.
> >  unsafe impl super::Backend for SpinLockBackend {
> >      type State = bindings::spinlock_t;
> >      type GuardState = Option<core::ffi::c_ulong>;
> > @@ -127,13 +129,24 @@ unsafe impl super::Backend for SpinLockBackend {
> >              None => unsafe { bindings::spin_unlock(ptr) },
> >          }
> >      }
> > +
> > +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> > +        let _ = match guard_state {
> > +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> > +            // initialised.
> > +            None => unsafe { Self::lock(ptr) },
> > +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> > +            // initialised.
> > +            Some(_) => unsafe { Self::lock_irqsave(ptr) },
> > +        };
> > +    }
> >  }
> >
> >  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
> >  // variant of the C lock acquisition functions to disable interrupts and retrieve the original
> >  // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
> >  // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> > -unsafe impl super::IrqSaveBackend for SpinLockBackend {
> > +unsafe impl IrqSaveBackend for SpinLockBackend {
> >      unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
> >          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
> >          // memory, and that it has been initialised before.
>
