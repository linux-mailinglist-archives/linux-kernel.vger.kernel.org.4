Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38EFC6D54E2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjDCWvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbjDCWvk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:51:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CFD03ABF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:51:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E631062B8D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 22:51:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56743C433EF;
        Mon,  3 Apr 2023 22:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680562288;
        bh=nCHk3zkvWXwY10cczA6sRnQuIsGC+f6S2QWO3f6TtSA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=k+H1E3v9KPcuvuvUuQBBW2BO21aPZplS0jyY9MsNd4oz8IgDdyYDucwIyM5K8m1Qw
         7jfixJSGkO3jKGDHNPIG4AO20rLHYAwREtYw/b1FYv+hfO6hlNv344Ec3i84te65l5
         yf8nFjrGDhogTn5mabLnsZdzBi4cTmYG0DUS4KRvqFZ/QMVi3yRKhFQEZYsP/qyNzn
         Nt6iMp/T2KQ5tjD6MBqbdacuo0tURaW4sZ7Kz7KSYgXUmnnO790/z8IZDcONWc6c/Y
         L43rtjojajfBuHhppauFI7Y3ETpyBxn5QjrlGWGcsyvvZEWqt0u7HpuCT8s59XtGt1
         oZDGNDa7rX9Hg==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D5FBA15404B4; Mon,  3 Apr 2023 15:51:27 -0700 (PDT)
Date:   Mon, 3 Apr 2023 15:51:27 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Olsa <jolsa@kernel.org>
Subject: Re: [PATCH] perf: Optimize perf_pmu_migrate_context()
Message-ID: <db6f2ad0-fe47-4574-9290-a1be5f349368@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230403090858.GT4253@hirez.programming.kicks-ass.net>
 <87sfdgr55p.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfdgr55p.ffs@tglx>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 12:07:30AM +0200, Thomas Gleixner wrote:
> On Mon, Apr 03 2023 at 11:08, Peter Zijlstra wrote:
> > Thomas reported that offlining CPUs spends a lot of time in
> > synchronize_rcu() as called from perf_pmu_migrate_context() even though
> > he's not actually using uncore events.
> 
> That happens when offlining CPUs from a socket > 0 in the same order how
> those CPUs have been brought up. On socket 0 this is not observable
> unless the bogus CPU0 offlining hack is enabled.
> 
> If the offlining happens in the reverse order then all is shiny.
> 
> The reason is that the first online CPU on a socket gets the uncore
> events assigned and when it is offlined then those are moved to the next
> online CPU in the same socket.
> 
> On a SKL-X with 56 threads per sockets this results in a whopping _1_
> second delay per thread (except for the last one which shuts down the
> per socket uncore events with no delay because there are no users) due
> to 62 times of pointless synchronize_rcu() invocations where each takes
> ~16ms on a HZ=250 kernel.
> 
> Which in turn is interesting because that machine is completely idle
> other than running the offline muck...
> 
> > Turns out, the thing is unconditionally waiting for RCU, even if there's
> > no actual events to migrate.
> >
> > Fixes: 0cda4c023132 ("perf: Introduce perf_pmu_migrate_context()")
> > Reported-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Tested-by: Thomas Gleixner <tglx@linutronix.de>
> 
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Yow!  ;-)

Assuming that all the events run under RCU protection, as in preemption
disabled:

Reviewed-by: Paul E. McKenney <paulmck@kernel.org>
