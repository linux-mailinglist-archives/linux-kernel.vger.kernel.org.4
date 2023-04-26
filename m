Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD1F6EFD26
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 00:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240032AbjDZW3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 18:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbjDZW3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 18:29:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B7635A1;
        Wed, 26 Apr 2023 15:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FAC06391F;
        Wed, 26 Apr 2023 22:29:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8641CC433EF;
        Wed, 26 Apr 2023 22:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682548159;
        bh=vO6L6ZXoVNUoUHs9/f4aULtIHpXjyWPjryGe2I6ClK4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=TpZuOlNBuXXoX9v6VIhPUmkmEuSCYkh+aDkV7Tb0oUoyfRicElb7FQy/GPNavM5e1
         5G79nR1dlmbEl7T8V2C+yb6SJAFH9FeilBR0+7ZXsdaL0LZFjgkcuhsEwgbBe/8a0c
         hx/2O5N72lZPbMsn5HsFxwLwAhhHWZgRdTQjyYfBM7kTt8PMo3tBlAJSLTMOo+s/SH
         HS1MBQpXeObNI3XVfo3r05yH2AX9eSRQ8gZU9TuPvJeofMlUcB7WKG85+2Yx8ixJPO
         yu9BX+sSvsJoxxFEblAMi6nSfgQ++aVwIeI2U+wyyrGQiA1QrjFOAIt2O2/jYrVesp
         2rBca9EHtFJ0Q==
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 1880E15404B7; Wed, 26 Apr 2023 15:29:19 -0700 (PDT)
Date:   Wed, 26 Apr 2023 15:29:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Tejun Heo <tj@kernel.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org, riel@surriel.com
Subject: Re: [PATCH RFC rcu] Stop rcu_tasks_invoke_cbs() from using
 never-online CPUs
Message-ID: <a047c7dd-7ac9-4b03-807b-1f77473321bc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <83d037d1-ef12-4b31-a7b9-7b1ed6c3ae42@paulmck-laptop>
 <ZEmhtdxpelt5jxAu@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEmhtdxpelt5jxAu@slm.duckdns.org>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 12:12:05PM -1000, Tejun Heo wrote:
> On Wed, Apr 26, 2023 at 10:26:38AM -0700, Paul E. McKenney wrote:
> > The rcu_tasks_invoke_cbs() relies on queue_work_on() to silently fall
> > back to WORK_CPU_UNBOUND when the specified CPU is offline.  However,
> > the queue_work_on() function's silent fallback mechanism relies on that
> > CPU having been online at some time in the past.  When queue_work_on()
> > is passed a CPU that has never been online, workqueue lockups ensue,
> > which can be bad for your kernel's general health and well-being.
> > 
> > This commit therefore checks whether a given CPU is currently online,
> > and, if not substitutes WORK_CPU_UNBOUND in the subsequent call to
> > queue_work_on().  Why not simply omit the queue_work_on() call entirely?
> > Because this function is flooding callback-invocation notifications
> > to all CPUs, and must deal with possibilities that include a sparse
> > cpu_possible_mask.
> > 
> > Fixes: d363f833c6d88 rcu-tasks: Use workqueues for multiple rcu_tasks_invoke_cbs() invocations
> > Reported-by: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> ...
> > +		// If a CPU has never been online, queue_work_on()
> > +		// objects to queueing work on that CPU.  Approximate a
> > +		// check for this by checking if the CPU is currently online.
> > +
> > +		cpus_read_lock();
> > +		cpuwq1 = cpu_online(cpunext) ? cpunext : WORK_CPU_UNBOUND;
> > +		cpuwq2 = cpu_online(cpunext + 1) ? cpunext + 1 : WORK_CPU_UNBOUND;
> > +		cpus_read_unlock();
> > +
> > +		// Yes, either CPU could go offline here.  But that is
> > +		// OK because queue_work_on() will (in effect) silently
> > +		// fall back to WORK_CPU_UNBOUND for any CPU that has ever
> > +		// been online.
> 
> Looks like cpus_read_lock() isn't protecting anything really.

It certainly isn't protecting much.  ;-)

The purpose is to avoid a situation where this CPU thinks that some other
CPU is online, but the corresponding workqueue has not yet been created.
And I freely admit that, given the huge amount of synchronization and
delay on the CPU-hotplug path, it is really hard to imagine this getting
messed up.  Except that this is the quick fix, where it would be bad to
rely on anything requiring much thought.

I am working a more dainty fix for mainline that doesn't need
cpus_read_lock(), even in nightmarish theorizing.

> > +		queue_work_on(cpuwq1, system_wq, &rtpcp_next->rtp_work);
> >  		cpunext++;
> >  		if (cpunext < smp_load_acquire(&rtp->percpu_dequeue_lim)) {
> >  			rtpcp_next = per_cpu_ptr(rtp->rtpcpu, cpunext);
> > -			queue_work_on(cpunext, system_wq, &rtpcp_next->rtp_work);
> > +			queue_work_on(cpuwq2, system_wq, &rtpcp_next->rtp_work);
> 
> As discussed in the thread, I kinda wonder whether just using an unbound
> workqueue would be sufficient but as a fix this looks good to me.

I would agree except for the callback-flood corner case, in which
callback invocation needs all the help it can get if it is to keep up
with a tightish loop doing call_rcu_tasks_*().

> Acked-by: Tejun Heo <tj@kernel.org>

I will apply this on my next rebase, thank you!

							Thanx, Paul
