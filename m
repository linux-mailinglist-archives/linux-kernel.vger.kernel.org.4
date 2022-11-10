Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F138623E7C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 10:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKJJWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 04:22:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbiKJJWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 04:22:46 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B7868C64
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:22:45 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ft34so3319046ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 01:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CiXk0ZxCjartGHlEcfXR+wx1HCFz8CF7DmDMb+VBys4=;
        b=QGIDmOyrSXjFXBbS9xFQf7+kr+vXgIANY3UfXxOd6fieggP4MPIoK6T8oooUvL+3Zz
         n5A39jb6oVYhos+0eqgi4ygAuEb+8EFRneem9RvJWAg1dZ3H5sSBqJYyPbsHEXNTPwG1
         zia5l5BR6e9WtRUQB6e1iv+9r1o2PB1EmnSYyv2Yn1jRii5mI2ec/GCgReVRDR4aCOsU
         2tsKa8vrjBGw+t9mdYurfcQoXIrWIRsIWtbGftz+D3BJ2NuGGP22XJRLx1jny7syxwU5
         qO7epXQY5earqhOVyAuLf1ssF71Xbe6z/f7vrIg1yBv+43PEnBo7y4WlZleWpBcpx6q+
         DyKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CiXk0ZxCjartGHlEcfXR+wx1HCFz8CF7DmDMb+VBys4=;
        b=ZX5dsmEh5byfzHl7SkOIdDES8zd35zjsD92meuVk4oy7IIW6AyMk1QvJb0yhoq0hvO
         QlH9bsGpK5G6wG+Be9sPt9a4cjAfAtcWvO+EdirJ6yaTiTNDqNLuyZP1No0S4n7e24lb
         BqJtisa9gD9zR1n90jdbav7Hd4OTDXFLv33Ej3QA+OXeaktuydLMO16287HSnUYQXevt
         d5WErSt+s6FUTbYmDuJjKOPhI+tVUGCGVhVqkxDYFDfgoSLjm8VLu7PCGQhQpYmakRY7
         kPIeRLxRmLWw2lJfQS9Wl5mCZyAst2OqHpZVs7clEwcA08B/v4D31KqO9jQePhqk/vc/
         2F9A==
X-Gm-Message-State: ANoB5pnHny5FDXMrwOcDH1kAIsSPKFo2r0h7GAx9okpZHCD0pRM3kdmH
        IjZaWzXp8JfEY47n7wm8EzPPrQ==
X-Google-Smtp-Source: AA0mqf6RA5OcwKQEVeQuaIy6sy8/aIiqiHAwAsrnb0HBghnCDX48TtWE1ovMtkIiA4TRTaZxEQCtHg==
X-Received: by 2002:a17:907:2e0b:b0:7a7:d37e:4650 with SMTP id ig11-20020a1709072e0b00b007a7d37e4650mr18208591ejc.261.1668072164060;
        Thu, 10 Nov 2022 01:22:44 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id ce12-20020a170906b24c00b007acbac07f07sm7008031ejb.51.2022.11.10.01.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 01:22:43 -0800 (PST)
Date:   Thu, 10 Nov 2022 10:22:42 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Guo Ren <guoren@kernel.org>
Cc:     anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        conor.dooley@microchip.com, heiko@sntech.de,
        philipp.tomsich@vrull.eu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Anup Patel <apatel@ventanamicro.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
Subject: Re: [PATCH V2] riscv: asid: Fixup stale TLB entry cause application
 crash
Message-ID: <20221110092242.hvz2ubzsfisqd7f6@kamzik>
References: <20221109054056.3618089-1-guoren@kernel.org>
 <20221109094503.he4ihaow7axjseuj@kamzik>
 <CAJF2gTRoeog55EMEZeziLxX0QNxD_pjBh979y8zp6sVwdarNpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJF2gTRoeog55EMEZeziLxX0QNxD_pjBh979y8zp6sVwdarNpQ@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 10, 2022 at 09:51:03AM +0800, Guo Ren wrote:
> On Wed, Nov 9, 2022 at 5:45 PM Andrew Jones <ajones@ventanamicro.com> wrote:
> >
> > On Wed, Nov 09, 2022 at 12:40:56AM -0500, guoren@kernel.org wrote:
> > >
> > > -     cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > > +#ifdef CONFIG_MMU
> > > +     if (!static_branch_unlikely(&use_asid_allocator))
> > > +#endif
> >
> > That's not very pretty. Can't we just do the following, instead?
> >
> > diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> > index 7acbfbd14557..ace419761e31 100644
> > --- a/arch/riscv/mm/context.c
> > +++ b/arch/riscv/mm/context.c
> > @@ -16,10 +16,11 @@
> >  #include <asm/cacheflush.h>
> >  #include <asm/mmu_context.h>
> >
> > -#ifdef CONFIG_MMU
> >
> >  DEFINE_STATIC_KEY_FALSE(use_asid_allocator);
> Define use_asid_allocator in nommu part? How about:

Yeah, I was thinking it'll just always be a false static branch
in the nommu case, but I like your proposal below better.

Thanks,
drew

> 
> diff --git a/arch/riscv/mm/context.c b/arch/riscv/mm/context.c
> index 7acbfbd14557..ed3f8de7ef97 100644
> --- a/arch/riscv/mm/context.c
> +++ b/arch/riscv/mm/context.c
> @@ -205,12 +205,16 @@ static void set_mm_noasid(struct mm_struct *mm)
>         local_flush_tlb_all();
>  }
> 
> -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> +static inline void set_mm(struct mm_struct *prev,
> +                         struct mm_struct *next, unsigned int cpu)
>  {
> -       if (static_branch_unlikely(&use_asid_allocator))
> -               set_mm_asid(mm, cpu);
> -       else
> -               set_mm_noasid(mm);
> +       cpumask_set_cpu(cpu, mm_cpumask(next));
> +       if (static_branch_unlikely(&use_asid_allocator)) {
> +               set_mm_asid(next, cpu);
> +       } else {
> +               cpumask_clear_cpu(cpu, mm_cpumask(prev));
> +               set_mm_noasid(next);
> +       }
>  }
> 
>  static int __init asids_init(void)
> @@ -264,7 +268,8 @@ static int __init asids_init(void)
>  }
>  early_initcall(asids_init);
>  #else
> -static inline void set_mm(struct mm_struct *mm, unsigned int cpu)
> +static inline void set_mm(struct mm_struct *prev,
> +                         struct mm_struct *next, unsigned int cpu)
>  {
>         /* Nothing to do here when there is no MMU */
>  }
> @@ -317,10 +322,7 @@ void switch_mm(struct mm_struct *prev, struct
> mm_struct *next,
>          */
>         cpu = smp_processor_id();
> 
> -       cpumask_clear_cpu(cpu, mm_cpumask(prev));
> -       cpumask_set_cpu(cpu, mm_cpumask(next));
> -
> -       set_mm(next, cpu);
> +       set_mm(prev, next, cpu);
> 
>         flush_icache_deferred(next, cpu);
> 
> >
> > +#ifdef CONFIG_MMU
> > +
> >  static unsigned long asid_bits;
> >  static unsigned long num_asids;
> >  static unsigned long asid_mask;
> >
> >
> > Thanks,
> > drew
> >
> > > +             cpumask_clear_cpu(cpu, mm_cpumask(prev));
> > > +
> > >       cpumask_set_cpu(cpu, mm_cpumask(next));
> > >
> > >       set_mm(next, cpu);
> > > --
> > > 2.36.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> 
> 
> 
> -- 
> Best Regards
>  Guo Ren
