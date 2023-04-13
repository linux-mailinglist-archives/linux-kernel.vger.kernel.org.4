Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F1D6E0B06
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 12:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjDMKIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 06:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDMKIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 06:08:11 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235D6A4D
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 03:08:10 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 612D81FD66;
        Thu, 13 Apr 2023 10:08:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681380489; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7xAdjq3X5bcekcoD/wdo9dLOF1QXKlGVkMIdRpzgJsM=;
        b=eNHKIWsO5sXAKHASAHD71AxoF0A7vyg8Gt7NLqRKnSo4KNvvOFlno28Pd/d4BNwcaY9b+e
        WCjkgnwkDJKRNwLRt/IQ1zxDuIxRdFnxJs7ocK0Q+/er1K9H3Hv7zw/HnmDhxQvs6MgHj5
        toPYVaoD2tFwynXNVOTHuhXMgiO/OsE=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 75C1A2C143;
        Thu, 13 Apr 2023 10:08:08 +0000 (UTC)
Date:   Thu, 13 Apr 2023 12:08:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        David Gow <davidgow@google.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        tangmeng <tangmeng@uniontech.com>
Subject: Re: [PATCH printk v1 16/18] kernel/panic: Add atomic write
 enforcement to warn/panic
Message-ID: <ZDfUiB55jE25kmv5@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-17-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-17-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:16, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Invoke the atomic write enforcement functions for warn/panic to
> ensure that the information gets out to the consoles.
> 
> For the panic case, add explicit intermediate atomic flush calls to
> ensure immediate flushing at important points. Otherwise the atomic
> flushing only occurs when dropping out of the elevated priority,
> which for panic may never happen.
> 
> It is important to note that if there are any legacy consoles
> registered, they will be attempting to directly print from the
> printk-caller context, which may jeopardize the reliability of the
> atomic consoles. Optimally there should be no legacy consoles
> registered.
> 
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -329,6 +332,8 @@ void panic(const char *fmt, ...)
>  	if (_crash_kexec_post_notifiers)
>  		__crash_kexec(NULL);
>  
> +	cons_atomic_flush(NULL, true);

Do we need to explicitly flush the messages here?

cons_atomic_flush() is called also from vprintk_emit(). And there are
many messages printed with the PANIC priority above.

This makes an assumption that either printk() in PANIC context
does not try to show the messages immediately or that this
explicit console_atomic_flush() tries harder. I think
that both assumptions are wrong.

> +
>  	console_unblank();
>  
>  	/*
> @@ -353,6 +358,7 @@ void panic(const char *fmt, ...)
>  		 * We can't use the "normal" timers since we just panicked.
>  		 */
>  		pr_emerg("Rebooting in %d seconds..\n", panic_timeout);
> +		cons_atomic_flush(NULL, true);

Same here.
>  
>  		for (i = 0; i < panic_timeout * 1000; i += PANIC_TIMER_STEP) {
>  			touch_nmi_watchdog();
> @@ -371,6 +377,7 @@ void panic(const char *fmt, ...)
>  		 */
>  		if (panic_reboot_mode != REBOOT_UNDEFINED)
>  			reboot_mode = panic_reboot_mode;
> +		cons_atomic_flush(NULL, true);

And here.

>  		emergency_restart();
>  	}
>  #ifdef __sparc__
> @@ -383,12 +390,16 @@ void panic(const char *fmt, ...)
>  	}
>  #endif
>  #if defined(CONFIG_S390)
> +	cons_atomic_flush(NULL, true);

And here.

>  	disabled_wait();
>  #endif
>  	pr_emerg("---[ end Kernel panic - not syncing: %s ]---\n", buf);
>  
>  	/* Do not scroll important messages printed above */
>  	suppress_printk = 1;
> +
> +	cons_atomic_exit(CONS_PRIO_PANIC, prev_prio);

On the contrary, I would explicitly call cons_atomic_flush(NULL, false)
here instead of hiding it in cons_atomic_exit().

It would make it clear that this is the POINT where panic() tries
harder to get the messages out on NOBKL consoles.

> +
>  	local_irq_enable();
>  	for (i = 0; ; i += PANIC_TIMER_STEP) {
>  		touch_softlockup_watchdog();
> @@ -599,6 +610,10 @@ struct warn_args {
>  void __warn(const char *file, int line, void *caller, unsigned taint,
>  	    struct pt_regs *regs, struct warn_args *args)
>  {
> +	enum cons_prio prev_prio;
> +
> +	prev_prio = cons_atomic_enter(CONS_PRIO_EMERGENCY);
> +
>  	disable_trace_on_warning();
>  
>  	if (file)
> @@ -630,6 +645,8 @@ void __warn(const char *file, int line, void *caller, unsigned taint,
>  
>  	/* Just a warning, don't kill lockdep. */
>  	add_taint(taint, LOCKDEP_STILL_OK);
> +
> +	cons_atomic_exit(CONS_PRIO_EMERGENCY, prev_prio);
>  }

I would more this into separate patch and keep this one only for the
PANIC handling.

Also I think that we want to set the EMERGENCY prio also in oops_enter()?

Best Regards,
Petr
