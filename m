Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CEF67B69C
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 17:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235150AbjAYQJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 11:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjAYQJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:09:42 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19DE0269D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:09:39 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hw16so48893498ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 08:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EXiBfmjBcNQi6pbbKA6odtfqgTnbP7xKpjz3EIYAoWA=;
        b=bqAjMVGbSh56sitJjC6TBhv2/ziWvyXrr2I4b9nf5yd+FYIfSW7rMWpECx81C/OQkU
         io4DxTSrp+dUdg7KuqPUbuqJdmqc9ODVekc9aH00UurWuLPRcToiesaYAJe2KNWispc+
         cPcNYvfPC9gxqoUkReA63D0zZlJUHbOy+SYdBD4iD+uhz+cE+gy2LXfEVnRfXVS4/5jJ
         RALqS1bCTDOy6ZWp0Oj3DzPSYhqUJbGitj1UD9xVBaLaxN4XVqO9vQLfiSQnJnf+eaRo
         uCwkgApVarU9YUCgdicZIhwnSC2EcMqNBhZAGAvNBDRGnwThro6o+M40e35G1U/hvNHK
         FjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXiBfmjBcNQi6pbbKA6odtfqgTnbP7xKpjz3EIYAoWA=;
        b=z81og/taYCuTg56y26LWD+EERGfmtfgCEth8T3gFhIIldUgH0zax9teCSoJ3Lqa3iT
         BHaUqcCWkITF2pfZSIBBLQiVV9Ef8ivCFnbpZ8QbKb1CO5G5waqL/SQoNYU7bb8KEjFP
         zJNKPUBNCan5V052eNTPV7fq9+TskXtcmiK1EpmTbLD5bo9i2TgcZbsUb5vv6MQ69E4E
         N89eD7iHgjMgbDIw4DDDq/vP0B/Qf1DanNNERAOCPlS+hFEhUJMtmkzXdiIGnC90yQPX
         aJB2y5Rlhb9eMjkrOJ5qgp1WiJDSfvb5RwHPSeIKVsLgorLvtse89vMp0wgNj9Mu1jUy
         R4Tw==
X-Gm-Message-State: AFqh2kpQ7bQ7O2+mXIq6jUwfQ39e/kcQvVuzIESlTyRCUX2F8dMnPfIZ
        iy0x1rkMpjWmGCMSHxCd4wUQfw==
X-Google-Smtp-Source: AMrXdXtibQKw3EEjfqjP3ENuoUdf9GlUkDyGHor7qaxU4f+xrVhILm0Tfqr78dzvR3+XeL33tt2Auw==
X-Received: by 2002:a17:906:3396:b0:871:ac32:88a6 with SMTP id v22-20020a170906339600b00871ac3288a6mr34361938eja.39.1674662977532;
        Wed, 25 Jan 2023 08:09:37 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id p9-20020a170906614900b0084d43def70esm2540890ejl.25.2023.01.25.08.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 08:09:37 -0800 (PST)
Date:   Wed, 25 Jan 2023 16:09:35 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>, mingo@kernel.org,
        peterz@infradead.org, dietmar.eggemann@arm.com, rafael@kernel.org,
        viresh.kumar@linaro.org, vschneid@redhat.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        lukasz.luba@arm.com, wvw@google.com, xuewen.yan94@gmail.com,
        han.lin@mediatek.com, Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v4] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <20230125160935.7qms26b4yx3l2rbg@airbuntu>
References: <20230119174244.2059628-1-vincent.guittot@linaro.org>
 <Y9CJ3w4q/NCw5RcK@e126311.manchester.arm.com>
 <CAKfTPtAm39hJk_=M08ceFUFwac2jj92-z=r2cev3K9JZ1xHDxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtAm39hJk_=M08ceFUFwac2jj92-z=r2cev3K9JZ1xHDxg@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/25/23 09:37, Vincent Guittot wrote:
