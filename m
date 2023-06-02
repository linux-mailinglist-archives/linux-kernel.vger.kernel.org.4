Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5CF7204BD
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236160AbjFBOnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236150AbjFBOm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:42:59 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA56FE42
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:42:57 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-96f5685f902so304073266b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685716976; x=1688308976;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=dukevTSJaY0OhT9+w91Mneil7yG1obPoDg2sizFF1Kw=;
        b=aoKXaO8dwVooQPVLxMImdjrEOsIxFysb+nj/swayH18hQNE/h4GiVBwJSA/HOgCDgq
         XtWisoMqdpWyWCFKNA1BbMPpt4afiQ5ToLOA4Wd7ah4s8e9z6FBGR7UdjDztPUxuVvYs
         0y/GfepgEnOMOs9P7possvFalCyRWAzOWYK7A8ihUC17s0u/U3G29pzXgAfCop61+1Cd
         kpLLqLG7nAjuqqoBrUl/5ErBX/4eNN4bGK8x/CPA7evwboG57+v5W/PikKblrOIJ22Co
         Jwxi/SzmQADoRHdJTpnfPRvlSatT5QS0Lwzp07inWvKKrbBZVY+SvbFYnwebru4SthtJ
         +Low==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685716976; x=1688308976;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dukevTSJaY0OhT9+w91Mneil7yG1obPoDg2sizFF1Kw=;
        b=PfXZE/9mwUBKctW+4vB999OmYZZfwZUsDHrsK8GlXLbgg2q+M03/lnTtohegO9lw6I
         DJUTcqP0NbU6imjgGI50HywMiKvJ9c514KkWh7A3slIFgGAWUWFt/zC4HfJ97Z0FS6RK
         XkHAPMHEFeigPDA0audZDOyN8FmFetCNJNkAjxMvVZxsLmonUFWmEx/ibdY9VrJ2+Q4Z
         J8CD1/g11dOCHdpSb9PuLAt8QEwHiQH+XRy130tDte5lVZtc+71w1wAXHgRyG/OfHZ+l
         SXgS4Z7sKnDm4waW7C6F3SSdRv4rjzPmS2OAK8BBBNok8Jcoum3r8P3V7H/OYzCxmIao
         dmjw==
X-Gm-Message-State: AC+VfDzIDGdzCiSblQQianSuG5EVi1XbYdVs0ERdZ0O6RZ6PAVl0b89k
        chU8Mzmrz9HxTNrxZzkK8k+v6g==
X-Google-Smtp-Source: ACHHUZ75f9ts5J1DJc8ZGgheFTyz1CPuj/R+6qPiOIzaw9u3QogCHyJm1KqU4xP9Q9iH/Y61aexlaQ==
X-Received: by 2002:a17:907:7b98:b0:94e:e5fe:b54f with SMTP id ne24-20020a1709077b9800b0094ee5feb54fmr12905139ejc.23.1685716976121;
        Fri, 02 Jun 2023 07:42:56 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id d4-20020a17090694c400b0096f67b55b0csm829768ejy.115.2023.06.02.07.42.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:42:55 -0700 (PDT)
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-7-aliceryhl@google.com>
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
Subject: Re: [PATCH v2 6/8] rust: workqueue: implement `WorkItemPointer` for
 pointer types
Date:   Fri, 02 Jun 2023 16:42:44 +0200
In-reply-to: <20230601134946.3887870-7-aliceryhl@google.com>
Message-ID: <87fs7a0vtd.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> This implements the `WorkItemPointer` trait for the pointer types that
> you are likely to use the workqueue with. The `Arc` type is for
> reference counted objects, and the `Pin<Box<T>>` type is for objects
> where the caller has exclusive ownership of the object.
>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>

