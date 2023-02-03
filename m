Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C3688BA8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 01:18:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbjBCASB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 19:18:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjBCAR6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 19:17:58 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB58370D7C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 16:17:56 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id me3so10963694ejb.7
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 16:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Gvjb/kvo7fCoN85bw+5nzURWfMKdctybB/MUXhN2Mx4=;
        b=FW+10UD/mNjFijhIrv0EkmQs9t0hjFKFhdZc6O870pN25h6ox7G+kkL0QpkifSnHBl
         rRfqCchBWnoCfiHoct9Vgxwnn89wAdAk9xQ048/Ibct8oEE8bUkzkE7WV5SASO75kF5Q
         yJYaQBGCOu4jP1jSIkcou016sSn+RHGbPKAj9z6ZSWmyxRExoXXiqdFhkdvRqSiBvX+s
         5vQaERznDOiU3TAMjy+0TMFX2aqhizASnZpLkO5alA5pD3rmjsCVO/Lw/9Nrd3Sn0Jd/
         FgGlTaiVEb/h3t0u38yW9Rr3nGYMbaPXm5iUj4SiuusluaoS89lauwHZs2Bd/vf0/RM/
         TdeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gvjb/kvo7fCoN85bw+5nzURWfMKdctybB/MUXhN2Mx4=;
        b=yP+BuGRgF/fT0BGOV2aRSG125DOMcnpmM+bbudyuHEl1duf5hh4+aDVJhYRiRo2+NG
         jJwmOocLxqGfFge+m45BEfVc6KR8H1D+aVTUtX59DErrLt4pq3XyOk5+5ZMfzQLdIWU2
         Sy9N4XjCUIAT0o8YWyN2aMSJcz68MH/WsFK2e3ghuwDrhwnJhKpDzSNjHgp7EoQrSEhC
         bwy5l5qc7gRzL5Em7u/S5uRrtq8apIr/7AvS7ze645iaWQgfMWGXXnwM2zkmrjKxOXLO
         4KbgvGINqd1lzYJB0TmN79xENMGgYlmKdKbwO+75SIsAmMng6LqDWDPaSgW79IxzXIAQ
         UrLA==
X-Gm-Message-State: AO0yUKVBgJ3PzXLS/fClH29AlvAk+AUDBaru7ywp/6WZQFCv6HxW8leq
        N4QLq3f6S1yn/T2sT4zpXPPNPl+l9C3rlDJagxJaTg==
X-Google-Smtp-Source: AK7set8m225eOYBxc0zjAdcFvUV/434ojhFbR0va4I5VIxpiH5PfOIbwh8kHwusjTHne2sUt2DV1VaEXpcy7xKXbS8I=
X-Received: by 2002:a17:906:c319:b0:878:7bc7:958a with SMTP id
 s25-20020a170906c31900b008787bc7958amr2432774ejz.220.1675383475017; Thu, 02
 Feb 2023 16:17:55 -0800 (PST)
MIME-Version: 1.0
References: <20230202233229.3895713-1-yosryahmed@google.com> <20230203000057.GS360264@dread.disaster.area>
In-Reply-To: <20230203000057.GS360264@dread.disaster.area>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 2 Feb 2023 16:17:18 -0800
Message-ID: <CAJD7tkazLFO8sc1Ly7+2_SGTxDq2XuPnvxxTnpQyXQELmq+m4A@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/2] Ignore non-LRU-based reclaim in memcg reclaim
To:     Dave Chinner <david@fromorbit.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Peter Xu <peterx@redhat.com>, NeilBrown <neilb@suse.de>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org
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

On Thu, Feb 2, 2023 at 4:01 PM Dave Chinner <david@fromorbit.com> wrote:
>
> On Thu, Feb 02, 2023 at 11:32:27PM +0000, Yosry Ahmed wrote:
> > Reclaimed pages through other means than LRU-based reclaim are tracked
> > through reclaim_state in struct scan_control, which is stashed in
> > current task_struct. These pages are added to the number of reclaimed
> > pages through LRUs. For memcg reclaim, these pages generally cannot be
> > linked to the memcg under reclaim and can cause an overestimated count
> > of reclaimed pages. This short series tries to address that.
>
> Can you explain why memcg specific reclaim is calling shrinkers that
> are not marked with SHRINKER_MEMCG_AWARE?
>
> i.e. only objects that are directly associated with memcg aware
> shrinkers should be accounted to the memcg, right? If the cache is
> global (e.g the xfs buffer cache) then they aren't marked with
> SHRINKER_MEMCG_AWARE and so should only be called for root memcg
> (i.e. global) reclaim contexts.
>
> So if you are having accounting problems caused by memcg specific
> reclaim on global caches freeing non-memcg accounted memory, isn't
> the problem the way the shrinkers are being called?

Not necessarily, according to my understanding.

My understanding is that we will only free slab objects accounted to
the memcg under reclaim (or one of its descendants), because we call
memcg aware shrinkers, as you pointed out. The point here is slab page
sharing. Ever since we started doing per-object accounting, a slab
page may have objects accounted to different memcgs. IIUC, if we free
a slab object charged to the memcg under reclaim, and this object
happened to be the last object on the page, we will free the slab
page, and count the entire page as reclaimed memory for the purpose of
memcg reclaim, which is where the inaccuracy is coming from.

Please correct me if I am wrong.

>
> > Patch 1 is just refactoring updating reclaim_state into a helper
> > function, and renames reclaimed_slab to just reclaimed, with a comment
> > describing its true purpose.
> >
> > Patch 2 ignores pages reclaimed outside of LRU reclaim in memcg reclaim.
> >
> > The original draft was a little bit different. It also kept track of
> > uncharged objcg pages, and reported them only in memcg reclaim and only
> > if the uncharged memcg is in the subtree of the memcg under reclaim.
> > This was an attempt to make reporting of memcg reclaim even more
> > accurate, but was dropped due to questionable complexity vs benefit
> > tradeoff. It can be revived if there is interest.
> >
> > Yosry Ahmed (2):
> >   mm: vmscan: refactor updating reclaimed pages in reclaim_state
> >   mm: vmscan: ignore non-LRU-based reclaim in memcg reclaim
> >
> >  fs/inode.c           |  3 +--
>
> Inodes and inode mapping pages are directly charged to the memcg
> that allocated them and the shrinker is correctly marked as
> SHRINKER_MEMCG_AWARE. Freeing the pages attached to the inode will
> account them correctly to the related memcg, regardless of which
> memcg is triggering the reclaim.  Hence I'm not sure that skipping
> the accounting of the reclaimed memory is even correct in this case;

Please note that we are not skipping any accounting here. The pages
are still uncharged from the memcgs they are charged to (the allocator
memcgs as you pointed out). We just do not report them in the return
value of try_to_free_mem_cgroup_pages(), to avoid over-reporting.

> I think the code should still be accounting for all pages that
> belong to the memcg being scanned that are reclaimed, not ignoring
> them altogether...

100% agree. Ideally I would want to:
- For pruned inodes: report all freed pages for global reclaim, and
only report pages charged to the memcg under reclaim for memcg
reclaim.
- For slab: report all freed pages for global reclaim, and only report
uncharged objcg pages from the memcg under reclaim for memcg reclaim.

The only problem is that I thought people would think this is too much
complexity and not worth it. If people agree this should be the
approach to follow, I can prepare patches for this. I originally
implemented this for slab pages, but held off on sending it.

>
> -Dave.
> --
> Dave Chinner
> david@fromorbit.com
