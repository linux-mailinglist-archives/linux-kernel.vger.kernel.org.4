Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AF06897CA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 12:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjBCLfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 06:35:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbjBCLe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 06:34:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7313A2915F;
        Fri,  3 Feb 2023 03:34:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06A06B82976;
        Fri,  3 Feb 2023 11:34:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAA49C433A0;
        Fri,  3 Feb 2023 11:34:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675424092;
        bh=VpWs6A9sli4gfwZ9V+w1/JT672l+cta8shndqw50dv0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uzjp6kp6nMapuPqjf2Jn12cCP46uKBuAZNwMAYFS2W6tQruA6fyWdS7f14ek/WuU7
         Wq7xt+oqmmiMemptJqOGQUurapPzNTwZjHha4jXGFVDcDmVf9lFhZSLauA6Sxba0RU
         9Bzulgy3PdAxBxKQwMYwngoJ/a8FsR/ATOPfA4lCJFUFxpHMYx3PMK4yJM5tnukw+u
         6XNl+bre3QEktbrqlnX1ElvJpWaHmqKyIxD1Nq0nENlunAiYSqaydSgk2C9qs0TWjK
         m4Jg9uBGwmIVIFt1oX0gs9lwSUsGzeO+yHeiDFpznnjG+AWuIkQrSS6nCMdRbsm29/
         PseTUgXxVcNrQ==
Received: by mail-lj1-f169.google.com with SMTP id o5so4974862ljj.1;
        Fri, 03 Feb 2023 03:34:52 -0800 (PST)
X-Gm-Message-State: AO0yUKUsZcnf6Q3noyKrlwbx9TsghzmX0Nu0mTAd80tQH+1Vm+874o5x
        0kNdYiI8GpvL3XRlsDYC3syaUTBtr22BhODkf7U=
X-Google-Smtp-Source: AK7set9biPUl8JeaqYccsJFtgvyH4AlRPSbwkHxkeWaJYoPjrQx38kl3rGhe1WRFAi0uBp6sjgi8cuJALhsc8hJQZ9U=
X-Received: by 2002:a2e:5448:0:b0:290:50e9:4b21 with SMTP id
 y8-20020a2e5448000000b0029050e94b21mr1265898ljd.178.1675424090681; Fri, 03
 Feb 2023 03:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20230202223653.never.473-kees@kernel.org>
