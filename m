Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15E4B73CB7F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 16:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbjFXO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230116AbjFXO7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 10:59:00 -0400
Received: from mail-0301.mail-europe.com (mail-0301.mail-europe.com [188.165.51.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB7F1B4
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 07:58:59 -0700 (PDT)
Date:   Sat, 24 Jun 2023 14:58:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1687618734; x=1687877934;
        bh=PGrRg8/LesaPKKANzQnFHjiA3Roa28wYAQr/ty0Oxv0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Z00Av2p9BVo2ONknTbvNUUaLKcap3c75jTieiUM6I/ztToIqLInzdQXOqEVPC40lI
         TN2P9I1qs+IC+T0thp+i0TQfS0Sq/DFX6E284xWT9HaqBA7UlZ4er4Hv46kIPxRDM2
         uwyMIZPSErZYLQxQkADQ6nqAsK1SH+dPXFeXDHOztihR12KyQKKzah5RgQDYSNAEiU
         v4d1KD2xSVIRedNHbXXzy2+5pBG9IeP/IZXrCw9S6lcOUyiT9LO2CAtgu1+w1MMQCl
         1JgIPZ5ji68SoB+UrdVfCN5785wVu07mMAKAb+OTTeD9c4Nwzb/aJfQljruQXSzoGf
         xd1h737Yg2l5A==
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
Subject: Re: [PATCH 3/7] rust: init: make guards in the init macros hygienic
Message-ID: <U0tuqEm3_89s8FWU9JE8TeHN9vg24GUOGjQgM2n7xREBJAFkRctJAIxoujeYo6vh4m4XxC6COyGwain_6D1D3zoLa3W6njwSIuQDCGIsE1U=@protonmail.com>
In-Reply-To: <20230624092330.157338-3-benno.lossin@proton.me>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-3-benno.lossin@proton.me>
Feedback-ID: 27884398:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 24th, 2023 at 11:25, Benno Lossin <benno.lossin@proton.me=
> wrote:

> Use hygienic identifiers for the guards instead of the field names. This
> makes the init macros feel more like normal struct initializers, since
> assigning identifiers with the name of a field does not create
> conflicts.
> Also change the internals of the guards, no need to make the `forget`
> function `unsafe`, since users cannot access the guards anyways. Now the
> guards are carried directly on the stack and have no extra `Cell<bool>`
> field that marks if they have been forgotten or not, instead they are
> just forgotten via `mem::forget`.
>=20
> Suggested-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Benno Lossin <benno.lossin@proton.me>

Reviewed-by: Bj=C3=B6rn Roy Baron <bjorn3_gh@protonmail.com>

> ---
>  rust/kernel/init.rs            |  1 -
>  rust/kernel/init/__internal.rs | 25 +++------------
>  rust/kernel/init/macros.rs     | 56 ++++++++++++----------------------
>  3 files changed, 23 insertions(+), 59 deletions(-)
>=20
> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
> index d9a91950cba2..ecf6a4bd0ce4 100644
> --- a/rust/kernel/init.rs
> +++ b/rust/kernel/init.rs
> @@ -206,7 +206,6 @@
>  use alloc::boxed::Box;
>  use core::{
>      alloc::AllocError,
> -    cell::Cell,
>      convert::Infallible,
>      marker::PhantomData,
>      mem::MaybeUninit,
> diff --git a/rust/kernel/init/__internal.rs b/rust/kernel/init/__internal=
.rs
> index 44751fb62b51..7abd1fb65e41 100644
> --- a/rust/kernel/init/__internal.rs
> +++ b/rust/kernel/init/__internal.rs
> @@ -174,7 +174,6 @@ pub fn init<E>(self: Pin<&mut Self>, init: impl PinIn=
it<T, E>) -> Result<Pin<&mu
>  /// Can be forgotten to prevent the drop.
>  pub struct DropGuard<T: ?Sized> {
>      ptr: *mut T,
> -    do_drop: Cell<bool>,
>  }
>=20
>  impl<T: ?Sized> DropGuard<T> {
> @@ -190,32 +189,16 @@ impl<T: ?Sized> DropGuard<T> {
>      /// - will not be dropped by any other means.
>      #[inline]
>      pub unsafe fn new(ptr: *mut T) -> Self {
> -        Self {
> -            ptr,
> -            do_drop: Cell::new(true),
> -        }
> -    }
> -
> -    /// Prevents this guard from dropping the supplied pointer.
> -    ///
> -    /// # Safety
> -    ///
> -    /// This function is unsafe in order to prevent safe code from forge=
tting this guard. It should
> -    /// only be called by the macros in this module.
> -    #[inline]
> -    pub unsafe fn forget(&self) {
> -        self.do_drop.set(false);
> +        Self { ptr }
>      }
>  }
>=20
>  impl<T: ?Sized> Drop for DropGuard<T> {
>      #[inline]
>      fn drop(&mut self) {
> -        if self.do_drop.get() {
> -            // SAFETY: A `DropGuard` can only be constructed using the u=
nsafe `new` function
> -            // ensuring that this operation is safe.
> -            unsafe { ptr::drop_in_place(self.ptr) }
> -        }
> +        // SAFETY: A `DropGuard` can only be constructed using the unsaf=
e `new` function
> +        // ensuring that this operation is safe.
> +        unsafe { ptr::drop_in_place(self.ptr) }
>      }
>  }
>=20
> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
> index e8165ff53a94..df4281743175 100644
> --- a/rust/kernel/init/macros.rs
> +++ b/rust/kernel/init/macros.rs
> @@ -992,7 +992,6 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>  /// - `init_slot`: recursively creates the code that initializes all fie=
lds in `slot`.
>  /// - `make_initializer`: recursively create the struct initializer that=
 guarantees that every
>  ///   field has been initialized exactly once.
> -/// - `forget_guards`: recursively forget the drop guards for every fiel=
d.
>  #[doc(hidden)]
>  #[macro_export]
>  macro_rules! __init_internal {
> @@ -1032,6 +1031,7 @@ macro_rules! __init_internal {
>                      $crate::__init_internal!(init_slot($($use_data)?):
>                          @data(data),
>                          @slot(slot),
> +                        @guards(),
>                          @munch_fields($($fields)*,),
>                      );
>                      // We use unreachable code to ensure that all fields=
 have been mentioned exactly
> @@ -1046,10 +1046,6 @@ macro_rules! __init_internal {
>                              @acc(),
>                          );
>                      }
> -                    // Forget all guards, since initialization was a suc=
cess.
> -                    $crate::__init_internal!(forget_guards:
> -                        @munch_fields($($fields)*,),
> -                    );
>                  }
>                  Ok(__InitOk)
>              }
> @@ -1063,13 +1059,17 @@ macro_rules! __init_internal {
>      (init_slot($($use_data:ident)?):
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          @munch_fields($(,)?),
>      ) =3D> {
> -        // Endpoint of munching, no fields are left.
> +        // Endpoint of munching, no fields are left. If execution reache=
s this point, all fields
> +        // have been initialized. Therefore we can now dismiss the guard=
s by forgetting them.
> +        $(::core::mem::forget($guards);)*
>      };
>      (init_slot($use_data:ident): // use_data is present, so we use the `=
data` to init fields.
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // In-place initialization syntax.
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>      ) =3D> {
> @@ -1080,24 +1080,26 @@ macro_rules! __init_internal {
>          // return when an error/panic occurs.
>          // We also use the `data` to require the correct trait (`Init` o=
r `PinInit`) for `$field`.
>          unsafe { $data.$field(::core::ptr::addr_of_mut!((*$slot).$field)=
, $field)? };
> -        // Create the drop guard.
> +        // Create the drop guard:
>          //
> -        // We only give access to `&DropGuard`, so it cannot be forgotte=
n via safe code.
> +        // We rely on macro hygiene to make it impossible for users to a=
ccess this local variable.
>          //
>          // SAFETY: We forget the guard later when initialization has suc=
ceeded.
> -        let $field =3D &unsafe {
> +        let guard =3D unsafe {
>              $crate::init::__internal::DropGuard::new(::core::ptr::addr_o=
f_mut!((*$slot).$field))
>          };
>=20
>          $crate::__init_internal!(init_slot($use_data):
>              @data($data),
>              @slot($slot),
> +            @guards(guard, $($guards,)*),
>              @munch_fields($($rest)*),
>          );
>      };
>      (init_slot(): // no use_data, so we use `Init::__init` directly.
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // In-place initialization syntax.
>          @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
>      ) =3D> {
> @@ -1107,24 +1109,26 @@ macro_rules! __init_internal {
>          // SAFETY: `slot` is valid, because we are inside of an initiali=
zer closure, we
>          // return when an error/panic occurs.
>          unsafe { $crate::init::Init::__init($field, ::core::ptr::addr_of=
_mut!((*$slot).$field))? };
> -        // Create the drop guard.
> +        // Create the drop guard:
>          //
> -        // We only give access to `&DropGuard`, so it cannot be forgotte=
n via safe code.
> +        // We rely on macro hygiene to make it impossible for users to a=
ccess this local variable.
>          //
>          // SAFETY: We forget the guard later when initialization has suc=
ceeded.
> -        let $field =3D &unsafe {
> +        let guard =3D unsafe {
>              $crate::init::__internal::DropGuard::new(::core::ptr::addr_o=
f_mut!((*$slot).$field))
>          };
>=20
>          $crate::__init_internal!(init_slot():
>              @data($data),
>              @slot($slot),
> +            @guards(guard, $($guards,)*),
>              @munch_fields($($rest)*),
>          );
>      };
>      (init_slot($($use_data:ident)?):
>          @data($data:ident),
>          @slot($slot:ident),
> +        @guards($($guards:ident,)*),
>          // Init by-value.
>          @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
>      ) =3D> {
> @@ -1135,16 +1139,17 @@ macro_rules! __init_internal {
>          unsafe { ::core::ptr::write(::core::ptr::addr_of_mut!((*$slot).$=
field), $field) };
>          // Create the drop guard:
>          //
> -        // We only give access to `&DropGuard`, so it cannot be accident=
ally forgotten.
> +        // We rely on macro hygiene to make it impossible for users to a=
ccess this local variable.
>          //
>          // SAFETY: We forget the guard later when initialization has suc=
ceeded.
> -        let $field =3D &unsafe {
> +        let guard =3D unsafe {
>              $crate::init::__internal::DropGuard::new(::core::ptr::addr_o=
f_mut!((*$slot).$field))
>          };
>=20
>          $crate::__init_internal!(init_slot($($use_data)?):
>              @data($data),
>              @slot($slot),
> +            @guards(guard, $($guards,)*),
>              @munch_fields($($rest)*),
>          );
>      };
> @@ -1189,29 +1194,6 @@ macro_rules! __init_internal {
>              @acc($($acc)* $field: ::core::panic!(),),
>          );
>      };
> -    (forget_guards:
> -        @munch_fields($(,)?),
> -    ) =3D> {
> -        // Munching finished.
> -    };
> -    (forget_guards:
> -        @munch_fields($field:ident <- $val:expr, $($rest:tt)*),
> -    ) =3D> {
> -        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> -
> -        $crate::__init_internal!(forget_guards:
> -            @munch_fields($($rest)*),
> -        );
> -    };
> -    (forget_guards:
> -        @munch_fields($field:ident $(: $val:expr)?, $($rest:tt)*),
> -    ) =3D> {
> -        unsafe { $crate::init::__internal::DropGuard::forget($field) };
> -
> -        $crate::__init_internal!(forget_guards:
> -            @munch_fields($($rest)*),
> -        );
> -    };
>  }
>=20
>  #[doc(hidden)]
> --
> 2.41.0
