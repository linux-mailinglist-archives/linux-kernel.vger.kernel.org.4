Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AB76B6DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 04:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbjCMDcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 23:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjCMDcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 23:32:18 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7430EB6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 20:32:15 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 32D3W50e044563;
        Mon, 13 Mar 2023 11:32:05 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from APC323 (10.0.12.101) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Mon, 13 Mar 2023 11:32:03 +0800
Date:   Mon, 13 Mar 2023 11:32:27 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     Guo Ren <guoren@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <sergey.matyukevich@syntacore.com>, <aou@eecs.berkeley.edu>,
        <palmer@dabbelt.com>, <paul.walmsley@sifive.com>,
        <x5710999x@gmail.com>, <tim609@andestech.com>,
        <peterlin@andestech.com>, <ycliang@andestech.com>
Subject: Re: [PATCH] riscv: mm: Fix incorrect ASID argument when flushing TLB
Message-ID: <ZA6ZS3hIXWR9PeXV@APC323>
References: <20230310103144.396214-1-dylan@andestech.com>
 <CAJF2gTTwEJNmee7TcbdbcmLQKTTWpokrUST4xanyreUJHxETqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJF2gTTwEJNmee7TcbdbcmLQKTTWpokrUST4xanyreUJHxETqg@mail.gmail.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Originating-IP: [10.0.12.101]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 32D3W50e044563
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 08:40:59PM +0800, Guo Ren wrote:
> On Fri, Mar 10, 2023 at 6:32 PM Dylan Jhong <dylan@andestech.com> wrote:
> >
> > Currently, we pass the CONTEXTID instead of the ASID to the TLB flush
> > function. We should only take the ASID field to prevent from touching
> > the reserved bit field.
> >
> > Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> > Signed-off-by: Dylan Jhong <dylan@andestech.com>
> > ---
> >  arch/riscv/include/asm/tlbflush.h | 2 ++
> >  arch/riscv/mm/context.c           | 3 ++-
> >  arch/riscv/mm/tlbflush.c          | 2 +-
> >  3 files changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> > index 907b9efd39a8..597d6d8aec28 100644
> > --- a/arch/riscv/include/asm/tlbflush.h
> > +++ b/arch/riscv/include/asm/tlbflush.h
> > @@ -12,6 +12,8 @@
> >  #include <asm/errata_list.h>
> >
> >  #ifdef CONFIG_MMU
> > +extern unsigned long asid_mask;
> > +
> >  static inline void local_flush_tlb_all(void)
> >  {
> >         __asm__ __volatile__ ("sfence.vma" : : : "memory");
> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 80ce9caba8d2..a6b76b33e377 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -22,7 +22,8 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> >
> >  static unsigned long asid_bits;
> >  static unsigned long num_asids;
> > -static unsigned long asid_mask;
> > +unsigned long asid_mask;
> > +EXPORT_SYMBOL(asid_mask);
> Why EXPORT_SYMBOL? (No module would use it by your patch.)
>
OK. I'll remove EXPORT_SYMBOL in v2.
Thanks.

> >
> >  static atomic_long_t current_version;
> >
> > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > index ce7dfc81bb3f..ba4c27187c95 100644
> > --- a/arch/riscv/mm/tlbflush.c
> > +++ b/arch/riscv/mm/tlbflush.c
> > @@ -27,7 +27,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
> >         /* check if the tlbflush needs to be sent to other CPUs */
> >         broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> >         if (static_branch_unlikely(&use_asid_allocator)) {
> > -               unsigned long asid = atomic_long_read(&mm->context.id);
> > +               unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
> >
> >                 /*
> >                  * TLB will be immediately flushed on harts concurrently
> > --
> > 2.34.1
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
