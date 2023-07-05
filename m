Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE31B747FD8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 10:38:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbjGEIiv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 04:38:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbjGEIis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 04:38:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50891713;
        Wed,  5 Jul 2023 01:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ieF3zFuQqWFAkhQGD7I16xeYHzi6lV//vDA/FIr0IiY=; b=i358LtHRAca5uc/0lBMdFN93OV
        WlZ0YDrFgL5bjcRHPVYfIFF7zwHG5Zq26fj7wl1C7CYT8yi1E6/eshbzI6K9dOiljw82n0ttfJZd2
        Cp/Ydey43SQZAsdJCG+pxJ4M2agG3/i5cGzwAA85xnCCFuEPvN48wPoYxms3HqsMePXaWNLYQQtGA
        dwQuXg0V+6lxeXXcGBe0FKVsKeYens3ilHKjn1qbDWa1emlQ1+/WksDbqMUppJ69eZkVzly5fmHHR
        cPcInDfKz8fGu6X1gKqpEHkp9SSflhyJsmdmqwITXlXDFGCwDgqQ53Vq2r+qfwJ8qqkmFWnYxmOSI
        h093ZfdQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qGy1z-00C2Vt-1k;
        Wed, 05 Jul 2023 08:38:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3FB183001E7;
        Wed,  5 Jul 2023 10:38:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 011502026A8A0; Wed,  5 Jul 2023 10:38:33 +0200 (CEST)
Date:   Wed, 5 Jul 2023 10:38:33 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Stephane Eranian <eranian@google.com>,
        Greg Thelen <gthelen@google.com>, stable@vger.kernel.org
Subject: Re: [PATCH] perf/x86: Fix lockdep warning in
 for_each_sibling_event() on SPR
Message-ID: <20230705083833.GE462772@hirez.programming.kicks-ass.net>
References: <20230704181516.3293665-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704181516.3293665-1-namhyung@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 11:15:15AM -0700, Namhyung Kim wrote:
> On SPR, the load latency event needs an auxiliary event in the same
> group to work properly.  There's a check in intel_pmu_hw_config()
> for this to iterate sibling events and find a mem-loads-aux event.
> 
> The for_each_sibling_event() has a lockdep assert to make sure if it
> disabled hardirq or hold leader->ctx->mutex.  This works well if the
> given event has a separate leader event since perf_try_init_event()
> grabs the leader->ctx->mutex to protect the sibling list.  But it can
> cause a problem when the event itself is a leader since the event is
> not initialized yet and there's no ctx for the event.
> 
> Actually I got a lockdep warning when I run the below command on SPR,
> but I guess it could be a NULL pointer dereference.
> 
>   $ perf record -d -e cpu/mem-loads/uP true
> 
> The code path to the warning is:
> 
>   sys_perf_event_open()
>     perf_event_alloc()
>       perf_init_event()
>         perf_try_init_event()
>           x86_pmu_event_init()
>             hsw_hw_config()
>               intel_pmu_hw_config()
>                 for_each_sibling_event()
>                   lockdep_assert_event_ctx()
> 
> We don't need for_each_sibling_event() when it's a standalone event.
> Let's return the error code directly.
> 
> Fixes: f3c0eba28704 ("perf: Add a few assertions")
> Reported-by: Greg Thelen <gthelen@google.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> ---
>  arch/x86/events/intel/core.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 0d09245aa8df..933fe4894c32 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -3983,6 +3983,14 @@ static int intel_pmu_hw_config(struct perf_event *event)
>  		struct perf_event *leader = event->group_leader;
>  		struct perf_event *sibling = NULL;
>  
> +		/*
> +		 * The event is not fully initialized yet and no ctx is set
> +		 * for the event.  Avoid for_each_sibling_event() since it
> +		 * has a lockdep assert with leader->ctx->mutex.
> +		 */

If I understand things correctly, your patch is indeed correct, however
I don't much like this comment, does something like:

		/*
		 * When this memload event is also the first event (no
		 * group exists yet), then there is no aux event before
		 * it.
		 */

work for you?

> +		if (leader == event)
> +			return -ENODATA;
> +
>  		if (!is_mem_loads_aux_event(leader)) {
>  			for_each_sibling_event(sibling, leader) {
>  				if (is_mem_loads_aux_event(sibling))
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 
