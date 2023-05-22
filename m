Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489D570C535
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbjEVSbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232726AbjEVSbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:31:48 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50CB9D
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:31:46 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-6238da9c235so48639986d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684780306; x=1687372306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R2ePywhxddrmGkoVQNp8eKUSoyJ0B6HoMDE+8yYxha4=;
        b=MmWyskyzTT43BPxqcPEfyDJ+eoeCV4JL1ubuSmB5fq6M8J/mjqK6AA9lB8HNLNC8Qm
         CQ9FKYEutoJx25Py/XqgxjzCfEd9RsM1HDM2SVRfXnOEr+CXc02bIboTVeIeMnvvHy++
         tk51lcdvVniNufq6ifqYVGxuwqMb/8cM/EoAgiZ8pwhnCTFpF9gRTUrire98vP7cB4TM
         tEmysSr81JLoTSvJwBO++Az9+tUx09bg5G+X8bGlG68E64Zf97cqQ2efLtc03rjrF6TH
         RlyKk5wNZUrbDnBl4nAevN/hqDyzQ7SVBV6Vp95+7Yb1PTED1DbCG/a8l5VKBbOOISNe
         wFpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684780306; x=1687372306;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R2ePywhxddrmGkoVQNp8eKUSoyJ0B6HoMDE+8yYxha4=;
        b=J2Hwc69MO++ZHLR0nHXNhpR18SYa65dqt1B7QNSHDsO888X0969IDullLRt5qCCUgm
         rO88j94wJcgEuvqt3lqWWevgQRzG+yhLzK9It4AQOD90qesfM1ftxPpITvVTBJJwruwQ
         Nx9/Jdraimiqk3Kw/omToQbDFchc0UZobNPVDyhDu6hPxUh9+QfC/1rfdkYg6/urVMzA
         Z4nif9h8AMOolE40EObNiBH2/jU//+GzsOgM65bnzw8ktnjV5AABOsp+eqx51Bfvnmjj
         YEXey0z00hIg8q2uh1ykVproiPjHP7gCyFX3FRHJPzMR47ix2EzsiEnPyuXfBlnQEAjg
         m5Dg==
X-Gm-Message-State: AC+VfDw3LChygtLB+w64qpb/p9RRgHb1nx/TgMerJWBTTt+y1yTe6UXR
        TnFO3rcDrbkdGZ8TmFooHzjTEVihQv3Zn6N6KoX4d/l8Uhqh2WtnFZgK/Q==
X-Google-Smtp-Source: ACHHUZ7NmQDjwE7vLXaFibglhxBUgur25eZyr+zh4oJc7IxqXfsG83P36hQ0Fmove4N0Z0thmX5az082DLGfPgQwQyI=
X-Received: by 2002:a05:6214:c4e:b0:5ef:6eb6:e26e with SMTP id
 r14-20020a0562140c4e00b005ef6eb6e26emr19398983qvj.6.1684780305960; Mon, 22
 May 2023 11:31:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-8-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-8-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 11:31:35 -0700
Message-ID: <CAKwvOdkTW_uYqpEUODzL7Qyavo2LeOGVb6Mg3Lofdu12mjN1rA@mail.gmail.com>
Subject: Re: [PATCH v6 07/20] modpost: replace r->r_offset, r->r_addend with
 faddr, taddr
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> r_offset/r_addend holds the offset address from/to which a symbol is
> referenced. It is unclear unless you are familiar with ELF.
>
> Rename them to faddr, taddr, respectively. The prefix 'f' means 'from',
> 't' means 'to'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>


Do you care to rewrap the parameter lists?
```
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4da96746a03b..8a787521963d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1115,8 +1115,8 @@ static bool is_executable_section(struct
elf_info *elf, unsigned int secndx)

 static void default_mismatch_handler(const char *modname, struct elf_info =
*elf,
                                     const struct sectioncheck* const misma=
tch,
-                                    Elf_Sym *tsym,
-                                    unsigned int fsecndx, const char
*fromsec, Elf_Addr faddr,
+                                    Elf_Sym *tsym, unsigned int fsecndx,
+                                    const char *fromsec, Elf_Addr faddr,
                                     const char *tosec, Elf_Addr taddr)
 {
        Elf_Sym *from;
@@ -1217,9 +1217,9 @@ static void check_export_symbol(struct module
*mod, struct elf_info *elf,
 }

 static void check_section_mismatch(struct module *mod, struct elf_info *el=
f,
-                                  Elf_Sym *sym,
-                                  unsigned int fsecndx, const char *fromse=
c,
-                                  Elf_Addr faddr, Elf_Addr taddr)
+                                  Elf_Sym *sym, unsigned int fsecndx,
+                                  const char *fromsec, Elf_Addr faddr,
+                                  Elf_Addr taddr)
 {
        const char *tosec =3D sec_name(elf, get_secindex(elf, sym));
        const struct sectioncheck *mismatch;
```
Either way:
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>


> ---
>
>  scripts/mod/modpost.c | 34 +++++++++++++++++++---------------
>  1 file changed, 19 insertions(+), 15 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 7848bacd4b42..f364738a236e 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1166,18 +1166,18 @@ static bool is_executable_section(struct elf_info=
 *elf, unsigned int secndx)
