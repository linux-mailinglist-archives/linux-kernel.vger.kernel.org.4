Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9069E215
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 15:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234271AbjBUONT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 09:13:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234222AbjBUONO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 09:13:14 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D1516A7B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:13:11 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id e9so132043plh.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 06:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SGZW5MhhWSuzxN07P+ERlBpgYTuis65PtkEETwyVr30=;
        b=z5ssYAvLlZqpdsQKRVJmHd9Vd7/a58S5YZEryXsdTpWBAD5cUwpm5aPQMlX7VQ/VPs
         5XbwfqWJNFZqWRi3VOGQurT4VMNSizgezwDv7PdcbW/QOX4rvpjI4g+DEOc7yWkyR+Q/
         +eoOhQ+wD+5bFkAmlYDfTHeY2WvTXPVS6BHTufB5yxCCvIPAL4auMwMEALsJQhLOhhQq
         UJErjMobOrO4LOwDYRa8Jj8bRaz1ynnOvDre1Xxyp46AwCk44lNNODOpvKf/w5jgsKBV
         WNMxpGEVrhmfd1qkCmRKiDdF1DNxY4xjvjXr6zBFvuAlO0g2Sw0o8lJlOba5Sbd8VSwX
         Pbxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SGZW5MhhWSuzxN07P+ERlBpgYTuis65PtkEETwyVr30=;
        b=4NrTL2j1nOysNXUv+0Aqu/k++LKY+33/snTLCZEeEBVagFos55QkfmQJ2cfvx9f3hC
         vusX3kE2dUFpQlmoBHwo+F08z/Asy2p5MDJIQmIZme84ae6hK9v4vffmjUgXCK5Amia9
         3nh96yilq3C/S+IBpwFvLc5fYN4Bhz9WvOR/ldvid/hA/vwhcXWG7MhrHjP4DzbXF+Cl
         BGNWo1jbniarCfOXbSEhaN7ZQUWoTaZicFjQycYOshm+CgjTW+BL1ZkOLW6PhPhz0SQb
         +Oi5f+F2Y2BVUONuQzVPVCrEO8iuUk+WN9cm+O4nkJPLe2VklO6tXylpvr2dc2jubMly
         +2tw==
X-Gm-Message-State: AO0yUKVD35SJIDU7txP0lYDEGnr3GQuvnjHFaTyz067dEeYUHAq9fDjt
        ueG+DrGVwwfbczxo9JMDMnO4E2WOiygUEwHh/+tSqQ==
X-Google-Smtp-Source: AK7set8HP2XtWwR74E0xle4aIfBn+LOunLn9btAqBtl/qZOp76dCSm4LivV8p9WAv3jWYvPp/qPLwzRTQ6coegyvzh8=
X-Received: by 2002:a17:90b:3946:b0:233:f98e:3a37 with SMTP id
 oe6-20020a17090b394600b00233f98e3a37mr1143430pjb.15.1676988790458; Tue, 21
 Feb 2023 06:13:10 -0800 (PST)
MIME-Version: 1.0
References: <20230113141234.260128-1-vincent.guittot@linaro.org>
 <20230113141234.260128-6-vincent.guittot@linaro.org> <Y/S+qrschy+N+QCQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Y/S+qrschy+N+QCQ@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 21 Feb 2023 15:12:59 +0100
Message-ID: <CAKfTPtD2eWfidO+FSrsjDYJkitJPubV+5+S5=dQ+0o00pud-mg@mail.gmail.com>
Subject: Re: [PATCH v10 5/9] sched/fair: Take into account latency priority at wakeup
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        cgroups@vger.kernel.org, qyousef@layalina.io,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
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

On Tue, 21 Feb 2023 at 13:53, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Fri, Jan 13, 2023 at 03:12:30PM +0100, Vincent Guittot wrote:
>
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 6c61bde49152..38decae3e156 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -568,6 +568,8 @@ struct sched_entity {
> >       /* cached value of my_q->h_nr_running */
> >       unsigned long                   runnable_weight;
> >  #endif
> > +     /* preemption offset in ns */
> > +     long                            latency_offset;
>
> I wonder about the type here; does it make sense to have it depend on
> the bitness; that is if s32 is big enough on 32bit then surely it is so
> too on 64bit, and if not, then it should be unconditionally s64.

I mainly wanted to stay aligned with the optimal width of the arch but
32bits is enough

>
>
> > +static void set_latency_offset(struct task_struct *p)
> > +{
> > +     long weight = sched_latency_to_weight[p->latency_prio];
> > +     s64 offset;
> > +
> > +     offset = weight * get_sleep_latency(false);
> > +     offset = div_s64(offset, NICE_LATENCY_WEIGHT_MAX);
> > +     p->se.latency_offset = (long)offset;
> > +}
>
> > +/*
> > + * latency weight for wakeup preemption
> > + */
> > +const int sched_latency_to_weight[40] = {
> > + /* -20 */     -1024,     -973,     -922,      -870,      -819,
> > + /* -15 */      -768,     -717,     -666,      -614,      -563,
> > + /* -10 */      -512,     -461,     -410,      -358,      -307,
> > + /*  -5 */      -256,     -205,     -154,      -102,       -51,
> > + /*   0 */         0,       51,      102,       154,       205,
> > + /*   5 */       256,      307,      358,       410,       461,
> > + /*  10 */       512,      563,      614,       666,       717,
> > + /*  15 */       768,      819,      870,       922,       973,
> > +};
>
> I'm slightly confused by this table, isn't that simply the linear
> function?

Yes, I had in mind to use a nonlinear function at the beginning so the table.

>
> Isn't all that the same as:
>
>         se->se.latency_offset = get_sleep_latency * nice / (NICE_LATENCY_WIDTH/2);
>
> ? The reason we have prio_to_weight[] is because it's an exponential,
> which is a bit more cumbersome to calculate, but surely we can do a
> linear function at runtime.
>
>
