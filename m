Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6A05B3B6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 17:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiIIPFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 11:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbiIIPFI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 11:05:08 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACB4D4623F
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 08:05:05 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id k9so3308841wri.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 08:05:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date;
        bh=wwdNPBNq11muSI4+KJ+PrnASzZFLFN3y0ScHNoYEb1k=;
        b=Wb4JDdN14YlJX/7ReXZe0Q/TJ+q3xlRuaW7Kyff513X2OnwZ5UCt7Sn45Dr/IzzkCu
         /Qqg0yC52x0Z2xDJhJNtPsizrDYZzXPjbKHqYqsbNZRxnna+D83naaYuPKO5tclXEXbA
         fFeTMqEqbMjEi5J4bl+DKx4Hgmori09Lw+/c/Fzg2FOL+L/VcLy9xSGUb5Nqo86KEAoz
         M2J6RR9UpT2B5yMjrHM0GonmkF5USaTdxQwmxaXAOQlnmT2Pdac9JkzmK/KgSYy337LU
         19qUdCSgLQrpFf2yO4PmWEEuyvzr88331a2ovxKP57+6TQtLyEDpq5JI7hEcgkR7jyjh
         KwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-transfer-encoding
         :content-disposition:mime-version:references:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=wwdNPBNq11muSI4+KJ+PrnASzZFLFN3y0ScHNoYEb1k=;
        b=NiqzEcfRz4nVmUx378QFPovg7MEy+AAx0RE6wFSSTiubgW11IO6fHvCVMwzP4I+a7u
         FT6ByveBz/DJWrRoCER0/QIH4EorUSUZsQcxEpqBG255zvXwVfnx91EArWtoVSZYcA/K
         DhL2ithLlNogS2I1N+uu7nfbxz5N2O53Hu16yUvAhywoST4iNsszrl6yt4kLeLgcDTtx
         s0DLiF0yK13xG4LoMcJnt/FIgpWjIu6lxuo2yybOl7N+GgOUreIIcYiFn88CRPqOqVsa
         Y6fINfsdlVg/+ovjYoTcVOHIggi3fym2tVuktLlqSTcWelzbEdL4BSPUErO7FDTRzXXW
         rzjA==
X-Gm-Message-State: ACgBeo1T17GW5RjNjfbhjEH+UZtgPPJpILtNoZEu31Ev0V+XiBUIR36G
        cgUYgdGY2P6dg38AGwd62qC8kg==
X-Google-Smtp-Source: AA6agR51SmOpuMTeoIXaqbpdtv8avSjd1HF/AYCmDm4Grjj7JJqsKSdxbuTDKx0wZw1GVmBlNBVrqw==
X-Received: by 2002:adf:e7c2:0:b0:228:8733:3a6d with SMTP id e2-20020adfe7c2000000b0022887333a6dmr8110265wrn.215.1662735904170;
        Fri, 09 Sep 2022 08:05:04 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:c6e:e86:ab92:92b7])
        by smtp.gmail.com with ESMTPSA id i11-20020adfb64b000000b00228df23bd51sm693382wre.82.2022.09.09.08.05.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Sep 2022 08:05:03 -0700 (PDT)
Date:   Fri, 9 Sep 2022 17:05:01 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Subject: Re: [PATCH 4/4] sched/fair: limit sched slice duration
Message-ID: <20220909150501.GA10697@vingu-book>
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-5-vincent.guittot@linaro.org>
 <Yxsf/5ErmVoKFucb@hirez.programming.kicks-ass.net>
 <CAKfTPtAo=PzN1MDyqGW17zimxYLE08TMFMAhhY6YuGNBvvfusw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKfTPtAo=PzN1MDyqGW17zimxYLE08TMFMAhhY6YuGNBvvfusw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le vendredi 09 sept. 2022 à 16:03:31 (+0200), Vincent Guittot a écrit :
