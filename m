Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031AA70736A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbjEQU65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjEQU6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:58:55 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD940EB
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:58:55 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id af79cd13be357-7576ae0f44bso26013385a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 13:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684357134; x=1686949134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2czja4XHffo3nxVxoM69dFCyr+HErNl06rsEi0dap2c=;
        b=Ll4EkCLwqXy2/czUUuAyJqaF6ONCFBCApEbnJf2pr3gTJjz2i0PPnm97/Wqjb70X/d
         KxPrzvkUYJtPsM0CuEQV80wqinnQEH3i4dy4B25TUBrGne5ETg4+1gLm3AFAcKpNk2tQ
         9t+ZBRJ9nGRttcWzG+001370aq9V6G76WqnOXBQ9f9l6z5C2ahHFhAPSrfIGkd+9AVqx
         J3uH+EHcbcOBfaSPGUUG9UY1TGfFU1mAteenWUC9qmLBYNBl9BzwoasjrYsA1+hb3Smd
         ZSBUoKIMoybcv9PLnKjS9UKJjPUKNhJziqlWDYkMQCYgpQw054OwUbbr5P/lvKYTYzxE
         msKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684357134; x=1686949134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2czja4XHffo3nxVxoM69dFCyr+HErNl06rsEi0dap2c=;
        b=QoS+HUD8SISOL1/e0KIOMNFgKfF5A4JIYEB6lAdZTirB3zGzX6wXDD51wT4iRJqfT4
         H/pIhH3T2bPVsNYGyFxDWYY6LhHMKeKY2zD856GsSpk12B3ZDyJ9U1OVCdKYdYH5j0AU
         Y+Z8GXkCEDo4Ho0GeAHFdg9InC6h4pLSB+9fzZy6bqrbSTr3bwAmv/Lugu3xsQpUIQIY
         BcogDXE/Twig4gnoLRnNSG95rJrQHfhBLaRS2lM5iRIVK65oJvIQZuDA4wJ93TxrgzHy
         Y2pNO76h3cFE3EwUh9Q+Lmbq6oy38CpS/AtLv3KDdgIPiLiu6qtYIRx8csAqBLqZ40hh
         huMQ==
X-Gm-Message-State: AC+VfDxTHocyKfCJDS4W2mVeEczK4haM17PCqWX070HviwtoTJHWaDM6
        rKI5BEB5h6wG6IM9HmLcl7vevGMVSfNV4du0vI0JmQpyNzjp/6Za9hI=
X-Google-Smtp-Source: ACHHUZ5Yq1ysISuJWhzqdfHVNewGDtjE9+aw5f90jB+4wttwyxYN9d6rWZGXZEgFXztNUIY2fJJlcJRIaSnFwSUMpqY=
X-Received: by 2002:a05:6214:e44:b0:5ea:9fc5:fcb1 with SMTP id
 o4-20020a0562140e4400b005ea9fc5fcb1mr1897763qvc.9.1684357134134; Wed, 17 May
 2023 13:58:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-9-masahiroy@kernel.org>
In-Reply-To: <20230514152739.962109-9-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 13:58:43 -0700
Message-ID: <CAKwvOdk7u5Yj8+Y6WeSpdohz25Tcrpo9Gc9BuAhpbac7RibEjQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/21] modpost: pass 'tosec' down to default_mismatch_handler()
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

On Sun, May 14, 2023 at 8:28=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> default_mismatch_handler() does not need to compute 'tosec' because
> it is calculated by the caller.
>
> Pass it down to default_mismatch_handler() instead of calling
> sec_name() twice.

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 49357a716519..2cc9c2a4aadc 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1203,9 +1203,9 @@ static bool is_executable_section(struct elf_info *=
elf, unsigned int secndx)
>
>  static void default_mismatch_handler(const char *modname, struct elf_inf=
o *elf,
>                                      const struct sectioncheck* const mis=
match,
> -                                    Elf_Rela *r, Elf_Sym *sym, const cha=
r *fromsec)
> +                                    Elf_Rela *r, Elf_Sym *sym, const cha=
r *fromsec,
> +                                    const char *tosec)
>  {
> -       const char *tosec;
>         Elf_Sym *to;
>         Elf_Sym *from;
>         const char *tosym;
> @@ -1214,7 +1214,6 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>         from =3D find_elf_symbol2(elf, r->r_offset, fromsec);
>         fromsym =3D sym_name(elf, from);
>
> -       tosec =3D sec_name(elf, get_secindex(elf, sym));
>         to =3D find_elf_symbol(elf, r->r_addend, sym);
>         tosym =3D sym_name(elf, to);
>
> @@ -1276,7 +1275,7 @@ static void check_section_mismatch(const char *modn=
ame, struct elf_info *elf,
>         if (!mismatch)
>                 return;
>
> -       default_mismatch_handler(modname, elf, mismatch, r, sym, fromsec)=
;
> +       default_mismatch_handler(modname, elf, mismatch, r, sym, fromsec,=
 tosec);
>  }
>
>  static unsigned int *reloc_location(struct elf_info *elf,
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
