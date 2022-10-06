Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B8B5F6147
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 08:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiJFG6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 02:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiJFG6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 02:58:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B97424B990
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 23:57:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C5E3B81FFC
        for <linux-kernel@vger.kernel.org>; Thu,  6 Oct 2022 06:57:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C36DC433C1;
        Thu,  6 Oct 2022 06:57:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665039477;
        bh=Oyr2f6WxgPXWa0Z4Ntcod1sqiu+XPoJXS7GJvpW9qzI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WN0Nyy8vfTl6wuVRD+gqBy+UYzCYMv6t5ua9bFIMsHbR2vvQsuKVqqrBPnzF4Gwcg
         s92qyokcS3OUV/E86lQv0wKCcPGshgD2T8bLK0mCJbDMbEDhhubqbuLjnsmA+SVEGE
         pBwShFzvlSyDlHFznwgrZlz0oPlwv6Pn4Eg/vnwpxvPSYrQKFEWs5bD5VWgFLnPBV3
         hUN+ExpwqhfhvhZQkE8dfRJCnqZuZuXKxmn2lsIEoz7G4/vfUSTYGh6Vo/8/fXeWD1
         xNOvuGtqyJWXPZgnGYTHn1BN/FCJqHFQFKL1dg7mF67E1z3xDN9YwUAoN38UVF4o88
         T8cQT9z+D1JPQ==
Date:   Thu, 6 Oct 2022 14:48:11 +0800
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        linux-riscv@lists.infradead.org, Albert Ou <aou@eecs.berkeley.edu>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>, Dao Lu <daolu@rivosinc.com>,
        Guo Ren <guoren@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix build with CONFIG_CC_OPTIMIZE_FOR_SIZE=y
Message-ID: <Yz56K2W/6ttN1SLT@xhacker>
References: <20220922060958.44203-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220922060958.44203-1-samuel@sholland.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 01:09:58AM -0500, Samuel Holland wrote:
> commit 8eb060e10185 ("arch/riscv: add Zihintpause support") broke
> building with CONFIG_CC_OPTIMIZE_FOR_SIZE enabled (gcc 11.1.0):
> 
>   CC      arch/riscv/kernel/vdso/vgettimeofday.o
> In file included from <command-line>:
> ./arch/riscv/include/asm/jump_label.h: In function 'cpu_relax':
> ././include/linux/compiler_types.h:285:33: warning: 'asm' operand 0 probably does not match constraints
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> ././include/linux/compiler_types.h:285:33: error: impossible constraint in 'asm'
>   285 | #define asm_volatile_goto(x...) asm goto(x)
>       |                                 ^~~
> ./arch/riscv/include/asm/jump_label.h:41:9: note: in expansion of macro 'asm_volatile_goto'
>    41 |         asm_volatile_goto(
>       |         ^~~~~~~~~~~~~~~~~
> make[1]: *** [scripts/Makefile.build:249: arch/riscv/kernel/vdso/vgettimeofday.o] Error 1
> make: *** [arch/riscv/Makefile:128: vdso_prepare] Error 2
> 
> Having a static branch in cpu_relax() is problematic because that
> function is widely inlined, including in some quite complex functions
> like in the VDSO. A quick measurement shows this static branch is
> responsible by itself for around 40% of the jump table.
> 
> Drop the static branch, which ends up being the same number of
> instructions anyway. If Zihintpause is supported, we trade the nop from
> the static branch for a div. If Zihintpause is unsupported, we trade the
> jump from the static branch for (what gets interpreted as) a nop.

Hi Samuel,

I'm not sure whether it's correct to remove static branch usage from
cpu_relax, but your report inspired my patch of constifying arguments
of arch_static_branch() and arch_static_branch_jump() [1]. Could you
please also test it?

Thanks very much

[1]https://lore.kernel.org/linux-riscv/20221006064028.548-1-jszhang@kernel.org/T/#u

> 
> Fixes: 8eb060e10185 ("arch/riscv: add Zihintpause support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>
> ---
> 
>  arch/riscv/include/asm/hwcap.h          |  3 ---
>  arch/riscv/include/asm/vdso/processor.h | 25 ++++++++++---------------
>  2 files changed, 10 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
> index 6f59ec64175e..b21d46e68386 100644
> --- a/arch/riscv/include/asm/hwcap.h
> +++ b/arch/riscv/include/asm/hwcap.h
> @@ -68,7 +68,6 @@ enum riscv_isa_ext_id {
>   */
>  enum riscv_isa_ext_key {
>  	RISCV_ISA_EXT_KEY_FPU,		/* For 'F' and 'D' */
> -	RISCV_ISA_EXT_KEY_ZIHINTPAUSE,
>  	RISCV_ISA_EXT_KEY_MAX,
>  };
>  
> @@ -88,8 +87,6 @@ static __always_inline int riscv_isa_ext2key(int num)
>  		return RISCV_ISA_EXT_KEY_FPU;
>  	case RISCV_ISA_EXT_d:
>  		return RISCV_ISA_EXT_KEY_FPU;
> -	case RISCV_ISA_EXT_ZIHINTPAUSE:
> -		return RISCV_ISA_EXT_KEY_ZIHINTPAUSE;
>  	default:
>  		return -EINVAL;
>  	}
> diff --git a/arch/riscv/include/asm/vdso/processor.h b/arch/riscv/include/asm/vdso/processor.h
> index 1e4f8b4aef79..789bdb8211a2 100644
> --- a/arch/riscv/include/asm/vdso/processor.h
> +++ b/arch/riscv/include/asm/vdso/processor.h
> @@ -4,30 +4,25 @@
>  
>  #ifndef __ASSEMBLY__
>  
> -#include <linux/jump_label.h>
>  #include <asm/barrier.h>
> -#include <asm/hwcap.h>
>  
>  static inline void cpu_relax(void)
>  {
> -	if (!static_branch_likely(&riscv_isa_ext_keys[RISCV_ISA_EXT_KEY_ZIHINTPAUSE])) {
>  #ifdef __riscv_muldiv
> -		int dummy;
> -		/* In lieu of a halt instruction, induce a long-latency stall. */
> -		__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
> +	int dummy;
> +	/* In lieu of a halt instruction, induce a long-latency stall. */
> +	__asm__ __volatile__ ("div %0, %0, zero" : "=r" (dummy));
>  #endif
> -	} else {
> -		/*
> -		 * Reduce instruction retirement.
> -		 * This assumes the PC changes.
> -		 */
> +	/*
> +	 * Reduce instruction retirement.
> +	 * This assumes the PC changes.
> +	 */
>  #ifdef __riscv_zihintpause
> -		__asm__ __volatile__ ("pause");
> +	__asm__ __volatile__ ("pause");
>  #else
> -		/* Encoding of the pause instruction */
> -		__asm__ __volatile__ (".4byte 0x100000F");
> +	/* Encoding of the pause instruction */
> +	__asm__ __volatile__ (".4byte 0x100000F");
>  #endif
> -	}
>  	barrier();
>  }
>  
> -- 
> 2.35.1
> 
