Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D152652826
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Dec 2022 22:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234340AbiLTU7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Dec 2022 15:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbiLTU7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Dec 2022 15:59:49 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC565592
        for <linux-kernel@vger.kernel.org>; Tue, 20 Dec 2022 12:59:46 -0800 (PST)
Date:   Tue, 20 Dec 2022 12:59:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1671569984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Y37zBw2z34AekRtu6QE+ZHXpaydFvXhSYB4OwYr6Iew=;
        b=k2tEgNCeJh1eRpPJ92swxPAVLxAUrukjoi5xvKpU7tyQKrSgio9+6kQaTDBhZn2wjzF03T
        laGIVhKyL9PhsRhc8uTgtEG+aRnANgJE0Rdz/aGTKAp3GeL8i+VdmfooHGoTAvO8nIPERh
        X7XL41kR1leDKMbChd4CqsUnhf5Rtvc=
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
Message-ID: <Y6IiPCg7c1A5fhsC@P9FQF9L96D.corp.robot.car>
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
 <CALvZod7WNxj0vdfiEad_xfBACsJu3iA0nF25m4VN3M=yLF4igg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod7WNxj0vdfiEad_xfBACsJu3iA0nF25m4VN3M=yLF4igg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2022 at 11:53:25AM -0800, Shakeel Butt wrote:
> +Vlastimil
> 
> On Tue, Dec 20, 2022 at 10:48 AM Roman Gushchin
> <roman.gushchin@linux.dev> wrote:
> >
> > Sven Luther reported a regression in the posix message queues
> > performance caused by switching to the per-object tracking of
> > slab objects introduced by patch series ending with the
> > commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
> > allocations").
> >
> > To mitigate the regression cache allocated mqueue messages on a small
> > percpu cache instead of releasing and re-allocating them every time.
> >
> 
> Seems fine with me but I am wondering what is stopping us to do this
> caching in the slab layer for all accounted allocations? Does this
> only make sense for specific scenarios/use-cases?

It's far from trivial, unfortunately. Here we have an mqueue object to associate
a percpu cache with and the hit rate is expected to be high, assuming the mqueue
will be used to pass a lot of messages.

With a generic slab cache we return to the necessity of managing
the per-cgroup x per-slab-cache x per-cpu free list (or some other data structure),
which is already far from trivial, based on the previous experience. It can
easily lead to a significant memory waste, which will fully compensate all perf
wins.

So probably we need some heuristics to allocate caches only for really hot slab
caches and use some sort of a hash map (keyed by cgroup and slab cache) to
access freelists. What I miss to commit more time to this project (aside from not
having it), is the lack of real workloads which will noticeably win from this work.

Sven provided a good example and benchmark to reproduce the regression, so it
was easy to justify the work.

Thanks!
