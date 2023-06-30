Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68866743CB2
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 15:25:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbjF3NZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 09:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjF3NZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 09:25:25 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C82DA3A98
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:25:13 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4fba74870abso561269e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 06:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1688131512; x=1690723512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk/29pUWn0vGiMuP9Cfi3/EYqLftvL8xXi5fIA2JMrc=;
        b=j+mHcNT0pkueAkNDWn7hm9eltY0NULS+J2NyiRE9ZLAh+KhRE7usnmg68+2I5JRgTy
         0PL/HWtrOw/Pc3hhmE1FoYMWYkYKR13Wgy7vWcaqc0ujgZN5PwvXkbzgFhcZwpbUYrPa
         JHZf4Otfur/p+BpVsSRlscKUY3dhWBuKbY0DIeoF1hb7TXh/48xIv3ygo+tbtHmo71b/
         Sg1rEHUQvfI+3lI7DZX788Ln9+FIg2kfDisV06CoBI5zx3VKIIrLAKPA2BsK5rMz4buV
         fzfvAztbyZjB9cpZOPwP6SYu2X7/UdDdloLWi+GoMOfFAm1GcOeyjdjf8dXtLyJiSyJn
         a8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688131512; x=1690723512;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk/29pUWn0vGiMuP9Cfi3/EYqLftvL8xXi5fIA2JMrc=;
        b=NmtTuYE/CiFVDHG2KvcfRG1f7///AZ38f9bh9oY7wa6w0CfDMKKnXxGCgzfdcbQJB2
         9X314wLFZEps4yjdhz8ddX7K4Ep2PLV3n2owQrWbZBy4w2XDZZfxhtoFPV/bYpmbUQ38
         Nqm/8sjqtXXZpM44nay2y43RSPpT9fgy+65LHJ6+hfMqcR/1ktdO5Mr8r5SaMQkQST/I
         BLf0SdqhV0QmURcT0OvCMCDPG6kXBZ4sLVYp9rbLWXZZFYGbE2oS5Bt/LZlE/bXJSDRA
         Fh5cORtTCQPAITM9x5R/leB8xMOqrWyoJtNjGJSIoO5i4xGO0HROBkgZ2WlAsUTHAg8F
         D54A==
X-Gm-Message-State: ABy/qLYhMWQoc8InRm9N9q7kl7rCm9O3tFwsbBBRv3flaIv2iLF6LxrP
        paHIsPmNyUX6heS/lu7EYGku0P4Y0KCbnDFcVKk=
X-Google-Smtp-Source: APBJJlFAg/rPCVEk3WXaVAiwSdndbFcfE5OcjnvsY8jXMLH02zphj9zIfobyZothbq+hgt0ET9b+4A==
X-Received: by 2002:a05:6512:455:b0:4fa:9dc3:1d41 with SMTP id y21-20020a056512045500b004fa9dc31d41mr2182003lfk.51.1688131511950;
        Fri, 30 Jun 2023 06:25:11 -0700 (PDT)
Received: from airbuntu (host86-163-217-97.range86-163.btcentralplus.com. [86.163.217.97])
        by smtp.gmail.com with ESMTPSA id q20-20020a1cf314000000b003f90b9b2c31sm22251634wmq.28.2023.06.30.06.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 06:25:11 -0700 (PDT)
Date:   Fri, 30 Jun 2023 14:25:07 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        rafael@kernel.org, linux-pm@vger.kernel.org, rostedt@goodmis.org,
        mhiramat@kernel.org, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, delyank@fb.com,
        qyousef@google.com, kernel test robot <lkp@intel.com>
Subject: Re: [RESEND][PATCH v2 3/3] schedutil: trace: Add tracing to capture
 filter out requests
Message-ID: <20230630132507.hggzz5g2odrabii6@airbuntu>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
 <20230522145702.2419654-4-lukasz.luba@arm.com>
 <20230531183105.r5tqpdx5axoogkzp@airbuntu>
 <a0101269-1d8b-d4e1-52b4-250a99b395fa@arm.com>
 <20230630120122.oqy4q42bl5gy6bfd@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630120122.oqy4q42bl5gy6bfd@airbuntu>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/30/23 13:01, Qais Yousef wrote:
