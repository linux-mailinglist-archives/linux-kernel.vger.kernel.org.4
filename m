Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161AE716D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjE3TNx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233333AbjE3TNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:13:43 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FCB113
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:13:38 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-75affe9d7feso562933385a.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 12:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685474017; x=1688066017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B+LD9VU/Kdgo99Hgebbbih6KGEIqzpFiVw8bD+mVg98=;
        b=VkX3oMD9acgbPVFWr0cZ5G4FNcWVjQipAK+mM0BYAA0r6w4yFjvmSKZ22PldQRnlmD
         lRupbfSo5W/cWyMJTDjVl2OIKd2WDmcnZyE4v4NffJ4zee9RlGcf45gqVatcjXx8H4rL
         O8oNja7BLu0gz/G1Fp/nxCseVANEloaxqKuwklcsJNUfrhzQmgKQ4+WbvxXhaGlK4wmG
         ExtkR1Rl54+PLjc3z7wlAe79bFkXe43omBGiPbkNK10wwDRs3HG14vRX3t722rf5LNtU
         +VP0G25Yt9mSi62hOPAaj28b4D81K0T+4hKZvZ6eVZhbYiqPYzS4zBMpB8vF5j03h1Qm
         oz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685474017; x=1688066017;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B+LD9VU/Kdgo99Hgebbbih6KGEIqzpFiVw8bD+mVg98=;
        b=GWv7AsmqxSuB36UEE1LYbpsBqmWxuge5Lht5SmcSMDBWzgSbM6hgtP3kX3gj3CKbC4
         pbmT10NutkruGykkOH26As07XmFnSvrJDxDgx9B1Q4Oitb+7mO2Xl1NbgsvSwkUkabS5
         IQFouk3z77FVSVeFviE14iOnQUOBuppyEVMBMuW/nilwOxCNSQAcz6DpVYip9x3M6RWI
         tcV7UwMmyztuEEiTZfrYIYzp9n5hMt5+7OEeOX5nv2GEcdVmxkiAjV4yfqwv0A082MBU
         VV0Zng7S9yqIu11XiUJaD0UrND7KgbPH1hkSZNl4uU7Nr/KefHjP4+W5GlLdSZs1vsK3
         66uQ==
X-Gm-Message-State: AC+VfDwGNz9acb264YIuLsyBqafh1aAgqMviA9Q5VMWjpY5eiWRIqUAm
        NePrVtYNdbtmEU3b26vkR4x0yQ==
X-Google-Smtp-Source: ACHHUZ7QBWewirSrycEWEJVRsLQoMA2UgFNuEz1+78/1sfi2S+QZYNu+vq68hA6FvT+e4kGu8uOeuw==
X-Received: by 2002:a05:620a:4895:b0:75b:23a0:de84 with SMTP id ea21-20020a05620a489500b0075b23a0de84mr3802410qkb.2.1685474017164;
        Tue, 30 May 2023 12:13:37 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id x12-20020a05620a14ac00b0075cc804ee88sm3032298qkj.30.2023.05.30.12.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 12:13:36 -0700 (PDT)
Date:   Tue, 30 May 2023 15:13:36 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
Message-ID: <20230530191336.GB101722@cmpxchg.org>
References: <20230530162153.836565-1-nphamcs@gmail.com>
 <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <20230530180038.GC97194@cmpxchg.org>
 <CAJD7tkYYQjumA6QPcrAv8c6YnqJfrDrMhPZzDSjAz2jv+uDvtg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkYYQjumA6QPcrAv8c6YnqJfrDrMhPZzDSjAz2jv+uDvtg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 11:41:32AM -0700, Yosry Ahmed wrote:
> On Tue, May 30, 2023 at 11:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, May 30, 2023 at 09:52:36AM -0700, Yosry Ahmed wrote:
> > > On Tue, May 30, 2023 at 9:22 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > >
> > > > Before storing a page, zswap first checks if the number of stored pages
> > > > exceeds the limit specified by memory.zswap.max, for each cgroup in the
> > > > hierarchy. If this limit is reached or exceeded, then zswap shrinking is
> > > > triggered and short-circuits the store attempt.
> > > >
> > > > However, if memory.zswap.max = 0 for a cgroup, no amount of writeback
> > > > will allow future store attempts from processes in this cgroup to
> > > > succeed. Furthermore, this create a pathological behavior in a system
> > > > where some cgroups have memory.zswap.max = 0 and some do not: the
> > > > processes in the former cgroups, under memory pressure, will evict pages
> > > > stored by the latter continually, until the need for swap ceases or the
> > > > pool becomes empty.
> > > >
> > > > As a result of this, we observe a disproportionate amount of zswap
> > > > writeback and a perpetually small zswap pool in our experiments, even
> > > > though the pool limit is never hit.
> > > >
> > > > This patch fixes the issue by rejecting zswap store attempt without
> > > > shrinking the pool when memory.zswap.max is 0.
> > > >
> > > > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > ---
> > > >  include/linux/memcontrol.h | 6 +++---
> > > >  mm/memcontrol.c            | 8 ++++----
> > > >  mm/zswap.c                 | 9 +++++++--
> > > >  3 files changed, 14 insertions(+), 9 deletions(-)
> > > >
> > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > > index 222d7370134c..507bed3a28b0 100644
> > > > --- a/include/linux/memcontrol.h
> > > > +++ b/include/linux/memcontrol.h
> > > > @@ -1899,13 +1899,13 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
> > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > >
> > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
> > > >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> > > >  #else
> > > > -static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > +static inline int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > >  {
> > > > -       return true;
> > > > +       return 0;
> > > >  }
> > > >  static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
> > > >                                            size_t size)
> > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > index 4b27e245a055..09aad0e6f2ea 100644
> > > > --- a/mm/memcontrol.c
> > > > +++ b/mm/memcontrol.c
> > > > @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] = {
> > > >   * spending cycles on compression when there is already no room left
> > > >   * or zswap is disabled altogether somewhere in the hierarchy.
> > > >   */
> > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > >  {
> > > >         struct mem_cgroup *memcg, *original_memcg;
> > > > -       bool ret = true;
> > > > +       int ret = 0;
> > > >
> > > >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > >                 return true;
> > > > @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > >                 if (max == PAGE_COUNTER_MAX)
> > > >                         continue;
> > > >                 if (max == 0) {
> > > > -                       ret = false;
> > > > +                       ret = -ENODEV;
> > > >                         break;
> > > >                 }
> > > >
> > > > @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > >                 pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
> > > >                 if (pages < max)
> > > >                         continue;
> > > > -               ret = false;
> > > > +               ret = -ENOMEM;
> > > >                 break;
> > > >         }
> > > >         mem_cgroup_put(original_memcg);
> > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > index 59da2a415fbb..7b13dc865438 100644
> > > > --- a/mm/zswap.c
> > > > +++ b/mm/zswap.c
> > > > @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> > > >         }
> > > >
> > > >         objcg = get_obj_cgroup_from_page(page);
> > > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > -               goto shrink;
> > > > +       if (objcg) {
> > > > +               ret = obj_cgroup_may_zswap(objcg);
> > > > +               if (ret == -ENODEV)
> > > > +                       goto reject;
> > > > +               if (ret == -ENOMEM)
> > > > +                       goto shrink;
> > > > +       }
> > >
> > > I wonder if we should just make this:
> > >
> > > if (objcg && !obj_cgroup_may_zswap(objcg))
> > >         goto reject;
> > >
> > > Even if memory.zswap.max is > 0, if the limit is hit, shrinking the
> > > zswap pool will only help if we happen to writeback a page from the
> > > same memcg that hit its limit. Keep in mind that we will only
> > > writeback one page every time we observe that the limit is hit (even
> > > with Domenico's patch, because zswap_can_accept() should be true).
> > >
> > > On a system with a handful of memcgs,
> > > it seems likely that we wrongfully writeback pages from other memcgs
> > > because of this. Achieving nothing for this memcg, while hurting
> > > others. OTOH, without invoking writeback when the limit is hit, the
> > > memcg will just not be able to use zswap until some pages are
> > > faulted back in or invalidated.
> > >
> > > I am not sure which is better, just thinking out loud.
> >
> > You're absolutely right.
> >
> > Currently the choice is writing back either everybody or nobody,
> > meaning between writeback and cgroup containment. They're both so poor
> > that I can't say I strongly prefer one over the other.
> >
> > However, I have a lame argument in favor of this patch:
> >
> > The last few fixes from Nhat and Domenico around writeback show that
> > few people, if anybody, are actually using writeback. So it might not
> > actually matter that much in practice which way we go with this patch.
> > Per-memcg LRUs will be necessary for it to work right.
> >
> > However, what Nhat is proposing is how we want the behavior down the
> > line. So between two equally poor choices, I figure we might as well
> > go with the one that doesn't require another code change later on.
> >
> > Doesn't that fill you with radiant enthusiasm?
> 
> If we have per-memcg LRUs, and memory.zswap.max == 0, then we should
> be in one of two situations:
> 
> (a) memory.zswap.max has always been 0, so the LRU for this memcg is
> empty, so we don't really need the special case for memory.zswap.max
> == 0.
> 
> (b) memory.zswap.max was reduced to 0 at some point, and some pages
> are already in zswap. In this case, I don't think shrinking the memcg
> is such a bad idea, we would be lazily enforcing the limit.
> 
> In that sense I am not sure that this change won't require another
> code change. It feels like special casing memory.zswap.max == 0 is
> only needed now due to the lack of per-memcg LRUs.

Good point. And I agree down the line we should just always send the
shrinker off optimistically on the cgroup's lru list.

So I take back my lame argument. But that then still leaves us with
the situation that both choices are equal here, right?

If so, my vote would be to go with the patch as-is.
