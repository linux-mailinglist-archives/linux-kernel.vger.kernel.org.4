Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7314B6337FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 10:09:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiKVJJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 04:09:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233260AbiKVJJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 04:09:21 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC834876A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 01:09:19 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 23CCE21AA4;
        Tue, 22 Nov 2022 09:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669108158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocCid8suFZ26SdTlwmD1wR7HL2ZEAq1UzTulsf3Qe8E=;
        b=bLyIFTAL66Q30UrOUCHfIPqdGW4SgNN75jyI1vPJSwD2zBUkv/APrv3jG+veV2j0YTloFg
        vm5Raf8QUD2KN/R3KjkGDSRuwdxdglWniwut5od3FVFICKFhQmwDxbgClYH+7VOhRcJaWV
        NMiwVXNMsPXlMe/awgv85sfW43EWVpo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669108158;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocCid8suFZ26SdTlwmD1wR7HL2ZEAq1UzTulsf3Qe8E=;
        b=7RHZfr6i0aOxagzBwntuqScPiFooH29odnJGUpIZvPDISam/lHF4klXDbr6UxRWXpFPogd
        tmL0WyqYByKUvMDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E435713B01;
        Tue, 22 Nov 2022 09:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id l2rhNr2RfGO4MAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Tue, 22 Nov 2022 09:09:17 +0000
Message-ID: <47e50136-eded-fbf4-4b63-7bf88b7fd791@suse.cz>
Date:   Tue, 22 Nov 2022 10:09:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] mm/page_alloc: Leave IRQs enabled for per-cpu page
 allocations
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
References: <20221118101714.19590-1-mgorman@techsingularity.net>
 <20221118101714.19590-3-mgorman@techsingularity.net>
 <f9acd363-bf53-c582-78ec-347fd7ec5c37@suse.cz>
 <20221121120121.djgvgm5bsklgfx7c@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20221121120121.djgvgm5bsklgfx7c@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/21/22 13:01, Mel Gorman wrote:
> On Fri, Nov 18, 2022 at 03:30:57PM +0100, Vlastimil Babka wrote:
>> On 11/18/22 11:17, Mel Gorman wrote:
> 
> While I think you're right, I think it's a bit subtle, the batch reset would
> need to move, rechecked within the "Different zone, different pcp lock."
> block and it would be easy to forget exactly why it's structured like
> that in the future.  Rather than being a fix, it could be a standalone
> patch so it would be obvious in git blame but I don't feel particularly
> strongly about it.
> 
> For the actual fixes to the patch, how about this? It's boot-tested only
> as I find it hard to believe it would make a difference to performance.

Looks good. Shouldn't make a difference indeed.

> 
> --8<--
> mm/page_alloc: Leave IRQs enabled for per-cpu page allocations -fix
> 
> As noted by Vlastimil Babka, the migratetype might be wrong if a PCP
> fails to lock so check the migrate type early. Similarly the !pcp check
> is generally unlikely so explicitly tagging it makes sense.
> 
> This is a fix for the mm-unstable patch
> mm-page_alloc-leave-irqs-enabled-for-per-cpu-page-allocations.patch
> 
> Reported-by: Vlastimil Babka <vbabka@suse.cz>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_alloc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 323fec05c4c6..445066617204 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3516,6 +3516,7 @@ void free_unref_page_list(struct list_head *list)
>  		struct zone *zone = page_zone(page);
>  
>  		list_del(&page->lru);
> +		migratetype = get_pcppage_migratetype(page);
>  
>  		/* Different zone, different pcp lock. */
>  		if (zone != locked_zone) {
> @@ -3530,7 +3531,7 @@ void free_unref_page_list(struct list_head *list)
>  			 */
>  			pcp_trylock_prepare(UP_flags);
>  			pcp = pcp_spin_trylock(zone->per_cpu_pageset);
> -			if (!pcp) {
> +			if (unlikely(!pcp)) {
>  				pcp_trylock_finish(UP_flags);
>  				free_one_page(zone, page, page_to_pfn(page),
>  					      0, migratetype, FPI_NONE);
> @@ -3545,7 +3546,6 @@ void free_unref_page_list(struct list_head *list)
>  		 * Non-isolated types over MIGRATE_PCPTYPES get added
>  		 * to the MIGRATE_MOVABLE pcp list.
>  		 */
> -		migratetype = get_pcppage_migratetype(page);
>  		if (unlikely(migratetype >= MIGRATE_PCPTYPES))
>  			migratetype = MIGRATE_MOVABLE;
>  
> 

