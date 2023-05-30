Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A9D716F4C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjE3U7u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbjE3U7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:59:48 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E11B107
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:59:42 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id d75a77b69052e-3f83114e0c6so17848571cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1685480381; x=1688072381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7eblH3QdRlICNFaCB+m62xz5shb1LJNMBbo87wL9f0M=;
        b=bD73S+5LUY83mZa0edlzw+q87HIkO5vf9WehMtJWC9PFfP0I/diLC1vBl9HDRie92h
         cBc9L9ZKojZ7FFAUvyk+aV/Ov4iNoFmy8C4NmwgfLiIIMgfXVf/ZMbRC1aIZ1QYm/GKx
         I87su7p19aUqhQoPLKQ3W09lzwa+byYrWgx+GGl8TH1yKLinNSv6A0YCxnHmOf0CCPUi
         WBpQSZ1HksNKZ6AvZE/tmdrwYzkZ4vSiE3HRoJJhryT26qRypgJ9gtSev5N1yZmtvHrM
         pfJGUzQ/2KqnXzZT+8/2KqCPovPV1B+1pSEZ1pjnR24NBI6Vr6sfLoRQ5xJ4GnI0UENo
         8Yyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685480381; x=1688072381;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7eblH3QdRlICNFaCB+m62xz5shb1LJNMBbo87wL9f0M=;
        b=P/OGqfq5sLrggM6GXYg/1MEdFV+aJ1daomc5T00hv9FhTOb9heGE1gM36oT1Si+Yz7
         ZZ3pAdfB5lLje0LE1SACvX5i7194bkvAZAmSPlZt0e4v300FZBlWZC72uvSUX76TnoPp
         TYLfGGk8hxW2ZGnWmxfAN+Q3xY8MgRYHoKLAQmoVOrxIbjtRU5putbf/DlB8jDDp5wyR
         H8SeqvGQgJPjtlm79SKcle3txk+oARJ2zuld74xP2X2SedRjNlhvV881PPxkaWIWbwpW
         XKjBlj+MTsoVndHSdYJK3D1EbMN2q+Ejtio6MszKP17oOpcTvqOCsLpwCd9SVERyv0+G
         l6IA==
X-Gm-Message-State: AC+VfDySJYD5Q4ZXCOMUsS4f4s+GSSC7giQVbWengnA5B19ooahw7QBG
        BQTwMsgn8msDBz+VFMjgM1sNrg==
X-Google-Smtp-Source: ACHHUZ6AQEP9JHBzG9mXbwzSBdS5kWqw3jmWZMI2lzZC8MfSEcnL4+MLvRjP0YxuvZvOLZZBbTNKEQ==
X-Received: by 2002:ac8:57ce:0:b0:3ef:28dc:fdd0 with SMTP id w14-20020ac857ce000000b003ef28dcfdd0mr3920666qta.44.1685480381364;
        Tue, 30 May 2023 13:59:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:8bb6])
        by smtp.gmail.com with ESMTPSA id y14-20020ac8524e000000b003e3914c6839sm5051821qtn.43.2023.05.30.13.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 13:59:41 -0700 (PDT)
Date:   Tue, 30 May 2023 16:59:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Nhat Pham <nphamcs@gmail.com>, akpm@linux-foundation.org,
        cerasuolodomenico@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sjenning@redhat.com,
        ddstreet@ieee.org, vitaly.wool@konsulko.com, kernel-team@meta.com
Subject: Re: [PATCH] zswap: do not shrink when memory.zswap.max is 0
Message-ID: <20230530205940.GA102494@cmpxchg.org>
References: <20230530162153.836565-1-nphamcs@gmail.com>
 <CAJD7tkZJttvpYs4mgjL3pt8-jkX0fnWRJP7hVBZmm=i_Ef3Abg@mail.gmail.com>
 <20230530180038.GC97194@cmpxchg.org>
 <CAJD7tkYYQjumA6QPcrAv8c6YnqJfrDrMhPZzDSjAz2jv+uDvtg@mail.gmail.com>
 <20230530191336.GB101722@cmpxchg.org>
 <CAJD7tkb8BbPZfDR5=3eMmJ4=7E52mPAafuzeytsnxunDQGyEmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJD7tkb8BbPZfDR5=3eMmJ4=7E52mPAafuzeytsnxunDQGyEmg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 01:19:12PM -0700, Yosry Ahmed wrote:
