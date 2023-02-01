Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81BC0686E4E
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 19:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbjBASmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 13:42:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjBASmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 13:42:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3148A267;
        Wed,  1 Feb 2023 10:42:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1550BB82270;
        Wed,  1 Feb 2023 18:42:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 384ACC433A1;
        Wed,  1 Feb 2023 18:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675276926;
        bh=pt7t+eEiyEqxwh+RI9ghwnII87bzmWTL0B9bkm6w7Dw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Sb2JtY17787tjqZI5/sCqM+GISTmhIdLpAfO4jkla/T3mAPeVVwjVBZ6NXJhXRfU8
         GM/REcUZG8jf8rMY/Zfe0tGIHUYJx1PqZds0Ki0PFniqawb4erXXQphKwHMwW5Nxbq
         IlDgfAWhIkY9Nma6LOlnIC+PlHPoQk1Oru2skMMDOU0WMVItpXoS7R598R3huz/aYQ
         /V39zHfMccuH+xPgmGVk7/k1zRih/IUpha/sd6uv7th3gleDsgf+LI23OabaWDfoI8
         BJncsPvBjtYvfBgzNfMwrCX2ha+n4BNHOmaVdU/J5mAkSaNmRzMwKrQKWzhuzzMm4k
         FhVOf8WTbY3Fw==
Received: by mail-lf1-f41.google.com with SMTP id v17so24749134lfd.7;
        Wed, 01 Feb 2023 10:42:06 -0800 (PST)
X-Gm-Message-State: AO0yUKXOr73mJbnLTZu8A9DBPFB86WVwcho3w+dFymCC05v/mbD8fkym
        FDXD6bDrr4rFmuNI0ZqBD5U9tX/VDnR3VxcZUAI=
X-Google-Smtp-Source: AK7set/v5qaomk5OLWHb/nl2GTQV7UtZrR2ZnBeA/i6A6TdXDTjjlMr9eUYLXs1iIiMeBBZbvgT+pATje8ou0mdiOVQ=
X-Received: by 2002:ac2:5159:0:b0:4cb:924e:5987 with SMTP id
 q25-20020ac25159000000b004cb924e5987mr558271lfd.199.1675276924008; Wed, 01
 Feb 2023 10:42:04 -0800 (PST)
MIME-Version: 1.0
References: <20230201173654.2475531-1-song@kernel.org> <a8da8ff9-0c5b-dcea-0e05-e8fa140feb45@csgroup.eu>
In-Reply-To: <a8da8ff9-0c5b-dcea-0e05-e8fa140feb45@csgroup.eu>
From:   Song Liu <song@kernel.org>
Date:   Wed, 1 Feb 2023 10:41:50 -0800
X-Gmail-Original-Message-ID: <CAPhsuW4sf-_yvMjtVbHaQ03c5D=6A8J9irb2sG-w4ggjwWNt8g@mail.gmail.com>
Message-ID: <CAPhsuW4sf-_yvMjtVbHaQ03c5D=6A8J9irb2sG-w4ggjwWNt8g@mail.gmail.com>
Subject: Re: [PATCH v6] module: replace module_layout with module_memory
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "kernel-team@meta.com" <kernel-team@meta.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 1, 2023 at 10:35 AM Christophe Leroy
<christophe.leroy@csgroup.eu> wrote:
>
> Hi,
>
> On what tree / branch does this patch applies ?
>
> I have tried with modules/modules-next, linus/master, with v6.1. It
> conflicts on all of them.
>
> 'git am -3' even says that 'It does not apply to blobs recorded in its
> index.'

Hmmm... I was using "git format-patch -b" to skip space changes. I
guess I should use --ignore-space-at-eol instead.

Resending it.

Thanks,
Song

PS: it was based on modules-next.

