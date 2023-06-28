Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 026C0740E41
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232395AbjF1KIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 06:08:25 -0400
Received: from mail-4316.protonmail.ch ([185.70.43.16]:50913 "EHLO
        mail-4316.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbjF1J7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 05:59:32 -0400
Date:   Wed, 28 Jun 2023 09:59:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687946370; x=1688205570;
        bh=xre7AR6dyMRE6Z/GQMstLM6DJEOLT2mAAHNybbT1ScI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=eswIO/t0iPgLkux0PKMOQGjp9hJEXHjvsb3Vmj7imNRmF+VAQi0wjq5DssEXPsPKs
         sGU6i/s9vPqr4YqNE4345RQHEnX6fIlR884+0g/+pKQ30B16p8KbTTudUpVig1l8Ml
         Ur89BeNlSqujAYvWIGcUkAn1rAchN9iBwEyqOuRNBvhS+mevtJpgHI8FclvKI1oRT8
         j47CawYJRNUGHCkJ+PzTxiUn2Eq7VZMFNLiJvToKbaDnskZ/25b6X8ORQWx8VrqkfK
         qTctCVvNixQSYayR9An+LiHWfwOVXOO4an/5uIvRqyzMBLOEewWj+06FcG1fDMl4QS
         DwMbM9KCrPWkA==
To:     Qingsong Chen <changxian.cqs@antgroup.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        =?utf-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/1] rust: macros: fix redefine const_name in `vtable`
Message-ID: <-tQGhW-nja4JfdjHgbQgLqvDMc8gxJRsUFsk-cA9n7Q7w5g93rowJacyTT9G1T1_92g1DW1Y7OxjyndTEOYr32vp25DL--rX3W_56M1I8hY=@proton.me>
In-Reply-To: <20230626074242.3945398-2-changxian.cqs@antgroup.com>
References: <20230626074242.3945398-1-changxian.cqs@antgroup.com> <20230626074242.3945398-2-changxian.cqs@antgroup.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.06.23 09:42, Qingsong Chen wrote:
> If the trait has same function name, the `vtable` macro
> will redefine its `gen_const_name`, e.g.:
> ```rust
>      #[vtable]
>      pub trait Foo {
>          #[cfg(CONFIG_X)]
>          fn bar();
>=20
>          #[cfg(not(CONFIG_X))]
>          fn bar(x: usize);
>      }
> ```
> Use `HashSet` to avoid this.
>=20
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/macros/vtable.rs | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/rust/macros/vtable.rs b/rust/macros/vtable.rs
> index 34d5e7fb5768..08eb0355f99b 100644
> --- a/rust/macros/vtable.rs
> +++ b/rust/macros/vtable.rs
> @@ -27,7 +27,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStrea=
m) -> TokenStream {
>       };
>=20
>       let mut body_it =3D body.stream().into_iter();
> -    let mut functions =3D Vec::new();
> +    let mut functions =3D HashSet::new();
>       let mut consts =3D HashSet::new();
>       while let Some(token) =3D body_it.next() {
>           match token {
> @@ -37,7 +37,7 @@ pub(crate) fn vtable(_attr: TokenStream, ts: TokenStrea=
m) -> TokenStream {
>                       // Possibly we've encountered a fn pointer type ins=
tead.
>                       _ =3D> continue,
>                   };
> -                functions.push(fn_name);
> +                functions.insert(fn_name);
>               }
>               TokenTree::Ident(ident) if ident.to_string() =3D=3D "const"=
 =3D> {
>                   let const_name =3D match body_it.next() {
> --
> 2.40.1
> 
