Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972EC61F3E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231374AbiKGNDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKGNDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:03:38 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65CC219C1A
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:03:36 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 12B9F222DD;
        Mon,  7 Nov 2022 13:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1667826215; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5q/uabPGNGovomZktnpmwImg0OhQd/Qp0uAJrETiXJc=;
        b=M1i7mEoU/18mS0lL+S8BygXA5o02V3rafhxILBFibIfKsuEnGD/W7xNmsI/wILUEWMBtLu
        9jOSGcFhn1Lc6NgzQWixTcS4dNKGmsYJCn70vdRl12EBkkGYUJDsJMgZahZUFLnK1/Niz0
        8Og1JwsmjE0J2DwqvPiPa4In63U5OTU=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id B63C22C141;
        Mon,  7 Nov 2022 13:03:34 +0000 (UTC)
Date:   Mon, 7 Nov 2022 14:03:31 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v2 27/38] printk: console_flush_all: use srcu
 console list iterator
Message-ID: <Y2kCI7pAiQBNefgi@alley>
References: <20221019145600.1282823-1-john.ogness@linutronix.de>
 <20221019145600.1282823-28-john.ogness@linutronix.de>
 <Y1f+Izra36qQ4ae6@alley>
 <87a6534osd.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6534osd.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-11-07 01:06:02, John Ogness wrote:
> On 2022-10-25, Petr Mladek <pmladek@suse.com> wrote:
> >>   console_lock()
> >>   | mutex_acquire(&console_lock_dep_map)       <-- console lock
> >>   |
> >>   console_unlock()
> >>   | console_flush_all()
> >>   | | srcu_read_lock(&console_srcu)            <-- srcu lock
> >>   | | console_emit_next_record()
> >>   | | | console_lock_spinning_disable_and_check()
> >>   | | | | srcu_read_unlock(&console_srcu)      <-- srcu unlock
> >>   | | | | mutex_release(&console_lock_dep_map) <-- console unlock
> >>
> >> @@ -2819,12 +2827,17 @@ static bool console_flush_all(bool do_cond_resched, u64 *next_seq, bool *handove
> >>  				/* Extended consoles do not print "dropped messages". */
> >>  				progress = console_emit_next_record(con, &text[0],
> >>  								    &ext_text[0], NULL,
> >> -								    handover);
> >> +								    handover, cookie);
> >>  			} else {
> >>  				progress = console_emit_next_record(con, &text[0],
> >>  								    NULL, &dropped_text[0],
> >> -								    handover);
> >> +								    handover, cookie);
> >>  			}
> >> +
> >> +			/*
> >> +			 * If a handover has occurred, the SRCU read lock
> >> +			 * is already released.
> >> +			 */
> >>  			if (*handover)
> >>  				return false;
> >
> > Please, release the SRCU read lock here:
> >
> > 			if (*handover) {
> > 				console_srcu_read_unlock(cookie);
> > 				return false;
> > 			}
> >
> > The lock should be released in the same function where it was taken.
> > It does not require passing the cookie and looks more straightforward.
> 
> It looks more straight forward, but it is incorrect from a locking
> perspective.
> 
> The locking order was:
> 
> console_lock()
> console_srcu_read_lock()
> 
> But for a handover at this point in code, console_emit_next_record() has
> already released the console_lock (to the spinning context). The
> console_srcu_read_lock should have been released first.

Ah, I see. I should be read all the comments more carefully.
I do not know about any better solution. Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>


Note:

The complexity is caused by calling
mutex_release() in console_lock_spinning_disable_and_check() and
mutex_acquire() in console_trylock_spinning().

I wondered if we really need to do so. These functions actually do not
release or acquire the console_lock. But it seems that it is necessary
because lockdep is not able to track the lock when it was moved into
another process.

I even tried to replace mutex_acquire()/mutex_release() with
rwsem_acquire()/rwsem_release(). But it did not help. lockdep
still complained when I removed these calls from
the _spinning_() API. Sigh.

Best Regards,
Petr
