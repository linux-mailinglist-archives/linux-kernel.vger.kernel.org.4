Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4D2707491
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjEQVyG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:54:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQVyE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:54:04 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A1A2728
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:54:03 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-61b40562054so6077166d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684360442; x=1686952442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mTTGg4QMVubvOCirJy3IK2jB/80t3lUB6+yAnmXNohk=;
        b=1P6l980sfbqqR2QSxo43Or5ZuP2QxzTksJ9KhEi//uj5EuIiPuGRlci3sB14f6LRIW
         lXqnt4yE2FkC7HEbUwM3cA8yMGqO3e6R4mLy50BXeqslQXSRne3SvqN7VdsmYQrfl3sW
         ehbpNE4l/Nx02xgbNQXeR29i0XX8QCRav3ldDYchGDRJmRYtjcTH8B6McTxkH0jYKnN6
         Ho95K49FFCKdWdxTqTkIWE83VhJ8kWfmmEwKkKLbsRBJpp4/5QqFiYq2Sy4a1OQGhbKp
         rIr3s92UfbSKnVB5lBLuOve0RB3Hvn99BZp1aOz7aAmDn0cKY+sFAvdD3mbbolw+i1dc
         NR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684360442; x=1686952442;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mTTGg4QMVubvOCirJy3IK2jB/80t3lUB6+yAnmXNohk=;
        b=ZPFSoytCwaQSMPYXxv4s3N1IqD6o86cKLvL7gBKg23lk6vE2nD5qiZbP3uFVk6NQMp
         Fh/p32QHCGWQ5IwRL5iuppowqY7XQPzMISxgIoU+nsDWhq06tDXLe0MNcnZ5Tpo6qLSC
         zUvf3m4KLYAfWkudvyg1Qitur/Y5Tn/vRHd3JaZ6ibHF0PH/0FCgWzDIErdpyvvKA9/i
         SKEwYbMR2tziAvbZay1OVkZcdDkHDxsshp9aSZuP0i7PSu04jbL7wPNzMSly/YjgiFDF
         EazRIaXTO2cfZkemV/YFsSNpUPz78PXGo9ewgP0STWytaRyfQHXuY52WanOMutHXr34A
         zqbg==
X-Gm-Message-State: AC+VfDxmkdEfOV6TIbyS2T7ncB3pvEo/845A4D+5HAA7BrHJzWXzUZSD
        VQpUVoRkH4gl8G7mUDRT3j6l8vmqzmYeOsDGJkjVTs4gU67g74dz1ng=
X-Google-Smtp-Source: ACHHUZ5UgWvFUDN+ibVRkjXLZE48iLYHVzZ7lPBN34Gb6wh67d6h8nMVyFivDARnCuTwCEsZV4DE+o4/GrG01J2Jsd0=
X-Received: by 2002:ad4:5cce:0:b0:621:c0a3:627b with SMTP id
 iu14-20020ad45cce000000b00621c0a3627bmr1560856qvb.52.1684360441129; Wed, 17
 May 2023 14:54:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-6-masahiroy@kernel.org>
In-Reply-To: <20230514152739.962109-6-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 14:53:50 -0700
Message-ID: <CAKwvOdmbhZKQZoatBgcFdm7zQR74CaiAo5nn+WZLuqeb3vSNZQ@mail.gmail.com>
Subject: Re: [PATCH v5 05/21] modpost: squash report_sec_mismatch() into default_mismatch_handler()
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
> report_sec_mismatch() and default_mismatch_handler() are small enough
> to be merged together.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 55 ++++++++++++++++---------------------------
>  1 file changed, 20 insertions(+), 35 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 7a9a3ef8ca0d..bb7d1d87bae7 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1207,17 +1207,27 @@ static Elf_Sym *find_elf_symbol2(struct elf_info =
*elf, Elf_Addr addr,
>         return near;
>  }
>
> -/*
> - * Print a warning about a section mismatch.
> - * Try to find symbols near it so user can find it.
> - * Check whitelist before warning - it may be a false positive.
> - */
> -static void report_sec_mismatch(const char *modname,
> -                               const struct sectioncheck *mismatch,
> -                               const char *fromsec,
> -                               const char *fromsym,
> -                               const char *tosec, const char *tosym)
> +static void default_mismatch_handler(const char *modname, struct elf_inf=
o *elf,
> +                                    const struct sectioncheck* const mis=
match,
> +                                    Elf_Rela *r, Elf_Sym *sym, const cha=
r *fromsec)
>  {
> +       const char *tosec;
> +       Elf_Sym *to;
> +       Elf_Sym *from;
> +       const char *tosym;
> +       const char *fromsym;
> +
> +       from =3D find_elf_symbol2(elf, r->r_offset, fromsec);
> +       fromsym =3D sym_name(elf, from);
> +
> +       tosec =3D sec_name(elf, get_secindex(elf, sym));
> +       to =3D find_elf_symbol(elf, r->r_addend, sym);
> +       tosym =3D sym_name(elf, to);
> +
> +       /* check whitelist - we may ignore it */
> +       if (!secref_whitelist(mismatch, fromsec, fromsym, tosec, tosym))
> +               return;
> +
>         sec_mismatch_count++;
>
>         switch (mismatch->mismatch) {
> @@ -1242,31 +1252,6 @@ static void report_sec_mismatch(const char *modnam=
e,
>         }
>  }
>
> -static void default_mismatch_handler(const char *modname, struct elf_inf=
o *elf,
> -                                    const struct sectioncheck* const mis=
match,
> -                                    Elf_Rela *r, Elf_Sym *sym, const cha=
r *fromsec)
> -{
> -       const char *tosec;
> -       Elf_Sym *to;
> -       Elf_Sym *from;
> -       const char *tosym;
> -       const char *fromsym;
> -
> -       from =3D find_elf_symbol2(elf, r->r_offset, fromsec);
> -       fromsym =3D sym_name(elf, from);
> -
> -       tosec =3D sec_name(elf, get_secindex(elf, sym));
> -       to =3D find_elf_symbol(elf, r->r_addend, sym);
> -       tosym =3D sym_name(elf, to);
> -
> -       /* check whitelist - we may ignore it */
> -       if (secref_whitelist(mismatch,
> -                            fromsec, fromsym, tosec, tosym)) {
> -               report_sec_mismatch(modname, mismatch,
> -                                   fromsec, fromsym, tosec, tosym);
> -       }
> -}
> -
>  static int is_executable_section(struct elf_info* elf, unsigned int sect=
ion_index)
>  {
>         if (section_index > elf->num_sections)
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
