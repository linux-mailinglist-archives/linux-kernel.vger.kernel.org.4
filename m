Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FF160C318
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 07:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbiJYFIR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 01:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiJYFHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 01:07:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8C6137389;
        Mon, 24 Oct 2022 22:06:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 52501B81260;
        Tue, 25 Oct 2022 05:06:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91FD0C433D7;
        Tue, 25 Oct 2022 05:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666674412;
        bh=PhAvkA+YfdXpkTGuM4QF1TubeX/M39i3zMfp0nDwnNI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gdzVXZnDZXkvLcl2UrckpkcK20KG0qUGhbBB3VlMtrQerDXWv1t8ywEzJANQEfpN8
         64p3rplQZqwKexR8wnQfuMIkjLkrlg6couk7pIBthi11VCYMx5eouCFO5qotQRDxIP
         r6fSjbaBtj2lGdUOxlJGDEcj6FqjdvpJtZ0AxE9Od52wGi4tdIK4OBcXcq3NNCng+M
         mm+t6L0dyb3SyRVsCicJq/cd4M24LOCdpl4Mn6tDRnQHAMA9uiGsFdYOXV6lRXx1xc
         yN6wH5ZU5PHgiUS24KiwjjrlQ7hXNnKt+Fdyhg7Dj/5FDQ21Bf7QA+dPIdd/xUPjgV
         V3jWt1ggvUS4Q==
Date:   Mon, 24 Oct 2022 22:06:50 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Adam Langley <agl@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: Should Linux set the new constant-time mode CPU flags?
Message-ID: <Y1du6kdk/6L0O56a@sol.localdomain>
References: <YwgCrqutxmX0W72r@gmail.com>
 <Ywzr2d52ixYXUDWR@zx2c4.com>
 <6ec9cdab-db5b-ab28-c92d-79c3812dd369@intel.com>
 <YxCQzZqLZ49gLlrH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxCQzZqLZ49gLlrH@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 01:00:29PM +0200, Peter Zijlstra wrote:
> Since I'm not feeling too well I figured I'd do something trivial and
> whipped up the below patch.
> 
> 
> ---
>  arch/x86/include/asm/cpufeatures.h |  3 ++
>  arch/x86/include/asm/msr-index.h   |  4 +++
>  arch/x86/kernel/cpu/common.c       | 69 ++++++++++++++++++++++++++++++--------
>  arch/x86/kernel/cpu/scattered.c    |  1 +
>  4 files changed, 63 insertions(+), 14 deletions(-)

We still need to do something about this.  As this thread died out, I'll revive
it by reviewing this patch.  (I'm not an expert in arch/x86/ stuff, though!)

> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 333d94394516..9b92f4e5e80a 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -305,6 +305,7 @@
>  #define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
>  #define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
>  #define X86_FEATURE_CALL_DEPTH		(11*32+18) /* "" Call depth tracking for RSB stuffing */
> +#define X86_FEATURE_MCDT_NO		(11*32+19) /* Not affected by MCDT */

Some of the other CPU feature flags have comments beginning with "", which
apparently results in the feature not being listed in /proc/cpuinfo.  (This
header file is run through a shell script that looks at these comments and
generates C code...)  Should this "feature" be listed in /proc/cpuinfo?

Looking for examples of other "feature" flags that mean that a CPU is not
vulnerable to something, I found X86_FEATURE_AMD_SSB_NO and X86_FEATURE_BTC_NO.
Those aren't listed in /proc/cpuinfo.  Maybe this should be the same?

Side note: maybe the comment should spell out "MXCSR Configuration Dependent
Timing"?  Acronyms can be hard to read.

> +#define X86_BUG_DOIT			X86_BUG(28)

Maybe it should be X86_BUG_DODT?  The bug is data operand *dependent* timing.
Data operand *independent* timing is the desired behavior and the fix.

> +#define X86_BUG_MCDT			X86_BUG(29)

According to Intel's documentation
(https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/best-practices/data-operand-independent-timing-isa-guidance.html),
MCDT is a separate bug which requires a separate mitigation.  So I think any
MCDT related stuff should be in a separate patch from DOITM.

But more importantly, this patch doesn't actually implement any mitigation for
MCDT.  Should we be doing that?  Intel recommends writing a certain value to
MXCSR to mitigate MCDT.  Is that feasible?

>  
>  #endif /* _ASM_X86_CPUFEATURES_H */
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 6674bdb096f3..08b4e0c2f7d3 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -119,6 +119,7 @@
>  						 * Not susceptible to
>  						 * TSX Async Abort (TAA) vulnerabilities.
>  						 */
> +#define ARCH_CAP_DOIT			BIT(12) /* Data Operand Independent Timing */
>  #define ARCH_CAP_SBDR_SSDP_NO		BIT(13)	/*
>  						 * Not susceptible to SBDR and SSDP
>  						 * variants of Processor MMIO stale data
> @@ -155,6 +156,9 @@
>  						 * Return Stack Buffer Predictions.
>  						 */
>  
> +#define MSR_IA32_UARCH_MISC_CTL		0x00001b01
> +#define UARCH_MISC_DOIT			BIT(0)	/* Enable DOIT */

The Intel documentation calls this bit "DOITM"
(Data Operand Independent Timing Mode), not "DOIT".

> +static __always_inline void setup_doit(struct cpuinfo_x86 *c)
> +{
> +	u64 msr = 0;
> +
> +	if (!cpu_has(c, X86_BUG_DOIT))
> +		return;
> +
> +	if (!doit_disabled)
> +		return;

This is backwards; it needs to be 'if (doit_disabled)'.

> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index fd44b54c90d5..5063f8046554 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -27,6 +27,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_APERFMPERF,       CPUID_ECX,  0, 0x00000006, 0 },
>  	{ X86_FEATURE_EPB,		CPUID_ECX,  3, 0x00000006, 0 },
>  	{ X86_FEATURE_INTEL_PPIN,	CPUID_EBX,  0, 0x00000007, 1 },
> +	{ X86_FEATURE_MCDT_NO,		CPUID_ECX,  5, 0x00000007, 2 },

The Intel documentation says this bit is CPUID.(EAX=7H,ECX=2):EDX[5]=1.
So CPUID_ECX is wrong; it needs to be CPUID_EDX.

- Eric
