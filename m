Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70BD370C4BB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 19:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjEVR4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 13:56:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbjEVR4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 13:56:33 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45961FF
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:56:32 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-62382e9cb8dso27978426d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 10:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1684778191; x=1687370191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AXu554m4l5lkSSuU8scTxxrh2rIrybtjbuunAaVMS6M=;
        b=6R6Xuz2WYLNqFqcWYkB0qy2OU0/5A3pSp0iCnWyFXcYtVRqyRaHQLbLQLMqWvoHAqi
         XPWUW5l2o5IiTHg3rNo8prwF/RdW7LUARZN7hh9nsQb44h0f/mShSlGLyEY3Fo02NnEq
         mY8LsRltpXZTF7FEmcbR21SLlkxHoFLateRbuk9e15CEZhvkSc2GwnaS8w0M1/huJrv1
         SIT36mOhZWPOUooNL2fX1pigwzj3PLMjQMn3rDrJsNwV6oxjnYaPAOKqtwOqbAk079fm
         M0vRj8IlimWn1G6Xkb68aq/Yr5VbJBhiTi7cIcoN8RULEZsS+MRLq9fXQREeNBvMrbRG
         Oj1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684778191; x=1687370191;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AXu554m4l5lkSSuU8scTxxrh2rIrybtjbuunAaVMS6M=;
        b=fgvFNo85oslcLmG0JmrxOwIjGcXNNzlNZP+BaQ2beFlkK8w+dFMfCe6fnedlHMfd1B
         8iPAiTgYnQH54X/VCP7lT9Ml1d+TbwDyMM80lxDsURFXbfqO0YQ2nTB+wPbC2zpRQ/Yl
         KosGugxkJ82ncrnZL5F6RN+SzYDwzwGx2atf+sf75iJrVIcdEU7ud+nYKb7NS2OYI/PO
         G0KbUhtXiMFP31bkM+BskexDd+PUW0CI5ySTZriaUN6kP54EtZBZA9fMzbasjaWkSz2c
         nZKV2RnlD0SJY+7FpvEw3FmqSeUgV4Qspf5dkmuOB4R1eM1g/vMsUDvEE/bE+8p/IQwi
         qMTA==
X-Gm-Message-State: AC+VfDwQ/BEcvrMlXn8FDiqMFXcqiB4/tENRlHsrRDKa7kd8pTIcjC0n
        +R1YrJDyS65UYIstxu0kzDPIxW1ekwiYvbKSdf098w==
X-Google-Smtp-Source: ACHHUZ5Uq3GLy2552YvGQzU2l81xm6dJRT1S3/tG40LO8/m91yXrfSuKs/vkOcRY60K0hOUGLFl6C46t29ez4Ieg8GI=
X-Received: by 2002:ad4:4eef:0:b0:624:c497:526a with SMTP id
 dv15-20020ad44eef000000b00624c497526amr12884208qvb.24.1684778191057; Mon, 22
 May 2023 10:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230521160426.1881124-1-masahiroy@kernel.org> <20230521160426.1881124-3-masahiroy@kernel.org>
In-Reply-To: <20230521160426.1881124-3-masahiroy@kernel.org>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 22 May 2023 10:56:20 -0700
Message-ID: <CAKwvOd=B+dKWjxD-K-8btROvywp_Nei=CREeYZdCvKSGuHHJOA@mail.gmail.com>
Subject: Re: [PATCH v6 02/20] modpost: fix section mismatch message for R_ARM_ABS32
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

+ linux-arm-kernel and some folks who might know another idea.

