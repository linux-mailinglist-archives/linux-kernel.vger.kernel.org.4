Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AF6F7379AF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:27:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjFUD1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbjFUD0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:26:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAF7199C;
        Tue, 20 Jun 2023 20:25:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B63D6145D;
        Wed, 21 Jun 2023 03:25:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E800C433C0;
        Wed, 21 Jun 2023 03:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687317918;
        bh=NGs11l/3B8YfeCe/z4oIs1N3Mm5E/col3XvNEFUUXn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A9yw8wR5gnNbP8vG+w1Ktt1f/FkaFUuyC2Seh1jsOkpYmmGwJFH8lgQ7I7G8Qn4Mn
         XL6xH5Ne75d8izn4HSWmrNlOdFBGAqIH8zIKdMjpmRlOLfs9vh08Dh3C5DUi+T1E+i
         9kJu80fipHNPqIXfbbKEsFU7Wr+N+PBVbOPGfNTXC/OwQcRZB7QzJkwi+2/+PM0ART
         TD28FaVAqStqrTgUUx1GliFn+0vcB5t4/eeEMqgUUeQWEXybygBgM+z8bGCXzVJrIG
         7X+KNCM8c+zqKavirD9ZL+uoc4o5XvWgy69IK+gcHDesZXLR8207zoHuqR3bcCQZw5
         3dRW4J/tJGbyg==
Date:   Wed, 21 Jun 2023 12:25:13 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, rafael@kernel.org,
        linux-pm@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org,
        mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, delyank@fb.com, qyousef@google.com
Subject: Re: [RESEND][PATCH v2 1/3] sched/tp: Add new tracepoint to track
 uclamp set from user-space
Message-Id: <20230621122513.2aa3bc0d29321197e3d38441@kernel.org>
In-Reply-To: <20230531182629.nztie5rwhjl53v3d@airbuntu>
References: <20230522145702.2419654-1-lukasz.luba@arm.com>
        <20230522145702.2419654-2-lukasz.luba@arm.com>
        <20230531182629.nztie5rwhjl53v3d@airbuntu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 May 2023 19:26:29 +0100
Qais Yousef <qyousef@layalina.io> wrote:

> On 05/22/23 15:57, Lukasz Luba wrote:
> > The user-space can set uclamp value for a given task. It impacts task
> > placement decisions made by the scheduler. This is very useful information
> > and helps to understand the system behavior or track improvements in
> > middleware and applications which start using uclamp mechanisms and report
> > better performance in tests.
> 
> Do you mind adding a generic one instead please? And explain why we can't just
> attach to the syscall via kprobes? I think you want to bypass the permission
> checks, so maybe a generic tracepoint after that might be justifiable?

Could you tell me more about this point? I would like to know what kind of
permission checks can be bypassed with tracepoints.

> Then anyone can use it to track how userspace has changed any attributes for
> a task, not just uclamp.

I guess Uclamp is not controlled by syscall but from kernel internal
sched_setattr/setscheduler() too. Anyway I agree that it can be more generic
tracepoint, something like trace_sched_set_scheduer(task, attr).

Thank you,

> 
> 
> Thanks
> 
> --
> Qais Yousef
> 
> > 
> > Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
> > ---
> >  include/trace/events/sched.h | 4 ++++
> >  kernel/sched/core.c          | 5 +++++
> >  2 files changed, 9 insertions(+)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index fbb99a61f714..dbfb30809f15 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
> >  	TP_PROTO(struct rq *rq, int change),
> >  	TP_ARGS(rq, change));
> >  
> > +DECLARE_TRACE(uclamp_update_tsk_tp,
> > +	TP_PROTO(struct task_struct *tsk, int uclamp_id,  unsigned int value),
> > +	TP_ARGS(tsk, uclamp_id, value));
> > +
> >  #endif /* _TRACE_SCHED_H */
> >  
> >  /* This part must be outside protection */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 944c3ae39861..7b9b800ebb6c 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -114,6 +114,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
> >  EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(uclamp_update_tsk_tp);
> >  
> >  DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> >  
> > @@ -1956,12 +1957,16 @@ static void __setscheduler_uclamp(struct task_struct *p,
> >  	    attr->sched_util_min != -1) {
> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MIN],
> >  			      attr->sched_util_min, true);
> > +		trace_uclamp_update_tsk_tp(p, UCLAMP_MIN,
> > +					   attr->sched_util_min);
> >  	}
> >  
> >  	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MAX &&
> >  	    attr->sched_util_max != -1) {
> >  		uclamp_se_set(&p->uclamp_req[UCLAMP_MAX],
> >  			      attr->sched_util_max, true);
> > +		trace_uclamp_update_tsk_tp(p, UCLAMP_MAX,
> > +					   attr->sched_util_max);
> >  	}
> >  }
> >  
> > -- 
> > 2.25.1
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
