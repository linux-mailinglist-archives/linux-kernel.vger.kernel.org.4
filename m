Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE665624A51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 20:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbiKJTIc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 14:08:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiKJTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 14:07:43 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D63659FC0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:06:22 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id b11so2453690pjp.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 11:06:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8BOfwJyZkB5NeEkoK9HFl+Jpr8ENfJAqXI5cJXPbV58=;
        b=nVYsd80hcxMv8ff6fLEa671TtzbPmVVCP1aPUXP0s6+BujlXVaze5aQociyjzmAnlW
         5W4BpzMnVVqWD3kXN+QkmA4t42sP4n+cIQrhaQkxhE/T8UB51PRMjJwk4f/XxJTULlAF
         0UX9NtEt9fcOSitjV6oaZxroCFZqPJ67lU7C1CqNAzDVpktF3ylxkr+XFKfC5tBGD+mo
         GpVfjDW6xYl5VXv6oN4COhPIVZ1yKi9o+8ZBFzGkMcenCokt3/NuMFkE2S5wyvZDy26P
         CzLzbhARvWXDpI4fowrGuZOZA4Kt3z+9+afVXuWt8ep5rdycTCXrZOIuwkgyfeBHc+WO
         9Dyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BOfwJyZkB5NeEkoK9HFl+Jpr8ENfJAqXI5cJXPbV58=;
        b=R8DsRY1ZCV1tMyE2RZZEtaXin96YgOrV6+Ex45DceO0aqse3rodGwqfgWNGNufdsBU
         v0MrMHzRLHBIU+lCK1LR2RnPEnb4jN0nEwUJIFU6tjNnhDicVdIToR1UD/UyoJckWxN0
         D7xLdM9MNJeWV0u4Lm4EZbXjINAbfXka5ldzrR1M4+HJgpOzKAvuGYNCrxwPPIR3Vj4w
         aUh4QzP7lzoEAOkRrB9LaeIZknY3A5MrdOZX4AP8lJ7uN+zy1DQvkhmQkrCn31CtFQ91
         9JCX+2gpmEnn50hhcyxN+TTBU8fUlJUsL8JduYxJ39ppEwbmRqYwxbc7p8i0cRLhlPUB
         8fAw==
X-Gm-Message-State: ACrzQf11Q4Ebx2jLNdzn7z8TrzNWfTgKNmdnhJzRAdi2o3uXOOcEMFcy
        6KiwMyA/A2wOz9zRmZ2BE66u9zqDjwcFx1mXVWKIKw==
X-Google-Smtp-Source: AMsMyM6LzgdK6gm66CyORfaEyT80odV+S0OASHc9uDM/+naRIEiC1LJkBIueaSZfN21OBm/dwxkjdGo74I31A4DX5Kg=
X-Received: by 2002:a17:90a:c24a:b0:213:13aa:3e2a with SMTP id
 d10-20020a17090ac24a00b0021313aa3e2amr82957783pjx.107.1668107181512; Thu, 10
 Nov 2022 11:06:21 -0800 (PST)
MIME-Version: 1.0
References: <20221106095106.849154-1-mailhol.vincent@wanadoo.fr> <20221106095106.849154-2-mailhol.vincent@wanadoo.fr>
In-Reply-To: <20221106095106.849154-2-mailhol.vincent@wanadoo.fr>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 10 Nov 2022 11:06:10 -0800
Message-ID: <CAKwvOdnzx0Y-vmFsRS6=rCveqAJVn6hXEutdn_ow=jbtNeQcCA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] x86/asm/bitops: Replace __fls() by its generic
 builtin implementation
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        llvm@lists.linux.dev, Borislav Petkov <bp@suse.de>
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

On Sun, Nov 6, 2022 at 1:51 AM Vincent Mailhol
<mailhol.vincent@wanadoo.fr> wrote:
>
> Below snippet:
>
>   #include <linux/bitops.h>
>
>   unsigned int foo(unsigned long word)
>   {
>         return __fls(word);
>   }
>
> produces this on GCC 12.1.0:
>
>   0000000000000000 <foo>:
>      0: f3 0f 1e fa             endbr64
>      4: e8 00 00 00 00          call   9 <foo+0x9>
>      9: 53                      push   %rbx
>      a: 48 89 fb                mov    %rdi,%rbx
>      d: e8 00 00 00 00          call   12 <foo+0x12>
>     12: 48 0f bd c3             bsr    %rbx,%rax
>     16: 5b                      pop    %rbx
>     17: 31 ff                   xor    %edi,%edi
>     19: e9 00 00 00 00          jmp    1e <foo+0x1e>
>
> and that on clang 14.0.6:
>
>   0000000000000000 <foo>:
>      0: f3 0f 1e fa             endbr64
>      4: e8 00 00 00 00          call   9 <foo+0x9>
>      9: 53                      push   %rbx
>      a: 50                      push   %rax
>      b: 48 89 fb                mov    %rdi,%rbx
>      e: e8 00 00 00 00          call   13 <foo+0x13>
>     13: 48 89 1c 24             mov    %rbx,(%rsp)
>     17: 48 0f bd 04 24          bsr    (%rsp),%rax
>     1c: 48 83 c4 08             add    $0x8,%rsp
>     20: 5b                      pop    %rbx
>     21: c3                      ret
>
> The implementation from <asm-generic/bitops/builtin-__fls.h> [1]
> produces the exact same code on GCC and below code on clang:
>
>   0000000000000000 <foo>:
>      0: f3 0f 1e fa             endbr64
>      4: e8 00 00 00 00          call   9 <foo+0x9>
>      9: 53                      push   %rbx
>      a: 48 89 fb                mov    %rdi,%rbx
>      d: e8 00 00 00 00          call   12 <foo+0x12>
>     12: 48 0f bd c3             bsr    %rbx,%rax
>     16: 5b                      pop    %rbx
>     17: c3                      ret
>
> The builtin implementation is better for two reasons:
>
>   1/ it saves two instructions on clang (a push and a stack pointer
>      decrement) because of a useless tentative to save rax.
>
>   2/ when used on constant expressions, the compiler is only able to
>      fold the builtin version (c.f. [2]).
>
> For those two reasons, replace the assembly implementation by its
> builtin counterpart.
>
> [1] https://elixir.bootlin.com/linux/v6.0/source/include/asm-generic/bitops/builtin-__fls.h
>
> [2] commit 146034fed6ee ("x86/asm/bitops: Use __builtin_ffs() to evaluate constant expressions")
>
> CC: Borislav Petkov <bp@suse.de>
> CC: Nick Desaulniers <ndesaulniers@google.com>
> CC: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

LGTM; thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  arch/x86/include/asm/bitops.h | 14 +-------------
>  1 file changed, 1 insertion(+), 13 deletions(-)
>
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 2edf68475fec..a31453d7686d 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -285,19 +285,7 @@ static __always_inline unsigned long variable_ffz(unsigned long word)
>          (unsigned long)__builtin_ctzl(~word) : \
>          variable_ffz(word))
>
> -/*
> - * __fls: find last set bit in word
> - * @word: The word to search
> - *
> - * Undefined if no set bit exists, so code should check against 0 first.
> - */
> -static __always_inline unsigned long __fls(unsigned long word)
> -{
> -       asm("bsr %1,%0"
> -           : "=r" (word)
> -           : "rm" (word));
> -       return word;
> -}
> +#include <asm-generic/bitops/builtin-__fls.h>
>
>  #undef ADDR
>
> --
> 2.37.4
>


-- 
Thanks,
~Nick Desaulniers
