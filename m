Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7C773BEA6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 20:59:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbjFWS7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 14:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjFWS7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 14:59:16 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4292C1FDF
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:59:12 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1b52875b8d9so25955ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jun 2023 11:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687546752; x=1690138752;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cbfaq/9T/wMpjvtED8ieY9JJoTnQ+cGmskLTct3IdWU=;
        b=qgkIlOYvSJJvafVoLwl1hQkJDDG3ATGs46baEGWBueZgwwLrSBRDV0NCKtrNc+k0aq
         H0Sn5RFeK52Ad+05UJOpKzjiR2yv7v1oiECEsehycHt0aRBst0/nCUeOLXxOmvLj40tq
         5Krv1IUyyV7grK7TGKtch0DsYR6Lk4biVA+d7F+SkGdN4MNOwbOuchFDHWkpIwHWkHy2
         8F3w+ut6A/eyhe15SACU2IGAAjSEes60M43sYjVqS5Bu4yHasl0nQ3Uwvw9HhgE0BOoZ
         k2DgMdAp3PmsNuOSabKDI03wiS6oXj9LC+LX9Q72gnt2drFWq/t2aI2I4Eo1Fwn6pxas
         DHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687546752; x=1690138752;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cbfaq/9T/wMpjvtED8ieY9JJoTnQ+cGmskLTct3IdWU=;
        b=VrGL/t0l4OvQh/WddhNgNuRvBjfjQnUsbKopY8SCbCcCFNDSESgru/82t0Yz3qnHjV
         CBjMm5ZYTcLUAbLgRw/ZRpRuJwOjMsRp0t+09JEYJX09I43dWrAoE4jN5a9szb8jKypY
         IVyiRV2REppK+cPhMQltfgcbF3UOFLo5P8UYt7TGLybBIArUFB9Oconbl7X+p9E2HqQC
         Xazyx9MzcyaisLtDdHv9wcoRbfLaShzjPol6a7OooLzkjJD+5QCJhTSTF9p0v/h8uAon
         d7D48vBT6ARuE6HHUYTVjQr3SrMhWa2vMwtdDvvuzmqqoYAonD2JRzjyEe5So57NiJWd
         euTw==
X-Gm-Message-State: AC+VfDzTiFplb4r/kSAGbGaoMVZEFcDgnqKy/9cG10HgXnVSP3nL8jLg
        sBN9eoXm7zeuyaa64opjNSp7wQ==
X-Google-Smtp-Source: ACHHUZ4x3WhT8bCgiMCTdXjtT4W9bzjUc59MQ+ccVWCqltvcctLLBF3uCNgOEpWt/lWUBAS5rt9d8A==
X-Received: by 2002:a17:902:c44a:b0:1a9:bb1d:64e with SMTP id m10-20020a170902c44a00b001a9bb1d064emr1607889plm.15.1687546751554;
        Fri, 23 Jun 2023 11:59:11 -0700 (PDT)
Received: from bsegall-glaptop.localhost (c-73-158-249-138.hsd1.ca.comcast.net. [73.158.249.138])
        by smtp.gmail.com with ESMTPSA id s16-20020a62e710000000b0064ff855751fsm6355934pfh.4.2023.06.23.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 11:59:11 -0700 (PDT)
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
        <xm26zg4r8bnz.fsf@google.com>
        <20230622213730.GE727646@lorien.usersys.redhat.com>
        <20230623130859.GA766130@lorien.usersys.redhat.com>
Date:   Fri, 23 Jun 2023 11:59:09 -0700
In-Reply-To: <20230623130859.GA766130@lorien.usersys.redhat.com> (Phil Auld's
        message of "Fri, 23 Jun 2023 09:08:59 -0400")
Message-ID: <xm26r0q280oy.fsf@google.com>
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

