Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED4F65DC6A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 19:57:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbjADS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 13:57:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbjADS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 13:57:00 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3296B13DFA
        for <linux-kernel@vger.kernel.org>; Wed,  4 Jan 2023 10:56:58 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0F8D71EC02FE;
        Wed,  4 Jan 2023 19:56:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1672858617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=eI6hrybg3gLaj8bRbb/kt2kToyODb7dNUhJzp/ZLGpY=;
        b=l9gQ/gxHxlA9XtFIgW4MXMZ1vjMsP+AdznrIPuUUkXphaUE1LhTpk4529b/7ZShKtpo6Ud
        v6V33oRywy0qwExgp4lfdnI52CzmXNWY2jSYaq800QemysqMc3sZs5dBUC47WLIbPQ1bN5
        Lv+GPYpEe13qujigxQIsY3Uq1GyNDl4=
Date:   Wed, 4 Jan 2023 19:56:52 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Ashok Raj <ashok.raj@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, X86-kernel <x86@kernel.org>,
        LKML Mailing List <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
Subject: Re: [PATCH v3 2/6] x86/microcode/core: Take a snapshot before and
 after applying microcode
Message-ID: <Y7XL9Pr9DiW0wdaM@zn.tnic>
References: <20230103180212.333496-1-ashok.raj@intel.com>
 <20230103180212.333496-3-ashok.raj@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230103180212.333496-3-ashok.raj@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 03, 2023 at 10:02:08AM -0800, Ashok Raj wrote:
> Fixes: 1008c52c09dc ("x86/CPU: Add a microcode loader callback")

Why a Fixes tag? Do you have a failure scenario for current kernels?

If so, then it would need stable backporting.

If so, it would need the previous patch too.

> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 387578049de0..ac2e67156b9b 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -697,6 +697,7 @@ bool xen_set_default_idle(void);
>  #endif
>  
>  void __noreturn stop_this_cpu(void *dummy);
> +void microcode_store_cpu_caps(struct cpuinfo_x86 *info);

s/microcode_store_cpu_caps/store_cpu_caps/g

>  void microcode_check(struct cpuinfo_x86 *info);
>  
>  enum l1tf_mitigations {
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index b9c7529c920e..7c86c6fd07ae 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -2297,28 +2297,43 @@ void cpu_init_secondary(void)
>  #endif
>  
>  #ifdef CONFIG_MICROCODE_LATE_LOADING
> +
> +void microcode_store_cpu_caps(struct cpuinfo_x86 *info)
> +{
> +	/* Reload CPUID max function as it might've changed. */

Might've changed how?

> +	info->cpuid_level = cpuid_eax(0);
> +
> +	/*
> +	 * Copy all capability leafs to pick up the synthetic ones so that
> +	 * memcmp() below doesn't fail on that...

split that comment and put the second part...

> +	 */
> +	memcpy(info->x86_capability, &boot_cpu_data.x86_capability,
> +	       sizeof(info->x86_capability));
> +

... here:

	/*
	 * ... the ones coming from CPUID will get overwritten here:
	 */

> +	get_cpu_cap(info);
> +}
> +
>  /*
>   * The microcode loader calls this upon late microcode load to recheck features,
>   * only when microcode has been updated. Caller holds microcode_mutex and CPU
>   * hotplug lock.
>   */
> -void microcode_check(struct cpuinfo_x86 *info)
> +void microcode_check(struct cpuinfo_x86 *orig)
					   ^^^^^

Yeah, what dhansen said.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
