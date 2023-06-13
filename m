Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9090E72D741
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 04:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjFMCJe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 22:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbjFMCJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 22:09:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C27DE55
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:09:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 954ED6205B
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:09:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0027C433A0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 02:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686622171;
        bh=5jMasUcRGtKMRcksEQfarzznOMv96OlnUXa2z8TxMtU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p61WQd5BJREVxnVQq/IW0Qa+gdnYNcg0ScvPA2LckA6Pv2Ie93/HkMuAeKd3Pd6OT
         qtMaMaxpLcokfPK8Eb2rk2mfFxv0RnBDtfWH560+eSlur0lVpniEdJjPOhpyNKnLEj
         /A4/IQwnDVJ2gED7Yht1G5TdHtL6RJ6qOaDKBBerKfupKfIrd9ngXivUJwCLq09uOb
         8yt9AHbJJinq4rH32yKhF6iPZ69orShYhEsxb8W9tfWsDbnjNern3AyAT///OWqwl7
         hmpuzJqS1XJP9LkjIEDomI5QSGjeR/2TF5k1gz3Nt8Vh0As+e6gVHDNkOe8LAUXJim
         sEx+JzpX//f9w==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51492ae66a4so7072957a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:09:30 -0700 (PDT)
X-Gm-Message-State: AC+VfDwg2+6ASK+6GPrCi41xQFJwnhpZ6WResAjDa4XVd2KPjzExxl2J
        RRgP1FCQ9xfpjsFQkyApzXOJ6Jv0DcWgmuG4Wa8=
X-Google-Smtp-Source: ACHHUZ732HpwWcWPyqyG9PFZw/DQfZXyhiA9xZUnswqIMR/ioJOuyvd2tzF6iMpcK/nugLbRdgaAn5IbSMr7k8b1JZw=
X-Received: by 2002:a05:6402:31f3:b0:514:9eae:b0a7 with SMTP id
 dy19-20020a05640231f300b005149eaeb0a7mr5179396edb.17.1686622169051; Mon, 12
 Jun 2023 19:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <63c16a5a-ea60-6607-a4ff-23ad9d47cd73@loongson.cn> <20230613011439.59168-1-jianghaoran@kylinos.cn>
In-Reply-To: <20230613011439.59168-1-jianghaoran@kylinos.cn>
From:   Huacai Chen <chenhuacai@kernel.org>
Date:   Tue, 13 Jun 2023 10:09:16 +0800
X-Gmail-Original-Message-ID: <CAAhV-H600pPCTEHzuMiiFRyKcgxq7ZGvaFMUv9pOeVE1xbYQ3A@mail.gmail.com>
Message-ID: <CAAhV-H600pPCTEHzuMiiFRyKcgxq7ZGvaFMUv9pOeVE1xbYQ3A@mail.gmail.com>
Subject: Re: [PATCH v2] LoongArch/rethook: Replace kretprobe with rethook on loongarch
To:     jianghaoran <jianghaoran@kylinos.cn>
Cc:     yangtiezhu@loongson.cn, conor.dooley@microchip.com,
        hejinyang@loongson.cn, jhrhhao@163.com, kernel@xen0n.name,
        l3b2w1@gmail.com, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, masahiroy@kernel.org,
        mhiramat@kernel.org, palmer@rivosinc.com, tangyouling@loongson.cn,
        zhangqing@loongson.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Haoran,

On Tue, Jun 13, 2023 at 9:20=E2=80=AFAM jianghaoran <jianghaoran@kylinos.cn=
> wrote:
>
> That's an adaptation of commit f3a112c0c40d ("x86,rethook,kprobes:
> Replace kretprobe with rethook on x86")and commit b57c2f124098
> ("riscv: add riscv rethook implementation") to loongarch.
> Mainly refer to this commit b57c2f124098.
>
> Replaces the kretprobe code with rethook on loongarch. With this patch,
> kretprobe on loongarch uses the rethook instead of kretprobe specific
> trampoline code.
Use LoongArch rather than loongarch in comments and commit messages.

>
> Signed-off-by: Haoran Jiang<jianghaoran@kylinos.cn>
The format is Haoran Jiang <jianghaoran@kylinos.cn>, pay attention to the s=
pace.

