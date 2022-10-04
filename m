Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D6D5F4716
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229851AbiJDQDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiJDQDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:03:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F636606A7
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:03:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1ECD6B81AD5
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:03:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F98C4347C
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 16:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664899426;
        bh=XWU1JKRC7NI+h/w8R5x8piuwrX888p+n72p/dEpZdpE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NUSztFFLQhx1jhQbyQ6ap7QSuKAprJQkxlYqYCKMGb9TsvVDEYnL+m2CFXOda+xa4
         psRVXPHxnpnyo47vrMLnJpf9RpsY0+iBURTyNtt1O/75aMsjrcb3Wl19VIB2z8AH0S
         hMnHRIGot9G+07Huk2XrG+ekPoRNQFfywoZhrUbkES3Vb5eU1LdoN7LWkax5ERdkHz
         Iis6gmPxfjU2jXWjSr+haR8ZesSUYt0t8xSHcuLDasvmSXfU/uib65rDYWCmep6Qez
         EioJamBCd31GzW/6pCkcqqt9JVeioo4WfKfBbUbAjKEx9b68kd5btV4E87+NMJ7JyR
         FKK49GT95z75w==
Received: by mail-oi1-f173.google.com with SMTP id g130so14808401oia.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:03:46 -0700 (PDT)
X-Gm-Message-State: ACrzQf1ysjWQlGanNgtqAiEk8GrP8I5Mb4wMYW2iBHWb7gMReZhkIxQr
        q56x8s1n3U1mAvfgLCDI5V9kaGd1gQN13svoNm0=
X-Google-Smtp-Source: AMsMyM44JllKE7LW8zT6nJCzI4eCn5+eHPo9ip6/7voQYhkNJrueGVFrnyFaLQRPe2Awh599kFSXJo2iM0H65m8g+SA=
X-Received: by 2002:a05:6808:151f:b0:350:1b5e:2380 with SMTP id
 u31-20020a056808151f00b003501b5e2380mr237126oiw.112.1664899425880; Tue, 04
 Oct 2022 09:03:45 -0700 (PDT)
MIME-Version: 1.0
References: <20221003102921.3973-1-jszhang@kernel.org> <20221003102921.3973-5-jszhang@kernel.org>
In-Reply-To: <20221003102921.3973-5-jszhang@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Wed, 5 Oct 2022 00:03:33 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQckQaq1c-P6dJ5O3S6fmMQ2-uxNhQHfn+o=W7bphZg6g@mail.gmail.com>
Message-ID: <CAJF2gTQckQaq1c-P6dJ5O3S6fmMQ2-uxNhQHfn+o=W7bphZg6g@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] riscv: entry: consolidate general regs saving/restoring
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Guo Ren <guoren@kernel.org>

