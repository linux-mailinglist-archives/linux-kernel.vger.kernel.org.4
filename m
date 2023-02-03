Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F7AE68A2BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 20:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233548AbjBCTPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 14:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231614AbjBCTPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 14:15:03 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42BA0EF9C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 11:15:02 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id n2so1719917pgb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Feb 2023 11:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GCsSpYaGKhPjbk4A0vQjSKCG3qz3zy/WsExyWKyZKmA=;
        b=JKhUeYVBuHCXlMroGMkXpiwxOsTL5Ky0TyKPWUUHkDZu+SdhPWnSXq6dNzjgXMOXMM
         cSVU+1nSXcxJeELtOM+fY4mLbf2qO0zUthYN0KL8uK9P9xWqjzoKK1iXFQixJiK4w5pH
         fio9fKnzkECnXKnVPehLPMMr041wgcS2mXPCnmTW3H3MSdY+1BJReIdgpI8/xJ4c5wDn
         EKJVi8vZ0rDa2cGIuQCMNaEBtpNcVLzvaSfWZxKTvvYfgNnNuUomGHby37JE+2XcGFG3
         X8MWC3yqq6UO6i188UD+vS2sVH2uwaeUChZvlN+N2BsycmXFQcrgqdvnfnQQeYZ2LsCg
         HleQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GCsSpYaGKhPjbk4A0vQjSKCG3qz3zy/WsExyWKyZKmA=;
        b=f7QzLF9XUnguxgMLe4iSt0FxUQ/5QBmI6xGH7R8NTKLyF48lukh4WSDUkkQdcGVVvZ
         PbPtyhJnwldgzfCfQjp9THXX22RgFrySrZhe0+61zf+e46lmXokT28IWyHBVmROislI7
         oqQqenLivC/VfXkyX9p8PgCZKUol/OviEtG/sumTN8LPFEeXgMc9/aefHDlMg2zzM/S7
         wPe1qAgnV4zVh/8LCs3QK94LDT/F40GSH8Fg5SEHN0zwe5Btah2Jv7vhs0zY9xj7c67S
         Madm64PC4Ow8Hh1v3H5L9RJa/vgzJLjza4rFnXfE5WHyCfNLkhn04LJ+2U1vihNAnR0y
         IuRA==
X-Gm-Message-State: AO0yUKVezJpzAHM52zpdtiqHIIbjwEV6VndLbJXnhknP9Smfo9aESLQE
        DcqjL2HXNR5T5qa059RwR4Vh8Ro5AIZR//po4FSU+g==
X-Google-Smtp-Source: AK7set8D1/GoK5Fl4fYWNhlGPY7s1qPfwAeWGwTNA2dp3/dqT4Lp4AIx+R6OunUD8NUCzoZnUYmbp3nMfC/+JjD3zGA=
X-Received: by 2002:aa7:9045:0:b0:593:adfa:8a1e with SMTP id
 n5-20020aa79045000000b00593adfa8a1emr2481029pfo.8.1675451701299; Fri, 03 Feb
 2023 11:15:01 -0800 (PST)
MIME-Version: 1.0
References: <20230203173946.gonna.972-kees@kernel.org>
In-Reply-To: <20230203173946.gonna.972-kees@kernel.org>
From:   Fangrui Song <maskray@google.com>
Date:   Fri, 3 Feb 2023 11:14:49 -0800
Message-ID: <CAFP8O3LdXO4-w57KeX+E2D2rOAv-bK47ur0=8XLgfEkXgB=5eg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: Support Clang UBSAN trap codes for better reporting
To:     Kees Cook <keescook@chromium.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        John Stultz <jstultz@google.com>,
        Yongqin Liu <yongqin.liu@linaro.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 3, 2023 at 9:39 AM Kees Cook <keescook@chromium.org> wrote:
>
> When building with CONFIG_UBSAN_TRAP=y on arm64, Clang encodes the UBSAN
> check (handler) type in the esr. Extract this and actually report these
> traps as coming from the specific UBSAN check that tripped.
>
> Before:
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
> ---
> v2: improve commit log, limit report strings to actual configs, document mappings
> v1: https://lore.kernel.org/lkml/20230202223653.never.473-kees@kernel.org/

Thanks. I'll add the Linux kernel use to
https://maskray.me/blog/2023-01-29-all-about-undefined-behavior-sanitizer
when this lands:)

> ---
>  arch/arm64/include/asm/brk-imm.h |  2 +
>  arch/arm64/kernel/traps.c        | 21 ++++++++++
>  include/linux/ubsan.h            |  9 +++++
>  lib/Makefile                     |  2 -
>  lib/ubsan.c                      | 67 ++++++++++++++++++++++++++++++++
>  lib/ubsan.h                      | 32 +++++++++++++++
>  6 files changed, 131 insertions(+), 2 deletions(-)
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

