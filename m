Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6D9F6A4DC0
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 23:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbjB0WIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 17:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbjB0WHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 17:07:52 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D71229E3A
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:07:40 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id c18so5181793wmr.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 14:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+wyCkH7EB9sNMh5yZnsOs8dEjM1084lAnLUlPc7QNpg=;
        b=f5Dw1irqTzRW2zx/1ZGVX5EJWJ5iuYpLU7jbqqcwiH8kvq9TIVbpcQ4qdbHUekxT53
         yPJKi+KABVQsEMbkV1Lmn4gbCe2pokGYwK1oVQqCmnavUV73pMhIoCuu7ZN5RzeMZpFU
         HTY/3JfxT6jmxwP52th8OaDz81CrxMTtWKupIvpJ3luHRSY/z0kfg9m6rvyP81LgfSyA
         /9D6hmj49I0ReKt4jE1RNEZy/W8ESWGK2Fn5JptjFz2EYY3NXgipfVfhEKVV4vkf91+U
         hAX6duAT0qwvH/d/0dEjQPLWkLs2HdPdg4LNEnVoCzDUYdL7W7Bt3RA0POES1pIdn1QZ
         2Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+wyCkH7EB9sNMh5yZnsOs8dEjM1084lAnLUlPc7QNpg=;
        b=PJPlgAgyrVD/J2P2qZ14T4NcGcgJ6TCx80L4RL/8R0xEkxCqdCd5Fn1Ux9BI0jGIQs
         lEQkGdGVP0tA6VndvO8aVBAuF3ez74R9oyylyLAmrDM3GWCzngIs1tTnrYRp8dJhK6/D
         XaMYXI7gqvL5zM0omdTkbEODbEmNdGgLNzFAiWU7W9tDynmM4oIHK0kw4v4XYDFHTfes
         g0gEtvnWdHD+bwvSEowsSQTHwp9YkLR1S0aB9gnVhcV/NwwsSZbVffaBsuEcCv/SBL3w
         A9x/iHSUvfgH+sEXT2UrTk0uj4zMaQ8z6ZAYkrCwoZS32srIl8T3bNnlGgBFKZUHM8G2
         wqbg==
X-Gm-Message-State: AO0yUKUM5BuJmXPf6gcZxYQpEt3aijSjUkfSVy+/iud6sEz2paDgeuul
        wCxKg1QZHW4v9x5KAJzE3ZwoHA==
X-Google-Smtp-Source: AK7set9QZACxOMbwmNBljZhZqAfbfrQlloumry5onLd1CB5VUq62r/rTg5saj+iRv9lJa0UwxcnYDA==
X-Received: by 2002:a05:600c:3555:b0:3ea:f6c4:3060 with SMTP id i21-20020a05600c355500b003eaf6c43060mr471039wmq.18.1677535658607;
        Mon, 27 Feb 2023 14:07:38 -0800 (PST)
Received: from airbuntu (host86-163-35-10.range86-163.btcentralplus.com. [86.163.35.10])
        by smtp.gmail.com with ESMTPSA id c18-20020adfed92000000b002c54c9bd71fsm8303442wro.93.2023.02.27.14.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Feb 2023 14:07:37 -0800 (PST)
Date:   Mon, 27 Feb 2023 22:07:35 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, vincent.guittot@linaro.org,
        mingo@redhat.com, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, ke.wang@unisoc.com,
        zhaoyang.huang@unisoc.com
Subject: Re: [RFC PATCH] sched/fair: update the vruntime to be max vruntime
 when yield
Message-ID: <20230227220735.3kaytmtt53uoegq7@airbuntu>
References: <20230222080314.2146-1-xuewen.yan@unisoc.com>
 <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y/zO8WZV2kvcU78b@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/27/23 16:40, Peter Zijlstra wrote:
> On Wed, Feb 22, 2023 at 04:03:14PM +0800, Xuewen Yan wrote:
> > When task call the sched_yield, cfs would set the cfs's skip buddy.
> > If there is no other task call the sched_yield syscall, the task would
> > always be skiped when there are tasks in rq. 
> 
> So you have two tasks A) which does sched_yield() and becomes ->skip,
> and B) which is while(1). And you're saying that once A does it's thing,
> B runs forever and starves A?

I read it differently.

I understood that there are multiple tasks.

If Task A becomes ->skip; then it seems other tasks will continue to be picked
instead. Until another task B calls sched_yield() and become ->skip, then Task
A is picked but with wrong vruntime causing it to run for multiple ticks (my
interpretation of 'always run' below).

There are no while(1) task running IIUC.

> 
> > As a result, the task's
> > vruntime would not be updated for long time, and the cfs's min_vruntime
> > is almost not updated.
> 
> But the condition in pick_next_entity() should ensure that we still pick
> ->skip when it becomes too old. Specifically, when it gets more than
> wakeup_gran() behind.

I am not sure I can see it either. Maybe __pick_first_entity() doesn't return
the skipped one, or for some reason vdiff for second is almost always
< wakeup_gran()?

> 
> > When this scenario happens, when the yield task had wait for a long time,
> > and other tasks run a long time, once there is other task call the sched_yield,
> > the cfs's skip_buddy is covered, at this time, the first task can run normally,
> > but the task's vruntime is small, as a result, the task would always run,
> > because other task's vruntime is big. This would lead to other tasks can not
> > run for a long time.

The error seems that when Task A finally runs - it consumes more than its fair
bit of sched_slice() as it looks it was starved.

I think the question is why it was starved? Can you shed some light Xuewen?

My attempt to help to clarify :) I have read this just like you.

FWIW I have seen a report of something similar, but I didn't managed to
reproduce and debug (mostly due to ENOBANDWIDTH); and not sure if the details
are similar to what Xuewen is seeing. But there was a task starving for
multiple ticks - RUNNABLE but never RUNNING in spite of other tasks getting
scheduled in instead multiple times. ie: there was a task RUNNING for most of
the time, and I could see it preempted by other tasks multiple time, but not by
the starving RUNNABLE task that is hung on the rq. It seems to be vruntime
related too but speculating here.


Cheers

--
Qais Yousef

> 
> I'm not seeing how this could happen, it should never get behind that
> far.
> 
> Additionally, check_preempt_tick() will explicitly clear the buddies
> when it finds the current task has consumed it's ideal slice.
> 
> I really cannot see how your scenario can happen.
> 
> > In order to mitigate this, update the yield_task's vruntime to be cfs's max vruntime.
> > This way, the cfs's min vruntime can be updated as the process running.
> 
> This is a bad solution, SCHED_IDLE tasks have very low weight and can be
> shot really far to the right, leading to other trouble.
> 
