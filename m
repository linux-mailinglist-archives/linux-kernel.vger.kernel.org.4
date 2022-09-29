Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0572F5EF959
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 17:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236003AbiI2Pom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 11:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235731AbiI2PoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 11:44:13 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570471BB23C
        for <linux-kernel@vger.kernel.org>; Thu, 29 Sep 2022 08:43:18 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8670721905;
        Thu, 29 Sep 2022 15:43:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1664466196; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zAcEDAeXByKAJJXb2Hk5mUl7jEDvdCepq+Gn9p2xl/A=;
        b=ivB8DCvTah53CyexdRyV+LMZXNXZxkigoTAJzwuISaWXWL5llmLSefpYy2QdF4QmikzsUJ
        r/BjX9Rwk8P1aQhGc5bBOdAySNAipqeQDT+rssG5P9yvYdt3GyrNMHn81lZ+D6JJ0HXNHf
        3M3lDb82adqCVtrhQXwepAJnw8JkDdw=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 341DE2C14E;
        Thu, 29 Sep 2022 15:43:16 +0000 (UTC)
Date:   Thu, 29 Sep 2022 17:43:15 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk 06/18] printk: Protect [un]register_console() with
 a mutex
Message-ID: <YzW9ExRVjv6PzvWR@alley>
References: <20220924000454.3319186-1-john.ogness@linutronix.de>
 <20220924000454.3319186-7-john.ogness@linutronix.de>
 <YzMT27FVllY3u05k@alley>
 <87mtajkqvu.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mtajkqvu.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-09-29 01:48:29, John Ogness wrote:
> On 2022-09-27, Petr Mladek <pmladek@suse.com> wrote:
> > Hmm, the new mutex is really nasty. It has very strange semantic.
> > It makes the locking even more complicated.
> 
> We are working to replace the BKL-console_lock with new separate clearly
> defined mechanisms.
>
> The new mutex provides full synchronization for list changes as well as
> changes to items of that list. (Really console->flags is the only change
> to items of the list.)

OK.


> For some places in the code it is very clear that the console_lock can
> be completely replaced (either with srcu or the new mutex). For other
> places, it is not yet clear why the console_lock is being used and so
> both console_lock and mutex are used.

One important and tricky location is console_trylock() in
vprintk_emit(). And the related for_each_console() called from
console_unlock()->console_flush_all().

It is the legacy mode that tries to print to the consoles immediately.
I am not sure if we could _ever_ remove this mode.

And it is most likely the main reason why semaphore is used instead
of a mutex:

    + printk() can be called in atomic context

    + also there is the console_trylock_spinning() trick that allows
      to transfer the semaphore to another owner without locking.


Do you see any RT-friendly solution for the legacy mode, please?

Maybe, an atomic variable (cmpxchg) can be used together with
the SRCU list. But I am not sure if srcu_read_lock can be
transferred to another context. Also this would not solve priority
inversion. Not to say that it might kill SRCU performance on
the entire system.


> > The ideal solution would be take console_lock() here.
>
> We should be looking where we can remove console_lock, not identifying
> new locations to add it.

Yes, we do not want this big kernel lock. Honestly, I am not
completely sure what is the exact purpose. My guess is that
console_lock() is used to prevent calling con->write() when
some internal console driver state is manipulated.

If the above is true then it might be solvable by some
driver-specific lock. The question is where the lock should
be. It is possible that it might require adding
the lock into struct console.

Anyway, some lock will still be needed to synchronize the list.
But could it be mutex? What about the legacy mode of printk_emit()?

> > A good enough solution might be call this under the later added
> > srcu_read_lock(&console_srcu) and use for_each_console_srcu().
> 
> @console_srcu does not allow safe reading of console->flags. It only
> provides safe list iteration and reading of immutable fields. The new
> mutex must be used for reading console->flags.
> 
> Note that for the NOBKL consoles (not part of this series), a new atomic
> state variable is used so that console->flags is not needed. That means
> for NOBKL consoles the new mutex is further reduced in scope to provide
> only list synchronization.

Good to know.

> > Or is this part of some strategy to remove console_sem later, please?
> 
> Yes! One of the main points of this final phase of the rework is to
> remove console_sem usage (for NOBKL consoles). If a system is running
> with only NOBKL consoles registered, ideally that system should never
> call console_lock()/console_trylock(). Once all drivers have converted
> over to the NOBKL interface, console_sem will serve no purpose for the
> printk and console frameworks, so it can be removed.

Is this realistic?

And even if we convert all console drivers then people still might
want the legacy mode.

My understanding is that some atomic consoles would be real hacks.
They might be good enough for panic(). But what about running system.
It seems that people might want the legacy more even on running
system. Will it be doable with mutex?


I am sorry. I was about to answer this mail with "fair enough". But
then I thought more about it...

I would really like to avoid state where we have two locks (semaphore
and mutex) serializing the same thing (console list).

Best Regards,
Petr
