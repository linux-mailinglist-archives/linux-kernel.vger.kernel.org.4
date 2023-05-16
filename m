Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67EBA704330
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 04:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjEPCBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 22:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjEPCBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 22:01:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED2713A91;
        Mon, 15 May 2023 19:01:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F9F463408;
        Tue, 16 May 2023 02:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4B1DC433A0;
        Tue, 16 May 2023 02:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684202491;
        bh=T2CH5jcEZ50auWMm9WlAERi13fZH34cVW0QQ55u3B1c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QYBV8uK05eipDy5EOb/FG+aKmAIuGJuZOBw6Ska1SmTfZiZU5WIOYPBNzr2ORGBmS
         kAnUtES8TlXc9i0JlRXGO8QPnDcDr4BHJKIaoUbpG7PBaVjdfcrXMbigf2atBDhNvX
         SY10wMbrj7hWNLzWoX+N1vZbKZArzmHKn81UmmlLBxVGyoYcxhjVoza81h2p1pA2KM
         rjiMdn8KUMQFAzlCO/Aj6BVbCYXFnRlqzU/W9ihgknbH+hznsX2/OKNWgtAT5/8zkK
         2ty9py1a9mro5bSA125FcbTG5zBU8NFrimGohmp21nQoCqRd6xe1wK5IQGrroZyte9
         CvMWtW3O6tOnQ==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-50bc37e1525so24977531a12.1;
        Mon, 15 May 2023 19:01:31 -0700 (PDT)
X-Gm-Message-State: AC+VfDxPsFvrRAHNHAlMGvLa5+cI/p3tWEFNeQPkWEycrT5UsDJOYUUr
        GA0UcNxmHnniFFif7wA/Zo5FNcanLfLrjZ0SubY=
X-Google-Smtp-Source: ACHHUZ6dgbB/xaSvvgnJkKxDy3hlVfrT9ojYrxmb8jMg0x1u/fS5lK20Eg9fSgXweC7x1BMbB5N2zEbZ0SdmmUxuiL8=
X-Received: by 2002:a17:907:7214:b0:96a:c661:fa1 with SMTP id
 dr20-20020a170907721400b0096ac6610fa1mr10638554ejc.46.1684202489967; Mon, 15
 May 2023 19:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <1684118574-7572-1-git-send-email-tangyouling@loongson.cn>
In-Reply-To: <1684118574-7572-1-git-send-email-tangyouling@loongson.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 16 May 2023 10:01:18 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5QJQ2fcB5urye4Ffcbeynmjy7qN9qW=d0-Av2QhzpbxA@mail.gmail.com>
Message-ID: <CAAhV-H5QJQ2fcB5urye4Ffcbeynmjy7qN9qW=d0-Av2QhzpbxA@mail.gmail.com>
Subject: Re: [PATCH v3] LoongArch: Add jump-label implementation
To:     Youling Tang <tangyouling@loongson.cn>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Jason Baron <jbaron@akamai.com>,
        WANG Xuerui <kernel@xen0n.name>,
        Zhangjin Wu <falcon@tinylab.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Queued, thanks.

Huacai

