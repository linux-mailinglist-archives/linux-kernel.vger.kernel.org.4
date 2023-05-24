Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB33970E9F3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 02:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238915AbjEXADe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 20:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbjEXADb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 20:03:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5EB83;
        Tue, 23 May 2023 17:03:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE6E462AD7;
        Wed, 24 May 2023 00:03:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2F8C433D2;
        Wed, 24 May 2023 00:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684886609;
        bh=CTgebIKJKAGtPHZmVGrZglejR1IhKcMyAClOVru44yU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=elN475I2iEUckg3souLG2WzLYYtvKV+4UHxrWak8MCxl0K/MUPLP5kNDH8EOV9Rdz
         KdLhtJfw1eav+rngkk0bP3fAMZs89htGE3jlzNa0GCH/MD09uWNCickD0HtKmkIRHF
         LyjVC6uZ+8WsLI/4RU6NeuI/njhwqPbGdn8g/pBqVb3qIe8fdRHOrRiglc3kaT9CIJ
         dgpXcILjlX7jaBOCj5WnU25sDuqDi+dWp+OvGy+7GNg1DJ4JccIyuQ77pU8M0ZVHDq
         c3TtllQFLNwqAT4OcoRFnpeBNl/TByLg37Loqv8XU8qkq+YubnBxktfMUdkz6GhgB/
         K0aGpjM3hdDOA==
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3980f932206so286351b6e.1;
        Tue, 23 May 2023 17:03:29 -0700 (PDT)
X-Gm-Message-State: AC+VfDyjuhD2gaHXrfIwVBppEJYjnqA7h1QfiY/OYvKB5b7AhFtD128v
        t+5KlZVQ914urAfNl4Wu1WNqQEUAl7Jcs5AlC5w=
X-Google-Smtp-Source: ACHHUZ4v/o9p3Ug2zWzJzKlre95zk287ufsJpq0sYomf0TLDU5ULK6aFdZ91taKqGo1ZuxItoeO2FAkmPo4nKQueIv0=
X-Received: by 2002:a54:4697:0:b0:398:fa2:4bb8 with SMTP id
 k23-20020a544697000000b003980fa24bb8mr3923070oic.43.1684886608523; Tue, 23
 May 2023 17:03:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org>
 <20230521160426.1881124-4-masahiroy@kernel.org> <CAKwvOdmxLrE8VksbsSGirfTqnuhEFT__FuCG53ri3V42UbH5aw@mail.gmail.com>
 <CAMj1kXGZLn37bchQ8NZy6zPgsMNT=CE7pZ0voTsnu=ytSf2i7g@mail.gmail.com>
 <CAK7LNASEj618kZn8ANnZwfFC54MuFx3UxgnqG=ByeubD7vUymA@mail.gmail.com> <CAMj1kXGDBkL4ZyPD-8LzEL=2uA6pSEwhtpG3nwc6esoLuMgRDQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGDBkL4ZyPD-8LzEL=2uA6pSEwhtpG3nwc6esoLuMgRDQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 24 May 2023 09:02:52 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQgWuoYbHjz4uFvnPVJ_kvsSp4tdyJ4AT+2vGYNaLmXMg@mail.gmail.com>
