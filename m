Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E50E170E17E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjEWQNE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbjEWQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:12:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6AAE0
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:12:57 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1ae454844edso53230175ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684858377; x=1687450377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MugypaEWsqVMkBOhFeIAf7kskqrSVjGa63FkjyH//es=;
        b=RXo4VzrqphG30UBiPWm3ci/zR3lDMnvwf9U/M7YK7laXZ0kymclTxgLCyLEYZj6kgo
         CW7p7bteKJ/LUIBjcw4kgShaKRqyzojrSpWwGbFVeCX65KDqgL+NwQurnVBQcMbmvQpF
         TDLaJwsOYlBKou8pG1aw3UOKB4FB17fEbJNn4KvSLoMRi4CKAbiAAa3j9SqT2y+TXDQW
         2eSVfhxTutA+VJA+/N/gA160wo8pXH6MAzHA41a5fzZBLNCFvY+g7nPVy0k4n+OtW7tl
         IjbUt7DN6YZWwzpkpK9T8G8eEWP7FWQr1nrWSpwJj+7vACEHJHyj1hmbz3gGpccnWBXR
         L2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684858377; x=1687450377;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MugypaEWsqVMkBOhFeIAf7kskqrSVjGa63FkjyH//es=;
        b=F6A9Xoq0jjFi1fshAT08JQIyT66CFN97bRnEjExAbe8zlU82uf/yVgX5c+QFZff+yc
         kO/WCA57kr4OdDJqYQcbeutP5b69IeuvYL07C9M4q+fn92DCs7ZzJDzSs9z4ebq5C8k+
         aiOdm3nF+/rhRc14sVjbEODPbrp7YeQ9ee+HvkLOemyiDkwgXT0ARPlOkPgaY84a6hyb
         CNoZObXQ3eSeTU29gDF8KR/FF0O/+DTi8SO6+w6K5ssl3q2wmXNAhQ86hEZRrPZX2ndI
         Ax4d7+X/7ToUlWLk0Hz/0YdBJL8fzoN0I5rceS0kyOwkekb2JTcRPCge8STVgEAKiUo7
         /NFw==
X-Gm-Message-State: AC+VfDwuT1BTRyNye1eU7abzc7PU+6oWooJn6bc4ZUWTnLsd2Wr9oQWV
        FDzudjhn0M2bbY4970+hw276PB7FHrN/CQUr0zqxxQ==
X-Google-Smtp-Source: ACHHUZ7Q/7pIzI+w2ld4e+hSMCBTLEruJYZIxDxWmPz7yEx9WvaaAahXfAhEe9tPaYfV2UMsdy3i02eXlfa8uBxhtKE=
X-Received: by 2002:a17:90a:ea94:b0:255:2dfc:6c6f with SMTP id
 h20-20020a17090aea9400b002552dfc6c6fmr10902928pjz.24.1684858376742; Tue, 23
 May 2023 09:12:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230519001709.2563-1-tj@kernel.org> <20230523111818.GH4253@hirez.programming.kicks-ass.net>
In-Reply-To: <20230523111818.GH4253@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 May 2023 18:12:45 +0200
Message-ID: <CAKfTPtB11Zwt9bgOJrNVDfs5yY7Dws_vnQBuXZHErSsbn9Edhw@mail.gmail.com>
Subject: Re: [PATCHSET v1 wq/for-6.5] workqueue: Improve unbound workqueue
 execution locality
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Tejun Heo <tj@kernel.org>, jiangshanlai@gmail.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, joshdon@google.com, brho@google.com,
        briannorris@chromium.org, nhuck@google.com, agk@redhat.com,
        snitzer@kernel.org, void@manifault.com, gautham.shenoy@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 May 2023 at 13:18, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, May 18, 2023 at 02:16:45PM -1000, Tejun Heo wrote:
>
> > Most of the patchset are workqueue internal plumbing and probably aren'=
t
> > terribly interesting. Howver, the performance picture turned out less
> > straight-forward than I had hoped, mostly likely due to loss of
> > work-conservation from scheduler in high fan-out scenarios. I'll descri=
be it
> > in this cover letter. Please read on.
>
> > Here's the relevant part of the experiment setup.
> >
> > * Ryzen 9 3900x - 12 cores / 24 threads spread across 4 L3 caches.
> >   Core-to-core latencies across L3 caches are ~2.6x worse than within e=
ach
> >   L3 cache. ie. it's worse but not hugely so. This means that the impac=
t of
> >   L3 cache locality is noticeable in these experiments but may be subdu=
ed
> >   compared to other setups.
>
> *blink*, 12 cores with 4 LLCs ? that's a grand total of 3 cores / 6
> threads per LLC. That's puny.
>
> /me goes google a bit.. So these are Zen2 things which nominally have 4
> cores per CCX which has 16M of L3, but these must binned parts with only
> 3 functional cores per CCX.
>
> Zen3 then went to 8 cores per CCX with double the L3.
>
> > 2. MED: Fewer issuers, enough work for saturation
> >
> >                   Bandwidth (MiBps)    CPU util (%)    vs. SYSTEM BW (%=
)
> >   ---------------------------------------------------------------------=
-
> >   SYSTEM             1155.40  =C4=850.89     97.41 =C4=850.05          =
       0.00
