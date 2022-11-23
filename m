Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED77363563E
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 10:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237733AbiKWJ2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 04:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237684AbiKWJ0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 04:26:55 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E311121C6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:25:59 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id n188so12755649iof.8
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 01:25:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zfp4k1sKmziFXjGhxPUQOEODXUQiY7lJXnmdU3Z7u40=;
        b=r6us3HO2cpO+/juFHf/7AFGmFJRyTVVSJ90hkFyxxYWsiDt/6aUGQhLIWhkk0PwSTj
         xVub2pqsj9xv0xQbhGdd9XKOlLMAAZlVoSm5kCRHGdmvPa3T/XlH9qRc/p/nw6HalDg6
         sSmBDCEunURsqvvLl9+l4/YRatTsy/gVecvcU9gWueM5gFwMHmogfOjx1H3y1Xz+tLeo
         VsEp1RYA/wP9FRgTjaAdYyH9DemF4OpLSr+uCR5LGHxQed+PAVa0yjXLpYPMVUxb1Smj
         SOgTkKzTKeLqPhUFS75z6QpZBZqSQqMuo7wvd/Rzeq4eHDQdlN7QupWoYj057Y8Lr+4r
         /dYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfp4k1sKmziFXjGhxPUQOEODXUQiY7lJXnmdU3Z7u40=;
        b=jhyCARx64tEQwEflwCrbisLIv50pm3v5MalTA7o2VNKco0mGHT0Uqlc8GO5KFkDZvn
         bqOzLZ5MBbA1x1+13GXNg2dSCNLEhehrrI1DfMkwitsJ5LKeoUIyClKhZEk9hBrc/LFa
         KRmtlyCXAoq3zqde3sXd/4hEyT48wQd9ovDhpvgfpAuTV6tGgLTiEkMGa0Fbf1Yiz6x6
         PW8f5P1byhRXlz9MCUYuDO1eCSMrCb0yau2trptMTmzCPj/sKKWtU5TYbA0CdX/pHTeK
         1gJOiIUdICPLB4C93sQxHHXVu/PfS4S5yuS+gqstkOV0bjI6z7WorCf+qgN05YQbID4E
         zpgA==
X-Gm-Message-State: ANoB5pkMvbin0fYfP4xoUSXgH39ZjsU6eS9JBVybmbO7VU5SJtkz0fTh
        6X+nN7N0zDzoJCVOW/jUEKSQ2RgXRIkdFzbbeutvMqYw2OetGw==
X-Google-Smtp-Source: AA0mqf77pd4P8P/sGrZTQOi1dKZNs4aduy+YQPImiNt4QrXMlDSAmAs0JLMcZKDUKdjhOCIzRqOIS8G6A9+w53Dqp2U=
X-Received: by 2002:a02:2422:0:b0:375:1ad6:e860 with SMTP id
 f34-20020a022422000000b003751ad6e860mr13348375jaa.191.1669195558797; Wed, 23
 Nov 2022 01:25:58 -0800 (PST)
