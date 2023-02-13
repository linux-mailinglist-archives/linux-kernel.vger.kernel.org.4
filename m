Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B0D6944B8
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 12:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjBMLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 06:40:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230412AbjBMLj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 06:39:58 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC155DBFD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 03:39:46 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B32511EC084C;
        Mon, 13 Feb 2023 12:39:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676288384;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=l7aspdoWBIQU7ygfUmH4uoLdy29h761To9Te8lKDM4c=;
        b=T8JGYGXkcmlGnhXM5lVP2nu0ZrVVdbIriX8/twsX1rbSDqoQC2EbT5lNFB2crvJkOHHtyC
        CfPNwd9x+XA40TLFHNWfrb6M5HUOOFzCN4wDIjOp3A/Kr+9xbbnwBvYSQfZ5q7FNiO8N4S
        4ms58LUQ7RNyVmgHLavueM1xUft3bPI=
Date:   Mon, 13 Feb 2023 12:39:40 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 2/8] x86/mtrr: support setting MTRR state for software
 defined MTRRs
Message-ID: <Y+ohfE/wICFKO/93@zn.tnic>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209072220.6836-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 08:22:14AM +0100, Juergen Gross wrote:
> When running virtualized, MTRR access can be reduced (e.g. in Xen PV
> guests or when running as a SEV-SNP guest under Hyper-V). Typically
> the hypervisor will reset the MTRR feature in cpuid data, resulting
> in no MTRR memory type information being available for the kernel.
> 
> This has turned out to result in problems:
> 
> - Hyper-V SEV-SNP guests using uncached mappings where they shouldn't
> - Xen PV dom0 mapping memory as WB which should be UC- instead
> 
> Solve those problems by supporting to set a fixed MTRR state,
> overwriting the empty state used today. In case such a state has been
> set, don't call get_mtrr_state() in mtrr_bp_init(). The set state
> will only be used by mtrr_type_lookup(), as in all other cases
> mtrr_enabled() is being checked, which will return false. Accept the
> overwrite call only in case of MTRRs being disabled in cpuid.

s/cpuid/CPUID/g

> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
> V2:
> - new patch
> ---
>  arch/x86/include/asm/mtrr.h        |  2 ++
>  arch/x86/kernel/cpu/mtrr/generic.c | 38 ++++++++++++++++++++++++++++++
>  arch/x86/kernel/cpu/mtrr/mtrr.c    |  9 +++++++
>  3 files changed, 49 insertions(+)
> 
> diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
> index f0eeaf6e5f5f..0b8f51d683dc 100644
> --- a/arch/x86/include/asm/mtrr.h
> +++ b/arch/x86/include/asm/mtrr.h
> @@ -31,6 +31,8 @@
>   */
>  # ifdef CONFIG_MTRR
>  void mtrr_bp_init(void);
> +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
> +			  mtrr_type *fixed, mtrr_type def_type);
>  extern u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform);
>  extern void mtrr_save_fixed_ranges(void *);
>  extern void mtrr_save_state(void);
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> index ee09d359e08f..788bc16888a5 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -240,6 +240,44 @@ static u8 mtrr_type_lookup_variable(u64 start, u64 end, u64 *partial_end,
>  	return mtrr_state.def_type;
>  }
>  
> +/**
> + * mtrr_overwrite_state - set fixed MTRR state

fixed only? You pass in variable too...

> + *
> + * Used to set MTRR state via different means (e.g. with data obtained from
> + * a hypervisor).
> + */
> +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
> +			  mtrr_type *fixed, mtrr_type def_type)
> +{
> +	unsigned int i;
> +
> +	if (boot_cpu_has(X86_FEATURE_MTRR))

check_for_deprecated_apis: WARNING: arch/x86/kernel/cpu/mtrr/generic.c:254: Do not use boot_cpu_has() - use cpu_feature_enabled() instead.

> +		return;

So this here needs to check:

	if (!cpu_feature_enabled(X86_FEATURE_HYPERVISOR) &&
	    !(cpu_feature_enabled(X86_FEATURE_SEV_SNP) ||
	      cpu_feature_enabled(X86_FEATURE_XENPV))) {
		WARN_ON_ONCE(1);
		return;
	}

as we don't want this to be called somewhere or by something else.

The SEV_SNP flag can be used from:

https://lore.kernel.org/r/20221214194056.161492-14-michael.roth@amd.com

I'm assuming here HyperV SEV-SNP guests really do set that feature flag
(they better). We can expedite that patch ofc.

And for dom0 I *think* we use X86_FEATURE_XENPV but I leave that to you.

> +
> +	if (var) {
> +		if (num_var > MTRR_MAX_VAR_RANGES) {
> +			pr_warn("Trying to overwrite MTRR state with %u variable entries\n",
> +				num_var);

What's that check for? Sanity of callers?

> +			num_var = MTRR_MAX_VAR_RANGES;
> +		}
> +		for (i = 0; i < num_var; i++)
> +			mtrr_state.var_ranges[i] = var[i];
> +		num_var_ranges = num_var;
> +	}
> +
> +	if (fixed) {
> +		for (i = 0; i < MTRR_NUM_FIXED_RANGES; i++)

You're not doing this sanity check here, expecting that callers would
know what they're doing...

> +			mtrr_state.fixed_ranges[i] = fixed[i];
> +		mtrr_state.enabled |= MTRR_STATE_MTRR_FIXED_ENABLED;
> +		mtrr_state.have_fixed = 1;
> +	}
> +
> +	mtrr_state.def_type = def_type;
> +	mtrr_state.enabled |= MTRR_STATE_MTRR_ENABLED;
> +
> +	mtrr_state_set = 1;
> +}

I can't say that I'm crazy about the call sites:

	mtrr_overwrite_state(NULL, 0, NULL, MTRR_TYPE_WRBACK);

This looks like it wants a

	mtrr_override_def_type(MTRR_TYPE_WRBACK);

instead of passing in all those nulls as params.

This:

	mtrr_overwrite_state(var, reg, NULL, MTRR_TYPE_UNCACHABLE);

I guess is a bit better.

Dunno, if it is only those two callers we can say, meh, whatever, this
interface is not pretty but does the job at least. But if more users
start popping up then I guess we can do

	mtrr_override_fixed()
	mtrr_override_variable()
	mtrr_override_def_type()

...


>  /**
>   * mtrr_type_lookup - look up memory type in MTRR
>   *
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 542ca5639dfd..b73fe243c7fd 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -668,6 +668,15 @@ void __init mtrr_bp_init(void)
>  	const char *why = "(not available)";
>  	unsigned int phys_addr;
>  
> +	if (mtrr_state.enabled) {

Not crazy about this either: this relies on the fragile boot ordering
where init_hypervisor_platform() runs before this so it has a chance
that mtrr_state.enabled will be already set.

Yeah, yeah, cache_bp_init() and all the MTRR BSP setup stuff happens
after it but there should at least be a comment over
init_hypervisor_platform()'s call site in setup_arch() stating that
cache_bp_init() needs to happen *after* it because <reason>.

I think we should also check

	x86_hyper_type

here and not do anything if not set. As this is all HV-related muck.

Xen I guess is a bit better because that call there happens even earlier
but we need the comments to say that the ordering matters because future
reorganization could cause it to blow up and people would search
themselves crazy why in the hell it breaks...

Can Xen use x86_hyper_type() too?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
