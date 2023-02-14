Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5929B696C71
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 19:10:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbjBNSKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 13:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233270AbjBNSJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 13:09:56 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B662686
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:09:53 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o15so13247065wrc.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 10:09:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fOEdqpsXNpVkbh39yn2iE/N1WL0Q2AdRM6SmJ0Ahum0=;
        b=VHaRlmD6/T2wduLrV4m8f4kifgSyeRZua8VpjOH2M+QDpsFIV94SFa/0chKfZgg1EW
         BFV142lJYxr4V1NjSSR3mfgYE+CzTkB2DD5rjGNNMC376cTqmZwdIaovlG3XveKrGfnr
         v9hRuBZJvj9dkllrXnavQ6MwkOpIBllBAGL/Zw9poPqRWKmesK0fiCQyevB5w1GjjoK4
         4VKjG6nlkJDjvktuFGuEwXDdb2DZK74+udsOJub6EYZ1cJET460K6//1VSMDWi4qATWw
         i8BLP5DrtIkLu2J6D8Im6UB1hozq7M40yYgV8VPOdHFxGj1t5Ue46ThJaa2yZEamtKN3
         3t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOEdqpsXNpVkbh39yn2iE/N1WL0Q2AdRM6SmJ0Ahum0=;
        b=RxXcqwtBT2PI5Nm152PCn+8b38GzXvq5ui1y5fuKTxOoBguKVJZUAXTDhlE0c2bjls
         6/0dh3/W0yqicgpPI79Yp71Sg6LuT+n2elVDhXUQo6b3tuM98kXPcm0zwIhRwdycNl0c
         VZJwcZvWt2sZPf1vMpdkgN+5KQc6UaX3CFnL8qtXHBpHbNHG1MVOenLEPNEroyx/GhQd
         RidMWGThWqZE1W5iqwK7eD4J0BrMu6jexbd9jkK2jAe8Nd+CGTuOaacL1Wtt6q3bUyWN
         AMfclXzKnALLMPv+Xy24ruk79aDLayHI7PX3RPrS/ZvFXvam/UsBM4GOuZuCIeO0fjA7
         RCyg==
X-Gm-Message-State: AO0yUKUDwpaIIiJeL40xO5m4eoAExXc456ia61RtUnZD2RcZvYiQ6Lh+
        94XfkPpdjAlwKIAZOezTtifHfg==
X-Google-Smtp-Source: AK7set/s4iCsw57MZNwONirno0A52mcN+g2j/+5RCIjzo/sc4aq5/2AvacfwVkv8AUJnZz87Y2/tGA==
X-Received: by 2002:a5d:458d:0:b0:2c3:d657:e951 with SMTP id p13-20020a5d458d000000b002c3d657e951mr3062987wrq.29.1676398192309;
        Tue, 14 Feb 2023 10:09:52 -0800 (PST)
Received: from airbuntu ([104.132.45.98])
        by smtp.gmail.com with ESMTPSA id y9-20020adfee09000000b002c550eb062fsm8627867wrn.14.2023.02.14.10.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 10:09:51 -0800 (PST)
Date:   Tue, 14 Feb 2023 18:09:50 +0000
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
Message-ID: <20230214180950.fkcpoirtjgpp3kys@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
 <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
 <2d92b035-4bf7-5199-b852-540ff3edee98@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2d92b035-4bf7-5199-b852-540ff3edee98@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/23 13:47, Dietmar Eggemann wrote:
