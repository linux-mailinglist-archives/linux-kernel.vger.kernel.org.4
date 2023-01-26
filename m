Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 282F567D5D9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 21:02:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232697AbjAZUCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 15:02:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232702AbjAZUCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 15:02:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288296E434;
        Thu, 26 Jan 2023 12:01:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9C45B81EDF;
        Thu, 26 Jan 2023 20:01:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FBFC433EF;
        Thu, 26 Jan 2023 20:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674763314;
        bh=eomNddM59o3lYml/N2hJOfRr2MeTcbChuKahWwPPKYs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qV49/CP+TjXDqh9WbfENpljK/EJfpaEuCM5B3IVmN5UBtvJdhR5fhxau+kS4du6q5
         3OPM+R1joQEAZ6rjwA30mk+0/+8FSRkxEQyr4kgyj7pb1Dk8kVW3YJOWlb11qDkgbk
         zs44Z9qKTOhteGSvTS7F/FCDInVIGy1MzbmmvVU+Kf7p+RSxjYzDsB4LJIN6ojR0QD
         v4wWWhf3jCukTxNDxOlx2Q2EzaK2tC8NvbJTi+hsojL4xMhagiGFLRZYEGPvZeYLSI
         xX0d7fCBmuhbGtpaO2/o9hGT6lzGL+655s4fScKEkGiWlYEeFF+GwCVit2h9ZcUiv1
         RueCKOPYkXIeg==
Received: by mail-lf1-f53.google.com with SMTP id d30so4716417lfv.8;
        Thu, 26 Jan 2023 12:01:54 -0800 (PST)
X-Gm-Message-State: AO0yUKVOr8PbXGh82cx0fU8LmkN6EXB3LowyVQpS9VSPZwXyMX13UrsA
        Vz51xPopebwgdYmvi6RQSOPAqxHvNFxSbBnCqsQ=
X-Google-Smtp-Source: AK7set/8k56Sy2VpxAvYKiOktRZunyLhAz3stBb5j2EUeR0d68jXoFqPZ2enpbR+U+8Rtmx4PC9Mi10vuGYcoiiLKBM=
X-Received: by 2002:ac2:43a4:0:b0:4d8:52ba:5054 with SMTP id
 t4-20020ac243a4000000b004d852ba5054mr173222lfl.310.1674763312400; Thu, 26 Jan
 2023 12:01:52 -0800 (PST)
MIME-Version: 1.0
References: <20230125185004.254742-1-song@kernel.org> <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
In-Reply-To: <Y9IYTI3pWuKbJ3bC@bombadil.infradead.org>
From:   Song Liu <song@kernel.org>
Date:   Thu, 26 Jan 2023 12:01:40 -0800
X-Gmail-Original-Message-ID: <CAPhsuW7ipGS=RhowYSp06DBYOY31sYoup7-Je+CEuKCxJsHavQ@mail.gmail.com>
Message-ID: <CAPhsuW7ipGS=RhowYSp06DBYOY31sYoup7-Je+CEuKCxJsHavQ@mail.gmail.com>
Subject: Re: [PATCH v2] module: replace module_layout with module_memory
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis,

Thanks for your kind review!

On Wed, Jan 25, 2023 at 10:06 PM Luis Chamberlain <mcgrof@kernel.org> wrote:
>
[...]
> >
> >         MOD_MEM_TYPE_TEXT,
> >         MOD_MEM_TYPE_DATA,
> >         MOD_MEM_TYPE_RODATA,
> >         MOD_MEM_TYPE_RO_AFTER_INIT,
> >         MOD_MEM_TYPE_INIT_TEXT,
> >         MOD_MEM_TYPE_INIT_DATA,
> >         MOD_MEM_TYPE_INIT_RODATA,
> >
> > and allocating them separately.
>
> First thanks for doing this work!
>
> This seems to not acknolwedge the original goal of the first module_layout and
> the latched rb-tree use, and that was was for speeding up __module_address()
> since it *can* even be triggered on NMIs. I say this because the first question
> that comes to me is the impact to performance on __module_address() I can't
> see that changing much here, but mention it as it similar consideration
> should be made in case future changes modify this path.

