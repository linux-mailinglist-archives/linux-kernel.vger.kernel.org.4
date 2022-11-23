Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66185634BB8
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235291AbiKWAhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiKWAhv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:37:51 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A418C12AFE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:37:49 -0800 (PST)
Date:   Tue, 22 Nov 2022 16:37:30 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1669163868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1vkqWV3BORpQGzdq3wZ6blydOpOGkzZln0X3Ao/u9AM=;
        b=w2EJu7hc6ylrM8Q+4ASnl/sZGCrW960jl5kuc6s1uAuR7t8s3jFAw3wujA0CO2h3AU9IAi
        CY0ThaQgr2zLx1uDRgBuTtnuqSgxeJaESyBNvXegXKEB0A78P5/jsWtj4Hk7WZLabONKp4
        NQ8eWPa/ac4ZjMTyF6Aswen2Lwes22I=
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
Subject: Re: [PATCH] mm: memcg: fix stale protection of reclaim target memcg
Message-ID: <Y31rSglEcTaaIg05@P9FQF9L96D.corp.robot.car>
References: <20221122232721.2306102-1-yosryahmed@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221122232721.2306102-1-yosryahmed@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 11:27:21PM +0000, Yosry Ahmed wrote:
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
> its standalone protection.
> 
> An example where this can happen is as follows. Consider the following
> hierarchy with memory_recursiveprot:
> ROOT
>  |
>  A (memory.min = 50M)
>  |
>  B (memory.min = 10M, memory.high = 40M)
> 
> Consider the following scenarion:
> - B has memory.current = 35M.
> - The system undergoes global reclaim (target memcg is NULL).
> - B will have an effective min of 50M (all of A's unclaimed protection).
> - B will not be reclaimed from.
> - Now allocate 10M more memory in B, pushing it above it's high limit.
> - The system undergoes memcg reclaim from B (target memcg is B)
> - In shrink_node_memcgs(), we call mem_cgroup_calculate_protection(),
>   which immediately returns for B without doing anything, as B is the
>   target memcg, relying on mem_cgroup_protection() to ignore B's stale
>   effective min (still 50M).
> - Directly after mem_cgroup_calculate_protection(), we will call
>   mem_cgroup_below_min(), which will read the stale effective min for B
>   and skip it (instead of ignoring its protection as intended). In this
>   case, it's really bad because we are not just considering B's
>   standalone protection (10M), but we are reading a much higher stale
>   protection (50M) which will cause us to not reclaim from B at all.
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
> Add mem_cgroup_ignore_protection() that checks if we are reclaiming from
> the target memcg, and call it in mem_cgroup_below_{min/low}() to ignore
> the stale protection of the target memcg.
> 
> Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Great catch!
The fix looks good to me, only a couple of cosmetic suggestions.

> ---
>  include/linux/memcontrol.h | 33 +++++++++++++++++++++++++++------
>  mm/vmscan.c                | 11 ++++++-----
>  2 files changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index e1644a24009c..22c9c9f9c6b1 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -625,18 +625,32 @@ static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
>  
>  }
>  
> -static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
> +static inline bool mem_cgroup_ignore_protection(struct mem_cgroup *target,
> +						struct mem_cgroup *memcg)
>  {
> -	if (!mem_cgroup_supports_protection(memcg))

How about to merge mem_cgroup_supports_protection() and your new helper into
something like mem_cgroup_possibly_protected()? It seems like they never used
separately and unlikely ever will be used.
Also, I'd swap target and memcg arguments.

Thank you!


PS If it's not too hard, please, consider adding a new kselftest to cover this case.
Thank you!
