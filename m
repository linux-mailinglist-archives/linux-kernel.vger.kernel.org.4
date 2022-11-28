Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7418363AB15
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229668AbiK1Oda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:33:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiK1Od2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:33:28 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B7DE710B6E;
        Mon, 28 Nov 2022 06:33:27 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10A70D6E;
        Mon, 28 Nov 2022 06:33:34 -0800 (PST)
Received: from e126311.manchester.arm.com (unknown [10.57.69.169])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1A0053F67D;
        Mon, 28 Nov 2022 06:33:25 -0800 (PST)
Date:   Mon, 28 Nov 2022 14:32:12 +0000
From:   Kajetan Puchalski <kajetan.puchalski@arm.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     daniel.lezcano@linaro.org, lukasz.luba@arm.com,
        Dietmar.Eggemann@arm.com, dsmythies@telus.net,
        yu.chen.surf@gmail.com, kajetan.puchalski@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 2/2] cpuidle: teo: Introduce util-awareness
Message-ID: <Y4TGbK+AhzRdiPA6@e126311.manchester.arm.com>
References: <20221031121314.1381472-1-kajetan.puchalski@arm.com>
 <20221031121314.1381472-3-kajetan.puchalski@arm.com>
 <CAJZ5v0hHvf-033Oa-nW7UEZq=9cTFzn6e_znccPXBUeNa=YY+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hHvf-033Oa-nW7UEZq=9cTFzn6e_znccPXBUeNa=YY+Q@mail.gmail.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022 at 07:27:13PM +0100, Rafael J. Wysocki wrote:
> > +/*
> > + * The number of bits to shift the cpu's capacity by in order to determine
> > + * the utilized threshold
> > + */
> > +#define UTIL_THRESHOLD_SHIFT 6
>
> Why is this particular number regarded as the best one?

Based on my testing this number achieved the best balance of power and
performance on average. It also makes sense from looking at the util
plots. The resulting threshold is high enough to not be triggered by
background noise and low enough to react quickly when activity starts
ramping up.

> > +static void teo_get_util(struct cpuidle_device *dev, struct teo_cpu *cpu_data)
> > +{
> > +       unsigned long util = sched_cpu_util(dev->cpu);
> > +
> > +       cpu_data->utilized = util > cpu_data->util_threshold;
>
> Why exactly do you need the local variable here?

It's not necessarily needed, I can replace it with comparing the result
of the call directly.

> Then, if there's only one caller, maybe this could be folded into it?

I do think it's nicer to have it separated in its own helper function, that
way if anything more has to be done with the util it'll all be
self-contained. Having only one caller shouldn't be a big issue, it's
also the case for teo_middle_of_bin and teo_find_shallower_state in the
current TEO implementation.

> > +               /* don't update metrics if the cpu was utilized during the last sleep */
> 
> Why?
> 
> The metrics are related to idle duration and cpu_data->utilized
> indicates whether or not latency should be reduced.  These are
> different things.
> 
> Moreover, this is just one data point and there may not be any direct
> connection between it and the decision made in this particular cycle.

Agreed, v4 already has this part removed.

> > +               if (!cpu_data->utilized)
> > +                       teo_update(drv, dev);
> >                 dev->last_state_idx = -1;
> >         }
> >
> > @@ -323,6 +381,21 @@ static int teo_select(struct cpuidle_driver *drv, struct cpuidle_device *dev,
> >                         goto end;
> >         }
> >
> > +       teo_get_util(dev, cpu_data);
> > +       /* the cpu is being utilized and there's only 2 states to choose from */
> > +       /* no need to consider metrics, choose the shallowest non-polling state and exit */
> 
> A proper kernel-coding-style 2-line comment, please!
> 
> Also I would say "utilized beyond the threshold" instead of just
> "utilized" and "there are only 2 states" (plural).

Both good points, I'll fix that.

> > +       if (drv->state_count < 3 && cpu_data->utilized) {
> > +               for (i = 0; i < drv->state_count; ++i) {
> > +                       if (dev->states_usage[i].disable ||
> > +                                       drv->states[i].flags & CPUIDLE_FLAG_POLLING)
> > +                               continue;
> > +                       break;
> 
> This looks odd.  It would be more straightforward to do
> 
> if (!dev->states_usage[i].disable && !(drv->states[i].flags &
> CPUIDLE_FLAG_POLLING)) {
>         idx = i;
>         goto end;
> }
> 
> without the "break" and "continue".

Fair enough, this works as well.

> I've changed my mind with respect to adding the idx == 1 check to
> this.  If the goal is to reduce latency for the "loaded" CPUs, this
> applies to deeper idle states too.

I see, this has no effect on arm devices one way or the other so I don't
mind, it's completely up to you. In light of Doug's test results
regarding this change, should I remove the check in v5?

Thanks,
Kajetan
