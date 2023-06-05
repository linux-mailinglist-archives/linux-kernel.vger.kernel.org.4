Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75D48723270
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbjFEVnZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjFEVnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:43:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB5EE9
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 14:43:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40E4862877
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 21:43:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFF0C433D2;
        Mon,  5 Jun 2023 21:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686001401;
        bh=H/POr77O/jcsJr1UFP5rBXIqMH3Nea3mFohei8lCugA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XofyBNdwyYya6x5rCOYgp1o6XQV6MNvoI7DsFPYxhtx1NWtj+WJQsykYRbS0gsW+a
         nZOq7NyQP7T8v90O1+dCA0EkzW8mOl/ULU5cEEjZvJIdqP3mzC5IQvc4sQZFabwpLX
         XCAlV6fH8HVXfDoiXwtlIdAWTJRJsH+T6uDw5ml+7VAcYsyJ78afY6VaeQQLHgUdUm
         A6yTABRx6eNUzo3P56Mae+R1Zs4AR9SuHsRKVO1s1C1el+4aQY90xpFzyqAlwgIvfz
         N3AIrvOHel5CR5R+LrI76bl2gpv6aiwFJ1vHKiukrbW40CmwQEc2u3JpOe51N8HtOu
         nOnTPvyFqdmNA==
Date:   Mon, 5 Jun 2023 23:43:18 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <jstultz@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Dumazet <edumazet@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Arjan van de Ven <arjan@infradead.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sebastian Siewior <bigeasy@linutronix.de>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v6 07/21] timers: Introduce add_timer() variants which
 modify timer flags
Message-ID: <ZH5W9hxUahwjVBbH@localhost.localdomain>
References: <20230510072817.116056-1-anna-maria@linutronix.de>
 <20230510072817.116056-8-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230510072817.116056-8-anna-maria@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, May 10, 2023 at 09:28:03AM +0200, Anna-Maria Behnsen a écrit :
> Timer might be used as pinned timer (using add_timer_on()) and later on as
> non pinned timers using add_timer(). When the NOHZ timer pull at expiry
> model is in place, TIMER_PINNED flag is required to be used whenever a
> timer needs to expire on a dedicated CPU. Flag must no be set, if
> expiration on a dedicated CPU is not required.
> 
> add_timer_on()'s behavior will be changed during the preparation patches
> for the NOHZ timer pull at expiry model to unconditionally set TIMER_PINNED
> flag. To be able to reset/set the flag when queueing a timer, two variants
> of add_timer() are introduced.
> 
> This is a preparatory patch and has no functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> ---
> New in v6
> ---
>  include/linux/timer.h |  2 ++
>  kernel/time/timer.c   | 34 ++++++++++++++++++++++++++++++++++
>  2 files changed, 36 insertions(+)
> 
> diff --git a/include/linux/timer.h b/include/linux/timer.h
> index 9162f275819a..6f96661480dd 100644
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h
> @@ -180,6 +180,8 @@ extern int timer_reduce(struct timer_list *timer, unsigned long expires);
>  #define NEXT_TIMER_MAX_DELTA	((1UL << 30) - 1)
>  
>  extern void add_timer(struct timer_list *timer);
> +extern void add_timer_local(struct timer_list *timer);
> +extern void add_timer_global(struct timer_list *timer);
>  
>  extern int try_to_del_timer_sync(struct timer_list *timer);
>  extern int timer_delete_sync(struct timer_list *timer);
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 1522fb81887e..ab9a8bb11a8a 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1242,6 +1242,40 @@ void add_timer(struct timer_list *timer)
>  }
>  EXPORT_SYMBOL(add_timer);
>  
> +/**
> + * add_timer_local - Start a timer on the local CPU
> + * @timer:	The timer to be started
> + *
> + * Same as add_timer() except that the timer flag TIMER_PINNED is set.
> + *
> + * See add_timer() for further details.
> + */
> +void add_timer_local(struct timer_list *timer)
> +{
> +	if (WARN_ON_ONCE(timer_pending(timer)))
> +		return;
> +	timer->flags |= TIMER_PINNED;
> +	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
> +}
> +EXPORT_SYMBOL(add_timer_local);

This one doesn't seem to be used at the end of the patchset.

Thanks.
