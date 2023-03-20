Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C704B6C210B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 20:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjCTTPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 15:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbjCTTO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 15:14:26 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643372B2A9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 12:06:37 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 74D731EC0662;
        Mon, 20 Mar 2023 20:05:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679339149;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=GLtLgfJ/BD7NAuZ08TuzB0Td8P4NsQY0UNsYf0ZYQjU=;
        b=cVxKKTdoZnYQLZy4AHn1wyPgE0in7cvmnUEP0pHc7yyOGIptkPYxS1PAKK9RgmSdnfyjop
        eWMw/7vEjbgoK5aTWTVPETh7Aa7g41EjTMUspPMsPosdXZgY5QlN5slEWlqKoL641rsEaa
        pTSaLKoPHAZV/QPTBAcCWsFEq7PV5vI=
Date:   Mon, 20 Mar 2023 20:05:43 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 03/12] x86/mtrr: support setting MTRR state for
 software defined MTRRs
Message-ID: <20230320190543.GFZBiuh2lImP8LEW3D@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-4-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306163425.8324-4-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:34:16PM +0100, Juergen Gross wrote:
> +/**
> + * mtrr_overwrite_state - set static MTRR state
> + *
> + * Used to set MTRR state via different means (e.g. with data obtained from
> + * a hypervisor).
> + * Is allowed only for special cases when running virtualized. Must be called
> + * from the x86_init.hyper.init_platform() hook. X86_FEATURE_MTRR must be off.
> + */
> +void mtrr_overwrite_state(struct mtrr_var_range *var, unsigned int num_var,
> +			  mtrr_type def_type)
> +{
> +	unsigned int i;
> +
> +	if (WARN_ON(mtrr_state_set ||
> +		    hypervisor_is_type(X86_HYPER_NATIVE) ||

Why that check?

> +		    !cpu_feature_enabled(X86_FEATURE_HYPERVISOR) ||
> +		    (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP) &&
> +		     !hv_is_isolation_supported() &&
> +		     !cpu_feature_enabled(X86_FEATURE_XENPV) &&
> +		     !cpu_feature_enabled(X86_FEATURE_TDX_GUEST))))

This is unparseable. Please split it into separate checks:

	if (WARN_ON(mtrr_state_set))
		return;

	if (WARN_ON(!cpu_feature_enabled(X86_FEATURE_HYPERVISOR)))
		return;

	...

and add comments above each one why we're testing this.


> +		return;
> +
> +	/* Disable MTRR in order to disable MTRR modifications. */
> +	setup_clear_cpu_cap(X86_FEATURE_MTRR);
> +
> +	if (var) {
> +		if (num_var > MTRR_MAX_VAR_RANGES) {
> +			pr_warn("Trying to overwrite MTRR state with %u variable entries\n",
> +				num_var);
> +			num_var = MTRR_MAX_VAR_RANGES;
> +		}
> +		for (i = 0; i < num_var; i++)
> +			mtrr_state.var_ranges[i] = var[i];
> +		num_var_ranges = num_var;
> +	}
> +
> +	mtrr_state.def_type = def_type;
> +	mtrr_state.enabled |= MTRR_STATE_MTRR_ENABLED;
> +
> +	mtrr_state_set = 1;
> +}
> +
>  /**
>   * mtrr_type_lookup - look up memory type in MTRR
>   *
> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 7596ebeab929..5fe62ee0361b 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -666,6 +666,15 @@ void __init mtrr_bp_init(void)
>  	const char *why = "(not available)";
>  	unsigned int phys_addr;
>  
> +	if (mtrr_state.enabled) {

I'm guessing the proper detection of that weird state should be:

	/*
	 * Check for the software overwrite of MTRR state, only for generic case.
	 * See mtrr_overwrite_state().
	 */
	if (!cpu_feature_enabled(X86_FEATURE_MTRR) &&
	    mtrr_state.enabled) {
		...


> +		/* Software overwrite of MTRR state, only for generic case. */
> +		mtrr_calc_physbits(true);
> +		init_table();
> +		pr_info("MTRRs set to read-only\n");
> +
> +		return;
> +	}
> +

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
