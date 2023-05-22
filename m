Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9819D70CC96
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 23:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231937AbjEVVgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 17:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjEVVgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 17:36:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00677A7;
        Mon, 22 May 2023 14:36:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88A0B62A5A;
        Mon, 22 May 2023 21:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8B38C4339C;
        Mon, 22 May 2023 21:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684791367;
        bh=i0l5o5pfr7+hmOunK0MO3ExMQQJ2u2MgDt54T+EjxjA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=drtfnRszWDVpJ+tOK7F6GtOC1nsARB4mApAVld5et6zjpTn3+gcgUrwyxyB9j1olb
         bOJv7MJhIO6eUNaZ/GVdAaaocjgJvv7T3ekIMw4GatuzyqfnRSaO8CPYu6rOM1RbUW
         iJffkN7/USx/LdV/Z2kLpim6Je8ONEiwDTEcIYqF1MrKLm+gMwngLI+b91TAPVK/ib
         ZcDV6KjyPYJQRbpNevdbM3oUCVyjWIYg9eV8iZEh+aJcJ9sMY6z9sQ8hvNOIu5eKjJ
         tWy+YWb4Th7mUgHiNdJgYN80TRQmjUNPbzYUzg2Qv/ROBF/2ZmqGfAE643gp1XcnKo
         tHkJhE0JJoHQg==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2af29e51722so40866141fa.1;
        Mon, 22 May 2023 14:36:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDzf3DSyBnp8hiZygQW+CIXjncKNxFZ7uoHOPZyO8ErY4Pw8YtP7
        8Iei409JX3xCMhrSnLdKEU68M+g8a3jYq+wVAHY=
X-Google-Smtp-Source: ACHHUZ5cVVFzaDoPp3qHJJ+S8cugosBnuG9dSVQs8Sdhh1V/e5uFdGgK3IxPNtjm4w9Ah/32do79AcFNzsCrNSOo7ME=
X-Received: by 2002:a2e:b1c4:0:b0:2af:22a0:81fd with SMTP id
 e4-20020a2eb1c4000000b002af22a081fdmr4023555lja.11.1684791365795; Mon, 22 May
 2023 14:36:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-3-masahiroy@kernel.org> <CAKwvOd=B+dKWjxD-K-8btROvywp_Nei=CREeYZdCvKSGuHHJOA@mail.gmail.com>
In-Reply-To: <CAKwvOd=B+dKWjxD-K-8btROvywp_Nei=CREeYZdCvKSGuHHJOA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 22 May 2023 23:35:54 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEYZdsE8A2izGbb4HWYT3a8HN9Ocw=pb3d64Zu0441RgA@mail.gmail.com>
Message-ID: <CAMj1kXEYZdsE8A2izGbb4HWYT3a8HN9Ocw=pb3d64Zu0441RgA@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] modpost: fix section mismatch message for R_ARM_ABS32
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 at 19:56, Nick Desaulniers <ndesaulniers@google.com> wr=
ote:
>
> + linux-arm-kernel and some folks who might know another idea.
>
> On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > addend_arm_rel() processes R_ARM_ABS32 in a wrong way.
> >
> > Here, simple test code.
> >
> >   [test code 1]
> >
> >     #include <linux/init.h>
> >
> >     int __initdata foo;
> >     int get_foo(int x) { return foo; }
> >
> > If you compile it with ARM versatile_defconfig, modpost will show the
> > symbol name, (unknown).
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (=
section: .text) -> (unknown) (section: .init.data)
> >
> > If you compile it for other architectures, modpost will show the correc=
t
> > symbol name.
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (=
section: .text) -> foo (section: .init.data)
> >
> > For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value.
> >
> > I just mimicked the code in arch/arm/kernel/module.c.
> >
> > However, there is more difficulty for ARM.
> >
> > Here, test code.
> >
> >   [test code 2]
> >
> >     #include <linux/init.h>
> >
> >     int __initdata foo;
> >     int get_foo(int x) { return foo; }
> >
> >     int __initdata bar;
> >     int get_bar(int x) { return bar; }
> >
> > With this commit applied, modpost will show the following messages
> > for ARM versatile_defconfig:
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (=
section: .text) -> foo (section: .init.data)
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_bar (=
section: .text) -> foo (section: .init.data)
> >
> > The reference from 'get_bar' to 'foo' seems wrong.
> >
> > I have no solution for this because it is true in assembly level.
> >
> > In the following output, relocation at 0x1c is no longer associated
> > with 'bar'. The two relocation entries point to the same symbol, and
> > the offset to 'bar' is encoded in the instruction 'r0, [r3, #4]'.
> >

