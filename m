Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FB8E688CDD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 03:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjBCCFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 21:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbjBCCFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 21:05:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE46565F10
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 18:05:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 634C361D5E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 02:05:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD961C433EF;
        Fri,  3 Feb 2023 02:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675389909;
        bh=cGGCO4j/eH7b6nXLU5Nt9zUQ+mhjmYgb6yW6H7zz0Nc=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=T9NmjRg47pymbNJuF0mdmFRCK4SuWK88BZMKt6drhuEcGlnZ/7qvJEcC6pqSpT7+J
         uDkv9Nv2lc9fWAs7DR65H4ugDbCJlUYrlD/TeLvlAeuqNfKTD8t2fA1ahti6b26HTR
         JbLoftNFeSBVrLj3m5WIh4dxSd37LBRWRddz59Zmxodaa26zx1Y3aHq1/gQ4PwglEn
         w1z4MWxRGffgul30m3AxjtuZxsy0WCtCpNAvjwyO9iN2J/YZ9+3ZE3U01SAetE6nHg
         OXUtvUW5YAywOZgPeQpVa3yFilwRr6O9JUw3zyHyjSppoLnC/5IXdt4WznaovPaeYK
         glhO6GFbFE4ww==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 523885C0DE7; Thu,  2 Feb 2023 18:05:09 -0800 (PST)
Date:   Thu, 2 Feb 2023 18:05:09 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [RFC][PATCH 1/4] locktorture: Add nested_[un]lock() hooks and
 nlocks parameter
Message-ID: <20230203020509.GD2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230202223409.2812443-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230202223409.2812443-1-jstultz@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 02, 2023 at 10:34:06PM +0000, John Stultz wrote:
> In order ot extend locktorture to support lock nesting, add
> nested_lock() and nested_unlock() hooks to the torture ops.
> 
> These take a 32bit lockset mask which is generated at random,
> so some number of locks will be taken before the main lock is
> taken and released afterwards.
> 
> Additionally, add nlocks module parameter to allow specifying
> the number of nested locks to be used.
> 
> This has been helpful to uncover issues in the proxy-exec
> series development.
> 
> This was inspired by locktorture extensions originally implemented
> by Connor O'Brien, for stress testing the proxy-execution series:
>   https://lore.kernel.org/lkml/20221003214501.2050087-12-connoro@google.com/
> 
> Comments or feedback would be greatly appreciated!

I have pulled this in for testing and further review, thank you!

Should either of these files have a locktorture.nlocks=<whatever>
added?

tools/testing/selftests/rcutorture/configs/lock/LOCK02.boot
tools/testing/selftests/rcutorture/configs/lock/LOCK05.boot

The first is for mutex_lock and the second for rtmutex_lock.

This did pass a quick "torture.sh --do-none --do-locktorture", which is
good, but this uses the existing .boot files.

							Thanx, Paul

> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: John Stultz <jstultz@google.com>
> ---
>  kernel/locking/locktorture.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 9c2fb613a55d..f4fbd3194654 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -48,6 +48,9 @@ torture_param(int, stat_interval, 60,
>  torture_param(int, stutter, 5, "Number of jiffies to run/halt test, 0=disable");
>  torture_param(int, verbose, 1,
>  	     "Enable verbose debugging printk()s");
> +torture_param(int, nlocks, 0, "Number of nested locks");
> +/* Going much higher trips "BUG: MAX_LOCKDEP_CHAIN_HLOCKS too low!" errors */
> +#define MAX_LOCKS 8
>  
>  static char *torture_type = "spin_lock";
>  module_param(torture_type, charp, 0444);
> @@ -76,10 +79,12 @@ static void lock_torture_cleanup(void);
>  struct lock_torture_ops {
>  	void (*init)(void);
>  	void (*exit)(void);
> +	int (*nested_lock)(int tid, u32 lockset);
>  	int (*writelock)(int tid);
>  	void (*write_delay)(struct torture_random_state *trsp);
>  	void (*task_boost)(struct torture_random_state *trsp);
>  	void (*writeunlock)(int tid);
> +	void (*nested_unlock)(int tid, u32 lockset);
>  	int (*readlock)(int tid);
>  	void (*read_delay)(struct torture_random_state *trsp);
>  	void (*readunlock)(int tid);
> @@ -669,6 +674,7 @@ static int lock_torture_writer(void *arg)
>  	struct lock_stress_stats *lwsp = arg;
>  	int tid = lwsp - cxt.lwsa;
>  	DEFINE_TORTURE_RANDOM(rand);
> +	u32 lockset_mask;
>  
>  	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
>  	set_user_nice(current, MAX_NICE);
> @@ -677,7 +683,10 @@ static int lock_torture_writer(void *arg)
>  		if ((torture_random(&rand) & 0xfffff) == 0)
>  			schedule_timeout_uninterruptible(1);
>  
> +		lockset_mask = torture_random(&rand);
>  		cxt.cur_ops->task_boost(&rand);
> +		if (cxt.cur_ops->nested_lock)
> +			cxt.cur_ops->nested_lock(tid, lockset_mask);
>  		cxt.cur_ops->writelock(tid);
>  		if (WARN_ON_ONCE(lock_is_write_held))
>  			lwsp->n_lock_fail++;
> @@ -690,6 +699,8 @@ static int lock_torture_writer(void *arg)
>  		lock_is_write_held = false;
>  		WRITE_ONCE(last_lock_release, jiffies);
>  		cxt.cur_ops->writeunlock(tid);
> +		if (cxt.cur_ops->nested_unlock)
> +			cxt.cur_ops->nested_unlock(tid, lockset_mask);
>  
>  		stutter_wait("lock_torture_writer");
>  	} while (!torture_must_stop());
> @@ -830,11 +841,11 @@ lock_torture_print_module_parms(struct lock_torture_ops *cur_ops,
>  				const char *tag)
>  {
>  	pr_alert("%s" TORTURE_FLAG
> -		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
> +		 "--- %s%s: nwriters_stress=%d nreaders_stress=%d nlocks=%d stat_interval=%d verbose=%d shuffle_interval=%d stutter=%d shutdown_secs=%d onoff_interval=%d onoff_holdoff=%d\n",
>  		 torture_type, tag, cxt.debug_lock ? " [debug]": "",
> -		 cxt.nrealwriters_stress, cxt.nrealreaders_stress, stat_interval,
> -		 verbose, shuffle_interval, stutter, shutdown_secs,
> -		 onoff_interval, onoff_holdoff);
> +		 cxt.nrealwriters_stress, cxt.nrealreaders_stress, nlocks,
> +		 stat_interval, verbose, shuffle_interval, stutter,
> +		 shutdown_secs, onoff_interval, onoff_holdoff);
>  }
>  
>  static void lock_torture_cleanup(void)
> @@ -1053,6 +1064,10 @@ static int __init lock_torture_init(void)
>  		}
>  	}
>  
> +	/* cap nlocks to MAX_LOCKS */
> +	if (nlocks > MAX_LOCKS)
> +		nlocks = MAX_LOCKS;
> +
>  	if (cxt.cur_ops->readlock) {
>  		reader_tasks = kcalloc(cxt.nrealreaders_stress,
>  				       sizeof(reader_tasks[0]),
> -- 
> 2.39.1.519.gcb327c4b5f-goog
> 
