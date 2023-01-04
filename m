Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0EE65DDE1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 21:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbjADUwx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Jan 2023 15:52:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjADUwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jan 2023 15:52:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E661C938;
        Wed,  4 Jan 2023 12:52:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26056B818E7;
        Wed,  4 Jan 2023 20:52:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAB57C433D2;
        Wed,  4 Jan 2023 20:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672865567;
        bh=qL/Mfx5nnOcaWRV9iCcVLVkZ4Zs70va068ZpkJfr4+k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UF/nvDc30Y0uCQQLNAXhC7rgcz9v0MJ0KCZgdF/EYUpIIhJwCJqmCvAWH91hyUeDr
         uuiUdNUi+PzDU7PLkzkgFmDNAfT9gLYrIiV0c3VT7mUqJKxDc0oKM2gQNG9cMMB6J4
         iXLRmj0JfgZI5+5GBoDMObTwZfL8IfmlFDNKz5SnSoND1DhczrjxMJu4o5VD36/CxD
         1r6lKUjMZoiAjEe3O6i6Nm4OfMOI6ecwnLyg0F/DifhFhzJrB+3+2hpBJbH70hv4yF
         FR7aX/xaXS18rwGOGD4FcNcZlP/mhC7muPqqSouq5isS76MR9UGb8BL3RxIh0ayvEs
         N+HaK3f3BKDxQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5A3505C066D; Wed,  4 Jan 2023 12:52:47 -0800 (PST)
Date:   Wed, 4 Jan 2023 12:52:47 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, rcu@vger.kernel.org
Subject: Re: [PATCH] entry/rcu: Check TIF_RESCHED _after_ delayed RCU wake-up
Message-ID: <20230104205247.GA1751113@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221223211507.84249-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223211507.84249-1-frederic@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 10:15:07PM +0100, Frederic Weisbecker wrote:
> RCU sometimes needs to perform a delayed wake up for specific kthreads
> handling offloaded callbacks (RCU_NOCB).  These wakeups are performed
> by timers and upon entry to idle (also to guest and to user on nohz_full).
> 
> However the delayed wake-up on kernel exit is actually performed after
> the thread flags are fetched towards the fast path check for work to
> do on exit to user. As a result, and if there is no other pending work
> to do upon that kernel exit, the current task will resume to userspace
> with TIF_RESCHED set and the pending wake up ignored.
> 
> Fix this with fetching the thread flags _after_ the delayed RCU-nocb
> kthread wake-up.
> 
> Fixes: 47b8ff194c1f ("entry: Explicitly flush pending rcuog wakeup before last rescheduling point")
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Queued and pushed, thank you!

							Thanx, Paul

> ---
>  kernel/entry/common.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 846add8394c4..a134e26b58c6 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -192,13 +192,14 @@ static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
>  
>  static void exit_to_user_mode_prepare(struct pt_regs *regs)
>  {
> -	unsigned long ti_work = read_thread_flags();
> +	unsigned long ti_work;
>  
>  	lockdep_assert_irqs_disabled();
>  
>  	/* Flush pending rcuog wakeup before the last need_resched() check */
>  	tick_nohz_user_enter_prepare();
>  
> +	ti_work = read_thread_flags();
>  	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
>  		ti_work = exit_to_user_mode_loop(regs, ti_work);
>  
> -- 
> 2.25.1
> 
