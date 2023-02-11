Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8505F6932E9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 18:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjBKRu7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 12:50:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjBKRu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 12:50:58 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D6010EC
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 09:50:56 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id rp23so22913302ejb.7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 09:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4ImTuAxtloRnmSYKiVuQLOiEQC0YtZvnnLwMt3mOGao=;
        b=MUYC3AEUv85GLt4jtdL1s70yw6xiGkEgk67Z/gwQ4iRhKVrmGc3DmrLToGcbJEFmOJ
         vQZaRH6Ug84bzmpPRZvjLLL5GIRQtMHS4Ub00qEdZHQm87aiWW63/aeYgMj7wQ4ck2rr
         22LF49p/y7aNh6n7NLZ+I3V2mYU1SLELv/f4eN3aslvLr03gra3TMoXzwECkHGjPrNKv
         //xY3bxzifivohpK/lQwXhRV40RgEhQ4aPfoqpDZLNfPocCOW/+nxi/PgwuzXuwsEjDB
         szQELGMG191kYc/1IDRcwdTBZpaVyMZe2tfKsdY28ImaxNruRfccN1P3US/zkXe0ypNz
         rN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4ImTuAxtloRnmSYKiVuQLOiEQC0YtZvnnLwMt3mOGao=;
        b=HPIjCY1jpLZGyoHVjCIEhS547m9ptjVqfzJNdjsGVPjeZXESyMPrCRZILPmN5lLKZ/
         DxakzYfEQPr4aaHOLa+aSCVW0obpxUtxYA1Rlmz2ZGV86e2b/RoZ5NPQTP0vDOrhXMe7
         8yva6aZP+GM/T765ySJNo06BfWGDN0/oUXVrXGNHEE11BKilpOFz2mIRniwLUeC3WQUN
         SzMzbGpRaghGndvtHsqoQ+geBH3lNG/aTiUAH/RT+aswxa8yLeAZFcTm3mZxW/HYONNm
         Te4pSqXjcBjrpyZ0DYkLcAKcOKJ8n2J6Vxi/iu+/+IgNo1WPowgzIwn4ekVJHvMQkpS4
         BMEA==
X-Gm-Message-State: AO0yUKV3Y4VtirMXBY1r+2GqSBGtxPpjkq1GPiB9AfKR8PBEBVrjDEUm
        b4hXCsEMHitnnGz36TwBVdVqqw==
X-Google-Smtp-Source: AK7set+oDSX79czFtOh/wXVlzIQpfdJ1CkEe9FWm4Vw++47NUGq1bt7sVvZ/oDEEaJDmEey/Ed6EnA==
X-Received: by 2002:a17:907:bb8a:b0:888:9bd6:34d2 with SMTP id xo10-20020a170907bb8a00b008889bd634d2mr21116362ejc.63.1676137855309;
        Sat, 11 Feb 2023 09:50:55 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id a23-20020a1709063a5700b0087bcda2b07bsm4046629ejf.202.2023.02.11.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Feb 2023 09:50:54 -0800 (PST)
Date:   Sat, 11 Feb 2023 17:50:52 +0000
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
Message-ID: <20230211175052.b7a4hddhkjk4j6qf@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-2-qyousef@layalina.io>
 <CAKfTPtA9yOncmGuLfo-XaXDZ5F7+9iL-hdyGeaOQi1qrDa_RqQ@mail.gmail.com>
 <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9e935645-9baf-af9f-73bd-3eaeaec044a8@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/09/23 19:02, Dietmar Eggemann wrote:
> On 07/02/2023 10:45, Vincent Guittot wrote:
> > On Sun, 5 Feb 2023 at 23:43, Qais Yousef <qyousef@layalina.io> wrote:
> >>
> >> When uclamp_max is being used, the util of the task could be higher than
> >> the spare capacity of the CPU, but due to uclamp_max value we force fit
> >> it there.
> >>
> >> The way the condition for checking for max_spare_cap in
> >> find_energy_efficient_cpu() was constructed; it ignored any CPU that has
> >> its spare_cap less than or _equal_ to max_spare_cap. Since we initialize
> >> max_spare_cap to 0; this lead to never setting max_spare_cap_cpu and
> >> hence ending up never performing compute_energy() for this cluster and
> >> missing an opportunity for a better energy efficient placement to honour
> >> uclamp_max setting.
> >>
> >>         max_spare_cap = 0;
> >>         cpu_cap = capacity_of(cpu) - task_util(p);  // 0 if task_util(p) is high
> >>
> >>         ...
> >>
> >>         util_fits_cpu(...);             // will return true if uclamp_max forces it to fit
> 
> s/true/1/ ?
> 
> >>
> >>         ...
> >>
> >>         // this logic will fail to update max_spare_cap_cpu if cpu_cap is 0
> >>         if (cpu_cap > max_spare_cap) {
> >>                 max_spare_cap = cpu_cap;
> >>                 max_spare_cap_cpu = cpu;
> >>         }
> >>
> >> prev_spare_cap suffers from a similar problem.
> >>
> >> Fix the logic by converting the variables into long and treating -1
> >> value as 'not populated' instead of 0 which is a viable and correct
> >> spare capacity value.
> 
> The issue I see here is in case we don't have any spare capacity left,
> the energy calculation (in terms CPU utilization) isn't correct anymore.
> 
> Due to `effective_cpu_util()` returning `max=arch_scale_cpu_capacity()`
> you never know how big the `busy_time` for the PD really is in this moment.
> 
> eenv_pd_busy_time()
> 
>   for_each_cpu(cpu, pd_cpus)
>     busy_time += effective_cpu_util(..., ENERGY_UTIL, ...)
>     ^^^^^^^^^
> 
> with:
> 
>   sum_util = min(busy_time + task_busy_time, pd_cap)
>                  ^^^^^^^^^
> 
>   freq = (1.25 * max_util / max) * max_freq
> 
>   energy = (perf_state(freq)->cost / max) * sum_util
> 
> 
> energy is not related to CPU utilization anymore (since there is no idle
> time/spare capacity) left.

Am I right that what you're saying is that the energy calculation for the PD
will be capped to a certain value and this is why you think the energy is
incorrect?

What should be the correct energy (in theory at least)?

> 
> So EAS keeps packing on the cheaper PD/clamped OPP.

Which is the desired behavior for uclamp_max?

The only issue I see is that we want to distribute within a pd. Which is
something I was going to work on and send after later - but can lump it in this
series if it helps.

> 
> E.g. Juno-r0 [446 1024 1024 446 446 446] with 6 8ms/16ms uclamp_max=440
> tasks all running on little PD, cpumask=0x39. The big PD is idle but
> never beats prev_cpu in terms of energy consumption for the wakee.

IIUC I'm not seeing this being a problem. The goal of capping with uclamp_max
is two folds:

	1. Prevent tasks from consuming energy.
	2. Keep them away from expensive CPUs.

2 is actually very important for 2 reasons:

	a. Because of max aggregation - any uncapped tasks that wakes up will
	   cause a frequency spike on this 'expensive' cpu. We don't have
	   a mechanism to downmigrate it - which is another thing I'm working
	   on.
	b. It is desired to keep these bigger cpu idle ready for more important
	   work.

For 2, generally we don't want these tasks to steal bandwidth from these CPUs
that we'd like to preserve for other type of work.

Of course userspace has control by selecting the right uclamp_max value. They
can increase it to allow a spill to next pd - or keep it low to steer them more
strongly on a specific pd.


Cheers

--
Qais Yousef