In-Reply-To: <20230202223653.never.473-kees@kernel.org>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 3 Feb 2023 12:34:38 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHa=jD_YNxymjd8zQo2_QHgh104RcmCY3gZs3rp24X_Zg@mail.gmail.com>
Message-ID: <CAMj1kXHa=jD_YNxymjd8zQo2_QHgh104RcmCY3gZs3rp24X_Zg@mail.gmail.com>
Subject: Re: [PATCH] arm64: Support Clang UBSAN trap codes for better reporting
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Alexander Potapenko <glider@google.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Feb 2023 at 23:37, Kees Cook <keescook@chromium.org> wrote:
>
> On arm64, Clang encodes the UBSAN check type in the esr. Extract this
> and actually report UBSAN traps with some specificity when building with
> CONFIG_UBSAN_TRAP. Before:
>
>   Internal error: BRK handler: 00000000f20003e8 [#1] PREEMPT SMP
>
> After:
>
>   Internal error: UBSAN: shift out of bounds: 00000000f2005514 [#1] PREEMPT SMP
>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: John Stultz <jstultz@google.com>
> Cc: Yongqin Liu <yongqin.liu@linaro.org>
> Cc: Sami Tolvanen <samitolvanen@google.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Marco Elver <elver@google.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: llvm@lists.linux.dev
> Signed-off-by: Kees Cook <keescook@chromium.org>

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>

One nit below

> ---
>  arch/arm64/include/asm/brk-imm.h |  2 ++
>  arch/arm64/kernel/traps.c        | 21 +++++++++++++
>  include/linux/ubsan.h            |  9 ++++++
>  lib/Makefile                     |  2 --
>  lib/ubsan.c                      | 54 ++++++++++++++++++++++++++++++++
>  lib/ubsan.h                      | 28 +++++++++++++++++
>  6 files changed, 114 insertions(+), 2 deletions(-)
>  create mode 100644 include/linux/ubsan.h
>
> diff --git a/arch/arm64/include/asm/brk-imm.h b/arch/arm64/include/asm/brk-imm.h
> index 6e000113e508..3f0f0d03268b 100644
> --- a/arch/arm64/include/asm/brk-imm.h
> +++ b/arch/arm64/include/asm/brk-imm.h
> @@ -28,6 +28,8 @@
>  #define BUG_BRK_IMM                    0x800
>  #define KASAN_BRK_IMM                  0x900
>  #define KASAN_BRK_MASK                 0x0ff
> +#define UBSAN_BRK_IMM                  0x5500
> +#define UBSAN_BRK_MASK                 0x00ff
>
>  #define CFI_BRK_IMM_TARGET             GENMASK(4, 0)
>  #define CFI_BRK_IMM_TYPE               GENMASK(9, 5)
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 4c0caa589e12..87f42eb1c950 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -26,6 +26,7 @@
>  #include <linux/syscalls.h>
>  #include <linux/mm_types.h>
>  #include <linux/kasan.h>
> +#include <linux/ubsan.h>
>  #include <linux/cfi.h>
>
>  #include <asm/atomic.h>
> @@ -1074,6 +1075,19 @@ static struct break_hook kasan_break_hook = {
>  };
>  #endif
>
> +#ifdef CONFIG_UBSAN_TRAP
> +static int ubsan_handler(struct pt_regs *regs, unsigned long esr)
> +{
> +       die(report_ubsan_failure(regs, esr & UBSAN_BRK_MASK), regs, esr);
> +       return DBG_HOOK_HANDLED;
> +}
> +
> +static struct break_hook ubsan_break_hook = {
> +       .fn     = ubsan_handler,
> +       .imm    = UBSAN_BRK_IMM,
> +       .mask   = UBSAN_BRK_MASK,
> +};
> +#endif
>
>  #define esr_comment(esr) ((esr) & ESR_ELx_BRK64_ISS_COMMENT_MASK)
>
> @@ -1091,6 +1105,10 @@ int __init early_brk64(unsigned long addr, unsigned long esr,
>  #ifdef CONFIG_KASAN_SW_TAGS
>         if ((esr_comment(esr) & ~KASAN_BRK_MASK) == KASAN_BRK_IMM)
>                 return kasan_handler(regs, esr) != DBG_HOOK_HANDLED;
> +#endif
> +#ifdef CONFIG_UBSAN_TRAP
> +       if ((esr_comment(esr) & ~UBSAN_BRK_MASK) == UBSAN_BRK_IMM)
> +               return ubsan_handler(regs, esr) != DBG_HOOK_HANDLED;
>  #endif
>         return bug_handler(regs, esr) != DBG_HOOK_HANDLED;
>  }
> @@ -1104,6 +1122,9 @@ void __init trap_init(void)
>         register_kernel_break_hook(&fault_break_hook);
>  #ifdef CONFIG_KASAN_SW_TAGS
>         register_kernel_break_hook(&kasan_break_hook);
> +#endif
> +#ifdef CONFIG_UBSAN_TRAP
> +       register_kernel_break_hook(&ubsan_break_hook);
>  #endif
>         debug_traps_init();
>  }
> diff --git a/include/linux/ubsan.h b/include/linux/ubsan.h
> new file mode 100644
> index 000000000000..bff7445498de
> --- /dev/null
> +++ b/include/linux/ubsan.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_UBSAN_H
> +#define _LINUX_UBSAN_H
> +
> +#ifdef CONFIG_UBSAN_TRAP
> +const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type);
> +#endif
> +
> +#endif
> diff --git a/lib/Makefile b/lib/Makefile
> index 4d9461bfea42..81b988bf9448 100644
> --- a/lib/Makefile
> +++ b/lib/Makefile
> @@ -340,9 +340,7 @@ quiet_cmd_build_OID_registry = GEN     $@
>  clean-files    += oid_registry_data.c
>
>  obj-$(CONFIG_UCS2_STRING) += ucs2_string.o
> -ifneq ($(CONFIG_UBSAN_TRAP),y)
>  obj-$(CONFIG_UBSAN) += ubsan.o
> -endif
>
>  UBSAN_SANITIZE_ubsan.o := n
>  KASAN_SANITIZE_ubsan.o := n
> diff --git a/lib/ubsan.c b/lib/ubsan.c
> index 60c7099857a0..98a671ec56e9 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -18,6 +18,58 @@
>
>  #include "ubsan.h"
>
> +#ifdef CONFIG_UBSAN_TRAP
> +const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
> +{
> +       switch (check_type) {
> +       case ubsan_add_overflow:
> +               return "UBSAN: addition overflow";

It would be nice if we could avoid duplicating this UBSAN: prefix 21x times.

> +       case ubsan_builtin_unreachable:
> +               return "UBSAN: unreachable code";
> +       case ubsan_cfi_check_fail:
> +               return "UBSAN: CFI failure";
> +       case ubsan_divrem_overflow:
> +               return "UBSAN: divide/remainder overflow";
> +       case ubsan_function_type_mismatch:
> +               return "UBSAN: function type mismatch";
> +       case ubsan_implicit_conversion:
> +               return "UBSAN: implicit conversion";
> +       case ubsan_invalid_builtin:
> +               return "UBSAN: invalid builtin";
> +       case ubsan_invalid_objc_cast:
> +               return "UBSAN: invalid object cast";
> +       case ubsan_load_invalid_value:
> +               return "UBSAN: loading invalid value";
> +       case ubsan_missing_return:
> +               return "UBSAN: missing return";
> +       case ubsan_mul_overflow:
> +               return "UBSAN: multiplication overflow";
> +       case ubsan_negate_overflow:
> +               return "UBSAN: negation overflow";
> +       case ubsan_nonnull_arg:
> +               return "UBSAN: non-NULL argument";
> +       case ubsan_nonnull_return:
> +               return "UBSAN: non-NULL return";
> +       case ubsan_out_of_bounds:
> +               return "UBSAN: array index out of bounds";
> +       case ubsan_pointer_overflow:
> +               return "UBSAN: pointer overflow";
> +       case ubsan_shift_out_of_bounds:
> +               return "UBSAN: shift out of bounds";
> +       case ubsan_sub_overflow:
> +               return "UBSAN: subtraction overflow";
> +       case ubsan_type_mismatch:
> +               return "UBSAN: type mismatch";
> +       case ubsan_alignment_assumption:
> +               return "UBSAN: alignment assumption";
> +       case ubsan_vla_bound_not_positive:
> +               return "UBSAN: VLA bounds not positive";
> +       default:
> +               return "UBSAN: unknown failure";
> +       }
> +}
> +
> +#else
>  static const char * const type_check_kinds[] = {
>         "load of",
>         "store to",
> @@ -384,3 +436,5 @@ void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
>         ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
> +
> +#endif /* !CONFIG_UBSAN_TRAP */
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 9a0b71c5ff9f..9c7f00f550f5 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -2,6 +2,34 @@
>  #ifndef _LIB_UBSAN_H
>  #define _LIB_UBSAN_H
>
> +enum ubsan_checks {
> +       ubsan_add_overflow,
> +       ubsan_builtin_unreachable,
> +       ubsan_cfi_check_fail,
> +       ubsan_divrem_overflow,
> +       ubsan_dynamic_type_cache_miss,
> +       ubsan_float_cast_overflow,
> +       ubsan_function_type_mismatch,
> +       ubsan_implicit_conversion,
> +       ubsan_invalid_builtin,
> +       ubsan_invalid_objc_cast,
> +       ubsan_load_invalid_value,
> +       ubsan_missing_return,
> +       ubsan_mul_overflow,
> +       ubsan_negate_overflow,
> +       ubsan_nullability_arg,
> +       ubsan_nullability_return,
> +       ubsan_nonnull_arg,
> +       ubsan_nonnull_return,
> +       ubsan_out_of_bounds,
> +       ubsan_pointer_overflow,
> +       ubsan_shift_out_of_bounds,
> +       ubsan_sub_overflow,
> +       ubsan_type_mismatch,
> +       ubsan_alignment_assumption,
> +       ubsan_vla_bound_not_positive,
> +};
> +
>  enum {
>         type_kind_int = 0,
>         type_kind_float = 1,
> --
> 2.34.1
>
