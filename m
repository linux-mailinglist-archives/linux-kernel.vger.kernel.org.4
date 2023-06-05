Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E744722410
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjFELAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFEK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:59:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88924EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2CA5B61055
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 10:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3A2C433D2;
        Mon,  5 Jun 2023 10:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685962797;
        bh=yocMBCPsP0c0J/HbGwrJBQpskkEaymOSeD/HViEnYlM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eTG5khQXijGxQMN4XDyCLmJ8v3lLUZl1pQ++aeSxInXlgjUQNQfedxRiuMYlUxPMX
         YoJREYu78HdTK4OYBXssXD+hC+OBFhDxCmpMcZ//b9EkjpzWPk+j6fYV0LXQnG8DmX
         BxpCrGGC/rVhGMXKQJEpovkoBuu9WcBARHwMvJvxrlrVyXEPOFxztl60Geawq38SUs
         p0DUSFItl84nAdjvELI2QlHo+dUN31ZX9hHeGZaetoA+WXruTI5NLWyRLxjMrL+xWk
         Jdf2UUFGgsa5qO4YGSJarayj60+LAWHkZBzTN9galPg6EYXeITYKAi+1fenu3B2AXv
         jP/icsmq8rz4w==
Date:   Mon, 5 Jun 2023 12:59:54 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        syzbot+5c54bd3eb218bb595aa9@syzkaller.appspotmail.com,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [patch v2a 01/20] posix-timers: Prevent RT livelock in
 itimer_delete()
Message-ID: <ZH3AKuUlZnZjoQo7@localhost.localdomain>
References: <20230425181827.219128101@linutronix.de>
 <20230425183312.862346341@linutronix.de>
 <ZFPmKtFGPUQkeDEd@localhost.localdomain>
 <87bkj03qmq.ffs@tglx>
 <875y9743dt.ffs@tglx>
 <877csndn49.ffs@tglx>
 <87v8g7c50d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v8g7c50d.ffs@tglx>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Thu, Jun 01, 2023 at 10:16:34PM +0200, Thomas Gleixner a écrit :
> itimer_delete() has a retry loop when the timer is concurrently expired. On
> non-RT kernels this just spin-waits until the timer callback has completed.
> On RT kernels this is a potential livelock when the exiting task preempted
> the hrtimer soft interrupt.

It's not just RT but also archs supporting HAVE_POSIX_CPU_TIMERS_TASK_WORK

> 
> Replace spin_unlock() with an invocation of timer_wait_running() to handle
> it the same way as the other retry loops in the posix timer code.
> 
> Fixes: ec8f954a40da ("posix-timers: Use a callback for cancel synchronization on PREEMPT_RT")
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
> V2:  Remove bogus comments vs. posix CPU timers - Frederic
> V2a: Send the real fixed up version
> ---
>  kernel/time/posix-timers.c |   43 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 35 insertions(+), 8 deletions(-)
> 
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -1037,27 +1037,52 @@ SYSCALL_DEFINE1(timer_delete, timer_t, t
>  }
>  
>  /*
> - * return timer owned by the process, used by exit_itimers
> + * Delete a timer if it is armed, remove it from the hash and schedule it
> + * for RCU freeing.
>   */
>  static void itimer_delete(struct k_itimer *timer)
>  {
> -retry_delete:
> -	spin_lock_irq(&timer->it_lock);
> +	unsigned long flags;
>  
> +retry_delete:
> +	/*
> +	 * irqsave is required to make timer_wait_running() work.
> +	 */
> +	spin_lock_irqsave(&timer->it_lock, flags);
> +
> +	/*
> +	 * Even if the timer is not longer accessible from other tasks
> +	 * it still might be armed and queued in the underlying timer
> +	 * mechanism. Worse, that timer mechanism might run the expiry
> +	 * function concurrently.
> +	 */
>  	if (timer_delete_hook(timer) == TIMER_RETRY) {
> -		spin_unlock_irq(&timer->it_lock);
> +		/*
> +		 * Timer is expired concurrently, prevent livelocks
> +		 * and pointless spinning on RT.

Ditto.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks.
