Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45F0710B48
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 13:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231482AbjEYLmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 07:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240743AbjEYLmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 07:42:14 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E55F813A
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:42:05 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4f24d8440c9so1109883e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 04:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685014924; x=1687606924;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=G3CpZ+J0QnNwNoVB62K2AVj9y0i+Or+IMdEdZ49khiY=;
        b=kIQyz8ec5/f02Po4gZr3TJIKxAwlafru27T82iDW8Cs6CHovlqpkAVDV24lZSCUxi6
         mAwL9figYmwnVEGEdcpm9oH2QkR5Ymvfkv0xqBPL0GowY7HILdZJ53426oB4oe2BKjYi
         /TWK13TbhNGnUt3xClXlOnLo0vyFaMbpypfvpEynG1j39Jl4deVdW+3OrnoNRzJCKTkg
         TZOv5aTZE7rck4jHtDUI+UMHFSkg5L/GpTIdUhgIJGL+lpMl5M7LRadKQjAB2zAxPblR
         MKG3zpHSedkOYkw0fSIEvZK67RwNAZX/naVeHVc+YYrYvx2LhniiuXFP5XVi0F6xnXMU
         Ly6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685014924; x=1687606924;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3CpZ+J0QnNwNoVB62K2AVj9y0i+Or+IMdEdZ49khiY=;
        b=i2Aw5eevfSeEtsg8qsgFn46K85/SmH35CxLYRH+/bI9vATs82iYnxYshyc8trNmHVQ
         vVwi50KL4Sp3XDDZnjSoUgqJRFDtYWClCL+w3bT8RNLiGo21OJDsDDvwisVNDTs00vxU
         SPoa0/lfxmgmllARB13Gt9J0uyvt49JBKcoQXts1uga3Rgn6aY3PvSbteMSOs+F1X4Hm
         QX8ygXm8r5N3EuSNa8GBKjKH+tXQzGhNvtRiiBQk65zvMcdUQl7HhbQBitBtFZtK86Vn
         6zRQV6E6vUqd4Uk60CUpBnXzbKGYxTVL4a9jXQki5S/2Nw5261nB7bqqsZMJuSawo4M0
         hZYQ==
X-Gm-Message-State: AC+VfDzLRdtZANRV6LLJ3gK8ErfVY58JIq0QUtithfA2zToqD3gvWodu
        yGqsdORAIxFSDZDh6fPJT5DLEQ==
X-Google-Smtp-Source: ACHHUZ5x/OH+3B/SMSwYfRg9CLDsisy3qIko8HeAW+iBEnDSN5+VuFnvNMx8H5CdwdhPoOQn8ETb8A==
X-Received: by 2002:a05:6512:12cc:b0:4f1:276f:a25 with SMTP id p12-20020a05651212cc00b004f1276f0a25mr772615lfg.5.1685014924080;
        Thu, 25 May 2023 04:42:04 -0700 (PDT)
Received: from localhost (77.241.128.147.mobile.3.dk. [77.241.128.147])
        by smtp.gmail.com with ESMTPSA id w13-20020ac254ad000000b004f3942e1fbesm188685lfk.1.2023.05.25.04.42.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 04:42:03 -0700 (PDT)
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-5-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
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
Subject: Re: [PATCH v1 4/7] rust: workqueue: define built-in queues
Date:   Thu, 25 May 2023 13:40:50 +0200
In-reply-to: <20230517203119.3160435-5-aliceryhl@google.com>
Message-ID: <875y8geiye.fsf@metaspace.dk>
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

> From: Wedson Almeida Filho <walmeida@microsoft.com>
>
> We provide these methods because it lets us access these queues from
> Rust without using unsafe code.
>
> These methods return `&'static Queue`. References annotated with the
> 'static lifetime are used when the referent will stay alive forever.
> That is ok for these queues because they are global variables and cannot
> be destroyed.
>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/workqueue.rs | 65 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index e66b6b50dfae..22205d3bda72 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -97,3 +97,68 @@ pub unsafe trait WorkItem {
>      where
>          F: FnOnce(*mut bindings::work_struct) -> bool;
>  }
> +
> +/// Returns the system work queue (`system_wq`).
> +///
> +/// It is the one used by `schedule[_delayed]_work[_on]()`. Multi-CPU multi-threaded. There are
> +/// users which expect relatively short queue flush time.
> +///
> +/// Callers shouldn't queue work items which can run for too long.
> +pub fn system() -> &'static Queue {
> +    // SAFETY: `system_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_wq) }
> +}
> +
> +/// Returns the system high-priority work queue (`system_highpri_wq`).
> +///
> +/// It is similar to the one returned by [`system`] but for work items which require higher
> +/// scheduling priority.
> +pub fn system_highpri() -> &'static Queue {
> +    // SAFETY: `system_highpri_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_highpri_wq) }
> +}
> +
> +/// Returns the system work queue for potentially long-running work items (`system_long_wq`).
> +///
> +/// It is similar to the one returned by [`system`] but may host long running work items. Queue
> +/// flushing might take relatively long.
> +pub fn system_long() -> &'static Queue {
> +    // SAFETY: `system_long_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_long_wq) }
> +}
> +
> +/// Returns the system unbound work queue (`system_unbound_wq`).
> +///
> +/// Workers are not bound to any specific CPU, not concurrency managed, and all queued work items
> +/// are executed immediately as long as `max_active` limit is not reached and resources are
> +/// available.
> +pub fn system_unbound() -> &'static Queue {
> +    // SAFETY: `system_unbound_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_unbound_wq) }
> +}
> +
> +/// Returns the system freezable work queue (`system_freezable_wq`).
> +///
> +/// It is equivalent to the one returned by [`system`] except that it's freezable.

Can we add a short definition of what "freezable" means?

BR Andreas

> +pub fn system_freezable() -> &'static Queue {
> +    // SAFETY: `system_freezable_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_freezable_wq) }
> +}
> +
> +/// Returns the system power-efficient work queue (`system_power_efficient_wq`).
> +///
> +/// It is inclined towards saving power and is converted to "unbound" variants if the
> +/// `workqueue.power_efficient` kernel parameter is specified; otherwise, it is similar to the one
> +/// returned by [`system`].
> +pub fn system_power_efficient() -> &'static Queue {
> +    // SAFETY: `system_power_efficient_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_power_efficient_wq) }
> +}
> +
> +/// Returns the system freezable power-efficient work queue (`system_freezable_power_efficient_wq`).
> +///
> +/// It is similar to the one returned by [`system_power_efficient`] except that is freezable.
> +pub fn system_freezable_power_efficient() -> &'static Queue {
> +    // SAFETY: `system_freezable_power_efficient_wq` is a C global, always available.
> +    unsafe { Queue::from_raw(bindings::system_freezable_power_efficient_wq) }
> +}

