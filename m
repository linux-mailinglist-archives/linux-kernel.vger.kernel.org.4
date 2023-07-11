Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287E474FAA4
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 00:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230399AbjGKWHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 18:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbjGKWHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 18:07:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCDFD170C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:07:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b9ed206018so28965ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 15:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689113234; x=1691705234;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/QjR+lZ864ZFzmJMbUUnn6oahTKgJfGFGgUoOrMYsLw=;
        b=dRUgT5cnj7i7FgOr1y1M84S0fqCOeac+Yy3Sr4+P2W7s+NvI0rxTBCAV/9tvydIpHD
         pjGvGY99PMog/8sDL2vYdgwTnp/F0bqhqiDIefUfxH39lSfHHKW6I7ici+n+L6ST/zmf
         DMLmvi/bDUYrep0qc++G5pcSrXJsJMO77ibmBn2sQSou/Dpm9CcHLcJHLt8DbV7ugm8f
         NlpmbwKMAxBKmcjCiLjJtX1V9iKmc7jiqnPZCNg47e5dtUSnY7Y7EPivUOHHZUrj8wnM
         LjUF6ZelmQu5CoRsxQ+qVhSUkLIQfhWh20VJ5GJHyvmChegVgK5w+Ep9LZDzPRwojKpT
         Idow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689113234; x=1691705234;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/QjR+lZ864ZFzmJMbUUnn6oahTKgJfGFGgUoOrMYsLw=;
        b=bI4n8cweObTDkZjtQAtHjU+Qqrfqvh4kEPA0uxQOYXhc28fGzOsKpEbM+rpNZE30iG
         5RA0Ja3w2EeElnFhFgsEkE3W372ybNJBilShVaDXXALI88XGiSwFZKDd+g7GHY1B4nXm
         LR7VwslHh92hDqdlG/4XL2U9jfrYgi6h9UZWHIN8uT3yR5COW+bnW/xqpK3Z6rGqa948
         3gBiS4Vx/sd9SVVGXN+T0OjVq1WpiS20HKWO5Lj64Ez8gJoZzJvQCNposuPuQ7vnUDE3
         8yLq02Puxpv22t4om4kxQmK+2ApUjia+nQkvZPtbDX39EirZR63q4VCy8HLyLEi6dHiy
         ke9A==
X-Gm-Message-State: ABy/qLauiGQFXNPZD51JVQ28m95Y7PzYfv0dKLUaMvHP5hov1rhmIa1u
        SyiY1S5TG36LD2ArTYXgAsqh70lovtIEMP/WeSK9gm+C
X-Google-Smtp-Source: APBJJlGcwV/FbvZbXiBPKTHfpapWxwwWYSwz/bKu4qmF2h6Culy+tqb6JZyMixAmBp1iWe1Nw9qS+A==
X-Received: by 2002:a17:903:22c7:b0:1b9:d96c:bca7 with SMTP id y7-20020a17090322c700b001b9d96cbca7mr22514plg.25.1689113234205;
        Tue, 11 Jul 2023 15:07:14 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id gk15-20020a17090b118f00b00263c8b33bcfsm2348028pjb.14.2023.07.11.15.07.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 15:07:13 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 2/2] Sched/fair: Block nohz tick_stop when cfs
 bandwidth in use
References: <20230707195748.2918490-1-pauld@redhat.com>
        <20230707195748.2918490-3-pauld@redhat.com>
        <xm26lefnfhkd.fsf@google.com>
        <20230711131024.GA150804@lorien.usersys.redhat.com>
        <20230711141210.GC150804@lorien.usersys.redhat.com>
Date:   Tue, 11 Jul 2023 15:07:12 -0700
In-Reply-To: <20230711141210.GC150804@lorien.usersys.redhat.com> (Phil Auld's
        message of "Tue, 11 Jul 2023 10:12:10 -0400")
