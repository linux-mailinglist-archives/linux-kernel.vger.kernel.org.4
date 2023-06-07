Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832E37259C8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 11:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbjFGJNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 05:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239610AbjFGJMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 05:12:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D926B1
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 02:11:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1686129104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/cLh2zvK8HOE20shhqEuzTDztEvswVlQNzlkSTXUEc=;
        b=43UGB2HRL9/NI/Zu6HosHsOQlyUHz8g9e+b2GsFPkhXRZUIkyeHWd8Xlpw6FPx0wdaoIoU
        FVSzx7kS7j9KWUBdFFi3P1I/bl1UJADaAVr1hRE/rrRAx3szZ+PbA35BAmdF9dt60djOxb
        I0ZZgV5gu9jMJYaNLDQTDF3N1Ss9YjqPsRhOPXfvRRp272+Hr95KyffNIwlYCyVfoogVnA
        JyKTsYOfkCEQz/07wrUwXBU9cWxUtMAVtWIMWQRKzd0UuWkXYBbmxTqzNb3yQmUW8+K4b/
        CtHZXjMZYlaBRWdvDsGzku21KilLjT9sX76eMoYbOtqGZJZlijteMaOp71pjUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1686129104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O/cLh2zvK8HOE20shhqEuzTDztEvswVlQNzlkSTXUEc=;
        b=zkuBi5AEDfLDA8a2LbMj1Q7VxOjhVFxUbQy5p7cg2xjle5qZKyZV8Imvga5E5ItegQDjnI
        OiDjzhwwlfWaMeDA==
To:     Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, mhocko@suse.com, jslaby@suse.cz,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: Re: [PATCH 2/3] x86/entry: Disable IA32 syscalls in the presence of
 ia32_disabled
In-Reply-To: <20230607072936.3766231-3-nik.borisov@suse.com>
References: <20230607072936.3766231-1-nik.borisov@suse.com>
 <20230607072936.3766231-3-nik.borisov@suse.com>
Date:   Wed, 07 Jun 2023 11:11:43 +0200
Message-ID: <87o7lrk568.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07 2023 at 10:29, Nikolay Borisov wrote:
> diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
> index ab97b22ac04a..618b428586d1 100644
> --- a/arch/x86/include/asm/desc.h
> +++ b/arch/x86/include/asm/desc.h
> @@ -8,6 +8,7 @@
>  #include <asm/fixmap.h>
>  #include <asm/irq_vectors.h>
>  #include <asm/cpu_entry_area.h>
> +#include <asm/traps.h>
>  
>  #include <linux/debug_locks.h>
>  #include <linux/smp.h>
> @@ -429,6 +430,10 @@ static inline void idt_init_desc(gate_desc *gate, const struct idt_data *d)
>  	gate->offset_high	= (u32) (addr >> 32);
>  	gate->reserved		= 0;
>  #endif
> +#ifdef CONFIG_IA32_EMULATION
> +	if (ia32_disabled && d->vector == IA32_SYSCALL_VECTOR)
> +		gate->bits.p = 0;
> +#endif

Why installing the IDT vector in the first place? This is completely
inconsistent with the CONFIG_IA32_EMULATION=n behaviour.

Just slapping this conditional into some random place is really not
cutting it.

The obvious solution is to remove IA32_SYSCALL_VECTOR from def_idts[]
and handle it separately.

>  extern unsigned long system_vectors[];
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 80710a68ef7d..71f8b55f70c9 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2054,17 +2054,24 @@ void syscall_init(void)
>  	wrmsrl(MSR_LSTAR, (unsigned long)entry_SYSCALL_64);
>  
>  #ifdef CONFIG_IA32_EMULATION
> -	wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
> -	/*
> -	 * This only works on Intel CPUs.
> -	 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
> -	 * This does not cause SYSENTER to jump to the wrong location, because
> -	 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
> -	 */
> -	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
> -	wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
> -		    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
> -	wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
> +	if (ia32_disabled) {
> +		wrmsrl_cstar((unsigned long)ignore_sysret);
> +		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);
> +		wrmsrl_safe(MSR_IA32_SYSENTER_ESP, 0ULL);
> +		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, 0ULL);
> +	} else {
> +		wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
> +		/*
> +		 * This only works on Intel CPUs.
> +		 * On AMD CPUs these MSRs are 32-bit, CPU truncates MSR_IA32_SYSENTER_EIP.
> +		 * This does not cause SYSENTER to jump to the wrong location, because
> +		 * AMD doesn't allow SYSENTER in long mode (either 32- or 64-bit).
> +		 */
> +		wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)__KERNEL_CS);
> +		wrmsrl_safe(MSR_IA32_SYSENTER_ESP,
> +			    (unsigned long)(cpu_entry_stack(smp_processor_id()) + 1));
> +		wrmsrl_safe(MSR_IA32_SYSENTER_EIP, (u64)entry_SYSENTER_compat);
> +	}
>  #else
>  	wrmsrl_cstar((unsigned long)ignore_sysret);
>  	wrmsrl_safe(MSR_IA32_SYSENTER_CS, (u64)GDT_ENTRY_INVALID_SEG);

So this ends up with two copies of the same code for invalidating
compat. Why?

   if (IS_ENABLED(CONFIG_IA32_EMULATION) && !ia32_disabled)) {
	wrmsrl_cstar((unsigned long)entry_SYSCALL_compat);
        ...
   } else {
	wrmsrl_cstar((unsigned long)ignore_sysret);
        ...
   }

All it requires is

#ifdef CONFIG_IA32_EMULATION
void entry_SYSCALL_compat(void);
#else
#define entry_SYSCALL_compat NULL
#endif

in the header which declares entry_SYSCALL_compat.

No?

Thanks,

        tglx
