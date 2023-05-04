Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0986F663D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbjEDHsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjEDHsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:48:11 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F2A3C0C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:47:46 -0700 (PDT)
Received: from zn.tnic (p5de8e8ea.dip0.t-ipconnect.de [93.232.232.234])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id D447E1EC026E;
        Thu,  4 May 2023 09:47:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1683186459;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=3b1uoytFIRYdIcUS7fsaq2JRXTA2tYDW5tMubkn5SQU=;
        b=aqi5poEWEYHlQ0FBZAHjIl7O4mBbp72khZIdyN+Zl93JdOuZUk12QE4AfwHcw+FQXZv9WJ
        7PRhCJ+oV6Av9QdLQ1/HZD2EeYdx63Ib3stF3nd3/WYqCGBpVr3QewZ//h35VbRPDKaUVF
        hbvf1b+wofy6bbSMDyuL/5h1sU4LWfo=
Date:   Thu, 4 May 2023 09:47:33 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        mikelley@microsoft.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v6 01/16] x86/mtrr: remove physical address size
 calculation
Message-ID: <20230504074733.GAZFNjFeptgXvizi3J@fat_crate.local>
References: <20230502120931.20719-1-jgross@suse.com>
 <20230502120931.20719-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230502120931.20719-2-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 02, 2023 at 02:09:16PM +0200, Juergen Gross wrote:
> diff --git a/arch/x86/kernel/cpu/mtrr/generic.c b/arch/x86/kernel/cpu/mtrr/generic.c
> index ee09d359e08f..3922552340b1 100644
> --- a/arch/x86/kernel/cpu/mtrr/generic.c
> +++ b/arch/x86/kernel/cpu/mtrr/generic.c
> @@ -38,6 +38,16 @@ u64 mtrr_tom2;
>  struct mtrr_state_type mtrr_state;
>  EXPORT_SYMBOL_GPL(mtrr_state);
>  
> +static u64 size_or_mask, size_and_mask;
> +
> +void __init mtrr_set_mask(void)
> +{
> +	unsigned int phys_addr = boot_cpu_data.x86_phys_bits;
> +
> +	size_or_mask = ~GENMASK_ULL(phys_addr - PAGE_SHIFT - 1, 0);
> +	size_and_mask = ~size_or_mask & GENMASK_ULL(39, 20);

What happened to getting rid of those:

https://lore.kernel.org/r/20230405202633.GFZC3ZeVWtmjkODYW7@fat_crate.local

and using the reserved bitfield masks as they're defined for the MSRs?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
