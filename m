Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EE16DB514
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 22:17:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbjDGURS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 16:17:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjDGURP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 16:17:15 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B74C66C
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 13:16:59 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id o2so40846045plg.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 13:16:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680898619; x=1683490619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GENUw9PqHBdUQEL7FlbS+wdO3dyU6tn18qubnwix7jU=;
        b=EaZapur5N7xnNq/YZo/eVlN61WzPv9HAnkbWBMyfaGhZ/0gJWIlsiyBVHWxzhdaw1t
         R72R8SmNCfn7gOE3iA3IHUCRcbAhGdJeVPIls4cJLB0T7xnifBLTjxGwcaOsvhJNJjI+
         l7hNO+bW2f7jkalZpw4AgJ3knwDIHaHVEouKYGvexkGYcX+HfBZ4SCS4piD0U6/Vq4WK
         Mrr/ENhyEAyAZ3NGN1F+7exOIEN/OdgXkkifBZ+3wTF9MEgxikWSqb18Why1CqmTTPtH
         eMA2SSTXI6uONKq0K2JOwTHAUu8YZZgEKzwE/KtMm2vjPpmSEy4nuAC8cchlsU9vl8VE
         HaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680898619; x=1683490619;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GENUw9PqHBdUQEL7FlbS+wdO3dyU6tn18qubnwix7jU=;
        b=TKOWpI3eYlH3vVMy9la33WM3EckjJ67zQtqCrLpNLul/wBSb5JpK2g16y9QvepSlvD
         Shq1UrMsEUUaX+75QcQ1V1TjQjONTGI2CFSWKUuAclMhv/Fq4z+sDqdfxOoTJLlcXbi4
         UOzpl7MTn9f0U+wZfPArjvfBoeFohE2D9gG8hofA54T/YiDcPXL1dW8zSmHwsyEY01S6
         3hWXHFiGbe3UgSNLC82Kic/MqtsxDqIeNj8DDkKRQmuhjNkSllD8plF6I9OOcbdrxFnY
         RXX4XoMEwfTqH+JoahltIzcV7FFcXzsEgZZuW8AMnm3ydDAAmyAd+3sAS3doZm3uZDhE
         dkiw==
X-Gm-Message-State: AAQBX9eWio6r3MucR7F3OJRjTjWATRBx1hsxKUX3Eipea3WS03T/mF8/
        4twrC6n5+mB8cZT2W6PyvIk8BWqapuwtJMUqQYwQ3Q==
X-Google-Smtp-Source: AKy350ZCS9oS/E6rHTOEUBGi//7qEXg87vIrCUZNJ2ntFTukuiOYoRT5fpPKSGoUDyQro9/0w5iXN2I+1adj/vXTVZs=
X-Received: by 2002:a17:902:7c10:b0:1a2:8871:b42a with SMTP id
 x16-20020a1709027c1000b001a28871b42amr1293738pll.2.1680898618741; Fri, 07 Apr
 2023 13:16:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230308115243.82592-1-masahiroy@kernel.org> <20230308115243.82592-5-masahiroy@kernel.org>