> ---
> v2:
> Modified the patch format and commit message.
> ---
>  arch/loongarch/Kconfig                        |  1 +
>  arch/loongarch/include/asm/kprobes.h          |  3 ---
>  arch/loongarch/kernel/Makefile                |  3 ++-
>  arch/loongarch/kernel/kprobes.c               | 20 --------------
>  arch/loongarch/kernel/rethook.c               | 27 +++++++++++++++++++
>  arch/loongarch/kernel/rethook.h               |  8 ++++++
>  ...obes_trampoline.S =3D> rethook_trampoline.S} |  6 ++---
>  7 files changed, 41 insertions(+), 27 deletions(-)
>  create mode 100644 arch/loongarch/kernel/rethook.c
>  create mode 100644 arch/loongarch/kernel/rethook.h
>  rename arch/loongarch/kernel/{kprobes_trampoline.S =3D> rethook_trampoli=
ne.S} (93%)
>
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index d38b066fc931..33753a1ab0bb 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -113,6 +113,7 @@ config LOONGARCH
>         select HAVE_KPROBES
>         select HAVE_KPROBES_ON_FTRACE
>         select HAVE_KRETPROBES
> +       select HAVE_RETHOOK
>         select HAVE_MOD_ARCH_SPECIFIC
>         select HAVE_NMI
>         select HAVE_PCI
Use alpha-betical order for these symbols, though x86 and riscv don't
do this, s390 does.

> diff --git a/arch/loongarch/include/asm/kprobes.h b/arch/loongarch/includ=
e/asm/kprobes.h
> index 798020ae02c6..7b9fc3ed71c3 100644
> --- a/arch/loongarch/include/asm/kprobes.h
> +++ b/arch/loongarch/include/asm/kprobes.h
> @@ -49,9 +49,6 @@ bool kprobe_fault_handler(struct pt_regs *regs, int tra=
pnr);
>  bool kprobe_breakpoint_handler(struct pt_regs *regs);
>  bool kprobe_singlestep_handler(struct pt_regs *regs);
>
> -void __kretprobe_trampoline(void);
> -void *trampoline_probe_handler(struct pt_regs *regs);
> -
>  #else /* !CONFIG_KPROBES */
>
>  static inline bool kprobe_breakpoint_handler(struct pt_regs *regs) { ret=
urn false; }
> diff --git a/arch/loongarch/kernel/Makefile b/arch/loongarch/kernel/Makef=
ile
> index 9a72d91cd104..e0d4d29a6f0f 100644
> --- a/arch/loongarch/kernel/Makefile
> +++ b/arch/loongarch/kernel/Makefile
> @@ -52,6 +52,7 @@ obj-$(CONFIG_UNWINDER_PROLOGUE) +=3D unwind_prologue.o
>  obj-$(CONFIG_PERF_EVENTS)      +=3D perf_event.o perf_regs.o
>  obj-$(CONFIG_HAVE_HW_BREAKPOINT)       +=3D hw_breakpoint.o
>
> -obj-$(CONFIG_KPROBES)          +=3D kprobes.o kprobes_trampoline.o
> +obj-$(CONFIG_KPROBES)          +=3D kprobes.o
> +obj-$(CONFIG_RETHOOK)          +=3D rethook.o rethook_trampoline.o
>
>  CPPFLAGS_vmlinux.lds           :=3D $(KBUILD_CFLAGS)
Please see commit 571a2a50a8fc546145ffd3bf673547e9 ("rethook, fprobe:
do not trace rethook related functions"), maybe we need to do some
additional modifications in Makefile.

> diff --git a/arch/loongarch/kernel/kprobes.c b/arch/loongarch/kernel/kpro=
bes.c
> index 56c8c4b09a42..dbce23ba9970 100644
> --- a/arch/loongarch/kernel/kprobes.c
> +++ b/arch/loongarch/kernel/kprobes.c
> @@ -378,26 +378,6 @@ int __init arch_init_kprobes(void)
>         return 0;
>  }
>
> -/* ASM function that handles the kretprobes must not be probed */
> -NOKPROBE_SYMBOL(__kretprobe_trampoline);
> -
> -/* Called from __kretprobe_trampoline */
> -void __used *trampoline_probe_handler(struct pt_regs *regs)
> -{
> -       return (void *)kretprobe_trampoline_handler(regs, NULL);
> -}
> -NOKPROBE_SYMBOL(trampoline_probe_handler);
> -
> -void arch_prepare_kretprobe(struct kretprobe_instance *ri,
> -                           struct pt_regs *regs)
> -{
> -       ri->ret_addr =3D (kprobe_opcode_t *)regs->regs[1];
> -       ri->fp =3D NULL;
> -
> -       /* Replace the return addr with trampoline addr */
> -       regs->regs[1] =3D (unsigned long)&__kretprobe_trampoline;
> -}
> -NOKPROBE_SYMBOL(arch_prepare_kretprobe);
>
>  int arch_trampoline_kprobe(struct kprobe *p)
>  {
> diff --git a/arch/loongarch/kernel/rethook.c b/arch/loongarch/kernel/reth=
ook.c
> new file mode 100644
> index 000000000000..ac97b78daf55
> --- /dev/null
> +++ b/arch/loongarch/kernel/rethook.c
> @@ -0,0 +1,27 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Generic return hook for loongarch.
Use LoongArch here.

> + */
> +
> +#include <linux/kprobes.h>
> +#include <linux/rethook.h>
> +#include "rethook.h"
> +
> +/* This is called from arch_rethook_trampoline() */
> +unsigned long __used arch_rethook_trampoline_callback(struct pt_regs *re=
gs)
> +{
> +       return rethook_trampoline_handler(regs, 0);
> +}
> +
> +NOKPROBE_SYMBOL(arch_rethook_trampoline_callback);
> +
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs=
, bool mcount)
> +{
> +       rhn->ret_addr =3D regs->regs[1];
> +       rhn->frame =3D 0;
> +
> +       /* replace return addr with trampoline */
> +       regs->regs[1] =3D (unsigned long)arch_rethook_trampoline;
> +}
Whether the logic is correct here needs Tiezhu's review.

