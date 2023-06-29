Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302F3742B95
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 19:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjF2Rzw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 13:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230333AbjF2Rzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 13:55:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6221FCD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:55:47 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1b52875b8d9so11785ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 10:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688061347; x=1690653347;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sAxukAuOQ1tZakZNLu7tDSVD3deXjfjzmKWVjSrew8s=;
        b=lFp7yeuXjj0YVKWD6JpaktKMieuZyKS//ozRFTow51EqV5o7GgLo7i7PTmD4Gi6z09
         WivxMQTPDU8Cn5cAyVad6Yg0EwLBLqSEw6HpKlIxkcNDlEGrlF2j1US56F1zi/XGoy0s
         ODZ+hhTaASxv1rOoCAO7adp79u1g5NiGsEOaEWcM64lEvRbviksfS6aPGO6rkmFTBu8W
         1/Yaf2P/X8ypfGCnTAvEoYpsnewyC7XyzxRlfKposG8/5kb05/zlqkxpFmRGs1fSN147
         IC7UdfaL3FQ3hP4XqrhZTbl8gx8M11NatxkBqTRv/Yu7HeZyfqJwA7pGf6V+gL/pD4hu
         FglQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688061347; x=1690653347;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAxukAuOQ1tZakZNLu7tDSVD3deXjfjzmKWVjSrew8s=;
        b=Fkgv83m2iepJEM1RMtWBVq1Rib8Lc6SH4f7AJRRZLmGIFWRhXSP90K+/AsO4zgMrpF
         QVqc1WNQHpDeWD/6g+vvTNZbCdrfLTdJi/LujBeJlQdxLTMaZENvJsOeEJhkRwcg1YHK
         fUQCHwPvYPPb/mM1bW0fntoy/xwg+gjdY4qY/RGUYjv2i8/LPfmkuX1PoWiDzl8O6PGy
         gQ7PEDG0Gj0Dsn/GIdukRo5R1V++NK5JTJa3bL82ljwE8H9ujnedIUjwITJqJ39PA5UD
         nsOIP/N5gEHI1Wb4M2Mz5gmsIVgsCT00NV8WpYiHcGIH4SOMK7QEDuUcoq32AQTn7C7t
         TpUg==
X-Gm-Message-State: ABy/qLZMudfe9kouoMb6eCsZD0LluaMkzDFtZy8BOjVewDoFuzPV4ikw
        qBQgEtU+60vc25ayvOTgnaA2aQ==
X-Google-Smtp-Source: APBJJlGwCqf41r8MaEoMitlpULsfrPGS0zSSY8hZwKJUiypIEQsvFRlNVvTqskl3yDn4nSWraMBspg==
X-Received: by 2002:a17:902:b70b:b0:1b8:5857:ea9a with SMTP id d11-20020a170902b70b00b001b85857ea9amr176444pls.23.1688061347129;
        Thu, 29 Jun 2023 10:55:47 -0700 (PDT)
Received: from bsegall-glaptop.localhost ([2620:15c:2c0:5:c831:5665:2d2b:3ca7])
        by smtp.gmail.com with ESMTPSA id z7-20020a170903018700b001b02162c86bsm9389701plg.80.2023.06.29.10.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 10:55:46 -0700 (PDT)
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
        <xm26jzvn8ds7.fsf@google.com>
        <20230629005342.GB8069@lorien.usersys.redhat.com>
Date:   Thu, 29 Jun 2023 10:55:44 -0700
In-Reply-To: <20230629005342.GB8069@lorien.usersys.redhat.com> (Phil Auld's
        message of "Wed, 28 Jun 2023 20:53:42 -0400")
Message-ID: <xm26fs6a8867.fsf@google.com>
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

