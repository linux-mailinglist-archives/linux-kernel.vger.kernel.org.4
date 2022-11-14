Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 821716285CF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:46:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiKNQqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237960AbiKNQqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:46:18 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9AF02F035
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:46:17 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id e189so8604365iof.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Nk3mVs8FjhorkCtEwcVs6HC/MIvJqCP6jBTg6TIU4cg=;
        b=vfKA5rSlDrq50Z91yEwMAJH8+820M93XB99uUBH/zwg5ye8DC5S9LHwIBIv0hA/0r6
         yuEaXlrg640dyRlOJOGqk6mWcW9bB18gwV3k/osS1JJabzTstFz7Qv+/337pFrErsGnN
         2/zSJJ5WYze0/xHA6PGpNjk0wbpKPOdB304N/NYYOFfYCrVpR2/G1RsPeMjgcOEtgP8c
         pJbYLOCd4Vf18PAEdd3Ihv17DYqw75WYowzZ464/yCkhGV6iU4FvXNP3uS25d67R93+R
         VHJHI4RgwPD5oo1csNZLN2uLdJLJR2MoNf1TGp7dhgUOSCuf8iQYqH5qTlJJcbaQEab7
         p7yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Nk3mVs8FjhorkCtEwcVs6HC/MIvJqCP6jBTg6TIU4cg=;
        b=DHbUWQekiglNENd2htXhZGt6mg9FMOqrImxi9iNPCKCMKKViqHORMo0YciNHfmfLPu
         4U2TDM18mMKBnA5FCImI4kA3Fjc+uw33dK9lFHr5PqMVSMekrVpIGElcuv7BZlcw/JvX
         2w5CUUr0q5fLIND+wwveAnjA2cSoGJ4Ihsh+WHocOfNM24w+C05Bw23NDJZeCy4uJms7
         Jh6mxLht839YOkYfrx4dFd3u6p1rGkN5c4wszOJl7wJMMMJlTgEX4SHkAE6sJ1ZggQ1D
         9a0Y9405PUVVeFwSA6XcAF5NgyrpjHmxZVVTufM9I6Hy4mrBQ0vKbZc0aiBcGpSVZ9GC
         UWxQ==
X-Gm-Message-State: ANoB5pn0mxNy4Nx24cMalJpDD4C4fX01YBa/dkGXdtweT+boXEsOLuj+
        4NWl+KyV/FJqtVTGVcSgoguyfF4kFSTmcR//mIgj2w==
X-Google-Smtp-Source: AA0mqf7GOfA3wPCbS2eSNRiHN14ajl5syHiae3fdGm5syzlC98W6EBmdN8e5+Fb6IcVXfk9xSp/NprUpL4vQRlAm0W4=
X-Received: by 2002:a5d:88d2:0:b0:6d6:a029:eba5 with SMTP id
 i18-20020a5d88d2000000b006d6a029eba5mr6054188iol.154.1668444377260; Mon, 14
 Nov 2022 08:46:17 -0800 (PST)
MIME-Version: 1.0
References: <20221110175009.18458-1-vincent.guittot@linaro.org>
 <20221110175009.18458-2-vincent.guittot@linaro.org> <Y3JqrQJWOyHMY+G2@google.com>
In-Reply-To: <Y3JqrQJWOyHMY+G2@google.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 14 Nov 2022 17:46:05 +0100
Message-ID: <CAKfTPtDnigeLQsBWU_iSPvxMbe2mpA4t1Y215WEZ4jPxjRvLGg@mail.gmail.com>
Subject: Re: [PATCH v8 1/9] sched/fair: fix unfairness at wakeup
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qyousef@layalina.io, chris.hyser@oracle.com,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 at 17:20, Patrick Bellasi
<patrick.bellasi@matbug.net> wrote:
>
> Hi Vincent!
>
> On 10-Nov 18:50, Vincent Guittot wrote:
>
> [...]
>
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 1fc198be1ffd..14879d429919 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2432,9 +2432,9 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
> >  extern const_debug unsigned int sysctl_sched_nr_migrate;
> >  extern const_debug unsigned int sysctl_sched_migration_cost;
> >
> > -#ifdef CONFIG_SCHED_DEBUG
> >  extern unsigned int sysctl_sched_latency;
> >  extern unsigned int sysctl_sched_min_granularity;
> > +#ifdef CONFIG_SCHED_DEBUG
> >  extern unsigned int sysctl_sched_idle_min_granularity;
> >  extern unsigned int sysctl_sched_wakeup_granularity;
> >  extern int sysctl_resched_latency_warn_ms;
> > @@ -2448,6 +2448,34 @@ extern unsigned int sysctl_numa_balancing_scan_period_max;
> >  extern unsigned int sysctl_numa_balancing_scan_size;
> >  #endif
> >
> > +static inline unsigned long  get_sched_latency(bool idle)
>                                 ^^^^^^^^^^^^^^^^^
>
> This can be confusing since it's not always returning the sysctl_sched_latency
> value. It's also being used to tune the vruntime at wakeup time.
>
> Thus, what about renaming this to something more close to what's used for, e.g.
>    get_wakeup_latency(se)
> ?
>
> Also, in the following patches we call this always with a false parametr.
> Thus, perhaps in a following patch, we can better add something like:
>    #define max_wakeup_latency get_wakeup_latency(false)
> ?

I'm going to rename get_wakeup_latency by get_sleep_latency() as
proposed earlier.

I don't see the benefit of adding a macro of top so will keep the parameter

>
> > +{
> > +     unsigned long thresh;
> > +
> > +     if (idle)
> > +             thresh = sysctl_sched_min_granularity;
> > +     else
> > +             thresh = sysctl_sched_latency;
> > +
> > +     /*
> > +      * Halve their sleep time's effect, to allow
> > +      * for a gentler effect of sleepers:
> > +      */
> > +     if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > +             thresh >>= 1;
> > +
> > +     return thresh;
> > +}
> > +
> > +static inline unsigned long  get_latency_max(void)
>                                 ^^^^^^^^^^^^^^^
>
> This is always used to cap some form of vruntime deltas in:
>  - check_preempt_tick()
>  - wakeup_latency_gran()
>  - wakeup_preempt_entity()
> It's always smaller then the max_wakeup_latency (as defined above).
>
> Thus, does not seems something like:
>    wakeup_latency_threshold()
> a better documenting naming?
>
> > +{
> > +     unsigned long thresh = get_sched_latency(false);
> > +
> > +     thresh -= sysctl_sched_min_granularity;
> > +
> > +     return thresh;
> > +}
>
> [...]
>
> Best,
> Patrick
>
> --
> #include <best/regards.h>
>
> Patrick Bellasi
>
