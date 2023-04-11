Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BD036DCFE2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 04:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjDKC7o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 22:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjDKC7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 22:59:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34D3270D;
        Mon, 10 Apr 2023 19:59:41 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id ch3so7728430ybb.4;
        Mon, 10 Apr 2023 19:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681181981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ivhYgDC1kDSsdzi3ooInuOL1tYuYF6aOjYno/V0sCT4=;
        b=KjhfgC4N95JAZhzKrSxFV/ei9UWvDvs/QL3soqPjcl+M8SBeSYzAlEEWnLcomTS5mv
         Q72yS5nYzczf31Gl0JVRFW9NPXHpmUx3IevQIyh1KPgHf/eK55E630P7g0JtlAYUyn0U
         p/6Oe0xbG4frCA9ki43pb/JXPF1F4Yf20WVU0CtuEd4DvrY14nQEqwAyVOyVXuRfTBz6
         5nQwgdjMCgrpoe2b3Jtg3miRZz7BVkRVjQ+BV3TWpvyyfPXsfqDlG0opBlRwhJV7Q6Ml
         1t6eqwqBOKSZDpJi7OTi9fVXFTsY/XdVB5Kb5QiyLtod13UQZ9as/5jcRCSkO0V/3JnV
         hPzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681181981;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ivhYgDC1kDSsdzi3ooInuOL1tYuYF6aOjYno/V0sCT4=;
        b=L/WhnQYRv56tJQ12oOlv3DUjGfW77qK4RfDfQnR0SwhHCLmb66J9SdIetloMItWJTv
         SCfjPZIpDjef/hZtxIxCAv8xiRQB+uoZKsWp0WzFAQN1Q7EVqocGn/1MLvlyJKPF+4tC
         q8vdGYJbOEF815CMquKUk8Jvtr2UrI/khz0eb6Mf+vUeLoGasUSuz1h4YqBLO3N8v7Oz
         9yhnMEnBNdOr6vo9Z9SjItbLa6uXapC3LRV3M8qD1+C8Y9Bn+pNjWTLGxujVJHlkFHz9
         mQyModnrXAr3MeJ5F7k4j+R7KIqL4OrDmRzJVLTcW6JhDXN4DhvjomNp7/Dx9AU7L42+
         1TWw==
X-Gm-Message-State: AAQBX9c2IigI+omGUcd+SzkKlsbz1NBz+YQNFTBoMxm/e1rbHe4qi0WN
        893BmBtP0Eukv7QQ6ZxmPpaz7/D8No4kwNHCxJ878oEf
X-Google-Smtp-Source: AKy350b99+TXNPfGHJpiDptMUukFH4qqlODGir9zcjh5zkAAsTr4+JL3jM5C+PtPoYXTfmt6dYUVG7x4WuLKgYhVSFM=
X-Received: by 2002:a25:d705:0:b0:b6b:6a39:949c with SMTP id
 o5-20020a25d705000000b00b6b6a39949cmr4240553ybg.6.1681181980810; Mon, 10 Apr
 2023 19:59:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230408075340.25237-1-wedsonaf@gmail.com> <20230408075340.25237-12-wedsonaf@gmail.com>
 <d33c531d-f707-bb29-9220-ced717079fbd@gmail.com>
In-Reply-To: <d33c531d-f707-bb29-9220-ced717079fbd@gmail.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Mon, 10 Apr 2023 23:59:29 -0300
Message-ID: <CANeycqouQfd8KMroWmmqx1BAsjVQKdPucHBVi91e0gR6vPViKg@mail.gmail.com>
Subject: Re: [PATCH v3 12/13] rust: sync: introduce `CondVar`
To:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
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

