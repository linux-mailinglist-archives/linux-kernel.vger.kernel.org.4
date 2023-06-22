Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE3C73A9A3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 22:49:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjFVUt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 16:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjFVUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 16:49:56 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23C4A1FF0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:49:55 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1b52875b8d9so54845ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687466994; x=1690058994;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nChPRQmBEdAld5P1YTfYa7xMMLzbYPI8K4mtrRYjvDM=;
        b=dB+ig1Pcj7r64qksetWZdkdmdJz69lxdLEthpkskL1yyQ+x+do18djKd+AKKa8RMcx
         ZwGCDoYm3PzEJcVPRSf2CzsIGREsIbkugewY+IHFPvKKjFR1tbebC6P6L4ioW6+50gi+
         POdehvdALRnWD4V+26Haz69Xokuh/HN7x0LcCOJn5H+vABsHT4e7nMowaIbObrE/IMc9
         kQQNi+RHIsQsZ59+8AKC/BkzIllKxwMPVZxPDAwdJmmEPypL2fPSMHtKHgZe4eMukZQT
         IIop1/m+lWLkpjQLuHG+wDUMJgaPivXSbBA9kpK6d2sS8mkrNrheaA/pQnfbSB3jtMYZ
         rpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687466994; x=1690058994;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nChPRQmBEdAld5P1YTfYa7xMMLzbYPI8K4mtrRYjvDM=;
        b=Y3VJ3+63FCxkNilHudvWs6hq1LWVUK8FODzzDZio0apXEIteWUe3JMdeAEdEvKcK+y
         cGN0P/yzZOZMl79383Uicscp1Yn1WF7fRyfViIAyINNQ/aYKU5zGG8ilkF0CH8YwgtyE
         MRLqda0fycxPsRsVxpm+F50nLdgfPHyytGsbPMQdSWirUyKxazfZRs2FLAF7+VMbio7U
         45iCYtQj7f/MZbY1ZDHQhNvz5imcupacJV425imzs7Pms3+dMp84zOKn/Xg2fZo+EWQP
         e2x7gLwWKqWiemsThkcrv7CgbN1vJndJvZ00C7VZ47fvUyiPWLv9oAzmGRdVBtiZwP+y
         Ql+Q==
X-Gm-Message-State: AC+VfDyh8PlperWK0S8rf8GmeG5AeVPws/VqkRT/8sU0oYsshlcgpbfx
        NIkvpow3V3us2e6y6VWuV2woWQ==
X-Google-Smtp-Source: ACHHUZ6V+7NlQ6d7/ARX2UAVvIYtzs/uF88h/BcNAqlV3+MBWKZdvHwg/brmCyGXVbv1KMV9j1lsGQ==
X-Received: by 2002:a17:903:228d:b0:1b3:c4c0:3aba with SMTP id b13-20020a170903228d00b001b3c4c03abamr625426plh.0.1687466994394;
        Thu, 22 Jun 2023 13:49:54 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id jm16-20020a17090304d000b001b680aab2f0sm5548297plb.121.2023.06.22.13.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 13:49:53 -0700 (PDT)
From:   Benjamin Segall <bsegall@google.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH] Sched/fair: Block nohz tick_stop when cfs bandwidth in use
References: <20230622132751.2900081-1-pauld@redhat.com>
Date:   Thu, 22 Jun 2023 13:49:52 -0700
In-Reply-To: <20230622132751.2900081-1-pauld@redhat.com> (Phil Auld's message
        of "Thu, 22 Jun 2023 09:27:51 -0400")
Message-ID: <xm26zg4r8bnz.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Auld <pauld@redhat.com> writes:

> CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> can easily run well past their quotas before a remote tick does
> accounting.  This leads to long, multi-period stalls before such
> tasks can run again. Currentlyi, when presented with these conflicting
> requirements the scheduler is favoring nohz_full and letting the tick
> be stopped. However, nohz tick stopping is already best-effort, there
> are a number of conditions that can prevent it, whereas cfs runtime
> bandwidth is expected to be enforced.
>
> Make the scheduler favor bandwidth over stopping the tick by setting
> TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> runtime limit enabled.
>
> Add sched_feat HZ_BW (off by default) to control this behavior.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> ---
>  kernel/sched/fair.c     | 33 ++++++++++++++++++++++++++++++++-
>  kernel/sched/features.h |  2 ++
>  2 files changed, 34 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 373ff5f55884..880eadfac330 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6139,6 +6139,33 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>  	rcu_read_unlock();
>  }
>  
> +#ifdef CONFIG_NO_HZ_FULL
> +/* called from pick_next_task_fair() */
> +static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
> +{
> +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
> +	int cpu = cpu_of(rq);
> +
> +	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
> +		return;
> +
> +	if (!tick_nohz_full_cpu(cpu))
> +		return;
> +
> +	if (rq->nr_running != 1 || !sched_can_stop_tick(rq))
> +		return;
> +
> +	/*
> +	 *  We know there is only one task runnable and we've just picked it. The
> +	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
> +	 *  be otherwise able to stop the tick. Just need to check if we are using
> +	 *  bandwidth control.
> +	 */
> +	if (cfs_rq->runtime_enabled)
> +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
> +}
> +#endif

So from a CFS_BANDWIDTH pov runtime_enabled && nr_running == 1 seems
fine. But working around sched_can_stop_tick instead of with it seems
sketchy in general, and in an edge case like "migrate a task onto the
cpu and then off again" you'd get sched_update_tick_dependency resetting
the TICK_DEP_BIT and then not call PNT (ie a task wakes up onto this cpu
without preempting, and then another cpu goes idle and pulls it, causing
this cpu to go into nohz_full).
