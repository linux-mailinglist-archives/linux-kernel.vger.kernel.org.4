Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46758707382
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:05:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjEQVFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjEQVFR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:05:17 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3670783C6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:05:16 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-7577f03e131so80695185a.0
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684357515; x=1686949515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+cLxniotM/EM+5BVdPmo+voqQOwKYEzqgr0Ov5V8b34=;
        b=4hZ9r77l9hrxNktL3aLUI/qION3B1JjNoLQV76nV0wiyU7DX+YLRtd+I0NVUwHPfrP
         tb+5PuZn++o+y+55YXY9amWouZyqUuQ74Ez85oM8UHTFGndkKbX/RcJbCOiK9vb12rXa
         jSeZ2r2pIiJed6sOfpPDgItv8nS7CyFPkjLYPD3Qb34WXtz/GIBmXGYrBey1vrBwX1/y
         s46qa4IKqu/K/xyAzbMX7aMKiH97c1JNTThopU4NH0ZrcUnLFVJ2PY7Rju0hnNWCrtTr
         6Z8i1p3a6hdV8ADFcxoM2Hlk/jLKpkMEcriykwVzq8saTc9bBKPS6vtJhvY2JlKW7Gg3
         3ySg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684357515; x=1686949515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+cLxniotM/EM+5BVdPmo+voqQOwKYEzqgr0Ov5V8b34=;
        b=P8Xbqpe2oy3C2U1Iwj+mFVVqRPd3ka9UHH/NQUHQ+YgF7kKN6A4reGh34pc54xvKVJ
         e9BdthBB4oPz2bguJ12cxu34LskB/C7xI9kRYfu0Y/haKMWt/W4yeDQ/MmyWK1Q2Zhjg
         PEiaf4Zld/Y/eKEX/LVg81gZjErHEkn95CkCCAhZCCnu77z3aRgVmJXXy/RgFHebctSu
         awQYhCc4tJPduMs5ZO1I7OCrm2TOXi7iWMT5gE5Bxr/8FGpUItc70sH6FDlh2ZKcqYc+
         kWaatX0fDNiflqM1Qh7I11AqOfC4Gm4pM7kK4HhEzPHpfvqOKfO7hSf0rB8TwaYi7Z6g
         K4zw==
X-Gm-Message-State: AC+VfDzGpavsQ4SUja/nnmTnauCoaa1K511HMgMs0sEH7BE62FycTbbX
        QoNQHbuXFbkUIp0gJjKYJ1L8VRUDaCjke5V6vS394g==
X-Google-Smtp-Source: ACHHUZ6YYuugFD1xROaho1IOfKDzyxOkZA8yoc2xmX64HCezJmw7RFImfaKeymZz/w1YG/fUCQz42DswiisyxamXTVE=
X-Received: by 2002:a05:6214:19cd:b0:623:832f:8b19 with SMTP id
 j13-20020a05621419cd00b00623832f8b19mr1873658qvc.20.1684357515156; Wed, 17
 May 2023 14:05:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230514152739.962109-1-masahiroy@kernel.org> <20230514152739.962109-10-masahiroy@kernel.org>
In-Reply-To: <20230514152739.962109-10-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 14:05:04 -0700
Message-ID: <CAKwvOd=4hN7niwmL5EmkwGASPJtqZwzHqqpcDSWOu5Lhx4yn8Q@mail.gmail.com>
Subject: Re: [PATCH v5 09/21] modpost: pass section index to find_elf_symbol2()
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
> find_elf_symbol2() converts the section index to the section name,
> then compares the two section names in each iteration. This is slow.
>
> It is faster to compare the section indices (i.e. integers) directly.