> On 11/02/2023 18:50, Qais Yousef wrote:
> > On 02/09/23 19:02, Dietmar Eggemann wrote:
> >> On 07/02/2023 10:45, Vincent Guittot wrote:
> >>> On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
> 
> [...]
> 
> >>>> Fix the logic by converting the variables into long and treating -1
> >>>> value as 'not populated' instead of 0 which is a viable and correct
> >>>> spare capacity value.
> >>
> >> The issue I see here is in case we don't have any spare capacity left,
> >> the energy calculation (in terms CPU utilization) isn't correct anymore.
> >>
> >> Due to `effective_cpu_util()` returning `max=arch_scale_cpu_capacity()`
> >> you never know how big the `busy_time` for the PD really is in this moment.
> >>
> >> eenv_pd_busy_time()
> >>
> >>   for_each_cpu(cpu, pd_cpus)
> >>     busy_time += effective_cpu_util(..., ENERGY_UTIL, ...)
> >>     ^^^^^^^^^
> >>
> >> with:
> >>
> >>   sum_util = min(busy_time + task_busy_time, pd_cap)
> >>                  ^^^^^^^^^
> >>
> >>   freq = (1.25 * max_util / max) * max_freq
> >>
> >>   energy = (perf_state(freq)->cost / max) * sum_util
> >>
> >>
> >> energy is not related to CPU utilization anymore (since there is no idle
> >> time/spare capacity) left.
> > 
> > Am I right that what you're saying is that the energy calculation for the PD
> > will be capped to a certain value and this is why you think the energy is
> > incorrect?
> > 
> > What should be the correct energy (in theory at least)?
> 
> The energy value for the perf_state is correct but the decision based 
> on `energy diff` in which PD to put the task might not be.
> 
> In case CPUx already has some tasks, its `pd_busy_time` contribution 
> is still capped by its capacity_orig.
> 
> eenv_pd_busy_time() -> cpu_util_next()
>                          return min(util, capacity_orig_of(cpu))
> 
> In this case we can't use `energy diff` anymore to make the decision 
> where to put the task.
> 
> The base_energy of CPUx's PD is already so high that the 
> `energy diff = cur_energy - base_energy` is small enough so that CPUx 
> is selected as target again.

I'm sorry bear with me as I'm still struggling to fully understand the case.

You're thinking that if all the CPUs in the pd are _already_ fully busy before
adding this newly woken up task there, then we'll end up with the wrong
energy_diff? IOW, when the pd is fully loaded, then the cost of adding extra
load will always look cheap is what you're saying?

> 
> >> So EAS keeps packing on the cheaper PD/clamped OPP.
> 
> Sometimes yes, but there are occurrences in which a big CPU ends up
> with the majority of the tasks. It depends on the start condition.

It should depend on the energy cost, yes. Which does depend on the current
state of the system.

> 
> > Which is the desired behavior for uclamp_max?
> 
> Not sure. Essentially, EAS can't do its job properly if there is no idle 

This "not sure" statement is making me worried. Are you not sure about how
uclamp_max should work in force fitting big tasks into small cores? Or just
about handling some of the corner cases? I understood the former, not the
latter.

> time left. As soon as uclamp_max restricts the system (like in my
> example) task placement decisions via EAS (min energy diff based) can be
> wrong. 

I'm assuming 'no idle time' refers to the pd being fully loaded already
_before_ placing the newly woken up task. If you refer to it not having idle
time _after_ placing it - then I'm confused as one of the goals of uclamp_max
is to act as a task placement hint and if it can't do that in this simple
scenarios, it won't be much useful? I can appreciate it failing at some corner
cases. But for example if a little core is idle and a 1024 task wakes up with
uclamp_max that makes the little a candidate; then yeah it'll not leave any
idle time on that cpu - but placing it there (if it the energy efficient cpu)
is the desired effect, no?

