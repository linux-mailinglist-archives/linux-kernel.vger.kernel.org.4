Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E443C5F9C7D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 12:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbiJJKPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 06:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiJJKO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 06:14:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A881401A;
        Mon, 10 Oct 2022 03:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=HPidJK9k0wDj5SKTPSWA/1fb2xWJmy1rprDVNz5gd7I=; b=gZPg5tHvpsY0bShNV9wsEEgKzL
        JRcE92EijJ+834KzNf4yHcapJ0hmZIzBsOs1iJJf2o8DPH+7tLJl7xpUpC4ILJ0EgFxvypPoxwPQS
        Ui0s3kNXhjHb5xf3YtykfLjUFUuIE3oI2vRyAWAGkmtMp/rUR9JlTu5XKrCj5lcXrvl1T/FTb9kF4
        XpNxRKqVTksqhCKqSRBJ2I7jQLs42ALK7yx950VZ6Bno7tlRTEb6tCQLnZ8V2850A4JBeYzGwdxmz
        cB7sVWx5zACwknyQTBTKjYT01aJ58pvGMpg5bHg6113Xy0JDD9W6pchvv8I35x+bvrpMOAwIiJO9v
        9GwnBM2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ohpnq-0048Q4-3g; Mon, 10 Oct 2022 10:14:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F80E300465;
        Mon, 10 Oct 2022 12:14:24 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5EB4F2022F86C; Mon, 10 Oct 2022 12:14:24 +0200 (CEST)
Date:   Mon, 10 Oct 2022 12:14:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, songliubraving@fb.com,
        eranian@google.com, ak@linux.intel.com, mark.rutland@arm.com,
        frederic@kernel.org, maddy@linux.ibm.com, irogers@google.com,
        will@kernel.org, robh@kernel.org, mingo@redhat.com,
        catalin.marinas@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        sandipan.das@amd.com, ananth.narayan@amd.com, kim.phillips@amd.com,
        santosh.shukla@amd.com
Subject: Re: [PATCH] perf: Rewrite core context handling
Message-ID: <Y0PwgBz6asJOHSan@hirez.programming.kicks-ass.net>
References: <20220829113347.295-1-ravi.bangoria@amd.com>
 <e1d933d1-4772-1357-9cf1-6e5b842508c8@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d933d1-4772-1357-9cf1-6e5b842508c8@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 04:58:49PM +0530, Ravi Bangoria wrote:
> > -static void
> > -ctx_flexible_sched_in(struct perf_event_context *ctx,
> > -		      struct perf_cpu_context *cpuctx)
> > +/* XXX .busy thingy from Peter's patch */
> > +static void ctx_flexible_sched_in(struct perf_event_context *ctx, struct pmu *pmu)
> 
> This one turned out to be very easy. Given that, we iterate over each
> pmu, we can just return error if we fail to schedule any flexible event.
> (It wouldn't be straight forward like this if we needed to implement
> pmu=NULL optimization.)
> 
> ---
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index e0232e0bb74e..923656af73fe 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -3751,6 +3751,7 @@ static int merge_sched_in(struct perf_event *event, void *data)
>  			cpc = this_cpu_ptr(event->pmu_ctx->pmu->cpu_pmu_context);
>  			perf_mux_hrtimer_restart(cpc);
>  			group_update_userpage(event);
> +			return -EBUSY;
>  		}
>  	}
>  

I'm afraid this breaks things; consider:

  f79256532682 ("perf/core: fix userpage->time_enabled of inactive events")

I totally hate this -- because it means we *HAVE* to iterate the
inactive events, but alas.
