Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADC666D853
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 09:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235877AbjAQIgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 03:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235754AbjAQIgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 03:36:10 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE3D2ED77;
        Tue, 17 Jan 2023 00:35:48 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30H8Z9BS4127953
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 17 Jan 2023 00:35:09 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30H8Z9BS4127953
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1673944511;
        bh=vqQlJ3TrrAtDYO6yWi6ppwxx2A6H0krCYOzj335kUj4=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Q0Zb6XImYJwgch3/y8/gj/iQy9mgf7QT/iSdmIKSriM+2/nAC2TuyC1G91P2mhUr7
         CAxvc/oP5+kT1XT/vmEu6jd8lvuYY0Zvlhfgf+k7bliLwON53gTId8AVpgEhK8xVOZ
         o2KJTQwLS3N9h7TFYJjmUI7gt8bZ8gVH8gyDvkMvViMyY8MacGfN6x1MagIHXQsHTf
         IysA8W12o4ShQJ+18Men1u5F1HaJ+OwvQcri3RifCqrGDwK4PJvSOgFkQIY/FcrF41
         k+DdNsB9xKtOdiVxF2krhhDx4M9bNRoxnQEGvaBUkrj5/t8Go/VxRNTnMZuWLXm4DI
         kGHiTfwiX1H/Q==
Date:   Tue, 17 Jan 2023 00:35:06 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Andy Lutomirski <luto@amacapital.net>
CC:     Yann Droneaud <ydroneaud@opteya.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Florian Weimer <fweimer@redhat.com>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_0/4=5D_random=3A_a_simple_vDSO?= =?US-ASCII?Q?_mechanism_for_reseeding_userspace_CSPRNGs?=
User-Agent: K-9 Mail for Android
In-Reply-To: <15F7D57C-8CC6-4CAE-8B7E-6F480B5F4133@amacapital.net>
References: <585ddb35-adc5-f5cf-4db3-27571f394108@zytor.com> <15F7D57C-8CC6-4CAE-8B7E-6F480B5F4133@amacapital.net>
Message-ID: <34C12E41-1914-4C93-8635-F3FDBADA1EBE@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 16, 2023 11:49:42 AM PST, Andy Lutomirski <luto@amacapital=2Enet=
> wrote:
>
>
>> On Jan 13, 2023, at 7:16 PM, H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>=20
>> =EF=BB=BFOn 1/12/23 11:55, Yann Droneaud wrote:
>>> Hi
>>> 12 janvier 2023 =C3=A0 18:07 "Jason A=2E Donenfeld" <Jason@zx2c4=2Ecom=
> a =C3=A9crit:
>>> =20
>>>> Sorry Yann, but I'm not interested in this approach, and I don't thin=
k
>>>> reviewing the details of it are a good allocation of time=2E I don't
>>>> want to lock the kernel into having specific reseeding semantics that
>>>> are a contract with userspace, which is what this approach does=2E
>>> This patch adds a mean for the kernel to tell userspace: between the
>>> last time you call us with getrandom(timestamp,, GRND_TIMESTAMP),
>>> something happened that trigger an update to the opaque cookie given
>>> to getrandom(timestamp, GRND_TIMESTAMP)=2E When such update happen,
>>> userspace is advised to discard buffered random data and retry=2E
>>> The meaning of the timestamp cookie is up to the kernel, and can be
>>> changed anytime=2E Userspace is not expected to read the content of th=
is
>>> blob=2E Userspace only acts on the length returned by getrandom(,, GRN=
D_TIMESTAMP):
>>>  -1 : not supported
>>>   0 : cookie not updated, no need to discard buffered data
>>>  >0 : cookie updated, userspace should discard buffered data
>>> For the cookie, I've used a single u64, but two u64 could be a better =
start,
>>> providing room for implementing improved behavior in future kernel ver=
sions=2E
>>>> Please just let me iterate on my original patchset for a little bit,
>>>> without adding more junk to the already overly large conversation=2E
>>> I like the simplicity of my so called "junk"=2E It's streamlined, does=
n't
>>> require a new syscall, doesn't require a new copy of ChaCha20 code=2E
>>> I'm sorry it doesn't fit your expectations=2E
>>=20
>> Why would anything more than a 64-bit counter be ever necessary? It onl=
y needs to be incremented=2E
>
>This is completely broken with CRIU or, for that matter, with VM forking=
=2E
>
>>=20
>> Let user space manage keeping track of the cookie matching its own buff=
ers=2E You do NOT want this to be stateful, because that's just begging for=
 multiple libraries to step on each other=2E
>>=20
>> Export the cookie from the vdso and voli=C3=A0, a very cheap check arou=
nd any user space randomness buffer will work:
>>=20
>>    static clone_cookie_t last_cookie;
>>    clone_cookie_t this_cookie;
>>=20
>>    this_cookie =3D get_clone_cookie();
>>    do {
>>        while (this_cookie !=3D last_cookie) {
>>            last_cookie =3D this_cookie;
>>            reinit_randomness();
>>            this_cookie =3D get_clone_cookie();
>>        }
>>=20
>>        extract_randomness_from_buffer();
>>        this_cookie =3D get_clone_cookie();
>>    } while (this_cookie !=3D last_cookie);
>>=20
>>    last_cookie =3D this_cookie;
>>=20
>>    -hpa
>

For those you would randomize the counter=2E
