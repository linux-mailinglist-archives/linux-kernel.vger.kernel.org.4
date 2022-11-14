Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51060627D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 13:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiKNMMf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 07:12:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236110AbiKNMMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 07:12:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75784F5B3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 04:12:32 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 249AEB80D21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 12:12:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCC6C433C1;
        Mon, 14 Nov 2022 12:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668427949;
        bh=+ef3W1sVbm/swEdirvU3QG6zn6qU/vBbry+/iQwJyzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YwYQx7UDj1Kn2tE0MeizUmHWmEWCpCTE+ZXi5P1DLEhTJ0us4W0GyPRjwQb6fL6vr
         QOJG6F5q+VGcNeKi8nbyYzNXMkc3VIzv+1q9k6cVy/Z7mI0mL9gCMtON6hWbi7Rn3g
         JjBCI/Bc7OwRTcv+w8fGz4OCYHegQcWsExnbayXjTi3JGa45br/1G4i/t2Vdp9PWbt
         a24fLzjNftoLH82CwHvU8/2Y7KsfjsxQpbLFIxuZP5hVG9Bf+gMJenalVSgUqE+yHE
         aHk6KCW0icmgbBw+uyDHYp21LJHWAj2N0mQzZzyS4U700UD5rdN21C0pNomJc/pMKX
         AZLjkdcNjO76A==
Date:   Mon, 14 Nov 2022 13:12:26 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     Aaron Tomlin <atomlin@redhat.com>, cl@linux.com,
        tglx@linutronix.de, mingo@kernel.org, peterz@infradead.org,
        pauld@redhat.com, neelx@redhat.com, oleksandr@natalenko.name,
        atomlin@atomlin.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v8 3/5] mm/vmstat: Do not queue vmstat_update if tick is
 stopped
Message-ID: <20221114121226.GB590078@lothringen>
References: <20220924152227.819815-1-atomlin@redhat.com>
 <20220924152227.819815-4-atomlin@redhat.com>
 <20221024110311.GA1285913@lothringen>
 <Y2wCKjYIxN8Q/FQ+@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2wCKjYIxN8Q/FQ+@fuller.cnet>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 09, 2022 at 04:40:26PM -0300, Marcelo Tosatti wrote:
> On Mon, Oct 24, 2022 at 01:03:11PM +0200, Frederic Weisbecker wrote:
> > Lines: 94
> > 
> > On Sat, Sep 24, 2022 at 04:22:25PM +0100, Aaron Tomlin wrote:
> > > From: Marcelo Tosatti <mtosatti@redhat.com>
> > > 
> > > From the vmstat shepherd, for CPUs that have the tick stopped, do not
> > > queue local work to flush the per-CPU vmstats, since in that case the
> > > flush is performed on return to userspace or when entering idle. Also
> > > cancel any delayed work on the local CPU, when entering idle on nohz
> > > full CPUs. Per-CPU pages can be freed remotely from housekeeping CPUs.
> > > 
> > > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> > > ---
> > >  mm/vmstat.c | 18 +++++++++++++-----
> > >  1 file changed, 13 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/mm/vmstat.c b/mm/vmstat.c
> > > index 472175642bd9..3b9a497965b4 100644
> > > --- a/mm/vmstat.c
> > > +++ b/mm/vmstat.c
> > > @@ -29,6 +29,7 @@
> > >  #include <linux/page_ext.h>
> > >  #include <linux/page_owner.h>
> > >  #include <linux/migrate.h>
> > > +#include <linux/tick.h>
> > >  
> > >  #include "internal.h"
> > >  
> > > @@ -1990,19 +1991,23 @@ static void vmstat_update(struct work_struct *w)
> > >   */
> > >  void quiet_vmstat(void)
> > >  {
> > > +	struct delayed_work *dw;
> > > +
> > >  	if (system_state != SYSTEM_RUNNING)
> > >  		return;
> > >  
> > >  	if (!is_vmstat_dirty())
> > >  		return;
> > >  
> > > +	refresh_cpu_vm_stats(false);
> > > +
> > >  	/*
> > > -	 * Just refresh counters and do not care about the pending delayed
> > > -	 * vmstat_update. It doesn't fire that often to matter and canceling
> > > -	 * it would be too expensive from this path.
> > > -	 * vmstat_shepherd will take care about that for us.
> > > +	 * If the tick is stopped, cancel any delayed work to avoid
> > > +	 * interruptions to this CPU in the future.
> > >  	 */
> > > -	refresh_cpu_vm_stats(false);
> > > +	dw = &per_cpu(vmstat_work, smp_processor_id());
> > > +	if (delayed_work_pending(dw) && tick_nohz_tick_stopped())
> > > +		cancel_delayed_work(dw);
> > >  }
> > >  
> > >  /*
> > > @@ -2024,6 +2029,9 @@ static void vmstat_shepherd(struct work_struct *w)
> > >  	for_each_online_cpu(cpu) {
> > >  		struct delayed_work *dw = &per_cpu(vmstat_work, cpu);
> > >  
> > > +		if (tick_nohz_tick_stopped_cpu(cpu))
> > > +			continue;
> > > +
> > >  		if (!delayed_work_pending(dw) && per_cpu(vmstat_dirty, cpu))
> > >  			queue_delayed_work_on(cpu, mm_percpu_wq, dw, 0);
> > 
> > All these checks are racy though. You may well eventually:
> > 
> > 1) Arm the timer after the CPU has entered in userspace
> > 2) Not arm the timer when the CPU has entered the kernel
> > 
> > How about converting that to an IPI instead? This should be a good candidate
> > for the future IPI deferment.
> > 
> > Another possible way to go is this:
> > 
> > 1) vmstat_shepherd completely ignores nohz_full CPUs
> > 2) vmstat_work is only ever armed locally
> > 3) A nohz_full CPU turning its local vmstat as dirty checks if vmstat_work is
> >    pending. If not, queue it, possibly through a self IPI (IRQ_WORK) to get
> >    away with current locking context.
> 
> I'm afraid there might be workloads where local vmstat touch is a
> hot-path.
> 
> > 3) Fold on idle if dirty
> > 4) Fold on user enter and disarm vmstat_work if pending
> > 
> > Does that sound possible?
> > 
> > Thanks.
> 
> I guess so, but proper barriers would also work.
> 
> Do you have any particular reason for the 1-4 sequence above 
> instead of barriers?

That means adding an smp_mb() on user enter, or atomic_cmpxchg().
But then deferred IPI would handle all that for you, right?
