Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98505742250
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 10:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231835AbjF2Ike (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 04:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbjF2Ijr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 04:39:47 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862EF35BB
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:34:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51d9865b8a2so448240a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 01:34:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688027640; x=1690619640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nXznbG4FVhuMJDAumoD9paaeIhbqWqlZS3esXX8J+O4=;
        b=XKc34Zr/KrbjfZ2h+WbrbmrFYeow/xUEUtaX5uqQDppmCb3l9MQvCfDWixxXTvFthS
         kQ+z4gnG6xNTDB6b0RTyln9I0j2PpqojT7364fCJfAhpf3a+K+khc8ntfByqUT+7xW7D
         RsTk0MPiDDUFEiv4SIrFFCgGO7UIwfrdcdXx1WbvQVPbpYlIGE3wjTuUktQ2jLhp2iTN
         DWeKhzz2obhJIVEYjJKhhwxn2dt6NpFiKhwsr0pRW7OE1WT15QI3BwcIBNED5NJnRXbI
         pFKIle2OFLB3OqhUF4hLNNkC4TGov5S0ptdHNVywbaom6fNgMBM+gcInytEXJS+dHRNS
         wFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688027640; x=1690619640;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nXznbG4FVhuMJDAumoD9paaeIhbqWqlZS3esXX8J+O4=;
        b=XVbFdsgOB+VB4JzVOD025w/qtePFSjA1lK6kelCXyudLUihvwztGL7nYSTaMw69FvM
         W13NzHsu4u5pRg93zxZG5c6yOImMNi/k7Am0NNpIdb0LyeUpqr1ou+Ip0mA9qe9rEM1h
         fvoN1FXI7m2nH3saGG2hVnllRT2nIbax0cW0GRA6vWizvoIgunyw8aWeH77n7Yvjz6CT
         5nxoIqqkObTAGXCs+T+3YAP5vRFB1xT+sTBzEaRIHrymbZxqO8NVcC7HV55P6k+Ie6Sm
         DgV66EKJS8zWl+s++sAFYnnU0/5oep9L48qEQHmuPPHAUkAiQ1kEudKLk6DAfkqeTjDj
         gMjw==
X-Gm-Message-State: AC+VfDwp9iH+UtQ6R5I//l9Tp8DXukVnDh1tuRzbQdDHB7czBVRJSj2N
        E4gZIjXQ5704N/6RlQh051T2jthTtJrejgNnlbex/g==
X-Google-Smtp-Source: ACHHUZ5aaatzGAqso2uPEQtt481aL5GASIoRhSgjmifmko0bm+A1t0OoLGKguCodYD53UV/Rk6u3/B4CWlXual+bOPs=
X-Received: by 2002:a05:6402:546:b0:51d:b8a3:b475 with SMTP id
 i6-20020a056402054600b0051db8a3b475mr2812445edx.39.1688027639928; Thu, 29 Jun
 2023 01:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <8e785777-03aa-99e1-d20e-e956f5685be6@huawei.com>
 <87mt18it1y.ffs@tglx> <68baeac9-9fa7-5594-b5e7-4baf8ac86b77@huawei.com>
 <ba352e83-b8b1-d900-9c1f-56b8c8a8b8fb@huawei.com> <CAKfTPtBoe_jRn-EMsQxssQ4BcveT+Qcd+GmsRbQEXQDGfzFOMg@mail.gmail.com>
 <a0c76a11-9c18-6473-b0be-fd5ffa864599@huawei.com>
In-Reply-To: <a0c76a11-9c18-6473-b0be-fd5ffa864599@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 29 Jun 2023 10:33:49 +0200
Message-ID: <CAKfTPtC6eVhnQh+SeiPLqVCWDLW5PnXmT+7LkZ8iPDh8_QvUeA@mail.gmail.com>
Subject: Re: [Question] report a race condition between CPU hotplug state
 machine and hrtimer 'sched_cfs_period_timer' for cfs bandwidth throttling
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, vschneid@redhat.com,
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

On Thu, 29 Jun 2023 at 03:26, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
>
>
>
> On 2023/6/28 0:46, Vincent Guittot wrote:
> > On Mon, 26 Jun 2023 at 10:23, Xiongfeng Wang <wangxiongfeng2@huawei.com> wrote:
> >>
> >> Hi,
> >>
> >> Kindly ping~
> >> Could you please take a look at this issue and the below temporary fix ?
> >>
> >> Thanks,
> >> Xiongfeng
> >>
> >> On 2023/6/12 20:49, Xiongfeng Wang wrote:
> >>>
> >>>
> >>> On 2023/6/9 22:55, Thomas Gleixner wrote:
> >>>> On Fri, Jun 09 2023 at 19:24, Xiongfeng Wang wrote:
> >>>>
> >>>> Cc+ scheduler people, leave context intact
> >>>>
> >>>>> Hello,
> >>>>>  When I do some low power tests, the following hung task is printed.

[...]

> >>> diff --cc kernel/sched/fair.c
> >>> index d9d6519fae01,bd6624353608..000000000000
> >>> --- a/kernel/sched/fair.c
> >>> +++ b/kernel/sched/fair.c
> >>> @@@ -5411,10 -5411,16 +5411,15 @@@ void start_cfs_bandwidth(struct cfs_ban
> >>>   {
> >>>         lockdep_assert_held(&cfs_b->lock);
> >>>
> >>> -       if (cfs_b->period_active)
> >>> +       if (cfs_b->period_active) {
> >>> +               struct hrtimer_clock_base *clock_base = cfs_b->period_timer.base;
> >>> +               int cpu = clock_base->cpu_base->cpu;
> >>> +               if (!cpu_active(cpu) && cpu != smp_processor_id())
> >>> +                       hrtimer_start_expires(&cfs_b->period_timer,
> >>> HRTIMER_MODE_ABS_PINNED);
> >>>                 return;
> >>> +       }
> >
> > I have been able to reproduce your problem and run your fix on top. I
> > still wonder if there is a
>
> Sorry, I forgot to provide the kernel modification to help reproduce the issue.
> At first, the issue can only be reproduced on the product environment with
> product stress testcase. After firguring out the reason, I add the following
> modification. It make sure the process ran out cfs quota and can be sched out in
> free_vm_stack_cache. Although the real schedule point is in __vunmap(), this can
> also show the issue exists.

I have been able to reproduce the problem ( or at least something
similar) without your change below with a shorter cfs_quota_us and
other tasks always running in the cgroup

>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0fb86b65ae60..3b2d83fb407a 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -110,6 +110,8 @@
>  #define CREATE_TRACE_POINTS
>  #include <trace/events/task.h>
>
> +#include <linux/delay.h>
> +
>  /*
>   * Minimum number of threads to boot the kernel
>   */
> @@ -199,6 +201,9 @@ static int free_vm_stack_cache(unsigned int cpu)
>         struct vm_struct **cached_vm_stacks = per_cpu_ptr(cached_stacks, cpu);
>         int i;
>
> +       mdelay(2000);
> +       cond_resched();
> +
>         for (i = 0; i < NR_CACHED_STACKS; i++) {
>                 struct vm_struct *vm_stack = cached_vm_stacks[i];
>
> Thanks,
> Xiongfeng
>
> > Could we have a helper from hrtimer to get the cpu of the clock_base ?
> >
> >
> >>>
> >>>         cfs_b->period_active = 1;
> >>>  -
> >>>         hrtimer_forward_now(&cfs_b->period_timer, cfs_b->period);
> >>>         hrtimer_start_expires(&cfs_b->period_timer, HRTIMER_MODE_ABS_PINNED);
> >>>   }
> >>>
> >>> Thanks,
> >>> Xiongfeng
> >>>
> >>> .
> >>>
> > .
> >