>
>  static void default_mismatch_handler(const char *modname, struct elf_inf=
o *elf,
>                                      const struct sectioncheck* const mis=
match,
> -                                    Elf_Rela *r, Elf_Sym *tsym,
> -                                    unsigned int fsecndx, const char *fr=
omsec,
> -                                    const char *tosec)
> +                                    Elf_Sym *tsym,
> +                                    unsigned int fsecndx, const char *fr=
omsec, Elf_Addr faddr,
> +                                    const char *tosec, Elf_Addr taddr)
>  {
>         Elf_Sym *from;
>         const char *tosym;
>         const char *fromsym;
>
> -       from =3D find_fromsym(elf, r->r_offset, fsecndx);
> +       from =3D find_fromsym(elf, faddr, fsecndx);
>         fromsym =3D sym_name(elf, from);
>
> -       tsym =3D find_tosym(elf, r->r_addend, tsym);
> +       tsym =3D find_tosym(elf, taddr, tsym);
>         tosym =3D sym_name(elf, tsym);
>
>         /* check whitelist - we may ignore it */
> @@ -1204,7 +1204,7 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>                 break;
>         case EXTABLE_TO_NON_TEXT:
>                 warn("%s(%s+0x%lx): Section mismatch in reference to the =
%s:%s\n",
> -                    modname, fromsec, (long)r->r_offset, tosec, tosym);
> +                    modname, fromsec, (long)faddr, tosec, tosym);
>
>                 if (match(tosec, mismatch->bad_tosec))
>                         fatal("The relocation at %s+0x%lx references\n"
> @@ -1212,7 +1212,7 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>                               "Something is seriously wrong and should be=
 fixed.\n"
>                               "You might get more information about where=
 this is\n"
>                               "coming from by using scripts/check_extable=
.sh %s\n",
> -                             fromsec, (long)r->r_offset, tosec, modname)=
;
> +                             fromsec, (long)faddr, tosec, modname);
>                 else if (is_executable_section(elf, get_secindex(elf, tsy=
m)))
>                         warn("The relocation at %s+0x%lx references\n"
>                              "section \"%s\" which is not in the list of\=
n"
> @@ -1221,17 +1221,18 @@ static void default_mismatch_handler(const char *=
modname, struct elf_info *elf,
>                              "list of authorized sections to jump to on f=
ault.\n"
>                              "This can be achieved by adding \"%s\" to\n"
>                              "OTHER_TEXT_SECTIONS in scripts/mod/modpost.=
c.\n",
> -                            fromsec, (long)r->r_offset, tosec, tosec, to=
sec);
> +                            fromsec, (long)faddr, tosec, tosec, tosec);
>                 else
>                         error("%s+0x%lx references non-executable section=
 '%s'\n",
> -                             fromsec, (long)r->r_offset, tosec);
> +                             fromsec, (long)faddr, tosec);
>                 break;
>         }
>  }
>
>  static void check_section_mismatch(const char *modname, struct elf_info =
*elf,
> -                                  Elf_Rela *r, Elf_Sym *sym,
> -                                  unsigned int fsecndx, const char *from=
sec)
> +                                  Elf_Sym *sym,
> +                                  unsigned int fsecndx, const char *from=
sec,
> +                                  Elf_Addr faddr, Elf_Addr taddr)
>  {
>         const char *tosec =3D sec_name(elf, get_secindex(elf, sym));
>         const struct sectioncheck *mismatch =3D section_mismatch(fromsec,=
 tosec);
> @@ -1239,8 +1240,9 @@ static void check_section_mismatch(const char *modn=
ame, struct elf_info *elf,
>         if (!mismatch)
>                 return;
>
> -       default_mismatch_handler(modname, elf, mismatch, r, sym, fsecndx,=
 fromsec,
> -                                tosec);
> +       default_mismatch_handler(modname, elf, mismatch, sym,
> +                                fsecndx, fromsec, faddr,
> +                                tosec, taddr);
>  }
>
>  static unsigned int *reloc_location(struct elf_info *elf,
> @@ -1406,7 +1408,8 @@ static void section_rela(const char *modname, struc=
t elf_info *elf,
>                 /* Skip special sections */
>                 if (is_shndx_special(sym->st_shndx))
>                         continue;
> -               check_section_mismatch(modname, elf, &r, sym, fsecndx, fr=
omsec);
> +               check_section_mismatch(modname, elf, sym,
> +                                      fsecndx, fromsec, r.r_offset, r.r_=
addend);
>         }
>  }
>
> @@ -1464,7 +1467,8 @@ static void section_rel(const char *modname, struct=
 elf_info *elf,
>                 /* Skip special sections */
>                 if (is_shndx_special(sym->st_shndx))
>                         continue;
> -               check_section_mismatch(modname, elf, &r, sym, fsecndx, fr=
omsec);
> +               check_section_mismatch(modname, elf, sym,
> +                                      fsecndx, fromsec, r.r_offset, r.r_=
addend);
>         }
>  }
>
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
