Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA046473FF
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbiLHQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiLHQQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:16:08 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4334BAD992
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:16:06 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 720B7208B2;
        Thu,  8 Dec 2022 16:16:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1670516165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRLagXkKmeXcUI+MhtRhuiGQoB9TArlcDvyl6UUGYBk=;
        b=vQM6oCgCOVXwFV5DYj98yA29qsTLcOVugq//N1Aabe0iC9QaR9hMXQXRHW9mQYoqGZgF33
        sR6aoF0IInhAbFtJdd+EAbuj+GHUg5FcKuDaLsMLkd27eKX05tiQyxmp4aOK2pd0xzy9wn
        lYiYYR6749emvc3Kvv+7/Lem33Zde/A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1670516165;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tRLagXkKmeXcUI+MhtRhuiGQoB9TArlcDvyl6UUGYBk=;
        b=cqPa/291QA0081oNI9E26jjdK0TvifhhMFbqCpEj0LsO1hZfyXg//NECr7lDppmi5C2ZqI
        +g8Fl6QDdhdO3YDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 52C8C138E0;
        Thu,  8 Dec 2022 16:16:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 6hiEE8UNkmN7IQAAMHmgww
        (envelope-from <vbabka@suse.cz>); Thu, 08 Dec 2022 16:16:05 +0000
Message-ID: <bba58246-47b6-1067-4da7-eb903224bd14@suse.cz>
Date:   Thu, 8 Dec 2022 17:16:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH 2/6] mm/page_alloc: Treat RT tasks similar to GFP_HIGH
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Linux-MM <linux-mm@kvack.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, NeilBrown <neilb@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20221129151701.23261-1-mgorman@techsingularity.net>
 <20221129151701.23261-3-mgorman@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221129151701.23261-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject should say __GFP_HIGH as there's no GFP_HIGH?

On 11/29/22 16:16, Mel Gorman wrote:
> RT tasks are allowed to dip below the min reserve but ALLOC_HARDER is
> typically combined with ALLOC_MIN_RESERVE so RT tasks are a little
> unusual. While there is some justification for allowing RT tasks
> access to memory reserves, there is a strong chance that a RT task
> that is also under memory pressure is at risk of missing deadlines
> anyway. Relax how much reserves an RT task can access by treating
> it the same as __GFP_HIGH allocations.
> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3b37909617bc..da746e9eb2cf 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4852,7 +4852,7 @@ gfp_to_alloc_flags(gfp_t gfp_mask)
>  		 */
>  		alloc_flags &= ~ALLOC_CPUSET;
>  	} else if (unlikely(rt_task(current)) && in_task())
> -		alloc_flags |= ALLOC_HARDER;
> +		alloc_flags |= ALLOC_MIN_RESERVE;
>  
>  	alloc_flags = gfp_to_alloc_flags_cma(gfp_mask, alloc_flags);
>  