Message-ID: <xm26cz0yf6gf.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> On Tue, Jul 11, 2023 at 09:10:24AM -0400 Phil Auld wrote:
>> On Mon, Jul 10, 2023 at 04:54:58PM -0700 Benjamin Segall wrote:
>> > Phil Auld <pauld@redhat.com> writes:
>> > 
>> > > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
>> > > can easily run well past their quotas before a remote tick does
>> > > accounting.  This leads to long, multi-period stalls before such
>> > > tasks can run again. Currently, when presented with these conflicting
>> > > requirements the scheduler is favoring nohz_full and letting the tick
>> > > be stopped. However, nohz tick stopping is already best-effort, there
>> > > are a number of conditions that can prevent it, whereas cfs runtime
>> > > bandwidth is expected to be enforced.
>> > >
>> > > Make the scheduler favor bandwidth over stopping the tick by setting
>> > > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
>> > > runtime limit enabled. We use cfs_b->hierarchical_quota to
>> > > determine if the task requires the tick.
>> > >
>> > > Add check in pick_next_task_fair() as well since that is where
>> > > we have a handle on the task that is actually going to be running.
>> > >
>> > > Add check in sched_can_stop_tick() to cover some edge cases such 
>> > > as nr_running going from 2->1 and the 1 remains the running task.
>> > >
>> > > Add sched_feat HZ_BW (off by default) to control the tick_stop
>> > > behavior.
>> > >
>> > > Signed-off-by: Phil Auld <pauld@redhat.com>
>> > > Cc: Ingo Molnar <mingo@redhat.com>
>> > > Cc: Peter Zijlstra <peterz@infradead.org>
>> > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> > > Cc: Juri Lelli <juri.lelli@redhat.com>
>> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> > > Cc: Valentin Schneider <vschneid@redhat.com>
>> > > Cc: Ben Segall <bsegall@google.com>
>> > > Cc: Frederic Weisbecker <frederic@kernel.org>
>> > > ---
>> > >  kernel/sched/core.c     | 12 ++++++++++
>> > >  kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
>> > >  kernel/sched/features.h |  2 ++
>> > >  kernel/sched/sched.h    |  1 +
>> > >  4 files changed, 64 insertions(+)
>> > >
>> > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > > index 1b214e10c25d..4b8534abdf4f 100644
>> > > --- a/kernel/sched/core.c
>> > > +++ b/kernel/sched/core.c
>> > > @@ -1229,6 +1229,18 @@ bool sched_can_stop_tick(struct rq *rq)
>> > >  	if (rq->nr_running > 1)
>> > >  		return false;
>> > >  
>> > > +	/*
>> > > +	 * If there is one task and it has CFS runtime bandwidth constraints
>> > > +	 * and it's on the cpu now we don't want to stop the tick.
>> > > +	 * This check prevents clearing the bit if a newly enqueued task here is
>> > > +	 * dequeued by migrating while the constrained task continues to run.
>> > > +	 * E.g. going from 2->1 without going through pick_next_task().
>> > > +	 */
>> > > +	if (sched_feat(HZ_BW) && rq->nr_running == 1 && task_on_rq_queued(rq->curr)) {
>> > > +		if (cfs_task_bw_constrained(rq->curr))
>> > > +			return false;
>> > > +	}
>> > > +
>> > 
>> > I think we still need the fair_sched_class check with the bit being on
>> > cfs_rq/tg rather than task.
>> > 
>> 
>> Is there a way a non-fair_sched_class task will be in a cfs_rq with
>> cfs_rq->runtime_enabled and/or cfs_b->hierarchical_quota set to non
>> RUNTIME_INF?  I suppose if they are stale and it's had its class changed?
>> 
>> That makes the condition pretty ugly but I can add that back if needed.
>> 
>
> Sigh, yeah. I took that out when I had the bit in the task. I'll put it
> back in...
>

Yeah, cfs_rq (and rt_rq) are set unconditionally, and a cgroup can have
a mix of fair and RT tasks (whether or not that's a good idea from a
sysadmin perspective).
