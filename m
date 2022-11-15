Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89FB362A146
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231540AbiKOSXV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:23:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbiKOSXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:23:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D842611D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 10:23:18 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 5F67F22C3E;
        Tue, 15 Nov 2022 18:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1668536597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VEevZ2xvthh0GCB0BsTLRUe+NkMpFQAIT+re8AyQH0s=;
        b=WAbnVuRBRXDM+S8JfMKh2iRcBfqQ891a1JQlWTxvfcYSQWB5dzELCj2khhZQ43AGwbjNR4
        T+tY6mc0VzKMxR3izWiDYfiGP3kIzoVMH+M9fF0RdLKy0GXEY/+x+Ek9oznk4kqafzXJ7u
        msR/mQBM4pJ6altUuaOEOoE6i9JDDRk=
Received: from suse.cz (unknown [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 1A5092C142;
        Tue, 15 Nov 2022 18:23:17 +0000 (UTC)
Date:   Tue, 15 Nov 2022 19:23:13 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: replay log: Re: [PATCH printk v4 38/39] printk: relieve
 console_lock of list synchronization duties
Message-ID: <Y3PZEbx+40ZyN/79@alley>
References: <20221114162932.141883-1-john.ogness@linutronix.de>
 <20221114162932.141883-39-john.ogness@linutronix.de>
 <Y3Oxck0/LAHFLYip@alley>
 <87tu30maqf.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tu30maqf.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-11-15 17:47:12, John Ogness wrote:
> On 2022-11-15, Petr Mladek <pmladek@suse.com> wrote:
> > On Mon 2022-11-14 17:35:31, John Ogness wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -3334,6 +3330,11 @@ void register_console(struct console *newcon)
> >>  		 * boot console that is the furthest behind.
> >>  		 */
> >>  		if (bootcon_registered && !keep_bootcon) {
> >> +			/*
> >> +			 * Hold the console_lock to guarantee safe access to
> >> +			 * console->seq.
> >> +			 */
> >> +			console_lock();
> >>  			for_each_console(con) {
> >>  				if ((con->flags & CON_BOOT) &&
> >>  				    (con->flags & CON_ENABLED) &&
> >> @@ -3341,6 +3342,7 @@ void register_console(struct console *newcon)
> >>  					newcon->seq = con->seq;
> >>  				}
> >>  			}
> >> +			console_unlock();
> >
> > Thinking more about it. This console_unlock() will actually cause
> > flushing the boot consoles. A solution would be to call
> > console_flush_all() here.
> 
> console_flush_all() requires the console_lock, so I don't think it would
> be different.

I meant to keep the console_lock(), something like:

		if (bootcon_registered && !keep_bootcon) {
			/*
			 * Hold the console_lock to guarantee safe access to
			 * console->seq.
			 */
			console_lock();
			/* Try to sync all consoles. */
			console_flush_all();
			/* Check if some boot console is still behind. */
			for_each_console(con) {
				if ((con->flags & CON_BOOT) &&
				    (con->flags & CON_ENABLED) &&
				    con->seq < newcon->seq) {
					newcon->seq = con->seq;
				}
			}
			console_unlock();
		}

It is not that easy because console_flush_all() might handover the
console_lock(). Also some new messages might appear so that we
should re-read prb_next_seq().

Maybe, the best solution would be to call pr_flush():

		if (bootcon_registered && !keep_bootcon) {
			/*
			 * Try to sync all consoles because we do not
			 * know which one is going to be replaced
			 */
			pr_flush();
			/*
			 * Hold the console_lock to guarantee safe access to
			 * console->seq.
			 */
			console_lock();
			/* Check if some boot console is still behind. */
			for_each_console(con) {
				if ((con->flags & CON_BOOT) &&
				    (con->flags & CON_ENABLED) &&
				    con->seq < newcon->seq) {
					newcon->seq = con->seq;
				}
			}
			console_unlock();
		}

It was always just the best effort. It does not need to be perfect.
On the other hand, we should not make it much worse because people
report duplicated messages from time to time.

> The correct solution would be to recognize if nextcon is taking over a
> bootcon. If yes, that bootcon could be unregistered right here with
> unregister_console_locked() and then seq for nextcon set appropriately
> to perfectly take over.
> 
> But we will need to think about how we could recognize the same
> device. I was thinking about if consoles hat some attribute showing
> their io-membase or something so that it could be clear that the two are
> the same hardware.

Interesting idea. Well, it is out of scope of this patchset.

Best Regards,
Petr
