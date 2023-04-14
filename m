Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18AA6E25FB
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 16:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjDNOlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 10:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbjDNOkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 10:40:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A248EC160
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1681483194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sG4yK/TOLxym+JLV5xeX+hZs0uy2QtpBhj9MkCeWpIE=;
        b=PwZPjzNGXDwOyo+NXuN98S2RxFmBfx0WYiOodroVjQOTRnTY9dMAHsXVNMZ5sLJIKMBK/P
        dQ9RlkcSdQLlin0SSBZ+dldFgoochWmD8VzImXu69OLUpzonGJ29HdT2MT2jHaW/XTgo7+
        5Bm7BQnCbId+fngp2LUngTURn/hIMOE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-NO2z0zv-McqN3yEmdI0wVg-1; Fri, 14 Apr 2023 10:39:53 -0400
X-MC-Unique: NO2z0zv-McqN3yEmdI0wVg-1
Received: by mail-wm1-f72.google.com with SMTP id j15-20020a05600c1c0f00b003f0a83bf082so2679002wms.8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 07:39:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681483192; x=1684075192;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sG4yK/TOLxym+JLV5xeX+hZs0uy2QtpBhj9MkCeWpIE=;
        b=TShhhc7VqkxJt2UxYy+gUmMtzkqBEi/qdbuo0/LO1vLCT8yj0E2cJPPnOmCUf2bglE
         23LeVSoDk29tenN+aGjjENMBadnbQLTlO+37W1w3iReUAsfnXH5uQ6Tczvu3uH2KcVPN
         qM7dD2fRhqenXH+845gFcNxyNEGS0KdKTkTGDCxRckyhR6THBUACVJulF66gGmWkNXuD
         4v/gccGYG1ipzjURN4V7wXx/wNglJgX8NBZp09og2a6R/6/OJvvzfmzG1C58U45Qh8AJ
         f2mCtndA6scSo3SgPBLb2i24X/Ak1uO6YqjDNzJrwcFcSmmtA9aiMC4nV2eUF6d5HMqm
         aJvw==
X-Gm-Message-State: AAQBX9e+9k9i+BVKG1/8172Cmp293IJTw4jamZbY7/KudGqkKBCZop8V
        JoUvwGUv80Q0KP3BGNcIRoNwzP25i8w1eImc4hAO0/GEqp9M4GtHOAjk4IwvgVUGnZa2tFgZDN5
        +FqbFk9jdoUsTY1UbjhHi+fbJ
X-Received: by 2002:a1c:e916:0:b0:3ee:b3bf:5f7c with SMTP id q22-20020a1ce916000000b003eeb3bf5f7cmr4436938wmc.23.1681483192285;
        Fri, 14 Apr 2023 07:39:52 -0700 (PDT)
X-Google-Smtp-Source: AKy350ajpuhomcgDMexRQTagIyyjV3SARUkfLNZ+e4RtxbW08d/nVJC7kwMoDCf3qu8qVSGUOA1iUA==
X-Received: by 2002:a1c:e916:0:b0:3ee:b3bf:5f7c with SMTP id q22-20020a1ce916000000b003eeb3bf5f7cmr4436921wmc.23.1681483191916;
        Fri, 14 Apr 2023 07:39:51 -0700 (PDT)
Received: from ?IPV6:2003:cb:c702:5700:cb5b:f73a:c650:1d9? (p200300cbc7025700cb5bf73ac65001d9.dip0.t-ipconnect.de. [2003:cb:c702:5700:cb5b:f73a:c650:1d9])
        by smtp.gmail.com with ESMTPSA id i8-20020a5d5228000000b002efb4dc5a5fsm3734751wra.7.2023.04.14.07.39.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 07:39:51 -0700 (PDT)
Message-ID: <377e6f67-e1c1-38d7-9743-9783c90489b8@redhat.com>
Date:   Fri, 14 Apr 2023 16:39:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] mm: page_alloc: Skip regions with hugetlbfs pages when
 allocating 1G pages
Content-Language: en-US
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.23 16:14, Mel Gorman wrote:
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
>                                 6.3.0-rc6              6.3.0-rc6              6.3.0-rc6
>                                   vanilla   hugeallocrevert-v1r1   hugeallocsimple-v1r2
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
>                     6.3.0-rc6   6.3.0-rc6   6.3.0-rc6
>                       vanilla   revert-v1   hugeallocfix-v2
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
> ---
>   mm/page_alloc.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 7136c36c5d01..b47f520c3051 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -9450,6 +9450,9 @@ static bool pfn_range_valid_contig(struct zone *z, unsigned long start_pfn,
>   
>   		if (PageReserved(page))
>   			return false;
> +
> +		if (PageHuge(page))
> +			return false;
>   	}
>   	return true;
>   }
> 
Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

