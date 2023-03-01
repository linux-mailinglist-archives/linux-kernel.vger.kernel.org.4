Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFB6A6B8E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 12:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjCALRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 06:17:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCALRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 06:17:41 -0500
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092B43B666
        for <linux-kernel@vger.kernel.org>; Wed,  1 Mar 2023 03:17:37 -0800 (PST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 321BHUJK055101;
        Wed, 1 Mar 2023 19:17:30 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from APC323 (10.0.12.101) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Wed, 1 Mar 2023 19:17:28 +0800
Date:   Wed, 1 Mar 2023 19:17:53 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     Alexandre Ghiti <alex@ghiti.fr>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <liushixin2@huawei.com>, <x5710999x@gmail.com>,
        <bjorn@rivosinc.com>, <abrestic@rivosinc.com>, <peterx@redhat.com>,
        <hanchuanhua@oppo.com>, <apopple@nvidia.com>, <hca@linux.ibm.com>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <tim609@andestech.com>,
        <peterlin@andestech.com>, <ycliang@andestech.com>
Subject: Re: [PATCH] RISC-V: mm: Support huge page in vmalloc_fault()
Message-ID: <Y/80YZOMce2cgITi@APC323>
References: <20230224104001.2743135-1-dylan@andestech.com>
 <8adb9dcb-621a-0392-9ccd-0117345636ec@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8adb9dcb-621a-0392-9ccd-0117345636ec@ghiti.fr>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Originating-IP: [10.0.12.101]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 321BHUJK055101
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 24, 2023 at 01:47:20PM +0100, Alexandre Ghiti wrote:
> Hi Dylan,
> 
> On 2/24/23 11:40, Dylan Jhong wrote:
> > RISC-V supports ioremap() with huge page (pud/pmd) mapping, but
> > vmalloc_fault() assumes that the vmalloc range is limited to pte
> > mappings. Add huge page support to complete the vmalloc_fault()
> > function.
> > 
> > Fixes: 310f541a027b ("riscv: Enable HAVE_ARCH_HUGE_VMAP for 64BIT")
> > 
> > Signed-off-by: Dylan Jhong <dylan@andestech.com>
> > ---
> >   arch/riscv/mm/fault.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/arch/riscv/mm/fault.c b/arch/riscv/mm/fault.c
> > index eb0774d9c03b..4b9953b47d81 100644
> > --- a/arch/riscv/mm/fault.c
> > +++ b/arch/riscv/mm/fault.c
> > @@ -143,6 +143,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
> >   		no_context(regs, addr);
> >   		return;
> >   	}
> > +	if (pud_leaf(*pud_k))
> > +		goto flush_tlb;
> >   	/*
> >   	 * Since the vmalloc area is global, it is unnecessary
> > @@ -153,6 +155,8 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
> >   		no_context(regs, addr);
> >   		return;
> >   	}
> > +	if (pmd_leaf(*pmd_k))
> > +		goto flush_tlb;
> >   	/*
> >   	 * Make sure the actual PTE exists as well to
> > @@ -172,6 +176,7 @@ static inline void vmalloc_fault(struct pt_regs *regs, int code, unsigned long a
> >   	 * ordering constraint, not a cache flush; it is
> >   	 * necessary even after writing invalid entries.
> >   	 */
> > +flush_tlb:
> >   	local_flush_tlb_page(addr);
> >   }
> 
> 
> This looks good to me, you can add:
> 
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> One question: how did you encounter this bug?
> 
> Thanks,
> 
> Alex
>
Hi Alex,

>>> One question: how did you encounter this bug?
This bug is caused by the combination of out-of-order excutiuon and ioremap().
The OoO excution will try to access the VA that is given by ioremap() and record
a page fault in TLB before the mapping is created in ioremap(). When the CPU
really accesses the VA after ioremap(), the CPU will trigger page fault because
of the TLB already has the VA mapping.

We hope that the vmalloc_fault() in page fault handler will trigger sfence.vma
to invalidate the TLB[1]. But since we do not support the huge page in vmalloc_fault(),
we encountered the nested page faults in vmalloc_fault() while forcing the pmd/pud
huge pages to resolve pte entry. This is the reason I send this patch.

ref:
    [1]: https://patchwork.kernel.org/project/linux-riscv/patch/20210412000531.12249-1-liu@jiuyang.me/

