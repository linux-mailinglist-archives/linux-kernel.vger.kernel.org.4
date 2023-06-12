Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6812D72D372
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbjFLVjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235018AbjFLVjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:39:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC5A4FC
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 14:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686605934;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t0zCtlzFDjE8YT7V2dopoCb+H4me8jQ8TbwBL710Xe0=;
        b=JaoOpnSRE1Jy46nJVODnIt9PsFbOYlk+ueKwAD/QxViFIQlDQJi2Nl7Apm1EkceoObUZ2i
        VedibveHW0fP32qHorL0NkpiZra1B9DBefSqDsL9s7Pk5mWyF5RImpe35dhJ37y+q6gFvU
        5DE9cqus0OtysCrODsNKzIIqae7Px6M=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-Id2VcDtKMLuVLYx4ecUDIQ-1; Mon, 12 Jun 2023 17:38:49 -0400
X-MC-Unique: Id2VcDtKMLuVLYx4ecUDIQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 363203C0C899;
        Mon, 12 Jun 2023 21:38:49 +0000 (UTC)
Received: from lorien.usersys.redhat.com (unknown [10.22.16.166])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A328A492CA6;
        Mon, 12 Jun 2023 21:38:48 +0000 (UTC)
Date:   Mon, 12 Jun 2023 17:38:46 -0400
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
        Mel Gorman <mgorman@suse.de>
Subject: Re: [PATCH v2] sched/nohz: Add HRTICK_BW for using cfs bandwidth
 with nohz_full
Message-ID: <20230612213846.GA524810@lorien.usersys.redhat.com>
References: <20230608125228.56097-1-pauld@redhat.com>
 <xm26fs6w9zt4.fsf@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xm26fs6w9zt4.fsf@google.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 01:43:35PM -0700 Benjamin Segall wrote:
> Phil Auld <pauld@redhat.com> writes:
> 
> > CFS bandwidth limits and NOHZ full don't play well together.  Tasks
> > can easily run well past their quotas before a remote tick does
> > accounting.  This leads to long, multi-period stalls before such
> > tasks can run again.  Use the hrtick mechanism to set a sched
> > tick to fire at remaining_runtime in the future if we are on
> > a nohz full cpu, if the task has quota and if we are likely to
> > disable the tick (nr_running == 1).  This allows for bandwidth
> > accounting before tasks go too far over quota.
> >
> > A number of container workloads use a dynamic number of real
> > nohz tasks but also have other work that is limited which ends
> > up running on the "spare" nohz cpus.  This is an artifact of
> > having to specify nohz_full cpus at boot. Adding this hrtick
> > resolves the issue of long stalls on these tasks. Currently
> > the scheduler, when faced with these conflicting requirements
> > choosed to favor nohz_full even though that is already best
> > effort. Here we make it favor respecting the bandwidth
> > limitations which are not supposed to be best effort.
> >
> > Add the sched_feat HRTICK_BW off by default to allow users to
> > enable this only when needed.
> >
> > Signed-off-by: Phil Auld <pauld@redhat.com>
> > Suggested-by: Juri Lelli <jlelli@redhat.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > Cc: Juri Lelli <juri.lelli@redhat.com>
> > Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > Cc: Valentin Schneider <vschneid@redhat.com>
> > Cc: Ben Segall <bsegall@google.com>
> > ---
> >
> > v2: Clean up building issues with various related CONFIG changes. Add a
> > check to start the hrtick in __account_cfs_rq_runtime() for when the
> > task gets more runtime.
> 
> This starts the hrtick before/without going through schedule, but the
> fact that it's still the standard hrtick()->task_tick(queued=1) means it
> will still set need_resched even if it succeeds at getting runtime.
> 

Ah, I see what you are saying. I was hoping to leverage the existing hrtick.
I certainly don't want to add a new one for this.  As it is it seems to be
doing what is expected (at some expense of extra schedules). If that expense
is too high then this may not be helpful.

I guess I will try the don't-stop-the-tick approach. I'm more concerned with getting
accurate quota support in this case than removing the tick.

Cheers,
Phil



-- 

