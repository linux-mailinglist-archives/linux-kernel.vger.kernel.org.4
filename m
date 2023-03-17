Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB616BED33
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 16:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjCQPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 11:45:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjCQPpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 11:45:31 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BE54D41C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 08:45:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E83C4B82627
        for <linux-kernel@vger.kernel.org>; Fri, 17 Mar 2023 15:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0988BC433EF;
        Fri, 17 Mar 2023 15:45:19 +0000 (UTC)
Date:   Fri, 17 Mar 2023 15:45:17 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kristina Martsenko <kristina.martsenko@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Luis Machado <luis.machado@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] arm64: mops: handle MOPS exceptions
Message-ID: <ZBSLDTUD3yLY7SHJ@arm.com>
References: <20230216160012.272345-1-kristina.martsenko@arm.com>
 <20230216160012.272345-8-kristina.martsenko@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216160012.272345-8-kristina.martsenko@arm.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 04:00:09PM +0000, Kristina Martsenko wrote:
> The memory copy/set instructions added as part of FEAT_MOPS can take an
> exception part-way through their execution and resume execution
> afterwards. If however the task is re-scheduled and execution resumes on
> a different CPU, then the CPU may take a new type of exception to
> indicate this. In this case the OS has to reset the registers and restart
> execution from the prologue instruction. The algorithm for doing this is
> provided as part of the Arm ARM.
> 
> Add an exception handler for the new exception and wire it up for
> userspace tasks.
> 
> Signed-off-by: Kristina Martsenko <kristina.martsenko@arm.com>

It may be worth adding a short note in the cover that the architecture
allows two options to implement the memory instructions and on a
heterogeneous system we can have different implementations between CPUs.
That's the reason for an exception after migration (it's not obvious
from your text above).

> diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
> index c9f15b9e3c71..96caaaee97a3 100644
> --- a/arch/arm64/include/asm/esr.h
> +++ b/arch/arm64/include/asm/esr.h
> @@ -47,7 +47,7 @@
>  #define ESR_ELx_EC_DABT_LOW	(0x24)
>  #define ESR_ELx_EC_DABT_CUR	(0x25)
>  #define ESR_ELx_EC_SP_ALIGN	(0x26)
> -/* Unallocated EC: 0x27 */
> +#define ESR_ELx_EC_MOPS		(0x27)
>  #define ESR_ELx_EC_FP_EXC32	(0x28)
>  /* Unallocated EC: 0x29 - 0x2B */
>  #define ESR_ELx_EC_FP_EXC64	(0x2C)
> @@ -352,6 +352,15 @@
>  #define ESR_ELx_SME_ISS_ZA_DISABLED	3
>  #define ESR_ELx_SME_ISS_ZT_DISABLED	4
>  
> +/* ISS field definitions for MOPS exceptions */
> +#define ESR_ELx_MOPS_ISS_MEM_INST	(UL(1) << 24)
> +#define ESR_ELx_MOPS_ISS_FROM_EPILOGUE	(UL(1) << 18)
> +#define ESR_ELx_MOPS_ISS_WRONG_OPTION	(UL(1) << 17)
> +#define ESR_ELx_MOPS_ISS_OPTION_A	(UL(1) << 16)
> +#define ESR_ELx_MOPS_ISS_DESTREG(esr)	(((esr) & (UL(0x1f) << 10)) >> 10)
> +#define ESR_ELx_MOPS_ISS_SRCREG(esr)	(((esr) & (UL(0x1f) << 5)) >> 5)
> +#define ESR_ELx_MOPS_ISS_SIZEREG(esr)	(((esr) & (UL(0x1f) << 0)) >> 0)
> +
>  #ifndef __ASSEMBLY__
>  #include <asm/types.h>
>  
> diff --git a/arch/arm64/include/asm/exception.h b/arch/arm64/include/asm/exception.h
> index 92963f98afec..5a6dc3643e9b 100644
> --- a/arch/arm64/include/asm/exception.h
> +++ b/arch/arm64/include/asm/exception.h
> @@ -77,6 +77,7 @@ void do_el0_svc(struct pt_regs *regs);
>  void do_el0_svc_compat(struct pt_regs *regs);
>  void do_el0_fpac(struct pt_regs *regs, unsigned long esr);
>  void do_el1_fpac(struct pt_regs *regs, unsigned long esr);
> +void do_el0_mops(struct pt_regs *regs, unsigned long esr);
>  void do_serror(struct pt_regs *regs, unsigned long esr);
>  void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags);
>  
> diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
> index cce1167199e3..2ef3ab5d7555 100644
> --- a/arch/arm64/kernel/entry-common.c
> +++ b/arch/arm64/kernel/entry-common.c
> @@ -611,6 +611,14 @@ static void noinstr el0_bti(struct pt_regs *regs)
>  	exit_to_user_mode(regs);
>  }
>  
> +static void noinstr el0_mops(struct pt_regs *regs, unsigned long esr)
> +{
> +	enter_from_user_mode(regs);
> +	local_daif_restore(DAIF_PROCCTX);
> +	do_el0_mops(regs, esr);
> +	exit_to_user_mode(regs);
> +}
> +
>  static void noinstr el0_inv(struct pt_regs *regs, unsigned long esr)
>  {
>  	enter_from_user_mode(regs);
> @@ -688,6 +696,9 @@ asmlinkage void noinstr el0t_64_sync_handler(struct pt_regs *regs)
>  	case ESR_ELx_EC_BTI:
>  		el0_bti(regs);
>  		break;
> +	case ESR_ELx_EC_MOPS:
> +		el0_mops(regs, esr);
> +		break;
>  	case ESR_ELx_EC_BREAKPT_LOW:
>  	case ESR_ELx_EC_SOFTSTP_LOW:
>  	case ESR_ELx_EC_WATCHPT_LOW:
> diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
> index 0ccc063daccb..689188712909 100644
> --- a/arch/arm64/kernel/traps.c
> +++ b/arch/arm64/kernel/traps.c
> @@ -507,6 +507,50 @@ void do_el1_fpac(struct pt_regs *regs, unsigned long esr)
>  	die("Oops - FPAC", regs, esr);
>  }
>  
> +void do_el0_mops(struct pt_regs *regs, unsigned long esr)
> +{
> +	bool wrong_option = esr & ESR_ELx_MOPS_ISS_WRONG_OPTION;
> +	bool option_a = esr & ESR_ELx_MOPS_ISS_OPTION_A;
> +	int dstreg = ESR_ELx_MOPS_ISS_DESTREG(esr);
> +	int srcreg = ESR_ELx_MOPS_ISS_SRCREG(esr);
> +	int sizereg = ESR_ELx_MOPS_ISS_SIZEREG(esr);
> +	unsigned long dst, src, size;
> +
> +	dst = pt_regs_read_reg(regs, dstreg);
> +	src = pt_regs_read_reg(regs, srcreg);
> +	size = pt_regs_read_reg(regs, sizereg);
> +
> +	/*
> +	 * Put the registers back in the original format suitable for a
> +	 * prologue instruction, using the generic return routine from the
> +	 * Arm ARM (DDI 0487I.a) rules CNTMJ and MWFQH.
> +	 */
> +	if (esr & ESR_ELx_MOPS_ISS_MEM_INST) {
> +		if ((!option_a && wrong_option) || (option_a && !wrong_option)) {
> +			pt_regs_write_reg(regs, dstreg, dst + size);
> +			pt_regs_write_reg(regs, sizereg, -size);
> +		}

Please add a comment here that this is for the SET* instructions (rule
MWFQH). It confused me a bit when trying to review against the Arm ARM.
I'd also add the comments from the spec like "format is Option A" and
"forward copy".

> +	} else {
> +		if ((option_a && wrong_option) || (!option_a && !wrong_option)) {
> +			if (regs->pstate & PSR_N_BIT) {
> +				pt_regs_write_reg(regs, dstreg, dst - size);
> +				pt_regs_write_reg(regs, srcreg, src - size);
> +			}
> +		} else {
> +			if (size & BIT(63)) {
> +				pt_regs_write_reg(regs, dstreg, dst + size);
> +				pt_regs_write_reg(regs, srcreg, src + size);
> +				pt_regs_write_reg(regs, sizereg, -size);
> +			}
> +		}
> +	}
> +
> +	if (esr & ESR_ELx_MOPS_ISS_FROM_EPILOGUE)
> +		regs->pc -= 8;
> +	else
> +		regs->pc -= 4;
> +}

Same here about the comments in the Arm ARM, copy them over here as
well.

I think rule CNTMJ has a typo with the indentation as the return
address seems to only be updated on the second 'else' block above.

Otherwise the code looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
