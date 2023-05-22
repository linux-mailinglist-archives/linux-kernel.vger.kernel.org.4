Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9835370C4E9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 20:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjEVSDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 14:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231998AbjEVSDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 14:03:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4856E132
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:03:25 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-5ed99ebe076so54214766d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 11:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684778604; x=1687370604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yN+5fBZoSuRn2vAVaf6V5f1u8QGccSwvan5bXoofEZA=;
        b=lH5aomZyS23V9z5grwNvsBN8NmKzJDL/BX+41G/2VZaB/KWe1weF4RNKsk3HflmUdj
         S8MuEdABefEJQS+E1rmU5aVLwFeRjFl2mLkYLhGDkTMr5SYDytGThyIKAqGi5jm+9EQy
         /yZcGvAsZWh/xWBp6CAQQNXuDyEZpy4s1cqe1aLUkmXEwMw7oVnHp1Ab+/3XLiMLDVIL
         5GToqetd3ksTETD68d45ofw4H4CVMfrsR41Amm2n1VFWf8g+ugJH7rKz0xTC0yj2x4WV
         gdFkPXMh///Zw41ir6lxRiT9YR+e32uRsUTbeVBD9uFSScwhCu+/0g2VHVaNnmPappGR
         sDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684778604; x=1687370604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yN+5fBZoSuRn2vAVaf6V5f1u8QGccSwvan5bXoofEZA=;
        b=PDYy2VB80xTQTK9GTGxvgiyQvi/gpM/vYkJXK73etAHZlD8IzgEK5n2Uu5it2q163G
         UYs5eFzhs1dkDndCxxu3IcVgaXHSOqamlpvrlpK7xyhr1sN5zszUDXnOkPuIUu76BooO
         BW/xUqvs2nOXBzr2dPVltbo71GzLMAnq4LkdHsL2Eg5b/4Zq+AkdNpoGFhfzaj+Fhin/
         g0QmO/FVPzgiv11syFAxkh4MsgwL4jFn7cX2iPQXEXWjJfgalM6c0i+lb/6IKy6VzB62
         9JKLqn9F95wL69Mba1e8xBCPho25sDyEXFWITjJD6SUyJgnrwTTxCgKxj/+wl/OgoBRD
         dgoQ==
X-Gm-Message-State: AC+VfDymZ97XxWYppr1NBu1E30RTc4QGSGJUCFc2J9v7FWUaYdmInkRV
        wWIzCfCgUWSULekWXrIq+qsy36t7PahnMhMbQxy/AQ==
X-Google-Smtp-Source: ACHHUZ7CdEhV2NhYsdjVZmTsn5VMlhEvOxGibdnoeXYzGtdTUkQhYEWAQjX+aLxdXF+HSTtIu2vDJ21Y7YJQWPJID7A=
X-Received: by 2002:a05:6214:19cd:b0:5df:47e2:8df5 with SMTP id
 j13-20020a05621419cd00b005df47e28df5mr23742073qvc.31.1684778604263; Mon, 22
 May 2023 11:03:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-4-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-4-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 11:03:13 -0700
Message-ID: <CAKwvOdmxLrE8VksbsSGirfTqnuhEFT__FuCG53ri3V42UbH5aw@mail.gmail.com>
Subject: Re: [PATCH v6 03/20] modpost: detect section mismatch for
 R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Fangrui Song <maskray@google.com>
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

+ linux-arm-kernel

On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> ARM defconfig misses to detect some section mismatches.
>
>   [test code]
>
>     #include <linux/init.h>
>
>     int __initdata foo;
>     int get_foo(int x) { return foo; }
>
> It is apparently a bad reference, but modpost does not report anything
> for ARM defconfig (i.e. multi_v7_defconfig).
>
> The test code above produces the following relocations.
>
>   Relocation section '.rel.text' at offset 0x200 contains 2 entries:
>    Offset     Info    Type            Sym.Value  Sym. Name
>   00000000  0000062b R_ARM_MOVW_ABS_NC 00000000   .LANCHOR0
>   00000004  0000062c R_ARM_MOVT_ABS    00000000   .LANCHOR0
>
>   Relocation section '.rel.ARM.exidx' at offset 0x210 contains 2 entries:
>    Offset     Info    Type            Sym.Value  Sym. Name
>   00000000  0000022a R_ARM_PREL31      00000000   .text
>   00000000  00001000 R_ARM_NONE        00000000   __aeabi_unwind_cpp_pr0
>
> Currently, R_ARM_MOVW_ABS_NC and R_ARM_MOVT_ABS are just skipped.
>
> Add code to handle them. I checked arch/arm/kernel/module.c to learn
> how the offset is encoded in the instruction.
>
> The referenced symbol in relocation might be a local anchor.
> If is_valid_name() returns false, let's search for a better symbol name.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 34fbbd85bfde..ed2301e951a9 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1108,7 +1108,7 @@ static inline int is_valid_name(struct elf_info *el=
f, Elf_Sym *sym)
>  /**
>   * Find symbol based on relocation record info.
>   * In some cases the symbol supplied is a valid symbol so
> - * return refsym. If st_name !=3D 0 we assume this is a valid symbol.
> + * return refsym. If is_valid_name() =3D=3D true, we assume this is a va=
lid symbol.
>   * In other cases the symbol needs to be looked up in the symbol table
>   * based on section and address.
>   *  **/
> @@ -1121,7 +1121,7 @@ static Elf_Sym *find_tosym(struct elf_info *elf, El=
f64_Sword addr,
>         Elf64_Sword d;
>         unsigned int relsym_secindex;
>
> -       if (relsym->st_name !=3D 0)
> +       if (is_valid_name(elf, relsym))
>                 return relsym;
>
>         /*
> @@ -1312,11 +1312,19 @@ static int addend_arm_rel(struct elf_info *elf, E=
lf_Shdr *sechdr, Elf_Rela *r)
>         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
>         Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
>         unsigned int inst =3D TO_NATIVE(*reloc_location(elf, sechdr, r));
> +       int offset;
>
>         switch (r_typ) {
>         case R_ARM_ABS32:
>                 r->r_addend =3D inst + sym->st_value;
>                 break;
> +       case R_ARM_MOVW_ABS_NC:
> +       case R_ARM_MOVT_ABS:
> +               offset =3D ((inst & 0xf0000) >> 4) | (inst & 0xfff);
> +               offset =3D (offset ^ 0x8000) - 0x8000;

The code in arch/arm/kernel/module.c then right shifts the offset by
16 for R_ARM_MOVT_ABS. Is that necessary?

> +               offset +=3D sym->st_value;
> +               r->r_addend =3D offset;
> +               break;
>         case R_ARM_PC24:
>         case R_ARM_CALL:
>         case R_ARM_JUMP24:
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
