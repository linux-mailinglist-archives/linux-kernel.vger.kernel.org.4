Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054D86DF3F3
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 13:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDLLnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 07:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjDLLnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 07:43:02 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546287D8A;
        Wed, 12 Apr 2023 04:42:39 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-54ee17a659bso214720527b3.4;
        Wed, 12 Apr 2023 04:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681299756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sps2lgbVwDuXXXI80T/3O3aUQpu4+Dlo0VHxWSwvXYo=;
        b=YGwfJLx6dX9gIxIO9JL/EKtmxT51BuSvfU6Q2PTUTEn7o4Hu3wv8SZgErzJ1d+gLeu
         2YjCqihiktb4kVINCzxpjFrU2twYI5cbM49OKepZOS6cmt8Q5XCV/gLg/8yCudw7gfEc
         TmDWeMkubI/3PGxH+pmX/nmPYZlR9EZ99mInklPbUwQQoWCvUn9Q5vzZqScnCLdUIFt8
         VxeW5sOxPpj92W6YJYY70FKKbxPwk2g/FUA/4TQaWBwmFhxhH/MqkMVOM9F9wC/RgWxU
         t5Qqkj+C4roKx+VHrs0sdAA+PcNVgciNuJGw+2vEyaN5LbQaQEXANEt/rW24rEDf/qgr
         //uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681299756;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sps2lgbVwDuXXXI80T/3O3aUQpu4+Dlo0VHxWSwvXYo=;
        b=BlRYOSFaKeCJpc08//g6XIx+0vLsfClFO2ZnLF+xiCZXBef7UNAAFd/dV9qtetaaEH
         SahTtRDFmohMwKEtkqu8Ig/wzHdkV8mcPdpm34YvYBuxuBOjciM3Iy0nV4TFn6xjWL6e
         u5u4XotoBvMH8LKqT0O+tlVEm0lmDffqWEqzUOygmiU46ye3Ky215IjllUGkTd/zAu98
         ryBnSDOvCSi7BQ3k6jys/F2yq2hAcppPfQGURWR5cgbRGGxz/jyn5lwr+5v4Wk6Kf7wE
         vbMoCtaTfVw8PDrYkt6foch/nSfWupvs1uBEQ6bAqUX75WwX9OI61mpsajeUMuNVMmjn
         8emA==
X-Gm-Message-State: AAQBX9d66rx+XgMXb48AwqUaAEtPH7Rx86mZ83Zdrwy7f7txaK7Gf2EO
        SRQzk0wWAtal7L3NUdtr5hNl3wDGwFI9e74xtpk=
X-Google-Smtp-Source: AKy350anHGb0xKWZc1uPiKi4ebaK4nMT/gY8wz+WRQBvZOKoxHxYwwOFehDO/JYiq68CaQAzr1DtBZZZ9IBtHCgWeoE=
X-Received: by 2002:a05:690c:d0f:b0:545:f3ed:d251 with SMTP id
 cn15-20020a05690c0d0f00b00545f3edd251mr2030970ywb.1.1681299756014; Wed, 12
 Apr 2023 04:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230411054543.21278-1-wedsonaf@gmail.com> <20230411054543.21278-9-wedsonaf@gmail.com>
 <20230411214721.2d6f8fda.gary@garyguo.net>
In-Reply-To: <20230411214721.2d6f8fda.gary@garyguo.net>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Wed, 12 Apr 2023 08:42:25 -0300
Message-ID: <CANeycqrkTSOwf2TBQpanfYQ0bQkZiJUTZ+Lj-1uoZ1d13TEmaQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/13] rust: add basic `Task`
To:     Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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

