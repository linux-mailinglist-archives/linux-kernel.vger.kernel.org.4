Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1698573CCC0
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 23:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229653AbjFXVPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 17:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjFXVPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 17:15:04 -0400
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338AA171A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 14:14:59 -0700 (PDT)
Date:   Sat, 24 Jun 2023 21:14:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687641297; x=1687900497;
        bh=aoe3KwxLysOwOT7903nCZgkzBRK8jEN40ti2Wl0T0nc=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=ifMSKZeW/oZyLlgZyE2HbdA3LNa/pSs3EX43kJs9SD15u1zoOTU2dB589IoilvzgE
         cRpeBZgyz43ev2wHd3JtWd0h41t68MP1HF3zw53jffGwx7MrpuphoaDUoJxcYNcN4F
         +3BsNHe//WOS5qAEv5oOqDk6PaDyVzlNsOhxprtSySXnZ2akueNSFQ0uvFyrFshsQT
         m4980/cgu5zIvi6vEjrckV6pm+CWLdE1I8rhZhy10z3j229UoCt0tlmc8XpqylsWCB
         GmlRz0Fwpru7BK/aTO6hx1mdWAerjEGU+xn+PWDv78Mw3yK0k0ZbB3kCGJz8QLIiaG
         Z89oq/Gz4AAFw==
To:     =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 5/7] rust: init: add `..Zeroable::zeroed()` syntax for zeroing all missing fields
Message-ID: <f4bcd952-1ad9-42b7-6e0b-72a115dcbe8e@proton.me>
In-Reply-To: <W1fY0aa_v9j7lJNWXk_WNaxY2qruJo1R6k7u0g-X5L5Rxuod-VMBMmByICDwjF_fFGvNJTV41QapW0WeVduNYqxgo9S243gnNGXbexq6P3Q=@protonmail.com>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-5-benno.lossin@proton.me> <W1fY0aa_v9j7lJNWXk_WNaxY2qruJo1R6k7u0g-X5L5Rxuod-VMBMmByICDwjF_fFGvNJTV41QapW0WeVduNYqxgo9S243gnNGXbexq6P3Q=@protonmail.com>
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

