Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216856C4C11
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 14:42:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCVNmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 09:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjCVNmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 09:42:22 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0E4FA96;
        Wed, 22 Mar 2023 06:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hgQQgEdJS6js4rXOh+AMl0grnS+OJc3Q2Dmr1Xc1fBs=; b=PUe3gU/38I2DLnDrrIKT6+Es5E
        J5h3lJp57o6mlM9sHakaq49Shw1CNABY8I7w7PJjrpWvzUBRjYFnvJ7pj7mhbpuhArD/ARdXmXedC
        Daf02iS6Ic6O4x/B53MFoAY+PsTOpZi7YrBOomOdh636tLi0AfDu3VmwrCk2FERpQ92TRtJzuNJZd
        s0K645LA+cZDQZAMd33J2eM2sVD1BxRvLP8YxJeBil+Juws8q5Sl2L0Fnl/51SSE35Gh4JIEJmO10
        ea+HDw0Cz3x7MSCQ36ZPcQ9a6jRlQi/jQ40Vhh2KGSDkdojgODMQ8L5KS3zc9UmnoclqiSxbrg1S9
        gyq5gl5g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1peyj7-004ZBD-1k;
        Wed, 22 Mar 2023 13:42:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A1AA30031E;
        Wed, 22 Mar 2023 14:42:03 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 536F1205D08C2; Wed, 22 Mar 2023 14:42:03 +0100 (CET)
Date:   Wed, 22 Mar 2023 14:42:03 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     alexander.shishkin@linux.intel.com, ak@linux.intel.com,
        kan.liang@linux.intel.com, nadav.amit@gmail.com,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        jolsa@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        mingo@redhat.com, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH] perf/core: Fix the same task check in
 perf_event_set_output
Message-ID: <20230322134203.GB2357380@hirez.programming.kicks-ass.net>
References: <20220711180706.3418612-1-kan.liang@linux.intel.com>
 <be7e6a74-4863-d5eb-51ff-26aa2890f2bd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be7e6a74-4863-d5eb-51ff-26aa2890f2bd@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 12:59:28PM +0200, Adrian Hunter wrote:
> On 11/07/22 21:07, kan.liang@linux.intel.com wrote:
> > From: Kan Liang <kan.liang@linux.intel.com>
> > 
> > With the --per-thread option, perf record errors out when sampling with
> > a hardware event and a software event as below.
> > 
> >  $ perf record -e cycles,dummy --per-thread ls
> >  failed to mmap with 22 (Invalid argument)
> > 
> > The same task is sampled with the two events. The IOC_OUTPUT is invoked
> > to share the mmap memory of the task between the events. In the
> > perf_event_set_output(), the event->ctx is used to check whether the
> > two events are attached to the same task. However, a hardware event and
> > a software event are from different task context. The check always
> > fails.
> > 
> > The task struct is stored in the event->hw.target for each per-thread
> > event. It can be used to determine whether two events are attached to
> > the same task.
> > 
> > The patch can also fix another issue reported months ago.
> > https://lore.kernel.org/all/92645262-D319-4068-9C44-2409EF44888E@gmail.com/
> > The event->ctx is not ready when the perf_event_set_output() is invoked
> > in the perf_event_open(), while the event->hw.target has been assigned
> > at the moment.
> > 
> > The problem should be a long time issue since commit c3f00c70276d
> > ("perf: Separate find_get_context() from event initialization"). The
> > event->hw.target doesn't exist at that time. Here, the patch which
> > introduces the event->hw.target is used by the Fixes tag.
> > 
> > The problem should still exists between the broken patch and the
> > event->hw.target patch. This patch does not intend to fix that case.
> > 
> > Fixes: 50f16a8bf9d7 ("perf: Remove type specific target pointers")
> > Reviewed-by: Zhengjun Xing <zhengjun.xing@linux.intel.com>
> > Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
> 
> Did this slip through the cracks, or is there more complexity
> to this case than just sharing the rb?

Both; I very much missed it, but looking at it now, I'm not at all sure
it is correct prior to the whole context rewrite we did recently.

So after the rewrite every cpu/task only has a single
perf_event_context, and your change below is actually an equivalence.

But prior to that a task could have multiple contexts. Now they got
co-scheduled most of the times and it will probably work, but I'm not
entirely sure.

So how about we change the Fixes tag to something like:

Fixes: c3f00c70276d ("perf: Separate find_get_context() from event initialization") # >= v6.2

And anybody that wants to back-port this further gets to either do the
full audit and/or keep the pieces.

Hmm?

> > ---
> >  kernel/events/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index b4d62210c3e5..22df79d3f19d 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -12080,7 +12080,7 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
> >  	/*
> >  	 * If its not a per-cpu rb, it must be the same task.
> >  	 */
> > -	if (output_event->cpu == -1 && output_event->ctx != event->ctx)
> > +	if (output_event->cpu == -1 && output_event->hw.target != event->hw.target)
> >  		goto out;
> >  
> >  	/*
> 