MIME-Version: 1.0
References: <20221122232721.2306102-1-yosryahmed@google.com> <Y31rSglEcTaaIg05@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y31rSglEcTaaIg05@P9FQF9L96D.corp.robot.car>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Wed, 23 Nov 2022 01:25:22 -0800
Message-ID: <CAJD7tkYrXYL3KqcFg0Hzxaa=2rEz_oxcAGZ5Gs77JPs8ysnXEw@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: fix stale protection of reclaim target memcg
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>, Yu Zhao <yuzhao@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Vasily Averin <vasily.averin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Chris Down <chris@chrisdown.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 4:37 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
>
> On Tue, Nov 22, 2022 at 11:27:21PM +0000, Yosry Ahmed wrote:
> > During reclaim, mem_cgroup_calculate_protection() is used to determine
> > the effective protection (emin and elow) values of a memcg. The
> > protection of the reclaim target is ignored, but we cannot set their
> > effective protection to 0 due to a limitation of the current
> > implementation (see comment in mem_cgroup_protection()). Instead,
> > we leave their effective protection values unchaged, and later ignore it
> > in mem_cgroup_protection().
> >
> > However, mem_cgroup_protection() is called later in
> > shrink_lruvec()->get_scan_count(), which is after the
> > mem_cgroup_below_{min/low}() checks in shrink_node_memcgs(). As a
> > result, the stale effective protection values of the target memcg may
> > lead us to skip reclaiming from the target memcg entirely, before
> > calling shrink_lruvec(). This can be even worse with recursive
> > protection, where the stale target memcg protection can be higher than
> > its standalone protection.
> >
> > An example where this can happen is as follows. Consider the following
> > hierarchy with memory_recursiveprot:
> > ROOT
> >  |
> >  A (memory.min = 50M)
> >  |
> >  B (memory.min = 10M, memory.high = 40M)
> >
> > Consider the following scenarion:
> > - B has memory.current = 35M.
> > - The system undergoes global reclaim (target memcg is NULL).
> > - B will have an effective min of 50M (all of A's unclaimed protection).
> > - B will not be reclaimed from.
> > - Now allocate 10M more memory in B, pushing it above it's high limit.
> > - The system undergoes memcg reclaim from B (target memcg is B)
> > - In shrink_node_memcgs(), we call mem_cgroup_calculate_protection(),
> >   which immediately returns for B without doing anything, as B is the
> >   target memcg, relying on mem_cgroup_protection() to ignore B's stale
> >   effective min (still 50M).
> > - Directly after mem_cgroup_calculate_protection(), we will call
> >   mem_cgroup_below_min(), which will read the stale effective min for B
> >   and skip it (instead of ignoring its protection as intended). In this
> >   case, it's really bad because we are not just considering B's
> >   standalone protection (10M), but we are reading a much higher stale
> >   protection (50M) which will cause us to not reclaim from B at all.
> >
> > This is an artifact of commit 45c7f7e1ef17 ("mm, memcg: decouple
> > e{low,min} state mutations from protection checks") which made
> > mem_cgroup_calculate_protection() only change the state without
> > returning any value. Before that commit, we used to return
> > MEMCG_PROT_NONE for the target memcg, which would cause us to skip the
> > mem_cgroup_below_{min/low}() checks. After that commit we do not return
> > anything and we end up checking the min & low effective protections for
> > the target memcg, which are stale.
> >
> > Add mem_cgroup_ignore_protection() that checks if we are reclaiming from
> > the target memcg, and call it in mem_cgroup_below_{min/low}() to ignore
> > the stale protection of the target memcg.
> >
> > Fixes: 45c7f7e1ef17 ("mm, memcg: decouple e{low,min} state mutations from protection checks")
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Great catch!
> The fix looks good to me, only a couple of cosmetic suggestions.
>
> > ---
> >  include/linux/memcontrol.h | 33 +++++++++++++++++++++++++++------
> >  mm/vmscan.c                | 11 ++++++-----
> >  2 files changed, 33 insertions(+), 11 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index e1644a24009c..22c9c9f9c6b1 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -625,18 +625,32 @@ static inline bool mem_cgroup_supports_protection(struct mem_cgroup *memcg)
> >
> >  }
> >
> > -static inline bool mem_cgroup_below_low(struct mem_cgroup *memcg)
> > +static inline bool mem_cgroup_ignore_protection(struct mem_cgroup *target,
> > +                                             struct mem_cgroup *memcg)
> >  {
> > -     if (!mem_cgroup_supports_protection(memcg))
>
> How about to merge mem_cgroup_supports_protection() and your new helper into
> something like mem_cgroup_possibly_protected()? It seems like they never used
> separately and unlikely ever will be used.
> Also, I'd swap target and memcg arguments.
>
> Thank you!
>
>
> PS If it's not too hard, please, consider adding a new kselftest to cover this case.
> Thank you!

Sent v2 with mem_cgroup_supports_protection() and
mem_cgroup_ignore_protection() merged into mem_cgroup_unprotected().

Also added a test case to test_memcontrol.c:test_memcg_protection.
Since the scenario in the bash test and the v1 commit log was too
complicated, I extended the existing test with a simpler scenario
based on proactive reclaim, and reused some functionality from
test_memcg_reclaim(). I also included explaining that simple proactive
reclaim scenario in the commit log of the fix.

Writing a test for the more complex scenario with recursive protection
would be more involved, so I think this should be enough for now :)
