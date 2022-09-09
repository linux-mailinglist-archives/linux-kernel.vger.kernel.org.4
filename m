Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0834C5B3A63
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 16:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiIIOHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 10:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiIIOGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 10:06:16 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9621475C7
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 07:04:16 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id z23so1977669ljk.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 07:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=HTiwWhAENNhIdLAnL0q1JuTZt3PgfN9bElkee4uC7PM=;
        b=fp9SeIEauOO6gv+bXrgAEGstp67oasZqo97ba10K89jiblfRCJKkRtqAhDdHq7ux3+
         bgtec+hVMUKvJhHWbaSkMUN0qnPxHQtA9U2qlBAygm+FvnCtbMLxp5Oqvri9y+KqDXHH
         yWpjFdYMeVWl3tFEaCQZwGMJUZyXMIg8mvf7Eo27KfAFL3K9eM/JkT6jEZH653Lw9Kt7
         onA8t6bG2Kd+7H//eaahCzr3Uf+T6m8+P+GXedU7M8G3bJtzttE9mXWV1zIqCQgtfRTO
         RCKi5cxpN0XpmJwB8J/5T0loAKzozsx/sjhFkvnFNDQniOkSms/In4bstTiYXefgz8kT
         yzsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=HTiwWhAENNhIdLAnL0q1JuTZt3PgfN9bElkee4uC7PM=;
        b=WeZHGAm/rAJ6YhQBYNmMPAdX3Z/sNEmt/F1+nTM1KuYjlu/OTHMsbbBtCivvEl2Fhy
         zArjTBQLOUAjhOzOxBYaXg1n6TvWWezyeNl9xAVHGu7D0iDF6PO+YU1Bf74Fl+0+B0ih
         louiHklVbWUZZUFJlM0TuJOq3ySRssUB4U9j/imwP84nJtfjG8lKZR1WhwQc9rBoUlPc
         QIRdrdio1vjuAJ7mVeycIHdQHGuhdE7pp3ZCDMRINu9kdQH1tA88kb9tEWvquiXXGud5
         97N2cEUqLvgVV5rMCilqvbPwN+qJ7/vgmf+Dh0d4jMUd/3SAQ3wM4L3np6/jJLNpF0e4
         yWEA==
X-Gm-Message-State: ACgBeo1zz/UzFChO5jrJpooQrKqN1+VVOimmIwsoto8AF0HWuBSaYU20
        hI87/06FjQqbImJ1NIeLyfDaGgLrCniWFim6JAQTjw==
X-Google-Smtp-Source: AA6agR7RBA9XwnQM5IKRnQ3zR1VpLxmB/kqlLu/OeejID0BHrlgvln7NMOT9Fn4QicXBD8nFwzPphRVgW0OVfA323cQ=
X-Received: by 2002:a05:651c:23b:b0:26a:66fe:47e6 with SMTP id
 z27-20020a05651c023b00b0026a66fe47e6mr3822438ljn.17.1662732223154; Fri, 09
 Sep 2022 07:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220825122726.20819-1-vincent.guittot@linaro.org>
 <20220825122726.20819-5-vincent.guittot@linaro.org> <Yxsf/5ErmVoKFucb@hirez.programming.kicks-ass.net>
In-Reply-To: <Yxsf/5ErmVoKFucb@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri, 9 Sep 2022 16:03:31 +0200
Message-ID: <CAKfTPtAo=PzN1MDyqGW17zimxYLE08TMFMAhhY6YuGNBvvfusw@mail.gmail.com>
Subject: Re: [PATCH 4/4] sched/fair: limit sched slice duration
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, zhangqiao22@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 Sept 2022 at 13:14, Peter Zijlstra <peterz@infradead.org> wrote:
>
>
> Picked up the first three.
>
> On Thu, Aug 25, 2022 at 02:27:26PM +0200, Vincent Guittot wrote:
> > In presence of a lot of small weight tasks like sched_idle tasks, normal
> > or high weight tasks can see their ideal runtime (sched_slice) to increase
> > to hundreds ms whereas it normally stays below sysctl_sched_latency.
> >
> > 2 normal tasks running on a CPU will have a max sched_slice of 12ms
> > (half of the sched_period). This means that they will make progress
> > every sysctl_sched_latency period.
> >
> > If we now add 1000 idle tasks on the CPU, the sched_period becomes
>
> Surely people aren't actually having that many runnable tasks and this
> is a device for the argument?
>
> > 3006 ms and the ideal runtime of the normal tasks becomes 609 ms.
> > It will even become 1500ms if the idle tasks belongs to an idle cgroup.
> > This means that the scheduler will look for picking another waiting task
> > after 609ms running time (1500ms respectively). The idle tasks change
> > significantly the way the 2 normal tasks interleave their running time
> > slot whereas they should have a small impact.
> >
> > Such long sched_slice can delay significantly the release of resources
> > as the tasks can wait hundreds of ms before the next running slot just
> > because of idle tasks queued on the rq.
> >
> > Cap the ideal_runtime to sysctl_sched_latency when comparing to the next
> > waiting task to make sure that tasks will regularly make progress and will
> > not be significantly impacted by idle/background tasks queued on the rq.
> >
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >
> > While studying the problem, I have also considered to substract
> > cfs.idle_h_nr_running before computing the sched_slice but we can have
> > quite similar problem with low weight bormal task/cgroup so I have decided
> > to keep this solution.
>
> That ^... my proposal below has the same problem.
>
> This:
>
> > Also, this solution doesn't completly remove the impact of idle tasks
> > in the scheduling pattern but cap the running slice of a task to a max
> > value of 2*sysctl_sched_latency.
>
> I'm failing to see how.

