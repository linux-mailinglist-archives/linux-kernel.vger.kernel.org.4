Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5174F73A8BC
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbjFVTBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFVTBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:01:52 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D816186
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:01:51 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-76246351f0cso652109685a.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687460510; x=1690052510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4qsg1RqLEPdlYVYZT9sFftBXtwp261XsDqIoUJonI4s=;
        b=Oi8wiXY4ddFjysagRcHGHlOMMjiG+hAmmEXjDGXNjZxztkm1QSgAWy5PgF0ixA1iw+
         2izk782YhO+lvIJIvDOHLTFlOhjV1BI9bcWtiUsM8UZzNDwq1DbIBN25V8tvt5xJxI7X
         QXBzCV6RBQF6Oj/4iEYeJYV68KMEEbtOQ3Ea+kuhBPh+RdAiyyu92KBcZbx1dzqY5/qX
         c7uiEXlB2mRu5p3c3L3UX8dFm50HJCIAmnYnb9mBMh9Hzt+iSakLDxsDaQbo+Y4bUQ+H
         MV3tFVAHb6NU879Rw0T/6v1lJDi+Bo00ergwhJCoCfT/0KiN6iHmxFV/Th0G2SM6Bcpq
         de4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687460510; x=1690052510;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4qsg1RqLEPdlYVYZT9sFftBXtwp261XsDqIoUJonI4s=;
        b=Gy8fjbHZPY+dC66S3e09Yoz52CeH8BRBTJXFH+BSyTPuQGXuBhF+CpYoFBxdsuD+DN
         pdWnVx+3VFzMtZPiE5bIOYMkIbeGeNu4oJ3hm/ZEQCBVEeOD2Jcdl+1U3DhWnfvpaEkp
         +rckmvuykvwtoqp3DVFPckDp7W3NAy19JAvQdMoSYd0gar1VhU+nx47CNqB7z7nB4WzP
         cKM+2EIXGkr7TY8Ac16qv2hfDVCd5Webc3wjv25eEy8rpKWR/cEwhikBjuz04BpQqdyG
         +du+/P4O46HmGvLhE95mbOPqvs6zICSazq0MDgfO3c7Y87wWwkDk4+esLe0HHQ02iEOK
         H6UA==
X-Gm-Message-State: AC+VfDyaUplbjLNoYw56EusNo5JZkvCaN6vexnfS/Jl3LFQhE+bjKSbi
        5SpxepGSa/FST/0SiZ+a+JpUjtpG1/aK+J34HEzxqw==
X-Google-Smtp-Source: ACHHUZ7gJZgU33kEAEEraVJxbs1L3PgvLGOZGKq0NrHlnNt51Km5xcWPc/m4RLy9Ld8IpRrDpPg5xbPGx8DMX9yf+uI=
X-Received: by 2002:ad4:4ea6:0:b0:62f:fd5d:4ff with SMTP id
 ed6-20020ad44ea6000000b0062ffd5d04ffmr14151653qvb.21.1687460510566; Thu, 22
 Jun 2023 12:01:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230620120521.688124-1-masahiroy@kernel.org> <20230620120521.688124-2-masahiroy@kernel.org>
In-Reply-To: <20230620120521.688124-2-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Jun 2023 12:01:39 -0700
Message-ID: <CAKwvOdnuXJOiDrdGjux6JMb8akYQTi1ohPZtH1i_ZhYuJpshbQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] modpost: factor out Elf_Sym pointer calculation to section_rel()
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

On Tue, Jun 20, 2023 at 5:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> Pass the Elf_Sym pointer to addend_arm_rel() as well as to
> check_section_mismatch().
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>
>  scripts/mod/modpost.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 2551ac9d5bd3..ffe45c54f024 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1295,10 +1295,9 @@ static int32_t sign_extend32(int32_t value, int in=
dex)
>         return (int32_t)(value << shift) >> shift;
>  }
>
> -static int addend_arm_rel(void *loc, struct elf_info *elf, Elf_Rela *r)
> +static int addend_arm_rel(void *loc, Elf_Sym *sym, Elf_Rela *r)
>  {
>         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> -       Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
>         uint32_t inst, upper, lower, sign, j1, j2;
>         int32_t offset;
>
> @@ -1493,6 +1492,7 @@ static void section_rel(struct module *mod, struct =
elf_info *elf,
>                 return;
>
>         for (rel =3D start; rel < stop; rel++) {
> +               Elf_Sym *tsym;
>                 void *loc;
>
>                 r.r_offset =3D TO_NATIVE(rel->r_offset);
> @@ -1514,6 +1514,7 @@ static void section_rel(struct module *mod, struct =
elf_info *elf,
>                 r.r_addend =3D 0;
>
>                 loc =3D sym_get_data_by_offset(elf, fsecndx, r.r_offset);
> +               tsym =3D elf->symtab_start + ELF_R_SYM(r.r_info);
>
>                 switch (elf->hdr->e_machine) {
>                 case EM_386:
> @@ -1521,7 +1522,7 @@ static void section_rel(struct module *mod, struct =
elf_info *elf,
>                                 continue;
>                         break;
>                 case EM_ARM:
> -                       if (addend_arm_rel(loc, elf, &r))
> +                       if (addend_arm_rel(loc, tsym, &r))
>                                 continue;
>                         break;
>                 case EM_MIPS:
> @@ -1532,7 +1533,7 @@ static void section_rel(struct module *mod, struct =
elf_info *elf,
>                         fatal("Please add code to calculate addend for th=
is architecture\n");
>                 }
>
> -               check_section_mismatch(mod, elf, elf->symtab_start + r_sy=
m,
> +               check_section_mismatch(mod, elf, tsym,
>                                        fsecndx, fromsec, r.r_offset, r.r_=
addend);
>         }
>  }
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
