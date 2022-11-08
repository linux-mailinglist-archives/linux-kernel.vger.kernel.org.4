Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E44620D43
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 11:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233330AbiKHK3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 05:29:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232125AbiKHK3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 05:29:36 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CA3614A;
        Tue,  8 Nov 2022 02:29:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 01EB91F8BD;
        Tue,  8 Nov 2022 10:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667903374; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=42Wym6hzhZrHL5OTzyhJU3dom4Zp+KxcEH8YfQkDIFA=;
        b=XXk3dL2kcI3cUCEHnlBi+X3mJXJ/iOiZHahAhF39ojcDurjARdKOPBIL642UWdpvEJ592O
        O+PeIZEY6Frk+4BO+rVkzLme/PGXrfw06copVWtDMDuYDIKyBH1t6uF0yh4wht7pDofiSm
        q6V9GnVki532OqQHws4P4FoAfkNUF70=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 791932C141;
        Tue,  8 Nov 2022 10:29:33 +0000 (UTC)
Date:   Tue, 8 Nov 2022 11:29:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org
Subject: Re: [PATCH printk v3 01/40] rcu: implement lockdep_rcu_enabled for
 !CONFIG_DEBUG_LOCK_ALLOC
Message-ID: <Y2ovjKa11/yojrNK@alley>
References: <20221107141638.3790965-1-john.ogness@linutronix.de>
 <20221107141638.3790965-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107141638.3790965-2-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 15:21:59, John Ogness wrote:
> Provide an implementation for debug_lockdep_rcu_enabled() when
> CONFIG_DEBUG_LOCK_ALLOC is not enabled. This allows code to check
> if rcu lockdep debugging is available without needing an extra
> check if CONFIG_DEBUG_LOCK_ALLOC is enabled.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Petr Mladek <pmladek@suse.com>

Just a small nit below.

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

It would make sense to move this up before rcu_read_lock_held()
definition so that the declarations and definitions are in
the same order in both #ifdef CONFIG_DEBUG_LOCK_ALLOC branches.

>  #endif /* #else #ifdef CONFIG_DEBUG_LOCK_ALLOC */
>  
>  #ifdef CONFIG_PROVE_RCU

Best Regards,
PEtr
