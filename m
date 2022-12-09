Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5615B647C87
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 04:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbiLIDPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:15:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiLIDPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:15:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 320277D065
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:15:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E4041B821FB
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:15:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9537C433F1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670555732;
        bh=LQSXaM6jsUeRyu1fvBXbONXa1UuWroih+AhdrvfCeec=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QUMSvhCkZAq7GpU4cBUgA6ZRI0mgaipm9QMkkIzlRiJcdLKUhIBocuhAF4y0nIn1f
         0kEE8pqQt9MvRoX3vqi14DrPZqaHrEEaNgm9+PQ7nNTXibX4rRaaNFWrbrxKNTYRYc
         I5qDFpFX3xMxVgy1+hzSvGUzrzpqEITFq72U+fr6Sjo8fHCsHJZoCYnjGPUb0mpPYj
         RLillCzUxNjdgG/Zvic56PWMeRlmO6tcC1X1593PXOnVO/LOlQ7hW7RDWXmfBCjy3T
         /XcW+nj46WOmeCKKr8TXAbt7Qk2lVJ48u5iAfunMXat0LWlgtCAza8RRyh9n0MhndW
         fNe0Gs9gyGDlg==
Received: by mail-ed1-f43.google.com with SMTP id a16so1441865edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 19:15:32 -0800 (PST)
X-Gm-Message-State: ANoB5pkXmBw8nZHmc38hrjK8Upnu7P6KaiQGD5Q85vFXxwA/42EDgNYj
        XjlvW1MO25SzXz1GM0si+FTByJ7sQ63SanrcqAQ=
X-Google-Smtp-Source: AA0mqf7EgxO76n65NAOGalkbWRlByFjxkTcPrf2dAK+qri5Wie6OqTWRGnIxP6H8/22GUzFxjMdBiUhWDuC1LJ65z0w=
X-Received: by 2002:aa7:c046:0:b0:461:54f0:f7dc with SMTP id
 k6-20020aa7c046000000b0046154f0f7dcmr84312488edo.117.1670555730907; Thu, 08
 Dec 2022 19:15:30 -0800 (PST)
MIME-Version: 1.0
References: <Y3fxsWPLPlKGfMBj@curiosity> <mhng-1d55338a-53a1-42eb-bf5c-91655fde2734@palmer-ri-x1c9a>
 <CAJF2gTQqF8GG77SKm9MpJC28DQebHsjuSoD_+FRRV0GcKpQFCg@mail.gmail.com>
In-Reply-To: <CAJF2gTQqF8GG77SKm9MpJC28DQebHsjuSoD_+FRRV0GcKpQFCg@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 9 Dec 2022 11:15:19 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQzVabqr4GSaqXzTLXGriUj4iVLMYDt_iYuv8_YApo+Fw@mail.gmail.com>
Message-ID: <CAJF2gTQzVabqr4GSaqXzTLXGriUj4iVLMYDt_iYuv8_YApo+Fw@mail.gmail.com>
Subject: Re: [PATCH V3] riscv: asid: Fixup stale TLB entry cause application crash
To:     Palmer Dabbelt <palmer@rivosinc.com>, geomatsi@gmail.com,
        philipp.tomsich@vrull.eu, Paul Walmsley <paul.walmsley@sifive.com>,
        anup@brainfault.org
Cc:     Conor Dooley <conor.dooley@microchip.com>, heiko@sntech.de,
        alex@ghiti.fr, Christoph Hellwig <hch@lst.de>,
        ajones@ventanamicro.com, gary@garyguo.net, jszhang@kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@linux.alibaba.com, apatel@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 9, 2022 at 11:13 AM Guo Ren <guoren@kernel.org> wrote:
