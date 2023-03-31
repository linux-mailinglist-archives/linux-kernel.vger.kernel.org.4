Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184BD6D1E42
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 12:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjCaKot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 06:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjCaKoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 06:44:46 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29F32705
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:44:44 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so13570912wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 03:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112; t=1680259483;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=fgT4pXwjWpcWsJKRJyD25qwvo3Ove36z7OrufJWsW1A=;
        b=El59aSwYyOp2Y8Sd2PhJVSLno9VB6oTPKZs67mKeAGMqU/X3yT9/f+iSntz2reoX7L
         +CM/7tDcOdHCZYL3VnrLb8I1fIMphVsrgHdkT9nwNyywwVUyeZhmrB1AE9DTkzpPFfHu
         uRISu6S5uZsy+LRu2waCG54ghnFcwZ0JW2Q3yUEdU+KAoMbrysq9XSGI20H6nGtDpEHG
         dCriicvF8tNJ671leD2ssWaIagH8wxxd45ILNytHqi4fj7kI23skzDSGTWfGfo77tFD5
         nPnH7H1pQtgDaAg7SjNoO+raM45+nthCpZAbU6b2TPSvjt9rHjbZ0oaKH54EpnEyi2O8
         L/qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680259483;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fgT4pXwjWpcWsJKRJyD25qwvo3Ove36z7OrufJWsW1A=;
        b=OTE2g9sjD+qdctDj7dymJXE+MnoyLyG0gzHRplIlt6cL+Qr590knOn8+TyJZdNA8lK
         iSIeZOYcQpjSaqh5uH/9PMw0ZWvRYTZ9Gj2dNtv72BFg5USqDhk+D7vZO0TzNMFXkFsa
         fNAYM1hqChRi9QoyaiTHv4OcuCx93d7hW2T/w8M4O6+WvCQUwl7/wJdavOtue+ui4bT9
         NvbXa6yNNjmFlopMnEHX4vmJ2Nc0m5EES4orr//fgdvJKJx24qJlKNRnpsndlHL6Oo66
         Ty9VWXePzizRa5huUZZ6RG5InB6zSgZdLebguiSmH1leHq65vlHrecXiNM9QO80yiByP
         O5Zg==
X-Gm-Message-State: AO0yUKWv8K3BlOUaNVkzeCPK0bHNV/pF/P/gPxed19QxyL0Nd2JML5ZF
        +3EFqKA8Mf/wEDQ+utSOQatviQ==
X-Google-Smtp-Source: AK7set9y9gLg+XLbecDYSwGE4Ch1DQts4Jcp8EXa6yx+72irIAbmqQLk97Vy66y63JrUUbStL6ZCow==
X-Received: by 2002:a7b:ca58:0:b0:3ed:93de:49ff with SMTP id m24-20020a7bca58000000b003ed93de49ffmr18973946wml.0.1680259482975;
        Fri, 31 Mar 2023 03:44:42 -0700 (PDT)
Received: from localhost ([147.161.155.82])
        by smtp.gmail.com with ESMTPSA id a14-20020a05600c224e00b003ef5f77901dsm2209464wmm.45.2023.03.31.03.44.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 03:44:42 -0700 (PDT)
References: <20230329223239.138757-1-y86-dev@protonmail.com>
 <20230329223239.138757-2-y86-dev@protonmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     y86-dev@protonmail.com
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Alice Ryhl <alice@ryhl.io>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andreas Hindborg <a.hindborg@samsung.com>
Subject: Re: [PATCH v3 01/13] rust: macros: add `quote!` macro
Date:   Fri, 31 Mar 2023 12:43:55 +0200
In-reply-to: <20230329223239.138757-2-y86-dev@protonmail.com>
Message-ID: <87wn2x2o9y.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


y86-dev@protonmail.com writes:

> From: Gary Guo <gary@garyguo.net>
>
> Add the `quote!` macro for creating `TokenStream`s directly via the
> given Rust tokens. It also supports repetitions using iterators.
>
> It will be used by the pin-init API proc-macros to generate code.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Benno Lossin <y86-dev@protonmail.com>
> ---

Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>

