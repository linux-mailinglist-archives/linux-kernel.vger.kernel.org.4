Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BDD66A14A0
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 02:34:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbjBXBeV convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Feb 2023 20:34:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjBXBeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 20:34:13 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A83139CC7
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 17:34:00 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 2849624E240;
        Fri, 24 Feb 2023 09:33:59 +0800 (CST)
Received: from EXMBX063.cuchost.com (172.16.7.63) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 09:33:59 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX063.cuchost.com
 (172.16.7.63) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 24 Feb
 2023 09:33:58 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Fri, 24 Feb 2023 09:33:58 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Andrew Jones <ajones@ventanamicro.com>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v4 3/4] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Thread-Topic: [PATCH v4 3/4] RISC-V: mm: Enable huge page support to
 kernel_page_present() function
Thread-Index: AQHZRZ0wRsS1rJlvBEisTE2RNJ10DK7blsuAgAG+CwA=
Date:   Fri, 24 Feb 2023 01:33:58 +0000
Message-ID: <4c2190ee0e1f4995b1c2cfa87f67661a@EXMBX066.cuchost.com>
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-4-jeeheng.sia@starfivetech.com>
 <20230223065717.zmlf2gxmtsgqperw@orel>
In-Reply-To: <20230223065717.zmlf2gxmtsgqperw@orel>
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
> Sent: Thursday, 23 February, 2023 2:57 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: Re: [PATCH v4 3/4] RISC-V: mm: Enable huge page support to kernel_page_present() function
> 
> On Tue, Feb 21, 2023 at 10:35:22AM +0800, Sia Jee Heng wrote:
> > Currently kernel_page_present() function doesn't support huge page
> > detection causes the function to mistakenly return false to the
> > hibernation core.
> >
> > Add huge page detection to the function to solve the problem.
> >
> > Fixes tag: commit 9e953cda5cdf ("riscv:
> > Introduce huge page support for 32/64bit kernel")
> 
> This should be formatted as below (no line wrap and no 'tag' in the tag)
> 
> Fixes: 9e953cda5cdf ("riscv: Introduce huge page support for 32/64bit kernel")
> 
> >
> > Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> > Reviewed-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > ---
> >  arch/riscv/mm/pageattr.c | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/arch/riscv/mm/pageattr.c b/arch/riscv/mm/pageattr.c
> > index 86c56616e5de..ea3d61de065b 100644
> > --- a/arch/riscv/mm/pageattr.c
> > +++ b/arch/riscv/mm/pageattr.c
> > @@ -217,18 +217,26 @@ bool kernel_page_present(struct page *page)
> >  	pgd = pgd_offset_k(addr);
> >  	if (!pgd_present(*pgd))
> >  		return false;
> > +	if (pgd_leaf(*pgd))
> > +		return true;
> >
> >  	p4d = p4d_offset(pgd, addr);
> >  	if (!p4d_present(*p4d))
> >  		return false;
> > +	if (p4d_leaf(*p4d))
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
> >
> 
> Otherwise,
> 
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
noted with thanks
> 
> Thanks,
> drew
