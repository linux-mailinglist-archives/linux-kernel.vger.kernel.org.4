Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7E36AE5E7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 17:07:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjCGQHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 11:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjCGQG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 11:06:56 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6990E1FF4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 08:05:14 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D6EE81F8AF;
        Tue,  7 Mar 2023 16:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1678205112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9a+pGfmvncKwIDz1ROk+vUHJYuwF6PClygZKgAHKv5Y=;
        b=nIYe0oa9MURxaJkb99TtsGf1+euTRiX+2I9SoCMi7htNTfpoQU0QtojxyHsCq0AyHqy/Ac
        Kw14HQkUE+/mOnLixN2JY+stmMmtTzAe/UyZAHLCmaSZ5e4kS9O/jx2zd/8GawDpG7h+4X
        u30KLDZo0SwK0hUwMLfZ3Z3NXovj8TQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8376B2C142;
        Tue,  7 Mar 2023 16:05:12 +0000 (UTC)
Date:   Tue, 7 Mar 2023 17:05:09 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v1 02/18] printk: Add NMI check to
 down_trylock_console_sem()
Message-ID: <ZAdgtcbPyQ/8dIDw@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:02, John Ogness wrote:
> The printk path is NMI safe because it only adds content to the
> buffer and then triggers the delayed output via irq_work. If the
> console is flushed or unblanked (on panic) from NMI then it can
> deadlock in down_trylock_console_sem() because the semaphore is not
> NMI safe.

Do you have any particular code path in mind, please?
This does not work in console_flush_on_panic(), see below.

> Avoid try-locking the console from NMI and assume it failed.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  kernel/printk/printk.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 40c5f4170ac7..84af038292d9 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -318,6 +318,10 @@ static int __down_trylock_console_sem(unsigned long ip)
>  	int lock_failed;
>  	unsigned long flags;
>  
> +	/* Semaphores are not NMI-safe. */
> +	if (in_nmi())
> +		return 1;

console_flush_on_panic() ignores the console_trylock() return value:

void console_flush_on_panic(enum con_flush_mode mode)
{
[...]
	/*
	 * If someone else is holding the console lock, trylock will fail
	 * and may_schedule may be set.  Ignore and proceed to unlock so
	 * that messages are flushed out.  As this can be called from any
	 * context and we don't want to get preempted while flushing,
	 * ensure may_schedule is cleared.
	 */
	console_trylock();
	console_may_schedule = 0;
	console_unlock();
}

So that this change would cause a non-paired console_unlock().
And console_unlock might still deadlock on the console_sem->lock.


OK, your change makes sense. But we still should try flushing
the messages in console_flush_on_panic() even in NMI.

One solution would be to call console_flush_all() directly in
console_flush_on_panic() without taking console_lock().
It should not be worse than the current code which ignores
the console_trylock() return value.

Note that it mostly works because console_flush_on_panic() is called
when other CPUs are supposed to be stopped.

We only would need to prevent other CPUs from flushing messages
as well if they were still running by chance. But we actually already
do this, see abandon_console_lock_in_panic(). Well, we should
make sure that the abandon_console_lock_in_panic() check is
done before flushing the first message.

All these changes together would prevent deadlock on console_sem->lock.
But the synchronization "guarantees" should stay the same.

> +
>  	/*
>  	 * Here and in __up_console_sem() we need to be in safe mode,
>  	 * because spindump/WARN/etc from under console ->lock will

Alternative solution would be to make the generic down_trylock() safe
in NMI or in panic(). It might do spin_trylock() when oops_in_progress
is set. I mean to do the same trick and console drivers do with
port->lock.

But I am not sure if other down_trylock() users would be happy with
this change. Yes, it might get solved by introducing down_trylock_panic()
that might be used only in console_flush_on_panic(). But it might
be more hairy than the solution proposed above.

Best Regards,
Petr
