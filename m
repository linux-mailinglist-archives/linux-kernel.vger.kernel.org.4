Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8A2669B45
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 16:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjAMPAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 10:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjAMO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 09:59:53 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B47325F498;
        Fri, 13 Jan 2023 06:50:53 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 434F7FEC;
        Fri, 13 Jan 2023 06:51:35 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AFB1F3F67D;
        Fri, 13 Jan 2023 06:50:49 -0800 (PST)
Date:   Fri, 13 Jan 2023 14:50:44 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@kernel.org, peterz@infradead.org, dietmar.eggemann@arm.com,
        qyousef@layalina.io, rafael@kernel.org, viresh.kumar@linaro.org,
        vschneid@redhat.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukasz.luba@arm.com, wvw@google.com,
        xuewen.yan94@gmail.com, han.lin@mediatek.com,
        Jonathan.JMChen@mediatek.com
Subject: Re: [PATCH v2] sched/fair: unlink misfit task from cpu overutilized
Message-ID: <Y8FvtLGdRK8ZdOvd@e126311.manchester.arm.com>
References: <20221228165415.3436-1-vincent.guittot@linaro.org>
 <Y8FhfyVyUDZ98hKD@e126311.manchester.arm.com>
 <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCmDA8WPrhFc8YxFXSOPOKasvvNWA3iOmRYcC2VSyMMrw@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I was testing this on a Pixel 6 with a 5.18 android-mainline kernel with

> Do you have more details to share on your setup ?
> Android kernel has some hack on top of the mainline. Do you use some ?
> Then, the perf and the power can be largely impacted by the cgroup
> configuration. Have you got details on your setup ?

The kernel I use has all the vendor hooks and hacks switched off to
keep it as close to mainline as possible. Unfortunately 5.18 was the
last mainline that worked on this device due to some driver issues so we
just backport mainline scheduling patches as they come out to at least
keep the scheduler itself up to date.

> I just sent a v3 which fixes a condition. Wonder if this could have an
> impact on the results both perf and power

I don't think it'll fix the GB5 score side of it as that's clearly
related to overutilization while the condition changed in v3 is inside
the non-OU section of feec(). I'll still test the v3 on the weekend
if I have some free time.

The power usage issue was already introduced in the uclamp fits capacity
patchset that's been merged so I doubt this change will be enough to
account for it but I'll give it a try regardless.

> > The most likely cause for the regression seen above is the decrease in the amount of
> > time spent while overutilized with these patches. Maximising
> > overutilization for GB5 is the desired outcome as the benchmark for
> > almost its entire duration keeps either 1 core or all the cores
> > completely saturated so EAS cannot be effective. These patches have the
> > opposite from the desired effect in this area.
> >
> > +----------------------------+--------------------+--------------------+------------+
> > |          kernel            |        time        |     total_time     | percentage |
> > +----------------------------+--------------------+--------------------+------------+
> > |          baseline          |      121.979       |      181.065       |   67.46    |
> > |        baseline_ufc        |      120.355       |      184.255       |   65.32    |
> > |        ufc_patched         |       60.715       |      196.135       |   30.98    | <-- !!!
> > +----------------------------+--------------------+--------------------+------------+
>
> I'm not surprised because some use cases which were not overutilized
> were wrongly triggered as overutilized so switching back to
> performance mode. You might have to tune the uclamp value

But they'd be wrongly triggered with the 'baseline_ufc' variant while
not with the 'baseline' variant. The baseline here is pre taking uclamp
into account for cpu_overutilized, all cpu_overutilized did on that
kernel was compare util against capacity.
Meaning that the 'real' overutilised would be in the ~67% ballpark while
the patch makes it incorrectly not trigger more than half the time. I'm
not sure we can tweak uclamp enough to fix that.

> >
> > 2. Jankbench (power usage regression)
> >
> > +--------+---------------+---------------------------------+-------+-----------+
> > | metric |   variable    |             kernel              | value | perc_diff |
> > +--------+---------------+---------------------------------+-------+-----------+
> > | gmean  | mean_duration |          baseline_60hz          | 14.6  |   0.0%    |
> > | gmean  | mean_duration |        baseline_ufc_60hz        | 15.2  |   3.83%   |
> > | gmean  | mean_duration |        ufc_patched_60hz         | 14.0  |  -4.12%   |
> > +--------+---------------+---------------------------------+-------+-----------+
> >
> > +--------+-----------+---------------------------------+-------+-----------+
> > | metric | variable  |             kernel              | value | perc_diff |
> > +--------+-----------+---------------------------------+-------+-----------+
> > | gmean  | jank_perc |          baseline_60hz          |  1.9  |   0.0%    |
> > | gmean  | jank_perc |        baseline_ufc_60hz        |  2.2  |  15.39%   |
> > | gmean  | jank_perc |        ufc_patched_60hz         |  2.0  |   3.61%   |
> > +--------+-----------+---------------------------------+-------+-----------+
> >
> > +--------------+--------+---------------------------------+-------+-----------+
> > |  chan_name   | metric |             kernel              | value | perc_diff |
> > +--------------+--------+---------------------------------+-------+-----------+
> > | total_power  | gmean  |          baseline_60hz          | 135.9 |   0.0%    |
> > | total_power  | gmean  |        baseline_ufc_60hz        | 155.7 |  14.61%   | <-- !!!
> > | total_power  | gmean  |        ufc_patched_60hz         | 157.1 |  15.63%   | <-- !!!
> > +--------------+--------+---------------------------------+-------+-----------+
> >
> > With these patches while running Jankbench we use up ~15% more power
> > just to achieve roughly the same results. Here I'm not sure where this
> > issue is coming from exactly but all the results above are very consistent
> > across different runs.
> >
> > > --
> > > 2.17.1
> > >
> > >