On 6/24/23 17:11, Bj=C3=B6rn Roy Baron wrote:
> On Saturday, June 24th, 2023 at 11:25, Benno Lossin <benno.lossin@proton.=
me> wrote:
>=20
>> Add the struct update syntax to the init macros, but only for
>> `..Zeroable::zeroed()`. Adding this at the end of the struct initializer
>> allows one to omit fields from the initializer, these fields will be
>> initialized with 0x00 set to every byte. Only types that implement the
>> `Zeroable` trait can utilize this.
>>
>> Suggested-by: Asahi Lina <lina@asahilina.net>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>>   rust/kernel/init.rs        |  16 +++++-
>>   rust/kernel/init/macros.rs | 114 ++++++++++++++++++++++++++++++++++++-
>>   2 files changed, 128 insertions(+), 2 deletions(-)
>>
>> diff --git a/rust/kernel/init.rs b/rust/kernel/init.rs
>> index ecf6a4bd0ce4..44bc3e77419a 100644
>> --- a/rust/kernel/init.rs
>> +++ b/rust/kernel/init.rs
>> @@ -508,14 +508,18 @@ macro_rules! stack_try_pin_init {
>>   /// - Fields that you want to initialize in-place have to use `<-` ins=
tead of `:`.
>>   /// - In front of the initializer you can write `&this in` to have acc=
ess to a [`NonNull<Self>`]
>>   ///   pointer named `this` inside of the initializer.
>> +/// - Using struct update syntax one can place `..Zeroable::zeroed()` a=
t the very end of the
>> +///   struct, this initializes every field with 0 and then runs all ini=
tializers specified in the
>> +///   body. This can only be done if [`Zeroable`] is implemented for th=
e struct.
>>   ///
>>   /// For instance:
>>   ///
>>   /// ```rust
>>   /// # use kernel::pin_init;
>> -/// # use macros::pin_data;
>> +/// # use macros::{pin_data, Zeroable};
>>   /// # use core::{ptr::addr_of_mut, marker::PhantomPinned};
>>   /// #[pin_data]
>> +/// #[derive(Zeroable)]
>>   /// struct Buf {
>>   ///     // `ptr` points into `buf`.
>>   ///     ptr: *mut u8,
>> @@ -528,6 +532,10 @@ macro_rules! stack_try_pin_init {
>>   ///     ptr: unsafe { addr_of_mut!((*this.as_ptr()).buf).cast() },
>>   ///     pin: PhantomPinned,
>>   /// });
>> +/// pin_init!(Buf {
>> +///     buf: [1; 64],
>> +///     ..Zeroable::zeroed(),
>> +/// });
>>   /// ```
>>   ///
>>   /// [`try_pin_init!`]: kernel::try_pin_init
>> @@ -547,6 +555,7 @@ macro_rules! pin_init {
>>               @data(PinData, use_data),
>>               @has_data(HasPinData, __pin_data),
>>               @construct_closure(pin_init_from_closure),
>> +            @munch_fields($($fields)*),
>>           )
>>       };
>>   }
>> @@ -603,6 +612,7 @@ macro_rules! try_pin_init {
>>               @data(PinData, use_data),
>>               @has_data(HasPinData, __pin_data),
>>               @construct_closure(pin_init_from_closure),
>> +            @munch_fields($($fields)*),
>>           )
>>       };
>>       ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
>> @@ -616,6 +626,7 @@ macro_rules! try_pin_init {
>>               @data(PinData, use_data),
>>               @has_data(HasPinData, __pin_data),
>>               @construct_closure(pin_init_from_closure),
>> +            @munch_fields($($fields)*),
>>           )
>>       };
>>   }
>> @@ -650,6 +661,7 @@ macro_rules! init {
>>               @data(InitData, /*no use_data*/),
>>               @has_data(HasInitData, __init_data),
>>               @construct_closure(init_from_closure),
>> +            @munch_fields($($fields)*),
>>           )
>>       }
>>   }
>> @@ -700,6 +712,7 @@ macro_rules! try_init {
>>               @data(InitData, /*no use_data*/),
>>               @has_data(HasInitData, __init_data),
>>               @construct_closure(init_from_closure),
>> +            @munch_fields($($fields)*),
>>           )
>>       };
>>       ($(&$this:ident in)? $t:ident $(::<$($generics:ty),* $(,)?>)? {
>> @@ -713,6 +726,7 @@ macro_rules! try_init {
>>               @data(InitData, /*no use_data*/),
>>               @has_data(HasInitData, __init_data),
>>               @construct_closure(init_from_closure),
>> +            @munch_fields($($fields)*),
>>           )
>>       };
>>   }
>> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
>> index 1e0c4aca055a..5dcb2e513f26 100644
>> --- a/rust/kernel/init/macros.rs
>> +++ b/rust/kernel/init/macros.rs
>> @@ -989,6 +989,7 @@ impl<$($impl_generics)*> $pin_data<$($ty_generics)*>
>>   ///
>>   /// This macro has multiple internal call configurations, these are al=
ways the very first ident:
>>   /// - nothing: this is the base case and called by the `{try_}{pin_}in=
it!` macros.
>> +/// - `with_update_parsed`: when the `..Zeroable::zeroed()` syntax has =
been handled.
>>   /// - `init_slot`: recursively creates the code that initializes all f=
ields in `slot`.
>>   /// - `make_initializer`: recursively create the struct initializer th=
at guarantees that every
>>   ///   field has been initialized exactly once.
>> @@ -1007,6 +1008,82 @@ macro_rules! __init_internal {
>>           @has_data($has_data:ident, $get_data:ident),
>>           // `pin_init_from_closure` or `init_from_closure`.
>>           @construct_closure($construct_closure:ident),
>> +        @munch_fields(),
>> +    ) =3D> {
>> +        $crate::__init_internal!(with_update_parsed:
>> +            @this($($this)?),
>> +            @typ($t $(::<$($generics),*>)? ),
>> +            @fields($($fields)*),
>> +            @error($err),
>> +            @data($data, $($use_data)?),
>> +            @has_data($has_data, $get_data),
>> +            @construct_closure($construct_closure),
>> +            @zeroed(), // nothing means default behavior.
>> +        )
>> +    };
>> +    (
>> +        @this($($this:ident)?),
>> +        @typ($t:ident $(::<$($generics:ty),*>)?),
>> +        @fields($($fields:tt)*),
>> +        @error($err:ty),
>> +        // Either `PinData` or `InitData`, `$use_data` should only be p=
resent in the `PinData`
>> +        // case.
>> +        @data($data:ident, $($use_data:ident)?),
>> +        // `HasPinData` or `HasInitData`.
>> +        @has_data($has_data:ident, $get_data:ident),
>> +        // `pin_init_from_closure` or `init_from_closure`.
>> +        @construct_closure($construct_closure:ident),
>> +        @munch_fields(..Zeroable::zeroed()),
>> +    ) =3D> {
>> +        $crate::__init_internal!(with_update_parsed:
>> +            @this($($this)?),
>> +            @typ($t $(::<$($generics),*>)? ),
>> +            @fields($($fields)*),
>> +            @error($err),
>> +            @data($data, $($use_data)?),
>> +            @has_data($has_data, $get_data),
>> +            @construct_closure($construct_closure),
>> +            @zeroed(()), // `()` means zero all fields not mentioned.
>> +        )
>> +    };
>> +    (
>> +        @this($($this:ident)?),
>> +        @typ($t:ident $(::<$($generics:ty),*>)?),
>> +        @fields($($fields:tt)*),
>> +        @error($err:ty),
>> +        // Either `PinData` or `InitData`, `$use_data` should only be p=
resent in the `PinData`
>> +        // case.
>> +        @data($data:ident, $($use_data:ident)?),
>> +        // `HasPinData` or `HasInitData`.
>> +        @has_data($has_data:ident, $get_data:ident),
>> +        // `pin_init_from_closure` or `init_from_closure`.
>> +        @construct_closure($construct_closure:ident),
>> +        @munch_fields($ignore:tt $($rest:tt)*),
>> +    ) =3D> {
>> +        $crate::__init_internal!(
>> +            @this($($this)?),
>> +            @typ($t $(::<$($generics),*>)? ),
>> +            @fields($($fields)*),
>> +            @error($err),
>> +            @data($data, $($use_data)?),
>> +            @has_data($has_data, $get_data),
>> +            @construct_closure($construct_closure),
>> +            @munch_fields($($rest)*),
>> +        )
>> +    };
>> +    (with_update_parsed:
>> +        @this($($this:ident)?),
>> +        @typ($t:ident $(::<$($generics:ty),*>)?),
>> +        @fields($($fields:tt)*),
>> +        @error($err:ty),
>> +        // Either `PinData` or `InitData`, `$use_data` should only be p=
resent in the `PinData`
>> +        // case.
>> +        @data($data:ident, $($use_data:ident)?),
>> +        // `HasPinData` or `HasInitData`.
>> +        @has_data($has_data:ident, $get_data:ident),
>> +        // `pin_init_from_closure` or `init_from_closure`.
>> +        @construct_closure($construct_closure:ident),
>> +        @zeroed($($init_zeroed:expr)?),
>>       ) =3D> {{
>>           // We do not want to allow arbitrary returns, so we declare th=
is type as the `Ok` return
>>           // type and shadow it later when we insert the arbitrary user =
code. That way there will be
>> @@ -1024,6 +1101,17 @@ macro_rules! __init_internal {
>>                   {
>>                       // Shadow the structure so it cannot be used to re=
turn early.
>>                       struct __InitOk;
>> +                    // If `$init_zeroed` is present we should zero the =
slot now and not emit an
>> +                    // error when fields are missing (since they will b=
e zeroed). We also have to
>> +                    // check that the type actually implements `Zeroabl=
e`.
>> +                    $(
>> +                        fn is_zeroable<T: Zeroable>(ptr: *mut T) {}
>=20
> Maybe call this assert_zeroable?

Sure.

>=20
>> +                        // Ensure that the struct is indeed `Zeroable`.
>> +                        is_zeroable(slot);
>> +                        // SAFETY:  The type implements `Zeroable` by t=
he check above.
>> +                        unsafe { ::core::ptr::write_bytes(slot, 0, 1) }=
;
>> +                        $init_zeroed // this will be `()` if set.
>=20
> How does this work? Shouldn't there be a ; after $init_zeroed to consume =
the () value?

It is the last expression of a block and since it is `()` it is ok=20
(adding a ; would also be ok, but it is not necessary).

>=20
>> +                    )?
>>                       // Create the `this` so it can be referenced by th=
e user inside of the
>>                       // expressions creating the individual fields.
>>                       $(let $this =3D unsafe { ::core::ptr::NonNull::new=
_unchecked(slot) };)?
>> @@ -1064,7 +1152,7 @@ macro_rules! __init_internal {
>>           @data($data:ident),
>>           @slot($slot:ident),
>>           @guards($($guards:ident,)*),
>> -        @munch_fields($(,)?),
>> +        @munch_fields($(..Zeroable::zeroed())? $(,)?),
>>       ) =3D> {
>>           // Endpoint of munching, no fields are left. If execution reac=
hes this point, all fields
>>           // have been initialized. Therefore we can now dismiss the gua=
rds by forgetting them.
>> @@ -1157,6 +1245,30 @@ macro_rules! __init_internal {
>>               @munch_fields($($rest)*),
>>           );
>>       };
>> +    (make_initializer:
>> +        @slot($slot:ident),
>> +        @type_name($t:ident),
>> +        @munch_fields(..Zeroable::zeroed() $(,)?),
>> +        @acc($($acc:tt)*),
>> +    ) =3D> {
>> +        // Endpoint, nothing more to munch, create the initializer. Sin=
ce the users specified
>> +        // `..Zeroable::zeroed()`, the slot will already have been zero=
ed and all field that have
>> +        // not been overwritten are thus zero and initialized. We still=
 check that all fields are
>> +        // actually accessible by using the struct update syntax oursel=
ves.
>> +        // Since we are in the `if false` branch, this will never get e=
xecuted. We abuse `slot` to
>> +        // get the correct type inference here:
>> +        unsafe {
>> +            let mut zeroed =3D ::core::mem::zeroed();
>> +            // We have to use type inference her to make zeroed have th=
e correct type. This does
>=20
> *here

Will fix.

--=20
Cheers,
Benno

>=20
>> +            // not get executed, so it has no effect.
>> +            ::core::ptr::write($slot, zeroed);
>> +            zeroed =3D ::core::mem::zeroed();
>> +            ::core::ptr::write($slot, $t {
>> +                $($acc)*
>> +                ..zeroed
>> +            });
>> +        }
>> +    };
>>       (make_initializer:
>>           @slot($slot:ident),
>>           @type_name($t:ident),
>> --
>> 2.41.0
>=20
> Cheers,
> Bj=C3=B6rn



