Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C96269B25C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 19:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjBQS0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 13:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBQS0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:26:19 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46965F806
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 10:26:18 -0800 (PST)
Date:   Fri, 17 Feb 2023 10:26:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676658376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b03GfOT4dkuf8arvwGMY+h7JsXZlR+KDPY8uVhKZfJ4=;
        b=xWPOsc5VYy1gGTb9sWGQQOnvZT4z3cLJyptPALTEUOIyzo1o/UcEIIR15mb202Psn6SljQ
        vLiT1BNs7vnef1jh57hqSVJWLxOR6v4r6k4BVt1Lvyq48vE9VEIAM90aWEebCyBvAN7VEz
        eXCg0ksgNq9WlC+5EWGs7OAvMOp0uns=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Waiman Long <longman@redhat.com>,
        Sven Luther <Sven.Luther@windriver.com>
Subject: Re: [PATCH RFC] ipc/mqueue: introduce msg cache
Message-ID: <Y+/GxJcNykVQxcG+@P9FQF9L96D.corp.robot.car>
References: <20221220184813.1908318-1-roman.gushchin@linux.dev>
 <7a3e0cb1-54f0-73b2-d9e5-db4d28836bfc@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a3e0cb1-54f0-73b2-d9e5-db4d28836bfc@leemhuis.info>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 01:29:59PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, this is your Linux kernel regression tracker.
> 
> On 20.12.22 19:48, Roman Gushchin wrote:
> > Sven Luther reported a regression in the posix message queues
> > performance caused by switching to the per-object tracking of
> > slab objects introduced by patch series ending with the
> > commit 10befea91b61 ("mm: memcg/slab: use a single set of kmem_caches for all
> > allocations").
> 
> Quick inquiry: what happened to below patch? It was supposed to fix a
> performance regression reported here:

Hi Thorsten!

I wouldn't call it simple a regression, things a bit more complicated:
it was a switch to a different approach with different trade-offs,
which IMO make more sense for the majority of real-world workloads.
In two words: individual kernel memory allocations became somewhat slower
(but still fast), but we've saved 40%+ of slab memory on typical systems
and reduced the memory fragmentation.

The regression reported by Sven and my "fix" are related to one very specific
case: posix message queues. To my knowledge they are not widely used for
anything that performance-sensitive, so it's quite a niche use case.
My "fix" was also hand-crafted for the benchmark provided by Sven, so it might
not work for a more generic case. And I don't think it can be easily generalized
without adding cpu or memory overhead.

On the other hand I'm working on improving the speed of kernel memory allocations
in general (I posted early versions some weeks ago). Hopefully it will mitigate
the problem for Sven as well, so we won't need these message queue-specific
hacks.

Thanks!
