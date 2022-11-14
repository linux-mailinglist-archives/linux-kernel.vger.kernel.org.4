Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFF836273C8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 01:15:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbiKNAPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 19:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiKNAPX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 19:15:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92483114B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Nov 2022 16:15:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 325FA60DEE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Nov 2022 00:15:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E400C433D6;
        Mon, 14 Nov 2022 00:15:20 +0000 (UTC)
Date:   Sun, 13 Nov 2022 19:15:18 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Julia Lawall <Julia.Lawall@inria.fr>
Subject: Re: [PATCH v6 4/6] timers: Add timer_shutdown_sync() to be called
 before freeing timers
Message-ID: <20221113191518.0a3b29b1@rorschach.local.home>
In-Reply-To: <875yfitpdu.ffs@tglx>
References: <20221110064101.429013735@goodmis.org>
        <20221110064147.343514404@goodmis.org>
        <875yfitpdu.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Nov 2022 00:18:21 +0100
Thomas Gleixner <tglx@linutronix.de> wrote:

> > @@ -1285,11 +1281,25 @@ int try_to_del_timer_sync(struct timer_list *timer)
> >  
> >  	if (base->running_timer != timer)
> >  		ret = detach_if_pending(timer, base, true);
> > +	if (free)
> > +		timer->function = NULL;  
> 
> Same problem as in the timer_shutdown() case just more subtle:
> 
> CPU0                           		CPU1
> 
>                                         lock_timer(timer);
>                                         base->running_timer = timer;
> 					fn = timer->function;
> 					unlock_timer(timer);
> 					fn(timer) {
> 
> __try_to_del_timer_sync(timer, free=true)
>     lock_timer(timer);
>     if (base->running_timer != timer)
>        // Not taken
>     if (free)                             mod_timer(timer);
>                                             if (WARN_ON_ONCE(!timer->function))
>                                                return; // not taken
>        timer->function = NULL;
>     unlock_timer(timer);
> 					    lock_timer(timer);
>                                             enqueue_timer(timer);
> 					    unlock_timer(timer);
>                                         }
> 
> 					//timer expires
> 					lock_timer(timer);
> 					fn = timer->function;
> 					unlock_timer(timer);
> 					fn(timer); <--- NULL pointer dereference
> 
> You surely have spent a massive amount of analysis on this!
> 
> Can you please explain how you came up with the brilliant idea of asking
> Linus to pull this post -rc4 without a review from the timer maintainers
> or anyone else who understands concurrency?

I trusted the source of this code:

  https://lore.kernel.org/all/87pmlrkgi3.ffs@tglx/


-- Steve
