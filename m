Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF847204AC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236112AbjFBOkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235707AbjFBOkk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:40:40 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39211BC
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:40:34 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3f60e536250so25691215e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685716832; x=1688308832;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=dd7s3Z3wE1FRuEKyebQLFIwrLmyQsduGsJm+S7BiDBA=;
        b=WbTcJBu7dkxQd6Xx/FdhcI+/W6kFAf+fOjnkbtuj7zwZ2Zaiz7RATDiV0A9TyiPZDX
         /9UbiI5tERB8SJ0XsVpCPyn757q28Wt9HzY5kMGLyi2rr0xEPHFYkQ7FMwoqqlBKa/rG
         T0NtUZJu2NarhxXvNXFTUmo8djZ/dWT6NvIZf4tF7hwLFlX038eumQC/oAE7YrY1wxo6
         Sx6Ps3Dcnkc6rz096/AvPzCwBqGaN7l0xOGfTCZq8daGKBb6nwVxKC2p/Qbpjb12Lgjs
         4x1b5psWDoiDnT41ltq0ZgoO/nNBh3+wZbhOJdeaHv335cmrVv/qUV41Yyvbuh2j9T3c
         /axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716832; x=1688308832;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dd7s3Z3wE1FRuEKyebQLFIwrLmyQsduGsJm+S7BiDBA=;
        b=Mp2qKZqq1yvaJ0IALC2SvKCGEu1U++7dyBGhFgsRAYc5wGCjwu/CtjyJ/7kBRtW++W
         Z1u41+jq+HfyCfvUSO1CWPt6GnRriKLypxbC93i3Za1NaocjFJeetFUUjHW6rwWBPm7+
         iMuxmDoE+wz0XVrWYGUpl3FLJ/UvENzk8svMh31k0nmAyk4viYf6ryyyr7Nve9lAVyVO
         +8ZPs/tAfsH5azLd9RarLRMT8DdIdHi8bHJXNByqzuKgXpa/HZdzeUkEsoixKOlM2o8q
         3J3BLD8Tz5mZNxEeS1t+oAZE4QX8PJdJpfr25L4T+tnoCDIL0R2yvHsXlPwEbczgDEOs
         Cv5A==
X-Gm-Message-State: AC+VfDykBtjthclqx6czmKbENYq0HT3xkvwHyUo8nsTANgmK4c/zPfFO
        nEjOW/IOHLDYWwVZ96T3VQU7ng==
X-Google-Smtp-Source: ACHHUZ5plGOHiofUtGd1wr0/17WzX3lFPrk17UetRP4zhL9gwB5+dLNKk+DiK+EIzimgC1GyyD/rSA==
X-Received: by 2002:adf:f606:0:b0:30a:d944:b765 with SMTP id t6-20020adff606000000b0030ad944b765mr57873wrp.15.1685716832593;
        Fri, 02 Jun 2023 07:40:32 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id k16-20020a056000005000b003079986fd71sm1898268wrx.88.2023.06.02.07.40.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:40:32 -0700 (PDT)
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-2-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v2 1/8] rust: workqueue: add low-level workqueue bindings
Date:   Fri, 02 Jun 2023 16:39:00 +0200
In-reply-to: <20230601134946.3887870-2-aliceryhl@google.com>
Message-ID: <87o7ly0vxc.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> Define basic low-level bindings to a kernel workqueue. The API defined
> here can only be used unsafely. Later commits will provide safe
> wrappers.
>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>

