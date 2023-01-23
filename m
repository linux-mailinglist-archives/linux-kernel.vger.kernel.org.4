Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0953D677D73
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 15:01:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjAWOBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 09:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbjAWOBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 09:01:52 -0500
Received: from outbound-smtp48.blacknight.com (outbound-smtp48.blacknight.com [46.22.136.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A3F26841
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 06:01:26 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id 467E9FA7D4
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 14:01:25 +0000 (GMT)
Received: (qmail 13299 invoked from network); 23 Jan 2023 14:01:24 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 23 Jan 2023 14:01:24 -0000
Date:   Mon, 23 Jan 2023 14:01:22 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable] lib/Kconfig.debug: do not enable
 DEBUG_PREEMPT by default
Message-ID: <20230123140122.gxg3dqvqsz62qks7@techsingularity.net>
References: <20230121033942.350387-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20230121033942.350387-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Peter to the cc as this should go via the tip tree even though
Ingo is cc'd already. Leaving full context and responding inline.

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

Acked-by: Mel Gorman <mgorman@techsingularity.net>

This has been default y since very early on in the development of the BKL
removal. It was probably selected by default because it was expected there
would be a bunch of new SMP-related bugs. These days, there is no real
reason to enable it by default except when debugging a preempt-related
issue or during development. It's not like CONFIG_SCHED_DEBUG which gets
enabled in a lot of distros as it has some features which are useful in
production (which is unfortunate but splitting CONFIG_SCHED_DEBUG is a
completely separate topic).

> ---
>  lib/Kconfig.debug | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index ddbfac2adf9c..f6f845a4b9ec 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -1176,13 +1176,16 @@ config DEBUG_TIMEKEEPING
>  config DEBUG_PREEMPT
>  	bool "Debug preemptible kernel"
>  	depends on DEBUG_KERNEL && PREEMPTION && TRACE_IRQFLAGS_SUPPORT
> -	default y
>  	help
>  	  If you say Y here then the kernel will use a debug variant of the
>  	  commonly used smp_processor_id() function and will print warnings
>  	  if kernel code uses it in a preemption-unsafe way. Also, the kernel
>  	  will detect preemption count underflows.
>  
> +	  This option has potential to introduce high runtime overhead,
> +	  depending on workload as it triggers debugging routines for each
> +	  this_cpu operation. It should only be used for debugging purposes.
> +
>  menu "Lock Debugging (spinlocks, mutexes, etc...)"
>  
>  config LOCK_DEBUGGING_SUPPORT
> -- 
> 2.34.1
> 
> 

-- 
Mel Gorman
SUSE Labs
