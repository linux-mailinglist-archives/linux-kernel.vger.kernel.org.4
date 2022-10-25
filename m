Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E30D60CD88
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 15:32:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232855AbiJYNcf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232786AbiJYNcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 09:32:33 -0400
Received: from outbound-smtp31.blacknight.com (outbound-smtp31.blacknight.com [81.17.249.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7201118B0A2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 06:32:32 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp31.blacknight.com (Postfix) with ESMTPS id A3875C0EA9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 14:32:30 +0100 (IST)
Received: (qmail 3467 invoked from network); 25 Oct 2022 13:32:30 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 Oct 2022 13:32:30 -0000
Date:   Tue, 25 Oct 2022 14:32:26 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     Mel Gorman <mgorman@suse.de>, mingo@redhat.com,
        peterz@infradead.org, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [External] Re: [PATCH 1/2] sched/numa: Stop an exhastive search
 if an idle core is found
Message-ID: <20221025133226.ap6zeidoyea6jher@techsingularity.net>
References: <20221021061558.34767-1-jiahao.os@bytedance.com>
 <20221021061558.34767-2-jiahao.os@bytedance.com>
 <20221024133435.e2kajx5k7jzznp25@suse.de>
 <ced7c05a-121b-a77d-0c57-3e60abaecacd@bytedance.com>
 <20221025093226.dm4sjvdq2tofkwvc@suse.de>
 <71589225-a4fd-b3eb-14d5-81c9a19419a7@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <71589225-a4fd-b3eb-14d5-81c9a19419a7@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 07:10:22PM +0800, Hao Jia wrote:
> On 2022/10/25 Mel Gorman wrote:
> > On Tue, Oct 25, 2022 at 11:16:29AM +0800, Hao Jia wrote:
> > > > Remove the change in the first hunk and call break in the second hunk
> > > > after updating ns->idle_cpu.
> > > > 
> > > 
> > > Yes, thanks for your review.
> > > If I understand correctly, some things might look like this.
> > > 
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index e4a0b8bd941c..dfcb620bfe50 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -1792,7 +1792,7 @@ static void update_numa_stats(struct task_numa_env
> > > *env,
> > >                  ns->nr_running += rq->cfs.h_nr_running;
> > >                  ns->compute_capacity += capacity_of(cpu);
> > > 
> > > -               if (find_idle && !rq->nr_running && idle_cpu(cpu)) {
> > > +               if (find_idle && idle_core < 0 && !rq->nr_running &&
> > > idle_cpu(cpu)) {
> > >                          if (READ_ONCE(rq->numa_migrate_on) ||
> > >                              !cpumask_test_cpu(cpu, env->p->cpus_ptr))
> > >                                  continue;
> > > 
> > 
> > I meant more like the below but today I wondered why did I not do this in
> > the first place? The answer is because it's wrong and broken in concept.
> > 
> > The full loop is needed to calculate approximate NUMA stats at a
> > point in time. For example, the src and dst nr_running is needed by
> > task_numa_find_cpu. The search for an idle CPU or core in update_numa_stats
> > is simply taking advantage of the fact we are scanning anyway to keep
> > track of an idle CPU or core to avoid a second search as per ff7db0bf24db
> > ("sched/numa: Prefer using an idle CPU as a migration target instead of
> > comparing tasks")
> > 
> > The patch I had in mind is below but that said, for both your version and
> > my initial suggestion
> > 
> > Naked-by: Mel Gorman <mgorman@suse.de>
> > 
> > For the record, this is what I was suggesting initially because it's more
> > efficient but it's wrong, don't do it.
> > 
> 
> Thanks for the detailed explanation, maybe my commit message misled you.
> 

Yes, I did end up confusing myself. The title and changelog referred to
stopping a search which made me think of terms of "this whole loop can
terminate early" which it can't but it *can* stop checking for a new idle
core. If an idle core has been found, it follows that an idle CPU has also
been found. While numa_idle_core checks this explicitly, your patch avoids
an unnecessary cpumask_test_cpu so it has value.

> Yes, we can't stop the whole loop of scanning the CPU because we have a lot
> of NUMA information to count.
> 
> But we can stop looking for the next idle core or idle cpu after finding an
> idle core.
> 
> So, please review the previous code.
> 

You're right and sorry for the noise.

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
