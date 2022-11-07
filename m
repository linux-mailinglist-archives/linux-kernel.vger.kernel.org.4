Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ECD61F8C0
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232702AbiKGQQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiKGQQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:16:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9EF271B
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 08:16:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4BFF561172
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 16:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FD90C433D6;
        Mon,  7 Nov 2022 16:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667837800;
        bh=dMM71S0S5/yBTRIkO9XurOYtV74sQuHO6guEKKhVeCE=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=d3AkSa5o/wSYgqVewFfucLCqBeEeB+1djoUSrpB3t95L8aosBGADm8zCXyyiFU5jB
         qQZAPDVBmOS0UBIabHAcJIQnGiKAYlLlqHvcL2rm9jIck/csEStB+dffj36qcZ3mJU
         Omjf9+1qh+ngsBsDh8cM9HyJ95hP1OY7Dl9k3R5ucTbiOMO+iUKdTRiQUF1Y6BmnJJ
         B7pPGciNyoD5YDnBqjxDusMCYvsOeRSf8wi7sZjZ3XVp4MPvx0J+5axpMiVs8e0P4r
         m2rDmy0UN1LsvaOW1ATCO7GTZgzxDqVDzQjpVPHAhBS7iMkgums+D78f7W/1qDoCyZ
         wrDbHbIDWoh3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 3511F5C095F; Mon,  7 Nov 2022 08:16:39 -0800 (PST)
Date:   Mon, 7 Nov 2022 08:16:39 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        boqun.feng@gmail.com
Subject: Re: [PATCH printk v2 33/38] printk: introduce console_list_lock
Message-ID: <20221107161639.GJ28461@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-34-john.ogness@linutronix.de>
 <Y1pY3I1ufABvroYj@alley>
 <20221027185007.GG5600@paulmck-ThinkPad-P17-Gen-1>
 <87a6539irz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6539irz.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 11:16:56AM +0106, John Ogness wrote:
> On 2022-10-27, "Paul E. McKenney" <paulmck@kernel.org> wrote:
> > One way to save a line is as follows:
> >
> > 	WARN_ON_ONCE(IS_ENABLED(CONFIG_DEBUG_LOCK_ALLOC) &&
> > 		     debug_lockdep_rcu_enabled() &&
> > 		     srcu_read_lock_held(&console_srcu));
> 
> Unfortunately this suggestion does not work because
> debug_lockdep_rcu_enabled() only exists if CONFIG_DEBUG_LOCK_ALLOC is
> enabled. Would you be interested in having an empty implementation?
> Then my check would not need to be concerned about
> CONFIG_DEBUG_LOCK_ALLOC at all. It would become:
> 
>  	WARN_ON_ONCE(debug_lockdep_rcu_enabled() &&
>  		     srcu_read_lock_held(&console_srcu));
> 
> The patch below could be used to achieve that.

Looks quite sensible to me!  There are probably a few other places
where it might be used.

							Thanx, Paul

> John
> 
> --------8<-------------
> >From 71d9e484d5128cd1e57e5bff5391d91789f444fa Mon Sep 17 00:00:00 2001
> From: John Ogness <john.ogness@linutronix.de>
> Date: Mon, 7 Nov 2022 11:06:40 +0106
> Subject: [PATCH] rcu: implement lockdep_rcu_enabled for
>  !CONFIG_DEBUG_LOCK_ALLOC
> 
> Provide an implementation for debug_lockdep_rcu_enabled() when
> CONFIG_DEBUG_LOCK_ALLOC is not enabled. This allows code to check
> if rcu lockdep debugging is available without needing an extra
> check if CONFIG_DEBUG_LOCK_ALLOC is enabled.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  include/linux/rcupdate.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
> index 08605ce7379d..65178c40ab6f 100644
> --- a/include/linux/rcupdate.h
> +++ b/include/linux/rcupdate.h
> @@ -340,6 +340,11 @@ static inline int rcu_read_lock_any_held(void)
>  	return !preemptible();
>  }
>  
> +static inline int debug_lockdep_rcu_enabled(void)
> +{
> +	return 0;
> +}
> +
>  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
>  #ifdef CONFIG_PROVE_RCU
> -- 
> 2.30.2
