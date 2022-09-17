Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 827F15BBAE3
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 00:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229483AbiIQWv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Sep 2022 18:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiIQWvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Sep 2022 18:51:53 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD2F6438
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:51:52 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id m66so26329447vsm.12
        for <linux-kernel@vger.kernel.org>; Sat, 17 Sep 2022 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telus.net; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=zhVbauSCHIqSTrZ46LyX7IvRStT/0PO8IONI/ynrObY=;
        b=fNJKbDCWVK1H8vsU8LNcsdPHliCpb0BSeUUq4+g3LX5rnUOXAA/MWFmDeDaJ/JPyLj
         YSbmtD5Axfrnh/lm/2GZ/P6OEpRf4GxfRuzBffxJy2+o5jkgTnSvGqR0/UwNHyrdizD1
         J2LsvRhUKayQLTGkwR/mGEOK2G2YYFz45DNTypnKFERFeq1omkVN6uu9bkpKi7soYJ6Y
         R1jabKCyvb3C2SvTBb9yxuEEQmFOPrK9laSjeZ8ximf4LeZ+himeSryzaxbVKXt8clq+
         WEkXZq+aBQv90xlAVog0K35qKbFF/0xEWPsKZz8vWQ5bB1B5CtnzZAXGK+zPaMajI1ht
         +evQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zhVbauSCHIqSTrZ46LyX7IvRStT/0PO8IONI/ynrObY=;
        b=wlxNKTw+bWrhbbcGoCK3xvVeeNR7CmpoUz89WAep6ttwK0s9ey9jpJXFjy1XaJ7MrN
         5rqd9PYxF7bphn1XbsMpNcfb932SC6MCOBxgCRTCYFIOAttxTx1eE93akvY5PVKt27nN
         qvaiEfSHs4N6QWEVUrUkJ4a/7pRIhawGdlZv+qxoEDJMWNV/A4KrZPBY38iJQAxcQI+A
         S5QJBvcWlntpO8JhVe51NO/6e8DLHvJAS4dMvz7tWW2i2xGzEQwWZYsNeMxsrWcW5BIQ
         amcfMQaBkO54KU3vEU8/Ixo3kaJhRf0UzPZcV4kDS3bzNGjC2Zj1PFhXh5hvvUGxFZQc
         GTJA==
X-Gm-Message-State: ACrzQf1lRPa6TctmX9O68fgcnT1q25p7rc2qDfTTe+Njs9revMUHYYts
        jXQyvvnwtB8E1A2xx/A6c0lFD+KPB55ALTXE9f9L6A==
X-Google-Smtp-Source: AMsMyM7AfQL+7pDetFvxgg0qs1Pphtyz3PrVoR4sfAlTf9d3uBZDwVg06qWeYwrQe03RAT2tyl1HbB9kwUyjmbMIDPg=
X-Received: by 2002:a05:6102:3a61:b0:398:2728:6a72 with SMTP id
 bf1-20020a0561023a6100b0039827286a72mr4158678vsb.36.1663455111322; Sat, 17
 Sep 2022 15:51:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220915164411.2496380-1-kajetan.puchalski@arm.com>
In-Reply-To: <20220915164411.2496380-1-kajetan.puchalski@arm.com>
From:   Doug Smythies <dsmythies@telus.net>
Date:   Sat, 17 Sep 2022 15:51:41 -0700
Message-ID: <CAAYoRsXwPmKHJ8m2aex0ddpf+=dr8ceXDSJM9kX=v5JdeRfgiA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     rafael@kernel.org, daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Doug Smythies <dsmythies@telus.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2022 at 9:45 AM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> Hi,

Hi,

I tried it.

>
> At the moment, all the available idle governors operate mainly based on t=
heir own past performance
> without taking into account any scheduling information. Especially on int=
eractive systems, this
> results in them frequently selecting a deeper idle state and then waking =
up before its target
> residency is hit, thus leading to increased wakeup latency and lower perf=
ormance with no power
> saving. For 'menu' while web browsing on Android for instance, those type=
s of wakeups ('too deep')
> account for over 24% of all wakeups.
>
> At the same time, on some platforms C0 can be power efficient enough to w=
arrant wanting to prefer
> it over C1. Sleeps that happened in C0 while they could have used C1 ('to=
o shallow') only save
> less power than they otherwise could have. Too deep sleeps, on the other =
hand, harm performance
> and nullify the potential power saving from using C1 in the first place. =
While taking this into
> account, it is clear that on balance it is preferable for an idle governo=
r to have more too shallow
> sleeps instead of more too deep sleeps.
>
> Currently the best available governor under this metric is TEO which on a=
verage results in less than
> half the percentage of too deep sleeps compared to 'menu', getting much b=
etter wakeup latencies and
> increased performance in the process.
>
> This proposed optional extension to TEO would specifically tune it for mi=
nimising too deep
> sleeps and minimising latency to achieve better performance. To this end,=
 before selecting the next
> idle state it uses the avg_util signal of a CPU's runqueue in order to de=
termine to what extent the
> CPU is being utilized. This util value is then compared to a threshold de=
fined as a percentage of
> the cpu's capacity (capacity >> 6 ie. ~1.5% in the current implementation=
).

