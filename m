Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444B45FF2B4
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 19:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiJNRBu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 13:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiJNRBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 13:01:47 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B351E1BF214
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:01:46 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id i65so4402599ioa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 10:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XyHPmmmm2Rd3qRYcI1oR6WB1UIUHTnUFpbEAoag3+wU=;
        b=dtwzU2M8qbIa/3FuGoN56whLOFavFkWtQZF/F/J/u+FQXTJwEzfcHKo7UJn5v3NA+t
         TCFxskWbENGbRYGWP1vaPszqUFlHrnFBjAIR80wRiWI6dB1h35YPUU/nhpJhtm9iT4Mw
         zH7wYzH8jdkri8ojcHgNVFZ1+t7+TYcmq4uC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XyHPmmmm2Rd3qRYcI1oR6WB1UIUHTnUFpbEAoag3+wU=;
        b=5az0b/rWzUaWCjsgxwl740udnUbqztoBQIrRJ4CPpQ782WKlpz/b926bkIP4vE1iOD
         cH4h58IPRi99L7F7eEPyxB/ibj76ircL09gP/RYwF9YARzL0n8iShao99tGOCOeS9vYI
         +V9Q8bJMeO+IsxOGhnxek5bF9ePYdb2SsJrPeRA5r3NSq8IIOpiZ+YzV8BEHNVNBbJt0
         AblsGgo9r33IiDZFVGrKi1bZrTEVxIrgHoCwrs+SRINbvQyDLkHg+j3K1+NCsOL7NFGT
         /owk0KAXSTZhoLCgzjx06VsRrGzzTrqBq5nyEP2AHLpE0KEsegfoQrUXPrfZ/fQ7Kl+u
         ju+Q==
X-Gm-Message-State: ACrzQf1d5SeJoxdnPOdXDbt70byFj1uZ0MXE7HUAUyK7hRB7fo9slYja
        JxgPyprT6ue/a9ZhP/usFmNoQcG0zmfUYW+XDgXSIA==
X-Google-Smtp-Source: AMsMyM7j8baSDK5niur76ajn86Mp7nBelMeiyYCWTw3SxFxjCd/ba86HkptauPI/nof/JihQvU2KDnX5yCxbgE3usiA=
X-Received: by 2002:a05:6638:2393:b0:363:6c5d:9584 with SMTP id
 q19-20020a056638239300b003636c5d9584mr3359464jat.232.1665766906021; Fri, 14
 Oct 2022 10:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20221003214501.2050087-1-connoro@google.com> <20221003214501.2050087-6-connoro@google.com>
In-Reply-To: <20221003214501.2050087-6-connoro@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Fri, 14 Oct 2022 13:01:35 -0400
Message-ID: <CAEXW_YRBYJU-iwF6FMGm=Tv5Tqw1CW3aONU6eRzThF9yjEFtJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 05/11] sched: Split scheduler execution context
To:     "Connor O'Brien" <connoro@google.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        John Stultz <jstultz@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Qais Yousef <qais.yousef@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Youssef Esmat <youssefesmat@google.com>
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
Just on the yield bits (my opinion):

On Mon, Oct 3, 2022 at 5:45 PM Connor O'Brien <connoro@google.com> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> Lets define the scheduling context as all the scheduler state in
> task_struct and the execution context as all state required to run the
> task.
>
> Currently both are intertwined in task_struct. We want to logically
> split these such that we can run the execution context of one task
> with the scheduling context of another.
>
> To this purpose introduce rq::proxy to point to the task_struct used
> for scheduler state and preserve rq::curr to denote the execution
> context.
>
> XXX connoro: A couple cases here may need more discussion:
> - sched_yield() and yield_to(): whether we call the sched_class
>   methods for rq->curr or rq->proxy, there seem to be cases where
>   proxy exec could cause a yielding mutex owner to run again
>   immediately. How much of a concern is this?

A task chosen to run again after calling yield is not unprecedented.
From sched_yield manpage:
"If the calling thread is the only thread in the highest priority list
at that time, it will continue to run after a call to sched_yield()."

[...]
> @@ -8276,6 +8300,11 @@ static void do_sched_yield(void)
>         rq = this_rq_lock_irq(&rf);
>
>         schedstat_inc(rq->yld_count);
> +       /*
> +        * XXX how about proxy exec?
> +        * If a task currently proxied by some other task yields, should we
> +        * apply the proxy or the current yield "behaviour" ?
> +        */
>         current->sched_class->yield_task(rq);

I think we should keep it simple and keep the existing yield behavior.
If there was no priority inversion, and lock owner called yield, why
should it behave any differently?

>
>         preempt_disable();
> @@ -8625,6 +8654,10 @@ EXPORT_SYMBOL(yield);
>   */
>  int __sched yield_to(struct task_struct *p, bool preempt)
>  {
> +       /*
> +        * XXX what about current being proxied?
> +        * Should we use proxy->sched_class methods in this case?
> +        */
>         struct task_struct *curr = current;
>         struct rq *rq, *p_rq;
>         unsigned long flags;

Ditto.

> @@ -8984,7 +9017,7 @@ void __init init_idle(struct task_struct *idle, int cpu)
[...]

Thanks,

 - Joel
