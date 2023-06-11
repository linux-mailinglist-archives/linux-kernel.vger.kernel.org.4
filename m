Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D8472B288
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbjFKPrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjFKPra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:47:30 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98F5113D
        for <linux-kernel@vger.kernel.org>; Sun, 11 Jun 2023 08:47:25 -0700 (PDT)
Date:   Sun, 11 Jun 2023 15:47:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1686498443; x=1686757643;
        bh=y9BC09FC+aLMdCShoO0QsSLuTmOQtTkJuLlGOqMbhaI=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=juQfb6XQqeksTC+XxFH/VGlfGeWh0FjHxzZ8C9m8ydT4m0YIB8N8uo+Ae90BemlBm
         yUU77QgH5mgfFDAll+fE252lnSNASVfnaoANrQZF3F5JcHrDOE9DftG2KhpktzAQue
         geCjs9yCpyM/TyslZU++7RzhriXaZhtVCHUvTZ1KOlFOGFc0lxv4z/9tbhI2Eu9t0J
         xP5Wnny556DuY9Rr9ovKDXSkqxoNqaxdc56JIYrsJUTXzv9ShogZ514fWvKPtVC/BM
         2j45Xkwaad+9+dLOENEKRZbSPG7f0K4g92Wd5lyG+0CO2Z2B9eHlZvVcH2RdPjxol6
         o/AnW21ivp7Kg==
To:     Alice Ryhl <aliceryhl@google.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v2 2/8] rust: add offset_of! macro
Message-ID: <1tSKGQpv9YMkND4AD6xkmklwOysLXZpLWyHKRig89_8HbBhabheCU004aOkq1ixT1PpdN4SfGILlUaxwtU012ezdlZHmALZCEir0xtcifMc=@proton.me>
In-Reply-To: <20230601134946.3887870-3-aliceryhl@google.com>
References: <20230601134946.3887870-1-aliceryhl@google.com> <20230601134946.3887870-3-aliceryhl@google.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.06.23 15:49, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
>=20
> This macro is used to compute the offset of a field in a struct.
>=20
> This commit enables an unstable feature that is necessary for using
> the macro in a constant. However, this is not a problem as the macro
> will become available from the Rust standard library soon [1]. The
> unstable feature can be disabled again once that happens.
>=20
> The macro in this patch does not support sub-fields. That is, you cannot
> write `offset_of!(MyStruct, field.sub_field)` to get the offset of
> `sub_field` with `field`'s type being a struct with a field called
> `sub_field`. This is because `field` might be a `Box<SubStruct>`, which
> means that you would be trying to compute the offset to something in an
> entirely different allocation. There's no easy way to fix the current
> macro to support subfields, but the version being added to the standard
> library should support it, so the limitation is temporary and not a big
> deal.
>=20
> Link: https://github.com/rust-lang/rust/issues/106655 [1]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

--=20
Cheers,
Benno

> ---
>   rust/kernel/lib.rs     | 35 +++++++++++++++++++++++++++++++++++
>   scripts/Makefile.build |  2 +-
>   2 files changed, 36 insertions(+), 1 deletion(-)
>=20
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index eaded02ffb01..7ea777b731e6 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -14,6 +14,7 @@
>   #![no_std]
>   #![feature(allocator_api)]
>   #![feature(coerce_unsized)]
> +#![feature(const_refs_to_cell)]
>   #![feature(dispatch_from_dyn)]
>   #![feature(new_uninit)]
>   #![feature(receiver_trait)]
> @@ -98,3 +99,37 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>       // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/i=
ssues/2094>.
>       loop {}
>   }
> +
> +/// Calculates the offset of a field from the beginning of the struct it=
 belongs to.
> +///
> +/// # Examples
> +///
> +/// ```
> +/// #[repr(C)]
> +/// struct Test {
> +///     a: u64,
> +///     b: u32,
> +/// }
> +///
> +/// assert_eq!(kernel::offset_of!(Test, b), 8);
> +/// ```
> +#[macro_export]
> +macro_rules! offset_of {
> +    ($type:path, $field:ident) =3D> {{
> +        let $type { $field: _, .. };
> +        let tmp =3D ::core::mem::MaybeUninit::<$type>::uninit();
> +        let outer =3D tmp.as_ptr();
> +        // To avoid warnings when nesting `unsafe` blocks.
> +        #[allow(unused_unsafe)]
> +        // SAFETY: The pointer is valid and aligned, just not initialise=
d; `addr_of` ensures that
> +        // we don't actually read from `outer` (which would be UB) nor c=
reate an intermediate
> +        // reference.
> +        let inner =3D unsafe { ::core::ptr::addr_of!((*outer).$field) } =
as *const u8;
> +        // To avoid warnings when nesting `unsafe` blocks.
> +        #[allow(unused_unsafe)]
> +        // SAFETY: The two pointers are within the same allocation block=
.
> +        unsafe {
> +            inner.offset_from(outer as *const u8) as usize
> +        }
> +    }};
> +}
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 78175231c969..819510694769 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>   # Compile Rust sources (.rs)
>   # ---------------------------------------------------------------------=
------
>=20
> -rust_allowed_features :=3D new_uninit
> +rust_allowed_features :=3D const_refs_to_cell,new_uninit
>=20
>   rust_common_cmd =3D \
>   =09RUST_MODFILE=3D$(modfile) $(RUSTC_OR_CLIPPY) $(rust_flags) \
> --
> 2.41.0.rc0.172.g3f132b7071-goog
>=20

