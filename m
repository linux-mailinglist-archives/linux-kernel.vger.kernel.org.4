Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57A56DCA5A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 20:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjDJSFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 14:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjDJSF0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 14:05:26 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514801BC1;
        Mon, 10 Apr 2023 11:05:23 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:04:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1681149919; x=1681409119;
        bh=U23Pxj6RmRXluaupeIIMF2+OgyhNmuLdOBsJ8ac8t5U=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=jqTai2OjeGJSWBhhS2vtfoWFT8IrFEzaTAx2Es/P9khzhP5bfX1SZGcqSSDlrgi1P
         uBgaWpDxOAwW8OMqF7J6n+9PcR5ZOpH7AFCYN1UyF3joWFzYFL7kZB13R0c27WVMtL
         X8e9g/qczUxDoK7eS/HL7fdDpscy2RQBUHsERv3aXl7a36pHp6L0zWng7x2KdkOs3m
         qNMlAcI1OkPCGk2aER5BJirri/djpfU3HrZGrrC+1ZHmQPh8C5QUhEqjBjgwFcv7C5
         4/18mM8O3mc6P9Sndp1UGvrDNORCQ0t3IizJAx7uJumUFDNbLaXzXUVIHRKuyeSV/h
         3Pj41pZx7ookQ==
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
From:   Benno Lossin <y86-dev@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v3 10/13] rust: introduce `current`
Message-ID: <08df022b-c0e9-bac6-a57f-296217dc81ed@protonmail.com>
In-Reply-To: <20230408075340.25237-10-wedsonaf@gmail.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com> <20230408075340.25237-10-wedsonaf@gmail.com>
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

