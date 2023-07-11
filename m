Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3474F3F4
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 17:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232586AbjGKPoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 11:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231932AbjGKPn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 11:43:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184CC1BE4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 08:43:41 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CCD2E2278D;
        Tue, 11 Jul 2023 15:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1689090219; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D8gS/AatCmSxkrWIi2yEwTN/4nvo6p/jXtb6v9XP55U=;
        b=qwnkeimNpLDCjqlXCrtOCMCENwgeu1LAClk9C8cKCC9YAjpz6dtJcOzHiiK6ijZRGzsUrS
        TKgDQc6qZEbJs/8Q8kPdjm2CKwmARe8A1nhA7CB7uGBpHsx9R8eba55wBX3dRztfpDFNTV
        psR+tPEFkGu39VYPz0YoWDCaODSnpPw=
Received: from suse.cz (pmladek.tcp.ovpn1.nue.suse.de [10.163.16.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 6BF902C142;
        Tue, 11 Jul 2023 15:43:39 +0000 (UTC)
Date:   Tue, 11 Jul 2023 17:43:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 2/5] printk: Add NMI safety to
 console_flush_on_panic() and console_unblank()
Message-ID: <ZK14p-ocWuuHkSAQ@alley>
References: <20230710134524.25232-1-john.ogness@linutronix.de>
 <20230710134524.25232-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710134524.25232-3-john.ogness@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2023-07-10 15:51:21, John Ogness wrote:
> The printk path is NMI safe because it only adds content to the
> buffer and then triggers the delayed output via irq_work. If the
> console is flushed or unblanked on panic (from NMI context) then it
> can deadlock in down_trylock_console_sem() because the semaphore is
> not NMI safe.

<thinking loudly>

Just to be sure. The semaphore is not NMI safe because even the
trylock takes an internal spin lock. Am I right, please?

Alternative solution would be to make down_trylock() NMI safe
by using raw_spin_trylock_irqsave() for the internal lock.

But this actually would not solve the whole problem. If the NMI safe
down_trylock() succeeded then up() would need to be called
in NMI as well. And up() really needs to take the spin lock
which might get blocked in the meantime.


Another question is whether we want to call c->unblank()
in NMI even when down_trylock() was NMI safe. It seems that it
is implemented only for struct console vt_console_driver.
I am pretty sure that it takes more internal locks which
are not NMI safe either.

On the other hand, if we would risk calling c->write() then
we might risk calling c->unblank() either.


Finally, it is not only about NMI. Any locks might cause a deadlock
in panic() in any context. It is because other CPUs are stopped
and might block some locks.

</thinking loudly>


In my opinion, we should handle c->unblank() in panic() the same way
as c->write() in panic().

I suggest to create

void __console_unblank(void)
{
	struct console *c;
	int cookie;

	cookie = console_srcu_read_lock();
	for_each_console_srcu(c) {
		if ((console_srcu_read_flags(c) & CON_ENABLED) && c->unblank)
			c->unblank();
	}
	console_srcu_read_unlock(cookie);
}

and call this in console_flush_on_panic() without the console_lock().

We still need to take the lock during Oops when the system tries
to continue. In this case, the NMI check makes perfect sense.
NMI might cause a deadlock. Other contexts should be safe
because the CPUs are not stopped.


> Avoid taking the console lock when flushing in panic. To prevent
> other CPUs from taking the console lock while flushing, have
> console_lock() block and console_trylock() fail for non-panic CPUs
> during panic.

I really like the trick that console_lock() and console_trylock()
would start failing on non-panic CPUs. It should prevent races
when the other CPUs were not stopped for some reasons.

I am still slightly afraid to do this even before stopping other CPUs.
But I do not have any real scenario where it might be a problem.
And it is only about console_lock() which should preferably be
available for the panic-CPU. Also we should _not_ rely on the other
CPUs during panic() anyway. So, it should be fine after all.


Well, would you mind to split this into two patches?

1st patch would split __console_unblank(), call it from
	console_flush_on_panic() after the trylock().

	Also it would add the NMI check into the original
	console_unblank() which would still be called in
	bust_spinlocks().

	The commit message should explain the motivation
	(primary the internal spinlock in the semaphore
	implementation). Also it should explain why only NMI
	is a problem when called in the Oops path.
	And why the locks are problem in any context
	when called in panic() after CPUs were stopped.


2nd patch would prevent taking console_lock on non-panic CPUs.
	And it would remove console_trylock()/console_unlock() from
	console_flush_on_panic().

	The commit message should explain the motivation
	(the internal spinlock in the semaphore code).
	Also it would solve a problem with a potential
	double unlock. And it should mention that it should
	not be worse then before when the trylock() result
	was ignored.

IMHO, both patches has a potential to cause regressions.
And it is better to do it in smaller steps.

Best Regards,
Petr
