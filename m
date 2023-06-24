Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DFBA73CB8C
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 17:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjFXPRR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 11:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjFXPRP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 11:17:15 -0400
Received: from mail-40137.protonmail.ch (mail-40137.protonmail.ch [185.70.40.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF35BE;
        Sat, 24 Jun 2023 08:17:13 -0700 (PDT)
Date:   Sat, 24 Jun 2023 15:17:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687619832; x=1687879032;
        bh=oqNbMDMVqYSYS7DA8muXpGFWCTY0wKl33meUenkWvVY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=tMLyvDngxwla/lu4eDw9gravTc+BGEbrRqE/XpZYW5kujgvQjkRQKUFHrysr71HIy
         u8ZMAJZw9e0d1v6W39SorECRwcZnI1OPxp8SZe3jTp3l0YPljoa4Qzy4LK9KB073HQ
         wkk+QLnfWTcvDwpFFjCJT1A1JNV/sPJG4I9mzNMC4Fq/glDya/kyg3xyX9nN3vbvKA
         YfFfxnqodrEnItJdxqG7GocAPuCYVr1UCkyVrBxA1b7ZA+DrHjL6UgytVg1Wi72hOf
         Pf7buSqTekXRvZK3GjA7kKhyIHf3Dwcl5oZ8aq+++b20T1apXT7SN2hbaWMLtAZMxJ
         TMjcnlzpJiF+Q==
To:     Benno Lossin <benno.lossin@proton.me>
From:   =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 6/7] rust: init: Add functions to create array initializers
Message-ID: <xHy4uUhB5UOmzgGDBs3Oh8O8YwC7l6KgvUP_s-D897heQhUIKGBxig6rIpr5EmupMXCXYI4LmuwhO5uB8CAWTtIY7buLMcuk_2ZS8UL2akA=@protonmail.com>
In-Reply-To: <20230624092330.157338-6-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-6-benno.lossin@proton.me>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 24th, 2023 at 11:25, Benno Lossin <benno.lossin@proton.me=
> wrote:

> Add two functions `pin_init_array_from_fn` and `init_array_from_fn` that
> take a function that generates initializers for `T` from usize, the added
> functions then return an initializer for `[T; N]` where every element is
> initialized by an element returned from the generator function.
>=20
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

> ---
>  rust/kernel/init.rs | 90 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 90 insertions(+)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index 44bc3e77419a..c9ea4bf71987 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -867,6 +867,96 @@ pub fn uninit<T, E>() -> impl Init<MaybeUninit<T>, E=
> {
>      unsafe { init_from_closure(|_| Ok(())) }
>  }
>=20
> +/// Initializes an array by initializing each element via the provided i=
nitializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// let array: Box<[usize; 1000_000_000]>=3D Box::init(init_array_from_f=
n(|i| i)).unwrap();
> +/// println!("{array:?}");
> +/// ```
> +pub fn init_array_from_fn<I, const N: usize, T, E>(
> +    mut make_init: impl FnMut(usize) -> I,
> +) -> impl Init<[T; N], E>
> +where
> +    I: Init<T, E>,
> +{
> +    let init =3D move |slot: *mut [T; N]| {
> +        let slot =3D slot.cast::<T>();
> +        for i in 0..N {
> +            let init =3D make_init(i);
> +            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[=
T; N]`.
> +            let ptr =3D unsafe { slot.add(i) };
> +            // SAFETY: The pointer is derived from `slot` and thus satis=
fies the `__init`
> +            // requirements.
> +            match unsafe { init.__init(ptr) } {
> +                Ok(()) =3D> {}
> +                Err(e) =3D> {
> +                    // We now free every element that has been initializ=
ed before:
> +                    for j in 0..i {
> +                        let ptr =3D unsafe { slot.add(j) };
> +                        // SAFETY: The value was initialized in a previo=
us iteration of the loop
> +                        // and since we return `Err` below, the caller w=
ill consider the memory at
> +                        // `slot` as uninitialized.
> +                        unsafe { ptr::drop_in_place(ptr) };
> +                    }
> +                    return Err(e);
> +                }
> +            }
> +        }
> +        Ok(())
> +    };
> +    // SAFETY: The initializer above initializes every element of the ar=
ray. On failure it drops
> +    // any initialized elements and returns `Err`.
> +    unsafe { init_from_closure(init) }
> +}
> +
> +/// Initializes an array by initializing each element via the provided i=
nitializer.
> +///
> +/// # Examples
> +///
> +/// ```rust
> +/// let array: Arc<[Mutex<usize>; 1000_000_000]>=3D
> +///     Arc::pin_init(init_array_from_fn(|i| new_mutex!(i))).unwrap();
> +/// println!("{array:?}");
> +/// ```
> +pub fn pin_init_array_from_fn<I, const N: usize, T, E>(
> +    mut make_init: impl FnMut(usize) -> I,
> +) -> impl PinInit<[T; N], E>
> +where
> +    I: PinInit<T, E>,
> +{
> +    let init =3D move |slot: *mut [T; N]| {
> +        let slot =3D slot.cast::<T>();
> +        for i in 0..N {
> +            let init =3D make_init(i);
> +            // SAFETY: since 0 <=3D `i` < N, it is still in bounds of `[=
T; N]`.
> +            let ptr =3D unsafe { slot.add(i) };
> +            // SAFETY: The pointer is derived from `slot` and thus satis=
fies the `__pinned_init`
> +            // requirements.
> +            match unsafe { init.__pinned_init(ptr) } {
> +                Ok(()) =3D> {}
> +                Err(e) =3D> {
> +                    // We now have to free every element that has been i=
nitialized before, since we
> +                    // have to abide by the drop guarantee.
> +                    for j in 0..i {
> +                        let ptr =3D unsafe { slot.add(j) };
> +                        // SAFETY: The value was initialized in a previo=
us iteration of the loop
> +                        // and since we return `Err` below, the caller w=
ill consider the memory at
> +                        // `slot` as uninitialized.
> +                        unsafe { ptr::drop_in_place(ptr) };
> +                    }
> +                    return Err(e);
> +                }
> +            }
> +        }
> +        Ok(())
> +    };
> +    // SAFETY: The initializer above initializes every element of the ar=
ray. On failure it drops
> +    // any initialized elements and returns `Err`.
> +    unsafe { pin_init_from_closure(init) }
> +}
> +
>  // SAFETY: Every type can be initialized by-value.
>  unsafe impl<T, E> Init<T, E> for T {
>      unsafe fn __init(self, slot: *mut T) -> Result<(), E> {
> --
> 2.41.0
