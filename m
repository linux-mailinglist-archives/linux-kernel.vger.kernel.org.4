Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFE29719BFD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbjFAMXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjFAMXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:23:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7AD9D;
        Thu,  1 Jun 2023 05:23:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52347643CA;
        Thu,  1 Jun 2023 12:23:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8222C433EF;
        Thu,  1 Jun 2023 12:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685622212;
        bh=fkFYdcDraY8CxXefsOf2X+lFb/cNpX2LQm9Gppg1hzM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JiljeqkLXukpkIkoSD6ciRMKkw24FJUS+AumrLx5OsYE1UZla7Bjeyn07M1raqfuM
         WPckXzdhZmIU1EIrA+wpky4GkOiHTE8Ojy6CXjJlapT1DYLZb7azoLpeHR2vrkCWbk
         EXsjpSNA+GA77+oXVrjI7T5WDL6L06rCKhQz9Y73BJrSlJ8xL0+SYegW8WZmDhZGAG
         kbIvhgnvSaTCMhGr371gR2r2yRl0VlJn1Ahg+jGyPGMPGt3G+2RvyA93oCuv3xQc/F
         aZ/GEIz2Izt2wM0U60VMQ2aaMEzWXTPjfoa5jdigfgpHeD9UaAmRF4WSEmWXHbbS3z
         EA0DeL5w6YpWA==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2af2602848aso10547341fa.2;
        Thu, 01 Jun 2023 05:23:32 -0700 (PDT)
X-Gm-Message-State: AC+VfDx9B59Mv8gtkuFha3zRgpvVrkTR7leDF+yg7Ig0VtdsOhK1JSWC
        CyEW6DIy5c6xuG1MZRHJi7TavGSALB4h+VW1cZA=
X-Google-Smtp-Source: ACHHUZ6cRMYPOSYQUWlSFAarfHRT7foXMycSC83wIP43hL55JTKrs8FD2Z85rJEK0bkTYAPwv+KAdLUD8wIqNXWlHvw=
X-Received: by 2002:a2e:9e04:0:b0:2a8:bce4:c70f with SMTP id
 e4-20020a2e9e04000000b002a8bce4c70fmr4452754ljk.26.1685622210654; Thu, 01 Jun
 2023 05:23:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230601121001.1071533-1-masahiroy@kernel.org> <20230601121001.1071533-6-masahiroy@kernel.org>
In-Reply-To: <20230601121001.1071533-6-masahiroy@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 1 Jun 2023 14:23:19 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHuasyDeAvs6ZX3wR155uiVOZUO0-VbVpTQq9+v=WE5Sw@mail.gmail.com>
Message-ID: <CAMj1kXHuasyDeAvs6ZX3wR155uiVOZUO0-VbVpTQq9+v=WE5Sw@mail.gmail.com>
Subject: Re: [PATCH 5/7] modpost: detect section mismatch for R_ARM_THM_{MOVW_ABS_NC,MOVT_ABS}
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 14:10, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> When CONFIG_THUMB2_KERNEL is enabled, modpost fails to detect some
> types of section mismatches.
>
>   [test code]
>
>     #include <linux/init.h>
>
>     int __initdata foo;
>     int get_foo(void) { return foo; }
>
> It is apparently a bad reference, but modpost does not report anything.
>
> The test code above produces the following relocations.
>
>   Relocation section '.rel.text' at offset 0x1e8 contains 2 entries:
>    Offset     Info    Type            Sym.Value  Sym. Name
>   00000000  0000052f R_ARM_THM_MOVW_AB 00000000   .LANCHOR0
>   00000004  00000530 R_ARM_THM_MOVT_AB 00000000   .LANCHOR0
>
> Currently, R_ARM_THM_MOVW_ABS_NC and R_ARM_THM_MOVT_ABS are just skipped.
>
> Add code to handle them. I checked arch/arm/kernel/module.c to learn
> how the offset is encoded in the instruction.
>
> One more thing to note for Thumb instructions - the st_value is an odd
> value, so you need to mask the bit 0 to get the offset. Otherwise, you
> will get an off-by-one error in the nearest symbol look-up.
>
> It is documented in "ELF for the ARM Architecture" [1]:
>
>   * If the symbol addresses a Thumb instruction, its value is the address
>     of the instruction with bit zero set (in a relocatable object, the
>     section offset with bit zero set).
>
>   * For the purposes of relocation the value used shall be the address
>     of the instruction (st_value & ~1).
>
> [1]: https://github.com/ARM-software/abi-aa/blob/main/aaelf32/aaelf32.rst
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  scripts/mod/modpost.c | 31 ++++++++++++++++++++++++++-----
>  1 file changed, 26 insertions(+), 5 deletions(-)
>
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 32d56efe3f3b..528aa9175e84 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -1082,7 +1082,8 @@ static Elf_Sym *find_nearest_sym(struct elf_info *elf, Elf_Addr addr,
>  {
>         Elf_Sym *sym;
>         Elf_Sym *near = NULL;
> -       Elf_Addr distance;
> +       Elf_Addr sym_addr, distance;
> +       bool is_arm = (elf->hdr->e_machine == EM_ARM);
>
>         for (sym = elf->symtab_start; sym < elf->symtab_stop; sym++) {
>                 if (get_secindex(elf, sym) != secndx)
> @@ -1090,10 +1091,19 @@ static Elf_Sym *find_nearest_sym(struct elf_info *elf, Elf_Addr addr,
>                 if (!is_valid_name(elf, sym))
>                         continue;
>
> -               if (addr >= sym->st_value)
> -                       distance = addr - sym->st_value;
> +               sym_addr = sym->st_value;
> +
> +               /*
> +                * For ARM Thumb instruction, the bit 0 of st_value is set.
> +                * Mask it to get the address.
> +                */
> +               if (is_arm)
> +                        sym_addr &= ~1;
> +

This is only appropriate for STT_FUNC symbols. If this is a data
reference, bit 0 could be a valid address bit.



> +               if (addr >= sym_addr)
> +                       distance = addr - sym_addr;
>                 else if (allow_negative)
> -                       distance = sym->st_value - addr;
> +                       distance = sym_addr - addr;
>                 else
>                         continue;
>
> @@ -1266,7 +1276,7 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
>         unsigned int r_typ = ELF_R_TYPE(r->r_info);
>         Elf_Sym *sym = elf->symtab_start + ELF_R_SYM(r->r_info);
>         void *loc = reloc_location(elf, sechdr, r);
> -       uint32_t inst;
> +       uint32_t inst, upper, lower;
>         int32_t offset;
>
>         switch (r_typ) {
> @@ -1288,6 +1298,17 @@ static int addend_arm_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
>                 offset = sign_extend32((inst & 0x00ffffff) << 2, 25);
>                 r->r_addend = offset + sym->st_value + 8;
>                 break;
> +       case R_ARM_THM_MOVW_ABS_NC:
> +       case R_ARM_THM_MOVT_ABS:
> +               upper = TO_NATIVE(*(uint16_t *)loc);
> +               lower = TO_NATIVE(*((uint16_t *)loc + 1));
> +               offset = sign_extend32(((upper & 0x000f) << 12) |
> +                                      ((upper & 0x0400) << 1) |
> +                                      ((lower & 0x7000) >> 4) |
> +                                      (lower & 0x00ff),
> +                                      15);
> +               r->r_addend = offset + sym->st_value;
> +               break;
>         case R_ARM_THM_CALL:
>         case R_ARM_THM_JUMP24:
>         case R_ARM_THM_JUMP19:
> --
> 2.39.2
>
