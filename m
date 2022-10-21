Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC8F606E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 05:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiJUDGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 23:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiJUDG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 23:06:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0715167252
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AC5D61DA5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C26FEC43140
        for <linux-kernel@vger.kernel.org>; Fri, 21 Oct 2022 03:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666321586;
        bh=nnTz6BbYm16k0pymxCXW1qmPXNG1V5s2aBk/OjUH7BY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UJ6sb8WV0xREV3cW37N/YPanGFWLWII4Keozt6NE5BFxA5pIbczICwED/D6cbxzZb
         Kb2NFf5mZS32sbOZoJgf3udRyg0igD4xvqfYZS7tYf3lCU3qO3uBl6lVuM4HoCppWo
         1XCNouWrAwY/RHHOOOseBclciVWuFUrlgDjXqEbdSlUV66PwSPJu0/f+XI6abjul37
         MrWgoJZ9b8efNtdMvgwcIG2/0rgxSauwnwaz065fQ6uxjOlkYOp6uzZU9EeC4BuWHD
         8MiHdmUqDR7st3VAdkSlSa6hfwOb1luHeYH1TAL+yOCpZPHR5xruRnDL1gxA5kuF1z
         vw0sa72x8sMPQ==
Received: by mail-ot1-f46.google.com with SMTP id r8-20020a056830120800b00661a0a236efso1062499otp.4
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 20:06:26 -0700 (PDT)
X-Gm-Message-State: ACrzQf0r9c+s0c31wrqvSMB3B8xR2/5XRga/mp2EuwO2KjXaf54Twtl/
        O+ffICFI+Qb6gkImHi0aG2eDY7E2uvJ0NCyh9f4=
X-Google-Smtp-Source: AMsMyM7ORoMBIMno6AdJgmO8am2C+XtwrCTgg8wGdEDBszktYCFqgSUmm5ITEUqn6IVJ0grQWuCwXB7GOht0Qcv3/8c=
X-Received: by 2002:a9d:3634:0:b0:661:a991:7c57 with SMTP id
 w49-20020a9d3634000000b00661a9917c57mr8230356otb.308.1666321585880; Thu, 20
 Oct 2022 20:06:25 -0700 (PDT)
MIME-Version: 1.0
References: <20221020143329.3276-1-jszhang@kernel.org>
In-Reply-To: <20221020143329.3276-1-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Fri, 21 Oct 2022 11:06:13 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTZX48_psz31gJCi9h9ayUV1tfWYr32Br8CmLLrCZPpPg@mail.gmail.com>
Message-ID: <CAJF2gTTZX48_psz31gJCi9h9ayUV1tfWYr32Br8CmLLrCZPpPg@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: fix race when vmap stack overflow
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 20, 2022 at 10:43 PM Jisheng Zhang <jszhang@kernel.org> wrote:
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
> Since v1:
>  - use smp_store_release directly
>  - use unsigned int instead of atomic_t
>
>  arch/riscv/kernel/entry.S | 4 ++++
>  arch/riscv/kernel/traps.c | 4 ++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index b9eda3fcbd6d..7b924b16792b 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -404,6 +404,10 @@ handle_syscall_trace_exit:
>
>  #ifdef CONFIG_VMAP_STACK
>  handle_kernel_stack_overflow:
> +1:     la sp, spin_shadow_stack
> +       amoswap.w sp, sp, (sp)
Using ".w" is tricky for 64 BIT, I've hesitated. ';)
Let's move to REG_AMOSWAP, or you must make sure the address of
spin_shadow_stack won't be 4GB aligned.

> +       bnez sp, 1b
> +
>         la sp, shadow_stack
>         addi sp, sp, SHADOW_OVERFLOW_STACK_SIZE
>
> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
> index f3e96d60a2ff..f1f57c1241b6 100644
> --- a/arch/riscv/kernel/traps.c
> +++ b/arch/riscv/kernel/traps.c
> @@ -221,11 +221,15 @@ asmlinkage unsigned long get_overflow_stack(void)
>                 OVERFLOW_STACK_SIZE;
>  }
>
> +unsigned int spin_shadow_stack;
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>         unsigned long tsk_stk = (unsigned long)current->stack;
>         unsigned long ovf_stk = (unsigned long)this_cpu_ptr(overflow_stack);
>
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
