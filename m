Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB8B95BCC07
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 14:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiISMlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 08:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiISMle (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 08:41:34 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822C2B4B
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:41:33 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id x27so13480629lfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Sep 2022 05:41:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=4MS7pFGtxxk+uvRVrGFzMzAmzd8aBxnJVj2n6SwQ71o=;
        b=Fo5SGGOkA30oGS8Q+5Up2JAfhK2aoIlsXcInJ4lupzm/BPrZDLKkgH2lsQq7Yfyxfn
         4UOtwge4PsZu67CaekCMrY5ObNXQdOEJ+tQFJDTkcx4MoX7W8ygp468vtMTgwvov1Ewp
         KhoNMhCbBk2ltt0zT8TmRJfpad90L3HZo9RoZz7/ZUU1y2wW94CzNIjbbH8LQoykfpdc
         c0BEe7RcTtwajOn7c+k9xZaqlmVFLC804PJt1q9xj0RD2Tv/QD30rhUw5+5BN45Ja/2U
         OYqZIoycflarY8VnKZ5M1h4szemS5Kpowvi2KveDiGf3WGHuuEmEjRuqchjyOePClpw0
         v4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=4MS7pFGtxxk+uvRVrGFzMzAmzd8aBxnJVj2n6SwQ71o=;
        b=k4B1PYQ76mg9LrqcIkAwD66axXZjoOPb4Wk+/VlDPfQ2oYgWNiLvSeiThG2hI0xxyc
         kVq0OOSdVTtIqD0aYc4zQDjpIIXgAkcNwYLQn2WuUDQFWtmT+eVoRLvJOh/CNrgkFMiQ
         U9FfIz8OjmRqnY7JZQJNRTKHTciW8/3vCZD15HauZC+e5D//Qv+6cuF+u+M2Zm3CEYlK
         oAZpHB3DPNANa0tWKefdhMcou98j+5+2Kf3UXRIXONqfD30EJ3jJOkEBV5r5oAjSbs8D
         mYVcoac9rzG22Pv9SdnYcdXzqNoCY9s0Abi3xOmRPmwglHZlopu3s7/HvbDd7hTNQrC2
         idZA==
X-Gm-Message-State: ACrzQf1X0UDV0eERDpCfCoFNUjZGATbfHF/Y1V/uFxDYPi1prsmP21bl
        neu/qu8rrgRcFfdSPByqLAiUYG4MQVkH2G0YDXmznQ==
X-Google-Smtp-Source: AMsMyM4Mjpap5ZJ+glNS6P/rgpH17YiCNQUKDi1XdEkURoPR1c8VJLGPw8e0yE+ac+qzyHYD/IHDRMU5hm+xWuD/b8I=
X-Received: by 2002:a05:6512:22c9:b0:499:cb5d:c138 with SMTP id
 g9-20020a05651222c900b00499cb5dc138mr6034950lfu.490.1663591291735; Mon, 19
 Sep 2022 05:41:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220916080305.29574-1-vincent.guittot@linaro.org>
 <20220916080305.29574-5-vincent.guittot@linaro.org> <5c060322-b132-c9b6-1253-6657ad08a63d@gnu.org>
In-Reply-To: <5c060322-b132-c9b6-1253-6657ad08a63d@gnu.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 19 Sep 2022 14:41:19 +0200
Message-ID: <CAKfTPtB8OeRzbDjfKoNUGLC1XUXT07G9QedCJ8stSMGvAD5hNg@mail.gmail.com>
Subject: Re: [PATCH v4 4/8] sched/core: Add permission checks for setting the
 latency_nice value
To:     timj <timj@gnu.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        valentin.schneider@arm.com, patrick.bellasi@matbug.net,
        David.Laight@aculab.com, pjt@google.com, pavel@ucw.cz,
        tj@kernel.org, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks you for describing in detail your use case.

On Mon, 19 Sept 2022 at 10:52, timj <timj@gnu.org> wrote:
>
> Hi,
>
> great to see work on improving low latency scenarios.
>
> There is an entire class of low latency audio applications that seems
> to be underrepresented in the current low latency use case descriptions.
> Experiencing audio drop outs (clicks or gaps) is generally perceived
> to be much more disruptive than graphics glitches like missing a frame
> deadline. That's why audio programs and devices with huge buffers put
> so much emphasis on avoiding drop outs however possible.
>
> Now, video players and tools like mpg123 are well served with increased
> audio buffer sizes to avoid drop outs. But the story is different with
> MIDI synthesizers (hit a piano key and expect immediate onset -
> especially drum synthesizers) or audio filters that implement realtime
> auto-tuning or short delay effects. Here, useful applications require
> IO latency guarantees significantly below 10ms. A useful setup would be
> e.g. 48kHz sampling frequency and an audio buffer of two fragments with
> 128 samples each. Simplified, that provides a combined IO latency of
> 2 * 128 / 48000 = 5.33ms if the audio application can rely on scheduling
> deadlines of 1 * 128 / 48000 = 2.6ms.
>
> So far, low latency applications have to jump through a number of hoops
> to roughly achieve such deadlines, ranging from requiring suid-
> installations for SCHED_DEADLINE (rarely used in practice), needing
> CAP_SYS_NICE, requiring a Jackd distro or depending on RtKit with all
> its shortcomings [1].
> I.e. there's a plethora of user space workarounds that have piled up
> over the decades, because regular user applications lack a simple way
> to tell the kernel one of:
>
> +1) I'm interested in throughput and don't care about latency: make -j
>   0) I'm fine with latency handling defaults: bash, X11
> -1) I'm depending on low latency scheduling much more than throughput:
>        audio-filter, synthesizer
>
> The emphasis here is on *USER* applications, not programs run by root.
> As you write in [PATCH v4 5/8]: "We don't want to provide more CPU
> bandwidth to a thread but reorder the scheduling to run latency
> sensitive task first whenever possible" and as outlined in the
> presentation "Latency_nice - Implementation and Use-case for Scheduler
> Optimization" by Shah et al [2], changing latency nice will not result
> in taking over the CPU or extending the possibility for DoS attacks.
>
> So what I'm getting at with this lengthy use case description is that
> it is vitally important for low latency audio applications without
> elevated privileges to be able to request low latency scheduling.
> I.e. please remove the check for !capable(CAP_SYS_NICE) to request low
> latency scheduling from the patch set, so audio applications can simply
> use their time slices (and nothing more) at the *right* time and have a
> way to tell the kernel about it without requiring root or daemons to
> relay the message. Conversely, idle tasks or make -j also don't need
> root to enjoy up to 100% of idle CPU time.

