Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 094FD610335
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 22:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbiJ0UsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 16:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237029AbiJ0UrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 16:47:03 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944A695257
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:44:17 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id z6so2181123qtv.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Oct 2022 13:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ulcc/AJ049BpMMrRt+IjtDTgmB3Jy0kl9mqytJzZu2I=;
        b=gd+iRB3s3OpD4q1VTUBUn0yik01en9MbCgSx4rY1JW6h6pZ9KTBxMNJgZVWFX4Qvws
         7kVOG6pyg8LXUfa9SZ5if5sZqlIoyd5vOXwKKpm0JQzZpwSRfbhcrD5A6CwO+eULNgVG
         OaVMvSgx9a6Liw9VdBjVOR1x2N22GOcHRoDgqaz0c9ff+jLUG+JFYbJSbuiZ+5SmyBDV
         G79hQ89rGfUpFxSBBJ3sD77HNzylerr1eVDCbjbNFCW2fLbcVhGTdEBLQpHSev9ebF/B
         qTyDNMkMYu/QlCtJS4B5QsW9eO6ywXkZInvgzrczDdZ5lSViptI0XaFghEZqe4hs09Zr
         DgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulcc/AJ049BpMMrRt+IjtDTgmB3Jy0kl9mqytJzZu2I=;
        b=xVPivh8++OUlfDtzgqeNEcqj8xZfDu6q2nJJF/HCSlMreVs4I4OTrbvAn/t5Ytq8S2
         ecGD1ytrwV2RIJg2xpNvzcx+4KosFAHsEYPq+GcjulFi9F3VzEBoQbc6hyvrV6ThM0rV
         N88A6s4NVmddklA5XKy1Qdc3+GcapoBrsRD9tO62JTQKNa3oQnQlctxA/Ubh9lyiIbN2
         zfGthLYdoXsWi7ORklsyTBlQLemPJm1nWHPuk0PgkVy2PIKjBSoPm66afdpn83JFCRZV
         Jos2fQmVQv4eo8Jj7IpTsB+Jm68A0fGE4sswJfqApeY2Hoh/paqHStxDOQ4aalsPgtbl
         eAbw==
X-Gm-Message-State: ACrzQf11oLQcLh+KHVYNTaUmJ3nHenOAmzeWezlAkZGvlyvh2hGyliLG
        1OPJtfwUjsjiwFb6q9/nkHuwkFJSMgvyc98k21hSoxvNR+k=
X-Google-Smtp-Source: AMsMyM4WtWoB+/moPScQEDgqsCBs/MGAig+9/tpQ+o1p8oelkNPdoU3RHWAkVz/1Xmk3KvQo0dcR66X7AASfFM88yYg=
X-Received: by 2002:a05:6638:1450:b0:363:7052:9c30 with SMTP id
 l16-20020a056638145000b0036370529c30mr32154513jad.53.1666903446611; Thu, 27
 Oct 2022 13:44:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221025170519.314511-1-hannes@cmpxchg.org> <CAHbLzkoXzbHRJxb9DkjGkKQ8TAO08ctvz7wvjyPA8Gy2Skm+2g@mail.gmail.com>
 <Y1hM6sMRpBGUPRyo@cmpxchg.org> <CAHbLzkpaoN37camSLYVDU7p9AXzQjYcvHnWm3K87iwae-YyZiQ@mail.gmail.com>
 <Y1lvJBnVx1Fv5WHz@cmpxchg.org> <CAHbLzkqQ=6U3uerEkypsCHnmsXerEZi5erMSYK-kp8-vJNk89Q@mail.gmail.com>
 <CAJD7tkb5y9oqgVauVPiS0KbiL2Wnsu7jhK7Q44oUBZzBXwKUYA@mail.gmail.com> <Y1qSZHK/U0SpNqNa@cmpxchg.org>
In-Reply-To: <Y1qSZHK/U0SpNqNa@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 27 Oct 2022 13:43:24 -0700
Message-ID: <CAJD7tkYt-KL=jDEy6pSOc5tDij=3SWmbhFeco39pjJuOmEAH0g@mail.gmail.com>
Subject: Re: [PATCH] mm: vmscan: split khugepaged stats from direct reclaim stats
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yang Shi <shy828301@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Eric Bergen <ebergen@meta.com>
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

