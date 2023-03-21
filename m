Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65A66C35CF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCUPg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbjCUPg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:36:57 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F072200D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:36:54 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 195FE201C5;
        Tue, 21 Mar 2023 15:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1679413013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8GR3nqVPTvIIUemQinUM3ZRWVv3nUcZCac4iLqxkiYA=;
        b=Avdna0atBakXPjFjYggo5LoWoSf6DOuF45QWLuNb6ViEM6ZM89nQsnHxlI2Zunf128fqn9
        ZuwEPZcQA/jTnnJ2HJYIxbyOdoigfnnusCoFmzoQuURX1ESsxhXE/RhB3jMNwMJJWGwNOS
        d8jdPtYdVctX6h9LkkfoD27qvgdGIkQ=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id ABCDC2C141;
        Tue, 21 Mar 2023 15:36:52 +0000 (UTC)
Date:   Tue, 21 Mar 2023 16:36:49 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: simplify: was: Re: [PATCH printk v1 06/18] printk: nobkl: Add
 acquire/release logic
Message-ID: <ZBnPEaJKdHyTtUNS@alley>
References: <20230302195618.156940-1-john.ogness@linutronix.de>
 <20230302195618.156940-7-john.ogness@linutronix.de>
 <ZBSkoKCdG5uiVNPq@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBSkoKCdG5uiVNPq@alley>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2023-03-17 18:34:30, Petr Mladek wrote:
> Hi,
> 
> I send this before reading today's answers about the basic rules.
> 
> I have spent on this answer few days and I do not want to delay
> it indefinitely. It documents my initial feelings about the code.
> Also it describes some ideas that might or need not be useful
> anyway.
> 
> Also there is a POC that slightly modifies the logic. But the basic
> approach remains the same.

I looked at this with a "fresh" mind. I though if there was any real
advantage in the proposed change of the cons_release() logic. I mean
to just clear .cpu and .cur_prio and let cons_try_acquire() to take
over the lock.

I tried to describe my view below.

> > +/**
> > + * __cons_release - Release the console after output is done
> > + * @ctxt:	The acquire context that contains the state
> > + *		at cons_try_acquire()
> > + *
> > + * Returns:	True if the release was regular
> > + *
> > + *		False if the console is in unusable state or was handed over
> > + *		with handshake or taken	over hostile without handshake.
> > + *
> > + * The return value tells the caller whether it needs to evaluate further
> > + * printing.
> > + */
> > +static bool __cons_release(struct cons_context *ctxt)
> > +{
> > +	struct console *con = ctxt->console;
> > +	short flags = console_srcu_read_flags(con);
> > +	struct cons_state hstate;
> > +	struct cons_state old;
> > +	struct cons_state new;
> > +
> > +	if (WARN_ON_ONCE(!(flags & CON_NO_BKL)))
> > +		return false;
> > +
> > +	cons_state_read(con, CON_STATE_CUR, &old);
> > +again:
> > +	if (!cons_state_bits_match(old, ctxt->state))
> > +		return false;
> > +
> > +	/* Release it directly when no handover request is pending. */
> > +	if (!old.req_prio)
> > +		goto unlock;
> > +
> > +	/* Read the handover target state */
> > +	cons_state_read(con, CON_STATE_REQ, &hstate);
> > +
> > +	/* If the waiter gave up hstate is 0 */
> > +	if (!hstate.atom)
> > +		goto unlock;
> > +
> > +	/*
> > +	 * If a higher priority waiter raced against a lower priority
> > +	 * waiter then unlock instead of handing over to either. The
> > +	 * higher priority waiter will notice the updated state and
> > +	 * retry.
> > +	 */
> > +	if (hstate.cur_prio != old.req_prio)
> > +		goto unlock;

The above check might cause that CUR will be completely unlocked
even when there is a request. It is a corner case. It would happen
when a higher priority context is in the middle of over-ridding
an older request (already took REQ but have not updated
CUR.req_prio yet).

As a result any context might take CUR while the higher priority
context is re-starting the request and tries to get the lock with
the updated CUR.

It is a bit pity but it is not end of the world. The higher priority
context would just need to wait for another context.

That said, my proposal would solve this a bit cleaner way.
CUR would stay blocked for the .req_prio context. As a result,
the being-overridden REQ owner would become CUR owner.
And the higher priority context would then need to setup
new REQ against the previous REQ owner.

> > +
> > +	/* Switch the state and preserve the sequence on 64bit */
> > +	copy_bit_state(new, hstate);
> > +	copy_seq_state64(new, old);
> > +	if (!cons_state_try_cmpxchg(con, CON_STATE_CUR, &old, &new))
> > +		goto again;

The other difference is that the above code will do just half of
the request-related manipulation. It will assing CUR to the REQ owner.
The REQ owner will need to realize that it got the lock and
clean up REQ part.

Or by other words, there are 3 pieces of information:

   + CUR owner is defined by CUR.cpu and CUR.cur_prio
   + REQ owner is defined by REQ.cpu and REQ.cur_prio
   + CUR knows about the request by CUR.req_prio

The current code modifies the pieces in thie order:

CPU0				CPU1

// take a free lock
set CUR.cpu
set CUR.cur_prio

				// set request
				set REQ.cpu
				set REQ.cur_prio

				// notify CUR
				set CUR.req_prio

// re-assign the lock to CPU1
set CUR.cpu = REQ.cpu
set CUR.cur_prio = REQ.cur_prio
set CUR.req_prio = 0

				// clean REQ
				REQ.cpu =0;
				REQ.cur_prio = 0;


In this case, CPU0 has to read REQ and does a job for CPU1.

Instead, my proposal does:

CPU0				CPU1

// take a free lock
set CUR.cpu
set cur.prio

				// set request
				set REQ.cpu
				set REQ,cur_prio

				// notify CUR
				set CUR.req_prio

// unlock CPU0
set CUR.cpu = 0
set CUR.cur_prio = 0;
keep CUR.req_prio == REQ.cur_prio

				// take the lock and clean notification
				set CUR.cpu = REQ.cpu
				set CUR.cur_prio = REQ.cur_prio
				set CUR.req_prio = 0

				// clean REQ
				REQ.cpu =0;
				REQ.cur_prio = 0;


In this case:

   + CPU0: It manipulates only CUR. And it keeps CUR.req_prio value.
	   It does not check REQ at all.

   + CPU1: Manipulates all REQ-related variables and fields.
	   It modifies SEQ.cpu and SEQ.cur_prio only when
	   they are free.

It looks a bit cleaner. Also it might help to think about barriers
because each side touches only its variables and fields. We might
need less explicit barriers that might be needed when one CPU
does a change for the other.


My view:

I would prefer to do the logic change. It might help with review
and also with the long term maintenance.

But I am not 100% sure if it is worth it. The original approach might
be good enough. The important thing is that it modifies CUR and REQ
variables and fields in the right order. And I do not see any
chicken-and-egg problems. Also the barriers should be doable.

Best Regards,
Petr
