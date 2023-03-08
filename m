Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A276B0882
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 14:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjCHNU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 08:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjCHNTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 08:19:40 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49AAE83FE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 05:15:59 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id B3B8821A0C;
        Wed,  8 Mar 2023 13:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678281349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zEpbfiWbEMdCGR1NntG67p9zbGiIgg73uH9ULh8xFuc=;
        b=DtfCfMoeekNkFDBLGhJBr3gK3IXl2suST3a3IYgFmDZBF2LaUwzNcdV4oj98chqloFCJpc
        gudIoywdq18WouzNJ189z7DoRIDlSodFsdWPd4II32AY8VJLrhy3N/FTiKUF4k7BLpjkNG
        N4UhbJ/H9Jsex9aigaROb9duEd8Uxf0=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5B9002C141;
        Wed,  8 Mar 2023 13:15:49 +0000 (UTC)
Date:   Wed, 8 Mar 2023 14:15:48 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 03/18] printk: Consolidate console deferred
 printing
Message-ID: <ZAiKhAA37/jehmD7@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:03, John Ogness wrote:
> Printig to consoles can be deferred for several reasons:
> 
> - explicitly with printk_deferred()
> - printk() in NMI context
> - recursive printk() calls
> 
> The current implementation is not consistent. For printk_deferred(),
> irq work is scheduled twice. For NMI und recursive, panic CPU
> suppression and caller delays are not properly enforced.
> 
> Correct these inconsistencies by consolidating the deferred printing
> code so that vprintk_deferred() is the toplevel function for
> deferred printing and vprintk_emit() will perform whichever irq_work
> queueing is appropriate.
> 
> Also add kerneldoc for wake_up_klogd() and defer_console_output() to
> clarify their differences and appropriate usage.

> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -2321,7 +2321,10 @@ asmlinkage int vprintk_emit(int facility, int level,
>  		preempt_enable();
>  	}
>  
> -	wake_up_klogd();
> +	if (in_sched)
> +		defer_console_output();
> +	else
> +		wake_up_klogd();

Nit: I would add an empty line here. Or I would move this up into the
     previous if (in_sched()) condition.

>  	return printed_len;
>  }
>  EXPORT_SYMBOL(vprintk_emit);
> @@ -3811,11 +3814,30 @@ static void __wake_up_klogd(int val)
>  	preempt_enable();
>  }
>  
> +/**
> + * wake_up_klogd - Wake kernel logging daemon
> + *
> + * Use this function when new records have been added to the ringbuffer
> + * and the console printing for those records is handled elsewhere. In

"elsewhere" is ambiguous. I would write:

"and the console printing for those records maybe handled in this context".

> + * this case only the logging daemon needs to be woken.
> + *
> + * Context: Any context.
> + */
>  void wake_up_klogd(void)
>  {
>  	__wake_up_klogd(PRINTK_PENDING_WAKEUP);
>  }
>  

Anyway, I like this change.

Best Regards,
Petr
