Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C606F84D8
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 16:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbjEEO31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 10:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230300AbjEEO3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 10:29:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08741723;
        Fri,  5 May 2023 07:29:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7B2A063E70;
        Fri,  5 May 2023 14:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819AEC433EF;
        Fri,  5 May 2023 14:29:19 +0000 (UTC)
Date:   Fri, 5 May 2023 10:29:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wander Lairson Costa <wander@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
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
Subject: Re: [PATCH v7 2/3] sched/task: Add the
 put_task_struct_atomic_safe() function
Message-ID: <20230505102916.4aa664dd@gandalf.local.home>
In-Reply-To: <20230505102602.2052c83a@gandalf.local.home>
References: <20230425114307.36889-1-wander@redhat.com>
        <20230425114307.36889-3-wander@redhat.com>
        <20230504084229.GI1734100@hirez.programming.kicks-ass.net>
        <20230504122945.GA28757@redhat.com>
        <20230504143303.GA1744142@hirez.programming.kicks-ass.net>
        <CAAq0SUmYrQbS1k9NNKGQP7hQRQJ308dk9NCiUimEiLeBJUavgA@mail.gmail.com>
        <20230504152424.GG1744258@hirez.programming.kicks-ass.net>
        <cjhvb72qrqggom5gxdjz6mtz3bntlmznx7r52adz72z2t2edzr@hwcog2pltfaq>
        <20230505133235.GG4253@hirez.programming.kicks-ass.net>
        <20230505102602.2052c83a@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 May 2023 10:26:02 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > > IIRC, the in_task() is there because preemptible() doesn't check if it
> > > is running in interrupt context.    
> > 
> > #define preemptible()   (preempt_count() == 0 && !irqs_disabled())
> > 
> > When in interrupt context preempt_count() will have a non-zero value in
> > HARDIRQ_MASK and IRQs must be disabled, so preemptible() evaluates to
> > (false && false), last time I checked that ends up being false.  
> 
> Interesting, I can't find v5 anywhere in my mail folders (but I have
> v4 and v6!). Anyway, from just the context of this email, and seeing
> IS_ENABLED(CONFIG_PREEMPT_RT), I'm guessing that in_task() returns false if
> it's running in a interrupt thread, where preemtible() does not.

But then I question, does it matter if it is running in an interrupt thread
or not for put_task_struct()?

-- Steve
