Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADA0642BC1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 16:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232827AbiLEP3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 10:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiLEP3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 10:29:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CA96347;
        Mon,  5 Dec 2022 07:28:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36433611AB;
        Mon,  5 Dec 2022 15:28:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667D3C433D6;
        Mon,  5 Dec 2022 15:28:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670254093;
        bh=Jmkt/6PesiLUerzNDnaGjzQezxhRSVgH7lMImePJ31s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pWuA7w+3ChSIKV1HA4BQStqdKUZjj1LShIyPMNiAF/48YCCahdCX4dPBNBJIZBI5O
         EBCMhUMfeahlRTKCSzCW9G8iVQoJ505nEXSabfl+EbZsWOk76Dlqe8/3hFpjE29Qln
         HmPI1hW4QvUuWRxUGNuIPBu5bWaHhN1fBpgWIJOI5ie8sN4DJ7T/iCg9om7AMbD7eJ
         3uc8cYt4iLIieQuq9S4IbP9bemT27vLg+sYy/7j87v6KhUV0YwMJLW5l0+lwkdZwhk
         i3ERH6ZailqNT8+m+wJuBDMaOaTZ7uU9NON4wynTiTnkUrHximEp+iX1NRvoGahFMV
         SBHwu5a1D1ZQQ==
Date:   Mon, 5 Dec 2022 23:18:17 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Guo Ren <guoren@kernel.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Andrew Jones <ajones@ventanamicro.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, kvm-riscv@lists.infradead.org
Subject: Re: [PATCH v2 09/13] riscv: switch to relative alternative entries
Message-ID: <Y44LuRcQYPnVnFje@xhacker>
References: <20221204174632.3677-1-jszhang@kernel.org>
 <20221204174632.3677-10-jszhang@kernel.org>
 <CAJF2gTRxm7LJFtups5fexJ5ishm9_j3e+yzfKv3nTtQqUtXPtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJF2gTRxm7LJFtups5fexJ5ishm9_j3e+yzfKv3nTtQqUtXPtA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 08:51:41AM +0800, Guo Ren wrote:
> On Mon, Dec 5, 2022 at 1:57 AM Jisheng Zhang <jszhang@kernel.org> wrote:
> >
> > Instead of using absolute addresses for both the old instrucions and
> > the alternative instructions, use offsets relative to the alt_entry
> > values. So we can not only cut the size of the alternative entry, but
> > also meet the prerequisite for patching alternatives in the vDSO,
> > since absolute alternative entries are subject to dynamic relocation,
> > which is incompatible with the vDSO building.
> >
> > Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> > ---
> >  arch/riscv/errata/sifive/errata.c           |  4 +++-
> >  arch/riscv/errata/thead/errata.c            | 11 ++++++++---
> >  arch/riscv/include/asm/alternative-macros.h | 20 ++++++++++----------
> >  arch/riscv/include/asm/alternative.h        | 12 ++++++------
> >  arch/riscv/kernel/cpufeature.c              | 13 ++++++-------
> >  5 files changed, 33 insertions(+), 27 deletions(-)
> >
> > diff --git a/arch/riscv/errata/sifive/errata.c b/arch/riscv/errata/sifive/errata.c
> > index 1031038423e7..0e537cdfd324 100644
> > --- a/arch/riscv/errata/sifive/errata.c
> > +++ b/arch/riscv/errata/sifive/errata.c
> > @@ -107,7 +107,9 @@ void __init_or_module sifive_errata_patch_func(struct alt_entry *begin,
> >
> >                 tmp = (1U << alt->errata_id);
> >                 if (cpu_req_errata & tmp) {
> > -                       patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> > +                       patch_text_nosync((void *)&alt->old_offset + alt->old_offset,
> > +                                         (void *)&alt->alt_offset + alt->alt_offset,
>  (void *)&alt->alt_offset + alt->alt_offset. ??!!

Hi Guo,

what's the problem? I can't catch your meaning, could you please proide
more details?

Thanks

> 
> > +                                         alt->alt_len);
> >                         cpu_apply_errata |= tmp;
> >                 }
> >         }
> > diff --git a/arch/riscv/errata/thead/errata.c b/arch/riscv/errata/thead/errata.c
> > index 21546937db39..2a6e335b5a32 100644
> > --- a/arch/riscv/errata/thead/errata.c
> > +++ b/arch/riscv/errata/thead/errata.c
> > @@ -68,6 +68,7 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
> >         struct alt_entry *alt;
> >         u32 cpu_req_errata = thead_errata_probe(stage, archid, impid);
> >         u32 tmp;
> > +       void *oldptr, *updptr;
> >
> >         for (alt = begin; alt < end; alt++) {
> >                 if (alt->vendor_id != THEAD_VENDOR_ID)
> > @@ -77,12 +78,16 @@ void __init_or_module thead_errata_patch_func(struct alt_entry *begin, struct al
> >
> >                 tmp = (1U << alt->errata_id);
> >                 if (cpu_req_errata & tmp) {
> > +                       oldptr = (void *)&alt->old_offset + alt->old_offset;
> > +                       updptr = (void *)&alt->alt_offset + alt->alt_offset;
> > +
> >                         /* On vm-alternatives, the mmu isn't running yet */
> >                         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> > -                               memcpy((void *)__pa_symbol(alt->old_ptr),
> > -                                      (void *)__pa_symbol(alt->alt_ptr), alt->alt_len);
> > +                               memcpy((void *)__pa_symbol(oldptr),
> > +                                      (void *)__pa_symbol(updptr),
> > +                                      alt->alt_len);
> >                         else
> > -                               patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> > +                               patch_text_nosync(oldptr, updptr, alt->alt_len);
> >                 }
> >         }
> >
> > diff --git a/arch/riscv/include/asm/alternative-macros.h b/arch/riscv/include/asm/alternative-macros.h
> > index ec2f3f1b836f..dd40727bc859 100644
> > --- a/arch/riscv/include/asm/alternative-macros.h
> > +++ b/arch/riscv/include/asm/alternative-macros.h
> > @@ -7,11 +7,11 @@
> >  #ifdef __ASSEMBLY__
> >
> >  .macro ALT_ENTRY oldptr newptr vendor_id errata_id new_len
> > -       RISCV_PTR \oldptr
> > -       RISCV_PTR \newptr
> > -       REG_ASM \vendor_id
> > -       REG_ASM \new_len
> > -       .word   \errata_id
> > +       .long \oldptr - .
> > +       .long \newptr - .
> > +       .short \vendor_id
> > +       .short \new_len
> > +       .long \errata_id
> >  .endm
> >
> >  .macro ALT_NEW_CONTENT vendor_id, errata_id, enable = 1, new_c : vararg
> > @@ -75,11 +75,11 @@
> >  #include <linux/stringify.h>
> >
> >  #define ALT_ENTRY(oldptr, newptr, vendor_id, errata_id, newlen)                \
> > -       RISCV_PTR " " oldptr "\n"                                       \
> > -       RISCV_PTR " " newptr "\n"                                       \
> > -       REG_ASM " " vendor_id "\n"                                      \
> > -       REG_ASM " " newlen "\n"                                         \
> > -       ".word " errata_id "\n"
> > +       ".long  ((" oldptr ") - .) \n"                                  \
> > +       ".long  ((" newptr ") - .) \n"                                  \
> > +       ".short " vendor_id "\n"                                        \
> > +       ".short " newlen "\n"                                           \
> > +       ".long  " errata_id "\n"
> >
> >  #define ALT_NEW_CONTENT(vendor_id, errata_id, enable, new_c)           \
> >         ".if " __stringify(enable) " == 1\n"                            \
> > diff --git a/arch/riscv/include/asm/alternative.h b/arch/riscv/include/asm/alternative.h
> > index 33eae9541684..3baf32e05b46 100644
> > --- a/arch/riscv/include/asm/alternative.h
> > +++ b/arch/riscv/include/asm/alternative.h
> > @@ -33,12 +33,12 @@ void riscv_alternative_fix_jal(void *alt_ptr, unsigned int len,
> >                                int patch_offset);
> >
> >  struct alt_entry {
> > -       void *old_ptr;           /* address of original instruciton or data  */
> > -       void *alt_ptr;           /* address of replacement instruction or data */
> > -       unsigned long vendor_id; /* cpu vendor id */
> > -       unsigned long alt_len;   /* The replacement size */
> > -       unsigned int errata_id;  /* The errata id */
> > -} __packed;
> > +       s32 old_offset;         /* offset to original instruciton or data  */
> > +       s32 alt_offset;         /* offset to replacement instruction or data */
> > +       u16 vendor_id;          /* cpu vendor id */
> > +       u16 alt_len;            /* The replacement size */
> > +       u32 errata_id;          /* The errata id */
> > +};
> >
> >  struct errata_checkfunc_id {
> >         unsigned long vendor_id;
> > diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
> > index 6244be5cd94a..adeac90b1d8e 100644
> > --- a/arch/riscv/kernel/cpufeature.c
> > +++ b/arch/riscv/kernel/cpufeature.c
> > @@ -257,6 +257,7 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
> >                                                   unsigned int stage)
> >  {
> >         struct alt_entry *alt;
> > +       void *oldptr, *updptr;
> >
> >         if (stage == RISCV_ALTERNATIVES_EARLY_BOOT)
> >                 return;
> > @@ -270,17 +271,15 @@ void __init_or_module riscv_cpufeature_patch_func(struct alt_entry *begin,
> >                         continue;
> >                 }
> >
> > +               oldptr = (void *)&alt->old_offset + alt->old_offset;
> > +               updptr = (void *)&alt->alt_offset + alt->alt_offset;
> >                 if (!__riscv_isa_extension_available(NULL, alt->errata_id))
> >                         continue;
> >
> >                 /* do the basic patching */
> > -               patch_text_nosync(alt->old_ptr, alt->alt_ptr, alt->alt_len);
> > -               riscv_alternative_fix_auipc_jalr(alt->old_ptr,
> > -                                                alt->alt_len,
> > -                                                alt->old_ptr - alt->alt_ptr);
> > -               riscv_alternative_fix_jal(alt->old_ptr,
> > -                                         alt->alt_len,
> > -                                         alt->old_ptr - alt->alt_ptr);
> > +               patch_text_nosync(oldptr, updptr, alt->alt_len);
> > +               riscv_alternative_fix_auipc_jalr(oldptr, alt->alt_len, oldptr - updptr);
> > +               riscv_alternative_fix_jal(oldptr, alt->alt_len, oldptr - updptr);
> >         }
> >  }
> >  #endif
> > --
> > 2.37.2
> >
> 
> 
> -- 
> Best Regards
>  Guo Ren
