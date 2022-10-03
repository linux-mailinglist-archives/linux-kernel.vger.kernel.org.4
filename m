Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB58C5F3065
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 14:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiJCMmR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 08:42:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiJCMmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 08:42:15 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B13472E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 05:42:13 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id x40so965469ljq.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Oct 2022 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=9KihD59o8exXxKhs+626FRzpoHm5LgtYCwka81Fqj6g=;
        b=Y9a9Zzx5MJ611OvM9FIwUwMLXkhBnoiS0O2KeL4RiDaN/Ea5gsL/L3HK9UlC6hQjYR
         OUTiGGgstgrMFuTJBHcJZ/nAS62ow2oJXAADRtj/cAIhXiIO7ds/11hIs+H1cXVBXDdB
         ArXEeDKaCl8qPsewUObxNgYS4Tk/7m/Xyg1HPPDgr0+qKyaGAg1IGKb79sM7XuzXOAi1
         k00oX4xV5ZsgpcWsKVpEZS50bkLf9lppxJQE+fkCjnY2nhijvq6brSeWhlj8n95VLtf9
         fxvgDr5nHGGJpPI5xcxYbDbZW6OHff+QKTk12aSpa/thKQdBa9v62YnvoAx5JMtppWnN
         LopQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=9KihD59o8exXxKhs+626FRzpoHm5LgtYCwka81Fqj6g=;
        b=0Oh36c1ur6Y6ned4B1rJZIX3p/IBoDJfMbdQgpUFhei7xTkBTaik7PJ1HRISvUMCax
         x5CZdiaxyUy3R2zs0dP38LshSc3un0wouOU9aeeCck5XoNM+8kzlBak1o0mBoz3VfgMs
         r5hdnq7eetKU3LitNOFW1zsqhVaLIh+vjiQjK79JZu6g2GffTxKxs4vRsbRg284UFaNw
         dlV9FfXPbtOLumSXF1qnEcyzqbfPpadc+8VyBDzzTSxA0zngjkhp2HHf1rBEvetk8TUS
         MjKM40TmD5dkiFNW/BtD7ncmZTO0qJQk/A9vJYE+jO9x0qAoZOlcbqeLG6UCUZU6YfxZ
         cKfQ==
X-Gm-Message-State: ACrzQf0IUmBXyIMnkx12jar2mmliyr6jbGsIgjJ+pvXTmiZpxWvLIHsM
        rsjyErmu27PkItrm6K3QwWj01dvzhd312fQxh2GwQw==
X-Google-Smtp-Source: AMsMyM7zkAM61F8P5dcfb43VWTWJZom4duMt7hRBrUS/zkIW00wwOW2WECT6v8+L7bMLJlMkGf11UfPeDVggr9VHL30=
X-Received: by 2002:a2e:3808:0:b0:26d:d0d2:2ecf with SMTP id
 f8-20020a2e3808000000b0026dd0d22ecfmr2013400lja.17.1664800932136; Mon, 03 Oct
 2022 05:42:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220915165407.1776363-1-yu.c.chen@intel.com> <CAKfTPtD3L4437htX__mCNBZJ+fv4MEdnNhCG2kBoQYhVESB_fg@mail.gmail.com>
 <YzcfAOLswvY05s0n@chenyu5-mobl1>
In-Reply-To: <YzcfAOLswvY05s0n@chenyu5-mobl1>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 3 Oct 2022 14:42:00 +0200
Message-ID: <CAKfTPtBiH-CbRvUJLU38ZQQocQ=pfGK-vStfDLpZmT47-95BKg@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/fair: Choose the CPU where short task is
 running during wake up
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Sept 2022 at 18:53, Chen Yu <yu.c.chen@intel.com> wrote:
>
> Hi Vincent,
> On 2022-09-29 at 10:00:40 +0200, Vincent Guittot wrote:
> [cut]
> > >
> > > This idea has been suggested by Rik at LPC 2019 when discussing
> > > the latency nice. He asked the following question: if P1 is a small-time
> > > slice task on CPU, can we put the waking task P2 on the CPU and wait for
> > > P1 to release the CPU, without wasting time to search for an idle CPU?
> > > At LPC 2021 Vincent Guittot has proposed:
> > > 1. If the wakee is a long-running task, should we skip the short idle CPU?
> > > 2. If the wakee is a short-running task, can we put it onto a lightly loaded
> > >    local CPU?
> >
> > When I said that, I had in mind to use the task utilization (util_avg
> > or util_est) which reflects the recent behavior of the task but not to
> > compute an average duration
> >
> Ah I see. However there is a scenario(will-it-scale context switch sub-test)
> that, if task A is doing frequent ping-pong context switch with task B on one
> CPU, we should avoid cross-CPU wakeup, by placing the wakee on the same CPU
> as the waker. Since util_avg/est might be high for both waker and wakee,
> we use the average duration to detect this scenario.

yeah, this can be up to 50%

> > >
> > > Current proposal is a variant of 2:
> > > If the target CPU is running a short-time slice task, and the wakee
> > > is also a short-time slice task, the target CPU could be chosen as the
> > > candidate when the system is busy.
> > >
> > > The definition of a short-time slice task is: The average running time
> > > of the task during each run is no more than sysctl_sched_min_granularity.
> > > If a task switches in and then voluntarily relinquishes the CPU
> > > quickly, it is regarded as a short-running task. Choosing
> > > sysctl_sched_min_granularity because it is the minimal slice if there
> > > are too many runnable tasks.
> > >
> [cut]
> > >
> > > +/*
> > > + * If a task switches in and then voluntarily relinquishes the
> > > + * CPU quickly, it is regarded as a short running task.
> > > + * sysctl_sched_min_granularity is chosen as the threshold,
> > > + * as this value is the minimal slice if there are too many
> > > + * runnable tasks, see __sched_period().
> > > + */
> > > +static int is_short_task(struct task_struct *p)
> > > +{
> > > +       return (p->se.sum_exec_runtime <=
> > > +               (p->nvcsw * sysctl_sched_min_granularity));
> >
> > you assume that the task behavior will never change during is whole life time
> >
> I was thinking that the average running time of a task could slowly catch
> up with the latest task behavior, but yes, there would be delay especially

Because you don't forget oldest activity, it will be more and more
difficult to catch up with the latest behavior.

> for rapid changing tasks(and similar to rq->avg_idle). I wonder if we
> could use something like:
>         return (p->se.avg.util_avg <=
>                 (p->nvcsw * PELT(sysctl_sched_min_granularity));

What is PELT(sysctl_sched_min_granularity) ?

You need at least a runtime and a period to compute something similar
to a PELT value.

As an example, a task running A ms every B ms period will have  an util_avg  of
At wakeup, util_avg = (1-y^A)/(1-y^B)*1024*y^(B-A) with y^32=1/2
Before sleeping, util_avg = (1-y^A)/(1-y^B)*1024

To be exact, it's running A segments of 1024us every period of B
segments of 1024us

> to reflect the recent behavior of the task.
>
> thanks,
> Chenyu
