Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9DE6A0CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 16:12:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234406AbjBWPMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 10:12:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbjBWPMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 10:12:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61DBC532B2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:12:21 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h14so2275448wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 07:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c93jTiIKPExdcIWzQaE+Yl5c9JFTuqHcaXbOwnsUttk=;
        b=AyuhKUpGyEH6HGv6G6CO7PmYJgDRoY7UNdFNV2GIlR/wa4S5EKMhVWuCNUfjmgrr1Q
         sc6HapUkUicl1UpiZbIfymif2jzSDJo6Rjbd+tdj7VDMyhLsB6CUPnoEhgwSxRoa8z9o
         Nw44joTuXloIVXS6mr1E3MqVki/U6Ky//kZMNS4tWYoVvpUr4NvghSpY3MBiDNkD1aNg
         irgBTYyjpTpxjeJHBuzJp7R129adJYknbv+TQ4/rIJgyLd+u0yxc0lcIZ24crA7XtCgG
         tlmSi/+Grso+S0LRNho+wM7IFI+NuxJ4N/qzVG7aDSUVGKzPfgYrLJrnIND3ck8LGv4K
         GAig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c93jTiIKPExdcIWzQaE+Yl5c9JFTuqHcaXbOwnsUttk=;
        b=h2Otd/Sib9BmtOTRsn8rW4vIpy3aJIl0fsu27/pYGpjams4C8i+AZyYFJ8QnL9Okoa
         Zlqc7jEn9FFznMK9Ats1UNJGsPkJyHy/SoWreQf/xtR3T+9QKPKNq9Q4UpcnI25DK+yk
         vHzNeQByAAYF+UTSAA9d9uPHaWOBvHxDb5GX0Cj8Fu4VkpaOHWrrbjadvL+0hB4moDr4
         wf9+a0ouQVHTcyTr75lWSz5rsBiKA/W3zLOgxhgahn8ntFd4zdWNzCPMuPhuQ+KpAAFG
         jH+0dMY5TV34NdUhVuUAEhYLBYZXnrkw8UkaBQJsrQ1j5wKjpAi3BbngtmcnDecMD1Vq
         cX2g==
X-Gm-Message-State: AO0yUKWAkLWqTp0tRSTI0OdaGsbbdGS1xZ924PkRryg6n67kRaVlXDto
        hmPv5qDjjI1kVMBKH3L/Ok3iUQ==
X-Google-Smtp-Source: AK7set8DzlQ3dUplHXbr0G16os8nE24iKK12cDZinm5ZaURzQEk1vdI0XwYzD+JChaBhuGDk8dbJHA==
X-Received: by 2002:a5d:568c:0:b0:2c7:478:d1d9 with SMTP id f12-20020a5d568c000000b002c70478d1d9mr8036575wrv.33.1677165139795;
        Thu, 23 Feb 2023 07:12:19 -0800 (PST)
Received: from airbuntu ([104.132.45.105])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d4752000000b002c3f9404c45sm9401568wrs.7.2023.02.23.07.12.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Feb 2023 07:12:18 -0800 (PST)
Date:   Thu, 23 Feb 2023 15:12:17 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Lukasz Luba <lukasz.luba@arm.com>,
        Wei Wang <wvw@google.com>, Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>
Subject: Re: [PATCH v2 1/3] sched/uclamp: Set max_spare_cap_cpu even if
 max_spare_cap is 0
Message-ID: <20230223151217.dnf2sge2vsqi7lte@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
 <2d92b035-4bf7-5199-b852-540ff3edee98@arm.com>
 <20230214180950.fkcpoirtjgpp3kys@airbuntu>
 <a7f9fea0-debf-3774-7367-2e842895669c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a7f9fea0-debf-3774-7367-2e842895669c@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/23 13:20, Dietmar Eggemann wrote:

> I analyzed one of the last traces I got with my example:
> 
> During the initial wakeup the system is in CPU OU. So feec() returns
> `target = -1` and `sis()->sic()` (a) does the initial placement for all
> the 6 tasks.
> 
> CPU  (a)     (b) (c) (d)    (e)
>       ^       ^   ^   ^      ^
>  0   t1-------->| |
>  1   t0 t3    |t5 |t1 |t4|   |   |   |   | ...
>  2   t2--------------------->|
>  3
>  4   t4------------>| |
>  5   t5---->| |
> 
> (b) feec() for t5:
> 
>     eenv_pd_busy_time()
> 
>       pd_busy_time = 1998 = 994 (CPU1) + 1004 (CPU2)
> 
>     compute_energy()
> 
>       busy_time = min(pd_capacity, pd_busy_time + task_busy_time)
> 
>                 = min(2048, 1998 + 921)
> 
>                 = 2048
> 
>     We go into saturation here and EAS assumes it can place t5 for the
>     cost of 2048 - 1998 = 50 util where in reality t5 has a util of
>     ~921. And that's why t5 ends up on CPU1 too.

So to rephrase as it was hard to follow your line thoughts.

