Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18D060F6E3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 14:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235301AbiJ0MMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 08:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbiJ0MMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 08:12:30 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C1C05106A79
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 05:12:28 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 34ADB23A;
        Thu, 27 Oct 2022 05:12:34 -0700 (PDT)
Received: from FVFF77S0Q05N (unknown [10.57.1.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DDBA03F7B4;
        Thu, 27 Oct 2022 05:12:25 -0700 (PDT)
Date:   Thu, 27 Oct 2022 13:12:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>,
        James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH] arm64: Enable data independent timing (DIT) in the
 kernel
Message-ID: <Y1p1oKCE+paB8JUK@FVFF77S0Q05N>
References: <20221027112741.1678057-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221027112741.1678057-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 01:27:41PM +0200, Ard Biesheuvel wrote:
> The ARM architecture revision v8.4 introduces a data independent timing
> control (DIT) which can be set at any exception level, and instructs the
> CPU to avoid optimizations that may result in a correlation between the
> execution time of certain instructions and the value of the data they
> operate on.
> 
> The DIT bit is part of PSTATE, and is therefore context switched as
> usual, given that it becomes part of the saved program state (SPSR) when
> taking an exception. We have also defined a hwcap for DIT, and so user
> space can discover already whether or nor DIT is available. This means
> that, as far as user space is concerned, DIT is wired up and fully
> functional.
> 
> In the kernel, however, we never bothered with DIT: we disable at it
> boot (i.e., INIT_PSTATE_EL1 has DIT cleared) and ignore the fact that we
> might run with DIT enabled if user space happened to set it.

FWIW, I did raise this with some architects a while back, and the thinking at
the time was that implementations were likely to have data independent timing
regardless of the value of the DIT bit, and so manipulating this at exception
entry was busy work with no actual gain (especially if we had to handle
mismatched big.LITTLE systems).

Since then, I have become aware of some possible implementation choices which
would consider the bit (though I have no idea if anyone is building such
implementations).

> Given that running privileged code with DIT disabled on a CPU that
> implements support for it may result in a side channel that exposes
> privileged data to unprivileged user space processes,

I appreciate this is a simple way to rule out issues of that sort, but I think
the "may" in that sentence is doing a lot of work, since:

* IIUC, we don't have a specific case in mind that we're concerned about. I can
  believe that we think all the crypto code we intend to be constant time is
  theoretically affected.

* IIUC we haven't gone an audited all constant-time code to check it doesn't
  happen to use instructions with data-dependent-timing. So there might be more
  work to do atop this to ensure theoretical correctness.

* AFAIK there are no contemporary implementations where the DIT is both
  implemented and it being clear results in data-dependent-timing. i.e. we have
  nothing to actually test on.
 
Given that, it would be nice if we could make this a bit clearer, e.g. state
that this is currently a belt-and-braces approach for theoretical cases, rather
than an extant side-channel today (as far as we're aware).

> let's enable DIT while running in the kernel if supported by all CPUs.

FWIW, I think it's reasonable to do this when all CPUs have DIT.

I have a slight fear that (as above) if there are future CPUs which do consider
DIT, there's presumably a noticeable performance difference (or the CPU would
just provide data-independent-timing regardless), but I'm not sure if that's
just something we have to live with or could punt on until we notice such
cases.

> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Eric Biggers <ebiggers@kernel.org>
> Cc: Jason A. Donenfeld <Jason@zx2c4.com>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Adam Langley <agl@google.com>
> Link: https://lore.kernel.org/all/YwgCrqutxmX0W72r@gmail.com/
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/include/asm/sysreg.h |  3 +++
>  arch/arm64/kernel/cpufeature.c  | 16 ++++++++++++++++
>  arch/arm64/kernel/entry.S       |  3 +++
>  arch/arm64/tools/cpucaps        |  1 +
>  4 files changed, 23 insertions(+)

Don't we also need to touch __cpu_suspend_exit() in arch/am64/kernel/suspend.c?
I'm assuming so given that has __uaccess_enable_hw_pan() today.

Presumably we'd also care about this in KVM hyp code?

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 7d301700d1a9..18e065f5130c 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -94,15 +94,18 @@
>  #define PSTATE_PAN			pstate_field(0, 4)
>  #define PSTATE_UAO			pstate_field(0, 3)
>  #define PSTATE_SSBS			pstate_field(3, 1)
> +#define PSTATE_DIT			pstate_field(3, 2)
>  #define PSTATE_TCO			pstate_field(3, 4)
>  
>  #define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
>  #define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
>  #define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
> +#define SET_PSTATE_DIT(x)		__emit_inst(0xd500401f | PSTATE_DIT | ((!!x) << PSTATE_Imm_shift))
>  #define SET_PSTATE_TCO(x)		__emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
>  
>  #define set_pstate_pan(x)		asm volatile(SET_PSTATE_PAN(x))
>  #define set_pstate_uao(x)		asm volatile(SET_PSTATE_UAO(x))
> +#define set_pstate_dit(x)		asm volatile(SET_PSTATE_DIT(x))
>  #define set_pstate_ssbs(x)		asm volatile(SET_PSTATE_SSBS(x))
>  
>  #define __SYS_BARRIER_INSN(CRm, op2, Rt) \
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 6062454a9067..273a74df24fe 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -2077,6 +2077,11 @@ static void cpu_trap_el0_impdef(const struct arm64_cpu_capabilities *__unused)
>  	sysreg_clear_set(sctlr_el1, 0, SCTLR_EL1_TIDCP);
>  }
>  
> +static void cpu_enable_dit(const struct arm64_cpu_capabilities *__unused)
> +{
> +	set_pstate_dit(1);
> +}

