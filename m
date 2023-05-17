Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F57707437
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjEQV1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEQV1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:27:34 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C686421E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:27:13 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id 6a1803df08f44-62385a3106dso5974806d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684358833; x=1686950833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lirS5BgNCncTUTh8FAM6PKxjij7fXFg47f/fXiGEh7o=;
        b=c6DgAVlUuJ+r/1qZcduFGWMWEFL5kGetd7CyObirpFZziXiLYtWCZGy6rHlB5+rbjI
         gxjyXKMB96uVbZgVrn0K97i8FCv8uD13XqzbYC+t/ynDqfokJdHD56UxovXFGXjHGMNH
         hUHjDIGlJQJlWobLCeMXiDpSj/rkMu+3OdqxuC/Ee2ovJhqujEro7m9JUkigMT1vS8tu
         KpbMW9+n0XFQTYsJFsm30uAbWduYJiOPtVJW3uC1Vw3FgL6YEXnPXHQyaffRkKt3n0lm
         3CF1Pi0JySZ/OqZ6G1s7UGL3T3nyUS2idL5/SFwoy0UJcareCyraZa2Na83TCY24zTEh
         Pqzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358833; x=1686950833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lirS5BgNCncTUTh8FAM6PKxjij7fXFg47f/fXiGEh7o=;
        b=RPkJeI1/hQj2c7EoIHXnaYaK56SCRuocxekyacQ4QeVIbOpIxVEGzMo3e6plF/LOUz
         4YHaO6cTVr/m++qwSGQXxggaCcNFP0GA2Nd/qZhoMhRq8gIPm/pymRFiBtsgZVOnYgHp
         zFKT9Ov6Zi2NGB0aTElkWdDJrCTgk5Qn9OOjJUYTK2u6Pk2YojFYq4maRkUbMKMnSykU
         Gow0/jzAeGPvs+kIMp6cJ2agnILz4AY6aXkaX/7+dGCWQN6ZLmu9CB1T6RHOwSGqxc+2
         o7pnlenaB3/DgTGozLKj2hOWGS9ArF0hnluc/HLOCT0morrWf6e9oVL2ppTfcDPCZzat
         SNSQ==
X-Gm-Message-State: AC+VfDymd0YyZw3KIWhGS35qUs+t2PCvXVV4r7kT5hiv4S/A/ZAoUwZR
        7R2E/f637okY2gLaYyULUGPfBkUY/K7BiS7q+4Rm3g==
X-Google-Smtp-Source: ACHHUZ6FCeZr6o1q4w+D9utGOYJrDTWuP81JZbwW5K2G4D2a3zeB5Ri/oH8y6QwIf0SkW4NqCfsi05tBZyUufjI0ug4=
X-Received: by 2002:a05:6214:1bcb:b0:5ef:60a8:e795 with SMTP id
 m11-20020a0562141bcb00b005ef60a8e795mr2123896qvc.4.1684358833008; Wed, 17 May
 2023 14:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-5-masahiroy@kernel.org>
In-Reply-To: <20230514152739.962109-5-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 14:27:02 -0700
Message-ID: <CAKwvOd=ntBEuLMyw55U3=mZmJ8=JY_NhiBL0nO9RtU8t6m+=VQ@mail.gmail.com>
Subject: Re: [PATCH v5 04/21] modpost: squash report_extable_warnings() into extable_mismatch_handler()
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

On Sun, May 14, 2023 at 8:27=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Collect relevant code into one place to clarify all the cases are
> covered by 'if () ... else if ... else ...'.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 40 ++++++++++++++--------------------------
>  1 file changed, 14 insertions(+), 26 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 371891d67175..7a9a3ef8ca0d 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1275,40 +1275,19 @@ static int is_executable_section(struct elf_info*=
 elf, unsigned int section_inde
>         return ((elf->sechdrs[section_index].sh_flags & SHF_EXECINSTR) =
=3D=3D SHF_EXECINSTR);
>  }
>
> -static void report_extable_warnings(const char* modname, struct elf_info=
* elf,
> -                                   const struct sectioncheck* const mism=
atch,
> -                                   Elf_Rela* r, Elf_Sym* sym,
> -                                   const char* fromsec, const char* tose=
c)
> -{
> -       Elf_Sym* tosym =3D find_elf_symbol(elf, r->r_addend, sym);
> -       const char* tosym_name =3D sym_name(elf, tosym);
> -
> -       warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n"=
,
> -            modname, fromsec, (long)r->r_offset, tosec, tosym_name);
> -
> -       if (!match(tosec, mismatch->bad_tosec) &&
> -           is_executable_section(elf, get_secindex(elf, sym)))
> -               fprintf(stderr,
> -                       "The relocation at %s+0x%lx references\n"
> -                       "section \"%s\" which is not in the list of\n"
> -                       "authorized sections.  If you're adding a new sec=
tion\n"
> -                       "and/or if this reference is valid, add \"%s\" to=
 the\n"
> -                       "list of authorized sections to jump to on fault.=
\n"
> -                       "This can be achieved by adding \"%s\" to \n"
> -                       "OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.\n"=
,
> -                       fromsec, (long)r->r_offset, tosec, tosec, tosec);
> -}
> -
>  static void extable_mismatch_handler(const char* modname, struct elf_inf=
o *elf,
>                                      const struct sectioncheck* const mis=
match,
>                                      Elf_Rela* r, Elf_Sym* sym,
>                                      const char *fromsec)
>  {
>         const char* tosec =3D sec_name(elf, get_secindex(elf, sym));
> +       Elf_Sym *tosym =3D find_elf_symbol(elf, r->r_addend, sym);
> +       const char *tosym_name =3D sym_name(elf, tosym);
>
>         sec_mismatch_count++;
>
> -       report_extable_warnings(modname, elf, mismatch, r, sym, fromsec, =
tosec);
> +       warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n"=
,
> +            modname, fromsec, (long)r->r_offset, tosec, tosym_name);
>
>         if (match(tosec, mismatch->bad_tosec))
>                 fatal("The relocation at %s+0x%lx references\n"
> @@ -1317,7 +1296,16 @@ static void extable_mismatch_handler(const char* m=
odname, struct elf_info *elf,
>                       "You might get more information about where this is=
\n"
>                       "coming from by using scripts/check_extable.sh %s\n=
",
>                       fromsec, (long)r->r_offset, tosec, modname);
> -       else if (!is_executable_section(elf, get_secindex(elf, sym)))
> +       else if (is_executable_section(elf, get_secindex(elf, sym)))
> +               warn("The relocation at %s+0x%lx references\n"
> +                    "section \"%s\" which is not in the list of\n"
> +                    "authorized sections.  If you're adding a new sectio=
n\n"
> +                    "and/or if this reference is valid, add \"%s\" to th=
e\n"
> +                    "list of authorized sections to jump to on fault.\n"
> +                    "This can be achieved by adding \"%s\" to\n"
> +                    "OTHER_TEXT_SECTIONS in scripts/mod/modpost.c.\n",
> +                    fromsec, (long)r->r_offset, tosec, tosec, tosec);
> +       else
>                 error("%s+0x%lx references non-executable section '%s'\n"=
,
>                       fromsec, (long)r->r_offset, tosec);
>  }
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