>
> On Fri, Dec 9, 2022 at 7:30 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
> >
> > On Fri, 18 Nov 2022 12:57:21 PST (-0800), geomatsi@gmail.com wrote:
> > > Hi Guo Ren,
> > >
> > >
> > >> After use_asid_allocator is enabled, the userspace application will
> > >> crash by stale TLB entries. Because only using cpumask_clear_cpu without
> > >> local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> > >> Then set_mm_asid would cause the user space application to get a stale
> > >> value by stale TLB entry, but set_mm_noasid is okay.
> > >
> > > ... [snip]
> > >
> > >> +    /*
> > >> +     * The mm_cpumask indicates which harts' TLBs contain the virtual
> > >> +     * address mapping of the mm. Compared to noasid, using asid
> > >> +     * can't guarantee that stale TLB entries are invalidated because
> > >> +     * the asid mechanism wouldn't flush TLB for every switch_mm for
> > >> +     * performance. So when using asid, keep all CPUs footmarks in
> > >> +     * cpumask() until mm reset.
> > >> +     */
> > >> +    cpumask_set_cpu(cpu, mm_cpumask(next));
> > >> +    if (static_branch_unlikely(&use_asid_allocator)) {
> > >> +            set_mm_asid(next, cpu);
> > >> +    } else {
> > >> +            cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > >> +            set_mm_noasid(next);
> > >> +    }
> > >>  }
> > >
> > > I observe similar user-space crashes on my SMP systems with enabled ASID.
> > > My attempt to fix the issue was a bit different, see the following patch:
> > >
> > > https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/
> > >
> > > In brief, the idea was borrowed from flush_icache_mm handling:
> > > - keep track of CPUs not running the task
> > > - perform per-ASID TLB flush on such CPUs only if the task is switched there
> >
> > That way looks better to me: leaking hartids in the ASID allocator might
> > make the crashes go away, but it's just going to end up trending towards
> > flushing everything and that doesn't seem like the right long-term
> > solution.
> The penalty in switch_mm is too heavy!!!
>  - If the system has multiple NUMA nodes, it will cause switch_mm_fast
> flush unnecessary harts.
>  - If flush_range is just 1 entry, it would case flush_tlb_all_asid.
>
> switch_mm_fast:
>         csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
>                   ((cntx & asid_mask) << SATP_ASID_SHIFT) |
>                   satp_mode);
>
>         if (need_flush_tlb)
>                 local_flush_tlb_all();
> +#ifdef CONFIG_SMP
> +        else {
> +                cpumask_t *mask = &mm->context.tlb_stale_mask;+
> +
> +               if (cpumask_test_cpu(cpu, mask)) {
> +                        cpumask_clear_cpu(cpu, mask);
> +                        local_flush_tlb_all_asid(cntx & asid_mask);
> // penalty in switch_mm fast path
> +                }
> +        }
> +#endif
>
> And See:
>  static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
>                                   unsigned long size, unsigned long stride)
>  {
> +       struct cpumask *pmask = &mm->context.tlb_stale_mask;
>         struct cpumask *cmask = mm_cpumask(mm);
>         unsigned int cpuid;
>         bool broadcast;
> @@ -44,6 +29,15 @@ static void __sbi_tlb_flush_range(struct mm_struct
> *mm, unsigned long start,
>         if (static_branch_unlikely(&use_asid_allocator)) {
>                 unsigned long asid = atomic_long_read(&mm->context.id);
>
> +               /*
> +                * TLB will be immediately flushed on harts concurrently
> +                * executing this MM context. TLB flush on other harts
> +                * is deferred until this MM context migrates there.
> +                */
> +               cpumask_setall(pmask);
>                  ^^^^^^^^^^^^^^^^^^^^^^^ It would flush all harts for
> all NUMA nodes!!! Most of them deferred to switch_mm_fast. The penalty
> contains unnecessary harts!
> +               cpumask_clear_cpu(cpuid, pmask);
> +               cpumask_andnot(pmask, pmask, cmask);
>
> Please reconsider a bit, and make a smart decision. Just penalty the
> harts who touched the mm, not all. And only flush the whole TLB when
                                                           ^^^^ ^^^^ Don't
> some entries are needed.
>
> The __sbi_tlb_flush_range is the slow path; keeping the fast path
> performance is worth more than improving a slow one.
>
> >
> > So I've got that one on for-next, sorry I missed it before.
> >
> > Thanks!
> >
> > >
> > > Your patch also works fine in my tests fixing those crashes. I have a
> > > question though, regarding removed cpumask_clear_cpu. How CPUs no more
> > > running the task are removed from its mm_cpumask ? If they are not
> > > removed, then flush_tlb_mm/flush_tlb_page will broadcast unnecessary
> > > TLB flushes to those CPUs when ASID is enabled.
> > >
> > > Regards,
> > > Sergey
>
>
>
> --
> Best Regards
>  Guo Ren



-- 
Best Regards
 Guo Ren
