Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B7067C29E
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 03:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230237AbjAZCCZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 21:02:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjAZCCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 21:02:24 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE5F5EF94
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 18:02:23 -0800 (PST)
Date:   Wed, 25 Jan 2023 18:02:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1674698541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dP/00qm2xtIoOgxZ59rfAfeMc8lp52RZ82HChbdOra0=;
        b=URqM1W+zW3QAvh/0+OOEBnQl0aaQomsbz+tP9Q7hKsSBR1wJF0vbHtv9GWiWTzGBNPI/uI
        WJ/BHaI8tQ5gmHapNRBpgAC3ZakEA3pvi7+APpcy14mQCwPE+u78V2hlhXcUwqEGqnjsgJ
        X/M4KpCwZxGGxcTY8dzsJKgVCJssG/w=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Roman Gushchin <roman.gushchin@linux.dev>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Message-ID: <Y9HfHKXRPLrfG6g1@P9FQF9L96D.corp.robot.car>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230121033942.350387-1-42.hyeyoo@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:39:42PM +0900, Hyeonggon Yoo wrote:
> In workloads where this_cpu operations are frequently performed,
> enabling DEBUG_PREEMPT may result in significant increase in
> runtime overhead due to frequent invocation of
> __this_cpu_preempt_check() function.
> 
> This can be demonstrated through benchmarks such as hackbench where this
> configuration results in a 10% reduction in performance, primarily due to
> the added overhead within memcg charging path.
> 
> Therefore, do not to enable DEBUG_PREEMPT by default and make users aware
> of its potential impact on performance in some workloads.
> 
> hackbench-process-sockets
> 		      debug_preempt	 no_debug_preempt
> Amean     1       0.4743 (   0.00%)      0.4295 *   9.45%*
> Amean     4       1.4191 (   0.00%)      1.2650 *  10.86%*
> Amean     7       2.2677 (   0.00%)      2.0094 *  11.39%*
> Amean     12      3.6821 (   0.00%)      3.2115 *  12.78%*
> Amean     21      6.6752 (   0.00%)      5.7956 *  13.18%*
> Amean     30      9.6646 (   0.00%)      8.5197 *  11.85%*
> Amean     48     15.3363 (   0.00%)     13.5559 *  11.61%*
> Amean     79     24.8603 (   0.00%)     22.0597 *  11.27%*
> Amean     96     30.1240 (   0.00%)     26.8073 *  11.01%*
> 
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

Nice!

I checkout my very simple kmem performance test (1M allocations 8-bytes allocations)
and it shows ~30% difference: 112319 us with vs 80836 us without.

Probably not that big for real workloads, but still nice to have.

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Thank you!
