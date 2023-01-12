Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76AF4666895
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 02:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbjALByN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 20:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjALByL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 20:54:11 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4F741D7A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 17:54:09 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30C1rfAG2011617
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 11 Jan 2023 17:53:42 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30C1rfAG2011617
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1673488423;
        bh=VGieq2MO5A1buIeiekgNn+iW1zNkO+ZFkczL48svTKc=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=JtlXfDni+v/9GVy2OqI9M0ZjxbksDYqF0MCOYyfzko0Tk7OonLo8E0szfIuZEyNjt
         JaH9yR9JOtMLy9u29Ln2csMpVrPl6+e+Wv9CuL/8+l3pcXvO7q3qcFhrQfzlSi1MAN
         2Z2Ekrq/O+4/m6q77x+NiZDIHNGQTOtYbgKEJ+mXpEiTnHiivnQd3CXy1qTQzGYbfU
         8nFPcNZDk4h9QV2wjv4QucqFTRjW+r1p+7OlwAHJsnmhsdVH4pLQ2fhqByCZR/H2B+
         sRmqZf2+uSNpLo3CmDlaoLoDPuvZSTQxvM+Nm1NEOcL9m0HFdnD8f1y9qxCWSEMInh
         amnDhr+L1sHGQ==
Date:   Wed, 11 Jan 2023 17:53:37 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86=3A_Disable_kernel_?= =?US-ASCII?Q?stack_offset_randomization_for_!TSC?=
User-Agent: K-9 Mail for Android
In-Reply-To: <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk>
References: <alpine.DEB.2.21.2301082113350.65308@angie.orcam.me.uk> <Y72CByxvewQv78YH@zx2c4.com> <alpine.DEB.2.21.2301120129020.65308@angie.orcam.me.uk>
Message-ID: <B71587C5-21E8-4F7C-94FB-92E2AA9F840A@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 11, 2023 5:34:29 PM PST, "Maciej W=2E Rozycki" <macro@orcam=2Eme=
=2Euk> wrote:
>On Tue, 10 Jan 2023, Jason A=2E Donenfeld wrote:
>
>> > Index: linux-macro/arch/x86/include/asm/entry-common=2Eh
>> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> > --- linux-macro=2Eorig/arch/x86/include/asm/entry-common=2Eh
>> > +++ linux-macro/arch/x86/include/asm/entry-common=2Eh
>> > @@ -5,6 +5,7 @@
>> >  #include <linux/randomize_kstack=2Eh>
>> >  #include <linux/user-return-notifier=2Eh>
>> > =20
>> > +#include <asm/cpufeature=2Eh>
>> >  #include <asm/nospec-branch=2Eh>
>> >  #include <asm/io_bitmap=2Eh>
>> >  #include <asm/fpu/api=2Eh>
>> > @@ -85,7 +86,8 @@ static inline void arch_exit_to_user_mod
>> >  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
>> >  	 * 6 (ia32) bits=2E
>> >  	 */
>> > -	choose_random_kstack_offset(rdtsc() & 0xFF);
>> > +	if (cpu_feature_enabled(X86_FEATURE_TSC))
>> > +		choose_random_kstack_offset(rdtsc() & 0xFF);
>>=20
>> What would happen if you just called `get_random_u8()` here?
>
> Thank you for your input=2E  I've had a look at the function and it seem=
s a=20
>bit heavyweight compared to a mere single CPU instruction, but I guess wh=
y=20
>not=2E  Do you have any performance figures (in terms of CPU cycles) for =
the=20
>usual cases?  Offhand I'm not sure how I could benchmark it myself=2E
>
> I have made a patch and of course it makes the system boot too, although=
=20
>it's not clear to me how I can actually verify randomisation works=2E  I =
can=20
>assume it does I suppose=2E
>
>  Maciej

Not to mention that we could use rdrand here if it is available (although =
it is slower than rdtsc=2E)

RDTSC isn't a super fast instruction either, but what is *way* more signif=
icant is that this use of RDTSC is NOT safe: in certain power states it may=
 very well be that stone number of lower bits of TSC contain no entropy at =
all=2E

At the very least one should do a rotating multiply with a large (32-bit) =
prime number=2E