On Sun, May 21, 2023 at 9:05=E2=80=AFAM Masahiro Yamada <masahiroy@kernel.o=
rg> wrote:
>
> addend_arm_rel() processes R_ARM_ABS32 in a wrong way.
>
> Here, simple test code.
>
>   [test code 1]
>
>     #include <linux/init.h>
>
>     int __initdata foo;
>     int get_foo(int x) { return foo; }
>
> If you compile it with ARM versatile_defconfig, modpost will show the
> symbol name, (unknown).
>
>   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (se=
ction: .text) -> (unknown) (section: .init.data)
>
> If you compile it for other architectures, modpost will show the correct
> symbol name.
>
>   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (se=
ction: .text) -> foo (section: .init.data)
>
> For R_ARM_ABS32, addend_arm_rel() sets r->r_addend to a wrong value.
>
> I just mimicked the code in arch/arm/kernel/module.c.
>
> However, there is more difficulty for ARM.
>
> Here, test code.
>
>   [test code 2]
>
>     #include <linux/init.h>
>
>     int __initdata foo;
>     int get_foo(int x) { return foo; }
>
>     int __initdata bar;
>     int get_bar(int x) { return bar; }
>
> With this commit applied, modpost will show the following messages
> for ARM versatile_defconfig:
>
>   WARNING: modpost: vmlinux.o: section mismatch in reference: get_foo (se=
ction: .text) -> foo (section: .init.data)
>   WARNING: modpost: vmlinux.o: section mismatch in reference: get_bar (se=
ction: .text) -> foo (section: .init.data)
>
> The reference from 'get_bar' to 'foo' seems wrong.
>
> I have no solution for this because it is true in assembly level.
>
> In the following output, relocation at 0x1c is no longer associated
> with 'bar'. The two relocation entries point to the same symbol, and
> the offset to 'bar' is encoded in the instruction 'r0, [r3, #4]'.
>
>   Disassembly of section .text:
>
>   00000000 <get_foo>:
>      0: e59f3004          ldr     r3, [pc, #4]   @ c <get_foo+0xc>
>      4: e5930000          ldr     r0, [r3]
>      8: e12fff1e          bx      lr
>      c: 00000000          .word   0x00000000
>
>   00000010 <get_bar>:
>     10: e59f3004          ldr     r3, [pc, #4]   @ 1c <get_bar+0xc>
>     14: e5930004          ldr     r0, [r3, #4]
>     18: e12fff1e          bx      lr
>     1c: 00000000          .word   0x00000000
>
>   Relocation section '.rel.text' at offset 0x244 contains 2 entries:
>    Offset     Info    Type            Sym.Value  Sym. Name
>   0000000c  00000c02 R_ARM_ABS32       00000000   .init.data
>   0000001c  00000c02 R_ARM_ABS32       00000000   .init.data
>
> When find_elf_symbol() gets into a situation where relsym->st_name is
> zero, there is no guarantee to get the symbol name as written in C.
>
> I am keeping the current logic because it is useful in many architectures=
,
> but the symbol name is not always correct depending on the optimization
> of the relocation. I left some comments in find_tosym().
>
> Fixes: 56a974fa2d59 ("kbuild: make better section mismatch reports on arm=
")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
> Changes in v6:
>  - More detailed commit log
>
>  scripts/mod/modpost.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 71de14544432..34fbbd85bfde 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1124,6 +1124,10 @@ static Elf_Sym *find_tosym(struct elf_info *elf, E=
lf64_Sword addr,
>         if (relsym->st_name !=3D 0)
>                 return relsym;
>
> +       /*
> +        * Strive to find a better symbol name, but the resulting name do=
es not
> +        * always match the symbol referenced in the original code.
> +        */
>         relsym_secindex =3D get_secindex(elf, relsym);
>         for (sym =3D elf->symtab_start; sym < elf->symtab_stop; sym++) {
>                 if (get_secindex(elf, sym) !=3D relsym_secindex)
> @@ -1306,12 +1310,12 @@ static int addend_386_rel(struct elf_info *elf, E=
lf_Shdr *sechdr, Elf_Rela *r)
>  static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Re=
la *r)
>  {
>         unsigned int r_typ =3D ELF_R_TYPE(r->r_info);
> +       Elf_Sym *sym =3D elf->symtab_start + ELF_R_SYM(r->r_info);
> +       unsigned int inst =3D TO_NATIVE(*reloc_location(elf, sechdr, r));
>
>         switch (r_typ) {
>         case R_ARM_ABS32:
> -               /* From ARM ABI: (S + A) | T */
> -               r->r_addend =3D (int)(long)
> -                             (elf->symtab_start + ELF_R_SYM(r->r_info));
> +               r->r_addend =3D inst + sym->st_value;
>                 break;
>         case R_ARM_PC24:
>         case R_ARM_CALL:
> --
> 2.39.2
>


--=20
Thanks,
~Nick Desaulniers
