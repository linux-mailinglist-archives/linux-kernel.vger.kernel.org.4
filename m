Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532AA5E96EE
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 01:30:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiIYXaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 19:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231345AbiIYXaN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 19:30:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811BE18B1C
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 16:30:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D30761493
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:30:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83DF8C43140
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 23:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664148611;
        bh=0dkLfkpN4bl6+XUgOrEzocRDFO2GLiA4mip+arTaoJU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=QQSkMZYZUkGzP15UheuDVf6q6ELa7I+MaMsKTleqTBELVuJF0HsUlZ0E+QO7dCAUZ
         SdzVfxXScTZd1iY4dT/g6SJbI3QZr0hQqMPLyvz3dONRCiXxbOhUhZe5sYfnXx4rF3
         PWGrHS4tdqFLkX1p9Q+o10b+/J4iusUrPzIjqep3G8zGYDAGnkOyrRyxgk/dd9aI95
         tuae4uV9bxFs8WiYaPmfq3rkuDFoqwAvMBDNf9VXCmurtDDN/d2jWF/5auc7ORZHGp
         BtDw2e9JiYNSK+msY4nW0ePXf6zdA4g7JfcX5uAfPL8QoYd5SfHzsi30IWORNE/6Px
         Y0ELg+0zECppw==
Received: by mail-oi1-f172.google.com with SMTP id v130so6439430oie.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Sep 2022 16:30:11 -0700 (PDT)
X-Gm-Message-State: ACrzQf3hF0AZI188LuPGusp3mTrXOsI1TQDJEupVAoYCI0nXslZM5C4N
        zxxdrAuDHWT3j9JhKpBGs98KXqMBfvU6wfcHCtw=
X-Google-Smtp-Source: AMsMyM78H8xRByyG0Kx8aSGOYIjP57Juz7vq8m3nhivoMNVDUsp0tW0/ImKxj4XFvVU/79/z7jAP6Vux6xHUVeayUiU=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr13923041oiw.112.1664148610641; Sun, 25
 Sep 2022 16:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220925175356.681-1-jszhang@kernel.org> <20220925175356.681-5-jszhang@kernel.org>
In-Reply-To: <20220925175356.681-5-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 26 Sep 2022 07:29:58 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT+NuLOfzOqm2bLy4-AK7z1M-nb17zgQKVqyz9uxAg8LQ@mail.gmail.com>
Message-ID: <CAJF2gTT+NuLOfzOqm2bLy4-AK7z1M-nb17zgQKVqyz9uxAg8LQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] riscv: entry: consolidate general regs saving into save_gp
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Guo Ren <kernel.org>

For the save & restore pair, I also suggest adding restore_gp.