> On Wed, 25 Jan 2023 at 02:46, Kajetan Puchalski
> <kajetan.puchalski@arm.com> wrote:
> >
> > Hi,
> >
> > > By taking into account uclamp_min, the 1:1 relation between task misfit
> > > and cpu overutilized is no more true as a task with a small util_avg may
> > > not fit a high capacity cpu because of uclamp_min constraint.
> > >
> > > Add a new state in util_fits_cpu() to reflect the case that task would fit
> > > a CPU except for the uclamp_min hint which is a performance requirement.
> > >
> > > Use -1 to reflect that a CPU doesn't fit only because of uclamp_min so we
> > > can use this new value to take additional action to select the best CPU
> > > that doesn't match uclamp_min hint.
> > >
> >
> > Just wanted to include some more test data here to flag potential issues
> > with how all these changes use thermal pressure in the scheduler.
> >
> > For the tables below, 'baseline' is pre the already merged "uclamp fits
> > capacity" patchset.
> > 'baseline_ufc' is the current mainline with said patchset applied.
> > The 'no_thermal' variants are variants with thermal handling taken out
> > of util_fits_cpu akin to the v1 variant of the patchset.
> > The 'patched' variants are the above but with the v4 of the 'unlink misfit
> > task' patch applied as well.
> >
> > Geekbench 5:
> >
> > +-----------------+-------------------------+--------+-----------+
> > |     metric      |         kernel          | value  | perc_diff |
> > +-----------------+-------------------------+--------+-----------+
> > | multicore_score |        baseline         | 2765.4 |   0.0%    |
> > | multicore_score |      baseline_ufc       | 2704.3 |  -2.21%   | <-- mainline score regression
> > | multicore_score | baseline_ufc_no_thermal | 2870.8 |   3.81%   | <-- ~170 pts better without thermal
> > | multicore_score |     ufc_patched_v4      | 2839.8 |   2.69%   | <-- no more regression but worse than above
> > | multicore_score | ufc_patched_no_thermal  | 2891.0 |   4.54%   | <-- best score
> > +-----------------+-------------------------+--------+-----------+
> >
> > +--------------+--------+-------------------------+--------+-----------+
> > |  chan_name   | metric |         kernel          | value  | perc_diff |
> > +--------------+--------+-------------------------+--------+-----------+
> > | total_power  | gmean  |        baseline         | 2664.0 |   0.0%    |
> > | total_power  | gmean  |      baseline_ufc       | 2621.5 |   -1.6%   |
> > | total_power  | gmean  | baseline_ufc_no_thermal | 2710.0 |   1.73%   |
> > | total_power  | gmean  |     ufc_patched_v4      | 2729.0 |   2.44%   |
> > | total_power  | gmean  | ufc_patched_no_thermal  | 2778.1 |   4.28%   |
> > +--------------+--------+-------------------------+--------+-----------+
> >
> > (Jankbench scores show more or less no change, Jankbench power below)
> >
> > +--------------+--------+------------------------------+-------+-----------+
> > |  chan_name   | metric |            kernel            | value | perc_diff |
> > +--------------+--------+------------------------------+-------+-----------+
> > | total_power  | gmean  |        baseline_60hz         | 135.9 |   0.0%    |
> > | total_power  | gmean  |      baseline_ufc_60hz       | 155.7 |  14.61%   | <-- mainline power usage regression
> > | total_power  | gmean  | baseline_ufc_no_thermal_60hz | 134.5 |  -1.01%   | <-- no more regression without the thermal bit
> > | total_power  | gmean  |     ufc_patched_v4_60hz      | 131.4 |  -3.26%   | <-- no more regression with the patch either
> > | total_power  | gmean  | ufc_patched_no_thermal_60hz  | 140.4 |   3.37%   | <-- both combined increase power usage
> > +--------------+--------+------------------------------+-------+-----------+
> >
> > Specifically the swing of +15% power to -1% power by taking out thermal
> > handling from util_fits_cpu on the original patchset is noteworthy. It
> > shows that there's some subtle thermal-related interaction there taking
> > place that can have adverse effects on power usage.
> >
> > Even more interestingly, the 'unlink misfit task' patch appears to be
> > preventing said interaction from happening down the line as it has a
> > similar effect to that of just taking out the thermal bits.
> >
> > My only concern here is that without taking a closer look at the thermal
> > parts this power issue shown above could easily accidentally be
> > reintroduced at some point in the future.
> 
> Yes, the handling of thermal pressure needs some closer look. It has
> been agreed to keep the current behavior for now and have a closer
> look on thermal pressure as a next step. And your results for
> ufc_patched_v4_* provide some reasonably good perf and power figures.

Note that the GB perf improvements can be pure accidental because now some UI
tasks that are boosted end up spending more time on medium and big cores and
increasing the higher frequency residency there.

For example looking at my old result against v1 of my patches I can see for the
big cores the top frequency residency moves from 11.74% (mainline-sh 5.10
kernel) to 18.98%. I see tasks with uclamp_min value of 512 in the system.
On medium it improves by ~2% (30% to 32%).