> On Wed, Jun 28, 2023 at 02:42:16PM -0700 Benjamin Segall wrote:
>> Phil Auld <pauld@redhat.com> writes:
>> 
>> > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
>> > can easily run well past their quotas before a remote tick does
>> > accounting.  This leads to long, multi-period stalls before such
>> > tasks can run again. Currentlyi, when presented with these conflicting
>> > requirements the scheduler is favoring nohz_full and letting the tick
>> > be stopped. However, nohz tick stopping is already best-effort, there
>> > are a number of conditions that can prevent it, whereas cfs runtime
>> > bandwidth is expected to be enforced.
>> >
>> > Make the scheduler favor bandwidth over stopping the tick by setting
>> > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
>> > runtime limit enabled.
>> >
>> > Add sched_feat HZ_BW (off by default) to control this behavior.
>> >
>> > Signed-off-by: Phil Auld <pauld@redhat.com>
>> > Cc: Ingo Molnar <mingo@redhat.com>
>> > Cc: Peter Zijlstra <peterz@infradead.org>
>> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> > Cc: Juri Lelli <juri.lelli@redhat.com>
>> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> > Cc: Valentin Schneider <vschneid@redhat.com>
>> > Cc: Ben Segall <bsegall@google.com>
>> > ---
>> >
>> > v2:  Ben pointed out that the bit could get cleared in the dequeue path
>> > if we migrate a newly enqueued task without preempting curr. Added a 
>> > check for that edge case to sched_can_stop_tick. Removed the call to 
>> > sched_can_stop_tick from sched_fair_update_stop_tick since it was 
>> > redundant.
>> >
>> >  kernel/sched/core.c     | 12 +++++++++++
>> >  kernel/sched/fair.c     | 45 +++++++++++++++++++++++++++++++++++++++++
>> >  kernel/sched/features.h |  2 ++
>> >  3 files changed, 59 insertions(+)
>> >
>> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> > index a68d1276bab0..646f60bfc7e7 100644
>> > --- a/kernel/sched/core.c
>> > +++ b/kernel/sched/core.c
>> > @@ -1194,6 +1194,8 @@ static void nohz_csd_func(void *info)
>> >  #endif /* CONFIG_NO_HZ_COMMON */
>> >  
>> >  #ifdef CONFIG_NO_HZ_FULL
>> > +extern bool sched_cfs_bandwidth_active(struct cfs_rq *cfs_rq);
>> > +
>> >  bool sched_can_stop_tick(struct rq *rq)
>> >  {
>> >  	int fifo_nr_running;
>> > @@ -1229,6 +1231,16 @@ bool sched_can_stop_tick(struct rq *rq)
>> >  	if (rq->nr_running > 1)
>> >  		return false;
>> >  
>> > +	/*
>> > +	 * If there is one task and it has CFS runtime bandwidth constraints
>> > +	 * and it's on the cpu now we don't want to stop the tick.
>> > +	 */
>> > +	if (sched_feat(HZ_BW) && rq->nr_running == 1 && rq->curr
>> > +	    && rq->curr->sched_class == &fair_sched_class && task_on_rq_queued(rq->curr)) {
>> > +		if (sched_cfs_bandwidth_active(task_cfs_rq(rq->curr)))
>> 
>> Actually, something I should have noticed earlier is that this should
>> probably be hierarchical, right? You need to check every ancestor
>> cfs_rq, not just the immediate parent. And at that point it probably
>> makes sense to have sched_cfs_bandwidth_active take a task_struct.
>> 
>
> Are you saying a child cfs_rq with a parent that has runtime_enabled could
> itself not have runtime_enabled?   I may be missing something but I don't
> see how that works.

Correct.

>
> account_cfs_rq_runtime() for example just looks at the immediate cfs_rq of
> curr and bails if it does not have runtime_enabled. How could that task get
> throttled if it exceeds some parent's limit?

account_cfs_rq_runtime() is called (primarily) from update_curr(), which
is called by enqueue_entity/dequeue_entity/entity_tick/etc, which are
called at each level of the hierarchy.

The worse cache behavior of doing a separate walk in sched_can_stop_tick
aka add/sub_nr_running could I guess be avoided by having some
runtime_enabled flag on the task struct or rq that is up to date for
rq->curr only. That would only be a little annoying to keep accurate,
and there's the dual arguments of "task_struct/rq is already too
cluttered"/"well they're already so cluttered a little more won't hurt".
