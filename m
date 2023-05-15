Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02AF702E23
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242183AbjEONaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242330AbjEONaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:30:10 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411922139
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:30:00 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-24deb9c5ffcso8566399a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684157399; x=1686749399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7SCmCEY4SD1dVrpECTlRaP1GJisQe+ITmKu8plXymTQ=;
        b=nX+a+xpepEVTRELdWBq3vXhrAnysGS+K7EVbG4zp9aEfek5mpUrooZgprPqR5f+Rmk
         mLeMFK0btyxAO5cE/Zs/5XkcmoEg3hSo3TyivQROoBbTOQQ6KLj24ujKIWPaMxn/Kre+
         LiORDh2kUPdmEwYqju//ULMVXdvPgoOqHSELOnrdd/9pZnglUsHLPw5Ri+byZdhKcYmK
         A7Yw638/KF0rGdPcUHKIcKHGNv9pfcUXaE9xIZTnzFI8Mf5/MKAuzgpp+yMkazkKbG6X
         h9UQnkg7s15T5+tBhIauGnMpDJYXFFjCJRAZyy6HrBXU9zSpioqVa7foz717Z5IihN+0
         utAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157399; x=1686749399;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SCmCEY4SD1dVrpECTlRaP1GJisQe+ITmKu8plXymTQ=;
        b=WdbazGwfsKiYMZ9UP7/8YRqB5x++O+gAr9XHHouiCLXW5VzC+9bzno1HWS921quqZm
         zhVIQBC40WjndJUQzkcQ3o9VW/uQrxoibRgM3KJ0dNDBmOqf2hI6M82+Tlx1xymsGQ02
         QxK3e1o/105euP3x8hKhp+fYan9tjzy43nrdjgX3eJRaOIZ9oTAMSWbrdM+9cyZZfN9K
         vc2V/xfYL+OofaDZIUElW+NJhg138/9+yvbG5JGy8QFRxifzvRRHZyDrewERJXabOauz
         IB90JrYZph9gxdxkiwqdL2gdh3TvaGkXOtLAJiszgQJKSlnLsRyl8XdwTv3393+6kp7E
         rsvA==
X-Gm-Message-State: AC+VfDwztzRs2dt7Ze9L4DmYjAEmiBPhcnLH6NJHutgU3gf6M91yyGHi
        gvF4J8WhR7UppgO11Ifey5496jUpaP75kBux2I1oSA==
X-Google-Smtp-Source: ACHHUZ49ZYr+uKDvpkpxX+HpWCEhXsiAPkAnbGJqMKB3Coaa79OQsjat16Q1SHphyyzhxHF7BGDtAHXqS+VMScq7WIw=
X-Received: by 2002:a17:90a:604b:b0:24d:e3dc:4b10 with SMTP id
 h11-20020a17090a604b00b0024de3dc4b10mr33644946pjm.23.1684157399600; Mon, 15
 May 2023 06:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230515063848.77947-1-jiahao.os@bytedance.com> <20230515063848.77947-3-jiahao.os@bytedance.com>
In-Reply-To: <20230515063848.77947-3-jiahao.os@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 May 2023 15:29:48 +0200
Message-ID: <CAKfTPtDvaWYyK31io1P1cJKF0OU2NfE79q7RKDaiE4LORz5L4g@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] sched/core: Avoid double calling update_rq_clock()
 in __balance_push_cpu_stop()
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
> The WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 17 PID: 138 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  __balance_push_cpu_stop+0x146/0x180
>  ? migration_cpu_stop+0x2a0/0x2a0
>  cpu_stopper_thread+0xa3/0x140
>  smpboot_thread_fn+0x14f/0x210
>  ? sort_range+0x20/0x20
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>
> To avoid this warning, we remove update_rq_clock() from
> the __migrate_task() function. And in order to avoid
> missing rq clock update, add update_rq_clock() call before
> migration_cpu_stop() calls __migrate_task().
>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/core.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 944c3ae39861..2bcf6a8e71fc 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2398,7 +2398,6 @@ static struct rq *__migrate_task(struct rq *rq, struct rq_flags *rf,
>         if (!is_cpu_allowed(p, dest_cpu))
>                 return rq;
>
> -       update_rq_clock(rq);
>         rq = move_queued_task(rq, rf, p, dest_cpu);
>
>         return rq;
> @@ -2456,10 +2455,12 @@ static int migration_cpu_stop(void *data)
>                                 goto out;
>                 }
>
> -               if (task_on_rq_queued(p))
> +               if (task_on_rq_queued(p)) {
> +                       update_rq_clock(rq);
>                         rq = __migrate_task(rq, &rf, p, arg->dest_cpu);
> -               else
> +               } else {
>                         p->wake_cpu = arg->dest_cpu;
> +               }
>
>                 /*
>                  * XXX __migrate_task() can fail, at which point we might end
> --
> 2.37.0
>
