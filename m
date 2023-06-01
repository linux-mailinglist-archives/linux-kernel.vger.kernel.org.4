Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF8371A000
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbjFAO3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233318AbjFAO33 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:29:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1564D1;
        Thu,  1 Jun 2023 07:29:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 628CF645CF;
        Thu,  1 Jun 2023 14:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56DAC433A1;
        Thu,  1 Jun 2023 14:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685629767;
        bh=dXPOGovjhXXNulmQVmOLqKWZVJpHZBGaZoBNkXJHjNs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=kwB67JDljFbZkEqLxS3CTSXPrQclIovsRV2WQgEIvDovey/G0F6aFb4nkADSd0QXr
         pLCvMX85eavx8Bfc8gALeT9yCSgR/D0okBH4dzvR5VcA3igFmdcHaII3VnRszANClG
         mvzOTa78oBgrSJwnqLpI0YbUK27h/joZM+2w4wNNiSqi4Tyv6mQe0LdeXCECM6mac/
         Aas7LL87+hMJvEMP+cZOcLBSy5Mgz7MBhhEfmeNS4vaZ9jNW2Knz9ULi5m9o8iiD0t
         2WYKlC7EVRAs9e47+Ku2FAu7HEDoiKvpD1O/pgURBUs9kl76aeapGq+PAQU3Nepnut
         E75KJtRX5nejA==
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3985f70cf1bso497458b6e.3;
        Thu, 01 Jun 2023 07:29:27 -0700 (PDT)
X-Gm-Message-State: AC+VfDza4P9ixmCavTz8SJqQYS9u4h7/6dUAJS+8cEqS3cS3JSiPvMhz
        +tMWJ2V+Botn8ATNLNw6DfKLxSMPy+I4bz+IR/Y=
X-Google-Smtp-Source: ACHHUZ7H8TcRfs0381/8uo4SSlTOH8IlU6miGe+4HNiGxCYx030CPyFk3wPCZ7jy+RJd7Wx3FlUSy9Yuid6wj8XTH9s=
X-Received: by 2002:aca:f254:0:b0:384:27f0:bd1c with SMTP id
 q81-20020acaf254000000b0038427f0bd1cmr5368030oih.51.1685629766892; Thu, 01
 Jun 2023 07:29:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230601121001.1071533-1-masahiroy@kernel.org>
 <20230601121001.1071533-6-masahiroy@kernel.org> <CAMj1kXHuasyDeAvs6ZX3wR155uiVOZUO0-VbVpTQq9+v=WE5Sw@mail.gmail.com>
In-Reply-To: <CAMj1kXHuasyDeAvs6ZX3wR155uiVOZUO0-VbVpTQq9+v=WE5Sw@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Thu, 1 Jun 2023 23:28:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQk4nHzEK_W=Q-8MADW2WpdKKk2eCQuF5SboT71J4DFiw@mail.gmail.com>
Message-ID: <CAK7LNAQk4nHzEK_W=Q-8MADW2WpdKKk2eCQuF5SboT71J4DFiw@mail.gmail.com>
Subject: Re: [PATCH 5/7] modpost: detect section mismatch for R_ARM_THM_{MOVW_ABS_NC,MOVT_ABS}
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 1, 2023 at 9:23=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wro=
te:
>
> On Thu, 1 Jun 2023 at 14:10, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
> >
> > When CONFIG_THUMB2_KERNEL is enabled, modpost fails to detect some
> > types of section mismatches.
> >
> >   [test code]
> >
> >     #include <linux/init.h>
> >
> >     int __initdata foo;
> >     int get_foo(void) { return foo; }
> >
> > It is apparently a bad reference, but modpost does not report anything.
> >
> > The test code above produces the following relocations.
> >
> >   Relocation section '.rel.text' at offset 0x1e8 contains 2 entries:
> >    Offset     Info    Type            Sym.Value  Sym. Name
> >   00000000  0000052f R_ARM_THM_MOVW_AB 00000000   .LANCHOR0
> >   00000004  00000530 R_ARM_THM_MOVT_AB 00000000   .LANCHOR0
> >
> > Currently, R_ARM_THM_MOVW_ABS_NC and R_ARM_THM_MOVT_ABS are just skippe=
d.
> >
> > Add code to handle them. I checked arch/arm/kernel/module.c to learn
> > how the offset is encoded in the instruction.
> >
> > One more thing to note for Thumb instructions - the st_value is an odd
> > value, so you need to mask the bit 0 to get the offset. Otherwise, you
> > will get an off-by-one error in the nearest symbol look-up.
> >
> > It is documented in "ELF for the ARM Architecture" [1]:
> >
> >   * If the symbol addresses a Thumb instruction, its value is the addre=
ss
> >     of the instruction with bit zero set (in a relocatable object, the
> >     section offset with bit zero set).
> >
> >   * For the purposes of relocation the value used shall be the address
> >     of the instruction (st_value & ~1).
> >
> > [1]: https://github.com/ARM-software/abi-aa/blob/main/aaelf32/aaelf32.r=
st
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 31 ++++++++++++++++++++++++++-----
> >  1 file changed, 26 insertions(+), 5 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 32d56efe3f3b..528aa9175e84 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1082,7 +1082,8 @@ static Elf_Sym *find_nearest_sym(struct elf_info =
*elf, Elf_Addr addr,
> >  {
> >         Elf_Sym *sym;
> >         Elf_Sym *near =3D NULL;
> > -       Elf_Addr distance;
> > +       Elf_Addr sym_addr, distance;
> > +       bool is_arm =3D (elf->hdr->e_machine =3D=3D EM_ARM);
> >
> >         for (sym =3D elf->symtab_start; sym < elf->symtab_stop; sym++) =
{
> >                 if (get_secindex(elf, sym) !=3D secndx)
> > @@ -1090,10 +1091,19 @@ static Elf_Sym *find_nearest_sym(struct elf_inf=
o *elf, Elf_Addr addr,
> >                 if (!is_valid_name(elf, sym))
> >                         continue;
> >
> > -               if (addr >=3D sym->st_value)
> > -                       distance =3D addr - sym->st_value;
> > +               sym_addr =3D sym->st_value;
> > +
> > +               /*
> > +                * For ARM Thumb instruction, the bit 0 of st_value is =
set.
> > +                * Mask it to get the address.
> > +                */
> > +               if (is_arm)
> > +                        sym_addr &=3D ~1;
> > +
>
> This is only appropriate for STT_FUNC symbols. If this is a data
> reference, bit 0 could be a valid address bit.


Thanks for catching it.

I will fix it as follows:

    /*
     * For ARM Thumb instruction, the bit 0 of st_value is set if
     * the symbol is STT_FUNC type. Mask it to get the address.
     */
    if (is_arm && ELF_ST_TYPE(sym->st_info) =3D=3D STT_FUNC)
            sym_addr &=3D ~1;




--=20
Best Regards
Masahiro Yamada
