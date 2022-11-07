Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F395761FCBC
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 19:05:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233057AbiKGSFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 13:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232270AbiKGSFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 13:05:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFC2224968;
        Mon,  7 Nov 2022 10:02:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 49099611BD;
        Mon,  7 Nov 2022 18:02:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96654C433C1;
        Mon,  7 Nov 2022 18:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667844119;
        bh=aR8pMC8ZTAkBjOgsSkUFawwVBw1I28GB4Ej9Sis/Em0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IoF4JUcn8BXIWZtIcHbwIPEbyZCeTDgFaJBWhx/0bY1Uj4lAtCjyKL0GtT/JSahmB
         UXxwwfIms6UFN0Lbq0AfY8hOxv+1+0O99BZ3YTiY/AOaRUEyuwJwrHmnxQXua6X3SU
         EoQuIIXu0TAyTVrg1M4N7PkkZNq9nMMW953BFq0ywmSPBEHWH0EPjXTTLoW0BIfpvq
         vX65U0tBh89bIu/2SoISDqknwx3vz8EA4eQzSaqCote/6/qAM/ApsdAyhZHIBox28J
         TD1VbJfyO7C67DAnXJePYFJX2f/LK9dJKLOMb5zRWTTaLyTtMR/tPG+krJq55Q4bG6
         ityDzBE9yaYcw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CFB085C095F; Mon,  7 Nov 2022 10:01:57 -0800 (PST)
Date:   Mon, 7 Nov 2022 10:01:57 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v3 01/40] rcu: implement lockdep_rcu_enabled for
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <20221107180157.GL28461@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 03:21:59PM +0106, John Ogness wrote:
> Provide an implementation for debug_lockdep_rcu_enabled() when
> CONFIG_DEBUG_LOCK_ALLOC is not enabled. This allows code to check
> if rcu lockdep debugging is available without needing an extra
> check if CONFIG_DEBUG_LOCK_ALLOC is enabled.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

If you would like me to take this one, please let me know.

Otherwise:

Acked-by: Paul E. McKenney <paulmck@kernel.org>

> ---
>  I also sent this patch to Paul as a suggestion. If it is not
>  acceptable, I just need to add an ifdef CONFIG_DEBUG_LOCK_ALLOC
>  into console_list_lock() of patch 21.
> 
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
> 
