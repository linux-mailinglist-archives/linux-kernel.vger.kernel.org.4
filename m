Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62BCA716BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 20:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231584AbjE3SAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 14:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjE3SAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 14:00:43 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6898F
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:00:40 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id af79cd13be357-75b04e897a5so559770385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 11:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685469640; x=1688061640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PAUyTlmfG/NzX286qOIA+d3/9/hv10y02ntNbNbWsp4=;
        b=pTeq3T/4iDaD4Y9y+5ezzfuqyD0HTP7mGhC5QChKZkokZiuyTtu1LVTFVfpKdS/Cr1
         7aJMmbRk3Gfdn+Eb1o5x2eS1awpUya8omy+sUVHnqXmVFc/icBn4SFzp4gXAXCo3CHZ/
         Dw45ok7bly0/CjSkZ3Ocr5oMDNsmyKXJ5vCQ8HnAvCnN8q1DXCjTIPreVSFAmNOgbO7Y
         pHSe3zzsVx1zQuxPaAJ8LJy0S9XEQ53iq5UJox1q4PeyAbDqnWr+DdJKfiDz77yHXGTd
         zZRwgKmwNHl9sboYZb4o4JW0jQoXetpqh7TlxpKRajUmAZZOXTboSDsw1tH8ZXhRPqKc
         3HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685469640; x=1688061640;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PAUyTlmfG/NzX286qOIA+d3/9/hv10y02ntNbNbWsp4=;
        b=Sb2tKQqgQzbqg6OQL9nyQdVixWVbmqS4Br9xy27HF3g2KiwQ9CwwTn2nRHcbmrpgzY
         5hYEwfdL+0gYcanqqdDrwLH9iLcIqMUT+/MJXiguYeKoBIYOIA3wdgfJkmHI+eZhttW4
         ASURLaEE2omwmHIBA5SsGgN9uIzlkLq/1ZCCL2+uHahx30J1HBWEtVAasSFIqu/mh4gq
         FezUkmO/DkV8nWC9gmn+M/02ErLVoE1caYBYgtGbbpQDwAOPdjlzZRal8cc7xux6FJ04
         n4SZHcsKkIzodi7VVp4SPCRzQkw3vmSgxQSt1LMpMao/fJmKZ2Wu0VyNLZ5mHvqAg6wv
         PbVw==
X-Gm-Message-State: AC+VfDzimEPG3ZX34Ijs1DHNawimyAeDJnAyA0CT/HzzGTE/M2eULBEt
        eu16eJcWp+MnIrpTtYZ6az+/qg==
X-Google-Smtp-Source: ACHHUZ4/1Ch0kmW0T32jslFZ93sjg8hICoOeOzr0XBJfwVod7NFxrp4gExjPHSBPH/93NCLvZBH7lw==
X-Received: by 2002:a05:6214:c4a:b0:625:aa49:9abc with SMTP id r10-20020a0562140c4a00b00625aa499abcmr3568464qvj.64.1685469639781;
        Tue, 30 May 2023 11:00:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id et18-20020a056214177200b006212456fd8asm4739509qvb.100.2023.05.30.11.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 11:00:39 -0700 (PDT)
Date:   Tue, 30 May 2023 14:00:38 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
Message-ID: <20230530180038.GC97194@cmpxchg.org>
References: <20230530162153.836565-1-nphamcs@gmail.com>
 <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 09:52:36AM -0700, Yosry Ahmed wrote:
> On Tue, May 30, 2023 at 9:22 AM Nhat Pham <nphamcs@gmail.com> wrote:
> >
> > Before storing a page, zswap first checks if the number of stored pages
> > exceeds the limit specified by memory.zswap.max, for each cgroup in the
> > hierarchy. If this limit is reached or exceeded, then zswap shrinking is
> > triggered and short-circuits the store attempt.
> >
> > However, if memory.zswap.max = 0 for a cgroup, no amount of writeback
> > will allow future store attempts from processes in this cgroup to
> > succeed. Furthermore, this create a pathological behavior in a system
> > where some cgroups have memory.zswap.max = 0 and some do not: the
> > processes in the former cgroups, under memory pressure, will evict pages
> > stored by the latter continually, until the need for swap ceases or the
> > pool becomes empty.
> >
> > As a result of this, we observe a disproportionate amount of zswap
> > writeback and a perpetually small zswap pool in our experiments, even
> > though the pool limit is never hit.
> >
> > This patch fixes the issue by rejecting zswap store attempt without
> > shrinking the pool when memory.zswap.max is 0.
> >
> > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > ---
> >  include/linux/memcontrol.h | 6 +++---
> >  mm/memcontrol.c            | 8 ++++----
> >  mm/zswap.c                 | 9 +++++++--
> >  3 files changed, 14 insertions(+), 9 deletions(-)
> >
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index 222d7370134c..507bed3a28b0 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -1899,13 +1899,13 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
> >  #endif /* CONFIG_MEMCG_KMEM */
> >
> >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
> >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> >  #else
> > -static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > +static inline int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> >  {
> > -       return true;
> > +       return 0;
> >  }
> >  static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
> >                                            size_t size)
> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index 4b27e245a055..09aad0e6f2ea 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] = {
> >   * spending cycles on compression when there is already no room left
> >   * or zswap is disabled altogether somewhere in the hierarchy.
> >   */
> > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> >  {
> >         struct mem_cgroup *memcg, *original_memcg;
> > -       bool ret = true;
> > +       int ret = 0;
> >
> >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> >                 return true;
> > @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> >                 if (max == PAGE_COUNTER_MAX)
> >                         continue;
> >                 if (max == 0) {
> > -                       ret = false;
> > +                       ret = -ENODEV;
> >                         break;
> >                 }
> >
> > @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> >                 pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
> >                 if (pages < max)
> >                         continue;
> > -               ret = false;
> > +               ret = -ENOMEM;
> >                 break;
> >         }
> >         mem_cgroup_put(original_memcg);
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 59da2a415fbb..7b13dc865438 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> >         }
> >
> >         objcg = get_obj_cgroup_from_page(page);
> > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > -               goto shrink;
> > +       if (objcg) {
> > +               ret = obj_cgroup_may_zswap(objcg);
> > +               if (ret == -ENODEV)
> > +                       goto reject;
> > +               if (ret == -ENOMEM)
> > +                       goto shrink;
> > +       }
> 
> I wonder if we should just make this:
> 
> if (objcg && !obj_cgroup_may_zswap(objcg))
>         goto reject;
> 
> Even if memory.zswap.max is > 0, if the limit is hit, shrinking the
> zswap pool will only help if we happen to writeback a page from the
> same memcg that hit its limit. Keep in mind that we will only
> writeback one page every time we observe that the limit is hit (even
> with Domenico's patch, because zswap_can_accept() should be true).
> 
> On a system with a handful of memcgs,
> it seems likely that we wrongfully writeback pages from other memcgs
> because of this. Achieving nothing for this memcg, while hurting
> others. OTOH, without invoking writeback when the limit is hit, the
> memcg will just not be able to use zswap until some pages are
> faulted back in or invalidated.
> 
> I am not sure which is better, just thinking out loud.

You're absolutely right.

Currently the choice is writing back either everybody or nobody,
meaning between writeback and cgroup containment. They're both so poor
that I can't say I strongly prefer one over the other.

However, I have a lame argument in favor of this patch:

The last few fixes from Nhat and Domenico around writeback show that
few people, if anybody, are actually using writeback. So it might not
actually matter that much in practice which way we go with this patch.
Per-memcg LRUs will be necessary for it to work right.

However, what Nhat is proposing is how we want the behavior down the
line. So between two equally poor choices, I figure we might as well
go with the one that doesn't require another code change later on.

Doesn't that fill you with radiant enthusiasm?

> Seems like this can be solved by having per-memcg LRUs, or at least
> providing an argument to the shrinker of which memcg to reclaim from.
> This would only be possible when the LRU is moved to zswap.

+1
