Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AEBF6122D0
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 14:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJ2MPP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 08:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiJ2MPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 08:15:13 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D6672EF0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 05:15:10 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e788329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e788:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 885011EC05DD;
        Sat, 29 Oct 2022 14:15:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1667045708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=Kg4wdByF6QWkzeTHBztw8HZa7/b2z+BFN0gMeNtQrgA=;
        b=PQsbDjEJ/HCoTeb/tSlIhPrzUWb2iO7MI7GYxzzmqmw+aGkCoobpyxxIxL/IfiFxYAsfig
        pl7zIl9DHVQBzGkHPfCkb43ELWD3e7vYlWh3qK/Y507my0eMQ315hGiDsMLE5jMHB0Z1Pn
        pxhtR1JTLuFLTGPHlQPdEpSWig0D4SA=
Date:   Sat, 29 Oct 2022 14:15:03 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 13/16] x86: decouple pat and mtrr handling
Message-ID: <Y10ZR7KtWTdzl6hm@zn.tnic>
References: <20221004081023.32402-1-jgross@suse.com>
 <20221004081023.32402-14-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004081023.32402-14-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 04, 2022 at 10:10:20AM +0200, Juergen Gross wrote:
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index 66a209f7eb86..ce1f3246a3e3 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -43,6 +43,7 @@
>  #include <linux/rbtree.h>
>  
>  #include <asm/cacheflush.h>
> +#include <asm/cacheinfo.h>
>  #include <asm/processor.h>
>  #include <asm/tlbflush.h>
>  #include <asm/x86_init.h>
> @@ -60,41 +61,34 @@
>  #undef pr_fmt
>  #define pr_fmt(fmt) "" fmt
>  
> -static bool __read_mostly pat_bp_initialized;
>  static bool __read_mostly pat_disabled = !IS_ENABLED(CONFIG_X86_PAT);
> -static bool __initdata pat_force_disabled = !IS_ENABLED(CONFIG_X86_PAT);
> -static bool __read_mostly pat_bp_enabled;
> -static bool __read_mostly pat_cm_initialized;
> +static u64 __read_mostly pat_msr_val;

__ro_after_init perhaps. Looks like this thing gets set only during CPU
init anyway.

...

> +void __init pat_bp_init(void)
>  {
> +	struct cpuinfo_x86 *c = &boot_cpu_data;
>  	u64 pat = 0;

Might as well get rid of that local var and use pat_msr_val directly.

>  
> -	if (pat_cm_initialized)
> -		return;
> +#ifndef CONFIG_X86_PAT
> +	pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
> +#endif

	if (!IS_ENABLED(CONFIG...))
		pr_info_once(..)

and one more ifdeffery is gone.

> -	if (boot_cpu_has(X86_FEATURE_PAT)) {
> -		/*
> -		 * CPU supports PAT. Set PAT table to be consistent with
> -		 * PAT MSR. This case supports "nopat" boot option, and
> -		 * virtual machine environments which support PAT without
> -		 * MTRRs. In specific, Xen has unique setup to PAT MSR.
> -		 *
> -		 * If PAT MSR returns 0, it is considered invalid and emulates
> -		 * as No PAT.
> -		 */
> +	if (!boot_cpu_has(X86_FEATURE_PAT))

check_for_deprecated_apis: Warning: arch/x86/mm/pat/memtype.c:265: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

> +		pat_disable("PAT not supported by the CPU.");
> +	else
>  		rdmsrl(MSR_IA32_CR_PAT, pat);
> -	}

...

> -void pat_init(void)
> -{
> -	u64 pat;
> -	struct cpuinfo_x86 *c = &boot_cpu_data;
> -
> -#ifndef CONFIG_X86_PAT
> -	pr_info_once("x86/PAT: PAT support disabled because CONFIG_X86_PAT is disabled in the kernel.\n");
> -#endif
> +	/* Xen PV doesn't allow to set PAT MSR, but all cache modes are fine. */

... all cache modes are supported" perhaps? "fine" sounds weird here.

> +	if (pat_disabled || cpu_feature_enabled(X86_FEATURE_XENPV)) {
> +		init_cache_modes(pat);
>  

Drop that resulting newline here.

> -	if (pat_disabled)
>  		return;
> +	}
>  
>  	if ((c->x86_vendor == X86_VENDOR_INTEL) &&
>  	    (((c->x86 == 0x6) && (c->x86_model <= 0xd)) ||

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
