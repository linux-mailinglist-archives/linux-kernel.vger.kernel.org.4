Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30015718A76
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbjEaTta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjEaTt1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:49:27 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49D9219F
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:49:04 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4f3b314b1d7so6961847e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 12:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20221208.gappssmtp.com; s=20221208; t=1685562542; x=1688154542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWftgnL1JUEVgu5g1KaXUWRYMdL6RWwjpZ6YOc+opWY=;
        b=gYZOPnXo+wFQQniQ3IoxdhE0b2qzKm15sYIPu4gClZMBNfQiY5d4zP9bKPk9SJw6Xb
         Kj91DTsDIK63uYGJKLhtC1VwEgeFM0JKqNe6ijkNp8kTwKpK5FIuNI80RT+psY/x8CkC
         Qr1s2gixCG6OKgm8/ADdxJ2Rd6dF9GgWWDWZRb5ygvBu5RTMkFLQQREoPVxpt9jy+Sl5
         OapeADpk3OyQEFkQHbIXdTQ+bPPPRk5j8tDru8xcF55FfLCGM47Nyd2LGwCEnFVSK1xk
         Q+vAwkmbSGJ3BlFIgzJMXJGal2zLlNqSQSq21B06FyXbE84g9MbGCT7wUa1Y/vEmvHN1
         nMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685562542; x=1688154542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWftgnL1JUEVgu5g1KaXUWRYMdL6RWwjpZ6YOc+opWY=;
        b=c1fNJ5LntsVGu9GxMygkx9HFqAN7l9nMK76rksemDRERjT3Mu7Tddv0P2sQS0po8vx
         dz6HUM2h6mlxaQ2AiemiisqVirpHlXRevKpbdu6kSFwjSQwsbEeo8IKLCTEPb84nc3Z+
         ojJpGjwM3F1NgCnhwhzcWzaopr3ECmYd4U8Rt9NBG9uN9QgY/dI8GRyzgsbLHZF/7MQ/
         0rqaM4YUaSOmZxw/pyLIiSyEsohncdDqmJeefmfy+MIQjNUSUUiq6U4kL6ESxdLEE2Sn
         FtsyPvXXxbgaDggkpYhnIHVX+PQrWIetMR9ftNbJJprkPHC6oQ/RbbejQ/OkDrhvzaps
         qe5Q==
X-Gm-Message-State: AC+VfDxVRh70shEAIZoTJdpSwtxjxvdEkTfJpdflmt3GEOYCsdJn352W
        gdioZsQqW4jpK1FhakWi2Mg+cw==
X-Google-Smtp-Source: ACHHUZ4dNwRSa+JsmzKh4/DsXq/kyKIlyodU63aJ/svIeLOm2gOHEuq56fUU15KtmuSUwvx6ZW4o3A==
X-Received: by 2002:a05:6512:3906:b0:4cb:280b:33c9 with SMTP id a6-20020a056512390600b004cb280b33c9mr52965lfu.24.1685562542322;
        Wed, 31 May 2023 12:49:02 -0700 (PDT)
Received: from airbuntu (host109-154-46-114.range109-154.btcentralplus.com. [109.154.46.114])
        by smtp.gmail.com with ESMTPSA id q13-20020a7bce8d000000b003f43f82001asm25490426wmj.31.2023.05.31.12.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 May 2023 12:49:01 -0700 (PDT)
Date:   Wed, 31 May 2023 20:48:57 +0100
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, corbet@lwn.net,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net, pjt@google.com,
        pavel@ucw.cz, qperret@google.com, tim.c.chen@linux.intel.com,
        joshdon@google.com, timj@gnu.org, kprateek.nayak@amd.com,
        yu.c.chen@intel.com, youssefesmat@chromium.org,
        joel@joelfernandes.org, efault@gmx.de, tglx@linutronix.de
