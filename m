Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E53369B92A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 10:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjBRJrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 04:47:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBRJrv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 04:47:51 -0500
Received: from trent.utfs.org (trent.utfs.org [94.185.90.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD512E6
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 01:47:48 -0800 (PST)
Received: from localhost (localhost [IPv6:::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by trent.utfs.org (Postfix) with ESMTPS id 2FE835F781;
        Sat, 18 Feb 2023 10:47:46 +0100 (CET)
Date:   Sat, 18 Feb 2023 10:47:46 +0100 (CET)
From:   Christian Kujau <lists@nerdbynature.de>
To:     linux-kernel@vger.kernel.org
cc:     Juergen Gross <jgross@suse.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [tip: x86/urgent] x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix
 pat_x_mtrr_type() for MTRR disabled case")
In-Reply-To: <167636735608.4906.4788207020350311572.tip-bot2@tip-bot2>
Message-ID: <8a1fd8b7-9fe3-b2b5-406e-fa6f5e03e7c0@nerdbynature.de>
References: <4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de> <167636735608.4906.4788207020350311572.tip-bot2@tip-bot2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2023, tip-bot2 for Juergen Gross wrote:
> The following commit has been merged into the x86/urgent branch of tip:

Sorry for being dense but I couldn't figure this out from the tip tree 
handbook[0]: will this be included in 6.2 or has this ship sailed? If so, 
I'll start bugging the Alpine folks to maybe carry this around until the 
next release.

Thanks,
Christian.

[0] https://www.kernel.org/doc/html/latest/process/maintainer-tip.html

> 
> Commit-ID:     f9f57da2c2d119dbf109e3f6e1ceab7659294046
> Gitweb:        https://git.kernel.org/tip/f9f57da2c2d119dbf109e3f6e1ceab7659294046
> Author:        Juergen Gross <jgross@suse.com>
> AuthorDate:    Thu, 09 Feb 2023 08:22:17 +01:00
> Committer:     Borislav Petkov (AMD) <bp@alien8.de>
> CommitterDate: Tue, 14 Feb 2023 10:16:34 +01:00
> 
> x86/mtrr: Revert 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
> 
> Commit
> 
>   90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled case")
> 
> broke the use case of running Xen dom0 kernels on machines with an
> external disk enclosure attached via USB, see Link tag.
> 
> What this commit was originally fixing - SEV-SNP guests on Hyper-V - is
> a more specialized situation which has other issues at the moment anyway
> so reverting this now and addressing the issue properly later is the
> prudent thing to do.
> 
> So revert it in time for the 6.2 proper release.
> 
>   [ bp: Rewrite commit message. ]
> 
> Reported-by: Christian Kujau <lists@nerdbynature.de>
> Tested-by: Christian Kujau <lists@nerdbynature.de>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/r/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de
> ---
>  arch/x86/mm/pat/memtype.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index fb4b1b5..46de9cf 100644
> --- a/arch/x86/mm/pat/memtype.c
> +++ b/arch/x86/mm/pat/memtype.c
> @@ -387,8 +387,7 @@ static unsigned long pat_x_mtrr_type(u64 start, u64 end,
>  		u8 mtrr_type, uniform;
>  
>  		mtrr_type = mtrr_type_lookup(start, end, &uniform);
> -		if (mtrr_type != MTRR_TYPE_WRBACK &&
> -		    mtrr_type != MTRR_TYPE_INVALID)
> +		if (mtrr_type != MTRR_TYPE_WRBACK)
>  			return _PAGE_CACHE_MODE_UC_MINUS;
>  
>  		return _PAGE_CACHE_MODE_WB;
> 

-- 
BOFH excuse #155:

Dumb terminal
