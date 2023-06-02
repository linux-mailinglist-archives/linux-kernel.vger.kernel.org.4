Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C507204D4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236212AbjFBOsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236215AbjFBOsp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:48:45 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB95E4E
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:48:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51491b87565so3134156a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685717321; x=1688309321;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=hJ9vneQJ4b683G/HZn1+z6+HzvNcmHcX4U7xxt8CZQM=;
        b=fod6LE95FV3APy5Pg6yBDbE1/Y+vFXNmAWLeCfz4L5JBk30TL+NMVnUCdzzyz1FmGA
         tnAwb/pDxY6oxocRE7I92RpB1oMc4Ejd0AGm4RBYZmXgPLLbMDpQUSUJzxch0HcivYmH
         eeKQiKDauWuzCFuGJoK41t9I8GBIIvnUtBY3PmVgVsQ0Gxq5tBLjiVkfrdXuV433zoPH
         dsQNE3O+Rnb2IYR1p7VvhIGMcWM3DGsVhdqFVTwZqf2QmZZ1LKPrxOimSrdLO+ZMPKe0
         LAZ+wOUz/ib1HVFZLCL609EZyw89w5tYV+UvpDTsdWHXTt1lKL2oaLhVA3CxTm5YuRBo
         CtZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717321; x=1688309321;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJ9vneQJ4b683G/HZn1+z6+HzvNcmHcX4U7xxt8CZQM=;
        b=FfzLpQuBQ2aZKfVC0A3CkNqFtlhlhIA0vzBBbEQfxsBG6jFNubEBSkvmn9Jh5BH1k6
         zP+wey0YGYN05wh3HlOT6JYDWY7iuIaOHhBamBj4VyW1McHc+jE+VquK1NlwF+vkd+Rd
         FIj2vUaOwzrzVmpnKawyR5qHNnFeSlJOqTeFKmHix1aCM3LBckzhXbbFabGMslkJVos1
         f2rEyHuUFqJyoFANkN7WveLqj2wFA+q50Ys01VGKIt6f7+Ncc9I6ktFEAsJHRmdA12QZ
         dt5sQ1LLxzkupif/D+nfX6UX1qOVNkI3lGLCKAYUVk2l/2gVB8OlMsovZ+Ib1YW77A5w
         q1VA==
X-Gm-Message-State: AC+VfDxPIyATs7M0gsZLruP73HTWuQtgpk/MMZz9ScCwVirjfvOiuxUK
        v0OaMqma1S28zNr8MKjMp46zQw==
X-Google-Smtp-Source: ACHHUZ7UZYmvfQCc3kWCaTEJZ/XKHlA07x9dA5pULrpWr6CJ5UxHiyb7LwJqRCvti/IzE2pGri8UQg==
X-Received: by 2002:a17:907:160d:b0:974:1c91:a751 with SMTP id hb13-20020a170907160d00b009741c91a751mr12009627ejc.29.1685717321001;
        Fri, 02 Jun 2023 07:48:41 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id cb2-20020a170906a44200b0097457363fc0sm851382ejb.33.2023.06.02.07.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:48:40 -0700 (PDT)
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-9-aliceryhl@google.com>
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
Subject: Re: [PATCH v2 8/8] rust: workqueue: add examples
Date:   Fri, 02 Jun 2023 16:48:14 +0200
In-reply-to: <20230601134946.3887870-9-aliceryhl@google.com>
Message-ID: <87y1l1zzqw.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> This adds two examples of how to use the workqueue. The first example
> shows how to use it when you only have one `work_struct` field, and the
> second example shows how to use it when you have multiple `work_struct`
> fields.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>

> ---
>  rust/kernel/workqueue.rs | 104 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 104 insertions(+)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index c302e8b8624b..cefcf43ff40e 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -26,6 +26,110 @@
>  //!  * The `WorkItemPointer` trait is implemented for the pointer type that points at a something
>  //!    that implements `WorkItem`.
>  //!
> +//! ## Example
> +//!
> +//! This example defines a struct that holds an integer and can be scheduled on the workqueue. When
> +//! the struct is executed, it will print the integer. Since there is only one `work_struct` field,
> +//! we do not need to specify ids for the fields.
> +//!
> +//! ```
> +//! use kernel::prelude::*;
> +//! use kernel::sync::Arc;
> +//! use kernel::workqueue::{self, Work, WorkItem};
> +//!
> +//! #[pin_data]
> +//! struct MyStruct {
> +//!     value: i32,
> +//!     #[pin]
> +//!     work: Work<MyStruct>,
> +//! }
> +//!
> +//! impl_has_work! {
> +//!     impl HasWork<Self> for MyStruct { self.work }
> +//! }
> +//!
> +//! impl MyStruct {
> +//!     fn new(value: i32) -> Result<Arc<Self>> {
> +//!         Arc::pin_init(pin_init!(MyStruct {
> +//!             value,
> +//!             work <- Work::new(),
> +//!         }))
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The value is: {}", this.value);
> +//!     }
> +//! }
> +//!
> +//! /// This method will enqueue the struct for execution on the system workqueue, where its value
> +//! /// will be printed.
> +//! fn print_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue(val);
> +//! }
> +//! ```
> +//!
> +//! The following example shows how multiple `work_struct` fields can be used:
> +//!
> +//! ```
> +//! use kernel::prelude::*;
> +//! use kernel::sync::Arc;
> +//! use kernel::workqueue::{self, Work, WorkItem};
> +//!
> +//! #[pin_data]
> +//! struct MyStruct {
> +//!     value_1: i32,
> +//!     value_2: i32,
> +//!     #[pin]
> +//!     work_1: Work<MyStruct, 1>,
> +//!     #[pin]
> +//!     work_2: Work<MyStruct, 2>,
> +//! }
> +//!
> +//! impl_has_work! {
> +//!     impl HasWork<Self, 1> for MyStruct { self.work_1 }
> +//!     impl HasWork<Self, 2> for MyStruct { self.work_2 }
> +//! }
> +//!
> +//! impl MyStruct {
> +//!     fn new(value_1: i32, value_2: i32) -> Result<Arc<Self>> {
> +//!         Arc::pin_init(pin_init!(MyStruct {
> +//!             value_1,
> +//!             value_2,
> +//!             work_1 <- Work::new(),
> +//!             work_2 <- Work::new(),
> +//!         }))
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem<1> for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The value is: {}", this.value_1);
> +//!     }
> +//! }
> +//!
> +//! impl WorkItem<2> for MyStruct {
> +//!     type Pointer = Arc<MyStruct>;
> +//!
> +//!     fn run(this: Arc<MyStruct>) {
> +//!         pr_info!("The second value is: {}", this.value_2);
> +//!     }
> +//! }
> +//!
> +//! fn print_1_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 1>(val);
> +//! }
> +//!
> +//! fn print_2_later(val: Arc<MyStruct>) {
> +//!     let _ = workqueue::system().enqueue::<Arc<MyStruct>, 2>(val);
> +//! }
> +//! ```
> +//!
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
>  use crate::{bindings, prelude::*, sync::Arc, types::Opaque};

