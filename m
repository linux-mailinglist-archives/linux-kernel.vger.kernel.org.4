Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04D362392E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 02:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiKJBvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 20:51:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231298AbiKJBvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 20:51:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CF663C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 17:51:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A57861D05
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:51:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BE0CC433B5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668045077;
        bh=oKQwTFxHq2kGMa1vOhC7zSnxTLyv7w68uwwH5S/nliI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UYHpTR2osa/At5V9rma90+CY0h1rg1v2er7L0mB22stbhBlmugc6AcyivNg3UfygE
         jMrJzBKNITunZAIwg2JN48ZT5QemaEWsYodcu9XoEF90IRKC/ZiJBiC24G19xbJOo8
         UlBiacYo+NXc4TJvQgguynB5OPo+8eTGjs/i3s9BCtouYlpWg0Rpdj0YyhKRv6iX7V
         ay52QE9kxKWyORVxjxmwipJeHuRNS0krUf3IrdgOPBCsheisH21VjxOG6GXDD5/jpe
         U8ct0IFCoyaTWTsxHNscP/NTjJ4aAdE3Z9ZipGLlRMWDIhZ/yfZ2+sUn7deljGhJiB
         FMqhKCU8RJO9Q==
Received: by mail-oi1-f180.google.com with SMTP id n83so468515oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 17:51:16 -0800 (PST)
X-Gm-Message-State: ACrzQf1nrKieA3KHFSdPPYMvD0DKJ1JCJgqzA/nObBZQEcyCL4gqIDCl
        zT9H9G1Zr2LhQi9F6AYeW6qMrg29Quknegilc/E=
X-Google-Smtp-Source: AMsMyM4MWhEeTyU4aE0ONp7ineIbT2o/2KCHK9CodVfC9wzPYs8zSZ/0JrI+Yf5WwekiZlcEN05rAOwpdwK659+BHfk=
X-Received: by 2002:aca:c1d4:0:b0:359:b15f:23f2 with SMTP id
 r203-20020acac1d4000000b00359b15f23f2mr1024667oif.112.1668045076113; Wed, 09
 Nov 2022 17:51:16 -0800 (PST)
