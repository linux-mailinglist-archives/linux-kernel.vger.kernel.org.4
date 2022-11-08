Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B3A620F8B
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 12:51:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiKHLvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 06:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233539AbiKHLvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 06:51:44 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F702F38A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Nov 2022 03:51:43 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id j5-20020a05600c410500b003cfa9c0ea76so3492652wmi.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Nov 2022 03:51:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w5UObqeTfp3daovjhWu7ye0yYxmfllnTTqwBV2Rj7Zo=;
        b=bE+Zrf5/XS8ar5/E/lIv+8MUT7JFeK0D2X2r4lKshJR6QfjuGVjtpS0uWbsJn1lymo
         eQQWlfUSUA03lOm0ykxipzv5n71e+0T/70urVEYaC4j8Go7e1YKNuF1tDjZB1Sc6u3tg
         QwhsA6h8GIYC4GTkmoAi7wLMqGSzOsFvA02VwKw5CSORiOU73cI0IIiWnVpa+04u6oJn
         QwX5xrHemr8Tpmts6jZnq4BDlMPKcT9pz/3WRC7zeG7Nof0kTvjIRLWRlph9+vBu9NwR
         LT7Sr2IdydKV//2PFvgQor/y/YQvIkgqf+ZyOxEL8WdghczNStxmu6PLoiWdA6JPF037
         UbOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w5UObqeTfp3daovjhWu7ye0yYxmfllnTTqwBV2Rj7Zo=;
        b=S4sHEBC2NoURyL6Tab/Zq0Hvbm1ZbVlYahnS11T9/aOL48NaDp0DhLRg/hjlBQ8x2W
         OfmszC39/722nD4NcNWU3nNEc6RBDkQnRtK9OiV2bJrxmtQb0RoQbYb5CJwRbWyPKL3E
         +uc2+R0uKGP/+kr6gOL4CGPOTznGX1R/rtBVst1vewCkncQA/m2qJ5xoorK+prFzDocg
         5tOgmVLdLwg5OYD3wjX0bjETGUfqn/WvITaVLIveW4e4GyXe6lmbrRc1cNQKvW/W2fPQ
         8WZgSkqG19S5kLcfjsE6UQNcazOPfxkyH20yinE7folBl4GEpEaskpKJ+QCOzTd1ognC
         0ZKw==
X-Gm-Message-State: ACrzQf1Q+p+xYqiS2Jcm9br9Su5fA0kh4Khl/cWnBJMq3gbyu6MqZyWn
        aU0gRwVj7aFUJad0ttwXPUFHnw==
X-Google-Smtp-Source: AMsMyM7KUoxu2yuYeOhKYKciZUo62YO7mPcFOzYNfGcgDJJiaROSdwB1I9Zo6aN9U2mWQw7ZD4mUtQ==
X-Received: by 2002:a05:600c:21a:b0:3cf:6e76:9830 with SMTP id 26-20020a05600c021a00b003cf6e769830mr33097283wmi.159.1667908301759;
        Tue, 08 Nov 2022 03:51:41 -0800 (PST)
Received: from airbuntu ([104.132.45.106])
        by smtp.gmail.com with ESMTPSA id l19-20020a1c7913000000b003c83465ccbfsm14288051wme.35.2022.11.08.03.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 03:51:41 -0800 (PST)
Date:   Tue, 8 Nov 2022 11:51:39 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Lukasz Luba <lukasz.luba@arm.com>, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH v2 9/9] sched/fair: Consider capacity inversion in
 util_fits_cpu()
Message-ID: <20221108115139.wlrgjm2k6ucucvtv@airbuntu>
References: <20220804143609.515789-1-qais.yousef@arm.com>
 <20220804143609.515789-10-qais.yousef@arm.com>
 <xhsmhwn8avd07.mognet@vschneid.remote.csb>
 <20221105204141.3tno6fzuh536ye4e@airbuntu>
 <xhsmho7timw1c.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xhsmho7timw1c.mognet@vschneid.remote.csb>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/22 18:58, Valentin Schneider wrote:
