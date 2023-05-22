Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 438DA70B2AE
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjEVBLQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 May 2023 21:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjEVBLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:11:14 -0400
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECE8CD
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 18:11:12 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 163AF24DDB2;
        Mon, 22 May 2023 09:11:10 +0800 (CST)
Received: from EXMBX167.cuchost.com (172.16.6.77) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 22 May
 2023 09:11:10 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX167.cuchost.com
 (172.16.6.77) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 22 May
 2023 09:11:09 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Mon, 22 May 2023 09:11:09 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>
CC:     Song Shuai <suagrfillet@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        "ajones@ventanamicro.com" <ajones@ventanamicro.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Song Shuai <songshuaishuai@tinylab.org>
Subject: RE: [PATCH] riscv: hibernation: Remove duplicate call of
 suspend_restore_csrs
Thread-Topic: [PATCH] riscv: hibernation: Remove duplicate call of
 suspend_restore_csrs
Thread-Index: AQHZij0JnSRR82RN7UivChxgOm4HvK9hcVtQ//9+BoCAAJELgIAD/mKg
Date:   Mon, 22 May 2023 01:11:09 +0000
Message-ID: <dc21929555a3422d883047a3e652b15d@EXMBX066.cuchost.com>
References: <20230519102908.253458-1-suagrfillet@gmail.com>
 <9a274a44b61345e8aba747a44250c4d8@EXMBX066.cuchost.com>
 <20230519-clarinet-collar-ba2c0fa37e11@wendy>
 <20230519-roundup-legwarmer-e26b31db3123@spud>
In-Reply-To: <20230519-roundup-legwarmer-e26b31db3123@spud>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Saturday, May 20, 2023 4:07 AM
> To: Conor Dooley <conor.dooley@microchip.com>
> Cc: JeeHeng Sia <jeeheng.sia@starfivetech.com>; Song Shuai <suagrfillet@gmail.com>; paul.walmsley@sifive.com;
> palmer@dabbelt.com; aou@eecs.berkeley.edu; Mason Huo <mason.huo@starfivetech.com>; Leyfoon Tan
> <leyfoon.tan@starfivetech.com>; ajones@ventanamicro.com; linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Song
> Shuai <songshuaishuai@tinylab.org>
> Subject: Re: [PATCH] riscv: hibernation: Remove duplicate call of suspend_restore_csrs
> 
> On Fri, May 19, 2023 at 12:28:07PM +0100, Conor Dooley wrote:
> > Hey,
> >
> > On Fri, May 19, 2023 at 11:14:27AM +0000, JeeHeng Sia wrote:
> >
> > > > The suspend_restore_csrs is called in both __hibernate_cpu_resume
> > > > and the `else` of subsequent swsusp_arch_suspend.
> > > >
> > > > Removing the first call makes both suspend_{save,restore}_csrs
> > > > left in swsusp_arch_suspend for clean code.
> 
> It took me embarrassingly long to wrap my head around the control flow
> here again. I'm not sure that I agree with you that splitting the calls
> between asm & c is cleaner, but whatever:
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 
> > > >
> > > > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > > > Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> >
> > BTW, why the two email addresses? The tinylab one here seems entirely
> > redundant - unless it is your employer, in which case should it be the
> > only SoB address & also in the author field?
> 
> Deja vu with my questioning your email address, but does your
> tinylab address actually repeat "shuai"?
> 
> > Also, Fixes tag?
> >
> > > > ---
> > > >  arch/riscv/kernel/hibernate-asm.S | 1 -
> > > >  1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> > > > index 5c76671c7e15..d698dd7df637 100644
> > > > --- a/arch/riscv/kernel/hibernate-asm.S
> > > > +++ b/arch/riscv/kernel/hibernate-asm.S
> > > > @@ -28,7 +28,6 @@ ENTRY(__hibernate_cpu_resume)
> > > >
> > > >  	REG_L	a0, hibernate_cpu_context
> > > >
> > > > -	suspend_restore_csrs
> > > >  	suspend_restore_regs
> >
> > > Good catch. This function is invoked twice to restore the CSRs.
> > > I am good with removing this function from here.
> >
> > If that's a review, then please either give an R-b or A-b tag :)
Reviewed-by: JeeHeng Sia <jeeheng.sia@starfivetech.com >
> >
> > Thanks,
> > Conor.
> 

