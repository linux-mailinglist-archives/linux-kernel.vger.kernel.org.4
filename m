Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE815F58AB
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 18:57:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbiJEQ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 12:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiJEQ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 12:57:34 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B22845FF48
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 09:57:32 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id ot12so98923ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 09:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Zoteraqe/L4yd0299ea+MRLeu1JpMpkXO60NWuA7B7E=;
        b=SCCTaSIiqd4/tKymi5No9cElet/VdyqewmwUUXdHm0yZWq0v2e8dV77UaypLDh5J8T
         A16GvMHo/GRn4I+ObTv0Xe8cHYajdngHihkurYW40mZYjbdxumg6aW8AHIN4c4uvR3Mc
         k7E6pz+U5vSqGGaEbAN5sdE41/m7SlLpqxu7aGelTMvlcf1ueQLRuh6QmPDVgNlPS0mF
         GkfqQSbNa/unr/h1HxqbL5dkANPQgGiQm4D8VfxDqnxAUFEpfIBQs3bUfXF+TnFF47cK
         /ohLLQ2xguuCyWGAbSqHRO6zuaD04VDsshBVYTmNznvYIBUajSewA8VIaiTaBaogu61S
         jWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Zoteraqe/L4yd0299ea+MRLeu1JpMpkXO60NWuA7B7E=;
        b=e7IwP4OhQDGep4VaXyazUN4S/g+MMIb8JXoP8uDcrwYk6lZ7q7VGanADTymKnnJ7hY
         pKYK0GND6DbiiiDNGbkfhaUiR9AHkLKczBm2sKle3y5j6K8erLhQHe93c4/Wzh3L+Ctp
         dcVKwKWFLGZC+srU53vKpvTwcDmNxwKEbynUNb41BQcGkvSFs6StMd/XUEIu+awM8K19
         d6bSZz3uV35pKifo8VNZwR+t95M6Ig6LVbLRnhvDb9mtzX8zs6vmNX7swSR+y2FwYqmA
         5AvJNF9C8TCxPKKIyptOMXwt/T4Z5XnEi/fM5YX8SzxyMgAIeNQHC9RzhZfQwWMaHDok
         YaEQ==
X-Gm-Message-State: ACrzQf02vL406wFWkr0Oac5eYJFGo9VK73jVDy5n9LlA5eN4cEAHiN65
        KLSC3U0jR1fBmTM3pmAedMGx0tzv8e0kUw9gnl8ifg==
X-Google-Smtp-Source: AMsMyM4mu3co7PzRqnTFA9waOvAJWJUmlKDSwf06gq7QM+2KSWimbLIThyTRm8IddrkscIs7yvtSNrRTTdqEcbsM0kU=
X-Received: by 2002:a17:907:2721:b0:77f:d471:47b3 with SMTP id
 d1-20020a170907272100b0077fd47147b3mr412745ejl.591.1664989050880; Wed, 05 Oct
 2022 09:57:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net> <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net> <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <CAGXk5yoC+whmLQn-KvUE3_rGGj4jodsKushr5LmtPK0mi6DFEQ@mail.gmail.com> <2a8b0887-503d-0350-7364-9c1c9293a793@arm.com>
In-Reply-To: <2a8b0887-503d-0350-7364-9c1c9293a793@arm.com>
From:   Wei Wang <wvw@google.com>
Date:   Wed, 5 Oct 2022 09:57:17 -0700
Message-ID: <CAGXk5yo4YOBQkt3DmWkipJgWqU5+00Ahsw_BaFJnwigR2iRmgA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>,
        "Chung-Kai (Michael) Mei" <chungkai@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 2:33 AM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> Hi Wei,
>
> On 04/10/2022 00:57, Wei Wang wrote:
>
> Please don't do top-posting.
>

Sorry, forgot this was posted to the list...

> > We have some data on an earlier build of Pixel 6a, which also runs a
> > slightly modified "sched" governor. The tuning definitely has both
> > performance and power impact on UX. With some additional user space
> > hints such as ADPF (Android Dynamic Performance Framework) and/or the
> > old-fashioned INTERACTION power hint, different trade-offs can be
> > archived with this sort of tuning.
> >
> >
> > +---------------------------------------------------------+----------+----------+
> > |                         Metrics                         |   32ms   |
> >   8ms    |
> > +---------------------------------------------------------+----------+----------+
> > | Sum of gfxinfo_com.android.test.uibench_deadline_missed |   185.00 |
> >   112.00 |
> > | Sum of SFSTATS_GLOBAL_MISSEDFRAMES                      |    62.00 |
> >    49.00 |
> > | CPU Power                                               | 6,204.00 |
> > 7,040.00 |
> > | Sum of Gfxinfo.frame.95th                               |   582.00 |
> >   506.00 |
> > | Avg of Gfxinfo.frame.95th                               |    18.19 |
> >    15.81 |
> > +---------------------------------------------------------+----------+----------+
>
> Which App is package `gfxinfo_com.android.test`? Is this UIBench? Never
> ran it.
>

