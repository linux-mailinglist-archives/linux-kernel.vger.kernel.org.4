Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2EF37301DF
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbjFNO2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237035AbjFNO2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:28:08 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61E51721;
        Wed, 14 Jun 2023 07:28:03 -0700 (PDT)
Date:   Wed, 14 Jun 2023 14:27:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1686752881; x=1687012081;
        bh=TaKHoWoduEdf1ULAdjEPdONgcWDvL8WQUMVGK+EvA5E=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=dNFrt+3gbyPbkBUmkd/PWupNZXiTiwc8CpC/mJxXuxtsM5Q49KRif7rmIGlcwbcB3
         0U2ua19QVjj1yxzMPXN+LqqjbHN/0c89FdHjyp1Jvdl7sxw7Y+SbGQ1lk6bvn7PwlN
         cISM1qgJIJUgPaEGIru1Bazz+keA6jbgkpK+PZYREelA15aNRu2iRuXZWja+m+sWHU
         G6hiPXz1csLlW4AUPJVxTqGFxs1Z1KpftAdsXHn+CcCzl2Q5nYN0nGIZUb1NUyfJVS
         SWTVn5E89b5eYGVF49+OwV6QcFqJbvorAErbeGGW4hgHPS4eS7j+9T14GYSSWB053d
         A+C0DhIgAU7mg==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: make `UnsafeCell` the outer type in `Opaque`
Message-ID: <zirWeKUZRqFhiN23v0pXHMmvuceI7EZyVvNUiREGf-UNbIbXLrHjbC8diUNg9v802jbX1978ezQLDCl--1M5S6K8l7CVWs8JGB-znEEMRNE=@proton.me>
In-Reply-To: <20230614115328.2825961-1-aliceryhl@google.com>
References: <20230614115328.2825961-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.06.23 13:53, Alice Ryhl wrote:
> When combining `UnsafeCell` with `MaybeUninit`, it is idiomatic to use
> `UnsafeCell` as the outer type. Intuitively, this is because a
> `MaybeUninit<T>` might not contain a `T`, but we always want the effect
> of the `UnsafeCell`, even if the inner value is uninitialized.
>=20
> Now, strictly speaking, this doesn't really make a difference. The
> compiler will always apply the `UnsafeCell` effect even if the inner
> value is uninitialized. But I think we should follow the convention
> here.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Small comment below, but I think it is fine the way it is.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/kernel/types.rs | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 1e5380b16ed5..fb41635f1e1f 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -224,17 +224,17 @@ fn drop(&mut self) {
>   ///
>   /// This is meant to be used with FFI objects that are never interprete=
d by Rust code.
>   #[repr(transparent)]
> -pub struct Opaque<T>(MaybeUninit<UnsafeCell<T>>);
> +pub struct Opaque<T>(UnsafeCell<MaybeUninit<T>>);
>=20
>   impl<T> Opaque<T> {
>       /// Creates a new opaque value.
>       pub const fn new(value: T) -> Self {
> -        Self(MaybeUninit::new(UnsafeCell::new(value)))
> +        Self(UnsafeCell::new(MaybeUninit::new(value)))
>       }
>=20
>       /// Creates an uninitialised value.
>       pub const fn uninit() -> Self {
> -        Self(MaybeUninit::uninit())
> +        Self(UnsafeCell::new(MaybeUninit::uninit()))
>       }
>=20
>       /// Creates a pin-initializer from the given initializer closure.
> @@ -258,7 +258,7 @@ pub fn ffi_init(init_func: impl FnOnce(*mut T)) -> im=
pl PinInit<Self> {
>=20
>       /// Returns a raw pointer to the opaque data.
>       pub fn get(&self) -> *mut T {
> -        UnsafeCell::raw_get(self.0.as_ptr())
> +        UnsafeCell::get(&self.0).cast::<T>()

Is there a reason you don't do `self.0.get().cast::<T>()`?

--=20
Cheers,
Benno

>       }
>=20
>       /// Gets the value behind `this`.
> @@ -266,7 +266,7 @@ pub fn get(&self) -> *mut T {
>       /// This function is useful to get access to the value without crea=
ting intermediate
>       /// references.
>       pub const fn raw_get(this: *const Self) -> *mut T {
> -        UnsafeCell::raw_get(this.cast::<UnsafeCell<T>>())
> +        UnsafeCell::raw_get(this.cast::<UnsafeCell<MaybeUninit<T>>>()).c=
ast::<T>()
>       }
>   }
>=20
>=20
> base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
> --
> 2.41.0.162.gfafddb0af9-goog
>=20

