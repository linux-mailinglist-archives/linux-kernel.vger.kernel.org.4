Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11FB06E263C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDNOxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNOxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:53:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 423E165A8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:53:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ECE5F1FD9D;
        Fri, 14 Apr 2023 14:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681483991; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zq/oh5Lz01qwAzowZIo2vh4+wtA8CDI8Eeckvi/+KAA=;
        b=Tv+meLRMJw9X5IGyOYJhyLLGEmE2OY0jONZQMLQlVGPNpAy5YQTVFcN0gO5NtrAfw+f9+d
        naVyDGAf0DW9/L43y388W+JjM1/uZnHzupoWuU2L4vo0pk1N+F3o6wAdAWpdRV91UzjNs6
        qLkkE5MBi+QjW+xcx4DsNgZyMN9U/iw=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE8D313498;
        Fri, 14 Apr 2023 14:53:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id KCJfKNZoOWSxMwAAMHmgww
        (envelope-from <mhocko@suse.com>); Fri, 14 Apr 2023 14:53:10 +0000
Date:   Fri, 14 Apr 2023 16:53:09 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Skip regions with hugetlbfs pages when
 allocating 1G pages
Message-ID: <ZDlo1ex3Tx5/rwsQ@dhcp22.suse.cz>
References: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-04-23 15:14:29, Mel Gorman wrote:
> A bug was reported by Yuanxi Liu where allocating 1G pages at runtime is
> taking an excessive amount of time for large amounts of memory. Further
> testing allocating huge pages that the cost is linear i.e. if allocating
> 1G pages in batches of 10 then the time to allocate nr_hugepages from
> 10->20->30->etc increases linearly even though 10 pages are allocated at
> each step. Profiles indicated that much of the time is spent checking the
> validity within already existing huge pages and then attempting a migration
> that fails after isolating the range, draining pages and a whole lot of
> other useless work.
> 
> Commit eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from
> pfn_range_valid_contig") removed two checks, one which ignored huge pages
> for contiguous allocations as huge pages can sometimes migrate. While
> there may be value on migrating a 2M page to satisfy a 1G allocation, it's
> potentially expensive if the 1G allocation fails and it's pointless to
> try moving a 1G page for a new 1G allocation or scan the tail pages for
> valid PFNs.
> 
> Reintroduce the PageHuge check and assume any contiguous region with
> hugetlbfs pages is unsuitable for a new 1G allocation.
> 
> The hpagealloc test allocates huge pages in batches and reports the
> average latency per page over time. This test happens just after boot when
> fragmentation is not an issue. Units are in milliseconds.
> 
> hpagealloc
>                                6.3.0-rc6              6.3.0-rc6              6.3.0-rc6
>                                  vanilla   hugeallocrevert-v1r1   hugeallocsimple-v1r2
> Min       Latency       26.42 (   0.00%)        5.07 (  80.82%)       18.94 (  28.30%)
> 1st-qrtle Latency      356.61 (   0.00%)        5.34 (  98.50%)       19.85 (  94.43%)
> 2nd-qrtle Latency      697.26 (   0.00%)        5.47 (  99.22%)       20.44 (  97.07%)
> 3rd-qrtle Latency      972.94 (   0.00%)        5.50 (  99.43%)       20.81 (  97.86%)
> Max-1     Latency       26.42 (   0.00%)        5.07 (  80.82%)       18.94 (  28.30%)
> Max-5     Latency       82.14 (   0.00%)        5.11 (  93.78%)       19.31 (  76.49%)
> Max-10    Latency      150.54 (   0.00%)        5.20 (  96.55%)       19.43 (  87.09%)
> Max-90    Latency     1164.45 (   0.00%)        5.53 (  99.52%)       20.97 (  98.20%)
> Max-95    Latency     1223.06 (   0.00%)        5.55 (  99.55%)       21.06 (  98.28%)
> Max-99    Latency     1278.67 (   0.00%)        5.57 (  99.56%)       22.56 (  98.24%)
> Max       Latency     1310.90 (   0.00%)        8.06 (  99.39%)       26.62 (  97.97%)
> Amean     Latency      678.36 (   0.00%)        5.44 *  99.20%*       20.44 *  96.99%*
> 
>                    6.3.0-rc6   6.3.0-rc6   6.3.0-rc6
>                      vanilla   revert-v1   hugeallocfix-v2
> Duration User           0.28        0.27        0.30
> Duration System       808.66       17.77       35.99
> Duration Elapsed      830.87       18.08       36.33
> 
> The vanilla kernel is poor, taking up to 1.3 second to allocate a huge page
> and almost 10 minutes in total to run the test. Reverting the problematic
> commit reduces it to 8ms at worst and the patch takes 26ms. This patch
> fixes the main issue with skipping huge pages but leaves the page_count()
> out because a page with an elevated count potentially can migrate.
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=217022
> Fixes: eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from pfn_range_valid_contig")
> Reported-by: Yuanxi Liu <y.liu@naruida.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Acked-by: Michal Hocko <mhocko@suse.com>
Thanks!

> ---
>  mm/page_alloc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7136c36c5d01..b47f520c3051 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9450,6 +9450,9 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>  
>  		if (PageReserved(page))
>  			return false;
> +
> +		if (PageHuge(page))
> +			return false;
>  	}
>  	return true;
>  }

-- 
Michal Hocko
SUSE Labs
