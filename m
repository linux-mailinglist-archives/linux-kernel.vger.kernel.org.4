Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A751E67DF79
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 09:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232414AbjA0IsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 03:48:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232160AbjA0IsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 03:48:15 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9EAEB52
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:48:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l8so2913042wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 00:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=74Srsc/HZaLd2G/K5A3jwcD5Q50sHxOztEiNF18Yd+E=;
        b=RBKipDzSGwfFqx+Z550Wd/qiFS3OXSJoMjvRXvDiE8KJyVGxOqiuSa/9k5Y3HqRdVK
         08SYhbOJDZxFBhfTE7oiUlPb/M7iaei1GBjuXjcIggMy6VeyK4rapz2XrQ1twT6rJOTl
         3zF/uWAxYkROGNDC3UcS2/jrsbguPTkVFj2z1Ln3sQX9aJ02TAXQO5f0ib3DH13vgZnN
         T5qQw4ZeUDwn+2akLuxIP5cyGJPzO8JftKjYk6QiAi+dQ9jjImcc79J2PepZJl5oLJvi
         JkxfZZRY0BKYcViDNQvkLzdNhIdzAFS6iWJ420abwsacwRsZngPA1wU22TgKOqpGORlW
         wFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=74Srsc/HZaLd2G/K5A3jwcD5Q50sHxOztEiNF18Yd+E=;
        b=vaz0IULFzQDdKQD7OMt7crHHNKtcW2UxOBOMMRDg/ujSST9ax1/8YGDgF6D6wwXkSF
         gS/EGPMIwCIfUEUuFFDYKr/B370NDOjMBGBVV0+9fGTcsAf5rFnA7fPEs4DCHr9TVtNF
         Bf0Mlv7oEAnj6T07IG3jTEIv+nEcP+ZrzM2BJ0J5znMHWrKERQIPAiJ2SZJMww8ngWOl
         V7w/bTRkoZYR8cuI32+g8aBu8AuEzSGXw3dW8mJxS0FOKI+5AnSm/B+HYYLzdpZmJchb
         9pzej5xBV8XD5na/PH6yUImXtcHNTKH1hso6Zj9z9RSq1tEPVDPcWUHQRcXPyo4Ed9n2
         fIbg==
X-Gm-Message-State: AFqh2ko0Pe0PUeCeCaUCE6vtoyeqzxDSk8lFFJjG/kPlticJJOcaB10+
        kgVzbZ3V767GdQq23iPAx/mxAgyTh/TnQogHVSg4qh1uJBR0QQ==
X-Google-Smtp-Source: AMrXdXtA/AmyKEpy3TzOGc4/dtiZaApnUtb/X9HOLK9Y873+F+NyOjwK4O/G2ar6UmEvFhVsCxpDzY7fqrw3nl0IXyo=
X-Received: by 2002:a7b:c4d0:0:b0:3db:459:5847 with SMTP id
 g16-20020a7bc4d0000000b003db04595847mr2144158wmk.5.1674809292405; Fri, 27 Jan
 2023 00:48:12 -0800 (PST)
MIME-Version: 1.0
References: <20230125081214.1576313-1-alexghiti@rivosinc.com>
 <20230125081214.1576313-2-alexghiti@rivosinc.com> <20230125114044.qcr2canalvljevcu@orel>
