Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A56D9698
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 14:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233619AbjDFMAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 08:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229812AbjDFL7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 07:59:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25701BDD3
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 04:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680782146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RpeUiKZblKpwqVQ8uVPclvtDcnSoPiA7m54Y8l9FAzo=;
        b=JQIRqn1munasH+gQyWIqNeb0FDaCQY3qBRv0ry0LddmkHCeyTY2qTZMx1CYVXGIB7h4Nr2
        HW2Sgfmg0dTHt/csSfaFTTFOSq5nR8BQZ85P3r/tWIL7sF//JSGVc0FFJiw6Fye2H2xey+
        Me1wmawzIG1kZ9P61jO9DLdlwcfJeqg=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-3-6wHZyEHhO-qbhps48e7d4g-1; Thu, 06 Apr 2023 07:55:45 -0400
X-MC-Unique: 6wHZyEHhO-qbhps48e7d4g-1
Received: by mail-qv1-f70.google.com with SMTP id m3-20020a0cbf03000000b005de7233ca79so15470389qvi.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 04:55:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680782145; x=1683374145;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RpeUiKZblKpwqVQ8uVPclvtDcnSoPiA7m54Y8l9FAzo=;
        b=RAtvje2wciO4AV4tSu+PwPpWSuUJ9X6LV9FZzFyOTMO2TiuG+hB1+PlLoxB6vGzEVR
         Q0h5Mew/wjuBBLqoGfdO2LUWqIS3ZxFySM/8uwAL9dJIht9k8Y+q6Wf02Ar+ip8+m1eQ
         0pkHBOYQEDa9kEj+Hw9hx0LsuKF2/ia1nDhF3OiIyHfUxADrLldvNkDUsKNwSOhH7vm2
         7w29dcFg2DJ3D4sRF0LJ8G1edHiFytEvCFS3m4kRxg6wlf7hCd2AGSjzJYHw/or5kfGt
         DfxzAf0faRRKwFmJwFtOEbfvhp38qf4jFU8CsZtShqkzcA5MX5XkpmjPCrqXJz/Ls7ZZ
         hufQ==
X-Gm-Message-State: AAQBX9d9nG9ZuOKTIfr/qgGF0RBojDq05ETIzuatCYzWIgwCInDzJrkI
        P0K/YWPFu28Nw1Y6pbjL3cia9ZHMgrveOblqLVZ3rj741NHpIOLTbV65XJnWAhRq2aYrGaaSegw
        OjyT2we2Q5t40zFqtCuPSLbd8
X-Received: by 2002:a05:6214:401c:b0:5a3:725e:425c with SMTP id kd28-20020a056214401c00b005a3725e425cmr4300041qvb.2.1680782144725;
        Thu, 06 Apr 2023 04:55:44 -0700 (PDT)
X-Google-Smtp-Source: AKy350aYnc+zC5zXbPa+D3f/9FFlnPDUlIGuSukS8kT7YoHRZTb4/DYT/jmywMJutc9USDjZi6FpYA==
X-Received: by 2002:a05:6214:401c:b0:5a3:725e:425c with SMTP id kd28-20020a056214401c00b005a3725e425cmr4300018qvb.2.1680782144443;
        Thu, 06 Apr 2023 04:55:44 -0700 (PDT)
Received: from vschneid.remote.csb ([154.57.232.159])
        by smtp.gmail.com with ESMTPSA id u12-20020a0ced2c000000b005dd8b934572sm466092qvq.10.2023.04.06.04.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Apr 2023 04:55:44 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Schspa Shi <schspa@gmail.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, zhaohui.shi@horizon.ai,
        Schspa Shi <schspa@gmail.com>
Subject: Re: [PATCH v8 2/2] sched/rt: Trying to push current task when
 target disable migrating
In-Reply-To: <20220828170303.171400-2-schspa@gmail.com>
References: <20220828170303.171400-1-schspa@gmail.com>
 <20220828170303.171400-2-schspa@gmail.com>
Date:   Thu, 06 Apr 2023 12:55:41 +0100
Message-ID: <xhsmhh6tt9qde.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/08/22 01:03, Schspa Shi wrote:
> When the task to push disable migration, retry to push the current
> running task on this CPU away, instead doing nothing for this migrate
> disabled task.
>
> CC: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>  kernel/sched/core.c     | 13 ++++++++++++-
>  kernel/sched/deadline.c |  9 +++++++++
>  kernel/sched/rt.c       |  8 ++++++++
>  3 files changed, 29 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ee28253c9ac0c..056b336c29e70 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -2503,8 +2503,19 @@ int push_cpu_stop(void *arg)
>       if (p->sched_class->find_lock_rq)
>               lowest_rq = p->sched_class->find_lock_rq(p, rq);
>
> -	if (!lowest_rq)
> +	if (!lowest_rq) {
> +		/*
> +		 * The find_lock_rq function above could have released the rq
> +		 * lock and allow p to schedule and be preempted again, and
> +		 * that lowest_rq could be NULL because p now has the
> +		 * migrate_disable flag set and not because it could not find
> +		 * the lowest rq. So we must check task migration flag again.
> +		 */
> +		if (unlikely(is_migration_disabled(p)))
> +			p->migration_flags |= MDF_PUSH;
> +

Given p has to be on this rq initially, this implies p being migrated away
to become migration_disabled() (it *can't* be scheduled while the stopper
is running), in which case it's not on this rq anymore, so do we care?

>               goto out_unlock;
> +	}
>
>       // XXX validate p is still the highest prio task
>       if (task_rq(p) == rq) {
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index e7eea6cde5cb9..c8055b978dbc3 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -2340,6 +2340,15 @@ static int push_dl_task(struct rq *rq)
>                */
>               task = pick_next_pushable_dl_task(rq);
>               if (task == next_task) {
> +			/*
> +			 * If next task has now disabled migrating, see if we
> +			 * can do resched_curr().
> +			 */
> +			if (unlikely(is_migration_disabled(task))) {
> +				put_task_struct(next_task);
> +				goto retry;
> +			}
> +
>                       /*
>                        * The task is still there. We don't try
>                        * again, some other CPU will pull it when ready.
> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> index 57e8cd5c9c267..381ec05eb2701 100644
> --- a/kernel/sched/rt.c
> +++ b/kernel/sched/rt.c
> @@ -2139,6 +2139,14 @@ static int push_rt_task(struct rq *rq, bool pull)
>                */
>               task = pick_next_pushable_task(rq);
>               if (task == next_task) {
> +			/*
> +			 * If next task has now disabled migrating, see if we
> +			 * can push the current task.
> +			 */
> +			if (unlikely(is_migration_disabled(task))) {
> +				put_task_struct(next_task);
> +				goto retry;
> +			}

Similarly here, if the task has been through a switch-in / switch-out
cycle, then at least for RT we'd have

  set_next_task_rt()
  `\
    rt_queue_push_tasks()

which will take care of it.

If the task is preempted by e.g. a DL task, then the retry would fail on

  (next_task->prio < rq->curr->prio)

and I'm thinking the same logic applies to the deadline.c. IOW, it looks
like we're already doing the right thing here when the task gets scheduled
out, so I don't think we need any of this.

>                       /*
>                        * The task hasn't migrated, and is still the next
>                        * eligible task, but we failed to find a run-queue
> --
> 2.37.2

