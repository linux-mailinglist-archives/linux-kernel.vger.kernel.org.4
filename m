Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E69F624327
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 14:25:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKJNZ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 08:25:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbiKJNZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 08:25:22 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117C15EFA3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:25:21 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id r203-20020a1c44d4000000b003cfa97c05cdso1669182wma.4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 05:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRubi9G2lBsUI33R2uhTRAQsKIxoXAIX1ikocWaZbRU=;
        b=xNVbNYHoO/lIhnGsF9DTTxB2whwoIA3dXO80I/gBfnfKpgcWcxWty4tth1trIm04Yo
         jBCS/METKaJeAV1EY+jX4DeJNvDcBfpDirYceqcwJ0pZ3rn98Ycrkaxltl6Hzu8HXU4r
         +shTNOrBz0HjK9C3mI5thgWtlfl69Mb/ylQPDR+GmI26wee4BCtoBpeC93A7Z4zgwm5t
         sF0hLClxMf/m7btc8ym4BCZJ2AKYCj0c3smlYq8YxuaHxn1a0C6mVjAXKfb/bA+GrL7U
         z90bL69P3UJW98q80eggEk9zKE1GvSb1XqLHbCf3wPlCA8gFtUcNFiSGAyVETVjje7uY
         0teQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRubi9G2lBsUI33R2uhTRAQsKIxoXAIX1ikocWaZbRU=;
        b=GuJk3omJnFkT7VN9DE+8/8N+p1gRZV2qKqiEzGBkyqu+QQk3ZEopWfAvsYHeVhf252
         1VKIKUGcywK2IoOxAsiQPj1QLs2OO56I1JLDJ5gCEyENM2c1BaIX1NYne3zrtG1ObwP+
         OSCeGolj3XrQYHh+O7hNUxAbJ36n1zWSFk/o85RcA2IqkZDjATWrox+qW0kr517RQidW
         HEl7TByShAhlfY2pYMCM9kxZHubk0VNcFk7mlI3uY7HDXA817rFFPLW04TFu7Z8XhawB
         /IBd1KjB3DN5j2OBBk4lppZSqZ2rX0fSQ/HQEhrSJGGWhR5vc0H626JbfH5XJ2S0pSA0
         SiNw==
X-Gm-Message-State: ACrzQf38tYZYbkTQHCeTEfhtJ0yZ2344wqT5aigyyvuE8hnfuKWaNC14
        zN8E54yD1SWw4Y9D6/cjUQUOkg==
X-Google-Smtp-Source: AMsMyM7s46svI6Mz8RpNwmiW3+qnblcjb5fYuUYLDgCzVxrrHjNVfDjbb6ZzvKdg8bNeGhK8VcsOoA==
X-Received: by 2002:a05:600c:16c6:b0:3cf:9a65:6860 with SMTP id l6-20020a05600c16c600b003cf9a656860mr21777738wmn.65.1668086719618;
        Thu, 10 Nov 2022 05:25:19 -0800 (PST)
Received: from airbuntu ([104.132.45.111])
        by smtp.gmail.com with ESMTPSA id d7-20020a05600c3ac700b003c65c9a36dfsm4754619wms.48.2022.11.10.05.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 05:25:19 -0800 (PST)
Date:   Thu, 10 Nov 2022 13:25:17 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kajetan Puchalski <kajetan.puchalski@arm.com>,
        Jian-Min Liu <jian-min.liu@mediatek.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Qais Yousef <qais.yousef@arm.com>,
        linux-kernel@vger.kernel.org,
        Jonathan JMChen <jonathan.jmchen@mediatek.com>
Subject: Re: [RFC PATCH 0/1] sched/pelt: Change PELT halflife at runtime
Message-ID: <20221110132517.vh2uzqlvw3upuwqf@airbuntu>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <0f82011994be68502fd9833e499749866539c3df.camel@mediatek.com>
 <YzVpqweg21yIn30A@hirez.programming.kicks-ass.net>
 <YzV9Gejo/+DL3UjK@e126311.manchester.arm.com>
 <YzV/yT6OYMgaq0kD@hirez.programming.kicks-ass.net>
 <YzWuq5ShtJC6KWqe@e126311.manchester.arm.com>
 <Y2kLA8x40IiBEPYg@hirez.programming.kicks-ass.net>
 <20221108194843.i4qckcu7zwqstyis@airbuntu>
 <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y2vMBWpPlIArwnI7@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/22 16:49, Peter Zijlstra wrote:
> On Tue, Nov 08, 2022 at 07:48:43PM +0000, Qais Yousef wrote:
> > On 11/07/22 14:41, Peter Zijlstra wrote:
> > > On Thu, Sep 29, 2022 at 03:41:47PM +0100, Kajetan Puchalski wrote:
> > > 
> > > > Based on all the tests we've seen, jankbench or otherwise, the
> > > > improvement can mainly be attributed to the faster ramp up of frequency
> > > > caused by the shorter PELT window while using schedutil.
> > > 
> > > Would something terrible like the below help some?
> > > 
> > > If not, I suppose it could be modified to take the current state as
> > > history. But basically it runs a faster pelt sum along side the regular
> > > signal just for ramping up the frequency.
> > 
> > A bit of a tangent, but this reminded me of this old patch:
> > 
> > 	https://lore.kernel.org/lkml/1623855954-6970-1-git-send-email-yt.chang@mediatek.com/
> > 
> > I think we have a bit too many moving cogs that might be creating undesired
> > compound effect.
> > 
> > Should we consider removing margins in favour of improving util ramp up/down?
> > (whether via util_est or pelt hf).
> 
> Yeah, possibly.
> 
> So one thing that was key to that hack I proposed is that it is
> per-task. This means we can either set or detect the task activation
> period and use that to select an appropriate PELT multiplier.

Note that a big difference compared to PELT HF is that we bias towards going up
faster in util_est, not being able to go down as quickly could impact power as
our residency in higher frequencies will be higher. Testing only can show how
big of a problem this is in practice.

> 
> But please explain; once tasks are in a steady state (60HZ, 90HZ or god
> forbit higher), the utilization should be the same between the various
> PELT window sizes, provided the activation period isn't *much* larger
> than the window.

It is steady state for a short period of time, before something else happens
that change the nature of the workload.

For example, being standing still in an empty room then an explosion suddenly
happens causing lots of activity to appear on the screen.

We can have a steady state at 20%, but an action on the screen could suddenly
change the demand to 100%.

You can find a lot of videos on how to tweak cpu frequencies and governor to
improve gaming performances on youtube by the way:

	https://www.youtube.com/results?search_query=android+gaming+cpu+boost

And this ancient video from google about impact of frequency scaling on games:

	https://www.youtube.com/watch?v=AZ97b2nT-Vo

this is truly ancient and the advice given then (over 8 years ago) is not
a reflection on current state of affairs.

The problem is not new; and I guess expectations just keeps going higher on
what one can do on their phone in spite of all the past improvements :-)

> 
> Are these things running a ton of single shot tasks or something daft
> like that?

I'm not sure how all game engines behave; but the few I've seen they don't tend
to do that.

I've seen apps like instagram using single shot tasks sometime in the (distant)
past to retrieve images. Generally I'm not sure how the Java based APIs behave.
There is an API for Job Scheduler that allows apps to schedule background and
foreground work; that could end up reusing a pool of tasks or creating new
ones. I'm not sure. Game engines tend to be written in NDKs; but simpler games
might not be.


Cheers

--
Qais Yousef
