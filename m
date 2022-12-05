Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FCB36428A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 13:40:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiLEMkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 07:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbiLEMkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 07:40:08 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA701A808;
        Mon,  5 Dec 2022 04:40:07 -0800 (PST)
Received: by mail-qk1-f174.google.com with SMTP id k2so4781867qkk.7;
        Mon, 05 Dec 2022 04:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N9AByblogyksZmUUDYbnQyVNZj7XMWQtmh4r5hKiB7g=;
        b=wxBS0fJ1lmwiwMEoEdaQWdjPpas0pU4AYBJyctcII+bk0tdHaLWW+fj+aaNpl8aKyE
         KPRbT/6NqTH1rlECTvmlM6ozZ7LEmozTFoc0qLkJ/hMJD/mlElj6czDEXl1a6Uk1phtq
         C/LZdkes1uDmyY2D0S3IQqVNfnCl3YF6K6DHlddd7aMYTyn/IOT6rxevDJ7RpRIjN+U8
         Ip565WSbDQdJoa64piDmH3upYenhLOGocc83isZApXI11YX4e2Kfv7xe2B5Y/5LTKcs8
         TLmpgxqPeyaHd4AvvxhhdJ2d/KQgiW6uiTqVhL1wzQC66CNSxGWtZ9BESipzf27gnhvC
         zzyg==
X-Gm-Message-State: ANoB5pk8yvrCVY/L2q9hJ9oBgsJpY/9UvduOHj3k8S3ZHxAL4g15lNQh
        yAheUtpPWfn2qAGmo6SVgHd9CGpDcI+lwntkbAY=
X-Google-Smtp-Source: AA0mqf6UaErJSxu/hsgPFuWBr6jR1KyzAl26lmCBDmbpS6RY6ac2om2uoXJLB0ipJg6sSc2xecUv3EMbUvjJ1JnT2to=
X-Received: by 2002:a05:620a:4611:b0:6fa:af7e:927c with SMTP id
 br17-20020a05620a461100b006faaf7e927cmr71442383qkb.443.1670244007067; Mon, 05
 Dec 2022 04:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20221127141742.1644023-1-qyousef@layalina.io> <20221127141742.1644023-4-qyousef@layalina.io>
 <CAJZ5v0iew=_pTq-v-2EdZN==8QY3donu9YUBtRYWdL18KBxs4Q@mail.gmail.com> <20221203143216.oezd2u6dpxodpuc3@airbuntu>
In-Reply-To: <20221203143216.oezd2u6dpxodpuc3@airbuntu>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Dec 2022 13:39:52 +0100
Message-ID: <CAJZ5v0h_uoja87NUZb-tWmG_6Fb+1bATB03VRO0Foi5nFadiVQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] sched/fair: Traverse cpufreq policies to detect
 capacity inversion
To:     Qais Yousef <qyousef@layalina.io>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 3, 2022 at 3:32 PM Qais Yousef <qyousef@layalina.io> wrote:
>
> On 11/30/22 19:27, Rafael J. Wysocki wrote:
>
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index 7c0dd57e562a..4bbbca85134b 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -8856,23 +8856,20 @@ static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> > >          *   * Thermal pressure will impact all cpus in this perf domain
> > >          *     equally.
> > >          */
> > > -       if (sched_energy_enabled()) {
> > > +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> > >                 unsigned long inv_cap = capacity_orig - thermal_load_avg(rq);
> > > -               struct perf_domain *pd = rcu_dereference(rq->rd->pd);
> > > +               struct cpufreq_policy *policy, __maybe_unused *policy_n;
> > >
> > >                 rq->cpu_capacity_inverted = 0;
> > >
> > > -               SCHED_WARN_ON(!rcu_read_lock_held());
> > > -
> > > -               for (; pd; pd = pd->next) {
> > > -                       struct cpumask *pd_span = perf_domain_span(pd);
> > > +               for_each_active_policy_safe(policy, policy_n) {
> >
> > 1. Is the "safe" part sufficient for protection against concurrent
> > deletion and freeing of list entries?  cpufreq driver removal can do
> > that AFAICS.
>
> The freeing part is not safe probably.

Well, I don't even think that the traversal part is safe against
concurrent removal of list entries (it is safe against removal of list
entries in the loop itself).

list_for_each_entry_safe() assumes that n will always point to a valid
list entry, but what if the entry pointed to by it is deleted by a
concurrent thread?

> I need to research this more. Do you
> have issues against the exportation of this traversal in principle?
>
> Switching them to be RCU protected could be the best safe option, anything
> against that too?

Not really, it just occurred to me that you may end up dealing with a
corrupted list here.

> I might not end up needing that. I need to dig more.
>
> > 2. For a casual reader of this code it may not be clear why cpufreq
> > policies matter here.
>
> I'm looking for a way to traverse the list of capacities of the system and
> know their related CPUs.

So why don't you mention this in a comment, for instance?

> AFAICT this information already exists in the performance domains and
> cpufreq_policy. Performance domains are conditional to energy model and
> schedutil. So trying to switch to cpufreq_policy.
>
> Assuming this question wasn't a request to add a comment :-)

Yes, it was. :-)

That said though, this change makes the scheduler kind of depend on
cpufreq which feels a bit like a corner cut TBH.

I do realize that cpufreq happens to be maintaining a data structure
that turns out to be useful here, but the reason why it is there has
nothing to do with this code AFAICS.