To make sure I understand this correctly. Do you mean we need something like
the following in the commit log?

"""
This adds slightly more entries to mod_tree (from up to 3 entries per module, to
up to 7 entries per module). However, this at most adds a small constant
overhead to __module_address(), which is expected to be fast.
"""

>
> Microbenching something so trivial as __module_address() may not be as useful
> for an idle system, at the very least being able to compare before and after
> even on idle may be useful *if* you eventually do some more radical changes
> here. Modules-related kernel/kallsyms_selftest.c did that for kallsyms_lookup_name()
> and friend just recently for a minor performance enhancement.

kernel/kallsyms_selftest.c is new to me. I will give it a try.

>
> At a high level it is perhaps my only conern so far while reviewing this patch,
> and I am glad it is now clear that addressing modules is a requirement. The rest
> seems like a highly welcomed cleanup even though the diffstat does not reflect
> that.
>
> > Various archs use module_layout for different data. These data are put
> > into different module_memory based on their location in module_layout.
> > IOW, data that used to go with text is allocated with MOD_MEM_TYPE_TEXT;
> > data that used to go with data is allocated with MOD_MEM_TYPE_DATA, etc.
>
> I think the commit log should document a bit the rationale for why
> ARCH_WANTS_MODULES_DATA_IN_VMALLOC gets *can* tidied up so well here.

Great point! Will add this in v3.

>
> > Signed-off-by: Song Liu <song@kernel.org>
> > Cc: Luis Chamberlain <mcgrof@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> >
> > ---
> >
> > This is the preparation work for the type aware module_alloc() discussed
> > in [1]. While this work is not covered much in the discussion, it is a
> > critical step of the effort.
> >
> > As this part grows pretty big (~1000 lines, + and -), I would like get
> > some feedback on it, so that I know it is on the right track.
> >
> > Please share your comments. Thanks!
> >
> > Test coverage: Tested on x86_64.
>
> I will likely merge this onto modules-next soon, not because I think it is
> ready, but just because I think it *is* mostly ready and the next thing
> we need is exposure and testing. rc5 is pretty late to consider this
> for v6.3 and so hopefully for this cycle we can at least settle on
> something which will sit in linux-next since the respective linux-next
> after v6.3-rc1 is released.

Yes, this definitely needs more tests. Given different archs use
module_layout in all sorts of ways. I will be very surprised if I updated
all them correctly (though I tried hard to).

>
> > Build tested by kernel test bot in [2]. The only regression in [2] was a
> > typo in parisc, which is also fixed.
> >
> > [1] https://lore.kernel.org/linux-mm/20221107223921.3451913-1-song@kernel.org/T/#u
>
> You still never addressed my performance suggestions so don't be
> surprised if I insist later. Yes you can use existing performance
> benchmarks, specially now with modules as a hard requirement, to
> show gains. So I'd like to clarify that if I'm reviewing late it is
> because:
>
> a) my modules patch review queue has been high as of late
> b) you seem to not have taken these performance suggestions into consideration
>    before and so I tend to put it at my end of my queue for review.

I think it will be a lot easier to run performance tests with the
module support. Let's see what we can do when we get to the
performance test part.