> >   CACHE              1154.40  =C4=851.14     96.15 =C4=850.09          =
      -0.09
> >   CACHE+STRICT       1112.00  =C4=854.64     93.26 =C4=850.35          =
      -3.76
> >   SYSTEM+LOCAL       1066.80  =C4=852.17     86.70 =C4=850.10          =
      -7.67
> >   CACHE+LOCAL        1034.60  =C4=851.52     83.00 =C4=850.07          =
     -10.46
> >
> > There are still eight issuers and plenty of work to go around. However,=
 now,
> > depending on the configuration, we're starting to see a significant los=
s of
> > work-conservation where CPUs sit idle while there's work to do.
> >
> > * CACHE is doing okay. It's just a bit slower. Further testing may be n=
eeded
> >   to definitively confirm the bandwidth gap but the CPU util difference
> >   seems real, so while minute, it did lose a bit of work-conservation.
> >   Comparing it to CACHE+STRICT, it's starting to show the benefits of
> >   non-strict scopes.
>
> So wakeup based placement is mostly all about LLC, and given this thing
> has dinky small LLCs it will pile up on the one LLC you target and leave
> the others idle until the regular idle balancer decides to make an
> appearance and move some around.
>
> But if these are fairly short running tasks, I can well see that not
> going to help much.
>
>
> Much of this was tuned back when there was 1 L3 per Node; something
> which is still more or less true for Intel but clearly not for these
> things.
>
>
> The below is a bit crude and completely untested, but it might help. The
> flip side of that coin is of course that people are going to complain
> about how selecting a CPU is more expensive now and how this hurts their
> performance :/
>
> Basically it will try and iterate all L3s in a node; wakeup will still
> refuse to cross node boundaries.

That remember me some discussion about system with fast on die
interconnect where we would like to run wider than llc at wakeup (i.e.
DIE level) something like the CLUSTER level but on the other side of
MC

Another possibility to investigate would be that each wakeup of a
worker is mostly unrelated to the previous one and it cares only
waker. so we should use -1 for the prev_cpu

>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 48b6f0ca13ac..ddb7f16a07a9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7027,6 +7027,33 @@ static int select_idle_cpu(struct task_struct *p, =
struct sched_domain *sd, bool
>         return idle_cpu;
>  }
>
> +static int
> +select_idle_node(struct task_struct *p, struct sched_domain *sd, int tar=
get)
> +{
> +       struct sched_domain *sd_node =3D rcu_dereference(per_cpu(sd_node,=
 target));
> +       struct sched_group *sg;
> +
> +       if (!sd_node || sd_node =3D=3D sd)
> +               return -1;
> +
> +       sg =3D sd_node->groups;
> +       do {
> +               int cpu =3D cpumask_first(sched_group_span(sg));
> +               struct sched_domain *sd_child;
> +
> +               sd_child =3D per_cpu(sd_llc, cpu);
> +               if (sd_child !=3D sd) {
> +                       int i =3D select_idle_cpu(p, sd_child, test_idle_=
cores(cpu), cpu);
> +                       if ((unsigned int)i < nr_cpumask_bits)
> +                               return i;
> +               }
> +
> +               sg =3D sg->next;
> +       } while (sg !=3D sd_node->groups);
> +
> +       return -1;
> +}
> +
>  /*
>   * Scan the asym_capacity domain for idle CPUs; pick the first idle one =
on which
>   * the task fits. If no CPU is big enough, but there are idle ones, try =
to
> @@ -7199,6 +7226,12 @@ static int select_idle_sibling(struct task_struct =
*p, int prev, int target)
>         if ((unsigned)i < nr_cpumask_bits)
>                 return i;
>
> +       if (sched_feat(SIS_NODE)) {
> +               i =3D select_idle_node(p, sd, target);
> +               if ((unsigned)i < nr_cpumask_bits)
> +                       return i;
> +       }
> +
>         return target;
>  }
>
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..f965cd4a981e 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>   */
>  SCHED_FEAT(SIS_PROP, false)
>  SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_NODE, true)
>
>  /*
>   * Issue a WARN when we do multiple update_rq_clock() calls
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 678446251c35..d2e0e2e496a6 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1826,6 +1826,7 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc=
);
>  DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_node);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index ca4472281c28..d94cbc2164ca 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -667,6 +667,7 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_node);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> @@ -691,6 +692,18 @@ static void update_top_cache_domain(int cpu)
>         per_cpu(sd_llc_id, cpu) =3D id;
>         rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
>
> +       while (sd && sd->parent) {
> +               /*
> +                * SD_NUMA is the first domain spanning nodes, therefore =
@sd
> +                * must be the domain that spans a single node.
> +                */
> +               if (sd->parent->flags & SD_NUMA)
> +                       break;
> +
> +               sd =3D sd->parent;
> +       }
> +       rcu_assign_pointer(per_cpu(sd_node, cpu), sd);
> +
>         sd =3D lowest_flag_domain(cpu, SD_NUMA);
>         rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
>