>  rust/macros/lib.rs   |   2 +
>  rust/macros/quote.rs | 145 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 147 insertions(+)
>  create mode 100644 rust/macros/quote.rs
>
> diff --git a/rust/macros/lib.rs b/rust/macros/lib.rs
> index c1d385e345b9..82b520f024dd 100644
> --- a/rust/macros/lib.rs
> +++ b/rust/macros/lib.rs
> @@ -2,6 +2,8 @@
>
>  //! Crate for all kernel procedural macros.
>
> +#[macro_use]
> +mod quote;
>  mod concat_idents;
>  mod helpers;
>  mod module;
> diff --git a/rust/macros/quote.rs b/rust/macros/quote.rs
> new file mode 100644
> index 000000000000..7efb009c25a9
> --- /dev/null
> +++ b/rust/macros/quote.rs
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: Apache-2.0 OR MIT
> +
> +use proc_macro::{TokenStream, TokenTree};
> +
> +pub(crate) trait ToTokens {
> +    fn to_tokens(&self, tokens: &mut TokenStream);
> +}
> +
> +impl<T: ToTokens> ToTokens for Option<T> {
> +    fn to_tokens(&self, tokens: &mut TokenStream) {
> +        if let Some(v) = self {
> +            v.to_tokens(tokens);
> +        }
> +    }
> +}
> +
> +impl ToTokens for proc_macro::Group {
> +    fn to_tokens(&self, tokens: &mut TokenStream) {
> +        tokens.extend([TokenTree::from(self.clone())]);
> +    }
> +}
> +
> +impl ToTokens for TokenTree {
> +    fn to_tokens(&self, tokens: &mut TokenStream) {
> +        tokens.extend([self.clone()]);
> +    }
> +}
> +
> +impl ToTokens for TokenStream {
> +    fn to_tokens(&self, tokens: &mut TokenStream) {
> +        tokens.extend(self.clone());
> +    }
> +}
> +
> +/// Converts tokens into [`proc_macro::TokenStream`] and performs variable interpolations with
> +/// the given span.
> +///
> +/// This is a similar to the
> +/// [`quote_spanned!`](https://docs.rs/quote/latest/quote/macro.quote_spanned.html) macro from the
> +/// `quote` crate but provides only just enough functionality needed by the current `macros` crate.
> +#[allow(unused_macros)]
> +macro_rules! quote_spanned {
> +    ($span:expr => $($tt:tt)*) => {
> +    #[allow(clippy::vec_init_then_push)]
> +    {
> +        let mut tokens = Vec::new();
> +        let span = $span;
> +        quote_spanned!(@proc tokens span $($tt)*);
> +        proc_macro::TokenStream::from_iter(tokens)
> +    }};
> +    (@proc $v:ident $span:ident) => {};
> +    (@proc $v:ident $span:ident #$id:ident $($tt:tt)*) => {
> +        let mut ts = proc_macro::TokenStream::new();
> +        crate::quote::ToTokens::to_tokens(&$id, &mut ts);
> +        $v.extend(ts.into_iter());
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident #(#$id:ident)* $($tt:tt)*) => {
> +        for token in $id {
> +            let mut ts = proc_macro::TokenStream::new();
> +            crate::quote::ToTokens::to_tokens(&token, &mut ts);
> +            $v.extend(ts.into_iter());
> +        }
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident ( $($inner:tt)* ) $($tt:tt)*) => {
> +        let mut tokens = Vec::new();
> +        quote_spanned!(@proc tokens $span $($inner)*);
> +        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
> +            proc_macro::Delimiter::Parenthesis,
> +            proc_macro::TokenStream::from_iter(tokens)
> +        )));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident [ $($inner:tt)* ] $($tt:tt)*) => {
> +        let mut tokens = Vec::new();
> +        quote_spanned!(@proc tokens $span $($inner)*);
> +        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
> +            proc_macro::Delimiter::Bracket,
> +            proc_macro::TokenStream::from_iter(tokens)
> +        )));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident { $($inner:tt)* } $($tt:tt)*) => {
> +        let mut tokens = Vec::new();
> +        quote_spanned!(@proc tokens $span $($inner)*);
> +        $v.push(proc_macro::TokenTree::Group(proc_macro::Group::new(
> +            proc_macro::Delimiter::Brace,
> +            proc_macro::TokenStream::from_iter(tokens)
> +        )));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident :: $($tt:tt)*) => {
> +        $v.push(
> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_macro::Spacing::Joint))
> +        );
> +        $v.push(
> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_macro::Spacing::Alone))
> +        );
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident : $($tt:tt)*) => {
> +        $v.push(
> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new(':', proc_macro::Spacing::Alone))
> +        );
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident , $($tt:tt)*) => {
> +        $v.push(
> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new(',', proc_macro::Spacing::Alone))
> +        );
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident @ $($tt:tt)*) => {
> +        $v.push(
> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new('@', proc_macro::Spacing::Alone))
> +        );
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident ! $($tt:tt)*) => {
> +        $v.push(
> +            proc_macro::TokenTree::Punct(proc_macro::Punct::new('!', proc_macro::Spacing::Alone))
> +        );
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +    (@proc $v:ident $span:ident $id:ident $($tt:tt)*) => {
> +        $v.push(proc_macro::TokenTree::Ident(proc_macro::Ident::new(stringify!($id), $span)));
> +        quote_spanned!(@proc $v $span $($tt)*);
> +    };
> +}
> +
> +/// Converts tokens into [`proc_macro::TokenStream`] and performs variable interpolations with
> +/// mixed site span ([`Span::mixed_site()`]).
> +///
> +/// This is a similar to the [`quote!`](https://docs.rs/quote/latest/quote/macro.quote.html) macro
> +/// from the `quote` crate but provides only just enough functionality needed by the current
> +/// `macros` crate.
> +///
> +/// [`Span::mixed_site()`]: https://doc.rust-lang.org/proc_macro/struct.Span.html#method.mixed_site
> +#[allow(unused_macros)]
> +macro_rules! quote {
> +    ($($tt:tt)*) => {
> +        quote_spanned!(proc_macro::Span::mixed_site() => $($tt)*)
> +    }
> +}

