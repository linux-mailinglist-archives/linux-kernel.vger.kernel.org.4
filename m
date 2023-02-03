Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D88A688E1E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 04:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjBCDnl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 2 Feb 2023 22:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBCDnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 22:43:39 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78D5D721FF
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 19:43:37 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 5505A24E13F;
        Fri,  3 Feb 2023 11:43:36 +0800 (CST)
Received: from EXMBX065.cuchost.com (172.16.6.65) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 11:43:36 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX065.cuchost.com
 (172.16.6.65) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 3 Feb
 2023 11:43:35 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 3 Feb 2023 11:43:35 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        Alexandre Ghiti <alexghiti@rivosinc.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v3 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v3 4/4] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZMi9ZN0+4F1UUIkevO0NjoPA20663GzgAgAWChyA=
Date:   Fri, 3 Feb 2023 03:43:35 +0000
Message-ID: <debdfe40909c4b4787868b11730170c9@EXMBX066.cuchost.com>
References: <20230127091051.1465278-1-jeeheng.sia@starfivetech.com>
 <20230127091051.1465278-5-jeeheng.sia@starfivetech.com>
 <Y9hTGo6dfgeusW4B@spud>
In-Reply-To: <Y9hTGo6dfgeusW4B@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.50.196.81]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Tuesday, 31 January, 2023 7:31 AM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>; Alexandre Ghiti <alexghiti@rivosinc.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: Re: [PATCH v3 4/4] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
> +CC Alex
> 
> Alex, could you take a look at the page table bits here when you get a
> chance please?
> 
> > + * @a0 - destination
> > + * @a1 - source
> > + */
> > +	.macro	copy_page a0, a1
> > +		lui	a2, 0x1
> > +		add	a2, a2, a0
> > +.1 :
> > +		REG_L	t0, 0(a1)
> > +		REG_L	t1, SZREG(a1)
> > +
> > +		REG_S	t0, 0(a0)
> > +		REG_S	t1, SZREG(a0)
> > +
> > +		addi	a0, a0, 2 * SZREG
> > +		addi	a1, a1, 2 * SZREG
> > +		bne	a2, a0, .1
> 
> allmodconfig, clang 15.0.4:
> 
> <instantiation>:3:1: error: unexpected token at start of statement
> .1 :
> ^
> /stuff/linux/arch/riscv/kernel/hibernate-asm.S:83:2: note: while in macro instantiation
>  copy_page a0, a1
>  ^
> <instantiation>:12:15: error: unknown operand
>   bne a2, a0, .1
>               ^
> /stuff/linux/arch/riscv/kernel/hibernate-asm.S:83:2: note: while in macro instantiation
>  copy_page a0, a1
>  ^
> make[5]: *** [/stuff/linux/scripts/Makefile.build:384: arch/riscv/kernel/hibernate-asm.o] Error 1
Hi Conor, I couldn't reproduce the above error, could you share the build command please?
> 
> > +	.endm
> > +
> >  #endif	/* __ASM_ASSEMBLER_H */
 
> Thanks,
> Conor.

