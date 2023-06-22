Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34873A828
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFVSZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 14:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjFVSZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 14:25:17 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A782100
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:25:16 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id 6a1803df08f44-6300f6ab032so50538036d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687458315; x=1690050315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JpCY0TF2cLx96N/IyHACrfjpAnXPyxrzLRydMAh063w=;
        b=LoCvzzDLFrPjEegwplNV98rfiCBa2fLDn5ZUgLH0vtLT7K994v9F+U61cS06HLkXMo
         GpLyvfbGHFmIN4K837Jlry+7DKakBC2UjQwDBsgkQnkXoYV0bb14uUMe08wS7SvoIjZM
         uVxVTa25bsc1VxjuIc6ZULbyGaMBZ1h7E/z12EpslZuuurFCMNJMsvR5EbCblPwx2KV1
         q1E6o4ws6nKipCPOoSLK3w+e+a+5T1vGyVtFTZjzdePSXc2yXqoJIPcVn1mIKkQ8B6mL
         0IlY8zdsUjtzHBuq/b0DHCDKJWrRbKOoHkN8cfaHJEbF46GZPKsdm9M3eVChNYDiy9Zn
         vFAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687458315; x=1690050315;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JpCY0TF2cLx96N/IyHACrfjpAnXPyxrzLRydMAh063w=;
        b=FqjCDnV5PFz/xxYyG/sA+CAddhu4UKwEeMJ+y33e1hT7DgyNTMOUWv7IEdQoIeblFT
         Ck7vhNiURSXZY1o2pm9CXF89O/qf00tE85jIo6D97h9aLsaDc5mZwBn/Wgk+Zx8vPbJI
         hsPES/HZpDPxGFeXZVXiDDjbB+lDshWPum4VVh0Gp8qE7NGJnqJYjkuCtPU8NGwyCUqr
         7odjjUg0itfp75o+9qZLVdcup/F9K3E2PUL5aycad4NHKUNhUk0eEOM66S9jrOMicStn
         uOYtcvE4rDbxl6/6lPwdgz0P3HsnmIAsqQIzI7x3vqY5bxQLrB/8vGHNjlFBYi7yf/Ip
         S8/w==
X-Gm-Message-State: AC+VfDyWdm2tyUQrSYTvwifn09g9WVIo2ynoKR7b7WxTZ74Jg9Bl500e
        dBCmULDqjHIlX/Vo2ayotWe3FpXVv5vXMeAD40OPcg==
X-Google-Smtp-Source: ACHHUZ4vBUYD+mow6n0TLXiHFM9GLNwgLvyOX/L8uL7ECQ3XGv6mlSTCgtn/a6Pj1paR6IhZWwU+TayLfzHR8jW1Vx4=
X-Received: by 2002:a05:6214:518f:b0:630:228d:6d38 with SMTP id
 kl15-20020a056214518f00b00630228d6d38mr13398621qvb.46.1687458315462; Thu, 22
 Jun 2023 11:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230620120521.688124-1-masahiroy@kernel.org>
In-Reply-To: <20230620120521.688124-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 22 Jun 2023 11:25:04 -0700
Message-ID: <CAKwvOdmSUkyb_fwDJ-_bKxo65MRWUShc25L5itWt4m4MTYi=yQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] modpost: factor out inst location calculation to section_rel()
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
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 5:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> All the addend_*_rel() functions calculate the instruction location in
> the same way.
>
> Factor out the similar code to the caller. Squash reloc_location() too.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 28 ++++++++++++----------------
>  1 file changed, 12 insertions(+), 16 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 6e0b8be32648..2551ac9d5bd3 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1256,16 +1256,9 @@ static void check_section_mismatch(struct module *=
mod, struct elf_info *elf,
>                                  tosec, taddr);
>  }
>
> -static unsigned int *reloc_location(struct elf_info *elf,
> -                                   Elf_Shdr *sechdr, Elf_Rela *r)
> -{
> -       return sym_get_data_by_offset(elf, sechdr->sh_info, r->r_offset);
> -}
> -
> -static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Re=
la *r)
> +static int addend_386_rel(uint32_t *location, Elf_Rela *r)
>  {
>         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> -       unsigned int *location =3D reloc_location(elf, sechdr, r);
>
>         switch (r_typ) {
>         case R_386_32:
> @@ -1302,11 +1295,10 @@ static int32_t sign_extend32(int32_t value, int i=
ndex)
>         return (int32_t)(value << shift) >> shift;
>  }
>
> -static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Re=
la *r)
> +static int addend_arm_rel(void *loc, struct elf_info *elf, Elf_Rela *r)
>  {
>         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
>         Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
> -       void *loc =3D reloc_location(elf, sechdr, r);
>         uint32_t inst, upper, lower, sign, j1, j2;
>         int32_t offset;
>
> @@ -1396,11 +1388,10 @@ static int addend_arm_rel(struct elf_info *elf, E=
lf_Shdr *sechdr, Elf_Rela *r)
>         return 0;
>  }
>
> -static int addend_mips_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_R=
ela *r)
> +static int addend_mips_rel(uint32_t *location, Elf_Rela *r)
>  {
>         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> -       unsigned int *location =3D reloc_location(elf, sechdr, r);
> -       unsigned int inst;
> +       uint32_t inst;
>
>         if (r_typ =3D=3D R_MIPS_HI16)
>                 return 1;       /* skip this */
> @@ -1502,6 +1493,8 @@ static void section_rel(struct module *mod, struct =
elf_info *elf,
>                 return;
>
>         for (rel =3D start; rel < stop; rel++) {
> +               void *loc;
> +
>                 r.r_offset =3D TO_NATIVE(rel->r_offset);
>  #if KERNEL_ELFCLASS =3D=3D ELFCLASS64
>                 if (elf->hdr->e_machine =3D=3D EM_MIPS) {
> @@ -1519,17 +1512,20 @@ static void section_rel(struct module *mod, struc=
t elf_info *elf,
>                 r_sym =3D ELF_R_SYM(r.r_info);
>  #endif
>                 r.r_addend =3D 0;
> +
> +               loc =3D sym_get_data_by_offset(elf, fsecndx, r.r_offset);

Can we compute `loc` only for the three machine types?

> +
>                 switch (elf->hdr->e_machine) {
>                 case EM_386:
> -                       if (addend_386_rel(elf, sechdr, &r))
> +                       if (addend_386_rel(loc, &r))
>                                 continue;
>                         break;
>                 case EM_ARM:
> -                       if (addend_arm_rel(elf, sechdr, &r))
> +                       if (addend_arm_rel(loc, elf, &r))
>                                 continue;
>                         break;
>                 case EM_MIPS:
> -                       if (addend_mips_rel(elf, sechdr, &r))
> +                       if (addend_mips_rel(loc, &r))
>                                 continue;
>                         break;
>                 default:
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
