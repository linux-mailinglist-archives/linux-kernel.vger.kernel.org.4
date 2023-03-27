Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA996CA239
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 13:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232037AbjC0LP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 07:15:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjC0LP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:15:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED99423A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:15:55 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j24so8381407wrd.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 04:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112; t=1679915754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JOyKIfLtw7epSWpNBR5RCtoo6dWCpYNvZHBA+U+jP4c=;
        b=1gL8htMXUt39RXtpOj2PLmpQ/+49gpLi4WXxkyVp6PZjyskLnkx+PEC2jrQM3rKye0
         FqViWjlx+8bXunHrXG1IAPA1V9dqq8XpTVS4ABFXu2ZlRhrJsOHwmRoSSRROJirTFURK
         agIgj2mo2PXjbUkzashbJQwP9LyRi8B66l3xHwQBXwCFZfKVgRnFs3hr3j8XX4AsfRVs
         onh37lLbaNbMMk8Rc3aai3SyTvEtEUf7tzRYtzg9RnvRfOJzQi7w/nI2ByKjOrdnYyCx
         oFZlSbDkcP4TuxWnvzNWFrlgyfix6QLEKhZoum8kWy0KbvFirNwZGPGQuelhrKezUFUf
         M8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679915754;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JOyKIfLtw7epSWpNBR5RCtoo6dWCpYNvZHBA+U+jP4c=;
        b=NCxrV3DZ8ANF2EbJtHAFtMuDEVonh8LuQKX6ddmmoxuQxOZCUpEfsR7IP3bvq1isUo
         riZ1oWlEM94IVS+8PU9HD5FWEnBw6IzvgPQ0pNOSgfr77ghDtD19VYhFldCAsa4tuEi+
         P0gZ/EDUF8vzBVpT3dEeKxVQVK8gZGGGUZg1rbpJtguPr/abwy+w2ZpiEXAWhyjbIpUO
         V4hz/MHhaMPUc7RTTTdYY724PbychPnQlb4QRLka9m8qCXAXM7kyL0c/Ph0TN3I07i+Y
         iXtwoOzpBOuAmUMnaCWlRD0a1Z44GJm7rUYcn7PznKffjZ/yje3pd4fO0uVvpJoqyBIQ
         zeKQ==
X-Gm-Message-State: AAQBX9cjgVnO90PyzZydnDs5ooHj4StV4QoFfFDFrof62Voht7emtMI4
        0kIET5wKFonr0XeCe/20uhpDnOhMUTvTc3Tu6m6KUw==
X-Google-Smtp-Source: AKy350acdqzIhtkutkDeAxi2LdPCiuVHBefCpw/W8e7lHOfa8nl2mxjemw3kk0+8K3psfGpJ3H8EqtEqFQBffD6BSsg=
X-Received: by 2002:adf:eb85:0:b0:2d3:c90e:88c3 with SMTP id
 t5-20020adfeb85000000b002d3c90e88c3mr2280919wrn.13.1679915754267; Mon, 27 Mar
 2023 04:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230324155421.271544-1-alexghiti@rivosinc.com>
 <20230324155421.271544-4-alexghiti@rivosinc.com> <20230327093926.x5qyb5nou7naiyyv@orel>
In-Reply-To: <20230327093926.x5qyb5nou7naiyyv@orel>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Mon, 27 Mar 2023 13:15:43 +0200
Message-ID: <CAHVXubg2BpoCqtXTW9BWQ21DmNOzR2ebvhUHA8NkZ3Hkk8-NkA@mail.gmail.com>
Subject: Re: [PATCH v9 3/3] riscv: Use PUD/P4D/PGD pages for the linear mapping
To:     Andrew Jones <ajones@ventanamicro.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Mon, Mar 27, 2023 at 11:39=E2=80=AFAM Andrew Jones <ajones@ventanamicro.=
com> wrote:
>
> On Fri, Mar 24, 2023 at 04:54:21PM +0100, Alexandre Ghiti wrote:
> > During the early page table creation, we used to set the mapping for
> > PAGE_OFFSET to the kernel load address: but the kernel load address is
> > always offseted by PMD_SIZE which makes it impossible to use PUD/P4D/PG=
D
> > pages as this physical address is not aligned on PUD/P4D/PGD size (wher=
eas
> > PAGE_OFFSET is).
> >
> > But actually we don't have to establish this mapping (ie set va_pa_offs=
et)
> > that early in the boot process because:
> >
> > - first, setup_vm installs a temporary kernel mapping and among other
> >   things, discovers the system memory,
> > - then, setup_vm_final creates the final kernel mapping and takes
> >   advantage of the discovered system memory to create the linear
> >   mapping.
> >
> > During the first phase, we don't know the start of the system memory an=
d
> > then until the second phase is finished, we can't use the linear mappin=
g at
> > all and phys_to_virt/virt_to_phys translations must not be used because=
 it
