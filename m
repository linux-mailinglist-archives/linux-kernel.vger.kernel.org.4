Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF2346A55CA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 10:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbjB1JaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 04:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjB1JaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 04:30:19 -0500
Received: from mout-b-105.mailbox.org (mout-b-105.mailbox.org [195.10.208.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A748C72B2;
        Tue, 28 Feb 2023 01:30:17 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-b-105.mailbox.org (Postfix) with ESMTPS id 4PQsXj4k9fz9tth;
        Tue, 28 Feb 2023 10:30:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nyantec.com; s=default;
        t=1677576613;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bi4OIXDyb2sM777Ha+kervPZF/8SdxTa01qLXizAj9E=;
        b=E2oZx40qJhRpnOxqow0hYGaXMt3skJHVIKtRaDvjE6GJRrfpbCOiCCap/E6RAlqLWiok06
        Znz4QT2RqfvV2t+zgYn1vArKmlGNLfmyefZXhv12IZizyw6msqwSVKJZrNZXSu+5GFeDD6
        kVncADUZew1H07Rj1ie8pNroOZmatrmcKzNUMNImjbN68d0fujX5yAblMGNf0doZ1n5jy0
        yOX8EPWPzI2V92nIpNWu7Aql+1vOoocnwmert20VHD6GLkkJCfcD1Z9eNuuCUxd6OpNPy7
        fNefKIH9pwv9+Ifyxs4ZTmM7+SoRaOCSahbuOrANcFL3EbyvW/2xHstkTnUBig==
From:   Finn Behrens <fin@nyantec.com>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
Subject: Re: [PATCH 1/3] rust: macros: Make expect_punct() return the Punct
 directly
Date:   Tue, 28 Feb 2023 10:29:59 +0100
Message-ID: <A74F7C50-1F28-4416-8E99-27B9F63A352B@nyantec.com>
In-Reply-To: <20230224-rust-macros-v1-1-b39fae46e102@asahilina.net>
References: <20230224-rust-macros-v1-0-b39fae46e102@asahilina.net>
 <20230224-rust-macros-v1-1-b39fae46e102@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 24 Feb 2023, at 8:25, Asahi Lina wrote:

> This makes it mirror the way expect_ident() works, and means we can mor=
e
> easily push the result back into the token stream.
>
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Reviewed-by: Finn Behrens <fin@nyantec.com>

> ---
>  rust/macros/concat_idents.rs | 2 +-
>  rust/macros/helpers.rs       | 6 +++---
>  rust/macros/module.rs        | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/rust/macros/concat_idents.rs b/rust/macros/concat_idents.r=
s
> index 7e4b450f3a50..6d955d65016e 100644
> --- a/rust/macros/concat_idents.rs
> +++ b/rust/macros/concat_idents.rs
> @@ -15,7 +15,7 @@ fn expect_ident(it: &mut token_stream::IntoIter) -> I=
dent {
>  pub(crate) fn concat_idents(ts: TokenStream) -> TokenStream {
>      let mut it =3D ts.into_iter();
>      let a =3D expect_ident(&mut it);
> -    assert_eq!(expect_punct(&mut it), ',');
> +    assert_eq!(expect_punct(&mut it).as_char(), ',');
>      let b =3D expect_ident(&mut it);
>      assert!(it.next().is_none(), "only two idents can be concatenated"=
);
>      let res =3D Ident::new(&format!("{a}{b}"), b.span());
> diff --git a/rust/macros/helpers.rs b/rust/macros/helpers.rs
> index cf7ad950dc1e..65706ecc007e 100644
> --- a/rust/macros/helpers.rs
> +++ b/rust/macros/helpers.rs
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>
> -use proc_macro::{token_stream, TokenTree};
> +use proc_macro::{token_stream, Punct, TokenTree};
>
>  pub(crate) fn try_ident(it: &mut token_stream::IntoIter) -> Option<Str=
ing> {
>      if let Some(TokenTree::Ident(ident)) =3D it.next() {
> @@ -38,9 +38,9 @@ pub(crate) fn expect_ident(it: &mut token_stream::Int=
oIter) -> String {
>      try_ident(it).expect("Expected Ident")
>  }
>
> -pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> char {
> +pub(crate) fn expect_punct(it: &mut token_stream::IntoIter) -> Punct {=

>      if let TokenTree::Punct(punct) =3D it.next().expect("Reached end o=
f token stream for Punct") {
> -        punct.as_char()
> +        punct
>      } else {
>          panic!("Expected Punct");
>      }
> diff --git a/rust/macros/module.rs b/rust/macros/module.rs
> index a7e363c2b044..07503b242d2d 100644
> --- a/rust/macros/module.rs
> +++ b/rust/macros/module.rs
> @@ -104,7 +104,7 @@ impl ModuleInfo {
>                  );
>              }
>
> -            assert_eq!(expect_punct(it), ':');
> +            assert_eq!(expect_punct(it).as_char(), ':');
>
>              match key.as_str() {
>                  "type" =3D> info.type_ =3D expect_ident(it),
> @@ -119,7 +119,7 @@ impl ModuleInfo {
>                  ),
>              }
>
> -            assert_eq!(expect_punct(it), ',');
> +            assert_eq!(expect_punct(it).as_char(), ',');
>
>              seen_keys.push(key);
>          }
>
> -- =

> 2.35.1