On Mon, Sep 26, 2022 at 2:03 AM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Consolidate the saving GPs(except sp and tp into save_gp macro.
> No functional change.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/kernel/entry.S | 85 ++++++++++++++-------------------------
>  1 file changed, 31 insertions(+), 54 deletions(-)
>
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 442d93beffcf..04e11d257ad6 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -14,31 +14,8 @@
>  #include <asm/asm-offsets.h>
>  #include <asm/errata_list.h>
>
> -ENTRY(handle_exception)
> -       /*
> -        * If coming from userspace, preserve the user thread pointer and load
> -        * the kernel thread pointer.  If we came from the kernel, the scratch
> -        * register will contain 0, and we should continue on the current TP.
> -        */
> -       csrrw tp, CSR_SCRATCH, tp
> -       bnez tp, _save_context
> -
> -_restore_kernel_tpsp:
> -       csrr tp, CSR_SCRATCH
> -       REG_S sp, TASK_TI_KERNEL_SP(tp)
> -
> -#ifdef CONFIG_VMAP_STACK
> -       addi sp, sp, -(PT_SIZE_ON_STACK)
> -       srli sp, sp, THREAD_SHIFT
> -       andi sp, sp, 0x1
> -       bnez sp, handle_kernel_stack_overflow
> -       REG_L sp, TASK_TI_KERNEL_SP(tp)
> -#endif
> -
> -_save_context:
> -       REG_S sp, TASK_TI_USER_SP(tp)
> -       REG_L sp, TASK_TI_KERNEL_SP(tp)
> -       addi sp, sp, -(PT_SIZE_ON_STACK)
> +       /* save all GPs except sp and tp */
> +       .macro save_gp
>         REG_S x1,  PT_RA(sp)
>         REG_S x3,  PT_GP(sp)
>         REG_S x5,  PT_T0(sp)
> @@ -68,6 +45,34 @@ _save_context:
>         REG_S x29, PT_T4(sp)
>         REG_S x30, PT_T5(sp)
>         REG_S x31, PT_T6(sp)
> +       .endm
> +
> +ENTRY(handle_exception)
> +       /*
> +        * If coming from userspace, preserve the user thread pointer and load
> +        * the kernel thread pointer.  If we came from the kernel, the scratch
> +        * register will contain 0, and we should continue on the current TP.
> +        */
> +       csrrw tp, CSR_SCRATCH, tp
> +       bnez tp, _save_context
> +
> +_restore_kernel_tpsp:
> +       csrr tp, CSR_SCRATCH
> +       REG_S sp, TASK_TI_KERNEL_SP(tp)
> +
> +#ifdef CONFIG_VMAP_STACK
> +       addi sp, sp, -(PT_SIZE_ON_STACK)
> +       srli sp, sp, THREAD_SHIFT
> +       andi sp, sp, 0x1
> +       bnez sp, handle_kernel_stack_overflow
> +       REG_L sp, TASK_TI_KERNEL_SP(tp)
> +#endif
> +
> +_save_context:
> +       REG_S sp, TASK_TI_USER_SP(tp)
> +       REG_L sp, TASK_TI_KERNEL_SP(tp)
> +       addi sp, sp, -(PT_SIZE_ON_STACK)
> +       save_gp
>
>         /*
>          * Disable user-mode memory access as it should only be set in the
> @@ -234,35 +239,7 @@ ENTRY(handle_kernel_stack_overflow)
>         addi sp, sp, -(PT_SIZE_ON_STACK)
>
>         //save context to overflow stack
> -       REG_S x1,  PT_RA(sp)
> -       REG_S x3,  PT_GP(sp)
> -       REG_S x5,  PT_T0(sp)
> -       REG_S x6,  PT_T1(sp)
> -       REG_S x7,  PT_T2(sp)
> -       REG_S x8,  PT_S0(sp)
> -       REG_S x9,  PT_S1(sp)
> -       REG_S x10, PT_A0(sp)
> -       REG_S x11, PT_A1(sp)
> -       REG_S x12, PT_A2(sp)
> -       REG_S x13, PT_A3(sp)
> -       REG_S x14, PT_A4(sp)
> -       REG_S x15, PT_A5(sp)
> -       REG_S x16, PT_A6(sp)
> -       REG_S x17, PT_A7(sp)
> -       REG_S x18, PT_S2(sp)
> -       REG_S x19, PT_S3(sp)
> -       REG_S x20, PT_S4(sp)
> -       REG_S x21, PT_S5(sp)
> -       REG_S x22, PT_S6(sp)
> -       REG_S x23, PT_S7(sp)
> -       REG_S x24, PT_S8(sp)
> -       REG_S x25, PT_S9(sp)
> -       REG_S x26, PT_S10(sp)
> -       REG_S x27, PT_S11(sp)
> -       REG_S x28, PT_T3(sp)
> -       REG_S x29, PT_T4(sp)
> -       REG_S x30, PT_T5(sp)
> -       REG_S x31, PT_T6(sp)
> +       save_gp
>
>         REG_L s0, TASK_TI_KERNEL_SP(tp)
>         csrr s1, CSR_STATUS
> --
> 2.34.1
>


--
Best Regards
 Guo Ren