Message-ID: <CAK7LNAQgWuoYbHjz4uFvnPVJ_kvsSp4tdyJ4AT+2vGYNaLmXMg@mail.gmail.com>
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 23, 2023 at 9:21=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> On Tue, 23 May 2023 at 13:59, Masahiro Yamada <masahiroy@kernel.org> wrot=
e:
> >
> > On Tue, May 23, 2023 at 6:50=E2=80=AFAM Ard Biesheuvel <ardb@kernel.org=
> wrote:
> > >
> > > On Mon, 22 May 2023 at 20:03, Nick Desaulniers <ndesaulniers@google.c=
om> wrote:
> > > >
> > > > + linux-arm-kernel
> > > >
> > > > On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@=
kernel.org> wrote:
> > > > >
> > > > > ARM defconfig misses to detect some section mismatches.
> > > > >
> > > > >   [test code]
> > > > >
> > > > >     #include <linux/init.h>
> > > > >
> > > > >     int __initdata foo;
> > > > >     int get_foo(int x) { return foo; }
> > > > >
> > > > > It is apparently a bad reference, but modpost does not report any=
thing
> > > > > for ARM defconfig (i.e. multi_v7_defconfig).
> > > > >
> > > > > The test code above produces the following relocations.
> > > > >
> > > > >   Relocation section '.rel.text' at offset 0x200 contains 2 entri=
es:
> > > > >    Offset     Info    Type            Sym.Value  Sym. Name
> > > > >   00000000  0000062b R_ARM_MOVW_ABS_NC 00000000   .LANCHOR0
> > > > >   00000004  0000062c R_ARM_MOVT_ABS    00000000   .LANCHOR0
> > > > >
> > > > >   Relocation section '.rel.ARM.exidx' at offset 0x210 contains 2 =
entries:
> > > > >    Offset     Info    Type            Sym.Value  Sym. Name
> > > > >   00000000  0000022a R_ARM_PREL31      00000000   .text
> > > > >   00000000  00001000 R_ARM_NONE        00000000   __aeabi_unwind_=
cpp_pr0
> > > > >
> > > > > Currently, R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS are just skipped.
> > > > >
> > > > > Add code to handle them. I checked arch/arm/kernel/module.c to le=
arn
> > > > > how the offset is encoded in the instruction.
> > > > >
> > > > > The referenced symbol in relocation might be a local anchor.
> > > > > If is_valid_name() returns false, let's search for a better symbo=
l name.
> > > > >
> > > > > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > > > > ---
> > > > >
> > > > >  scripts/mod/modpost.c | 12 ++++++++++--
> > > > >  1 file changed, 10 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > > > > index 34fbbd85bfde..ed2301e951a9 100644
> > > > > --- a/scripts/mod/modpost.c
> > > > > +++ b/scripts/mod/modpost.c
> > > > > @@ -1108,7 +1108,7 @@ static inline int is_valid_name(struct elf_=
info *elf, Elf_Sym *sym)
> > > > >  /**
> > > > >   * Find symbol based on relocation record info.
> > > > >   * In some cases the symbol supplied is a valid symbol so
> > > > > - * return refsym. If st_name !=3D 0 we assume this is a valid sy=
mbol.
> > > > > + * return refsym. If is_valid_name() =3D=3D true, we assume this=
 is a valid symbol.
> > > > >   * In other cases the symbol needs to be looked up in the symbol=
 table
> > > > >   * based on section and address.
> > > > >   *  **/
> > > > > @@ -1121,7 +1121,7 @@ static Elf_Sym *find_tosym(struct elf_info =
*elf, Elf64_Sword addr,
> > > > >         Elf64_Sword d;
> > > > >         unsigned int relsym_secindex;
> > > > >
> > > > > -       if (relsym->st_name !=3D 0)
> > > > > +       if (is_valid_name(elf, relsym))
> > > > >                 return relsym;
> > > > >
> > > > >         /*
> > > > > @@ -1312,11 +1312,19 @@ static int addend_arm_rel(struct elf_info=
 *elf, Elf_Shdr *sechdr, Elf_Rela *r)
> > > > >         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> > > > >         Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info)=
;
> > > > >         unsigned int inst =3D TO_NATIVE(*reloc_location(elf, sech=
dr, r));
> > > > > +       int offset;
> > > > >
> > > > >         switch (r_typ) {
> > > > >         case R_ARM_ABS32:
> > > > >                 r->r_addend =3D inst + sym->st_value;
> > > > >                 break;
> > > > > +       case R_ARM_MOVW_ABS_NC:
> > > > > +       case R_ARM_MOVT_ABS:
> > > > > +               offset =3D ((inst & 0xf0000) >> 4) | (inst & 0xff=
f);
> > > > > +               offset =3D (offset ^ 0x8000) - 0x8000;
> > > >
> > > > The code in arch/arm/kernel/module.c then right shifts the offset b=
y
> > > > 16 for R_ARM_MOVT_ABS. Is that necessary?
> > > >
> > >
> > > MOVW/MOVT pairs are limited to an addend of -/+ 32 KiB, and the same
> > > value must be encoded in both instructions.
> >
> >
> > In my understanding, 'movt' loads the immediate value to
> > the upper 16-bit of the register.
> >
>
> Correct. It sets the upper 16 bits of a register without corrupting
> the lower 16 bits.
>
> > I am just curious about the code in arch/arm/kernel/module.c.
> >
> > Please see 'case R_ARM_MOVT_ABS:' part.
> >
> >   [1] 'offset' is the immediate value encoded in instruction
> >   [2] Add sym->st_value
> >   [3] Right-shift 'offset' by 16
> >   [4] Write it back to the instruction
> >
> > So, the immediate value encoded in the instruction
> > is divided by 65536.
> >
> > I guess we need something like the following?
> > (left-shift by 16).
> >
> >   if (ELF32_R_TYPE(rel->r_info) =3D=3D R_ARM_MOVT_ABS ||
> >       ELF32_R_TYPE(rel->r_info) =3D=3D R_ARM_MOVT_PREL)
> >           offset <<=3D 16;
> >
>
> No. The addend is not encoded in the same way as the effective immediate =
value.
>
> The addend is limited to -/+ 32 KiB (range of s16), and the MOVT
> instruction must use the same addend value as the MOVW instruction it
> is paired with, without shifting.
>
> This is necessary because otherwise, there is no way to handle an
> addend/symbol combination that results in a carry between the lower
> and upper 16 bit words. This is a consequence of the use of REL format
> rather than RELA, where the addend is part of the relocation and not
> encoded in the instructions.


Ah, OK.
Now I understand.




> >
> >
> >
> > >
> > > When constructing the actual immediate value from the symbol value an=
d
> > > the addend, only the top 16 bits are used in MOVT and the bottom 16
> > > bits in MOVW.
> > >
> > > However, this code seems to borrow the Elf_Rela::addend field (which
> > > ARM does not use natively) to record the intermediate value, which
> > > would need to be split if it is used to fix up instruction opcodes.
> >
> > At first, modpost supported only RELA for section mismatch checks.
> >
> > Later, 2c1a51f39d95 ("[PATCH] kbuild: check SHT_REL sections")
> > added REL support.
> >
> > But, the common code still used Elf_Rela.
> >
> >
> > modpost does not need to write back the fixed instruction.
> > modpost is only interested in the offset address.
> >
> > Currently, modpost saves the offset address in
> > r->r_offset even for Rel. I do not like this code.
> >
> > So, I am trying to reduce the use of Elf_Rela.
> > For example, this patch.
> > https://patchwork.kernel.org/project/linux-kbuild/patch/20230521160426.=
1881124-8-masahiroy@kernel.org/
> >
>
> Yeah, that looks better to me.
>
> >
> > > Btw the Thumb2 encodings of MOVT and MOVW seem to be missing here.
> >
> > Right, if CONFIG_THUMB2_KERNEL=3Dy, section mismatch check.
> >
> > Several relocation types are just skipped.
> >
>
> Skipped entirely? Or only for the diagnostic print that outputs the symbo=
l name?


Skipped entirely.

modpost cannot detect section mismatches
if you enable CONFIG_THUMB2_KERNEL.



--
Best Regards
Masahiro Yamada
