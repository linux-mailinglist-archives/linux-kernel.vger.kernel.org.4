Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7559564BDE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 21:29:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238477AbiLMU25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Dec 2022 15:28:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238509AbiLMU2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Dec 2022 15:28:31 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14FCE2656B;
        Tue, 13 Dec 2022 12:24:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD0F9B815C9;
        Tue, 13 Dec 2022 20:24:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 879BAC433D2;
        Tue, 13 Dec 2022 20:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670963083;
        bh=HuehnSlj7ZBNMT4dk1EPBut8qpFjPDHqw41+48T7UQU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=r37i9+ExBrlOyIDY4hNC43PDUJWQS4v8XYpLyIQaQFfAQDu2lOS5EHcw6zgs9G7Br
         XFYRi+zT7Ko6XkYBzJkyjVuX44dxgH7qiWhS6T9YSKn6qoSFT3Artnv7cejq1tnYRI
         jxLc9XBBk4JhN3b3L4CX4G0BS4xYoKgWkz0N/zsnssY1zHJFc35xO4fGbyK/fBULmz
         SpFzDOAexUzCotm/flSAGPupwSm02IXXsCZoTYE0eZXXjvV1cCY3YKbpQVAfIugLX7
         7WeD/wbyfr6VH3yfxHocHiw0Qbe3qOA7Nt3ggUfd8M14MOYfViQrYOB2PaY5uhPKGL
         U23lFuhCn6oxw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1ACAC5C13B7; Tue, 13 Dec 2022 12:24:43 -0800 (PST)
Date:   Tue, 13 Dec 2022 12:24:43 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>, rcu@vger.kernel.org,
        connoro@google.com
Subject: Re: [PATCH v2 1/2] locktorture: Allow non-rtmutex lock types to be
 boosted
Message-ID: <20221213202443.GU4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221209022305.321149-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209022305.321149-1-joel@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 02:23:04AM +0000, Joel Fernandes (Google) wrote:
> Currently RT boosting is only done for rtmutex_lock, however with proxy
> execution, we also have the mutex_lock participating in priorities. To
> exercise the testing better, add RT boosting to other lock testing types
> as well, using a new knob (rt_boost).
> 
> Tested with boot parameters:
> locktorture.torture_type=mutex_lock
> locktorture.onoff_interval=1
> locktorture.nwriters_stress=8
> locktorture.stutter=0
> locktorture.rt_boost=1
> locktorture.rt_boost_factor=1
> locktorture.nlocks=3
> 
> For the rtmutex test, rt_boost is always enabled even if disabling is
> requested.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

Nice, thank you!

Except that "git am -3" doesn't know about the commit on which this
is based.  Could you please rebase onto the -rcu tree's "dev" branch?

