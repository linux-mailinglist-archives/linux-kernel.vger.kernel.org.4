Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B826A19D8
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 11:19:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjBXKTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 05:19:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjBXKTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:19:22 -0500
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1BA18B2E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:19:19 -0800 (PST)
Received: (Authenticated sender: alex@ghiti.fr)
        by mail.gandi.net (Postfix) with ESMTPSA id 7DF89FF80D;
        Fri, 24 Feb 2023 10:19:14 +0000 (UTC)
Message-ID: <651d5f06-a22b-4cd9-1ec7-d198adf0a6f1@ghiti.fr>
Date:   Fri, 24 Feb 2023 11:19:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 2/4] RISC-V: Factor out common code of
 __cpu_resume_enter()
Content-Language: en-US
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>,
        paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        leyfoon.tan@starfivetech.com, mason.huo@starfivetech.com
References: <20230221023523.1498500-1-jeeheng.sia@starfivetech.com>
 <20230221023523.1498500-3-jeeheng.sia@starfivetech.com>
From:   Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <20230221023523.1498500-3-jeeheng.sia@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sia,

On 2/21/23 03:35, Sia Jee Heng wrote:
> The cpu_resume() function is very similar for the suspend to disk and
> suspend to ram cases. Factor out the common code into restore_csr macro
> and restore_reg macro.
>
> Signed-off-by: Sia Jee Heng <jeeheng.sia@starfivetech.com>
> ---
>   arch/riscv/include/asm/assembler.h | 62 ++++++++++++++++++++++++++++++
>   arch/riscv/kernel/suspend_entry.S  | 34 ++--------------
>   2 files changed, 65 insertions(+), 31 deletions(-)
>   create mode 100644 arch/riscv/include/asm/assembler.h
>
> diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
> new file mode 100644
> index 000000000000..727a97735493
> --- /dev/null
> +++ b/arch/riscv/include/asm/assembler.h
> @@ -0,0 +1,62 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> + *
> + * Author: Jee Heng Sia <jeeheng.sia@starfivetech.com>
> + */
> +
> +#ifndef __ASSEMBLY__
> +#error "Only include this from assembly code"
> +#endif
> +
> +#ifndef __ASM_ASSEMBLER_H
> +#define __ASM_ASSEMBLER_H
> +
> +#include <asm/asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/csr.h>
> +
> +/*
> + * restore_csr - restore hart's CSR value
> + */
> +	.macro restore_csr
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> +		csrw	CSR_EPC, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> +		csrw	CSR_STATUS, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> +		csrw	CSR_TVAL, t0
> +		REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> +		csrw	CSR_CAUSE, t0
> +	.endm
> +
> +/*
> + * restore_reg - Restore registers (except A0 and T0-T6)
> + */
> +	.macro restore_reg
> +		REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> +		REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> +		REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> +		REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> +		REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> +		REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> +		REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> +		REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> +		REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> +		REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> +		REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> +		REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> +		REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> +		REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> +		REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> +		REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> +		REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> +		REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> +		REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> +		REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> +		REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> +		REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> +		REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +	.endm
> +
> +#endif	/* __ASM_ASSEMBLER_H */


You introduce assembler.h which in the future may contain other assembly 
functions not related to suspend: I'd rename those macros so that we 
know they are suspend related, something like 
suspend_restore_regs/suspend_restore_csrs.

And instead of (SUSPEND_CONTEXT_REGS + PT_XXX) you could introduce 
SUSPEND_CONTEXT_REGS_PT_XXX in asm-offsets.c?


> diff --git a/arch/riscv/kernel/suspend_entry.S b/arch/riscv/kernel/suspend_entry.S
> index aafcca58c19d..74a8fab8e0f6 100644
> --- a/arch/riscv/kernel/suspend_entry.S
> +++ b/arch/riscv/kernel/suspend_entry.S
> @@ -7,6 +7,7 @@
>   #include <linux/linkage.h>
>   #include <asm/asm.h>
>   #include <asm/asm-offsets.h>
> +#include <asm/assembler.h>
>   #include <asm/csr.h>
>   #include <asm/xip_fixup.h>
>   
> @@ -83,39 +84,10 @@ ENTRY(__cpu_resume_enter)
>   	add	a0, a1, zero
>   
>   	/* Restore CSRs */
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_EPC)(a0)
> -	csrw	CSR_EPC, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_STATUS)(a0)
> -	csrw	CSR_STATUS, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_BADADDR)(a0)
> -	csrw	CSR_TVAL, t0
> -	REG_L	t0, (SUSPEND_CONTEXT_REGS + PT_CAUSE)(a0)
> -	csrw	CSR_CAUSE, t0
> +	restore_csr
>   
>   	/* Restore registers (except A0 and T0-T6) */
> -	REG_L	ra, (SUSPEND_CONTEXT_REGS + PT_RA)(a0)
> -	REG_L	sp, (SUSPEND_CONTEXT_REGS + PT_SP)(a0)
> -	REG_L	gp, (SUSPEND_CONTEXT_REGS + PT_GP)(a0)
> -	REG_L	tp, (SUSPEND_CONTEXT_REGS + PT_TP)(a0)
> -	REG_L	s0, (SUSPEND_CONTEXT_REGS + PT_S0)(a0)
> -	REG_L	s1, (SUSPEND_CONTEXT_REGS + PT_S1)(a0)
> -	REG_L	a1, (SUSPEND_CONTEXT_REGS + PT_A1)(a0)
> -	REG_L	a2, (SUSPEND_CONTEXT_REGS + PT_A2)(a0)
> -	REG_L	a3, (SUSPEND_CONTEXT_REGS + PT_A3)(a0)
> -	REG_L	a4, (SUSPEND_CONTEXT_REGS + PT_A4)(a0)
> -	REG_L	a5, (SUSPEND_CONTEXT_REGS + PT_A5)(a0)
> -	REG_L	a6, (SUSPEND_CONTEXT_REGS + PT_A6)(a0)
> -	REG_L	a7, (SUSPEND_CONTEXT_REGS + PT_A7)(a0)
> -	REG_L	s2, (SUSPEND_CONTEXT_REGS + PT_S2)(a0)
> -	REG_L	s3, (SUSPEND_CONTEXT_REGS + PT_S3)(a0)
> -	REG_L	s4, (SUSPEND_CONTEXT_REGS + PT_S4)(a0)
> -	REG_L	s5, (SUSPEND_CONTEXT_REGS + PT_S5)(a0)
> -	REG_L	s6, (SUSPEND_CONTEXT_REGS + PT_S6)(a0)
> -	REG_L	s7, (SUSPEND_CONTEXT_REGS + PT_S7)(a0)
> -	REG_L	s8, (SUSPEND_CONTEXT_REGS + PT_S8)(a0)
> -	REG_L	s9, (SUSPEND_CONTEXT_REGS + PT_S9)(a0)
> -	REG_L	s10, (SUSPEND_CONTEXT_REGS + PT_S10)(a0)
> -	REG_L	s11, (SUSPEND_CONTEXT_REGS + PT_S11)(a0)
> +	restore_reg
>   
>   	/* Return zero value */
>   	add	a0, zero, zero
