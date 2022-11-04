Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF3618FCC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 06:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiKDFCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 01:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiKDFCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 01:02:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF47027FED
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 22:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 67C8BB82BD5
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 05:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D27EC433D6;
        Fri,  4 Nov 2022 05:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
        t=1667538089; bh=UC4QqaY95lw4qInX215V9aUJTnKnVXWxx0zctNKV9qo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=e+ogq1OZvE0UGCTg1vv7pBCqwNRxO3owbg8QruvLpPmjdvkcN9lWFy1E1c/42jzv0
         TkKDsyEMHz56amq8ZnXyXMdaai++lsG95SAnHN6qqXFzSxHa81saVYYXJ8yzkRcVV0
         ddlreiwM2pfK5I0Cvl5VgiW1Psbl0tkwUQkdu36U=
Message-ID: <1c74ac94-50db-ceb3-234d-f8f227de8f6e@linux.dev>
Date:   Thu, 3 Nov 2022 22:01:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v12 06/17] riscv: Reset vector register
Content-Language: en-US
To:     Chris Stillson <stillson@rivosinc.com>
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        Han-Kuan Chen <hankuan.chen@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@atishpatra.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Guo Ren <guoren@kernel.org>,
        Mayuresh Chitale <mchitale@ventanamicro.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Andy Chiu <andy.chiu@sifive.com>
References: <20220921214439.1491510-1-stillson@rivosinc.com>
 <20220921214439.1491510-6-stillson@rivosinc.com>
From:   Vineet Gupta <vineet.gupta@linux.dev>
In-Reply-To: <20220921214439.1491510-6-stillson@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 14:43, Chris Stillson wrote:
> From: Guo Ren <guoren@linux.alibaba.com>
> 
> Reset vector registers at boot-time and disable vector instructions
> execution for kernel mode.

Perhaps bike-shedding, but "Reset" has a different connotation in 
kernel, this is clear registers IMO. And "Reset Vector ..." sounds 
totally different at first glance.


> -	 * Disable the FPU to detect illegal usage of floating point in kernel
> -	 * space.
> +	 * Disable the FPU/Vector to detect illegal usage of floating point
> +	 * or vector in kernel space.
>   	 */
> -	li t0, SR_SUM | SR_FS
> +	li t0, SR_SUM | SR_FS | SR_VS

Is VS writable in implementations not implementing V hardware.

Priv spec seems to be confusing. It states

    "The FS[1:0] and VS[1:0] WARL fields..."

Above implies it can be written always but will read legal values only.
But then this follows.

	"If neither the v registers nor S-mode is implemented, then VS 	
	is read-only zero. If S-mode is implemented but the v registers
	are not, VS may optionally be read-only zero"

What does optionally mean for software ?

>   
>   	REG_L s0, TASK_TI_USER_SP(tp)
>   	csrrc s1, CSR_STATUS, t0
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index b865046e4dbb..2c81ca42ec4e 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -140,10 +140,10 @@ secondary_start_sbi:
>   	.option pop
>   
>   	/*
> -	 * Disable FPU to detect illegal usage of
> -	 * floating point in kernel space
> +	 * Disable FPU & VECTOR to detect illegal usage of
> +	 * floating point or vector in kernel space
>   	 */
> -	li t0, SR_FS
> +	li t0, SR_FS | SR_VS
>   	csrc CSR_STATUS, t0
>   
>   	/* Set trap vector to spin forever to help debug */
> @@ -234,10 +234,10 @@ pmp_done:
>   .option pop
>   
>   	/*
> -	 * Disable FPU to detect illegal usage of
> -	 * floating point in kernel space
> +	 * Disable FPU & VECTOR to detect illegal usage of
> +	 * floating point or vector in kernel space
>   	 */
> -	li t0, SR_FS
> +	li t0, SR_FS | SR_VS
>   	csrc CSR_STATUS, t0

Third instance of duplicated SR_FS | SR_VS. Better to add a helper 
SR_FS_VS or some such macro.

>   
>   #ifdef CONFIG_RISCV_BOOT_SPINWAIT
> @@ -431,6 +431,29 @@ ENTRY(reset_regs)
>   	csrw	fcsr, 0
>   	/* note that the caller must clear SR_FS */
>   #endif /* CONFIG_FPU */
> +
> +#ifdef CONFIG_VECTOR
> +	csrr	t0, CSR_MISA
> +	li	t1, COMPAT_HWCAP_ISA_V
> +	and	t0, t0, t1
> +	beqz	t0, .Lreset_regs_done
> +
> +	/*
> +	 * Clear vector registers and reset vcsr
> +	 * VLMAX has a defined value, VLEN is a constant,
> +	 * and this form of vsetvli is defined to set vl to VLMAX.
> +	 */
> +	li	t1, SR_VS
> +	csrs	CSR_STATUS, t1
> +	csrs	CSR_VCSR, x0
> +	vsetvli t1, x0, e8, m8, ta, ma
> +	vmv.v.i v0, 0
> +	vmv.v.i v8, 0
> +	vmv.v.i v16, 0
> +	vmv.v.i v24, 0
> +	/* note that the caller must clear SR_VS */

Is that actually happening ?


