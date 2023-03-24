Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3766C82AF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 17:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjCXQ4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 12:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjCXQ4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 12:56:19 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65AEAD8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 09:56:18 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id F166D1EC052A;
        Fri, 24 Mar 2023 17:56:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1679676977;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=7ZRKSsns+egRH+T5pXbc9Siz0msd/nkSLiFV7f95bNo=;
        b=emP3UAe8KFcrpD0ZoVAtKVjycQ7eOEHAfoJMoKPqHNt/McjmWNPziiZ10njlW04ixVU9D+
        et5XMFRE2q6HwnwRxbrfaZiq8zTHjm/rrODzR1Dwaxm+x+leEQ1t+nWWon8qfDaWmIu16Z
        hD76Qb0Huv4lL7I4xHQVgWPzf3Wbszc=
Date:   Fri, 24 Mar 2023 17:56:11 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v4 06/12] x86/mtrr: replace vendor tests in MTRR code
Message-ID: <20230324165611.GIZB3WK13NdjceLWnN@fat_crate.local>
References: <20230306163425.8324-1-jgross@suse.com>
 <20230306163425.8324-7-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230306163425.8324-7-jgross@suse.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 05:34:19PM +0100, Juergen Gross wrote:
> Modern CPUs all share the same MTRR interface implemented via
> generic_mtrr_ops.
> 
> At several places in MTRR code this generic interface is deduced via
> is_cpu(INTEL) tests, which is only working due to X86_VENDOR_INTEL
> being 0 (the is_cpu() macro is testing mtrr_if->vendor, which isn't
> explicitly set in generic_mtrr_ops).
> 
> Fix that by replacing the is_cpu(INTEL) tests with testing for mtrr_if
> to be &generic_mtrr_ops.

Two things:

* is_cpu() checks also whether mtrr_if is set. And we don't set it for
all vendors. I wanted to replace that thing with a vendor check recently
but there's that little issue.

I guess for the cases where we have the generic MTRR implementation, we
can safely assume that mtrr_if is set. Which leads me to the second
thing:

* If you're going to test for &generic_mtrr_ops, then you can just as
well do

	cpu_feature_enabled(X86_FEATURE_MTRR)

which is a lot more telling.

> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 5fe62ee0361b..0c83990501f5 100644
> --- a/arch/x86/kernel/cpu/mtrr/mtrr.c
> +++ b/arch/x86/kernel/cpu/mtrr/mtrr.c
> @@ -108,14 +108,12 @@ static int have_wrcomb(void)
>  /*  This function returns the number of variable MTRRs  */
>  static void __init set_num_var_ranges(bool use_generic)
>  {
> -	unsigned long config = 0, dummy;
> +	unsigned long config, dummy;
>  
>  	if (use_generic)
>  		rdmsr(MSR_MTRRcap, config, dummy);
> -	else if (is_cpu(AMD) || is_cpu(HYGON))
> -		config = 2;
> -	else if (is_cpu(CYRIX) || is_cpu(CENTAUR))
> -		config = 8;
> +	else
> +		config = mtrr_if->var_regs;
>  
>  	num_var_ranges = config & 0xff;
>  }

Since you're touching this function, you might simply expand its body in
its only call site in mtrr_bp_init(), put a comment above the expanded
code and remove that function.

That is, if we're going to do the ->var_regs thing.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