I think this wants the same treatment as PAN, i.e.
WARN_ON_ONCE(in_interrupt()); with a comment about PSTATE being discareded upon
ERET.

Thanks,
Mark.

> +
>  /* Internal helper functions to match cpu capability type */
>  static bool
>  cpucap_late_cpu_optional(const struct arm64_cpu_capabilities *cap)
> @@ -2640,6 +2645,17 @@ static const struct arm64_cpu_capabilities arm64_features[] = {
>  		.matches = has_cpuid_feature,
>  		.cpu_enable = cpu_trap_el0_impdef,
>  	},
> +	{
> +		.desc = "Data independent timing control (DIT)",
> +		.capability = ARM64_HAS_DIT,
> +		.type = ARM64_CPUCAP_SYSTEM_FEATURE,
> +		.matches = has_cpuid_feature,
> +		.sys_reg = SYS_ID_AA64PFR0_EL1,
> +		.field_pos = ID_AA64PFR0_EL1_DIT_SHIFT,
> +		.field_width = 4,
> +		.min_field_value = 1,
> +		.cpu_enable = cpu_enable_dit,
> +	},
>  	{},
>  };
>  
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index e28137d64b76..229b505e6366 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -197,6 +197,9 @@ alternative_cb_end
>  	.endm
>  
>  	.macro	kernel_entry, el, regsize = 64
> +	.if	\el == 0
> +	ALTERNATIVE(nop, SET_PSTATE_DIT(1), ARM64_HAS_DIT)
> +	.endif
>  	.if	\regsize == 32
>  	mov	w0, w0				// zero upper 32 bits of x0
>  	.endif
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index f1c0347ec31a..a86ee376920a 100644
> --- a/arch/arm64/tools/cpucaps
> +++ b/arch/arm64/tools/cpucaps
> @@ -20,6 +20,7 @@ HAS_CNP
>  HAS_CRC32
>  HAS_DCPODP
>  HAS_DCPOP
> +HAS_DIT
>  HAS_E0PD
>  HAS_ECV
>  HAS_EPAN
> -- 
> 2.35.1
> 
