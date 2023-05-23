Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD10B70DBE0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 13:59:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236730AbjEWL7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 07:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjEWL7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 07:59:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7EA3138;
        Tue, 23 May 2023 04:59:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BEB260A76;
        Tue, 23 May 2023 11:59:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2879C4339B;
        Tue, 23 May 2023 11:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684843176;
        bh=cZRMnaWqP5mfA9NqMeJMEcLYT/LYiBSk1XN8SvO9krY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Nak0CZd3WuJupeoRhpYwR51fYVp5cVnfjOT9qDG+RXfhwwL8CVw3ZjBnazBzr9VoI
         BnGz+SLTe+gBcLqzI/f2d5a3q45M7stZlx0QADs0X82FsM54lJHOuI0uHbDrbuHx/d
         mLubjqVSiCMOaUpvFnct73OyJWVWlF8xUhykwvjpKWcmwYnaydzcg8lAm3Hw+Q0a64
         KQKrmPWl0GgpIPMAiQwMAX1dPqtd75wihuylSM80h+9ts3XFDPG0CKhkkMdPEQ9iIz
         FLxFVjsn0mz0KqikTFcvR2PVGXmH7L4T4mEXfgQpr8ux6Uq/DXc8pSa7HYniqp8z4i
         0Dc+ZjVPwFlJQ==
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-397f0bb41a2so888232b6e.0;
        Tue, 23 May 2023 04:59:36 -0700 (PDT)
X-Gm-Message-State: AC+VfDz1+bQ/nKwb63yYqVCWF+5oIUTWF3DG2GXgZhp4W3VXQ3VJQfoY
        aoM8wTKxZtFxoS6thN7nO1WCm3LkJxz0TfLA7WY=
X-Google-Smtp-Source: ACHHUZ4/PEiQJ4jSA5HlSzPabWNUB5hHdhkQuhi4nt/PWbQK0bGMDATvrmhC1WVjenOKfxEM8sjh0qWkz4x+q4v7OAs=
X-Received: by 2002:aca:2808:0:b0:398:100d:7ae7 with SMTP id
 8-20020aca2808000000b00398100d7ae7mr2889209oix.43.1684843176109; Tue, 23 May
 2023 04:59:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-4-masahiroy@kernel.org> <CAKwvOdmxLrE8VksbsSGirfTqnuhEFT__FuCG53ri3V42UbH5aw@mail.gmail.com>
 <CAMj1kXGZLn37bchQ8NZy6zPgsMNT=CE7pZ0voTsnu=ytSf2i7g@mail.gmail.com>
In-Reply-To: <CAMj1kXGZLn37bchQ8NZy6zPgsMNT=CE7pZ0voTsnu=ytSf2i7g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 23 May 2023 20:58:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASEj618kZn8ANnZwfFC54MuFx3UxgnqG=ByeubD7vUymA@mail.gmail.com>
Message-ID: <CAK7LNASEj618kZn8ANnZwfFC54MuFx3UxgnqG=ByeubD7vUymA@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] modpost: detect section mismatch for
 R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
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

On Tue, May 23, 2023 at 6:50=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Mon, 22 May 2023 at 20:03, Nick Desaulniers <ndesaulniers@google.com> =
wrote:
> >
> > + linux-arm-kernel
> >
> > On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kern=
el.org> wrote:
> > >
> > > ARM defconfig misses to detect some section mismatches.
> > >
> > >   [test code]
> > >
> > >     #include <linux/init.h>
> > >
> > >     int __initdata foo;
> > >     int get_foo(int x) { return foo; }
> > >
> > > It is apparently a bad reference, but modpost does not report anythin=
g
> > > for ARM defconfig (i.e. multi_v7_defconfig).
> > >
> > > The test code above produces the following relocations.
> > >
> > >   Relocation section '.rel.text' at offset 0x200 contains 2 entries:
> > >    Offset     Info    Type            Sym.Value  Sym. Name
> > >   00000000  0000062b R_ARM_MOVW_ABS_NC 00000000   .LANCHOR0
> > >   00000004  0000062c R_ARM_MOVT_ABS    00000000   .LANCHOR0
> > >
> > >   Relocation section '.rel.ARM.exidx' at offset 0x210 contains 2 entr=
ies:
> > >    Offset     Info    Type            Sym.Value  Sym. Name
> > >   00000000  0000022a R_ARM_PREL31      00000000   .text
> > >   00000000  00001000 R_ARM_NONE        00000000   __aeabi_unwind_cpp_=
pr0
> > >
> > > Currently, R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS are just skipped.
> > >
> > > Add code to handle them. I checked arch/arm/kernel/module.c to learn
> > > how the offset is encoded in the instruction.
> > >
> > > The referenced symbol in relocation might be a local anchor.
> > > If is_valid_name() returns false, let's search for a better symbol na=
me.
> > >
> > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > ---
> > >
> > >  scripts/mod/modpost.c | 12 ++++++++++--
> > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > index 34fbbd85bfde..ed2301e951a9 100644
> > > --- a/scripts/mod/modpost.c
> > > +++ b/scripts/mod/modpost.c
> > > @@ -1108,7 +1108,7 @@ static inline int is_valid_name(struct elf_info=
 *elf, Elf_Sym *sym)