Though there is nothing touching kernel/locking/locktorture.c in
-rcu at the moment, so I confess some curiosity as to exactly what
these patches are based on.  ;-)

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c | 99 ++++++++++++++++++++----------------
>  1 file changed, 56 insertions(+), 43 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index bc3557677eed..8968fd65a90d 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -46,6 +46,8 @@ torture_param(int, shutdown_secs, 0, "Shutdown time (j), <= zero to disable.");
>  torture_param(int, stat_interval, 60,
>  	     "Number of seconds between stats printk()s");
>  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
> +torture_param(int, rt_boost, 2,
> +		"Do periodic rt-boost. 0=Disable, 1=Only for rt_mutex, 2=For all lock types.");
>  torture_param(int, verbose, 1,
>  	     "Enable verbose debugging printk()s");
>  torture_param(int, nlocks, 1,
> @@ -129,15 +131,49 @@ static void torture_lock_busted_write_unlock(int tid __maybe_unused)
>  	  /* BUGGY, do not use in real life!!! */
>  }
>  
> -static void torture_boost_dummy(struct torture_random_state *trsp)
> +static void __torture_rt_boost(struct torture_random_state *trsp)
>  {
> -	/* Only rtmutexes care about priority */
> +	const unsigned int factor = 50000; /* yes, quite arbitrary */
> +
> +	if (!rt_task(current)) {
> +		/*
> +		 * Boost priority once every ~50k operations. When the
> +		 * task tries to take the lock, the rtmutex it will account
> +		 * for the new priority, and do any corresponding pi-dance.
> +		 */
> +		if (trsp && !(torture_random(trsp) %
> +			      (cxt.nrealwriters_stress * factor))) {
> +			sched_set_fifo(current);
> +		} else /* common case, do nothing */
> +			return;
> +	} else {
> +		/*
> +		 * The task will remain boosted for another ~500k operations,
> +		 * then restored back to its original prio, and so forth.
> +		 *
> +		 * When @trsp is nil, we want to force-reset the task for
> +		 * stopping the kthread.
> +		 */
> +		if (!trsp || !(torture_random(trsp) %
> +			       (cxt.nrealwriters_stress * factor * 2))) {
> +			sched_set_normal(current, 0);
> +		} else /* common case, do nothing */
> +			return;
> +	}
> +}
> +
> +static void torture_rt_boost(struct torture_random_state *trsp)
> +{
> +	if (rt_boost != 2)
> +		return;
> +
> +	__torture_rt_boost(trsp);
>  }
>  
>  static struct lock_torture_ops lock_busted_ops = {
>  	.writelock	= torture_lock_busted_write_lock,
>  	.write_delay	= torture_lock_busted_write_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_lock_busted_write_unlock,
>  	.readlock       = NULL,
>  	.read_delay     = NULL,
> @@ -181,7 +217,7 @@ __releases(torture_spinlock)
>  static struct lock_torture_ops spin_lock_ops = {
>  	.writelock	= torture_spin_lock_write_lock,
>  	.write_delay	= torture_spin_lock_write_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_spin_lock_write_unlock,
>  	.readlock       = NULL,
>  	.read_delay     = NULL,
> @@ -208,7 +244,7 @@ __releases(torture_spinlock)
>  static struct lock_torture_ops spin_lock_irq_ops = {
>  	.writelock	= torture_spin_lock_write_lock_irq,
>  	.write_delay	= torture_spin_lock_write_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_lock_spin_write_unlock_irq,
>  	.readlock       = NULL,
>  	.read_delay     = NULL,
> @@ -277,7 +313,7 @@ __releases(torture_rwlock)
>  static struct lock_torture_ops rw_lock_ops = {
>  	.writelock	= torture_rwlock_write_lock,
>  	.write_delay	= torture_rwlock_write_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_rwlock_write_unlock,
>  	.readlock       = torture_rwlock_read_lock,
>  	.read_delay     = torture_rwlock_read_delay,
> @@ -320,7 +356,7 @@ __releases(torture_rwlock)
>  static struct lock_torture_ops rw_lock_irq_ops = {
>  	.writelock	= torture_rwlock_write_lock_irq,
>  	.write_delay	= torture_rwlock_write_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_rwlock_write_unlock_irq,
>  	.readlock       = torture_rwlock_read_lock_irq,
>  	.read_delay     = torture_rwlock_read_delay,
> @@ -362,7 +398,7 @@ __releases(torture_mutex)
>  static struct lock_torture_ops mutex_lock_ops = {
>  	.writelock	= torture_mutex_lock,
>  	.write_delay	= torture_mutex_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_mutex_unlock,
>  	.readlock       = NULL,
>  	.read_delay     = NULL,
> @@ -460,7 +496,7 @@ static struct lock_torture_ops ww_mutex_lock_ops = {
>  	.exit		= torture_ww_mutex_exit,
>  	.writelock	= torture_ww_mutex_lock,
>  	.write_delay	= torture_mutex_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_ww_mutex_unlock,
>  	.readlock       = NULL,
>  	.read_delay     = NULL,
> @@ -478,37 +514,6 @@ __acquires(torture_rtmutex)
>  	return 0;
>  }
>  
> -static void torture_rtmutex_boost(struct torture_random_state *trsp)
> -{
> -	const unsigned int factor = 50000; /* yes, quite arbitrary */
> -
> -	if (!rt_task(current)) {
> -		/*
> -		 * Boost priority once every ~50k operations. When the
> -		 * task tries to take the lock, the rtmutex it will account
> -		 * for the new priority, and do any corresponding pi-dance.
> -		 */
> -		if (trsp && !(torture_random(trsp) %
> -			      (cxt.nrealwriters_stress * factor))) {
> -			sched_set_fifo(current);
> -		} else /* common case, do nothing */
> -			return;
> -	} else {
> -		/*
> -		 * The task will remain boosted for another ~500k operations,
> -		 * then restored back to its original prio, and so forth.
> -		 *
> -		 * When @trsp is nil, we want to force-reset the task for
> -		 * stopping the kthread.
> -		 */
> -		if (!trsp || !(torture_random(trsp) %
> -			       (cxt.nrealwriters_stress * factor * 2))) {
> -			sched_set_normal(current, 0);
> -		} else /* common case, do nothing */
> -			return;
> -	}
> -}
> -
>  static void torture_rtmutex_delay(struct torture_random_state *trsp)
>  {
>  	const unsigned long shortdelay_us = 2;
> @@ -534,10 +539,18 @@ __releases(torture_rtmutex)
>  	rt_mutex_unlock(&torture_rtmutex);
>  }
>  
> +static void torture_rt_boost_rtmutex(struct torture_random_state *trsp)
> +{
> +	if (!rt_boost)
> +		return;
> +
> +	__torture_rt_boost(trsp);
> +}
> +
>  static struct lock_torture_ops rtmutex_lock_ops = {
>  	.writelock	= torture_rtmutex_lock,
>  	.write_delay	= torture_rtmutex_delay,
> -	.task_boost     = torture_rtmutex_boost,
> +	.task_boost     = torture_rt_boost_rtmutex,
>  	.writeunlock	= torture_rtmutex_unlock,
>  	.readlock       = NULL,
>  	.read_delay     = NULL,
> @@ -604,7 +617,7 @@ __releases(torture_rwsem)
>  static struct lock_torture_ops rwsem_lock_ops = {
>  	.writelock	= torture_rwsem_down_write,
>  	.write_delay	= torture_rwsem_write_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_rwsem_up_write,
>  	.readlock       = torture_rwsem_down_read,
>  	.read_delay     = torture_rwsem_read_delay,
> @@ -656,7 +669,7 @@ static struct lock_torture_ops percpu_rwsem_lock_ops = {
>  	.exit		= torture_percpu_rwsem_exit,
>  	.writelock	= torture_percpu_rwsem_down_write,
>  	.write_delay	= torture_rwsem_write_delay,
> -	.task_boost     = torture_boost_dummy,
> +	.task_boost     = torture_rt_boost,
>  	.writeunlock	= torture_percpu_rwsem_up_write,
>  	.readlock       = torture_percpu_rwsem_down_read,
>  	.read_delay     = torture_rwsem_read_delay,
> -- 
> 2.39.0.rc1.256.g54fd8350bd-goog
> 
