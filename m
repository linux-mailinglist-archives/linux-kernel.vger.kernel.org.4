Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB906E6A12
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbjDRQpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 12:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232130AbjDRQpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 12:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67938D326
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 09:44:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F2A62BB5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 16:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46EBC433EF;
        Tue, 18 Apr 2023 16:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681836295;
        bh=r3o3YyCLJM3hMokQ9TeldgL/1f3w+rQgr+fSpQ2C+5Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NyCSuI53x7bQgDGxrDHDpbSSIqAgM/SyC5/JFhTjc7qFZ3kCOuHYqJ7EzzyPKI46j
         MoTRr7v/bP0pClZdqzGDVmpmcFj84tO5CFkGV2lMoeTiJHpMAkB3kPRLNQRNq5FXIw
         QNzo9ryhYV1V7U8/WjucwSVHxIH62QA/bNM6iS/AGZ74by8xKZnSz4UvIZoCGn0iQ0
         V7IEB+agMkVXt4xIa5yRydI0ACbkjvE3/nzTHtgnEFs70+HBqNZ53vKuxbxIffADYo
         h1SEXtLtPYglK47Tbc0rVgdYI31hDMRW0ZMY5nVGHw59H3fdVCWu32XZbmP/FjQA+I
         xbwZfzO4LusFA==
Date:   Tue, 18 Apr 2023 18:44:50 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Marco Elver <elver@google.com>,
        syzbot <syzbot+3b14b2ed9b3d06dcaa07@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Jacob Keller <jacob.e.keller@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH] posix-cpu-timers: Implement the missing
 timer_wait_running callback
Message-ID: <ZD7JAppWQCoBEBgN@localhost.localdomain>
References: <87h6tsred7.ffs@tglx>
 <874jpsqdy1.ffs@tglx>
 <ZDADdMnY0oW2k5BV@lothringen>
 <87lej3twhv.ffs@tglx>
 <ZDBin2ZQwc69hGX4@lothringen>
 <87ile7trv7.ffs@tglx>
 <CANpmjNOFxGa6iuVbzVcXPyWO-6Zmd=edhatmDBHPKcZ-au35dg@mail.gmail.com>
 <87zg764ojw.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg764ojw.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Mon, Apr 17, 2023 at 03:37:55PM +0200, Thomas Gleixner a écrit :
>  struct cpu_timer {
>  	struct timerqueue_node	node;
> @@ -72,6 +74,7 @@ struct cpu_timer {
>  	struct pid		*pid;
>  	struct list_head	elist;
>  	int			firing;
> +	struct task_struct	*handling;

I guess it can be made __rcu

>  };
>  
>  static inline bool cpu_timer_enqueue(struct timerqueue_head *head,
> @@ -846,6 +846,8 @@ static u64 collect_timerqueue(struct tim
>  			return expires;
>  
>  		ctmr->firing = 1;
> +		/* See posix_cpu_timer_wait_running() */
> +		WRITE_ONCE(ctmr->handling, current);

That can be rcu_assign_pointer()

>  		cpu_timer_dequeue(ctmr);
>  		list_add_tail(&ctmr->elist, firing);
>  	}
> @@ -1161,7 +1163,49 @@ static void handle_posix_cpu_timers(stru
> +static void posix_cpu_timer_wait_running(struct k_itimer *timr)
> +{
> +	struct task_struct *tsk = READ_ONCE(timr->it.cpu.handling);

And rcu_dereference()

> +
> +	/* Has the handling task completed expiry already? */
> +	if (!tsk)
> +		return;
> +
> +	/* Ensure that the task cannot go away */
> +	get_task_struct(tsk);
> +	/* Now drop the RCU protection so the mutex can be locked */
> +	rcu_read_unlock();
> +	/* Wait on the expiry mutex */
> +	mutex_lock(&tsk->posix_cputimers_work.mutex);
> +	/* Release it immediately again. */
> +	mutex_unlock(&tsk->posix_cputimers_work.mutex);
> +	/* Drop the task reference. */
> +	put_task_struct(tsk);
> +	/* Relock RCU so the callsite is balanced */
> +	rcu_read_lock();
> +}
> @@ -1363,6 +1420,8 @@ static void handle_posix_cpu_timers(stru
>  		 */
>  		if (likely(cpu_firing >= 0))
>  			cpu_timer_fire(timer);
> +		/* See posix_cpu_timer_wait_running() */
> +		WRITE_ONCE(timer->it.cpu.handling, NULL);

And rcu_assign_pointer()

Aside the boring details:

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
