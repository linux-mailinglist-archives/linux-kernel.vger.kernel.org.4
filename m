Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD5688FAE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 07:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbjBCGae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 01:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjBCGaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 01:30:30 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2079023319
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 22:30:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AF12F61CC8
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 06:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8BEC433EF;
        Fri,  3 Feb 2023 06:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675405828;
        bh=j6I7zaAES9oltJCRwDO/7+UEDLvZ7GINMhpnILkQXUo=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=mInjAoh3BTeCCcM5IeeR8jvO7wVCIrKyBP6eOVYV6NdaZ6xL9NG06/+voAtY/NscN
         sIhzQE8MuUaZ0fgHuH3AtJL/Cu3EFqgsEA+z1mN8HZAIfFpSkEkLs0/cgNd/vEzcu8
         gN8sPDXyCA9Wd5z11DQPttPdME4BsSvZ6hyofD9G+RR0syeIXyQKidltsmxkeC6ljs
         bnutrPDZihk0YUE3RV9mN+oOO05+rF5iJDHC1c8EyiWNmOv1ZC/l70HktQ7Qj4YNmS
         Wuqdu1UmnDypfEtoVZDla0QO7ItArq9+qV4UsxmzNMn93ANIZyNlMWvT/CxEwpP3Nw
         0D5KMEzf2Arbw==
Date:   Fri, 03 Feb 2023 06:30:24 +0000
From:   Conor Dooley <conor@kernel.org>
To:     JeeHeng Sia <jeeheng.sia@starfivetech.com>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: =?US-ASCII?Q?RE=3A_=5BPATCH_v3_4/4=5D_RISC-V=3A_Add_arch_functi?= =?US-ASCII?Q?ons_to_support_hibernation/suspend-to-disk?=
User-Agent: K-9 Mail for Android
In-Reply-To: <debdfe40909c4b4787868b11730170c9@EXMBX066.cuchost.com>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com> <20230127091051.1465278-5-jeeheng.sia@starfivetech.com> <Y9hTGo6dfgeusW4B@spud> <debdfe40909c4b4787868b11730170c9@EXMBX066.cuchost.com>
Message-ID: <26A8AAC0-D477-45CD-A7D1-55218992B25F@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 February 2023 03:43:35 GMT, JeeHeng Sia <jeeheng=2Esia@starfivetech=
=2Ecom> wrote:
>
>
>> -----Original Message-----
>> From: Conor Dooley <conor@kernel=2Eorg>
>> Sent: Tuesday, 31 January, 2023 7:31 AM
>> To: JeeHeng Sia <jeeheng=2Esia@starfivetech=2Ecom>; Alexandre Ghiti <al=
exghiti@rivosinc=2Ecom>
>> Cc: paul=2Ewalmsley@sifive=2Ecom; palmer@dabbelt=2Ecom; aou@eecs=2Eberk=
eley=2Eedu; linux-riscv@lists=2Einfradead=2Eorg; linux-
>> kernel@vger=2Ekernel=2Eorg; Leyfoon Tan <leyfoon=2Etan@starfivetech=2Ec=
om>; Mason Huo <mason=2Ehuo@starfivetech=2Ecom>
>> Subject: Re: [PATCH v3 4/4] RISC-V: Add arch functions to support hiber=
nation/suspend-to-disk
>>=20
>> +CC Alex
>>=20
>> Alex, could you take a look at the page table bits here when you get a
>> chance please?
>>=20
>> > + * @a0 - destination
>> > + * @a1 - source
>> > + */
>> > +	=2Emacro	copy_page a0, a1
>> > +		lui	a2, 0x1
>> > +		add	a2, a2, a0
>> > +=2E1 :
>> > +		REG_L	t0, 0(a1)
>> > +		REG_L	t1, SZREG(a1)
>> > +
>> > +		REG_S	t0, 0(a0)
>> > +		REG_S	t1, SZREG(a0)
>> > +
>> > +		addi	a0, a0, 2 * SZREG
>> > +		addi	a1, a1, 2 * SZREG
>> > +		bne	a2, a0, =2E1
>>=20
>> allmodconfig, clang 15=2E0=2E4:
>>=20
>> <instantiation>:3:1: error: unexpected token at start of statement
>> =2E1 :
>> ^
>> /stuff/linux/arch/riscv/kernel/hibernate-asm=2ES:83:2: note: while in m=
acro instantiation
>>  copy_page a0, a1
>>  ^
>> <instantiation>:12:15: error: unknown operand
>>   bne a2, a0, =2E1
>>               ^
>> /stuff/linux/arch/riscv/kernel/hibernate-asm=2ES:83:2: note: while in m=
acro instantiation
>>  copy_page a0, a1
>>  ^
>> make[5]: *** [/stuff/linux/scripts/Makefile=2Ebuild:384: arch/riscv/ker=
nel/hibernate-asm=2Eo] Error 1
>Hi Conor, I couldn't reproduce the above error, could you share the build=
 command please?

It was just allmodconfig with LLVM=3D1

>>=20
>> > +	=2Eendm
>> > +
>> >  #endif	/* __ASM_ASSEMBLER_H */
>=20
>> Thanks,
>> Conor=2E
>