>
> Christophe
>
> Le 01/02/2023 =C3=A0 18:36, Song Liu a =C3=A9crit :
> > module_layout manages different types of memory (text, data, rodata, et=
c.)
> > in one allocation, which is problematic for some reasons:
> >
> > 1. It is hard to enable CONFIG_STRICT_MODULE_RWX.
> > 2. It is hard to use huge pages in modules (and not break strict rwx).
> > 3. Many archs uses module_layout for arch-specific data, but it is not
> >     obvious how these data are used (are they RO, RX, or RW?)
> >
> > Improve the scenario by replacing 2 (or 3) module_layout per module wit=
h
> > up to 7 module_memory per module:
> >
> >          MOD_TEXT,
> >          MOD_DATA,
> >          MOD_RODATA,
> >          MOD_RO_AFTER_INIT,
> >          MOD_INIT_TEXT,
> >          MOD_INIT_DATA,
> >          MOD_INIT_RODATA,
> >
> > and allocating them separately. This adds slightly more entries to
> > mod_tree (from up to 3 entries per module, to up to 7 entries per
> > module). However, this at most adds a small constant overhead to
> > __module_address(), which is expected to be fast.
> >
> > Various archs use module_layout for different data. These data are put
> > into different module_memory based on their location in module_layout.
> > IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT=
;
> > data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc=
.
> >
> > module_memory simplifies quite some of the module code. For example,
> > ARCH_WANTS_MODULES_DATA_IN_VMALLOC is a lot cleaner, as it just uses a
> > different allocator for the data. kernel/module/strict_rwx.c is also
> > much cleaner with module_memory.
> >
> > Signed-off-by: Song Liu <song@kernel.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
> >
> > ---
> >
> > This is the preparation work for the type aware module_alloc() discusse=
d
> > in [1]. While this work is not covered much in the discussion, it is a
> > critical step of the effort.
> >
> > As this part grows pretty big (~1000 lines, + and -), I would like get
> > some feedback on it, so that I know it is on the right track.
> >
> > Please share your comments. Thanks!
> >
> > Test coverage: Tested on x86_64.
> > Build tested by kernel test bot in [2]. The only regression in [2] was =
a
> > typo in parisc, which is also fixed.
> >
> > [1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kern=
el.org/T/#u
> > [2] https://lore.kernel.org/linux-raid/63b8827e.clJQX2wg+I+tiX7m%25lkp@=
intel.com/T/#u
> >
> > Changes v1 =3D> v2:
> > 1. Add data_addr_[min|max] for CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLO=
C
> >     case.
> >
> > Changes v2 =3D> v3:
> > 1. Fix and remove the last use of INIT_OFFSET_MASK.
> > 2. Add more information in the commit log. (Luis Chamberlain)
> > 3. Rebase and fix issues in x86/calltrunks.
> > 4. Minor cleanup.
> >
> > Changes v3 =3D> v4:
> > 1. Shorten enum/variable names, so that the code are easier to read.
> >     (Christophe Leroy)
> > 2. Remove an used variable. (Guenter Roeck, Christophe Leroy)
> >
> > Changes v4 =3D> v5:
> > 1. Simplify some code some code. (Peter Zijlstra, Christophe Leroy)
> > 2. Remove module_check_misalignment(), which is not useful any more.
> >
> > Changes v5 =3D> v6:
> > 1. Improve mod_mem_type_is_* and for_*mod_mem_type marcos.
> >     (Peter Zijlstra).
> > ---
> >   arch/alpha/kernel/module.c      |   2 +-
> >   arch/arc/kernel/unwind.c        |   9 +-
> >   arch/arm/kernel/module-plts.c   |   2 +-
> >   arch/arm64/kernel/module-plts.c |   2 +-
> >   arch/ia64/kernel/module.c       |  24 ++-
> >   arch/mips/kernel/vpe.c          |  11 +-
> >   arch/parisc/kernel/module.c     |  51 ++---
> >   arch/powerpc/kernel/module_32.c |   7 +-
> >   arch/s390/kernel/module.c       |  26 +--
> >   arch/x86/kernel/callthunks.c    |   4 +-
> >   arch/x86/kernel/module.c        |   4 +-
> >   include/linux/module.h          |  86 +++++---
> >   kernel/module/internal.h        |  40 ++--
> >   kernel/module/kallsyms.c        |  56 ++---
> >   kernel/module/kdb.c             |  17 +-
> >   kernel/module/main.c            | 355 ++++++++++++++++++-------------=
-
> >   kernel/module/procfs.c          |  16 +-
> >   kernel/module/strict_rwx.c      | 100 ++-------
> >   kernel/module/tree_lookup.c     |  39 ++--
> >   19 files changed, 432 insertions(+), 419 deletions(-)
> >
> > diff --git a/arch/alpha/kernel/module.c b/arch/alpha/kernel/module.c
> > index 5b60c248de9e..9109213abc09 100644
> > --- a/arch/alpha/kernel/module.c
> > +++ b/arch/alpha/kernel/module.c
> > @@ -148,7 +148,7 @@ apply_relocate_add(Elf64_Shdr *sechdrs, const char =
*strtab,
> >
> >       /* The small sections were sorted to the end of the segment.
> >          The following should definitely cover them.  */
> > -     gp =3D (u64)me->core_layout.base + me->core_layout.size - 0x8000;
> > +     gp =3D (u64)me->mem[MOD_DATA].base + me->mem[MOD_DATA].size - 0x8=
000;
> >       got =3D sechdrs[me->arch.gotsecindex].sh_addr;
> >
> >       for (i =3D 0; i < n; i++) {
> > diff --git a/arch/arc/kernel/unwind.c b/arch/arc/kernel/unwind.c
> > index 200270a94558..933451f4494f 100644
> > --- a/arch/arc/kernel/unwind.c
> > +++ b/arch/arc/kernel/unwind.c
> > @@ -369,6 +369,8 @@ void *unwind_add_table(struct module *module, const=
 void *table_start,
> >                      unsigned long table_size)
> >   {
> >       struct unwind_table *table;
> > +     struct module_memory *mod_mem_core_text;
> > +     struct module_memory *mod_mem_init_text;
> >
> >       if (table_size <=3D 0)
> >               return NULL;
> > @@ -377,9 +379,12 @@ void *unwind_add_table(struct module *module, cons=
t void *table_start,
> >       if (!table)
> >               return NULL;
> >
> > +     mod_mem_core_text =3D &module->mem[MOD_TEXT];
> > +     mod_mem_init_text =3D &module->mem[MOD_INIT_TEXT];
> > +
> >       init_unwind_table(table, module->name,
> > -                       module->core_layout.base, module->core_layout.s=
ize,
> > -                       module->init_layout.base, module->init_layout.s=
ize,
> > +                       mod_mem_core_text->base, mod_mem_core_text->siz=
e,
> > +                       mod_mem_init_text->base, mod_mem_init_text->siz=
e,
> >                         table_start, table_size,
> >                         NULL, 0);
> >
> > diff --git a/arch/arm/kernel/module-plts.c b/arch/arm/kernel/module-plt=
s.c
> > index af7c322ebed6..9d4ecb6b1412 100644
> > --- a/arch/arm/kernel/module-plts.c
> > +++ b/arch/arm/kernel/module-plts.c
> > @@ -30,7 +30,7 @@ static const u32 fixed_plts[] =3D {
> >
> >   static bool in_init(const struct module *mod, unsigned long loc)
> >   {
> > -     return loc - (u32)mod->init_layout.base < mod->init_layout.size;
> > +     return within_module_init(loc, mod);
> >   }
> >
> >   static void prealloc_fixed(struct mod_plt_sec *pltsec, struct plt_ent=
ries *plt)
> > diff --git a/arch/arm64/kernel/module-plts.c b/arch/arm64/kernel/module=
-plts.c
> > index 5a0a8f552a61..fedffa83a283 100644
> > --- a/arch/arm64/kernel/module-plts.c
> > +++ b/arch/arm64/kernel/module-plts.c
> > @@ -67,7 +67,7 @@ static bool plt_entries_equal(const struct plt_entry =
*a,
> >
> >   static bool in_init(const struct module *mod, void *loc)
> >   {
> > -     return (u64)loc - (u64)mod->init_layout.base < mod->init_layout.s=
ize;
> > +     return within_module_init(loc, mod);
> >   }
> >
> >   u64 module_emit_plt_entry(struct module *mod, Elf64_Shdr *sechdrs,
> > diff --git a/arch/ia64/kernel/module.c b/arch/ia64/kernel/module.c
> > index 8f62cf97f691..3661135da9d9 100644
> > --- a/arch/ia64/kernel/module.c
> > +++ b/arch/ia64/kernel/module.c
> > @@ -485,19 +485,19 @@ module_frob_arch_sections (Elf_Ehdr *ehdr, Elf_Sh=
dr *sechdrs, char *secstrings,
> >       return 0;
> >   }
> >
> > -static inline int
> > +static inline bool
> >   in_init (const struct module *mod, uint64_t addr)
> >   {
> > -     return addr - (uint64_t) mod->init_layout.base < mod->init_layout=
.size;
> > +     return within_module_init(addr, mod);
> >   }
> >
> > -static inline int
> > +static inline bool
> >   in_core (const struct module *mod, uint64_t addr)
> >   {
> > -     return addr - (uint64_t) mod->core_layout.base < mod->core_layout=
.size;
> > +     return within_module_core(addr, mod);
> >   }
> >
> > -static inline int
> > +static inline bool
> >   is_internal (const struct module *mod, uint64_t value)
> >   {
> >       return in_init(mod, value) || in_core(mod, value);
> > @@ -677,7 +677,8 @@ do_reloc (struct module *mod, uint8_t r_type, Elf64=
_Sym *sym, uint64_t addend,
> >               break;
> >
> >             case RV_BDREL:
> > -             val -=3D (uint64_t) (in_init(mod, val) ? mod->init_layout=
.base : mod->core_layout.base);
> > +             val -=3D (uint64_t) (in_init(mod, val) ? mod->mem[MOD_INI=
T_TEXT].base :
> > +                                mod->mem[MOD_TEXT].base);
> >               break;
> >
> >             case RV_LTV:
> > @@ -812,15 +813,18 @@ apply_relocate_add (Elf64_Shdr *sechdrs, const ch=
ar *strtab, unsigned int symind
> >                *     addresses have been selected...
> >                */
> >               uint64_t gp;
> > -             if (mod->core_layout.size > MAX_LTOFF)
> > +             struct module_memory *mod_mem;
> > +
> > +             mod_mem =3D &mod->mem[MOD_DATA];
> > +             if (mod_mem->size > MAX_LTOFF)
> >                       /*
> >                        * This takes advantage of fact that SHF_ARCH_SMA=
LL gets allocated
> >                        * at the end of the module.
> >                        */
> > -                     gp =3D mod->core_layout.size - MAX_LTOFF / 2;
> > +                     gp =3D mod_mem->size - MAX_LTOFF / 2;
> >               else
> > -                     gp =3D mod->core_layout.size / 2;
> > -             gp =3D (uint64_t) mod->core_layout.base + ((gp + 7) & -8)=
;
> > +                     gp =3D mod_mem->size / 2;
> > +             gp =3D (uint64_t) mod_mem->base + ((gp + 7) & -8);
> >               mod->arch.gp =3D gp;
> >               DEBUGP("%s: placing gp at 0x%lx\n", __func__, gp);
> >       }
> > diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
> > index 13294972707b..ab114c686f9d 100644
> > --- a/arch/mips/kernel/vpe.c
> > +++ b/arch/mips/kernel/vpe.c
> > @@ -199,18 +199,17 @@ static void layout_sections(struct module *mod, c=
onst Elf_Ehdr *hdr,
> >       for (m =3D 0; m < ARRAY_SIZE(masks); ++m) {
> >               for (i =3D 0; i < hdr->e_shnum; ++i) {
> >                       Elf_Shdr *s =3D &sechdrs[i];
> > +                     struct module_memory *mod_mem;
> > +
> > +                     mod_mem =3D &mod->mem[MOD_TEXT];
> >
> >                       if ((s->sh_flags & masks[m][0]) !=3D masks[m][0]
> >                           || (s->sh_flags & masks[m][1])
> >                           || s->sh_entsize !=3D ~0UL)
> >                               continue;
> >                       s->sh_entsize =3D
> > -                             get_offset((unsigned long *)&mod->core_la=
yout.size, s);
> > +                             get_offset((unsigned long *)&mod_mem->siz=
e, s);
> >               }
> > -
> > -             if (m =3D=3D 0)
> > -                     mod->core_layout.text_size =3D mod->core_layout.s=
ize;
> > -
> >       }
> >   }
> >
> > @@ -641,7 +640,7 @@ static int vpe_elfload(struct vpe *v)
> >               layout_sections(&mod, hdr, sechdrs, secstrings);
> >       }
> >
> > -     v->load_addr =3D alloc_progmem(mod.core_layout.size);
> > +     v->load_addr =3D alloc_progmem(mod.mod_mem[MOD_TEXT].size);
> >       if (!v->load_addr)
> >               return -ENOMEM;
> >
> > diff --git a/arch/parisc/kernel/module.c b/arch/parisc/kernel/module.c
> > index 7df140545b22..f6e38c4d3904 100644
> > --- a/arch/parisc/kernel/module.c
> > +++ b/arch/parisc/kernel/module.c
> > @@ -27,9 +27,9 @@
> >    *      We are not doing SEGREL32 handling correctly. According to th=
e ABI, we
> >    *      should do a value offset, like this:
> >    *                  if (in_init(me, (void *)val))
> > - *                           val -=3D (uint32_t)me->init_layout.base;
> > + *                           val -=3D (uint32_t)me->mem[MOD_INIT_TEXT]=
.base;
> >    *                  else
> > - *                           val -=3D (uint32_t)me->core_layout.base;
> > + *                           val -=3D (uint32_t)me->mem[MOD_TEXT].base=
;
> >    *  However, SEGREL32 is used only for PARISC unwind entries, and we =
want
> >    *  those entries to have an absolute address, and not just an offset=
.
> >    *
> > @@ -76,25 +76,6 @@
> >    * allows us to allocate up to 4095 GOT entries. */
> >   #define MAX_GOTS    4095
> >
> > -/* three functions to determine where in the module core
> > - * or init pieces the location is */
> > -static inline int in_init(struct module *me, void *loc)
> > -{
> > -     return (loc >=3D me->init_layout.base &&
> > -             loc <=3D (me->init_layout.base + me->init_layout.size));
> > -}
> > -
> > -static inline int in_core(struct module *me, void *loc)
> > -{
> > -     return (loc >=3D me->core_layout.base &&
> > -             loc <=3D (me->core_layout.base + me->core_layout.size));
> > -}
> > -
> > -static inline int in_local(struct module *me, void *loc)
> > -{
> > -     return in_init(me, loc) || in_core(me, loc);
> > -}
> > -
> >   #ifndef CONFIG_64BIT
> >   struct got_entry {
> >       Elf32_Addr addr;
> > @@ -302,6 +283,7 @@ int module_frob_arch_sections(CONST Elf_Ehdr *hdr,
> >   {
> >       unsigned long gots =3D 0, fdescs =3D 0, len;
> >       unsigned int i;
> > +     struct module_memory *mod_mem;
> >
> >       len =3D hdr->e_shnum * sizeof(me->arch.section[0]);
> >       me->arch.section =3D kzalloc(len, GFP_KERNEL);
> > @@ -346,14 +328,15 @@ int module_frob_arch_sections(CONST Elf_Ehdr *hdr=
,
> >               me->arch.section[s].stub_entries +=3D count;
> >       }
> >
> > +     mod_mem =3D &me->mem[MOD_TEXT];
> >       /* align things a bit */
> > -     me->core_layout.size =3D ALIGN(me->core_layout.size, 16);
> > -     me->arch.got_offset =3D me->core_layout.size;
> > -     me->core_layout.size +=3D gots * sizeof(struct got_entry);
> > +     mod_mem->size =3D ALIGN(mod_mem->size, 16);
> > +     me->arch.got_offset =3D mod_mem->size;
> > +     mod_mem->size +=3D gots * sizeof(struct got_entry);
> >
> > -     me->core_layout.size =3D ALIGN(me->core_layout.size, 16);
> > -     me->arch.fdesc_offset =3D me->core_layout.size;
> > -     me->core_layout.size +=3D fdescs * sizeof(Elf_Fdesc);
> > +     mod_mem->size =3D ALIGN(mod_mem->size, 16);
> > +     me->arch.fdesc_offset =3D mod_mem->size;
> > +     mod_mem->size +=3D fdescs * sizeof(Elf_Fdesc);
> >
> >       me->arch.got_max =3D gots;
> >       me->arch.fdesc_max =3D fdescs;
> > @@ -371,7 +354,7 @@ static Elf64_Word get_got(struct module *me, unsign=
ed long value, long addend)
> >
> >       BUG_ON(value =3D=3D 0);
> >
> > -     got =3D me->core_layout.base + me->arch.got_offset;
> > +     got =3D me->mem[MOD_TEXT].base + me->arch.got_offset;
> >       for (i =3D 0; got[i].addr; i++)
> >               if (got[i].addr =3D=3D value)
> >                       goto out;
> > @@ -389,7 +372,7 @@ static Elf64_Word get_got(struct module *me, unsign=
ed long value, long addend)
> >   #ifdef CONFIG_64BIT
> >   static Elf_Addr get_fdesc(struct module *me, unsigned long value)
> >   {
> > -     Elf_Fdesc *fdesc =3D me->core_layout.base + me->arch.fdesc_offset=
;
> > +     Elf_Fdesc *fdesc =3D me->mem[MOD_TEXT].base + me->arch.fdesc_offs=
et;
> >
> >       if (!value) {
> >               printk(KERN_ERR "%s: zero OPD requested!\n", me->name);
> > @@ -407,7 +390,7 @@ static Elf_Addr get_fdesc(struct module *me, unsign=
ed long value)
> >
> >       /* Create new one */
> >       fdesc->addr =3D value;
> > -     fdesc->gp =3D (Elf_Addr)me->core_layout.base + me->arch.got_offse=
t;
> > +     fdesc->gp =3D (Elf_Addr)me->mem[MOD_TEXT].base + me->arch.got_off=
set;
> >       return (Elf_Addr)fdesc;
> >   }
> >   #endif /* CONFIG_64BIT */
> > @@ -742,7 +725,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
> >                              loc, val);
> >                       val +=3D addend;
> >                       /* can we reach it locally? */
> > -                     if (in_local(me, (void *)val)) {
> > +                     if (within_module(val, me)) {
> >                               /* this is the case where the symbol is l=
ocal
> >                                * to the module, but in a different sect=
ion,
> >                                * so stub the jump in case it's more tha=
n 22
> > @@ -801,7 +784,7 @@ int apply_relocate_add(Elf_Shdr *sechdrs,
> >                       break;
> >               case R_PARISC_FPTR64:
> >                       /* 64-bit function address */
> > -                     if(in_local(me, (void *)(val + addend))) {
> > +                     if (within_module(val + addend, me)) {
> >                               *loc64 =3D get_fdesc(me, val+addend);
> >                               pr_debug("FDESC for %s at %llx points to =
%llx\n",
> >                                      strtab + sym->st_name, *loc64,
> > @@ -839,7 +822,7 @@ register_unwind_table(struct module *me,
> >
> >       table =3D (unsigned char *)sechdrs[me->arch.unwind_section].sh_ad=
dr;
> >       end =3D table + sechdrs[me->arch.unwind_section].sh_size;
> > -     gp =3D (Elf_Addr)me->core_layout.base + me->arch.got_offset;
> > +     gp =3D (Elf_Addr)me->mem[MOD_TEXT].base + me->arch.got_offset;
> >
> >       pr_debug("register_unwind_table(), sect =3D %d at 0x%p - 0x%p (gp=
=3D0x%lx)\n",
> >              me->arch.unwind_section, table, end, gp);
> > @@ -977,7 +960,7 @@ void module_arch_cleanup(struct module *mod)
> >   #ifdef CONFIG_64BIT
> >   void *dereference_module_function_descriptor(struct module *mod, void=
 *ptr)
> >   {
> > -     unsigned long start_opd =3D (Elf64_Addr)mod->core_layout.base +
> > +     unsigned long start_opd =3D (Elf64_Addr)mod->mem[MOD_TEXT].base +
> >                                  mod->arch.fdesc_offset;
> >       unsigned long end_opd =3D start_opd +
> >                               mod->arch.fdesc_count * sizeof(Elf64_Fdes=
c);
> > diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/modu=
le_32.c
> > index ea6536171778..2729179e9dc0 100644
> > --- a/arch/powerpc/kernel/module_32.c
> > +++ b/arch/powerpc/kernel/module_32.c
> > @@ -163,8 +163,7 @@ static uint32_t do_plt_call(void *location,
> >
> >       pr_debug("Doing plt for call to 0x%x at 0x%x\n", val, (unsigned i=
nt)location);
> >       /* Init, or core PLT? */
> > -     if (location >=3D mod->core_layout.base
> > -         && location < mod->core_layout.base + mod->core_layout.size)
> > +     if (within_module_init(location, mod))
> >               entry =3D (void *)sechdrs[mod->arch.core_plt_section].sh_=
addr;
> >       else
> >               entry =3D (void *)sechdrs[mod->arch.init_plt_section].sh_=
addr;
> > @@ -322,14 +321,14 @@ notrace int module_trampoline_target(struct modul=
e *mod, unsigned long addr,
> >
> >   int module_finalize_ftrace(struct module *module, const Elf_Shdr *sec=
hdrs)
> >   {
> > -     module->arch.tramp =3D do_plt_call(module->core_layout.base,
> > +     module->arch.tramp =3D do_plt_call(module->mem[MOD_TEXT].base,
> >                                        (unsigned long)ftrace_caller,
> >                                        sechdrs, module);
> >       if (!module->arch.tramp)
> >               return -ENOENT;
> >
> >   #ifdef CONFIG_DYNAMIC_FTRACE_WITH_REGS
> > -     module->arch.tramp_regs =3D do_plt_call(module->core_layout.base,
> > +     module->arch.tramp_regs =3D do_plt_call(module->mem[MOD_TEXT].bas=
e,
> >                                             (unsigned long)ftrace_regs_=
caller,
> >                                             sechdrs, module);
> >       if (!module->arch.tramp_regs)
> > diff --git a/arch/s390/kernel/module.c b/arch/s390/kernel/module.c
> > index 2d159b32885b..3ed455b785ad 100644
> > --- a/arch/s390/kernel/module.c
> > +++ b/arch/s390/kernel/module.c
> > @@ -126,6 +126,7 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_Sh=
dr *sechdrs,
> >       Elf_Rela *rela;
> >       char *strings;
> >       int nrela, i, j;
> > +     struct module_memory *mod_mem;
> >
> >       /* Find symbol table and string table. */
> >       symtab =3D NULL;
> > @@ -173,14 +174,15 @@ int module_frob_arch_sections(Elf_Ehdr *hdr, Elf_=
Shdr *sechdrs,
> >
> >       /* Increase core size by size of got & plt and set start
> >          offsets for got and plt. */
> > -     me->core_layout.size =3D ALIGN(me->core_layout.size, 4);
> > -     me->arch.got_offset =3D me->core_layout.size;
> > -     me->core_layout.size +=3D me->arch.got_size;
> > -     me->arch.plt_offset =3D me->core_layout.size;
> > +     mod_mem =3D &me->mem[MOD_TEXT];
> > +     mod_mem->size =3D ALIGN(mod_mem->size, 4);
> > +     me->arch.got_offset =3D mod_mem->size;
> > +     mod_mem->size +=3D me->arch.got_size;
> > +     me->arch.plt_offset =3D mod_mem->size;
> >       if (me->arch.plt_size) {
> >               if (IS_ENABLED(CONFIG_EXPOLINE) && !nospec_disable)
> >                       me->arch.plt_size +=3D PLT_ENTRY_SIZE;
> > -             me->core_layout.size +=3D me->arch.plt_size;
> > +             mod_mem->size +=3D me->arch.plt_size;
> >       }
> >       return 0;
> >   }
> > @@ -304,7 +306,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base=
, Elf_Sym *symtab,
> >       case R_390_GOTPLT64:    /* 64 bit offset to jump slot.  */
> >       case R_390_GOTPLTENT:   /* 32 bit rel. offset to jump slot >> 1. =
*/
> >               if (info->got_initialized =3D=3D 0) {
> > -                     Elf_Addr *gotent =3D me->core_layout.base +
> > +                     Elf_Addr *gotent =3D me->mem[MOD_TEXT].base +
> >                                          me->arch.got_offset +
> >                                          info->got_offset;
> >
> > @@ -329,7 +331,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base=
, Elf_Sym *symtab,
> >                       rc =3D apply_rela_bits(loc, val, 0, 64, 0, write)=
;
> >               else if (r_type =3D=3D R_390_GOTENT ||
> >                        r_type =3D=3D R_390_GOTPLTENT) {
> > -                     val +=3D (Elf_Addr) me->core_layout.base - loc;
> > +                     val +=3D (Elf_Addr) me->mem[MOD_TEXT].base - loc;
> >                       rc =3D apply_rela_bits(loc, val, 1, 32, 1, write)=
;
> >               }
> >               break;
> > @@ -345,7 +347,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base=
, Elf_Sym *symtab,
> >                       char *plt_base;
> >                       char *ip;
> >
> > -                     plt_base =3D me->core_layout.base + me->arch.plt_=
offset;
> > +                     plt_base =3D me->mem[MOD_TEXT].base + me->arch.pl=
t_offset;
> >                       ip =3D plt_base + info->plt_offset;
> >                       *(int *)insn =3D 0x0d10e310;      /* basr 1,0  */
> >                       *(int *)&insn[4] =3D 0x100c0004;  /* lg   1,12(1)=
 */
> > @@ -375,7 +377,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base=
, Elf_Sym *symtab,
> >                              val - loc + 0xffffUL < 0x1ffffeUL) ||
> >                             (r_type =3D=3D R_390_PLT32DBL &&
> >                              val - loc + 0xffffffffULL < 0x1fffffffeULL=
)))
> > -                             val =3D (Elf_Addr) me->core_layout.base +
> > +                             val =3D (Elf_Addr) me->mem[MOD_TEXT].base=
 +
> >                                       me->arch.plt_offset +
> >                                       info->plt_offset;
> >                       val +=3D rela->r_addend - loc;
> > @@ -397,7 +399,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base=
, Elf_Sym *symtab,
> >       case R_390_GOTOFF32:    /* 32 bit offset to GOT.  */
> >       case R_390_GOTOFF64:    /* 64 bit offset to GOT. */
> >               val =3D val + rela->r_addend -
> > -                     ((Elf_Addr) me->core_layout.base + me->arch.got_o=
ffset);
> > +                     ((Elf_Addr) me->mem[MOD_TEXT].base + me->arch.got=
_offset);
> >               if (r_type =3D=3D R_390_GOTOFF16)
> >                       rc =3D apply_rela_bits(loc, val, 0, 16, 0, write)=
;
> >               else if (r_type =3D=3D R_390_GOTOFF32)
> > @@ -407,7 +409,7 @@ static int apply_rela(Elf_Rela *rela, Elf_Addr base=
, Elf_Sym *symtab,
> >               break;
> >       case R_390_GOTPC:       /* 32 bit PC relative offset to GOT. */
> >       case R_390_GOTPCDBL:    /* 32 bit PC rel. off. to GOT shifted by =
1. */
> > -             val =3D (Elf_Addr) me->core_layout.base + me->arch.got_of=
fset +
> > +             val =3D (Elf_Addr) me->mem[MOD_TEXT].base + me->arch.got_=
offset +
> >                       rela->r_addend - loc;
> >               if (r_type =3D=3D R_390_GOTPC)
> >                       rc =3D apply_rela_bits(loc, val, 1, 32, 0, write)=
;
> > @@ -515,7 +517,7 @@ int module_finalize(const Elf_Ehdr *hdr,
> >           !nospec_disable && me->arch.plt_size) {
> >               unsigned int *ij;
> >
> > -             ij =3D me->core_layout.base + me->arch.plt_offset +
> > +             ij =3D me->mem[MOD_TEXT].base + me->arch.plt_offset +
> >                       me->arch.plt_size - PLT_ENTRY_SIZE;
> >               ij[0] =3D 0xc6000000;     /* exrl %r0,.+10        */
> >               ij[1] =3D 0x0005a7f4;     /* j    .               */
> > diff --git a/arch/x86/kernel/callthunks.c b/arch/x86/kernel/callthunks.=
c
> > index ffea98f9064b..22ab13966427 100644
> > --- a/arch/x86/kernel/callthunks.c
> > +++ b/arch/x86/kernel/callthunks.c
> > @@ -330,8 +330,8 @@ void noinline callthunks_patch_module_calls(struct =
callthunk_sites *cs,
> >                                           struct module *mod)
> >   {
> >       struct core_text ct =3D {
> > -             .base =3D (unsigned long)mod->core_layout.base,
> > -             .end  =3D (unsigned long)mod->core_layout.base + mod->cor=
e_layout.size,
> > +             .base =3D (unsigned long)mod->mem[MOD_TEXT].base,
> > +             .end  =3D (unsigned long)mod->mem[MOD_TEXT].base + mod->m=
em[MOD_TEXT].size,
> >               .name =3D mod->name,
> >       };
> >
> > diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
> > index 705fb2a41d7d..dbc8e226c464 100644
> > --- a/arch/x86/kernel/module.c
> > +++ b/arch/x86/kernel/module.c
> > @@ -339,8 +339,8 @@ int module_finalize(const Elf_Ehdr *hdr,
> >       }
> >       if (locks) {
> >               void *lseg =3D (void *)locks->sh_addr;
> > -             void *text =3D me->core_layout.base;
> > -             void *text_end =3D text + me->core_layout.text_size;
> > +             void *text =3D me->mem[MOD_TEXT].base;
> > +             void *text_end =3D text + me->mem[MOD_TEXT].size;
> >               alternatives_smp_module_add(me, me->name,
> >                                           lseg, lseg + locks->sh_size,
> >                                           text, text_end);
> > diff --git a/include/linux/module.h b/include/linux/module.h
> > index 8c5909c0076c..ccc9de8a93db 100644
> > --- a/include/linux/module.h
> > +++ b/include/linux/module.h
> > @@ -320,17 +320,47 @@ struct mod_tree_node {
> >       struct latch_tree_node node;
> >   };
> >
> > -struct module_layout {
> > -     /* The actual code + data. */
> > +enum mod_mem_type {
> > +     MOD_TEXT =3D 0,
> > +     MOD_DATA,
> > +     MOD_RODATA,
> > +     MOD_RO_AFTER_INIT,
> > +     MOD_INIT_TEXT,
> > +     MOD_INIT_DATA,
> > +     MOD_INIT_RODATA,
> > +
> > +     MOD_MEM_NUM_TYPES,
> > +     MOD_INVALID =3D -1,
> > +};
> > +
> > +#define mod_mem_type_is_init(type)   \
> > +     ((type) =3D=3D MOD_INIT_TEXT ||     \
> > +      (type) =3D=3D MOD_INIT_DATA ||     \
> > +      (type) =3D=3D MOD_INIT_RODATA)
> > +
> > +#define mod_mem_type_is_core(type) (!mod_mem_type_is_init(type))
> > +
> > +#define mod_mem_type_is_text(type)   \
> > +      ((type) =3D=3D MOD_TEXT ||         \
> > +       (type) =3D=3D MOD_INIT_TEXT)
> > +
> > +#define mod_mem_type_is_data(type) (!mod_mem_type_is_text(type))
> > +
> > +#define mod_mem_type_is_core_data(type)      \
> > +     (mod_mem_type_is_core(type) &&  \
> > +      mod_mem_type_is_data(type))
> > +
> > +#define for_each_mod_mem_type(type)                  \
> > +     for (enum mod_mem_type (type) =3D 0;              \
> > +          (type) < MOD_MEM_NUM_TYPES; (type)++)
> > +
> > +#define for_class_mod_mem_type(type, class)          \
> > +     for_each_mod_mem_type(type)                     \
> > +             if (mod_mem_type_is_##class(type))
> > +
> > +struct module_memory {
> >       void *base;
> > -     /* Total size. */
> >       unsigned int size;
> > -     /* The size of the executable code.  */
> > -     unsigned int text_size;
> > -     /* Size of RO section of the module (text+rodata) */
> > -     unsigned int ro_size;
> > -     /* Size of RO after init section */
> > -     unsigned int ro_after_init_size;
> >
> >   #ifdef CONFIG_MODULES_TREE_LOOKUP
> >       struct mod_tree_node mtn;
> > @@ -339,9 +369,9 @@ struct module_layout {
> >
> >   #ifdef CONFIG_MODULES_TREE_LOOKUP
> >   /* Only touch one cacheline for common rbtree-for-core-layout case. *=
/
> > -#define __module_layout_align ____cacheline_aligned
> > +#define __module_memory_align ____cacheline_aligned
> >   #else
> > -#define __module_layout_align
> > +#define __module_memory_align
> >   #endif
> >
> >   struct mod_kallsyms {
> > @@ -418,12 +448,8 @@ struct module {
> >       /* Startup function. */
> >       int (*init)(void);
> >
> > -     /* Core layout: rbtree is accessed frequently, so keep together. =
*/
> > -     struct module_layout core_layout __module_layout_align;
> > -     struct module_layout init_layout;
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     struct module_layout data_layout;
> > -#endif
> > +     /* rbtree is accessed frequently, so keep together. */
> > +     struct module_memory mem[MOD_MEM_NUM_TYPES] __module_memory_align=
;
> >
> >       /* Arch-specific module values */
> >       struct mod_arch_specific arch;
> > @@ -573,23 +599,33 @@ bool __is_module_percpu_address(unsigned long add=
r, unsigned long *can_addr);
> >   bool is_module_percpu_address(unsigned long addr);
> >   bool is_module_text_address(unsigned long addr);
> >
> > +static inline bool within_module_mem_type(unsigned long addr,
> > +                                       const struct module *mod,
> > +                                       enum mod_mem_type type)
> > +{
> > +     unsigned long base, size;
> > +
> > +     base =3D (unsigned long)mod->mem[type].base;
> > +     size =3D mod->mem[type].size;
> > +     return addr - base < size;
> > +}
> > +
> >   static inline bool within_module_core(unsigned long addr,
> >                                     const struct module *mod)
> >   {
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     if ((unsigned long)mod->data_layout.base <=3D addr &&
> > -         addr < (unsigned long)mod->data_layout.base + mod->data_layou=
t.size)
> > +     for_class_mod_mem_type(type, core)
> > +             if (within_module_mem_type(addr, mod, type))
> >                       return true;
> > -#endif
> > -     return (unsigned long)mod->core_layout.base <=3D addr &&
> > -            addr < (unsigned long)mod->core_layout.base + mod->core_la=
yout.size;
> > +     return false;
> >   }
> >
> >   static inline bool within_module_init(unsigned long addr,
> >                                     const struct module *mod)
> >   {
> > -     return (unsigned long)mod->init_layout.base <=3D addr &&
> > -            addr < (unsigned long)mod->init_layout.base + mod->init_la=
yout.size;
> > +     for_class_mod_mem_type(type, init)
> > +             if (within_module_mem_type(addr, mod, type))
> > +                     return true;
> > +     return false;
> >   }
> >
> >   static inline bool within_module(unsigned long addr, const struct mod=
ule *mod)
> > diff --git a/kernel/module/internal.h b/kernel/module/internal.h
> > index 2e2bf236f558..c6c44ceca07a 100644
> > --- a/kernel/module/internal.h
> > +++ b/kernel/module/internal.h
> > @@ -17,27 +17,19 @@
> >   #define ARCH_SHF_SMALL 0
> >   #endif
> >
> > -/* If this is set, the section belongs in the init part of the module =
*/
> > -#define INIT_OFFSET_MASK (1UL << (BITS_PER_LONG - 1))
> > -/* Maximum number of characters written by module_flags() */
> > -#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
> > -
> > -#ifndef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -#define      data_layout core_layout
> > -#endif
> > -
> >   /*
> > - * Modules' sections will be aligned on page boundaries
> > - * to ensure complete separation of code and data, but
> > - * only when CONFIG_STRICT_MODULE_RWX=3Dy
> > + * Use highest 4 bits of sh_entsize to store the mod_mem_type of this
> > + * section. This leaves 28 bits for offset on 32-bit systems, which is
> > + * about 256 MiB (WARN_ON_ONCE if we exceed that).
> >    */
> > -static inline unsigned int strict_align(unsigned int size)
> > -{
> > -     if (IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> > -             return PAGE_ALIGN(size);
> > -     else
> > -             return size;
> > -}
> > +
> > +#define SH_ENTSIZE_TYPE_BITS 4
> > +#define SH_ENTSIZE_TYPE_SHIFT        (BITS_PER_LONG - SH_ENTSIZE_TYPE_=
BITS)
> > +#define SH_ENTSIZE_TYPE_MASK ((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
> > +#define SH_ENTSIZE_OFFSET_MASK       ((1UL << (BITS_PER_LONG - SH_ENTS=
IZE_TYPE_BITS)) - 1)
> > +
> > +/* Maximum number of characters written by module_flags() */
> > +#define MODULE_FLAGS_BUF_SIZE (TAINT_FLAGS_COUNT + 4)
> >
> >   extern struct mutex module_mutex;
> >   extern struct list_head modules;
> > @@ -101,8 +93,8 @@ int try_to_force_load(struct module *mod, const char=
 *reason);
> >   bool find_symbol(struct find_symbol_arg *fsa);
> >   struct module *find_module_all(const char *name, size_t len, bool eve=
n_unformed);
> >   int cmp_name(const void *name, const void *sym);
> > -long module_get_offset(struct module *mod, unsigned int *size, Elf_Shd=
r *sechdr,
> > -                    unsigned int section);
> > +long module_get_offset_and_type(struct module *mod, enum mod_mem_type =
type,
> > +                             Elf_Shdr *sechdr, unsigned int section);
> >   char *module_flags(struct module *mod, char *buf, bool show_state);
> >   size_t module_flags_taint(unsigned long taints, char *buf);
> >
> > @@ -190,10 +182,13 @@ struct mod_tree_root {
> >   #endif
> >       unsigned long addr_min;
> >       unsigned long addr_max;
> > +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > +     unsigned long data_addr_min;
> > +     unsigned long data_addr_max;
> > +#endif
> >   };
> >
> >   extern struct mod_tree_root mod_tree;
> > -extern struct mod_tree_root mod_data_tree;
> >
> >   #ifdef CONFIG_MODULES_TREE_LOOKUP
> >   void mod_tree_insert(struct module *mod);
> > @@ -224,7 +219,6 @@ void module_enable_nx(const struct module *mod);
> >   void module_enable_x(const struct module *mod);
> >   int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> >                               char *secstrings, struct module *mod);
> > -bool module_check_misalignment(const struct module *mod);
> >
> >   #ifdef CONFIG_MODULE_SIG
> >   int module_sig_check(struct load_info *info, int flags);
> > diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> > index 4523f99b0358..acdca7692961 100644
> > --- a/kernel/module/kallsyms.c
> > +++ b/kernel/module/kallsyms.c
> > @@ -78,6 +78,7 @@ static bool is_core_symbol(const Elf_Sym *src, const =
Elf_Shdr *sechdrs,
> >                          unsigned int shnum, unsigned int pcpundx)
> >   {
> >       const Elf_Shdr *sec;
> > +     enum mod_mem_type type;
> >
> >       if (src->st_shndx =3D=3D SHN_UNDEF ||
> >           src->st_shndx >=3D shnum ||
> > @@ -90,11 +91,12 @@ static bool is_core_symbol(const Elf_Sym *src, cons=
t Elf_Shdr *sechdrs,
> >   #endif
> >
> >       sec =3D sechdrs + src->st_shndx;
> > +     type =3D sec->sh_entsize >> SH_ENTSIZE_TYPE_SHIFT;
> >       if (!(sec->sh_flags & SHF_ALLOC)
> >   #ifndef CONFIG_KALLSYMS_ALL
> >           || !(sec->sh_flags & SHF_EXECINSTR)
> >   #endif
> > -         || (sec->sh_entsize & INIT_OFFSET_MASK))
> > +         || mod_mem_type_is_init(type))
> >               return false;
> >
> >       return true;
> > @@ -113,11 +115,13 @@ void layout_symtab(struct module *mod, struct loa=
d_info *info)
> >       Elf_Shdr *strsect =3D info->sechdrs + info->index.str;
> >       const Elf_Sym *src;
> >       unsigned int i, nsrc, ndst, strtab_size =3D 0;
> > +     struct module_memory *mod_mem_data =3D &mod->mem[MOD_DATA];
> > +     struct module_memory *mod_mem_init_data =3D &mod->mem[MOD_INIT_DA=
TA];
> >
> >       /* Put symbol section at end of init part of module. */
> >       symsect->sh_flags |=3D SHF_ALLOC;
> > -     symsect->sh_entsize =3D module_get_offset(mod, &mod->init_layout.=
size, symsect,
> > -                                             info->index.sym) | INIT_O=
FFSET_MASK;
> > +     symsect->sh_entsize =3D module_get_offset_and_type(mod, MOD_INIT_=
DATA,
> > +                                                      symsect, info->i=
ndex.sym);
> >       pr_debug("\t%s\n", info->secstrings + symsect->sh_name);
> >
> >       src =3D (void *)info->hdr + symsect->sh_offset;
> > @@ -134,28 +138,27 @@ void layout_symtab(struct module *mod, struct loa=
d_info *info)
> >       }
> >
> >       /* Append room for core symbols at end of core part. */
> > -     info->symoffs =3D ALIGN(mod->data_layout.size, symsect->sh_addral=
ign ?: 1);
> > -     info->stroffs =3D mod->data_layout.size =3D info->symoffs + ndst =
* sizeof(Elf_Sym);
> > -     mod->data_layout.size +=3D strtab_size;
> > +     info->symoffs =3D ALIGN(mod_mem_data->size, symsect->sh_addralign=
 ?: 1);
> > +     info->stroffs =3D mod_mem_data->size =3D info->symoffs + ndst * s=
izeof(Elf_Sym);
> > +     mod_mem_data->size +=3D strtab_size;
> >       /* Note add_kallsyms() computes strtab_size as core_typeoffs - st=
roffs */
> > -     info->core_typeoffs =3D mod->data_layout.size;
> > -     mod->data_layout.size +=3D ndst * sizeof(char);
> > -     mod->data_layout.size =3D strict_align(mod->data_layout.size);
> > +     info->core_typeoffs =3D mod_mem_data->size;
> > +     mod_mem_data->size +=3D ndst * sizeof(char);
> >
> >       /* Put string table section at end of init part of module. */
> >       strsect->sh_flags |=3D SHF_ALLOC;
> > -     strsect->sh_entsize =3D module_get_offset(mod, &mod->init_layout.=
size, strsect,
> > -                                             info->index.str) | INIT_O=
FFSET_MASK;
> > +     strsect->sh_entsize =3D module_get_offset_and_type(mod, MOD_INIT_=
DATA,
> > +                                                      strsect, info->i=
ndex.str);
> >       pr_debug("\t%s\n", info->secstrings + strsect->sh_name);
> >
> >       /* We'll tack temporary mod_kallsyms on the end. */
> > -     mod->init_layout.size =3D ALIGN(mod->init_layout.size,
> > +     mod_mem_init_data->size =3D ALIGN(mod_mem_init_data->size,
> >                                       __alignof__(struct mod_kallsyms))=
;
> > -     info->mod_kallsyms_init_off =3D mod->init_layout.size;
> > -     mod->init_layout.size +=3D sizeof(struct mod_kallsyms);
> > -     info->init_typeoffs =3D mod->init_layout.size;
> > -     mod->init_layout.size +=3D nsrc * sizeof(char);
> > -     mod->init_layout.size =3D strict_align(mod->init_layout.size);
> > +     info->mod_kallsyms_init_off =3D mod_mem_init_data->size;
> > +
> > +     mod_mem_init_data->size +=3D sizeof(struct mod_kallsyms);
> > +     info->init_typeoffs =3D mod_mem_init_data->size;
> > +     mod_mem_init_data->size +=3D nsrc * sizeof(char);
> >   }
> >
> >   /*
> > @@ -171,9 +174,11 @@ void add_kallsyms(struct module *mod, const struct=
 load_info *info)
> >       char *s;
> >       Elf_Shdr *symsec =3D &info->sechdrs[info->index.sym];
> >       unsigned long strtab_size;
> > +     void *data_base =3D mod->mem[MOD_DATA].base;
> > +     void *init_data_base =3D mod->mem[MOD_INIT_DATA].base;
> >
> >       /* Set up to point into init section. */
> > -     mod->kallsyms =3D (void __rcu *)mod->init_layout.base +
> > +     mod->kallsyms =3D (void __rcu *)init_data_base +
> >               info->mod_kallsyms_init_off;
> >
> >       rcu_read_lock();
> > @@ -183,15 +188,15 @@ void add_kallsyms(struct module *mod, const struc=
t load_info *info)
> >       /* Make sure we get permanent strtab: don't use info->strtab. */
> >       rcu_dereference(mod->kallsyms)->strtab =3D
> >               (void *)info->sechdrs[info->index.str].sh_addr;
> > -     rcu_dereference(mod->kallsyms)->typetab =3D mod->init_layout.base=
 + info->init_typeoffs;
> > +     rcu_dereference(mod->kallsyms)->typetab =3D init_data_base + info=
->init_typeoffs;
> >
> >       /*
> >        * Now populate the cut down core kallsyms for after init
> >        * and set types up while we still have access to sections.
> >        */
> > -     mod->core_kallsyms.symtab =3D dst =3D mod->data_layout.base + inf=
o->symoffs;
> > -     mod->core_kallsyms.strtab =3D s =3D mod->data_layout.base + info-=
>stroffs;
> > -     mod->core_kallsyms.typetab =3D mod->data_layout.base + info->core=
_typeoffs;
> > +     mod->core_kallsyms.symtab =3D dst =3D data_base + info->symoffs;
> > +     mod->core_kallsyms.strtab =3D s =3D data_base + info->stroffs;
> > +     mod->core_kallsyms.typetab =3D data_base + info->core_typeoffs;
> >       strtab_size =3D info->core_typeoffs - info->stroffs;
> >       src =3D rcu_dereference(mod->kallsyms)->symtab;
> >       for (ndst =3D i =3D 0; i < rcu_dereference(mod->kallsyms)->num_sy=
mtab; i++) {
> > @@ -267,12 +272,15 @@ static const char *find_kallsyms_symbol(struct mo=
dule *mod,
> >       unsigned int i, best =3D 0;
> >       unsigned long nextval, bestval;
> >       struct mod_kallsyms *kallsyms =3D rcu_dereference_sched(mod->kall=
syms);
> > +     struct module_memory *mod_mem;
> >
> >       /* At worse, next value is at end of module */
> >       if (within_module_init(addr, mod))
> > -             nextval =3D (unsigned long)mod->init_layout.base + mod->i=
nit_layout.text_size;
> > +             mod_mem =3D &mod->mem[MOD_INIT_TEXT];
> >       else
> > -             nextval =3D (unsigned long)mod->core_layout.base + mod->c=
ore_layout.text_size;
> > +             mod_mem =3D &mod->mem[MOD_TEXT];
> > +
> > +     nextval =3D (unsigned long)mod_mem->base + mod_mem->size;
> >
> >       bestval =3D kallsyms_symbol_value(&kallsyms->symtab[best]);
> >
> > diff --git a/kernel/module/kdb.c b/kernel/module/kdb.c
> > index f4317f92e189..995c32d3698f 100644
> > --- a/kernel/module/kdb.c
> > +++ b/kernel/module/kdb.c
> > @@ -26,10 +26,11 @@ int kdb_lsmod(int argc, const char **argv)
> >               if (mod->state =3D=3D MODULE_STATE_UNFORMED)
> >                       continue;
> >
> > -             kdb_printf("%-20s%8u", mod->name, mod->core_layout.size);
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -             kdb_printf("/%8u", mod->data_layout.size);
> > -#endif
> > +             kdb_printf("%-20s%8u", mod->name, mod->mem[MOD_TEXT].size=
);
> > +             kdb_printf("/%8u", mod->mem[MOD_RODATA].size);
> > +             kdb_printf("/%8u", mod->mem[MOD_RO_AFTER_INIT].size);
> > +             kdb_printf("/%8u", mod->mem[MOD_DATA].size);
> > +
> >               kdb_printf("  0x%px ", (void *)mod);
> >   #ifdef CONFIG_MODULE_UNLOAD
> >               kdb_printf("%4d ", module_refcount(mod));
> > @@ -40,10 +41,10 @@ int kdb_lsmod(int argc, const char **argv)
> >                       kdb_printf(" (Loading)");
> >               else
> >                       kdb_printf(" (Live)");
> > -             kdb_printf(" 0x%px", mod->core_layout.base);
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -             kdb_printf("/0x%px", mod->data_layout.base);
> > -#endif
> > +             kdb_printf(" 0x%px", mod->mem[MOD_TEXT].base);
> > +             kdb_printf("/0x%px", mod->mem[MOD_RODATA].base);
> > +             kdb_printf("/0x%px", mod->mem[MOD_RO_AFTER_INIT].base);
> > +             kdb_printf("/0x%px", mod->mem[MOD_DATA].base);
> >
> >   #ifdef CONFIG_MODULE_UNLOAD
> >               {
> > diff --git a/kernel/module/main.c b/kernel/module/main.c
> > index d3be89de706d..9f890d14072c 100644
> > --- a/kernel/module/main.c
> > +++ b/kernel/module/main.c
> > @@ -80,12 +80,6 @@ struct mod_tree_root mod_tree __cacheline_aligned =
=3D {
> >       .addr_min =3D -1UL,
> >   };
> >
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -struct mod_tree_root mod_data_tree __cacheline_aligned =3D {
> > -     .addr_min =3D -1UL,
> > -};
> > -#endif
> > -
> >   struct symsearch {
> >       const struct kernel_symbol *start, *stop;
> >       const s32 *crcs;
> > @@ -93,14 +87,24 @@ struct symsearch {
> >   };
> >
> >   /*
> > - * Bounds of module text, for speeding up __module_address.
> > + * Bounds of module memory, for speeding up __module_address.
> >    * Protected by module_mutex.
> >    */
> > -static void __mod_update_bounds(void *base, unsigned int size, struct =
mod_tree_root *tree)
> > +static void __mod_update_bounds(enum mod_mem_type type __maybe_unused,=
 void *base,
> > +                             unsigned int size, struct mod_tree_root *=
tree)
> >   {
> >       unsigned long min =3D (unsigned long)base;
> >       unsigned long max =3D min + size;
> >
> > +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > +     if (mod_mem_type_is_core_data(type)) {
> > +             if (min < tree->data_addr_min)
> > +                     tree->data_addr_min =3D min;
> > +             if (max > tree->data_addr_max)
> > +                     tree->data_addr_max =3D max;
> > +             return;
> > +     }
> > +#endif
> >       if (min < tree->addr_min)
> >               tree->addr_min =3D min;
> >       if (max > tree->addr_max)
> > @@ -109,12 +113,12 @@ static void __mod_update_bounds(void *base, unsig=
ned int size, struct mod_tree_r
> >
> >   static void mod_update_bounds(struct module *mod)
> >   {
> > -     __mod_update_bounds(mod->core_layout.base, mod->core_layout.size,=
 &mod_tree);
> > -     if (mod->init_layout.size)
> > -             __mod_update_bounds(mod->init_layout.base, mod->init_layo=
ut.size, &mod_tree);
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     __mod_update_bounds(mod->data_layout.base, mod->data_layout.size,=
 &mod_data_tree);
> > -#endif
> > +     for_each_mod_mem_type(type) {
> > +             struct module_memory *mod_mem =3D &mod->mem[type];
> > +
> > +             if (mod_mem->size)
> > +                     __mod_update_bounds(type, mod_mem->base, mod_mem-=
>size, &mod_tree);
> > +     }
> >   }
> >
> >   /* Block module loading/unloading? */
> > @@ -923,12 +927,27 @@ static ssize_t store_uevent(struct module_attribu=
te *mattr,
> >   struct module_attribute module_uevent =3D
> >       __ATTR(uevent, 0200, NULL, store_uevent);
> >
> > +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > +
> >   static ssize_t show_coresize(struct module_attribute *mattr,
> >                            struct module_kobject *mk, char *buffer)
> >   {
> > -     return sprintf(buffer, "%u\n", mk->mod->core_layout.size);
> > +     return sprintf(buffer, "%u\n", mk->mod->mem[MOD_TEXT].size);
> >   }
> >
> > +#else
> > +
> > +static ssize_t show_coresize(struct module_attribute *mattr,
> > +                          struct module_kobject *mk, char *buffer)
> > +{
> > +     unsigned int size =3D 0;
> > +
> > +     for_class_mod_mem_type(type, core)
> > +             size +=3D mk->mod->mem[type].size;
> > +     return sprintf(buffer, "%u\n", size);
> > +}
> > +#endif
> > +
> >   static struct module_attribute modinfo_coresize =3D
> >       __ATTR(coresize, 0444, show_coresize, NULL);
> >
> > @@ -936,7 +955,14 @@ static struct module_attribute modinfo_coresize =
=3D
> >   static ssize_t show_datasize(struct module_attribute *mattr,
> >                            struct module_kobject *mk, char *buffer)
> >   {
> > -     return sprintf(buffer, "%u\n", mk->mod->data_layout.size);
> > +     unsigned int size =3D 0;
> > +
> > +     for_class_mod_mem_type(type, core) {
> > +             if (type =3D=3D MOD_TEXT)
> > +                     continue;
> > +             size +=3D mk->mod->mem[type].size;
> > +     }
> > +     return sprintf(buffer, "%u\n", size);
> >   }
> >
> >   static struct module_attribute modinfo_datasize =3D
> > @@ -946,7 +972,11 @@ static struct module_attribute modinfo_datasize =
=3D
> >   static ssize_t show_initsize(struct module_attribute *mattr,
> >                            struct module_kobject *mk, char *buffer)
> >   {
> > -     return sprintf(buffer, "%u\n", mk->mod->init_layout.size);
> > +     unsigned int size =3D 0;
> > +
> > +     for_class_mod_mem_type(type, init)
> > +             size +=3D mk->mod->mem[type].size;
> > +     return sprintf(buffer, "%u\n", size);
> >   }
> >
> >   static struct module_attribute modinfo_initsize =3D
> > @@ -1143,6 +1173,63 @@ void __weak module_arch_freeing_init(struct modu=
le *mod)
> >   {
> >   }
> >
> > +#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > +static bool mod_mem_use_vmalloc(enum mod_mem_type type)
> > +{
> > +     return mod_mem_is_core_data(type);
> > +}
> > +#else
> > +static bool mod_mem_use_vmalloc(enum mod_mem_type type)
> > +{
> > +     return false;
> > +}
> > +#endif
> > +
> > +static void *module_memory_alloc(unsigned int size, enum mod_mem_type =
type)
> > +{
> > +     if (mod_mem_use_vmalloc(type))
> > +             return vzalloc(size);
> > +     return module_alloc(size);
> > +}
> > +
> > +static void module_memory_free(void *ptr, enum mod_mem_type type)
> > +{
> > +     if (mod_mem_use_vmalloc(type))
> > +             vfree(ptr);
> > +     else
> > +             module_memfree(ptr);
> > +}
> > +
> > +static void free_mod_mem(struct module *mod)
> > +{
> > +     /* free the memory in the right order to avoid use-after-free */
> > +     static enum mod_mem_type mod_mem_free_order[MOD_MEM_NUM_TYPES] =
=3D {
> > +             /* first free init sections */
> > +             MOD_INIT_TEXT,
> > +             MOD_INIT_DATA,
> > +             MOD_INIT_RODATA,
> > +
> > +             /* then core sections, except rw data */
> > +             MOD_TEXT,
> > +             MOD_RODATA,
> > +             MOD_RO_AFTER_INIT,
> > +
> > +             /* last, rw data */
> > +             MOD_DATA,
> > +     };
> > +     int i;
> > +
> > +     for (i =3D 0; i < MOD_MEM_NUM_TYPES; i++) {
> > +             enum mod_mem_type type =3D mod_mem_free_order[i];
> > +             struct module_memory *mod_mem =3D &mod->mem[type];
> > +
> > +             /* Free lock-classes; relies on the preceding sync_rcu().=
 */
> > +             lockdep_free_key_range(mod_mem->base, mod_mem->size);
> > +             if (mod_mem->size)
> > +                     module_memory_free(mod_mem->base, type);
> > +     }
> > +}
> > +
> >   /* Free a module, remove from lists, etc. */
> >   static void free_module(struct module *mod)
> >   {
> > @@ -1189,18 +1276,10 @@ static void free_module(struct module *mod)
> >
> >       /* This may be empty, but that's OK */
> >       module_arch_freeing_init(mod);
> > -     module_memfree(mod->init_layout.base);
> >       kfree(mod->args);
> >       percpu_modfree(mod);
> >
> > -     /* Free lock-classes; relies on the preceding sync_rcu(). */
> > -     lockdep_free_key_range(mod->data_layout.base, mod->data_layout.si=
ze);
> > -
> > -     /* Finally, free the core (containing the module structure) */
> > -     module_memfree(mod->core_layout.base);
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     vfree(mod->data_layout.base);
> > -#endif
> > +     free_mod_mem(mod);
> >   }
> >
> >   void *__symbol_get(const char *symbol)
> > @@ -1387,16 +1466,18 @@ unsigned int __weak arch_mod_section_prepend(st=
ruct module *mod,
> >       return 0;
> >   }
> >
> > -/* Update size with this section: return offset. */
> > -long module_get_offset(struct module *mod, unsigned int *size,
> > +long module_get_offset_and_type(struct module *mod, enum mod_mem_type =
type,
> >                               Elf_Shdr *sechdr, unsigned int section)
> >   {
> > -     long ret;
> > +     long offset;
> > +     long mask =3D ((unsigned long)(type) & SH_ENTSIZE_TYPE_MASK) << S=
H_ENTSIZE_TYPE_SHIFT;
> >
> > -     *size +=3D arch_mod_section_prepend(mod, section);
> > -     ret =3D ALIGN(*size, sechdr->sh_addralign ?: 1);
> > -     *size =3D ret + sechdr->sh_size;
> > -     return ret;
> > +     mod->mem[type].size +=3D arch_mod_section_prepend(mod, section);
> > +     offset =3D ALIGN(mod->mem[type].size, sechdr->sh_addralign ?: 1);
> > +     mod->mem[type].size =3D offset + sechdr->sh_size;
> > +
> > +     WARN_ON_ONCE(offset & mask);
> > +     return offset | mask;
> >   }
> >
> >   static bool module_init_layout_section(const char *sname)
> > @@ -1428,6 +1509,20 @@ static void layout_sections(struct module *mod, =
struct load_info *info)
> >               { SHF_WRITE | SHF_ALLOC, ARCH_SHF_SMALL },
> >               { ARCH_SHF_SMALL | SHF_ALLOC, 0 }
> >       };
> > +     static int core_m_to_mem_type[] =3D {
> > +             MOD_TEXT,
> > +             MOD_RODATA,
> > +             MOD_RO_AFTER_INIT,
> > +             MOD_DATA,
> > +             MOD_INVALID,
> > +     };
> > +     static int init_m_to_mem_type[] =3D {
> > +             MOD_INIT_TEXT,
> > +             MOD_INIT_RODATA,
> > +             MOD_INVALID,
> > +             MOD_INIT_DATA,
> > +             MOD_INVALID,
> > +     };
> >       unsigned int m, i;
> >
> >       for (i =3D 0; i < info->hdr->e_shnum; i++)
> > @@ -1435,41 +1530,30 @@ static void layout_sections(struct module *mod,=
 struct load_info *info)
> >
> >       pr_debug("Core section allocation order:\n");
> >       for (m =3D 0; m < ARRAY_SIZE(masks); ++m) {
> > +             enum mod_mem_type type =3D core_m_to_mem_type[m];
> > +
> >               for (i =3D 0; i < info->hdr->e_shnum; ++i) {
> >                       Elf_Shdr *s =3D &info->sechdrs[i];
> >                       const char *sname =3D info->secstrings + s->sh_na=
me;
> > -                     unsigned int *sizep;
> >
> >                       if ((s->sh_flags & masks[m][0]) !=3D masks[m][0]
> >                           || (s->sh_flags & masks[m][1])
> >                           || s->sh_entsize !=3D ~0UL
> >                           || module_init_layout_section(sname))
> >                               continue;
> > -                     sizep =3D m ? &mod->data_layout.size : &mod->core=
_layout.size;
> > -                     s->sh_entsize =3D module_get_offset(mod, sizep, s=
, i);
> > +
> > +                     if (WARN_ON_ONCE(type =3D=3D MOD_INVALID))
> > +                             continue;
> > +
> > +                     s->sh_entsize =3D module_get_offset_and_type(mod,=
 type, s, i);
> >                       pr_debug("\t%s\n", sname);
> >               }
> > -             switch (m) {
> > -             case 0: /* executable */
> > -                     mod->core_layout.size =3D strict_align(mod->core_=
layout.size);
> > -                     mod->core_layout.text_size =3D mod->core_layout.s=
ize;
> > -                     break;
> > -             case 1: /* RO: text and ro-data */
> > -                     mod->data_layout.size =3D strict_align(mod->data_=
layout.size);
> > -                     mod->data_layout.ro_size =3D mod->data_layout.siz=
e;
> > -                     break;
> > -             case 2: /* RO after init */
> > -                     mod->data_layout.size =3D strict_align(mod->data_=
layout.size);
> > -                     mod->data_layout.ro_after_init_size =3D mod->data=
_layout.size;
> > -                     break;
> > -             case 4: /* whole core */
> > -                     mod->data_layout.size =3D strict_align(mod->data_=
layout.size);
> > -                     break;
> > -             }
> >       }
> >
> >       pr_debug("Init section allocation order:\n");
> >       for (m =3D 0; m < ARRAY_SIZE(masks); ++m) {
> > +             enum mod_mem_type type =3D init_m_to_mem_type[m];
> > +
> >               for (i =3D 0; i < info->hdr->e_shnum; ++i) {
> >                       Elf_Shdr *s =3D &info->sechdrs[i];
> >                       const char *sname =3D info->secstrings + s->sh_na=
me;
> > @@ -1479,30 +1563,13 @@ static void layout_sections(struct module *mod,=
 struct load_info *info)
> >                           || s->sh_entsize !=3D ~0UL
> >                           || !module_init_layout_section(sname))
> >                               continue;
> > -                     s->sh_entsize =3D (module_get_offset(mod, &mod->i=
nit_layout.size, s, i)
> > -                                      | INIT_OFFSET_MASK);
> > +
> > +                     if (WARN_ON_ONCE(type =3D=3D MOD_INVALID))
> > +                             continue;
> > +
> > +                     s->sh_entsize =3D module_get_offset_and_type(mod,=
 type, s, i);
> >                       pr_debug("\t%s\n", sname);
> >               }
> > -             switch (m) {
> > -             case 0: /* executable */
> > -                     mod->init_layout.size =3D strict_align(mod->init_=
layout.size);
> > -                     mod->init_layout.text_size =3D mod->init_layout.s=
ize;
> > -                     break;
> > -             case 1: /* RO: text and ro-data */
> > -                     mod->init_layout.size =3D strict_align(mod->init_=
layout.size);
> > -                     mod->init_layout.ro_size =3D mod->init_layout.siz=
e;
> > -                     break;
> > -             case 2:
> > -                     /*
> > -                      * RO after init doesn't apply to init_layout (on=
ly
> > -                      * core_layout), so it just takes the value of ro=
_size.
> > -                      */
> > -                     mod->init_layout.ro_after_init_size =3D mod->init=
_layout.ro_size;
> > -                     break;
> > -             case 4: /* whole init */
> > -                     mod->init_layout.size =3D strict_align(mod->init_=
layout.size);
> > -                     break;
> > -             }
> >       }
> >   }
> >
> > @@ -2122,72 +2189,42 @@ static int move_module(struct module *mod, stru=
ct load_info *info)
> >   {
> >       int i;
> >       void *ptr;
> > +     enum mod_mem_type t;
> >
> > -     /* Do the allocs. */
> > -     ptr =3D module_alloc(mod->core_layout.size);
> > -     /*
> > -      * The pointer to this block is stored in the module structure
> > -      * which is inside the block. Just mark it as not being a
> > -      * leak.
> > -      */
> > -     kmemleak_not_leak(ptr);
> > -     if (!ptr)
> > -             return -ENOMEM;
> > -
> > -     memset(ptr, 0, mod->core_layout.size);
> > -     mod->core_layout.base =3D ptr;
> > -
> > -     if (mod->init_layout.size) {
> > -             ptr =3D module_alloc(mod->init_layout.size);
> > -             /*
> > -              * The pointer to this block is stored in the module stru=
cture
> > -              * which is inside the block. This block doesn't need to =
be
> > -              * scanned as it contains data and code that will be free=
d
> > -              * after the module is initialized.
> > -              */
> > -             kmemleak_ignore(ptr);
> > -             if (!ptr) {
> > -                     module_memfree(mod->core_layout.base);
> > -                     return -ENOMEM;
> > +     for_each_mod_mem_type(type) {
> > +             if (!mod->mem[type].size) {
> > +                     mod->mem[type].base =3D NULL;
> > +                     continue;
> >               }
> > -             memset(ptr, 0, mod->init_layout.size);
> > -             mod->init_layout.base =3D ptr;
> > -     } else
> > -             mod->init_layout.base =3D NULL;
> > +             mod->mem[type].size =3D PAGE_ALIGN(mod->mem[type].size);
> > +             ptr =3D module_memory_alloc(mod->mem[type].size, type);
> >
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     /* Do the allocs. */
> > -     ptr =3D vzalloc(mod->data_layout.size);
> >               /*
> >                * The pointer to this block is stored in the module stru=
cture
> >                * which is inside the block. Just mark it as not being a
> >                * leak.
> >                */
> > -     kmemleak_not_leak(ptr);
> > +             kmemleak_ignore(ptr);
> >               if (!ptr) {
> > -             module_memfree(mod->core_layout.base);
> > -             module_memfree(mod->init_layout.base);
> > -             return -ENOMEM;
> > +                     t =3D type;
> > +                     goto out_enomem;
> > +             }
> > +             memset(ptr, 0, mod->mem[type].size);
> > +             mod->mem[type].base =3D ptr;
> >       }
> >
> > -     mod->data_layout.base =3D ptr;
> > -#endif
> >       /* Transfer each section which specifies SHF_ALLOC */
> >       pr_debug("final section addresses:\n");
> >       for (i =3D 0; i < info->hdr->e_shnum; i++) {
> >               void *dest;
> >               Elf_Shdr *shdr =3D &info->sechdrs[i];
> > +             enum mod_mem_type type =3D shdr->sh_entsize >> SH_ENTSIZE=
_TYPE_SHIFT;
> >
> >               if (!(shdr->sh_flags & SHF_ALLOC))
> >                       continue;
> >
> > -             if (shdr->sh_entsize & INIT_OFFSET_MASK)
> > -                     dest =3D mod->init_layout.base
> > -                             + (shdr->sh_entsize & ~INIT_OFFSET_MASK);
> > -             else if (!(shdr->sh_flags & SHF_EXECINSTR))
> > -                     dest =3D mod->data_layout.base + shdr->sh_entsize=
;
> > -             else
> > -                     dest =3D mod->core_layout.base + shdr->sh_entsize=
;
> > +             dest =3D mod->mem[type].base +
> > +                     (shdr->sh_entsize & SH_ENTSIZE_OFFSET_MASK);
> >
> >               if (shdr->sh_type !=3D SHT_NOBITS)
> >                       memcpy(dest, (void *)shdr->sh_addr, shdr->sh_size=
);
> > @@ -2198,6 +2235,10 @@ static int move_module(struct module *mod, struc=
t load_info *info)
> >       }
> >
> >       return 0;
> > +out_enomem:
> > +     for (t--; t >=3D 0; t--)
> > +             module_memory_free(mod->mem[t].base, t);
> > +     return -ENOMEM;
> >   }
> >
> >   static int check_module_license_and_versions(struct module *mod)
> > @@ -2242,12 +2283,13 @@ static void flush_module_icache(const struct mo=
dule *mod)
> >        * Do it before processing of module parameters, so the module
> >        * can provide parameter accessor functions of its own.
> >        */
> > -     if (mod->init_layout.base)
> > -             flush_icache_range((unsigned long)mod->init_layout.base,
> > -                                (unsigned long)mod->init_layout.base
> > -                                + mod->init_layout.size);
> > -     flush_icache_range((unsigned long)mod->core_layout.base,
> > -                        (unsigned long)mod->core_layout.base + mod->co=
re_layout.size);
> > +     for_each_mod_mem_type(type) {
> > +             const struct module_memory *mod_mem =3D &mod->mem[type];
> > +
> > +             if (mod_mem->size)
> > +                     flush_icache_range((unsigned long)mod_mem->base,
> > +                                        (unsigned long)mod_mem->base +=
 mod_mem->size);
> > +     }
> >   }
> >
> >   bool __weak module_elf_check_arch(Elf_Ehdr *hdr)
> > @@ -2350,11 +2392,8 @@ static void module_deallocate(struct module *mod=
, struct load_info *info)
> >   {
> >       percpu_modfree(mod);
> >       module_arch_freeing_init(mod);
> > -     module_memfree(mod->init_layout.base);
> > -     module_memfree(mod->core_layout.base);
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     vfree(mod->data_layout.base);
> > -#endif
> > +
> > +     free_mod_mem(mod);
> >   }
> >
> >   int __weak module_finalize(const Elf_Ehdr *hdr,
> > @@ -2415,7 +2454,9 @@ static void do_mod_ctors(struct module *mod)
> >   /* For freeing module_init on success, in case kallsyms traversing */
> >   struct mod_initfree {
> >       struct llist_node node;
> > -     void *module_init;
> > +     void *init_text;
> > +     void *init_data;
> > +     void *init_rodata;
> >   };
> >
> >   static void do_free_init(struct work_struct *w)
> > @@ -2429,7 +2470,9 @@ static void do_free_init(struct work_struct *w)
> >
> >       llist_for_each_safe(pos, n, list) {
> >               initfree =3D container_of(pos, struct mod_initfree, node)=
;
> > -             module_memfree(initfree->module_init);
> > +             module_memfree(initfree->init_text);
> > +             module_memfree(initfree->init_data);
> > +             module_memfree(initfree->init_rodata);
> >               kfree(initfree);
> >       }
> >   }
> > @@ -2456,7 +2499,9 @@ static noinline int do_init_module(struct module =
*mod)
> >               ret =3D -ENOMEM;
> >               goto fail;
> >       }
> > -     freeinit->module_init =3D mod->init_layout.base;
> > +     freeinit->init_text =3D mod->mem[MOD_INIT_TEXT].base;
> > +     freeinit->init_data =3D mod->mem[MOD_INIT_DATA].base;
> > +     freeinit->init_rodata =3D mod->mem[MOD_INIT_RODATA].base;
> >
> >       do_mod_ctors(mod);
> >       /* Start the module */
> > @@ -2492,8 +2537,8 @@ static noinline int do_init_module(struct module =
*mod)
> >       if (!mod->async_probe_requested)
> >               async_synchronize_full();
> >
> > -     ftrace_free_mem(mod, mod->init_layout.base, mod->init_layout.base=
 +
> > -                     mod->init_layout.size);
> > +     ftrace_free_mem(mod, mod->mem[MOD_INIT_TEXT].base,
> > +                     mod->mem[MOD_INIT_TEXT].base + mod->mem[MOD_INIT_=
TEXT].size);
> >       mutex_lock(&module_mutex);
> >       /* Drop initial reference. */
> >       module_put(mod);
> > @@ -2505,11 +2550,10 @@ static noinline int do_init_module(struct modul=
e *mod)
> >       module_enable_ro(mod, true);
> >       mod_tree_remove_init(mod);
> >       module_arch_freeing_init(mod);
> > -     mod->init_layout.base =3D NULL;
> > -     mod->init_layout.size =3D 0;
> > -     mod->init_layout.ro_size =3D 0;
> > -     mod->init_layout.ro_after_init_size =3D 0;
> > -     mod->init_layout.text_size =3D 0;
> > +     for_class_mod_mem_type(type, init) {
> > +             mod->mem[type].base =3D NULL;
> > +             mod->mem[type].size =3D 0;
> > +     }
> >   #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
> >       /* .BTF is not SHF_ALLOC and will get removed, so sanitize pointe=
r */
> >       mod->btf_data =3D NULL;
> > @@ -2628,9 +2672,6 @@ static int complete_formation(struct module *mod,=
 struct load_info *info)
> >       module_bug_finalize(info->hdr, info->sechdrs, mod);
> >       module_cfi_finalize(info->hdr, info->sechdrs, mod);
> >
> > -     if (module_check_misalignment(mod))
> > -             goto out_misaligned;
> > -
> >       module_enable_ro(mod, false);
> >       module_enable_nx(mod);
> >       module_enable_x(mod);
> > @@ -2644,8 +2685,6 @@ static int complete_formation(struct module *mod,=
 struct load_info *info)
> >
> >       return 0;
> >
> > -out_misaligned:
> > -     err =3D -EINVAL;
> >   out:
> >       mutex_unlock(&module_mutex);
> >       return err;
> > @@ -2909,7 +2948,10 @@ static int load_module(struct load_info *info, c=
onst char __user *uargs,
> >       mutex_unlock(&module_mutex);
> >    free_module:
> >       /* Free lock-classes; relies on the preceding sync_rcu() */
> > -     lockdep_free_key_range(mod->data_layout.base, mod->data_layout.si=
ze);
> > +     for_class_mod_mem_type(type, core) {
> > +             lockdep_free_key_range(mod->mem[type].base,
> > +                                    mod->mem[type].size);
> > +     }
> >
> >       module_deallocate(mod, info);
> >    free_copy:
> > @@ -3060,20 +3102,21 @@ bool is_module_address(unsigned long addr)
> >   struct module *__module_address(unsigned long addr)
> >   {
> >       struct module *mod;
> > -     struct mod_tree_root *tree;
> >
> >       if (addr >=3D mod_tree.addr_min && addr <=3D mod_tree.addr_max)
> > -             tree =3D &mod_tree;
> > +             goto lookup;
> > +
> >   #ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     else if (addr >=3D mod_data_tree.addr_min && addr <=3D mod_data_t=
ree.addr_max)
> > -             tree =3D &mod_data_tree;
> > +     if (addr >=3D mod_tree.data_addr_min && addr <=3D mod_tree.data_a=
ddr_max)
> > +             goto lookup;
> >   #endif
> > -     else
> > +
> >       return NULL;
> >
> > +lookup:
> >       module_assert_mutex_or_preempt();
> >
> > -     mod =3D mod_find(addr, tree);
> > +     mod =3D mod_find(addr, &mod_tree);
> >       if (mod) {
> >               BUG_ON(!within_module(addr, mod));
> >               if (mod->state =3D=3D MODULE_STATE_UNFORMED)
> > @@ -3113,8 +3156,8 @@ struct module *__module_text_address(unsigned lon=
g addr)
> >       struct module *mod =3D __module_address(addr);
> >       if (mod) {
> >               /* Make sure it's within the text section. */
> > -             if (!within(addr, mod->init_layout.base, mod->init_layout=
.text_size)
> > -                 && !within(addr, mod->core_layout.base, mod->core_lay=
out.text_size))
> > +             if (!within_module_mem_type(addr, mod, MOD_TEXT) &&
> > +                 !within_module_mem_type(addr, mod, MOD_INIT_TEXT))
> >                       mod =3D NULL;
> >       }
> >       return mod;
> > diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
> > index cf5b9f1e6ec4..0a4841e88adb 100644
> > --- a/kernel/module/procfs.c
> > +++ b/kernel/module/procfs.c
> > @@ -62,6 +62,15 @@ static void m_stop(struct seq_file *m, void *p)
> >       mutex_unlock(&module_mutex);
> >   }
> >
> > +static unsigned int module_total_size(struct module *mod)
> > +{
> > +     int size =3D 0;
> > +
> > +     for_each_mod_mem_type(type)
> > +             size +=3D mod->mem[type].size;
> > +     return size;
> > +}
> > +
> >   static int m_show(struct seq_file *m, void *p)
> >   {
> >       struct module *mod =3D list_entry(p, struct module, list);
> > @@ -73,10 +82,7 @@ static int m_show(struct seq_file *m, void *p)
> >       if (mod->state =3D=3D MODULE_STATE_UNFORMED)
> >               return 0;
> >
> > -     size =3D mod->init_layout.size + mod->core_layout.size;
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     size +=3D mod->data_layout.size;
> > -#endif
> > +     size =3D module_total_size(mod);
> >       seq_printf(m, "%s %u", mod->name, size);
> >       print_unload_info(m, mod);
> >
> > @@ -86,7 +92,7 @@ static int m_show(struct seq_file *m, void *p)
> >                  mod->state =3D=3D MODULE_STATE_COMING ? "Loading" :
> >                  "Live");
> >       /* Used by oprofile and other similar tools. */
> > -     value =3D m->private ? NULL : mod->core_layout.base;
> > +     value =3D m->private ? NULL : mod->mem[MOD_TEXT].base;
> >       seq_printf(m, " 0x%px", value);
> >
> >       /* Taints info */
> > diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
> > index 14fbea66f12f..2e79a77f40eb 100644
> > --- a/kernel/module/strict_rwx.c
> > +++ b/kernel/module/strict_rwx.c
> > @@ -11,82 +11,26 @@
> >   #include <linux/set_memory.h>
> >   #include "internal.h"
> >
> > -/*
> > - * LKM RO/NX protection: protect module's text/ro-data
> > - * from modification and any data from execution.
> > - *
> > - * General layout of module is:
> > - *          [text] [read-only-data] [ro-after-init] [writable data]
> > - * text_size -----^                ^               ^               ^
> > - * ro_size ------------------------|               |               |
> > - * ro_after_init_size -----------------------------|               |
> > - * size -----------------------------------------------------------|
> > - *
> > - * These values are always page-aligned (as is base) when
> > - * CONFIG_STRICT_MODULE_RWX is set.
> > - */
> > +static void module_set_memory(
> > +     const struct module *mod, enum mod_mem_type type,
> > +     int (*set_memory)(unsigned long start, int num_pages))
> > +{
> > +     const struct module_memory *mod_mem =3D &mod->mem[type];
> > +
> > +     set_vm_flush_reset_perms(mod_mem->base);
> > +     set_memory((unsigned long)mod_mem->base, mod_mem->size >> PAGE_SH=
IFT);
> > +}
> >
> >   /*
> >    * Since some arches are moving towards PAGE_KERNEL module allocation=
s instead
> > - * of PAGE_KERNEL_EXEC, keep frob_text() and module_enable_x() indepen=
dent of
> > + * of PAGE_KERNEL_EXEC, keep module_enable_x() independent of
> >    * CONFIG_STRICT_MODULE_RWX because they are needed regardless of whe=
ther we
> >    * are strict.
> >    */
> > -static void frob_text(const struct module_layout *layout,
> > -                   int (*set_memory)(unsigned long start, int num_page=
s))
> > -{
> > -     set_memory((unsigned long)layout->base,
> > -                PAGE_ALIGN(layout->text_size) >> PAGE_SHIFT);
> > -}
> > -
> > -static void frob_rodata(const struct module_layout *layout,
> > -              int (*set_memory)(unsigned long start, int num_pages))
> > -{
> > -     set_memory((unsigned long)layout->base + layout->text_size,
> > -                (layout->ro_size - layout->text_size) >> PAGE_SHIFT);
> > -}
> > -
> > -static void frob_ro_after_init(const struct module_layout *layout,
> > -                     int (*set_memory)(unsigned long start, int num_pa=
ges))
> > -{
> > -     set_memory((unsigned long)layout->base + layout->ro_size,
> > -                (layout->ro_after_init_size - layout->ro_size) >> PAGE=
_SHIFT);
> > -}
> > -
> > -static void frob_writable_data(const struct module_layout *layout,
> > -                     int (*set_memory)(unsigned long start, int num_pa=
ges))
> > -{
> > -     set_memory((unsigned long)layout->base + layout->ro_after_init_si=
ze,
> > -                (layout->size - layout->ro_after_init_size) >> PAGE_SH=
IFT);
> > -}
> > -
> > -static bool layout_check_misalignment(const struct module_layout *layo=
ut)
> > -{
> > -     return WARN_ON(!PAGE_ALIGNED(layout->base)) ||
> > -            WARN_ON(!PAGE_ALIGNED(layout->text_size)) ||
> > -            WARN_ON(!PAGE_ALIGNED(layout->ro_size)) ||
> > -            WARN_ON(!PAGE_ALIGNED(layout->ro_after_init_size)) ||
> > -            WARN_ON(!PAGE_ALIGNED(layout->size));
> > -}
> > -
> > -bool module_check_misalignment(const struct module *mod)
> > -{
> > -     if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> > -             return false;
> > -
> > -     return layout_check_misalignment(&mod->core_layout) ||
> > -            layout_check_misalignment(&mod->data_layout) ||
> > -            layout_check_misalignment(&mod->init_layout);
> > -}
> > -
> >   void module_enable_x(const struct module *mod)
> >   {
> > -     if (!PAGE_ALIGNED(mod->core_layout.base) ||
> > -         !PAGE_ALIGNED(mod->init_layout.base))
> > -             return;
> > -
> > -     frob_text(&mod->core_layout, set_memory_x);
> > -     frob_text(&mod->init_layout, set_memory_x);
> > +     for_class_mod_mem_type(type, text)
> > +             module_set_memory(mod, type, set_memory_x);
> >   }
> >
> >   void module_enable_ro(const struct module *mod, bool after_init)
> > @@ -98,16 +42,13 @@ void module_enable_ro(const struct module *mod, boo=
l after_init)
> >               return;
> >   #endif
> >
> > -     set_vm_flush_reset_perms(mod->core_layout.base);
> > -     set_vm_flush_reset_perms(mod->init_layout.base);
> > -     frob_text(&mod->core_layout, set_memory_ro);
> > -
> > -     frob_rodata(&mod->data_layout, set_memory_ro);
> > -     frob_text(&mod->init_layout, set_memory_ro);
> > -     frob_rodata(&mod->init_layout, set_memory_ro);
> > +     module_set_memory(mod, MOD_TEXT, set_memory_ro);
> > +     module_set_memory(mod, MOD_INIT_TEXT, set_memory_ro);
> > +     module_set_memory(mod, MOD_RODATA, set_memory_ro);
> > +     module_set_memory(mod, MOD_INIT_RODATA, set_memory_ro);
> >
> >       if (after_init)
> > -             frob_ro_after_init(&mod->data_layout, set_memory_ro);
> > +             module_set_memory(mod, MOD_RO_AFTER_INIT, set_memory_ro);
> >   }
> >
> >   void module_enable_nx(const struct module *mod)
> > @@ -115,11 +56,8 @@ void module_enable_nx(const struct module *mod)
> >       if (!IS_ENABLED(CONFIG_STRICT_MODULE_RWX))
> >               return;
> >
> > -     frob_rodata(&mod->data_layout, set_memory_nx);
> > -     frob_ro_after_init(&mod->data_layout, set_memory_nx);
> > -     frob_writable_data(&mod->data_layout, set_memory_nx);
> > -     frob_rodata(&mod->init_layout, set_memory_nx);
> > -     frob_writable_data(&mod->init_layout, set_memory_nx);
> > +     for_class_mod_mem_type(type, data)
> > +             module_set_memory(mod, type, set_memory_nx);
> >   }
> >
> >   int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
> > diff --git a/kernel/module/tree_lookup.c b/kernel/module/tree_lookup.c
> > index 8ec5cfd60496..277197977d43 100644
> > --- a/kernel/module/tree_lookup.c
> > +++ b/kernel/module/tree_lookup.c
> > @@ -21,16 +21,16 @@
> >
> >   static __always_inline unsigned long __mod_tree_val(struct latch_tree=
_node *n)
> >   {
> > -     struct module_layout *layout =3D container_of(n, struct module_la=
yout, mtn.node);
> > +     struct module_memory *mod_mem =3D container_of(n, struct module_m=
emory, mtn.node);
> >
> > -     return (unsigned long)layout->base;
> > +     return (unsigned long)mod_mem->base;
> >   }
> >
> >   static __always_inline unsigned long __mod_tree_size(struct latch_tre=
e_node *n)
> >   {
> > -     struct module_layout *layout =3D container_of(n, struct module_la=
yout, mtn.node);
> > +     struct module_memory *mod_mem =3D container_of(n, struct module_m=
emory, mtn.node);
> >
> > -     return (unsigned long)layout->size;
> > +     return (unsigned long)mod_mem->size;
> >   }
> >
> >   static __always_inline bool
> > @@ -77,32 +77,27 @@ static void __mod_tree_remove(struct mod_tree_node =
*node, struct mod_tree_root *
> >    */
> >   void mod_tree_insert(struct module *mod)
> >   {
> > -     mod->core_layout.mtn.mod =3D mod;
> > -     mod->init_layout.mtn.mod =3D mod;
> > -
> > -     __mod_tree_insert(&mod->core_layout.mtn, &mod_tree);
> > -     if (mod->init_layout.size)
> > -             __mod_tree_insert(&mod->init_layout.mtn, &mod_tree);
> > -
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     mod->data_layout.mtn.mod =3D mod;
> > -     __mod_tree_insert(&mod->data_layout.mtn, &mod_data_tree);
> > -#endif
> > +     for_each_mod_mem_type(type) {
> > +             mod->mem[type].mtn.mod =3D mod;
> > +             if (mod->mem[type].size)
> > +                     __mod_tree_insert(&mod->mem[type].mtn, &mod_tree)=
;
> > +     }
> >   }
> >
> >   void mod_tree_remove_init(struct module *mod)
> >   {
> > -     if (mod->init_layout.size)
> > -             __mod_tree_remove(&mod->init_layout.mtn, &mod_tree);
> > +     for_class_mod_mem_type(type, init) {
> > +             if (mod->mem[type].size)
> > +                     __mod_tree_remove(&mod->mem[type].mtn, &mod_tree)=
;
> > +     }
> >   }
> >
> >   void mod_tree_remove(struct module *mod)
> >   {
> > -     __mod_tree_remove(&mod->core_layout.mtn, &mod_tree);
> > -     mod_tree_remove_init(mod);
> > -#ifdef CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
> > -     __mod_tree_remove(&mod->data_layout.mtn, &mod_data_tree);
> > -#endif
> > +     for_each_mod_mem_type(type) {
> > +             if (mod->mem[type].size)
> > +                     __mod_tree_remove(&mod->mem[type].mtn, &mod_tree)=
;
> > +     }
> >   }
> >
> >   struct module *mod_find(unsigned long addr, struct mod_tree_root *tre=
e)