On Mon, May 15, 2023 at 10:43=E2=80=AFAM Youling Tang <tangyouling@loongson=
.cn> wrote:
>
> Add support for jump labels based on the ARM64 version.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Youling Tang <tangyouling@loongson.cn>
> ---
> Changes in v3:
> - Define the JUMP_TABLE_ENTRY macro so that arch_static_branch
>   and arch_static_branch_jump can be shared.
> - Modify commit message.
>
> Changes in v2:
> - Fix build errors.
> - fix comment.
>
>  .../core/jump-labels/arch-support.txt         |  2 +-
>  arch/loongarch/Kconfig                        |  2 +
>  arch/loongarch/configs/loongson3_defconfig    |  1 +
>  arch/loongarch/include/asm/jump_label.h       | 50 +++++++++++++++++++
>  arch/loongarch/kernel/Makefile                |  2 +
>  arch/loongarch/kernel/jump_label.c            | 23 +++++++++
>  6 files changed, 79 insertions(+), 1 deletion(-)
>  create mode 100644 arch/loongarch/include/asm/jump_label.h
>  create mode 100644 arch/loongarch/kernel/jump_label.c
>
> diff --git a/Documentation/features/core/jump-labels/arch-support.txt b/D=
ocumentation/features/core/jump-labels/arch-support.txt
> index 2328eada3a49..94d9dece580f 100644
> --- a/Documentation/features/core/jump-labels/arch-support.txt
> +++ b/Documentation/features/core/jump-labels/arch-support.txt
> @@ -13,7 +13,7 @@
>      |        csky: |  ok  |
>      |     hexagon: | TODO |
>      |        ia64: | TODO |
> -    |   loongarch: | TODO |
> +    |   loongarch: |  ok  |
>      |        m68k: | TODO |
>      |  microblaze: | TODO |
>      |        mips: |  ok  |
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066fc931..193a959a5611 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -83,6 +83,8 @@ config LOONGARCH
>         select GPIOLIB
>         select HAS_IOPORT
>         select HAVE_ARCH_AUDITSYSCALL
> +       select HAVE_ARCH_JUMP_LABEL
> +       select HAVE_ARCH_JUMP_LABEL_RELATIVE
>         select HAVE_ARCH_MMAP_RND_BITS if MMU
>         select HAVE_ARCH_SECCOMP_FILTER
>         select HAVE_ARCH_TRACEHOOK
> diff --git a/arch/loongarch/configs/loongson3_defconfig b/arch/loongarch/=
configs/loongson3_defconfig
> index 6cd26dd3c134..33a0f5f742f6 100644
> --- a/arch/loongarch/configs/loongson3_defconfig
> +++ b/arch/loongarch/configs/loongson3_defconfig
> @@ -63,6 +63,7 @@ CONFIG_EFI_ZBOOT=3Dy
>  CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=3Dy
>  CONFIG_EFI_CAPSULE_LOADER=3Dm
>  CONFIG_EFI_TEST=3Dm
> +CONFIG_JUMP_LABEL=3Dy
>  CONFIG_MODULES=3Dy
>  CONFIG_MODULE_FORCE_LOAD=3Dy
>  CONFIG_MODULE_UNLOAD=3Dy
> diff --git a/arch/loongarch/include/asm/jump_label.h b/arch/loongarch/inc=
lude/asm/jump_label.h
> new file mode 100644
> index 000000000000..4d8cbd5a8221
> --- /dev/null
> +++ b/arch/loongarch/include/asm/jump_label.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + *
> + * Based on arch/arm64/include/asm/jump_label.h
> + */
> +#ifndef __ASM_JUMP_LABEL_H
> +#define __ASM_JUMP_LABEL_H
> +
> +#ifndef __ASSEMBLY__
> +
> +#include <linux/types.h>
> +
> +#define JUMP_LABEL_NOP_SIZE    4
> +
> +#define JUMP_TABLE_ENTRY                               \
> +        ".pushsection  __jump_table, \"aw\"    \n\t"   \
> +        ".align        3                       \n\t"   \
> +        ".long         1b - ., %l[l_yes] - .   \n\t"   \
> +        ".quad         %0 - .                  \n\t"   \
> +        ".popsection                           \n\t"
> +
> +static __always_inline bool arch_static_branch(struct static_key * const=
 key,
> +                                              const bool branch)
> +{
> +       asm_volatile_goto(
> +               "1:     nop                     \n\t"
> +               JUMP_TABLE_ENTRY
> +               :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +
> +       return false;
> +l_yes:
> +       return true;
> +}
> +
> +static __always_inline bool arch_static_branch_jump(struct static_key * =
const key,
> +                                                   const bool branch)
> +{
> +       asm_volatile_goto(
> +               "1:     b       %l[l_yes]       \n\t"
> +               JUMP_TABLE_ENTRY
> +               :  :  "i"(&((char *)key)[branch]) :  : l_yes);
> +
> +       return false;
> +l_yes:
> +       return true;
> +}
> +
> +#endif  /* __ASSEMBLY__ */
> +#endif /* __ASM_JUMP_LABEL_H */
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 9a72d91cd104..64ea76f60e2c 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -54,4 +54,6 @@ obj-$(CONFIG_HAVE_HW_BREAKPOINT)      +=3D hw_breakpoin=
t.o
>
>  obj-$(CONFIG_KPROBES)          +=3D kprobes.o kprobes_trampoline.o
>
> +obj-$(CONFIG_JUMP_LABEL)       +=3D jump_label.o
> +
>  CPPFLAGS_vmlinux.lds           :=3D $(KBUILD_CFLAGS)
> diff --git a/arch/loongarch/kernel/jump_label.c b/arch/loongarch/kernel/j=
ump_label.c
> new file mode 100644
> index 000000000000..b06245955f7a
> --- /dev/null
> +++ b/arch/loongarch/kernel/jump_label.c
> @@ -0,0 +1,23 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2023 Loongson Technology Corporation Limited
> + *
> + * Based on arch/arm64/kernel/jump_label.c
> + */
> +#include <linux/jump_label.h>
> +#include <linux/kernel.h>
> +#include <asm/inst.h>
> +
> +void arch_jump_label_transform(struct jump_entry *entry,
> +                              enum jump_label_type type)
> +{
> +       void *addr =3D (void *)jump_entry_code(entry);
> +       u32 insn;
> +
> +       if (type =3D=3D JUMP_LABEL_JMP)
> +               insn =3D larch_insn_gen_b(jump_entry_code(entry), jump_en=
try_target(entry));
> +       else
> +               insn =3D larch_insn_gen_nop();
> +
> +       larch_insn_patch_text(addr, insn);
> +}
> --
> 2.37.1
>
>