> 
> > The only issue I see is that we want to distribute within a pd. Which is
> > something I was going to work on and send after later - but can lump it in this
> > series if it helps.
> 
> I assume you refer to
> 
>     } else if ((fits > max_fits) ||
>         ((fits == max_fits) && ((long)cpu_cap > max_spare_cap))) {
> 
> here?

Yes. If there are multiple cpus with the same max_spare_cap maybe we can
distribute among them rather than always pick the first one.

> 
> >> E.g. Juno-r0 [446 1024 1024 446 446 446] with 6 8ms/16ms uclamp_max=440
> >> tasks all running on little PD, cpumask=0x39. The big PD is idle but
> >> never beats prev_cpu in terms of energy consumption for the wakee.
> > 
> > IIUC I'm not seeing this being a problem. The goal of capping with uclamp_max
> > is two folds:
> > 
> > 	1. Prevent tasks from consuming energy.
> > 	2. Keep them away from expensive CPUs.
> 
> Like I tried to reason about above, the energy diff based task placement
> can't always assure this.

Re assure: It is not expected to be 100% guarantee. But it shouldn't fail
simply too.

> 
> > 
> > 2 is actually very important for 2 reasons:
> > 
> > 	a. Because of max aggregation - any uncapped tasks that wakes up will
> > 	   cause a frequency spike on this 'expensive' cpu. We don't have
> > 	   a mechanism to downmigrate it - which is another thing I'm working
> > 	   on.
> 
> True. And it can also lead to CPU overutilization which then leads to
> load-balancing kicking in.

Yep.

> 
> > 	b. It is desired to keep these bigger cpu idle ready for more important
> > 	   work.
> 
> But this is not happening all the time. Using the same workload
> (6 8ms/16ms uclamp_max=440) on Juno-r0 [446 1024 1024 446 446 446]
> sometimes ends up with all 6 tasks on big CPU1.

This seems similar to a case I see on pinebook pro but with uclamp_min.

$ grep '' /sys/devices/system/cpu/cpu*/cpu_capacity
/sys/devices/system/cpu/cpu0/cpu_capacity:381
/sys/devices/system/cpu/cpu1/cpu_capacity:381
/sys/devices/system/cpu/cpu2/cpu_capacity:381
/sys/devices/system/cpu/cpu3/cpu_capacity:381
/sys/devices/system/cpu/cpu4/cpu_capacity:1024
/sys/devices/system/cpu/cpu5/cpu_capacity:1024

ts, dst_cpu, p_util, uclamp_min, uclamp_max, energy
253049258065, 4, 0, 381, 1024, 10562
253049269732, 3, 0, 381, 1024, 18814
253065609673, 4, 0, 381, 1024, 10562
253065621340, 3, 0, 381, 1024, 17874
253082033696, 4, 0, 381, 1024, 14669
253082045071, 2, 0, 381, 1024, 17403
253098438637, 4, 0, 381, 1024, 14082
253098450011, 3, 0, 381, 1024, 17403
253114803452, 4, 0, 381, 1024, 17016
253114814827, 0, 0, 381, 1024, 16933
253131192435, 4, 0, 381, 1024, 15843
253131204101, 2, 0, 381, 1024, 16933
253147557125, 4, 0, 381, 1024, 18776
253147568500, 0, 0, 381, 1024, 15992
253163935608, 4, 0, 381, 1024, 17603
253163946108, 0, 0, 381, 1024, 15522
253180299382, 4, 0, 381, 1024, 17016
253180306965, 3, 0, 381, 1024, 26811
253196598074, 4, 0, 381, 1024, 16429
253196606532, 0, 0, 381, 1024, 25870
253212953723, 4, 0, 381, 1024, 15256
253212965681, 0, 0, 381, 1024, 25400
253229376288, 4, 0, 381, 1024, 19363

With uclamp_max energy looks different, but p_util is different too which has
impact on compute_energy() calculations

ts, dst_cpu, p_util, uclamp_min, uclamp_max, energy
760154735422179, 4, 407, 0, 381, 237058
760154735426845, 0, 407, 0, 381, 192382
760154751547464, 4, 407, 0, 381, 237058
760154751552131, 0, 407, 0, 381, 191912
760154767690833, 4, 407, 0, 381, 237058
760154767696667, 0, 407, 0, 381, 202730
760154783818744, 4, 407, 0, 381, 237058
760154783823994, 0, 407, 0, 381, 198967
760154799944613, 4, 407, 0, 381, 237058
760154799949280, 0, 407, 0, 381, 198967
760154816074565, 4, 407, 0, 381, 237058
760154816079232, 0, 407, 0, 381, 195675
760154832201309, 4, 407, 0, 381, 237058
760154832205976, 0, 407, 0, 381, 195204
760154848328053, 4, 407, 0, 381, 237058
760154848333012, 0, 407, 0, 381, 193793
760154864453631, 4, 407, 0, 381, 237058
760154864458297, 0, 407, 0, 381, 193793
760154880578333, 4, 407, 0, 381, 237058
760154880583000, 0, 407, 0, 381, 192852
760154896705369, 4, 407, 0, 381, 237058
760154896710619, 0, 407, 0, 381, 192852

I'm not sure if there's an error in compute_energy to be honest - but as you
said depends on the conditions of the system the most energy efficient cpu
could be different.

Without this patch we don't even call compute_energy() for the little core; but
now it is a viable candidate.

> 
> A corresponding EAS task placement looks like this one:
> 
> <idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[1]=0 cpu_util[f|e]=[446 994]  
> <idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[2]=0 cpu_util[f|e]=[445 1004]
> 
> <idle>-0 [005] select_task_rq_fair: CPU5 cpu=1 busy_time=994 util=994 pd_cap=2048
> <idle>-0 [005] select_task_rq_fair: CPU5 cpu=2 busy_time=1998 util=1004 pd_cap=2048
> 
> <idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=-1 energy=821866 pd_busy_time=1998 task_busy_time=921 max_util=446 busy_time=1998 cpu_cap=1024
> <idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=1  energy=842434 pd_busy_time=1998 task_busy_time=921 max_util=446 busy_time=2048 cpu_cap=1024
>                                                             ^^^^^^^^^^^^^
>                                                             diff = 20,568

This is not necessarily a problem, unless the energy calculations are wrong of
course.

Setting uclamp_max near the top capacity of the littles will hopefully make it
run there more often - but we know that the top frequencies of the little are
not necessarily efficient ones too.

Does lowering uclamp_max more towards the 'knee' of the little help keeping the
tasks there?

Note what this patch does is make sure that the little is a 'candidate'. Energy
efficiency is the ultimate choice of which candidate cpu/pd to pick.

Being more strict about uclamp_max choice might be necessary if there's
a stronger desire by userspace to keep the tasks on specific cluster.

If there're errors in calculating energy, I'd appreciate your help on how to
resolve them.


Thanks!

--
Qais Yousef

> 
> <idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[0]=0 cpu_util[f|e]=[440 446] 
> <idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[3]=0 cpu_util[f|e]=[6 6]
> <idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[4]=0 cpu_util[f|e]=[440 446] 
> <idle>-0 [005] select_task_rq_fair: CPU5 p=[task0-5 2551] prev_cpu=5 util=940 uclamp_min=0 uclamp_max=440 cpu_cap[5]=0 cpu_util[f|e]=[440 446] 
> 
> <idle>-0 [005] select_task_rq_fair: CPU5 cpu=0 busy_time=446 util=446 pd_cap=1784
> <idle>-0 [005] select_task_rq_fair: CPU5 cpu=3 busy_time=452 util=2 pd_cap=1784
> <idle>-0 [005] select_task_rq_fair: CPU5 cpu=4 busy_time=898 util=446 pd_cap=1784
> <idle>-0 [005] select_task_rq_fair: CPU5 cpu=5 busy_time=907 util=1 pd_cap=1784
> 
> <idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=-1 energy=242002 pd_busy_time=907 task_busy_time=921 max_util=440 busy_time=907 cpu_cap=446
> <idle>-0 [005] compute_energy: CPU5 p=[task0-5 2551] cpu=5  energy=476000 pd_busy_time=907 task_busy_time=921 max_util=440 busy_time=1784 cpu_cap=446
>                                                             ^^^^^^^^^^^^^
>                                                             diff = 233,998
> 
> <idle>-0 [005] select_task_rq_fair: p=[task0-5 2551] target=1
> 
> > For 2, generally we don't want these tasks to steal bandwidth from these CPUs
> > that we'd like to preserve for other type of work.
> > 
> > Of course userspace has control by selecting the right uclamp_max value. They
> > can increase it to allow a spill to next pd - or keep it low to steer them more
> > strongly on a specific pd.
> 
> [...]
> 
