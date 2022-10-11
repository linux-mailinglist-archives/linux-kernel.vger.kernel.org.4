Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F387D5FAB6F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 05:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbiJKDwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 23:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJKDvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 23:51:50 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A59485F101
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:51:45 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id i25-20020a4a8d99000000b0047fa712fc6dso8070687ook.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 20:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QrH+AZ0pi0NyiGYAQ/yzy4Prd1ObK+j25tmndo4l+fk=;
        b=Iku+TdbOK6LiwxbDxTspAMlAL1zo0/kFd7JCkLY5eAhmOhSYwpWWQ3WdwhWZqYsdf2
         wGXCzPX65sdTgLIkzA4bamxSZYl1aDMuPuL75a5bSbeHwhJZtXYl6dx92AJGffDW+dU0
         KtshlaIFmzpKEozD+pMawHFc5DmFHNw8L6qpClmPttCbQg9dSTG0UOimIBufZabiCvNR
         2wBCZvDD/JoUCgMf5bm5hn12DSa9rVJrj+W6x376va75cu38hf8IsjAiz3YNHETb3Zr0
         c311d2KDBe7ZCiWuCf45kRmavfPqRvTtjZLRK+jyBCsd202BlveF9CYGJ5n6BaEzq6nN
         ihSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QrH+AZ0pi0NyiGYAQ/yzy4Prd1ObK+j25tmndo4l+fk=;
        b=GviQv5/NNNC8omkSTeEKj9E0UAQuIpL6pWKg33JBLY5UCcJC9Ke5DnKV2DgyKWyh7d
         Pp2Cr+N8VkXFz2CbYY1/0rOnTziRpbzX6QXZvxv5jHlOu1CZQAlXtZ14jFxiDTXLL/T8
         vQFPH34fID8Qk6lQwUjo1bk5WbiyckgjDVfpqf8k4wZVP6Ys3/Ci7wfhOrYcRbhcaDcn
         RX9e3QFXMJ+kKkZXjBL/39yTXzoDoaCqpK+LeVml7mn/QnxP0aSj0qScp4J7c7jDlwa3
         4mc6Tec9sxA1ajJhZZZj6ewMIAfHStr0CIrZq+C/6pDo4m4xjWv0WmaA+WtPodZHAyTs
         RUxg==
X-Gm-Message-State: ACrzQf3pzldxnkaOBgoeW12aH9SSsaF4NMGHw2YyYQodIBwukeGYc++O
        NJFIygZYrG+EJNZHjvaFou/VcNaJghqVx3BWiQ==
X-Google-Smtp-Source: AMsMyM4MKc2EZoI9oyTnmgyHcIq3Xy3rUR2/0Qq0BjS30Ar3veoS0PzqocrlzgmkSNAV9QzTwYgTDVlgXLkpIzdk6oU=
X-Received: by 2002:a4a:aeca:0:b0:480:2413:1edc with SMTP id
 v10-20020a4aaeca000000b0048024131edcmr7165861oon.96.1665460304873; Mon, 10
 Oct 2022 20:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20221010190159.11920-1-xin3.li@intel.com> <20221010190159.11920-7-xin3.li@intel.com>
In-Reply-To: <20221010190159.11920-7-xin3.li@intel.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Mon, 10 Oct 2022 23:51:33 -0400
Message-ID: <CAMzpN2hKr-=9sP=_VjGdsJDX5Pzdr9WAsSs77s_5yPJeqi728g@mail.gmail.com>
Subject: Re: [PATCH v2 6/6] x86/gsseg: use the LKGS instruction if available
 for load_gs_index()
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 3:46 PM Xin Li <xin3.li@intel.com> wrote:
>
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>
> The LKGS instruction atomically loads a segment descriptor into the
> %gs descriptor registers, *except* that %gs.base is unchanged, and the
> base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
> what we want this function to do.
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> link: https://lkml.org/lkml/2022/10/7/352
> link: https://lkml.org/lkml/2022/10/7/373
> ---
>  arch/x86/include/asm/gsseg.h | 27 ++++++++++++++++++++++++++-
>  1 file changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
> index 5e3b56a17098..4aaef7a1d68f 100644
> --- a/arch/x86/include/asm/gsseg.h
> +++ b/arch/x86/include/asm/gsseg.h
> @@ -3,15 +3,40 @@
>  #define _ASM_X86_GSSEG_H
>
>  #include <linux/types.h>
> +
> +#include <asm/asm.h>
> +#include <asm/cpufeature.h>
> +#include <asm/alternative.h>
>  #include <asm/processor.h>
> +#include <asm/nops.h>
>
>  #ifdef CONFIG_X86_64
>
>  extern asmlinkage void asm_load_gs_index(u16 selector);
>
> +/* Replace with "lkgs %di" once binutils support LKGS instruction */
> +#define LKGS_DI _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
> +
>  static inline void native_load_gs_index(unsigned int selector)
>  {
> -       asm_load_gs_index(selector);
> +       u16 sel = selector;
> +
> +       /*
> +        * Note: the fixup is used for the LKGS instruction, but
> +        * it needs to be attached to the primary instruction sequence
> +        * as it isn't something that gets patched.
> +        *
> +        * %rax is provided to the assembly routine as a scratch
> +        * register.
> +        */
> +       asm_inline volatile("1:\n"
> +                           ALTERNATIVE("call asm_load_gs_index\n",
> +                                       _ASM_BYTES(0x3e) LKGS_DI,
> +                                       X86_FEATURE_LKGS)
> +                           _ASM_EXTABLE_TYPE_REG(1b, 1b, EX_TYPE_ZERO_REG, %k[sel])
> +                           : ASM_CALL_CONSTRAINT
> +                           : [sel] "D" (sel)

DI needs to be marked as input and output (+D), since the exception
handler modifies it.

> +                           : "memory", _ASM_AX);

_ASM_AX is only needed for code that is used by both 32 and 64-bit.
Since this is 64-bit only, "rax" would be appropriate.

--
Brian Gerst
