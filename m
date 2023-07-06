Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB274A322
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 19:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbjGFRdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 13:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjGFRdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 13:33:35 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83972B2;
        Thu,  6 Jul 2023 10:33:30 -0700 (PDT)
Date:   Thu, 06 Jul 2023 17:33:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1688664806; x=1688924006;
        bh=gO2BKfjwlzki2Tjw5P6AggQxCkuHmpo/jAvQ/A+lNUg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=NKF0/9JhQoNuzDECKLmD1fcbeeNWtc1rryijHUc0GVmn1vcPbGiu59/vtk47PS/o+
         M3rzg2Fv9Z4RcuH4fcVceXnsAIN07P1bj3YtABxw0Hb/0gce1831tkflSm3TS/vrXd
         8ImMK2UitpLButHPsCNMhZuyrEuZcyZLmNyi0oiOJML/irg11Qa/nQ6D07eDm33kRz
         uhtOALL9NyvOsMycO/2LNVfiUqlF3TUmRmykLVJP+5npnmqoGa58WURa8+bM+nd25a
         x/u1qQorKwze8EYmXCEyfo/1me9zVDM4aWRC9RdaVjpQNA3UZpoWbZRWRToyaQVq6Z
         ACQRdeXBJTqXQ==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH] rust: delete `ForeignOwnable::borrow_mut`
Message-ID: <ZxQ3Iwjmp3_Nitm5A7iA-MvgW2LSxiw1vgwxwkyMHv6P4KfBxQT69uVPV43H4mGZcwJGdea-6ILhJGi8zdjmZF5-3UHshUQdKzep_7eMTTY=@proton.me>
In-Reply-To: <20230706094615.3080784-1-aliceryhl@google.com>
References: <20230706094615.3080784-1-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06.07.23 11:46, Alice Ryhl wrote:
> We discovered that the current design of `borrow_mut` is problematic.
> This patch removes it until a better solution can be found.
>=20
> Specifically, the current design gives you access to a `&mut T`, which
> lets you change where the `ForeignOwnable` points (e.g., with
> `core::mem::swap`). No upcoming user of this API intended to make that
> possible, making all of them unsound.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

> ---
>   rust/kernel/sync/arc.rs |  3 +--
>   rust/kernel/types.rs    | 22 ++--------------------
>   2 files changed, 3 insertions(+), 22 deletions(-)
>=20
> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index a89843cacaad..172f563976a9 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -243,8 +243,7 @@ unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -=
> ArcBorrow<'a, T> {
>           let inner =3D NonNull::new(ptr as *mut ArcInner<T>).unwrap();
>=20
>           // SAFETY: The safety requirements of `from_foreign` ensure tha=
t the object remains alive
> -        // for the lifetime of the returned value. Additionally, the saf=
ety requirements of
> -        // `ForeignOwnable::borrow_mut` ensure that no new mutable refer=
ences are created.
> +        // for the lifetime of the returned value.
>           unsafe { ArcBorrow::new(inner) }
>       }
>=20
> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 1e5380b16ed5..d479f8da8f38 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -35,34 +35,16 @@ pub trait ForeignOwnable: Sized {
>       ///
>       /// `ptr` must have been returned by a previous call to [`ForeignOw=
nable::into_foreign`] for
>       /// which a previous matching [`ForeignOwnable::from_foreign`] hasn=
't been called yet.
> -    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow_mut`]
> -    /// for this object must have been dropped.
>       unsafe fn borrow<'a>(ptr: *const core::ffi::c_void) -> Self::Borrow=
ed<'a>;
>=20
> -    /// Mutably borrows a foreign-owned object.
> -    ///
> -    /// # Safety
> -    ///
> -    /// `ptr` must have been returned by a previous call to [`ForeignOwn=
able::into_foreign`] for
> -    /// which a previous matching [`ForeignOwnable::from_foreign`] hasn'=
t been called yet.
> -    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow`] and
> -    /// [`ForeignOwnable::borrow_mut`] for this object must have been dr=
opped.
> -    unsafe fn borrow_mut(ptr: *const core::ffi::c_void) -> ScopeGuard<Se=
lf, fn(Self)> {
> -        // SAFETY: The safety requirements ensure that `ptr` came from a=
 previous call to
> -        // `into_foreign`.
> -        ScopeGuard::new_with_data(unsafe { Self::from_foreign(ptr) }, |d=
| {
> -            d.into_foreign();
> -        })
> -    }
> -
>       /// Converts a foreign-owned object back to a Rust-owned one.
>       ///
>       /// # Safety
>       ///
>       /// `ptr` must have been returned by a previous call to [`ForeignOw=
nable::into_foreign`] for
>       /// which a previous matching [`ForeignOwnable::from_foreign`] hasn=
't been called yet.
> -    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow`] and
> -    /// [`ForeignOwnable::borrow_mut`] for this object must have been dr=
opped.
> +    /// Additionally, all instances (if any) of values returned by [`For=
eignOwnable::borrow`] for
> +    /// this object must have been dropped.
>       unsafe fn from_foreign(ptr: *const core::ffi::c_void) -> Self;
>   }
>=20
>=20
> base-commit: d2e3115d717197cb2bc020dd1f06b06538474ac3
> --
> 2.41.0.255.g8b1d071c50-goog
> 
