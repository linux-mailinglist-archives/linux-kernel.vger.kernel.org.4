Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385C0623431
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 21:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiKIUGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 15:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiKIUGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 15:06:36 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4392A8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 12:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1668024277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4JpgViCI9N5nOLLYCx04E2zRWLxWK/5vOHmovPG9dcM=;
        b=cxlNPph8cd9Enq526wYZ7zSsKDn6m7FIadEt/Bd0iGzjrcxIVYx8WwAnlL0oJrtmkwwfWQ
        rbA/rhyEgipYCk/F5B3xRvc6X5xTrAMuWnMY4RcEuuQVtjuAJuvJuJC/kwp8OL4ncVdjQo
        IP6bZaea2lv+LkHdCMGq1v9581QNmlY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-nW6RJhzMNL2jlX4G5MQ8kQ-1; Wed, 09 Nov 2022 15:04:33 -0500
X-MC-Unique: nW6RJhzMNL2jlX4G5MQ8kQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8CD8A1C0879D;
        Wed,  9 Nov 2022 20:04:32 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-4.gru2.redhat.com [10.97.112.4])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F0CD04B3FC6;
        Wed,  9 Nov 2022 20:04:31 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 9BFE3416D89A; Wed,  9 Nov 2022 16:40:26 -0300 (-03)
Date:   Wed, 9 Nov 2022 16:40:26 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Aaron Tomlin <atomlin@redhat.com>, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        atomlin@atomlin.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 3/5] mm/vmstat: Do not queue vmstat_update if tick is
 stopped
Message-ID: <Y2wCKjYIxN8Q/FQ+@fuller.cnet>
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220924152227.819815-4-atomlin@redhat.com>
 <20221024110311.GA1285913@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024110311.GA1285913@lothringen>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 01:03:11PM +0200, Frederic Weisbecker wrote:
> Lines: 94
> 
> On Sat, Sep 24, 2022 at 04:22:25PM +0100, Aaron Tomlin wrote:
> > From: Marcelo Tosatti <mtosatti@redhat.com>
> > 
> > From the vmstat shepherd, for CPUs that have the tick stopped, do not
> > queue local work to flush the per-CPU vmstats, since in that case the
> > flush is performed on return to userspace or when entering idle. Also
> > cancel any delayed work on the local CPU, when entering idle on nohz
> > full CPUs. Per-CPU pages can be freed remotely from housekeeping CPUs.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > ---
> >  mm/vmstat.c | 18 +++++++++++++-----
> >  1 file changed, 13 insertions(+), 5 deletions(-)
> > 
> > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > index 472175642bd9..3b9a497965b4 100644
> > --- a/mm/vmstat.c
> > +++ b/mm/vmstat.c
> > @@ -29,6 +29,7 @@
> >  #include <linux/page_ext.h>
> >  #include <linux/page_owner.h>
> >  #include <linux/migrate.h>
> > +#include <linux/tick.h>
> >  
> >  #include "internal.h"
> >  
> > @@ -1990,19 +1991,23 @@ static void vmstat_update(struct work_struct *w)
> >   */
> >  void quiet_vmstat(void)
> >  {
> > +	struct delayed_work *dw;
> > +
> >  	if (system_state != SYSTEM_RUNNING)
> >  		return;
> >  
> >  	if (!is_vmstat_dirty())
> >  		return;
> >  
> > +	refresh_cpu_vm_stats(false);
> > +
> >  	/*
> > -	 * Just refresh counters and do not care about the pending delayed
> > -	 * vmstat_update. It doesn't fire that often to matter and canceling
> > -	 * it would be too expensive from this path.
> > -	 * vmstat_shepherd will take care about that for us.
> > +	 * If the tick is stopped, cancel any delayed work to avoid
> > +	 * interruptions to this CPU in the future.
> >  	 */
> > -	refresh_cpu_vm_stats(false);
> > +	dw = &per_cpu(vmstat_work, smp_processor_id());
> > +	if (delayed_work_pending(dw) && tick_nohz_tick_stopped())
> > +		cancel_delayed_work(dw);
> >  }
> >  
> >  /*
> > @@ -2024,6 +2029,9 @@ static void vmstat_shepherd(struct work_struct *w)
> >  	for_each_online_cpu(cpu) {
> >  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> >  
> > +		if (tick_nohz_tick_stopped_cpu(cpu))
> > +			continue;
> > +
> >  		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
> >  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> 
> All these checks are racy though. You may well eventually:
> 
> 1) Arm the timer after the CPU has entered in userspace
> 2) Not arm the timer when the CPU has entered the kernel
> 
> How about converting that to an IPI instead? This should be a good candidate
> for the future IPI deferment.
> 
> Another possible way to go is this:
> 
> 1) vmstat_shepherd completely ignores nohz_full CPUs
> 2) vmstat_work is only ever armed locally
> 3) A nohz_full CPU turning its local vmstat as dirty checks if vmstat_work is
>    pending. If not, queue it, possibly through a self IPI (IRQ_WORK) to get
>    away with current locking context.

I'm afraid there might be workloads where local vmstat touch is a
hot-path.

> 3) Fold on idle if dirty
> 4) Fold on user enter and disarm vmstat_work if pending
> 
> Does that sound possible?
> 
> Thanks.

I guess so, but proper barriers would also work.

Do you have any particular reason for the 1-4 sequence above 
instead of barriers?

