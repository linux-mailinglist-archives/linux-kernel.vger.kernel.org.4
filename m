Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FCD6E10CB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 17:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231557AbjDMPQC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 11:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjDMPQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 11:16:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEEDAD
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 08:15:59 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7A6851FD66;
        Thu, 13 Apr 2023 15:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681398958; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1ncar6WxFuoBBNk0Hs6qIbWy5Bwe1mGIBpSePZJMnvQ=;
        b=NuM6YxfBuXbF2b55v2j2WcH+4cF2iry9n4bE+Ix83D8E8c3RqYovDiQIIms7ERwJCqdJz8
        VmE3sb0U2zGh0oSLfqLIdFfTLsRdEA3VcK+VLUI9NMGjPlFyRhfDL844X8E1gTYQWcC4hI
        aF7R9WvmzEVZq5NzTyGKyDKsiGPULQ0=
Received: from suse.cz (pmladek.udp.ovpn2.prg.suse.de [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 25FAC2C143;
        Thu, 13 Apr 2023 15:15:58 +0000 (UTC)
Date:   Thu, 13 Apr 2023 17:15:54 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 03/18] printk: Consolidate console deferred
 printing
Message-ID: <ZDgcqqLNZuvsbgET@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-4-john.ogness@linutronix.de>
 <ZAiKhAA37/jehmD7@alley>
 <871qln7cle.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871qln7cle.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-03-17 14:11:01, John Ogness wrote:
> On 2023-03-08, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2321,7 +2321,10 @@ asmlinkage int vprintk_emit(int facility, int level,
> >>  		preempt_enable();
> >>  	}
> >>  
> >> -	wake_up_klogd();
> >> +	if (in_sched)
> >> +		defer_console_output();
> >> +	else
> >> +		wake_up_klogd();
> >
> > Nit: I would add an empty line here. Or I would move this up into the
> >      previous if (in_sched()) condition.
> 
> Empty line is ok. I do not want to move it up because the above
> condition gets more complicated later. IMHO a simple if/else for
> specifying what the irq_work should do is the most straight forward
> here.
> 
> >> @@ -3811,11 +3814,30 @@ static void __wake_up_klogd(int val)
> >>  	preempt_enable();
> >>  }
> >>  
> >> +/**
> >> + * wake_up_klogd - Wake kernel logging daemon
> >> + *
> >> + * Use this function when new records have been added to the ringbuffer
> >> + * and the console printing for those records is handled elsewhere. In
> >
> > "elsewhere" is ambiguous. I would write:
> >
> > "and the console printing for those records maybe handled in this context".
> 
> The reason for using the word "elsewhere" is because in later patches it
> is also the printing threads that can handle it. I can change it to
> "this context" for this patch, but then after adding threads I will need
> to adjust the comment again. How about:
> 
> "and the console printing for those records should not be handled by the
> irq_work context because another context will handle it."

It is better but still a bit hard to follow. As a reader, I see three
contexts:

   + context that calls wake_up_klogd()
   + irq_work context
   + another context that would handle the console printing

The confusing part is that the "another context". It might be the
context calling wake_up_klogd(). If feels like scratching
right ear by left hand ;-)

In fact, also the next sentence "In this case only the logging
daemon needs to be woken." is misleading. Also the printk
kthreads need to be woken but it is done by another function.

OK, what about?

 * wake_up_klogd - Wake kernel logging daemon
 *
 * Use this function when new records have been added to the ringbuffer
 * and the console printing does not have to be deferred to irq_work
 * context. This function will only wake the logging daemons.


Heh, the "wake_up_klogd_work" has became confusing since it started
handling deferred console output. And it is even more confusing now
when it does not handle the kthreads which are yet another deferred
output. But I can't think of any reasonable solution at the moment.

Maybe, we should somehow distinguish the API that will handle only
the legacy consoles. For example, suspend_console() handles both
but console_flush_all() will handle only the legacy ones.

I think that we are going to use nbcon_ prefix for the API
handling the new consoles. Maybe we could use another prefix
for the legacy-consoles-specific API.

Hmm, what about?

    + "bcon_" like the opposite of "nbcon_" but it might be
      confused with boot console

    + "lcon_" like "legacy" or "locked" consoles

    + "scon" like synchronized or serialized consoles.


Honestly, I am not sure how much important this is. But it might
be pretty helpful for anyone who would try to understand the code
in the future. And this rework might be really challenging for
future archaeologists. Not to say, that legacy consoles will
likely stay with us many years, maybe decades.

Best Regards,
Petr
