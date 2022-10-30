Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65351612AB7
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Oct 2022 14:24:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiJ3NYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Oct 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiJ3NYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Oct 2022 09:24:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F208DC51
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 06:24:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B0C160CE8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 13:24:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD62C433D7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 13:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667136244;
        bh=R5uAAOwfhBbjV6oM76LGmmVk9MxkU7/sTXwusw3/Mxs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=a3GKiaC0hK08JreV1E2wvjYIXFxsyC0FotLYKaAMaPxNtqizbDuLeYwFdQS7Dchtt
         SaqA827YASFLTyHkjIWoAIlSGbzZiqdp+d3GX7cMEnxG5t4MJg1RhqHkmJTkLdeS4c
         Lf96++REpXouQkDkxJMoaibzFnY3svy2r8Me1PYmgv/tgjnSkhqte8hICQ+UbcEPSH
         nB6n1YfJ5Lmd6Jg+ZuUnSCjO/7YBA9XWVL91jnjmDMo9AG7Xpc+mWYT7m7vbPRpX81
         hOklM0gE5GJV0sPE7EUS/TAL+7GbELYtsueIaBz3BDD9buSQ4l0Mu38c1c3arxuJiC
         We9fPTw8O6+1Q==
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-13b6c1c89bdso11087943fac.13
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 06:24:04 -0700 (PDT)
X-Gm-Message-State: ACrzQf3ZRwPq4GI5VGWU2QG/+KrZWLLtojcux+wIHhvKJYsGd66m5ihM
        Tvv4TkNq8hPSoNfTpn5Wo6vYOzRtt4N0BU35RkU=
X-Google-Smtp-Source: AMsMyM6JDTigjpyhc9s9y68ntLbzzQG3iswsqkU6mLrFLhpaBY0LV9z9NUcaBTc40L0yrTXODfGOgaSqyytpO39funI=
X-Received: by 2002:a05:6870:5803:b0:12c:c3e0:99dc with SMTP id
 r3-20020a056870580300b0012cc3e099dcmr13430439oap.19.1667136243989; Sun, 30
 Oct 2022 06:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20221030124517.2370-1-jszhang@kernel.org>
In-Reply-To: <20221030124517.2370-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 30 Oct 2022 21:23:51 +0800
X-Gmail-Original-Message-ID: <CAJF2gTRPECoPFHXKZZ8bRc27YSYv7z4xkYh+hTmfzmZg8=2Ejg@mail.gmail.com>
Message-ID: <CAJF2gTRPECoPFHXKZZ8bRc27YSYv7z4xkYh+hTmfzmZg8=2Ejg@mail.gmail.com>
Subject: Re: [PATCH v3] riscv: fix race when vmap stack overflow
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Sun, Oct 30, 2022 at 8:54 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Currently, when detecting vmap stack overflow, riscv firstly switches
> to the so called shadow stack, then use this shadow stack to call the
> get_overflow_stack() to get the overflow stack. However, there's
> a race here if two or more harts use the same shadow stack at the same
> time.
>
> To solve this race, we introduce spin_shadow_stack atomic var, which
> will be swap between its own address and 0 in atomic way, when the
> var is set, it means the shadow_stack is being used; when the var
> is cleared, it means the shadow_stack isn't being used.
>
> Fixes: 31da94c25aea ("riscv: add VMAP_STACK overflow detection")
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> Suggested-by: Guo Ren <guoren@kernel.org>
> ---
> Since v2:
>  - use REG_AMOSWAP
>  - add comment to the purpose of smp_store_release()
>
> Since v1:
>  - use smp_store_release directly
>  - use unsigned int instead of atomic_t
>
>
>  arch/riscv/include/asm/asm.h | 1 +
>  arch/riscv/kernel/entry.S    | 4 ++++
>  arch/riscv/kernel/traps.c    | 9 +++++++++
>  3 files changed, 14 insertions(+)
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 1b471ff73178..acf563072b8b 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -23,6 +23,7 @@
>  #define REG_L          __REG_SEL(ld, lw)
>  #define REG_S          __REG_SEL(sd, sw)
>  #define REG_SC         __REG_SEL(sc.d, sc.w)
> +#define REG_AMOSWAP    __REG_SEL(amoswap.d, amoswap.w)
>  #define REG_ASM                __REG_SEL(.dword, .word)
>  #define SZREG          __REG_SEL(8, 4)
>  #define LGREG          __REG_SEL(3, 2)
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b9eda3fcbd6d..ea6b78dac739 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
>
>  #ifdef CONFIG_VMAP_STACK
>  handle_kernel_stack_overflow:
> +1:     la sp, spin_shadow_stack
> +       REG_AMOSWAP sp, sp, (sp)
> +       bnez sp, 1b
> +
>         la sp, shadow_stack
>         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f3e96d60a2ff..dea47f329708 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -221,11 +221,20 @@ asmlinkage unsigned long get_overflow_stack(void)
>                 OVERFLOW_STACK_SIZE;
>  }
>
> +unsigned long spin_shadow_stack;
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>         unsigned long tsk_stk = (unsigned long)current->stack;
>         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>
> +       /*
> +        * to ensure spin flag is set after the sp is used in entry.S:
> +        * //load per-cpu overflow stack.
> +        * REG_L sp, -8(sp)
> +        */
> +       smp_store_release(&spin_shadow_stack, 0);
> +
>         console_verbose();
>
>         pr_emerg("Insufficient stack space to handle exception!\n");
> --
> 2.37.2
>


-- 
Best Regards
 Guo Ren
