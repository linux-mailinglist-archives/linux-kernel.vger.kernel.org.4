Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 820356216FE
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 15:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbiKHOlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 09:41:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiKHOlg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 09:41:36 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0520911821
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 06:41:35 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E65741FB;
        Tue,  8 Nov 2022 06:41:40 -0800 (PST)
Received: from FVFF77S0Q05N.cambridge.arm.com (FVFF77S0Q05N.cambridge.arm.com [10.1.38.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42A683F73D;
        Tue,  8 Nov 2022 06:41:33 -0800 (PST)
Date:   Tue, 8 Nov 2022 14:41:26 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Kees Cook <keescook@chromium.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adam Langley <agl@google.com>
Subject: Re: [PATCH v2] arm64: Enable data independent timing (DIT) in the
 kernel
Message-ID: <Y2pqlmlro/aICn+u@FVFF77S0Q05N.cambridge.arm.com>
References: <20221107172400.1851434-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107172400.1851434-1-ardb@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ard,

On Mon, Nov 07, 2022 at 06:24:00PM +0100, Ard Biesheuvel wrote:
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
> 
> Currently, we have no idea whether or not running privileged code with
> DIT disabled on a CPU that implements support for it may result in a
> side channel that exposes privileged data to unprivileged user space
> processes, so let's be cautious and just enable DIT while running in the
> kernel if supported by all CPUs.

Thanks for respinning the wording!

I have one minor nit below, but otherwise this looks good to me.

> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index f73f11b5504254be..f44579bca9f8107e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -875,6 +875,11 @@ static inline bool cpu_has_pan(void)
>  						    ID_AA64MMFR1_EL1_PAN_SHIFT);
>  }
>  
> +static inline bool cpu_has_dit(void)
> +{
> +	return cpus_have_const_cap(ARM64_HAS_DIT);
> +}

Normally cpu_has_X() implies a local feature check, and cpus_have_X() tests for
common support, so this should be cpus_have_dit().

That said, this is only used in one place below, so we could use the CAP
directly there without a wrapper.

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 7d301700d1a93692..1f3f52ce407fe942 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -90,20 +90,24 @@
>   */
>  #define pstate_field(op1, op2)		((op1) << Op1_shift | (op2) << Op2_shift)
>  #define PSTATE_Imm_shift		CRm_shift
> +#define SET_PSTATE(x, r)		__emit_inst(0xd500401f | PSTATE_ ## r | ((!!x) << PSTATE_Imm_shift))
>  
>  #define PSTATE_PAN			pstate_field(0, 4)
>  #define PSTATE_UAO			pstate_field(0, 3)
>  #define PSTATE_SSBS			pstate_field(3, 1)
> +#define PSTATE_DIT			pstate_field(3, 2)
>  #define PSTATE_TCO			pstate_field(3, 4)
>  
> -#define SET_PSTATE_PAN(x)		__emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
> -#define SET_PSTATE_UAO(x)		__emit_inst(0xd500401f | PSTATE_UAO | ((!!x) << PSTATE_Imm_shift))
> -#define SET_PSTATE_SSBS(x)		__emit_inst(0xd500401f | PSTATE_SSBS | ((!!x) << PSTATE_Imm_shift))
> -#define SET_PSTATE_TCO(x)		__emit_inst(0xd500401f | PSTATE_TCO | ((!!x) << PSTATE_Imm_shift))
> +#define SET_PSTATE_PAN(x)		SET_PSTATE((x), PAN)
> +#define SET_PSTATE_UAO(x)		SET_PSTATE((x), UAO)
> +#define SET_PSTATE_SSBS(x)		SET_PSTATE((x), SSBS)
> +#define SET_PSTATE_DIT(x)		SET_PSTATE((x), DIT)
> +#define SET_PSTATE_TCO(x)		SET_PSTATE((x), TCO)

Nice!

[...]

> diff --git a/arch/arm64/kernel/suspend.c b/arch/arm64/kernel/suspend.c
> index 8b02d310838f9240..3032a82ea51a19f7 100644
> --- a/arch/arm64/kernel/suspend.c
> +++ b/arch/arm64/kernel/suspend.c
> @@ -60,6 +60,8 @@ void notrace __cpu_suspend_exit(void)
>  	 * PSTATE was not saved over suspend/resume, re-enable any detected
>  	 * features that might not have been set correctly.
>  	 */
> +	if (cpu_has_dit())
> +		set_pstate_dit(1);

As above, I'd prefer if we either renamed cpu_has_dit() to cpus_have_dit(), or
just open-coded this as:

	if (cpus_have_const_cap(ARM64_HAS_DIT))
		set_pstate_dit(1);

With either of those options:

  Acked-by: Mark Rutland <mark.rutland@arm.com>

I assume Will might fix that up when applying.

Mark.

>  	__uaccess_enable_hw_pan();
>  
>  	/*
> diff --git a/arch/arm64/tools/cpucaps b/arch/arm64/tools/cpucaps
> index f1c0347ec31a85c7..a86ee376920a08dd 100644
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