Thanks,
Huacai

> +
> +NOKPROBE_SYMBOL(arch_rethook_prepare);
> diff --git a/arch/loongarch/kernel/rethook.h b/arch/loongarch/kernel/reth=
ook.h
> new file mode 100644
> index 000000000000..3f1c1edf0d0b
> --- /dev/null
> +++ b/arch/loongarch/kernel/rethook.h
> @@ -0,0 +1,8 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LOONGARCH_RETHOOK_H
> +#define __LOONGARCH_RETHOOK_H
> +
> +unsigned long arch_rethook_trampoline_callback(struct pt_regs *regs);
> +void arch_rethook_prepare(struct rethook_node *rhn, struct pt_regs *regs=
, bool mcount);
> +
> +#endif
> diff --git a/arch/loongarch/kernel/kprobes_trampoline.S b/arch/loongarch/=
kernel/rethook_trampoline.S
> similarity index 93%
> rename from arch/loongarch/kernel/kprobes_trampoline.S
> rename to arch/loongarch/kernel/rethook_trampoline.S
> index af94b0d213fa..bd5772c96338 100644
> --- a/arch/loongarch/kernel/kprobes_trampoline.S
> +++ b/arch/loongarch/kernel/rethook_trampoline.S
> @@ -75,7 +75,7 @@
>         csrxchg t0, t1, LOONGARCH_CSR_CRMD
>         .endm
>
> -SYM_CODE_START(__kretprobe_trampoline)
> +SYM_CODE_START(arch_rethook_trampoline)
>         addi.d  sp, sp, -PT_SIZE
>         save_all_base_regs
>
> @@ -84,7 +84,7 @@ SYM_CODE_START(__kretprobe_trampoline)
>
>         move a0, sp /* pt_regs */
>
> -       bl trampoline_probe_handler
> +       bl arch_rethook_trampoline_callback
>
>         /* use the result as the return-address */
>         move ra, a0
> @@ -93,4 +93,4 @@ SYM_CODE_START(__kretprobe_trampoline)
>         addi.d  sp, sp, PT_SIZE
>
>         jr ra
> -SYM_CODE_END(__kretprobe_trampoline)
> +SYM_CODE_END(arch_rethook_trampoline)
> --
> 2.27.0
>
