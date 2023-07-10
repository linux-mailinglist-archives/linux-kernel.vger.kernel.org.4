Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DE574E259
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 01:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjGJXzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 19:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbjGJXzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 19:55:03 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112AFA9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:55:02 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b9ed206018so43735ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 16:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689033301; x=1691625301;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vcjm6rctdmCVEw3eNu9IlJAGWa+qJbqrhCH/HfvBY3I=;
        b=jzE6HHKT4khAjtgHJeghNLeX83XHL3xu1fQTeM3FeihJENdhKBl05Z2xpbV58BJ1MB
         LlaQLDbWtEbfev+8PCPW63jYHiNMhmBTIwdEkAlDrZht/VFhuXtK08i/A6XCopFPMyc2
         8dCPvHK81PbKRXb5KlrxOulRZvIUPlq2uHQ0slt1hdDxG+tChRNv9g+ypTYT4MNZpKhx
         W0Z7sHF8L/+CGhqiDdcHZt9uq/UcToSHBJIEKLpDtbW4D19+JdXzCDzGax60sAjKLlsC
         yt8qO4cTJswjJpT9B+1bOqDBK/y6rJtfK6zEsmD0Uqd7iWY4N0POuA+t2x7umoK53+bB
         jodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689033301; x=1691625301;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vcjm6rctdmCVEw3eNu9IlJAGWa+qJbqrhCH/HfvBY3I=;
        b=flJ+37qlmpPVCgfU7IlUvPFQptqFNMHFedmVtis2KF3svpHXnziEfzFFNfZa/0XPlX
         /E1pJOxdnRNOjlqEvEnQJiQmXYCCLGUtvXkX0nC6nCTulKvyWTdOknMZi/FToR50dBiY
         5iaYe2bKKclWj7d2yEbRas4oTVnm7yna8xkrrFjDqvsO627MKuKhEgdj2fxsUlP2S+hf
         jemjtY7O6os6RafB9Bioxd4YEXaT7WkVQTg6Yhy3F9M0qD0+OV4D3W7sx27ZALl5PYMX
         7Zxck5/tMuYmwHUb93YCTXJdIsHTR5ks4dtPFF8wakJFeMOSXDpIydtC/JQJ8AvILLIT
         JX2g==
X-Gm-Message-State: ABy/qLbN9ilskhvysD7SZo3P6iAypdvQUhVOmVezpgR/xN2/Dh7Nfe0i
        w1XF1BXMiaxt3nwmR6s7vKzPdw==
X-Google-Smtp-Source: APBJJlFRZtb6Xi+TpHQHh4qJpvOR4DuHkV5Uj2ZeTzaG2RoSuO0pme8pA9LSQeJWBvuqYn846h/XYQ==
X-Received: by 2002:a17:902:e88f:b0:1b9:e9f3:b4d4 with SMTP id w15-20020a170902e88f00b001b9e9f3b4d4mr124218plg.4.1689033301006;
        Mon, 10 Jul 2023 16:55:01 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id a18-20020a1709027d9200b001ac7f583f72sm435076plm.209.2023.07.10.16.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 16:55:00 -0700 (PDT)
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
        Mel Gorman <mgorman@suse.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v5 2/2] Sched/fair: Block nohz tick_stop when cfs
 bandwidth in use
References: <20230707195748.2918490-1-pauld@redhat.com>
        <20230707195748.2918490-3-pauld@redhat.com>
Date:   Mon, 10 Jul 2023 16:54:58 -0700
In-Reply-To: <20230707195748.2918490-3-pauld@redhat.com> (Phil Auld's message
        of "Fri, 7 Jul 2023 15:57:48 -0400")
Message-ID: <xm26lefnfhkd.fsf@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
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
> tasks can run again. Currently, when presented with these conflicting
> requirements the scheduler is favoring nohz_full and letting the tick
> be stopped. However, nohz tick stopping is already best-effort, there
> are a number of conditions that can prevent it, whereas cfs runtime
> bandwidth is expected to be enforced.
>
> Make the scheduler favor bandwidth over stopping the tick by setting
> TICK_DEP_BIT_SCHED when the only running task is a cfs task with
> runtime limit enabled. We use cfs_b->hierarchical_quota to
> determine if the task requires the tick.
>
> Add check in pick_next_task_fair() as well since that is where
> we have a handle on the task that is actually going to be running.
>
> Add check in sched_can_stop_tick() to cover some edge cases such 
> as nr_running going from 2->1 and the 1 remains the running task.
>
> Add sched_feat HZ_BW (off by default) to control the tick_stop
> behavior.
>
> Signed-off-by: Phil Auld <pauld@redhat.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Vincent Guittot <vincent.guittot@linaro.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Ben Segall <bsegall@google.com>
> Cc: Frederic Weisbecker <frederic@kernel.org>
> ---
>  kernel/sched/core.c     | 12 ++++++++++
>  kernel/sched/fair.c     | 49 +++++++++++++++++++++++++++++++++++++++++
>  kernel/sched/features.h |  2 ++
>  kernel/sched/sched.h    |  1 +
>  4 files changed, 64 insertions(+)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 1b214e10c25d..4b8534abdf4f 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1229,6 +1229,18 @@ bool sched_can_stop_tick(struct rq *rq)
>  	if (rq->nr_running > 1)
>  		return false;
>  
> +	/*
> +	 * If there is one task and it has CFS runtime bandwidth constraints
> +	 * and it's on the cpu now we don't want to stop the tick.
> +	 * This check prevents clearing the bit if a newly enqueued task here is
> +	 * dequeued by migrating while the constrained task continues to run.
> +	 * E.g. going from 2->1 without going through pick_next_task().
> +	 */
> +	if (sched_feat(HZ_BW) && rq->nr_running == 1 && task_on_rq_queued(rq->curr)) {
> +		if (cfs_task_bw_constrained(rq->curr))
> +			return false;
> +	}
> +

I think we still need the fair_sched_class check with the bit being on
cfs_rq/tg rather than task.