> ---
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/workqueue.rs        | 107 ++++++++++++++++++++++++++++++++
>  3 files changed, 109 insertions(+)
>  create mode 100644 rust/kernel/workqueue.rs
>
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 50e7a76d5455..ae2e8f018268 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -10,6 +10,7 @@
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/workqueue.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 85b261209977..eaded02ffb01 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -43,6 +43,7 @@
>  pub mod sync;
>  pub mod task;
>  pub mod types;
> +pub mod workqueue;
>  
>  #[doc(hidden)]
>  pub use bindings;
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
> +//! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
> +
> +use crate::{bindings, types::Opaque};
> +
> +/// A kernel work queue.
> +///
> +/// Wraps the kernel's C `struct workqueue_struct`.
> +///
> +/// It allows work items to be queued to run on thread pools managed by the kernel. Several are
> +/// always available, for example, `system`, `system_highpri`, `system_long`, etc.
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
> +    /// The caller must ensure that the provided raw pointer is not dangling, that it points at a
> +    /// valid workqueue, and that it remains valid until the end of 'a.
> +    pub unsafe fn from_raw<'a>(ptr: *const bindings::workqueue_struct) -> &'a Queue {
> +        // SAFETY: The `Queue` type is `#[repr(transparent)]`, so the pointer cast is valid. The
> +        // caller promises that the pointer is not dangling.
> +        unsafe { &*(ptr as *const Queue) }
> +    }
> +
> +    /// Enqueues a work item.
> +    ///
> +    /// This may fail if the work item is already enqueued in a workqueue.
> +    ///
> +    /// The work item will be submitted using `WORK_CPU_UNBOUND`.
> +    pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
> +    where
> +        W: RawWorkItem<ID> + Send + 'static,
> +    {
> +        let queue_ptr = self.0.get();
> +
> +        // SAFETY: We only return `false` if the `work_struct` is already in a workqueue. The other
> +        // `__enqueue` requirements are not relevant since `W` is `Send` and static.
> +        //
> +        // The call to `bindings::queue_work_on` will dereference the provided raw pointer, which
> +        // is ok because `__enqueue` guarantees that the pointer is valid for the duration of this
> +        // closure.
> +        //
> +        // Furthermore, if the C workqueue code accesses the pointer after this call to
> +        // `__enqueue`, then the work item was successfully enqueued, and `bindings::queue_work_on`
> +        // will have returned true. In this case, `__enqueue` promises that the raw pointer will
> +        // stay valid until we call the function pointer in the `work_struct`, so the access is ok.
> +        unsafe {
> +            w.__enqueue(move |work_ptr| {
> +                bindings::queue_work_on(bindings::WORK_CPU_UNBOUND as _, queue_ptr, work_ptr)
> +            })
> +        }
> +    }
> +}
> +
> +/// A raw work item.
> +///
> +/// This is the low-level trait that is designed for being as general as possible.
> +///
> +/// The `ID` parameter to this trait exists so that a single type can provide multiple
> +/// implementations of this trait. For example, if a struct has multiple `work_struct` fields, then
> +/// you will implement this trait once for each field, using a different id for each field. The
> +/// actual value of the id is not important as long as you use different ids for different fields
> +/// of the same struct. (Fields of different structs need not use different ids.)
> +///
> +/// Note that the id is used only to select the right method to call during compilation. It wont be
> +/// part of the final executable.
> +///
> +/// # Safety
> +///
> +/// Implementers must ensure that any pointers passed to a `queue_work_on` closure by `__enqueue`
> +/// remain valid for the duration specified in the documentation for `__enqueue`.
> +pub unsafe trait RawWorkItem<const ID: u64> {
> +    /// The return type of [`Queue::enqueue`].
> +    type EnqueueOutput;
> +
> +    /// Enqueues this work item on a queue using the provided `queue_work_on` method.
> +    ///
> +    /// # Guarantees
> +    ///
> +    /// If this method calls the provided closure, then the raw pointer is guaranteed to point at a
> +    /// valid `work_struct` for the duration of the call to the closure. If the closure returns
> +    /// true, then it is further guaranteed that the pointer remains valid until someone calls the
> +    /// function pointer stored in the `work_struct`.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided closure may only return `false` if the `work_struct` is already in a workqueue.
> +    ///
> +    /// If the work item type is annotated with any lifetimes, then you must not call the function
> +    /// pointer after any such lifetime expires. (Never calling the function pointer is okay.)
> +    ///
> +    /// If the work item type is not [`Send`], then the function pointer must be called on the same
> +    /// thread as the call to `__enqueue`.
> +    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool;
> +}

