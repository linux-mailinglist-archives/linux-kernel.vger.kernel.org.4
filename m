Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 065C468A6F8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 00:38:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbjBCXiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 18:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232127AbjBCXix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 18:38:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 077081BAED
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 15:38:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6F04962041
        for <linux-kernel@vger.kernel.org>; Fri,  3 Feb 2023 23:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C803AC433EF;
        Fri,  3 Feb 2023 23:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675467530;
        bh=3xq4cMFYfLRdyj8Ht5xCK5O2qFvkrXyiGtCmpQ8cKTY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YzIZB5hxxk2lewlaQL4xZAxCs1Beq+MzgDtuIUJ7BsVCJz/N0WLEmAA5WGRyS6+R1
         FZ1cOZNtQMl+UzrSjcJFwgaJe8LtbPtl6Ox/CiwNrJJpSWpkgMBNYgiLEsYw+uh8A6
         LyQoZduplRbtVWKG2AHR1X3015m6hYiWHs2cAQ5FPndh7bGR61Ew66ene0w6guilkU
         q7zCsUZ1fxTZd59MM5eakQVnGPP3Ree1ivLhTt3R9eY3+gx2He6PfuEcBI/6wldlw+
         VzxUJ2zdUnaifzMnqLTXZue6BptDkM3wOmCodczJ0Oyu/gBVSLMjUkeg7bR9sIjur5
         sp4sTrUGLOMLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 6FFB25C1931; Fri,  3 Feb 2023 15:38:50 -0800 (PST)
Date:   Fri, 3 Feb 2023 15:38:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v2 1/4] locktorture: Add nested_[un]lock() hooks and
 nlocks parameter
Message-ID: <20230203233850.GP2948950@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20230203200138.3872873-1-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203200138.3872873-1-jstultz@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 08:01:35PM +0000, John Stultz wrote:
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

I have applied this series in place of the previous one, and thank you
for the added scripting updates!

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
