Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9B573D28E
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 18:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbjFYQqb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 12:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjFYQq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 12:46:29 -0400
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92E7194
        for <linux-kernel@vger.kernel.org>; Sun, 25 Jun 2023 09:46:24 -0700 (PDT)
Date:   Sun, 25 Jun 2023 16:46:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=protonmail; t=1687711582; x=1687970782;
        bh=UiwcovPu5D6YP531Fs0Dmh7sLnagRakiziEoNif0OK0=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=GfpbcRsSZQ7svs4/PAthoEJAPODQtFPWvBA/VHFU+AmCuQnZndEAtEzddlpKmj2cn
         /DK6pw2KjJDqrIvjy94GyslatfJP7AxKXCJeyReJ9k+iaVCsrUPS4Gx1JEeTtdoZVY
         agnrNQ2R+4ENodKJp641s9srz/zEnt27LvzYGfitSz6ziI5TFmBFAUXPZi4bBajRPB
         Ass6krGGpP685vfHvH2UyTgnLN5bMi+IR6OjieDxgbljJL/xAmBl5Z/pM8cWoBIqKU
         aOrrr5jsZY1PMznSp2rqTo9y6/Rnv/2y+ELnbuwD1MAbsAoF7W63qD6ouK8EmU2Pcu
         dKz5x7xXZxrgg==
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
Message-ID: <0f99bc49-5280-c300-719f-86c138f48eaf@proton.me>
In-Reply-To: <8lCE3SyChVVb2HphigkwKsxv7etgmS0N3AzcDyYtCEoqcFEKvY-5ILkOrWUr_vnWrvsWrAHXVfwcWARfsiMHC8Yc03sND-PuuK-2z9j4z6I=@protonmail.com>
References: <20230624092330.157338-1-benno.lossin@proton.me> <20230624092330.157338-5-benno.lossin@proton.me> <W1fY0aa_v9j7lJNWXk_WNaxY2qruJo1R6k7u0g-X5L5Rxuod-VMBMmByICDwjF_fFGvNJTV41QapW0WeVduNYqxgo9S243gnNGXbexq6P3Q=@protonmail.com> <f4bcd952-1ad9-42b7-6e0b-72a115dcbe8e@proton.me> <we7PHkrpBV6kIgFZojiBFerqlXtSJB9HWkj129OGUWUVyVFwtuoirr3gVybgLzW2hmpUqqSAAQUPsdfL9QC2JyNKOLRNX0mSTfgD8llSJKE=@protonmail.com> <6f4e1d68-f828-8990-4859-8ab24907fa46@proton.me> <8lCE3SyChVVb2HphigkwKsxv7etgmS0N3AzcDyYtCEoqcFEKvY-5ILkOrWUr_vnWrvsWrAHXVfwcWARfsiMHC8Yc03sND-PuuK-2z9j4z6I=@protonmail.com>
Feedback-ID: 71780778:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/25/23 16:17, Bj=C3=B6rn Roy Baron wrote:
> On Sunday, June 25th, 2023 at 15:07, Benno Lossin <benno.lossin@proton.me=
> wrote:
>> On 25.06.23 14:56, Bj=C3=B6rn Roy Baron wrote:
>>> On Saturday, June 24th, 2023 at 23:14, Benno Lossin <benno.lossin@proto=
n.me> wrote:
>>
>>>>>> +                        // Ensure that the struct is indeed `Zeroab=
le`.
>>>>>> +                        is_zeroable(slot);
>>>>>> +                        // SAFETY:  The type implements `Zeroable` =
by the check above.
>>>>>> +                        unsafe { ::core::ptr::write_bytes(slot, 0, =
1) };
>>>>>> +                        $init_zeroed // this will be `()` if set.
>>>>>
>>>>> How does this work? Shouldn't there be a ; after $init_zeroed to cons=
ume the () value?
>>>>
>>>> It is the last expression of a block and since it is `()` it is ok
>>>> (adding a ; would also be ok, but it is not necessary).
>>>
>>> I'm surprised it is considered the last expression of a block. Unlike w=
ith {} using $()? will still
>>> allow variables defined inside this as if they were outside of it. Also=
 I can't reproduce this
>>> behavior with:
>>>
>>>       macro_rules! foo {
>>>           ($($a:expr)?) =3D> {
>>>               $($a)?
>>>               bar();
>>>           }
>>>       }
>>>
>>>       fn main() {
>>>           foo!(());
>>>       }
>>>
>>> Is there something I'm missing?
>>>
>>> Cheers,
>>> Bj=C3=B6rn
>>
>> Not sure what you mean with "allow variables defined inside this
>> as if they were outside of it". But note that in the macro `$init_zeroed=
`
>> is the last expression of a block. Here is a small example:
>=20
> $(let $this =3D unsafe { ::core::ptr::NonNull::new_unchecked(slot) };)? c=
omes after
> this code in the same block that contains struct __InitOk;. And after tha=
t another
> $crate::__init_internal!() invocation. That is why I don't get that this =
is allowed
> at all.
>=20

Oh I see the issue now, I thought I wrote
```
$({
     fn assert_zeroable<T: Zeroable>(ptr: *mut T) {}
     // Ensure that the struct is indeed `Zeroable`.
     assert_zeroable(slot);
     // SAFETY:  The type implements `Zeroable` by the check above.
     unsafe { ::core::ptr::write_bytes(slot, 0, 1) };
     $init_zeroed // this will be `()` if set.
})?
```

But I forgot the inner `{}`. Good catch!

--
Cheers,
Benno

>>
>> ```
>> macro_rules! foo {
>>       ($($a:expr)?) =3D> {{
>>           $(
>>               bar();
>>               $a
>>           )?
>>       }};
>> }
>>
>> fn bar() {}
>>
>> fn main() {
>>       foo!(());
>>       foo!();
>> }
>> ```
>>
>> it expands to this:
>> ```
>> fn main() {
>>       {
>>           bar();
>>           ()
>>       };
>>       {};
>> }
>> ```
>>
>> --
>> Cheers,
>> Benno
>>