Subject: Re: [PATCH 00/15] sched: EEVDF and latency-nice and/or slice-attr
Message-ID: <20230531194857.t45rolkntpej3u3c@airbuntu>
References: <20230531115839.089944915@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230531115839.089944915@infradead.org>
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,URI_DOTEDU autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/31/23 13:58, Peter Zijlstra wrote:
> Hi!
> 
> Latest version of the EEVDF [1] patches.
> 
> The only real change since last time is the fix for tick-preemption [2], and a 
> simple safe-guard for the mixed slice heuristic.
> 
> Other than that, I've re-arranged the patches to make EEVDF come first and have
> the latency-nice or slice-attribute patches on top.
> 
> Results should not be different from last time around, lots of people ran them
> and found no major performance issues; what was found was better latency and
> smaller variance (probably due to the more stable latency).
> 
> I'm hoping we can start queueing this part.
> 
> The big question is what additional interface to expose; some people have
> voiced objections to the latency-nice interface, the 'obvious' alternative
> is to directly expose the slice length as a request/hint.

I haven't thought much about this, but..

There are two desired properties form user space that I hope we can achieve
with this new hint:

1. The obvious improve the wake up latencies of some tasks.
2. Hint that there are some tasks that are happy to suffer high latencies.

2 is important because one thing that user space wants to do but we lack
mechanisms to do so is give a hint some tasks are background tasks and can be
shuffled around and preempted more often at the expense of keeping other
tasks more happy.

I'm hoping this + uclamp_max there would be reasonable way to tag these
tasks now so that they consume less power and can be kept 'out of the way' when
necessary.

Slice length seems a bit counter intuitive for these use cases. Maybe expose
the lag? Not sure if this neutral though to allow moving away from EEVDF in the
future if we ever need to. deadline can sound too promising probably.

Also, we had in mind to use these in EAS to avoid packing (though this has to
be re-evaluated if still needed) which is another source of latency. I think
Oracle wanted to use that to control the search depth at load balance IIRC
- not sure if they still want that.

Not sure where we stand from multiple users of this hint now. Should they be
new hints? If so, are we okay with continue to extend sched_setattr() or better
create a proper QoS framework?

As a side note - I started working on some patches to generalize the load
balancer misfit path. Issues we see:

1. latency sensitive tasks ending up on the same CPU can end up suffering. We
   need both wake up and load balancer to be aware of this and help spreading.
2. Busy uclamp_max tasks can end up stuck on a wrong core with no ability to
   move it around. I still have to see this in practice but it's a concern for
   wider deployment (which hasn't happened yet).

I think the misfit path the right way to handle these cases. But I could be
wrong. (or maybe you already take care of this and I just need to better read
the patches). For the wake up side of things I think we need to be careful of
cramming latency sensitive tasks on the same rq if we can avoid it. I didn't
spot that in Vincent patches, neither in yours (which I yet to look better at).

If I may piggy-back a bit more. We seem to reserve a policy for SCHED_ISO,
which AFAICT had an old proposal to better tag interactive tasks. Is this
something waiting for someone to come forward with a proposal for again? I have
to say, the choice of interactive policy looks attractive. I wonder sometimes
if we need to go vertical (new policy/sched_class) instead of horizental - or
maybe both.

Sorry a bit of a brain dump here. HTH.


Cheers

--
Qais Yousef

> 
> The very last patch implements this alternative using sched_attr::sched_runtime
> but is untested.
> 
> Diffstat for the base patches [1-11]:
> 
>  include/linux/rbtree_augmented.h |   26 +
>  include/linux/sched.h            |    7 +-
>  kernel/sched/core.c              |    2 +
>  kernel/sched/debug.c             |   48 +-
>  kernel/sched/fair.c              | 1105 ++++++++++++++++++--------------------
>  kernel/sched/features.h          |   24 +-
>  kernel/sched/sched.h             |   16 +-
>  7 files changed, 587 insertions(+), 641 deletions(-)
> 
> 
> [1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564
> 
> [2] https://lkml.kernel.org/r/20230420150537.GC4253%40hirez.programming.kicks-ass.net
> 
