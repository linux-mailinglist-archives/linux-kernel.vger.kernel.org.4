Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692346E39D1
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Apr 2023 17:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbjDPPbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Apr 2023 11:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDPPbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Apr 2023 11:31:39 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD9D1FFF
        for <linux-kernel@vger.kernel.org>; Sun, 16 Apr 2023 08:31:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id F354421A46;
        Sun, 16 Apr 2023 15:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681659095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZJdDeYoccvK0HkfZcO7TKPtQnPVDW+juR9W+3yn6l0=;
        b=n+as61N+wacLx7P05kktsBpbfDQKvK0c2YJIa4e7efa5bhuUcuNv2Eck0e1JSvbyBmST6+
        X5ABuiopqzgXJFG0y4FU4VX7va6HyqbaZrZlbqx/EBn+v8yWZgOq4wsyEp63AknzstmGFQ
        Gcq1c131g9PYxmdHk3j1udUYR6x8thk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681659095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+ZJdDeYoccvK0HkfZcO7TKPtQnPVDW+juR9W+3yn6l0=;
        b=QIK/QEtIhWQYMGksEFEEVH7IUrM7gvsqnBDzRxMb07FBHfDCF5iAGWb738lJ/gi6wKClqr
        /8W7zMaQMQepQ0CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E3DF713498;
        Sun, 16 Apr 2023 15:31:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id nCJgN9YUPGTtbAAAMHmgww
        (envelope-from <osalvador@suse.de>); Sun, 16 Apr 2023 15:31:34 +0000
MIME-Version: 1.0
Date:   Sun, 16 Apr 2023 17:31:34 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <OSalvador@suse.com>,
        Yuanxi Liu <y.liu@naruida.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: page_alloc: Skip regions with hugetlbfs pages when
 allocating 1G pages
In-Reply-To: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
References: <20230414141429.pwgieuwluxwez3rj@techsingularity.net>
User-Agent: Roundcube Webmail
Message-ID: <253c6362834bf3c9deea94cfc7741920@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-04-14 16:14, Mel Gorman wrote:
> A bug was reported by Yuanxi Liu where allocating 1G pages at runtime 
> is
> taking an excessive amount of time for large amounts of memory. Further
> testing allocating huge pages that the cost is linear i.e. if 
> allocating
> 1G pages in batches of 10 then the time to allocate nr_hugepages from
> 10->20->30->etc increases linearly even though 10 pages are allocated 
> at
> each step. Profiles indicated that much of the time is spent checking 
> the
> validity within already existing huge pages and then attempting a 
> migration
> that fails after isolating the range, draining pages and a whole lot of
> other useless work.
> 
> Commit eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from
> pfn_range_valid_contig") removed two checks, one which ignored huge 
> pages
> for contiguous allocations as huge pages can sometimes migrate. While
> there may be value on migrating a 2M page to satisfy a 1G allocation, 
> it's
> potentially expensive if the 1G allocation fails and it's pointless to
> try moving a 1G page for a new 1G allocation or scan the tail pages for
> valid PFNs.
> 
> Reintroduce the PageHuge check and assume any contiguous region with
> hugetlbfs pages is unsuitable for a new 1G allocation.
> 
> The hpagealloc test allocates huge pages in batches and reports the
> average latency per page over time. This test happens just after boot 
> when
> fragmentation is not an issue. Units are in milliseconds.
> 
...
> 
> BugLink: https://bugzilla.kernel.org/show_bug.cgi?id=217022
> Fixes: eb14d4eefdc4 ("mm,page_alloc: drop unnecessary checks from
> pfn_range_valid_contig")
> Reported-by: Yuanxi Liu <y.liu@naruida.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

Thanks Mel!

-- 
Oscar Salvador
SUSE Labs
