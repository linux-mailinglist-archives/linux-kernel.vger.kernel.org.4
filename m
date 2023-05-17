Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE5470747E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjEQVoW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:44:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjEQVoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:44:21 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF49213E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:44:20 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6237c957c5aso5570086d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684359859; x=1686951859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8b4C5n3kcCGVMGsBpVw128NH7ZLRih5QfkGZ+UkidE=;
        b=gtz/aea2blmObU16pWPUGUm87VjtkE6q2GCQ7daraVeIAOdIu3ye4EZHn0q9cHAGf9
         9NK1Lrrew9oOS4MRWZFngY8KH3qiKzknN1K5nyAdNipCmr66mAZdFW6XK8/FlAvrw9Pm
         KSY5SFVna7q774W0GeIy9sfxpJiq+5CFlMeTZ92aiT2RUusCJwzaYM1d69DJs25MGmrD
         nG/IafIFVxp6jNrmLZqX13yzJkYIJDOKVQ/Yf4/SNrV61zaeW0cHaRCFm5Ag4l8XhP+e
         Gz86VhcPl4hEqhAgaNJQR/H5vcwynOn/n//OPiNBRAuf89+VTKLn41neXJzV3x8ZVj4w
         zv6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684359859; x=1686951859;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/8b4C5n3kcCGVMGsBpVw128NH7ZLRih5QfkGZ+UkidE=;
        b=TizhLQwVJLo7RV+N6jW7uyjT+8I9W/tuTzriSe95pyUZ+n2x2ZHf8HFj3EF7pN74Rl
         AZpHR5V5XDOBf4jAGqGGjh7aN9dWHI+jVFjQTzXoXRakZ5ScSuTGtWc2y5g9OaQrvIqy
         8yphM6UDAFzn+lnXipQR3H4Nm/HLOXJMc6SYbkzJw7uixYT72Pk7Y7leWVD+roaXJuH9
         aihPWPK20hZSJrkYWAY8s8Kjndb+sADHn4b0PrPK3Joh/uls3wUvk3udy+ArprbtnFQv
         vDOCZtDgg50gi5GapNbu8qzrBCZRVVXj76iKYg+QkG3qIIYJWuNvcH9/I9VA6uvsgb8e
         xtiA==
X-Gm-Message-State: AC+VfDzUsRokDG8dAYBzj9xj2TrVSGDrmRfk3UVth0HikZa9KN4ItpIi
        9/Coh7z0QR541Tfu1f70N0kEJQNFk9nUKJrng8LeLAazcof4WOd7MSA=
X-Google-Smtp-Source: ACHHUZ4QWxFvfbOBwFS37kSrATv6UgaZXhARIC3Kri39tbZ/xb0Qsr4rkRS4sw580nhtdNB8kuWhzi3sVMcLunRJcCg=
X-Received: by 2002:ad4:5948:0:b0:61b:5ca6:b7ef with SMTP id
 eo8-20020ad45948000000b0061b5ca6b7efmr1709943qvb.42.1684359859328; Wed, 17
 May 2023 14:44:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-4-masahiroy@kernel.org>
In-Reply-To: <20230514152739.962109-4-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 14:44:08 -0700
Message-ID: <CAKwvOdmM5PsCy=p=CmWR9faCWwGsrmqPHv5MH7sfRS5fKz+=rQ@mail.gmail.com>
Subject: Re: [PATCH v5 03/21] modpost: remove get_prettyname()
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 8:27=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> This is the last user of get_pretty_name() - it is just used to
> distinguish whether the symbol is a function or not. It is not
> valuable information.

I thought it's a nice touch. Not like it should slow things down
unless there are extable warnings to report. May we keep it?

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 27 ++-------------------------
>  1 file changed, 2 insertions(+), 25 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index bbe066f7adbc..371891d67175 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1207,23 +1207,6 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *=
elf, Elf_Addr addr,
>         return near;
>  }
>
> -static int is_function(Elf_Sym *sym)
> -{
> -       if (sym)
> -               return ELF_ST_TYPE(sym->st_info) =3D=3D STT_FUNC;
> -       else
> -               return -1;
> -}
> -
> -static inline void get_pretty_name(int is_func, const char** name, const=
 char** name_p)
> -{
> -       switch (is_func) {
> -       case 0: *name =3D "variable"; *name_p =3D ""; break;
> -       case 1: *name =3D "function"; *name_p =3D "()"; break;
> -       default: *name =3D "(unknown reference)"; *name_p =3D ""; break;
> -       }
> -}
> -
>  /*
>   * Print a warning about a section mismatch.
>   * Try to find symbols near it so user can find it.
> @@ -1299,15 +1282,9 @@ static void report_extable_warnings(const char* mo=
dname, struct elf_info* elf,
>  {
>         Elf_Sym* tosym =3D find_elf_symbol(elf, r->r_addend, sym);
>         const char* tosym_name =3D sym_name(elf, tosym);
> -       const char* to_pretty_name;
> -       const char* to_pretty_name_p;
>
> -       get_pretty_name(is_function(tosym),
> -                       &to_pretty_name, &to_pretty_name_p);
> -
> -       warn("%s(%s+0x%lx): Section mismatch in reference to the %s %s:%s=
%s\n",
> -            modname, fromsec, (long)r->r_offset,
> -            to_pretty_name, tosec, tosym_name, to_pretty_name_p);
> +       warn("%s(%s+0x%lx): Section mismatch in reference to the %s:%s\n"=
,
> +            modname, fromsec, (long)r->r_offset, tosec, tosym_name);
>
>         if (!match(tosec, mismatch->bad_tosec) &&
>             is_executable_section(elf, get_secindex(elf, sym)))
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
