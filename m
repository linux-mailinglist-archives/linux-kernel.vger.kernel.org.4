Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE07E63ACF0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 16:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbiK1Psy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 10:48:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232129AbiK1Pso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 10:48:44 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3D521A8;
        Mon, 28 Nov 2022 07:48:42 -0800 (PST)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8C9752A0;
        Mon, 28 Nov 2022 15:48:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8C9752A0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1669650521; bh=+Hwx206NJd9t7OktNCE7G9a3Wt8Nk1NuJRsrehoQEKU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Z1ZY8nKI2M7Jts9IxHuh5JTL11MgkB8bkmd9BZDKgQJSAbMHxz5uSOFBIdNlnoJiT
         Hmb6UU/GZygkj3zk6X+VjnNs/CtwN97IpmKYFwh23D+hsSeEfT6RKGQmgGHf17ErEF
         yZRZk8Uz34i0YhEY7rNooORADTccOsMMKwOj+FNP1pM91aBHpNHp3qYjxLR6xRFb8C
         Eouy5x7dJFqsAGAfNOF+aOSkM6ez8BcWF+Fp4FqN5a8dPcjk/p1E7n7HupvZlbqdof
         WSWjT1MOwbSrzW8XJLaty70xHZSt4dPcP6fKrNCeciL86NnP4dYEZ9eWHAGdY3QR+8
         nVb5Lp1oNDo1w==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Qais Yousef <qyousef@layalina.io>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan94@gmail.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Paul Bone <pbone@mozilla.com>,
        Qais Yousef <qyousef@layalina.io>
Subject: Re: [PATCH v2] Documentation: sched: Add a new sched-util-clamp.rst
In-Reply-To: <20221127142657.1649347-1-qyousef@layalina.io>
References: <20221127142657.1649347-1-qyousef@layalina.io>
Date:   Mon, 28 Nov 2022 08:48:40 -0700
Message-ID: <87cz976pwn.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qais Yousef <qyousef@layalina.io> writes:

> The new util clamp feature needs a document explaining what it is and
> how to use it. The new document hopefully covers everything one needs to
> know about uclamp.
>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> Signed-off-by: Qais Yousef (Google) <qyousef@layalina.io>
> ---
>
> Changes in v2:
>
> 	* Address various style comments from Bagas

Just a handful of nits - this looks like a good addition to our
documentation, thanks.

>  Documentation/scheduler/index.rst            |   1 +
>  Documentation/scheduler/sched-util-clamp.rst | 732 +++++++++++++++++++
>  2 files changed, 733 insertions(+)
>  create mode 100644 Documentation/scheduler/sched-util-clamp.rst
>
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index b430d856056a..f12d0d06de3a 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -15,6 +15,7 @@ Linux Scheduler
>      sched-capacity
>      sched-energy
>      schedutil
> +    sched-util-clamp
>      sched-nice-design
>      sched-rt-group
>      sched-stats
> diff --git a/Documentation/scheduler/sched-util-clamp.rst b/Documentation/scheduler/sched-util-clamp.rst
> new file mode 100644
> index 000000000000..da1881e293c3
> --- /dev/null
> +++ b/Documentation/scheduler/sched-util-clamp.rst
> @@ -0,0 +1,732 @@
> +====================
> +Utilization Clamping
> +====================

RST files, too, should have SPDX tags at the beginning.  The practice
rather lags the rule here, but we're trying...

> +1.  Introduction
> +================
> +
> +Utilization clamping is a scheduler feature that allows user space to help in
> +managing the performance requirement of tasks. It was introduced in v5.3
> +release. The CGroup support was merged in v5.4.
> +
> +It is often referred to as util clamp and uclamp. You'll find all variations
> +used interchangeably in this documentation and in the source code.
> +
> +Uclamp is a hinting mechanism that allows the scheduler to understand the
> +performance requirements and restrictions of the tasks. Hence help it make

...of the tasks, and thus help it ... 

> +a better placement decision. And when schedutil cpufreq governor is used, util
> +clamp will influence the frequency selection as well.
> +
> +Since scheduler and schedutil are both driven by PELT (util_avg) signals, util

Since *the* scheduler

