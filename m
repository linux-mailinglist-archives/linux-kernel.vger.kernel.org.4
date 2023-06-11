Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617D372B287
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbjFKPqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKPqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:46:12 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B2B10A;
        Sun, 11 Jun 2023 08:46:07 -0700 (PDT)
Date:   Sun, 11 Jun 2023 15:45:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1686498364; x=1686757564;
        bh=/Rp7EG+uVgU6PeRrnnk9oL6t/Q+tJr5OMcOjEBtUThw=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=UXaWJIyB1x9Nf7hBR9dboMnfSSiBOgBvdJ5TfhJ8rq8F0HelRtn3ISMMQp/W0PM2z
         CQJ5OVJFuqTq3O1Fei1mSN8LPjmbE+Hmk+prKeauNpucNjwOetvNkVUg+HrvP8GJ/S
         5fxwtjxfpWcuP1opvmFS9cYsPseMZbu4uPZ48i97XQghMZPuonxvkFOTeFPxX6tTbt
         SN+kpov4AoL4/GhhLNHU3DCMkC7vpNvHZbpmRzWG/nuKSss19fSn7UQMQofcNbO8ya
         uHxQ9FwAvyrBNhPcjBHqJ+nnyxi4rY9r2EPhheBTiJ6FplqgQNJZqSoC+Ij1bbYV65
         ie9UQQ1wGtIKw==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/8] rust: workqueue: add low-level workqueue bindings
Message-ID: <_VAFv3y5UIDHOZg8C_XcFaxauEVzV2-nrA0aN2apuhr0NGtu4YRv_5mzl4JTs_Dg24sFD1lQG8gtb0AmXZBcTD_gJyEsFmcGJyF20ZUcIgk=@proton.me>
In-Reply-To: <20230601134946.3887870-2-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com> <20230601134946.3887870-2-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 15:49, Alice Ryhl wrote:
> Define basic low-level bindings to a kernel workqueue. The API defined
> here can only be used unsafely. Later commits will provide safe
> wrappers.
>=20
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

