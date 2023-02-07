Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13A6268D58C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 12:32:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjBGLcv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 06:32:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjBGLca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 06:32:30 -0500
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 164993A5AE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 03:31:15 -0800 (PST)
Received: from zn.tnic (p5de8e9fe.dip0.t-ipconnect.de [93.232.233.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CB31A1EC047F;
        Tue,  7 Feb 2023 12:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1675769472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=h7lnd9yay5DNxFl5I2HIyME+G/Sn/uJGuf8xwszLWZA=;
        b=qIzWX5xRIwrHS6V1xx4gjLHcKH6OgAT+yJ0I5QVL9OACA3z+AUp1Pb+QYqgLRb0VoyW309
        R8g43eTfNzQnMtRLWxRpjeWyLoqSVXdQ5BeFZrT8vUyVfVD2WJ8gsofEVxrahvIf07If/j
        HdYSsTOf9yB5BGgKynta7wQ1ZYbrmtM=
Date:   Tue, 7 Feb 2023 12:31:08 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Juergen Gross <jgross@suse.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 2/6] x86/pat: check for MTRRs enabled in memtype_reserve()
Message-ID: <Y+I2fD6zrU51OZOk@zn.tnic>
References: <20230207072902.5528-1-jgross@suse.com>
 <20230207072902.5528-3-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230207072902.5528-3-jgross@suse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 08:28:58AM +0100, Juergen Gross wrote:
> Today memtype_reserve() bails out early if pat_enabled() returns false.
> The same can be done in case MTRRs aren't enabled.
> 
> This will reinstate the behavior of memtype_reserve() before commit
> 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when
> running on Xen"). There have been reports about that commit breaking
> SEV-SNP guests under Hyper-V, which was tried to be resolved by commit
> 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case"),
> but that again resulted in problems with Xen PV guests.

No, no commit message text with references to other commits.

Considering how this is one of those "let's upset the universe" thing of
decoupling MTRRs from PAT and how it breaks in weird ways, if we ever
end up doing that, then we need to explain *exactly* why we're doing it.

And in detail.

Because otherwise, in the future, we'll end up scratching heads just
like we're doing now as to why the large page thing allowed those
certain types, and so on and so on.

> Fixes: 72cbc8f04fe2 ("x86/PAT: Have pat_enabled() properly reflect state when running on Xen")
> Fixes: 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/pat/memtype.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index fb4b1b5e0dea..18f612b43763 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -557,8 +557,12 @@ int memtype_reserve(u64 start, u64 end, enum page_cache_mode req_type,
>  		return -EINVAL;
>  	}
>  
> -	if (!pat_enabled()) {
> -		/* This is identical to page table setting without PAT */
> +	/*
> +	 * PAT disabled or MTRRs disabled don't require any memory type
> +	 * tracking or type adjustments, as there can't be any conflicts
> +	 * between PAT and MTRRs with at least one of both being disabled.
> +	 */
> +	if (!pat_enabled() || !mtrr_enabled()) {

Yah, looks straight-forward to me but I have said this before. And we
have broken shit so if anything, this needs to be tested on everything
before we go with it.

IMNSVHO.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
