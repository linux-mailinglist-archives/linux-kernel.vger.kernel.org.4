Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362936D9CD7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 17:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239516AbjDFP62 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 6 Apr 2023 11:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbjDFP60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 11:58:26 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0187593CB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 08:58:24 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1pkS09-0007Xj-Pw; Thu, 06 Apr 2023 17:58:17 +0200
Message-ID: <8312fa88a3929b83a8ccdca1a0ab33bef15fa0ae.camel@pengutronix.de>
Subject: Re: [Regression] drm/scheduler: track GPU active time per entity
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Luben Tuikov <luben.tuikov@amd.com>,
        Danilo Krummrich <dakr@redhat.com>, daniel@ffwll.ch,
        Dave Airlie <airlied@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Date:   Thu, 06 Apr 2023 17:58:16 +0200
In-Reply-To: <3215dfb9-8f7f-625f-44a9-85320cd32019@amd.com>
References: <3e00d8a9-b6c4-8202-4f2d-5a659c61d094@redhat.com>
         <2a84875dde6565842aa07ddb96245b7d939cb4fd.camel@pengutronix.de>
         <8b28151c-f2db-af3f-8dff-87dd5d57417b@amd.com>
         <c952a63a2c0c7377e1e15b1d06c1a941f3456d60.camel@pengutronix.de>
         <3215dfb9-8f7f-625f-44a9-85320cd32019@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, dem 05.04.2023 um 16:44 -0400 schrieb Luben Tuikov:
> On 2023-04-05 13:44, Lucas Stach wrote:
> > Hi Luben,
> > 
> > Am Dienstag, dem 04.04.2023 um 00:31 -0400 schrieb Luben Tuikov:
> > > On 2023-03-28 04:54, Lucas Stach wrote:
> > > > Hi Danilo,
> > > > 
> > > > Am Dienstag, dem 28.03.2023 um 02:57 +0200 schrieb Danilo Krummrich:
> > > > > Hi all,
> > > > > 
> > > > > Commit df622729ddbf ("drm/scheduler: track GPU active time per entity") 
> > > > > tries to track the accumulated time that a job was active on the GPU 
> > > > > writing it to the entity through which the job was deployed to the 
> > > > > scheduler originally. This is done within drm_sched_get_cleanup_job() 
> > > > > which fetches a job from the schedulers pending_list.
> > > > > 
> > > > > Doing this can result in a race condition where the entity is already 
> > > > > freed, but the entity's newly added elapsed_ns field is still accessed 
> > > > > once the job is fetched from the pending_list.
> > > > > 
> > > > > After drm_sched_entity_destroy() being called it should be safe to free 
> > > > > the structure that embeds the entity. However, a job originally handed 
> > > > > over to the scheduler by this entity might still reside in the 
> > > > > schedulers pending_list for cleanup after drm_sched_entity_destroy() 
> > > > > already being called and the entity being freed. Hence, we can run into 
> > > > > a UAF.
> > > > > 
> > > > Sorry about that, I clearly didn't properly consider this case.
> > > > 
> > > > > In my case it happened that a job, as explained above, was just picked 
> > > > > from the schedulers pending_list after the entity was freed due to the 
> > > > > client application exiting. Meanwhile this freed up memory was already 
> > > > > allocated for a subsequent client applications job structure again. 
> > > > > Hence, the new jobs memory got corrupted. Luckily, I was able to 
> > > > > reproduce the same corruption over and over again by just using 
> > > > > deqp-runner to run a specific set of VK test cases in parallel.
> > > > > 
> > > > > Fixing this issue doesn't seem to be very straightforward though (unless 
> > > > > I miss something), which is why I'm writing this mail instead of sending 
> > > > > a fix directly.
> > > > > 
> > > > > Spontaneously, I see three options to fix it:
> > > > > 
> > > > > 1. Rather than embedding the entity into driver specific structures 
> > > > > (e.g. tied to file_priv) we could allocate the entity separately and 
> > > > > reference count it, such that it's only freed up once all jobs that were 
> > > > > deployed through this entity are fetched from the schedulers pending list.
> > > > > 
> > > > My vote is on this or something in similar vain for the long term. I
> > > > have some hope to be able to add a GPU scheduling algorithm with a bit
> > > > more fairness than the current one sometime in the future, which
> > > > requires execution time tracking on the entities.
> > > 
> > > Danilo,
> > > 
> > > Using kref is preferable, i.e. option 1 above.
> > > 
> > > Lucas, can you shed some light on,
> > > 
> > > 1. In what way the current FIFO scheduling is unfair, and
> > > 2. shed some details on this "scheduling algorithm with a bit
> > > more fairness than the current one"? 
> > 
> > I don't have a specific implementation in mind yet. However the current
> > FIFO algorithm can be very unfair if you have a sparse workload compete
> > with one that generates a lot of jobs without any throttling aside from
> > the entity queue length.
> 
> Ah, that's interesting, let's see, a "sparse workload compete with one that
> generates a lot of jobs", so basically we have a sparse workload compete
> with a dense workload. So we can represent this with two entities, A, B,
> whose jobs we're going to represent by the entities, names A and B.
> So if we let A be the sparse workload and B the dense workload,
> we have this, wlog,
> 
>       First/oldest job, .........................., latter/new jobs.
> Subm: A, B, B, B, B, B, A, B, B, B, B, B, A, B, B, B, B, B, A, ...
> Time: t0,t1,t2,t3,t4,t5,t6,t7,t8,t9, .....
> 
> The current FIFO algorithm, would prefer to execute those jobs
> in order of submission, i.e. oldest-ready-first job. Assume
> that all jobs are ready. Then we'll execute them in order.
> This is desirable and fair. We want to execute the jobs
> in the order they were submitted, given also that they are
> ready to be executed. So perhaps we want to execute them like this:
> 
>       First/oldest job, .........................., latter/new jobs.
> Subm: A, B, B, B, B, B, A, B, B, B, B, B, A, B, B, B, B, B, A, ...
> Time: t0,t1,t2,t3,t4,t5,t6,t7,t8,t9, ....
> Exec:          A, B, B, B, B, B, A, B, B, B, B, B, A, B, B, B, B, B, A, ...   
> 
> Any other ordering would starve either A, or B. If we executed the 2nd A
> job at t6 or t7, then that would starve the 3rd/4th job in B, since the 2nd A job
> arrives at the same time as that of the 3rd B job, at time t6.
> The time t3-t0 is some delta > 0, some initial scheduler-start up time.
> 
For simplicity now also assume that all jobs from A take 5ms of GPU
time, while jobs from B take 50ms of GPU time.

