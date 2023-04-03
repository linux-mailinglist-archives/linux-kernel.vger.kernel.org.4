Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8159D6D5309
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 23:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbjDCVHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjDCVHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 17:07:14 -0400
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339191BD0;
        Mon,  3 Apr 2023 14:07:13 -0700 (PDT)
Date:   Mon, 03 Apr 2023 21:06:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=protonmail3; t=1680556031; x=1680815231;
        bh=Ygcel1PvnMoe3RHJ38UCoAZrKYRkopyr0hOnUB7vewE=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=w18BWd4XymeKr9glYoZHqwLcVivawa55JNf6WPwPjen8au9DMMLMFxeTf5Al4zBrh
         RXxIpXDggEITn+Ct6No4+78+Us2apw0H7dktahZBnH+FbuyKREJd4K80uK/TpsR/dN
         Ef/781PugEn0S9xCc51NAU1EyKk7fmWnJ5vEUkJlc/PEDa1LwCDnpC1J63WXNDRqxI
         fRsv3JILSveZbz9O8vsssDuEkGd/Hp6mJve3BT2H3Myx55igXzk/kIeGEMAHYekuBM
         GmHIsP4oBA6Bfu4m/0JvFEpDP7WrAKcvcQzhEzsbpfTa10UxYMlQ21Z5YajijuCJFM
         j6BfubfY0nIrA==
To:     Alice Ryhl <alice@ryhl.io>
From:   y86-dev <y86-dev@protonmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH v5 14/15] rust: sync: reduce stack usage of `UniqueArc::try_new_uninit`
Message-ID: <IPLyc9BujE_3VnXZSkge4KAkU2UP7JQGWIOlhWq4Dfli3k_M5luHYkPrxH5ig1E3G_iTKkaSJuzsXCdSx6e3AC4iLYlVqNULFvBr4VYR2MQ=@protonmail.com>
In-Reply-To: <d50b28f0-e989-7392-505b-2dd9f00abef6@ryhl.io>
References: <20230403154422.168633-1-y86-dev@protonmail.com> <20230403160511.174894-7-y86-dev@protonmail.com> <d50b28f0-e989-7392-505b-2dd9f00abef6@ryhl.io>
Feedback-ID: 40624463:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03.04.23 19:56, Alice Ryhl wrote:
> On 4/3/23 18:05, Benno Lossin wrote:
>>        /// Tries to allocate a new [`UniqueArc`] instance whose contents=
 are not initialised yet.
