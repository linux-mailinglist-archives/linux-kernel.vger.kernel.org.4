Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD426D63DB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235216AbjDDNu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234953AbjDDNu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 09:50:56 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5B7101
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 06:50:53 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id cn12so28202483qtb.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 06:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1680616252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uAemJB9AYv7ntFQDcoxLkRGzoNUZzlSqsw0pxvVXNfg=;
        b=x7StyDfRBY2FU7Vdkq0UbK1RLu2DwdcVlVGJtWnlyT1CpjJOx5m0Eb/EOVMbiZvOLv
         EDS6ILhmwYiWXDqmQuCuMd5uSXyzWBqAKJvNbYVKa9+dA317OqgpcK6GIyGqPrHotiy3
         fBiDXjpVFWYc/QXL95ZnbobufX0HBithd/dWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680616252;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uAemJB9AYv7ntFQDcoxLkRGzoNUZzlSqsw0pxvVXNfg=;
        b=30Addyi32ulNc7vfIhgq6ygyJ/sTMC/Ihe2JXD0bSNOV6Ud5NanfkCLxRmnpwYDYYq
         Vj6MifbnYa0yMattOYKI0n9vUi9FojVcO4pYWTO0y6IlW/NzdQn4xOLTpWraWtoUA1KC
         q0XGmcnEFQ6EhM/CpO1oKkEjBaFUpaeaVquIwWcTyU4rMRYvJwEw0VnamXBj+31eiBYy
         /xmOYSCoCEHHA9UCV8Kw3KWu3vEumrYf/W3XjSP/UJWbRfQMvjYQqMqHdA4nVHBzoaD1
         rd5fZhSnNSr/twZp3cYgwimsRuqXYwlGRweJnzCaIFRFOvQY4s/C5HOQvAIVdrKJx+4z
         V6FQ==
X-Gm-Message-State: AAQBX9dnksCym7OvDd//aFuzKOmmZgq5Ynll/0gd079TjsmHJzxP1O/C
        MFZmmoqL1hyNzVtWciqNOuHyyQ==
X-Google-Smtp-Source: AKy350ajxCqBQXBxHTQ7+Lda4ZRJNgGw6ZevTKXwfhlW0PN+Tk9WA1A5RDB2g29QJjq+9k099RLmTA==
X-Received: by 2002:ac8:5782:0:b0:3dc:ce21:6f87 with SMTP id v2-20020ac85782000000b003dcce216f87mr3396137qta.11.1680616252252;
        Tue, 04 Apr 2023 06:50:52 -0700 (PDT)
Received: from localhost (129.239.188.35.bc.googleusercontent.com. [35.188.239.129])
        by smtp.gmail.com with ESMTPSA id i25-20020ac860d9000000b003bd0f0b26b0sm3248608qtm.77.2023.04.04.06.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 06:50:51 -0700 (PDT)
Date:   Tue, 4 Apr 2023 13:50:50 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        qyousef@layalina.io, chris.hyser@oracle.com,
        patrick.bellasi@matbug.net, pjt@google.com, pavel@ucw.cz,
        qperret@google.com, tim.c.chen@linux.intel.com, joshdon@google.com,
        timj@gnu.org, kprateek.nayak@amd.com, yu.c.chen@intel.com,
        youssefesmat@chromium.org, efault@gmx.de
Subject: Re: [PATCH 14/17] sched/eevdf: Better handle mixed slice length
Message-ID: <20230404135050.GA471948@google.com>
References: <20230328092622.062917921@infradead.org>
 <20230328110354.562078801@infradead.org>
 <CAKfTPtAkFBw5zt0+WK7dWBUE9OrbOOExG8ueUE6ogdCEQZhpXQ@mail.gmail.com>
 <20230404092936.GD284733@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404092936.GD284733@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 04, 2023 at 11:29:36AM +0200, Peter Zijlstra wrote:
> On Fri, Mar 31, 2023 at 05:26:51PM +0200, Vincent Guittot wrote:
> > On Tue, 28 Mar 2023 at 13:06, Peter Zijlstra <peterz@infradead.org> wrote:
> > >
> > > In the case where (due to latency-nice) there are different request
> > > sizes in the tree, the smaller requests tend to be dominated by the
> > > larger. Also note how the EEVDF lag limits are based on r_max.
> > >
> > > Therefore; add a heuristic that for the mixed request size case, moves
> > > smaller requests to placement strategy #2 which ensures they're
> > > immidiately eligible and and due to their smaller (virtual) deadline
> > > will cause preemption.
> > >
> > > NOTE: this relies on update_entity_lag() to impose lag limits above
> > > a single slice.
> > >
> > > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > > ---
> > >  kernel/sched/fair.c     |   14 ++++++++++++++
> > >  kernel/sched/features.h |    1 +
> > >  kernel/sched/sched.h    |    1 +
> > >  3 files changed, 16 insertions(+)
> > >
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -616,6 +616,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq,
> > >         s64 key = entity_key(cfs_rq, se);
> > >
> > >         cfs_rq->avg_vruntime += key * weight;
> > > +       cfs_rq->avg_slice += se->slice * weight;
> > >         cfs_rq->avg_load += weight;
> > >  }
> > >
> > > @@ -626,6 +627,7 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq,
> > >         s64 key = entity_key(cfs_rq, se);
> > >
> > >         cfs_rq->avg_vruntime -= key * weight;
> > > +       cfs_rq->avg_slice -= se->slice * weight;
> > >         cfs_rq->avg_load -= weight;
> > >  }
> > >
> > > @@ -4832,6 +4834,18 @@ place_entity(struct cfs_rq *cfs_rq, stru
> > >                 lag = se->vlag;
> > >
> > >                 /*
> > > +                * For latency sensitive tasks; those that have a shorter than
> > > +                * average slice and do not fully consume the slice, transition
> > > +                * to EEVDF placement strategy #2.
> > > +                */
> > > +               if (sched_feat(PLACE_FUDGE) &&
> > > +                   cfs_rq->avg_slice > se->slice * cfs_rq->avg_load) {
> > > +                       lag += vslice;
> > > +                       if (lag > 0)
> > > +                               lag = 0;
> > 
> > By using different lag policies for tasks, doesn't this create
> > unfairness between tasks ?
> 
> Possibly, I've just not managed to trigger it yet -- if it is an issue
> it can be fixed by ensuring we don't place the entity before its
> previous vruntime just like the sleeper hack later on.
> 
> > I wanted to stress this situation with a simple use case but it seems
> > that even without changing the slice, there is a fairness problem:
> > 
> > Task A always run
> > Task B loops on : running 1ms then sleeping 1ms
> > default nice and latency nice prio bot both
> > each task should get around 50% of the time.
> > 
> > The fairness is ok with tip/sched/core
> > but with eevdf, Task B only gets around 30%
> > 
> > I haven't identified the problem so far
> 
> Heh, this is actually the correct behaviour. If you have a u=1 and a
> u=.5 task, you should distribute time on a 2:1 basis, eg. 67% vs 33%.

Splitting like that sounds like starvation of the sleeper to me. If something
sleeps a lot, it will get even less CPU time on an average than it would if
there was no contention from the u=1 task.

And also CGroups will be even more weird than it already is in such a world,
2 different containers will not get CPU time distributed properly- say if
tasks in one container sleep a lot and tasks in another container are CPU
bound.

thanks,

 - Joel

