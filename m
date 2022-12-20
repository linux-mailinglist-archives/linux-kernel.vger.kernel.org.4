Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC30652A10
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 00:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234005AbiLTX4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 18:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiLTX4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 18:56:48 -0500
Received: from out-204.mta0.migadu.com (out-204.mta0.migadu.com [IPv6:2001:41d0:1004:224b::cc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194071CB24
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 15:56:46 -0800 (PST)
Date:   Tue, 20 Dec 2022 15:56:37 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671580602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pzTn8ur1XtUN2Eo2Nx2CrqTa1RIIIWnV7wMZmTTSeVA=;
        b=hsswEVk0//IyZFc2+E1WqZAHxe0CFtd4/DVo+x3UvNn/+X9mxF5n56d2exL+WLYeNkoin4
        RV2YPPvXag2wbDau0BBIZQAVrRT6bPBeabW/xRTj4cmq2EguhpTRKggNZhdUfVWd8erRnf
        dyDxVHaidT492nQGMk1Ux/lVIr0RqRI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Sven Luther <Sven.Luther@windriver.com>
Subject: Re: [PATCH RFC] ipc/mqueue: introduce msg cache
Message-ID: <Y6JLtVFkJ9+wlMfa@P9FQF9L96D.corp.robot.car>
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
 <CALvZod7WNxj0vdfiEad_xfBACsJu3iA0nF25m4VN3M=yLF4igg@mail.gmail.com>
 <Y6IiPCg7c1A5fhsC@P9FQF9L96D.corp.robot.car>
 <CALvZod7q1jcpVyFUSzfL8-mSFa24peqrKDmqnMLwNe2=dNEpaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7q1jcpVyFUSzfL8-mSFa24peqrKDmqnMLwNe2=dNEpaw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 03:28:11PM -0800, Shakeel Butt wrote:
> On Tue, Dec 20, 2022 at 12:59 PM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
> >
> > On Tue, Dec 20, 2022 at 11:53:25AM -0800, Shakeel Butt wrote:
> > > +Vlastimil
> > >
> > > On Tue, Dec 20, 2022 at 10:48 AM Roman Gushchin
> > > <roman.gushchin@linux.dev> wrote:
> > > >
> > > > Sven Luther reported a regression in the posix message queues
> > > > performance caused by switching to the per-object tracking of
> > > > slab objects introduced by patch series ending with the
> > > > commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
> > > > allocations").
> > > >
> > > > To mitigate the regression cache allocated mqueue messages on a small
> > > > percpu cache instead of releasing and re-allocating them every time.
> > > >
> > >
> > > Seems fine with me but I am wondering what is stopping us to do this
> > > caching in the slab layer for all accounted allocations? Does this
> > > only make sense for specific scenarios/use-cases?
> >
> > It's far from trivial, unfortunately. Here we have an mqueue object to associate
> > a percpu cache with and the hit rate is expected to be high, assuming the mqueue
> > will be used to pass a lot of messages.
> >
> > With a generic slab cache we return to the necessity of managing
> > the per-cgroup x per-slab-cache x per-cpu free list (or some other data structure),
> > which is already far from trivial, based on the previous experience. It can
> > easily lead to a significant memory waste, which will fully compensate all perf
> > wins.
> >
> > So probably we need some heuristics to allocate caches only for really hot slab
> > caches and use some sort of a hash map (keyed by cgroup and slab cache) to
> > access freelists. What I miss to commit more time to this project (aside from not
> > having it), is the lack of real workloads which will noticeably win from this work.
> >
> > Sven provided a good example and benchmark to reproduce the regression, so it
> > was easy to justify the work.
> >
> 
> Thanks for the explanation. I think we should add this to the commit
> message as well. I do think we should have a general framework for
> such caching as there are other users (e.g. io_uring) doing the same
> and some future users can take advantage as well e.g. I think this
> type of caching will be helpful for filelock_cache as well. Anyways
> that can be done in future.

I agree.

One way I'm thinking about is to provide an API for creating objcg-specific slab
caches. All objects belonging to a such slab cache will belong to the same objcg.
In this case the accounting can be even faster than the previous per-page
accounting. And the user of such API will be responsible for the lifetime
of the cache, as well as the decision whether to use the local or global
slab cache.

Thanks!