Yes.

> I'm familiar with `dumpsys gfxinfo <PACKAGE_NAME>`.
>
> # adb shell dumpsys gfxinfo <PACKAGE_NAME>
>
> ...
> ** Graphics info for pid XXXX [<PACKAGE_NAME>] **
> ...
> 95th percentile: XXms            <-- (a)
> ...
> Number Frame deadline missed: XX <-- (b)
> ...
>
>
> I assume that `Gfxinfo.frame.95th` is related to (a) and
> `gfxinfo_com.android.test.uibench_deadline_missed` to (b)? Not sure
> where `SFSTATS_GLOBAL_MISSEDFRAMES` is coming from?
>

a) is correct b) is from surfaceflinger. Android display pipeline
involves both a) app (generation) and b) surfaceflinger
(presentation).

> What's the Sum here? Is it that you ran the test 32 times (582/18.19 = 32)?
>

Uibench[1] has several micro tests and it is the sum of those tests.


[1]: https://cs.android.com/android/platform/superproject/+/master:platform_testing/tests/microbenchmarks/uibench/src/com/android/uibench/microbenchmark/


> [...]
>
> > On Thu, Sep 29, 2022 at 11:59 PM Kajetan Puchalski
> > <kajetan.puchalski@arm.com> wrote:
> >>
> >> On Thu, Sep 29, 2022 at 01:21:45PM +0200, Peter Zijlstra wrote:
> >>> On Thu, Sep 29, 2022 at 12:10:17PM +0100, Kajetan Puchalski wrote:
> >>>
> >>>> Overall, the problem being solved here is that based on our testing the
> >>>> PELT half life can occasionally be too slow to keep up in scenarios
> >>>> where many frames need to be rendered quickly, especially on high-refresh
> >>>> rate phones and similar devices.
> >>>
> >>> But it is a problem of DVFS not ramping up quick enough; or of the
> >>> load-balancer not reacting to the increase in load, or what aspect
> >>> controlled by PELT is responsible for the improvement seen?
> >>
> >> Based on all the tests we've seen, jankbench or otherwise, the
> >> improvement can mainly be attributed to the faster ramp up of frequency
> >> caused by the shorter PELT window while using schedutil. Alongside that
> >> the signals rising faster also mean that the task would get migrated
> >> faster to bigger CPUs on big.LITTLE systems which improves things too
> >> but it's mostly the frequency aspect of it.
> >>
> >> To establish that this benchmark is sensitive to frequency I ran some
> >> tests using the 'performance' cpufreq governor.
> >>
> >> Max frame duration (ms)
> >>
> >> +------------------+-------------+----------+
> >> | kernel           |   iteration |    value |
> >> |------------------+-------------+----------|
> >> | pelt_1           |          10 | 157.426  |
> >> | pelt_4           |          10 |  85.2713 |
> >> | performance      |          10 |  40.9308 |
> >> +------------------+-------------+----------+
> >>
> >> Mean frame duration (ms)
> >>
> >> +---------------+------------------+---------+-------------+
> >> | variable      | kernel           |   value | perc_diff   |
> >> |---------------+------------------+---------+-------------|
> >> | mean_duration | pelt_1           |    14.6 | 0.0%        |
> >> | mean_duration | pelt_4           |    14.5 | -0.58%      |
> >> | mean_duration | performance      |     4.4 | -69.75%     |
> >> +---------------+------------------+---------+-------------+
> >>
> >> Jank percentage
> >>
> >> +------------+------------------+---------+-------------+
> >> | variable   | kernel           |   value | perc_diff   |
> >> |------------+------------------+---------+-------------|
> >> | jank_perc  | pelt_1           |     2.1 | 0.0%        |
> >> | jank_perc  | pelt_4           |     2   | -3.46%      |
> >> | jank_perc  | performance      |     0.1 | -97.25%     |
> >> +------------+------------------+---------+-------------+
> >>
> >> As you can see, bumping up frequency can hugely improve the results
> >> here. This is what's happening when we decrease the PELT window, just on
> >> a much smaller and not as drastic scale. It also explains specifically
> >> where the increased power usage is coming from.
>
