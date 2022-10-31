Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C44613CC1
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:00:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbiJaSAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiJaSAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:00:36 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB386423
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:00:34 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id fz10so2210016qtb.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EESE7Qk6RD3HsvrbKWsjg2fpvxN09XKBO8g4pTk9Zqc=;
        b=aS1lzemXQZpkfQM3ZRNpeWXBq9ad6z/ulZOwAp7Ve7KVMrHtE1PxeZTDeRbaoRnG5z
         13xbG3qUxDGi4PO3bejle5EMuLIOEi7uwnC0lGMvNj0NwEjugAykCDqI5aR5GLmb+5AG
         Rg8YJv29s/scDENhkhvGCepRtBBwHE0GR4KZA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EESE7Qk6RD3HsvrbKWsjg2fpvxN09XKBO8g4pTk9Zqc=;
        b=Gifvr7TvcbW3mEo9P4MVqT0bjHNDL3xKF6I4ha95IQ1TOGgJslne73INOoVNdjVs6g
         SFgMl8pJWZhvdyys4pWmCvbu5bL5flJmocqy+pt1GKeUtrZFkS1uePO8sxO2kSk+fySR
         S2neC4JjKU4Fj/Q9xLZEl2TrotqTygrzNCreZeA+Y32BaNvVw8mTHxGAHjPTskwjFpQu
         yo14AXTGuwN3s4WoAl8rXIbH7NpMit3AFFJPniPGKd2h5bM3OJroFFHskk/dKcF5mnsS
         akglyWW648dWc2Dl0jiXptpVbuQ1M6vmPu15Yzn1OwOIBGQY7EZtSfnu0E+C9rdWPTWz
         7FUw==
X-Gm-Message-State: ACrzQf1Tl64UbVd3NMFwWO5WqLnr7ozvOiuIItxuY3iMT3Orqw7lAogu
        Utm6kZIIu1HJN35YFjbvTDKttQ==
X-Google-Smtp-Source: AMsMyM6CoPJkkzrWoAnfpzaFJpBszz5RSRjvF3lADxNaffS+PLPKvfhsxrDfu46vhDUs4o5AEOnJ5w==
X-Received: by 2002:a05:622a:1826:b0:3a4:ae8c:6eb4 with SMTP id t38-20020a05622a182600b003a4ae8c6eb4mr11705178qtc.210.1667239232970;
        Mon, 31 Oct 2022 11:00:32 -0700 (PDT)
Received: from localhost (48.230.85.34.bc.googleusercontent.com. [34.85.230.48])
        by smtp.gmail.com with ESMTPSA id br18-20020a05620a461200b006b953a7929csm5048243qkb.73.2022.10.31.11.00.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 11:00:31 -0700 (PDT)
Date:   Mon, 31 Oct 2022 18:00:30 +0000
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Connor O'Brien <connoro@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, John Stultz <jstultz@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [RFC PATCH 07/11] sched: Add proxy execution
Message-ID: <Y2ANPi7y5HhHvelr@google.com>
References: <dab347c1-3724-8ac6-c051-9d2caea20101@arm.com>
 <34B2D8B9-A0C1-4280-944D-17224FB24339@joelfernandes.org>
 <4e396924-c3be-1932-91a3-5f458cc843fe@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4e396924-c3be-1932-91a3-5f458cc843fe@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 05:39:45PM +0100, Dietmar Eggemann wrote:
> On 29/10/2022 05:31, Joel Fernandes wrote:
> > Hello Dietmar,
> > 
> >> On Oct 24, 2022, at 6:13 AM, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >> ﻿On 03/10/2022 23:44, Connor O'Brien wrote:
> >>> From: Peter Zijlstra <peterz@infradead.org>
> 
> [...]
> 
> >>> +    put_prev_task(rq, next);
> >>> +    if (curr_in_chain) {
> >>> +        rq->proxy = rq->idle;
> >>> +        set_tsk_need_resched(rq->idle);
> >>> +        /*
> >>> +         * XXX [juril] don't we still need to migrate @next to
> >>> +         * @owner's CPU?
> >>> +         */
> >>> +        return rq->idle;
> >>> +    }
> >>
> >> --> (1)
> > 
> > Sorry but what has this got to do with your comment below?
> 
> This was the place where fake_task was used in:
> 
> https://lkml.kernel.org/r/20181009092434.26221-6-juri.lelli@redhat.com
> 
> +migrate_task:
>    ...
> +	 }
> +	 rq->proxy = &fake_task;           <-- !!!
> +
> +	 for (; p; p = p->blocked_task) {
> 
> >>> +    rq->proxy = rq->idle;
> 
> We use `rq->idle` now,

I see. I need to research that, but a comment below:

> [...]
> 
> >>> +    rq_unpin_lock(rq, rf);
> >>> +    raw_spin_rq_unlock(rq);
> >>
> >> Don't we run into rq_pin_lock()'s:
> >>
> >> SCHED_WARN_ON(rq->balance_callback && rq->balance_callback !=
> >> &balance_push_callback)
> >>
> >> by releasing rq lock between queue_balance_callback(, push_rt/dl_tasks)
> >> and __balance_callbacks()?
> > 
> > Apologies, I’m a bit lost here. The code you are responding to inline does not call rq_pin_lock, it calls rq_unpin_lock.  So what scenario does the warning trigger according to you?
> 
> True, but the code which sneaks in between proxy()'s
> raw_spin_rq_unlock(rq) and raw_spin_rq_lock(rq) does.
> 

Got it now, thanks a lot for clarifying. Can this be fixed by do a
__balance_callbacks() at:

> __schedule()
> 
>   rq->proxy = next = pick_next_task()
> 
>     __pick_next_task()
> 
>       pick_next_task_rt()
> 
>         set_next_task_rt()
> 
>           rt_queue_push_tasks()
> 
>             queue_balance_callback(..., push_rt_tasks); <-- queue rt cb
> 
>   proxy()
> 

... here, before doing the following unlock?

>     raw_spin_rq_unlock(rq)
> 
>                  ... <-- other thread does rq_lock_XXX(rq)
>                                               raw_spin_rq_lock_XXX(rq)
>                                                 rq_pin_lock(rq)
> 
>     raw_spin_rq_lock(rq)
> 
>   context_switch()
> 
>      finish_task_switch()
> 
>        finish_lock_switch()
> 
>          __balance_callbacks(rq) <-- run rt cb here
> 
>   __balance_callbacks(rq)() <-- or run rt cb here


Hmm also Connor, does locktorture do hotplug? Maybe it should to reproduce
the balance issues.

thanks,

 - Joel


