Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEB51692FE6
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 11:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjBKKIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 05:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjBKKIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 05:08:48 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 515F7301BC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 02:08:47 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id DD3071EC0758;
        Sat, 11 Feb 2023 11:08:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1676110125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=SjUwam36BHvZqpLaoUqMHGyknDCmWaXXVc3iHJRhjyc=;
        b=O6/GowsgzYlVcPho8Wb/1vNXn3nOre++k619JopjK6rUqY8I5XkmmviDUq3IfUNa3qEJp2
        lBZzunsKvqmbhKFle3Y9IOXOIEFvWW9GUd+x8CLVP33ZOXkXaJDsAUFKe8nCrNHZVdPvG8
        R994LpzXJ8YxG2EeenCn7hLjPhx1+NQ=
Date:   Sat, 11 Feb 2023 11:08:39 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 1/8] x86/mtrr: split off physical address size
 calculation
Message-ID: <Y+dpJ5BY1gI9jaI2@zn.tnic>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-2-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230209072220.6836-2-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 09, 2023 at 08:22:13AM +0100, Juergen Gross wrote:
> @@ -654,42 +638,54 @@ void __init mtrr_bp_init(void)
>  			    (boot_cpu_data.x86_stepping == 0x3 ||
>  			     boot_cpu_data.x86_stepping == 0x4))
>  				phys_addr = 36;
> -
> -			size_or_mask = SIZE_OR_MASK_BITS(phys_addr);
> -			size_and_mask = ~size_or_mask & 0xfffff00000ULL;
>  		} else if (boot_cpu_data.x86_vendor == X86_VENDOR_CENTAUR &&
>  			   boot_cpu_data.x86 == 6) {
>  			/*
>  			 * VIA C* family have Intel style MTRRs,
>  			 * but don't support PAE
>  			 */
> -			size_or_mask = SIZE_OR_MASK_BITS(32);
> -			size_and_mask = 0;
>  			phys_addr = 32;
>  		}
> +	}
> +
> +	size_or_mask = ~((1ULL << ((phys_addr) - PAGE_SHIFT)) - 1);

Too many brackets because you've taken the macro and put in the argument
directly.

In any case, reviewing patches which do code movement *and* changes in
the same diff is always unnecessarily nasty. Please do the mechanical
code movement only - cleanups come ontop.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
