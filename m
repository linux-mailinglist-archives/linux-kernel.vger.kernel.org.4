Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6E6C7158DB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjE3IlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbjE3Ik4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:40:56 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81BA110
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:40:29 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5147e441c33so7536945a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1685436024; x=1688028024;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7ZICuGD24BHTlM9NFi98k1RFcbodRQfaJIvts7Xvgc=;
        b=O4fD9DpGUdiXimkO57drFr6WhbVdE75RO7GotNlwURwFNYPS1X0JbKtl0C4egKABAf
         EaLlT+MJoIdzJUmxVIrnqUuWrRn2A/3TaypAOtark2tMmZs73Gpl3WelhHWdhU8ul4mm
         rlovrkr+Dtsd9JBq8cC6ux11cb2OQd4TCvRatinFu7W/gYMnnAQON8fIKu8HlGFCXYX2
         WRWUtSYeGUOJQc7dpIHhwK/ZJPvJVtt2sJwM/ETOuAWhMKTkxW0vRX5Z5JIwyHamiOdq
         D3BO4svXObz+8Gwr4X/DaH8zoilSYWx/IcmT1jz/u2NvSO/H0crEgW4Lf4BmevHTlNXU
         q12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685436024; x=1688028024;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
         :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F7ZICuGD24BHTlM9NFi98k1RFcbodRQfaJIvts7Xvgc=;
        b=kXfk7DZWfiNx3E3zGBu5pdA5aWq13NWJXgI9ETle9JkdwTARfbKg0yROJ3B0s9ZLCh
         B7WtakK+98d4ArWiCE0vBYgDR4Ukr7+MB+wExovRXGV4C0XiF6Pzef1DZnPx0dFklQfA
         8sDeLM/pbufFDG+skHmwx2xZjcQjPF1MgvfFcCDgbTonSHNfiWjZXDaINn12GYjDpmes
         yiOoVnt844dTXhu5Nx4by6hDDNBblV5HcoZclR0mYfhKvbLRuUlkmjTZ2yB54wK1TvLP
         oGbU1E0C2+OMQRtm8FMSaGnjOVavPYw1TXcxH6Uj65rvvbnoOMRPR8CZABn42+Bsdq5W
         MLVw==
X-Gm-Message-State: AC+VfDxazNwfTy6dPjt8qvcqL7xGVl7H9T8Qyb11NjCef1S1IpOx7Ax4
        vb7BS0h8Fp+Arfwh8EEPt7y5Fg==
X-Google-Smtp-Source: ACHHUZ6EmMLH+rqeEWeBT+5Eqvo49AHeEmOvJzXLrWc5CVA3fSqrI+dBSd2w9/YJ9Vytzkq6DXrvtQ==
X-Received: by 2002:aa7:d3c4:0:b0:514:a6a6:facb with SMTP id o4-20020aa7d3c4000000b00514a6a6facbmr1798132edr.13.1685436023709;
        Tue, 30 May 2023 01:40:23 -0700 (PDT)
Received: from localhost ([194.62.217.2])
        by smtp.gmail.com with ESMTPSA id b13-20020a056402138d00b0050690bc07a3sm4169381edv.18.2023.05.30.01.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 01:40:23 -0700 (PDT)
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-3-aliceryhl@google.com>
 <20230523164818.0a44fec8.gary@garyguo.net>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Gary Guo <gary@garyguo.net>
Cc:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Subject: Re: [PATCH v1 2/7] rust: add offset_of! macro
Date:   Tue, 30 May 2023 10:40:03 +0200
In-reply-to: <20230523164818.0a44fec8.gary@garyguo.net>
Message-ID: <87pm6i9pqh.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Gary Guo <gary@garyguo.net> writes:

> On Wed, 17 May 2023 20:31:14 +0000
> Alice Ryhl <aliceryhl@google.com> wrote:
>
>> From: Wedson Almeida Filho <walmeida@microsoft.com>
>>=20
>> This macro is used to compute the offset of a field in a struct.
>>=20
>> This commit enables two unstable features that are necessary for using
>> the macro in a constant. However, this is not a problem as the macro
>> will become available from the Rust standard library soon [1]. The
>> unstable features can be disabled again once that happens.
>>=20
>> The macro in this patch does not support sub-fields. That is, you cannot
>> write `offset_of!(MyStruct, field.sub_field)` to get the offset of
>> `sub_field` with `field`'s type being a struct with a field called
>> `sub_field`. This is because `field` might be a `Box<SubStruct>`, which
>> means that you would be trying to compute the offset to something in an
>> entirely different allocation. There's no easy way to fix the current
>> macro to support subfields, but the version being added to the standard
>> library should support it, so the limitation is temporary and not a big
>> deal.
>>=20
>> Link: https://github.com/rust-lang/rust/issues/106655 [1]
>> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
>> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
>> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
>> ---
>>  rust/kernel/lib.rs     | 35 +++++++++++++++++++++++++++++++++++
>>  scripts/Makefile.build |  2 +-
>>  2 files changed, 36 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
>> index c718524056a6..cdf9fe999328 100644
>> --- a/rust/kernel/lib.rs
>> +++ b/rust/kernel/lib.rs
>> @@ -14,6 +14,8 @@
>>  #![no_std]
>>  #![feature(allocator_api)]
>>  #![feature(coerce_unsized)]
>> +#![feature(const_ptr_offset_from)]
>> +#![feature(const_refs_to_cell)]
>>  #![feature(core_ffi_c)]
>>  #![feature(dispatch_from_dyn)]
>>  #![feature(explicit_generic_args_with_impl_trait)]
>> @@ -102,3 +104,36 @@ fn panic(info: &core::panic::PanicInfo<'_>) -> ! {
>>      // instead of `!`. See <https://github.com/rust-lang/rust-bindgen/i=
ssues/2094>.
>>      loop {}
>>  }
>> +
>> +/// Calculates the offset of a field from the beginning of the struct i=
t belongs to.
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// #[repr(C)]
>> +/// struct Test {
>> +///     a: u64,
>> +///     b: u32,
>> +/// }
>> +///
>> +/// assert_eq!(kernel::offset_of!(Test, b), 8);
>> +/// ```
>> +#[macro_export]
>> +macro_rules! offset_of {
>> +    ($type:ty, $field:ident) =3D> {{
>> +        let tmp =3D ::core::mem::MaybeUninit::<$type>::uninit();
>> +        let outer =3D tmp.as_ptr();
>> +        // To avoid warnings when nesting `unsafe` blocks.
>> +        #[allow(unused_unsafe)]
>> +        // SAFETY: The pointer is valid and aligned, just not initialis=
ed; `addr_of` ensures that
>> +        // we don't actually read from `outer` (which would be UB) nor =
create an intermediate
>> +        // reference.
>> +        let inner =3D unsafe { ::core::ptr::addr_of!((*outer).$field) }=
 as *const u8;
>> +        // To avoid warnings when nesting `unsafe` blocks.
>> +        #[allow(unused_unsafe)]
>> +        // SAFETY: The two pointers are within the same allocation bloc=
k.
>> +        unsafe {
>> +            inner.offset_from(outer as *const u8) as usize
>> +        }
>
> This has no protection against using `Deref`. The memoffset crate has a=20
>
> let $type { $field: _, .. };
>
> line to ensure that the field is a direct member of type and deref is
> not happening.

Good catch =F0=9F=91=8D

>
>> +    }};
>> +}
>> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
>> index 9f94fc83f086..ec583d13dde2 100644
>> --- a/scripts/Makefile.build
>> +++ b/scripts/Makefile.build
>> @@ -277,7 +277,7 @@ $(obj)/%.lst: $(src)/%.c FORCE
>>  # Compile Rust sources (.rs)
>>  # ---------------------------------------------------------------------=
------
>>=20=20
>> -rust_allowed_features :=3D core_ffi_c,explicit_generic_args_with_impl_t=
rait,new_uninit,pin_macro
>> +rust_allowed_features :=3D const_ptr_offset_from,const_refs_to_cell,cor=
e_ffi_c,explicit_generic_args_with_impl_trait,new_uninit,pin_macro
>
> Side note: once we bump our compiler to 1.71, we should switch to the
> built-in `offset_of!` macro and get rid of these unstable features.
>
> Best,
> Gary

