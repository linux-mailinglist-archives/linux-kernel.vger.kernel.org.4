Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68404702E25
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 15:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242387AbjEONau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 09:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbjEONam (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 09:30:42 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899E219A6
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:30:30 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-24dec03ad8fso9133610a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 06:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684157430; x=1686749430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9iEajs3yLmQPcVXajU/jZRpJQYfqJavnjdSLHoqXRyc=;
        b=Nb4wRsJ0grTsnaCS/XWHZymWAeYN7PwhrcwWdNIm11W3DjNoD8IWsC+jJfU74I1T9n
         5VJnjQgypZINSTYo6OixXEtoFgKIpRsK/+9MtjtFCnUYLYScCO7wq40KBU5Pn0ZfUj2E
         Kv3tKHIqxYAI97U3h5nDnu3EX4pZzEd+iu2NFSX1M2kpBWkq2IYYvlANepgLgY3qIVrT
         99UEA6h61Sh0ZwwS6HbVlC3fnvftQfuITdJu6DtZASqGQxpCs547WpsbNp8rhhfoo5o9
         ySI8m0QRqWfgEy60TcacX42uvndn6AlBmnF7KVeBYEmY7CBCQUMSXi/WNC6NAa5icM7P
         f95Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684157430; x=1686749430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9iEajs3yLmQPcVXajU/jZRpJQYfqJavnjdSLHoqXRyc=;
        b=GkTc6+uN50+3TBSQKC1FtY2DcUTv57nWqKw7foJwqKEcHXoBS5Ays13OWE8Wt1w5zP
         PukPaxgZ7aqk0VTUpMMwYT9+k3K8ZPcD4IUODW1t277eWKvreFGWMxn9Iwn9kWZ5JD7x
         XhhDY9ACxsCGbPe3sIxSHZy+p5xOjWysoFOnxpxZPtnMNSSJhzf6bYqCIELGq+8jv6qN
         hJYz/BB8nlGwTxV2u2JRdkr4HiDdjKqxDM9oUIoudhgVDY2L53n739YlDYeQhMvqNZnN
         qVzSm/0hdXWE7AS0uptp+INUgUKBz19liG7fZ/VEE7BEC5p47TZ29wFdn9hb0XvL76yp
         eoxQ==
X-Gm-Message-State: AC+VfDyk3fhnjtX0y+rQA+tk8JxI1gX7XJ4f6nru2J83pasoikJ7vuZF
        1jSiPzSrfnRAnNS2OJoW48hWLdzScpah+aKW9dDk7g==
X-Google-Smtp-Source: ACHHUZ6CRJ5F+mwOPEctRc2A+2LTsasazVB9Z+sRjKRB4VUKtGrMUAByGoMDWTFvixPvbeyTS12eB4HNsSp+jcOzun4=
X-Received: by 2002:a17:90a:74c6:b0:24e:82f:f640 with SMTP id
 p6-20020a17090a74c600b0024e082ff640mr33273331pjl.8.1684157429409; Mon, 15 May
 2023 06:30:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230515063848.77947-1-jiahao.os@bytedance.com> <20230515063848.77947-5-jiahao.os@bytedance.com>
In-Reply-To: <20230515063848.77947-5-jiahao.os@bytedance.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 15 May 2023 15:30:18 +0200
Message-ID: <CAKfTPtDBBZZH9_GuFNh8rXyxzjRB9Sp=_bhnWO=SNDPxRZ1XOw@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] sched/core: Avoid multiple calling
 update_rq_clock() in unthrottle_offline_cfs_rqs()
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
> This WARN_DOUBLE_CLOCK warning is triggered during cpu offline.
> ------------[ cut here ]------------
> rq->clock_update_flags & RQCF_UPDATED
> WARNING: CPU: 0 PID: 3323 at kernel/sched/core.c:741
> update_rq_clock+0xaf/0x180
> Call Trace:
>  <TASK>
>  unthrottle_cfs_rq+0x4b/0x300
>  rq_offline_fair+0x89/0x90
>  set_rq_offline.part.118+0x28/0x60
>  rq_attach_root+0xc4/0xd0
>  cpu_attach_domain+0x3dc/0x7f0
>  partition_sched_domains_locked+0x2a5/0x3c0
>  rebuild_sched_domains_locked+0x477/0x830
>  rebuild_sched_domains+0x1b/0x30
>  cpuset_hotplug_workfn+0x2ca/0xc90
>  ? balance_push+0x56/0xf0
>  ? _raw_spin_unlock+0x15/0x30
>  ? finish_task_switch+0x98/0x2f0
>  ? __switch_to+0x291/0x410
>  ? __schedule+0x65e/0x1310
>  process_one_work+0x1bc/0x3d0
>  worker_thread+0x4c/0x380
>  ? preempt_count_add+0x92/0xa0
>  ? rescuer_thread+0x310/0x310
>  kthread+0xe6/0x110
>  ? kthread_complete_and_exit+0x20/0x20
>  ret_from_fork+0x1f/0x30
>
> The rq clock has been updated before the set_rq_offline()
> function runs, so we don't need to call update_rq_clock() in
> unthrottle_offline_cfs_rqs().
> We only need to call rq_clock_start_loop_update() before the
> loop starts and rq_clock_stop_loop_update() after the loop
> to avoid this warning.
>
> Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>

> ---
>  kernel/sched/fair.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index af9604f4b135..9e961e0ec971 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6124,6 +6124,13 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>
>         lockdep_assert_rq_held(rq);
>
> +       /*
> +        * The rq clock has already been updated before the
> +        * set_rq_offline() runs, so we should skip updating
> +        * the rq clock again in unthrottle_cfs_rq().
> +        */
> +       rq_clock_start_loop_update(rq);
> +
>         rcu_read_lock();
>         list_for_each_entry_rcu(tg, &task_groups, list) {
>                 struct cfs_rq *cfs_rq = tg->cfs_rq[cpu_of(rq)];
> @@ -6146,6 +6153,8 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>                         unthrottle_cfs_rq(cfs_rq);
>         }
>         rcu_read_unlock();
> +
> +       rq_clock_stop_loop_update(rq);
>  }
>
>  #else /* CONFIG_CFS_BANDWIDTH */
> --
> 2.37.0
>
