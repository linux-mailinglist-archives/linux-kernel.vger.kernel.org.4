Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933D16E25EC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDNOjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbjDNOi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:38:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48143B460
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:38:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id E8A2C219E5;
        Fri, 14 Apr 2023 14:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1681483118; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKkcRNPVtLEhv1N06+iXT1LK1bajNyNsHds/Gh6DN38=;
        b=CD/AS2yPJh3gAuVMWrOPga9JpzsCFANVwlPWxflhq0w2c61fyOiIU4uK8PI4Xcbbh05UAQ
        3O4hvOwxtlK21bJ1eJtjDUhx0HkOzHbbyOU2jFI4a8zl2aSE96Cuc4O3U7IdT/FOcDLJbB
        BmS5clZB9aPSofxoNOY1Poni85ELTUg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1681483118;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fKkcRNPVtLEhv1N06+iXT1LK1bajNyNsHds/Gh6DN38=;
        b=uqW/sUzjDdM4r1S2Mc88t/ovdq6QEKlBmSWk1KSsb+D3eKGQu42LScS/Vi2bVvbzztOaUt
        9wBnJLAtQ9A/NoDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC2E713498;
        Fri, 14 Apr 2023 14:38:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 3EARLW5lOWRTLAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Fri, 14 Apr 2023 14:38:38 +0000
Message-ID: <e84c068c-f07c-bb03-12f6-4e171cdaf80f@suse.cz>
Date:   Fri, 14 Apr 2023 16:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] mm: page_alloc: Skip regions with hugetlbfs pages when
 allocating 1G pages
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/23 16:14, Mel Gorman wrote:
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

Acked-by: Vlastimil Babka <vbabka@suse.cz>

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

