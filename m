Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7176F48BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 19:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbjEBRAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 13:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbjEBRAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 13:00:09 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8EB2114;
        Tue,  2 May 2023 10:00:07 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-b9d9dad9edfso5219188276.2;
        Tue, 02 May 2023 10:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683046806; x=1685638806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2JuzgaRSwqX93Paz8QMIW2w6sN1tsO1/zDhr8bQyJhU=;
        b=eFRn/beJBSstmGMrZtoYnDVn0LbYK/XQfQeez8QUz+OFuKfJjo5HdP0RhIVCl/oKoQ
         0beAEmckSFMVmC/FvrSqxNkyd/oze7dqbUYNYYXtZhFLwp34FhEmy+PyxECIglxEob3b
         h61xNGFSSStI3aKEEiSetu0lubr5OPti/2v7lBAYxz11WmypJFzep6Du33BINW45Xa4O
         QtyuxfJjPl03PTmspIcq4lRLFMIhqbtK2KGRY8b4JK4IZrUKw8SSqo8G/pv8cFF5w2s0
         XU7leAQ+qTmAmfsJTn6tZGCiJNOZrrU7hDNgd9diAFWPrLAfzfDGiMxJsJdhUtD1u7pq
         XA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683046806; x=1685638806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2JuzgaRSwqX93Paz8QMIW2w6sN1tsO1/zDhr8bQyJhU=;
        b=KqYuBpi304r2uC41s0DG8XnK0S8fbjmnIEaKDf6h3+wVdq+0gCgTTHBd/258Q4CUvi
         KYkjJwxYBincvWzY4UapR5QvkLPMs9dnJDAUDDzOHLJrvTed0fApuwM4k90ZIZjvgocU
         4yChE1EiJqJ+z9MkmOVv+YQ8wgJVbZU5gPCJzVo9Osli74zHQQfH7CZqwYBJNxK2ax1A
         JkiL0NMYHDmxrzbYObUmC+nwIX71EwbAShd6GrcmBJlfU/H88LuIFoPuxoc1o0Wb9yO6
         Mxsk182+3OHf8IKyncnSqcwbcsn72OuYO5fMrM+ITjCzwYn9Ez48HiwCG7LrIV1s40Qa
         Sm2A==
X-Gm-Message-State: AC+VfDw55W3HAW8mtkKeZzKQfzQGk3gY3eEjVQR4YITJgn24pfAzqpUx
        3XUbrQOhM4Al1LHmiXxb+uByfYkP2kfu72ucPGrQUH6kD7o=
X-Google-Smtp-Source: ACHHUZ6bE/xq2Qn+iEAMe8Oxl5bvh8V3EXlR1Li/Xdmzx4xFCozf90pZSHDYVUQp6VAj57DeQOOyUAOUucuphEvie0U=
X-Received: by 2002:a25:cd45:0:b0:b9d:7887:4423 with SMTP id
 d66-20020a25cd45000000b00b9d78874423mr12778541ybf.16.1683046806559; Tue, 02
 May 2023 10:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230502125306.358283-1-aliceryhl@google.com>
In-Reply-To: <20230502125306.358283-1-aliceryhl@google.com>
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
Date:   Tue, 2 May 2023 13:59:56 -0300
Message-ID: <CANeycqo+htksD_nj-eyCTOtE0TQHJR+dHZ1Hu8cL5eXNt4cd=A@mail.gmail.com>
Subject: Re: [PATCH] rust: str: add conversion from `CStr` to `CString`
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 09:53, Alice Ryhl <aliceryhl@google.com> wrote:
>
> These methods can be used to copy the data in a temporary c string into
> a separate allocation, so that it can be accessed later even if the
> original is deallocated.
>
> The API in this file mirrors the standard library API for the `&str` and
> `String` types. The `ToOwned` trait is not implemented because it
> assumes that allocations are infallible.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  rust/kernel/str.rs | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index b771310fa4a4..54935ff3a610 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,6 +2,7 @@
>
>  //! String representations.
>
> +use alloc::collections::TryReserveError;
>  use alloc::vec::Vec;
>  use core::fmt::{self, Write};
>  use core::ops::{self, Deref, Index};
> @@ -199,6 +200,12 @@ impl CStr {
>      pub unsafe fn as_str_unchecked(&self) -> &str {
>          unsafe { core::str::from_utf8_unchecked(self.as_bytes()) }
>      }
> +
> +    /// Convert this [`CStr`] into a [`CString`] by allocating memory and
> +    /// copying over the string data.
> +    pub fn to_cstring(&self) -> Result<CString, TryReserveError> {
> +        CString::try_from(self)
> +    }
>  }
>
>  impl fmt::Display for CStr {
> @@ -584,6 +591,20 @@ impl Deref for CString {
>      }
>  }
>
> +impl<'a> TryFrom<&'a CStr> for CString {
> +    type Error = TryReserveError;

Wouldn't `AllocError` make more sense? Or even Error (with ENOMEM value).

`TryReserveError` is documented as "The error type for try_reserve
methods." -- that fact the we use a `Vec` is an implementation detail,
I feel it's better not to leak this fact through the public API.

> +
> +    fn try_from(cstr: &'a CStr) -> Result<CString, TryReserveError> {
> +        let len = cstr.len_with_nul();
> +        let mut buf = Vec::try_with_capacity(len)?;
> +        buf.try_extend_from_slice(cstr.as_bytes_with_nul())?;
> +
> +        // INVARIANT: The CStr and CString types have the same invariants for
> +        // the string data, and we copied it over without changes.
> +        Ok(CString { buf })
> +    }
> +}
> +
>  /// A convenience alias for [`core::format_args`].
>  #[macro_export]
>  macro_rules! fmt {
>
> base-commit: ea76e08f4d901a450619831a255e9e0a4c0ed162
> --
> 2.40.1.495.gc816e09b53d-goog
>
