Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E228B69DFFB
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 13:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234747AbjBUMKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 07:10:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234681AbjBUMKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 07:10:01 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF87328D2B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:09:28 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l2-20020a05600c1d0200b003e1f6dff952so3336315wms.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 04:09:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=layalina-io.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdoBiwNBdOMigLxE6IMYShFfvfTDihYPTm+CSnTmhrA=;
        b=nnkdSamjgplK5DeYCgdswu4CTAsVnpe2GDB9c0+dcOZrbJfqyo4pcjNqii9eNcLdkN
         YaaqLO/7/leCCLMPrh8A7TgOTOuPYg7Kcn6qRuEgw7r0jj7KLsq8Xd/DVx8wdbTKCZGh
         cWFdoCrwUBo4dC9EgRTUtRz5w9J5L9YPfCG35Kyl4lH0UQPNYoGDxehrbjtUN6Mum+iO
         uhSVvL1GXaj/Ce7w+wZiqtc1WrFyIGS6MN+6cKaQltCW1xsWSIZ9ImiIYXrCASOR1ehv
         hyVtj5lo+1Ob4lVkPS5QbIor4ORmMwWKgEPApmtqRUAC3NHP4IYNuAd7p0UIeLtm6IBf
         OxQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WdoBiwNBdOMigLxE6IMYShFfvfTDihYPTm+CSnTmhrA=;
        b=HjBQL2VGv2aUgjF/ADqUm4EPUFzcwbQpMiTC/DZrskJyZALfO1vsRvfqG9pB46FdDx
         rruIplYzu8My4J8xDJEPx2tBdK9xWrLjE+fQvIe/lEe8msD0YKT0O4XcjASDto2HbT5T
         PA+wpKDqlbHl3qI1hZWq9vyEDXQsiNmRm0TnLVoTVPBMgMqjwbA6igsin2CrKEb4wAhB
         LZFBW5mOCFqBx2tMpN2Uc89Cm7CVwoIj1xeJ3HIAVSzaQ6GJ+r8qBSqZUlf8bAZq2F7J
         l5bPtv2tLuiEE7F2UKZgSkN2zss3+dPeKW76IZ7pPmJ087csjhuhJ3TkKHnVaVygmZY2
         b7NA==
X-Gm-Message-State: AO0yUKWDmaOLs8PlcSoK4A9pIc4C0GgOKCm8KujdMPIsFKqxOweAiSu5
        HtWTkzH5WHaJVYRINsgRU8Yxlw==
X-Google-Smtp-Source: AK7set9fWrgZXGsJ0yAnT4W9bcKmUO6rKxZFaNPo5oS8Hhmnt+j2BCCoF4VguVWx9YveaRWK8D0QPg==
X-Received: by 2002:a05:600c:a294:b0:3d9:fb59:c16b with SMTP id hu20-20020a05600ca29400b003d9fb59c16bmr3231005wmb.36.1676981313523;
        Tue, 21 Feb 2023 04:08:33 -0800 (PST)
Received: from airbuntu ([104.132.45.105])
        by smtp.gmail.com with ESMTPSA id az17-20020a05600c601100b003dd1bd0b915sm14790448wmb.22.2023.02.21.04.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 04:08:33 -0800 (PST)
Date:   Tue, 21 Feb 2023 12:08:32 +0000
From:   Qais Yousef <qyousef@layalina.io>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Xuewen Yan <xuewen.yan94@gmail.com>,
        Hank <han.lin@mediatek.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 3/3] sched/tp: Add new tracepoint to track compute
 energy computation
Message-ID: <20230221120832.x642tqohxv5nascr@airbuntu>
References: <20230205224318.2035646-1-qyousef@layalina.io>
 <20230205224318.2035646-4-qyousef@layalina.io>
 <d99b1097-1d77-1547-30bf-860756d4952f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d99b1097-1d77-1547-30bf-860756d4952f@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/23 11:22, Lukasz Luba wrote:
> Hi Qais,
> 
> On 2/5/23 22:43, Qais Yousef wrote:
> > It was useful to track feec() placement decision and debug the spare
> > capacity and optimization issues vs uclamp_max.
> > 
> > Signed-off-by: Qais Yousef <qyousef@layalina.io>
> > ---
> >   include/trace/events/sched.h | 4 ++++
> >   kernel/sched/core.c          | 1 +
> >   kernel/sched/fair.c          | 7 ++++++-
> >   3 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> > index fbb99a61f714..20cc884f72ff 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -735,6 +735,10 @@ DECLARE_TRACE(sched_update_nr_running_tp,
> >   	TP_PROTO(struct rq *rq, int change),
> >   	TP_ARGS(rq, change));
> > +DECLARE_TRACE(sched_compute_energy_tp,
> > +	TP_PROTO(struct task_struct *p, int dst_cpu, unsigned long energy),
> > +	TP_ARGS(p, dst_cpu, energy));
> > +
> >   #endif /* _TRACE_SCHED_H */
> >   /* This part must be outside protection */
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 4580fe3e1d0c..5f6dde9b892b 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -110,6 +110,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_overutilized_tp);
> >   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_cfs_tp);
> >   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_util_est_se_tp);
> >   EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
> > +EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
> >   DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index a8c3d92ff3f6..801e903c4307 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -7295,11 +7295,16 @@ compute_energy(struct energy_env *eenv, struct perf_domain *pd,
> >   {
> >   	unsigned long max_util = eenv_pd_max_util(eenv, pd_cpus, p, dst_cpu);
> >   	unsigned long busy_time = eenv->pd_busy_time;
> > +	unsigned long energy;
> >   	if (dst_cpu >= 0)
> >   		busy_time = min(eenv->pd_cap, busy_time + eenv->task_busy_time);
> > -	return em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> > +	energy = em_cpu_energy(pd->em_pd, max_util, busy_time, eenv->cpu_cap);
> > +
> > +	trace_sched_compute_energy_tp(p, dst_cpu, energy);
> 
> Could we also dump the max_util and busy_time?

We certainly can :)


Cheers

--
Qais Yousef

> 
> > +
> > +	return energy;
> >   }
> >   /*
> 
> 
> IMO this one is really helpful. I hope it won't be an issue if we can
> have it in this code path.
> 
> Regards,
> Lukasz
