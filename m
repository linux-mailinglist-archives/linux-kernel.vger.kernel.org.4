Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875426DB27B
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 20:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDGSIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 14:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjDGSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 14:08:19 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53D3DAD12
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 11:08:18 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f04275b2bdso134895e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 11:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680890897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m3im81jdsus/Yk7rDAQ6nsUJCO1TAGpuJlX+PUtR7Vo=;
        b=BFLsqEfhJiKOQ9Fkb0uEY0bKk5LQ3O/Z5acnS9Gwe11T22vLKmD912M1G9fayPfFIH
         3/0AqtpNonm8XU0iAxH6wnQZR1Hff8nXXC7kYtaxP44vjxASjiFL/jOxpQRvq5qer4wP
         /Wklo8Qoocl4rdQG5Ui/i76rBmmXsyZDaASmyEO6ITb9LpMRRpGrai2Fd7+RfURug7hG
         4THnLsAqR9LILD3vO3U6MVNDR880as0IAGcHp6uDt5DG88u3DFQjQHjtSj96xxIG3ZKI
         H57WBUG4kWK7rFEto0jO0z5wCLj1x8eCps8nzqORjQJ//QTj2FdYTA3hMVn+9ortN1cX
         uoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680890897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m3im81jdsus/Yk7rDAQ6nsUJCO1TAGpuJlX+PUtR7Vo=;
        b=NJzGRyyydgThgFPJ6iQAlCIal44yWS3+m8aP3hOLaCYB5R9li80Ux1mcF1BqTAi00y
         T5Xv9/Lu7xjH87cWY4TfZekSG6sdmqJ0j58ZVZSEWBD6z/UHh1E1Lfdnh+n8K/S5HNrE
         X/zvHC8CmMIevfGGOv/uKIImpXLTgtzYj8HIw/PptgD4GvTMQI60g0LVTnndr3n3Pj88
         4tokupwJbE9NU7ZyLWZeW0wKTQwSSaJZFWA2XMfsFD04mwmqvRIxGsV7WlHjTX4cXdOA
         eiuU6yC1hJYuMYDMBeMR89DI2mzbbzAnrOZ7+iMeC2Lf5YaqJsNP/GKx9hL0AmqiZJVy
         wMkw==
X-Gm-Message-State: AAQBX9cxB+R38bhQW8AHrF1cumdzr1oq05ZTX848oKi+RbgNx4kKyLq5
        /DpxtrSs8O4Z+p0UjdzyEjbzJvrYBH6JJJeJu1xHaw==
X-Google-Smtp-Source: AKy350bj2LuHP6CSAaRSdFqFuxzZBOchnEQ15/j6t1PmhCJfRaf+gRVdZBcSdbFqsz2Oxz2EK9in4urxgaJb/hv+1Ho=
X-Received: by 2002:a05:600c:82c9:b0:3df:f3cb:e8ce with SMTP id
 eo9-20020a05600c82c900b003dff3cbe8cemr7124wmb.7.1680890896734; Fri, 07 Apr
 2023 11:08:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230405200150.GA35884@cmpxchg.org> <CAOUHufYCxdAXtw_b1qFT_02L3gWcs3of6Y0-5mmLwr+CeWvLQQ@mail.gmail.com>
 <20230406200213.GA50192@cmpxchg.org> <CAJD7tkaBHKvT2KDYg0x873mV6WW-Ky-HmQRKqc2qA4ir3nb=5g@mail.gmail.com>