Q: How is 0x5500 derived?

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

IIUC, the break hook is a list so CONFIG_KASAN_SW_TAGS
(kernel-hwaddress) can be used with CONFIG_UBSAN_TRAP.

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
> index 60c7099857a0..f05ae85fc268 100644
> --- a/lib/ubsan.c
> +++ b/lib/ubsan.c
> @@ -18,6 +18,71 @@
>
>  #include "ubsan.h"
>
> +#ifdef CONFIG_UBSAN_TRAP
> +/*
> + * Only include matches for UBSAN checks that are actually compiled in.
> + * The mappings of struct SanitizerKind (the -fsanitize=xxx args) to
> + * enum SanitizerHandler (the traps) in Clang is in clang/lib/CodeGen/.
> + */
> +const char *report_ubsan_failure(struct pt_regs *regs, u32 check_type)
> +{
> +       switch (check_type) {
> +#ifdef CONFIG_UBSAN_BOUNDS
> +       /*
> +        * SanitizerKind::ArrayBounds and SanitizerKind::LocalBounds
> +        * emit SanitizerHandler::OutOfBounds.
> +        */
> +       case ubsan_out_of_bounds:
> +               return "UBSAN: array index out of bounds";
> +#endif
> +#ifdef CONFIG_UBSAN_SHIFT
> +       /*
> +        * SanitizerKind::ShiftBase and SanitizerKind::ShiftExponent
> +        * emit SanitizerHandler::ShiftOutOfBounds.
> +        */
> +       case ubsan_shift_out_of_bounds:
> +               return "UBSAN: shift out of bounds";
> +#endif
> +#ifdef CONFIG_UBSAN_DIV_ZERO
> +       /*
> +        * SanitizerKind::IntegerDivideByZero emits
> +        * SanitizerHandler::DivremOverflow.
> +        */
> +       case ubsan_divrem_overflow:
> +               return "UBSAN: divide/remainder overflow";
> +#endif
> +#ifdef CONFIG_UBSAN_UNREACHABLE
> +       /*
> +        * SanitizerKind::Unreachable emits
> +        * SanitizerHandler::BuiltinUnreachable.
> +        */
> +       case ubsan_builtin_unreachable:
> +               return "UBSAN: unreachable code";
> +#endif
> +#if defined(CONFIG_UBSAN_BOOL) || defined(CONFIG_UBSAN_ENUM)
> +       /*
> +        * SanitizerKind::Bool and SanitizerKind::Enum emit
> +        * SanitizerHandler::LoadInvalidValue.
> +        */
> +       case ubsan_load_invalid_value:
> +               return "UBSAN: loading invalid value";
> +#endif
> +#ifdef CONFIG_UBSAN_ALIGNMENT
> +       /*
> +        * SanitizerKind::Alignment emits SanitizerHandler::TypeMismatch
> +        * or SanitizerHandler::AlignmentAssumption.
> +        */
> +       case ubsan_alignment_assumption:
> +               return "UBSAN: alignment assumption";
> +       case ubsan_type_mismatch:
> +               return "UBSAN: type mismatch";
> +#endif
> +       default:
> +               return "UBSAN: unrecognized failure code";
> +       }
> +}

I wonder whether keeping the dash-prefixed name is better since that
matches compiler-rt/lib/ubsan.
People can search for "add-overflow" and get cross references from
compiler-rt/lib/ubsan, instead of needing to knowing that "addition
overflow" is another name for "add-overflow".

> +
> +#else
>  static const char * const type_check_kinds[] = {
>         "load of",
>         "store to",
> @@ -384,3 +449,5 @@ void __ubsan_handle_alignment_assumption(void *_data, unsigned long ptr,
>         ubsan_epilogue();
>  }
>  EXPORT_SYMBOL(__ubsan_handle_alignment_assumption);
> +
> +#endif /* !CONFIG_UBSAN_TRAP */
> diff --git a/lib/ubsan.h b/lib/ubsan.h
> index 9a0b71c5ff9f..cc5cb94895a6 100644
> --- a/lib/ubsan.h
> +++ b/lib/ubsan.h
> @@ -2,6 +2,38 @@
>  #ifndef _LIB_UBSAN_H
>  #define _LIB_UBSAN_H
>
> +/*
> + * ABI defined by Clang's UBSAN enum SanitizerHandler:
> + * https://github.com/llvm/llvm-project/blob/release/16.x/clang/lib/CodeGen/CodeGenFunction.h#L113
> + */
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
>

Reviewed-by: Fangrui Song <maskray@google.com>