These are section relative relocations - this is unusual but not
incorrect. Normally, you only see this if the symbols in question have
static linkage.

It does mean that the symbol is not preemptible, which is what makes
this somewhat surprising.

Generally, you cannot resolve a relocation to a symbol without taking
the addend into account, so looking up the address of .init.data in
the symbol table is not quite the right approach here. If anything,
the symbol should be reported as [.init.data+0x4] in the second case.

> >   Disassembly of section .text:
> >
> >   00000000 <get_foo>:
> >      0: e59f3004          ldr     r3, [pc, #4]   @ c <get_foo+0xc>
> >      4: e5930000          ldr     r0, [r3]
> >      8: e12fff1e          bx      lr
> >      c: 00000000          .word   0x00000000
> >
> >   00000010 <get_bar>:
> >     10: e59f3004          ldr     r3, [pc, #4]   @ 1c <get_bar+0xc>
> >     14: e5930004          ldr     r0, [r3, #4]
> >     18: e12fff1e          bx      lr
> >     1c: 00000000          .word   0x00000000
> >
> >   Relocation section '.rel.text' at offset 0x244 contains 2 entries:
> >    Offset     Info    Type            Sym.Value  Sym. Name
> >   0000000c  00000c02 R_ARM_ABS32       00000000   .init.data
> >   0000001c  00000c02 R_ARM_ABS32       00000000   .init.data
> >
> > When find_elf_symbol() gets into a situation where relsym->st_name is
> > zero, there is no guarantee to get the symbol name as written in C.
> >
> > I am keeping the current logic because it is useful in many architectur=
es,
> > but the symbol name is not always correct depending on the optimization
> > of the relocation. I left some comments in find_tosym().
> >
> > Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on a=
rm")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > Changes in v6:
> >  - More detailed commit log
> >
> >  scripts/mod/modpost.c | 10 +++++++---
> >  1 file changed, 7 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 71de14544432..34fbbd85bfde 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1124,6 +1124,10 @@ static Elf_Sym *find_tosym(struct elf_info *elf,=
 Elf64_Sword addr,
> >         if (relsym->st_name !=3D 0)
> >                 return relsym;
> >
> > +       /*
> > +        * Strive to find a better symbol name, but the resulting name =
does not
> > +        * always match the symbol referenced in the original code.
> > +        */
> >         relsym_secindex =3D get_secindex(elf, relsym);
> >         for (sym =3D elf->symtab_start; sym < elf->symtab_stop; sym++) =
{
> >                 if (get_secindex(elf, sym) !=3D relsym_secindex)
> > @@ -1306,12 +1310,12 @@ static int addend_386_rel(struct elf_info *elf,=
 Elf_Shdr *sechdr, Elf_Rela *r)
> >  static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_=
Rela *r)
> >  {
> >         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> > +       Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
> > +       unsigned int inst =3D TO_NATIVE(*reloc_location(elf, sechdr, r)=
);
> >
> >         switch (r_typ) {
> >         case R_ARM_ABS32:
> > -               /* From ARM ABI: (S + A) | T */
> > -               r->r_addend =3D (int)(long)
> > -                             (elf->symtab_start + ELF_R_SYM(r->r_info)=
);
> > +               r->r_addend =3D inst + sym->st_value;
> >                 break;
> >         case R_ARM_PC24:
> >         case R_ARM_CALL:
> > --
> > 2.39.2
> >
>
>
> --
> Thanks,
> ~Nick Desaulniers