MIME-Version: 1.0
References: <20221109054056.3618089-1-guoren@kernel.org> <20221109094503.he4ihaow7axjseuj@kamzik>
In-Reply-To: <20221109094503.he4ihaow7axjseuj@kamzik>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 10 Nov 2022 09:51:03 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRoeog55EMEZeziLxX0QNxD_pjBh979y8zp6sVwdarNpQ@mail.gmail.com>
Message-ID: <CAJF2gTRoeog55EMEZeziLxX0QNxD_pjBh979y8zp6sVwdarNpQ@mail.gmail.com>
Subject: Re: [PATCH V2] riscv: asid: Fixup stale TLB entry cause application crash
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 9, 2022 at 5:45 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Wed, Nov 09, 2022 at 12:40:56AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > After use_asid_allocator is enabled, the userspace application will
> > crash by stale TLB entries. Because only using cpumask_clear_cpu without
> > local_flush_tlb_all couldn't guarantee CPU's TLB entries were fresh.
> > Then set_mm_asid would cause the user space application to get a stale
> > value by stale TLB entry, but set_mm_noasid is okay.
> >
> > Here is the symptom of the bug:
> > unhandled signal 11 code 0x1 (coredump)
> >    0x0000003fd6d22524 <+4>:     auipc   s0,0x70
> >    0x0000003fd6d22528 <+8>:     ld      s0,-148(s0) # 0x3fd6d92490
> > => 0x0000003fd6d2252c <+12>:    ld      a5,0(s0)
> > (gdb) i r s0
> > s0          0x8082ed1cc3198b21       0x8082ed1cc3198b21
> > (gdb) x /2x 0x3fd6d92490
> > 0x3fd6d92490:   0xd80ac8a8      0x0000003f
> > The core dump file shows that register s0 is wrong, but the value in
> > memory is correct. Because 'ld s0, -148(s0)' used a stale mapping entry
> > in TLB and got a wrong result from an incorrect physical address.
> >
> > When the task ran on CPU0, which loaded/speculative-loaded the value of
> > address(0x3fd6d92490), then the first version of the mapping entry was
> > PTWed into CPU0's TLB.
> > When the task switched from CPU0 to CPU1 (No local_tlb_flush_all here by
> > asid), it happened to write a value on the address (0x3fd6d92490). It
> > caused do_page_fault -> wp_page_copy -> ptep_clear_flush ->
> > ptep_get_and_clear & flush_tlb_page.
> > The flush_tlb_page used mm_cpumask(mm) to determine which CPUs need TLB
> > flush, but CPU0 had cleared the CPU0's mm_cpumask in the previous
> > switch_mm. So we only flushed the CPU1 TLB and set the second version
> > mapping of the PTE. When the task switched from CPU1 to CPU0 again, CPU0
> > still used a stale TLB mapping entry which contained a wrong target
> > physical address. It raised a bug when the task happened to read that
> > value.
> >
> > The solution is to keep all CPUs' footmarks of cpumask(mm) in switch_mm,
> > which could prevent losing pieces of stuff during TLB flush.
> >
> > Fixes: 65d4b9c53017 ("RISC-V: Implement ASID allocator")
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > Cc: Anup Patel <apatel@ventanamicro.com>
> > Cc: Palmer Dabbelt <palmer@rivosinc.com>
> > ---
> > Changes in v2:
> >  - Fixup nommu compile problem (Thx Conor, Also Reported-by: kernel
> >    test robot <lkp@intel.com>)
> >  - Keep cpumask_clear_cpu for noasid
> > ---
> >  arch/riscv/mm/context.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 7acbfbd14557..f58e4b211595 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -317,7 +317,11 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
> >        */
> >       cpu = smp_processor_id();
> >
> > -     cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > +#ifdef CONFIG_MMU
> > +     if (!static_branch_unlikely(&use_asid_allocator))
> > +#endif
>
> That's not very pretty. Can't we just do the following, instead?
>
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..ace419761e31 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -16,10 +16,11 @@
>  #include <asm/cacheflush.h>
>  #include <asm/mmu_context.h>
>
> -#ifdef CONFIG_MMU
>
>  DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
Define use_asid_allocator in nommu part? How about:

diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
index 7acbfbd14557..ed3f8de7ef97 100644
--- a/arch/riscv/mm/context.c
+++ b/arch/riscv/mm/context.c
@@ -205,12 +205,16 @@ static void set_mm_noasid(struct mm_struct *mm)
        local_flush_tlb_all();
 }

-static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
+static inline void set_mm(struct mm_struct *prev,
+                         struct mm_struct *next, unsigned int cpu)
 {
-       if (static_branch_unlikely(&use_asid_allocator))
-               set_mm_asid(mm, cpu);
-       else
-               set_mm_noasid(mm);
+       cpumask_set_cpu(cpu, mm_cpumask(next));
+       if (static_branch_unlikely(&use_asid_allocator)) {
+               set_mm_asid(next, cpu);
+       } else {
+               cpumask_clear_cpu(cpu, mm_cpumask(prev));
+               set_mm_noasid(next);
+       }
 }

 static int __init asids_init(void)
@@ -264,7 +268,8 @@ static int __init asids_init(void)
 }
 early_initcall(asids_init);
 #else
-static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
+static inline void set_mm(struct mm_struct *prev,
+                         struct mm_struct *next, unsigned int cpu)
 {
        /* Nothing to do here when there is no MMU */
 }
@@ -317,10 +322,7 @@ void switch_mm(struct mm_struct *prev, struct
mm_struct *next,
         */
        cpu = smp_processor_id();

-       cpumask_clear_cpu(cpu, mm_cpumask(prev));
-       cpumask_set_cpu(cpu, mm_cpumask(next));
-
-       set_mm(next, cpu);
+       set_mm(prev, next, cpu);

        flush_icache_deferred(next, cpu);

>
> +#ifdef CONFIG_MMU
> +
>  static unsigned long asid_bits;
>  static unsigned long num_asids;
>  static unsigned long asid_mask;
>
>
> Thanks,
> drew
>
> > +             cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > +
> >       cpumask_set_cpu(cpu, mm_cpumask(next));
> >
> >       set_mm(next, cpu);
> > --
> > 2.36.1
> >
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv



-- 
Best Regards
 Guo Ren
