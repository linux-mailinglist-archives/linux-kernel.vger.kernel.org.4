Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22405F7B4A
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiJGQTD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 12:19:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiJGQTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 12:19:00 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C19114DC1
        for <linux-kernel@vger.kernel.org>; Fri,  7 Oct 2022 09:18:58 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id c17-20020a4aa4d1000000b0047653e7c5f3so3829584oom.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Oct 2022 09:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nseJ3w1yq7ddO6MwJhyhERjvC7DCkLFBPmXmd3KM1zE=;
        b=Avw2R2I5JrrUipY3K/HqwljAEflaVE2Kc/C9z2A5jcSBDeVzCHg+S7JgDuhZjL8WNn
         o8T+HZABP7Lg4KVT/EuaJnpRU10A6sl+a70SayR7pIriThdNN22pFJ/mggoxqB8BnDBQ
         UlWa+q9xmoQxuJd9ab66vk38uojXhhLcYkGQcj+jMEXSl+wtwgFZQEmjbdUvUE7JedlY
         hLs3f1K8EGUVfoDDXr23km1Ajep5B2JzFsA8GMNC99Rf73VXEBbslzsWlwO3CUVDK+s1
         vkPqNDCzrh+rKQ9dEE/LwlviR7EUl9Z8NVXf8xQ8yk7OgOgYpHNFlUBFf0VIvDZ9fe7k
         ZBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nseJ3w1yq7ddO6MwJhyhERjvC7DCkLFBPmXmd3KM1zE=;
        b=07AwvHd/8DvcQAz5jErIjN8yb16ufBrbRClcdDR5rr49p+Mm8rWBuccrdzv0rdiWCL
         3bIwSbKagMFNwd3vdupMTUdGwdbhs2EcDSJ12wRYeYDPdPtLC8XWbo1vYnmp//tsGDzq
         Ex+KujjrN0EY3sTN5fvnH9GatUy3cTRkD9/vA73kr7UrY8cYQYoWnH0Dlwx1V09YZiEH
         Bfx99c3gOpk5O51acwUNkaoqMh/3iWQ/GpPula894SeJ10sKXmS1UDVbsIrq3JFKmQ6F
         kyOjoTbMuMzn8OilPP1x+zNsbihnYtsUE/scsLD5KyoYVxeFz12MakfMPlQ6h2eXOfwC
         e9jg==
X-Gm-Message-State: ACrzQf0qPpsAO5MD1C6x5M49Z6sI1UogHIPdUuW7OlRUg/T+Q58piuII
        q2sRGzmhQpuXz/qItRwPh1wMR2zELMxC+rrE5IDz5l01fQ==
X-Google-Smtp-Source: AMsMyM6IXib+XzH647vImxep6q7MwAd+v7I0iSvXASbIA9aMnncJ3GBOxJBxEGP2F7mTnfN9S7gxQKNcumG6dAzm5UY=
X-Received: by 2002:a05:6830:618c:b0:65b:f09f:d55f with SMTP id
 cb12-20020a056830618c00b0065bf09fd55fmr2389073otb.266.1665159537164; Fri, 07
 Oct 2022 09:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <20221006154041.13001-1-xin3.li@intel.com> <20221006154041.13001-7-xin3.li@intel.com>
In-Reply-To: <20221006154041.13001-7-xin3.li@intel.com>
From:   Brian Gerst <brgerst@gmail.com>
Date:   Fri, 7 Oct 2022 12:18:45 -0400
Message-ID: <CAMzpN2iccL5kNa2UaBXppiLnoNWrpwJd74+uBrB_63N0F5F5Xg@mail.gmail.com>
Subject: Re: [PATCH 6/6] x86/gsseg: use the LKGS instruction if available for load_gs_index()
To:     Xin Li <xin3.li@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com
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

On Thu, Oct 6, 2022 at 12:19 PM Xin Li <xin3.li@intel.com> wrote:
>
> From: "H. Peter Anvin (Intel)" <hpa@zytor.com>
>
> The LKGS instruction atomically loads a segment descriptor into the
> %gs descriptor registers, *except* that %gs.base is unchanged, and the
> base is instead loaded into MSR_IA32_KERNEL_GS_BASE, which is exactly
> what we want this function to do.
>
> Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
> Signed-off-by: Xin Li <xin3.li@intel.com>
> ---
>  arch/x86/include/asm/gsseg.h | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/include/asm/gsseg.h b/arch/x86/include/asm/gsseg.h
> index 5e3b56a17098..b8a6a98d88b8 100644
> --- a/arch/x86/include/asm/gsseg.h
> +++ b/arch/x86/include/asm/gsseg.h
> @@ -3,15 +3,41 @@
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
> +#define LKGS_DI        _ASM_BYTES(0xf2,0x0f,0x00,0xf7)
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
> +       alternative_io("1: call asm_load_gs_index\n"
> +                      ".pushsection \".fixup\",\"ax\"\n"
> +                      "2:      xorl %k[sel], %k[sel]\n"
> +                      "        jmp 1b\n"
> +                      ".popsection\n"
> +                      _ASM_EXTABLE(1b, 2b),
> +                      _ASM_BYTES(0x3e) LKGS_DI,
> +                      X86_FEATURE_LKGS,
> +                      ASM_OUTPUT2([sel] "+D" (sel), ASM_CALL_CONSTRAINT),
> +                      ASM_NO_INPUT_CLOBBER(_ASM_AX));
>  }
>
>  #endif /* CONFIG_X86_64 */
> --
> 2.34.1

There are not that many call sites, so using something like this
(incorporating Peter Z's suggestion for the exception handler) would
be better from a code readability perspective vs. a tiny increase in
code size.

        if (static_cpu_has(X86_FEATURE_LKGS))
                asm volatile("1: " LKGS_DI
                             _ASM_EXTABLE_TYPE_REG(1b, 1b,
EX_TYPE_ZERO_REG, %k[sel])
                             : [sel] "+D" (sel) : : "memory");
        else
                asm_load_gs_index(sel);

--
Brian Gerst
