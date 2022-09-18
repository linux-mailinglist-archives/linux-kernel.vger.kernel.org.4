Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A22025BBD79
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 12:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiIRKqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 06:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbiIRKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 06:46:14 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA52253A
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:46:13 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id f14so41439062lfg.5
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 03:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=yYCfKeGcTkqu5qBAQbw2UoaLHIe9hcO+llsGClyycow=;
        b=hGFfiY0Wz5xErgR5lACH1RDbjWQt/TlVQEPjsH3SuB5/ChBjHnICd7ny9b/Kkk3tN1
         gn+30+WMs6LhNh01ice24gccg0LwFj8LGldRI/jBvqOBoaPBSdFnxec2AOfromMwJmgQ
         2AWOzvLQemSnte957BOqzl+pbcKhNl6U7FThVCNXuCTAe4ReBVJ7TlsV9u1ega5tDF3v
         cPXqrPIX0XNT1DIGR8/kXTvBJLg4FzzDYZh1DvUmCNIhGZOBI4E0o06RNkO2+hFSNnsD
         KxZgCzT0ri3vEABwcc2hLQrAr7zNgmUAW9H6V00t5Dk+NZ/EPN4oglyMWlSttGlc/2ak
         weog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=yYCfKeGcTkqu5qBAQbw2UoaLHIe9hcO+llsGClyycow=;
        b=WdcP9HaHQzV850IhmD8DNn4vtyxBq+KrNf6FOhSDOalLe4cWCS9oQLrs+KS5UGPvLc
         ZXnQcNhbMcF+kb6za7+xjN/I+sKdo9wigxL2yYGrf0z9A22QQgWEQY3w+5fYGt4erx1p
         q4NdBY+G2sVabsBBUX/O8DriRLfT7jETiU7/Gnv72YV8zpPYG6Gdfql6b826WDOf/Vcy
         cAdnUTYL4eVj3qdDXC3EXFLbNNGAPkqsgzgqDJqRWupLyldGmntVbesPs/goG2BRiOpP
         rBJCXi2Om6nlWJCWdxiVrde0t2HwfxxP/IOEF2WzKeQHG7caBV36oJS8FgS04ZMWNYSp
         ws+Q==
X-Gm-Message-State: ACrzQf24icPyR17rSACfiIB7xou+z6UdxnZ+bt1DHPbCRXxp+7aWNbjn
        FmxIw+8vIe85WZBktyP9rPzSsZDO7jWH2yJpFXiTvQ==
X-Google-Smtp-Source: AMsMyM4XHZqWlMmGERuWfYO2Ek0+FZnhSmEZQC1+4kBmVpuYQkBVbAYe7kz+vPi/LvidClc7dA8IF8HPEpTH6o99lOA=
X-Received: by 2002:ac2:454a:0:b0:49c:6212:c44d with SMTP id
 j10-20020ac2454a000000b0049c6212c44dmr4691876lfm.430.1663497971314; Sun, 18
 Sep 2022 03:46:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-6-vincent.guittot@linaro.org>
 <20220916120245.2951-1-hdanton@sina.com> <CAKfTPtDV+ACXtQGH38sXwFVJfq+EzyKO1mCMZ68Q+GC5kw7-ww@mail.gmail.com>
 <20220917225819.817-1-hdanton@sina.com>
In-Reply-To: <20220917225819.817-1-hdanton@sina.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Sun, 18 Sep 2022 12:46:00 +0200
Message-ID: <CAKfTPtCFCYi3uM2B7wf4A3d4bfVHb=-_PA+6tWMQQCA9K9Hi5A@mail.gmail.com>
Subject: Re: [PATCH v4 5/8] sched/fair: Take into account latency priority at wakeup
To:     Hillf Danton <hdanton@sina.com>
Cc:     peterz@infradead.org, mgorman@suse.de, valentin.schneider@arm.com,
        parth@linux.ibm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 18 Sept 2022 at 00:58, Hillf Danton <hdanton@sina.com> wrote:
>
> On 16 Sep 2022 15:36:53 +0200 Vincent Guittot <vincent.guittot@linaro.org> wrote:
> >
> > Hi Hillf,
> >
> > On Fri, 16 Sept 2022 at 14:03, Hillf Danton <hdanton@sina.com> wrote:
> > >
> > > Hello Vincent
> > >
> > > On 16 Sep 2022 10:03:02 +0200 Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > > >
> > > > @@ -4606,6 +4608,7 @@ check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > > >
> > > >       se = __pick_first_entity(cfs_rq);
> > > >       delta = curr->vruntime - se->vruntime;
> > > > +     delta -= wakeup_latency_gran(curr, se);
> > > >
> > > >       if (delta < 0)
> > > >               return;
> > >
> > > What is derived from the latency nice you added is the runtime granulaity
> > > which has a role in preempting the current task.
> > >
> > > Given the same defination of latency nice as the nice, the runtime granularity
> > > can be computed without introducing the latency nice.
> > >
> > > Only for thoughts now.
> > >
> > > Hillf
> > >
> > > +++ b/kernel/sched/fair.c
> > > @@ -4569,7 +4569,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, st
> > >  static void
> > >  check_preempt_tick(struct cfs_rq *cfs_rq, struct sched_entity *curr)
> > >  {
> > > -       unsigned long ideal_runtime, delta_exec;
> > > +       unsigned long ideal_runtime, delta_exec, granu;
> > >         struct sched_entity *se;
> > >         s64 delta;
> > >
> > > @@ -4594,6 +4594,14 @@ check_preempt_tick(struct cfs_rq *cfs_rq
> > >                 return;
> > >
> > >         se = __pick_first_entity(cfs_rq);
> > > +
> > > +       granu = sysctl_sched_min_granularity +
> > > +               (ideal_runtime - sysctl_sched_min_granularity) *
> > > +               (se->latency_nice + 20) / LATENCY_NICE_WIDTH;
> >
> > There is no latency_nice field in se but a latency_offset instead
> >
> > Also at this step, we are sure that curr has run at least
> > sysctl_sched_min_granularity and we want now to compare curr vruntime
> > with first se's one. We take the latency offset into account to make
> > sure we will not preempt curr too early
> >
> > > +
> > > +       if (delta_exec < granu)
> > > +               return;
> > > +
> > >         delta = curr->vruntime - se->vruntime;
> > >
> > >         if (delta < 0)
>                 return;
>
>             if (delta > ideal_runtime)
>                 resched_curr(rq_of(cfs_rq));
>
> After another look, curr is not preempted without the gap in vruntime
> between curr and the first entity growing more than ideal runtime, while

Curr can be preempted as it has run more than the ideal time (1st
test). This one is to make sure that the diff does not become too
large. Here we reuse the same comparison as wakeup to make sure that a
newly curr will get a chance to run its ideal time after  having
preempted at wakeup the previous current

> with latency_offset, since the gap becomes larger, preempt happens later
> than ideal runtime thoughts IMO.