On 08.04.23 09:53, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> This allows Rust code to get a reference to the current task without
> having to increment the refcount, but still guaranteeing memory safety.
>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: Make `current` a macro to prevent it from escaping the caller
> v2 -> v3:
> - Mention `current` macro in `Task::current`
> - Hide implementation of `TaskRef` inside `Task::current`
>
>   rust/helpers.c         |  6 +++
>   rust/kernel/prelude.rs |  2 +
>   rust/kernel/task.rs    | 88 +++++++++++++++++++++++++++++++++++++++++-
>   3 files changed, 95 insertions(+), 1 deletion(-)
>
> diff --git a/rust/helpers.c b/rust/helpers.c
> index 58a194042c86..96441744030e 100644
> --- a/rust/helpers.c
> +++ b/rust/helpers.c
> @@ -100,6 +100,12 @@ bool rust_helper_refcount_dec_and_test(refcount_t *r=
)
>   }
>   EXPORT_SYMBOL_GPL(rust_helper_refcount_dec_and_test);
>
> +struct task_struct *rust_helper_get_current(void)
> +{
> +=09return current;
> +}
> +EXPORT_SYMBOL_GPL(rust_helper_get_current);
> +
>   void rust_helper_get_task_struct(struct task_struct *t)
>   {
>   =09get_task_struct(t);
> diff --git a/rust/kernel/prelude.rs b/rust/kernel/prelude.rs
> index fcdc511d2ce8..c28587d68ebc 100644
> --- a/rust/kernel/prelude.rs
> +++ b/rust/kernel/prelude.rs
> @@ -36,3 +36,5 @@ pub use super::error::{code::*, Error, Result};
>   pub use super::{str::CStr, ThisModule};
>
>   pub use super::init::{InPlaceInit, Init, PinInit};
> +
> +pub use super::current;
> diff --git a/rust/kernel/task.rs b/rust/kernel/task.rs
> index d70cad131956..5269a562cb1b 100644
> --- a/rust/kernel/task.rs
> +++ b/rust/kernel/task.rs
> @@ -5,7 +5,17 @@
>   //! C header: [`include/linux/sched.h`](../../../../include/linux/sched=
.h).
>
>   use crate::{bindings, types::Opaque};
> -use core::ptr;
> +use core::{marker::PhantomData, ops::Deref, ptr};
> +
> +/// Returns the currently running task.
> +#[macro_export]
> +macro_rules! current {
> +    () =3D> {
> +        // SAFETY: Deref + addr-of below create a temporary `TaskRef` th=
at cannot outlive the
> +        // caller.
> +        unsafe { &*$crate::task::Task::current() }
> +    };
> +}
>
>   /// Wraps the kernel's `struct task_struct`.
>   ///
> @@ -15,6 +25,42 @@ use core::ptr;
>   ///
>   /// Instances of this type are always ref-counted, that is, a call to `=
get_task_struct` ensures
>   /// that the allocation remains valid at least until the matching call =
to `put_task_struct`.
> +///
> +/// # Examples
> +///
> +/// The following is an example of getting the PID of the current thread=
 with zero additional cost
> +/// when compared to the C version:
> +///
> +/// ```
> +/// let pid =3D current!().pid();
> +/// ```
> +///
> +/// Getting the PID of the current process, also zero additional cost:
> +///
> +/// ```
> +/// let pid =3D current!().group_leader().pid();
> +/// ```
> +///
> +/// Getting the current task and storing it in some struct. The referenc=
e count is automatically
> +/// incremented when creating `State` and decremented when it is dropped=
:
> +///
> +/// ```
> +/// use kernel::{task::Task, types::ARef};
> +///
> +/// struct State {
> +///     creator: ARef<Task>,
> +///     index: u32,
> +/// }
> +///
> +/// impl State {
> +///     fn new() -> Self {
> +///         Self {
> +///             creator: current!().into(),
> +///             index: 0,
> +///         }
> +///     }
> +/// }
> +/// ```
>   #[repr(transparent)]
>   pub struct Task(pub(crate) Opaque<bindings::task_struct>);
>
> @@ -27,6 +73,46 @@ unsafe impl Sync for Task {}
>   type Pid =3D bindings::pid_t;
>
>   impl Task {
> +    /// Returns a task reference for the currently executing task/thread=
.
> +    ///
> +    /// The recommended way to get the current task/thread is to use the
> +    /// [`current`](crate::current) macro because it is safe.
> +    ///
> +    /// # Safety
> +    ///
> +    /// Callers must ensure that the returned object doesn't outlive the=
 current task/thread.
> +    pub unsafe fn current() -> impl Deref<Target =3D Task> {
> +        pub struct TaskRef<'a> {
> +            task: &'a Task,
> +            _not_send: PhantomData<*mut ()>,
> +        }
> +
> +        impl Deref for TaskRef<'_> {
> +            type Target =3D Task;
> +
> +            fn deref(&self) -> &Self::Target {
> +                self.task
> +            }
> +        }
> +
> +        impl From<TaskRef<'_>> for crate::types::ARef<Task> {
> +            fn from(t: TaskRef<'_>) -> Self {
> +                t.deref().into()
> +            }
> +        }

I think we can remove this `From` impl, since the type is never exposed
to the outside (there still is the `From<&T> for ARef<T>` impl, so users
can still do `current!().into()` to get an `ARef<Task>`).

--
Cheers,
Benno

> +
> +        // SAFETY: Just an FFI call with no additional safety requiremen=
ts.
> +        let ptr =3D unsafe { bindings::get_current() };
> +
> +        TaskRef {
> +            // SAFETY: If the current thread is still running, the curre=
nt task is valid. Given
> +            // that `TaskRef` is not `Send`, we know it cannot be transf=
erred to another thread
> +            // (where it could potentially outlive the caller).
> +            task: unsafe { &*ptr.cast() },
> +            _not_send: PhantomData,
> +        }
> +    }
> +
>       /// Returns the group leader of the given task.
>       pub fn group_leader(&self) -> &Task {
>           // SAFETY: By the type invariant, we know that `self.0` is a va=
lid task. Valid tasks always
> --
> 2.34.1
>

