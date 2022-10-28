Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A696611270
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiJ1NNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 09:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiJ1NNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 09:13:00 -0400
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B989D68CCF;
        Fri, 28 Oct 2022 06:12:55 -0700 (PDT)
Received: by mail-qk1-f180.google.com with SMTP id f8so3346745qkg.3;
        Fri, 28 Oct 2022 06:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YDAFQ+mkHAqwgxQwscs1RhbY90HSm/YhHxWGMns0tWs=;
        b=tXdKVMVP+oleSIClB6xamR9xeCjTsZF+740JhUU9y7nS63b/CA2yQn1y9BfMV9PcJz
         uMfmgvNpCiPRk2BDRoy2z04s6SSDmqwEKZdpcV+Sd9sv9E5BhMoEhk43MbBdcJp3CRor
         3cE716b5hOqa51N6n4vlvPl9x+o9tw8CdW4cam7StLugVeF0i5iGPTLAwABgfYfWirg/
         bIQV4Mckq5QWCugZFIk0IfSY8cBZ9FDx5L2VGwTr3gE5B3S5U8v8G/+pHeCzC+xyui3+
         ailRO2+UcyuFlH+k04QzxKBhGJnIBm7C4hb2FwpjN62QQhlxKsFXUGJcZkvZW/vNI9je
         6evQ==
X-Gm-Message-State: ACrzQf3yK0UeFdFYhN6PDO0q/la4khMrfamTL+aCPueZnOEN2vWZQdDV
        //+FLFzBMYqKIjGkEv/mpboWEaNyp6ILUz/3BdQ=
X-Google-Smtp-Source: AMsMyM5XKUFfZHKPwpVT3I9YNhhOkefiEHI5DUXxGyeHIDyFGBKbEsvwA/gyBY2qcEZ1VgpmMhOiJXNgUKF1MYijh7g=
X-Received: by 2002:a37:c4e:0:b0:6fa:c1c:6fc0 with SMTP id 75-20020a370c4e000000b006fa0c1c6fc0mr1223655qkm.501.1666962774766;
 Fri, 28 Oct 2022 06:12:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221003144914.160547-1-kajetan.puchalski@arm.com>
 <CAJZ5v0hoe=8nY9vR=+Bjvexrg+E6fcO-S=W+PDkfD=Li6Uy__g@mail.gmail.com> <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
In-Reply-To: <Y0fymW5LOoIHstE2@e126311.manchester.arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 28 Oct 2022 15:12:43 +0200
Message-ID: <CAJZ5v0gvAtpzdQo0Tj13ZGFcop8fdNht7e_Nc_UNYCgbU1zZLA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/1] cpuidle: teo: Introduce optional util-awareness
To:     Kajetan Puchalski <kajetan.puchalski@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, daniel.lezcano@linaro.org,
        lukasz.luba@arm.com, Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 13, 2022 at 1:12 PM Kajetan Puchalski
<kajetan.puchalski@arm.com> wrote:
>
> On Wed, Oct 12, 2022 at 08:50:39PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Oct 3, 2022 at 4:50 PM Kajetan Puchalski
> > <kajetan.puchalski@arm.com> wrote:
> > >
> > > Hi,
> > >
> > > At the moment, all the available idle governors operate mainly based on their own past performance
> >
> > Not true, at least for the menu and teo governors that use the
> > information on the distribution of CPU wakeups that is available to
> > them and try to predict the next idle duration with the help of it.
> > This has a little to do with their performance.
>
> You're right of course, I should have written "their own past
> correctness" as that's what I was referring to. I just meant that for
> instance with TEO the initial timer-based choice is only adjusted using
> the governor's own metrics and not any information from anywhere else in
> the system.

The last sentence is just right, so that's what I would say in the changelog.


