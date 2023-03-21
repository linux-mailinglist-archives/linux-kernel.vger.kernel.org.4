Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04ED6C284E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 03:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjCUCnO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 22:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbjCUCnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 22:43:11 -0400
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7029E197
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 19:43:07 -0700 (PDT)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
        by Atcsqr.andestech.com with ESMTP id 32L2gFuL055035;
        Tue, 21 Mar 2023 10:42:15 +0800 (+08)
        (envelope-from dylan@andestech.com)
Received: from APC323 (10.0.12.101) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Tue, 21 Mar 2023 10:42:14 +0800
Date:   Tue, 21 Mar 2023 10:42:37 +0800
From:   Dylan Jhong <dylan@andestech.com>
To:     Zong Li <zongbox@gmail.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <guoren@kernel.org>, <sergey.matyukevich@syntacore.com>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <x5710999x@gmail.com>,
        <tim609@andestech.com>, <peterlin@andestech.com>,
        <ycliang@andestech.com>, <alistair.francis@wdc.com>
Subject: Re: [PATCH v2] riscv: mm: Fix incorrect ASID argument when flushing
 TLB
Message-ID: <ZBkZnRG4FYqjGiLz@APC323>
References: <20230313034906.2401730-1-dylan@andestech.com>
 <CA+ZOyahmpKXq2K-VqKkfN8t5aLDwU-OvL46oj9nNpdm6ZU3qNQ@mail.gmail.com>
 <ZBAh4EY2RNLryzEW@APC323>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZBAh4EY2RNLryzEW@APC323>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Originating-IP: [10.0.12.101]
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL: Atcsqr.andestech.com 32L2gFuL055035
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 03:27:30PM +0800, Dylan Jhong wrote:
> On Tue, Mar 14, 2023 at 10:22:43AM +0800, Zong Li wrote:
> > Dylan Jhong <dylan@andestech.com> 於 2023年3月13日 週一 下午12:29寫道：
> > >
> > > Currently, we pass the CONTEXTID instead of the ASID to the TLB flush
> > > function. We should only take the ASID field to prevent from touching
> > > the reserved bit field.
> > >
> > > Fixes: 3f1e782998cd ("riscv: add ASID-based tlbflushing methods")
> > > Signed-off-by: Dylan Jhong <dylan@andestech.com>
> > > ---
> > 
> > Hi Dylan,
> > Thanks for your patch, if I remember correctly, there was a patch from
> > Alistair Francis did the similar fix. Perhaps we should track that
> > patch to see why it doesn't be merged. Thanks.
> > 
> > http://lists.infradead.org/pipermail/linux-riscv/2022-March/013558.html
> >
> Hi Zong,
> Thanks for the reminder, I didn't notice that Alistair had sent the same patch before.
> 
> Hi Palmer, Alistair
> http://lists.infradead.org/pipermail/linux-riscv/2022-March/013597.html
> This patch does not seem to be cherry-picked back to the released linux kernel,
> and I have not seen the v4 patch. May I ask how is the follow-up progress of this patch?
> 
> Best,
> Dylan
>

Hi Palmer,

Ping. Any update on this?

Best,
Dylan

> > > Changes from v2:
> > > - Remove unsued EXPORT_SYMBOL()
> > > ---
> > >  arch/riscv/include/asm/tlbflush.h | 2 ++
> > >  arch/riscv/mm/context.c           | 2 +-
> > >  arch/riscv/mm/tlbflush.c          | 2 +-
> > >  3 files changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/riscv/include/asm/tlbflush.h b/arch/riscv/include/asm/tlbflush.h
> > > index 907b9efd39a8..597d6d8aec28 100644
> > > --- a/arch/riscv/include/asm/tlbflush.h
> > > +++ b/arch/riscv/include/asm/tlbflush.h
> > > @@ -12,6 +12,8 @@
> > >  #include <asm/errata_list.h>
> > >
> > >  #ifdef CONFIG_MMU
> > > +extern unsigned long asid_mask;
> > > +
> > >  static inline void local_flush_tlb_all(void)
> > >  {
> > >         __asm__ __volatile__ ("sfence.vma" : : : "memory");
> > > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > > index 80ce9caba8d2..6d1aeb063e81 100644
> > > --- a/arch/riscv/mm/context.c
> > > +++ b/arch/riscv/mm/context.c
> > > @@ -22,7 +22,7 @@ DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> > >
> > >  static unsigned long asid_bits;
> > >  static unsigned long num_asids;
> > > -static unsigned long asid_mask;
> > > +unsigned long asid_mask;
> > >
> > >  static atomic_long_t current_version;
> > >
> > > diff --git a/arch/riscv/mm/tlbflush.c b/arch/riscv/mm/tlbflush.c
> > > index ce7dfc81bb3f..ba4c27187c95 100644
> > > --- a/arch/riscv/mm/tlbflush.c
> > > +++ b/arch/riscv/mm/tlbflush.c
> > > @@ -27,7 +27,7 @@ static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
> > >         /* check if the tlbflush needs to be sent to other CPUs */
> > >         broadcast = cpumask_any_but(cmask, cpuid) < nr_cpu_ids;
> > >         if (static_branch_unlikely(&use_asid_allocator)) {
> > > -               unsigned long asid = atomic_long_read(&mm->context.id);
> > > +               unsigned long asid = atomic_long_read(&mm->context.id) & asid_mask;
> > >
> > >                 /*
> > >                  * TLB will be immediately flushed on harts concurrently
> > > --
> > > 2.34.1
> > >
