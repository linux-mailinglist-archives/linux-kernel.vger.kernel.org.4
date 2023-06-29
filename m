Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83ECA742242
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbjF2Icv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbjF2Ia7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:30:59 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8942C2D4C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:30:57 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-98e25fa6f5bso57008266b.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688027456; x=1690619456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jWrukKFFy0tw5S2kDbR9tmnBZP1G3ykm2c+1fuL8P6Q=;
        b=JzP34lnHO4IHu2yMugScoQeq+XWqqila68WSZL85oZbFtfHpq7wtAo+TXGslnXRQLp
         s3IOmEMe1lVW0yuseOJf/q4/amSubMTjJEvsO2A8zQn0blj1GZXIMaJ7qCGh2453f0Sa
         rFO8zwquU6nNVBq8iFULhRDLxIhQuagRgtlZHF969lnncB1NjU3KPU1qDP+LAzfW9xn2
         42BZV7M3muIah/fXiVM5paGClJ7ivHH66owujsZGvdTXKIzWjQPYP99PJMf6jUr5kLGl
         76I0SACGHFb1ZKsom7WlcssV/BkAkq0/sbc/VgQosERPwPsbDZbeo+Ba+0kLFR45fPpm
         KWxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688027456; x=1690619456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jWrukKFFy0tw5S2kDbR9tmnBZP1G3ykm2c+1fuL8P6Q=;
        b=dQWNI7NXH082swlyMRXgb/SfDksEeAHhZmONnnXT2HT7+BW/XhaKpHlnYNdQGS2iU2
         +aTNdrJZIEXMXZXzZsy7nBORUkMsyv6IxparS79+wPNSLByUgcbPByCacpn9Wzm+cKRT
         /kxllOF7DbA6CtlHmMZIlF+mYlm9s+iWDbbZzEWVpOaXN+o+LNQBJAFGDnKAOE/XiZhg
         KY5wqRuVUM1+B0T1+4kqJHAjwG0Hsqy6PDtupfvVimIC8DFZPX+kKyi29j7BjQq+RGUh
         QtkHxk4oOFq4KW+Sc9aGmqIseav1sw6nuEb1jZAAwgioo4Ps0qK1j9jgL+rIbKfPj+w5
         La/g==
X-Gm-Message-State: AC+VfDxggVY8AcWwRjrGXTzbMl0aKYB/xf4WKbIfR/K0AssAKznWjf1V
        wy5lRt3IG5X53+tH4NDB6P/o5pApNda12/YXkYJzsA==
X-Google-Smtp-Source: ACHHUZ7QW5k0osr2VS+cDzbx/j8BjGByn2zCK42RokmW2GvhVNAIhCPGSY1/3pO9BbPzMc6eDDTGSr+mFJAh8P8G4K4=
X-Received: by 2002:a17:907:987:b0:969:faf3:7dba with SMTP id
 bf7-20020a170907098700b00969faf37dbamr35333395ejc.52.1688027455715; Thu, 29
 Jun 2023 01:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com>
 <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com> <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
 <875y774wvp.ffs@tglx> <CAKfTPtAzTy4KPrBNRA4cMeTonxn5EKLEAg0b9iH5ecJkAMEStw@mail.gmail.com>
 <87pm5f2qm2.ffs@tglx>
In-Reply-To: <87pm5f2qm2.ffs@tglx>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Jun 2023 10:30:44 +0200
Message-ID: <CAKfTPtBSx7h1caR9g8wEK5GG2JMfSBRqSzLgjRUjrnp1Zc-ssg@mail.gmail.com>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, vschneid@redhat.com,
        Phil Auld <pauld@redhat.com>, vdonnefort@google.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei Li <liwei391@huawei.com>,
        "liaoyu (E)" <liaoyu15@huawei.com>, zhangqiao22@huawei.com,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>
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

On Thu, 29 Jun 2023 at 00:01, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Wed, Jun 28 2023 at 14:35, Vincent Guittot wrote:
> > On Wed, 28 Jun 2023 at 14:03, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> No, because this is fundamentally wrong.
> >>
> >> If the CPU is on the way out, then the scheduler hotplug machinery
> >> has to handle the period timer so that the problem Xiongfeng analyzed
> >> does not happen in the first place.
> >
> > But the hrtimer was enqueued before it starts to offline the cpu
>
> It does not really matter when it was enqueued. The important point is
> that it was enqueued on that outgoing CPU for whatever reason.
>
> > Then, hrtimers_dead_cpu should take care of migrating the hrtimer out
> > of the outgoing cpu but :
> > - it must run on another target cpu to migrate the hrtimer.
> > - it runs in the context of the caller which can be throttled.
>
> Sure. I completely understand the problem. The hrtimer hotplug callback
> does not run because the task is stuck and waits for the timer to
> expire. Circular dependency.
>
> >> sched_cpu_wait_empty() would be the obvious place to cleanup armed CFS
> >> timers, but let me look into whether we can migrate hrtimers early in
> >> general.
> >
> > but for that we must check if the timer is enqueued on the outgoing
> > cpu and we then need to choose a target cpu.
>
> You're right. I somehow assumed that cfs knows where it queued stuff,
> but obviously it does not.

scheduler doesn't know where hrtimer enqueues the timer

>
> I think we can avoid all that by simply taking that user space task out
> of the picture completely, which avoids debating whether there are other
> possible weird conditions to consider alltogether.

yes, the offline sequence should not be impacted by the caller context

>
> Something like the untested below should just work.
>
> Thanks,
>
>         tglx
> ---
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -1490,6 +1490,13 @@ static int cpu_down(unsigned int cpu, en
>         return err;
>  }
>
> +static long __cpu_device_down(void *arg)
> +{
> +       struct device *dev = arg;
> +
> +       return cpu_down(dev->id, CPUHP_OFFLINE);
> +}
> +
>  /**
>   * cpu_device_down - Bring down a cpu device
>   * @dev: Pointer to the cpu device to offline
> @@ -1502,7 +1509,12 @@ static int cpu_down(unsigned int cpu, en
>   */
>  int cpu_device_down(struct device *dev)
>  {
> -       return cpu_down(dev->id, CPUHP_OFFLINE);
> +       unsigned int cpu = cpumask_any_but(cpu_online_mask, dev->id);
> +
> +       if (cpu >= nr_cpu_ids)
> +               return -EBUSY;
> +
> +       return work_on_cpu(cpu, __cpu_device_down, dev);

The comment for work_on_cpu :

 * It is up to the caller to ensure that the cpu doesn't go offline.
 * The caller must not hold any locks which would prevent @fn from completing.

make me wonder if this should be done only once the hotplug lock is
taken so the selected cpu will not go offline

>  }
>
>  int remove_cpu(unsigned int cpu)
