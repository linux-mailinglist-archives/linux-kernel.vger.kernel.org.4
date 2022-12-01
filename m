Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6288F63F168
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 14:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231193AbiLANRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 08:17:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiLANRi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 08:17:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9CAFEA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 05:17:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E64E6200A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF1E5C433D7
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669900655;
        bh=UjKLLEsIwR07HcG33HnbQVlpUJCO7pqDak6jWKKW6IE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MVGr9tzOx7orMLDymZc+/k0D1jXfB1JrmVjNHLdzcgjmsFgxG0YuwnuBo1jDmiTR0
         VJ4HLUKcWioo3ZjlyIG8T+gApHsIIO5z4VTkVxDPC4pfu9VcTge060dKJprBfeKkMW
         tViGnRJM8S2ozBj7typhEi5kBdkBFa20tApyyMGFCZPZcmhmE8MABNwd73x1uUETaS
         pGccITwJ2QyvlA3aj7IdaKSwM4NzpaOpTQkIK+SNUq/88v5qRUg6SB+gkom1sOPkq5
         +bSK5y8/Efk1VC6EPCS3O+IMLOPEsgAtu4LJcDMUr9v10XSIZyNGDO95yjoTtgKsmq
         AW3zAbOhYbiFg==
Received: by mail-ej1-f47.google.com with SMTP id gu23so4093285ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 05:17:35 -0800 (PST)
X-Gm-Message-State: ANoB5pmK20aiObux4/it4etdHn/TlYrNF6tLjNtaubwf2CbaPvk+z6uu
        9yZMWZFzYnPA2qhsm2XIxqCJECkjEk7jDccT0HA=
X-Google-Smtp-Source: AA0mqf4kyO5hcP35ZuA9HU7kZNC7BjGnYjUnpkgAIT8BA+YaJi4wPl89S+iUN/ZQmwZI/X5JzT7vDVHIT8ugHL5V6v4=
X-Received: by 2002:a17:906:ee2:b0:78d:3f96:b7aa with SMTP id
 x2-20020a1709060ee200b0078d3f96b7aamr41475089eji.74.1669900654008; Thu, 01
 Dec 2022 05:17:34 -0800 (PST)
MIME-Version: 1.0
References: <20221130023515.20217-1-palmer@rivosinc.com> <20221130023515.20217-2-palmer@rivosinc.com>
In-Reply-To: <20221130023515.20217-2-palmer@rivosinc.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Thu, 1 Dec 2022 21:17:22 +0800
X-Gmail-Original-Message-ID: <CAJF2gTS2A=C0Epf5NqgpE8ZWX-EXHLt5SwD0HmB3kzoLj1N3Bw@mail.gmail.com>
Message-ID: <CAJF2gTS2A=C0Epf5NqgpE8ZWX-EXHLt5SwD0HmB3kzoLj1N3Bw@mail.gmail.com>
Subject: Re: [PATCH 2/2] RISC-V: Add some comments about the shadow and
 overflow stacks
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     jszhang@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 10:35 AM Palmer Dabbelt <palmer@rivosinc.com> wrote:
>
> It took me a while to page all this back in when trying to review the
> recent spin_shadow_stack, so I figured I'd just write up some comments.
>
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
>  arch/riscv/kernel/traps.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index acdfcacd7e57..336d4aadadb1 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -200,18 +200,18 @@ void __init trap_init(void)
>  }
>
>  #ifdef CONFIG_VMAP_STACK
> +/*
> + * Extra stack space that allows us to provide panic messages when the kernel
> + * has overflowed its stack.
> + */
>  static DEFINE_PER_CPU(unsigned long [OVERFLOW_STACK_SIZE/sizeof(long)],
>                 overflow_stack)__aligned(16);
>  /*
> - * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
> - * to get per-cpu overflow stack(get_overflow_stack).
> + * A temporary stack for use by handle_kernel_stack_overflow.  This is used so
> + * we can call into C code to get the per-hart overflow stack.  Usage of this
> + * stack must be protected by spin_shadow_stack.
Reviewed-by: Guo Ren <guoren@kernel.org>

>   */
>  long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
> -asmlinkage unsigned long get_overflow_stack(void)
> -{
> -       return (unsigned long)this_cpu_ptr(overflow_stack) +
> -               OVERFLOW_STACK_SIZE;
> -}
>
>  /*
>   * A pseudo spinlock to protect the shadow stack from being used by multiple
> @@ -222,6 +222,12 @@ asmlinkage unsigned long get_overflow_stack(void)
>   */
>  unsigned long spin_shadow_stack;
>
> +asmlinkage unsigned long get_overflow_stack(void)
> +{
> +       return (unsigned long)this_cpu_ptr(overflow_stack) +
> +               OVERFLOW_STACK_SIZE;
> +}
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>         unsigned long tsk_stk = (unsigned long)current->stack;
> --
> 2.38.1
>


-- 
Best Regards
 Guo Ren