> > >  /**
> > >   * Find symbol based on relocation record info.
> > >   * In some cases the symbol supplied is a valid symbol so
> > > - * return refsym. If st_name !=3D 0 we assume this is a valid symbol=
.
> > > + * return refsym. If is_valid_name() =3D=3D true, we assume this is =
a valid symbol.
> > >   * In other cases the symbol needs to be looked up in the symbol tab=
le
> > >   * based on section and address.
> > >   *  **/
> > > @@ -1121,7 +1121,7 @@ static Elf_Sym *find_tosym(struct elf_info *elf=
, Elf64_Sword addr,
> > >         Elf64_Sword d;
> > >         unsigned int relsym_secindex;
> > >
> > > -       if (relsym->st_name !=3D 0)
> > > +       if (is_valid_name(elf, relsym))
> > >                 return relsym;
> > >
> > >         /*
> > > @@ -1312,11 +1312,19 @@ static int addend_arm_rel(struct elf_info *el=
f, Elf_Shdr *sechdr, Elf_Rela *r)
> > >         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> > >         Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
> > >         unsigned int inst =3D TO_NATIVE(*reloc_location(elf, sechdr, =
r));
> > > +       int offset;
> > >
> > >         switch (r_typ) {
> > >         case R_ARM_ABS32:
> > >                 r->r_addend =3D inst + sym->st_value;
> > >                 break;
> > > +       case R_ARM_MOVW_ABS_NC:
> > > +       case R_ARM_MOVT_ABS:
> > > +               offset =3D ((inst & 0xf0000) >> 4) | (inst & 0xfff);
> > > +               offset =3D (offset ^ 0x8000) - 0x8000;
> >
> > The code in arch/arm/kernel/module.c then right shifts the offset by
> > 16 for R_ARM_MOVT_ABS. Is that necessary?
> >
>
> MOVW/MOVT pairs are limited to an addend of -/+ 32 KiB, and the same
> value must be encoded in both instructions.


In my understanding, 'movt' loads the immediate value to
the upper 16-bit of the register.

I am just curious about the code in arch/arm/kernel/module.c.

Please see 'case R_ARM_MOVT_ABS:' part.

  [1] 'offset' is the immediate value encoded in instruction
  [2] Add sym->st_value
  [3] Right-shift 'offset' by 16
  [4] Write it back to the instruction

So, the immediate value encoded in the instruction
is divided by 65536.

I guess we need something like the following?
(left-shift by 16).

  if (ELF32_R_TYPE(rel->r_info) =3D=3D R_ARM_MOVT_ABS ||
      ELF32_R_TYPE(rel->r_info) =3D=3D R_ARM_MOVT_PREL)
          offset <<=3D 16;




>
> When constructing the actual immediate value from the symbol value and
> the addend, only the top 16 bits are used in MOVT and the bottom 16
> bits in MOVW.
>
> However, this code seems to borrow the Elf_Rela::addend field (which
> ARM does not use natively) to record the intermediate value, which
> would need to be split if it is used to fix up instruction opcodes.

At first, modpost supported only RELA for section mismatch checks.

Later, 2c1a51f39d95 ("[PATCH] kbuild: check SHT_REL sections")
added REL support.

But, the common code still used Elf_Rela.


modpost does not need to write back the fixed instruction.
modpost is only interested in the offset address.

Currently, modpost saves the offset address in
r->r_offset even for Rel. I do not like this code.

So, I am trying to reduce the use of Elf_Rela.
For example, this patch.
https://patchwork.kernel.org/project/linux-kbuild/patch/20230521160426.1881=
124-8-masahiroy@kernel.org/


> Btw the Thumb2 encodings of MOVT and MOVW seem to be missing here.

Right, if CONFIG_THUMB2_KERNEL=3Dy, section mismatch check.

Several relocation types are just skipped.






>
>
> > > +               offset +=3D sym->st_value;
> > > +               r->r_addend =3D offset;
> > > +               break;
> > >         case R_ARM_PC24:
> > >         case R_ARM_CALL:
> > >         case R_ARM_JUMP24:
> > > --
> > > 2.39.2
> > >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers
--
Best Regards
Masahiro Yamada