> On 05/11/22 20:41, Qais Yousef wrote:
> > On 11/04/22 17:35, Valentin Schneider wrote:
> >> On 04/08/22 15:36, Qais Yousef wrote:
> >> > We do consider thermal pressure in util_fits_cpu() for uclamp_min only.
> >> > With the exception of the biggest cores which by definition are the max
> >> > performance point of the system and all tasks by definition should fit.
> >> >
> >> > Even under thermal pressure, the capacity of the biggest CPU is the
> >> > highest in the system and should still fit every task. Except when it
> >> > reaches capacity inversion point, then this is no longer true.
> >> >
> >> > We can handle this by using the inverted capacity as capacity_orig in
> >> > util_fits_cpu(). Which not only addresses the problem above, but also
> >> > ensure uclamp_max now considers the inverted capacity. Force fitting
> >> > a task when a CPU is in this adverse state will contribute to making the
> >> > thermal throttling last longer.
> >> >
> >> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> >> > ---
> >> >  kernel/sched/fair.c | 14 +++++++++-----
> >> >  1 file changed, 9 insertions(+), 5 deletions(-)
> >> >
> >> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> > index cb32dc9a057f..77ae343e32a3 100644
> >> > --- a/kernel/sched/fair.c
> >> > +++ b/kernel/sched/fair.c
> >> > @@ -4293,12 +4293,16 @@ static inline int util_fits_cpu(unsigned long util,
> >> >        * For uclamp_max, we can tolerate a drop in performance level as the
> >> >        * goal is to cap the task. So it's okay if it's getting less.
> >> >        *
> >> > -	 * In case of capacity inversion, which is not handled yet, we should
> >> > -	 * honour the inverted capacity for both uclamp_min and uclamp_max all
> >> > -	 * the time.
> >> > +	 * In case of capacity inversion we should honour the inverted capacity
> >> > +	 * for both uclamp_min and uclamp_max all the time.
> >> >        */
> >> > -	capacity_orig = capacity_orig_of(cpu);
> >> > -	capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> >> > +	capacity_orig = cpu_in_capacity_inversion(cpu);
> >> > +	if (capacity_orig) {
> >> > +		capacity_orig_thermal = capacity_orig;
> >> > +	} else {
> >> > +		capacity_orig = capacity_orig_of(cpu);
> >> > +		capacity_orig_thermal = capacity_orig - arch_scale_thermal_pressure(cpu);
> >> > +	}
> >> >
> >>
> >> IIUC the rq->cpu_capacity_inverted computation in update_cpu_capacity() can be
> >> summarised as:
> >>
> >> - If there is a PD with equal cap_orig, but higher effective (orig - thermal)
> >>   capacity
> >>   OR
> >>   there is a PD with pd_cap_orig > cpu_effective_cap:
> >>   rq->cpu_capacity_inverted = capacity_orig - thermal_load_avg(rq)
> >>
> >> - Else:
> >>   rq->cpu_capacity_inverted = 0
> >>
> >> Then, the code above uses either rq->cpu_capacity_inverted if it is
> >> non-zero, otherwise:
> >>
> >>   capacity_orig - arch_scale_thermal_pressure(cpu);
> >>
> >> Why use average thermal pressure in one case, and use instantaneous
> >> thermal pressure in the other?
> >
> > There was a big debate on [1] about using avg vs instantaneous.
> >
> 
> Interesting thread, thanks for the link!
> 
> > I used avg for detecting inversion to be consistent with using average in in
> > scale_rt_capacity(). I didn't want the inversion state to be flipping too
> > quickly too.
> >
> > I used the instantaneous in the other check based on that discussion. It seemed
> > using the average is hurtful when for example the medium drops an OPP and by
> > not reacting quickly at wake up we lose the chance to place it on a big; which
> > if my memory didn't fail me is what Xuewen was seeing.
> >
> 
> OK So IIUC by using the inst. pressure you start excluding CPUs sooner, and
> with the avg pressure you keep those CPUs out (if the pressure remained
> long enough).

Yes. I hope the discussion on avg vs instantaneous will be continued and we can
unify the usages.

> 
> > [1] https://lore.kernel.org/lkml/24631a27-42d9-229f-d9b0-040ac993b749@arm.com/
> >
> 
> >>
> >> Can't we get rid of rq->cpu_capacity_inverted and replace this whole thing
> >> with an unconditional
> >>
> >>   capacity_orig_thermal = capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu));
> >>
> >> ?
> >
> > I can't see how we end up with equivalent behavior then. Or address the
> > concerns raised by Xuewen and Lukasz on the RT thread in regards to avg vs
> > instantaneous.
> >
> > Specifically, if we don't use the new rq->cpu_capacity_inverted we can't handle
> > the case where the task is requesting to run at maximum performance but a small
> > drop in thermal pressure means it won't fit anywhere. That PD is the best fit
> > until it hits an inversion.
> >
> > Originally I wanted to defer handling thermal pressure into a different series.
> > But Vincent thought it's better to handle it now. We want more data points from
> > more systems tbh. But I think what we have now is still a good improvement over
> > what we had before.
> >
> > Lukasz had a patch [2] which could allow making thermal_load_avg() more
> > acceptable for systems that care about faster response times.
> >
> > [2] https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/
> >
> >
> > Thanks
> >
> > --
> > Qais Yousef
> 