On Mon, Oct 3, 2022 at 6:39 PM Jisheng Zhang <jszhang@kernel.org> wrote:
>
> Consolidate the saving/restoring GPs(except zero, ra, sp, gp and tp) into
> save_from_x5_to_x31/restore_from_x5_to_x31 macros.
>
> No functional change intended.
>
> Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
> ---
>  arch/riscv/include/asm/asm.h   | 63 +++++++++++++++++++++++++
>  arch/riscv/kernel/entry.S      | 84 ++--------------------------------
>  arch/riscv/kernel/mcount-dyn.S | 56 +----------------------
>  3 files changed, 68 insertions(+), 135 deletions(-)
>
> diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
> index 1b471ff73178..bf5247aa317d 100644
> --- a/arch/riscv/include/asm/asm.h
> +++ b/arch/riscv/include/asm/asm.h
> @@ -68,6 +68,7 @@
>  #endif
>
>  #ifdef __ASSEMBLY__
> +#include <asm/asm-offsets.h>
>
>  /* Common assembly source macros */
>
> @@ -80,6 +81,68 @@
>         .endr
>  .endm
>
> +       /* save all GPs except zero, ra, sp, gp and tp */
> +       .macro save_from_x5_to_x31
> +       REG_S x5,  PT_T0(sp)
> +       REG_S x6,  PT_T1(sp)
> +       REG_S x7,  PT_T2(sp)
> +       REG_S x8,  PT_S0(sp)
> +       REG_S x9,  PT_S1(sp)
> +       REG_S x10, PT_A0(sp)
> +       REG_S x11, PT_A1(sp)
> +       REG_S x12, PT_A2(sp)
> +       REG_S x13, PT_A3(sp)
> +       REG_S x14, PT_A4(sp)
> +       REG_S x15, PT_A5(sp)
> +       REG_S x16, PT_A6(sp)
> +       REG_S x17, PT_A7(sp)
> +       REG_S x18, PT_S2(sp)
> +       REG_S x19, PT_S3(sp)
> +       REG_S x20, PT_S4(sp)
> +       REG_S x21, PT_S5(sp)
> +       REG_S x22, PT_S6(sp)
> +       REG_S x23, PT_S7(sp)
> +       REG_S x24, PT_S8(sp)
> +       REG_S x25, PT_S9(sp)
> +       REG_S x26, PT_S10(sp)
> +       REG_S x27, PT_S11(sp)
> +       REG_S x28, PT_T3(sp)
> +       REG_S x29, PT_T4(sp)
> +       REG_S x30, PT_T5(sp)
> +       REG_S x31, PT_T6(sp)
> +       .endm
> +
> +       /* restore all GPs except zero, ra, sp, gp and tp */
> +       .macro restore_from_x5_to_x31
> +       REG_L x5,  PT_T0(sp)
> +       REG_L x6,  PT_T1(sp)
> +       REG_L x7,  PT_T2(sp)
> +       REG_L x8,  PT_S0(sp)
> +       REG_L x9,  PT_S1(sp)
> +       REG_L x10, PT_A0(sp)
> +       REG_L x11, PT_A1(sp)
> +       REG_L x12, PT_A2(sp)
> +       REG_L x13, PT_A3(sp)
> +       REG_L x14, PT_A4(sp)
> +       REG_L x15, PT_A5(sp)
> +       REG_L x16, PT_A6(sp)
> +       REG_L x17, PT_A7(sp)
> +       REG_L x18, PT_S2(sp)
> +       REG_L x19, PT_S3(sp)
> +       REG_L x20, PT_S4(sp)
> +       REG_L x21, PT_S5(sp)
> +       REG_L x22, PT_S6(sp)
> +       REG_L x23, PT_S7(sp)
> +       REG_L x24, PT_S8(sp)
> +       REG_L x25, PT_S9(sp)
> +       REG_L x26, PT_S10(sp)
> +       REG_L x27, PT_S11(sp)
> +       REG_L x28, PT_T3(sp)
> +       REG_L x29, PT_T4(sp)
> +       REG_L x30, PT_T5(sp)
> +       REG_L x31, PT_T6(sp)
> +       .endm
> +
>  #endif /* __ASSEMBLY__ */
>
>  #endif /* _ASM_RISCV_ASM_H */
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 48ed1df7a792..7ba3826dde84 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -41,33 +41,7 @@ _save_context:
>         addi sp, sp, -(PT_SIZE_ON_STACK)
>         REG_S x1,  PT_RA(sp)
>         REG_S x3,  PT_GP(sp)
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
> +       save_from_x5_to_x31
>
>         /*
>          * Disable user-mode memory access as it should only be set in the
> @@ -184,33 +158,7 @@ ENTRY(ret_from_exception)
>         REG_L x1,  PT_RA(sp)
>         REG_L x3,  PT_GP(sp)
>         REG_L x4,  PT_TP(sp)
> -       REG_L x5,  PT_T0(sp)
> -       REG_L x6,  PT_T1(sp)
> -       REG_L x7,  PT_T2(sp)
> -       REG_L x8,  PT_S0(sp)
> -       REG_L x9,  PT_S1(sp)
> -       REG_L x10, PT_A0(sp)
> -       REG_L x11, PT_A1(sp)
> -       REG_L x12, PT_A2(sp)
> -       REG_L x13, PT_A3(sp)
> -       REG_L x14, PT_A4(sp)
> -       REG_L x15, PT_A5(sp)
> -       REG_L x16, PT_A6(sp)
> -       REG_L x17, PT_A7(sp)
> -       REG_L x18, PT_S2(sp)
> -       REG_L x19, PT_S3(sp)
> -       REG_L x20, PT_S4(sp)
> -       REG_L x21, PT_S5(sp)
> -       REG_L x22, PT_S6(sp)
> -       REG_L x23, PT_S7(sp)
> -       REG_L x24, PT_S8(sp)
> -       REG_L x25, PT_S9(sp)
> -       REG_L x26, PT_S10(sp)
> -       REG_L x27, PT_S11(sp)
> -       REG_L x28, PT_T3(sp)
> -       REG_L x29, PT_T4(sp)
> -       REG_L x30, PT_T5(sp)
> -       REG_L x31, PT_T6(sp)
> +       restore_from_x5_to_x31
>
>         REG_L x2,  PT_SP(sp)
>
> @@ -238,33 +186,7 @@ ENTRY(handle_kernel_stack_overflow)
>         //save context to overflow stack
>         REG_S x1,  PT_RA(sp)
>         REG_S x3,  PT_GP(sp)
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
> +       save_from_x5_to_x31
>
>         REG_L s0, TASK_TI_KERNEL_SP(tp)
>         csrr s1, CSR_STATUS
> diff --git a/arch/riscv/kernel/mcount-dyn.S b/arch/riscv/kernel/mcount-dyn.S
> index d171eca623b6..040d098279a9 100644
> --- a/arch/riscv/kernel/mcount-dyn.S
> +++ b/arch/riscv/kernel/mcount-dyn.S
> @@ -70,33 +70,7 @@
>         REG_S x2,  PT_SP(sp)
>         REG_S x3,  PT_GP(sp)
>         REG_S x4,  PT_TP(sp)
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
> +       save_from_x5_to_x31
>         .endm
>
>         .macro RESTORE_ALL
> @@ -108,33 +82,7 @@
>         REG_L x2,  PT_SP(sp)
>         REG_L x3,  PT_GP(sp)
>         REG_L x4,  PT_TP(sp)
> -       REG_L x5,  PT_T0(sp)
> -       REG_L x6,  PT_T1(sp)
> -       REG_L x7,  PT_T2(sp)
> -       REG_L x8,  PT_S0(sp)
> -       REG_L x9,  PT_S1(sp)
> -       REG_L x10, PT_A0(sp)
> -       REG_L x11, PT_A1(sp)
> -       REG_L x12, PT_A2(sp)
> -       REG_L x13, PT_A3(sp)
> -       REG_L x14, PT_A4(sp)
> -       REG_L x15, PT_A5(sp)
> -       REG_L x16, PT_A6(sp)
> -       REG_L x17, PT_A7(sp)
> -       REG_L x18, PT_S2(sp)
> -       REG_L x19, PT_S3(sp)
> -       REG_L x20, PT_S4(sp)
> -       REG_L x21, PT_S5(sp)
> -       REG_L x22, PT_S6(sp)
> -       REG_L x23, PT_S7(sp)
> -       REG_L x24, PT_S8(sp)
> -       REG_L x25, PT_S9(sp)
> -       REG_L x26, PT_S10(sp)
> -       REG_L x27, PT_S11(sp)
> -       REG_L x28, PT_T3(sp)
> -       REG_L x29, PT_T4(sp)
> -       REG_L x30, PT_T5(sp)
> -       REG_L x31, PT_T6(sp)
> +       restore_from_x5_to_x31
>
>         addi    sp, sp, PT_SIZE_ON_STACK
>         addi    sp, sp, SZREG
> --
> 2.37.2
>


-- 
Best Regards
 Guo Ren
