Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7A971138F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 20:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241252AbjEYSSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 14:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241061AbjEYSSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 14:18:47 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A426B1BC
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:18:45 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-6238417112aso255556d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 11:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685038725; x=1687630725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2bghzY/gD0I0tJYxUqAr+ROA5ANmhi9sosFaTZpTtDk=;
        b=tlzTdrMSoWH+tBUoR5gUJNarlbdfLRwYhIE4I95T9dQzWGe7+2E6W6serpilShQ5Jl
         trz4nI5fWZl31eT6urED4iGqC75EszchBeq1eOSQAZhNAHm2j3T4poVbvK5XgGy5/MYa
         E5ZHsL/z4fuYb/AAX3AQQNYK11QrK1baxwD1U4Bm/pZIYtbCMCOHZgCq/b5PrLDzy88K
         npIqJI/bkm+LV/sgwpHnGIswHajs2n6tEt82yucdOYqr3ThFs9QQyamCBH9gfngWSRkf
         ghsrsCk+2r5FSwBX7OZ6zkMRp0djUOdEVltkUwdLA9JZGrsAKuQyfPMq7Gor4xQ+q+6M
         YhEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685038725; x=1687630725;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2bghzY/gD0I0tJYxUqAr+ROA5ANmhi9sosFaTZpTtDk=;
        b=gMhG4nfUbQT4t+QGeDXvxuDdNvxB28uNmu9mRPvDEYgyG9jr29R6rT60oPPq4zcihF
         QglgR/seWdn1cmM0rEVzU8Nn4+pjN3AW+zYlQ+Fn6Q0EYvjmwjPutdAqmgFHEUGPP+CU
         VnVWMx+Mgz++b6RWGUnGD2X0IkOzFUwkviKH4Jp/26/ZiTI1432Wq16RyazDqalROOqh
         A6JVK1D5s04ZoQZqg+gHf1fJmz2QaA/03v8dGfE8KmEzb8KTAoIvX2Ibz3T5LZ1VlUdQ
         fPqq/DsW0RBg1qOfr6jLhgeTKQcjRmTalxnMk9VCEYK6FeXHgopX7k44XQ3OjpZJANYz
         J2zw==
X-Gm-Message-State: AC+VfDwlTaLV0UlslMzoAF+3NLrF1D1kR2O+ubNMY65C+z+Ua0xToXcw
        UQQ6HuPTPInxpHf8gaqExhA8Y4LRRbWywfzuj2JWLQ==
X-Google-Smtp-Source: ACHHUZ4+PsQgVq7ilhtxop/0H/Wup78sLuFKI7UE7s+3kJg7IY4zWaioosxIowG2hMJ9jlcmqlNXzLyhxpaFPrENuXk=
X-Received: by 2002:a05:6214:2486:b0:623:5dc2:883b with SMTP id
 gi6-20020a056214248600b006235dc2883bmr2582445qvb.24.1685038724605; Thu, 25
 May 2023 11:18:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-13-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-13-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 25 May 2023 11:18:33 -0700
