Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0C7C70ADC6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 13:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231674AbjEULrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 07:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231898AbjEULqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 07:46:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BAE18F;
        Sun, 21 May 2023 04:17:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E2C716147A;
        Sun, 21 May 2023 11:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47639C4339B;
        Sun, 21 May 2023 11:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684667820;
        bh=oXwvhxYmXD40/yjCvSkTkZwbE0tn28YyZYrBXJtZc+0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bP5iPUJUmzbQpyH29R8A2+C7USZY/pXLu2hEf8jck6hUGECaTptPUwg+4JvzY/UXk
         EiNJ6BrPzJV/S6PNiFG2YDei3T+5U6zT0RLK1RIrN59quiZxFCmrz9YW87Hckp/7ta
         MF6vckvtDFcHCA4clSIRbihkNvL0vKvmFUtkW+GduHEioiNxObaPWB7Ax/WdHPBebD
         GI8MaD7RQBBFFl4pmyNucYyNmRAVpFtJkVAsLVzQwbuwc2X0VWWKek4Yfnmbr23CE5
         Y138AQY47kAtAteK0D72LuX1/nK5tupoECGK6M0KlzxsZoLG6g8dw2sYVg8sWYHHid
         oIBToRCU8lvlw==
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5527456ede6so2390586eaf.3;
        Sun, 21 May 2023 04:17:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDxKYz02kzbcdAzcNIen8+KxpTPrfep9DMX5O0WRPuGw9zQDZn1p
        WZivM0jhxlDzNX3dbBJfZuI8bJ2zX2fR/jbcei8=
X-Google-Smtp-Source: ACHHUZ6PGzg0eqaif3me5Nt1Fh731/EEV7EqAVTctdgV4bm+DhKI3Bsu0xT6KKyWaruU6wFpwMPs8uXL7sTmIIpzrMA=
X-Received: by 2002:aca:1e17:0:b0:38d:f298:6cfc with SMTP id
 m23-20020aca1e17000000b0038df2986cfcmr4495096oic.0.1684667819560; Sun, 21 May
 2023 04:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230515005419.1293357-1-masahiroy@kernel.org> <CAKwvOdkMYKhm1gaDGxqa=J136J1=+vSv=fEVYNJR430Px5Qy6A@mail.gmail.com>
In-Reply-To: <CAKwvOdkMYKhm1gaDGxqa=J136J1=+vSv=fEVYNJR430Px5Qy6A@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 21 May 2023 20:16:23 +0900
X-Gmail-Original-Message-ID: <CAK7LNARvKhuWWTcvDj-TWw3yFG-kk_qLyfY44nTeP9bYVHNj-Q@mail.gmail.com>
Message-ID: <CAK7LNARvKhuWWTcvDj-TWw3yFG-kk_qLyfY44nTeP9bYVHNj-Q@mail.gmail.com>
Subject: Re: [PATCH] modpost: fix section mismatch message for R_ARM_ABS32
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sam Ravnborg <sam@ravnborg.org>
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

On Thu, May 18, 2023 at 6:41=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 14, 2023 at 5:54=E2=80=AFPM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > The section mismatch check does not show proper warning messages for AR=
M.
> >
> > Here, very simple test code.
> >
> >     #include <linux/init.h>
> >
> >     static int __initdata foo;
> >
> >     void set_foo(int x)
> >     {
> >             foo =3D x;
> >     }
> >
> >     int get_foo(int x)
> >     {
> >             return foo;
> >     }
> >
> > If I compile it for ARM, modpost does not show the symbol name.
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: set_foo (=
section: .text) -> (unknown) (section: .init.data)
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (=
section: .text) -> (unknown) (section: .init.data)
> >
> > If I compile it for other architectures, modpost shows the correct symb=
ol name.
> >
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: set_foo (=
section: .text) -> foo (section: .init.data)
> >   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (=
section: .text) -> foo (section: .init.data)
> >
> > For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value.
> >
> > arch/arm/kernel/module.c handles R_ARM_ABS32 as follows:
> >
> >         case R_ARM_ABS32:
> >         case R_ARM_TARGET1:
> >                 *(u32 *)loc +=3D sym->st_value;
> >
> > I just mimicked it in modpost.
> >
> > Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on a=
rm")
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 7 ++++---
> >  1 file changed, 4 insertions(+), 3 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index d4531d09984d..c93780d93caf 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1460,12 +1460,13 @@ static int addend_386_rel(struct elf_info *elf,=
 Elf_Shdr *sechdr, Elf_Rela *r)
> >  static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_=
Rela *r)
> >  {
> >         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> > +       unsigned int *location =3D reloc_location(elf, sechdr, r);
>
> If `location` is only used in one case of the switch, consider
> computing `location` only in that case.


I really suspect the other case labels are also wrong.

For example, see R_ARM_PC24 in arch/arm/kernel/module.c

The offset is encoded in the instruction.
If you can compute the addend without reading the instruction,
I do not know how.

Anyway, I will fix another breakage.
It will need 'location' as well.









>
> > +       Elf_Sym *sym;
> >
> >         switch (r_typ) {
> >         case R_ARM_ABS32:
> > -               /* From ARM ABI: (S + A) | T */
> > -               r->r_addend =3D (int)(long)
> > -                             (elf->symtab_start + ELF_R_SYM(r->r_info)=
);
> > +               sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
> > +               r->r_addend =3D TO_NATIVE(*location) + sym->st_value;
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



--=20
Best Regards
Masahiro Yamada