> On Fri, 9 Sept 2022 at 13:14, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> >
> > Picked up the first three.
> >
> > On Thu, Aug 25, 2022 at 02:27:26PM +0200, Vincent Guittot wrote:
> > > In presence of a lot of small weight tasks like sched_idle tasks, normal
> > > or high weight tasks can see their ideal runtime (sched_slice) to increase
> > > to hundreds ms whereas it normally stays below sysctl_sched_latency.
> > >
> > > 2 normal tasks running on a CPU will have a max sched_slice of 12ms
> > > (half of the sched_period). This means that they will make progress
> > > every sysctl_sched_latency period.
> > >
> > > If we now add 1000 idle tasks on the CPU, the sched_period becomes
> >
> > Surely people aren't actually having that many runnable tasks and this
> > is a device for the argument?
> >
> > > 3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
> > > It will even become 1500ms if the idle tasks belongs to an idle cgroup.
> > > This means that the scheduler will look for picking another waiting task
> > > after 609ms running time (1500ms respectively). The idle tasks change
> > > significantly the way the 2 normal tasks interleave their running time
> > > slot whereas they should have a small impact.
> > >
> > > Such long sched_slice can delay significantly the release of resources
> > > as the tasks can wait hundreds of ms before the next running slot just
> > > because of idle tasks queued on the rq.
> > >
> > > Cap the ideal_runtime to sysctl_sched_latency when comparing to the next
> > > waiting task to make sure that tasks will regularly make progress and will
> > > not be significantly impacted by idle/background tasks queued on the rq.
> > >
> > > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > > ---
> > >
> > > While studying the problem, I have also considered to substract
> > > cfs.idle_h_nr_running before computing the sched_slice but we can have
> > > quite similar problem with low weight bormal task/cgroup so I have decided
> > > to keep this solution.
> >
> > That ^... my proposal below has the same problem.
> >
> > This:
> >
> > > Also, this solution doesn't completly remove the impact of idle tasks
> > > in the scheduling pattern but cap the running slice of a task to a max
> > > value of 2*sysctl_sched_latency.
> >
> > I'm failing to see how.
> 
> The 1st part of  check_preempt_tick ensures that we wait at least
> sysctl_sched_min_granularity but not more than ideal_runtime before
> possibly picking another entity.
> 
> Once both conditions above tested, we check that the vruntime diff
> with the 1st pending entity is not larger than a sysctl_sched_latency.
> 
> Normally sched_slice should return an ideal_runtime value less than
> sysctl_sched_latency. But we also want to provide a minimum runtime to
> all tasks  so we increase the sched_period when the number of tasks
> increases too much.
> 
> The case described above is a corner case because of the large
> difference between the tasks' prio.
> 
> Now, let assume that we have only 1 normal task and 1000 idle tasks, I
> don't see any problem with providing a large ideal runtime for this
> normal task. The problem comes when you have at least 2 normal tasks
> as we don't expect the other normal task to wait for several hundreds
> of ms before running.
> 
> That's why the comparison is done against the diff of vruntime; idle
> task running for a 4ms tick will increase its vruntime with + 1366ms
> which is comparable with the slice duration of the normal task. On the
> other side, a 4ms tick will increase the vruntime of a nice 0 task to
> 4ms only. So the vruntime diff will quickly move above the
> sysctl_sched_latency.
> 
> That being said, it doesn't completely fix the case of 2 nice -20 task runnings
> 
> >
> > >  kernel/sched/fair.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 260a55ac462f..96fedd0ab5fa 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4599,6 +4599,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > >       if (delta < 0)
> > >               return;
> >
> > (I'm thinking that early return is a bit pointless, a negative value
> > won't be larger than ideal_time anyway)
> 
> yes
> 
> >
> > > +     ideal_runtime =  min_t(u64, ideal_runtime, sysctl_sched_latency);
> > > +

scaling sysctl_sched_latency with curr weight should fix the problem for high prio task

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4599,7 +4599,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
        if (delta < 0)
                return;
 
-       ideal_runtime =  min_t(u64, ideal_runtime, sysctl_sched_latency);
+       ideal_runtime =  min_t(u64, ideal_runtime,
+                                   calc_delta_fair(sysctl_sched_latency, curr));
 
        if (delta > ideal_runtime)
                resched_curr(rq_of(cfs_rq));



> >
> > (superfluous whitespace -- twice, once after the = once this whole extra
> > line)
> 
> sorry for that...
> 
> >
> > >       if (delta > ideal_runtime)
> > >               resched_curr(rq_of(cfs_rq));
> > >  }
> >
> > Urgghhhh..
> >
> > so delta is in vtime here, while sched_latency is not, so the heavier
> > the queue, the larger this value becomes.
> >
> > Given those 1000 idle tasks, rq-weight would be around 2048; however due
> > to nr_running being insane, sched_slice() ends up being something like:
> 
> rq weight will be 1000*3+2*1024=5048
> sched_period becomes 1002 * min_gran = 3006ms
> 
> idle task got a slice of weight(3) * (1002 min_gran) / 5048 =
> 3002/5048 * min_gran
> 
> normal task got a slice of weight(1024) * (1002 min_gran) / 5048 =
> 1024*1002*5048 * min_gran ~ 200 min_gran
> 
> if the 1000 task are in a idle sched group, that even worth because
> the rq weight decrease to 3+2*1024 = 2051 and the slice increase to
> 500 min_gran
> 
> note that if we use 2 tasks nice -20 and 1000 tasks with nice 19 we
> have similar slice duration (around 500 min_gran) so we can't really
> rely on idle_nr_running
> 
> >
> >   1000 * min_gran * 2 / 2048
> >
> > which is around ~min_gran and so won't come near to latency.
> >
> >
> > since we already have idle_min_gran; how about something like this?
> 
> the idl_min gran will divide by 4 the sched_slice which can still
> remain quite high
> 
> The main problem with my proposal is that task with negative nice prio
> can still get larger sched_slice because vruntime increases slower
> than  real time
> 
> >
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index efceb670e755..8dd18fc0affa 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -706,12 +706,14 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
> >   *
> >   * p = (nr <= nl) ? l : l*nr/nl
> >   */
> > -static u64 __sched_period(unsigned long nr_running)
> > +static u64 __sched_period(unsigned long nr_running, unsigned long nr_idle)
> >  {
> > -       if (unlikely(nr_running > sched_nr_latency))
> > -               return nr_running * sysctl_sched_min_granularity;
> > -       else
> > -               return sysctl_sched_latency;
> > +       u64 period = 0;
> > +
> > +       period += nr_running * sysctl_sched_min_granularity;
> > +       period += nr_idle    * sysctl_sched_idle_min_granularity;
> > +
> > +       return max_t(u64, period, sysctl_sched_latency);
> >  }
> >
> >  static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
> > @@ -724,15 +726,25 @@ static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
> >   */
> >  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
> >  {
> > -       unsigned int nr_running = cfs_rq->nr_running;
> > +       unsigned int nr_idle = cfs_rq->idle_nr_running;
> > +       unsigned int nr_running = cfs_rq->nr_running - nr_idle;
> >         struct sched_entity *init_se = se;
> >         unsigned int min_gran;
> >         u64 slice;
> >
> > -       if (sched_feat(ALT_PERIOD))
> > -               nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
> > +       if (sched_feat(ALT_PERIOD)) {
> > +               nr_idle = rq_of(cfs_rq)->cfs.idle_h_nr_running;
> > +               nr_running = rq_of(cfs_rq)->cfs.h_nr_running - nr_idle;
> > +       }
> > +
> > +       if (!se->on_rq) {
> > +               if (se_is_idle(se))
> > +                       nr_idle++;
> > +               else
> > +                       nr_running++;
> > +       }
> >
> > -       slice = __sched_period(nr_running + !se->on_rq);
> > +       slice = __sched_period(nr_running, nr_idle);
> >
> >         for_each_sched_entity(se) {
> >                 struct load_weight *load;
> >
> >
> > This changes how the compute the period depending on the composition. It
> > suffers the exact same problem you had earlier though in that it doesn't
> > work for the other low-weight cases. But perhaps we can come up with a
> > better means of computing the period that *does* consider them?
> >
> > As said before;... urgh! bit of a sticky problem this.