Note that userspace now can dynamically set uclamp_min values and we don't
understand how this interaction goes.

I luckily had some old data of the results I collected when I ran v1 to
hopefully help demonstrate how uclamp_min behaves:

	Kernel B here is: Stock android12-5.10 without out of tree sched changes.
	Kernel C: Kernel B + v1 of my patches.

(Kernel A was the stock kernel in my experiments if you're wondering)

The first two tables show uclamp_min values per cpu. Note how with my fixes now
512 values are more dominant on cpus 4-7 (75% is 512).

The second set of tables shows the non zero uclamp_min values per task. Note
how on Kernel B the max is 398 for many tasks. On Pixel 6 the capacities are:

	L: 160
	M: 498
	B: 1024

498 * 0.8 = 398. So they get capped to 80% which is the migration margin
I resolved the relationship with.

Also note how AyncTask get boosted to 512 on Kernel C while they don't seem to
be boosted on Kernel B. Not sure why. I assume something with the cgroup
settings changes for some reason. Userspace configuration is not tuned to this
behavior anyway so I'm not sure what we see is optimal. So I'd take results
generally with a grain of salt. Note the 512 boost will result in these tasks
preferring big cores more to honour uclamp_min.

Also note how RenderThread and hwuiTask have big standard deviation as they are
dynamically adjusted. RenderThread 50% goes from 442 to 496; which is near the
top boundary of the medium core. Last set of tables show the count for how many
each value was seen for RenderThread for each kernel.

Overall this demonstrates there's a complex set of interactions going on. And
generally geekbench is not a workload that I'd expect to benefit from uclamp
and saying that we improved/regressed can be misleading. I can't say for sure,
but it seems to benefit from few happy accidents. We need to look at this in
the light of how uclamp_min is being used by userspace.

FWIW I'll be backporting these patches to GKI and will run another detailed
analysis. For now I think what we have makes sense and is a good improvement.

(I'm still testing v4 with my unit test - need a bit more time as I'm trying to
improve my unit test too)

--->8---


Kernel B uclamp CFS
       count      mean        std  min  25%  50%  75%    max
cpu
0    87542.0  0.172397   7.836326  0.0  0.0  0.0  0.0  512.0
1    87829.0  0.383404  11.910648  0.0  0.0  0.0  0.0  512.0
2    81713.0  0.371801  11.621681  0.0  0.0  0.0  0.0  512.0
3    85040.0  0.334113  11.160260  0.0  0.0  0.0  0.0  512.0
4    93270.0  1.032915  20.262032  0.0  0.0  0.0  0.0  512.0
5    93820.0  1.057003  20.036322  0.0  0.0  0.0  0.0  512.0
6    71159.0  4.901868  46.765630  0.0  0.0  0.0  0.0  512.0
7    78797.0  4.414445  43.265857  0.0  0.0  0.0  0.0  512.0

Kernel C uclamp CFS
       count        mean         std  min  25%    50%    75%    max
cpu
0    78514.0   55.845161  159.535262  0.0  0.0    0.0    0.0  512.0
1    78231.0   73.549296  179.461818  0.0  0.0    0.0    0.0  512.0
2    73310.0   80.742873  186.373848  0.0  0.0    0.0    0.0  512.0
3    69998.0   86.269151  191.512815  0.0  0.0    0.0    0.0  512.0
4    86887.0  169.776802  240.719169  0.0  0.0    0.0  512.0  512.0
5    87763.0  176.961875  243.162097  0.0  0.0    0.0  512.0  512.0
6    83600.0  257.773505  255.694248  0.0  0.0  506.0  512.0  512.0
7    74770.0  217.606380  252.568571  0.0  0.0    0.0  512.0  512.0

Kernel B uclamp SE
                  count        mean         std    min    25%    50%    75%    max
comm
AudioThread         8.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
Chrome_ChildIOT    35.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
Chrome_DevTools     2.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
Chrome_IOThread   132.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
Chrome_InProcGp    74.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
Chrome_ProcessL    22.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
CleanupReferenc     3.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
CookieMonsterBa     2.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
CookieMonsterCl     4.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
CrAsyncTask #1      3.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
MemoryInfra         5.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
NetworkService     20.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
RenderThread      773.0  350.175938  181.779995    6.0  225.0  448.0  512.0  512.0
SharedPreferenc     1.0  398.000000         NaN  398.0  398.0  398.0  398.0  398.0
Thread-2            1.0  398.000000         NaN  398.0  398.0  398.0  398.0  398.0
Thread-3            5.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
ThreadPoolForeg   156.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
ThreadPoolServi    47.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
ThreadPoolSingl    13.0  415.538462   42.810854  398.0  398.0  398.0  398.0  512.0
VizWebView        128.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
droid.launcher3    10.0  512.000000    0.000000  512.0  512.0  512.0  512.0  512.0
getprop            21.0  512.000000    0.000000  512.0  512.0  512.0  512.0  512.0
hwuiTask0         219.0  310.917808  190.832514    6.0   90.0  307.0  512.0  512.0
hwuiTask1         230.0  331.786957  186.994297    6.0  225.0  307.0  512.0  512.0
labs.geekbench5  1037.0  344.688525  180.838188    6.0  175.0  398.0  512.0  512.0
ll.splashscreen    99.0  457.060606  106.420692  253.0  512.0  512.0  512.0  512.0
mali-cmar-backe    17.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
mali-mem-purge     40.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
mali-utility-wo    18.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
ndroid.systemui    88.0  197.022727  197.388407   31.0   52.0   52.0  512.0  512.0
queued-work-loo     5.0  398.000000    0.000000  398.0  398.0  398.0  398.0  398.0
sh                  7.0  512.000000    0.000000  512.0  512.0  512.0  512.0  512.0

Kernel C uclamp SE
                    count        mean         std    min     25%    50%    75%    max
comm
AsyncTask #1     128468.0  512.000000    0.000000  512.0  512.00  512.0  512.0  512.0
AudioThread           8.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
Chrome_ChildIOT      35.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
Chrome_DevTools       2.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
Chrome_IOThread     154.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
Chrome_InProcGp      91.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
Chrome_ProcessL      18.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
CleanupReferenc       3.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
CookieMonsterBa       2.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
CookieMonsterCl       5.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
CrAsyncTask #1        3.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
MemoryInfra           4.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
NetworkService       18.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
RenderThread        965.0  380.451813  172.243131    6.0  235.00  496.0  512.0  512.0
SharedPreferenc       1.0  512.000000         NaN  512.0  512.00  512.0  512.0  512.0
Thread-2              1.0  436.000000         NaN  436.0  436.00  436.0  436.0  436.0
Thread-3              5.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
ThreadPoolForeg     161.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
ThreadPoolServi      38.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
ThreadPoolSingl      13.0  447.692308   28.540569  436.0  436.00  436.0  436.0  512.0
VizWebView          115.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
droid.launcher3      12.0  512.000000    0.000000  512.0  512.00  512.0  512.0  512.0
getprop              31.0  512.000000    0.000000  512.0  512.00  512.0  512.0  512.0
hwuiTask0           249.0  368.489960  174.171868    9.0  169.00  496.0  512.0  512.0
hwuiTask1           254.0  354.704724  179.083049    6.0  169.00  458.0  512.0  512.0
labs.geekbench5    1008.0  361.363095  181.320417    6.0  201.25  436.0  512.0  512.0
ll.splashscreen      73.0  422.493151   83.830206  283.0  446.00  446.0  458.0  512.0
mali-cmar-backe      21.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
mali-mem-purge       35.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
mali-utility-wo      17.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
ndroid.systemui     201.0  290.731343  195.719308   51.0  109.00  140.0  512.0  512.0
queued-work-loo       7.0  436.000000    0.000000  436.0  436.00  436.0  436.0  436.0
sh                   21.0  512.000000    0.000000  512.0  512.00  512.0  512.0  512.0

Kernel B RenderThread
512    361
253     59
307     40
84      39
264     37
52      36
225     30
16      28
398     21
472     19
448     13
43       5
216      5
375      5
138      4
87       4
143      4
112      4
501      4
21       4
190      4
6        4
67       4
25       4
175      4
347      3
13       3
126      3
93       3
103      3
129      3
100      2
78       2
413      2
97       2
242      1
75       1
31       1
115      1
81       1

Kernel C RenderThread
512    393
506     75
496     75
169     52
321     46
104     33
109     31
283     30
9       21
436     21
446     17
92      17
231     16
458     15
325     13
140     11
13       8
19       8
358      6
276      6
50       5
237      5
70       5
224      4
47       4
374      4
361      4
415      3
99       3
82       3
235      3
44       3
249      3
6        3
190      3
507      3
93       3
22       2
31       2
347      2
75       2
463      1
51       1

--->8---

Cheers

--
Qais Yousef
