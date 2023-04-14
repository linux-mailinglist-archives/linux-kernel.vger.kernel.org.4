Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53C06E1FFD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjDNJ4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 05:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjDNJ4J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 05:56:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95C95B80
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 02:56:07 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8D40C219CC;
        Fri, 14 Apr 2023 09:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1681466166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=baME+fkiYtclD4GrTUozJgl7rXaCDJmUAFH/P7wuFaM=;
        b=Hq744AnITIofmOnQEurWhB7XqmAnQddMLSqkwmAu2mY18ayhYDCoer3i2E4mtzOYFaNaSh
        tGDNaahl1lbiVAiQlpY4k/W1aCeiJ/Uh9dPEIwfKJdHSghd+jd9JsuLW0S6VFwmWK10FR6
        iEz9Akr2gZTX9cQeBdSHLi16B0RA9Rs=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 2F5102C143;
        Fri, 14 Apr 2023 09:56:06 +0000 (UTC)
Date:   Fri, 14 Apr 2023 11:56:05 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 04/18] printk: Add per-console suspended state
Message-ID: <ZDkjNSTz2yKrm3ad@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-5-john.ogness@linutronix.de>
 <ZAieQtcs7YEuCCDa@alley>
 <87y1nv5x8j.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y1nv5x8j.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-03-17 14:28:04, John Ogness wrote:
> On 2023-03-08, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/include/linux/console.h
> >> +++ b/include/linux/console.h
> >> @@ -153,6 +153,8 @@ static inline int con_debug_leave(void)
> >>   *			receiving the printk spam for obvious reasons.
> >>   * @CON_EXTENDED:	The console supports the extended output format of
> >>   *			/dev/kmesg which requires a larger output buffer.
> >> + * @CON_SUSPENDED:	Indicates if a console is suspended. If true, the
> >> + *			printing callbacks must not be called.
> >>   */
> >>  enum cons_flags {
> >>  	CON_PRINTBUFFER		= BIT(0),
> >> @@ -162,6 +164,7 @@ enum cons_flags {
> >>  	CON_ANYTIME		= BIT(4),
> >>  	CON_BRL			= BIT(5),
> >>  	CON_EXTENDED		= BIT(6),
> >> +	CON_SUSPENDED		= BIT(7),
> >
> > We have to show it in /proc/consoles, see fs/proc/consoles.c.
> 
> Are we supposed to show all flags in /proc/consoles? Currently
> CON_EXTENDED is not shown either.

Good question. It is true that CON_SUSPENDED flag is not that useful.
Userspace will likely be frozen when this flag is set. I am fine
with not showing it.

Well, CON_EXTENDED might actually be useful. It defines the format
of the console messages. It would be nice to fix this but it is
not in the scope of this patchset.

> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2574,11 +2590,26 @@ void suspend_console(void)
> >>  
> >>  void resume_console(void)
> >>  {
> >> +	struct console *con;
> >> +
> >>  	if (!console_suspend_enabled)
> >>  		return;
> >>  	down_console_sem();
> >>  	console_suspended = 0;
> >>  	console_unlock();
> >> +
> >> +	console_list_lock();
> >> +	for_each_console(con)
> >> +		console_srcu_write_flags(con, con->flags & ~CON_SUSPENDED);
> >> +	console_list_unlock();
> >> +
> >> +	/*
> >> +	 * Ensure that all SRCU list walks have completed. All printing
> >> +	 * contexts must be able to see they are no longer suspended so
> >> +	 * that they are guaranteed to wake up and resume printing.
> >> +	 */
> >> +	synchronize_srcu(&console_srcu);
> >> +
> >
> > The setting of the global "console_suspended" and per-console
> > CON_SUSPENDED flag is not synchronized. As a result, they might
> > become inconsistent:
> 
> They do not need to be synchronized and it doesn't matter if they become
> inconsistent. With this patch they are no longer related. One is for
> tracking the state of the console (CON_SUSPENDED), the other is for
> tracking the suspend trick for the console_lock.

OK, the race might be theoretical because it would be a race between
suspend_console() and resume_console(). But it exists:

CPU0					CPU1

suspend_console()

  console_list_lock();
    for_each_console(con)
      con->flags |= CON_SUSPENDED;
  console_list_unlock();

					resume_console()

					  down_console_sem();
					    console_suspended = 0;
					  console_unlock();

					  console_list_lock();
					    for_each_console(con)
					      con->flags &= ~CON_SUSPENDED;
					  console_list_unlock();

  down_console_sem();
    console_supended = 1;
  up_console_sem();

Result:

    console_supended == 1;
    con->flags & CON_SUSPENDED == 0;

    + NO_BKL consoles would work because they ignore console_supend.
    + legacy consoles won't work because console_unlock() would
      return early.

This does not look right.


> > I think that we could just remove the global "console_suspended" flag.
> >
> > IMHO, it used to be needed to avoid moving the global "console_seq" forward
> > when the consoles were suspended. But it is not needed now with the
> > per-console con->seq. console_flush_all() skips consoles when
> > console_is_usable() fails and it bails out when there is no progress.
> 
> The @console_suspended flag is used to allow console_lock/console_unlock
> to be called without triggering printing. This is probably so that vt
> code can make use of the console_lock for its own internal locking, even
> when in a state where ->write() should not be called. I would expect we
> still need it, even if the consoles do not.

But it would still work. console_unlock() could always call
console_flush_all() now. It just does not make any progress
when all consoles have CON_SUSPENDED flag set.

Note that this is a new behavior since the commit a699449bb13b70b8bd
("printk: refactor and rework printing logic"). Before this commit,
the main loop in console_unlock() always incremented console_seq
even when no console was enabled. This is why console_unlock()
had to skip the main loop when the consoles were suspended.

I believe that @console_suspended is not longer needed.
Let's replace it with the per-console flag and do not worry
about races.

Best Regards,
Petr
