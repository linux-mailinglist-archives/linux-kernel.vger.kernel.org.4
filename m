Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1F45BD52F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 21:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbiISTZn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 15:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiISTZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 15:25:41 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C21245F5A
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 12:25:40 -0700 (PDT)
Received: from zn.tnic (p200300ea9733e79d329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9733:e79d:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AE7D1EC01D2;
        Mon, 19 Sep 2022 21:25:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1663615534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=F9PypRJJonu/owp4xrRfoXhBJ3jDL2onqnjEb1GXu3Y=;
        b=e73OG2H0WGw9U8n57rAKIiTBCILi25gC0NTfDGY8v21Yznj6PkJjSepxXE+TLVdgVuXfBP
        JTb1vTweHpXufHSi//l9bVP40yg3OS7zY3NuanLnAgGopwqabn4DwvIdJ+nJlG3iOB19h3
        O+cPJ4/A4lxbtmRf0RizHjQwCcaMCTA=
Date:   Mon, 19 Sep 2022 21:25:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v3 05/10] x86/mtrr: split generic_set_all()
Message-ID: <YyjCKs7H3Lvnf3Jr@zn.tnic>
References: <20220908084914.21703-1-jgross@suse.com>
 <20220908084914.21703-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220908084914.21703-6-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 10:49:09AM +0200, Juergen Gross wrote:
> Split generic_set_all() into multiple parts, while moving the main
> function body into cacheinfo.c.
> 
> This prepares the support of PAT without needing MTRR support by

"Prepare PAT support without ... "

> moving the main function body of generic_set_all() into cacheinfo.c
> while renaming it to cache_cpu_init(). The MTRR specific parts are
> moved into a dedicated small function called by cache_cpu_init().
> The PAT and MTRR specific functions are called conditionally based
> on the cache_generic bit settings.
> 
> The setting of smp_changes_mask is merged into the (new) function

... and so on. So the commit message should not say what you're doing -
that should be visible from the diff itself. It should talk more about
the *why* you're doing it.

...

> diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
> index 47e2c72fa8a4..36378604ec61 100644
> --- a/arch/x86/kernel/cpu/cacheinfo.c
> +++ b/arch/x86/kernel/cpu/cacheinfo.c
> @@ -1120,3 +1120,22 @@ void cache_enable(void) __releases(cache_disable_lock)
>  
>  	raw_spin_unlock(&cache_disable_lock);
>  }
> +
> +void cache_cpu_init(void)
> +{
> +	unsigned long flags;
> +
> +	local_irq_save(flags);
> +	cache_disable();
> +
> +	/* Set MTRR state. */

Yeah, and when you name the functions properly as you've done, you don't
really need those comments anymore either.

> +	if (cache_generic & CACHE_GENERIC_MTRR)
> +		mtrr_generic_set_state();
> +
> +	/* Set PAT. */

And this one.

> +	if (cache_generic & CACHE_GENERIC_PAT)
> +		pat_init();
> +
> +	cache_enable();
> +	local_irq_restore(flags);
> +}
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> index 5ed397f03a87..fc7b2d952737 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -731,30 +731,19 @@ void mtrr_enable(void)
>  	mtrr_wrmsr(MSR_MTRRdefType, deftype_lo, deftype_hi);
>  }
>  
> -static void generic_set_all(void)
> +void mtrr_generic_set_state(void)
>  {
>  	unsigned long mask, count;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	cache_disable();
>  
>  	/* Actually set the state */
>  	mask = set_mtrr_state();
>  
> -	/* also set PAT */
> -	pat_init();
> -
> -	cache_enable();
> -	local_irq_restore(flags);
> -
>  	/* Use the atomic bitops to update the global mask */
>  	for (count = 0; count < sizeof(mask) * 8; ++count) {
>  		if (mask & 0x01)
>  			set_bit(count, &smp_changes_mask);
>  		mask >>= 1;
>  	}
> -
>  }
>  
>  /**
> @@ -854,7 +843,7 @@ int positive_have_wrcomb(void)
>   * Generic structure...
>   */
>  const struct mtrr_ops generic_mtrr_ops = {
> -	.set_all		= generic_set_all,
> +	.set_all		= cache_cpu_init,

I was gonna say that this looks weird - a set_all function pointer
assigned to a init function but that changes in the next patch.

But yeah, I like where this is going.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
