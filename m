Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE026F1DE3
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 20:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345909AbjD1SRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 14:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbjD1SRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 14:17:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD2219B2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:17:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 895EE6448B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE649C433EF
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 18:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682705827;
        bh=r4gxstm7LnhfYNM52ZSXmFsL1V9td4s4GASPsOIzhys=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ILMs/IuKUMb1TWgguR2KUhzReL3jwHlgYN6F+yh7NHJGvrH5cj68M0b1Oqvzx9xxn
         ZsNAEmaf7UgbMTuR+9iwFkTD/pJd8K+CP9Iey19CEyosUdL4CFpJvwPB4s6KWGevjF
         veeGpetGoBSppyLg+/RwqV/d450+WwWKcbLRyl0fyRoh0uDIzYAq8cgvA15LuzPcAI
         WAbtenzZrUH7eAMEKcgdGvLPQbzqtsQlLQRnxDmn+HW35q1KzCgrJ+0JlXGGwcDR4m
         h1nxS53LtwJo3M+Ein3X8KbDOWdnj+9+vMfrE3v0jcWKdd/EEGwNXuFxFLo+6MCx7n
         16sSDgVLd4h2w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2a8aea0c7dcso14931fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 11:17:07 -0700 (PDT)
X-Gm-Message-State: AC+VfDxaAEzKkp6StQTP6HuUX8wjfyVuhFDGbe+9R+5yM9umwska/gpn
        sXnVz7xRPVaOhDd4VNHYC3xjNZxAFnLufL52flE=
X-Google-Smtp-Source: ACHHUZ6F6PlgD+8fz6GQDx/MiJAOCHBYUSbAc4pVhLd5ME0rAcFp0He+DjOM2njdIXfxwRwF2yBPoiy7xM4OBH/Fhdc=
X-Received: by 2002:ac2:5307:0:b0:4ed:d629:8d26 with SMTP id
 c7-20020ac25307000000b004edd6298d26mr1638925lfh.10.1682705825915; Fri, 28 Apr
 2023 11:17:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230428-awx-v1-1-1f490286ba62@google.com>
In-Reply-To: <20230428-awx-v1-1-1f490286ba62@google.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Apr 2023 19:16:55 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHskJLA7yfy1j4rLYPjscK6bsW0CGjmhpNYg5fuirwinA@mail.gmail.com>
Message-ID: <CAMj1kXHskJLA7yfy1j4rLYPjscK6bsW0CGjmhpNYg5fuirwinA@mail.gmail.com>
Subject: Re: [PATCH] arm64: kernel: remove SHF_WRITE|SHF_EXECINSTR from .idmap.text
To:     ndesaulniers@google.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        Fangrui Song <maskray@google.com>,
        Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nick,

On Fri, 28 Apr 2023 at 19:09, <ndesaulniers@google.com> wrote:
>
> commit d54170812ef1 ("arm64: fix .idmap.text assertion for large kernels")
> modified some of the section assembler directives that declare
> .idmap.text to be SHF_ALLOC instead of
> SHF_ALLOC|SHF_WRITE|SHF_EXECINSTR.
>
> This patch fixes up the remaining stragglers that were left behind.
>
> Because .idmap.text is merged into .text,

Nit: this is no longer the case: the ID map code is never executed via
the kernel mapping, so we moved it into a special .rodata.text section
that contains all generated code that should not have an executable
mapping by default, but only when it gets copied and/or mapped into a
different executable region.

This doesn't impact the correctness of the patch, so with this
paragraph clarified:

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>


> LLD will retain the
> SHF_EXECINSTR on .text, in addition to the synthetic .got.  This doesn't
> matter to the kernel loader, but syzkaller is having trouble symboling
> such sections. Clean this up while we additionally fix up syzkaller. Add
> Fixes tag so that this doesn't precede related change in stable.
>
> Fixes: d54170812ef1 ("arm64: fix .idmap.text assertion for large kernels")
> Reported-by: Greg Thelen <gthelen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
>  arch/arm64/kernel/cpu-reset.S | 2 +-
>  arch/arm64/kernel/sleep.S     | 2 +-
>  arch/arm64/mm/proc.S          | 6 +++---
>  3 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/cpu-reset.S b/arch/arm64/kernel/cpu-reset.S
> index 6b752fe89745..c87445dde674 100644
> --- a/arch/arm64/kernel/cpu-reset.S
> +++ b/arch/arm64/kernel/cpu-reset.S
> @@ -14,7 +14,7 @@
>  #include <asm/virt.h>
>
>  .text
> -.pushsection    .idmap.text, "awx"
> +.pushsection    .idmap.text, "a"
>
>  /*
>   * cpu_soft_restart(el2_switch, entry, arg0, arg1, arg2)
> diff --git a/arch/arm64/kernel/sleep.S b/arch/arm64/kernel/sleep.S
> index 2ae7cff1953a..2aa5129d8253 100644
> --- a/arch/arm64/kernel/sleep.S
> +++ b/arch/arm64/kernel/sleep.S
> @@ -97,7 +97,7 @@ SYM_FUNC_START(__cpu_suspend_enter)
>         ret
>  SYM_FUNC_END(__cpu_suspend_enter)
>
> -       .pushsection ".idmap.text", "awx"
> +       .pushsection ".idmap.text", "a"
>  SYM_CODE_START(cpu_resume)
>         mov     x0, xzr
>         bl      init_kernel_el
> diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
> index 91410f488090..c2cb437821ca 100644
> --- a/arch/arm64/mm/proc.S
> +++ b/arch/arm64/mm/proc.S
> @@ -167,7 +167,7 @@ alternative_else_nop_endif
>  SYM_FUNC_END(cpu_do_resume)
>  #endif
>
> -       .pushsection ".idmap.text", "awx"
> +       .pushsection ".idmap.text", "a"
>
>  .macro __idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
>         adrp    \tmp1, reserved_pg_dir
> @@ -201,7 +201,7 @@ SYM_FUNC_END(idmap_cpu_replace_ttbr1)
>
>  #define KPTI_NG_PTE_FLAGS      (PTE_ATTRINDX(MT_NORMAL) | SWAPPER_PTE_FLAGS)
>
> -       .pushsection ".idmap.text", "awx"
> +       .pushsection ".idmap.text", "a"
>
>         .macro  kpti_mk_tbl_ng, type, num_entries
>         add     end_\type\()p, cur_\type\()p, #\num_entries * 8
> @@ -400,7 +400,7 @@ SYM_FUNC_END(idmap_kpti_install_ng_mappings)
>   * Output:
>   *     Return in x0 the value of the SCTLR_EL1 register.
>   */
> -       .pushsection ".idmap.text", "awx"
> +       .pushsection ".idmap.text", "a"
>  SYM_FUNC_START(__cpu_setup)
>         tlbi    vmalle1                         // Invalidate local TLB
>         dsb     nsh
>
> ---
> base-commit: 22b8cc3e78f5448b4c5df00303817a9137cd663f
> change-id: 20230428-awx-c73f4bde79c4
>
> Best regards,
> --
> Nick Desaulniers <ndesaulniers@google.com>
>