> > would result in a different translation from the 'real' one once the fi=
nal
> > mapping is installed.
> >
> > So here we simply delay the initialization of va_pa_offset to after the
> > system memory discovery. But to make sure noone uses the linear mapping
> > before, we add some guard in the DEBUG_VIRTUAL config.
> >
> > Finally we can use PUD/P4D/PGD hugepages when possible, which will resu=
lt
> > in a better TLB utilization.
> >
> > Note that:
> > - this does not apply to rv32 as the kernel mapping lies in the linear
> >   mapping.
> > - we rely on the firmware to protect itself using PMP.
> >
> > Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> > Acked-by: Rob Herring <robh@kernel.org> # DT bits
> > ---
> >  arch/riscv/include/asm/page.h | 16 ++++++++++
> >  arch/riscv/mm/init.c          | 58 +++++++++++++++++++++++++++++++----
> >  arch/riscv/mm/physaddr.c      | 16 ++++++++++
> >  drivers/of/fdt.c              | 11 ++++---
> >  4 files changed, 90 insertions(+), 11 deletions(-)
> >
> > diff --git a/arch/riscv/include/asm/page.h b/arch/riscv/include/asm/pag=
e.h
> > index 8dc686f549b6..ea1a0e237211 100644
> > --- a/arch/riscv/include/asm/page.h
> > +++ b/arch/riscv/include/asm/page.h
> > @@ -90,6 +90,14 @@ typedef struct page *pgtable_t;
> >  #define PTE_FMT "%08lx"
> >  #endif
> >
> > +#ifdef CONFIG_64BIT
> > +/*
> > + * We override this value as its generic definition uses __pa too earl=
y in
> > + * the boot process (before kernel_map.va_pa_offset is set).
> > + */
> > +#define MIN_MEMBLOCK_ADDR      0
> > +#endif
> > +
> >  #ifdef CONFIG_MMU
> >  #define ARCH_PFN_OFFSET              (PFN_DOWN((unsigned long)phys_ram=
_base))
> >  #else
> > @@ -121,7 +129,11 @@ extern phys_addr_t phys_ram_base;
> >  #define is_linear_mapping(x) \
> >       ((x) >=3D PAGE_OFFSET && (!IS_ENABLED(CONFIG_64BIT) || (x) < PAGE=
_OFFSET + KERN_VIRT_SIZE))
> >
> > +#ifndef CONFIG_DEBUG_VIRTUAL
> >  #define linear_mapping_pa_to_va(x)   ((void *)((unsigned long)(x) + ke=
rnel_map.va_pa_offset))
> > +#else
> > +void *linear_mapping_pa_to_va(unsigned long x);
> > +#endif
> >  #define kernel_mapping_pa_to_va(y)   ({                               =
       \
> >       unsigned long _y =3D (unsigned long)(y);                         =
         \
> >       (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < phys_ram_base) ?          =
       \
> > @@ -130,7 +142,11 @@ extern phys_addr_t phys_ram_base;
> >       })
> >  #define __pa_to_va_nodebug(x)                linear_mapping_pa_to_va(x=
)
> >
> > +#ifndef CONFIG_DEBUG_VIRTUAL
> >  #define linear_mapping_va_to_pa(x)   ((unsigned long)(x) - kernel_map.=
va_pa_offset)
> > +#else
> > +phys_addr_t linear_mapping_va_to_pa(unsigned long x);
> > +#endif
> >  #define kernel_mapping_va_to_pa(y) ({                                 =
               \
