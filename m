Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFDE36F841A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjEENdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjEENdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:33:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26EDA20741;
        Fri,  5 May 2023 06:33:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OAJHHR5cW5zZppYz7Dqy+tRpazmn4q+ZTLJfKmwg/AU=; b=EJlEpl44I8W/6AL75Uu7TvyziQ
        RVvBZ9mcyGdPikqbzI3SjFqg5Erc2zYDBz0PSdjioDTgcLE5tZlAF4if8QiQXIGGY4DLIqxI4Uc7L
        1moJENTgO5pKKM0GfDA1EGDoWmiObGiaOSIrvFB8BIvekd+Cn050DkDEPfSBKBnDtcHMxHY8LjT7h
        JCDU0OHXbtfnVk5YS3FsSYCI5ZRAvixzDdeUiXugrxylRWQ4bSEGBbw4w+IIyVbmktVd1AbZtRG2n
        XzvfNsTB8W3jDJBGJbC9Gmpz7DHt1jdFYmds+DNQ+x79cOQISNlH7x/fkwEGJK7L90pzoLVOnbmzI
        9fDWnPMw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1puvY5-00BVcU-FH; Fri, 05 May 2023 13:32:37 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C7D943003CF;
        Fri,  5 May 2023 15:32:35 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 87FCF21353002; Fri,  5 May 2023 15:32:35 +0200 (CEST)
Date:   Fri, 5 May 2023 15:32:35 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Wander Lairson Costa <wander@redhat.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Brian Cain <bcain@quicinc.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <brauner@kernel.org>,
        Andrei Vagin <avagin@gmail.com>,
        Shakeel Butt <shakeelb@google.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>, Hu Chunyu <chuhu@redhat.com>,
        Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v7 2/3] sched/task: Add the put_task_struct_atomic_safe()
 function
Message-ID: <20230505133235.GG4253@hirez.programming.kicks-ass.net>
References: <20230425114307.36889-1-wander@redhat.com>
 <20230425114307.36889-3-wander@redhat.com>
 <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
 <20230504122945.GA28757@redhat.com>
 <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
 <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
 <20230504152424.GG1744258@hirez.programming.kicks-ass.net>
 <cjhvb72qrqggom5gxdjz6mtz3bntlmznx7r52adz72z2t2edzr@hwcog2pltfaq>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cjhvb72qrqggom5gxdjz6mtz3bntlmznx7r52adz72z2t2edzr@hwcog2pltfaq>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 03:21:11PM -0300, Wander Lairson Costa wrote:
> On Thu, May 04, 2023 at 05:24:24PM +0200, Peter Zijlstra wrote:
> > On Thu, May 04, 2023 at 11:55:15AM -0300, Wander Lairson Costa wrote:
> > 
> > > > Then I'm thinking something trivial like so:
> > > >
> > > > static inline void put_task_struct(struct task_struct *t)
> > > > {
> > > >         if (!refcount_dec_and_test(&t->usage))
> > > >                 return;
> > > >
> > > >         if (IS_ENABLED(CONFIG_PREEMPT_RT) && !preemptible())
> > > >                 call_rcu(&t->rcu, __put_task_struct_rcu);
> > > >
> > > >         __put_task_struct(t);
> > > > }
> > > >
> > > 
> > > That's what v5 [1] does. What would be the path in this case? Should I
> > > resend it as v8?
> > 
> > It's almost what v5 does. v5 also has a !in_task() thing. v5 also
> > violates codingstyle :-)
> 
> IIRC, the in_task() is there because preemptible() doesn't check if it
> is running in interrupt context.

#define preemptible()   (preempt_count() == 0 && !irqs_disabled())

When in interrupt context preempt_count() will have a non-zero value in
HARDIRQ_MASK and IRQs must be disabled, so preemptible() evaluates to
(false && false), last time I checked that ends up being false.