> ---
>  rust/kernel/workqueue.rs | 97 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 96 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index dbf0aab29a85..f06a2f036d8b 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -28,8 +28,10 @@
>  //!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
> -use crate::{bindings, prelude::*, types::Opaque};
> +use crate::{bindings, prelude::*, sync::Arc, types::Opaque};
> +use alloc::boxed::Box;
>  use core::marker::{PhantomData, PhantomPinned};
> +use core::pin::Pin;
>  
>  /// A kernel work queue.
>  ///
> @@ -323,6 +325,99 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
>      )*};
>  }
>  
> +unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
> +where
> +    T: WorkItem<ID, Pointer = Self>,
> +    T: HasWork<T, ID>,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
> +        // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
> +        let ptr = ptr as *mut Work<T, ID>;
> +        // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
> +        let ptr = unsafe { T::work_container_of(ptr) };
> +        // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
> +        let arc = unsafe { Arc::from_raw(ptr) };
> +
> +        T::run(arc)
> +    }
> +}
> +
> +unsafe impl<T, const ID: u64> RawWorkItem<ID> for Arc<T>
> +where
> +    T: WorkItem<ID, Pointer = Self>,
> +    T: HasWork<T, ID>,
> +{
> +    type EnqueueOutput = Result<(), Self>;
> +
> +    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool,
> +    {
> +        // Casting between const and mut is not a problem as long as the pointer is a raw pointer.
> +        let ptr = Arc::into_raw(self) as *mut T;
> +
> +        // SAFETY: Pointers into an `Arc` point at a valid value.
> +        let work_ptr = unsafe { T::raw_get_work(ptr) };
> +        // SAFETY: `raw_get_work` returns a pointer to a valid value.
> +        let work_ptr = unsafe { Work::raw_get(work_ptr) };
> +
> +        if queue_work_on(work_ptr) {
> +            Ok(())
> +        } else {
> +            // SAFETY: The work queue has not taken ownership of the pointer.
> +            Err(unsafe { Arc::from_raw(ptr) })
> +        }
> +    }
> +}
> +
> +unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Pin<Box<T>>
> +where
> +    T: WorkItem<ID, Pointer = Self>,
> +    T: HasWork<T, ID>,
> +{
> +    unsafe extern "C" fn run(ptr: *mut bindings::work_struct) {
> +        // SAFETY: The `__enqueue` method always uses a `work_struct` stored in a `Work<T, ID>`.
> +        let ptr = ptr as *mut Work<T, ID>;
> +        // SAFETY: This computes the pointer that `__enqueue` got from `Arc::into_raw`.
> +        let ptr = unsafe { T::work_container_of(ptr) };
> +        // SAFETY: This pointer comes from `Arc::into_raw` and we've been given back ownership.
> +        let boxed = unsafe { Box::from_raw(ptr) };
> +        // SAFETY: The box was already pinned when it was enqueued.
> +        let pinned = unsafe { Pin::new_unchecked(boxed) };
> +
> +        T::run(pinned)
> +    }
> +}
> +
> +unsafe impl<T, const ID: u64> RawWorkItem<ID> for Pin<Box<T>>
> +where
> +    T: WorkItem<ID, Pointer = Self>,
> +    T: HasWork<T, ID>,
> +{
> +    type EnqueueOutput = ();
> +
> +    unsafe fn __enqueue<F>(self, queue_work_on: F) -> Self::EnqueueOutput
> +    where
> +        F: FnOnce(*mut bindings::work_struct) -> bool,
> +    {
> +        // SAFETY: We're not going to move `self` or any of its fields, so its okay to temporarily
> +        // remove the `Pin` wrapper.
> +        let boxed = unsafe { Pin::into_inner_unchecked(self) };
> +        let ptr = Box::into_raw(boxed);
> +
> +        // SAFETY: Pointers into a `Box` point at a valid value.
> +        let work_ptr = unsafe { T::raw_get_work(ptr) };
> +        // SAFETY: `raw_get_work` returns a pointer to a valid value.
> +        let work_ptr = unsafe { Work::raw_get(work_ptr) };
> +
> +        if !queue_work_on(work_ptr) {
> +            // SAFETY: This method requires exclusive ownership of the box, so it cannot be in a
> +            // workqueue.
> +            unsafe { ::core::hint::unreachable_unchecked() }
> +        }
> +    }
> +}
> +
>  /// Returns the system work queue (`system_wq`).
>  ///
>  /// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are

