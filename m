Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93464741B0F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 23:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbjF1VmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 17:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjF1VmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 17:42:20 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0FE29F
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:42:19 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1b52875b8d9so49105ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Jun 2023 14:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687988539; x=1690580539;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5XwqJfKqxmcA74LPjt0hT06/TEv8TqV0UeBjdA4KMdY=;
        b=hPmualm6Fs7YGVwq4JladKilDbshqoAbgwl53n3hIYQRKsbtXRYugCt5S8wnJGG0K+
         qaCtQldSvc72+v/AXOhVnDOT5/WVjBolceEZtqXdFy9b22hfcrEcwmfqZVyb2TwhDODE
         CBQgNEb2xupZIFnATxTgF7WUZ4lHtT5lkyHT+CJvOYkwVo0rsNFohmBG72ET6cCC5SP7
         rzK21M6dU4LLw2OKjctTP8ZZcnmAEyM692zFGE5Tc9AvKwIcYG82VmSrkltgVPd0f0ZS
         Masef3Jj8uBcmMt98K28ytvH7BSzI7K/4lahvYFz7+2C6MLKpA0xnbDAwe+fxKYpZ8GL
         dMgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687988539; x=1690580539;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XwqJfKqxmcA74LPjt0hT06/TEv8TqV0UeBjdA4KMdY=;
        b=YOYAed00ZyS1wg19K9Fpzqmr9lBv4NO5ooFYg0yKtfzOZSMsbqJtr2gEHamo7w4OZD
         JIDJiR0SZJFOhYuO417uTSDaqvmEd198LWdyuGV9LcOegqfvTI3dBEpMifNRoc1Tk8aj
         bbXI0TGEyJBPrqiQ+YufRBfWJNz7Y+L31HLL3fd1Dt3+JOBcddgLXuhExn/VSy1BFpNe
         QjskiNA9vo6xE/cfmzED3T+tlaKuIbmELufsuxjBuL8vv/YhzMsyrTcgLljryR5g8QaJ
         1SIWJorQ1jfWZspjru8kfmGDuo58RaMDgWq1pQqJsAZ0/8jsJridHWftOC2szLYS4ffK
         6BHg==
X-Gm-Message-State: AC+VfDzZUdGme4vnfxN2l7F2q5rF6x+gU0WMoB52LW+tJ5SiNURqjCzx
        6OXH4gQuHWrVe5Gv4KmvsOdbSg==
X-Google-Smtp-Source: ACHHUZ4XLl4HLiuCdUKffCaDo5bpgUxJ5O/B+bHD33FlOZKfb5RBnq+oUyP/LCvH62AjwL7IO/IxRw==
X-Received: by 2002:a17:902:ec91:b0:1b0:ceb:d67f with SMTP id x17-20020a170902ec9100b001b00cebd67fmr355958plg.8.1687988538958;
        Wed, 28 Jun 2023 14:42:18 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id ob11-20020a17090b390b00b00262dc783974sm6919359pjb.31.2023.06.28.14.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 14:42:18 -0700 (PDT)
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
Subject: Re: [PATCH v2] Sched/fair: Block nohz tick_stop when cfs bandwidth
 in use
References: <20230627191201.344110-1-pauld@redhat.com>
Date:   Wed, 28 Jun 2023 14:42:16 -0700
In-Reply-To: <20230627191201.344110-1-pauld@redhat.com> (Phil Auld's message
        of "Tue, 27 Jun 2023 15:12:01 -0400")
Message-ID: <xm26jzvn8ds7.fsf@google.com>
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
>
> v2:  Ben pointed out that the bit could get cleared in the dequeue path
> if we migrate a newly enqueued task without preempting curr. Added a 
> check for that edge case to sched_can_stop_tick. Removed the call to 
> sched_can_stop_tick from sched_fair_update_stop_tick since it was 
> redundant.
>
>  kernel/sched/core.c     | 12 +++++++++++
>  kernel/sched/fair.c     | 45 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  2 ++
>  3 files changed, 59 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index a68d1276bab0..646f60bfc7e7 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1194,6 +1194,8 @@ static void nohz_csd_func(void *info)
>  #endif /* CONFIG_NO_HZ_COMMON */
>  
>  #ifdef CONFIG_NO_HZ_FULL
> +extern bool sched_cfs_bandwidth_active(struct cfs_rq *cfs_rq);
> +
>  bool sched_can_stop_tick(struct rq *rq)
>  {
>  	int fifo_nr_running;
> @@ -1229,6 +1231,16 @@ bool sched_can_stop_tick(struct rq *rq)
>  	if (rq->nr_running > 1)
>  		return false;
>  
> +	/*
> +	 * If there is one task and it has CFS runtime bandwidth constraints
> +	 * and it's on the cpu now we don't want to stop the tick.
> +	 */
> +	if (sched_feat(HZ_BW) && rq->nr_running == 1 && rq->curr
> +	    && rq->curr->sched_class == &fair_sched_class && task_on_rq_queued(rq->curr)) {
> +		if (sched_cfs_bandwidth_active(task_cfs_rq(rq->curr)))

Actually, something I should have noticed earlier is that this should
probably be hierarchical, right? You need to check every ancestor
cfs_rq, not just the immediate parent. And at that point it probably
makes sense to have sched_cfs_bandwidth_active take a task_struct.
