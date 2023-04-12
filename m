Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63196DEF00
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjDLIqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbjDLIqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:46:42 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08588A57
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:46:20 -0700 (PDT)
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 043F31EC0688;
        Wed, 12 Apr 2023 10:45:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1681289147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=uE3gSAnWryP/3GGUVOJZECjE3+6ix60o4i2DBScP9B8=;
        b=j118p8yLfUE+aQ/Ri6Pi6ahQeLsKC0XQrJpVE3Xos21zjYgbyDmpf68vo2b3NXbywol3OO
        OgBu+1HpMSY+6p1i1dAjUxh6I92nhggMwiaym3PNB7J9iL6WFGYnQgi/RDL0CLI0+LRfDA
        UgHiH2OLffUVKJSelh7SmaXKeIX/xcE=
Date:   Wed, 12 Apr 2023 10:45:41 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v5 07/15] x86/mtrr: replace vendor tests in MTRR code
Message-ID: <20230412084541.GIZDZvtcMnWYJ7Kh6a@fat_crate.local>
References: <20230401063652.23522-1-jgross@suse.com>
 <20230401063652.23522-8-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230401063652.23522-8-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 01, 2023 at 08:36:44AM +0200, Juergen Gross wrote:
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

Replace with:

"Test the generic CPU feature X86_FEATURE_MTRR instead."

> diff --git a/arch/x86/kernel/cpu/mtrr/mtrr.c b/arch/x86/kernel/cpu/mtrr/mtrr.c
> index 1c19d67ddab3..46aae69d259e 100644
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
>  	num_var_ranges = config & MTRR_CONFIG_NUM_VAR_MASK;
>  }

From previous review which you've missed to incorporate:

"Since you're touching this function, you might simply expand its body in
its only call site in mtrr_bp_init(), put a comment above the expanded
code and remove that function.

That is, if we're going to do the ->var_regs thing."

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
