Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658706D9134
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235984AbjDFIJN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:09:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235821AbjDFIJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:09:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37CEBE4A
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:09:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E791C1F895;
        Thu,  6 Apr 2023 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1680768545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1SnxkeA60Ry/X3tkNOJRB22ifyITS+wV4tC8bip0D9k=;
        b=a/xUsI8Ry4/gk3UfhbKu9P137SDpbSi724ZjUSp+Mv725/yr/jGY9yHpOX7TRKCOLFTRHQ
        79w8O7FbUJjdO5m2xIHsgR8pT+HSPU4jojMWllIdB1xIi5i4iCsbHYlrTChSwqdn9ExYXq
        J6B3KoJlrp5nFSa+dwrnoPCNaRV0YoE=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 86E062C141;
        Thu,  6 Apr 2023 08:09:05 +0000 (UTC)
Date:   Thu, 6 Apr 2023 10:09:02 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: wakeup synchronization: was: Re: [PATCH printk v1 11/18] printk:
 nobkl: Introduce printer threads
Message-ID: <ZC5+Hn0bOhMrVci6@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-12-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230302195618.156940-12-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-03-02 21:02:11, John Ogness wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Add the infrastructure to create a printer thread per console along
> with the required thread function, which is takeover/handover aware.
>
> --- a/kernel/printk/printk_nobkl.c
> +++ b/kernel/printk/printk_nobkl.c
> +/**
> + * cons_kthread_func - The printk thread function
> + * @__console:	Console to operate on
> + */
> +static int cons_kthread_func(void *__console)
> +{
> +	struct console *con = __console;
> +	struct cons_write_context wctxt = {
> +		.ctxt.console	= con,
> +		.ctxt.prio	= CONS_PRIO_NORMAL,
> +		.ctxt.thread	= 1,
> +	};
> +	struct cons_context *ctxt = &ACCESS_PRIVATE(&wctxt, ctxt);
> +	unsigned long flags;
> +	short con_flags;
> +	bool backlog;
> +	int cookie;
> +	int ret;
> +
> +	for (;;) {
> +		atomic_inc(&con->kthread_waiting);

Sigh, I really have hard times to scratch my head around the barriers
here. This part looks fine. The rcuwait_wait_event() provides full
barrier before checking the "condition".

But I am not sure about the counter part. It is in another patch.
IMHO, there should be a full barrier before checking
con->kthread_waiting. Something like this:

+  void cons_wake_threads(void)
+ {
+ 	struct console *con;
+ 	int cookie;
+

	/*
	 * Full barrier against rcuwait_wait_event() in	cons_kthread_func().
	 *
	 * The purpose of this barrier is to make sure that the new record is
	 * stored before checking con->kthread_waiting.
	 *
	 * It has the same purpose as the full barrier in rcuwait_wake_up().
	 * It makes sure that cons_kthread_should_wakeup() see the new record
	 * before going into sleep in rcuwait_wait_event().
	 *
	 * The extra barrier is needed here because rcuwait_wake_up() is called
	 * only when we see con->kthread_waiting set. We need to make sure
	 * that either we see con->kthread_waiting or cons_kthread_func()
	 * will see the new record when checking the condition in
	 * rcuwait_wait_event().
	 */
	smp_mb();

+ 	cookie = console_srcu_read_lock();
+ 	for_each_console_srcu(con) {
+ 		if (con->kthread && atomic_read(&con->kthread_waiting))
+ 			irq_work_queue(&con->irq_work);
+ 	}
+ 	console_srcu_read_unlock(cookie);
+ }

I think that I am right. But I am not in a good "see-barriers" mood so
I also might be wrong.

> +
> +		/*
> +		 * Provides a full memory barrier vs. cons_kthread_wake().
> +		 */
> +		ret = rcuwait_wait_event(&con->rcuwait,
> +					 cons_kthread_should_wakeup(con, ctxt),
> +					 TASK_INTERRUPTIBLE);

I am sorry but I would need some explanation for this. I am not
familiar with the rcuwait API. I looked at the code, commit messages,
and various users, and I am still not sure.

My assumption is that this allows to wait for an event on "con"
when the lifetime of this structure is synchronized using SRCU.
The counter-part calls rcuwait_wake_up() under srcu_read_lock().

I am afraid that it it is more complicated in our case.
We do not call rcuwait_wake_up() under srcu_read_lock().
We call it from an irq_work() that might be proceed later
after srcu_read_unlock().

IMHO, we need to make sure that there is no pending irq_work
and nobody could create a new one after exit from
unregister_console(). There seems to be irq_work_sync()
for this purpose.

> +
> +		atomic_dec(&con->kthread_waiting);
> +
> +		if (kthread_should_stop())
> +			break;
> +
> +		/* Wait was interrupted by a spurious signal, go back to sleep */
> +		if (ret)
> +			continue;
> +
> +		for (;;) {
[...]
> +
> +			if (console_is_usable(con, con_flags)) {
> +				/*
> +				 * If the emit fails, this context is no
> +				 * longer the owner. Abort the processing and
> +				 * wait for new records to print.
> +				 */
> +				if (!cons_emit_record(&wctxt))
> +					break;
> +
> +				backlog = ctxt->backlog;
> +			} else {
> +				backlog = false;
> +			}
[...]
> +	}
> +	return 0;
> +}
> +

Best Regards,
Petr