> >       unsigned long _y =3D (unsigned long)(y);                         =
         \
> >       (IS_ENABLED(CONFIG_XIP_KERNEL) && _y < kernel_map.virt_addr + XIP=
_OFFSET) ? \
> > diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> > index 3b37d8606920..f803671d18b2 100644
> > --- a/arch/riscv/mm/init.c
> > +++ b/arch/riscv/mm/init.c
> > @@ -213,6 +213,14 @@ static void __init setup_bootmem(void)
> >       phys_ram_end =3D memblock_end_of_DRAM();
> >       if (!IS_ENABLED(CONFIG_XIP_KERNEL))
> >               phys_ram_base =3D memblock_start_of_DRAM();
> > +
> > +     /*
> > +      * In 64-bit, any use of __va/__pa before this point is wrong as =
we
> > +      * did not know the start of DRAM before.
> > +      */
> > +     if (IS_ENABLED(CONFIG_64BIT))
> > +             kernel_map.va_pa_offset =3D PAGE_OFFSET - phys_ram_base;
> > +
> >       /*
> >        * memblock allocator is not aware of the fact that last 4K bytes=
 of
> >        * the addressable memory can not be mapped because of IS_ERR_VAL=
UE
> > @@ -667,9 +675,16 @@ void __init create_pgd_mapping(pgd_t *pgdp,
> >
> >  static uintptr_t __init best_map_size(phys_addr_t base, phys_addr_t si=
ze)
> >  {
> > -     /* Upgrade to PMD_SIZE mappings whenever possible */
> > -     base &=3D PMD_SIZE - 1;
> > -     if (!base && size >=3D PMD_SIZE)
> > +     if (!(base & (PGDIR_SIZE - 1)) && size >=3D PGDIR_SIZE)
> > +             return PGDIR_SIZE;
> > +
> > +     if (!(base & (P4D_SIZE - 1)) && size >=3D P4D_SIZE)
> > +             return P4D_SIZE;
> > +
> > +     if (!(base & (PUD_SIZE - 1)) && size >=3D PUD_SIZE)
> > +             return PUD_SIZE;
> > +
> > +     if (!(base & (PMD_SIZE - 1)) && size >=3D PMD_SIZE)
> >               return PMD_SIZE;
> >
> >       return PAGE_SIZE;
> > @@ -978,11 +993,22 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >       set_satp_mode();
> >  #endif
> >
> > -     kernel_map.va_pa_offset =3D PAGE_OFFSET - kernel_map.phys_addr;
> > +     /*
> > +      * In 64-bit, we defer the setup of va_pa_offset to setup_bootmem=
,
> > +      * where we have the system memory layout: this allows us to alig=
n
> > +      * the physical and virtual mappings and then make use of PUD/P4D=
/PGD
> > +      * for the linear mapping. This is only possible because the kern=
el
> > +      * mapping lies outside the linear mapping.
> > +      * In 32-bit however, as the kernel resides in the linear mapping=
,
> > +      * setup_vm_final can not change the mapping established here,
> > +      * otherwise the same kernel addresses would get mapped to differ=
ent
> > +      * physical addresses (if the start of dram is different from the
> > +      * kernel physical address start).
> > +      */
> > +     kernel_map.va_pa_offset =3D IS_ENABLED(CONFIG_64BIT) ?
> > +                             0UL : PAGE_OFFSET - kernel_map.phys_addr;
> >       kernel_map.va_kernel_pa_offset =3D kernel_map.virt_addr - kernel_=
map.phys_addr;
> >
> > -     phys_ram_base =3D kernel_map.phys_addr;
> > -
> >       /*
> >        * The default maximal physical memory size is KERN_VIRT_SIZE for=
 32-bit
> >        * kernel, whereas for 64-bit kernel, the end of the virtual addr=
ess
> > @@ -1106,6 +1132,17 @@ static void __init create_linear_mapping_page_ta=
ble(void)
> >       phys_addr_t start, end;
> >       u64 i;
> >
> > +#ifdef CONFIG_STRICT_KERNEL_RWX
> > +     phys_addr_t ktext_start =3D __pa_symbol(_start);
> > +     phys_addr_t ktext_size =3D __init_data_begin - _start;
> > +     phys_addr_t krodata_start =3D __pa_symbol(__start_rodata);
> > +     phys_addr_t krodata_size =3D _data - __start_rodata;
> > +
> > +     /* Isolate kernel text and rodata so they don't get mapped with a=
 PUD */
