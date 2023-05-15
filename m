Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82016703CDB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244225AbjEOSjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243328AbjEOSjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:39:37 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11374268F
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:39:36 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bcb4a81ceso23192371a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684175974; x=1686767974;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=Dl1Ick5+y0z3ChuC16Xif3bBPKbyd3ReO5tblUB4trg=;
        b=HoLkpmx8b32mON58aaOI26AqqsUYSvMn9llJihQNKRcCVEIhYzP1Kh6XnoR2/7VVs5
         98mdhcMwnnLLjvxd7RUNdzWzXGdNQW03szhF0KTRiLgcuhWy9EPjHAh4aC/zRSY5Uuuv
         kzEhp3KcES4f7umsQ8lXqPjR2XSsBUcJpZsLbw9b5kbcu6mMuMmB3jNUyDt7njPz3MNz
         Pw73U77KJx1oLxJJhndezhAN/jmFj87J8uGovtsBF3JP0BlShlyGb2flXtTrO84aBunl
         LEtG4QWnatvyl8awCNcVewNM/dv8Kqse77t4MQng+0fqnbTEHJeDJa9JVDFHJRBa3Kef
         UyWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684175974; x=1686767974;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dl1Ick5+y0z3ChuC16Xif3bBPKbyd3ReO5tblUB4trg=;
        b=j+1EqVzY9NA8kJCVqqonV4aPrMYC9ZmbwWfbt7fUR9wh50nBMyhhwZ/NeJavk15kYk
         qcn3FiGSvl3MGabVulS6/9JjduShxs0nLugQySOjCbv82JYU57xfz42UlgowhjsbbvQY
         hh0lsS0UuaLQNtDAfCTaX+lA3ihSAVwHh4cqx2iagp74RkLSMsEDFHfz2uFMm3ngjbxP
         UtIwmxOmzXa3oxWfM+Wy/01BNyAx++W3NTRqjg0ZM6iQkeuNNMff5mmiWiVk6LezGeMr
         PHQVZbg+YyE/i/wycKNDB1CTrx8YI5aMaE9Gnhd7L2yeXJO/PrMx6qYRNuZMOdh+dZ9O
         RRbg==
X-Gm-Message-State: AC+VfDwHdEV9F+PI1m6ntMlv78b6Q6DGwrkHMQpVV2toZ62xUD8GBMMx
        y/hEwoHNQyyZRcclZ38z7RvGdQ==
X-Google-Smtp-Source: ACHHUZ6Lhwsf1IqGhRp+H/JzKUfKgGXirGUvi+6afds1Me7/s5xFqcZKkvOrRy7bcMDLHP8yLutv0g==
X-Received: by 2002:a17:907:9308:b0:965:b2c3:9575 with SMTP id bu8-20020a170907930800b00965b2c39575mr29323647ejc.57.1684175974420;
        Mon, 15 May 2023 11:39:34 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090614cf00b00965ff04f9f6sm9804211ejc.161.2023.05.15.11.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:39:33 -0700 (PDT)
References: <20230503141016.683634-1-aliceryhl@google.com>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
Date:   Mon, 15 May 2023 20:36:47 +0200
In-reply-to: <20230503141016.683634-1-aliceryhl@google.com>
Message-ID: <87bkilo2vu.fsf@metaspace.dk>
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


Alice Ryhl <aliceryhl@google.com> writes:

> These methods can be used to copy the data in a temporary c string into
> a separate allocation, so that it can be accessed later even if the
> original is deallocated.
>
> The API in this change mirrors the standard library API for the `&str`
> and `String` types. The `ToOwned` trait is not implemented because it
> assumes that allocations are infallible.
>
> Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>


>  rust/kernel/str.rs | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/rust/kernel/str.rs b/rust/kernel/str.rs
> index b771310fa4a4..f3dc5b24ea55 100644
> --- a/rust/kernel/str.rs
> +++ b/rust/kernel/str.rs
> @@ -2,6 +2,7 @@
>  
>  //! String representations.
>  
> +use alloc::alloc::AllocError;
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
> +    pub fn to_cstring(&self) -> Result<CString, AllocError> {
> +        CString::try_from(self)
> +    }
>  }
>  
>  impl fmt::Display for CStr {
> @@ -584,6 +591,21 @@ impl Deref for CString {
>      }
>  }
>  
> +impl<'a> TryFrom<&'a CStr> for CString {
> +    type Error = AllocError;
> +
> +    fn try_from(cstr: &'a CStr) -> Result<CString, AllocError> {
> +        let mut buf = Vec::new();
> +
> +        buf.try_extend_from_slice(cstr.as_bytes_with_nul())
> +            .map_err(|_| AllocError)?;
> +
> +        // INVARIANT: The `CStr` and `CString` types have the same invariants for
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

