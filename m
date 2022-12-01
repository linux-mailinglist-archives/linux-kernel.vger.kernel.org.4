Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57BE463F54F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 17:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiLAQb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 11:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232208AbiLAQbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 11:31:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A67A80B8
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 08:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C638B81F90
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 16:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C491C433C1;
        Thu,  1 Dec 2022 16:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669912309;
        bh=d2Jl/HzZ3cLunjfqczW81B/ARLzmlgq+fe3WizaptYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cPQQHIu6HSPXnXx/X0EOrt8jWH0GSCTDEfAB+V/QrFJmzcy2qPp7VwQozOnBxn8+Y
         8oSoev4dJE4sdMU7zkLBtqmE+tAA1CXaw50/mJjmIfmPJp1OqfdN5ix/K/kHXizG+m
         RIKm9cXSghKS5FnbVOqwdw2rlkb1E8uKNnNxJkxKjohmCr1OFPFTdpafPKLlZE3jWj
         u6oUl4DYSh19YGRvB6PUmOzFVFyoKGIeZYOEi3fEGNDy4KsXhQ6zYq22qqYxJF6+VX
         mBA04NX0NP61E83hUFCgNv2223N6+yJg4ot0u4fCaeedU65UpTpCBQjtykdVsKE+05
         DHYExtHSggaQQ==
Date:   Fri, 2 Dec 2022 00:21:55 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     guoren@kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] RISC-V: Add some comments about the shadow and
 overflow stacks
Message-ID: <Y4jUo09vh7PudmXW@xhacker>
References: <20221130023515.20217-1-palmer@rivosinc.com>
 <20221130023515.20217-2-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221130023515.20217-2-palmer@rivosinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 29, 2022 at 06:35:15PM -0800, Palmer Dabbelt wrote:
> It took me a while to page all this back in when trying to review the
> recent spin_shadow_stack, so I figured I'd just write up some comments.
> 
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>

Reviewed-by: Jisheng Zhang <jszhang@kernel.org>

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
>  		overflow_stack)__aligned(16);
>  /*
> - * shadow stack, handled_ kernel_ stack_ overflow(in kernel/entry.S) is used
> - * to get per-cpu overflow stack(get_overflow_stack).
> + * A temporary stack for use by handle_kernel_stack_overflow.  This is used so
> + * we can call into C code to get the per-hart overflow stack.  Usage of this
> + * stack must be protected by spin_shadow_stack.
>   */
>  long shadow_stack[SHADOW_OVERFLOW_STACK_SIZE/sizeof(long)] __aligned(16);
> -asmlinkage unsigned long get_overflow_stack(void)
> -{
> -	return (unsigned long)this_cpu_ptr(overflow_stack) +
> -		OVERFLOW_STACK_SIZE;
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
> +	return (unsigned long)this_cpu_ptr(overflow_stack) +
> +		OVERFLOW_STACK_SIZE;
> +}
> +
>  asmlinkage void handle_bad_stack(struct pt_regs *regs)
>  {
>  	unsigned long tsk_stk = (unsigned long)current->stack;
> -- 
> 2.38.1
> 
