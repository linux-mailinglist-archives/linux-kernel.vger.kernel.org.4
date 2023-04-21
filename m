Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E1A6EAEE3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 18:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbjDUQPb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 12:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbjDUQP3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 12:15:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D93BB19B6
        for <linux-kernel@vger.kernel.org>; Fri, 21 Apr 2023 09:15:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 844C421A4E;
        Fri, 21 Apr 2023 16:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1682093726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AwF3d3ZNKKYJ/ZXOzikimHY4xWkQNJAaMDbXHQeEkp8=;
        b=He0o2Y0sS0ygDdSIMnnUAsLNV9RleANDBBPQ/ylIDNPuS1YCMJFzp+giaO15jxFp04tSIT
        bJC2oZpBatRUUhK7Cod1Ry1O0cIk4765EJaU8L6wNIY2AkNGxUk8g4D7lB5fjdccqRs3qk
        gDWffqjAZdLV4zbMlaTTlfy0wTz65NU=
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 157212C145;
        Fri, 21 Apr 2023 16:15:26 +0000 (UTC)
Date:   Fri, 21 Apr 2023 18:15:22 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: port lock: was: Re: [PATCH printk v1 11/18] printk: nobkl:
 Introduce printer threads
Message-ID: <ZEK2mu9ikDhDeVvu@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-12-john.ogness@linutronix.de>
 <ZC6U/CZCNmgnTpI4@alley>
 <ZEEMJxobFe_UZ8gV@alley>
 <87zg72vo5g.fsf@jogness.linutronix.de>
 <ZEE_ERSc_jHaVVe9@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZEE_ERSc_jHaVVe9@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2023-04-20 15:33:10, Petr Mladek wrote:
> On Thu 2023-04-20 12:39:31, John Ogness wrote:
> I know. And the hostile takeover is not my concern.
> 
> My concern are races between write_atomic() in emergency context
> and other driver code serialized only by the port->lock.
> 
> We need an API that will make sure that any code serialized
> by port->lock is properly serialized against write->atomic()
> when the console is registered.

I though more about it. My idea is the following:

A. The nbcon side might have basically four modes
   for taking the new nbcon lock. It might have four interfaces:

    nbcon_trylock(struct console *con,
		  enum cons_prio prio);
    nbcon_trylock_emergency(struct console *con,
		  enum cons_prio prio);
    nbcon_trylock_panic(struct console *con,
		  enum cons_prio prio);
    nbcon_lock(struct console *con,
		  enum cons_prio prio);

, where

   + nbcon_trylock() would use the current approach for
     the printk kthread. It means that it would try to get
     the lock with a timeout. But it would never try to
     steel the lock.

   + nbcon_trylock_emergency() would use the current approach
     used in emergency context. It would busy wait and
     then try to steel the lock. But it would take over the lock
     only when it is in safe context.

    + nbcon_trylock_panic() would behave the same way as
      nbcon_trylock_emergency(). But it would allow to
      take over the lock even when it is unsafe. It might
      still fail when it is not called on the CPU that
      handles the panic().

    + nbcon_lock() would wait until the lock is really
      available.

  and

  enum cons_prio would be one of the four priorities.

  The API should disable cpu migration to make sure that
  it will stay the same until the lock is released.

  The caller should rememner the priority somewhere,
  e,g. in struct cons_ctxt.


B. The port->lock side would switch to the new nbcon lock
   when the console is registered. There are two big questions
   that come to my mind:

  1. The original code does not expect that it might lose
     the lock.

     It should be enough to mark the entire section .unsafe.
     In that case, only the final panic() call might steel
     the lock.


  2. The console registration must be done a safe way
     to make sure that all callers will use the same
     real lock (port->lock or nbcon_lock).


  IMHO, the uart_port part might look like:

void uart_port_lock_irqsafe(struct uart_port *port,
	int *cookie,
	unsigned long &flags)
{
	struct console *con;

try_again:
	/* Synchrnonization against console registration. */
	*cookie = console_srcu_read_lock();

	con = rcu_access_pointer(nbcon->cons);

	if (!can_use_nbcon_lock(con)) {
		/* Only the port lock is available. */
		spin_lock_irqsafe(&port->lock, *flags);
		port->locked = LOCKED_BY_PORT_LOCK;
		return;
	}


	/*
	 * The nbcon lock is available. Take it instead of
	 * the port->lock. The only exception is when
	 * there is registration in progress. In this case,
	 * port->lock has to be taken as well.
	 *
	 * It will always be taken only with the normal priority.
	 * when called from the port lock side.
	 */
	nbcon_lock(con, CON_PRIO_NORMAL);
	local_irq_save(*flags);

	if (cons->registration_in_progress) {
		spin_lock(&port->lock);
		port->locked = LOCKED_BY_BOTH_LOCKS;
	} else {
		port->locked = LOCKED_BY_NBCON_LOCK;
	}

	/*
	 * Makes sure that only nbcon_lock_panic() would
	 * be able to steel this lock.
	 */
	if (!nbcon_enter_unsafe(con, CON_PRIO_NORMAL)) {
		revert locks;
		goto try_again;
	}
}

void uart_port_unlock_irqrestore(struct uart_port *port,
	int *cookie, unsigned long *flags)
{
	struct console *con;

	con = rcu_access_pointer(nbcon->cons);

	switch (port->locked) {
	LOCKED_BY_PORT_LOCK:
		spin_unlock_irqrestore(&port->lock, *flags);
		break;
	LOCKED_BY_BOTH_LOCKS:
		spin_unlock(&port->lock);
		fallthrough;
	LOCKED_BY_NBCON_LOCK:
		nbcon_exit_unsafe(con, CON_PRIO_NORMAL);
		local_irq_restore(*flags);
		nbcon_unlock(con, CON_PRIO_NORMAL);
	};

	console_srcu_unlock(*cookie);
}


and finally the registration:

void register_console(struct console *newcon)
{
[...]
	if (con->flags & CON_NBCON) {
		nbcon_lock(con);
		nbcon->regisration_in_progress = true;
		nbcon_unlock(con);

		/*
		 * Make sure that callers are locked by both
		 * nbcon_lock() and port->lock()
		 */
		synchronize_srcu();
	}

	/* Insert the console into console_list */

	if (con->flags & CON_NBCON) {
		nbcon_lock(con);
		nbcon->regisration_in_progress = false;
		nbcon_unlock(con);
	}
[...]
}

and similar thing in uregister_console().

I am not sure if I should send this on Friday evening. But I reworked
it many times and I do not longer see any obvious reason why it
could not work.

My relief is that it builds on top of your code. It basically just
adds the port_lock interface. I hope that it would actually simplify
things a lot.

Well, a huge challenge might be to replace all spin_lock(port->lock)
calls with the new API. There is a lot of code shared between various
consoles and we wanted to migrate them one-by-one.

On the other hand, the new port_lock() API should behave as simple
spin lock when port->cons is a legacy console.

Best Regards,
Petr