On Sun, 9 Apr 2023 at 13:49, Martin Rodriguez Reboredo
<yakoyoku@gmail.com> wrote:
>
> On 4/8/23 04:53, Wedson Almeida Filho wrote:
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > This is the traditional condition variable or monitor synchronisation
> > primitive. It is implemented with C's `wait_queue_head_t`.
> >
> > It allows users to release a lock and go to sleep while guaranteeing
> > that notifications won't be missed. This is achieved by enqueuing a wait
> > entry before releasing the lock.
> >
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Waiman Long <longman@redhat.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: Use the new `current` macro
> > v2 -> v3: Use new Opaque::ffi_init from Benno's series
> >
> >  rust/bindings/bindings_helper.h |   1 +
> >  rust/helpers.c                  |   7 ++
> >  rust/kernel/sync.rs             |   2 +
> >  rust/kernel/sync/condvar.rs     | 174 ++++++++++++++++++++++++++++++++
> >  rust/kernel/sync/lock.rs        |   1 -
> >  5 files changed, 184 insertions(+), 1 deletion(-)
> >  create mode 100644 rust/kernel/sync/condvar.rs
> >
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index 03656a44a83f..50e7a76d5455 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/slab.h>
> >  #include <linux/refcount.h>
> > +#include <linux/wait.h>
> >  #include <linux/sched.h>
> >
> >  /* `bindgen` gets confused at certain things. */
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index 96441744030e..8ff2559c1572 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/spinlock.h>
> >  #include <linux/sched/signal.h>
> > +#include <linux/wait.h>
> >
> >  __noreturn void rust_helper_BUG(void)
> >  {
> > @@ -76,6 +77,12 @@ void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
> >
> > +void rust_helper_init_wait(struct wait_queue_entry *wq_entry)
> > +{
> > +     init_wait(wq_entry);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_init_wait);
> > +
> >  int rust_helper_signal_pending(struct task_struct *t)
> >  {
> >       return signal_pending(t);
> > diff --git a/rust/kernel/sync.rs b/rust/kernel/sync.rs
> > index c997ff7e951e..431402180aa8 100644
> > --- a/rust/kernel/sync.rs
> > +++ b/rust/kernel/sync.rs
> > @@ -8,9 +8,11 @@
> >  use crate::types::Opaque;
> >
> >  mod arc;
> > +mod condvar;
> >  pub mod lock;
> >
> >  pub use arc::{Arc, ArcBorrow, UniqueArc};
> > +pub use condvar::CondVar;
> >  pub use lock::{mutex::Mutex, spinlock::SpinLock};
> >
> >  /// Represents a lockdep class. It's a wrapper around C's `lock_class_key`.
> > diff --git a/rust/kernel/sync/condvar.rs b/rust/kernel/sync/condvar.rs
> > new file mode 100644
> > index 000000000000..ef882e2af746
> > --- /dev/null
> > +++ b/rust/kernel/sync/condvar.rs
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! A condition variable.
> > +//!
> > +//! This module allows Rust code to use the kernel's [`struct wait_queue_head`] as a condition
> > +//! variable.
> > +
> > +use super::{lock::Backend, lock::Guard, LockClassKey};
> > +use crate::{bindings, init::PinInit, pin_init, str::CStr, types::Opaque};
> > +use core::marker::PhantomPinned;
> > +use macros::pin_data;
> > +
> > +/// Creates a [`CondVar`] initialiser with the given name and a newly-created lock class.
> > +#[macro_export]
> > +macro_rules! new_condvar {
> > +    ($($name:literal)?) => {
> > +        $crate::sync::CondVar::new($crate::optional_name!($($name)?), $crate::static_lock_class!())
> > +    };
> > +}
> > +
> > +/// A conditional variable.
> > +///
> > +/// Exposes the kernel's [`struct wait_queue_head`] as a condition variable. It allows the caller to
> > +/// atomically release the given lock and go to sleep. It reacquires the lock when it wakes up. And
> > +/// it wakes up when notified by another thread (via [`CondVar::notify_one`] or
> > +/// [`CondVar::notify_all`]) or because the thread received a signal. It may also wake up
> > +/// spuriously.
> > +///
> > +/// Instances of [`CondVar`] need a lock class and to be pinned. The recommended way to create such
> > +/// instances is with the [`pin_init`](crate::pin_init) and [`new_condvar`] macros.
> > +///
> > +/// # Examples
> > +///
> > +/// The following is an example of using a condvar with a mutex:
> > +///
> > +/// ```
> > +/// use kernel::sync::{CondVar, Mutex};
> > +/// use kernel::{new_condvar, new_mutex};
> > +///
> > +/// #[pin_data]
> > +/// pub struct Example {
> > +///     #[pin]
> > +///     value: Mutex<u32>,
> > +///
> > +///     #[pin]
> > +///     value_changed: CondVar,
> > +/// }
> > +///
> > +/// /// Waits for `e.value` to become `v`.
> > +/// fn wait_for_vaue(e: &Example, v: u32) {
>
> Should it be `wait_for_value`?

Yes, thanks for spotting this. Will fix.

>
> > +///     let mut guard = e.value.lock();
> > +///     while *guard != v {
> > +///         e.value_changed.wait_uninterruptible(&mut guard);
> > +///     }
> > +/// }
> > +///
> > +/// /// Increments `e.value` and notifies all potential waiters.
> > +/// fn increment(e: &Example) {
> > +///     *e.value.lock() += 1;
> > +///     e.value_changed.notify_all();
> > +/// }
> > +///
> > +/// /// Allocates a new boxed `Example`.
> > +/// fn new_example() -> Result<Pin<Box<Example>>> {
> > +///     Box::pin_init(pin_init!(Example {
> > +///         value <- new_mutex!(0),
> > +///         value_changed <- new_condvar!(),
> > +///     }))
> > +/// }
> > +/// ```
> > +///
> > +/// [`struct wait_queue_head`]: ../../../include/linux/wait.h
> > +#[pin_data]
> > +pub struct CondVar {
> > +    #[pin]
> > +    pub(crate) wait_list: Opaque<bindings::wait_queue_head>,
> > +
> > +    /// A condvar needs to be pinned because it contains a [`struct list_head`] that is
> > +    /// self-referential, so it cannot be safely moved once it is initialised.
> > +    #[pin]
> > +    _pin: PhantomPinned,
> > +}
> > +
> > +// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on any thread.
> > +#[allow(clippy::non_send_fields_in_send_ty)]
> > +unsafe impl Send for CondVar {}
> > +
> > +// SAFETY: `CondVar` only uses a `struct wait_queue_head`, which is safe to use on multiple threads
> > +// concurrently.
> > +unsafe impl Sync for CondVar {}
> > +
> > +impl CondVar {
> > +    /// Constructs a new condvar initialiser.
> > +    #[allow(clippy::new_ret_no_self)]
> > +    pub fn new(name: &'static CStr, key: &'static LockClassKey) -> impl PinInit<Self> {
> > +        pin_init!(Self {
> > +            _pin: PhantomPinned,
> > +            // SAFETY: `slot` is valid while the closure is called and both `name` and `key` have
> > +            // static lifetimes so they live indefinitely.
> > +            wait_list <- Opaque::ffi_init(|slot| unsafe {
> > +                bindings::__init_waitqueue_head(slot, name.as_char_ptr(), key.as_ptr())
> > +            }),
> > +        })
> > +    }
> > +
> > +    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> > +        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
> > +
> > +        // SAFETY: `wait` points to valid memory.
> > +        unsafe { bindings::init_wait(wait.get()) };
> > +
> > +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> > +        unsafe {
> > +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
> > +        };
> > +
> > +        // SAFETY: No arguments, switches to another thread.
> > +        guard.do_unlocked(|| unsafe { bindings::schedule() });
> > +
> > +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> > +        unsafe { bindings::finish_wait(self.wait_list.get(), wait.get()) };
> > +    }
> > +
> > +    /// Releases the lock and waits for a notification in interruptible mode.
> > +    ///
> > +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> > +    /// thread to sleep, reacquiring the lock on wake up. It wakes up when notified by
> > +    /// [`CondVar::notify_one`] or [`CondVar::notify_all`], or when the thread receives a signal.
> > +    /// It may also wake up spuriously.
> > +    ///
> > +    /// Returns whether there is a signal pending.
> > +    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
> > +    pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
> > +        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard);
> > +        crate::current!().signal_pending()
> > +    }
> > +
> > +    /// Releases the lock and waits for a notification in uninterruptible mode.
> > +    ///
> > +    /// Similar to [`CondVar::wait`], except that the wait is not interruptible. That is, the
> > +    /// thread won't wake up due to signals. It may, however, wake up supirously.
> > +    pub fn wait_uninterruptible<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) {
> > +        self.wait_internal(bindings::TASK_UNINTERRUPTIBLE, guard)
> > +    }
> > +
> > +    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
> > +    fn notify(&self, count: i32, flags: u32) {
> > +        // SAFETY: `wait_list` points to valid memory.
> > +        unsafe {
> > +            bindings::__wake_up(
> > +                self.wait_list.get(),
> > +                bindings::TASK_NORMAL,
> > +                count,
> > +                flags as _,
> > +            )
> > +        };
> > +    }
> > +
> > +    /// Wakes a single waiter up, if any.
> > +    ///
> > +    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> > +    /// completely (as opposed to automatically waking up the next waiter).
> > +    pub fn notify_one(&self) {
> > +        self.notify(1, 0);
> > +    }
> > +
> > +    /// Wakes all waiters up, if any.
> > +    ///
> > +    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> > +    /// completely (as opposed to automatically waking up the next waiter).
> > +    pub fn notify_all(&self) {
> > +        self.notify(0, 0);
> > +    }
> > +}
> > diff --git a/rust/kernel/sync/lock.rs b/rust/kernel/sync/lock.rs
> > index a2c654ec5bd3..c365bc909dff 100644
> > --- a/rust/kernel/sync/lock.rs
> > +++ b/rust/kernel/sync/lock.rs
> > @@ -179,7 +179,6 @@ pub struct Guard<'a, T: ?Sized, B: Backend> {
> >  unsafe impl<T: Sync + ?Sized, B: Backend> Sync for Guard<'_, T, B> {}
> >
> >  impl<T: ?Sized, B: Backend> Guard<'_, T, B> {
> > -    #[allow(dead_code)]
> >      pub(crate) fn do_unlocked(&mut self, cb: impl FnOnce()) {
> >          // SAFETY: The caller owns the lock, so it is safe to unlock it.
> >          unsafe { B::unlock(self.lock.state.get(), &self.state) };
>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