That seems quite a bit too low to me. However on my processor the
energy cost of using
idle state 0 verses anything deeper is very high, so I do not have a
good way to test.

Processor: Intel(R) Core(TM) i5-10600K CPU @ 4.10GHz
On an idle system :
with only Idle state 0 enabled, processor package power is ~46 watts.
with only idle state 1 enabled, processor package power is ~2.6 watts
with all idle states enabled,  processor package power is ~1.4 watts

> If the util is above the
> threshold, the governor directly selects the shallowest available idle st=
ate. If the util is below
> the threshold, the governor defaults to the TEO metrics mechanism to try =
to select the deepest
> available idle state based on the closest timer event and its own past co=
rrectness.
>
> Effectively this functions like a governor that on the fly disables deepe=
r idle states when there
> are things happening on the cpu and then immediately reenables them as so=
on as the cpu isn't
> being utilized anymore.
>
> Initially I am sending this as a patch for TEO to visualize the proposed =
mechanism and simplify
> the review process. An alternative way of implementing it while not inter=
fering
> with existing TEO code would be to fork TEO into a separate but mostly id=
entical for the time being
> governor (working name 'idleutil') and then implement util-awareness ther=
e, so that the two
> approaches can coexist and both be available at runtime instead of relyin=
g on a compile-time option.
> I am happy to send a patchset doing that if you think it's a cleaner appr=
oach than doing it this way.

I would prefer the two to coexist for testing, as it makes it easier
to manually compare some
areas of focus.

>
> This approach can outperform all the other currently available governors,=
 at least on mobile device
> workloads, which is why I think it is worth keeping as an option.
>
> Additionally, in my view, the reason why it makes more sense to implement=
 this type of mechanism
> inside a governor rather than outside using something like QoS or some ot=
her way to disable certain
> idle states on the fly are the governor's metrics. If we were disabling i=
dle states and reenabling
> them without the governor 'knowing' about it, the governor's metrics woul=
d end up being updated
> based on state selections not caused by the governor itself. This could i=
nterfere with the
> correctness of said metrics as that's not what they were designed for as =
far as I understand.
> This approach skips metrics updates whenever a state was selected based o=
n the util and not based
> on the metrics.
>
> There is no particular attachment or reliance on TEO for this mechanism, =
I simply chose to base
> it on TEO because it performs the best out of all the available options a=
nd I didn't think there was
> any point in reinventing the wheel on the side of computing governor metr=
ics. If a
> better approach comes along at some point, there's no reason why the same=
 idle aware mechanism
> couldn't be used with any other metrics algorithm. That would, however, r=
equire implemeting it as
> a separate governor rather than a TEO add-on.
>
> As for how the extension performs in practice, below I'll add some benchm=
ark results I got while
> testing this patchset.
>
> Pixel 6 (Android 12, mainline kernel 5.18):
>
> 1. Geekbench 5 (latency-sensitive, heavy load test)
>
> The values below are gmean values across 3 back to back iteration of Geek=
bench 5.
> As GB5 is a heavy benchmark, after more than 3 iterations intense throttl=
ing kicks in on mobile devices
> resulting in skewed benchmark scores, which makes it difficult to collect=
 reliable results. The actual
> values for all of the governors can change between runs as the benchmark =
might be affected by factors
> other than just latency. Nevertheless, on the runs I've seen, util-aware =
TEO frequently achieved better
> scores than all the other governors.
>
> 'shallow' is a trivial governor that only ever selects the shallowest ava=
ilable state, included here
> for reference and to establish the lower bound of latency possible to ach=
ieve through cpuidle.
>
> 'gmean too deep %' and 'gmean too shallow %' are percentages of too deep =
and too shallow sleeps
> computed using the new trace event - cpu_idle_miss. The percentage is obt=
ained by counting the two
> types of misses over the course of a run and then dividing them by the to=
tal number of wakeups.
>
> | metric                                | menu           | teo           =
    | shallow           | teo + util-aware  |
> | ------------------------------------- | -------------  | --------------=
-   | ---------------   | ---------------   |
> | gmean score                           | 2716.4 (0.0%)  | 2795 (+2.89%) =
    | 2780.5 (+2.36%)   | 2830.8 (+4.21%)   |
> | gmean too deep %                      | 16.64%         | 9.61%         =
    | 0%                | 4.19%             |
> | gmean too shallow %                   | 2.66%          | 5.54%         =
    | 31.47%            | 15.3%             |
