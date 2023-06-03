Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 446BA721126
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jun 2023 18:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbjFCQPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Jun 2023 12:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjFCQO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Jun 2023 12:14:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291C2BD
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 09:14:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9A7160B61
        for <linux-kernel@vger.kernel.org>; Sat,  3 Jun 2023 16:14:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24B1FC433EF;
        Sat,  3 Jun 2023 16:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685808897;
        bh=bzSAZ1YsCUZ2UczkOzfOUE1xUDtm1RQJDMA4raWpkH0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=XEbZ6yaYoSK3wdz7c5XwxZh0oIEJUNaV26CrDHoFW4D2W/SbdFqA9fX4NjLmtXx1K
         TrBSkvzBzRzQIj5nY/rcbVigboHlc+1Pqs5gLLTJtfnjsKBvOiDqiMEM3TqW5t28TO
         p9LGN/9jU+LEZUFa92zwufQNu6aQ3LZLS1+bWpynjj23zQutMjVq+mDnuzIUiuV6hz
         McbU51nXWLl92g885FY584UUzh27xwOzJbxPYOBzZ5vHzuYOiDSB2bfzLSx7eiSOe8
         6dH2Inw7O2Bbi3EshA8bIooOwxPeszeblRhTcu2PnfPPhLvOe6hujv3ldzdHwrcHC+
         ZNFbW+Lr2AkVw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id B5677CE1B88; Sat,  3 Jun 2023 09:14:56 -0700 (PDT)
Date:   Sat, 3 Jun 2023 09:14:56 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Stultz <jstultz@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        kernel-team@android.com
Subject: Re: [PATCH 2/2] torture: Add lock_torture_writer_fifo module param
Message-ID: <c2415658-de0e-4497-889a-d5401cbc134a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20230602220221.600774-1-jstultz@google.com>
 <20230602220221.600774-2-jstultz@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602220221.600774-2-jstultz@google.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 10:02:10PM +0000, John Stultz wrote:
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> 
> Modifies locktorture writer to run as RT task.
> 
> To use it:
> insmod /lib/modules/torture.ko random_shuffle=1 lock_torture_writer_fifo=1
>                                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^
> insmod /lib/modules/locktorture.ko torture_type=mutex_lock rt_boost=1 rt_boost_factor=50 nested_locks=3
> 
> This patch has been helpful to uncover issues with the proxy-execution
> seires.
> 
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Josh Triplett <josh@joshtriplett.org>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Valentin Schneider <vschneid@redhat.com>
> Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Cc: kernel-team@android.com
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> [jstultz: Include header change to build, reword commit message]
> Signed-off-by: John Stultz <jstultz@google.com>

Queued and pushed, thank you all!

							Thanx, Paul

> ---
>  kernel/locking/locktorture.c |  3 ++-
>  kernel/torture.c             | 11 ++++++++++-
>  2 files changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/locking/locktorture.c b/kernel/locking/locktorture.c
> index 153ddc4c47ef..7cb044fc99b2 100644
> --- a/kernel/locking/locktorture.c
> +++ b/kernel/locking/locktorture.c
> @@ -816,7 +816,8 @@ static int lock_torture_writer(void *arg)
>  	bool skip_main_lock;
>  
>  	VERBOSE_TOROUT_STRING("lock_torture_writer task started");
> -	set_user_nice(current, MAX_NICE);
> +	if (!rt_task(current))
> +		set_user_nice(current, MAX_NICE);
>  
>  	do {
>  		if ((torture_random(&rand) & 0xfffff) == 0)
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 8be83fdc6be1..db79197e257a 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -37,6 +37,7 @@
>  #include <linux/ktime.h>
>  #include <asm/byteorder.h>
>  #include <linux/torture.h>
> +#include <linux/sched/rt.h>
>  #include "rcu/rcu.h"
>  
>  MODULE_LICENSE("GPL");
> @@ -57,6 +58,9 @@ module_param(verbose_sleep_duration, int, 0444);
>  static int random_shuffle;
>  module_param(random_shuffle, int, 0444);
>  
> +static int lock_torture_writer_fifo;
> +module_param(lock_torture_writer_fifo, int, 0444);
> +
>  static char *torture_type;
>  static int verbose;
>  
> @@ -734,7 +738,7 @@ bool stutter_wait(const char *title)
>  	cond_resched_tasks_rcu_qs();
>  	spt = READ_ONCE(stutter_pause_test);
>  	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
> -		if (!ret) {
> +		if (!ret && !rt_task(current)) {
>  			sched_set_normal(current, MAX_NICE);
>  			ret = true;
>  		}
> @@ -944,6 +948,11 @@ int _torture_create_kthread(int (*fn)(void *arg), void *arg, char *s, char *m,
>  		*tp = NULL;
>  		return ret;
>  	}
> +
> +	if (lock_torture_writer_fifo &&
> +	    !strncmp(s, "lock_torture_writer", strlen(s)))
> +		sched_set_fifo(*tp);
> +
>  	wake_up_process(*tp);  // Process is sleeping, so ordering provided.
>  	torture_shuffle_task_register(*tp);
>  	return ret;
> -- 
> 2.41.0.rc2.161.g9c6817b8e7-goog
> 