[...]
>
> > @@ -1389,16 +1466,29 @@ unsigned int __weak arch_mod_section_prepend(struct module *mod,
> >       return 0;
> >  }
> >
> > -/* Update size with this section: return offset. */
> > -long module_get_offset(struct module *mod, unsigned int *size,
> > -                    Elf_Shdr *sechdr, unsigned int section)
> > +/*
> > + * Use highest 4 bits of sh_entsize to store the mod_mem_type of this
> > + * section. This leaves 28 bits for offset on 32-bit systems, which is
> > + * about 256 MiB (WARN_ON_ONCE if we exceed that).
> > + */
> > +
> > +#define SH_ENTSIZE_TYPE_BITS 4
> > +#define SH_ENTSIZE_TYPE_SHIFT        (BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)
> > +#define SH_ENTSIZE_TYPE_MASK ((1UL << SH_ENTSIZE_TYPE_BITS) - 1)
> > +#define SH_ENTSIZE_OFFSET_MASK       ((1UL << (BITS_PER_LONG - SH_ENTSIZE_TYPE_BITS)) - 1)
> > +
> > +long module_get_offset_and_type(struct module *mod, enum mod_mem_type type,
> > +                             Elf_Shdr *sechdr, unsigned int section)
> >  {
> > -     long ret;
> > +     long offset;
> > +     long mask = ((unsigned long)(type) & SH_ENTSIZE_TYPE_MASK) << SH_ENTSIZE_TYPE_SHIFT;
> >
> > -     *size += arch_mod_section_prepend(mod, section);
> > -     ret = ALIGN(*size, sechdr->sh_addralign ?: 1);
> > -     *size = ret + sechdr->sh_size;
> > -     return ret;
> > +     mod->mod_mem[type].size += arch_mod_section_prepend(mod, section);
> > +     offset = ALIGN(mod->mod_mem[type].size, sechdr->sh_addralign ?: 1);
> > +     mod->mod_mem[type].size = offset + sechdr->sh_size;
> > +
> > +     WARN_ON_ONCE(offset & mask);
> > +     return offset | mask;
> >  }
>
> Could you split this somehow with the mask stuff up into its own
> non-functional patch first somehow to make this easier to review?
>
> No worries if you can't.

This is not very straightforward with INIT_OFFSET_MASK. So I will keep
it as-is for now. Btw, while looking into this, I found a leftover
INIT_OFFSET_MASK that I will remove in v3.

>
> > @@ -2117,74 +2193,45 @@ static int find_module_sections(struct module *mod, struct load_info *info)
> >
> >  static int move_module(struct module *mod, struct load_info *info)
> >  {
> > +     enum mod_mem_type type;
> >       int i;
> >       void *ptr;
> >
> > -     /* Do the allocs. */
> > -     ptr = module_alloc(mod->core_layout.size);
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
> > -     mod->core_layout.base = ptr;
> > +     for_each_mod_mem_type(type) {
> > +             if (!mod->mod_mem[type].size) {
> > +                     mod->mod_mem[type].base = NULL;
> > +                     continue;
> > +             }
> > +             mod->mod_mem[type].size = PAGE_ALIGN(mod->mod_mem[type].size);
> > +             if (mod_mem_use_vmalloc(type))
> > +                     ptr = vzalloc(mod->mod_mem[type].size);
> > +             else
> > +                     ptr = module_alloc(mod->mod_mem[type].size);
>
> This form to check for mod_mem_use_vmalloc() is used twice, how about
> a helper to just do it one line for us?

Good idea! Will update in v3.

>
> > @@ -2195,6 +2242,14 @@ static int move_module(struct module *mod, struct load_info *info)
> >       }
> >
> >       return 0;
> > +out_enomem:
> > +     for (type--; type >= 0; type--) {
> > +             if (mod_mem_use_vmalloc(type))
> > +                     vfree(mod->mod_mem[type].base);
> > +             else
> > +                     module_memfree(mod->mod_mem[type].base);
> > +     }
> > +     return -ENOMEM;
> >  }
>
> Here's the other user.
>
> > diff --git a/kernel/module/strict_rwx.c b/kernel/module/strict_rwx.c
>
> This was the hardest file to review and so I ask the same, if a separate
> non-functional change could be done first to make the changes easier
> to review.

AFAICT, strict_rwx.c is pretty straightforward after the change. And it is
just ~100 LOC. The non-functional change is very likely to be more
complicated. So I will keep this part as-is.

>
> No worries if not.
>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>

I will fix these, rebase, and send v3.

Thanks again!
Song
