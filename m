Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8370F6EF9AE
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 19:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236369AbjDZR5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjDZR5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 13:57:13 -0400
Received: from mail.cybernetics.com (mail.cybernetics.com [173.71.130.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B096F35AD
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 10:57:11 -0700 (PDT)
X-ASG-Debug-ID: 1682530672-1cf43912153204b0001-xx1T2L
Received: from cybernetics.com ([10.10.4.126]) by mail.cybernetics.com with ESMTP id Dn3l0AKuadEIoHu3; Wed, 26 Apr 2023 13:37:52 -0400 (EDT)
X-Barracuda-Envelope-From: tonyb@cybernetics.com
X-ASG-Whitelist: Client
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cybernetics.com; s=mail;
        bh=ATNwJSLFyohux/M/YpzBNZaYsaxhBJGvwGF+sS4vHgk=;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
        Content-Language:Subject:MIME-Version:Date:Message-ID; b=MryUhUccxU/FrKL6qT7I
        6c7ae0y2kKBTIwWvyMf93qaVYM1C6JcurHWJOGT7EX35E9hVvE+ykWJrqvMen2D7p9wXGAdIN/6kk
        HrdWXLruTVFztCUmGCPNMSeCLwZmY2CEpPllODlBw6u0XIuEpUqu3b/P0rg6akRxIq0dsWqkCU=
Received: from [10.157.2.224] (HELO [192.168.200.1])
  by cybernetics.com (CommuniGate Pro SMTP 7.1.1)
  with ESMTPS id 12591941; Wed, 26 Apr 2023 13:37:52 -0400
Message-ID: <ccf57fd2-45b8-1f1f-f46a-55d7f4c56161@cybernetics.com>
Date:   Wed, 26 Apr 2023 13:37:52 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
Content-Language: en-US
X-ASG-Orig-Subj: Re: [PATCH RFC] x86/cpu: fix intermittent lockup on poweroff
To:     Thomas Gleixner <tglx@linutronix.de>,
        Dave Hansen <dave.hansen@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>
References: <3817d810-e0f1-8ef8-0bbd-663b919ca49b@cybernetics.com>
 <f5c7a104-d422-bd02-d361-e9e9f433d41d@intel.com> <87o7nbzn8w.ffs@tglx>
 <5f8a9cb8-70cf-2a17-cfc4-cb31cb658de4@cybernetics.com> <87y1mey503.ffs@tglx>
From:   Tony Battersby <tonyb@cybernetics.com>
In-Reply-To: <87y1mey503.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Barracuda-Connect: UNKNOWN[10.10.4.126]
X-Barracuda-Start-Time: 1682530672
X-Barracuda-URL: https://10.10.4.122:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at cybernetics.com
X-Barracuda-Scan-Msg-Size: 3908
X-Barracuda-BRTS-Status: 1
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 12:37, Thomas Gleixner wrote:
> The problem really seems to be that the control CPU goes off before the
> other CPUs have finished and depending on timing that causes the
> wreckage. Otherwise the mdelay(100) would not have helped at all.
>
> But looking at it, that num_online_cpus() == 1 check in
> stop_other_cpus() is fragile as hell independent of that wbinvd() issue.
>
> Something like the completely untested below should cure that.
>
> Thanks,
>
>         tglx
> ---
>  arch/x86/include/asm/cpu.h |    2 ++
>  arch/x86/kernel/process.c  |   10 ++++++++++
>  arch/x86/kernel/smp.c      |   15 ++++++++++++---
>  3 files changed, 24 insertions(+), 3 deletions(-)
>
> --- a/arch/x86/include/asm/cpu.h
> +++ b/arch/x86/include/asm/cpu.h
> @@ -98,4 +98,6 @@ extern u64 x86_read_arch_cap_msr(void);
>  int intel_find_matching_signature(void *mc, unsigned int csig, int cpf);
>  int intel_microcode_sanity_check(void *mc, bool print_err, int hdr_type);
>  
> +extern atomic_t stop_cpus_count;
> +
>  #endif /* _ASM_X86_CPU_H */
> --- a/arch/x86/kernel/process.c
> +++ b/arch/x86/kernel/process.c
> @@ -752,6 +752,8 @@ bool xen_set_default_idle(void)
>  }
>  #endif
>  
> +atomic_t stop_cpus_count;
> +
>  void __noreturn stop_this_cpu(void *dummy)
>  {
>  	local_irq_disable();
> @@ -776,6 +778,14 @@ void __noreturn stop_this_cpu(void *dumm
>  	 */
>  	if (cpuid_eax(0x8000001f) & BIT(0))
>  		native_wbinvd();
> +
> +	/*
> +	 * native_stop_other_cpus() will write to @stop_cpus_count after
> +	 * observing that it went down to zero, which will invalidate the
> +	 * cacheline on this CPU.
> +	 */
> +	atomic_dec(&stop_cpus_count);
> +
>  	for (;;) {
>  		/*
>  		 * Use native_halt() so that memory contents don't change
> --- a/arch/x86/kernel/smp.c
> +++ b/arch/x86/kernel/smp.c
> @@ -27,6 +27,7 @@
>  #include <asm/mmu_context.h>
>  #include <asm/proto.h>
>  #include <asm/apic.h>
> +#include <asm/cpu.h>
>  #include <asm/idtentry.h>
>  #include <asm/nmi.h>
>  #include <asm/mce.h>
> @@ -171,6 +172,8 @@ static void native_stop_other_cpus(int w
>  		if (atomic_cmpxchg(&stopping_cpu, -1, safe_smp_processor_id()) != -1)
>  			return;
>  
> +		atomic_set(&stop_cpus_count, num_online_cpus() - 1);
> +
>  		/* sync above data before sending IRQ */
>  		wmb();
>  
> @@ -183,12 +186,12 @@ static void native_stop_other_cpus(int w
>  		 * CPUs reach shutdown state.
>  		 */
>  		timeout = USEC_PER_SEC;
> -		while (num_online_cpus() > 1 && timeout--)
> +		while (atomic_read(&stop_cpus_count) > 0 && timeout--)
>  			udelay(1);
>  	}
>  
>  	/* if the REBOOT_VECTOR didn't work, try with the NMI */
> -	if (num_online_cpus() > 1) {
> +	if (atomic_read(&stop_cpus_count) > 0) {
>  		/*
>  		 * If NMI IPI is enabled, try to register the stop handler
>  		 * and send the IPI. In any case try to wait for the other
> @@ -208,7 +211,7 @@ static void native_stop_other_cpus(int w
>  		 * one or more CPUs do not reach shutdown state.
>  		 */
>  		timeout = USEC_PER_MSEC * 10;
> -		while (num_online_cpus() > 1 && (wait || timeout--))
> +		while (atomic_read(&stop_cpus_count) > 0 && (wait || timeout--))
>  			udelay(1);
>  	}
>  
> @@ -216,6 +219,12 @@ static void native_stop_other_cpus(int w
>  	disable_local_APIC();
>  	mcheck_cpu_clear(this_cpu_ptr(&cpu_info));
>  	local_irq_restore(flags);
> +
> +	/*
> +	 * Ensure that the cache line is invalidated on the other CPUs. See
> +	 * comment vs. SME in stop_this_cpu().
> +	 */
> +	atomic_set(&stop_cpus_count, INT_MAX);
>  }
>  
>  /*
>
Tested-by: Tony Battersby <tonyb@cybernetics.com>

10 successful poweroffs in a row with wbinvd() enabled.  As I mentioned
before though, I don't have an AMD CPU to test the SME cache
invalidation logic.

I will reply with my patch with an updated title and description.

Tony