In-Reply-To: <20230125114044.qcr2canalvljevcu@orel>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Fri, 27 Jan 2023 09:48:01 +0100
Message-ID: <CAHVXubgCK23digBakrPjC7_J-OVD9Bu2=hcvDYvvtnLnyj7Ajw@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] riscv: Get rid of riscv_pfn_base variable
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 12:40 PM Andrew Jones <ajones@ventanamicro.com> wrote:
>
> On Wed, Jan 25, 2023 at 09:12:13AM +0100, Alexandre Ghiti wrote:
> > Use directly phys_ram_base instead, riscv_pfn_base is just the pfn of
> > the address contained in phys_ram_base.
> >
> > Even if there is no functional change intended in this patch, actually
> > setting phys_ram_base that early changes the behaviour of
> > kernel_mapping_pa_to_va during the early boot: phys_ram_base used to be
> > zero before this patch and now it is set to the physical start address of
> > the kernel. But it does not break the conversion of a kernel physical
> > address into a virtual address since kernel_mapping_pa_to_va should only
> > be used on kernel physical addresses, i.e. addresses greater than the
> > physical start address of the kernel.
>
> afaict, only CONFIG_XIP_KERNEL kernels use phys_ram_base prior to
> setup_bootmem() and, for them, this change only redundantly sets
> phys_ram_base to the same thing, so I believe this is a no functional
> change patch.
>

Good, thanks for checking again

> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > ---
> >  arch/riscv/include/asm/page.h | 3 +--
> >  arch/riscv/mm/init.c          | 6 +-----
> >  2 files changed, 2 insertions(+), 7 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/page.h
> > index 9f432c1b5289..728eee53152a 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -91,8 +91,7 @@ typedef struct page *pgtable_t;
> >  #endif
> >
> >  #ifdef CONFIG_MMU
> > -extern unsigned long riscv_pfn_base;
> > -#define ARCH_PFN_OFFSET              (riscv_pfn_base)
> > +#define ARCH_PFN_OFFSET              (PFN_DOWN(phys_ram_base))
> >  #else
> >  #define ARCH_PFN_OFFSET              (PAGE_OFFSET >> PAGE_SHIFT)
> >  #endif /* CONFIG_MMU */
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 478d6763a01a..225a7d2b65cc 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -271,9 +271,6 @@ static void __init setup_bootmem(void)
> >  #ifdef CONFIG_MMU
> >  struct pt_alloc_ops pt_ops __initdata;
> >
> > -unsigned long riscv_pfn_base __ro_after_init;
> > -EXPORT_SYMBOL(riscv_pfn_base);
> > -
> >  pgd_t swapper_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >  pgd_t trampoline_pg_dir[PTRS_PER_PGD] __page_aligned_bss;
> >  static pte_t fixmap_pte[PTRS_PER_PTE] __page_aligned_bss;
> > @@ -285,7 +282,6 @@ static pmd_t __maybe_unused early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAG
> >
> >  #ifdef CONFIG_XIP_KERNEL
> >  #define pt_ops                       (*(struct pt_alloc_ops *)XIP_FIXUP(&pt_ops))
> > -#define riscv_pfn_base         (*(unsigned long  *)XIP_FIXUP(&riscv_pfn_base))
> >  #define trampoline_pg_dir      ((pgd_t *)XIP_FIXUP(trampoline_pg_dir))
> >  #define fixmap_pte             ((pte_t *)XIP_FIXUP(fixmap_pte))
> >  #define early_pg_dir           ((pgd_t *)XIP_FIXUP(early_pg_dir))
> > @@ -985,7 +981,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >       kernel_map.va_pa_offset = PAGE_OFFSET - kernel_map.phys_addr;
> >       kernel_map.va_kernel_pa_offset = kernel_map.virt_addr - kernel_map.phys_addr;
> >
> > -     riscv_pfn_base = PFN_DOWN(kernel_map.phys_addr);
> > +     phys_ram_base = kernel_map.phys_addr;
>
> nit: I'd put this in the #else part of the #ifdef CONFIG_XIP_KERNEL above
> to have some consistency with that #ifdef arm and also avoid the redundant
> assignment of phys_ram_base for CONFIG_XIP_KERNEL.

True, but as this is removed in the next patch, I guess we can live with that.

>
> >
> >       /*
> >        * The default maximal physical memory size is KERN_VIRT_SIZE for 32-bit
> > --
> > 2.37.2
> >
>
> Otherwise,
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Alex

>
> Thanks,
> drew
