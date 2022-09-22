Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE78B5E5C2F
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbiIVHTp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbiIVHTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:19:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959BB6359
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:19:39 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s10so9877228ljp.5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Iq5Fm6kb4l/9l7hrrqLF7wzKUoBamfvADToHUOZBGpQ=;
        b=iU6d4nPD3iOlCMrWY+mCzqpv4+7GawgyDaLXYuSKkLeD9ZV7XlytBSr9BDbcDJJ3tv
         KgcZxYyj58ByN15K3UgzL1md55VbbdONrdZFPIUSAo503eCJit9cn9T1ihGK6dPWvYTj
         cZGinXYus7GDZAo3Ww+cTS23x+Cuk4c1iUmsYfaUZIUsE73egxEkvx5Fodw21b10WJu6
         JqITB08nNP6g4yQ/JO3DM3h/aclC5sqNklewB8UVng/2l4MDbamPvfd4jd9XxE9Ef3U8
         OGfszrthqGBzrs6bJk4w+F1e66/+udREweWVosA1OjV5C7nZ9lqKMlf74IZL4uhmm31y
         9MHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Iq5Fm6kb4l/9l7hrrqLF7wzKUoBamfvADToHUOZBGpQ=;
        b=aYKJVgmJN/Hh/qq27/A2whEu6HXm7APUqMQDSYD4nRqYC38nUOmej9jBCfx3QHJ5he
         I/LD08avUo0PXGMV4jCa/bjiMvV10dIO+2N+33OjFQRU2kD6aXpuRNMYxnr8rz1SMZD6
         aPqUtjcVC0X3e52wBYzmH5XexlXo2PoxaXv5XDiVh1dULO713ZKLT3y2wWQDkjq+Z4A3
         33hJx9e7e8BcdpiKnmfztJ+G5gQ2YR+hPItBeYefCNKDiwYA3YD5ZEnCGRoYUp0kXUph
         EyFYUGtFKSWeYmGL9v9HcoZiCE5MwfoXtlWwWQlzkKmdzZOMUcaEsYKAr62Wy2DrwKG7
         GLKA==
X-Gm-Message-State: ACrzQf2SSNA9X8MicO8jaNdJ2vy3ouDOQsqmph6abFM37Uvp713QJb8P
        Biw2mzXfJpEzBK4r6xwAa346BMwkGC3/Cx91eqqJLQ==
X-Google-Smtp-Source: AMsMyM4cAqH9Rqf1mtnGT4JF3CyFhM+N7tZZ1thnpOyhPnIk0E4uonInBLTDcOPzqnnmQPyN/oSncEFytC5v1ylHfYM=
X-Received: by 2002:a2e:bf21:0:b0:266:2be3:61e8 with SMTP id
 c33-20020a2ebf21000000b002662be361e8mr570118ljr.383.1663831177837; Thu, 22
 Sep 2022 00:19:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org> <20220921160834.4a2s3733vlr4rqfh@wubuntu>
In-Reply-To: <20220921160834.4a2s3733vlr4rqfh@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 22 Sep 2022 09:19:26 +0200
Message-ID: <CAKfTPtBWZ+BH+TmM-hcG8_StdNSP8JYmD7JX_ch7L-XEU6htOA@mail.gmail.com>
Subject: Re: [PATCH v4 0/8] Add latency priority for CFS class
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        chris.hyser@oracle.com, valentin.schneider@arm.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com, joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sept 2022 at 18:08, Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Vincent
>
> On 09/16/22 10:02, Vincent Guittot wrote:
> > This patchset restarts the work about adding a latency priority to describe
> > the latency tolerance of cfs tasks.
> >
> > The patches [1-4] have been done by Parth:
> > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> >
> > I have just rebased and moved the set of latency priority outside the
> > priority update. I have removed the reviewed tag because the patches
> > are 2 years old.
> >
> > The patch [5] uses latency nice priority to define a latency offset
> > and then to decide if a cfs task can preempt the current running task. The
> > patch gives some tests results with cyclictests and hackbench to highlight
> > the benefit of latency priority for short interactive task or
> > long intensive tasks.
> >
> > Patch [6] adds the support of latency_offset to task group by adding a
> > cpu.latency field. There were discussions for the last version about
> > using a real unit for the field so I decided to expose directly the
> > latency offset which reflects the time up to which we can preempt when the
> > value is negative, or up to which we can defer the preemption when the
> > value is positive.
> > The range is [-sysctl_sched_latency:sysctl_sched_latency]
> >
> > Patch [7] makes sched_core taking into account the latency offset.
> >
> > Patch [8] adds a rb tree to cover some corner cases where the latency
> > sensitive task is preempted by high priority task (RT/DL) or fails to
> > preempt them. This patch ensures that tasks will have at least a
> > slice of sched_min_granularity in priority at wakeup. The patch gives
> > results to show the benefit in addition to patch 5
> >
> > I have also backported the patchset on a dragonboard RB3 with an android
> > mainline kernel based on v5.18 for a quick test. I have used
> > the TouchLatency app which is part of AOSP and described to be very good
> > test to highlight jitter and jank frame sources of a system [1].
> > In addition to the app, I have added some short running tasks waking-up
> > regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
> > without overloading it (and disabling EAS). The 1st results shows that the
> > patchset helps to reduce the missed deadline frames from 5% to less than
> > 0.1% when the cpu.latency of task group are set.
> >
> > [1] https://source.android.com/docs/core/debug/eval_perf#touchlatency
>
> One thing that still confuses me is whether this proposal is supposed to be the
> only consumer of this interface or we still expect other users to be able to
> use this hint to optimize other sources of latency in the scheduler? Last
> discussion [1] raised issues on the interface and I haven't seen any
> discussions on the suitability of the interface to enable future consumers.
>
> I might have missed something. What's the current state on this?

Nothing has changed since the discussion in March:
https://lore.kernel.org/lkml/CAKfTPtBCKyqa-472Z7LtiWTq+Yirq6=jSrkzJtNbkdKXnwP-mA@mail.gmail.com/T/

>
>
> [1] https://lwn.net/Articles/820659/
>
>
> Thanks
>
> --
> Qais Yousef