> IOW, we don't want to delay a job any more than it should wait--the oldest
> job, which is also ready, should execute next, so that we're fair how
> it executes in real time. We cannot boot B at t6, so that we execute A,
> just because it is sparse, but just arrived.
> 
> From A's point of view, it shouldn't expect its job execution time distribution
> to be any different than its submission time distribution.
> 
> Do you think there's a job permutation which offers a fairer scheduling
> than the Exec line above for the Submission line above?
> 
Yes, if we try to keep some fairness of actual GPU time made available
to each entity by tracking the time spent over a sampling interval, we
would see that at t6 B has already spent 100ms of GPU time, while A has
only spent 5ms, so naturally we would prefer the newly submitted job
from entity A when choosing the next job to schedule.

> > By tracking the actual GPU time consumed by
> > the entities we could implement something with a bit more fairness like
> > deficit round robin (don't pin me on the specific algorithm, as I
> > haven't given it much thought yet).
> 
> Since there's no preemption, this would be hard to achieve--you're at the mercy
> of the execution time of job A_i for an entity A job i. (Assuming there's no
> preemption as it is the current state of the GPU scheduler.)
> 
> The only thing you can do, is punish the next job from this entity, A_i+1,
> to execute much later. However, you don't know how long A_i+1 would take. If A_i+1
> takes very little time, then you're better off executing it at the next opportune
> time, i.e. when it would normally execute. But such an algorithm, which doesn't
> know a priori the execution time of a job, would punish A_i+1 to execute much later.
> 
> But if A_i+1 takes time as long or longer than A_i, then punishing it to execute much
> later, would simply delay it, from an observer's point a view, it wouldn't teach
> the context to submit smaller jobs, so that GPU sharing is more fair.

Without preemption we can't really make the scheduling absolutely fair,
but we can still do better than the simple FIFO. If a entity has taken
up a disproportionate amount of GPU time over the last sampling
interval, we can derate it when picking the next job to schedule to
allow other entities to take up more GPU time in the next sampling
interval.

Regards,
Lucas
