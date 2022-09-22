Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC45E631B
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 15:04:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbiIVNER (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 09:04:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbiIVNEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 09:04:14 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86F7E9CC4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:04:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id s6so14574439lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=orioyOGOubOGhTCTtopqoLShsTRfoEgdx0lBFZNZKis=;
        b=K46szh+sxzPJtXetS8p0VwxEtKCkWNewqETh/j4iATHXKzAjnmfjeYCqKcfaIcqJi1
         UiYzQlZVw+tnY5ctz9g9u/7c2/Mx/uO7CEFSRP9lIYkg5SVzPj+205HvEavKaJ3R3+Uq
         lUMqcoeUWsEcDxsdm26Wol7qBimXjksxQwT7MF92V0cAvYCktHqU0eX2cWGNbWarAVqE
         Id1tRZMLi+COZvmnEbPlr3KbtcMXzA5qyeRVgXCR0JVWHayYvUbKliSjid/tXd4egtNm
         XS7G/gnVbcjblMp9ItINSN9tdxkCBvHbdRnHu9RpuqUtP2AqYqMbwiRFrYT4wqBCIcfo
         Bl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=orioyOGOubOGhTCTtopqoLShsTRfoEgdx0lBFZNZKis=;
        b=B2roE/t8Kl1nsxa8xdWqK1SxK7i/Xx9ZkwjEvpMxcuyYxgVSLgc7y6kxg7cQuuemel
         KRvDd/vfm3e9rO7yF/DYl1jsr+7AJ2erin6OLdQhsd6C4vCmEIOyCT2Az33FFIYxI+ya
         mcj+gupMwsUM6VJFftc9j85O2/9Cko+/GpKMIM6TsFceVomX6jDDpCPeBtqusouPY1iF
         2hxuh+zFLIobccm/cizLymvGokoegh6vP7mD5isVdmT8DGoR3IhhTfP1iAmvDGK6GMOr
         vrXblMSW5+MpgocGBvjaXnHg297vd5uzKCZSS5rFy857klYATb5/lqXBDOfaAS9kkf4q
         P83A==
X-Gm-Message-State: ACrzQf1wWyBWkpMHWDCWrrvJhKhebGi4KZSvG2i2BR4IdiiqwS5RRANy
        GHlGTgzP1NGJi3Zlk3l/RRfp14/t9UMHSRpFh611Nw==
X-Google-Smtp-Source: AMsMyM5fdTV+HxE9OWGWvQOGCdx8ojC5q3f+gXLb6s8P1FjUyTJj3hOlE+KlDxAQh6XDQA8IRP6VfMmx5uyLNeOLhI0=
X-Received: by 2002:a05:6512:22c9:b0:499:cb5d:c138 with SMTP id
 g9-20020a05651222c900b00499cb5dc138mr1181571lfu.490.1663851849862; Thu, 22
 Sep 2022 06:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220921160834.4a2s3733vlr4rqfh@wubuntu> <CAKfTPtBWZ+BH+TmM-hcG8_StdNSP8JYmD7JX_ch7L-XEU6htOA@mail.gmail.com>
 <20220922110021.vg5uz3ampvdif5o3@wubuntu>
In-Reply-To: <20220922110021.vg5uz3ampvdif5o3@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Thu, 22 Sep 2022 15:03:57 +0200
Message-ID: <CAKfTPtC9PD+_tOqD1gaRwopYXq4G+XTEx_rAaBmZr2CRe=oRqw@mail.gmail.com>
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

On Thu, 22 Sept 2022 at 13:00, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 09/22/22 09:19, Vincent Guittot wrote:
> > On Wed, 21 Sept 2022 at 18:08, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > Hi Vincent
> > >
> > > On 09/16/22 10:02, Vincent Guittot wrote:
> > > > This patchset restarts the work about adding a latency priority to describe
> > > > the latency tolerance of cfs tasks.
> > > >
> > > > The patches [1-4] have been done by Parth:
> > > > https://lore.kernel.org/lkml/20200228090755.22829-1-parth@linux.ibm.com/
> > > >
> > > > I have just rebased and moved the set of latency priority outside the
> > > > priority update. I have removed the reviewed tag because the patches
> > > > are 2 years old.
> > > >
> > > > The patch [5] uses latency nice priority to define a latency offset
> > > > and then to decide if a cfs task can preempt the current running task. The
> > > > patch gives some tests results with cyclictests and hackbench to highlight
> > > > the benefit of latency priority for short interactive task or
> > > > long intensive tasks.
> > > >
> > > > Patch [6] adds the support of latency_offset to task group by adding a
> > > > cpu.latency field. There were discussions for the last version about
> > > > using a real unit for the field so I decided to expose directly the
> > > > latency offset which reflects the time up to which we can preempt when the
> > > > value is negative, or up to which we can defer the preemption when the
> > > > value is positive.
> > > > The range is [-sysctl_sched_latency:sysctl_sched_latency]
> > > >
> > > > Patch [7] makes sched_core taking into account the latency offset.
> > > >
> > > > Patch [8] adds a rb tree to cover some corner cases where the latency
> > > > sensitive task is preempted by high priority task (RT/DL) or fails to
> > > > preempt them. This patch ensures that tasks will have at least a
> > > > slice of sched_min_granularity in priority at wakeup. The patch gives
> > > > results to show the benefit in addition to patch 5
> > > >
> > > > I have also backported the patchset on a dragonboard RB3 with an android
> > > > mainline kernel based on v5.18 for a quick test. I have used
> > > > the TouchLatency app which is part of AOSP and described to be very good
> > > > test to highlight jitter and jank frame sources of a system [1].
> > > > In addition to the app, I have added some short running tasks waking-up
> > > > regularly (to use the 8 cpus for 4 ms every 37777us) to stress the system
> > > > without overloading it (and disabling EAS). The 1st results shows that the
> > > > patchset helps to reduce the missed deadline frames from 5% to less than
> > > > 0.1% when the cpu.latency of task group are set.
> > > >
> > > > [1] https://source.android.com/docs/core/debug/eval_perf#touchlatency
> > >
> > > One thing that still confuses me is whether this proposal is supposed to be the
> > > only consumer of this interface or we still expect other users to be able to
> > > use this hint to optimize other sources of latency in the scheduler? Last
> > > discussion [1] raised issues on the interface and I haven't seen any
> > > discussions on the suitability of the interface to enable future consumers.
> > >
> > > I might have missed something. What's the current state on this?
> >
> > Nothing has changed since the discussion in March:
> > https://lore.kernel.org/lkml/CAKfTPtBCKyqa-472Z7LtiWTq+Yirq6=jSrkzJtNbkdKXnwP-mA@mail.gmail.com/T/
>
> Okay. For my peace of mind, could you update the cover letter please to be more
> explicit that this is only one use case of potential others to come later in

I thought that the reference to Prath's patchset at the beg of the
cover letter was enough to highlight that there were other possible
uses of the interface. But I can mentioned that this is not the sole
and alone use of the interface can be done in the scheduler and other
places could also take advantage of this new hint.

> the future? The other 2 that I remember are improve load balancer search and
> modify EAS behavior. Parth had a use case to help take advantage of turbo
> frequencies, but not sure if this is still being pursued/desired.
>
> Your proposed use case could actually help make the EAS one unnecessary. But it
> is hard to tell at this stage and prefer to continue to consider it as
> a potential new consumer of this interface.
>
>
> Thanks!
>
> --
> Qais Yousef
