Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628F96D4A50
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 16:46:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233935AbjDCOqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 10:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233928AbjDCOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 10:46:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313661827D
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 07:45:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l27so29627086wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 07:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112; t=1680533142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RnVk/Wnnf/1HA+ytvWnFK1GzMlr9h0wU72EZm2tgn1k=;
        b=3zf3+gG8mTIPegTRcHfdgIdW65GoV1GtZEcts0ddbdJmW5Mnn9EPmW78rCuo0X+3kE
         0VufaMFQrneIxa+oioQ1LZNGvT/n0I3/ZuniS3/ZC2Xy5zshleRAfKBj8dRV02ksdUdE
         VbOy6J/286CDe/rFwERfVpp/h3CbdbO+kBmdsuX+OXy2hcF8KDSTeOmJi94jQod4fehq
         xtY5kQlXMAl6FqHOsqn0cU8UGBdOtiB9pgWHim6GMdnkkFB+cHnYnLjPGOeyKcJ3YWBI
         qz/UuESNQhhbBnLiHZr4c49mCL496XEl5s9sW5HA9/OthBxXGDvOpTSE2KsvTqdS4oKf
         33pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680533142;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnVk/Wnnf/1HA+ytvWnFK1GzMlr9h0wU72EZm2tgn1k=;
        b=zwahzUsCLYdN+JdiQ+caBhBdmiN8F6lsrkjAgeDlMNH66uyrGaiFnO2uUoChVvFwpO
         QJr4FTPVSow8edytnnX1tR2PGhRJOs3U49U6/O3/0ibq9L0j5rt3HWIAUBic/hd7x7aG
         B/IfhQHpUDSzSLF9GV56s24hhtCiNVm9GmlOII620xJAq3Z1SE4bYTIGO0yrRLdbJ5z8
         3z4MNu5rUzAl86lITacFwlo0PamiMoSje/U/QW5d8abrDV74XyVBLaeW9Pqpw7iE8ib7
         VZN64qyGf7f7WXuPi0Ryz8QOrRyhpFmUgy3PQYbj5QriyPZUWkLU3UabEF6DRR08CqUO
         qEcg==
X-Gm-Message-State: AAQBX9fgKAxptDL+b9G9hcZQb6SaIu0Kr6YB1iiPXqDOCW1P9ckTWueD
        qnDESeBVkIRTxPaRe7R1JSMh/Q==
X-Google-Smtp-Source: AKy350YkVgMbovkFOcyLNjf7oHPAn/01D2NJ99nlZwTcLfpqxf3ID3LV4LOFqH4C9t/B7mcWyi+fZg==
X-Received: by 2002:adf:ea10:0:b0:2da:e8ac:6986 with SMTP id q16-20020adfea10000000b002dae8ac6986mr29428945wrm.10.1680533142039;
        Mon, 03 Apr 2023 07:45:42 -0700 (PDT)
Received: from airbuntu (host86-163-35-64.range86-163.btcentralplus.com. [86.163.35.64])
        by smtp.gmail.com with ESMTPSA id t16-20020adfdc10000000b002e5ff05765esm9349834wri.73.2023.04.03.07.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 07:45:41 -0700 (PDT)
Date:   Mon, 3 Apr 2023 15:45:39 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <20230403144539.46iwihlrzigsx5iu@airbuntu>
References: <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
 <424e2c81-987d-f10e-106d-8b4c611768bc@arm.com>
 <CAKfTPtD0ZOndFef3-JxBn3G9tcX=cZEObjHZ0iqiVTJz7+QrmQ@mail.gmail.com>
 <20230223153700.55zydy7jyfwidkis@airbuntu>
 <CAKfTPtDVGcvmR5BoJpyoOBE19PcWZP+6NjSD7MnJyBAc7VMnmg@mail.gmail.com>
 <20230301172458.intrgsirjauzqmo3@airbuntu>
 <60fe6b16-0fc6-6ac4-f8fe-87ae9b6592c0@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <60fe6b16-0fc6-6ac4-f8fe-87ae9b6592c0@arm.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Diemtar

On 03/23/23 17:29, Dietmar Eggemann wrote:
> On 01/03/2023 18:24, Qais Yousef wrote:
> > On 03/01/23 11:39, Vincent Guittot wrote:
> >> On Thu, 23 Feb 2023 at 16:37, Qais Yousef <qyousef@layalina.io> wrote:
> >>>
> >>> On 02/09/23 17:16, Vincent Guittot wrote:
> >>>
> >>>> I don't see how util_est_faster can help this 1ms task here ? It's
> >>>> most probably never be preempted during this 1ms. For such an Android
> >>>> Graphics Pipeline short task, hasn't uclamp_min been designed for and
> >>>> a better solution ?
> >>>
> >>> uclamp_min is being used in UI and helping there. But your mileage might vary
> >>> with adoption still.
> >>>
> >>> The major motivation behind this is to help things like gaming as the original
> >>> thread started. It can help UI and other use cases too. Android framework has
> >>> a lot of context on the type of workload that can help it make a decision when
> >>> this helps. And OEMs can have the chance to tune and apply based on the
> >>> characteristics of their device.
> >>>
> >>>> IIUC how util_est_faster works, it removes the waiting time when
> >>>> sharing cpu time with other tasks. So as long as there is no (runnable
> >>>> but not running time), the result is the same as current util_est.
> >>>> util_est_faster makes a difference only when the task alternates
> >>>> between runnable and running slices.
> >>>> Have you considered using runnable_avg metrics in the increase of cpu
> >>>> freq ? This takes into the runnable slice and not only the running
> >>>> time and increase faster than util_avg when tasks compete for the same
> >>>> CPU
> >>>
> >>> Just to understand why we're heading into this direction now.
> >>>
> >>> AFAIU the desired outcome to have faster rampup time (and on HMP faster up
> >>> migration) which both are tied to utilization signal.
> >>>
> >>> Wouldn't make the util response time faster help not just for rampup, but
> >>> rampdown too?
> >>>
> >>> If we improve util response time, couldn't this mean we can remove util_est or
> >>> am I missing something?
> >>
> >> not sure because you still have a ramping step whereas util_est
> >> directly gives you the final tager
> 
> util_est gives us instantaneous signal at enqueue for periodic tasks,

