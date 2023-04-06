Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 232336D97AA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 15:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjDFNLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 09:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDFNLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 09:11:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C1123
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 06:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pXqj1PwftFG1CTNztOejBWmbXpaGHlkrrhcO5cp65TY=; b=vfAFeGBQ8S7+THx9NTlICwvPs3
        eKY5LmCpPmoxnvhnzOhQaQrJI5W4/cNbnnon4dNOi8ZbzOqUpNirOi6ahqkjSqQdAnqlsZwl4tkZQ
        iW8ctRug5iH6cBZlDUMc0Xdx+R6d+hyYX1IAF1/wSGf7hwDoVHBaftkhuAClTtA3MFDenW49AwzwA
        pjzGQrDi1fTgXLBcPLZ4Wj3X9p8fG88S0j+PW8pB+4Bf2i3J0QIRyo7FYLP3qxmXTHk9spopjyuKF
        h4OzLRbtPrAMtbqqvIGHiyZqAG4By3KW7e6yXkxXa0qIJa/WiSEDjkU5aojCHGUAXKq/E8yqLnzLJ
        89ScngDQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pkPOB-00HRGu-6f; Thu, 06 Apr 2023 13:10:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id EDE0F3000DC;
        Thu,  6 Apr 2023 15:10:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D00CB212E36AA; Thu,  6 Apr 2023 15:10:53 +0200 (CEST)
Date:   Thu, 6 Apr 2023 15:10:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org, ak@linux.intel.com,
        eranian@google.com
Subject: Re: [PATCH 1/2] perf: Add sched_task callback during ctx reschedule
Message-ID: <20230406131053.GK386572@hirez.programming.kicks-ass.net>
References: <20230328222735.1367829-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328222735.1367829-1-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 03:27:34PM -0700, kan.liang@linux.intel.com wrote:
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> Several similar kernel warnings can be triggered,
> 
>   [56605.607840] CPU0 PEBS record size 0, expected 32, config 0
>   cpuc->record_size=208
> 
> when the below commands are running in parallel for a while on SPR.
> 
>   while true; do perf record --no-buildid -a --intr-regs=AX -e
>   cpu/event=0xd0,umask=0x81/pp -c 10003 -o /dev/null ./triad; done &
> 
>   while true; do perf record -o /tmp/out -W -d -e
>   '{ld_blocks.store_forward:period=1000000,
>   MEM_TRANS_RETIRED.LOAD_LATENCY:u:precise=2:ldlat=4}'
>   -c 1037 ./triad; done
>   *The triad program is just the generation of loads/stores.
> 
> The warnings are triggered when an unexpected PEBS record (with a
> different config and size) is found.
> 
> In a context switch, different events may be applied to the old task and
> the new task. The sched_task callback is used to switch the PMU-specific
> data. For the PEBS, the callback flushes the DS area and parses the PEBS
> records from the old task when schedule out. The new task never sees the
> stale PEBS records.
> 
> However, the exec() doesn't have similar support. The new command may
> see the PEBS records from the old command. In the perf_event_exec(), the
> ctx_resched() is invoked to reschedule the context. It may updates the
> active events, which may change the global PEBS configuration. The PEBS
> record from the old command may have a different config and size from
> the new command. The warning is triggered.
> 
> The sched_task callback should be invoked in all the places where the
> context can be changed. Add the sched_task callback in the ctx_resched()
> as well.
> 
> Reported-by: Stephane Eranian <eranian@google.com>
> Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> ---
>  kernel/events/core.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index f79fd8b87f75..0c49183656fd 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -2642,6 +2642,8 @@ static void perf_event_sched_in(struct perf_cpu_context *cpuctx,
>  		 ctx_sched_in(ctx, EVENT_FLEXIBLE);
>  }
>  
> +static void perf_ctx_sched_task_cb(struct perf_event_context *ctx, bool sched_in);
> +
>  /*
>   * We want to maintain the following priority of scheduling:
>   *  - CPU pinned (EVENT_CPU | EVENT_PINNED)
> @@ -2680,6 +2682,7 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  	perf_ctx_disable(&cpuctx->ctx);
>  	if (task_ctx) {
>  		perf_ctx_disable(task_ctx);
> +		perf_ctx_sched_task_cb(task_ctx, false);
>  		task_ctx_sched_out(task_ctx, event_type);
>  	}
>  
> @@ -2698,8 +2701,10 @@ static void ctx_resched(struct perf_cpu_context *cpuctx,
>  	perf_event_sched_in(cpuctx, task_ctx);
>  
>  	perf_ctx_enable(&cpuctx->ctx);
> -	if (task_ctx)
> +	if (task_ctx) {
> +		perf_ctx_sched_task_cb(task_ctx, true);
>  		perf_ctx_enable(task_ctx);
> +	}
>  }
>  

Urgh... yuck.. Also I think you missed perf_rotate_context() which has
an open coded resched.

But I think this is a very fragile approach. Why can't the x86 pmu/pebs
driver not flush when it's programming changes -- it, as no other, knows
when this happens.
