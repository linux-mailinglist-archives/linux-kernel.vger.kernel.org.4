Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C698763FA1A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 22:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLAV5N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 16:57:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiLAV5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 16:57:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50017C35BF
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 13:56:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3889EB82038
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 21:56:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB491C433C1;
        Thu,  1 Dec 2022 21:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669931811;
        bh=L5adjgLKg0mPxVAzes7OLtV4Uipq90KoN8TcDYjFv1g=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=e3ceouk+BP1lc9wvcZnEduAf2nZ+d4wNjeSN4Adt0+kGZ13SJccnEgWA17kBQjg6j
         OJtQqoCQWLeFJkpNM1EwJQTYJR5tx/3MePAxgR0BCKREURDPOJ2O5wZmPz8li0BHOR
         mIKIICwCdXHj9PviKOLZtvLldk38tZsRqJ8Rcc6RKTQnHPQnNWu9Fd3ID7zr0tk1vx
         Y0Y3oLiTjeweToCHmVP2ajcGJHIUiUsDCbaEgWC0KhVqu2yiu3INIre0tixr0xS9yg
         85VU/iDhDKtManjBZi82ZQNdIsUdPBea+LXw8eNI57fJOSdtPIwI+tTbFE/mzdX5T/
         65SQ6G5StGK9g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 952375C05F8; Thu,  1 Dec 2022 13:56:50 -0800 (PST)
Date:   Thu, 1 Dec 2022 13:56:50 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        qiang1.zhang@intel.com
Subject: Re: [PATCH printk v5 03/40] printk: Prepare for SRCU console list
 protection
Message-ID: <20221201215650.GK4001@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221116162152.193147-1-john.ogness@linutronix.de>
 <20221116162152.193147-4-john.ogness@linutronix.de>
 <Y4jw3hSuwt3RG4DL@dev-arch.thelio-3990X>
 <87lenqq012.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lenqq012.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 01, 2022 at 10:42:25PM +0106, John Ogness wrote:
> Hi Nathan,
> 
> Thanks for reporting this. Patch below.
> 
> @paulmck: Please also take a look below.
> 
> On 2022-12-01, Nathan Chancellor <nathan@kernel.org> wrote:
> > bad: scheduling from the idle thread!
> > CPU: 0 PID: 0 Comm: swapper Not tainted 6.1.0-rc1+ #1
> > Hardware name: PowerMac3,1 7400 0xc0209 PowerMac
> > Call Trace:
> > [c0bc1db0] [c07f07e0] dump_stack_lvl+0x34/0x50 (unreliable)
> > [c0bc1dd0] [c008429c] dequeue_task_idle+0x34/0x5c
> > [c0bc1df0] [c0820924] __schedule+0x56c/0x5c4
> > [c0bc1e40] [c08209d0] schedule+0x54/0xfc
> > [c0bc1e60] [c0826034] schedule_timeout+0x13c/0x194
> > [c0bc1ea0] [c082134c] __wait_for_common+0xcc/0x1f4
> > [c0bc1ee0] [c00ac8ac] synchronize_srcu+0xc8/0x12c
> > [c0bc1f20] [c00a0230] unregister_console+0xc8/0x10c
> > [c0bc1f40] [c009e314] register_console+0x2f4/0x390
> > [c0bc1f60] [c0a17510] pmz_console_init+0x34/0x48
> > [c0bc1f70] [c0a0491c] console_init+0x9c/0xf0
> > [c0bc1fa0] [c09f5584] start_kernel+0x588/0x6ac
> > [c0bc1ff0] [00003540] 0x3540
> 
> This config is using TINY_RCU. Its srcu_synchronize() implementation
> does not check if it called before scheduling is ready. The following
> patch will fix it.
> 
> @paulmck: Should it check (system_state < SYSTEM_SCHEDULING) instead
> since TINY_RCU does not use @rcu_scheduler_active?

Thank you for chasing this down, John!

You are exactly right, and I therefore need to pull this into the
pile for the upcoming merge window:

dbc6ca150842 ("srcu: Make Tiny synchronize_srcu() check for readers")

And kudos to Zqiang for a proactive fix!  ;-)

I will add your (John's) Tested-by, but please let me know if this is
inappropriate.

							Thanx, Paul

> John Ogness
> 
> diff --git a/kernel/rcu/srcutiny.c b/kernel/rcu/srcutiny.c
> index 33adafdad261..35338e6e37e7 100644
> --- a/kernel/rcu/srcutiny.c
> +++ b/kernel/rcu/srcutiny.c
> @@ -197,6 +197,9 @@ void synchronize_srcu(struct srcu_struct *ssp)
>  {
>  	struct rcu_synchronize rs;
>  
> +	if (rcu_scheduler_active == RCU_SCHEDULER_INACTIVE)
> +		return;
> +
>  	init_rcu_head_on_stack(&rs.head);
>  	init_completion(&rs.completion);
>  	call_srcu(ssp, &rs.head, wakeme_after_rcu);
