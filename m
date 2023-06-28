Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 380E8741037
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 13:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjF1LmN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 07:42:13 -0400
Received: from mail-4322.protonmail.ch ([185.70.43.22]:55013 "EHLO
        mail-4322.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230281AbjF1LmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 07:42:10 -0400
Date:   Wed, 28 Jun 2023 11:41:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687952529; x=1688211729;
        bh=1XmJXLB2uklIrAaKv9O0vIo0TRiOWO1X6CWSa661Mfg=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=UlBERZzlcMySexpywP/qfwbhkcuGUTK/3+eki529LjK1ujWoEHEDLIGJhR8G+ofo2
         HJ96vvG49aHx/tDb+30C3Cl4gVcd2UPpiQPc8mbZMEWBzojtWtIaLoT+NPnvI27t3I
         dcsWKLEczhj4NeRxGDcuK6QlC4g/TGLF5erWdd0b//47PyfwUYVIX+2LS8n6++LVWx
         tXM1cTk0Cz5qPn+7rKokJTd2Yf9LVVjjDEjbSO9XVK8Qt5tob1alGLuGlE1RKFuPnI
         6uAqN2CQA66+U8jLcfXAaFqVoi5x4vIL/7kY9K9RZtxsZlH5ArVPIjZ7cyoxjsnnyz
         aEzhhUSlftGqA==
To:     Gary Guo <gary@garyguo.net>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 3/7] rust: init: make guards in the init macros hygienic
Message-ID: <w4kyaXwWZEyoBoCCFmVtRmkUS6d0m_DJYTs7OVWLkbBX7PFwjj_wemi1mtvSemjUyhZwSDCA2l-5fXn4sxO4C3DT_8wGyZebpea-wQseOmA=@proton.me>
In-Reply-To: <20230625215453.25aa38a0.gary@garyguo.net>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-3-benno.lossin@proton.me> <20230625215453.25aa38a0.gary@garyguo.net>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.06.23 22:54, Gary Guo wrote:
> On Sat, 24 Jun 2023 09:25:10 +0000
> Benno Lossin <benno.lossin@proton.me> wrote:
>=20
>> Use hygienic identifiers for the guards instead of the field names. This
>> makes the init macros feel more like normal struct initializers, since
>> assigning identifiers with the name of a field does not create
>> conflicts.
>> Also change the internals of the guards, no need to make the `forget`
>> function `unsafe`, since users cannot access the guards anyways. Now the
>> guards are carried directly on the stack and have no extra `Cell<bool>`
>> field that marks if they have been forgotten or not, instead they are
>> just forgotten via `mem::forget`.
>=20
> The code LGTM, so:
>=20
> Reviewed-by: Gary Guo <gary@garyguo.net>
>=20
> Although this will cause the new expansion we have to be no longer
> compatible with a totally-proc-macro impl, if we want to do everything
> in proc macro in the future.
>=20
> If we have the paste macro upstream (
> https://github.com/nbdd0121/linux/commit/fff00461b0be7fd3ec218dcc428f2588=
6b5ec04a
> ) then we can replace the `guard` with `paste!([<$field>])` and keep
> the expansion identical.
>=20

I tried it and it seems to work, but I am not sure why the hygiene is
set correctly. Could you maybe explain why this works?
```
        $crate::__internal::paste!{
            let [<$field>] =3D unsafe {
                $crate::__internal::DropGuard::new(::core::ptr::addr_of_mut=
!((*$slot).$field))
            };
            $crate::__init_internal!(init_slot($use_data):
                @data($data),
                @slot($slot),
                @guards([<$field>], $($guards,)*),
                @munch_fields($($rest)*),
            );
        }
```

i.e. why can't a user access the guard? I think it is because the hygiene o=
f the `[<>]`
is used, but not sure why that works.

--=20
Cheers,
Benno