>>        pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, Allo=
cError> {
>> -        Ok(UniqueArc::<MaybeUninit<T>> {
>> +        // INVARIANT: The refcount is initialised to a non-zero value.
>> +        let inner =3D Box::try_init::<AllocError>(try_init!(ArcInner {
>> +            // SAFETY: There are no safety requirements for this FFI ca=
ll.
>> +            refcount: Opaque::new(unsafe { bindings::REFCOUNT_INIT(1) }=
),
>> +            data <- init::uninit::<T, AllocError>(),
>> +        }? AllocError))?;
>> +        Ok(UniqueArc {
>>                // INVARIANT: The newly-created object has a ref-count of=
 1.
>> -            inner: Arc::try_new(MaybeUninit::uninit())?,
>> +            // SAFETY: The pointer from the `Box` is valid.
>> +            inner: unsafe { Arc::from_inner(Box::leak(inner).into()) },
>>            })
>>        }
>>    }
>=20
> I'm curious - do you know whether this compiles to the same machine code
> as this?
>=20
> pub fn try_new_uninit() -> Result<UniqueArc<MaybeUninit<T>>, AllocError> =
{
>       let inner: Box<MaybeUninit<ArcInner<T>>> =3D Box::try_new_uninit()?=
;
>       let ptr =3D Box::into_raw(inner) as *mut ArcInner<T>;
>       addr_of_mut!((*ptr).refcount).write(bindings::REFCOUNT_INIT(1));
>       Ok(UniqueArc {
>           inner: Arc {
>               ptr: unsafe { NonNull::new_unchecked(ptr) },
>               _p: PhantomData,
>           }
>       })
> }

Yes it compiles to exactly the same assembly (byte for byte), because I was
not sure if I was compiling the right thing, I compiled this function:

    unsafe { core::arch::asm!("ud2") };
    let r1 =3D UniqueArc::try_new_uninit();
    unsafe { core::arch::asm!("ud2") };
    let r2 =3D UniqueArc::try_new_uninit2();
    unsafe { core::arch::asm!("ud2") };

The `ud2` instructions are for better visibility, as I have not read a lot
of assembly. The above disassembles to this:

    ffffffff8143bb80 <_RNvXCsdVu6umiBwhr_12rust_minimalNtB2_11RustMinimalNt=
CsfATHBUcknU9_6kernel6Module4init>:
    ffffffff8143bb80:=0941 57                =09push   r15
    ffffffff8143bb82:=0941 56                =09push   r14
    ffffffff8143bb84:=0953                   =09push   rbx
    ffffffff8143bb85:=0949 89 ff             =09mov    r15,rdi
    ffffffff8143bb88:=090f 0b                =09ud2
    ffffffff8143bb8a:=09bf 04 00 10 00       =09mov    edi,0x100004
    ffffffff8143bb8f:=09be 04 00 00 00       =09mov    esi,0x4
    ffffffff8143bb94:=09e8 a7 23 f5 ff       =09call   ffffffff8138df40 <__=
rust_alloc>
    ffffffff8143bb99:=0948 85 c0             =09test   rax,rax
    ffffffff8143bb9c:=0974 12                =09je     ffffffff8143bbb0 <_R=
NvXCsdVu6umiBwhr_12rust_minimalNtB2_11RustMinimalNtCsfATHBUcknU9_6kernel6Mo=
dule4init+0x30>
    ffffffff8143bb9e:=0949 89 c6             =09mov    r14,rax
    ffffffff8143bba1:=09bf 01 00 00 00       =09mov    edi,0x1
    ffffffff8143bba6:=09e8 e5 fc f4 ff       =09call   ffffffff8138b890 <ru=
st_helper_REFCOUNT_INIT>
    ffffffff8143bbab:=0941 89 06             =09mov    DWORD PTR [r14],eax
    ffffffff8143bbae:=09eb 03                =09jmp    ffffffff8143bbb3 <_R=
NvXCsdVu6umiBwhr_12rust_minimalNtB2_11RustMinimalNtCsfATHBUcknU9_6kernel6Mo=
dule4init+0x33>
    ffffffff8143bbb0:=0945 31 f6             =09xor    r14d,r14d
    ffffffff8143bbb3:=090f 0b                =09ud2
    ffffffff8143bbb5:=09bf 04 00 10 00       =09mov    edi,0x100004
    ffffffff8143bbba:=09be 04 00 00 00       =09mov    esi,0x4
    ffffffff8143bbbf:=09e8 7c 23 f5 ff       =09call   ffffffff8138df40 <__=
rust_alloc>
    ffffffff8143bbc4:=0948 85 c0             =09test   rax,rax
    ffffffff8143bbc7:=0974 11                =09je     ffffffff8143bbda <_R=
NvXCsdVu6umiBwhr_12rust_minimalNtB2_11RustMinimalNtCsfATHBUcknU9_6kernel6Mo=
dule4init+0x5a>
    ffffffff8143bbc9:=0948 89 c3             =09mov    rbx,rax
    ffffffff8143bbcc:=09bf 01 00 00 00       =09mov    edi,0x1
    ffffffff8143bbd1:=09e8 ba fc f4 ff       =09call   ffffffff8138b890 <ru=
st_helper_REFCOUNT_INIT>
    ffffffff8143bbd6:=0989 03                =09mov    DWORD PTR [rbx],eax
    ffffffff8143bbd8:=09eb 02                =09jmp    ffffffff8143bbdc <_R=
NvXCsdVu6umiBwhr_12rust_minimalNtB2_11RustMinimalNtCsfATHBUcknU9_6kernel6Mo=
dule4init+0x5c>
    ffffffff8143bbda:=0931 db                =09xor    ebx,ebx
    ffffffff8143bbdc:=090f 0b                =09ud2
    ffffffff8143bbde:=094d 89 77 08          =09mov    QWORD PTR [r15+0x8],=
r14
    ffffffff8143bbe2:=0949 89 5f 10          =09mov    QWORD PTR [r15+0x10]=
,rbx
    ffffffff8143bbe6:=0941 c7 07 00 00 00 00 =09mov    DWORD PTR [r15],0x0
    ffffffff8143bbed:=094c 89 f8             =09mov    rax,r15
    ffffffff8143bbf0:=095b                   =09pop    rbx
    ffffffff8143bbf1:=0941 5e                =09pop    r14
    ffffffff8143bbf3:=0941 5f                =09pop    r15
    ffffffff8143bbf5:=09c3                   =09ret

I have not done extensive enough tests to be sure about this in general,
but most of the examples of the pin-init API that I looked at were
optimized to the same assembly as manual initialization.

The only examples were this was not the case was when I had triply nested
structs with `Box`es that all were initialized via `PinInit`. That was the
point were the initialization closure was not inlined any more.
I also verified that in this particular case the closure was again inlined
after adding `#[inline]` to it (which requires `stmt_expr_attributes`).

At some point I might do a more thorough analysis.

--=20
Cheers,
Benno