> On Tue, May 30, 2023 at 12:13 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> >
> > On Tue, May 30, 2023 at 11:41:32AM -0700, Yosry Ahmed wrote:
> > > On Tue, May 30, 2023 at 11:00 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Tue, May 30, 2023 at 09:52:36AM -0700, Yosry Ahmed wrote:
> > > > > On Tue, May 30, 2023 at 9:22 AM Nhat Pham <nphamcs@gmail.com> wrote:
> > > > > >
> > > > > > Before storing a page, zswap first checks if the number of stored pages
> > > > > > exceeds the limit specified by memory.zswap.max, for each cgroup in the
> > > > > > hierarchy. If this limit is reached or exceeded, then zswap shrinking is
> > > > > > triggered and short-circuits the store attempt.
> > > > > >
> > > > > > However, if memory.zswap.max = 0 for a cgroup, no amount of writeback
> > > > > > will allow future store attempts from processes in this cgroup to
> > > > > > succeed. Furthermore, this create a pathological behavior in a system
> > > > > > where some cgroups have memory.zswap.max = 0 and some do not: the
> > > > > > processes in the former cgroups, under memory pressure, will evict pages
> > > > > > stored by the latter continually, until the need for swap ceases or the
> > > > > > pool becomes empty.
> > > > > >
> > > > > > As a result of this, we observe a disproportionate amount of zswap
> > > > > > writeback and a perpetually small zswap pool in our experiments, even
> > > > > > though the pool limit is never hit.
> > > > > >
> > > > > > This patch fixes the issue by rejecting zswap store attempt without
> > > > > > shrinking the pool when memory.zswap.max is 0.
> > > > > >
> > > > > > Fixes: f4840ccfca25 ("zswap: memcg accounting")
> > > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > > ---
> > > > > >  include/linux/memcontrol.h | 6 +++---
> > > > > >  mm/memcontrol.c            | 8 ++++----
> > > > > >  mm/zswap.c                 | 9 +++++++--
> > > > > >  3 files changed, 14 insertions(+), 9 deletions(-)
> > > > > >
> > > > > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > > > > index 222d7370134c..507bed3a28b0 100644
> > > > > > --- a/include/linux/memcontrol.h
> > > > > > +++ b/include/linux/memcontrol.h
> > > > > > @@ -1899,13 +1899,13 @@ static inline void count_objcg_event(struct obj_cgroup *objcg,
> > > > > >  #endif /* CONFIG_MEMCG_KMEM */
> > > > > >
> > > > > >  #if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_ZSWAP)
> > > > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg);
> > > > > >  void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size);
> > > > > >  void obj_cgroup_uncharge_zswap(struct obj_cgroup *objcg, size_t size);
> > > > > >  #else
> > > > > > -static inline bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > > +static inline int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > >  {
> > > > > > -       return true;
> > > > > > +       return 0;
> > > > > >  }
> > > > > >  static inline void obj_cgroup_charge_zswap(struct obj_cgroup *objcg,
> > > > > >                                            size_t size)
> > > > > > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > > > > > index 4b27e245a055..09aad0e6f2ea 100644
> > > > > > --- a/mm/memcontrol.c
> > > > > > +++ b/mm/memcontrol.c
> > > > > > @@ -7783,10 +7783,10 @@ static struct cftype memsw_files[] = {
> > > > > >   * spending cycles on compression when there is already no room left
> > > > > >   * or zswap is disabled altogether somewhere in the hierarchy.
> > > > > >   */
> > > > > > -bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > > +int obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > >  {
> > > > > >         struct mem_cgroup *memcg, *original_memcg;
> > > > > > -       bool ret = true;
> > > > > > +       int ret = 0;
> > > > > >
> > > > > >         if (!cgroup_subsys_on_dfl(memory_cgrp_subsys))
> > > > > >                 return true;
> > > > > > @@ -7800,7 +7800,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > >                 if (max == PAGE_COUNTER_MAX)
> > > > > >                         continue;
> > > > > >                 if (max == 0) {
> > > > > > -                       ret = false;
> > > > > > +                       ret = -ENODEV;
> > > > > >                         break;
> > > > > >                 }
> > > > > >
> > > > > > @@ -7808,7 +7808,7 @@ bool obj_cgroup_may_zswap(struct obj_cgroup *objcg)
> > > > > >                 pages = memcg_page_state(memcg, MEMCG_ZSWAP_B) / PAGE_SIZE;
> > > > > >                 if (pages < max)
> > > > > >                         continue;
> > > > > > -               ret = false;
> > > > > > +               ret = -ENOMEM;
> > > > > >                 break;
> > > > > >         }
> > > > > >         mem_cgroup_put(original_memcg);
> > > > > > diff --git a/mm/zswap.c b/mm/zswap.c
> > > > > > index 59da2a415fbb..7b13dc865438 100644
> > > > > > --- a/mm/zswap.c
> > > > > > +++ b/mm/zswap.c
> > > > > > @@ -1175,8 +1175,13 @@ static int zswap_frontswap_store(unsigned type, pgoff_t offset,
> > > > > >         }
> > > > > >
> > > > > >         objcg = get_obj_cgroup_from_page(page);
> > > > > > -       if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > > > -               goto shrink;
> > > > > > +       if (objcg) {
> > > > > > +               ret = obj_cgroup_may_zswap(objcg);
> > > > > > +               if (ret == -ENODEV)
> > > > > > +                       goto reject;
> > > > > > +               if (ret == -ENOMEM)
> > > > > > +                       goto shrink;
> > > > > > +       }
> > > > >
> > > > > I wonder if we should just make this:
> > > > >
> > > > > if (objcg && !obj_cgroup_may_zswap(objcg))
> > > > >         goto reject;
> > > > >
> > > > > Even if memory.zswap.max is > 0, if the limit is hit, shrinking the
> > > > > zswap pool will only help if we happen to writeback a page from the
> > > > > same memcg that hit its limit. Keep in mind that we will only
> > > > > writeback one page every time we observe that the limit is hit (even
> > > > > with Domenico's patch, because zswap_can_accept() should be true).
> > > > >
> > > > > On a system with a handful of memcgs,
> > > > > it seems likely that we wrongfully writeback pages from other memcgs
> > > > > because of this. Achieving nothing for this memcg, while hurting
> > > > > others. OTOH, without invoking writeback when the limit is hit, the
> > > > > memcg will just not be able to use zswap until some pages are
> > > > > faulted back in or invalidated.
> > > > >
> > > > > I am not sure which is better, just thinking out loud.
> > > >
> > > > You're absolutely right.
> > > >
> > > > Currently the choice is writing back either everybody or nobody,
> > > > meaning between writeback and cgroup containment. They're both so poor
> > > > that I can't say I strongly prefer one over the other.
> > > >
> > > > However, I have a lame argument in favor of this patch:
> > > >
> > > > The last few fixes from Nhat and Domenico around writeback show that
> > > > few people, if anybody, are actually using writeback. So it might not
> > > > actually matter that much in practice which way we go with this patch.
> > > > Per-memcg LRUs will be necessary for it to work right.
> > > >
> > > > However, what Nhat is proposing is how we want the behavior down the
> > > > line. So between two equally poor choices, I figure we might as well
> > > > go with the one that doesn't require another code change later on.
> > > >
> > > > Doesn't that fill you with radiant enthusiasm?
> > >
> > > If we have per-memcg LRUs, and memory.zswap.max == 0, then we should
> > > be in one of two situations:
> > >
> > > (a) memory.zswap.max has always been 0, so the LRU for this memcg is
> > > empty, so we don't really need the special case for memory.zswap.max
> > > == 0.
> > >
> > > (b) memory.zswap.max was reduced to 0 at some point, and some pages
> > > are already in zswap. In this case, I don't think shrinking the memcg
> > > is such a bad idea, we would be lazily enforcing the limit.
> > >
> > > In that sense I am not sure that this change won't require another
> > > code change. It feels like special casing memory.zswap.max == 0 is
> > > only needed now due to the lack of per-memcg LRUs.
> >
> > Good point. And I agree down the line we should just always send the
> > shrinker off optimistically on the cgroup's lru list.
> >
> > So I take back my lame argument. But that then still leaves us with
> > the situation that both choices are equal here, right?
> >
> > If so, my vote would be to go with the patch as-is.
> 
> I *think* it's better to punish the memcg that exceeded its limit by
> not allowing it to use zswap until its usage goes down, rather than
> punish random memcgs on the machine because one memcg hit its limit.
> It also seems to me that on a system with a handful of memcgs, it is
> statistically more likely for zswap shrinking to writeback a page from
> the wrong memcg.

Right, but in either case a hybrid zswap + swap setup with cgroup
isolation is broken anyway. Without it being usable, I'm assuming
there are no users - maybe that's optimistic of me ;)

However, if you think it's better to just be conservative about taking
action in general, that's fine by me as well.

> The code would also be simpler if obj_cgroup_may_zswap() just returns
> a boolean and we do not shrink at all if it returns false. If it no
> longer returns a boolean we should at least rename it.
> 
> Did you try just not shrinking at all if the memcg limit is hit in
> your experiments?
> 
> I don't feel strongly, but my preference would be to just not shrink
> at all if obj_cgroup_may_zswap() returns false.

Sounds reasonable to me. Basically just replace the goto shrink with
goto reject for now. Maybe a comment that says "XXX: Writeback/reclaim
does not work with cgroups yet. Needs a cgroup-aware entry LRU first,
or we'd push out entries system-wide based on local cgroup limits."

Nhat, does that sound good to you?