> > > without taking into account any scheduling information. Especially on interactive systems, this
> > > results in them frequently selecting a deeper idle state and then waking up before its target
> > > residency is hit, thus leading to increased wakeup latency and lower performance with no power
> > > saving. For 'menu' while web browsing on Android for instance, those types of wakeups ('too deep')
> > > account for over 24% of all wakeups.
> >
> > How is this measured?
>
> Using the cpu_idle_miss trace event. Over the course of a benchmark run
> I collect all cpu_idle and cpu_idle_miss trace events. Then I divide the
> number of too deep misses by the total number of cpu_idle wakeup events
> which gives me the percentage. Those are the percentages described as
> 'gmean too deep %' in the tables included in the cover letter. Gmean
> because I run the benchmarks for many iterations and then take an
> average of those percentages to account for outliers.
> PCMark Web Browsing is a 'benchmark' that just amounts to browsing the
> web on Android, hence I can use data from it to talk about what the
> system behaviour under normal usage would be.
>
> > > At the same time, on some platforms C0 can be power efficient enough to warrant wanting to prefer
> > > it over C1.
> >
> > Well, energy-efficiency is relative, so strictly speaking it is
> > invalid to say "power efficient enough".
>
> Yes, by 'enough' I meant that the power savings of C0 vs C1 on arm are
> fairly comparable as opposed to other platforms. From Doug's data
> collected on an Intel CPU, the power usage difference of only-C0
> compared to only-C1 was over 20-fold ie 46w vs 2.6w. With only C0
> enabled on Pixel 6 that difference is closer to something like 4%. It's
> just fundamentally different hardware. With 4% being your ceiling you
> can talk about performance/latency tradeoffs etc, if you're talking
> about potential over 1700% increases, not so much.

The above is very close to a proper problem statement.

IIUC, on the hardware in question the power difference between the
first available idle state (state 0) and the next idle state (state 1)
is relatively small, but the target residency of state 1 is relatively
large and if it is missed, energy is wasted and the extra cost in
terms of latency is relatively high.  At the same time, this is the
idle duration range where the latency matters the most, so it is
desirable to reduce the likelihood of mispredicting higher idle
duration in this range beyond what the teo governor does by itself.

Also, unlike on Intel systems, state 0 actually is an idle state (on
Intel systems state 0 is a polling state and it is there to avoid the
latency cost of C1 in the cases when it wouldn't save any energy due
to the nonzero target residency).

Fair enough.

> > Also, as far as idle CPUs are concerned, we are talking about the
> > situation in which no useful work is done at all, so the state drawing
> > less power is always more energy-efficient than the one drawing more
> > power.
>
> Yes, assuming the CPU is woken up after the target residency of the
> state has been met. If the wakeup happens too early then for that
> situation C0 would've been more power efficient than C1 even though C1
> technically draws less power, right? That's what we're trying to fix
> here, we just noticed that for mobile interactive workloads at least
> we're getting this situation way too often.

Well, the interactive workloads are likely to be similar on any clent
systems (and the term "mobile" is somewhat vague).

> The result being that this util-aware TEO variant while using much less
> C1 and decreasing the percentage of too deep sleeps from ~24% to ~3% in
> PCMark Web Browsing also uses almost 2% less power. Clearly the power is
> being wasted on not hitting C1 residency over and over.

Hmm.  The PCMark Web Browsing table in your cover letter doesn't indicate that.

The "gmean power usage" there for "teo + util-aware" is 205, whereas
for "teo" alone it is 187.8.  This is still arguably balanced by the
latency difference (~100 us vs ~185 us, respectively), but this looks
like trading energy for performance.

On the side note, unmodified "teo" shows some nice 10%-range
improvements in terms of both power and latency over "menu" in this
case, even though it underestimates the idle duration much more often
(which kind of supports the idea that underestimating the idle
duration is better than overestimating it).

> > You may argue that predicting idle durations that are too long too
> > often leads to both excessive task wakeup latency and excessive energy
> > usage at the same time, but this may very well mean that the target
> > residency value for C1 is too low.
>
> We get residency values from DT and they're meant to be the descriptions
> of each CPU's hardware so I don't think tweaking them to get better
> results would be a good idea. Unless I'm misunderstanding what you mean?

I mean that the target residency values from DT may be less than perfect.

Also, they really are input for the governor's decisions, nothing
more, so putting values that are likely to yield more desirable
governor behavior in there is not a bad idea.

