Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90E327073DA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbjEQVPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:15:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbjEQVPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:15:03 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC40C93E2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:56 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-623914a4bf0so524786d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684358090; x=1686950090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R/UDshlYMhETGULfkRrgD+JuGa+CGdea1mThx2z5Su4=;
        b=aiZXg/57wbN2dPigF7ZEAnt1bLEr0+EkXv5tno+1mzBI8/2zm0ZRKZ6fXMm+/3JDxf
         pURP/paJyY2BFBZ/FVzV2avaqijUdeaw+7UxKKJswmA1o5VvWbgooVrEhF2YxdcejuuX
         /6zwiYFwdkcxoLiPrGAmvyTdf9Mr6a8j6R9lCbjYXC0Cc6F/eE1uSpWd70k45ET71mdb
         V//PtAoisuohwR02bPMc1AkMw6rBChzu8l9FBYQcIdGdhUfX7uN9jeD6N62HjYpofFDW
         tSkseF4+B0gbO4lP3XSbBxCqGpYgMTCeURCTDbKa+QyvySyTWOdC2rp69j4eHeQlfFAm
         nFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684358090; x=1686950090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R/UDshlYMhETGULfkRrgD+JuGa+CGdea1mThx2z5Su4=;
        b=HzL1f9KqApSvmIzR9+yaBpw8jmnHhkBhrs0Fg6JwaLIo9r7bn8hs5FlcHMs5tDXd6I
         +p4CaoATjBQ6dAmZCuPSROhIPwGOhbiOiYvxVkddwMuHApikJyoWQ3yMP9YiogMXSGLr
         KrDwl9pGMSqsDKN0SM9CiZcnsJNmElE40u/THZA1Gz8EduJOYZlb6QP2KBLOpjHu9SNT
         eJTzLOUx5hY/KB080sO3/RKQH4uZtacLvHPuiBri1TgZDecBRzybCdFpQ8YNGjNqjZXM
         IF5AkgkG0aQJvLGaMyBSsJejcFew/TVQcKLjvW2TPc+hoJtgjvm+M2TwZ9HQizkLdIt0
         pKxg==
X-Gm-Message-State: AC+VfDxPpdQq1Dm2LekfepoFgNxtOtXzkTqeHnvUnftK6t1y7sDJuwxN
        FQELA1GuRnE9amZtJiH67wQowwoJWH3Eq8Sf0xsZfQ==
X-Google-Smtp-Source: ACHHUZ6SC7EHtBR33soA7BCb7guA5Vlem1U3ixeI40PoHt9yvur4P2vLV0m2njmTyr2W1PY32lNX/I8SXOMJOoixEcU=
X-Received: by 2002:a05:6214:2a86:b0:623:9218:58e1 with SMTP id
 jr6-20020a0562142a8600b00623921858e1mr66310qvb.31.1684358089847; Wed, 17 May
 2023 14:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-11-masahiroy@kernel.org>
In-Reply-To: <20230514152739.962109-11-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 14:14:39 -0700
Message-ID: <CAKwvOdmA1q1ojTWq79VK4HJqKfMHA=8VB9q61xJoKyYsegv3tg@mail.gmail.com>
Subject: Re: [PATCH v5 10/21] modpost: rename find_elf_symbol() and find_elf_symbol2()
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

On Sun, May 14, 2023 at 8:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> find_elf_symbol() and find_elf_symbol2() are not good names.
>
> Rename them to find_tosym(), find_fromsym(), respectively.

The comments maybe could be updated, too. The end of the comment looks
wrong for both.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v5:
>   - Change the names
>
>  scripts/mod/modpost.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 3b7b78e69137..0d2c2aff2c03 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1124,8 +1124,8 @@ static inline int is_valid_name(struct elf_info *el=
f, Elf_Sym *sym)
>   * In other cases the symbol needs to be looked up in the symbol table
>   * based on section and address.
>   *  **/
> -static Elf_Sym *find_elf_symbol(struct elf_info *elf, Elf64_Sword addr,
> -                               Elf_Sym *relsym)
> +static Elf_Sym *find_tosym(struct elf_info *elf, Elf64_Sword addr,
> +                          Elf_Sym *relsym)
>  {
>         Elf_Sym *sym;
>         Elf_Sym *near =3D NULL;
> @@ -1168,8 +1168,8 @@ static Elf_Sym *find_elf_symbol(struct elf_info *el=
f, Elf64_Sword addr,
>   * The ELF format may have a better way to detect what type of symbol
>   * it is, but this works for now.
>   **/
> -static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
> -                                unsigned int secndx)
> +static Elf_Sym *find_fromsym(struct elf_info *elf, Elf_Addr addr,
> +                            unsigned int secndx)
>  {
>         Elf_Sym *sym;
>         Elf_Sym *near =3D NULL;
> @@ -1207,10 +1207,10 @@ static void default_mismatch_handler(const char *=
modname, struct elf_info *elf,
>         const char *tosym;
>         const char *fromsym;
>
> -       from =3D find_elf_symbol2(elf, r->r_offset, fsecndx);
> +       from =3D find_fromsym(elf, r->r_offset, fsecndx);
>         fromsym =3D sym_name(elf, from);
>
> -       to =3D find_elf_symbol(elf, r->r_addend, sym);
> +       to =3D find_tosym(elf, r->r_addend, sym);
>         tosym =3D sym_name(elf, to);
>
>         /* check whitelist - we may ignore it */
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
