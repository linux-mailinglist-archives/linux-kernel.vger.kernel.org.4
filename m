Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75A9E6A149E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBXBdu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Feb 2023 20:33:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjBXBdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:33:47 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA814EB0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:33:43 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 0454524DB8C;
        Fri, 24 Feb 2023 09:33:42 +0800 (CST)
Received: from EXMBX061.cuchost.com (172.16.6.61) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 09:33:41 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX061.cuchost.com
 (172.16.6.61) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 09:33:41 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 24 Feb 2023 09:33:41 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v4 2/4] RISC-V: Factor out common code of
 __cpu_resume_enter()
Thread-Topic: [PATCH v4 2/4] RISC-V: Factor out common code of
 __cpu_resume_enter()
Thread-Index: AQHZRZ0usaQdEx0RFEu95aWg+gkHKK7blUuAgAG/cmA=
Date:   Fri, 24 Feb 2023 01:33:41 +0000
Message-ID: <794606ec4f594119a71824fbf3af5921@EXMBX066.cuchost.com>
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-3-jeeheng.sia@starfivetech.com>
 <20230223065155.olemrm7cskwclzt7@orel>
In-Reply-To: <20230223065155.olemrm7cskwclzt7@orel>
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
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Thursday, 23 February, 2023 2:52 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: Re: [PATCH v4 2/4] RISC-V: Factor out common code of __cpu_resume_enter()
> 
> On Tue, Feb 21, 2023 at 10:35:21AM +0800, Sia Jee Heng wrote:
> > The cpu_resume() function is very similar for the suspend to disk and
> > suspend to ram cases. Factor out the common code into restore_csr macro
> > and restore_reg macro.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > ---
> >  arch/riscv/include/asm/assembler.h | 62 ++++++++++++++++++++++++++++++
> >  arch/riscv/kernel/suspend_entry.S  | 34 ++--------------
> >  2 files changed, 65 insertions(+), 31 deletions(-)
> >  create mode 100644 arch/riscv/include/asm/assembler.h
> >
> > diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> > new file mode 100644
> > index 000000000000..727a97735493
> > --- /dev/null
> > +++ b/arch/riscv/include/asm/assembler.h
> > @@ -0,0 +1,62 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +/*
> > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > + *
> > + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> > + */
> > +
> > +#ifndef __ASSEMBLY__
> > +#error "Only include this from assembly code"
> > +#endif
> > +
> > +#ifndef __ASM_ASSEMBLER_H
> > +#define __ASM_ASSEMBLER_H
> > +
> > +#include <asm/asm.h>
> > +#include <asm/asm-offsets.h>
> > +#include <asm/csr.h>
> > +
> > +/*
> > + * restore_csr - restore hart's CSR value
> > + */
> > +	.macro restore_csr
> 
> Since there are more than one, 'restore_csrs' would be more appropriate
> and s/CSR value/CSRs/
> 
> > +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> > +		csrw	CSR_EPC, t0
> > +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> > +		csrw	CSR_STATUS, t0
> > +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> > +		csrw	CSR_TVAL, t0
> > +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> > +		csrw	CSR_CAUSE, t0
> > +	.endm
> > +
> > +/*
> > + * restore_reg - Restore registers (except A0 and T0-T6)
> > + */
> > +	.macro restore_reg
> 
> restore_regs
> 
> > +		REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> > +		REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> > +		REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> > +		REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> > +		REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> > +		REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> > +		REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> > +		REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> > +		REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> > +		REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> > +		REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> > +		REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> > +		REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> > +		REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> > +		REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> > +		REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> > +		REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> > +		REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> > +		REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> > +		REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> > +		REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> > +		REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> > +		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> > +	.endm
> > +
> > +#endif	/* __ASM_ASSEMBLER_H */
> > diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
> > index aafcca58c19d..74a8fab8e0f6 100644
> > --- a/arch/riscv/kernel/suspend_entry.S
> > +++ b/arch/riscv/kernel/suspend_entry.S
> > @@ -7,6 +7,7 @@
> >  #include <linux/linkage.h>
> >  #include <asm/asm.h>
> >  #include <asm/asm-offsets.h>
> > +#include <asm/assembler.h>
> >  #include <asm/csr.h>
> >  #include <asm/xip_fixup.h>
> >
> > @@ -83,39 +84,10 @@ ENTRY(__cpu_resume_enter)
> >  	add	a0, a1, zero
> >
> >  	/* Restore CSRs */
> > -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> > -	csrw	CSR_EPC, t0
> > -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> > -	csrw	CSR_STATUS, t0
> > -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> > -	csrw	CSR_TVAL, t0
> > -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> > -	csrw	CSR_CAUSE, t0
> > +	restore_csr
> >
> >  	/* Restore registers (except A0 and T0-T6) */
> > -	REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> > -	REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> > -	REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> > -	REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> > -	REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> > -	REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> > -	REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> > -	REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> > -	REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> > -	REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> > -	REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> > -	REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> > -	REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> > -	REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> > -	REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> > -	REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> > -	REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> > -	REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> > -	REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> > -	REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> > -	REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> > -	REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> > -	REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> > +	restore_reg
> >
> >  	/* Return zero value */
> >  	add	a0, zero, zero
> > --
> > 2.34.1
> >
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
noted with thanks
> 
> Thanks,
> drew

