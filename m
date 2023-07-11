Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6553B74EFF8
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231226AbjGKNOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 09:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKNOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 09:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1CC8E6C
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 06:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689081227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+iyLeoAPn93dXROnVnHivE6YyowgqiCgtRGSaKlCmDk=;
        b=jMH6DT+kcpnIZ6Qm/B+nfB6KpJhXcmzNIZ0+tdOVwYZdk+zTRqq2QKpnEj3uE2DqsuvslS
        /Tr6kjzxLX6S6/kq8xWWoRjbMzEZOgQ/Lxr4WsefyTZUfFcLUupOOhnin1zligknQNqE0y
        NpGHGWHAeOsoQA6bXwnzQ9yLb+YMbog=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-486-pQpbtKXKP_mcBC6Ug2ZnVg-1; Tue, 11 Jul 2023 09:13:44 -0400
X-MC-Unique: pQpbtKXKP_mcBC6Ug2ZnVg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D06BD1C2BD63;
        Tue, 11 Jul 2023 13:13:43 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.17.109])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 538AD492C13;
        Tue, 11 Jul 2023 13:13:43 +0000 (UTC)
Date:   Tue, 11 Jul 2023 09:13:41 -0400
From:   Phil Auld <pauld@redhat.com>
To:     Benjamin Segall <bsegall@google.com>
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
Subject: Re: [PATCH v5 1/2] sched, cgroup: Restore meaning to
 hierarchical_quota
Message-ID: <20230711131341.GB150804@lorien.usersys.redhat.com>
References: <20230707195748.2918490-1-pauld@redhat.com>
 <20230707195748.2918490-2-pauld@redhat.com>
 <xm26h6qbfhbo.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26h6qbfhbo.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 05:00:11PM -0700 Benjamin Segall wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > In cgroupv2 cfs_b->hierarchical_quota is set to -1 for all task
> > groups due to the previous fix simply taking the min.  It should
> > reflect a limit imposed at that level or by an ancestor. Even
> > though cgroupv2 does not require child quota to be less than or
> > equal to that of its ancestors the task group will still be
> > constrained by such a quota so this should be shown here. Cgroupv1
> > continues to set this correctly.
> >
> > In both cases, add initialization when a new task group is created
> > based on the current parent's value (or RUNTIME_INF in the case of
> > root_task_group). Otherwise, the field is wrong until a quota is
> > changed after creation and __cfs_schedulable() is called.
> 
> Reviewed-by: Ben Segall <bsegall@google.com>
>

Thanks, I'll hold on to this for the next version where I update the comment
if that's okay. I was just going to send that but based on your comment
on patch 2 may just do a v6 of the whole thing.


Cheers,
Phil

> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index a68d1276bab0..1b214e10c25d 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -11038,11 +11038,14 @@ static int tg_cfs_schedulable_down(struct task_group *tg, void *data)
> >  
> >  		/*
> >  		 * Ensure max(child_quota) <= parent_quota.  On cgroup2,
> > -		 * always take the min.  On cgroup1, only inherit when no
> > -		 * limit is set:
> > +		 * always take the non-RUNTIME_INF min.  On cgroup1, only
> > +		 * inherit when no limit is set:
> >  		 */
> >  		if (cgroup_subsys_on_dfl(cpu_cgrp_subsys)) {
> > -			quota = min(quota, parent_quota);
> > +			if (quota == RUNTIME_INF)
> > +				quota = parent_quota;
> > +			else if (parent_quota != RUNTIME_INF)
> > +				quota = min(quota, parent_quota);
> >  		} else {
> >  			if (quota == RUNTIME_INF)
> >  				quota = parent_quota;
> 
> I suppose you could also set RUNTIME_INF to be a positive value or
> better yet just compare at unsigned, but it's not like config needs to
> be fast, so no need to mess with that.
> 
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 373ff5f55884..92381f9ecf37 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6005,13 +6005,14 @@ static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
> >  	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
> >  }
> >  
> > -void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b)
> > +void init_cfs_bandwidth(struct cfs_bandwidth *cfs_b, struct cfs_bandwidth *parent)
> >  {
> >  	raw_spin_lock_init(&cfs_b->lock);
> >  	cfs_b->runtime = 0;
> >  	cfs_b->quota = RUNTIME_INF;
> >  	cfs_b->period = ns_to_ktime(default_cfs_period());
> >  	cfs_b->burst = 0;
> > +	cfs_b->hierarchical_quota = ((parent) ? parent->hierarchical_quota : RUNTIME_INF);
> 
> Minor style nit: don't need any of these parens here.
> 

-- 