> > > Currently the best available governor under this metric is TEO which on average results in less than
> > > half the percentage of too deep sleeps compared to 'menu', getting much better wakeup latencies and
> > > increased performance in the process.
> >
> > Well, good to hear that, but some numbers in support of that claim
> > would be nice to have too.
>
> Those are the numbers I included in the cover letter for the two
> benchmarks, they've been very consistent in terms of the pattern
> across all the runs and workloads I've seen. For too deep % for
> instance in GB5 we had on average menu 16.6%, TEO 9.6%, TEO+util 4.19%.
> For PCMark Web Browsing menu 24.15%, TEO 10.32%, TEO+util 3.2%. The
> values differ per-workload but every dataset I've seen had that same
> 'staircase' pattern.

I see.

> > > This proposed optional extension to TEO would specifically tune it for minimising too deep
> > > sleeps and minimising latency to achieve better performance. To this end, before selecting the next
> > > idle state it uses the avg_util signal of a CPU's runqueue in order to determine to what extent the
> > > CPU is being utilized.
> >
> > Which has no bearing on what the CPU idle time governors have to do
> > which is (1) to predict the next idle duration as precisely as
> > reasonably possible and (2) to minimise the cost in terms of task
> > wakeup latencies associated with using deep idle states.
> >
> > The avg_util value tells us nothing about how much the CPU is going to
> > be idle this time and it also tells us nothing about the
> > latency-sensitivity of the workload.
> >
> > Yes, it tells us how much idle time there was on the given CPU in the
> > past, on the average, but there is zero information about the
> > distribution of that idle time in it.
> >
> > So in the first place please tell me why it fundamentally makes sense
> > to use avg_util in CPU idle time management at all.
>
> Right, the idea here is slightly similar to that of temporal locality.
> We obviously can't predict the future which is sort of what an idle
> governor tries to achieve. Focusing on timer events makes a lot of sense
> and is probably close to as good as it gets in estimating future
> behaviour.
>
> The observation we're relying on here is simply that if the
> CPU was doing enough work in the recent past for its avg_util to still
> be raised while going into idle, it is very likely that the same CPU
> might be needed again soon. From my tests that assumption tends to be
> correct quite often. In those situations, when avg_util is high and the
> next timer event is far enough for C1 to be selected, a lot of the time
> the CPU does actually get woken up before the residency is hit leading
> to all the issues described above.

This is quite reasonable overall.

> I don't think using avg_util as the *only* input for idle management
> would be a good idea at all. The way I see it, it serves as a very good hint
> to determine if we are likely to get a wakeup between now and the next
> timer event and provides an additional dimension for decision making.
> While the current metrics only adjust themselves after making a certain
> number of mistakes and are a "trailing" adjusting mechanism, using
> avg_util this way provides a "leading" mechanism that potentially lets
> us not make those mistakes in the first place. It's not just theory
> either, it very clearly works and gets results, at least on the
> platforms/workloads we've been looking at.
>
>
> On the Intel & power usage angle you might have seen in the discussion,
> Doug sent me some interesting data privately. As far as I can tell the
> main issue there is that C0 on Intel doesn't actually do power saving so
> moving the state selection down to it is a pretty bad idea because C1
> could be very close in terms of latency and save much more power.
>
> A potential solution could be altering the v2 to only decrease the state
> selection by 1 if it's above 1, ie 2->1 but not 1->0. It's fine for us
> because arm systems with 2 states use the early exit path anyway. It'd
> just amount to changing this hunk:
>
> +       if (cpu_data->utilized && idx > 0 && !dev->states_usage[idx-1].disable)
> +               idx--;
>
> to:
>
> +       if (cpu_data->utilized && idx > 1 && !dev->states_usage[idx-1].disable)
> +               idx--;
>
> What would you think about that?

Definitely it should not be changed if the previous state is a polling
one which can be checked right away.  That would take care of the
"Intel case" automatically.

> Should make it much less intense for Intel systems.

So I think that this adjustment only makes sense if the current
candidate state is state 1 and state 0 is not polling.  In the other
cases the cost of missing an opportunity to save energy would be too
high for the observed performance gain.