The 1st part of  check_preempt_tick ensures that we wait at least
sysctl_sched_min_granularity but not more than ideal_runtime before
possibly picking another entity.

Once both conditions above tested, we check that the vruntime diff
with the 1st pending entity is not larger than a sysctl_sched_latency.

Normally sched_slice should return an ideal_runtime value less than
sysctl_sched_latency. But we also want to provide a minimum runtime to
all tasks  so we increase the sched_period when the number of tasks
increases too much.

The case described above is a corner case because of the large
difference between the tasks' prio.

Now, let assume that we have only 1 normal task and 1000 idle tasks, I
don't see any problem with providing a large ideal runtime for this
normal task. The problem comes when you have at least 2 normal tasks
as we don't expect the other normal task to wait for several hundreds
of ms before running.

That's why the comparison is done against the diff of vruntime; idle
task running for a 4ms tick will increase its vruntime with + 1366ms
which is comparable with the slice duration of the normal task. On the
other side, a 4ms tick will increase the vruntime of a nice 0 task to
4ms only. So the vruntime diff will quickly move above the
sysctl_sched_latency.

That being said, it doesn't completely fix the case of 2 nice -20 task runnings

>
> >  kernel/sched/fair.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 260a55ac462f..96fedd0ab5fa 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4599,6 +4599,8 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> >       if (delta < 0)
> >               return;
>
> (I'm thinking that early return is a bit pointless, a negative value
> won't be larger than ideal_time anyway)

yes

>
> > +     ideal_runtime =  min_t(u64, ideal_runtime, sysctl_sched_latency);
> > +
>
> (superfluous whitespace -- twice, once after the = once this whole extra
> line)

sorry for that...

>
> >       if (delta > ideal_runtime)
> >               resched_curr(rq_of(cfs_rq));
> >  }
>
> Urgghhhh..
>
> so delta is in vtime here, while sched_latency is not, so the heavier
> the queue, the larger this value becomes.
>
> Given those 1000 idle tasks, rq-weight would be around 2048; however due
> to nr_running being insane, sched_slice() ends up being something like:

rq weight will be 1000*3+2*1024=5048
sched_period becomes 1002 * min_gran = 3006ms

idle task got a slice of weight(3) * (1002 min_gran) / 5048 =
3002/5048 * min_gran

normal task got a slice of weight(1024) * (1002 min_gran) / 5048 =
1024*1002*5048 * min_gran ~ 200 min_gran

if the 1000 task are in a idle sched group, that even worth because
the rq weight decrease to 3+2*1024 = 2051 and the slice increase to
500 min_gran

note that if we use 2 tasks nice -20 and 1000 tasks with nice 19 we
have similar slice duration (around 500 min_gran) so we can't really
rely on idle_nr_running

>
>   1000 * min_gran * 2 / 2048
>
> which is around ~min_gran and so won't come near to latency.
>
>
> since we already have idle_min_gran; how about something like this?

the idl_min gran will divide by 4 the sched_slice which can still
remain quite high

The main problem with my proposal is that task with negative nice prio
can still get larger sched_slice because vruntime increases slower
than  real time

>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index efceb670e755..8dd18fc0affa 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -706,12 +706,14 @@ static inline u64 calc_delta_fair(u64 delta, struct sched_entity *se)
>   *
>   * p = (nr <= nl) ? l : l*nr/nl
>   */
> -static u64 __sched_period(unsigned long nr_running)
> +static u64 __sched_period(unsigned long nr_running, unsigned long nr_idle)
>  {
> -       if (unlikely(nr_running > sched_nr_latency))
> -               return nr_running * sysctl_sched_min_granularity;
> -       else
> -               return sysctl_sched_latency;
> +       u64 period = 0;
> +
> +       period += nr_running * sysctl_sched_min_granularity;
> +       period += nr_idle    * sysctl_sched_idle_min_granularity;
> +
> +       return max_t(u64, period, sysctl_sched_latency);
>  }
>
>  static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
> @@ -724,15 +726,25 @@ static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq);
>   */
>  static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
>  {
> -       unsigned int nr_running = cfs_rq->nr_running;
> +       unsigned int nr_idle = cfs_rq->idle_nr_running;
> +       unsigned int nr_running = cfs_rq->nr_running - nr_idle;
>         struct sched_entity *init_se = se;
>         unsigned int min_gran;
>         u64 slice;
>
> -       if (sched_feat(ALT_PERIOD))
> -               nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
> +       if (sched_feat(ALT_PERIOD)) {
> +               nr_idle = rq_of(cfs_rq)->cfs.idle_h_nr_running;
> +               nr_running = rq_of(cfs_rq)->cfs.h_nr_running - nr_idle;
> +       }
> +
> +       if (!se->on_rq) {
> +               if (se_is_idle(se))
> +                       nr_idle++;
> +               else
> +                       nr_running++;
> +       }
>
> -       slice = __sched_period(nr_running + !se->on_rq);
> +       slice = __sched_period(nr_running, nr_idle);
>
>         for_each_sched_entity(se) {
>                 struct load_weight *load;
>
>
> This changes how the compute the period depending on the composition. It
> suffers the exact same problem you had earlier though in that it doesn't
> work for the other low-weight cases. But perhaps we can come up with a
> better means of computing the period that *does* consider them?
>
> As said before;... urgh! bit of a sticky problem this.
