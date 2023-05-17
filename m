Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9E8707476
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 23:41:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjEQVle (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 17:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjEQVld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 17:41:33 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD9CC213E
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:41:29 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-623914a4bf0so630556d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684359689; x=1686951689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bDq+b2ZfYYDFmAo9WgDly+IUe6hIbHfQ/RLSHSxP/78=;
        b=O78miNZ1V/XTjemeCQCMyarMfE++byFmzniA7NwgMp2CBONkaU2iBWLTbM+Zz4GS25
         LVMsWrD9H65jBdbIHt1sHivauDHvxci/eVgdGDHVog9i0VC1by156yVFqYaHWYBXKom1
         ku9WVSgsumEjW1yVhEREq5SYY1hd9OwSRm9RYmUbYFXxtJd08FZwXqSUz73rEa8MuRBu
         cNrR9TXHYnbnYOvmMX2kRLQZyn4Jyv12Tu3Uj3fL1JfZuf/CNZVSuZf/uQJsbUkpyAoK
         Tq58blgqS0nqy0MTN0wNisYWzX8pSoP34ez+bok3iv6aB/JvAsvLffV1HDwM/BbIgEns
         pC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684359689; x=1686951689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bDq+b2ZfYYDFmAo9WgDly+IUe6hIbHfQ/RLSHSxP/78=;
        b=JWONBm4MX7KQJeSiBtaQFItS23TcAXb6X+g5UxSlateh33m207mgn+1j1nZNv+QMrd
         XWqFYMkupm9j0iJskf7NceFBPx08/nG+rc/kriQvFBRRd7KyvTv2WfWqplwK4p7uU0iJ
         MD90b3SBn50mAuqxzsk3rmND0sww5GqZztOwpBGHHgthI8o1rprbU3Ww1sjQ7y8BU20w
         P2ii9ZRgDbqjpdVh7CDsCz9ZUEzVgAKZzdzwEJ/I9DtQSkOPvosunED0Y+OgvlnasGaX
         Egu/JH5nrAo9E3Tg6m7mJZBQ+uTV2BLMZpULodp4zWwoVATKkL4QYxe6GW10QDVZUgDY
         jB6Q==
X-Gm-Message-State: AC+VfDxGMeezaxkxo54uxYJTdkVbzRyCP/UMxHlx/rOJ4Jk8QhX/FrpS
        x7u9hAAAb7PJf4NEqaWJekmxUPlEVI6EnOxpWtlEdw==
X-Google-Smtp-Source: ACHHUZ5ttIRXBgugBrH6LyTmA9hxubwzkf0SzUaf5KfnQd9ndw5lPFwIl2BLSNkFdtpO6q592cwB7akX2DYN3VG2MHE=
X-Received: by 2002:a05:6214:ca1:b0:616:4e24:ff28 with SMTP id
 s1-20020a0562140ca100b006164e24ff28mr2773332qvs.0.1684359688719; Wed, 17 May
 2023 14:41:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230515005419.1293357-1-masahiroy@kernel.org>
In-Reply-To: <20230515005419.1293357-1-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 17 May 2023 14:41:17 -0700
Message-ID: <CAKwvOdkMYKhm1gaDGxqa=J136J1=+vSv=fEVYNJR430Px5Qy6A@mail.gmail.com>
Subject: Re: [PATCH] modpost: fix section mismatch message for R_ARM_ABS32
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Sam Ravnborg <sam@ravnborg.org>
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

On Sun, May 14, 2023 at 5:54=E2=80=AFPM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> The section mismatch check does not show proper warning messages for ARM.
>
> Here, very simple test code.
>
>     #include <linux/init.h>
>
>     static int __initdata foo;
>
>     void set_foo(int x)
>     {
>             foo =3D x;
>     }
>
>     int get_foo(int x)
>     {
>             return foo;
>     }
>
> If I compile it for ARM, modpost does not show the symbol name.
>
>   WARNING: modpost: vmlinux.o: section mismatch in reference: set_foo (se=
ction: .text) -> (unknown) (section: .init.data)
>   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (se=
ction: .text) -> (unknown) (section: .init.data)
>
> If I compile it for other architectures, modpost shows the correct symbol=
 name.
>
>   WARNING: modpost: vmlinux.o: section mismatch in reference: set_foo (se=
ction: .text) -> foo (section: .init.data)
>   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (se=
ction: .text) -> foo (section: .init.data)
>
> For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value.
>
> arch/arm/kernel/module.c handles R_ARM_ABS32 as follows:
>
>         case R_ARM_ABS32:
>         case R_ARM_TARGET1:
>                 *(u32 *)loc +=3D sym->st_value;
>
> I just mimicked it in modpost.
>
> Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on arm=
")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index d4531d09984d..c93780d93caf 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1460,12 +1460,13 @@ static int addend_386_rel(struct elf_info *elf, E=
lf_Shdr *sechdr, Elf_Rela *r)
>  static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Re=
la *r)
>  {
>         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> +       unsigned int *location =3D reloc_location(elf, sechdr, r);

If `location` is only used in one case of the switch, consider
computing `location` only in that case.

> +       Elf_Sym *sym;
>
>         switch (r_typ) {
>         case R_ARM_ABS32:
> -               /* From ARM ABI: (S + A) | T */
> -               r->r_addend =3D (int)(long)
> -                             (elf->symtab_start + ELF_R_SYM(r->r_info));
> +               sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
> +               r->r_addend =3D TO_NATIVE(*location) + sym->st_value;
>                 break;
>         case R_ARM_PC24:
>         case R_ARM_CALL:
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
