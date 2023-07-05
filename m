Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96C89749019
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 23:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjGEVol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 17:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjGEVok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 17:44:40 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 782C81997
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 14:44:35 -0700 (PDT)
Date:   Wed, 05 Jul 2023 21:44:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1688593472; x=1688852672;
        bh=BsxqveEuWUXuxAC8tXYge4xIJEmM7wZqtaoyhSMuH9A=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=baIRJTcH2TwferdGWwGYFCBD1n1CVqnDMs2JrPsYN/pvdhesSH6w+Dmfhv+k8oH9/
         NKeofawqRPpIs83RXdQnWPh6ohYYEyhgVPBCwEgiystbjTKRKuHqQexMCv1TiX1UG4
         Tgtp5ho7hM7kZn1iUqUZxxbx9ibm2g7J7rQTPN5rQPh5WtZX+uChurmXa1whzABgDB
         2H9MX/vSorp0UGtZUcI4Iy8OMj7MVwK+3BeMiuYGoT4owXPFMWvLd9EObqLlSrYUpw
         E+AxKNF9n+uTyOwhLSPW7lxQFvpXr4V1Zb7J754LOnyT4v5+LzyMAbCJvcDd8AVFNj
         T8YY0VDnxlUoA==
To:     Gary Guo <gary@garyguo.net>
From:   Benno Lossin <benno.lossin@proton.me>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Asahi Lina <lina@asahilina.net>
Subject: Re: [PATCH 5/7] rust: init: add `..Zeroable::zeroed()` syntax for zeroing all missing fields
Message-ID: <YfprOGVPci8tiiFEBN5olLh8NiFh8mRJOcQQ5icOWAhXjncFLKy9Aj-Tr5sidcCiSguYYykfdv_4PM2UoF238vjzuXHeckZal5cGNMW2y8c=@proton.me>
In-Reply-To: <20230705184836.363c8c8b.gary@garyguo.net>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-5-benno.lossin@proton.me> <ZKMQW4UGPQZ8yF39@boqun-archlinux> <20230705184836.363c8c8b.gary@garyguo.net>
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

On 05.07.23 19:48, Gary Guo wrote:
> On Mon, 3 Jul 2023 11:15:55 -0700
> Boqun Feng <boqun.feng@gmail.com> wrote:
>=20
>> On Sat, Jun 24, 2023 at 09:25:19AM +0000, Benno Lossin wrote:
>> [...]
>> (this is `init_slot`)
>>> @@ -1064,7 +1152,7 @@ macro_rules! __init_internal {
>>>           @data($data:ident),
>>>           @slot($slot:ident),
>>>           @guards($($guards:ident,)*),
>>> -        @munch_fields($(,)?),
>>> +        @munch_fields($(..Zeroable::zeroed())? $(,)?),
>>
>> since you append an unconditional comma ',' to init_slot and
>> make_initializer when "calling" them in with_update_parsed, shouldn't
>> this be:
>>
>> +        @munch_fields($(..Zeroable::zeroed(),)? $(,)?),
>>
>> , and..
>>
>>>       ) =3D> {
>>>           // Endpoint of munching, no fields are left. If execution rea=
ches this point, all fields
>>>           // have been initialized. Therefore we can now dismiss the gu=
ards by forgetting them.
>>> @@ -1157,6 +1245,30 @@ macro_rules! __init_internal {
>>>               @munch_fields($($rest)*),
>>>           );
>>>       };
>>> +    (make_initializer:
>>> +        @slot($slot:ident),
>>> +        @type_name($t:ident),
>>> +        @munch_fields(..Zeroable::zeroed() $(,)?),
>>
>> this should be:
>>
>> +        @munch_fields(..Zeroable::zeroed() , $(,)?),
>>
>> Otherwise the example before `pin_init!()` wouldn't compile:
>>
>> =09/// pin_init!(Buf {
>> =09///     buf: [1; 64],
>> =09///     ..Zeroable::zeroed(),
>> =09/// });
>=20
> Comma is not allowed after base struct.

Yes this is a mistake in the example, will fix.

--=20
Cheers,
Benno

>=20
>>
>> Regards,
>> Boqun
>>
>>> +        @acc($($acc:tt)*),
>>> +    ) =3D> {
>>> +        // Endpoint, nothing more to munch, create the initializer. Si=
nce the users specified
>>> +        // `..Zeroable::zeroed()`, the slot will already have been zer=
oed and all field that have
>>> +        // not been overwritten are thus zero and initialized. We stil=
l check that all fields are
>>> +        // actually accessible by using the struct update syntax ourse=
lves.
>>> +        // Since we are in the `if false` branch, this will never get =
executed. We abuse `slot` to
>>> +        // get the correct type inference here:
>>> +        unsafe {
>>> +            let mut zeroed =3D ::core::mem::zeroed();
>>> +            // We have to use type inference her to make zeroed have t=
he correct type. This does
>>> +            // not get executed, so it has no effect.
>>> +            ::core::ptr::write($slot, zeroed);
>>> +            zeroed =3D ::core::mem::zeroed();
>>> +            ::core::ptr::write($slot, $t {
>>> +                $($acc)*
>>> +                ..zeroed
>>> +            });
>>> +        }
>>> +    };
>>>       (make_initializer:
>>>           @slot($slot:ident),
>>>           @type_name($t:ident),
>>> --
>>> 2.41.0
>>>
>>>
> 