How do you define instantaneous and periodic here? How would you describe the
behavior for non periodic tasks?

> something PELT will never be able to do.

Why? Isn't by selecting a lower pelt halflife we achieve something similar?

>  
> > I didn't get you. tager?
> > 
> >>
> >>>
> >>> Currently we have util response which is tweaked by util_est and then that is
> >>> tweaked further by schedutil with that 25% margin when maping util to
> >>> frequency.
> >>
> >> the 25% is not related to the ramping time but to the fact that you
> >> always need some margin to cover unexpected events and estimation
> >> error
> > 
> > At the moment we have
> > 
> > 	util_avg -> util_est -> (util_est_faster) -> util_map_freq -> schedutil filter ==> current frequency selection
> > 
> > I think we have too many transformations before deciding the current
> > frequencies. Which makes it hard to tweak the system response.
> 
> To me it looks more like this:
> 
> max(max(util_avg, util_est), runnable_avg) -> schedutil's rate limit* -> freq. selection
>                              ^^^^^^^^^^^^ 
>                              new proposal to factor in root cfs_rq contention

These are still 5 stages even if written differently.

What if background tasks that are causing the contention? How can you tell it
to ignore that and NOT drive the frequency up unnecessary for those non
important ones? If userspace is fully aware of uclamp - this whole discussion
wouldn't be necessary. And I still have a bunch of fixes to push before
uclamp_max is actually usable in production.

> Like Vincent mentioned, util_map_freq() (now: map_util_perf()) is only
> there to create the safety margin used by schedutil & EAS.

Yes I know and that's not the point. The point is that it's a chain reaction.
25% percent headroom is already very aggressive and causes issues on the top
inefficient ends of the cores. And when util is high, you might end up in
a situation where you skip frequencies. Making everything go up faster without
balancing it with either enabling going down faster too or tune this value can
lead to power and thermal issues on powerful systems.

I think all we need is controlling pelt halflife and this one to tune the
system to the desired trade-off.

> 
> * The schedutil up/down filter thing has been already naked in Nov 2016.
> IMHO, this is where util_est was initially discussed as an alternative.

Well, I don't see anyone not using a down filter. So I'm not sure util_est has
been a true alternative.

> We have it in mainline as well, but one value (default 10ms) for both
> directions. There was discussion to map it to the driver's
> translation_latency instead.

Which can be filled wrong sometimes :(

> 
> In Pixel7 you use 0.5ms up and `5/20/20ms` down for `little/medium/big`.
> 
> So on `up` your rate is as small as possible (only respecting the
> driver's translation_latency) but on `down` you use much more than that. 
> 
> Why exactly do you have this higher value on `down`? My hunch is
> scenarios in which the CPU (all CPUs in the freq. domain) goes idle,
> so util_est is 0 and the blocked utilization is decaying (too fast,
> 4ms (250Hz) versus 20ms?). So you don't want to ramp-up frequency
> again when the CPU wakes up in those 20ms?   

The down filter prevents changing the frequency to a lower value. So it's
a holding function to keep the residency at a higher frequency for at least
20ms. It is, sort of, similar to the max() functions you used above. The max
function will allow you to follow the fasting ramping up signal on the way up,
and the slowest ramping down one on the way down.

I think this is more deterministic way to do it.

> 
> >>> I think if we can allow improving general util response time by tweaking PELT
> >>> HALFLIFE we can potentially remove util_est and potentially that magic 25%
> >>> margin too.
> >>>
> >>> Why the approach of further tweaking util_est is better?
> >>
> >> note that in this case it doesn't really tweak util_est but Dietmar
> >> has taken into account runnable_avg to increase the freq in case of
> >> contention
> >>
> >> Also IIUC Dietmar's results, the problem seems more linked to the
> >> selection of a higher freq than increasing the utilization;
> >> runnable_avg tests give similar perf results than shorter half life
> >> and better power consumption.
> > 
> > Does it ramp down faster too?
> 
> Not sure why you are interested in this? Can't be related to the
> `driving DVFS` functionality discussed above.

If you change the reaction time to be more aggressive in going up, then it's
only natural to have it symmetrical so your residency on the power hungry OPPs
don't go over the roof and end up with thermal and power issues.

I am concerned about us biasing towrads perf first too much and not enabling
sys admins to select a proper trade off for their system and use case. Which
are not static. The workloads the system needs to accommodate to are abundant
and operating conditions could change. And the diversity of hardware available
out there is huge - I am not sure how can we expect we can have one response to
accommodate for all of them.

What I'm trying to push for here is that we should look at the chain as one
unit. And we should consider that there's important trade-off to be had here;
having a sensible default doesn't mean the user shouldn't be allowed to select
a different trade-off. I'm not sure the problem can be generalized and fixed
automatically. But happy to be proven wrong of course :-)

FWIW, I'm trying to tweak all these knobs and study their impact. Do you mind
pasting the patch for load_avg consideration so I can take it into account too
in my experiments?


Thanks!

--
Qais Yousef