Message-ID: <CAKwvOdms2g_qDCavMyPT5fVmoygXxEoutTYaB=P0t=wLag8DpA@mail.gmail.com>
Subject: Re: [PATCH v6 12/20] modpost: check static EXPORT_SYMBOL* by modpost again
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>, owen@owenrafferty.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Commit 31cb50b5590f ("kbuild: check static EXPORT_SYMBOL* by script
> instead of modpost") moved the static EXPORT_SYMBOL* check from the
> mostpost to a shell script because I thought it must be checked per
> compilation unit to avoid false negatives.
>
> I came up with an idea to do this in modpost, against combined ELF
> files. The relocation entries in ELF will find the correct exported
> symbol even if there exist symbols with the same name in different
> compilation units.
>
> Again, the same sample code.
>
>   Makefile:
>
>     obj-y +=3D foo1.o foo2.o
>
>   foo1.c:
>
>     #include <linux/export.h>
>     static void foo(void) {}
>     EXPORT_SYMBOL(foo);
>
>   foo2.c:
>
>     void foo(void) {}
>
> Then, modpost can catch it correctly.
>
>     MODPOST Module.symvers
>   ERROR: modpost: vmlinux: local symbol 'foo' was exported
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
> Changes in v6:
>   - Make the symbol name in the warning more precise
>
>  scripts/Makefile.build     |  4 ---
>  scripts/check-local-export | 70 --------------------------------------
>  scripts/mod/modpost.c      |  7 ++++
>  3 files changed, 7 insertions(+), 74 deletions(-)
>  delete mode 100755 scripts/check-local-export
>
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 6bf026a304e4..bd4123795299 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -220,8 +220,6 @@ cmd_gen_ksymdeps =3D \
>         $(CONFIG_SHELL) $(srctree)/scripts/gen_ksymdeps.sh $@ >> $(dot-ta=
rget).cmd
>  endif
>
> -cmd_check_local_export =3D $(srctree)/scripts/check-local-export $@
> -
>  ifneq ($(findstring 1, $(KBUILD_EXTRA_WARN)),)
>  cmd_warn_shared_object =3D $(if $(word 2, $(modname-multi)),$(warning $(=
kbuild-file): $*.o is added to multiple modules: $(modname-multi)))
>  endif
> @@ -229,7 +227,6 @@ endif
>  define rule_cc_o_c
>         $(call cmd_and_fixdep,cc_o_c)
>         $(call cmd,gen_ksymdeps)
> -       $(call cmd,check_local_export)
>         $(call cmd,checksrc)
>         $(call cmd,checkdoc)
>         $(call cmd,gen_objtooldep)
> @@ -241,7 +238,6 @@ endef
>  define rule_as_o_S
>         $(call cmd_and_fixdep,as_o_S)
>         $(call cmd,gen_ksymdeps)
> -       $(call cmd,check_local_export)
>         $(call cmd,gen_objtooldep)
>         $(call cmd,gen_symversions_S)
>         $(call cmd,warn_shared_object)
> diff --git a/scripts/check-local-export b/scripts/check-local-export
> deleted file mode 100755
> index 969a313b9299..000000000000
> --- a/scripts/check-local-export
> +++ /dev/null
> @@ -1,70 +0,0 @@
> -#!/bin/sh
> -# SPDX-License-Identifier: GPL-2.0-only
> -#
> -# Copyright (C) 2022 Masahiro Yamada <masahiroy@kernel.org>
> -# Copyright (C) 2022 Owen Rafferty <owen@owenrafferty.com>
> -#
> -# Exit with error if a local exported symbol is found.
> -# EXPORT_SYMBOL should be used for global symbols.
> -
> -set -e
> -pid=3D$$
> -
> -# If there is no symbol in the object, ${NM} (both GNU nm and llvm-nm) s=
hows
> -# 'no symbols' diagnostic (but exits with 0). It is harmless and hidden =
by
> -# '2>/dev/null'. However, it suppresses real error messages as well. Add=
 a
> -# hand-crafted error message here.
> -#
> -# TODO:
> -# Use --quiet instead of 2>/dev/null when we upgrade the minimum version=
 of
> -# binutils to 2.37, llvm to 13.0.0.
> -# Then, the following line will be simpler:
> -#   { ${NM} --quiet ${1} || kill 0; } |
> -
> -{ ${NM} ${1} 2>/dev/null || { echo "${0}: ${NM} failed" >&2; kill $pid; =
} } |
> -${AWK} -v "file=3D${1}" '
> -BEGIN {
> -       i =3D 0
> -}
> -
> -# Skip the line if the number of fields is less than 3.
> -#
> -# case 1)
> -#   For undefined symbols, the first field (value) is empty.
> -#   The outout looks like this:
> -#     "                 U _printk"
> -#   It is unneeded to record undefined symbols.
> -#
> -# case 2)
> -#   For Clang LTO, llvm-nm outputs a line with type t but empty name:
> -#     "---------------- t"
> -!length($3) {
> -       next
> -}
> -
> -# save (name, type) in the associative array
> -{ symbol_types[$3]=3D$2 }
> -
> -# append the exported symbol to the array
> -($3 ~ /^__export_symbol_(gpl)?_.*/) {
> -       export_symbols[i] =3D $3
> -       sub(/^__export_symbol_(gpl)?_/, "", export_symbols[i])
> -       i++
> -}
> -
> -END {
> -       exit_code =3D 0
> -       for (j =3D 0; j < i; ++j) {
> -               name =3D export_symbols[j]
> -               # nm(3) says "If lowercase, the symbol is usually local"
> -               if (symbol_types[name] ~ /[a-z]/) {
> -                       printf "%s: error: local symbol %s was exported\n=
",
> -                               file, name | "cat 1>&2"
> -                       exit_code =3D 1
> -               }
> -       }
> -
> -       exit exit_code
> -}'
> -
> -exit $?
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 8b94090d0743..dd1d066f1214 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1235,6 +1235,13 @@ static void check_export_symbol(struct module *mod=
, struct elf_info *elf,
>                 return;
>         }
>
> +       if (ELF_ST_BIND(sym->st_info) !=3D STB_GLOBAL &&
> +           ELF_ST_BIND(sym->st_info) !=3D STB_WEAK) {
> +               error("%s: local symbol '%s' was exported\n", mod->name,
> +                     label_name + strlen(prefix));
> +               return;
> +       }
> +
>         if (strcmp(label_name + strlen(prefix), name)) {
>                 error("%s: .export_symbol section references '%s', but it=
 does not seem to be an export symbol\n",
>                       mod->name, name);
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
