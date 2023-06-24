Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2403D73CCBC
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 23:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbjFXVFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 17:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjFXVFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 17:05:42 -0400
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FA9171A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jun 2023 14:05:36 -0700 (PDT)
Date:   Sat, 24 Jun 2023 21:05:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687640733; x=1687899933;
        bh=+s2qFVdzSz1dpYq79TE2KMsy1jB2F75QErlkZyaVuak=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=Ig2IeD3atLhIkkOEdLwbcZrefkSYwpRAza/XJ8Zjwi7uQQgg5TxKoeg/QTY1oLqOX
         VZ4fU8tSo+C26sC++G1cQFInRO8rhBGnLSi+HlFq++l/1fvbtyUw5ffP4NnCuMj45+
         6+i12Yy9qwDXVtLAdp7ijVvJNpiDtt53cfZaO7m+YCLn3OpW/ymLZ7KDyTseGu2N68
         axvv90ptAztRXM8R48NZ1FpMyXOg3onvAfccJBVLoKOQ6WXzrstHeDhjUuIQdKilTO
         86XOEBOkcmNe41KuTR8VerYbOlhB56agJrcaRcPJb9tlM/+5y2ZHEFBHaG5cB0Ks33
         V6npSjhBlx+9A==
To:     =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH 4/7] rust: init: wrap type checking struct initializers in a closure
Message-ID: <Cs0WvAGhcBydk2RmwKLuog68EzhWu-Uc6ZTUrXBs7vgUozT07W9JebR0KiFQokDpWVGkotW68iEzW9TYFym5jDvpGMp5AqlpSsmLUUDgeNE=@proton.me>
In-Reply-To: <zLJ2TSszsTrjSQ39Y8JsZLnZQ2qe8JLp_dK7vSArkClDKOzaCzO94OXwYdco6FLBNTr-MeRp0c75a-aKm_8wKlb9aPgfvf9nz2Ha5XbrutE=@protonmail.com>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-4-benno.lossin@proton.me> <zLJ2TSszsTrjSQ39Y8JsZLnZQ2qe8JLp_dK7vSArkClDKOzaCzO94OXwYdco6FLBNTr-MeRp0c75a-aKm_8wKlb9aPgfvf9nz2Ha5XbrutE=@protonmail.com>
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

On 6/24/23 17:03, Bj=C3=B6rn Roy Baron wrote:
> On Saturday, June 24th, 2023 at 11:25, Benno Lossin <benno.lossin@proton.=
me> wrote:
>=20
>> In the implementation of the init macros there is a `if false` statement
>> that type checks the initializer to ensure every field is initialized.
>> Since the next patch has a stack variable to store the struct, the
>> function might allocate too much memory on debug builds. Putting the
>> struct into a closure ensures that even in debug builds no stack
>> overflow error is caused. In release builds this was not a problem since
>> the code was optimized away due to the `if false`.
>>
>> Signed-off-by: Benno Lossin <benno.lossin@proton.me>
>> ---
>>   rust/kernel/init/macros.rs | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/rust/kernel/init/macros.rs b/rust/kernel/init/macros.rs
>> index df4281743175..1e0c4aca055a 100644
>> --- a/rust/kernel/init/macros.rs
>> +++ b/rust/kernel/init/macros.rs
>> @@ -1037,14 +1037,18 @@ macro_rules! __init_internal {
>>                       // We use unreachable code to ensure that all fiel=
ds have been mentioned exactly
>>                       // once, this struct initializer will still be typ=
e-checked and complain with a
>>                       // very natural error message if a field is forgot=
ten/mentioned more than once.
>> -                    #[allow(unreachable_code, clippy::diverging_sub_exp=
ression)]
>> +                    #[allow(unreachable_code,
>> +                            clippy::diverging_sub_expression,
>> +                            clippy::redundant_closure_call)]
>>                       if false {
>> -                        $crate::__init_internal!(make_initializer:
>> -                            @slot(slot),
>> -                            @type_name($t),
>> -                            @munch_fields($($fields)*,),
>> -                            @acc(),
>> -                        );
>> +                        (|| {
>> +                            $crate::__init_internal!(make_initializer:
>> +                                @slot(slot),
>> +                                @type_name($t),
>> +                                @munch_fields($($fields)*,),
>> +                                @acc(),
>> +                            );
>> +                        })();
>=20
> Is it necessary to call this closure? Typechecking of the closure should =
happen even without calling it.

You are right, I do not need to call it. Will fix.

--=20
Cheers,
Benno

>=20
>>                       }
>>                   }
>>                   Ok(__InitOk)
>> --
>> 2.41.0
>=20
> Cheers,
> Bj=C3=B6rn