On Tue, 11 Apr 2023 at 17:47, Gary Guo <gary@garyguo.net> wrote:
>
> On Tue, 11 Apr 2023 02:45:39 -0300
> Wedson Almeida Filho <wedsonaf@gmail.com> wrote:
>
> > From: Wedson Almeida Filho <walmeida@microsoft.com>
> >
> > It is an abstraction for C's `struct task_struct`. It implements
> > `AlwaysRefCounted`, so the refcount of the wrapped object is managed
> > safely on the Rust side.
> >
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> > Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> > ---
> > v1 -> v2: No changes
> > v2 -> v3: Wrap task_struct with `Opaque` instead of `UnsafeCell`
> > v3 -> v4: No changes
> >
> >  rust/bindings/bindings_helper.h |  1 +
> >  rust/helpers.c                  | 19 +++++++++
> >  rust/kernel/lib.rs              |  1 +
> >  rust/kernel/task.rs             | 75 +++++++++++++++++++++++++++++++++
> >  4 files changed, 96 insertions(+)
> >  create mode 100644 rust/kernel/task.rs
> >
> > diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> > index 75d85bd6c592..03656a44a83f 100644
> > --- a/rust/bindings/bindings_helper.h
> > +++ b/rust/bindings/bindings_helper.h
> > @@ -8,6 +8,7 @@
> >
> >  #include <linux/slab.h>
> >  #include <linux/refcount.h>
> > +#include <linux/sched.h>
> >
> >  /* `bindgen` gets confused at certain things. */
> >  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> > diff --git a/rust/helpers.c b/rust/helpers.c
> > index efd5b1e86f6e..f545923aedd8 100644
> > --- a/rust/helpers.c
> > +++ b/rust/helpers.c
> > @@ -24,6 +24,7 @@
> >  #include <linux/refcount.h>
> >  #include <linux/mutex.h>
> >  #include <linux/spinlock.h>
> > +#include <linux/sched/signal.h>
> >
> >  __noreturn void rust_helper_BUG(void)
> >  {
> > @@ -76,6 +77,12 @@ void rust_helper_spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_spin_unlock_irqrestore);
> >
> > +int rust_helper_signal_pending(struct task_struct *t)
> > +{
> > +     return signal_pending(t);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_signal_pending);
> > +
> >  refcount_t rust_helper_REFCOUNT_INIT(int n)
> >  {
> >       return (refcount_t)REFCOUNT_INIT(n);
> > @@ -112,6 +119,18 @@ long rust_helper_PTR_ERR(__force const void *ptr)
> >  }
> >  EXPORT_SYMBOL_GPL(rust_helper_PTR_ERR);
> >
> > +void rust_helper_get_task_struct(struct task_struct *t)
> > +{
> > +     get_task_struct(t);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_get_task_struct);
> > +
> > +void rust_helper_put_task_struct(struct task_struct *t)
> > +{
> > +     put_task_struct(t);
> > +}
> > +EXPORT_SYMBOL_GPL(rust_helper_put_task_struct);
> > +
> >  /*
> >   * We use `bindgen`'s `--size_t-is-usize` option to bind the C `size_t` type
> >   * as the Rust `usize` type, so we can use it in contexts where Rust
> > diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> > index 2d7606135ef6..ee27e10da479 100644
> > --- a/rust/kernel/lib.rs
> > +++ b/rust/kernel/lib.rs
> > @@ -44,6 +44,7 @@ mod static_assert;
> >  pub mod std_vendor;
> >  pub mod str;
> >  pub mod sync;
> > +pub mod task;
> >  pub mod types;
> >
> >  #[doc(hidden)]
> > diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> > new file mode 100644
> > index 000000000000..d70cad131956
> > --- /dev/null
> > +++ b/rust/kernel/task.rs
> > @@ -0,0 +1,75 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Tasks (threads and processes).
> > +//!
> > +//! C header: [`include/linux/sched.h`](../../../../include/linux/sched.h).
> > +
> > +use crate::{bindings, types::Opaque};
> > +use core::ptr;
> > +
> > +/// Wraps the kernel's `struct task_struct`.
> > +///
> > +/// # Invariants
> > +///
> > +/// All instances are valid tasks created by the C portion of the kernel.
> > +///
> > +/// Instances of this type are always ref-counted, that is, a call to `get_task_struct` ensures
> > +/// that the allocation remains valid at least until the matching call to `put_task_struct`.
> > +#[repr(transparent)]
> > +pub struct Task(pub(crate) Opaque<bindings::task_struct>);
> > +
> > +// SAFETY: It's OK to access `Task` through references from other threads because we're either
> > +// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
> > +// synchronised by C code (e.g., `signal_pending`).
> > +unsafe impl Sync for Task {}
> > +
> > +/// The type of process identifiers (PIDs).
> > +type Pid = bindings::pid_t;
>
> This'll just end up being `i32`. I think it'll be more desirable that
> this is defined as a new type.

We may very well decide that we want to make this a new type.

But that should be done in a different patch.

> > +
> > +impl Task {
> > +    /// Returns the group leader of the given task.
> > +    pub fn group_leader(&self) -> &Task {
> > +        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> > +        // have a valid group_leader.
> > +        let ptr = unsafe { *ptr::addr_of!((*self.0.get()).group_leader) };
> > +
> > +        // SAFETY: The lifetime of the returned task reference is tied to the lifetime of `self`,
> > +        // and given that a task has a reference to its group leader, we know it must be valid for
> > +        // the lifetime of the returned task reference.
> > +        unsafe { &*ptr.cast() }
> > +    }
> > +
> > +    /// Returns the PID of the given task.
> > +    pub fn pid(&self) -> Pid {
> > +        // SAFETY: By the type invariant, we know that `self.0` is a valid task. Valid tasks always
> > +        // have a valid pid.
> > +        unsafe { *ptr::addr_of!((*self.0.get()).pid) }
> > +    }
> > +
> > +    /// Determines whether the given task has pending signals.
> > +    pub fn signal_pending(&self) -> bool {
> > +        // SAFETY: By the type invariant, we know that `self.0` is valid.
> > +        unsafe { bindings::signal_pending(self.0.get()) != 0 }
> > +    }
> > +
> > +    /// Wakes up the task.
> > +    pub fn wake_up(&self) {
> > +        // SAFETY: By the type invariant, we know that `self.0.get()` is non-null and valid.
> > +        // And `wake_up_process` is safe to be called for any valid task, even if the task is
> > +        // running.
> > +        unsafe { bindings::wake_up_process(self.0.get()) };
> > +    }
> > +}
> > +
> > +// SAFETY: The type invariants guarantee that `Task` is always ref-counted.
> > +unsafe impl crate::types::AlwaysRefCounted for Task {
> > +    fn inc_ref(&self) {
> > +        // SAFETY: The existence of a shared reference means that the refcount is nonzero.
> > +        unsafe { bindings::get_task_struct(self.0.get()) };
> > +    }
> > +
> > +    unsafe fn dec_ref(obj: ptr::NonNull<Self>) {
> > +        // SAFETY: The safety requirements guarantee that the refcount is nonzero.
> > +        unsafe { bindings::put_task_struct(obj.cast().as_ptr()) }
> > +    }
> > +}
>
