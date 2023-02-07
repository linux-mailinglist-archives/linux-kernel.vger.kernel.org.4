Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E12068D5DF
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjBGLnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:43:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjBGLnH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:43:07 -0500
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A91826BE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:42:53 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id EB32F1EC047F;
        Tue,  7 Feb 2023 12:42:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675770172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=41j/IaMcFXFa59PYCDGIDQ4/TVq3Ye7U37Xqft1wRRo=;
        b=bw43+KAaTaBozJw2Mb9CmVTnmAxJXHk4R5K2Vso8ZFawwaKJT78usu/OBfsL27e2vI3qhJ
        RfOjKiOXrWcd0jyuVDAsfNX2qlKU3AXZpSyw/yLSwnSij0zDdcoFwq/uqWhQbi9V0LeaAJ
        TbiEfsT4uB991ixgLWUgeZfp2nlhzFo=
Date:   Tue, 7 Feb 2023 12:42:47 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>, "Kani, Toshi" <toshi.kani@hpe.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 5/6] x86/mm: only check uniform after calling
 mtrr_type_lookup()
Message-ID: <Y+I5NyAeu4LWFBcA@zn.tnic>
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-6-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230207072902.5528-6-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:29:01AM +0100, Juergen Gross wrote:
> Today pud_set_huge() and pmd_set_huge() test for the MTRR type to be
> WB or INVALID after calling mtrr_type_lookup(). Those tests can be
> dropped, as the only reason to not use a large mapping would be
> uniform being 0. Any MTRR type can be accepted as long as it applies
> to the whole memory range covered by the mapping, as the alternative
> would only be to map the same region with smaller pages instead using
> the same PAT type as for the large mapping.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/pgtable.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index e4f499eb0f29..7b9c5443d176 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -721,8 +721,7 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
>  	u8 mtrr, uniform;
>  
>  	mtrr = mtrr_type_lookup(addr, addr + PUD_SIZE, &uniform);
> -	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
> -	    (mtrr != MTRR_TYPE_WRBACK))
> +	if (!uniform)
>  		return 0;
>  
>  	/* Bail out if we are we on a populated non-leaf entry: */
> @@ -748,8 +747,7 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
>  	u8 mtrr, uniform;
>  
>  	mtrr = mtrr_type_lookup(addr, addr + PMD_SIZE, &uniform);
> -	if ((mtrr != MTRR_TYPE_INVALID) && (!uniform) &&
> -	    (mtrr != MTRR_TYPE_WRBACK)) {
> +	if (!uniform) {
>  		pr_warn_once("%s: Cannot satisfy [mem %#010llx-%#010llx] with a huge-page mapping due to MTRR override.\n",
>  			     __func__, addr, addr + PMD_SIZE);
>  		return 0;
> -- 

See my reply here:

https://lore.kernel.org/all/Y+DLqV5MfuBJRnb6@zn.tnic

I understand it as WB is ok, for example, even if not uniform. That
thing in mtrr_type_lookup():

        /*
         * Look up the fixed ranges first, which take priority over
         * the variable ranges.
         */
        if ((start < 0x100000) &&
            (mtrr_state.have_fixed) &&
            (mtrr_state.enabled & MTRR_STATE_MTRR_FIXED_ENABLED)) {
                is_uniform = 0;
                type = mtrr_type_lookup_fixed(start, end);
                goto out;
        }

If that can return WB, then I guess that says it is still ok. Can the
fixed ranges even cover a, at least a PMD? I guess I need to stare at
this more.

Lemme add Toshi who authored that code - he might have a comment or two.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