> +clamp acts on that to achieve its goal by clamping the signal to a certain
> +point; hence the name. I.e: by clamping utilization we are making the system
> +run at a certain performance point.
> +
> +The right way to view util clamp is as a mechanism to make performance
> +constraints request/hint. It consists of two components:
> +
> +        * UCLAMP_MIN, which sets a lower bound.
> +        * UCLAMP_MAX, which sets an upper bound.
> +
> +These two bounds will ensure a task will operate within this performance range
> +of the system. UCLAMP_MIN implies boosting a task, while UCLAMP_MAX implies
> +capping a task.
> +
> +One can tell the system (scheduler) that some tasks require a minimum
> +performance point to operate at to deliver the desired user experience. Or one
> +can tell the system that some tasks should be restricted from consuming too
> +much resources and should NOT go above a specific performance point. Viewing
> +the uclamp values as performance points rather than utilization is a better
> +abstraction from user space point of view.
> +
> +As an example, a game can use util clamp to form a feedback loop with its
> +perceived FPS. It can dynamically increase the minimum performance point

FPS?

> +required by its display pipeline to ensure no frame is dropped. It can also
> +dynamically 'prime' up these tasks if it knows in the coming few 100ms
> +a computationally intensive scene is about to happen.
> +
> +On mobile hardware where the capability of the devices varies a lot, this
> +dynamic feedback loop offers a great flexibility in ensuring best user
> +experience given the capabilities of any system.
> +
> +Of course a static configuration is possible too. The exact usage will depend
> +on the system, application and the desired outcome.
> +
> +Another example is in Android where tasks are classified as background,
> +foreground, top-app, etc. Util clamp can be used to constraint how much

to *constrain* how

> +resources background tasks are consuming by capping the performance point they
> +can run at. This constraint helps reserve resources for important tasks, like
> +the ones belonging to the currently active app (top-app group). Beside this
> +helps in limiting how much power they consume. This can be more obvious in
> +heterogeneous systems; the constraint will help bias the background tasks to
> +stay on the little cores which will ensure that:
> +
> +        1. The big cores are free to run top-app tasks immediately. top-app
> +           tasks are the tasks the user is currently interacting with, hence
> +           the most important tasks in the system.
> +        2. They don't run on a power hungry core and drain battery even if they
> +           are CPU intensive tasks.
> +
> +By making these uclamp performance requests, or rather hints, user space can
> +ensure system resources are used optimally to deliver the best user experience
> +the system is capable of.
> +
> +Another use case is to help with overcoming the ramp up latency inherit in how
> +scheduler utilization signal is calculated.
> +
> +A busy task for instance that requires to run at maximum performance point will
> +suffer a delay of ~200ms (PELT HALFIFE = 32ms) for the scheduler to realize
> +that. This is known to affect workloads like gaming on mobile devices where
> +frames will drop due to slow response time to select the higher frequency
> +required for the tasks to finish their work in time.
> +
> +The overall visible effect goes beyond better perceived user
> +experience/performance and stretches to help achieve a better overall
> +performance/watt if used effectively.
> +
> +User space can form a feedback loop with thermal subsystem too to ensure the

with *the* thermal subsystem

> +device doesn't heat up to the point where it will throttle.
> +
> +Both SCHED_NORMAL/OTHER and SCHED_FIFO/RR honour uclamp requests/hints.
> +
> +In SCHED_FIFO/RR case, uclamp gives the option to run RT tasks at any

In *the* SCHED_FIFO...

