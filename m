Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D08D76BBAB8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjCORUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbjCORTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:19:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0CD9EDD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678900742;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UVXZ9RkFbzbXN9OpSinhyf/3z8cujBPcQ64MTebMFxM=;
        b=JLI2cQTLNpBxlCDmucAlw8llaSOqsgnU2bibuBEc3Op/Euk9ZfW8wDTQf2QobqVasoxZdU
        UKQjm8mPimUOo5W8TZp5UTkZnOfuwVaMTNeSmD2jjUiA32GWVrRMxb7mHeFc6ghuwBIjEv
        SUBfuLKTDxT11kGi5sq6Im1yMgRqY0U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-H2WnO2R3Pmi5bECQTq19Hg-1; Wed, 15 Mar 2023 13:19:01 -0400
X-MC-Unique: H2WnO2R3Pmi5bECQTq19Hg-1
Received: by mail-wm1-f72.google.com with SMTP id n38-20020a05600c3ba600b003ed29a0b729so3276438wms.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:19:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678900740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UVXZ9RkFbzbXN9OpSinhyf/3z8cujBPcQ64MTebMFxM=;
        b=XW4aKcpRPOHXkoCQ8OBA0nZ7FWtj8AF+q73/4tqRz+W4WLyhyYlfrEjNS8TPiViieU
         qiK1XY3rZUBxZ9lKSI4WfKAHwEHMHdrYfRw6dGhy7ZDaQ2C7sv4RQ5AirfwEm6BdgB5f
         0ca7abVcipNWcWoEKixdbmmAbZfbCeTPL86k4Fahfo7phpvKDBSihrGdM6zN94mNzjjT
         3d7pq1Bj5lHbhnBgT/XtAZ5+VEbcRnRqtpRArfZ573GGEFmsCO+GAaE40jCwtuETQQCl
         brt87ABAIKHbRjeFHSQi+XR3e+VcUHmiq2bSZwzLuEAz2RaXZLpM74pqfgP1UtgeLL3L
         5s9w==
X-Gm-Message-State: AO0yUKX3/NuZ3H63rtsJi8I5t84OOY3si4XhTinEIA9RLgIGeWQ77L9o
        HcXCmIKO+D95dWYHJVKzHDTNwVAt+ZbdBlUPldwu77zg9Jty7R/JJLQ5OjVqXWm14CCOoUtWR8B
        2oHK9ai6QsKbG1ryeAkphJNfc
X-Received: by 2002:a05:600c:1e89:b0:3eb:20f6:2d5c with SMTP id be9-20020a05600c1e8900b003eb20f62d5cmr18733384wmb.35.1678900740296;
        Wed, 15 Mar 2023 10:19:00 -0700 (PDT)
X-Google-Smtp-Source: AK7set9rU0BE2Il2qxiWH5H45lMgBinIyzEIHiGQJtAphOkImi8ZXXq6MWZY/GAQ9eAI2Jck1s/CDg==
X-Received: by 2002:a05:600c:1e89:b0:3eb:20f6:2d5c with SMTP id be9-20020a05600c1e8900b003eb20f62d5cmr18733362wmb.35.1678900740003;
        Wed, 15 Mar 2023 10:19:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c6:4a21:6f01:ac73:9611:643a:5397])
        by smtp.gmail.com with ESMTPSA id g17-20020a05600c311100b003e733a973d2sm2492783wmo.39.2023.03.15.10.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Mar 2023 10:18:59 -0700 (PDT)
Date:   Wed, 15 Mar 2023 17:18:57 +0000
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Hao Luo <haoluo@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        claudio@evidence.eu.com, tommaso.cucinotta@santannapisa.it,
        bristot@redhat.com, mathieu.poirier@linaro.org,
        cgroups@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Wei Wang <wvw@google.com>, Rick Yiu <rickyiu@google.com>,
        Quentin Perret <qperret@google.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RFC PATCH 2/3] sched/cpuset: Keep track of SCHED_DEADLINE tasks
 in cpusets
Message-ID: <ZBH+AaJV36y/HNXk@localhost.localdomain>
References: <20230315121812.206079-1-juri.lelli@redhat.com>
 <20230315121812.206079-3-juri.lelli@redhat.com>
 <20230315144927.624cbwc3yep3fwor@airbuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230315144927.624cbwc3yep3fwor@airbuntu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/03/23 14:49, Qais Yousef wrote:
> On 03/15/23 12:18, Juri Lelli wrote:

...

> > +void inc_dl_tasks_cs(struct task_struct *p)
> > +{
> > +	struct cpuset *cs = task_cs(p);
> 
> nit:
> 
> I *think* task_cs() assumes rcu_read_lock() is held, right?
> 
> Would it make sense to WARN_ON(!rcu_read_lock_held()) to at least
> annotate the deps?

Think we have that check in task_css_set_check()?

> Or maybe task_cs() should do that..
> 
> > +
> > +	cs->nr_deadline_tasks++;
> > +}
> > +
> > +void dec_dl_tasks_cs(struct task_struct *p)
> > +{
> > +	struct cpuset *cs = task_cs(p);
> 
> nit: ditto
> 
> > +
> > +	cs->nr_deadline_tasks--;
> > +}
> > +

...

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 5902cbb5e751..d586a8440348 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -7683,6 +7683,16 @@ static int __sched_setscheduler(struct task_struct *p,
> >  		goto unlock;
> >  	}
> >  
> > +	/*
> > +	 * In case a task is setscheduled to SCHED_DEADLINE, or if a task is
> > +	 * moved to a different sched policy, we need to keep track of that on
> > +	 * its cpuset (for correct bandwidth tracking).
> > +	 */
> > +	if (dl_policy(policy) && !dl_task(p))
> > +		inc_dl_tasks_cs(p);
> > +	else if (dl_task(p) && !dl_policy(policy))
> > +		dec_dl_tasks_cs(p);
> > +
> 
> Would it be better to use switched_to_dl()/switched_from_dl() instead to
> inc/dec_dl_tasks_cs()?

Ah, makes sense. I'll play with this.

Thanks,
Juri

