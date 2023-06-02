Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A0F7204C3
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 16:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236174AbjFBOnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 10:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236086AbjFBOnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 10:43:50 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4F721B3
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jun 2023 07:43:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9741caaf9d4so302204166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jun 2023 07:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685717027; x=1688309027;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=HiT9+FOvSDgrU3EvO2uC6SOYObLJTSqPECXVlks7Q4s=;
        b=fksRSXQg0xd3o1gTujB1C0oLz9ZjsAd3ALsBJe5SOmG8a7VsgwnlpGsy+0b0Dr4n/U
         A4xJkyFLkDK6juw5/aZ2kwz5HO2LE9pilpukOvPJnIISikBNmK3rx+9SWwDP005MOXW7
         t6/VW6H02HYL4IcsB2Xjsp//RX6Dj75OYqSaMqXolzbcaYJ9sEZsCbC8ydd+NfgXn14E
         CJF7yDuNXWygqVKFAyodAQaUg8IhnemQjQAYBLmaWZk9Dz22/E7hqH9IDFmrorcnV9g5
         o3QvyeLNBiVlBTBUd1G2cEW4AUlipOG1mLgjiEWLoE/+Qc/7JzOSkBN0SmJ6uJ8WkzPw
         PxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685717027; x=1688309027;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiT9+FOvSDgrU3EvO2uC6SOYObLJTSqPECXVlks7Q4s=;
        b=BdDkMuEDZ8Fcmq3/SskxRRJGFXNXvtwngvT+A1cnONWzEfiOufIgcrBsHnSkM49Uan
         ZE2gXKIToxSYtrSNZHuOA//w/DqicqjyPr7ethPBfr8D7D+0+Jb7g6PVh7fXIww/B8yl
         z9xTUVPa2HWqCzhHgEYFY3/ydX3KKkwzLBEyzkCVXp1Pbji1tLb6cYS5UqbpZDuLVVIu
         eoyoJEcEyg39b1pBKlE3hUZP6BQypNuxrOsyrStfJDVEkwBHJOpLAYyKOwftstWI59i1
         AdMy7DEtaOii19qeQGXXKsU8CT+6sSBIDNnXyEn8oMisd1WrgEJZzkYmsfsABMWxFx2O
         Cb/A==
X-Gm-Message-State: AC+VfDzveWpVdm6UOlwAgT3PYPbFnlrD+Wi3SgcrldSghYT6u4H21jl9
        E7v/+eDBJsWY/WMqEV9VuqyMeg==
X-Google-Smtp-Source: ACHHUZ4vu/ybbB860ST000hxSx+G25W11XyrRD4vZ7zPqf4TWeGuIiYRh2boQPz9XQfe7pptwDHqGA==
X-Received: by 2002:a17:907:7b98:b0:973:940e:a01b with SMTP id ne24-20020a1709077b9800b00973940ea01bmr12464509ejc.60.1685717027127;
        Fri, 02 Jun 2023 07:43:47 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id a22-20020a1709063e9600b0096637a19dccsm816565ejj.210.2023.06.02.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 07:43:46 -0700 (PDT)
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-8-aliceryhl@google.com>
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
Subject: Re: [PATCH v2 7/8] rust: workqueue: add `try_spawn` helper method
Date:   Fri, 02 Jun 2023 16:43:33 +0200
In-reply-to: <20230601134946.3887870-8-aliceryhl@google.com>
Message-ID: <87bkhx2acd.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,PDS_OTHER_BAD_TLD,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <aliceryhl@google.com> writes:

> This adds a convenience method that lets you spawn a closure for
> execution on a workqueue. This will be the most convenient way to use
> workqueues, but it is fallible because it needs to allocate memory.
>
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Andreas Hindborg (Samsung) <nmi@metaspace.dk>

> ---
>  rust/kernel/workqueue.rs | 43 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index f06a2f036d8b..c302e8b8624b 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -29,6 +29,7 @@
>  //! C header: [`include/linux/workqueue.h`](../../../../include/linux/workqueue.h)
>  
>  use crate::{bindings, prelude::*, sync::Arc, types::Opaque};
> +use alloc::alloc::AllocError;
>  use alloc::boxed::Box;
>  use core::marker::{PhantomData, PhantomPinned};
>  use core::pin::Pin;
> @@ -87,6 +88,44 @@ pub fn enqueue<W, const ID: u64>(&self, w: W) -> W::EnqueueOutput
>              })
>          }
>      }
> +
> +    /// Tries to spawn the given function or closure as a work item.
> +    ///
> +    /// This method can fail because it allocates memory to store the work item.
> +    pub fn try_spawn<T: 'static + Send + FnOnce()>(&self, func: T) -> Result<(), AllocError> {
> +        let init = pin_init!(ClosureWork {
> +            work <- Work::new(),
> +            func: Some(func),
> +        });
> +
> +        self.enqueue(Box::pin_init(init).map_err(|_| AllocError)?);
> +        Ok(())
> +    }
> +}
> +
> +/// A helper type used in `try_spawn`.
> +#[pin_data]
> +struct ClosureWork<T> {
> +    #[pin]
> +    work: Work<ClosureWork<T>>,
> +    func: Option<T>,
> +}
> +
> +impl<T> ClosureWork<T> {
> +    fn project(self: Pin<&mut Self>) -> &mut Option<T> {
> +        // SAFETY: The `func` field is not structurally pinned.
> +        unsafe { &mut self.get_unchecked_mut().func }
> +    }
> +}
> +
> +impl<T: FnOnce()> WorkItem for ClosureWork<T> {
> +    type Pointer = Pin<Box<Self>>;
> +
> +    fn run(mut this: Pin<Box<Self>>) {
> +        if let Some(func) = this.as_mut().project().take() {
> +            (func)()
> +        }
> +    }
>  }
>  
>  /// A raw work item.
> @@ -325,6 +364,10 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workqueue::Work<$work_typ
>      )*};
>  }
>  
> +impl_has_work! {
> +    impl<T> HasWork<Self> for ClosureWork<T> { self.work }
> +}
> +
>  unsafe impl<T, const ID: u64> WorkItemPointer<ID> for Arc<T>
>  where
>      T: WorkItem<ID, Pointer = Self>,