> On Thu, Jun 22, 2023 at 05:37:30PM -0400 Phil Auld wrote:
>> On Thu, Jun 22, 2023 at 01:49:52PM -0700 Benjamin Segall wrote:
>> > Phil Auld <pauld@redhat.com> writes:
>> > 
>> > > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
>> > > can easily run well past their quotas before a remote tick does
>> > > accounting.  This leads to long, multi-period stalls before such
>> > > tasks can run again. Currentlyi, when presented with these conflicting
>> > > requirements the scheduler is favoring nohz_full and letting the tick
>> > > be stopped. However, nohz tick stopping is already best-effort, there
>> > > are a number of conditions that can prevent it, whereas cfs runtime
>> > > bandwidth is expected to be enforced.
>> > >
>> > > Make the scheduler favor bandwidth over stopping the tick by setting
>> > > TICK_DEP_BIT_SCHED when the only running task is a cfs task with
>> > > runtime limit enabled.
>> > >
>> > > Add sched_feat HZ_BW (off by default) to control this behavior.
>> > >
>> > > Signed-off-by: Phil Auld <pauld@redhat.com>
>> > > Cc: Ingo Molnar <mingo@redhat.com>
>> > > Cc: Peter Zijlstra <peterz@infradead.org>
>> > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
>> > > Cc: Juri Lelli <juri.lelli@redhat.com>
>> > > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
>> > > Cc: Valentin Schneider <vschneid@redhat.com>
>> > > Cc: Ben Segall <bsegall@google.com>
>> > > ---
>> > >  kernel/sched/fair.c     | 33 ++++++++++++++++++++++++++++++++-
>> > >  kernel/sched/features.h |  2 ++
>> > >  2 files changed, 34 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> > > index 373ff5f55884..880eadfac330 100644
>> > > --- a/kernel/sched/fair.c
>> > > +++ b/kernel/sched/fair.c
>> > > @@ -6139,6 +6139,33 @@ static void __maybe_unused unthrottle_offline_cfs_rqs(struct rq *rq)
>> > >  	rcu_read_unlock();
>> > >  }
>> > >  
>> > > +#ifdef CONFIG_NO_HZ_FULL
>> > > +/* called from pick_next_task_fair() */
>> > > +static void sched_fair_update_stop_tick(struct rq *rq, struct task_struct *p)
>> > > +{
>> > > +	struct cfs_rq *cfs_rq = task_cfs_rq(p);
>> > > +	int cpu = cpu_of(rq);
>> > > +
>> > > +	if (!sched_feat(HZ_BW) || !cfs_bandwidth_used())
>> > > +		return;
>> > > +
>> > > +	if (!tick_nohz_full_cpu(cpu))
>> > > +		return;
>> > > +
>> > > +	if (rq->nr_running != 1 || !sched_can_stop_tick(rq))
>> > > +		return;
>> > > +
>> > > +	/*
>> > > +	 *  We know there is only one task runnable and we've just picked it. The
>> > > +	 *  normal enqueue path will have cleared TICK_DEP_BIT_SCHED if we will
>> > > +	 *  be otherwise able to stop the tick. Just need to check if we are using
>> > > +	 *  bandwidth control.
>> > > +	 */
>> > > +	if (cfs_rq->runtime_enabled)
>> > > +		tick_nohz_dep_set_cpu(cpu, TICK_DEP_BIT_SCHED);
>> > > +}
>> > > +#endif
>> > 
>> > So from a CFS_BANDWIDTH pov runtime_enabled && nr_running == 1 seems
>> > fine. But working around sched_can_stop_tick instead of with it seems
>> > sketchy in general, and in an edge case like "migrate a task onto the
>> > cpu and then off again" you'd get sched_update_tick_dependency resetting
>> > the TICK_DEP_BIT and then not call PNT (ie a task wakes up onto this cpu
>> > without preempting, and then another cpu goes idle and pulls it, causing
>> > this cpu to go into nohz_full).
>> > 
>> 
>> The information to make these tests is not available in sched_can_stop_tick.
>> I did start there. When that is called, and we are likely to go nohz_full,
>> curr is null so it's hard to find the right cfs_rq to make that
>> runtime_enabled test against.  We could, maybe, plumb the task being enqueued
>> in but it would not be valid for the dequeue path and would be a bit messy.
>>
>
> Sorry, mispoke... rq->curr == rq-idle not null. But still we don't have
> access to the task and its cfs_rq which will have runtime_enabled set.
>

That is unfortunate. I suppose then you'd wind up needing both this
extra bit in PNT to handle the switch into nr_running == 1 territory,
and a "HZ_BW && nr_running == 1 && curr is fair && curr->on_rq &&
curr->cfs_rq->runtime_enabled" check in sched_can_stop_tick to catch
edge cases. (I think that would be sufficient, if an annoyingly long set
of conditionals)
