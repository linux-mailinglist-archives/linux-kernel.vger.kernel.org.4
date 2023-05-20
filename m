Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D90D70A861
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 15:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbjETNqa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 09:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETNq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 09:46:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A0F1DE;
        Sat, 20 May 2023 06:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2693D608D5;
        Sat, 20 May 2023 13:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC64C4339C;
        Sat, 20 May 2023 13:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684590385;
        bh=yIrQnawHJxJyexbo6ICsyoYjJo4r/4iP3AULd75+fu0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=maabUWJj3wwNV5MX26qtdjvxOdShqjT4k28TQ4J7tGe0zn/XmZK9Sa5gD2dnlVePf
         fxPbQTBWAsz5go9X4oZcBgw79cIbEaoN0DPCi5+Gjyni9vvQV09rqFj8vWaB9LeKrw
         +TxQ4hTylrqoP2bcv0bTGW3MylFtgHn19CrtR3wNQzuuO5vqJDQbirl+dpx6eBR05I
         oZk0HTIsAdDQLN3ggPXZcY1xU3s+fQb2nFluTCWhJhHamKfJNAjBkJgdHh2qumSGcp
         FmLDpIBJT2RD2U/7yH9nVgFIex4/ckZRJxa420t5BVX82WlEnj0WsjzMW7S+ccYIAl
         YP5Kp8LNbU48Q==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-38eda4ef362so2596563b6e.2;
        Sat, 20 May 2023 06:46:25 -0700 (PDT)
X-Gm-Message-State: AC+VfDw7wvyo3Rfh9CKU2qvesypoBtfB1dcbbMwp/A4x3tA2n+B9e9b4
        IQ0bQojJdaqmJLs5u3cdrDtZqKobRibLZRnOXxA=
X-Google-Smtp-Source: ACHHUZ4V7+GZIVtg8yKowpo9yasKR3QeANExbuoh5914rgZ5G0yPyKitI9qNJSr1olNJryUWH4OtmppGfjplb0vxqp0=
X-Received: by 2002:a05:6808:8e7:b0:396:2678:f15d with SMTP id
 d7-20020a05680808e700b003962678f15dmr2968716oic.5.1684590384790; Sat, 20 May
 2023 06:46:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-15-masahiroy@kernel.org>
 <CAKwvOdkZgu7wmaxFMKKjY1WscWto=vU=KAEO-pVmJ8+zegWG4g@mail.gmail.com>
In-Reply-To: <CAKwvOdkZgu7wmaxFMKKjY1WscWto=vU=KAEO-pVmJ8+zegWG4g@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 20 May 2023 22:45:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNARcSSA429nZENksFwVWu--gLhzymi06XLY7VpRimiHZaQ@mail.gmail.com>
Message-ID: <CAK7LNARcSSA429nZENksFwVWu--gLhzymi06XLY7VpRimiHZaQ@mail.gmail.com>
Subject: Re: [PATCH v5 14/21] modpost: remove is_shndx_special() check from section_rel(a)
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Thu, May 18, 2023 at 6:23=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Sun, May 14, 2023 at 8:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel=
.org> wrote:
> >
> > This check is unneeded. Without it, sec_name() will returns the null
> > string "", then section_mismatch() will return immediately.
> >
> > Anyway, special section indices do not appear quite often in these
> > loops.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Could almost eliminate is_shndx_special after this. I think there's
> only one callsite after this?

There will be no callsite of is_shndx_special().
I will remove the definition as well.



 (I should check with the series applied;
> this patch fails to apply on mainline if that's relevant for potential
> merge conflicts).
>
> Does doing that additional work speed things up though?


I do not know.

As I wrote in the comment, special indices rarely appear in
the relocation.
I do not believe "let's bail out earlier" does not buy us.



>
> > ---
> >
> >  scripts/mod/modpost.c | 16 ++++------------
> >  1 file changed, 4 insertions(+), 12 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 0ef9d6964b6a..28db215ecc71 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -1370,7 +1370,6 @@ static int addend_mips_rel(struct elf_info *elf, =
Elf_Shdr *sechdr, Elf_Rela *r)
> >  static void section_rela(const char *modname, struct elf_info *elf,
> >                          Elf_Shdr *sechdr)
> >  {
> > -       Elf_Sym  *sym;
> >         Elf_Rela *rela;
> >         Elf_Rela r;
> >         unsigned int r_sym;
> > @@ -1413,11 +1412,8 @@ static void section_rela(const char *modname, st=
ruct elf_info *elf,
> >                                 continue;
> >                         break;
> >                 }
> > -               sym =3D elf->symtab_start + r_sym;
> > -               /* Skip special sections */
> > -               if (is_shndx_special(sym->st_shndx))
> > -                       continue;
> > -               check_section_mismatch(modname, elf, sym,
> > +
> > +               check_section_mismatch(modname, elf, elf->symtab_start =
+ r_sym,
> >                                        fsecndx, fromsec, r.r_offset, r.=
r_addend);
> >         }
> >  }
> > @@ -1425,7 +1421,6 @@ static void section_rela(const char *modname, str=
uct elf_info *elf,
> >  static void section_rel(const char *modname, struct elf_info *elf,
> >                         Elf_Shdr *sechdr)
> >  {
> > -       Elf_Sym *sym;
> >         Elf_Rel *rel;
> >         Elf_Rela r;
> >         unsigned int r_sym;
> > @@ -1472,11 +1467,8 @@ static void section_rel(const char *modname, str=
uct elf_info *elf,
> >                 default:
> >                         fatal("Please add code to calculate addend for =
this architecture\n");
> >                 }
> > -               sym =3D elf->symtab_start + r_sym;
> > -               /* Skip special sections */
> > -               if (is_shndx_special(sym->st_shndx))
> > -                       continue;
> > -               check_section_mismatch(modname, elf, sym,
> > +
> > +               check_section_mismatch(modname, elf, elf->symtab_start =
+ r_sym,
> >                                        fsecndx, fromsec, r.r_offset, r.=
r_addend);
> >         }
> >  }
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
