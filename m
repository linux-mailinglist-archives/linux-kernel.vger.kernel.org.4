Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7C1707429
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjEQVYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:24:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjEQVYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:24:46 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B45D1BFA
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:24:19 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75765c213fbso77347485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684358656; x=1686950656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ml8oPK36I7ToUAH8tt/Yfo6x69yihZNiInjsICOE6/I=;
        b=jY+n5z6SZljQjlnPxAsk+uUV80QNM5CEWMGUUJ1VPZkChJbTSdEmf80gn7aglmGGBb
         HxLkJ8iUD++chvnb0pApuiL+FMNWI+3iTjd8etAE8IK8QcSpLt944ogIAj9e6FBpYDGs
         QvXFIPTtX3TGQJasnhMOl1W7lYDIJTWtiJ+39W8CY4ekx1C8DaHQe0w/cssRzc61Qnaj
         W7A3ZYExyp4I877R+p71xj51rb0NyvQzatuuxEcAKUWItt+/jxRdJFfMCMTh7dsFOGEV
         OwyZY4/5SZ1MWF42ti0pXojeGxV2Z9Bn49rTYkfzzDiKXfZskR2y67YrYuEL4xACIGZ8
         gN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358656; x=1686950656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ml8oPK36I7ToUAH8tt/Yfo6x69yihZNiInjsICOE6/I=;
        b=kx4sKnRXyAcPGmdBVwQMnVObnKs8BLDgW5fgRszCi6HEv9ZVN/W+py/4rp+e1A36zP
         jJW2bYj8E7vqMqIdrBN9qbDF/g0/v/lcuVAverBCNbZQYxhGvQmnJZehPJOQPEeWVK91
         1VifWeXTZ7XZQ3ch7YmMYBQOQxz8Vv+haX2HYA/sZy+3w54w24UvoNUp66m+/s63/jxa
         rKnnX97x4YFx8TYzep2L+TtpxtwPLTmIUpKvv6yHxPtIRe5MdgNvUIxvTGA2ZpbIBh7+
         Lp01JFR8Vrhg+cKd0TPOxgFVL6BpBHT5nAE/rMShvorlacMo31NtcsoOg9WO+c+lPNw+
         KDHg==
X-Gm-Message-State: AC+VfDxAh3siaGKyg7flpqTEVEYA70Wz4GX5sJRXmUsk9kh8uRhXdgxO
        BRBZ0yBlgHzaBP35W0niX8aNIdGFUhV2KUZq659tvw==
X-Google-Smtp-Source: ACHHUZ4xbrBf1hiW2IU1NcTwCuNOM6I1Fog7WteVKVv8v1vplR2pyGXBc1uc7AvD7gkSiAE3A8aB4gL+5AJzczLEDeM=
X-Received: by 2002:ad4:5c86:0:b0:5e9:429b:559f with SMTP id
 o6-20020ad45c86000000b005e9429b559fmr2332945qvh.13.1684358656403; Wed, 17 May
 2023 14:24:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-15-masahiroy@kernel.org>
 <CAKwvOdkZgu7wmaxFMKKjY1WscWto=vU=KAEO-pVmJ8+zegWG4g@mail.gmail.com>
In-Reply-To: <CAKwvOdkZgu7wmaxFMKKjY1WscWto=vU=KAEO-pVmJ8+zegWG4g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 14:24:03 -0700
Message-ID: <CAKwvOdnBNCRp1AYOaBQKOGvUGsmC4WKfF9cARgBjVuQPgKpB7g@mail.gmail.com>
Subject: Re: [PATCH v5 14/21] modpost: remove is_shndx_special() check from section_rel(a)
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Pitre <npitre@baylibre.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 2:23=E2=80=AFPM Nick Desaulniers
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
> only one callsite after this? (I should check with the series applied;
> this patch fails to apply on mainline if that's relevant for potential
> merge conflicts).
>
> Does doing that additional work speed things up though?

Either way,
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

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
Thanks,
~Nick Desaulniers
