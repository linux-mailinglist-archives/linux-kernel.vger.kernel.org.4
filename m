Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14FA0647C84
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 04:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiLIDNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 22:13:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiLIDNq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 22:13:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21010716E1
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 19:13:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0227B82780
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63760C433F2
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 03:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670555622;
        bh=x+9MrQMMOfSTvflWMJ+YfKIq/lzAfeXGJeLdsIAP3fs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bwphORUVbhRZlcJYegc5KIHzlojwm+TIe0e5QN9c1zeizXhSujyIYNOhK8qTsBHbD
         re8U0EJVP4cY9lRM+Fg2+vkOCNQJ71qzMSzMcU+cIEU3FVQMhAn9X29g7LzBHWH9jN
         tcSSa/9+42Hr0i9sOL0uvYPuMnOE5bc4mCZ3fNPJNad87+wApMuwY1uwVmGXgyXE6l
         xp8emKZ/HpsqCzouReH+8tNbHLOHtvKLklSklaplrJ0zsL7/1wCKGGFGJCk1ssC3JB
         5r26U3dND08rfeOZxivd5mS6zWoRHp8z8YAo4Yxip9IkNXyF6n0eBuhxxIIEkw68Ew
         iT+Urxw9PGiVA==
Received: by mail-ej1-f47.google.com with SMTP id ud5so8549817ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 19:13:42 -0800 (PST)
X-Gm-Message-State: ANoB5pkFu/MjZ8EXRMaUKNBEa+m5KBORyPiQGB7b6+6vEBN/ovrcbPnE
        fMovl9N3Qes7ftZ+4F6wUiZtEbbUwCQmcIyKZjQ=
X-Google-Smtp-Source: AA0mqf46N45tPba3FH4c8/5VKiowiVnhF8psDwbHD8oJxrSPlp44NQUMpaslqZTw59wcxYXGf93Q6V16adxCICV3DiM=
X-Received: by 2002:a17:906:ee2:b0:78d:3f96:b7aa with SMTP id
 x2-20020a1709060ee200b0078d3f96b7aamr64225763eji.74.1670555620457; Thu, 08
 Dec 2022 19:13:40 -0800 (PST)
MIME-Version: 1.0
References: <Y3fxsWPLPlKGfMBj@curiosity> <mhng-1d55338a-53a1-42eb-bf5c-91655fde2734@palmer-ri-x1c9a>
In-Reply-To: <mhng-1d55338a-53a1-42eb-bf5c-91655fde2734@palmer-ri-x1c9a>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 9 Dec 2022 11:13:28 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQqF8GG77SKm9MpJC28DQebHsjuSoD_+FRRV0GcKpQFCg@mail.gmail.com>
Message-ID: <CAJF2gTQqF8GG77SKm9MpJC28DQebHsjuSoD_+FRRV0GcKpQFCg@mail.gmail.com>
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

On Fri, Dec 9, 2022 at 7:30 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> On Fri, 18 Nov 2022 12:57:21 PST (-0800), geomatsi@gmail.com wrote:
> > Hi Guo Ren,
> >
> >
> >> After use_asid_allocator is enabled, the userspace application will
> >> crash by stale TLB entries. Because only using cpumask_clear_cpu without
> >> local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> >> Then set_mm_asid would cause the user space application to get a stale
> >> value by stale TLB entry, but set_mm_noasid is okay.
> >
> > ... [snip]
> >
> >> +    /*
> >> +     * The mm_cpumask indicates which harts' TLBs contain the virtual
> >> +     * address mapping of the mm. Compared to noasid, using asid
> >> +     * can't guarantee that stale TLB entries are invalidated because
> >> +     * the asid mechanism wouldn't flush TLB for every switch_mm for
> >> +     * performance. So when using asid, keep all CPUs footmarks in
> >> +     * cpumask() until mm reset.
> >> +     */
> >> +    cpumask_set_cpu(cpu, mm_cpumask(next));
> >> +    if (static_branch_unlikely(&use_asid_allocator)) {
> >> +            set_mm_asid(next, cpu);
> >> +    } else {
> >> +            cpumask_clear_cpu(cpu, mm_cpumask(prev));
> >> +            set_mm_noasid(next);
> >> +    }
> >>  }
> >
> > I observe similar user-space crashes on my SMP systems with enabled ASID.
> > My attempt to fix the issue was a bit different, see the following patch:
> >
> > https://lore.kernel.org/linux-riscv/20220829205219.283543-1-geomatsi@gmail.com/
> >
> > In brief, the idea was borrowed from flush_icache_mm handling:
> > - keep track of CPUs not running the task
> > - perform per-ASID TLB flush on such CPUs only if the task is switched there
>
> That way looks better to me: leaking hartids in the ASID allocator might
> make the crashes go away, but it's just going to end up trending towards
> flushing everything and that doesn't seem like the right long-term
> solution.
The penalty in switch_mm is too heavy!!!
 - If the system has multiple NUMA nodes, it will cause switch_mm_fast
flush unnecessary harts.
 - If flush_range is just 1 entry, it would case flush_tlb_all_asid.

switch_mm_fast:
        csr_write(CSR_SATP, virt_to_pfn(mm->pgd) |
                  ((cntx & asid_mask) << SATP_ASID_SHIFT) |
                  satp_mode);

        if (need_flush_tlb)
                local_flush_tlb_all();
+#ifdef CONFIG_SMP
+        else {
+                cpumask_t *mask = &mm->context.tlb_stale_mask;+
+
+               if (cpumask_test_cpu(cpu, mask)) {
+                        cpumask_clear_cpu(cpu, mask);
+                        local_flush_tlb_all_asid(cntx & asid_mask);
// penalty in switch_mm fast path
+                }
+        }
+#endif

And See:
 static void __sbi_tlb_flush_range(struct mm_struct *mm, unsigned long start,
                                  unsigned long size, unsigned long stride)
 {
+       struct cpumask *pmask = &mm->context.tlb_stale_mask;
        struct cpumask *cmask = mm_cpumask(mm);
        unsigned int cpuid;
        bool broadcast;
@@ -44,6 +29,15 @@ static void __sbi_tlb_flush_range(struct mm_struct
*mm, unsigned long start,
        if (static_branch_unlikely(&use_asid_allocator)) {
                unsigned long asid = atomic_long_read(&mm->context.id);

+               /*
+                * TLB will be immediately flushed on harts concurrently
+                * executing this MM context. TLB flush on other harts
+                * is deferred until this MM context migrates there.
+                */
+               cpumask_setall(pmask);
                 ^^^^^^^^^^^^^^^^^^^^^^^ It would flush all harts for
all NUMA nodes!!! Most of them deferred to switch_mm_fast. The penalty
contains unnecessary harts!
+               cpumask_clear_cpu(cpuid, pmask);
+               cpumask_andnot(pmask, pmask, cmask);

Please reconsider a bit, and make a smart decision. Just penalty the
harts who touched the mm, not all. And only flush the whole TLB when
some entries are needed.

The __sbi_tlb_flush_range is the slow path; keeping the fast path
performance is worth more than improving a slow one.

>
> So I've got that one on for-next, sorry I missed it before.
>
> Thanks!
>
> >
> > Your patch also works fine in my tests fixing those crashes. I have a
> > question though, regarding removed cpumask_clear_cpu. How CPUs no more
> > running the task are removed from its mm_cpumask ? If they are not
> > removed, then flush_tlb_mm/flush_tlb_page will broadcast unnecessary
> > TLB flushes to those CPUs when ASID is enabled.
> >
> > Regards,
> > Sergey



-- 
Best Regards
 Guo Ren
