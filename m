Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1042B74FAE6
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjGKWY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKWY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:24:26 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1DE10F2;
        Tue, 11 Jul 2023 15:24:20 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-992dcae74e0so801880566b.3;
        Tue, 11 Jul 2023 15:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689114259; x=1691706259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PrcIyOaJSd/7YI26QorfI+WMWDNNra1F3KRdh8w9hnY=;
        b=hvI09kJNWn86TsfOg083UNhM3eA/skdkjwUzAqPzGkti80sK8buNYmOvCaVZlKBLn0
         sHEYSS3fNsPbRK00StcMVUM/RJC3QMjSAjYDBmRk7poZB6PZylnIAo0AlC9tEIQvP4Xa
         BoLkT+jD/pj14Fr2bvYB/kjKicUS5sBlr+1CQ9d3V4yQqsRG4D9fINhLAs8QhC3nQXgm
         +za5xpplTlHlzyi5gJP0aaMtK0oAbHPNl0SI6D18BBbf6CEpHPgxJFobziZTDfwMy/7J
         r7f7EnyfXchPGsdhwBqoeV6YRNRJ/hXBPAsaPXdt7AOg395m/ghG7er6hmdAyjGAqfp8
         GL2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689114259; x=1691706259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PrcIyOaJSd/7YI26QorfI+WMWDNNra1F3KRdh8w9hnY=;
        b=VXx1i/4ytetHGTF5cm1q/5DLZ8d4KDkRSVGaLCkz7W4+j2OLpgqAJd17WpimUSlGE5
         Pg6aetRu8TD2CRACj1szA3HpoO3XfxIIaZObYeC0/WT99XSaPvLOHxHUYx6jYfAkvmVn
         /DqkQVm7nEA9+MqvyTmEp8Ly85bQK+q+B+kVrGTSvz+OGwi4SxM9i+m2Ov2T9sXhmR/L
         P3h++9MWfPy9nmqWCKQvr+bcAO9x6rDDlpmmJFXV3f29fMHn8AXW7fB3UmCQAyz9T/7I
         7oig7Uycfd8PE9fRz8RbstQLNWcbWhCdcXh/8Ff6VrIps9yi94W/rtUiv0bxEk1+axXM
         bs/g==
X-Gm-Message-State: ABy/qLbkxTikXT6X4/61UuO+jze7ixixb7meu8sbQf88YLNcCJwXk944
        7IjFItiUxI/LFYkkSihvP9Y=
X-Google-Smtp-Source: APBJJlGwjN7HTkBa8/rzC3GAU86r3r05TimGx5LEewS3QtYGrhdZApBYefvDj2j+qlq4Ow6MOMSQmw==
X-Received: by 2002:a17:906:649c:b0:993:e695:b589 with SMTP id e28-20020a170906649c00b00993e695b589mr12581589ejm.20.1689114258598;
        Tue, 11 Jul 2023 15:24:18 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t10-20020a1709066bca00b00993a37aebc5sm1672846ejs.50.2023.07.11.15.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:24:18 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id D4F0227C0054;
        Tue, 11 Jul 2023 18:24:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 11 Jul 2023 18:24:15 -0400
X-ME-Sender: <xms:jtatZH3OHiyB1zZeiMd15Ea9WwnlBW_6OUan7_-JpT3IiVeZ_2rfLg>
    <xme:jtatZGFV1H9byMIPVq835_hLZNPJz6oFND5_cCs-oj8VgvOdSHjfaFYaiF82Sfiud
    4ZBonGGkv7nVORhJw>
X-ME-Received: <xmr:jtatZH7Y6fzIRzm39RBK56LIwzujBid9dQT5gehoyz-1EUZfGZO92mw7Uhc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedugddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:jtatZM3NHeXVawZcQFwlI0dnyeHCkpZWidrggi8DixA10qFJo9-8wg>
    <xmx:jtatZKGS1g-KlqkmrLnlUhUzZsYjfsTVT2lAd21iR_PuHDGTYqUL-w>
    <xmx:jtatZN-wa9G8bTq6kAfdwCfoMvgHhS-jjZJ5wp3SL7U9XSYLN-VClQ>
    <xmx:j9atZGGejfcBXaxB5S0uZbqSgv8gVLfkOrNzamuu-5UTfb7rG76N6Q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Jul 2023 18:24:14 -0400 (EDT)
Date:   Tue, 11 Jul 2023 15:23:12 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Andreas Hindborg <nmi@metaspace.dk>
Subject: Re: [PATCH v3 4/9] rust: workqueue: add low-level workqueue bindings
Message-ID: <ZK3WUBTb1dHfjnh8@boqun-archlinux>
References: <20230711093303.1433770-1-aliceryhl@google.com>
 <20230711093303.1433770-5-aliceryhl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711093303.1433770-5-aliceryhl@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2023 at 09:32:58AM +0000, Alice Ryhl wrote:
> Define basic low-level bindings to a kernel workqueue. The API defined
> here can only be used unsafely. Later commits will provide safe
> wrappers.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> ---
> v2 -> v3:
>  * Update documentation to say "guarantees section".
>  * Add Reviewed-by from Martin, Andreas, Benno.
> 
>  rust/bindings/bindings_helper.h |   1 +
>  rust/kernel/lib.rs              |   1 +
>  rust/kernel/workqueue.rs        | 108 ++++++++++++++++++++++++++++++++
>  3 files changed, 110 insertions(+)
>  create mode 100644 rust/kernel/workqueue.rs
> 
> diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
> index 3e601ce2548d..4e1c0938c8cb 100644
> --- a/rust/bindings/bindings_helper.h
> +++ b/rust/bindings/bindings_helper.h
> @@ -11,6 +11,7 @@
>  #include <linux/refcount.h>
>  #include <linux/wait.h>
>  #include <linux/sched.h>
> +#include <linux/workqueue.h>
>  
>  /* `bindgen` gets confused at certain things. */
>  const gfp_t BINDINGS_GFP_KERNEL = GFP_KERNEL;
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index 6963d11092c4..6d63f4f6bb8a 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -45,6 +45,7 @@
>  pub mod sync;
>  pub mod task;
>  pub mod types;
> +pub mod workqueue;
>  
>  #[doc(hidden)]
>  pub use bindings;
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> new file mode 100644
> index 000000000000..060d26dfcc7d
> --- /dev/null
> +++ b/rust/kernel/workqueue.rs
> @@ -0,0 +1,108 @@
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

I don't think "usable from any thread" is the accurate wording here, it
sounds to me that there are types that cannot be used for a particular
type of threads ;-)

Maybe

	// SAFETY: Accesses to workqueues used by [`Queue`] are
	// thread-safe.

?

Rest of this patch looks good to me.

Reviewed-by: Boqun Feng <boqun.feng@gmail.com>

Regards,
Boqun

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
> +/// remain valid for the duration specified in the guarantees section of the documentation for
> +/// `__enqueue`.
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
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