In-Reply-To: <CAJD7tkaBHKvT2KDYg0x873mV6WW-Ky-HmQRKqc2qA4ir3nb=5g@mail.gmail.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Fri, 7 Apr 2023 12:07:39 -0600
Message-ID: <CAOUHufZEbXjYqqC2fGeCwEsM_tKV45M8dOy0MieESzELuYMqsA@mail.gmail.com>
Subject: Re: global_reclaim() and code documentation (was: Re: [PATCH v3 3/3]
 mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
To:     Yosry Ahmed <yosryahmed@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 7, 2023 at 12:03=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Thu, Apr 6, 2023 at 1:02=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.or=
g> wrote:
> >
> > On Wed, Apr 05, 2023 at 03:09:27PM -0600, Yu Zhao wrote:
> > > On Wed, Apr 5, 2023 at 2:01=E2=80=AFPM Johannes Weiner <hannes@cmpxch=
g.org> wrote:
> > > > static bool cgroup_reclaim(struct scan_control *sc)
> > > > {
> > > >         return sc->target_mem_cgroup;
> > > > }
> > > >
> > > > static bool global_reclaim(struct scan_control *sc)
> > > > {
> > > >         return !sc->target_mem_cgroup || mem_cgroup_is_root(sc->tar=
get_mem_cgroup);
> > > > }
> > > >
> > > > The name suggests it's the same thing twice, with opposite
> > > > polarity. But of course they're subtly different, and not documente=
d.
> > > >
> > > > When do you use which?
> > >
> > > The problem I saw is that target_mem_cgroup is set when writing to th=
e
> > > root memory.reclaim. And for this case, a few places might prefer
> > > global_reclaim(), e.g., in shrink_lruvec(), in addition to where it's
> > > being used.
> > >
> > > If this makes sense, we could 1) document it (or rename it) and apply
> > > it to those places, or 2) just unset target_mem_cgroup for root and
> > > delete global_reclaim(). Option 2 might break ABI but still be
> > > acceptable.
> >
> > Ah, cgroup_reclaim() tests whether it's limit/proactive reclaim or
> > allocator reclaim. global_reclaim() tests whether it's root reclaim
> > (which could be from either after memory.reclaim).
> >
> > I suppose we didn't clarify when introducing memory.reclaim what the
> > semantics should be on the root cgroup:
> >
> > - We currently exclude PGSCAN and PGSTEAL stats from /proc/vmstat for
> >   limit reclaim to tell cgroup constraints from physical pressure. We
> >   currently exclude root memory.reclaim activity as well. Seems okay.
> >
> > - The file_is_tiny heuristic is for allocator reclaim near OOM. It's
> >   currently excluded for root memory.reclaim, which seems okay too.
> >
> > - Like limit reclaim, root memory.reclaim currently NEVER swaps when
> >   global swappiness is 0. The whole cgroup-specific swappiness=3D0
> >   semantic is kind of quirky. But I suppose we can keep it as-is.
> >
> > - Proportional reclaim is disabled for everybody but direct reclaim
> >   from the allocator at initial priority. Effectively disabled for all
> >   situations where it might matter, including root memory.reclaim. We
> >   should also keep this as-is.
> >
> > - Writeback throttling is interesting. Historically, kswapd set the
> >   congestion state when running into lots of PG_reclaim pages, and
> >   clear it when the node is balanced. This throttles direct reclaim.
> >
> >   Cgroup limit reclaim would set and clear congestion on non-root only
> >   to do local limit-reclaim throttling. But now root memory.reclaim
> >   might clear a bit set by kswapd before the node is balanced, and
> >   release direct reclaimers from throttling prematurely. This seems
> >   wrong. However, the alternative is throttling memory.reclaim on
> >   subgroup congestion but not root, which seems also wrong.
> >
> > - Root memory.reclaim is exempted from the compaction_ready() bail
> >   condition as well as soft limit reclaim. But they'd both be no-ops
> >   anyway if we changed cgroup_reclaim() semantics.
> >
> > IMO we should either figure out what we want to do in those cases
> > above, at least for writeback throttling.
> >
> > Are you guys using root-level proactive reclaim?
> >
> > > If we don't want to decide right now, I can rename global_reclaim() t=
o
> > > root_reclaim() and move it within #ifdef CONFIG_LRU_GEN and probably
> > > come back and revisit later.
> >
> > So conventional vmscan treats root-level memory.reclaim the same as
> > any other cgroup reclaim. And the cgroup_reclaim() checks are mostly
> > reserved for (questionable) allocator reclaim-specific heuristics.
> >
> > Is there a chance lrugen could do the same, and you'd be fine with
> > using cgroup_reclaim()? Or is it a data structure problem?
> >
> > If so, I agree it could be better to move it to CONFIG_LRU_GEN and
> > rename it for the time being. root_reclaim() SGTM.
>
> Oh and if we decide to keep the helper as root_reclaim I would prefer
> it to be outside CONFIG_LRU_GEN so that I can still use it in the
> patch series that this thread was originally a part of (ignoring
> non-LRU freed pages in memcg reclaim).

Thanks for the summaries. I think you both covered all the important detail=
s.

Just to recap -- it all comes down to how we want to define the
semantics for the root memory.reclaim for *future* use case, since
currently it has no known users (I personally use it for testing
purposes, which is not important at all). So I'm fine with whatever
you two see fit (delete, refactor or rename).
