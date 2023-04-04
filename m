Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222AD6D5BEB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 11:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234190AbjDDJan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 05:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjDDJak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 05:30:40 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF69B1BD3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 02:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XxZB3SLSYvPYnBm4w8lf6rXnbcqwEa14/do4C6PCMow=; b=iiJFOb6YNge1DKARwvlpAARAQA
        ri0AcpY0qlzrwt0AGIn8/P5XyfbGNFQ8OEpLSOXKHIpXwbsB+5GkWPBvsT+vgUMxdHFGcSrdr3ZkX
        aFO7/FYLYP9L9MlnLEqDtl9KYqilz/5vIEP4tajqQi39rtYKgPo18nQXhUS913eyn8OYt31ITs4cN
        FdAnHWRcWC2m4kpNqhXFH1Vkl5JxwW+2XanO3PpEhpanTb2p/32652J96lh4f4ioUjhQ7MSKv1Lj5
        QTjMLCZO+2V0dsU7PTiFnUrt+/WM6LqzseKNT4x9IBSB6EcNnkS+jbJU87Mg+ljyBm/y30Tagy43+
        TO540yVA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjcyx-009Dhr-1X;
        Tue, 04 Apr 2023 09:29:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 43A58300338;
        Tue,  4 Apr 2023 11:29:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 21CF4242109F9; Tue,  4 Apr 2023 11:29:36 +0200 (CEST)
Date:   Tue, 4 Apr 2023 11:29:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, corbet@lwn.net, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
Message-ID: <20230404092936.GD284733@hirez.programming.kicks-ass.net>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.562078801@infradead.org>
 <CAKfTPtAkFBw5zt0+WK7dWBUE9OrbOOExG8ueUE6ogdCEQZhpXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAkFBw5zt0+WK7dWBUE9OrbOOExG8ueUE6ogdCEQZhpXQ@mail.gmail.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 05:26:51PM +0200, Vincent Guittot wrote:
> On Tue, 28 Mar 2023 at 13:06, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > In the case where (due to latency-nice) there are different request
> > sizes in the tree, the smaller requests tend to be dominated by the
> > larger. Also note how the EEVDF lag limits are based on r_max.
> >
> > Therefore; add a heuristic that for the mixed request size case, moves
> > smaller requests to placement strategy #2 which ensures they're
> > immidiately eligible and and due to their smaller (virtual) deadline
> > will cause preemption.
> >
> > NOTE: this relies on update_entity_lag() to impose lag limits above
> > a single slice.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/sched/fair.c     |   14 ++++++++++++++
> >  kernel/sched/features.h |    1 +
> >  kernel/sched/sched.h    |    1 +
> >  3 files changed, 16 insertions(+)
> >
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -616,6 +616,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq,
> >         s64 key = entity_key(cfs_rq, se);
> >
> >         cfs_rq->avg_vruntime += key * weight;
> > +       cfs_rq->avg_slice += se->slice * weight;
> >         cfs_rq->avg_load += weight;
> >  }
> >
> > @@ -626,6 +627,7 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq,
> >         s64 key = entity_key(cfs_rq, se);
> >
> >         cfs_rq->avg_vruntime -= key * weight;
> > +       cfs_rq->avg_slice -= se->slice * weight;
> >         cfs_rq->avg_load -= weight;
> >  }
> >
> > @@ -4832,6 +4834,18 @@ place_entity(struct cfs_rq *cfs_rq, stru
> >                 lag = se->vlag;
> >
> >                 /*
> > +                * For latency sensitive tasks; those that have a shorter than
> > +                * average slice and do not fully consume the slice, transition
> > +                * to EEVDF placement strategy #2.
> > +                */
> > +               if (sched_feat(PLACE_FUDGE) &&
> > +                   cfs_rq->avg_slice > se->slice * cfs_rq->avg_load) {
> > +                       lag += vslice;
> > +                       if (lag > 0)
> > +                               lag = 0;
> 
> By using different lag policies for tasks, doesn't this create
> unfairness between tasks ?

Possibly, I've just not managed to trigger it yet -- if it is an issue
it can be fixed by ensuring we don't place the entity before its
previous vruntime just like the sleeper hack later on.

> I wanted to stress this situation with a simple use case but it seems
> that even without changing the slice, there is a fairness problem:
> 
> Task A always run
> Task B loops on : running 1ms then sleeping 1ms
> default nice and latency nice prio bot both
> each task should get around 50% of the time.
> 
> The fairness is ok with tip/sched/core
> but with eevdf, Task B only gets around 30%
> 
> I haven't identified the problem so far

Heh, this is actually the correct behaviour. If you have a u=1 and a
u=.5 task, you should distribute time on a 2:1 basis, eg. 67% vs 33%.

CFS has this sleeper bonus hack that makes it 50% vs 50% but that is
strictly not correct -- although it does help a number of weird
benchmarks.

