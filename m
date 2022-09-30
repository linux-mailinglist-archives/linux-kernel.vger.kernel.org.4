Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3D15F1153
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 20:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbiI3SFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 14:05:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231817AbiI3SE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 14:04:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2552E3B718
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 11:04:49 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0E7A8218A8;
        Fri, 30 Sep 2022 18:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664561088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VY+CGNq75eXMTzG8QjYZs4jrMV1oGOoUUANHZTEjaTA=;
        b=qc3H+b+RQjR8vPulEcDK8Z7+s7Gj2KfiYnKC86MR1h8tyXc7LuhF3BHyg/0CFnHhvgKdCb
        0UtOX6li4tpIfAsJuoB/9IteALHJ+Thl2XU7oyeoxrmuJTzughIy3lJySu7iiswOkr4286
        JNH+lZvyyUFYheS2NpBl5Ppeah8nT/M=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B3F8E2C161;
        Fri, 30 Sep 2022 18:04:47 +0000 (UTC)
Date:   Fri, 30 Sep 2022 20:04:44 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <YzcvvPargLYDHhgq@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley>
 <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley>
 <Yza1wxVcH2bsITcs@alley>
 <87leq1uev5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87leq1uev5.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-09-30 16:22:30, John Ogness wrote:
> On 2022-09-30, Petr Mladek <pmladek@suse.com> wrote:
> > You know, the more locks we have, the bigger is the risk of
> > deadlocks, and the more hacks would be needed in
> > console_flush_on_panic(). And I am afraid
> > that console_lock() will be with us for many years and
> > maybe forever.
> 
> Sure. Removing console_lock() will be a long battle involving many
> drivers. I am not trying to fight that battle right now. I just want
> console_lock() out of the way of NOBKL consoles.

There is some misunderstanding. I am going to think more about your
arguments over the weekend.

But maybe, the above is important. You want to get cosole_lock() out
of the way of NOBLK consoles. What does it exactly mean, please?
What code paths are important to achieve this?

From my POV, the most important code path is the kthread. But it
should use SRCU. I mean that the kthread will take neither
cosnole_lock() nor console_list_lock().

Is there any other code path where console_list_lock() will help
you to get console_lock() out of the way?


From my POV, the proposed code does:

register_console()
{
	console_list_lock();
	console_lock();

	/* manipulate struct console and the console_list */

	console_unlock();
	console_list_unlock();
}

register_console()
{
	console_list_lock();
	console_lock();

	/* manipulate struct console and the console_list */

	console_unlock();
	console_list_unlock();
}

printk_kthread()
{
	while() {
		srcu_read_lock();

		if (read_flags_srcu())
		     /* print line */

		srcu_read_unlock();
	}
}

vprintk_emit()
{
	/* store message */

	if (do_not_allow_sync_mode)
		return;

	if (console_trylock()) {
		console_flush_all();
		__console_unlock();
	}
}

some_other_func()
{
	console_list_lock();
	/* do something with all registered consoles */
	console_list_unlock();
}

console_flush_all()
{
	do_something_with_all_consoles();
	do_something_else_with_all_consoles();
}

What if?

do_something_with_all_consoles()
{
	console_list_lock();
	/* do something */
	console_list_unlock();
}

Wait, there is a possible ABBA deadlock because
do_something_with_all_consoles() takes console_list_lock()
under console_lock(). And register_console() does it
the other way around.

But it is less obvious because these are different locks.

From my POV, both locks serialize the same things
(console_list manipulation). SRCU walk should be
enough for most iterations over the list.

And I do not see which code path would really benefit from
having the new console_list_lock() instead of console_lock().

Best Regards,
Petr