On Thu, Oct 27, 2022 at 7:15 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
>
> On Wed, Oct 26, 2022 at 07:41:21PM -0700, Yosry Ahmed wrote:
> > On Wed, Oct 26, 2022 at 1:51 PM Yang Shi <shy828301@gmail.com> wrote:
> > >
> > > On Wed, Oct 26, 2022 at 10:32 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > >
> > > > On Tue, Oct 25, 2022 at 02:53:01PM -0700, Yang Shi wrote:
> > > > > On Tue, Oct 25, 2022 at 1:54 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > >
> > > > > > On Tue, Oct 25, 2022 at 12:40:15PM -0700, Yang Shi wrote:
> > > > > > > On Tue, Oct 25, 2022 at 10:05 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > > > > > > >
> > > > > > > > Direct reclaim stats are useful for identifying a potential source for
> > > > > > > > application latency, as well as spotting issues with kswapd. However,
> > > > > > > > khugepaged currently distorts the picture: as a kernel thread it
> > > > > > > > doesn't impose allocation latencies on userspace, and it explicitly
> > > > > > > > opts out of kswapd reclaim. Its activity showing up in the direct
> > > > > > > > reclaim stats is misleading. Counting it as kswapd reclaim could also
> > > > > > > > cause confusion when trying to understand actual kswapd behavior.
> > > > > > > >
> > > > > > > > Break out khugepaged from the direct reclaim counters into new
> > > > > > > > pgsteal_khugepaged, pgdemote_khugepaged, pgscan_khugepaged counters.
> > > > > > > >
> > > > > > > > Test with a huge executable (CONFIG_READ_ONLY_THP_FOR_FS):
> > > > > > > >
> > > > > > > > pgsteal_kswapd 1342185
> > > > > > > > pgsteal_direct 0
> > > > > > > > pgsteal_khugepaged 3623
> > > > > > > > pgscan_kswapd 1345025
> > > > > > > > pgscan_direct 0
> > > > > > > > pgscan_khugepaged 3623
> > > > > > >
> > > > > > > There are other kernel threads or works may allocate memory then
> > > > > > > trigger memory reclaim, there may be similar problems for them and
> > > > > > > someone may try to add a new stat. So how's about we make the stats
> > > > > > > more general, for example, call it "pg{steal|scan}_kthread"?
> > > > > >
> > > > > > I'm not convinved that's a good idea.
> > > > > >
> > > > > > Can you generally say that userspace isn't indirectly waiting for one
> > > > > > of those allocating threads? With khugepaged, we know.
> > > > >
> > > > > AFAIK, ksm may do slab allocation with __GFP_DIRECT_RECLAIM.
> > > >
> > > > Right, but ksm also uses __GFP_KSWAPD_RECLAIM. So while userspace
> > > > isn't directly waiting for ksm, when ksm enters direct reclaim it's
> > > > because kswapd failed. This is of interest to kernel developers.
> > > > Userspace will likely see direct reclaim in that scenario as well, so
> > > > the ksm direct reclaim counts aren't liable to confuse users.
> > > >
> > > > Khugepaged on the other hand will *always* reclaim directly, even if
> > > > there is no memory pressure or kswapd failure. The direct reclaim
> > > > counts there are misleading to both developers and users.
> > > >
> > > > What it really should be is pgscan_nokswapd_nouserprocesswaiting, but
> > > > that just seems kind of long ;-)
> > > >
> > > > I'm also not sure anybody but khugepaged is doing direct reclaim
> > > > without kswapd reclaim. It seems unlikely we'll get more of those.
> > >
> > > IIUC you actually don't care about how many direct reclaim are
> > > triggered by khugepaged, but you would like to separate the direct
> > > reclaim stats between that are triggered directly by userspace
> > > actions, which may stall userspace, and that aren't, which don't stall
> > > userspace. If so it doesn't sound that important to distinguish
> > > whether the direct reclaim are triggered by khugepaged or other kernel
> > > threads even though other kthreads are not liable to confuse users
> > > IMHO.
>
> I feel like I've sufficiently explained my reason for wanting to
> separate out the __GFP_KSWAPD_RECLAIM special case from other sites.
>
> > My 2c, if we care about direct reclaim as in reclaim that may stall
> > user space application allocations, then there are other reclaim
> > contexts that may pollute the direct reclaim stats. For instance,
> > proactive reclaim, or reclaim done by writing a limit lower than the
> > current usage to memory.max or memory.high, as they are not done in
> > the context of the application allocating memory.
> >
> > At Google, we have some internal direct reclaim memcg statistics, and
> > the way we handle this is by passing a flag from such contexts to
> > try_to_free_mem_cgroup_pages() in the reclaim_options arg. This flag
> > is echod into a scan_struct bit, which we then use to filter out
> > direct reclaim operations that actually cause latencies in user space
> > allocations.
> >
> > Perhaps something similar might be more generic here? I am not sure
> > what context khugepaged reclaims memory from, but I think it's not a
> > memcg context, so maybe we want to generalize the reclaim_options arg
> > to try_to_free_pages() or whatever interface khugepaged uses to free
> > memory.
>
> So at the /proc/vmstat level, I'm not sure it matters much because it
> doesn't count any cgroup_reclaim() activity.
>
> But at the cgroup level, it sure would be nice to split out proactive
> reclaim churn. Both in terms of not polluting direct reclaim counts,
> but also for *knowing* how much proactive reclaim is doing.
>
> Do you have separate counters for this?

Not yet. Currently we only have the first part, not polluting direct
reclaim counts.

We basically exclude reclaim coming from memory.reclaim, setting
memory.max/memory.limit_in_bytes, memory.high (on write, not hitting
the high limit), and memory.force_empty from direct reclaim stats.

As for having a separate counter for proactive reclaim, do you think
it should be limited to reclaim coming from memory.reclaim (and
potentially memory.force_empty), or should it include reclaim coming
from limit-setting as well?
