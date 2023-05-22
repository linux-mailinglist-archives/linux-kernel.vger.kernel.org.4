Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0447A70CCE3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231578AbjEVVug (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjEVVue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:50:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970A4E9;
        Mon, 22 May 2023 14:50:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 33EF962420;
        Mon, 22 May 2023 21:50:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7B8C4339B;
        Mon, 22 May 2023 21:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684792232;
        bh=w9LBRRyqm5803GlEmQJZqgi6Hi543bH+GSEVI71mr4U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=I/ontW20EvDbJnLq6xU5ShiaD22MGoctonKdCZgJ8gdqcX72r119hzIeZAh0/zSex
         suWbalsmVxpagJITEksC5QDQdQMuZj6/1Nqw2wB392BrnmgEB+WTUv+De1sojJeeWv
         rx09Wex8VG7mLJY3XZRYlevH/v8IhVOQiORX13FmcXbgRfVq1p2TH6HlxgtuKJC3eh
         OY5ncdQW1Cz9CvScLvWLZjH/ByafHUPKSJ9vmDB42vMJ7VY9cPlZ3rnKQBAVjsID3o
         elw5AKO5B7HrPXsiPpuOBbs94GEe60VeKv7JoP2+i5QONa3kcH/EPA7g+j+bmWN+RR
         RHeuYfzIBqLbg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2af2602848aso45471211fa.2;
        Mon, 22 May 2023 14:50:32 -0700 (PDT)
X-Gm-Message-State: AC+VfDyu9//3H0RNtWWHukCmYs4QTpmzeofehXWQaNtmmG2NjEqUOMKx
        MwUApKjgUOeyIzriX4tNig5/S4+vsfKT7VtI+hA=
X-Google-Smtp-Source: ACHHUZ7FchTNICuptLDm84N5BY9TxQGeCVjWIPYByI/t/mb7wnhfP/8Wo2cawp25N0HDhoKLpZsG6wakqtavDnBCxYI=
X-Received: by 2002:a2e:9cce:0:b0:29c:3f18:57a7 with SMTP id
 g14-20020a2e9cce000000b0029c3f1857a7mr4510593ljj.35.1684792230596; Mon, 22
 May 2023 14:50:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-4-masahiroy@kernel.org> <CAKwvOdmxLrE8VksbsSGirfTqnuhEFT__FuCG53ri3V42UbH5aw@mail.gmail.com>
In-Reply-To: <CAKwvOdmxLrE8VksbsSGirfTqnuhEFT__FuCG53ri3V42UbH5aw@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 May 2023 23:50:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGZLn37bchQ8NZy6zPgsMNT=CE7pZ0voTsnu=ytSf2i7g@mail.gmail.com>
Message-ID: <CAMj1kXGZLn37bchQ8NZy6zPgsMNT=CE7pZ0voTsnu=ytSf2i7g@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] modpost: detect section mismatch for
 R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 at 20:03, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> + linux-arm-kernel
>
> On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > ARM defconfig misses to detect some section mismatches.
> >
> >   [test code]
> >
> >     #include <linux/init.h>
> >
> >     int __initdata foo;
> >     int get_foo(int x) { return foo; }
> >
> > It is apparently a bad reference, but modpost does not report anything
> > for ARM defconfig (i.e. multi_v7_defconfig).
> >
> > The test code above produces the following relocations.
> >
> >   Relocation section '.rel.text' at offset 0x200 contains 2 entries:
> >    Offset     Info    Type            Sym.Value  Sym. Name
> >   00000000  0000062b R_ARM_MOVW_ABS_NC 00000000   .LANCHOR0
> >   00000004  0000062c R_ARM_MOVT_ABS    00000000   .LANCHOR0
> >
> >   Relocation section '.rel.ARM.exidx' at offset 0x210 contains 2 entrie=
s:
> >    Offset     Info    Type            Sym.Value  Sym. Name
> >   00000000  0000022a R_ARM_PREL31      00000000   .text
> >   00000000  00001000 R_ARM_NONE        00000000   __aeabi_unwind_cpp_pr=
0
> >
> > Currently, R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS are just skipped.
> >
> > Add code to handle them. I checked arch/arm/kernel/module.c to learn
> > how the offset is encoded in the instruction.
> >
> > The referenced symbol in relocation might be a local anchor.
> > If is_valid_name() returns false, let's search for a better symbol name=
.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 12 ++++++++++--
> >  1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 34fbbd85bfde..ed2301e951a9 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1108,7 +1108,7 @@ static inline int is_valid_name(struct elf_info *=
elf, Elf_Sym *sym)
> >  /**
> >   * Find symbol based on relocation record info.
> >   * In some cases the symbol supplied is a valid symbol so
> > - * return refsym. If st_name !=3D 0 we assume this is a valid symbol.
> > + * return refsym. If is_valid_name() =3D=3D true, we assume this is a =
valid symbol.
> >   * In other cases the symbol needs to be looked up in the symbol table
> >   * based on section and address.
> >   *  **/
> > @@ -1121,7 +1121,7 @@ static Elf_Sym *find_tosym(struct elf_info *elf, =
Elf64_Sword addr,
> >         Elf64_Sword d;
> >         unsigned int relsym_secindex;
> >
> > -       if (relsym->st_name !=3D 0)
> > +       if (is_valid_name(elf, relsym))
> >                 return relsym;
> >
> >         /*
> > @@ -1312,11 +1312,19 @@ static int addend_arm_rel(struct elf_info *elf,=
 Elf_Shdr *sechdr, Elf_Rela *r)
> >         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> >         Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
> >         unsigned int inst =3D TO_NATIVE(*reloc_location(elf, sechdr, r)=
);
> > +       int offset;
> >
> >         switch (r_typ) {
> >         case R_ARM_ABS32:
> >                 r->r_addend =3D inst + sym->st_value;
> >                 break;
> > +       case R_ARM_MOVW_ABS_NC:
> > +       case R_ARM_MOVT_ABS:
> > +               offset =3D ((inst & 0xf0000) >> 4) | (inst & 0xfff);
> > +               offset =3D (offset ^ 0x8000) - 0x8000;
>
> The code in arch/arm/kernel/module.c then right shifts the offset by
> 16 for R_ARM_MOVT_ABS. Is that necessary?
>

MOVW/MOVT pairs are limited to an addend of -/+ 32 KiB, and the same
value must be encoded in both instructions.

When constructing the actual immediate value from the symbol value and
the addend, only the top 16 bits are used in MOVT and the bottom 16
bits in MOVW.

However, this code seems to borrow the Elf_Rela::addend field (which
ARM does not use natively) to record the intermediate value, which
would need to be split if it is used to fix up instruction opcodes.

Btw the Thumb2 encodings of MOVT and MOVW seem to be missing here.


> > +               offset +=3D sym->st_value;
> > +               r->r_addend =3D offset;
> > +               break;
> >         case R_ARM_PC24:
> >         case R_ARM_CALL:
> >         case R_ARM_JUMP24:
> > --
> > 2.39.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