> ---
>   rust/bindings/bindings_helper.h |   1 +
>   rust/kernel/lib.rs              |   1 +
>   rust/kernel/workqueue.rs        | 107 ++++++++++++++++++++++++++++++++
>   3 files changed, 109 insertions(+)
>   create mode 100644 rust/kernel/workqueue.rs
>=20
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_hel=
per.h
> index 50e7a76d5455..ae2e8f018268 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
>   #include <linux/refcount.h>
>   #include <linux/wait.h>
>   #include <linux/sched.h>
> +#include <linux/workqueue.h>
>=20
>   /* `bindgen` gets confused at certain things. */
>   const gfp_t BINDINGS_GFP_KERNEL =3D GFP_KERNEL;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..eaded02ffb01 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -43,6 +43,7 @@
>   pub mod sync;
>   pub mod task;
>   pub mod types;
> +pub mod workqueue;
>=20
>   #[doc(hidden)]
>   pub use bindings;
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> new file mode 100644
> index 000000000000..9c630840039b
> --- /dev/null
> +++ b/rust/kernel/workqueue.rs
> @@ -0,0 +1,107 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Work queues.
> +//!
> +//! C header: [`include/linux/workqueue.h`](../../../../include/linux/wo=
rkqueue.h)
> +
> +use crate::{bindings, types::Opaque};
> +
> +/// A kernel work queue.
> +///
> +/// Wraps the kernel's C `struct workqueue_struct`.
> +///
> +/// It allows work items to be queued to run on thread pools managed by =
the kernel. Several are
> +/// always available, for example, `system`, `system_highpri`, `system_l=
ong`, etc.
> +#[repr(transparent)]
> +pub struct Queue(Opaque<bindings::workqueue_struct>);
> +
> +// SAFETY: Kernel workqueues are usable from any thread.
> +unsafe impl Send for Queue {}
> +unsafe impl Sync for Queue {}
> +
> +impl Queue {
> +    /// Use the provided `struct workqueue_struct` with Rust.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure that the provided raw pointer is not dang=
ling, that it points at a
> +    /// valid workqueue, and that it remains valid until the end of 'a.
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::workqueue_struct) -=
> &'a Queue {
> +        // SAFETY: The `Queue` type is `#[repr(transparent)]`, so the po=
inter cast is valid. The
> +        // caller promises that the pointer is not dangling.
> +        unsafe { &*(ptr as *const Queue) }
> +    }
> +
> +    /// Enqueues a work item.
> +    ///
> +    /// This may fail if the work item is already enqueued in a workqueu=
e.
> +    ///
> +    /// The work item will be submitted using `WORK_CPU_UNBOUND`.
> +    pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
> +    where
> +        W: RawWorkItem<ID> + Send + 'static,
> +    {
> +        let queue_ptr =3D self.0.get();
> +
> +        // SAFETY: We only return `false` if the `work_struct` is alread=
y in a workqueue. The other
> +        // `__enqueue` requirements are not relevant since `W` is `Send`=
 and static.
> +        //
> +        // The call to `bindings::queue_work_on` will dereference the pr=
ovided raw pointer, which
> +        // is ok because `__enqueue` guarantees that the pointer is vali=
d for the duration of this
> +        // closure.
> +        //
> +        // Furthermore, if the C workqueue code accesses the pointer aft=
er this call to
> +        // `__enqueue`, then the work item was successfully enqueued, an=
d `bindings::queue_work_on`
> +        // will have returned true. In this case, `__enqueue` promises t=
hat the raw pointer will
> +        // stay valid until we call the function pointer in the `work_st=
ruct`, so the access is ok.
> +        unsafe {
> +            w.__enqueue(move |work_ptr| {
> +                bindings::queue_work_on(bindings::WORK_CPU_UNBOUND as _,=
 queue_ptr, work_ptr)
> +            })
> +        }
> +    }
> +}
> +
> +/// A raw work item.
> +///
> +/// This is the low-level trait that is designed for being as general as=
 possible.
> +///
> +/// The `ID` parameter to this trait exists so that a single type can pr=
ovide multiple
> +/// implementations of this trait. For example, if a struct has multiple=
 `work_struct` fields, then
> +/// you will implement this trait once for each field, using a different=
 id for each field. The
> +/// actual value of the id is not important as long as you use different=
 ids for different fields
> +/// of the same struct. (Fields of different structs need not use differ=
ent ids.)
> +///
> +/// Note that the id is used only to select the right method to call dur=
ing compilation. It wont be
> +/// part of the final executable.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that any pointers passed to a `queue_work_o=
n` closure by `__enqueue`
> +/// remain valid for the duration specified in the documentation for `__=
enqueue`.
> +pub unsafe trait RawWorkItem<const ID: u64> {
> +    /// The return type of [`Queue::enqueue`].
> +    type EnqueueOutput;
> +
> +    /// Enqueues this work item on a queue using the provided `queue_wor=
k_on` method.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// If this method calls the provided closure, then the raw pointer =
is guaranteed to point at a
> +    /// valid `work_struct` for the duration of the call to the closure.=
 If the closure returns
> +    /// true, then it is further guaranteed that the pointer remains val=
id until someone calls the
> +    /// function pointer stored in the `work_struct`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided closure may only return `false` if the `work_struct=
` is already in a workqueue.
> +    ///
> +    /// If the work item type is annotated with any lifetimes, then you =
must not call the function
> +    /// pointer after any such lifetime expires. (Never calling the func=
tion pointer is okay.)
> +    ///
> +    /// If the work item type is not [`Send`], then the function pointer=
 must be called on the same
> +    /// thread as the call to `__enqueue`.
> +    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutpu=
t
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool;
> +}
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>=20


