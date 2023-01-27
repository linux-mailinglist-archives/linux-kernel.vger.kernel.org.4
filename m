Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D41167F0EC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 23:10:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231886AbjA0WKa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Jan 2023 17:10:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjA0WK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jan 2023 17:10:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95530C64C
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:10:28 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9so6334854pll.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Jan 2023 14:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kmjrMnYCXi/rj2ul8IC92eQ3ZAY55RwvPXH2SwVG2oc=;
        b=Joeg9twXF3K1plBxGdNv+20m0ULT2GmVdeDW8f+IQWIdrKHOBsDONBzhWCv0h57uN0
         gbsR1KMmp11MqBAdg5mc5TKzIVg6L1vn6o95MztgKW7TrnL8b0oZfanu65bO7+E8bVC6
         U5VmrTq/Ng8Oavliw33jFun3MmV2T5Lmp13UCLO2YXEw9FPnpLjdZTG+nq+87bE9VPhH
         RtRmREmsYysIUxo7/qqXgm8LjTBWMzWvAhlRosTo5Fg2x4iwB9NWpIsnRDzYHyuDLJk3
         FQBdf+qJqTHPwzIXFLKzYbMmMV38OeVWbff8roS8/sS8GIuzSwFxuEjb/tk7gQJ7aYP4
         k/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kmjrMnYCXi/rj2ul8IC92eQ3ZAY55RwvPXH2SwVG2oc=;
        b=p7hZ2jhcZF3Inam1LE7X0YXiCuC80R3X1asNrYK8cDOX2T24MW7/3H45ijvnUSrJlg
         legVGX2immWLQfwD0gbsMRBBA36vDCpIhx+vSc63kT3Lrrcff5h03gbM98AGHUYd1eqV
         RJ7imSxZlO9G96Gh66MGehJrioYEYfHahlIyaZ9VYLBp/0XTFvJv4PTAy5y6yJyCmI47
         dQ9nSgWyZxMKpoYNOXTo7vi9lG8jteT9TyBFVjnpIyh7NVEv7akyv6eCBAIwdBOH1VQE
         aAboa+RDPqmdQ/chr/LLS/8PIPuJVgB9vbOnb1zwjqsNlxw3lM0msH800NWNUbfh6Cqn
         ZtmQ==
X-Gm-Message-State: AO0yUKWqVScL6V6pdjaEZPb7fq5w9sK08ie5Unfmsqd5zzS4sDmfkiOc
        Fiw36wcuGe9XRySIcSrFF8OD5h3O/3fB2MfJdO8=
X-Google-Smtp-Source: AK7set9XUrOtcXfgucaH7UcILt26gHqhdb51sOPgZJe5dT+Nku1Fgt7yLoEZ/HfxrMBXRsLLxzXSWw==
X-Received: by 2002:a17:90a:3e03:b0:22b:b82a:8b5f with SMTP id j3-20020a17090a3e0300b0022bb82a8b5fmr161911pjc.2.1674857427013;
        Fri, 27 Jan 2023 14:10:27 -0800 (PST)
Received: from bsegall-glaptop.localhost (c-67-188-112-16.hsd1.ca.comcast.net. [67.188.112.16])
        by smtp.gmail.com with ESMTPSA id ds11-20020a17090b08cb00b0022c0a05229fsm3234945pjb.41.2023.01.27.14.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:10:25 -0800 (PST)
From:   Benjamin Segall <bsegall@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Roman Kagan <rkagan@amazon.de>,
        Zhang Qiao <zhangqiao22@huawei.com>,
        Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [bug-report] possible s64 overflow in max_vruntime()
References: <73e639d5-702b-0d03-16d9-a965b1963ef6@huawei.com>
        <Y6RRfF5yRew7rdCp@hirez.programming.kicks-ass.net>
        <Y9GG3N5ivVvyETa2@u40bc5e070a0153.ant.amazon.com>
        <Y9J25xMrItpeHIxD@hirez.programming.kicks-ass.net>
        <Y9LG5vkf/4ufJb35@u40bc5e070a0153.ant.amazon.com>
        <Y9O5Fwfib2CVAMwl@hirez.programming.kicks-ass.net>
        <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
Date:   Fri, 27 Jan 2023 14:10:23 -0800
In-Reply-To: <CAKfTPtBMSg2SDXq=sVt99TyM+tEXRFL74EQ57-t5uKYAXUUyLg@mail.gmail.com>
        (Vincent Guittot's message of "Fri, 27 Jan 2023 17:18:56 +0100")
Message-ID: <xm26v8kr7ho0.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent Guittot <vincent.guittot@linaro.org> writes:

> On Fri, 27 Jan 2023 at 12:44, Peter Zijlstra <peterz@infradead.org> wrote:
>>
>> On Thu, Jan 26, 2023 at 07:31:02PM +0100, Roman Kagan wrote:
>>
>> > > All that only matters for small sleeps anyway.
>> > >
>> > > Something like:
>> > >
>> > >         sleep_time = U64_MAX;
>> > >         if (se->avg.last_update_time)
>> > >           sleep_time = cfs_rq_clock_pelt(cfs_rq) - se->avg.last_update_time;
>> >
>> > Interesting, why not rq_clock_task(rq_of(cfs_rq)) - se->exec_start, as
>> > others were suggesting?  It appears to better match the notion of sleep
>> > wall-time, no?
>>
>> Should also work I suppose. cfs_rq_clock takes throttling into account,
>> but that should hopefully also not be *that* long, so either should
>> work.
>
> yes rq_clock_task(rq_of(cfs_rq)) should be fine too

No, last_update_time is based on cfs_rq_clock_pelt(cfs_rq), and it will
get more and more out of sync as time goes on, every time the cfs_rq
throttles. It won't reset when the throttle is done.

>
> Another thing to take into account is the sleeper credit that the
> waking task deserves so the detection should be done once it has been
> subtracted from vruntime.
>
> Last point, when a nice -20 task runs on a rq, it will take a bit more
> than 2 seconds for the vruntime to be increased by more than 24ms (the
> maximum credit that a waking task can get) so threshold must be
> significantly higher than 2 sec. On the opposite side, the lowest
> possible weight of a cfs rq is 2 which means that the problem appears
> for a sleep longer or equal to 2^54 = 2^63*2/1024. We should use this
> value instead of an arbitrary 200 days