> On 06/20/23 18:52, Lukasz Luba wrote:
> > Hi Qais,
> > 
> > I have somehow missed your feedback on this series.
> > 
> > On 5/31/23 19:31, Qais Yousef wrote:
> > > On 05/22/23 15:57, Lukasz Luba wrote:
> > > > Some of the frequency update requests coming form the task scheduler
> > > > might be filter out. It can happen when the previous request was served
> > > > not that long ago (in a period smaller than provided by the cpufreq driver
> > > > as minimum for frequency update). In such case, we want to know if some of
> > > > the frequency updates cannot make through.
> > > > Export the new tracepoint as well. That would allow to handle it by a
> > > > toolkit for trace analyzes.
> > > > 
> > > > Reported-by: kernel test robot <lkp@intel.com> # solved tricky build
> > > > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > > > ---
> > > >   include/trace/events/sched.h     |  4 ++++
> > > >   kernel/sched/cpufreq_schedutil.c | 10 ++++++++--
> > > >   2 files changed, 12 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > > > index dbfb30809f15..e34b7cd5de73 100644
> > > > --- a/include/trace/events/sched.h
> > > > +++ b/include/trace/events/sched.h
> > > > @@ -739,6 +739,10 @@ DECLARE_TRACE(uclamp_update_tsk_tp,
> > > >   	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
> > > >   	TP_ARGS(tsk, uclamp_id, value));
> > > > +DECLARE_TRACE(schedutil_update_filtered_tp,
> > > > +	TP_PROTO(int cpu),
> > > > +	TP_ARGS(cpu));
> > > > +
> > > >   #endif /* _TRACE_SCHED_H */
> > > >   /* This part must be outside protection */
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > > > index f462496e5c07..4f9daf258a65 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -6,6 +6,8 @@
> > > >    * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >    */
> > > > +EXPORT_TRACEPOINT_SYMBOL_GPL(schedutil_update_filtered_tp);
> > > > +
> > > >   #define IOWAIT_BOOST_MIN	(SCHED_CAPACITY_SCALE / 8)
> > > >   struct sugov_tunables {
> > > > @@ -318,8 +320,10 @@ static inline bool sugov_update_single_common(struct sugov_cpu *sg_cpu,
> > > >   	ignore_dl_rate_limit(sg_cpu);
> > > > -	if (!sugov_should_update_freq(sg_cpu->sg_policy, time))
> > > > +	if (!sugov_should_update_freq(sg_cpu->sg_policy, time)) {
> > > > +		trace_schedutil_update_filtered_tp(sg_cpu->cpu);
> > > >   		return false;
> > > > +	}
> > > 
> > > Can't we have something more generic here too? Are you interested to count
> > > these events? How do you plan to use it?
> > 
> > The plan is to record those events, count them and maybe adjust the FW
> > if the frequency switching capabilities are too low, e.g. 4ms...
> 
> You mean as part of tuning step for the system or at runtime? The latter seems
> to indicate for a proper interface instead.
> 
> IMHO I think the current filtering mechanism needs a bit of a massage.
> 
> One thing I think we must do is to ignore the filter if there's a big sudden
> change in requested frequency. Like for instance if a big task migrates. Then
> prev_cpu should go to lower freq sooner, and new_cpu should change to higher
> frequency sooner too. The filtering makes sense only in steady state situation
> where we are ramping up or down gradually.
> 
> If no one beats me to it, I'll propose something in that regard.
> 
> > 
> > We need those numbers to point out that there is a need for faster
> > FW micro-controller to serve those incoming requests.
> 
> I think there's a big assumption here that the filter is always set correctly
> ;-)
> 
> > 
> > > 
> > > I think this will be a very noisy event by the way.
> > 
> > Could be, but on the other hand for those statistical analysis
> > 'the more the better'. It will also depend on number of
> > CPUs in the cluster, e.g. 4 CPUs vs 1 CPU.
> > 
> > I don't know when we will switch to this per-cpu cpufreq mode
> > when all CPUs behave like independent DVFS. Juno mainline kernel and FW
> > supports that mode. We would have to compare those two modes and
> > measure how much we gain/loose when using one and not the other.
> > 
> > Furthermore, we already suspect some of our integration testing for
> > EAS-mainline (on Juno) failing due to filtered out requests. How much
> > that would impact other boards - it would be nice to see in traces.
> 
> Another problem I think we have is that the DVFS headroom value should be
> a function of this filter. At the moment it is hardcoded to a random value
> which causes power issue.
> 
> So to summarize I think there are two improvements required (and if anyone has
> the time to try them out go ahead otherwise I'll get to it):
> 
>  1. The filter should only be applied if the history hasn't changed. ie: we are
>     gradually increasing or decreasing PELT. Otherwise we should honour sudden
>     changes ASAP.
>  2. DVFS headroom should be a function of the filter. 25% is too high for
>     500us. It could be too low for 10ms (I don't know).

To expand a bit more since it's related. Our  migration margins should depend
on the tick value instead of random magic numbers they are today. More
precisely the balance_interval. If there's a misfit task, then we should
upmigrate it at wake up only if we think it'll become misfit before the load
balancer kicks in. Otherwise the load balancer should do the correction if it
becomes long running/misfit. If the sys admin wants to speed up/slow down
migration it should be throw controlling PELT IMO and not these magic margin
values - which are hardcoded to random values at the moment anyway that are not
suitable for every system.

And since we decoupled overutilized from misfit lb; I think our definition
should improve to better detect when the system needs to disable packing and
starts spreading. Current check for overutilized based on misfit is no longer
adequate IMO. Especially when there's a single misfit task in the system.

Again, just sharing thoughts in case someone interested to work on this before
I get a chance to share any patches ;-)


Cheers

--
Qais Yousef
