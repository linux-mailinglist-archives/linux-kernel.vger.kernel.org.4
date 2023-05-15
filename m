Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AB9702E24
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242330AbjEONah (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbjEONa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:30:28 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83DF270E
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:30:15 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-250252e4113so8684261a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:30:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684157415; x=1686749415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ko+d8ireVUCHhYExnhdaC2SRXz04dws8GLecG4R5UEQ=;
        b=Z1SZDAW0IoZP2NjMRrPIW8t2AT+1nlbKaGLjWJ26bpneApaOhAb9QrQSJyX5d5GFbg
         jXCFxtVQSkpO5jP3pXgK2x4z8ugpYY0+s7JCVdBN/AXRZR4LoatGuzTZYLPhybZu1u3u
         /2m04opXHOsRVlOWe0pkM8nA0n5p9nyDkYahVpvr4phtcM84mtBg5D7St5vnki8yHcEK
         cwxsmw9SwyUYim2wlVE01RXu+F++bSDGETMtToI6MUSJtT465GekTxSifLXneeTj/qUi
         GWfm2yFHXOAMW/JpNYkgFXGZkirDtoY2R8BZxsdnWvBVXU7LBnekSPNUM9RbRy9nLUqt
         KtdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157415; x=1686749415;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ko+d8ireVUCHhYExnhdaC2SRXz04dws8GLecG4R5UEQ=;
        b=X5SvN9kCDIfm0qWg1WBGjvHl92Tan0cCov/PEd72jI3EDPfQfsY09wshiVluo+V7Cw
         Fl9xKqRn43J5aTUmVVhfnPfF4yWa4Ouj+KespALlFFgBZBEjUXdfNRMrxY5Xfv94IxoM
         zWUNYAx+2VIR4U4EQ1aOkc61nEcHb68ZiY0rdccxfuxG+ZrPtvNJRdJ0Yp19Cz6zaQaF
         yPlZeHciE8WBUEZQ8XFWoe4bcpFpJjVcpz6O7zJWyasLzvZdH71pGqIX5Tcfi0Kr1lLJ
         u7QQ15+v9Z/MZLUJcmuVZG7bi5pO/U1oFsdhZxgL4S9+rSZfRfK+cv8JPD1nEVGglt3y
         9PBg==
X-Gm-Message-State: AC+VfDxN6SZKbIO/fYYHqqs5EW59DqUoFVU3eL3s/l/conk2YS72SyyQ
        jKCwFI81//I0KuFCXrEuGcNCVpruLlPoxcr7XF0pbw==
X-Google-Smtp-Source: ACHHUZ4pNFI0uxrW5iHc9KtRBweu/yvJ15DLQ440uUrXqhMNR31xdSnmBxTUDjw1zu3sO/9lsBMUMn4wjmBiJiLjoLs=
X-Received: by 2002:a17:90a:778c:b0:250:3bc3:2b09 with SMTP id
 v12-20020a17090a778c00b002503bc32b09mr35028628pjk.12.1684157415033; Mon, 15
 May 2023 06:30:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230515063848.77947-1-jiahao.os@bytedance.com> <20230515063848.77947-4-jiahao.os@bytedance.com>
In-Reply-To: <20230515063848.77947-4-jiahao.os@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 May 2023 15:30:03 +0200
Message-ID: <CAKfTPtDby6A_SwBramkU15nQ3rWPuC+dkfhSs4aXJKkoNPhuCg@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] sched/core: Avoid multiple calling
 update_rq_clock() in __cfsb_csd_unthrottle()
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023 at 08:39, Hao Jia <jiahao.os@bytedance.com> wrote:
>
> After commit 8ad075c2eb1f ("sched: Async unthrottling for cfs
> bandwidth"), we may update the rq clock multiple times in the loop of
> __cfsb_csd_unthrottle(). At that time the following warning will be
> triggered.
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 54 PID: 0 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  unthrottle_cfs_rq+0x4b/0x300
>  __cfsb_csd_unthrottle+0xe0/0x100
>  __flush_smp_call_function_queue+0xaf/0x1d0
>  flush_smp_call_function_queue+0x49/0x90
>  do_idle+0x17c/0x270
>  cpu_startup_entry+0x19/0x20
>  start_secondary+0xfa/0x120
>  secondary_startup_64_no_verify+0xce/0xdb
>
> Before the loop starts, we update the rq clock once and call
> rq_clock_start_loop_update() to prevent updating the rq clock
> multiple times. And call rq_clock_stop_loop_update() After
> the loop to clear rq->clock_update_flags.
>
> Fixes: 8ad075c2eb1f ("sched: Async unthrottling for cfs bandwidth")
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c  |  9 +++++++++
>  kernel/sched/sched.h | 21 +++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..af9604f4b135 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5576,6 +5576,14 @@ static void __cfsb_csd_unthrottle(void *arg)
>
>         rq_lock(rq, &rf);
>
> +       /*
> +        * Iterating over the list can trigger several call to
> +        * update_rq_clock() in unthrottle_cfs_rq().
> +        * Do it once and skip the potential next ones.
> +        */
> +       update_rq_clock(rq);
> +       rq_clock_start_loop_update(rq);
> +
>         /*
>          * Since we hold rq lock we're safe from concurrent manipulation of
>          * the CSD list. However, this RCU critical section annotates the
> @@ -5595,6 +5603,7 @@ static void __cfsb_csd_unthrottle(void *arg)
>
>         rcu_read_unlock();
>
> +       rq_clock_stop_loop_update(rq);
>         rq_unlock(rq, &rf);
>  }
>
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index ec7b3e0a2b20..50446e401b9f 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1546,6 +1546,27 @@ static inline void rq_clock_cancel_skipupdate(struct rq *rq)
>         rq->clock_update_flags &= ~RQCF_REQ_SKIP;
>  }
>
> +/*
> + * During cpu offlining and rq wide unthrottling, we can trigger
> + * an update_rq_clock() for several cfs and rt runqueues (Typically
> + * when using list_for_each_entry_*)
> + * rq_clock_start_loop_update() can be called after updating the clock
> + * once and before iterating over the list to prevent multiple update.
> + * After the iterative traversal, we need to call rq_clock_stop_loop_update()
> + * to clear RQCF_ACT_SKIP of rq->clock_update_flags.
> + */
> +static inline void rq_clock_start_loop_update(struct rq *rq)
> +{
> +       lockdep_assert_rq_held(rq);
> +       rq->clock_update_flags |= RQCF_ACT_SKIP;
> +}
> +
> +static inline void rq_clock_stop_loop_update(struct rq *rq)
> +{
> +       lockdep_assert_rq_held(rq);
> +       rq->clock_update_flags &= ~RQCF_ACT_SKIP;
> +}
> +
>  struct rq_flags {
>         unsigned long flags;
>         struct pin_cookie cookie;
> --
> 2.37.0
>
