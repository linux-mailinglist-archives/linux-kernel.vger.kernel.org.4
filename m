Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9D8873BA94
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 16:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231770AbjFWOs1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 10:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFWOsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:48:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AFF631B4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 07:48:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CAE5C1042;
        Fri, 23 Jun 2023 07:49:06 -0700 (PDT)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F4943F59C;
        Fri, 23 Jun 2023 07:48:22 -0700 (PDT)
Message-ID: <43377789-5090-fc4c-1e5b-502603e84f76@arm.com>
Date:   Fri, 23 Jun 2023 15:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] arm64: sdei: abort running SDEI handlers during crash
Content-Language: en-GB
To:     D Scott Phillips <scott@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
References: <20230607195546.2896-1-scott@os.amperecomputing.com>
From:   James Morse <james.morse@arm.com>
In-Reply-To: <20230607195546.2896-1-scott@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Scott,

On 07/06/2023 20:55, D Scott Phillips wrote:
> Interrupts are blocked in SDEI context, per the SDEI spec: "The client
> interrupts cannot preempt the event handler." If we crashed in the SDEI
> handler-running context (as with ACPI's AGDI) then we need to clean up the
> SDEI state before proceeding to the crash kernel so that the crash kernel
> can have working interrupts.
> 
> Track the active SDEI handler per-cpu so that we can COMPLETE_AND_RESUME
> the handler, discarding the interrupted context.

I still argue this is a bug in the firmware. The text you indicate was intended to mean
'set PSTATE.I'. The whole 'GIC abstraction' use-case was added to SDEI quite late. You'll
note linux doesn't support any of that. The normal-world OS was never supposed to have
to guess whether


Regardless, I've not managed to convince the firmware people to fix this.


> diff --git a/arch/arm64/include/asm/sdei.h b/arch/arm64/include/asm/sdei.h
> index 4292d9bafb9d..dc2f038a61ef 100644
> --- a/arch/arm64/include/asm/sdei.h
> +++ b/arch/arm64/include/asm/sdei.h
> @@ -17,6 +17,11 @@
>  
>  #include <asm/virt.h>
>  
> +#ifdef CONFIG_ARM_SDE_INTERFACE
> +DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_normal_event);
> +DECLARE_PER_CPU(struct sdei_registered_event *, sdei_active_critical_event);
> +#endif

Please drop these #ifdef guards, they prevent using IS_ENABLED() to let the compiler check
the code, but dead-code eliminate it. This makes it harder for the CI to catch any issues
without having to 'get lucky' with the Kconfig options.


> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index ab2a6e33c052..e49f72b5fb63 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -1007,6 +1007,12 @@ SYM_CODE_START(__sdei_asm_handler)
>  	ldrb	w4, [x19, #SDEI_EVENT_PRIORITY]
>  #endif
>  
> +	cbnz	w4, 1f

Is this meant to be considering SDEI_EVENT_PRIORITY? That is #ifdef'd for VMAP_STACK/SCS.
Without those options set, you're checking to the stack pointer here.
You probably need to drop the #ifdefs.


> +	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
> +	b	2f
> +1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
> +2:	str	x19, [x5]

Almost every assembly block in here has a comment describing what its doing.
|	/* Store the registered-event for crash_smp_send_stop() */


>  #ifdef CONFIG_VMAP_STACK
>  	/*
>  	 * entry.S may have been using sp as a scratch register, find whether
> @@ -1072,6 +1078,13 @@ SYM_CODE_START(__sdei_asm_handler)
>  
>  	ldr_l	x2, sdei_exit_mode


|	/* Clear the registered-event seen by crash_smp_send_stop() */

> +	ldrb	w3, [x4, #SDEI_EVENT_PRIORITY]
> +	cbnz	w3, 1f
> +	adr_this_cpu dst=x5, sym=sdei_active_normal_event, tmp=x6
> +	b	2f
> +1:	adr_this_cpu dst=x5, sym=sdei_active_critical_event, tmp=x6
> +2:	str	xzr, [x5]
> +
>  alternative_if_not ARM64_UNMAP_KERNEL_AT_EL0
>  	sdei_handler_exit exit_mode=x2
>  alternative_else_nop_endif


> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 4e8327264255..ea1595b51590 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c

> @@ -1069,7 +1067,28 @@ void crash_smp_send_stop(void)
>  		pr_warn("SMP: failed to stop secondary CPUs %*pbl\n",
>  			cpumask_pr_args(&mask));
>  
> +skip_ipi:
>  	sdei_mask_local_cpu();
> +
> +#ifdef CONFIG_ARM_SDE_INTERFACE

Please make this a C "if(IS_ENABLED(CONFIG_ARM_SDE_INTERFACE)) {", this lets the compiler
check this is all valid, before dead-code eliminating it if the Kconfig option isn't
selected. This lets the CI systems check this code regardless of the Kconfig option.


> +	/*
> +	 * If the crash happened in an SDEI event handler then we need to
> +	 * finish the handler with the firmware so that we can have working
> +	 * interrupts in the crash kernel.
> +	 */
> +	if (__this_cpu_read(sdei_active_critical_event)) {
> +		pr_warn("SMP: stopped CPUs from SDEI critical event handler "
> +			"context, attempting to finish handler.\n");
> +		sdei_handler_abort();
> +		__this_cpu_write(sdei_active_critical_event, NULL);
> +	}
> +	if (__this_cpu_read(sdei_active_normal_event)) {
> +		pr_warn("SMP: stopped CPUs from SDEI normal event handler "
> +			"context, attempting to finish handler.\n");
> +		sdei_handler_abort();
> +		__this_cpu_write(sdei_active_normal_event, NULL);
> +	}
> +#endif

You might want to wrap this up as a sdei_handler_abort(), just to hide the ugly details
from here. The asm version would then need a double-underscore prefix.


>  }


With the entry.S #ifdef issue fixed:
Reviewed-by: James Morse <james.morse@arm.com>


Thanks,

James
