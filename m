Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04ADA6A149D
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjBXBdo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Feb 2023 20:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjBXBdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:33:42 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42F7298C6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:33:29 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2A76B24E24E;
        Fri, 24 Feb 2023 09:33:17 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 09:33:17 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 09:33:16 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 24 Feb 2023 09:33:16 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: RE: [PATCH v4 1/4] RISC-V: Change suspend_save_csrs and
 suspend_restore_csrs to public function
Thread-Topic: [PATCH v4 1/4] RISC-V: Change suspend_save_csrs and
 suspend_restore_csrs to public function
Thread-Index: AQHZRZ0s27ZIes8WRE6urFHZP2L6bK7bkdoAgAHCyCA=
Date:   Fri, 24 Feb 2023 01:33:16 +0000
Message-ID: <e2a0b59ebe464d79af30a16bd1075f3d@EXMBX066.cuchost.com>
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-2-jeeheng.sia@starfivetech.com>
 <20230223063936.6tsqh57lom3tvjxo@orel>
In-Reply-To: <20230223063936.6tsqh57lom3tvjxo@orel>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Andrew Jones <ajones@ventanamicro.com>
> Sent: Thursday, 23 February, 2023 2:40 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>; Conor Dooley
> <conor.dooley@microchip.com>
> Subject: Re: [PATCH v4 1/4] RISC-V: Change suspend_save_csrs and suspend_restore_csrs to public function
> 
> On Tue, Feb 21, 2023 at 10:35:20AM +0800, Sia Jee Heng wrote:
> > Currently suspend_save_csrs() and suspend_restore_csrs() functions are
> > statically defined in the suspend.c. Change the function's attribute
> > to public so that the functions can be used by hibernation as well.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> > ---
> >  arch/riscv/include/asm/suspend.h | 3 +++
> >  arch/riscv/kernel/suspend.c      | 4 ++--
> >  2 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/suspend.h b/arch/riscv/include/asm/suspend.h
> > index 8be391c2aecb..75419c5ca272 100644
> > --- a/arch/riscv/include/asm/suspend.h
> > +++ b/arch/riscv/include/asm/suspend.h
> > @@ -33,4 +33,7 @@ int cpu_suspend(unsigned long arg,
> >  /* Low-level CPU resume entry function */
> >  int __cpu_resume_enter(unsigned long hartid, unsigned long context);
> >
> > +/* Used to save and restore the csr */
> 
> s/the csr/CSRs/
> 
> > +void suspend_save_csrs(struct suspend_context *context);
> > +void suspend_restore_csrs(struct suspend_context *context);
> >  #endif
> > diff --git a/arch/riscv/kernel/suspend.c b/arch/riscv/kernel/suspend.c
> > index 9ba24fb8cc93..3c89b8ec69c4 100644
> > --- a/arch/riscv/kernel/suspend.c
> > +++ b/arch/riscv/kernel/suspend.c
> > @@ -8,7 +8,7 @@
> >  #include <asm/csr.h>
> >  #include <asm/suspend.h>
> >
> > -static void suspend_save_csrs(struct suspend_context *context)
> > +void suspend_save_csrs(struct suspend_context *context)
> >  {
> >  	context->scratch = csr_read(CSR_SCRATCH);
> >  	context->tvec = csr_read(CSR_TVEC);
> > @@ -29,7 +29,7 @@ static void suspend_save_csrs(struct suspend_context *context)
> >  #endif
> >  }
> >
> > -static void suspend_restore_csrs(struct suspend_context *context)
> > +void suspend_restore_csrs(struct suspend_context *context)
> >  {
> >  	csr_write(CSR_SCRATCH, context->scratch);
> >  	csr_write(CSR_TVEC, context->tvec);
> > --
> > 2.34.1
> >
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
Noted with thanks
> 
> Thanks,
> drew
