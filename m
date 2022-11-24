Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76FB7636F04
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Nov 2022 01:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiKXAk0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 19:40:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiKXAkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 19:40:24 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F420AAEBCE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 16:40:22 -0800 (PST)
Date:   Wed, 23 Nov 2022 16:40:16 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669250421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dwKCZVTaet+r/Ao/ZZyGQNy9e/1DBVJOZrEH4BYHHXA=;
        b=DvDw1lgMAEhgIPzyJDHrphzocWaHSHpaxMoAJWxNDG0JB9f5yrrepPUFBpHfslDY5exXP8
        4CGbgE2B2ARew1YWgwca686mUrPI6sIUHWKQcHpY6Of5uj4LHsumDVEAO1Qm2ODRfcqi8R
        jSrVtVSzhwB/15z9GneY/ZSneiQAbKQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 1/3] mm: memcg: fix stale protection of reclaim target
 memcg
Message-ID: <Y369cNnRWkoymF1G@P9FQF9L96D.corp.robot.car>
References: <20221123092132.2521764-1-yosryahmed@google.com>
 <20221123092132.2521764-2-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221123092132.2521764-2-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 23, 2022 at 09:21:30AM +0000, Yosry Ahmed wrote:
> During reclaim, mem_cgroup_calculate_protection() is used to determine
> the effective protection (emin and elow) values of a memcg. The
> protection of the reclaim target is ignored, but we cannot set their
> effective protection to 0 due to a limitation of the current
> implementation (see comment in mem_cgroup_protection()). Instead,
> we leave their effective protection values unchaged, and later ignore it
> in mem_cgroup_protection().
> 
> However, mem_cgroup_protection() is called later in
> shrink_lruvec()->get_scan_count(), which is after the
> mem_cgroup_below_{min/low}() checks in shrink_node_memcgs(). As a
> result, the stale effective protection values of the target memcg may
> lead us to skip reclaiming from the target memcg entirely, before
> calling shrink_lruvec(). This can be even worse with recursive
> protection, where the stale target memcg protection can be higher than
> its standalone protection. See two examples below (a similar version of
> example (a) is added to test_memcontrol in a later patch).
> 
> (a) A simple example with proactive reclaim is as follows. Consider the
> following hierarchy:
> ROOT
>  |
>  A
>  |
>  B (memory.min = 10M)
> 
> Consider the following scenario:
> - B has memory.current = 10M.
> - The system undergoes global reclaim (or memcg reclaim in A).
> - In shrink_node_memcgs():
>   - mem_cgroup_calculate_protection() calculates the effective min (emin)
>     of B as 10M.
>   - mem_cgroup_below_min() returns true for B, we do not reclaim from B.
> - Now if we want to reclaim 5M from B using proactive reclaim
>   (memory.reclaim), we should be able to, as the protection of the
>   target memcg should be ignored.
> - In shrink_node_memcgs():
>   - mem_cgroup_calculate_protection() immediately returns for B without
>     doing anything, as B is the target memcg, relying on
>     mem_cgroup_protection() to ignore B's stale effective min (still 10M).
>   - mem_cgroup_below_min() reads the stale effective min for B and we
>     skip it instead of ignoring its protection as intended, as we never
>     reach mem_cgroup_protection().
> 
> (b) An more complex example with recursive protection is as follows.
> Consider the following hierarchy with memory_recursiveprot:
> ROOT
>  |
>  A (memory.min = 50M)
>  |
>  B (memory.min = 10M, memory.high = 40M)
> 
> Consider the following scenario:
> - B has memory.current = 35M.
> - The system undergoes global reclaim (target memcg is NULL).
> - B will have an effective min of 50M (all of A's unclaimed protection).
> - B will not be reclaimed from.
> - Now allocate 10M more memory in B, pushing it above it's high limit.
> - The system undergoes memcg reclaim from B (target memcg is B).
> - Like example (a), we do nothing in mem_cgroup_calculate_protection(),
>   then call mem_cgroup_below_min(), which will read the stale effective
>   min for B (50M) and skip it. In this case, it's even worse because we
>   are not just considering B's standalone protection (10M), but we are
>   reading a much higher stale protection (50M) which will cause us to not
>   reclaim from B at all.
> 
> This is an artifact of commit 45c7f7e1ef17 ("mm, memcg: decouple
> e{low,min} state mutations from protection checks") which made
> mem_cgroup_calculate_protection() only change the state without
> returning any value. Before that commit, we used to return
> MEMCG_PROT_NONE for the target memcg, which would cause us to skip the
> mem_cgroup_below_{min/low}() checks. After that commit we do not return
> anything and we end up checking the min & low effective protections for
> the target memcg, which are stale.
> 
> Update mem_cgroup_supports_protection() to also check if we are
> reclaiming from the target, and rename it to mem_cgroup_unprotected()
> (now returns true if we should not protect the memcg, much simpler logic).
> 
> Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Reviewed-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!
