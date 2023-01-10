Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E64A663976
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 07:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjAJGp1 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 10 Jan 2023 01:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjAJGpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 01:45:24 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CED1CE26
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 22:45:21 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8A8A224E217;
        Tue, 10 Jan 2023 14:45:19 +0800 (CST)
Received: from EXMBX162.cuchost.com (172.16.6.72) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 14:45:19 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX162.cuchost.com
 (172.16.6.72) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 10 Jan
 2023 14:45:19 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 10 Jan 2023 14:45:19 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v2 2/3] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Thread-Topic: [PATCH v2 2/3] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Thread-Index: AQHZI/MEyk4BWxsDWk+SJDmuy1TBsK6VpAGAgAGQfoA=
Date:   Tue, 10 Jan 2023 06:45:19 +0000
Message-ID: <62163664add9493db394c8ca45b73ce2@EXMBX066.cuchost.com>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-3-jeeheng.sia@starfivetech.com>
 <20230109144525.4xgnpeb6zcyyvx4j@orel>
In-Reply-To: <20230109144525.4xgnpeb6zcyyvx4j@orel>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [60.49.128.133]
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
> Sent: Monday, 9 January, 2023 10:45 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com;
> aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>;
> Mason Huo <mason.huo@starfivetech.com>
> Subject: Re: [PATCH v2 2/3] RISC-V: mm: Enable huge page support to
> kernel_page_present() function
> 
> On Mon, Jan 09, 2023 at 02:24:06PM +0800, Sia Jee Heng wrote:
> > Currently kernel_page_present() function doesn't support huge page
> > detection causes the function to mistakenly return false to the
> > hibernation core.
> >
> > Add huge page detection to the function to solve the problem.
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > ---
> >  arch/riscv/mm/pageattr.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> > index 86c56616e5de..73fdec8c0a72 100644
> > --- a/arch/riscv/mm/pageattr.c
> > +++ b/arch/riscv/mm/pageattr.c
> > @@ -221,14 +221,20 @@ bool kernel_page_present(struct page *page)
> >  	p4d = p4d_offset(pgd, addr);
> >  	if (!p4d_present(*p4d))
> >  		return false;
> > +	if (p4d_leaf(*pud))
>                       ^ p4d
> 
> I guess you got lucky with the stack garbage in your testing.
You are right. But the reason it is added here is because kernel page table walk is checking for the p4d_leaf as well. 
For example: walk_p4d_range() in the mm/pagewalk.c. So, I just trying to make it consistent to the Kernel page table walk mechanism.
Should I remove it?
> 
> > +		return true;
> >
> >  	pud = pud_offset(p4d, addr);
> >  	if (!pud_present(*pud))
> >  		return false;
> > +	if (pud_leaf(*pud))
> > +		return true;
> >
> >  	pmd = pmd_offset(pud, addr);
> >  	if (!pmd_present(*pmd))
> >  		return false;
> > +	if (pmd_leaf(*pmd))
> > +		return true;
> >
> >  	pte = pte_offset_kernel(pmd, addr);
> >  	return pte_present(*pte);
> > --
> > 2.34.1
> >
> 
> Thanks,
> drew
