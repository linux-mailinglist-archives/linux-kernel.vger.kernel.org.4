Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15C747111EC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 19:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbjEYRU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 13:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236311AbjEYRUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 13:20:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAC1A4
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:20:48 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-75b08639930so58725485a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 10:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685035247; x=1687627247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=idVvh3Hi/Oxhf6eEX+oF6Y39sENzliovz45uq92Jgac=;
        b=dXoLpKXqaoar+9J5WZ565irtkP9mp/Z9ejfauR9coLH2R8X9wD90CHTWYApPU+rDUz
         KUwcmYAWzSlHMJeSlCR5GOtS+2V6LGwpwHdn067k72imWd3U1CwMREAbP6cWyNTV6TyA
         /TDD4M0CAbLsVMvcZTjq35F1QoJS638ojjuiHzKSlhy6LJw8rVnpA4nRBbiRyrfB6gGO
         lDy6bbUftSNHWTitNtQWpaal380n+vrX8lNcTfiYCu4jpne0FhNRfyMpuquQ+re0eYmg
         Z5dYOCeYHB4Vt3zA71kGptKnRd13QaI5hIDK0uhfq03NRvgk+AmOI5wQqbmfXOEPEXTl
         U6EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685035247; x=1687627247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=idVvh3Hi/Oxhf6eEX+oF6Y39sENzliovz45uq92Jgac=;
        b=TIrqLL2ZwweVHNXMi4Q7NEzjBKYWDkSw5hm2RE8rl1tx09TkJFgWepjOmIAv3UTtFO
         dGzWJUCLPBKSL7O2Q3veLA400/FGiMfBQU/iEW/d6qAn7/r1KP3MvuoPdHuDXAyzwDeG
         PMPQg7GpQjFqCAYJLI/yLW8MawcjhS4R785I12za7O1kjsSfgUmsePh7eVJ/70TPo0K/
         tIb32x+6aYYynJnoAL2LQtTVkgwOitmA/cwEwO/gPPWTDZrU4z/vXIyRWbC4Y/UTt+85
         40d2JgysxAx463Uxd91m6a/e8h3prxppnrgn4GZi294g/yfikyretmuyThBJ8/9YEbTb
         l0tg==
X-Gm-Message-State: AC+VfDxRkvDJx80UYJ/+RLPnlxIkcB91a4t3EIHU6pgK+UIc2lW6Dq5q
        cjh5+/N/tTJao71ZccX/RITyOBRhp/xkR8Bw5iJbQKqeMGu+MBnofOwdVw==
X-Google-Smtp-Source: ACHHUZ6YN2OHVzq5lblbEVFVyuZYsf5PZl90I1LnhIBj0jt0olmiCSdaWhPh+5nnkil1lWiIUdAbGsFocTvFIUehI4g=
X-Received: by 2002:a05:620a:439c:b0:75b:23a1:d858 with SMTP id
 a28-20020a05620a439c00b0075b23a1d858mr3626403qkp.26.1685035247090; Thu, 25
 May 2023 10:20:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-9-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-9-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 May 2023 10:20:36 -0700
Message-ID: <CAKwvOdmDRNXQd0oDCjV1XdCk4coEd4_=V_idpObc9ibuVwOWgw@mail.gmail.com>
Subject: Re: [PATCH v6 08/20] modpost: remove is_shndx_special() check from section_rel(a)
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
> This check is unneeded. Without it, sec_name() will returns the null
> string "", then section_mismatch() will return immediately.
>
> Anyway, special section indices rarely appear in these loops.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v6:
>   - Remove is_shndx_special() definition
>
>  scripts/mod/modpost.c | 16 ++++------------
>  scripts/mod/modpost.h |  5 -----
>  2 files changed, 4 insertions(+), 17 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index f364738a236e..40fac4f64fcd 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1361,7 +1361,6 @@ static int addend_mips_rel(struct elf_info *elf, El=
f_Shdr *sechdr, Elf_Rela *r)
>  static void section_rela(const char *modname, struct elf_info *elf,
>                          Elf_Shdr *sechdr)
>  {
> -       Elf_Sym  *sym;
>         Elf_Rela *rela;
>         Elf_Rela r;
>         unsigned int r_sym;
> @@ -1404,11 +1403,8 @@ static void section_rela(const char *modname, stru=
ct elf_info *elf,
>                                 continue;
>                         break;
>                 }
> -               sym =3D elf->symtab_start + r_sym;
> -               /* Skip special sections */
> -               if (is_shndx_special(sym->st_shndx))
> -                       continue;
> -               check_section_mismatch(modname, elf, sym,
> +
> +               check_section_mismatch(modname, elf, elf->symtab_start + =
r_sym,
>                                        fsecndx, fromsec, r.r_offset, r.r_=
addend);
>         }
>  }
> @@ -1416,7 +1412,6 @@ static void section_rela(const char *modname, struc=
t elf_info *elf,
>  static void section_rel(const char *modname, struct elf_info *elf,
>                         Elf_Shdr *sechdr)
>  {
> -       Elf_Sym *sym;
>         Elf_Rel *rel;
>         Elf_Rela r;
>         unsigned int r_sym;
> @@ -1463,11 +1458,8 @@ static void section_rel(const char *modname, struc=
t elf_info *elf,
>                 default:
>                         fatal("Please add code to calculate addend for th=
is architecture\n");
>                 }
> -               sym =3D elf->symtab_start + r_sym;
> -               /* Skip special sections */
> -               if (is_shndx_special(sym->st_shndx))
> -                       continue;
> -               check_section_mismatch(modname, elf, sym,
> +
> +               check_section_mismatch(modname, elf, elf->symtab_start + =
r_sym,
>                                        fsecndx, fromsec, r.r_offset, r.r_=
addend);
>         }
>  }
> diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
> index 1178f40a73f3..b1e2d95f8047 100644
> --- a/scripts/mod/modpost.h
> +++ b/scripts/mod/modpost.h
> @@ -151,11 +151,6 @@ struct elf_info {
>         Elf32_Word   *symtab_shndx_stop;
>  };
>
> -static inline int is_shndx_special(unsigned int i)
> -{
> -       return i !=3D SHN_XINDEX && i >=3D SHN_LORESERVE && i <=3D SHN_HI=
RESERVE;
> -}
> -
>  /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
>  static inline unsigned int get_secindex(const struct elf_info *info,
>                                         const Elf_Sym *sym)
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