Ok, Your explanation makes sense to me especially because we want to
ensure to not provide more cpu time with this latency prio. I'm
curious to see the feedback from others about the reason we want
CAP_SYS_NICE other than following nice priority.

Side question, Have you tried this patchset (minus this patch) with
your use case ?

>
> [1] https://github.com/heftig/rtkit/issues/25
> [2] https://static.lwn.net/images/conf/2020/ospm/latency-nice-slides.pdf
>
> On 16.09.22 10:03, Vincent Guittot wrote:
> > From: Parth Shah <parth@linux.ibm.com>
> >
> > Since the latency_nice uses the similar infrastructure as NICE, use the
> > already existing CAP_SYS_NICE security checks for the latency_nice. This
> > should return -EPERM for the non-root user when trying to set the task
> > latency_nice value to any lower than the current value.
> >
> > Signed-off-by: Parth Shah <parth@linux.ibm.com>
> > [rebase]
> > Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> > ---
> >   kernel/sched/core.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2015e7d1f8b2..3c79c5419d1b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7444,6 +7444,10 @@ static int __sched_setscheduler(struct task_struct *p,
> >                       return -EINVAL;
> >               if (attr->sched_latency_nice < MIN_LATENCY_NICE)
> >                       return -EINVAL;
> > +             /* Use the same security checks as NICE */
> > +             if (attr->sched_latency_nice < p->latency_nice &&
> > +                 !capable(CAP_SYS_NICE))
> > +                     return -EPERM;
> >       }
> >
> >       if (pi)
>