> > +     memblock_mark_nomap(ktext_start,  ktext_size);
> > +     memblock_mark_nomap(krodata_start, krodata_size);
> > +#endif
> > +
> >       /* Map all memory banks in the linear mapping */
> >       for_each_mem_range(i, &start, &end) {
> >               if (start >=3D end)
> > @@ -1118,6 +1155,15 @@ static void __init create_linear_mapping_page_ta=
ble(void)
> >
> >               create_linear_mapping_range(start, end);
> >       }
> > +
> > +#ifdef CONFIG_STRICT_KERNEL_RWX
> > +     create_linear_mapping_range(ktext_start, ktext_start + ktext_size=
);
> > +     create_linear_mapping_range(krodata_start,
> > +                                 krodata_start + krodata_size);
>
> Just for my own education, it looks to me like the rodata is left writabl=
e
> until the end of start_kernel(), when mark_rodata_ro() is called. Is that
> correct?

Yes, right before init is triggered, certainly that late because the
rodata section embeds the "__ro_after_init" variables.


>
> Thanks,
> drew
>
> > +
> > +     memblock_clear_nomap(ktext_start,  ktext_size);
> > +     memblock_clear_nomap(krodata_start, krodata_size);
> > +#endif
> >  }
> >
> >  static void __init setup_vm_final(void)
> > diff --git a/arch/riscv/mm/physaddr.c b/arch/riscv/mm/physaddr.c
> > index 9b18bda74154..18706f457da7 100644
> > --- a/arch/riscv/mm/physaddr.c
> > +++ b/arch/riscv/mm/physaddr.c
> > @@ -33,3 +33,19 @@ phys_addr_t __phys_addr_symbol(unsigned long x)
> >       return __va_to_pa_nodebug(x);
> >  }
> >  EXPORT_SYMBOL(__phys_addr_symbol);
> > +
> > +phys_addr_t linear_mapping_va_to_pa(unsigned long x)
> > +{
> > +     BUG_ON(!kernel_map.va_pa_offset);
> > +
> > +     return ((unsigned long)(x) - kernel_map.va_pa_offset);
> > +}
> > +EXPORT_SYMBOL(linear_mapping_va_to_pa);
> > +
> > +void *linear_mapping_pa_to_va(unsigned long x)
> > +{
> > +     BUG_ON(!kernel_map.va_pa_offset);
> > +
> > +     return ((void *)((unsigned long)(x) + kernel_map.va_pa_offset));
> > +}
> > +EXPORT_SYMBOL(linear_mapping_pa_to_va);
> > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > index d1a68b6d03b3..d14735a81301 100644
> > --- a/drivers/of/fdt.c
> > +++ b/drivers/of/fdt.c
> > @@ -887,12 +887,13 @@ const void * __init of_flat_dt_match_machine(cons=
t void *default_match,
> >  static void __early_init_dt_declare_initrd(unsigned long start,
> >                                          unsigned long end)
> >  {
> > -     /* ARM64 would cause a BUG to occur here when CONFIG_DEBUG_VM is
> > -      * enabled since __va() is called too early. ARM64 does make use
> > -      * of phys_initrd_start/phys_initrd_size so we can skip this
> > -      * conversion.
> > +     /*
> > +      * __va() is not yet available this early on some platforms. In t=
hat
> > +      * case, the platform uses phys_initrd_start/phys_initrd_size ins=
tead
> > +      * and does the VA conversion itself.
> >        */
> > -     if (!IS_ENABLED(CONFIG_ARM64)) {
> > +     if (!IS_ENABLED(CONFIG_ARM64) &&
> > +         !(IS_ENABLED(CONFIG_RISCV) && IS_ENABLED(CONFIG_64BIT))) {
> >               initrd_start =3D (unsigned long)__va(start);
> >               initrd_end =3D (unsigned long)__va(end);
> >               initrd_below_start_ok =3D 1;
> > --
> > 2.37.2
> >