> | gmean task wakeup latency (gb5)       | 82.05=CE=BCs (0.0%) | 73.97=CE=
=BCs (-9.85%)  | 42.05=CE=BCs (-48.76%) | 66.91=CE=BCs (-18.45%) |
> | gmean task wakeup latency (asynctask) | 75.66=CE=BCs (0.0%) | 56.58=CE=
=BCs (-25.22%) | 65.78=CE=BCs (-13.06%) | 55.35=CE=BCs (-26.84%) |
>
> In case of this benchmark, the difference in latency does seem to transla=
te into better scores.
>
> Additionally, here's a set of runs of Geekbench done after holding the ph=
one in
> the fridge for exactly an hour each time in order to minimise the impact =
of thermal issues.
>
> | metric                                | menu           | teo           =
    | teo + util-aware  |
> | ------------------------------------- | -------------  | --------------=
-   | ---------------   |
> | gmean multicore score                 | 2792.1 (0.0%)  | 2845.2 (+1.9%)=
    | 2857.4 (+2.34%)   |
> | gmean single-core score               | 1048.3 (0.0%)  | 1052.6 (+0.41%=
)   | 1055.3 (+0.67%)   |
>
> 2. PCMark Web Browsing (non latency-sensitive, normal usage test)
>
> The table below contains gmean values across 20 back to back iterations o=
f PCMark 2 Web Browsing.
>
> | metric                    | menu           | teo               | shallo=
w          | teo + util-aware  |
> | ------------------------- | -------------  | ---------------   | ------=
---------  | ---------------   |
> | gmean score               | 6283.0 (0.0%)  | 6262.9 (-0.32%)   | 6258.4=
 (-0.39%)  | 6323.7 (+0.65%)   |
> | gmean too deep %          | 24.15%         | 10.32%            | 0%    =
           | 3.2%              |
> | gmean too shallow %       | 2.81%          | 7.68%             | 27.69%=
           | 17.189%           |
> | gmean power usage [mW]    | 209.1 (0.0%)   | 187.8 (-10.17%)   | 205.5 =
(-1.71%)   | 205 (-1.96%)      |
> | gmean task wakeup latency | 204.6=CE=BCs (0.0%) | 184.39=CE=BCs (-9.87%=
) | 95.55=CE=BCs (-53.3%) | 95.98=CE=BCs (-53.09%) |
>
> As this is a web browsing benchmark, the task for which the wakeup latenc=
y was recorded was Chrome's
> rendering task, ie CrRendererMain. The latency improvement for the actual=
 benchmark task was very
> similar.
>
> In this case the large latency improvement does not translate into a nota=
ble increase in benchmark score as
> this particular benchmark mainly responds to changes in operating frequen=
cy. Nevertheless, the small power
> saving compared to menu with no decrease in benchmark score indicate that=
 there are no regressions for this
> type of workload while using this governor.
>
> Note: The results above were as mentioned obtained on the 5.18 kernel. Re=
sults for Geekbench obtained after
> backporting CFS patches from the most recent mainline can be found in the=
 pdf linked below [1].
> The results and improvements still hold up but the numbers change slightl=
y. Additionally, the pdf contains
> plots for all the relevant results obtained with this and other idle gove=
rnors.
>
> At the very least this approach seems promising so I wanted to discuss it=
 in RFC form first.
> Thank you for taking your time to read this!

There might be a way forward for my type of processor if the algorithm
were to just reduce the idle
depth by 1 instead of all the way to idle state 0. Not sure. It seems
to bypass all that the teo
governor is attempting to achieve.

For a single periodic workflow at any work sleep frequency (well, I
test 5 hertz to 411 hertz) and very
light workload: Processor package powers for 73 hertz work/sleep frequency:

teo: ~1.5 watts
menu: ~1.5 watts
util: ~19 watts

For 12 periodic workflow threads at 73 hertz work/sleep frequency
(well, I test 5 hertz to 411 hertz) and very
workload: Processor package powers:

teo: ~2.8watts
menu: ~2.8 watts
util: ~49 watts

My test computer is a server, with no gui. I started a desktop linux
VM guest that isn't doing much:

teo: ~1.8 watts
menu: ~1.8 watts
util: ~7.8 watts

>
> --
> Kajetan
>
> [1] https://github.com/mrkajetanp/lisa-notebooks/blob/a2361a5b647629bfbfc=
676b942c8e6498fb9bd03/idle_util_aware.pdf
>
>
> Kajetan Puchalski (1):
>   cpuidle: teo: Introduce optional util-awareness
>
>  drivers/cpuidle/Kconfig         | 12 +++++
>  drivers/cpuidle/governors/teo.c | 86 +++++++++++++++++++++++++++++++++
>  2 files changed, 98 insertions(+)
>
> --
> 2.37.1
>