The problem you're highlighting is that with uclamp_max we can end up with
a fully utilized pd. But the energy cost of this always-runing pd is capped to
a constant value. But you think this should be modeled better to reflect it'll
run for longer period of time, hence cost more energy.

There are multiple compound issue that makes this difficult to be reflected
accurately and makes think this best-effort is not really as bad as you think:

1. The capacity of little cores has become small, 158 on pixel 6. This makes
   the definition of 'busy' task from the little's point of view rather
   relaxed/small. But there's a strong desire to enable uclamp_max to act as
   a soft affinity to prevent these tasks from interfering with more important
   work on bigger cores and potentially waste power.

2. If the task is truly long running 1024 tasks (even on big core), then
   knowing its actual utilization and runtime would be impossible and we'd have
   to cap it to something. It's basically inifinity.

3. Because of uclamp_max capping, the util_avg could be wrong - depends on
   actually how big the task is compared the uclamp_max. In worst case scenario
   if no idle time is seen util_avg can easily grow into 1024 - although if the
   task is allowed to run uncapped it actually might be 300 or something in
   reality.

4. Because of max aggregation, the uclamp_max tasks are a frequency spike
   hazard. Again if the task is a true 1024 (and capping those tasks is one of
   the major use cases for uclamp_max, if not The Major use case) then as soon
   as uncapped task wakes up on the CPU, there'd be a frequency spike
   regardless of how small this task is.

   If at wake-up it thought a big core is okay, and ends up running for the new
   few 100s ms with randodm rt/kworkers waking up on that core - the big core
   will run enough times at most energy enefficient point of the system. Which
   is a bigger problem as the power cost will be very high and noticeable. And
   uclamp_max isn't being used because of this already today.

   And because this is an always running task for the foreseeable future from
   the scheduler PoV, and, the lack of a downmigration mechanism to move these
   tasks away (I have patches for that - but trying to send fixes one by one),
   these frequency spikes poses a bigger hazard of wasting power than making
   a one off miscalculation at wakeup time. The decision at wake up is sampling
   at that exact instant of time. But generally uclamp_max is desired for those
   long running tasks whose potential energy cost over a long period of time
   (many ticks worth of realtime) is the worrisome. Immediately after that
   sampling time the condition could change even today and render our decision
   completely wrong. And there's no fixing for that. It's the nature of the
   beast.

5 One of the desired properties of uclamp_max in practice is to act as a soft
  affinity. In Android background tasks are restricted by cpuset. But this
  could potentially lead to lost opportunities of better energy placement under
  normal lightly loaded circumstances where there are a lot of small tasks
  running but nothing particularly busy. EAS shines under those scenarios. But
  fails for long running tasks - and here where uclamp_max is expected to help.

> 
> (c) & (d) similar to (b)
> 
> (e) From here on no wakeups anymore. Only tick preemption on CPU1 every
>     4ms (250Hz) between the 5 tasks and t2 finishing on CPU2 eventually.
> 
> >>> Which is the desired behavior for uclamp_max?
> >>
> >> Not sure. Essentially, EAS can't do its job properly if there is no idle 
> > 
> > This "not sure" statement is making me worried. Are you not sure about how
> > uclamp_max should work in force fitting big tasks into small cores? Or just
> > about handling some of the corner cases? I understood the former, not the
> > latter.
> 
> I'm not sure if we can call the issue that EAS doesn't work in
> saturation anymore a corner case. In case uclamp_max has an effect, it
> can quite easily create these saturation scenarios in which EAS is still
> enabled but it can't do its job anymore.
> Making sure that we probe each PD is not getting rid of this more
> fundamental issue.

I disagree with there being a fundamental issue in regards to energy
calculation. I see a potential nice-to-have improvement for estimating energy
calculation of long running tasks.

What I see as a fundamental error that this series is fixing is that the hint
to keep tasks on little cores doesn't work. Being able to consider a better
energy efficient CPU is less of a problem and not sure if it's really affecting
anyone in practice. Today's mainline will not consider any busy task as
a candidate for little core even of uclamp_max says it's okay. The task has to
be small enough (< 158 on pixel 6) for EAS to consider it, but those tasks are
not the ones that need uclamp_max hint.

We could try to remove the min(). But I worry this is premature now before
first introducing my fixes to teach the load balancer to do down migration. And
I think we need to do more to address the frequency spike problem - which I do
have proposals ready to address this problem too.

As it stands we can't use uclamp_max in products, and there are a series of
fixes required to achieve that. And what you see as a fundamental issue is not
one of the blocking issues I am aware of. It seems a nice enhancement to make
the wakeup  energy estimation even better. But I do think it requires some
crystal ball and it'll remain a best effort even after that.

I think the current outcome is the desired behavior to be honest. Maybe we can
do better, but that's a separate problem/question and not a fundamental
blocking to enabling uclamp_max to do what it says on the tin.

I can add this as another limitation in the uclamp doc.

The only thing that probably should do now is add a limit to how much cramming
we can do before we say it's too much for this pd even with uclamp_max. Maybe
we can put a limit based on load_avg as I think it'll continue to grow unlike
util_avg which will settle on 1024.


Thanks!

--
Qais Yousef
