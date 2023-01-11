Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C28665330
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 06:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbjAKFM4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Jan 2023 00:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbjAKFMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 00:12:01 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354D7FCE9
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 21:06:03 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id 8B56624E1A6;
        Wed, 11 Jan 2023 13:05:17 +0800 (CST)
Received: from EXMBX167.cuchost.com (172.16.6.77) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Jan
 2023 13:05:17 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX167.cuchost.com
 (172.16.6.77) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 11 Jan
 2023 13:05:16 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Wed, 11 Jan 2023 13:05:17 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Conor Dooley <conor@kernel.org>
CC:     Andrew Jones <ajones@ventanamicro.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH v2 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZI/MH11WdbApPuUeV8qMdKhtSOK6V9U4AgAFQMgCAAE7gAIABF1UA
Date:   Wed, 11 Jan 2023 05:05:16 +0000
Message-ID: <6952df4474b54a31894d71e7cfe6077a@EXMBX066.cuchost.com>
References: <20230109062407.3235-1-jeeheng.sia@starfivetech.com>
 <20230109062407.3235-4-jeeheng.sia@starfivetech.com>
 <20230109193624.iiuguwgimpn7zbyw@orel>
 <6638291f6a3c463994919ba0a875472c@EXMBX066.cuchost.com>
 <Y73I6H+X+qswIst0@spud>
In-Reply-To: <Y73I6H+X+qswIst0@spud>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Conor Dooley <conor@kernel.org>
> Sent: Wednesday, 11 January, 2023 4:22 AM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: Andrew Jones <ajones@ventanamicro.com>; paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-
> riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo
> <mason.huo@starfivetech.com>
> Subject: Re: [PATCH v2 3/3] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
> Hey JeeHeng,
> 
> On Tue, Jan 10, 2023 at 08:37:01AM +0000, JeeHeng Sia wrote:
> > > From: Andrew Jones <ajones@ventanamicro.com>
> > > On Mon, Jan 09, 2023 at 02:24:07PM +0800, Sia Jee Heng wrote:
> 
> > > > +/* Helper parameters that help us to restore the image.
> > >
> > > Separate line for /*
> > ok
> 
> I'm not sure why this one struct has an actual description that
> resembles kerneldoc, when nothing else does - but why not make it
> actually kerneldoc, as you're almost there as things stand:
> https://docs.kernel.org/doc-guide/kernel-doc.html#structure-union-and-enumeration-documentation
Thanks. This is a good info, will work on it.
> 
> > > > + * @hartid: To make sure same boot_cpu executing the hibernate/restore
> > > code.
> > > > + * @saved_satp: Original page table used by the hibernated image.
> > > > + * @restore_cpu_addr: The kernel's image address to restore the CPU
> > > context.
> 
> ^^ also your mail client is doing some really odd things wrapping wise.
Oops. Hope I have fixed it in this round..
> 
> > > > +static unsigned long temp_pgtable_map_pmd(pmd_t *pmdp, unsigned
> > > long vaddr, pgprot_t prot)
> > > > +{
> > > > +	uintptr_t pmd_idx = pmd_index(vaddr);
> > > > +	pte_t *ptep;
> > > > +
> > > > +	if (pmd_none(pmdp[pmd_idx])) {
> > > > +		ptep = (pte_t *) get_safe_page(GFP_ATOMIC);
> > >
> > > No space between cast and function. Same comment for following functions.
> > > I thought checkpatch complained about that.
> > Ok. But it is weird that checkpatch doesn't report the issue.
> 
> It does:
ok, will double check again.
> 20:08:17 conor /stuff/linux$ ./scripts/checkpatch.pl --strict --terse -g HEAD~3..HEAD
> 7481f133eb0310496742c27d15a20fdd2c499d29:97: CHECK: Alignment should match open parenthesis
> [...]
> 7481f133eb0310496742c27d15a20fdd2c499d29:370: CHECK: No space is necessary after a cast
> [...]
> 7481f133eb0310496742c27d15a20fdd2c499d29:460: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:467: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:475: CHECK: Blank lines aren't necessary after an open brace '{'
> 7481f133eb0310496742c27d15a20fdd2c499d29:480: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:487: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:499: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:506: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:518: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:525: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:577: CHECK: No space is necessary after a cast
> 7481f133eb0310496742c27d15a20fdd2c499d29:591: CHECK: Alignment should match open parenthesis
> 7481f133eb0310496742c27d15a20fdd2c499d29:596: CHECK: Alignment should match open parenthesis
> total: 0 errors, 1 warnings, 21 checks, 545 lines checked
> 
> The patchwork automation seems to have ignored this patchset for some
> reason. It was stuck on a patchset for some reason and this one may
> have got skipped when I tried to sort that out.
> Ordinarily, you'd see it complaining about these sorts of things.
> 
> Thanks,
> Conor.

