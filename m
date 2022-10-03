Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1401F5F3208
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiJCOhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiJCOhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:37:15 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF43F4E615
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 07:37:14 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A2FCF1F943;
        Mon,  3 Oct 2022 14:37:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664807833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=866Iu7MyeuktJ5Z7CjLPOTBkI5bOBZ4NyjSvpf9gt8I=;
        b=ImHtmQYT9aF62pJzfIGhhV1Ui67UhBQF+G76a4rqV/gnyCtrvI7yN0V9OMmyIYHfGzUkxU
        Z3PCuA3jfL5ngbOkS1HK8RfcDPN9HjyWiWMsrsdABOEKTFOouoS+7tDvfSP4U9BZEMX14Z
        wTlb60qSYX+Js4QpcZ89oA+47CTfgpk=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4F1252C141;
        Mon,  3 Oct 2022 14:37:13 +0000 (UTC)
Date:   Mon, 3 Oct 2022 16:37:12 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <YzrzmHZYxp8iKEDT@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley>
 <87mtajkqvu.fsf@jogness.linutronix.de>
 <YzW9ExRVjv6PzvWR@alley>
 <Yza1wxVcH2bsITcs@alley>
 <87leq1uev5.fsf@jogness.linutronix.de>
 <YzcvvPargLYDHhgq@alley>
 <87zgeg7gnb.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgeg7gnb.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-09-30 22:32:32, John Ogness wrote:
> On 2022-09-30, Petr Mladek <pmladek@suse.com> wrote:
> > You want to get cosole_lock() out of the way of NOBKL consoles. What
> > does it exactly mean, please?
> 
> It means that a system with only NOBKL consoles will never take the
> console_lock.

What is exactly wrong with console_lock, please?

Is the main problem that it is a semaphore?

Or is it a problem that it is used in some console
drivers for other purposes?

My view:

If you use only NOBLK consoles then you should never take
console_lock via con->write(). Also the printk kthread
main-loop does not need to take console_lock.

If the above is true then console_lock should be needed
only by register_console() and unregister_console(). Anything
else should be doable via srcu_read_lock.

Is it a problem when console_lock is needed in register_console
and unregister_console on RT?


> > What code paths are important to achieve this?
> 
> Anything that iterates or queries the consoles is taking the
> console_lock right now. We want that code to use something else for
> those tasks (console_srcu, console_mutex, atomic_state).

IMHO, console_srcu should be enough for any query.

And even when the write lock was needed from some
reasons why mutex is needed? Is semaphore completely
unacceptable on RT? Do you want to avoid semaphore on RT
at any cost?


> My v2 will hopefully change your POV. I will make it clear (in comments
> and implementation) that the console_lock does _not_ protect the console
> list. All iteration and querying will have no choice but to use the new
> mechanisms for list iteration and checking/setting CON_ENABLED.

Before you spend too much time on it then please try to solve
the problem below.

> Then the console_lock's only function is to block legacy consoles from
> printing and making sure that multiple legacy consoles are not printing
> in parallel. And, of course, it will still function as a general BKL
> lock for fbdev, which may be relying on its locking function to
> synchronize some fbdev data.
> 
> Note that the end result will be no change in behavior for legacy
> consoles. But it allows legacy and NOBKL consoles to run simultaneously
> while sharing significant amounts of code, and provides a clear path for
> console drivers to begin converting. As a side-effect, the first step of
> reducing the scope of the console_lock will have been taken.

OK, there are people that want to disable kthreads by some command line
option. There is a non-trivial possibility that this "feature" will
be there forever.

How exactly do you want to support this legacy mode, please?

The above proposal suggests that it might be something like:

register_console()
{
	console_list_lock();

	if (!need_console())
		goto out;

	if (!try_enable_console())
		goto out;

	if (!(con->flags & CON_NOBLK))
		console_lock()

	add_console_into_the_list();

	if (!(con->flags & CON_NOBLK))
		console_unlock()

out:
	console_list_unlock();
}


vprintk_emit()
{
	vprintk_store();

	wake_up_klogd();

	if (only_noblk_consoles || in_sched)
		return;

	if (console_trylock()) {
		console_flush_all();
		__console_unlock();
}


console_flush_all()
{
	/*
	 * !!! WARNING !!!
	 *  Must take srcu_read_lock(&console_src) here.
	 *  Must never take console_list_lock() here.
	 */
	srcu_read_lock(&console_srcu);

	for_each_console() {
		...
	}

	srcu_read_unlock(&console_srcu);
}

The srcu_read_lock() is needed because NOBKL consoles are
added into the list without console_lock().

There are actually two reasons why we could not take
console_list_lock() in console_flush_all():

    + it is a sleeping lock and vprintk_emit() might
      be called in atomic context

    + it might cause ABBA deadlock with console_lock


IMHO, this is not obvious. The rules for using the three global
locks (console_lock(), console_list_lock(), console_srcu)
look quite complicated to me.

Anyway, are you able to implement vprintk_emit()/console_flush_all()
without console_lock()?

If we need to keep console_trylock() in vprintk_emit() forever
then we really need a good justification why console_list_lock()
is needed.

Please, show me a code path where console_mutex is needed
as the only acceptable solution for RT.

Best Regards,
Petr