Good idea!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 2cc9c2a4aadc..3b7b78e69137 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1169,19 +1169,14 @@ static Elf_Sym *find_elf_symbol(struct elf_info *=
elf, Elf64_Sword addr,
>   * it is, but this works for now.
>   **/
>  static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
> -                                const char *sec)
> +                                unsigned int secndx)
>  {
>         Elf_Sym *sym;
>         Elf_Sym *near =3D NULL;
>         Elf_Addr distance =3D ~0;
>
>         for (sym =3D elf->symtab_start; sym < elf->symtab_stop; sym++) {
> -               const char *symsec;
> -
> -               if (is_shndx_special(sym->st_shndx))
> -                       continue;
> -               symsec =3D sec_name(elf, get_secindex(elf, sym));
> -               if (strcmp(symsec, sec) !=3D 0)
> +               if (get_secindex(elf, sym) !=3D secndx)
>                         continue;
>                 if (!is_valid_name(elf, sym))
>                         continue;
> @@ -1203,7 +1198,8 @@ static bool is_executable_section(struct elf_info *=
elf, unsigned int secndx)
>
>  static void default_mismatch_handler(const char *modname, struct elf_inf=
o *elf,
>                                      const struct sectioncheck* const mis=
match,
> -                                    Elf_Rela *r, Elf_Sym *sym, const cha=
r *fromsec,
> +                                    Elf_Rela *r, Elf_Sym *sym,
> +                                    unsigned int fsecndx, const char *fr=
omsec,
>                                      const char *tosec)
>  {
>         Elf_Sym *to;
> @@ -1211,7 +1207,7 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>         const char *tosym;
>         const char *fromsym;
>
> -       from =3D find_elf_symbol2(elf, r->r_offset, fromsec);
> +       from =3D find_elf_symbol2(elf, r->r_offset, fsecndx);
>         fromsym =3D sym_name(elf, from);
>
>         to =3D find_elf_symbol(elf, r->r_addend, sym);
> @@ -1267,7 +1263,8 @@ static void default_mismatch_handler(const char *mo=
dname, struct elf_info *elf,
>  }
>
>  static void check_section_mismatch(const char *modname, struct elf_info =
*elf,
> -                                  Elf_Rela *r, Elf_Sym *sym, const char =
*fromsec)
> +                                  Elf_Rela *r, Elf_Sym *sym,
> +                                  unsigned int fsecndx, const char *from=
sec)
>  {
>         const char *tosec =3D sec_name(elf, get_secindex(elf, sym));
>         const struct sectioncheck *mismatch =3D section_mismatch(fromsec,=
 tosec);
> @@ -1275,7 +1272,8 @@ static void check_section_mismatch(const char *modn=
ame, struct elf_info *elf,
>         if (!mismatch)
>                 return;
>
> -       default_mismatch_handler(modname, elf, mismatch, r, sym, fromsec,=
 tosec);
> +       default_mismatch_handler(modname, elf, mismatch, r, sym, fsecndx,=
 fromsec,
> +                                tosec);
>  }
>
>  static unsigned int *reloc_location(struct elf_info *elf,
> @@ -1390,12 +1388,11 @@ static void section_rela(const char *modname, str=
uct elf_info *elf,
>         Elf_Rela *rela;
>         Elf_Rela r;
>         unsigned int r_sym;
> -       const char *fromsec;
> -
> +       unsigned int fsecndx =3D sechdr->sh_info;
> +       const char *fromsec =3D sec_name(elf, fsecndx);
>         Elf_Rela *start =3D (void *)elf->hdr + sechdr->sh_offset;
>         Elf_Rela *stop  =3D (void *)start + sechdr->sh_size;
>
> -       fromsec =3D sec_name(elf, sechdr->sh_info);
>         /* if from section (name) is know good then skip it */
>         if (match(fromsec, section_white_list))
>                 return;
> @@ -1434,7 +1431,7 @@ static void section_rela(const char *modname, struc=
t elf_info *elf,
>                 /* Skip special sections */
>                 if (is_shndx_special(sym->st_shndx))
>                         continue;
> -               check_section_mismatch(modname, elf, &r, sym, fromsec);
> +               check_section_mismatch(modname, elf, &r, sym, fsecndx, fr=
omsec);
>         }
>  }
>
> @@ -1445,12 +1442,11 @@ static void section_rel(const char *modname, stru=
ct elf_info *elf,
>         Elf_Rel *rel;
>         Elf_Rela r;
>         unsigned int r_sym;
> -       const char *fromsec;
> -
> +       unsigned int fsecndx =3D sechdr->sh_info;
> +       const char *fromsec =3D sec_name(elf, fsecndx);
>         Elf_Rel *start =3D (void *)elf->hdr + sechdr->sh_offset;
>         Elf_Rel *stop  =3D (void *)start + sechdr->sh_size;
>
> -       fromsec =3D sec_name(elf, sechdr->sh_info);
>         /* if from section (name) is know good then skip it */
>         if (match(fromsec, section_white_list))
>                 return;
> @@ -1493,7 +1489,7 @@ static void section_rel(const char *modname, struct=
 elf_info *elf,
>                 /* Skip special sections */
>                 if (is_shndx_special(sym->st_shndx))
>                         continue;
> -               check_section_mismatch(modname, elf, &r, sym, fromsec);
> +               check_section_mismatch(modname, elf, &r, sym, fsecndx, fr=
omsec);
>         }
>  }
>
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
