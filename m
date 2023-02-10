Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E76925E9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 19:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233155AbjBJS7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 13:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjBJS7q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 13:59:46 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B847B381
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 10:59:45 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1pQYcY-0002ko-D3; Fri, 10 Feb 2023 19:59:42 +0100
Message-ID: <9046a3cb-928a-5476-1e72-63bd197c039e@leemhuis.info>
Date:   Fri, 10 Feb 2023 19:59:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 5/8] x86/mtrr: revert commit 90b926e68f50
Content-Language: en-US, de-DE
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     lists@nerdbynature.de, mikelley@microsoft.com,
        torvalds@linux-foundation.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>
References: <20230209072220.6836-1-jgross@suse.com>
 <20230209072220.6836-6-jgross@suse.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230209072220.6836-6-jgross@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1676055586;7704a9b2;
X-HE-SMSGID: 1pQYcY-0002ko-D3
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker.

On 09.02.23 08:22, Juergen Gross wrote:
> Commit 90b926e68f50 ("x86/pat: Fix pat_x_mtrr_type() for MTRR disabled
> case") has introduced a regression with Xen.
> 
> Revert the patch.

That regression you refer to is afaics one I'm tracking[1] that was
introduced this cycle. That makes me wonder: could this patch be applied
directly to fix the issue quickly? Or are patches 1 to 4 needed as well
(or the whole series?) to avoid other problems?

Ciao, Thorsten

[1]
https://lore.kernel.org/all/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/

P.S.: BTW; let me tell regzbot to monitor this thread:

#regzbot ^backmonitor:
https://lore.kernel.org/all/4fe9541e-4d4c-2b2a-f8c8-2d34a7284930@nerdbynature.de/


> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/mm/pat/memtype.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/x86/mm/pat/memtype.c b/arch/x86/mm/pat/memtype.c
> index fb4b1b5e0dea..46de9cf5c91d 100644
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
