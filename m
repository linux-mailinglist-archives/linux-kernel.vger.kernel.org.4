Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A5866669A
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 23:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjAKW7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 17:59:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235898AbjAKW72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 17:59:28 -0500
Received: from mail.zytor.com (unknown [IPv6:2607:7c80:54:3::138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906986304
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 14:59:25 -0800 (PST)
Received: from [127.0.0.1] ([73.223.250.219])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.17.1) with ESMTPSA id 30BMx6gD1966304
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Wed, 11 Jan 2023 14:59:06 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 30BMx6gD1966304
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2023010601; t=1673477946;
        bh=2juGYZbcVT+bZA0NvbibTotBf+qUGGwXXwtHaUAzRZw=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=gaNWmSkqt7OY80pBxqf1WoDUVGIbPP9tmu9sz/7KcX1EWFWJopEwucIJZu0KXuYqu
         agpqVqXsqdo4grFkv0lqeOCXgbV+RTXCEzn0Pw//sVGzF1imfLwTBDkIJ3nq1MohBr
         uUAtLf5pY4u96PBGLpRW4GvRVI8yH9A/tZ4oJJPjTB5ApQmTP0WrOCv5fU5CPIk8DF
         +MSEawfwvV3FUVEGLTHzykz2a7w7udHfrtpjgzDgDRejSqk+8sL4+6FSyd+UEuxHr8
         bI+lOaZ88J1dsbMML2dvzRErx+DXj12oSTi700yKd52T7PTaByqKopPzGcsbU7Pf5K
         OroiBE4CvAKjQ==
Date:   Wed, 11 Jan 2023 14:59:02 -0800
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: x86/boot: Avoid using Intel mnemonics in AT&T syntax asm
User-Agent: K-9 Mail for Android
In-Reply-To: <Y71NllA2NjlNiZpX@gmail.com>
References: <Y71I3Ex2pvIxMpsP@hirez.programming.kicks-ass.net> <Y71NllA2NjlNiZpX@gmail.com>
Message-ID: <C003E13E-34D9-4A23-806E-D61B665E4D59@zytor.com>
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

On January 10, 2023 3:35:50 AM PST, Ingo Molnar <mingo@kernel=2Eorg> wrote:
>
>* Peter Zijlstra <peterz@infradead=2Eorg> wrote:
>
>>=20
>> With 'GNU assembler (GNU Binutils for Debian) 2=2E39=2E90=2E20221231' t=
he
>> build now reports:
>>=20
>>   arch/x86/realmode/rm/=2E=2E/=2E=2E/boot/bioscall=2ES: Assembler messa=
ges:
>>   arch/x86/realmode/rm/=2E=2E/=2E=2E/boot/bioscall=2ES:35: Warning: fou=
nd `movsd'; assuming `movsl' was meant
>>   arch/x86/realmode/rm/=2E=2E/=2E=2E/boot/bioscall=2ES:70: Warning: fou=
nd `movsd'; assuming `movsl' was meant
>>=20
>>   arch/x86/boot/bioscall=2ES: Assembler messages:
>>   arch/x86/boot/bioscall=2ES:35: Warning: found `movsd'; assuming `movs=
l' was meant
>>   arch/x86/boot/bioscall=2ES:70: Warning: found `movsd'; assuming `movs=
l' was meant
>>=20
>> Which is due to:
>>=20
>>   PR gas/29525
>>=20
>>   Note that with the dropped CMPSD and MOVSD Intel Syntax string insn
>>   templates taking operands, mixed IsString/non-IsString template group=
s
>>   (with memory operands) cannot occur anymore=2E With that
>>   maybe_adjust_templates() becomes unnecessary (and is hence being
>>   removed)=2E
>>=20
>> More details: https://sourceware=2Eorg/bugzilla/show_bug=2Ecgi?id=3D295=
25
>>=20
>> Fixes: 7a734e7dd93b ("x86, setup: "glove box" BIOS calls -- infrastruct=
ure")
>> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead=2Eorg>
>> ---
>>  arch/x86/boot/bioscall=2ES |    4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> --- a/arch/x86/boot/bioscall=2ES
>> +++ b/arch/x86/boot/bioscall=2ES
>> @@ -32,7 +32,7 @@
>>  	movw	%dx, %si
>>  	movw	%sp, %di
>>  	movw	$11, %cx
>> -	rep; movsd
>> +	rep; movsl
>> =20
>>  	/* Pop full state from the stack */
>>  	popal
>> @@ -67,7 +67,7 @@
>>  	jz	4f
>>  	movw	%sp, %si
>>  	movw	$11, %cx
>> -	rep; movsd
>> +	rep; movsl
>>  4:	addw	$44, %sp
>
>So I think the GAS change to introduce this warning was probably=20
>unnecessary - these instructions weren't really causing any trouble and t=
he=20
>syntax was basically a legacy thing that shouldn't be touched - but I gue=
ss=20
>that argument is water down the bridge now:
>
>   Reviewed-by: Ingo Molnar <mingo@kernel=2Eorg>
>
>Thanks,
>
>	Ingo

Yeah; looks like a gas bug/regression, but there isn't really any reason n=
ot to fix it=2E

The semicolon after rep isn't needed anymore either ;)

Acked-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
