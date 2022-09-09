Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA7A5B3800
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 14:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231136AbiIIMjo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 08:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiIIMjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 08:39:41 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A3C1707B
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 05:39:39 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFtd6LZsz4xPB;
        Fri,  9 Sep 2022 22:39:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1662727178;
        bh=gdgKruRzyKjPVi5bAZLzebsCGCDJal29o5ykCf7Y6Z4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Y5dl+LtKR/dieSR3wubP1gZfKdgCpr11hX6e3Oybcj8d7Yhx7Vqu7s1yfrM1fTBIx
         GE0owCOm73VbeM/AkRr8nNdF9HyX8zHQgSaYL8NcstoTr4vLeQIJdEAbEhNoiKuizE
         njk0dh1Hsuz1F/CvIM278pc7TwvSrqeilltWE8ue1Cw4p7T17xsxM1UlLLQBhqp91p
         3MCIG/vPXJoC19/zomhB3cTDW7zZN8ikUiiBRopGZSXKTeY/iDopRr6QO+e6Snc4Wl
         EznaIQwAJAq2Rlw6BRto2lofB4BzLXEt/hLva5c85QGBDhTgFgVL9SCSQyu7TLtoCQ
         ysjt59wWanoJg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v1 02/19] powerpc/64e: Tie PPC_BOOK3E_64 to PPC_E500MC
In-Reply-To: <e60c6e97-f73e-5a5e-9ddf-8956e9a5b950@csgroup.eu>
References: <4e7e6259e5af0e0e171f19ee1f85ab5b2553723f.1662658653.git.christophe.leroy@csgroup.eu>
 <f2d30eb7fadcfd89f7ac3784cb0b4a4b47d47db1.1662658653.git.christophe.leroy@csgroup.eu>
 <87r10ldrk2.fsf@mpe.ellerman.id.au>
 <e60c6e97-f73e-5a5e-9ddf-8956e9a5b950@csgroup.eu>
Date:   Fri, 09 Sep 2022 22:39:37 +1000
Message-ID: <87k06cen7a.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> Le 09/09/2022 =C3=A0 07:50, Michael Ellerman a =C3=A9crit=C2=A0:
>> Hi Christophe,
>>=20
>> Thanks for trying to clean up this tangled mess.
>>=20
>> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>>> The only 64-bit Book3E CPUs we support is the e500mc.
>>=20
>> AFAIK the e500mc is 32-bit?
>
> Yes it seems.
>
>>=20
>> We support e5500 and e6500 which are 64-bit Book3E.
>>=20
>> They're derivatives of the e500mc AIUI.
>>=20
>> So CONFIG_PPC_E500MC actually means e500mc *and later derivatives*.
>>=20
>> You can see that with eg:
>>=20
>> config SPE_POSSIBLE
>> 	def_bool y
>> 	depends on E500 && !PPC_E500MC
>>=20
>> Because e500mc dropped SPE, and so therefore e5500 and e6500 don't have
>> it either.
>>=20
>> And eg:
>>=20
>> #ifdef CONFIG_PPC_E500MC
>> _GLOBAL(__setup_cpu_e6500)
>> 	mflr	r6
>>=20
>>=20
>>> However our Kconfig allows configurating a kernel that has 64-bit
>>> Book3E support, but no e500mc support enabled. Such a kernel
>>> would never boot, it doesn't know about any CPUs.
>>=20
>> That is true.
>>=20
>>> To fix this, force e500mc to be selected whenever we are
>>> building a 64-bit Book3E kernel.
>>=20
>> I think that's a reasonable fix, just it's important to differentiate
>> between CONFIG_PPC_E500MC (the symbol) and e500mc (the CPU).
>
> Ok, I'll see how I can make it more explicit.
>
>>=20
>>> And add a test to detect futur situations where cpu_specs is empty.
>>                             future
>>>
>>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>>> ---
>>>   arch/powerpc/kernel/cputable.c         | 2 ++
>>>   arch/powerpc/platforms/Kconfig.cputype | 2 ++
>>>   2 files changed, 4 insertions(+)
>>>
>> ..
>>> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/plat=
forms/Kconfig.cputype
>>> index 5185d942b455..19fd95a06352 100644
>>> --- a/arch/powerpc/platforms/Kconfig.cputype
>>> +++ b/arch/powerpc/platforms/Kconfig.cputype
>>> @@ -108,6 +108,8 @@ config PPC_BOOK3S_64
>>>   config PPC_BOOK3E_64
>>>   	bool "Embedded processors"
>>>   	select PPC_FSL_BOOK3E
>>> +	select E500
>>> +	select PPC_E500MC
>>>   	select PPC_FPU # Make it a choice ?
>>>   	select PPC_SMP_MUXED_IPI
>>>   	select PPC_DOORBELL
>>=20
>> I think that makes the select of PPC_E500MC below redundant:
>>=20
>> config PPC_QEMU_E500
>> 	bool "QEMU generic e500 platform"
>> 	select DEFAULT_UIMAGE
>> 	select E500
>> 	select PPC_E500MC if PPC64
>
> That's handled in  [v1,10/19] powerpc: Remove redundant selection of=20
> E500 and E500MC. Should I reorder patches ?

No that's fine the way it is, I hadn't looked at patch 10 when I replied.

cheers
