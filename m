Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457C470E9FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238928AbjEXAFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEXAFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAF10E5;
        Tue, 23 May 2023 17:05:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D4562FBF;
        Wed, 24 May 2023 00:05:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D318FC4339B;
        Wed, 24 May 2023 00:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684886726;
        bh=c87dWfVIQm/nlzRv/KMLKVrwTHENHNLcmE0pdAdLe9o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=OW1pb27yVUhopPe1LpHaPewR4l6jjgc68XiZBzRUDCFDtWBYe5+2rF0+MlsizNFEM
         7XpiUYVuQImePtZ8HpkX45RrIH18oN8XnMu4opd3CW+nnHVGUEjDaYVGz4RD53XuAa
         jDZ8hBNRhU0bQjAnwk8rXBySv4L88NXN2Lam8iwowvuYnYZyV3f5cPmua6mCZa7MDt
         s9qyrMc7QR/ZoknEI/dw7UHhPou/p9WyHNTaYfajSg+lItMX3Q7T6f36TftE30h8eF
         5C7pEBXvK+d5m+tBF/qMuk6eidHH/9AV0TZVCRV7ILixxh6xzu5g5UfBtUmtYByjsR
         My9THfihL2S/w==
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-39810ce3e13so310159b6e.2;
        Tue, 23 May 2023 17:05:26 -0700 (PDT)
X-Gm-Message-State: AC+VfDzOXhFR70nR59lKbl9ikwiF22YbkTl+Y2oNVHCcGHRL+ZJTp0Fw
        i8Qg6BVTMw5eYV9tNu9/f6DIxeNt2aKwLoXk8Xw=
X-Google-Smtp-Source: ACHHUZ5zgeo+bl4IlfyfI42y83apWO7cSnlKyUWFgBeMURoyHPsQMVQekNPkCs7jFSTpHTmO7uHYiJOUqtQ3Z9ciU1E=
X-Received: by 2002:aca:6747:0:b0:398:3671:9bfe with SMTP id
 b7-20020aca6747000000b0039836719bfemr1685268oiy.31.1684886726117; Tue, 23 May
 2023 17:05:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-4-masahiroy@kernel.org> <CAKwvOdmxLrE8VksbsSGirfTqnuhEFT__FuCG53ri3V42UbH5aw@mail.gmail.com>
In-Reply-To: <CAKwvOdmxLrE8VksbsSGirfTqnuhEFT__FuCG53ri3V42UbH5aw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 24 May 2023 09:04:49 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR8UE8298b=WxyUkG99pe=yb_m=qdsiW+jMcACg=jvCwA@mail.gmail.com>
Message-ID: <CAK7LNAR8UE8298b=WxyUkG99pe=yb_m=qdsiW+jMcACg=jvCwA@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] modpost: detect section mismatch for
 R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
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

On Tue, May 23, 2023 at 3:03=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
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


I replied to Ard's email, but just in case.


modpost does not need to write back the fixed instruction.
modpost is only interested in the offset address.

So, the right-shift by 16 is unneeded.






--=20
Best Regards
Masahiro Yamada
