Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6997D634BCC
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 01:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235326AbiKWAqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 19:46:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235329AbiKWAq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 19:46:28 -0500
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E3F9D907C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:46:26 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id bp12so7873732ilb.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Nov 2022 16:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HCqiKLLnoiFcJW128YgyhQV3aZ+j8zueWc+2Mjy7QDw=;
        b=P2OPgvc42GjVbzAFJtllZKLMFc61w1isQHKvEcP5yiMOWGleesqrhoLQIQhdsP6GDE
         9ps4Tq2j7LR+SSAH64kH1RYuigJP8KjN/6AmU7YYZ4Lvn3Cgb7fOiqvN28u6CW/0K9Uf
         dKonoiT2zED/Kx4CTxRDpW9zGZ1mkvyg7q4vA/qp6GPpNkbX6Cehih0gRIhpbatSdfSZ
         cbaM9L0H8DQ65UZVwA/K5tVtRMmlA+zlRMVEyYy9P2cS3gw2Y4T2tetE5XchKLnLCX7u
         2UaJGyeTgRsdUXq1dlrlP6FzM9aSYHLyomGWwfhRZpZSBWs8KfcmXVZz1TMnj6c+Zpcz
         5EnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HCqiKLLnoiFcJW128YgyhQV3aZ+j8zueWc+2Mjy7QDw=;
        b=GLxQ4di22MAItuDKrh50j86XcanfiTgjLGiKTGCmuZshWsnAR9rUQatSaGJ7XvVHSa
         UL9eeZLnse1TKZVM8Cz8tTI6xsPhvO2jOQLYhe2OSccn0Og/0RB+bdm/VP5om5PDrvnU
         RpmRzblgsHJS23kSfkC28e4sIN9GZjPA5RZlZJQzUMnv99gwcaw5p67gYgIgMsxz2VJJ
         ZF/32C6T1grSm4YIJXxandYJAvPbvioFB1uNfPDQRWRkJsPiyT/g3p/ITAXytpbZCP0r
         dMUXp3AvKsCRET4AHJi/AUmfG3sh8ZoydeMFGxSbq+bsVXtL3AQtOqL8lKaPMsYUqZoS
         HrOg==
X-Gm-Message-State: ANoB5pm3Do8m6nrbvJhNlkLI/LXS9yuLTtasuAmFcVhzz0CRFRI3mKL/
        9Y/eyA4YUwPakXLFR9a+ObCokJiw8WL5OL6LN5lpRQ==
X-Google-Smtp-Source: AA0mqf4L0GbX8I8q8w0YiGVmt4MtBul+hhQ7iVRKGIEZLiVPea/oqIJVTnMpmzrKMqVduKgfXyGBhocQot8JgF/gX/M=
X-Received: by 2002:a92:7310:0:b0:302:571f:8d7f with SMTP id
 o16-20020a927310000000b00302571f8d7fmr11554477ilc.53.1669164385808; Tue, 22
 Nov 2022 16:46:25 -0800 (PST)
MIME-Version: 1.0
References: <20221122232721.2306102-1-yosryahmed@google.com> <Y31rSglEcTaaIg05@P9FQF9L96D.corp.robot.car>
In-Reply-To: <Y31rSglEcTaaIg05@P9FQF9L96D.corp.robot.car>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 22 Nov 2022 16:45:50 -0800
Message-ID: <CAJD7tkZE6TLDShcntnY=tXnRpA6jx1uLMemeZtqWLZ3JAC_GNg@mail.gmail.com>
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

Sounds good! I am thinking maybe mem_cgroup_no_protection() which is
an inlining of !mem_cgroup_supports_protection() ||
mem_cgorup_ignore_protection().

> Also, I'd swap target and memcg arguments.

Sounds good.

>
> Thank you!
>
>
> PS If it's not too hard, please, consider adding a new kselftest to cover this case.
> Thank you!

I will try to translate my bash test to something in test_memcontrol,
I don't plan to spend a lot of time on it though so I hope it's simple
enough..
