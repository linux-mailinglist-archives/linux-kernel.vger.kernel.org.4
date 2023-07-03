Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C91745879
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 11:34:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjGCJe3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 05:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjGCJe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 05:34:26 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F294CD
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 02:34:24 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-4f875b267d9so6510093e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jul 2023 02:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1688376862; x=1690968862;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=qFhvCFqAXehqBRjZH7xGnUqT1VUtEV+4hwF7vSBD5kY=;
        b=QDmX7US6YcMAgmXBL8+nRgR/dRajVeyGSzO9kr04HZ74tuBP+94DpzYzKT7Cy+wrFD
         gTYuFG9k/iLNK+DWnj9FZG9KjYoiLX1N3cDqkXPTZRprdTrHJgv49fR6h3anrlq5CC4t
         FzSuDQMPfXBaDzB4fuVNJbOT3ihCTPgerpbXsi/PaY4CWSCNthLNxt8x+mo9G6MUOYhM
         9kfRyd7jtV4m8ldSeg+EhWtdvFIhOMZgzVHVnOg4bBasJOTbrRHpmMHH1Wmj8za42jsp
         D2/1IkSovyVjFdnco14dHYIUaFiMLzpMxuggT6DGojKZxn+nwFIadtRNG+eK/aaO7zUM
         keAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688376862; x=1690968862;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFhvCFqAXehqBRjZH7xGnUqT1VUtEV+4hwF7vSBD5kY=;
        b=LRKq1QcWqKy/43DcUOdGB3UeFg0hx8iAbabZbgHP7aNuC847SeGsR5uOfodDRjP8G9
         u3WMijjWzxHjIoEE7MRtDF8H5reIt7KRE637OB97bWQ0LPA9+Za1gM2l2CEY6fF6SPvq
         WmE3E968wUsfWOBkpBYKLW3EaEhfHZ+7yUhlL6xShCYpxGoNBcBcHLR36mkfui2op/JR
         fLhXq8WgVy4IrY4PxC4zAL9VRbSZuSqh3YbuMEBTXr5hpZvYbkmoVYHtfu64aO1Ws4kL
         Of74lO5uBNoIckYz4dl28HZJub87U+fOQVxxrZ+a1bKEh7RHC12T00GsXQtSCi5eofYJ
         VGEQ==
X-Gm-Message-State: ABy/qLY+0mv8xAdnOEENSfzYbe0nxm0WZe3OU727XqzTuhU7vsk1MveE
        SOvZzes+roO/ZqHxeUsIeGd+6w==
X-Google-Smtp-Source: APBJJlEP5/VzNY9M/lHHzn4JqHyCy7vhJD90vxmot+mAJWzQVW5jwFi0C6nYq4sdl+5I1W/Nis7tmQ==
X-Received: by 2002:a2e:9844:0:b0:2b6:cd6a:17f7 with SMTP id e4-20020a2e9844000000b002b6cd6a17f7mr6719111ljj.20.1688376862267;
        Mon, 03 Jul 2023 02:34:22 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id e13-20020a50fb8d000000b0051e0be09297sm1954178edq.53.2023.07.03.02.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 02:34:21 -0700 (PDT)
References: <20230630150216.109789-1-benno.lossin@proton.me>
User-agent: mu4e 1.10.4; emacs 28.2.50
From:   "Andreas Hindborg (Samsung)" <nmi@metaspace.dk>
To:     Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH] rust: types: make `Opaque` be `!Unpin`
Date:   Mon, 03 Jul 2023 11:30:56 +0200
In-reply-to: <20230630150216.109789-1-benno.lossin@proton.me>
Message-ID: <87mt0dcp9f.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Benno Lossin <benno.lossin@proton.me> writes:

> Adds a `PhantomPinned` field to `Opaque<T>`. This removes the last Rust
> guarantee: the assumption that the type `T` can be freely moved. This is
> not the case for many types from the C side (e.g. if they contain a
> `struct list_head`). This change removes the need to add a
> `PhantomPinned` field manually to Rust structs that contain C structs
> which must not be moved.
>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

> This patch depends on the patch that swaps `UnsafeCell` with
> `MaybeUninit` inside `Opaque` [1].
>
> [1]: https://lore.kernel.org/rust-for-linux/20230614115328.2825961-1-aliceryhl@google.com/
> ---
>  rust/kernel/types.rs | 19 ++++++++++++++-----
>  1 file changed, 14 insertions(+), 5 deletions(-)
>
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index fb41635f1e1f..e664a2beef30 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -6,7 +6,7 @@
>  use alloc::boxed::Box;
>  use core::{
>      cell::UnsafeCell,
> -    marker::PhantomData,
> +    marker::{PhantomData, PhantomPinned},
>      mem::MaybeUninit,
>      ops::{Deref, DerefMut},
>      ptr::NonNull,
> @@ -224,17 +224,26 @@ fn drop(&mut self) {
>  ///
>  /// This is meant to be used with FFI objects that are never interpreted by Rust code.
>  #[repr(transparent)]
> -pub struct Opaque<T>(UnsafeCell<MaybeUninit<T>>);
> +pub struct Opaque<T> {
> +    value: UnsafeCell<MaybeUninit<T>>,
> +    _pin: PhantomPinned,
> +}
>  
>  impl<T> Opaque<T> {
>      /// Creates a new opaque value.
>      pub const fn new(value: T) -> Self {
> -        Self(UnsafeCell::new(MaybeUninit::new(value)))
> +        Self {
> +            value: UnsafeCell::new(MaybeUninit::new(value)),
> +            _pin: PhantomPinned,
> +        }
>      }
>  
>      /// Creates an uninitialised value.
>      pub const fn uninit() -> Self {
> -        Self(UnsafeCell::new(MaybeUninit::uninit()))
> +        Self {
> +            value: UnsafeCell::new(MaybeUninit::uninit()),
> +            _pin: PhantomPinned,
> +        }
>      }
>  
>      /// Creates a pin-initializer from the given initializer closure.
> @@ -258,7 +267,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> impl PinInit<Self> {
>  
>      /// Returns a raw pointer to the opaque data.
>      pub fn get(&self) -> *mut T {
> -        UnsafeCell::get(&self.0).cast::<T>()
> +        UnsafeCell::get(&self.value).cast::<T>()
>      }
>  
>      /// Gets the value behind `this`.