In-Reply-To: <20230308115243.82592-5-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 7 Apr 2023 13:16:47 -0700
Message-ID: <CAKwvOdnu8Z2wTDG+R515t+ZkaVC=b7dV8g0agwvhw3BiBBePNg@mail.gmail.com>
Subject: Re: [PATCH 5/8] scripts/kallsyms: move compiler-generated symbol
 patterns to mksysmap
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 8, 2023 at 3:53=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.or=
g> wrote:
>
> scripts/kallsyms.c maintains compiler-generated symbols, but we end up
> with something similar in scripts/mksysmap to avoid the "Inconsistent
> kallsyms data" error. For example, commit c17a2538704f ("mksysmap: Fix
> the mismatch of 'L0' symbols in System.map").
>
> They were separately maintained prior to commit 94ff2f63d6a3 ("kbuild:
> reuse mksysmap output for kallsyms").
>
> Now that scripts/kallsyms.c parses the output of scripts/mksysmap,
> it makes more sense to collect all the ignored patterns to mksysmap.

Cool, thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/kallsyms.c | 59 ----------------------------------------------
>  scripts/mksysmap   | 43 +++++++++++++++++++++++++++++++++
>  2 files changed, 43 insertions(+), 59 deletions(-)
>
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index e572fda6fe42..97d514c0fc8f 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -102,65 +102,6 @@ static char *sym_name(const struct sym_entry *s)
>
>  static bool is_ignored_symbol(const char *name, char type)
>  {
> -       /* Symbol names that exactly match to the following are ignored.*=
/
> -       static const char * const ignored_symbols[] =3D {
> -               "_SDA_BASE_",           /* ppc */
> -               "_SDA2_BASE_",          /* ppc */
> -               NULL
> -       };
> -
> -       /* Symbol names that begin with the following are ignored.*/
> -       static const char * const ignored_prefixes[] =3D {
> -               "__efistub_",           /* arm64 EFI stub namespace */
> -               "__kvm_nvhe_$",         /* arm64 local symbols in non-VHE=
 KVM namespace */
> -               "__kvm_nvhe_.L",        /* arm64 local symbols in non-VHE=
 KVM namespace */
> -               "__AArch64ADRPThunk_",  /* arm64 lld */
> -               "__ARMV5PILongThunk_",  /* arm lld */
> -               "__ARMV7PILongThunk_",
> -               "__ThumbV7PILongThunk_",
> -               "__LA25Thunk_",         /* mips lld */
> -               "__microLA25Thunk_",
> -               "__kcfi_typeid_",       /* CFI type identifiers */
> -               NULL
> -       };
> -
> -       /* Symbol names that end with the following are ignored.*/
> -       static const char * const ignored_suffixes[] =3D {
> -               "_from_arm",            /* arm */
> -               "_from_thumb",          /* arm */
> -               "_veneer",              /* arm */
> -               NULL
> -       };
> -
> -       /* Symbol names that contain the following are ignored.*/
> -       static const char * const ignored_matches[] =3D {
> -               ".long_branch.",        /* ppc stub */
> -               ".plt_branch.",         /* ppc stub */
> -               NULL
> -       };
> -
> -       const char * const *p;
> -
> -       for (p =3D ignored_symbols; *p; p++)
> -               if (!strcmp(name, *p))
> -                       return true;
> -
> -       for (p =3D ignored_prefixes; *p; p++)
> -               if (!strncmp(name, *p, strlen(*p)))
> -                       return true;
> -
> -       for (p =3D ignored_suffixes; *p; p++) {
> -               int l =3D strlen(name) - strlen(*p);
> -
> -               if (l >=3D 0 && !strcmp(name + l, *p))
> -                       return true;
> -       }
> -
> -       for (p =3D ignored_matches; *p; p++) {
> -               if (strstr(name, *p))
> -                       return true;
> -       }
> -
>         if (type =3D=3D 'u' || type =3D=3D 'n')
>                 return true;
>
> diff --git a/scripts/mksysmap b/scripts/mksysmap
> index 1efd61ee0bac..d8ad6ff69320 100755
> --- a/scripts/mksysmap
> +++ b/scripts/mksysmap
> @@ -36,6 +36,28 @@ ${NM} -n ${1} | sed >${2} -e "
>  # local labels, .LBB, .Ltmpxxx, .L__unnamed_xx, .LASANPC, etc.
>  / \.L/d
>
> +# arm64 EFI stub namespace
> +/ __efistub_/d
> +
> +# arm64 local symbols in non-VHE KVM namespace
> +/ __kvm_nvhe_\$/d
> +/ __kvm_nvhe_\.L/d
> +
> +# arm64 lld
> +/ __AArch64ADRPThunk_/d
> +
> +# arm lld
> +/ __ARMV5PILongThunk_/d
> +/ __ARMV7PILongThunk_/d
> +/ __ThumbV7PILongThunk_/d
> +
> +# mips lld
> +/ __LA25Thunk_/d
> +/ __microLA25Thunk_/d
> +
> +# CFI type identifiers
> +/ __kcfi_typeid_/d
> +
>  # CRC from modversions
>  / __crc_/d
>
> @@ -45,6 +67,15 @@ ${NM} -n ${1} | sed >${2} -e "
>  # EXPORT_SYMBOL (namespace)
>  / __kstrtabns_/d
>
> +# ----------------------------------------------------------------------=
-----
> +# Ignored suffixes
> +#  (do not forget '$' after each pattern)
> +
> +# arm
> +/_from_arm$/d
> +/_from_thumb$/d
> +/_veneer$/d
> +
>  # ----------------------------------------------------------------------=
-----
>  # Ignored symbols (exact match)
>  #  (do not forget a space before and '$' after each pattern)
> @@ -52,6 +83,18 @@ ${NM} -n ${1} | sed >${2} -e "
>  # for LoongArch?
>  / L0$/d
>
> +# ppc
> +/ _SDA_BASE_$/d
> +/ _SDA2_BASE_$/d
> +
> +# ----------------------------------------------------------------------=
-----
> +# Ignored patterns
> +#  (symbols that contain the pattern are ignored)
> +
> +# ppc stub
> +/\.long_branch\./d
> +/\.plt_branch\./d
> +
>  # ----------------------------------------------------------------------=
-----
>  # Ignored kallsyms symbols
>  #
> --
> 2.34.1
>


--=20
Thanks,
~Nick Desaulniers