> +performance point rather than being tied to MAX frequency all the time. Which
> +can be useful on general purpose systems that run on battery powered devices.
> +
> +Note that by design RT tasks don't have per-task PELT signal and must always
> +run at a constant frequency to combat undeterministic DVFS rampup delays.
> +
> +Note that using schedutil always implies a single delay to modify the frequency
> +when an RT task wakes up. This cost is unchanged by using uclamp. Uclamp only
> +helps picking what frequency to request instead of schedutil always requesting
> +MAX for all RT tasks.
> +
> +See section 3.4 for default values and 3.4.1 on how to change RT tasks default
> +value.
> +
> +2.  Design
> +==========
> +
> +Util clamp is a property of every task in the system. It sets the boundaries of
> +its utilization signal; acting as a bias mechanism that influences certain
> +decisions within the scheduler.
> +
> +The actual utilization signal of a task is never clamped in reality. If you
> +inspect PELT signals at any point of time you should continue to see them as
> +they are intact. Clamping happens only when needed, e.g: when a task wakes up
> +and the scheduler needs to select a suitable CPU for it to run on.
> +
> +Since the goal of util clamp is to allow requesting a minimum and maximum
> +performance point for a task to run on, it must be able to influence the
> +frequency selection as well as task placement to be most effective. Both of
> +which have implications on the utilization value at rq level, which brings us
> +to the main design challenge.
> +
> +When a task wakes up on an rq, the utilization signal of the rq will be
> +impacted by the uclamp settings of all the tasks enqueued on it. For example if
> +a task requests to run at UTIL_MIN = 512, then the util signal of the rq needs
> +to respect this request as well as all other requests from all of the enqueued
> +tasks.
> +
> +To be able to aggregate the util clamp value of all the tasks attached to the
> +rq, uclamp must do some housekeeping at every enqueue/dequeue, which is the
> +scheduler hot path. Hence care must be taken since any slow down will have
> +significant impact on a lot of use cases and could hinder its usability in
> +practice.
> +
> +The way this is handled is by dividing the utilization range into buckets
> +(struct uclamp_bucket) which allows us to reduce the search space from every
> +task on the rq to only a subset of tasks on the top-most bucket.
> +
> +When a task is enqueued, we increment a counter in the matching bucket. And on
> +dequeue we decrement it. This makes keeping track of the effective uclamp value
> +at rq level a lot easier.
> +
> +As we enqueue and dequeue tasks we keep track of the current effective uclamp
> +value of the rq. See section 2.1 for details on how this works.
> +
> +Later at any path that wants to identify the effective uclamp value of the rq,
> +it will simply need to read this effective uclamp value of the rq at that exact
> +moment of time it needs to take a decision.
> +
> +For task placement case, only Energy Aware and Capacity Aware Scheduling
> +(EAS/CAS) make use of uclamp for now. This implies heterogeneous systems only.
> +When a task wakes up, the scheduler will look at the current effective uclamp
> +value of every rq and compare it with the potential new value if the task were
> +to be enqueued there. Favoring the rq that will end up with the most energy
> +efficient combination.
> +
> +Similarly in schedutil, when it needs to make a frequency update it will look
> +at the current effective uclamp value of the rq which is influenced by the set
> +of tasks currently enqueued there and select the appropriate frequency that
> +will honour uclamp requests.
> +
> +Other paths like setting overutilization state (which effectively disables EAS)
> +make use of uclamp as well. Such cases are considered necessary housekeeping to
> +allow the 2 main use cases above and will not be covered in detail here as they
> +could change with implementation details.
> +
> +2.1  Buckets
> +------------
> +
> +::
> +
> +                           [struct rq]
> +
> +  (bottom)                                                    (top)
> +
> +    0                                                          1024
> +    |                                                           |
> +    +-----------+-----------+-----------+----   ----+-----------+
> +    |  Bucket 0 |  Bucket 1 |  Bucket 2 |    ...    |  Bucket N |
> +    +-----------+-----------+-----------+----   ----+-----------+
> +       :           :                                   :
> +       +- p0       +- p3                               +- p4
> +       :                                               :
> +       +- p1                                           +- p5
> +       :
> +       +- p2
> +
> +
> +.. note::
> +  The diagram above is an illustration rather than a true depiction of the
> +  internal data structure.
> +
> +To reduce the search space when trying to decide the effective uclamp value of
> +an rq as tasks are enqueued/dequeued, the whole utilization range is divided
> +into N buckets where N is configured at compile time by setting
> +CONFIG_UCLAMP_BUCKETS_COUNT. By default it is set to 5.
> +
> +The rq has a bucket for each uclamp_id: [UCLAMP_MIN, UCLAMP_MAX].
> +
> +The range of each bucket is 1024/N. For example for the default value of 5 we
> +will have 5 buckets, each of which will cover the following range:
> +
> +.. code-block:: c

If you want to minimize markup, you could use basic literal blocks
rather than ..code-block::, which really only has the effect of syntax
coloring in HTML output.  I don't find that worth the extra clutter
myself, but others clearly disagree with me...

> +        DELTA = round_closest(1024/5) = 204.8 = 205
> +
> +        Bucket 0: [0:204]
> +        Bucket 1: [205:409]
> +        Bucket 2: [410:614]
> +        Bucket 3: [615:819]
> +        Bucket 4: [820:1024]
> +

I didn't find anything worth quibbling about after this.

Thanks,

jon
